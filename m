Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71EF1FE455;
	Fri, 30 May 2025 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748586255; cv=none; b=ntZkn1TtXHFVUaIOyKC8KGf0weAE93vn9wNbm6T9CKfZhzboEqYyqpziaUYF70txKPqFy+1DxGIBjGwSOaQOXMplWRZw5475oko5xHfoT8xGeCK1DTFT5pbAyTJYqY1f7YRen+9AKqER5HQZBAomeV5xdfR3HDe79zIMAvoOh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748586255; c=relaxed/simple;
	bh=OYvYPHL2WgbBwyBOJ5/Dnn15RG6NScDVsfeRryDXXlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6C92hdlsKIdeDuEmt69xQVP3P7VokJTO7I//WRYnLfe6Kzp6XC2h5YsxlWvXTHHAnGuE2AZfui5AyCvCdOyFYmvfAbN5d2otzp9A4bW52LH0+oWh4bdyxv2tTEa01FYqvoJF5tv01N5jJyT2eY1bQciAfkY08wvx4PoY6xO8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJEY/BEb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJEY/BEb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23228b9d684so19161645ad.1;
        Thu, 29 May 2025 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748586253; x=1749191053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KAmaZGstt+itlsylRoWzIqpr+NCv8aQmcMmtle5two=;
        b=HJEY/BEb7ezVjwEGN4pLH/lOPhm8fxnAfEwZelvdijcQcpUsDqS/JhteZ0pHVnRhrR
         c0vdz9ifVp66vNqcFs9jbMOWjBW9oU0EsLixAz9eeBp5lZpnkrp9Ahv8GTnz5oYeRlsD
         E7Fm9G7sa1Bd6ICvldx5LJtxN3B91LZBYgc3Vh3fVEPphnf0vpidxPRcmpw86ZUiiF5t
         BbkSB/ZZU8odThuTgQlbiz1Me43+qzDHsWXO9u8PkZfOkD36ELprdWn4OUF14qZo6TY7
         YW5OBlxb606YfCTrscwZOG34aqu3xoBhvkjGzNDzrsbgXKlmYv6uZBzyQjbK8F+URW+1
         5Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748586253; x=1749191053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KAmaZGstt+itlsylRoWzIqpr+NCv8aQmcMmtle5two=;
        b=GLa4DHVWEgJ1IZ0spOuXbNB9RwIeVAJPWjhY20M5fO5q0N0XwtC+ad2WqcaxcedPZb
         prscXuMxooXj57PeTjfJ98WykgepjRRjvUJNply/MpOGKUNPauuklXJ7sd4yH7iPNY6C
         Lji++4JC/Z8UgnI0kJUatSRqECflz/nXbDr9D6m0qI5wKmHnMnyEZQwv9F32UhrO8mMl
         v4IvZxNi6oq3tpAOUJtn1Ow3zsp1DmYCSZOapC/uYtJJt8o+/yRpNCkJXk33kUZbTft9
         1b7pp+jmdIGaZM9tPSQtbRt4j9l0h1tzNb+DDktaNLvjwhwOSyDX2GTHlHmP32EforAc
         9dOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXFUYO6VkQOc6D83bZD7qqI7taGMGn+0MrSBgHH790mSW7Vm0Sw5YVSAoPNuATkY8p8/L5fWUiKayljLtLLgGJfQ==@vger.kernel.org, AJvYcCW5aH73aqYl48yZhxKFRl4Gv+48lH4y8xV/rYEY1eq3OEZjWMfPBZCWyKVnE+shgDV5qKR3odIxyFEoT34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJBWXjUdY6NztgakeKxfk8eDYPCX8LbnwiikaX7Co1YMd+R6Nq
	+nBgrZly7WgqzpLGtjtI+az1gB1UatHLngRkgX+xehEzyv5zwJzqZOJe
X-Gm-Gg: ASbGncvrKGp8ENwTihXYQFUhuGxkicutQDkoFEVirCI8UpF37Yl0jkuGmkb5jQYez24
	L+7IxJAPEJtNtrhGO8b2PKIz5QqTpehq6e03hJinyic7W8RCTrPe7a9IWxgxGiZujitXp6Jns5j
	JYZKmwbNpf9i80eg1bbvzQdkhnRmqVfQCvtyJNwB00f4Jz3friMXxw4168JSjQZKZOViCNIm7Wu
	/HUTWaybGRlXQkaAS9Qg5xCbek868cNeJd5wLCR7t5zF7BVseeAYq1Wt9ek0IvaIzfvW4RaJBvo
	2T0KMBCz6ulaDPgyNHXUctlouQhTUn2+hKzwxNr6tTQdVAwTyZhf42pBIUCtCvSy4bdlFibbW3w
	pGrHv47kEpks=
