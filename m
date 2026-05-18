Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E6384CEC
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079684; cv=none; b=mtn7bDDCwlwwjEG9CrCgdH9Iam4pf5sAWDDADv8bIY4WzFpxjLl+A2CC2nHl7Ja8Ttwtt72GxVGeX7Zk0GH2yqEwWL3LIi3vyLhzNXi+wDY92Xx8yxp/YvF8VyRD0rF235g65JGVYqRtWls0z802fBiOtS6OkDZK16X6yPvW4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079684; c=relaxed/simple;
	bh=xokYndru7r5U27QA5IiJ9grDU4CmNf+aSc8fRA9ncZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbwTfaEm3f0rQMD+3LJBeTBo4kDi96EsbtRRa7qRXNvhwfrv7coyff13BBtqRYuZm7ayH8k0rD/KTOYnpfSc31W50X4uTqSmhDWLRdd/QqlJjVg21lH5XINYJsgwzOcTSdkQ6z2BtB8DC4FUKUBIuUUcHN4XJ9dKfg17kGsF15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQEDOkyy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQEDOkyy"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd1dbcccf6so53475ad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079681; x=1779684481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=gQEDOkyyrdEXVUCBhpgHwgZkrpeCSPW+jVSu18SGrXnzi9+ysn4Dz/KMlsD3CELpiF
         TRfvQyLY/6YIuqzEyQ2B1NIuQ9NMiK0cOmvfoVxXd1BNDKrxYJfA0NKwyl2Py1PYqRL4
         6VMTMcRfYxrAjW5joaataRLMlpC36lBb80ED0P5JxRlTm7EyvP2Q7ZnUUQjOIy0A+gP5
         LuB1N46eDiQkcWVvpg2tShrLnu0Fvh5VlV+60h27jydwWKhpkV0jK/IglPxFS13KSXTN
         fmIfnWxguY94CHNU0uA9jVmI8Rc4gjKly5X54R56dmniIPd5I8YQnGRDI54MjU72gVJf
         f1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079681; x=1779684481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=hgRn2EjLJxZoDSm40wKgwtjSHDuH+yuQn0P4ENwCjaGah7e+oHsDgsFmozkI02wXhV
         36a+UGJkPAZakj1qpDi0lerEYNArXyVm1pe2ZiqhpZggvpK4nGNKTLKRKPe+Eoz7+y03
         Q8Labs0PpCDXlNMMr38tU1AYtu/DCcNPghViwezWLOMoHaNh+XM4lrBOZTvQ/ZeiQ/Tp
         nSWZGNBzYt27aUzw0wN3kiZ2aQJjlYeRtAsgJBhUPK/DBGO9vz5sLHb+r8RBgB3slJiD
         D5Gmcuon/9Y84Bbyi5WzEnsZbV4xSGFgrIiF15ZwLayfWHDFwK3zgK5DVy1mqPnLyFw5
         5wxA==
X-Forwarded-Encrypted: i=1; AFNElJ9P+WbYL3ac79HfG5s8ZgXxpENgqn5vLTwMmbPbhFFp7r9oB3Klhab46F01Y1TCZl7URFepjFCCsXvegxv4X99N@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkxp/uOy2hqloyMcC/pFwg7VeR66PBFOdYyqy5qhB3gipcK6c
	zL1lKzWxtHY5FEo4zE/mg2K4fR1JL+unN5UftiT+YsYSShGuuDiXW3CVrUaSKpBkdK4Gaq6MS0F
	igYmgZlccYw==
X-Received: from plsq22.prod.google.com ([2002:a17:902:bd96:b0:2bc:ae06:63be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e746:b0:2bd:c925:3a16
 with SMTP id d9443c01a7336-2bdc9253b48mr56262905ad.2.1779079680419; Sun, 17
 May 2026 21:48:00 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:30 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-5-irogers@google.com>
Subject: [PATCH v6 04/14] perf build: Remove empty archheaders target
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Remove empty target that doesn't do anything.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c66af4c825fd..24581941e912 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -627,7 +627,7 @@ endif
 __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(or $(__build-dir),.)
 
-prepare: $(OUTPUT)PERF-VERSION-FILE archheaders \
+prepare: $(OUTPUT)PERF-VERSION-FILE \
 	arm64-sysreg-defs \
 	$(LIBAPI) \
 	$(LIBPERF) \
@@ -1070,7 +1070,7 @@ FORCE:
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
-.PHONY: archheaders python_perf_target
+.PHONY: python_perf_target
 
 endif # force_fixdep
 
-- 
2.54.0.563.g4f69b47b94-goog

