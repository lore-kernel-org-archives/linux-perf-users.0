Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1261DA0ED;
	Tue, 26 Nov 2024 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641417; cv=none; b=YmBIi9nJPb+aDlKp7h41K6ghPXnhbsFbpVOgHTWYjCx123D/iSQyQxAY7JrlH84B4R5zyRSJ0F8kyMAfgto5U7a0jQRhgadIL3AjxWKzaLkEF8DwoWBpH4dDvD5aE+Fe36dHaLknlr2Z9R8ddaBq8KZtVqJIeArl00fA1aNcAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641417; c=relaxed/simple;
	bh=BoFX0DFtyDhgk1jysACLSTIFLU8ZzZ2tVfhovrAqrK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFpTj/KeD91C43WximcEUG824oRBYz83LlVibaNA7UO8TyAcTihPxmhqC+SjPHO28J9aW3GnesGONFmFhae/4o7YEwTnQi9l+nUJTsVFLvc3nHcDteiu6zSiHr9nmHhDWV0YKSor62VCoulVGEANR1t8GEvjwT7wiUMiqJ2ZYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpRy+KKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpRy+KKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73616C4CED0;
	Tue, 26 Nov 2024 17:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641417;
	bh=BoFX0DFtyDhgk1jysACLSTIFLU8ZzZ2tVfhovrAqrK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpRy+KKoH57jcDK9OWxgUTm7iqspxILcnn7ZMW2GOsVOhQRuVzVm5hpUA5oi88LGv
	 9sKoBZr6xXI90G1YQRku4DtE42qmJGeECJr55ALsIa0QXfVumHtwIcjbDmmDMhp1AE
	 +P13OHuulF6MV/uU+16u8kCA/7BynarB32nwJAPm6XfoW/STSpTw2SNtTBc53g5YP/
	 ak9ZTBOy1DKRW2J5/kGkoaXtpuGL9+EXct9oKweQqcfWHDMyTecwL/qiNpDBYls5gC
	 ZuYBgR5InrN5hAr1v/BmFBJ8lub4sbFjByscr6Jn9pk1+wMQx4Dx0pknxBejIp7GAC
	 Q4KKiPM5AOmMg==
Date: Tue, 26 Nov 2024 14:16:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V15 0/7] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
Message-ID: <Z0YChjympWOZeu1e@x1>
References: <20241114101711.34987-1-adrian.hunter@intel.com>
 <9bb112f8-0af1-4517-a4b8-bd2edacce07c@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bb112f8-0af1-4517-a4b8-bd2edacce07c@intel.com>

On Tue, Nov 26, 2024 at 02:59:02PM +0200, Adrian Hunter wrote:
> On 14/11/24 12:17, Adrian Hunter wrote:
> > Hi
> > 
> > Note for V15:
> > 	Same as V14 but without kernel patches because they have been
> > 	applied, and updated "missing_features" patch for the new way
> > 	of detecting missing features.
> 
> Still apply

So the kernel part is in, I'll go over this after getting a machine with
a kernel with those features so that I can test it all together.

- Arnaldo
 
