Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878157;
	b=evSvCB7r4iFOrEugl737S33e7kOEvZlXtroirxv97h8eEib8CqU2ZFM1D3JsjN/CQKU9
	 aqAkS+mgprljTxxoAwLiH+L8uX/Jz6CxC0KhzsXVjUfETtwS+SFWRrOV5leFFd+gP4YXW
	 PXAHIxilmbjCfMNAzeDYEATTtYdsq7wWk9g2vfCcTnhNYx5iKkxqawvv6sQwOdFGqv6es
	 Q9WztvwBW+7m+i2dixQK0zKVgbVTosTu6CfuzBEkKfy6oBOBWpQOwUlllXnrWqtQdNhQk
	 9P1P5OfKWlvPBw8YVFd/f+B9NfH/fBgeuatysuNwek+FlZYcaCR3RgbvM5FQJ37bVWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=N/06Fqiqgpcb/TdwVDmA0U4277VRXF0+QsquQEmtQNs=;
	b=TZGiZep+DwdcM+9KF6m5hIFUF/5/wc4kT/ObY91Vve9lEL9LQvehu9GE+XfKJ3Wx/9G0
	 lriBAHAmJce717sxJ9G/l9JuuS/MwR3KG42yHEw3vNjIWBTnACbcjlXgyZb+0+WxqteRk
	 XSx/BwGG0ijACplmfpGRWBCiy91utKuZOze1UOZ/6rp+EOvNkrEdOuYU7ukKXFjZIi7vg
	 3zaVROQeiCqokYWt7UF7OovFvnev9WjQ94aImm3NCgGygG9nSxgN/pN0s+/rOfBFL6eZk
	 W7JJYGdFAH7kyOr9cUycIvahk+33lEHG9Hmm7FRCP5O/MhuUW+iELN+Th8HbN/+66VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I9a9JUzK;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A5606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D7A5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I9a9JUzK
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso776188f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793878156; x=1794482956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/06Fqiqgpcb/TdwVDmA0U4277VRXF0+QsquQEmtQNs=;
        b=I9a9JUzKUX0WcnX2PpmU4+ofAjmpb982XVSor5aq/TW/nqUSgGHRNul8ojN9n5rJtU
         LiDY3caSbkJ9HlcRoXukLgA8ik5sPUsOY0DBol0NUT0XCDz0nDN84l0smVxncOKVKgQU
         mKNyqH3tm8mvWushA2x4wqw4aP/umUS5qQlIkoK7IbkA7xoE8PMWOFkJP5OeW0fvy9iO
         JXoV3DJF7F5pVlxP7qYd5fymQ5MbY3PNM0OmAumSo1ZS0hVb7YadikvkedhyRwiXjoeY
         oMPdOmTTbzyRxs/o4u7HEJw1T/IotbOkHoguO9j4MrwBddabErl2HbMNw7zRJzUX+XH+
         MJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878156; x=1794482956;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N/06Fqiqgpcb/TdwVDmA0U4277VRXF0+QsquQEmtQNs=;
        b=Zlmy72BqYTPSwcEc7iK28N4NwdU6KkY40XjOBcpZQdzyaXDYcJAHPboYVg2+Eus5uQ
         Lg4Gm4Ohuvn1NWm6HXAUm/L0hKryMprRZzmirxbqQfsTxghR3CTIkHW9iFTsnSZorf3A
         +nqCI+F+rR4WF0hQyS3bN90MJeWff4DDlJ0mt1643oJqlNbibn8v3iAJ0PMck0AonqHb
         9bLqYF3ukMReCQAMEDftw2zIdRWn6RtzBe/GEJjH3pHln2DHbyjt1Eiq3DunNzK2SN42
         SD3+cJmNU63hni2iveDMls2M4l/i/g/h8YR0aKMbqn3XeoK3VwEHiSlwpuGTODELBv8H
         KwUg==
X-Forwarded-Encrypted: i=1; AKwUvBwxxag3UbGPaAp3vLjF6FR8bO8y2o80pYtl/rZcqquISPuAg9N77Lcw3BHvtbHAGNOWXy1dRwQr+AR7Lsq6989o@vger.kernel.org
X-Gm-Message-State: APuU4Z8w11031bTuNZnzyMgJAv7InyshVNEYr3TiTrAgkEhvAlR2ZYlg
	rUrc54bruGHcSnMRnkum22aWqnyBqGcz28QNpRYtzCreDHuWvhTQ1qlVqVkkBcy4BEM=
