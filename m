Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021140.outbound.protection.outlook.com [52.101.95.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4207483BE6;
	Thu, 20 Aug 2026 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260280; cv=fail; b=ph9c4s7Ez4yDcRY/5YiZ/0ql2VgY5AxmCtPEWYUJY3opgq/x6SfYZhnK7+b7n3peNT+R/5leOC8hNkVHiQ2XzsMKV0alVvOwY71LSg+fkKWw0iW15I1c7PHw7Q3aLptEx3G7lNEL64FtE7Jvdg3YEj+DmH5BYp4Mtq+I7cjViUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260280; c=relaxed/simple;
	bh=aL8WBC5Nweqz+LZjDGPE+7OmuU/58k7UCHSgO9hS3eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JJ4FxYbM0qfceA7RLFb/fsCxTq1Ou2GlGptSOJEp+cJiRb3zqwgm/HR/a+budAMTTP2Grqcu3e8cO+zXZ+rJHQcqozIptqN6mLIYJT6KJY34GpXWbltJqV71Xmrind3wPQPrhjgbrL0caLqD8ZBnilH6LBMqVttGCaW8CflxQzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYqm69ULekkTqcNZzpS/gtBS4uv2BGIQV0aDGoZjr/At1vcrsmSTJhttjHqPrEfq6s/ov7P9oEy5dab1IrIUq3euGCxETdKK1tnPPc5WaQ5JGcYGEuBpaI0nADHD++JuXBgDO1UQ/4kB0cLbQzCEKDXi0dFcfku1q5+ORP18sx4vBXMZZ8VrhywO8DVNyjVwhKqWtKZvMLyPyduSBYB2SvakjxwkacyLVgHqhRzrgGeZKZIO7a25CYiN5nevi+qS8M3Kel1WUBiKMkBkchOGCipcZFClDsYG2e4V0ZKfyddgzFBW5A90em2FjnchAzMg2EBJ91qOKdHLkgtulITntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=2p5Qs+mvI86rGQCA5HRrh8jMO2QqSGcFtwmakLq4+9w=;
 b=qMcEtpOvC+Egu3CNtGKmKaPseI1c1PIbEq1F5T1tM+bKX63EakAvcLdn8gvknOnaWWpB99CJRP4x+4CgoQRRnoruwvcxaUtKbvWYRDftxjsRFr1YRh7CADYY9fxOpgRjB0fOWVLRrseNOyDFc+t3n4jMymRTqsvlaYAnhBLS7j/vI9RijBVoTNKbHByMveurv29e9/A62paic8nhTVoerw/wSjfcmwBwj3IDMp354T8MyFAXnUOsCj6lFoaJAOzH1Xxx0fNvpTX2EU7YBW3B44hl1zo2F6zZ4MIWlwN6SB3BW3CQHi+3pzWqMFcFxDKJemoP7Yb0VbdQbgdTPufx1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB9004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 21:11:17 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 21:11:17 +0000
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
Subject: [PATCH perf-tools-next v3 4/4] perf tests: Add shell test for kernel symbol beautifier
Date: Thu, 20 Aug 2026 17:11:00 -0400
Message-ID: <20260820211100.649142-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820211100.649142-1-atomlin@atomlin.com>
References: <20260820211100.649142-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:408:e5::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: da0e412e-f7e3-49f7-a6f6-08defeff934a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6UOWxEPk5ojHnRXLvtB3JWLRAloi5RExeXu0MHEHlpst4v3mwtjrc4VdYliIRA7tPKgvVDfic1ErLl4GYmiyIEcTsR0NmE/sCtUpcoScrqKdzZfQ9Wr73UDmmy/8aDW6XZ7S96bG3nKSFrfK/yKI6G4ucKPieHKoe6s5hFwpuigN7g9mmSuygo1Z+JRnf2Fn18FvGX6sX0n/H/07+l5beXIek1Z6OuCedj/MWUsCnHEcKb2Q0wwvg1/nqIQYOKqipiAorRfKLc8aKAwit05hUL9Ff+TCsPuOrdYayOTU4/y2WG5y3iyP1RlpzC0bhc3w0Ujjj8N8csCK3+YZgdRkQVbAO4mIgDdc5CKHy89VGwtEAtRrxP2ws5U9jJO0NMoSqqeg/8KDr53z6RJL7dAqpNmU541mz1sCOSU4zysUFTuc1y3xeyIiUrXzGEL1qsNNNfcJlpi9jkZinJUg5S/xjP2JMLtLY+FTIT+5mdfZ2iwE8kwGb606uNO0g3lNheNFW8tUUOE9ax8ivXiMNJTEbUs7CJi4I3x794Pe3lVB2SDAiGkTZU2JTBP0jUOK92ylukAWz9fs/tNccEESN25b0sR9icRmXZhVedHBlx0xcWZJrYo/bAuQ4SrqU1+2sFrR2UoIZCl+WyN653utLPZt3hQZs9+r6Grl/W/6GJ3kDwY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qtp14mjBt9hjTfHl8iCAXfjfbz/Ik2ON8IQKKlR37cMPZUUWAo3PIReS89BN?=
 =?us-ascii?Q?x5kJhmZa9QRCF9utkSt2cDh9Stvu/RylSF5OJ9ytuYFFWNU8OS0GviFXqJnJ?=
 =?us-ascii?Q?CcjuG3ncNsLSEAD1xtHSl0mG9pQjBVk5C+EDyiELKBa59sD7wwL4ZfZR1N3j?=
 =?us-ascii?Q?eyvN/UzMb2MyWpBqQk09X16hzGFH8r5QlYmyZHerse23g8QaGLZYikKl0VeG?=
 =?us-ascii?Q?HNAYTLzpsHfbMozradTkPsFUJbpPsJ9Bqd03785VKPQB8iGoCbgZgpH5PqJ2?=
 =?us-ascii?Q?7OsqQsptsoISwgA/3tSc5VEMhM7rfBzvB1r4MYUfktCx1BYdICnHaMlqrQ+M?=
 =?us-ascii?Q?ON2mCjINfD45lReDG96Lsh2WhXfeN13JNH8AbCWFLi71Org7fQNbLztCv/U3?=
 =?us-ascii?Q?5bMvUauqI7FKTCkYcD0s6/9p8DdFMI81CL4RrWkuWqn0ZkJy49AZflid/NiI?=
 =?us-ascii?Q?YhI7yRoTeCowWxmL7pE8tUaLXxiadQL9dewOpbOkViILjgiHDcnR3x/gENFy?=
 =?us-ascii?Q?OVTsk6vbvDxf80s66cDoEoVfUah9r0e7GBCitvn9AivX2OhJ9PfAOLyP6Hqq?=
 =?us-ascii?Q?Puc/5qdNpN4dIdpgOl88y2LJtKpwVJvmXz383m0M3gGMLC7VhTbZgLGTVzjo?=
 =?us-ascii?Q?acXrVXIi53WAhJ3HkT3lv4J4J/Ka68S70q//U2Ao8S05ygD6Um2SJaVjXfqL?=
 =?us-ascii?Q?qhSlD4GDX9sSFgaqxftQs0srRS8ujIZBMhLS0tWDY4WFpp+wrO6aE6r3gbJc?=
 =?us-ascii?Q?wl7X+ll/jWMrz8fr8OoBblE88Bppunmdr3kx7V7ApuYvLLQj+fDaO+sBfY14?=
 =?us-ascii?Q?TNH9EIvnnziZ7fv5/GzYvXz0Xceo91voZod/Z3rSIAN+De3A5kFYie2F5lL3?=
 =?us-ascii?Q?ltuuJ+R/XCTUAjdkF/HmWAkNsaarEpi4UNGFCnutJJyBdc6/EPtMYbFmzr23?=
 =?us-ascii?Q?7z6a1iDRNuOVHQ30Fe165vNmaaXLh/p5MZazA0foIaALWTc6rAj1bsoqs2kx?=
 =?us-ascii?Q?LlCtudaZ1OodmmkwXxVSbAsOpNoMNNyHPGv68q8smabJpqgwpwfUhzBhznrt?=
 =?us-ascii?Q?jkPiMLZ2Jozu9pfFCclIWFbBE/0aqi8DUilA5puzy1yciDfc9l/MKyqcoA/n?=
 =?us-ascii?Q?3zoNI17zWSuNA3J9f+HxrCSkQojQW50cZDh/5gyaNsKoI0ytNEWYD4KZIZfp?=
 =?us-ascii?Q?vcke4FWeabg1eBbzJUmuzKezgU1p7H7cznbIjkToLLoVhkbSp5+HxtQ69Ljs?=
 =?us-ascii?Q?iyNn7w7fOBg8wV4TXOtra07iGB0j+vmjtlQyZcGHvdMDCuRxABl1MFdirK8l?=
 =?us-ascii?Q?Z5ksBHfZxrk2CVpgF8qTTYyd/kb5NVZYEJkEClHl5EEnmZVAhgATgU1+Wb/G?=
 =?us-ascii?Q?CLtZmIZKctbc5deo5hNu1XHMkBkMrHbgB7/qJ629wx6Pyre6r/RNzmx2d3Ll?=
 =?us-ascii?Q?NX24s9Q6Eg/2bGZDS+BfOW3TogN3IqlQW3Jk4q2ASInsChOHB/xFsP6c58QE?=
 =?us-ascii?Q?NqEEdUJhtFZg8vU5kN/PoaKN5yCibCgxosfUznpJ4oxkOfIOda5Fmte5gSDr?=
 =?us-ascii?Q?q+Y/lu9+a47T34azPDDmQbS06+hJRHrkGAcjipQGcTXEWxLMmanPhVLAwlpg?=
 =?us-ascii?Q?Rsmj2sRFx+1vraalnHPN87PT/EyUmeNfT6SuMTqKybJglkB6EKCKpEmT8da5?=
 =?us-ascii?Q?hWQtlXUYLXM+kJYVrpdOaLZCN0gv8zqbql5xZEOysGDBWe48vWopCGlmfhVh?=
 =?us-ascii?Q?FtCghXw2tQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0e412e-f7e3-49f7-a6f6-08defeff934a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:11:17.5511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv+Ph0HG8L/Q1FORhN1qXWTk1gAythjSgM8vAFgIP15GhWBAp/219jr9q1eTgS9NsUgqFEr9a2lNsHRiWwNrzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB9004

Add a dedicated shell test script, trace_ksym_beautifier.sh, to verify
that 'perf trace' properly symbolises kernel virtual addresses and
function pointers using both the default kallsyms beautifier (SCA_KSYM)
and BTF type routing i.e., --force-btf.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 .../perf/tests/shell/trace_ksym_beautifier.sh | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh

diff --git a/tools/perf/tests/shell/trace_ksym_beautifier.sh b/tools/perf/tests/shell/trace_ksym_beautifier.sh
new file mode 100755
index 000000000000..30a8429669dd
--- /dev/null
+++ b/tools/perf/tests/shell/trace_ksym_beautifier.sh
@@ -0,0 +1,43 @@
+#!/bin/bash
+# perf trace kernel symbol beautifier tests
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+
+# shellcheck source=lib/probe.sh
+. "$(dirname "$0")"/lib/probe.sh
+skip_if_no_perf_trace || exit 2
+[ "$(id -u)" = 0 ] || exit 2
+
+test_ksym_kallsyms() {
+  echo "Testing perf trace kernel symbol beautifier (default kallsyms)"
+  output="$(perf trace -e kmem:kmalloc --max-events=1 2>&1)"
+  if ! echo "$output" | grep -q -E "call_site: [a-zA-Z_][a-zA-Z0-9_]*" || echo "$output" | grep -q -E "call_site: 0x[0-9a-fA-F]+"
+  then
+    printf "Default kallsyms function symbolization failed, output:\n%s\n" "$output"
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
+  output="$(perf trace -e kmem:kmalloc --force-btf --max-events=1 2>&1)"
+  if ! echo "$output" | grep -q -E "call_site: [a-zA-Z_][a-zA-Z0-9_]*" || echo "$output" | grep -q -E "call_site: 0x[0-9a-fA-F]+"
+  then
+    printf "BTF function symbolization failed, output:\n%s\n" "$output"
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
+exit $err
-- 
2.55.0

