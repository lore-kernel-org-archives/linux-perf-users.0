Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BD4084E;
	Wed, 31 Jul 2024 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450216; cv=none; b=gPyygLKtBW06HdM7lkcp0Z+A7Prj2tTHJUbj/Q+1JPjP4nCS8bMWrTS/g+gOEzfjxR0pFOj5fvD7gT2OFLO85++HSBk0CnOP1IdWdXJDArDxvzyxSVHZbFBP8Gjwd7p9Sa4rdTe/lhGNtjIhZ2QMs5WcuYNhZESfWi/PidEZYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450216; c=relaxed/simple;
	bh=KWBLAHqVEJNDAWVbtvGuY67hfs/WP7wwcArjC7Y79o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzozOgu6eebG5YqES16Rvv3dP6k8CwDDNqCtG8dGlNLrfrImHMSTIg/32vEvePHG6kYcSb+v/PIF/qFu+2n1/guWlhvl7gR7Pc6elszrRuSfOYrpdoNYvcrhS7lBAXw0lhWtjcfd8h+gvo1w/gjT4iiK7Tww52Knd4J3j+AMbSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEVv3zGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEVv3zGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED11AC116B1;
	Wed, 31 Jul 2024 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722450216;
	bh=KWBLAHqVEJNDAWVbtvGuY67hfs/WP7wwcArjC7Y79o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEVv3zGyriJU5fpAx192G9axrSJtFEb0h443Z/+Rc8mrLpAUnLQ5blG//LpXBgwWf
	 AU9gD0Esre/1s8I4EebvMt7oS6a4TBgUSakgjCgbnk1RxHFvJyrI0IwUn2DjYQlMOP
	 6DWudHXX92d+IQxCKnndxSqkjGQ8z1MPujMXAMIjgYjh2sLKzsW0yKWhiCGZ5ZkjEo
	 5niqBuCw7WHEiYQcIBYBE4/eAxcHkGKptgxFOEbDKoMzeCSmCBf2/CSYe6qBbFJIbh
	 /QFeSHwUA7euNOP0PRf04uBPJEC8lpFz1yE879cfWB87tyB8qUb4n421qmAhs5KNqL
	 OmRz03TQ5Ma/g==
Date: Wed, 31 Jul 2024 15:23:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, irogers@google.com,
	adrian.hunter@intel.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Dump off-cpu samples directly
Message-ID: <ZqqBJbYAsLSSJAoX@x1>
References: <20240726102826.787004-1-howardchu95@gmail.com>
 <ZqbutBvHOJ0SPd64@google.com>
 <CAH0uvogRFE_gXhSQTbXJiu-Yj2b+H1U4K40bDOgwTFyTOtHFDA@mail.gmail.com>
 <Zqp4aoqhPgW7AOQA@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zqp4aoqhPgW7AOQA@google.com>

On Wed, Jul 31, 2024 at 10:46:18AM -0700, Namhyung Kim wrote:
> On Mon, Jul 29, 2024 at 11:24:47PM +0800, Howard Chu wrote:
> > On Mon, Jul 29, 2024 at 9:21 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Fri, Jul 26, 2024 at 06:28:21PM +0800, Howard Chu wrote:
> > > > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323

> > > > Currently, off-cpu samples are dumped when perf record is exiting. This
> > > > results in off-cpu samples being after the regular samples. This patch
> > > > series makes possible dumping off-cpu samples on-the-fly, directly into
> > > > perf ring buffer. And it dispatches those samples to the correct format
> > > > for perf.data consumers.

> > > Thanks for your work!

> > > But I'm not sure we need a separate event for offcpu-time-direct.  If we
> > > fix the format for the direct event, we can adjust the format of offcpu-
> > > time when it dumps at the end.

> > Thank you and Ian for this advice, I'll do that.

> > > Anyway, as far as I can see you don't need to fill the sample info in
> > > the offcpu-time-direct manually in your BPF program.  Because the
> > > bpf_perf_event_output() will call perf_event_output() which fills all
> > > the sample information according to the sample_type flags.

> > > Well.. it'll set IP to the schedule function, but it should be ok.
> > > (updating IP using CALLCHAIN like in off_cpu_write() is a kinda hack and
> > > not absoluately necessary, probably I can get rid of it..  Let's go with
> > > simple for now.)

> > > So I think what you need is to ensure it has the uncessary flags.  And
> > > the only info it needs to fill is the time between the previous schedule
> > > and this can be added to the raw data.

I wonder if there wouldn't be other kernel information about things that
may have affected the time it took for the task to be off-cpu, maybe
system load average, C/P states, but then it would be overengineering, I
think, just thought about what else we could add that could help
understanding the off-cpu time that could be obtained from the vantage
point of BPF attached to sched-out and sched-in, things we could collect
at sched-out in addition to the timestamp and ditto at sched-in, but I'm
no scheduler expert, so take this just as some brainstorming. Maybe we
could have some sort of sample_type specific to this off-cpu event that
would allow us to ask for extra info in an extensible way. We can start
with just PERF_OFFCPU_SAMPLE_TIMESTAMP...

> > Sure thing, thank you. Other than the off-cpu duration, do you think
> > we should collect the callchain as well?
 
> I think the kernel will do that for you once you set the
> SAMPLE_CALLCHAIN flag in the event attr.

Yes, we should not reinvent the wheel for all things that can be asked
from the kernel perf subsystem, only using the raw-data payload on the
bpf-output event for things we can't get from the perf subsystem, and
that is the timestamp for a previous event stored in a BPF map, looking
if the delta to the current time (on a sched-in event) is over the
threshold and then recording this time on this specific "made-up on the
fly using BPF" event that appears on the ring buffer just like any other
"native" events such as tracepoints, hardware events, cache events, etc.

- Arnaldo
