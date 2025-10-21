Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E76302766
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035301; cv=none; b=f3xGPeHym7AVWJVnbXw2QT3fGTIT8mmMLNe7DFDn0r1RyRQVwyG7TSyT8krL18TLNq6sa3E6oArlZaGd7OnQ6a6y+4OfJ3alRLcowWU2+Cwzq5Lg0r/YxVBaaW42fAMqDcyOahSuZCg77nE5znkfjIz5L/BudFXb9jZmv6TuiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035301; c=relaxed/simple;
	bh=bzpOktbYO2tYBTucV155BxXIDpmGKecPOHUkItg8BLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+yPY0PLTg65eu9ouzr8hg5K8+6L8vLpoPV+cXEOrCr0dXAkNIaZ7KV9Vq5w6Z6I2I9Fpve7rqlMX0F/OJr/KPZ+OafKPS85JDpdbDa1ONbVsrQvY0U8iM2Dy79YK+xyMy20QcYeUYq3G3twaDcho8J2TboKZyESZTybNom6P1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TtiB+EBC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtiB+EBC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710665e7deso19181275e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761035298; x=1761640098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b52ybaDxDJQAgpDd+OquVpENnANEDzFwPJdoTxwdyo0=;
        b=TtiB+EBC6khzycTQDXFF0pZrO8uAvItn2dZX9PM0j0+F2KbUXquqVxw5H9YVDcpq2v
         WUIct6ryQjNYskp+AEpX/Z+pNAjOVJ5NhQf4NAzIn+tRAp8zqv7xbgP9N8hW62Wj30bm
         votBplHAmtYbQcl7M9OKGL82Zg3S+gHoiOcXLTZL02G/SUS0aC6df0ehEDm9vMD1EXGy
         O51F96nKYFuZpi2eHqPBGW/Uj5Co2wRXpZ57TMlviNpuPxPljpvnNe9eNGox6WoaSwMC
         SE84YFsb0PAWH+4ovJEOy0j8jmJBJ6aaoanMkVslbwk35vYjAHRQXT5/4CfQKI/Ds50u
         9rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035298; x=1761640098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b52ybaDxDJQAgpDd+OquVpENnANEDzFwPJdoTxwdyo0=;
        b=uBsqApH12gp9NInoD839HSll/TdB1zabPiPDlWV8KmzR1y6r7+4abxuG1OQu7qR0t8
         jjs+KEdBZRkFavIsFPZlFL8CmQqtpF5MrUAu2Mp/ydQh3HhBZ/tAlAnDzHdv9Mkp2Jvf
         R7NegGnYA7yGKzcBEfb3iDx1UjOreeZw7WKcyDmvOO5hmG8GJJMevNVzbYkuuJRhHQ+j
         m8g/Fd1vmxABrbQkhY9xdUJg/aMvfE9sfCQSnGfHXx19iR1Q131yx7JFBFc/d2D80BpG
         +CX47c6iw/4FF63TWhjkxIP1XOMKTh5gQ/j918srBud6u3P9n3OyqkmaM8pVLi8WgEgR
         8RGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFPYtoLd1j9rlm6jjHSY59j4lZxG0Xg6DzPjnjjybE/jIDvQgowUSlagUaJ3RtioljT6QfST80dagK9Mhb15rb@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGmgcdgVUXjl3kxeR13zNJdtdlJgM9upL7UM2G7JLFHiExMw0
	spVsp2A4LoU9sVqfgRLkoyesY4uvCaXOiFLtpib0o+Fln2ZsgvYYXx0lBZi8UgY9ivY=
X-Gm-Gg: ASbGncvlBSwgADlbbYTek9VzCbJJp4OzPQcniJzoqPxfrBdtNQFmMdczgGlsdhi3VNS
	74FJra9lp8cmgH+U3aG/v9YRYf+Sc2OENPSXEvoBB+WwR3WCNzmzIJ9WYeJJd/B1hMXM5gueHhh
	FNWHHNwxGyAlw87SPCvFWaPD53u6k0+sr6RWRmZRgdvqzQJFT0KnEPMvin0fVX6YIfQwNxwsu01
	+E5RSC3f2xwH9+lkfk+wVYBaYU0kyCOTrsBeRYsTWuNBCbCPdRaIoRbnG9xKJc7db59LoyLbmpy
	sINIsU21LmrLRruGIXJ2xMbpwue9LUbg5BeB4OJoy92mP6lHuS7CC2V9E0eS5fo0FmdmQThBj+J
	okRcoKCkI8jMIZuwfl93NjeE7asnRlethZCGF7TZ4+Nx5fPwHTZ+Y+AyZC3IAHVJP/doYfM7QLr
	CxEp1Mcx5R+kcLqTnL
X-Google-Smtp-Source: AGHT+IEf+14wrIR+AkVBMF4pU21DeYP3U2sM85qOJiSGJSUOr3M9WjJk+DnUtO/N8Z7K2WyYMosFog==
X-Received: by 2002:a05:600c:1994:b0:471:a73:9c49 with SMTP id 5b1f17b1804b1-471178745fdmr135759115e9.2.1761035298036;
        Tue, 21 Oct 2025 01:28:18 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5bab52sm18943601f8f.22.2025.10.21.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:28:17 -0700 (PDT)
Message-ID: <de62f91e-b081-4cf5-8052-0b910ccf1b41@linaro.org>
Date: Tue, 21 Oct 2025 09:28:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf jevents: Fix build when there are other json
 files in the tree
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
 <20251020-james-perf-fix-json-find-v1-1-627b938ccf0d@linaro.org>
 <20251020163835.GI281971@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251020163835.GI281971@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/10/2025 5:38 pm, Leo Yan wrote:
> On Mon, Oct 20, 2025 at 05:08:26PM +0100, James Clark wrote:
>> The unquoted glob *.json will expand to a real file if, for example,
>> there is any file in the Perf source ending in .json. This can happen
>> when using tools like Bear and clangd which generate a
>> compile_commands.json file. With the glob already expanded by the shell,
>> the find command will fail to wildcard any real json events files.
>>
>> Fix it by wrapping the star in quotes so it's passed to find rather than
>> the shell.
>>
>> This fixes the following build error (most of the diff output omitted):
>>
>>    $ make V=1 -C tools/perf O=/tmp/perf_build_with_json
>>
>>    TEST    /tmp/perf_build_with_json/pmu-events/empty-pmu-events.log
>>    ...
>>     /* offset=121053 */ "node-access\000legacy cache\000Local memory read accesses\000legacy-cache-config=6\000\00010\000\000\000\000\000"
>>     /* offset=121135 */ "node-misses\000legacy cache\000Local memory read misses\000legacy-cache-config=0x10006\000\00010\000\000\000\000\000"
>>     /* offset=121221 */ "node-miss\000legacy cache\000Local memory read misses\000legacy-cache-config=0x10006\000\00010\000\000\000\000\000"
>>    ...
>>    -       {
>>                    .event_table = { 0, 0 },
>>                    .metric_table = { 0, 0 },
>>            },
>>    make[3]: *** [pmu-events/Build:54: /tmp/perf_build_with_json/pmu-events/empty-pmu-events.log] Error 1
>>
>> Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files to OUTPUT")
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Searched a bit, if without quotes, the wildcard will be expanded by make
> but not by shell.  It makes sense for me to fix it with quotes.
> 

I think it is the shell. The only * expanded by make is file names on 
the right hand side of rules. Either way it only makes a difference to 
the commit message.

> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks for the review.

