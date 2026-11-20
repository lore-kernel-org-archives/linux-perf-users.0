Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186731;
	b=sbIdYbA9ZI5rkxCLoAvJFOyR/9TzSloG0SSerBU8OLLf7lPd/AUr+Q3nASC7fgVNhq7c
	 +yU98wugM4bGqUAFGcEETbUTlpBupHg918wmlwVVjKvMfhXvX7Gz/65hlQ698LpMf19Ju
	 t8G+RnerMt1fpGbDH+xfeO6Z+rHK3lO0Eyi3qQPefEJdchGOT3Ka+9Vn8PnG5DSLynZjF
	 YqW2Y8tXDR55Oy0dWs9uJppmHRTjJjnHEl+/gaES8jcxf2ooo/Nh3T5F2dI3cx84rU/R2
	 AgJyysof+zNJYmHtbtOTTe2Vc0WmBvf6Klt+u6/WsrpufytsQOeBSVOhGXpDl3gP4VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=emRRxOo38GGoG0OqsYCSeZjP1qZaERfoyqyxbY6jVHU=;
	b=WpFhDy7+FHerRvzWPULhvQJwLi6cjozCQMDRQ7ot5jepwsGhCTvTAMIhqL/S6Fz1ifZS
	 mR0RnGap3NLchtssgyFv6e/xUCkZqI8Xr7iKmwG89erUr02oGJn8DflManVJfOWr/MI5r
	 CUSB5B455Iknlf1OuSQfxulV/f13Lsux/4lpRwR3srq5bbHs8k1+rPobjn6z6VEHKUeRS
	 CXO9AA1vfv9yjmglcN0hm8OdfHssvbagypqqNBVTJrYxqernY6fnBqD9eERjpbAfSYFao
	 YlxN/J1eBLcwivl6JY5Dxc3QG27RzQhSuKvEePmO2K6GNBqyXtXrnLU3LPqXox2U6Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wVe5RQcL;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD760A3813
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37FD760A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wVe5RQcL
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a210470b49so8751955e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 06:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795186729; x=1795791529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=emRRxOo38GGoG0OqsYCSeZjP1qZaERfoyqyxbY6jVHU=;
        b=wVe5RQcLmFXzY9rW2IB9oCDZE5MeZRDz3CICNse/KrxYd9jlEfbH2foeoINglAnu1f
         ZqGMJTwZJO7ZCCXQh/DlW4dJYsip0kcCpNE5BtydGs0/jJ17KNxLOgB2IA/kQ9nFN9Zu
         MUgY/JiIssnAi3XYi0LEk0ameOJI84yzv0t8Nr6KwjIpI6TiSRiDoU9Ms0tQK428935d
         e1/AuEtRimD5e9AeM61r/LFRgBp8Eid7EnUzzzKXXDQqU0X4TBQ2o5XIMOrlFGHsOOYY
         +428/eCMDmUqDX1KuLkV58wBhc4V2W6A7mbUNafcyI8A2DQAdl2ch1aDYuP6TaYIJB7h
         9Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186729; x=1795791529;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=emRRxOo38GGoG0OqsYCSeZjP1qZaERfoyqyxbY6jVHU=;
        b=AOVsIsrKWhVEPk+pvm8HWetRuEtSGIIRHenZ7CvTykUOq4qFTMdDlndxTsinnHw9X1
         Y5TEwfRJaKv6gAt8oCgRCYEFqZ6S3Q988jGX2+HVrU+gVXZTPkrHDBm1LNUQG9ca0aTR
         FD617wg/fr7dV7HQMvmb4mr71iyAQqLq02dAhUIRDQMb7IeAoGyMc+oeaYP5mrY6WdL9
         NVhOuihmEdX5jvDw1gLlSa25HcMtRVHZ3TUwMIlnltG7Y7HvpLsC/9tZ5aj2hYtoCU1W
         byUBBjzZq5ecPka/s4Yy7u81wh5ue9f9+zTilzE+Yv/7wqVo4VPVQ6riKBQva8kdDbzm
         lHuA==
X-Forwarded-Encrypted: i=1; AL+hErFJNyAv7+GPKYBYzHu1b86ikV5FWrK0anGZqr8ITLWI+e6BC5GawMWgTNHMJ4uph6a/cF6JdKOIKfiI3WBCYvnN@vger.kernel.org
X-Gm-Message-State: APuU4Z/3dxu1w6GbOVaJo2FJXrjn5Hkl2RVI8nfbynjNlWefxpJeK5lQ
	CaB4Ssq7j0QpsA4S4llfGAlnTmHqyjFvjFhoi+VfStAqsibQ2ykK4LUws7xJ4dFJd6U=
