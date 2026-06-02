Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC053A7587
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381521; cv=none; b=ikXM0moqABNjLukjDF5lKmQSD7Fl+uSQ1hE8HaNJtN/JGD/gE/KF0XsF/kGicScPdR4Gf4doviVPbopKwXgm7QfgGsWDm69jzHq5tM3Le/E8z3Z2orUTT97evEZZ151xo6CR836yKfFdrVlUkrYrjW7WAnk25Jzxkj6bvzvZUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381521; c=relaxed/simple;
	bh=azv2pBu2JzgGiyYsHqFDUXP8g7tfdhTUd7ip2wDqkv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d/aDqpUXbt20KwwcRdAij9NIiPAue5F6DdI0ZT2QoEY719mSBZ93EO0W3aQG9kicrgHL6wKXkB5gYdKjGKQbupsCjLyCJncaxW6uIIw0O/8sIv/MhtboIi7DgMgzaGHv6VinOHRFLIAa7pjteEQs2ubDBx4SB5MMQZ2G8Tn/EUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWYmEmQS; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWYmEmQS"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d8613efbso5500249eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Jun 2026 23:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381518; x=1780986318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0xbxLEfFS6BKwiC2R63DBW2gx2OwZfI2gcRMPfbI9Q=;
        b=YWYmEmQSCawjcOrSpYxlGL3ey8ScyKHbVaw+eJ71pXrz18asl3yic4wlQDP8EzxL5p
         bDAudD1xya5kQZX3QO0AJJsUPJr0VPMoSQb4mMo4OiFNOewOWcscDRR/pUvaxYjfTPDv
         SDarugTdRKN9hQp6+r3U+lApMCEh744LWMhi6pvsgWmJjWalgi+evjo1c5a0QzjcoPvs
         hXEqmecm8pWKvkC1mQbWUgdZXst+E2Mc4knQ+Rhb7MQHmSTd01Bm+M4LgHYJT8FLleg8
         caLwcB2K8jL5p/7N3KS2vtNXxD/bSScpNM/0iCsjnVkNhtgViAJLzZdKSoLC7h7Lb+8F
         ybUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381518; x=1780986318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0xbxLEfFS6BKwiC2R63DBW2gx2OwZfI2gcRMPfbI9Q=;
        b=cs8lliTb/Y+YYgC0AAbIq/Itbewe5PIT8IEoy5HBKNb4UEhvHOScRHcTpKu271fRV+
         CkEM+hljiffvG1j/veXWtvcWIZSKs9yTXRgRliPwZnPHa2JFVqILOgWKwmLHyMQAqYh9
         hGilVKBDj99STX7ACKBmlCKRDoLsuHsw7mPEQEIfT0ALdouRmAjFGfElREH6aXp3sACi
         WH1ZHan32FVc7TdQmxaZkWqQmwt/csaSFVfJ5+PaZy00awzxk3JpuoU3UuCIEcq9ab7P
         SQuM9BM+UADHHfRoa/0czSOMkAF+aBOFumupRw4cUmAnPKhoHqW5uvCAf5U3Rjwlp1FK
         1oHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ow21Y2oYTRA5UXXs9zAjPiWSSwEnPElZGDM6GAEsT1WzgRlLkk1T3USg6TbT/mcHI7D2OeqiHn3Wbnmg1hvuH@vger.kernel.org
X-Gm-Message-State: AOJu0YwicMdbNC4eFaSR1Lrkdu5eFD2JCb5E0Nx+RuE7XX+R10uDI2U5
	DmL/uslsbe7lIgEVIDyVo7RZSizAbt0WVozOBQ/+Jop3b7KjfY70e5LDe+xEmVc6nwWsk7BbV+8
	jXILcgiI4gw==
X-Received: from dlbuu12.prod.google.com ([2002:a05:7022:7e8c:b0:135:da3e:b81])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f502:b0:137:ddaf:7e89
 with SMTP id a92af1059eb24-137ddaf7f47mr2527507c88.15.1780381517292; Mon, 01
 Jun 2026 23:25:17 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:35 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-4-irogers@google.com>
