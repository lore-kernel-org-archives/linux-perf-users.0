Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A346305665;
	Fri, 15 May 2026 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878132; cv=none; b=IOhCEQoGMUYR1xGc/TcijaTkhjQKGlc7y48jKNw/jKd+1jHCjFZoG+o8cWJ1SHohlV1Hikp3p6eHguwmXQfj89YiiDg1Xj9eGKQxPVMOY9E6k8YMkHlC+EaKlvQIq0wn722RqUjjV/8GMWfRiPEuUjVF3GfRJT8vh+gPGZ5gpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878132; c=relaxed/simple;
	bh=mnxRonVmc3SIVkJfuxHHi9gFpuH063Z0knM8Jl4+ZUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIxPBk8zTuzsNsQvXkcpjKe9DeC7Eazz3ZGE2KmRORIEtjMbrK+1sDD0a+0Xu5Le/FqiNJHFQCzBv95tTiWTQNdOB6aFk6qzsloefFFFluxnfnFnJoP0uexxnlK++6OSQAo9wX4fgUsGhStJZPuHb4kjKH023WKAdYjXtJQBs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY2x9j3t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY2x9j3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A77BC2BCB0;
	Fri, 15 May 2026 20:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778878132;
	bh=mnxRonVmc3SIVkJfuxHHi9gFpuH063Z0knM8Jl4+ZUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sY2x9j3tc+tNhoOAjU2yJZ7X/GCf60U9IvfrSx7LcvtPasbU2cxHxAKyv2I/l+x2b
	 WD8hAJuJ/HsTQafeO3rR4o8YjGHqPegt/gXQy0QhgLcRFVGGZG+K8YTa3FeFIfRcVI
	 6H5NSPaKbg2ZN75fKPC4Mjv0Hp0wMcE67ud5+WEmjT87runl0RBGG4ydGYCKA0n4IH
	 nuaPA6ApcBc6YTCMf/RNhArlzvQNxKRxTFCVMCj3PpvAHPA8srRQL/psG7sHJR/1CX
	 P2SXhwyzb655eVLIC9OI14twWN/GvvUPjPIyWADwFRXEa7yHS2xsn/6kwzhIHSYldV
	 IaFHoxPUu7HvA==
Date: Fri, 15 May 2026 17:48:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, namhyung@kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Li Guan <guanli.oerv@isrc.iscas.ac.cn>, 9erthalion6@gmail.com,
	alex@ghiti.fr, alexander.shishkin@linux.intel.com,
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu,
	atrajeev@linux.ibm.com, howardchu95@gmail.com,
	john.g.garry@oracle.com, jolsa@kernel.org, leo.yan@linux.dev,
	libunwind-devel@nongnu.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org, mingo@redhat.com,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com,
	will@kernel.org
Subject: Re: [PATCH v5 4/7] perf unwind-libunwind: Make libunwind register
 reading cross platform
Message-ID: <ageGsOVhDDKnvQhQ@x1>
References: <20260413024805.1316480-1-irogers@google.com>
 <20260513233151.572332-1-irogers@google.com>
 <20260513233151.572332-5-irogers@google.com>
 <agdyluuau3wPQOtX@x1>
 <CAP-5=fUeGOSH1LO1oSbWnpmXfv_RzxfFE+YCQ07PC19gLHDEsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUeGOSH1LO1oSbWnpmXfv_RzxfFE+YCQ07PC19gLHDEsA@mail.gmail.com>

On Fri, May 15, 2026 at 12:38:48PM -0700, Ian Rogers wrote:
> On Fri, May 15, 2026 at 12:23 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > +++ b/tools/perf/util/libunwind-arch/libunwind-ppc32.c
> > @@ -23,6 +23,8 @@ int __get_perf_regnum_for_unw_regnum_ppc32(int unw_regnum __maybe_unused)
> >                 return PERF_REG_POWERPC_CTR;
> >         case UNW_PPC32_XER:
> >                 return PERF_REG_POWERPC_XER;
> > +       case UNW_PPC32_NIP:
> > +               return PERF_REG_POWERPC_NIP;
> >         default:
> >                 pr_err("unwind: invalid reg id %d\n", unw_regnum);
> >                 return -EINVAL;
> > ⬢ [acme@toolbx perf-tools-next]$

> > Ok? It was the only issue found in this patch.
 
> Looks good, the NIP is in the original code that I copied, so I don't
> understand how I lost this, but good catch!

What I have is in tmp.perf-tools-next, doing a container build now,
still need to look at the other findings, but they seems either trivial
or complaints about making  the build time more inneficient by not
caching some feature tests, so I think I'll fix the trivial like I did
in the above case (posting diffs to the list) and leave the build time
for later so that we make progress.

Will try to do this later today so that I publish it to perf-tools-next
for it to soak a bit in linux-next.

- Arnaldo
