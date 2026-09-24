Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580944D09EB;
	Thu, 24 Sep 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271334; cv=none; b=HSAN7CnnmtGEAOigdq1dmm2cfVLd56WDJ3vbk3yMxcOkAym8IvDnS2HS+I/ByTYO48OuSYmtLD9Q8sjCiHCW63Y3OI3kh5rDQ0Fspz0C6uGUQ/5Y8VayaTw3ZcaDQMZ7VrIqakEdwKyaTOeyGECI09ImYIOcq4SQYq7UrIUO6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271334; c=relaxed/simple;
	bh=qQU15BMTU9n5l1J2SRyYyOCgcwcrbWAwPPEt/k6KNEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tixnPFP7yINJdlCx8VtEhUuwdXOGAXyl237pKtdtS7JL539lZrfiBPFFAFSQmFozUSKJwzBUV2+yeKXOxdy0IK7r/6J2vnG7iAeFZgG4DzgwMA+FVKuEEYH78zfGW9G0unOjdRAFDCKq0iyZXrs72bGJetKv7xiSnXKElErN3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ/jXhWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ/jXhWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FC41F00902;
	Thu, 24 Sep 2026 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271333;
	bh=WQzWSAB242M0aa5nFGCOIgs3eg39Of4VNXwVut989R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bZ/jXhWuZr6kvWfWzhuELIXVyFnpUAuAocDgeq9X091buMcmF5ktDsYNCmdwVL/up
	 yfjw9ShWacbgQ6keEjiFzjH6UP94XKac88SqKMsmvbJZezUK4kurOX27/b6JJzs2su
	 2WTC10zR52luoLDEGxPA7DNb4IS3V4DP+17cyPMYXosVHXrcQMFdgobAyRY8xjh6J+
	 Z/AJP9lncqktDZ2WOausmdXhP9YQzPodoKFc7wDum9qQwFM7Pha+YepGfAljQAfEUr
	 dN1OIS6F7sfB1jB9cx2uc5a0dgI5yDUTcKVzDnJpVjYyFqQHjnU8VhacM+qbSvQ62C
	 OnOxLwHrTbYCQ==
Date: Thu, 24 Sep 2026 19:35:30 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v12 0/6] perf: Add support for memory region/range
 reporting
Message-ID: <arVfYrhsx6WXWBVI@x2>
References: <20260923161043.95C171F000FF@smtp.kernel.org>
 <20260923170903.48388-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923170903.48388-1-thomas.falcon@intel.com>

On Wed, Sep 23, 2026 at 12:08:57PM -0500, Thomas Falcon wrote:
> Add support for two memory-related reporting features in the perf tool:
<SNIP> 
> Include a change allowing PERF_MEM_LVLNUM_L0 to be printed in
> perf-mem output as well.
 
> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
> [2]: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.com/
> [3]: MRRM definition allow for future expansion for the OS to assign
> these region IDs.
 
> v12: 
> -- Fixed typo in bounds checking for max supported memory ranges when
>    reading header data

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
