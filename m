Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4E172BD5;
	Thu, 10 Apr 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243892; cv=none; b=oJUDtNBGiQh57GaRspb0uS1qyU7uV7qUeOhqpoGloaOdJNpfzt5ihlP2Tupr13InH9RBUoV8GYxwno8TSsoFbBJZP0rnKZ0qF4J9LK9F2tEWl1G4Eb3NdUH0QFXb9Xd3+XTCoN0BiH8rVbrXxgBfxmn9cqySUbkO15TFOljE318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243892; c=relaxed/simple;
	bh=+r8U8hwXDQFs2eGkncAiuoZnN1KgVhOqirh8hXUaHv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jbmlq8YuWMwUo445axvqfBAbpTHO7HgHD5R+RDZ1m3Rg0tAMDQYv6XD2LJRI8H0GcsUoTeEH9pThvqn9kTb/jsvz+HLAqlpgE/5l6rencyaXfB/H4g9c3+/AymAthdXOpu47DQtSAvZo6n6rrqyUz0CExWt5l6InohDhU/ksCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfwQer2s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfwQer2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272FFC4CEE3;
	Thu, 10 Apr 2025 00:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243891;
	bh=+r8U8hwXDQFs2eGkncAiuoZnN1KgVhOqirh8hXUaHv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfwQer2sCctsdcsC6MXVyA0GpWyT21/x0C5xyD9+QJSfRFPzv2nvjEtKEelYuAPvy
	 jE8Ws3/Y+fu0SOg9SrYs9x4LV/VcktOguQMKg8eKUtanrZM0Qr5Xv26zpXCEBZk+Fq
	 vv0vG/0SkKUbpPuMpZiP4qrp67CkLJ0LbQCZQ2fc66iU6KKxmhpCONIrM+sfr3sdU6
	 CWMf19rxUoCHfUI75+AwLHXLE0LRCByhyClJ0Qk1FF1ihXUCT2siTzJDTPbtp+wJC1
	 3hzdmU6qaEEpYovY4onklJ2t6+cWoX1/jPVnz42D6X9BT7+Jtj/x4aIWyZqoqOM0Ux
	 nU4S8V/YxCKfA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 08/10] tools headers: Update the linux/unaligned.h copy with the kernel sources
Date: Wed,  9 Apr 2025 17:11:23 -0700
Message-ID: <20250410001125.391820-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in:

  3846699217798061 ALSA: rawmidi: Make tied_device=0 as default / unknown
  7bb49d2e8b52adac ALSA: rawmidi: Bump protocol version to 2.0.5
  b8fefed73a952a33 ALSA: rawmidi: Show substream activity in info ioctl
  bdf46443f350dd5d ALSA: rawmidi: Expose the tied device number in info ioctl

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h

Please see tools/include/uapi/README for further details.

Cc: linux-sound@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/sound/asound.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/include/uapi/sound/asound.h b/tools/perf/trace/beauty/include/uapi/sound/asound.h
index 4cd513215bcd8f74..5a049eeaeccea59f 100644
--- a/tools/perf/trace/beauty/include/uapi/sound/asound.h
+++ b/tools/perf/trace/beauty/include/uapi/sound/asound.h
@@ -716,7 +716,7 @@ enum {
  *  Raw MIDI section - /dev/snd/midi??
  */
 
-#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 4)
+#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 5)
 
 enum {
 	SNDRV_RAWMIDI_STREAM_OUTPUT = 0,
@@ -728,6 +728,9 @@ enum {
 #define SNDRV_RAWMIDI_INFO_INPUT		0x00000002
 #define SNDRV_RAWMIDI_INFO_DUPLEX		0x00000004
 #define SNDRV_RAWMIDI_INFO_UMP			0x00000008
+#define SNDRV_RAWMIDI_INFO_STREAM_INACTIVE	0x00000010
+
+#define SNDRV_RAWMIDI_DEVICE_UNKNOWN		0
 
 struct snd_rawmidi_info {
 	unsigned int device;		/* RO/WR (control): device number */
@@ -740,7 +743,8 @@ struct snd_rawmidi_info {
 	unsigned char subname[32];	/* name of active or selected subdevice */
 	unsigned int subdevices_count;
 	unsigned int subdevices_avail;
-	unsigned char reserved[64];	/* reserved for future use */
+	int tied_device;		/* R: tied rawmidi device (UMP/legacy) */
+	unsigned char reserved[60];	/* reserved for future use */
 };
 
 #define SNDRV_RAWMIDI_MODE_FRAMING_MASK		(7<<0)
-- 
2.49.0.504.g3bcea36a83-goog

