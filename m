Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D8258CF7;
	Thu, 14 Aug 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203035; cv=none; b=rkKC8Lv+C07YAkS4vNjeqbEQnZAxa0WsWH1xIyb7mBczBF4MJIWYvJJQzXihKXwpjgsgobQ8V7Och7MVWjk/wYDxrotb1nIHdrLAW64aoFtR56xFbxB0IBJ9FwEexb2X7uJyScBVjSbeaiPVOqFkPP/eGObOCvDpangaxV0D1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203035; c=relaxed/simple;
	bh=pUCA2eTYm8o0pa+luMX7DYe58517nKcKOs6FdCxkmIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1n8D5siB2IDPwWQsmNZR08WlGRuJZuf4Kmu6kn/0s+kxyYaDurQRSMnjIyYaFptatkZ0zGIa42v3BIcahs0qha0vBlb/HaexZ4gIE14pFaaO+pBmlKdUlQhApN4zMpWtQB6vkfoyBbmSIagM8+fRe2Fi0JyZhPBXy8i/NqNHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244581fdfd8so2117535ad.3;
        Thu, 14 Aug 2025 13:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203030; x=1755807830;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WpHv0j9aeid55lLyRqzHbxWvK34fp9Ff0OVpQqjLLo=;
        b=mTLPc8rwdT0kIfZb0pa5aoaXlAlUQAGAzM+Yex54XvveSg6oG6PPs2fftw/WCJXrPJ
         SMf/VvbLsSBqDl+WOnHV5bUUyO1/KFV46cwNRsrbw1jcACjS0i71a2kHg1JhkGvdOQyO
         1r8/Qo9VaF8AN4aQxpBWEdREEFxQvObkCMLty0R7wVcxShkj7HECIKPiyCao7gfdDr/b
         R3DIGdLViEQGzM3hcIgT4VPWyCNuYPnL9K3GDXWpIZKuHEvtMi/PflJm+A3IeRIY2QOj
         CZxFqcPhl0x6qqpn4pLTMgUYEWTQOUlVVAPh+OOxjLHD0q4k2y8Si1FT33ugcYg2M+MB
         /+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVqEPIpcgLgjg0CCIOdXRjZoyc2QKkIyGPG+2A4NCD0qrESvRtXZKO1dHdDBmJToHimK4p8BTWqJoB1ae8=@vger.kernel.org, AJvYcCVwlH4qC65daFt005AD+C/hr0PIM/pDy3ZNuNSahK33eg5YtIEoDOY+B6asLA9XwzON5ySTYsJk9MffA8TxU14qlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvqUtEOIpbSr8qvYi5ZVjnGp7CbrhChL7M7hBMu6NJYnm6OQ2
	KUtUf/hiLYehrustx7gdcp2duZ13uddTDvt2B8S2iQl06E0ghnhoa79i
X-Gm-Gg: ASbGnctdzvO87EP6FYOh3llL5i00ZaY3ty8hKjEt7Em+GMm/np1gEb2xnvfaQ5r+cbM
	PSMFtPArAeq2tDAe43ubqpUyw+6OmqYID12zFARFuhvosgBSTjw/8oijC+3H/2bm5Dg4YG1FCxV
	LMLhmNhWbhZbf/8RUp1F9Az51KFbXuZ4qzyBpR2DqlfAMuRIGKVKpiD4xYav7fjp41rxUuOzAKJ
	Bdd/QFf+eiyq9VlYvFpT1JRUdZLkeDsCu9kORdDcdLKOGVw8X14smnp9BWERnBUYpmCLHJ/u086
	ww2okAEM9waG1kKintWtZw7Vnmtxzif9krrXr2JlkQZCunT0v04C3ymVUS46N6ALGHXrRU9KXjV
	dM4QPPSp2ri6jJ4d794ua1cAzv4UAtJ/2
X-Google-Smtp-Source: AGHT+IGZkLRgquIg8BqkOF8dVsleVvpUt/TPYto81cReQ9ZJpyO3/wRhsiyHLGpAhf6apUoA3ULbGw==
X-Received: by 2002:a17:902:ced2:b0:240:b9c0:bc6f with SMTP id d9443c01a7336-244587dc253mr31116575ad.10.1755203030081;
        Thu, 14 Aug 2025 13:23:50 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976cfdsm356954895ad.101.2025.08.14.13.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 13:23:49 -0700 (PDT)
Message-ID: <a40f008e-d552-4ce2-8279-5a25183b7726@kzalloc.com>
Date: Fri, 15 Aug 2025 05:23:44 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Add test case for event group throttling with
 inactive events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
 Collin Funk <collin.funk1@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250813163251.490451-2-ysk@kzalloc.com>
 <aJ5Bt1q3AZFxxz_U@google.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <aJ5Bt1q3AZFxxz_U@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Namhyung,

Thanks for your reply.

On 8/15/25 5:06 AM, Namhyung Kim wrote:
> Hi Yunseong,
> 
> On Wed, Aug 13, 2025 at 04:32:52PM +0000, Yunseong Kim wrote:
>> A recent UBSAN shift-out-of-bounds report was identified when throttling
>> event groups that included inactive (PERF_EVENT_STATE_OFF) events.
>> This occurred because pmu->start()/stop() could be called on these events,
>> potentially leaving event->hw.idx at -1. This leads to undefined behavior
>> when PMU code later uses this negative index as a shift exponent.
>>
>> The issue need to ensuring perf_event_throttle() and
>> perf_event_unthrottle() skip inactive events entirely.
>>
>> Introduce a new perf test suite, "event group throttle", to verify this
>> fix and prevent regressions.
> 
> Thanks for your work!
> 
> I'm curious what happens if it runs on unfixed kernels.  I suspect this
> should be in the selftest so that it can tie with the kernel fix.

I agree with your point. I believe it's more appropriate for this test to
be included in "kself test" alongside the kernel fix. I'll modify the
test case based on Liang's suggestion.

> By having this in the perf tools test suite, you cannot guarantee if the
> kernel has the fix.  And it may turn the kernel into an unstable state
> easily.

Would it be possible to add this test if it were changed to focus on
a different aspect?

> Thanks,
> Namhyung

Thank you,
Yunseong Kim
