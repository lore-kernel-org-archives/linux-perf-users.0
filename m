Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECD23C506;
	Mon, 12 Jan 2026 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244065; cv=none; b=Zmq7DzLRo06j5lzD24uIX+GBb94pwMFJGhaEdbqk4h2rzLcF2yBL46Ynf+J3h3+IB8qZWpxbu3lne8zTsp+gVKR2gXv0Mbto1ywsvhWUouZUohcC5DSe1uunZvbQGJ1OAuHfacN23Rwn2nGKHr04JanS6AHs96p1etANO6ls/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244065; c=relaxed/simple;
	bh=UO/II2FWxu6Gge78J+8ypItJi8eaR8K2FyTcgqo+Oiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0n29rmVondANREuBVHumSO10aU89RB3yAcLJ5ChJOQpmfnZZ1M/yeNjTuuF/+KpA6BSJFa5KQ7gwuVqKeJA/km25tE0bax8jDUo/GG/FvpW3yhMGez4jN4cRSMa8NK412NZdf805aZ2xonKf7L+7vSfwJiHH6Cr/skxRLNWO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcRA0uss; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcRA0uss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CF5C116D0;
	Mon, 12 Jan 2026 18:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768244065;
	bh=UO/II2FWxu6Gge78J+8ypItJi8eaR8K2FyTcgqo+Oiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcRA0ussMdXYg7nKw96mIkV4JEgrw3jrULW93xZLHhsn1MGgPkrHak/13wYqumu/t
	 gbZNwRp5xrO5KXPhzvdJraSsusxcJX1s1p97m79O1+T5sUzh86XlO+lRYlj84CQxLs
	 mV44q7gZ7P9wjRpUL7tik9koH8zfuDPi9HVqSAl43pSa4PHWfkgGHWO/LUMsEIQ7ru
	 2j0rIoemcSxHTCTsTy0XaByfDn8DYJ29buje1pjXAK5xc4jECsSADVPoWaCVLzkFmv
	 FF9bAySHrDXIGEs7xJ/DjLTh0xw6PW38VKVl1sVBj6KqTI2MLuMBonPqrvbnQckpbW
	 9qSjJX26MwqeA==
Date: Mon, 12 Jan 2026 15:54:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Nicolas Schier <n.schier@avm.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Michael Petlan <mpetlan@redhat.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Philipp Hahn <p.hahn@avm.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH v3] perf build: Raise minimum shellcheck version to 0.7.2
Message-ID: <aWVDXUv0Jdon_nFB@x1>
References: <20260108-perf-raise-minimum-shellcheck-version-v3-1-36028909e7d0@avm.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-perf-raise-minimum-shellcheck-version-v3-1-36028909e7d0@avm.de>

On Thu, Jan 08, 2026 at 12:29:10PM +0100, Nicolas Schier wrote:
> Raise the minimum shellcheck version for perf builds to 0.7.2, so that
> systems with shellcheck versions below 0.7.2 will automatically skip the
> shell script checking, even if NO_SHELLCHECK is unset.
> 
> Since commit 241f21be7d0f ("perf test perftool_testsuite: Use absolute
> paths"), shellcheck versions before 0.7.2 break the perf build with
> several SC1090 [2] warnings due to its too strict dynamic source
> handling [1], e.g.:
> 
>   In tests/shell/base_probe/test_line_semantics.sh line 20:
>   . "$DIR_PATH/../common/init.sh"
>     ^---------------------------^ SC1090: Can't follow non-constant source. Use a directive to specify location.
> 
> Fixes: 241f21be7d0f ("perf test perftool_testsuite: Use absolute paths")

Thanks, applied to perf-tools-next,

- Arnaldo
