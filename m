Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCA2036F4
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399519; cv=none; b=iyEUCcdmVDGvWXRedk107cVGFKDdc/4ivD0BIdocggXFf+ajs0Py9XS65SEr45LMV2rzdvU8LlCffG8KTNkXar2SVgrlFz4oxcigfrSbrnj0tmzix39POHA7rQN6/JUCAzprn4CtprfdP4zw+r/R9Sdq/hZEgh73H4DuXdllmz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399519; c=relaxed/simple;
	bh=9xYAmC7Odj+wcG5scUKb2hxhqBVZwbTv98XQABN1UOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R0kKYUTFRxDRVPTc1fg45De+le21jetSioxixxqEEnvjQDq46AHCXW7sgPaXWzyhflB6K3/0cm6IJTN2bhK7e+nvRo6djbZyRW8pNxnC3SiXBvBucP+o0apTzQomM5ssJrrvpC4US1hjnQl+Sr7gO4UsSnjgnqYMeS5gV9p0T3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLT1C2rD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLT1C2rD"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so522742a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 14:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399517; x=1740004317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4u0lqhDVCs3kWFzXSRSy88eSlq3hW173Ud7Yk2USkk=;
        b=sLT1C2rDOEyzzLjEjuaRckKwaQ00FSPM7NcwXHLowCOWOBl7jqp258G7LJ6nhbMS3N
         3KCYLouS3RjIFHy+L6x32LYG/wvm4gdvQ92X3Lmf7eeRZvMcIMZUiPFq1iHrpdJM7sj+
         /1Vq/Ul3gknf1Q9T1DviNgGoT67r/Dxz8Ce4oOBWyvjPqeLT2+ihOMXr6AXpngEJjxPL
         om5whT5SD6ile3O21yTz2NxFZLQTTgjVruCtLeSUCT7bXdF2X9OD+6lf8AEH+0pi6oo0
         n7IvgLC7MsPON58ug2Ah5HAjyUAdwUGb0kwtbZGAo2PibTzeWSmYid8jA/Yqd8zmavmg
         2hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399517; x=1740004317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4u0lqhDVCs3kWFzXSRSy88eSlq3hW173Ud7Yk2USkk=;
        b=UEfUabpFrZ9tli0g6/xsTknQBq6ScYpTIn2X/7Nku/OcKjBORNEQBmYBbGe4CWhmeG
         Cq94fHaNgm45r2wEQHC1i1ygJo6tVH64pxTcuNSZ6Z1TdAFWqxd2Hn7+bpTEXBNTRCJl
         1+LPI5NYJFDfeXO+CivryuFCOciPswn1KEM7yZ6IfkK+Ghr8YTCBL3rjG+pti3elt0y2
         bDAKB0Om44Rg1/6iBei1KqcQNnadyTFDmFBK3k6wpBdeoPAvhPmZVMrup2rJH31ZSq78
         OY/2M2144mN2HyJljbJxcfMimKlb1PVnexo7pZMhuoPe+un51zo/ozNPgiIT7eUvAhDn
         Vdcg==
X-Forwarded-Encrypted: i=1; AJvYcCUuDCfmbHcP7mbdam7nZEHjORnIWgOHrvY8MF3L+2qapo6me/HG/ucdjlQvhX47N6zx9Tkutc2ONoWZ04BDYDC4@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYLQcrGumxK0ZyEXNaGpJNJDNPmTTySTUvGGbginKLz7WpJL2
	KpK6pElRw3Z+2JfQguNDLWocmtBmyivp2mPe8Hb0PBpMCUPQTbpqOLZN7jwi/qv7k8bBv0uCUif
	URw==
X-Google-Smtp-Source: AGHT+IHCkcBnyBvA5rBqb0nlmu6y/i7b8JGoyzx+WFgpOL9irq8xmcP/AfVCc/JAi46e7AZbhgN0hE+xX1s=
X-Received: from pjbpt6.prod.google.com ([2002:a17:90b:3d06:b0:2ef:7af4:5e8e])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c04:b0:2fa:f8d:65e7
 with SMTP id 98e67ed59e1d1-2fbf5bb574fmr8098207a91.2.1739399516973; Wed, 12
 Feb 2025 14:31:56 -0800 (PST)
Date: Wed, 12 Feb 2025 14:24:56 -0800
In-Reply-To: <20250212222859.2086080-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212222859.2086080-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212222859.2086080-6-ctshao@google.com>
Subject: [PATCH v5 5/5] perf lock: Update documentation for -o option in
 contention mode
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch also decouple -o with -t, and shows warning to notify the new
behavior for -ov.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 3dc100cf30ef..e16bda6ce525 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1817,7 +1817,7 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 	}
 
-	if (con->owner && con->save_callstack) {
+	if (con->owner && con->save_callstack && verbose > 0) {
 		struct rb_root root = RB_ROOT;
 
 		if (symbol_conf.field_sep)
@@ -1978,6 +1978,11 @@ static int check_lock_contention_options(const struct option *options,
 		}
 	}
 
+	if (show_lock_owner && !show_thread_stats) {
+		pr_warning("Now -o try to show owner's callstack instead of pid and comm.\n");
+		pr_warning("Please use -t option too to keep the old behavior.\n");
+	}
+
 	return 0;
 }
 
@@ -2569,7 +2574,8 @@ int cmd_lock(int argc, const char **argv)
 		     "Filter specific address/symbol of locks", parse_lock_addr),
 	OPT_CALLBACK('S', "callstack-filter", NULL, "NAMES",
 		     "Filter specific function in the callstack", parse_call_stack),
-	OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owners instead of waiters"),
+	OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owners instead of waiters.\n"
+		"\t\t\tThis option can be combined with -t, which shows owner's per thread lock stats, or -v, which shows owner's stacktrace"),
 	OPT_STRING_NOEMPTY('x', "field-separator", &symbol_conf.field_sep, "separator",
 		   "print result in CSV format with custom separator"),
 	OPT_BOOLEAN(0, "lock-cgroup", &show_lock_cgroups, "show lock stats by cgroup"),
-- 
2.48.1.502.g6dc24dfdaf-goog

