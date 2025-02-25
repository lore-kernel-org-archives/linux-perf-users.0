Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E7156F3A
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506095; cv=none; b=PPKTY7iQ37uixiTUrknaYQh3NlZQqGHrrS+jadlhVlNyX8HMe+nFAQR+6bKhEA6QOVafKjfArCmD86EylLbA+7URnQ5hCj3vUvCpN2f6+P0gAO+yUw33t84Z8RFqVV6X5GhdAZ4vOmAHzzyT8dW1CoYNeF2MTAq/Tvhv8kT+/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506095; c=relaxed/simple;
	bh=slTRWrb0K60rij42llMj6mVKeIRUjLYwsZyy64sDf2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtWUaUIYuK3cyiOhNiF9SYeSL18Jc8SywY4AIg4nRvTHjAucRP5KfEo8boml+3NutHyQIgu1HBjomoZ6v4+YXnGX7tThTj7UW06+0ZPHP4gOiZiUbZENIaJtYnlsgM3q+HReqm+mKCwI4BBrjy9jrrKI3Kgggts0ibbw5soQpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dsV6zM3V; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dsV6zM3V"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abec8c122e4so256558866b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 09:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740506092; x=1741110892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=011mEZq+lEHTVl8zPiUWPXTDh62dk2zOJhBI9PwZoL4=;
        b=dsV6zM3VZxvkpNQBf6/crt/+1J53Zbh/OW0pLF5kSQzH8DD1U6A8M7JvnMFOqfqf4e
         zEGmFdpRk7PE7uVnTC/sDJ37tw+Wdc3Mubb0X/zmZE0Ong7mAppG2FzSYBMvyDIFgHyS
         2n/tqC5igTG4dV2Aici6de3Vex+6GWkLbwvidqnymRAUwZ9DDdzA31l6peKskabN1SlC
         uDtNfPAEfO/9jjvEicQL0ha2tGyUvEoRjRhakO0o8dIpE+XSlfAKhtq7ym2GooPSF7rG
         0HuPXuN+J5W3OEQ8SL+6kPBc7CaDsnF6Ze2e9osMcceFOuuKPQIrsa1Gdr5JsEbDsUvE
         IyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506092; x=1741110892;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=011mEZq+lEHTVl8zPiUWPXTDh62dk2zOJhBI9PwZoL4=;
        b=VIaPcdcqlZiUlDmGIlCG++1FbFYWLgAKtxNEoJhGFd6nXZKy/aBzxkLBtYN2BqTI6F
         QfsMxqRqgfEnv8TBTSq4oncGF/4mEEOHVAbRwqvoYIkKR13QI/fngxZU5x3vcYDhyRAY
         c6Z1zOPSUQnhR9SEbc1KX3isveQ4yAgKrrysbBaQ+UdhMG//OeAmzCBtSwWkesLdVWyv
         fFj2z94eRF7GiabmrtE2in1DpXOWSD8y0wO0NcFWMoNx2wH+P+ppfnGQG70Fl3lIBnhP
         JuZgvgT6nK2h5sLrBO+UWHwoJuoU39FJHM4ecRLDgzIsAishhXrXpxADa3s1ahcbd2Ci
         x4jA==
X-Forwarded-Encrypted: i=1; AJvYcCWhwZGFojxqpkAOtLoBf4VnB6atkib4l1g4wZ7IJujcL6tdduo38V5tlvmE+NxBdDm4jLHMWaiMGHjkcFY4oTyr@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWLdWyVvhtrBZn6wE07ohFFxZGGJonxxjzKZ7HoUt9/ieS7vb
	4RJ7QgiN8MeZhjcwizyJfldhbTYO9wVUEmdLFA4xq1cV7YAH49L5RSuMzuDEnyH/7WhBheEAg04
	8
X-Gm-Gg: ASbGnct+K9DfS5sZ3DUOixPPk2DQGF3i5pr3YEf76wkjLFs1K5uXIs7wwkHf6FFh492
	Fm+GMZgwxkzhcRj37pHjbRHRkC7VcwK8cDisKal1KPuCrvZNOgJxMVuETznITVEIZsPagv18CBi
	U3ukmaYgz0OedjlVCpilFgOXKJ3rpty1CjW/9azdQwzPGCZfdKakpVBuWMxR8ikOOq15947evdV
	CAZ4d17UfF7CTaL7Zib4seA5pmE7tsnL+/c0fAomBLMbzVz1DSM0BnXfZ60I6Wo8r2PZDj9wB8m
	2YC0YH/nZ/SdJZp0qKa7g0DGS3S1yejAXN9Mf5mlZ1CzHSHTSZa0rg==
X-Google-Smtp-Source: AGHT+IGOWzmly6boKtwKSHB9GxdOpBk2xi8IAsBkCHz8v6aKL6B3fyJuVL3+GQUEXLe6PIomZxR9Lg==
X-Received: by 2002:a17:907:9721:b0:ab6:dbe0:d658 with SMTP id a640c23a62f3a-abeeee410b3mr9238566b.31.1740506092123;
        Tue, 25 Feb 2025 09:54:52 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20121adsm178683066b.91.2025.02.25.09.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 09:54:51 -0800 (PST)
Message-ID: <8973bfd4-d8b2-4dd7-ae1a-3f685dff769f@suse.com>
Date: Tue, 25 Feb 2025 19:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] x86/cpufeatures: Automatically generate required
 and disabled feature masks
To: Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, will@kernel.org, peterz@infradead.org,
 yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
 namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local>
 <1a444a2e-75b6-46f9-8f38-0458655873ac@zytor.com>
 <20250225174915.GBZ74Cm2Xpc_WwS3oe@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20250225174915.GBZ74Cm2Xpc_WwS3oe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.02.25 г. 19:49 ч., Borislav Petkov wrote:
> On Tue, Feb 25, 2025 at 09:10:01AM -0800, Xin Li wrote:
>> After looking into the build issue, we think it's better to change to perl;
>> GNU awk has quite a few extended features that standard awk doesn't support,
>> e.g., BEGINFILE/FPAT/...
> 
> ... which will make the kernel build depend on yet another tool. I know,
> I know, perl is everywhere but someone would crawl out of the woodwork
> complaining that building the kernel pulls in even more stuff.
> 


But don't we use perl even now:

$ find . -iname *.pl | wc -l
55

