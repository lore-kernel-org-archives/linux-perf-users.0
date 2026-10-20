Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506375;
	b=maUH3zTZ3U/efOjTRxbAzmLVnm1H29prd5qVPPxXZWTX5iMQBo3X/W7jftVBlt22SBA8
	 GBQpNkYJkS6szFrAF0iEeWx+9EUtsrnRm/7Cdl4xuQq9agKxYth+3qj3Ix4iYQMKaQqtV
	 QWi9OJTshAR4RgbvtfPIO5UswoHdxOTdZ/Z0azoi60dyie/GvZZt+nFa4Ch2eQCAGLeIg
	 +LSsU42BOjKR8//QzIRnmrEinx7Ay6WPF0/s8RZl8pzS/X8lny+ALTMoHeuCGm/YZfAn3
	 9ngb3baJqQykWqdbXgQvpjlHJvirO64R3c0HMJJ7jP0SOTGdC2P0L2fuKd4PYVGdUNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lKN2Kpy24qYXb++X9M24Ji7pq7TM4o+Umqf1AAgxfzE=;
	b=f2vwnNYs09pLejc6ViuaBpoYZzsNXZ0wJh44sUu6Muy5pRud21pPb41Fh+dlvnziXR3W
	 i3DnBQMVhj9frNspmXT1NskDW3ciQURNyH0IlAXr0MhU18t02jRjjwcNgFhHV78iKIEzR
	 Mewa1yLcM0OpRRgeFQW/k//QqPZXXs5Wc6fczGr85y8kbwDXxjDx42x9RTno8wnnevCWo
	 EajtreDgdwoGnGDPDXovWV1hlzIHOXaBbW3XDsk9M8OMygWyBqmZxxE3LMNEJHCTPAMY6
	 Q81O2X2semiGZsVOlPhPAgnO3bJVOKXuFjAr+UJhDM5sCMI83d6xiQbHPpOYNQbSYdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="m/9U24QS";
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132EC606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 132EC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m/9U24QS
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c43373ae89aso379149666b.3
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792506373; x=1793111173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKN2Kpy24qYXb++X9M24Ji7pq7TM4o+Umqf1AAgxfzE=;
        b=m/9U24QS2Bz/OBc7yLUW7ra9avWJTiDbw2N8OWcBxciX+hOnKDyxTX4KI9hZE4E+mr
         JK1LaV9jQUJ09o6pP6JRKkhbT5jyFX4Z8Zlg3cXiQeeUHlFec5KoYWgdd6jZT2d93WuG
         YxnqFvde23cuE8kQ1070EDs+wtduXbpSNpLE9kvNPHZ9TXAnEENbFp1+a79wLY3p5N/1
         OcdtFrR40UO1342c69sfjiSkLRmshc9dutjX/u7f4Ab1dhEk3uA8sRc25K03afHnDJkQ
         INhvsed/UNgSZYhjgC+H4w8CZjVB3cgdUc6lA3pS2IeA9B6vJ6HMUeiwBgEvRjCfX+0Z
         pB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792506373; x=1793111173;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lKN2Kpy24qYXb++X9M24Ji7pq7TM4o+Umqf1AAgxfzE=;
        b=VbXcgRA8eWYQajsmwLwo/mcBvxkgLEutNrqt2UrAix3qf47Ix/aE/NJXd3Rz6uodLN
         mh1W+Osr6gOjshiKkPfOc4B00j74wbRcRJ4thQk5CxB7H3lzg3tNkRofdP+6g4ia9YKH
         KihvoNxkdImy79DSlFKjOmEzgHqK9JPpdbjhEw9vY2CqTG+Up2MJsPFm3HT/qqVYV8re
         IBiDf5NwofgFfjs6KKfUKGE7+uCSKyVcaXP4loXyKHCgansv7ez1s+S9kO9asOP6QHH/
         lTswBXsqmCVVe/MgVpBDOzKTLX+Ds8OD6z7iRBQbksmyz6CyWM2g78d3vseE5GULnLBr
         WytQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwjUZi6bOw1/uD1311zljIarmMc4/6rDCNjc/Z/6gy9XRX3EfxGX6GNhj/AibU46Sgo+zxFzobGCdWSUb7aJrR@vger.kernel.org
X-Gm-Message-State: AFq9FYLDs35mvJld3wt8LUILI6qLwzyXxcQ3tb0+PCOqA6pPeguCNSnS
	5M3XMzpEK5ScHvQ6mCsDX/zb9UnaltP9VV2s7ADqBJeVGmQBXGpVr/9fgwqqJdqv0Tw=
