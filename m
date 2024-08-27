Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED919D8B8;
	Tue, 27 Aug 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750439; cv=none; b=ULOoRXonmQfRMuEz9lpGSUuUk0qy6RnIW8BNF98rKg0kHfUmSGEVHDaLMslIyXZfaKfkBlFr16OBQj7tJXQuUnzq3ZZ6OxduDElruCbUrhlkWjq9h5PlfeDeLzu3npxKbw3GCBqFG2BLYXNkKtekZG0hPS+/Tu4MbXLqbwGBA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750439; c=relaxed/simple;
	bh=J9ep6SvvhVvWae5Siyf9xQ4d9pIREuEisVKN1WZ0ypg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ttb7lLU/Fha59skwlWWcKLJt8WExxgTC+/PNgaIlR24aso6nfLmhOyvtJQpUAU0kJ0r7/gd2S7nL+TfwKrHqV5xU5J1+FG6rOQT2ibF6iDIbngLUod05+EyqBNFL9tdBgfrG321YiX7TSdE93RFD8kAUS+ZyMmLoojJv/m3Lz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qlk/3bzO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qlk/3bzO"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71446fefddfso2830944b3a.0;
        Tue, 27 Aug 2024 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724750437; x=1725355237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrpdlMQ1W0rFqxCLf05gZ+eKlSN802JEZH3ICSjn+mU=;
        b=Qlk/3bzOqvvFUDgIEiAdo/9iRqBJsIVA9vYCqxEDCYdjOGgJIpVm+0AV7FSTlCHvEj
         ko40E22sy5+RZF3Wp/ir0GIfMfu6mIFvJ4z4lmSGK4c4R5twO4sFuzKdWtamxoPSyduA
         mPPl/rMUb1OGTlvPVqd76B90cPVh/jQ80uw2O1ULlYHRoydk5ae64d2sGTwGBb4ZopqY
         DBsIvkCCg4DrQzFgTRUm2jdnVqFh57hy8MxHiFdWDg0LyUp78HZ1+j9kz2g9DMXHAKAt
         gyDZhU2f0yl9rrfi9o1j3MA4iTUpOLDJ4bIJiBWof6ESXPTJyskpxySyVP8S6QatJErg
         ROqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724750437; x=1725355237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrpdlMQ1W0rFqxCLf05gZ+eKlSN802JEZH3ICSjn+mU=;
        b=jUToeghT1vgziBaiUey8/KakhjZA21DeXZlCseDzIHfEiigYh8leHk9Wm/ypM0RDrT
         HZxwUYVwoQQc1DI0UdCJvcpp2o3KlVqGxDYliUcRBsdknEvWcwlXa1aZuyS4JGtzHR3l
         F17ERaHqBeKnpXAxm8frKcHHaI4Qj5KTtjXyrhRoMV73u92Cz1XaPegNjcljoVQBj+GY
         ScSDX/mxuLGsTc4AcrF3zC7O2PEQxVIVZ9J1h02dUQZqVkvYWOMDh+X5IlrPUlZ0Aur6
         VzK/ksm99UjYx4OY1S6uDLrhXD/szx5WJJd/Dkig6k3YlSuFOmg4WXiibBDjaE4PfGR7
         3L7Q==
X-Forwarded-Encrypted: i=1; AJvYcCURdoY3qlruNVy3nLBvRv+nHVwRVnaqeQp4f80mZ/00abwFu0X0cJzn0uXLzQFy9oj4KY7zKBO0yZiBHEISCm0Okw==@vger.kernel.org, AJvYcCWRx/Wbj4bK8JitSNOFjvU9wigxxCO/gLYKZ2K0IcMlI57lx9Q7oxWedo4w0wZfu0EfLUCIV6pkBrEMj1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5naGPz0KpktKuGnarjKHWCcHpRVYjq0xl5eNfE34trksqczp9
	4ZTg93qFW9cj/+yyatWF9pDewPPh96g5L5oa/Bto7OmRjt0IN8HI
