Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA61C173D
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272321; cv=none; b=tkpi6EPjVn/HzXxZ5Vt3F5vMUscpHfMKbzPOfimhrqKSL5C1XXgIrSHc48+NT7h0/ywKMVGSz48pWW5r4z51LsfuAfMlJMIM784/hC3ZXoxqV/QjEeQcjeym+YwbaulgjY1bu7mK7sD696dQatwnSNNN1cFj1KSG381MIHmM6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272321; c=relaxed/simple;
	bh=Lo4LNHyksZC8Nvy8Ez4rvuVgU4Jy5CO7M+jBaZReBy4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BWZo9VEopKdIBW0g8MmyTpQlN/SxnSY3xu0QbO6Po9FnE9VJ9QDWebHwVmN+EkXt/lOjojH2IG0NM4Xbo4QyZww6XdQ3Io84fccypVzkiAWY4xGOLn/yBhzMDZfT9mNOm9HNS8IJlMK7afh7GCwbaTj+BTdPmzwVzYXorxVp72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjA1IO82; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjA1IO82"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2c7008c05so74714817b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 21:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742272319; x=1742877119; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buUfiIeN4odzNdnVDdtT1UchpiIGiz11qbZtpIeUEUI=;
        b=sjA1IO82cCusKxODlBsm3dl3Ta/CyqwbimsfhqKVovfkh6W+pf6mzVUc6So5YkpwIY
         A/oz5F8hauUYGc28qYclJTWoF3tNrmzH53vLbd3NrU7m4iyTICSXgny12/Fa0c7Q6DMC
         dWJwy4kW315htZwmxzNJ2c0cOfls9uFXR+pnDOwApn9dP2nD75TP7fg+Mm0leaCUZjBf
         z+1LMmA7WXB1dX5iHd/c/Qhyr+pnT9bjadzAsp623J5EBWM8SjrPsFbl/AuTvlDQi/DC
         qY3qPU3N3Hu2R4gMR36013HQ86qEMTooo92FekRNQVTV+u0lq5myBg6Q7aqqTD/3+Uxo
         cIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742272319; x=1742877119;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buUfiIeN4odzNdnVDdtT1UchpiIGiz11qbZtpIeUEUI=;
        b=TiTdhkvdJANzfRwb5FntW/W8Ea+b448T+1mx7+rbW3OAl7BdB7lZcl5HqfrDmoB4/o
         m8daSgEH5nzzJQVmgP25ioymZQJZfzDdqByvvDPIOMjP08MHZnn37Ceu+GLKaV5oErp0
         mTtN761KdJrJZ9r5j0xQeVBslWH1eNOHk0n0Z7wYYP4NaxJD2N2LrhAcn7Giin3yMYq7
         v5vJROtI9I5kpHzE6+E0loKB5UKZGrQVGs7awaWMGxCvsmL463BcXUng+KydHjvKN4+2
         6QYZqEskJ89/ibTBd0YFj1lsNVO+P3lqsYVJKgMbN22c4lo+W8UMAE213PbDJiIotzYy
         G8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVmhEyrJwoBzudCM7MoSLF6d2+NCW3yvPCzDgS377y63U1agOu1Ltw11rzHnPfGB0J1db7T2n16mFMQWASrMNGW@vger.kernel.org
X-Gm-Message-State: AOJu0YzyLoLrG9z257OSz/sROsD6SIWUUnJZcYX9UW1ijnAhuY+24mwx
	ZGKCfTtbP5NTrQpquH3TJ6Y/AexKVhtnxsGwgZEA6EuJL3ZstgBHFWzqT87jM/1RMRKNDEXbbd/
	SuLFwPQ==
X-Google-Smtp-Source: AGHT+IHt0q0AMpyCBE1YLeztKe3QCXP+N1dVHHSbhX67GXrd/iWlfxYQPvguy3gsTKVEfi2oC9xOb5X5Y1Pp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2c8b:b0:6f9:98c3:a191 with SMTP
 id 00721157ae682-6ff45edf246mr71587b3.2.1742272319011; Mon, 17 Mar 2025
 21:31:59 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:31:50 -0700
