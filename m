Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0B2777FD;
	Fri, 18 Apr 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744982388; cv=none; b=idxGN/BaSE+muEZwizniHnI1FIIfuotYF3SyYkNjnMlq//Bx18Zrc/RpL1F4Q1JS5fxfkyjB5WLX5mZs9XC1+MDgbX/MuXs3kqyNLRd8qco4W7mwUuyXZ7N82qdEjgN0UDE+BR2tavK9l/1gH/vG9mG0/KRMAuAl/50yAQxcYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744982388; c=relaxed/simple;
	bh=4xB8IL7W/UCAtzyc6w+BFktaW/NvD3ELXCjHQtlKos8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjErZtnJYqo4BkfBbOuBdg4iCSMZEQ5oQyOnuNJGtbpE4K+HEQyU/Nho4A2EkeynY6OxcqCnIhoc15xsYh7CPOsClkMePkmtrvGSkISpPmQ7eYT+y5oPmi52uxo0yjwqwKXxtPofvEluG3OI1ozy3zDpLxbdvD/5peTMmKXSJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTZFf/SP; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTZFf/SP"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3085f827538so2339535a91.0;
        Fri, 18 Apr 2025 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744982386; x=1745587186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeTKk+PDVfLUZiKrNtpNsGA7T9VGSsrDOTM5NZFH9mM=;
        b=RTZFf/SPkMxksmvf7yNnyV3AinQ51zS7ReuyMXRf7WJBnYcfRQbIP/Yg6eMSrM9cXh
         1aLOmC4dk3b3gxPE2gLwgzqORJtgciVKmvfEfR6SU3oT2yFP8ed3f58eZIlpBke3KNDO
         M0zSSJIbVoxVXz2/1q82wK3/eW0VfAnzRaYvW7ZLfzRj877GKT7DqYUY2mYxLQCTkfgY
         dFbhMeoRxf4MS0jY+/8QG2kPubVouQV9PVSw9eiytgZ3+bVGEhhxeNGiZka4rciKUVeu
         mOrctII0LdrGVsG2LfZd5ihW+5yg93PyHD3ExUaiel1teodKxEIR8l3BUoDj7z56PCvy
         1veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744982386; x=1745587186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WeTKk+PDVfLUZiKrNtpNsGA7T9VGSsrDOTM5NZFH9mM=;
        b=iIJPpa9HKgH4GIG9u1mQjr8pM7uo3ETvwdwBoTvxq7gIOoTHbCB3bJF4GduhN+5Kax
         lYN9swt2B9icr236hQI9kTs+fBiJrgDhWZwgt2Qn0YOVG6+P8HUfVFxSoQYmNlKRdMkr
         vFycJfzzpYMspeGbwBIqzeOtGGjWLNChYnBBQ1ZrMLTuj8CsVACzFTG0iSl3Fs1qZaDy
         asM989JdnDjxSrEoHUGEYXt70tRGj6cJAdeWyKmr3JtxDiVU3ghjdoDx90VXnUIC1YF5
         R6okCqlqfho42IdtwKcUKu3GFOosOvYyW6EQhENRdtxvJKE0hkynG/MtlqlyX3DvWhe/
         TwLg==
X-Forwarded-Encrypted: i=1; AJvYcCWH+l5WoHjt3Cm2C4oz9G1k/tVyg2vsqGaf2gVQvA345lKEhnq5KVMgW/FbheN/ymxf0FJYua8xDI2GNgk=@vger.kernel.org, AJvYcCWKnYkGzvaI44N8pHBwkm57jrVOvNhHOOCXxIN0cewLl4SolIY/+RkWlO6wrTTrluLeVP86SRYvE9FrajB+pe7bSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwODTmS+b6FJNr+Joi5tQINazIWHx49NmjkDrtSEpCObDeKmJuo
	mBSw7L+orz0OpSQYf97GqNYn1U69TUTMVh9CZog9DRJOgy+zPBli
X-Gm-Gg: ASbGncusQbAay/gF0orOeFwp/LM1T2x7m9n6RLoKmvuhdyOrbFuVnFH+WIOzriNbzhV
	P9Bdgc6yADRPetnE12gWz+tmBnYtNd6gC8Sue7o8NbY7F9wj5Z3A8tkzbjdec30vUapW1CAkTTY
	EMsD6uJSFgWiZ6VUiD/swyVI1iplLJoiMbRzjQzuhBS0zlMFooNWTSQaNTrloGc4+j2Et26Slc/
	uKdxDE47urw5uLEVL824Awi/7Tpvt2/ceJ1hYaOdcpvZme0o0/mr8/CeErkBQmoKHpBRdltVJrG
	rsyQKWffgw7qnfRVuGf+Mp7hxxer+hfafQdzZmfz67yI5ntRWmHoGXblwLTX
X-Google-Smtp-Source: AGHT+IER7DfBsykiv5bTdHVAcEdlSpnFTCJoc6C9/I9MoY9jJj6LiXn9RSOmaUl8dBHOCMAMipetIg==
X-Received: by 2002:a17:90a:c105:b0:2ee:9e06:7db0 with SMTP id 98e67ed59e1d1-3087bb5708bmr4335342a91.11.1744982385870;
        Fri, 18 Apr 2025 06:19:45 -0700 (PDT)
Received: from [192.168.3.3] ([27.38.215.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3085458154esm5004162a91.1.2025.04.18.06.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 06:19:45 -0700 (PDT)
Message-ID: <c25c7155-400e-4cf0-ba56-49759e4c31f5@gmail.com>
Date: Fri, 18 Apr 2025 21:19:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/core: Fix broken throttling when
 max_samples_per_tick=1
To: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org,
 kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 namhyung@kernel.org
References: <20250405141635.243786-1-wangqing7171@gmail.com>
 <20250405141635.243786-3-wangqing7171@gmail.com>
 <20250418090302.GO38216@noisy.programming.kicks-ass.net>
 <ca94f413-4e35-41fd-9554-c80d6e2707ac@gmail.com>
 <20250418131056.GF17910@noisy.programming.kicks-ass.net>
From: Qing Wang <wangqing7171@gmail.com>
In-Reply-To: <20250418131056.GF17910@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you again. This has kick-started my journey of contributing to the 
Linux Kernel community, and it's really awesome.

On 4/18/2025 9:10 PM, Peter Zijlstra wrote:
> I've stomped on it a bit and pushed out to queue/perf/core.
>
> If all looks well, and the robots don't have a fit because I failed to
> compile test the thing, it should eventually make its way into tip.
