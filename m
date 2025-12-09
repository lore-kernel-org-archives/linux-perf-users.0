Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74791288C22
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279916; cv=none; b=HzziYQnkgbB6zv+nnF+cCxft2hAgp0xZJ+JgQff2qsIwgofX/u6hPqUChVTDTPEojxrADK8KShmkPfj2wWq4l3wdPqZv96Tae4gTSOh/X4YiHJVtNkOOqGDCmP1+LQYvV7T1OuplKx678atizu85+SyxKft1WN6ezHG3LmU9S3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279916; c=relaxed/simple;
	bh=6HH/cxAGt3ABS3t90IUPQ0e68wSNZs8U8QlS2Iiv/WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=f6p9Fvke+1dyE2pY5SmQ/Sm31N6XVN0PGE9Z8gBDPnB8vNPhE+4Jw8DYhH90cX9I+GR0FpvHwR2bZYhPRy4Y+IASWU8Ll2cSSLgFXLazBhHczCP5tdyr/zM5lhzupb9HydwbEr980F6PjKQs6by6f//AUKsXdxqlZu16iCns294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DT1i7a2e; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DT1i7a2e"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42e33956e76so2489258f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 03:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765279912; x=1765884712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e6YWuMvXTNdTJOhHcDzcUXEKOmVYtdsSHdCKcDTVbug=;
        b=DT1i7a2eRvbRFikyVj47zjez4/UWBN1J7kivgWUWjlq3Sv6tjR54FeDoMTGhctz3yM
         S+d+cNT8fIhjS5g5vvYzA20G4htXtX4qlu/+axDox2CQeQh2CxLfS7Jzzdauot1J3zF9
         aURA3nJFC7Qoo23046Q9T9G4VYlI1s5TtJ0L8S5TPkpi0pTELk6cVR9CDRPeEoszb8km
         jn0IStgPmKYSEhEhK6SGBphx2uh+ZsexeJtmmXMxkioLf6FP/MmX2b7XGnzJuSVIqQcu
         Z2siNOzr7ObaEpHrcEIn6fIj0ln4ysZc/G5iEvHlZLnLD9ociQP6q35+qBjeb+i5mpnb
         BB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765279912; x=1765884712;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6YWuMvXTNdTJOhHcDzcUXEKOmVYtdsSHdCKcDTVbug=;
        b=GkjYc9SeJj0/ifWv1VTmnhQx2X8CNr5GS5xMJo4Xr/nvF+DuKrMOj7KWchBWadaotS
         WtGmf/S8MF0REZBvQ0utGaYeq3qDBps2YYTja9pZnPeOBAeNhogUMUyKwRVK/tRelbpn
         4qRccZvf1YRrSAQxIATA86tCDZle5XVWSfFEEdJetlmXuZmXWob5IdiAttOxYSZzQ+u1
         GAuVHDCH0sj43lBfcoZWEWsPWvz8/Kc5BqQK6HCAFqK8nBpAzqIDnedZsIzq0FiYUklt
         Mm29vYy1xw8p7G8ShLNqyi6SfJub9VjzWiMOGRz1WkSNtNo7Vh/IoYMK/quiURn1eAtf
         qO+A==
X-Forwarded-Encrypted: i=1; AJvYcCWepsV5idSOkcc0oCdh9OBiLMZUVkoRavhLV4knXrLnXmWHeAqBzraFHXn7OlOCLVfYXiIDM/PRnCqhrv/vphCj@vger.kernel.org
X-Gm-Message-State: AOJu0YzefqGqv6vjeiw370HTzeDBlS/t4FLKd7Xx4bPe4ooYY1ehSS3g
	3DXGoebWT5M39Cmb7hWHk/3V/4bR4qUJKCbJYQxREjBuNhmqVbZDtxJb93KvSg/Z8ao=
X-Gm-Gg: ASbGncun7mJYty0+4qgA2Z+6ADBHGplZ3aAqRuB5VMKgr6Cqa5LhCUA3sFA0zP9nYOl
	qIY5GyiMgZ1pUKKJ3ZhZamcGdOE9Lj3TIIvqNUcXtfnlKjzR4NieN+fzZzTzENDjF+sblU348aA
	atxb2rOhWY2AoTPZoAfh9qRsbnO672Vq641aryr1JCu7WkfuHHU5OA6EM2F66/CDl5z8uMk3NnQ
	Il+r2915Cs/t9dvr+YdkrnAKtk+pznZGpgsdm9W2I3eD2OmrIksKcRLYdEgrO6WLl1uOCqU4S2G
	gzFh0g5zXh6bFBkxnH1CICf+8XEhuJm1c3iOOjyUh2mbcTYXiyWkW9aPDc1ZVPKvuPqcBvbNtJP
	/VTf5xTcfXXnASsUmLNjsPZ8vcYTA7jGssy07Jhq1W2WFrfL1PGAWN/j8lRdxm5OMPcLRmZIwNF
	/ijiDBp6e/LhXhy/JG
X-Google-Smtp-Source: AGHT+IEwfVpq4vEyyu/zMlGG00IRvDaLPlzEHvJE6y+B8GWLHwhzhlMF/Zpeb50z/1x4UmBzouJKYg==
X-Received: by 2002:a05:6000:4301:b0:429:8d0f:e92 with SMTP id ffacd0b85a97d-42f89f0abbemr10139233f8f.6.1765279911677;
        Tue, 09 Dec 2025 03:31:51 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbff320sm31190157f8f.18.2025.12.09.03.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 03:31:51 -0800 (PST)
