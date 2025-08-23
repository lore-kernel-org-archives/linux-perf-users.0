Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C424CEEA
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Aug 2025 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755907244; cv=none; b=SegM6mH/bAuplGIznRgnz23oI2Kn0CU9EOE26uKANIBwgy0IB2cQAh0GarZQuzE5CHqToJyIT9ct9NiLX1AzFOfxnUJYeTeTRFaiERMtDWcj6E9r2r5V0lAl9DZejvJJZXRAI6b++QmPNcHfWxSWu4nKsvCUFAdv1QMSh/Rx0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755907244; c=relaxed/simple;
	bh=NM3DeuEEtAaAuRHK2RaSfe/aDNVsrnZNl/fWVpPhJkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cN4va8+Op8aqyPFNMz8iJihZLEjxGD7sxuXwwQ7Lj2+BI70LI0vmrGW6/ev8I7C1UMKqtgBQyJh1dJo7lDeECwu0F/17c5CP9b3l3CCBNMvKmh34NvawnrgaD4XOsYfnhlQpHfD+ptsv3LOTumHXb/N2GfzUbDCjT/ffHwlJbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Is3HS8RH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Is3HS8RH"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce388so57267945ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755907242; x=1756512042; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouvN9Z/KSAqQFTzs2r7I/5ZrSF7aA646JZI4/Fn2ePU=;
        b=Is3HS8RHwHzdcDRxsbuZpkOAdrKTiVUqrRLGv9Fh9pluxO+BHB7JWd/Ds5T7MHwDVB
         5wpkjBVlsh26UyQOj9dK0OjWBZXD2e1ckRZj0Roq2Jw8lph9CLQvfsH5EhkpaRQlqB5l
         g5+aXurOW8VyXq57IxpocS2XGwv+3raApRn1Ql9LS6QfkILPOLsEr1ak1zrO9HFYeQ/U
         1dpmSNFshX/KikY/Tv1SqOnhJqCxw4n2PNmvevgQ59YYzglyrWI+cRiB4gWIy+Lpql18
         Mt+j7ZNHoaq7ixOTD100kikTILOz62g9LDCMHvdkAlJVscaUo+P8f3MHRmiQwF/vukIG
         Xxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755907242; x=1756512042;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouvN9Z/KSAqQFTzs2r7I/5ZrSF7aA646JZI4/Fn2ePU=;
        b=g9UW8kzdf4HUP46PbOCKA3+ggrbgOb8FQTlxD+BZoBBGB2eRe77rvhQH8zEXdpa9aX
         kRRR4MMTH3ZyBLB9UaPpw1Ns0nB+oQNqGPv9WTzaieYwhbw/rkeCirp5i5ia4h6nUo9g
         wQYmbmJg9n15bhKsdDHkxE0iiKKWpHtOqKmxamqlJwMhSoUZruHMbLn1GJTNs5+lxtu4
         91vGqs3HFIU6WucJN7G71LT4py3qJYpBNoTDT03SLn7ja7oNSThAtj6QmY5ihMuOgVC+
         FCPYkOVtt3JFIuTvgOUD5Bw4CJlbLTqra72U/UlsZvlpY011y4rNHwRnEfoMNp6eXQxY
         UJCg==
X-Forwarded-Encrypted: i=1; AJvYcCW/AjnvS5md3MEk9QCbLzRLROJ88IrGOYgOvw2qZ3VInJmhxk2NNGYuU4KohiEC6IgoB2+d8cvAVF0ATn9snfF+@vger.kernel.org
X-Gm-Message-State: AOJu0YxPD/x+LW2JJoso625Y1SvnJFNC8hALBYXqk5xgq0Ex+hEaAKev
	AVJi6QzyBOn+TRCFDtO62zxyGQJBI4NDIeXTac0zkjegEPaUODaA3asykov+tZBckc+DjbrkHKd
	YF+WX7/OaxQ==
