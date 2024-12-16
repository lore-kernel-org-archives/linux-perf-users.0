Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E102207DF4
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376819; cv=none; b=SzbVj0iaPmU3eLKqJRHKBu06v3x1CbvH7b3SlROWoNJBE8VB7wPjzvArCY50bWP1K097F+d/HFuebJOj0xzb1/PPHM/ysbomDFizJTOBE1cgYwc+qfyxpAxHZx9aJP8fEpJlUdPkd1Zn8mGqVcUxK3sQOQraIiWYaBv+zAx9EGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376819; c=relaxed/simple;
	bh=hJO7PhFFILWqOSoDZ6qlrrhdx3WwQXrpYMxPRM4LBuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRTVuxsIzaVimsnsHmSD3TvLDmTcBmylzccGJ3r0izBfXU7Yc3hVVVTjJpa6WBfEEkZ34Rw49JiiYh61MgoDLgP1ro00FQL0ghHsqqWwZ7XaaCxmvM7MUN4ZtTIN89bv6GA9Neq3tPgu66I4rVUtE05c6AB6EsJJvN24vw/s9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7/6Y1wX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7/6Y1wX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734376816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAcFp9mawsitE6ltl4OckOZ068h+OrWsoh6QDL7J4Vg=;
	b=X7/6Y1wXuedfUTtS0OqZdql+nCKHnxiWEWC4YCVDiW34a79urZn+W2kIIzear26qUWySXu
	9wPx/5JMt01qeDR4uEEaruLwEiyPaZ5mwnNcZSqrB2hjnChQwK0ta2jWe7yAtOW6XIjAJg
	/nIdEBstULC1pn1MT+vxYC8jjChH9+0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-cyoXPWvWObWdX3TmoZTNOA-1; Mon,
 16 Dec 2024 14:20:13 -0500
X-MC-Unique: cyoXPWvWObWdX3TmoZTNOA-1
X-Mimecast-MFC-AGG-ID: cyoXPWvWObWdX3TmoZTNOA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70D561956089;
	Mon, 16 Dec 2024 19:20:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.224])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5C73419560A2;
	Mon, 16 Dec 2024 19:20:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 16 Dec 2024 20:19:46 +0100 (CET)
Date: Mon, 16 Dec 2024 20:19:37 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20241216191937.GC374@redhat.com>
References: <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
 <Zy6QHHakztIXvudC@pavilion.home>
 <20241111120857.5cWFpNkJ@linutronix.de>
 <20241204134826.GA923@redhat.com>
 <Z1DxqJlGM_I8irVQ@pavilion.home>
 <20241205092015.GA8673@redhat.com>
 <Z1F6_cC4bRvcN56T@pavilion.home>
 <20241205102840.GB8673@redhat.com>
 <Z1y6vSznjbCwAvn1@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1y6vSznjbCwAvn1@pavilion.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 12/13, Frederic Weisbecker wrote:
>
> So which way do you prefer do solve the initial problem?

Ah. please do what you think/feel is right.

I can't suggest a better fix anyway.

> > > > 			do {
> > > > 	-			next = work->next;
> > > > 	+			next = READ_ONCE(work->next);
> > > > 				work->func(work);
> > > > 				work = next;
> > > > 				cond_resched();
> > > >
> > > > Perhaps it makes sense before the patch from Sebastian even if that patch
> > > > removes this do/while loop ?
> > >
> > > Hmm, can work->next be modified concurrently here?
> >
> > work->func(work) can, say, do kfree(work) or do another task_work_add(X,
> > work).
>
> Right but then isn't it serialized program order, from the compiler point of view?

Hmm, indeed, you are right. In this case the compiler can't assume it can
"defer" work->next. Thanks for correcting me!

Oleg.

