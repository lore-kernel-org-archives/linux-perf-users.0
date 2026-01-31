Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE543371058
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889763; cv=none; b=OUVQiNwxH5+aRHx9AOQmDH3czgKPyOxHhGVEymS66QyqsVTZuNPXdOr5RKgYmA0BJdCAKblfJ66mvTnWIYp5+KOzIl4J2GF3BF7qygG6jgCt7WfNHjI7z0oNHDsun9e3QyYGwlz43Mqr43+lEcib8jg39lIOpNgm+ZqgvYUvNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889763; c=relaxed/simple;
	bh=d4upQRvP0lDqXZNMbJh/OXbkaabdEA1OKhcE2+JqhOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OgmxkUE59GlV3oVPqFv+rENQ+BWVpTDCsKOYTvDThPMK9DcDM5C3xGbXJ1Sxn7Pu6B4JfdAE42OZRaOoSfTztdY5SA3UV04Gi4+orIrPni61a1wSf8GAODDexBTfekvtBcJQNIgg6Omw4XBaCSdSc5ZktbwEQCmh+HbMr65ZxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHD1wGy+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHD1wGy+"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b724ff60e6so3679628eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 12:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769889761; x=1770494561; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yU/No/CiRXNK30X5BW5gARgpwLegeQsixxR3xJoI9G0=;
        b=BHD1wGy+XKylBq57TAt25VNR7heUwP3MnJr5Rjq/atmcGdblHY4wFrpMKMjigA16rs
         xAB8jJZ3a/yZPCN45knZVVDLbemZe+IjsrBHowAmpgxQNnbYWIr5iiaGJUKpoProxYUL
         XatGJfRehKLpwL/sMt9YBQ6vtHDQQH+U7ELVkRFS3JFaQDGNQssPRIOu7tLCgyXjynVj
         +DaHlkbQtAXmfIKl24uQQ35VbF6KhxPt9wEBiBJ3OsjQF1u+9bzd7KKX4Ly5u2OnKpPs
         UcqDvJe1ya/B0DwBRtNklCh9oVWBDpMGf/56BWmretONqdb1XPnrR3qVJd9GKHUj6PP3
         gQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889761; x=1770494561;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yU/No/CiRXNK30X5BW5gARgpwLegeQsixxR3xJoI9G0=;
        b=kz3Jujzz1EHKASZxc5La6/gUPb4LLI2oFnOI8QPvV7DXD3AbRhFVbej9bRel/yPhME
         oCX18k1HWG/QDO5tMg9QpDzgnKdVHPQw/qLvGBbihNhFg351zCayLAuhw1UK10fWSddh
         zJ8qhJvmj0/9D4dUxf8widb3XFhpjT3xIuPreJRZM3KLRs/eGKaXLunfYgXEnkhNX4cP
         /Ny7KQsHuWDaKVNRWzig8O4R/Y7JpkasI38idWZ4PrOFg+RcYEvfOEH6BRac+r+5lQdv
         rEv1ndUcow+JXkcqC50Do6w0mTpPD2OtIWl8smSrmcVtSC5NMNKDPQfzC6K1JbOOfMTC
         Gxlg==
X-Forwarded-Encrypted: i=1; AJvYcCVIlRBnnGb0KxEGuwDdwRdUUJ8lW/p5jlKD7FFgY/eTa+YGf6Vx5fRV213w68lNxZ3YpitWrCNG2rqdWoG57R9j@vger.kernel.org
X-Gm-Message-State: AOJu0YybIzSTUbhjPPQvkf0lXdfijZ/X9jOFR55Ao0aYCc+tMK1jzQtL
	afvJaKw36/gdNa2lKR7NEsEkFeEjn9MVZNHR6u/g8zLCwzU4zQTTKVc9LEN6ZF12tXMh33KcVDJ
	zQAA5xKIJzg==
X-Received: from dyek9.prod.google.com ([2002:a05:7300:6409:b0:2b7:4867:6bd0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2b13:b0:2ae:614a:330e
 with SMTP id 5a478bee46e88-2b7c8943db0mr3682412eec.41.1769889761125; Sat, 31
 Jan 2026 12:02:41 -0800 (PST)
Date: Sat, 31 Jan 2026 12:02:24 -0800
In-Reply-To: <20260131200224.1296136-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131200224.1296136-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131200224.1296136-7-irogers@google.com>
Subject: [PATCH v2 6/6] perf thread: Don't require machine to compute the e_machine
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, Yunseong Kim <ysk@kzalloc.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Blake Jones <blakejones@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
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
2.53.0.rc1.225.gd81095ad13-goog