X-Google-Smtp-Source: AGHT+IHBE+a/Nwo51dwHhNmlO51ZDKIzz+BjXguGQZ6jdUmxmLzkgl3rDdG548uoUhX4kHE8w87O0lFUxGRq
X-Received: from plgv17.prod.google.com ([2002:a17:902:e8d1:b0:23f:f68b:fa0c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f44:b0:240:1850:cb18
 with SMTP id d9443c01a7336-2462efaee75mr68904135ad.53.1755907242498; Fri, 22
 Aug 2025 17:00:42 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:00:24 -0700
In-Reply-To: <20250823000024.724394-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823000024.724394-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823000024.724394-3-irogers@google.com>
Subject: [PATCH v1 2/2] perf symbol: Add blocking argument to filename__read_build_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Dmitry Vyukov <dvyukov@google.com>, Song Liu <song@kernel.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When synthesizing build-ids, for build ID mmap2 events, they will be
added for data mmaps if -d/--data is specified. The files opened for
their build IDs may block on the open causing perf to hang during
synthesis. There is some robustness in existing calls to
filename__read_build_id by checking the file path is to a regular
file, which unfortunately fails for symlinks. Rather than adding more
is_regular_file calls, switch filename__read_build_id to take a
"block" argument and specify O_NONBLOCK when this is false. The
existing is_regular_file checking callers and the event synthesis
callers are made to pass false and thereby avoiding the hang.

Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/inject-buildid.c  | 2 +-
 tools/perf/builtin-buildid-cache.c | 8 ++++----
 tools/perf/builtin-inject.c        | 4 ++--
 tools/perf/tests/sdt.c             | 2 +-
 tools/perf/util/build-id.c         | 4 ++--
 tools/perf/util/debuginfo.c        | 8 ++++++--
 tools/perf/util/dsos.c             | 4 ++--
 tools/perf/util/symbol-elf.c       | 9 +++++----
 tools/perf/util/symbol-minimal.c   | 6 +++---
 tools/perf/util/symbol.c           | 8 ++++----
 tools/perf/util/symbol.h           | 2 +-
 tools/perf/util/synthetic-events.c | 2 +-
 12 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index aad572a78d7f..12387ea88b9a 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -85,7 +85,7 @@ static int add_dso(const char *fpath, const struct stat *sb __maybe_unused,
 	if (typeflag == FTW_D || typeflag == FTW_SL)
 		return 0;
 
-	if (filename__read_build_id(fpath, &bid) < 0)
+	if (filename__read_build_id(fpath, &bid, /*block=*/true) < 0)
 		return 0;
 
 	dso->name = realpath(fpath, NULL);
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index c98104481c8a..2e0f2004696a 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -180,7 +180,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 	struct nscookie nsc;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid);
+	err = filename__read_build_id(filename, &bid, /*block=*/true);
 	nsinfo__mountns_exit(&nsc);
 	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
@@ -204,7 +204,7 @@ static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
 	int err;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid);
+	err = filename__read_build_id(filename, &bid, /*block=*/true);
 	nsinfo__mountns_exit(&nsc);
 	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
@@ -280,7 +280,7 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
 		return true;
 
-	if (filename__read_build_id(filename, &bid) == -1) {
+	if (filename__read_build_id(filename, &bid, /*block=*/true) == -1) {
 		if (errno == ENOENT)
 			return false;
 
@@ -309,7 +309,7 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 	int err;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid);
+	err = filename__read_build_id(filename, &bid, /*block=*/true);
 	nsinfo__mountns_exit(&nsc);
 	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 40ba6a94f719..a114b3fa1bea 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -680,12 +680,12 @@ static int dso__read_build_id(struct dso *dso)
 
 	mutex_lock(dso__lock(dso));
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
+	if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0)
 		dso__set_build_id(dso, &bid);
 	else if (dso__nsinfo(dso)) {
 		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, &bid) > 0)
+		if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0)
 			dso__set_build_id(dso, &bid);
 		free(new_name);
 	}
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 93baee2eae42..6132f1af3e22 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -31,7 +31,7 @@ static int build_id_cache__add_file(const char *filename)
 	struct build_id bid = { .size = 0, };
 	int err;
 
-	err = filename__read_build_id(filename, &bid);
+	err = filename__read_build_id(filename, &bid, /*block=*/true);
 	if (err < 0) {
 		pr_debug("Failed to read build id of %s\n", filename);
 		return err;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index a7018a3b0437..bf7f3268b9a2 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -115,7 +115,7 @@ int filename__snprintf_build_id(const char *pathname, char *sbuild_id, size_t sb
 	struct build_id bid = { .size = 0, };
 	int ret;
 
-	ret = filename__read_build_id(pathname, &bid);
+	ret = filename__read_build_id(pathname, &bid, /*block=*/true);
 	if (ret < 0)
 		return ret;
 
@@ -841,7 +841,7 @@ static int filename__read_build_id_ns(const char *filename,
 	int ret;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	ret = filename__read_build_id(filename, bid);
+	ret = filename__read_build_id(filename, bid, /*block=*/true);
 	nsinfo__mountns_exit(&nsc);
 
 	return ret;
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index a44c70f93156..bb9ebd84ec2d 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -110,8 +110,12 @@ struct debuginfo *debuginfo__new(const char *path)
 	if (!dso)
 		goto out;
 
-	/* Set the build id for DSO_BINARY_TYPE__BUILDID_DEBUGINFO */
-	if (is_regular_file(path) && filename__read_build_id(path, &bid) > 0)
+	/*
+	 * Set the build id for DSO_BINARY_TYPE__BUILDID_DEBUGINFO. Don't block
+	 * incase the path isn't for a regular file.
+	 */
+	assert(!dso__has_build_id(dso));
+	if (filename__read_build_id(path, &bid, /*block=*/false) > 0)
 		dso__set_build_id(dso, &bid);
 
 	for (type = distro_dwarf_types;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 0a7645c7fae7..64c1d65b0149 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -81,13 +81,13 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 		return 0;
 	}
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid) > 0) {
+	if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0) {
 		dso__set_build_id(dso, &bid);
 		args->have_build_id = true;
 	} else if (errno == ENOENT && dso__nsinfo(dso)) {
 		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, &bid) > 0) {
+		if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0) {
 			dso__set_build_id(dso, &bid);
 			args->have_build_id = true;
 		}
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6d2c280a1730..033c79231a54 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -902,7 +902,7 @@ static int read_build_id(const char *filename, struct build_id *bid)
 
 #else // HAVE_LIBBFD_BUILDID_SUPPORT
 
