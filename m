Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21905481A9E
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119224; cv=none; b=ZEHT9r1fgrUB7NpEm5eAq1j3FCphNkGbGrq3+1/1uQLJFkXsj7xavjklXgcKfr+GSlNww50R6HYjZHYbM+bUK18Yt5M16o9n0tIQznxz+GvEL88gY6Wq4CZTTv4grtNuTAb9Wd1pdHpA1knVzhZjhU4r06WKpoAwcAhOER8ttns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119224; c=relaxed/simple;
	bh=xokYndru7r5U27QA5IiJ9grDU4CmNf+aSc8fRA9ncZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QLJexeB1XfsYHNzhGaXXBlTaIoBpVM/8ITZ8PdpwMSOnWu6Tc8om47SIklvlvAI34SzDnPasAwTWU8XaatwZORmMNcc0GvXD2SSjtXEr63xcfwCu5uJRtrzivXDI9qIj0qhPCTMt1JeYpgB8ayB98HCcNWiCI7uPjFMt+IIO9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqa+Xpn+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqa+Xpn+"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f5943ca81aso8294930eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119214; x=1779724014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=nqa+Xpn+WYiNVYiFro/FdEuSqfdz+/Anp4DY6x02BJ7r+d6QiYgljg8qrG4eBVqoC3
         YIk8l2U7vrOxH0W3K9un/C6PcUl6uMXshmVsYRp0nu9TlQB99JQy4xQoQSPKV+2vD7Nf
         thr8/7mHu4kYr7wC2UA13Vni/e8j45B29mb2YKFuTg9OU56wMzy2MNMaqgbaH6doqH80
         VuPrBy95+G4257UW+K1ZDqZRncWJQe+jF978MR+ESgpzjE8EhQNPdg6k8GuQBHUG97Qw
         Gh4RivISJIDnETU2sBYFeF4PZ9SPpVitjQoBzpHM6tSIDoXMXn9SNkb8orZdHHjrIoTC
         8ZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119214; x=1779724014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=gJotFD+jAt2iYl2wjTVIJSdUkSywYu7lCLT0rEbfBgE6Kx39Gpw9Got8v6pURMZaLY
         0ENAJxKHJFpQfwSLIY6s6atJ9uXHtgc2NhgvSr1wXdLMavPkHhWY96KPg5g+Hr1XXI1y
         8KIAPe2KZQ1o4RjKw4vyQlI30iLomGOs2TWVdqhhOrDSAdpraXMN/ZVPGyJrO5DPiGQk
         DcUC6znQbBEQ7M/PVoKPrh2hx2Crv6Y4OF9q1KLWV0n+/HQtVQqOGVF67xsUE9z1mzf6
         lxiCNvePcz8Rg1yanbN72ifUnjid/u7IwmNGyGapOEYJ4fzreGi4HwGE6xtCeUBnldMD
         dR+A==
X-Forwarded-Encrypted: i=1; AFNElJ8f72846T+TALst7CFJf3JR1KlYK3QumznW5uFETXXM12Nn+czST70/cUWASp5o6K9HqpHGCYL5pgjYu6IvSBP4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7U6yVaodGfWyD/SWz1bhQm1ysbi4ZRZpGFG/63u6HxsBv4zEz
	RzYiFHFEAyoRGVL2RMIsOexO9q+MKEewRxmwAq25A8wmg8MopuFBkqCjr9R6dtraShCJ1nxSE16
	zVOAdJSq9ag==
X-Received: from dybme15.prod.google.com ([2002:a05:7301:188f:b0:2e5:fa99:f6e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:400c:b0:302:e560:afb5
 with SMTP id 5a478bee46e88-303986010f3mr7499182eec.18.1779119213238; Mon, 18
 May 2026 08:46:53 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:28 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-5-irogers@google.com>
Subject: [PATCH v7 04/14] perf build: Remove empty archheaders target
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
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

