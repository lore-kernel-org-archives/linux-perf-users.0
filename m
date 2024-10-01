Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253EE19ABC3;
	Tue,  1 Oct 2024 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818355; cv=none; b=FZs9qYyYmyp8lGmdbkH+nf0yEyXiZlWePrlfygLH/n68NUgAFDJ6Qug/3GXWI/ehXRhPpLUeRnZVZ9QJjOl/21DyzfOOr+06+hC+kM9qxWX1qkwaZXN3V5O/aClTbWFHi6CvNJlo9IihSrAN+ExyKmMmsb6dKC9E1p8eRJqlKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818355; c=relaxed/simple;
	bh=xc+6Yrc0mFSiTg575g6Zo4OcSmJrOJHuuLsO/V5dxKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/v987InvpcBj8dGcfOo3B3K04/qFi2PJT0QgPnz5p38sDLbGY3y27YOsS3I4OO6iIz35MXNsPJJH5AKzOKU0LyNgQEyD2DPahcdHJtGL8QDyaT7drnLb/K+jEoYyUPEmDkQXXFIl8CA5g+uRM280wsPe2lg0q6S77oHIVc/sZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDrNieZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDrNieZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346D3C4CEC6;
	Tue,  1 Oct 2024 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727818354;
	bh=xc+6Yrc0mFSiTg575g6Zo4OcSmJrOJHuuLsO/V5dxKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDrNieZyF9cw4shb4R6E527lIRthcGW/dK7jX/CRuWOSvekUfyVqKAdNrvX9nkYkh
	 L4hsz336vETwUZt/OsOLWd8sRU+JnzIKqVjnLcbBpCxFnVFtzxwLkz+X46d8qj2LoT
	 srsnxVKRgPPI6LwujGsrUZzkvBnizphCOl95lR7gwQN3SxPxJjL3TFLLj12P6EyvXa
	 LNM2Zorr9q+EFkO4UZ6XyO7Vc/yJvJ9hsf86HiJ0sdmRER/OfTXxDlSQy5pkAR1qY5
	 lxiEdjlV4K1tUC4hLR1r2wrwS9dVnrYG61iJPiimqVkUcqsA2q/tOi1G8c7jaOm7RK
	 Dkd7CCIYdq5Fg==
Date: Tue, 1 Oct 2024 14:32:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 5/8] perf tools: Detect missing kernel features properly
Message-ID: <ZvxqcEIVELw9Uets@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-6-namhyung@kernel.org>
 <CAP-5=fVrptOSOK+sBo0rHR1QWQ0i1WigMaFRy=So-HATKr=R9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVrptOSOK+sBo0rHR1QWQ0i1WigMaFRy=So-HATKr=R9A@mail.gmail.com>

On Tue, Oct 01, 2024 at 10:53:02AM -0700, Ian Rogers wrote:
> On Mon, Sep 30, 2024 at 5:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The evsel__detect_missing_features() is to check if the attributes of
> > the evsel is supported or not.  But it checks the attribute based on the
> > given evsel, it might miss something if the attr doesn't have the bit or
> > give incorrect results if the event is special.
> >
> > Also it maintains the order of the feature that was added to the kernel
> > which means it can assume older features should be supported once it
> > detects the current feature is working.  To minimized the confusion and
> > to accurately check the kernel features, I think it's better to use a
> > software event and go through all the features at once.
> >
> > Also make the function static since it's only used in evsel.c.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/evsel.c | 345 +++++++++++++++++++++++++++++-----------
> >  tools/perf/util/evsel.h |   1 -
> >  2 files changed, 249 insertions(+), 97 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index f202d28147d62a44..32e30c293d0c6198 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/zalloc.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/resource.h>
> > +#include <sys/syscall.h>
> >  #include <sys/types.h>
> >  #include <dirent.h>
> >  #include <stdlib.h>
> > @@ -2150,120 +2151,272 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> >         return err;
> >  }
> >
> > -bool evsel__detect_missing_features(struct evsel *evsel)
> > +static bool has_attr_feature(struct perf_event_attr *attr, unsigned long flags)
> >  {
> > +       int fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
> > +                        /*group_fd=*/-1, flags);
> > +       close(fd);
> > +
> > +       if (fd < 0) {
> > +               attr->exclude_kernel = 1;
> > +
> > +               fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
> > +                            /*group_fd=*/-1, flags);
> > +               close(fd);
> > +       }
> > +
> > +       if (fd < 0) {
> > +               attr->exclude_hv = 1;
> > +
> > +               fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
> > +                            /*group_fd=*/-1, flags);
> > +               close(fd);
> > +       }
> > +
> > +       if (fd < 0) {
> > +               attr->exclude_guest = 1;
> > +
> > +               fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
> > +                            /*group_fd=*/-1, flags);
> > +               close(fd);
> > +       }
> > +
> > +       attr->exclude_kernel = 0;
> > +       attr->exclude_guest = 0;
> > +       attr->exclude_hv = 0;
> > +
> > +       return fd >= 0;
> > +}
> > +
> > +static void evsel__detect_missing_brstack_features(struct evsel *evsel)
> 
> In the future could other PMU specific unsupported features be added
> not just brstack? Perhaps evsel__detect_missing_pmu_features would
> better capture that.

Yep, sounds reasonable.  I think we can add that if we have another
thing to check.

> 
> > +{
> > +       static bool detection_done = false;
> > +       struct perf_event_attr attr = {
> > +               .type = evsel->core.attr.type,
> > +               .config = evsel->core.attr.config,
> > +               .disabled = 1,
> > +               .sample_type = PERF_SAMPLE_BRANCH_STACK,
> > +               .sample_period = 1000,
> > +       };
> > +       int old_errno;
> > +
> > +       if (detection_done)
> > +               return;
> > +
> > +       old_errno = errno;
> > +
> >         /*
> >          * Must probe features in the order they were added to the
> > -        * perf_event_attr interface.
> > +        * perf_event_attr interface.  These are PMU specific limitation
> > +        * so we can detect with the given hardware event and stop on the
> > +        * first one succeeded.
> >          */
> > -       if (!perf_missing_features.branch_counters &&
> > -           (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
> > -               perf_missing_features.branch_counters = true;
> > -               pr_debug2("switching off branch counters support\n");
> > -               return true;
> > -       } else if (!perf_missing_features.read_lost &&
> > -           (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
> > -               perf_missing_features.read_lost = true;
> > -               pr_debug2("switching off PERF_FORMAT_LOST support\n");
> > +
> > +       /* Please add new feature detection here. */
> > +
> > +       attr.branch_sample_type = PERF_SAMPLE_BRANCH_COUNTERS;
> > +       if (has_attr_feature(&attr, /*flags=*/0))
> > +               goto found;
> > +       perf_missing_features.branch_counters = true;
> 
> It feels like these global variables should be part of the PMU state.
> There is already perf_pmu.missing_features.

You're right.  But I think this is kinda global feature unless we have
different PMUs that provide different branch sampling capability.  It's
just the feature test requires a specific PMU and event.  But it'd be
better putting this into struct perf_pmu later.

Kan, can you confirm if Intel hybrid systems have the same branch stack
sampling capabilities on both cores?

Thanks,
Namhyung
