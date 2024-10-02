Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0881E0B72
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862583; cv=none; b=IqnXxJZ+rGNYJk+h0aYBxsrZ1ARwhSim3/aCjF8knHQp7DyXLdqgJf2kS28UuE9kXJiR+Ie3S4TdrM2yYUSKMMSsqeHS485eCNz7obRMUoJexe9DeOxL6j5NQxtMC2bcdNTMtO4lYkfHv1XdG/JQSFCjZpUy4mhbirHmv+AuY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862583; c=relaxed/simple;
	bh=ThjDiiUmc7K5RP8JXSTAHHvHhsSR2gUxloWzQHhUKK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KA0b+OUliJmJB5pTzLexhi3Sl3qfh4BVQxuON12Czc2QVjgALAs9eVjhnukgyRk1YnDmk7uj9anD7N5BT40eRlAFu01ZHs4uZsStanybDqUYVsO3vo2TS7uymtLziXVhhheoxTmXaJyUWfH1j4a+GdVWaouVs5rL3HM/Jcbau3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SYNXvJlH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYNXvJlH"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5399675e14cso3782394e87.3
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Oct 2024 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727862579; x=1728467379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U53E0yTEUkeFzJEDaWpr2IrJhE3rw3NidU36zE23tWg=;
        b=SYNXvJlH0RQvAwv2fSueBrXfOqfmgsUgbPHDaMZb2CvcE3+ETc63pXynNz06A/uTTN
         GMcc+v5Uk2Iz0Ra3glM3MeLPJfxwM/k7V1M0uTmatTP1B782sWPd2L6O9LcNWaIpbt36
         n9XLnJ9O0D5cGemmywFVHb8f5+w9gCGlPsP9f6BgIinmpdXJTG0lVFFhqrr98dadFEyV
         May5IQmebUpuYk6+Z434riuhi3CNhPiykP4XbwddHqd2llpkebMdcfTjMOBNn1mbYFrv
         yZu9PiFbLwWBQutTm+qDgVgFCXsIi+oairyTXgRlz4zFG/jKH4J8YldOAaDa/Ydee7QP
         KzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862579; x=1728467379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U53E0yTEUkeFzJEDaWpr2IrJhE3rw3NidU36zE23tWg=;
        b=Bo3Tx3FNww3Bnz0k1vn6gah+yax2Pon2tl4Hc/F0tSfT5BGBZK62Isir0s1nVVIhjA
         jSrzBuwoT6V3wvBiX7TRv2HDHeCVH1yuSa4nfzTykbzeCXtPMFIKxhjm1xqL2T2zk38B
         N8hszQx52U0S71GhHIid3LRW8Lk5KFX+d6cYiqGN+/T5BQAqanUYtBRkJdLjlGCbnj50
         2k1a2BNri/IX5q4tSXMWAqBVJzLjtjiaNSssHMu0uCmqLF7UrYFihqr8n1KrLr97CIFe
         JBikZ6l67JzM8QCIuIJe3/RBLhHgI6YnNOfNqVhrpR5Hxs3wBK+h6FaajAQPT/gF8dVu
         9eFw==
X-Forwarded-Encrypted: i=1; AJvYcCUs5I0nZwYRIGtWwxmoH1Be8E9wV4JBYCAPL5zloJsVMAc7Zf+8ReRzVlNGvnyKgRsJPHFavSi0Hjmt1DW2CSLD@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWOK9jcVG0NSMyxjy8O6DDBK2srl4DzXiMS36Acz+tEMVUd12
	hU2LxsjRdZrvRy9pUkZHKW1Wz3cFUu7lH7KqOHWbYf2uCSdnhZRQmsYNwvgdw4s=
X-Google-Smtp-Source: AGHT+IHHP/AAM3V6vneqEsVuTTPua23yP5ObAU+JSYfoaupy45P0EeOnzyyqw/P4bjPCtO92UFSXTA==
X-Received: by 2002:a05:6512:1090:b0:52b:de5b:1b30 with SMTP id 2adb3069b0e04-539a0793d07mr1372094e87.44.1727862579025;
        Wed, 02 Oct 2024 02:49:39 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248aeaesm7425912a12.71.2024.10.02.02.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 02:49:38 -0700 (PDT)
