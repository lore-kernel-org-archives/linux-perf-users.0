Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764CF176AC3;
	Tue,  6 Aug 2024 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984619; cv=none; b=FCbAfwip9ke235+3hcS/opaGWqE9zE4mi0F6Klajut+5KIup6S/BjUb9lPeMUVw4i/gKb7gRT8ZtxLPeUGfgc32ZUdZ4W/7vypxH5AytD4lMPLwaYFLqHkkijJpQTFB7p5y+/78Glcr1cNqyvyVKMMk0pZZ0WRMH577TlVr70/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984619; c=relaxed/simple;
	bh=SJvRysmu8xqA8n6qgCwUmrdFMTmIl8qTQ/IGTpq68eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puzynzBc5CkFai+5JvDV2zwtx70/wDwbZ462oW0JHDj4maI4k+Y1ORnEkJwQvCDXafPJsj9/0D1Hs8He7yV++lfRTV2Dz1ihN8Yt5uv2jl5MVDDGAUwuv6A/Evp8jY6l2zNI4lNmOKB1S+AOO8dJ9T7qYjbsLDw/iGf8sjFKVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m55APhQ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m55APhQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E1BC4AF09;
	Tue,  6 Aug 2024 22:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722984619;
	bh=SJvRysmu8xqA8n6qgCwUmrdFMTmIl8qTQ/IGTpq68eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m55APhQ+th8wn89GKfn8V0dfDs+7hlWsJKUtPC+P2OvdirKIKLRecuBwHH3sANnjI
	 Go14YqgkZ/IjV4GLk+ktbfSVm8kQ2XoaSLLF5y6ejn+7XZfBF8pp9jY5CE6ZZGWWpi
	 JqWQXtdtLibrRSuajAlLTshyz/LHq2DayCbfbmMBnEO0Tzs3pCS3tOhH/qZCapOIgw
	 ud48O1xkMAI3v5EZfsozSwQwBiyW+GHxFmrDH7209ody9mvHXCnBTS7D1750oIntTq
	 ejUQzTHG/oVohqLIAWfgqtMD7pTP0J8I1HmltatWdlF3Hh4VvCglD6nF5Pahn3E8Q4
	 l0WX5ste7haAA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH 05/10] tools/include: Sync uapi/sound/asound.h with the kernel sources
Date: Tue,  6 Aug 2024 15:50:08 -0700
Message-ID: <20240806225013.126130-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240806225013.126130-1-namhyung@kernel.org>
References: <20240806225013.126130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  f05c1ffc2745 ALSA: pcm: reinvent the stream synchronization ID API

This should be used to beautify sound syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
  diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h

Please see tools/include/uapi/README for details (it's in the first patch
of this series).

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/sound/asound.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/trace/beauty/include/uapi/sound/asound.h b/tools/perf/trace/beauty/include/uapi/sound/asound.h
index 628d46a0da92..8bf7e8a0eb6f 100644
--- a/tools/perf/trace/beauty/include/uapi/sound/asound.h
+++ b/tools/perf/trace/beauty/include/uapi/sound/asound.h
@@ -142,7 +142,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 17)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 18)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -334,7 +334,7 @@ union snd_pcm_sync_id {
 	unsigned char id[16];
 	unsigned short id16[8];
 	unsigned int id32[4];
-};
+} __attribute__((deprecated));
 
 struct snd_pcm_info {
 	unsigned int device;		/* RO/WR (control): device number */
@@ -348,7 +348,7 @@ struct snd_pcm_info {
 	int dev_subclass;		/* SNDRV_PCM_SUBCLASS_* */
 	unsigned int subdevices_count;
 	unsigned int subdevices_avail;
-	union snd_pcm_sync_id sync;	/* hardware synchronization ID */
+	unsigned char pad1[16];		/* was: hardware synchronization ID */
 	unsigned char reserved[64];	/* reserved for future... */
 };
 
@@ -420,7 +420,8 @@ struct snd_pcm_hw_params {
 	unsigned int rate_num;		/* R: rate numerator */
 	unsigned int rate_den;		/* R: rate denominator */
 	snd_pcm_uframes_t fifo_size;	/* R: chip FIFO size in frames */
-	unsigned char reserved[64];	/* reserved for future */
+	unsigned char sync[16];		/* R: synchronization ID (perfect sync - one clock source) */
+	unsigned char reserved[48];	/* reserved for future */
 };
 
 enum {
-- 
2.46.0.rc2.264.g509ed76dc8-goog

