Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F436130
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721182; cv=none; b=qdO9rP9fOFV/pfhjOoy+59MEInOZHT7ZhkcpyNrcxz6zTb4wVKp7gjdHxt7Z5/zjIM7//gLp/RMa9/VtqAmWUdYXxvpAUUJakqurkVOht6OpS2QGWVrTuSTIKa3pK0FFKqKOPKVE1Cw3f8U2ksM7+3/oqlR2OiVLQ6OIr0cpm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721182; c=relaxed/simple;
	bh=NqwN1ivfdf//amCWTxGUXKkycY0A2iJVKDOTkVP/SIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gx058FvJazWJP2GsGN55ExYaYj/K+SFdaARq33fz4mzXkXOIHGHVGaJK/kO1W0/1yKDrxnB5k7X6nrB74zMhpJwvJQx3s1luAIZsJ/Z8D9wvTFFwI7KSU5TwhnYJZhusBfa5/48U473Y1eexg8NCEM0om7VbP02SgDfUSOcS6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=QNRzbf+W; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="QNRzbf+W"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-427db004e36so23817345e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1721721179; x=1722325979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSxFHfDFN+MiVLSyULOWbYjXLDYVoJ0fH1mNtWGCU7I=;
        b=QNRzbf+Wvhb2Ejqc/k0VIJvDzGJ5e87p18UpsSU7bS/sRE3He2VpXY+1cBOhoN8yKy
         cqNuxVgACP+e6hF+UgRev6c3ZkhPgaZmNXySZGK86Tg++2vtvHLzu6gxNaLLFXcNpx71
         IzKCPvEzzJt1KT8rxfS6PlnDJESGh2MIbwv29fYmhPlMtzxvvr9nEdTWzF6bqKw8fmYo
         GjJJ6g41z18WQM88G2DsZPavFFWuwU3RFxdRZeLpot1enRJldJUtWfKKoSRYoJpn5UoC
         Mp9cfzOpmPzZG71UGP5PlGLsqhSl6KaGOEMUiXzRs5SIjq7hIEkm3zePGJnaaaS8x7IS
         s0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721721179; x=1722325979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSxFHfDFN+MiVLSyULOWbYjXLDYVoJ0fH1mNtWGCU7I=;
        b=H8VpahW3igg0lLNDWNJLO4HWPjE1iz3pkWxFkBR9oV7w8w8DWRdDRTJktcC4v6woUX
         HBiFVGR9fJhJsRUjRYQTfwGech4MRmLj62R/JbIJmNIEhzfjBLDJH09pvtgBvPklBYVm
         +f1UwQrtN1nn+ffq8d2QcEnKZEzfQQZIllnpZ/3wb5ZBDUHD6wMldKUweb3WOf37d2xN
         kvhEumFwsm3SqdA2YVQclap18QJ2+kmg7WWE2+BwaCGYk0VCv8M/gxHx3T6fAgOEBPPg
         1hJhcf9YaApRmeIo0WP1JUNGNzKKTNZD6HhcRhj4fc14qKxB2/b8CfOIJFgapZ2fxUzD
         qMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuEBExcRcq11CXZqoJGX5m3EKbZPZ6vn1xI/+MYI0iAruL6wBvDMZVwj97H87MkXSia6F5MM2Cln2autqwLPBg3XgAW80Eus+bnOrE/fYlPw==
X-Gm-Message-State: AOJu0YzcX+86vfPIF/xdEK5p4cc23/ME64yw+j3OU9fFNw63Ubl8v0hh
	+3BI0zMlxPrd3gXL/mkAVF3g+diZ7jrEJuCMjJNCIDdGUP4QFtHdoAOfGx0Vcng=
