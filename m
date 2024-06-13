Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157C156F3D
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321508; cv=none; b=BauF26vY6uA47G42zJAYSaRYVe7ougrfyvKuxkt3t7NvEDR46qbEdJTnkAXWQe9USeKuG6+NIbPTCw5XLNzxeki2uu9Jlalufl+utGuaZ7q4i4ONVvEHytytNTf42/etLajMuswzL75qgCDhtZ5w9HmRkfPuPf3qicWLHvy0Hhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321508; c=relaxed/simple;
	bh=0n3NWiOLohwJNKVKL9gV3Koesj5loLw/lRVeMyy3BQk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hCcrpdJHl7AGrkUdAlAm8l+4LaEOrTh4lCDZJsyxvEaCFXqfCrmnv2KT1svf/BF7bKDixxaNt39mngVS9N74M/BmcCfC9v8ZmuUmqXBSfFyDJHqhOp5LhrE9SGSGeIPxXCDqqWavfw4nPR3Qd0j6aBAO319pQS+nMIKAFpreVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fPtBisXP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fPtBisXP"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfab38b7f6bso2429979276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718321506; x=1718926306; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxA/uxqQnuEGimdVVLwjMbl2Ju2kVgaw0AA0enSCOv4=;
        b=fPtBisXPeJQJTiULPQiFjCmvHHJbj/Ej6YVO8oH5ulF98wNoCyEHGl6rnPQ8MM+2me
         oihcrKKWFBOji+NM1Vgiv3B/L+6SXD16GGEZbF0Xc+LWqLJT+IHvnhv3NiH10JECHk7S
         SYYxPqCCXIqRA/cNluRAkgNW1BFdfTWqk5wt0k1e4DeptHiawJvwiG6mCCYVAfKL+5q4
         iJH7d8WLTfsgoHzjwbB8eOx99cVBzQ4z4BR1sE6lFH7DECCdTfU7jsgqRiierwwhFzLX
         QrJ7DNNEPhaYv/QK+fHOrl+D3EVN/fwUcC1NYpGgJb1+63MLAfUPDaO2yVgcQtoldL5D
         c1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321506; x=1718926306;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxA/uxqQnuEGimdVVLwjMbl2Ju2kVgaw0AA0enSCOv4=;
        b=v2tgh7XQPjpKXASNbyYaVHZkbepKNR7eojX5LzSk6x5JWf/H7AHtM+F7mxitR1b+CB
         pB4oGX2YhYll4+KFsZaCWr8b2iy/dMMOakKPIj+Ks3NDF+bTa3U2C8R8yNoDVDTiHf0S
         z1c1dnlFiJVBSk6Knn340FuEcxCgpJos7hWt8FrFA16cQk+XN5R9xtP7Q4TV2kaiE0KW
         Fz+Cu5RBojfoQpE3e0h0qDi6N3BMt/yC6eR4HxgKb+JUOjT+Lh6wfULx0ci2ejVr5JST
         fvssIQfsCGP1r/RgrKC0L8haIFHOYh0BoARNjjDaSRf/5QRNbq9k845q9HT0FfZKDKsv
         lOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/kcR3l/euGgB9jL2cvADloZPk9MWacjTXWg7QChTydIqS2Yl8NTHL80UyPYQ7JLNdyJ6hf612aOj0lHGV2yEJ9079Fs9vRBhoYc89CydOLw==
X-Gm-Message-State: AOJu0Yxi/Fx1nPo+SeFx/lQNCmnQ3fNWiZkdEFSUzhfq9hQMpU8FZzJ9
	uQPFfB6E16NfTYbifpA8ECFpMPRON4qDQ3UxH1PT2r8y34PEtEvHMHUFVjEnOR2txVTszpq/78V
	L+9TrwQ==
X-Google-Smtp-Source: AGHT+IG0QxtJ2klO/2YXDc0iBujvmja2VH2aEZOp3HvulIB/G5oRb8rNfXRnL0OTcbZ0KYmVBuD4OITIspBw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:6902:1109:b0:df7:9609:4cd8 with SMTP
 id 3f1490d57ef6-dff150d9a54mr275213276.0.1718321506207; Thu, 13 Jun 2024
 16:31:46 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:31:17 -0700
In-Reply-To: <20240613233122.3564730-1-irogers@google.com>
Message-Id: <20240613233122.3564730-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613233122.3564730-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v3 3/8] perf pmu-events: Make pmu-events a library
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
2.45.2.627.g7a2c4fd464-goog

