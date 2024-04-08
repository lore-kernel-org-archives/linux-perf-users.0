Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71491E57B
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557703; cv=none; b=Qw1SSUjdVIzgNv3IslSTSmT2Saa21U6OiyX5ugyiXbZip37abKBVPsg10LEUVPr31ygoBaJxunlfZxfRI9hzHHj/bUpFJvDqffsW3mVIfbAqUhmwO0n7dBXhEzyWDY65T1AGguIkIAouvCrp7pK/s4QDZSJNfOOWPwZxolElkNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557703; c=relaxed/simple;
	bh=IE2dQfOBUfWFV2sRzZOKfpp0BxlqrHbr9xEZn3IEuP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFldxWEbn/pCVgz+RSjqD4D80lo7gbmpikh3WnR+WkLVJlPKiNoxpjwT0Np6oEJ1H2ScfgDdGSGukQUGtBdaXH93JlvMPmCgI8sltxa0+yNd+lBD6e9Jvj/dwjAI6eV6RiPogphbYiRnyHLKZUPBumZinFEpA4frgwrhLBt9KBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yOXJp81r; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOXJp81r"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso5300608a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Apr 2024 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712557700; x=1713162500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6EgD/Muel3BqCojSMMdXuM1Td/LzqFDog01ouaIAt4=;
        b=yOXJp81rAaNrq1CgYmdLDH1j2ny2sATQ0Jm61sa5Ex90e+AQSMQhg6fXhzgwPXh+TS
         OF9HCV32Sup3zJYhk3DGDBMvinJDnerJ36Eq2Yr2KFP/2FFR5W8U0KG8ut4nICKn9TKn
         P5NnSElxCBYRuJu+eoWCyXpBkpD/nWEcBg09Pn3yddBbMT65naPeqwDJbKhP0jsbYtKB
         7OdZ/5XPp7Bq+yYrJrP12JX2XHV0GNhrJUJiBn/vywNEnxPx6BZtdtKjnBNHE+kAD4MJ
         l+ZUV9TgVBlx/djmlOfNyNIC9HTDITSqNjcdzrGqn1uWQ9hbrAxInlbTWYGomjY2z/gY
         Wxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712557700; x=1713162500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6EgD/Muel3BqCojSMMdXuM1Td/LzqFDog01ouaIAt4=;
        b=emHaIe1ks/i5LVP9tZD9JJMmT06ZGiNXAI08cUoTwQECczrzrYDrweVGRIfBWeAJCW
         dnO38pGZni/dgy9quSNz1BILArYPv9Cor9VsCL2EoHaLNfF+VnmV6tQ8IcUR41Pkt0x0
         RauxAI5o1prU5OP6nc1Fxze/iXRpFN797hP3AJNV8amB6C3J5QHaQviLD+0jmWGoErGU
         h2MD2W0KQ/x/epQ6bdyHEHWuEk8ASdDZncpZ9bhr/DsPepDKF3umT5eykdFH2KR4sJ00
         4COMZswFJpdrcOuWxWbDLlJN/UNBDcL9FUSMz5i6OUZx8SG11wNOkN+BT5eQbNlOoqJV
         K2RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtEIvw5lbWxN+k2pZxM88xi5/Kp8csxkDHrIv6zeP4pWPL/m4AufY0jrnJv5QBeJ3kAAMx7XiMj8cyetPiKzXY+hl1nRDexVJgEJNlhYwz+g==
X-Gm-Message-State: AOJu0YzOOhN9u/xIITiRCcITkgxAzFG+WTcAvGwFVOmqmd3A+UH2gIlT
	ihDKOfLkymOUVWuYr/rDKuaVVUS07/Z1RYHSyGQ1s5DUo9lTfx2wiPmlaDs+tD0=
X-Google-Smtp-Source: AGHT+IEW7NFlAXtt0eb3qEVFrk9JxABFiNRfMx5pOzC0ESg5/RMCffY6KCodQ4v8J7x5a4GlkvTfcw==
X-Received: by 2002:a50:bae3:0:b0:56c:18d5:1e27 with SMTP id x90-20020a50bae3000000b0056c18d51e27mr5576700ede.5.1712557699936;
        Sun, 07 Apr 2024 23:28:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id k19-20020aa7c393000000b0056bfb7004basm3538428edq.90.2024.04.07.23.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:28:19 -0700 (PDT)
Message-ID: <2e481816-2b06-432c-b09c-e92e230debe8@linaro.org>
Date: Mon, 8 Apr 2024 08:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm: replace set_pte_at_notify() with just
 set_pte_at()
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Nicholas Piggin <npiggin@gmail.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Sean Christopherson
 <seanjc@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-riscv@lists.infradead.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240405115815.3226315-1-pbonzini@redhat.com>
 <20240405115815.3226315-5-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405115815.3226315-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/4/24 13:58, Paolo Bonzini wrote:
> With the demise of the .change_pte() MMU notifier callback, there is no
> notification happening in set_pte_at_notify().  It is a synonym of
> set_pte_at() and can be replaced with it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/linux/mmu_notifier.h | 2 --
>   kernel/events/uprobes.c      | 5 ++---
>   mm/ksm.c                     | 4 ++--
>   mm/memory.c                  | 7 +------
>   mm/migrate_device.c          | 8 ++------
>   5 files changed, 7 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

