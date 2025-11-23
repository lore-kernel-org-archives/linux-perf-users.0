Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5043229B36
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865164; cv=none; b=Mt5qjPZN5MeKLYp5d2i+S8qrqpIaTOKQ39CfUxBa9gHBFp+Qmd/nkW7NMlSeJIlCB3CbvG0RzL+ANSYrt6Yxal4FiJZd8Wo4AJ6+3qEyRQ3m6owMJ8h4jGDn28fkB3heDhgQjq/eVLcgZ254nW6LstawP2oUVPjlvS5oeRYx3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865164; c=relaxed/simple;
	bh=/m4nFY58ooW3j4EVV44rHempiLtSr3soyPpOz7+8zMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=m2sCgHCFywDq4r2H9tC7R2fLOXL2WvqRw22xFqIChYwJ2MK91mfNlJlPeXxO5t3fjoUlthgIF1stPAuPjch/ybJz3A4+oOY5WfgDQiFKwqyGhqfvrlDxsPMtWO+2cgRzsBU6pMp/2WVlkmkXqk4NuFERorZSEbHlLlPdwlbEDp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNFfS4ud; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNFfS4ud"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99f6516262so10360571a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 18:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763865162; x=1764469962; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=216g4UGP++NTukOPT8kADTLlrUxIj1uULiiBz8Jq85U=;
        b=iNFfS4udZdML+ra6Rav6nnRvB3wCjrh5Hko+RWF4Bu5PUXxiVhtqV/b4Xcp+wh1D9P
         ykZwhXiM+vdrCyD9u8fDaIkunm8lthODq9bzwAAAMSDwv4D/TAcc/a1NdwIS/IHfdbzI
         amI3mlNPe/aoFoz8XyMtYjsB4zHAo7E9zq09Dreul/wHCyW36L88izWMKdcayz4vHOuN
         gXA85Y2dAR/S2i48pO4alZn4SJVJCgl33T+oMRxzedzKpjy8fboD5XoY1pdR7s4BkPXs
         pAwLI/YNsQNwWkxiLz89Gy9/48hK+henZ0sSwUhUmIDjx+pEZviTFeVUYvWk6u0hIWfu
         NiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763865162; x=1764469962;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=216g4UGP++NTukOPT8kADTLlrUxIj1uULiiBz8Jq85U=;
        b=SFxEMCxw6ynOxgRgRMoH9Ex7wGgVrjcl/9z7hOYupe3af5PaSU6XiK6pqVeya9JaOA
         8Gi5dlY5hAXBNtsezVhY7kvFTrd1OJXaf65yeqDAg3YcMagUZM4YReOH0Pk/aiT/C+2S
         qklmB7CBV4SOu/sj/itzKHejJhScj7XRFDPCcet9D2id9eC8iXIFxf0lwCoZjIbhto0d
         xtaUZTJSi4fvoolCHBKafWjpw0/YpuggE0cENACL/cQBlXlz+8+UjAw5nUCn1ABnA342
         UymeGYO+A1z/k2zuQ3FTWwDrro1PHRxVPPPUiPdLWfSyozlJX3OK2oqgUfTMpspYDX0Z
         8UJA==
X-Forwarded-Encrypted: i=1; AJvYcCV3zUzq7xwJGnMzKsH2Egwk1Fs0mbWtzED4LUsDSvqRuQdsaPvkBfRg3y/SP6tEw21PevEQvzd13BTexMDblVm2@vger.kernel.org
X-Gm-Message-State: AOJu0YwwXztWjVfhPt2bwoaQmZYjYSZynBRV4NcLipozSqlOKORWe+2W
	9L+2jK3ePNqHWjRyy6zmokPltML+pYLWPzvUM6XlTaCcLS3IE0a6e4SYHrXpAus552zfX+fGRBw
	AtpyKT1wApg==
