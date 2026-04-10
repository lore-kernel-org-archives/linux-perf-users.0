Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348F342530
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813105; cv=none; b=kKcFiFdqSp4MyFeSP2vSsNZ/WI3Xehq0WX9LSP8YJ/LOq3BhW8Lha0aPKQnb/vVG/1SvV5Mtx9UA/OxTr9ynkQlbROa6HfOcV7yl7D/09b4IVzBc2DTMkZJ24NQjt+pSYPw2G6ks1t3HLVqecY75ZXXQETS5QFG4dVbru9C/Tqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813105; c=relaxed/simple;
	bh=uAoFiXQldyDKMQPKhMx3P5oajVo9oIWg7TC1U+INyCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwTn3VsRy+JTNSfpS0ytE1dlGeSMmucKMikotPm40WLs38MeyUEDqSkUsyNS7c3HBUqjHF1EGJ+nOBSBB+mXGt/0UX3AOT9VuDP76pOQieG48j881lD/JI3UDaxkiI1+aU20DomBVIk8F3OWLEXpjFK/qctzy7VWgLgkmitUnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kn20TnIu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kn20TnIu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488d2079582so14849185e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 02:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775813102; x=1776417902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EaqDywoj+uSpm9uhbUsCqEBrRoto0iCeBK1SrvtZ+mA=;
        b=kn20TnIuQeo09A2DeFBHRFrJqzN1xPdznRiyv0y4oq+3zRo5fThW8ia0BrqM+79UOE
         8kbFOESS995/74O+iX8gOsLsB1cX9Me0lJS0VSZ0z4bJ15vE+CUVbGA3oMe4pvkaY7nf
         ClzimLxgz7xjolWe+ZYKZCr0tL5auKBvQ9GPjB0b/1aQqdHS72ktkftBnBZBbfkdZqLP
         4sEPDdUrqqprF7XHSJnIsDVqUyuTYphC6BCUa7NyTzuXt8EeOscdGoktzQ0Up1f5eeFO
         6fnl9UF/wSLEv1lwC6a3LInmz46OVTZQEr8lGrCxqYBzv7kH2v7uENaFRqY9snv6aaaq
         K5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813102; x=1776417902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EaqDywoj+uSpm9uhbUsCqEBrRoto0iCeBK1SrvtZ+mA=;
        b=F1FH+N5ftDoe4aD7CkhWUxSvUICUclWqyB7aMUPDtp2usPn3KqPMQvYZlYHI3DDhcf
         ark8tZpivQOor5rw3WwH+6r51Wu0kV54lYQfwXW9jvyXtXWIcOZcLLy4oADwXcRgh5j1
         FcV07hiU5fipGwsP75eoUBArw03eYWuX28ouc0XTtYT8PO3KDPO4MjNOyHK8VZcj5zRH
         BrrZmtxN72xjE6KbuepR6JDl552kow3qYeNYEcsBTdeAIu/o1pOB5Yw7QEq0h4bGsSDO
         alJ05lO5KIybRax4wBM9XXhQLb42xF56nICi0qwoi1vFpmbAWDoiLV3CC07bbe0+bbMq
         6VSg==
X-Gm-Message-State: AOJu0YxrN1yDOX0vqCLtX6MfN99OYQTT9R7ew7Chpi+O7333P+sLC3h9
	QuPf15a7JdD+tRW2/rQKuFUMwr/YfNpkzLxs2BblXVDsQhsnypxa+W+WsFwb2d707Wo=
X-Gm-Gg: AeBDieuEwkA/Vxpin3Ao04EBIEuMb8hT7ywURQcltWLzVIl5wxNw6qwoF88aGve4/A5
	SVx5ooDHftzhDEmhoAf3U3ca1raMC/3dGvobmF7J2277sfTiJ9Lp8sX1F3T23ksx1AwB90S+xQR
	Ml/COzVoDtqISEJOOMoza5QoewgFtYgOZpFoxN+IHXenksh0f6Yf8QeRZ/CwN5CbqQYib92BcKF
	CGnyoQ8Ac7jW3Y3Al8eNR8MFYCrDuHe4Trz+4rRdGrMGDLsZ6Expc5AOCX/5Jkki7t4hhouddjb
	R8nnY7hyWlpfw3hJMu5detteazTzLHAr0AosRq9+U9FutAwSoDhK3aLkkxlXXTNDb2QP/x5lUGA
	mJ6KrTr/WawWKc2loyfbNAiM6JcWXQ2QepTiT9u9CsWr8oO7q7A87w9npmd2KyT0kFmD9F/+2uS
	0rxFfpcH8U1lImQhKNP695GOP8/QSs
X-Received: by 2002:a05:600c:a411:b0:488:af48:af11 with SMTP id 5b1f17b1804b1-488d67c749emr22931015e9.1.1775813101910;
        Fri, 10 Apr 2026 02:25:01 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681ea59sm16117725e9.14.2026.04.10.02.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 02:25:01 -0700 (PDT)
Message-ID: <d9c9eddf-8f66-4757-98b4-16b4ba505f5e@linaro.org>
Date: Fri, 10 Apr 2026 10:25:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: fix "argument list too long" in second
 location
To: Markus Mayer <mmayer@broadcom.com>
Cc: Perf Mailing List <linux-perf-users@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20260409221418.185343-1-mmayer@broadcom.com>
 <20260409221418.185343-2-mmayer@broadcom.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260409221418.185343-2-mmayer@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2026 11:14 pm, Markus Mayer wrote:
> Turns out that displaying "RM $^" via quiet_cmd_rm can also upset the
> shell and cause it to display "argument list too long".
> 
> Trying to quote $^ doesn't help.
> 
> In the end, *not* displaying the (potentially long) list of files is
> probably the right thing to do for a "quiet" message, anyway. Instead,
> let's display a count of how many files were removed. There is always
> V=1 if more detail is required.
> 
>    TEST    linux/tools/perf/pmu-events/metric_test.log
>    RM      ...634 orphan file(s)...
>    LD      linux/tools/perf/util/perf-util-in.o
> 
> Also move the comment regarding xargs before the rule, so it doesn't
> show up in the build output.
> 

I'm assuming this is just a cosmetic issue so it doesn't need a fixes 
tag? And "upsetting the shell" doesn't cause a build failure?

Otherwise looks good to me.

Reviewed-by: James Clark <james.clark@linaro.org>

> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>   tools/perf/pmu-events/Build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index dc5f94862a3b..dc1df2d57ddc 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -211,10 +211,10 @@ ifneq ($(strip $(ORPHAN_FILES)),)
>   
>   # Message for $(call echo-cmd,rm). Generally cleaning files isn't part
>   # of a build step.
> -quiet_cmd_rm  = RM      $^
> +quiet_cmd_rm = RM      ...$(words $^) orphan file(s)...
>   
> +# The list of files can be long. Use xargs to prevent issues.
>   prune_orphans: $(ORPHAN_FILES)
> -	# The list of files can be long. Use xargs to prevent issues.
>   	$(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f
>   
>   JEVENTS_DEPS += prune_orphans

