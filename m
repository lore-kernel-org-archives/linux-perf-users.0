Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E31714CF
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320150; cv=none; b=W/xjmpLqN9Ih5RARnmi1zYew5fw73g4m+Cn/9sQRiEJqEl6vkDvGaVROyAMiPC19wkCj4U9wGu3HjG2Hn8BELT/gqNhdSHLmROxiteg3ffdBHv/l03inKNBI6JbJ93+1s/muNVRIXrLb3idzqSTKZlrk7jy98mLDHkN5r9yII7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320150; c=relaxed/simple;
	bh=0j6FJ8fiuDYyiH6zzM42a3gMbVjQLvsLiYprWteC/PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC459oLEA2rW0zRSkbO1ETulSTaTdNoXzGGR3JQzTTh/oGZJR69Ng2zmuHTrtWLv3cVMTKvdXJT05Go2Iyz4L+T2uH4vD9iRw6UqAe+zQ0OGd7Y1Wu8MPgxo5IqMB7jEANammnewY+zHmDPdoXcerdVS5xvuleVNw+7Y0bvLQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnvzvyJ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnvzvyJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733320146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qsBR5UG4HjqdO1NFkUMDoQH9Jpl+TuhICWoMUDLMLik=;
	b=HnvzvyJ8jcFg2BaDdLZNB4UOHoLirEfDFF84f4KbF6rjHzwod3DWgatNKmqdsATR4vwGt2
	rW+LLyC/+W+GeyxRhXSidI9ROYsQQSfbX4PvvGRGWB6QrcxrEI5wOxMXAFiw/mwd9Stq1s
	p4wV3CaY4MDjX4qg0Fjs/3xO4gxt6s0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245--aBLzE9zP2OUyHJDjRZ_bQ-1; Wed,
 04 Dec 2024 08:49:02 -0500
X-MC-Unique: -aBLzE9zP2OUyHJDjRZ_bQ-1
X-Mimecast-MFC-AGG-ID: -aBLzE9zP2OUyHJDjRZ_bQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 528E01956055;
	Wed,  4 Dec 2024 13:48:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8E93E19560A2;
	Wed,  4 Dec 2024 13:48:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  4 Dec 2024 14:48:36 +0100 (CET)
Date: Wed, 4 Dec 2024 14:48:27 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
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
Message-ID: <20241204134826.GA923@redhat.com>
References: <Zx9Losv4YcJowaP/@ly-workstation>
 <Zx-B0wK3xqRQsCOS@localhost.localdomain>
 <20241029172126.5XY8vLBH@linutronix.de>
 <20241030140721.pZzb9D-u@linutronix.de>
 <ZyJUzhzHGDu5CLdi@localhost.localdomain>
 <20241107144617.MjCWysud@linutronix.de>
 <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
 <Zy6QHHakztIXvudC@pavilion.home>
 <20241111120857.5cWFpNkJ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111120857.5cWFpNkJ@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/11, Sebastian Andrzej Siewior wrote:
>
> On 2024-11-08 23:26:36 [+0100], Frederic Weisbecker wrote:
> > > Please see
> > > https://lore.kernel.org/all/1440816150.8932.123.camel@edumazet-glaptop2.roam.corp.google.com/
> > > and the whole thread.
>
> Thank you for this Oleg.
>
> > > I don't think raw_spin_lock_irq + cmpxchg for each work is a good
> > > idea, but quite possibly I misunderstood this change.
> >
> > I did not realize there could be gazillion files released in a row. So there
> > could be noticeable performance issues I guess...
>
> I made a testcase to open 2M (2 *10^6) files and then exit. This led
> task_work_run() run 2M + 3 callbacks (+ stdin/out/err) for the task.
>
> Running 70 samples on the "orig" kernel:
> - avg callback time 1.156.470,3 us
> - 63 samples are starting with 11 (1,1 sec) avg: 1.128.046,7 us
> - 6 samples are starting with 14 (1,4 sec) avg: 1.435.294,8us
>
> Running 70 samples on the "patched" kernel:
> - avg callback time 1.278.938,8 us
> - 59 samples are starting with 12 (1,2 sec) avg: 1.230.189,1 us
> - 10 samples are starting with 15 (1,5sec) avg: 1.555.934,5 us
>
> With the extra lock the task_work_run() runtime extends by approximately
> ~122ms for the 2M invoked callbacks.
> The spike 1,1sec -> 1,4sec or 1,2sec -> 1,5 sec is due to context
> switching (there are few cond_resched()/ might_sleep()).
>
> It is not that bad, is it?

Not that bad, but I personally dislike this patch for other reasons.
But lets forget it for the moment.

The numbers in

	PATCH] task_work: remove fifo ordering guarantee
	https://lore.kernel.org/all/1440816150.8932.123.camel@edumazet-glaptop2.roam.corp.google.com/

didn't look too bad too, yet they convinced Linus and other reviewers.

I still think that fifo makes much more sense. The main (only?) offender
is fput(), so perhaps we can do something like
https://lore.kernel.org/all/20150907134924.GA24254@redhat.com/
but when I look at this change now I see it is racy.

Stupid question. What if we revert this "task_work: remove fifo ordering guarantee"
patch above? Can this help?

I don't understand this code and the problem. But when I (try to) read the
previous discussion on lore.kernel.org it seems that perf_pending_task_sync()
fails to cancel event->pending_task because it is called from task_work_run()
and then rcuwait_wait_event() obviously hangs.

Your patch can only help if task_work_add(current, &event->pending_task) was
called before fput()->task_work_add(task, &file->f_task_work(), right?
So perhaps, if we restore the fifo ordering, we can rely on the fact that
current should call perf_pending_task() before it calls perf_release/free_event ?

Sorry in advance, I am sure I have missed something...

Oleg.

