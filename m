Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862C4C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Jan 2022 07:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447037AbiAYHp7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Jan 2022 02:45:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31520 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1446799AbiAYHnf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Jan 2022 02:43:35 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P6WwVL016199;
        Tue, 25 Jan 2022 07:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=uolXvXfAtrPI17ZPUJX6WpkGf5x0ZvpBwJko5sat454=;
 b=JTb0nH7QdmIfecqQT8BK35xRBaLf3Y0+5msHwBy0tdPul8ORx+IUPBGxJdt+nHED0Ec8
 9Av9iCpo8q5stLA9YF+pP013kinNGvj+7Xf/Vyy94yAjAlzOzeN2pyd1i/nk0Z14cry+
 kpOyrofKhCmubtThFNQgf9tiq/0Q8HibBcUzIANQbd69QNosaCjkuVRv/Me00m5JS8W9
 XcIQ+5UM40PWicceg9bBN2iFB4LwjH3Ci40hgkBAyXRu4LU80OJC1oeANdV9RmLutBqG
 PeYIau6/3fYw1JWyhFFpZS4KoVHE/JT94pNdJEGDOxhr4+mLkWKztiUFhvC3RW7s3p+5 dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfj6vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 07:43:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P7enqF186161;
        Tue, 25 Jan 2022 07:43:32 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by aserp3020.oracle.com with ESMTP id 3dtax5wce3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 07:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUG0mTl6qGHJhtm3xC+bDrbywzxvAWAVAEQ1Y+Sr+6AhXfEqSeusYxq8FEqtCpuXNuvsBU8QL3cWPE0Rk7EovGf0u1/Laxa/kS5cnJWpetEMvMBvAcD0rZ/gtIhMguKFi9v34OVtBbZ1WVg783NRTJ4ttCUlTBrBSqPQ80F//SoIEs2lnoNfF30NURLGhpu2i/PFEv5I5Etu0h+/rQfbEucGu/SxiQBUYdUeVPv4Z/Qk3bspKkSiVHUoNLIH9lMbEEs348a7Z3fXDfSiiQcs0FLFPnqZUtw8lN/sZaLqNvRA3r5JvRvZiH4iPi4exPoCPbzV5Wz21kz+x4U5ljwLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uolXvXfAtrPI17ZPUJX6WpkGf5x0ZvpBwJko5sat454=;
 b=W35C7EvRNYaUhbNVGC8H/bISehT4zU6PTTGQb4duuOEXWHGMBfznVv+Rt9osSghS3FuIrOCZnPQHmXDxGfdNwLz0j3zS9trK5en8h/OvjYK/5lVhqqQHKM8XIaGPH2rY7XDjyR9NBhxPLR+PY4A4ndF2dkDZxRMFrHeuEahDrqAYv7Tv2pTKD4zQuGxruoMBys6wASuTUTYmeFdip0xfGqegk4EAbSfMZGGU6H4JtdSQSDkN/TvbPLcGENdmWgawYOTeUwOJnZCPKCEJTIMj3kw1LlJGdqIpzeHy847IJhtemwbNpIv1/M1f1vNx2bk4GlKhbx5kufRmLJOUV0IFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uolXvXfAtrPI17ZPUJX6WpkGf5x0ZvpBwJko5sat454=;
 b=vP+mtXnQax9lnu0l1wh9fquYxkl+aW7rR45E8UydfGmLTdOXSTP3v1uZ3uEGTsy8si+Bm/JmR/QsC/+fhJ9lgkJgTLgVex5jdSAyJBB4qjhmNe1lnXHvGRIdsnAtBDP60WSQF6p5RB98WVPfd0ReLzF4YpRvhRCw2S/HfG2w3/k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4642.namprd10.prod.outlook.com
 (2603:10b6:303:6f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 07:43:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 07:43:29 +0000
Date:   Tue, 25 Jan 2022 10:43:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Subject: [bug report] perf/x86: Add Intel Tiger Lake uncore support
Message-ID: <20220125074319.GA3211@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0145.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7588978d-3dfb-4573-0cd0-08d9dfd66143
X-MS-TrafficTypeDiagnostic: CO1PR10MB4642:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB46420837D4664870025CF1018E5F9@CO1PR10MB4642.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bj/VkG7FDRHQVFsP87JqpU51O9QJxpo/c8P8RNuYB3ALEgB/lUmBJ7m3xZ1uf+Z8l5cvc7dDQxFSR1zvGkU5EEdno4uOe1z8TjCjSS/FeD4sAWxKoqiRBf/ozSi3tH97OPEEoleeo+Jd7tMmxrhX+rNQ5DhJZAKfe67sEVAe+2450VUWapcaRsd/AnxJXWBoF+p2qesNE2/byIGHYB0/eBoatqPbxadgjlZgkTM8RNf++IEodfPepnAfnDk1TwLEuMbVnr7lyiM60sWw8bPM6WYsoakgmW9eKBiVDDvRtp4Ix7WKVSZp18voCfTC39S2uWfuzijFccq0kFJ2cDXf3kdWDOKWcfA4QM8Kw1+quzQQTYFZgwbooUs4z2E9PLnB19uJd99ziU0umSfomEsG8KMUHWEUZ3NHHuovu74S4ci6/JMo9TsVOkVHwX5aheBCcaDiATt0A8INlD+8GIzy7YRwiPhhkaXe8Rqg0AyPHCPRApbgzihAfGkUHjoVTu3mA7PI0gwhJvYngNwiKFyAnQzHTRK/eD/1TrC49fdLwQNT206r0IjvbfTlvyVeX2mneTA3jyRqNP3XIx1XcsNLK50/ZsSezwGCeTDqiZ69gaQ6QMygOhtZiHHydHKe+ZY9Iic22U9DeT2mk7FU7vx10BMzGnRZBzfy+kaBPXPxPtkJYig/AAtSQsiWDwp4+D4SN+myIekmKkVjo3rnbp5fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6512007)(83380400001)(9686003)(186003)(1076003)(6486002)(508600001)(33716001)(66476007)(8676002)(38100700002)(38350700002)(8936002)(316002)(44832011)(66946007)(66556008)(6506007)(2906002)(26005)(86362001)(6666004)(52116002)(5660300002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5nJp9wEN37AxVYKsWdn6+tA3r/ijVmE+F26+r2l8ujluA9KQ88EtU/CedK6j?=
 =?us-ascii?Q?XwNj1CFc3EokXGM5VbpTwVV1rb6G+pL88w22p+sJoHp6kLXCT0S7GwP3zXkY?=
 =?us-ascii?Q?EFX718ApEK7zc4mrr89WX0nBnYXUq8Jzq1qNjTep3qngwk7+XzKW/wLME91C?=
 =?us-ascii?Q?SugkNVwVM5Gprkcl8+kDtoyQa+qVtqVadWr6XucQLN3LIR+02CmqydSn/iLF?=
 =?us-ascii?Q?EFRTZP0KDaCrsxQpKEUS3g++ENg09IEsVg8re5Siki1ksDmMkMmgvx0RYBQS?=
 =?us-ascii?Q?Zb8j0O9uqOgU5Xt9Jw3mT1uvVSw4nyQfGoEuWGGzL/S0gSanZGN9FIjJbgRb?=
 =?us-ascii?Q?5oD4Qnx8aYWD64+DAWaUlwYFXcBXkdL+rcQLcYwW/kUBkfyF9HGdRfFQt5W6?=
 =?us-ascii?Q?vDQ6C7vU+JBKftSNK+t8fBD4D07l3qUENtjERVMwKPMXhtnIuoc3la9z9p06?=
 =?us-ascii?Q?38Ga4VtTruxmOEQOiV7KuIlbOvOhv6PvIoy+qFjHaYuDC2H8esfeiGQt85mU?=
 =?us-ascii?Q?GpKkjf63QfRRbMLbV5YdZ08GZx8zkZfIYjo+uesdtf6nDw/T4DtgktHG0JeP?=
 =?us-ascii?Q?VmaUlvzjUgh+iZPjHoDxvT0YcrCThvRcqAYVXzDHHMHfVdJgnzWpj0C0sMbX?=
 =?us-ascii?Q?aM14T6LLyYhCg83gRMYWeHxYFdV+qa4Yt4PH267EY1572dKmIwQ3Ut4v5QF0?=
 =?us-ascii?Q?z4JyTI87LaZmniDYYhSUkWjtx6G/0IBX1/cHJuGwkNQjU2AsQ7H2D28raIMm?=
 =?us-ascii?Q?3X4W/diwszKJxm0ItI7NOWVC8ImN17PhpBksyJafFZB0MZCA58hOBZL7Gkfr?=
 =?us-ascii?Q?8INzmHnV4iu5X5jiG8+LrBcWjjr/pcMtCVuG5UwVAQzrO23jbA9qsQVzTLpz?=
 =?us-ascii?Q?KfrLCamk8/rSxvptsaSmalPDnmgVq3vwM+pgA1zXZF8lvxTJ/ZkNB+lsifDL?=
 =?us-ascii?Q?bRgXhX/iqpEIBcnF8/zFhyDGAhXECB8EITMFxxfYg4ciT77bLb7zU348iFnA?=
 =?us-ascii?Q?bIiHXpNJcfOUiGbnqfKscojGv0G5OOi7WGGggfSB9OadOy+sscvVA5QmkefN?=
 =?us-ascii?Q?SPF00vp58V5prMkot172LDwJDzUjsOpdas09NDzRFo9A8mRGP2rQu5Y3aEXC?=
 =?us-ascii?Q?3wEBP5dT41XPVDFV0DfLzccm6sFOMNZuNSmfFYwL3Lvu5eWXNxaOkRvh47Dz?=
 =?us-ascii?Q?y3xpOsLbfFn9cHDg4kJ1aed8qw69dtNNdwr11JpDuFdlysvIcwFjKouuBkYt?=
 =?us-ascii?Q?cPDCMqmR2Usz+ESKs6sScWJZL+XoeGb7koQOpBJbVhVLk5+locbax7Dn7wGE?=
 =?us-ascii?Q?1HI/TdXM50+NQVzJRkoFE9YtiUNl4zgXcyPZWqOTZvFIeQE9TVx1dqY/HxLa?=
 =?us-ascii?Q?bdV1jS5sVSMX3IOfUm3aGhc6yP1ie5eJDcNr5a95w9O3oGJ0gPd219HTDUbr?=
 =?us-ascii?Q?9JOE0+Ps6AaEmEGWN5roRurHbbOnzWcFMo8hESs35Y+1kCtjdpFZpMa9WSE5?=
 =?us-ascii?Q?8yHypXnPMf1/8npD57+dfJWyn7oKYa+vDEY2DdLZ7OFPFBVUhqdpRFV58CbE?=
 =?us-ascii?Q?lvwRyiQJRO55DMVkk1J3+i20Q4NNIYApDLG+icBnpncho48HZpkX+vPE23A+?=
 =?us-ascii?Q?Ionj3LcH94h63WZOmah5VfKWxYUc/V1yIUK7WJ9X5PQ6/uEjPY/2CLKQ4P9z?=
 =?us-ascii?Q?ld8zDnq/+TIG4ApIHbp/Csa2YOw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7588978d-3dfb-4573-0cd0-08d9dfd66143
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 07:43:29.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqPc5kZa9y0ZgwpjW3410PRi1UfVA8Ays53lW0ejbPO7Xx3zyRhQNFFQtHVmRzIh3Mw6mMH3TIofJhwYGELA5X5qIVLWLzZZcDd8F6v/Avs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250050
X-Proofpoint-GUID: M6OTosFBwJiuoz8FzgNB1Ojjr1pTmojt
X-Proofpoint-ORIG-GUID: M6OTosFBwJiuoz8FzgNB1Ojjr1pTmojt
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Kan Liang,

The patch fdb64822443e: "perf/x86: Add Intel Tiger Lake uncore
support" from Feb 6, 2020, leads to the following Smatch static
checker warning:

	arch/x86/events/intel/uncore_snb.c:1486 __uncore_imc_init_box()
	warn: cast after binop

arch/x86/events/intel/uncore_snb.c
    1465 static void __uncore_imc_init_box(struct intel_uncore_box *box,
    1466                                   unsigned int base_offset)
    1467 {
    1468         struct pci_dev *pdev = tgl_uncore_get_mc_dev();
    1469         struct intel_uncore_pmu *pmu = box->pmu;
    1470         struct intel_uncore_type *type = pmu->type;
    1471         resource_size_t addr;
    1472         u32 mch_bar;
    1473 
    1474         if (!pdev) {
    1475                 pr_warn("perf uncore: Cannot find matched IMC device.\n");
    1476                 return;
    1477         }
    1478 
    1479         pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET, &mch_bar);
    1480         /* MCHBAR is disabled */
    1481         if (!(mch_bar & BIT(0))) {
    1482                 pr_warn("perf uncore: MCHBAR is disabled. Failed to map IMC free-running counters.\n");
    1483                 return;
    1484         }
    1485         mch_bar &= ~BIT(0);
--> 1486         addr = (resource_size_t)(mch_bar + TGL_UNCORE_MMIO_IMC_MEM_OFFSET * pmu->pmu_idx);
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
All of these are 32 bit values.  If we really need a 64bit type, these
will overflow before the cast to resource_size_t.  This code is 2 years
old, so I suspect the cast is only required on line 1490 and that one is
correct.

    1487 
    1488 #ifdef CONFIG_PHYS_ADDR_T_64BIT
    1489         pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET + 4, &mch_bar);
    1490         addr |= ((resource_size_t)mch_bar << 32);
    1491 #endif
    1492 
    1493         addr += base_offset;
    1494         box->io_addr = ioremap(addr, type->mmio_map_size);
    1495         if (!box->io_addr)
    1496                 pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
    1497 }

regards,
dan carpenter
