Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB14C43332
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F4864EDB
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhBRTAw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:00:52 -0500
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183]:37046 "EHLO
        mr85p00im-zteg06021501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232746AbhBRRWn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Feb 2021 12:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1613668894; bh=R8+cauNt8iwXlTyff96Q/bKyJRNxKUdP0QLCyGEeXAA=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=aKqIlNqLE/h7ubpWtTP8VdCSlEz3zC9Z6DHQbM7dU0X9DnOmLSranHtooD0i59/N3
         OlByR0FuyPg7Xk68ShU17/BDzsChiemoEqA6XuC0lGyZU4q+XIMrDhWV3zyOEt6SP7
         3IWjvR3exQBK8NxVobPwGImjw2Jq//4b3IOTqDJpREvRMANoBMBPwXmjg8Be+6jZ2J
         1ER916RUtZX38gJgDtX1gpb1USj1cfEQUyycuE+EpREuYHJBudeLnDpRfUXObMzFD4
         R4mIhDW9EtMkHlxwVOqXghhQFZ00B2JwSwOd/HbetVazqiDl17859wB9rsk62H2y7J
         T1zp011fIOUuA==
Received: from [192.168.178.23] (home.amunra.co.uk [88.97.61.234])
        by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 0DD31380973;
        Thu, 18 Feb 2021 17:21:32 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] perf unwind: Set userdata for all __report_module paths
From:   Dave Rigby <d.rigby@me.com>
In-Reply-To: <YC6hojRhuzPj/Iey@kernel.org>
Date:   Thu, 18 Feb 2021 17:21:30 +0000
Cc:     linux-perf-users@vger.kernel.org,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EBB1798-B52C-42BA-8DC2-6DAB585247DF@me.com>
References: <20210218165654.36604-1-d.rigby@me.com>
 <D53872E9-71B0-4F1F-8640-672CE1ABE344@me.com> <YC6hojRhuzPj/Iey@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102180145
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 18 Feb 2021, at 17:19, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Thu, Feb 18, 2021 at 04:58:44PM +0000, Dave Rigby escreveu:
>> I missed adding a link to the bugzilla issue: =
https://bugzilla.kernel.org/show_bug.cgi?id=3D211801
>>=20
>> Note sure what the recommended way of tagging that in the patch is=E2=80=
=A6
>=20
> You also forgot to add your:
>=20
> Signed-off-by: Dave Rigby <d.rigby@me.com>
>=20
> I'm adding it, ok?

Thanks - I missed that in the documentation.=20

Signed-off-by: Dave Rigby <d.rigby@me.com>



>=20
> Please take a look at Documentation/process/submitting-patches.rst, =
this
> part:
>=20
> =
--------------------------------------------------------------------------=
--
> Developer's Certificate of Origin 1.1
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> By making a contribution to this project, I certify that:
>=20
>        (a) The contribution was created in whole or in part by me and =
I
>            have the right to submit it under the open source license
>            indicated in the file; or
>=20
>        (b) The contribution is based upon previous work that, to the =
best
>            of my knowledge, is covered under an appropriate open =
source
>            license and I have the right under that license to submit =
that
>            work with modifications, whether created in whole or in =
part
>            by me, under the same open source license (unless I am
>            permitted to submit under a different license), as =
indicated
>            in the file; or
>=20
>        (c) The contribution was provided directly to me by some other
>            person who certified (a), (b) or (c) and I have not =
modified
>            it.
>=20
>        (d) I understand and agree that this project and the =
contribution
>            are public and that a record of the contribution (including =
all
>            personal information I submit with it, including my =
sign-off) is
>            maintained indefinitely and may be redistributed consistent =
with
>            this project or the open source license(s) involved.
>=20
> then you just add a line saying::
>=20
>        Signed-off-by: Random J Developer =
<random@developer.example.org>
>=20
> using your real name (sorry, no pseudonyms or anonymous =
contributions.)
> This will be done for you automatically if you use ``git commit -s``.
> Reverts should also include "Signed-off-by". ``git revert -s`` does =
that
> for you.
>=20
> Some people also put extra tags at the end.  They'll just be ignored =
for
> now, but you can do this to mark internal company procedures or just
> point out some special detail about the sign-off.
>=20
> Any further SoBs (Signed-off-by:'s) following the author's SoB are =
from
> people handling and transporting the patch, but were not involved in =
its
> development. SoB chains should reflect the **real** route a patch took
> as it was propagated to the maintainers and ultimately to Linus, with
> the first SoB entry signalling primary authorship of a single author.
> =
--------------------------------------------------------------------------=
--
>=20
>>=20
>> DaveR
>>=20
>>> On 18 Feb 2021, at 16:56, d.rigby@me.com wrote:
>>>=20
>>> From: Dave Rigby <d.rigby@me.com>
>>>=20
>>> When locating the dwarf module for a given address, =
__find_debuginfo()
>>> requires a 'struct dso' passed via the userdata argument.
>>>=20
>>> However, this field is only set in __report_module() if the module =
is
>>> found in via dwfl_addrmodule(), not if it is found later via =
dwfl_report_elf().
>>>=20
>>> Set userdata irrespective of how the dwarf module was found, as long
>>> as we found a module.
>>>=20
>>> Fixes: bf53fc6b5f41 ("perf unwind: Fix separate debug info files =
when using elfutils' libdw's unwinder")
>>> Cc: linux-perf-users@vger.kernel.org
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Cc: Jan Kratochvil <jan.kratochvil@redhat.com>
>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>> ---
>>> tools/perf/util/unwind-libdw.c | 11 ++++++++---
>>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/tools/perf/util/unwind-libdw.c =
b/tools/perf/util/unwind-libdw.c
>>> index 0ada907..a74b517 100644
>>> --- a/tools/perf/util/unwind-libdw.c
>>> +++ b/tools/perf/util/unwind-libdw.c
>>> @@ -60,10 +60,8 @@ static int __report_module(struct addr_location =
*al, u64 ip,
>>> 	mod =3D dwfl_addrmodule(ui->dwfl, ip);
>>> 	if (mod) {
>>> 		Dwarf_Addr s;
>>> -		void **userdatap;
>>>=20
>>> -		dwfl_module_info(mod, &userdatap, &s, NULL, NULL, NULL, =
NULL, NULL);
>>> -		*userdatap =3D dso;
>>> +		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, =
NULL);
>>> 		if (s !=3D al->map->start - al->map->pgoff)
>>> 			mod =3D 0;
>>> 	}
>>> @@ -79,6 +77,13 @@ static int __report_module(struct addr_location =
*al, u64 ip,
>>> 					      al->map->start - =
al->map->pgoff, false);
>>> 	}
>>>=20
>>> +	if (mod) {
>>> +		void **userdatap;
>>> +
>>> +		dwfl_module_info(mod, &userdatap, NULL, NULL, NULL, =
NULL, NULL, NULL);
>>> +		*userdatap =3D dso;
>>> +	}
>>> +
>>> 	return mod && dwfl_addrmodule(ui->dwfl, ip) =3D=3D mod ? 0 : -1;
>>> }
>>>=20
>>> --=20
>>> 1.8.3.1
>>=20
>=20
> --=20
>=20
> - Arnaldo

