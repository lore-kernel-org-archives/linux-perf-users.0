Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AC2FC03E
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981978; cv=none; b=XjvM3btxcVLSUpOC2plYR9Ww+YQlRrvR2ZjqASAbghCIUachWAp1GheC8PGdzzS9fyR3Vf4BmNj2Vt4JWmYFvuekIF/D3Mg3W//efvWjuUjoAz/wrgG9b0ABJVgQ6TYdo27sgvZEyG2BtfrIiTpj/OgTs0T3OpmKt3wlU4Czj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981978; c=relaxed/simple;
	bh=KFFXxsQTAmZS+a4BukfJ3HDLuW62d+/mNEmK3NfVCos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E4zFNKmvoIcav8/oV9tqF9SKoJTLYeqpQDe7t3/OOCIW0mnKzjiYlaLHpmNkdraAxHTLoKXbONUHlelyA88YJDM3afwxviubuup0LhiI6nOqDrL0DBECK4VnSWmdW4YnE9tocHNdJKGzssxuJhQsoYHKh66Lu5YusdESgVO/8ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pPcx2mBs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPcx2mBs"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso26564855e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 02:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763981974; x=1764586774; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJZWeNL/L5TAelLBtZwTlpzk2ssVlRMGmT3P4O+XmDk=;
        b=pPcx2mBs3PCjqdHrZ4I4FeGECwNuK73UyAP/07ldISBIxiBnerOxjUyjqwXBKiHDFd
         POfiSwYkaklNC6HOc7WEoTbPS/oke3i0SmJRAj1kTLKhhqtvQFW7ZVlUwMjzz6s3Oi/S
         YXFz1SFXigS5KZYLMZea5OCzh/dbKoAogw0GS44ohH6heEbPtJQ/gMhfAEGeY5d0gH9I
         sZ6s0ENj7/7xfJTVRHPDNbZCUL9IrZzEbiJieq7B7rGuWTMUhb5rHuzLreZpdiOn9FVt
         2dZvETszj+NfDKxp/RGp8DvKj2nHAy2y9B7i1YFq8v90mCv/rJKsjFWQJJcnbj+Gi/Nu
         x17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763981974; x=1764586774;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJZWeNL/L5TAelLBtZwTlpzk2ssVlRMGmT3P4O+XmDk=;
        b=bKTeh9TTDfrS/2o/DfD+EoTNEHD7LAzRaMDWT43Pq/L4m/Njq1YYzoeMsqCdCZ/cjm
         sGOqsdEd16uZHApjjqXOW6kpPSfaaH2NIUxZVh7dG+UofIWZhfhc0QEfnNFQ2z81r68a
         sK4GopBAF4nbaIITkuVPe/UFfmUUn4TTPlK2ALDUBH7Z0+AVkcM8zzuol0kVDkj5K7Dq
         AoQWQLdLAgF5hWUUERVsq18ilw8SfbAOodwOl7K4ixMxYanWAt/DBeRMIQzozY0E6q2H
         RfXtkHwyvunuJDZFrwq7RxDm7khVdUWkMprk0tKxUtl6YG2GmtGZMCGxDYMbtlVtom3i
         D8Rw==
X-Gm-Message-State: AOJu0Yy3UsFleVjJ91OoJPN15Md9VuACG8UIKTAYHzwzYl5wTBU7gRZ1
	gDM+DjJo0LZIw9c8Et2rC0XnWVmu5N1X73T7Vr8B157osXPL0hpYD4pUcqDRk4oWNFg=
