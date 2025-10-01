Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320382D46C8
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Oct 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342373; cv=none; b=OnOtWhSI96uGcoJlZYLwfN/LTa/z14+Dqv4ryxjbDyNLM9XV+Ffy+kQtHNDTWWjyB6D9e4KJCw6fmT+qV6fkHbGdRifwVNrBk8+SuzoYV5c7hAhQR2Md24Eoy2+gzjadOpOxxO6PpepwEcsab8/cTpmoVQrZoC4zrsIq3VPZeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342373; c=relaxed/simple;
	bh=HX9oew4e1XAYFrT5AT7h78qJ1smpZAnVIIJYFY+JefI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eMCQArJfJKrSIcN2+qXuhQiKA2u/DiXQvLM2JbsYcI3we+z1PmmWhfRlb+xbhfxjUQZnUOwUxmJD8juoiapUp1ahBiuwfhPi6JinPvcc3i9S/C3roDlO7e05G9aqK27n48ayx+bM2H4iLRJmeMCRU43gdZjxxJBGH29l4CaCerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALNkCant; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALNkCant"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2697410e7f9so1264005ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Oct 2025 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759342371; x=1759947171; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EH7kbbVLdziTCdAjxXm5Ue6gNSX07dTrc9Cjc+NPVyU=;
        b=ALNkCant5jeeKO+LIS6cMCVBRd4+gVeaMrsIdtD12GqcSKUI3yT3qpnJtxUdpa2BMd
         cgeocP2C2Q63sA4SFS9OU94RYOo9IWzj4ha8SPXAVK0/63B1jFxL7AYEkQ3t/mGSirw2
         2e4Rdb0DFELWjKwx0j94b89tGMv6y6myWGwf66Xli9ZEEvOoeu8DvHTQaUUOB35fP3Cw
         nABX3R65FdwfHWARRib3NdCZcRFMguLA567BPsGAewwwbrT1foQtFG2HW8RJ3B0rb+lc
         aU1lVoxASrBFK/5Epwt37+VUeMs9ApBq/TpYu4E8RAHTATrI0eFKTFQT3BlJoB3b23Au
         y5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759342371; x=1759947171;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EH7kbbVLdziTCdAjxXm5Ue6gNSX07dTrc9Cjc+NPVyU=;
        b=hAm9blVikK5QRbRAwxPk6wnsRh2vw7cIPkxzdhrj/X3r+ChM/JVL6cZUttNvKUmrxO
         6+HI51vJcCBT6a5wdHYVNbOqzWNYraXaZ+rFStIWGx9ahPC7Mb2hUevecCb2fOViVA1X
         W+yozr2D1ycwQNOnUxPgOxMigtY+N0uxOU2kpQ+a/yd/ngQCrU4nDQAeENHXro9hT5ZG
         YUeKcK3ufmuBxAEaTXwaPLIMSzGTDNwhI7XulGfrXynMAtq8mX69Y28UzdM63KfC7kQn
         PI6+25CJK/oacb8h3gs4rfxv1to7kthqnwEubItgx2lejwULKKBkG5qFedl6sSFE4MDJ
         ojOw==
X-Forwarded-Encrypted: i=1; AJvYcCVOLOIAr5sETPfDxfjM3ZqMzVGkJbgjJ6tEc5aH9C7fFkUdQ/2HRY60FZ2gEj6T6p1cX5zEOke12PYuaopP/XEU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hXgxJpPPPGemRP9mYkhKOdgddcHS9kf7vQNPrRuW1xv4hBwY
	duv2btj6HJirxcynLCQwYjpXolklkXR1XP7f//x7VXitdbuO52btmErTbIt9wi8P+SI/EIod0Yw
	4Swlk5BbV8Q==
X-Google-Smtp-Source: AGHT+IES+2nYbttOTnv0Js78KqzEulqo5E60Y3lSDZcRX9EumMk5CNUcMSfc2W4thLIdEfbe5dzGHZXjJ9s6
X-Received: from pjob2.prod.google.com ([2002:a17:90a:8c82:b0:330:6513:c709])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3847:b0:278:9051:8e9c
 with SMTP id d9443c01a7336-28e7f440874mr63024935ad.42.1759342371336; Wed, 01
 Oct 2025 11:12:51 -0700 (PDT)
