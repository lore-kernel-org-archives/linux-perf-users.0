Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0517CA0F
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340958; cv=none; b=sVUgt90u8kkbhG3O8HRlCw/9zxfekEoMFF2EoyUSQnmxd6YD1H2f+VBt6jflZkLmBxThSbpRaeXLgfZniUQDYn2wXfutJVbzHubII919Cs2nAKQYVkKdDdC9pzebms2tnZJdrPSNE405xDbE5PIzLtKbtefp8pPDcWXCMyu9ta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340958; c=relaxed/simple;
	bh=XCcoFDUSO68+IaAjxY0zcTXTu1PIqW7TvqckZysWY14=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QvMZ2Ld2wS5Ie52YprGQ27HMYgJjnMxLennfiW2g3yaiOhUSL3AOuYa5zNSaG54TECKKQCFET81Np4QLwBUG4Xejqm9FObuz+0ta+41jrqGfiOYRZObMiH+ncrtcv6Wn2YqnaQgKGTnMhR+B5p0Osj9Z8T/i9UhZBRc0KzdJSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+OSqN1j; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+OSqN1j"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6311e0f4db4so130017007b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719340956; x=1719945756; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNKhk3i6ZR127Ku5IVQOBYSjQPa/zZMsU20LfXii9LU=;
        b=S+OSqN1j/qvLashEyPjdZQmX6vF2cMZQLGy60cP6tIa/Dh/F9fzmujZAiAi2XlFatY
         gRoV0AGob/tLQXN9ZHSFfsCtpPejfiNqWlFa+PYLVB7WsW9qktApwN2+JncHgfPlZULV
         RPW92UXJk6TqagseLh5qW3cwTmN8PpwWrrkJjiG+habfNLmLzVlM8WpzXA8/uBO5ffI/
         +3P8knhTcPryVAYvAVVatDBz+5EGinLM9egAoFW04XZQC4k9pb7U0i+wwHXXa3CP2cw5
         5OuCfF6vtzEiCSEUlPoMA6c9ckEPGsHaDwmWXzyHWd/fXiE+4l80LtKf6oXDXRoIZQwj
         r38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340956; x=1719945756;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNKhk3i6ZR127Ku5IVQOBYSjQPa/zZMsU20LfXii9LU=;
        b=NqZrZ6tcP7Dt3XSzoEqnTWvbXD06hBoAQGeB0Y2s7RLFzDsO54s3JaDBiowOkc7nbf
         MMEX3bEAVj5xxFQdmquiMbLioCe/bkiq10Ujb1/sPZJWcHyvM6kebll0vIV985CAy7h+
         Mk9QHg5jOrRLbBHqy0v+zqXDV3EdyRqH9K2KwixYY72eneBQ6KSlMx1525iKrYpknwse
         kpDkstzuK2VtEE7X6rtj2dMwt3mKTcGikwHIt2BTIUnHs36Wgcf3A2RVYrTB7s7VH5n9
         c0w2mPun8r4/aSsO1r/7Zag2DBxdrEUUztknc6pH1E11NTSSxPqhhXtyzH/Ptkgtrrwy
         PQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkl3meERkNLSqCdogByU52IWzZbU5V/HWzWbeVy0BnDkxQ6xoCE8RnLeITvRJjBWa7aSL9FhGBzD37ngOTJrnitESWSRcowFbv9xvVji9OwQ==
X-Gm-Message-State: AOJu0Yy7t+U4g2wN9SBL+SgiPLNKh29v7418o+Fa3S94mZX5bsFypbhT
	eAdHzxHK+ZhUDEt7/MRifJuiTm17/BJutjnMSKvJIsywXCFQjh/NWpaKlNEAbG9qiayYBN5qwtR
	hSFM0SQ==
X-Google-Smtp-Source: AGHT+IE2knK+SqiP/3MRcV2ZoKoDhmC7Z51zU81w59tOSVa7+OtakO9/inMolJXvN6wS2iet4Qv6IJqkT1eX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f08:b0:62a:2a39:ccd9 with SMTP
 id 00721157ae682-643ad9aa0bfmr5402067b3.6.1719340955895; Tue, 25 Jun 2024
 11:42:35 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:42:19 -0700
In-Reply-To: <20240625184224.929018-1-irogers@google.com>
Message-Id: <20240625184224.929018-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625184224.929018-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v4 2/7] perf ui: Make ui its own library
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
	Nick Terrell <terrelln@fb.com>, Andrei Vagin <avagin@google.com>, Kees Cook <keescook@chromium.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
2.45.2.741.gdbec12cfda-goog

