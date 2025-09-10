Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8DD2BE7D5;
	Wed, 10 Sep 2025 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493707; cv=none; b=ZQ7u8jcNEPHrO/13mqUcXPJfIBK4G0sqawwESK456ugccrEW3O18A2xse0viNW5LqF0Bs5ONZXjueWwBj/nrMBxG2b/BDlBO9TfuO9dEJRvLchsh9rFhk6GwMO44prV55Dl/2bn6NdAL7dqpQZ3TJc6II5U5dKuS0LFneVZDR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493707; c=relaxed/simple;
	bh=WXEEu67YxLZJ0AVlikwwITZAXBcBgZXrS90WmG7/K0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfVvCYexzPipzCUd6pIxr8Op50zy3FCSXvhvU+KPvhKx5Q4NK/y87nLFlZXjcWh2M7rVYqzNlHexgqmrL3lljiFVjoQ6piwkZ2pdshEiHvPTzkk5eAZv9fC8VyY6ceAaZWh5cAJwiJle9rZ3RDiA8YukCN38k2FV/p+3tpDCFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpRI2CqC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpRI2CqC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so40558585e9.0;
        Wed, 10 Sep 2025 01:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493704; x=1758098504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3IKUpQfaLekPKjen96M//7ifX26lwnIh4aj6a3++lk=;
        b=MpRI2CqCBsG0v1sLGeXXpbe6zcal6XaDBbzaNfxzVyYHxTvynE5srpo2ZHAIFIjxAj
         nTa2CVx1SQG0XyMRnaLQfxc9x+O0hdSFZYDeWPte2YNxZDdfm+F5+ZVIN1b7HMyr69H8
         4hkoGm/7nLtQ9OVRgC490djfSXkK5RpDkNmz7Q3Ktzm71Ujg3pflDBqEtdNnkhqgJ7Qx
         K7Wiw23lm8cwi4gHw5Cc44HpFJBf7KzG+5yag1nLPzNCEcsATHNefCMngBJJvQ0EzQy+
         K5fG3IbBnKsI4rae88EaoTTsOUd+BpOkHzer5jy6k854auZM5Zlev0N+ybodTDUD2Pdx
         vFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493704; x=1758098504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3IKUpQfaLekPKjen96M//7ifX26lwnIh4aj6a3++lk=;
        b=f8pImHltOEx6MiGT/kPYJn9GMSd34OQ++jBMDUmFPQPXQJZPpABbWsnY4TFI6UJ3dU
         UZA6UQ97FefxdivRJCimaUqePwmQQlLtpYNCaPRvAxdpUsoX+CSh3rPqN0EP6TTrLeyg
         iWdNKKqhx8ngV7DP+r4AtRc4wuD5ysWqDOsgPBW0boUYo0lVa3/ldg2qGo26JRdzFfzq
         3Sy8bTGvVzMulEY/ftPbggPTji3rwoghuIWQZzO3a1D/j6/b3s3gXc/dxPhn1zpiKfzk
         gUGf5vHGzxYjOSSFxhb8BVyFZzJPt0+e5ThQgMk4rylnIZSrZhTK2lcYoBoQdsU+/XVX
         IuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR3VoLNvesKy7Cob8Fq1jYWGGbTDRjhC70fcIEoTyheOuN/8PoYZ+9zelcrK6TJbLvZOLADZZXMpHy@vger.kernel.org, AJvYcCVvB7qT6V+1rE3WIIF+te9wpB9nZi+KD++uqJKZQM/ZSWHNVvTajhLELRcgkBYasSaTM4O7sQIwqboatY7u@vger.kernel.org, AJvYcCWnmPuq0aRBpw1IfpMZS6Xf7X9MbLiLY9K1Dv/JBZPhT1DC0SovNTWVj0iKOvC09188hX3hnzC15Y3B@vger.kernel.org, AJvYcCWwusylzWsjpaSw9si7Qh58UTzAHAkwBUgkweomF7AH9EsKYHOnpTDVCMBKAZMyGSzOuIv5Yn5h+fcA@vger.kernel.org, AJvYcCXAFC3GwuTw8TBG+pjsCEwbndYDIN/GuClaSUp+Q6GVsJQIgSfrmEnfo6LTAccZJNtxQGStrXYaVuubI7YC5L8uGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqk7XqjYVLz+9aNHh4uT2fICD/1kYCEzMNw318KZsLWJN2OqtQ
	64rtfw7u+get86A+LC/FOYxhnpOJ+wqZlLvgNDOL4RP8p7a/BifMpKR3
