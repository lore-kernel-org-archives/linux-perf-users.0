Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F26B49551A
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638875; cv=none; b=j/Q3LdGyAQwbSeFN7WQrZtV1qiVmDK3Fp/WgvkNQxc47+rJu18iN2dNUoD/fO1d9jE5B7ZFnPZGQlItW0kxSoKaXK2R6VbEWaHAvOqKTv2z7IUIzl/NmY8OWDhUV5CxPl74jTuLU+be6C+46nFWB6XJd/lcz63DKUIPKGnVSPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638875; c=relaxed/simple;
	bh=VHjE+CvqvCycM8vZo5suwfivOiQA3PhZb6EWX5kH6O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5Fp3tvEPoTZsbRTLqMk5dZKiNbP2vQKhnin6LkPhjzCIvbNgYm7+r8ZzC4N3H18zswETK8veopBc7bDVc+7QsGpNGv81W1LKXkWpfjDY6YsW4hxNaFZXC2Vw70pX+ZED/ixdtX3zLyMXGzOKBW81/BfMAu+vIG2PpraCsM1b6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VeNPbwy+; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VeNPbwy+"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-821106b5b64so21818857b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 09:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786638873; x=1787243673;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=er5DRGv9RBWWCyOmoSI2svQn2A2+M6brn7eWG6JBVlI=;
        b=S8zyjU88Msl4L4cQrXB037g5wL3ZeRlCUcnQajAC7nJLptWCG1KyfMlb4ep6/c14gd
         QFuPaOUn7jZ78yQ1LUfAYngEq9kQlm4CnhkDVZ8Vk/3o1lin6qJtGZdUw7pq5/NML7B6
         8PTA+k0eSqGg9WDNdaaayTDxRfvGhfh4EsgvL6BckEUIs2mGOm1Yy33+mu85pm8Ys0MJ
         aKYNbEtU7Qrf5u9zpl6bfJ07mFuvydOSk5UnsbwkbKz0RM+I5S5H3nVAG2OfbqU2jagb
         x8QCqzdfjKzeyI5oZBYfKLO3FaYjJ09jxtqV2PFcvK814n32U55a1FQ/uBYYz+rNFLeD
         2pcg==
X-Gm-Message-State: AOJu0Yw+N8jjq6XFfMCz9rGxd8LRIRuDIeiPdYkiC8W3B9YFhZeGa1zZ
	4eF8VeC2Ryr+XlrhsbjCLifv8JtaVTiuFS/uBXD+qJd8Di5sWJEecNivRY04gX3/2kuaJQU+kq/
	TQGUS6mefVfwFEnEupeJPDaKzmV8a9oPieIRsg+r9ywYgL26MDwTq+1EJ1wzjKLSeqxTqdL6IWP
	VKVWEnCeONgklw2GPoKfWvup/3l/mX7TC/WtSFKlleEG6/c0zSsDQRiK1vcGsdLL8fvazkT5sAm
	ecQWbeVdispT995YPNcIraQJO4rGQ==
X-Gm-Gg: AR+sD10RfK91lR9hwYEcLOX6X4s+NOqXrRiL9+JhaAWYT1aXMkvjFI/EQtYvAxYymTX
	cMVeVnJd9JMIqwGqStFGMEaROe7yv2O2A3FIBP1U1BlBkje3Lh1Z+7EOY4AYEobrpSFKc5Ulm4f
	25XzEf2zaclcDMVhzjzSJchhEZ60P97OdQJA5BMkL3PeYddCm1op9Nf35cx7WXlR7Xu4WAhoPXP
	cURaqbbWjTSg9r75g+UiLnet7f1TsF3B9Sd+rAhIe5+IfDJJMB/i0ZpSnRej+9Z3Q+Jxp5WXvf5
	43qJ7gQGwQyAWXpOx+aBRpheYuPSQ2OXzeetDWoyoB1vJsqZW7RjQ9glFOy4aEUV8uL9iLUPbML
	mJASqCqcan/xGPsLGtcO35LsLG2UJ83Acq3uTDOQeGED7yShQL3Lk3w4E9EnTZfF76f+iSmIk4i
	4vskVbjW3lorfMVfOSKmZ66pjQ/tDi4CiU/m9CKmdY
