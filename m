Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A21DC9B5;
	Fri, 16 Jan 2026 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547816; cv=none; b=Vw3gynpvs8TMNep0uQI44V0GgoY49wqQmWkNjPGtNPGHkHG1r7Mp9Aj131NxaEsGYioaAxGbPJN+xG6tdQYgC2jzaV5/gQTFCtqEe4ZSFmfJ797APhnewyuq3rpX1dRfOZ0Ursh+799W/mgpQgzykxy6QXXyz+BB6b92WTgLNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547816; c=relaxed/simple;
	bh=WK1k2tXRHttFAnVeH1b+A0GYI0qBxecRM+bmrmtNpLs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=huHiq4mb68VjR1sG2ls2q2ui6BWXMxhVZ9skivvbsyeVUTVyDAyEuOEYA0QLf0h3ZQB4A07+tIubf6/dCW+h6LYLS99y3aDLwp58E7mcJSVujKhxF3c43Liz1ycdttta7o5Hbj27TJWGAk3EOKIZEkikFA13oGsLzu/ZbhuHwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Y9k4wUD/; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Y9k4wUD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768547808; x=1769152608; i=markus.elfring@web.de;
	bh=IUdlntFum7uRRgWyGN0jnp3MpiON0cwurbWj1y5cNJw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y9k4wUD/B28SEqYkBSSvDrhOwxBEc7YL8xf3MKmE2WAczNZRcxaYnGRzTicj2FJt
	 Cgj08VAW3xYW1QX0btmY+YpCli5KDl/mvHzoM3xVZTCAM1BNJSQImhFOLpZ6xYsFN
	 1/1FZGl2U9VBp/vzITapDOuImWl8hXqlhFTYmG/sFmiBfPIbxrFqFVsw+oRf0l45I
	 Ccc0XmHsd1zJfsUj2BipdX89r6dHFTSrT0oZChnXsxgv3UPhGhBRdHjmYWnEy4b6A
	 K9d583fJfQVpPllutvk3yCx12vPocWeT+uSiT36prvd6rgRx9N0PoXI2DiT6B6k6A
	 aS5brGtaxWAVde+YGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFayq-1vbgWn3zl0-000Pmy; Fri, 16
 Jan 2026 08:16:48 +0100
Message-ID: <afc060ac-0cb9-4e2f-8cdc-029ac7679246@web.de>
Date: Fri, 16 Jan 2026 08:15:59 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
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
 <25f39aaa-1e72-47ce-92e7-d6b8ecc2750a@web.de>
 <b7c46240-d0b3-472d-87dc-88cdbd8e0b92@intel.com>
Content-Language: en-GB, de-DE
In-Reply-To: <b7c46240-d0b3-472d-87dc-88cdbd8e0b92@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bX52E90dCkc38H5aVvQReZTVfB9ENbPUFTRYKV4ZSQFezp60/3j
 VnDxTi851MRJtSCdnjNuGIWRM0UEC26QQGp4QcoXOLHFDAsdRpuRJDEijriGieizmfGwzaO
 JS7PnIeQmtqAW2sG69tSY04Kr+H4mO3Qg+IoyEhfBmIKgCMxcJ9YaMYKYyb9gtcMsluz9l9
 DACZ5DtG48zG/6XtBNx5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MyWk9lrFw/o=;1BzaPLY7QDal6l6+GE4ZIhvQQYu
 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
 QbqrTsTSozKd/WJfWr3ur3g46Y7w3

>>>> See also once more:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n94
>>>>
>>>> Will another imperative wording approach become helpful for an improv=
ed change description?
>>>
>>> My apologies =E2=80=94 I did try to address the feedback, but I may st=
ill be
>>> missing something.  Could you please point out what specifically could
>>> be improved?
>>
>> I hope that the understanding will improve somehow also for a developme=
nt
>> communication requirement like =E2=80=9Cimperative mood=E2=80=9D.
>=20
> For the commit message itself, I=E2=80=99ve tried to improve it as much =
as I can
> based on the feedback so far. If there are still specific phrases or
> wording that should be adjusted, I=E2=80=99d really appreciate it if you=
 could
