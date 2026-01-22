Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B13451049
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067103; cv=none; b=Mruf5CA+XS7Gb5D0f9P/2spnMPx5S6O+gTN6Wq5EysyOgWcQ+sTZvkvjV8obHhuNvG70O4QYb5a+zwj0ArIE1SWnyJlYiQUrrd7sHA8mA3Par7fh6vfgD3pTwzyHKi1qTejtje5Zw663y7eEb6VCLto6dUHR+TRWVu7VR2fzPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067103; c=relaxed/simple;
	bh=WqOiFcX/heg3IGph3C/ogbRzFLpcL0diaA21e5ry5lo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UFtYfv+nFR0lIVc1aSZ09Q6f1rDIwVqKJ+tY7nVZdsxLeeR5mw4H5fJmp9IF9a+X6Cs+TDr/tGr13/nzQL45O4DkqXaKpXdIPC765fFcBmRyEc1uy4916wnUb4A48JNeOs28Wftl1qMD5gdxuSa8aUYMdsyMSn9qEQ9t/4t/x4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22z2F6bI; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22z2F6bI"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-123349958b2so3081373c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 23:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769067092; x=1769671892; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnbHjkP7sr2MY8dvLIuI6wPgadGKGFiX6WTYohRo5Kw=;
        b=22z2F6bInp6cZhvQ9Em21c3XK/Yk+8bxjkaGoHOr+ypQIMd5qS6M8YmO/ig4cTtQA5
         UKsY4BqUMT4kSZOvGIpH2bJRvZ6hgpPf3XJixF4OtNHqDwjK55UWPlkj6pcw3dz5gUOV
         TcoAsOSNTlGUTOHNUn4wItzdpmMIOUY6z7BoKdUzoLVBFXv7XSgR/4zW7qk+U5xYvLvP
         zXfjy3KmjHNtznRpcbnYN3pq6ggvdT6g3mzciVKGCcOqmWzQDxxCHIPrU8wO+52JZyTH
         voQBqvQvlIfsPHU/XqOKYb62o1jr19O6PnVPv5J0DysTs82jFGRaRl5fzLbQWE9YjCLk
         JHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067092; x=1769671892;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnbHjkP7sr2MY8dvLIuI6wPgadGKGFiX6WTYohRo5Kw=;
        b=Yps+OIM76aYFwkrYxkMh7SlM4hfOrYZecflB5FSz+orm5MysLXjB5sv8bp3JAi14k6
         a6FZ/m3Y6er45OtChcusYmq1jmiuoschjV8a60aC/O1esh1mre8ECFLkkhkd4AWAxHkQ
         Angose9uwKkVyZEzXSZ77BjJYBYlFPPU/X9o+BDiJaU6pXLo7zvbbIzdNdthOJjKP4rr
         exb4i3VbZFMgf4vUKXjjPThs98vyb5bjt13kgA1kxjLDRX/Cz777raKBJeekItkhhacM
         WUwAXgUwn9hrYzdjO7o9/sYBhkjSYldtHugTlGy9zGXYNO2JSt/eq8kt4ngb6Z+qKLUd
         b2Og==
X-Forwarded-Encrypted: i=1; AJvYcCU8NUDON/SyMW5ZzBiGu4+3KEtouyNRbYKpVbHV2+6WkK6VEQckmGgha3FTwIEZk4f5fc6AmaSyLGDwFftvemee@vger.kernel.org
X-Gm-Message-State: AOJu0YzIV/hILsfWTE66daj28Lqc7Dq1XoWmcglkUdf1FHqp0U3LEF2j
	eiA0uroyStxgDVYK4+0CE4fZ8s5rSCPlKSmRrMgGJE5yKv4p1dKhu10fBPSo+2bXHJvgqjOKGsD
	Llvf1Kije1w==
X-Received: from dlg15.prod.google.com ([2002:a05:7022:78f:b0:11f:330d:ed15])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:225:b0:11b:f056:a1b3
 with SMTP id a92af1059eb24-1244a728dc0mr16430933c88.11.1769067091900; Wed, 21
 Jan 2026 23:31:31 -0800 (PST)
Date: Wed, 21 Jan 2026 23:31:17 -0800
In-Reply-To: <20260122073127.375139-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122073127.375139-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122073127.375139-2-irogers@google.com>
Subject: [PATCH v1 01/11] perf maps: Fix reference count leak in maps__find_ams
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

ams and so ams->ms.map is an in argument, however, it is also
overwritten. As a map is reference counted, ensure a map__put is done
before overwriting it.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: 42fd623b58db ("perf maps: Get map before returning in maps__find")
---
 tools/perf/util/maps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 8ccc46d515b6..4092211cff62 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -708,6 +708,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
 		if (maps == NULL)
 			return -1;
+		map__put(ams->ms.map);
 		ams->ms.map = maps__find(maps, ams->addr);
 		if (ams->ms.map == NULL)
 			return -1;
-- 
2.52.0.457.g6b5491de43-goog

