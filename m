Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF517F375
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351691; cv=none; b=DY6JIvMja3hMIVAPuB96QgoKEb/FTzSGdPezHCC48zG6LT6Gg12by8xzcF430ax040kz0t45Gxj+11oPeSeqSQ7XsPknBx4mzltZMHcM/btq2VJ7sqpD3zqN3lvW/30H8Znr2IcmlmrVt6AaHwMapx8xqiIWyzXdA5OeqNF9uck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351691; c=relaxed/simple;
	bh=bwtLI3Jcufku622sK4AUh1VaGsI4g/AsTLwYxdou9H8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bUvbfGjpQhwlCj3Eg+Y1GpvdnrMWuextjJ0FuD6KxAXTppX39uzWzMmqGG6n8k3W7zhmr9XKPrrH/Cm7kHJ8RCe1YMefa6+ZVgsZLddbKqQkfn1R9J52Ml7IGBa5XZg2081jBCX1fLEf/9tFjvR+g+7WI90TqKQtremLZiMJkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2Uj6hFL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2Uj6hFL"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6438cfe5af9so78722947b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719351688; x=1719956488; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jtxp0mR0wazQJ0QHy8snlQ9f7IXPyviJrJGWoRkeF4=;
        b=q2Uj6hFLsAdKOeELndGjConhoS658D28BYTFM9GQ9ACQIkdIayNhca5+Rv+gMbwQIL
         L8+Dxcc19/3B5GKr1KiRQetPeWJ01ssnQrjDKC5TtSM6IM4ciqxKqzKrPgE3xxWTAlUF
         aeR/eytXAeJFVXR0X9wWlyVTRHlIIZb4WyyOv+I4C1mEcFcenFzya6tyBsnS/3a0dSYD
         o9sTwZTDoWQaetIZL86YBn545XGfFbi2EHWzv+i1y1Xk8OFY/DYyLHwmSnO65YiahLto
         4vXBYNIK2uVeqjYmj9jcNpIJqxO+8z1D1+kDaB+3MXmA5N67kYhLtiTOJVxoqigQoLyV
         sKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351688; x=1719956488;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jtxp0mR0wazQJ0QHy8snlQ9f7IXPyviJrJGWoRkeF4=;
        b=e5nK+hhMRVHtvHrZ0xQnTEy+EsjnAUCtKthJzEpOBq3KRmX7fFpxW6ceHF/qPtZS+R
         yT5XdNoojYTtnKs4saaRZ435UXbBsyij4k4HhKLtMZ59q7mJApm3ptnTfZp57Gd/hUEE
         vclVWmE8PgkWxVWxGv/qpXAXhoO2JdPfmG0KrVE3bM5QEeOFbG00jVccH4oLBZ7UWXxw
         9xGfFUovT/iYZ4ko3mlTtWxoJgYTLwKTv9x7HtCDPvEVYQj3wCD1onI8VXpRZ4E/KmFd
         aipj2jNm38Tsotz6z/LEf+41VyAwCIcf92EsaZQl/H8XVpXRgFUX2OZxLlZKVUAQvQd2
         moog==
X-Forwarded-Encrypted: i=1; AJvYcCWBehzsAqiEiibnp4QHpoa1HhfquRAfZskwaZ2OzyPMRRYYBPEp5qTR6FardbWA5Axk6s67dsFgAqjRNCj6tMnwyKDhNqxtThD3eCfvrhW9kg==
X-Gm-Message-State: AOJu0Ywj23nW+Dra3a3V5PMNiJqk1A+CCeDpFVwGBAEixBxz/wG8A/dG
	ldJP9HYGMETMMAylmZWU2QFWZO/aZcoDN6co1nJtWORq2D/ABlleVuQWpKE4ci/HQQWchsbKWsI
	B/CEXbg==
X-Google-Smtp-Source: AGHT+IEqpHMY/PPtc0hzBnoY6UQPAQ6fP/kxnOlvyQiEDGBFgD3xE956igXL9erX+1EydnCMwNQI2cg/pyd/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:d6d0:0:b0:dff:2f78:a5d7 with SMTP id
 3f1490d57ef6-e0303edb955mr134350276.5.1719351687643; Tue, 25 Jun 2024
 14:41:27 -0700 (PDT)
Date: Tue, 25 Jun 2024 14:41:12 -0700
In-Reply-To: <20240625214117.953777-1-irogers@google.com>
Message-Id: <20240625214117.953777-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625214117.953777-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v5 3/8] perf pmu-events: Make pmu-events a library
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

Make pmu-events into a library so it may be linked against things like
the python module and not built from source.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Makefile.perf | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c5a027381c55..9640c6ae1837 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -428,11 +428,14 @@ export PERL_PATH
 LIBPERF_UI_IN := $(OUTPUT)perf-ui-in.o
 LIBPERF_UI := $(OUTPUT)libperf-ui.a
 
+LIBPMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+LIBPMU_EVENTS := $(OUTPUT)libpmu-events.a
+
 PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
 ifdef LIBBPF_STATIC
   PERFLIBS += $(LIBBPF)
 endif
-PERFLIBS += $(LIBPERF_UI)
+PERFLIBS += $(LIBPERF_UI) $(LIBPMU_EVENTS)
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -721,8 +724,6 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
-
-PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
 export NO_JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
@@ -730,18 +731,21 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
-$(PMU_EVENTS_IN): FORCE prepare
+$(LIBPMU_EVENTS_IN): FORCE prepare
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
+$(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
+
 $(LIBPERF_UI_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=perf-ui
 
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
-		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
+		$(PERF_IN) $(LIBS) -o $@
 
 $(GTK_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=gtk
-- 
2.45.2.741.gdbec12cfda-goog

