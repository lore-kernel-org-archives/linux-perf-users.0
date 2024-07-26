Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAA14A82;
	Fri, 26 Jul 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004519; cv=none; b=Hb7iPMA0x7FahC+nr0gwfof0TsdJMRVoWc4irSXQb3nJM0c632DmJy9+3+otIVu0KldqFwOUJodlKL1TgB5Lhxxu1reyRGp0TYV+t927CCdrCu3mKgpv1xk7M/bUq1c1HErHJPNWXgBvdP/Kb/7fyoAZA088RY6FXykhv/6e3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004519; c=relaxed/simple;
	bh=MCyLCmJ5ASG1+9SW/Nyj3XNaNWYtfUuNic9tED0Aahg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2ZIANGd8NadF8tK5CS5CCWszCtrBTBwuAUg9XI4syKmVYFSr07e/giXxdF3KZRkn8CMgTSaHJsoIdpORGiLaOjqSGHBIFiGDT4tNOHSvPfONBcntD/QKPqceigqkW1iu81qQzbu/J3d5jXa1f7y7Y+T0hFkXW4iY7/g4UdUB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5F45JHd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5F45JHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416A1C4AF07;
	Fri, 26 Jul 2024 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004518;
	bh=MCyLCmJ5ASG1+9SW/Nyj3XNaNWYtfUuNic9tED0Aahg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5F45JHdnjm8t5TeQn45HlnxjEZLAjtqI2pUkpe7I0FmRd097w1cwUaS2JmoS0tVW
	 WM5rTF0xl4wmnT8tvVRRv9+za6LjkSnw/4MbqD4pu7pPCjN8oQLVUeavZv19HFnkq7
	 5e2qmH2C/C9ckR5c3BOLNjP9HS+9RmjKmds7zZu2es9xzZsjQczVhadhY44kg+9E4c
	 kkz/+biYCDBpBntuLO1WvIR64xNatV72IlmBWC4hzGvYeagSMiAIc8hqyrZIl41FrU
	 KmJ8zRIBHyua2O1YvViP/1OvrwFgt80O6Z7J+EYJqhQLTVivNcgS19wtPItfdVK2tZ
	 vFQV25XafX+Gg==
Date: Fri, 26 Jul 2024 11:35:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@linaro.org>, coresight@lists.linaro.org,
	gankulkarni@os.amperecomputing.com, leo.yan@arm.com,
	suzuki.poulose@arm.com, John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf cs-etm: Output 0 instead of 0xdeadbeef when
 exception packets are flushed
Message-ID: <ZqO0I1zLFX_oLYaY@x1>
References: <20240722152756.59453-1-james.clark@linaro.org>
 <20240722152756.59453-2-james.clark@linaro.org>
 <CAJ9a7VhLx0Zi0e-1qzcGCUWArkeD7vDkv0ewueDE_pYbmm5PVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VhLx0Zi0e-1qzcGCUWArkeD7vDkv0ewueDE_pYbmm5PVw@mail.gmail.com>

On Tue, Jul 23, 2024 at 04:09:29PM +0100, Mike Leach wrote:
> On Mon, 22 Jul 2024 at 16:28, James Clark <james.clark@linaro.org> wrote:
> >
> > Normally exception packets don't directly output a branch sample, but
> > if they're the last record in a buffer then they will. Because they
> > don't have addresses set we'll see the placeholder value
> > CS_ETM_INVAL_ADDR (0xdeadbeef) in the output.
> >
> > Since commit 6035b6804bdf ("perf cs-etm: Support dummy address value for
> > CS_ETM_TRACE_ON packet") we've used 0 as an externally visible "not set"
> > address value. For consistency reasons and to not make exceptions look
> > like an error, change them to use 0 too.

<SNIP>
 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>

Thanks, applied to tmp.perf-tools-next,

- Arnaldo
