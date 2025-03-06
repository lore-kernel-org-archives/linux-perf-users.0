Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A418DB3F
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Mar 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254336; cv=none; b=XBuOwCmmhw4OBrb/1qaNrtELck3d+EXfk1jGUBDfldJ1YaUj/cSqO5Ee42+yPJCq049J5drN0bJm994ObTD2TTrXsieisbCS141pFgGrRh7DXzqO3oM7Z0A/LK60LmFb+TAcZmuVSzNFOL5De/qyVVBSsWVLrViTLNslvHNCbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254336; c=relaxed/simple;
	bh=/Paa9Ppr3dpc3yGGhGt6blce4IOqRHPQareE3kaavvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8Qk2gVrlb4nYHHAPUFE6sYgpAmmhsKMeiLT3iMETwJeMZ+dfd26ssOQMQOeCY372NI38Tmbm0ZTbjNmf4FvWlz/qxClGY7lT3ZrjxOqj4PScKXgSci3Jcr5g0JlfFiQF4JFAgimkZEoWLwWZXN14OUKq8bYtJkejUu/8M/1rb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ad9pku22; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ad9pku22"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc31227ecso2352415e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254333; x=1741859133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ib6uvD1UOSB7iCE+uK87YhdmFx4Z1+LHRHqLNKyZf3U=;
        b=Ad9pku22dJj8KAQguQn77RpGh1Fkt2GKsM9/aT7ce8unW9LsZYbx3MLbc4sKfWJpSB
         9tGQMZCMJi5RnWjxs8XJAE/tYkHq0pY0FZkNmZaQep2cLZLghlvPvyloe+s7y9vQblTi
         0V5JxVTXLVDZy21dW5TRtmVHpzGPNuBkAwVoINlvIs156s3vncph4oBnOxiqtSx5Ggnr
         uFOJp0xnftZfQYs1ZEzATtSPPlYqYYnoM/Uf/tFMQckA0vStY/KJxsMdsP++67W6S8ws
         EXftUJq1d6925en5m/BTmrp4yjhWO5e/dMqnCjZHBQ/Zamx7mqpVi4Xb4UmVJvkBCmpa
         38Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254333; x=1741859133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib6uvD1UOSB7iCE+uK87YhdmFx4Z1+LHRHqLNKyZf3U=;
        b=fGyzSoNZOqgf22EXllZGeIAFLZJ1GdndKknBMzeqyfYhjdkc0zc3ss7svl34xAOd+B
         RKt0KKe9hldG2DBI+zSGBvcN3p52+OVlVme8VDFHIihlyBW7FPUDAwYfj3mA72dtUX2C
         DkaALlVMV/OqrnUzxIeQj/HdGcp//vjlxZ3v6b0rLGYERqH7CKyZt3v3qrswU1htAWzL
         7KnccLOVVAPjZ4ZmYRJgjaktfpO7GiVxkIUu/lVYTA/WanU9mpaw+KGZPKXG2mAaGb+T
         mrAfmYv0OFB0e2/KegJ2fCL2fLuV364FSfQuIjNQ84Fw3Mh8IXq+994uoYwSYVPNI/1l
         YJhw==
X-Forwarded-Encrypted: i=1; AJvYcCUoXUhMSLYvCzWPaeIcKFLYZrotBFzaHwIZS0Qw9HD8WSTDcdpWMqKw8pG8JiCOJDinLDSxKKLNoPQQtASTBV4d@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiq17ISzIJEpJwcvI6OtDFq90jVuvVqZJZwAVJrKqTa9b79E4
	hzIT2SLYM/5D2oT7rw3ewwInqTjfll+aFDFcG7w9kxBA9fIY5CkQ6w60VF+4vRk=
X-Gm-Gg: ASbGnctZVTKtW4RGy1MtZPCQzaxuWRtHANREa6RYBGCAUHOINTqmKc0wvAylbgHZBox
	eE7xYvrpJMRXKqgJqTIj0lE05dpYfqY3Kfxu5Rfl3Guxio0TYVkzOW7RImLx+BSxq0cJZpkzS2C
	VfzQGdHBwnPR5x6SBRto4ttv1y/7Ahz4rVNGnlR9Nt0q8uFCANy5tCU3K+kNt+xsE6qEALEbbcn
	iDEipNVVsEVqBw6BbiwY5viJtAqXs5eXoYf2CD9usDvrfkM5+5U//Cgvei/65Eh2Kl+uyKjdKoJ
	ySWLp3q9NMaxTKGA0NewtFmOZkJtFGD2PQ+tLhb/+IthyniB7mnmpQ==
X-Google-Smtp-Source: AGHT+IGKKY+W5AegUXBiD0ygLeBmuUSupCHLoSK0LTRbSaruyo4vSjRj8N2aVNPCWrxf/uCOb1/Erw==
X-Received: by 2002:a05:600c:3506:b0:434:fb65:ebbb with SMTP id 5b1f17b1804b1-43bd298f535mr50704515e9.17.1741254331601;
        Thu, 06 Mar 2025 01:45:31 -0800 (PST)
Received: from [192.168.1.247] ([145.224.67.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4353003sm46516085e9.28.2025.03.06.01.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:45:31 -0800 (PST)
Message-ID: <4484f7e8-e3c5-4488-9b1c-40d9c7124ecd@linaro.org>
Date: Thu, 6 Mar 2025 09:45:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf/arm_cspmu: Move register definitons to header
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc: mark.rutland@arm.com, bwicaksono@nvidia.com,
 ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <cover.1741190362.git.robin.murphy@arm.com>
 <5a3c796560665b51cb63fec0d473afd8f8d0a836.1741190362.git.robin.murphy@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <5a3c796560665b51cb63fec0d473afd8f8d0a836.1741190362.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 4:10 pm, Robin Murphy wrote:
> Implementations may occasionally want to refer to register offsets, so
> for the sake of consistency move all of the register definitions to join
> the PMIIDR fields in the private header where they can be shared. As an
> example nicety, we can then define Ampere's imp-def filters in terms of
> the architectural PMIMPDEF range rather than open-coded offsets.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Reviewed-by: James Clark <james.clark@linaro.org>