In-Reply-To: <20250318043151.137973-1-irogers@google.com>
Message-Id: <20250318043151.137973-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318043151.137973-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v2 2/3] perf dso: Use lock annotations to fix asan deadlock
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, James Clark <james.clark@linaro.org>, 
	Yunseong Kim <yskelg@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dso__list_del with address sanitizer and/or reference count checking
will call dso__put that can call dso__data_close reentrantly trying to
lock the dso__data_open_lock and deadlocking. Switch from pthread
mutexes to perf's mutex so that lock checking is performed in debug
builds. Add lock annotations that diagnosed the problem. Release the
dso__data_open_lock around the dso__put to avoid the deadlock.

Change the declaration of dso__data_get_fd to return a boolean,
indicating the fd is valid and the lock is held, to make it compatible
with the thread safety annotations as a try lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dso-data.c              |  4 +-
 tools/perf/util/dso.c                    | 74 +++++++++++++++---------
 tools/perf/util/dso.h                    | 15 +++--
 tools/perf/util/unwind-libunwind-local.c | 16 ++---
 4 files changed, 66 insertions(+), 43 deletions(-)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 5286ae8bd2d7..06be7c5d8495 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -106,9 +106,9 @@ struct test_data_offset offsets[] = {
 /* move it from util/dso.c for compatibility */
 static int dso__data_fd(struct dso *dso, struct machine *machine)
 {
-	int fd = dso__data_get_fd(dso, machine);
+	int fd = -1;
 
-	if (fd >= 0)
+	if (dso__data_get_fd(dso, machine, &fd))
 		dso__data_put_fd(dso);
 
 	return fd;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 7576e8e24838..e0111049f6b0 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -493,11 +493,25 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
 /*
  * Global list of open DSOs and the counter.
  */
+struct mutex _dso__data_open_lock;
 static LIST_HEAD(dso__data_open);
-static long dso__data_open_cnt;
-static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
+static long dso__data_open_cnt GUARDED_BY(_dso__data_open_lock);
 
-static void dso__list_add(struct dso *dso)
+static void dso__data_open_lock_init(void)
+{
+	mutex_init(&_dso__data_open_lock);
+}
+
+static struct mutex *dso__data_open_lock(void) LOCK_RETURNED(_dso__data_open_lock)
+{
+	static pthread_once_t data_open_lock_once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&data_open_lock_once, dso__data_open_lock_init);
+
+	return &_dso__data_open_lock;
+}
+
+static void dso__list_add(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	list_add_tail(&dso__data(dso)->open_entry, &dso__data_open);
 #ifdef REFCNT_CHECKING
@@ -508,11 +522,13 @@ static void dso__list_add(struct dso *dso)
 	dso__data_open_cnt++;
 }
 
-static void dso__list_del(struct dso *dso)
+static void dso__list_del(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	list_del_init(&dso__data(dso)->open_entry);
 #ifdef REFCNT_CHECKING
+	mutex_unlock(dso__data_open_lock());
 	dso__put(dso__data(dso)->dso);
+	mutex_lock(dso__data_open_lock());
 #endif
 	WARN_ONCE(dso__data_open_cnt <= 0,
 		  "DSO data fd counter out of bounds.");
@@ -521,7 +537,7 @@ static void dso__list_del(struct dso *dso)
 
 static void close_first_dso(void);
 
-static int do_open(char *name)
+static int do_open(char *name) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	int fd;
 	char sbuf[STRERR_BUFSIZE];
@@ -548,6 +564,7 @@ char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
 }
 
 static int __open_dso(struct dso *dso, struct machine *machine)
+	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	int fd = -EINVAL;
 	char *root_dir = (char *)"";
@@ -613,6 +630,7 @@ static void check_data_close(void);
  * list/count of open DSO objects.
  */
 static int open_dso(struct dso *dso, struct machine *machine)
+	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	int fd;
 	struct nscookie nsc;
@@ -638,7 +656,7 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
-static void close_data_fd(struct dso *dso)
+static void close_data_fd(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	if (dso__data(dso)->fd >= 0) {
 		close(dso__data(dso)->fd);
@@ -655,12 +673,12 @@ static void close_data_fd(struct dso *dso)
  * Close @dso's data file descriptor and updates
  * list/count of open DSO objects.
  */
-static void close_dso(struct dso *dso)
+static void close_dso(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	close_data_fd(dso);
 }
 
-static void close_first_dso(void)
+static void close_first_dso(void) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	struct dso_data *dso_data;
 	struct dso *dso;
@@ -705,7 +723,7 @@ void reset_fd_limit(void)
 	fd_limit = 0;
 }
 
-static bool may_cache_fd(void)
+static bool may_cache_fd(void) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	if (!fd_limit)
 		fd_limit = get_fd_limit();
@@ -721,7 +739,7 @@ static bool may_cache_fd(void)
  * for opened dso file descriptors. The limit is half
  * of the RLIMIT_NOFILE files opened.
 */
-static void check_data_close(void)
+static void check_data_close(void) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	bool cache_fd = may_cache_fd();
 
@@ -737,12 +755,13 @@ static void check_data_close(void)
  */
 void dso__data_close(struct dso *dso)
 {
-	pthread_mutex_lock(&dso__data_open_lock);
+	mutex_lock(dso__data_open_lock());
 	close_dso(dso);
-	pthread_mutex_unlock(&dso__data_open_lock);
+	mutex_unlock(dso__data_open_lock());
 }
 
 static void try_to_open_dso(struct dso *dso, struct machine *machine)
+	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	enum dso_binary_type binary_type_data[] = {
 		DSO_BINARY_TYPE__BUILD_ID_CACHE,
@@ -784,25 +803,27 @@ static void try_to_open_dso(struct dso *dso, struct machine *machine)
  * returns file descriptor.  It should be paired with
  * dso__data_put_fd() if it returns non-negative value.
  */
-int dso__data_get_fd(struct dso *dso, struct machine *machine)
+bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
 {
+	*fd = -1;
 	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
-		return -1;
+		return false;
 
-	if (pthread_mutex_lock(&dso__data_open_lock) < 0)
-		return -1;
+	mutex_lock(dso__data_open_lock());
 
 	try_to_open_dso(dso, machine);
 
-	if (dso__data(dso)->fd < 0)
-		pthread_mutex_unlock(&dso__data_open_lock);
+	*fd = dso__data(dso)->fd;
+	if (*fd >= 0)
+		return true;
 
-	return dso__data(dso)->fd;
+	mutex_unlock(dso__data_open_lock());
+	return false;
 }
 
 void dso__data_put_fd(struct dso *dso __maybe_unused)
 {
-	pthread_mutex_unlock(&dso__data_open_lock);
+	mutex_unlock(dso__data_open_lock());
 }
 
 bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by)
@@ -954,7 +975,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 {
 	ssize_t ret;
 
-	pthread_mutex_lock(&dso__data_open_lock);
+	mutex_lock(dso__data_open_lock());
 
 	/*
 	 * dso__data(dso)->fd might be closed if other thread opened another
@@ -970,7 +991,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 
 	ret = pread(dso__data(dso)->fd, data, DSO__DATA_CACHE_SIZE, offset);
 out:
-	pthread_mutex_unlock(&dso__data_open_lock);
+	mutex_unlock(dso__data_open_lock());
 	return ret;
 }
 
@@ -1078,7 +1099,7 @@ static int file_size(struct dso *dso, struct machine *machine)
 	struct stat st;
 	char sbuf[STRERR_BUFSIZE];
 
-	pthread_mutex_lock(&dso__data_open_lock);
+	mutex_lock(dso__data_open_lock());
 
 	/*
 	 * dso__data(dso)->fd might be closed if other thread opened another
@@ -1102,7 +1123,7 @@ static int file_size(struct dso *dso, struct machine *machine)
 	dso__data(dso)->file_size = st.st_size;
 
 out:
-	pthread_mutex_unlock(&dso__data_open_lock);
+	mutex_unlock(dso__data_open_lock());
 	return ret;
 }
 
@@ -1611,11 +1632,10 @@ size_t dso__fprintf(struct dso *dso, FILE *fp)
 
 enum dso_type dso__type(struct dso *dso, struct machine *machine)
 {
-	int fd;
+	int fd = -1;
 	enum dso_type type = DSO__TYPE_UNKNOWN;
 
-	fd = dso__data_get_fd(dso, machine);
-	if (fd >= 0) {
+	if (dso__data_get_fd(dso, machine, &fd)) {
 		type = dso__type_fd(fd);
 		dso__data_put_fd(dso);
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 84d5aac666aa..846b74510038 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -232,6 +232,8 @@ DECLARE_RC_STRUCT(dso) {
 	char		 name[];
 };
 
+extern struct mutex _dso__data_open_lock;
+
 /* dso__for_each_symbol - iterate over the symbols of given type
  *
  * @dso: the 'struct dso *' in which symbols are iterated
@@ -653,7 +655,7 @@ void __dso__inject_id(struct dso *dso, const struct dso_id *id);
 int dso__name_len(const struct dso *dso);
 
 struct dso *dso__get(struct dso *dso);
-void dso__put(struct dso *dso);
+void dso__put(struct dso *dso) LOCKS_EXCLUDED(_dso__data_open_lock);
 
 static inline void __dso__zput(struct dso **dso)
 {
@@ -733,8 +735,8 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
  * The current usage of the dso__data_* interface is as follows:
  *
  * Get DSO's fd:
- *   int fd = dso__data_get_fd(dso, machine);
- *   if (fd >= 0) {
+ *   int fd;
+ *   if (dso__data_get_fd(dso, machine, &fd)) {
  *       USE 'fd' SOMEHOW
  *       dso__data_put_fd(dso);
  *   }
@@ -756,9 +758,10 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
  *
  * TODO
 */
-int dso__data_get_fd(struct dso *dso, struct machine *machine);
-void dso__data_put_fd(struct dso *dso);
-void dso__data_close(struct dso *dso);
+bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
+	EXCLUSIVE_TRYLOCK_FUNCTION(true, _dso__data_open_lock);
+void dso__data_put_fd(struct dso *dso) UNLOCK_FUNCTION(_dso__data_open_lock);
+void dso__data_close(struct dso *dso) LOCKS_EXCLUDED(_dso__data_open_lock);
 
 int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 5f4387e2423a..9fb2c1343c7f 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -330,8 +330,7 @@ static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 	int ret, fd;
 
 	if (dso__data(dso)->eh_frame_hdr_offset == 0) {
-		fd = dso__data_get_fd(dso, ui->machine);
-		if (fd < 0)
+		if (!dso__data_get_fd(dso, ui->machine, &fd))
 			return -EINVAL;
 
 		/* Check the .eh_frame section for unwinding info */
@@ -372,8 +371,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 	 *    has to be pointed by symsrc_filename
 	 */
 	if (ofs == 0) {
-		fd = dso__data_get_fd(dso, machine);
-		if (fd >= 0) {
+		if (dso__data_get_fd(dso, machine, &fd) {
 			ofs = elf_section_offset(fd, ".debug_frame");
 			dso__data_put_fd(dso);
 		}
@@ -485,14 +483,16 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 	/* Check the .debug_frame section for unwinding info */
 	if (ret < 0 &&
 	    !read_unwind_spec_debug_frame(dso, ui->machine, &segbase)) {
-		int fd = dso__data_get_fd(dso, ui->machine);
-		int is_exec = elf_is_exec(fd, dso__name(dso));
+		int fd;
 		u64 start = map__start(map);
-		unw_word_t base = is_exec ? 0 : start;
+		unw_word_t base = start;
 		const char *symfile;
 
-		if (fd >= 0)
+		if (dso__data_get_fd(dso, ui->machine, &fd)) {
+			if (elf_is_exec(fd, dso__name(dso)))
+				base = 0;
 			dso__data_put_fd(dso);
+		}
 
 		symfile = dso__symsrc_filename(dso) ?: dso__name(dso);
 
-- 
2.49.0.rc1.451.g8f38331e32-goog

