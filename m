Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA291D5CCC
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Dec 2024 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394565; cv=none; b=B9gpQKKWfQMXdZweoDpIb/ezfbyCYkMAk5OtKghEwhX5IwO+M3KHJst4DcI+M75TAEK3ShuvkC/ZJuGcrn3y9z0fz1dzH1PSBEsYW+QlaJLIGEGSaieWpPb5cqpnVoEjHy2Qhg4vDoxCavx7POMTfJHnN/oWdWED3iMjyFZFZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394565; c=relaxed/simple;
	bh=ckoXV8Prl50yqnQscf2+2cQw4ett0hPrVvf/PZvKTTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R30rVhZig3gv618w5KuLQXIWKPEJN3nu7SVyQbJNqn5QHk9AisepNlRJ31jlWErpeOUVgWKIkl9cn4QAPI+muO2VP7hRu9AjLIb7ZCQFnd8Ky6hzM1cbEj8syk6MEE9DlSgi8jBpwtomfp+JYczNXun9ccfAfezmmkADzB0EGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ve/a5myx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ve/a5myx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733394560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+S9yWB2Q2Ddgi8hcXxZfGZkEo9PsHmW3vje2XLGt+RY=;
	b=Ve/a5myx6jk/p5ws8TYlvflMwxhaOqX5mgbPJBwOm1PApwk33+MJnk+38XoTJvuE5Dl6xZ
	zLTA4V6jb6GFIl/JRd/bY+enWwEZQCJrDt+L/03wBQWzYpeVV88PeXuQGu+LI/ty0Oljcb
	/jPB3+wk93XoUE6R9G9cPxvxdyiui0w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-sxWkNQCgOMSuIBUsFbyaGg-1; Thu,
 05 Dec 2024 05:29:15 -0500
X-MC-Unique: sxWkNQCgOMSuIBUsFbyaGg-1
X-Mimecast-MFC-AGG-ID: sxWkNQCgOMSuIBUsFbyaGg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E039193EF56;
	Thu,  5 Dec 2024 10:29:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 780751954200;
	Thu,  5 Dec 2024 10:29:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  5 Dec 2024 11:28:50 +0100 (CET)
Date: Thu, 5 Dec 2024 11:28:41 +0100
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
Message-ID: <20241205102840.GB8673@redhat.com>
References: <ZyJUzhzHGDu5CLdi@localhost.localdomain>
 <20241107144617.MjCWysud@linutronix.de>
 <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
 <Zy6QHHakztIXvudC@pavilion.home>
 <20241111120857.5cWFpNkJ@linutronix.de>
 <20241204134826.GA923@redhat.com>
 <Z1DxqJlGM_I8irVQ@pavilion.home>
 <20241205092015.GA8673@redhat.com>
 <Z1F6_cC4bRvcN56T@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1F6_cC4bRvcN56T@pavilion.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12/05, Frederic Weisbecker wrote:
>
> Le Thu, Dec 05, 2024 at 10:20:16AM +0100, Oleg Nesterov a écrit :
>
> > > Looking at task_work, it seems that most enqueues happen to the current task.
> > > AFAICT, only io_uring() does remote enqueue. Would it make sense to have a light
> > > version of task_work that is only ever used by current? This would be a very
> > > simple flavour with easy queue and cancellation without locking/atomics/RmW
> > > operations.
> >
> > Perhaps, but we also need to avoid the races with task_work_cancel() from
> > another task. I mean, if a task T does task_work_add_light(work), it can race
> > with task_work_cancel(T, ...) which can change T->task_works on another CPU.
>
> I was thinking about two different lists.

OK... but this needs more thinking/discussion.

> Another alternative is to maintain another head that points to the
> head of the executing list. This way we can have task_work_cancel_current()
> that completely cancels the work. That was my initial proposal here and it
> avoids the lock/xchg for each work:
>
> https://lore.kernel.org/all/Zx-B0wK3xqRQsCOS@localhost.localdomain/

Thanks... Heh, I thought about something like this too ;) Although I thought
that we need a bit more to implement task_work_cancel_sync(). But this is
another story.

> > Hmm. I just noticed that task_work_run() needs a simple fix:
> >
> > 	--- x/kernel/task_work.c
> > 	+++ x/kernel/task_work.c
> > 	@@ -235,7 +235,7 @@
> > 			raw_spin_unlock_irq(&task->pi_lock);
> >
> > 			do {
> > 	-			next = work->next;
> > 	+			next = READ_ONCE(work->next);
> > 				work->func(work);
> > 				work = next;
> > 				cond_resched();
> >
> > Perhaps it makes sense before the patch from Sebastian even if that patch
> > removes this do/while loop ?
>
> Hmm, can work->next be modified concurrently here?

work->func(work) can, say, do kfree(work) or do another task_work_add(X, work).

Oleg.

