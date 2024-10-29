Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A192107;
	Tue, 29 Oct 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222495; cv=none; b=cJlZ1wdAmhkf8hNWrd4+3zanyttO7zIJskJWB3d7hBXm7vtyaOWY/80QPgJIUBIsCx41ZPp15TPt3H2KJ6k0R1ryJUKoHIa/gRCYcNOAD7q57KxivpbXQQ/nrqivSRzPGv4M7MSWEZ/kZntpC14x6aKU26p64D7xjVlg5SdEkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222495; c=relaxed/simple;
	bh=Arltj1CGqF+HSEixbn0G/Jqg7tpZJ8SlmImGt8M/g8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edln4awc0D0YiSXJejXjgVykJqW0PRkAjYhJouB06i/wmi2QlrWK8U7dND9L0n7I1QdIfRVwkTVVIwrH+whYTegL45m11W/hsQLIhQqUunkNQ2JokSgstGboWy/UrjRAAbTqzhRnykATfuGBNFOX7szfs/FixkMK2dFEzpvdHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LUslh7zv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwzYel2q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LUslh7zv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwzYel2q"
Date: Tue, 29 Oct 2024 18:21:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730222491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tzyKQPDnGtN9OisTHM3Kv/x4ft11CeEKlB8kIWbLRME=;
	b=LUslh7zvkmbzENZDveMsUAau5aJynDQP+RmpV54Xy1dT4KgDBvMS36amrlyc/iVCuVLnR1
	ujtnl21wZYEcnWQIBoWSIET761F0Kvm75SL+s/Rr08viffkaMh99ahI1mRbqlMCLrCigXb
	MomkzmFWLFl8Ck8o5KTT7gilF3jpY+wEAEchxJwV/2b+fyAZNpkmUUsZIBcYEftaqKX8BL
	Av3V/+MEoXLoj7mi3+FxvM1cwHcdVHbqv/JQbbc7QFnuUrJ+HWESiVPEsuboasQHgurBzi
	s+3xWIhAUFQCDfgPzTRombAXv/IGWeFRcU6op7ATcMzPQ1Xq/oHjBMpV/0Do4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730222491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tzyKQPDnGtN9OisTHM3Kv/x4ft11CeEKlB8kIWbLRME=;
	b=XwzYel2q0wgUME7ii1TJYs5UY9TXogYdrtArWVGgpzs2eJ78swOkne5wKxnTNgQQg2S6Ol
	3ZR3U9eX/2S+/dAg==
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
Message-ID: <20241029172126.5XY8vLBH@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
 <Zx9Losv4YcJowaP/@ly-workstation>
 <Zx-B0wK3xqRQsCOS@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zx-B0wK3xqRQsCOS@localhost.localdomain>

On 2024-10-28 13:21:39 [+0100], Frederic Weisbecker wrote:
> Ah the perf_pending_task work is pending but perf_pending_task_sync()
> fails to cancel there:
> 
> 	/*
> 	 * If the task is queued to the current task's queue, we
> 	 * obviously can't wait for it to complete. Simply cancel it.
> 	 */
> 	if (task_work_cancel(current, head)) {
> 		event->pending_work = 0;
> 		local_dec(&event->ctx->nr_no_switch_fast);
> 		return;
> 	}
> 
> And that's because the work is not anymore on the task work
> list in task->task_works. Instead it's in the executing list
> in task_work_run(). It's a blind spot for task_work_cancel()
> if the current task is already running the task works. And it
> does since it's running the fput delayed work.
> 
> Something like this untested?

Tested. Not sure if this is a good idea.
Couldn't we take the ->next pointer and add it to current::task_works
instead?
That patch in ZtYyXG4fYbUdoBpk@pavilion.home gets rid of that
rcuwait_wait_event().

Sebastian
