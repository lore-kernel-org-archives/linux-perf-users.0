Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C58D37A83F
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552932; cv=none; b=GAyMBR6n0vGBLOLe6PLSPNejUscHl9sfzm83jUvJoHrD3shKYbmW5JvBpPO+O8QbSTbOvBKctCgcOxLHzOG77UCyDHdoQ593mAG/6B6IzTQIGGDgECidg+L9r7KKDD6KemHLSFO6mSmNrviQmrEFRNkHZ1uvzbnyK35RYZUm7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552932; c=relaxed/simple;
	bh=gMaNXf7xJjOQ+qdNmKmHhulbQS0EBessgU12SUxZg28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UEdsZRUWBqeQGT0JHs4dZzGbAZjlfKVqA+vSvVKXrbaYKXYfqcbQ+u3G2+3+/C74Ti2KotLV7hi/wIEljnpN6dRSEO+hUn6gpSEG8HY32kOYAx5q0cgZbkMuCFDX78jzC+Q25z8qPJsBQUagI59pI7Eqq0/WNYUrT9NAylSMr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUD+RZeB; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUD+RZeB"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so4554508a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787552930; x=1788157730; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UgqPKMSInHAUx1W1Amw4siLEmTlfxJRfowC3pdCETa4=;
        b=pUD+RZeBpTwUTE6MQ7/OuLhVF+A/ZwMZApmlqTNVeAojcrZ7x2xpYML1VUHmrfPqH/
         UogRH5UKH7UKn1Nj7bMW4dfwlSol3c8+He55jQBn/oSNrX7XK+cRFnN8sYvPFc0F6anV
         GHeRoKsgWG9d/yOeAcOQMRMEQowelzcSwIaYNi0LL4Dv8fVjOpRHLRA8xBn4pJX24KZu
         /ecI7omBaRNZ3MON+XHjApp5PZMjQWk/y6NZ/0GnZz6mKlIBuMorHmYLZvE9FgDmfPtY
         gBqbVAO9f3dor5jLxqWWb+UVNsrYNcmt8HLHUEyE8KIp8v5XKMCCzgxvZtfe73YT7joL
         KNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787552930; x=1788157730;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UgqPKMSInHAUx1W1Amw4siLEmTlfxJRfowC3pdCETa4=;
        b=r7PcnO4jlywvItgO9QkE1S2/84iC6ubtdFF7W5iiGI17GUOY8D7Asmv6kePGsAapXv
         6PlD4VpViB6uMfA5kudxgHyZaNksvbCNbhhBELhElW5s4UPiXIz//XYjomrSDuf2LGVW
         kNmjDan7Tt3YtBeLM6UX7v9mE3JONn3ubrtizGVPko5BHpBODTCnzjc0JrXDjzOKy4Cp
         5h2xNN++lHPXl78X3cqLSuft/5XM0ZArryfIC68dCfD3nWeZkElfpoo1SLnC6aE8r75V
         Dd6xn9a6WRpSvqnk0C6TX2aWKwt5Rgq6qNQY4Q5IlBCFfugfO0pR2EFixaqRgzFE0ZlU
         b0sQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWByHC1LBcPebuwIISOEoiFZrmhWSNrnysCVwtfOOmNeRcQg21u95zU5nmOTTBGjT7HRsnIJGpdYUs6v6byLUX@vger.kernel.org
X-Gm-Message-State: AFuF++k9KH8M4ROTfakBCpE5YQXhkOrAZoEBUv2iGVAYX/YTfYhB7T4k
	lAvTV6YHqY0lkWvK2K8Zpmd0/MJRkRup/gTtSTCozIzKXHNuBNSeCUaA+KFSJTVTZbK09qSrbsk
	xCCEI5Ie5Jg==
X-Received: from dlbvv2.prod.google.com ([2002:a05:7022:5f02:b0:140:f3ca:6a02])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5646:b0:381:28e0:6259
 with SMTP id 98e67ed59e1d1-395c36fb278mr45944849a91.9.1787552928935; Sun, 23
 Aug 2026 23:28:48 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:28:40 -0700
In-Reply-To: <20260824062841.1529489-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824062841.1529489-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824062841.1529489-2-irogers@google.com>
Subject: [PATCH v1 1/2] perf libdw: Pass dso_name explicitly to properly
 anchor split-debug builds
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tanushree Shah <tshah@linux.ibm.com>, 
	Michael Liang <mliang@purestorage.com>, Alessio Podda <aleph.pi.gh@gmail.com>, 
	Shimin Guo <shimin.guo@skydio.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When resolving source lines via get_srcline(), srcline_dso_name()