X-Gm-Gg: ASbGnctKKEfoUrITYo4aJs0PeAL6SuqC6dWltXywE+uEKImThYbnVZEWSp/GcuNYP2T
	hWcs0kj0oSeioMtEAqEkD3ej4NsiqibNlsD4pnmg+sjyccxEtGanjivrEJ80RW4XYCJGmQLLrm9
	7FTbczKGGz3endFtzIYEUYzs13d7oFOboAv0Jx0GysSHYjuGFntMykAErO0In3TVtmuNgDoj3+Y
	2eCIy3rw8ohVDOg4j60TZcNIqf6F3sEyVXFyHzO39rVtkYQjQYVXDxEEC7ZAJpa/YjvVgUqTNZi
	bPj5Xo2vHc/wgLlXBUyf2r3GgSThzEh+Q8l8q8wmN0ujvMLrO0WCTlopOS4RtylxpULAX5hr9xg
	Fw7/t41nt72+o7/dvVxRIcLRmD+52cG3BtN3tozNy3xtl1JAEM1TWuJwXO5S/unMZ1/aXvWNIfP
	N247COj5iSe9l1CWNrhuYKDnqr59+wzCc=
X-Google-Smtp-Source: AGHT+IHSW8oyA47+Vpl2YYgvYcYcBG1sj8hIEmTd/6AmNWUxYRo1AGVMy9QcFZNtSfezkLKm6uK4yA==
X-Received: by 2002:a5d:584b:0:b0:429:b963:cdd5 with SMTP id ffacd0b85a97d-42cc12f1d70mr12796820f8f.5.1763981974100;
        Mon, 24 Nov 2025 02:59:34 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd9b45sm27700464f8f.43.2025.11.24.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 02:59:33 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 24 Nov 2025 10:59:08 +0000
Subject: [PATCH v2] perf tools: Don't read build-ids from non-regular files
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-james-perf-non-block-v2-1-54cdc2f13a24@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHs6JGkC/22NQQ6CMBBFr0Jm7RhmCJC68h6GxYAFqtiSqSEaw
 t2txKXL95L//grRqrMRTtkKahcXXfAJ+JBBN4ofLLprYuCcSyIyeJOHjThb7dEHj+0UujsWbKr
 OVCY3IpCms9revfbspUk8uvgM+t5fFvraX5Dpf3AhJKyk5Tpnacu6OE/Oi4Zj0AGabds+cT/RW
 LkAAAA=
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Simplify the build ID reading code by removing the non-blocking option.
Having to pass the correct option to this function was fragile and a
mistake would result in a hang, see the linked fix. Furthermore,
compressed files are always opened blocking anyway, ignoring the
non-blocking option.

We also don't expect to read build IDs from non-regular files. The only
hits to this function that are non-regular are devices that won't be elf
files with build IDs, for example "/dev/dri/renderD129".

Now instead of opening these as non-blocking and failing to read, we
skip them. Even if something like a pipe or character device did have a
build ID, I don't think it would have worked because you need to call
read() in a loop, check for -EAGAIN and handle timeouts to make
non-blocking reads work.

Link: https://lore.kernel.org/linux-perf-users/20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org/
Signed-off-by: James Clark <james.clark@linaro.org>
---
I looked at the paths for hits to this function and found the following
categories:

Devices, which non-block reads were unsuccessfully attempted, but are
now skipped:
 * /dev/dri/renderD129

Non-valid paths, where 'non-regular' is irrelevant e.g.:
 * [vdso]
 * ... (deleted)
 * anon_inode:i915.gem

Shared memory. These are regular and blocking reads work, so no changes
there:
 * /dev/shm/.org.chromium.Chromium.ejhzXY

