Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068328469A
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622551; cv=none; b=ovW2RRoIgee/ITMFRIVnRn/HhGnQrlTPx7JV8w9mbRB33RI/rN/6kEdQ3cdjy1UT13tDEFCxPBt2B6F71Z/sFumXmiX4/JqNUrUSZhIRY53kWu/z0peDovgo2fTkGx4dQQpAO0R8Yii2i/gbHHKGmVnD2WdVIubV8FUG1wh8FaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622551; c=relaxed/simple;
	bh=2hLfLEdeG6Q9fp6ZEtSs1CidG+0p9Bs8uu4s6+QrX+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Z5PLenkLy6lWQivwSkFx4K2fy1KDhkx3VUVON6wJgqToYuic3VOtb0s/bGdFNXF8a0FBgbZMe+wMXHlxFFTt9CL1fB/r0j5lvZjfS37NIXz7o24c+g7i0VZhRfIwRfCi4/kxkF/zTkC2lwQz8gvNMcXAaxD4e+MxMwnEw4zpGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMqJfx/j; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMqJfx/j"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99f6516262so11624221a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764622548; x=1765227348; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKKNjh5F/DaKk8wuFOjnc86WkhY823H5ekf9jbrPtus=;
        b=lMqJfx/jvWsyx6G8U5XiToYWLJmjU+5j3mqN9w3TaQr1rxzi5o6IcQYXkpzTwIsweH
         1NbQ3gLZS3s7Uv424BNmkwjdzow5IMxu6UrERUVE9z9DFOSGxwappWFbqX4wW5b8tJKF
         cCmWZ0puYQ+n/OJhjKdEZWFt5jmNUfpEMlNUigbMk4fYAGXKgAW5LGovDXo7w2vTI284
         sFNfn+mCR3ADVQO2QXpOrC6xxC0mJvbhMRlcFmxG5unz0M1zgrBKTSsOR79VoIwPRI5E
         +5E+bdZKe7pKk3gAmFPIO50y011Q516VO1yTGeUPtzCB9xgkkN8FgnNOdRFfwAJNgw/s
         VS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622548; x=1765227348;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKKNjh5F/DaKk8wuFOjnc86WkhY823H5ekf9jbrPtus=;
        b=UcRtemQAS60j/WAKgjSR7kM7/35gKdL54CXTVxDfs1vgtE06U7p5tem8NTMFv0+3+X
         EBGW7R13CxWJRDhAAFg4X8XYYMm/bCQFtHdVDBMma3scDLe3TQcHX3zPsJsXUkWPYIQl
         1oukumDUFe5X2ofb45OZq4hCoJ75Atqtx0T2XP82WjZdNAW7h06HKT0927Ps8jz8ehGb
         QnFboxDLF26KFqY6Q4YvnKBtX11nax+tUhELIxyaW7NTZq706kFtYqq0C29alV11GoSO
         3U6o2gDQ7zju21tODuvc56xt3yFSvlLiAC/NQzMwMizqGZKU3bDWg7bfbkuSAfAVjJ7G
         siKg==
X-Forwarded-Encrypted: i=1; AJvYcCU+8eJiuZupoV4euc4EVLcF5AUL4DWFYhIyLmPOt+p2VZSf5xo5ym7I2ExH/APpDkmwAswElG0Nb6wif2MPbO7Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxjjV4ntFVM2yMCzKtNBYlb5VePU0maXfN94qk3Yb5kMFYx5GHi
	YWTYHJwYvHsLv6WB52Wvlg1q2FLkoupEv1OSdv6ezlgUxLo+0SV6PYTopiuPluxhDcnAUxY4GjC
	viqdm+CVC8A==
X-Google-Smtp-Source: AGHT+IFR17AdhrIQVLVcu0xi9Bguk4YjUWqci6Qpnra1PNK40h9hsWE1hc6G1x5ZPC695Q4w+8XCmSkGAurL
X-Received: from dygu17.prod.google.com ([2002:a05:7300:5411:b0:2a4:85c9:5e08])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3943:b0:2a4:3592:cf77
 with SMTP id 5a478bee46e88-2a941894852mr19882346eec.27.1764622548105; Mon, 01
 Dec 2025 12:55:48 -0800 (PST)
