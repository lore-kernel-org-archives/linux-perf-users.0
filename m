Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A414B092;
	Thu, 15 May 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325806; cv=none; b=XxD6YTL+JDJprffxBVSDJw3UYWLNefStjfjeTJt7tczdTHfRxAKKDbTLhWzihttj53CsmOa8yhs8csFFsGzy0utFwO9Qd5mMpLQrX9C5FcXsVxG18oAajBv7qFY3byhsxXEvrrWSByyVOZSCrBbS/ADqHwQvbG8ayFV5TU0D1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325806; c=relaxed/simple;
	bh=+Z/FBhF3TsVxxcYnzna6c2Ltc2O0dK+361Hx/d/etQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+MSZe/28wKNwDx2k1MXYNcD+yL81d92Y4BSo1zB8+T+Oqw1nAGiXfo1xtuwJ1juAS2aV1fQlJPAlHWJZRts+rTJlGuV01VZgw86q5ZBvH+L5dWiVGKkS5MXpfka/aG2GZbzFQUAlBiVWL9k8jphc/DbAXUOih40OnqYXbUu7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0Nf2s9O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0Nf2s9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29179C4CEE7;
	Thu, 15 May 2025 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747325805;
	bh=+Z/FBhF3TsVxxcYnzna6c2Ltc2O0dK+361Hx/d/etQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0Nf2s9OkbFqRBivLRaezHm0atUtMR5zpHlRTvBULTapnKj03u1HWv8P96nuURfgN
	 u9q9Aoe19zv9sp6blgZTszp8ajLxE6DXJD8NXwS4gx1VgWWTX9zvx7oTwI+CJ60bax
	 AWT4WrYgEx2QiAUurNU1WCb5Pp8fhlWt7RrPdDoij/lxkm6SvR3/lFINgu/idadpAp
	 3/Q0fuQras4f6WvSTXcdoKJWP9VFrJKhLugtnFJux06uICdYp4IHPIsKwKQ2OK3jlp
	 xvAKTUREHiBNH/yawFXak0D0asihLHQR2EJTRW/oG2c8wHaJSwXNuhdEEXE+MUx5SY
	 1cf9GuQAZRVkA==
Date: Thu, 15 May 2025 13:16:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
Message-ID: <aCYTaveeziFiF3kw@x1>
References: <20250515043818.236807-1-irogers@google.com>
 <aCYTG12gSmv0OtXN@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCYTG12gSmv0OtXN@x1>

On Thu, May 15, 2025 at 01:15:26PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 14, 2025 at 09:38:18PM -0700, Ian Rogers wrote:
> > On graniterapids the cache home agent (CHA) and memory controller
> > (IMC) PMUs all have their cpumask set to per-socket information. In
> > order for per NUMA node aggregation to work correctly the PMUs cpumask
> > needs to be set to CPUs for the relevant sub-NUMA grouping.
> 
> I'm blindly applying it as I can't test these changes, and I think this
> is bad.

In the end the only review/action I could do was to turn:

Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clusters

Into:

Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumasks for sub-NUMA clusters

:-(

Besides the build tests, etc.

- Arnaldo
