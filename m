Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.100
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792550036;
	b=OXjGv45lhZXrQ7bAzFwr75M+FGsL6CUD8EkC2cYhk74DfdFzvoDxqVtS4ZxnLpYdUKTY
	 Dg61rtAovBiyg9grl9rtnoTgfJaDBcVkFO+t/r/Jz0aLS5DDuyv7jsKonbJ7SRj687JVB
	 fZ2KqvYCOQLIDIrxbQqz7K0F87BH93ksN99k9QIgSgPreIOXYNwtcdd/rc+XS9o5LZUi6
	 uhV6upCac6doShSNJ8TzF/yM/kpoLG7zgZGDZPn0sbqK+x/b43ng7noLD0kZeRiRDomOh
	 Z8WbzNj6fddJ9WTjoKoV9q2qHiSGkFTHBTtI5Yy9bz3LlKeeQ1z5MaPsGDIQf4k7QEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550036;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rKnL1h/NUXkJBkliXBl1Ur+6R10J1GqhjH2XR0mJids=;
	b=itQHbi77mt8Fv/t5n/EXl1/xWiOvSOzWQ07r4ufvhepS+I7wi616aeR7t6ydv45QbaW8
	 +eQ4EFItykfsv4vlAc25yHAaXs5o6MXKNzMRZsTEVaMA5BZMgKfkfbU1T8pLzusXWUTYZ
	 B/lp6QRl2wdMGYUB8wE0SQU1ra0E6jfPu0pgRQ66NYZ1cRg6j+veZQw7ynU/Bgth/ndw9
	 AbKHFmebiJ4GV/erPkvY2l+eqP3x4ImLk7Dr/2RPxhZPXbiQj1wSxihmkVQHf+P7+YyRR
	 5LzMiT+8THDhvOoccYIFNxCMC7LMbQTNPUg1Wwkw3GKybi70O7OEOQ0d8R5m52PEiZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.100
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022100.outbound.protection.outlook.com [52.101.96.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9649606A31B;
	Wed, 21 Oct 2026 02:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9649606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwpV4mp+ijYc8s9kKXhIGS9NlpO5M8uYXMJHe3/euC6LfVo3GO1R1TYMvVFvXw2Ekn2IbLjO9BtPZA5+Obz0kh4yHncNFPx5ZUI/5lH8qefH+tt24WGqH5Tp3+QUrWJ2Nn7qWVsc6Fhep7TV+GrQgetkSlW9lIqw7rhQ5PcPn8pgFusv+QzthfWfL/UwzTT3Rw2ZvTaknTPg5Nr2Rh6ZmfUas2gc/7Ow4Hcp8JsLhwd2rBy6Q9M82BnICBfoKWKQDICuCtTMRT6bvHbWwZC0j7AHZ0bYqva2XeiGzMuLyPSENYiCuMC38aLaK9fV64GnvLgOgJ7+BdXUOM93B6kmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=rKnL1h/NUXkJBkliXBl1Ur+6R10J1GqhjH2XR0mJids=;
 b=RSBb4OnMO+IUPIkgDNLxxEjMk2U+87jAs7ZiAIfLfUthoVzv9NRVQEs3ZsHmvFvco8J8D/LppCwMadQOzaJwdCMo7GbYpLNKWYL5xjTBufgkpFPs3ByvU+TdCjGLHmESOHbhL0XDmlCnNNVt6gYp5EO7DoQKFMzeq8PiAhO/r1fd1JCYhXphqlwG+te27Kd/kKL/DRHHE+JuR3yIgQwo7IKtj6qMI0RMBmpx5Lzj2VAffT50JBIyNokvIwPOOY+WiV55fZivzdz3KwNBGj8weILEvfxtUr/WUFKvLp3kXaxFRxW4CULNmmAtjPECjwvpFRGoS/DvMpQDllM9vGoeIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB5917.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:33:53 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:33:53 +0000
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
	atomlin@atomlin.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v9 3/6] perf symbol: Introduce vmlinux_path__find() helper
