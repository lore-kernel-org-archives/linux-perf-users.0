Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A11730BF67
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833871; cv=none; b=ma4hClrvEsfii/KrTN9dzxxY5LhXtmlafrue7ZBYjvl3Ic0keLM530UIA4RmTmfKbsbSdREe0Qd7HKjTHLvx5Nju+YsNJG1f5yEB6ZUNLoq9KiEQlVNbwHP50yNoOTg1QBhqEipQ00SclmII3RfPDlgCoiejlCem/5n2qDxHEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833871; c=relaxed/simple;
	bh=goAJRIvcXmArqjtsnCnAKiuCo6RWRhzBbuO89gkopnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=r9Jtewfm9cW8zGqeE0Bb7A3QQbRaDvhQKwK6NUglU8skjsdL1e9HCy/4WC1DENv53fDxd3T281leDHJAGmO+ktm2wEtTglLEbAy2t9ho29bLs4PisBqQ7LUpMEFlqhTcUAgaOFd4Wy1CfatIThye4xbR85KXgWhkTSGlZObZRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VkVXFu3i; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VkVXFu3i"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295b713530cso44556815ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833870; x=1763438670; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kfrvj9SxzyHWG3QRMI04WWVn93aXW9NO85HAoMrUfM=;
        b=VkVXFu3iRg2gCoSRFVtVNXc4AeJgSFyFn956Xf/JnNjr7DimIJZ4eSnI4IQ0VKc+6i
         PubU818PmAfPg/N15Q3lodrL+qis3NTncI2ymZqhRJxNAs/zM5Et6kn5Trhe8vtQ0zJp
         11mmJ/q/qcdQHaGfggMZ6YHgborEEpp+EGEWKPsQ86iKcICiDY5OtFt8yKMxGp0GCjA8
         OpJa7aND9DowDSE35ssBuUnr0i9kivdlMSofoHewPXFbpIv3M5Bp416y+2As7wl3KdH8
         bT8Xu+BaIYkPYTyBF+FFbPN0RRSd/eFUiLDFuAvPDjyEOsHqthgCeCH6yY90K7ujzcYk
         eWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833870; x=1763438670;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kfrvj9SxzyHWG3QRMI04WWVn93aXW9NO85HAoMrUfM=;
        b=WyYjmMnLcnFajfs8kzvnPRqZ1t1ucIct2KIa2u0DmYvesjtDZi8qdcyK/skSsitWX4
         +BUnwW3xhOYvL3mPVBTfnrf33UMXO80BsqTvGl42k+tnM/6kx4lq6enVF6k98q9W7UlI
         lvzfaex4AlPmuXbqYtuQAufeG5UV81mEo+JIAjfDNg5zJe7CettTj7Ciye5UmTppNYe4
         c0vt7G9um6/IIhYDnBZ/VXjEZaQ63ThfCRJBWmJahMkE0btfSCAMjd9ahG6HN3pRM4TX
         3KVwSNhM/upEnQPZwFV2IG+1q34dEOXn8PswJwjYiIpP9iZCMFI9z4bzGck25EOfNvUb
         eJEw==
X-Forwarded-Encrypted: i=1; AJvYcCXUMLLQZ2O4VjU9O5uB/ETZdVwruN10yolJfEvbVXtXimFiq2D8PD7j3xZc3fCQNIC4ohZNQoReyPXiMaDFuBbl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9x4XFtwlWN6RQlptg7mvE5srayBFQlgzQU79nckpUYhVdagN
	pianbAYJZBmAgtgBCFOntUTySr8IMvrOlXU9uA568A81JqeYM0s3kw4VwBBp97iUktFr3Rcx0ul
	o2vz3nrMK9A==
X-Google-Smtp-Source: AGHT+IHVZJ6rPHs+aut4IPB35AikU94fQpOnKja6gvJpXpnu3R3IcAWz1crnWG63f/Ij/vPLbwFlVJFsfgfA
X-Received: from dlnn4.prod.google.com ([2002:a05:7022:6184:b0:119:b185:ea76])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da4b:b0:295:512f:5060
 with SMTP id d9443c01a7336-297e540dc24mr140450485ad.7.1762833869681; Mon, 10
 Nov 2025 20:04:29 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:01 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-3-irogers@google.com>
Subject: [PATCH v3 02/18] perf expr: Add #target_cpu literal
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

For CPU nanoseconds a lot of the stat-shadow metrics use either
task-clock or cpu-clock, the latter being used when
target__has_cpu. Add a #target_cpu literal so that json metrics can
perform the same test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7fda0ff89c16..4df56f2b283d 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -409,6 +409,9 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 	} else if (!strcmp("#core_wide", literal)) {
 		result = core_wide(ctx->system_wide, ctx->user_requested_cpu_list)
 			? 1.0 : 0.0;
+	} else if (!strcmp("#target_cpu", literal)) {
+		result = (ctx->system_wide || ctx->user_requested_cpu_list)
+			? 1.0 : 0.0;
 	} else {
 		pr_err("Unrecognized literal '%s'", literal);
 	}
-- 
2.51.2.1041.gc1ab5b90ca-goog

