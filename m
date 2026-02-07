Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F43308F3D
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770452687; cv=none; b=ADPYl5cG7323HHY6ZVnTeQjl8rSxIlOyh4Hpndhmb7o8Q8Tu82IzOe9adqMT2ZBViwFZrHDNLXY16STdRn3WsNqjSZi51Zu3MxvY1rS1cNMdX5K8GKwRnzE1GDf+Ylw7X+tItIEttt6uF7hz9G5l+luF6FlRBqkJ9wQtD8utjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770452687; c=relaxed/simple;
	bh=fQNe+C2ykGl+VIgRxAFw4P2gpNTolHEt92EQYWoDGj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VDEz8Kk3a/pY376XruO1UHjKaqPp0BRsXIJnvp1L1eaVjPlmoNCoWn73PyDEODvQ08t0IeYaOtcFhE7XUYjGE4RJmP8mwEWA8Lwh1bbjYntVdUjvi/XbewryZBBsHa7n1yu4OCGudPSO2/e5l5OjnopIGfbtHag2r2X5yXx+73I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+HH3+XM; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+HH3+XM"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124627fc58dso5171812c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 00:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770452686; x=1771057486; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HR0mAxChVDTPD1V2GKemhoMM82m58RwfPlVP6zevyfU=;
        b=Z+HH3+XMdZ2TgXrQaUwMSMmzC6fX6MC1wmGeRBsjZ6uzmNcU9c7NKdW6xRjUhDyRnM
         0mpAfr1FlP6kYfDetwQ8UAwLUur9QqHjWdZ+LRPUNhsGpnSpI9frI2OcAzwBbh3uw7ef
         V3BNlnWFhd2D7/05B71hkIMxr15t49Q7m1Pa5eswIci7gWttrhBISMjAwdzBX3LI3nYx
         /c9vUwvmMMvu3MUKBKWco6mihxkPR5SWiOB1MfnBJpnvVE47nPu4Ho6za63OjuR3FWGv
         ngLFcjiIQuLl2oO5OC/lrxNEZaP2Ywf6v6kVxrGY5dYPUQazgdhTBhDMQbFGR77nVGYg
         fhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770452686; x=1771057486;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HR0mAxChVDTPD1V2GKemhoMM82m58RwfPlVP6zevyfU=;
        b=SUSHu2WQ2jHyt8JVAlaZ+SDfhC48WADyes2fLJrObQh/Z6GMiiTXFCdU7tU/kjjShb
         KjnX9JnHL+JPHvQk1uK/HYq4brlek22iFIqtJKa9SpMvO9aCXKwtzVFfMx2bPoGGX4fz
         octhke/9F5dW/JmOgYQplXKdzIayIvEKSNgmmjezEqqFdOitE1+beSh//Gfj+8ICiiyA
         KJbV1yexp6xnC7zbcWspKyQyXTN3LV05mWoQ5InbVpJYTK84hmeRGujWZ53ZlP1mPUCj
         s8I2xMtjT7lJB0vEde1k9eEEBBk2zLUOiDM8qyN+m6IzhNpQTfnSgJO27li/C1mxb+OB
         8yRA==
X-Forwarded-Encrypted: i=1; AJvYcCX1IQu2l4gWB3xxFASUU7VXlKvomeI0Ym7mhAQmn5tmxtXUKu9Itq/+uAaUlG+CgSFOwyvYS97Qq9rZwJZrIjWl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd82AdtlNrfaZHNFUCzp5s/W3tovNruYZLige8mjAXexI/BfOO
	Bx5juRRJfAiHT8k1yP7TpQSxqe+3v8ZahTOsMcnByyma0DwCpZVn+xavKF6DCy2vNPJknfNbR9Q
	CvloQ7cnuVg==
X-Received: from dlii7.prod.google.com ([2002:a05:7022:4187:b0:124:a7b4:135d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60a7:b0:11b:998d:bded
 with SMTP id a92af1059eb24-12704049b56mr2452401c88.28.1770452686366; Sat, 07
 Feb 2026 00:24:46 -0800 (PST)
Date: Sat,  7 Feb 2026 00:24:24 -0800
In-Reply-To: <20260207082428.1742209-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207082428.1742209-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260207082428.1742209-2-irogers@google.com>
Subject: [PATCH v1 1/5] perf symbol: Reduce scope of elf__needs_adjust_symbols
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Eric Biggers <ebiggers@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function is only used by symsrc__init in symbol-elf.c, make static to
reduce scope. Switch to not passing the argument by value but as a
pointer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 8 ++++----
 tools/perf/util/symbol.h     | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 76912c62b6a0..d7582dbf379e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1054,15 +1054,15 @@ void symsrc__destroy(struct symsrc *ss)
 	close(ss->fd);
 }
 
-bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
+static bool elf__needs_adjust_symbols(const GElf_Ehdr *ehdr)
 {
 	/*
 	 * Usually vmlinux is an ELF file with type ET_EXEC for most
 	 * architectures; except Arm64 kernel is linked with option
 	 * '-share', so need to check type ET_DYN.
 	 */
-	return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL ||
-	       ehdr.e_type == ET_DYN;
+	return ehdr->e_type == ET_EXEC || ehdr->e_type == ET_REL ||
+	       ehdr->e_type == ET_DYN;
 }
 
 static Elf *read_gnu_debugdata(struct dso *dso, Elf *elf, const char *name, int *fd_ret)
@@ -1235,7 +1235,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	if (dso__kernel(dso) == DSO_SPACE__USER)
 		ss->adjust_symbols = true;
 	else
-		ss->adjust_symbols = elf__needs_adjust_symbols(ehdr);
+		ss->adjust_symbols = elf__needs_adjust_symbols(&ehdr);
 
 	ss->name   = strdup(name);
 	if (!ss->name) {
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3fb5d146d9b1..9aa0016937b7 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -217,7 +217,6 @@ int setup_intlist(struct intlist **list, const char *list_str,
 		  const char *list_name);
 
 #ifdef HAVE_LIBELF_SUPPORT
-bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
 void arch__sym_update(struct symbol *s, GElf_Sym *sym);
 #endif
 
-- 
2.53.0.239.g8d8fc8a987-goog

