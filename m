Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F441EF36B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004320; cv=none; b=Hbk6NEq1qEjxXLx84xT/BB7+Nbp7j830OCdzcKa8YUP6v34oBFWGI18/XTUflJl9cDzQzJiXmTE/ju98lUiol0c8k7xH4LSNMMAC7HRJ3ednxRaisMLV3AgaoKZ6SQc5jMyd0bjfiXqfg3LbN4eqP6KbWHXl/0I+Dhirf942cLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004320; c=relaxed/simple;
	bh=6WxClkv5V34a9WmXewzodD17BTwVdhGExvAm2sJTj7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJcPqoE5nLWx3RTLdvHJLt/85WsGK7Ol+Vkg+pbdzd7py0G9oeJOHu9iEb87YW5MXYX9ZEJejKxdY3bLw6FDFtt1nwsfyIRI616Ck4f8l8rpWO1+WHp9I7m0kgxbEbbEq8zamSpQkNAGbkfflAr920Hl/GkZ6Te75V0XkDMdhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=asbDrd48; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="asbDrd48"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so4578035e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760004317; x=1760609117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HW4bKBT8xrSY5GEouSxxGs5MztnP7UN7ylXE6WHX3iw=;
        b=asbDrd48kUpZGud9PqtENnUYOny7hGuDt+gkwN7QqqWSechfnI8T4onumn0a2wnEkH
         3wtqucbC4j4H6hnhDpd5vhaBsDH4jcfo/5zw/c9CtwUzoKcX5ML5r1V81hRNgfq/Lr/o
         hDsFMnoARjhHZDhSLvyZKq4vElmYiJdZhAcr/fWftspK+QiEo/sC4pGZzYRm5pKgnXjY
         XjTnro99Ljws371GyV8CJFX+e+MsM1+JCEJ/bHFVJaMvkNmP9F2VC4fMj0MIB3HCAzCc
         PDt/hAby2qX2D+yQARfH1EJvvtS8mTQKXq/PGnnTWAOsP8eBX07jy+DneX/nolply5vh
         4W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760004317; x=1760609117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW4bKBT8xrSY5GEouSxxGs5MztnP7UN7ylXE6WHX3iw=;
        b=cD5cPjsOvVn1xf2rQzQhvJK3MfJUUKZLa2wxXuXl3/Hb6HGqWoH+TqNsQfjz14riCQ
         bUi4DAtyKQLX7WlGrWQOz9HQ6UE0eblFfdFQV6rqS5Z2j9S8nbidVuRYGRKIuKnsieS0
         jr/1OyFD0+pjcIgHV6W/vMRDwuYQ+O6T4ETDWpUg8BXCmuqnknVv/D7vEFBaHbyL2bF+
         R49y5BC3kPPW1OK0boEregLE+5kAZtckbmkXlEGW5m+Axfwiclhon64YQqJWvE9QfVyC
         xpvB51/yID7byrSN5mK15q/w98KvX/q1Qr2+hYGt6qlNFKPffoiC/gdrX3PdxYgf+SFV
         1kJw==
X-Forwarded-Encrypted: i=1; AJvYcCUaJ9iSTqrMJCctfP1LGdMKY0YH8JFZf8IROPTsBFikG6bpgXA6mDTRuVhoHTqrNzVOVhlP/eEsQOb4Tn7tWskS@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZfDA60JGactViFT4sj4Y97GkdZZs5ZUWEkZYTMrjj7yFzXZK
	Fui9bMeJYzHBROgHLbsEyFvcfzlS1EO0aosy01pv0jk7vmc7Es3FVKNDf29waSSewRI=
X-Gm-Gg: ASbGncsdn28qi8wQ30wPgbqTwnCDltQBe/8l9Ibh88neAMxFTeeYDcHsXqNz3vHlUoC
	+xfaQxx1lnv7dN8X07tV9x88EthZTqeUrWNzU/NbZ5y+qKX9KUupV1us2PswGygS0PxJkcIEVbt
	f/1WFtsTI7oJRhYD/VXdEMLVPhQHVwy0LMJNzIfyWmcbHkRSVlYTFrA3QI4jnaWIvLgYP3ip0cy
	gz9TXmnxqlYXJ9MI74+XdX7OBI3obXurljyQ6KmuOB+V7+y1/xnseZ9rZy8rBqh/77/IPt01XjQ
	vmZcLkf+rtQVQeTJU3q2qX/b6M2+rR8yF9IDjONTW8AJK+tT6/tcC0W2fQQ2ib5Lk40DZTqfe2g
	8D+37wBzYE+LS3XXjgBJU6dYdnBlBNw/65m8I39ET3wj15gKENQGjkLYm
X-Google-Smtp-Source: AGHT+IF2PiR9z/mI1cDdm/wmX6qLTpwvXGJi3FCpoOMyAyMI+2Urjhh7Otn9B8hFvl7zxTCISy0nvA==
X-Received: by 2002:a05:600c:6011:b0:45c:b642:87a6 with SMTP id 5b1f17b1804b1-46fa28bbca1mr56829235e9.0.1760004317095;
        Thu, 09 Oct 2025 03:05:17 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07cbasm78311195e9.7.2025.10.09.03.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 03:05:16 -0700 (PDT)
Message-ID: <953b1861-d990-4c29-9593-3796d50ad435@linaro.org>
Date: Thu, 9 Oct 2025 11:05:15 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/25] perf sort: Support sort ASE and SME
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-22-1150b3c83857@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-22-1150b3c83857@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2025 5:37 pm, Leo Yan wrote:
> Support sort Advance SIMD extension (ASE) and SME.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/sample.h | 9 ++++++---
>   tools/perf/util/sort.c   | 4 ++++
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index fae834144ef42105d08a59704ee75cd4852bbc5a..405876885e1f273c039cb67187c6e5c39c91a612 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -67,12 +67,15 @@ struct aux_sample {
>   };
>   
>   struct simd_flags {
> -	u8	arch:1,	/* architecture (isa) */
> -		pred:2;	/* predication */
> +	u8	arch:  3,	/* architecture (isa) */
> +		pred:  2,	/* predication */
> +		resv:  3;	/* reserved */
>   };
>   
>   /* simd architecture flags */
> -#define SIMD_OP_FLAGS_ARCH_SVE		0x01	/* ARM SVE */
> +#define SIMD_OP_FLAGS_ARCH_SVE		0x01	/* Arm SVE */
> +#define SIMD_OP_FLAGS_ARCH_SME		0x02	/* Arm SME */
> +#define SIMD_OP_FLAGS_ARCH_ASE		0x04	/* Arm Advanced SIMD */

Same comment as the UAPI change. These are exclusive so it can be an 
enum rather than separate bits.

>   
>   /* simd predicate flags */
>   #define SIMD_OP_FLAGS_PRED_PARTIAL	0x01	/* partial predicate */
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f3a565b0e2307a8adf159725f803df5fef0dff83..c7596e9ca089c170988dbc43a00f6973039261cd 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -195,6 +195,10 @@ static const char *hist_entry__get_simd_name(struct simd_flags *simd_flags)
>   
>   	if (arch & SIMD_OP_FLAGS_ARCH_SVE)
>   		return "SVE";
> +	if (arch & SIMD_OP_FLAGS_ARCH_SME)
> +		return "SME";
> +	if (arch & SIMD_OP_FLAGS_ARCH_ASE)
> +		return "ASE";
>   	else
>   		return "n/a";
>   }
> 

