Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A13DA5B2
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Mar 2026 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772651180; cv=none; b=TY2wjMUNWhPcyUdyvBwE6XLsDdteFsmwQrFnEBSWbtmm8rIZKe1FFrsHSDEkggQL3Juc9FklvbUzbqQ78XYBxyxNb3RG/S2V6NrYQYvDokaVoOWAlU8IyoO7WHE/D78i57KvjiObMAIHZ14TF7Xf4Nk0MmNSViW33ClLcjIThhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772651180; c=relaxed/simple;
	bh=rgHhhK904eJTrKQNA3d+lrJY9I8xSxH1hvgB75KvjM8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HLaMMwKKOpDPJWkXErSTYzrlzzIElng4VcSDQOyO3T2CQKcXY1VLh9/UPXXibb233LDRaFRUGn91CcqJYbIrgQNdcEii09cPOVZkPcfIY5KtCotGynKQJidGciUSjWpnUEdSoSNB4aJxqvvxBouJJtMgH5rUmrFzU0qGu7qGWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifNlccI7; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifNlccI7"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2be1bc0905bso2769007eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 11:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772651179; x=1773255979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aZoK9TpWtH8M9FGRXi7BDR9wHii+12mE/LlkI5rGic4=;
        b=ifNlccI7BskY05SBUgIoFtPJaeL1DJWN8e7Eyz8/Tl0u3dkG7j4cwIXVlqX3JXzTpy
         g64AhoX9IGb0UCoftcEdZizc7bKCPw4qJ4s+hNx0ktAA+nnTEB1OmphSFqmwl6veelA9
         dv/bfOQkr+T1m2RYVS8OfcLWa4vBBv0sONagJlHD+R83u5z6W0jbkX5xbyxbmcw6448W
         byj3VCSyAUgKwYXjzeoVDo6LFerKceXcA6Pk02ffFYPByfSSKueJOFNwzVSN5uYZMsAE
         NAfgeg6YNO6ARFTIGM9/IveYJMl8ZZTYWDcQ2L9ee+sYeRpMca4cvm2ybIRdt+VKWM6v
         f0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772651179; x=1773255979;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZoK9TpWtH8M9FGRXi7BDR9wHii+12mE/LlkI5rGic4=;
        b=sZ7nzlZ2Yy0q+xzeCfqjWGob7jCuWgm9UR40C3XBpLyaXZoTUVd7U20HMGf0Q86kkq
         ueH4HE+skFIZeeoadqr7S0nHVoIPqnfl5RPPyckKGpNmiWl0LGMBa1k4HfMMLG2k5yBY
         MMuFTmFUJosaJOlYAgBHU0iLrEXJgyUs+4M/yvdEWRq+MuCjKVC0r1aECNHHXiGsHvYO
         Y9ffoiOlC15EwHpvDJxtmjsv3le7wIM4uxvQ2xRD1rcoQGC09uK5UnbAnX0n2TmtjJjU
         lxmhNt2EywXB/ChYWIG/kUw+eF2Xf61zwPOjnGpdCFyLPhOJpwYp9Dyj4P7YNVdPfzGy
         kEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHfZsohIyQORfU6sl9neICLHt1bjEwlZO+8RGIct+E14frGsQczosVUdSE5oRCtI+Uj4Ffs7jvlIo6roTk2889@vger.kernel.org
X-Gm-Message-State: AOJu0YyV6Gg0CQWDQ6LyYfTL7cM6Sah/+mTUGWt73wsQ/W+eABxTGIQq
	jmeepEFLgDCE+7KCo3YJO4VU2OrucpfnpXEkWTk7obq9xS6Jh41mOugthC9y7KymtGfQsg==
X-Received: from dlbuy16.prod.google.com ([2002:a05:7022:1e10:b0:127:32c4:b97b])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6609:b0:123:2ee9:d1b3
 with SMTP id a92af1059eb24-128b7075854mr1369664c88.2.1772651178263; Wed, 04
 Mar 2026 11:06:18 -0800 (PST)
Date: Wed,  4 Mar 2026 11:06:12 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304190613.2507582-1-pcc@google.com>
Subject: [PATCH] perf disasm: Fix off-by-one bug in outside check
From: Peter Collingbourne <pcc@google.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Collingbourne <pcc@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

If a branch target points to one past the end of a function, the branch
should be treated as a branch to another function. This can happen
e.g. with a tail call to a function that is laid out immediately after
the caller.

Link: https://linux-review.googlesource.com/id/Ide471112e82d68177e0faf08ca411d9fcf0a7bdf
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 tools/perf/util/disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index ddcc488f2e5f0..9e0420e14be19 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -384,7 +384,7 @@ static int jump__parse(const struct arch *arch, struct ins_operands *ops, struct
 	start = map__unmap_ip(map, sym->start);
 	end = map__unmap_ip(map, sym->end);
 
-	ops->target.outside = target.addr < start || target.addr > end;
+	ops->target.outside = target.addr < start || target.addr >= end;
 
 	/*
 	 * FIXME: things like this in _cpp_lex_token (gcc's cc1 program):
-- 
2.53.0.473.g4a7958ca14-goog

