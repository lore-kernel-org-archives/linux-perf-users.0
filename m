Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF015622E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321506; cv=none; b=E9lAZpc99ia5YZ0sXu3MiwGMjaaF4pilYXUz/TIVyFWo2j9HU9pycKH0oXpCaKPcnmipa8s2ZW95sdf6vxDyF9ZODo//R3c23pJoL8wH/zty1oLKPnkECBTpjANwljPFJZnHozbVx8WqZjPtHvS7BBsdsh3Dg7UG3dmCtUnxZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321506; c=relaxed/simple;
	bh=rFcy+S2+2TKAedCtBmi8koJqecDAqvQ96WMKLQwJCVE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Y8kQujKLYDcifc12ZnowAqBks9zMadDPsrk1mmUh2/ETkBkD6JQs92Hk9/UPjOWyLBTLs89tRz7lvGnWS52TaBMKOAArS+fGyJXg+0+kjsVwYVejxx3UCz3lwn4des7Mj/aLauwdYAQ5vsdNgDQe3jxR7o9ETr4s0ovPV7VqaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bX8QD1l7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bX8QD1l7"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-631b498f981so13954627b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718321503; x=1718926303; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+7hNL7GU/EnUYuEiQpshzYvHRCk9RdYS1NEyctZDl4=;
        b=bX8QD1l70xe2wkNwM/mT9kDZR9IsbViT1kmFgT8bJ7BJYTAAWJFfMeSUSW0djdwLAK
         +7HS8N+OpeAOzdMhnHmLd5eh3ERWMSL+cHWMabVCSLLqAlhZKQuNH9i0m9l2ep5WxTNt
         Zl0iAT6cnh9zXFmtRXTGlaGx5kMhJRXkwhW2TLdGHwWFsLh9FqfGK1ChHTtmKTRB6Mye
         hpMGUJkkF6dJKTjSDKDviHLGaUEiKePpn7Si6MbY82+PSJNqhdDnU41umWgyr5voFtM4
         Des/mtO6Z2f8WcybOPDe27HUMNWhM6XG1eHIK+n0U341X+Uhc/prm5LM0hZbwDNp4BKY
         WCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321503; x=1718926303;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+7hNL7GU/EnUYuEiQpshzYvHRCk9RdYS1NEyctZDl4=;
        b=CVTtvzCiE1wZbEoNhn0dQc/ZihE4GOaEnkF04zLI1D7bPDBHihFEuC4VteQQUorJHD
         ziL1oBBX91D9ieE6KVdyI+W742kDGjCAWahSRvPw9hzgbdLXqy/ceNGRitpNul+ZU7OZ
         Sf5rhfCOPN9crPBDMPbXDETO5HjbbxMvsz09oWGT8WHGmbpVwT8i0m1lXv230zXjrcUa
         gG0yygOHuzuIkigcCUbz0HTMb9UmEPpJCPMPjf4qAr1XfC75SvNVwa7B5j6GYhNhlsIX
         17ZCoPKp3UzheLy6xMBhbuTGsjpjnEG31pZvcknl4uRWPCUDpxwzfy4JqXkq8ltjshis
         FMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnUn/9yRXZldWznridfCD0UnK32uxNlAns6/8irA+Fbbi1ADlQQ3oEjE5vg46mwXVeSSETl2SYauq+2O9x2xIhLoioR/ivE/+6HxJa/U+Y1A==
X-Gm-Message-State: AOJu0YwyItJuzBC3ktENUX7TF9aHP840xCl7i0NcO1pYhCZNTBoc1Cf/
	gLe2QWI4ikS2Gt53HEvusNbcO7JzlFuDFMOSQYdvF9bZ1lbJW4k70x6aAWWkpGFnxH+bBfy0jye
	vuZTmjg==
X-Google-Smtp-Source: AGHT+IFn2/Zt1q3vLtrOIzuqJ1p4Eu87kh7DLSgs2XgUvKC7/KbRAInI64oUnn9ccHvLPYSIt3Qb2v5r0Lgf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:690c:19:b0:62d:cb6:1cff with SMTP id
 00721157ae682-6322235c1e3mr2906847b3.1.1718321503168; Thu, 13 Jun 2024
 16:31:43 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:31:16 -0700