X-Gm-Gg: AYBFou0rwgnnBdgh3k5lZRUDwfh3TV2T1kn0xAb8zSq/lVi66/UhPLG+E3cBbOtIHKE
	eSpIwJh+GR0taCf989M6x0oZFu+AvtgHXC048gmlhvfj6G03+SkNzrzpzt/EFV9665Y9Cl/ESM7
	9WREbg0dh7Vn9Uh9OoZ2uM8OO1vtI2huA9knZpMuUrEW1dQh3AX6o/Up4joGLWL7Xkpxwus3Zg/
	0EPVDUyahYoh2lwO/9ahYWRGPXHkfBvmcCVVtf0wgT8L1Ror9z1a+W1u6fobKFUUdT8Zp4kkcZr
	sjsDy9FfsOOfIyUSrnjdNOrHGsZ3iARDbJ79tKO/aj4VCQSlSJVr/6YOaFEvXvLuSEjFFK59wKb
	LzwGKXCQE706MVih6mruEu8PeyyC+5wGlzj1HJ6eNscvJ9cRSm3W+j47UGqQ+vlLPKUqxx7Q7BH
	RpLuXiVM/EuO92lj1feRXq9hIEqXjBRrYtzD12jL4XOyRNhXdnBKmCHcZDwvd0ZWWy24/dDBKfQ
	B3lLbNPVQk6MFkP75c9xkBKrij7MzzNhY8fpcr9zfqsrSutGKDwbdCK1dbDWzSyMrfSXiLWeclK
	6Ru1k5BcQAzmjkNAb+pRHvBkoIbitMtTag==
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr71132445e9.12.1795186729437;
        Fri, 20 Nov 2026 06:58:49 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm120356755e9.5.2026.11.20.06.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 06:58:48 -0800 (PST)
Message-ID: <9366b008-37e3-483d-b85f-a850bad4253b@linaro.org>
Date: Fri, 20 Nov 2026 14:58:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] perf jevents: Fail the build on a key the tables
 may not carry
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, John Garry <john.garry@linux.dev>,
 linux-arm-kernel@lists.infradead.org,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Leo Yan <leo.yan@linux.dev>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20261120060931.711483-1-takano32@gmail.com>
 <20261120134252.1036963-1-takano32@gmail.com>
 <20261120134252.1036963-3-takano32@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261120134252.1036963-3-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/11/2026 13:42, TAKANO Mitsuhiro wrote:
