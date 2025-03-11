Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5325BAB1;
	Tue, 11 Mar 2025 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718981; cv=none; b=jUTRCTN0kIoMHyLGfgDYNuXKHnxoX/Wv+LH0ecnEMpS9R4QjGEJkelybxE0qeCLIEqSnWl9mujfi2YK5IIbdcGVonbQmpxI2YhXg6K9gVCiRXS51BphMczTEXklaOorXmA+t0B+DQ0VoObulg0edPRIAw7c70HvklAVBCnAuNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718981; c=relaxed/simple;
	bh=VU7WhE6APe6H7bTbZRI9X/6a38vjPocJxlvi5pMbQW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G59QP7lZG/XcgZxlK0+18uIvhgUJuStwHQWVDGc+ypNp34wqKoyhM6xwJ8ET+ElqFPtiaWKW6SoC1e0PBkYfJJen7XGSh+7cWNOQOjQ89svf7DxZnjZbHTenUsQKmEh7yR5ALDgCBCMwz064Wf1NpbrhRBEWB4BZXv3LpRBjWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVlfL38z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVlfL38z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFE1C4CEE9;
	Tue, 11 Mar 2025 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741718980;
	bh=VU7WhE6APe6H7bTbZRI9X/6a38vjPocJxlvi5pMbQW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVlfL38zksyzrzIzCUm6B2wYxhaYCCME6SQ4VTx+Cq2DlFewwZWrhOz+M/A5Y7OuW
	 kbDH2r+aUUeAql3W5LUVmu2tdcYSeJVWCCODSawVQT9ZG82mImQWFjrD5jkSVdqsWR
	 X6YsAamfpy4+cRhkPbbxeTYGcTzZI1L3kQjy9NuP9yDuLTMdHhDklWxQ4890Uo66sn
	 8J/b3qud6GfrmIwX3k78SUxhRuqXo0NGmCunYPBf2TcliQ1xOi0hY5JzrbJn37+Ule
	 FM68uZRacuZAtnGs+mBsqaPr3m7tMy4XNEPcod4eqvnvFy4MlveKY+Nrmgc4OeIJFP
	 a4RP9ubH6g8zw==
Date: Tue, 11 Mar 2025 15:49:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 11/11] perf python tracepoint: Switch to using
 parse_events
Message-ID: <Z9CFwbXSGnGLn0lA@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-12-irogers@google.com>
 <Z89We45bGpeJvO9C@x1>
 <Z89WvaIVyF7klGp6@x1>
 <CAP-5=fXzva636zCZR2isdfrjT6mM3o42C+oGWNkGieqGVajfHA@mail.gmail.com>
 <Z89ZYVgL_bT3ampz@x1>
 <Z9BXdbWnX19ua5Mr@x1>
 <Z9BtpXnqSUYKr1TK@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9BtpXnqSUYKr1TK@x1>

