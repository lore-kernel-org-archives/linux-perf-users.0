Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795049900;
	b=gwEtaDVswDSV48/XLAWWnr6vhHKwiaIAjaBljpZYl82yeuPXpebIDWJ+kXW2dvVrHhNs
	 LeqO2o5lxQHnb0zsj1BWagprsGl0shDpaxkp/byhJuXv3QR+JL7Un2i+Dje7e/wkaRAti
	 CCuE9f21dhUJ8X08c3Ep5ARgtYCTD1lk9JyAGOYtC+XdRyhVIVichqZ2EC9y8b24zrPrs
	 13WAcSp5WmE68k9ddrRBjdFdBTpNTl65FKjOGSCmWva+sUHT+J5rtRRvzoQyokyUg/szD
	 xolqisbKNHsKvHtX2KF5y+jtUy7yK5oRQwFkpeTsqEMaP4xHfEbPBhOEjha6hPBZKfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=WmULB5BRRN7myu8YelnTP2kh9LSwow9E6/6HbTV2yCY=;
	b=C5aZPb34fSk48Sycx/yWu771UQDN194jfExbG3X+gX6IUEoahsdLlFeu4GUOtPRSWEG7
	 DeXS7Daca0ACdNl6L+zL5vBEYg/+Y8ft3IKSLbv9LqO/48u+C24acOBqzQtOOMjhS0HGs
	 jV24S82SXKZwbHa1QaAraeVpSZI8vJim9lCL760MH9QcDVCEuVFAMJcUZ89jkzUX/zHNw
	 4N5AEbqowiRpM8zV749ZtiByKIqfjxhcn/IDOvembzNdnGdFAlyecveJn/4haPekNB6xU
	 ItVMDqE9DxQyh6Jf09SCBw60IJ8bc3UVPrEXNp/ZBzWIWwGyX2UTBpcfG41je6dRZnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LghaJhlE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A4606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 00:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 372A4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LghaJhlE
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ae25c9f857so16982251fa.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:58:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795049898; cv=none;
        d=google.com; s=arc-20260327;
        b=Vs6hpvC4tKRO6+/4v8HM4xu4sxWMCNwLsRXpedi7ybFSob3qasU1npE9c3z6FDC9Qf
         pljW+QBS/LOUg2rlZ3f68nRZBxtioIl2DS5TUcA+eBXAmBNTu9o9gcB3YBctNWf86xoR
         RCzNJ6dSemHiU2EQjugptucaCUkpXrkP/dgfkSExyfeZJfSqefch9IEcFZ4Y7VYQCMks
         EJc3DfxZH+81QixQ/fGBt2qihxhvfgk9JTafGL8iEdQbf2oXb0ev1HPLp91QfFDj7dfe
         R4/DOaIYBz3Xm3QrhDfuG7rFXWUm4A3ArmWzvorvcDL2rEoHp8Oz8sWXgfez/Ebifjfd
         xcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WmULB5BRRN7myu8YelnTP2kh9LSwow9E6/6HbTV2yCY=;
        fh=8V/ievEDKWWnOamQIIQII36sa2V7gzyi2FYdkgVXrJg=;
        b=ZX8Y2uwzq8CWJtMVzEBfz87+h+ZCueAAPYcPxhRNyLDRxEHvfQkmXMgtgSo5nKHvu8
         95JC84J4MTnsSb+mn/PJD+XklgoppjOXBF17OKPiqh99l2LTjvkNPDKgPSr0Blgrkonu
         yIEfLZtFk25Lu8D4LM1AZXpz3StXCuqypuz4bqQ9SHE8j7XDF2sXYayp1G2JuOK6lH4M
         21GuoJYC/cXVN+o40jtW60TkReEDsmWdGRtI5KcuMPZCoQqNSnKeLbbzM2b3OdDWAKyj
         t8wVJbOg+0eF7v2yq+dFleezctuTwvac8sbZCdwpC/FyH67nnUz9eauF63AT3iQklhz5
         FqwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049898; x=1795654698; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WmULB5BRRN7myu8YelnTP2kh9LSwow9E6/6HbTV2yCY=;
        b=LghaJhlEIwS0qw8B+AlxxJ2DBn2vU2OykxKk3Qn4cV5W6W6iQuwnKvHNp/Go45CGxN
         jK6iSTJ0bd9WYMjixeIdt6vW0OYMyDcZhUo2R/wE9GJdtnoDWAdUGNI3U3vYVh+6Jzfg
         KSqpJhCVRbVc0c0BOOurlvVbu0xAj48JpVygQm4ZZRiClaBE7ZiUR8U65bMOus1xiwdd
         15O4uOrPY3m68UYV024jQxKo0NlGxWxQVdHkishL5of00rfSsYF0Kn13sItx9Y2bS68Y
         grDweeZ0m7BwVv/2hKyqCGzXJjSXBVkV13D+KzU/GwrNjSQw8eQb1mUhj20isbT3KxBv
         IYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049898; x=1795654698;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WmULB5BRRN7myu8YelnTP2kh9LSwow9E6/6HbTV2yCY=;
        b=U9g9t+MdtnorcugeReHE2t6GjV0AQMhAgRSO8Ac5olVJVT4pEcjpXEFM0H0clpJfhh
         XPskS9dJKQIS7Gu/Bm73DJTwFbmrCXIaWOkYufUW1ko+BoQmc6IUIl/GxsFxObEILvw5
         gnw+GqOURMyphvyElDqImMQ2xYoUcvuGinnjss9AwpUa7u92srjoDBEWq9WmLhH28jZJ
         Bk+mjDPyef4RAVcdkv8wpUZGoxVDBj/v+S3rFMT/2ANiNgVvb61xtKC3oXsxg0ejLhD8
         8D28qu363xuFJjJS7VlUO3m4YH8wLU5JWBtrBQcrx13/kbj3sRO1sKKGmJFh05CApgtc
         3B8w==