X-Google-Smtp-Source: AGHT+IGGs1lL6zRYCul6ahXzZCqjt8nz/UVOMvKplJnd7VbGxuyghTPmQmQgkb8WrlEkl2RA5LNvOK7xeE4H
X-Received: from dydx8.prod.google.com ([2002:a05:7300:2288:b0:2a4:4bd0:6ed8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:168e:b0:2a4:5154:b346
 with SMTP id 5a478bee46e88-2a7192e071cmr4743854eec.35.1763865162232; Sat, 22
 Nov 2025 18:32:42 -0800 (PST)
Date: Sat, 22 Nov 2025 18:32:23 -0800
In-Reply-To: <20251123023225.8069-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251123023225.8069-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251123023225.8069-8-irogers@google.com>
Subject: [PATCH v1 7/9] perf symbol: Use fallbacks for filename__read_debuglink
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Try libbfd and then libelf in symbol.c. Remove the non-existent
symbol-minimal version.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf-libelf.c    | 52 +++++++++++++++++++++++++++++
 tools/perf/util/perf-libelf.h    | 10 ++++++
 tools/perf/util/symbol-elf.c     | 56 --------------------------------
 tools/perf/util/symbol-minimal.c |  9 -----
 tools/perf/util/symbol.c         | 10 ++++++
 5 files changed, 72 insertions(+), 65 deletions(-)

diff --git a/tools/perf/util/perf-libelf.c b/tools/perf/util/perf-libelf.c
index c7fa08a177d0..a8a8c39056da 100644
--- a/tools/perf/util/perf-libelf.c
+++ b/tools/perf/util/perf-libelf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "perf-libelf.h"
 
+#include <fcntl.h>
 #include <stddef.h>
 #include <string.h>
 #include <unistd.h>
@@ -143,3 +144,54 @@ int libelf__read_build_id(int _fd, const char *filename, struct build_id *bid)
 out:
 	return err;
 }
+
+int libelf_filename__read_debuglink(const char *filename, char *debuglink, size_t size)
+{
+	int fd, err = -1;
+	Elf *elf;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	Elf_Data *data;
+	Elf_Scn *sec;
+	Elf_Kind ek;
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
+		goto out;
+
+	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
+	if (elf == NULL) {
+		pr_debug2("%s: cannot read %s ELF file.\n", __func__, filename);
+		goto out_close;
+	}
+
+	ek = elf_kind(elf);
+	if (ek != ELF_K_ELF)
+		goto out_elf_end;
+
+	if (gelf_getehdr(elf, &ehdr) == NULL) {
+		pr_err("%s: cannot get elf header.\n", __func__);
+		goto out_elf_end;
+	}
+
+	sec = elf_section_by_name(elf, &ehdr, &shdr,
+				  ".gnu_debuglink", NULL);
+	if (sec == NULL)
+		goto out_elf_end;
+
+	data = elf_getdata(sec, NULL);
+	if (data == NULL)
+		goto out_elf_end;
+
+	/* the start of this section is a zero-terminated string */
+	strncpy(debuglink, data->d_buf, size);
+
+	err = 0;
+
+out_elf_end:
+	elf_end(elf);
+out_close:
+	close(fd);
+out:
+	return err;
+}
diff --git a/tools/perf/util/perf-libelf.h b/tools/perf/util/perf-libelf.h
index 931597493b1f..167679f9fc9b 100644
--- a/tools/perf/util/perf-libelf.h
+++ b/tools/perf/util/perf-libelf.h
@@ -2,6 +2,8 @@
 #ifndef __PERF_LIBELF_H
 #define __PERF_LIBELF_H
 
+#include <stddef.h>
+
 struct build_id;
 
 #ifdef HAVE_LIBELF_SUPPORT
@@ -30,6 +32,7 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep, GElf_Shdr *shp, const char
 int __libelf__read_build_id(Elf *elf, void *bf, size_t size);
 
 int libelf__read_build_id(int _fd, const char *filename, struct build_id *bid);
+int libelf_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
 
 #else // !defined(HAVE_LIBELF_SUPPORT)
 
@@ -40,6 +43,13 @@ static inline int libelf__read_build_id(int fd __always_unused,
 	return -1;
 }
 
+static inline int libelf_filename__read_debuglink(const char *filename __always_unused,
+						  char *debuglink __always_unused,
+						  size_t size __always_unused)
+{
+	return -1;
+}
+
 #endif // defined(HAVE_LIBELF_SUPPORT)
 
 #endif /* __PERF_LIBELF_H */
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index b301f1263ecc..d4a1b01010c1 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -801,62 +801,6 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 	return err;
 }
 
-int filename__read_debuglink(const char *filename, char *debuglink,
-			     size_t size)
-{
-	int fd, err = -1;
-	Elf *elf;
-	GElf_Ehdr ehdr;
-	GElf_Shdr shdr;
-	Elf_Data *data;
-	Elf_Scn *sec;
-	Elf_Kind ek;
-
-	err = libbfd_filename__read_debuglink(filename, debuglink, size);
-	if (err >= 0)
-		goto out;
-
-	fd = open(filename, O_RDONLY);
-	if (fd < 0)
-		goto out;
-
-	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
-	if (elf == NULL) {
-		pr_debug2("%s: cannot read %s ELF file.\n", __func__, filename);
-		goto out_close;
-	}
-
-	ek = elf_kind(elf);
-	if (ek != ELF_K_ELF)
-		goto out_elf_end;
-
-	if (gelf_getehdr(elf, &ehdr) == NULL) {
-		pr_err("%s: cannot get elf header.\n", __func__);
-		goto out_elf_end;
-	}
-
-	sec = elf_section_by_name(elf, &ehdr, &shdr,
-				  ".gnu_debuglink", NULL);
-	if (sec == NULL)
-		goto out_elf_end;
-
-	data = elf_getdata(sec, NULL);
-	if (data == NULL)
-		goto out_elf_end;
-
-	/* the start of this section is a zero-terminated string */
-	strncpy(debuglink, data->d_buf, size);
-
-	err = 0;
-
-out_elf_end:
-	elf_end(elf);
-out_close:
-	close(fd);
-out:
-	return err;
-}
-
 bool symsrc__possibly_runtime(struct symsrc *ss)
 {
 	return ss->dynsym || ss->opdsec;
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index f9adeb09ef00..8700c0628437 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -77,15 +77,6 @@ static int read_build_id(void *note_data, size_t note_len, struct build_id *bid,
 	return -1;
 }
 
-#ifndef HAVE_LIBELF_SUPPORT
-int filename__read_debuglink(const char *filename __maybe_unused,
-			     char *debuglink __maybe_unused,
-			     size_t size __maybe_unused)
-{
-	return -1;
-}
-#endif
-
 /*
  * Just try PT_NOTE header otherwise fails
  */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index c8795e1da2df..1152d11a0366 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2049,6 +2049,16 @@ int filename__read_build_id(const char *filename, struct build_id *bid, bool blo
 	return err;
 }
 
+int filename__read_debuglink(const char *filename, char *debuglink, size_t size)
+{
+	int err = libbfd_filename__read_debuglink(filename, debuglink, size);
+
+	if (err == 0)
+		return 0;
+
+	return libelf_filename__read_debuglink(filename, debuglink, size);
+}
+
 static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 {
 	struct build_id bid = { .size = 0, };
-- 
2.52.0.rc2.455.g230fcf2819-goog

