Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFA9C11F65
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F345461474
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 17:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhF3Rbu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:31:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63644 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhF3Rbt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Jun 2021 13:31:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UHQCZP014965
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Jun 2021 17:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=nuUlYLfrMyWjvnQxpvp7PZAZQvRhhh2J+3Dt2BJ9EF4=;
 b=BdvFHd0OMGH229xA92gQgJV9KjFWqsL+iG4HXSk7G1pJtjsFATy/UKpHQUxHfXfcSnug
 Gf5mgq8R5IvwZ8S++mVuoztbOYB43OCcAB/VFzQk9fq/KbfdY69Cst4rDYaP8pl42jLU
 AcqUyX9YiE7Is2sQfY6vk5H/PCTRlNwgP4sE6djElQ+GfDxFzkF/icM54EqxKQY4VnT+
 2C/BPVJ54sL2cEkq8RKLNSCU3z9cfDJj4VJDAuCWK4aaoAq7Brn8JbDhajpKi9ZfncxR
 SxMidA7HCcJz+AnEnFUKhgNltqZHBzBgvB4dYsKEtrjASWQGS7hSotYl42ihz6GBoV+N cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39fpu2mgy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Jun 2021 17:29:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UHPjEP163771
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Jun 2021 17:29:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3030.oracle.com with ESMTP id 39dsc1uqne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Jun 2021 17:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW7IPlp28XTf4pO30h1AvknLCKzABT9ZL1ZCGvi0EiJ5ia25yei7C50ace5L+sv5xpgcRiowyh64Cdza+z2L/nssXgwqBvfajLkYXpfYseHVLEE0/EyYpR4BUidgrqcAYBSZlHY06Qkau8KlK5bC+BopYMlq+tPT736ccW9zrd1sSge14X/bXIFOeW5VpPN2BakzThDWqUmMde0gaSVPD2tCA/v9w99W1l4O17RPL4VNLQPocZdA8LumFNVpXFd7gW27AWm32bp2x6fGUJjnNWTE6AMyQ5MswLGFYLYfuOwvjSMusCsz9uxEkhSQp1/nuTCCz7bd+gX9bhmXfNapOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuUlYLfrMyWjvnQxpvp7PZAZQvRhhh2J+3Dt2BJ9EF4=;
 b=E1bYgsAJefmTyyvRrCOiBmOdy3kEWa5uFMIBRsnWy3WCux079XEObQjRc5p6oU2AR5kaiU4V9jYaJAYmSqzxTc+FaPi2nkA2+NqWCdatGOfZqbpglKRLkozf9CKnpBrueFEFQRwWBZAJca9MRNqyZNmO94nm49hGcRJ94vA+9kJ09uEFQySMZNnlw2bY/aUdTBTS8iRCotcXV5Im59qskw38NaL+//+/yiJncCiLlErEsRAimaWFjU+ADqFR6Vp9xLE5vIYTV3zYP0CWOahVOrrYQuzluDbATKCnFyPgKQai1p2+8RWyPcIP0XWJ6PwhPGpmkF1+UcIWcOQddQ1KSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuUlYLfrMyWjvnQxpvp7PZAZQvRhhh2J+3Dt2BJ9EF4=;
 b=EFkVyu2TRi+acbEzBnHsjM8WkpQuyUY5srrUNT5dxL35n6olXJGjp/CNcLR0Qdlmwn/0dw6bHDEsKnyloH7gb2aP53YvPcsZwQ9yl5Cfr2giYEGADVXbxBnFfG6dSMcTSHMy0N1bMEh0FC++C5bjKwTkS+marKssxVezQeItTqQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15)
 by SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 30 Jun
 2021 17:29:16 +0000
