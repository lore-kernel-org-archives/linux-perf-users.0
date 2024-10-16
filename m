Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34838154429;
	Wed, 16 Oct 2024 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043831; cv=none; b=sYQqzbPJpcw1Z4GfeJs70xNAdOaBtMcHJsit5HytQlqLL4ReYgvLrINEul6jv2N7e8og9S8/7ZMoQ85yOYFeoM9n06+JQ9whjzWoH+ShI+1kK/dubOcz3kilJryFATXSyFqbEHicBtkWlw4OZq/em7G6UjGZZHyFSlkmkKGwgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043831; c=relaxed/simple;
	bh=Y2BKlDs6C2MgyKrG1bPqWTtqWVqdaILO78P3aMJC0Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8vEHDDCqeizffpbOE0SQ/wWtXp2hQTgaXj4fZXnZ9HAAfRBjvwJo6naIAdF03eDm4anUMPVAV+6LfYeaVTwrc60VWN1It5pSwVJVmJGtrcIUZ4aOLU+UxNE4LuqSaCRJ7W9oYozaf5K78/pIhn8qRTLgwaYlFCq8XWe1uFBw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uea3560D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uea3560D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B7BC4CEC6;
	Wed, 16 Oct 2024 01:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729043830;
	bh=Y2BKlDs6C2MgyKrG1bPqWTtqWVqdaILO78P3aMJC0Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uea3560DPIvV9wPu7zHb52JJVzvT4Z957vO8uQ+os4q40/MrcFl5Ug/ph0fvpgaKD
	 ZDSeldedrFDoWLY4aBZ5fYclyHqU9P1aegkuHIWGr9PnPTlYa94UQjBSlOy/SqfbbF
	 HmeKW4Mm8ABCjMb0rdua2x0xYXF5YbZHgiYkdsgBv4iMNxo4cI0M3O9/2m5ldiFOC7
	 jweC4j9x4hYXmOTgzh0IDGIWjHg4xRXpUikEfiBd/81Ltu0KfNL9PAu/uSMnKO8j3P
	 CD4+dhMTawA9pFQMAsoBIqwrSUd2qf50mM+ud0Thwcl1dd2TV+LZezQ/dOQK2xTGxa
	 XQlcK5EOKugsA==
Date: Tue, 15 Oct 2024 18:57:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf test: Fix probe testsuite with a new error message
Message-ID: <Zw8ddemrwX_mzQNJ@google.com>
References: <20241010051620.1066407-1-namhyung@kernel.org>
 <ZwfNL2sLL8cDy2au@x1>
 <ZwfNmDNzQAXf0ZQV@x1>
 <af8c186d-72ba-4fcb-8737-84b665017cdd@redhat.com>
 <CA+JHD91skZHrEanhANQzWaq=4wpZomTn8Vab4j+wT2kHdibTkA@mail.gmail.com>
 <2a212bcf-a8ee-4f10-9c5b-948b9f6895f3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a212bcf-a8ee-4f10-9c5b-948b9f6895f3@redhat.com>

Hello,

On Tue, Oct 15, 2024 at 12:46:35PM +0200, Veronika Molnarova wrote:
> 
> 
> On 10/10/24 16:40, Arnaldo Carvalho de Melo wrote:
> > On Thu, Oct 10, 2024, 10:31 AM Veronika Molnarova <vmolnaro@redhat.com>
> > wrote:
> > 
> >>
> >>
> >> On 10/10/24 14:50, Arnaldo Carvalho de Melo wrote:
> >>> On Thu, Oct 10, 2024 at 09:48:52AM -0300, Arnaldo Carvalho de Melo wrote:
> >>>> On Wed, Oct 09, 2024 at 10:16:20PM -0700, Namhyung Kim wrote:
> >>>>> On my system, it's constantly failing because of new error message from
> >>>>> perf probe.  It should update the regex pattern to match the message -
> >>>>> "A function DIE doesn't have decl_line. Maybe broken DWARF?".
> >>>>>
> >>>>>   $ sudo head -n 2 /sys/kernel/debug/kprobes/blacklist | cut -f2
> >>>>>   warn_thunk_thunk
> >>>>>   asm_exc_divide_error
> >>>>>
> >>>>>   $ sudo perf probe warn_thunk_thunk
> >>>>>   A function DIE doesn't have decl_line. Maybe broken DWARF?
> >>>>>   A function DIE doesn't have decl_line. Maybe broken DWARF?
> >>>>>   Probe point 'warn_thunk_thunk' not found.
> >>>>>     Error: Failed to add events.
> >>>>>
> >>>>>   $ sudo perf probe asm_exc_overflow
> >>>>>   Failed to find scope of probe point.
> >>>>>     Error: Failed to add events.
> >>>>
> >>>> We discussed this in the past, I came up with a similar patch, Veronika
> >>>> rightly pointed out that this may point to a real problem, Masami said
> >>>> that since these are for DWARF from assembly those are known issues, I
> >>>> suggested Veronika checked if the CU where the function came from was
> >>>> generated from Assembly (there are DWARF tags that have that info), IIRC
> >>>> she said she would try to do it.
> >>>>
> >>>> I'll try to find out the threads and see what happened.
> >>>
> >>> https://lore.kernel.org/all/ZvXhJLkJcR99Y2sF@google.com/T/#u
> >>>
> >>> Veronika, was there a v3?
> >>>
> >>> Thanks,
> >> Well the patch was already applied upstream so we are talking about a fix
> >> not v3, right?
> > 
> > 
> > 
> > 
> > Can you provide a url for the patch that was applied upstream?
> > 
> > I just checked at
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh?h=perf-tools-next
> > 
> > And I'm not seeing it.
> 
> Well the patch adding the failing test case that you can see at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh?h=perf-tools-next
> 
> There was the whole patchset that contained the failing probe test case.
> The patchset was applied and merged upstream so there won't be a v3 for 
> the failing test case, instead we will send a fix patch resolving the 
> mentioned issue. Hopefully this explains the confusion that I think
> happened.

Ok, thanks for the explanation.  I see it's merged already and I'm
waiting for the fix only.

> 
> We will send the next patchset soon containing also the patch fixing
> the probe issue with bad dwarf so if there will still be some confusion 
> that should resolve that.
 
It'd be nice if you can send the fix first separately.  As the whole
patchset might take some time for review, I want to fix the existing
problem ASAP.

Thanks,
Namhyung

