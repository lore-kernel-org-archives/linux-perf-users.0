Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766035B15A;
	Wed, 14 Jan 2026 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377075; cv=none; b=sVtpwT+gnH6f8FMKoZIAWXXVRO3nWryWLUctMTK0oWYs8Y4RZVpy2stqNmkWZNcFDWpTrviUMB4q8+J59NDr3lQOPp5RogIg6RAMe3yKI7/U9g6wG7v5pvV7QbWJ+1KByQ5pK1FT7xxtcqSLxPltPpVkJAHlXlMzkKeU9AzMCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377075; c=relaxed/simple;
	bh=Qp3UBzYxl9TiEFid1viDPOYrf6uJ7Kr/lpYpaI/sjHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNRXaOK/ABxPVnRxGgW+mhB3+4G7MX5G5vQoaooOjcp7oo+5Xk7svcpUIYho6RfLui2MSR8cj2hk7sqHryLtW0Et4By30cZgiFL1C0iCXJgqtjrOmKorXE0wdmKKiYzRvfKJKBwcC78cQWPjSLGwawc4UclkdgN/fyy+Zzozt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OeqfrOLm; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OeqfrOLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768377066; x=1768981866; i=markus.elfring@web.de;
	bh=5omaCYQKYXaIlhG+UM75AnEjLCq/nqfpP7lwdD5AFLE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OeqfrOLmuI49StamfFv4VAWUIy9Dpw6uP2uPFj+8wWW0R16humQPXKbKVc88+ZZ4
	 ZJm8cOHbFILkH3WiTngqWNBfUz5UyhUEDCEdbYx7rYKWFhM9CcIlrEfkrC+c+6m+5
	 9j4agdr4R2atEz3IoWLH9rCfmaiYq1vuC6bnn0DX2CsWbPqLom+5JtyHAzutE6Zlw
	 jXuEyNC7sqlvDdMUh8IQQZMC6brP1GlfQQrVp+9PBTzJTGXgwIaz5iQ28UxjI7lw1
	 R2C0g0JNOgvsUmtB3hrx51fWYhmysude1iroGbKT71jxiBs/Zg4omM8AQRZgPRfK8
	 n40rfVCp0mR0jPxnCA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kEP-1vk4Wh02bJ-004AEV; Wed, 14
 Jan 2026 08:51:06 +0100
Message-ID: <77078fe5-23fa-4278-b32f-f655f0760be1@web.de>
Date: Wed, 14 Jan 2026 08:51:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init
 failure
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
References: <20260113002539.408943-1-zide.chen@intel.com>
 <6213d28c-7377-44c2-92c6-0dc34cfdf60a@web.de>
 <fc565620-a3ef-4a28-bfb8-87bb5ce135f5@intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fc565620-a3ef-4a28-bfb8-87bb5ce135f5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wEXZrAKaAwzV74a7a4o2RtoGvtJw+6HGLiJFPrQlcoScsIcTqi0
 b6XqbF7Wm8hub7HZX5pc7eBgusElLbCwWNSWdkKE+uF4wawMpYTiHWtljPqqcnzfbLLna99
 nLS7YlZCWmMUCxWDn8zJI2TxDpz70fm/Ijha3SgTlAvbhxFJrcZVg6+Hl6kZ0Hi5mySQ6sz
 IIiFo4cyLM4NbIaH5+wqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QX5loB7MZEQ=;tUtYudJNNT3sV1HfGubXRIIyQwh
 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

>>> If domain->global_init() fails in __parse_discovery_table(), the
>>> mapped MMIO region is not released before returning, resulting in
>>> an iounmap() leak.
>>
>> How do you think about to avoid a bit of duplicate source code here?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/coding-style.rst?h=3Dv6.19-rc5#n526
>=20
> Thank you for the suggestion!
>=20
> Yes, I agree this is better.

Thanks for this positive feedback.


> In V1 I followed the existing style in this API.

This variant might be nicer for backporting.


> I will post a v2 with this change:
>=20
> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct
> uncore_discovery_domain *domain,
>         struct uncore_unit_discovery unit;
>         void __iomem *io_addr;
>         unsigned long size;
> +       int ret =3D 0;
>         int i;

Would scope adjustments become helpful for any of these local vartiables?



>         size =3D UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
> @@ -273,21 +274,23 @@ static int __parse_discovery_table(struct
=E2=80=A6
> -       if (domain->global_init && domain->global_init(global.ctl))
> -               return -ENODEV;
> +       if (domain->global_init && domain->global_init(global.ctl)) {
> +               ret =3D -ENODEV;
> +               goto out;
> +       }
=E2=80=A6
>         *parsed =3D true;
> +
> +out:

Would an other label be a bit clearer here?

unmap_io:


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

Will another imperative wording become helpful for an improved change desc=
ription?


> Are you suggesting that I add a Closes tag?

It depends =E2=80=A6


> This issue was reported by Intel internal LKP, and there is no public
> URL available.

Thanks for such a bit of background information.
Some contributors would appreciate further hints on involved development t=
ools
(and known source code analysis approaches).

Regards,
Markus
