Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F8BC04AA5
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Aug 2022 00:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiHYAOr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Aug 2022 20:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiHYAOq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Aug 2022 20:14:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E767974E30
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 17:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn6B0q2rCFMEvUG16PnEjLZpJTgg0+U9pRNMG69kVJkTIhEoVr3kEbc6lEG+xmOxla0K/UIlR6kH2WjcXrDfUiIUh68Wjh0sJW9qdeMLYwht2uMWNw/XCohGzETbULnTPX582+JmfGdQEmQ3yrKfLoHon60XaiWzOXzNzd2ZulvbzyzJ7MZ2dYbGDOwIXMJC308x/fuwYPErNXDl8LYoxgAYmjC3HdzROoImtNRTfGASTuW9BwYwi5Z2qtiLlzEqok57qak7FYHr6bbsq6g+sza3GvPnsdf4XbIJsADXF6qjsQq6rDoM0XMx36RGmT7c1ZBO7sMKCIgUPjZLov6zNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSDWt18/+MW9aYG3mkahQR/mWDgSDtNAGfdhpj9SjAQ=;
 b=X2Wxed8OgOxfg0szvPBVU4SX3wegweaqFH8OUZbqEhCCIxajBitRoCL2ES8jfH3lVshQ47lmZhadOUk4Q1avWlMXz1SgGZ8WerB8Fur4h1P5Sm6mBsXOMk52rXW9zaC9XYDJdHwb73AAv00Q9C/cteRFY0IuUXam8GFzaXn8fFuFI5JR/bwzxoP0ylxw8JhtumrxDhz7g5WugNJwsZPtjsD28Ms7LzMhFWul9M9Z+5S2V37zEMZsLnKkpTOvTfyGRGrhZKpx1dhuAqaT26KlBanF2aH8ckoH9A6hkxB45m9x2NWn4QGUSTumvDGkAN9Y6em8Pr8eoFFpSMADjbG0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSDWt18/+MW9aYG3mkahQR/mWDgSDtNAGfdhpj9SjAQ=;
 b=LRrkEe1dj9HefMa20E+dXF/33IBIixEiGWKb48RMdJzD9US9VlwARRMJaKgw/hfOUkBGE19ehzNUP2tumnil7/IGsCpbP//Yh4uv99/B2uwHkeXYPQQ57sOAQtZrhxByvpJYBTWuBIXBjvVJ/cehrGnySmQSDnvHGIv8Bzfs2FUPFvH069sjNaqLZCKEBcHosg/+ww7cH8pi/P4Vnpf37+SNv5ctyMW19G7fgC4lj/o4gi4Enww4YaUncBrBWXvMTlZHcVfnrjImst1d1+i0t+11rJj5PBuM/WAbmlFLXPwCJtmeNRK1IeTtcJTemQjk/CJgSdfziPnbjpkifPb1FQ==
