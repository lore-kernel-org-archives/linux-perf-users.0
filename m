Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021103.outbound.protection.outlook.com [52.101.95.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B232333ADAE;
	Sun, 18 Oct 2026 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291093; cv=fail; b=jQn2uc6gsk61GQhju5S2ydUd0KcBRFDKMpMolhNJQdcLbJDVePbj9SQbQ2xrybdgMpONn1VLbN72oLMoP0QPEr1E6YnIqplc+MDc69YHNjJrF+LTmE6wMTe10zlNjvLuQ6CIAXD6FCP/AYOH/n0jKiZeGdGOqHGcK2F88Oygrf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291093; c=relaxed/simple;
	bh=PWrnZqpxMCf1shNzWS3M6l3l/wkSFhmjjCApVnpd43g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHpb+hFj4J+rLLmXB0xYIrWygWkN5Te3Mi5plBsmanA+x6GiX4ghv8nRGnIxW30aBcMBGxNDfhAOdZrJkbB7CF/kWMBPujz2VuAs4/PW7MYfOsHF494XbNSoQk+2AQjgyEpT9jyqHnfbgvVCay7+ZQlMABQFNp2lFDr9BTTgRR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxt3umY6Br3xYYzuRn84ktVQjeOm7C2Pzr9PKTxBrNHZ/T+WikR/drAT0zziN/vsla/7tWKe6GZma72P6RmB8U4L0rQXaz3WHTiKtkBetwxLhE+wgfpd3MEqyE1fU1wZaozFf+vzfha1yw1KM8gcUmzKSuvA6nZuxdznDvjhcqKP8fXyODwWt9x2XpDDDg6rTPK8cCX8N2RjkrjxwrLPPf7LaiJsWkv7yx0YD4+MGcmtFJ6vpuQ893E4Pu7xeM7B13HS3/RfIROpv7FZ/+M/XatHJF9oUH+eaJiITz/+uIpjXkMIoBz437EAKB3HxUPgA1vFm+Tc+/tJASTmS35Iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=XE+Ndi8EqGlWWWRkaPBjQVsn1HMKZoGAVjptslju53A=;
 b=xFd6gHgc2VQqigos/xyPPocoRklOuyp9EJ6QDsk0OQ03t1cqGptevQ5xWtPW7ndl3b+lsytn/p0u01Dqx4Iv06x0xQeRgYg3ym/8wTrbk6mK9r8XwdAfpVk+qIeKbflEMlXEJAeQn7O37psZYl5c5l4i8afaapNZIUx9P80uiqtmHLKWS02ydifZMH2n9CgUvlfn9uHejo3h6jE+n9kX3mhFPWWvQ1wG2a6mFHOvBfAEVfbl8pUoLQiNddix0p1XFMjeCgaVIlGS1qTPnNIqxC4RcJddujYi6RgMpyRtUpunrb0j2kVmAeogFXbBZy4FkpVQdErQS7C7reXPQJ2ilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB4333.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Sun, 18 Oct
 2026 02:38:09 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:38:09 +0000
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
Subject: [PATCH perf-tools-next v8 3/6] perf symbol: Introduce vmlinux_path__find() helper
Date: Sat, 17 Oct 2026 22:37:50 -0400
Message-ID: <20261018023753.584873-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018023753.584873-1-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:408:ee::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: e299c586-48e1-4b6e-77c5-08df2cc0d8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|261009223027099003|22082099003|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NMfC/s9bGyaM0Mdv7n9RJX34h1qHXWJJSbux8JgAwi2YvtBW+Q4bBRRUEeO/85/xrJdTeB2qcJMDIV8JQ0r/qdZctEhgbZezfb+KKmwmd452V1CVGxPHL7nuV9Qmm+wYmZtgMYE0m0bsOIbNaNQkVhorTNNdp1Ht8d3URLbg0jC8cGeIM0yBDxCGIKyYUJ4nOu5LNUvmJ4V8i1JcDkigkFcszlfsuCa/r7OX8nAQooBnr8aS7qp29COD2W0zDYsCZptlbOWnJpEaq70bblEZz+VtW4Ons+Ady9gIRmmDWLWu3u01PMlTo3RYgeXWORWbVQatilSyd0fquzDd/2wtwlAu4SQ3GdiWKkJYOSxazCfa5qiPSELz0uxgW/Zx5e88iWN0nkMfICG4+prTGwr0vCTFQkt/SgDczgmE9OnRV9lTVUzFxnMeK+JG1FJbNZgfbHNxbqe0i2dpfoaH5UEy1WKI7uwc3rUxCZvhsAhGM4Dq2rZZpZoWqgSfZK7MOC7FubzcIBU5fYLj3VX4DEbpEpMbaKUZVZTI+UK16o++861nxDIMuu0QzDHFM/TCx2NZTyvGr4EdUDnLE0wDO/v16QXeC4Pqr5i1j4ZNX0W1aPjFkz0eFeod2lfonKK1eYx5DAbs/+gq+XtYNkJP6uy5pwkmrRMoAvylBGjNjmhTELM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(261009223027099003)(22082099003)(6133799003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zu7INQcmmyYQ2k5Hgj5jgDOCXhZwpc8DKyRBXe01vDQm67hcixSEW1bOgKBr?=
 =?us-ascii?Q?EkLw6aj7sHBJDm0t9nS6v5XYrViyh/fRa/5Actl2oq3LQOeMaMtctqualVlx?=
 =?us-ascii?Q?4fT6xT6M0uOyhYBq+aG1hheMoLRcDp0z6KVbkI9YAbB+QmM3AU3O5N1DwJUK?=
 =?us-ascii?Q?XfBbrJf7lFpco4lyGcUt8Ujuyap/l81eH16pSvAkaq1wcExY6QbxmzrKk2EF?=
 =?us-ascii?Q?JvmihrhSwqkboLJzOc8OkFMygDKkRLZQkZky5fh5jPSvV80Sne2YMuaToA59?=
 =?us-ascii?Q?jjyq1kwvrtAQvdpSqQ4U/WrS69UsBo+l0xCZx5GjIHzAf41qxiLM5mCqbI7Y?=
 =?us-ascii?Q?uxFAu0COpUOqnhIvOHN9mW+XnrtiwNVMjR/XLeyndB3bU85aYgVBPjRTMAzp?=
 =?us-ascii?Q?Or7Ahq6Mp9iFYPoTZhhm+wcbZ7jhp95yQpScNnWjM6+3xSaJg8hBoz6VQf7X?=
 =?us-ascii?Q?yigPJ6eSUp8eqmak7wwIxmAMb7rDwrHETrMWZMZoACG5aQ6ciV9Hl4U/8U53?=
 =?us-ascii?Q?f9zC5gdhD9heiN8XF98pMhN4snn9Os274jpEfdXm5LsBWbMQ/gUUX+rrVA3r?=
 =?us-ascii?Q?fyibkzl/q5jEgxxceVwoa29chaY14+eaJ7taNout02rUc3js2nq5T7ZrpId3?=
 =?us-ascii?Q?Ir0QVWBKlgib280SxC6Wc7IRblesxtGhgRM/Hmj51NoBbZFJb0pKls5OjLC6?=
 =?us-ascii?Q?66nkga/YHctYRxMLtD+8M4xgrhK78HpxiEQh8uaIz0Qr3bN/0edNmg/CO00h?=
 =?us-ascii?Q?nu/o+9/zA34JDVLNbLoymC8/PWQKSAG6pYymcedeklLOZ3ZTxC2X/Dn0COlq?=
 =?us-ascii?Q?Q91EuBQWI+5K7LvW/3+tYQ82NmNK/u76OYDf8gLGlywWyeo38IuQ30OoIsSN?=
 =?us-ascii?Q?oAZIVZGpqJVnXutn2/dC3/Lo4JKOIDTA0aQWz8GiaRzsQf3OqH8r02+MAf2Z?=
 =?us-ascii?Q?MPPzTnUILsWplldDN0PH+j/OFRornumk3kjHOcRrktBqazwuH8vMDU/dWqZO?=
 =?us-ascii?Q?Rxs0btNhdtFYyOCLh1JDvMfjw43/BiNNYWua59ZWzFFKpVOSQhXqhYX6cd8a?=
 =?us-ascii?Q?rVss5zcdvxYRM7Bbxy+CDpft5AXidZpc7tWf3rzDo9Q2Oitu346peN5eJMQC?=
 =?us-ascii?Q?p/eaWV6qzZ4PKT9XSvRiRI5KBv/xIt0uJAKLZ25jprhHIkIyeO/Yk1tx7+7Z?=
 =?us-ascii?Q?IBAP9+xrr0n5Az4vPqUpw+9ef+7eYwiIHM89GkzQxRmtQQo/MeeiDLkTYBpy?=
 =?us-ascii?Q?G1amHDDlmNcBozSnc3xPela/8fr2Smk4WxLgqd3eEATTj2LbooB6P65WzKCU?=
 =?us-ascii?Q?VoBirMWrGd8RoKX8iUZN5h+Yo7v7yinWpgPAPPGRHoWxJIRdOz2CQ/IXdqM3?=
 =?us-ascii?Q?2JqBu6IjjZzf/kXOlTqKkChLsNJ8dRMOM5Mdkbe7xZX+lMiHDa4ktTRGHu/B?=
 =?us-ascii?Q?L0AxJZ3ZUIq6ydkwRXl6OPaMzFeiPnnpKd3Lg48c7EJlhCLBJutCus8RCemW?=
 =?us-ascii?Q?2EfWFCJMAehXbU+JR0d2qAvftrJljQ4XzAlws+i/TEgSYb0TbeZu7fRhAwAU?=
 =?us-ascii?Q?/PWD7umvkoZBjZq6UJrrv2vDn0jFUwrVrAK7ZCxhRW3i0zjaKK87tXueO0XJ?=
 =?us-ascii?Q?iq08cIFOnCdqMKPkGJ4B3/HbCABYolsf2JjxK0rPYeCt/tDC54CeGdA5SLtj?=
 =?us-ascii?Q?/68eqQWQyyDveYgAYnt63y/YFRTAhon2GVqtX4kOj9Dx03qBjbCSLHmGHEMT?=
 =?us-ascii?Q?ufrDTnNTAQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e299c586-48e1-4b6e-77c5-08df2cc0d8ba
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:38:09.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8RYN2KGzeSOSEjQB+a3fqHTO4LsOfWLa0ArSnXVruMoxwt5hosG1V2JjigiX82lm6+xa4s43Rt2RJtqPxXn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB4333

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
 tools/perf/util/symbol.c | 30 ++++++++++++++++++++++++++++++
 tools/perf/util/symbol.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b61a574ce9a3..a0fc430be13a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2372,6 +2372,36 @@ static int vmlinux_path__init(struct perf_env *env)
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
+	if (!vmlinux_path) {
+		symbol_conf.try_vmlinux_path = true;
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

