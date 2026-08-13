Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B784353A9F
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609889; cv=none; b=I1SsfNcnn+mF9/dxu/EwXdhENkfbS4+B/CP6n4/J4bgdTNLpX8X1rbHUMK1V+eT8uAAD6wptBBZLUJULh8mmhYbU7cuSarBykDhmbvGcJAwg54r3zk3Cl7jKyj488SnVCEjW9MuGhqYjqtqOvAeWiXpz5b/gQ7XUXq7EzPynAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609889; c=relaxed/simple;
	bh=LMi/OV+Cm0ipRtfFs5ZeyscPdvojyaPEEcChB2H4lKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROwZgn2+ef9tGQJrB7+ctiAgj86NBm/BZOPSncL/pm4YpLgL1dDCdzLNUtTedV5F+5sTwzahlNplqVmWDVyzbp6MPF9dv9xN5Uj/aLL6VqdWgsKWQi6DujrCYRb6I40SwzTOvNtBSfYJ+R1NabIfcRPZ5ejfRwvfbH9pvrlui/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=emXwTQRi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emXwTQRi"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so1224026a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786609886; x=1787214686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7yUisejUB/RXblzXQvMfPo73Fse8gZhIxVZGVkZNBxE=;
        b=emXwTQRioauzsfYCuKe+X1AtxW3vLMlNQqdBbUq+oJane0pKk7Sl8XAydwey/FlTz6
         Q+MJAJIzZCY2QdJ40rcEG3KvDCl3pcaUT3JzqzblLl+YN+z4TwPYPuFqyFcxSz6P3oZ+
         dqRRMVeEzlmbHIrmFQ9SJ9Ki+yp2XkP5U4luHKUpjm+6dKz8JsBaYIBvyj38dWgmyFjW
         WwZsw3gbAALeGOCKJ0VTNV/JWgJBct4X+rbA3tgScvPJqoc0/PqhGsyeMFyEYNwEoaTI
         7E97pc3TyNm/O2v3t8Ppdf6nD2UXCUWy9XMCwG7JZoFJptsjsKPUD4Uz19Up8J806F2E
         5Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786609886; x=1787214686;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yUisejUB/RXblzXQvMfPo73Fse8gZhIxVZGVkZNBxE=;
        b=kBi6KNULXq65Z6Yihft9U2/dTXbqr3ueGtrzlh3dYN56iXzsRzCCQE/YJf88OnKF7x
         LePVltP5VggLNKtY2C4ZIcD0tz1x/99+qBo2Hr95FClfSjg20m9OCI6aAjPcePRXNF/b
         AEwpZML/jkiaO0S6k6QcjGgf2HiySHiVLlCdbJ/UsRkrvg/L+HlAOdp2kF0wSetGb6P7
         kAMAPqqPks/VIuAWlESEJJmYngQDSb48PXY/e4sCbJgFXH41sxT1LZ1GkTNG77+A2xNJ
         oUl9Y3QevQoipys5wYeJRf+14US4z/ldbgq9aelxjk6RFvh4J03whv8KLCs4CbuOIG3a
         nzPg==
X-Forwarded-Encrypted: i=1; AHgh+Rpqnu2lnZC23Rizs0RBsTQ/0lw5W+fE5zxMNs6cpaf+M2tmeEZrWDVpkpf7fK2gPAO9hQZVS8TY1UlJpFcr12TK@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaypU9bWZjJuDQUftuqyEXR7tZ+geYtDA1FU7ffSwWXYzvrIQ
	vFeAQvNPvRIKtEQBl6qmlYTYMKUZG6521W2xtU/ADdu+nl6+rKtCwwOSbhSqp9Na/R0RNwqlQ/M
	DVQVbL8sy7g==
