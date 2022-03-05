Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3132C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Mar 2022 00:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiCEAwb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiCEAwa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Mar 2022 19:52:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871CE517F0
        for <linux-perf-users@vger.kernel.org>; Fri,  4 Mar 2022 16:51:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1irhh0Na4faWNDPLTmUtUiuYAS8RwJurMd5hdInXflqHbSX5j0AryjnYjwKDKTxKjhKG+VT1nteROg9ageH4Fr/4pftWmMKzS9WwGDpUpbFdTA56jRhMzf8UTvG9R+3MCIFFVaRZ7/YwH4C0iTmK8wCPxuvrE8bYWC3/7LtYbtLAw5UXBchhGXmbaQ4He8Bgfl8gMjDWqKW95ydH/TKBoWQJiPjYVT3zP7+o4sDmApLkXqw1ctXvxNEJEYgV+8gMmOIXGX33gDKC//X6eCaapNYpn5KoowoAuYY8MD19d0mXpIM8IPUUmCnu8boo0nLnJRyXPH989Mm/ubQaWT+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyTNhO6KZBTcYh+ilDYKjTkUitImk/dnmOmhzyrCKB4=;
 b=XKshFE/Mne9VoIwCbcsjke2/B7U8VgJ18nyIEaJLNDKPRECNEOYbKJfMNeHW5CTO0GOD/AU9GKwp3b6rk1a4/R8CWdVaRMU9kTeunVJ/p10GMWI1CJBrEoJuzictB18unwt0Pat37H86oZsXd4m2qrVPTBIjWke7VJr0N6mDTEkMcAjxqivEWR15g2LYWzApsuwQZHhsrJawQhHrmT8bGgwr2JFp+9G5ckjp8Gh7zwaLusyFPBeFrhhnGXLRfg+xAS8a2jpIMxa0Oi7fg28GoEXINYI1R+Dsx3m0MGy3CM9ZbRM2ls37Z1nlsngr5SWCbsjS3uMZktuiPBu6si5tzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyTNhO6KZBTcYh+ilDYKjTkUitImk/dnmOmhzyrCKB4=;
 b=VNcWR9iq0vaYxCsEHhFw8dTDdLyvIrAnudNL4j80nPKjINGuJiHyiTQZ6TyKmnIPmTzi7XgrGNKccGd/UHhaFTDgYacAzR5wk4rm9QC07qgqc28CULklI0f4YhFKusmUWUs+xlVvmaaYe30d4OfO1a/YrqEuHnfxsDdJMHouDYQ=
