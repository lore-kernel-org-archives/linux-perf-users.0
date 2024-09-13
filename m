Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC22C80;
	Fri, 13 Sep 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228456; cv=none; b=NlN9dWI+RELeQRlxVvCBaTGMHdKNhscJkgJw0USTYrDTWbT941TonGS7xTfz02LQRkm3zHzXKNSCDHf8ygVfBR9oGgelgP1DYtJ3s6woEOH0cFsz01hH4ow1xrltad3nXgRXYE5mUc49mG5WNl6sld6luZ7Fmd9AMK6ixnE7yEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228456; c=relaxed/simple;
	bh=iG2P9hX1ns9KNbqKRkEhqBui87XiWao5+qPYO4jvhyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvksMKpjHDJ2n+WPgh1mkYVycqICRZSDACinu8KCrfIG7zpdY2XzF9GDD/7/NT5Mu1daoa/ZmDQsLAXQoq275/fRqV/ddncFk8qbt0M1kUPnctokXgHQeQ39tdC/odDc3FLVhJRrZlddt5g14okdYYtydjMY9BXIPHrBxZevNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8352413D5;
	Fri, 13 Sep 2024 04:54:42 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366E53F64C;
	Fri, 13 Sep 2024 04:54:10 -0700 (PDT)
Message-ID: <cfad80e4-3ee8-4a55-9dee-41d0d0256c04@arm.com>
Date: Fri, 13 Sep 2024 12:54:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] perf cs-etm: Use new OpenCSD consistency checks
To: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <20240912151143.1264483-3-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240912151143.1264483-3-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 16:11, James Clark wrote:> 
> 
> Previously when the incorrect binary was used for decode, Perf would
> silently continue to generate incorrect samples. With OpenCSD 1.5.4 we
> can enable consistency checks that do a best effort to detect a mismatch
> in the image. When one is detected a warning is printed and sample
> generation stops until the trace resynchronizes with a good part of the
> image.
> 
> Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> Closes: https://lore.kernel.org/all/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index b78ef0262135..b85a8837bddc 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>          }
> 
>          if (d_params->operation == CS_ETM_OPERATION_DECODE) {
> +               int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
> +#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
> +               decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | OCSD_OPFLG_CHK_RANGE_CONTINUE |
> +                               ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
> +#endif

Looks good to me.

Just one question: should the flag ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK be set
according to ETM version? E.g. it should be only set for ETMv4 or this is
fine for ETE as well.

Thanks,
Leo

>                  if (ocsd_dt_create_decoder(decoder->dcd_tree,
>                                             decoder->decoder_name,
> -                                          OCSD_CREATE_FLG_FULL_DECODER,
> +                                          decode_flags,
>                                             trace_config, &csid))
>                          return -1;
> 
> --
> 2.34.1
> 
