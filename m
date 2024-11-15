Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831211D54C2
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684962; cv=none; b=bftPUwHKORzyPb92MYhlBAz6KKQoPDAa1Qjq03qzwYBXhoQqlGkakYEWchWxgpNOC6onZJjaAESqbYATafMCZXPlDf3R6r0T/X6NUyH0Q+LUpjA4xLF3KQW4y69djSZ/bit/P7+dMYobkh47G1JccsnLmFk7OwhwBLUxxepLjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684962; c=relaxed/simple;
	bh=rYvme6davXOV7S0ICIdnVJjQUxIQxCENktTfkU2/Km8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=R99zmNQTDA/Pgajz4b57dAyn0/Kssw1YsM0mcE1OEZIzfD0vHHVFVFPu5D6ouEY/13gERH4SJ9icS9ehjEghY3el6wzjGkkBtddnCqVewcjRmEo0pR4pckcWRcfXCxxCAAqlreAZiYBD/oDjR9odRAO58kfnbxBzPN0oiVY4o14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zzPKoX9d; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzPKoX9d"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cf7b79c6a6so2792569a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731684959; x=1732289759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1RpKflVF0bebbJaxQf/ZXjTfRFvkv41edCIwaQJcQs=;
        b=zzPKoX9d3vNb5ippLrlXv5etR4FrC9zcSvcSOQni0LEaI4P88GCkH0/nLdS7UkFOPn
         bQgiAd4GORZDHF8N81/6MP0CmPxvVblIdQTGzv31WWNEQxjfde9umNCPrY12zU5+i3Po
         hbKlSM+Gacet/oE8hJnZPAATZEj0YymIxZjMI6Yp3NA/40tMhZlybAIPVOQZRSEte7+u
         CQntrJt6lTCL9OJNu+dH8MWqDrPHAi2UU19opvXWMB71oD45uLEvFYi7jjyZypACdx+r
         RGctr3CjrVYWdTufECMKdcEiOT7ECY7ylzvXug+RUIjtXaHfM0kdCnNR1yQHBQXSFbvw
         BiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684959; x=1732289759;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1RpKflVF0bebbJaxQf/ZXjTfRFvkv41edCIwaQJcQs=;
        b=DgfUAtWOLoPpn+kgnUzmBAbHe0Z/8MmKtsy63gP5CnXIAkiOPzUvm1dNaxh8onSFd9
         AlIC1jKoEKUzjoTLykJW9LyQS9G9r+KOp4NrT8MQYEJmwPfRKQ5Dn5GRteYUNlIeEb3E
         exm7zMktJE7x+vhL9/AuB4xpLRki8olvBO/AtOsJ0ISJVEDbZ8Dffs7/Xii8+GzrWoF7
         3/rrgnops5s/tT0FTBoOE1VJi7BO0hiuK1vsrWRyY2BeCqbi3yba6XT0MXnBcCJ+cRUm
         Lbr38nBfJR5woK7fVop0IPVu0qJcE71ikR4v2UAjfR31VDaq4TKvXMAez3JyjZdqIRQR
         R6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCX18iRKZvSnbOVTKn2dFazqLQivJcLKunpHTxO+iclnYHfNvMh8cGaoSttHb5YznZFdKe1hI+SpqKuP3MuzOXVj@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdcSPwz/AIxPntNPknahx5qCcHfpyOvJTnrsVjngmQcoOEWcr
	mutdSlWNokfNsFBXX2j+lGgQZhfReZnMZY44WkUo8yHbGuLW7JonmpmP8cHs3Ss=
X-Google-Smtp-Source: AGHT+IECuVoSF3cpPActYMtkLKV2qemZdHFkwL1b+NBlkRP5B3JvLdOGBczovm4O75t7YTAzxqF8NQ==
X-Received: by 2002:a05:6402:34c4:b0:5cf:14fa:cd10 with SMTP id 4fb4d7f45d1cf-5cf754df234mr6631178a12.5.1731684958824;
        Fri, 15 Nov 2024 07:35:58 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.111])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c0ad15sm1676898a12.66.2024.11.15.07.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:35:58 -0800 (PST)
Message-ID: <215ca9a2-0a63-4d0c-8402-5cb1f2bb0794@linaro.org>
Date: Fri, 15 Nov 2024 15:35:55 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Refactor cpuid and metric table lookup code
To: Ian Rogers <irogers@google.com>, Xu Yang <xu.yang_2@nxp.com>
References: <20241107162035.52206-1-irogers@google.com>
Content-Language: en-US
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Ben Zong-You Xie <ben717@andestech.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das
 <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Dima Kogan <dima@secretsauce.net>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/11/2024 4:20 pm, Ian Rogers wrote:
> Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> lookup:
> https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.yang_2@nxp.com/
> These patches remove a lot of the logic relating CPUIDs to PMUs so
> that the PMU isn't part of the question when finding a metric table.
> For time reasons, it doesn't go as far as allowing system metrics
> without a metric table as a metric table is needed for metrics to
> refer to other metrics, and the refactoring of that resolution is a
> hassle.
> 
> Ian Rogers (7):
>    perf header: Move is_cpu_online to numa bench
>    perf header: Refactor get_cpuid to take a CPU for ARM
>    perf arm64 header: Use cpu argument in get_cpuid
>    perf header: Avoid transitive PMU includes
>    perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
>    perf jevents: Add map_for_cpu
>    perf pmu: Move pmu_metrics_table__find and remove ARM override
> 
> Xu Yang (1):
>    perf jevents: fix breakage when do perf stat on system metric
> 
>   tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
>   tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
>   tools/perf/arch/arm64/util/pmu.c         | 20 ------
>   tools/perf/arch/loongarch/util/header.c  |  4 +-
>   tools/perf/arch/powerpc/util/header.c    |  4 +-
>   tools/perf/arch/riscv/util/header.c      |  4 +-
>   tools/perf/arch/s390/util/header.c       |  6 +-
>   tools/perf/arch/x86/util/auxtrace.c      |  3 +-
>   tools/perf/arch/x86/util/header.c        |  5 +-
>   tools/perf/bench/numa.c                  | 53 +++++++++++++++
>   tools/perf/builtin-kvm.c                 |  4 +-
>   tools/perf/pmu-events/empty-pmu-events.c | 39 ++++++-----
>   tools/perf/pmu-events/jevents.py         | 39 ++++++-----
>   tools/perf/pmu-events/pmu-events.h       |  2 +-
>   tools/perf/tests/expr.c                  |  5 +-
>   tools/perf/util/env.c                    |  4 +-
>   tools/perf/util/expr.c                   |  6 +-
>   tools/perf/util/header.c                 | 82 ++++++++----------------
>   tools/perf/util/header.h                 | 23 +++----
>   tools/perf/util/pmu.c                    | 25 --------
>   tools/perf/util/pmu.h                    |  2 -
>   tools/perf/util/probe-event.c            |  1 +
>   22 files changed, 189 insertions(+), 229 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