Symlinks to regular files. Also no change as is_regular_file() is true
for these too.
---
Changes in v2:
- Check is_regular_file in libbfd__read_build_id() too
- Return -EWOULDBLOCK instead of -EFAULT for non-regular files
- Link to v1: https://lore.kernel.org/r/20251121-james-perf-non-block-v1-1-6ab2702ab573@linaro.org
---
 tools/perf/bench/inject-buildid.c  |  2 +-
 tools/perf/builtin-buildid-cache.c |  8 ++++----
 tools/perf/builtin-inject.c        |  4 ++--
 tools/perf/tests/pe-file-parsing.c |  4 ++--
 tools/perf/tests/sdt.c             |  2 +-
 tools/perf/util/build-id.c         |  4 ++--
 tools/perf/util/debuginfo.c        |  2 +-
 tools/perf/util/dsos.c             |  4 ++--
 tools/perf/util/libbfd.c           |  9 +++++++--
 tools/perf/util/libbfd.h           |  5 ++---
 tools/perf/util/symbol-elf.c       | 13 +++++++------
 tools/perf/util/symbol-minimal.c   | 11 ++++++++---
 tools/perf/util/symbol.c           |  5 ++---
 tools/perf/util/symbol.h           |  2 +-
 tools/perf/util/synthetic-events.c |  2 +-
 15 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index 12387ea88b9a..aad572a78d7f 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -85,7 +85,7 @@ static int add_dso(const char *fpath, const struct stat *sb __maybe_unused,
 	if (typeflag == FTW_D || typeflag == FTW_SL)
 		return 0;
 
-	if (filename__read_build_id(fpath, &bid, /*block=*/true) < 0)
+	if (filename__read_build_id(fpath, &bid) < 0)
 		return 0;
 
 	dso->name = realpath(fpath, NULL);
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 2e0f2004696a..c98104481c8a 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -180,7 +180,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 	struct nscookie nsc;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid, /*block=*/true);
+	err = filename__read_build_id(filename, &bid);
 	nsinfo__mountns_exit(&nsc);
 	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
@@ -204,7 +204,7 @@ static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
 	int err;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid, /*block=*/true);
+	err = filename__read_build_id(filename, &bid);
 	nsinfo__mountns_exit(&nsc);
 	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
@@ -280,7 +280,7 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
 		return true;
 
-	if (filename__read_build_id(filename, &bid, /*block=*/true) == -1) {
+	if (filename__read_build_id(filename, &bid) == -1) {
 		if (errno == ENOENT)
 			return false;
 
@@ -309,7 +309,7 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 	int err;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid, /*block=*/true);
+	err = filename__read_build_id(filename, &bid);
 	nsinfo__mountns_exit(&nsc);
 	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index bd9245d2dd41..0e40f2a4bd18 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -668,12 +668,12 @@ static int dso__read_build_id(struct dso *dso)
 
 	mutex_lock(dso__lock(dso));
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0)
+	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
 		dso__set_build_id(dso, &bid);
 	else if (dso__nsinfo(dso)) {
 		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0)
+		if (new_name && filename__read_build_id(new_name, &bid) > 0)
 			dso__set_build_id(dso, &bid);
 		free(new_name);
 	}
diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 8b31d1d05f90..30c7da79e109 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -37,7 +37,7 @@ static int run_dir(const char *d)
 	size_t idx;
 
 	scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
-	ret = filename__read_build_id(filename, &bid, /*block=*/true);
+	ret = filename__read_build_id(filename, &bid);
 	TEST_ASSERT_VAL("Failed to read build_id",
 			ret == sizeof(expect_build_id));
 	TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,
@@ -49,7 +49,7 @@ static int run_dir(const char *d)
 			!strcmp(debuglink, expect_debuglink));
 
 	scnprintf(debugfile, PATH_MAX, "%s/%s", d, debuglink);
-	ret = filename__read_build_id(debugfile, &bid, /*block=*/true);
+	ret = filename__read_build_id(debugfile, &bid);
 	TEST_ASSERT_VAL("Failed to read debug file build_id",
 			ret == sizeof(expect_build_id));
 	TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 6132f1af3e22..93baee2eae42 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -31,7 +31,7 @@ static int build_id_cache__add_file(const char *filename)
 	struct build_id bid = { .size = 0, };
 	int err;
 
