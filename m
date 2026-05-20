Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00833EA979;
	Wed, 20 May 2026 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303176; cv=none; b=KTgu6KA1C27etY+E2HSJAOkhETglMwL5VyqmNCilpQQNKfYiVUlNQgS9IAO5QKcM26EQH3VDCr/Qsze/5BQ5+RMXlkl7a/FEg0fJJkDUUCQyKUnmdXL6oMlJihJV53fELgTxtWPPmd9yW7Gn/mUlFoZed802KlNPyuPghiGXMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303176; c=relaxed/simple;
	bh=KMS0F32bwXiosObItDNiyt1nom0a6B4MGSkOAOt2+rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svqhyngttv1DHtRLMi5/8UuCymCHEQSCg3FACTB4cDIkDuaNiQcsc9k5vu+uX2ucd5cFWnj4N4/Cv9VAZPL/5EWT0e0gR22Q8IPqFiZ1XkAmp9ahto7JWTtdS1vZXfgfZRa36A4mDY/W/E/PjYgtyvDZHfm6f+Y/CixztvCgzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQke5ll3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQke5ll3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2061F000E9;
	Wed, 20 May 2026 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779303174;
	bh=mVoL27wzhu14AxaDri3hYol07T2Q0IpMApk1h7KaMlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IQke5ll3n4zGwO6PlZnCFx+OETutaqYEuzaShV3qmVsVAs1uMf2r2LQkMAxnn4eAx
	 6AvUjWcIYKBcmxSpZfvBoP5tY4Tczt132Foka6ZkdvVNU1Nhfj7VM5ZCYUsAgZ2QI6
	 YHUmyPnR8oH/m+MkmrDA9gE7d5IIy1mKHGOE0nNfwl4bmKNB6rM9A86pZoRSVpx0JW
	 S/Yjq6Ccshvb6q+MlLQ23NoJfsnwaLc7PFrs7G89gA4NGTuk7h2cjVZtSZiAVILGh/
	 rJUH6GvfaWc0XaW+3v9cZOd0vIID4dzr+xdBb0gMFpSsUdECjPenTuVbQvToSzlVad
	 O5J6X0hBOlQOg==
Date: Wed, 20 May 2026 15:52:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Michael Jeanson <mjeanson@efficios.com>,
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf data ctf: replace libbabeltrace with
 babeltrace2-ctf-writer
Message-ID: <ag4DA1FMVtmaY9On@x1>
References: <20260512194710.162215-1-mjeanson@efficios.com>
 <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com>
 <e6d88ec4-c6fa-473c-ae70-071bb6f040c1@efficios.com>
 <CAP-5=fVnNyScv=fWy++iucCWWe8G7jcEn=AiDbLEV6PaeBooHQ@mail.gmail.com>
 <CAP-5=fX5QpRcVhnZCd230FQWsJ8KHbCrv6y_47vcrBK0fhWWxA@mail.gmail.com>
 <33978160-74a3-42ee-a4a2-1b0ad968a46e@efficios.com>
 <CAP-5=fUxAGG1Cs9yHqy7qjJNa4KP6E_Q0cCdLfmYwcPnHKLdyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUxAGG1Cs9yHqy7qjJNa4KP6E_Q0cCdLfmYwcPnHKLdyA@mail.gmail.com>

On Wed, May 20, 2026 at 11:12:37AM -0700, Ian Rogers wrote:
> On Wed, May 20, 2026 at 10:58 AM Michael Jeanson <mjeanson@efficios.com> wrote:
> >
> > On 2026-05-20 12:13, Ian Rogers wrote:
> > > On Wed, May 13, 2026 at 9:06 AM Ian Rogers <irogers@google.com> wrote:
> > >> On Wed, May 13, 2026 at 7:14 AM Michael Jeanson <mjeanson@efficios.com> wrote:
> > >>> On 2026-05-12 17:54, Ian Rogers wrote:
> > >>>> This is cool, I'm surprised at how non-invasive the change is. I'd
> > >>>> done a similar thing but keeping both babeltrace 1 and 2. I'll post my
> > >>>> WIP in reply just as a heads up, but I have to do much more heavy
> > >>>> engineering.
> > >>>
> > >>> I think I can rework this to try babeltrace2-ctf-writer first and fall
> > >>> back on libbabeltrace1. The change is non-invasive because
> > >>> bt2-ctf-writer is basically just a compat API for the ctf-writer of bt1
> > >>> but it doesn't expose any of the new features of bt2.
> > >>>
> > >>> Your WIP patch that uses the proper libbabeltrace2 API is definitely the
> > >>> way to go for the long term. In the meantime would you like a v2 of this
> > >>> patch?
> > >>
> > >> We have a problem with the perf tool in that it carries too much
> > >> baggage due to its library dependencies, so I'd prefer we stick with
> > >> v2 support and your cleaner/simpler patch. I'm also hugely
> > >> appreciative of the work you've put in! I'm too busy to review my own
> > >> work right now, and cleaning this up ASAP offers an advantage.
> > > ...
> > >>
> > >> * We support libbfd although libbfd is GPLv3 and license incompatible
> > >> with perf, which is mainly GPLv2. We carry around libunwind support
> > >> but that project appears unmaintained. We have LLVM support but the
> > >> LLVM dependency is huge in terms of size and dependencies it brings
> > >> in, so people avoid building with it, etc.
> > >
> > > What's the plan here? I'd prefer to carry the v1 patch, ie let's lose
> > > libbabeltrace (version 1) as a dependency.
> >
> > I think I misunderstood you, I thought you wanted to keep the bt1
> > support as a fallback. I'm fine with either version of the patch being
> > merged.
> >
> > I can send an updated version of the v1 patch addressing your review
> > comments.
> 
> Arnaldo, Namhyung, do you mind losing libbabeltrace v1 support? As the
> commit message states:
> 
>   The 1.x branch of Babeltrace has been superseded by 2.x in 2020 and has
>   been unmaintained since 2022, efforts have started to remove it from
>   popular distributions.
> 
> My choice would be to go with the v1 patch with the few fixes I'd mentioned.

Right, this is from the people working directly in babeltrace, so I'll
take their advice, Michael, can you please address Ian's comments, check
that it applies cleanly to perf-tools-next and resubmit, please?

- Arnaldo
