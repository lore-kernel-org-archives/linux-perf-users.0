Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E0030FF29;
	Tue,  2 Dec 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764675785; cv=none; b=jWcP7M7xwcoRCIQJqfldhdqb/0PryKGjJVmqLnCURZno5a/SwY1PcxobXFLwAKM9sUpSJ32JfGT55zPyd6DsAZh8zk6Zi5bd9xByFRYP3qw9YNYvtUScKcpcvBKWXunnn5lxzzb1rYAzn1sZmVGNr145TXww4aangOkhUJtfad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764675785; c=relaxed/simple;
	bh=+EkQnN7wqbVCwLxhmIyFIOrx3w79G0/USUOywNXI6pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoK93W1cWCkpbXxcVqaUcOBBhUU6F8fDM03yk0CfV9WJ5TXp6imG/OOGxi/nzbVY36OgwmIiXMmzEVfZuPQbmBL3cLVGmkLOWDiQbq4t6YkpoMjDeMT4aVrUVI2MO26fvS+1GjYhtLI4bYTE9NlNSdZwL5X8u4hmM4V1rgQ2mbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3319153B;
	Tue,  2 Dec 2025 03:42:55 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B80433F59E;
	Tue,  2 Dec 2025 03:43:02 -0800 (PST)
Date: Tue, 2 Dec 2025 11:43:00 +0000
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
Subject: Re: [PATCH 4/7] perf cs-etm: Don't use hard coded config bits when
 setting up ETMCR
Message-ID: <20251202114300.GV724103@e132581.arm.com>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-4-22ecbbf8007c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-james-perf-config-bits-v1-4-22ecbbf8007c@linaro.org>

On Mon, Dec 01, 2025 at 04:41:07PM +0000, Coresight ML wrote:

[...]

> @@ -746,7 +779,7 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
>  	case CS_ETMV3:
>  		magic = __perf_cs_etmv3_magic;
>  		/* Get configuration register */
> -		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
> +		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_guess_etmcr(itr);

I still think cs_etm_get_config() is better than cs_etm_guess_etmcr().

For ETMv3, we directly pass CONFIG to the kernel, and after validation
in the dirver, then the value will be set to ETMCR.  If we already know
the config value is consistent between user space and kernel, why
introduce a redundant "guess" operation here?

Thanks,
Leo
