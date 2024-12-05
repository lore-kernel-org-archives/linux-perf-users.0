Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117F1D278A
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Dec 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390457; cv=none; b=ZgN+a0SGmUq7yPdaoMpdIU/+nXn/DURW5KCitaVf+aNxJaM1VrRHcaW2+ChrzJsBeXhUL6HewW+zbK2+YnTA2v75UV3HfYCU3Zs1VflWntH9PBX0h5deuESaoOvC62dqVN1ew8Q7xEjdMFaZiVyPClCtKypslJy5qjljtfmKkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390457; c=relaxed/simple;
	bh=0+RpVtrY31wygQclYfTPGuGzmBH1BJnrrQSogr49aEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYKByCvMi8gOBJzwGY04yrvFcjKsS4BkC/v3sy2qON5MCJuTINubPQIiGecxobv8W8ckLj4Xer11h/RIYBqCZ/eqWeuJ/XP36LKA60WQnAQuDvCUsOBcfI8Bp5bxapcnw3QZVJ68FYmmqgXMxU5na66sh/527EX1fCD4Lzneuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OME2q96i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OME2q96i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733390454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ym/eZknnQR+ZJLNwu9Iew/KPDqWEhOZ5yGUJfxUQVuE=;
	b=OME2q96iDbKDZngabic+mOU5Gnd5aEYFY3v72gggyz3yqyM1GTNtBIELr2+0gmMrQoeTsh
	Pzd2CBOMILJC1OI9c57Nvw7LN+RPF6LGCyn2m891uvYlQZOyWemkQlRxPrm6MtCA2q12Du
	/03+6udiKdyU6q4Iv+n5Sn1f2GPDCTI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-YfJdkzj3MnyFaZclEjtrew-1; Thu,
 05 Dec 2024 04:20:49 -0500
X-MC-Unique: YfJdkzj3MnyFaZclEjtrew-1
X-Mimecast-MFC-AGG-ID: YfJdkzj3MnyFaZclEjtrew
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55EB41955DC7;
	Thu,  5 Dec 2024 09:20:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E9C2C1955F3D;
	Thu,  5 Dec 2024 09:20:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  5 Dec 2024 10:20:24 +0100 (CET)
Date: Thu, 5 Dec 2024 10:20:16 +0100
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
Message-ID: <20241205092015.GA8673@redhat.com>
References: <20241029172126.5XY8vLBH@linutronix.de>
 <20241030140721.pZzb9D-u@linutronix.de>
 <ZyJUzhzHGDu5CLdi@localhost.localdomain>
 <20241107144617.MjCWysud@linutronix.de>
 <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
 <Zy6QHHakztIXvudC@pavilion.home>
 <20241111120857.5cWFpNkJ@linutronix.de>
 <20241204134826.GA923@redhat.com>
 <Z1DxqJlGM_I8irVQ@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1DxqJlGM_I8irVQ@pavilion.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 12/05, Frederic Weisbecker wrote:
>
> Le Wed, Dec 04, 2024 at 02:48:27PM +0100, Oleg Nesterov a écrit :
>
> > So perhaps, if we restore the fifo ordering, we can rely on the fact that
> > current should call perf_pending_task() before it calls perf_release/free_event ?
>
> Hmm but a perf event can still fire between the task_work_add() on fput and the
> actual call to task_work_run() that will run the queue. So &event->pending_task
> can be set either before or after. And then whether fifo or lifo, that would
> still be buggy.

Ah, indeed,

> Or am I missing something?

No, it is me, thanks for correcting me!

> Looking at task_work, it seems that most enqueues happen to the current task.
> AFAICT, only io_uring() does remote enqueue. Would it make sense to have a light
> version of task_work that is only ever used by current? This would be a very
> simple flavour with easy queue and cancellation without locking/atomics/RmW
> operations.

Perhaps, but we also need to avoid the races with task_work_cancel() from
another task. I mean, if a task T does task_work_add_light(work), it can race
with task_work_cancel(T, ...) which can change T->task_works on another CPU.


OK, I can't suggest a good solution for this problem, so I won't argue with
the patch from Sebastian. Unfortunately, with this change we can never restore
the fifo ordering. And note that the current ordering is not lifo, it is
"unpredictable". Plus the extra lock/xchg for each work...

Hmm. I just noticed that task_work_run() needs a simple fix:

	--- x/kernel/task_work.c
	+++ x/kernel/task_work.c
	@@ -235,7 +235,7 @@
			raw_spin_unlock_irq(&task->pi_lock);
	 
			do {
	-			next = work->next;
	+			next = READ_ONCE(work->next);
				work->func(work);
				work = next;
				cond_resched();

Perhaps it makes sense before the patch from Sebastian even if that patch
removes this do/while loop ?

Oleg.