Received: from MW4PR18MB5034.namprd18.prod.outlook.com (2603:10b6:303:1b9::6)
 by DM6PR18MB3738.namprd18.prod.outlook.com (2603:10b6:5:c3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 00:14:42 +0000
Received: from MW4PR18MB5034.namprd18.prod.outlook.com
 ([fe80::88b2:5c9f:505:a22a]) by MW4PR18MB5034.namprd18.prod.outlook.com
 ([fe80::88b2:5c9f:505:a22a%2]) with mapi id 15.20.5566.014; Thu, 25 Aug 2022
 00:14:42 +0000
From:   Hongtao Yu <Hongtao.Yu@outlook.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Cannot use address filtering with user register sampling
Thread-Topic: Cannot use address filtering with user register sampling
Thread-Index: AQHYuBefxk+4eY25oUqX67pJ/KC0qA==
Date:   Thu, 25 Aug 2022 00:14:42 +0000
Message-ID: <MW4PR18MB503443512239B3F40267004C8A729@MW4PR18MB5034.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [BAybwg+73STYSTmKCQayc92waCmFv2T7rnpSyd/C0mnxVNsM9hVrLA==]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 894708c7-46b9-4248-a06a-08da862eced7
x-ms-traffictypediagnostic: DM6PR18MB3738:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gj/SyQOxq6e1KtPXERoUAw6Yp1jGmXSYkcjcM8eB62KZEtrCPJFoQAyRNsb/QpvCbWVtk/5o3+bUlOsbsr+XxtJTgzzk89YqdIpVL4SU9k96PHa2mBC/MMQRapiA6+Rd9tVSpRTF5xONtUUtlaplacbfmqXy4qL6YqOpxiefTwFNq3qBNQanWaY2bo7DhWNjAHa6Ik/xSAZInSergly6PVoEp0KYz+zof2qOoXwV8c3C7QgRDz/gS//aCuouGLgc1V7PdOIBqc1+qoufmeDHht7yftTMlPqNWQbjd95Yt+YWhYnBicRoep/rq0iaGh2YszGp7bgb/jRVMn1pDcVTv7n1ere5vsi1y5oL1xlFES0CrZ6ZR4FuD5CJ/bi2BAdmfRqgUNaMoJxkLM6IAACU2losuWSKKWdDti5J2A0xEWPnBzgeWa6DGwDukoUmPRBH0qjv+/uKbccjvpdZyqJjs7vp1bBDOrnXrbxalIAJRDG/N0riqI77IQJscIb2GzTH91S8RKX/E7WtyitH8zntYXgu1qVOhtk5qy9pN8gd5EQlyQ6Rh4R/ihkTdSKemppmwQRqM6AUx0E1p5g4taKZsXVYWw1OY8gENfmEhswSoaQuWeOQgqDGjv0tw7Zf+Hgj9VNalPPKiXpHo6JqQI5bWQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?iq614CjJD11fcvTcjVhnl/IMEbxwNmv1xh1izTZ99oxBl4e1ApSkoqDd?=
 =?Windows-1252?Q?oFfHNL5mxvo2knB7M4ino9/0CeXeHYhMPaO3TNhBVBUb7fgYEpO53npc?=
 =?Windows-1252?Q?3j3S9HG8VQpcFE5Ww+shtyMQtB16Uf3FIq5+YyhNinybhPu7Ub2fnPor?=
 =?Windows-1252?Q?qaeONb6mV0XZu1um09X2u8SUrEUK+hlIOGDEc8QL1MQYkAmhv/ZNBCHC?=
 =?Windows-1252?Q?NP5zFimsTbVjpEa2rbtlaSkqUofSdh+N7VHgpQTht9AHNHp55wF3MUKy?=
 =?Windows-1252?Q?TmTaY2PeiAP5g7/4cJ4suan52cEALQvfL4GGq6ONAMFFkCnLCYOj1Htn?=
 =?Windows-1252?Q?GiSupBQfLvTsayxJRnRkE3E20TJ2/f2k8fmGjNxml1iKlrOOUBiss96A?=
 =?Windows-1252?Q?aVwh5mBxh42h3SFndH+w6Yn0YbSCojDlt8nAk4fKRFypmb6UlCRGfyRR?=
 =?Windows-1252?Q?Vkd84dyNi6VCcYYJd70eJYxsfVu0l/bn2ZxMbjdiPOUxCeTOarl98UMA?=
 =?Windows-1252?Q?+S2zt5ydJaQ2XDpxm8rQf1WSQjyZ57BpWkzO3xaGSjL9RnqhCdhMvW/d?=
 =?Windows-1252?Q?74ZZTJbDBPmFlfh6ExcO1XWCWkX45ETp9+I+XuQh/X4T2WmBM4mIiY76?=
 =?Windows-1252?Q?tWiY6GNLhwn8jHwjkeCj6kwDC6vZhLhwo6SjbpddCfsQtXNmPtinky6Q?=
 =?Windows-1252?Q?a5YiJNJCfzcJx0yI3TnRIPmIQSaYigiVzB2FDq5bMOa/U0BIuKNd4Ly2?=
 =?Windows-1252?Q?SOH0OFxwCgKTM3quPcE+oDXnw5nqWb7nXstVVKkgvFHrwOUUvx1VT8zQ?=
 =?Windows-1252?Q?H3P+06ZpZjvjp9W58fvviEohgkBf7ZFg3EXUdzdR76Cja3WbKjxNIdLh?=
 =?Windows-1252?Q?lNc3WwSaHwg9TWf+nf7USuOUttbO5erAsQlVrGqRQOiy9v2LO4NhRyng?=
 =?Windows-1252?Q?S6ULe2Rh/w2PPkVDf3t1gcmAqMAadrXpU3X4rdAw/gJhkc+Dw1zsGql1?=
 =?Windows-1252?Q?Ulh6auPh1LsfI0QP9Q5tXcvtJR2UUYGlTXRb6I7JtZ3JFb/b2tBRb4ob?=
 =?Windows-1252?Q?8S9vwdTPDUR4v6RDD7Ek2KfaSQ/HmyQJss/vscBz2lzRFcvzHS+A+Ygh?=
 =?Windows-1252?Q?ri0q+l5kVb1/eB8RgJChQsVU9wxWFHNW7Jn6ILpumdcJLG2SmU+tmuly?=
 =?Windows-1252?Q?6K9ViwaDHl4VB4aYrDLNG4E6EiSiJPMTrO9NrGatV9heUXTzBRDrSSav?=
 =?Windows-1252?Q?k6oGONv1Fou1hcpwH4I/oUwm4yvaU2FJpZPzpFF8Z/PKgGxBxpWTjgWY?=
 =?Windows-1252?Q?5lAqeZXrj1fnpWeDTFsbgDEgJUiY9WfSYSbIEAUbph1z/wQZ+qForRYk?=
 =?Windows-1252?Q?b2mA31sI9KgB56x8VQQko9VT1u5wpNEKQVw=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5034.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 894708c7-46b9-4248-a06a-08da862eced7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 00:14:42.2563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3738
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,=0A=
=A0=0A=
I was exploring address filtering together with user reg sampling on Intel =
Skylake hardware. The idea behind it is to make reg sampling more selective=
ly. Unfortunately, I hit ` This CPU does not support address filtering` err=
or. The command I ran is:=0A=
=A0=0A=
=A0=A0 perf record -e br_inst_retired.all_branches:uppp --user-regs=3DDI --=
filter 'filter * @/bin/ls' =A0ls=0A=
=A0=0A=
=A0=A0 This CPU does not support address filtering=0A=
=A0=0A=
IIUC, the br_inst_retired event is also hardware-based, similarly with the =
intel_pt event. But the latter works with address filtering while the forme=
r doesn=92t. What is rational behind this?=0A=
=A0=0A=
Thanks,=0A=
Hongtao=0A=
=A0=0A=
