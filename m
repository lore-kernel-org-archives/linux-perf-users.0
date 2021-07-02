Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC8C07E95
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 22:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2419D613FE
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 22:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhGBWvi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jul 2021 18:51:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31806 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230174AbhGBWvh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jul 2021 18:51:37 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162MlDD3025673;
        Fri, 2 Jul 2021 22:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=cCY7XbEmOuqFL0Z1ny/8Na/Ldp0luW0mfa5cfD3Y5fQ=;
 b=g8/y2jEjeDuNvhjLYCDsZEvIn+sHgFfaKlXPNU7CmzvURoNmHBk9M+7CC/uEDzgCzv1f
 6ABa6FXBkRoXbIMVucKUB3ez5HHNfwvG4UHK2szubVEyj82vSUNG8/5gbsJiyksrZvOU
 WmgUwJWtMeMfTxFgqBikGO1fdXSWEVGtLhI4Zja8Z50T2toGlBIxW1v5m4KV3V/wCFR1
 xyAAOqF7/KwuJXh5cZFTruhMpAYDaFZtORJlyPwDE/VvX2NMw4J6tznKKMffn3MVwbZn
 K72KNFfqq49EAedVFu/TymAdgmDNdCxz2K0/00J4r2UqHjImBj5CamxGPQzgI4KPi2JX UQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39j3v58s03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 22:48:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 162MjrxE044109;
        Fri, 2 Jul 2021 22:48:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 39dsc795de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 22:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRK/b+PId7X34/KEIjeJ4x+5K/vIZCE7cvUrgwczKCNHvUwOIRzs3zOy2Sj77ZMofVZocPnxivuW6oCFbQPA1q6LdmvwwjY0iVfGcroc/A2th6P62OXI0zOg/+AeR1h8xLbA4TbDpwV0aLsaINxDe2lXCyWu3ZzV1E7hy6yqLVzXc6sk/T1Wecr0ZEJKr9ZnfgOrnRphTNFiHbrK6gRwEqXSeNZ3ErIep540ASFP/e7yO4Kr8bLBWph4wtcmzc/002IAqkrDuUp8RIS+8cH4r8Udu2QFDfdHU5QwpeIULTBofXho3YD++B3DWsmlVvM5BQUmMbCLhyHiFDm3PedLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCY7XbEmOuqFL0Z1ny/8Na/Ldp0luW0mfa5cfD3Y5fQ=;
 b=EbdWFo/dl4vOs12P0FAeoMsOZaGkXfXt0ugsdgBSL4Al3Nvt517sv1n08A+wtnxTUQVqaQQqFbmAtJR+i8HZNFMaJ7SfCG1PGpeiwTVGwjf0WA70Hj4L2+G/IEThOOMRr2uptCf43A92wEgnp/6aNklHwlnyQ2P2d7TP3lp2o2HBW/hWr7tsw7zrQRKg2stUNePs6RW5FycO+E04lr+iUE3UDpoKNATFI/DbCbq00y2g71RjeG6T7Xf8LprZIoTOvbEGBjNAqC4k9H0xkz8AHa5ktpHt6Wbpn2p6UWXMzDxwxNviuz+SKzwjgRm30AxFmns7hiGducWgbG8kA5y5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCY7XbEmOuqFL0Z1ny/8Na/Ldp0luW0mfa5cfD3Y5fQ=;
 b=ftxmeYftuAhZuM3eppxYyormaql0FfSAGbNkEglUOzaQqKlFXtT8p6suGDSDMK9RThXATlfK+W6OpJ8gRSiSJ8jaDREnjy5hxErSomogSgZmX8hBqXuAo+v0OQVAkd5ozoBiLncFMJQV04ILZz2jlA8/seJFdLtPXc1Aza8hfEo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15)
 by BYAPR10MB2662.namprd10.prod.outlook.com (2603:10b6:a02:b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Fri, 2 Jul
 2021 22:48:51 +0000
Received: from BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::3574:8df7:f5c0:d412]) by BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::3574:8df7:f5c0:d412%4]) with mapi id 15.20.4287.030; Fri, 2 Jul 2021
 22:48:51 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Perf loses events without reporting
