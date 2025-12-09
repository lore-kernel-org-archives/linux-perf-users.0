Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD16328B47
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765284950; cv=none; b=Dslg0xp9jtaYlAjCBH7KTjj7CIYg4GKy4KXZDjg9fsPeAx2UmjQqEHy1VvcQYvRUSiaaUpmIkSzE7hC9/msyFBo4Ef2YOQKmxzzJEklf+fuslS5ZBApuf1oY5ChDfWbkktTfWxsUT60Okpinh5+zOuortk+ISJx8XyogYHzwnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765284950; c=relaxed/simple;
	bh=bkIDfM4SVFJY3Ktk9wE5L7DRDeXwMlUVCTaF/ec4Cmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OulzjWKvKNkx9tzDkiweomJmQa9jgYPyHCD5PASnQHbVI891TL3wzau5sud7qZKjtFwE2Yxar+lXlxjv9/MKZxPSwdQvP0RgzJe6culK3cgMD1729mOncfsq3RV12cuR57t2yLouDf87ZnuPMRH5qxReS34qjW2BYRE+0JbqiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YY+Yh64D; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YY+Yh64D"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b47f662a0so3309049f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765284947; x=1765889747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbbAdtIdBbswWFM/AO9Gj8SRgHiVFnbhJARwIjPvjFQ=;
        b=YY+Yh64DPw4LVDc3MsRpdEpMlXTUA6+a9spztrgwhy/fGALgN/usabrJdLlqa0ukyA
         rcUw2jtZqiWjIgcddsY26PipMEawiTydjKDj2NZN75dsIlFc9jwOpWpNs4YQpZMIAYh0
         f6d4qQOtmmFsopvCisHdDWCcoCXKOsDhSXBiUYTNYHQIG+DxEvRiGlNghovlU8RFGbeh
         ahSNMIdLgWI9+DVb8ozb/y80NmICg8cSMuUpoOoNlqxPxepQ9ExtNbJXx8HUEHuSHeaI
         YZoNIy7hYk//Cai5Rfa051dUCs8roP0Mck4ZCmpgIWh8PWOfV99Xi0GXHHzJxun0Y3LY
         zv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765284947; x=1765889747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbbAdtIdBbswWFM/AO9Gj8SRgHiVFnbhJARwIjPvjFQ=;
        b=xKz4DMQjnxtNhjJZlO07FFWheS5uQIm8R2ylH41xVdadto6Q1iELrP6foV+7HHX4IP
         Jvn9vcNGtQuFFKmALzyppue2GHK3CUZW3QoXxuTsIOTDa0RF2TU0nFPxRb+D6uNhAr75
         kJbs6JKYyYQtv+ikzhweD5AoYsRFZRIhlhYH0mfh0icQsQHerGvd6u5W8vtImtSSmdEt
         gug8pY0CyBV8o9nRG/LOXpsHrz9c4peuIc3+UK6vfYSCPn/f5dSZGNY4H2L3CKx9NQV0
         SU2eV5anjMWcUzEo1TmXnhsNycsKYpLlMpG2ro+EeXKE5F/qKFaBN8bl9gN/xLwvEBqJ
         znww==
X-Forwarded-Encrypted: i=1; AJvYcCVldhu35KlaqV/Oz0QWKwXDaKUdS8KTTzsrP6Tj7lJteVjeWyizGUeE9u5d/heSM+EuFGrJKDxPRNtD3wH0s1dA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0H+pG1lh6w2p9yN/4U2UpC+v8tmHx4RncQSdS9GGvYEGzutL
	JW2nfEJJHvIEmmtoVwiBOEVJKRrwf+dvYYKs7wUR4uFRy4LtySXcGgLArvq5aRpcEVc=
X-Gm-Gg: ASbGncuHzZZSZcrbDw3rGVdV9pK+1Wa0y28dQy/mTvNaqKpYDaxZYOex7vO8LeM2pCv
	WUrUwR0BU0NzCDIrQ92vDLXn4rp+ulGgRSRcqcgpP+R92nJvbO/idGMpRTlFzb7dwNjwbk0caKB
	7RuRk86MYMbSmgrfA83bVWOHIrZJpgalUygvwMC0AQ9F0YPF2BEd1Ch0IvXZTVPtUZVGRxkgOzf
	5EouYrNmyNUo7owNXy/crBzcKZTDMzJB+9Y8Xcyz62g13c8uPFtlSCEjBe+sTdMjy/xCTMNz8Ns
	BpisziEWToyLZ8psEVGr5/yPBnAnIU/Z5liva6vSfR2wvLVR8yFGK/tL8hD6OXyMosg/8gTZJK0
	B/g2TLK3KC2jiOzNnyv/jt2/J11CcnGs5FMFxEsl47zT2giFap8khAPSHh9i8st3XpQob4tCt66
	DtKtipFX1pbrpp2IeM
X-Google-Smtp-Source: AGHT+IGVMz50w+3JuXVuVCo1dDhHydxp54sFgLNskm+CNWPVD6GgXHByjmJy/xVgvEpRQJVrN5d49Q==
X-Received: by 2002:a05:6000:615:b0:42b:2db2:159f with SMTP id ffacd0b85a97d-42fa08306edmr1934939f8f.12.1765284946693;
        Tue, 09 Dec 2025 04:55:46 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d22249esm31181185f8f.25.2025.12.09.04.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 04:55:46 -0800 (PST)
Message-ID: <f08a244f-864f-4e68-b448-c17ec9ff89b2@linaro.org>
Date: Tue, 9 Dec 2025 12:55:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf tools: Add the legacy-cache.json to .gitignore
To: Haiyue Wang <haiyuewa@163.com>, linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
References: <20251208021524.10101-1-haiyuewa@163.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251208021524.10101-1-haiyuewa@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/12/2025 2:15 am, Haiyue Wang wrote:
> The commit 0012e0fa221b ("perf jevents: Add legacy-hardware and legacy-cache json")
> will auto-generate: "pmu-events/arch/common/common/legacy-cache.json".
> 
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> ---
>   tools/perf/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index b64302a76144..5c59f954f52a 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -36,6 +36,7 @@ config.mak.autogen
>   util/intel-pt-decoder/inat-tables.c
>   arch/*/include/generated/
>   trace/beauty/generated/
> +pmu-events/arch/common/common/legacy-cache.json
>   pmu-events/pmu-events.c
>   pmu-events/jevents
>   pmu-events/metric_test.log

Reviewed-by: James Clark <james.clark@linaro.org>

