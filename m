Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9D3D75DC
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781993; cv=none; b=A6rL+1kitOod3KHLH/2TlKNz/ZQygBf+D6ZxCgrQ9jo3PbcLSuUeleVCeY/sKMjIZungVghKPa5NAbDWo5r53tpCMOPVadHxrg/hivsu8txkKpcO/NqGzlR1inJ9A8OnfBoZ+7J/fIY9zCP3uPmMTpnaVGBYQeo91Z4xLDip6HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781993; c=relaxed/simple;
	bh=IHRvS3C1jeZEyoYmpFk9W8/Od1wo6/pY6I19NPtYnYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3f3TcFBltRn+FesEXgBWB5zxRWiAKJ/lNygKxtJMeCtez0Tix0yyIJpKAcnP53eQkThTXUcvxhJvf2XfXMT4CKz2TYTvrzbXDW4Xq+cbKymhHkY3axDvHu+tg9EvweMZxTjbeA9ECoqj+Yz9dtkZa/OFsxEiRKx9qiFjqnWKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nXpvdFER; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nXpvdFER"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891f625344so24690035e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776781990; x=1777386790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I86X5f7o1KhxjdDA+yrUKD5IZ9a2fkcl2651mUvpB2I=;
        b=nXpvdFER/OhwcnXMfQq8af9GCjkxKH4winTg0zM2fmCAeZ/ww2fA6BlZJm1Faap2ye
         G+het7+WI4piQUP5A0SamWz1orXPPMToRydfUAsQv5vsF6IbtEPmL06l4Jrc+96xFSBu
         EmQRFKoBzj2hxJBNaNHAwWxnYzsB67NGWcuJDfhj3POa1dtzbQ5LQpQW0L/k9CgNv28U
         ygdfPAes680JdwslRsUZ87NoeSOV1HbTchZQq11PItb6n2B2ou/DAAwW2yCn5dfVfCnR
         qZ3NB8M09VP4M8OxDqivx/wcCQPwRv1QwNQsqc2+fAJtsVi3FPHXKebmmijh23N0bcXV
         Zqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781990; x=1777386790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I86X5f7o1KhxjdDA+yrUKD5IZ9a2fkcl2651mUvpB2I=;
        b=Kc6Mn9sTrF5zqaQTcFJ7o7+L4/zFLmkUBGwXoKN1hZmWKLh1uCdjzxQaVpnxxrB3lA
         4PgpCCGHrjyNbkH6Y9baYdRh02earIPCWr9u2J6DxwEwm66W0xAgdruemoE+67kbVWN7
         06GdzW6+rTOc6c/skKdlzV7udmWc+t2GrRk5PshvvTe3EtN4JugR7/Ze+3CceBYCbHIZ
         zzcPPq2335FWEQ8E4CmZ8vgtHQAu+0Kp6bkOdUBgqQORo6YObLC0Hfg2LBd9flKBjh+q
         yVZmpm12TOl+wihwO6v8aPwquGTk55lLRJ9HDYAWFmkX98fTsRSNvUrFcbjoi6poQcei
         WNRw==
X-Forwarded-Encrypted: i=1; AFNElJ9T8Xj88qFQYQf6y1X4YVGHKW3dyy6LxFqtUGVNiV6j/Q1jI2XvITz2O5XqjBwrCVm+n2lI3bQ/S76+mIWT6gUe@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrucvzAFTygJ1CZwoXtkshaQ+hUMCz9et3Ktzp2DUqB1mvmMR
	5ffm+qvPcO8KdkeTnL2/aMl4Ilh+v9L8VnK0TnsHFpxPoxBlu7T9ZSC360UI7xLOBUE=
X-Gm-Gg: AeBDiesRQ68orJDIZbauGknELu+cY+NztoTGxxCtgIZWlYAYOvueq+IjZHw8e8PyGTy
	n+Nw4/58UM2auhEV291IoDlGEIeKeH/V7TS4zCihDAIVqSXM5gntixpWKaE0xJiqG2n9uJdXemu
	bYoHqj2iWLDrOXg5xZoLZgG9YZDr2lCXzb7Y28DhR3gJuP8cmmfKhg4b965j6I9MlH84P8XTH6k
	0XFiibjvJIR5jTAxJIFn7wfJhuntSzmzP0ePR9IoxLhqyacYO3X1JDBhzqIK9OwBrYN4CziHNIr
	PDUbADbGw9R7sUj52dPUVOp9qG6gO8peIwzOus8xu9vdUYI2c9g0SAMP78PXorwRvzbV8x+5wES
	oSJhm6aCi4Zj85bZBA7nPnbY7qWaFCzxqROeBLfPpmeiha9GXR9olCw7qKZbth2BXRFKr7PCbU+
	Iav02R3BAjbN8d1zmFxRzf0NX5T1rmreAi0cQg0HPHBYw=
X-Received: by 2002:a05:600c:33a4:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-4891abb574amr73260305e9.5.1776781989776;
        Tue, 21 Apr 2026 07:33:09 -0700 (PDT)
Received: from [192.168.178.64] ([84.246.200.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm621187595e9.3.2026.04.21.07.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 07:33:09 -0700 (PDT)
Message-ID: <d350c96d-8a1f-47cb-bdc2-355ca0dfa2c1@linaro.org>
Date: Tue, 21 Apr 2026 15:33:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build-id: Fix wrong return value checking
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20260420180858.129075-1-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260420180858.129075-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/04/2026 19:08, Namhyung Kim wrote:
> The {sysfs,filename}__snprintf_build_id() both return the actual length
> of build-ID.  But in their fprintf counterparts check with sbuild_id
> length which contain a terminating NUL bytes.  So they cannot match.
> 
> This resulted in perf buildid-list -k prints nothing.  With this fix,
> it can show the following result.
> 
>    $ perf buildid-list -k
>    9524074000cb36cf2559a5b52f0555dab47da553
> 
> Fixes: fccaaf6fbbc59910e ("perf build-id: Change sprintf functions to snprintf")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/builtin-buildid-list.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
> index a91bbb34ac946360..8ad39ff9a4b8a4b4 100644
> --- a/tools/perf/builtin-buildid-list.c
> +++ b/tools/perf/builtin-buildid-list.c
> @@ -61,7 +61,7 @@ static int sysfs__fprintf_build_id(FILE *fp)
>   	int ret;
>   
>   	ret = sysfs__snprintf_build_id("/", sbuild_id, sizeof(sbuild_id));
> -	if (ret != sizeof(sbuild_id))
> +	if (ret != sizeof(sbuild_id) - 1)
>   		return ret < 0 ? ret : -EINVAL;
>   
>   	return fprintf(fp, "%s\n", sbuild_id);
> @@ -73,7 +73,7 @@ static int filename__fprintf_build_id(const char *name, FILE *fp)
>   	int ret;
>   
>   	ret = filename__snprintf_build_id(name, sbuild_id, sizeof(sbuild_id));
> -	if (ret != sizeof(sbuild_id))
> +	if (ret != sizeof(sbuild_id) - 1)
>   		return ret < 0 ? ret : -EINVAL;
>   
>   	return fprintf(fp, "%s\n", sbuild_id);

