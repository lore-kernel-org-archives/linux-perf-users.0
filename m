Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F831EE7D5;
	Tue, 21 Apr 2026 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793674; cv=none; b=mvjwfrOHWaDOOPbrkPAo0qpGvZWBJi9LYTbP17Ucf//BurI8G8TPSj4EV5fKt4gJJXPXaETKFv88oxg/ArEz0RuJQ/jMHfINxYlbvuCUcz2tGD9pmryRV6hrA0HdIbm+S7mn8ZMtTtYTXmsQHNZU4KS3kgYEcM/Qck/SGd0Y4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793674; c=relaxed/simple;
	bh=2+xsvnBDg4QPBCiOS85Tl/b9xr6nqqa4dH7+Z+nZtqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSbuKy7To4FNcFsNgw8BGTlUUHi9bXceHY9cP/6Yrvpe89X7HnX/IKpDkaqmxaIUtn4d3izYbPTl3qL9WLBkW2/hc2vOHCQuJnhjvu3r4TenTFlgVkOTbL2RcmTbDZXQAHnFaJsNGVNeJ9PhlNapwFVttVg8g5vXXuiCzi92ybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PseeYZ+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PseeYZ+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D930C2BCB0;
	Tue, 21 Apr 2026 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776793673;
	bh=2+xsvnBDg4QPBCiOS85Tl/b9xr6nqqa4dH7+Z+nZtqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PseeYZ+YD0h3lziyya/PAxQi4ZmzNbzswcECiVbr20r+YgCWJkgtEzx+K4Rtv93+I
	 BJL2QGALMRmUOqhIFOmoXymdaUfJI73HcowqpJGZqI0n9wh6i7V+qrDmNq9yGQQUei
	 mjh9pAz9NDOqlyfi0o6Mwi228OEjP+X/O8QY1djBgBkLDunm/MwMFE06tA6dJNz+hs
	 biyKp0mPOElWn/obPZzUYH7rxu7zv1QLPKBoGpyRWxGrg/nPsE6Bwq6DLSDiWZE9pE
	 aH6X9UxAFbuByGcfQbKDEtV17UHLfcDoRtSefSiAqzcf42mNzTPAWI2inhL8mvosQ3
	 gk0HVwcxbk6Ng==
Date: Tue, 21 Apr 2026 10:47:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Markus Mayer <mmayer@broadcom.com>
Cc: James Clark <james.clark@linaro.org>,
	Perf Mailing List <linux-perf-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/1] perf build: fix "argument list too long" in second
 location
Message-ID: <aee4R3i-xnb0F0qb@google.com>
References: <20260409221418.185343-1-mmayer@broadcom.com>
 <20260409221418.185343-2-mmayer@broadcom.com>
 <d9c9eddf-8f66-4757-98b4-16b4ba505f5e@linaro.org>
 <CAGt4E5tinak=M+301yDCE_R0qREcQvWY6uGQ9vPZjhfrCTxk7g@mail.gmail.com>
 <ee8e6379-6bb4-4a83-87d3-5ae30fc0e95c@linaro.org>
 <CAGt4E5t4v3ztJPFRX-x0ygTk3cgnM_SwB_t+vvbNJ+_ifa=KHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGt4E5t4v3ztJPFRX-x0ygTk3cgnM_SwB_t+vvbNJ+_ifa=KHA@mail.gmail.com>

Hello,

On Mon, Apr 20, 2026 at 11:26:42AM -0700, Markus Mayer wrote:
> On Tue, 14 Apr 2026 at 03:43, James Clark <james.clark@linaro.org> wrote:
> >
> > On 11/04/2026 02:07, Markus Mayer wrote:
> > > On Fri, 10 Apr 2026 at 02:25, James Clark <james.clark@linaro.org> wrote:
> > >>
> > >> On 09/04/2026 11:14 pm, Markus Mayer wrote:
> > >>> Turns out that displaying "RM $^" via quiet_cmd_rm can also upset the
> > >>> shell and cause it to display "argument list too long".
> > >>>
> > >>> Trying to quote $^ doesn't help.
> > >>>
> > >>> In the end, *not* displaying the (potentially long) list of files is
> > >>> probably the right thing to do for a "quiet" message, anyway. Instead,
> > >>> let's display a count of how many files were removed. There is always
> > >>> V=1 if more detail is required.
> > >>>
> > >>>     TEST    linux/tools/perf/pmu-events/metric_test.log
> > >>>     RM      ...634 orphan file(s)...
> > >>>     LD      linux/tools/perf/util/perf-util-in.o
> > >>>
> > >>> Also move the comment regarding xargs before the rule, so it doesn't
> > >>> show up in the build output.
> > >>>
> > >>
> > >> I'm assuming this is just a cosmetic issue so it doesn't need a fixes
> > >> tag? And "upsetting the shell" doesn't cause a build failure?
> > >
> > > No. It's not just cosmetic. It absolutely DOES cause a build failure.
> > >
> > >  From the cover letter in this thread:
> > >
> > >    GEN     linux/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
> > >    TEST    linux/tools/perf/pmu-events/metric_test.log
> > > make[5]: /bin/sh: Argument list too long
> > > make[5]: *** [pmu-events/Build:220: prune_orphans] Error 127
> > >
> >
> > Ah in that case it should have a fixes: tag then. And it's worth putting
> > the actual build failure in the commit message IMO.
> 
> Unfortunately, it looks like the patch was already applied.[1] Is
> there anything I (or someone else) can do to fix up that commit
> message in the way you are suggesting?

It's already merged to the Linus tree.  I don't think we can change that
anymore.

Thanks,
Namhyung