X-Google-Smtp-Source: AGHT+IHzeXymVD09NDmgEKtmmFolex8pa6fKmlGntRYRQoFBZckRRqq//lmcpdxVzsrHkeSypRcJCA==
X-Received: by 2002:a17:903:190:b0:234:c2e7:a0d0 with SMTP id d9443c01a7336-23538ed0117mr17467805ad.5.1748586252854;
        Thu, 29 May 2025 23:24:12 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb6857sm757498a12.73.2025.05.29.23.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 23:24:12 -0700 (PDT)
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
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 1/2] perf trace: Enhance task filtering
Date: Thu, 29 May 2025 23:24:07 -0700
Message-ID: <20250530062408.1438861-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250530062408.1438861-1-howardchu95@gmail.com>
References: <20250530062408.1438861-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch does two things:
1. Add a pids_targeted map, put pids that interest perf trace in.
2. Make bpf-output event system-wide.

Effect 1:
perf trace doesn't augment threads properly. With the script below:

Program test_trace_loop.c
~~~
    #include <pthread.h>
    #include <stdio.h>
    #include <unistd.h>
    #include <stdlib.h>

    #define THREAD_NR 2

    struct thread_arg {
	    int index;
    };

    void *func(void *arg) {
	    struct thread_arg *t_arg = arg;
	    while (1) {
		    printf("thread %d running\n", t_arg->index);
		    sleep(1);
	    }
	    return NULL;
    }

    int main()
    {
	    pthread_t thread_ids[THREAD_NR];
	    struct thread_arg thread_args[THREAD_NR];

	    for (int i = 0; i < THREAD_NR; i++) {
		    thread_args[i].index = i;
		    if (pthread_create(&thread_ids[i], NULL, &func, &thread_args[i])) {
			    perror("failed to create thread, exiting\n");
			    exit(1);
		    }
	    }

	    while (1) {
		    printf("parent sleeping\n");
		    sleep(1);
	    }

	    for (int i = 0; i < THREAD_NR; i++)
		    pthread_join(thread_ids[i], NULL);

	    return 0;
    }
~~~

Commands
~~~
$ gcc test_trace_loop.c -o test_trace_loop

$ ./test_trace_loop &
[1] 1404183

$ pstree 1404183 -p
test_trace_loop(1404183)─┬─{test_trace_loop}(1404185)
                         └─{test_trace_loop}(1404186)

$ sudo perf trace -p 1404183 -e *sleep
~~~

Output
before:
$ sudo /tmp/perf/perf trace -p 1404183 -e *sleep
         ? (         ): test_trace_loo/1404186  ... [continued]: clock_nanosleep())                                  = 0
         ? (         ): test_trace_loo/1404183  ... [continued]: clock_nanosleep())                                  = 0
     0.119 (         ): test_trace_loo/1404186 clock_nanosleep(rqtp: 0x7a86061fde60, rmtp: 0x7a86061fde60)        ...
         ? (         ): test_trace_loo/1404185  ... [continued]: clock_nanosleep())                                  = 0
     0.047 (         ): test_trace_loo/1404183 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd89091450) ...
     0.047 (1000.127 ms): test_trace_loo/1404183  ... [continued]: clock_nanosleep())                                  = 0

explanation: only the parent thread 1404183 got augmented

after:
$ sudo /tmp/perf/perf trace -p 1404183 -e *sleep
         ? (         ): test_trace_loo/1404183  ... [continued]: clock_nanosleep())                                  = 0
         ? (         ): test_trace_loo/1404186  ... [continued]: clock_nanosleep())                                  = 0
     0.147 (         ): test_trace_loo/1404186 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7a86061fde60) ...
         ? (         ): test_trace_loo/1404185  ... [continued]: clock_nanosleep())                                  = 0
     0.076 (         ): test_trace_loo/1404183 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd89091450) ...
     0.076 (1000.160 ms): test_trace_loo/1404183  ... [continued]: clock_nanosleep())                                  = 0
     0.147 (1000.090 ms): test_trace_loo/1404186  ... [continued]: clock_nanosleep())                                  = 0
     2.557 (         ): test_trace_loo/1404185 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7a86069fee60) ...
  1000.323 (         ): test_trace_loo/1404186 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7a86061fde60) ...
     2.557 (1000.129 ms): test_trace_loo/1404185  ... [continued]: clock_nanosleep())                                  = 0
  1000.384 (         ): test_trace_loo/1404183 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd89091450) ...

explanation: all threads augmented

Effect 2: perf trace doesn't collect syscall argument data for *ALL*
pids, and throw it away anymore. Those uninteresting pids get filtered
right away. There should be a performance advantage.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c                    | 52 ++++++++++++++++---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 35 ++++++++++---
 tools/perf/util/evlist.c                      |  2 +-
 3 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 67b557ec3b0d..11620cb40198 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4377,6 +4377,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	unsigned long before;
 	const bool forks = argc > 0;
 	bool draining = false;
+	bool enable_evlist = false;
 
 	trace->live = true;
 
@@ -4447,6 +4448,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		evlist__set_default_cgroup(trace->evlist, trace->cgroup);
 
 create_maps:
