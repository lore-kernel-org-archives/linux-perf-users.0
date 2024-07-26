Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7C178CF6;
	Fri, 26 Jul 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989719; cv=none; b=f0Y1fHK5ceppM8d9S3AzMpK8AkNkFL3l825ePmwcU67mSXLvAljmer7ZFfn9Fmz0HODu9agEJ4rJF47elBrvGYHJBTk3WEd9kJlOO0I2y2uYsh+06wyRyEDm1plx2s5Je/mfO5mmRD7f2oARhF/92OzWSZ6iPKRhuVW0Qq2fDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989719; c=relaxed/simple;
	bh=MjhgwSqZimmdmD1dpQq5wlRkC5PeBJVr3Dq9nmm48Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiAzySRxttbNFj83XopDfAGBsZEvrxwQdAPntj22eo4hiRNnOPxEWAsicckr3H6uV4vcQ88vmeRNhLV/Pii6dMSdoNUc0VjmCeEbRKcargdng2V8hGOAMRX04G8cFqqlMfEMMQwEA/MlBFp/6oKVi1g5GU2D0N5HXMC18b6Ex7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrTCzGnz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrTCzGnz"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d19c525b5so605647b3a.2;
        Fri, 26 Jul 2024 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721989717; x=1722594517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVEF7D5qINKpDbwHrDwMFyfJ/l35hZL2O5jduliMP9M=;
        b=ZrTCzGnzNDu0lobzCFVuDS1McJFiQOJcw8PYprcsrQOPlXtE0PPXDQSBJaso5yF4TO
         vwJk0uKaKusbu8ZexP7IgWrTp3eHPZL32ozZFx0AGwPt5aQoEGWDjPVqZ1cm889LAsz3
         qyAiEGWzgd1gfUPTAL7G6y6B3+LXrsdXmR1xfXxxbMMSNe6vbhQtVe86z1dDRYlygu5e
         P7/lx0W+9wZfsvoxrX9mYJ6BYxCzBjFvl4GTlA/VRJAaFqVPDvT7hhxitmZt0+CPkw1S
         ZzeG2ooCWX56hnyrJM8QRuTHEfjTTCSm+IWsbHqh2pZx3c/IRS5q/5pZU3euSppw7VuN
         B1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721989717; x=1722594517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVEF7D5qINKpDbwHrDwMFyfJ/l35hZL2O5jduliMP9M=;
        b=tpZ84JLaxnv4GSXOqQsQ4I9Pq7ZikmGHrzNuj9OZm3skS8kANPpHqDqD/EOobgPccC
         J6ZMRXJMIUJc8E1bA5wJFQ3sV76MakdTtuifrAHk0vvYKNqu4JQ6TcIC58Vj1bvEU1he
         Dyj+XUh/uH1qV694E2NDrBgo4W0awbfN3KxlQkiO0ebAH87nhnIrpdWWm2OQykVfsn6C
         5G2HCsFZTcN3GMjNUuzfMmZ3pTu8ISwkVjowqoFlF2wwhwZ/sO7ORIhqQTmZ/Ds0YsyM
         a3FW3xHy0plViPQagJUy+j9L4go5v9jLLbOgesvVASS6uiuo5t1DEzqvI1+qKUPYbTLP
         tcFw==
X-Forwarded-Encrypted: i=1; AJvYcCU9KDsbY4OPpl9TwL5azazRpsGSWgpUR/ZMHUF7N/jgbFOsJMcyNyJqsCvbBR0hVYhM1TmynRkTfSsOc6r5vxn+ULMQ9HLE7JTt9eKTjSMPkduDH7Pqv1m95JlU4Rqy2NeNs7UPgNW02NKFAsRJVg==
X-Gm-Message-State: AOJu0YyuACbrf9UOPzu+zkcGmLVHvrekSsXmrYPPKWgGVATkRG1qGFRU
	xfxIzucVTZBBSHJdsfazcYLYgV7MyoyZ9EUkx4a8ebOh/Bi+/jtIHCaItQEz
X-Google-Smtp-Source: AGHT+IE//9XYv0NtcGzXg87opZmhH6Ab9BKIze4hU8Fji26nueGSX/rzi3uZCMxtyyXHAeboblFZwQ==
X-Received: by 2002:a05:6a21:3982:b0:1c4:698f:c509 with SMTP id adf61e73a8af0-1c47b1db22cmr5014828637.31.1721989717103;
        Fri, 26 Jul 2024 03:28:37 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816da89sm2179964a12.20.2024.07.26.03.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:28:36 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] perf record off-cpu: Add direct off-cpu event
Date: Fri, 26 Jul 2024 18:28:22 +0800
Message-ID: <20240726102826.787004-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726102826.787004-1-howardchu95@gmail.com>
References: <20240726102826.787004-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add direct off-cpu event called "offcpu-time-direct". Add a threshold to
dump direct off-cpu samples, "--off-cpu-thresh". Default value of
--off-cpu-thresh is UULONG_MAX(no direct off-cpu samples), and
--off-cpu-thresh's unit is milliseconds.

Bind fds and sample_id in off_cpu_start()

Note that we add "offcpu-time-direct" event using parse_event(), because we
need to make it no-inherit, otherwise perf_event_open() will fail.

