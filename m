Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE86ECAAD2
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Aug 2022 23:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiH2X3a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Aug 2022 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiH2X31 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Aug 2022 19:29:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2074.outbound.protection.outlook.com [40.92.40.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0486B876A4
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 16:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO9wPEdZFCI58YyO39a4sd/GErww8fRaATuqSECQ158hjQT5EjPQtNRbbhFEev4KIU6FT99QKIIjQ7YMoHhmN2D5AGkA3kXPW8eCvbjdKIwlkkdhcGVWXmEefFcNQYnt9hxUqFylpBZRqJUUHhFdXsHEWBDkVnHigCcgabcjYhYeY5loUrzEpmU7+xfYrj6r01NQWunSZp29+iLkhW8SKnOrpHUDi11AM5Ia9PBQ7gc3DQtTtb0M9riS9AI0l5JXQOuco9/FmcdLMVg6YmCP1SZLmV+XbwpK3beSBxt/JW57rzUXYkeRqN+Oq2yXuYEFnDOJu/c1k1SNGhcNUKzaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAqLHKeEur5TiekRmYWzvB7JLSAfjy3JEzIUBAaB6MQ=;
 b=iOFcespKiemONl9j6Wu6ws7atqSiBKn1BqV3yKG68p5ARPc5TI6Z4xneLTayjDcNz4Rt8cc+K88DG2SVbqMaOo/vVSEZt4H37GBJGtbRKOr+aVL7dHIL9VlulI/bT9RRvjvAzZS4Zqn3RL1YXiYl8e2p5JAhxcq0LYQFC2Ddli5RjxagXn981yRoTtnDq51ODFb2BMh9z7UZjIpzoruEGRJ2anNTZg4M8kBz74hFMHzwIW2k/JzhU2ZDlPJo7LWjsQldcVtBeKf9/+z35YNNtCDYr5SPDKrQEX0MjSv8tgUnByUN8Cs7vM5Me19cQOt2IE36T/CrzkxQgKrAye4SnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAqLHKeEur5TiekRmYWzvB7JLSAfjy3JEzIUBAaB6MQ=;
 b=NZdFS/LWKsyfdagg7+MD4OfpoxMKEQLOiHKBIoL/DESLXzGBHfAHSRSUHHPTrZJNZ1a3FmZuuTmrkz2fDxWSePh0SWoqg6CrSSskAgwlSFQ2PQl5zwAW3iRQvEuV2qz86Jknjit0cmKCIYqFFw0TUQ8HqoJId/6fHMWHHQZ4TT1/2Bkp+uZSGIAkMIVzLwjC1YgM1TB9a83huDRqCqZpUjlNJRI60aRM51VNWFQD3MmyHr7zOzLRQz/JvJ3BMzjGvQEKZr/qenJMHkArMHMNANzPX7om2f0gmAFWWjcxxuMLJsgcFMVA1Kke0SBIp0GPh2u/xFfK8AILIxK5M5tNGQ==
Received: from DM4PR18MB5026.namprd18.prod.outlook.com (2603:10b6:8:51::10) by
 CY4PR18MB1447.namprd18.prod.outlook.com (2603:10b6:903:108::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 23:29:24 +0000
Received: from DM4PR18MB5026.namprd18.prod.outlook.com
 ([fe80::ec38:b8f9:7657:e7b0]) by DM4PR18MB5026.namprd18.prod.outlook.com
 ([fe80::ec38:b8f9:7657:e7b0%7]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:29:24 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: Cannot print 'uregs' field with perf script -F uregs
From:   Hongtao Yu <Hongtao.Yu@outlook.com>
In-Reply-To: <Yw056ndacsdoAyVg@krava>
Date:   Mon, 29 Aug 2022 16:29:21 -0700
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <DM4PR18MB502656F9122018CA3713ADD48A769@DM4PR18MB5026.namprd18.prod.outlook.com>
References: <DM4PR18MB5026C7008C77EF24557409138A6B9@DM4PR18MB5026.namprd18.prod.outlook.com>
 <YwyxOVALB0mUf/t9@krava>
 <DM4PR18MB50267E1E2D1A247C5E10F8098A769@DM4PR18MB5026.namprd18.prod.outlook.com>
 <Yw056ndacsdoAyVg@krava>
To:     Jiri Olsa <olsajiri@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TMN:  [kwf8odRBMt+Qm0WQpFBG77D7uT0f1UK0fp1QCO0vlRDCt/wFH8pdfw==]
X-ClientProxiedBy: BYAPR08CA0065.namprd08.prod.outlook.com
 (2603:10b6:a03:117::42) To DM4PR18MB5026.namprd18.prod.outlook.com
 (2603:10b6:8:51::10)
X-Microsoft-Original-Message-ID: <59D539F8-9D63-4B46-9455-26E84C1E3308@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aea2cd00-627c-49f0-fbe1-08da8a164ea9
X-MS-TrafficTypeDiagnostic: CY4PR18MB1447:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Piv8Bh8TSldKJwtgDjYIJC5L33UN/pjU8RHeUbgdv+bULceQVLgztVG/v1lFMY2tdF1jqgUk/pPei7E2SYIIjPHWfQ/ilW4QXl0Dsm/pKBvw3B/V1cS7TbBLuJfbzNm26ZTFEq3Bjtfky/qhLVgUq9xcFE6+dTx5Dqy371yXUOwfSxsL1H0JZQpJ9kas0eTOrzHbO2nvMXQ0fkJtwAinWhkteDlNikCpF5thniQ6cUa475TjgHOmvk8LBTprjhNBULqokUeNxcnTYPWIWrXKeY6Yu/SDgc7Fxwd2EhT/5I4rIeBdPhbV6btR+cI+XkCsqL55Nx/up97ZtyGz9DBOKw9NGs6bcA4WySr36MSGtOgxKqj8GKFyvcAT8DufM82Ebc4rtLYMj1zmgdeDYik8wbgCTi+pCAw7uUvpdFT9mJrajTrjZtJehHa/p4L9B+TM6ZGgMDE+pc3QaEWvBWcB5X0iPPVe8u//uMw/i5Lnh3au6a3qLDN+oOXCxf9LY6MAFkG5txOi8zuxo3OfNuQUSdJCbjlf26AHjrAv6eeF4mjUio4nFQfEV99HuTZdQoNII4lhW0weSklZj/7Y4engcYlORikQP/1kpDk83TlXTnlrBQNxyB7WGJZ51TVN6N6/V4o+2OMp78viECX/m/DZBYUg8Tw7aw2dBOTitm9I+iKVjXIydAUs8ecra287vsA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUFiMFgxL0JNMTkvZWdlL0EwWEJ2My9GdDI3UnRsc2pWeE9qdC9EREQwN0ho?=
 =?utf-8?B?dFY4SkJHNG1LaWs3cnAwaFg5Z29ra1FhaW9XYUs5UmdjRHhHMTF4V0loVlBV?=
 =?utf-8?B?Q2pTdEM0VUk1cUN0TGw4UmdSQ3ZvU1Y5SkpGMEt3Vko0YnA3d3AzMG1XYmhM?=
 =?utf-8?B?SEE3Qnc0TXdPWkZMS2VaZHozb1FBK3pOR3ljTWlwYm9HM3NkbC9SOExiZE1U?=
 =?utf-8?B?bWUzbThUY2JKeVhBMnp0cmt4Z2JxUDVlVjQwSHlUbW01eStjMzJZNkRqTEVM?=
 =?utf-8?B?NW55YUV6R1BxSnBEZVdzN1FObUdaRjhaYnhDYXVUR25YV2toOCtsclFmemJ3?=
 =?utf-8?B?NzNsS0UrbFNCYW53U1R2L3gxNFVqOU1idFdkSFNaMXRXM3p6OGp2RlNaQ0hr?=
 =?utf-8?B?akhJUE85aE1xZndKWG9TbFFOaTdFZ2FFVk5CSkoyVFNiVTE1ZVVHZVRnME1P?=
 =?utf-8?B?cXp1Unora2lNVHNZUVBXVzA0T2xEN2hmMjJ5d0FNanpLNWJSUUQ0MVgxc1ha?=
 =?utf-8?B?VnIwdWordFl0NEsxRmR4Ylp2V2VkZXFoYkE5NUtLK205U1dyczc0TTJTeUcw?=
 =?utf-8?B?QVllaXhZeVR0czEzZXBmcElxY0UxaWc3T0tHWVdHS2pYQXptbThsL1VKaGpa?=
 =?utf-8?B?dEdvVERqSzdFMnBWL2swR0d2and2dXZMNkJjUi9qL1VTZEhVaFBJQzlLcWdl?=
 =?utf-8?B?RnBFM0lJT3YvUXBzc3phaUkxUHdCQlpqS2pHaytWemFHVkZZak56aWZ1bG5M?=
 =?utf-8?B?djAvQnc3SzlMWGI0UnNwQ21IRElIOTl6dEQyeTZWUGNxWG1OSWpqanRVK0dB?=
 =?utf-8?B?dlZ2aXlSdTdId0dUakNZQmloN3BubnAyRndNU3o2NU8wSGZEbSsrelNEd1cz?=
 =?utf-8?B?UG1aQXYrQmtkUDlUb1VFdHJ1ZG1zSXdyRk9VbU9wWlVJNVlZWHFTdCtOZ3Ix?=
 =?utf-8?B?MlpSMFpya2RYM281UURvVHBsUTZES0d5bGRheUh4WDg2SHRtN2Z6Q3JmSHBk?=
 =?utf-8?B?Q3hIZmMyLytxcjZLbDZhbFY5OVNrenYxN3FiVHpiTm05L3RhQnNGSnZRSnFm?=
 =?utf-8?B?MFdvd0EzR1poRGJhczE0d3ByQkpNdkN0dkJDVjJya0J2OWJzeHlacHRkNVgv?=
 =?utf-8?B?K3diaHhiTS9JNkN0ejRRNGJlRVBDN3kwU0hlNS9YSTRQc2FDYjJjT0h2UnlU?=
 =?utf-8?B?dFpvU1QrN3ZCZ1l3endjMktxbWlDSUJobEgwbGdZYi9rMHJ1WDE3RHRqd2gr?=
 =?utf-8?B?MSsxeVViVTlTRVpRUjVTL1U2STRoWWY3QUZtOEhrWHNsN2JzcURVai9lVm01?=
 =?utf-8?B?RmdwZWY0S0J0YzU0L0hvMzRMeTY3UTdZUXB1cStaZUQ0aVdzT3E0aEF0ZGRj?=
 =?utf-8?B?UFRvU2U0SjZZVmtGcVczaXJ6NDVwbzM4eTlzbVFHcU5QNmR1aTJJMlB5dCtv?=
 =?utf-8?B?aXR2bVFCdlRiWldZWDRFSzFXVEYyYlpSRFpkc3lQRjBzQUFmMzNVbnpMdUVK?=
 =?utf-8?B?YWdGMHN5dCtXNTdrNUdjdnI1cUhkTnkwRi9WQUpSYllYbENZYTdqZnMvY0dm?=
 =?utf-8?B?a01qZ09tN0FEM1pKYzZZKzl4NUZMRGc2ZURHcmMzNHNrRmpYRStkY0tTY2xt?=
 =?utf-8?B?L3ZaUmxOR0pOUEczdU4rSUMySWpXaHp4eEd2cFEreXBLVCs1U3RXNGdYNkNY?=
 =?utf-8?B?a294U1QxYlZzdWJRL1YzWGlFaXQ2WmdWTi9jVXpkaGpicGZWbFQ4UWd5MXRt?=
 =?utf-8?Q?I/k/HF50W2UP69fsoTNgXJKLGFI6oKeQzZzhN3q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea2cd00-627c-49f0-fbe1-08da8a164ea9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB5026.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:29:24.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1447
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On Aug 29, 2022, at 3:12 PM, Jiri Olsa <olsajiri@gmail.com> wrote:
>=20
> On Mon, Aug 29, 2022 at 04:24:57PM +0000, Hongtao Yu wrote:
>> Thanks for the response. I tried with hw:uregs but it didn't seem to wor=
k expectedly. Instead of giving uregs samples, it gives something like
>>=20
>>      hhvmworker 10485 [003] 2812596.974788:      16009 br_inst_retired.n=
ear_call:uppp:          10349698 [unknown] ([unknown])
>>      hhvmworker  4412 [006] 2812596.975085:      16009 br_inst_retired.n=
ear_call:uppp:          1339b05e [unknown] (/tmp/perf-1530.map)
>=20
>=20
> could you share how do you record the data?
>=20
> it seems to work on my setup:
>=20
> [root@krava perf]# ./perf record -a --user-regs sleep 1=20
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 2.477 MB perf.data (1574 samples) ]
>=20
> [root@krava perf]# ./perf script -F hw:uregs | head -10
> ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce507=
40f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde=
560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:=
0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff=
   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
> ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce507=
40f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde=
560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:=
0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff=
   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
> ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce507=
40f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde=
560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:=
0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff=
   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
> ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce507=
40f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde=
560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:=
0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff=
   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
> ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce507=
40f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde=
560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:=
0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff=
   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
> ABI:2    AX:0x20ddb70    BX:0x7ffde3dde620    CX:0x1    DX:0x2030b80    S=
I:0x0    DI:0x2090f60    BP:0x7ffde3dde5f0    SP:0x7ffde3dde5d0    IP:0x4c6=
afa FLAGS:0x8    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x2=
46   R12:0x7ffde3dde600   R13:0x0   R14:0x0   R15:0x3=20
> ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce507=
40f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde=
560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:=
0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff=
   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
> ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce507=
40f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde=
560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:=
0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff=
   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
> ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce507=
40f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde=
560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:=
0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff=
   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
> ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce507=
40f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde=
560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:=
0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff=
   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
>=20
>=20
> [root@krava perf]# ./perf script -F hw:+uregs | head -10
>            perf 958512 [000] 278398.227483:          1   cycles:  fffffff=
f9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36=
.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff   =
 CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0   =
 SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b  =
  R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xf=
fffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
>            perf 958512 [000] 278398.227486:          1   cycles:  fffffff=
f9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36=
.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff   =
 CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0   =
 SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b  =
  R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xf=
fffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
>            perf 958512 [000] 278398.227488:          8   cycles:  fffffff=
f9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36=
.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff   =
 CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0   =
 SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b  =
  R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xf=
fffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
>            perf 958512 [000] 278398.227489:        173   cycles:  fffffff=
f9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36=
.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff   =
 CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0   =
 SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b  =
  R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xf=
fffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
>            perf 958512 [000] 278398.227491:       3967   cycles:  fffffff=
f9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36=
.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff   =
 CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0   =
 SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b  =
  R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xf=
fffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
>            perf 958512 [000] 278398.227493:      90589   cycles:         =
   4c6afa evlist_cpu_iterator__next+0x2a (/home/jolsa/kernel/linux-perf/too=
ls/perf/perf) ABI:2    AX:0x20ddb70    BX:0x7ffde3dde620    CX:0x1    DX:0x=
2030b80    SI:0x0    DI:0x2090f60    BP:0x7ffde3dde5f0    SP:0x7ffde3dde5d0=
    IP:0x4c6afa FLAGS:0x8    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0=
x0   R11:0x246   R12:0x7ffde3dde600   R13:0x0   R14:0x0   R15:0x3=20
>            perf 958512 [001] 278398.227515:          1   cycles:  fffffff=
f9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36=
.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff   =
 CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0   =
 SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b  =
  R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xf=
fffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
>            perf 958512 [001] 278398.227517:          1   cycles:  fffffff=
f9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36=
.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff   =
 CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0   =
 SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b  =
  R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xf=
fffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
>            perf 958512 [001] 278398.227518:         13   cycles:  fffffff=
f9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36=
.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff   =
 CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0   =
 SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b  =
  R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xf=
fffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
>            perf 958512 [001] 278398.227519:        415   cycles:  fffffff=
f9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36=
.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff   =
 CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0   =
 SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b  =
  R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xf=
fffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff=20
>=20
>=20
> jirka
>=20
>=20

My command is mostly like yours except for a given event and a sampling fre=
quency : perf record -e br_inst_retired.near_call:uppp -c 16009 --user-regs=
 =E2=80=A6

Hongtao


>>=20
>> Thanks,
>> Hongtao
>>=20
>>=20
>>=20
>> From: Jiri Olsa <olsajiri@gmail.com>
>> Sent: Monday, August 29, 2022 5:29 AM
>> To: Hongtao Yu <Hongtao.Yu@outlook.com>
>> Cc: olsajiri@gmail.com <olsajiri@gmail.com>; linux-perf-users@vger.kerne=
l.org <linux-perf-users@vger.kernel.org>
>> Subject: Re: Cannot print 'uregs' field with perf script -F uregs=20
>> =20
>> On Mon, Aug 15, 2022 at 10:34:44PM -0700, Hongtao Yu wrote:
>>> You fix works, thanks! Are you going to commit it?
>>=20
>> sorry for delay.. I was checking in more detail and we actually
>> can do it even without the fix with 'hw:' prefix like:
>>=20
>>   # perf script -F hw:uregs
>>=20
>> dummy event is special, but I'll need to check if we want
>> to hardcode that first
>>=20
>> jirka

