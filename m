Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022077.outbound.protection.outlook.com [52.101.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E9636A36E;
	Fri, 21 Aug 2026 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345381; cv=fail; b=IvOBNWKNtKmRsn6FIGbatjhpXnAwsEdnmwSSo0ngWPYhnJ5x/1jaYn93i/B8RMthS1jYLASzq3i1Nl1zPWZi6wHjRw+MQgocKd3PHykIi7I5TZR6phnOkUrycIeeFzu/7KABf5S/2NAOrX6NOQTyz3506FZTIoWrVuOvoUmoXYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345381; c=relaxed/simple;
	bh=/dT15EN5BtXqC/Kc+JIYw1DdFsMy6ur+RmiE+0tyCcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtqlwyIk9TWigF/xacdJCQiG/daQMJP+wuKmf8zIdeULVm49hDi2ACl64D+Mx4YpQw0Z05SW8Q1QHLaz0lNspdYUETvz8W1JTLP2SHDlj7RTYMKH2vA6NeGZDvzAkSf4O1RnZqUKFUadKIYROwFaH8/YBvuhHfoPRhcCWUyhm6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRa18nCxcZ8XSZ8lgDdN2goF65ZOK4BXyw8y97CSysDnSNSHvWSq4TT9Lq0iErbFmW/DszGgMH6FotIy1l6ZAi/sokOfv5reRToUWbdbDCkMGsaWrzIYDSNbO98gh/lH5/X6ro20/VP7iotZxsEOpOKBB6WC1mnceg7OMzKBRYHfIzgzlc3lxvhrf9IqHDJxtQJkhv3ejizuyLOj6X1Q5mb5QjjgRFnh+bveiSfSvHxuAwOfG6L9e8p7RHzd0LRtmCU2UJFe8/H81XhDAkk9Fb+CitYyvn952X0SiU0dhAeGcw4EZaORsdh0m3JyO8WWnP1LFY4WzHaIaB5bfNPoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=+LY40U8azJZOZVX5dkyDjbVu9cZgdNS5hWk4U+zDsEQ=;
 b=k+xH5m0UdGK9bQzIj/NSTeyJBhKYqbHQyLiI7ElG3RVU+FCMc7//YsmVVDZeMrdaoLjWp7VNwVY6v8HGgQNLVFBo5dbLLN0VVZExocYShKxOV8jdO+b65Mc9ydz61FYNOtdvGSHWhGAn1ESYHZ/VaVekvnul8SujSKlg01fMsZWn6y/Xb6d7L8BrAvhA6LfluVoiJZtWB2j6H8IE4ypMDy8mSv44HiBkpRRt3PKjZ5qICUbIht7UTRbvtdJpgQiMwNp2GnIvG1bwAHafBRg32OozDAtqJ7nJa7zQceS7wDx1679eQYU7kGRA2wr9PoNTsR4JtDD7vGU6ds4/y4VX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB6104.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:25b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 20:49:39 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 20:49:38 +0000
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
Subject: [PATCH perf-tools-next v4 1/4] perf trace: Introduce kernel symbol beautifier for virtual addresses
Date: Fri, 21 Aug 2026 16:49:27 -0400
Message-ID: <20260821204930.679027-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821204930.679027-1-atomlin@atomlin.com>
References: <20260821204930.679027-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:408:fb::28) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 54de1ddf-b9e9-486a-40bf-08deffc5b74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cIvb3GjC8p735GZ2Ams5JPen5aHC+ahyiKhZlU9+W0CwLiO4B/DiYqevOwUJeRowHmTriEnW99egVC1T+PzPhgvdBG6Bvi2Gu7e/EU3rPIOVYpgQ+3IdaMQIMXj6R+w8tAA8cJuR84rJCDqYpdKdgDT00Sq6HWYa7v5jMAts9TKbmr4nG3fXbYkuseKKeGXhweSVMduWrDEVn9CHvdcabnFSgaEAReG4637RStY446gxj87QQaxejP9lgIETSXxomLq8HrSo+t2ZHThxpgqyq9KuaOZFtyFg83myaXGZAMG2afEEH8J8rbyta+UafT+0PqZ/nHJbjEgs/ZdvYW7ynbGDOu2ytFRAwHWfYwc2Yu08jQ4S10XRVCv+URr/ujrWHm907bN7k9iZrCLl20ex+fsv7XvpcduLSQqwUKc4OJ47kh08bzGFwNjaRgSxgB+Di8mP7ZvD404Q/+7RD1RwySnyn3vxv6BxstKs5E7/7UtC35HlcgO/UNI1y/Mj4jMX88Qf32zROvawEO9ZgIt7YD3iXsIsXouJch93gynpRyulwG/U/vI9B9nPP1Ay1nTCja4rFLsPGeA88G8aKq2TWN5Y0Mz9BM7Y7lckHyRovTmvdd5HvP+xmrnp777Au7Evo/DkLJYaMrA7+//z25b5pQYjlGYfHCONgPb9JDBdvCI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v3QGe59/nNiNPkHQLAcOaGh7gfwSVouuBYZreaxKZY6ZGhQ7BmxNPPZbRs3s?=
 =?us-ascii?Q?B+vWTJ+pL4OS48Aq+hcO4XfsMUVOWY+QOCJyjLQd3JEzd+pniRpcgYYU19tZ?=
 =?us-ascii?Q?lqbp2oEk7IQzTU2AQvMBmrBHD1RcB0DUeTDxtNHoS9uUxhONQdhL1SL7Vk/J?=
 =?us-ascii?Q?COCd1+pZCt8vMops0zAkTekT5v/qGJWrUBIecnVxQe7uibFj3GtPodLpg0yf?=
 =?us-ascii?Q?yjjFR3m42+1JkdbiyzqpMr7Och0NoJIkc+bd1sas8OerjaCuukIpCixNVOle?=
 =?us-ascii?Q?KNetM27TM2prWqV8JBtLR8lF/fKAbrDd6EAHqrYcvCbRdYO9sAkZ+YRkxFBh?=
 =?us-ascii?Q?LzSOKdE7eLLnhjMCqpRZvE/3bCGAN5D006Aoxp8iNhT6y3NJWpquGyzrfQ/M?=
 =?us-ascii?Q?PirfS0rKFayVLiaWphG7ksuINobl8Ahj+T1UbjH/B9Paxa4BL/rIXoM3mghh?=
 =?us-ascii?Q?O49fVU9gYdML2KpnyhDeutV6LJIpRaY/sYOLW+XnHKQawbnO4+2csCpCaZPD?=
 =?us-ascii?Q?+A85ovo6KaaKp8QzfMkvSmJFKPJiy8SvPGuX/fI7CLSP25lNPw3+VT3jpxIS?=
 =?us-ascii?Q?9ZNgZenf6u3gPTnv/ITMWq8JNtmarP9rkoIsVA2smIDepDt20kgLU3J7bkpU?=
 =?us-ascii?Q?FKUcP8MLzhy4/cg/6+PN33PBJ7UJ7KYWCXGHYFW2w1A8CApAai5X68AMt/on?=
 =?us-ascii?Q?lI5ytXmECj9TlcLNOiJf8/yEeg/HRHaJ8JXkdEtfP8wz++C14mlD3+ZagUdh?=
 =?us-ascii?Q?t3yPA6jCDZ/S952Nxq9jUVKu/bSnJ7LqpBY712PFldBRYN6DF6HFKpS2Th/G?=
 =?us-ascii?Q?vOAQaFbPfq81f41Y3sAaVfz7R35vh55gQdUgL63hkYh0HArrXWGcTLDfYJdL?=
 =?us-ascii?Q?5IwooGiPWTBk+ODqF1C5mDUBd6ogYIwARUw9F75zAlytkEVmFEwcaktU70Ml?=
 =?us-ascii?Q?hbYOYBlqEKAqgAT8/ocggnZKdi/e3qgPY9+pFSI5MLUGZnEQ8maRIkqOdJ/L?=
 =?us-ascii?Q?VsNxisleCIDRY1BOcfQ2aRXGt4HPGgdiecPOu3Wfd+iNSusjRB4cU3TM+Wg0?=
 =?us-ascii?Q?3OMn9e+r227l11A1zJfBPe3xQXk4TGYS+27ibTQe17WxIhueoFma8oBtbptC?=
 =?us-ascii?Q?LNM6vf5ouwPuKqxsETYPTSbjMVarsmSMOOwdaTzhIsap61izEZqWE6SgTxZz?=
 =?us-ascii?Q?vjxRZUF0tJQbahcOoCQZpyDtdA6YPu+7hxO/VtUTspW9LxIlWb6AwnPYD0HU?=
 =?us-ascii?Q?ATFNQsjLTiyvnKgFbCRtItzGEgxPd+MjHQO5CxQV6ZHBnnXQIn0I1YMPaHL3?=
 =?us-ascii?Q?LKJjqLRoni7Vb5B8cW6yDjDwOYYBkzTXTwulOhsigq9ojYCyySU7D+f/OtrV?=
 =?us-ascii?Q?JZy6pUDzQTL2rii9E/j0T8e/5D6NAcocBxp8SJmhGjBuP1tp2gEcuvm0HD9S?=
 =?us-ascii?Q?7k8G1/osgKH7O1W9ChWi5xcSwT4aPB60QeCs3WiCCZ9NG2FqkLjLNptVBAVX?=
 =?us-ascii?Q?VMPfDeambq0cdn3tnonjLlKFIZUwH3aw9jlzzrAcWoVUP9WJ62otTHE8tZux?=
 =?us-ascii?Q?6AbPaUluM+Zva1Yxw+hXutLYRLbR1lzXmbTZUDGgFhI1J4Dv7sheb1NWgSS0?=
 =?us-ascii?Q?sft/7MPUwtBbEqUfkTm3FEyi4oszyIzwgxL3CjATvmoB34lAHSFJEhykShys?=
 =?us-ascii?Q?4xUziANt+hD3D6T0l4TXqXMeOlZ3e5b7EdPeUSnNkS498VEoK+MRW8WIRI/Q?=
 =?us-ascii?Q?vxLGEEzLlg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54de1ddf-b9e9-486a-40bf-08deffc5b74e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:49:38.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9/ODIaA1M94NN2KdCrB8VacT7kgjo7pVRAViJ52PuZu/4YllOz1nOJQDr9lCiVMcEWigx49YhztRgnIkZ+tEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6104

