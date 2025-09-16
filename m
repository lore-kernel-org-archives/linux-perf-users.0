Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239B335BAC;
	Tue, 16 Sep 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033010; cv=none; b=Ux6lo3yR41cOktjcIE4nzMMawyL7nVEpInFM9mlgghVRRkPo/CuEiXP99Vqh/qKbfkD9pUP0TvH5GY7yz4+GnRJkJ6GhgVdcbwvw4cuM6n4oGLif24OJFoE5K2H7tU2bRVEmazluLhM9EIzNl2MtCG/VNjyTFb08fMDdj4PhmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033010; c=relaxed/simple;
	bh=cgSBheFKwssyvonzMIRhF90zfZIPlSWof2Di41nscT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okY/E9T2utvTVhze+OYhQbyTKJmue8z9jOguBdHzv6WukpIRA3YCvcJl87au7yBq/SS/ig3ZXwHRh7i8yHc7VdJf97fEuaVSZDAxfa/me7cpGbzOOX+r7I1d8/h9duuxmlNhZXa7uxaMed1Xgryphnhq2ivn2fGnslNaawY4q34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpAFufgq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpAFufgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3D2C4CEEB;
	Tue, 16 Sep 2025 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033009;
	bh=cgSBheFKwssyvonzMIRhF90zfZIPlSWof2Di41nscT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rpAFufgqdcW07IIDfVG0RULPL1gaXUn27mWmkomiJVpBlhwdMArYUpI0NEkpgQHRW
	 qQpvVASFTOaDfPXfyCgwVtIj9/EwBUTQQO5ItEG/4MsfaNxBKGaizvJBaqW/oSHTkd
	 d7eJGjeFReGuvCKkwcMqbtP4Mh9Huij5NIpavloHuZilASJktTFsIKMOZo7fTVPSWQ
	 bcb75aiRXE4x80W7vdC2cTYy30Qf9zR2kn9s4HL1tobflaIpTNSGSmwlQimbewdYp+
	 kbqt8Be2wZyblMBNiH4re4en0nbxKSCdN0pT7jDQ4mzPYce13LzeGtpAs0oL8HLoAU
	 Q16lTKEPBrKmA==
Date: Tue, 16 Sep 2025 11:30:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Collin Funk <collin.funk1@gmail.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: AMD IBS swfilt skip kernel tests if
 paranoia is >1
Message-ID: <aMl0brRnnyW_ofs4@x1>
References: <20250908221727.3635572-1-irogers@google.com>
 <aL9oL8aAMam676Ra@google.com>
 <aMSWbjo-qY7JYAoY@x1>
 <CAP-5=fWQUE4YxbAK4-qV44WFXYjo_EPy1XcVSrOYVP=rTspKnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWQUE4YxbAK4-qV44WFXYjo_EPy1XcVSrOYVP=rTspKnQ@mail.gmail.com>

On Fri, Sep 12, 2025 at 04:37:59PM -0700, Ian Rogers wrote:
> On Fri, Sep 12, 2025 at 2:53 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Sep 08, 2025 at 04:35:11PM -0700, Namhyung Kim wrote:
> > > Hi Ian,
> > >
> > > On Mon, Sep 08, 2025 at 03:17:27PM -0700, Ian Rogers wrote:
> > > > If not root and the perf_event_paranoid is set >1 swfilt will fail to
> > > > open the event failing the test. Add check to skip the test in that
> > > > case.
> > >
> > > Thanks for the fix!
> >
> > I'm taking this as an Acked-by, ok?
> 
> I have a new version but I'm discovering quite a few other issues on
> the way. There are 7 patches on top of this here:
> https://github.com/googleprodkernel/linux-perf/commits/google_tools_master/

I just checked and b4 picked the latest version of this patch as what I
have now in perf-tools-next is the same as in:

https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/tools/perf/tests/shell/amd-ibs-swfilt.sh

- Arnaldo

> I'll send the new version now, but I'd been tardy as it wasn't clear I
> was done with fixes yet.
> 
> Thanks,
> Ian