In-Reply-To: <YN9zQDghzBj8b4Ki@krava>
References: <87lf6rclcm.fsf@stepbren-lnx.us.oracle.com>
 <YN2a3pSvealjK6uR@krava> <87im1uc79i.fsf@stepbren-lnx.us.oracle.com>
 <87fswyc6cb.fsf@stepbren-lnx.us.oracle.com>
 <87czs1didj.fsf@stepbren-lnx.us.oracle.com> <YN89LwSzTKc8wBar@krava>
 <YN9zQDghzBj8b4Ki@krava>
Date:   Fri, 02 Jul 2021 15:48:47 -0700
Message-ID: <877di8coxc.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-Originating-IP: [2606:b400:8301:1041::10]
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To BYAPR10MB2823.namprd10.prod.outlook.com
 (2603:10b6:a03:87::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8301:1041::10) by BYAPR06CA0036.namprd06.prod.outlook.com (2603:10b6:a03:d4::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Fri, 2 Jul 2021 22:48:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf1baf3f-05b0-4cbe-d270-08d93dab8ffb
X-MS-TrafficTypeDiagnostic: BYAPR10MB2662:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2662A28F2DA0D2EB32E3F026DB1F9@BYAPR10MB2662.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZ0bLqK1nBcrFxIw/CjkF+NmszIod4U0T44XtP/gfzXF46Cf9/x/m16F0DaK8zNqGI8hZiTJvH6vBv3bjBmcdNkRPhM7IyfjWrtyvtr7T6rQ8hMOFxmI70KArZp1FU0Vr1UG4W8IfYSJ8nFlUTWnfPHf6IjpDa2OTbrA6ltlJqBfZ26aaK+XOA1xDPpojD+v4zHUyMsGaD7N/551iMKPIJCLS+8DRSorAwJPyGzL+yv73WIRsLKre2vmWyjMb/XvloNGEgUBiKff+lJ5gLlUW5OKfoKJzlJdUu/Y/dd0RMNZ+jjzFFf5+UalhED6bN+lXAVG9mGkDHi93osVzcH0XfoFquJLFIn4uPPLO0Rtuz+sj+ThRcehlSiq55OiAFtig9s5l1AWlio4SlfFg4S2uQyEfSBLD8pSUc6dscb6ama+BUsuA0l0cD+zj91HHukuJYvjeFu9cNawr3kfEeI+hjP8J2v6mHBxTr9iETjmDScaD8aaq0JGpPp8lHtZmtqbEyG233GfeLO9RUAROmowbr9UlyPI9gU36ktTW/HuGZgI3wZbbLyt0ENjrJfZvdqzudQZlEv1XNXLaBmhavUAHQxaWeQKOCxS2fNyoAwtQqsUzFrOzGy3VMfJ2xwnYa4ndh66+5BZQecs4kY2/gMUxpJgT2lY1S7VoQ4HfgCKBoKR1RjwH2w48gZG5dqLa2i7ZhUv9y+0Vx0J281SNMfEPvLnR05bhsb8Wj8wD2g+DcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2823.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(6486002)(6916009)(66946007)(66476007)(38100700002)(66556008)(16526019)(186003)(5660300002)(52116002)(8676002)(6496006)(316002)(2906002)(8936002)(4326008)(86362001)(6666004)(478600001)(83380400001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YIxCNu61uiwoiGm6m0F/Iyflv55lbgpl/n1YvDHm35rZTY0GBDzaVceluuGU?=
 =?us-ascii?Q?d0l+5lVh47hncUYFkZU4/YPHwyPuezjwrPFRPrCw6MG/VMm0V13NK+329XKS?=
 =?us-ascii?Q?/427On4WfYFLqAphj5Ezh5At96k39JW48ajfWAPPMtIPP8eDQ8XJU/0TayoW?=
 =?us-ascii?Q?OcS0oMN70ZCOAiohiDUuO90ILvW2PgVkbs1t6uT96IjBtIBPrCZXFH6eMnW0?=
 =?us-ascii?Q?yq6l7Ug4jiApbq9Rzr8h8C1coYQACrCIYPncEx8kB+1g7dZDy90GkDKVx/Rq?=
 =?us-ascii?Q?vEo/o0MQQwVPjZfyM3OG8Q1HdFpfo/NGkeWBt/NHbfjNWSfIkiS7cwPie0Kn?=
 =?us-ascii?Q?mMttIZI/H+v22B0DMKXIqVKsTXIYQCO/ppjT1Ml7HE2CAFayipjdvvjsuzY6?=
 =?us-ascii?Q?nIysiu6PKBY8SKnWjhJoPrs9k+h8QzmUldXFRY6AdJhkLA5RI7tUYZc6fLQY?=
 =?us-ascii?Q?VqN4KXAzrHuXshKJNFtmM8pc5sf2hg18hgFqbcl0oP2MRxBUuySv6c2PD+yQ?=
 =?us-ascii?Q?U/3zfUdfvICIc5C9PQiNrrUIVbbtCfbkCN6upR5uICqdAODtZFH32vf8wPqq?=
 =?us-ascii?Q?ZcDmcX1CHtJEnY86aHZIjtU79XMIcM+li8jeFIsodNwmXa/RHKvINR747qAW?=
 =?us-ascii?Q?iz067etUHWqLEYCzoIBuqdq0d/daqKsthqAJAs0qIZ8NH+i9GbQELqmptCth?=
 =?us-ascii?Q?ieJIsv0SXLyboWK24KqYkB0PByHUMPDszP3vPYDmzJTRXngeXfPkHeynBGaJ?=
 =?us-ascii?Q?3Hh6sKtEIukU2FgjPl6pceCM4P2nj7fTBgYFOS3e2perkxRLp3SDgOO0HTo5?=
 =?us-ascii?Q?a3tnsQ4nvELtnyftXB3KfWIr0GrV7pheZh4mSmYxJAA8qqLNs03nR4uDeRfR?=
 =?us-ascii?Q?9tVb7a/YUU9IOJ6/QYmdYDNenKtvIaP2BTyAGu80KZG5nyVI4VWeggniw2X7?=
 =?us-ascii?Q?GkURZ1I1y2/1/dAQo4oQPLAN+pKadlwmY3OQ3QI5EnLWm6hNrWbHMTeBoaRF?=
 =?us-ascii?Q?gzLdDFpXD/FFnTTdWXNB61cyPMGNU+tYbnxp/baOW6Jh8PeNzyH3RfaQ1Ils?=
 =?us-ascii?Q?cY60L9iMvHrU+mdK6DOF2jquAbzfP0Hbtzv8rZbP2wND20+KNIpRz5a3iAa0?=
 =?us-ascii?Q?YA26oQ9E7EJKr2yCBb/j9UPKHSHxYiFh3NEP5508VcuHwDp1ycDDouODlnsT?=
 =?us-ascii?Q?+Z/Mg4pfUQlR7tkRNUpR9RzUq0L1is+35Q8Lfv0ctGOTMUhbifvqL3NUFfRz?=
 =?us-ascii?Q?+fVvVmWMmu9tq+2IDfiL1LAdKIjqhrDKO/f6Q3nx7LXLwfNNZJW2cTKTRm3o?=
 =?us-ascii?Q?OW4oJTZckF8mZZiil11AE+BzWoTITeQkVsrJMu0CuEZ+Jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1baf3f-05b0-4cbe-d270-08d93dab8ffb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2823.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 22:48:51.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xz3QImmQMS0NjDmmw8FbbZZS9B3tyAcm9N+wSzsdfI/zfpT7j9U0xFPE8tPiv/bBglt8+QYj4pksahvZ0RQzQXHAJO86N4MwriXW2YVeKWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2662
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10033 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107020115
X-Proofpoint-ORIG-GUID: 4Gg8lJ8y_1Xgnt0x05Oalfez0LxhG1YA
X-Proofpoint-GUID: 4Gg8lJ8y_1Xgnt0x05Oalfez0LxhG1YA
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:
> On Fri, Jul 02, 2021 at 06:22:10PM +0200, Jiri Olsa wrote:
>> On Thu, Jul 01, 2021 at 11:00:24AM -0700, Stephen Brennan wrote:
>> 
>> SNIP
>> 
>> > 
>> > static ssize_t irqsoff_write(struct file *f, const char __user *data, size_t amt, loff_t *off)
>> > {
>> > 	char buf[32];
>> > 	int rv;
>> > 	unsigned long millis = 0;
>> > 
>> > 	if (amt > sizeof(buf) - 1)
>> > 		return -EFBIG;
>> > 
>> > 	if ((rv = copy_from_user(buf, data, amt)) != 0)
>> > 		return -EFAULT;
>> > 
>> > 	buf[amt] = '\0';
>> > 
>> > 	if (sscanf(buf, "%lu", &millis) != 1)
>> > 		return -EINVAL;
>> > 
>> > 	/* Threshold it at 5 minutes for safety. */
>> > 	if (millis > 5 * 60 * 1000)
>> > 		return -EINVAL;
>> > 
>> > 	pr_info("[irqoff] lock for %lu millis\n", millis);
>> > 	spin_lock_irq(&irqoff_lock);
>> > 	irqsoff_inirq_delay(millis);
>> > 	spin_unlock_irq(&irqoff_lock);
>> 
>> yea, I can see that as well.. if I took the spin_lock_irq it works as
>> expected.. will check
>
> ok, so with disabling irqs you disable task tick which
> kicks the unthrotling
>
> throtling is started when you cross the limit of samples
> per tick, which you do real fast with busy waiting
>
> then when event is throttled (and no samples are generated),
> the next task tick restores it.. but with disabled irqs,
> there's no task tick, so the event is throttled all the
> time when irqs are disabled

Ah, this makes sense, I'll take a look at the throttling code to
understand it a bit better myself.

>
> is there any use case you have to have irqs disabled for so long?

I don't have a good use case for keeping IRQs disabled so long. However,
one of my use cases for perf is as a debugging tool for anything which
doesn't result in panics. One common enough issue is spinlock
contention, during which IRQs can be disabled. Normally if a lock is
contended, IRQs are disabled and then reenabled very frequently. In
these cases, you wouldn't necessarily notice lost events because either
(a) they wouldn't be lost, or (b) the event could be unthrottled
frequently. But sometimes, a buggy lock is held for a longer time, and the
event loss can make it hard to see the contention in perf.

For example, in a recent issue we saw a spinlock held with IRQs disabled
for several seconds (causing other threads to pile up waiting). The wait
was long enough to cause serious issues with devices due to missed
interrupts, but short enough to not trigger the configured lockup
detector. Our perf recording didn't show any particular "hot functions"
at this spinlock, since so few samples were captured there, despite the
large amount of time spent on it.

Ideally for this sort of debugging it would be best to have all the
samples. However, failing that, it would be useful to have a reliable
detection mechanism for these sorts of gaps. I have a script right now
for frequency-based sampling, which detects "holes" -- whenever the
period between samples is more than 10x the expected sample period. Of
course the sample period can never be perfect, but 10x seems to be a
reasonable threshold that only really gets hit during idle (due to
frequency scaling, I'd guess). This script is decent but still has false
positives.

Thanks for this analysis, it's quite helpful!

Stephen

>
> cc-ing peterz
> initial email: https://lore.kernel.org/linux-perf-users/YN89LwSzTKc8wBar@krava/T/#m616481aa95da10e17d9b0769717f006b9ff38637
>
> jirka
