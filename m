Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABA1C0502C
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Aug 2022 16:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiH2QZE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Aug 2022 12:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiH2QZA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Aug 2022 12:25:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2102.outbound.protection.outlook.com [40.92.22.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5259611151
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 09:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxeD4+S/B01ph0d1YwsWrM4YOhnLmynmcIFswRN9BgdOCpNX5EP/NbtNkKjvilTL7DrJAF+90X0pex7KiyyLN0J4Gy7kFZCtY/weEghy0lJgsCSNkxqiOzBDJcZUGtMSiFZ9dw03Uf4tNOQVg8o375lC3afPGy9E7qgLbPt4g6bSqYc9Pb1qE+tVOGcyfVW9bx4wJ3VqZ0kBCrurM9MshevjPc5+O62Cs6vuvZGggHmyv8pUfniAuB5c/024Ezrz46ZDyrOs0mp9pzU8cViSYs/MIo/reNWtWpGgpQ84HXh7OdIKVATmq36BY40bkuEFzix2nfgL8vAicWNA/C12rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCO7qA7/nton2bQFw74iZuS09cDBuXOoGaTNQ/JYz+Y=;
 b=ayKOZcIKQssHi/4lRU12vHmplmwnmcX9zLjwlpU+yL/mTW7OCk/f/I7Hfkgxbp8gAODmvEu5TA/BSlNb/mtg4JUrPr55/koU5zQ9DqttZ4QuoXx2WUT0MIW39MSb84Hr7wBMw1UkabDvjo+Uy2g1BEc/QBKfujnzNTt0Pa/yYwIUwxnCt2wqmdN6MEcje40ktzWMwu0Ym3Z+yQYjfzUuWUqMBMwXoetO0nX53JnMsozih9HHAdCUiBKt1hg95b3mJhNRxNJG3MFIsCEpLezZjSW9bEsKA30dxZO4G5z6rZKwhhL+FAbyJ+lhpS4IR13+4d5C2iuQN9aE7vHLRlF3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCO7qA7/nton2bQFw74iZuS09cDBuXOoGaTNQ/JYz+Y=;
 b=HPPVNEGn8cBgEg/jM/gNHp6+mp1XRGIROGac/pN6M/If4zYBMtzmMOIjMJ0Z+6pZQ+TWIIHqjgCry3tpKZdMzwFT86zUTe7CYhGHX+XKzpnRB6m8v0PQAEYjC1M7A2VkyUHfVs0FNVYKvgnwepRip1bkx2kdD4FkOEXaSWbI9+qKe2hhq6FwWNL/46llvHYLYiACqA6r70lSBd5/wZBrQcf2XTazRqmYXoJ7VsihSSKn7Y68zp0c7eJxHra6y0HS2KqYe5XbtVQt8dju/sYVJ3utRigDjKp1488t7YNtNvqLuB9B1IVcJ9JLgupRduOZLt5etoMvMS8MM+f8vHD87A==
Received: from DM4PR18MB5026.namprd18.prod.outlook.com (2603:10b6:8:51::10) by
 DM6PR18MB3209.namprd18.prod.outlook.com (2603:10b6:5:1ca::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Mon, 29 Aug 2022 16:24:57 +0000
Received: from DM4PR18MB5026.namprd18.prod.outlook.com
 ([fe80::ec38:b8f9:7657:e7b0]) by DM4PR18MB5026.namprd18.prod.outlook.com
 ([fe80::ec38:b8f9:7657:e7b0%7]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 16:24:57 +0000
From:   Hongtao Yu <Hongtao.Yu@outlook.com>
To:     Jiri Olsa <olsajiri@gmail.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Cannot print 'uregs' field with perf script -F uregs
Thread-Topic: Cannot print 'uregs' field with perf script -F uregs
Thread-Index: AQHYsTHlv1alxiqDpkm9VMrDmse9fq3F46aAgABBG0A=
Date:   Mon, 29 Aug 2022 16:24:57 +0000
Message-ID: <DM4PR18MB50267E1E2D1A247C5E10F8098A769@DM4PR18MB5026.namprd18.prod.outlook.com>
References: <DM4PR18MB5026C7008C77EF24557409138A6B9@DM4PR18MB5026.namprd18.prod.outlook.com>
 <YwyxOVALB0mUf/t9@krava>
In-Reply-To: <YwyxOVALB0mUf/t9@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [JS3Ktn/b2kdntrb7JyuxTj9J6N63H5/tkyXOBOGjnmbrww/J09ZrDQ==]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a74a911f-bd4e-49b3-f6e8-08da89db0335
x-ms-traffictypediagnostic: DM6PR18MB3209:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQM0l+YZgppNkr4op3wByPfolpZQe1+rmF63LUyN/ziFZj97YGGATOgJXkdedElxlsgXhIGG+/59DknS1ASMOGo9KH8eRMpjWgyjbbsF6NYx+Wl7LiA+Hd7tKVGKxEBZS+uvQSUFRIgjX3JrizOdrcpWHDYw91WFuvjOkpHJYJUvP9y++5VJsdHSXxOtdttCNXJ5vE8VqxHV2Vw1sEnYLDKveLpxlv1bS+cDsfjjc0iv6UHYk9saWnZZHJS8V7BuxhfjCaNYGBTBawgIsIQHmXKf9ofco3nkTQciC9R54PZBRdmNz9sL5ozQQMXmqvqxVzQhDnQPCZaUfvSR1XtEiDl/oHBsbQjHVF/GuQBRafeoPq6P8GlkKXDyULAPsDUMnEZui2+jucYukw3T21OIhOrbIzFMfZYgNkoP3WBA/pPJ8aWt3HDu5y1Ho+J4mqn89aHr3ZS2WEx4aFECedwDYVst6ySYg6Vzg69xoBcaEV418R03V7afcfkq/JN4rMr/LRIlTuActQ8VUBDINi3lf/7KfsoKeerFYX4RErU1b65cZE73eYGR3mMWdxDsAggFAjmvTWUZCXkknLnNT+6mMxtvNtqfdmp0I0UvD+J3NVB49kKuh/mtFRBRGxMvZmey63UH1pVI4V3+KAddWRrfPkIUBnlmT10LdnhkH5w4ICBRehjMvX73TtVfEGH1yilN
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JeGG9aVeb5SzIFV01F7pgSymqja9IgsgFPjuSQ6Dx9sDNH+fe+DBESTNvv?=
 =?iso-8859-1?Q?98HQLzpgbRDtcf2+KEO4r7vkHyqDEdq/605dIBCatgY6Q6LaM3sooNnyBL?=
 =?iso-8859-1?Q?tpIzoU82LbzoaNwoEFRguwKLlEx2H4qxevzAu3mhLPpBbrCsbQ05VGAv+O?=
 =?iso-8859-1?Q?ViUn/FEn/UgZqj15+4XZkIZcN67whQvrVltsmuEYMxTQAPOGqaIzYwLS9v?=
 =?iso-8859-1?Q?5wLm4iUiJE8NdCYhWFYra+JgYmYWPS5Dd213uIP5t8eprz4AYbt6pTiDo6?=
 =?iso-8859-1?Q?+eNpBWgGKeWeTqTCY7aGiBE6TBrpz3x+k7SImwMoegImlHlF1XYY6pLkAW?=
 =?iso-8859-1?Q?vLSvRx1ZR9Ayzi63t82N1ipFjsjVS18A5QH/VbDbro37SdBHLP71jaemTG?=
 =?iso-8859-1?Q?MGxweP4Q1Sxt75jqKHBaJnWOYdZoehoLrNgB8gN/EuaFnmMcjNXoMiQ7u3?=
 =?iso-8859-1?Q?tOnA8MIJWfhcduJAnjOsHXAKlXQozgLzV964jcYn/DaQ39jJ175Mli8hqe?=
 =?iso-8859-1?Q?N4V4CA8Kxn7wgG4CjpV6ZWtA2Z/RRlzIm24jc/yrH7jC3lAk+c3/IhKtl5?=
 =?iso-8859-1?Q?a5+zLIpwAjPnrisJcQ8RSDu/hRPq10PveCvLySaigaJTk0HTRxJtQF9AHu?=
 =?iso-8859-1?Q?/Mr7GdUST4UzUjUdINIAD7HXY8x/GD+aUHbgAcdLnKqeJmca6w3oSNQI/Q?=
 =?iso-8859-1?Q?BKI3Ofa21KgmtgmiJ/09yImIhQx+HMlhcRLAIxrCIbZ4oIfk8WjzXwpiH+?=
 =?iso-8859-1?Q?FxnDh93py1/QMwNUDdFBXvFR59DTr2EH+PE02sRf6x5C66wYpUpYTxBwX1?=
 =?iso-8859-1?Q?f4obYOA1tLGtwu4RWFKjQge65NRoTlAduMZ26hjxSczm30nsQADnMeDaCh?=
 =?iso-8859-1?Q?ZOdjCfI179eyX4EDvSyGx0GpoPrP6HEl7p4LxXY0leSbfSwD3H7AqG5m3y?=
 =?iso-8859-1?Q?BK9Ypa/jLB0VYm++v53Vie3HB/g2tZ84X8QIh07dtmPZcrtLByV981l5nI?=
 =?iso-8859-1?Q?a2DE3X5szOWUvoROje5ARfw+6xK6lK6lh1B4R4HT/oH8hV2dfXCJlR+bzB?=
 =?iso-8859-1?Q?L9VsRJ5znSC+CAq53SPEUd+V31ca7nwuLE0h03O1UA20xybdYCUg+40NIH?=
 =?iso-8859-1?Q?DKmiSME0bO4H8+5YB0LeHUYVMEosRAO2ULh9p1zLFOag9ifgcIz6lu5Vtp?=
 =?iso-8859-1?Q?X6phznWxtfsxfybY0tp82bf38Y4P4CnU30b+YZP3GybEKAAuZ1fd1DpHaI?=
 =?iso-8859-1?Q?GckhGCHuitiIy8zDb9d5ik0UqW7gG0q4YuVCd5Ush5ddkF/eYd6E1wd1QL?=
 =?iso-8859-1?Q?SdQfRqUcbNmiFoZXyOn7t864jhR112vgJJqmzTAgLz/oyos=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB5026.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a74a911f-bd4e-49b3-f6e8-08da89db0335
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 16:24:57.0111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3209
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thanks for the response. I tried with hw:uregs but it didn't seem to work e=
xpectedly. Instead of giving uregs samples, it gives something like=0A=
=0A=
      hhvmworker 10485 [003] 2812596.974788:      16009 br_inst_retired.nea=
r_call:uppp:          10349698 [unknown] ([unknown])=0A=
      hhvmworker  4412 [006] 2812596.975085:      16009 br_inst_retired.nea=
r_call:uppp:          1339b05e [unknown] (/tmp/perf-1530.map)=0A=
=0A=
Thanks,=0A=
Hongtao=0A=
=0A=
=0A=
=0A=
From: Jiri Olsa <olsajiri@gmail.com>=0A=
Sent: Monday, August 29, 2022 5:29 AM=0A=
To: Hongtao Yu <Hongtao.Yu@outlook.com>=0A=
Cc: olsajiri@gmail.com <olsajiri@gmail.com>; linux-perf-users@vger.kernel.o=
rg <linux-perf-users@vger.kernel.org>=0A=
Subject: Re: Cannot print 'uregs' field with perf script -F uregs =0A=
=A0=0A=
On Mon, Aug 15, 2022 at 10:34:44PM -0700, Hongtao Yu wrote:=0A=
> You fix works, thanks! Are you going to commit it?=0A=
=0A=
sorry for delay.. I was checking in more detail and we actually=0A=
can do it even without the fix with 'hw:' prefix like:=0A=
=0A=
=A0 # perf script -F hw:uregs=0A=
=0A=
dummy event is special, but I'll need to check if we want=0A=
to hardcode that first=0A=
=0A=
jirka=
