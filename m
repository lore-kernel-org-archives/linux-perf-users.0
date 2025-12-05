Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D25E18B0A;
	Fri,  5 Dec 2025 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764910103; cv=none; b=ac365mvearzByQq8TB6cxJUsVSiNCcqk1Inirkf9TviMeQkJ7Cu4JO/j4OTp74IL566EtmOp87qivCs2TZ6rsBMBCd6sVlX37VzGHkTaC5Gg40Y7R5vBI6//N0E4B3IOX0sPzGS7kcKcqEgBzXUtV5xAC4sCtu1uBewUq7V5UuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764910103; c=relaxed/simple;
	bh=/6zLhXin8TiveM4GlDFxuE79xuhwSrMi0pfUNFVFK/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4Jn1LVJp0zZ7rH1bmklMonKciuYD537vsI5IRiySaSRH8snhH1Yr2OMBijcnM9cxAPwpI9gBK2WL4L5dr0t4+ugX4x13qtEzsPuEc/aVvpTl5EL9sTI/82nT+x5D6UynSFVRcJrtLhXWJQLVD25hO4EdSPvN71ELyRk3qA24WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9170B339;
	Thu,  4 Dec 2025 20:48:13 -0800 (PST)
Received: from [10.163.52.42] (unknown [10.163.52.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 321A23F86F;
	Thu,  4 Dec 2025 20:48:14 -0800 (PST)
Message-ID: <c22b084b-3853-405d-8b43-397786af7be9@arm.com>
Date: Fri, 5 Dec 2025 10:18:11 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] perf: cs-etm: Set watermark for AUX trace
To: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-19-7da32b076b28@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-19-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/12/25 4:52 PM, Leo Yan wrote:
> The default watermark is half of the total buffer size. In many cases,
> the tool can not be notified with sufficient free space, especially when
> profiling with small AUX buffer (e.g., 64KiB).

Could not smaller AUX buffer be prevented for TRBE instead ?

> > Setting watermark to quarter of the buffer to notifies the tool to read
> data earlier and prevents the data loss.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index ea891d12f8f40beebf8dee1d3db71cad701f5666..649b8b0d0f92b4af45fb97db9da3c5ccf24a978b 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -424,6 +424,13 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  		pr_debug2("%s snapshot size: %zu\n", CORESIGHT_ETM_PMU_NAME,
>  			  opts->auxtrace_snapshot_size);
>  
> +	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
> +		size_t aw = opts->auxtrace_mmap_pages * (size_t)page_size / 4;
> +		u32 aux_watermark = aw > UINT_MAX ? UINT_MAX : aw;
> +
> +		cs_etm_evsel->core.attr.aux_watermark = aux_watermark;
> +	}
> +
>  	/*
>  	 * To obtain the auxtrace buffer file descriptor, the auxtrace
>  	 * event must come first.
> 

