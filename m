Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111BC266F00;
	Mon, 14 Jul 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507475; cv=none; b=e2ttRFKplnlJ7UIdCU6DvI5B34h0bc2nUmU83x3KhcvSd1ChlXMw++5LsxkfErL7VNiCy3pOK/xj+BxV2hvH2BJfUgAc2kw2vEkH2aaL9q0Qd+TtcOb/1ETNvff9KADflBXOjM+h7i9WdjaNKpEX7dsbvyBsnf04MUw5++p1Xyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507475; c=relaxed/simple;
	bh=QjQ0UWlscOYrLTxqfo8jeI2W2cZqq+DP0CdXTDyGEcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0h8mrEZOGTLmkviyWOdReZfHlpUNPM3MA12uiuQYd3kcLD+kJVu2I5MV6W6ul9dByoyR5gQhos7i7iPWlGp/PTR2ftaTYp0o+4VH5w9ewLPIYy836FaZW+OBed/KiZnMK270wI0ow/WPBrlaxeQPxRl8qMwgWCGuX8ke+A/h1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDIzDkx3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDIzDkx3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235d6de331fso49000075ad.3;
        Mon, 14 Jul 2025 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752507473; x=1753112273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjQ0UWlscOYrLTxqfo8jeI2W2cZqq+DP0CdXTDyGEcE=;
        b=NDIzDkx3Bq3miRT9xFy762nSk+VGxI7KaInx3vbv9Y4NhVQtZ6ybtWPFbPhB9gxU4D
         ePbVztjRTcOzAti4fiu08gUi+UQkG6ZoTQemQQaBvTIMjsDweJ/dogdo/FNRMwXHXJ1F
         X/8QITXAAS9rlU7HnALobpC2hDJYGoYWivRlmr0nj9zrrNuzSheC3OgYI3eiEPp5Fnbz
         qsfDNTbHwuWc0hxWi+hgO8TGrRKt+OFytpg9xRZu0Xr7FApPy6kigFT32t7kUaaHdMig
         KqCJvRxm21j/bf728tCB4PnRKwCPeMP47yXB73+8yao67/ma0l9kBHxZ2XtGWpYfXXhB
         1vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752507473; x=1753112273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjQ0UWlscOYrLTxqfo8jeI2W2cZqq+DP0CdXTDyGEcE=;
        b=rF2HR3LIdrvATzjyL00vSNO7BpjnA2mQfI9tNaUEfGUycPHCygKfc1pVMlbSUjO7na
         Pcmo6dYuk7chvVNx5MLDKGhQDPGFDCVnJbAgC6yJRZtgF+oJx/35UAK2jmOWFY0pBF1G
         5KBrki7bBgN17qAPIauxA8APzMpD+wZzudKWGwMS+8r6xnnTx5eVhrXwl9oIn5iBfc13
         inQ07lQt63ZMoA6VmxJcJQ5bg0MfKMuwLTmFxcOkV7MraeaS67DQyl//4OCcOZmzFR5R
         f1GW+cEpK8NVdz9dmqQDGNbQ7NEjN2i0POv2ERGwYUU+1GPOlr1RqPzfUK5Os/CgwWmb
         PEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBfRLBjDipB5tw5LUj9Ng7BnSq5EujEaSFEnl032umR6k6k5YDbAuWOp4J1vQWakQuN5XOYQ+dudWXJFNlN7MdLw==@vger.kernel.org, AJvYcCV4N5KsdL1+j9qP8XZc2Zf15l/2qieVeWQYs5N1wWhXlyRJoy9O3pJrlv7usWtLDEhqxFS/uKLjvRRw@vger.kernel.org, AJvYcCVx+BvPnFI03PRISEsXi8v+IN3ClJNjd0vWGsylPWgHo53LcNMo8DnKDke9sxlbHsc80E6Krd/WCCOUcV/y@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDAR+Pf0JhiCdB+x4jAgiMVWyCncuXiFWmL4CzQjaVZA5+hqt
	T4eZuCaOIiKa4UB9u26F809NLc9dCkznZK89BRrZNL7jvN9sZiPJq4YpBLwjxo5qQ7yMVA==
X-Gm-Gg: ASbGncue7fjHoZJfvE7+VgjY2NyioA6IIAffTnJ4BENrsfPHARXOqW3IJa6zgNdS6xt
	FeaRRv+3Z5gP+AT5wM1Mre4HxaZbFtxd8d6yHCRea/jXzlktAVjTLBnoB7uXkj2eeb1dozdWRBY
	re3shj5OnoNpADnramLofgs8j6y3OR5WJ0ZFZOlZuj8qpMBcdXbTvj6UV/wA9vv4PL0NIFoDhWr
	kOrtFvGsoA7NOuuOMappdZyJ684WpnFsWXNmMg4G4l4bgsnw4MBGbI1vunGuzta0fTDjTEuNfLy
	q4aJtwfYhkT108us2tBYWJKI2Y6ws8w5vZAmUq4ZmStaL9y6sitVKVVQV5Rbg1/6WqHDeOJdghr
	W9qMW/haZv7PFom1R4L8wCtvzFFjSuLnhlAS1E1PYHzATD87HUSc7We4IlDHZbS8=
X-Google-Smtp-Source: AGHT+IEMvnX379Cfqxjm8d/1Z5fQyV4o83jOtFXuWtyBzvMeYslcOx4WAebdY0n5WCMLCRYgzq0u0g==
X-Received: by 2002:a17:903:a4f:b0:235:f70:fd39 with SMTP id d9443c01a7336-23dede2e17cmr167967685ad.10.1752507472927;
        Mon, 14 Jul 2025 08:37:52 -0700 (PDT)
Received: from [192.168.0.124] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae9f5sm95068015ad.66.2025.07.14.08.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:37:52 -0700 (PDT)
Message-ID: <81addd64-6ba6-465e-901e-05f9cb29185b@gmail.com>
Date: Mon, 14 Jul 2025 23:37:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 02/21] drivers/perf: apple_m1: Only init PMUv3
 remap when EL2 is available
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <20250616-apple-cpmu-v7-2-df2778a44d5c@gmail.com>
 <aHUeNpx6bsC5Gk3b@willie-the-truck>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <aHUeNpx6bsC5Gk3b@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Will Deacon 於 2025/7/14 夜晚11:11 寫道:
> On Mon, Jun 16, 2025 at 09:31:51AM +0800, Nick Chan wrote:
>> Skip initialization of PMUv3 remap when EL2 is not available.
>> Initialization is harmless in EL1 but it is still a weird thing to do.
> Why is that weird?

Maybe I could use better wording but if the check is not here, then for Apple A7 which has very
different event mappings, it either has to use the mappings for M1 which is wrong on the hardware,
or declare an a7_pmu_pmceid_map, which would just be dead code since A7's CPU does not
support EL2. Not initializing the mapping in EL1 avoid these problems.

>
> Will
>
Nick Chan