Subject: [PATCH v11 03/19] perf env, dso, thread: Add _endian variants for
 e_machine helpers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add perf_arch_is_big_endian(), dso__read_e_machine_endian(),
dso__e_machine_endian(), and thread__e_machine_endian() to support
bi-endianness and cross-architecture analysis without breaking the
existing API.

These helpers allow querying the absolute endianness of a DSO or
thread, which is required for tools like Capstone that need to set the
correct disassembly mode.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c    | 19 ++++++++-----
 tools/perf/util/dso.h    | 14 ++++++++--
 tools/perf/util/env.c    | 16 +++++++++++
 tools/perf/util/env.h    |  1 +
 tools/perf/util/thread.c | 58 ++++++++++++++++++++++++++++++----------
 tools/perf/util/thread.h | 23 +++++++++++++++-
 6 files changed, 108 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index b791e1b6b2cf..7dced896c64e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1220,7 +1220,8 @@ static enum dso_swap_type dso_swap_type__from_elf_data(unsigned char eidata)
 }
 
 /* Reads e_machine from fd, optionally caching data in dso. */
-uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags)
+uint16_t dso__read_e_machine_endian(struct dso *optional_dso, int fd, uint32_t *e_flags,
+				    bool *is_big_endian)
 {
 	uint16_t e_machine = EM_NONE;
 	unsigned char e_ident[EI_NIDENT];
@@ -1250,6 +1251,9 @@ uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags
 	if (swap_type == DSO_SWAP__UNSET)
 		return EM_NONE; // Bad ELF data encoding.
 
+	if (is_big_endian)
+		*is_big_endian = (e_ident[EI_DATA] == ELFDATA2MSB);
+
 	/* Cache the need for swapping. */
 	if (optional_dso) {
 		assert(dso__needs_swap(optional_dso) == DSO_SWAP__UNSET ||
@@ -1288,7 +1292,8 @@ uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags
 	return e_machine;
 }
 
-uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_flags)
+uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_t *e_flags,
+			       bool *is_big_endian)
 {
 	uint16_t e_machine = EM_NONE;
 	int fd;
@@ -1308,9 +1313,11 @@ uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_fl
 	case DSO_BINARY_TYPE__BPF_IMAGE:
 	case DSO_BINARY_TYPE__OOL:
 	case DSO_BINARY_TYPE__JAVA_JIT:
-		if (e_flags)
-			*e_flags = EF_HOST;
-		return EM_HOST;
+		if (is_big_endian) {
+			*is_big_endian = perf_arch_is_big_endian(
+				machine && machine->env ? perf_env__arch(machine->env) : NULL);
+		}
+		return perf_env__e_machine(machine ? machine->env : NULL, e_flags);
 	case DSO_BINARY_TYPE__DEBUGLINK:
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
@@ -1338,7 +1345,7 @@ uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_fl
 	try_to_open_dso(dso, machine);
 	fd = dso__data(dso)->fd;
 	if (fd >= 0)
-		e_machine = dso__read_e_machine(dso, fd, e_flags);
+		e_machine = dso__read_e_machine_endian(dso, fd, e_flags, is_big_endian);
 	else if (e_flags)
 		*e_flags = 0;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ede691e9a249..2916b954a804 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -866,8 +866,18 @@ int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size);
-uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags);
-uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_flags);
+uint16_t dso__read_e_machine_endian(struct dso *optional_dso, int fd, uint32_t *e_flags,
+				    bool *is_big_endian);
+static inline uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags)
+{
+	return dso__read_e_machine_endian(optional_dso, fd, e_flags, NULL);
+}
+uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_t *e_flags,
+			       bool *is_big_endian);
+static inline uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_flags)
+{
+	return dso__e_machine_endian(dso, machine, e_flags, NULL);
+}
 ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 			    struct machine *machine, u64 addr,
 			    u8 *data, ssize_t size);
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 0cd23b5fc651..fae70b07ba8d 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -342,6 +342,22 @@ int perf_env__kernel_is_64_bit(struct perf_env *env)
 	return env->kernel_is_64_bit;
 }
 
