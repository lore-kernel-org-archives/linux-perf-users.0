Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020087.outbound.protection.outlook.com [52.101.195.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AFD38736C;
	Sat, 22 Aug 2026 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434603; cv=fail; b=L8hWn8Fj4h/uV+nTaWvM26UuM1x/m7j+1El1edGPaJlax8ChzcoV7th1zVIWx9Qk4R11i/0SduC6eK31k+w9CtPDtBotz733ZBUPfPO7TwXtG8kHE29V3tivhRLnhnOGOyiUT2c++UcVt/TPR+lhWNKSEnf3KfaGbr9oftPFxAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434603; c=relaxed/simple;
	bh=gtYRGN5e2EKc9gzhHbXazBVRphqvfnrvB59rNUuCJwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=klsunbtbT8aMdCqP4AM0KyLoHc+Y89yuLWwdzS/1cCEPfB3gx63NIRg6PMvu04X01STT6KW9/BM1RqWJ9yomg01wilP6O5MiPwN5k+rd0DCj4S+HPy6ZrM8qeej23RFfbo9aYh00/BT1bvjsgi+NR5qGyzaS1i4Z5QT6oTPCJNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmmMJKIotd81fkYYy0shDlZ6E9U5SeBPNi3IiX2UcRN2QWwDWs5V7lRRSuRN4oK2QgB8TivgkbnUB9j7kiCMn3vkI+XlEGKGsthf7pRKzN90ZfEBto8wu/JpIsynFmHI4ohvlZO/O3WIZRRD8v7KpM4TROmUbwkWQnwiW76t3p8w0kKUjMHz8cvmsVqzuOCyKUG2o5a56gkTck5Zt2naxdANhrJMYNJbMI6Xi63OfYOOrYTjkl5m2NMUDqpr+91bN38FuBc9BycW1TaKxDqXctg6GcQ6ZAmleVPgUZlfCuK+5AZKQq3WubZVlSIUPgzjh8mEwyEv2XsZgIq6kSlLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=9eeckgsIEyQVF0ihDry9Mxy4+gt+zzKwg5V/WyoGhX4=;
 b=lB9gYXF4/E/aRQEBpOWiQDEymo8RHdjDawPHbMykrHT9G0Zyx6ksa7NsZNyzAOVWkMk4ZeDA7fZSZVSIg2OAZCr7qxRi00W7xANolIdtzM/7fZsG7fw8MXNMf9NCetLytj2jXW0wv+nKCPgInq0vy/NReK63JRwpbNJkJni3J26+Y6QRBZJc6Nvjtxc9VGtcmyaxVXtx44M9D62AQZh65dlssaC1K+M67ksrmSvcuTDKShcyOap0/K239hxfsVUm3hKCY8pJLoj4Wvk/S4SYewA1Q0gBQYDCkhNwkTnFvvu4Ec5xRV6gc/I5eifTFx3DYrHBYw55Q5i18wJwwzHspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3193.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 21:36:20 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 21:36:20 +0000
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
Subject: [PATCH perf-tools-next v5 4/4] perf tests: Add shell test for kernel symbol beautifier
Date: Sat, 22 Aug 2026 17:35:58 -0400
Message-ID: <20260822213558.704018-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213558.704018-1-atomlin@atomlin.com>
References: <20260822213558.704018-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0430.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3193:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b25798-4e26-4779-6865-08df00955ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RIeOhQxLy8JPFevMJ23b48S2r/ij88yaMfIypX86VzSPcobTIXZ06sWDgaJp66KdlB+WmELwRwxbfIPjN8hGBPvrwi3uCWyQbZpTVqhH4FfbHc4E/lSOZVqlBeF9KucegPHkDqjyF0PjdNxk8CsXi8IjRhZf6EK0gdv46tilMxqz5iTgJ1KgupzwwZtQKi6D4ACJISrv+AsBlgTRgAeEkCWbg5GXZnFx9CKJzkmt8+NGuLvWfkgJAvZzknGD8eTDE0oDvydy9HuiRRoSPwR8/NBTE9Ef7bkBC+HEz4IiJB+iIc4fMlX7mIme9btEV36/CDBNroyHoZb0+2O0mOckBSaoB96geO9mfzeNkbnaGozgAqEn5u8NLdkXVVd6RgvAdlJKD+Twp4K/mr6kGvtmGt9lsYZ5Ly0DZMc0P6EGXo0oR1XtpuRYWTCxSryuvHiIra8l2i/xMPsPV0ZXrF3wiSH4zCyQa6H5e7Pua1POh1VTMRoGujLVwVfctevATq972UuqaRa1JXK4pOyC2QDoM7qebP3xFoJYROcaTmJI1ZjInEEVGG5f2pwZ5dm3PTuvA46dv/k7K9HuZAsx1T1FbpBzJrvXas5uKnM+PpRkaLlAmmU9DNk5gnxdqmh8CjzND0XgKKKOrhhOj0CtGNX100b8ynWd25v1fX0Nqw4ZOTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lu/U8vV5nUf2Qjf2r4qAl8J8InTX3sEjGylmh1ioGquGY1mVzwdJuMlbJ21?=
 =?us-ascii?Q?R50Zr4y9POKwBQPkYa3LrUm/w+93YACqlKpiMntlf6T3Oz3VjP/C40qbjMxp?=
 =?us-ascii?Q?upd/k4FbfC91OucNeIBqqINUDDBneLitvH1oG/4wQeMA7DrbGkVaocDC7Drs?=
 =?us-ascii?Q?XayrJLFNrNP8Etmr62jI669fxJpeg3/4/WjufkHHm90JLRLQGhDCWb+OudzZ?=
 =?us-ascii?Q?86F+AgkdkXR6v/N128j3v9HIfWzIKIgkmqM1KjrQh5NTOSKW/XrOiE2Yxxcu?=
 =?us-ascii?Q?ZAH435zv5XUmTDAjV6J7gIrrKT0IB+BHiaErwLDTUhZ05LE91b4pJ4+wUvan?=
 =?us-ascii?Q?LabgRnhRvkBQ4MSkBJa/OIB0E9dvy+JzSa9fXQjQib4yT+vWgwEekZuBP2W5?=
 =?us-ascii?Q?ivBIAvFPxDQu5E8YaTfGFx8c0klUrkKGZX9TKHbO4yud+i/WdW2caaRPEgwE?=
 =?us-ascii?Q?LXlpVHPBpOscc5tGVIW9oa7Nx0TvBc9U73Ya3h4w4axXgrmRPFl0PyLpi87f?=
 =?us-ascii?Q?htb6jQ5+NP+oA8Pn9uR+NasYWldvdjGTjUeD402raR3d7az5oapIYToU8arz?=
 =?us-ascii?Q?hYJer4p8tWOnezg3FmHAlOS4Ykax7YL2Q2HLqpyDuqcMAVMdnVocGU/regqo?=
 =?us-ascii?Q?eEhM1iZDK5wKG/Fw0nzGXjz3r/KuxMOpCkh9ic4WK8FvWU1qd7rMV2T3nNp9?=
 =?us-ascii?Q?hUcWsAHOLEpjEkAtKN04GzEx4ZLPx/WN/QQQCQGXLMukMesx8UBXjw028Kx3?=
 =?us-ascii?Q?sRLkQPbUtMPvnrRhqQpVXlXRrOzxNE0Zz+UjxaIL1veC1gmLrMRBc7XEvCPw?=
 =?us-ascii?Q?9RThNWr16IHbXL5LhW5CCyF96DO4U8LpGHcZpJsU1pcSK7pvOAsZP3oCg2tD?=
 =?us-ascii?Q?hnjL3A4UCDRtkxfd7VqvLjY+xg0UbeP6FzoWfw1DphJrVnKusgD9gXKvvRtQ?=
 =?us-ascii?Q?aTUZKcVvOCSGZiv0m/e3mXlq3e/vnlt93N8zlYDijnRgoa4b+uAS4zMgJKtH?=
 =?us-ascii?Q?ioO2zENXNDyxC12bG8I5k37Sw1WwnBcVm961QZmlZ/vyoZliAN0vxZONksUB?=
 =?us-ascii?Q?twrpajNRMFbJXDD9g3cdtWiL96doUPkEnwISxqHvXTqv5ppstXharYbjmZMA?=
 =?us-ascii?Q?k0Yj9eoZJi+VLXJtHq2MXIBTmJd8yem72VHEebvksBi3GKlce3ZbBNXVP00q?=
 =?us-ascii?Q?kcNheMHuXAVjnZn6tmCBLXbBTNG0ypGastG02sKdXbJWC75pYT8S1itXoukR?=
 =?us-ascii?Q?f3lAyseyuNbnxQ82krCit+pCXBv1dN0lJotT7pdO2USygXVyoj863tSxbfox?=
 =?us-ascii?Q?AxWici7b9MbDm9usDz163AbXjnWG3z6YtXHLv94tLZtUqgnUDVygxn7n4Gh0?=
 =?us-ascii?Q?BaWwoBhZiddm6d0BQXfDHR5brPn81cUooWh4vVI/xQrdMrdmOdNOyJmfj/hP?=
 =?us-ascii?Q?tYPZqUosGbZI40kYTEEwkQzz6peJFXmlb8JBgnSzhYtgYGAiG/TeR98NN75U?=
 =?us-ascii?Q?9JT8hg9IZEqe6BJkvnvXWSNcHNmDQd+RdcSvw0b9eNz8rj9rfRzPRtvEIU9C?=
 =?us-ascii?Q?SmnLJgFu9/YXUut4naIXy9x2eoyiglt7HuxIv5QWogt5HEUPeG98bBX98ff4?=
 =?us-ascii?Q?3MyRznioZjyvLgQOkVsXRTR6ofXkCzkCRY4hT1/7YRwzjX1lGcNTlxOeGH7R?=
 =?us-ascii?Q?+cPxnl4xsSY1s5dtmnR1ih+NEZaMVoCVbYbMvbhDFoFX8hF8?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b25798-4e26-4779-6865-08df00955ea3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 21:36:04.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwxrtW+4glHXGQYOEUXpWM2/D2jg+s/02Zc/Jn7Buh1VP7B7PZuqgbk1vlLuvpOW03GUnaLaCL+y4mOFji/FYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3193

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
index 000000000000..45c803338d4c
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
+  output="$(perf trace -e kmem:kmalloc --max-events=1 -- true 2>&1)"
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
+  output="$(perf trace -e timer:hrtimer_start --force-btf --max-events=1 -- sleep 0.01 2>&1)"
+  if ! echo "$output" | grep -q -E "function: [a-zA-Z_][a-zA-Z0-9_]*" || echo "$output" | grep -q -E "function: 0x[0-9a-fA-F]+"
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

