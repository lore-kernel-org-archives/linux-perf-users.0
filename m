Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455159;
	b=GOZxlVx3QgGm1jzyw6mEv2FOZ+4EAFbyDFS0hxFe2bdmi07QnFeiG2mFA6vgmfzDFiBR
	 /qRiAFVk6a30RvKk43664wh04HPr3xhnIqzHt+LsgEbUUnFxJG6NpqJsaNchxTFEx5SOE
	 Wl+1oHK+0QZlydlp1hhwEy6Oaq9FEyHOr/ehVAvnS11wnq/fObecq3/zi14OLfV+wmWpq
	 m3+GhTVQORmU7h4ukYdFCe+eRNi/CaWVwNrt4N7qejPotxhAL1UtKwitb+7aU2Y45Ft0Y
	 bcgHMPHcyqC3mrUj9M9He+xUdXMwiKwP0lKNRcJNHeNa99OywSUk3IYZ7eyB3LrFFTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455159;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=Dac1FERf1Emk9l+Dj72gPWmV4FN/j45L9H+ZPXsL8co=;
	b=x9WiQxK8jdlCmrFM3rats/m4Am7ILsfLocwjUfxKWVPqj2FLxMEwzw5Zb3uBbzv9vBRk
	 TzWQeQF+CfcjKE9ptmsXcDEFH1HBHYSAPCc/UcqAZDujMZ2UKqCPYwz1ltVnkHd1jNt77
	 S/ixswlEBn7UkF7lPEg6QZ74SE7hRhsNk1EiCxvcZcYtCCdXaWvzn1tbwkgyI3K6tQc0f
	 AHTo91rIUfESfd3HYhBxfhgXIyIdW75dSDz1ypc7DSh2ZrdEq9h3KDkLpxMBhYzHx3kzv
	 T2TXyRILV+X4TiKpaX7wMAYaDk1JkIrvNKdqrkemlUMEdB0+ZOv0mqDhDfijL9l+w5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EMeq+ySG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDA606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 17:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02DDA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EMeq+ySG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795455156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dac1FERf1Emk9l+Dj72gPWmV4FN/j45L9H+ZPXsL8co=;
	b=EMeq+ySG5aR0L8kHMyDi6QKM394i7nP6saDOu4M3CGwFvdv+E06Kgim6Vq6SzvIzV2fcwb
	FkHjnCtwd2z4JwyauoUQjlG7iVn8C5BZ9m+r12/QNp9EqR3p7lTrSV32ADcGovLt44ck82
	DiG+0Qz1gpH/L9+amrdf46wF34DT6zQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-TP4QAAtUMu2j5Hiba3cvAQ-1; Mon,
 23 Nov 2026 17:32:30 +0000
X-MC-Unique: TP4QAAtUMu2j5Hiba3cvAQ-1
X-Mimecast-MFC-AGG-ID: TP4QAAtUMu2j5Hiba3cvAQ_1795455147
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 735EC180289D;
	Mon, 23 Nov 2026 17:32:27 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1BA621955F01;
	Mon, 23 Nov 2026 17:32:22 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 23 Nov 2026 18:32:27 +0100 (CET)
Date: Mon, 23 Nov 2026 18:32:22 +0100
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
Message-ID: <awR4plQC_oIvoc2R@redhat.com>
References: <20260408100247.2065245-1-keenanat2000@gmail.com>
 <awRRgnRmeMDUvUWz@redhat.com>
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
In-Reply-To: <awRRgnRmeMDUvUWz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/23, Oleg Nesterov wrote:
>
> Andrii, can you take a look? I never understood this code in details,
> and today I forgot everything...
>
> On 04/08, Keenan Dong wrote:
> >
> > ri_pool_push() returns a return_instance to the per-task pool for
> > later reuse. The pool reset clears cons_cnt, but it leaves
> > extra_consumers behind.
>
> So at first glance this doesn't look right no matter what...
>
> > A reused return_instance can later grow a fresh extra_consumers
> > array and then reach the cleanup path with a stale pointer from its
> > previous lifetime, leading to a double free of the recycled object.
>
> Can you add more details to explain the possible double free?
> This is not immediately obvious, at least not to me.

May be this has something to do with dup_utask() -> dup_return_instance() ?

If cons_cnt = 0 but ri->extra_consumers != NULL, then
dup_return_instance() -> kmemdup() will copy old->extra_consumers, but
but kmemdup(old->extra_consumers) won't be called?

Damn this code is too complex for me ;) Anyway, I think the changelog
should say more.

Oleg.

> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1945,6 +1945,8 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
> >  
> >  static void ri_pool_push(struct uprobe_task *utask, struct return_instance *ri)
> >  {
> > +	kfree(ri->extra_consumers);
> > +	ri->extra_consumers = NULL;
> >  	ri->cons_cnt = 0;
> >  	ri->next = utask->ri_pool;
> >  	utask->ri_pool = ri;
> > -- 
> > 2.43.0
> > 