Date: Mon,  1 Dec 2025 12:55:07 -0800
In-Reply-To: <20251201205509.195451-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201205509.195451-9-irogers@google.com>
Subject: [PATCH v2 08/10] perf symbol: Make a common sysfs__read_build_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The libelf version of sysfs__read_build_id would read through the
file, the symbol-minimal version would read the whole file and then
use regular build-id parsing. Given we prefer the libelf code, make
both implementations use the libelf implementation and not require
reading the whole file. As the libelf implementation uses libelf
structs, move the code to symbol-minimal and use the
style/implementation that exists there already in the in memory
read_build_id code. Note, this means we could avoid reading phdrs
where read_build_id is used and switch to read_build_id_fd to
potentially avoid some memory allocation.

Clean up how bf was being used as it bound checked bf when a build ID
note was found but not when the name wasn't "GNU". Switch to just
lseek-ing forward the file to avoid any buffer overrun problems and
unnecessary reading.

Reduce scope of NOTE_ALIGN macro in perf-libelf.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf-libelf.c    |  5 ++
 tools/perf/util/perf-libelf.h    |  5 --
 tools/perf/util/symbol-elf.c     | 50 --------------------
 tools/perf/util/symbol-minimal.c | 80 +++++++++++++++++++++++---------
 tools/perf/util/symbol-minimal.h |  1 +
 tools/perf/util/symbol.c         |  6 +++
 6 files changed, 69 insertions(+), 78 deletions(-)

diff --git a/tools/perf/util/perf-libelf.c b/tools/perf/util/perf-libelf.c
index a8a8c39056da..4198f4dfad9f 100644
--- a/tools/perf/util/perf-libelf.c
+++ b/tools/perf/util/perf-libelf.c
@@ -9,6 +9,11 @@
 #include "build-id.h"
 #include "debug.h"
 
+/*
+ * Align offset to 4 bytes as needed for note name and descriptor data.
+ */
+#define NOTE_ALIGN(n) (((n) + 3) & -4U)
+
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *idx)
 {
diff --git a/tools/perf/util/perf-libelf.h b/tools/perf/util/perf-libelf.h
index 167679f9fc9b..2118325c04e5 100644
--- a/tools/perf/util/perf-libelf.h
+++ b/tools/perf/util/perf-libelf.h
@@ -21,11 +21,6 @@ struct build_id;
 # define PERF_ELF_C_READ_MMAP ELF_C_READ
 #endif
 
-/*
- * Align offset to 4 bytes as needed for note name and descriptor data.
- */
-#define NOTE_ALIGN(n) (((n) + 3) & -4U)
-
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep, GElf_Shdr *shp, const char *name,
 			     size_t *idx);
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9ceb746b6c59..cb890de31044 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -751,56 +751,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	return 0;
 }
 
