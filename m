Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8628FC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 10:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4196023D
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 10:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhIFK6o (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:58:44 -0400
Received: from mail-bn1nam07on2072.outbound.protection.outlook.com ([40.107.212.72]:49058
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240404AbhIFK6o (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Sep 2021 06:58:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9tX/CmJuKMMvtJGzzAg42ivfgvBBJYgWp9nuI5TD9jEyxdjhZlb1GkBzr63mx6UPs5LLfnLUSy0BlqhZF3g09wz6wMzV32VjuQDXTENepZYooL/HTqx+rC9pWHLMtPtR76UhF05U4gBE3OuONOoOOEJOwDEJNYF6Bx7u+Evw+EQyWtYook34ttoFepo3N8dS6F0LfJOqZZGKC4WynuPPXF+PeLPs1Kp/HETqa1/gg1VagEin65xk4qELTa2CiVAE8QZbIEv2AsTHQugltYL/7dclC7Kef0kTkEhZJP86MSQa9sk36GyfJ+ieb3G0J/dVAZb6RK1hvYAVzfuuzy1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IIYlKUeumm9ztStiKa7y9z+pJNO6XnVYbF0J8TlChbw=;
 b=mjg8MpT7wYvkCl+jcTkADsEN6mA70UiaQGwEWWb2CuNJ5xre5H7IclIDmUqL7iusu+eeIX3vB4eZBK/tQM8RUOgKvFVVKyYdyUhTdRtc9rZai92wpgBhjIOt73fhztzkmDJnx9fK5YuL5VC298cX8BPWxsFBoBHP+X+HwKiTtHWkbxlTol3/rlMzOq01hGqAGKUQ/LKAxii2v73Kh58Xfft2n+R3CYe3hltY/fr8lCvjuFSNDxIv0kawRXLQ76oj+ZfjEoGcZpF3gL3CVfKerh5W15irOidA7JAjvoqbNVfFzqh7sC6XkTrtZoeL08CJm3tieNEjU1adaEyk+hofSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIYlKUeumm9ztStiKa7y9z+pJNO6XnVYbF0J8TlChbw=;
 b=HRetQf6yv8vuAsRsGjHlX2PFcZior7XOuGuftY6BAHWEuY5Mow/31nN3+sPN4ZTj3FOPLn2W4NGzPzPp3KVcQvlrUQfMpdv3UZTm9alIBanCs4mQj/8/grBRUTpqtLSnhEnZasqo9DMSrw72QmWWsDRW61Ow5b3DEfYRHUqYFyE=
Received: from BN6PR13CA0060.namprd13.prod.outlook.com (2603:10b6:404:11::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Mon, 6 Sep
 2021 10:57:37 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::1e) by BN6PR13CA0060.outlook.office365.com
 (2603:10b6:404:11::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend
 Transport; Mon, 6 Sep 2021 10:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 10:57:37 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 6 Sep 2021
 05:57:32 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <yao.jin@linux.intel.com>, <namhyung@kernel.org>,
        <kim.phillips@amd.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] perf annotate: Add fusion logic for AMD microarchs
Date:   Mon, 6 Sep 2021 16:26:40 +0530
Message-ID: <20210906105640.1040-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210906105640.1040-1-ravi.bangoria@amd.com>
References: <20210906105640.1040-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7b69ef1-3d50-4c06-d8b9-08d9712523aa
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512157A60C7DCC895F7416DE0D29@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IoLn1pPEhzyUg0ME3RO5nf/tzz2MH+NJ9o3vrBfF32g4UY6Iwh1GkcV4eQzUHkiOpFexwIQXiAO+zJJLKoxeByWURtnQ8OzCpsNCIky9wn+Rtc31FzGKctQ0WeQA5fNHRj7g1/bpzzOhZq4kmwWI931O3+qdPDToum7u3JlGQHQ1h8kKtCxdXJQVvPuYZsk2Yld5eVDc3dazTpJPOv/mpz71g1FtFiklD2OyNAOrBDCXNOskz8scngE9eP4ImlmV9PTftuvGt+Sqd3iXJFj0FvT3EQ9JZYAdOaefQHHnwCdR3eLFBBWix3hNvN07hkZYOQGGt65BuiG//lQR2+0ITBnws9EI/WmbxRulhRvji2b5Y4l0yCgNVDmGUJLvi1yz/2IkUGr3KUQD/AcjOt7s193FRRk60Ry7wwtgWxs2dz/ENB7hWarmxjuE+77JmW8MxeCfYi4zkskEqUs0a6tCvFxsaCkrz6wWtRgFxKco4VQSm6sQ3fPwK2bD5FqU1m/YKeKlWG3u5oQfjgEh05kn0okVTZkuEz2fqj2kmr9uYTtYsH1Cc/P+QGKjU/1B53S2Hc8XOf3r+8FCl45KztoVdM1dxETieboCrCb0OhHs9I6/QDQInQmRolKCwvVWfcXcgirAzxgvt3+fUd3rgV0Idr3XRt57KW+KSZQzjKb5mKKPsGa15rdOpNIhqy9v13NvKjGVYlGzTc/DkKIlixvtYG8r7sPDfL+66KozBquvRVFf8VrzS8TsHFbo7aUcxTCdVmsacfBImAaJzVo0Ge6lPZ+iINXRHZ8skS3VSWzOxFOtM4zDAWrwKRElM5iSZNUcAvwOzVssoOk2q0nv9gj+fnjPAhrqMg4dhpyQbBGr0Rc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966006)(36840700001)(2906002)(316002)(36756003)(36860700001)(4326008)(6666004)(86362001)(8936002)(6916009)(1076003)(47076005)(44832011)(81166007)(966005)(478600001)(54906003)(82310400003)(8676002)(83380400001)(82740400003)(70206006)(336012)(2616005)(26005)(186003)(70586007)(16526019)(5660300002)(7696005)(426003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 10:57:37.5333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b69ef1-3d50-4c06-d8b9-08d9712523aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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
 tools/perf/arch/x86/annotate/instructions.c | 37 ++++++++++++++++++++-
 tools/perf/util/annotate.c                  |  1 +
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 24ea12ec7e02..46d7124cc4e1 100644
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
@@ -172,6 +195,15 @@ static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
 	return false;
 }
 
+static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
+			      const char *ins2)
+{
+	if (strstarts(arch->vendor, "AuthenticAMD"))
+		return amd__ins_is_fused(arch, ins1, ins2);
+
+	return intel__ins_is_fused(arch, ins1, ins2);
+}
+
 static int x86__cpuid_parse(struct arch *arch, char *cpuid)
 {
 	unsigned int family, model, stepping;
@@ -184,6 +216,9 @@ static int x86__cpuid_parse(struct arch *arch, char *cpuid)
 	if (ret == 3) {
 		arch->family = family;
 		arch->model = model;
+		arch->vendor = strndup(cpuid, 12);
+		if (!arch->vendor)
+			return -1;
 		return 0;
 	}
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0bae061b2d6d..88326bb990b5 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -77,6 +77,7 @@ struct arch {
 	bool		sorted_instructions;
 	bool		initialized;
 	void		*priv;
+	char		*vendor;
 	unsigned int	model;
 	unsigned int	family;
 	int		(*init)(struct arch *arch, char *cpuid);
-- 
2.27.0

