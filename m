Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF68FC433E9
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6955A64ECA
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhBRTAl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:00:41 -0500
Received: from mr85p00im-ztdg06011801.me.com ([17.58.23.199]:52553 "EHLO
        mr85p00im-ztdg06011801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232353AbhBRRJC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Feb 2021 12:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1613667528; bh=SMH8zMQSwJptrNF59bbPMPzkEctwQqwf+VAq2Dpw0jU=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=RdJaZYQCy/qZQCEvw2MBxYc/MERiVdHCaP+Iv21Uaklnn/PjrpIOKSlRkWL+Op0M5
         DB8YsCtxeBaOkvF9vCWeuMjQ0vN3zEpzfgEGlbjx1LfmQ99efcfdfOFwi7lqwEooNR
         Z2r7Kkjt4TK06jk26Zo8QLs/NpOAJkrROfg1Jay7+dc+PLfQaZlPp7QSMSkQpYBD1c
         0c5+7hmncf7gNjo5+fmWqoHDYV9mpGJQjsTvufAT1+89cE05m58GrYI9li1G0efuBB
         1cfK1utuCQTaK30f1hJNV7NxbdNAvbX5J1UBdiWh6jMPEhJfdo7kkZU0/ns+Z5wmA8
         MO7EFskcomBcg==
Received: from [192.168.178.23] (home.amunra.co.uk [88.97.61.234])
        by mr85p00im-ztdg06011801.me.com (Postfix) with ESMTPSA id 50C8EC0281;
        Thu, 18 Feb 2021 16:58:47 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] perf unwind: Set userdata for all __report_module paths
From:   Dave Rigby <d.rigby@me.com>
In-Reply-To: <20210218165654.36604-1-d.rigby@me.com>
Date:   Thu, 18 Feb 2021 16:58:44 +0000
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D53872E9-71B0-4F1F-8640-672CE1ABE344@me.com>
References: <20210218165654.36604-1-d.rigby@me.com>
To:     Dave Rigby <d.rigby@me.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_08:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102180144
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I missed adding a link to the bugzilla issue: =
https://bugzilla.kernel.org/show_bug.cgi?id=3D211801

Note sure what the recommended way of tagging that in the patch is=E2=80=A6=



DaveR

> On 18 Feb 2021, at 16:56, d.rigby@me.com wrote:
>=20
> From: Dave Rigby <d.rigby@me.com>
>=20
> When locating the dwarf module for a given address, __find_debuginfo()
> requires a 'struct dso' passed via the userdata argument.
>=20
> However, this field is only set in __report_module() if the module is
> found in via dwfl_addrmodule(), not if it is found later via =
dwfl_report_elf().
>=20
> Set userdata irrespective of how the dwarf module was found, as long
> as we found a module.
>=20
> Fixes: bf53fc6b5f41 ("perf unwind: Fix separate debug info files when =
using elfutils' libdw's unwinder")
> Cc: linux-perf-users@vger.kernel.org
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Jan Kratochvil <jan.kratochvil@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> ---
> tools/perf/util/unwind-libdw.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/perf/util/unwind-libdw.c =
b/tools/perf/util/unwind-libdw.c
> index 0ada907..a74b517 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -60,10 +60,8 @@ static int __report_module(struct addr_location =
*al, u64 ip,
> 	mod =3D dwfl_addrmodule(ui->dwfl, ip);
> 	if (mod) {
> 		Dwarf_Addr s;
> -		void **userdatap;
>=20
> -		dwfl_module_info(mod, &userdatap, &s, NULL, NULL, NULL, =
NULL, NULL);
> -		*userdatap =3D dso;
> +		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, =
NULL);
> 		if (s !=3D al->map->start - al->map->pgoff)
> 			mod =3D 0;
> 	}
> @@ -79,6 +77,13 @@ static int __report_module(struct addr_location =
*al, u64 ip,
> 					      al->map->start - =
al->map->pgoff, false);
> 	}
>=20
> +	if (mod) {
> +		void **userdatap;
> +
> +		dwfl_module_info(mod, &userdatap, NULL, NULL, NULL, =
NULL, NULL, NULL);
> +		*userdatap =3D dso;
> +	}
> +
> 	return mod && dwfl_addrmodule(ui->dwfl, ip) =3D=3D mod ? 0 : -1;
> }
>=20
> --=20
> 1.8.3.1

