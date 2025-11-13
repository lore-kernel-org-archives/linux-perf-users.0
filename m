Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6935975;
	Thu, 13 Nov 2025 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065838; cv=none; b=cKsFwpOC0ds0Sna+T0jJC+mr7NmqCMZdcQK//92o/tLahc/7LmgBoFw7WZxf6mweWftO9EjD8NSi+KCiuBdQbiy0GChmlPHy4iLkTk2GfR3XqLrCMTX6H/PP3NvTXdmos+NLJL1IYV4cjs5XbgjIKzucfjgG1r0gCoyR7VT4hwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065838; c=relaxed/simple;
	bh=We3zn8RXbL+6odnj8ZF9KfEYh1rZdYD/VhJmX5sCcYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeSQEfdl1LAB7Y2wQ1sFtbeKGUqSA8055ACk4izy9V1X09nxYBEbs1fG56KOOvEKFMMc0mTHxLCouHeMuBN0oBfT2fG0Oxg0r78+Igiryn0m8ub3enQxVvbvJjreof6SiL5gagy/ipcu3k0Du/OhbEaCfcFVokg95Rfznuizh+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHZwMKrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHZwMKrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA2FC4CEF5;
	Thu, 13 Nov 2025 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763065838;
	bh=We3zn8RXbL+6odnj8ZF9KfEYh1rZdYD/VhJmX5sCcYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHZwMKrRTK0+SEOqpLNIwwp7lNBmC5dWW/8GGPbIAZc45fUK1cmZW+4jwkzEvUuTK
	 8oIgdkSyHrb7ZTJ7kt3PWz5dtshfi+idnkptm8YG3GLOVP6hMMJCWVE7LghBMs0toc
	 p8ToA1DNs7j/hf2yZLA7/tnOs05KOAVp/8PPkHsRIvnVQ2H18z75DR+DRqe4YnhY8K
	 6SYNfiY8Ono/WJptgvmnQXgxnuX41a9exL1gcQng+/7irMBXNWKXo00hB4aJOVr1bb
	 yK6QB4Lxpb6TKP6oW7MN+ogbWal5EHSr6sfBoOZmI1nP0o/TvDdVd0RHPGvPR5JQ9v
	 2ZH846R0vD5dg==
Date: Thu, 13 Nov 2025 17:30:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Tycho Andersen <tycho@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH 0/2] perf lock contention: Assorted fixes
Message-ID: <aRY_6-xqgMp4-vid@x1>
References: <20251113160124.2695-1-ravi.bangoria@amd.com>
 <CAP-5=fVNZW5EvpX+MCQOU1WJ0BeyDudk+nMp8-cAH6CfF9cE+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVNZW5EvpX+MCQOU1WJ0BeyDudk+nMp8-cAH6CfF9cE+g@mail.gmail.com>

On Thu, Nov 13, 2025 at 08:57:40AM -0800, Ian Rogers wrote:
> On Thu, Nov 13, 2025 at 8:03 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >
> > o Patch 1 resolves a segmentation fault in both "perf lock report"
> >   and "perf lock contention".
> > o Patch 2 repairs the perf-lock unit test.
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, tested, reproduced the segfault and the fix for it, applied to
perf-tools,

- Arnaldo
