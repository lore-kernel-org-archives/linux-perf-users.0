Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8D31AF2A;
	Fri, 12 Sep 2025 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702935; cv=none; b=hOKTmTaAOKnShectwoueuoDoDLH6Zp5YUFLLLNIrP7w/UefyC1GpnRO22VH4fikugBTRhLx4zHNJDoIaCtWSsVr91i3D9t4zoSgeckw/FxBYKymRQFtqVPfUGCsHMwVWKbXntA8rlLpPeDugEiX8AYagln84gdtUsxUw/ZZjMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702935; c=relaxed/simple;
	bh=cJb5BBmk8fPdZjmmUJ5jkr99ebhj43GK6sqw2ZJDZsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuX0pzIcOiBwwCFaVZEOLel9lMJtqvLe/tG+SKB7bg1MWP9Bwo1nRuLKZzjX5ZCkujO+03hGXw+83rJwAkTUwURQsu3JeDOs4euBWq6YBTqqSM4738eeqNP1H5+gz1CZkXod+8mKuLcEKAYI/WxDwUggbdCJUWP+e/l7ZNIK28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaLUncVo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaLUncVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C7BC4CEF1;
	Fri, 12 Sep 2025 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757702935;
	bh=cJb5BBmk8fPdZjmmUJ5jkr99ebhj43GK6sqw2ZJDZsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaLUncVogwHc/amdcfamYUw/8mWSGIB3nlIjMy6SsMgaqCKQkKeF1ZDJRB8Y3J1VD
	 O9amPck2JIkQRD2+VmKKoYmEUzKRTTte8IiZQs/zCrccuIJun0xxGCmlqp6c52z/GB
	 CwKlvbX2B407S6yErr5r30PUcNsyBcm6O2uQpnimOMARIirGSt3OU/bmIrcd8lM5Ct
	 U5wX+NhmC7UiPeZ6cHdudvHRilxX4FmT7TzLAonm8o81KVvO9j8gc2H7Eopk0k95mU
	 0f/S7iG3nqXZPEwLg4IL7UHvVGm3/w7HU7xC6kk7Y1o7/Wlx8+cjR62nBXz0w3grNu
	 MTSCWoa2Rrdgw==
Date: Fri, 12 Sep 2025 15:48:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Howard Chu <howardchu95@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Improve event groups for topdown, add X event
 modifier
Message-ID: <aMRrFDBDKFSyA2VO@x1>
References: <20250825211204.2784695-1-irogers@google.com>
 <3f481d00-2c9f-45a5-807b-037930903b1c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f481d00-2c9f-45a5-807b-037930903b1c@linux.intel.com>

On Tue, Aug 26, 2025 at 10:30:10AM +0800, Mi, Dapeng wrote:
> On 8/26/2025 5:12 AM, Ian Rogers wrote:
> > Ian Rogers (3):
> >   perf evsel: Give warning for broken Intel topdown event grouping
> >   perf stat: Don't skip failing group events
> >   perf parse-events: Add 'X' modifier to exclude an event from being
> >     regrouped
 
> The whole patch-set looks good to me.
 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
 
> Tested the patches on Intel Sapphire Rapids and Panther Lake, all results
> are expected.
 
> Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks, applied to perf-tools-next,

- Arnaldo
