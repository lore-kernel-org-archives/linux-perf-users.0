Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68463223DF6
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622525; cv=none; b=XXEW5HNKf+A6uaPnU6gFaCpDDOxun6fwoeC5292cPAjW6W0s7lb61z31G5lYLGH9M04wUjBkHwZCC6NB5ImVC31ciWZkcSV285+7s8S5QQnBWUtQukdTWIMBZiyaD/DoklFgqQAV59Y5wK112lF4WrNMCk2gZzIHobMRLBX3l74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622525; c=relaxed/simple;
	bh=z6FtVLqdmY2BvHaJao1xCfusHONbHKHJuP9pFmB/d0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tj8HeysAOX+sBc6LqUhouTGvv4vmtTpVkQMD+4lumiawVAxXxabStPaXSsLS4Iq0rniECK756moPNzbsCTutdrcLv0NBPpg6s1/MYKRrbN4D95dDZ+or18yZJD47cjFH7wGJW1iGPNF7cFJOm6VkW9u9mf6O22SplDnEQMemy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BeNIDYFL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BeNIDYFL"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b82c2c2ca2so7047419b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764622523; x=1765227323; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z77aYCybIIHavayyPQkrG4XKGziZQG4YhRaKisouWww=;
        b=BeNIDYFLvcrWLpYVaLbdUPxdx2AuDX4AZBdSkedivw9VyUPp+skyrPQGTSYNlwp4W8
         zcspHRCrOIXo95lRS449hGEhMfd3JNW3T2c98vw0uJ4BY23HIcBXpxxtJtA0gj02negR
         aW0E06xshfvUjC7ru0NWPeVFw2X7vYRh3nV6HQ+sPr2qrANqwEMnAn5ZrkBpO/KWt178
         CCYUcWDpu9mL8W1v47kXcfcpofFpNl9JlGGAZZFiSIUZVfyt8M3+9R4olqqmUc9j/0lW
         o/b1+XckYzRUZiU0L8McshodyTPwDTsURYxSMnuzALAbj7Oppo0X0JCOP/EsJ4TUJpBc
         NKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622523; x=1765227323;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z77aYCybIIHavayyPQkrG4XKGziZQG4YhRaKisouWww=;
        b=ButstKooMZJH2AZBEEBPijWWB56uScFrFxfPCOyQ0ztsPJIY6iD/pAdu6DQrvUZnmI
         Dd59wbyc7aVbn3yZwmhcjqmpqbOZeZP9PGTdexrsTkDKrASxD/9QdBTW0DU1TNXv1iWA
         z2sEKbj4QnFlCna+5L/c/EfOylVQRDQyiGN3FGv5Vn0bCVtaKvBRA3p+EmYlbMWBMHfh
         Iqq4wKHD9uLq+nYExAXrBcymqTACwAD6z2iPFOGJGPScfi1l9nt9GOEt2MBrtVqfoZXg
         fNXRwIXIJOjZjps9tkDzB6Dwo1T/t/8l4bduK/kGJA4iuV4u3I+hetdbHmw4rsmDxoWe
         wVlg==
X-Forwarded-Encrypted: i=1; AJvYcCXxMQlHchRbjzRR+Fbxjm5c0jmIfPhJuC/wyeb29AgZF53li3x2qwuQCgs/Hl8Zqak9TSIwRUTE8niPBZF5lQlG@vger.kernel.org
X-Gm-Message-State: AOJu0YyXi2e271DmOigQDDrXFwR1l2yWM9qfzvH/Lmmi0+yvAyyQh1bd
	iNrOfvjciZNRk3Z4HA5uO889l7mZbeT23ksMZ/qJjGNvUBFXLWmhFIff6wrJCfY8N8FqOzNhpmD
	832b1k2iwXA==
X-Google-Smtp-Source: AGHT+IEE9W5jzAEEvpyu9+iNLMSoHbvRdj4v9fElI9rpCqSB7ekTOa4+XG6BRiJddwmiLaTozOsN4F8a2pxb
X-Received: from dlbvv24.prod.google.com ([2002:a05:7022:5f18:b0:11b:a892:80ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2219:b0:11a:51f9:daf
 with SMTP id a92af1059eb24-11c9d718ef4mr24872885c88.14.1764622523344; Mon, 01
 Dec 2025 12:55:23 -0800 (PST)
Date: Mon,  1 Dec 2025 12:55:00 -0800
In-Reply-To: <20251201205509.195451-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201205509.195451-2-irogers@google.com>
Subject: [PATCH v2 01/10] perf symbol: Reduce scope of elf__needs_adjust_symbols
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

Function is only used by symsrc__init in symbol-elf.c, make static to
reduce scope. Switch to not passing the argument by value but as a
pointer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 8 ++++----
 tools/perf/util/symbol.h     | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index c5c382c3409a..f661ea6c8ac2 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1052,15 +1052,15 @@ void symsrc__destroy(struct symsrc *ss)
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
@@ -1233,7 +1233,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
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
2.52.0.158.g65b55ccf14-goog

