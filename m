Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54A3C28CF5
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Jan 2022 13:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbiAZNZ1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:25:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62056 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239443AbiAZNZY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Jan 2022 08:25:24 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q9RWU8019615;
        Wed, 26 Jan 2022 13:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=7zsXWFV7KltUdbZ6D7T/b/EwPFDqTXv5yCEvdhUP8Fc=;
 b=gZEa3u+63Tgu1FR3+x+LzA6KlTHD7WERKSld3QaH+K+1tWYEU25GcdbjFeUh1b73M9kj
 oBrBRKUfU0CGA8Ey6+PDuAg3bKxhA9ZUU2JxVmNaJlMYgzTsS5Q1dPVj1nInR/Keu3zt
 zBACR/WY1Jr9PUJ+qNQkkZIfiW4YGygYM9ClEy65xxNQcewNjYVcRJ2be8HxKG1v/tAw
 uZ4/i04G87upaK+mMMrtBaFZA0xSVV7qhKwIEzuDEfFPWoOgYdr1ysgj+zPIBLLtfpgy
 N9fJRMHMTacPC+Z39zFFIv/RQsKJJKJqPe7LADV4f6Lrv0AqhD/tl5F6qfmMiLMImnms bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7ax6ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 13:25:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QDGo4p169440;
        Wed, 26 Jan 2022 13:25:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3dtax8ck8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 13:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibr5wQKSEeq7yrJkSZNv8enxxwjiNr/Y1JMU6Qw6oj5hmpRibPoOxB9NjOPWZ+yDBrjQFMb8G/ngzOx8XVD0+0bJGT3gpjpyS4HumqbZOh8KGfMOO107AY2pa4doVjflLHzr3GTM2NREs0u/GcWlTJQRXaNzHWRtotrtbl3HQJ3UNXEVrce5XUbaEj50cs+k1KR29Bu7ZU43tp/vya/2ETYrvndrRrRuOTEQE3EiwmOwxFGl4aDCb5abCaUVZMjbqV8GN+grzT+sMdZa3VrW3f0BVysPjVyU/UJohmr54Fza8qORkrusyPZUVKBoT7bRueWpm9nezK9Dh6dizFg4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zsXWFV7KltUdbZ6D7T/b/EwPFDqTXv5yCEvdhUP8Fc=;
 b=E5C1vDI//zOhYjuLRaW0QfHvZ9kghQ/jPfZbKk3P8mfqDCHwg2+ftvtHE8F3mUjy3mSUUTYxdawLI5ov5s9McX7o/jBdLx3ZH4A94PUaNPdD8yoNUyj090E/NcYaCK/dlXTziVOIw/oXJ/KogiW0cQE8yl8XPeXrIfriqzc0HzwrRzbS4IgafsYE3ARh8PhsU5wH7FWExtAhqsjAO3WT9LlIiotdjGBLmCVjTFD2YXugqGBNqTIvR8SuScHVJ7yYnTNWPLNOpGmkThHfrQw1JMzEhlMLuT4aw36T2lEWmfsDE0V2BaPj7wJrs1IZi08PyjTdQ0s/TYwwz2nM45UPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zsXWFV7KltUdbZ6D7T/b/EwPFDqTXv5yCEvdhUP8Fc=;
 b=opEFWwW/2sILAQ3mUCDMXxcPJhMhe4xXXxMENhYQR0oOODkaFNeXY0bKpIBNAL6+l+r5YAPyS7wcJMDXPP1ubuw1XOrSdocCcx/Uv9BMf4jWlxmhtbN574MMrDYnMclQWs6irQMA3q53sSHlQiHVZJdaCQ+h25P2cnOuSLlqedQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1291.namprd10.prod.outlook.com
 (2603:10b6:3:a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Wed, 26 Jan
 2022 13:25:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 13:25:17 +0000
Date:   Wed, 26 Jan 2022 16:24:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [bug report] irq_work: Allow irq_work_sync() to sleep if
 irq_work() no IRQ support.
Message-ID: <20220126132457.GZ1978@kadam>
References: <20220119133729.GA14183@kili>
 <YfE6YV7V2s89A55f@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfE6YV7V2s89A55f@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 982807d8-4548-498a-69a6-08d9e0cf4adc
X-MS-TrafficTypeDiagnostic: DM5PR10MB1291:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB12919410DD0FBB9BCADA33D18E209@DM5PR10MB1291.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0MUu+wwIF04mnCUBvL3XaJXMhejOSe7t3u8q1BGl1IFakNlDp2P9XA8e6MRy1Hvxj9VoJgqdpRYHqAhJqjEVI6F3auw+HWrai4wd0qZzpQLHIX8li5bFUiqSvjgAdlTrNhr96Hwo7ENKJ6PisvWCcuQlFI665+g4ZTXA6ofxJS3MV2dK3/+JS8S0gQ2tHXoDED/bLKub7UZrEVZZ9ZqRmBcZS7Ugh9gHyZbeWGhjixUpQ03XhWnMgLogMxcsNOAcF4V/6fvWYLekcxA3RE87bOApNBYLMQD9kNsWCrTpY9tqgL2ufF3b954WRSaeHFoZYoUVoRuqeiNYmo+OTxHfl9oqKnzqFH5PHq2xLlVNrWvLk8lpy7EWZ1Ruhy2n/vpLQ2s2FWYmjpi/wOwmiReQWiylV7FrL9a7vfyPI94DFNP0PD541Q90ZzD3CLXYCbUM1WBSPe2EeJv/FSzygwLKhISePHEYEslaRAx5mwdD53MywqjaRXfxesWRjiXGBMxUQOISKFQUfuhjk0IET/r7jsz8351ISWU051iSn9beEfxeaikBUCLeB1ykd6+TZz+dupaPhINXKBrAW8fXmXiiOCQ2MN/BtPHj+adhravv06kj5nWyBNUth78SOfonvtvrenngmp0Xflt+syt+AvGloipnsKT3OEOoZUmIgs/ReN2W/g4+vGeeJWimh16m+zrM9YqeN82nFO03I5jtXOItQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8936002)(33716001)(508600001)(33656002)(54906003)(4326008)(9686003)(44832011)(6512007)(4744005)(5660300002)(6486002)(2906002)(52116002)(83380400001)(316002)(1076003)(38100700002)(66556008)(66476007)(8676002)(38350700002)(186003)(6666004)(86362001)(6506007)(66946007)(6916009)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZoCuy981nXFOSdiN2qEX+ii/s2QG90IyyikMpVdEWIe8afg+x+oahLXxkLeg?=
 =?us-ascii?Q?LA6xRJCNUf8rwTeqg6F3Fm3Qyt4ddQCEkkk1wlIIjipqeer7YgHK135fdnMz?=
 =?us-ascii?Q?NXWhdpaIjwtLRuZO/s1x5FqtnAr/TdkFf6y0ShYeSuJYKI5b6WK530KXKqQ5?=
 =?us-ascii?Q?yRV5xpjzZlGrGP0t4U6MZaUXocqM4gpqhXW++zLtVZpFrIecc6O2UOySwtXS?=
 =?us-ascii?Q?vQUuUNdSjJ14aqcw7jFq7MVaDdNYBjjunxeYuhtsdsIaEAyvVYLajQhocw1f?=
 =?us-ascii?Q?jG5dNSmSoXZMvix9FkHtJ++xkkxEQ8hMT2Okd7Hn8H5L73LfDAwuYC0ydrPV?=
 =?us-ascii?Q?kkG2GM3EBoMPquyZMajO2r9Huk8XFA4HGx2xNDufdFMOHwq2ZI9A7DGFDoEs?=
 =?us-ascii?Q?Sq4GtKdivBX8bDMoz/KdFlcfdwiuGY/aJil6bGHcyT9g7d8cXo3QZMiBq3HV?=
 =?us-ascii?Q?Dw557fE2SoRZJleVSFuTJzk1LoRBXB7gG2HFChdEdFZ6emIP38+BVc1gK6v6?=
 =?us-ascii?Q?OUumTwk18PLSO65ycy1FO0YMwjUGpK5RogzDvwDNJI1EaiFwmcItCs1p+iFi?=
 =?us-ascii?Q?VQsrIR+hJ/uDOKQJs94CKoQQQE1Q8TwPxSTSfxgYQYuetUVEbIXo4ivostRn?=
 =?us-ascii?Q?Ypv8xEQu1YQvtodvocr//KCLdn6i417Cxc7+BOt64QUKmffRbdtXi/7UJ//l?=
 =?us-ascii?Q?WxR8tfvJzU3Debf89xBwnXQspgZPAG+LaEvt49RVySJ1yTgSq/Hn+1ZjskZU?=
 =?us-ascii?Q?aemj0gqFqhkftEkA5OVMT0rhNj9GGvRb8THMZJCkvOOeUi/FyVBx45JZyMf9?=
 =?us-ascii?Q?XA0D6uGWHjejUALCW9N9uG0ypKPgi5UDEfVTYg2WIbeiveo9d8bfVYJKkVc1?=
 =?us-ascii?Q?iZLhp1WrHiyFPE0cFK06p+H4ByeHVTMywrKDauW7y3kozZcT9awwMnbF5x6g?=
 =?us-ascii?Q?bnXZhyn3TRTCNJGmmET79ISWq106lCLnq/MNOyPpxF9xzvNZHWVwAqWEllk+?=
 =?us-ascii?Q?z59ofyPvDjwte3c4wkmzyvU8shmqAJLEhRok6iI5GA51PL0f6qnejimZ/989?=
 =?us-ascii?Q?uOjrSwEwo6TJZqMWfMh8hxFPnubd3tufSxJ7259lKE8EQyL5x+8cyA7M8VyO?=
 =?us-ascii?Q?flUOoGAwmEm0ROYPL71WGPbt9iF4Ju+PWEVTl+y7dHrCaw4MDotLws9bxBiy?=
 =?us-ascii?Q?KsqiKyEvdBwYvf09bIIu/KyMKs2LEduOeYDmn6aMsYy1dkVnlbqypsVNugVm?=
 =?us-ascii?Q?BZjkilPTuUySHS3USRQkWmV0sGDv5k7Ecxkg8OJEs86cXy35v+Ti+U3MseVZ?=
 =?us-ascii?Q?EA8xP/F4qpogiJmSp2RUJl+FWsXo00EF2Uf1TGb68sqbyGxyfWvXYPL/l3/6?=
 =?us-ascii?Q?Vr5256NI/PaubOPe9FRKzvWuFBCAfnlPSviVKstwki+8vejGGAVegB7vxG9K?=
 =?us-ascii?Q?/FRbr31seAAoo/DA7AqzVVmWMU7VNhspju67uUDvwRDJMd4kE4N2lA9hKyzm?=
 =?us-ascii?Q?GQuEcRzKdQ1ylk8qksmEDt+NwuECcGKe2HH1Jx1ETUBGosi8fK/svMlhgXP0?=
 =?us-ascii?Q?fjc/9Fp26g36sBttesWoh65sNULFcNwpCYN+hbrApgSuUACmKuTEsGFbx/gc?=
 =?us-ascii?Q?pc49tyopQ2Srdp35eytdj+3CDtmsCOcPtaHAdrk0XV8wT43W5qW/3qFolbPM?=
 =?us-ascii?Q?xOQnzMtrKzOHwzHoWQoGDWYLHmo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982807d8-4548-498a-69a6-08d9e0cf4adc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 13:25:16.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdVh4+HssH7SY8FgDOYmtfKrXh+E027gpKZfzitOXIUQwg6Ri/6X9nbanL3yvCjHEluQ65MGo9q1JV6tLdHLxvNRsywC7vRgmqAhZuvz9aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1291
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260080
X-Proofpoint-GUID: JrwfpPa-KTWjuVdCDW8RQqMwdA2_uudD
X-Proofpoint-ORIG-GUID: JrwfpPa-KTWjuVdCDW8RQqMwdA2_uudD
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jan 26, 2022 at 01:11:13PM +0100, Sebastian Andrzej Siewior wrote:
> 
> > __perf_event_exit_context() <- disables preempt
> don't see additional one.
> 
> > -> __perf_remove_from_context()

In linux-next perf_remove_from_context() calls raw_spin_lock() which
disabled preemption.

kernel/events/core.c
 13343        static void __perf_event_exit_context(void *__info)
 13344        {
 13345                struct perf_event_context *ctx = __info;
 13346                struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 13347                struct perf_event *event;
 13348
 13349                raw_spin_lock(&ctx->lock);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^
 13350                ctx_sched_out(ctx, cpuctx, EVENT_TIME);
 13351                list_for_each_entry(event, &ctx->event_list, event_entry)
 13352                        __perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 13353                raw_spin_unlock(&ctx->lock);
 13354        }

regards,
dan carpenter
