Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF71FC11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 18:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93036141A
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 18:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhGASDK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:03:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14772 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229844AbhGASDK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 14:03:10 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161I0bU4013338;
        Thu, 1 Jul 2021 18:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=NP/EIwAyFmOFjJWHjAzwy/MYuQLZmQCK8C/RJXK+Vx0=;
 b=qJYo81UJpF0Ph/tG8O12WqcrML2evZhJ4hmG8IiUzbEyZNLLl8riJ/a+zOplFP90C989
 qYCymSeWVGxBGFK14T5puAKw4XeThm1P7/q/bi3jv+3R6R/6FOUfvTjb5svGnfHy21QS
 lePEIHB+uqbk26490vgJSykUuZYFehevNq8mxnEHJAuqdhDmIUyC5ZsD95oPAQzNKGmq
 Ti+3g3BmqiKSKz+YIjNuYk4zCumedh7waPSnBp23JL/C42p0R9Arq7woSxgSLxyuSIlU
 XLiBkur1lDoibCpbt/49Gny9+4btBcFd9soTvmj9L90+7AdIDpJ4mR6dVgBOb/CzlQo6 zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gb2t4fd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jul 2021 18:00:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 161HpnM3077670;
        Thu, 1 Jul 2021 18:00:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by userp3030.oracle.com with ESMTP id 39dsc4esqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jul 2021 18:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjX75q0x98KSymwryDEv1wnC6t28OEou9BDYFRG4XSXANXsv7mjNa5sgrLyoOK9vqmJ6HLbyRNN/XpxrZfuDssbMOG5U+m9LpcyOfwpTZV2IdZy+puPP9coPeYyBVnI8iyarnIBUHUj8zYyFigG/8PkQeDUYniHkviPsn/iYhBl5D0rt6fcGHuoOkOB6cPf0Z0EwMgN8B6Z0SLzVGt2PkApGwXsNGHt9/wmM2aTLFMQC8Iw4LmCu9yRmLHmwo0ddRcV6R6Xm30o/r0NgkEH3hKfwxA+8fBDM0VMoc0MUAkjxLAtJ9OoOtGAa0yDcb3FX4C+QEIm0cPCXYJP58rnaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP/EIwAyFmOFjJWHjAzwy/MYuQLZmQCK8C/RJXK+Vx0=;
 b=gjPul/JryqdR+1ES9FQ5VNbXJDhBfFtlNys8NzR4yruW1rDgI7DIz+x7gWP9B0mqw/fUXJHqx1Sv4F+39a++BaYBUPk6jPRnClrSQS/MoPxaruvOwixnLlwKq5JH9RxY5KmROxXL1uE2fil3S8PxyGoLc513bglBabmO3tz703mzJabNHIODLuHGyD/BdphdVcYE6ASMZqnUVFAos3wv3doNstPjHIiGCwiYmxwELPlC8g1jb+XT7OhTCUJ0mSV48hhSHJ1aFEHH/UEKu4UI35xvvGvLHmgzyQ4BeNt8JjFi6to6JK2FksnT4S4XlDBlwqzmdegFTIaBswbYqvnLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP/EIwAyFmOFjJWHjAzwy/MYuQLZmQCK8C/RJXK+Vx0=;
 b=wJz6KT01OajClfO6Zqcxvi6SuiJZ5lojtLUxq6SJI+4TFKZ3qGdoQvrGu+GPEPlWk6IBFksSA1O+xg65HqSf/S4P58zeYyBPm3QNHLzI4iGRfnvIRYXdSrXopXZd85XrxCRKk2vS8swErZEQ0a+klygvIu5yuCWhwXCwlxnUeOs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Thu, 1 Jul
 2021 18:00:31 +0000
Received: from BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::3574:8df7:f5c0:d412]) by BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::3574:8df7:f5c0:d412%4]) with mapi id 15.20.4287.022; Thu, 1 Jul 2021
 18:00:31 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: Perf loses events without reporting
In-Reply-To: <87fswyc6cb.fsf@stepbren-lnx.us.oracle.com>
References: <87lf6rclcm.fsf@stepbren-lnx.us.oracle.com>
 <YN2a3pSvealjK6uR@krava> <87im1uc79i.fsf@stepbren-lnx.us.oracle.com>
 <87fswyc6cb.fsf@stepbren-lnx.us.oracle.com>
