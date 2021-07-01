Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7CC11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 16:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6300613E2
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 16:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhGAQs1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:48:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20944 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhGAQs1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 12:48:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161GgT1H005096;
        Thu, 1 Jul 2021 16:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=MYxUjWYOTJNnF10myiYekuhsx89snjPL2UD3i+SaeP4=;
 b=b3k6CO2saKBRXLXbq2+Wju8BP7nGUHMW5Mj7EFsxsW6gcQUOts5s5ddOTiBpiRJVwN2b
 bXyDHTjodqh5rFwmF1yzAvrCfpxFwNwr6DksuNrARc7c6vGROFdTzxeBvFwhEAT0ERai
 bmSa3NkJGZE9UdSVbma8bJO/oDAKuwaIZT6etXBuMLRtwV7fI8qEbjckAtoEuHffBV5q
 uLs2YkfhtN4kKzmQUJlUvIaWMZUSaM9WFWDqVo0cwvrEW2TBpDo08t29WPuph3BF0NTs
 hdnxmmE5CHIwPlq7LgNadhOAJwO0I+uOWIrFdZPGQq3QmoItrx8njvzXAoBHyW//LS27 HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gjrwkkxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jul 2021 16:45:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 161GeCv8140443;
        Thu, 1 Jul 2021 16:45:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by userp3020.oracle.com with ESMTP id 39ee116jb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jul 2021 16:45:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtHNPXMjBMQIS+3dB2BGHtI7U1rNgOyLC6mId2SNglqeSifSCsgijzLNfINtJdgR/kMJtgvd0V5gaehgj2+mhGjgjoLl5+gOKe5mM/OdBmf8NgvOEBAHSgaLlaOJSqxZ0Wvl9pNym9+PHySPU2IEGUl9s1GMSQs3G27Az6CDdza9iLqe4cvfQ/T5b8GQex954T0cB+FDEaSBNC5UDWDQEraqX77pWQaVFU7kwF0SsqOgcBgjSl+75UnMxWgOtCMwiix8aJqC6+j4fzTdSl6cPeFW318mpTbTO3gYnon0Vz1CWoMiXMo9h+kaAkIJrm0eydu62RkspkK4IJWoILYNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYxUjWYOTJNnF10myiYekuhsx89snjPL2UD3i+SaeP4=;
 b=Pv9Svry43cjO17iLtCtipqesHAEXfGxTZSFcnRrBENEqYsA77obe8qXuVrH3uo9fNqhp5jYvzCyLbVso8aQOUqMWVOaW8PLEmVJ3shtOSsu5vQHRatnCoD108HGnxEHDWO9v8k/J7vkp/U6i/JdGw5ksQgauKX77+xl4AxdwO/2lAZHw3fqdDPg1MlP2uKyEQ7DREnBOejBvSsUwGu9uD5NPIltTwLhZskejK5ETnGnFtDsZmYPNq9EWUvwBHMFZ08VUJqwoTJ22Cw54eFwCCnyXraDLFJ5aMr0eYR1NAPZPMvZXmmnJZ4sc4/ty9T2ur5K4NAxZ63b4vuMvhnBpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYxUjWYOTJNnF10myiYekuhsx89snjPL2UD3i+SaeP4=;
 b=H4qdzxRqyLsdovIUFbGaHOHf70QtRGtwylfzBuzf63llcSFsbiFG13b5BXdAQzHhCizCFPhj83GpwcRO2Bgg36jNRvATxATaIBcBLkSmFRiq6TBp0IUOfF84hovi6X0uG7pw4LlD4s5VZQ7jTz5G5SsL6MdKyhL7wF6SkWijozc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 1 Jul
 2021 16:45:51 +0000
Received: from BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::3574:8df7:f5c0:d412]) by BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::3574:8df7:f5c0:d412%4]) with mapi id 15.20.4287.022; Thu, 1 Jul 2021
 16:45:51 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: Perf loses events without reporting
In-Reply-To: <YN2a3pSvealjK6uR@krava>
References: <87lf6rclcm.fsf@stepbren-lnx.us.oracle.com>
 <YN2a3pSvealjK6uR@krava>
