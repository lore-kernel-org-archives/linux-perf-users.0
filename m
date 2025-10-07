Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1A1A8401;
	Tue,  7 Oct 2025 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867290; cv=none; b=flwGQK6chHXv37om9dPGpaMzDW77uL3F1k2tdQd/FWrJIQJ5xVJkyNE9pgBO3AVPCcaOruEZ2aFrAiyC0gJM7pYjC4NpmQH+zzYM7VFmvlay/AMRO3D7ZNwZTDrcN4uHI0B0c/2chEsygBUOALBEbRlKTLw3aNZjygwUUpB5QE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867290; c=relaxed/simple;
	bh=CCRq93UET3znVktK4m65Ep3opYdVinFNRNx5T+FpV40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgzSCE8L2NZNecOFYP4JwIN30Cf1jZUtUkC1MnEho0UmBB8k+rn+/hkdyv0bG6jPNHb8MOT8l1jA0s8l2jW08J13hMBS8Ci9IsuxP/k6SvDtGGa/Oc1Sz65Iymca4S8zSz4srVawBgpQix2Tu2edQiqIdNKdxoncOHp91zCc6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N03NhpnA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N03NhpnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DE0C4CEFF;
	Tue,  7 Oct 2025 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759867289;
	bh=CCRq93UET3znVktK4m65Ep3opYdVinFNRNx5T+FpV40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N03NhpnAeW9dCL78cOrF55iVbihXuAf7cWdmpd0tOtkq9e34WOfkv8XeRSaxMhrFb
	 Q67gmquKlyjAhfxJo5+/ZQ+qlKXojJU7u3sq11RNLUWj/wVtAxFsPh6UtknqOu8tWT
	 vMVkzF705pWUqWpbw1cPassZBzCqpEReEcwTzCWePvkuszgzU8T790xxNQfXbQY1yU
	 995BF77x6Bi9mISAIxOhuIHe6H1k10lY5xHfMP3wnuix+LTINobWweU6brD7YV3irb
	 kfAsX7JxaGcxZ2qY9GLrpJlfiFAR5jfPtJ/IJHlHZjVqo72IvHmw8ppvPueKUNWkuX
	 KI2bCnJpen3mw==
Date: Tue, 7 Oct 2025 17:01:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code
 reading"
Message-ID: <aOVxlEXDMKJyIhME@x1>
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
 <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org>

On Tue, Oct 07, 2025 at 10:10:12AM +0100, James Clark wrote:
> On 06/10/2025 4:21 pm, Ian Rogers wrote:
> > On Mon, Oct 6, 2025 at 6:11 AM James Clark <james.clark@linaro.org> wrote:
> > > +       data = zalloc(sizeof(*data));
> > > +       if (!data)
> > > +               return true;

> > > +       data->addr = addr;
> > > +       strlcpy(data->path, path, sizeof(data->path));
 
> > nit: perhaps strdup rather than having 4kb per tested_section.

> Oh yeah that would have been better, not sure why I didn't do it that way.
> Although the max sections I saw was around 50, and it's usually a lot less
> so it's probably not worth the churn to change it now that Arnaldo's applied
> it?

I see you submitted a patch for using strdup() and then there is a need
for checking the strdup(), etc.

Since at this point this is an improvement on a test and all is sitting
in linux-next and the window is closing for v6.18, lets leave this for
the next window, ok?

These would be good things for some tool to catch, before it gets sent,
but that is another rabbit hole :-)

Thanks,

- Arnaldo