Received: from BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::3574:8df7:f5c0:d412]) by BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::3574:8df7:f5c0:d412%4]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 17:29:15 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     linux-perf-users@vger.kernel.org
Subject: Perf loses events without reporting
Date:   Wed, 30 Jun 2021 10:29:13 -0700
Message-ID: <87lf6rclcm.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-Originating-IP: [2606:b400:8004:44::15]
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To BYAPR10MB2823.namprd10.prod.outlook.com
 (2603:10b6:a03:87::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8004:44::15) by BY5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:a03:1a0::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Wed, 30 Jun 2021 17:29:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f00d2355-6edd-4f00-131e-08d93bec9577
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB468616EC1B11ABB1FAA03D20DB019@SJ0PR10MB4686.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKGvIoiBeeO6t94Cn7WO+DbsPQ6g0Ajh0EA6Qk4cAX/vxeflYxI/MYEDEFyOlN9YraXw66MTMoPx6DYjg2OgqTU14AFAvyAjWiUCBkWMO8Uc+ync4/Jlv6LpLtkpGV0hdokbrjEn+rnxe5soMp9stfn4IXY4klexDXS96tCl0+LhZptEXj5nWnFKHo7x2iq954w1SAP6x5FnY+c4UszBuA1+eZA5uJQSdXpTiRH6Iof5xL/xk2whyifYM+FN6/RnEpB0cbvnj0zjiYDhnk+JtCYiS8p7GPKpQCb3jVJS+MAKtjqDwIqNuE2W6kuU8XF+0HPl50LkGPudtxz1pfZz2Gw5xP8WsyPK0TJO1l/jVGGXHskwxjFbY1mgb3EBncHXlqLyuZTVCSUeurrA06SzHWsIraMKKSR6UxQXESb9Nq3+7Sytd/ixcKKdDGfM9pLe1TG4c/5nVmW/21nMWyOjuiJEacUtzfa4rdo2jAcDmAaoSlbrU9GZRPfGTCu3Kzpq/mUgsUoIEh0Z6VEIuRFIcwMc0N/a5IzjLt4A4xr6x0RAaTFPFNixKNgC9obj4poQO4//jPqRIw6hQUS1DHVXhrNp6eCiewzRUIw2ZZ/c3SIdZr9ewtLdUBPy35iSlmvh46eIC2Pm/Ld3SsgoFezlOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2823.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(396003)(346002)(376002)(478600001)(6486002)(38100700002)(83380400001)(86362001)(2906002)(316002)(16526019)(186003)(8936002)(66946007)(8676002)(66476007)(66556008)(5660300002)(6496006)(52116002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lc6GZZsBo0o3pUOR6v6/uAM7dzjZjYPuH8t7LozYsNxQjBuMYI1oP3OWN708?=
 =?us-ascii?Q?nvXhxLL9lbdbMf9hD7ehQaP+6gPQkh12/MXZTHyQj+y7pFXpk1raIiXrg7vW?=
 =?us-ascii?Q?j3+NiXvJ0pdJnN06uGjAorz1dQNT5sJuUsLTJFYuJiAx1JKKUGpsXrBHLvgx?=
 =?us-ascii?Q?N/IjsKRNEkfhnKgwUNXdqvfTYF6ecl5OL1XbrV2rCdTn2cEo+oAm+PuaYP2f?=
 =?us-ascii?Q?bbrK/9WO4oYrxSt/VozzerW/zAoZzT66MBdjdPABetnjt9rBfaiiUZA5gBQr?=
 =?us-ascii?Q?fq9RalIrV1rqGNJue7/xqD2JLy/FuCy+ojr+pqlCw+IjNqSZ0Pse1/IKqa/i?=
 =?us-ascii?Q?uirptcOqLodmn3bOQ6hy6AMOZVHoK2tpep3eBA9RRr51wxvQ4YJ55RXLfYLW?=
 =?us-ascii?Q?1fOp2aftXrG597W7lQdtDg6yldijb9HlujkE7sundC8ePGtP6fQrqJZyhZKO?=
 =?us-ascii?Q?49BeLtQRnXTY1NDpe0Y3yN4r2TT7XT0NtJvpVQkQ17+X08zedM6e9jQaiQQg?=
 =?us-ascii?Q?jYcTTRPHZ/+vOUzUyFUmVVSO4Qq3LIgXwOSsRc9Ubq8447RKpaZWKbqfJuT1?=
 =?us-ascii?Q?8S1gqyfmODhQO2j5Ktg/VyvKhAQe3KtcTPU9NGDejmQ0depJSQiA0itkSsid?=
 =?us-ascii?Q?mdaECYCQFqtN4IDKM/cbD3rhjLO3cUqjUaRP3WJNM5ACsibQ2Bvt49TADMlO?=
 =?us-ascii?Q?xvwRVBd/zRmr8EtMynv4+zUX+pGp76bdo951hA4Og2cc/ugwNxse/vxYA1ZQ?=
 =?us-ascii?Q?jgph4OfwsWorWnfqndDxXlH2rpP6rj+QQw4oYRcd1saTcbQ2+M0xhC580KYy?=
 =?us-ascii?Q?SR7Q6M57ZIlPFoy+CAXWyv7xzU6JoGTefLu4I63DSSCK0VD1aV7Q9LyhRZUK?=
 =?us-ascii?Q?+G5OwKXoAQyDQdHfRpnUeijPPsONRjmHdfBng2YWzyKsJ1oCR5GH9HAE+Zga?=
 =?us-ascii?Q?FznoJyz/UooXyteUN2lDnINi+G94+75if0e+l9aBj3anj5yt4EUvuPsDihEd?=
 =?us-ascii?Q?cAdnmgdzHPtFJLssixY1qUGCmBVVexZDK2HdCDSc5rKsc2+ZQUm+dbTEzFrX?=
 =?us-ascii?Q?ZRXEUk7cFo44COr+w4HGd14kVP9GTNtCsh8t9Z/QOkxg7wS0eh3vyioCSuAC?=
 =?us-ascii?Q?m0dqrvc4a61zIRvdQ+EVJKNBOXo5AnDTBgcHvSolUVl3PaFt26zy7QR+WokO?=
 =?us-ascii?Q?1PVnyopuMq3icKGTOC7Q6NP36HenyQbfrJBalGr4cah6lZQElXc5K0wu1fkE?=
 =?us-ascii?Q?u6PLl2ZhuHIb2HXypaEzeUo+ZYkhrnSbGcRmzONriPX4ThvvWjkb/K6KIzFp?=
 =?us-ascii?Q?f43gZetx3qrh/neVfLzaYI7VYqOhDH7aJrkhOq2w8H2ecQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00d2355-6edd-4f00-131e-08d93bec9577
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2823.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 17:29:15.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyyrzAXSgpvnScO03R6/fDMbPZX2eiumqiZ0lTvi7+grD5FfFye6teWCUzdF8WRMT5nuu6bkGNINLhMdylq+4NkC3tj3oXQ9o9f60NoyroA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4686
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10031 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300097
X-Proofpoint-GUID: 4S_k2M4_5Ya4R_JEIIsc-5uiSjm9ir8w
X-Proofpoint-ORIG-GUID: 4S_k2M4_5Ya4R_JEIIsc-5uiSjm9ir8w
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi all,

