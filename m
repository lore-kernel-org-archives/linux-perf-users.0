Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7F16ABEA
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896736; cv=none; b=Hd2FKlxgoYQIHZxOhN2xHMBK53I8QLUllq77bnPVRjtobF+vqayj40boFGFoUAzeAOkI3kNx/pmQWLED0lE6kt7AcCO1IYTUl3lT6pSzinDfPcx49FU4lU4L1JL8HYKnECL4ElNy4gXY8t5Ki61mxy/tGuj1Zy8bd/JRGg6o428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896736; c=relaxed/simple;
	bh=0/xV4LdFkajcn56LDZkrLi7f4puJVzOTzZj2Rq2qAd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTJQNIdfat8cvt4dpcftGDXZXTEstMAnUeU10txjA1fFTsAnaO4gH+X04+UbFy1RLbL7RbhrpYKe48bn/D1zR9b4uxjVErVp/4H04auw5cANT7K3BAswUi4TledFR6UEAKgFP40YGCWX48u0X4eCvQufOfnUTFFHMW6XqQmjuqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdhaqmeA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdhaqmeA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716896733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rMfCZO8g2vfGsqH1SK9rU/F4CmTOiXAI1AfElosqsKo=;
	b=PdhaqmeAT6eW93R0mhtTlNz7gr4dvqn/AlKPwhrDC50Cz/shpkFMZsgFmEDmXzNwQPZ25A
	PRHHx/KvmPEU8Scn0Sn4xQzly3KT65AUbEJOQucfhAfnW3jyRTTLxQksFdl6+ZaY4rr6N3
	tgIN6RYIu78yKpaguH4WtdCS51d4PcQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-etJcTkoMMJuAw7lIc9lwCw-1; Tue, 28 May 2024 07:45:31 -0400
X-MC-Unique: etJcTkoMMJuAw7lIc9lwCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77806801948;
	Tue, 28 May 2024 11:45:30 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.224.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AEAA6C15BB1;
	Tue, 28 May 2024 11:45:27 +0000 (UTC)
Date: Tue, 28 May 2024 13:45:25 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: add a shortcut for metrics
Message-ID: <20240528114525.GA449511@alecto.usersys.redhat.com>
References: <20240527101519.356342-1-asavkov@redhat.com>
 <ZlS8pc39t2c1WFye@x1>
 <ZlS9M1vcxZ3Qsx_B@x1>
 <ZlTCvelaGVb6lCia@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlTCvelaGVb6lCia@x1>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Mon, May 27, 2024 at 02:28:29PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 27, 2024 at 02:04:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
> > > > Add -M/--metrics option to perf-record providing a shortcut to record
> > > > metrics and metricgroups. This option mirrors the one in perf-stat.
>
> > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
>
> > > Not building for me, I needed to add the rblist.h header and also I
> > > think we need to use metricgroup__rblist_init(&mevents), right?
>
> > Argh, that is a static function, it seems we trigger it by having
> > nr_entries = 0, so the following should do the trick:
>
> >   struct rblist mevents = { .nr_entries = 0, }
>
> > So that we don't depend on the compiler zeroing that field, which for
> > local variables it should not.
>
> How did you test this?
>
> I'm trying:
>
> perf list metric
>
> pick a metric then:
>
> perf record -M tma_core_bound
>
> And it gets in a long loop doing perf_event_open() calls...

[snip]

> (gdb) bt
> #0  0x00007ffff6f21804 in close () from /lib64/libc.so.6
> #1  0x000000000061fbd2 in perf_evsel__close_fd_cpu (evsel=0xdab470, cpu_map_idx=6) at evsel.c:188
> #2  0x000000000061fc22 in perf_evsel__close_fd (evsel=0xdab470) at evsel.c:197
> #3  0x000000000061fc9b in perf_evsel__close (evsel=0xdab470) at evsel.c:211
> #4  0x00000000004e0b5f in evlist.reset_weak_group ()
> #5  0x0000000000423bb9 in __cmd_record.constprop.0 ()
> #6  0x00000000004276c5 in cmd_record ()
> #7  0x00000000004c4579 in run_builtin ()
> #8  0x00000000004c4889 in handle_internal_command ()
> #9  0x0000000000410e57 in main ()
> (gdb) c
> Continuing.
> ^C
> Program received signal SIGINT, Interrupt.
> 0x00007ffff6f21804 in close () from /lib64/libc.so.6
> (gdb)
>
> So you should investigate this further.

I tried a bunch of random metrics from perf list but didn't hit this.

It spins forever in evlist__for_each_entry() loop in record__open() with
the same error:

        Weak group for TOPDOWN.SLOTS/5 failed

Looks like the culprit is one of those unsupported metrics, will
investigate.

> The idea, from my notes, was to be able to have extra columns in 'perf
> report' with things like IPC and other metrics, probably not all metrics
> will apply. We need to find a way to find out which ones are OK for that
> purpose, for instance:
>
> Opening: cpu_core/topdown-bad-spec/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu_core)
>   size                             136
>   config                           0x8100 (topdown-bad-spec)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   freq                             1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -22
> switching off PERF_FORMAT_LOST support
> Opening: cpu_core/topdown-bad-spec/

Is it just metrics containing unsupported events that need to be skipped
or there are other cases that wouldn't make much sense? If the latter
maybe it will be easier to just tag the ones that are supported (or not) in
pmu-events?

--
 Artem

