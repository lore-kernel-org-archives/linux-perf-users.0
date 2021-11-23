Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FCEC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 08:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhKWItz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:49:55 -0500
Received: from mail-bn1nam07on2046.outbound.protection.outlook.com ([40.107.212.46]:15252
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229617AbhKWIty (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 03:49:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2KBuh17fPLbKX9/uX4/lhdLlY3KuH2lTzA43lC/rznNVggts2v4+QTg4bprvGg7BQ63Uxo/jHxxWQWpQTYjysaajsMHPt0KQLPpyAkSFW1qpcS7EaV+1HcvBH09x9efNa7pGhrlLwvXsEbQ6bmywfA27xr1wAGW6SZzDURPkAN7/HLwnCMA4+4OvW72C6iwZF2E72NsAiS1e3lV51ZFdGH+TqynGg+9MflrRQxhFyzdYKxvzkNwTCWYGEf/vNdHypXsvJUfMDv2ZE+QyfMLutQF9sDVd/aqesAnzhGT6s/zzU4ozu2YS02iFlvOF3CDnKVBabjca2PteB5VHN9o5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/eNIRmuBbt0biEKSWQoQy8qn4+mdumI1+XGorzSt8A=;
 b=Fi7GTzkmGTW7MELKtrDMODmItHiXlqC1Kw7tfJqdeAJJqvdd8MeQ0fSxk4OikWhY5mS4LNxhPMcKwu3HSMdDv/Nq96pNtor8i4MoYkxk+lG9PoLqv8G5Dy/mYUpHSGwXmeGmkfTMrsHMjJXYM2MGwBSaYLBq3Kg5n4HuYhXFZjkyZWgubDr6rTf7TnHQYzi67xx3jtSUBcq/C419L51JpJ6YlqOUluc07nabtks5bd4MQLK6PIS0ufEPLcQ53a72lTaGkG4qa6shjFvXIZl65nznMp10bzmI3bJ+BUOu8Z3ksDtLkQXhrLxfpkGndDxshGS5UIQZYAMB9ukS6pVUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/eNIRmuBbt0biEKSWQoQy8qn4+mdumI1+XGorzSt8A=;
 b=sOmime5v8yB0VuyBRf8XETmz5hmfiIKqvb1fVWk4e21/TKXQPAlhHDAKBMqpKv6S0ZRY1xs31QTa4AaC7emqD2b+8PzMQPkbRQOEY/iXfuwFEcaQT+zKNtFwwOnHjzmNr+3CbjZ9VgUtUeoT7DxjmwCg4v5pKjkHdYTQypqlqr0=
Received: from MWHPR1701CA0017.namprd17.prod.outlook.com
 (2603:10b6:301:14::27) by BYAPR12MB2936.namprd12.prod.outlook.com
 (2603:10b6:a03:12f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 08:46:44 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::f0) by MWHPR1701CA0017.outlook.office365.com
 (2603:10b6:301:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Tue, 23 Nov 2021 08:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 08:46:44 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 02:46:37 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <acme@kernel.org>
CC:     <santosh.shukla@amd.com>, <ravi.bangoria@amd.com>,
        <ananth.narayan@amd.com>, <kim.phillips@amd.com>,
        <rrichter@amd.com>, <linux-perf-users@vger.kernel.org>,
        <jolsa@redhat.com>, <kjain@linux.ibm.com>
Subject: [PATCH v3 2/2] perf/docs: Update link to AMD documentation
Date:   Tue, 23 Nov 2021 14:16:13 +0530
Message-ID: <20211123084613.243792-2-sandipan.das@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123084613.243792-1-sandipan.das@amd.com>
References: <20211123084613.243792-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdba0818-d413-43c2-b623-08d9ae5dc6e4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2936:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29365982865CF31BE94349C58B609@BYAPR12MB2936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NeTe4spbmJyjEkjmgwljVFS5LogoZA+8V0ro+5tpABDWzDVD2YR/sirJg8QsGd7AUTc9n8ooqzi3CqkkAiHC3pXBHEmwbpFqhGQBsxoUy+Z3F8bRxhM89WXGhZBjhGPSt35sAXRNAfKLi+oOTbNNuzPjdFMRyKUfsJx8AWU7unOQnDYGBhhKiGUSgiPo+hVmgUyP8px5x2QDb/dXV67gssPrfXP0UdshiSFzyTIPIxVSkXGgR9JQ6aAT+G7iCt1escg5fdrfRI+ixuy+tUEoUcc+a9QqW2UGR7JTpQvYuJCR4vNgNCxjYCjonDSNuhO1ND8D4yuThoTI5R5H/H7RA6azNBFvzB+P7lRkRTGpPA9ht2MyjXTCHBW83TmCm+4knSmHIZm8V982tZdJVn1S03d9YtfQmWbd5DQXHRauDxu6W+ZzD7WoeuUpE8+Cp2R3x/ymP6ftMyc9bUmQhlKqbG4L8uwJ+pgT/RtWz1lZbAWsQ0Iyiha6AzIs7TNklv4hwfjfefI2lefmVbJPFcmXlhng2x8dyJHGm52CuLVGZk1vA+3ZNqiziirh1qRD8d8LX6QEhvBFFGtfjUwy+csquvSSmWz3YRgVJWpqMtnk9WjnF6QmgPmuthU5QCD1e9rlsdU4shNohL6tRJHYREoCjY/o7kez9i9V9HtUCPyC+9fbUGCYYe67BQGBx4vFh2BwZpLqCUNTcZDwn6a6Nc6QBOtA7k9TNai7LPPcXHv8v6OMpdoUI/ZiJInbX4fJnarEQlprKjsp7Q4lciNhk/jTjpV9QgJLHg6CI+HrWMu9Esdf4NvWhgpKPv/FZa77YAtn/zFcc/D8iCcD9Rh3nFnDaFLagMrGREAddO1YlFbztw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(36860700001)(44832011)(966005)(6666004)(26005)(70586007)(426003)(83380400001)(5660300002)(8936002)(4326008)(82310400004)(6916009)(186003)(316002)(16526019)(8676002)(1076003)(54906003)(2616005)(2906002)(47076005)(70206006)(86362001)(356005)(7696005)(508600001)(15650500001)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:46:44.0135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdba0818-d413-43c2-b623-08d9ae5dc6e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2936
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This updates the link to documentation on AMD processors.
The new link points to a page where users can find the
Processor Programming Reference (PPR) documents for the
family and model codes corresponding to processors they
are using.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
v1: https://lore.kernel.org/linux-perf-users/20211119111234.170726-2-sandipan.das@amd.com/
v2: https://lore.kernel.org/linux-perf-users/20211123065104.236717-2-sandipan.das@amd.com/

v3:
- No changes.

---
 tools/perf/Documentation/perf-list.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index a922a95289a9..57384a97c04f 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -81,7 +81,11 @@ On AMD systems it is implemented using IBS (up to precise-level 2).
 The precise modifier works with event types 0x76 (cpu-cycles, CPU
 clocks not halted) and 0xC1 (micro-ops retired). Both events map to
 IBS execution sampling (IBS op) with the IBS Op Counter Control bit
-(IbsOpCntCtl) set respectively (see AMD64 Architecture Programmer’s
+(IbsOpCntCtl) set respectively (see the
+Core Complex (CCX) -> Processor x86 Core -> Instruction Based Sampling (IBS)
+section of the [AMD Processor Programming Reference (PPR)] relevant to the
+family, model and stepping of the processor being used).
+
 Manual Volume 2: System Programming, 13.3 Instruction-Based
 Sampling). Examples to use IBS:
 
@@ -96,8 +100,10 @@ it can be encoded in a per processor specific way.
 
 For instance on x86 CPUs, N is a hexadecimal value that represents the raw register encoding with the
 layout of IA32_PERFEVTSELx MSRs (see [Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3B: System Programming Guide] Figure 30-1 Layout
-of IA32_PERFEVTSELx MSRs) or AMD's PerfEvtSeln (see [AMD64 Architecture Programmer’s Manual Volume 2: System Programming], Page 344,
-Figure 13-7 Performance Event-Select Register (PerfEvtSeln)).
+of IA32_PERFEVTSELx MSRs) or AMD's PERF_CTL MSRs (see the
+Core Complex (CCX) -> Processor x86 Core -> MSR Registers section of the
+[AMD Processor Programming Reference (PPR)] relevant to the family, model
+and stepping of the processor being used).
 
 Note: Only the following bit fields can be set in x86 counter
 registers: event, umask, edge, inv, cmask. Esp. guest/host only and
@@ -348,4 +354,4 @@ SEE ALSO
 linkperf:perf-stat[1], linkperf:perf-top[1],
 linkperf:perf-record[1],
 http://www.intel.com/sdm/[Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3B: System Programming Guide],
-http://support.amd.com/us/Processor_TechDocs/24593_APM_v2.pdf[AMD64 Architecture Programmer’s Manual Volume 2: System Programming]
+https://bugzilla.kernel.org/show_bug.cgi?id=206537[AMD Processor Programming Reference (PPR)]
-- 
2.30.2

