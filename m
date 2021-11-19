Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24282C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 11:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C50260F9B
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 11:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhKSLQF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:16:05 -0500
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:16128
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232004AbhKSLQF (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Nov 2021 06:16:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCFw/e/VGaLTEgW/A1GAp83SXZDv+9qa+bm0k9pXMGXDROI+s1uPcGX1RrwCWNT8Dn0Jma+vUTrZVrjN0xAGEhFt12LMdEZ72UFmUaMkWzOHmabCjpWP0FxIhfXsYK98SST+dwVW0/TcHt+oiYXTI3b9+tSYf5AoX/CrNybxb6i3zpPrqJi8L5gZ+0/9PvGRvviShfpRRlyDa3PLd0HdXLutfRfa4g8Oz4rWB7c3a1f1GdEs5n18IJsF8woUWf7hpTtgaPdctNsyF9sjk6stg+mClPRgYgiGFT5ACA/A8QXSC9bOgx+8ZkET8OvDFvCctx9nN7x5HflCQ218AWf20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/YgKcwpzzBal35Pyer5FlTK15sCoWsTV+4rStRfYy4=;
 b=Z5Ae/YXktkMrinZXtRE1nG8vH1ZSjIiw/wV7RG5Sb6/z5ka2dWBo0uLSXA6y7di2+xK9sunq/EIpl5RrH4URttFvuK+cADHxONsTFX12rBCPpna6t0L490HY30IYhKpgSG3QLI2hbrbCeTz6CX8O6A7vIwEM/J7Sddty4Zs5UlhBcAOHwz//513mQDcyCMvV2DLeFEGkBUc3wdLMrEKIfGyYMa6ekA8YdQmyT7BgqXNky40/a/s6QnhJB+UtFETkLOqyTsy0R5fZBluHZITKOTUIPxqs5OQefxpIaNmdAqnKX2ozD55LNiUj3T1pFEK7UZ/nhH2jEf7z/Vwc6q96oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/YgKcwpzzBal35Pyer5FlTK15sCoWsTV+4rStRfYy4=;
 b=vIW+lZejGsBP7kf9WZkxhOXLwXoMTGksGQXZwQ8JXdcwB8w3jBED0kWYkL0jmHLnj5MqhhW6lV4T0xqqahGnImB3tEEaDbpxOhyFoYqUGg6vEe3P/KWt9zJ0ohNgs9ff7y3lQWT5L9QEga2I24prk3TT9TrsD81qsGzt8h9i0uM=
Received: from DM5PR12CA0009.namprd12.prod.outlook.com (2603:10b6:4:1::19) by
 DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Fri, 19 Nov 2021 11:13:02 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::ce) by DM5PR12CA0009.outlook.office365.com
 (2603:10b6:4:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 11:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 11:13:02 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 05:12:58 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <acme@kernel.org>
CC:     <santosh.shukla@amd.com>, <ravi.bangoria@amd.com>,
        <ananth.narayan@amd.com>, <kim.phillips@amd.com>,
        <rrichter@amd.com>, <linux-perf-users@vger.kernel.org>,
        <jolsa@redhat.com>, <kjain@linux.ibm.com>
Subject: [PATCH 2/2] perf/docs: Update link to AMD documentation
Date:   Fri, 19 Nov 2021 16:42:34 +0530
Message-ID: <20211119111234.170726-2-sandipan.das@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211119111234.170726-1-sandipan.das@amd.com>
References: <20211119111234.170726-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8ebdb97-2059-481f-c095-08d9ab4d8d95
X-MS-TrafficTypeDiagnostic: DM6PR12MB4925:
X-Microsoft-Antispam-PRVS: <DM6PR12MB492520CF5F4E44E89CBF9C1E8B9C9@DM6PR12MB4925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gB6SEmgPxS7uNwQTgkXHfMMU0on9jQY3muukQy4KDaeoRMMxQ/gisKH4GdCxnpUqdNBVcudYHdALjNbKwtEYkkx60bVbdTA5yDRJXJn6Cm983XH3hnDJEKfwBOgFE11iOMBr9sq2PJkamMlI1lXmFRNCP/nGTDEIMbiYRb73qdvucIMkWR2q0jjlbOv9rjtAKZo/G8W3uYnBsEYaAKCCszSXbza0kVJe/nUlvwYV9TWzIHABwroUogKo2YFhx7YmlTm3iyU6ILLm2M4tew9Jf7qGSChpm24Ah2OZWb3JezGJ+vgJUhhPbJqFgPYDgB6WOLgY8i+/pMYuzP6Sa4W/q2GxFAa+tdQ7dQgTlZFJhf1yCGcc9HjrpkfSEyyHyE4pO/Najtu+AC+G5k9Xl6HLf0j6vXpS47jke4K+cMNYV8ZUq2AamBbExlcJpFHUFJJv1virIPFlQJd3XBn7kmPC0MReo7JfsNrmygSavK2Mmfc9YE1PNlPuXG9kPo5dpDw+v+w2qkrqLkhhXa1Pg7jSppwBEdre7Mf3CTe3sRRtmIv8aYMebf8wBjVpSfMyfOeGHVpRLOhu5ImE3yk/m3sEDtRrhAomHbIqXAVOZxNDOswHbjuILshOSFwCRAFuPn6hbUiJasPDeEeBslnJbX1wdGxuTdstNH68IdDJd5GZfNR5CScqWvMi4dJ7MVPHmHEL7NrY41Z8Y4kjr8XN+xXbpVv2A5s3fIFyyEu0xqmoyqdJjAqt9p6UCdVKVzBiy3eRvJUq1BMqpwmptu6xPil2N0q5+AWTIFQme1/Ht7yMy3oGZBwG2KE3YgDlyI/RKgqjpXGyF/nlsuZIFaD+HYQE9bY8lN/WzbEAvKit+C6YKxM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(1076003)(86362001)(44832011)(36860700001)(966005)(356005)(54906003)(6666004)(426003)(316002)(5660300002)(81166007)(47076005)(186003)(16526019)(70206006)(508600001)(83380400001)(6916009)(7696005)(26005)(8936002)(336012)(2616005)(82310400003)(15650500001)(70586007)(2906002)(36756003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 11:13:02.4719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ebdb97-2059-481f-c095-08d9ab4d8d95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
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
 tools/perf/Documentation/perf-list.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 9c54c0566fda..2f892a76c659 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -81,7 +81,11 @@ On AMD systems it is implemented using IBS (up to precise-level 2).
 The precise modifier works with event types 0x76 (cpu-cycles, CPU
 clocks not halted) and 0xC1 (micro-ops retired). Both events map to
 IBS execution sampling (IBS op) with the IBS Op Counter Control bit
-(IbsOpCntCtl) set respectively (see AMD64 Architecture Programmer’s
+(IbsOpCntCtl) set respectively (see the
+Core Complex -> Processor x86 Core -> Instruction Based Sampling (IBS)
+section of the [AMD Processor Programming Reference (PPR)] relevant to the
+family and model which the processor being used belongs to).
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
+[AMD Processor Programming Reference (PPR)] relevant to the family and model
+which the processor being used belongs to).
 
 Note: Only the following bit fields can be set in x86 counter
 registers: event, umask, edge, inv, cmask. Esp. guest/host only and
@@ -350,4 +356,4 @@ SEE ALSO
 linkperf:perf-stat[1], linkperf:perf-top[1],
 linkperf:perf-record[1],
 http://www.intel.com/sdm/[Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3B: System Programming Guide],
-http://support.amd.com/us/Processor_TechDocs/24593_APM_v2.pdf[AMD64 Architecture Programmer’s Manual Volume 2: System Programming]
+https://www.amd.com/en/support/tech-docs/[AMD Processor Programming Reference (PPR)]
-- 
2.30.2

