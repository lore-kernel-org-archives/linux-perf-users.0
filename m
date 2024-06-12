Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2C5FB8A
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217213; cv=none; b=ZmjT+EF2YTe4SzHVdvcLD41N+E+5ro8F7sP41S4L6S2pAK9hrD7dOS/Ku7j+5xoSppFWDkE3A+pWA73VZ6iEaaLvvkNlx4bhBQjyQwzORxRr41FPvCkQnDStUA6R95gouagtQBzeoLldY+qwIESbWqV+bpKGJJjLE2CY4/DqwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217213; c=relaxed/simple;
	bh=xM2OraEzCHPYA1XYxDOu/vQ1lb7fq6Wfuu93T3xy8mk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k+rUjU8oSdAXtkCYK1nmdCZGIYNRyj5UP4CBn6qpPDEk2xIMuYRIDzxIZE7JcbUTX0dJAmw+NINwdXB0mKTiYArfdv0UvfjkgSYModrvqKx1GKUmlhSsqRJkmRaJ/p5+D4z4n0fmE8lAmw5GCu+dKt0ryqM+A80q9on6iwVXuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xl43Op6X; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xl43Op6X"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6302067d548so3314527b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718217209; x=1718822009; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGJvGIe1CwvnPYERWz1EPbS43EUUz4nerE4PJ3wm8uk=;
        b=xl43Op6XK7zi980STBylFDTWGj0pMAX95odZBVnQI/iaf8cWbuaZHXRg/jAJMLv+hs
         UFariMYZ/EMdrxRXTtc1Kgrmlj0kJnSgkMGix72plsRAj9et8187Jva3ZnCuIXMKFkcA
         /biBSI6T06Ht6ImUr7O3yhHBf4ij1yQuOP9FELPJJ+ltCmUBRYS0A/To5fZlRvhkRnu9
         wdJG7YB7iIx9FAzfmi2oH0glHP/VPE6XTB0aM8tkrCXpQe0t+Ve3/SzcDLG/EVIFzokC
         Yq+hTUM+zn/YLc9zt9zpwuNXulBdWIF++zhR2pgrcMz3i+LnWGVBVVp1H51YFT8zjXlk
         B96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217209; x=1718822009;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGJvGIe1CwvnPYERWz1EPbS43EUUz4nerE4PJ3wm8uk=;
        b=uxtqFwzqe8Cvi+0wkEZxh921UZ2N49xx9tBqCc8NmUrLVzUSSphYcMvsdVlX+Yu89G
         BqHvSUjeqaqk/FZ7Ng+5APhxkEdEVfeaFQk1Ax8BIOxsfRSmb9YmxmBHebfTHE62w1/8
         FiR1JkCbIWmJ7cTVFqfJxRGUFEIl03vI6TAQQrFUEGFQRF5S8KAQhU7PvSmQ+Mu/Rx5Z
         hZQP1AT936z0kTFZ2DCRs7ys1p0y8rJSaAExK0ko2KtYNFmZ33HKfZRgzaaAIvA6rLjm
         KyelIfq6PhJ6M0nhKoPjNheKS4JPSJ7nUqEfKQwf0/zUCeC79SgjDwWbUpT8KcAfez/M
         84IQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9x6g0LmhHjzbX+3MB/oVcYPCCNlbFt0Mi1MPHjDYUcyEIYNOnetVc3s70k1tk/R+RZvVRR6UDQI9NfnLvSm8qBrum4CuLsliIAx9XW77UGA==
X-Gm-Message-State: AOJu0YxIkb/NsNnPXHFhDgezbrg6nt/lUUsRjhhLJaI3+a3I7XziTLys
	eD+rNuWQzlkV8n8VEXHNG+MZJWj7B9X/Kewz93UvQdB62KvDcfpBxf0iPJbkIa6+te9mHWkiAAw
	CBtBSRg==
X-Google-Smtp-Source: AGHT+IGXEDI7uql6mJLDFjO1+Fqeh1AyLA9O3UleyCaiFC6kUY86MVaz89Z/OC+PlyfjDDJprAmYcNiyixd1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:959d:4302:db0e:d12a])
 (user=irogers job=sendgmr) by 2002:a05:690c:6605:b0:62c:ea0b:a44e with SMTP
 id 00721157ae682-62fb97e690dmr7848007b3.2.1718217209459; Wed, 12 Jun 2024
 11:33:29 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:31:59 -0700
In-Reply-To: <20240612183205.3120248-1-irogers@google.com>
Message-Id: <20240612183205.3120248-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240612183205.3120248-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v1 1/7] perf ui: Make ui its own library
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
index 5c35c0d89306..350b65088fc1 100644
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
2.45.2.505.gda0bf45e8d-goog

