Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0E230BE9;
	Thu,  1 May 2025 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066500; cv=none; b=bhpcR+6JktkfGAQb2IZ2m2Vk03LxUqCNzxCr/vD/S2rLi1miJULmACoe7hzjAjNIrbj/5VaJGQdPXpqI9Ru2EES0V2+RVB2pfKjnfr371nwcLBcpyUh+20oafkSXwZMRCzrTDwaPog2Vq4WyiRrq5Q7Y74Eks0mB2cF3RTRP2mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066500; c=relaxed/simple;
	bh=VFBcBi6kgTg4RgBDcmOg2i1bLJ9QJGSKr0nnYNEwcMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMqd7rioZ8SRH+2n+YWSBW55RrB2sEKoSti6ZXJbDw9GE/Wiq9YUneonoxbOfv0NuYcx+17KQ8GQzQ5e4EeTlNRlg/yHXi2OK0zc/ffNqsdhSrKhjcNWp9h88fVhJUbSpV7+wWUs0CGdIO02S07TwuNlXACRUx+mzX7ZkWgTMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3lvAy3G; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3lvAy3G"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74019695377so462998b3a.3;
        Wed, 30 Apr 2025 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066497; x=1746671297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIdt8T44pUg9ZI5PqJY71nYgZCT1z4VuC2192Gm2TOU=;
        b=M3lvAy3GDMj9nCPF99O1+pZQPPNFpBQ7gQOSDK7Hr/14gU4a1YRsiYSwavY0sppP4l
         TPvWdAMMtl9xYdgLwwiCiMk/yNhy50xAnOQJWJXiTVBffuFm2rdUGYfuSAKxPS0/w0Fb
         Mk5NgAkCgG8xk2EMBdU8Sx+SDAEjYoFKRJVX3+VQ7D76H8ZeAWAx1Cp34whe+sLg5qx2
         pEHSmqrYBtY1L9I2hI+ViR536ScweUSpMo6alQ37Qi/eBi2PNk64v3pIZ3C99M+UTBQ3
         J2u2QrL8cKJgRRZxN9sElgSPj9EAo5onZjdvHmgoWCovdCZ5nXu+pL89Fm1RhUxB0kRn
         Tf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066497; x=1746671297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIdt8T44pUg9ZI5PqJY71nYgZCT1z4VuC2192Gm2TOU=;
        b=DEpngoVBIMRJebPYVepOuTv7+fi4QGCuBaPOfesNbm1m+cmImfKx3Oq9pecLu6Olit
         WtEIccHcAHW6I5I84+Qyk9YfQfwYPBJXn6AKyUKYd7b4CxeY74gXolaxkM4hfMcTL4dE
         IY9EJrFIpF5aj1Zr0VYsqoAB3eFiDBnp0DcQ8et054H5KqhyZ1/XM9NmdwAmZ66PiWSp
         m7DcTPeFDBkfZyZvBmllLbhMpZ55G07ql0u2t6R3Uv9tPvjxczM12WjWm2CNijLJ5LUs
         Vc2BeF6eFAvd2wB22wi6Ds8HIhIzRBWpbRpqoUkhfB/8oo8HhCjcCkPk/rpH83RqMeXX
         DyNw==
X-Forwarded-Encrypted: i=1; AJvYcCUHVi2fIffNNGt92SKYKGjGsucAk8o0ZOe6Q2DwZemXrfGg+fSit/461vI5FRqOHd6BIqku4JWB7U6pUug=@vger.kernel.org, AJvYcCWbSuLps8YWY56WlbF+FJPLuPGP3SZV4Wf75eFP6tb1fzK/ee2UAKqQvH3lUoXVDcYoJHTHaTimpKl+ry1DstMn8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhEii/ARj4IDWURoshmZUzZJhr1mpmlieo3fLQ2K5iZB+1y3w
	/sGH4p0aGJmBFt92jLSlUzAcBqfXPvuheTQCR5YA+PPO6VK3izeA
