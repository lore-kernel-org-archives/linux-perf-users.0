Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021140.outbound.protection.outlook.com [52.101.95.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EC3D47DD;
	Sun, 16 Aug 2026 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913987; cv=fail; b=GODw+NDuiJNOnSmRcSNqAsBaKRpZEuK6O/mbtTpPQmdQPeQl15n/8bExQWR78gNY4eAQvSUKnEVjnr/9D8M3+Jlh4zjSPa5uE0sceuCusnTE5aWQK9/27ipzXknA/3zz3AkxX2mpRpKaZtyiEYXOz1BlYEDRvfJ7rrQoUVcaSPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913987; c=relaxed/simple;
	bh=q2gZ4ulnfe5qWEDwHZOz/q0qtt8KtRsRc3qWK7NZcsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CzWxxQ5SL6p3bOMV2JpdIxm4+2yPx550/WRtSNyD8NAa5MUSBQR1minzY9pINUChXas3EIB1Yct1E0Riai/rmq6tzPazmZPAPoubM/5hAJcsktJQwslHdNazcmGzwzJyO0MSontshWfZWtiQMcpqvLWAUdNQYlHyOccf4AXD614=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcI32+QjT2WXybX/Mp6gsrqeGj10p8eKfpexAkZD7uSttuLUfx+UlHCwLskF55Fb4ETdCN4dXQ8r9TSlv7VC2HHhLEy+xdFDcXPPdmSZQiFuzpIjOoQ+OKW3QE7tUmzErPMVLoynyOUEuOwnOat1n7HptPaKvWoXIdhG4uEdSxwc7TxEk0RandI1Wm6Q+twgDpS+bT9+5lAJAgwLJnmL2YEpbdk1vb4RJFuVUCQerL9Tf42uvh2Iu7PX8uYMmH1dCaIJnbeAso9UiN5BEEA18DrA4HUzcauXLfSgfQZVl0z6wcda/027aOxEMEBl2JfrsM8tJvgX4nY+2IK5VWWWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=oXdrem2ffKK2V3YmCug0VnyYQT+e37A4HVFDd9ZGNX4=;
 b=Wn5MDT9N94VcDQbZ0M3bh+Jpnp2/LySuwCsDmX6ikDE1eioptQ20rfe1OZ3GlGSMrSL1IiojqIXCWNsq7tCifkM79lJTcX7xvLulvfH2F4rI3q1dpY3364ORU7pLovxBTyNJGibuN/5VCFPOxK5098p7YyMnRxR+PbuBncJsafYUoQW2DEtQtSnPw1scC9MuhB4DMyYhW1jbBexQvLv2Yuz9CWex10j+Qw8aiNb4NquJ3JTof6w5wkjQocYVzRINvaUP6jdVi3B9s9+0C7+vkq34/xJa7n23z5+xOlE4FhBCs13l2z8jYyc08F0mQ7oduJdDAPSq48DW8gLb4YJYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2682.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 20:59:40 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 20:59:40 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v2 4/4] perf tests: Add shell test for kernel symbol beautifier
