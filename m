Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762FC147
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Aug 2025 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755907242; cv=none; b=ZhXCFffp75Kle3zWwt7h0dZ0JK/0zwkmP93F5nUHz63MDcs7HFK0WvYezMzGCC9lckmhHP5a0NcNVFa6PAVx9QXsEhYfEio7/9fCrBSK516fT6aWFvikqbbPrb5jakBhRw0usDURm9mC+v6lRBvQACHd1eIXljC3Sm7GrsCgka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755907242; c=relaxed/simple;
	bh=Z081sHystRdEW29SSVK9iJw2aQWk5mYfgw3Kk+9n+xE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tCAz1X7FCLKRYBYvXkVyTnvQN665XaHl9Vkb42HxNGknwczojaZh7Y1bd5YiSDdTjV5vl6FsYivWL5O3CbbnWTLqICwjdAWIBySr6Pd6XtBqs5G4m7v+zv2Itvfnzg6TKYa+Lr126qh4F+lfMh7VYIDUGteUWZt6PQTiDmhL0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWvi0TLM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWvi0TLM"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445806b18aso34156965ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755907240; x=1756512040; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ULpCq4HuDiQhtLU1R+s5TkMdJZ1jHlpW8rzbARN3QRo=;
        b=HWvi0TLMuc8W6Y92ErRZcF4LYR/L0z2cE5nJZQQDQbRjEtGqKPwzlvqyDVIi7+mqpv
         0N5G/C+AlC1X34IxQzzsXOr5X8CXcMPL5Mhk0tjRJwD+w5kVRyhbIBcDgJTIvRP4XpvR
         CtwdgvOA/XC2OmvVFk+VrGXiYkseMKfPARrfAfq/J/Lu/zWGP8aPzlpruIU69NkGVRbs
         sEvAj8CQX6eJ42faQo3ur4du/HGSJXLTcZZAR8O7efkNWEPza8bsrwsSnFXgGcXjDMd4
         fx78C4+paOShO7Sd2mkH5KTagBwkrAHj3YWUTnqFHoITxLMrdJzFdOS28WHZLKog/vuO
         DHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755907240; x=1756512040;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULpCq4HuDiQhtLU1R+s5TkMdJZ1jHlpW8rzbARN3QRo=;
        b=DsimBZL4Vse5XmjOH6h5Eig51pZqyPvVuGp0b3+HcWVQegPPP0cNgx8m2aobFbdByE
         WVDZPw8DLhhx+6c+wtMaTdIC14fLX4xxlqxDDyy+/soQA5tdcdhWrBdAxZDAFcUe4zJy
         aRU0sRpefa77Kckk2lxlUVa4rvxedBQ1elBY+oMlFzIN6kZZ9mNLiC2YVrutkN0wuM9a
         Su8L1epcpMCMZLwYZE6pPGq5eFlZVkwc5lsDjbKJoNo++zU0hT9ENeSN0kvymTvCpsh/
         cXjqASI51Et42V2r3QqC6dhqysydMPENC+nVL9YmJLYCYLlrRpysPIJNFzcqip8pNUnq
         GwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOgDaa+DUijDpza6Iat3MJJqB0CShPIpqMNKbcXYYje+UhAa02ZhB1wsjkRsHr+5du4QxHhy8d2f8NPhk/RUKV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fYT2KeSeWvT4xhTL5Y59SQsJMKMQAucWv+A2WCQfT62QtCI+
	+B9I9x1T/yAqLBxNshxAxkSsva87g1QEm7EZkF7p0TD6tlqXrcg+fW4fzbEYS6mjMIylqzAn7g7
	vU1c2yOCqQQ==
