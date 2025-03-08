Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9B38DF9
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Mar 2025 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741393949; cv=none; b=MxqZOCBweo5vQMBKsZNJtrT0DUQdyB85bZEv3zeCVIzJWolHLwUmZV6Hsjak18UVfCMEApwllEFE4A1+l0hqS6uNTXP4hrvKwra/S7kFXgFzGYj9YLVLO/TTkDHjzGKpUToKIa6bM4bQFOfzNQ/hQgSCjg5+fj5W49NUc/f8tYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741393949; c=relaxed/simple;
	bh=CXs5r0h7EJ5ttG4g9B/EkaU928uC5JdyNMpXSExxHu8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lpLFKeS7NPC4hDGMOqC063PmSDBciwl5SS+EdGFFG2JiCksMtI+BdGeuBVFkrOj4Ba4cLwExk8Blcd7M4+5d0ziB8d9OgBosJbMNRS/TweSjcQ4iS/nJZOTbRwaK4L6Uadp3MJd7DLYPWNJW/jSZb9P6If/rzidHYQCE6mUCAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CEtm5G5+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEtm5G5+"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2b4c302e1so36505957b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 16:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741393946; x=1741998746; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8nEy5rB/hIdNS8kmhBvsJmZBEly95jw8NQmovPnRcI=;
        b=CEtm5G5+0iGOirSK5dGG5QUHkAgw4x4N3raad+iezLOS+rQXN9jmjwk37hWbDvQJpG
         mEVLP+nEBtPHzmppLDH3H1eLdfoHmxIK1LPDPIpg01YefN7HTPZupHZzYXvbSfhpLJtz
         PE0U/nbm5I0DmN+SxKXosYx4hpWb68naOk3yM3196oFeYQG0Kh3Z1HnYhDwUhKIysneo
         ltV1fJz9xdYtPZ0RKG8b0wSXdUL9GkRtJu45NrAhsw7tbjMa0f/VLAdwkKwU6LZD5+Gz
         kv6KQI2MaoJIUoWzs9kMdVyKcYhRmiayCGPJBr7eb7M3i0hqBFiBeFwychSGXZIETQU7
         Kiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741393946; x=1741998746;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8nEy5rB/hIdNS8kmhBvsJmZBEly95jw8NQmovPnRcI=;
        b=JddYQFFWQg6AvmMNKYTKthIfGovc0ReTgmHmlMGvHPOv6nd/CKQksATzvhpAuaWkh4
         4WGWE3cOS5nnmxF9EV3WJ991DPXPTivA9vPGjreAkXhdpCuIuu5Dv0LM2qjodTWwvnr2
         RO13V07TDIi2MDNrdgyiepBa/B02MBYfMHghfsLqI0iQU+uGoC6sms4Az6AhVhQf93ZX
         rFKLE2LU5I0Q702IbHQTl9Sn9VoM7EuYmIa2BpRqLTBMidyhtEw/mi3oaFjjNKWBDJB/
         ErcCXIdDBKgp+fAHaErochY5Pt8ceHrPHp5N0Er5fSwvyOp6LUzb5TUlRGJn1zSGCL8j
         RC0g==
X-Forwarded-Encrypted: i=1; AJvYcCXi0m/LGz/MQOcgc2XXbov1B2PFyx4zcjAUpkjsLckOqszGKg2FL4kU862CrMZ3kCEuxxxijlqMmpym5sj/0Ige@vger.kernel.org
X-Gm-Message-State: AOJu0YzUq2GGYW7OE6iB+v/PM3mCBkT+DusBr5mzDK2euq80t7a0W7zg
	lhHI4efwf0RnY7PbbQLSTYUp2SHP1AkVs4wx0sRYNF2fQMlqMF+kqVqMX4Vsx76jqtUdyiqTcrr
	uqWhbCg==
X-Google-Smtp-Source: AGHT+IEReJ5DG45Y2N78xw+Wv9anGhMhyh78SY1Xp5hvlU3qYN+t3i78fMBSJgNA1+oBXk1aHtUloiroGn65
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:1541:e490:aa80:5766])
 (user=irogers job=sendgmr) by 2002:a05:690c:20b0:b0:6fd:2b79:fb13 with SMTP
 id 00721157ae682-6febf3b53d7mr4850647b3.6.1741393946311; Fri, 07 Mar 2025
 16:32:26 -0800 (PST)
Date: Fri,  7 Mar 2025 16:32:04 -0800
In-Reply-To: <20250308003209.234114-1-irogers@google.com>
Message-Id: <20250308003209.234114-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308003209.234114-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v5 06/11] perf dso: Add support for reading the e_machine type
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
 tools/perf/util/dso.c        | 88 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/dso.h        |  3 ++
 tools/perf/util/symbol-elf.c | 27 -----------
 3 files changed, 91 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5c6e85fdae0d..00fec1bc32bc 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1170,6 +1170,67 @@ ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
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
@@ -1525,6 +1586,33 @@ void dso__put(struct dso *dso)
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
index 4aa8c3d36566..38d9e3eac501 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -730,6 +730,8 @@ bool dso__sorted_by_name(const struct dso *dso);
 void dso__set_sorted_by_name(struct dso *dso);
 void dso__sort_by_name(struct dso *dso);
 
+int dso__swap_init(struct dso *dso, unsigned char eidata);
+
 void dso__set_build_id(struct dso *dso, struct build_id *bid);
 bool dso__build_id_equal(const struct dso *dso, struct build_id *bid);
 void dso__read_running_kernel_build_id(struct dso *dso,
@@ -818,6 +820,7 @@ int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size);
+uint16_t dso__e_machine(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 			    struct machine *machine, u64 addr,
 			    u8 *data, ssize_t size);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66fd1249660a..71df13a5722a 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1173,33 +1173,6 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 
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
2.49.0.rc0.332.g42c0ae87b1-goog

