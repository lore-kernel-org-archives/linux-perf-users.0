Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675AA17BD3;
	Thu, 21 Nov 2024 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732172111; cv=none; b=SVEAUVTT2N2pcDkcmqA790m2sk8fZrCCBedf6ESDvHKZuukYtuUar22QBxgmoDwqysTBCctRc3wW19dDgq+iK52wZxl/c5dDx3Km9b3saCv+u0mJep1g5p7gbHGSyZIkWiSTrW+h8aajSpDBD4TyDMmenny5Rj6PhaQep2dk3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732172111; c=relaxed/simple;
	bh=ly84SB9ksS+ux12lYZH2Wz4TBBGj2pjjStOdVhGcPoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cg5J2m+v6tNc50INC0h8KTp7c3gpQfmx5xgRk1INhoK/nllJIjPoCeWg2Lq6UZq+ArIAbc3j7uHJWduKv3qCPa4hnc2QpiLvB2GnnBf1OMBRyuoptSf5ZK6UqgKg1plmlrVW28moiBcZgTiGXwFHh9Y5u7cdvFtvewFi1TUAOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OE3UD3Iz; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OE3UD3Iz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pgvLK
	AeCklAMAhSK2ThO7+GadLi13r288slmMgxehSQ=; b=OE3UD3IzkvhaJzr20bmL4
	52jQv5cO8FAn8BAZM09LCXKIu8ZSPm8d0tguUpHg6DjeynttoDCQ0uaehMur0Zsn
	8Y4kgB+8jLZFnCVMOG+vR/hhkPZRbX7sibqiXDdNpHMZsxMHRkt/rFDnpmzrya5Z
	vjNk6vjtJnqEt7TqKL48H4=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBXT_kx2T5nRIP0GA--.21032S4;
	Thu, 21 Nov 2024 14:54:42 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mingo@redhat.com,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: Re: [PATCH 2/4] perf/core: convert call_rcu(free_ctx) to kfree_rcu()
Date: Thu, 21 Nov 2024 06:54:40 +0000
Message-Id: <20241121065440.3391001-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120091622.GK38972@noisy.programming.kicks-ass.net>
References: <20241120091622.GK38972@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXT_kx2T5nRIP0GA--.21032S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4DWryDurWfKw45WF1xZrb_yoW8Wr47pr
	ykAF1ayay8JFnYva47ta4xZ345t39aqrn7Wa4vkw1SyrnIgr1qg3WUZr1rZFyYvr92kFWf
	Zr4qvF9F934kJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU9zVUUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqQqeTGc+0Fv59QAAsv

>On Wed, Nov 20, 2024 at 06:47:14AM +0000, Ran Xiaokai wrote:
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> 
>> The rcu callback free_ctx() simply calls kfree().
>> It's better to directly call kfree_rcu().
>
>Why is it better? 

Too many of these simple rcu callbacks increase in the kernel size,
and there have been several rounds of cleanups to replace these simple
call_rcu(). So this one is a straggler ?
Besides, no real-world problem was observed.

>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
>>  kernel/events/core.c | 10 +---------
>>  1 file changed, 1 insertion(+), 9 deletions(-)
>> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 065f9188b44a..7f4cc9c41bbe 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -1210,14 +1210,6 @@ static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
>>  		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
>>  }
>>  
>> -static void free_ctx(struct rcu_head *head)
>> -{
>> -	struct perf_event_context *ctx;
>> -
>> -	ctx = container_of(head, struct perf_event_context, rcu_head);
>> -	kfree(ctx);
>> -}
>> -
>>  static void put_ctx(struct perf_event_context *ctx)
>>  {
>>  	if (refcount_dec_and_test(&ctx->refcount)) {
>> @@ -1225,7 +1217,7 @@ static void put_ctx(struct perf_event_context *ctx)
>>  			put_ctx(ctx->parent_ctx);
>>  		if (ctx->task && ctx->task != TASK_TOMBSTONE)
>>  			put_task_struct(ctx->task);
>> -		call_rcu(&ctx->rcu_head, free_ctx);
>> +		kfree_rcu(ctx, rcu_head);
>>  	}
>>  }
>>  
>> -- 
>> 2.17.1
>> 
>> 

