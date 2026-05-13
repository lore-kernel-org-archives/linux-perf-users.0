Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC94357CF0;
	Wed, 13 May 2026 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778667628; cv=none; b=SlOnnlLS5dZiZoIdItaOaY8uBPnMIL1uy1hK/ZHH0XuZMHJEI9PfKko/htsCkIk4DrjVKW28YN7MwipBcQYoYU+DuEF4I5mugjTDQqVM87oYzPMeZMtIlii9CEwCsDG0M9KfEt+h8VWtTCYiJfkvXvtsEVfLAPS4Pm9Kejcb9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778667628; c=relaxed/simple;
	bh=kFvTrr5lJpNJvDr3fdaHSC+zFry1lWQIXZUKTBx3L1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWVySbfDWzrfpTvktjFwPLqsa7Ctd3bCNEW2uhpldeh4LfknBTZC8ugyWM0G1BkOXb2TZPnR0ZIgrw6jC2Ryr6sCQ+LhbmjMslzLakByo41O1eWN8zNYft7esrkkXae7z21JMgEQmTiFprkHpyShjhgKkagPIE8kiyDiqt22z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fNYAxVKz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fNYAxVKz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 644611650;
	Wed, 13 May 2026 03:20:21 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C50C3F7B4;
	Wed, 13 May 2026 03:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778667626; bh=kFvTrr5lJpNJvDr3fdaHSC+zFry1lWQIXZUKTBx3L1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNYAxVKza3PQJhUpXaSnZ2e+T2igw4Q9GliYm71/gsnjf4PaRVCerBtdlH66+l+rk
	 ynkUM/HOkTGS3UDX3FKRfdKrBrp1vR7GNMwF9ZYxzSaZCbMQ33Pazf5+KY/32tpgNg
	 V64XoKhQhFZoP50NY5f/QUhffdPUQC6O51PZtEag=
Date: Wed, 13 May 2026 11:20:24 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Don't warn about the discard bit if it
 doesn't exist
Message-ID: <20260513102024.GE34802@e132581.arm.com>
References: <20260410-james-spe-discard-warning-v1-1-985c02756ee4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-james-spe-discard-warning-v1-1-985c02756ee4@linaro.org>

On Fri, Apr 10, 2026 at 12:05:12PM +0100, James Clark wrote:
> Opening an SPE event shows a warning that doesn't concern the user:
> 
>   $ perf record -e arm_spe
>   Unknown/empty format name: discard
> 
> Perf only wants to know if the discard bit is set for configuring the
> event, not in response to anything the user has done. Fix it by adding
> another helper that returns if a config bit exists without warning.
> 
> We should probably keep the warning in evsel__get_config_val() to avoid
> having every caller having to do it, and most format bits should never
> be missing.
> 
> Add a test for the new helper. Rename the parent test function to be
> more generic rather than adding a new one as it requires a lot of
> boilerplate.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
