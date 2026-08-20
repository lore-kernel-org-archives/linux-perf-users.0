Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020122.outbound.protection.outlook.com [52.101.195.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C563DDB0A;
	Thu, 20 Aug 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260272; cv=fail; b=m3O2r2W2lNXoEQp9nfw0RPpniNHXFP2Qy8olHvXQvbfmypCEMLIpmn4lQmeqPAI54vVHFpCxgxfyJCPdEJ43YLPehXfLtGyrWo9nfif7TwM/IjZ5JUGweb+qJAiVD+LO4gJCw2bPAml+b6MSub25IernqZxHzACPjytHMhB8cAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260272; c=relaxed/simple;
	bh=/dT15EN5BtXqC/Kc+JIYw1DdFsMy6ur+RmiE+0tyCcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P0RkZJGANYHDumXjbYpekLp0d5alKI/25gT81v+GBnjx7GhuWhrt1zJ5OuUeeHZs8KW3CofqaXdVPdZcK2k2Vc2xbsJYq6FkFon9ilaqzuCjavjW7Gm6lirJNwXcilYMtExIeCcBcfgG0troqkmNZ1HGQin1vdXreHIbIiUWXvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjCNpadn6Q/X7VRW0SORsOm8N5qqKhhPygPtebEZL43dS8VA10A4W7jguClzIsvVGVYX7xPvK3gBuqjwP0YyZcl9nUsvViaErM3Fj6yIPfZAvPgH7HpjqwuGz0+Cts6ea/9NXbGckAlyy3uT2WTQZHZKoVw7ojmYEMjt8f1SGoS4xz2/+i1LT3aKkPdA/XY+8xtIBo4XCKXk7Mk2c7BBmJca6MGuHXlbMtvk/mDbzQgH8YJLHamBBBxT7HgUQYujhdf/To9KijQc7tu7vegFg3MkKlsBzIyFR99p7KkrML1W03HdxSiMgGkFCyoqE283PfpZuPNz4oji591JwoOpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=+LY40U8azJZOZVX5dkyDjbVu9cZgdNS5hWk4U+zDsEQ=;
 b=YbuDADotAB8DEk+WCPRKwnw1DMcS/ue+vEGdMijiTKRIeexqPEJ7MLBrSt9iXoLQj3Nc17lR/WGiqsCpR3HZMoZhRxvyEDZ62iefhDk72llgNY6FAM/nQQvGrdDrMUPr75K81tvceH94fFu5iVIeuqWYzXXQM0Mat6gzKqaCz7AreYzYO3opO2wjSjX6lBVAChAZbQgrkR+q2VEg/ps5vSiz3a9oAr4QGdkwfVwDvZR3cITasf6wmJLBcOzOtlfT6wbbmeT7R2j0/PkmlH5c8kBHdcechDJkRsSb/ef70FPWB3vKxOis78+Y2snGYOytvqOCdQLsrkyj82olpxNRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB9004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 21:11:07 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 21:11:07 +0000
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
Subject: [PATCH perf-tools-next v3 1/4] perf trace: Introduce kernel symbol beautifier for virtual addresses
Date: Thu, 20 Aug 2026 17:10:57 -0400
Message-ID: <20260820211100.649142-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820211100.649142-1-atomlin@atomlin.com>
References: <20260820211100.649142-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0935.namprd03.prod.outlook.com
 (2603:10b6:408:108::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b351f1-4db8-446c-d5be-08defeff8d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KNeJWxjLkhIH7KV9S4M1BLY0LyM2xkFeua44sHD0bYXV7ccpasrxq967ZdsLs7c4p4WBBhaXatqf7bsnDp4mgdTv0yK8keWEd70vE2ANdUMNCXopT7SjWWz1knnhexAfp+aLIk91U9K7lK++hb3+dGf37JgTZ7UOax7iXvR6EZW8xekxe/cwUzfAoY43iuT5eGaH/VJ78CcrSUKvg8h6OjRn5CzdNQ0R9VUSDoZY3/NqszM/LFMAD8QLglFeXDT7X6Y4cyxY80IEvw2KTRVNiTnm1vFoOuZaHW2iIpFGtv6NIibgorZqHOaIg85tllcnzN34MBwMVf+/vdb/Z8pALk6bMH/RS1dtNNG+m1Sw4mLtzErnftUtlHfjLrB8PqVJBLjH4XJO4T8x8KDE15JxMOCetoIVOBgyO9cd3Tn1NNC88rQhnAPz0f7Uzge+1lc4wK6ZBxVQ3MAiyFBiYAr4PD55I716rM2yvMi6BhLK6LagVHK0SW64dNS5BNkx/Pkvg/s3aF+ywS9lApCmokGrGCk2f6bK1NqMoT6SpLpCK/qtZN1mvM4oAwhhIcUM871IPJJk9eAwYjsjTxUOKYfXvvIlRrhfX+otMf3S/NiJWAq0KpkgTMnPJ3Q1R0sK/rllwmQBmMvIM/wJc40zgAngqTkEUYLbD3MzJ4Z7oejGXFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/k3VbZrb+oGQmfHyTRXGfp9xzcwUZZYLiDQvM3CRLQZLS5zpb0weo5wjBX01?=
 =?us-ascii?Q?Ad5Aq1H2hplS3m76SVsY7roxlwuFMpj9TDJG8/iw5RtLaufm007ALmYpVZ2g?=
 =?us-ascii?Q?zUWiYtfsS5bWbnePCxGe4ZQ/gGreKdAJQDPdo8RqbqUBVxLgYHoVhepG6yka?=
 =?us-ascii?Q?04doVRflyqTmwOtRpO8GbYvZ1VWSoISzMhGro/YcfLkyh3LErcF03TxH3bDG?=
 =?us-ascii?Q?nM173zeqzPjnsABdcJeU4+rJANIXOzZpGZY9nUmG/RqFA5+1zjunznkq7yI/?=
 =?us-ascii?Q?SkOEdcseu72HZS5OkUn9HWEpA/x8OzFfYkuzqLfwSXKmqlkIgVue5tsD1i44?=
 =?us-ascii?Q?Xb53yZh5DPgu2viesEmnsa6VQVgqmVl/B9Q3AWcd46dQfDe9iq6lvCpRn/Ar?=
 =?us-ascii?Q?jDas7gKu9SqL9DB6XZQSrV9pwjVCwQ4/1h4KTF4yeD0X6KdthLbxIiDOs8Lu?=
 =?us-ascii?Q?5GX2MGVsuSFW4NRMFz23tzrfwWBQ66ULxs6waxl/zqfgiMyLDbMpjZtYep54?=
 =?us-ascii?Q?D5pCXxDkkCrcd7GS9Vx9UBBP7K2XavnIdvymAabCL8LXoLF+b44y2m6Ky+GB?=
 =?us-ascii?Q?RiB5s3PKHn8WLkjS6PAh67YT6jgcB7dCdSls5P9UIzVWHfoHjlrkWEI/Ur/W?=
 =?us-ascii?Q?e3jPyIa8C/M7ta2lqT9ubneky2cLgpMDMHDM6suaj/qJaecVb584y7C5ivMu?=
 =?us-ascii?Q?UyatGdeZMNI3V2HV99qenmrJPpwrMhM2CvNwScBGTCjguN3W+Wr7hElaKcEy?=
 =?us-ascii?Q?WQFs22Gn63zuwAs7UrV9tF9BkkrB1V6fAk7erGJuoPsAx1Hl175ZC1Nv2kYC?=
 =?us-ascii?Q?2OHIopJ/Rv+oxBTOVzHdlsKkzWmFtZlW8KTfzBRCfeknhwOmIB9y3yqhQ0q9?=
 =?us-ascii?Q?FE2Ww5o2IAk4OHGj//s4/FZsuEwI6OdIQ4BBFBXLcPJFnKxvoS/6I35cZqTT?=
 =?us-ascii?Q?oNJEF+jOUwr1INB2u220YmVZBSmHxB7ociXPfwK7RGYtzYhlOgRysyPtgygP?=
 =?us-ascii?Q?THrNkUyixN4ZfisiOkLMeDe7exvselWCoqB/iBC+yNwG8qdEQFDyzbnmg+At?=
 =?us-ascii?Q?9i7Ioj3tMVc9jOxsY1FWEsyK+k9HtKvnKe/PdyL0qI3G6y+9cROUomUcOJ6U?=
 =?us-ascii?Q?4MMVhg73QyWpPYUj4tZCMlUvhJqkyIQxABxp6hHicf90SWmQdqfXRvRxY7eG?=
 =?us-ascii?Q?YOmO+XtUwZxl11Tp6qCAwB+vTxug+We8b7HSBB++4BvrZude7ZAqo/b1bBBq?=
 =?us-ascii?Q?v6it29Z8Yr7w4lbD85LiXlqmP6Eh3yma9o5FTHlNUc4AgBNBkj0auUejo9Tj?=
 =?us-ascii?Q?jd9BOq4CrYr7WGtVKsAterLlyeRYuyB8b1zkyb6yx4Es2X6rKMtXGOIfvu6L?=
 =?us-ascii?Q?McpHA2PTh42LoW3RwoVfgc88cFo2R6RkIOnWmq56bYA52b8D88CEp8qN2T0u?=
 =?us-ascii?Q?IR8lW5UwEnRIePNp19cHeUxHokfXV1F3d/JKVrTmn6gBHdxJwWozLF/Ypj1n?=
 =?us-ascii?Q?sQtGHtM1U2sfdC+GomZ9xYdG7kNyxuouTTuD/cxEdaU+Ni/uAsP3ivz33VT2?=
 =?us-ascii?Q?7pUtMDhrSkPjOfemoloSk4/6+x6QT3iMFtM3r9LhwY/RtvxKgc3X7cB/hCNc?=
 =?us-ascii?Q?LB7E6SXDsg1mMWh1BdiGzLyklK/d7tc1cX/y4dex3PGG4XNmENiXoib+wTDm?=
 =?us-ascii?Q?gXSjFTvJtUMW1QSL6csxaG3veIjGW05+mwxVKtjC0vY/4He9RZTmtYzqdPGK?=
 =?us-ascii?Q?22jGCdnJyA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b351f1-4db8-446c-d5be-08defeff8d2a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:11:07.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fy9fp2uZjVCDK2VDNVPr8Su3ps564/HXvYUHmq4rrTp37XVGW2WIeuwThDvESZtbc+2FpyjbusA5jk86W75dnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB9004

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

