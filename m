Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7AD33121E
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860269; cv=none; b=tTkq62NhrMyM4G8b4uI+7FKeMc7SjLzDZQD6DfXeZu6iZkMmyyqy3E+h0OziXoWy/I4hiZVmHdWfBncSQ99lGFeiFDWlKonbX2tcF4fPL/dCDN+RJy7IV3tGHd3qiQrsn6yC4Po2xLiWNaFFMFUoqzG8uGo1nlI8X9t9kMBGSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860269; c=relaxed/simple;
	bh=28DkOdr888zEIg2+DOjAFLS8KOzx/O00mCM9DtAg6b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZjVfgJyoHwiz/KfmzKo/Zawsw8+TgAaOsvFQjZaDGx6j8UEdXUkwDW2ZAB+YcJnEeSs4EvjBGsKrqq38CbXTMECTgs+OHc175Laf5WAyUUJp6fJaJYB6biFs2W21lSlnXEY8jjgW3OcsOtD2OxcuP+j2d9KLQ/hPqU9IPo4dqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG5Ia1uV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG5Ia1uV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222C4C19421;
	Wed, 18 Mar 2026 18:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773860268;
	bh=28DkOdr888zEIg2+DOjAFLS8KOzx/O00mCM9DtAg6b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oG5Ia1uVTjROYxXG7Q4JKEUnjO1vxJP+oohJ6M2shfZBv2LUgNAaOFb5x+0nChTGc
	 KYVOnOFk5rQ4umc6PiSZvk0m4DWt1KJkfndd0y1cZ1mTkv8theBBPWBg7ruphBgGXS
	 q0fYQjCyGurAg25xnQyPRwDmK/O9BAvVsKBReTDVr9eobSUxfWNpfPND43Npdnb5n+
	 0HTTR1tMycLB4Djqp8ePirR9XmOKVPtuQzIH6qGhcI9BHGy/F4cK6mKdLtI/P9bGB7
	 mdwN8iBqb4gwaMOnZ6BNIjWIjwCW4w4rP9DnJAVm/OMtWSOvywXpwpLW5kEFO/7I0b
	 AM13dck5y5Asw==
Date: Wed, 18 Mar 2026 15:57:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Chen Ni <nichen@iscas.ac.cn>,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org
Subject: Re: [PATCH] perf intel-tpebs: Remove duplicate include of stat.h
Message-ID: <abr1qQ2ZjQN8Nh4U@x1>
References: <20260318034932.398913-1-nichen@iscas.ac.cn>
 <CAP-5=fUitzKwJONTngiW17XkS7kVr2cDS4cDL_HccJKcnR2EgQ@mail.gmail.com>
 <abrwRmaS7CDhzAyl@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abrwRmaS7CDhzAyl@google.com>

On Wed, Mar 18, 2026 at 11:34:46AM -0700, Namhyung Kim wrote:
> On Wed, Mar 18, 2026 at 10:33:54AM -0700, Ian Rogers wrote:
> > On Tue, Mar 17, 2026 at 8:54 PM Chen Ni <nichen@iscas.ac.cn> wrote:
> > >
> > > Remove duplicate inclusion of stat.h in intel-tpebs.c to clean up
> > > redundant code.
> > >
> > > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > 
> > We should really have a style for #includes and try to get it into the
> > kernel coding style. It doesn't matter so much in the kernel but
> > inconsistencies abound in tools, and the lack of alphabetical sorting
> > allows duplicates to occur. Here is a proposal that makes sense:
> > 
> > For any given C source file (e.g., server.c), group your #include
> > directives into distinct blocks separated by a blank line, ordered as
> > follows:
> >  * The Corresponding Header ("server.h")
> >  * C Standard Library Headers (<stdio.h>, <stdlib.h>)
> >  * OS/System-Specific Headers (<unistd.h>, <pthread.h>)
> >  * Third-Party Library Headers (<sqlite3.h>, <jansson.h>)
> >  * Your Project's Other Headers ("utils/logger.h", "database.h")
> > Within each block, alphabetize the headers.
> 
> Yep, sounds good.  I'm not sure if we want to convert all existing
> sources for this.  I think it's good for new changes touching header
> inclusion.

And then there are cases where there are ordering dependencies, which I
can't recall one to give as an example right now but I come accross in
the past.

So perhaps this should be made as a recommendation and when we have the
opportunity we change?

Just going thru lots of churn to have it look polished seems overkill
:-\

- Arnaldo
 
> Thanks,
> Namhyung