-	err = filename__read_build_id(filename, &bid, /*block=*/true);
+	err = filename__read_build_id(filename, &bid);
 	if (err < 0) {
 		pr_debug("Failed to read build id of %s\n", filename);
 		return err;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 35505a1ffd11..fdb35133fde4 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -122,7 +122,7 @@ int filename__snprintf_build_id(const char *pathname, char *sbuild_id, size_t sb
 	struct build_id bid = { .size = 0, };
 	int ret;
 
-	ret = filename__read_build_id(pathname, &bid, /*block=*/true);
+	ret = filename__read_build_id(pathname, &bid);
 	if (ret < 0)
 		return ret;
 
@@ -848,7 +848,7 @@ static int filename__read_build_id_ns(const char *filename,
 	int ret;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	ret = filename__read_build_id(filename, bid, /*block=*/true);
+	ret = filename__read_build_id(filename, bid);
 	nsinfo__mountns_exit(&nsc);
 
 	return ret;
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index bb9ebd84ec2d..4a559b3e8cdc 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -115,7 +115,7 @@ struct debuginfo *debuginfo__new(const char *path)
 	 * incase the path isn't for a regular file.
 	 */
 	assert(!dso__has_build_id(dso));
-	if (filename__read_build_id(path, &bid, /*block=*/false) > 0)
+	if (filename__read_build_id(path, &bid) > 0)
 		dso__set_build_id(dso, &bid);
 
 	for (type = distro_dwarf_types;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 64c1d65b0149..0a7645c7fae7 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -81,13 +81,13 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 		return 0;
 	}
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0) {
+	if (filename__read_build_id(dso__long_name(dso), &bid) > 0) {
 		dso__set_build_id(dso, &bid);
 		args->have_build_id = true;
 	} else if (errno == ENOENT && dso__nsinfo(dso)) {
 		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
 
-		if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0) {
+		if (new_name && filename__read_build_id(new_name, &bid) > 0) {
 			dso__set_build_id(dso, &bid);
 			args->have_build_id = true;
 		}
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 01147fbf73b3..0099b415decc 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -383,13 +383,18 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	return err;
 }
 
-int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block)
+int libbfd__read_build_id(const char *filename, struct build_id *bid)
 {
 	size_t size = sizeof(bid->data);
 	int err = -1, fd;
 	bfd *abfd;
 
-	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
+	if (!filename)
+		return -EFAULT;
+	if (!is_regular_file(filename))
+		return -EWOULDBLOCK;
+
+	fd = open(filename, O_RDONLY);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/perf/util/libbfd.h b/tools/perf/util/libbfd.h
index e300f171d1bd..953886f3d62f 100644
--- a/tools/perf/util/libbfd.h
+++ b/tools/perf/util/libbfd.h
@@ -25,7 +25,7 @@ void dso__free_a2l_libbfd(struct dso *dso);
 int symbol__disassemble_libbfd(const char *filename, struct symbol *sym,
 			     struct annotate_args *args);
 
-int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block);
+int libbfd__read_build_id(const char *filename, struct build_id *bid);
 
 int libbfd_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
 
@@ -59,8 +59,7 @@ static inline int symbol__disassemble_libbfd(const char *filename __always_unuse
 }
 
 static inline int libbfd__read_build_id(const char *filename __always_unused,
-					struct build_id *bid __always_unused,
-					bool block __always_unused)
+					struct build_id *bid __always_unused)
 {
 	return -1;
 }
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9e820599bab3..c5c382c3409a 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -860,20 +860,20 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 	return err;
 }
 
-static int read_build_id(const char *filename, struct build_id *bid, bool block)
+static int read_build_id(const char *filename, struct build_id *bid)
 {
 	size_t size = sizeof(bid->data);
 	int fd, err;
 	Elf *elf;
 
-	err = libbfd__read_build_id(filename, bid, block);
+	err = libbfd__read_build_id(filename, bid);
 	if (err >= 0)
 		goto out;
 
 	if (size < BUILD_ID_SIZE)
 		goto out;
 
-	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
+	fd = open(filename, O_RDONLY);
 	if (fd < 0)
 		goto out;
 
@@ -894,7 +894,7 @@ static int read_build_id(const char *filename, struct build_id *bid, bool block)
 	return err;
 }
 
