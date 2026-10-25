Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.93
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792951933;
	b=enWUTFkPN/V2xWYz3/z+mtIZwZ6Ki4+jsYb7AOV1U/n8wSjy8okpi+lu59xGe+uiX029
	 z07gUZ6waRjwJ3powA/DOdWDBoZTtnNDsKgkk11ptptX0uRE2cdpimPO6AXSJI4jW+0aM
	 lsQgLEcJGnalEJ7qApggtDy5saWGlcWR0f+tIdA1KOQfiPGgkiESx/DJ+iQv72xq2Z46O
	 w+gOI1lQnWuDIGjcx5RU7nmm2N6xAagl4KqX5l2l4zSvE9D8cbNRTGHM7yjVIlQxL91Kg
	 X8UtZ+BUUaQZ7w0TC0LgGhqje28CKg5wAewJjprAhYKhIh9kH4NVNQ5fFDNOkg9WLnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951933;
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
	bh=CYRLDpusJg0d9KsxMCl4z+6VeJtiw7Bf+EQAANmo6M0=;
	b=uWAUruMm4sC2BUBku+Ccvu8Dhy0NcPIhioUV12xl7MtMaol2oedKX59NgHdj0w1U70QO
	 byFf+6rZkA/MJ9ntFDh4X+AfyL8/KNl1zw78Yq9L9/HYil/qgICcE89WjTw9XyUuQGKJb
	 mapODC+CAEI47mOAh4izpWmBaOg09B4DVq5CVrGy/1/oiuYMmGmrVizr4VA+HhYy3BTq6
	 0/hAFEUsUJ2D+b9HESonG4FNDuNUO1JXxqvqw0x2xHLInlg5dpX6RSxTsOoZ0fy082X3K
	 VkLOl3g15XaB04KBBEMTRgAnxjuE/6BdU1f74bjBDur2eejhVCIv9axjXmGbdLK0CBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.93
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022093.outbound.protection.outlook.com [52.101.96.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178C606A31A;
	Sun, 25 Oct 2026 18:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A178C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNwjvf+6iY2jAHexMtdMe36TMNh3xhwUuYG7Jzq9HRj3oQUieCL7z4XRjSRvgyl6GY4Ho7nrdRYyXJTnVZYHyk/OzIffd0gGxC6B28qFtxgwFReGEdFA9JowbHSEb+C2dsdqvd9oea9kly5p+wAgbQnDd1AAy6GajTxezZVXZy4zNbwbEV5ZNlRJqURCm3xZOdM50y1lFzwlZG4EKRBNXfwWZphVOHgW5RHc6ZAXgJdk7D68pSRYLqfWdSaieKjiqQDbEvjgIG5nN1oHdmH2ZLVfLxvDV5un1VWsdhP4jUeeEJAxhyA7LhFFcWQJijGy8mYDtBX1q6Cvfjw8v+29hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=CYRLDpusJg0d9KsxMCl4z+6VeJtiw7Bf+EQAANmo6M0=;
 b=rnSOguxbPciyoU9oZo3B3fG35/4ZTPe7EViFVbGTpekh9YXVoEiHHMvYjDJ7wX+mAtAy51TWLnuSoDZ7fb7s1von8bLewC3vfBgyaboxj8QiLaWwklxijbmnUtKAu9hjWBJ+5MmhClXyBWSFuPnX9vu6G7ElxL5llmHqSJ2ZlrbvQscHC0cyV8w3DlMOwCjK0Cr6ZYZlU4WHLw3VcOHBrtVTWeYV8nS7eK0rL0IcLqzq0zOHwiqo10jiK+Ahvs8sso4cgHSA0uetDreemMfXZADBx2R5jHElUa0lZvCz+olMXZcoAXdr2PNrgB2jMipbLpnZfL6dHWxlvBNagr6w8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6815.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 18:12:10 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 18:12:10 +0000
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
	chjohnst@mail.com,
	neelx@suse.com,
	sean@ashe.io,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v11 07/10] perf symbol: Introduce vmlinux_path__find() helper
