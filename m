Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8293126C7;
	Tue,  2 Dec 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676911; cv=none; b=f3Rraf/dm0GmIyYHCvQuugZ3cs+FCpKf5MRom/SSIDUdpurpPyCqXdbKRqqOmPE/DbmUBt68DFs/jfABZDa/TZRpgGNr4NgcqAfporOg0Er7LMYd4NfLTkbx3LlB//+cNrOFJR9r59fNtW4kqGaKqWm8rlh4i3CYhsmDrbkrZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676911; c=relaxed/simple;
	bh=Eo1EAl+QluDkQxH6pq8OHUPOv4wDYHFgUwLk0W+P71U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlhHOH9qSYn2BJSFUrY4poZCEctHQFbekOxb1GBdjBGM9twVk19d/q226/TMN/I4kQkZQjN9oBTzr7fyAQ2ke6imh+RQDH883tpHCPaBbllDo2nTiTQrDh8Tr+Pa5fUVnE1cBYnej1oYc4ZRNPM8mF4vIlZDh7uFnOrUnCl2APE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AD51153B;
	Tue,  2 Dec 2025 04:01:42 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 646D23F73B;
	Tue,  2 Dec 2025 04:01:49 -0800 (PST)
Date: Tue, 2 Dec 2025 12:01:47 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/7] perf cs-etm: Don't use hard coded config bits when
 setting up TRCCONFIGR
Message-ID: <20251202120147.GW724103@e132581.arm.com>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-5-22ecbbf8007c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-james-perf-config-bits-v1-5-22ecbbf8007c@linaro.org>

On Mon, Dec 01, 2025 at 04:41:08PM +0000, Coresight ML wrote:
> Perf only looks at attr.config when determining what was programmed into
> TRCCONFIGR. These bits could theoretically be in any of the config
> fields. Use the evsel__get_config_val() helper so it's agnostic to
> which config field they are in.
> 
> The kernel will also stop publishing the TRCCONFIGR register bits in a
> header [1] so preempt that by defining them here.
> 
> [1]: https://lore.kernel.org/linux-arm-kernel/20251128-james-cs-syncfreq-v8-10-4d319764cc58@linaro.org/
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
