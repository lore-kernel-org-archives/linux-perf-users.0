Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633C1C242A;
	Fri, 27 Sep 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463231; cv=none; b=f9yMT1RXDP9UC2rUr0YGQg7WJvWe45rsMoVX6KjVc3RU7oKvYFANWRc66gouzuQ+YEDr6pWlriiikhQHPkIQOHG8wu7ignHUrY6gM/lIc5HLXUCCvfF/0i41OKojeKe1HJKIm4gyIXOWl+143N+wbbJwmitrxGK8DOIJdZBgjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463231; c=relaxed/simple;
	bh=nIUiDxgqflD2SH7nvjL7lUKBxvllcX5JqrcgK+ywIMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTk1ltSmIsBS3qv5JVN2ilzKzlA3ERnJYrI1+djhkDzweJPzVBBhMrGJ0TVixSbReixIIAiQkk/eqtCbg1JPC3+4+DL8SrcFaIanRsqjFk1VWYeBx5I9RFxyVyAAqHsvhVDs0tIbA3Zk1ubK+kK/KEjNCIllKGgHuG/rs4J0u6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGWncTcC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGWncTcC"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71b0d1c74bbso1846284b3a.0;
        Fri, 27 Sep 2024 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727463229; x=1728068029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKsZoLSE8Uo83LAMVBiqpWixpej/X0Qxsd++nXnThvw=;
        b=mGWncTcC9P1Gjaq3UG4BRn17fTtTyQ3iGTQ0Pc8mnEm0ZCcTxvjLvjzxk26g6vvOgC
         Ab2bwagFStduZv3WuN8wK6RvGdjPPTEUyXtvWugwFTchBJ6lAGOn2iarsVfxtwjweXxG
         GJgmA2lB13EyoZOLkGXn+q3WGLwu5Vd9LAYQ9TPMm9DWn2VsgcFbT8J4i4xZJkDFE/2Q
         edTfz64I3hImtW+JEvcua/gPTfDYZjn+pf1+7AkZKia1Y8aPoHfcO8XUzHY3rndVI0kg
         phrlSJSxR2VEkXgL9SY0aeFNPwusTG1ZhF6Zhwm0zs1SEgWPmydkSx/XWyq7+KKEdktw
         OXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463229; x=1728068029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKsZoLSE8Uo83LAMVBiqpWixpej/X0Qxsd++nXnThvw=;
        b=Uu1vxFqKsgeHBisj5KDJixSrkYpx1kVV38xnPH0rZD+IxIFWj/Y9lRkouWl/oW439L
         p0+bGXngSJlw9D8w3hO48z7m66A8Ja8co9bTuS9NkPzB1sMzphGkEhH8vZxkTOl/Bvb2
         6GqgiUekdz1Y1b1eth97+TQFAMNsIEU7lvLR9AyDqWLDz9R86H//kFrgs+GbUzxDqX/0
         34WeM9JREEulbNM0nZ2EzdSruWnwBUjlI/EVm0vOR61mWLQE05p+lFYnplLDEYU9zw6P
         Sja0IwrSz4Kte03hHMly5AJ11NoXKl5+fE2L42I35XVgw8/d56+2Z1RMPqbSXsFegtf0
         rywg==
X-Forwarded-Encrypted: i=1; AJvYcCWuJQnE0pU27wn0/WpDmfPkCsHdTk+Z4KX1gw4RpLEzWL5b8A+QITNsj+KUdwUzQrutta+RFqJCzC1d639W6JGXCQ==@vger.kernel.org, AJvYcCX0BGSUAFOH/hBpe1dJr9tqq4dWookmU0CKlY5wDaY6BW8eb0uJ8lsKzu7mIeaj4F6CX4RligTl4F0/EYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNykIER3CESpHD3kxd6pmbHVDC2cN2+jBwbboh59esBaty/HT9
	RlOYiTpMC+FkKAR6SqnXM6OrDBjTItWoLFZAoNyIU2zN6bg21EtO
X-Google-Smtp-Source: AGHT+IEUGSpbq2772BukGCLqUiWTJ8oS1H8C3nAZ4vn3TPx4CPFpwquy5QxafUgBsPA536MzXYW7VA==
X-Received: by 2002:a05:6a00:2e87:b0:717:87a1:786 with SMTP id d2e1a72fcca58-71b25f3aed3mr5994150b3a.9.1727463228815;
        Fri, 27 Sep 2024 11:53:48 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c23b6sm1930244b3a.88.2024.09.27.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:53:48 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v5 1/8] perf evsel: Set off-cpu BPF output to system-wide
Date: Fri, 27 Sep 2024 11:53:33 -0700
Message-ID: <20240927185340.658143-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927185340.658143-1-howardchu95@gmail.com>
References: <20240927185340.658143-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pid = -1 for off-cpu's bpf-output event.

This makes 'perf record -p <PID> --off-cpu', and 'perf record --off-cpu
<workload>' work. Otherwise bpf-output cannot be collected.

The reason (conjecture): say if we open perf_event on pid = 11451, then
in BPF, we call bpf_perf_event_output() when a direct sample is ready to
be dumped. But currently the perf_event of pid 11451 is not __fully__
sched_in yet, so in kernel/trace/bpf_trace.c's
__bpf_perf_event_output(), there will be event->oncpu != cpu, thus
return -EOPNOTSUPP, direct off-cpu sample output failed.

if (unlikely(event->oncpu != cpu))
		return -EOPNOTSUPP;

So I'm making it pid = -1, everybody can do bpf_perf_event_output()

P.S. In perf trace this is not necessary, because it uses syscall
tracepoints, instead of sched_switch.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index edfb376f0611..500ca62669cb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2368,6 +2368,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			test_attr__ready();
 
+			if (evsel__is_offcpu_event(evsel))
+				pid = -1;
+
 			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
-- 
2.43.0

