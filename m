Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3660DC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 20:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199E36105A
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 20:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhHFUrA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:47:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40394 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231172AbhHFUq7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 16:46:59 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176Kk8ZQ023344;
        Fri, 6 Aug 2021 20:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=fFunPuY2T0CCMNWrW3Beombg2qQ3lFM91NLVaRj8D5I=;
 b=Ws9A88D2O2grwUn6NwFetJL5o1SJV+EWcPQmDuFYmH7pcjv1obwhPOg5mpEMhb28e0cz
 ZHsf7WmtNeiWt5fQMpvf3u6PqzdxFgjGf7FzfHFdoAP0TfE0ogyoyohMhxPe/LTWC6Xu
 UkRMa8UNIxw8qkPLHb4jE1x8FfOQ1tg4LiGr+43fwi4hVPj7fzBaWMoxTIABx9VtRBjK
 CK1uGWtVZzIWlRddr1ANhWpxCTe5Bb5G1vRjLKiKX7oCD64ozj64t296pbdHXYZvK2Nt
 s95oMWVLP8JVUYsKRHoZhxiR7s0xua01SmMocaRNngW0bK4SquXK2PH8tw0VUXIyrqGK cA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=fFunPuY2T0CCMNWrW3Beombg2qQ3lFM91NLVaRj8D5I=;
 b=fOWUNTTDOJGo9uVD8zVOOw85NZluiSL1Y8kSJgfmeMyILcdOcrCYGuyZhV7Anyqs0aKe
 NLTlUFs6NzugGzUc4WprVyiSQBChw4NybEH/Tv2pgpP2GV3ALBRWmaVx2glhNr0+QDDq
 Ta9g/EYj55bfvfSUAb5/40KV10/ArKQ+ajKnfcZfp5YhIWfK9KM11wzYt5ldSQyion0o
 S9509TV0cxYzls/vDI2BYekXCB/JTq2Pj24n2EbdICS6/eRJqyfrdCeMGlbJTv+sL3mD
 Ic8sR+e4zxeWGeI3GNy8HNeoDA6ITJsPtvmZuK6tl69Wsihnq2WQ/SENwR83eS5efD4C 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a8vy3t1ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 20:46:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 176KkKFf019410;
        Fri, 6 Aug 2021 20:46:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by aserp3030.oracle.com with ESMTP id 3a78db42v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 20:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1qui6jVpuh9z8yM3eAkcE5o+8GnsIRi8RkMaCwoz5shbASTqWi+gIBCp0l6egmeQf1fR/LA27Md94WyH0LsqvG3hJETP0MP45tKWF6Ut9WjgEhJkYEO5jHrOPDh5QNHCfsLpmfcAK45Lr56F1fHBfxmrIgIdVZoC0Hko80sj1Nat5EiQO2Rh7WFlQ/goPNXNQCj2tMn5OWjGcVmpj0YW2Li0sfguD4HMSacp45yk/OZWjX6I51OctjkshJ26otzPBl5cdXOGEnuFy+yxyA01x0btH7fyQh7rzX74uOpb+o7oGi2CmG1zkS8FeY3IYoJBHN17SGWFR6BW4Ze821/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFunPuY2T0CCMNWrW3Beombg2qQ3lFM91NLVaRj8D5I=;
 b=ejSa2pT51AyYBsuTapXJ8FNUzyyhzAXoBUNJdd/ADAnwrAPT1dI8MLhgdWMvYt/ooAv8Me9ZQAb/OmUxjGPDuk2IqB8/1WD5A1bN2LBf1QQl1plXtNfGZc3JSp3dJ+yxVSVX8RPG9tfBG+QU4o3MUJx5ftCtibbLsTZ2b80C4YxYt0L1hmCblxRqR1RF9DmrdDwAFQMzyROn7xr6jqi3yTreI7xw19AWcsR2XskLqRkdxyMGDhnT1GnFXB+bRNPzetUds18tKWvcopl+AQPZLRhop+1c0iUXsy1yy2xCrehYv0xJ6GOLlZRLIHjqR1SgWXcPflB30Kqo3zvxeP6b0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFunPuY2T0CCMNWrW3Beombg2qQ3lFM91NLVaRj8D5I=;
 b=RcNtKuSEUtcfLHaZYP1dUecV0otY30ffb3/3kfZ/2CI9Te5xLLe/8RwB8AdlKA1YambGJH+VF85IVG9dSKCmLlDcWdwUlzwPRCpF8au07t2rhAl4CSnnGOLQnYt23+z+HmnDvd3FMaStyzRizKI7OGDigShQN3WUSZFmv4VUngA=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5196.namprd10.prod.outlook.com (2603:10b6:610:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Fri, 6 Aug
 2021 20:46:14 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::7dfc:5c8a:aac:a65f]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::7dfc:5c8a:aac:a65f%4]) with mapi id 15.20.4394.018; Fri, 6 Aug 2021
 20:46:14 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf script python: fix unintended underline
