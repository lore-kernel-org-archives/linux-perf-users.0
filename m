Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23501E2111
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Aug 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590663; cv=none; b=JU0iKobZM8zJqT+Ixw8PKpGx50ptqRCfl3dMbcIwJNfoyfNyumiyDCLRaEO6/awk++pR7EsXO9lgKxIa8gf7eXw/OwZjqvUOEjq/cZ9ksxXxUcWBVwae68Mjqq3vjyaAWAPt7L7TiVgBsub1LgemGxmIf/k2cXhutIBJnQg/h/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590663; c=relaxed/simple;
	bh=uVXNxDR7qKY3f5mtHytO19EwACmQxiXxAxl8I5EYMdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNxmZ2vgdWwtSSodNz+9ue99mS4GAKStITfj+rH+5qkohIH78YjRKxuLMZO17HuuPh17O2ABd1UKUnyBnC+1wiDM1C6P1g4JHOnJTE88cJPB6y62PxH2ejKlgX8x6jdTzHY+3U1HbY3ikYu8+41QOE3K/4GZoO1LSXfv8zgHa4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpzXbgyG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpzXbgyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722590660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFZYSjXj/nOTS7A0u95Mfk5cT+BFdZgMlnPQnliy2J8=;
	b=OpzXbgyG95leQDaMLZ8nnZ0nfNWSWY6mQvS8L1NzEsk4s2BuQ5KXCMsWZieU7JXHKfP8jb
	4+BzvIgRplDcMWvD0Ji0jbfMca2s1xnldffIX3m0PhtkG6vweK9WvTCU7lUX3r8KqU6vYn
	ROcCiOVFc5Kr2PC3VAvj0eJXRopU+ws=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-wiluX6t3MMmF-6vA305zDg-1; Fri,
 02 Aug 2024 05:24:17 -0400
X-MC-Unique: wiluX6t3MMmF-6vA305zDg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35FD91956064;
	Fri,  2 Aug 2024 09:24:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 704E1300018D;
	Fri,  2 Aug 2024 09:24:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Aug 2024 11:24:13 +0200 (CEST)
Date: Fri, 2 Aug 2024 11:24:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Improve scalability by reducing the contention
 on siglock
Message-ID: <20240802092406.GC12343@redhat.com>
References: <20240801082407.1618451-1-liaochang1@huawei.com>
 <20240801140639.GE4038@redhat.com>
 <51a756b7-3c2f-9aeb-1418-b38b74108ee6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51a756b7-3c2f-9aeb-1418-b38b74108ee6@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/02, Liao, Chang wrote:
>
>
> 在 2024/8/1 22:06, Oleg Nesterov 写道:
> > On 08/01, Liao Chang wrote:
> >>
> >> @@ -2276,22 +2277,25 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
> >>  	int err = 0;
> >>
> >>  	uprobe = utask->active_uprobe;
> >> -	if (utask->state == UTASK_SSTEP_ACK)
> >> +	switch (utask->state) {
> >> +	case UTASK_SSTEP_ACK:
> >>  		err = arch_uprobe_post_xol(&uprobe->arch, regs);
> >> -	else if (utask->state == UTASK_SSTEP_TRAPPED)
> >> +		break;
> >> +	case UTASK_SSTEP_TRAPPED:
> >>  		arch_uprobe_abort_xol(&uprobe->arch, regs);
> >> -	else
> >> +		fallthrough;
> >> +	case UTASK_SSTEP_DENY_SIGNAL:
> >> +		set_tsk_thread_flag(current, TIF_SIGPENDING);
> >> +		break;
> >> +	default:
> >>  		WARN_ON_ONCE(1);
> >> +	}
> >
> > Liao, at first glance this change looks "obviously wrong" to me.
>
> Oleg. Did i overlook some thing obvious here?

OK, lets suppose uprobe_deny_signal() sets UTASK_SSTEP_DENY_SIGNAL.

In this case handle_singlestep() will only set TIF_SIGPENDING and
do nothing else. This is wrong, either _post_xol() or _abort_xol()
must be called.

But I think handle_singlestep() will never hit this case. In the
likely case uprobe_post_sstep_notifier() will replace _DENY_SIGNAL
with _ACK, and this means that handle_singlestep() won't restore
TIF_SIGPENDING cleared by uprobe_deny_signal().

Oleg.

