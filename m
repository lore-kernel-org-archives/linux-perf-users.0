Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A11C5F32
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742268731; cv=none; b=rK2QHW8MFmZ24J1L/47+NBdhTo1rmspUeGVqVp6l7spNflfxniZIzMPyFWKt4Dtn044709xJE0uRsSUOOQnFsAhTcqZEol2C7yjjzN68FiSQy0TDVjdUKqwfwrThIfOwi7s9uqQwqyPD9G9bPBsZlpeR1Rhj83wwIQcplKgnJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742268731; c=relaxed/simple;
	bh=qO33fTx+HqUeOfYY5NS9nwgBksuRWZC4/oEm3OxAtag=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BRgLDemM9aS65CHARv4VxqImHunLCVAkNntYft/PNuKzpg5VcJw8jsjKBwFtWmFBmcOsMY0QTe6FgTNdSWQxLabLxGMfEJhOs2zjNOR83E9dGcySMOcib19Uyj2cJxACBJtIJ3OG51U9DOugW1c9h+AOHGdSL3GXlfm7ewLTeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vL9d4irp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vL9d4irp"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e6432a0dad8so2502961276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742268729; x=1742873529; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0QBY2Nw3ByVw59Pz+Hx1wvCamLOjPFqTULRDEzwjio=;
        b=vL9d4irpZtNlWZeAo9RpgEE4n97txUWe514DBzBOA+h6Kk+iucX/OR9lvGhxDo+L3P
         aVW88T84BkcejkbiZei4cZpSiGWGDH7AeXPPYybw7Tzhlxii4R4RKzGAYhpA7/vzi8vj
         4EySWmnizLaXC0M4jfSyN6l4+acJKOxGzha8TtBsuTKJWM9B6G1di/ZTDVCGDmh/Rwyn
         hAYTW7p5mBxMfU1+xzEBqt9dk6cslAZQaZ5BhHMsfa984LykxjZG355+N4EzFt0f00+W
         wGhnNUb5BlwhYLDNAFZ8MdyazwmMumYUVF1jUOUwVEBI8WxBcbDTdX1wgsRsLABXbNJI
         /qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742268729; x=1742873529;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0QBY2Nw3ByVw59Pz+Hx1wvCamLOjPFqTULRDEzwjio=;
        b=i8e9lL3kA0UfEgzFhgY7eXsQuC7YpWWAkTIeR5doOv11ROADs2CjYgvfrcTwkAe6C1
         UumTxhfVmTdFf6UoJyWkra5UHgQKp3vAxr58eNNooHXIMigDDbFe5dKkML7bpwGMvOEY
         y4v0S+pN8mIOTTigv/ZzzSgsWzNXVJF/GIEhIgFsZqEXLi7PuTBJvbQz6oApumlaH12t
         rboTobjg2MnjEmQX1QL50H/J6i0PA9WS3RWENM3Qy+p4NFeE9oxdrkE64baJTDZ0ItbO
         f8DrROSs1jwFJvzvhww1obxwBnCqLxFl5aYT6cb4hgVxd4gjaSBgpw05HivYX3tiREsS
         N+RA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ98C4xiUX4JWErAFdNDJoxHN1fPMM8nYLnkJcEEAO6Pqi8cUgASoVXrzF7oe5xskQYVgrRzh/liPtZKMo3LlS@vger.kernel.org
X-Gm-Message-State: AOJu0YzujsuH+qx86XvAujSLIm59UbPriEZK2271xjW9VNBC096YsygA
	gMIEcLtw7HOoeJVteg+ln2ajP7YxhvRnwsAqJFdA+NYjLo5vymXnSzAJwo5JOT1UviXOjI7nc5n
	l0iZCTw==
X-Google-Smtp-Source: AGHT+IH3ZsA45Hh6AC985okMNJU3GA2gN9GLs2pTd3dhMU9xuvlE/Rp3C8qkGUhbDsx6HENWoPY55aGi1xZ6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a25:ae94:0:b0:e5d:a3bd:890a with SMTP id
 3f1490d57ef6-e63f64c348fmr7905276.1.1742268729109; Mon, 17 Mar 2025 20:32:09
 -0700 (PDT)
Date: Mon, 17 Mar 2025 20:31:43 -0700
In-Reply-To: <20250318033150.119174-1-irogers@google.com>
Message-Id: <20250318033150.119174-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318033150.119174-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v6 06/13] perf dso: Add support for reading the e_machine type
 for a dso
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

For ELF file dsos read the e_machine from the ELF header. For kernel
types assume the e_machine matches the perf tool. In other cases
return EM_NONE.

When reading from the ELF header use DSO__SWAP that may need
dso->needs_swap initializing. Factor out dso__swap_init to allow this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c        | 89 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/dso.h        |  3 ++
 tools/perf/util/symbol-elf.c | 27 -----------
 3 files changed, 92 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 7576e8e24838..45da63d7315b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1173,6 +1173,68 @@ ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 	return data_read_write_offset(dso, machine, offset, data, size, true);
 }
 
