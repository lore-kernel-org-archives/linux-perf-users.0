Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D004E33FE11;
	Thu, 15 Jan 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467750; cv=none; b=LfKRVZUCpqSZtK668u74oCrqGktr+tT50NndT48ARL66I/DNnwzZ3eN4601XjhYAkUAB4PWJtPwcfCPiAcuoXlk6Yo1iWwZF+Poim/QsLivQbAgiaXtHKtgo3aS0nazBtjPJmD1z/yRNmBmGzQZWCKpxH4aAP/xMnlGVHGL7NRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467750; c=relaxed/simple;
	bh=gLShZw6ulRqmvBahtkw0CgrsQ8I7xzuwNSNNbmxGit0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7UsU6LodjOOt/uWYHIvAyIyZW9DWZXL8/pvM6buvV2/uEwkmwvHq9X3eB8IZkRstBuOPvtnqKetlclw/kezcelx6j2rVzq3HNnXJYZbpTNwX9jzo0vP++NzmoB9RCki3Lf6IGalUXXT8zh9zQdyUPnvITyeBzR1u/NVH+LU4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=b223NfQs; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="b223NfQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768467720; x=1769072520; i=markus.elfring@web.de;
	bh=6sQguX0SFG96wLHnHGpFkCRrrpT2mR3gFvQ9F92pbkI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b223NfQs/rW+FqccdIdNdtbXWpXpMnpLALbVXlQUF07dGiUlt5eeieH2wy6NcrGN
	 vU4TGwVDONN2rwU4uxzukWT/rVf/zA/SA6zICzdVVTQ9LpBCVu72K0oSIf5avEqcA
	 8mft8zzSw+G3hZ6KT9nXBbRMmRPxfzcpRSjyC2bbPQqzEksfEnzvnD8bS/Y3dJVFw
	 cgHPcOVLRUnNyu3OoFatPz6MxwomxkDlmSUNLykMbadV8DKTVQVWOvN5yzAeaw4Ek
	 pp4KbLBpTcSEh6uSr9M5iuLBE3rE64WV8mm4Zew6spX29HN7I1+Bgf5XfqKEw5XjN
	 TCyV4f+E2Xd08cEzeg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.191]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpTxm-1w9qB20176-00pt91; Thu, 15
 Jan 2026 10:02:00 +0100
Message-ID: <25f39aaa-1e72-47ce-92e7-d6b8ecc2750a@web.de>
Date: Thu, 15 Jan 2026 10:01:48 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] perf/x86/intel/uncore: Fix iounmap() leak on global_init
 failure
To: Zide Chen <zide.chen@intel.com>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260114193825.17973-1-zide.chen@intel.com>
 <cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de>
 <32386e0a-09d9-4f13-a5e1-c6f9dd3afdfd@intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <32386e0a-09d9-4f13-a5e1-c6f9dd3afdfd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ebCCccKh9ev2D7zXEZ2CLuJFjZWkvm11GNyBP2o86wb1rIAqDZp
 bJA+66fRvvqU5GiVE00el7tvW7c0WDTzFnHJzvNt/rysWBoYAJnjAc4ylBpnUHvdX0VLZQD
 oiG5p+r9odBKRF9KuwXRZkrpcpA27L4AKStPpEQ/sWoVCkOAHMmCYRIapnkv4sA8oZiVWcq
 /W6HBcQsQ073X/zlX5cTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RGLgAn1RMmM=;I4Sd6Z4PShXi1j3W8jFmFHaM+PJ
 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

>> See also once more:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n94
>>
>> Will another imperative wording approach become helpful for an improved=
 change description?
>=20
> My apologies =E2=80=94 I did try to address the feedback, but I may stil=
l be
> missing something.  Could you please point out what specifically could
> be improved?

I hope that the understanding will improve somehow also for a development
communication requirement like =E2=80=9Cimperative mood=E2=80=9D.


>> =E2=80=A6
>>> ---
>>>  arch/x86/events/intel/uncore_discovery.c | 15 ++++++++++-----
>> =E2=80=A6
>>
>> Some contributors would appreciate patch version descriptions.
>> https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+=
previously+submitted+patch%22
=E2=80=A6
> Yes, that was the intention for v2.
>=20
> V2:
> - As suggested by Markus, add an `out` label and use goto-based error
>   handling to reduce duplicated iounmap() code.

We are still trying to discuss the corresponding identifier selection,
aren't we?


> - Add the original warning from the kernel test robot to the commit mess=
age.

It is possible then to identify presented information in the way
that it is probably coming from coccicheck.


> - Trivial rewording of the commit message.
>=20
>>
>> Is there a need to perform desirable changes by a small patch series?
>>
>> * Specific fix
>> * Related refinements
>=20
> It seems to me that the changes in this patch are small and closely
> related, so I wondered whether splitting it might be unnecessary.

I propose to apply a more detailed change granularity.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n81


>>> +++ b/arch/x86/events/intel/uncore_discovery.c
>>> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct uncore_d=
iscovery_domain *domain,
>>>  	struct uncore_unit_discovery unit;
>>>  	void __iomem *io_addr;
>>>  	unsigned long size;
>>> +	int ret =3D 0;
>>>  	int i;
>>
>> Would scope adjustments become helpful for any of these local variables=
?
>=20
> As mentioned in my earlier reply, my suggestion was to avoid doing other
> unrelated optimizations in this patch.

Will development interests grow for related update steps?


> https://lore.kernel.org/all/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.c=
om/T/#t

Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init failu=
re

Can the timing trigger special considerations?


>>> @@ -273,21 +274,23 @@ static int __parse_discovery_table(struct uncore=
_discovery_domain *domain,
>>> =20
>>>  	/* Read Global Discovery State */
>>>  	memcpy_fromio(&global, io_addr, sizeof(struct uncore_global_discover=
y));
>>> +	iounmap(io_addr);
>>> +
>>>  	if (uncore_discovery_invalid_unit(global)) {
>> =E2=80=A6
>>>  	}
>>> -	iounmap(io_addr);
>>
>> Can this modification part be interpreted as an optimisation?
>=20
> Yes, this is technically an optimization.

Thanks that we can come to the same conclusion on this aspect.


>                                           Since the patch is already
> refactoring the iounmap() handling, my thinking was that it would be
> reasonable to include it in the same patch.

I dare to point another opinion out.

I assume that backporting concerns can influence this detail also a bit mo=
re.


>> =E2=80=A6
>>> -	if (domain->global_init && domain->global_init(global.ctl))
>>> -		return -ENODEV;
>>> +	if (domain->global_init && domain->global_init(global.ctl)) {
>>> +		ret =3D -ENODEV;
>>> +		goto out;
>>> +	}
>> =E2=80=A6
>>>  	*parsed =3D true;
>>> +
>>> +out:
>>
>> Would an other label be a bit clearer here?
>=20
> I=E2=80=99d suggest keeping the label name out for style consistency, as
> mentioned in my earlier reply.
>=20
> https://lore.kernel.org/all/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.c=
om/T/#t
>=20
>>
>> unmap_io:
>>
>>>  	iounmap(io_addr);
>>> -	return 0;
>>> +	return ret;
>>>  }
>> =E2=80=A6

By the way:
How do you think about to increase the application of scope-based resource=
 management?

Regards,
Markus
