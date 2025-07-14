Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9341339A4;
	Mon, 14 Jul 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508785; cv=none; b=cVdHkPF+nsM1pRD3Gv0cpid6sRAtDLNQnhZga9AgfQ9ebaE+0WJzG+m8xRZM4k44jMw27uR+4sKrWsus3tB3wnvecwqOkq6NiqaOxsB/eGNU8gFBS1MZyGN+BP4wD0iEhtM9BUKHUhDgAc67GDY9NEifolEAi6LbaiuWe9jpYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508785; c=relaxed/simple;
	bh=5BYeSn92YzzQF+VMS4Brh9M0r6cRiJUgo31LKCP5UVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzYNOLp1ZC5rFBGDLLkZBYKEc38Q3OFMdIlvAIlgsoUd6HVDaK4arCVmnOBGzwspNH+NSj+j3EntTLBnSr43uhheSqAnyqssCyYwglaqeWs5ifUY9xH/AfDBH6FkCK4a0/qI3CTWf7JNQDZhe/13hrhD27NYx/aJIAPxAErt/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFocH2Aw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFocH2Aw"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7490acf57b9so3177303b3a.2;
        Mon, 14 Jul 2025 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752508783; x=1753113583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BYeSn92YzzQF+VMS4Brh9M0r6cRiJUgo31LKCP5UVE=;
        b=mFocH2Aw0Ykib9y0cOEqS/ZijxUp+Nht5uOr82RF7cDRGRIuv+r/uiJ30Lgcabp9Ag
         3xRwPzztl6Fpf33sRgUOC8hZXqwjKq7on902GTD7OFCqsSdsWDaOyaiDnGdwIGOl2q58
         lCk+UpV5vmmSxnGoNbJIo1K2s8ucvTCz4gG2HFWlT45izydk4JJbL6W1VdZ61TpW5b1Z
         nlAsLFySjx/rD6WiGcLmZ06tqzn5Kexf9SqkVz46PAUHbg8qd5gpVeOzl0GX7adxXovL
         w89a9wPv96X/hQQzNKX7F8ih8L3IsyNEzr+fiWWIT0tJ4SmK6JBBtuqI6r9N5sQLDgGu
         J/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508783; x=1753113583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BYeSn92YzzQF+VMS4Brh9M0r6cRiJUgo31LKCP5UVE=;
        b=ciOaKct1Jbh0FSYMW3/b0h9muZTG4IaMtKq8NpZXXd+FKirYMhVfWABJDRcg8TguPj
         CZhLbzrwVpsWWLybUVdELX2+nJ9twWQanseuyvNQque2QkADaOMcMST+e+tnLQbJUA5n
         QfsOfbQCCyTaGUi2MAXLgig80/r6viSltRoAa+jHHjC36m+E6UHKPedtbN1WuwlVf5jz
         JXPnhONzmPbOLoK5LrLwQ5mN/Ds0t7Jctll3UpNR1OCq6/qpr3eTlyKLm9vyvRPZycOW
         EFuOy6943bJIgGcc/0sKa6jpa1q2Mzpg1KI/dHDjpKwirh6Gak1gLvvGGmCagiw+tXPe
         lXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4sOZyxGk3QupM5dzjKX7m5t/a2bRkFKbOVDD6SlTmwi9C88SOywH6or+6go3qCGEin0Gu4p7pnTvk0/IT@vger.kernel.org, AJvYcCVMi1/ztVUbjtATy7NsUEWdGETIDCgEbfgJX+Sr4ByoEUM7Aj72Ep+EmkLom5dvgd6p25kgPhCmu6Eh@vger.kernel.org, AJvYcCXm1vsswO/H4Y/ZwxBwt9ajq/Ndl9fLQZXoka2XaPHftaUznF7y+zTb4+yGTAkq5jszewMqXt99lFOWiqF+4jjU6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFaJfqZuZkTDX2xadDgGigC+EyP34l+8gGLWV4yomuiDEH1KVh
	kHxtf2S8y3z6HHhAOkM6BhGkMMnQoue/INaC96un8QyH7uaY3vNXUDSV
