Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480B31ED81;
	Mon, 24 Aug 2026 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578316; cv=fail; b=IDktZpcptc8w69wM+zVc2zc+3glGfD3+jj4mmVv7CFkVSL8VS00FwFTY4oSwoDci7VSoFqMZ+7QOxBHFBkogsHD06CqnrGNctSXStrHIDEvojNikokx3Gofcv1h8JFfGxPZe+gLpYKlfg4XmQBQLDFeVEG2gP8iBVwIMJ8Nau4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578316; c=relaxed/simple;
	bh=hAAVGZR+PkwA5hJspKTiEdfAAeTJZ4xfwFKV0OmU784=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GnmoYHAxEiDjYrL21VjMYlhY/RM2GsdLSUl+XhxvbRL0xy5JF9JSO/yn4c4Qm11EmI005PRWv/34WBcOgy9OZ81rGYZ1Ew3uUrVxp9joyckYSdIRnuaavapbxQIhEKJipU2Q27rMwQ1vdWkP56YZ1RYjTrHvm+Bciod5NVVwSzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6MyGRcUSh1PYlEsH9Qn8r1g1R1SBvbaErsl9JpUTk7bn4Smo/bejeEXNsBFS27e3EGp1tmE+RFSniXFPlWD1ZXq/Vw2jJUqSBZZwP2ISG9zEyLWXTCdKw3R1doKnLUBNHhk46ZlLDtEai/wCnJzoonYMUUOkxGgIoMqS3NwNonggY/3knY7jv4+6mPdJ5HiqNqmXHeXwaEt0sTQ3874QidEt7UUr6sgvMmBfgFE8M8U4gwHCD97Ut/QRlLGhT9FNATvnFSzyXKFrIUJMUpVpfUc0xCcPi17J/NG6a+oZUnbESw9wU25MZJqXxUMPnmgDfjEstCxz2ZNd1Jb7bTp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/rNNW+LjIHKLsQ4O23ZzyLYh/Eqed0g3UmN0zD9kUNE=;
 b=Oci/Ksi/J6GHIf8OdE/b45Y7CuFdzb3+4GfC60qFShnXj3ZpZ44xAtQd2lP43hiW3K9yPhqoW3O0Psh5v4Q8gm8ZWDmYa/T4E7ZrU9JKueaO4A/fYUE860M3W0C3EnltmzxCyqhDA6YEIUIvOUHn5dov8NtLwRIjGlvGUQmQL7qC99eO2oBBhaNyKJXyveapDAPv6YMlBja0u+Zcc5r+TaDR1eHL77Eze11/eDebSc/fWZ1+mPRLIYfc+NYIaIp4wMKLKCdPcpOQ1UhE5rPPBoY/OpttZiGxC7AB/q55AcQ86xMO9NxBIVf2DOXvBgsRBVq5x4U5O52vJ0IhmcEGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8950.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:271::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:31:31 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:31:31 +0000
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
Subject: [PATCH perf-tools-next v6 5/5] perf tests: Add shell test for kernel symbol beautifier
Date: Mon, 24 Aug 2026 09:31:22 -0400
Message-ID: <20260824133122.751733-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824133122.751733-1-atomlin@atomlin.com>
References: <20260824133122.751733-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: c3243657-cdb2-46d3-86ac-08df01e40240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IoX/uBx+8/RZG+csmk+8IN7UB0uyW79+5Qm6WbWiB8+kyDzltu00hpL38hEf8Lr52FJT5wRfCYpoLVFxiirZwALe+ohW/sheHbA1CxpLMdLc7iN+Ca/IZWWLLg+kpaOcPWJ+xW2DkRWRsRTfVLzERWYWns7H6G0t0401+THAd6zjUUkdk9/WfRpATcQh4X7yHEnTj3zY9V0yibeoYNQfg4HK5xQ/+91Qj8Vqo9gVSVxgFc7Vp0nzpn5ivVv1VDWBGK/IYb7iM1jwu6WNvld6dfjTQvIxTbufyUrJ5w/v9GVd9AnY4GJMZErDJ2VyzBFXHMY+BcGHEmP9JaQq6HFvcGBLadw4d9IVnxO8hCyUPQ7fVwZk1ymeFwAe+eKsdfU2TzDVSkaTeRTNbAOyhYFUYqg3OC04YgrsHrqQNMjl7Xn5n4O99vgjxZA2VFebIRSDjdTv+pURpE4rgVZ5KDte3O1MbnTIyyoBYzHwiNTcOKVSDywBcT/nAnN/jxmI3/Smsb/WKLXCM9+POG70NmaOWPVHYot3ndGlzL9wANKk/KL+iFKr/AjzQ3SOt8DYgpSFrJEX0jkscllJrtxQNBNCP6faPgfpkUOy9kwyoUrQPNWIyigwZHLc2jPIUxgsjZqYCUsGGFR5um0e8Cf3INgQi1Zfy98ojtywFtKKD2jm5dg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DlXqrxCgNDr8MQHEyOf9HPe/M2vRn5Z9zQ7vdSAXg3hAv5n4ueZkCmZLjU+F?=
 =?us-ascii?Q?5LufMuW3Ku1JrOQKugdjCv5LPxaIvv75TfF7RsvTZI9eTAsjX/V60hFhw9x4?=
 =?us-ascii?Q?hA7E8PZ5mbZnJVyQmDTaSxveRBhyByLYdBPM/FX+so3gqKuG0WPaHsH1LrCz?=
 =?us-ascii?Q?V8IXF+4v8CCRXmyRIXokOlCWYg8Y/MviWlnHm/hv2zxetPa+He8dK9wYZcMM?=
 =?us-ascii?Q?FmtzrOVaszUjX2bMdiVm04MMSnf/z5L/pN+OgEuRnrVVV90moZ7mrC5HcpuX?=
 =?us-ascii?Q?APh6coNaxyJmUklThkby2qij4higYKaJroWWn+Hsmc/SMvsswpeciGOZu3Ln?=
 =?us-ascii?Q?QEg6BglkqMsjUFm3wwGxz/49w5ZT/2o6YcDpZQ1AASRv8DjrhYdms6L6nR7c?=
 =?us-ascii?Q?0z0oNa3IiVxz9tMMa+6dA16ye1v+SBG7tS0ZWn6Try4mMO42tlbNPZqbs6wz?=
 =?us-ascii?Q?cWIlru7o0jR5C2sDujzBjnaSCeRSNpEXqaFx8VvXnst7n7ceDMXzF22HRhOC?=
 =?us-ascii?Q?d1cPV8eRbFZGba+gYhsWCguWT7wz5XtnN+x0vOSAb38cUKBJXxZ94HJBlDoP?=
 =?us-ascii?Q?aTAOwXBeXyVH+aqzQgRatxvQE8cZZZGPjpnaDP9JqR9wiMpPxTTmeQEDltPB?=
 =?us-ascii?Q?mMAN0kBKxMr9ef86RxQvVDRZQCaqj80wHRA90anLZKogGJTTBaNQhCIjA1/y?=
 =?us-ascii?Q?hboowksfzx08LrsrRg44rPDps4t4EZYby4b3L2as5GctpxJZXA+R9A8Jt4c+?=
 =?us-ascii?Q?4ImH5noRmnFpbE+ohNP7LV+UtvJofcyze54bfpmUf///gD2H4upAQ1x/KNop?=
 =?us-ascii?Q?RLuS/TKjsiPnZZY7v81cZzKyDOH961Ovz7PWE7zp5XO4IlAOYv6vO7NP8F6D?=
 =?us-ascii?Q?KeX3DR5bKB3t3alnp8BQnww5LPadYjX0evgDyGQk/wxZsnFh+xssp3pof+pt?=
 =?us-ascii?Q?OZAver3ozA3n9LPsReAKRKbMkpU1RDrLigu8nuBpltWhBMH9L/H8MiyPIEsp?=
 =?us-ascii?Q?KqA+/9EMq+pIZQ20zMagUXEvMXhLqv1NcSGDFEGcI8E2BEUEYp0xTn0cTn7Q?=
 =?us-ascii?Q?Xm9rYxASmEA9QjugWlhjtM+TgJtRFyVFgRWW5xbEyyHe6A1cySYZ8G3qvhu9?=
 =?us-ascii?Q?dyCYNBRqRUBE3tBRuo14LQFOORc3LRny+D1XaKIjzcNRPS0v/gM71dIXPObL?=
 =?us-ascii?Q?tswsiheno/+YYmR4hY1+0p48pgYGEW4AkbMrG/f/ur36xcCeBFHkfL6dsQV9?=
 =?us-ascii?Q?HnFlrWICj+4oqABW4Q5fKLYHC2VDg9vEwc0TI3MhLfdiLt/4oCWA0uQY5oCt?=
 =?us-ascii?Q?OYTn8R/Fqlyi8jgwG51rhCuTXOzqSAtJD/JxgWVXHGq0/Z9WDmmD5msMYSc/?=
 =?us-ascii?Q?TSNIVJJ6hnXNmASBOBJaBn8XdF8/MtpPjYytAtGtXTgyabwpImTDb7p5YGM+?=
 =?us-ascii?Q?EER+pMfz34SO5wTl+fV3erthNMS6o/5dbk9LZf5TLPLDWiNA3p+rHI+4sWqN?=
 =?us-ascii?Q?itvhIfEsF2QwREhX7+thxPGdXVTVvAULweH0m+/3BXjd+mbOW7GOMqHrngH0?=
 =?us-ascii?Q?vqTixN4Tb6rSnmDI6yzi6T9EbIOA42snUBMddwYJMnl6m637Jwyr96PWRa0G?=
 =?us-ascii?Q?6CE/CldL1oR8UZmjoRUoqd48EQCekDZjGmD4Ecm/JBbE4NFCxsJCiCCqpYFs?=
 =?us-ascii?Q?livYqDa4kC/n/eCF4Z5UEO+r/MGhbMXYiUavyWPWxT26Cbzx?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3243657-cdb2-46d3-86ac-08df01e40240
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:31:31.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuP6QzM8MPwpv2lp5yyeX7dkyWLt2w/UVW/Zr2ojXoL/AsizPnXzZ6tKmZrZnW6f855EaElJsFPHlC2DnFcykg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8950

