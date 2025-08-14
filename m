Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332A32143C;
	Thu, 14 Aug 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182445; cv=none; b=JPTAEXT3Zpb1C1e33di5y3FwOiVyDUl9x6iA5p5OvOnxKLudmQtdwk5ZMjil43YtNOmlyhjjEoFSqHENcleXE9NI7bgItAveHJ3BSkgrm+kjEj0wrPQABPU4ESkzTeqS+Zm5CTz8rU8ChtvEbIP46xI1jzsyCFpUf7NCXfsZ/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182445; c=relaxed/simple;
	bh=3QtS0ERTKMX5YBda6xA5ASwtd6hVEodKEmGIdvNvVHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlDI50YovJ4Byo4WOhVYGxRC2LmJUf8ad3HUSk85MhRbhDZXpRtT51BphwDlHPen4bOyzZvnuI4g+QsQPjTc5uSepqBfIA8I4399mgx1OB6l0BFdUS6v3yMSKmLQIbDk1Nzthc5SbJofD0zfcfigX1yt6XZhMvUoEvmwci0aqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC0ibIjg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC0ibIjg"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9edf504e6so513668f8f.3;
        Thu, 14 Aug 2025 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755182441; x=1755787241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8eKDxpRJVTIzyGI66oWlYnjcg0q+lXbGUZBFK9SZ3r8=;
        b=LC0ibIjguiRP7RmixeoSbXfdFf8scP3qgpHaUxq1qI5m6UtwASCVexwe5nqQR7Eolz
         64yO2GXCqRrP5Kyx1k42XyI2BsJmKXioHpQGs7FleG1Q8v2OGYpp70s+JqHaiWvqgYVv
         RqnH5hCI+qv2fnJWEjhzAhlb1VLO38yJnpc+aYWObwFzuPjO+0CDRIndtNRDHqPviDZu
         UNQxzZwqstoBmG/gwdjEnNw3AYH0CHJEivKTxecXfdZEVV7KKku1hFQVlMmqP73g/8Wa
         PFDVNdcU0zNJVbETcFMItdKjbOiFRz/n0iTPNZh1IfdBnzBQ1D1xIHVEddGYWr0T3LjU
         4Jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755182441; x=1755787241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eKDxpRJVTIzyGI66oWlYnjcg0q+lXbGUZBFK9SZ3r8=;
        b=AKQCr3mIYKRNyQ2TLFVLccopHaXHGr1ZvSw9qVY15uxvwC633HoBKtDqlR87sUbpUN
         kays6WDaCX85eCdaJY8HlVfkIuAp/Gy3gho8ui/kH+UbT3n6WeG5RgwLYMY6YHJVtjOx
         ll2Enbft71o7FkVbgdzyoLkdHDN7bmyRXqUzxNOLDfuAKwpDMYLHVhO3mqZUzbJUwi5r
         TizC7FVjRrrwNUc7FF8QkTgjoylKFo4xRKFBHoLq/PdAP12Nj/m0aIBLs3mtMDaZ2s7/
         vjxQA+wuZ1OgOG0tGFjjIZkhaTZnqgI7GB1IeVT9cRI9UUDXgHR5rPLWI4mAKI8EZUbz
         5z+g==
