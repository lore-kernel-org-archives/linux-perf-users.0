Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ADE38D68F
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185905; cv=none; b=o40lTgWqKhEEqU3Pkkp+E87TKZrcYqh4GYo1U/zrJ5zclftWsxfnJgZWmq5J/3J6qvbSLsIS5MUJ3wXv88toUi/LbwXOau88arWQMc2zW3h8Njv0VvgMgzFqxB16/D2yehn+/93q+43/doYpfYCPqkXNhTGlCyTfBxjVDqlPRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185905; c=relaxed/simple;
	bh=BtH0j4D4ANSbyEHLXUSbHJtMwiCmgti0BTLJkI1cLNQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TyUnAFASdV5cCKZZyCeF999fU9gg2SrCLTBz4H5WHAegB3Z4W2qTg1EUN1hoLkNu7vGnFtVunxtzOYijGkihgUh5vmLUGp5UI2fT3KvYR76Kjp9pDnlMZz/lFVHbpPMwyyikeZ5wQpi5khBHW6S6MF3STIKll+7m6fh9BhEqySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hX9PfqOh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hX9PfqOh"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-81ec0eb032aso68591347b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185897; x=1784790697; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3n+NLEtgkVKcMq53XD7BwLdhHU2hY7RObJiI/aTQumc=;
        b=hX9PfqOhkZbQ+JVEwBb9n4O6GhjgzgN4t9rWguglbwuvLMC3dkbWjC319ucmzAoyhm
         kSrDrCLpPlxQrd3svSmG+ctbROOUAvYqvA84v71iIeFpQcyyoXyIC7T3Si92epuCizm4
         YuZeFJRJI0Xt2U3lEk0b1aI4WN0yM/hU0xXmqsHUO80/Ebw3KWJX6dbgxiQgQF5o2P+0
         RCvSS/2fjMDaonZaY1CE6Xrx7u0LPSfCIHp2sjMmT1Dk4iKoPrB/+Pq/0tdKR3oCjWyR
         wbS9MaUsXzFgmj+pINhCK/iBqrpERkhApZvhe2oGnGoPqkGMkhrsBcNNQMceSTM36pou
         yw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185897; x=1784790697;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3n+NLEtgkVKcMq53XD7BwLdhHU2hY7RObJiI/aTQumc=;
        b=IoKkV8eZy0kJRdM/+m2Uqc229Iw8MmbzVQt5ggfo+xAsza593FiiRbHBQ2FdqV8pyv
         0jgwEVmtt0K48+piDU3g5QIYPXOOmhKeydN+pZFVIs8s4afPbDt+vo0f9Bodj4aB7E3e
         9DFZSzO7z8+p0iZ90M8ceh8MMNaR6xTv/OnlWWQaDnrA/7ON/yLa7LbsU9/IAjNCniBi
         duAYMNC9lg2Vq7Lk8WpNOXOi6YG3BhXivfSWCTCoU8gHCmf12aV1KjxBWBSgqKeC+aBs
         k3UPoNTLWWhKFaOdU7hoTtqAJXx+sI/jr15pIcqWSQuivS/eZok9uRSBaOrMt1tHByQM
         f8aw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6uW2TVYyYblgRGr88889ZqbtndNulNCAp7QsrJShncTs0PCfVUrkpGhjtNgivp1uFPxWZnnD13Nlbsk70YVQu@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXXSgggdliQ1nSfuZNR6kKzIfLUwXy9GhhwD9FcYaLc4robt1
	1oAtSxieqUOC3ACNqrwDigX/3fH+hct5G/KtEJ4ju9BDU7iEhYN1HOARJfeHsrDExfQmwdwZ8Z9
	SNnuM8hYCwA==
X-Received: from dlj19.prod.google.com ([2002:a05:7022:513:b0:13b:340f:d011])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:114c:b0:3b4:b275:c5b1
 with SMTP id adf61e73a8af0-3c36c1cf118mr7506417637.26.1784185402102; Thu, 16
 Jul 2026 00:03:22 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:02:54 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-6-irogers@google.com>
Subject: [PATCH v4 05/14] perf stat: Extend STD output linter to test advanced
 PMU checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run the
advanced hardware PMU and topology checks under the --new print flag:

  - check_per_cache_instance
  - check_per_cluster

This ensures that standard console outputs are verified under advanced
topology-aware aggregation environments.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 8dee005a7281..0d38a1283967 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -131,6 +131,8 @@ then
 	check_per_core "STD (New API)" "$perf_cmd"
 	check_per_die "STD (New API)" "$perf_cmd"
 	check_per_socket "STD (New API)" "$perf_cmd"
+	check_per_cache_instance "STD (New API)" "$perf_cmd"
+	check_per_cluster "STD (New API)" "$perf_cmd"
 fi
 
 cleanup
-- 
2.55.0.141.g00534a21ce-goog