X-Gm-Gg: AYBFou17ItdEZ9Ei8a+bmH8acT/z6q7FYMc423tiyvNZJd8iaTHureCWHNinfZyomJR
	yJjXfRfCiMRJddZb2tQdD9jnXUEdv3FJYrbPW5W8XB+dOR6enBGYbo8O8cGou6bFqUeeiaz07Nz
	dQdlrcKAzkrfe6pu4C6WFQXfZ1DpRgvH5q5Q8BAxvUqO1hE7GZW10dQilSl6h3LfsLh+AvZ4uAv
	am7ikgmlMoXxCgW6PmOGLadz4ckKu5Je9z1mEorSN9edfoaEvwkEg3vDZtG9kxFuHZUHkLVYL1k
	e/wLfhKUquAooTt/mEmdSMctyBg0IaxwIBz/vNUqA372aXGf8qjEL++f4ViUKUhf7tgyn7ijJBc
	CYCDBafrERJs9b01kXXXo1Dq6pPPA4EAXi0pkOUYnOIT+Nt6Orbqt9AM9og173KXmG9+NDrFume
	fHpjGwyKOYSg12LNLcqgpbJfp/HDMl5jBBs9+/zH1YG8B4aVslhVmVAgP//o2j+rnO3NHqPQuLs
	xZWF+ZN9Qj6Hk83RqNT4xryb8M6Efd9p0MncGiCdsz/QmDMAgz+UwE5yLxXJAaeO9wHHrIBf5/H
	XR73y8lGvyF3PWvwuR5875dBVenhMOxz
X-Received: by 2002:a05:6000:2011:b0:48d:f14a:917e with SMTP id ffacd0b85a97d-48e6e2f24f9mr44942848f8f.11.1793878155393;
        Thu, 05 Nov 2026 03:29:15 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea1811c4sm9489546f8f.3.2026.11.05.03.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 03:29:15 -0800 (PST)
Message-ID: <404c2006-61f4-4e6d-8b23-dbea177bab3c@linaro.org>
Date: Thu, 5 Nov 2026 11:29:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] perf: do not call zfree() on uninitialized pointer
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, "acme@redhat.com" <acme@redhat.com>
References: <cover.1793867553.git.jirislaby@kernel.org>
 <8b245572903b8c4ed0dc569d7a71a8f4974e2455.1793867553.git.jirislaby@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <8b245572903b8c4ed0dc569d7a71a8f4974e2455.1793867553.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/11/2026 08:33, Jiri Slaby (SUSE) wrote:
> In add_drm_pmu(), the check for type > PERF_PMU_TYPE_DRM_END happens
> before "drm" is allocated by zalloc(). The error path nevertheless
> called zfree(&drm), i.e. free() on an uninitialized pointer, which
> can crash. Remove this bogus zfree() -- nothing has been allocated
> yet at this point, so there is nothing to free.
> 
> Fixes this compiler warning:
> In function ‘__zfree’,
>      inlined from ‘add_drm_pmu’ at util/drm_pmu.c:110:3,
>      inlined from ‘read_drm_pmus_cb’ at util/drm_pmu.c:174:10:
> ../lib/zalloc.c:13:9: warning: ‘drm’ may be used uninitialized [-Wmaybe-uninitialized]
>     13 |         free(*ptr);
>        |         ^
> 
> Assisted-by: LLM
> Fixes: 28917cb17f9d ("perf drm_pmu: Add a tool like PMU to expose DRM information")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> ---
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: linux-perf-users@vger.kernel.org
> ---
>   tools/perf/util/drm_pmu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
> index b8badae7015c..5e4bdd8e7fa8 100644
> --- a/tools/perf/util/drm_pmu.c
> +++ b/tools/perf/util/drm_pmu.c
> @@ -107,7 +107,6 @@ static struct drm_pmu *add_drm_pmu(struct list_head *pmus, char *line, size_t li
>   		type = PERF_PMU_TYPE_DRM_START;
>   
>   	if (type > PERF_PMU_TYPE_DRM_END) {
> -		zfree(&drm);
>   		pr_err("Unable to encode DRM PMU type for %s\n", name);
>   		return NULL;
>   	}

Reviewed-by: James Clark <james.clark@linaro.org>