+bool perf_arch_is_big_endian(const char *arch)
+{
+	if (!arch)
+		return __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__;
+
+	if (str_ends_with(arch, "_be") || !strcmp(arch, "sparc") || !strcmp(arch, "sparc64") ||
+	    !strcmp(arch, "s390") || !strcmp(arch, "s390x") || !strcmp(arch, "powerpc") ||
+	    !strcmp(arch, "ppc") || !strcmp(arch, "ppc64") ||
+	    !strcmp(arch, "mips") || !strcmp(arch, "mips64") || !strcmp(arch, "parisc") ||
+	    !strcmp(arch, "parisc64") || !strcmp(arch, "m68k") ||
+	    !strcmp(arch, "armeb") || !strcmp(arch, "mipseb") || !strcmp(arch, "mips64eb"))
+		return true;
+
+	return false;
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index bde192fd5be5..dd9907dbc345 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -175,6 +175,7 @@ void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version,
 void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
+bool perf_arch_is_big_endian(const char *arch);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index aac9cb75dcf4..ba33c0dfc18f 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -56,6 +56,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread__set_cpu(thread, -1);
 		thread__set_guest_cpu(thread, -1);
 		thread__set_e_machine(thread, EM_NONE);
+		thread__set_e_is_big_endian(thread, false);
 		thread__set_lbr_stitch_enable(thread, false);
 		INIT_LIST_HEAD(thread__namespaces_list(thread));
 		INIT_LIST_HEAD(thread__comm_list(thread));
@@ -429,7 +430,7 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	}
 }
 
-static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags)
+static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags, bool *is_big_endian)
 {
 	char path[6 /* "/proc/" */ + 11 /* max length of pid */ + 5 /* "/exe\0" */];
 	int fd;
@@ -438,7 +439,8 @@ static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags)
 	snprintf(path, sizeof(path), "/proc/%d/exe", pid);
 	fd = open(path, O_RDONLY);
 	if (fd >= 0) {
-		e_machine = dso__read_e_machine(/*optional_dso=*/NULL, fd, e_flags);
+		e_machine = dso__read_e_machine_endian(/*optional_dso=*/NULL, fd, e_flags,
+						       is_big_endian);
 		close(fd);
 	}
 	return e_machine;
@@ -448,6 +450,7 @@ struct thread__e_machine_callback_args {
 	struct machine *machine;
 	uint32_t e_flags;
 	uint16_t e_machine;
+	bool is_big_endian;
 };
 
 static int thread__e_machine_callback(struct map *map, void *_args)
@@ -458,24 +461,38 @@ static int thread__e_machine_callback(struct map *map, void *_args)
 	if (!dso)
 		return 0; // No dso, continue search.
 
-	args->e_machine = dso__e_machine(dso, args->machine, &args->e_flags);
+	args->e_machine =
+		dso__e_machine_endian(dso, args->machine, &args->e_flags, &args->is_big_endian);
 	return args->e_machine != EM_NONE ? 1 /* stop search */ : 0 /* continue search */;
 }
 
-uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint32_t *e_flags)
+uint16_t thread__e_machine_endian(struct thread *thread, struct machine *machine, uint32_t *e_flags,
+				  bool *is_big_endian)
 {
 	pid_t tid, pid;
-	uint16_t e_machine = RC_CHK_ACCESS(thread)->e_machine;
+	uint16_t e_machine;
 	uint32_t local_e_flags = 0;
-	struct thread__e_machine_callback_args args = {
-		.machine = machine,
-		.e_flags = 0,
-		.e_machine = EM_NONE,
-	};
+	struct thread__e_machine_callback_args args;
+
+	if (!thread) {
+		if (is_big_endian) {
+			*is_big_endian = perf_arch_is_big_endian(
+				machine && machine->env ? perf_env__arch(machine->env) : NULL);
+		}
+		return perf_env__e_machine(machine ? machine->env : NULL, e_flags);
+	}
+
+	e_machine = RC_CHK_ACCESS(thread)->e_machine;
+	args.machine = machine;
+	args.e_flags = 0;
+	args.e_machine = EM_NONE;
+	args.is_big_endian = false;
 
 	if (e_machine != EM_NONE) {
 		if (e_flags)
 			*e_flags = thread__e_flags(thread);
+		if (is_big_endian)
+			*is_big_endian = thread__e_is_big_endian(thread);
 		return e_machine;
 	}
 
@@ -483,6 +500,7 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 		struct maps *maps = thread__maps(thread);
 
 		machine = maps__machine(maps);
+		args.machine = machine;
 	}
 	tid = thread__tid(thread);
 	pid = thread__pid(thread);
