Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31285C2BB41
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Aug 2022 08:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiHPIKE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Aug 2022 04:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiHPIJp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Aug 2022 04:09:45 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2063.outbound.protection.outlook.com [40.92.47.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE92D1AF18
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Aug 2022 22:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8zYu6AA7ZhCpOMUyoDP7g6nYCT5ppkuRr1vTY7QhqVoXoCLNL4rEnWqGmgRAtaYmgFRWf+QSHIXYCe5v5EXpRR7cFjhtai5jboEIbhKNbY9AAWQf/d29M7ZjbHNg7bKBoxe+M4pSLhvK+8qNTVgonmnX8Qq4Ye4v8TMjbsyxlKQznvYCmmm+cJz4diQa69807siUuC5SOrFhvFyu4SfDSPZ8YBNztbgAqna8w8lLFxvPn8aRnESa6a5UGjBmsc7v5ajCaIL9zg7cxWXk24rX0Z7m75wO+Fu7atjiA8vib3s86S1GjewUmuoI9hEhmpVYxm37cVS5mWK1Iv80We1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy6I4UHbqbGF8IrOstbM3WTRsIITIFOgf4ypGK2YleA=;
 b=YJHOKDdeyygKyTXUevsuPGKD7Pn+yX6xBSPF3LI6VB3Hcj6oU9biqcFlFyVDU8IS3dtTgo8iK6pUeMMDfND/XL5/OHOwypaO6OCRuEsyM0YMyHHHVrL1re/WEnxBKychukSI3tqFN7VeWsOOZkwy+uz8vkxoH14VuNLD5U4wfOhv2IYgak29S7lUpfXofiqMUbRQ6Da25s6WF9e/VtFx+92CVQw2fFY06IgHbHZrtTfrj5BA+q2DYKhlvDeeJLDJl2f5pGshPnsw38dOiQTaA9eEvjCWW2HvOW9RvhvzHUkzqkwSPXi5dL344nUtS1tTkasTKD9UXtZc6t875XfZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy6I4UHbqbGF8IrOstbM3WTRsIITIFOgf4ypGK2YleA=;
 b=hHBitmWz6LvEc99ZjKzuygYN3wIDcn4DJko8rlkay48pt6WP9VgSd6LkZG8b4m6TrB7DZ1RaEb1n75ZCRWkojrcsNU8M2Y75uwARiDnxLKMDUQ3cpDVPjeIwdkfCJwMIzMGYL4OHSX2YUWG+rZil5iDH2+VG/qgpwd3QImGoa8n78aQR4QxFABhjvnG4hk0iHnZ5KPXOXyXsHRcFxEsa1JeHFKmcsXph5pXNJyMLFXp0zf4Pjv7Q03oUmnVLVEtL+gnaMjYR8hUhzLgUA7FqqaoDiDG+I4ReBVJOFDS7SZ2gJkRGB+2GbrwXqohnamw+JvQQIyritWhWMV48eTYRdA==
Received: from DM4PR18MB5026.namprd18.prod.outlook.com (2603:10b6:8:51::10) by
 PH0PR18MB3800.namprd18.prod.outlook.com (2603:10b6:510:29::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Tue, 16 Aug 2022 05:34:47 +0000
Received: from DM4PR18MB5026.namprd18.prod.outlook.com
 ([fe80::fd8d:f920:c9a5:83d5]) by DM4PR18MB5026.namprd18.prod.outlook.com
 ([fe80::fd8d:f920:c9a5:83d5%3]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 05:34:47 +0000
From:   Hongtao Yu <Hongtao.Yu@outlook.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: Cannot print 'uregs' field with perf script -F uregs
Message-ID: <DM4PR18MB5026C7008C77EF24557409138A6B9@DM4PR18MB5026.namprd18.prod.outlook.com>
Date:   Mon, 15 Aug 2022 22:34:44 -0700
Cc:     linux-perf-users@vger.kernel.org
To:     olsajiri@gmail.com
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-TMN:  [KfZmp/h1Z06FriQDqwzmXzwa53KjlSMpMxAhyW8BPu7yhlrxfUbXEw==]
X-ClientProxiedBy: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To DM4PR18MB5026.namprd18.prod.outlook.com
 (2603:10b6:8:51::10)
X-Microsoft-Original-Message-ID: <A5EEA504-8484-4B59-95B3-3A460633E296@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98bac041-6c1d-4390-83c3-08da7f4907eb
X-MS-TrafficTypeDiagnostic: PH0PR18MB3800:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FAUkNbYuXIMGKftEaXAUF8p49cGRx0UMahFJuFKwGFPNGMaR6OaZUNKTVmcX9JMxxJLSG6w2I0JcIXy8113kI6I8ZBpbeGIj8td4hR8oILleR+lXaLKxPNqYoiO12QAmV2IcAsHeUT1Kr8whLorjsWIcBRRSxf5fTsdTsil/s+Xr3lyjvbHOQtWLNGMGSMjODy5Sh8V2bKzCxCCwowrnfO8rcjHFe0nQPdNztnnF3iYiV/Hvz15iRFk3Rywl+Kp2P7ZdlfAs6w4sgsQ6Yoh38cOY6Cand3HIskiyqrR7T9V2j60W1zL1ZeqYb+oz6fmabSH2PBJgZkdI/v/pBj1lAjZIUUWxSU1Zhor8JvSFDebZK3RlrHTunsKiGHY2QHJsEQEkXp1sbvwNLQXlJchuNAnoobDaMO110WK7xIQTfEzVCUrxX5yDf7+fFabiAkowP8+btmwc4UcOaCCs7owIMFf9iw8MEo2XH0qVuZbXRZ93Gn+maQ6AXYQ4Wm0ovx9RCfuf0X4TfSpHgHNI/hWCKeK3m63/9qrr41P7zCIANfx5KEADAVnJt7pxg5soU6d7981qaQ/U2Mh/2KSEc4dqBU/WAPUvrthwtulzNyJmq0Da+vXqd3KvLvjTWoWfHjlO5+pND70KOHpGazMdXNmthyXVwny3xK3tBZzDIP3hcWQB4sLooDqbiwGBdeJFJPx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HD3oR2dPbhRS1iRGD1cvJhCwmng/X+fxi5wcok1n/fQiq1lwH8V2q5qtT0gb?=
 =?us-ascii?Q?R4fcI43vN7jwD+EjXaBCKlKhk27mAVMwQ8JVUWbWRDjeG9NFPoHdqoMgT5sP?=
 =?us-ascii?Q?p0tV/bqd448SoDCZkFMrP3AgD5i9s/MQB7RPH7Pf+gGSXhgZcMbssTrkqdQB?=
 =?us-ascii?Q?Zl1OLtOyp7huwk2jpv0i5gco6opoW448qZa2KfzkP1J/Rf4v+TTKDVfoavYf?=
 =?us-ascii?Q?50FG5g5QNDktvExd1ru4ymOwL6tVq3oHCrDTPZfL3pA/PSVDW3lEHKha5nln?=
 =?us-ascii?Q?8QFw6eTx7SYcXKlGDdaAqIAZ9s+aED2BhcIbbMKMzkoGhjUiZOoJRRKDFZqf?=
 =?us-ascii?Q?EbPpOoRYG30iFM4sKevguJJdJx25lH8ms+N9XIjcMuVtGe5CIUmDPmdUMPrB?=
 =?us-ascii?Q?hu6h/v98OkOnuhYyJbVfDdgHosaWknQavD0ybsSN4p36k+S7u49L0zSGFd9K?=
 =?us-ascii?Q?PgPKGmUSb7p+Bm0V6osCY7NLRDFd2qhDexKwgxvXYS0WGPeJqG//JH6qUGBI?=
 =?us-ascii?Q?pzd2X/gZ5kfL0VQAGomG2Z6vXCSZ6vgx+7S0Zdju5gA00IDUOUm7uyFsRrNp?=
 =?us-ascii?Q?vex4wNndfwUruKWpBvJRberHMEAPixXNUALa9KXyUp0S7PXvOvILWl7YVRtl?=
 =?us-ascii?Q?NNbPICZWc1ExC686BjLtXn9CnKBx8GSa3iWQLWYguNjgQkYpFiO95JuJ/WCQ?=
 =?us-ascii?Q?bwmoyUua0nWPLuc21+L+3rYmpigs0k6BzxW/ExPZAKXJb3aOVlAekusbLBD7?=
 =?us-ascii?Q?4IcQOnX24qP3F0jS2D23XKrNXZQW9MhOpDmq/qGlxaSnbq0FErCZ3vaFFeDx?=
 =?us-ascii?Q?LTDwscJFxma6JopSzaa98oeM+FiqVPmJgdyhMbrS7+twn7IAiFTF369nk/Rt?=
 =?us-ascii?Q?gRMJJMwk0DtGgVx3nacFwcI+STWCA25AHriTotd8isBJupvzGYDgExp6j8T5?=
 =?us-ascii?Q?Dc03ME794QB2EdmfZanZeGL8u1WSB8Ut8U8aD8ghSXF1YWzBjYdZ1aDzyHf8?=
 =?us-ascii?Q?O9vnZbZEob5tfe64TgDR9til0bqmEDhlN1XPi9IsZ07XgHKlavyCmT32IF90?=
 =?us-ascii?Q?iyWXGcbBHJmSlFp0GTiDXiY2h0vTVJDbxnTBCI5SW/IoV4CDZYh2YdtAlWMK?=
 =?us-ascii?Q?K9QBNvB8xTSSoctrkoCWhSNku4FsWehNwbG9GuSNohU8aPSjq5xVw4EGv9AX?=
 =?us-ascii?Q?UvKLUEP90WpIDF9qdiLQRQrq/W/IIpbHgMjezEi+txflO8xFX2QCuR3uvKeU?=
 =?us-ascii?Q?P8GJHQk/GWh9QTJENMAoiA10Em34esO0zI3XLTB1ATq4vZ3xYzB/ZCw7NFex?=
 =?us-ascii?Q?eJgrJvHijzzmUsaZ7nitAggR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bac041-6c1d-4390-83c3-08da7f4907eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB5026.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 05:34:47.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3800
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

You fix works, thanks! Are you going to commit it?
