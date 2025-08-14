Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC03321427;
	Thu, 14 Aug 2025 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180408; cv=none; b=V+Q2/RduAfCvZjCoOH5gmgQnTTARjegyNhms1i8s9uHSXADFQWmziOuiIIs6DG2C9tZ2hf5FRwlohzlxFxAI/vR6cwIV80W08Gmr4SccsrwL3FwQG8c7Ult1DnvobevL+O7Rh1mkYZ+12RI7Ve49B2uCEqODcjN+c99sUC0bO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180408; c=relaxed/simple;
	bh=Ybxk1TB6zRWIfSh85LcO2RRx7atnh+AZLW/N/PE9Rcs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mUyBNeELNzOgCUg2jCxasK5M0tyAJx4y2+4iOd4iGHu+uzUhvGnTAFVuQHBhVOyub5gwG+5ZwnmWbi1n8zIl04Qd0LezxmXFaE9F6VAI46c2atzEaicVgPxJhdc/IBi71B14SjX1bjnjSMfLbk1iLXBdW9lZehC+G6ufMKoCUGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEOyQxV2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEOyQxV2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so477264f8f.3;
        Thu, 14 Aug 2025 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755180405; x=1755785205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qda6eKiChu1mXCojr2a5Wn7iDIeLm6m2hQhqg1Pn4sg=;
        b=UEOyQxV2fDgRPnaeK13ztdYlFtXTWFg64MhSQhLr9GeLlZCAIn0K97TQUBfP2+SduR
         Al2JfRyZZm2u9JJ+unyZ7q375+glYjQQKM//CeKBjP5J8X9bPHWSGRhkqB4jZqBwu7r/
         zDeOnVfox4n+JUoSrqeNesGOKMb83hXBKxU/u/fKv/zso4XPrGfUQ3zfSZAAnYSTa3Jq
         4aNoOVJJLBXogTTu0NQ8CurDLFA+ht0Ft1GYDCW1hLAMqlbDCGltE+j+bYeNU9j2Ll2P
         YSTD9iAT5FxvILJmBQFpIenvZyrbq0VRBn0ef1UzMXHsVNYOoGnI9qP7rwfTW90b90XJ
         B3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180405; x=1755785205;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qda6eKiChu1mXCojr2a5Wn7iDIeLm6m2hQhqg1Pn4sg=;
        b=cx8KrlCSHUcIxMN5jRuK9sHHqrr3aLtW7UggxS+3bejR6Wasodjm0cjavrzbun/gVE
         NSZwIa52DVBiH9COvG/ERYCuomGcOEqIGUuUmcnE6XAcHzzfZKMb+VKVtuqgxPxGweIs
         kD67nkpJdpgHtVJNK/zDBAcGeaIs1KoJuXs6mUwkYaDPUnGpti3JLhf+aEWNW0GtBTmQ
         wXcom8kAFFydxIN4ANeaEs0Tg6zURNmL4gg3UPbZhlmoVqcH3ws7+DxYJMKOa3qojbxk
         KihkYkhGwMY84jxCoEV0ce8wC7nPCz3vyP3jR9GQoh15Djptj4tMcCwRLnx1zpVPIQ6s
         OxSg==
X-Forwarded-Encrypted: i=1; AJvYcCUl9stnpj4dcJZ69DWkrXWP3MVfPaoS19rI/lqC3cYdDjxzyZCE9TiWEp4GYuE4JRCZdUs4qTAOxr9qWKRBLZ52jw==@vger.kernel.org, AJvYcCVwNXwtQbEu2ngNB0OdQE1459Y8oGdLxao3IKx/73iQumJuHqBqpnHvpamfWpCCDFsb3aggOX4SDaOv@vger.kernel.org, AJvYcCWHTfpM5B1Ij7F+fd8jOwYDJod+AA6gkQx4QtFt+GFN04HsCbePs/nmgVGzeybuzZ+HogN58Dviv9gE@vger.kernel.org, AJvYcCXTFRikrNZ4wgEeEmya00J2Dz7HurzJcHpyRouEsqY7H1+UU0l1Txjb1hfPdXKRSmx9QNUAMBe1i9Uj@vger.kernel.org, AJvYcCXj9xd6PaEkNXO9MBNhOpvg6Rrqqi+8zb+ONT46OwDtKl653Da48CCsYecIXoo061tBPeBUW8kGY/9+rpq+@vger.kernel.org
X-Gm-Message-State: AOJu0YyfunE9r9nrfoGbNhasfvwz9IaMq9FWCB7yNkXeLMEfza+P2m+v
	sGbRVyl1AxOJp5d41YQHhCg3nBzlwzNEndwAfkdCZdpIcrD0g8zc3WwY