-int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
+int filename__read_build_id(const char *filename, struct build_id *bid)
 {
 	struct kmod_path m = { .name = NULL, };
 	char path[PATH_MAX];
@@ -902,6 +902,8 @@ int filename__read_build_id(const char *filename, struct build_id *bid, bool blo
 
 	if (!filename)
 		return -EFAULT;
+	if (!is_regular_file(filename))
+		return -EWOULDBLOCK;
 
 	err = kmod_path__parse(&m, filename);
 	if (err)
@@ -918,10 +920,9 @@ int filename__read_build_id(const char *filename, struct build_id *bid, bool blo
 		}
 		close(fd);
 		filename = path;
-		block = true;
 	}
 
-	err = read_build_id(filename, bid, block);
+	err = read_build_id(filename, bid);
 
 	if (m.comp)
 		unlink(filename);
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index aeb253248895..c6b17c14a2e9 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -85,7 +85,7 @@ int filename__read_debuglink(const char *filename __maybe_unused,
 /*
  * Just try PT_NOTE header otherwise fails
  */
-int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
+int filename__read_build_id(const char *filename, struct build_id *bid)
 {
 	int fd, ret = -1;
 	bool need_swap = false, elf32;
@@ -102,7 +102,12 @@ int filename__read_build_id(const char *filename, struct build_id *bid, bool blo
 	void *phdr, *buf = NULL;
 	ssize_t phdr_size, ehdr_size, buf_size = 0;
 
-	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
+	if (!filename)
+		return -EFAULT;
+	if (!is_regular_file(filename))
+		return -EWOULDBLOCK;
+
+	fd = open(filename, O_RDONLY);
 	if (fd < 0)
 		return -1;
 
@@ -323,7 +328,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 	if (ret >= 0)
 		RC_CHK_ACCESS(dso)->is_64_bit = ret;
 
-	if (filename__read_build_id(ss->name, &bid, /*block=*/true) > 0)
+	if (filename__read_build_id(ss->name, &bid) > 0)
 		dso__set_build_id(dso, &bid);
 	return 0;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cc26b7bf302b..d8fc5ea77f84 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1743,14 +1743,13 @@ int dso__load(struct dso *dso, struct map *map)
 
 	/*
 	 * Read the build id if possible. This is required for
-	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work. Don't block in case path
-	 * isn't for a regular file.
+	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work.
 	 */
 	if (!dso__has_build_id(dso)) {
 		struct build_id bid = { .size = 0, };
 
 		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
-		if (filename__read_build_id(name, &bid, /*block=*/false) > 0)
+		if (filename__read_build_id(name, &bid) > 0)
 			dso__set_build_id(dso, &bid);
 	}
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 347106218799..3fb5d146d9b1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -140,7 +140,7 @@ struct symbol *dso__next_symbol(struct symbol *sym);
 
 enum dso_type dso__type_fd(int fd);
 
-int filename__read_build_id(const char *filename, struct build_id *id, bool block);
+int filename__read_build_id(const char *filename, struct build_id *id);
 int sysfs__read_build_id(const char *filename, struct build_id *bid);
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 5aa44c4aba62..2ba9fa25e00a 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -401,7 +401,7 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 	nsi = nsinfo__new(event->pid);
 	nsinfo__mountns_enter(nsi, &nc);
 
-	rc = filename__read_build_id(event->filename, &bid, /*block=*/false) > 0 ? 0 : -1;
+	rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
 
 	nsinfo__mountns_exit(&nc);
 	nsinfo__put(nsi);

---
base-commit: 134852abcbfa5f6a4a17619c8f44c857f800ae03
change-id: 20251119-james-perf-non-block-3296c96909aa

Best regards,
-- 
James Clark <james.clark@linaro.org>

