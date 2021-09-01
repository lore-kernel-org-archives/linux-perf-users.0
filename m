Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A84EC432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 21:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1197860F3A
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 21:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbhIAVJ2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:09:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43980 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343826AbhIAVJ0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 17:09:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181I45tf008937;
        Wed, 1 Sep 2021 21:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Ux34rEi+oVVlTMiJ9LMJkt3ssy1Fz/sBcVLy0Xx3yLw=;
 b=B0jph2yG87PMEjljQnFdc11DZ3jBd/bca9YrC7Yy8i61WAlM6utrknM1L5U3xAc7bSdf
 mOO086nLe2Nt/3jBetNzneUxNAKOZWCR5wVxZ4IGblm0GbrhoV5anZsMgLfLopF9xvXl
 bkj799YLl9j3J+FgDpw8tmwGxozJNi52XlS3ekOUENLD1bSdQsjwhcR8cuxTmeIXBvg+
 asDF8F1GAsTE6m/kNYHFphNo59Co+BzuPPU4nQKjn/Yio8cz4Z+Fpo/Yx5QTWHYR5r6l
 8PbLLckR4ARVhbxSEZNKOOBQIBUExQQVAwMdCxVDgeN6cZkj/uD8udH9kE2B74Ph8avL hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Ux34rEi+oVVlTMiJ9LMJkt3ssy1Fz/sBcVLy0Xx3yLw=;
 b=owDGvKIVJz1IWsSzNB6ICOYCGO1Y2cWbgn1Bc3LQq8OX0BLScMgP0zW2UK8BABwStNUE
 ESj4U0cw6fPpx8rWbIGRSu2SxYkF45rPT4njLuiflFTgnLvcmrN9JJT5CTejNgLIpPBi
 hb4NLtq4hyudzUXXx7ZZXcUeua/u7ib5sW0YlkS/w5dusmEmAlVhbtmGi4fBQpg8garP
 IersZhwa8a0yp/prfIBBsm7EcyNeTKsmqNwU34EqwhHlH4JPLU1byd41q493XbWkJe6f
 YA88ulbORpD8DSsa0V+BuINToY3bQ9FkYLr29Hm3i5zg5rjU4CVo0sHUJTXQa6ztxZoj ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw0gjj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 21:08:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181L6PdK027409;
        Wed, 1 Sep 2021 21:08:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3ate04rppy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 21:08:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpqnNbIXBtGXjFnZpKKG6hQx/AgNv0v2mDfvAbDkXGPle94QnS/bWou7drJKRsapAL5QAA8P3hM4FX6xhKVGYH7NsYDr3njM6l67jUPJ0IOzbF5TUXT7hU4RndZA6FG5avpYyEcajiCdGPCAtbhvezopj3wDAYHaFG2TH/VfRxb2AQBTNdnQeohFFlBktT1zOVRnL7Jxoyyk+62ZYfusyGwTzY7OuR70O3hzaXI0Ij6VujElEHBqlvj+QiQNwz++eUtO0UOpQuZGlAM7wPsGAzA5HUUCicoowX8kbHCBk7HjygBtTTjBwQBoRCkpkx0Ob/JjU4ciBh1uyIBUj1ah1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ux34rEi+oVVlTMiJ9LMJkt3ssy1Fz/sBcVLy0Xx3yLw=;
 b=QTifDvmbkQC3kJtcDxZjiKIDsSgzpoTz7LRPfYvLGpQqqHj/fbNIstnm/aTZO6IEDsUwnxB/3gM9DTL0rmIawrEd8/yqaGPTEJ+zllwT7YgVeDOzxal8uSsq9DCdSy3oAS7amkD4I/n4pOR060XkS0a/S0LBcLMt/rNKE0HrQu0BAjxBo/AKkn9AW/SjJyduuG3oB4tYOghaywH8+nepT+ZuxbNUaxofP2hWtDAPfQ3Z3Y/3aQzK/NI8axfI0dBfkMFQ0qxNTP/XHdPSosnBpkUzFHywloNyXC6WrW6qUiRV143iPNaVVLFLPUgZ1Xscjv+Is3Jz7qu5e0VcGFpKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux34rEi+oVVlTMiJ9LMJkt3ssy1Fz/sBcVLy0Xx3yLw=;
 b=OIpKumI8UwXJl3CswhY+9iOAehsV9Cv2em4E07obdECdXZnG5tVaaK7MThueqpVHMbPCERf8+gxj3mZ6dn0pQufd6XHZ1p2rV+SooMjhUBlQ62ELJ7MvANRCHTM0pFTD/K8cUWUFA1hRBxae4t79D1x0Q+h/mAiwTLcotSPaz+I=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 21:08:15 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 21:08:15 +0000
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
Subject: [PATCH v2] perf script python: Allow reporting [un]throttle
Date:   Wed,  1 Sep 2021 14:08:15 -0700
Message-Id: <20210901210815.133251-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:806:27::34) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (148.87.23.10) by SA9PR13CA0149.namprd13.prod.outlook.com (2603:10b6:806:27::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Wed, 1 Sep 2021 21:08:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16c82270-6a3e-42c3-829d-08d96d8c9d76
X-MS-TrafficTypeDiagnostic: CH0PR10MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5211EA972C69A013FCE0309CDBCD9@CH0PR10MB5211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y+261XZeOQI6PZdUnZ6rMYiImfaKb2UFtk3P3t0ZVK/wytbmlztiTkMvnmeK?=
 =?us-ascii?Q?xa/18fZNtFqFb+sVFiX2O5b4qInNMnvMgmcMIXM0vZa9bSi4/5+WL6dDw7Mm?=
 =?us-ascii?Q?kTbKjgOswsFfkapsEtEosXhhPLIIJ/bB8QwN/BohVHfy0/awLuXRPFQrx/0K?=
 =?us-ascii?Q?HuSD+VvfupCA1sX15xYwT/Pz0Xe45tSlLLZFpEwJNF+dGuJd+NLBfPUXM1C4?=
 =?us-ascii?Q?NbuchggCiNCnqz3NAJo+lxq3U+qOGV3mRMRGAsaY1WlqCWUh+cCDppH81QDK?=
 =?us-ascii?Q?rN366sx9g4ZQxlepJ+Az2A0/03B3UDVG90Byeyc8gO1sAVWB0fKyWR6tXq2A?=
 =?us-ascii?Q?x2zEpkL5wr245VeQ3FlfCdjL8WDyerIyqssphR5+zoi0hspHoxHHGM003MXE?=
 =?us-ascii?Q?WlA0vn5UqrTNgllXHblaVMC36y/jfkBMzNX4OKLNCrbbylARBmyl/tWURKBM?=
 =?us-ascii?Q?hz4E68k0EO1BeRndtIUQbst6oRni5mL65oBPp1mHRFPux1Squ7yGQOYZUlKS?=
 =?us-ascii?Q?2S9kJ3HXZIm2XijfecpVI9EgAEWC2MosR3vf1lDWbN6XPIS2vnuDqMr9XRG6?=
 =?us-ascii?Q?cJLVV2vZ9vk6boZEMmos0dVSMqB08C2WtonZxReJQGvNV0ShVqcc7QUY1n/F?=
 =?us-ascii?Q?+uTNXumTHpBP8hLlavwZKIO1gQWKybsN2aZG/qUXLH8iA/jZob51WHnva+Lg?=
 =?us-ascii?Q?85+NnB6pvK51Or8t0hN3RzXxS0F5NW6SImRl74vLQ1+E4YzYJWQCnr2u3jNQ?=
 =?us-ascii?Q?iNj1Yvvc8DbJBk7ivznKUDgdnoz6NaQ+Ial0fYjyt2RqNYA+sodvxz9MX/nF?=
 =?us-ascii?Q?udArOB2js4YGA/vboBUjntZDa20/l90SJgWBzRu5NSFA+jNMmtZmk4JJR+ZN?=
 =?us-ascii?Q?nbUH+f7TWCuV+02c/Wf+afcFYAocaFH2WfVXUmVSlUfRg+u4NSapZ0Yw2m+F?=
 =?us-ascii?Q?ZTW7LeYvh7etKkO7oQ4GnM4urY/AAxx0Z2FUM0MzpOUbdK31gN5PI0D6id/3?=
 =?us-ascii?Q?U6J5zCMOIe4TXNk42Z6cYExNGb7g6LA5U79aH+r9ksocbGk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(376002)(39860400002)(136003)(396003)(366004)(346002)(36756003)(26005)(6496006)(8676002)(956004)(38350700002)(38100700002)(186003)(110136005)(8936002)(83380400001)(6486002)(66556008)(66476007)(52116002)(66946007)(103116003)(2616005)(1076003)(2906002)(5660300002)(4326008)(86362001)(316002)(478600001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hLSBNGIkc/Q+a65IIWYcTimwkGcPB//q+9DeHg+RW4Wgg3+SE9U2L72CfpW?=
 =?us-ascii?Q?RIwW49ss0j+8GI8sqktRkdIRfwce9KMEwKaH3uqS6HdeK+atLbEDuVzWXBdM?=
 =?us-ascii?Q?pfEBidOlVxPjr+XJMHiF7Xb3kWir2x9StNtxywXkHBJ1pZsGUHem3nPf/U3Y?=
 =?us-ascii?Q?m9vMeD2EAiMGYwHEBPKQjR/JWEFFyOxHJcMa/J1Jl6MAxSkucMOIdGfxQgrM?=
 =?us-ascii?Q?DZO396e0yaBENraNwfsnHJkMi3x0GVbpBXGrM+BYEedtrmAw8wYMBXQ2AI+f?=
 =?us-ascii?Q?lj/dWT4N24xB2KJFLTCZApEwwH9gaLVRtgFMB/h8/iu7L4jfOTuuQb4k32qX?=
 =?us-ascii?Q?fpPsAo7/ib6WVbPfyM4w9H3CAjcmIqIN1OAFX6vahfT/8DkBsPXVmllzbyXl?=
 =?us-ascii?Q?fcIdZGxnLagntHDbniV52qnm/HUMYcsaurR6W5cZqsVzSOQn7W3RQ8jHQC5W?=
 =?us-ascii?Q?SLRMkg9c8MogztFKw42Unr2KFkv1zfDMdKj3LNCSKF0rLCXvpME8RHzMjXRL?=
 =?us-ascii?Q?LhJxlsLyls2ryai7EI+JWs9idj4qmSKkwLJkCI3xk8jM1ofxMvJwprRKfi3g?=
 =?us-ascii?Q?9kMPxWUnMtPygDAXB6vsfhFOMU9wlmzItUQZdgJ4+7B4N6LpmDXpf3uIvxlm?=
 =?us-ascii?Q?1N34E7IZKLBy3SYQ7L37uuCtpg/3wFvqsYnvfMcuaTWzLWu6r0lCVEvhOypM?=
 =?us-ascii?Q?Y0MnLN6+JJUd/bQgM/wIBdOgRZpyEHNrHtxDdxVzqmrLrSLcuLXI0TaGXZRp?=
 =?us-ascii?Q?jASoqVk7YOVML/+bX5PKK3GdgvQCaJPa4Gqtsm+zC1ExLoQ7Ly/YoTTHRPHC?=
 =?us-ascii?Q?S5F0s9wcfwDGUv0cbery2u5fmz39F3GQF/b30XZ8fz3C45HAI9eYLEpOBKxG?=
 =?us-ascii?Q?l76CBJeSyn0yKAcwNjieQ1V77KsPc2FAZopOkD/hgI01ecOSu1aqcU7/v+JD?=
 =?us-ascii?Q?EU3zt6wnJ/foEWcvL7F499ZI4yWwVxhQh4f64aqa9SVf9k5qoRqlhPjciBhN?=
 =?us-ascii?Q?0hNfY1htjrVtoi4v7qHOzSlYqgocPXeofkUOl7WZPYu7EGs4KdxAPUDQmsaG?=
 =?us-ascii?Q?xmWalk3Ci9nbcvVInQQDlkcDqS0+3Ehpw72dwfB6p/Dk/TeZjKXvuO7Phj99?=
 =?us-ascii?Q?i11H/6+8LbIg0g9QiB8AG7ZIrf5KauV9rvnIZk4SEWuca45m7TFhEp8pe/eo?=
 =?us-ascii?Q?B7A9uPQDQV+h0LPWyyiF8oZDfT3mhA7wvbjxqBMGMwegoQsGpshf2E6pDgUt?=
 =?us-ascii?Q?lLwBbvjacv0NgXbH9uQ3uXCiR5diattxhjfFIhQiYer+4qu8sqU2bGcKBxWy?=
 =?us-ascii?Q?n/dlB/LsYskEN166EfdTDEok?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c82270-6a3e-42c3-829d-08d96d8c9d76
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:08:15.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PBZXuM1cr3/8bWWNoPs/J7OLYnYkLB39A8HzYclc18rdwoFlvjONqLVw8cmMcyI2qQXCSST9eTQvzIXontS34DF/hx/U4Zn5SVeHvTNTGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010123
X-Proofpoint-GUID: 9ICeD3x-A4cfRapEoXlKj8hAJWLDIAdB
X-Proofpoint-ORIG-GUID: 9ICeD3x-A4cfRapEoXlKj8hAJWLDIAdB
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_events may sometimes throttle an event due to creating too many
samples during a given timer tick. As of now, the perf tool will not
report on throttling, which means this is a silent error. Implement a
callback for the throttle and unthrottle events within the Python
scripting engine, which can allow scripts to detect and report when
events may have been lost due to throttling. The simplest script to
report throttle events is:

def throttle(*args):
    print("throttle" + repr(args))
def unthrottle(*args):
    print("unthrottle" + repr(args))

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/builtin-script.c                   | 13 ++++++++
 .../scripting-engines/trace-event-python.c    | 32 +++++++++++++++++++
 tools/perf/util/trace-event.h                 |  3 ++
 3 files changed, 48 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 064da7f3618d..072869a35f85 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2492,6 +2492,17 @@ process_lost_event(struct perf_tool *tool,
 			   sample->tid);
 }
 
+static int
+process_throttle_event(struct perf_tool *tool __maybe_unused,
+		       union perf_event *event,
+		       struct perf_sample *sample,
+		       struct machine *machine)
+{
+	if (scripting_ops && scripting_ops->process_throttle)
+		scripting_ops->process_throttle(event, sample, machine);
+	return 0;
+}
+
 static int
 process_finished_round_event(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
@@ -3652,6 +3663,8 @@ int cmd_script(int argc, const char **argv)
 			.stat_config	 = process_stat_config_event,
 			.thread_map	 = process_thread_map_event,
 			.cpu_map	 = process_cpu_map_event,
+			.throttle	 = process_throttle_event,
+			.unthrottle	 = process_throttle_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
 		},
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 69129e2aa7a1..c0c010350bc2 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1422,6 +1422,37 @@ static void python_process_event(union perf_event *event,
 	}
 }
 