> > Hardware traces, such as instruction traces, can produce a vast amount of
> > trace data, so being able to reduce tracing to more specific circumstances
> > can be useful.
> > 
> > The ability to pause or resume tracing when another event happens, can do
> > that.
> > 
> > These patches add such a facilty and show how it would work for Intel
> > Processor Trace.
> > 
> > Maintainers of other AUX area tracing implementations are requested to
> > consider if this is something they might employ and then whether or not
> > the ABI would work for them.  Note, thank you to James Clark (ARM) for
> > evaluating the API for Coresight.  Suzuki K Poulose (ARM) also responded
> > positively to the RFC.
> > 
> > Changes to perf tools are now (since V4) fleshed out.
> > 
> > Please note, Intel® Architecture Instruction Set Extensions and Future
> > Features Programming Reference March 2024 319433-052, currently:
> > 
> > 	https://cdrdv2.intel.com/v1/dl/getContent/671368
> > 
> > introduces hardware pause / resume for Intel PT in a feature named
> > Intel PT Trigger Tracing.
> > 
> > For that more fields in perf_event_attr will be necessary.  The main
> > differences are:
> > 	- it can be applied not just to overflows, but optionally to
> > 	every event
> > 	- a packet is emitted into the trace, optionally with IP
> > 	information
> > 	- no PMI
> > 	- works with PMC and DR (breakpoint) events only
> > 
> > Here are the proposed additions to perf_event_attr, please comment:
> > 
> > diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> > index 0c557f0a17b3..05dcc43f11bb 100644
> > --- a/tools/include/uapi/linux/perf_event.h
> > +++ b/tools/include/uapi/linux/perf_event.h
> > @@ -369,6 +369,22 @@ enum perf_event_read_format {
> >  	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
> >  };
> >  
> > +enum {
> > +	PERF_AUX_ACTION_START_PAUSED		=   1U << 0,
> > +	PERF_AUX_ACTION_PAUSE			=   1U << 1,
> > +	PERF_AUX_ACTION_RESUME			=   1U << 2,
> > +	PERF_AUX_ACTION_EMIT			=   1U << 3,
> > +	PERF_AUX_ACTION_NR			= 0x1f << 4,
> > +	PERF_AUX_ACTION_NO_IP			=   1U << 9,
> > +	PERF_AUX_ACTION_PAUSE_ON_EVT		=   1U << 10,
> > +	PERF_AUX_ACTION_RESUME_ON_EVT		=   1U << 11,
> > +	PERF_AUX_ACTION_EMIT_ON_EVT		=   1U << 12,
> > +	PERF_AUX_ACTION_NR_ON_EVT		= 0x1f << 13,
> > +	PERF_AUX_ACTION_NO_IP_ON_EVT		=   1U << 18,
> > +	PERF_AUX_ACTION_MASK			= ~PERF_AUX_ACTION_START_PAUSED,
> > +	PERF_AUX_PAUSE_RESUME_MASK		= PERF_AUX_ACTION_PAUSE | PERF_AUX_ACTION_RESUME,
> > +};
> > +
> >  #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
> >  #define PERF_ATTR_SIZE_VER1	72	/* add: config2 */
> >  #define PERF_ATTR_SIZE_VER2	80	/* add: branch_sample_type */
> > @@ -515,10 +531,19 @@ struct perf_event_attr {
> >  	union {
> >  		__u32	aux_action;
> >  		struct {
> > -			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
> > -				aux_pause        :  1, /* on overflow, pause AUX area tracing */
> > -				aux_resume       :  1, /* on overflow, resume AUX area tracing */
> > -				__reserved_3     : 29;
> > +			__u32	aux_start_paused  :  1, /* start AUX area tracing paused */
> > +				aux_pause         :  1, /* on overflow, pause AUX area tracing */
> > +				aux_resume        :  1, /* on overflow, resume AUX area tracing */
> > +				aux_emit          :  1, /* generate AUX records instead of events */
> > +				aux_nr            :  5, /* AUX area tracing reference number */
> > +				aux_no_ip         :  1, /* suppress IP in AUX records */
> > +				/* Following apply to event occurrence not overflows */
> > +				aux_pause_on_evt  :  1, /* on event, pause AUX area tracing */
> > +				aux_resume_on_evt :  1, /* on event, resume AUX area tracing */
> > +				aux_emit_on_evt   :  1, /* generate AUX records instead of events */
> > +				aux_nr_on_evt     :  5, /* AUX area tracing reference number */
> > +				aux_no_ip_on_evt  :  1, /* suppress IP in AUX records */
> > +				__reserved_3      : 13;
> >  		};
> >  	};
> > 
> > 
> > Changes in V15:
> >       perf/x86/intel/pt: Fix buffer full but size is 0 case
> >       perf/core: Add aux_pause, aux_resume, aux_start_paused
> >       perf/x86/intel/pt: Add support for pause / resume
> >       perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
> > 	Dropped kernel patches because they have been applied
> > 
> >       perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
> > 	Re-base on new API probe method of missing feature detection
> > 	and add probe for aux_action.
> > 
> > Changes in V14:
> >       Dropped KVM patches
> > 
> >       perf/x86/intel/pt: Add support for pause / resume
> > 	Set pt->handle_nmi after configuration is completed instead of during
> > 
> > Changes in V13:
> >       perf/core: Add aux_pause, aux_resume, aux_start_paused
> > 	Do aux_resume at the end of __perf_event_overflow() so as to trace
> > 	less of perf itself
> > 
> >       perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
> > 	Add error message also in EOPNOTSUPP case (Leo)
> > 
> > Changes in V12:
> > 	Add previously sent patch "perf/x86/intel/pt: Fix buffer full
> > 	but size is 0 case"
> > 
> > 	Add previously sent patch set "KVM: x86: Fix Intel PT Host/Guest
> > 	mode when host tracing"
> > 
> > 	Rebase on current tip plus patch set "KVM: x86: Fix Intel PT Host/Guest
> > 	mode when host tracing"
> > 
> > Changes in V11:
> >       perf/core: Add aux_pause, aux_resume, aux_start_paused
> > 	Make assignment to event->hw.aux_paused conditional on
> > 	(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE).
> > 
> >       perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
> > 	Remove definition of has_aux_action() because it has
> > 	already been added as an inline function.
> > 
> >       perf/x86/intel/pt: Fix sampling synchronization
> >       perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
> >       perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
> > 	Dropped because they have already been applied
> > 
> > Changes in V10:
> >       perf/core: Add aux_pause, aux_resume, aux_start_paused
> > 	Move aux_paused into a union within struct hw_perf_event.
> > 	Additional comment wrt PERF_EF_PAUSE/PERF_EF_RESUME.
> > 	Factor out has_aux_action() as an inline function.
> > 	Use scoped_guard for irqsave.
> > 	Move calls of perf_event_aux_pause() from __perf_event_output()
> > 	to __perf_event_overflow().
> > 
> > Changes in V9:
> >       perf/x86/intel/pt: Fix sampling synchronization
> > 	New patch
> > 
> >       perf/core: Add aux_pause, aux_resume, aux_start_paused
> > 	Move aux_paused to struct hw_perf_event
> > 
> >       perf/x86/intel/pt: Add support for pause / resume
> > 	Add more comments and barriers for resume_allowed and
> > 	pause_allowed
> > 	Always use WRITE_ONCE with resume_allowed
> > 
> > 
> > Changes in V8:
> > 
> >       perf tools: Parse aux-action
> > 	Fix clang warning:
> > 	     util/auxtrace.c:821:7: error: missing field 'aux_action' initializer [-Werror,-Wmissing-field-initializers]
> > 	     821 |         {NULL},
> > 	         |              ^
> > 
> > Changes in V7:
> > 
> > 	Add Andi's Reviewed-by for patches 2-12
> > 	Re-base
> > 
> > Changes in V6:
> > 
> >       perf/core: Add aux_pause, aux_resume, aux_start_paused
> > 	Removed READ/WRITE_ONCE from __perf_event_aux_pause()
> > 	Expanded comment about guarding against NMI
> > 
> > Changes in V5:
> > 
> >     perf/core: Add aux_pause, aux_resume, aux_start_paused
> > 	Added James' Ack
> > 
> >     perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
> > 	New patch
> > 
> >     perf tools
> > 	Added Ian's Ack
> > 
> > Changes in V4:
> > 
> >     perf/core: Add aux_pause, aux_resume, aux_start_paused
> > 	Rename aux_output_cfg -> aux_action
> > 	Reorder aux_action bits from:
> > 		aux_pause, aux_resume, aux_start_paused
> > 	to:
> > 		aux_start_paused, aux_pause, aux_resume
> > 	Fix aux_action bits __u64 -> __u32
> > 
> >     coresight: Have a stab at support for pause / resume
> > 	Dropped
> > 
> >     perf tools
> > 	All new patches
> > 
> > Changes in RFC V3:
> > 
> >     coresight: Have a stab at support for pause / resume
> > 	'mode' -> 'flags' so it at least compiles
> > 
> > Changes in RFC V2:
> > 
> > 	Use ->stop() / ->start() instead of ->pause_resume()
> > 	Move aux_start_paused bit into aux_output_cfg
> > 	Tighten up when Intel PT pause / resume is allowed
> > 	Add an example of how it might work for CoreSight
> > 
> > 
> > Adrian Hunter (7):
> >       perf tools: Add aux_start_paused, aux_pause and aux_resume
> >       perf tools: Add aux-action config term
> >       perf tools: Parse aux-action
> >       perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
> >       perf intel-pt: Improve man page format
> >       perf intel-pt: Add documentation for pause / resume
> >       perf intel-pt: Add a test for pause / resume
> > 
> >  tools/include/uapi/linux/perf_event.h      |  11 +-
> >  tools/perf/Documentation/perf-intel-pt.txt | 596 ++++++++++++++++++-----------
> >  tools/perf/Documentation/perf-record.txt   |   4 +
> >  tools/perf/builtin-record.c                |   4 +-
> >  tools/perf/tests/shell/test_intel_pt.sh    |  28 ++
> >  tools/perf/util/auxtrace.c                 |  67 +++-
> >  tools/perf/util/auxtrace.h                 |   6 +-
> >  tools/perf/util/evsel.c                    | 101 ++++-
> >  tools/perf/util/evsel.h                    |   1 +
> >  tools/perf/util/evsel_config.h             |   1 +
> >  tools/perf/util/parse-events.c             |  10 +
> >  tools/perf/util/parse-events.h             |   1 +
> >  tools/perf/util/parse-events.l             |   1 +
> >  tools/perf/util/perf_event_attr_fprintf.c  |   3 +
> >  tools/perf/util/pmu.c                      |   1 +
> >  15 files changed, 594 insertions(+), 241 deletions(-)
> > 
> > 
> > Regards
> > Adrian
> 
