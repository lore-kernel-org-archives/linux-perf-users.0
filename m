Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641EF2BFC9E;
	Wed, 21 May 2025 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860607; cv=none; b=ZZ9Yj/7QoFrDHyNboCZ56OHFWilKnCDOs71+jfWlBbKOtUVgeT0UcmPdXWGVgVY5ZEwSBbL7eJ/4rLmVQaG4ONbBtE+IR9vMfx1++sLE9FM1Xhx/JKrjIl0SV6+05KwQaK2vcBWL8K91KLw4ycC1l+oaRaUkcuJFWDDXsbbr7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860607; c=relaxed/simple;
	bh=N37wVWerWd7nPL9xYaWJ8SxgWS4N6DGwmoe0dWApv00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHHLCyZ2p3LVvAfKVbBGvzqRiFzdDD1iTyeE/S1jprqGcY40/usz2WRe1TY8DM1EBnRToo2Oin4DFW6ChhFESezzrP4er0crVbsA+EzbX8N8Uh4RC5BKGe4t/VKGAjnj17GsDa4May1iTjBFZftKzzGJ7vS/PEwGHEkeWNbiqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKPcSpX/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKPcSpX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9632DC4CEE4;
	Wed, 21 May 2025 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860605;
	bh=N37wVWerWd7nPL9xYaWJ8SxgWS4N6DGwmoe0dWApv00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKPcSpX/yIYRaer7liv4CXUHA7V7Ta7MCATogpw0v9rA0EU9pEj9A7wFMcqD/zGzy
	 fHvepn9nPxp6sMOCGN+uoriHnD/DBeSKHp+j8rj4t285Lb/bZ0XblGxq1BmqPn4HlU
	 NE+wJpTYbvVtaql7Q889wccn/fx+wNK4k1B/GD+5Vif1vvjUWqJloVepynyvxWl9lX
	 woea6R/HBqoctf51eJZq+cOAVEu2sAipNG4MLfMZAFkFTqGMogMeZg5dwM65zYtis1
	 Bwx1wOJHrzmIoV4d3LxH3/Ag3UR+OZsb2j5mPWNiDdrSSj7ohapxmrwRuQTh3z5lDL
	 24XEcn5WrMO8Q==
Date: Wed, 21 May 2025 13:50:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: IBS perf test failures on 9950x3d
Message-ID: <aC48fFyR1NN4RPz8@google.com>
References: <aCfuGXUnNIbnYo_r@x1>
 <33e86415-c90d-420a-b7a8-6a360769aea4@amd.com>
 <aColYM3RqE4T5t5c@google.com>
 <aCt4akGLsuuC4aLP@x1>
 <804ac0d6-22f7-40c3-9ff5-e5f9d863d37e@amd.com>
 <aCzqdn3AJji_yPpQ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCzqdn3AJji_yPpQ@x1>

On Tue, May 20, 2025 at 05:47:50PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, May 20, 2025 at 04:31:29PM +0530, Ravi Bangoria wrote:
> > > Telling that to the user and possibly skipping the test if viable using
> > > uname to get the version and if less than v6.15-rc1 print "Skip (needs
> > > v6.15-rc1 or newer)" may be an option.
>  
> > > Then if the bug somehow reappears, people running 'perf test' will flag
> > > it.
>  
> > Sure. Attaching a patch at the end.
> 
> Thanks, I'm applying it.
> 
> But now that I think about it, it may well be the case that, say, RHEL
> backports the fixes in v6.15 for an enterprise kernel that has an
> "older" version, so probably the best is for execute the test, if it
> fails, then do the version check to decide if it is an unexpected
> failure.

Yeah, that was my concern too.  I'm fine with having it in perf test and
skip older kernels though.

> 
> But this can be done on top, lets make progress and apply your patch.
> 
> > > And I think having it in 'perf test' as well may make the feature to be
> > > tested more widely, both by those who run selftests as well as by people
> > > trying just 'perf test'.
> > 
> > Yeah, that was precisely the reason I did it in 'perf test'.

+1.

Thanks,
Namhyung

