Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA22D5C97
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206955; cv=none; b=rwneO29Ux9k71nIIIkXK9PU6YvkuTC4VSR1jbSiC7dDZx00y3401G74anjDqWeW0/LkHOgeoEqeUmgh9Eu24p80w9kc0SqlPl9fbFiBvI71oEwDm2UHnYHlBEzrxVrW0BxG005GBdB2o90d5KFVIB9RS6LeWF22iM68EYuGdjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206955; c=relaxed/simple;
	bh=kC9AZtpAHUdBYY6O6Nxkfi+ezy8yHcBLFEIPAVk6JdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=umRhz5Q1OrF6xw28SuhatRel4knTl9+k4+Wwk6iu9r+U23KQDIn2bvZ+I96biLytWrUau7Y1Zu7tqD7z5o1vkVscq1uFOywTUSVTmtW/73XRl8hSuFfmuzlmmxZKH2OEPaXJxh0hbQajEiNf5IxT6Lwymn6fGFyoY+2SRcmxeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QjRB6D3B; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjRB6D3B"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b71bdcd037so1679779eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 14:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769206953; x=1769811753; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M71H9eDQwgF4ql2WlmE8laY3Y552yAYpetkw1WK6z+k=;
        b=QjRB6D3B1yyIHL6WKTP04dcfdQQVfMZDVevlH55HFOqk6PzzIAQWVJNgjjcHcUAY3k
         7dYaGrvNTUBto1zon0GcrWDYvuPc4naloDtxOesX0GOePUtVwiabh3d/UXqGzLo4V6oQ
         qJVd/+/8LNT6WhWI0wVxkUCrPrLaRPhBx9qe/KdUIZah8Yu2NPxeUSI5FloLJwKfz1MG
         AvuGLOuVpZ917g854P/F7Nl6n/GlDajJn21JfSL6L2DuP9ZAoq/SkGXPiLu3wRJU/XZZ
         FdIcuxZ9FxjkU2/RFdUQ+eeoGKSrokhsJyShKt36OzZjXgaxk8d63dw7TJA+lXIVlhaj
         aBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769206953; x=1769811753;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M71H9eDQwgF4ql2WlmE8laY3Y552yAYpetkw1WK6z+k=;
        b=AIu96bomlpEzRhU3FPGPAf5B0GWplcN8HVSi/ljxEWkFnsLfNVvBEq14XjEIUdXDry
         zwP+QFv0WR6NeAjKcyurzzFvtN3tcHMorU3+pSfdjXZFD3I1h1iX3MukkfZy9IFy2wW3
         7+UNhhrurRZIZil1CpGOJIh6NofF4pUjtcmHCn/mG1lw+SlfeMvhuZk5pzp866uW04e0
         ZRr4hNPtKoSXRwM+YaZp4/OrZRU2RdG++A1whyWPSnFo4REGMY3h7RHq5w3Xszs3fk0W
         Hx3Z4p8DwuUqS42xiCXDLUm9rqAOI13YwwxJFGzOKwh6R7PaZq8kNzR/qfcVP+zKw6Qi
         jJMw==
X-Forwarded-Encrypted: i=1; AJvYcCVhr/YwdGwGi9hsSgi7qXikDOj6lO5mF5IOlhBZ/17/QnlcmvlP56hct4dEOypqBJXSWgG82ww80y9JuO1YZH+T@vger.kernel.org
X-Gm-Message-State: AOJu0YwRF8T7IjddkLZXbjP41jKhPdrqnhGZBEeAD8OVq584Ghs866Dg
	rl/XdPCjm+0RBn5GpB8Kd+I+Gdf5DxRVOxARsPmhOZcxYrCyfs0kiPrIj68SMOX6/MP29cIb/u4
	hyw0daeZUQA==
X-Received: from dyjm31.prod.google.com ([2002:a05:7300:169f:b0:2b6:fdc8:cdf6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8622:b0:2b0:6a03:f08c
 with SMTP id 5a478bee46e88-2b72471588cmr4230043eec.5.1769206952582; Fri, 23
 Jan 2026 14:22:32 -0800 (PST)
Date: Fri, 23 Jan 2026 14:22:09 -0800
In-Reply-To: <20260123222209.1181249-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260123222209.1181249-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123222209.1181249-5-irogers@google.com>
Subject: [PATCH v1 4/4] perf unwind-libdw: Wire up e_flags for CSKY
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Guo Ren <guoren@kernel.org>, 
	Tianyou Li <tianyou.li@intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Howard Chu <howardchu95@gmail.com>, Sergei Trofimovich <slyich@gmail.com>, 
	Shimin Guo <shimin.guo@skydio.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Wire up the e_flags now it can be read for a thread. The e_flags
encode the CSKY ABI level and this can impact which perf registers
need setting up for unwinding.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/unwind-libdw.c | 9 +++++----
 tools/perf/util/unwind-libdw.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 3fdcfa06bf22..05e8e68bd49c 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -213,7 +213,6 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 {
 	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
 	struct unwind_info *ui = dwfl_ui_ti->ui;
-	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine, /*e_flags=*/NULL);
 	struct stack_dump *stack = &ui->sample->user_stack;
 	u64 start, end;
 	int offset;
@@ -223,7 +222,7 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 		return false;
 
 	ret = perf_reg_value(&start, ui->sample->user_regs,
-			     perf_arch_reg_sp(e_machine));
+			     perf_arch_reg_sp(ui->e_machine));
 	if (ret)
 		return false;
 
@@ -260,7 +259,7 @@ static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
 	int max_dwarf_reg = 0;
 	bool ret;
 	uint16_t e_machine = ui->e_machine;
-	int e_flags = 0;
+	int e_flags = ui->e_flags;
 	uint64_t ip_perf_reg = perf_arch_reg_ip(e_machine);
 	Dwarf_Word val = 0;
 
@@ -348,7 +347,8 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 {
 	struct maps *maps = thread__maps(thread);
 	struct machine *machine = maps__machine(maps);
-	uint16_t e_machine = thread__e_machine(thread, machine, /*e_flags=*/NULL);
+	uint32_t e_flags = 0;
+	uint16_t e_machine = thread__e_machine(thread, machine, &e_flags);
 	struct dwfl_ui_thread_info *dwfl_ui_ti;
 	static struct unwind_info *ui;
 	Dwfl *dwfl;
@@ -370,6 +370,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 		.arg		= arg,
 		.max_stack	= max_stack,
 		.e_machine	= e_machine,
+		.e_flags	= e_flags,
 		.best_effort    = best_effort
 	};
 
diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
index 3dec0ab8bd50..6423bf5a2492 100644
--- a/tools/perf/util/unwind-libdw.h
+++ b/tools/perf/util/unwind-libdw.h
@@ -20,6 +20,7 @@ struct unwind_info {
 	void			*arg;
 	int			max_stack;
 	int			idx;
+	uint32_t		e_flags;
 	uint16_t		e_machine;
 	bool			best_effort;
 	struct unwind_entry	entries[];
-- 
2.52.0.457.g6b5491de43-goog

