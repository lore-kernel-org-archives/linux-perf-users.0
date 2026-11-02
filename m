Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655681;
	b=mOZMRjhi246BZ708RrzzlYbVjoTo30AKslXPontE+AYP0XjR+1e0CJMq3knIWF2OXDEJ
	 OSfuIwD8LqRKH5D8S+JxHhZ5XtwytqIjfr/cemIpaqnpPs9+H3yTlj0OETnz1VgptvDPA
	 M9/qMuM1WEHN0Q7JriKVeRLNAxWLoyg6JqyF1v0P8U48pGT82pOxDG7X+6SxeWfJ2rw0B
	 X5/azwYNJTEdBe/Wwc8wg15hmVUOiW6Sc+crVtFt+2uyJXISErRCCm8Ib30Odolp3yv03
	 e7l/MyThTTxBA6iAnbZLdMNcBM/+4FUPNX4RqvQnUS5K3IHGl9JldnZxPRnyrM/ePRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655681;
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
	bh=zm9Hc/i3HG3kFlSs0IeQ1ejNgHQSUkEXR8EyT8ahvxk=;
	b=gOI+XsyONwJsMl9mcFuDU35+gsVBUWwoSdQICZfdMEA3IdARSogUoNpJ7ek8mfM9tedR
	 uKEhcerv9w4FC8Fe0BDGvzru+w4Z3dPbs/vLSxBfWKf4WfAb//rDebEfLTeF0iNFrFQeR
	 iCbAZoMgd8BJy7Nq9n0PWbLqZX2z/UoJYWbHSEbFbTwHHn/4OA+B0qvyxPsaRfhyBFTRK
	 06QCirkZrWheht2G5kS/4JafNNFLtlzhijI0nM5LhRAX4ZAxqCqi/1xaJI9tbkEKpg5jI
	 eG0lwAT/22KkGASUzPbhy2krtbqdx4QXQDj2n9w8sSkqWW4ao7GPxYU7xk0C3xbhNjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.91
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020091.outbound.protection.outlook.com [52.101.195.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6DD606D810;
	Mon,  2 Nov 2026 21:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D6DD606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaFZ+/Pyd2bEKIpW88g/S49JDU4ahbaXQOlxIHLb7YnzYBi8svvUagy4VJT0V3Ekx9qvRLpSxSGbMXfNIQYxJ8QSQ+2Un4UAOvIzS/pAUhbEJ5C6FKem79gu+eOxOSPqmMxKhMXA0opOjG0qraXkoDN8CaoHoCCh0r4fkDnor+wuIxVt9SY2ss/mBF97GPyzpZetEHwVabSvJn8wcH8uLTP3Y/+DEuezhagzpwTUJCU+2o5kbnZJh8C5L1CJ/1Yo+EBBqzkgAzasy8kOL5zJPN7/ZooUjKsvh7nzP53VyTS9PahEUAKK45pN1QK3Gx/BXIHLFNgSqTY+q0WpdQJ2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=zm9Hc/i3HG3kFlSs0IeQ1ejNgHQSUkEXR8EyT8ahvxk=;
 b=hBF3GzjkBMMXUwyoUh/StgmEK9pAQtBQXPhc/vySqD2mXI9ZMvDt1H4vV6ITiT+YYgJ6b8AaVPyHPcOxAJe4n6qkwefyseUK89vnQdVzKV4Kw/xpkRKTCGLSyr7xrfFIviOQkCIMBWwmO2a2AgU6oOBAVfGc1OhyZz5vQ3hbwutsVhbHJEnAbPyb7Eq/2s993+ldCWlN90GCcD4dWjXGm9MKOdGATbsrKu46aanhHDOBVPx4cn8vIxE1dab0fYrbvQpbh4eT4Pg7Yy8FHMw3LNHMnBAGEXm6og5nsLZSvJhviWl67/wOe246Kryn69wRVfw1oFguf2b0u0gm97Pe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWXP123MB3814.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:41:19 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:41:18 +0000
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
Subject: [PATCH perf-tools-next v13 04/10] perf ftrace: Add basic task call stack management
Date: Mon,  2 Nov 2026 16:40:48 -0500
Message-ID: <20261102214054.911298-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102214054.911298-1-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::27) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWXP123MB3814:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f96103-e691-4b1f-f545-08df392a077b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|3023799007|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|5023799004|261022113327099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	ujcUbxoKWiMVxAuaODr6p3aWI3eJjrvkk6BJb1HerxB55KBQISJAzBIB2M/pxAoTf5b2Kke9bkpsnqgzmT8ty5T2Smx3Lg2MG+p2YKuHQGrwlTHErBh2icSC7XrkO5LkA5SaclUm5RC8LC+6I6J8KDIJaBYwS2MDNLSNH3zarkAItoZn6ciD0MhKc8S7wL26JJK7vozDdl0O/Fgw519+X5KDh3IolQVRCFGWCogaN5trspF9+vA1IxhBz2WFa4ZZ5A1SSUv5iolVNBixSorAduVarjD/XAyvkKJEsLgEYRE2Zf5347iGOzctE3xgdJj6bhtaVDwpfxja9s2bxRxQcfnF++snGWeJRTmcEoTaxOVyprvkvzTDqGtO3O9c23BxcYq92EeVqnBePm0TjpdXSUqVmA0skYW3sP8mp0VBSwD94esih3ZFVffrw6I2A94dZuECnJ+om/aTTEmTo/DV/cLkJ7XS8tRq63NCtKuGTHRszOgFE/e3ex8jzqy50nJiUqK5yyYdxjsid82+waf0O9vQZqx4w8Ed3AY9UgNxL7tS15o+8k61q+y9osq36WEcgOm3ptvXvzjyiXCHHydcHcrZ18LdPTDMKGtV4U5iqHLhCqk27HmxuBgC/gmKnMeopvOZKP0nIfub8xGyXSdK9ilw6BoZh9ZnplwAN7Bzf4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(5023799004)(261022113327099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPhTxEedvndwKdIm6HVSzMnnhB0OcP56A8xsxoSIx9A5SlE4mmHIw5OAJ8TM?=
 =?us-ascii?Q?eeQ/Xxjb4p+e3sgfEPEeADkpS5EaVh4kKkbnvhzEZoa4acWD+TiwbvlXFEq5?=
 =?us-ascii?Q?Y9UiPV31/MGb4I+NJsPKRoIvEVaFirkdgrlnkpJ1RwPFvOheAV09vsbmWATy?=
 =?us-ascii?Q?O3Ov/w9nXpTGcgpNOsGS9Wv6/OmDn6tsg3viwLXINKmnt3h8inNX+6B+Wbz/?=
 =?us-ascii?Q?X9SBjXFBQE79H557DEQofvLxZiqquYR8qi0C8iIASxihLmsvM0aHbSrCPlY3?=
 =?us-ascii?Q?AhXJbgLQfS+NFWXQMxGC7Uf7rtIipOk9653RzDgGOKwEMygPKdncPd0XcJOW?=
 =?us-ascii?Q?iqFf+jWi6+CsgCIYMfrid+f4aWX7HPm3DwmuNqdG9vtK6dpMqlMy0eEuCdG/?=
 =?us-ascii?Q?C7XG9TdiJHeSgCmB8fq2dGSfkUQyWjIir4Bmttf/3zsEUyablKQSUt/RyemX?=
 =?us-ascii?Q?FlpiaJGhWBMwxvLgONBOW8mILND9dQSqIx4P/u+0dfPf3ImMoV3I94SFH3KV?=
 =?us-ascii?Q?Wv6fG0/2mPaBEwOzQ78UynTxzII3IelodI+d0+c4dF20UCAKyWfIu//wKUwf?=
 =?us-ascii?Q?RPHbNx+N1jySsdPPvZoOjpx7fs/9LxlFejU4D3sYq+E89GwvcDaD4pm4/y0x?=
 =?us-ascii?Q?S65hp7zphMQL/xwvreOYm5BH0Zaj5Ba4KhGdslZmTzMrHi9SFv/y+rFyhUa2?=
 =?us-ascii?Q?1kCzNW+on29Yz1JFEkq/IW9Mxb+xulfiL9V4jOws5nxAxlamqA8B1v/jZawJ?=
 =?us-ascii?Q?wxyWv/Yiqh7hfGIo/I1jA9u7c4tqoONT3Y02eswvVQx4BNfdhDAU3Jt7qB7A?=
 =?us-ascii?Q?ZsM3h/+UV2AVlK03ksvoI8RaOzguNECfLIUdX0alYXnfzlYUx9jxj79nlBjQ?=
 =?us-ascii?Q?RQn6i47Frho2W+WRC1cZnLAx8011WSGv/wxsLgQ2NoE83eMOq3kDOHjXRf3V?=
 =?us-ascii?Q?6qmRR7iIGDJ+vqM3eK1e6ZRcLRdIPfMjr1uF3PgDto/1tmJOAvzRHvjZWXVW?=
 =?us-ascii?Q?zeIh6udzE7Q/Qi4TQFzQyWMAUV7NJEM/Hn2EjyhQA+TnRoP6mb/PRia8zC42?=
 =?us-ascii?Q?BSR2G984Ac4yYYP2oZLmLOoOTHcR8jxZ7szAsYiJz2bXpcHK0tRxjjIlfoL5?=
 =?us-ascii?Q?W7QhJrJLHgJ/YALvl2tTif1ZsNo64n7e7JofLmqexExEa5S1FhD/Eb/4wQPI?=
 =?us-ascii?Q?zAcxGwwvTSoGeyqo2XXLGst9bNa2PURTbH+Al/QtU7FyOIcLAJrWmNtRBucB?=
 =?us-ascii?Q?j0rTKkI/f1gilAwgIIZBA5QjDErKk3L/rfGVx7Lg7XJ4wHDL2C0U1rsPFI8B?=
 =?us-ascii?Q?XAvrz/9vIPsMECEboB5lS15RlDQIcengMoNrlfYFG+WwZOtfVsoiY+qT6CE+?=
 =?us-ascii?Q?+rvKZOsAnegPvMIuPjM6GIgLqit7hY1eAcpKf458jF7j0e+aCqtuJfLnXqR2?=
 =?us-ascii?Q?N+npc3uDzSQjUVbas7fqXdCffWVk6JVnYvlIZFSnmsE18ETUqgJVs0fFUhzN?=
 =?us-ascii?Q?9exu5ELsSBq+q7kERqLRVDR9D8wnyHzmpthVPjujj/Ub/gEDSgoP8nza5rB5?=
 =?us-ascii?Q?g7ibCXGbZQiOckxW9tJQ8HkY4OKgg9iGiBmPolj/+o5IRrzBXr+2CiVjjT2y?=
 =?us-ascii?Q?gyGoIyZHCoOCN16IOejkYe0KKYy+DfwGiDdID6/mnPAga0Ea/sP0dvjpXWdm?=
 =?us-ascii?Q?tbO4QQTfL9qz2mqLrzxrWYmoC7j4Z25uGrOoGklKK84PVO8zNDkPt8KGsFLp?=
 =?us-ascii?Q?52WsbCB9PA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f96103-e691-4b1f-f545-08df392a077b
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:41:18.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG+SDvpJB2RHRtGBlxvifdQ3OesWXC5uQjeTsitwWKqURBpRV4aRSvl3R7pUcCRG8lC7Rj9ucae+lYhjctXjiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3814

The function_graph tracer records kernel function entries and exits with
nested indentation. To perform call graph analysis and subsequent inlined
function reconstruction, userspace must track the active call stack on a
per-task and per-CPU basis.

Introduce basic call stack management for the function graph tracer:

    1.  Data structures

        Define struct ftrace_stack_frame to track function names and
        indentation.

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
 tools/perf/builtin-ftrace.c |  40 +++-
 tools/perf/util/ftrace.c    | 430 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.h    |   5 +
 3 files changed, 463 insertions(+), 12 deletions(-)

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
index 452231c01568..21d40c6eb288 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -2,11 +2,183 @@
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
+#define FTRACE_MAX_CPUS 4096
+#define FTRACE_MAX_STACK 256
+#define FTRACE_PID_HASH_BITS 10
+#define FTRACE_PID_HASH_SIZE (1 << FTRACE_PID_HASH_BITS)
+
+#define FTRACE_IDLE_PID(cpu)       ((pid_t)(-1 - (cpu)))
+#define FTRACE_UNKNOWN_PID(cpu)    ((pid_t)(-1 - FTRACE_MAX_CPUS - (cpu)))
+
+/*
+ * Represents a single call frame on a task's function_graph stack.
+ *
+ * @name:   Function name extracted from the trace entry.
+ * @indent: Indentation (in spaces) used to correlate entry and exit frames.
+ */
+struct ftrace_stack_frame {
+	char *name;
+	int indent;
+};
+
+/*
+ * Per-task call stack state for function_graph trace reconstruction.
+ *
+ * @node:           Hash list node indexed by PID.
+ * @pid:            Task PID (or synthetic per-CPU ID when PID is unavailable).
+ * @stack:          Dynamically resized array of active stack frames.
+ * @max_stack:      Current allocated capacity (in frames) of @stack.
+ * @depth:          Current number of active frames stored in @stack.
+ * @overflow_depth: Nesting count of frames entered beyond @stack capacity,
+ *                  preventing their exits from popping valid parent frames.
+ */
+struct ftrace_task_state {
+	struct hlist_node node;
+	pid_t pid;
+	struct ftrace_stack_frame *stack;
+	int max_stack;
+	int depth;
+	int overflow_depth;
+};
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
+ * ftrace_task_state__grow_stack - Double the capacity of a task's call stack
+ * @ts: Task state whose stack should be resized
+ *
+ * Reallocate @ts->stack with twice the current capacity, zero-initialising
+ * the newly allocated frames.
+ *
+ * Return: 0 on success, or -ENOMEM if memory allocation fails.
+ */
+static int ftrace_task_state__grow_stack(struct ftrace_task_state *ts)
+{
+	int new_max = ts->max_stack ? ts->max_stack * 2 : FTRACE_MAX_STACK;
+	struct ftrace_stack_frame *new_stack;
+
+	new_stack = realloc(ts->stack, new_max * sizeof(*new_stack));
+	if (!new_stack) {
+		pr_err("Not enough memory to resize ftrace stack\n");
+		return -ENOMEM;
+	}
+
+	memset(new_stack + ts->max_stack, 0, (new_max - ts->max_stack) * sizeof(*new_stack));
+	ts->stack = new_stack;
+	ts->max_stack = new_max;
+	return 0;
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
+	if (ftrace_task_state__grow_stack(ts) < 0) {
+		free(ts);
+		return NULL;
+	}
+
+	ts->pid = pid;
+	key = hash_32((u32)pid, FTRACE_PID_HASH_BITS);
+	head = &ftrace_task_hash[key];
+	hlist_add_head(&ts->node, head);
+	return ts;
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
@@ -91,3 +263,261 @@ void ftrace_filter_retaddr(char *str)
 
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
+ * function_graph trace record. Depending on the funcgraph-* options set
+ * up by perf, a record looks like:
+ *
+ *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
+ *
+ * The abstime and comm-pid columns are only present with --graph-opts
+ * verbose.
+ *
+ * Return: A pointer to the last character of the context columns (the final
+ * '|' delimiter). Returns NULL if @line is not a trace record.
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
+	struct ftrace_task_state *ts;
+	int cpu = -1;
+	int leading_spaces;
+	int top_indent;
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
+	ts = get_cpu_state(ftrace, cpu);
+	if (!ts)
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
+		top_indent = -1;
+		if (ts->depth > 0)
+			top_indent = ts->stack[ts->depth - 1].indent;
+
+		if (ts->overflow_depth > 0 &&
+		    (top_indent < 0 || leading_spaces > top_indent)) {
+			ts->overflow_depth--;
+			return print_line(ftrace, line, out);
+		}
+
+		match_idx = -1;
+		if (exit_name[0] != '\0') {
+			for (i = ts->depth - 1; i >= 0; i--) {
+				if (ts->stack[i].name &&
+				    ts->stack[i].indent == leading_spaces &&
+				    strcmp(ts->stack[i].name, exit_name) == 0) {
+					match_idx = i;
+					break;
+				}
+			}
+		}
+
+		if (match_idx < 0 && exit_name[0] == '\0') {
+			for (i = ts->depth - 1; i >= 0; i--) {
+				if (ts->stack[i].indent == leading_spaces) {
+					match_idx = i;
+					break;
+				}
+			}
+		}
+
+		if (match_idx >= 0) {
+			ts->overflow_depth = 0;
+			while (ts->depth > match_idx) {
+				free(ts->stack[ts->depth - 1].name);
+				ts->depth--;
+			}
+		} else if (ts->overflow_depth > 0) {
+			ts->overflow_depth--;
+		}
+
+		return print_line(ftrace, line, out);
+	}
+
+	has_open_brace = (strchr(func_start, '{') != NULL);
+	has_semicolon = (strchr(func_start, ';') != NULL);
+
+	top_indent = -1;
+	if (ts->depth > 0)
+		top_indent = ts->stack[ts->depth - 1].indent;
+
+	if (ts->overflow_depth > 0 && top_indent >= 0 &&
+	    leading_spaces <= top_indent)
+		ts->overflow_depth = 0;
+
+	if (has_open_brace && !has_semicolon) {
+		char entry_name[128];
+
+		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+		if (ts->depth >= ts->max_stack &&
+		    ftrace_task_state__grow_stack(ts) < 0) {
+			ts->overflow_depth++;
+		} else {
+			ts->stack[ts->depth].name = strdup(entry_name);
+			if (!ts->stack[ts->depth].name) {
+				pr_err("Not enough memory\n");
+				return -ENOMEM;
+			}
+			ts->stack[ts->depth].indent = leading_spaces;
+			ts->depth++;
+		}
+	}
+
+	return print_line(ftrace, line, out);
+}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index a3a679f74e9d..a65ae369e9fb 100644
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
@@ -95,5 +98,7 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
 void ftrace_filter_retaddr(char *str);
+int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out);
+void ftrace_cpu_states__clear(void);
 
 #endif  /* __PERF_FTRACE_H__ */
-- 
2.55.0

