Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10C1E3DCF;
	Fri, 21 Feb 2025 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119683; cv=none; b=s3mkSHuaN5weKdJe88eGUG4nFhIbyMHmkL+FtX5+cK8TiCWPd6+PM044iQpYUcAWnncMliC/MGc6VC4lOcaAi+GE7VKS0vYoS05Uu5vF6eHRA/HdHKrAXiYzrT1JsoWRnL2agkKmAThDRJP8nI6cDfdQlxpZ3qIS44jJQ0iTPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119683; c=relaxed/simple;
	bh=vkgfE5ntMdEMiMS+9MkNPD8HkcY13i4p+PcL8NCRd4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnXTtLvBw/feNpaYzQWMN2x+A5/g7pOny/kq/L5+dk3C4eaGuZH1qY3+AIyi7In/ttEaecpBOWLhxlA7eg/VpCkC33rzOLw+jxmoZtRTUeS3mIbnxXz7SwZv+4ozA6aMcMu61ZwMtpXHzTKZvis4a3lErOSbzuf99E+X1JXqpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9e5BV4n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9e5BV4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A2C4CED6;
	Fri, 21 Feb 2025 06:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740119682;
	bh=vkgfE5ntMdEMiMS+9MkNPD8HkcY13i4p+PcL8NCRd4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9e5BV4n9cw+ahpkjVMtN2rx/ukPh6k77r5o04HLolhfdTaUXOfW87VRuDUd8TCYY
	 V3HeELtTQQ1XF/N1FWQ5I3tiCpTouLug7CzwjYRplejOurvAnSzc0Lo68U0IEnlkKf
	 790of9UGsIemSqgbTIbywEmJRPnJ3fHveGXPslv9XvD12Tr6L7JKyVE97zOeV/6io0
	 3eOnuzimytPdfv+PhsyHFzZmLVes9pX1YpBZGBreU/07vGR1VUgckHp5py5PzeF2lj
	 WT1LV37htMf3Z7W1HnIv6P1WLy4sRsxznfJ3/w+CMNqcZXrpSRInp81kDygX4wkvWD
	 +UdCpNRJeLZdg==
Date: Thu, 20 Feb 2025 22:34:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf parse-events: Tidy name token matching
Message-ID: <Z7gegNG5_pX2gQ9O@google.com>
References: <20250109175401.161340-1-irogers@google.com>
 <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
 <CAP-5=fWZAk7XqtL+=CanefkuFxhDsJ22+-uHkrxXi4g8123oew@mail.gmail.com>
 <Z7ZD5phOOCbKggrn@google.com>
 <CAP-5=fXeZM7iWNQq0ar1HmAwWrH4HAHqD3F=ueB=jaw-2UMn_w@mail.gmail.com>
 <Z7Za30xyVUQWI1tV@google.com>
 <CAP-5=fW=_4j43-mY3B02BavaOdTA469kUjEZaahTUA5S7Ma4sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW=_4j43-mY3B02BavaOdTA469kUjEZaahTUA5S7Ma4sQ@mail.gmail.com>