X-Gm-Gg: ASbGncuaf16pYCO9GRVGIPbop1HNG0vodPSjHEDppUjiZ5fVDKrLFLNI9GFKMdY1Rp5
	l2uDLnu/wWXPRGiSwTEH1awPR5N9Tr6miXm0FsFX66RHla4Nzpv1354MvU07Kj5nYLs9yZqfDZT
	WEzbyJOQHBMSDuLgGYdVyLvJ1CrqVCwtCkZhuJhXbSOeJwyorhBLfCBfCHS2cganWQdI0BIuUvD
	0DbA8G9GaVLLll1sHRYaNn4CEYkPE8Fv8xg4aCPXyyV3TxyKARwZ4MALXGC0G9AmE1VU5v+cnSC
	Y55b8IZ+5xy76EfF/JvbR+sNlgmtHwS0ihcG77x0MlPe/R8OYXIQCYu8S2e4461KAfbK0plJTdB
	To6fZtL9Vs9PU5ckLWG/zqHh4p6baCimHQiFi63H4CBDYmvbCCQGQbYkPlnP3sJWAC8pQGT5zND
	T5gBM6WoILQvrbsyRSfnIJncWwtniILHPXFJJUWOweEBHZqPcpp+lrPuAIz3dmXzm47X1HpmrcD
	A==
X-Google-Smtp-Source: AGHT+IFAC+KaKdWZCDt0F29FwBEVeFET6FJu2DQLhogXKqRlrNmNAmvGOz7dmZmfwY3vjWPcfaiR9g==
X-Received: by 2002:a05:600c:1387:b0:45b:9c93:d237 with SMTP id 5b1f17b1804b1-45dddeb93f1mr119978935e9.14.1757493703536;
        Wed, 10 Sep 2025 01:41:43 -0700 (PDT)
Received: from ?IPV6:2a02:8440:7135:4f4c:9000:7072:695b:3ef? (2a02-8440-7135-4f4c-9000-7072-695b-03ef.rev.sfr.net. [2a02:8440:7135:4f4c:9000:7072:695b:3ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81d3ee4sm19382275e9.6.2025.09.10.01.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:41:43 -0700 (PDT)
Message-ID: <899eb863-6b6d-42f0-9e7c-e2020ee45f4d@gmail.com>
Date: Wed, 10 Sep 2025 10:41:41 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/20] dt-bindings: memory: factorise LPDDR props into
 SDRAM props
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Julius Werner <jwerner@chromium.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
 <20250909-b4-ddrperfm-upstream-v6-5-ce082cc801b5@gmail.com>
 <20250910-flat-raptor-of-temperance-5e8c7c@kuoka>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <20250910-flat-raptor-of-temperance-5e8c7c@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/09/2025 09:54, Krzysztof Kozlowski wrote:
> On Tue, Sep 09, 2025 at 12:12:12PM +0200, Clément Le Goffic wrote:
>> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>>
>> LPDDR and DDR bindings are SDRAM types and are likely to share the same
>> properties (at least for density, io-width and reg).
>> To avoid bindings duplication, factorise the properties.
>>
>> The compatible description has been updated because the MR (Mode
>> registers) used to get manufacturer ID and revision ID are not present
>> in case of DDR.
>> Those information should be in a SPD (Serial Presence Detect) EEPROM in
>> case of DIMM module or are known in case of soldered memory chips as
>> they are in the datasheet of the memory chips.
>>
>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> 
> Is this email defunct now, that you add second SoB?

Yes, but I still want to upstream it and was thinking to keep the 
"original" author even if it is me.
Am I wrong here ? What should I do ?

>> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>


