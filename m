Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622203;
	b=xUlWiYNMyQooPCi+PXufzFws8E07dVkbDQJtmshuYLQIv/l/OKEOyaAfXNLPvFUMVa+R
	 uFanb1EdYoefi2hS/5W3ic9VFZpCa0s1NGxSGBP6ecKjobuk9efESw0+K8+swZMpted1H
	 sofAZhea33VJegiqZV7YENjJr4mMMssOVe8edIG4FuoSMtuwozs984yTrRAC07o0b3t6d
	 yL3WPd6etqsmVIB+UD/uTYn3slOIw+cmcU3gJWO6SNDYDp8BAvEIOtUjTOZUuUDXENJjE
	 ABTMHa3Z0KsGx2L/3tNgqCFY4yqeucWgpZwjQV2qdWyXuj+2Oho0oayPR74SV2OWQBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O/uFUkzDqCwgWY62KgTbVh6URBIkDoEOCWHHjbQ4zUE=;
	b=V1rbbS6yKtdv+DAuk2PzQhMYLQtUi5nahbuseS5dBFzGEe73CzKk4dWVAzjivlKQcZA4
	 whrWpugp5ZOLkz+kC9agcFrpaOUgQQgv22pjrzOC+2WCxmlbxyGZ0shKWLSaWDZCVwiSD
	 x5AF9GZi9ueMF2jsBgU1Z/PNsS2WqqdyqiHx/vVPW7BSXQhnA4hDooShnp48bVEsqQ02c
	 kBDjqlTvGUqryTRY6slJfDOrogTqjWr7+hMNfdJfDsNbjewckXMExZFRlLldlD1Pwqv7i
	 rqw1iImNtnNS0e2kU4MVoc63wC5TK4SOxL+rF/H36i+PJzQ3sEw0H3vuOTISXd10lwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+M23Miy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FD606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+M23Miy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A2F1F000C2;
	Wed, 21 Oct 2026 22:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622202;
	bh=O/uFUkzDqCwgWY62KgTbVh6URBIkDoEOCWHHjbQ4zUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q+M23Miy0/nbXjglVbiJAHuycjO08k7JP5gKL/Eobb1i3bEMVRrO53ke8GXhkXfdi
	 IiGUaigAu67M531r5ZJ7JAAkX0pPsC0JYX178oph42xi8C6z3HHXIrduHo5EGzTfTK
	 1wwt/MNfPE58uWcqpRLc8PnBEFzjGlq6HF6g2zv9OvpAVORCdUiOTL8b+cFQTxRq4k
	 F6prr3Il7fY/V7yfJvm6PKLU5TSBB63gYM0x573JvU2HSR/TkBmeCG2ikomvyCGpp3
	 GDha6IndHUusb7Cv+KPCgzneua86mgVMU/ZK0rosj+FDI2qMDTv+jEsqt0GLwQPuMP
	 86w//NdWqFWCA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 11/12] tools headers: Sync UAPI sound/asound.h with kernel sources
Date: Wed, 21 Oct 2026 19:35:50 -0300
Message-ID: <20261021223555.28372-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021223555.28372-1-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  91415225fbfb ("ALSA: uapi: Drop __bitwise and __force prefix")
  86cac980c966 ("ALSA: control: add ioctl to retrieve full card components")

