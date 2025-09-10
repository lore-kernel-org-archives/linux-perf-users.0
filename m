Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A142D23B6;
	Wed, 10 Sep 2025 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493290; cv=none; b=BMkORPhqBFtMeAoRqDGicBWg9jPa3m0FRqgFDLx8XPcaki8RTCF0UuOVPVyBRnl7lyfUZ1pNtIm6dJMAnopKDoMSBeycQ4lYmL3YfwJo64hUOJK4KUpgago7+4STZruXxWJm6C2GLlzIhvnQTtnh+RUZ/ciwjOzD/JSFlEObxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493290; c=relaxed/simple;
	bh=xcnQqscGKsKb6v/bCxaWU5aNlfSk+7RftDAfiQybNIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDRASNL83F6GSRdXFOE/WjOqq7P9fhzo2PEbCmeEmjfpQ/d76TERYmPE5yXfoNC4mPU4LZDnMcWGoiEePiVgdTR+O6aSA++uVFHfnWSUo5LPcyKWNmhRLSDHE4f6EnkJnoZO+g+7QhvExphIyPcQcIBIUjP9Fubz2dbSiTt/GSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPMJJ5L0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPMJJ5L0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45de1f2cdeeso21548035e9.0;
        Wed, 10 Sep 2025 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493287; x=1758098087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvxtkN58s90JpLuJgBRzi7rdiBNppM/NXoJyMRiUo58=;
        b=WPMJJ5L0Or45drR/nmYinu3JNiok5ntx/s2hbw8mnoPTn8a3yJ2CihgOamLTMovU2I
         mNQGjmS/HXOcc0hbvIIIc9WwOn+D+fbCQgZZ5x/9+o1CUPfeAT70ve9dsWA+tFvCUobm
         CpP+/PShbMs6K0NtqAikfktuvqcgQmi8FbDezvSnRCazcByrM/ens0MS9gx7nAaLdjU0
         hA+NMSaq06hvX67cDPpsqYzo64CeCRzpAVaXSpcQc7yMQfO9XFV+Yko51qkkxserbvOc
         nfl0A56lbxYnMHMjjnUH/EHg57oLh7EW5Xxco9xPYxdXgsuK8ClFXy0dOvspCsUftFGL
         hcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493287; x=1758098087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvxtkN58s90JpLuJgBRzi7rdiBNppM/NXoJyMRiUo58=;
        b=LnoPstT0O4lOZNFkq+n711jQ2esx/L/hDFvm4C8vv2Zr4uyFqeFAmoZ+Zo/xpJKuXT
         nRWCijmbyX7WUUdhwlTayAGVNCvp9IH3zM9z0/OKuFJp8TDciG5dVqDQ3CeuH1qM4iyG
         P+aP+I3wUbCn6b0Ld6SwsV+Q/+DGy/oIB5akSCJSNRb1D3ROd35hNe7vdd2Js+AJZV+J
         Pmw5G11Eboilik/PACdtG/0+6l2OvOefTsuLbtOpCZwcxt0K1/FWtuBjxOzrEMEa7iJl
         rGcADLNCI/tvhtN0gq4jZXf7Oe/VICoJ1PA3159ufa2gly2LHU0ElbbjpZDdMFSBMome
         ZXww==