> jevents.py takes the fields it wants out of each JSON object by name and
> ignores the rest, so a key that is spelled differently is dropped without
> a word and the object is built without whatever that field held.
> 
> Compare the keys of each object with _valid_keys, the keys a table may
> carry, and fail on anything else.  The generator already names the file it
> was reading and the exception names the keys it did not expect, so the
> build stops with a message that says where to look.
> 
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran the generator on every arch directory, with and without a key the
> tables may not carry.
> 
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
>   tools/perf/pmu-events/jevents.py          | 24 +++++++++++
>   tools/perf/tests/shell/jevents_bad_key.sh | 52 +++++++++++++++++++++++
>   2 files changed, 76 insertions(+)
>   create mode 100755 tools/perf/tests/shell/jevents_bad_key.sh
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 080e04b51b8c..1baeae76349f 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -63,6 +63,27 @@ _json_metric_attributes = [
>   # Attributes that are bools or enum int values, encoded as '0', '1',...
>   _json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg',
>                            'default_show_events']
> +# Keys a table under arch/ may carry.  jevents.py takes the fields it wants by
> +# name and drops the rest without a word, so a key that is spelled differently
> +# is only visible as a field that went missing; a table carrying anything else
> +# is an error.  The list holds the keys jevents.py reads, plus the ones the
> +# tables carry and it does not read: Counter, CountersNumFixed and
> +# CountersNumGeneric (read by nothing) and Experimental (read by metric.py).
> +_valid_keys: Set[str] = {
> +    'AggregationMode', 'AnyThread', 'ArchStdEvent', 'BriefDescription',
> +    'Compat', 'ConfigCode', 'Counter', 'CounterMask',
> +    'CountersNumFixed', 'CountersNumGeneric', 'Data_LA', 'DefaultMetricgroupName',
> +    'DefaultShowEvents', 'Deprecated', 'EdgeDetect', 'EnAllCores',
> +    'EnAllSlices', 'Errata', 'EventCode', 'EventidCode',
> +    'EventName', 'Experimental', 'ExtSel', 'FCMask',
> +    'Filter', 'Invert', 'LegacyCacheCode', 'LegacyConfigCode',
> +    'MetricConstraint', 'MetricExpr', 'MetricGroup', 'MetricgroupNoGroup',
> +    'MetricName', 'MetricThreshold', 'MSRIndex', 'MSRValue',
> +    'NodeType', 'PEBS', 'PerPkg', 'PortMask',
> +    'PublicDescription', 'RdWrMask', 'RetirementLatencyMax', 'RetirementLatencyMean',
> +    'RetirementLatencyMin', 'SampleAfterValue', 'ScaleUnit', 'SliceId',
> +    'ThreadMask', 'UMask', 'Unit',
> +}
>   
>   def file_name_to_table_name(prefix: str, parents: Sequence[str],
>                               dirname: str) -> str:
> @@ -196,6 +217,9 @@ class JsonEvent:
>     def __init__(self, jd: dict):
>       """Constructor passed the dictionary of parsed json values."""
>   
> +    if extra := set(jd) - _valid_keys:
> +      raise ValueError(f'Unknown keys: {sorted(extra)}')
> +
>       def llx(x: int) -> str:
>         """Convert an int to a string similar to a printf modifier of %#llx."""
>         return str(x) if x >= 0 and x < 10 else hex(x)
> diff --git a/tools/perf/tests/shell/jevents_bad_key.sh b/tools/perf/tests/shell/jevents_bad_key.sh
> new file mode 100755
> index 000000000000..6084205b5f4d
> --- /dev/null
> +++ b/tools/perf/tests/shell/jevents_bad_key.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Check jevents.py reports unknown keys as errors (no_mlock)
> +#
> +# A key that is spelled differently is dropped without a word, so jevents.py
> +# compares the keys of each object in a table against the keys a table may
> +# carry and fails on anything else.
> +
> +jevents=$(dirname "$0")/../../pmu-events/jevents.py
> +python=${PYTHON:-python3}
> +
> +# An installed perf has the test but not the generator, and a python that is
> +# not there or too old to run it is a skip, not a failure of the check.
> +[ -r "${jevents}" ] || exit 2
> +[ "$("${python}" -c 'import sys; print(sys.version_info >= (3, 9))' 2>/dev/null)" = True ] \
> +  || exit 2
> +
> +tmp=$(mktemp -d) || exit 2
> +trap 'rm -rf "${tmp}"' EXIT HUP INT TERM
> +tables="${tmp}/arch/x86/model"
> +mkdir -p "${tables}" "${tmp}/arch/common"
> +printf '[]\n' > "${tmp}/arch/common/empty.json"
> +printf 'Family-model,Version,Filename,EventType\nGenuineIntel-6-97,v1.0,model,core\n' \
> +  > "${tmp}/arch/x86/mapfile.csv"
> +printf '[{"EventName": "a", "NotAKey": "x"}]\n' > "${tables}/events.json"
> +
> +if "${python}" -B "${jevents}" x86 all "${tmp}/arch" \
> +    "${tmp}/pmu-events.c" "${tmp}/pmu-events-string.c" \
> +    > "${tmp}/out" 2> "${tmp}/err"; then
> +  echo "jevents.py accepted a key it does not read" >&2
> +  exit 1
> +fi
> +
> +# The generator says which file it was reading, and the exception says which
> +# key it did not expect.
> +grep -qF -- "Exception processing" "${tmp}/out" || {
> +  echo "jevents.py failed without naming the file" >&2
> +  cat "${tmp}/out" "${tmp}/err" >&2
> +  exit 1
> +}
> +grep -qF -- "${tables}/events.json" "${tmp}/out" || {
> +  echo "jevents.py failed without naming the path" >&2
> +  cat "${tmp}/out" "${tmp}/err" >&2
> +  exit 1
> +}
> +grep -qF -- "NotAKey" "${tmp}/err" || {
> +  echo "jevents.py failed without naming the key" >&2
> +  cat "${tmp}/out" "${tmp}/err" >&2
> +  exit 1
> +}
> +
> +exit 0

Reviewed-by: James Clark <james.clark@linaro.org>

