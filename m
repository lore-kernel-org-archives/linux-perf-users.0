Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E436A000
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100876; cv=none; b=MhMmQOSVsVaa7kmtw0l1GshHs2s+bjOKWOBhTQSNztqrHnU5iFzBfRufozOn7D3fyPCLAmsrckt+AJBaPJDbsE+Bx2f+ydT+0eaS6Sylw4bLKGZneDUAC4oKXZUtOt+2vFpZkOenQ2WT9E53IJ50wGeKVjnSYFoThS1sCFJFVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100876; c=relaxed/simple;
	bh=WqOiFcX/heg3IGph3C/ogbRzFLpcL0diaA21e5ry5lo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZhvmQeh8iQknxhu7/Xc6PxIADQMySv4botVEV7JRBogm9hqMkx3OpG0TsqDu599ajRtABg+YPp5QwJ68y9RzViiGoRILYB50lJYo87HwtqdurVP0JugBP6/Wtu8/KA7HmOZJbjMyH4d6fO5U32dLXoGPvmOtWYrIyZEhOVRbY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSOMAGss; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSOMAGss"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b7174ab5faso5214765eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100860; x=1769705660; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnbHjkP7sr2MY8dvLIuI6wPgadGKGFiX6WTYohRo5Kw=;
        b=uSOMAGssh5dmLUIRtCZrmMb7VsAbqQZI773U2nrsh6m8PA55jIRS0RSIxlIKsCJ6iK
         Zhz9zetOv1Nu1TWCqnEY+EPbsLXuBXCN5uamUaEsA+Av8Ca9ubrvqplOew9lZKCAABrG
         OB4v8bO/RrpH48a7eA/TXKHwOqWoWGRVPE6Z+scupxkZi8D/W6eUMH954qd8LCDcmY2/
         4LkK8iuqSNuvDzZRDOj0NuwtwqG/84gW1vWTdXj33Mmt5eTjsPMNmI/Uyuq6EGezVw4+
         fT6h0FVyqLO/ydTVbYlAffpMZtIqzrbaAAdBrZ4vOCMEQi9l1elMNwOz7p75WaV/b1dE
         7PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100860; x=1769705660;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnbHjkP7sr2MY8dvLIuI6wPgadGKGFiX6WTYohRo5Kw=;
        b=s+DRvL71zaKmZVbJQbnvsV7zRdDyVKqkfmbO2k7DOwtqvAdEaODGnmqhjj2MYBiFb2
         LMLYijikgnOa/7fY1Y76ascHsT8OnWwZ2fL/ItHbvQF86oldFSCo0R2u+VY3fCa+jLIQ
         N9Jq9xNv9KB+TgfdqcD5tQ7PyW8Uu/47b8HA9+JaKHz6L0lqdeIRYxx59oW9+P9ll5jJ
         bptABfpH66Opt+OXm/oRnP3/1ee5bOErKaSYkvvUkniCkfWFUMkvQi76echsi8tBWA8H
         lrCEGLwvUVcZgvSXD0UtPYAuTVx5xfm01DQlWX1kAyOYQroyk1S56X8fNbMV33s5K4xM
         kYhA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ7Wa0cBq4B4dlbJWHmXFDe56XtMYM6rihKz7q/esblDwFSQGM7nJ+Bj5FoDhmW1CC95nGIIEaxLeTnmgw+MOg@vger.kernel.org
X-Gm-Message-State: AOJu0YwhCpRKV7OgWpwU9iV2pBM4CzilWewusti3nYMVvne7E/WjSHpq
	1AslEQ7b+Ny8KbqXvROQjE+U+WL/R0M037oc9PLZjReLYi8KBgaTdxRgHnkv0NAPKZYlIqUKvrl
	MPtCKInXaIQ==
X-Received: from dycue4.prod.google.com ([2002:a05:7300:84:b0:2ae:5283:d72f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7c13:b0:2ae:824e:31ba
 with SMTP id 5a478bee46e88-2b6b3eed5d9mr19877803eec.7.1769100860046; Thu, 22
 Jan 2026 08:54:20 -0800 (PST)
Date: Thu, 22 Jan 2026 08:53:58 -0800
In-Reply-To: <20260122165407.561888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122165407.561888-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122165407.561888-4-irogers@google.com>
Subject: [PATCH v2 03/12] perf maps: Fix reference count leak in maps__find_ams
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

