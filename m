Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5933F38E
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890703; cv=none; b=MBZhRUgOgK3QhqWJdrDo9/P1DzbTdiztTCiOKmx0svmm+h93mTlrcXIL/EzqkP1QkTqkttOTME3Q+xNQHFyfqtU2gHpaaQml/fnmHzxxMoYJ6AKMaKdQ5+F7y4+XIcr5LP8c0jam3KXTA5W21i1rozADnHEJmcLAlpfji2qNvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890703; c=relaxed/simple;
	bh=zSR89FimOo+a1ho86PLlAmAIRUBEG6ciri5qyIpa6GQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pjRaTe/gaZzN3GMwUdZZm31bhtoXO/wNqZWznuK6FoAuzUzEsMg+cM7+ZjXgnlSW09mEHLC1I4XAx19m6QQsyHZ7gfonTborx9YandZzaEuW/fZi9+Dam/0tDFZtQquJSVMR+UY86lcJXlG0N3V1dAv0Hl3z3SiUbD5VDLHnpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRt5utl/; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRt5utl/"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0ba59a830so3827296eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890702; x=1776495502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhB4ugJgO/oaf/OiGetNZif1o7sER/QECqKsaPKgFw8=;
        b=kRt5utl/Ixj74mmtRNrhUcHBzN44QLlB1VaqqlF7gNoXJDapm4mOCXRdYKnWLaCb7m
         40JjNjoHxx135IJ7CLU8OU/g83oimbIsGyCZxIin7cd3YWEMOgmGa0UMKqWgDbvLIFad
         BsJashMaBvd8EM8FACtFrBM/aa9IVuuMcny0D90eHSSwtiN4abya3ETbyAv7SYwSZkqs
         Dj84CKxIRBmbjTmiLcuvRbXYQaUKQstxE/Vzlj4Jx66w4WXxmu8AE4t67A62+HTUmWl4
         vBwT8VmVfqo29xXLNsUXIBD+fAo0SyLP/6fd4BP02KWUqxNWbBOAseKT0u24/smUCFJP
         48tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890702; x=1776495502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhB4ugJgO/oaf/OiGetNZif1o7sER/QECqKsaPKgFw8=;
        b=bG5pXZd65VWlntxtPUd2TrpR9Sylx1PcTRzvx8Kc7mpELzJS+CYkj4Xc3HBKev6FUW
         o3kcf3/dH6zqTrmiGKvsJOJ0ajUkR2ainzdlYRfck39q7WN0o+wjpt/eD1ERy2z2kXji
         0P7m56vUXEQ7uTg54qq2JSORjNdQyJbWXCltTBWa09l/JjLy6kHt9kuc7fc1wYJmUqeN
         yf0XkFcZqxwR80lDrHmrFje2yDSrcU5ZR7ikq9kx5+eXHw/9DYziGmEayMv4MQO9Z2DH
         1Ky6rSxlcB7IzLBUoJgPWsUdKY/uuy0fDMhBKf6Fg8/czt5Q46SFufCoV+L/UXFUGeOm
         640g==
X-Forwarded-Encrypted: i=1; AJvYcCVXk2bYb4iNxUmB2z+VU3XzKzcu6O45EVM/UvdbebmzxOEljB887/pr3dtXHcEPLPnZXMTqGoLwLzwb2+rQdvxw@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvStcoYhh815or/dBZWFNJE8s0MOqlf8jibPrO89p09LsBfIG
	TXMgHSxScZ1b59TdhhAAT4StsanMhP9eSJ34Jmt1+Q56AvX/ZTKz9vJrrKwVRhB2Fotqg+9fbre
	0s4AHW3kxiA==
X-Received: from dybtv22.prod.google.com ([2002:a05:7300:f496:b0:2d4:12b8:28ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7495:b0:2c8:8ae4:962a
 with SMTP id 5a478bee46e88-2d5870ac142mr3557382eec.2.1775890701171; Fri, 10
 Apr 2026 23:58:21 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:14 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-26-irogers@google.com>
Subject: [PATCH v8 25/29] perf sched: Bounds check CPU in sched switch events
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

