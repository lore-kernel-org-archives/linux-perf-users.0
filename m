Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.115
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792951911;
	b=Gcl0CYtPwKoyeOvCPhqZkmcyMtQ/0PGn4d6ctMYtHP4OijA2KsjbQZ9bzrrq4hqQ/z1K
	 1/T9iBL5wlrbFaGLRYPhmLXBOY0ijPSKXiHQeXIr8RI+j9NsYT418eq7/8+DDoMR24ik3
	 P9PtTPMB4Yh+Xnos/lk244UgBhnNWNzhnaU/NPzpseb4Z12t63rV9eejthT3TrEDoeyYb
	 riPzH+ZTt/il0zbdRx5cyycs+qpMIQuCYLJl3sjEZKEhpmdx9jJlCy/FsINFSx5tQNFv7
	 B5ZgKAbwf0qeds9o7xLqWYZWmfqPYfNGfHKFo8+xDmNTDoeBQv+EgC5gvGOZ+jAmXIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951911;
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
	bh=OkMd+ZmpptyNZdhmUpPI0HgvdBPHnBO1GTrj+lMoUaM=;
	b=b1/Dzxlf7s8Vf9NcNTQiGznPWi6AZkrbs9GDPIizaeNc8RmqxlXcwAp4XFFd6J5+YrSw
	 DBpYJ2hklPPaZfLp7ZMJKseCnhnSczNnysHBF17+ihLC6xyJDR+dAj3p418H3662OQ7Ar
	 7jkIEKFCQ3CzjdtlyDJa7rMV44nR0cN187iP+kQZPBqk9/WqYCViMTPAzuOqCARCXa/zI
	 nyDbpzufJRuJK0hh1HSH7An6V5fHzhVWrAYenEv1nG7XzCryaGgEBpxlWH2lNAIjlhysL
	 UQLhb3ScH2G4PseXHU81BCWTGyae3KXAOeX1Fd9YYD+CQob1KqTmcQtnaUQ11+Rr2Fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.115
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022115.outbound.protection.outlook.com [52.101.96.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A749606A31B;
	Sun, 25 Oct 2026 18:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A749606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIdppnf33j6haCXz+8SVlsZ8NoaZBpa3AvB73lmnlsx7cPGKX+9Hxe4rHcdle06Y1NSUXJf9Ta5gLa1aAV8BMkEJng75HGcfsxvFhr/ZUf2+aWqYDo3oxbzsBMNesmfBnVD/tZ4oradnyMK3BdPZdoF3BNHZi16NnG961RgO5TbwVxr1v/i+Isf8hy9WGrvGNdkh7ZFYlsbTBMk2ZMy7w1snL0vMT8BA373LcqZgbPvspJb2s8N6ammtIZxMn+WgDrWFnFcigNa16BFuiVqSwnKh0H2hxgJrVSrq5Wot3qpCm0XLvYG9KSlgK5wTFVcvmugNZC6RXslAqV69L+wreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=OkMd+ZmpptyNZdhmUpPI0HgvdBPHnBO1GTrj+lMoUaM=;
 b=KqExx5O8Lftmh997fpD06lkwv3BLbXc1X5yi2lB0BVHl+VmhH0pATYYMkd7wXdwhJ1EHU9OT6+N7tS04Fz6V+SaifLl8UdbiRiH6A+nggSVz6eR7XBjfXgO9ScXnZ9UfDkjfzAHx+yY8mUhHaOe2ikMdzLyjCQ5Y6S8JLSQkgw2t3xXXSVPDyFtHU+ebKE4pjw28PZz7mUnVgD0x1W1GWApJnTsQQDaQnDKCdFImR/bFNW82120k+Q1kjhx5yQDJ00S0murKKbxszf13HWhf3ZaA89pOBZPjYd163dX3qPFbiHWDx/a2JACYu4XaBWgqnTdnWZ+lxU+3DlKw1qk7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6815.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 18:11:48 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 18:11:48 +0000
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
Subject: [PATCH perf-tools-next v11 04/10] perf ftrace: Add basic task call stack management
Date: Sun, 25 Oct 2026 14:11:19 -0400
Message-ID: <20261025181125.514372-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025181125.514372-1-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: f69013e3-eab7-40e4-57f6-08df32c36f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|5023799004|56012099006|261022105027099003|261022113327099003|261022075727099003|261009223027099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	v0ftYD1ZV1O66ejbdtQSHR30nRNrxP9d38jrOVZz5ZV0bJuKhY3s/slqCB1wPldTgFIs499lHVUCYI5I80F7+MIQo5MId6iYkBAe2kzU5A+MZqIopusRmSVbCo1gRVYkW80uRXs0IoebGV7GqtrYC0kE4xZQXoyOWqGiP/fTbbnlKLfU59FPwlLuasNKGzuKf2RmzsQSsS0y3yvdacFoOIuehBc379R+U0blppWyYR9qn2WGept0Uw2Y4mI63BgMRXzuPgQqT+sPRhq4yKonKgFq9Oh/OMhMUScRPXvZndJpF3c+cNbSF+/I0WZqggXpDs9MzsxamfjFFLrIGwlF+2DtbJ704VXG5o0kQgwxaqKOHmc3mDwssj1SePaWej1MSUt6xjcKB+qLgpal3QazfBcKDy7ywiaMK+fnm58I77MgE7XVELS42JWE37Nf+p7wQ1EbRR4iW+CRPvLyoiMx1cmcb5gzwIVT58n4rZD76kuOg/WS7tKdJVO/X42m8rZkKuhJB2Z9YBGE6i1gf6NHLsa6tQiw3xtZN0xndWs8W5wwLdGZqSBAMfK06bwmedloTrSU6W5ymFIxYcwlfgA2A+pkZKY1S5uCwI0JDFbQzXlp+LPjgMpLfIYhmIrxL2qQveQL1kDfki9sfL7kifMAGSOBoARiVtCmln1jG3alpP4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(5023799004)(56012099006)(261022105027099003)(261022113327099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iaLx1Ov1ZyhhOsrXKeddE5yBr25y3QAUEmSdpYSrHED3XVSUWfKUpujUMglG?=
 =?us-ascii?Q?3q7bq/PLLooZedYqvanu96OAxgfK6GHW49gGFJ7A/KB0mBJXbrdIF2ycG6ql?=
 =?us-ascii?Q?0vafuq/pnLyeF4MSssu1IdP6Q61UXq/3767uSfhxvHfUKb7nRutObOtGf+sm?=
 =?us-ascii?Q?FQMBpuM0bkh481tyaT9UqaINvQDAGhOr3uYRU4BD291ENfVjE0OeRCnWqxBp?=
 =?us-ascii?Q?ykkodw4D7eHmWTV01TggRj6tVupK5/1tjmZ9Yzb8kXJ7AAK1Xfd4CTBQukt1?=
 =?us-ascii?Q?Xh/hySPn53hQPZOHOs43OdSc9dA5hCToLkOikiBiq4s5f9Hbch5dzi2OUVbo?=
 =?us-ascii?Q?FPhfxWEYlHtQ44WFPRctt7pUEdcXiHiIG7VpPvQrY78hORjLDAw7atVdgfEF?=
 =?us-ascii?Q?AiFzVBq/CODWyzLmesl8DCaj+kM3JFButWaUeVyKtx6oXwirDOpD6fHvcXCl?=
 =?us-ascii?Q?sZRXvNq71dgBZ6RnfwCiO1MNxnmeYjYo7/CUCX5HdlLH3KJvN9tTEmv2QsMw?=
 =?us-ascii?Q?uTBDCIHCtvDgVmExAA238444VEQs38A4pgHcg1peYfvWWmUrQSIz3VKC/bPH?=
 =?us-ascii?Q?DRVPSd1arNGedsH+tLBncKk2PuPPWR5H+2InI6TsLqGhpwW7qOCKG/18Q6hg?=
 =?us-ascii?Q?79SL6sYaTUPVZFlO1H87lCzGSlds4TZFzEUrN7s37diiAbXBYFT0CQ2j7PiV?=
 =?us-ascii?Q?+m0cxUNycEP9eRRAZQ6ivP3IBdrg94e667eJ1Qoa2fBlUoZkSsC8RHZXk4XQ?=
 =?us-ascii?Q?uDE3gSoUCPmarY0N4EIhp7B8JPm4GXMgrG3Pf3SOltt25GNoIQVkIY3iFyJc?=
 =?us-ascii?Q?O40EcbHh7zNroSj4Nv8SX8bGyT95bWNUXAr47PB0pyYyZuTK/PJKKbIVB3k9?=
 =?us-ascii?Q?mDlX07A+WtzK3i4DtA9NKuWJQ+HdjK3zsAHbHDRiJT69zKM555PvQNxNnYbM?=
 =?us-ascii?Q?GpJH+sFrFXI5ZoR07gBDuQ57z+ROQnX0fSmZV4jal6u1pgJg6pdeGkH7xJzL?=
 =?us-ascii?Q?Q60mNUjHG2hVKd2H/oRByZU1e1bMeRxyq06564e0BXv1XsJpoa5ZVSKe087L?=
 =?us-ascii?Q?fHmW9Ow+vcpgDX+8/OfXQUQworJfTWvby8SSzYJv8wQ+IcyEwkvNw6e1+BTj?=
 =?us-ascii?Q?ovYoDn9olsQ9oloJeADsyCAA3K1na4tkkVR7UttkxYAHhCzO9qWvyGX3zBv/?=
 =?us-ascii?Q?ZxNFIp25eLlumRFezEOtvfoueyVyJKACL4u/PjRDVC7zXBGmO05kTTJQaBHj?=
 =?us-ascii?Q?eOPU00iGcDm6oRrIllHG1rVJnFbIE6tlFdXPB3jtgLKD3GF/yHOpikQIF45t?=
 =?us-ascii?Q?vO7F1G6cqMs0YOo3SW9IkvQIEQsBOnO8+zI/Itz44KZtvusXjoSu+6X6U5bQ?=
 =?us-ascii?Q?xsT6nImWGWbnV8lwChrxoBreCX0lopULV/UlCwWbjQuzsWf6ZLc6oJobHYoO?=
 =?us-ascii?Q?rIj9Ed95xo+XVT7cja6LEKFSqV4Yk15Knd7cAK14Drch1pq8MYF6sRlvHTN0?=
 =?us-ascii?Q?OXunm45ZaQn3kj8h/T5JHcwQ/pJ0hSKhdusywa67DhZKsRnqJwkF8F/CuXVh?=
 =?us-ascii?Q?FpgTrZK2VB1h2RMR5B59FKr3B+GdGwwdhOEt3J7H81yiHA7zVWDKtRy/vMmH?=
 =?us-ascii?Q?lpxoYNL958DbkJTAo34nfsoByOJreQzdkc5AUJ6cCkFijFG7OKMyghQUJHoU?=
 =?us-ascii?Q?3lcHw1DUZu/iPOfL4wwlTSs/9j/S4bmBzkaO42t3mBmRWd8QfbVJTNs+dMWA?=
 =?us-ascii?Q?8rRKBt9qeA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69013e3-eab7-40e4-57f6-08df32c36f97
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:11:48.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hh5NyDi6b7ZVfJ3ABnPI7JjOtKlu1C9R58WNf7JgHZA5lMO4fCPSaIHyicKdzbMY9EXwXCKWJ31Y9WyCqF7c2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6815

The function_graph tracer records kernel function entries and exits with
nested indentation. To perform call graph analysis and subsequent inlined
function reconstruction, userspace must track the active call stack on a
per-task and per-CPU basis.

Introduce basic call stack management for the function graph tracer:

    1.  Data structures

        Define struct ftrace_stack_frame to track function names,
        indentation, and inlined status.

        Define struct ftrace_task_state with a dynamically resisable call
        stack array, tracked in a hash table keyed by PID alongside per-CPU
        active task bindings (ftrace_cpu_tasks).

    2.  Trace stream processing

        Implement find_func_column() to isolate context columns (CPU,
        timestamps, duration) from function graph trace lines across
        standard and verbose layouts.

        Implement ftrace_process_fgraph_line() to parse function entries
        ("{") and exits ("}"), pushing and popping frames on the tracked
        stack and matching bare closing braces against preceding frames.

    3.  Integration in __cmd_ftrace()

        Stream complete trace lines through ftrace_process_fgraph_line()
        in __cmd_ftrace() and clean up allocated CPU states on exit via
        ftrace_cpu_states__clear().

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-ftrace.c |  40 ++--
 tools/perf/util/ftrace.c    | 394 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.h    |  30 +++
 3 files changed, 452 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index e00621703dd7..e3909cff287b 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -744,6 +744,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	int trace_fd;
 	char *buf = NULL;
 	struct strbuf linebuf = STRBUF_INIT;
+	int ret = 0;
 	struct pollfd pollfd = {
 		.events = POLLIN,
 	};
@@ -837,14 +838,20 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			for (int i = 0; i < n; i++) {
 				if (buf[i] == '\n') {
-					if (!ftrace->graph_retaddr)
-						ftrace_filter_retaddr(linebuf.buf);
-					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
+					if (ftrace_process_fgraph_line(ftrace,
+								       linebuf.buf,
+								       stdout) < 0) {
+						ret = -1;
+						goto out_close_fd;
+					}
+					if (ferror(stdout))
 						break;
 					strbuf_setlen(&linebuf, 0);
 				} else {
-					if (strbuf_addch(&linebuf, buf[i]) < 0)
+					if (strbuf_addch(&linebuf, buf[i]) < 0) {
+						ret = -1;
 						goto out_close_fd;
+					}
 				}
 			}
 			/* flush output since stdout is in full buffering mode due to pager */
@@ -876,22 +883,30 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 		for (int i = 0; i < n; i++) {
 			if (buf[i] == '\n') {
-				if (!ftrace->graph_retaddr)
-					ftrace_filter_retaddr(linebuf.buf);
-				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
+				if (ftrace_process_fgraph_line(ftrace,
+							       linebuf.buf,
+							       stdout) < 0) {
+					ret = -1;
+					goto out_close_fd;
+				}
+				if (ferror(stdout))
 					break;
 				strbuf_setlen(&linebuf, 0);
 			} else {
-				if (strbuf_addch(&linebuf, buf[i]) < 0)
+				if (strbuf_addch(&linebuf, buf[i]) < 0) {
+					ret = -1;
 					goto out_close_fd;
+				}
 			}
 		}
 	}
 
 	if (!ferror(stdout) && linebuf.len > 0) {
-		if (!ftrace->graph_retaddr)
-			ftrace_filter_retaddr(linebuf.buf);
-		fprintf(stdout, "%s\n", linebuf.buf);
+		if (ftrace_process_fgraph_line(ftrace, linebuf.buf,
+					       stdout) < 0) {
+			ret = -1;
+			goto out_close_fd;
+		}
 		strbuf_setlen(&linebuf, 0);
 	}
 
@@ -901,9 +916,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	free(buf);
 	strbuf_release(&linebuf);
 out_reset:
+	ftrace_cpu_states__clear();
 	exit_tracing_instance();
 out:
-	return (done && !workload_exec_errno) ? 0 : -1;
+	return (ret == 0 && done && !workload_exec_errno) ? 0 : -1;
 }
 
 static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 452231c01568..95db57e70d11 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -2,11 +2,146 @@
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
+#include <linux/hash.h>
+#include <linux/list.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+#include <errno.h>
+#include <sys/types.h>
+#include "debug.h"
 #include "util/ftrace.h"
