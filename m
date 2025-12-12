Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D40AD51
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554732; cv=none; b=B6Bygop4GpGhn9WioRtTdc03LKHft2bVPzH84pLwr5rXJvkG568fi3kV0LBFagUSS4MAMRgsdD1c+wbth3rc3cAZGLNaVa9sBWjRYdcucHgC6RMlIiLG/esp5ooH8rJ9pKLDiUe5AwTjpL5j+pz9y4MdHCltcvNCcIdFlT7Yntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554732; c=relaxed/simple;
	bh=6cveMDU2xhIPiIlaviJbj0HLFpMZOamk+NrqD5tfSV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4CcZZnBeaAOWA60Nz90xBYd6iSWASHle0pR3Gji4TSCDLQFc7Vz3HNRVixU1Rd1M4JU/jzwGruG/Jk9yooyMXWTaTB2ZaGi563/MwBUch13VhwhBd0p1bquzs89mvTc2FDmLNmYRmhr2c//1ahVKukscgT0EdfSmQ/79sqC9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1PH4aIY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1PH4aIY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so15438835e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765554729; x=1766159529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BF5gJ/otAEoZ4clGqcYn+D/DhcYdPlTejIl8apYKJjg=;
        b=H1PH4aIYKEl7teNkGYxE+6xQp0X2kl/JwUFOSe87i1npMzAALsxsMpRd/qqO7AT9aS
         YwUFFP2ujl7qTfgB6BCx+tLD/2FNQTt8fZef//aUOJdrZX0MntT54OBryVwGaWoY7Qyp
         pc1HZn9dS4hub+FFbV2FxNBd4ZEreKhkGjVxwzQDXnsSkpSX3svgCuPaZRI2Ptd41uMK
         iqbKWRy3z8e961gr9z7QaxaZHLQZ3ApclqUeFpgDk/v79Vq4ueY6IYi5xbyIyy5XCh1Z
         +QHs3ECXs/G4CLQgLx50PsxsMHO91IPx3UsIKLKcPZX5NdTXvQB+/LhPsJNSbWkie13l
         gRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765554729; x=1766159529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BF5gJ/otAEoZ4clGqcYn+D/DhcYdPlTejIl8apYKJjg=;
        b=f8yPqZ1CJ40N73guuWqkIYlbNXBo1e7V8lHUpmr3ik/O6UTFg+uWPQUQMoPc8Jdzmv
         XOiVA+hqPev5CUfFSPVQa8DhEwFy+unSFJW5T5rorl2pr8HU5RvTm29X6icBlX55AjtT
         5SUudLdUyvROHdFLvL0C/6OJIEtsjt3gDB479R9h3zxowIyvORdL0DevkodgzvtIzJPp
         F4VlNqJVkR1ukpyxnrhee7rjjFI1Y2qv1WxDUNI/wyyv72XApSeLrw+rUyohcMgKYeMP
         X6mnjFTeUNjwtH1D6/lQlSI0q/ICDtvHj5408dseLrQkTwAYEn2bLC5RS+DOeSNYm1W0
         Eg0A==
X-Forwarded-Encrypted: i=1; AJvYcCUl6ebNpCN4+jBT8X95wal5MIbPCOLNfi8p7DyzIY6CkanMQqHRpzGJZvSgssIIIjfHVC30lRcKvrL0wEQ6w+p0@vger.kernel.org
X-Gm-Message-State: AOJu0YzHieuMeq0I9T+Jkl/zuzC/vAbuUavq6UezbUm61woBoWezsA7F
	rNxaCldcruWx4xiEn+2EG13QliSk4sdNTsv7ZXsJaPRoYgl0Jecy6owgsNspEh7dGpYmt5XI9W9
	ojkvCIwR2/gDm
X-Gm-Gg: AY/fxX5sW65jgGdhi8UboqfehPIBqt2o/Ny1VvIyY+LLc15rOUs7gDgzubzdmMTaquU
	ojn8/cv1uD31W9bBclf2pBIKW/KE9YcWiTmy4S/8arsLw0esp2A8XOXpSCUaA/j71ok369XAz7x
	o9i2ten38+IaF1KszC5joVpUV/lmXQFUE24WppZUDKwJHLk6vk/SHjIkTK018MIlemxqesLxDC7
	hPcIslSn35Bokd1lK9dR3vk9+OWDuTAjYOcc3d7O8oMbqty8kyTnRGPvgS1EQ4/dFxKKRnsTojY
	MxGZ+l50PHSa3kaeqmP1SRSTqLQMt/gIokjsDhByOxgy/AWvQriRgLEPavCPfqUhDt7dZSQss2X
	CKi7WY0AsrnfeUshjr4TwOZbhi81TIFD3YkYsLOlAzdmCit9lcjzlOxn3sYk3sjKoMAAWDfkTl9
	+5wloV5ZwNIrVoox3tyhJ8
X-Google-Smtp-Source: AGHT+IFyYqsJru0EerGFYFTMp90A+LMaDZcZ5Gsc9tDkxrzqI6XWJZKohcECOZHdf9TafH96HnDZ4g==
X-Received: by 2002:a05:600c:450b:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-47a8f8c0608mr25573425e9.13.1765554729284;
        Fri, 12 Dec 2025 07:52:09 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b85f38sm12766586f8f.28.2025.12.12.07.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 07:52:08 -0800 (PST)
Message-ID: <26b61e11-1dfa-4be1-8d58-06e35fb04d64@linaro.org>
Date: Fri, 12 Dec 2025 17:52:07 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] coresight: trbe: Refactor AUX flag setting
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-7-7da32b076b28@arm.com>
 <a638f74f-94bc-4052-b8e1-e940aca2d4ce@linaro.org>
 <20251210154308.GZ724103@e132581.arm.com>
 <27417fd5-902e-4474-8d60-356a94ac9590@linaro.org>
 <20251212152738.GA181228@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251212152738.GA181228@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/2025 17:27, Leo Yan wrote:
> On Fri, Dec 12, 2025 at 04:50:52PM +0200, James Clark wrote:
> 
> [...]
> 
>>> The trace can be stopped on Fill mode (stop on wrap) or Stop on trigger, so
>>> it is not (only) about buffer error.  In these cases, even though the trace
>>> unit is stopped, the buffer may still have space available, tracing can be
>>> directly re-enabled in interrupt handler, thus the COLLISION/PARTIAL flags
>>> are better choices.
>>
>> I suppose this is the bit that I don't understand. If there is space left
>> then why is the stop hit at all?
> 
> For instance, the buffer becomes empty in the middle:
> 
>     +----------------------------+
>     |$$$$$$$|            |$$$$$$$|
>     +----------------------------+
>     ` base  `wptr        `limit
> 
> In this case, the trace unit stops when it reaches the limit.
> Meanwhile, the tool might have already read out the old trace data so
> we will get some free space, thus no need to set TRUNCATED flag.

Hmmm I see, I still think that means that Perf is being too slow and 
disabling the event wouldn't be that bad.

Also isn't there a very small chance to hit this? I'm wondering if you 
ever saw PARTIAL flags in practice?

I think the following all have to be true:

  * 3 out of 4 sections were full on the last interrupt
  * Perf hadn't managed to finish reading even 1 section in that time
  * The last section fills up
  * Perf had managed to finish reading 1 section between the time of
    the previous interrupt and the hard stop

There would have to be quite a high variability in read speed to make 
that possible. Maybe it happens and it's worthwhile optimizing for. The 
comments could explain it better if we do decide to keep it.