On Tue, Mar 11, 2025 at 02:06:45PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Mar 11, 2025 at 12:32:05PM -0300, Arnaldo Carvalho de Melo wrote:
> >                 if (field->flags & TEP_FIELD_IS_STRING &&
> >                     is_printable_array(data + offset, len)) {
> >                         ret = PyUnicode_FromString((char *)data + offset);
> >                 } else {
> >                         ret = PyByteArray_FromStringAndSize((const char *) data + offset, len);
> >                         field->flags &= ~TEP_FIELD_IS_STRING;
> >                 }
> > 
> > 
> > For some reason in sessions where bytearrays are returned, and all comes
> > as bytearrays, the problem is not noticed.
> > 
> > But when it comes as a string it breaks after a short time, /me
> > scratches head...
> 
> I think I'm getting closer, with some debugging sprinkled in the python
> binding:
> 
> ip 0 pid=74131 tid=74131 cpu=3
>  ( field 'prev_comm' ret=0x7f0a66a1b970 )  ( field 'prev_pid' ret=0x7f0a66b1bed0 )  ( field 'prev_prio' ret=0x7f0a74f60d08 )  ( field 'prev_state' ret=0x7f0a74f60e08 ) time 4503271651784 prev_comm=kworker/u112:14 prev_pid=74131 prev_prio=120 prev_state=0x80 ==>
>  ( field 'next_comm' ret=0x7f0a66a1b970 )  ( field 'next_pid' ret=0x7f0a74f5fe08 )  ( field 'next_prio' ret=0x7f0a74f60d08 ) next_comm=swapper/3 next_pid=0 next_prio=120
> ip 0 pid=80209 tid=80209 cpu=4
>  ( field 'prev_comm' ret=0x7f0a66a1b970 )  ( field 'prev_pid' ret=0x7f0a66b1bed0 )  ( field 'prev_prio' ret=0x7f0a74f60d08 )  ( field 'prev_state' ret=0x7f0a74f60e08 ) time 4503280531143 prev_comm=kworker/u112:3 prev_pid=80209 prev_prio=120 prev_state=0x80 ==>
>  ( field 'next_comm' ret=0x7f0a66a1b970 )  ( field 'next_pid' ret=0x7f0a74f5fe08 )  ( field 'next_prio' ret=0x7f0a74f60d08 ) next_comm=swapper/4 next_pid=0 next_prio=120
> ip 0 pid=74131 tid=74131 cpu=5
>  ( XXX '�!' len=16)  ( field 'prev_comm' ret=(nil) ) Traceback (most recent call last):
>   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 51, in <module>
>     main()
>   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 40, in main
>     event.prev_comm,
>     ^^^^^^^^^^^^^^^
> AttributeError: 'perf.sample_event' object has no attribute 'prev_comm'
> 
> 
> So the size of the field, in the tracepoint format file is 16, its a
> comm:
> 
> root@number:/home/acme/git/perf-tools-next# grep '_comm\[' /sys/kernel/tracing/events/sched/sched_switch/format 
> 	field:char prev_comm[16];	offset:8;	size:16;	signed:0;
> 	field:char next_comm[16];	offset:40;	size:16;	signed:0;
> root@number:/home/acme/git/perf-tools-next#
> 
> But:
> 
> root@number:/home/acme/git/perf-tools-next# cat /proc/74131/comm
> kworker/u112:14-events_unbound
> root@number:/home/acme/git/perf-tools-next#
> 
> root@number:/home/acme/git/perf-tools-next# echo -n "kworker/u112:14-events_unbound" | wc -c
> 30
> root@number:/home/acme/git/perf-tools-next#
> 
> Which should explain that:
> 
> ( XXX '�!' len=16)  ( field 'prev_comm' ret=(nil) )
> 
> That is printed by:
> 
> +++ b/tools/perf/util/python.c
> @@ -318,16 +318,17 @@ tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
>                         if (tep_field_is_relative(field->flags))
>                                 offset += field->offset + field->size;
>                 }
> -               if (field->flags & TEP_FIELD_IS_STRING &&
> -                   is_printable_array(data + offset, len)) {
> +               if (field->flags & TEP_FIELD_IS_STRING) {
>                         ret = PyUnicode_FromString((char *)data + offset);
> +                       if (ret == NULL) {
> +                               printf(" ( XXX '%.*s' len=%d) ", len, (char *)data + offset, len); fflush(stdout);
> +                       }
>                 } else {
>                         ret = PyByteArray_FromStringAndSize((const char *) data + offset, len);
> -                       field->flags &= ~TEP_FIELD_IS_STRING;
>                 }
> 
> So now trying to figure out why when the comm lenght is more than 16 the
> raw_data appears to contain trash...

So it seems to be something just in the python binding, as perf trace
seems to handle it well:

 ( field 'prev_comm' ret=0x7f7c31f65110, raw_size=68 )  ( field 'prev_pid' ret=0x7f7c23b1bed0, raw_size=68 )  ( field 'prev_prio' ret=0x7f7c239c0030, raw_size=68 )  ( field 'prev_state' ret=0x7f7c239c0250, raw_size=68 ) time 14771421785867 prev_comm= prev_pid=1919907691 prev_prio=796026219 prev_state=0x303a32313175 ==>
 ( XXX '��' len=16, raw_size=68)  ( field 'next_comm' ret=(nil), raw_size=68 ) Traceback (most recent call last):
  File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 51, in <module>
    main()
  File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 46, in main
    event.next_comm,
    ^^^^^^^^^^^^^^^
AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
root@number:/home/acme/git/perf-tools-next# cat /proc/125355/comm
kworker/u112:0-i915
root@number:/home/acme/git/perf-tools-next# 
root@number:/home/acme/git/perf-tools-next# 
root@number:/home/acme/git/perf-tools-next# perf trace -e sched:sched_switch -p 125355
     0.000 sched:sched_switch(prev_comm: "kworker/u112:0", prev_pid: 125355 (kworker/u112:0-), prev_prio: 120, prev_state: 128, next_comm: "swapper/6", next_prio: 120)
^Croot@number:/home/acme/git/perf-tools-next#

I.e. it chops up the prev_comm size to what is specified in the
tracepoint format.

And that sample->raw_size is the same accross the sched:sched_switch
raw_datas (seemingly suboptimal, most are less than 16 bytes, but
probably its not guaranteed that the \0 will be there, so copy all the
16 bytes).

Now to try to figure out why simply using PyUnicode_FromStringAndSize
doesn't work...

- Arnaldo