+	if (trace->syscalls.events.bpf_output)
+		trace->syscalls.events.bpf_output->core.system_wide = true;
+
 	err = evlist__create_maps(evlist, &trace->opts.target);
 	if (err < 0) {
 		fprintf(trace->output, "Problems parsing the target to trace, check your options!\n");
@@ -4481,20 +4485,54 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_error_open;
 #ifdef HAVE_BPF_SKEL
 	if (trace->syscalls.events.bpf_output) {
+		struct perf_evsel *perf_evsel = &trace->syscalls.events.bpf_output->core;
 		struct perf_cpu cpu;
+		bool t = true;
+
+		enable_evlist = true;
+		if (trace->opts.target.system_wide)
+			trace->skel->bss->system_wide = true;
+		else
+			trace->skel->bss->system_wide = false;
 
 		/*
 		 * Set up the __augmented_syscalls__ BPF map to hold for each
 		 * CPU the bpf-output event's file descriptor.
 		 */
-		perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events.bpf_output->core.cpus) {
+		perf_cpu_map__for_each_cpu(cpu, i, perf_evsel->cpus) {
 			int mycpu = cpu.cpu;
 
-			bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
-					&mycpu, sizeof(mycpu),
-					xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
-						       mycpu, 0),
-					sizeof(__u32), BPF_ANY);
+			err = bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
+						   &mycpu, sizeof(mycpu),
+						   xyarray__entry(perf_evsel->fd, mycpu, 0),
+						   sizeof(__u32), BPF_ANY);
+			if (err) {
+				pr_err("Couldn't set system-wide bpf output perf event fd"
+				       ", err: %d\n", err);
+				goto out_disable;
+			}
+		}
+
+		if (target__has_task(&trace->opts.target)) {
+			struct perf_thread_map *threads = trace->evlist->core.threads;
+
+			for (int thread = 0; thread < perf_thread_map__nr(threads); thread++) {
+				pid_t pid = perf_thread_map__pid(threads, thread);
+
+				err = bpf_map__update_elem(trace->skel->maps.pids_targeted, &pid,
+							   sizeof(pid), &t, sizeof(t), BPF_ANY);
+				if (err) {
+					pr_err("Couldn't set pids_targeted map, err: %d\n", err);
+					goto out_disable;
+				}
+			}
+		} else if (workload_pid != -1) {
+			err = bpf_map__update_elem(trace->skel->maps.pids_targeted, &workload_pid,
+						   sizeof(workload_pid), &t, sizeof(t), BPF_ANY);
+			if (err) {
+				pr_err("Couldn't set pids_targeted map for workload, err: %d\n", err);
+				goto out_disable;
+			}
 		}
 	}
 
@@ -4553,7 +4591,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 			goto out_error_mmap;
 	}
 
-	if (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay)
+	if (enable_evlist || (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay))
 		evlist__enable(evlist);
 
 	if (forks)
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index e4352881e3fa..e517eec7290b 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -26,6 +26,7 @@
 #define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
 
 #define MAX_CPUS  4096
+#define MAX_PIDS  4096
 
 /* bpf-output associated map */
 struct __augmented_syscalls__ {
@@ -113,6 +114,15 @@ struct pids_filtered {
 	__uint(max_entries, 64);
 } pids_filtered SEC(".maps");
 
+volatile bool system_wide;
+
+struct pids_targeted {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, bool);
+	__uint(max_entries, MAX_PIDS);
+} pids_targeted SEC(".maps");
+
 struct augmented_args_payload {
 	struct syscall_enter_args args;
 	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
@@ -145,6 +155,11 @@ struct beauty_payload_enter_map {
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
@@ -418,14 +433,18 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
 	return 1; /* Failure: don't filter */
 }
 
-static pid_t getpid(void)
+static bool filter_pid(void)
 {
-	return bpf_get_current_pid_tgid();
-}
+	if (system_wide)
+		return false;
 
-static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
-{
-	return bpf_map_lookup_elem(pids, &pid) != NULL;
+	pid_t pid = getpid();
+
+	if (bpf_map_lookup_elem(&pids_targeted, &pid) &&
+	    !bpf_map_lookup_elem(&pids_filtered, &pid))
+		return false;
+
+	return true;
 }
 
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
@@ -534,7 +553,7 @@ int sys_enter(struct syscall_enter_args *args)
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
 
-	if (pid_filter__has(&pids_filtered, getpid()))
+	if (filter_pid())
 		return 0;
 
 	augmented_args = augmented_args_payload();
@@ -560,7 +579,7 @@ int sys_exit(struct syscall_exit_args *args)
 {
 	struct syscall_exit_args exit_args;
 
-	if (pid_filter__has(&pids_filtered, getpid()))
+	if (filter_pid())
 		return 0;
 
 	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index dcd1130502df..7b5837c6e6bb 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1012,7 +1012,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!threads)
 		return -1;
 
-	if (target__uses_dummy_map(target) && !evlist__has_bpf_output(evlist))
+	if (target__uses_dummy_map(target))
 		cpus = perf_cpu_map__new_any_cpu();
 	else
 		cpus = perf_cpu_map__new(target->cpu_list);
-- 
2.45.2