On Wed, Feb 19, 2025 at 02:43:10PM -0800, Ian Rogers wrote:
> On Wed, Feb 19, 2025 at 2:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Feb 19, 2025 at 02:11:43PM -0800, Ian Rogers wrote:
> > > On Wed, Feb 19, 2025 at 12:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Wed, Feb 19, 2025 at 11:02:40AM -0800, Ian Rogers wrote:
> > > > > On Mon, Feb 10, 2025 at 11:23 AM Ian Rogers <irogers@google.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 9, 2025 at 9:54 AM Ian Rogers <irogers@google.com> wrote:
> > > > > > >
> > > > > > > Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PMUs
> > > > > > > before parsing") names (generally event names) excluded hyphen (minus)
> > > > > > > symbols as the formation of legacy names with hyphens was handled in
> > > > > > > the yacc code. That commit allowed hyphens supposedly making
> > > > > > > name_minus unnecessary. However, changing name_minus to name has
> > > > > > > issues in the term config tokens as then name ends up having priority
> > > > > > > over numbers and name allows matching numbers since commit
> > > > > > > 5ceb57990bf4 ("perf parse: Allow tracepoint names to start with digits
> > > > > > > "). It is also permissable for a name to match with a colon (':') in
> > > > > > > it when its in a config term list. To address this rename name_minus
> > > > > > > to term_name, make the pattern match name's except for the colon, add
> > > > > > > number matching into the config term region with a higher priority
> > > > > > > than name matching. This addresses an inconsistency and allows greater
> > > > > > > matching for names inside of term lists, for example, they may start
> > > > > > > with a number.
> > > > > > >
> > > > > > > Rename name_tag to quoted_name and update comments and helper
> > > > > > > functions to avoid str detecting quoted strings which was already done
> > > > > > > by the lexer.
> > > > > > >
> > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > >
> > > > > > Ping. This patch addresses name parsing inconsistencies, in particular
> > > > > > events may start with a number without a PMU, but not with. It also
> > > > > > aims to give better names to patterns than name_minus and name_tag
> > > > > > (with term_name and quoted_name respectively) that have drifted from
> > > > > > their original meaning and become to me less than intention revealing.
> > > > >
> > > > > Ping.
> > > >
> > > > Sorry for the delay.  Can you please give an example for better
> > > > understanding if there's a change in the behavior?
> > >
> > > The example in:
> > > https://lore.kernel.org/r/20240510-perf_digit-v4-3-db1553f3233b@codewreck.org
> > > is `perf trace -e '9p:*'` which allows the number to start a
> > > tracepoint name, but what is true for tracepoint names is also true
> > > for event names. I lack the tracepoint but the patch here is making
> > > that work if the event/tracepoint is specified with a PMU, so:
> > >
> > > Before the input is just seen as broken:
> > > ```
> > > $ perf stat -e 'tracepoint/9p:9p/' true
> > > event syntax error: 'tracepoint/9p:9p/'
> > >                                \___ Unrecognized input
> > > Run 'perf list' for a list of valid events
> > >
> > > Usage: perf stat [<options>] [<command>]
> > >
> > >    -e, --event <event>   event selector. use 'perf list' to list
> > > available events
> > > ```
> > >
> > > After the input fails because the event wasn't found:
> > > ```
> > > $ perf stat -e 'tracepoint/9p:9p/' true
> > > event syntax error: 'tracepoint/9p:9p/'
> > >                     \___ Bad event or PMU
> > >
> > > Unable to find PMU or event on a PMU of 'tracepoint'
> > >
> > > event syntax error: 'tracepoint/9p:9p/'
> > >                                \___ unknown term '9p:9p' for pmu 'tracepoint'
> > >
> > > valid terms: config,config1,config2,config3,name,period,percore,metric-id
> > >
> > > event syntax error: 'tracepoint/9p:9p/'
> > >                                \___ unknown term '9p:9p' for pmu 'tracepoint'
> > >
> > > valid terms: config,config1,config2,config3,name,period,percore,metric-id
> > > Run 'perf list' for a list of valid events
> > >
> > > Usage: perf stat [<options>] [<command>]
> > >
> > >    -e, --event <event>   event selector. use 'perf list' to list
> > > available events
> > > ```
> > >
> > > But the patch is just about making the name term more consistent and
> > > cleaner, the weirdness above wasn't its main point, I want the code to
> > > be easy to read and understand.
> >
> > Ok, so I guess there's no behavior change from the users perspective in
> > this patchset.  Do you plan to add support for the tracepoint name in
> > the config term (like tracepoint/9p:9p/) later?
> 
> I think we treat tracepoints much as we do regular PMU perf events
> except in the encoding of the config. There is also a sysfs PMU:
> ```
> $ ls -al /sys/bus/event_source/devices/tracepoint
> /
> total 0
> drwxr-xr-x  3 root root    0 Feb 19 14:35 .
> drwxr-xr-x 78 root root    0 Feb 19 08:13 ..
> -rw-r--r--  1 root root 4096 Feb 19 14:34 perf_event_mux_interval_ms
> drwxr-xr-x  2 root root    0 Feb 19 08:13 power
> lrwxrwxrwx  1 root root    0 Feb 19 08:13 subsystem -> ../../bus/event_source
> -r--r--r--  1 root root 4096 Feb 19 10:53 type
> -rw-r--r--  1 root root 4096 Feb 19 08:13 uevent
> ```
> with the type reflecting the perf_event_attr type (3 aka
> PERF_TYPE_TRACEPOINT). So I think much like with the hwmon_pmu.c it
> makes sense to have a tracepoint_pmu.c and move logic like
> parse-events add_tracepoint in there:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n523
> in that case tracepoint/9p:9p/ would be a valid tracepoint event name.
> For now this code is cleaning up that if you had a 9p on say the cpu
> PMU, 9p would wildcard match with it but cpu/9p/ would be a parse
> error - as the event name currently doesn't allow a number to start it
> when it is part of the term list, what this patch fixes as part of
> tidying up the code.

Ok, the change itself looks fine to me.

Thanks,
Namhyung

