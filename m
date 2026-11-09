Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219629;
	b=aILWUhQnYA/Jp4OZ9wQXSxqAFb8rk2FQMiLEDmSnetol59KFM0l6NIadqSrTgzOqQleb
	 KuK5i/cpHjbRlTuT8Ho9TK2zffMGe++hxNth5dzfmLPcqgA3RV+B03GDa1mX9JpMcrSGJ
	 wWKNH6DR5i52xQphO3+PV7ZuNYTjSo5RxhLp58djYERdTf0NKYj+eH571jPWKfthouA3A
	 /s32Co+nznhnU7WWD1pbZe4LPAOVwHCPTkps35/TM04r4Zc+zUgBLKT4a4NEpL6b771Lh
	 k3UjE4AwoNz0RceVIWgmQvjLE3i0MdtYXTiSOeJiPBWzchd40AELqrwTEQ13MMkeZoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GyubhaEOLN7D/19FkpOmekZzLJ5vhZuDJz1CV5g+qx4=;
	b=tAv2w9YpHQq1oV3tM7p9AcBjWYxDq+MtPe0hYo0KFkcWq+NpS+pkSR+pSq1nFjC0ZAGp
	 Xwg27caElSdsOyCbOhxRVxgwE/su6XPYXLudko7bFZZGP94tFVnG2MbuKAxW53TLKtiEw
	 TMqhA5Hh3n1IAXkp43V29bSN3qcgpbLn2kekbyztdvqiPDAY9k8NI6kfvF+YFV04i9Wrk
	 XWueiUX72qGWrtCXnC7ps+8S5A7wWmuVcXQBcIN+ghxTI8OrJ0Gfz9zpUEOwm9NxxDwV8
	 B9fFOG6TuXlTg+TMcTLXgKBlBxOFg+553+u2WsnVRLiKIelLU56kMSCkAqVjuKzR++g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oUdqn1wr;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF1606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82DF1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oUdqn1wr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so6660425e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 02:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794219627; x=1794824427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GyubhaEOLN7D/19FkpOmekZzLJ5vhZuDJz1CV5g+qx4=;
        b=oUdqn1wre8mVL4F1FKrBpaW2pDONFwTPsqAAEbdpGfnr6xV5ynF1og7mYCVWUWHijL
         BGvXrc6T2vYgKiPWzB5OmDhZevpcK0TChKgiaZbF8eY9U2nYtHdhDC1qUmOgj3OON34z
         +fYWuENG9lvsqpeSsda7PtsR0gdNzM2+NuGSa8vkpQd0fte45F7UTfh/N/BZK3kjs8z4
         3cH56A9eOS6o5J+YzuAC0vaY52ZjcAbkavCVdumFtz5MX16CybP+M4Vyx3pc+rC9Eo27
         ZesOKQO+FOIZZyh9NeVXEqeHSKg/RgSHCeHPEIuywhM3vC4McmyR3XhM/YSF0LRGRppV
         3Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219627; x=1794824427;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GyubhaEOLN7D/19FkpOmekZzLJ5vhZuDJz1CV5g+qx4=;
        b=txOMvhpYFqNl7cLVQna7JZx0MtQQQOWbYN2v2tr9TAQkp+sRKIFJrfm1F9UyZM/6dZ
         Hy8hXueULZFDemjbs9iQLIVfnnrgtSZ6A6zcunZ8wnx2bRlj8ewsZMy1cy/DqhFp+tP0
         L+lhF73CmX9cEWp3n7jCE6S6o21x3gIZUcaB3qzVl5f1xk1gRRYHQNX766SB4A56A5LF
         2WJ4ESK7iOmRHa41gqEr5O+VtHE1PYpkIBg0WPaGTF5aYBkke9cr7ZVrt7Lmv9x2qXuL
         3cIjMjwH0MA62dq7TC7kJ3hSKwOkaTnAc4E+6aKBZzAqJqW0rspfw2faOhSwmcGzZe9O
         LgiA==
X-Forwarded-Encrypted: i=1; AL+hErF3nCViClVV3ss6YqQ1RDZ4oF1uBKXNw7lGjbr0kibeH7KxHICT7fFTWSe4k8B+GvsHD6ZECXnfxPjpg4dkRRdu@vger.kernel.org
X-Gm-Message-State: APuU4Z9LA/Zya6Srbfwcwv86qUz1N7lbOiHVuRuj12KBAvN4mnIEcVtu
	dPo/C2EJ6xJYMKBDafRdVDkvckCsO48nJU7FCWzW1hUPBOEcdf9V4aeGpbNrncrG0Vg=
X-Gm-Gg: AYBFou26OPprj5QX9lAq3uCuGnHvkTwXaRJdcQ+d7V0dSvqgpR7vde8UAZmo9rEcDTY
	hUs974y9XmDGKOmt18Jqz5vqVWr1v/rQIxCXIudAdwZtdiq34yFLtGv3XR5U45M1K4D0ohT+ltV
	vrVKpmOPq8H+eeH8SCBEJ6fr6SJVzP0WQAu201etttOrOd4k165Fywrie9E6gipsTWAqDPPJqmi
	W47CGkyPAi8p/i+PJNMWo1fbGg4xvE+LssXAnd/SR6xzcVxyEc4RHBNsE0EIl625zWN+f/vfGrc
	mdpq1xMwiCs0+Xuo89RVqlIRuhCP2JBaW5byKzE8ud12j3fg0NQ3yNIwOtYuPMoG51hly/zioOp
	01gI4vcdLQ2TKrh7C+JwERjuKZQ6ND5/SrQBarKOFl2tqX84hZq4PxPHr59JG9nPTm36WfdOItd
	vljlFTWyiB3qxKKiCFUz68DFQJBUzjjAI9qZOtiX6hh/93k8vjpuITkJBX4qdKiuCr78rmeTTbx
	w0U+XQBHnXnd9kky7uzO+L1hNCeSbc8sgH0XLpAw5bY9EGe8712ev2vB0ORjFu82NesX2eVN7ZM
	ak7dpJPeO7HQFRQZT1l9T4t5fHYHcGk4C8lMzAEAO/KIC2E8hh7pFg==
