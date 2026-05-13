Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153838AC7B
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709372; cv=none; b=u4tQibiURgQss4HxPg1EylZv/N/L36vCWrFgTGjZRPtkXY2xEg4h2gfy0TbrlFDJkZcu81fvsiNrrygFvbN7ys3vskeRFkPA4HvByPRRjqfko3HdvF6fLPFltIZeBQJ6UrpvAzVRsZGDLlnov7UtHsVphfBE0tij5NpTC+FsS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709372; c=relaxed/simple;
	bh=1XimAraz+eaeRD/qV6rFBGluyxAhYcaEF1sf4L3qXFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/AC3JStloUvggz9gDWl7HbyKnC/k+hQtJet4E6f1DPK3sfH1TU6hVS2kqZtTb1vw4sLw1NrcrsHbvK7g83elwGsmpdtA9raSmPv/kN/pEZGJJaTnewFpvzaBHKQkx6B4tsspzYQyj/Jwpe4A/Def5M0XkGr+Dx2/hrcVqspR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JRlIib5/; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JRlIib5/"
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-408778a8ec4so4063718fac.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 14:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778709370; x=1779314170;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rKpcuN8BMEhOGlG4OX0AkTmwlcIpeIXdS5Vx4rdG7g8=;
        b=X7kJxSN7AVuJiGxu7Yp3wxs28iLS3xEhgeRmSAYlPXpWsOlt8dZrZAvm75zpLoaUmP
         nMR/FQJqXEwjagmOuQF6b+C8WQRCCT6THuKDrDDsqAozzq0ZLtsXAa5XAmpCPDNAnlye
         1cq2jnlnO51pflxRraAXhU1naZT0Hbq1Z2NsqYC2kCCgzLM0dEovv931BVKzqxYLbXFn
         9Oy22SQEQ6h6CLJLBirBuIjA3FEAtdTypWPKcVefKv9chtXPqEJaRei7xBxqnX/Ry8Ig
         scBJMlmR0ipzup2RflhJhjvoxap44aQ8MTBYqEMn2KBAbfmbkS2l5JtB36tqbxu91+ht
         MG1w==
X-Forwarded-Encrypted: i=1; AFNElJ+hIlOdeHNptdyh11B+kS/iMrN1jysDT0+CIm8eVsjiuj/dyqlhyYt04pakXnpv8fL2z0FULeoZX69NQNBolvwV@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfRtkcDkh89GaiDS6kjOC7U1KfXpsn/qzitNuC/ZTl0BU0pHe
	digaX0B01oeSI0Ix+8x8xkk+pKdTSlfkz21Y5TJwxf9TuiZ6gNvs77PJTKYFKwDVphHRtTT3AxE
	XY9aPWhE0c8UyMkRd9jiEOIZMdLRQ023HOFuUNuDVlnvCc9eZgqnKHpnrP1GyB8scWEuxbHVkf6
	+N+62FqIjiTZtkFPXsIowMfoktE2Ar7wyoiZaxwX2DYVB/FrFvCwytI5EbtB/TwKtTUUG5E+W0a
	9B5p5jJx2BxV87bleLQNIXcX4rNOA==
X-Gm-Gg: Acq92OHK78MSxXrvDvymO71M/A7+UCdarG+OS/w3b8JFRElnP3B9aG2aPnvNwfBmyGQ
	sOsc3fFaTPiGPn3Cz9V7z/qJCpepvstcWxnbBGRDvhQ3w1mRY4t3pBpg4T47D59eIcDY28qktSg
	P/LMzAT4fjglzgnkg8Jl4A8SPX7UL6ZWn06caCk77cQCrCTzu7k6/BKO91cp+A7MQxRRN4HvvMD
	67nhb0czjacStqI5vuixsx/Hd0Cdn8G0cWKLKP6jf2jMR02z2JYU1AhaOMnip78MJgSOalWePeF
	tKA5B3UUJIzPpnNG8t5WCie+qQJ/ILdnx+Lnby2Ys2uWLEHTanEsMrV3MsxrM67vSfNfTV1KlYb
	mjedeAvd666nyMFzKvqac4Pu6UFB4lAKwD5Oi6efHHF5NYq0r8AUJjTOiDWhS75X/KjWDkA1gVm
	3IBDpnD9PUWyzuLC/ELcp4A4LWMKewvnjGYJ4gpZtIwkXil3evGn+mcoCrWDn2fvyoMOp+S4l44
	gg=
