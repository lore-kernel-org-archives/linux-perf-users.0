Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E538C401
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873619; cv=none; b=biN/7iL5A5iUfkc/pbRzVFUH7HCo70HjpH02wuUQGQ54sb7/n12v+++mjkcx4k4aiaODu6KRHal0XbgQ7SMNPOkLE2czSEhRae25ItAJKhSAH5MVUnUGAGyaQygS3HzzqtUbQAlCM9piYBIXvQ6/XJqEnmwS0dSleznOBBkMeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873619; c=relaxed/simple;
	bh=xokYndru7r5U27QA5IiJ9grDU4CmNf+aSc8fRA9ncZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LCYHRTn6UYUIFOeCAwerjITAEra5+b0H6f/J+bN9KaAROBTC/Ql9QboMMDdrwjAGasi9/oQq/qncOjxjKH7y8nFjfzvPSrvUjxHRe0YJKfA9RqJc9gNcwt/hQ+/G/U1CMeR7Q309urrcDjECpyb6OWU8OkVcB1MP52L3nsHyNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjqg1xml; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjqg1xml"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so485881eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873616; x=1779478416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=qjqg1xml2X8/4hrUegqsskUBzy2wCyvgTVzbq6RLye/O669e6I0iuc5i8Il2+j6LoP
         Md5uqnfLBQqdstx5wiVWT7zcpVIOwMeppqXuMKKRw56n0sKJeYqyiYc08BtC5aahKUWf
         MaPpwRcQiGZe1WlfZLqOwiuFoTdwiyzFOh4zqajX9/LLa9huVGQR0Ivp8aXmQcSkxmvA
         +G9mySTkKcemgOioRtwbBoz4jDVdkaoAh+F7KWkvK6ILpJIfhZAzBalbbITFgS2mzUBh
         e55iABYkK1oQS8G91aIvryoH3ruGBNGQ3XXPH+5WM5KwuDZtGRRus5MJ+hYem9T0vEBH
         O1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873616; x=1779478416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=Lrsycxv5Fut0EUooMSwBQtHLgZCyjQFsJryaHBeoVtodMXk+M7Ym015Ho5Q0ckcJvo
         hCt874ZR52CgJsyUxgH7n0Nt8WuoHY1qobkIfPeCF/wjzO4gELaexNO+NExEf/mIdgpM
         FrmqjN/w8bX3sYGW962rn2a/FSg0ehZ5iVqdep4HsWYPic1ckY2pZKMdLIOZhckDt2bA
         BIK/X+8tX0iBpCy72QpK+xlzlU0GIvpBGZkntH+miMPt2xMM7b9q3AWLeg/eu9LcQV9T
         tqfg4rpfiYxHOeuKZFM54DPycSF9hFOBceDr5HnlqfvV2+wx76iYb9azCodYhxrNU/nU
         TwNA==
X-Forwarded-Encrypted: i=1; AFNElJ+tx3fO/ZCedJno3AA+4yRJh8cf92QnnBAJs0E/hsDOUlOOi8N3udDU6gNHWmXh2031g80kJ+7FAcJum6+guS/h@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrVExqEesRgkT5TXD4JVKqfgU13J8ci8LtBnsX3B7B3N3jtOj
	cboZOGPverVaDiaDbV6kr9x5S0r/tFlipqmvOum/YQX3SD7VrkQeMDjNZkLhcsaqGKZ+TBXiV+p
	/wywGMDfJdg==
X-Received: from dlbur8-n1.prod.google.com ([2002:a05:7022:ea48:10b0:12d:bef6:56f4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a509:b0:2f6:811e:c840
 with SMTP id 5a478bee46e88-30398681505mr2920420eec.18.1778873616179; Fri, 15
 May 2026 12:33:36 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:04 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-5-irogers@google.com>
Subject: [PATCH v5 04/14] perf build: Remove empty archheaders target
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

