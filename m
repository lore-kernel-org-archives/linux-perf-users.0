Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856635FF46;
	Wed, 14 Jan 2026 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375554; cv=none; b=S864okEs0Wd1WiPN7FGR33F8fQpAaUeYLeiFY2K2rh54DNfws+TbhAf8B4XTQJHC5nlotRFZPK/w54xd7+ICP7p4Sy1qcA74jgbSBnPKVTztjyPUTsJbL8cm03PMFtxaC2aqq0DzkE/d/0L9A/CwVteAcUlLdqENtLSHYXfk+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375554; c=relaxed/simple;
	bh=yhqAPxE0eom/KaeoDZ7LzcWfOLHF5Q9Zh3wSK+3Kxn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ou2wFDp8T06AC9bXdD7+3oWV8lbP0Z2jO2I4vXKszawG6Rhz4/QDJW7kUkmZM041nfLlckas88juy7YkYDD+vP9HcxC69dY7N+UDGtF6tDVpdpr3O+Q1PnkerB/ovpqUuwRjKf+12fha0CztjNLnmR0YWoVfDRDqTMLoqV6uByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SDrV+PoA; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SDrV+PoA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768375535; x=1768980335; i=markus.elfring@web.de;
	bh=PXuSVpZcV2U323AB6efp154HqJfrB+4cs4kzBZV3vh8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SDrV+PoAWgcG0Ms13f0imriV15oeiP7RgB7ap2DKB1OU+3s3U37z/QZy/smXrZ5H
	 /04RrL1cepV9fxiSSoGTaU1N6AHcZwlQB0WXWBCOhtwSjJqvL6deqjl26QkX8s6kN
	 j43ae8xlSEf/L1zSytmaw1WYYSrO7pH66/9Lc2kNYWWqCy4zA5NKDJLjjsO9aUFex
	 Gydgf80Mn0bRraQcc0Alxa7S8ybYncl2356CA6fOiHWvHgX38gAHI2JxBDhbUEIoi
	 4GgzjR/eWAugd8jeE/FxCxlA+NION558qPXjaDcz534s/R+eQES8WS8x2IipQXEvF
	 hDiP1wfV9UPvp0eP+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HG8-1vmY232Mqu-001hLi; Wed, 14
 Jan 2026 08:25:35 +0100
Message-ID: <548c93bc-bba4-4257-a8da-5cc384a2ec7b@web.de>
Date: Wed, 14 Jan 2026 08:25:32 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init
 failure
To: "Chen, Zide" <zide.chen@intel.com>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Eranian Stephane
 <eranian@google.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 Thomas Falcon <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260113002539.408943-1-zide.chen@intel.com>
 <6213d28c-7377-44c2-92c6-0dc34cfdf60a@web.de>
 <fc565620-a3ef-4a28-bfb8-87bb5ce135f5@intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fc565620-a3ef-4a28-bfb8-87bb5ce135f5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N5eVCQrEabOidvqP5eZObaLjmz5GhbcC+otZbJDZG1A96ClB1d9
 lx7Rt72MnKj0hBJOY58OIu7CiRlpACGSWARE7xATmR86RBHvElk4gp64dktJf6w4ZRJJwvo
 zBZsq4aLJd+CZ4fxSc+JZXm3Ppbm2lDpZuTJpvqhwc0K43sO2Zqbp4FP6FMDvvUtK48UlLA
 4Ogv0WqusmvIV2Dyg/THA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Wy7XMT9eLU=;LN62a3OfPx5uRU3wg0voWJ/xHRv
 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
 nSVme1nIigWAgS8HJZQzyxU3YQhSx



Am 13.01.26 um 23:04 schrieb Chen, Zide:
>=20
>=20
> On 1/13/2026 8:21 AM, Markus Elfring wrote:
>>> If domain->global_init() fails in __parse_discovery_table(), the
>>> mapped MMIO region is not released before returning, resulting in
>>> an iounmap() leak.
>>
>> How do you think about to avoid a bit of duplicate source code here?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/coding-style.rst?h=3Dv6.19-rc5#n526
>>
>=20
> Thank you for the suggestion!
>=20
> Yes, I agree this is better. In V1 I followed the existing style in this
> API.
>=20
> I will post a v2 with this change:
>=20
> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct
> uncore_discovery_domain *domain,
>         struct uncore_unit_discovery unit;
>         void __iomem *io_addr;
>         unsigned long size;
> +       int ret =3D 0;
>         int i;
>=20
>         size =3D UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
> @@ -273,21 +274,23 @@ static int __parse_discovery_table(struct
> uncore_discovery_domain *domain,
>=20
>         /* Read Global Discovery State */
>         memcpy_fromio(&global, io_addr, sizeof(struct
> uncore_global_discovery));
> +       iounmap(io_addr);
> +
>         if (uncore_discovery_invalid_unit(global)) {
>                 pr_info("Invalid Global Discovery State: 0x%llx 0x%llx
> 0x%llx\n",
>                         global.table1, global.ctl, global.table3);
> -               iounmap(io_addr);
>                 return -EINVAL;
>         }
> -       iounmap(io_addr);
>=20
>         size =3D (1 + global.max_units) * global.stride * 8;
>         io_addr =3D ioremap(addr, size);
>         if (!io_addr)
>                 return -ENOMEM;
>=20
> -       if (domain->global_init && domain->global_init(global.ctl))
> -               return -ENODEV;
> +       if (domain->global_init && domain->global_init(global.ctl)) {
> +               ret =3D -ENODEV;
> +               goto out;
> +       }
>=20
>         /* Parsing Unit Discovery State */
>         for (i =3D 0; i < global.max_units; i++) {
> @@ -307,8 +310,10 @@ static int __parse_discovery_table(struct
> uncore_discovery_domain *domain,
>         }
>=20
>         *parsed =3D true;
> +
> +out:
>         iounmap(io_addr);
> -       return 0;
> +       return ret;
>  }
>=20
>  static int parse_discovery_table(struct uncore_discovery_domain
>=20
>> See also once more:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n94
>=20
> Are you suggesting that I add a Closes tag?
> This issue was reported by Intel internal LKP, and there is no public
> URL available.
>=20
>=20
>> Regards,
>> Markus
>=20

