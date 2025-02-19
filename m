Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04386255E33;
	Wed, 19 Feb 2025 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004066; cv=none; b=jidpNVO9l7acKGFBYCle/uIrHmfttGe9kEiGyE1x5OIs1ZWhjVi/o01MwiUTpXYxTVkn8QXCFYUVfBmu2kCBFIs9mjgJEfoPv1Iz1Hx7f9mfIUf02DRfQI8co9ri91kzNN0KJsXBX0mmeNTB3zLEKM2dmBpDFNf43mottScuiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004066; c=relaxed/simple;
	bh=pxp1S3DrfSjlSFcTpmmei+K9bf/p1MkqUCDf1l9DrKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asa+eiQiPOkFlxjXz0j1WKbuXvG/G8LJeU5BLIZnbho+B8BxpsTzXzqqfCxD9xaE3u/hxTuQNKgYqXmLenJMrc2B36aKE33pxyfqfHjQiPLRgQG3GhHLEilyWqWaLjv6YfjsSfrWIVSvJxsjqwjjPmpM8JaGL2ofNmlilczmWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9fJ/C8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9fJ/C8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C3FC4CED1;
	Wed, 19 Feb 2025 22:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004065;
	bh=pxp1S3DrfSjlSFcTpmmei+K9bf/p1MkqUCDf1l9DrKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9fJ/C8h4dFds9YN9u/wZk9rHf7MK+AAdinHlBP8Fz2k5VLwcB9OURtkKOVmymaVw
	 6p4/nyPWmyt8axtX1u9yndpqN8kN0RkOk1CsmOOjfUZH6dsY7Kb5T091dwmgLgFUgl
	 2scaaSvCHrVMTlJlmJdURBVzXLei1kjRuwnuC+fHlvJIihKI2mvoK0TsIb++Ay7r5U
	 K7D1z4P8oWNqXH+DdWjbqLfx+pZje914HdOv52g4iJYmKIRQScFMvBuaXlDoeIvfT8
	 /2IVSsNS7hku6T02ubVx5Zhutoc71JK6S/Te6Od9ur7Ww2iVPEMNRDGYmvzF/FnBkQ
	 gXDWCtYjbIDlQ==
Date: Wed, 19 Feb 2025 14:27:43 -0800
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
Message-ID: <Z7Za30xyVUQWI1tV@google.com>
References: <20250109175401.161340-1-irogers@google.com>
 <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
 <CAP-5=fWZAk7XqtL+=CanefkuFxhDsJ22+-uHkrxXi4g8123oew@mail.gmail.com>
 <Z7ZD5phOOCbKggrn@google.com>
 <CAP-5=fXeZM7iWNQq0ar1HmAwWrH4HAHqD3F=ueB=jaw-2UMn_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXeZM7iWNQq0ar1HmAwWrH4HAHqD3F=ueB=jaw-2UMn_w@mail.gmail.com>

On Wed, Feb 19, 2025 at 02:11:43PM -0800, Ian Rogers wrote:
> On Wed, Feb 19, 2025 at 12:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Feb 19, 2025 at 11:02:40AM -0800, Ian Rogers wrote:
> > > On Mon, Feb 10, 2025 at 11:23 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Thu, Jan 9, 2025 at 9:54 AM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PMUs
> > > > > before parsing") names (generally event names) excluded hyphen (minus)
> > > > > symbols as the formation of legacy names with hyphens was handled in
> > > > > the yacc code. That commit allowed hyphens supposedly making
> > > > > name_minus unnecessary. However, changing name_minus to name has
> > > > > issues in the term config tokens as then name ends up having priority
> > > > > over numbers and name allows matching numbers since commit
> > > > > 5ceb57990bf4 ("perf parse: Allow tracepoint names to start with digits
> > > > > "). It is also permissable for a name to match with a colon (':') in
> > > > > it when its in a config term list. To address this rename name_minus
> > > > > to term_name, make the pattern match name's except for the colon, add
> > > > > number matching into the config term region with a higher priority
> > > > > than name matching. This addresses an inconsistency and allows greater
> > > > > matching for names inside of term lists, for example, they may start
> > > > > with a number.
> > > > >
> > > > > Rename name_tag to quoted_name and update comments and helper
> > > > > functions to avoid str detecting quoted strings which was already done
> > > > > by the lexer.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > Ping. This patch addresses name parsing inconsistencies, in particular
> > > > events may start with a number without a PMU, but not with. It also
> > > > aims to give better names to patterns than name_minus and name_tag
> > > > (with term_name and quoted_name respectively) that have drifted from
> > > > their original meaning and become to me less than intention revealing.
> > >
> > > Ping.
> >
> > Sorry for the delay.  Can you please give an example for better
> > understanding if there's a change in the behavior?
> 
> The example in:
> https://lore.kernel.org/r/20240510-perf_digit-v4-3-db1553f3233b@codewreck.org
> is `perf trace -e '9p:*'` which allows the number to start a
> tracepoint name, but what is true for tracepoint names is also true
> for event names. I lack the tracepoint but the patch here is making
> that work if the event/tracepoint is specified with a PMU, so:
> 
> Before the input is just seen as broken:
> ```
> $ perf stat -e 'tracepoint/9p:9p/' true
> event syntax error: 'tracepoint/9p:9p/'
>                                \___ Unrecognized input
> Run 'perf list' for a list of valid events
> 
> Usage: perf stat [<options>] [<command>]
> 
>    -e, --event <event>   event selector. use 'perf list' to list
> available events
> ```
> 
> After the input fails because the event wasn't found:
> ```
> $ perf stat -e 'tracepoint/9p:9p/' true
> event syntax error: 'tracepoint/9p:9p/'
>                     \___ Bad event or PMU
> 
> Unable to find PMU or event on a PMU of 'tracepoint'
> 
> event syntax error: 'tracepoint/9p:9p/'
>                                \___ unknown term '9p:9p' for pmu 'tracepoint'
> 
> valid terms: config,config1,config2,config3,name,period,percore,metric-id
> 
> event syntax error: 'tracepoint/9p:9p/'
>                                \___ unknown term '9p:9p' for pmu 'tracepoint'
> 
> valid terms: config,config1,config2,config3,name,period,percore,metric-id
> Run 'perf list' for a list of valid events
> 
> Usage: perf stat [<options>] [<command>]
> 
>    -e, --event <event>   event selector. use 'perf list' to list
> available events
> ```
> 
> But the patch is just about making the name term more consistent and
> cleaner, the weirdness above wasn't its main point, I want the code to
> be easy to read and understand.

Ok, so I guess there's no behavior change from the users perspective in
this patchset.  Do you plan to add support for the tracepoint name in
the config term (like tracepoint/9p:9p/) later?

Thanks,
Namhyung

