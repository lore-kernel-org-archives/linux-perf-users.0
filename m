Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445140;
	b=x3lDzXdifu6AOjipWfIVmDciH1p8VtkdX/cET7+TK0bCM97+uMREEEFMDZ7MTHj7BjZz
	 HeW9qyLZ1fDsCLJVu+FvV1sqnZf8FvkBgAF//wZlKIEr/lhgu/IiQSqSRhpOpEGPQSReS
	 7wEiFlyj1DNpCGY9HEFC8EqNpB3WlERRxgPguAg9A/QY4QRtanMipXeD+KhlF7JOmunBj
	 E/Z6hKzjZTWBQZlpHeKI7GpnbTeIlrM0iiuoM4zYEsLlxIfRrgRgMBCHmkqH6h4aEtw/x
	 pfqMwPDCP8DH9yyGG426e3e/pVY8qRUsV78XYwhfIV6PPzmPTggo3Zj2e0dLDiT4H3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445140;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=EJQxp1b8WsNMfoVFurNpPhpxRv6/KYmR7xfHGB3nybg=;
	b=zBn3JBux8Oo9T1u5zYAIBwVRmUJrjOP9LJK2roalRdmsVivx0UIoFRUMBwKh2iZC+Uz7
	 XPEdlzlaveNANr8wVzQnxqScXjhmiDrOLgzCEw4MJHoO8sfjZMWYP0d1tCb02L24RR4ys
	 OcFy564DtxwP/S1tqH/GLapCdBwyy1MLWVqSM0iXHlNbIZ0Dcp+Aw3AzsrercJteJASPs
	 c4n6o6V21qt4RZnpjgo3dsW5JZtCPpi0HrCF2upuUJOAv170rnh/fPOLXIeZDl+ePz89I
	 05gP1LiqudubjSxH55cci7uZObv4TPRhiZGsMBYoWoyXxjj5K5neRV4S4/fUUiPVTuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QUBxf1Tm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE8606A330
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 14:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACFE8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QUBxf1Tm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795445138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJQxp1b8WsNMfoVFurNpPhpxRv6/KYmR7xfHGB3nybg=;
	b=QUBxf1Tmg/Oe80eNJNvVD1W88h5mt2iMos1O6hKD5IKtuvywHQwVbHyq8Y63XaWq5bA510
	d1c4p5b46dD6kxJojt4drlaNcf3fkY4vvUxU+5eHPtNXZyS4KuC9jEUOL0M7zpO/elBHQ7
	TDPqgoGFSHODDvIGQX3t/OJSbYU8Gok=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-j0KvJMa_O22XrITh9ygvgw-1; Mon,
 23 Nov 2026 14:45:32 +0000
X-MC-Unique: j0KvJMa_O22XrITh9ygvgw-1
X-Mimecast-MFC-AGG-ID: j0KvJMa_O22XrITh9ygvgw_1795445129
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 622581955D7C;
	Mon, 23 Nov 2026 14:45:28 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 12FE1345;
	Mon, 23 Nov 2026 14:45:23 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 23 Nov 2026 15:45:28 +0100 (CET)
Date: Mon, 23 Nov 2026 15:45:22 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Keenan Dong <keenanat2000@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: clear extra_consumers before pooling return
 instances
Message-ID: <awRRgnRmeMDUvUWz@redhat.com>
References: <20260408100247.2065245-1-keenanat2000@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408100247.2065245-1-keenanat2000@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Andrii, can you take a look? I never understood this code in details,
and today I forgot everything...

On 04/08, Keenan Dong wrote:
>
> ri_pool_push() returns a return_instance to the per-task pool for
> later reuse. The pool reset clears cons_cnt, but it leaves
> extra_consumers behind.

So at first glance this doesn't look right no matter what...

> A reused return_instance can later grow a fresh extra_consumers
> array and then reach the cleanup path with a stale pointer from its
> previous lifetime, leading to a double free of the recycled object.

Can you add more details to explain the possible double free?
This is not immediately obvious, at least not to me.

Oleg.

> Free and clear extra_consumers before putting the instance back into
> the pool so every reused entry starts from a clean state.
> 
> Fixes: 8622e45b5da1 ("uprobes: Reuse return_instances between multiple uretprobes within task")
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
> ---
>  kernel/events/uprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 923b24b321cc..24b9884a2667 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1945,6 +1945,8 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
>  
>  static void ri_pool_push(struct uprobe_task *utask, struct return_instance *ri)
>  {
> +	kfree(ri->extra_consumers);
> +	ri->extra_consumers = NULL;
>  	ri->cons_cnt = 0;
>  	ri->next = utask->ri_pool;
>  	utask->ri_pool = ri;
> -- 
> 2.43.0
> 

