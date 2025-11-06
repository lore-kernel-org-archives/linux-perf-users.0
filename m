Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA234F49E
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470946; cv=none; b=LdJIFGqMr/KU5a8nH2UNHTYOCoTIDbG8iu7wgxqcKzVuGXwwLyoCHbtEw2v8Jk8Q5K7/i/KqERgOgnRQY4j88DHHiUGr9gMnHlaWGhO8hu9U+Lp0E58jbSxxZmqmRa4ms9XLYF/8Y4ttLYss5spcSp/qep2ocd9zHqBz5YfgvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470946; c=relaxed/simple;
	bh=goAJRIvcXmArqjtsnCnAKiuCo6RWRhzBbuO89gkopnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UW8iD2CnA+6EIDdsr7L3bjSK/N9h9D15UgakWf/jB7BH+jtOCHCQXH8QHhnacUL0iYD0Vx8fwpVI8PcKZlRKsmij4W6roW6Rk4bzeg9ooJogo2AdDAEG/CqyAPnZJZPCHHE5aUDpFW91ilAYSZRwQp/x6rvD5zdau3vzLiQnVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BekpuqQn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BekpuqQn"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29598910dd2so3250645ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470943; x=1763075743; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kfrvj9SxzyHWG3QRMI04WWVn93aXW9NO85HAoMrUfM=;
        b=BekpuqQnqK4aaGV7k0MAlGonnpLEFf4PJzyV8opYVhRoVbT0A0UG8vmQf/c66j1uSc
         fGLo1Kcf5SlFIsk99qNidk60eLdmXQHmxMx9C3d+HkSR961rxCXTxrX/EQSp8z0OzlJN
         z7iXe/dGJy7Nsch5WNPNI5xSGGuxujaUEr7ONtr5bZB2PsZFhR3UzPV6MNLs7sXxfxUk
         b7LVeAJ15azM1G/PI8tgxS+RO2B/WulGQdvE0+2R52aYS3U2N3Ed83Mas9p26iykfeZK
         SuJo1cyYW7DkWGzKG0xqHgW19TNPP8OLp7WWpfdMN2I9nJ8VUrHgmtFj9KrSvmFRNHM+
         PpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470943; x=1763075743;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kfrvj9SxzyHWG3QRMI04WWVn93aXW9NO85HAoMrUfM=;
        b=Htmyd5rr46osSSecodKemosbChbwcVyZW0/ktPKjMC4WUy0hlmAFah88DlHvnatOYn
         1V/EO0GekAtWEToWYKaS89Gg0hj58ThSyHi955Sqqt0Gxt6X1ZWUOjbqiCHcZH6vQLp8
         jNRUVO+rvSIU5vST85uq2+DJe9vHrqueWynxsPW2zTiKaN6a3S46+M+F0Lxx4tiaLphr
         9L9ogulAU1yrO0S5pXTPkmNTdOvQGk7Vwm9MJg7yuVUbkgc3Oa7oddcqEAdAWn8h6Ug9
         FR5KLVs4W/lt6Q2bTarwYrrBYbI+oNBbb7eGo2y9CfgMP83BdiK+rMNAerX3OlhGag59
         jVPA==
X-Forwarded-Encrypted: i=1; AJvYcCUxzDUDjxKJo50VPL3/4qDM1wuMxJ5q8DeipRaoLijYOs6YJ32+YdqWFH7PpGvXB3EBcr7fye7wJqZSikg1AHNl@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCCOyLpr8s1WzGp2LzOOTqwGIEj2FuBcZkFNDi3s28AzrUa3v
	gZI4fl3/PEQJSn7fD3PmcCB7YvDodrV65AZkZQWbkp6mXTEA2THj7iJ7X1L5NBadKrmUQo97hdT
	Aypg8kQi1eQ==
X-Google-Smtp-Source: AGHT+IFma2NJzvhRXHMld0BT31zupRS7KxCsW4oTcuOFZWocvzaqYwh5cLgtfxBZt5czA5+dCdaoj9K7WdG3
X-Received: from dlf6.prod.google.com ([2002:a05:7022:406:b0:119:b185:ea6d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f791:b0:295:571b:64cd
 with SMTP id d9443c01a7336-297c047bd71mr15118375ad.52.1762470943106; Thu, 06
 Nov 2025 15:15:43 -0800 (PST)
Date: Thu,  6 Nov 2025 15:14:52 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-3-irogers@google.com>
Subject: [PATCH v2 02/18] perf expr: Add #target_cpu literal
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