Add a dedicated shell test script, trace_ksym_beautifier.sh, to verify
that 'perf trace' properly symbolises kernel virtual addresses (e.g.
call_site in kmem:kmalloc) and function pointer fields (e.g. function in
timer:hrtimer_start) using the kernel symbol beautifier (SCA_KSYM).

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 .../perf/tests/shell/trace_ksym_beautifier.sh | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh

diff --git a/tools/perf/tests/shell/trace_ksym_beautifier.sh b/tools/perf/tests/shell/trace_ksym_beautifier.sh
new file mode 100755
index 000000000000..7c441f8551a2
--- /dev/null
+++ b/tools/perf/tests/shell/trace_ksym_beautifier.sh
@@ -0,0 +1,38 @@
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
+test_ksym_call_site() {
+  echo "Testing perf trace kernel symbol beautifier (call_site)"
+  output="$(perf trace -e kmem:kmalloc --max-events=1 -- true 2>&1)"
+  if ! echo "$output" | grep -q -E "call_site: [a-zA-Z_][a-zA-Z0-9_]*" || echo "$output" | grep -q -E "call_site: 0x[0-9a-fA-F]+"
+  then
+    printf "Call site kernel symbol beautification failed, output:\n%s\n" "$output"
+    err=1
+  fi
+}
+
+test_ksym_function_ptr() {
+  echo "Testing perf trace kernel symbol beautifier (function pointer)"
+  output="$(perf trace -e timer:hrtimer_start --max-events=1 -- sleep 0.01 2>&1)"
+  if ! echo "$output" | grep -q -E "function: [a-zA-Z_][a-zA-Z0-9_]*" || echo "$output" | grep -q -E "function: 0x[0-9a-fA-F]+"
+  then
+    printf "Function pointer kernel symbol beautification failed, output:\n%s\n" "$output"
+    err=1
+  fi
+}
+
+test_ksym_call_site
+
+if [ $err = 0 ]; then
+  test_ksym_function_ptr
+fi
+
+exit $err
-- 
2.55.0

