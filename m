Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815B2E03E6
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114435; cv=none; b=c0P5tMD0tvAMNqmj778Qav9WNCH/pcpQGJblOTSQ+/GZ4fTgYbG9RKPWsqk++QjAOCIxyk/NMhlhoVTlij+rWqqXLSRUH1o6xouEy720LMvDnm/8pCd6agu4KkT8mypbTLfkifOYrSz2/rLLjP1j0o83JI6LSMoHuUVLlO+Q5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114435; c=relaxed/simple;
	bh=GGSxE1Hu/CmOz5hk4iCIXmBgYdKQBmbj6Z4PL8VgTak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Q8Bnc0usmIsE2J20zOeIWtRD1EsRzwDWmNFwrtZffexOWyOITvQa3qf+kwQiP9OkHsOYNg/+uxO4E1p7PHBF+wSwr8JsKk74l4JNhGr+9slJHKzjr/oJbUbEu3xXTp5H4qSNOeMplODj/FnSDliKnFcyiQp5NZVHwMnyvFJXST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjbLsZrt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjbLsZrt"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455b00339c8so32286535e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753114431; x=1753719231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9BReN8kFhNkqoSb3wxSgjEPGo+Of3+hoptB67zyAW78=;
        b=cjbLsZrt6/2Ve0zjFZmbBZsIfjFeqQw/cid/lH3mmtdqJFhMH0jLZT206f357Z69Rr
         jO7DfJyH73EIiPzhrWInpI0ENkhXy+Gm6mE4ER3pspP5zAouql/Xbk3hwnT0traxZhu2
         Mhgvs7d0HqSX4bwUbvaQOlAcerIeJvoHU5QN63Wq5GxznO3/TnpF4hMlb8zj+A6nU9Du
         wMd4l0CAh5O2Lu0ocfPCP19GX0h2qXBpGZVBQeJFLNCeIcLhRL3JsyaBQB8xU8w0x1Vc
         /YupH4fg+JGERAuWgx4+B8aHU6otjdePAirmuwWjVbHOYPhax0Fskoyhi2qRP3vlX302
         j8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753114431; x=1753719231;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BReN8kFhNkqoSb3wxSgjEPGo+Of3+hoptB67zyAW78=;
        b=H0DKhy9rLEVPFU/hmVNu9GezQv/7cF7mY6xr4ry12Z09HCdfMZUhQj6kWSNw7oXfMg
         EGp0InthI/n8CnqJegOc2zGCRAGWJaK0nu/QYxkEe5AH+kXHM22OrQ4bYrSGFRmBw5SC
         qUOl0DKulX44SQ2DH3QSqm2Z0qZHQf2pmseoT2XEPfj2aVhAlHJaqg87qOCcqH5WJovT
         O1nkTs1AqK2PtzfqQSqdtTk6o35iV+MSjGRQxb2Rk7/qlJHX1F/hSjkUULm3JCFjnqmR
         /7J5hGDAhtRjh9rB2n6W07fuWLLmwSKt9cy43iedE430XbZ32FhJZPr0QAExJ9arQc9V
         h6HA==
X-Forwarded-Encrypted: i=1; AJvYcCXVaK6q/4h9Trj2W4WbFPwggeJJamfeuKS/47jLty9Lmd3hvUvjAr5lSQAQJf9KlpcnDNVGITn1d3ZSPRll3zvE@vger.kernel.org
X-Gm-Message-State: AOJu0YwiOKXGIBfOl9Re9X2NrzY2wRfm7U5G+iCs3hjOc8iaLNnICXVU
	8yZBn0ekXIQU0PrLh7TYpazwqYvJuPJUEt84sAjL+91eXZ20TBoXgos1xhL7ZdIUkMc=
X-Gm-Gg: ASbGncufB5Js8St5uWSSiSpuUUDKOcPR4wfEGeLyV5xQYtiVd8T3rwBaq/Ja2Cge5TN
	ADrwWsYXNF9nJKeXEB9Dvxjn07UaQSolmnVqAvlsd33CNRPudMa+oDSjykJKKiNYRV9UCqPT2KR
	KeJK2tIgdfbOWIVUb2sDslKoLmK+0K+Llw9LU1GwlyoB7N/zJhSKxkZRFoXGLuWhvhSOyWnNpJy
	38Qp3CYlCTy6kNlVAz7lRYPCjjtwzd0ltF/QVBilYk9I3Zj524d/yXCiCtfmKfkIMeutAXoTuzZ
	hl1lwAQRx9Xl8AGDdBXNgEAyTP5f8EYjioeIA35y+/NyaVyIS5RMsKr0t2JbzxlPWKjb2SEVAsN
	jjC9fN+P4T8cOivJF+Ak8DXmIbbetYb9nkrnMqA==
