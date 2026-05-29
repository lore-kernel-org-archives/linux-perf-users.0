Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4C344D83
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066712; cv=none; b=n08cfi/NjrcNIL00rvSWF8aHQtsltSBJSSlsiB4/toxo4DSjf0cL9WuucjxzKGg+9hAul7E8xYLQi98zOtqRwudlUAUI/uYHwf+yXD1xIFFovZ8no9fzzM99adQ1EZdWAYEoU+MlQ8eP8yzLkfaNFm/1DVx3ApKvZ2EbPxSLDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066712; c=relaxed/simple;
	bh=96Axeydsbr/K6eNmKKqadFt3Wwe4S83b7PyJUYG/R3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpX2BHRrg0QrD3J+aTVI2MV5gqRjHzFxXt8/5vYQ0K1J2XXZWFxulIhu9po4k4FofwFFZZXxNUUEkXarz8pSfQIjyZT0SUzKkY7jrxkgBqYgvsl7YC2KNQlZPLU4NRBiutaiBc2IypnXoj2wPtRBTYQAHMKwELwsCXr9t38vaac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wB3Db/wc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wB3Db/wc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4905e190c71so67669535e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780066709; x=1780671509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Is9Os2uASlIKNmi1KYsxRAgrLVybqc2m49x4ZEtQc7w=;
        b=wB3Db/wcwytZ9NNcu07YloMkPwNzKqrBUcocXvLpYRUss+ZoMaMK7ewmIEme35w7Mb
         t17CFkVBIyYbYpZqTdR16X56n0Lortocy1wQ1JRR5kQMG+xIxREPEmk1w4+JqG50v5/n
         4W2j1T0vMvU/9k6u1Vul4SbN109cdirfaZwgafKlkUsBJdvMgr0NfDiMpUpUbUw1PKyA
         /ENmtwOkIYi2Ehjv9j0GzFJWdaSko893b6tFqUoLsziUCNcl6osLNeYMg2tqf7k4suN6
         It3PqC/Vjd7o9X15HNuKvACyz1RheE91WXsu76CaXgxvqI79ijdQ042/GJVnDiH1g8i9
         PV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066709; x=1780671509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Is9Os2uASlIKNmi1KYsxRAgrLVybqc2m49x4ZEtQc7w=;
        b=aoOfuh9pkhhCRtjmcckiTyciZWF7Gv3b7F4Fg9KBCx39oFWjAH5eZkzGQkxWiIuDIW
         qknZCXwwlZh3YFUSxOE7S8Ist5zyIiadrIIPP1cLFXBTL4JNA3QRhb8x4cSV6Rm74pj0
         dnfoDRS3Bfp9Zj9iNGHIQ4cwXkuXd9XZswMk7QrLk6IAAyt09qmZ6UWnPM/a5STIZF04
         NzNrSyu4JMBSD2pGTrVigjugGoXaigw1cihITJqFPqRu7QhDLWiONqoPYAK3hBr/vDeP
         voT7o8FC9ULzHXat4yW05GKVCsJcqWmw+DIeiqBvMU01W1a1AV9n03DHojnjrxLW+dLJ
         O1Gw==
X-Forwarded-Encrypted: i=1; AFNElJ8ppfSwyXmZBh6oQ7Mz+As+MFY3GUjxBY5QT1rjAZdzN9OZ0+MEsoum/w1KqtshkaXflE1MSiUFYRkdOoWARB2q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Wpu6SVwfLvObOO1CSKhTKACZiQKSkRXgjqrStczcGqn5sCVt
	9jFlKMRY92GDvYkwGwbsvYRFIOizRqOq28WHQ6s0Q6RyKkMO8iMVB0rpmVK0aiPqg8I=
X-Gm-Gg: Acq92OHPkNMKj0F0K5WOplnI4S9ZCflgVQ99MlMohmfaFGZAXyDwpnx4Rd82IEPsKat
	GSKZ8rl7iR8YaHS9Xf8J2DRZttQ6gg6O3WB4lpYWFoCb4GgGryciQwcjOk8nm8BPewgZIphUc7w
	9CBjTMEJ2VmwNt5eY0IVDDewV0laazsVX6knWGQK6vI8sJ2BcL4eFh4iZ0Jjpwpvqfg5KaXK6iP
	JwxFJXXjTiPHToP5sjE7xMGCkvadJ06cBXxXRIHDXDd5aZf6FhSHAty537EnDPYmWfSR3vxFswK
	m4frrx7ZQYCq5HfmO0ARD5Zd1ONqWRTyZZtCfQbKax0hHrvX67kPqWpf65xqwMHMeIr3mT/jExv
	2DQxRVKVH/UW79qtnsUGOs6UjBkIFaWevXYP/4GMIqYpqHOxGrhqgnlyu8Zx9LdayZaS3g6yVuP
	aCw13xy84NbOLFdjSwM+CPSrgBJSWK9v6sl0y4sAk=
X-Received: by 2002:a05:600c:8b10:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-490a2900d9dmr387565e9.2.1780066709614;
        Fri, 29 May 2026 07:58:29 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca6575csm79932415e9.4.2026.05.29.07.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 07:58:28 -0700 (PDT)
Message-ID: <7dd351bd-2695-4eb1-a875-c859c9711d72@linaro.org>
Date: Fri, 29 May 2026 15:58:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf cs-etm: Queue context packets for frontend
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Amir Ayupov <aaupov@meta.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org>
 <ahmo6AF3oGOvdzT8@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ahmo6AF3oGOvdzT8@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/05/2026 3:55 pm, Arnaldo Carvalho de Melo wrote:
> On Tue, May 26, 2026 at 12:14:35PM +0100, James Clark wrote:
>> Fix thread tracking when decoding Coresight trace and add a new test for
>> it.
>>
>> Unfortunately the test has to be added as a separate binary like the
>> other existing Coresight workloads which needs a bit of makefile
>> boilerplate. Ideally it would be a builtin Perf test workload, but Perf
>> has a lot of dependencies and generates a lot of trace when starting up
>> which makes tracing tests very slow because all that has to be decoded.
>>
>> Hopefully I can find a generic way to enable Perf events at the
>> beginning of the workload and then I can migrate everything from
>> tools/perf/tests/shell/coresight to Perf test workloads, but that will
>> have to be done as a separate change.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> James, there are some review comments from Sashiko, some looks
> legitimate, wdyt?
> 
> - Arnaldo

Yes, and I'm waiting for Leo to take a look too. There will definitely 
be a v2.

Thanks
James

