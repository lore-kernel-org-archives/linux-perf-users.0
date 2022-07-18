Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F848C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiGRNPc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiGRNPa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 09:15:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F341162
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 06:15:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB4XYG029438;
        Mon, 18 Jul 2022 13:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=/8OcCPx82/UPzqR8jlJ+IFVwJdRaaOWpAvqUaZazEbw=;
 b=BGP1M7BNWNm7yfim0B34w7M6qaMQiJmKMs7ZnPkxqwl5ApE+/TeR//e9VECSdbi7TqP/
 ARkpSBlch6VO2yVdtces0d4LgWz+lvFxNTy2bo43qNWMKDQtphH38zGRAsY7/J/VWei8
 NFP89DBBwYFRrjqBiqfBu9cHNZd7WEG5G6EVqUyOylkj4dws9KVDiNsawNT6SPh5Ajrd
 LGfH1DrF7t71HEecs0AbcSUh1LFA9RKOn4p+A9Hq8uL2d/lHSbid35rr5N341QoDVPrC
 IBC/j7LP+JPoHzrE+SfdtPKi5j0ZouJVTYO3woaPMqdtDCVclI83GAq59JRYe4TTD943 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0ua1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:15:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IBuvaG002124;
        Mon, 18 Jul 2022 13:15:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hr02rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:15:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NraDLY8fJ023WmvMjqA4T22Vm63FLogweKD79FSGx6q40NS0ksIa2uHR+1QZnAxtMzWdFkk/IaHg2mfmUzLQnHIy2G1u4uPjwspd2MPsgmAxtxuS4ilBqDDPGnGEu/Sl7ZlJiM+dXo+DJXAiynLofAOEr0pP8N0a3BvV7MF34G44pXnDHhtYYZjH0LuoRFRifPlIjZi9UIS9CTTxm55cnPFOULNtqt3OTCvzVRpzgTtmjentq1SCAoLW2T8w+o0SuG8ABPfCPYGr6tkyrvWjPca1Zjl0WddsLuGRzlJnHGQvCgVqREwyzeoEObv2YaCCrjY1GroOSkLZAKCD4b5qzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8OcCPx82/UPzqR8jlJ+IFVwJdRaaOWpAvqUaZazEbw=;
 b=ckVzo/jf1JHAiLtbKTpGEMvt/ZDuS/EpqtQ0aIi85BGrOfrws4yBmVAGc213SjVpcvQp2K3R52upj3jSmrcLXauSgpNBUFfLCZ3BnoFqfg53xBcrCFU3nKFUvd0ILT1gcXHiw1O+wGlA3Wg3hLv2SV1HK9RZytqFYXyxjMAPNpHeb3Axly7YMlZCQ4cHrxFoBFNYPRYi7pvpoiTD168rHcV9AmthPJyXrM+amIN2ksykfm4cL7dYoPO+r4jcGbMYup18MQ/Q/1WJnw5Fzsh8uSWhrJEQ69LQii5nm7/pZyXDWbW2QiJJYM2CopGXjqPbyJ3YOayPSziaeK/mW3x6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8OcCPx82/UPzqR8jlJ+IFVwJdRaaOWpAvqUaZazEbw=;
 b=UvaL/YIYJ3OnQj5uV41xmNMBWdRRe5DrDaMlvXIW4uUo9jMUjIqgO9jDgnQsuvUqltMSpz17SnNViHZKxafr46BJcDH6HwrbEoIiPEB/mI8Ldp6itIXWcOYG/P5z66vE4/v2hdRkg9fxNLP4xmSKGAxh8nQTI4CeTetZbrSeOGo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3196.namprd10.prod.outlook.com
 (2603:10b6:5:1a5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 13:15:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:15:19 +0000
Date:   Mon, 18 Jul 2022 16:15:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kim.phillips@amd.com
Cc:     linux-perf-users@vger.kernel.org
Subject: [bug report] perf env: Add perf_env__cpuid,
 perf_env__{nr_}pmu_mappings
Message-ID: <YtVc3cwnlxCWtyEv@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe401703-653c-4589-e49e-08da68bf8ff9
X-MS-TrafficTypeDiagnostic: DM6PR10MB3196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiEnpbG8PmEfziFnoYATGJxTFnjKkZPxNHWeSsnIDs4lOlH3ATmgw3yq3TFH06Y4O+AbjwxYBdwKxtK/O4aOCE0Dt7C0h7Ez6pXmVpwlpss44YrVeJceZDyEnZLQKX4jdf60EP02nB97q+1PuJNkUxuOEcZtpUhUfsgoJtzbhYz0e8bxHxJXp6ezemh+vcudBiJZ+uq/85kObPUqKpuy89E/DH79MuBsROfg8vLLIX3oOCmgLA7KQp5h1Yi/kMf4Yjj52f8A/AF8Wi8/3A89nXp06igGF9lPMwHhxmmOqp9QzK9YvS4wQsTza3CmPqyZVwOrZHC6Q1+WUKhwYG7m6IuVuJKTGP1u5bqU3E8cTkcNQvFJczWpFG/P0W4PMLzRfzJor5dKIqz6p7Rn9g/p1qNpwQycXjIEnwNTm7jSTnlihwFi5zg+V34wlBoBm0zNi9XNhNEwBgxLbif0qc0iR4puWO39AbiVc5K4qZgaQ32DcBtsmvzo9NHfboBB0ajb85RkpUnQzbvOu7rTwf2FUIYzhVehr8oL1bYrlKTeVox8byJ1qVEhzSp9gN8DLAe+SUt4zV4BooxCOl/DCVFKK5zYfY9YYdtX5/eshYsMBL8uhJ5YEb5q6xleiJf/9xkUwkDfLMCVvtlzXC6B7cmvLra+3xJcAUc4om4XrAf0yWRjPLtk1nrzb5cjtL896+tEUEjO9VDAb2Jgdpp2UkrqIUrh8WY2O85LSFls3TVRY53vFnJHTk4z8jKVdOaqEb/olAz+ShiOWc120ur3ZQF7G20U+h/B1HgcRAm626iLLraBdH5oAHlStYwwGEETGdF/MYjzq619zRszzvcd6E1+D7cMtXfGPG29/rsA5bRoZxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(376002)(346002)(39860400002)(136003)(33716001)(8676002)(8936002)(2906002)(66946007)(66476007)(66556008)(6506007)(83380400001)(5660300002)(4326008)(6666004)(41300700001)(44832011)(4744005)(6486002)(26005)(6512007)(9686003)(86362001)(478600001)(6916009)(38350700002)(316002)(38100700002)(186003)(52116002)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GlDY1GaBx4UDejNC5EDVuMTlM1mMiWeZ9CNU3T2YarYmAZMmzZrMat2O2Jix?=
 =?us-ascii?Q?e3KgTtO+5rdQd83cj48SAkZHLEuPOxmMQlN75kAVj0kYvunDt1qFKxOIseO/?=
 =?us-ascii?Q?lX3CnnEVyO2oj9a1OQWzREYGgWuTbBLTshXmW6aiH9KDjS99RbsvHHceFG4I?=
 =?us-ascii?Q?zLzET6VIl5TKmotTa2J2hAhf/eN5bT1LqoYO99p4WteVTsVlsHvnztiHuUU9?=
 =?us-ascii?Q?7Z8MIbY+RjY5PX7if8wnERNFxf+1SaKnER08XHMImqjR6I9rbAJagsEU7Xch?=
 =?us-ascii?Q?pLav3ljkyJSCsdYpZOhOkkRiuNB0U7M+DLfrzxMgX8zo8HsUDaflmQxDt5yt?=
 =?us-ascii?Q?6VcCYxOl2S58Muo9FZL21SL1/hzRwRnmL2Hl1TPeX2HJbA2oEm0xcwSvFXv7?=
 =?us-ascii?Q?r3KWGrbWe0uWE0XmiSoExYfaMQFavMYmJoX0Huu4jpXCHPdgW3wWTpvbz1TB?=
 =?us-ascii?Q?Th9+zTei9cdbB9Pi/eukBQSmvvC5Tx5ynXt289ZRSLo43nqXo+zHYmK4STj3?=
 =?us-ascii?Q?qNQDrdyrQfhrrREmq6Z4/6g9U74LeVlW4WLXU04v/2vSwuHDydDLYcdaTmHj?=
 =?us-ascii?Q?OOm27PErWauEgB7n+XCcNoCQ/WQnp0389aWSIah8a2ySxhtCd1lQspVnh89k?=
 =?us-ascii?Q?N3YB/3r7PCENCsp4D5FSqcoqi+6n8V1zKnRMhlWcx1CZcIAEFKAHQJsjcZx3?=
 =?us-ascii?Q?+TMHz++DAZlrLWPaWymYQM1qXvtMqCawAMnNTEkmMDcGmRdcz1o23YggE1cn?=
 =?us-ascii?Q?ajg6hTpF+yCuEleh/RTlX80he40Y03reHoKrBLC33c/QN/SmDzi0+A52wfD7?=
 =?us-ascii?Q?0JTxmafBl6MPnv/YL4VMltX+uuode4Y13XNHkaRqA2ZjQgaBkmopS24F/s9c?=
 =?us-ascii?Q?C7K2YoAA/pvKo2aXeD6ULSxGW/0jStOKf9GDRagUH59/26JPjbp5CnjvMrdy?=
 =?us-ascii?Q?CTsskThyZQpF+qnsvIfnOrBq+5+yCXLLzIp+xiON/JJyL5DmCBDqEudcPL0W?=
 =?us-ascii?Q?GJrnuzyl29LPVMOJn3q2w2bScUwnCLavQqpAGcYC9kyq0MR7nFtSRKcOn/yx?=
 =?us-ascii?Q?GhP5bNWuZ5dT1zvbNSR6LsIW7rPesaYsUD2IIQIpP9jMDAXcUfUhHWarXz5P?=
 =?us-ascii?Q?OQuxqsn+dPvAoj1Xj9/Klwx0wM9YEANKwzSxh5emG3PJaKga+qXBAY9FXO69?=
 =?us-ascii?Q?88hKvGm9hL7mNcAv9uPcUjrnY3pdADnO/+jwbuI/ZGQQEiLfdE8CqguVptQ9?=
 =?us-ascii?Q?zE5BrSdu6SogCtvsCrCHvdj3VTEXi0X1hLu5hBW0b7xkA4/gE7+Cx4osIU0k?=
 =?us-ascii?Q?137vaSaDfWp8xg/F37CZWibajqcY9SIEF047JDuKOJYuATcudrMVQ6LH5b9H?=
 =?us-ascii?Q?qFJ0/rVOx0nw0fW5laxkTb0DKO38NKeA9RyNH+bkAu2vF7KsQil7tbOl0I/F?=
 =?us-ascii?Q?fZrae/a7eGT400YmojxsLm54y+whVLcFt71JtC3x+BXOt/FskbxepmWiXTB9?=
 =?us-ascii?Q?9MvgNLXe1lCj2wsvbJKYVrK2U0+3qs7CZN5OIRCVboZmHbirne3wqO8bgVVw?=
 =?us-ascii?Q?CL8RRglZczrf8MIed6AxwViAjALpF3ZaVzmy8M5Jrc3zColzYjdNY+rfkWIn?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe401703-653c-4589-e49e-08da68bf8ff9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 13:15:19.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/mppmfFZqIWWkBTY9jCXe5dTvAhj6+cVzZA3Qq88qosWoDqs6m1Yozc2hOZ+IR61njcYfnW/hMxL0loibqrDo7ohmRwXgYcCwSrNSYjpIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=809 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180058
X-Proofpoint-GUID: Uv5WL6MVnnbY3u-ra3urej2tVydQ40Dk
X-Proofpoint-ORIG-GUID: Uv5WL6MVnnbY3u-ra3urej2tVydQ40Dk
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Kim Phillips,

This is a semi-automatic email about new static checker warnings.

The patch 9fe8895a27a8: "perf env: Add perf_env__cpuid,
perf_env__{nr_}pmu_mappings" from Aug 17, 2021, leads to the
following Smatch complaint:

    tools/perf/util/env.c:467 perf_env__cpuid()
    error: we previously assumed 'env' could be null (see line 461)

tools/perf/util/env.c
   457  const char *perf_env__cpuid(struct perf_env *env)
   458  {
   459          int status;
   460  
   461          if (!env || !env->cpuid) { /* Assume local operation */
   462                  status = perf_env__read_cpuid(env);
   463                  if (status)
   464                          return NULL;

If env is NULL and perf_env__read_cpuid() return zero then we are
toasted.

   465          }
   466  
   467          return env->cpuid;
   468  }

A couple of the neighboring functions are written the same way.  I'm not
sure why they don't generate checker warnings.

regards,
dan carpenter