X-Forwarded-Encrypted: i=1; AJvYcCUcyGfSL9bPlZZbQ/KygBvEBuOYSj213PASns9o1My8InUNcoziiUYhvXXTtsblmlWk7JayeQoXs49S@vger.kernel.org, AJvYcCWBLI2hJJGSBlXDX4dZldY8+jDib1UD+AcjjrbDNXu9GDfQLSyDPg0rW5swNRiHf0scaKPn0vfJZfNPUNTFowhz2w==@vger.kernel.org, AJvYcCWF9bUyJOY3dFD68JEoMjampGZ7e9QTy5rwGoIuJhMiV43m7xW7HSxxY/tUoxM0bLbZUDT2A3L+gcLc@vger.kernel.org, AJvYcCWIZVQf8hD2j9CDiVMMDOUSbntx0xfJs8DkwJ/tPg61pv/0T7XjbfOD8A/9G278wDP5j9atX4ksiQv5vXSV@vger.kernel.org, AJvYcCWy1dhhRfGjsjWOIxI+IMjVmG1QQhdxcYvuDERviwPradB02AWm1qTeOdYUcs/gSq+hJL+wiaBNfcJF@vger.kernel.org
X-Gm-Message-State: AOJu0YwirYdsqalld9ksuZW2p2DB5a088qjAyKbpvccxy5WU1CYBbPsk
	Q4EqtGdk84Sbi2a5/AlGANmSDidz5/sfLgHL9TcpPmwjW1z8IZOENp4Z
X-Gm-Gg: ASbGnctbLkAeREDvaebCsSIrnbjePcqq2QflB19wZ+os6Gf4TwhktvS5XgViTpYT8Kt
	I9P+Gmjrxb+CJWgZ2FtA18dloFNGrpITCvg7AWmLNFqXtIMgSsxURv4xjsqjEItEsHxz3EzNyQ0
	g7QvEzT2pDYte7RPKAH32eBV03TMAUlaRra94m9POJ49kx2N/i17rSobC9TX4+u+riQerur/9pY
	n9WPpADONxx257f7YP+zx6/m1bSf3FjjvQVmKf2wuxPkA7o4zZhy7hkfNodZtL1dpKd851KvdCU
	4ZVDwxtJAIDCVM2Uu/BP85NA/YV/lCOXrHTSTZNwvifH3owC6bW5nYCR6oZlklCCbk44RPrdoR/
	UUh1RsxfmH+fxir0ABmOidVzZgWOInY9oFeCZwL6CE8cFNt/jRwVEfNsYQCOyANYtpf986f1fGz
	i1sD3lEjTJP9ear3dN9hO6eh1EkSDilTZxZin57Ird/fKmnKswNUNvRvFTJYwi708H
X-Google-Smtp-Source: AGHT+IGIl6W6nr22Y4YoVoUfpGIRuQbb/HUttEupcp6PwkaGiEDhgt7ofHOiURySJSgcpN1jAaaG6Q==
X-Received: by 2002:a05:6000:4006:b0:3b7:98bc:b856 with SMTP id ffacd0b85a97d-3b9edf5b3bemr3100715f8f.41.1755182441060;
        Thu, 14 Aug 2025 07:40:41 -0700 (PDT)
Received: from ?IPV6:2a01:cb08:941b:4c00:f383:4db2:82a:81e9? (2a01cb08941b4c00f3834db2082a81e9.ipv6.abo.wanadoo.fr. [2a01:cb08:941b:4c00:f383:4db2:82a:81e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b1d4220sm17216425e9.0.2025.08.14.07.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:40:40 -0700 (PDT)
Message-ID: <05cc39e7-9ec1-4ac1-903d-873f77c3c79d@gmail.com>
Date: Thu, 14 Aug 2025 16:40:38 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/20] dt-bindings: memory: introduce DDR4
To: Julius Werner <jwerner@chromium.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
 <20250728-ddrperfm-upstream-v5-6-03f1be8ad396@foss.st.com>
 <CAODwPW8ZXfMdFL2=6ht+BvQq5_LQkwHhQJT5j9DcseEx9naXxg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <CAODwPW8ZXfMdFL2=6ht+BvQq5_LQkwHhQJT5j9DcseEx9naXxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Julius,

On 30/07/2025 20:29, Julius Werner wrote:
>> +title: DDR3 SDRAM compliant to JEDEC JESD79-4D
> 
> Should this say DDR4?
Yes, absolutely.
> 
>> +examples:
>> +  - |
>> +    ddr {
>> +        compatible = "ddr4-ff,f", "jedec,ddr4";
> 
> This is not a valid example for the way you're defining it now anymore.
Yes will fix it.

Best regards,
Clément