-static int read_build_id(const char *filename, struct build_id *bid)
+static int read_build_id(const char *filename, struct build_id *bid, bool block)
 {
 	size_t size = sizeof(bid->data);
 	int fd, err = -1;
@@ -911,7 +911,7 @@ static int read_build_id(const char *filename, struct build_id *bid)
 	if (size < BUILD_ID_SIZE)
 		goto out;
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
 	if (fd < 0)
 		goto out;
 
@@ -934,7 +934,7 @@ static int read_build_id(const char *filename, struct build_id *bid)
 
 #endif // HAVE_LIBBFD_BUILDID_SUPPORT
 
-int filename__read_build_id(const char *filename, struct build_id *bid)
+int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
 {
 	struct kmod_path m = { .name = NULL, };
 	char path[PATH_MAX];
@@ -958,9 +958,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 		}
 		close(fd);
 		filename = path;
+		block = true;
 	}
 
-	err = read_build_id(filename, bid);
+	err = read_build_id(filename, bid, block);
 
 	if (m.comp)
 		unlink(filename);
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 8d41bd7842df..41e4ebe5eac5 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -85,7 +85,7 @@ int filename__read_debuglink(const char *filename __maybe_unused,
 /*
  * Just try PT_NOTE header otherwise fails
  */
-int filename__read_build_id(const char *filename, struct build_id *bid)
+int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
 {
 	int fd, ret = -1;
 	bool need_swap = false, elf32;
@@ -102,7 +102,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	void *phdr, *buf = NULL;
 	ssize_t phdr_size, ehdr_size, buf_size = 0;
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
 	if (fd < 0)
 		return -1;
 
@@ -323,7 +323,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 	if (ret >= 0)
 		RC_CHK_ACCESS(dso)->is_64_bit = ret;
 
-	if (filename__read_build_id(ss->name, &bid) > 0)
+	if (filename__read_build_id(ss->name, &bid, /*block=*/true) > 0)
 		dso__set_build_id(dso, &bid);
 	return 0;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index e816e4220d33..3fed54de5401 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1869,14 +1869,14 @@ int dso__load(struct dso *dso, struct map *map)
 
 	/*
 	 * Read the build id if possible. This is required for
-	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work
+	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work. Don't block in case path
+	 * isn't for a regular file.
 	 */
-	if (!dso__has_build_id(dso) &&
-	    is_regular_file(dso__long_name(dso))) {
+	if (!dso__has_build_id(dso)) {
 		struct build_id bid = { .size = 0, };
 
 		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
-		if (filename__read_build_id(name, &bid) > 0)
+		if (filename__read_build_id(name, &bid, /*block=*/false) > 0)
 			dso__set_build_id(dso, &bid);
 	}
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3fb5d146d9b1..347106218799 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -140,7 +140,7 @@ struct symbol *dso__next_symbol(struct symbol *sym);
 
 enum dso_type dso__type_fd(int fd);
 
-int filename__read_build_id(const char *filename, struct build_id *id);
+int filename__read_build_id(const char *filename, struct build_id *id, bool block);
 int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index cb2c1ace304a..fcd1fd13c30e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -401,7 +401,7 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 	nsi = nsinfo__new(event->pid);
 	nsinfo__mountns_enter(nsi, &nc);
 
-	rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
+	rc = filename__read_build_id(event->filename, &bid, /*block=*/false) > 0 ? 0 : -1;
 
 	nsinfo__mountns_exit(&nc);
 	nsinfo__put(nsi);
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

