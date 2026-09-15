Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA112F585;
	Tue, 15 Sep 2026 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431175; cv=none; b=Av59HAMwDpuM9+U9Hbp9bAY1CEyNboVL2muc8cj7kvePPpZdzg1Jkx4jC926eGNZuaYTIIAcFDjrla2usfSieowcgHNoQFeRNYnEEuFvczHYbyAjFqEygpT+Uc7ccp7K0Y3F12z76YLTi0cG6PWnEHxUHeg5JRJ9Mz7GnndVoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431175; c=relaxed/simple;
	bh=zhnx7AaXwqZQ0NgtYjvaGqDLnplmETcLfwMRC/yMguo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAfNR+0CmBtKKIR4nDnYs1VcUH69oUscJ1a1Y5f8UORj7AKXUZv+eNEXo8eHxLXP2jT+dVALU1SZoF1LoJhBdbV+GD5WhxnvW9+mYVh/HK99soZ1r84GQFYAmQI6LtFmj5cRTC12fbkM66ssvPkgWjj14HJPRjlN6Batg3mVBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDT7ph1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDT7ph1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395CC1F000FF;
	Tue, 15 Sep 2026 00:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789431173;
	bh=YvVrBgg+vONYjj2Z+vL3bZIO/5A/H3xh1/bkiLsmcaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CDT7ph1+48JbmxfifrHwu7ho+8gWl2UZprSk6k8ihEBcybC8NLuEDTCilh5OmufL8
	 G2mpzcvcIKWh8Umw7kAfnCj2LblLjc4B4VqtSB3MOY4rTkbRrd3yiG/z3mWMV7g5x5
	 Qb300QSs3f5H/KTkHUCHqItsqcqIl/vkG1Iqrubw7dQNu72LozTSF3A0WYdu974aMN
	 Sw5E00VbxJSxHSE50aHPipaq8dlJOQwEHAWybhmOSiqHKBPMhkzOo51MYkjXr+/xN0
	 XBCTS2YPTujXEir5p0zR0BarialXzjxmfMl02/4FuMC+HA9J3/4AHAPIp8yAqkmiRN
	 s7ljNFc0fr6bg==
Date: Mon, 14 Sep 2026 21:12:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Leo Yan <leo.yan@linux.dev>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/14] perf cs-etm: Per-thread mode fixes and snapshot
 wrap support
Message-ID: <aqiNgmB8-C_TuGf9@x2>
References: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
 <aqdL33fw9AoxTrPq@x2>
 <20260914081343.GF200420@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914081343.GF200420@e132581.arm.com>

On Mon, Sep 14, 2026 at 09:13:43AM +0100, Leo Yan wrote:
> Hi Arnaldo,
> 
> On Sun, Sep 13, 2026 at 10:20:31PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Aug 11, 2026 at 04:30:03PM +0100, James Clark wrote:
> > > Fix a few issues with per-thread mode:
> > >   - With TRBE, thread migrations hit a queue without a decoder assert
> > >   - On nVHE, everything looks like guest trace instead of host
> > >   - Tracing multiple threads didn't really work
> > 
> > This series applies cleanly to perf-tools-next but has no Reviewed-by
> > nor was processed by Sashiko.
> > 
> > Can somebody from the ARM camp take a look at it, please?
> 
> James has sent v2 [1] and I gave some words on it. Adrian also has one
> comment for snapshot callbacks refactoring.
> 
> Sashiko also sent out review on the series.

Ok, so it is still in development with open issues, I'll wait.

- Arnaldo
 
> Thanks,
> Leo
> 
> [1] https://lore.kernel.org/linux-perf-users/20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org/
