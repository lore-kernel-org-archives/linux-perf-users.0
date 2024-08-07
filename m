Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC061C9DD6;
	Wed,  7 Aug 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031789; cv=none; b=kVNFZhaDx+NDSJ86m6Ii9TYcnnheDFatdZnA31BDpi+koOhddNLOuq438u24kZIE/bagmYFcTKMyPK2oFThWiuO4kVv2vAUiw4ugH/5lVp3gtf9YLRubLCJhE2CDXoXRPWpJsnNRzBS4BnPRKQhRuKhtaS+bHu5S5C5K3y88Svc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031789; c=relaxed/simple;
	bh=7vFpReSgChNl5N2B1nNSb0ynkw7YnJsq1aiowqO2L78=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=j4uN0OSJxywLLQ+FmtuTx9t/vYNU8dYPh0gT620IPFskvEafTa4pTQ6eQxw4KTyFXxj2brZUAFQQh7Ooo+iiCEmaPmh14cMonSTPZsJh5NJE/rE7NOfKe2dO83AeCFfpXonjtSyVxiU8/LmAmpSu7KmA8flVe5oxAHBWs9t5BUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dUhByFM6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dUhByFM6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Q1UNDQZ2e2JbYztzZF7igz7f6ZnlzcACcly57OU05G0=; b=dUhByFM6nnJRQGJzT7e9QWsSgT
	Rd3+Tb1dlCwVrt1blMhP4yWIWeIvqIfzG6z+qzw8Es6VOZnaNZzAdzsUoaDSLA4KNlFwshvwfG2IP
	ZCREuDkYbhAwwB6f7THXjNoIDGq3SbVbChvF59lNdSzCMPPy5LDtZMCIN2uGS8Q1NhVpK30sg6uht
	jpN4APqF/axDEAGeaaf9pFDXhhTLb4cAI7rNv5TNYu76cBRXgJ7jgoX8JuGyAw1DsdI/QhqSMGNY6
	bSqO8luVG5zxp24SQB/6I7gCt9/eAVv4HKyIQVtnxQLJg3tTf/Od6ApT0wlcuqAlr6R2JhVwlzAO5
	fkcgPPIw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbfHD-00000006cCn-136Q;
	Wed, 07 Aug 2024 11:56:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9F2D9300DDC; Wed,  7 Aug 2024 13:56:21 +0200 (CEST)
Message-Id: <20240807115550.392851915@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 07 Aug 2024 13:29:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: peterz@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] perf: Optimize __pmu_ctx_sched_out()
References: <20240807112924.448091402@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

There is is no point in doing the perf_pmu_disable() dance just to do
nothing. This happens for ctx_sched_out(.type = EVENT_TIME) for
instance.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3304,7 +3304,7 @@ static void __pmu_ctx_sched_out(struct p
 		cpc->task_epc = NULL;
 	}
 
-	if (!event_type)
+	if (!(event_type & EVENT_ALL))
 		return;
 
 	perf_pmu_disable(pmu);