Currently, when 'perf trace' formats tracepoint payloads or system call
arguments containing raw kernel virtual addresses (e.g., a work item
function pointer work_func_t in workqueue:workqueue_execute_start),
it prints them as raw hexadecimal values (e.g., 0xffffffff81234567).
This impairs readability when tracing kernel execution flows.

Introduce a dedicated kernel symbol beautifier,
syscall_arg__scnprintf_ksym (i.e., SCA_KSYM), to resolve kernel
virtual addresses to human-readable symbol names and offsets
(e.g., "flush_to_ldisc").

The beautifier looks up the virtual address in the machine kernel maps via
machine__find_kernel_symbol(). If a valid kernel symbol is found, the
symbol name and offset are printed without requiring --libtraceevent; if
the address is zero, "NULL" is rendered; otherwise, it gracefully falls
back to hexadecimal formatting.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c       | 29 +++++++++++++++++++++++++++++
 tools/perf/trace/beauty/beauty.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c3c7f1f85c53..003048946503 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -750,6 +750,35 @@ size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg
 	return syscall_arg__scnprintf_hex(bf, size, arg);
 }
 
+size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *arg)
+{
+	if (arg->val == 0)
+		return scnprintf(bf, size, "NULL");
+
+	if (arg->trace && arg->trace->host) {
+		struct map *map = NULL;
+		struct symbol *sym = machine__find_kernel_symbol(arg->trace->host,
+								 arg->val, &map);
+
+		if (sym) {
+			u64 start = map__unmap_ip(map, sym->start);
+			u64 offset = arg->val - start;
+			size_t printed;
+
+			if (offset == 0)
+				printed = scnprintf(bf, size, "%s", sym->name);
+			else
+				printed = scnprintf(bf, size, "%s+0x%" PRIx64,
+						    sym->name, offset);
+			map__put(map);
+			return printed;
+		}
+		map__put(map);
+	}
+
+	return syscall_arg__scnprintf_hex(bf, size, arg);
+}
+
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return scnprintf(bf, size, "%d", arg->val);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 58a3206481ae..0f4801c61a5b 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -160,6 +160,9 @@ size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg
 size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PTR syscall_arg__scnprintf_ptr
 
+size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_KSYM syscall_arg__scnprintf_ksym
+
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_INT syscall_arg__scnprintf_int
 
-- 
2.55.0

