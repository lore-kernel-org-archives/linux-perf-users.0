Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD2C8E0;
	Sat,  5 Apr 2025 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743822741; cv=none; b=df3o+uTxSHKkP+W2PEacFTHEuTPgrsPI9os6i56WUYq6T425V6MRtlXAq0uP3uU7mlZ2uA41JoYlJtYAv5MlH6XQKUnLBvlzhoQv4cdJ10No8gYp3tyUnaRJrdOEZSZ4XOH6GDwj1gPdzsoyX/UhcJYsmD693S0uQopwWidcAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743822741; c=relaxed/simple;
	bh=VGgGPh2VsvYfcOMo2vW3z6LzrYp44V2jkmrZPkzfvz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oXDzHvNJhHlWKhd7k03gU3VUA9Od7sPigfPUAS4pZcXEAKAfnSOo+OnNvUqhOcOA4Fif5luc/fn/ds343zmkCyomeT3LOvDDWg1QPFhnlSlecEdcWfpkGEsZ/3PE5uKEtvWqxUdyeY/cT7jgAZuJf/7qa4STjfXkeHfhobgm3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8XU0BVg; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8XU0BVg"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ecf0e07954so35189446d6.1;
        Fri, 04 Apr 2025 20:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743822738; x=1744427538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QMFI/YdgSQtSX1ODi42VtJ+bjgy/ZFD0RdBy7KOKgO0=;
        b=g8XU0BVgsTZcKiSMf6IZlN/1MthdsDD1ARCEnd4GCvUzS4cbYVNtLPyuxVwoMwW6bL
         nRGOZ79TpThNR3Zn5d7r59/tF/2NOKkXB/FkjrqA3ErnHuDGaI804RlPzXEhPEOCoqta
         ///zTMTPwxC/gbRGPMP+k0vmVdnP13SgkVeF4/xFImZ353ZNdgInh8g0SNtSUQWm74AO
         QUjk7b7Y/Jh3WrSTkkq48ad5zrO/CB3EKzzHtEyLtrtwwcMMnMUl3h4OgOXbeAAVOEdI
         9E4OfS6fvD5Cu4XXUSCaO8izZ9oTyT4WB7IbfIvc0/XLUne+NH0GWdDp762PQkULP5TD
         7LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743822738; x=1744427538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMFI/YdgSQtSX1ODi42VtJ+bjgy/ZFD0RdBy7KOKgO0=;
        b=KtzoIExL0jANEBF1jNJJmiwxIkcUQegCMV+3bFN0nJO7xlEuE0iiAreQsSOyMMmZAB
         fRSE6LgqvXG1Zm/lGu8MCsGKkR8/E/iaIA5Skc0y2DVs//DgmfXPdW8lHPBx/z6NdLNy
         l09OEsjrfI7TZdugcDYuUux2jl6p8omA4K9MyfG5QDOUS0yMwe03jH/I8rG3fdG6NDpr
         MKTpz2aEdm6yCDgMWa2mOIuxQOuXBT6pgvGWCrn4eRcw2OmaIkt1qhK6deT6H+CA15J5
         R1+xLtTnDYB5lZ4Q7edgZjU5RJ8ES/Qo82Sd/0ebwSSRCX+8LPg7aHBicDY231i4Buru
         IsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Xun1684ftOXhGWviKaZV7vnvTgcKg6YL1xo08XetyTPzmgM4tFBqrOpCgA8GaKjCD5OXmx4HRz7q2/Q=@vger.kernel.org, AJvYcCXR84IDk2DLrH0txTvDA/OpvdyKIxTKAxrNPjqk2T6xprGO+1FaYv5JAK+oW9bnQO2Iqrzq3aI7XkAUMhF9VjIoGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9r44VGx3CP1EGQaDLrGCFa53z955p1rFIi6wF9wdb49wKD1N
	jAMVvC6Rgvi0fBgRP5vaeZYVVmpn9LU7B1Jq4AmGv0cp+u6fL9uw
