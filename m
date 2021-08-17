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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819E2C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F8F61038
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhHQWMw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:12:52 -0400
Received: from mail-bn1nam07on2069.outbound.protection.outlook.com ([40.107.212.69]:60679
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235977AbhHQWMw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:12:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC/qTNNrXeYGIwqI/RB3ePpYtmvd8vdKLKCd2NcN02xhxawEqYepYFy1ZztsuWb6EgHvCP8Q2So5YdIuYf9XE1TexjcdyLHC8zs+I2lm2PZNRowf4qi3xJyE4YxiTG+4uf3Z+5v3tWtYFJjgdFA2tyKHV6fbg/LoXs9GSVRwcyHJjoar9oTez8TVDGvrayFf8qZVPCvpt/jRgOSCbH39ABJ++K4z9l9cDIJvnHNp8RfATq4gRCUkfC2pmwU65la1CmBWbSNou8mkZ7Q5xNdEZHEvWoWnFCdc0uCk1kxBGPXhXjeywfpNXtjDFvpbNWqRoRftGncBymIimysl033cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30lEPAQExaB0EqCvRzwoQZ9S1qpkcmYMsQgAyxqBQD8=;
 b=cUU5+0HSbNzml2m7BHVIh9K2dKhc+2tTVEfIN2enV1DWofq/zkP1mhlMtVTlOir6P616X7SH/mny1kuNwq1mPldjU46EfW/IvFuKvpqJ1fbIW/kFwiVj1r06/D5IqWJjKb0tGsfC5KH31awdmijbDfHP7BGCXIouICKN6GhDJwUn/SKroeubn3BdQSJu80qyD/4fQzWYNvp6z2LEELqfvdqCAnsY0SyKUBVeAvw+0Pu8Kgq+JQcOVbKsA7iXLcoP15Qp8CyACicjfgoLAwd46v/FpPjhsnzkqfRYF7RlXwxeOfFJJfwvoFuGAn8W4K1yb2YccaYmTEH+dTzI2FIjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30lEPAQExaB0EqCvRzwoQZ9S1qpkcmYMsQgAyxqBQD8=;
 b=RIzcibOrV6+IHLrUxJEo65L5KXWJpIZPW3UX2trjOPJ0kywD6JO3M2dNnHVyEjPsVrpOFDIm8PaKcK+V3CHv23kQm+engU/UhtA+lcdniyWgsLHdXWQqAI36Ls0jhTawPtWW8Et1gugT9auCdfSeLPcs/d7UcRJ2z63flpaHMHA=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 22:12:17 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:12:17 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 5/8] perf/amd/uncore: Use linux/ include paths instead of asm/