Date: Sun, 16 Aug 2026 16:59:21 -0400
Message-ID: <20260816205921.576365-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816205921.576365-1-atomlin@atomlin.com>
References: <20260816205921.576365-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:408:f8::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2682:EE_
X-MS-Office365-Filtering-Correlation-Id: 8364c589-7aa7-4447-a053-08defbd949f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|3023799007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	irDRM5leRJk5waV7zXPgajgIWl0ugdp0w6A2mExgwcJb/By4k+pAjtwPDiJ0Vc2fIFeJFO+3IIo0jeoyrxRQTA467aTpkIFfCIOnlOVyPxPzOd0oWQosBEqLU9ZPUT07HwRU0SZd1DEfaprYpCSB47dHG0kVpB7RpvU1XF0H+uI6lDj7ArqPnudLkDR3wWGijoVBujo5IvSa691zM+vhw59NtoiWZ7piO1JMvH0CYIxVspEUz3F4oVTDSD+5PSeqOisseu+qb1gIa2qNyKKWAvKJUy4tl+bM5m/Qf1jMRjQ5YKokSL8ruwUKlRA7EHbfLs6bV9FAFetitg6+z7iaWMvvA1CTYCX0eK1ddBLqdpxJx/z++48HYkPNdSGvHE+ji2ZbYGmDQL5QDFPLcx7FSznupTGHjwyB6hDZG9Xeu5FoDXrZ32+GTxCJ7uJbn6TduDEILntQS2o4c477SB630BmXBHGTGX1kItTgm1Ofxw1+3ZnubGcXAF4NlJ8xMwKjmuvsFn33GW4cGjYw+i67ohd3AulfnrhOaG4NGP7xWwRWIvknvMaRdgckl6NYY1lVoi96wpOehB+s9X3RhGLcUqW3KYUHJ93YcjpVFvFrEgxTI+mp1azVifHsIEtMaltlMWAlQhUp9AJzFfG9nFHgn+F++DTb73tfsrjl2TWhA5U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obGxzarfuHu3WrwemKJ2voI3QLZJsEKdTRwfpZbbB9mWizn3rE2unpr0u25N?=
 =?us-ascii?Q?PtaoT65QXuPR4vYQWuTPertfFaZ5RSSSdn16taSL3uVRPv61ryt+8rverHDl?=
 =?us-ascii?Q?jCVpfQZ2Hg8eUyrQPjHQ4+dodzggc35GKZphzFMwYKsrjkp66tbon08dGE/K?=
 =?us-ascii?Q?otV9GdLeWtcaFQC2k+775WCADiUYML/bjZhfCH8rz6k+WR+CHxaaSG0NGdCP?=
 =?us-ascii?Q?fG/NcV/1DR4kkMRchlgmxqSXYMbDS9cpYS0DW78wffENiE4A7/RMchzlh98G?=
 =?us-ascii?Q?1JBAjZoN1RpJ8d/xdaf5LQmcGuC957E69jT0E0kbIaONAbTkRhwzBR2CHmqn?=
 =?us-ascii?Q?eYDr2SJMH8JUJERLULx3k7wAwpQZoj1Sg/YA8SwYSU9EYxwfT278szECcK/A?=
 =?us-ascii?Q?Kh5qGiY4+F37BSyXUIMMvnGBLKyAzmwuMretMDsM4ZLeW79hhQhjma4Npjci?=
 =?us-ascii?Q?kCO6kyRZphNAeujkkdStaBzmTUfJ8d8tNtceSjLZ/zG5qgVwlCzUGTaRvUuT?=
 =?us-ascii?Q?FLaW8IVX8uwNgzuBWDNVJjOg5B1dlnWOkwYMdkfg/3h/DqRKCjoPl1Ol31Re?=
 =?us-ascii?Q?0OpuaGJKqmBGk07+MUbqa2m9jsSeHQLewgBNeK8TfeHZabe67GYaf3zSSy1Z?=
 =?us-ascii?Q?7I+jVyl7ZRhyfN1PLOlS0wM4rxyyejQuY2QNAXiHaRBivGQHK0PhUIh2dt7x?=
 =?us-ascii?Q?H0ZsiY6QHtWbRjWLDALLi1TJgsHjcDoDgPLUkwxgEgp0fww9mPntGPCbqUWl?=
 =?us-ascii?Q?sDNRegd2hL1O+Nf3bP8mg6/94mdjZyV5xmB8IG3V20g044wypIa1uCMbI7q1?=
 =?us-ascii?Q?OyCveCxRpY0RiEbuF/swd5firBPJEOS3Kvajwj5DpFo0P3ll7DS4C06mjEtr?=
 =?us-ascii?Q?UniuIQgk62dbAjRrcG3D48ARSJs0SbfJ4iTyAXVKm0shxHDkeHc/23kofo2v?=
 =?us-ascii?Q?Jr4X91LwWM4kKhJ1rJJkxxvoLV9V59KhI4wW0lAZovKX7k0jQK1MGm4AkXZO?=
 =?us-ascii?Q?ZHzSNvLvstf6rkw5nOYTNsBku9IILM8zUfQWliB/4XbGdSnOSjQyxxUXzt8F?=
 =?us-ascii?Q?BPQqsP81tA+Dyojk0aTlbVOhGLclrTvCVQk+BnqsMijhExGgD4xGANdGo4HN?=
 =?us-ascii?Q?vFukWS24IlsD/TlNA3PT+99fl+6rjiofNzA2lel2qAtNMkInLcno3Fx9tkpu?=
 =?us-ascii?Q?Bc19RPhIfk04uIxB7PGJ5pxZw5dxl4lEoIEJKQy7d3k1IS+1oJ5hYQ+PeycJ?=
 =?us-ascii?Q?mQojWH8s1LDV2d8MMTs+ekOmqhck5JoehXOsvC21v5wUbCFhQ+LE5uzKo/ji?=
 =?us-ascii?Q?og2FCS+pOrOzx/LnKS2W9G63WNJHZRJscx5sefXD4jdbFvp4JALJQT9uJFw1?=
 =?us-ascii?Q?UnZyJlB3HCKumHU9dFzX+2+eK9+d2rTGS6q61cu507qgaT7Z0lgCLHgwNQYC?=
 =?us-ascii?Q?BST92SHrswuQehhFAGqtIlOqMOPIkTYqGrcZN7L2p80PnDnTnGBczjjftnHE?=
 =?us-ascii?Q?iP4QYT9MoKA93egiNobpufXTV0dq3jGItpFfx2R/+1xC/7+v7+E59Sfnurn9?=
 =?us-ascii?Q?1Ik7sx7mTb4VP5GKtJB5Crdqu3uDTqzZbgPuELNrF6XQiUb4lTo/o1wirRdU?=
 =?us-ascii?Q?HWptxCOEDlywQxYUJZ7O1qnpV2UvXAxS4VKFHdMetXTuM8SZCryQXVnwtaXK?=
 =?us-ascii?Q?HD6FFMW88sKyIdwYyXNk2X7fVzkQtnlAvR4+evEBfh2l9nF/QEfu3APoZ3jQ?=
 =?us-ascii?Q?ttP6nmX5Og=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8364c589-7aa7-4447-a053-08defbd949f3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 20:59:40.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUEna6ix3zBwRDyr+vBHQzukms2j2fvSoCZ84ukssX3n3xG4SjS5+KL5Vjmf4dPalHZFzKsbrLrH3z2E+YNuqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2682