Date:   Thu, 01 Jul 2021 11:00:24 -0700
Message-ID: <87czs1didj.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-Originating-IP: [2606:b400:8004:44::26]
X-ClientProxiedBy: SJ0PR05CA0201.namprd05.prod.outlook.com
 (2603:10b6:a03:330::26) To BYAPR10MB2823.namprd10.prod.outlook.com
 (2603:10b6:a03:87::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8004:44::26) by SJ0PR05CA0201.namprd05.prod.outlook.com (2603:10b6:a03:330::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.7 via Frontend Transport; Thu, 1 Jul 2021 18:00:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1faf48bc-619f-42d6-ee9e-08d93cba1e16
X-MS-TrafficTypeDiagnostic: BY5PR10MB4178:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4178CC2C6F844853A260B437DB009@BY5PR10MB4178.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+KZNVmUky3d8PWShf6ycFmJKeOWsrR7b2dqhjCz6XKKXUlr4TH74eh23be6o7hFzllR39Jn7ASbgtpO0T5XyGqRPRL4Q50uYuWZHgcC6EHk6AZ3kZVOQhDJWRaWe7bMLFKWcFTZ+pnQfhtXAU2UiI5N/sgzlOIFzfJTHSeMpOrtuqZdIPO4MSXMdvSjGr5iaxq59ImDUG6IhHI/fPlwCRLltauliD5J5R1S1cgk++/QJHHGZZIBAaOIRDj3oWhVEEVo+RfYaUB4Q7C1jDZB5E82W5ZtkGkfpYTRAMuPL9FoZJHBrkcwvXbaXiXEIA1sgmLa5OnGxl2XzESRENqogUhc2vNXoQOYYqENOtYVj9GCpySBBMKwYkBRVcSH65IWzyrullqbx2a60i0ItV/4c/4U5K/mKm8H7Z1s2V0Eno4WXN1VcZn5vB08RZEr3XmPGBZ16Gi8Q4LaArE7mO+XIlyqmYDrNDqDr9bixYZTI30nz29yCevDuj4AMQdoPj0507mDCwOI4vVhQN/GhNtPVp6wvGbpztyvoTV8U2CgKKbJX72KCqe8EHdRS9YYsn47DxnClLXqIigFBsd0MtY/nRoN7Buwvsemp3mtV5pTmxFDSVMCweQOds7ytk4v2Ypgjola7aVO7BAdwf8I+IeE0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2823.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(38100700002)(2906002)(4326008)(6486002)(66946007)(5660300002)(478600001)(66556008)(66476007)(6496006)(8936002)(16526019)(6666004)(6916009)(8676002)(52116002)(186003)(83380400001)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fgvi/QkCt1fcceDln1YR6SI+Yskr9c/DrXcHcXgOuGWY2U52eaPCbeJkR9Yn?=
 =?us-ascii?Q?XWfFXDZEub813C/cVMMLPbx48Npe1eU95oSAqFCdkGf6x//cjv5TawI9ozka?=
 =?us-ascii?Q?c0hhMWXYFcWL1lDOqr0ri5jl3C1HkJ8GM29PlaHHChvvY8syLSbHTrCwfbF0?=
 =?us-ascii?Q?T8L5Tey4RG7ob3Q1ZjdQ0lJyFoDltlug4WQaPAA5XRkE7uHsZWlZQZooFuha?=
 =?us-ascii?Q?gofw+12i5E6DP7NaL8GFbQqNR+Hj+EwriOo5UMtDNcLe9OOSwlaHYg5MHs5v?=
 =?us-ascii?Q?L4UhtLyOcBZYYiZoTUG8M1B5Dja5jJzqHkuPJSY+g0bODmiF2ioR0bEVrmMK?=
 =?us-ascii?Q?ScBFchOXNdz8t75/p7mJUXk0xgnSZ7LurjKk8hX11OK5ha/u/GQdPzrkPmxC?=
 =?us-ascii?Q?yJfr9KIWTQ7nIq1XNpzr0bfx9u5J3Z8UwQ6DJjxbM/LtUqjpjx7gTF94re19?=
 =?us-ascii?Q?3oBYeCfGwW2Igk8QeiuqzQYhtt1s0KcIXmpKgXJhbDExX6VmwNaF+nV2w6H2?=
 =?us-ascii?Q?PBH3Ph+E5ti6OqINaHSySXarrs4Bho8I0/vXt2HyqtoZ4R1hI0aBZfZuizWt?=
 =?us-ascii?Q?JU2Ep0D7a7kbLAnhkNfKjAm7Xy6XhxQnbWuzo3/frwRExMh3qeh9+J0tb3W5?=
 =?us-ascii?Q?WHY0xgNDGKwCQ3laBMblPoJx6K1HxVJS/nrFX1RKDMjqnSfknN5/wCz3pj39?=
 =?us-ascii?Q?oldjVOYRTGA/gzjJvuE7z1s+70M1SBy55sXbw4Kn/RJmVAmlkDe+Z+UjGisz?=
 =?us-ascii?Q?7NMnMY8URF8GZk9b1oJZDtmn5XVKMPBnG7N+DEAsojVmQoodJcsmtQh/G/q3?=
 =?us-ascii?Q?BwJxt61gPhSkCAkA3UCC+1SsLbw4/831xv/TPe+Ksr9jSJgyYVug6jUrgaO4?=
 =?us-ascii?Q?YDCyJoLOy9cm5tRMsS6z75QZexqLWmbgJvF+NiTCUPmGAeBJN3JKgQhHeqNa?=
 =?us-ascii?Q?eoOAL9lprvO2vEQWhQMoWg6Ikik6xjNdEedugB/vDl9aPvbnJHu4nt1jZt3h?=
 =?us-ascii?Q?VvlZuRZHFZnv3dcmRtyjpCYMzkXIFWA8fG+cNB3V7kIL/m6BCvqr20Stop0B?=
 =?us-ascii?Q?O7xPAkevoLT+unxJjS3/w1g1c5ZRGLebZzPTO6PrDoTxb/D/d2xxmoaF0L80?=
 =?us-ascii?Q?IUIMQrWEn1pM6AwrUq8Ghf/s+eANENLk5iofUNKaCBw4amnqdmdtihAXTwu7?=
 =?us-ascii?Q?JQd99w6m0cx4kCLegvjo7Bx+wRS0HpevG6a8uZEZp+PbKD3OiqPv8hTrdKxq?=
 =?us-ascii?Q?RJ9A6bzMRu59OUbtWKQXfxitpldxAfkS79P53ZPkH5AvDU1/v+3IRLu4T4Dh?=
 =?us-ascii?Q?m1cUpe6NXojURNllLrKZ1XVjwq6rz9V4TwheUQ+e7ZPVCA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faf48bc-619f-42d6-ee9e-08d93cba1e16
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2823.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 18:00:31.8137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OgwkTLsojScLEjR+/mYpxA89R/PR9gwBw+L3OxfLoHRB63UrL3iGESmf0rKiQiXyxT/55zTV2hbqmfz64poH+rytxLWy1fmd9D4309+ngg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10032 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010105
X-Proofpoint-GUID: 6rAFZcgiPe7JFTGoS3zM5Yw-kwtdHoOr
X-Proofpoint-ORIG-GUID: 6rAFZcgiPe7JFTGoS3zM5Yw-kwtdHoOr
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:

> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
>> So hopefully this information helps narrow down the exploration. It
>> seems to be Intel PMU specific!
>
> Or more accurately, we only observe it on the Intel systems I've
> checked. The AMD systems record fewer cycle events in mdelay() and thus
> may not have a chance to skip events. I'll try updating my kernel module
> to busy wait by looping until jiffies is above a particular value. This
> would hopefully avoid any CPU-specific idling which would reduce the
> cycle count on AMD. I'll update this thread with my findings after
> testing.

Quite sorry for the spam, but I have completed my testing on AMD. By
abandoning mdelay() and using a jiffies-based busy loop (updated module
code at the end of this message), I was able to reproduce the 2 second
gap in the perf data. It seems that the difference here has more to do
with the implementation of mdelay.

Regards,
Stephen

Updated module code:

/*
 * irqoff.c: Linux kernel module for disabling interrupts and delaying for a
 * certain amount of time. Useful for experimenting with perf, lockup detector,
 * and more.
 */
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/proc_fs.h>
#include <linux/spinlock.h>
#include <linux/delay.h>
#include <linux/version.h>
#include <linux/uaccess.h>
#include <linux/types.h>
#include <linux/jiffies.h>

#include <asm/msr.h>

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Test module that allows to disable IRQ for configurable time");
MODULE_AUTHOR("Stephen Brennan <stephen.s.brennan@oracle.com>");


// Store the proc dir entry we can use to check status
struct proc_dir_entry *pde = NULL;

DEFINE_SPINLOCK(irqoff_lock);

bool use_mdelay = false;
module_param(use_mdelay, bool, false);


static noinline void irqsoff_inirq_manual_delay(unsigned long millis)
{
	uint64_t start_tsc, tsc;
	unsigned long jiffies_start = jiffies;
	unsigned long jiffies_end = jiffies + millis * HZ / 1000;

	/*
	 * With interrupts disabled, it's possible that jiffies may not get
	 * updated! To account for this, we'll use the x86_64 cycle count too.
	 * After a million cycles, if jiffies are not updated, then it's likely
	 * that we've accidentally disabled the timer interrupt and we can't
	 * accurately time our sleep, so we should bail out.
	 */
	#define TSC_EMERGENCY 100000000
	start_tsc = rdtsc();

	pr_info("[irqoff] manual delay %lu millis (jiffies cur=%lu target=%lu)\n",
		millis, jiffies_start, jiffies_end);
	while (time_before(jiffies, jiffies_end)) {
		asm volatile ("nop");
		asm volatile ("nop");
		asm volatile ("nop");
		asm volatile ("nop");
		asm volatile ("nop");
		tsc = rdtsc();
		if ((tsc >= start_tsc + TSC_EMERGENCY) && (jiffies == jiffies_start)) {
			pr_info(
				"[irqoff] looks like we disabled timer interrupt, "
				"bailing! (TSC start %llu, cur %llu)\n", start_tsc, tsc);
			break;
		}
	}
	pr_info("[irqoff] manual delay complete, jiffies: %lu\n", jiffies);
}

static void irqsoff_inirq_delay(unsigned long millis)
{
	if (use_mdelay) {
		mdelay(millis);
	} else {
		irqsoff_inirq_manual_delay(millis);
	}
}

static ssize_t irqsoff_write(struct file *f, const char __user *data, size_t amt, loff_t *off)
{
	char buf[32];
	int rv;
	unsigned long millis = 0;

	if (amt > sizeof(buf) - 1)
		return -EFBIG;

	if ((rv = copy_from_user(buf, data, amt)) != 0)
		return -EFAULT;

	buf[amt] = '\0';

	if (sscanf(buf, "%lu", &millis) != 1)
		return -EINVAL;

	/* Threshold it at 5 minutes for safety. */
	if (millis > 5 * 60 * 1000)
		return -EINVAL;

	pr_info("[irqoff] lock for %lu millis\n", millis);
	spin_lock_irq(&irqoff_lock);
	irqsoff_inirq_delay(millis);
	spin_unlock_irq(&irqoff_lock);

	return amt;
}

static ssize_t irqsoff_read(struct file *f, char __user *data, size_t amt, loff_t *off)
{
	return 0;
}

#if LINUX_VERSION_CODE < KERNEL_VERSION(5,6,0)
static const struct file_operations irqsoff_fops = {
	.owner                  = THIS_MODULE,
	.read                   = irqsoff_read,
	.write                  = irqsoff_write,
};
#else
static const struct proc_ops irqsoff_fops = {
	.proc_read		= irqsoff_read,
	.proc_write		= irqsoff_write,
};
#endif

static int irqoff_init(void)
{
	pde = proc_create("irqoff_sleep_millis", 0644, NULL, &irqsoff_fops);
	if (!pde)
		return -ENOENT;

	pr_info("[irqoff] successfully initialized\n");
	return 0;
}

static void irqoff_exit(void)
{
	proc_remove(pde);
	pde = NULL;
	pr_info("[irqoff] exited\n");
}

module_init(irqoff_init);
module_exit(irqoff_exit);