That introduce these new entries in the string tables:

  $ tools/perf/trace/beauty/sndrv_ctl_ioctl.sh tools/perf/trace/beauty/include/uapi/sound/ > before.txt
  $ cp include/uapi/sound/asound.h tools/perf/trace/beauty/include/uapi/sound/asound.h
  $ tools/perf/trace/beauty/sndrv_ctl_ioctl.sh tools/perf/trace/beauty/include/uapi/sound/ > after.txt
  $ diff -u before.txt after.txt

  @@ -1,6 +1,7 @@
   static const char *sndrv_ctl_ioctl_cmds[] = {
   	[0x00] = "PVERSION",
   	[0x01] = "CARD_INFO",
  +	[0x02] = "CARD_BYTES",
   	[0x10] = "ELEM_LIST",
   	[0x11] = "ELEM_INFO",
   	[0x12] = "ELEM_READ",

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h

Please see tools/include/uapi/README for further details.

Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../trace/beauty/include/uapi/sound/asound.h  | 200 ++++++++++--------
 1 file changed, 110 insertions(+), 90 deletions(-)

diff --git a/tools/perf/trace/beauty/include/uapi/sound/asound.h b/tools/perf/trace/beauty/include/uapi/sound/asound.h
index d3ce75ba938a8497..c11da9656e3811d2 100644
--- a/tools/perf/trace/beauty/include/uapi/sound/asound.h
+++ b/tools/perf/trace/beauty/include/uapi/sound/asound.h
@@ -169,72 +169,72 @@ enum {
 	SNDRV_PCM_STREAM_LAST = SNDRV_PCM_STREAM_CAPTURE,
 };
 
-typedef int __bitwise snd_pcm_access_t;
-#define	SNDRV_PCM_ACCESS_MMAP_INTERLEAVED	((__force snd_pcm_access_t) 0) /* interleaved mmap */
-#define	SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED	((__force snd_pcm_access_t) 1) /* noninterleaved mmap */
-#define	SNDRV_PCM_ACCESS_MMAP_COMPLEX		((__force snd_pcm_access_t) 2) /* complex mmap */
-#define	SNDRV_PCM_ACCESS_RW_INTERLEAVED		((__force snd_pcm_access_t) 3) /* readi/writei */
-#define	SNDRV_PCM_ACCESS_RW_NONINTERLEAVED	((__force snd_pcm_access_t) 4) /* readn/writen */
+typedef int snd_pcm_access_t;
+#define	SNDRV_PCM_ACCESS_MMAP_INTERLEAVED	0 /* interleaved mmap */
+#define	SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED	1 /* noninterleaved mmap */
+#define	SNDRV_PCM_ACCESS_MMAP_COMPLEX		2 /* complex mmap */
+#define	SNDRV_PCM_ACCESS_RW_INTERLEAVED		3 /* readi/writei */
+#define	SNDRV_PCM_ACCESS_RW_NONINTERLEAVED	4 /* readn/writen */
 #define	SNDRV_PCM_ACCESS_LAST		SNDRV_PCM_ACCESS_RW_NONINTERLEAVED
 
-typedef int __bitwise snd_pcm_format_t;
-#define	SNDRV_PCM_FORMAT_S8	((__force snd_pcm_format_t) 0)
-#define	SNDRV_PCM_FORMAT_U8	((__force snd_pcm_format_t) 1)
-#define	SNDRV_PCM_FORMAT_S16_LE	((__force snd_pcm_format_t) 2)
-#define	SNDRV_PCM_FORMAT_S16_BE	((__force snd_pcm_format_t) 3)
-#define	SNDRV_PCM_FORMAT_U16_LE	((__force snd_pcm_format_t) 4)
-#define	SNDRV_PCM_FORMAT_U16_BE	((__force snd_pcm_format_t) 5)
-#define	SNDRV_PCM_FORMAT_S24_LE	((__force snd_pcm_format_t) 6) /* low three bytes */
-#define	SNDRV_PCM_FORMAT_S24_BE	((__force snd_pcm_format_t) 7) /* low three bytes */
-#define	SNDRV_PCM_FORMAT_U24_LE	((__force snd_pcm_format_t) 8) /* low three bytes */
-#define	SNDRV_PCM_FORMAT_U24_BE	((__force snd_pcm_format_t) 9) /* low three bytes */
+typedef int snd_pcm_format_t;
+#define	SNDRV_PCM_FORMAT_S8		0
+#define	SNDRV_PCM_FORMAT_U8		1
+#define	SNDRV_PCM_FORMAT_S16_LE		2
+#define	SNDRV_PCM_FORMAT_S16_BE		3
+#define	SNDRV_PCM_FORMAT_U16_LE		4
+#define	SNDRV_PCM_FORMAT_U16_BE		5
+#define	SNDRV_PCM_FORMAT_S24_LE		6	/* low three bytes */
+#define	SNDRV_PCM_FORMAT_S24_BE		7	/* low three bytes */
+#define	SNDRV_PCM_FORMAT_U24_LE		8	/* low three bytes */
+#define	SNDRV_PCM_FORMAT_U24_BE		9	/* low three bytes */
 /*
  * For S32/U32 formats, 'msbits' hardware parameter is often used to deliver information about the
  * available bit count in most significant bit. It's for the case of so-called 'left-justified' or
  * `right-padding` sample which has less width than 32 bit.
  */
-#define	SNDRV_PCM_FORMAT_S32_LE	((__force snd_pcm_format_t) 10)
-#define	SNDRV_PCM_FORMAT_S32_BE	((__force snd_pcm_format_t) 11)
-#define	SNDRV_PCM_FORMAT_U32_LE	((__force snd_pcm_format_t) 12)
-#define	SNDRV_PCM_FORMAT_U32_BE	((__force snd_pcm_format_t) 13)
-#define	SNDRV_PCM_FORMAT_FLOAT_LE	((__force snd_pcm_format_t) 14) /* 4-byte float, IEEE-754 32-bit, range -1.0 to 1.0 */
-#define	SNDRV_PCM_FORMAT_FLOAT_BE	((__force snd_pcm_format_t) 15) /* 4-byte float, IEEE-754 32-bit, range -1.0 to 1.0 */
-#define	SNDRV_PCM_FORMAT_FLOAT64_LE	((__force snd_pcm_format_t) 16) /* 8-byte float, IEEE-754 64-bit, range -1.0 to 1.0 */
-#define	SNDRV_PCM_FORMAT_FLOAT64_BE	((__force snd_pcm_format_t) 17) /* 8-byte float, IEEE-754 64-bit, range -1.0 to 1.0 */
-#define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE ((__force snd_pcm_format_t) 18) /* IEC-958 subframe, Little Endian */
-#define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE ((__force snd_pcm_format_t) 19) /* IEC-958 subframe, Big Endian */
-#define	SNDRV_PCM_FORMAT_MU_LAW		((__force snd_pcm_format_t) 20)
-#define	SNDRV_PCM_FORMAT_A_LAW		((__force snd_pcm_format_t) 21)
-#define	SNDRV_PCM_FORMAT_IMA_ADPCM	((__force snd_pcm_format_t) 22)
-#define	SNDRV_PCM_FORMAT_MPEG		((__force snd_pcm_format_t) 23)
-#define	SNDRV_PCM_FORMAT_GSM		((__force snd_pcm_format_t) 24)
-#define	SNDRV_PCM_FORMAT_S20_LE	((__force snd_pcm_format_t) 25) /* in four bytes, LSB justified */
-#define	SNDRV_PCM_FORMAT_S20_BE	((__force snd_pcm_format_t) 26) /* in four bytes, LSB justified */
-#define	SNDRV_PCM_FORMAT_U20_LE	((__force snd_pcm_format_t) 27) /* in four bytes, LSB justified */
-#define	SNDRV_PCM_FORMAT_U20_BE	((__force snd_pcm_format_t) 28) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_S32_LE		10
+#define	SNDRV_PCM_FORMAT_S32_BE		11
+#define	SNDRV_PCM_FORMAT_U32_LE		12
+#define	SNDRV_PCM_FORMAT_U32_BE		13
+#define	SNDRV_PCM_FORMAT_FLOAT_LE	14	/* 4-byte float, IEEE-754 32-bit, range -1.0 to 1.0 */
+#define	SNDRV_PCM_FORMAT_FLOAT_BE	15	/* 4-byte float, IEEE-754 32-bit, range -1.0 to 1.0 */
+#define	SNDRV_PCM_FORMAT_FLOAT64_LE	16	/* 8-byte float, IEEE-754 64-bit, range -1.0 to 1.0 */
+#define	SNDRV_PCM_FORMAT_FLOAT64_BE	17	/* 8-byte float, IEEE-754 64-bit, range -1.0 to 1.0 */
+#define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE 18	/* IEC-958 subframe, Little Endian */
+#define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE 19	/* IEC-958 subframe, Big Endian */
+#define	SNDRV_PCM_FORMAT_MU_LAW		20
+#define	SNDRV_PCM_FORMAT_A_LAW		21
+#define	SNDRV_PCM_FORMAT_IMA_ADPCM	22
+#define	SNDRV_PCM_FORMAT_MPEG		23
+#define	SNDRV_PCM_FORMAT_GSM		24
+#define	SNDRV_PCM_FORMAT_S20_LE		25	/* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_S20_BE		26	/* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_LE		27	/* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_BE		28	/* in four bytes, LSB justified */
 /* gap in the numbering for a future standard linear format */
-#define	SNDRV_PCM_FORMAT_SPECIAL	((__force snd_pcm_format_t) 31)
-#define	SNDRV_PCM_FORMAT_S24_3LE	((__force snd_pcm_format_t) 32)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_S24_3BE	((__force snd_pcm_format_t) 33)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_U24_3LE	((__force snd_pcm_format_t) 34)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_U24_3BE	((__force snd_pcm_format_t) 35)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_S20_3LE	((__force snd_pcm_format_t) 36)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_S20_3BE	((__force snd_pcm_format_t) 37)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_U20_3LE	((__force snd_pcm_format_t) 38)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_U20_3BE	((__force snd_pcm_format_t) 39)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_S18_3LE	((__force snd_pcm_format_t) 40)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_S18_3BE	((__force snd_pcm_format_t) 41)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_U18_3LE	((__force snd_pcm_format_t) 42)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_U18_3BE	((__force snd_pcm_format_t) 43)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_G723_24	((__force snd_pcm_format_t) 44) /* 8 samples in 3 bytes */
-#define	SNDRV_PCM_FORMAT_G723_24_1B	((__force snd_pcm_format_t) 45) /* 1 sample in 1 byte */
-#define	SNDRV_PCM_FORMAT_G723_40	((__force snd_pcm_format_t) 46) /* 8 Samples in 5 bytes */
-#define	SNDRV_PCM_FORMAT_G723_40_1B	((__force snd_pcm_format_t) 47) /* 1 sample in 1 byte */
-#define	SNDRV_PCM_FORMAT_DSD_U8		((__force snd_pcm_format_t) 48) /* DSD, 1-byte samples DSD (x8) */
-#define	SNDRV_PCM_FORMAT_DSD_U16_LE	((__force snd_pcm_format_t) 49) /* DSD, 2-byte samples DSD (x16), little endian */
-#define	SNDRV_PCM_FORMAT_DSD_U32_LE	((__force snd_pcm_format_t) 50) /* DSD, 4-byte samples DSD (x32), little endian */
-#define	SNDRV_PCM_FORMAT_DSD_U16_BE	((__force snd_pcm_format_t) 51) /* DSD, 2-byte samples DSD (x16), big endian */
-#define	SNDRV_PCM_FORMAT_DSD_U32_BE	((__force snd_pcm_format_t) 52) /* DSD, 4-byte samples DSD (x32), big endian */
+#define	SNDRV_PCM_FORMAT_SPECIAL	31
+#define	SNDRV_PCM_FORMAT_S24_3LE	32	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_S24_3BE	33	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U24_3LE	34	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U24_3BE	35	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_S20_3LE	36	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_S20_3BE	37	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U20_3LE	38	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U20_3BE	39	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_S18_3LE	40	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_S18_3BE	41	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U18_3LE	42	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U18_3BE	43	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_G723_24	44	/* 8 samples in 3 bytes */
+#define	SNDRV_PCM_FORMAT_G723_24_1B	45	/* 1 sample in 1 byte */
+#define	SNDRV_PCM_FORMAT_G723_40	46	/* 8 Samples in 5 bytes */
+#define	SNDRV_PCM_FORMAT_G723_40_1B	47	/* 1 sample in 1 byte */
+#define	SNDRV_PCM_FORMAT_DSD_U8		48	/* DSD, 1-byte samples DSD (x8) */
+#define	SNDRV_PCM_FORMAT_DSD_U16_LE	49	/* DSD, 2-byte samples DSD (x16), little endian */
+#define	SNDRV_PCM_FORMAT_DSD_U32_LE	50	/* DSD, 4-byte samples DSD (x32), little endian */
+#define	SNDRV_PCM_FORMAT_DSD_U16_BE	51	/* DSD, 2-byte samples DSD (x16), big endian */
+#define	SNDRV_PCM_FORMAT_DSD_U32_BE	52	/* DSD, 4-byte samples DSD (x32), big endian */
 #define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U32_BE
 #define	SNDRV_PCM_FORMAT_FIRST		SNDRV_PCM_FORMAT_S8
 
@@ -265,11 +265,11 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_BE
 #endif
 
-typedef int __bitwise snd_pcm_subformat_t;
-#define	SNDRV_PCM_SUBFORMAT_STD		((__force snd_pcm_subformat_t) 0)
-#define	SNDRV_PCM_SUBFORMAT_MSBITS_MAX	((__force snd_pcm_subformat_t) 1)
-#define	SNDRV_PCM_SUBFORMAT_MSBITS_20	((__force snd_pcm_subformat_t) 2)
-#define	SNDRV_PCM_SUBFORMAT_MSBITS_24	((__force snd_pcm_subformat_t) 3)
+typedef int snd_pcm_subformat_t;
+#define	SNDRV_PCM_SUBFORMAT_STD		0
+#define	SNDRV_PCM_SUBFORMAT_MSBITS_MAX	1
+#define	SNDRV_PCM_SUBFORMAT_MSBITS_20	2
+#define	SNDRV_PCM_SUBFORMAT_MSBITS_24	3
 #define	SNDRV_PCM_SUBFORMAT_LAST	SNDRV_PCM_SUBFORMAT_MSBITS_24
 
 #define SNDRV_PCM_INFO_MMAP		0x00000001	/* hardware supports mmap */
@@ -303,16 +303,16 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define __SND_STRUCT_TIME64
 #endif
 
-typedef int __bitwise snd_pcm_state_t;
-#define	SNDRV_PCM_STATE_OPEN		((__force snd_pcm_state_t) 0) /* stream is open */
-#define	SNDRV_PCM_STATE_SETUP		((__force snd_pcm_state_t) 1) /* stream has a setup */
-#define	SNDRV_PCM_STATE_PREPARED	((__force snd_pcm_state_t) 2) /* stream is ready to start */
-#define	SNDRV_PCM_STATE_RUNNING		((__force snd_pcm_state_t) 3) /* stream is running */
-#define	SNDRV_PCM_STATE_XRUN		((__force snd_pcm_state_t) 4) /* stream reached an xrun */
-#define	SNDRV_PCM_STATE_DRAINING	((__force snd_pcm_state_t) 5) /* stream is draining */
-#define	SNDRV_PCM_STATE_PAUSED		((__force snd_pcm_state_t) 6) /* stream is paused */
-#define	SNDRV_PCM_STATE_SUSPENDED	((__force snd_pcm_state_t) 7) /* hardware is suspended */
-#define	SNDRV_PCM_STATE_DISCONNECTED	((__force snd_pcm_state_t) 8) /* hardware is disconnected */
+typedef int snd_pcm_state_t;
+#define	SNDRV_PCM_STATE_OPEN		0 /* stream is open */
+#define	SNDRV_PCM_STATE_SETUP		1 /* stream has a setup */
+#define	SNDRV_PCM_STATE_PREPARED	2 /* stream is ready to start */
+#define	SNDRV_PCM_STATE_RUNNING		3 /* stream is running */
+#define	SNDRV_PCM_STATE_XRUN		4 /* stream reached an xrun */
+#define	SNDRV_PCM_STATE_DRAINING	5 /* stream is draining */
+#define	SNDRV_PCM_STATE_PAUSED		6 /* stream is paused */
+#define	SNDRV_PCM_STATE_SUSPENDED	7 /* hardware is suspended */
+#define	SNDRV_PCM_STATE_DISCONNECTED	8 /* hardware is disconnected */
 #define	SNDRV_PCM_STATE_LAST		SNDRV_PCM_STATE_DISCONNECTED
 
 enum {
@@ -1058,7 +1058,7 @@ struct snd_timer_tread {
  *                                                                          *
  ****************************************************************************/
 
-#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 9)
+#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 10)
 
 struct snd_ctl_card_info {
 	int card;			/* card number */
@@ -1072,24 +1072,43 @@ struct snd_ctl_card_info {
 	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
 };
 
-typedef int __bitwise snd_ctl_elem_type_t;
-#define	SNDRV_CTL_ELEM_TYPE_NONE	((__force snd_ctl_elem_type_t) 0) /* invalid */
-#define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	((__force snd_ctl_elem_type_t) 1) /* boolean type */
-#define	SNDRV_CTL_ELEM_TYPE_INTEGER	((__force snd_ctl_elem_type_t) 2) /* integer type */
-#define	SNDRV_CTL_ELEM_TYPE_ENUMERATED	((__force snd_ctl_elem_type_t) 3) /* enumerated type */
-#define	SNDRV_CTL_ELEM_TYPE_BYTES	((__force snd_ctl_elem_type_t) 4) /* byte array */
-#define	SNDRV_CTL_ELEM_TYPE_IEC958	((__force snd_ctl_elem_type_t) 5) /* IEC958 (S/PDIF) setup */
-#define	SNDRV_CTL_ELEM_TYPE_INTEGER64	((__force snd_ctl_elem_type_t) 6) /* 64-bit integer type */
+/*
+ * Card components can exceed the fixed 128 bytes in snd_ctl_card_info.
+ * Use SNDRV_CTL_IOCTL_CARD_BYTES with type SND_CTL_CARD_BTYPE_COMPONENTS
+ * to retrieve the full string.
+ */
+
+/* Type values for struct snd_ctl_card_bytes::type */
+enum {
+	SND_CTL_CARD_BTYPE_COMPONENTS	= 1,	/* full card components string */
+};
+
+struct snd_ctl_card_bytes {
+	__u32 type;				/* SND_CTL_CARD_BTYPE_* */
+	__u32 data_allocated;	/* size of @data buffer in bytes */
+	__u32 data_len;			/* in/out: actual data length in bytes */
+	__u32 reserved;			/* explicit pad */
+	__u64 data;				/* user buffer (pointer stored as __u64) */
+};
+
+typedef int snd_ctl_elem_type_t;
+#define	SNDRV_CTL_ELEM_TYPE_NONE	0 /* invalid */
+#define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	1 /* boolean type */
+#define	SNDRV_CTL_ELEM_TYPE_INTEGER	2 /* integer type */
+#define	SNDRV_CTL_ELEM_TYPE_ENUMERATED	3 /* enumerated type */
+#define	SNDRV_CTL_ELEM_TYPE_BYTES	4 /* byte array */
+#define	SNDRV_CTL_ELEM_TYPE_IEC958	5 /* IEC958 (S/PDIF) setup */
+#define	SNDRV_CTL_ELEM_TYPE_INTEGER64	6 /* 64-bit integer type */
 #define	SNDRV_CTL_ELEM_TYPE_LAST	SNDRV_CTL_ELEM_TYPE_INTEGER64
 
-typedef int __bitwise snd_ctl_elem_iface_t;
-#define	SNDRV_CTL_ELEM_IFACE_CARD	((__force snd_ctl_elem_iface_t) 0) /* global control */
-#define	SNDRV_CTL_ELEM_IFACE_HWDEP	((__force snd_ctl_elem_iface_t) 1) /* hardware dependent device */
-#define	SNDRV_CTL_ELEM_IFACE_MIXER	((__force snd_ctl_elem_iface_t) 2) /* virtual mixer device */
-#define	SNDRV_CTL_ELEM_IFACE_PCM	((__force snd_ctl_elem_iface_t) 3) /* PCM device */
-#define	SNDRV_CTL_ELEM_IFACE_RAWMIDI	((__force snd_ctl_elem_iface_t) 4) /* RawMidi device */
-#define	SNDRV_CTL_ELEM_IFACE_TIMER	((__force snd_ctl_elem_iface_t) 5) /* timer device */
-#define	SNDRV_CTL_ELEM_IFACE_SEQUENCER	((__force snd_ctl_elem_iface_t) 6) /* sequencer client */
+typedef int snd_ctl_elem_iface_t;
+#define	SNDRV_CTL_ELEM_IFACE_CARD	0 /* global control */
+#define	SNDRV_CTL_ELEM_IFACE_HWDEP	1 /* hardware dependent device */
+#define	SNDRV_CTL_ELEM_IFACE_MIXER	2 /* virtual mixer device */
+#define	SNDRV_CTL_ELEM_IFACE_PCM	3 /* PCM device */
+#define	SNDRV_CTL_ELEM_IFACE_RAWMIDI	4 /* RawMidi device */
+#define	SNDRV_CTL_ELEM_IFACE_TIMER	5 /* timer device */
+#define	SNDRV_CTL_ELEM_IFACE_SEQUENCER	6 /* sequencer client */
 #define	SNDRV_CTL_ELEM_IFACE_LAST	SNDRV_CTL_ELEM_IFACE_SEQUENCER
 
 #define SNDRV_CTL_ELEM_ACCESS_READ		(1<<0)
@@ -1198,6 +1217,7 @@ struct snd_ctl_tlv {
 
 #define SNDRV_CTL_IOCTL_PVERSION	_IOR('U', 0x00, int)
 #define SNDRV_CTL_IOCTL_CARD_INFO	_IOR('U', 0x01, struct snd_ctl_card_info)
+#define SNDRV_CTL_IOCTL_CARD_BYTES	_IOWR('U', 0x02, struct snd_ctl_card_bytes)
 #define SNDRV_CTL_IOCTL_ELEM_LIST	_IOWR('U', 0x10, struct snd_ctl_elem_list)
 #define SNDRV_CTL_IOCTL_ELEM_INFO	_IOWR('U', 0x11, struct snd_ctl_elem_info)
 #define SNDRV_CTL_IOCTL_ELEM_READ	_IOWR('U', 0x12, struct snd_ctl_elem_value)
-- 
2.56.0

