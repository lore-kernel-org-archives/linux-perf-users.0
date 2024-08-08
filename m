Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C3718CC08
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123060; cv=none; b=iP35FIrLbhxqScyTCtB9uwdEXOZhAji63TcI+xapLs/XxzCnSuCOTMp64NXToVsyIsgdcBfctp4i0RMcy2cWktMgLeeHij3MXseLuWPVugX2YissNJ3dpv7j/4jIsgLtR7P+kcBLY/HZ5QBLwFwEi3uPmkAVtakjFio9RZIOk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123060; c=relaxed/simple;
	bh=t+LPtWnKwFmta+rcn4kHZtopq4a0rOzX4dLqMmte6o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcrgBRJpb4Q4ON/9ioKfStt6tQuATeavo2X0K4/8HSYFhPEIxfR42Lu9SK5jYhAKEjVh0kV48BWaJ+faQx7xXHNq0a0a3vwMLILEYp/QpUYkAJ3hq2O5rgTkeZSh6CBO5N16HxeKfevDXfuA33/WTFyHjPYOEZLSorO1zyJFO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8Db1RlY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8Db1RlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723123058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XD7FvdIckarUhrXzB2SzlPRAVb193xDecLuQI6dSDYI=;
	b=f8Db1RlY9iMuEku4FE9qFw7Q4j4Fy3U5P8aikV6ut6D+Hf6qnGbcErCd8SFt1XEPXyQoiH
	uyLcRvGRW0oD09Fc3WNh1wnlsKePNRbpXwHftMVE4DmSo5EdWv47JZ83NrCNKIEDh1XzKF
	CUfYwsSJ/CMhkyh1L2+Cycm7r7L8ftQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-2rSh06GzOoKOsVWkOzbomQ-1; Thu,
 08 Aug 2024 09:17:34 -0400
X-MC-Unique: 2rSh06GzOoKOsVWkOzbomQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF5811955D59;
	Thu,  8 Aug 2024 13:17:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 182F319560AA;
	Thu,  8 Aug 2024 13:17:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 15:17:30 +0200 (CEST)
Date: Thu, 8 Aug 2024 15:17:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org
Subject: Re: [PATCH] uprobes: Improve scalability by reducing the contention
 on siglock
Message-ID: <20240808131722.GD8020@redhat.com>
References: <20240801082407.1618451-1-liaochang1@huawei.com>
 <20240801140639.GE4038@redhat.com>
 <51a756b7-3c2f-9aeb-1418-b38b74108ee6@huawei.com>
 <20240802092406.GC12343@redhat.com>
 <0c69ef28-26d8-4b6e-fa78-2211a7b84eca@huawei.com>
 <20240806172529.GC20881@redhat.com>
 <20240807101746.GA27715@redhat.com>
 <3bb87fb4-c32e-0a35-0e93-5e1971fe8268@huawei.com>
 <20240808102837.GC8020@redhat.com>
 <ef7b6889-7e15-1ff3-c7a5-b3c6dabb13d4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef7b6889-7e15-1ff3-c7a5-b3c6dabb13d4@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/08, Liao, Chang wrote:
>
>
> 在 2024/8/8 18:28, Oleg Nesterov 写道:
> > --- x/kernel/events/uprobes.c
> > +++ x/kernel/events/uprobes.c
> > @@ -2308,9 +2308,10 @@ static void handle_singlestep(struct upr
> >  	utask->state = UTASK_RUNNING;
> >  	xol_free_insn_slot(current);
> >
> > -	spin_lock_irq(&current->sighand->siglock);
> > -	recalc_sigpending(); /* see uprobe_deny_signal() */
> > -	spin_unlock_irq(&current->sighand->siglock);
> > +	if (utask->xxx) {
> > +		set_thread_flag(TIF_SIGPENDING);
> > +		utask->xxx = 0;
> > +	}
>
> Agree, if no more discussion about this flag, I will just send v2 today.

Please also resend the previous patch a 1/2, this one as 2/2.

Oleg.

