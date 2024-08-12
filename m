Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5B16CD16
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453922; cv=none; b=XhdfNdSmaUix75+e+mgV0Z376iJUXm9aJpT3zi1woYY2nLzMWxpMSm0P/Jpu1ibR8PPBwTkDCW7NJN2OC4iZaCFZITi/aYL+pAOj6iQX9mRemv+cwazytA+njj29/NgPLcI8DkgTK1XGDg0w/PKeD42izuRWBNihavWTInMOa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453922; c=relaxed/simple;
	bh=u1YwTJ0QN6o1AIAnNP0uRQpK9L26jBSTy2c8zGqytDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JEuZRISt9Sme1mKq7WMJ3geK3zq+77NM9uvaTW3JZR1ki1lXIU9cMBzG4RhiL0b7UpAa/mAACdueU8zeWxWAzQV3LzhCDDmttVnsh9aB/QB20DFNcJzjDaUK8URPZoAjXgnAZAW6zaTJRYhT0BTnmbZpbLxVdnwvlw/biX6Byf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+qcUI6L; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+qcUI6L"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so2114331f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723453919; x=1724058719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/dkDOzR/LNy1JwPGO+eblLQszpYlL9hjoNFzaxywG4A=;
        b=T+qcUI6LcG7OBOHpZEcsSTB9/sa8qHLZYyqdRBkk72VoJUawHl4ToH633m1B0kjBvu
         aYsxa2rA/nLe7t2IxsF6IvRBYw5pJZEBvhX6cMx/V3duEEUc6NMd4hS6lqEBOaI2wJk0
         6FiUFAqf5dim+5/Mm9jH6wjqzBQkY44VgrPWA+LzHYgzKeKw1yzE/UVokjtgtjt+mQY3
         h0NxaJ6Oh7IJ/LQCFfj9z3TX6Db//2z2XS7In8ojxGBZcAr7JhyEdfHz5cPEz8Ibv8fg
         R+7R9JmJ1gK3a4FDHoi8+91UR89psUWvg5AgabcDktyKt1hA+t6pELKALqQD7vPKvypB
         89vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453919; x=1724058719;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dkDOzR/LNy1JwPGO+eblLQszpYlL9hjoNFzaxywG4A=;
        b=EFdAHXLSpMUJcCo7XILHYGqDBkKclZpEcxxpG1GLSdhJqNwrkikF7fgLyd/bxeUH5E
         EjJI00Wf33Iaq2ENc8ysTXLGq0Sd3kxtSvhsWqT+gslebfh8zZQgrsIbPWVG6BlVdY6n
         F3It1/9ZzXClb/oi1Uxt1Um4+wMSoPhhMlbNmIlSe7+7EZUayhhj6Yr1X4/G+L6kTYPN
         XRSg/MK7TtJDQW/GQuJBd190o4vsUf5EQhDbEN3O6Z0k1Z9A6VOM8HBtLnn5ysro5qWx
         hdj002JL/wB63/ZGC1WOknlTRZJaYxTI8RttLzqHRyzVuthO0p4gJOcP01GrU8htFjw/
         m6VA==
X-Forwarded-Encrypted: i=1; AJvYcCU6a6PCh616qf5m6Oas50Wsdlwljr3OUrUcgNhgNXbtRgeL3QiTuRw7opxxEdjnhpeTWwgA7kee77v+KLufmlmC421pVOzr7iOsohZSxyF/cg==
X-Gm-Message-State: AOJu0YwCB1Zli5il9xz8MoJ1R93NecppXPOj4kS905Qta0KiGrH+M3We
	7WOZFZ+PT4FcA9sPy36dH+hzCn/lPkusGD7A/4/zo4qMwMrZ56hM/EzoO/kvmNvqLA7i0jnqJ2w
	q
X-Google-Smtp-Source: AGHT+IF5kcpXENxol6rpDJqiXdN3+3deXeOjD5dbPk0vGTABOrF9Nu6EOSCDHs0k0VWKeAyu8WF2WA==
X-Received: by 2002:a05:6000:4b:b0:36b:c126:fe5e with SMTP id ffacd0b85a97d-36d5eb0429emr6725486f8f.30.1723453918673;
        Mon, 12 Aug 2024 02:11:58 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3416sm6895438f8f.100.2024.08.12.02.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:11:57 -0700 (PDT)
Message-ID: <9b27533e-6dc6-4476-8f0b-4497388efde3@linaro.org>
Date: Mon, 12 Aug 2024 10:11:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf docs: Refine the description for the buffer size
To: Leo Yan <leo.yan@arm.com>
References: <20240810161540.2282535-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Govindarajan.Mohandoss@arm.com
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240810161540.2282535-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/08/2024 5:15 pm, Leo Yan wrote:
> Current description for the AUX trace buffer size is misleading. When a
> user specifies the option '-m,512M', it represents a size value in bytes
> (512MiB) but not 512M pages (512M x 4KiB regard to a page of 4KiB).
> 
> Make the document clear that the normal buffer and the AUX tracing
> buffer share the same semantics.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/Documentation/perf-record.txt | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 41e36b4dc765..242223240a08 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -273,10 +273,11 @@ OPTIONS
>   -m::
>   --mmap-pages=::
>   	Number of mmap data pages (must be a power of two) or size
> -	specification with appended unit character - B/K/M/G. The
> -	size is rounded up to have nearest pages power of two value.
> -	Also, by adding a comma, the number of mmap pages for AUX
> -	area tracing can be specified.
> +	specification in bytes with appended unit character - B/K/M/G.
> +	The size is rounded up to the nearest power-of-two page value.
> +	By adding a comma, an additional parameter with the same
> +	semantics used for the normal mmap areas can be specified for
> +	AUX tracing area.
>   
>   -g::
>   	Enables call-graph (stack chain/backtrace) recording for both

The same text is repeated on a few tools, probably makes sense to update 
them all at the same time.

With that change:

Reviewed-by: James Clark <james.clark@linaro.org>