Message-ID: <b894eed7-15e0-4ec4-a9d6-07fe86326396@linaro.org>
Date: Wed, 2 Oct 2024 10:49:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 0/8] perf tools: Do not set attr.exclude_guest by
 default (v4)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241001002027.1272889-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/10/2024 1:20 am, Namhyung Kim wrote:
> Hello,
> 
> I found perf tools set exclude_guest bit inconsistently.  It used to
> set the bit but now the default event for perf record doesn't.  So I'm
> wondering why we want the bit in the first place.
> 
> Actually it's not good for PMUs don't support any exclusion like AMD
> IBS because it disables new features after the exclude_guest due to
> the missing feature detection logic.
> 
> v4 changes)
> 
>   * handle EOPNOTSUPP error in compatible way  (Kan)
>   * drop --exclude-guest option in perf stat
>   * not to separate exclude_hv fallback
>   * rename to exclude_GH_default  (Kan)
>   * drop the RFC from the subject
> 
> v3) https://lore.kernel.org/lkml/20240905202426.2690105-1-namhyung@kernel.org/
> 
>   * move exclude_guest fallback to the front
>   * fix precise_max handling on AMD
>   * simplify the default event for perf record
> 
> v2) https://lore.kernel.org/lkml/20240904064131.2377873-1-namhyung@kernel.org/
> 
>   * update the missing feature detection logic
>   * separate exclude_hv fallback
>   * add new fallback for exclude_guest
> 
> v1) https://lore.kernel.org/lkml/20240902014621.2002343-1-namhyung@kernel.org/
> 
> AFAIK it doesn't matter for the most cases but perf kvm.  If users
> need to set the bit, they can still use :H modifier.  For vPMU pass-
> through or Apple M1, it'd add the exclude_guest during the fallback
> logic.
> 
> Also the kernel feature detection logic should be separated from the
> exclude bit tests since it depends on the PMU implementation rather
> than the core kernel features.  So I changed it to use a software
> event for the detection and factor out some hw-specific checks.
> 
> The code is available at 'perf/exclude-v4' branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 

Looks like you need to allow for :H in the perf stat test on M1 now:

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 5a2ca2bcf94d..77cb95859649 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -161,7 +161,7 @@ test_hybrid() {
    fi

    # Run default Perf stat
-  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles 
" | wc -l)
+  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles 
|  cycles:H  " | wc -l)

    if [ "$pmus" -ne "$cycles_events" ]
    then

Other than that:

Reviewed-by: James Clark <james.clark@linaro.org>

> Namhyung Kim (8):
>    perf tools: Add fallback for exclude_guest
>    perf tools: Don't set attr.exclude_guest by default
>    perf tools: Simplify evsel__add_modifier()
>    perf tools: Do not set exclude_guest for precise_ip
>    perf tools: Detect missing kernel features properly
>    perf tools: Move x86__is_amd_cpu() to util/env.c
>    perf tools: Check fallback error and order
>    perf record: Just use "cycles:P" as the default event
> 
>   tools/perf/arch/x86/util/Build              |   1 -
>   tools/perf/arch/x86/util/env.c              |  19 -
>   tools/perf/arch/x86/util/env.h              |   7 -
>   tools/perf/arch/x86/util/pmu.c              |   2 +-
>   tools/perf/builtin-kvm.c                    |   1 +
>   tools/perf/builtin-record.c                 |   4 +-
>   tools/perf/builtin-stat.c                   |  18 +-
>   tools/perf/dlfilters/dlfilter-test-api-v0.c |   2 +-
>   tools/perf/dlfilters/dlfilter-test-api-v2.c |   2 +-
>   tools/perf/tests/attr/test-record-dummy-C0  |   2 +-
>   tools/perf/tests/parse-events.c             |  30 +-
>   tools/perf/util/env.c                       |  24 ++
>   tools/perf/util/env.h                       |   4 +
>   tools/perf/util/evsel.c                     | 394 ++++++++++++++------
>   tools/perf/util/evsel.h                     |   1 -
>   tools/perf/util/parse-events.c              |   6 +-
>   tools/perf/util/util.c                      |  10 +-
>   tools/perf/util/util.h                      |   3 +
>   18 files changed, 364 insertions(+), 166 deletions(-)
>   delete mode 100644 tools/perf/arch/x86/util/env.c
>   delete mode 100644 tools/perf/arch/x86/util/env.h
> 

