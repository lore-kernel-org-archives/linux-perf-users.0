Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030101EBFFD;
	Wed, 30 Oct 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297250; cv=none; b=YMos8Gevomr1+maApb4wMXPmDhDCWzIuGhh9tbHo288xkO1swENjNOIwFijkhwIJZAPguO1+B++FDbVQyTB2whoAOmeu+vYg1u2EcgILtYaOWIgCEVV5cKndTaZQwzCB6Any5fsP31tbKBh3F7RvKuemHiGJ9oX3zhSIRuDPmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297250; c=relaxed/simple;
	bh=VMOeSFIln/02RJd0YqS4M95LqofrDi/DTZQjA0Y6h5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYBL6W9bgm46nABbAqvwhN/6XnBCVgnxeJKi3n6O6j0SFdRUTDkghQt894Vs6A+VsN2C1zDA0nCJcT/gIYu0idrytzRkg9teD9WCcX5nihM04JhbRJEhQk4/2tA3GLhUP/U4D3Z9Vst42tgt5arlckADWL38qOPEFp9bAqQehHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i7wKv0dk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlWlBozd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i7wKv0dk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlWlBozd"
Date: Wed, 30 Oct 2024 15:07:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730297244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVJPScEsi/7iMYMr4y9Tqf6bsqOslAbYjQMdS8PGCi0=;
	b=i7wKv0dkTiMXOoRJzNVOpwiu0LmTPd7UTz81N26wTsGlOOhvqKvpMtn6xjK5cHRDZYTCAi
	uVmSOGD+P73kAjsQ8+MV4WLx8CzojHwOmMIHfot5ropYO5kQfth6Xnvu1RrAQCa8nAE2lu
	47+IOZlD8PpQQzYJ99nTjj1odyXAOUPYHORuXdzdg0aH0Zr14NJj+CuurYT0HmvRdrgo79
	DuCs45Uyu8v/azOVEx05phkT2DIRWALpLTVnG9o2McLJwsm2p2yYUnGy8mQH3rBcqs7l1m
	oCr8vTuttfCtvnGJr/NyzEwMEOHOmBXwG/SagkeXYQhSG7yBAP0JCD8o2M9CYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730297244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVJPScEsi/7iMYMr4y9Tqf6bsqOslAbYjQMdS8PGCi0=;
	b=qlWlBozd15ZyXlaRVSGV1IffE2a85ac7NqVw9AoBd0+r+TO55rbY9cETehJc+Coip8f4EG
	s86uyccm3HeaSbDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
Message-ID: <20241030140721.pZzb9D-u@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
 <Zx9Losv4YcJowaP/@ly-workstation>
 <Zx-B0wK3xqRQsCOS@localhost.localdomain>
 <20241029172126.5XY8vLBH@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029172126.5XY8vLBH@linutronix.de>

On 2024-10-29 18:21:31 [+0100], To Frederic Weisbecker wrote:
> On 2024-10-28 13:21:39 [+0100], Frederic Weisbecker wrote:
> > Ah the perf_pending_task work is pending but perf_pending_task_sync()
> > fails to cancel there:
> > 
> > 	/*
> > 	 * If the task is queued to the current task's queue, we
> > 	 * obviously can't wait for it to complete. Simply cancel it.
> > 	 */
> > 	if (task_work_cancel(current, head)) {
> > 		event->pending_work = 0;
> > 		local_dec(&event->ctx->nr_no_switch_fast);
> > 		return;
> > 	}
> > 
> > And that's because the work is not anymore on the task work
> > list in task->task_works. Instead it's in the executing list
> > in task_work_run(). It's a blind spot for task_work_cancel()
> > if the current task is already running the task works. And it
> > does since it's running the fput delayed work.
> > 
> > Something like this untested?
> 
> Tested. Not sure if this is a good idea.
> Couldn't we take the ->next pointer and add it to current::task_works
> instead?
> That patch in ZtYyXG4fYbUdoBpk@pavilion.home gets rid of that
> rcuwait_wait_event().

Just tested. That patch from ZtYyXG4fYbUdoBpk@pavilion.home also solves
that problem. Could we take that one instead?
 
Sebastian
