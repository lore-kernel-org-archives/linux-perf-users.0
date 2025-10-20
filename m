Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7457B27E071;
	Mon, 20 Oct 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978935; cv=none; b=EuIZfFfBjAz/ZVlc8quUNA20Q7+oCl0le38BHOXDzzyxQziDLD/wlG83Xv5d+ReCGthEdoeq39JxoUuKbe8ppAjMQMNINGPJ3bDH+9Kfm7UWqrt+fuPnNbO+r1zSyxSEICsZFlD+40jBZpXuNFEavGwDq0uKs36e78NAwroIKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978935; c=relaxed/simple;
	bh=TN6KJeOMT+6mvj8g80so4+2Y3eKtmbwNPrJe05vbPlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8Hk2TtaByDC/Q4gNzKX7d/+r3XrvIA+Qkk9PGnpCji5lqL+cuX7eWnqOniQLEO9mZkD/PvKPfk168acT9CbxuLS4YrnmdfcmtXBOzpVSMEn5L2Lx+o7L70znNI933RXgJPIuuqrCp8YscXaNfT89xZX02I1znNaNHpaT+qPrTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF9E71007;
	Mon, 20 Oct 2025 09:48:43 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B9CE3F63F;
	Mon, 20 Oct 2025 09:48:51 -0700 (PDT)
Date: Mon, 20 Oct 2025 17:48:49 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf jevents: Fix build when there are other json
 files in the tree
Message-ID: <20251020164849.GJ281971@e132581.arm.com>
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>

On Mon, Oct 20, 2025 at 05:08:25PM +0100, James Clark wrote:
> I hit this issue because I'm using clangd with a json compile database.
> Not sure if anyone else will actually hit this, but it's not impossible
> and the fix is trivial anyway. The first commit is the fix so has a tag.
> The other two commits are minor related cleanups.

I can reproduce the issue and the redundant warning, and confirmed
the series can fix them:

Tested-by: Leo Yan <leo.yan@arm.com>