Received: from DM5PR15MB1739.namprd15.prod.outlook.com (2603:10b6:4:5b::22) by
 MN2PR15MB3037.namprd15.prod.outlook.com (2603:10b6:208:f9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Sat, 5 Mar 2022 00:51:39 +0000
Received: from DM5PR15MB1739.namprd15.prod.outlook.com
 ([fe80::ddea:a32d:ffab:70f8]) by DM5PR15MB1739.namprd15.prod.outlook.com
 ([fe80::ddea:a32d:ffab:70f8%10]) with mapi id 15.20.5017.029; Sat, 5 Mar 2022
 00:51:39 +0000
From:   Douglas Graham <douglas.graham@ericsson.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: What exactly does -F <freq> do?
Thread-Topic: What exactly does -F <freq> do?
Thread-Index: AdgwKW7BTGI98hwwTTKcL/QVTcLgmA==
Date:   Sat, 5 Mar 2022 00:51:39 +0000
Message-ID: <DM5PR15MB17390661547DEAA8C397A540F0069@DM5PR15MB1739.namprd15.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b7c0c72-51e1-48f6-7cb2-08d9fe424f03
x-ms-traffictypediagnostic: MN2PR15MB3037:EE_
x-microsoft-antispam-prvs: <MN2PR15MB30372E2D25E05F55FF15B024F0069@MN2PR15MB3037.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qYs98GYqDgxrTTb79LFeFmHaJAiwwB1zoyoUGe595C6uF0lMb1a3dEuAWqkSpuMDhWT5MvbPZ1dWhoNQJQxmYaGOsJysR4GHPjZhwst6/KMdPGWP0+e2jG6u15k6YDjF1Ds3L4XC2xufjx92ibbeITVGhy9XWD9mgZ9XrO/yU1hX4QJnkPRM42VskpUIq7qjKTfNar/WXG8pqw08OAtl0iVk1HlJx8JOi0MTl4fetml4x7NuAYc3x8VFroQukYZUIqw4078ukHxuCfON53juPtOaldK+MVzrmmdnkHoDIcJOwCFGpoMdJaVdjqeqAw5KOKod96VRYGbu8xsYd9QWxukRETXbMFOlmQo+y7DTpN+5fWzfdNOhutYDsaJ3r2ykYTCUDznzI08xUf6HhnHWO4jIH3hz226Quv7wNrcTJrn5md2Vcbkg8A+Vl5xHxIYAj9Eb5EZqXLU63RUccW6a4CODIyhXQ9FZ4ylnQSdwtr9q4fXaHNbBwhYQIOQHmmXCVYweyL3QnwC/nruTvJrDcY9ZFxLWO0j+ySc5jSMbEyVnPUDibAdsQ3/wnVkAX0jV4i11VetG6W2/MCgN5hshm0cY1k0yGkYfIB62F6pr8vKWttXhzdDRw0iqr8Eowpx3df7v4Q6iVciAT3Lul/Z8c8TqJuyx08sf67HHktY3nLppx2s7154Sp2XVMSA207JdY+U2wKNCm4JlLdYmrID5JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR15MB1739.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(2906002)(186003)(26005)(122000001)(83380400001)(6506007)(52536014)(7696005)(55016003)(9686003)(44832011)(66556008)(66446008)(66476007)(316002)(82960400001)(71200400001)(64756008)(86362001)(508600001)(33656002)(38100700002)(76116006)(8676002)(38070700005)(66946007)(8936002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KKeQ0g/+0nmWV11b1Chub3ZEOgu5wVaaqOZW2zCz7ofOkyAfh3PVofFWLbRO?=
 =?us-ascii?Q?SII7lKnyATyL6+ziZcNs28Em0h+K7AVlrJR2ca0FwvYCzmb9ZWgqx+y+YCch?=
 =?us-ascii?Q?q020e2Yq0dJYJG30hGPJOV53wROQNimLd0iMS/khoDnAQ5K/Za1gT1Pj6Z4R?=
 =?us-ascii?Q?jSTFqjWxMtdCwU3YOJnnNxjFdLsklCwVLBInrllIPfBzuW3TBWD+dLnNvieq?=
 =?us-ascii?Q?XFV2WrTP26gdlrBaqCtmE8vN6xsCaNxOI+/Vj3kMEdQaD2kFDKNIaHYhAhay?=
 =?us-ascii?Q?0ymNhovvl66B5MM/uC9eFAdaNmks+Ma0QPwcqQkDjH2Vr7eeAZzs0pvl3d0W?=
 =?us-ascii?Q?6LEd9DbJyhm1I3LixYwFRajG96R9LOzhlGDrg6hPW7g0BdYiJDLWlAhhfuX2?=
 =?us-ascii?Q?Et9THxwl8wIMmtsVS3M57FgFy1G7a44KiXyxuz54phu8XvTG3UrH+I3xXx4w?=
 =?us-ascii?Q?yHyMKiViSB/XUYu16IxGTGQw0oyiRLeQg1HCNWvpl5OvidX8rw+UHvvUNjWo?=
 =?us-ascii?Q?7fnZpwSRW5XUZGw5LJP+ju4mQBJnSjVoeq2HE2iestquSyN5vS26tlTmqR8L?=
 =?us-ascii?Q?EwjL+fTeZ4ymUZm4BqmQyOHVTcuabIj7fpLDZ0XALqY0o+8c1QfIr/Wo3kt/?=
 =?us-ascii?Q?oqxtQBl+H61r5R3GrQv5Cx+nXfsoSM6WbsN1IhyZ2S3qLOu/y0pxJ83X0sGr?=
 =?us-ascii?Q?NqeWU8Eks1MZufWIhC2pGsM+8u+M3725hRFzjvRZF8xicuV/So14PFQWaz+y?=
 =?us-ascii?Q?IUSLfbG3QEmGyiDWQa1Nt8veQgorZTAIysZmQC1IWfKu5OIpYt8JB4klZNm0?=
 =?us-ascii?Q?M1CYQ3EsLgNfTgf4Vdp9NwDBF238azGeNrUAjNWUMaDeMJrS6AniqIQksraU?=
 =?us-ascii?Q?Ls8eIeQQI9GAv4ffI+Ywpm07pqu24FVXjsglpmCaSuXTBlHvZ4Ot4lr+EWao?=
 =?us-ascii?Q?7rqE/wN0bUGV+eSqGzwH7UcNZd2zrRG+dbbC3lg9w+DPEKYUSauyOYu78zFe?=
 =?us-ascii?Q?eNboJ9aELRlzjCxJB3mQnb45poLZITBqc6HDz/aoE1fJpMibZzBd1B9uRfEK?=
 =?us-ascii?Q?qboGrO6qvqVCa3rNY56QjUzY4Y0GdvWJWGYKyqZlm82ebm6vp2X2rkwU2/nE?=
 =?us-ascii?Q?sv+VSbm3LGGA1ONc5UGMh4uxn5KdkU99Z3EmjgR4JzH6BS8vYUJKZvNUMcGZ?=
 =?us-ascii?Q?LQMEBRiXKTY0+YRve+9klTF6CINwVRdKbsdG9Q81yFEW4m3OTI3I5XfssGC2?=
 =?us-ascii?Q?OkwHPVbcKEzDYqytzR5bzBA4jJR/Zo0jq8WIz4/AXesjgMh+7Rytc+ctlwmD?=
 =?us-ascii?Q?cBO8iEDptFYnnGv8CIln6xXfCZudY5qV6jaWlb6jtidLvNkUj/O7g+Ky7URB?=
 =?us-ascii?Q?BmKgjBTlAY4lHfOvnh/4I7eFiRRDAM/36qfCnfj3NxEQ3v+EsNAVRaC9N0u2?=
 =?us-ascii?Q?fONCCMhsBWceoTayN2C7GM9Pc1qAhDHt9X0nseS5Sola9ceD+V0yr7eYBU11?=
 =?us-ascii?Q?8fgqyjbTv5uf4STyGUOzeuzB/uAQ6Qql8Ok8f58y/N2iv2eteTlqESrZQbO6?=
 =?us-ascii?Q?1MC4DEOuwu9lLtxOndC/03BR36GwLmd+Qi4JHAy9YCB3C75Ka57mxMFvu+sq?=
 =?us-ascii?Q?DH4ftAUjdQ5XMmceXCosALBBa7f4MBIzX+EaZm+vezY6HHLA5oPYtsrhXge0?=
 =?us-ascii?Q?5Z7KJg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR15MB1739.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7c0c72-51e1-48f6-7cb2-08d9fe424f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2022 00:51:39.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uHGrhaJMtFRvzfjMfY0f25Qzn4Fs67zVLlqMSpou1JYHTKwj9ms9o3/qx0ob7AlCa4/b2IYGRk4xc1SErHVdAMQsQyZMqZQheXNuakL7TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3037
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

The perf-record man page says this about the -F option:

  -F, --freq=3D
           Profile at this frequency.

And this about the -c option:

       -c, --count=3D
           Event period to sample.

A "perf stat sleep 1" on the system I'm interested in says:

           1630370      cycles                    #    1.315 GHz

As I understand it, the cycles event is used by default, so a 100 Hz sample=
 frequency should give the same results as a 13150000 cycles sample period.

And yet the results with "-F 100" are significantly different than those wi=
th "-c 13150000".  Perf script output shows the same number of cycles on al=
l samples collected with -c, eg:

    tmoSchedulerTx  2281 [003] 32746.853052:   13150000   cycles:        55=
834b1e5c [unknown] (/opt/foo)
   richw_commond  1950 [003] 32746.926042:   13150000   cycles:  ffffffc010=
013504 do_el0_svc+0x44 ([kernel.kallsyms])
         swapper                  0 [000] 32746.946399:   13150000   cycles=
:  ffffffc0107d1828 arch_cpu_idle+0x14 ([kernel.kallsyms])
   richw_commond  1889 [003] 32747.002987:   13150000   cycles:  ffffffc010=
7dba24 _raw_spin_unlock_irqrestore+0x14 ([kernel.kallsyms])

whereas the number of cycles bounces around in the perf -F output, eg:

  tmoSchedulerTx   2281 [001] 32696.168404:    5904091    cycles:        55=
834b1988 [unknown] (/opt/foo)
         startUp            2180 [001] 32696.209523:    6148607    cycles: =
       7fb235de68 operator delete@plt+0x8 (/usr/lib/foo.so.0.0.0)
         swapper                 0 [001] 32696.348061:    6416807    cycles=
:  ffffffc0107dbaa8 _raw_spin_unlock_irq+0x18 ([kernel.kallsyms])
   richw_commond  1889 [002] 32696.501004:   21730400   cycles:  ffffffc010=
7dbaa8 _raw_spin_unlock_irq+0x18 ([kernel.kallsyms])

I can understand why perf would have to keep adjusting the number of events=
 between samples if it is targeting an constant average sample frequency bu=
t using an event that occurs at a variable rate (eg: cache misses), but cyc=
les *does* occur at a fixed rate. So why does the number of cycles between =
samples keep changing (often radically) like this?  What exactly is perf ai=
ming for?

Other statistical profilers (eg: gprof) sample at a fixed frequency, where =
you can assume that if the sampling frequency is 100Hz, then each sample re=
presents roughly 10ms.  A function that was sampled 100 times during a test=
 run ran for roughly 1 second during that run.  I think the same can be sai=
d if perf record is used with the -c option to ensure a constant sampling p=
eriod.  But I have no idea how to interpret the results of a "perf record -=
F 100".  It almost looks like it's trying to capture 100 non-idle samples e=
very second, but if that's what it's doing, I think the result can be wildl=
y inaccurate.  If it's constantly adjust the sample rate to try to ensure a=
 fixed number of non-idle samples per second, then it will sample more ofte=
n when the system is lightly loaded, and that will make whatever happened d=
uring that time look more CPU intensive than it really was, when analyzed t=
ogether with the samples gathered when the system was busy.

Thanks,
Doug

