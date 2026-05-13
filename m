Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251F425CEC;
	Wed, 13 May 2026 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676776; cv=none; b=ZGXam7XVsRxw3JporyKe2PesP0kUvWKNRwRliheaP0S4TGcaerwx1deKPDW7KRrcRvcgHPBfMwTthF9OFh0Npa5BXMLkMjP+u5DaMPgoHNlvPhBkWv0HDpCHHwiZ42aTQ80wrCYMUwVAE3Y3jJ5SljIxTFO/ap/OPdg/bCB5Iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676776; c=relaxed/simple;
	bh=tG5nsfkX+xTPLj2+Y5oSvUpGkGiMRsHHbhBzN1TkQKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqOCcfkfrPCIkGR5OBR7DLHdpGLBygUWJvpYdspcDHE0k+NFvu7WdKGXQkuvb5TDUfxpO6ZrkHu/m4GtEYcG2/t1XlgyVsehGpFUu+VKgZtgF3Rp2hcquOkkLLeL2g05x7u2/I7GyXUVkJAuCQ01uTc/gNBlbadp7on6QtiIEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NGygUNbk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NGygUNbk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E0EB165C;
	Wed, 13 May 2026 05:52:49 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E13C23F7B4;
	Wed, 13 May 2026 05:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778676774; bh=tG5nsfkX+xTPLj2+Y5oSvUpGkGiMRsHHbhBzN1TkQKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGygUNbkbGU4/5PAjFTIdOkE0HTtK5ne53aiSg/J8i/+XCzMo572DnZHHGGH/sUUH
	 MtF+4Up0P4dqfcJHQlSq4FxQD0hVGJaZze7cNGGAQ6YAMuNeChukonrkAUqzzdDzUI
	 LUqLWDcFM/MG0AY6wQQ0k3EgYtXPnziO+KoEPSV0=
Date: Wed, 13 May 2026 13:52:51 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] perf pmu: Skip test on Arm64 when #slots is zero
Message-ID: <20260513125251.GF34802@e132581.arm.com>
References: <20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b@arm.com>
 <98ddaa65-747a-4b3e-9f72-05b90fc4eadb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98ddaa65-747a-4b3e-9f72-05b90fc4eadb@linaro.org>

On Tue, Apr 21, 2026 at 03:20:08PM +0100, James Clark wrote:

[...]

> > This commit introduces a new function is_expected_broken_metric() to
> > identify broken metrics, and treats metrics containing "#slots" as
> > expected broken when #slots == 0 on Arm64 platforms.
> > 
> > Fixes: 3a61fd866ef9 ("perf expr: Return -EINVAL for syntax error in expr__find_ids()")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Gentle ping. Thanks!
