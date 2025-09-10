Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196AE2D0639;
	Wed, 10 Sep 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493097; cv=none; b=OSZrP4q2q1Thd+M8JBnAfO6oH3Tm0fNotsAUJhpcKmLCWAoy13HNdd/3bTQM2TCYfgjCZDT2RgvY4MeJoWn/amQIqpx5NVLWlaA+IQtLnyqbtApi7ds7tgd1hxadqSd9KUf+2JcY4YqbtYrly6vlda+inR+ugpeNnzYHRBeeFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493097; c=relaxed/simple;
	bh=z/y9SDPa5RivZXhVP+3sMoBp/5DIxMZDzFaym+YBtWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMeggzgDWM4e67/ORhe6+OVUrZ99MnrGwx6VUbol9e3n+VaQXQYQ7OcY9IlwjpCazxIIKq7cjbSqAXuG3B9wDp25c4W08sWGosF113RcH4/XPQM/N+y7LDzOy2wEtB6BOuqlPCvudhLFLjWiAcXQxzG1Ph1nHdJNHXTAC0BnBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy29mMHT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy29mMHT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so3531095e9.0;
        Wed, 10 Sep 2025 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493094; x=1758097894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZiUguKRHSjLNl8qev2KvUrL6xayZ/2jdKMeAroqeQk=;
        b=Sy29mMHTWQ2QvcxSdL+y76eMTUfEhXOFLLYMHXfSw08P/faGB9LbZHk/9wILfByphT
         be6M4Pq0nDs2/AFBd1jRXSPvn/ec646vDemWAVI+4sDQ/dlAkbTXED1kmtAEYO9BbqZq
         TCOwzmHIPckYyvJ4ZyKOdci1lSb45kF8MJEzFwIdrP3oHPuav80BweJUiD7JsjThLDhe
         uK3FoJXggN9wYE5E0ijkerIA3ZXBfe2yXNf83LjZJAXsYPLKLuGEoNE/9mMS/BlVAwFN
         r8TVxGiyLIJbDCV3HT2YZp2hhEPk/9m68UwEszzdknhGQS7B3p1I3ra3QRvCe/DYy2CM
         ivqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493094; x=1758097894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZiUguKRHSjLNl8qev2KvUrL6xayZ/2jdKMeAroqeQk=;
        b=J6AMOEbYkNJ4vsstjNIC8zkWKczpsR/IPt2+paKpRsxV1i9dJe6O004LtEkBG3rjr3
         5lr416wu8w3tAUQQDna2a4E+kNMsR74is23zPE+5OAzo0WcuhYZO1G1CBdRxESP5kwtt
         O86e5oF5gqzg66s84xs4s0sipscRZpuh2J+krdCS/PzB8I9xmy/IdvhwmP6tW7HhuVXF
         GN2UlTf3LiKIXJs2Htlhm8PAI4MB7h7v1X01pdnCf+9+H8fepm5Sqk3KtBTRTZDks0yD
         FyM1WARp/w0NNf1vxDqn2j4XwZbH00GkTVSP2aH5KGfEym0CpoPLTXU89AR+6ttL2Rtp
         vLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBbaLyDcn8w2ZAYdH74D5leB9RxTn7Y4BULgts1BLYLa6re2MTIjCwvTNvS+LNAACGR9hCYKCsarQbzYQ98i0I1A==@vger.kernel.org, AJvYcCUVSnZCkt3VHOcX6wAQ/8SXceJreZADfdWVAdvMr00ex5b8heSx4/Fv9duSRvgROCmiWCzE095kV/J3@vger.kernel.org, AJvYcCUnXfXh5lR3bUI1sbLVgu1SXMc1W5W7ot1P/MkfqWn4KdMAAfi0k2w6QKJuBLi3s/rPvl6hXk1seNm6@vger.kernel.org, AJvYcCVYSiLm+rOzTCyBOgURDaMgWFA8JmcFqJK5GiwBp2LC2U9a8J2ryDygqDF7xmCSJTsEKe+KMNJRu9RB@vger.kernel.org, AJvYcCX+8mKA6CnJc84gdNyoBafW92NnGlQZtPVix83QZXllpmMmwKtMjQKl1JtUSTL6HDBiTbrD8pYhgAYDsqkK@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZVwPU9uBGWgYjkKhsWnYZnmqtwi1sjYDDmolr+1VKMM3VJy8
	EM0ti+ZRfBKbPV7jaqb7Zuee+X3dNLdc5Yyhs7uw0dEU2PyIYdfsW2TE
X-Gm-Gg: ASbGncuTdaW1aM8cvHDIRnwWjouABWXg0R0usz1fmn7OClhJevlb37N5cHzwOpEhdpv
	qJlyDGpjwDCS+q1CWjPjfcJBV0BHIv4m5sToJBnzezrwKW1hZlMCU2nsxo5lqtF+rDKnFjbl3Ax
	7Z6fJLI8LOdlKPF71jZxC5aSovEM7AjsLVD47YoJhMvONlCI2MX+LZttZ19fu/sW+llKz5C4rtE
	QSP6Y9QSgcIsFwwJAvkEtgWWra+kFvduJBTc6W+bvPK+AYkAZICz+0uG3RLACVtYfnWVqdlqwmD
	Mkrh21U7ZPG/1T6kxb7WAgkRTJ3LsAYciVhoKKWq3uidgmUm5s2UHr47majRRRbpCm9xCNdLxUa
	i2wGjfFkt3Ve65fpiivgxjesZ6mTU36wmM8Itp9dPBlK7aYdR7cfbhXnFAKAldh0A+jYJC5k9Qc
	L7pAn9EDZ93KN/DvMw7MQrPO0NDHH1jnsVo2fF0GydaaUBr92m7mhmGzvwEbFnanmkbqT5ko/ho
	Q==
X-Google-Smtp-Source: AGHT+IHtxpNnwR+OSaL4WHAtvZm3SZwKKJRshnL76nqSRl+ub9r1kz9W9fnbmNI59d2V+S62gNIBxA==
X-Received: by 2002:a05:600c:1907:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-45dde1b15b7mr140442595e9.6.1757493094104;
        Wed, 10 Sep 2025 01:31:34 -0700 (PDT)
Received: from ?IPV6:2a02:8440:7135:4f4c:9000:7072:695b:3ef? (2a02-8440-7135-4f4c-9000-7072-695b-03ef.rev.sfr.net. [2a02:8440:7135:4f4c:9000:7072:695b:3ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75224bc2csm5817574f8f.54.2025.09.10.01.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:31:33 -0700 (PDT)
Message-ID: <4066608d-af1e-41b7-ac7a-6c0aa3791c2f@gmail.com>
Date: Wed, 10 Sep 2025 10:31:32 +0200
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
> 
>> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>

Hi Krzysztof,
> 
> I still see in this patchset around 5 different subsystems. Nothing in
> the cover letter explains the dependencies, so grouping looks like
> coincidence and you just make it difficult for maintainers for no
> reason.
> 
> Please organize your patchsets per subsystems, see submitting patches
> doc for more details.

Yes I agree it is a big series.
I'll split it according to each subsystem it targets.

Best regards,
Clément

