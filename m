Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBE3BB114
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608027; cv=none; b=bbmmUr2Rfk1eYPatLewUpzumLynEYtzk6EoXGlweoHeVaWA4+F02Lh5OnlMSaVG8+/Xf/xfT/uryeCvurppMuFuh0a2IO1cY042uIsg/MduCyG3pYyt1cFkuLfb94z4fOTrxyFju4dea8TvueLklKeDJTN0eac4wru/JS24prcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608027; c=relaxed/simple;
	bh=xokYndru7r5U27QA5IiJ9grDU4CmNf+aSc8fRA9ncZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b6+NQuEPjeVAIMvtByIL9EMvRVA7drFg/TNUtYzXyM8oPpoB+aKV0ZMi9OXgQaMKc+fGzowy5nRXMUjYzUHUPGMVn+/FOu+gVdbrNLLynPmu0bz5BMtzW+R4GKYY5/Y1d6RWjxLcr+hoyRYyLCWQJNYpfGPq1+fU0GJdoAoKmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRF3nmce; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRF3nmce"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so4220092eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608026; x=1779212826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=hRF3nmcewigmpn3jnvgSvrxBmrtx7Wsd3s/8ydmbJe1PrQzx9hWoB4z0N2+BH/pudj
         xTpwuz+qzaT1b97qyWB6q6dYe0+D96SDhL5gTrhrVAwmxmxrWM1T352eQq/bhJBGAYN5
         lbYmaX1QIrt3UhVchd9BmN5jCHU+G91oNrytJRVxa8aAvqbkz+JugExBLTpVjH/z+Nyn
         fxP0r0muONrVaFM3WEdFd9DZeLWW1vhFvWAxsh8cEhgHt+HBMENN4PG22mrkC4fRpICR
         OsGjRgzvxHGI3P+x8NEtxVtHflGQ7OMruLI03/APe8BgW9Pefp5+iK6e5vVzfprF2URw
         ajpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608026; x=1779212826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=rr8LS5PLiJfeeJjWe7PUIYEH6jXk6H1BSYmMjSg9UHirTXm8wr4O6Z9bxgHwZqEOkL
         6oLASpTieaQW98QXGWdl2VwfOQOnCB2RZytGCF8/gXPvfBXT3YRYbhKHmgUznA44ySGY
         Zm4TR+lHwQA7TWeF1szFCE5OOZmfqrFebS//Zp9KYooT9nub9SzxHfC20M9GccYjQF9e
         5MuhfNF+2qjwPef/TPUYwUj3Apnmva2lYFEMQimqXIj4eSsAzu4pqDDtGpmqhp3mo0i7
         woL5/szWzFX7mRQ7n/JXGpJohCGkW1VaTNquJLndCo0ASgcKnqOthVaw+D/hDDF0TE8s
         XHtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9g4Lq1gtARi9AB66sxl94CkMuDHnDk3qJ0FzrUJ4ALVAYhC7zFl0TKe8+8hwmWPTMusd4jgmlHymRH21t6ljfL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xBNwCCpEosG7ostPMKSVH7Wo74YDRCRv99zuwe8GvKVAp/lV
	3QAmnyA7DtRgwW+or5Db6TS8gKU73G7bSvlAf1Kje9iqJr4jq5K2vpKF1QYM8hdz5W8BZVtJiqU
	OLXXWF21YOA==
X-Received: from dlbbo27.prod.google.com ([2002:a05:7022:439b:b0:12d:e33d:70da])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60a3:b0:128:d23d:81aa
 with SMTP id a92af1059eb24-133450a1de4mr2504765c88.27.1778608025074; Tue, 12
 May 2026 10:47:05 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:27 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-8-irogers@google.com>
Subject: [PATCH v2 07/18] perf build: Remove empty archheaders target
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

