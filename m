Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109C496D5C;
	Wed, 16 Sep 2026 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567344; cv=none; b=Xk/OJTpOCbYWH8WHGT7HoBicmN5IClku0ENrg/350Z0uvp17BUL3zzL2vZcGUhQgG3d1ickkaB/Tv5cAI7Z3TOHF4M4m2WUZRjW1mF+TMk+jmXDizGt/5YXAzb5FntrMN5lrmRYppdzH8A/W4eTg+SKwPFMJOchB+SgDPQXoXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567344; c=relaxed/simple;
	bh=uqeg/tEdSna7bYqoVqFFTobsC2dLJUX55+mZkBOvi50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiJuxHJqIgda7go9l5kVL5y9eHJlVCPZN74k2aScP9yrUDggpLPzQvV3PTVIU6EDusl9X9/c7HTiy00ASKvxb2Oi89vDNJu+01Z4fxAcidEQG7Mm+nWoIugf9reumtbSPkkVNYIzC+01gzpji3Ajjx2sBVCS+aBUiS5RNPrdH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv6HBG3n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv6HBG3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641A61F000FF;
	Wed, 16 Sep 2026 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567343;
	bh=4wW3rLkY/v7pVduAC/PyGBiRUBE1iuH3F9MxNjBZjSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hv6HBG3nfOPvATJBQ9ydWtz5nlmItmz0weShgtLJqW0xPzNk4gDp4cC6mFIVLbioP
	 tE+WmcTanjJowy3wr01h8X/WmUhVm8dgnh5UFaX0IdU6RHafUp0NiT13HtIXINtp5Y
	 C1UKhAPf86vQucaR6C1+ibTxWb5v3UDY82hiebEAWe26mArczOmwxToms8N9vBwCCz
	 +XcfRSttYoYmbj8+GWzC+gDg7/x6wD75RrZUAKPOHujnL+je2j+vuue6hxPZUgv51q
	 YrwKF8uQlyI+F3edsXUJBdE2Gi3FId/ZgnZ6i7XNLs4OPbhF6EFaCd7dnYoKqvx3mj
	 Y1xmdCpzRb58w==
Date: Wed, 16 Sep 2026 11:02:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9] perf evsel: Find process with busy PMUs for EBUSY
Message-ID: <aqqha44XgcO_qQjp@x2>
References: <CAP-5=fVzG-2oJ1gN=s-W+2r58k8P4M-E3r8aP9zJ2aK_w-K9vQ@mail.gmail.com>
 <20260915204951.2935261-2-ctshao@google.com>
 <20260915205836.654691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915205836.654691F000FF@smtp.kernel.org>

On Tue, Sep 15, 2026 at 08:58:35PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] perf: missing POSIX header inclusions for libc functions
> --
> commit d5be35562f4cbefd7876eec8560215b17ee34b81
> Author: Chun-Tse Shao <ctshao@google.com>
 
> perf evsel: Find process with busy PMUs for EBUSY
 
> This commit parses fdinfo with PMU type, comparing it with the event which
> failed to open, and reports the processes causing EBUSY errors.
 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
 
> [ ... ]
 
> > +			/* Let's check the PMU type reserved by this process */
> > +			scnprintf(buf, sizeof(buf), "%s/fdinfo/%s",
> > +				  proc_entry->d_name, fd_entry->d_name);
> > +			fdinfo_fd = openat(dirfd(proc_dir), buf, O_RDONLY | O_NONBLOCK);
 
> [Severity: Low]
> Will this compile under musl libc without explicitly including <fcntl.h> for
> openat and O_NONBLOCK, as well as <unistd.h> for read and close?

Added while merging this patch...
 
> [Severity: Low]
> Does this require <stdio.h> to be explicitly included for sscanf to prevent
> musl libc build failures?

... ditto ...
 
> > +					   "perf_event_attr.type:\t%u",
> > +					   &perf_event_type) == 1) {
> > +					/* continue parsing */
> > +				} else if (sscanf(line,
> > +						  "pmu_type:\t%u",
> > +						  &pmu_type) == 1) {
> > +					/* continue parsing */
> > +				}
> > +				line = strtok_r(NULL, "\n", &saveptr);
> > +			}
 
> [ ... ]
 
> > @@ -4304,10 +4355,12 @@ static int dump_perf_event_processes(char *msg, size_t size)
> >  				for (ssize_t i = 0; i < cmdline_size; i++) {
> >  					if (buf[i] == '\0')
> >  						buf[i] = ' ';
> > +					else if (!isprint((unsigned char)buf[i]))
 
> [Severity: Low]
> Does this require <ctype.h> to be explicitly included for isprint to ensure
> compatibility with musl libc builds?

⬢ [acme@tb-five-perf perf-tools-next]$ grep ctype tools/perf/util/evs
evsel.c          evsel_config.h   evsel_fprintf.c  evsel_fprintf.h  evsel.h          evswitch.c       evswitch.h       
⬢ [acme@tb-five-perf perf-tools-next]$ grep ctype tools/perf/util/evsel.c 
#include <linux/ctype.h>
⬢ [acme@tb-five-perf perf-tools-next]$ grep -w isprint tools/include/linux/ctype.h 
#define isprint(c)	((__ismask(c)&(_P|_U|_L|_D|_SP)) != 0)
⬢ [acme@tb-five-perf perf-tools-next]$

We need to update review-prompts to cover this case.

Anyway:

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
