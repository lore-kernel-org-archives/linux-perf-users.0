Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4320B2AD0C
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579572; cv=none; b=im9w4M+kt5J7F4tN5AKflpI501e9ZYiZDOZwsUN7dT5djOd0S+M155jJfGqRn2wWQK9PTeKdZ7tiUw4q4TZMnp/rtJgaW/hE8e6jJjyyyx88ysz4a91FhnZQVM19l2MNPipEVwlpkn8bTE/TSjDd6W/fKGveLjujBB9e0HwVzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579572; c=relaxed/simple;
	bh=vZUjQJX8Nbtgyf6eJuPbiChSi3lL6doQnfdjXcYe9XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVJ2iyoLlHkWQmri6SYyXhsj7m2tJHHtxkC+vlSkw9szv+rU3RZLFH8n+1DWSE1rT5qQAnsM/AKWm2/TulEZBY7U1LQmUD962Uyq6usVDyNhFzUVXExVF0fk3X6iUomh5R4e/KB5FGi0/XjxdOeB1L0hTKV22dELjBYveTCFEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U02cVyEM; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U02cVyEM"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3811f512167so1991294a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 17:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786579570; x=1787184370;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wx5qD1bTE3okJgcwPgCBz83Zocyi88FPJfPF28sTzWk=;
        b=pFWt5QWzqpOIhYhw2crBzYQJtQ9+gG5jf/GGLbLHi2VA7UmdX/esrLpd9Rsi5KeL/u
         ufZ0zz0TN1TntfgEW2ag9ljHwERP1X8PIAe1eIIORSpnjYrfg8MoL/hGuqabxtTG7I0b
         GvNFfpd4ADgepskYnMtAretqdOW6OyoTVwm30SG6lWCF3mY9DqSJi9Glt3M+K7PtkOsw
         Nm+kbixA0BgBfv3yYyi4w6KsGG5f5DnyEBs3Vjfw1Td7MC4ju+SecBWU1YzrpeOsATmQ
         FJ11OfTgJLn0o1Oij4YrWw1b02M6Wq0RzbhLafu+BM+NPVmH7crY7ta5TUqitOPEdrdv
         DyBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrYAJZ+9iV8eOA4AEXrAHZUk2ShsKhLMxW3VwcLlcTzg6Jzam68moICPoE20mSgeYZnmrDkqPX5EyoAem2x1tM@vger.kernel.org
X-Gm-Message-State: AOJu0YzIk0qTF3h2dVHLbl4MH0i0hfMOwYlgf2qcI60TJ0ugmqMeysHf
	6k1a1rkJyEIHucyj4NspFGKNMHJLkL4IIcri5huXgMNXYKCxgL/yx0R6yBiY2gE3n352CKhEijN
	+oPRajpbP07siqFhM7gmqHmDoWQhA7de1UAXN3kagWnPjIEy6EuOAuImeNBN8/oK0y69+C6Xt6+
	ea2ZbGOOgrlNF++9iAuNCRXIvBOrbpxvSnpYnj7/yyNyPT+JHYZwL5Q5YiPjcRzg8h8v26QxjBs
	I8Y+UXVu+YEYGgUTNDFZcYaaoMwrA==
X-Gm-Gg: AR+sD12l+zWqUQ269+EjaIzCzDJMODYH+900KhLneHpjZEoXJQ5Ni3bSSkJv0jZh/u/
	dHKJi0B2rSdUram8sAqk6VFgfwzVpPciqvAQW8pMFi94QX1oza+xsKAgsHo+b08YANDgJLkRKKZ
	5W/Xi08TNW3kfrKsmxr5JdIzHOZAkFJCGvNVIOK/t4aomds64CjXNqbar96DBUYsPMOI//5VyEJ
	FuVtFHpqcQIu6+tRrsLgPN12VVHK2GAIv5bwo1LHInKP5q2rfj5PMOVxxwUw/5poLvSJBHn6wvb
	Gq/93YhAaOu8sfZM+Fvy/kN5J7qUT8qprzmMImD+CRsug/cHg704wyYKiCWPsjDR98sLKNr43kA
	v2MZYMQOZC2+f+vUGG6yS+dOFlwPLzT8qBpOTHNSIP9yjBmmCKC0WIVlcKySvCdHVuDJxDRJ1Zf
	2d0PknE4Zu8vBtim584tO+U8d7eHfBLVT+5AV0Ilgn
X-Received: by 2002:a17:90b:48c1:b0:393:1cd6:643a with SMTP id 98e67ed59e1d1-3931e2cf85dmr2225184a91.18.1786579570356;
        Wed, 12 Aug 2026 17:06:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3931cd54531sm420293a91.6.2026.08.12.17.06.09
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2026 17:06:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-907ca5abf1bso10461536d6.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 17:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786579569; x=1787184369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wx5qD1bTE3okJgcwPgCBz83Zocyi88FPJfPF28sTzWk=;
        b=U02cVyEMJv+uTjvEcfct7XPKPvUMmWWRt7d4cMQbC/nlhi6wizL3hwfwLzJYbjXbym
         CSh2gZ7lSWHnV3gQ3QZQAMTVS9In0rU6sgUq3fVHFKiaQqsY1yiV2BnThdn7ajtzGHte
         K9MFsOPCrPg+u64PLh/eFGdMI+rbK9OavN5k0=
X-Forwarded-Encrypted: i=1; AHgh+RrZZ1DOxtq8PahBgiWtmQrBNeinxUBdByfWA6l1FG2L4hLG600vnkB3Xpn3Ed5dduhT1O3JBPsv6UzfGB1eG60I@vger.kernel.org
X-Received: by 2002:a05:6214:53ca:b0:8f0:5b55:1f64 with SMTP id 6a1803df08f44-90a80b8a548mr18381356d6.20.1786579568995;
        Wed, 12 Aug 2026 17:06:08 -0700 (PDT)
X-Received: by 2002:a05:6214:53ca:b0:8f0:5b55:1f64 with SMTP id 6a1803df08f44-90a80b8a548mr18380416d6.20.1786579568260;
        Wed, 12 Aug 2026 17:06:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a817bbb3fsm2968896d6.15.2026.08.12.17.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 17:06:06 -0700 (PDT)
Message-ID: <e67a21d5-4841-469a-a75e-0987be9b915c@broadcom.com>
Date: Wed, 12 Aug 2026 17:06:05 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
To: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, u.kleine-koenig@baylibre.com, will@kernel.org
References: <20260812230145.2644281-1-irogers@google.com>
 <20260812230800.2646749-1-irogers@google.com>
 <20260812230800.2646749-2-irogers@google.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260812230800.2646749-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/12/26 16:07, Ian Rogers wrote:
> This commit adds an uncore performance monitoring unit (PMU) driver
> for Broadcom BCM2835-BCM2711 AXI system monitors and VideoCore VPU firmware
> mailbox monitors found on Raspberry Pi 1 through 4.

Missing generative AI tags here?

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   drivers/perf/Kconfig       |   10 +
>   drivers/perf/Makefile      |    1 +
>   drivers/perf/rpi_axi_pmu.c | 1793 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 1804 insertions(+)
>   create mode 100644 drivers/perf/rpi_axi_pmu.c

This is more applicable to the second part of the patch, but the 
dependency on the Raspberry Pi firmware interface bothers me a bit. We 
have the AXI PMU blocks available on the 7712/77122 chips which are 
sister chips to the 2712, we don't run the Raspberry Pi firmware on 
those systems however.

Once your patches land, I will see if I can get generative AI to help me 
add support for the two AXI PMUs that exist on those chips.

Thanks for doing this!
-- 
Florian