explicitly checks for and returns the split-debug file path
(dso__symsrc_filename, which is cached during dso__load()) rather than
the default executable path (dso__long_name). Because libdw__addr2line
defaulted to dso__long_name without accepting a passed dso_name, the
Dwfl_Module was hardcoded to initialize against the stripped
executable instead of the intended split debug file.

By explicitly passing the successfully resolved dso_name down the call
path from addr2line() to dso__libdw_dwfl(), libdw accurately anchors to
the dynamically discovered split-debug file, fixing dwarf resolution for
these binaries.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c |  2 +-
 tools/perf/util/dso.h                             |  5 +++--
 tools/perf/util/libdw.c                           | 10 +++++-----
 tools/perf/util/libdw.h                           |  5 +++--
 tools/perf/util/srcline.c                         |  2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index e57f10798fa6..f7dd27faaec2 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -152,7 +152,7 @@ static int check_return_addr(struct dso *dso, Dwarf_Addr mapped_pc)
 	Dwarf_Addr	end = mapped_pc;
 	bool		signalp;
 
-	dwfl = dso__libdw_dwfl(dso);
+	dwfl = dso__libdw_dwfl(dso, NULL);
 	if (!dwfl)
 		return -1;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 55c4aaa53c38..3271e1ecaa9e 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -380,9 +380,10 @@ static inline void dso__set_libdw(struct dso *dso, void *val)
 
 struct Dwfl;
 #ifdef HAVE_LIBDW_SUPPORT
-struct Dwfl *dso__libdw_dwfl(struct dso *dso);
+struct Dwfl *dso__libdw_dwfl(struct dso *dso, const char *dso_name);
 #else
-static inline struct Dwfl *dso__libdw_dwfl(struct dso *dso __maybe_unused)
+static inline struct Dwfl *dso__libdw_dwfl(struct dso *dso __maybe_unused,
+					   const char *dso_name __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index 4ca7e7e4fbe9..f53caee980b0 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -25,17 +25,17 @@ void dso__free_libdw(struct dso *dso)
 	}
 }
 
-struct Dwfl *dso__libdw_dwfl(struct dso *dso)
+struct Dwfl *dso__libdw_dwfl(struct dso *dso, const char *dso_name)
 {
 	Dwfl *dwfl = dso__libdw(dso);
-	const char *dso_name;
 	Dwfl_Module *mod;
 	int fd;
 
 	if (dwfl)
 		return dwfl;
 
-	dso_name = dso__long_name(dso);
+	if (!dso_name)
+		dso_name = dso__long_name(dso);
 	/*
 	 * Initialize Dwfl session.
 	 * We need to open the DSO file to report it to libdw.
@@ -163,11 +163,11 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 	return DWARF_CB_ABORT;
 }
 
-int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
+int libdw__addr2line(const char *dso_name, u64 addr, char **file, unsigned int *line_nr,
 		     struct dso *dso, bool unwind_inlines,
 		     struct inline_node *node, struct symbol *sym)
 {
-	Dwfl *dwfl = dso__libdw_dwfl(dso);
+	Dwfl *dwfl = dso__libdw_dwfl(dso, dso_name);
 	Dwfl_Module *mod;
 	Dwfl_Line *dwline;
 	Dwarf_Addr bias;
diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
index b12094737415..4bdd28d44e25 100644
--- a/tools/perf/util/libdw.h
+++ b/tools/perf/util/libdw.h
@@ -25,7 +25,7 @@ struct symbol;
  *
  * Returns 1 on success (found), 0 on failure (not found).
  */
-int libdw__addr2line(u64 addr, char **file,
+int libdw__addr2line(const char *dso_name, u64 addr, char **file,
 		     unsigned int *line_nr, struct dso *dso,
 		     bool unwind_inlines, struct inline_node *node,
 		     struct symbol *sym);
@@ -40,7 +40,8 @@ void dso__free_libdw(struct dso *dso);
 
 #else /* HAVE_LIBDW_SUPPORT */
 
-static inline int libdw__addr2line(u64 addr __maybe_unused, char **file __maybe_unused,
+static inline int libdw__addr2line(const char *dso_name, u64 addr __maybe_unused,
+				   char **file __maybe_unused,
 				   unsigned int *line_nr __maybe_unused,
 				   struct dso *dso __maybe_unused,
 				   bool unwind_inlines __maybe_unused,
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index b082178c279b..8e954f0c860a 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -155,7 +155,7 @@ static int addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
 	for (size_t i = 0; i < ARRAY_SIZE(symbol_conf.addr2line_style); i++) {
 		switch (symbol_conf.addr2line_style[i]) {
 		case A2L_STYLE_LIBDW:
-			ret = libdw__addr2line(addr, file, line_nr, dso, unwind_inlines,
+			ret = libdw__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines,
 					       node, sym);
 			break;
 		case A2L_STYLE_LLVM:
-- 
2.55.0.766.g2966f0265a-goog

