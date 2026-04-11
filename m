Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C73CCA16
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935094; cv=none; b=EeuWjaWURdRpPwwOTioSdQxJfLHNrtG3iiwvCE0RU7UqRQ5Um4pjmRCG7ECFGAJFjVzbCAFwUy8Y1Qulbl0M4XoZ3+uzQgsSjh+rQPGZuqKGMWS9a4QSmwXuQFXdAjsJDwzUFI0Aen3j+a0EUlgIWYuVPpBibHOSb+pVguXsvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935094; c=relaxed/simple;
	bh=zSR89FimOo+a1ho86PLlAmAIRUBEG6ciri5qyIpa6GQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DUkCoThYGvuDjfzfgIOhZObPa/h8rF/NoKIXq0Gck+ejRNNiGgWcMRzvu6C8ld3QD6PhI2fhTCMOlFkBMiebJOQ7xIXr4LQ9lmD0xgXHjvO2mUNBcgJIH9t2pZQo6QfPn7qxygdG5DgxcZhwkDThL/2mI+oT2tFymZLH0gp8ITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ary3dn+b; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ary3dn+b"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12711ec96fbso8572426c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935093; x=1776539893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhB4ugJgO/oaf/OiGetNZif1o7sER/QECqKsaPKgFw8=;
        b=ary3dn+biRDv3sbj+3GUTzrPjrLAzsXBMB5ZSijw14PE780u38PZqo0xvgOXNE/hcW
         xKfyvggOv+Ea9krV/TC2wGsKl6r5Y3bA4MI65D4lO2oE8wboxVONGD/ZTuKE9mAfvaSU
         WpTSPhBJg5FfCx78aH3Z+05dmvMl2pa9ftloBs+yivoOnS+AKDCp8lT4Dg2xxyGNMrzX
         ab7tGp1En+M7ccKk0h7hcjsNhOgqibCEdPFT3W14tWxO2AhvOlAtnYegOLzFk39sDlK0
         MHxwmzrvUW62S41TQiwoEe0xn5t6lPQJfKlOVRXaBhvWeBodz1PqR4Bl5hJWX0nDCSp1
         xvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935093; x=1776539893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhB4ugJgO/oaf/OiGetNZif1o7sER/QECqKsaPKgFw8=;
        b=aSaYPy4Sq/69z0hNNsXwtOirQltqGU7GUxxhM+woM5lLe3R78M/5vIiRxQCrXJC2W9
         GleW73ZtYlTBTVYfF2lEnofpJB1acrKcoqm6yV4lBrTtEer2GAMJEmdl1rf8WQ8qaMQ+
         rQ941MHjoxdJyDZ3FHo+/g5Y1YkmefV6IQ/9DpEYRruNErU+l28jKOjNb8MxHEa/S1ai
         FnAS+fOrinf9BDjakPTymGPgt5xIA26z0n+igMLbVXjk+Vec7UBNOjZ+el7jmSnqckwS
         +T42KktZcSP3RwHDXdBJFRbFSwJggjC2LeuVsc8+AcHXWDw1vZ0n3QXtlAni7xj5/UqF
         FjHw==
X-Forwarded-Encrypted: i=1; AJvYcCUjBlWOC0eCbCPX1CUnf35l/BsXAZXbs/iYtHDxAx8xI/FiosZyXIPbAj9AJFLkJVvP5Z32UOmF6rfNbSf81Nyf@vger.kernel.org
X-Gm-Message-State: AOJu0YwAu6hF9AoFgPT52JvP2SPcE3AHfM957fTGQbP1M48egOstrMUb
	c6E4HMgb8dpdZDiZPNj+xSfaVKn6lFOLh9kdYinP3EN9NQ9jyisUKk2GcVfG2qwQl8PJ4QTpZoZ
	PT2icoyp/aw==
X-Received: from dlad11.prod.google.com ([2002:a05:701b:220b:b0:12a:8256:66b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6891:b0:11a:e426:911a
 with SMTP id a92af1059eb24-12c34eb9b40mr5007446c88.15.1775935092641; Sat, 11
 Apr 2026 12:18:12 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:17:06 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-26-irogers@google.com>
Subject: [PATCH v9 25/29] perf sched: Bounds check CPU in sched switch events
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

Ensure the CPU is within expected bounds to avoid out of bound memory
accesses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 45439e2af8ff..6d0655d56e26 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1791,6 +1791,11 @@ static int process_sched_switch_event(const struct perf_tool *tool,
 	u32 prev_pid = perf_sample__intval(sample, "prev_pid"),
 	    next_pid = perf_sample__intval(sample, "next_pid");
 
+	if (this_cpu < 0 || this_cpu >= MAX_CPUS) {
+		pr_debug("Out-of-bound sample CPU %d\n", this_cpu);
+		return -1;
+	}
+
 	if (sched->curr_pid[this_cpu] != (u32)-1) {
 		/*
 		 * Are we trying to switch away a PID that is
-- 
2.53.0.1213.gd9a14994de-goog

