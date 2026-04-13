Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2549337F8C6
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053587; cv=none; b=cnRzERSehDASZ095swUehRER5vxp+6DnRYAyRlhYvPpydimbQELB5xM5rloJcH4KNY8Gg71KOFu0+VxY35n30qfYSkxtf2+IcY1WthuAy6ly6KjmCUHex7vqWa7ufD4zZKoRG1DfxNIKkPO8DiSw1SBMXfXrBjwEEm8aH84tDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053587; c=relaxed/simple;
	bh=TORHr2hwj56t1K+9uUsjLQo6KHkuVY+QoSlV3b0luUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HPfO1IC+ULs3D4Yg5CvxA4yC7UmNDBaL8hEex0vaKETSrWGjNaioJKf6vfwbgkX4/HpqHvmau6uXeHbwJO7320dhK1+hNSXK1Sw+gkXuw3EXz0agC+pnC1np8AjmcQsq9dVhDilBzot5aQBp8m6/fRUumsTucltRYB9Gh48aw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2EsuqHi; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2EsuqHi"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0ba59a830so5234418eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053581; x=1776658381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQS4P5hyltqhKwRzLCXyq1MWFkkdWjplTUZAMK0ialE=;
        b=V2EsuqHiZtAPSgAnc/RVlR5TN16VCtgoEP1M5eRpnrJos5DVQTS/3GJA11Y5/W5gsz
         eCKIASLlbUb6SccXOoJ6uiELlX39tzUOI3GDHsVvXl6ddPRB8zAHUYtpPMawMm5w1UPI
         g/E8jVtyJe3GFlkRPWOHwoz6K46T38ZkKHXYe7Gc2uXqQIog/Ee2+2BXDrdQbMSQhv62
         qPVoFbKiKyRv5uT6OrVZRHoTqpQJ+A3s+OvWVs+VzhnbExGp0FBeNPScs+eLgPVvmzdO
         26Mwc75HIarqoPGsNJumJkJh4WSeCXzj+a4CstjTFPygSNPLe22dzrNCzdJ6adlFhUrC
         fq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053581; x=1776658381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQS4P5hyltqhKwRzLCXyq1MWFkkdWjplTUZAMK0ialE=;
        b=W2nKo0c02zWRurNkpgm18U9Y/wQ8gq9AfVOnlSzKfWxommEgLlmAedfodbPQ0pjWR4
         HhQvXCzl037n9utRjUEv48q5MkRGQd3mvMF/a4+BY47z8DT3ZUZHFuvTgYgpPnMOPvIj
         GflnefpATNooTzCPeb5zVD78JuOmq7+1L48tjF9qVS7OjITcpDTugXU/FZma+noKA/Cu
         uTpyqX4Gc8axa4G6UP6AcSDg8FEpNExLishfu+y2jqwx6UAHgNPF/KYi0OavDEeYOF1N
         QoEn68PfqaJllFSpkAxgS0v8gp7D7r345XTjjSWO0hyVJ586zmyME6C9k0Gv9ZJeA5Fa
         Nh8A==
X-Forwarded-Encrypted: i=1; AFNElJ/GyCYJGOMNJ9v63WcWIbS1smra9HDxCFT3EUt4TLqdRMCq6NtvzPLKFEEuaSBg2k9GLM1VCwx1a4wgB7PdRWDV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0SE6EQgG20ZQLWAAh6yWZx00Y54b3g+3C1pTgDaOtJkiRzDf0
	CwyGjOHo7zUJyb1bOAjjMRfH57Jbox2UPOs776+oMcyCOb8uJv3qt1+yxju/AiSJq/28WvUo+Kn
	7B3WBtcQKMA==
X-Received: from dyon31.prod.google.com ([2002:a05:7300:6d1f:b0:2d4:49c9:3b10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a54b:b0:2da:1874:f3bb
 with SMTP id 5a478bee46e88-2da1874f8ccmr135985eec.23.1776053580832; Sun, 12
 Apr 2026 21:13:00 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:38 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-29-irogers@google.com>
Subject: [PATCH v12 28/33] perf kmem: Add bounds checks to tracepoint read values
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Avoid out-of-bound memory accesses by bound checking order and
migrate_type when coming from page_alloc_event and page_free_event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index daf2272c7337..33585e353efe 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -826,6 +826,16 @@ static int evsel__process_page_alloc_event(struct perf_sample *sample)
 		.migrate_type = migrate_type,
 	};
 
+	if (order >= MAX_PAGE_ORDER) {
+		pr_debug("Out-of-bounds order %u\n", order);
+		return -1;
+	}
+
+	if (migrate_type >= MAX_MIGRATE_TYPES) {
+		pr_debug("Out-of-bounds migratetype %u\n", migrate_type);
+		return -1;
+	}
+
 	if (use_pfn)
 		page = perf_sample__intval(sample, "pfn");
 	else
@@ -892,6 +902,11 @@ static int evsel__process_page_free_event(struct perf_sample *sample)
 		.order = order,
 	};
 
+	if (order >= MAX_PAGE_ORDER) {
+		pr_debug("Out-of-bounds order %u\n", order);
+		return -1;
+	}
+
 	if (use_pfn)
 		page = perf_sample__intval(sample, "pfn");
 	else
-- 
2.53.0.1213.gd9a14994de-goog

