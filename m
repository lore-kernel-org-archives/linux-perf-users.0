Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C832E6BF;
	Thu,  8 Jan 2026 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767916651; cv=none; b=oE5PootcpHPPw0Wj/d+x/Gb5iHjbOILtwbMMtH3QLC4tQepI+oR9w7XvK/7R/+V6jdkkaow3EExP7fN2d8I9LOhAtINsLdFvX5vZfnAluB499eUVxNPRG3tOUmMiVzhL6LeFGdm00fCmU2meum3B+xyJC0R9iGUqnKrVC6BUV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767916651; c=relaxed/simple;
	bh=KGQRZxShhN31WMXVpQ5cr0GSY9PajzKHZaNjp1gD8x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQRNcJ+gOElfKQzmoVflRqAVHRKnOhmVTKhI127RA4c0RygBqU2hFMwC/qxDmGhU1VsuDX0DLkRKyH8fx94P2EhqNx1HUUlU1Zze4W3w4CIQHC06SGCF6zzyYwqPYXA69a+KlWWV+g01pHLdPIr6WaQU95DYtDS/UGph/rBhGiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0oND0iH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0oND0iH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B29C116C6;
	Thu,  8 Jan 2026 23:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767916650;
	bh=KGQRZxShhN31WMXVpQ5cr0GSY9PajzKHZaNjp1gD8x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0oND0iH7V0BwZDz8+f6ttO48W4qnePWJFAgEYEtee2sHsYGh+ooWHGFRXOYq+Yma
	 gh7hOl9rf7YFNNb1m3ZB9sPzL0dZoMKCF0bnSdq4BIuCFsmYezsgnIaptRDT8rIsXP
	 4Mh+s4QC+Rjq6Fvgj6xi/a9vgF5bV97rWqID0U6QPHcFaCwcwWnRqYwaswaW5MUoRD
	 bbMhFxUPlKa5FQRlLyoxRNLi5ZyBcO/7rthWu/3SczmH309r4ObOQfwNP/gN4aLbgR
	 DLwHRNcmxj7uAv6YLdW6v99ewTein+7Cgx+dTCSTzPzuGbho9g6VVO4oCF0LEq+rag
	 vhhlN7DQiB96A==
Date: Thu, 8 Jan 2026 15:57:28 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Gabriel Marin <gmx@google.com>
Subject: Re: [PATCH] perf inject: Keep build-ID data if no option is used
Message-ID: <aWBEaNVsoizw4Aax@google.com>
References: <20251217183927.2259237-1-namhyung@kernel.org>
 <CAP-5=fXShAb9Ez-j64fY8c_XDpRUp33Z1Z75jS9=+UaTKa68HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXShAb9Ez-j64fY8c_XDpRUp33Z1Z75jS9=+UaTKa68HQ@mail.gmail.com>

Hi Ian,

On Wed, Dec 17, 2025 at 10:57:01AM -0800, Ian Rogers wrote:
> On Wed, Dec 17, 2025 at 10:39 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The keep_feat() determines which header features will be kept or
> > discarded.  Usually perf inject will add build-IDs based on -b, -B or
> > other related options.  But it lose build-ID when none of those options
> > are used.  This is meaningful only when --buildid-mmap is not used.
> >
> > The following example shows the impact of this change.
> >
> >   $ perf record --no-buildid-mmap true
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.037 MB perf.data (5 samples) ]
> >
> >   $ perf inject -i perf.data -o perf.data.inject
> >
> >   $ perf buildid-list -i perf.data
> >   08cccc2a9388d5247ccb3e864f3063b975b0a15d /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> >   fd5c4d5673256cd6bda51725dba048dabb0f854e [kernel.kallsyms]
> >   97a36ce1140071be5c36b147fa0bed173e05a602 [vdso]
> >
> >   $ perf buildid-list -i perf.data.inject
> >   97a36ce1140071be5c36b147fa0bed173e05a602 [vdso]
> >
> > With this change, perf.data.inject would show the same list (of course,
> > you need to run perf inject again).
> >
> > Reported-by: Gabriel Marin <gmx@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the review!

Arnaldo, any chance you can pick this up soon?

Thanks,
Namhyung