X-Received: by 2002:a05:690c:30c:b0:80c:16ad:2f16 with SMTP id 00721157ae682-834932f695amr34089177b3.8.1786638872962;
        Thu, 13 Aug 2026 09:34:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-836baf07381sm121277b3.5.2026.08.13.09.34.32
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 09:34:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930b571432fso115492285a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786638872; x=1787243672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=er5DRGv9RBWWCyOmoSI2svQn2A2+M6brn7eWG6JBVlI=;
        b=VeNPbwy+cWnJGcBMaCWEmUDteaG3J/3m7VcIquF645Bvi7jRR3KFfQJAQfaR9FX6n4
         9P3CCf0VDo53Wj6x4znkxqHNLxGr7+nvVI9EataDtpbiZLNctJSRVhO1+K6xj/GZlgKJ
         AIVnnmMoEnanag+NJZ2wfaULMLh82YTQ2sSKw=
X-Received: by 2002:a05:620a:3726:b0:936:a184:3cf3 with SMTP id af79cd13be357-936c064fb1fmr644759685a.10.1786638872145;
        Thu, 13 Aug 2026 09:34:32 -0700 (PDT)
X-Received: by 2002:a05:620a:3726:b0:936:a184:3cf3 with SMTP id af79cd13be357-936c064fb1fmr644752585a.10.1786638871669;
        Thu, 13 Aug 2026 09:34:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936cdf54ce8sm21460285a.4.2026.08.13.09.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 09:34:31 -0700 (PDT)
Message-ID: <4fc52c7d-85eb-40ec-9e90-2a20f194c64f@broadcom.com>
Date: Thu, 13 Aug 2026 09:34:29 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
To: Ian Rogers <irogers@google.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, Peter Robinson <pbrobinson@gmail.com>,
 u.kleine-koenig@baylibre.com
References: <20260812002728.2283079-1-irogers@google.com>
 <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck>
 <CALeDE9P1xZonVnZDExR_hMafd4mxahkjBVTDLJenQ6DKW5MSHA@mail.gmail.com>
 <CAP-5=fXd2HETe-484Pe5wMTGPiXbLheMaW6ZDpdD+YCtKoBHVg@mail.gmail.com>
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
In-Reply-To: <CAP-5=fXd2HETe-484Pe5wMTGPiXbLheMaW6ZDpdD+YCtKoBHVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/13/26 06:48, Ian Rogers wrote:
> On Thu, Aug 13, 2026 at 2:08 AM Peter Robinson <pbrobinson@gmail.com> wrote:
>>
>> On Wed, 12 Aug 2026 at 09:28, Will Deacon <will@kernel.org> wrote:
>>>
>>> On Tue, Aug 11, 2026 at 10:24:15PM -0700, Ian Rogers wrote:
>>>> This patch series adds an uncore Performance Monitoring Unit (PMU) driver
>>>> for Broadcom AXI system and VideoCore VPU performance monitors found on
>>>> Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5).
>>>
>>> Why are you sending four versions of this patch series, at -rc7, each in
>>> reply to the previous one? Nobody is going to review that.
>>
>> I'm also wondering why this is called rpi_axi_pmu where it very much
>> looks like Broadcom IP, and is possibly used in other Broadcom SoCs,
>> Florian can you confirm what this driver should be called?
> 
> I'm somewhat agnostic regarding the naming, and having a more general
> driver strikes me as a good thing. Fwiw, I based the name on a
> somewhat similarly named non-perf-compliant driver:
> https://github.com/raspberrypi/linux/blob/rpi-6.18.y/drivers/perf/raspberrypi_axi_monitor.c

Given this uses the Raspberry Pi firmware interface, having 
rpi/rasbperrypi in the name is sensible IMHO, but the IP is technically 
from Broadcom AFAICT, so using a bcm2835 prefix wouldn't be far off.

Ian, I am really having a hard time following all of your frequent 
submissions, would you mind waiting for feedback before spinning new 
versions?

Thanks!
-- 
Florian
