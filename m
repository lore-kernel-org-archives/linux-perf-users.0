Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284E51E421
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919768; cv=none; b=BsRvuLYacbwe+FyiJB2Sy+U3C/eNckou4jJeqAJu2/NQaP6o4qW6geV1rPcMItSwNllzPxCIllvpMR1HrAE2TVDrSNDL9+Zn5q7dneNowlrxVeF3NobzqQGaXi7P/0tJITA+mCtkZwVBMM+j8LuXnQq0QpOgRiB+IFhG8grxstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919768; c=relaxed/simple;
	bh=HFB6DyseJTdbQfG1DZ6MXg0hnr9XmayZmDxutEscNow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pA38dcBaQ6rXm1XV9DTWy/t3gXG8WfjtVufKGn4uONlrD0yDWA3NJy0a+C2pkw1+2A7W9Sxs3tkvAcZLL33T0mN58hTVJjnfQlp6TAO+I1SaoKh4nQogqylV8Zye5Q84d7XufvZ3g9xLFBnsbfMq6X+uEm8WVA0Y3oi+aLGBoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SkTvqIiA; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SkTvqIiA"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6df5e315bd1so2291496eaf.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1791919765; x=1792524565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOxgkNuwHKNgVFVQaM+OBUUFEqO0M0muHBMxUHjrBmQ=;
        b=SkTvqIiA7vr8JdA7bRhOV0Ijo+RNsveUSQpUJqUqmTESqBbZfENP2lD88rRRillW15
         ys2GG5hsB9vHt97BdHz1tW9LWRvwEOUPVKEfgXonYSTYSs4zZ8/h6ww8ZLBIo4CM+1i0
         rTS6kswASnjWNcuXNpBD8nI+kll1UZ7FC7Ka4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919765; x=1792524565;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOxgkNuwHKNgVFVQaM+OBUUFEqO0M0muHBMxUHjrBmQ=;
        b=waoZm73C6ev7GiXrnJ2etW46tPfdXruA/IHQsMDlOo0DFM47GBBORKyVsoa+UUYlGh
         8ckMcO5DndWYxEazCKxKl9L/poRGJS2LFfcLzfC/wseXuvy/c9h/E3mVNyp1vfCAKxUq
         jCAJ/m3dgIu5rCepk98+XSAThVhwpl1g845yUQZrUyYqPb3n75U3Y78FFlIURYJPVaxt
         FoYcLNOZm4YYbj35WQ8ALsre1IiGNyWWNCmA59oV6b3ZffYyOU2liY8XU4Y1dwNE4dk5
         +17xl5av5yC5RFosUXz9jTLpwFBdpRiQ9MGVOAcbHf6aIG77U/EBS33uFxnx9DpZYpnq
         rZ2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzmWnPxe+Oukum1owrmhWf559aP4b9fcEjB2U/P6N0NXyz12Fzh2TTJNqBA0itd8MEImFa0TwC41yVtQ8ob7Iot@vger.kernel.org
X-Gm-Message-State: AFq9FYIgV7nUkvMH8hSTYmNdwrx7oSh3NHDkVT1BAwVCBAGmbTLwJTjU
	ZWO+LNlbTl+Z+P5U2xdPMIQNLqALuceTYCbKDjmT11y0iL2o62pVK4QdMPoArwC8r1c=
X-Gm-Gg: AYBFou2ynILNN8VaA3DJa/3Wv584y7huSOmaAqSMOxNJNEYFpDJzQD+CHj1frUYQawi
	/Zyd/gEGJEiQ+2T9PJ2q8Ghrui64cYOTrjmzlJj0BbzMI+meQispGW+KsDpzwOOVWLflTpYcj35
	fePKWp8NS1OKMbgG/LlEHG23lOGNh2AnggNSfq0/hu1L5O//ZBGTCuYwzGhyYWXMAa/vE5dSYj/
	flIQ6SnJenJoGDE48YKdlU5gCPekUto80OVPdJrHVptzipr4bszV5/DwyzokYr2UsRpe7vd2h2X
	FvmfdnozJ4zegsWvUqLPGvSDCLiaUfJnL5X0DOiYUNfI63wqz4I/Q3C4KrWxgHabOeXBUrZGACZ
	3d/CqaptoUs08i7dHH8/lKbAhV8ftMfX7ctywNY85yUfALswLWwTP1oqV5KUNWOHLarY8iqz82i
	ABgbkKnnB32n2XrK2RAUnvK4/XghF6qa/1QcIdS7X8QTY5fQGIqFWlI3/P9mQFNWwnh4DxriFd2
	Wqmo0ZX
X-Received: by 2002:a05:6820:198a:b0:6ca:3ce1:ed36 with SMTP id 006d021491bc7-6ef100968e7mr11004632eaf.47.1791919765182;
        Tue, 13 Oct 2026 12:29:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfd0b149sm437488fac.18.2026.10.13.12.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 12:29:24 -0700 (PDT)
Message-ID: <08e8e221-4e46-41a1-baa5-bade8ee20730@linuxfoundation.org>
Date: Tue, 13 Oct 2026 13:29:22 -0600
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] tools: build kernel selftests in tools_build
To: Sasha Levin <sashal@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-5-sashal@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261011233647.2454648-5-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/26 17:36, Sasha Levin wrote:
> Add a "Kernel selftests" sub-menu with one entry per selftests directory
> that builds with only a C library and does not write into the source
> tree. Each is built as "make kselftest-all" builds it, with KHDR_INCLUDES
> pointing at the UAPI headers installed in the object tree, but by its own
> make, so the selected ones build in parallel. Selftests whose Makefile
> does not use KHDR_INCLUDES still build against the C library's copy of
> the UAPI headers.
> 
> The selftests do not track header dependencies, so a selftest is built
> again from scratch when its own directory, a header or makefile any
> selftest may share, or a kernel source it includes directly (the vDSO
> test includes the architecture's vDSO code) is newer than its last
> build.

Is there a way you can fold in kselftest_deps.sh run into this
so users know why some tests didn't build. Also we want to make
sure kselftest build doesn't fail if a test fails to build to
keep the current kselftest build behavior.

tools/testing/selftests/kselftest_deps.sh

> 
> Selftests that need libraries beyond the C library, a vmlinux with BTF,
> or a sanitizer runtime are left out for now.

Great. That is good for this round.

thanks,
-- Shuah