X-Google-Smtp-Source: AGHT+IFGXDFRw5VzdW5zdoyd7BG1p/ClFVmdN+5eYllG2ePkcd0IhsdwnjOR6L1/7bnpjJ2gHWN1Kg==
X-Received: by 2002:a05:6a20:cf8d:b0:1c4:9f31:ac8f with SMTP id adf61e73a8af0-1cc89ee960emr13469666637.37.1724750436768;
        Tue, 27 Aug 2024 02:20:36 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:ab14:280:f82b:883b:12eb:74c7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d6136fdaeasm11523939a91.7.2024.08.27.02.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:20:36 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 2/2] perf trace: Use pid to index perf_event in BPF
Date: Tue, 27 Aug 2024 17:20:13 +0800
Message-Id: <20240827092013.1596-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240827092013.1596-1-howardchu95@gmail.com>
References: <20240827092013.1596-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, perf trace -p <PID> is broken for some syscalls. This patch
fixes the it.

Before:
perf $ perf trace -e open -p 79768
         ? (         ):  ... [continued]: open())                                             = -1 ENOENT (No such file or directory)
         ? (         ):  ... [continued]: open())                                             = -1 ENOENT (No such file or directory)
         ? (         ):  ... [continued]: open())                                             = -1 ENOENT (No such file or directory)

After:
perf $ ./perf trace -e open -p 79768
     0.000 ( 0.019 ms): open(filename: "DINGZHEN", flags: WRONLY)                             = -1 ENOENT (No such file or directory)
  1000.187 ( 0.031 ms): open(filename: "DINGZHEN", flags: WRONLY)                             = -1 ENOENT (No such file or directory)
  2000.377 ( 0.019 ms): open(filename: "DINGZHEN", flags: WRONLY)                             = -1 ENOENT (No such file or directory)

This is because when using -p <PID> in perf trace, we mmap the pids
instead of cpus. But in BPF, we tend to use a per-cpu mapped perf_event
to output the augmented data (such as using BPF_F_CURRENT_CPU). That
means the index for perf_event map is cpu.

When we are using -p <PID>, there is "cpu = -1, pid = <PID>".

perf_event_map
[-1]  =  target_perf_event_of_this_pid

This -1 index will never work in BPF. So my original solution is to map
every cpu on this single pid, which is:

perf_event_map
[0]   =  target_perf_event_of_this_pid
[1]   =  target_perf_event_of_this_pid
[2]   =  target_perf_event_of_this_pid
[3]   =  target_perf_event_of_this_pid

But that will cause <number-of-pid> * <number-of-cpu> times
sys_perf_event_open.

So Namhyung's solution is to introduce a new map. I call it
pid2perf_event.

pid2perf_event_map
[pid] = perf_event_index

and then:

perf_event_map
[perf_event_index] = target_perf_event_of_this_pid

we use pid to get the correct index in perf_event map, and
retrieve the correct perf_event using this index.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c                    | 55 +++++++++++++++----
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 33 +++++++++--
 tools/perf/util/evlist.c                      |  2 +-
 3 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d38e0b919e8e..f9ff65c3d4d2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3920,6 +3920,7 @@ static int trace__set_allowed_pids(struct trace *trace)
 	struct strlist *pids_slist = strlist__new(trace->opts.target.pid, NULL);
 
 	trace->skel->bss->task_specific = false;