Date: Wed,  1 Oct 2025 11:12:28 -0700
In-Reply-To: <20251001181229.1010340-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001181229.1010340-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001181229.1010340-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf bpf_counter: Fix handling of cpumap fixing hybrid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Don't open evsels on all CPUs, open them just on the CPUs they
support. This avoids opening say an e-core event on a p-core and
getting a failure - achieve this by getting rid of the "all_cpu_map".

In install_pe functions don't use the cpu_map_idx as a CPU number,
translate the cpu_map_idx, which is a dense index into the cpu_map
skipping holes at the beginning, to a proper CPU number.

Before:
```
$ perf stat --bpf-counters -a -e cycles,instructions -- sleep 1

 Performance counter stats for 'system wide':

   <not supported>      cpu_atom/cycles/
       566,270,672      cpu_core/cycles/
   <not supported>      cpu_atom/instructions/
       572,792,836      cpu_core/instructions/           #    1.01  insn per cycle

       1.001595384 seconds time elapsed
```

After:
```
$ perf stat --bpf-counters -a -e cycles,instructions -- sleep 1

 Performance counter stats for 'system wide':

       443,299,201      cpu_atom/cycles/
     1,233,919,737      cpu_core/cycles/
       213,634,112      cpu_atom/instructions/           #    0.48  insn per cycle
     2,758,965,527      cpu_core/instructions/           #    2.24  insn per cycle

       1.001699485 seconds time elapsed
```

Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c        | 26 ++++++++++----------------
 tools/perf/util/bpf_counter_cgroup.c |  3 ++-
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 1c6cb5ea077e..ca5d01b9017d 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -336,6 +336,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx
 {
 	struct bpf_prog_profiler_bpf *skel;
 	struct bpf_counter *counter;
+	int cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx).cpu;
 	int ret;
 
 	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
@@ -343,7 +344,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx
 		assert(skel != NULL);
 
 		ret = bpf_map_update_elem(bpf_map__fd(skel->maps.events),
-					  &cpu_map_idx, &fd, BPF_ANY);
+					  &cpu, &fd, BPF_ANY);
 		if (ret)
 			return ret;
 	}
@@ -451,7 +452,6 @@ static int bperf_check_target(struct evsel *evsel,
 	return 0;
 }
 
-static	struct perf_cpu_map *all_cpu_map;
 static __u32 filter_entry_cnt;
 
 static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
@@ -495,7 +495,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	 * following evsel__open_per_cpu call
 	 */
 	evsel->leader_skel = skel;
-	evsel__open_per_cpu(evsel, all_cpu_map, -1);
+	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
 
 out:
 	bperf_leader_bpf__destroy(skel);
@@ -533,12 +533,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
 		return -1;
 
-	if (!all_cpu_map) {
-		all_cpu_map = perf_cpu_map__new_online_cpus();
-		if (!all_cpu_map)
-			return -1;
-	}
-
 	evsel->bperf_leader_prog_fd = -1;
 	evsel->bperf_leader_link_fd = -1;
 
@@ -656,9 +650,10 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
 {
 	struct bperf_leader_bpf *skel = evsel->leader_skel;
+	int cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx).cpu;
 
 	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
-				   &cpu_map_idx, &fd, BPF_ANY);
+				   &cpu, &fd, BPF_ANY);
 }
 
 /*
@@ -667,13 +662,12 @@ static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
  */
 static int bperf_sync_counters(struct evsel *evsel)
 {
-	int num_cpu, i, cpu;
+	struct perf_cpu cpu;
+	int idx;
+
+	perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus)
+		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu.cpu);
 
-	num_cpu = perf_cpu_map__nr(all_cpu_map);
-	for (i = 0; i < num_cpu; i++) {
-		cpu = perf_cpu_map__cpu(all_cpu_map, i).cpu;
-		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
-	}
 	return 0;
 }
 
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index ed6a29b106b4..690be3ce3e11 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -186,7 +186,8 @@ static int bperf_cgrp__load(struct evsel *evsel,
 }
 
 static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
-				  int cpu __maybe_unused, int fd __maybe_unused)
+				  int cpu_map_idx __maybe_unused,
+				  int fd __maybe_unused)
 {
 	/* nothing to do */
 	return 0;
-- 
2.51.0.618.g983fd99d29-goog