X-Forwarded-Encrypted: i=1; AJvYcCUcdoRKNh6izjQG0dCOmZuPS4k4oaWkvvZmMs4Qk0WtsUcbDWt2alAE/uoyHOwAcDUUKVGPEpaUnuLv@vger.kernel.org, AJvYcCV+nXHnfjTmnVP2UX1DuZ1r843JKAgbbEjuShfABR8BBrw+8xRuuN7Vy5ycbAhaJIjh2B67p9Mtez4n@vger.kernel.org, AJvYcCW9Gq7exrYsBdqC6UxzcwrvXEfS/RWGiOMIcdTArVI5NbyotXBDG0WkMhT56e9TebTXTea+0vPx7TOkK2/ftgjI4Q==@vger.kernel.org, AJvYcCWVtXQSvewn5afiOmzMWrMYjbtBOfQpflBe+8VQAa3I8tfst0cIst+2OxUtg50fs+S6WjpC7fdRH63T@vger.kernel.org, AJvYcCXu8b4G1pY2HMpK8uFYZqwhDWo2LNZCFG1jOJ+BnyaSeff1NKg0gRicsTqIhq1THRwmzURUI/sI/jPz7dcN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2Gehi4Mni0y/IAaM/1FcfA8zXQDeSJjysv7emT62guOMklcz
	KxYPYJP9bRt+UOFsu25nPLQUrmuJ7J5weD/Fy7HxnKiBqwyNTRil7J4u
X-Gm-Gg: ASbGncuC5DhXuth1seC6Tvod2O2wr+Kh4buIUU1RdUIStnjnXBa7Q8xw+9xUgsfl75S
	9jWB/VCTil9OE6rbC+R3xzz+cJb7Td9jEPJYXy9Q3mMsWYOLd8TDVVm6ix+qpcIZxk858AA0vph
	bO7OwApBbO5CQ3RqRKW09t/gfBg+jIBLBWMAdD7QHrw3ZwyhqpNzuIXndlGiwZv3/BtnLQNOswP
	OoKxvQG52Dcrd3xD8r/7eWJAonvxk5d6L7IwyrcP0h1iBRUqRin4EPWgh0JJVQebL2F3WRPIfpf
	i1wIji9JpOqYJatEtbX8REW+9P8H4iHLfj/8pppk36ycjsjnH2IsfDLvRX1UbaqbwRkVrYlLdE7
	X2jPck9ZvB9wW/Oe2HLf6i1JIJnlH4L9f1vp7VOYv2hHtkO/5zVWRy8TTstQ1uNzvb5uAexVebH
	SPYJxlSWf7nYVIKKm8nT/fKxMxiZzsuzHxgQcDDnlM8Cqhcw5lca3kPFOLYEN5qbA=
X-Google-Smtp-Source: AGHT+IEQEEKz1G0RJ7Rv5RJrQMqTp7wb9aYAHyNKeRkV5T6QpUQaKrLWSe8p8sLtVzT2+/GsKFY/hg==
X-Received: by 2002:a05:600c:870f:b0:45b:8453:d7e with SMTP id 5b1f17b1804b1-45de072e865mr136738135e9.6.1757493287542;
        Wed, 10 Sep 2025 01:34:47 -0700 (PDT)
Received: from ?IPV6:2a02:8440:7135:4f4c:9000:7072:695b:3ef? (2a02-8440-7135-4f4c-9000-7072-695b-03ef.rev.sfr.net. [2a02:8440:7135:4f4c:9000:7072:695b:3ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81e1e00sm19751505e9.10.2025.09.10.01.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:34:47 -0700 (PDT)
Message-ID: <e40e858f-091f-4059-a379-7aa25835c3ce@gmail.com>
Date: Wed, 10 Sep 2025 10:34:45 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/20] dt-bindings: perf: stm32: introduce DDRPERFM
 dt-bindings
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
 <20250909-b4-ddrperfm-upstream-v6-12-ce082cc801b5@gmail.com>
 <20250910-encouraging-masterful-dodo-3d1f60@kuoka>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <20250910-encouraging-masterful-dodo-3d1f60@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/09/2025 09:57, Krzysztof Kozlowski wrote:
> On Tue, Sep 09, 2025 at 12:12:19PM +0200, Clément Le Goffic wrote:
>> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>>
>> DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
>> It allows to monitor DDR events that come from the DDR Controller
>> such as read or write events.
> 
> Also:
> 
> A nit, subject: drop second/last, redundant "dt-bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Oops, it will be fixed in next version.

Best regards,
Clément