X-Google-Smtp-Source: AGHT+IEx0bUgQTSlXV+L1eqClL3ijNyH9m/aIoYnt0Qb5dB6eUafXwAr9MngWqDVKVS3G/tpzT9pRJaj3327
X-Received: from plzu5.prod.google.com ([2002:a17:902:82c5:b0:240:770f:72cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f44:b0:242:fba2:b8e4
 with SMTP id d9443c01a7336-2462efaf1demr69588065ad.56.1755907240172; Fri, 22
 Aug 2025 17:00:40 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:00:23 -0700
In-Reply-To: <20250823000024.724394-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823000024.724394-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823000024.724394-2-irogers@google.com>
Subject: [PATCH v1 1/2] perf symbol-minimal: Fix ehdr reading in filename__read_build_id
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

The e_ident is part of the ehdr and so reading it a second time would
mean the read ehdr was displaced by 16-bytes. Switch from stdio to
open/read/lseek syscalls for similarity with the symbol-elf version of
the function and so that later changes can alter then open flags.

Fixes: fef8f648bb47 ("perf symbol: Fix use-after-free in filename__read_build_id")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-minimal.c | 55 ++++++++++++++++----------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 7201494c5c20..8d41bd7842df 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -4,7 +4,6 @@
 
 #include <errno.h>
 #include <unistd.h>
-#include <stdio.h>
 #include <fcntl.h>
 #include <string.h>
 #include <stdlib.h>
@@ -88,11 +87,8 @@ int filename__read_debuglink(const char *filename __maybe_unused,
  */
 int filename__read_build_id(const char *filename, struct build_id *bid)
 {
-	FILE *fp;
-	int ret = -1;
+	int fd, ret = -1;
 	bool need_swap = false, elf32;
-	u8 e_ident[EI_NIDENT];
-	int i;
 	union {
 		struct {
 			Elf32_Ehdr ehdr32;
@@ -103,28 +99,27 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			Elf64_Phdr *phdr64;
 		};
 	} hdrs;
-	void *phdr;
-	size_t phdr_size;
-	void *buf = NULL;
-	size_t buf_size = 0;
+	void *phdr, *buf = NULL;
+	ssize_t phdr_size, ehdr_size, buf_size = 0;
 
-	fp = fopen(filename, "r");
-	if (fp == NULL)
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
 		return -1;
 
-	if (fread(e_ident, sizeof(e_ident), 1, fp) != 1)
+	if (read(fd, hdrs.ehdr32.e_ident, EI_NIDENT) != EI_NIDENT)
 		goto out;
 
-	if (memcmp(e_ident, ELFMAG, SELFMAG) ||
-	    e_ident[EI_VERSION] != EV_CURRENT)
+	if (memcmp(hdrs.ehdr32.e_ident, ELFMAG, SELFMAG) ||
+	    hdrs.ehdr32.e_ident[EI_VERSION] != EV_CURRENT)
 		goto out;
 
-	need_swap = check_need_swap(e_ident[EI_DATA]);
-	elf32 = e_ident[EI_CLASS] == ELFCLASS32;
+	need_swap = check_need_swap(hdrs.ehdr32.e_ident[EI_DATA]);
+	elf32 = hdrs.ehdr32.e_ident[EI_CLASS] == ELFCLASS32;
+	ehdr_size = (elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr64)) - EI_NIDENT;
 
-	if (fread(elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64,
-		  elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr64),
-		  1, fp) != 1)
+	if (read(fd,
+		 (elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64) + EI_NIDENT,
+		 ehdr_size) != ehdr_size)
 		goto out;
 
 	if (need_swap) {
@@ -138,14 +133,18 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			hdrs.ehdr64.e_phnum = bswap_16(hdrs.ehdr64.e_phnum);
 		}
 	}
-	phdr_size = elf32 ? hdrs.ehdr32.e_phentsize * hdrs.ehdr32.e_phnum
-			  : hdrs.ehdr64.e_phentsize * hdrs.ehdr64.e_phnum;
+	if ((elf32 && hdrs.ehdr32.e_phentsize != sizeof(Elf32_Phdr)) ||
+	    (!elf32 && hdrs.ehdr64.e_phentsize != sizeof(Elf64_Phdr)))
+		goto out;
+
+	phdr_size = elf32 ? sizeof(Elf32_Phdr) * hdrs.ehdr32.e_phnum
+			  : sizeof(Elf64_Phdr) * hdrs.ehdr64.e_phnum;
 	phdr = malloc(phdr_size);
 	if (phdr == NULL)
 		goto out;
 
-	fseek(fp, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
-	if (fread(phdr, phdr_size, 1, fp) != 1)
+	lseek(fd, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
+	if (read(fd, phdr, phdr_size) != phdr_size)
 		goto out_free;
 
 	if (elf32)
@@ -153,8 +152,8 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	else
 		hdrs.phdr64 = phdr;
 
-	for (i = 0; i < elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum; i++) {
-		size_t p_filesz;
+	for (int i = 0; i < (elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum); i++) {
+		ssize_t p_filesz;
 
 		if (need_swap) {
 			if (elf32) {
@@ -180,8 +179,8 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 				goto out_free;
 			buf = tmp;
 		}
-		fseek(fp, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
-		if (fread(buf, p_filesz, 1, fp) != 1)
+		lseek(fd, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
+		if (read(fd, buf, p_filesz) != p_filesz)
 			goto out_free;
 
 		ret = read_build_id(buf, p_filesz, bid, need_swap);
@@ -194,7 +193,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	free(buf);
 	free(phdr);
 out:
-	fclose(fp);
+	close(fd);
 	return ret;
 }
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

