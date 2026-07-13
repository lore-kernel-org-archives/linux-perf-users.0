Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA56347505;
	Mon, 13 Jul 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976071; cv=none; b=gi4t99eDSdFjOgshnsB9H1RDYjEetQS5CBwb1zmmdTY6l0lRiQDm1nnVOemzsByCBpi6xnJLvgg4C/zf3S/ECFO3xBQYUg1a1A91EHAKFDhQk21GEBMO1zyQK9ds/ue8CGnuer2jKLNPqgYaQlkhLY+D1DvBtFnFGKs1bGuWxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976071; c=relaxed/simple;
	bh=CfIj1aV5kQWls5b4PSHP/LT/lmIQTxGFr4gVHVRstjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYS2VdtGkpwWDZ1kVNxhNVYJozY7XcozHKuhpx8guhd5BcZMwJFhOK4YScs0/flsRBg6INEPleMBzTwJiKNJxqdEIO2VhTLf3i1BW9MFvF+lAbZS5VMG/bYGJoYgCH2DaCDE086YeraT8NyWh+UsIQLRueptB3TxInqtAjv1QJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIeL/fvY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIeL/fvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3FE1F000E9;
	Mon, 13 Jul 2026 20:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783976069;
	bh=DL6/qVwpuc21RbxBxwlYCylaVsFJ5Sm8i2iDWWQ+9aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MIeL/fvY7UsNuB/A+XDK6J9//Bg8k7p8RpwRbU9nclp5z4taN6Gck2vyKTCDV9+AA
	 QW1h0uplu1Uq7FE9Z0zUMznjB9nZiZQJl886Y9OeTc9oBLFrvqX+ccOKRFrFbmLC6S
	 CWayK7eeAF/G/Bvp+zngLtouscXgQRtMhLgGUyhDCZvp4Ycg6ejUFlvQiK0iEZxjHR
	 14v/AOdjJlEwb0FSmUIDjQxXMnE8xDC0rnAJXjjxMRhFzciFEyV3+X+aKUtVNuxEBS
	 DF4spYLtJBEI3tbf9jWpi2FUcqpnr+6lAIAEjYRbv6Nnziz8CETDyRY7+k3mSYHPfY
	 7wKixStOjPezQ==
Date: Mon, 13 Jul 2026 13:54:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Trevor Allison <tallison@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix static build of dlfilters
Message-ID: <alVQhBfLDlyD7jdV@google.com>
References: <20260713-perf_fix_static_build-v1-1-460be1f9e4d6@arm.com>
 <alUioShYpMSzbmf2@google.com>
 <20260713181401.GA512733@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713181401.GA512733@e132581.arm.com>

On Mon, Jul 13, 2026 at 07:14:01PM +0100, Leo Yan wrote:
> Hi Namhyung,
> 
> On Mon, Jul 13, 2026 at 10:38:41AM -0700, Namhyung Kim wrote:
> 
> [...]
> 
> > > Fixes: e1065ed188cf ("perf build: Add LDFLAGS to dlfilters .so link")
> > 
> > Actually I posted the same patch.  Can I get your Tested-by?
> > 
> > https://lore.kernel.org/r/20260707000357.823509-1-namhyung@kernel.org
> 
> Sorry for duplicate patches. I will give my test tag on the patch.

No problem, thanks for your work!

Namhyung