X-Received: by 2002:a05:6870:8a14:b0:41c:616:5317 with SMTP id 586e51a60fabf-439d31348a1mr2094513fac.39.1778709369836;
        Wed, 13 May 2026 14:56:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-439fc2a509esm56590fac.8.2026.05.13.14.56.09
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2026 14:56:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-132a8f93432so1455796c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778709368; x=1779314168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rKpcuN8BMEhOGlG4OX0AkTmwlcIpeIXdS5Vx4rdG7g8=;
        b=JRlIib5/XOwv3NhIrq3zZZmcxKXMDxmUE5h7yh7TzOH1fKxwAKNVipwylQQqJUzbzE
         SIwCu7E+E4uGBlNrzL2jXZkC1TmUqj5RCzzqn6NZFQ4mFHBvER+t5UzlMibchof6rWXR
         WCk3O0Lxi9YhF9dkAbWg9kyojA3G8iIQtumXc=
X-Forwarded-Encrypted: i=1; AFNElJ+nBQOwD9Zb0XrAjC8PUId9MSsb22G0RKPOpnS/mWJ2pKcdifOcwQC0isA5yCZfiTHYCBGVClcfMm3xQOhic1Jh@vger.kernel.org
X-Received: by 2002:a05:7022:68a6:b0:12d:b3f8:60e7 with SMTP id a92af1059eb24-1349ac71ce5mr3244194c88.34.1778709368436;
        Wed, 13 May 2026 14:56:08 -0700 (PDT)
X-Received: by 2002:a05:7022:68a6:b0:12d:b3f8:60e7 with SMTP id a92af1059eb24-1349ac71ce5mr3244168c88.34.1778709367869;
        Wed, 13 May 2026 14:56:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed2232sm1184822c88.7.2026.05.13.14.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 14:56:07 -0700 (PDT)
Message-ID: <f06b4732-33f4-4457-9e6b-58ede7590122@broadcom.com>
Date: Wed, 13 May 2026 14:56:05 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace beauty fcntl: Fix build with older kernel
 headers
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, mmayer@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
References: <20260513192347.4007895-1-florian.fainelli@broadcom.com>
 <CAP-5=fXfD5bkhoufpa3aYU5mO4YiJ3agjG+vyB6KUU=o4vGADw@mail.gmail.com>
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
In-Reply-To: <CAP-5=fXfD5bkhoufpa3aYU5mO4YiJ3agjG+vyB6KUU=o4vGADw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/13/26 13:58, Ian Rogers wrote:
> On Wed, May 13, 2026 at 12:23 PM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> Toolchains with older kernel headers that do not include upstream commit
>> c75b1d9421f80f4143e389d2d50ddfc8a28c8c35 ("fs: add fcntl() interface for
>> setting/getting write life time hints") will now fail to build perf due
>> to missing definitions for
>> F_GET_RW_HINT/F_SET_RW_HINT/F_GET_FILE_RW_HINT/F_SET_FILE_RW_HINT.
>>
>> Provide a fallback definition for these when they are not already
>> defined.
> 
> This seems fine but the commit you mention was added to Linux 4.13. Is
> there a reason you've run into this problem? The oldest active LTS
> kernel is 4.19.

The toolchain I am using is still on kernel headers 4.9.x, I am 
cognizant this is a very old set of kernel headers, this is specific and 
unique to building for MIPS, our ARM/ARM64 targets are using more modern 
components.
-- 
Florian