+#include "util/string2.h"
+
+static struct hlist_head ftrace_task_hash[FTRACE_PID_HASH_SIZE];
+static struct ftrace_task_state *ftrace_cpu_tasks[FTRACE_MAX_CPUS];
+
+/**
+ * ftrace_cpu_states__clear - Free allocated CPU and task stack states
+ *
+ * Free all memory associated with the per-task stack tracking states,
+ * including the strings allocated for stack frames.
+ */
+void ftrace_cpu_states__clear(void)
+{
+	struct ftrace_task_state *ts;
+	struct hlist_node *tmp;
+	int i, j;
+
+	for (i = 0; i < FTRACE_PID_HASH_SIZE; i++) {
+		hlist_for_each_entry_safe(ts, tmp, &ftrace_task_hash[i], node) {
+			for (j = 0; j < ts->depth; j++)
+				free(ts->stack[j].name);
+			free(ts->stack);
+			hlist_del_init(&ts->node);
+			free(ts);
+		}
+	}
+
+	memset(ftrace_cpu_tasks, 0, sizeof(ftrace_cpu_tasks));
+}
+
+/**
+ * find_task_state - Look up call stack state for a task by PID
+ * @pid: Process ID of the task
+ *
+ * Return: A pointer to the task's stack state, or NULL if not found.
+ */
+static struct ftrace_task_state *find_task_state(pid_t pid)
+{
+	struct ftrace_task_state *ts;
+	struct hlist_head *head;
+	u32 key = hash_32((u32)pid, FTRACE_PID_HASH_BITS);
+
+	head = &ftrace_task_hash[key];
+	hlist_for_each_entry(ts, head, node) {
+		if (ts->pid == pid)
+			return ts;
+	}
+
+	return NULL;
+}
+
+/**
+ * get_task_state - Get or allocate stack state for a given task PID
+ * @pid: Process ID of the task
+ *
+ * Return: A pointer to the task's stack state, or NULL on allocation failure.
+ */
+static struct ftrace_task_state *get_task_state(pid_t pid)
+{
+	struct ftrace_task_state *ts = find_task_state(pid);
+	struct hlist_head *head;
+	u32 key;
+
+	if (ts)
+		return ts;
+
+	ts = zalloc(sizeof(*ts));
+	if (!ts)
+		return NULL;
+
+	ts->stack = calloc(FTRACE_MAX_STACK, sizeof(*ts->stack));
+	if (!ts->stack) {
+		free(ts);
+		return NULL;
+	}
+	ts->max_stack = FTRACE_MAX_STACK;
+
+	ts->pid = pid;
+	key = hash_32((u32)pid, FTRACE_PID_HASH_BITS);
+	head = &ftrace_task_hash[key];
+	hlist_add_head(&ts->node, head);
+	return ts;
+}
+
+/**
+ * ftrace_task_state__grow_stack - Double the capacity of a task's call stack
+ * @cs: Task state whose stack should be resized
+ *
+ * Reallocate @cs->stack with twice the current capacity, zero-initialising
+ * the newly allocated frames.
+ *
+ * Return: 0 on success, or -ENOMEM if memory allocation fails.
+ */
+static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
+{
+	int new_max = cs->max_stack ? cs->max_stack * 2 : FTRACE_MAX_STACK;
+	struct ftrace_stack_frame *new_stack;
+
+	new_stack = realloc(cs->stack, new_max * sizeof(*new_stack));
+	if (!new_stack) {
+		pr_err("Not enough memory to resize ftrace stack\n");
+		return -ENOMEM;
+	}
+
+	memset(new_stack + cs->max_stack, 0, (new_max - cs->max_stack) * sizeof(*new_stack));
+	cs->stack = new_stack;
+	cs->max_stack = new_max;
+	return 0;
+}
+
+/**
+ * get_cpu_state - Get or allocate active task stack state for a given CPU
+ * @ftrace: Perf ftrace context
+ * @cpu: The CPU number
+ *
+ * Return: A pointer to the CPU's active task stack state, or NULL on error or
+ * out-of-bounds CPU index.
+ */
+static struct ftrace_task_state *get_cpu_state(struct perf_ftrace *ftrace __maybe_unused, int cpu)
+{
+	if (cpu < 0 || cpu >= FTRACE_MAX_CPUS)
+		return NULL;
+
+	if (!ftrace_cpu_tasks[cpu])
+		ftrace_cpu_tasks[cpu] = get_task_state(FTRACE_UNKNOWN_PID(cpu));
+
+	return ftrace_cpu_tasks[cpu];
+}
 
 /**
  * ftrace_parse_retaddr - Parse return address comment from trace line
@@ -91,3 +226,262 @@ void ftrace_filter_retaddr(char *str)
 
 	memmove(start, end, strlen(end) + 1);
 }
+
+/**
+ * extract_entry_func_name - Extract the function name from an entry record
+ * @str: The trace line's function column string
+ * @buf: Buffer to store the extracted name
+ * @size: Size of the @buf
+ *
+ * Parse the function name out of an entry trace record by stripping away
+ * parentheses or braces.
+ */
+static void extract_entry_func_name(const char *str, char *buf, size_t size)
+{
+	size_t i = 0;
+
+	while (*str && *str != '(' && *str != '{' && !isspace(*str) && i < size - 1)
+		buf[i++] = *str++;
+	buf[i] = '\0';
+}
+
+/**
+ * extract_exit_func_name - Extract the function name from an exit record
+ * @str: The trace line's function column string
+ * @buf: Buffer to store the extracted name
+ * @size: Size of the @buf
+ *
+ * Parse the original function name out of the trailing comment in an
+ * exit trace record.
+ */
+static void extract_exit_func_name(const char *str, char *buf, size_t size)
+{
+	const char *p = strchr(str, '}');
+	size_t i = 0;
+
+	buf[0] = '\0';
+	if (!p)
+		return;
+
+	p = strstr(p, "/*");
+	if (!p)
+		return;
+
+	p = skip_spaces(p + 2);
+	while (*p && !isspace(*p) && *p != '*' && *p != '/' && i < size - 1)
+		buf[i++] = *p++;
+	buf[i] = '\0';
+}
+
+/**
+ * find_func_column - Locate the function call column in a trace record
+ * @ftrace: Perf ftrace context
+ * @line: The trace record to parse
+ * @cpu: Pointer to store the CPU number
+ *
+ * Locate the context columns that precede the function call column of a
+ * function_graph trace record.
+ *
+ * Return: A pointer to the last character of the context columns (the final
+ * '|' delimiter, or the CPU ')' when no delimiter follows it). Returns NULL
+ * if @line is not a trace record.
+ */
+static const char *find_func_column(const struct perf_ftrace *ftrace,
+				    const char *line, int *cpu)
+{
+	const char *p = line;
+	char *endptr;
+	long val;
+
+	if (ftrace->graph_verbose) {
+		p = strchr(p, '|');
+		if (!p)
+			return NULL;
+		p++;
+	}
+
+	p = skip_spaces(p);
+	val = strtol(p, &endptr, 10);
+	if (endptr == p || *endptr != ')')
+		return NULL;
+	p = endptr;
+
+	if (ftrace->graph_verbose) {
+		p = strchr(p, '|');
+		if (!p)
+			return NULL;
+
+		p = strchr(p + 1, '|');
+		if (!p)
+			return NULL;
+	}
+
+	p = strchr(p + 1, '|');
+	if (!p)
+		return NULL;
+
+	*cpu = (int)val;
+	return p;
+}
+
+/**
+ * print_line - Output a trace line verbatim, filtering return addresses if needed
+ * @ftrace: Perf ftrace context
+ * @line: The trace line to output
+ * @out: File stream to output to
+ *
+ * Output @line to @out. Unless ftrace->graph_retaddr is set, return address
+ * comments are filtered out first.
+ *
+ * Return: 0 on success, or a negative error code (e.g. -ENOMEM) on failure.
+ */
+static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
+{
+	char *filtered;
+
+	if (ftrace->graph_retaddr) {
+		fprintf(out, "%s\n", line);
+		return 0;
+	}
+
+	filtered = strdup(line);
+	if (!filtered) {
+		pr_err("Not enough memory\n");
+		return -ENOMEM;
+	}
+
+	ftrace_filter_retaddr(filtered);
+	fprintf(out, "%s\n", filtered);
+	free(filtered);
+	return 0;
+}
+
+/**
+ * ftrace_process_fgraph_line - Process and output a function graph trace line
+ * @ftrace: Perf ftrace context
+ * @line: The trace line to process
+ * @out: File stream to output to
+ *
+ * Parse function entries and exits, maintain the task's call stack, and
+ * output the trace line.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
+{
+	const char *pipe_char;
+	const char *after_pipe;
+	const char *func_start;
+	struct ftrace_task_state *cs;
+	int cpu = -1;
+	int leading_spaces;
+	int top_raw_indent;
+	int match_idx;
+	int i;
+	bool is_exit;
+	bool has_open_brace;
+	bool has_semicolon;
+
+	pipe_char = find_func_column(ftrace, line, &cpu);
+	if (!pipe_char)
+		return print_line(ftrace, line, out);
+
+	cs = get_cpu_state(ftrace, cpu);
+	if (!cs)
+		return print_line(ftrace, line, out);
+
+	after_pipe = pipe_char + 1;
+	func_start = skip_spaces(after_pipe);
+	leading_spaces = func_start - after_pipe;
+
+	if (*func_start == '\0')
+		return print_line(ftrace, line, out);
+
+	is_exit = (*func_start == '}');
+
+	if (is_exit) {
+		char exit_name[128];
+
+		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
+
+		top_raw_indent = -1;
+		for (i = cs->depth - 1; i >= 0; i--) {
+			top_raw_indent = cs->stack[i].raw_indent;
+			break;
+		}
+
+		if (cs->overflow_depth > 0 &&
+		    (top_raw_indent < 0 || leading_spaces > top_raw_indent)) {
+			cs->overflow_depth--;
+			return print_line(ftrace, line, out);
+		}
+
+		match_idx = -1;
+		if (exit_name[0] != '\0') {
+			for (i = cs->depth - 1; i >= 0; i--) {
+				if (cs->stack[i].name &&
+				    cs->stack[i].raw_indent == leading_spaces &&
+				    strcmp(cs->stack[i].name, exit_name) == 0) {
+					match_idx = i;
+					break;
+				}
+			}
+		}
+
+		if (match_idx < 0 && exit_name[0] == '\0') {
+			for (i = cs->depth - 1; i >= 0; i--) {
+				if (cs->stack[i].raw_indent == leading_spaces) {
+					match_idx = i;
+					break;
+				}
+			}
+		}
+
+		if (match_idx >= 0) {
+			cs->overflow_depth = 0;
+			while (cs->depth > match_idx) {
+				free(cs->stack[cs->depth - 1].name);
+				cs->depth--;
+			}
+		} else if (cs->overflow_depth > 0) {
+			cs->overflow_depth--;
+		}
+
+		return print_line(ftrace, line, out);
+	}
+
+	has_open_brace = (strchr(func_start, '{') != NULL);
+	has_semicolon = (strchr(func_start, ';') != NULL);
+
+	top_raw_indent = -1;
+	for (i = cs->depth - 1; i >= 0; i--) {
+		top_raw_indent = cs->stack[i].raw_indent;
+		break;
+	}
+
+	if (cs->overflow_depth > 0 && top_raw_indent >= 0 &&
+	    leading_spaces <= top_raw_indent)
+		cs->overflow_depth = 0;
+
+	if (has_open_brace && !has_semicolon) {
+		char entry_name[128];
+
+		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+		if (cs->depth >= cs->max_stack &&
+		    ftrace_task_state__grow_stack(cs) < 0) {
+			cs->overflow_depth++;
+		} else {
+			cs->stack[cs->depth].name = strdup(entry_name);
+			if (!cs->stack[cs->depth].name) {
+				pr_err("Not enough memory\n");
+				return -ENOMEM;
+			}
+			cs->stack[cs->depth].inlined = false;
+			cs->stack[cs->depth].indent = leading_spaces;
+			cs->stack[cs->depth].raw_indent = leading_spaces;
+			cs->depth++;
+		}
+	}
+
+	return print_line(ftrace, line, out);
+}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index a3a679f74e9d..fa2974f46582 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -1,6 +1,9 @@
 #ifndef __PERF_FTRACE_H__
 #define __PERF_FTRACE_H__
 
+#include <stdbool.h>
+#include <stdio.h>
+#include <sys/types.h>
 #include <linux/list.h>
 
 #include "target.h"
@@ -93,7 +96,34 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 #endif  /* HAVE_BPF_SKEL */
 
+#define FTRACE_MAX_CPUS 4096
+#define FTRACE_MAX_STACK 256
+#define FTRACE_PID_HASH_BITS 10
+#define FTRACE_PID_HASH_SIZE (1 << FTRACE_PID_HASH_BITS)
+
+#define FTRACE_IDLE_PID(cpu)       ((pid_t)(-1 - (cpu)))
+#define FTRACE_UNKNOWN_PID(cpu)    ((pid_t)(-1 - FTRACE_MAX_CPUS - (cpu)))
+
+struct ftrace_stack_frame {
+	char *name;
+	bool inlined;
+	int indent;
+	int raw_indent;
+};
+
+struct ftrace_task_state {
+	struct hlist_node	node;
+	pid_t			pid;
+	struct ftrace_stack_frame *stack;
+	int			max_stack;
+	int			depth;
+	int			inlined_depth;
+	int			overflow_depth;
+};
+
 bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
 void ftrace_filter_retaddr(char *str);
+void ftrace_cpu_states__clear(void);
+int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out);
 
 #endif  /* __PERF_FTRACE_H__ */
-- 
2.55.0

