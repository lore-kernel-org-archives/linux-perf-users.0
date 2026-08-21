Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022106.outbound.protection.outlook.com [52.101.96.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01436A37B;
	Fri, 21 Aug 2026 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345393; cv=fail; b=sKu0upCBXKbeWeX+uSDBxjpUZUby7WhG7Rcy/KTBE8buf2l5JjkZa2E/HtuGB3UBxhfmL7iKF0EeM1s13CnBjZSZojy/zx6zUCOT12UztWWedvoSfmT8tLapNIKtweXYPBInjY9yxTD+u78QQjD1Sk2v7n/RdeCASqpKOpQ1DlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345393; c=relaxed/simple;
	bh=KSzkEkWyVNrAW4939Y+u0MYFzxls+lwsFKNV6uDG1Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vCyMs6yNor19uhiIEStA6QEWB8eeKqI2FbpIZpCjyPIn35HMnUcn2PejLrLaBlXv3clULS0yJzx5IP9B1FxpzwrrH/jM4+fkPxZxycr7v0dnbAMV70uhdrCp4sZuAL5nX24aYtOR4K5VUFm9MCNUTtxLOkNSN8K85SE05OPmKe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/MvppMgEs1o1P04Jy8cXHhR1N/+9hYVG5BBhLMLNuyVEKbSw5Fsf+vaR8n0oHrGLzAMEE3fdtfAli9/T6TKR/3ZGCkF2cwZMkv361EeTggnw3egMWH1ed+kT4d6if0g3Ed0205sh5sSKCuX0N0Fi37D9AEm0MrideX98fCUACqiD9b2sSEQSreRSW3LxNIgkZ3w02eacz+Nqi8l2s66q/qIk7nytbW9Os9zU5/UTjI2KhufW5u5zXZTxb6mlyBHVw+SXsU/htmhTXNAAEyY8VQkhS640Eh3O06S0lqR5w+kULNbfd5/WgV0/z5RrXfTUtdRo67FrKIVrTfyDkY9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=RiOjqwRYcmOSgM2wzySgoIHISgvp6LKypH8lAlqc8Vg=;
 b=QlDNRpyD+5IP5P1GXmJ1AhOGNDhVkF99ZY/MsrPNh0oQzfgZDqhDnSPwQ36vp2/xhNQLv8qt26oqncCFvTSQebG6QP0k46+/5VrnQhra0cjeLDkIEF0QfKJKY2qyARgQc1J8iHlM434o4acVUrXhV2ZHbPZBj1JRbDdxizhh7k7aC98+bQwDhscLPUW6lRQNp4MTB+Lf3AhTLZSoz1h6MPp52AgCSW0PqhmOZALteujQvXZkaZtJx7jrSjCGIsUgFvgr5lVqcfhRtfaGqlL4zRNzIkGZLDo+OHyK76dXiPr3iEB50AtC1Pws+nimtvJcRnq1jyeSR4Rk3HZbKoK9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB6104.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:25b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 20:49:50 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 20:49:50 +0000
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
Subject: [PATCH perf-tools-next v4 4/4] perf tests: Add shell test for kernel symbol beautifier
Date: Fri, 21 Aug 2026 16:49:30 -0400
Message-ID: <20260821204930.679027-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821204930.679027-1-atomlin@atomlin.com>
References: <20260821204930.679027-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0636.namprd03.prod.outlook.com
 (2603:10b6:408:13b::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f9465e-c053-477f-f29d-08deffc5be45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JnUEUW8SrWryD8d8G4FWHLHuDLvFSQ0TDzU6R/mzo1+qCsMZTQOVWhoDJqM30J7s09DJMqGNzILJzzjlRj6AkLfC3/ZpYTNKU/B6mcgdxcu0W2aQig5qBcIVDeiBDrBen0chJGe+1bIcdhaRUnXg51tRBOWxJcbC9zm9vxm5E+AjAskK9kUjvh6TUqcDJzGMMB+e0YSZpyiO/pGrBCde2c6J74GHNBdwNH9NRY8akIaTVNRNGldY3yEHrusKzdl0XwTBamh7tQutQEtH53ypsPGLHKwRQexN58h63cXgXkTNiZxIPdwy8O6exONt5wPjHfoZuBgkhZ77KQ8UYTLeW/0mSbhNjqHvWOlp5FBQgJNhl7uQslFDv2kL2v74juKwdOW/HcmH84/Tgztf2H2DWEjfMefEvPy26LoyjwVLptliAQLVlp2S+2OmUqDFCO5BqkNUzOfBzh/IMF+z2jdOqByiNSmXNYCM67MpGSysuYi0Q9n2hnP9i+N+rzvMRqugt0DjRnO0oqj1NCWc/Wy5q9XNG5Th6OWYW0uts3bL3VNcUuhA4XRE6rfTBAuLkUDmF0ZQRdpdju5BdAqxwpE4VXFUzr/Siw1Xk9Rlw8aLK4Bb7VpV7XQPdsQuPWFciu1qzADVcZPPo1JphE4qKPgxOHYqMn4D5hX1ANTemwZAFpY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c9hBxscF2yYEJq5hp6lu/xYOmVjj70TfHafYwcPO8InG5pCrov6uF41bx9xJ?=
 =?us-ascii?Q?x6W9JAXBUZcZx1bBkss67juOf8WqNekD0HdpKu058TA4/12RGDt494RmiBxw?=
 =?us-ascii?Q?jfvM/sd8YSLVWDBcBrj2uRKUCaLc2zNixP1lpmIVP1IY34EIMhsTVyB6itG0?=
 =?us-ascii?Q?vd9J5SB3il4ue5JH5OrNnoM4sAuWjkGt1VPObLo2IbT/bjlm0RR/yVf3XXTm?=
 =?us-ascii?Q?s207qWMnznqcevjhQsv0koihucCI+bTaAEYEP5ZFxAyuEkmf3yBvl0ba1PL6?=
 =?us-ascii?Q?X2yCRRQT10V2RVnQwYCrDa9a7Rm/zlPetBHQ1Ui3fh/jSDtJgaKvclvv4w7f?=
 =?us-ascii?Q?lnd3WnLZ1Hd6iNNIJ9C6KKNweeGZ1vDrISCgQoJmzjN90elkNC+U64ixzNob?=
 =?us-ascii?Q?ShmFDiI/+4UIma6HOppoT3gNpfH5QI6KuCIBLD2Dd6PJdz0t0165e6OSfpva?=
 =?us-ascii?Q?c9mssSz1BSJDvpG2RlotDATEVHLiaErrXmT61amRG8ptLy5B3aoeQZF3+bNx?=
 =?us-ascii?Q?nmJUX92VLxyoarK7zO2iE1xRSJJTvtKyjrPyI2YoKzKnxwliQFnWyCFj/1w3?=
 =?us-ascii?Q?bvhNXaZZEJM2BCleQzqKrfmeS8XgCowm57tyOHP3OiHNoKvL5wCEFwpJqt8u?=
 =?us-ascii?Q?buIjd/ISuyECuVWg7MOGxk196FiV3Gg1PBJ62MqJWD8fAmvWBKxfS0pULEPG?=
 =?us-ascii?Q?qMAtCfnVepCLmfz0pZv6yuDyf44HqVJeEqijmkT8TIfagtEMUsKMgroKZlAW?=
 =?us-ascii?Q?l+JvGNCh3s/v/N9VuoaHtzyUaays4kHlnpNgkRnpqdARcyATtiwB35uDQoD4?=
 =?us-ascii?Q?rwBzlcA1N5NXp/bM0gnMkN3/ex3pzID+6P9PDNdw3Vt6JXpG1ZBq6u29e67B?=
 =?us-ascii?Q?c6HMJBYiZ/h9AQGdWFiWHUFpBwSjGzoHLr1WjLs3/6SAE7Z/OIwJy+gAUIPE?=
 =?us-ascii?Q?VRu3J44SBPNKT/4L8yHZnSrgHACgVkWx1sts8/iGzXgE2jHr/NromFbbnETQ?=
 =?us-ascii?Q?Rc6OyjHpx5n6nqwRNh7kTPVeToUl+jiXa1NWVPmuld6H8CimHVK17Gs2Ep7s?=
 =?us-ascii?Q?HfkmHxEqc/rp42/o8cHlucSyUIMwN1MtHbwEvnYOxqjb34pPu7ZwS9k0rPAG?=
 =?us-ascii?Q?pY4ehaiDF+yXCumDwXuoEX1HhxBuO7d6EXvDdAckYdgoCamOi6MdY5qxufot?=
 =?us-ascii?Q?pd6yW/d0mX2DpJ+fd59VaY1ziB+qWU8H4Pioh3YFr6dlUCdCSOhcouCWjiv2?=
 =?us-ascii?Q?lulGIvgeCXtjhyExuv5Tp4hn0H6J6BRHkIxpgTRUiM7qwUu0QHoO26sgh2Ju?=
 =?us-ascii?Q?Nl+Rp8i0WlzKKo+QK3SGV7yX9DqXdiWkWr/NfGOHgXGKBg3RWodixuuJO/WC?=
 =?us-ascii?Q?7YgZPPkMDYWjJvukfykKjFO08ntlKqBC5kQCT3ccRgJi8346KS1Jmu8s2dcW?=
 =?us-ascii?Q?kjlNLsh2Ou7vQaxe1WE5rHrEFLOrSc1eFUTd+6YmqbRzhtVOB/+xm21d4Mnz?=
 =?us-ascii?Q?14wbVXjXQOEV+Bj1oeAdkSQO2/VsTZ4freyUXoYfnohm9M1WrUEErgFo4eUf?=
 =?us-ascii?Q?yQr0uw4mJyxWIx0V7eT0qdNNrbe+HAs2kcY10XGESw3/NkCc5yvZ7/ym0mo3?=
 =?us-ascii?Q?j1vmhMW8UMxENFbOnIPKm2k4q2rCMtAjGFu0DpeNqjugCsdlpaJ4ElZ4g4Gr?=
 =?us-ascii?Q?/ac1+IfyOe1Ys6ZrFrCJrhmrMpxAPhYtgZLGSdDP4mRpX9JP0fglGR3OMVV8?=
 =?us-ascii?Q?NMUqssUTJw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f9465e-c053-477f-f29d-08deffc5be45
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:49:50.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDHy2dmfjzP/DwwikAn2OPJSyzaGxztKjIxqKODCNx9XzYhsVVRZqenCPPwXXjPaUjlKndSxsE7Uq0L6KxWPyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6104

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
index 000000000000..c030b03e2b66
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
+  output="$(perf trace -e csd:csd_function_entry --force-btf --max-events=1 2>&1)"
+  if ! echo "$output" | grep -q -E "func: [a-zA-Z_][a-zA-Z0-9_]*" || echo "$output" | grep -q -E "func: 0x[0-9a-fA-F]+"
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

