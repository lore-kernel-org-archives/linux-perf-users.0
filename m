Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5331FDA89;
	Wed,  5 Mar 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168205; cv=none; b=jwt5zbbgbshNyFNCUOc5n4+ueAoUEGS2L87w/hNtucJIXC3T+gY9YOve3aFM5/as55N6phwxtcVmKg8PPjRTlOT/pH+zRjLSCf4p00/F7h97wppfxydw7e1C54rS+Q2vvChCbtUiumbCDOV+Oe8BvvQIvgtAw9KknDcQHl1f8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168205; c=relaxed/simple;
	bh=9XCwGkO1slE9cNaXGcMSpm5vtcrGZCcbvX/iUzJ0eIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnGMWH7+aXUDJobSe81qQsSWi1+d7jaar05Q+6vuuawJ3bE7V5vC8aLIL99pz0DCsfHjFQp75mSLJ47fIyTcU8ANHmEgeN3WtqkYJKn+2/l/RKJ5sgfootHjPfsO8tHmKJrSY5QVq7xr5l4lUai9XrqW2MBqGWjsQXhrVH2xVxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59B6BFEC;
	Wed,  5 Mar 2025 01:50:16 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FC123F673;
	Wed,  5 Mar 2025 01:50:02 -0800 (PST)
Date: Wed, 5 Mar 2025 09:49:58 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf list: Collapse similar events across PMUs
Message-ID: <20250305094958.GE13418@e132581.arm.com>
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
 <20250304-james-perf-hybrid-list-v1-2-a363ffac283c@linaro.org>
 <20250305093545.GD13418@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305093545.GD13418@e132581.arm.com>

On Wed, Mar 05, 2025 at 09:35:45AM +0000, Leo Yan wrote:
> On Tue, Mar 04, 2025 at 01:49:14PM +0000, James Clark wrote:
> > Instead of showing multiple line items with the same event name and
> > description, show a single line and concatenate all PMUs that this
> > event can belong to.
> > 
> > Don't do it for json output. Machine readable output doesn't need to be
> > minimized, and changing the "Unit" field to a list type would break
> > backwards compatibility.
> > 
> > Before:
> >  $ perf list -v
> >  ...
> >  br_indirect_spec
> >        [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53]
> >  br_indirect_spec
> >        [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a57]
> > 
> > After:
> > 
> >  $ perf list -v
> >  ...
> >  br_indirect_spec
> >        [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53,armv8_cortex_a57]
> 
> From my testing, based on the latest tmp.perf-tools-next branch, I
> need to remove the option '-v'.  Otherwise, the '-v' option will
> enable long event descriptions, in this case, it does _not_ print Unit
> strings at all (see default_print_event() in builtin-list.c).

Ah, actually I worked on the Linux master branch.  After switched to
tmp.perf-tools-next branch, it works pretty well.

  perf list -v 2>&1 | grep br_mis_pred_retired -A 2
  ...
    br_mis_pred_retired
           [Instruction architecturally executed,mispredicted branch.
           Unit:
                   armv9_cortex_a510,armv9_cortex_a710]

Please ignore my previous comment.  The series looks good to me.

Thanks,
Leo

>   default_print_event()
>   {
>     ...
>     if (long_desc && print_state->long_desc) {
>             fprintf(fp, "%*s", 8, "[");
>             wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
>             fprintf(fp, "]\n");
>     } else if (desc && print_state->desc) {
>     ...
>   }
> 
> The command `perf list` would be sufficent.

> 
> Thanks,
> Leo
> 
