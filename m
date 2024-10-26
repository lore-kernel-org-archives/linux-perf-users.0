Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A241537C8
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Oct 2024 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729922097; cv=none; b=U2K2kW3yLWe9TApD4SGGulBl+EbPC/mQqfUGYh/EIW+TIUObcLPUFAlXEwZlbCGzu7794LDNgtydUBQqChUAl4+3CTgr2Mx8z5XtJM/7QgXsn2NssDX4O2Qm7bD7q/FHZ8irvkDQ4xWcapko9kwpnsS0blOGiuREmzValJBbYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729922097; c=relaxed/simple;
	bh=qhKiOzd4hWkfDT0ixda2Xpgm6/DzGg6Q7le4hCKq89I=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=nd/GjMCJFFXEZ7/di86htBJikb9Fbr2LP7vIgEeBL0mnd68/O/Me1jDDfGFqjzGzdHDhPHrISFRuS/h7DiRQAz94DcSM6m4H8J1jh3YIK7EFMtXNOmy/EGjLLbZF404I3mvXNjNfjTxB/s75JJKmrLLTv06MpcmbOOrbysPKeis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvoopHvx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvoopHvx"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2bd3e0a26cso5432441276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 22:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729922093; x=1730526893; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fQ+JoA3yMgCIChxZeZuJrJ0GmpCnonVaPMsJNW1KHPQ=;
        b=bvoopHvxvp4OUJSNRb03tezzt1wkkSvBwvz5+uPNw2QzC44gtQ/JrPXD0xtT5WRTCo
         Hb9Snz3aOhCcofba0VYWZGosMp+5ivoFvrQ82c8xCalJ8n2V2FuF1lFl7mqceRRKMGzZ
         rlYlz5PVbQSvrR+5UFkpnXq9YI4AIqmmWk38GmPJ+W/6aH5Chx1K5OWB6vcIc5R8rQmO
         WgCtWkz8H5KX5KB/apYy80RJvfYArfAXT/eFy4LhnS25yTXVcod2ezjDc/QhCO8PKoJb
         GSTs3xjYKg9e/W9SleNqrJtazeZPHiNPTxgySpWF6UsP9uCHZtuqoRhzQCGzyTCrKhmJ
         VTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729922093; x=1730526893;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQ+JoA3yMgCIChxZeZuJrJ0GmpCnonVaPMsJNW1KHPQ=;
        b=UlPixZP+jtTjgM734MnwIKntS0kqDnEvtz6ecw3xA2fAbHVINWxl+4ODmNn+nVElF9
         tOk2GOkgsRa2ZFhtfLbDgl1EK67sBKYY1pBuZrBXRyv39tM3OasR57SS84q1q3sQxiKj
         WqFcryAnHRTisehzVM+M/OLDNOPUTQoZLMpQDF+mAArBNEE6heXL8pJUbht6PeIQrLVm
         orPN62PNJ0TScs0NihjdqCXMHZZlqvCg7UOyerKCyNVxLM25RcqgVBjMRbyPKFvVLQDN
         ys7Gg3xBIeCQRnldaWlcfyTaG4fV1Cc5lbmyf3KSwSP1e7DERmWQiHi3LNShgsVGGMXp
         s97A==
X-Forwarded-Encrypted: i=1; AJvYcCUYJaJzAgb9SPqi6pdCK9V+X97IhrnFSngREAy/jDK3aduLEcVi4eFf0omDZ+P+/qoQkAe0DTbQSsroN6qsPbmM@vger.kernel.org
X-Gm-Message-State: AOJu0YyfdcgSK6jLHADjrX8OgQcs7cesflfK+G2wfMaZhwB0BCSyfteY
	Gdn+T12qnsFvnZdxIFBXIlHiv2n8zHHAPPg9shEYkbItN6o7n8HjP49kgAZSxuhMY8DFUvPMufM
	a31ULDg==
X-Google-Smtp-Source: AGHT+IEwpU1onMnTo2a0bqqTaAxZpdCUl7SSf+//vaZrTq34r6usaqFmjLfqXqtavVQ/YGKlGvWMoIEowYWk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:4bc4:f7cc:83b4:dece])
 (user=irogers job=sendgmr) by 2002:a5b:f0f:0:b0:e2e:2cba:ac1f with SMTP id
 3f1490d57ef6-e3087bd5414mr7597276.6.1729922092758; Fri, 25 Oct 2024 22:54:52
 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:54:48 -0700
Message-Id: <20241026055448.312247-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1] perf cap: Add __NR_capget to arch/x86 unistd
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As there are duplicated kernel headers in tools/include libc can pick
up the wrong definitions. This was causing the wrong system call for
capget in perf.

Closes: https://lore.kernel.org/lkml/cc7d6bdf-1aeb-4179-9029-4baf50b59342@intel.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
 tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
 tools/perf/util/cap.c                       | 10 +++-------
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 9de35df1afc3..63182a023e9d 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -11,6 +11,9 @@
 #ifndef __NR_getpgid
 #define __NR_getpgid 132
 #endif
+#ifndef __NR_capget
+#define __NR_capget 184
+#endif
 #ifndef __NR_gettid
 #define __NR_gettid 224
 #endif
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index d0f2043d7132..77311e8d1b5d 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -11,6 +11,9 @@
 #ifndef __NR_getpgid
 #define __NR_getpgid 121
 #endif
+#ifndef __NR_capget
+#define __NR_capget 125
+#endif
 #ifndef __NR_gettid
 #define __NR_gettid 186
 #endif
diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
index 7574a67651bc..69d9a2bcd40b 100644
--- a/tools/perf/util/cap.c
+++ b/tools/perf/util/cap.c
@@ -7,13 +7,9 @@
 #include "debug.h"
 #include <errno.h>
 #include <string.h>
-#include <unistd.h>
 #include <linux/capability.h>
 #include <sys/syscall.h>
-
-#ifndef SYS_capget
-#define SYS_capget 90
-#endif
+#include <unistd.h>
 
 #define MAX_LINUX_CAPABILITY_U32S _LINUX_CAPABILITY_U32S_3
 
@@ -21,9 +17,9 @@ bool perf_cap__capable(int cap, bool *used_root)
 {
 	struct __user_cap_header_struct header = {
 		.version = _LINUX_CAPABILITY_VERSION_3,
-		.pid = getpid(),
+		.pid = 0,
 	};
-	struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
+	struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S] = {};
 	__u32 cap_val;
 
 	*used_root = false;
-- 
2.47.0.163.g1226f6d8fa-goog