Introduce sample_type_embed, indicating the sample_type of a sample
embedded in BPF output. More discussions in later patches.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c   |  2 ++
 tools/perf/util/bpf_off_cpu.c | 53 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/off_cpu.h     |  1 +
 tools/perf/util/record.h      |  1 +
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a94516e8c522..708d48d309d6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3325,6 +3325,7 @@ static struct record record = {
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
+		.off_cpu_thresh      = ULLONG_MAX,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -3557,6 +3558,7 @@ static struct option __record_options[] = {
 			    "write collected trace data into several data files using parallel threads",
 			    record__parse_threads),
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
+	OPT_U64(0, "off-cpu-thresh", &record.opts.off_cpu_thresh, "time threshold(in ms) for dumping off-cpu events"),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 6af36142dc5a..905a11c96c5b 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -13,6 +13,7 @@
 #include "util/cgroup.h"
 #include "util/strlist.h"
 #include <bpf/bpf.h>
+#include <internal/xyarray.h>
 
 #include "bpf_skel/off_cpu.skel.h"
 
@@ -45,10 +46,12 @@ static int off_cpu_config(struct evlist *evlist)
 		.size	= sizeof(attr), /* to capture ABI version */
 	};
 	char *evname = strdup(OFFCPU_EVENT);
+	char off_cpu_direct_event[64];
 
 	if (evname == NULL)
 		return -ENOMEM;
 
+	/* off-cpu event in the end */
 	evsel = evsel__new(&attr);
 	if (!evsel) {
 		free(evname);
@@ -65,12 +68,22 @@ static int off_cpu_config(struct evlist *evlist)
 	free(evsel->name);
 	evsel->name = evname;
 
+	/* direct off-cpu event */
+	snprintf(off_cpu_direct_event, sizeof(off_cpu_direct_event), "bpf-output/no-inherit=1,name=%s/", OFFCPU_EVENT_DIRECT);
+	if (parse_event(evlist, off_cpu_direct_event)) {
+		pr_err("Failed to open off-cpu event\n");
+		return -1;
+	}
+
 	return 0;
 }
 
 static void off_cpu_start(void *arg)
 {
 	struct evlist *evlist = arg;
+	struct evsel *evsel;
+	struct perf_cpu pcpu;
+	int i, err;
 
 	/* update task filter for the given workload */
 	if (!skel->bss->has_cpu && !skel->bss->has_task &&
@@ -86,6 +99,27 @@ static void off_cpu_start(void *arg)
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
 	}
 
+	/* sample id and fds in BPF's perf_event_array can only be set after record__open() */
+	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT_DIRECT);
+	if (evsel == NULL) {
+		pr_err("%s evsel not found\n", OFFCPU_EVENT_DIRECT);
+		return;
+	}
+
+	if (evsel->core.id)
+		skel->bss->sample_id = evsel->core.id[0];
+
+	perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
+		err = bpf_map__update_elem(skel->maps.offcpu_output,
+					   &pcpu.cpu, sizeof(__u32),
+					   xyarray__entry(evsel->core.fd, pcpu.cpu, 0),
+					   sizeof(__u32), BPF_ANY);
+		if (err) {
+			pr_err("Failed to update perf event map for direct off-cpu dumping\n");
+			return;
+		}
+	}
+
 	skel->bss->enabled = 1;
 }
 
@@ -130,14 +164,24 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 {
 	int err, fd, i;
 	int ncpus = 1, ntasks = 1, ncgrps = 1;
+	__u64 offcpu_thresh;
 	struct strlist *pid_slist = NULL;
 	struct str_node *pos;
+	struct evsel *evsel;
 
 	if (off_cpu_config(evlist) < 0) {
 		pr_err("Failed to config off-cpu BPF event\n");
 		return -1;
 	}
 
+	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT_DIRECT);
+	if (evsel == NULL) {
+		pr_err("%s evsel not found\n", OFFCPU_EVENT_DIRECT);
+		return -1 ;
+	}
+
+	evsel->sample_type_embed = OFFCPU_SAMPLE_TYPES;
+
 	skel = off_cpu_bpf__open();
 	if (!skel) {
 		pr_err("Failed to open off-cpu BPF skeleton\n");
@@ -250,7 +294,6 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 	}
 
 	if (evlist__first(evlist)->cgrp) {
-		struct evsel *evsel;
 		u8 val = 1;
 
 		skel->bss->has_cgroup = 1;
@@ -272,6 +315,14 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	offcpu_thresh = opts->off_cpu_thresh;
+
+	if (opts->off_cpu_thresh != ULLONG_MAX)
+		offcpu_thresh = opts->off_cpu_thresh * 1000000; /* off-cpu-thresh is in ms */
+
+	skel->bss->offcpu_thresh = offcpu_thresh;
+	skel->bss->sample_type   = OFFCPU_SAMPLE_TYPES;
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2dd67c60f211..a349f8e300e0 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -9,6 +9,7 @@ struct perf_session;
 struct record_opts;
 
 #define OFFCPU_EVENT  "offcpu-time"
+#define OFFCPU_EVENT_DIRECT  "offcpu-time-direct"
 
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e..3c11416e6627 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -79,6 +79,7 @@ struct record_opts {
 	int	      synth;
 	int	      threads_spec;
 	const char    *threads_user_spec;
+	u64	      off_cpu_thresh;
 };
 
 extern const char * const *record_usage;
-- 
2.45.2

