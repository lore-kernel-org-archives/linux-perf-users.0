Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308D218AB3
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748550482; cv=none; b=prtU6pPT5ilhe2PM52f8kLcb0CLHNd2YiVUqnGcAQed1WDwWaEoEklc7l6OalQfjsN/O6HMpt/fzVlK/i5VF2m73iXPDnPpFFJ86Is+GyNAoXHCZZLO9FZXEVY6h4duDO50XANiKAIbAbXfdbJ2Z4AD35NPJ+dWieD3R228bRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748550482; c=relaxed/simple;
	bh=IakKMT1dyj/Wa095Hu8r+xBABzSqIsd4K0nWybNZJK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyWr+mYqZPTpK0hok/a4zF0MgRDzHNNPSEmy+k1mORy/Rzp5Pkodb076hbPPp7yupWah9bN6vNEXUzOnXVlz6/jejPPHvX0n9+/O73Y1aqAMEwQ0HEo9tLkO3d/rkBBHdwoEOI4exZDxqJ85kAmbmkdmA+uc/0ySplIe/8SCLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6frT3KH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6frT3KH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B7CC4CEE7;
	Thu, 29 May 2025 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748550482;
	bh=IakKMT1dyj/Wa095Hu8r+xBABzSqIsd4K0nWybNZJK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6frT3KHC9U/7LhhFjqFtrsUOgdT4FVjF/CdJuznHL0c6wkSjoaLH7p0XtBO5wwbi
	 Ydp2498t7OpXynUpDipthITGHlLqq5saJdAqz29xDOjH7rBDdsz739BNHHK4C0n9oo
	 FM3IVoCo3LiWHARk9CZUa4j+ZTkZFdoGWoNj/0MYD1mQTTPkQKGI2qBe1c0s0zHFg4
	 nYH3w5zMgDFbOHrktRK8Tdj9c5L2tx6ZKB0bW9Cgy23Yi/t4qKqKqbUX46K1MC5wK6
	 +3UG+n71FtpviDLTv1HSJXUGwaa+KD/44QmnYEF7147UiqCsSqgpppu76HAFo82Uq7
	 seHXToveOdbog==
Date: Thu, 29 May 2025 17:27:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, namhyung@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Subject: Re: [PATCH] perf trace: set errpid to false for rseq and
 set_robust_list
Message-ID: <aDjDTxO9XBZJWP13@x1>
References: <20250529143334.1469669-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529143334.1469669-2-ashelat@redhat.com>

On Thu, May 29, 2025 at 10:33:35AM -0400, Anubhav Shelat wrote:
> rseq and set_robust_list don't return a pid, so set errpid for both to
> false.
 
> Fixes 0c1019e3463b2 and 1de5b5dcb8353.
 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>

Some minor nits on the commit log messages, I did some adjustments,
please take a look.


Thanks, applied to perf-tools-next,

- Arnaldo

----

perf trace: Set errpid to false for rseq and set_robust_list

The 'rseq' and 'set_robust_list' syscalls don't return a pid, so set 
errpid for both to false.

Fixes: 0c1019e3463b263a ("perf trace: Mark the 'rseq' arg in the rseq syscall as coming from user space")
Fixes: 1de5b5dcb8353f36 ("perf trace: Mark the 'head' arg in the set_robust_list syscall as coming from user space")
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250529143334.1469669-2-ashelat@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