Message-ID: <c71aeb58-a87c-455b-9d5d-7bb28e34d317@linaro.org>
Date: Tue, 9 Dec 2025 11:31:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 46/48] perf jevents: Add collection of topdown like
 metrics for arm64
To: Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20251202175043.623597-1-irogers@google.com>
 <20251202175043.623597-47-irogers@google.com>
Content-Language: en-US
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Benjamin Gray <bgray@linux.ibm.com>, Caleb Biggers
 <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Perry Taylor <perry.taylor@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>,
 Sandipan Das <sandipan.das@amd.com>, Thomas Falcon
 <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251202175043.623597-47-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2025 5:50 pm, Ian Rogers wrote:
> Metrics are created using legacy, common and recommended events. As
> events may be missing a TryEvent function will give None if an event
> is missing. To workaround missing JSON events for cortex-a53, sysfs
> encodings are used.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> An earlier review of this patch by Leo Yan is here:
> https://lore.kernel.org/lkml/8168c713-005c-4fd9-a928-66763dab746a@arm.com/
> Hopefully all corrections were made.
> ---
>   tools/perf/pmu-events/arm64_metrics.py | 145 ++++++++++++++++++++++++-
>   1 file changed, 142 insertions(+), 3 deletions(-)
> 
[...]
> +        MetricGroup("lpm_topdown_be_bound", [
> +            MetricGroup("lpm_topdown_be_dtlb", [
> +                Metric("lpm_topdown_be_dtlb_walks", "Dtlb walks per instruction",
> +                       d_ratio(dtlb_walk, ins_ret), "walk/insn"),
> +                Metric("lpm_topdown_be_dtlb_walk_rate", "Dtlb walks per L1D TLB access",
> +                       d_ratio(dtlb_walk, l1d_tlb) if l1d_tlb else None, "100%"),
> +            ]) if dtlb_walk else None,
> +            MetricGroup("lpm_topdown_be_mix", [
> +                Metric("lpm_topdown_be_mix_ld", "Percentage of load instructions",
> +                       d_ratio(ld_spec, inst_spec), "100%") if ld_spec else None,
> +                Metric("lpm_topdown_be_mix_st", "Percentage of store instructions",
> +                       d_ratio(st_spec, inst_spec), "100%") if st_spec else None,
> +                Metric("lpm_topdown_be_mix_simd", "Percentage of SIMD instructions",
> +                       d_ratio(ase_spec, inst_spec), "100%") if ase_spec else None,
> +                Metric("lpm_topdown_be_mix_fp",
> +                       "Percentage of floating point instructions",
> +                       d_ratio(vfp_spec, inst_spec), "100%") if vfp_spec else None,
> +                Metric("lpm_topdown_be_mix_dp",
> +                       "Percentage of data processing instructions",
> +                       d_ratio(dp_spec, inst_spec), "100%") if dp_spec else None,
> +                Metric("lpm_topdown_be_mix_crypto",
> +                       "Percentage of data processing instructions",
> +                       d_ratio(crypto_spec, inst_spec), "100%") if crypto_spec else None,
> +                Metric(
> +                    "lpm_topdown_be_mix_br", "Percentage of branch instructions",
> +                    d_ratio(br_immed_spec + br_indirect_spec + br_ret_spec,
> +                            inst_spec), "100%") if br_immed_spec and br_indirect_spec and br_ret_spec else None,

Hi Ian,

I've been trying to engage with the team that's publishing the metrics 
in Arm [1] to see if there was any chance in getting some unity between 
these new metrics and their existing json ones. The feedback from them 
was that the decision to only publish metrics for certain cores is 
deliberate and there is no plan to change anything. The metrics there 
are well tested, known to be working, and usually contain workarounds 
for specific issues. They don't want to do "Arm wide" common metrics for 
existing cores as they believe it has more potential to mislead people 
than help.

I'm commenting on this "lpm_topdown_be_mix_br" as one example, that the 
equivalent Arm metric "branch_percentage" excludes br_ret_spec because 
br_indirect_spec also counts returns. Or on neoverse-n3 it's 
"PC_WRITE_SPEC / INST_SPEC".

I see that you've prefixed all the metrics so the names won't clash from 
Kan's feedback [2]. But it makes me wonder if at some point some kind of 
alias list could be implemented to override the generated metrics with 
hand written json ones. But by that point why not just use the same 
names? The Arm metric team's feedback was that there isn't really an 
industry standard for naming, and that differences between architectures 
would make it almost impossible to standardise anyway in their opinion. 
But here we're adding duplicate metrics with different names, where the 
new ones are known to have issues. It's not a great user experience IMO, 
but at the same time missing old cores from the Arm metrics isn't a 
great user experience either. I actually don't have a solution, other 
than to say I tried to get them to consider more unified naming.

I also have to say that I do still agree with Andi's old feedback [3] 
that the existing json was good enough, and maybe this isn't the right 
direction, although it's not very useful feedback at this point. I 
thought I had replied to that thread long ago, but must not have pressed 
send, sorry about that.

[1]: 
https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tree/main/data
[2]: 
https://lore.kernel.org/lkml/43548903-b7c8-47c4-b1da-0258293ecbd4@linux.intel.com
[3]: https://lore.kernel.org/lkml/ZeJJyCmXO9GxpDiF@tassilo/