Date: Tue, 20 Oct 2026 22:33:34 -0400
Message-ID: <20261021023337.809936-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021023337.809936-1-atomlin@atomlin.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:408:ea::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: f4aaa087-a119-4e2d-c470-08df2f1bbfa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2ffh6IRGaOxIZZW9CSdck8fvOjFdW5+Uhuc2pnkHoiQTXQrR72jVkp9tyfndLm6vYZysh/ZB7K6T0f3dskaL7JjcXccYHwr/FR+9Vo5wvGIa8jWfHq5WAZXkYPLe5S9EYpEtLouFa17qCtSGEbsBGuPoOCQmBW2ihaylpqm+jSTlLdrOzSw/WiAsITnuKp4kvwz9letWrdStVeJNU+0DbJS60eA321Xs0EWQFaR4kVony8zk+ucbvv0Z7zjo+As6NLfqOFKvxm6sXqmI0PiiRVFNMUQVtXUk12M0wGT2GFiwNK8B43VQab+XUf7Z5+3cQ4YMK6dBLd9yOGrUt18vzuMiWgJpPKeHYcQ+TnAb0tQY1+UniCI90mx4IkyXsdXgYuzexJYDrMZqbTMqsDFOYrEkVlAFHv28OyrAX0e5Dms3aL6wOcwxuIgZl6ltC4TP4GUV+0Foy2IBGphoZaPgejZJEvfYgHvspN50BDjOwHsTNFy2zwE6j6n0ZbJFa8FlH9x51j5KX1+rnEb5zNolQV0Qyusfo7M5aYoA174+OlgTqEtZaXJDjHxnygV/ldUlolBAOCKcB4Tff8jreVXrYHl4rApMQHWvQerQ3XaZPeZ5JvjkQTocFKdn9C00ov5LtTw5VM2BYOOXwlLUv+TdKECzPPBJDeBn3cnJkwoprMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s7yBF5u0qTBCGMR0hWTlnjfe0sHA6XZYlEB3AKZK+ET+EW1pPAJ4oYGo3Mip?=
 =?us-ascii?Q?cXWq1xFqZV34MtZP/1NGgybKZWCApRYRdOi9RsCSkrk589xPrWsDtrQVjsp/?=
 =?us-ascii?Q?sgTIHByiDyho90eFv2a3tctSdsGNOVh1SrXfJjaTPvE24ULhBqWn73RlSDdR?=
 =?us-ascii?Q?sZk/BrECiYuNVjyO8Af6Q6/Le2/ZLngZsdq4nnSDt1cPkdLlvVb52r7YV3x+?=
 =?us-ascii?Q?M/dGEGpjseQ0vz9Iz7FZ1uzuLPP/llFKO5f6iILP7XRvGYSLGKz/25KsmgBN?=
 =?us-ascii?Q?saf4F/FRVxuiddLWqI9pWy0pCc3bAxhgdjmIaSQ2vZ+Kt/oITBgRlIBSyXHK?=
 =?us-ascii?Q?C6mIpKEV/M/sLZ5b61eiGZZGc1GHoMlO+73kHsWD9lp0veeJwrLsJid7ahqW?=
 =?us-ascii?Q?4wR1ct5aWvSL/8lJTt7HGfONdS99mZq0Nlyu/Psj2ooexnHfyc4FJecv0RYn?=
 =?us-ascii?Q?562b0Eb8tMdnUxdd0hvUByY4X4MnRKPyVqPxxy6F+PBgQYRcjxzbKCVmF78O?=
 =?us-ascii?Q?vaUKRJX3v3E4W3yMda6zfBN1N8WoMlBCWkZXAxfr9XF0qeu0CZz+wdPjC0Sj?=
 =?us-ascii?Q?lNxDAqf37lVL0I/GYtXfzch2ybM6331/37FXSPzZMfUs6I9bV37zanvjbxmu?=
 =?us-ascii?Q?ZFVZHZ47TEYz3DscgA2TAEmQ3aE4akuRmEli9xMP3U8s1g641m6RivKiSzIp?=
 =?us-ascii?Q?jdLlZNNQHUcKue/VIKVJC+01wFZNK229FiIXtu01hfRGsk4avT3kXLYwA9CH?=
 =?us-ascii?Q?K+Z7WfUVElqzRDRKJU1iU/hSB6EZ7jpSyxb5kqJQrWqoNkJVqTV1rLlpSzv9?=
 =?us-ascii?Q?hEmqosC8JXue7dOoRgpyVot/ArO6QOngK1R2fAP95Iei/h8r5p3NwckTOr+E?=
 =?us-ascii?Q?oPfrdPPHXyeLkxCLYoGrXppMZOPn52BzeXfP6L6KH8Mu1WGsBnDebJSqah4W?=
 =?us-ascii?Q?28mksrE4bw8OkKlCY0z8/ogt42VRjGxrTbSj9jdTWxO/1Rc2Ejuc75YoCqRH?=
 =?us-ascii?Q?xHDLA8OZ5AwmvH5O+4rxqguThNhuQPN44ZDpaqBsC3bh4xXk6RoJLFACWO8v?=
 =?us-ascii?Q?Cpp8w1B5Mo/uIaFjZ2tSQNxz+EfcKYrfAC/GD3p75iKow6esIs9ybFcPNqqB?=
 =?us-ascii?Q?7RDGiP6Fk6yevXo3RiPsM+yBhyU9dJl1chLx9MLr/wdn4pc7oV9y4fb+h5Qe?=
 =?us-ascii?Q?T/m8GeA+TumB75f8ezrqvKDH6FgJKQdkAkH5BRaywZsNDNxN9eNq/4viAYAi?=
 =?us-ascii?Q?BVPfb4nIQXDTqx6U5Yqy6Vkg0xQMjKzJHBR/ngRNPlVklEr0MPK7DexbNtFI?=
 =?us-ascii?Q?CpLeplNNdwrMO2dbBOmy+jsschzkqdEdyBUTiQSWAYRkB3BCJhwmKtmzzuTk?=
 =?us-ascii?Q?hLsWVF5656BsSUzBM6m2IPhrdA7k/19+OfLsNNKQKhkJDfw2+k+fqOqwCT/Q?=
 =?us-ascii?Q?SjxK13vpaysvq4olNfvR30gUk/BSeUSCM/L1U8e+4F7UvcAIQOmIku548nCh?=
 =?us-ascii?Q?8t7dcNHd87R0EXznrA9nRk2MPWVKauaQvGS+/D4TvrYnR2SZIg3Cj3iuglYx?=
 =?us-ascii?Q?bSzkD87Ws5GyrwUlMyV354/tpd6EKcjAhJ5Yf9km5tgPJ0hBXixFAsf25Gjb?=
 =?us-ascii?Q?/qwL1lPt5nYFVO7NChnCVM+Wk6yAfsTKSCIbKYJyngEPJo7j2KrDxxqNDIkT?=
 =?us-ascii?Q?Dr1LPGazUObThPkhlDMmiyOgu85e89ZRlc6yum1Hb9JgpUpYkT2KF+gFZWGE?=
 =?us-ascii?Q?0taUQbYEJA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4aaa087-a119-4e2d-c470-08df2f1bbfa6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:33:53.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvmKv+t7bcNS+REywE9ZFwgqnhu4GqTVRRf9EirzYU2CCz8nkjNStaJl3q/FfMslPPomPlJ8JLHZPo4aYssUyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5917

