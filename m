Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891E8C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Feb 2022 11:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376507AbiBHLcf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355791AbiBHLWz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Feb 2022 06:22:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD21AC03FEC0
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Feb 2022 03:22:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218Abxcj026745;
        Tue, 8 Feb 2022 11:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Ku+9YHpN4tD/uIB9mAGTwxq/jxfSKWCrTNqUDzDjeVc=;
 b=wTH3hlfNVK/e0KSCwhs0C9bH1niDZIjI+XJz30WmrcWwcSLoybLXmNBnfDbAUPmccKtR
 iNiuFXiyM7SJnGBiH8FCqsq9MYQRMRxqIta9aJho1yJDGsVtc3dDUN3qCZOj7jSfZhuZ
 Us2FdEJDdK5oUcCAuYQLNWI2K8aEA/JPN7UJ3t+tg8StvoJNlNbu6dIKx+SFQtRnH6ht
 7beS+zydlsdCvVS4Xapj9xxBRu2XOM0bWk5qbByR7Pp3dTvRYiISZozUzrG+WBZ6svCD
 ALwEExrRCpin3ozTp//AzULyr26laghZadAOWBl3+iwI/6TE74+QPocEOCrtTvfgROo7 fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3h28h10p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 11:22:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218BLX1X163615;
        Tue, 8 Feb 2022 11:22:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3020.oracle.com with ESMTP id 3e1h25xtg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 11:22:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5pE/WCEkrmS4jTU1UhteLtQAjfY0jw44q6yQAELVt7LMETel6MaM8kjfifi6jX/PF5iaw0yK7rDC41pY39svR5Ympb0XZ/kigUbfgIygnO1w1S+Ru1dtM1XIaXPs86A8B/6mVqKenCDg7GBNPPuwQRMBBRVcjfA5M35iyTpi9UKtGj11dMWFOk4sCyHmbbnswjeDxVPKFi53VKfo7B2/ROUE597oK6PKfe5sK3p9mjcPhwj6a9dFoq8nlLYyeHI1cz1mccbjH2wkXwRsrqmDW3IWl1w6vAG+vau352/bmEc3YMBCAlnn6kqSGpkcZ+EgimiT14oI+HsBuZ7nF2UHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku+9YHpN4tD/uIB9mAGTwxq/jxfSKWCrTNqUDzDjeVc=;
 b=nRKPwSxZ8WCjP97qPJBwyPThKKLI8NmOnVdy0+WtS4P8wkPPz6GW5tt6UPLzq/fHOyJZeXVZP7wRIowuTousC99Jur/N5UeltvYDpVgKOOsnwKEboKVdYTGTZR99uv5+sYXRfXGtGpUp7aLiTr35d6NKKBP5SK26VeiiucOnAyq1eaZWKYtiK1yMPkMnug2Jar/49IbZ1BlbWLZ+V1a8Lr0xwqWONYQ9qG/Yg5XKUpGsNrZroygCFgDYp7NFlEe54zGIrWTFpPZIyYOr7olBAIJt0piFcNm9RuZp1c3cTmoZCD6LR7IRpc3xMn69th/NKqRdqEZkTTv3ZnqjtcBOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku+9YHpN4tD/uIB9mAGTwxq/jxfSKWCrTNqUDzDjeVc=;
 b=htpGMnQ9qNFUCUjAO/L3XB2fHLk+FbquSCgwpuXRR0YiXJn5XmqYWNQFS4LOSFYNpwAJaFg/z6Djqo9eGge91+nR6dKRQw8Hm4N6d62Mc8OnRLiccZ1/8rHyWPBuPwcn0CHjT81bHnPnwN+qPiPk8fXSHjfGSw32fpDzWmTrFGY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1318.namprd10.prod.outlook.com
 (2603:10b6:903:29::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 11:22:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 11:22:49 +0000
Date:   Tue, 8 Feb 2022 14:22:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kim.phillips@amd.com
Cc:     linux-perf-users@vger.kernel.org
Subject: [bug report] perf env: Add perf_env__cpuid,
 perf_env__{nr_}pmu_mappings
Message-ID: <20220208112239.GA18799@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM3PR05CA0098.eurprd05.prod.outlook.com
 (2603:10a6:207:1::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85df8014-43e2-41f1-654c-08d9eaf556f9
X-MS-TrafficTypeDiagnostic: CY4PR10MB1318:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB131886CB372F86BFB06D7CE38E2D9@CY4PR10MB1318.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzkNaNLGOoUTEGoS3AgLF5KO3UY5Pvy24w8GiK/uO5i9j40RcCRuyo9Pl6Nw/4De4ry6ZJNJ7WIr5f+9ixEOHdqKw1u7+DqipbiEOdoOUksugIE1S22cfB8zi7sNQQ1rzRGMojgw/3ULZgsdvio1Gfqsf3bftdLzNQFbH73TcPZu33M4Btk36gVteYspHkTIhPYjrbWoS0wzKKMGedgAhqDYhWgDu9x19Pvs9KUcSq6pBB1O0WVlV1JuzOj7aYmrvfZvdh8H2ue5l9p50LrwIaGzd8vcfFZ1Bg9JkGKpwe2S1zFqOHMuLiId45c+TgV9dwflSCgO3UTgqrHgvGoivd7jOUd1IU6Lv/MEA9ZArxk7fjrCHNILIAgzu7tQiOx1ECWnRgEeJ8mzEOGAMEc64O5UTBVsYB/f5vm9w2KNBdPDc4mVA676F+WKxrKAG3VUsGZ/6CMzoQXsEJrYDdpBpk6yRr1+7kxOqmyE2xe0BZ0kyPBtYTjuNlad/c55433NtDS9itd9KEANPuwv7lqN6o0CkyB1aJrVgkfZHtZARTrPEwPdIZlz90eoPCFrHnyB0j4adM5RRNXAVTbYXp0zk1MYeku2ot9FypP1CuPkhmoPHq1U0Et8XS8CY4L0zO/Pf7DowAGBz8XPQlUALN64CqijssiE7s8GQUTdJjpnTcVeXem8E6F4blonl+5j+JB+QRjhN0FOfdqLVKT4PT1Ndw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(8676002)(66476007)(66946007)(66556008)(6666004)(6512007)(6506007)(186003)(4326008)(6486002)(33656002)(33716001)(86362001)(9686003)(38100700002)(8936002)(6916009)(316002)(4744005)(52116002)(508600001)(2906002)(5660300002)(44832011)(83380400001)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZJVQPGKq37MH7KltPSSyZiA3xFRgvUcTe19rSet5DzbMAqZoINRpLWnAwd3w?=
 =?us-ascii?Q?cSTid+KMmemLgf/dw0cRzCjt1TvnkKTRfJ5Id0tCMwQAzlRb7OG+o/M+O3kv?=
 =?us-ascii?Q?/xzfGgqTOyhAwFcoKRipPoDmAXcWmLkkyq/v5b7ukar4C+0WFnxL1qtANw1X?=
 =?us-ascii?Q?VCu3izIiVFK20M2Rsh1tVhdeyMdQsMBQUQ5Yn6BCW9Lq7YNXzEGJSViSEicM?=
 =?us-ascii?Q?/D7GxTztulKNbv2SgT53Pqahavae0HLz9ye5mKd93zcwA2kpx8AHANKlB1mG?=
 =?us-ascii?Q?9dL7Tc5kcFBNEwZgyXC9jWukFx+TSyH4TtLOQIITWVss0lSyNCfS/6mCf6ce?=
 =?us-ascii?Q?oIds79LlS5NJl4PHhTIGMVJWYwxjODCFdttF3NwSTZIK0pZDGKZQ9GV7MvY9?=
 =?us-ascii?Q?esxUFuwww3IjbQU1+vulikjJ1PujGVUqPg7apaM0T5bfM0G6IMOeao8dd87i?=
 =?us-ascii?Q?3QHKArmsbbC47Bmgmn5wnDOCTZQSRBWRqDUAK9gsozGXD+jxvSiMKRJafMr6?=
 =?us-ascii?Q?4fppBJVRZArX7PerGa8beAqw1FFk90hoCPDHZ4gCEhNAgFFWoJFxWfiugT2J?=
 =?us-ascii?Q?pgmlN+fhCriUhgkAwzc0kqbpIMN4wqheffQkK4+lDVvnQd2KeID4sB3/v96N?=
 =?us-ascii?Q?KrvHfJUzYXrMMlNJxtXgtqZUvePFOgXmbEnnPCVWxrbBL6itfxTeQkF57jvb?=
 =?us-ascii?Q?bwNzTPNPt7XYirQlSXlK+UGBfCZ2nqxs0f7CIdmUn5cbdQCauXzu1tuFxuvr?=
 =?us-ascii?Q?qLcIgluyNrZbggWavaEUuepPMIu8mRdETPj7BEg6+8PyZ2hotruoPz6wzBKH?=
 =?us-ascii?Q?KnUCAby4rfBEY3XX7MTibS7o33j90k6mSLBbB7SoVjqj0Jsm/5XQiZpEstgw?=
 =?us-ascii?Q?OH2fUpR4TEMcvFVHcr8b1EZc7DvOh+4+SYlSlaAG6NCSh8J85x/wbSPeZEMk?=
 =?us-ascii?Q?VzKihsH4KVK+2lA24xkXCJnNMAiatze2GNFasDjxw861F9WxHatLO7kO77I3?=
 =?us-ascii?Q?N5/oLuMdqI29yEYLbm/RRCwuMoQwxP4V4fMUfZHMa9/0P3DKIqtgEa7Wdp+f?=
 =?us-ascii?Q?Y2ml3jXwSPOqD/Q1iUSzEadOiJ+rj9YEg8y8tqlu72EaAGAbC5qhlsTk4TbU?=
 =?us-ascii?Q?TVrogAB30tVrzPKIV+cmCV9+Oje3woEvZRTq0udYtL8Hd/FHcQhgGJqPKZcL?=
 =?us-ascii?Q?wK55KvmlL7DX7UIF9kfOdCK2cwp19/TgikIZ+jdL10wkJQPz7VbyZjOKuYaY?=
 =?us-ascii?Q?6ejUkyZKVCyl3Wn3tZxEqV0MO9GYLVrKXZz+v2GR1gUe+ttMLRs0g+rBPrWq?=
 =?us-ascii?Q?bXvyxw1ZCGOhkbeZMRFtba0vUUTRbZIQQLWoUv5c8JnHHk2+v17fItQvKJYe?=
 =?us-ascii?Q?Zk0cf//CeyISG2JwhIQUZaNexAqjfh09LRUw9petn+sDb+8wlEfxE7GWf6Ij?=
 =?us-ascii?Q?LLFdos6qdKaybgttqZn6tSHpO4PfcJ8+lxgbkIaDOUt/oH92Hsha3EjmKeDj?=
 =?us-ascii?Q?v/fglEDiQYA2/JN/Yl9M9ktFVAISF046uDHprreZmFBau8256bNg/xWnN/+N?=
 =?us-ascii?Q?dqCRyExygGfnoTHuBNJi70qQt6lyYSqk7UJh/eZfQB1QT7QUQ4CLp36B0Taw?=
 =?us-ascii?Q?YS74Jjced7J6+/Abavm7FDGSn41zavFJrVbAmjwW/RFdV7EEsYLD5cxaX7zD?=
 =?us-ascii?Q?8a1utczcumQZLDIyP/lEiFK1nlIVEQ5L47n6S3NIT1YOyVOn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85df8014-43e2-41f1-654c-08d9eaf556f9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:22:49.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nH5nd1uLo59LU7tF8nRnHbnAZtBDTX8heMwvkPwQavbvm9HBjsC+Q4sAUVhD3ru39vGPsEuqb/uzfRZ3lvsiuT2D9Y29A7M5noD8fE1AN7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1318
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=872 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080068
X-Proofpoint-ORIG-GUID: eMya-IntI17j2JbhUEEgVxKhTmbvYxHK
X-Proofpoint-GUID: eMya-IntI17j2JbhUEEgVxKhTmbvYxHK
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Kim Phillips,

This is a semi-automatic email about new static checker warnings.

The patch 9fe8895a27a8: "perf env: Add perf_env__cpuid,
perf_env__{nr_}pmu_mappings" from Aug 17, 2021, leads to the
following Smatch complaint:

    ./tools/perf/util/env.c:476 perf_env__nr_pmu_mappings()
    error: we previously assumed 'env' could be null (see line 470)

./tools/perf/util/env.c
   469	
   470		if (!env || !env->nr_pmu_mappings) { /* Assume local operation */
                     ^^^
Checks for NULL

   471			status = perf_env__read_pmu_mappings(env);
   472			if (status)
   473				return 0;
   474		}
   475	
   476		return env->nr_pmu_mappings;
                       ^^^^
Unchecked dereference

   477	}

regards,
dan carpenter
