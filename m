Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA7335EDB3
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143250; cv=none; b=uuZzXtUmv/XYrAHemlHsX6zz6W/f0r4CsYJsPx2omY77ShxjkUvtscBcax01ICSuEmapYEMr+JIUPGcIsKNlBor2uVzqJrGlxP98f4tCfz23mGHv3GehTGYlf9jhCICdR7CE72Wt6sjVhROej9U6V57BYB7b4ReFQyvqfiCvMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143250; c=relaxed/simple;
	bh=cxW5E6PS3j+YMSlMxPs0pg15R3kh9Gvwggyb8H61pds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R9T+HLJo0rfq8KQBljbRwZhOZI1vBm90q84VpkPlIP/NoNEepLHZF+gYi/w5ORZGlTl2BZUxrdZhQteOJ0+yCR03M0tlF7carQ/gBA/j+DMWLsgJufDqPqyCDSBm/JTmPO8H7gGM0yKx2rT+bhfNZUOwTkzj9ERDdJxzzbt2HvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YfGSdv+B; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfGSdv+B"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b75222e9easo13362380eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 10:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770143248; x=1770748048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Lo69Fl4f1ujd/UcQ8IKUv7cnjD0QPa0txh8j6kiRg=;
        b=YfGSdv+BN4DBtmXLM8k4V06gkFUY76dDOp5BnxFmc9Tc6ZQVhYZoAN/gnkw+SBN7Zl
         X5aH0sg1YgEYj8KWTbHy70vLSv3OmYCbpZ+/Uwq/I7Sb0CQxjHinURfOf05NV8GzaBnd
         63/fppLu0s6Titvg2Rlx8tCFzxjpJgq31yj+JGW0gOT1wK2Bo+kkK7NceKS2g1l2uABh
         kXI1neNKu9MrTxqDkNxWa2bqheI0WhlAZwl8WSPYEdAUCeErbGyLT68+IBnen9/rg+4g
         SLAvUKL9R0dP1E5U3BpJdrTST/UIln74TtAZGaTp9kZ2Dp1v2V4MbTCH2E7zKAdqDECE
         qk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770143248; x=1770748048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Lo69Fl4f1ujd/UcQ8IKUv7cnjD0QPa0txh8j6kiRg=;
        b=CpKLROQGWKOtTmZGu7Rx9IPlRP7+kw41hVpa6cO2dc2NzC7IywvGS5HQpkHcxmXv61
         Zh+k+6dPrK/SLViIJBSNFJI+aibYqISW3jJJi0SAN44CIH3MGTZ+ns3npIC+ImU1S2TY
         r3f1U0YuHyCJoKDhhLnMwdWvmjFcYt23M/f9fxVtPw01iPwK8LkRSq1k6qEDoKVPY5IP
         04QQhGyFzVEy4ZzroAShzc8Xkb1sGFuOOrf3/VMm0NgnK88zzutbf2R2iyfoDlUlvNJO
         zJ7bwCjH05SCSEjtGelaYkwKz1TsBoSI0EwVKt1RPrwL4mupn5Popir7Z/oguMpSQnv+
         eojg==
X-Forwarded-Encrypted: i=1; AJvYcCU/6wtlZIqlD9Ui3EK7fLCqO9UgitUNu46BSSkcJpLxRBNli4NznmjOrXfCGhRHhDEMAnNwAS+YKtyzQ9uWr2nW@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbTmdGZ1phr/73qxXlbKzTCdpLCjr4od5zeVV4y97xVwf5psO
	hncY0i+nlEbRH0M7BBHGG6ztKK3BZwT2vkEKqVS6PypXsrzeHZEJUPmiJQCKzLeuxUgABp05y7c
	VZGnDn4Em2Q==
X-Received: from dybmd11.prod.google.com ([2002:a05:7301:180b:b0:2a4:6ffc:87c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a287:b0:2b7:f522:9964
 with SMTP id 5a478bee46e88-2b83296f2f4mr186503eec.7.1770143247875; Tue, 03
 Feb 2026 10:27:27 -0800 (PST)
Date: Tue,  3 Feb 2026 10:26:40 -0800
In-Reply-To: <20260203182640.3911987-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYIOMWb2sijXzSDm@x1> <20260203182640.3911987-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203182640.3911987-6-irogers@google.com>
Subject: [PATCH v3 5/5] perf thread: Don't require machine to compute the e_machine
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: aditya.b1@linux.ibm.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, ashelat@redhat.com, 
	atrajeev@linux.ibm.com, blakejones@google.com, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, dvyukov@google.com, howardchu95@gmail.com, 
	irogers@google.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, swapnil.sapkal@amd.com, thomas.falcon@intel.com, 
	will@kernel.org, ysk@kzalloc.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The machine can be calculated from a thread via its maps. Don't
require the machine argument to simplify callers and also to delay
computing the machine until a little later.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 8 +++-----
 tools/perf/util/session.c                              | 3 +--
 tools/perf/util/thread.c                               | 5 +++++
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 62c9c73daef5..2b0df7bd9a46 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -837,7 +837,6 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 					 PyObject *callchain)
 {
 	PyObject *dict, *dict_sample, *brstack, *brstacksym;
-	struct machine *machine;
 	uint16_t e_machine = EM_HOST;
 	uint32_t e_flags = EF_HOST;
 
@@ -926,10 +925,9 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
 	}
 
-	if (al->thread) {
-		machine = maps__machine(thread__maps(al->thread));
-		e_machine = thread__e_machine(al->thread, machine, &e_flags);
-	}
+	if (al->thread)
+		e_machine = thread__e_machine(al->thread, /*machine=*/NULL, &e_flags);
+
 	if (set_regs_in_dict(dict, sample, evsel, e_machine, e_flags))
 		Py_FatalError("Failed to setting regs in dict");
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 53f51c3f9603..4b465abfa36c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2972,9 +2972,8 @@ struct perf_session__e_machine_cb_args {
 static int perf_session__e_machine_cb(struct thread *thread, void *_args)
 {
 	struct perf_session__e_machine_cb_args *args = _args;
-	struct machine *machine = maps__machine(thread__maps(thread));
 
-	args->e_machine = thread__e_machine(thread, machine, &args->e_flags);
+	args->e_machine = thread__e_machine(thread, /*machine=*/NULL, &args->e_flags);
 	return args->e_machine != EM_NONE ? 1 : 0;
 }
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 618f29afb160..22be77225bb0 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -499,6 +499,11 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 		return e_machine;
 	}
 
+	if (machine == NULL) {
+		struct maps *maps = thread__maps(thread);
+
+		machine = maps__machine(maps);
+	}
 	tid = thread__tid(thread);
 	pid = thread__pid(thread);
 	if (pid != tid) {
-- 
2.53.0.rc2.204.g2597b5adb4-goog

