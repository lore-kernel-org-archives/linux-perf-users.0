Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C6C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 06:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhKWGym (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 01:54:42 -0500
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:38496
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229728AbhKWGym (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 01:54:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkwb0wTmpQeNRMk6VjUzXV/9q9+CrWL4dqKquBjqXZIg0kJRGXyXavATjMOibeFJsFoc3CaNShDy5OErPhcdzokd8nBg4omdCls4PUW9ZsGjMrZuMWCj/biOprlCPcT2GVSOQMh++rtwDGAC/hH4hoDZ70s4874G0+/nbFtm6FOStwfCfJ6iP6IA1vA4gdOf0ZVl8ZTf0kz9+rnlmoBw9GmhGaTiLtoaclshWh1BE6NuHFsCXn+gHbUUB/5CF7VoDxF0Hyaek1DlMh4Tcq/VtNOmzBcTw/jIOpShYmG4goJRyvbSlmpIc2JYw44i+AeKKiTh2KmKrHsAMMVzKKniBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm0FxplMSwZLERDuzqXOB5qA37XuQxflfc756euF9ss=;
 b=iRepGSm/PWHwu/HoMFow2AmssCPp7KrdeZc+Bgg1D8yxZwnG9wDdSJFCHE+bwyhS4owh7rvIxcY30S7FbxabCqpyRkbkbd2KCGxOA1RNxe3TjxJSAyilkWXR/K7YolHnedlKIwhYp/74w84pyEXGoCQGFAupe+s2JOeuIBBGnPfe3bU3ZCdH9sl8+EemjZjJr3D2R8cHU39Glthpi1I0TuNlIQe59bnh16Kv/Qti/Z7v0y5IHxPPayTd83Drq3MHeXB2CxfLEnrxXSVUXUhMogA9EKsM4gDlXtXQY+frUt7DViH8wow7mKWHrLAzm8qcR/X/xEGQCniS3mdlfnFv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm0FxplMSwZLERDuzqXOB5qA37XuQxflfc756euF9ss=;
 b=AnOikIveMApWtisdOpKHEB2LteQDgydsxSmYXPw5ezCZEaaCG0lJ3ua2OLrbL+qdRyrVWDtywJdltzb5cRNkXqybjgvUuZsl1pJAw0LeUvnQn3soe6plIIZl1MDVfhM5vCV1u/NcGbPt51hAIBcJp4GgqVwK5e+fJ+pYJZI9eSI=
Received: from BN0PR04CA0116.namprd04.prod.outlook.com (2603:10b6:408:ec::31)
 by SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 06:51:32 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::fc) by BN0PR04CA0116.outlook.office365.com
 (2603:10b6:408:ec::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 23 Nov 2021 06:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 06:51:32 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 00:51:29 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <acme@kernel.org>
CC:     <santosh.shukla@amd.com>, <ravi.bangoria@amd.com>,
        <ananth.narayan@amd.com>, <kim.phillips@amd.com>,
        <rrichter@amd.com>, <linux-perf-users@vger.kernel.org>,
        <jolsa@redhat.com>, <kjain@linux.ibm.com>
Subject: [PATCH v2 2/2] perf/docs: Update link to AMD documentation
Date:   Tue, 23 Nov 2021 12:21:04 +0530
Message-ID: <20211123065104.236717-2-sandipan.das@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123065104.236717-1-sandipan.das@amd.com>
References: <20211123065104.236717-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdfd3fde-9989-4e3d-0711-08d9ae4daf3b
X-MS-TrafficTypeDiagnostic: SN6PR12MB4719:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4719DF5CFF8E33EED176EF808B609@SN6PR12MB4719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbVuRA6rmZ9w5YkexI635CBsaDof9ChX0dwZi8sRp9lc46+bKoe3/kecSjijreplElZMEZ0O1pxvLx97SRaHrGq5RykWUJI5kAMjITONxTbmNFkI+SmY1IwOoP5j02nLrPOdQurs7xr9rEerKKdBhXmrXHgZrWmZzARnjPlIiVY+In6C+G4IMccHWb4peFwAR5weJj+ZrdLLGn8tus6B1niZ35sat/cb879lanbmRsHk5a5SO45OUMtfcpcIhPJArrO/XGrCU2T+OIZZTC414EqdGGlgyqwudk4cpHwnOfKO9/Fz+1CShaF2O5Jtf5/wTBndBlpBpBFljE0HEHywfYq0rywBu13XeaC+CRVvaRDvzvxyi1+ivRcgm2q2U8SZSGltBgYn/Utcp4Rr98qi7zpGaDdZ6TmkLKh2ttJwWg2xgws5qEZpeMidz6W7WjsuTiEZ9RUX6w0jEYXA3MQP/BLc8fej8q1+oY0+30yxg9vwKJKjNVSUMteoO8jf8OWRW/gqkp7ASqRHDBwyVPtZ6A6JFVrDIRIdM2YydSzuB0mnffZIcx3Er4H90S4qlmTvu4RSMFmtBmuGczB2ajKxOror/0kjx9XXuxVth9sJek+c63+uWcGhqq5DhOv0rUZ7icDvy/CgZxfiXynAKM9F/pa/Zzk8Z/DaEc7pjWimMbWJlEzQIq5c5yUVdIJkTTOujqwK+SHrwz+ZaTkGFw5GPr1r76y6yWgNmUyTmsvk4zev38YefAawEGUU2J1prJsYRpSNtNaENfWMp267bggHihmsCtgWFOtIgKJ7oav0AiiM8Z/7OeQiwaixfVcfwCU/NCNjo4f5kYFfzJTfrGMmVf7AHtO+ugciu9eAC9ob1cc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(6666004)(54906003)(26005)(70586007)(8676002)(1076003)(356005)(426003)(15650500001)(82310400004)(316002)(36860700001)(4326008)(7696005)(2906002)(6916009)(81166007)(5660300002)(508600001)(8936002)(86362001)(2616005)(36756003)(44832011)(83380400001)(47076005)(186003)(336012)(966005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 06:51:32.4802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfd3fde-9989-4e3d-0711-08d9ae4daf3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4719
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

v2:
- Use family, model and stepping when referring to processors.
- Use the kernel bugzilla link for access to PPRs.

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