X-Gm-Gg: ASbGncvmFhRPDf10dzEm+sONPK3cNF3W4jBi6bDeZ0jZ76RuQxoRRWSBNKHE+7QiL6U
	ufQHVhGEa1gsvcOCbXOIU9LLBjUaCKGldAYHLSTYxncu94gwMBI6brtMbRjLZVcEIq5nzmBLWHr
	66nqyupdtmek2A994t/8OiMrZ9k0r3PYXSCE9pn73c/gbBkLdbV5+qMLCV52hgRJ0CEABNNiPey
	nZZo+Ii1ns5vKbRgQM5P1L1xo6Llj9wInmC4bqVewglcRxcdv7YPle8C1cNJCNmL1DZ7odtYO74
	yoQZrLKF9uCfG1+lfqTjjYqJH4iVnfqq4D/s2tV7p0Qg0kH8btbpTT3KQX2x6DR7SBW7aJk8HnD
	1sxiOjgvS30kQQ8YvegvPXEJikhW78rsh3gPzivG60iLSOlAymhxf1jk3cyI626QtMpcRdTX4hz
	8kxvc0pB6RGnICcpYCkWyZLfPXJbAmvWbGAIVuDCYkoPOqZJC7K2zLl7sg7nfBF24WI4z6pwyPh
	8M=
X-Google-Smtp-Source: AGHT+IEnQ9do0ALLGKmunp/XJpi/t5BmL0hnvtsNOXrAxguTK/fiIMH8QwU2UzXZuUzOb9KHxDTCdQ==
X-Received: by 2002:a05:6000:2405:b0:3b9:7bf0:88e1 with SMTP id ffacd0b85a97d-3b9edfd55bfmr2615620f8f.56.1755180404714;
        Thu, 14 Aug 2025 07:06:44 -0700 (PDT)
Received: from ?IPV6:2a01:cb08:941b:4c00:f383:4db2:82a:81e9? (2a01cb08941b4c00f3834db2082a81e9.ipv6.abo.wanadoo.fr. [2a01:cb08:941b:4c00:f383:4db2:82a:81e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0bfc79fsm40404341f8f.56.2025.08.14.07.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:06:44 -0700 (PDT)
Message-ID: <4055d2c4-64c7-498f-8cdb-8d749d32ec68@gmail.com>
Date: Thu, 14 Aug 2025 16:06:42 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Subject: Re: [PATCH v5 05/20] dt-bindings: memory: factorise LPDDR props into
 SDRAM props
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
 <20250728-ddrperfm-upstream-v5-5-03f1be8ad396@foss.st.com>
 <CAODwPW-FjCtPGYkNYozo0ybEjz_rVOeDqkvEPiCmQ6M2in0OeQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAODwPW-FjCtPGYkNYozo0ybEjz_rVOeDqkvEPiCmQ6M2in0OeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Julius,

On 30/07/2025 20:27, Julius Werner wrote:
>> +      Compatible strings can be either explicit vendor names and part numbers
>> +      (e.g. elpida,ECB240ABACN), or generated strings of the form
>> +      lpddrX,YY,ZZZZ or ddrX-YYYY,AAAA...,ZZZZ where X, Y, A and Z are in lower
> 
> If the revision ID is only one byte for DDR, there should be only two Zs.

Indeed, will fix it here and in the dedicated field documentation below.
Wouldn't it be better to add a regex pattern for the compatible ?

> 
>> +      case hexadecimal with leading zeroes.
> 
> AAAA is not hexadecimal, it's a verbatim ASCII string (at least that's
> how I would define it, for readability).

Yes you're right. I'll add the numbers of chars it corresponds to in the 
dedicated field below also.

> 
>> +      For LPDDR and DDR SDRAM, X is the SDRAM version (2, 3, 4, etc.).
>> +      For LPDDR SDRAM:
>> +        - YY is the manufacturer ID (from MR5), 1 byte
>> +        - ZZZZ is the revision ID (from MR6 and MR7), 2 bytes
>> +      For DDR4 SDRAM with SPD, according to JEDEC SPD4.1.2.L-6 :
>> +        - YYYY is the manufacturer ID, 2 bytes, from bytes 320 and 321
>> +        - AAAA... is the part number, 20 bytes, from bytes 329 to 348
> 
> This should clarify that it is excluding trailing spaces (so only the
> significant part of those 20 bytes, since they're supposed to be
> padded with spaces at the end).

I'll add a comment about that.

> 
>> +        - Z is the revision ID, 1 byte, from byte 349
>> +      The former form is useful when the SDRAM vendor and part number are
>> +      known, such as when the SDRAM is soldered on the board.
> 
> This inversion of the statement is a bit odd? I think it's more
> important to explain why we need the latter form (or just explain
> both).

I will document both forms so.

> 
>> +      SDRAM revision ID:
>> +        - LPDDR SDRAM, decoded from Mode Register 6 and 7, always 2 bytes.
>> +        - DDR4 SDRAM, decoded from the SPD from byte 349 according to
>> +          JEDEC SPD4.1.2.L-6.
> 
> nit: Add "always one byte" for clarity and consistency with the LPDDR
> equivalent.

Ack

