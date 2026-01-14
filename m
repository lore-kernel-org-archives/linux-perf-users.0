Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73435773B;
	Wed, 14 Jan 2026 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424277; cv=none; b=sHrtMkNun0bAc4jGXiOEMOuMrPINJZtZ5CIEroki1PvHUMtJAhfAJ0k+hZPFYKSMTXAzfvh8dYsrxpg4JXwQPnbNVsWxa0D9VQ94X2LyFFLX/7kw30fXygWIli6s1VwCnbDY0n0gRWx5sMtLzCPT/aZaLnjuw7ZQ3jqcfrlt+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424277; c=relaxed/simple;
	bh=4WDyYMUESPXKGiMtPA9Z4XdqZwYa7wyT4k+geOmXcr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csuPgxKks5pbV6qOg32EB5D2FYu4bbJkgjAaDcKnzZU/vl06jHgORu/CtGGcXG/nk5AKxC0uRHD8YZr/M+BvQQ4x5u3ZslqPHU7WJsoHh9gH+AXCKWLiaBIJHTmm9yOBuVgwhz8jowLKQ7I5bQxvC+kNtFkaET0M5Q4DnauF3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hlJQx/5d; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hlJQx/5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768424267; x=1769029067; i=markus.elfring@web.de;
	bh=SScaMT5WEvl+VpG51AQ3g7NbyDTEREQ4mxNjljVAQpg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hlJQx/5d9LbUft2FSCD1qyp63ndkUFyNsF9rqLVfIuTY3/jfJ+JqlJItWWyaksEl
	 1eQ/bK+YJSyM8AKE1NKHdjdeLVK/SFXeVHVaMYZagngf98mBjU65onVec7PnAgaCb
	 N89RApyBqwZQ/UAwjnXDyt6SC1txHsAM2ocQ8mE9o+xl41qlhBUMtpGs87XPom8gw
	 FbmLkZr1xETcyfORbQ/PH76pwdUrDRExAaPKmVtx9pZCcdYEMFaJ4hD5deMloCxG+
	 hJzuz/P1WKx2oF1Bhx4mSPzdx6wGKrQCsh9ggm5hxK8OYPhYc3ZkSgmP/wZWfqVIk
	 JQ7mOgeFPesj/LwETQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8C07-1vlMjZ3ZZb-003c56; Wed, 14
 Jan 2026 21:57:46 +0100
Message-ID: <cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de>
Date: Wed, 14 Jan 2026 21:57:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf/x86/intel/uncore: Fix iounmap() leak on
 global_init failure
To: Zide Chen <zide.chen@intel.com>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Stephane Eranian <eranian@google.com>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260114193825.17973-1-zide.chen@intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260114193825.17973-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s/GOk8u11vQDqdqfkLs6rptj6haywgTUiwSgXl59Sw+jeTA/tOZ
 FH2QOKiKzwt23BMI8kKhdWNauujtrw2DaYlgZYAtvsS3B8a7GCJT6++QXlGHKaFKBOMeX59
 PLosOqkE0W9eno2WAl/s4tl72612/bLyR6Ailyh1+veqvEepiVRCbFqWgKGTQzzOhY8/Q1d
 QAMHGtgluz4t/qAWU0hJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RQTuO2U20Y8=;C7Ycy1boseTIcC2MI9pXSc+PCwZ
 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
 NfOKK/x0IKlVEKUqVaCT

> Kernel test robot reported:

Is this duplicate information according to a known tag?


> Unverified Error/Warning (likely false positive, kindly check if
> interested):
>     arch/x86/events/intel/uncore_discovery.c:293:2-8:
>     ERROR: missing iounmap; ioremap on line 288 and execution via
>     conditional on line 292

See also:
https://elixir.bootlin.com/linux/v6.19-rc5/source/scripts/coccinelle/free/=
iounmap.cocci#L2-L8


> If domain->global_init() fails in __parse_discovery_table(), the
> ioremap'ed MMIO region is not released before returning, resulting
> in an MMIO mapping leak.
>=20
> Reported-by: kernel test robot <lkp@intel.com>

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n94

Will another imperative wording approach become helpful for an improved ch=
ange description?


=E2=80=A6
> ---
>  arch/x86/events/intel/uncore_discovery.c | 15 ++++++++++-----
=E2=80=A6

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n310


Is there a need to perform desirable changes by a small patch series?

* Specific fix

* Related refinements


> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct uncore_dis=
covery_domain *domain,
>  	struct uncore_unit_discovery unit;
>  	void __iomem *io_addr;
>  	unsigned long size;
> +	int ret =3D 0;
>  	int i;

Would scope adjustments become helpful for any of these local variables?


> @@ -273,21 +274,23 @@ static int __parse_discovery_table(struct uncore_d=
iscovery_domain *domain,
> =20
>  	/* Read Global Discovery State */
>  	memcpy_fromio(&global, io_addr, sizeof(struct uncore_global_discovery)=
);
> +	iounmap(io_addr);
> +
>  	if (uncore_discovery_invalid_unit(global)) {
=E2=80=A6
>  	}
> -	iounmap(io_addr);

Can this modification part be interpreted as an optimisation?


=E2=80=A6
> -	if (domain->global_init && domain->global_init(global.ctl))
> -		return -ENODEV;
> +	if (domain->global_init && domain->global_init(global.ctl)) {
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
=E2=80=A6
>  	*parsed =3D true;
> +
> +out:

Would an other label be a bit clearer here?

unmap_io:

>  	iounmap(io_addr);
> -	return 0;
> +	return ret;
>  }
=E2=80=A6


Regards,
Markus
