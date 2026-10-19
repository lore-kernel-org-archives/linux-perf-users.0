Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427470;
	b=AO9usboaWX3QOla6vIAF9+REe+bshKNhkOXjmPpNXyJ2oieGyV6tYYnWjObO12RwwelA
	 LLdm1+aGIG5jQ6lBkNg2YVfAkVMsvJscx3nvUxXb3DMZf5nEKFhCHi48Csyk9dBkCp+FP
	 ZO26Abo7yZ/dfXLwY2nl0F2jNA0UG7fWDzAmFpy0OjXPJeKcl0yf/EU7+Nyg903dfOpYC
	 N+uSbaiprG9Ut1iAC7KO5iRcMdskblmpB5U/CSlvUqIj1Q0KxkBcAAwGKcb7chBiekpKq
	 lGmO7w7GafmTDBKM3zsprSlsKe6KOJEd+hf6u5vjl5DXrMdIvRBvSmAfc9d/bBuNXsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427470;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Scanned-By;
	bh=7vGFlsnjZ5TUMr/EjNcJOClHWlRBtcNRQf4NXslTfyM=;
	b=AfZmI/tE+fplhJtV5nJHBuU1ZN82FXzyPEaQkWGnH6RqqJex2eobQ6lNPk4tpxdRG7ON
	 +9EjicqUrE5CKmYxYOZUjaKW7g9tvyF0tboxJ4K6u/ivsvM+L3RkE3ClphI++k/UCIO+m
	 G4UtAYN+lppPEL79kjd4IKbI/y9NxoMINcZCQfxu4FC8bPfP//E/d6ypV+AVRvQ/jbixV
	 j2Df68om8wlINxTvDuhpc5sNWds+SDteAom45MVzV4ip/Pb7t1WJP+ql2OWFbqBy72m/T
	 4rLSLvnJBplqm2sFVOmlbwWRVqIWtpKM+lPPPQrF40YZBEXp9nb6+G9QJ6lLwKGZe7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TD+fKMNs;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA1606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 16:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19DA1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TD+fKMNs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792427468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vGFlsnjZ5TUMr/EjNcJOClHWlRBtcNRQf4NXslTfyM=;
	b=TD+fKMNsK0fosoAX2pbCBih0qV88/JuzgijcjA7REmxm5oEJ2/TXtpuAeSQaCVXD9rUbGp
	n2q/fUA4ZArJYXUV4s7k4UcRS20G9zwaVuXtOUmnBWyjB+vCSPyA9HbuZD0DvH4edHXrJE
	/5gv+CYlpl65LtIKDmA/0F8WHKqwJpA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-Rx91e-ptPqaFVRcYxJHLXA-1; Mon,
 19 Oct 2026 16:31:02 +0000
X-MC-Unique: Rx91e-ptPqaFVRcYxJHLXA-1
X-Mimecast-MFC-AGG-ID: Rx91e-ptPqaFVRcYxJHLXA_1792427460
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9488C1800EF5;
	Mon, 19 Oct 2026 16:30:59 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9F5241803A40;
	Mon, 19 Oct 2026 16:30:54 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 19 Oct 2026 18:30:59 +0200 (CEST)
Date: Mon, 19 Oct 2026 18:30:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Binbin Deng <18983559317@163.com>, mhiramat@kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	andrii@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] uprobe: Assign session ID before publishing consumer
Message-ID: <atZFvTrDIyBtzWbo@redhat.com>
References: <20261019080709.477548-1-18983559317@163.com>
 <atX2FsqHIkOvhrLy@redhat.com>
 <CAEf4BzbX7vmpd2da4eKphX1r8=QXGey_1m32-KP=-8FOkFk15Q@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbX7vmpd2da4eKphX1r8=QXGey_1m32-KP=-8FOkFk15Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/19, Andrii Nakryiko wrote:
>
> On Mon, Oct 19, 2026 at 3:51 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 10/19, Binbin Deng wrote:
> > >
> > > consumer_add() publishes a consumer on uprobe->consumers
> > > before assigning its session ID.  handler_chain() traverses the consumer
> > > list under the trace RCU read-side critical section and can therefore
> > > observe the new consumer while uc->id still contains its initial value.
> > >
> > > The race is reachable when an uprobe at the same inode:offset is already
> > > active and a task hits its entry breakpoint while another CPU registers a
> > > second session consumer.  handler_chain() may store the stale ID in the
> > > return_instance consumer array.  By the time the function returns,
> > > uc->id has been assigned a nonzero value, so return_consumer_find() fails
> > > to match the saved ID and the session ret_handler is incorrectly skipped.
> >
> > I guess we don't really care, this doesn't differ from the case when
> > consumer_add() is called right after list_for_each_entry_rcu() in
> > handler_chain().
>
> that uc->id is important for "uprobe session" semantics,

Yes, but

> which seems a
> bit different situation compared to barely missing consumer_add() in
> handler_chain(),

I must have missed something... If handler_chain() misses consumer_add()
then push_consumer(uc->id) won't be called.  This means that then later
handle_uretprobe_chain() -> return_consumer_find(uc->id) will equally fail?

> but regardless, the fix looks good, we should apply it
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Agreed, I have acked it too.

Oleg.

