Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286B1DE8B4;
	Mon, 28 Oct 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131708; cv=none; b=JoV0fvgMSKpBqM4zYJE+uqmH7Ktd6tUWXZCTdC2HDLahe2DQrnHdYWDpG2G8BtnhAJ43+rpuCE0BvHoFvocISlTnVE8j/Jiau6L03kMGjTO8vebRV/b1jh0l+ykgMQB49Jn5G5zBh2Jw1sci9rQN5kYguNtEoiwuSrSuY9TjOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131708; c=relaxed/simple;
	bh=QCl5kdGtws/gZEzPILUveMBgYMgEM6pFSQgc8jF1ex8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9rTaCAoc4RSFmnB9lWJQYOZ8Jy0HDWEJxTCgI+L4nGSMcR1M8q2q12YxU1VFTI6hO0vOy4YRBBOs8HHnVx0o2WEq3QeGHv8NSOA8SNnlC5mdt0h+SPfvPxlLRp4fABPXqiD4ET4+iv47CNage+mgNliSxMHP438xVinadnnMOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLTDTCDT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLTDTCDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43FCC4CEC3;
	Mon, 28 Oct 2024 16:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730131708;
	bh=QCl5kdGtws/gZEzPILUveMBgYMgEM6pFSQgc8jF1ex8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLTDTCDTfp1wfbTG1RD4IoUOpGEz7Pvg8zU0OsKGxnoxCo6EFMb06hKcDrkCTVKFf
	 WI7s6xIC28tQiKocBr595ncOCPm3LzHHD1hwwdLpGjVxChSMzxJIcjZ3xHl+GsRgdE
	 8x5o3t3MvnDE0QaFOvNRHIOOxhiXC2kRED2nvTED4Mas3UKYkpgg2JJWyvaZLP/DD4
	 HD5+lnd596RjdJg+LiiR86+SbZqeZzvmHhk/lZBR71OBf4t07BgtS2oCjb0qjn34cQ
	 d7bYLYZ2DPweIegank0CHenREu0UM4vpwoPEDa7kQ5HtuU76dzHQuWVlNRGYvkzzhS
	 EvlgguRh+0f8w==
Date: Mon, 28 Oct 2024 13:08:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf cap: Add __NR_capget to arch/x86 unistd
Message-ID: <Zx-2-GhdII3ZIizi@x1>
References: <20241026055448.312247-1-irogers@google.com>
 <CAP-5=fXLL1dB4MEfe7Z+fhp_RzC9DV91gBLBHjjywW-_RXmM-Q@mail.gmail.com>
 <c19ca53b-b0e6-4763-8691-09ee4a095492@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c19ca53b-b0e6-4763-8691-09ee4a095492@intel.com>

On Mon, Oct 28, 2024 at 09:25:36AM +0200, Adrian Hunter wrote:
> On 26/10/24 09:00, Ian Rogers wrote:
> > On Fri, Oct 25, 2024 at 10:54 PM Ian Rogers <irogers@google.com> wrote:
> >>
> >> As there are duplicated kernel headers in tools/include libc can pick
> >> up the wrong definitions. This was causing the wrong system call for
> >> capget in perf.
> >>
> >> Closes: https://lore.kernel.org/lkml/cc7d6bdf-1aeb-4179-9029-4baf50b59342@intel.com/
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> > 
> > Forgot:
> > Fixes: e25ebda78e23 ("perf cap: Tidy up and improve capability testing")
> 
> Works for me, thank you!
> 
> Tested-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, I also added this:

Reported-by: Adrian Hunter <adrian.hunter@intel.com>

Applied to perf-tools, for v6.12-rc.

- Arnaldo
 
> > 
> > Thanks,
> > Ian
> > 
> >> ---
> >>  tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
> >>  tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
> >>  tools/perf/util/cap.c                       | 10 +++-------
> >>  3 files changed, 9 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
> >> index 9de35df1afc3..63182a023e9d 100644
> >> --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
> >> +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
> >> @@ -11,6 +11,9 @@
> >>  #ifndef __NR_getpgid
> >>  #define __NR_getpgid 132
> >>  #endif
> >> +#ifndef __NR_capget
> >> +#define __NR_capget 184
> >> +#endif
> >>  #ifndef __NR_gettid
> >>  #define __NR_gettid 224
> >>  #endif
> >> diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
> >> index d0f2043d7132..77311e8d1b5d 100644
> >> --- a/tools/arch/x86/include/uapi/asm/unistd_64.h
> >> +++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
> >> @@ -11,6 +11,9 @@
> >>  #ifndef __NR_getpgid
> >>  #define __NR_getpgid 121
> >>  #endif
> >> +#ifndef __NR_capget
> >> +#define __NR_capget 125
> >> +#endif
> >>  #ifndef __NR_gettid
> >>  #define __NR_gettid 186
> >>  #endif
> >> diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> >> index 7574a67651bc..69d9a2bcd40b 100644
> >> --- a/tools/perf/util/cap.c
> >> +++ b/tools/perf/util/cap.c
> >> @@ -7,13 +7,9 @@
> >>  #include "debug.h"
> >>  #include <errno.h>
> >>  #include <string.h>
> >> -#include <unistd.h>
> >>  #include <linux/capability.h>
> >>  #include <sys/syscall.h>
> >> -
> >> -#ifndef SYS_capget
> >> -#define SYS_capget 90
> >> -#endif
> >> +#include <unistd.h>
> >>
> >>  #define MAX_LINUX_CAPABILITY_U32S _LINUX_CAPABILITY_U32S_3
> >>
> >> @@ -21,9 +17,9 @@ bool perf_cap__capable(int cap, bool *used_root)
> >>  {
> >>         struct __user_cap_header_struct header = {
> >>                 .version = _LINUX_CAPABILITY_VERSION_3,
> >> -               .pid = getpid(),
> >> +               .pid = 0,
> >>         };
> >> -       struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
> >> +       struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S] = {};
> >>         __u32 cap_val;
> >>
> >>         *used_root = false;
> >> --
> >> 2.47.0.163.g1226f6d8fa-goog
> >>
