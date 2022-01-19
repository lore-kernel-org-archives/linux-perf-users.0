Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B3EC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jan 2022 13:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiASNhq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jan 2022 08:37:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15656 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230422AbiASNhp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jan 2022 08:37:45 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20J9QLED012909;
        Wed, 19 Jan 2022 13:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=UbPfO+QloSM+95WuVlKkIDL17TqMy6AIuk3CR2nNoaI=;
 b=aO7+yyvys3JjAJbpX+tWHIIIERR/Ka0YSfh8mRjsTAL6/WOA1baqKMYpNxop/nPi05Rc
 Pba3kiiSkiap8wcTEXmQsC/RY6Ws1bYLsvWGw59N9bNq+OISHA0PBK2PjsaggIn1IJWb
 Ymw/+H0q5izxtmfrRwzMmZlgsPgU8g5qXRVbkict3i8qI7JkwyQcDuTm0ZZAgjweVKXf
 aTZmjWfSsOMShiFSv6YsRKxECDrNRepQL2Wz+L9zEnCa/AscTfOxe5OH7o4QUUvyl7gE
 QEIOGUx6SLyRBzXc4Nw4n2KZw1UYbGCvK17eFJ2b/BMO9SKv+CnD8Oaa9S6sdT9GebtM eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q55q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 13:37:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20JDb7XL041321;
        Wed, 19 Jan 2022 13:37:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 3dkp35w2jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 13:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzgzB5IHNEe9nKU5C4D3ObzeWeDT2RDJLQtXMnjVHqVv7UCsn+dBpv1ErOvDZxk9D4q3WG43gspUbFqYrIU3+gEHGvXlHMZfM0Yu0N9CChWMT9bxF1Bfd2jDjqBf12ajGOPqrbyCr+1BxgriHYx1wekeqjo32ratZLjHgKUJ8CD+5f5nPWCJbzDiJnKQuJH6a6w9UoXl5Ua6xwQxOgtTKEMnbigEQcsN8DWa2BUoX7Atv06T4MmSJUCHBxdRZbf6bZl0YzS1Dre/hksHZeMZG2v9I17U+So2EiRaEyz8s1o0DoA9fOSwfy8o+7goxQsjhIshW1Kmsu5gKLwxuD4+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbPfO+QloSM+95WuVlKkIDL17TqMy6AIuk3CR2nNoaI=;
 b=L2CsXWWe4aRH59IGLtINjKwMUvoLSxGzGm/CPCSOES4K6loiNQ9Qt84TGiWsNiKTVUE9cp8BgSdNtjbii8Xju8GZm71hswK4ZvWxlblS6Ry/WKb6hGJnpdT147SyHff+UX36qCFj+elix5yi8znl1IexKm+1vCylvtxkmrYY67F5huKzxLzh79T6EOzAIQe2p9VWnTVsolNdrMVFntsm30AcU+JPJCqy+SCa854YOUmK8LRyJrPSa+jWDjVrxyEaz/eAda5BnRmyjWffIX6mfTX4VbvqnSgwdUc3s4+TOzcGWatVub1u5fJIk52W98DYRbTyqDX4ESmTC6vQLKs0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbPfO+QloSM+95WuVlKkIDL17TqMy6AIuk3CR2nNoaI=;
 b=mA2PvlM6m8yQfokTkpWkdZZ9lbyDTgDZzxPPPouT/5HMfePxn/5g5bkAwBlKE7kLst8aMQ9apGRIA0iANO0/SzNwWRoZqfuhqqAZMARn5e4FwfLGMjufjXKENkFWM9c1ZX8x+Qv6oZg82LM8sKhAt4/DKnLdfMEjaL3G7gOM30M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2308.namprd10.prod.outlook.com
 (2603:10b6:405:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 19 Jan
 2022 13:37:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 13:37:39 +0000
Date:   Wed, 19 Jan 2022 16:37:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     bigeasy@linutronix.de
Cc:     linux-perf-users@vger.kernel.org
Subject: [bug report] irq_work: Allow irq_work_sync() to sleep if irq_work()
 no IRQ support.
Message-ID: <20220119133729.GA14183@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0132.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d2333e4-7bd8-4574-fde8-08d9db50dcb9
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2308:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2308F139F267C341D07BDF2A8E599@BN6PR1001MB2308.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bde9M0sdWN44hN3MmGbi9bnbBtW1qzyGAFWEuYWBcsip7gKPRKnxLxZdJr77nKAuD9HWINkRJPJkVXA64g7bO3puLEtaJengfauQValJkdKAq6o7vC0TyIaS7cSkIKQm3ypX/eEk0wVniPuNTsZvfM4Z8VvB0mh46EAc1PxFGeT1YajtFinQVmatLgvGpIZi/bIE2NalyQHgMrpcAgu06nQVldylN+GEgW2DkhKWXRQl07BoQL6JRoKDluu0p6s/C6nTtgrtmyCcIuztIo84lty2xb4++TRypasxOr40kvcHx4z//0tGWw9mb2mLTBeMOQjgybvW2+aW0llUkLOmV/1GXbuuwWB7wABK2XhzaANRtQSAhkrHneOKILLPrZJ9Qsta45h+26LxkII+BdF/hn38IRx29w7dV7HcnKYnr0922sghVn/tVGtGBUcOcoFJDSJyJidfkDa/9Knh2TTsMFTCQNh6W5lKdCh0SvGWPdnt/gtPzIitSYYtwG0dxb80QFeGWUVLf46Ur4eTu1t2Z59YFH5fI/U4HleQmTq+9ktalQSuM/O0p8EM2fmH07KvwKzyIsANopI1ckPOFbPnPgPtA235MXMwrGWFb99VCT+dYoxS+ddY6Egcjq5Jznj9cbUHy4R5P80R66XZX7scU7Cfvms5PjTMjyjd+cFEu9YDPQ1320wu/351rPZnpq9N5M1ofycC130EEw95sKqJ3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38350700002)(44832011)(6916009)(86362001)(38100700002)(83380400001)(316002)(8936002)(6666004)(66556008)(33656002)(508600001)(4744005)(2906002)(33716001)(1076003)(8676002)(66946007)(186003)(4326008)(66476007)(6512007)(52116002)(26005)(9686003)(5660300002)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8B6KX081OQlSNVmeERNuR9gouVSE0YUCqVnpTcfEAOS1fGAEzrjQw/BStmT5?=
 =?us-ascii?Q?4QVITzP26aOcFoEuV7m+4dTnCmw/gMrv45t0kMSiu2K02iCqRo46zzEOFfTF?=
 =?us-ascii?Q?ieiEI2U4g2iGpfnC3eYoBTkMvEyrd4w+gtlZwQVIXd0CJWMrPE9Q45kpUDHL?=
 =?us-ascii?Q?nvoZ3gXYp7e9dtc9O9FaJ6Uyt89i8LzO2aE3HkTYFdprTMOhwELkll/M+tnR?=
 =?us-ascii?Q?LaeHSkCkE77ksr/KjP2BVpy+nqeBtqYYv94HXBIoqDWr5RhRMwg/n5TqyHC8?=
 =?us-ascii?Q?+hHw+LvYV2rOH1avyauXnELK5ToQpO6LXFABFGFp1JyylETxEGoLGINnl3QD?=
 =?us-ascii?Q?2fUnu8CdziBQqKXjPVGFTZ3Phq1qi0AVEMFixodtBkPShHsHseawmKfHavDO?=
 =?us-ascii?Q?X5I8NpSmFejLEKDUitZAx53/tiyRH7VFnZMxyQwb+Iig+5I0vk+7p7b9j1rQ?=
 =?us-ascii?Q?KTtBT2DMT2T9nIfmRvKh+vk0HIhhV4c9dNhy9QcqPuLjBL1/Nuhe5wI4SBQ8?=
 =?us-ascii?Q?7CKnGi+wc/Sd1cBakzZOpJ0bw/JGAtGzA2FEpRHeVogQPfXTSr5XBZskMpXM?=
 =?us-ascii?Q?XTfhM1tLjIQNi5BGcG+ZuFQzUPzTiAFKrDDV0Kz55CkCegC5l7G2HM4j0ZAH?=
 =?us-ascii?Q?nZk+sUE3ZIhvb1R8HZ6vtMfZogWWhtkDN5hgMSwUtRI6a7hL8gW/f/VWSDC4?=
 =?us-ascii?Q?9xWe56Cc4BYGBXMpc/YppRXL6Y38XxaKLTSwAi7m6v3WOkBrlIX1j2JpUNan?=
 =?us-ascii?Q?LqCKgAhk4pNLdAtZcPHuSm6L0EbSkB6BVPJg0CeTyCgdH1bKsRL8FlfsYPiL?=
 =?us-ascii?Q?D0Vc3+OrP+OHPU2vX91EAuZgvngpaMXW0F7BCLJS+h3uRXGl//5hnvwJ4XSX?=
 =?us-ascii?Q?4i6mCm9X4n7EdKPCdU9f62xFEYwZJ4R2Qk0k/60xzaK7q0glbVqafoKQhi20?=
 =?us-ascii?Q?GN+Cl2YpDSwt0SGJUCFGsVRNgPJckPkUqHVC1F+lgbrI3yLYkVXjnqUxMNUm?=
 =?us-ascii?Q?8SoSiknbDqaSqXTcZWZ2emeuFmFD58tyYGSIf6E1q2iRCCRKApCo1W/MChLf?=
 =?us-ascii?Q?Z4F+ghVKtNMoyTmMbFu3UfCj8Nr0A3C0CADCp7bL0PZ1PkxDypmi59KEgAbh?=
 =?us-ascii?Q?RcXwIqI+1qp8xUMjNdRxN1eIKzKktX0puf9/pGE+oi5Pc1QtiKdDA5jKXHJK?=
 =?us-ascii?Q?IGNtbfjdfQHNm85nuMZ/uyt5bnhP+ZeoOgxRS5GvO1KuAoKXAgKU6BeM52uv?=
 =?us-ascii?Q?bl65vPh1lE/13+Yfm2W9vEu2XQwndLmy9P2Mo/5C9YglhkgltoqpU+5TWiN5?=
 =?us-ascii?Q?jio6XpEIrZtKXRVhzdBIYPJmqEoHODrxYqvtWKwwXFgTEl6CAufzRin6M5pi?=
 =?us-ascii?Q?u9YRV2/re4EqVlpTAwMFKbl2rvccu2yWfe3gzvY3WMUmwRYmxO2cPZGrHc4j?=
 =?us-ascii?Q?Thmolrt8QM4iDpszCQPAMLJUoUO3vNt6GIeEeUbLiefUDoMHqOGdE1RQnEJD?=
 =?us-ascii?Q?FUiEpdaz8xIJhKFmr+uWW03ZtA+L+GiIvBsg+nO92JUKEp2IUmtf3uelCTfq?=
 =?us-ascii?Q?hnlb6pZejBIxFR4IaFjlGOVuspeZLdvRWn+i6cNeQDvGhm7dAw1Ne/jOvxXT?=
 =?us-ascii?Q?Rj/ALnDK5vB8BH8QPkcOotmEvCR515ztm2k4UU/0dXXTrVkCDNY+ZeL6X58f?=
 =?us-ascii?Q?4QeoHCEuD1zJeztIEnOULLbJe/0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2333e4-7bd8-4574-fde8-08d9db50dcb9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 13:37:39.8397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMOxkcB5e0Xy4lLuAKgRpmhFwXDxMGNGYk2VJd1pECZoDZgz9MAHaoh0a5MbPpGg1fgaP1DqgfVgVNd3N1nQpY4Nnh4wljeCMb1h0d8aOXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2308
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190078
X-Proofpoint-GUID: cTpPJQy30j_6NMKINwTp9oiSK7BFHgou
X-Proofpoint-ORIG-GUID: cTpPJQy30j_6NMKINwTp9oiSK7BFHgou
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Sebastian Andrzej Siewior,

The patch 810979682ccc: "irq_work: Allow irq_work_sync() to sleep if
irq_work() no IRQ support." from Oct 6, 2021, leads to the following
Smatch static checker warning:

	kernel/events/core.c:4955 _free_event()
	warn: sleeping in atomic context

There are two potential call trees where preemption is disabled.

perf_remove_from_context() <- disables preempt
__perf_event_exit_context() <- disables preempt
-> __perf_remove_from_context()
   -> perf_group_detach()
      -> perf_put_aux_event()
         -> put_event()
            -> _free_event()

_free_event() calls irq_work_sync() which can now sleep.

regards,
dan carpenter

