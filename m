Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2A286417
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770530099; cv=none; b=tAofrxZjYO1JIwk8XPAaq0bYiK+SaLjCu+Kf7cROj0W5xrt70hENHcSTgLAqqR4oXe5SJaQaO7i43Yu/FIsZyJcBruxVNCIqeIuxi7xWnTEia94tBqjQl5tyUMkZAztC2Mf+Ig+vyzDOkpFHeW2azPeZ2/nQwZwrv6caHeolxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770530099; c=relaxed/simple;
	bh=JoY1n+l6pd1BCL502VNFlXuVt8k7uJXlwxHjuh1t/zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m4X/YDa23h8WXiwhqkodErSEJ3sRIG+V2YVvdcEsnTF5kP0YtTH3eryP8zOwNGgP6NwpOFc4t/6PJ2Vd50JjidlKTSl0tjuJU07yi7fTNtSN9Uk4+PPR+R++OzdNYqFgsUWpSkXJ66hECY7fAZ4NUyrMNS31C+qfFqy0k/zRMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCTP3Fhr; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCTP3Fhr"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124aa710af7so13342031c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 21:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770530098; x=1771134898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lrW1Cx3/67vRka+SGqomkI3iFHJq9jaTFbD4Hj4rLFY=;
        b=JCTP3Fhr7Pr5NIbT7BOvLPQ59IbWrf43RoekSxx9qTI8rcLKdBN7BbAqNNYNcD7W91
         8jwE2bVX+iVxEfX+7MbIJchtiTy6F8Cz2Naupr8Z4PcuOVIonx2N/8Oyh1XRO5tsNVLb
         seazLhKB7wkF78xBYjmEehcsMBVRe5BMz8JnE0HZAW33togmxoCFxR1gWg64Ydq7t5/m
         rPT1fvyLWw0jWZMJl/ZFNXJw/Eoaelh2EOnxyH/CU6O4Xiw/Cw1k5X/37gIN6Nn8k0GE
         LecaxTWUQZDWrZyexkPoSXvXwj82o76GZl37LM9uo0otlGonmJCZTLPu/p6eBz6JjC6M
         OC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770530098; x=1771134898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrW1Cx3/67vRka+SGqomkI3iFHJq9jaTFbD4Hj4rLFY=;
        b=JqNecqO7h65tpQnX0CRekq4H3ashKn8p4nmNzsl8p6OPeoW8e9knm3fdVTWJXL7shD
         1Go/pWXUQFDzCR1VNwBGjBy8jPNvCqJiWorq9r8NPF+vRaDh418Etzi4pz4DhtN0LkZ/
         vmfMinER4LuOibmrRhM2q4XFrFqejf0FBHzJ5b0EzRvrJ2fw+ZAMpLiHBuWkTFFO25qe
         FiJkU+BUEYmDa2HpOVAB2EIjdKvSmZBGh8kn2L1FB6pxTCLosYmFBv9opD+xr4y/J1co
         1wwXWFoczMTlxybOaM+NfbeT1ViMUerENiaaZKxC3c5Up1RA2wHoC2Jog7SqKNjf0ppR
         oc6g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8pRwVCgWu0hQA0ira23tkSlEYcZBNKVXFu0eX/PJPlP6XWzomTmK9BvoI0ZjgNrPlrskmlujvrdt1s2cpbti@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUvmHcLc4X8SvCci1zcb3Q6JUB/DY+8RBVNsEw6Xflww4JGMZ
	XFlsgZfEXGA6jEOTIMzmrjfrE1CJyCRpXqQ56ebEbhwVgLQGjXpSgmtgAgrutNNXV7GSuRWRtYs
	QQyZcg6H5SA==
X-Received: from dyax22-n1.prod.google.com ([2002:a05:693c:4196:10b0:2b8:1dcd:3af6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2384:b0:2b7:2bf3:ce01
 with SMTP id 5a478bee46e88-2b85682f7d0mr3957118eec.30.1770530098372; Sat, 07
 Feb 2026 21:54:58 -0800 (PST)
Date: Sat,  7 Feb 2026 21:54:55 -0800
In-Reply-To: <CAP-5=fXH1tP_x22_YXi3F3POjjTxc8216o6=F+19XSYEWGwgOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXH1tP_x22_YXi3F3POjjTxc8216o6=F+19XSYEWGwgOA@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260208055455.2437197-1-irogers@google.com>
Subject: [PATCH v1] perf test parse-metric: Ensure aggregate counts appear to
 have run
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Commit bb5a920b9099 ("perf stat: Ensure metrics are displayed even
with failed events") made it so that counters which weren't enabled in
the kernel were handled as NaN in metrics. This cased the "Parse and
process metrics" test to start failing as it wasn't putting a non-zero
value in these variables. Add arbitrary values of 1 to fix the test.

Fixes: bb5a920b9099 ("perf stat: Ensure metrics are displayed even with failed events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-metric.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 6bbc209a5c6a..7c7f489a5eb0 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -41,6 +41,8 @@ static void load_runtime_stat(struct evlist *evlist, struct value *vals)
 		count = find_value(evsel->name, vals);
 		evsel->supported = true;
 		evsel->stats->aggr->counts.val = count;
+		evsel->stats->aggr->counts.ena = 1;
+		evsel->stats->aggr->counts.run = 1;
 	}
 }
 
-- 
2.53.0.239.g8d8fc8a987-goog