-int sysfs__read_build_id(const char *filename, struct build_id *bid)
-{
-	size_t size = sizeof(bid->data);
-	int fd, err = -1;
-
-	fd = open(filename, O_RDONLY);
-	if (fd < 0)
-		goto out;
-
-	while (1) {
-		char bf[BUFSIZ];
-		GElf_Nhdr nhdr;
-		size_t namesz, descsz;
-
-		if (read(fd, &nhdr, sizeof(nhdr)) != sizeof(nhdr))
-			break;
-
-		namesz = NOTE_ALIGN(nhdr.n_namesz);
-		descsz = NOTE_ALIGN(nhdr.n_descsz);
-		if (nhdr.n_type == NT_GNU_BUILD_ID &&
-		    nhdr.n_namesz == sizeof("GNU")) {
-			if (read(fd, bf, namesz) != (ssize_t)namesz)
-				break;
-			if (memcmp(bf, "GNU", sizeof("GNU")) == 0) {
-				size_t sz = min(descsz, size);
-				if (read(fd, bid->data, sz) == (ssize_t)sz) {
-					memset(bid->data + sz, 0, size - sz);
-					bid->size = sz;
-					err = 0;
-					break;
-				}
-			} else if (read(fd, bf, descsz) != (ssize_t)descsz)
-				break;
-		} else {
-			int n = namesz + descsz;
-
-			if (n > (int)sizeof(bf)) {
-				n = sizeof(bf);
-				pr_debug("%s: truncating reading of build id in sysfs file %s: n_namesz=%u, n_descsz=%u.\n",
-					 __func__, filename, nhdr.n_namesz, nhdr.n_descsz);
-			}
-			if (read(fd, bf, n) != n)
-				break;
-		}
-	}
-	close(fd);
-out:
-	return err;
-}
-
 bool symsrc__possibly_runtime(struct symsrc *ss)
 {
 	return ss->dynsym || ss->opdsec;
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 445307f230af..0e3a27dae9d6 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -77,6 +77,58 @@ static int read_build_id(void *note_data, size_t note_len, struct build_id *bid,
 	return -1;
 }
 
+static int read_build_id_fd(int fd, struct build_id *bid, bool need_swap)
+{
+	size_t size = sizeof(bid->data);
+	struct {
+		u32 n_namesz;
+		u32 n_descsz;
+		u32 n_type;
+	} nhdr;
+
+	while (true) {
+		size_t namesz, descsz, n;
+		ssize_t err;
+
+		err = read(fd, &nhdr, sizeof(nhdr));
+		if (err != sizeof(nhdr))
+			return err == -1 ? -errno : -EIO;
+
+		if (need_swap) {
+			nhdr.n_namesz = bswap_32(nhdr.n_namesz);
+			nhdr.n_descsz = bswap_32(nhdr.n_descsz);
+			nhdr.n_type = bswap_32(nhdr.n_type);
+		}
+		namesz = NOTE_ALIGN(nhdr.n_namesz);
+		descsz = NOTE_ALIGN(nhdr.n_descsz);
+		n = namesz + descsz; /* Remaining bytes of this note. */
+
+		if (nhdr.n_type == NT_GNU_BUILD_ID && nhdr.n_namesz == sizeof("GNU")) {
+			char name[NOTE_ALIGN(sizeof("GNU"))];
+
+			err = read(fd, name, sizeof(name));
+			if (err != sizeof(name))
+				return err == -1 ? -errno : -EIO;
+
+			n = descsz;
+			if (memcmp(name, "GNU", sizeof("GNU")) == 0) {
+				/* Successfully found build ID. */
+				ssize_t sz = min(descsz, size);
+
+				err = read(fd, bid->data, sz);
+				if (err != sz)
+					return err == -1 ? -errno : -EIO;
+
+				memset(bid->data + sz, 0, size - sz);
+				bid->size = sz;
+				return 0;
+			}
+		}
+		if (lseek(fd, n, SEEK_CUR) == -1)
+			return -errno;
+	}
+}
+
 /*
  * Just try PT_NOTE header otherwise fails
  */
@@ -194,38 +246,20 @@ int sym_min__read_build_id(int _fd, const char *filename, struct build_id *bid)
 	return ret;
 }
 
-#ifndef HAVE_LIBELF_SUPPORT
-int sysfs__read_build_id(const char *filename, struct build_id *bid)
+int sym_min_sysfs__read_build_id(const char *filename, struct build_id *bid)
 {
-	int fd;
-	int ret = -1;
-	struct stat stbuf;
-	size_t buf_size;
-	void *buf;
+	int fd, ret;
 
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
-		return -1;
-
-	if (fstat(fd, &stbuf) < 0)
-		goto out;
-
-	buf_size = stbuf.st_size;
-	buf = malloc(buf_size);
-	if (buf == NULL)
-		goto out;
-
-	if (read(fd, buf, buf_size) != (ssize_t) buf_size)
-		goto out_free;
+		return -errno;
 
-	ret = read_build_id(buf, buf_size, bid, false);
-out_free:
-	free(buf);
-out:
+	ret = read_build_id_fd(fd, bid, /*need_swap=*/false);
 	close(fd);
 	return ret;
 }
 
+#ifndef HAVE_LIBELF_SUPPORT
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	         enum dso_binary_type type)
 {
diff --git a/tools/perf/util/symbol-minimal.h b/tools/perf/util/symbol-minimal.h
index 185d98968212..5cce1f1f0f16 100644
--- a/tools/perf/util/symbol-minimal.h
+++ b/tools/perf/util/symbol-minimal.h
@@ -5,5 +5,6 @@
 struct build_id;
 
 int sym_min__read_build_id(int _fd, const char *filename, struct build_id *bid);
+int sym_min_sysfs__read_build_id(const char *filename, struct build_id *bid);
 
 #endif /* __PERF_SYMBOL_MINIMAL_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index da75a1c159f2..76dc5b70350a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2050,6 +2050,12 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	return err;
 }
 
+int sysfs__read_build_id(const char *filename, struct build_id *bid)
+{
+	/* Doesn't mmap file into memory. */
+	return sym_min_sysfs__read_build_id(filename, bid);
+}
+
 int filename__read_debuglink(const char *filename, char *debuglink, size_t size)
 {
 	int err = libbfd_filename__read_debuglink(filename, debuglink, size);
-- 
2.52.0.158.g65b55ccf14-goog