X-Google-Smtp-Source: AGHT+IGS05W2n0Cs3+lkmQ0hawv/FUnUeJ4fwkqkj5rDTWEAfnRp5XtI8zOuQ9QBwRb1AvWITpdyfA==
X-Received: by 2002:adf:9dc3:0:b0:3a4:f918:9db9 with SMTP id ffacd0b85a97d-3b60e5127e4mr14240084f8f.32.1753114431398;
        Mon, 21 Jul 2025 09:13:51 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80731bsm163234685e9.15.2025.07.21.09.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 09:13:50 -0700 (PDT)
Message-ID: <2b51b856-a1c6-4ff1-b336-ae612e5d1cf5@linaro.org>
Date: Mon, 21 Jul 2025 17:13:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/12] CPU mask improvements/fixes particularly for
 hybrid
To: Ian Rogers <irogers@google.com>
References: <20250627192417.1157736-1-irogers@google.com>
Content-Language: en-US
Cc: Thomas Falcon <thomas.falcon@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>,
 Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
 Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>,
 Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
 Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/06/2025 8:24 pm, Ian Rogers wrote:
> On hybrid systems some PMUs apply to all core types, particularly for
> metrics the msr PMU and the tsc event. The metrics often only want the
> values of the counter for their specific core type. These patches
> allow the cpu term in an event to give a PMU name to take the cpumask
> from. For example:
> 
>    $ perf stat -e msr/tsc,cpu=cpu_atom/ ...
> 
> will aggregate the msr/tsc/ value but only for atom cores. In doing
> this problems were identified in how cpumasks are handled by parsing
> and event setup when cpumasks are specified along with a task to
> profile. The event parsing, cpumask evlist propagation code and perf
> stat code are updated accordingly.
> 
> The final result of the patch series is to be able to run:
> ```
> $ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
>   10.1: Basic parsing test                                            : Ok
>   10.2: Parsing without PMU name                                      : Ok
>   10.3: Parsing with PMU name                                         : Ok
> 
>   Performance counter stats for 'perf test -F 10':
> 
>          63,704,975      msr/tsc/
>          47,060,704      msr/tsc,cpu=cpu_core/                        (4.62%)
>          16,640,591      msr/tsc,cpu=cpu_atom/                        (2.18%)
> ```
> 
> This has (further) identified a kernel bug for task events around the
> enabled time being too large leading to invalid scaling (hence the
>   --no-scale in the command line above).
> 
> Ian Rogers (12):
>    perf parse-events: Warn if a cpu term is unsupported by a CPU
>    perf stat: Avoid buffer overflow to the aggregation map
>    perf stat: Don't size aggregation ids from user_requested_cpus
>    perf parse-events: Allow the cpu term to be a PMU
>    perf tool_pmu: Allow num_cpus(_online) to be specific to a cpumask
>    libperf evsel: Rename own_cpus to pmu_cpus
>    libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
>    perf evsel: Use libperf perf_evsel__exit
>    perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
>    perf parse-events: Minor __add_event refactoring
>    perf evsel: Add evsel__open_per_cpu_and_thread
>    perf parse-events: Support user CPUs mixed with threads/processes
> 
>   tools/lib/perf/evlist.c                 | 118 ++++++++++++++++--------
>   tools/lib/perf/evsel.c                  |   9 +-
>   tools/lib/perf/include/internal/evsel.h |   3 +-
>   tools/perf/builtin-stat.c               |   9 +-
>   tools/perf/tests/event_update.c         |   4 +-
>   tools/perf/util/evlist.c                |  15 +--
>   tools/perf/util/evsel.c                 |  55 +++++++++--
>   tools/perf/util/evsel.h                 |   5 +
>   tools/perf/util/expr.c                  |   2 +-
>   tools/perf/util/header.c                |   4 +-
>   tools/perf/util/parse-events.c          | 102 ++++++++++++++------
>   tools/perf/util/pmus.c                  |  29 +++---
>   tools/perf/util/pmus.h                  |   2 +
>   tools/perf/util/stat.c                  |   6 +-
>   tools/perf/util/synthetic-events.c      |   4 +-
>   tools/perf/util/tool_pmu.c              |  56 +++++++++--
>   tools/perf/util/tool_pmu.h              |   2 +-
>   17 files changed, 297 insertions(+), 128 deletions(-)
> 

Tested-by: James Clark <james.clark@linaro.org>