I've been trying to understand the behavior of the x86_64 performance
monitoring interrupt, specifically when IRQ is disabled. Since it's an
NMI, it should still trigger and record events. However, I've noticed
that when interrupts are disabled for a long time, events seem to be
silently dropped, and I'm wondering if this is expected behavior.

To test this, I created a simple kernel module "irqoff" which creates a
file /proc/irqoff_sleep_millis. On write, the module uses
"spin_lock_irq()" to disable interrupts, and then issues an mdelay()
call for whatever number of milliseconds was written. This allows us to
busy wait with IRQ disabled. (Source for the module at the end of this
email).

When I use perf to record a write to this file, we see the following:

$ sudo perf record -e cycles -c 100000 -- sh -c 'echo 2000 > /proc/irqoff_sleep_millis'
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.030 MB perf.data (58 samples) ]

$ sudo perf script
# ... filtered down:
              sh 62863 52318.991716:     100000 cycles:  ffffffff8a8237a9 delay_tsc+0x39 ([kernel.kallsyms])
              sh 62863 52318.991740:     100000 cycles:  ffffffff8a823797 delay_tsc+0x27 ([kernel.kallsyms])
              sh 62863 52318.991765:     100000 cycles:  ffffffff8a823797 delay_tsc+0x27 ([kernel.kallsyms])