X-Forwarded-Encrypted: i=1; AL+hErGSBOksazI8Yeeqdc7kKuwY5Y/P/60IIgDgIJ+hCIj6pSmIdpBa5M/HiniK4SmD/7dMgsrzHYZVrHu2y+HKZGRU@vger.kernel.org
X-Gm-Message-State: APuU4Z+haiduGb6FRPpqMMw/5GROyA7hXOE1tJi9UykmkCLPeXON9dAr
	O13NezThlYEPGHHXpMQXiSXyzeOT9v0ch6FxlJgrRugbjTd+hG67elq4mAHV/29h5b1cYxb2Hck
	R46xkm7w2f8A6yH/a3WQErBE6vRJqh4g=
X-Gm-Gg: AYBFou1I/wFdr7mv92yufihMNs/zxIEN/KB4yjXL7NzvQh1Y9hMSOueIGPmQEvodGUa
	o7VDZFjfTTUZJg62x9BgqRPw4MZi6aicIxofky3EnIL2D+4eP2wrVAscDEV/A1ncuBS4UVw247t
	Mx4HA/nWXOrJxJbCk4EGwJGwfYDDTy6HTj0nvlse+R2V6uIIUosqnVULjGIWAejRp8QK4ezX3Er
	InIDZhAyUaSiyWdhte7kW85spYVv85eF6aEeaQY5xoX/Yz8HJBHV8uEuTVVCtTYCddrQQ37HAqi
	4YfTbvw8qFgrNw+VcxRZ0n7ooDJ842iABVb2IFlNoyZba13jx+KpCtDbJTuhrC98/jTwPCktAIW
	oCQP2mC5X39A5N4rPqiuPK7sIyiAwSNw1H32kCG7qXCNndTrbiTjRflMpG1807SaWD9iNmuRnS4
	DphFaKR93twRP0fNhDAajNcjWQQz//bt40dZrhaHrlVnuYKiSrkvONOrBKWVllntbmhfO598Ut+
	YS4xvVC9SeV3r1iIyH70HeyB18MhdhFm2WcOI7hOzEVh54Xb6bcyZ4DmhqP4sf4qipQQ/ZbFNth
	33JEmhVV+Q==
X-Received: by 2002:a05:651c:1a2c:b0:3ae:68:d07b with SMTP id
 38308e7fff4ca-3ae670cf580mr12208771fa.11.1795049898159; Wed, 18 Nov 2026
 16:58:18 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116081248.21059-1-danjwade95@gmail.com> <20261118104353.GN1813469@noisy.programming.kicks-ass.net>
In-Reply-To: <20261118104353.GN1813469@noisy.programming.kicks-ass.net>
From: Daniel Wade <danjwade95@gmail.com>
Date: Thu, 19 Nov 2026 11:28:05 +1030
X-Gm-Features: AclHuK9RupdcoMxYA3V6rh5w4L2BDyhmtlUMf1cZuVsvFCWEi_9cy1l0uFREU_M
Message-ID: <CAMn7ay_NX9ULF8fYko363U6bM2XzgyT4dkRVBv5CJCM6zQ=neA@mail.gmail.com>
Subject: Re: [PATCH] perf: Reject group leaders detached by CPU hot-unplug
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Kyle Zeng <kylebot@openai.com>, 
	Aditya Chillara <aditya.chillara@oss.qualcomm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Nov 2026 at 21:14, Peter Zijlstra <peterz@infradead.org> wrote:
> It occurs to me that changeing __perf_event_exit_contxt() to use
> DETACH_EXIT | DETACH_GROUP, will also fix things, right?
>
> In that case the STATE_EXIT check from fa091f46c383 will catch it.
>
> Doing this makes the various cases (task-exit, CPU-offline) behave
> similarly.
>
> Does that work for you?


Yep this makes sense. Much cleaner. I will send a v2 doing that.

Although one small difference still: task exit wakes pollers and CPU
offline doesn't. Which probably doesn't matter given they aren't woken
today either.