In-Reply-To: <20240613233122.3564730-1-irogers@google.com>
Message-Id: <20240613233122.3564730-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613233122.3564730-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v3 2/8] perf ui: Make ui its own library
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make the ui code its own library. This is done to avoid compiling code
twice, once for the perf tool and once for the perf python module.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Build             |  2 +-
 tools/perf/Makefile.perf     | 10 ++++++++++
 tools/perf/ui/Build          | 18 +++++++++---------
 tools/perf/ui/browsers/Build | 14 +++++++-------
 tools/perf/ui/tui/Build      |  8 ++++----
 5 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index b0cb7ad8e6ac..16ed1357202b 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -55,7 +55,7 @@ CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
 
 perf-y += util/
 perf-y += arch/
-perf-y += ui/
+perf-ui-y += ui/
 perf-y += scripts/
 
 gtk-y += ui/gtk/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index acc41a6717db..c5a027381c55 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -425,10 +425,14 @@ endif
 
 export PERL_PATH
 
+LIBPERF_UI_IN := $(OUTPUT)perf-ui-in.o
+LIBPERF_UI := $(OUTPUT)libperf-ui.a
+
 PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
 ifdef LIBBPF_STATIC
   PERFLIBS += $(LIBBPF)
 endif
+PERFLIBS += $(LIBPERF_UI)
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -729,6 +733,12 @@ $(PERF_IN): prepare FORCE
 $(PMU_EVENTS_IN): FORCE prepare
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
+$(LIBPERF_UI_IN): FORCE prepare
+	$(Q)$(MAKE) $(build)=perf-ui
+
+$(LIBPERF_UI): $(LIBPERF_UI_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
+
 $(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
 		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
diff --git a/tools/perf/ui/Build b/tools/perf/ui/Build
index 6b6d7143a37b..d2ecd9290600 100644
--- a/tools/perf/ui/Build
+++ b/tools/perf/ui/Build
@@ -1,12 +1,12 @@
-perf-y += setup.o
-perf-y += helpline.o
-perf-y += progress.o
-perf-y += util.o
-perf-y += hist.o
-perf-y += stdio/hist.o
+perf-ui-y += setup.o
+perf-ui-y += helpline.o
+perf-ui-y += progress.o
+perf-ui-y += util.o
+perf-ui-y += hist.o
+perf-ui-y += stdio/hist.o
 
 CFLAGS_setup.o += -DLIBDIR="BUILD_STR($(LIBDIR))"
 
-perf-$(CONFIG_SLANG) += browser.o
-perf-$(CONFIG_SLANG) += browsers/
-perf-$(CONFIG_SLANG) += tui/
+perf-ui-$(CONFIG_SLANG) += browser.o
+perf-ui-$(CONFIG_SLANG) += browsers/
+perf-ui-$(CONFIG_SLANG) += tui/
diff --git a/tools/perf/ui/browsers/Build b/tools/perf/ui/browsers/Build
index 2608b5da3167..a07489e44765 100644
--- a/tools/perf/ui/browsers/Build
+++ b/tools/perf/ui/browsers/Build
@@ -1,7 +1,7 @@
-perf-y += annotate.o
-perf-y += annotate-data.o
-perf-y += hists.o
-perf-y += map.o
-perf-y += scripts.o
-perf-y += header.o
-perf-y += res_sample.o
+perf-ui-y += annotate.o
+perf-ui-y += annotate-data.o
+perf-ui-y += hists.o
+perf-ui-y += map.o
+perf-ui-y += scripts.o
+perf-ui-y += header.o
+perf-ui-y += res_sample.o
diff --git a/tools/perf/ui/tui/Build b/tools/perf/ui/tui/Build
index f916df33a1a7..2ac058ad1a61 100644
--- a/tools/perf/ui/tui/Build
+++ b/tools/perf/ui/tui/Build
@@ -1,4 +1,4 @@
-perf-y += setup.o
-perf-y += util.o
-perf-y += helpline.o
-perf-y += progress.o
+perf-ui-y += setup.o
+perf-ui-y += util.o
+perf-ui-y += helpline.o
+perf-ui-y += progress.o
-- 
2.45.2.627.g7a2c4fd464-goog