Date:   Fri,  6 Aug 2021 13:45:01 -0700
Message-Id: <20210806204502.110305-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:806:21::10) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (148.87.23.11) by SA9PR13CA0005.namprd13.prod.outlook.com (2603:10b6:806:21::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.6 via Frontend Transport; Fri, 6 Aug 2021 20:46:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda21b49-ff70-4865-49a2-08d9591b3b1f
X-MS-TrafficTypeDiagnostic: CH0PR10MB5196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB519640E13D4BD869F1ADF101DBF39@CH0PR10MB5196.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?etkDXsbVfsTkuERHp+0ao7zHhrSwyvKKsyddefElkDyPE3r/Ex/1bsMewaOs?=
 =?us-ascii?Q?BVZsn50VGQDDNo82YWqFaWVZTJbWv/4V8UEKPvmwrMhxw8bRlOlAVCVrgxmR?=
 =?us-ascii?Q?OxdaXgJ4KrFHIB31Jt7uJq4Nx611ri7ddyr0j04CxIUxNNfeZW56e3pOcVa1?=
 =?us-ascii?Q?9HPXvvKQDbXRTEHCqGblJ2Jh62DOpWq6dccxeAIn/Vgh36MMUi37H4E4IIPY?=
 =?us-ascii?Q?74hozjpxBrKz46ouViR6hEU0C8CMQ9pT8xIaop5CIYOidcnIsDMnOUffmFn6?=
 =?us-ascii?Q?Gp8ZV22fgzdx/tiIOdPpNMaFQBY1o+H+soxDgm2Zr1xv+pQ0zqQqLPF2cW7k?=
 =?us-ascii?Q?H0GBjTk2PqNeU4NpGTcmwCyfFQtgbU5mbeg0gfupSYr0yV7W0XOXu4A8vaPl?=
 =?us-ascii?Q?A6q84t9bXkgYoveGYgT4soW5CUqq4vuDFKKUzVdL0hjd/Fi+XAkup/kJmN84?=
 =?us-ascii?Q?833A5kGXTJJE7p+6siyM6BDCPkWJIDM71wRBs1m5r89TocInXxKg1Upi9KMU?=
 =?us-ascii?Q?iYUQfoZc0nkf8MLzDgF8EdAZ6QuKKoW04JgL1vPtSNcvJ5OgFwth11cMToQk?=
 =?us-ascii?Q?iyje7V1T9DeBJhgOff8cfsReVsHLkZ5ZruQJD7Nu/SKabdtK8hVzCl8gwngG?=
 =?us-ascii?Q?tEIGNWZ6K+y9JM2k4jYYLa6GUqMU081i6yDVcXTnKSWIcEV3ucNfuwk54f19?=
 =?us-ascii?Q?7xJ0aX46u1U3KdkT+asrpFnXtqTYpQm55mNJ92bftVs3Rx4i38Aw4K26fwai?=
 =?us-ascii?Q?QpKAFmO89o+Z2CVPflchyHUdzYee9lQm0GxtulZj/WqZl/k92bRTx5rPl1L8?=
 =?us-ascii?Q?Z3L+eWmrQ6rr8S1Mr6DanvsrncJKFPRbvDtJ05mfPViDZqePEtSMh9BYF9EB?=
 =?us-ascii?Q?nMpSyLPnGnwGozyreQg3LBfcMVl+hEuYongsfZl2Wn7sii+TvY/oyl42cl7J?=
 =?us-ascii?Q?6InmJK0CEPdNT1Cdmh9VFpjv1/hKKMQQ1kkMGSCEjXqLphlR838Leia7+y79?=
 =?us-ascii?Q?s9J3F3fhbdKoYeKa0RJcM/+DfS4E/+nCJN1EDj/Ig3LZqxk92HetMofudbYo?=
 =?us-ascii?Q?Vn/GYN7vGn/IpXUYuzbtetr+s2Y5yFKBwpcqajDQ2TzWWcOWednl613HiD3q?=
 =?us-ascii?Q?XeuZbbPh+0Em?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(136003)(346002)(376002)(366004)(396003)(39860400002)(966005)(478600001)(110136005)(6496006)(38350700002)(83380400001)(8676002)(2906002)(316002)(66946007)(1076003)(66556008)(66476007)(86362001)(5660300002)(38100700002)(6666004)(2616005)(956004)(6486002)(186003)(26005)(8936002)(4326008)(52116002)(103116003)(36756003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rgTJhK4Hidw5jCosEuvP6gVqeXrW2IwOVvMdayMs+FO05r0fPxeAO3jd2Znr?=
 =?us-ascii?Q?hhGt8jP8BzBrUmRIeLncmD3nW9QqcQioeK0iXGb7eb28Vi6f+mEbIfY0V4AO?=
 =?us-ascii?Q?DMpfHOuDTsoIboUYFTC5moBaJMBG0JiIrMuxgRLqqKQEnhb4Za1+orOnG7DI?=
 =?us-ascii?Q?LxeOBBeHFS3llIs1tWuUpvlg8IvB3Abycdr3iV98Hcd7bEUFC9Vk+DX1ke32?=
 =?us-ascii?Q?SJaKtq9VB1fkKAIrKFf64vbDCRKw0dyb1gQ7ELmKRfJpNqfwuS9Xk2q5dd9w?=
 =?us-ascii?Q?XRnCJUoGteoQf0d3rBGy5/AgyHPvWlITmPk5eU6dgeWrwPXpo/R+XKaNw36Q?=
 =?us-ascii?Q?wzbC9bAsKQL4/Lzyf0qOM/A3LpPQp8cw81zs86a4c4hiFoBkhpGXcVeyXsxw?=
 =?us-ascii?Q?JQX6BGqwC4huwQXDOv+yzbjaJgCjjI4UUFJf+8++J40ma1m/NMhlIUApGBZ0?=
 =?us-ascii?Q?1El1jXUbFHfzXEp4Kct56A2jOmzD9CYXdXq1tIOykc0tviRsDG2yr/BoB0kz?=
 =?us-ascii?Q?KomQaDMPuNb0i4s9rUEjrAnVWYeurWPQuneA3laESQPEQnHDihIik7fCjuhm?=
 =?us-ascii?Q?ISOPpvefHSkqxa1X3GjNn2/SjWIWO1hcnGOb0U/zOYKZ45WeLAPtjGWs20M0?=
 =?us-ascii?Q?pT/5MhwuerG2iOaOIKx4EnBO3LzRbiEBQE1cnyHBBkK/sBkuTD+CKMBZ3YGw?=
 =?us-ascii?Q?NWRx4kbVIqfEnVl5DUZZpMBdj0D02ZPPQi8JU9ZRMzqlX8TYA8F0JVpuSSRS?=
 =?us-ascii?Q?GTZNljhNs2ai/uBtWuDf0SSYahsjCZH4EWICz3E3BKxrqSpjMRYSFf/W7B0+?=
 =?us-ascii?Q?9Me897gS8Btvv3G8VHXMQVpaT61vlvtDyvNmXSlGUfwggbNSDbBNZcbGBQOC?=
 =?us-ascii?Q?JfnF/u76KtotRXjKv7Plrehh9mr1VLFz973oJVsqjP0feiPu/DTCEhQsjuBe?=
 =?us-ascii?Q?Hys3CEfbq6J+hzCM8m477JOiPN7DDDr2ZDz3fZvh4rNotyQa7EpCsNSy1L+O?=
 =?us-ascii?Q?Wy/uaMB1pHb8plWxan9ijP5DbfSpVW5jcT62saZFBB6NMkOQegUbMaF70PNJ?=
 =?us-ascii?Q?75gZs7pkka/GlJeQ7Jozq1IW8Zpq/ddEuXxp43wiwXIDj7t/rAcRCRt+cX9+?=
 =?us-ascii?Q?fpZVzT6o8c3ck3Uaz7Nv8eDx67iZpfEsTi2vPpjtJdNlBWB6ssA5DHS6T+25?=
 =?us-ascii?Q?B7LnZDGJxnirOV/5B4w11jaak52Eq2MeYsYJE0YJrlx0R4Wij3J1NvLQevWe?=
 =?us-ascii?Q?MLH4iD6qn35r3lzFcdU7nGrglp+dEp1zN28bKCdGOzlH0+2CtHFo/02iXv7P?=
 =?us-ascii?Q?Xfz0SyP3Z/3/Hb8sKsTVkG4N?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda21b49-ff70-4865-49a2-08d9591b3b1f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 20:46:14.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLokWLI89DWayFqBDAxEHehK0SDjL6cw0KN1ATK+yuElPaUW7iJxhwmTXJC0Wa4sCCfxR53fOJ/RxedeUH4n3waoyUVo/Z1h8m/+2Gq+LHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5196
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10068 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060137
X-Proofpoint-GUID: jJHEPC5kVtq8L7wZDeaVtA-gSbcqlsU8
X-Proofpoint-ORIG-GUID: jJHEPC5kVtq8L7wZDeaVtA-gSbcqlsU8
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The text ranging from "subsystem__event_name" to
"raw_syscalls__sys_enter()" is interpreted by asciidoc as a pair of
unconstrained text formatting markers. The result is that the manual
page displayed this text as underlined, and the HTML pages displayed
this text as italicized. Escape the first double-underscore to prevent
this.

https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/Documentation/perf-script-python.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 5e43cfa5ea1e..0250dc61cf98 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -167,7 +167,7 @@ below).
 
 Following those are the 'event handler' functions generated one for
 every event in the 'perf record' output.  The handler functions take
-the form subsystem__event_name, and contain named parameters, one for
+the form subsystem\__event_name, and contain named parameters, one for
 each field in the event; in this case, there's only one event,
 raw_syscalls__sys_enter().  (see the EVENT HANDLERS section below for
 more info on event handlers).
-- 
2.30.2