X-Received: by 2002:a05:600c:8b45:b0:4a4:4d57:8462 with SMTP id 5b1f17b1804b1-4b963c8ea4emr61122485e9.24.1794219626867;
        Mon, 09 Nov 2026 02:20:26 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495974660cfsm9316703f8f.38.2026.11.09.02.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:20:26 -0800 (PST)
Message-ID: <5d77f0ed-e175-47f6-af0a-050e0bbc66c7@linaro.org>
Date: Mon, 9 Nov 2026 10:20:25 +0000
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
Subject: Re: [PATCH] perf vendor events arm64: Fix typos in event descriptions
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
 John Garry <john.garry@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
References: <20261108184654.3811267-1-takano32@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261108184654.3811267-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/11/2026 18:46, TAKANO Mitsuhiro wrote:
> Six entries in common-and-microarch.json spell Statistical as "Statisical"
> (the SAMPLE_FEED_* events), and one entry in the Fujitsu a64fx table, the
> L2HWPF_STREAM_PF event, spells prefetcher as "prefecher" in both its
> BriefDescription and its PublicDescription.
> 
> The SAMPLE_FEED_* events are inherited through ArchStdEvent by the
> neoverse-n3, neoverse-v3 and t410 tables, so the misspelling reaches those
> three generated tables.  The a64fx pair appears once, because the long
> description is dropped when it equals the brief one.
> 
> Spell the words correctly.  Event names, codes and expressions are
> unchanged.
> 
> Written with Hermes Agent, an LLM assistant.  Running jevents.py for arm64
> before and after this change removes 12 occurrences of "Statisical" and the
> one "prefecher" from the generated string table; perf was not rebuilt.
> 
> Fixes: 994256a79867 ("perf vendor events arm64: Add N3 events/metrics")
> Fixes: 5497b23e870c ("perf vendor events arm64: Add Fujitsu A64FX pmu event")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
>   .../pmu-events/arch/arm64/common-and-microarch.json  | 12 ++++++------
>   .../pmu-events/arch/arm64/fujitsu/a64fx/other.json   |  4 ++--
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> index 144325d87be4..c61d6c0ceb4f 100644
> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> @@ -1340,32 +1340,32 @@
>       {
>           "EventCode": "0x812A",
>           "EventName": "SAMPLE_FEED_BR",
> -        "BriefDescription": "Statisical Profiling sample taken, branch"
> +        "BriefDescription": "Statistical Profiling sample taken, branch"
>       },
>       {
>           "EventCode": "0x812B",
>           "EventName": "SAMPLE_FEED_LD",
> -        "BriefDescription": "Statisical Profiling sample taken, load"
> +        "BriefDescription": "Statistical Profiling sample taken, load"
>       },
>       {
>           "EventCode": "0x812C",
>           "EventName": "SAMPLE_FEED_ST",
> -        "BriefDescription": "Statisical Profiling sample taken, store"
> +        "BriefDescription": "Statistical Profiling sample taken, store"
>       },
>       {
>           "EventCode": "0x812D",
>           "EventName": "SAMPLE_FEED_OP",
> -        "BriefDescription": "Statisical Profiling sample taken, matching operation type"
> +        "BriefDescription": "Statistical Profiling sample taken, matching operation type"
>       },
>       {
>           "EventCode": "0x812E",
>           "EventName": "SAMPLE_FEED_EVENT",
> -        "BriefDescription": "Statisical Profiling sample taken, matching events"
> +        "BriefDescription": "Statistical Profiling sample taken, matching events"
>       },
>       {
>           "EventCode": "0x812F",
>           "EventName": "SAMPLE_FEED_LAT",
> -        "BriefDescription": "Statisical Profiling sample taken, exceeding minimum latency"
> +        "BriefDescription": "Statistical Profiling sample taken, exceeding minimum latency"
>       },
>       {
>           "EventCode": "0x8130",
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
> index 10c823ac26cc..6fa2936e427d 100644
> --- a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
> @@ -162,10 +162,10 @@
>       "BriefDescription": "This event counts non-allocation type prefetch injection requests to L1D cache generated by hardware prefetcher."
>     },
>     {
> -    "PublicDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefecher.",
> +    "PublicDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefetcher.",
>       "EventCode": "0x233",
>       "EventName": "L2HWPF_STREAM_PF",
> -    "BriefDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefecher."
> +    "BriefDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefetcher."
>     },
>     {
>       "PublicDescription": "This event counts allocation type prefetch injection requests to L2 cache generated by hardware prefetcher.",
> 
> base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee

Reviewed-by: James Clark <james.clark@linaro.org>

