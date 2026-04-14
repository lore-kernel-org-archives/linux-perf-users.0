Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE802F362B;
	Tue, 14 Apr 2026 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147672; cv=none; b=WH0c8b7kmqxauxAU5vs7lILDgbG3oyJndhzW1z5jCxVBiPsRfqpZn3OR15r4/DFKRnTz4HQvAACeGrM46dQM6OTXH9ZpqkllZAvjaZydW0mHoEya8ydycrI7I60OSggqoyAtoUDnrF9To4f3HMbnbmPaXMG5Ajqe+isWeuxxat4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147672; c=relaxed/simple;
	bh=SLPXjxcBGOBc12xm3alZQDiFEKm1Y8dSnDsT4u3Zj9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPnqH2qNf+ieue0RwHTi/WBExGjCuSaYNZCuEjkTKNw8XJZmhK++gbPHtaNneA3z3Ri5tsqmCX/9X/pfqIxUALwb8MgHinsKUNa+obTAwj+7drYWfTuUkNF/oLWabkceYW1sZ6VaWAg/1oL2zZ41fAdtkxtGJa41NKOE+DmD5Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKA6+dAy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKA6+dAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA0FC19425;
	Tue, 14 Apr 2026 06:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776147671;
	bh=SLPXjxcBGOBc12xm3alZQDiFEKm1Y8dSnDsT4u3Zj9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKA6+dAyqzlUGCcfyEeEBM3TXMXG/CRVicioAFFobMufl1i4ke0lv4T0Evb6VS+oe
	 IVlPVR2c8fq3Dane0FrwpkZDuxQSnKOjHCAgiZCQjvoL8w09+gYckIhMDzsLFfuN5Z
	 wgFqlFGzq7A4YPcEyjnw0zpEZMDfav98jXO3rdmdkfM1Xca8X3ERjBa8y0/sjDDsKq
	 YJgJG0ubIaDIGpuV2hqVXVSJ/hXnInfsYRpS+MdwGT4KaIthAtZaczqxelu+G81Nia
	 zoH4Dz60Ydy2DI37XkNW5H3p7OdKo5fgfaKmOG9K5T/y5ray+pt51FJ0L2IYNph78D
	 O++LVZgkslutg==
Date: Mon, 13 Apr 2026 23:21:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES perf-tools-next v2 00/13] Sanity check perf.data headers
Message-ID: <ad3c1SY54y15YZYv@google.com>
References: <20260410220905.200051-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260410220905.200051-1-acme@kernel.org>

Hi Arnaldo,

On Fri, Apr 10, 2026 at 07:08:52PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
>         Sashiko recently mentioned the lack of sanity checking headers
> in perf.data files, that with a fuzzy or maliciously crafted file could
> make processing a perf.data file cause deleterious results.
> 
>         Add sanity checks and some arbitrarily generous upper limits to
> headers, if some are found to be questionable, lets tweak them in
> upcoming versions of this patchset.

Yep, I think it's a bit tricky to handle malformed files.  But this
change would defend some of bad inputs.  We can add more later.

> 
>         As registered in the Assisted-by tags in the patches, this was
> done using Claude code to speed up development, hopefully no
> hallucinations are present.

It looks fine.

> 
>         I'm also trying to get some of these checks into review-prompts
> skills, some of which were already merged, for instance:
> 
>   https://github.com/masoncl/review-prompts/commit/2bb2159893ea926e120105416e95629b9ef1508c

Thanks for doing this!
Namhyung
