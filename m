Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738882BD030
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503183; cv=none; b=lgZZE5X6YDkczuKjlWS4GXv3NcrWHz5DC2gT1TtHtMKWJBBubMN1+v0tmL1dYSdcc6qsQDM94PHW8GsAER0qDQyj5Vv+xvYsPVQ3IyLFxJ+0/ljq3igP2xfrOVpWypJpltoknOh82azHsxNN9ADxeK4+CXTT+5JPRkoV+Vmrkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503183; c=relaxed/simple;
	bh=+GWdI5GaapuuPFkF+1pWn80E7RwfKlyV8xsbbbZwENQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqWq9Ii5GTKlRt04A5bsMkIFkK3wbmxA9p/EdJeMMj9znKt3vBBH8lB2SvFsmOG2dWyi39kxiC7f406cCzPIQ2Eff4cDhIgDL4w3lpzqMTqoVAUHAbkohfihLlNm2VeasGTd420pP2i5+eVlYocI50wpqXr0YJGNvqw+yNkvOhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=riatndP2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riatndP2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b3e03939so8586735e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780503181; x=1781107981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UKULipB408ValDz8ua2CahzCEdZz52u0U+4kqUbz4QE=;
        b=riatndP2zNdhheLMEwL7VGYbzX2Iy7YfvM/aw7VA5Bofg20hjX1FxB5C0BfjvAtQb+
         VghOksLuXAq6U5KKp6YTDoTGrV3rY9QdtU/fyefANqSNBbuGk2Sz3Y6mNOpfyTY3B3rW
         7VNppayma/4m8Q5dLSH8KvFAbRZgs+a9P+DyIm4LTiyOuGUShFyVcCBgaUZ6Aewy6RZu
         aSAI8z3iVVp0YERQvmUtf7N6EJu6mPe5apBzB9RplthQJEtIUyay+uirxjr3p2PC72zF
         e/vO+dWtZXa9DAk8d9wcHTcKK6O3vMZYDLy05oaVG6L7KmA388uvEPQcRNVuP1leW8+o
         8N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780503181; x=1781107981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKULipB408ValDz8ua2CahzCEdZz52u0U+4kqUbz4QE=;
        b=lL4AcVDmW2suGcCdp1PcNgm7C8WnDynT5YYPgyL12je7ZPanPCMnh69enHHciGXjXW
         NK8Oqv/ZZsDhQhhuPV8hP0+m0MImPTQMf2i1vPrATEsNuWsgAUFk0ge24uGm39IrANId
         boFT+6tP86LHP7JgzLHM9lyHHbLixZmzTALrNlZlxqByh2oH8A+NOaru+j9KtT7KEfFq
         yTMM6PfvMBIqTTj5Ic4XPAs456zG5LzlyS6pxVrhc4VVPPQTx8IGnAtvo5kbeh0O9MK1
         oBLhBHJUmNgxLtCw/k9SFwJIcNiecJ4/JDIhg5v9Unnh7qkH6EcXCz90lW0efFhSyWer
         8+Yw==
X-Forwarded-Encrypted: i=1; AFNElJ+dbrMoZa0e/JdqV71kfSzrDnRshFujdWM6A6jm5j0FoiWVrfW9i7ZRzsuFPVKzV2h2nisNsOQF2PwzEXQU6cc+@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOjKAeu+n6JBHD2CBrkv/6tW8oZOmCDP9WqRiDRRdiXUEKGuI
	kNN9sd2hBHEJNQuypAi0l78tHZNoIisCYKOSsCu7K+6GwzjuiCrlx7meCAH+ShjUfCw=
X-Gm-Gg: Acq92OGGIR0xviiFtWk0d70MFvucL4bdoshlhzJyGewsn84R72XoMnlBua8Rt/OIV+N
	pYt4UAi2Tf1E+nuqwx8NbS/L5dCdaUqbvf7Eyt2h6ws0aqFPTdm2FCaoZS8+oEmjrgM9XWM2g80
	AUVUXTgp3p6ve0d4M/toWJm3jg4yyJtyRwQ+yCg3XrEKqrNpcO4rGYuJc4adugj904Sp8unNrxG
	7xdw3rOjSvlTosuJJBpyxIGR3y+5E2bzU7agE196PDlqElCXChxAwbd3FjZ3hufpdXPhMZKQKW2
	wqKVFRbvsyaVUXg/xw4rdTegBUH/Ju8f4Au86MS0yjGqBRtErbOokohSCQTdT0vPDvP5HWrkqc6
	1i/N85ZUDsC12bq8rFr5ap+AoIuMfm3ZVwchdEYsI0bUmthxaaHjyLgcZnDG4j68xS1jazvvqYa
	5HNs8Ke0eji41yegLL5gu1qPuGMMRj091JoJxSPbY=
X-Received: by 2002:a05:600c:810b:b0:490:8b0b:d3b1 with SMTP id 5b1f17b1804b1-490bc4f9846mr622895e9.12.1780503180885;
        Wed, 03 Jun 2026 09:13:00 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a7cb85sm70950515e9.1.2026.06.03.09.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 09:13:00 -0700 (PDT)
Message-ID: <5e29907a-2533-4540-833f-977c5f0fb90b@linaro.org>
Date: Wed, 3 Jun 2026 17:12:59 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/18] perf test: Add named_threads workload
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-9-85b5ce6f55c6@linaro.org>
 <20260603145415.GY101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603145415.GY101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 3:54 pm, Leo Yan wrote:
> On Tue, Jun 02, 2026 at 03:26:51PM +0100, James Clark wrote:
> 
>> +#define DEFINE_THREAD(n)						\
>> +noinline void *named_threads_thread##n(void *arg __maybe_unused)	\
>> +{									\
>> +	pthread_setname_np(pthread_self(), "thread" #n);		\
>> +	for (int i = 0; i < iterations; i++)				\
>> +		named_threads_work *= 3;				\
>> +									\
>> +	return NULL;							\
>> +}
> 
>> +static int named_threads(int argc, const char **argv)
>> +{
>> +	pthread_t threads[MAX_THREADS];
>> +	int nr_threads = 1;
>> +	int err = 0;
>> +
>> +	if (argc > 0)
>> +		nr_threads = atoi(argv[0]);
>> +
>> +	if (nr_threads <= 0 || nr_threads > MAX_THREADS) {
>> +		fprintf(stderr, "Error: num threads must be 1 - %d\n", MAX_THREADS);
>> +		return 1;
>> +	}
>> +
>> +	if (argc > 1)
>> +		iterations = atoi(argv[1]);
>> +
>> +	if (iterations < 0) {
>> +		fprintf(stderr, "Error: iterations must be non-negative\n");
>> +		return 1;
>> +	}
>> +
>> +	for (int i = 0; i < nr_threads; i++) {
>> +		int ret;
>> +
>> +		ret = pthread_create(&threads[i], NULL, thread_fns[i], NULL);
> 
> Just curious this can be simplified to a thread function, like:
> 
>    noinline void *named_thread(void *arg)
>    {
>          char name[16];
> 
>          snprintf(name, sizeof(name), "thread%d", int(arg));
> 
>    	pthread_setname_np(pthread_self(), name);
>          ...
>    	return NULL;
>    }
> 
> Thanks,
> Leo

Only if you don't want to check for symbols as well. I thought if we 
were going to spawn a load of threads and look for thread names we might 
as well check that the symbols match at the same time.

If all of the threads run the same function you can't do that.

