Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CABD1B4257;
	Fri,  6 Mar 2026 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800087; cv=none; b=Zfg/tcocoYojVCTCugjG7087qrNlO5sRMplXP5h5kXeYN3p3qThymAvx6SWe2zlqbVN3LmD/ybYvgNQzj4QJQCfce+tD5vggGpFI4XAHSKfo1OAsxw3GNZqeCCBS9+F5ltwZ4EKUL0aLDBSNzEuJLpDocNdKfTSNYgReJMI5PC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800087; c=relaxed/simple;
	bh=IoeCs8XvyRuWUugZ+riHvX4p+zQSX2EZh8j9o3fpKAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q807rkWJlbNuFSEd2whn9AGiQU1VVkTxa6+5F3cZOpffzMBmR/cCG41J9fINYQOAQWeI53lwe1VLu81SHvcirtsSDZDCPKWovlmv6lOusQOd1dC7MUhCHoSFe8+Fn/fzBPy0mPn+OWF3qrIxLJAYNDPVY79L2anAEIRR1nY0AoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23F15497;
	Fri,  6 Mar 2026 04:27:59 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2AB3F694;
	Fri,  6 Mar 2026 04:28:04 -0800 (PST)
Date: Fri, 6 Mar 2026 12:28:02 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf cs-etm: Finish removal of ETM_OPT_*
Message-ID: <20260306122802.GM1098637@e132581.arm.com>
References: <20260306-james-perf-remove-etm_opt-v1-0-03c662380361@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-james-perf-remove-etm_opt-v1-0-03c662380361@linaro.org>

On Fri, Mar 06, 2026 at 11:24:44AM +0000, Coresight ML wrote:
> Finish removal of ETM_OPT_* defines so the coresight-pmu.h header can
> by synced from the kernel.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

For the series:

Tested-by: Leo Yan <leo.yan@arm.com>