X-Gm-Gg: ASbGncuWEkF3aOCEU08BeDHQw/PJf31sEYPOgHlyTpSRv8zMtPQp9g/UerJngnfuX6D
	J2u/QzGK4CUc9ISL4g2Z1o+WkKHKrBiLB4UjK9miIFw7CRyFhQLuKh7iQRkN09d69h40pZhwOSw
	0pDBXCjJE29RC54+Kw+F/nMAJHSSC8lbh/CmzS2O+A5gEvMT8vYYbIzA5TFXHQzg2QqNkXcHBWl
	Xi4I+SpiSYqJA2AayCjG61Gq4AlWLBEAKWhWo61XbFDCjeKwuU/MCWWKg3nrXkhbCHncD8qY0aq
	/Wq5867EnIw7Epro5u0NONa54Vq1gAr462zJQmj/+6bUtvz9q5dGazMSzR0=
X-Google-Smtp-Source: AGHT+IG9SCiijd5s9anYpfKr0j+IeyyhTDaMtWL9AkRebpEOO0iUBXDtoVsGwQSgm0fURGxsTiWefw==
X-Received: by 2002:a05:6214:404:b0:6e8:fee2:aae4 with SMTP id 6a1803df08f44-6f01e769f7cmr85407006d6.28.1743822738537;
        Fri, 04 Apr 2025 20:12:18 -0700 (PDT)
Received: from howard.neu.edu ([4.53.135.106])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f14e93fsm28616766d6.110.2025.04.04.20.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 20:12:18 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	charlie@rivosinc.com,
	mpetlan@redhat.com,
	vmolnaro@redhat.com,
	linux@treblig.org,
	mhiramat@kernel.org,
	leo.yan@arm.com,
	dima@secretsauce.net,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	krzysztof.m.lopatowski@gmail.com
Subject: [PATCH v1] perf trace: Speed up startup time by bypassing the creation of kernel maps
Date: Fri,  4 Apr 2025 20:12:13 -0700
Message-ID: <20250405031213.3502708-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If perf trace isn't run with '--call-graph' and '--kernel-syscall-graph'
options, e.g.

sudo ./perf trace --call-graph fp --kernel-syscall-graph -a

there is no need for creating kernel maps.

before:

perf $ time sudo ./perf trace -- sleep 1
         ? (         ): sleep/3462908  ... [continued]: execve())                                           = 0
	 ...
  1001.459 (         ): sleep/3463166 exit_group()                                                          = ?

real    0m2.834s
user    0m0.011s
sys     0m0.012s

after:

perf $ time sudo ./perf trace -- sleep 1
         ? (         ): sleep/3459948  ... [continued]: execve())                                           = 0
	 ...
  1001.471 (         ): 3459948 exit_group()                                                          = ?

real    0m1.810s
user    0m0.008s
sys     0m0.015s

I also want to express my gratitude to Krzysztof Łopatowski—his
profiling of the perf trace [1] inspired this patch. I'm not sure why
the discussion stalled, and I apologize for not being able to answer his
questions. Since his findings significantly improve the startup time of
perf trace, I don't want to take credit for that. So Krzysztof, please
let me know if you'd like a Suggested-by: or anything else.

[1]: https://lore.kernel.org/linux-perf-users/CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com/
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: "Krzysztof Łopatowski" <krzysztof.m.lopatowski@gmail.com>
---
 tools/perf/builtin-buildid-list.c     | 2 +-
 tools/perf/builtin-trace.c            | 2 +-
 tools/perf/tests/code-reading.c       | 2 +-
 tools/perf/tests/dlfilter-test.c      | 2 +-
 tools/perf/tests/dwarf-unwind.c       | 2 +-
 tools/perf/tests/mmap-thread-lookup.c | 2 +-
 tools/perf/tests/symbols.c            | 2 +-
 tools/perf/util/machine.c             | 6 +++---
 tools/perf/util/machine.h             | 2 +-
 tools/perf/util/probe-event.c         | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 52dfacaff8e3..357201d8ef0c 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -47,7 +47,7 @@ static void buildid__show_kernel_maps(void)
 {
 	struct machine *machine;
 
-	machine = machine__new_host();
+	machine = machine__new_host(true);
 	machine__for_each_kernel_map(machine, buildid__map_cb, NULL);
 	machine__delete(machine);
 }
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f55a8a6481f2..39f23ce39842 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1963,7 +1963,7 @@ static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
 	if (err)
 		return err;
 
