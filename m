Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E262E62A0
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Apr 2025 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743844021; cv=none; b=UGjP9JuFZhLx4MfayUPWc7DNxlJMhqF8odLsysLVAE2zGY/yYzxJfufACgjLp3/3IVxm4PG0PNhnoWVnuFDDoz3llRLA6WaNNIN4d0rW8hj7WkHfWK1W1Q6mmwzeh3KMZItFu7KI0WfGNm+vJ8UVTZDob6do7juDRSwSIGLOX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743844021; c=relaxed/simple;
	bh=hmo4SkEfKVQ+JtittZixzT5qMxahWc1LMsBGP6j/eDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+d8G8spJaBMXChMOZknQ2cA67Wm2wuF0pBRXqUQ6tHbhmL4MEL1YcsI1uWnpMCVUVZWdE2LyNYvT+w5YuRipZ8faiskErfaWTqKfeMUwVqfMBrgoouxtqPjjLXSBeikLxsyXnLkmHblHBfqbe0cXPNht0dBbuh9cjv9xDvfxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1I+YMgL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1I+YMgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D81C4CEE4;
	Sat,  5 Apr 2025 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743844020;
	bh=hmo4SkEfKVQ+JtittZixzT5qMxahWc1LMsBGP6j/eDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1I+YMgLbUZLoiXEBIQVW+nP7YLIl5gMopWOdGVmV2AA8PSdseBoLdc0QpoeyW/3B
	 UvBue9CJE+COrwhTJtP5jMub9OyFVPIKs02p0iVrzgDMJyuX1xtz9Jtw1Nu0arzDrV
	 nI/agJS6i4xMWjte7nbMq7sttPEQhYwuglAKdpuUzS0/VCUJV0cAZR1xNnCJ095jT4
	 tsx2aRoeVjJYRVcOLTJi/8SWzuFtZ6gor3YWqUKtcx7+PWaSy4Geh7wCPyn0eLeA1m
	 bRYHi9gPIi59Hc0DlBwJ8/hsePL0+6E3kwpeq1cJteJPiT8e7MPfIUPMDpbb9ppsKF
	 jcr123+aVYujA==
Date: Sat, 5 Apr 2025 11:06:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_DyquBrleEGyiE3@gmail.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <Z_AWpgne5108xqlc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_AWpgne5108xqlc@google.com>


* Namhyung Kim <namhyung@kernel.org> wrote:

> >  /usr/bin/ld: test-libunwind.c:(.text+0x44): undefined reference to `_Ux86_64_init_remote'
> >  /usr/bin/ld: test-libunwind.c:(.text+0x6b): undefined reference to `_Ux86_64_dwarf_search_unwind_table'
> >  collect2: error: ld returned 1 exit status
> > 
> > I tried to install the libunwind-19-dev package, I tried to 
> > uninstall/reinstall - no combination seems to work.
> > 
> > perf is also totally unhelpful about resolving such issues - it used to 
> > issue tips about what packages to install, but those tips are not 
> > present anymore, for this one at least.
> 
> Since v6.13, we switched to disable libunwind by default and used 
> unwinding in libdw.
> 
> commit 13e17c9ff491 ("perf build: Make libunwind opt-in rather than 
> opt-out")
> 
> You need to pass LIBUNWIND=1 to build with it.

So, users (including me) have absolutely no idea which unwinding 
library they want to build with: 99% of them would like to have a 
clean, full-featured perf build with all libraries marked as '[ on ]' 
in the build log. :-)

> > Within 'perf top' I go into a function, and I press 's', which is 
> > supposed to toggle the source code annotation ... but nothing happens.
> > 
> > 'nothing happens' is perhaps the most passive-aggressive reaction a 
> > tool can give to a user. I'd prefer a *crash* to ignoring the keypress 
> > ...
> 
> Oh ok.  I prefer a warning. :)

There's a zillion other things I'd prefer over the current behavior, 
what I wanted to say was that *even a crash* is superior to a puzzling 
'nothing' :-)

Thanks,

	Ingo