+uint16_t dso__e_machine(struct dso *dso, struct machine *machine)
+{
+	uint16_t e_machine = EM_NONE;
+	int fd;
+
+	switch (dso__binary_type(dso)) {
+	case DSO_BINARY_TYPE__KALLSYMS:
+	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
+	case DSO_BINARY_TYPE__VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_KMODULE:
+	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
+	case DSO_BINARY_TYPE__KCORE:
+	case DSO_BINARY_TYPE__GUEST_KCORE:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
+	case DSO_BINARY_TYPE__JAVA_JIT:
+		return EM_HOST;
+	case DSO_BINARY_TYPE__DEBUGLINK:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
+	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+		break;
+	case DSO_BINARY_TYPE__NOT_FOUND:
+	default:
+		return EM_NONE;
+	}
+
+	pthread_mutex_lock(&dso__data_open_lock);
+
+	/*
+	 * dso__data(dso)->fd might be closed if other thread opened another
+	 * file (dso) due to open file limit (RLIMIT_NOFILE).
+	 */
+	try_to_open_dso(dso, machine);
+	fd = dso__data(dso)->fd;
+	if (fd >= 0) {
+		_Static_assert(offsetof(Elf32_Ehdr, e_machine) == 18, "Unexpected offset");
+		_Static_assert(offsetof(Elf64_Ehdr, e_machine) == 18, "Unexpected offset");
+		if (dso__needs_swap(dso) == DSO_SWAP__UNSET) {
+			unsigned char eidata;
+
+			if (pread(fd, &eidata, sizeof(eidata), EI_DATA) == sizeof(eidata))
+				dso__swap_init(dso, eidata);
+		}
+		if (dso__needs_swap(dso) != DSO_SWAP__UNSET &&
+		    pread(fd, &e_machine, sizeof(e_machine), 18) == sizeof(e_machine))
+			e_machine = DSO__SWAP(dso, uint16_t, e_machine);
+	}
+	pthread_mutex_unlock(&dso__data_open_lock);
+	return e_machine;
+}
+
 /**
  * dso__data_read_addr - Read data from dso address
  * @dso: dso object
@@ -1528,6 +1590,33 @@ void dso__put(struct dso *dso)
 		RC_CHK_PUT(dso);
 }
 
+int dso__swap_init(struct dso *dso, unsigned char eidata)
+{
+	static unsigned int const endian = 1;
+
+	dso__set_needs_swap(dso, DSO_SWAP__NO);
+
+	switch (eidata) {
+	case ELFDATA2LSB:
+		/* We are big endian, DSO is little endian. */
+		if (*(unsigned char const *)&endian != 1)
+			dso__set_needs_swap(dso, DSO_SWAP__YES);
+		break;
+
+	case ELFDATA2MSB:
+		/* We are little endian, DSO is big endian. */
+		if (*(unsigned char const *)&endian != 0)
+			dso__set_needs_swap(dso, DSO_SWAP__YES);
+		break;
+
+	default:
+		pr_err("unrecognized DSO data encoding %d\n", eidata);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 void dso__set_build_id(struct dso *dso, struct build_id *bid)
 {
 	RC_CHK_ACCESS(dso)->bid = *bid;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index fcb2898e0f49..0459d4e41b14 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -735,6 +735,8 @@ bool dso__sorted_by_name(const struct dso *dso);
 void dso__set_sorted_by_name(struct dso *dso);
 void dso__sort_by_name(struct dso *dso);
 
+int dso__swap_init(struct dso *dso, unsigned char eidata);
+
 void dso__set_build_id(struct dso *dso, struct build_id *bid);
 bool dso__build_id_equal(const struct dso *dso, struct build_id *bid);
 void dso__read_running_kernel_build_id(struct dso *dso,
@@ -823,6 +825,7 @@ int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size);
+uint16_t dso__e_machine(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 			    struct machine *machine, u64 addr,
 			    u8 *data, ssize_t size);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 3fa92697c457..fbf6d0f73af9 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1174,33 +1174,6 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 
 #endif
 
-static int dso__swap_init(struct dso *dso, unsigned char eidata)
-{
-	static unsigned int const endian = 1;
-
-	dso__set_needs_swap(dso, DSO_SWAP__NO);
-
-	switch (eidata) {
-	case ELFDATA2LSB:
-		/* We are big endian, DSO is little endian. */
-		if (*(unsigned char const *)&endian != 1)
-			dso__set_needs_swap(dso, DSO_SWAP__YES);
-		break;
-
-	case ELFDATA2MSB:
-		/* We are little endian, DSO is big endian. */
-		if (*(unsigned char const *)&endian != 0)
-			dso__set_needs_swap(dso, DSO_SWAP__YES);
-		break;
-
-	default:
-		pr_err("unrecognized DSO data encoding %d\n", eidata);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 bool symsrc__possibly_runtime(struct symsrc *ss)
 {
 	return ss->dynsym || ss->opdsec;
-- 
2.49.0.rc1.451.g8f38331e32-goog

