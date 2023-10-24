Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B218E27
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ect2QPVe"
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5510F4
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MIYrdxAOCuwhACG45cev/M36+4cXPSUKo+cU1Snj/VI=; b=ect2QPVeu5gC4JorYbxbx03NQA
	Ak2WwxE1jgqqNyCOevfWcTXZyzJSKs40wvf6PvxBTFaU864i5+IZTQVfogUE6XTlr3jPM2bppNGQj
	KORSl4F8IvCvsv2nwzo5QSTKl0PWfiZiiPQSqGd+VRBQTxJNqRju+K55RwRUeTIeNyBRTVG7zCQL/
	uIntdW4AxYUj8N+XyEjsw6aeeeWXXWQCfHaK/4bfEPQBgqPh7+BEyD5Lj2vVJ1LTTHpxhysoiSYjQ
	qOqJwp8NAmJg/+dZocuK+BCu0Vi6goLlDYTDj37BP+saKC1El34/IJSGiAzD0GXJBDIKpi0mnyZH+
	QwegCCFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qvDvZ-001kbl-QF; Tue, 24 Oct 2023 09:42:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 78572300473; Tue, 24 Oct 2023 11:42:21 +0200 (CEST)
Date: Tue, 24 Oct 2023 11:42:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [bug report] perf: Disallow mis-matched inherited group reads
Message-ID: <20231024094221.GG31411@noisy.programming.kicks-ass.net>
References: <df95d570-0f39-41bb-9072-49eb59fa2d76@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df95d570-0f39-41bb-9072-49eb59fa2d76@moroto.mountain>

On Tue, Oct 24, 2023 at 11:52:31AM +0300, Dan Carpenter wrote:
> Hello Peter Zijlstra,
> 
> The patch 32671e3799ca: "perf: Disallow mis-matched inherited group
> reads" from Oct 18, 2023 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	kernel/events/core.c:13392 inherit_group()
> 	error: potential NULL/IS_ERR bug 'leader'
> 
> kernel/events/core.c
>     13363 static int inherit_group(struct perf_event *parent_event,
>     13364               struct task_struct *parent,
>     13365               struct perf_event_context *parent_ctx,
>     13366               struct task_struct *child,
>     13367               struct perf_event_context *child_ctx)
>     13368 {
>     13369         struct perf_event *leader;
>     13370         struct perf_event *sub;
>     13371         struct perf_event *child_ctr;
>     13372 
>     13373         leader = inherit_event(parent_event, parent, parent_ctx,
>     13374                                  child, NULL, child_ctx);
>     13375         if (IS_ERR(leader))
>     13376                 return PTR_ERR(leader);
>     13377         /*
>     13378          * @leader can be NULL here because of is_orphaned_event(). In this
>                      ^^^^^^^^^^^^^^^^^^^

Yeah, clearly I can not even read my own comments :-(

>     13379          * case inherit_event() will create individual events, similar to what
>     13380          * perf_group_detach() would do anyway.
>     13381          */
>     13382         for_each_sibling_event(sub, parent_event) {
>     13383                 child_ctr = inherit_event(sub, parent, parent_ctx,
>     13384                                             child, leader, child_ctx);
>     13385                 if (IS_ERR(child_ctr))
>     13386                         return PTR_ERR(child_ctr);
>     13387 
>     13388                 if (sub->aux_event == parent_event && child_ctr &&
>     13389                     !perf_get_aux_event(child_ctr, leader))
>     13390                         return -EINVAL;
>     13391         }
> --> 13392         leader->group_generation = parent_event->group_generation;
>                   ^^^^^^^^^^^^^^^^^^^^^^^^
> New unchecked dereference

Urgh.. Thanks Dan!

---
Subject: perf: Fix potential NULL deref

Smatch is awesome.

Fixes: 32671e3799ca ("perf: Disallow mis-matched inherited group reads")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2cd6865b42a8..683dc086ef10 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13389,7 +13389,8 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
