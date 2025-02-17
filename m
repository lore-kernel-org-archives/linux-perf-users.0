Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD52253A5
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809738; cv=none; b=aII2cAoto2eE2MAmn5s5E3AD48b/voRJcHPtIVDEtbF27i9F0JadUcrILn2wknadrBPsZH1WK6faMKkNlqAYb8uRMu8pqUmbeuLd/XSfX3P8l7RbXdPoG5J4TxIT0aVPXdUr5hm9+BbN5i1Q6dBEfc2phfqrKpZQaFerARNR8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809738; c=relaxed/simple;
	bh=1dZjLA99dFw5X8YnsZGjN3xV4yjbzsmIuRCG3ozKqwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=uCXRY3vEAGnFmD5gixxAWUyDdMXsf9wpWuO9qUGz/5nmtyhN8N6FJLeugP5XEu3VdC+QhaLwneDaBRZrXUdzEPL5qmVbFsTqPbc+07w8Ha9SqndNClm8ymKZaGG2QrgkbQBGSgcAB8YWtmkY7oOm6PpvnXJuN8TVIl0rMxwfO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ua7qIs9e; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ua7qIs9e"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so2736641f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739809734; x=1740414534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RZGgBpcp8HuoDdnVbyjD6nbTX5PiNpopNc/IO+zHmIo=;
        b=Ua7qIs9eNfY8EGqW3P050US1ROL7uqThw5HggVZ4Ku2sL6IV1UUGIYX4cfK75o59TE
         Z7y57REb1g/t9+ksCa6X7sDvRam2IkfXbZYrBCUcd1dES7pOf5cN7gpGBpxJWOSiqygK
         6xqhFnNV1e+8e+RuXpMDTFlvZJOnJs6MaHBHF9gKfCxRc1LmST7fs6UdM2sLgXnREvtO
         d3shc5T89yltl7RGW8EqYpiIxerTOyIu9kltt6vCMrSXFy2lmdwB2m3sWN53SwZj/xBU
         2KYnYWRNLYAG627NJJU0Z8pgTLnF8ov5H1cURmqAO/sylYfZJYmaqiCGhExW5g/yfgwS
         PSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809734; x=1740414534;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZGgBpcp8HuoDdnVbyjD6nbTX5PiNpopNc/IO+zHmIo=;
        b=aSRcGLQlE8Hhj/wCuzSVIrd+xUqpO0zNTcXzw0Ry7EIsiOC8gy9irhDmOgbTZk3rm+
         t8HmdXfDvZEO/dySpSEeDzKYWXUpAu0OBvEauOAaEzmfithPxEVxaYrOSRt/CP15Wbfe
         7eFjTmtB2F0RsiOkeq/egkKF1has0khWAPqvg/S436TBnxJBpWE2LeJy6d0317zzQHjG
         27fdduoiG1GCC2C68Zv26NlsFQkoYIm6X6vGe37A5fTqJhWC+qLh1aZiihV9jaJE2knc
         +HAn0zDShJiSDlhd7Q2KusGEdg7GN+5TGIpeYz1qQEr4rUtmKMicmhR6RDZdxgu2tFXw
         5xLg==
X-Forwarded-Encrypted: i=1; AJvYcCXT4fIceZoTuECbtjw7yyj+yklUaJF6o5kw/7LuBUK/tecjIG6enHAAiTHlYE/gJmdYYjbgtwnSvPoJF3vSFohJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxhLyEP6WOQW+/H17e2f0UT+TMKINyMPIvvtcfd7fjYZ2FyXA
	iUnsp+n2CS3pRSXmhMOaWQLQtQwaGyKV1LdJE537WdSq2tvpX5qAktmi4l68Pzs=
