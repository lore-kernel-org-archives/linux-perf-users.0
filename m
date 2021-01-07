Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA71C433DB
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Jan 2021 18:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA301223E8
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Jan 2021 18:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbhAGSCA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Jan 2021 13:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbhAGSB7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Jan 2021 13:01:59 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E09C0612F9;
        Thu,  7 Jan 2021 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SloNa+LGZ5nIBXQeqtHN8RfszzzW/MPD+Vi9iB+gttE=;
 b=Uq9VP6FYJMW3lHmWf/8fa1B95EdiezRzwkYfsobGvcc7Dq3nTg/0tm8l+7MpSUVK+rXp+/Fpw1jSq8NbYQJUTNgyiX9wigdlj/5cGV/FsM4XBovZW5NfENo/ylgvfqph+AFZ9VNRZb5pT0aSXx/VzPkt6XtX8w3PHq579xlXxU8=
Received: from DB6P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:6:28::33) by
 AM0PR08MB3012.eurprd08.prod.outlook.com (2603:10a6:208:5b::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Thu, 7 Jan 2021 18:00:58 +0000
Received: from DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:28:cafe::64) by DB6P191CA0023.outlook.office365.com
 (2603:10a6:6:28::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Thu, 7 Jan 2021 18:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT041.mail.protection.outlook.com (10.152.21.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 18:00:57 +0000
Received: ("Tessian outbound 6ec21dac9dd3:v71"); Thu, 07 Jan 2021 18:00:57 +0000
X-CR-MTA-TID: 64aa7808
Received: from eeb2c5a6daab.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 06277687-EAB5-4418-BC69-7EF84FC02C30.1;
        Thu, 07 Jan 2021 18:00:52 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eeb2c5a6daab.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 07 Jan 2021 18:00:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVaFsP0id3Bxz8Y6ce+goEtlWNB5V/ZyV53Y2RiCE7AJzoM8UQuZYuMN/uR6uPy1w539JgZr0mIp5WUup8Sb2LFt40t1pnokPzxkSsXN4SYCU2O1i8n/7iaaoeOuWI0mfFvTeGGHIYdkmmpiq6UqpW3SqnQf4ILMQqp0BE3tBC/xTZgA7bXXPpR0jy0ACwMlTauCHhsa3bmsClyUkLFaL986rFAuW/1r6ZH8MBP3CVlDdLbaiwdZmSx3VQmfiT6WrzNDTaV4Qqb63axvkQeNnCfiW2Ex7fIuDoIbWBJbfLKavRSY2+BMoiN8ZdJJkDoc9eeB1qWlYJepChgLU0WRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SloNa+LGZ5nIBXQeqtHN8RfszzzW/MPD+Vi9iB+gttE=;
 b=HTboeRmoYIJ58Ujny9G4DmtFtzFdN+6kiXO2ebg49fSvvDSWR6lwD7wHbCQeFqmabfQHW1PZNNcHJd3a7iqaE9CIrMQny+8zn4kbaFVrKDAT378QdcorIxhkW1U0Eug/KkkyCIBqKVuAWzJ6TtlvOOd/sNxc9hfnmSUz5aP3vYyULJnpnS6Zo+elmtT0759Na75xcMbVd85rfyIvw46msi1bdGCDgNeOujWRtlkG1bUnCmBE7DaNiTXGv3iLcPpwD2pzzZ9+tzdydNG6rq5V2FGdBAddTJYWPp0+RdT0F99TniqGfuyX7iPbULNeR41kntt+H1i/ZVUJ6H7X7rvJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SloNa+LGZ5nIBXQeqtHN8RfszzzW/MPD+Vi9iB+gttE=;
 b=Uq9VP6FYJMW3lHmWf/8fa1B95EdiezRzwkYfsobGvcc7Dq3nTg/0tm8l+7MpSUVK+rXp+/Fpw1jSq8NbYQJUTNgyiX9wigdlj/5cGV/FsM4XBovZW5NfENo/ylgvfqph+AFZ9VNRZb5pT0aSXx/VzPkt6XtX8w3PHq579xlXxU8=
Received: from AM6PR08MB3351.eurprd08.prod.outlook.com (2603:10a6:209:48::20)
 by AS8PR08MB6246.eurprd08.prod.outlook.com (2603:10a6:20b:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 18:00:50 +0000
Received: from AM6PR08MB3351.eurprd08.prod.outlook.com
 ([fe80::d42c:f1a8:313d:2d91]) by AM6PR08MB3351.eurprd08.prod.outlook.com
 ([fe80::d42c:f1a8:313d:2d91%7]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 18:00:50 +0000
From:   Al Grant <Al.Grant@arm.com>
To:     Mark Rutland <Mark.Rutland@arm.com>,
        James Clark <James.Clark@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
Subject: RE: [PATCH v2] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
Thread-Topic: [PATCH v2] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
Thread-Index: AQHW0fWNB286+OrdcUad+a9RoXdTAaoaiDkAgAIHa8A=
Date:   Thu, 7 Jan 2021 18:00:50 +0000
Message-ID: <AM6PR08MB33514C1A7E776FA8F9FA986D86AF0@AM6PR08MB3351.eurprd08.prod.outlook.com>
References: <20201214084502.19954-1-james.clark@arm.com>
 <20210106102327.GA26994@C02TD0UTHF1T.local>
In-Reply-To: <20210106102327.GA26994@C02TD0UTHF1T.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 2693BCE47C8EA34CBE09B5A6981BCA99.0
x-checkrecipientchecked: true
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [217.140.99.251]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 507d936d-f4a4-4f87-6b9b-08d8b3362f74
x-ms-traffictypediagnostic: AS8PR08MB6246:|AM0PR08MB3012:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB301213E3BD7697B23B75425F86AF0@AM0PR08MB3012.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: m9d+/bj3DfWBkTiP88xFV411F40b0hOYzwFEZTj31LNGSvpPlzh8kg8QwTpSKXT9bcFeSM9g5/fbchGLNR7fgUdCp5VXlbuCNGoxVfnlylgTp2/0j6ShzMEJgm7olpmT+ImFfdFgce/uo/VAuOXSp2s2Q1/4b6aoclFLOSjhnLjixVe98c69QrZMNkOFApC/zC5EWaDP1IUdYepqkdj5JbEhN6NpmDi837efhQJssO0Xzm7VCPmFDoJl4NP9TC+gZTx5f/38QKWZSnWa57UHOqJOGGe4hhc2GEYB8waZqWkecnu/CHgV7fQNAkygCiiTmaXSKNT8w4RygOQDFaRMfWM8EQMdqhwtSbpublE69UTNUpEs9zLTuH4Pnl2BaifEGpL0AeIP8arVJXFyt2H22A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3351.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39850400004)(396003)(366004)(71200400001)(186003)(9686003)(76116006)(55016002)(54906003)(66946007)(2906002)(26005)(53546011)(83380400001)(6506007)(478600001)(86362001)(6636002)(5660300002)(8676002)(52536014)(110136005)(316002)(64756008)(66476007)(66556008)(33656002)(8936002)(4326008)(7696005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CO5ms8oV4sI3QDjEN35ANpkOAOpdbW0m/qQeeFb+Z3QL9dk8++ncKIFlPQcN?=
 =?us-ascii?Q?mMHRF/2oXGg3Q9Fbl5xBf2tQ5QW9jzvfOQ5XhJpD1ETxvrZQY9h+05RgqjQF?=
 =?us-ascii?Q?Ag8JJkaPKBglJuPgrPiW7cFFSN/1tyAOUY2xfuqnFLAvGgz1i2Yrr3Za+nwg?=
 =?us-ascii?Q?gFmNOoyNpODvvRe9iYOqGD94qEOfb+i8rPlZH8iCgR9Ogl+cgbTroe64N4+D?=
 =?us-ascii?Q?1h3P2s/3B5c6UdRiYGcfHbIJDgmAxVolIO8zqwJTK6KycMzhRxzBKBmKjc4X?=
 =?us-ascii?Q?Ag5ROym8UrGLNGEsKKAaBz2xV0Cww8SeywEAPgbwPrC2+cRS+WYIDHXVoeqz?=
 =?us-ascii?Q?s4IbUueqUnyUp7kwoGh0AfiEFN5XmgrqYXbk33QWIr5Z4vYFEzcdE6YnX4Ke?=
 =?us-ascii?Q?yhmtkNjgdkTms0O8AWkmmwVpHdvtCNqa9A+kzkZyWvKv1wQ4U9qgzfyJOuzD?=
 =?us-ascii?Q?/3o/0TuWxiO5P3okvq/UjyK5ISfT4A+AfqAtVpG+NLImc209AQhnwEE5NxN0?=
 =?us-ascii?Q?RkonX8eC5fhdJHjZizdB9QjxRHox/qZRKQ0KHT2d9IMpb0tTkGe5Evxihqxj?=
 =?us-ascii?Q?BYfbcLyv7iH8ndW+lPrJ7eKWmP2TxZSzoji2Lp3pSjeRtJ+cW/rszbdmJ1Oy?=
 =?us-ascii?Q?JgtgJLsYzlYFxR+n31VUtEeSV3HUDdQIZKArN0YNKax0CNkzdlM0z7NO+qyM?=
 =?us-ascii?Q?+t3Bqx3MGRk7wxsr/x5TLiOFDz8D+Y24cUIWebBbadDQDdzr10Hq8xECudQc?=
 =?us-ascii?Q?flrkCnAKt9Gf/EDAm2OvonuW1etf1o7CAcpz/2mViydVv78jyZ6gR2YxNUZd?=
 =?us-ascii?Q?8QB8VMvmI7u1ETHqoMCpLcuImTm7AVAMXq4prNL7ffm2W9zKq7BbYzMybXYS?=
 =?us-ascii?Q?azVW7ApfEV13VIIvR5GbjojVnfo5guGXGCtSurqX176KA5qPkNUTKDb1omXJ?=
 =?us-ascii?Q?pjvQH2srnY58DzZMidSuojtvUB7XoZ7Ou/UXNRvuDd0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6246
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d5a1fa77-d278-4762-b1c2-08d8b3362b09
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4GHt/fLdlJae3Bxyn/RWyazKqoklFILvPg3/1AK9Om91lIHf73WrxXd130ECWfaHiaouzhwv7YyTG8qwYpmVmx6wQWNtaEPxgEiFp3GgXKwQiFG7p05hecy0LusnTtI/BGlzwcZZZ4CfWpwxAeKSjO5SzMsgp5ngtmRyp5y1bgJQOE5i7Qcja85ZTu2KPDXVfWR1TkiUzci9sW2SWjlTaBFb7AQLD0N7RPtQPPvUTrC8ZiQgEQLiNURIWLt99SE9XXZFTbv9B++0TE7jKfmTnANNSmHZ/yonKi19rFrIMuqHd9NJHVkwSv5R6jXWJZPYssQAGPGBTgbhcw0yDzkL3enpwYM63AMuLBm7qwLaxZd46PpAfEXUjieMSDzsjLF+p+Z9waTiyU0fITALum2cFwNHTXvCLe/9QlZWt1XAEa6oBoIe1oI5L+TxSwcjrntzTEUfRcKjcDBJ98mCzls6XK+DtbWEbbSbXC3n5hh9qwZuD6p3sxOSmI0VGo+rK4S
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(376002)(346002)(46966006)(55016002)(47076005)(7696005)(5660300002)(356005)(450100002)(54906003)(86362001)(2906002)(316002)(4326008)(53546011)(9686003)(336012)(83380400001)(186003)(34020700004)(70206006)(8676002)(70586007)(82740400003)(82310400003)(6636002)(26005)(52536014)(33656002)(81166007)(478600001)(6506007)(110136005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 18:00:57.8599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 507d936d-f4a4-4f87-6b9b-08d8b3362f74
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3012
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> From: Mark Rutland <mark.rutland@arm.com>
> Sent: 06 January 2021 10:24
> To: James Clark <James.Clark@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; l=
inux-
> perf-users@vger.kernel.org; will@kernel.org; leo.yan@linaro.org; Al Grant
> <Al.Grant@arm.com>; John Garry <john.garry@huawei.com>; Suzuki Poulose
> <Suzuki.Poulose@arm.com>; Mathieu Poirier <mathieu.poirier@linaro.org>;
> Catalin Marinas <Catalin.Marinas@arm.com>
> Subject: Re: [PATCH v2] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
>=20
> On Mon, Dec 14, 2020 at 10:45:02AM +0200, James Clark wrote:
> > Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
> > This flag is required to get PID data in the SPE trace. Without it the
> > perf tool will report 0 for PID which isn't very useful, especially
> > when doing system wide profiling or profiling applications that fork.
> >
> > There is a small performance overhead when enabling PID_IN_CONTEXTIDR,
> > but SPE itself is optional and not enabled by default so the impact is
> > minimised.
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Al Grant <al.grant@arm.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  arch/arm64/Kconfig.debug | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug index
> > 265c4461031f..b030bb21a0bb 100644
> > --- a/arch/arm64/Kconfig.debug
> > +++ b/arch/arm64/Kconfig.debug
> > @@ -2,6 +2,7 @@
> >
> >  config PID_IN_CONTEXTIDR
> >  	bool "Write the current PID to the CONTEXTIDR register"
> > +	default y if ARM_SPE_PMU
> >  	help
> >  	  Enabling this option causes the kernel to write the current PID to
> >  	  the CONTEXTIDR register, at the expense of some additional
>=20
> Given that PID_IN_CONTEXTIDR doesn't take PID namespacing into account,
> IIUC it's kinda broken today (and arguably removing that support would be
> better).
>=20
> Can we not track the (namespaced) PID in thte main ringbuffer regardless =
of
> PID_IN_CONTEXTIDR, and leave PID_IN_CONTEXTIDR as an external debug aid
> only?

The (namespaced) PID is already tracked in other perf records; the point
of putting PID in CONTEXTIDR is that SPE and ETM will capture it into the
AUX buffer, and this can be used to correlate AUX buffer events with
other perf events when the AUX buffer doesn't have hardware timestamps
that are sufficiently precise and can be converted to kernel time.=20

Right now, a kernel may be enabling PID_IN_CONTEXTIDR for other reasons,
and in a SPE or ETM perf session run from within a container, the AUX buffe=
r
will be capturing root-namespace PIDs. This is wrong, as a container, and
an events created in a container's non-root PID namespace, should not
have visibility of root-namespace PIDs. The solution is for the SPE and ETM
PMU drivers to disable CONTEXTIDR capture if the event's PID namespace
is non-root. For SPE and ETM4, this is straightforward - both trace formats
are self-describing and perf's decoder can cope with CONTEXTIDR being
absent even if it was requested. For ETM3 and PTM (on older 32-bit cores)
this might not be the case. So it may be better to have perf_event_open=20
fail and have userspace retry with contextid sampling disabled.

This does mean perf sessions from within a container will lack PIDs in AUX=
=20
buffers (so correlation relying on that will fail), but that's better than =
having
these sessions expose root-namespace PIDs as they do now. perf sessions
from the root namespace just work.

(The alternative, of adjusting CONTEXTIDR to trace non-root-namespace PIDs,
doesn't work in general - the namespace belongs to the event tracing the
process, not the process being traced. Worst case, you might have a process
subject to an SPE event in one namespace and an ETM event in another -
there is no value of CONTEXTIDR that works for both.)

Al

=20
> Making this default y is ARM_SPE_PMU implies it'll be on in all distro ke=
rnels, and
> I think we need to think harder before doing that.