@@ -490,7 +508,8 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 		struct thread *parent = machine__findnew_thread(machine, pid, pid);
 
 		if (parent) {
-			e_machine = thread__e_machine(parent, machine, &local_e_flags);
+			e_machine = thread__e_machine_endian(parent, machine, &local_e_flags,
+							     &args.is_big_endian);
 			thread__put(parent);
 			goto out;
 		}
@@ -515,16 +534,27 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 			is_live = !!session->data;
 		}
 		/* Read from /proc/pid/exe if live. */
-		if (is_live)
-			e_machine = read_proc_e_machine_for_pid(pid, &local_e_flags);
+		if (is_live) {
+			e_machine = read_proc_e_machine_for_pid(pid, &local_e_flags,
+								&args.is_big_endian);
+		} else if (machine && machine->env) {
+			/* Offline analysis: fallback to environment metadata. */
+			e_machine = perf_env__e_machine(machine->env, &local_e_flags);
+			args.is_big_endian = perf_arch_is_big_endian(perf_env__arch(machine->env));
+		}
 	}
 out:
 	if (e_machine != EM_NONE) {
-		thread__set_e_machine(thread, e_machine);
 		thread__set_e_flags(thread, local_e_flags);
+		thread__set_e_is_big_endian(thread, args.is_big_endian);
+		thread__set_e_machine(thread, e_machine);
+		if (is_big_endian)
+			*is_big_endian = args.is_big_endian;
 	} else {
 		e_machine = EM_HOST;
 		local_e_flags = EF_HOST;
+		if (is_big_endian)
+			*is_big_endian = (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__);
 	}
 	if (e_flags)
 		*e_flags = local_e_flags;
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index f5792d3e8a16..d82fce8173ae 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -69,6 +69,11 @@ DECLARE_RC_STRUCT(thread) {
 	 * computed.
 	 */
 	uint16_t		e_machine;
+	/**
+	 * @e_is_big_endian: True if the ELF architecture of the thread is big endian.
+	 * Valid if e_machine != EM_NONE.
+	 */
+	bool			e_is_big_endian;
 	/* LBR call stack stitch */
 	bool			lbr_stitch_enable;
 	struct lbr_stitch	*lbr_stitch;
@@ -311,7 +316,13 @@ static inline void thread__set_filter_entry_depth(struct thread *thread, int dep
 	RC_CHK_ACCESS(thread)->filter_entry_depth = depth;
 }
 
-uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint32_t *e_flags);
+uint16_t thread__e_machine_endian(struct thread *thread, struct machine *machine, uint32_t *e_flags,
+				  bool *is_big_endian);
+static inline uint16_t thread__e_machine(struct thread *thread, struct machine *machine,
+					 uint32_t *e_flags)
+{
+	return thread__e_machine_endian(thread, machine, e_flags, NULL);
+}
 
 static inline void thread__set_e_machine(struct thread *thread, uint16_t e_machine)
 {
@@ -328,6 +339,16 @@ static inline void thread__set_e_flags(struct thread *thread, uint32_t e_flags)
 	RC_CHK_ACCESS(thread)->e_flags = e_flags;
 }
 
+static inline bool thread__e_is_big_endian(const struct thread *thread)
+{
+	return RC_CHK_ACCESS(thread)->e_is_big_endian;
+}
+
+static inline void thread__set_e_is_big_endian(struct thread *thread, bool is_big_endian)
+{
+	RC_CHK_ACCESS(thread)->e_is_big_endian = is_big_endian;
+}
+
 
 static inline bool thread__lbr_stitch_enable(const struct thread *thread)
 {
-- 
2.54.0.929.g9b7fa37559-goog

