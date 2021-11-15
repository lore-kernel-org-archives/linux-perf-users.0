Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E9C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 09:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30E8615E1
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 09:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhKOJwf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:52:35 -0500
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:53672
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236726AbhKOJwe (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 04:52:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g23OsItLmXMGKwjED8jsi7nCjcHrIUoEwuO/cmgMbR55GHS+1gYm7DL3Jk7tGOeUAFlE+xpjehAS3QdyQ518wTDLtpESMjj+0ZJL9vwuzYlw5FWzRNrQ4bN9VXeamg+fEZ2zh7H9gc86GVKOxdfe5CnOrjQ2OZnWgKW/yyaocZBsS5BemlQdarH4wQzN0/Y4f7m8eLwjlCmc6QZS15U3kGn6C6yUPr186c1TfEE97t5YSLwxbHhYh3KPham9XoTK8Vxfe1yPcZ6+lRvYKKSjErgimpAtolNwFz5mZhrck1O1td/D5kBIDq+IUxf/3qSnByeLUu+2oik+ZO7bbUuE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kkos9xsCM0B4L5tso6htIqQQ1Vp7M6bAlCCI5NSxTgo=;
 b=SQ33q+Z1d2r4CgAwvZTSkihOFBBAM38K/WO+iHSFfjBabQcUh4ZLeFrjg++jplsQKpeczTx/vlwkLYmVZ5BCt2X7m99D3gcwzevnijb9/fUb2NYbxn5PIUGCdBbtEOS3hUNDZCKcUrYuud5oaT79sHZ2mU3kcTjkDa0kQURpkNmySOHJP7CwqyBpblD18wQAWSqrN2ZXnUBaM4+SjhO3DJAskGfPjR6Wp889lg4wq+vtxvlJXIna8PBO7qDs0yUZEFsGvmvJ7aRmZlVsWaVE5xwlar3m7a+IXIS+lCvlnIxyB2OXkELWxSB95artw1URd+boRMHvoWgUT8Mb1ErxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kkos9xsCM0B4L5tso6htIqQQ1Vp7M6bAlCCI5NSxTgo=;
 b=PKzXtnRxavSFy99hGGodYew7KNhcbX49fDvuKbRwWuBdmj8EZ9e4AuGo+rz7+Tv+IIn35LZqCcNHfFXbDYLVloCRLVApQ04XeCvVVVJffY9GkjY0H69/OB45l9i4+IW5SSg/9i1JbPnmsD2cPDBmGgUrvYXChDbJZWqp46NMv9A=
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 09:49:24 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::a0) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Mon, 15 Nov 2021 09:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 09:49:23 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 03:49:15 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <kim.phillips@amd.com>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [RFC] perf/amd/ibs: Move ibs pmus under perf_sw_context
Date:   Mon, 15 Nov 2021 15:18:38 +0530
Message-ID: <20211115094838.3359-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80fbd132-e78b-42b8-fd4d-08d9a81d3494
X-MS-TrafficTypeDiagnostic: MN2PR12MB4536:
X-Microsoft-Antispam-PRVS: <MN2PR12MB45362E33909FFC6D8A32F704E0989@MN2PR12MB4536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbNPVcgCNIegXU9VE/wH79Dgu1mNOgSz4qqoZ8zqUpAbPGtzxfA1V3R5dPedHF7diQOqETKtAfYUWYwS4/SWy2dPMESJbyMIQC/3lrMT6aXyZ8MTD387UmuO2coldadbJzmAiHLhI0CgT6VaumHKzjbEPtRiz3csOPmLNZycAOPQlqfxiYfSWyMgsk54v5LsaU/lcmhDIy1jfZTrUrpXr8Kve1LYyo62b6YxDDWjK+2eB/D+6ABTFZzmaBzMJNlkPLvKC08Xjv9ygi5huRFbzbHhuB2LvHt7CQSqmLYwCk3rJjMCbsYMuZOwYTmaQYxRubN7uOqZQtckpNRaEGapBx+EZ7uVv+C92uZXfVQyBBdiV3ED8+8DslXfWvHsu4qmkW/2T8jz0tt8nZ9TuYfXlFGduooMhKSUZfcbF1yS3KVO+G2TSHDFb2lYd+Mz7oVr6o2eUXTPuE4atU/70XVnBcwFfC87iwwlldYb/haAbwU0hIqxiuTqLuJQPJW78tAtSadNCmBBuoTdcuccosAc7bzRFqGMJ0aPVPYDwnGrunPZG8OYLvMEkUrS1af9ISuoya+uwm6/lLI4ZLh9OO+w5l2vn7oqBfyorPLhxWKMakqG0TMhLQYGzuu74hSA7e+DUryJbVkg1p+8brEO/zpEGbSI6yQvg97Fql/Yx1LvWk63As8aEklACC+jO+kwY/6VOyIgVgnG/8mFfscVis/RNva4fW4T0ppxTCsNnBJvrUcCR5U79pZoH2uDwU03OpMzs01jWXMBURco0xNKAbF+vDsRFL/6QaNsXS1hFJWuSdAsh5gTJi+mRtl9xp90nq5ZsQSSJ9MotwsdwZjkHxobzJS2t8AelrUHi0zY6LSkqzI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(82310400003)(81166007)(7696005)(356005)(70586007)(8676002)(86362001)(47076005)(36756003)(70206006)(8936002)(7416002)(6916009)(336012)(316002)(1076003)(5660300002)(4326008)(6666004)(2906002)(44832011)(54906003)(36860700001)(186003)(2616005)(16526019)(426003)(966005)(83380400001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 09:49:23.7774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fbd132-e78b-42b8-fd4d-08d9a81d3494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Ideally, a pmu which is present in each hw thread belongs to
perf_hw_context, but perf_hw_context has limitation of allowing only
one pmu (a core pmu) and thus other hw pmus need to use either sw or
invalid context which limits pmu functionalities.

This is not a new problem. It has been raised in the past, for example,
Arm big.LITTLE (same for Intel ADL) and s390 had this issue:

  Arm:  https://lore.kernel.org/lkml/20160425175837.GB3141@leverpostej
  s390: https://lore.kernel.org/lkml/20160606082124.GA30154@twins.programming.kicks-ass.net

Arm big.LITTLE (followed by Intel ADL) solved this by allowing multiple
(heterogeneous) pmus inside perf_hw_context. It makes sense as they are
still registering single pmu for each hw thread.

s390 solved it by moving 2nd hw pmu to perf_sw_context, though that 2nd
hw pmu is count mode only, i.e. no sampling.

AMD IBS also has similar problem. IBS pmu is present in each hw thread.
But because of perf_hw_context restriction, currently it belongs to
perf_invalid_context and thus important functionalities like per-task
profiling is not possible with IBS pmu. Moving it to perf_sw_context
will:
 - allow per-task monitoring
 - allow cgroup wise profiling
 - allow grouping of IBS with other pmu events
 - disallow multiplexing

Please let me know if I missed any major benefit or drawback of
perf_sw_context. I'm also not sure how easy it would be to lift
perf_hw_context restriction and start allowing more pmus in it.

Suggestions?

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 9739019d4b67..3cedd3f0c364 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -533,7 +533,7 @@ static struct attribute *ibs_op_format_attrs[] = {
 
 static struct perf_ibs perf_ibs_fetch = {
 	.pmu = {
-		.task_ctx_nr	= perf_invalid_context,
+		.task_ctx_nr	= perf_sw_context,
 
 		.event_init	= perf_ibs_init,
 		.add		= perf_ibs_add,
@@ -558,7 +558,7 @@ static struct perf_ibs perf_ibs_fetch = {
 
 static struct perf_ibs perf_ibs_op = {
 	.pmu = {
-		.task_ctx_nr	= perf_invalid_context,
+		.task_ctx_nr	= perf_sw_context,
 
 		.event_init	= perf_ibs_init,
 		.add		= perf_ibs_add,
-- 
2.27.0

