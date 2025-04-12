Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC582367C9;
	Sat, 12 Apr 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744423016; cv=none; b=VnW0LzFIkdb6ZDUMyaVoOt1j4wn0CdyvZwdk+A8QnyeUxkpwm9N2v/RLooiWg4/Quon5b1VqH/OWK5oGbBooS+ZT6jeLKSwPcYVCahN1FeI+e72k+GSC8TOfscdxPiTdTCWVzEZI3KMmfek2RIwyOpXz3A9f3FKbojG3gv/99NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744423016; c=relaxed/simple;
	bh=1HqxmpwQNL+yZAmp1OIqUOvYqu2NvLOW0oHIjsK/umE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=arY+nUmlMYfESf5BX2m8jmGmYySRsXRsi5ncz01+Bg6OQnOWC89vvy0lYV6FH7HIMzlPiBuipJY6IYQ6ESJe97YxghqPaoBdbKZwaTl0O0RF7qP+o70CygW9Kaw0vTav1nUCF2Jb4fW/FKh/LlPhG9oeuguFBFIj1aqVzIrzB5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emwzM3bG; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emwzM3bG"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fecfae554bso23058817b3.0;
        Fri, 11 Apr 2025 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744423013; x=1745027813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTHrNBkTx/zyCwWcdU7nNOfjQTZuPE32NVflHkU5Nds=;
        b=emwzM3bGchZc/Gx2yDG6nuPmvV1Oqvp125ojYq7DahtnyoOpzmohxQSF+I4BghJfI4
         5l1tqaXZ0kfiBEjnbvGJWwqdcWEeCUlMbQ4fbsAJKvW7DchUfDNC9y3/XtNO2bzlMFm8
         rxy4TZuxImRTejTSalDVfC/saPXKVopy8BrDft9bZUSTt5ekdfF3+3CgpPnOo0pZoney
         f6b2gMATWc2KGtTw2fDqp7RjiAZDUpEh0Tbu2YmiFphuaVovbEHM2//omDzTaRbdMmsF
         HJGrDLjT35O/x8F7LFUnGxCzgt9paDQk/Kpi6rEny5EYWfKKxOFLhJCiN0vXOgSgwwQY
         GgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744423013; x=1745027813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTHrNBkTx/zyCwWcdU7nNOfjQTZuPE32NVflHkU5Nds=;
        b=pcoVLTO4pPGLDZ+KXrWwcncDem10ESR0B1S2FxFPrx/yp8eBh81U28svpj3fGi7UUR
         R91qVUhrBLzIHXt79jr1/AsnuYHY8pI8lr67qjpW6m/ea1KUbEJ4a60muVOoYYZbOjt/
         niFMXV1ULNuCI1EfFlSqW1sIeb3r3xWVO8F+xxR8tkV9QJbAhRJ+oR0pu6iSgpy2ASYX
         gJoqXKLIuU3JtbIH6q4XBM87ljZnk9kvxiMbQkIVLzq4s3DEbEIIS6w0soolcihjEU64
         gf57syKh8If3C4YvmkRqmBn3dpz0ffRvlIQ5A94zKiSCdSrbgBCoBRPsoJVaNDZ440z2
         hUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvEmAVAtjwijw0troEbDLobBcu30ke6ucDEp4GaVx3j/XES9VHi2gYXqWWjYt5IY0WjOPGlK7F21JeIPu/Jj0kIw==@vger.kernel.org, AJvYcCWHyflJoOtTym1APDXkKo+qqMfZQqFNNTILn6e5kXw/apeejJzkhsooCbmGXnfwZIYblujrmJKXjVBn7Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpezVslcK7Rre/9Kt5Da/8vJUrbd33peOmGF0kwIuAMRlZHfgW
	qXmNiMCMqAW6Ud5t527a1M98+7GqqdXTl3IzvctRt6Do/QWz/5uW
X-Gm-Gg: ASbGnct4SuV30uBsmV//pXasOVatLDekhtUTJfTwFigJD/p/r5pJuqhiZGzM0b2KygB
	gGmtfx28R90I94pbaT86+9EGEaXD8HFPkZzH/hSNJBovJsOZOt5yHlf+VpaoRQ1QbyTK56rSm+f
	p+Ngt2zqzaglE87tZNLVUI60KwEGPnYGcgX7e0ZJkgy1/iimr7JxS74mF18yo/luVcXYYi6jnbz
	HxwFQEdxpCSmgCCLmtW/PR6yS7F45bXutTz2pYuKK+NUP3MmRnfhYMleGvtanDmx9y9ieXSnlVZ
	qUiXokvPaTM/9QS8KiQx9jVu0T6ujPZkE2oNhmvkTi4Xpb4=
X-Google-Smtp-Source: AGHT+IElyNBjfL0jF803b4OtSeIRD7x1ewGxgMkp+NLEcz/TGsCZVykDZV3HLzzE0WZVHKLG8zI9hw==
X-Received: by 2002:a05:690c:4b8c:b0:6fd:4849:62ec with SMTP id 00721157ae682-705599cbf61mr81240877b3.12.1744423012885;
        Fri, 11 Apr 2025 18:56:52 -0700 (PDT)
Received: from howard.neu.edu ([50.232.161.101])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e3715d0sm17623287b3.78.2025.04.11.18.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 18:56:52 -0700 (PDT)
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
Subject: [PATCH v2] perf trace: Speed up startup time by bypassing the creation of kernel maps
Date: Fri, 11 Apr 2025 18:56:52 -0700
Message-ID: <20250412015652.245123-1-howardchu95@gmail.com>
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
questions.

[1]: https://lore.kernel.org/linux-perf-users/CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com/

Cc: "Krzysztof Łopatowski" <krzysztof.m.lopatowski@gmail.com>
Suggested-by: "Krzysztof Łopatowski" <krzysztof.m.lopatowski@gmail.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
Change in v2:
* Add a Suggested-by tag for Krzysztof

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

