Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA71FFC59
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865153; cv=none; b=scC7AvlKsGb9ji3TuUfNKydEfplaitW3LSvW4c/HzlkgJlkg0C4F++KeTSq0vqnSnGcRHVkaf8K8b5m6JmAAR+7mwfrqZt6aydPXIcXpwNWB8sJsEoqDzsX5GAw+4WG8SqjqsCAjIC3hZoEEcyilXu7dZ6wM6b//DGI8zPKJCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865153; c=relaxed/simple;
	bh=5QMdl7eVBNTewwuuJO3lMgdAqN0GWRRlNGk3e8qasGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uO+ze+UMnL+U23vX5P1qy/3qpfwA1D2lb3PPVP0VH5zFypgOUNGqjs79VzbzpUaOU6LUAlVUTQNhpaxCcb3Dvz6eijucz2ZlztKvfSAlWiAK4pqe6TPr33RY3pC6I8+wh8iRBmQmSauMO6a4JxtGvyUVJE+s+EYOpN+wkEWmd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbWtcnNm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbWtcnNm"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bb27b422cf2so5925070a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 18:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763865151; x=1764469951; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a3m6U2A9WK68emhqbKZBFX3D9dZLpGkE+dA1a3ZMrcY=;
        b=XbWtcnNmkzhIhdX6y+Ej3cL+bp/42IWw5pCrBUlvOsTifU3NN0dkHo+XwcMMDotLX/
         LG2wetlnTiRtJ4/5RlKJbB9OSBfajQLtXZFavmoHxmvTASE3owko64NJXr/SRl+e7596
         HAwaRVYQU+1vNUv3s9sWMGG5G7zKIQBId1PVHWGJrKKmLXsS5O3tpkVpydXo87F+PTDV
         qRT+FVM/Nop03bcoA9yC8fdp3jqK3rQv8EmT2zkvH3emCB5BguVB4bMPuhRZvUq0mRJb
         KLkhpwGcH5tC+wL9jlllp3Ei/2vlWwjmcprvWi8Ck3C1SEXANJVIa85M5BHp9SlxoQnQ
         v+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763865151; x=1764469951;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3m6U2A9WK68emhqbKZBFX3D9dZLpGkE+dA1a3ZMrcY=;
        b=W33GMN3YktHGGSt2LYQuVz+fz3mda+prIzEHjZ6Ch2IbQ7ce4jptBgbnFSX8cyTiJH
         WeGOMHJCqlzmt7omy6WWPTXEJ5ztdELxY9TanFYhL38+Q26YopXmdvoW7IMTJ6ZVRSee
         5Ta85ASLHBvgKJTLcLM7gt/pXdCuD7l31csj3XHwDJvCHmYgqfeYFNmVmoazVlyMZEQV
         nLb7O+I55Ncm/SQASpRhUPKF4iPX2seuODE30RcnuMgSSkxP5VwGTVstuVt/HUZpIn9m
         ZuMlIGOYLuSqDTXStooPsfOaWG7fSaDATyu2vG8eNUefZI2mkdauu7WPAia3oLdFCkB2
         IwWA==
X-Forwarded-Encrypted: i=1; AJvYcCVEshwDmnfMB3FydCZ8UmNdVtkHV6iXNxo5JbEwC+uusW7qVBqzzB8YE6Qk5PGk1cvExVwGph8ha2s5Cbas7DoG@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJBdkZ4iFtFs8VUwqhLGsop/LZsFA+bkYg/d6Hcfz5gunpeih
	wgtJiBpEY47TJxcVmCbAf6o/Zy2hkFQ6Hoizw0c7sXdVbkkZuMdDYWTOGfs0INe2Q+B1ECDpYuc
	JRGq8wi0PiQ==
X-Google-Smtp-Source: AGHT+IH3pIkeTqQHy76r4obdhe86Ny6izg2Sh0yksr9YISTMimKKaq+pmHRF86AOvIkaLfNtdVyaVB15Gd7R
X-Received: from dybhi45.prod.google.com ([2002:a05:7301:29ad:b0:2a4:75f7:2135])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4625:b0:2a4:61d1:f451
 with SMTP id 5a478bee46e88-2a7190f6638mr3165341eec.16.1763865150882; Sat, 22
 Nov 2025 18:32:30 -0800 (PST)
Date: Sat, 22 Nov 2025 18:32:17 -0800
In-Reply-To: <20251123023225.8069-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251123023225.8069-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251123023225.8069-2-irogers@google.com>
Subject: [PATCH v1 1/9] perf symbol: Reduce scope of elf__needs_adjust_symbols
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

Function is only used by symsrc__init in symbol-elf.c, make static to
reduce scope. Switch to not passing the argument by value but as a
pointer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 8 ++++----
 tools/perf/util/symbol.h     | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9e820599bab3..5cd4844f9bb4 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1051,15 +1051,15 @@ void symsrc__destroy(struct symsrc *ss)
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
@@ -1232,7 +1232,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	if (dso__kernel(dso) == DSO_SPACE__USER)
 		ss->adjust_symbols = true;
 	else
-		ss->adjust_symbols = elf__needs_adjust_symbols(ehdr);
+		ss->adjust_symbols = elf__needs_adjust_symbols(&ehdr);
 
 	ss->name   = strdup(name);
 	if (!ss->name) {
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 347106218799..d91dc89386e2 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -217,7 +217,6 @@ int setup_intlist(struct intlist **list, const char *list_str,
 		  const char *list_name);
 
 #ifdef HAVE_LIBELF_SUPPORT
-bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
 void arch__sym_update(struct symbol *s, GElf_Sym *sym);
 #endif
 
-- 
2.52.0.rc2.455.g230fcf2819-goog

