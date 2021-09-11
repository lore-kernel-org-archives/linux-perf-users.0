Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C5EC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 04:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2EE611C0
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 04:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhIKEkn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 00:40:43 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:52417
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229559AbhIKEkm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Sep 2021 00:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH8ATSW76CPaTWkrVn06w/GBvZQRU3AyvxojxRx9VFBPCnwDInInCjCqxxSKD/jLsFcbxo1S0kY5Hp03eJwFaglLMLeQQdhn3ARVWSwqr0Y70mknaBr2oD0BZaNNg0pC8xjqHa94Cxriwcy/49dW4V2VyRrA56ZDe8tXQmPAOpQrJ+XeB3VEosfIo3yCZXtXxLV4pwrFDXL5rOngdPkh3qXYYJ3emQLhVcBHrIbZirDWcXIhCdR0EskP8gBIRbqGuMxjUewEPcJ6Hu2q5GwPJ+GKWnjDg+bgnjMyQK54pRqysus/sdQxNgLXoAepfxBWD70UnAuMkl6+ZqFQKb0Psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3g+E+Gu6rnhhOZDh617tYJptj3P12EuKShXz4ge4kws=;
 b=PguxLWK9WAxnh70+qWp4fVHPDHwOKznqsL7uIjawvcJzlRGkJzfR/20X6TYH8pHYE6ypVIr7Q3IdccnB3BYPpn2Qe3kVzYFdKQwwFLc2TjupXSL3jhNBmufsB2c55xi+xWQSIqICsApIRti6KFsopjiOWecFuV1VrMrsU9WaPAh1LffvhWsplamlgSMcLQeo/paZsYcZ4sfKVoE0P3f0/V8V6fMpnDxNFMSs/HQtFwnfaQhrFukwPy7X9DP5+frKgXBXwrcDIu/Teu2r6xqSQfCj8U4LWM3KR4PtxM/J6f+ATH1idixmH3CuOk4uEXwN6rYV3y9zATJO6luZODfQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g+E+Gu6rnhhOZDh617tYJptj3P12EuKShXz4ge4kws=;
 b=Ua0nDvW5jd0kGiPF78Lk2A3v6uhv8/V7BgmtPT7TbNk3Tv1+68ms5mqNxSJzrVABeFeZjY9bVjaPUZeNWV13U4acAQockr3k7IAPkng+vK4nqqnKVlqj/t1jJmgtGUOGfietA2LpnxG1oCfZCF16P+ThMeVQWpCauf2xBkYlmTU=
Received: from DM6PR11CA0043.namprd11.prod.outlook.com (2603:10b6:5:14c::20)
 by BN8PR12MB3058.namprd12.prod.outlook.com (2603:10b6:408:66::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Sat, 11 Sep
 2021 04:39:29 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::dc) by DM6PR11CA0043.outlook.office365.com
 (2603:10b6:5:14c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Sat, 11 Sep 2021 04:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Sat, 11 Sep 2021 04:39:28 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 23:39:24 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <yao.jin@linux.intel.com>, <namhyung@kernel.org>,
        <kim.phillips@amd.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] perf annotate: Add fusion logic for AMD microarchs