Date: Sun, 25 Oct 2026 14:11:22 -0400
Message-ID: <20261025181125.514372-8-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025181125.514372-1-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RI1P284CA0017.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:10:150::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 1322dcfe-a101-413a-7ffe-08df32c37cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|261022105027099003|261022115727099003|261022075727099003|261009223027099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7f+kI1jcfhMB/dAeCyjN2HTGQhkadD830JaSd0PVYnLAwH1u2oi42jNSQSRwYBV0VY95f3xcrv4ecE6ZYFlDGTSs8gaN2XLQHvmUSNeEM0qegOD+uHzUzGpN7W5jrNTpuY7Nxf4t27fb990QtCbCqFwYGpO49Y4bpx7eQKwLjktyet8HuhRQHcYw9TrqtUoAE8Q/CTuTO4QzP3h3Cl3kabF1siVKhezfMfZP+UE2uA2397SilhTdu06gDGoHm+WKb0b2yUrF6cJehdYHyB5a7Cyu7SNYHbSjXwC+VgrICIY69Ce+56crW1bC+m4xP19+zXr3WDTEMtrYHhXjxiDmUro1fOTFRGqXDWZSmKWOnA/eLKCTp3O8DunNbs1QcPwnn/c02p08qN4Egt8LL23pc8MuGNd/CtP8sooTkJdLFWn1zgwLtVjNOsRZPR9Uz8RFaKIAoyO9aEs/uIej/uG7mlXg86qBytdthhXr4gcgdafV9Gv9//JFF1geQu+xQnYuh/2WuFtb6HA8ptsSyq+VM/wrs2WRz6bhS0AeyYDUayYpyozgV/0vITKkC8jZut+G/VjRGuNHZgYrFokKRgrXF4V8ZcoH/FMsycu9611beM0wTNgm+kJfRYdjoNjHptxvG53ydcEqKXLlJAgcWlpKEiARfkoQ9OD/iW521HPZlt0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(261022105027099003)(261022115727099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zx7KVgQdnqeaQtSNOD9ELcWZp6d59Q/OsN7pQL54bs25W7XlT1oLlVn0L/wc?=
 =?us-ascii?Q?w0ZVW9Rm0NbegTJbH+Ot7xID/FJdDNKlupCzXs50NkCh5Vf5XaslKwXUOskC?=
 =?us-ascii?Q?44QJ+HK2zKz9IXIcdMon6HblRJ7eoRpmfnzyCr+j/6QwrKeY2qQJy62zjryI?=
 =?us-ascii?Q?MJ6RLmLiycNTM7C4sBrFunWWR6T7Yl1OXsKckhNHOPog/kxEROwod+mJqjpn?=
 =?us-ascii?Q?wjBqdbGDNC6dW8hB+qUFWSezWPIUaljzAvN4hbW2378CECbw8NzaPsE9xGXu?=
 =?us-ascii?Q?FJ5uZM1ExouJIUcryPNIdqF5ymXyCDOOy3QgU+sJayHVY9Ph68tyUuu0i/Io?=
 =?us-ascii?Q?yEVyw766AoPl0maiYAdfutQvqdLDRZr7mdJGArq5vKCk3GL+P8c42jzKZ+pK?=
 =?us-ascii?Q?2j4Ared1TODdLjz132F/oIBducvmDCD1F9ZwO9Py9JrFzrDMEYsbMJrqalKr?=
 =?us-ascii?Q?vTqwgMKPpvRq8fv8yDmvZkNSb+T4iBt0j5pNqEPgYIgIht/HpF6DlHVGf6XT?=
 =?us-ascii?Q?omn0DeuO7QamfCytRyZZvXN0gwgzhM14XJVw0jk50JoLiwDgv+ru1jJS/wUj?=
 =?us-ascii?Q?nVjItup6SlhQ8ixHAzFiLrDlVSy5KIWSu5B7dHfazRyqKhMdIWlTBlpKOOWs?=
 =?us-ascii?Q?Ana8J52srFeVuxRF+gMbDFrUdQ2kFhMUpvj9JmTYZPUFSC4qNAYEssG+M46g?=
 =?us-ascii?Q?yijgEs1slYZRKwd8avCKiWmWkoO3NItQW2qgmiVVRiXXKoZQRLm0p0tU6Tuc?=
 =?us-ascii?Q?5t6AhzdH3h2i5m0xgAbrqP78aAhmh2s0V9HEaKMpTFb5cwb60hkB1S+AAL1R?=
 =?us-ascii?Q?MyZSLWQkdKfbKUpIBcEeKOkuJxSy3W3y4xDNJDrotnJu1Dj0nLmY1aVzoNM8?=
 =?us-ascii?Q?RPjg6tRsAdySl1bJD7WYsTwCnZNsmqb/0knoDqBCeWQMwQHX6tetwTf6ts6u?=
 =?us-ascii?Q?mtFCc7uZtJVjXuvZeQv0Pz+hMllGUjsnL4Dw7t4xozFi3zhI/IxVY3qz4AGh?=
 =?us-ascii?Q?qu2GuhH+YTOqNKXNpP8Y/LS6hV97cFMoFD6gzzRc8xL55tH1JlFiyrP2cYrk?=
 =?us-ascii?Q?XXPIDp3H6WvnGYGBCaJQ3EP9MdYu8CTwLj6kSZwPZPX7MrSwDSQF7xWAt9Na?=
 =?us-ascii?Q?vscc1/lgEs+eIhcBJZqv9IFoDvAywygKLEAC0VjFZ4LPMXvgpl8/9RNxuYyi?=
 =?us-ascii?Q?RkMm5ScZhzhhiVMwVEE/XfBb0HlxNRNfvTVBcbYEqL/guipOjzrGV70VD3ZM?=
 =?us-ascii?Q?nm40qOureXSTZd93mFjOcG8DCderxB/9aeFF16MiRD3DjLQYzEFzhaoUzTKv?=
 =?us-ascii?Q?qCTfJ5QVkQl1365NEwFCbtLnmJasqhwa70HjEpgl1ZDtZ5YhUcTRUZRwznKi?=
 =?us-ascii?Q?FFzMLQ/QbjejHIy3al8Nl46fJ+nDzfOXTHaim6M20o0othkBX3YvrdI2b+JR?=
 =?us-ascii?Q?8WVU6CaQM0vVsOuK+o2Q/O8FfLS41tkSoyvA+gc6yfgP778AlEhRdOIa397S?=
 =?us-ascii?Q?qxY/Obboc3yLbcyvHwO0B2tlfIVhzO2aIe1+Qc0BwUFVVTT1zv6/WWJ+xxVL?=
 =?us-ascii?Q?d0DYVlOtzmZmC3M6MUDJluXhQawSnbpRvit1LrrpLSENLA+me0QUM14i5WMu?=
 =?us-ascii?Q?3cfG8K9iW9Im075Lnizj3l0cOaqm2OMIb4lvsxzPx78miQRBVzh5LWHlPo0v?=
 =?us-ascii?Q?ms+nd1isLqHPpy/BdGFNrr+Rr8cnaVHaD+trBCrALJzB4sgTcOFgfpFS2fjy?=
 =?us-ascii?Q?daGne6Nr0Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1322dcfe-a101-413a-7ffe-08df32c37cbf
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:12:10.5511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZVNHAgWmhXHuGN13azyJesFlleTfynHPqCAHL0fOV624EWnHCRpy8YBXJ0GTfEzwbT5nySmnwaan+AAxPZlBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6815

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

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
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