X-Gm-Gg: ASbGncvQrBnEtT7WG9Kc2s/UDIGsY965jfrSe0GIlgKwJkKgmgzwlzcoNZS2pze8SJO
	NOOjnw9E3RBj3PLNd2PVbplX1eylQldN8sDQjeqAExpjaiZ9gLx/eIvt9tzZ6BDIXcCYQEgP+PD
	UKZbeQRRWZ/nOJPYHT75B94zWXNv48VICB7bXa1RiEAR8gbUWoY2e73NLRjjWW+F0J938RCBVQV
	QF7HHu2jaW1WeAYhxXsv2m1eynn3CGLNjbP27TIUNuLRcoaFzX6+MYegaSDm7zSNO6SgRXNNRNj
	iQMZWyLXucQNOtbnit3IGM+YYeFZ1FvSVC8gWxM0AlrTi2a8U4DLA5AnL8aAdW0ck+9p0rQNqKn
	3TmLuDL7eQTxfhroMsq8/tA+m93OocN+gAdyR19bDTKmd/Y2s0RZ0NYmqE7VH8O4=
X-Google-Smtp-Source: AGHT+IFQh7ea6LSr/0o4y+3tyMlqQDNYfa/MKNj7Iq4WOAh0qAjPKYZF07a8RNp0seFp+oT3EdK8AQ==
X-Received: by 2002:a05:6a20:3d8c:b0:21f:86f1:e2dd with SMTP id adf61e73a8af0-2311e939eecmr20538952637.11.1752508782754;
        Mon, 14 Jul 2025 08:59:42 -0700 (PDT)
Received: from [192.168.0.124] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f49f80sm10152790b3a.117.2025.07.14.08.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:59:42 -0700 (PDT)
Message-ID: <be327242-ad55-476a-bed4-44c33c263962@gmail.com>
Date: Mon, 14 Jul 2025 23:59:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 00/21] drivers/perf: apple_m1: Add Apple A7-A11,
 T2 SoC support
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <aHUeUMmn_19EayL1@willie-the-truck>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <aHUeUMmn_19EayL1@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Will Deacon 於 2025/7/14 夜晚11:12 寫道:
> On Mon, Jun 16, 2025 at 09:31:49AM +0800, Nick Chan wrote:
>> This series adds support for the CPU PMU in the older Apple A7-A11, T2
>> SoCs. These PMUs may have a different event layout, less counters, or
>> deliver their interrupts via IRQ instead of a FIQ. Since some of those
>> older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
>> be enabled by the driver where applicable.
>>
>> Patch 1 adds the DT bindings.
>> Patch 2-7 prepares the driver to allow adding support for those
>> older SoCs.
> Modulo my nits, the patches look alright to this point...
>
>> Patch 8-12 adds support for the older SoCs.
> ... but I'm not sure if anybody actually cares about these older SoCs
> and, even if they do, what the state of the rest of Linux is on those
> parts. I recall horror stories about the OS being quietly migrated
> between CPUs with incompatible features, at which point I think we have
> to question whether we actually care about supporting this hardware.
The "horror" story you mentioned is about Apple A10/A10X/T2, which
has a big little switcher integrated into the cpufreq block, so when the
cpufreq driver switch between states in the same way as on other
SoCs, on these SoCs that would silently cause a CPU migration. There
is only one incompatible feature that I am aware of which is 32-bit EL0
support. However, since the CPUs in these SoCs does not support
4K pages anyways in practice this is not an issue for as long as
CONFIG_EXPERT is disabled.
>
> On the other hand, if it all works swimmingly and it's just the PMU
> driver that needs updating, then I could get on board with it.

As mentioned above, it does all work fine when CONFIG_EXPERT is not
enabled, and if it is enabled, then 32-bit process may crash with illegal
instruction but everything else will still works fine.

>
> Will
>
Nick Chan
