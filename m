Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CD1C1F18;
	Fri,  8 Nov 2024 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104799; cv=none; b=C1T/T0J9rrNuxh/7OmuQGEV0mTmq6SEmQ0rVrnCtq0PV4/LVug1qzERGHVemREOj8kROeoFMFvPX6+UP8gSniQeO7ivHqBjs+BZE1bwjFYvf6Xg/bXWfHE/MmRO1bwECL3VPRqEYLTcgSuPL/3sbQYBxqf8aHRitwwj7wapAmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104799; c=relaxed/simple;
	bh=VyvMOyH0+82bfFFSDpJF4HQhtVh841gbibWXKNpthTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDwADDGxlsXDsrqAwXHt8U/XnqtDtXMdMKb33j9nD5yo4w/iddO8Bia1pWtAdUeYg2YjsmcQbN/mLPZWzzdGcB4qCS7HTCYI20IZpKb1/iDxO8dA4V9PeLD6vtMUPfRJ9Ow4TlwGqm2WDidJSmTrire949x0nagDmbnw/X4uESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzUx1o8+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzUx1o8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE86BC4CECD;
	Fri,  8 Nov 2024 22:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731104799;
	bh=VyvMOyH0+82bfFFSDpJF4HQhtVh841gbibWXKNpthTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzUx1o8+vz9jW9xR/5GwKQShCqqK+tBfE6NaeFxSENGxLtY9tMqVAszbC/dDBebX6
	 cK7iNO32eMnCkxFccZhMYO9CTm6cEhGVYeElzHZF8rza039d0Xxd61ydvGnvmfCJ4Z
	 pQqXL5SGIO89nztTS0lUv8ZzvBJhCDkLjfV+BDEjgMoH0MVMlIhExl/eD5as5kj09A
	 qo0OLnvpWdhNpxPOMONM/ttPA57IQNfzV8SvgkXoB+jpEYyhLxs7p/z/xQB2FrK67L
	 8fChkSxIi+Xgws4KAC9eO8EmlJlDyW7OiDObAFdyeocDIWDaOCL+M7wvYXzaJdWho2
	 mXkQ6/9sDEIDw==
Date: Fri, 8 Nov 2024 23:26:36 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
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
Message-ID: <Zy6QHHakztIXvudC@pavilion.home>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
 <Zx9Losv4YcJowaP/@ly-workstation>
 <Zx-B0wK3xqRQsCOS@localhost.localdomain>
 <20241029172126.5XY8vLBH@linutronix.de>
 <20241030140721.pZzb9D-u@linutronix.de>
 <ZyJUzhzHGDu5CLdi@localhost.localdomain>
 <20241107144617.MjCWysud@linutronix.de>
 <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108190835.GA11231@redhat.com>

Le Fri, Nov 08, 2024 at 08:08:36PM +0100, Oleg Nesterov a écrit :
> Sorry, currently I don't have time to even read the emails from lkml.
> 
> Plus I wasn't cc'ed so I don't understand the intent at all, but ...
> 
> On 11/08, Frederic Weisbecker wrote:
> >
> > > @@ -232,13 +222,24 @@ void task_work_run(void)
> > >  		 * But it can remove another entry from the ->next list.
> > >  		 */
> > >  		raw_spin_lock_irq(&task->pi_lock);
> > > +		do {
> > > +			head = NULL;
> > > +			if (work) {
> > > +				head = READ_ONCE(work->next);
> > > +			} else {
> > > +				if (task->flags & PF_EXITING)
> > > +					head = &work_exited;
> > > +				else
> > > +					break;
> > > +			}
> > > +		} while (!try_cmpxchg(&task->task_works, &work, head));
> > >  		raw_spin_unlock_irq(&task->pi_lock);
> >
> > And having more than one task work should be sufficiently rare
> > that we don't care about doing the locking + cmpxchg() for each
> > of them pending.
> 
> Please see
> https://lore.kernel.org/all/1440816150.8932.123.camel@edumazet-glaptop2.roam.corp.google.com/
> and the whole thread.
> 
> I don't think raw_spin_lock_irq + cmpxchg for each work is a good
> idea, but quite possibly I misunderstood this change.

I did not realize there could be gazillion files released in a row. So there
could be noticeable performance issues I guess...

Thanks.
> 
> Oleg.
> 