X-Gm-Gg: ASbGncvoDG8Zz5UbokNCJUnhyIADjxmRNtaOGO07H2m+9sPSf9DT4oMR5vG2ejGrmrR
	cHuHaKBRhVgGYQkSAVINOjAhzbPbVKx0Fvs3C63FgeFTVmRZcMP8Oonfa0s6aUqUBwVmOXGVyMj
	zod3+mDuEiH2094og84FUGyB92ao+yh5vlrVFxc0ntPndS3A4ABJ73RqPa9PnvKoHc+HB7HofbT
	5dK6djTDfoNsM87B/3hOdPT0ykicAPNttPwCW6APz4LPt8O5UjBVIF2Q/qwmpPc0flyOORJ0wC+
	zSHnrBn+a6BqDGPIVLXwxaKu5ZmMnw5M2Zc2kovEYpOWXYL6OMKwhlZlW64dxBF3RqYAuWPShrC
	noYZDIavkljsooqshZw/y
X-Google-Smtp-Source: AGHT+IEUB68AE0so/EbVx6QyFjubOz1tQGHLljnIt6qiiMZG1XrfHKq8vApAf57wCaVvn4EaqTWUeA==
X-Received: by 2002:a05:6a00:1383:b0:739:3f55:b23f with SMTP id d2e1a72fcca58-740491f63aemr1145658b3a.14.1746066497366;
        Wed, 30 Apr 2025 19:28:17 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:17 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v16 03/10] perf record --off-cpu: Preparation of off-cpu BPF program
Date: Wed, 30 Apr 2025 19:28:01 -0700
Message-ID: <20250501022809.449767-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the perf_event map in BPF for dumping off-cpu samples, and set the
offcpu_thresh to specify the threshold.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-5-howardchu95@gmail.com
[ Added some missing iteration variables to off_cpu_config() and fixed up
  a manually edited patch hunk line boundary line ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_off_cpu.c          | 24 ++++++++++++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 2101aa2b7c42..1975a02c1683 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -13,6 +13,7 @@
 #include "util/cgroup.h"
 #include "util/strlist.h"
 #include <bpf/bpf.h>
+#include <internal/xyarray.h>
 
 #include "bpf_skel/off_cpu.skel.h"
 
@@ -60,6 +61,9 @@ static int off_cpu_config(struct evlist *evlist)
 static void off_cpu_start(void *arg)
 {
 	struct evlist *evlist = arg;
+	struct evsel *evsel;
+	struct perf_cpu pcpu;
+	int i;
 
 	/* update task filter for the given workload */
 	if (skel->rodata->has_task && skel->rodata->uses_tgid &&
@@ -73,6 +77,26 @@ static void off_cpu_start(void *arg)
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
 	}
 
+	/* update BPF perf_event map */
+	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
+	if (evsel == NULL) {
+		pr_err("%s evsel not found\n", OFFCPU_EVENT);
+		return;
+	}
+
+	perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
+		int err;
+		int cpu_nr = pcpu.cpu;
+
+		err = bpf_map__update_elem(skel->maps.offcpu_output, &cpu_nr, sizeof(int),
+					   xyarray__entry(evsel->core.fd, cpu_nr, 0),
+					   sizeof(int), BPF_ANY);
+		if (err) {
+			pr_err("Failed to update perf event map for direct off-cpu dumping\n");
+			return;
+		}
+	}
+
 	skel->bss->enabled = 1;
 }
 
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index c152116df72f..a5002e25b259 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -18,6 +18,8 @@
 #define MAX_STACKS   32
 #define MAX_ENTRIES  102400
 
+#define MAX_CPUS  4096
+
 struct tstamp_data {
 	__u32 stack_id;
 	__u32 state;
@@ -39,6 +41,13 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+	__uint(max_entries, MAX_CPUS);
+} offcpu_output SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
-- 
2.45.2