X-Gm-Gg: AR+sD127uLyJhfN7jKO9BD/QtqcJGbK0X9qhnsyAN24bZXY/OLVaV8VDN4vZDRttSPl
	1NYjhhJ/t0AJ39kBhF3HeOE2UYh0n2LkDyePFeUlPG4Mu5t76b6M6c+a0qLfhmCZFps5LMfetHi
	jSVOmYHag/1fbgjLaOVN7hIemZmLJX4z3cJn6UKbDaPbDPyv6qlYsPWiAmZWF5m8A+7mME1aeBh
	SAvuWAAl7UJ6k0bpjTxExbaWmC/z+3G0d2oYUQrhVhohaMJ5Ggojw2O6w/ENj4n1WjM3FFarEpY
	1HAYYpU08rVe5XzVaUEOPzyO9to4jKh2auWN+v4Pm5ktowCPYxrungEyDTB8HuHMp/8IaczMDMM
	Ak6US9uWhn7KfHRHIegGYE6YRDGvKKortAELDHQmT4ikXxlLnit6XIqnZJy0BPvXngxBKdHP38/
	p1J/2y0MjBDCAg2COQH9NrJGOJL3Jd+L02MAgNtFo7cIPE9+urcfEBCtwmOG6W4zckGw==
X-Received: by 2002:a17:907:a686:b0:c15:a7b9:2ae1 with SMTP id a640c23a62f3a-c210a820123mr158648066b.6.1786609886208;
        Thu, 13 Aug 2026 01:31:26 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21087e2c7dsm61260066b.39.2026.08.13.01.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 01:31:25 -0700 (PDT)
Message-ID: <856c4a5a-6b45-42ea-822a-01791b952af3@linaro.org>
Date: Thu, 13 Aug 2026 09:31:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] perf dlfilter: Add non-empty branch stack filter
To: Amir Ayupov <aaupov@fb.com>
Cc: linux-doc@vger.kernel.org, Mike Leach <mike.leach@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
References: <20260803090640.2412336-1-aaupov@fb.com>
 <20260803090640.2412336-4-aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260803090640.2412336-4-aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/08/2026 10:06, Amir Ayupov wrote:
> --itrace=L adds decoded branch history to existing samples, but a sample
> that was recorded while the decoder had no trace for that thread keeps an
> empty branch stack. Consumers of the resulting perf script output, such
> as profile generators for context-sensitive PGO, have no use for those
> samples.
> 
> Add an opt-in dlfilter that drops samples whose parsed branch stack is
> empty, so users can exclude them without changing default sample
> semantics. Build and install it alongside perf's existing dlfilters.
> 
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>   tools/perf/Makefile.perf                      |  1 +
>   .../dlfilters/dlfilter-nonempty-brstack.c     | 26 +++++++++++++++++++
>   2 files changed, 27 insertions(+)
>   create mode 100644 tools/perf/dlfilters/dlfilter-nonempty-brstack.c
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 0031112c036e8..aeb8085b0756d 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -427,6 +427,7 @@ PROGRAMS += $(OUTPUT)$(LIBJVMTI)
>   endif
>   
>   DLFILTERS := dlfilter-test-api-v0.so dlfilter-test-api-v2.so dlfilter-show-cycles.so
> +DLFILTERS += dlfilter-nonempty-brstack.so
>   DLFILTERS := $(patsubst %,$(OUTPUT)dlfilters/%,$(DLFILTERS))
>   
>   # what 'all' will build and 'install' will install, in perfexecdir
> diff --git a/tools/perf/dlfilters/dlfilter-nonempty-brstack.c b/tools/perf/dlfilters/dlfilter-nonempty-brstack.c
> new file mode 100644
> index 0000000000000..9e66205b841d5
> --- /dev/null
> +++ b/tools/perf/dlfilters/dlfilter-nonempty-brstack.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dlfilter-nonempty-brstack.c: Filter out samples with no branch stack
> + * Copyright (c) 2026, Meta Platforms, Inc.
> + */
> +#include <stddef.h>
> +
> +#include <perf/perf_dlfilter.h>
> +
> +int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
> +{
> +	/* Return 1 to filter out the sample, 0 to keep it */
> +	return !sample->brstack_nr;
> +}
> +
> +const char *filter_description(const char **long_description)
> +{
> +	static char *long_desc =
> +		"Instruction trace decoders can add branch history to existing "
> +		"samples, but samples that were recorded while no trace was "
> +		"being collected get an empty branch stack. Filter those out so "
> +		"that only samples carrying branch history remain.";
> +
> +	*long_description = long_desc;
> +	return "Keep only samples with a non-empty branch stack";
> +}

Reviewed-by: James Clark <james.clark@linaro.org>