The vmlinux_path array maintains standard paths used by perf to locate
the kernel image (e.g. "vmlinux", "/boot/vmlinux",
"/lib/modules/%s/build/vmlinux", "/usr/lib/debug/..."). While
vmlinux_path__init() populates these candidates and dso__load_vmlinux_path()
loads symbols into a DSO/map, callers (such as test suites or probing tools)
often need to verify the existence of an accessible vmlinux on disk before
attempting machine setup or test execution.

Introduce vmlinux_path__find() to search through the configured vmlinux_path
entries (or symbol_conf.vmlinux_name if explicitly set) and return the
path to the first readable vmlinux file, or NULL if none is accessible.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/util/symbol.c | 38 +++++++++++++++++++++++++++++++++++++-
 tools/perf/util/symbol.h |  2 ++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b61a574ce9a3..fd4a4441718e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2337,6 +2337,9 @@ static int vmlinux_path__init(struct perf_env *env)
 	const char *kernel_version;
 	unsigned int i;
 
+	if (vmlinux_path)
+		return 0;
+
 	vmlinux_path = malloc(sizeof(char *) * (ARRAY_SIZE(vmlinux_paths) +
 			      ARRAY_SIZE(vmlinux_paths_upd)));
 	if (vmlinux_path == NULL)
@@ -2372,6 +2375,38 @@ static int vmlinux_path__init(struct perf_env *env)
 	return -1;
 }
 
+/**
+ * vmlinux_path__find - Locate the first accessible vmlinux file
+ *
+ * Check symbol_conf.vmlinux_name first if set, then search through the
+ * initialized paths in vmlinux_path.
+ *
+ * Return: A pointer to the path of the first readable vmlinux file, or NULL if
+ * none is accessible.
+ */
+const char *vmlinux_path__find(void)
+{
+	int i;
+
+	if (symbol_conf.vmlinux_name && access(symbol_conf.vmlinux_name, R_OK) == 0)
+		return symbol_conf.vmlinux_name;
+
+	if (symbol__init(NULL) < 0)
+		return NULL;
+
+	if (!vmlinux_path) {
+		if (vmlinux_path__init(NULL) < 0)
+			return NULL;
+	}
+
+	for (i = 0; i < vmlinux_path__nr_entries; ++i) {
+		if (access(vmlinux_path[i], R_OK) == 0)
+			return vmlinux_path[i];
+	}
+
+	return NULL;
+}
+
 int setup_list(struct strlist **list, const char *list_str,
 		      const char *list_name)
 {
@@ -2598,6 +2633,8 @@ int symbol__init(struct perf_env *env)
 
 void symbol__exit(void)
 {
+	vmlinux_path__exit();
+
 	if (!symbol_conf.initialized)
 		return;
 
@@ -2608,7 +2645,6 @@ void symbol__exit(void)
 	intlist__delete(symbol_conf.tid_list);
 	intlist__delete(symbol_conf.pid_list);
 	intlist__delete(symbol_conf.addr_list);
-	vmlinux_path__exit();
 	symbol_conf.sym_list = symbol_conf.dso_list = symbol_conf.comm_list = NULL;
 	symbol_conf.bt_stop_list = NULL;
 	symbol_conf.initialized = false;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d0bac824c79c..6d1eb08076ab 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -184,6 +184,8 @@ static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
 extern int vmlinux_path__nr_entries;
 extern char **vmlinux_path;
 
+const char *vmlinux_path__find(void);
+
 static inline void *symbol__priv(struct symbol *sym)
 {
 	return ((void *)sym) - symbol_conf.priv_size;
-- 
2.55.0