X-Gm-Gg: AYBFou0za3rO+PRN7zS1qeNhB+0DWLMKIhKToMvyTOX+k4ZAk3+x8TBcZU+n/OREPrv
	xPrn2FND4OWQEeyiR94ZI1p1nJBtutifjjr7hFQyGC+3WvDsQMgc0gvyRAwCXm/WJSnbsdq8OVI
	zsqbWhzAhGYllK8JK77optTKso8tB2TTH4uen0sbeJJbXY+OgBt/JAbjX7UI9BrMhWC0vJhwH49
	Tzuxa9ddrvRMp93GgUpuxklKF9iKHNcTzw3j44aOceOEdpGdB38JkE++6MiSkeFyAi/Z6AGgotE
	CxqoEy2SUBDiCGT2cuF5KHDQKig1Orpiw++0Yc+nWXz4qayOVRlTJBpbAlaPqJH0YOR0m8PBIXk
	vHkiMgIsq+wwdSmBIZ9KRmvyATGYgvH0e7TRtyRmAT7bnkNYVqqi2sWIxuO9zQRJ0sYsPahlQAg
	vzjjzfLxmTJLparKoP1m8RelHCCI+afdu8APDAbU13/PiIaKrfLiOkUxPcyaQ4VcWuti7wV0kLR
	1D2
X-Received: by 2002:a17:906:f5a8:b0:c38:ee33:2931 with SMTP id a640c23a62f3a-c419f709659mr789055466b.37.1792506372574;
        Tue, 20 Oct 2026 07:26:12 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d810035sm6911288f8f.13.2026.10.20.07.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:26:12 -0700 (PDT)
Message-ID: <52dc152f-5417-4af4-b084-5ca5f821a6f4@linaro.org>
Date: Tue, 20 Oct 2026 15:26:10 +0100
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
Subject: Re: [PATCH 25/25] Documentation: coresight: Document AUX sample
 decoding
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
 <20260915-arm_cs_support_aux_sample-v1-25-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-25-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:49, Leo Yan wrote:
> Describe recording AUX trace in PMU samples and generating callchains
> and branch stacks with --itrace=G and --itrace=L.
> 
> Explain the default decoding behavior, preservation of recorded stacks,
> context ID requirements and decoding limitations.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   Documentation/trace/coresight/coresight-perf.rst | 39 ++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
> index c0c82b3d26ea88dad7143afdb047c4d8f502b4a6..59eda2a5b6473ed1cb6bade5d281a12bdde76bb0 100644
> --- a/Documentation/trace/coresight/coresight-perf.rst
> +++ b/Documentation/trace/coresight/coresight-perf.rst
> @@ -171,6 +171,45 @@ no branch history at all, for example samples from a thread that was never
>   traced, or samples recorded before the first or after the last trace window.
>   It is built and installed with perf's other dlfilters.
>   
> +Decode branch stack and callchain from AUX samples
> +--------------------------------------------------
> +
> +With a kernel that supports CoreSight AUX sampling, record an AUX trace
> +window inside each cycle sample::
> +
> +  perf record --aux-sample=8192 -e '{cs_etm//u,cycles/period=100003/u}' \
> +        -- ./workload
> +  perf script --itrace=G16L64 -F comm,pid,tid,cpu,event,ip,brstack
> +
> +``G16`` adds a reconstructed callchain and ``L64`` adds up to 64 branches.
> +Either option can be used alone. Existing callchains and branch stacks are
> +preserved. Without an explicit ``--itrace`` option, both are enabled for AUX
> +samples. Decoded history is available in ``perf script`` and ``perf report``.
> +
> +AUX sampling supports unformatted, per-CPU sink (TRBE) trace. Each sample

Minor nit, but "per-CPU" in this context might be confusing for users. I 
know we've used "percpu_sink" in the driver (unrelated, but maybe 
"single_source" would be better there anyway), but from the point of 
view of userspace, "per-CPU" and "per-thread" would be related to how 
the event is opened. Which doesn't affect aux sampling.

> +selects its CPU's decoder and starts a fresh trace window. The window already
> +belongs to the sample, so ETM timestamps are not required for attribution.
> +Samples without decodable history receive no reconstructed stack. CPU-wide
> +recordings must enable context IDs to distinguish tasks within a window; the
> +default recording setup enables them.
> +
> +Callchains cover only calls visible in the captured window; callers before
> +the first synchronization point cannot be recovered.
> +
> +When kernel tracing is enabled, AUX samples can include PMU interrupt-handler
> +execution before the trace source is paused. The late-sample helpers trim
> +this using instruction addresses, which may not uniquely identify the sample
> +boundary for kernel samples.
> +
> +Formatted sinks such as ETR are not supported. They can collect trace from
> +sources on multiple CPUs in a shared buffer, mixing execution from unrelated
> +threads into the AUX sample. Context IDs can distinguish these threads, but
> +trace from other CPUs can consume the limited sample window, leaving little
> +history for the sampled thread.

This isn't really an issue if you are only tracing a single process 
regardless of shared sinks. As the aux sampling driver implementation is 
quite tied to the sink, it only makes sense to say we didn't implement 
it because we think the main users only want TRBE, and it's extra 
complexity to do it for ETR. But that doesn't really seem necessary to 
mention here.

TRBE also supports multiple threads anyway, because you haven't put a 
hard limitation on using --per-thread.


> +
> +Guest samples, synthesizing instruction events, and saving reconstructed

I don't think guest is working anyway even without aux sampling. There 
is some structure left in the code for if we ever decide to support it. 
But I don't think we should mention or do anything special for guest in 
relation to aux sampling.

> +callchains with ``perf inject`` are also unsupported.
> +
>   Perf test - Verify kernel and userspace perf CoreSight work
>   -----------------------------------------------------------
>   
> 