X-Google-Smtp-Source: AGHT+IE9Cvh25hfaQz/Gp/ZdOfzixVQt2BVNg/bV++7oWQiR7JI21E3NokuVP3ZF00d3/6mUezvKcQ==
X-Received: by 2002:a05:600c:3c94:b0:426:629f:1556 with SMTP id 5b1f17b1804b1-427dc56476amr60061065e9.31.1721721179228;
        Tue, 23 Jul 2024 00:52:59 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a7218esm181620735e9.25.2024.07.23.00.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 00:52:58 -0700 (PDT)
Message-ID: <4cd8c6c7-bd15-4663-bb0b-815904560c90@ursulin.net>
Date: Tue, 23 Jul 2024 08:52:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/i915/pmu: Drop is_igp()
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 intel-gfx@lists.freedesktop.org, linux-perf-users@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
 <20240722210648.80892-5-lucas.demarchi@intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240722210648.80892-5-lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 22/07/2024 22:06, Lucas De Marchi wrote:
> There's no reason to hardcode checking for integrated graphics on a
> specific pci slot. That information is already available per platform an
> can be checked with IS_DGFX().

Hmm probably reason was this, added is_igp:

commit 05488673a4d41383f9dd537f298e525e6b00fb93
Author:     Tvrtko Ursulin <tursulin@ursulin.net>
AuthorDate: Wed Oct 16 10:38:02 2019 +0100
Commit:     Tvrtko Ursulin <tursulin@ursulin.net>
CommitDate: Thu Oct 17 10:50:47 2019 +0100

     drm/i915/pmu: Support multiple GPUs

Added IS_DGFX:

commit dc90fe3fd219c7693617ba09a9467e4aadc2e039
Author:     José Roberto de Souza <jose.souza@intel.com>
AuthorDate: Thu Oct 24 12:51:19 2019 -0700
Commit:     Lucas De Marchi <lucas.demarchi@intel.com>
CommitDate: Fri Oct 25 13:53:51 2019 -0700

     drm/i915: Add is_dgfx to device info

So innocently arrived just a bit before.

Regards,

Tvrtko

> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>   drivers/gpu/drm/i915/i915_pmu.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index 3a8bd11b87e7..b5d14dd318e4 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -1235,17 +1235,6 @@ static void i915_pmu_unregister_cpuhp_state(struct i915_pmu *pmu)
>   	cpuhp_state_remove_instance(cpuhp_slot, &pmu->cpuhp.node);
>   }
>   
> -static bool is_igp(struct drm_i915_private *i915)
> -{
> -	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> -
> -	/* IGP is 0000:00:02.0 */
> -	return pci_domain_nr(pdev->bus) == 0 &&
> -	       pdev->bus->number == 0 &&
> -	       PCI_SLOT(pdev->devfn) == 2 &&
> -	       PCI_FUNC(pdev->devfn) == 0;
> -}
> -
>   void i915_pmu_register(struct drm_i915_private *i915)
>   {
>   	struct i915_pmu *pmu = &i915->pmu;
> @@ -1269,7 +1258,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
>   	pmu->cpuhp.cpu = -1;
>   	init_rc6(pmu);
>   
> -	if (!is_igp(i915)) {
> +	if (IS_DGFX(i915)) {
>   		pmu->name = kasprintf(GFP_KERNEL,
>   				      "i915_%s",
>   				      dev_name(i915->drm.dev));
> @@ -1323,7 +1312,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
>   	pmu->base.event_init = NULL;
>   	free_event_attributes(pmu);
>   err_name:
> -	if (!is_igp(i915))
> +	if (IS_DGFX(i915))
>   		kfree(pmu->name);
>   err:
>   	drm_notice(&i915->drm, "Failed to register PMU!\n");
> @@ -1351,7 +1340,7 @@ void i915_pmu_unregister(struct drm_i915_private *i915)
>   	perf_pmu_unregister(&pmu->base);
>   	pmu->base.event_init = NULL;
>   	kfree(pmu->base.attr_groups);
> -	if (!is_igp(i915))
> +	if (IS_DGFX(i915))
>   		kfree(pmu->name);
>   	free_event_attributes(pmu);
>   }