+static void python_process_throttle(union perf_event *event,
+				    struct perf_sample *sample,
+				    struct machine *machine)
+{
+	const char *handler_name;
+	PyObject *handler, *t;
+
+	if (event->header.type == PERF_RECORD_THROTTLE)
+		handler_name = "throttle";
+	else
+		handler_name = "unthrottle";
+	handler = get_handler(handler_name);
+	if (!handler)
+		return;
+
+	t = tuple_new(6);
+	if (!t)
+		return;
+
+	tuple_set_u64(t, 0, event->throttle.time);
+	tuple_set_u64(t, 1, event->throttle.id);
+	tuple_set_u64(t, 2, event->throttle.stream_id);
+	tuple_set_s32(t, 3, sample->cpu);
+	tuple_set_s32(t, 4, sample->pid);
+	tuple_set_s32(t, 5, sample->tid);
+
+	call_object(handler, t, handler_name);
+
+	Py_DECREF(t);
+}
+
 static void python_do_process_switch(union perf_event *event,
 				     struct perf_sample *sample,
 				     struct machine *machine)
@@ -2079,5 +2110,6 @@ struct scripting_ops python_scripting_ops = {
 	.process_auxtrace_error	= python_process_auxtrace_error,
 	.process_stat		= python_process_stat,
 	.process_stat_interval	= python_process_stat_interval,
+	.process_throttle	= python_process_throttle,
 	.generate_script	= python_generate_script,
 };
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 54aadeedf28c..640981105788 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -90,6 +90,9 @@ struct scripting_ops {
 	void (*process_stat)(struct perf_stat_config *config,
 			     struct evsel *evsel, u64 tstamp);
 	void (*process_stat_interval)(u64 tstamp);
+	void (*process_throttle)(union perf_event *event,
+				 struct perf_sample *sample,
+				 struct machine *machine);
 	int (*generate_script) (struct tep_handle *pevent, const char *outfile);
 };
 
-- 
2.30.2