Date:   Sat, 11 Sep 2021 10:08:54 +0530
Message-ID: <20210911043854.8373-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911043854.8373-1-ravi.bangoria@amd.com>
References: <20210911043854.8373-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d945320f-de5f-445d-e5de-08d974de242d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3058:
X-Microsoft-Antispam-PRVS: <BN8PR12MB305835F6DAEBAD7A24FA4D93E0D79@BN8PR12MB3058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YDkUq87AmsqR0VmKEWOvz2KwpaM9+bBvJzEaQLaq+jRB3ugcpNCNjmSkdtY42tEjw/hw8EOlFEwdqoXpvmklI59pzjd0E+sjd/K91j0vkNQEXZQdmfsotyT04mXeKv2a3oB5KM1HXu9AiSlSi2jetuKjL674HYD4tEOAAOZt7LijVuwgM7epIN1Xr0l5mmHLaCnQPA+2vwL/v9MdxYaLDf1nuiJ5cU9+AdZBmALIhP+8Oq9IXb41V/tz0oFN2LVtYoC2h5xlgtc3X4jJT58f0QP+M+p11B/TombijpktBHlHzMJ18lo753vWd0e+yKNG85nEd4L3/F2/3/HDfCXq4aRWnWJC/s2Gpji5kObBkw9b1Dsta47oG7TIX4DQwIacNzAPNFg4rTmyTfNXMQQdI91WkT1J+QWYzArI8EApdNPSkaQ7dzpE6jiY/hdSZkwNt+GeDQwc18Wlol75AYkBo+Bjh1/dpijw5qfsWf6MKV7nD2RLRCeaT0qtcGsAwzH0QEH4EVta9bjCEUd2drbS9nrn69083omX1FPNxx1hU6hCGFT4S+lxDwuwHBbEr1Zy/3ylcr897AcKBYu2QZlVwvrE+yo4xdx8aGpckMW1T4cj+BcsejzlY6jDfPZxvWbetQq+EW1NQHWEmiO7lwYOIedua/kQxLLNw/NYxuEoBbfi8DgZxkZlSakH5ikTEA6hXuWymSF8BYzPs+I8NKJSGxhtqJvl9VJMZNCdm8+drf4NWnqjnCF6Dq2agHRLUvLJ7V2nJfeXF8cHpW+gUTr7ZWLTBpFjb8OBWMpZYLjHDGy+l+M2jdIXgk4+KxkahmxqIaURWeZkzPIBmxvnUGWXkTVh5SL+WVplw4bBLSlEeY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(7696005)(54906003)(356005)(70586007)(16526019)(508600001)(70206006)(8676002)(36860700001)(336012)(6916009)(426003)(8936002)(26005)(4326008)(6666004)(316002)(82310400003)(36756003)(83380400001)(81166007)(2906002)(2616005)(1076003)(966005)(44832011)(5660300002)(86362001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2021 04:39:28.7215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d945320f-de5f-445d-e5de-08d974de242d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3058
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

AMD family 15h and above microarchs fuse a subset of cmp/test/ALU
instructions with branch instructions[1][2]. Add perf annotate
fused instruction support for these microarchs.

Before:
         │       testb  $0x80,0x51(%rax)
         │    ┌──jne    5b3
    0.78 │    │  mov    %r13,%rdi
         │    │→ callq  mark_page_accessed
    1.08 │5b3:└─→mov    0x8(%r13),%rax

After:
         │    ┌──testb  $0x80,0x51(%rax)
         │    ├──jne    5b3
    0.78 │    │  mov    %r13,%rdi
         │    │→ callq  mark_page_accessed
    1.08 │5b3:└─→mov    0x8(%r13),%rax

[1] https://bugzilla.kernel.org/attachment.cgi?id=298553
[2] https://bugzilla.kernel.org/attachment.cgi?id=298555

Reported-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
v1->v2:
  - Don't store vendor id. Instead, directly assign function pointer
    based on verndor id. (acme)

 tools/perf/arch/x86/annotate/instructions.c | 28 ++++++++++++++++++++-
 tools/perf/util/annotate.c                  |  1 -
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 24ea12ec7e02..305872692bfd 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -144,8 +144,31 @@ static struct ins x86__instructions[] = {
 	{ .name = "xorps",	.ops = &mov_ops, },
 };
 
-static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
+static bool amd__ins_is_fused(struct arch *arch, const char *ins1,
 			      const char *ins2)
+{
+	if (strstr(ins2, "jmp"))
+		return false;
+
+	/* Family >= 15h supports cmp/test + branch fusion */
+	if (arch->family >= 0x15 && (strstarts(ins1, "test") ||
+	    (strstarts(ins1, "cmp") && !strstr(ins1, "xchg")))) {
+		return true;
+	}
+
+	/* Family >= 19h supports some ALU + branch fusion */
+	if (arch->family >= 0x19 && (strstarts(ins1, "add") ||
+	    strstarts(ins1, "sub") || strstarts(ins1, "and") ||
+	    strstarts(ins1, "inc") || strstarts(ins1, "dec") ||
+	    strstarts(ins1, "or") || strstarts(ins1, "xor"))) {
+		return true;
+	}
+
+	return false;
+}
+
+static bool intel__ins_is_fused(struct arch *arch, const char *ins1,
+				const char *ins2)
 {
 	if (arch->family != 6 || arch->model < 0x1e || strstr(ins2, "jmp"))
 		return false;
@@ -184,6 +207,9 @@ static int x86__cpuid_parse(struct arch *arch, char *cpuid)
 	if (ret == 3) {
 		arch->family = family;
 		arch->model = model;
+		arch->ins_is_fused = strstarts(cpuid, "AuthenticAMD") ?
+					amd__ins_is_fused :
+					intel__ins_is_fused;
 		return 0;
 	}
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0bae061b2d6d..b55f35485e43 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -183,7 +183,6 @@ static struct arch architectures[] = {
 		.init = x86__annotate_init,
 		.instructions = x86__instructions,
 		.nr_instructions = ARRAY_SIZE(x86__instructions),
-		.ins_is_fused = x86__ins_is_fused,
 		.objdump =  {
 			.comment_char = '#',
 		},
-- 
2.27.0