Add a dedicated shell test script, trace_ksym_beautifier.sh, to verify
that 'perf trace' properly symbolises kernel virtual addresses and
function pointers using both the default kallsyms beautifier (SCA_KSYM)
and BTF type routing i.e., --force-btf.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 .../perf/tests/shell/trace_ksym_beautifier.sh | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh

diff --git a/tools/perf/tests/shell/trace_ksym_beautifier.sh b/tools/perf/tests/shell/trace_ksym_beautifier.sh
new file mode 100755
index 000000000000..2916f78503f7
--- /dev/null
+++ b/tools/perf/tests/shell/trace_ksym_beautifier.sh
@@ -0,0 +1,52 @@
+#!/bin/bash
+# perf trace kernel symbol beautifier tests
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+OUTPUT=$(mktemp /tmp/perf_trace_test.XXXXX)
+
+# shellcheck source=lib/probe.sh
+. "$(dirname $0)"/lib/probe.sh
+skip_if_no_perf_trace || exit 2
+[ "$(id -u)" = 0 ] || exit 2
+
+cleanup() {
+  rm -f ${OUTPUT}
+}
+
+trap cleanup EXIT TERM INT HUP
+
+test_ksym_kallsyms() {
+  echo "Testing perf trace kernel symbol beautifier (default kallsyms)"
+  perf trace -e kmem:kmalloc --max-events=1 > ${OUTPUT} 2>&1
+  if ! grep -q -E "call_site: [a-zA-Z0-9_]+" ${OUTPUT}
+  then
+    printf "Default kallsyms function symbolization failed, output:\n$(cat ${OUTPUT})\n"
+    err=1
+  fi
+}
+
+test_ksym_btf() {
+  echo "Testing perf trace kernel symbol beautifier (BTF)"
+  if [ ! -f /sys/kernel/btf/vmlinux ]; then
+    echo "Skipping BTF test due to missing vmlinux BTF"
+    return
+  fi
+
+  perf trace -e kmem:kmalloc --force-btf --max-events=1 > ${OUTPUT} 2>&1
+  if ! grep -q -E "call_site: [a-zA-Z0-9_]+" ${OUTPUT}
+  then
+    printf "BTF function symbolization failed, output:\n$(cat ${OUTPUT})\n"
+    err=1
+  fi
+}
+
+test_ksym_kallsyms
+
+if [ $err = 0 ]; then
+  test_ksym_btf
+fi
+
+cleanup
+
+exit $err
-- 
2.55.0