#                      ^ v   ~2 second gap!
              sh 62863 52320.963900:     100000 cycles:  ffffffff8ae47417 _raw_spin_lock_irqsave+0x27 ([kernel.kallsyms])
              sh 62863 52320.963923:     100000 cycles:  ffffffff8ae47417 _raw_spin_lock_irqsave+0x27 ([kernel.kallsyms])
              sh 62863 52320.963948:     100000 cycles:  ffffffff8ab1db9a handle_tx_event+0x2da ([kernel.kallsyms])

The perf stat shows the following counters over a similar run:

$ sudo perf stat -- sh -c 'echo 2000 > /proc/irqoff_sleep_millis'

 Performance counter stats for 'sh -c echo 2000 > /proc/irqoff_sleep_millis':

          1,975.55 msec task-clock                #    0.999 CPUs utilized
                 1      context-switches          #    0.001 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                61      page-faults               #    0.031 K/sec
     7,952,267,470      cycles                    #    4.025 GHz
       541,904,608      instructions              #    0.07  insn per cycle
        83,406,021      branches                  #   42.219 M/sec
            10,365      branch-misses             #    0.01% of all branches

       1.977234595 seconds time elapsed

       0.000000000 seconds user
       1.977162000 seconds sys

According to this, we should see roughly 79k samples (7.9 billion cycles
/ 100k sample period), but perf only gets 58. What it "looks like" to
me, is that the CPU ring buffer might run out of space after several
events, and the perf process doesn't get scheduled soon enough to read
the data? But in my experience, perf usually reports that it missed some
events. So I wonder if anybody is familiar with the factors at play for
when IRQ is disabled during a PMI? I'd appreciate any pointers to guide
my exploration.

My test case here ran on Ubuntu distro kernel 5.11.0-22-generic, and I
have also tested on a 5.4 based kernel. I'm happy to reproduce this on a
mainline kernel too.

Thanks,
Stephen

Makefile:
<<<
obj-m += irqoff.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
>>>

irqoff.c:
<<<
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/proc_fs.h>
#include <linux/spinlock.h>
#include <linux/delay.h>
#include <linux/version.h>
#include <linux/uaccess.h>

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Test module that allows to disable IRQ for configurable time");
MODULE_AUTHOR("Stephen Brennan <stephen.s.brennan@oracle.com>");


// Store the proc dir entry we can use to check status
struct proc_dir_entry *pde = NULL;

DEFINE_SPINLOCK(irqoff_lock);


static noinline void irqsoff_inirq_delay(unsigned long millis)
{
	mdelay(millis);
}


static ssize_t irqsoff_write(struct file *f, const char __user *data, size_t amt, loff_t *off)
{
	char buf[32];
	int rv;
	unsigned long usecs = 0;

	if (amt > sizeof(buf) - 1)
		return -EFBIG;

	if ((rv = copy_from_user(buf, data, amt)) != 0)
		return -EFAULT;

	buf[amt] = '\0';

	if (sscanf(buf, "%lu", &usecs) != 1)
		return -EINVAL;

	/* We read number of milliseconds, but will convert to microseconds.
	   Threshold it at 5 minutes for safety. */
	if (usecs > 5 * 60 * 1000)
		return -EINVAL;

	pr_info("[irqoff] lock for %lu millis\n", usecs);
	spin_lock_irq(&irqoff_lock);
	irqsoff_inirq_delay(usecs);
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
}

module_init(irqoff_init);
module_exit(irqoff_exit);
>>>