-	trace->host = machine__new_host();
+	trace->host = machine__new_host(callchain_param.enabled && trace->kernel_syscallchains);
 	if (trace->host == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index cf6edbe697b2..17c7b9f95532 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -654,7 +654,7 @@ static int do_test_code_reading(bool try_kcore)
 
 	pid = getpid();
 
-	machine = machine__new_host();
+	machine = machine__new_host(true);
 	machine->env = &perf_env;
 
 	ret = machine__create_kernel_maps(machine);
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 54f59d1246bc..11f70ebabacf 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -352,7 +352,7 @@ static int test__dlfilter_test(struct test_data *td)
 		return test_result("Failed to find program symbols", TEST_FAIL);
 
 	pr_debug("Creating new host machine structure\n");
-	td->machine = machine__new_host();
+	td->machine = machine__new_host(true);
 	td->machine->env = &perf_env;
 
 	td->fd = creat(td->perf_data_file_name, 0644);
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 4803ab2d97ba..b76712f68403 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -203,7 +203,7 @@ noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 	struct thread *thread;
 	int err = -1;
 
-	machine = machine__new_host();
+	machine = machine__new_host(true);
 	if (!machine) {
 		pr_err("Could not get machine\n");
 		return -1;
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index ddd1da9a4ba9..194b5affaa41 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -167,7 +167,7 @@ static int mmap_events(synth_cb synth)
 	 */
 	TEST_ASSERT_VAL("failed to create threads", !threads_create());
 
-	machine = machine__new_host();
+	machine = machine__new_host(true);
 
 	dump_trace = verbose > 1 ? 1 : 0;
 
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index ee20a366f32f..6b22a451211a 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -19,7 +19,7 @@ struct test_info {
 
 static int init_test_info(struct test_info *ti)
 {
-	ti->machine = machine__new_host();
+	ti->machine = machine__new_host(true);
 	if (!ti->machine) {
 		pr_debug("machine__new_host() failed!\n");
 		return TEST_FAIL;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 55d4977b9913..b1828e3922f2 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -125,14 +125,14 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	return 0;
 }
 
-struct machine *machine__new_host(void)
+struct machine *machine__new_host(bool create_kmaps)
 {
 	struct machine *machine = malloc(sizeof(*machine));
 
 	if (machine != NULL) {
 		machine__init(machine, "", HOST_KERNEL_ID);
 
-		if (machine__create_kernel_maps(machine) < 0)
+		if (create_kmaps && machine__create_kernel_maps(machine) < 0)
 			goto out_delete;
 
 		machine->env = &perf_env;
@@ -146,7 +146,7 @@ struct machine *machine__new_host(void)
 
 struct machine *machine__new_kallsyms(void)
 {
-	struct machine *machine = machine__new_host();
+	struct machine *machine = machine__new_host(true);
 	/*
 	 * FIXME:
 	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitly
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index ae3e5542d57d..e6faf8cd06e7 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -163,7 +163,7 @@ struct thread *machine__findnew_guest_code(struct machine *machine, pid_t pid);
 void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size);
 void machines__set_comm_exec(struct machines *machines, bool comm_exec);
 
-struct machine *machine__new_host(void);
+struct machine *machine__new_host(bool create_kmaps);
 struct machine *machine__new_kallsyms(void);
 int machine__init(struct machine *machine, const char *root_dir, pid_t pid);
 void machine__exit(struct machine *machine);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 307ad6242a4e..6b5b5542f454 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -94,7 +94,7 @@ int init_probe_symbol_maps(bool user_only)
 	if (symbol_conf.vmlinux_name)
 		pr_debug("Use vmlinux: %s\n", symbol_conf.vmlinux_name);
 
-	host_machine = machine__new_host();
+	host_machine = machine__new_host(true);
 	if (!host_machine) {
 		pr_debug("machine__new_host() failed.\n");
 		symbol__exit();
-- 
2.45.2