X-Gm-Gg: ASbGncuB6GCS5tJLSD4RLCl+g80Uh8TCnv8h294DydN7/QiQHAhv+YwHWfrrMaCU/tf
	S/vTJUUFCXY6ggp+50z2ULZx+wWPbZGsMZX9On7YSj8bw1iNv/q6622RfFYZ3OwG3OshpfxDubd
	c1lrWlUl2eQ/F3k/dVutfLRNfFE19Eju3MHjx80S+OgJiTnlOQxE5T6iRrWwd+A81RLYBXIDH5h
	0EOxbPiWIsptoHdPYhVkidfIObOD153dWIojeKyih6crhrBRC5YEeDKE1MEZUih8t1FTrs5w+81
	+TVj37+03j8OHXgmDSWoT1GfJA==
X-Google-Smtp-Source: AGHT+IHuH77s0Gc3jaj6SvUYPZ9P8VnXHclSL5deuIzHmW+q14rWha9t/xkM04tw0RHHjunQ1PBdgA==
X-Received: by 2002:adf:e6ce:0:b0:385:f6b9:e762 with SMTP id ffacd0b85a97d-38f340676a5mr8093772f8f.36.1739809733997;
        Mon, 17 Feb 2025 08:28:53 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccd3sm12655932f8f.23.2025.02.17.08.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 08:28:53 -0800 (PST)
Message-ID: <cd0c08e2-351c-43fb-863c-85a405714284@linaro.org>
Date: Mon, 17 Feb 2025 16:28:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] perf script: Refactor branch flags for Arm SPE
To: Leo Yan <leo.yan@arm.com>
References: <20250214111936.15168-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Graham Woodward
 <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250214111936.15168-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/02/2025 11:19 am, Leo Yan wrote:
> This patch series refactors branch flags for support Arm SPE.  The patch
> set is divided into two parts, the first part is for refactoring common
> code and the second part is for enabling Arm SPE.
> 
> For refactoring branch flags, the sample flaghs are classified as branch
> types and events.  A program branch type can be conditional branch,
> function call, return or expection taken.  A branch event happens when
> taking a branch.  This series combines branch types and the associated
> events to present a sample flag.
> 
> The second part is to enable Arm SPE's sample flags for expressing
> branch types and events, and support branch stack.
> 
> Patches 01 - 03 are to refactor branch types and branch events.
> Patches 04, 05 extend to support not-taken event.
> 
> Patches 06 - 09 enables branch flags in Arm SPE.  This allows to print
> out sample flags for samples.
> 
> Patch 10 supports branch stack for Arm SPE.  Patch 11 is an enhancement
> for PBT feature.
> 
> Changes from v1:
> - For patch 05, changed to append the 'not_taken' bit in the branch_flags.
>    This can avoid altering bit layout and cause breakage.
> - Added Ian's review tags.
> 
> 
> Leo Yan (11):
>    perf script: Make printing flags reliable
>    perf script: Refactor sample_flags_to_name() function
>    perf script: Separate events from branch types
>    perf script: Add not taken event for branches
>    perf script: Add not taken event for branch stack
>    perf arm-spe: Extend branch operations
>    perf arm-spe: Decode transactional event
>    perf arm-spe: Fill branch operations and events to record
>    perf arm-spe: Set sample flags with supplement info
>    perf arm-spe: Add branch stack
>    perf arm-spe: Support previous branch target (PBT) address
> 
>   tools/perf/builtin-script.c                   |  30 ++--
>   .../util/arm-spe-decoder/arm-spe-decoder.c    |  23 ++-
>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  11 +-
>   .../arm-spe-decoder/arm-spe-pkt-decoder.c     |  14 +-
>   .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  12 +-
>   tools/perf/util/arm-spe.c                     | 135 ++++++++++++++++++
>   tools/perf/util/branch.h                      |   3 +-
>   tools/perf/util/event.h                       |  12 +-
>   tools/perf/util/trace-event-scripting.c       | 116 +++++++++++----
>   tools/perf/util/trace-event.h                 |   2 +
>   10 files changed, 307 insertions(+), 51 deletions(-)
> 

Just one potential issue on patch 8, with that fixed:

Reviewed-by: James Clark <james.clark@linaro.org>

