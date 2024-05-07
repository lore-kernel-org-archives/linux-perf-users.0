Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0117B642;
	Tue,  7 May 2024 03:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053672; cv=none; b=kk8pMMwPcW7PGjcU670vL7gdKOvZhlT/65HNlWoPgDDXL/MwSN2wJqBSbaChdbZ1e5LZhhvkQJGtNVk3CHtmSHFwtoKu8zuN0W3dS7QQUUrW3WQLJJKiIS8bC9arjAXaJDsWxApf5rjpLrKito1scleom5WXlleS7ifpqGGVG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053672; c=relaxed/simple;
	bh=kFOM3iy7Z7jag75KzlVF383Urq+3zzDGTWrSzDmdSmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLmH0/q+lxiXyfNhNyz+DfK63v65KCRTGLnAHGnkWjL/+ApoVfQ0t+t4zinjarMkErJmxLTWpN+h6QXhYckBRFmLW6VupPt0ibjC2oCjM+bJAPcvh0LLOe8sky6tvh/6Nhl34UpS/zVcICjDCG/lJeIiyeNW7vkCAqDdV0lO4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D56B106F;
	Mon,  6 May 2024 20:48:09 -0700 (PDT)
Received: from [10.163.33.37] (unknown [10.163.33.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21AB23F762;
	Mon,  6 May 2024 20:47:34 -0700 (PDT)
Message-ID: <08bcd616-5006-45df-b8cc-45cf3a1dd762@arm.com>
Date: Tue, 7 May 2024 09:17:36 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] perf cs-etm: Print error for new
 PERF_RECORD_AUX_OUTPUT_HW_ID versions
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 coresight@lists.linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-2-james.clark@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240429152207.479221-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/24 20:51, James Clark wrote:
> The likely fix for this is to update Perf so print a helpful message.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index d65d7485886c..32818bd7cd17 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -335,8 +335,11 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
>  	trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
>  
>  	/* check that we can handle this version */
> -	if (version > CS_AUX_HW_ID_CURR_VERSION)
> +	if (version > CS_AUX_HW_ID_CURR_VERSION) {
> +		pr_err("CS ETM Trace: PERF_RECORD_AUX_OUTPUT_HW_ID version %d not supported. Please update Perf.\n",

Is not this bit misleading ? PERF_RECORD_AUX_OUTPUT_HW_ID is just the perf record
format identifier. The record version here, is derived from the platform specific
hardware ID information embedded in this perf record.

Should not this be just s/PERF_RECORD_AUX_OUTPUT_HW_ID/hardware ID/ instead ?

> +		       version);
>  		return -EINVAL;
> +	}
>  
>  	/* get access to the etm metadata */
>  	etm = container_of(session->auxtrace, struct cs_etm_auxtrace, auxtrace);
