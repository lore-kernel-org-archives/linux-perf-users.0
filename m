Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CF48033F
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582261; cv=none; b=R9P3b1teKMpYwR7Kwh8dfbEu4bHWWPrzeiJR8mYBNYqCIeisp2winqlzRMaxrgBCFmPKiggzRfRTZKBc0iZROO4WijHy+Dwtaq4cXSyYOFi150YjajiUdAxTCkR/wwT5sAWonyxZdHXjvTOWCjkfXKY4E1a0phEdpCw7dQmS5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582261; c=relaxed/simple;
	bh=X49F+6nXaniS/EqXMyPY8dIqo4ZcncfjPzZFhgE6GPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnDg4qHj3YtPBmVmVs9yhgoZEv73AsjRfFziW/LRKwCDyuTETlupZ2YnBshBHSrrnM6rBUMVrWkZ+mdNQoqXvr9engxdVEs/8XIWeqWyKMDnKI3QFJJ5ft/NYXX3yrp4xNEfkhp+WMCPKlvJ19/nOk9uQaXc64Qd338nYfpvMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLpG+NAI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLpG+NAI"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68ad1e513d3so1144566a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780582256; x=1781187056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWGYhCQeY167Hr42YHFijyfh5XKD6HMAPsUmURHfd7s=;
        b=yLpG+NAI5SJjvow/t2UYhF6bYmOZnfQEgDreLoJdyZQwFL5I0d54XSqA+m1uEOX38l
         yQq1KJOWHbmJ6PCRmjBl8fNxMU9KFRpTEizF/8tIowDAJHX/oCY1GbE80+EDMyMxR8uK
         zMRcQQ0WuMfkWT08FW4L8Yj7GLY84FfVkdKa8CbpPAS3PKD5w8PkLnfyDm+lyGkufFDk
         N7EGsHCV3myjmBW4ZTa0Y2sDLF/WT8HIERMMiY6F2nx8m6Ez7CZhlP05+/Z8Nyti6J3F
         a9YxmY5NDBbqfrR5JqruM3wF+iKI+CCrMXQzm0ArHtxq5x6loA1DePQ3zfjxQRgRbuiy
         O41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582256; x=1781187056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWGYhCQeY167Hr42YHFijyfh5XKD6HMAPsUmURHfd7s=;
        b=e+w9mF6XTLYcixe1Pcirfh2lIE68S18v6Fh8Hgxcrde/4ekP/BKZUGrOnsC3tIEYHC
         8mvkUX/121Zc2E+wsIH0NCgPLWGTQgDiVDtZm2vmnmvdTfM2UFEdSj/FSLiVCgdUSs/4
         vIPwlywHV3OjOzU2zj9IAKowUkP2evOj71mJpxB517N3aYTO0jfpENLVTAEZ/1BotpX2
         4druLj+43Ipn8fDu1hrXC2Y3Mjnyg+oauXFaUbykO6HRpcBkS6XLSpS4mVFAJ4vQFbda
         wRW2Z17JgYXA8qo4CnfcdxgfUwuZd2F8a7WBvwkcqd8d+QG5oVJENQ9PhTuB5VLdTi3u
         NyQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/RLI9pnCVTWF+23FNHFU+5Erx2/MR6vux7+PfODS2mK+fVoFHSUxcoESNUAHGp+HHnaa1rpqe4q1Hdul2iFbL@vger.kernel.org
X-Gm-Message-State: AOJu0YykZ6Un+o6QP/sOyzDlz2Y9wTzzfS+V+pWcJ5FqItNLzPc6hN00
	Sf3ACrlwtYZZNRzB/X0PsVw9DwtybksPupUYfcdmXyXSlVvowYNFvZa4h2bQhZ3TykM=
X-Gm-Gg: Acq92OEMk/ncdkOSfRx5Oo43002j9IH/I6bB1jbceDd6Bzw4fc6HkuaF21Q9UqnOeeo
	DMS/qPF/ZulmKLsqupIz7ZNmP63ZOCqhbc4dVSSKZYJ5T2YttP/OP4Z2vUKUGCJRDguUMa5Bmix
	AZYpXAZepWIDq4/nB/3OpeZdJIBNjPZctUPtRZxJLk7O4+2KMdLjCjBCUQKZ1xhdNPE8vHh42L0
	SCaQA1BCpxBRtdPwEJDCuZMX+xtPHwW91Yw4yD+TH4DCpWcfejIQYbOqVGiF572IybNN3gY3bpq
	NGomeQ7jH8pAY7kTrFRaZ9ZhZejGZ9kOtCxABoNdiYwlLNGi4g6ZJajyZXncFDrIzuU2iz55DSu
	B0c0npGSdyde1399+xGTuEMXwChNmV/MohRaPbp52bfUFMmHBOQL6fiqL3LxhSmXFsfEIan3G20
	jOUvksBz590Jsp9zCGlBOZwf5T1dSNyvRP1aPsSqug1hx9QsdZqQ==
X-Received: by 2002:a05:6402:27ce:b0:67f:99d8:868 with SMTP id 4fb4d7f45d1cf-68e710eb7bfmr3728458a12.16.1780582256213;
        Thu, 04 Jun 2026 07:10:56 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64e2c810sm2540577a12.9.2026.06.04.07.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:10:54 -0700 (PDT)
Message-ID: <047a6470-9afa-41f7-8942-9d9b6d15eff8@linaro.org>
Date: Thu, 4 Jun 2026 15:10:53 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] perf cs-etm: Decode ETE exception packets
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
 <20260526-b4-arm_cs_callchain_support_v1-v6-1-f9f49f53c9dd@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-1-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/05/2026 5:59 pm, Leo Yan wrote:
> ETE shares the same packet format as ETMv4, but exception decoding
> handled ETMv4 packets only. As a result, ETE exception packets were
> not classified.
> 
> Recognize the ETE magic for exception number decoding.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 6ec48de29441012f3d827d50616349c6c0d1f037..ab79d08f5a6095448470e2c3ec85ff3db2fb5634 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2138,7 +2138,7 @@ static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
>   	 * HVC cases; need to check if it's SVC instruction based on
>   	 * packet address.
>   	 */
> -	if (magic == __perf_cs_etmv4_magic) {
> +	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
>   		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
>   		    cs_etm__is_svc_instr(etmq, trace_chan_id, prev_packet,
>   					 prev_packet->end_addr))
> @@ -2161,7 +2161,7 @@ static bool cs_etm__is_async_exception(struct cs_etm_traceid_queue *tidq,
>   		    packet->exception_number == CS_ETMV3_EXC_FIQ)
>   			return true;
>   
> -	if (magic == __perf_cs_etmv4_magic)
> +	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic)
>   		if (packet->exception_number == CS_ETMV4_EXC_RESET ||
>   		    packet->exception_number == CS_ETMV4_EXC_DEBUG_HALT ||
>   		    packet->exception_number == CS_ETMV4_EXC_SYSTEM_ERROR ||
> @@ -2192,7 +2192,7 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
>   		    packet->exception_number == CS_ETMV3_EXC_GENERIC)
>   			return true;
>   
> -	if (magic == __perf_cs_etmv4_magic) {
> +	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
>   		if (packet->exception_number == CS_ETMV4_EXC_TRAP ||
>   		    packet->exception_number == CS_ETMV4_EXC_ALIGNMENT ||
>   		    packet->exception_number == CS_ETMV4_EXC_INST_FAULT ||
> 

Reviewed-by: James Clark <james.clark@linaro.org>

