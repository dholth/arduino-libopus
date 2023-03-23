"""Play an Opus file through an I2S DAC connected to D4, D5, D6."""

from machine import I2S, Pin
import oggz

opus = oggz.oggz(open("nyan30.opus", "rb"))

WAV_SAMPLE_SIZE_IN_BITS = 16
FORMAT = I2S.STEREO
SAMPLE_RATE_IN_HZ = 48000
BUFFER_LENGTH_IN_BYTES = 960*4

# in circuitpython:
# audio = audiobusio.I2SOut(board.D4, board.D5, board.D6)
# D4 = clock, D5 = word clock, D6 = data
# from pins.c:
# D4 = GPIO6
# D5 = GPIO7
# D6 = GPIO0 # zero?

SCK_PIN = 6
WS_PIN = 7
SD_PIN = 0

audio_out = I2S(
    0,
    sck=Pin(SCK_PIN),
    ws=Pin(WS_PIN),
    sd=Pin(SD_PIN),
    mode=I2S.TX,
    bits=WAV_SAMPLE_SIZE_IN_BITS,
    format=FORMAT,
    rate=SAMPLE_RATE_IN_HZ,
    ibuf=BUFFER_LENGTH_IN_BYTES,
)

# a common opus frame size
buf0 = memoryview(bytearray(BUFFER_LENGTH_IN_BYTES))

def more_opus(buf):
    samples = 0
    while samples <= 0:
        # print(opus.decode_opus(buf))
        content_type, samples, bytes_read = opus.decode_opus(buf)
        print(content_type, samples, bytes_read)
        if bytes_read == 0 and samples == 0:
            raise Exception("End of file %s %s %s" % (content_type, samples, bytes_read))
    return samples

while True:
    more_opus(buf0)
    audio_out.write(buf0)

print("Done playing!")