+	trace->skel->bss->is_workload = false;
 
 	if (pids_slist) {
 		strlist__for_each_entry(pos, pids_slist) {
@@ -3944,6 +3945,7 @@ static int trace__set_allowed_pids(struct trace *trace)
 			return err;
 
 		trace->skel->bss->task_specific = true;
+		trace->skel->bss->is_workload = true;
 	}
 
 	strlist__delete(pids_slist);
@@ -4321,18 +4323,49 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_error_open;
 #ifdef HAVE_BPF_SKEL
 	if (trace->syscalls.events.bpf_output) {
-		struct perf_cpu cpu;
+		if (trace->opts.target.pid) {
+			/*
+			 * perf_event map is supposed to be a cpu to perf_event mapping, which is
+			 * different from which when we specified -p, with cpu = -1, pid = <PID>.
+			 * In this case, we treat perf_event map as an array and ignore the cpu
+			 * mapping side of it, and use pid to retrieve the correct index to its
+			 * corresponding perf_event.
+			 */
+			int j = 0;
+			struct perf_thread_map *threads;
+			struct evsel *evsel_aug_sys = evlist__find_evsel_by_str(trace->evlist, "__augmented_syscalls__");
 
-		/*
-		 * Set up the __augmented_syscalls__ BPF map to hold for each
-		 * CPU the bpf-output event's file descriptor.
-		 */
-		perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events.bpf_output->core.cpus) {
-			bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
-					&cpu.cpu, sizeof(int),
-					xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
-						       cpu.cpu, 0),
-					sizeof(__u32), BPF_ANY);
+			if (evsel_aug_sys == NULL)
+				goto out_error;
+
+			threads = evsel_aug_sys->core.threads;
+
+			for (int thread = 0; thread < perf_thread_map__nr(threads); thread++, j++) {
+				pid_t pid = perf_thread_map__pid(threads, thread);
+
+				bpf_map__update_elem(trace->skel->maps.pid2perf_event, &pid, sizeof(pid_t),
+						     &j, sizeof(int), BPF_ANY);
+
+				bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
+						&j, sizeof(int),
+						xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
+							       0, j),
+						sizeof(__u32), BPF_ANY);
+			}
+		} else {
+			struct perf_cpu cpu;
+
+			/*
+			 * Set up the __augmented_syscalls__ BPF map to hold for each
+			 * CPU the bpf-output event's file descriptor.
+			 */
+			perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events.bpf_output->core.cpus) {
+				bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
+						&cpu.cpu, sizeof(int),
+						xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
+							       cpu.cpu, 0),
+						sizeof(__u32), BPF_ANY);
+			}
 		}
 	}
 #endif
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 1ab0a56c8f35..ef8aa0bd2275 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -25,6 +25,7 @@
 #define MAX_CPUS  4096
 
 volatile bool task_specific;
+volatile bool is_workload;
 
 /* bpf-output associated map */
 struct __augmented_syscalls__ {
@@ -90,6 +91,13 @@ struct pids_allowed {
 	__uint(max_entries, 512);
 } pids_allowed SEC(".maps");
 
+struct pid2perf_event {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, int);
+	__uint(max_entries, MAX_CPUS);
+} pid2perf_event SEC(".maps");
+
 /*
  * Desired design of maximum size and alignment (see RFC2553)
  */
@@ -154,6 +162,11 @@ struct beauty_payload_enter_map {
 	__uint(max_entries, 1);
 } beauty_payload_enter_map SEC(".maps");
 
+static pid_t getpid(void)
+{
+	return bpf_get_current_pid_tgid();
+}
+
 static inline struct augmented_args_payload *augmented_args_payload(void)
 {
 	int key = 0;
@@ -168,7 +181,20 @@ static inline int augmented__output(void *ctx, struct augmented_args_payload *ar
 
 static inline int augmented__beauty_output(void *ctx, void *data, int len)
 {
-	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, data, len);
+	/*
+	 * when it's cpu = -1 pid = PID, we look up the perf_event for this PID. Workload is
+	 * per-cpu mapped so we don't do so.
+	 */
+	if (task_specific && !is_workload) {
+		pid_t pid = getpid();
+		u32 *perf_event = bpf_map_lookup_elem(&pid2perf_event, &pid);
+		if (perf_event)
+			return bpf_perf_event_output(ctx, &__augmented_syscalls__, *perf_event, data, len);
+	} else {
+		return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, data, len);
+	}
+
+	return -1;
 }
 
 static inline
@@ -397,11 +423,6 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
 	return 1; /* Failure: don't filter */
 }
 
-static pid_t getpid(void)
-{
-	return bpf_get_current_pid_tgid();
-}
-
 static inline bool should_filter()
 {
 	pid_t pid = getpid();
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f14b7e6ff1dc..ef58a7764318 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1067,7 +1067,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!threads)
 		return -1;
 
-	if (target__uses_dummy_map(target) && !evlist__has_bpf_output(evlist))
+	if (target__uses_dummy_map(target))
 		cpus = perf_cpu_map__new_any_cpu();
 	else
 		cpus = perf_cpu_map__new(target->cpu_list);
-- 
2.46.0

