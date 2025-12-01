Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB492773F7
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622548; cv=none; b=Fm0CaWDISUSfheTeaw/jBL+MtwQigmdwx6KAbSGTHBeoeRKoNzxwfpvSumeQjpqhjPWOzQrW2+a2Wmt/gdYZIL6SvGF08cQtk/HVJNsry9VCUjJHaTb6VzVpsRsAryh93at5CUequDe5YzzAru/zpkdaV41KW8PjDk9lo4l5qUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622548; c=relaxed/simple;
	bh=fjLI72kegeSJqfZ6jGUOurYAdTweSGw5ZtcUlLf1AoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Q2NmhZOmKebP7S9uiOzILLx5SF2OkLn1zc0Udu35ud3bu8tvkL/cE31JMKn0wP839ybnmPmo4A+4nU7EXkJi9H3FmXaus8uO45KSGgtBpQA8q0aJ56C0QCOvLiAJhTroWU4TwLIWPCNG0NQrK063SPX9+cnz74a6tHnscoa1drQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYHQy8Pv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYHQy8Pv"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc240cdb249so4157719a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764622546; x=1765227346; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7HvpJfXVkoUBz8+ZXfXdSN3qFolYiwgdTVJfU/maPo=;
        b=IYHQy8PvH+rEkVJaR55cp0WNy5u8nfe9lJSRDg4bp0Gr881BEwJwvlZOZqrzp8kOo7
         QPsAT5gJoc51bBr31IzBmobLUf936C+quSi8d/z9xem5VcOqUAp+hfmNQBXisvsiUoVX
         P9hs9MagOHUM7aGfzbjl8/faE1KLLFXz1O/Xxs9PltShAv7ZG6C79a/412kgkW6uBmvH
         ASG9UJYbjVkYqOiNCkRCeTqfWJlm27y3tZW+6+N9J9lO5FEGTjQMSzwenVdLKl+RivBL
         hYOlEeJ2ZJmeTSTAyJfrDUKsDs/zcO9Y4++3L2+/hg/emch84nsIxgSzxDUzPQ5uCYCB
         mvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622546; x=1765227346;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7HvpJfXVkoUBz8+ZXfXdSN3qFolYiwgdTVJfU/maPo=;
        b=WDzp23BtBso4q9Qsw2SZx3bXwTrbJvynQYeSNNfJo3EFprDseUCXVxQ8BCZFkidENH
         I27Zp6aAXJxBmj+UIbmq8kJV758pjT6qb6huIhGo/xYpCA/GdclSzKptaGCO0RZCSL3v
         rVlHPX522Llu4d7FSvXajI2fgWPq4Li7z58KTJmEDG02IaIOemyCxYQejX809pJOpglF
         Ky3McCzBfonul8jquo33FR4/v0k/ZPe55CPmy06gytNZ+eiMVxth3nQsVUoMlmMnuJpU
         9ODam9K5Zl7NGgHosv3FEuJ4tJZB6qqDKs7X8hxKTF3Td8bUXBp7wzSpa141yEdJUNVY
         LP1A==
X-Forwarded-Encrypted: i=1; AJvYcCWpb9FmFURyiHBFggfWYJ1xcSvQD8yMz5X0XmLD/zR/26f99XxN3wwRsNcWB1VLo+JcrYEQUgDnFofqJtz8ynzJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTdLLeUgi4k0iJytfen3AUa9UmGFSKFki549q3QJvSb8XoHeQ
	7eGtro1cFbRlXThfMVGQ/aK4aYgETbg2CMW+S9XbSA06mMI6t7F2nxusb1wxg+69nNry2kcvn2X
	f7EZBdqlQHw==
X-Google-Smtp-Source: AGHT+IGOxiUBhvMxSqyCELGqzF5enfB5jhNuSSvdzglSimtj4YnpmrdDi5VRYzuCfIRwh+KGF1PB54ol3qFa
X-Received: from dybqf13.prod.google.com ([2002:a05:7301:648d:b0:2a4:7cf4:5bc0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d4cd:b0:2a4:5eaa:a9a7
 with SMTP id 5a478bee46e88-2a9415730cemr17893504eec.1.1764622546182; Mon, 01
 Dec 2025 12:55:46 -0800 (PST)
Date: Mon,  1 Dec 2025 12:55:06 -0800
In-Reply-To: <20251201205509.195451-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201205509.195451-8-irogers@google.com>
Subject: [PATCH v2 07/10] perf symbol: Use fallbacks for filename__read_debuglink
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
index 8fb7bf743ca6..9ceb746b6c59 100644
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
index b71cf8caf282..445307f230af 100644
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
index 8d461974a69f..da75a1c159f2 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2050,6 +2050,16 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
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
2.52.0.158.g65b55ccf14-goog