Date:   Thu, 01 Jul 2021 09:45:45 -0700
Message-ID: <87im1uc79i.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-Originating-IP: [2606:b400:8004:44::26]
X-ClientProxiedBy: BYAPR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:a03:60::19) To BYAPR10MB2823.namprd10.prod.outlook.com
 (2603:10b6:a03:87::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8004:44::26) by BYAPR07CA0042.namprd07.prod.outlook.com (2603:10b6:a03:60::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Thu, 1 Jul 2021 16:45:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9723025b-794f-4904-6366-08d93cafaf56
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4606:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4606623A49F10B65D58FDBFEDB009@SJ0PR10MB4606.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBRk0eJCHKK+qTBkKObqzx/FBGwUvvZtUSwL1VKLn3lmIaMwhijtuHauMhXRfbI7HB+kPIlrgmiRCgf/egh5t2Kr1lkOk8PsQJsaP2wxykbeFrJyx3HriPWftOzshLeGx1NN/HivrCSBeq7rDdmF8AC8CzPn3COE1iyXNkoUBOrmh9xEs6SRpbtaWvQoQAid0bYdbZuKfL7VRamkjyzPwP7tj5A5eLceP9EL9SjNeP3hI8qRizhujuubn9QC7SzDyG3czfntpBTvHPiaUfkt3RD8s+8d4zGC0B/rvO8NA5tOhoPY9a7eTojQl7YTGlz0Vll3bN0sFL+cLjzLwvnwpa/b+1piKOvgORRO2XYNNJeJ9cSca9Wf7tnJNdGRfVFkkfgJEbUQuU31E+rDzxJyEVfzUBYPgMYf/YBcdDbScrInMy3ax02Fj9qqC7YUjz+LpAR7WACSBNilfWIvhX2Ml4rVwyB59/31d92pVILk4K44M+ZvhMPzrktTtNK73yE3xduen6tjRLBnkXm3c3ArUczkCvyeyxJpF91uPRa4yVjfloCdSyVqOco/EHluAqAVFvL5G+qqmO8O+1u9TDq4yn3aaZUO969Y3sqbe7LxQi6zJes9pdTXe2vgP5e1mRla5BoKtEyivNgvvWqxs0nvvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2823.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(30864003)(2906002)(6916009)(8676002)(4326008)(66946007)(8936002)(66556008)(83380400001)(6666004)(66476007)(16526019)(38100700002)(6496006)(86362001)(316002)(186003)(478600001)(5660300002)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?spcGtuE3tWNTVatgvfrD5WJwF5+lp6mqKslhLSyoKSKVHgaOKvX4Pe4OLz4P?=
 =?us-ascii?Q?gheRR16XoQweolAnhgtlyAhQW/BFnMnLG+KIaeI0Jdw4Y2ZXwjcfXP3cE/Oq?=
 =?us-ascii?Q?uP/ImXD01G7JE8CAhFNA3xnFrucBXDhVbaH8CvRc/Whp+LJ7ZQmv7onUcvyI?=
 =?us-ascii?Q?m7y6sKnlWG0vXqnDl6vPhPg/dlsDuHryf5Kmr0ykXN1923ACfNig/mu4HXPw?=
 =?us-ascii?Q?7kae1UXoXYi1PKCQtIVTlrfS27agHq4eB5hXhCSXdAGxt8w1fVgsIaRMdgX+?=
 =?us-ascii?Q?fc3dY0Mri9BlYecnUXV1x2r3BK6cftkdyKdAMUm/xhbINeP7CUjYQL0ki/W0?=
 =?us-ascii?Q?/+p57qOUmjZ9CKLUmO9+eJFcgOO3Rm0uLcQDJpxrbit8sVilPqFHb8EE/8s2?=
 =?us-ascii?Q?1IzEYaMiS8BJcLsu5OuuTa6ExfkIM1YO2zP+uaKmSEwTgNhcxfzgn4Gciwul?=
 =?us-ascii?Q?NJMZ1bqNhIP9DtfjTfFy3jjvXR8bAKDP098EQtyW9C6iUtGtpJ+yfJPXUZXg?=
 =?us-ascii?Q?m8rn05qUPYtO9XBK/crUZquPJLtwXsajvwov/e/FkRICdWw3r7F9n3vbvL9w?=
 =?us-ascii?Q?KKFP4RUMP7KUGaIjxR93sEuHpiO72y/FURsExtEaF0rmW0rSPImc26r6SpRI?=
 =?us-ascii?Q?8z6LTC5KCTfVBFSWRpnDAbvGzQSmgKlGfsCRr6rF77TZpJZKYNYbw74vdTq0?=
 =?us-ascii?Q?8tCEuJeJQ8vRgpjxj0WiSSX0P5vUyPV1va0JBC3Xx6hoMMW+sgusZviPlpT7?=
 =?us-ascii?Q?fQqpZIbuOdn7I9qNXlSqDTAZPhQ54+QVrYByxnZfiWTaJJwZnC5A1sJQAvFZ?=
 =?us-ascii?Q?AohSIXLEWNYcD7ECTYc3tWCX+R+kcQMhjsRVprMnlVkI7UaYo/a5SqAuiPXO?=
 =?us-ascii?Q?netEQA2C+4O1FJDoz1m+Wgp1Fo0JVL7p1V12M1KttnVWAIK54J7qfTPhiwW0?=
 =?us-ascii?Q?gbqpwQAzkSSRpHCSXfcuj9Nug+BoXKwPQ2i5PvHS7EuL62guJa71Qn+SZz1y?=
 =?us-ascii?Q?Yah7oebQDJvI+PC4aRTs8rf7EViUikuSMcFaseL5uA1FjV5+h0I1YjMf3Apz?=
 =?us-ascii?Q?CTF8ZGZGjLEFKgoQfyDq0JtN6RPUgS9sUetv2VtsO/61jVxk2RDbqGl6Avzy?=
 =?us-ascii?Q?4ZpU3/KJhkizizi40Bp6EBCevG1yBFWSPjnvbUA/ty5Qn4obXcFMFkwOFnfa?=
 =?us-ascii?Q?DDaRvdciOqt6HxgSRWKzl5d+H0yRSLOb1clPbP7bt7595k5Xpexty35WzaWL?=
 =?us-ascii?Q?lryiAdS8yasM4Qq9o1R/YJl6HiENJwG/K9C17au5O52MgV0ftD6GtG/ZDxiI?=
 =?us-ascii?Q?lj0UA+GrD/MOWvACw9raqaAKfVNN5ZjUMhjHk6xM32lGGw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9723025b-794f-4904-6366-08d93cafaf56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2823.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 16:45:51.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCgeCm3eYXroDRhsT1ZRUytnwFn9/VmqG81q4372dYB+p9d5dyy6qHRVLhaWX4IkfJ3DK2Zi6mj/9qAw/Eqddh0XDncygi3MsRLod+Pu7cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10032 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107010098
X-Proofpoint-ORIG-GUID: sJc2bvTtIGpscUK22KVfSV-XdWUhb-Y7
X-Proofpoint-GUID: sJc2bvTtIGpscUK22KVfSV-XdWUhb-Y7
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:

> On Wed, Jun 30, 2021 at 10:29:13AM -0700, Stephen Brennan wrote:
>> Hi all,
>> 
>> I've been trying to understand the behavior of the x86_64 performance
>> monitoring interrupt, specifically when IRQ is disabled. Since it's an
>> NMI, it should still trigger and record events. However, I've noticed
>> that when interrupts are disabled for a long time, events seem to be
>> silently dropped, and I'm wondering if this is expected behavior.
>> 
>> To test this, I created a simple kernel module "irqoff" which creates a
>> file /proc/irqoff_sleep_millis. On write, the module uses
>> "spin_lock_irq()" to disable interrupts, and then issues an mdelay()
>> call for whatever number of milliseconds was written. This allows us to
>> busy wait with IRQ disabled. (Source for the module at the end of this
>> email).
>> 
>> When I use perf to record a write to this file, we see the following:
>> 
>> $ sudo perf record -e cycles -c 100000 -- sh -c 'echo 2000 > /proc/irqoff_sleep_millis'
>
> seems strange.. I'll check
>
> could you see that also when monitoring the cpu? like:
>
>   $ sudo perf record -e cycles -c 100000 -C 1 -- taskset -c 1 sh -c ..
>
> jirka

Thanks for taking a look. I tried monitoring the CPU instead of the task
and saw the exact same result -- about a two second gap in the resulting
data when viewed through perf script. I tried specifying a few different
CPUs just in case.

I've reproduced this behavior on a few bare-metal (no VM) systems with
different CPUs, and my initial observation is that it seems to be Intel
specific. Below are two Intel CPUs which have the exact same behavior:
(a) perf stat shows the cycles counter in the billions, (b) orders of
magnitude fewer samples than expected, and (c) large ~2s gap in the
data.

** Server (v5.4 based)
Vendor ID:           GenuineIntel
CPU family:          6
Model:               79
Model name:          Intel(R) Xeon(R) CPU E5-2699C v4 @ 2.20GHz
Stepping:            1

** Laptop (v5.11 based)
Vendor ID:                       GenuineIntel
CPU family:                      6
Model:                           142
Model name:                      Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz
Stepping:                        12

On the other hand, with AMD, I get similarly few samples, but the data
seems correct. Here is the CPU info for my AMD test system:

** AMD Server (v5.4 based)
Vendor ID:           AuthenticAMD
CPU family:          23
Model:               1
Model name:          AMD EPYC 7551 32-Core Processor
Stepping:            2

$ sudo perf stat -- sh -c 'echo 2000 >/proc/irqoff_sleep_millis'                          

 Performance counter stats for 'sh -c echo 2000 >/proc/irqoff_sleep_millis':

          2,000.83 msec task-clock                #    1.000 CPUs utilized          
                 1      context-switches          #    0.000 K/sec                  
                 1      cpu-migrations            #    0.000 K/sec                  
               130      page-faults               #    0.065 K/sec                  
         7,196,575      cycles                    #    0.004 GHz                      (99.75%)
     3,606,261,791      stalled-cycles-frontend   # 50110.81% frontend cycles idle    (0.29%)
         3,156,105      stalled-cycles-backend    #   43.86% backend cycles idle      (99.99%)
         3,399,963      instructions              #    0.47  insn per cycle         
                                                  # 1060.68  stalled cycles per insn
           655,974      branches                  #    0.328 M/sec                  
            12,880      branch-misses             #    1.96% of all branches          (99.97%)

       2.001346768 seconds time elapsed

       0.396201000 seconds user
       1.605213000 seconds sys

Since the cycles counter is so low, I assume that the AMD PMU doesn't
count idle/stalled/nop cycles from the mdelay() function call, which
seems reasonable. Maybe this is an example of frequency scaling? The
recorded perf data during the mdelay call shows no gap, just very few
samples that uniformly stretch over the runtime:

$ sudo perf record -e cycles -c 100000 -- sh -c 'echo 2000 >/proc/irqoff_sleep_millis'
...
$ sudo perf script
...
              sh 14305   683.219192:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   683.300989:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   683.383783:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   683.465580:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   683.547376:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   683.629173:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   683.710970:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   683.793764:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   683.875561:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   683.957357:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.039154:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.120951:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.203745:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.285542:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.367339:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.449135:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.530932:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.613726:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.695523:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.778317:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.861111:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.942908:     100000 cycles:  ffffffffb0b7a172 delay_mwaitx+0x72 ([kernel.kallsyms])
              sh 14305   684.978837:     100000 cycles:  ffffffffb0203d71 syscall_slow_exit_work+0x111 ([kernel.kallsyms])
              sh 14305   684.978890:     100000 cycles:  ffffffffb029d8a1 __raw_spin_unlock+0x1 ([kernel.kallsyms])
              sh 14305   684.978922:     100000 cycles:  ffffffffb04502f9 unmap_page_range+0x639 ([kernel.kallsyms]
...

While this sort of data (very few data points during a long period of
time) is not ideal for my debugging, it's at least consistent, and a
well-known gotcha of perf. I also double checked monitoring a single CPU
on AMD (rather than task) and saw the same results.

So hopefully this information helps narrow down the exploration. It
seems to be Intel PMU specific!

Thanks,
Stephen

>
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.030 MB perf.data (58 samples) ]
>> 
>> $ sudo perf script
>> # ... filtered down:
>>               sh 62863 52318.991716:     100000 cycles:  ffffffff8a8237a9 delay_tsc+0x39 ([kernel.kallsyms])
>>               sh 62863 52318.991740:     100000 cycles:  ffffffff8a823797 delay_tsc+0x27 ([kernel.kallsyms])
>>               sh 62863 52318.991765:     100000 cycles:  ffffffff8a823797 delay_tsc+0x27 ([kernel.kallsyms])
>> #                      ^ v   ~2 second gap!
>>               sh 62863 52320.963900:     100000 cycles:  ffffffff8ae47417 _raw_spin_lock_irqsave+0x27 ([kernel.kallsyms])
>>               sh 62863 52320.963923:     100000 cycles:  ffffffff8ae47417 _raw_spin_lock_irqsave+0x27 ([kernel.kallsyms])
>>               sh 62863 52320.963948:     100000 cycles:  ffffffff8ab1db9a handle_tx_event+0x2da ([kernel.kallsyms])
>> 
>> The perf stat shows the following counters over a similar run:
>> 
>> $ sudo perf stat -- sh -c 'echo 2000 > /proc/irqoff_sleep_millis'
>> 
>>  Performance counter stats for 'sh -c echo 2000 > /proc/irqoff_sleep_millis':
>> 
>>           1,975.55 msec task-clock                #    0.999 CPUs utilized
>>                  1      context-switches          #    0.001 K/sec
>>                  0      cpu-migrations            #    0.000 K/sec
>>                 61      page-faults               #    0.031 K/sec
>>      7,952,267,470      cycles                    #    4.025 GHz
>>        541,904,608      instructions              #    0.07  insn per cycle
>>         83,406,021      branches                  #   42.219 M/sec
>>             10,365      branch-misses             #    0.01% of all branches
>> 
>>        1.977234595 seconds time elapsed
>> 
>>        0.000000000 seconds user
>>        1.977162000 seconds sys
>> 
>> According to this, we should see roughly 79k samples (7.9 billion cycles
>> / 100k sample period), but perf only gets 58. What it "looks like" to
>> me, is that the CPU ring buffer might run out of space after several
>> events, and the perf process doesn't get scheduled soon enough to read
>> the data? But in my experience, perf usually reports that it missed some
>> events. So I wonder if anybody is familiar with the factors at play for
>> when IRQ is disabled during a PMI? I'd appreciate any pointers to guide
>> my exploration.
>> 
>> My test case here ran on Ubuntu distro kernel 5.11.0-22-generic, and I
>> have also tested on a 5.4 based kernel. I'm happy to reproduce this on a
>> mainline kernel too.
>> 
>> Thanks,
>> Stephen
>> 
>> Makefile:
>> <<<
>> obj-m += irqoff.o
>> 
>> all:
>> 	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
>> 
>> clean:
>> 	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
>> >>>
>> 
>> irqoff.c:
>> <<<
>> #include <linux/module.h>
>> #include <linux/kernel.h>
>> #include <linux/init.h>
>> #include <linux/proc_fs.h>
>> #include <linux/spinlock.h>
>> #include <linux/delay.h>
>> #include <linux/version.h>
>> #include <linux/uaccess.h>
>> 
>> MODULE_LICENSE("GPL");
>> MODULE_DESCRIPTION("Test module that allows to disable IRQ for configurable time");
>> MODULE_AUTHOR("Stephen Brennan <stephen.s.brennan@oracle.com>");
>> 
>> 
>> // Store the proc dir entry we can use to check status
>> struct proc_dir_entry *pde = NULL;
>> 
>> DEFINE_SPINLOCK(irqoff_lock);
>> 
>> 
>> static noinline void irqsoff_inirq_delay(unsigned long millis)
>> {
>> 	mdelay(millis);
>> }
>> 
>> 
>> static ssize_t irqsoff_write(struct file *f, const char __user *data, size_t amt, loff_t *off)
>> {
>> 	char buf[32];
>> 	int rv;
>> 	unsigned long usecs = 0;
>> 
>> 	if (amt > sizeof(buf) - 1)
>> 		return -EFBIG;
>> 
>> 	if ((rv = copy_from_user(buf, data, amt)) != 0)
>> 		return -EFAULT;
>> 
>> 	buf[amt] = '\0';
>> 
>> 	if (sscanf(buf, "%lu", &usecs) != 1)
>> 		return -EINVAL;
>> 
>> 	/* We read number of milliseconds, but will convert to microseconds.
>> 	   Threshold it at 5 minutes for safety. */
>> 	if (usecs > 5 * 60 * 1000)
>> 		return -EINVAL;
>> 
>> 	pr_info("[irqoff] lock for %lu millis\n", usecs);
>> 	spin_lock_irq(&irqoff_lock);
>> 	irqsoff_inirq_delay(usecs);
>> 	spin_unlock_irq(&irqoff_lock);
>> 
>> 	return amt;
>> }
>> 
>> static ssize_t irqsoff_read(struct file *f, char __user *data, size_t amt, loff_t *off)
>> {
>> 	return 0;
>> }
>> 
>> #if LINUX_VERSION_CODE < KERNEL_VERSION(5,6,0)
>> static const struct file_operations irqsoff_fops = {
>> 	.owner                  = THIS_MODULE,
>> 	.read                   = irqsoff_read,
>> 	.write                  = irqsoff_write,
>> };
>> #else
>> static const struct proc_ops irqsoff_fops = {
>> 	.proc_read		= irqsoff_read,
>> 	.proc_write		= irqsoff_write,
>> };
>> #endif
>> 
>> static int irqoff_init(void)
>> {
>> 	pde = proc_create("irqoff_sleep_millis", 0644, NULL, &irqsoff_fops);
>> 	if (!pde)
>> 		return -ENOENT;
>> 
>> 	pr_info("[irqoff] successfully initialized\n");
>> 	return 0;
>> }
>> 
>> static void irqoff_exit(void)
>> {
>> 	proc_remove(pde);
>> 	pde = NULL;
>> }
>> 
>> module_init(irqoff_init);
>> module_exit(irqoff_exit);
>> >>>
>> 