Date:   Tue, 17 Aug 2021 17:10:45 -0500
Message-Id: <20210817221048.88063-6-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817221048.88063-1-kim.phillips@amd.com>
References: <20210817221048.88063-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::12) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SN7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 22:12:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeb278e8-abdf-4026-7c2b-08d961cc12dc
X-MS-TrafficTypeDiagnostic: BN8PR12MB3505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB350524228E31BFF7D895E07587FE9@BN8PR12MB3505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mb7CQnizx3y3Ac339lYdnsUF6KqUjVXCit3AwbGoTIVDdNCB4dkeNdYcsYY+3lztKY5DO2/vwwjCwv6UiGwr8+RYm+is3ldFyVpOL3yAOAfaSpTz4W/agTBNPBjqfyyYh8KFA1ynBapPG9GIsaw3VfOl3PKg1b1DDK6vsBPA8tsP7om2fRdAvJJQA69beTbTsiSBNl2ezl0nlibiqQ5p9KfNG9jQc7oFo7tHP1sl8I7nuF9ooL/TsjhWO68zh2FN1sQ6JPCzrTCIOjZ7r/GBYFNl5h1UWYK9MSCO8fnqCJEGECrhH7aRG+Rakk+3dTJ8WYPJ1rr+Tj5L+OHtjY+i+rdTOUUB0c4z0yrRZRD+Bx+VLHO13zkqWdFQgwVeMWqrhWTtHENi8uBE5+txOFGkL/K8CDumNNL9FUBDvD02KNjD6r4f6bVR6aG7vLZ5IdSxuwiwZ0clq66MbfYsc3kTIw2j3I8FqPNkcqDXoFnuZHZ2AnlTCjiHTTi96DGcjzZq9yKohiWRvO2cquNVHv3DXAD54cbATUCsJ3/WfJ9tfdK8i/ZQA/bgOf+j9RBRl1iheooNAk7qesw5WV/TGZ6j9+THEEkZr6dn2/uv+pJ7jgA7u0CxlqhrLx1TegAjbKnABcGGqeefMt5cb5z6ZKS+i7cuDGHVFncWq2uDlRMuHDOLt1ngoIiZF2ZsoAYSShRoejpDuIBk1GuFxVKu7iOpsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(38350700002)(66946007)(52116002)(110136005)(86362001)(54906003)(6486002)(2906002)(66556008)(83380400001)(66476007)(186003)(26005)(7696005)(7049001)(5660300002)(956004)(36756003)(478600001)(8936002)(7416002)(1076003)(6666004)(8676002)(44832011)(4326008)(2616005)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1yXkZqovuabqVpi4bKbae7vHdHFjgXpc4yqXOohn/qTYW5x8ydkONya0lR8?=
 =?us-ascii?Q?r9rJNcO00VcZhiA+zb5fF1TOrkSChQz6GY7AwB+Mn3cuRj0eH7fe4RpA9RjN?=
 =?us-ascii?Q?fB7rq0+IYCUyggcam6phIuuojMgg0HINemfO/mKzfXkYL/g+b2MAybnUs+6P?=
 =?us-ascii?Q?mL9KX2iITv3p8hcrziy2b66l/Pmx0P+Ew3qlSN+YXM6+gbaARfpLvLyMvcAj?=
 =?us-ascii?Q?E14VOjPUD84vvZqGdCWt9r8erE3Z7IkF69QO0Zaru4jlYwKEohcOUfZHYz9K?=
 =?us-ascii?Q?2m8bdq0GtNKlDkJoQig+zbVqLiCtDzSDnSpAgrAlzvpbL8t1fF2M/A1oTof1?=
 =?us-ascii?Q?oQFOQ/0prHKH+JX+14BBJ959nYpkWZgjxz31axrJVM4e9rMl+X4NKwF8Yehw?=
 =?us-ascii?Q?mExzPK9DRfB1QKQc22391mosV6Cp6NYunCVyzzUK5ETHbYG8OgYg0VX9e81p?=
 =?us-ascii?Q?hS7edB+8ARD5cW2KtEgsTwXsJQrwzA/vWxCxQVFj6p6sh2VXeQHbNqYHdaBj?=
 =?us-ascii?Q?0Px/TTieGM0Gx+XDiH8+gQaIQEI1NAmfqYdtW9Ub6gl2+cX3izpUXE+GxPz5?=
 =?us-ascii?Q?L6SeYiR9ToIiKrGeNpwbeWa4De3coTYoPWU4OpnM9m6p6dpHdnxpe7QaqCXL?=
 =?us-ascii?Q?Jw+Zgl0VF7+suZHL1rTZC7EHveznLIPovXqfk5PjnHXhu/o7xx8FokSZkgnz?=
 =?us-ascii?Q?FLSxP6mdxiI8hjW5NteYWS/D4yzp/M7oQtJA/HMzVfgPyYIuDoc4WgOjlFpf?=
 =?us-ascii?Q?kQc6WAc9aMnjL+TTsAVEQnWNkGYO+Lqd2GyWdD+9wearcbLL3CZ/BuX2g/OY?=
 =?us-ascii?Q?W7vGsbHVandE6SKEH2i3mPvz1ymipsPfEFJApLCzYIqhJLv6YmASn6+x9YjJ?=
 =?us-ascii?Q?DnOrl7DecEC1Z6uBP0yXmw3COTmmdQG01ZrLKjOnFJzqkuerjRs6sZlvRK/U?=
 =?us-ascii?Q?hH2LIXfIHVou3ioiBdpqD4DzZ9Y/dPTsutgtvV1RyZL9eTitiwHPDHEz/cot?=
 =?us-ascii?Q?w0nmZA5BcMoNejALNmWaVSYzLfBBLTecc5zJNQbH71z7v5QqXBxgp7lw/LHr?=
 =?us-ascii?Q?ArsVcXMxcnMBm5phkSMnyCcJuAjWcWhBJzfPMTXxu125uUf8GYB1oLNoEfCh?=
 =?us-ascii?Q?aO5lAfwMFrYnPuGY9jaPx80S4JpKASnZPMkTUvWOWVS2jyD9kr5S06cWAuD2?=
 =?us-ascii?Q?z0Ur9/rN7xriQtVe65sPdFmMZ5cmymmW+Ljwd+cLhsZ0fEtaLi9i7/P+iwwt?=
 =?us-ascii?Q?Nnb2lN0AQbuwsQKdc1KhRxKoOLlhBGzDkv8BMg+gChvhQR6ItNsgAVMk1hIu?=
 =?us-ascii?Q?g2AiJvKRO8R30HA35/K4Z2sG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb278e8-abdf-4026-7c2b-08d961cc12dc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:12:16.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6J0aovUzN+XiPeRnSUkruXoyk/VjKArodhz3/6cWIfbzbN8Y5mNEXjDDvYhFjFz+SedrW9MJab/BbG9HEFYJOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3505
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Found by checkpatch.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: x86@kernel.org
---
 arch/x86/events/amd/uncore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 05bdb4cba300..7fb50ad171e9 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -12,11 +12,11 @@
 #include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/cpufeature.h>
+#include <linux/smp.h>
 
-#include <asm/cpufeature.h>
 #include <asm/perf_event.h>
 #include <asm/msr.h>
-#include <asm/smp.h>
 
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
-- 
2.31.1