> point them out.

1. The mentioned source code analysis report is obviously helpful.

2. You added a custom explanation accordingly.

3. Which text part of your change description does contain =E2=80=9Corders=
 to
   the codebase to change its behaviour=E2=80=9D?


>>>> Is there a need to perform desirable changes by a small patch series?
>>>>
>>>> * Specific fix
>>>> * Related refinements
>>>
>>> It seems to me that the changes in this patch are small and closely
>>> related, so I wondered whether splitting it might be unnecessary.
>>
>> I propose to apply a more detailed change granularity.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n81
>=20
> Thanks for the reference. I considered this a single logical fix, which
> is why I kept the changes together.

I find this adjustment approach also =E2=80=9Clogical=E2=80=9D (in princip=
le).


>>>>> +++ b/arch/x86/events/intel/uncore_discovery.c
>>>>> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct uncore=
_discovery_domain *domain,
>>>>>  	struct uncore_unit_discovery unit;
>>>>>  	void __iomem *io_addr;
>>>>>  	unsigned long size;
>>>>> +	int ret =3D 0;
>>>>>  	int i;
>>>>
>>>> Would scope adjustments become helpful for any of these local variabl=
es?
>>>
>>> As mentioned in my earlier reply, my suggestion was to avoid doing oth=
er
>>> unrelated optimizations in this patch.
>>
>> Will development interests grow for related update steps?
>=20
> Are you suggesting including this change in this patch?

Does anything hinder you to take patch series better into account?


>                                                         My understanding
> is that it isn=E2=80=99t directly related to the scope of this patch, so=
 I would
> prefer not to include it here.

Can we imagine further patch variations?


>                                Please let me know if you see it differen=
tly.

This is the case according to another evolving patch review.


>>> https://lore.kernel.org/all/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel=
.com/T/#t
>>
>> Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init fa=
ilure
>>
>> Can the timing trigger special considerations?
>=20
> Sorry if I=E2=80=99m missing your point, but it seems to me that there a=
re no
> special considerations involved here.

1. You announced planned changes for an initial patch.
   https://lore.kernel.org/linux-perf-users/fc565620-a3ef-4a28-bfb8-87bb5c=
e135f5@intel.com/

2. I offered review comments accordingly.

3. You published the second patch version.
   https://lore.kernel.org/linux-perf-users/20260114193825.17973-1-zide.ch=
en@intel.com/

4. You replied to the mentioned review approach three minutes later, didn'=
t you?
   https://lore.kernel.org/linux-perf-users/e7d74d9d-cb45-4f5f-8e44-502dd7=
c4bcff@intel.com/



>>>                                           Since the patch is already
>>> refactoring the iounmap() handling, my thinking was that it would be
>>> reasonable to include it in the same patch.
>>
>> I dare to point another opinion out.
>>
>> I assume that backporting concerns can influence this detail also a bit=
 more.
>=20
> Thanks for pointing that out. This patch is intended as a quick fix for
> a change that is still staging in perf/core, so I assume that
> backporting is unlikely to be needed.

Will backporting be usually desirable for Linux software components?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/backporting.rst?h=3Dv6.19-rc5#n14

It happened again that further change possibilities were noticed.
Thus companion patches can be considered on demand.
The corresponding change recombination can occasionally become more intere=
sting
for selected development ideas.


>> How do you think about to increase the application of scope-based resou=
rce management?
>=20
> That=E2=80=99s an interesting topic, but for this patch I=E2=80=99d like=
 to keep the
> change minimal and focused.

This software design technique influences also if we would still like to f=
iddle
with goto chains (or not).
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/cleanup.h#=
L12-L17

Do you see opportunities fur further collateral evolution?

Regards,
Markus
