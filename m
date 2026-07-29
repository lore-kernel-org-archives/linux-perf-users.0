Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022078.outbound.protection.outlook.com [52.101.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519B48D860;
	Wed, 29 Jul 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336303; cv=fail; b=Mmczfl+DciPHdvVb76XlpjISXnLaHGBGCPfW2xFzihthuczSERxNYPcVN4oEhMQOecSTusR30YzFrOM9lcbhsvUXlzja8TtQMe21Reud4pAXs8FizjRlpMBzKiaKBnCAFgE/BWlJB/1IbxLwsQmSb9Jxo2mwka/Sg6L20lHP7ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336303; c=relaxed/simple;
	bh=IRhFxWoNRwDnzHqEBgrt2VKUb3dzsmSDZxnFyjyf39s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5e1Z4kw9JaRPgth2NlH7Gdhf2aL8WTEJNQ7WZ50VQhkSK1uts08lQYr2++0kpoI7AFbNe26Q53pfsAZZ/ztkXt+Hii5SnVYvXFuUNPC+vJsiNJvzzxrmNbnnU/5ajIfUL+w6W8nNDsyOZXuTXShKx2hTIrUpcHmc+F4joFxlQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khQsj868KEP2QRKKcJCkHIeeK8MdIk58ApcN/LqypXfDG5jJA9VX/6rk+MV8oLDJwAp/yDxAsKJVswwWyGU9z6VjR4sMRXKngtSXxn4e8sq1KN+9q0mK/Swc82sCpMjdMAqSyaQ+Mwx2WIg57/P6Lan3WXRVDN2af3cXD0MdkNnJrbwrT+sPV+JH2YTdvnvMGZeRguamlx4uCVeh0om7fVVUdBELEE/z8X3bx0Y9GYDA7SJDB6MvfvLegmuV4OlvNhSQDNj3EbJUoOScbA9mwXNYzpRKW52s0p0FuUf72vnK0OEpUDoUViGvLwZg7UHS5Uq5Ik6ZLwSbs36SXkDIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=7zoozAA+qB3DJYAKEgMaZyUqwGAj4vXpX323WaDiQNo=;
 b=J5udT090JCMYTyovtUHF/YuGORVFTN/JlbiPiRxz5XK+hBFOa/hbQHooWjG87CNVwO2cYyUj1ltAfYzrRG64cFApyA8HZ52MAkpsgg/jsRPZbRwWH6F/rZLRrUXOFCONidF5DU+o6HgfMsHqJZSxE/GHYIF+R+8QRKXj0+4mnwn6pjYmc6FCOAGcZWm3N4zUnjvUDfKpEeeqN3gjHIfwmIR7fgfW1Z8KqxXdbrHcKmQ00S8/eE8+Qyq3b4Yq+gl3xfIZ4mMxZTv1K+fh3HizU0Xl5fHCfYhtSCat3WRoguwxEfJf6RtlwE8BDCV7Z4IDS4EIQYSFDEY7YmfaJuAwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8527.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:487::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 14:44:59 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 14:44:59 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] perf sched: Suppress latency table output when trace samples are missing
Date: Wed, 29 Jul 2026 10:44:49 -0400
Message-ID: <20260729144451.38286-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729144451.38286-1-atomlin@atomlin.com>
References: <20260729144451.38286-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:208:239::13) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a7e5f1-40c4-43ae-8e00-08deed7ff6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|3023799007|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	uD8jEMUwngr3vp1rTzMXNh4iTEm+LDQHh+FJg8lb6wInp/QzNhBmnGcJhQGpnWKwWUBFjYBUsx10YD4Pw9TpVMhaZcNC/KyxzmMuWxCb7YKWEx3SA4hYBgjarlN23rhs7AUGBvh3l42OlqGnXcvsekd0wFxGAoaRnZXXuPK/HFZEUG9C0Yz3sSACWG0kyGVfirt5HKgOU75kJGL952FZ4elkZh+ccJAxxep36nKaewcq09ZssCwzuFQionTtnU5ww6mFSg0FypD40TB9twegsSga8UkTET7e9lP6wszuCUfBILmi1o9RaiRO2B+GDl9jWrLVQ4zv+WG3uZUu/rvstQDbT3pT620VFErGXBxKFavHNc1gEJIIUAc5bsLuMbexUqVUThBinSv6pXqVf6rc7B53KphdUEIj/GOlazaJ35eEiSCAhCz1JrCow+cn0U1zVW2eVUSDvZr6gO+SajPQhrKV8wsYkfuKB3v661ErnTy9wBjNeVwGsEPdZcawOs532b8BXj6EHVihgL4h+IxAt/mIRWIKEBM70VBCb4QOUNWOKeuk/c3rq+5+zO2Nyv2fYdFb8q1t9xuAcuAM/Nbi02YMG8oNjhDRCRwGjBxRDC/lXrPqO9OB6t1gdlh8Nfp0rHJ0hI0LetyH9xJSHTbozgleqOFpVScPMPMo+2TpmqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9BMsioJ8OppABujVNaZZJuj3qtArV3hJFiwtOPHVqcbICei2lOYIB7QVluM8?=
 =?us-ascii?Q?Vxw3lvCXX1VRD6irho8qUe92IglFGJYZ++8+lwnQdVPcKHTFoaWh8sF48XDK?=
 =?us-ascii?Q?V53VE0PVUa/ERl/h9M2OKuM9dPjIP4NKgPzgdjEkYP4wM7NFlgAQcZPdfGEn?=
 =?us-ascii?Q?OTF4iW+ATFq4z7XEnDWtIuHLFzd7SCWBgF7evp287SxXiVDi/Hg7qpnE2YkQ?=
 =?us-ascii?Q?WVjqnAev2BEd4P0Jqlx/gMAspLKJR5mlNH7ZiCOgSdGBapl9e1893r3fyI6N?=
 =?us-ascii?Q?toA4SSZHiWrqdip52tv+/v4LwIrOsDeX0/wAmCHTUEQaagaaIFVSJvbNs/z+?=
 =?us-ascii?Q?9Z04ns3sygISk9aFuht7M76Ic3PNMEnjEcgJXjumrD1vjSShdO/IRNWnOxgf?=
 =?us-ascii?Q?emlkZ1IWtlsoN/CZkTzEDNTRecKUOAvE77RlWOTj5CMQTx4qid/gS5gEchWf?=
 =?us-ascii?Q?9AJc1SZyluuebpq2EAUXqyh5K8wMB9jzPiVT2w0Yjj/uEBIapE6H8w2ObLR5?=
 =?us-ascii?Q?EiDH0PQPX0/q1Xa47kAvDMcB9RGK7MhQ/PkWLnUZKHftbiqLtGARCgBJuo73?=
 =?us-ascii?Q?Ikshfx9hurlIlVc00FcpkbJpHuXJFj8CGdQ6VFXYMlSdI4kJFNKpaT2KKWu+?=
 =?us-ascii?Q?vOVTOLf6+V0BLXrxrjnmzeMviSjlNSJamK0ep9/5bLVVzjS2bcBvGvQgr1VR?=
 =?us-ascii?Q?zcpX2Eg9rnlo1Ls1gsmMFR6dOXeWrmmHgMUwZ6AQfaDjRDNdrDO8GXoZKpgg?=
 =?us-ascii?Q?Svpzzz2HZywZplbKckueBoDhG0Zw+rl0NTEBDtIN6DnHzFLgwhFNziEf5AAc?=
 =?us-ascii?Q?VNHS2GM9iGQohKPSdtwo7BIL5pN3kPzcUk9JEk4uQjjzQMJEGadS7Qe/ryVM?=
 =?us-ascii?Q?A3+e8QAMujfAw0YwLzmKeZcU+X7CuyMndsNRKj5oWWC67cKiMrxovAeG8tvv?=
 =?us-ascii?Q?rYMnjMAKh3nzGAZIxvUzb51QtCHs1Bco+zmzauX/0y4dXZ83MaYnlrN2KJ+8?=
 =?us-ascii?Q?f2oXPIHT/BhPqE3z9XcaWECJmvpX1SPFrEQVxGYh6YAKYnFYZgZf+hDKynxw?=
 =?us-ascii?Q?zh+fhwzBgdKaoeWRAKkme25Vfx6zz+qmVuvcL32eU2Dh/ioff7u1HiFZscA4?=
 =?us-ascii?Q?ii129wKy2H7tF54OLeo/ZzZ12Vc5EZ6Y81TAHRhLQOVj3OUAUrF3ughb9y0i?=
 =?us-ascii?Q?EH3F4sgdr106kMSh5LDgRAVu3qn+zL7LpNjpvyJlojaTzWdZNO0F+ySXGDX8?=
 =?us-ascii?Q?HBg/kNNAGXgBRGxYkVhyCVqnznucZfujM7Bklh7X1AmRdJrucv+LAMjtw+ii?=
 =?us-ascii?Q?VIqWhJPd+rOu2fLQGhg6SqO5Jt9uI+18dLTfGJV2Cv95+SwDe9WlrWHIvMhW?=
 =?us-ascii?Q?Xkp3g7G0zkZe+KE4zcPwv2wiibBqNMnBj0RNkY9H6TgEJywp0ps+epjTq5xd?=
 =?us-ascii?Q?P9tuFrTJnNynuRol9P5pDgblLlUqtWUPOuIF2lPJGa2NBkvtPS+xsImdw5t6?=
 =?us-ascii?Q?VsDZjKxw9AOL6C9elnyfdFfPwmywahig/sAy88D9bfpXMKm4LEaooBrW39Al?=
 =?us-ascii?Q?nD+NUEt2MhWMfrKpXO3cRXT/4gfggHMJnX7dDxtRhBMDWM5joriqlEUaWTbo?=
 =?us-ascii?Q?2s9jENdsw+lDzGk0MvABb7htyOUFgljb1aE6ds/FWCISJlQLYg/1w2tk4bW2?=
 =?us-ascii?Q?SbPRilrmCHbuSKztYuqslx/myQkP8idhWXNYQuCfCMWMHJ1l2IbBskLVy/L9?=
 =?us-ascii?Q?AgljLE4okg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a7e5f1-40c4-43ae-8e00-08deed7ff6ae
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 14:44:58.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RO0e6nvSr1GoXGOtK8yyN7074FLEwjCaLaUOAbzX0eKTtycuw7WfLnC5dL5ioTc840Mw3a8038VK9PLAuHBCAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8527

When 'perf sched latency' is executed on a perf.data file that lacks
tracepoint samples (i.e., a file recorded without the -R flag or
containing only non-tracepoint events), perf_session__has_traces()
correctly outputs an error message. However, perf_sched__read_events()
subsequently falls through and returns 0 (success).

Consequently, caller functions such as perf_sched__lat() assume event
processing succeeded and proceed to render empty latency header tables
and total summary statistics.

Fix this behavior by ensuring perf_sched__read_events() aborts early and
returns a suitable error code when perf_session__has_traces() evaluates
to false.

For pipe mode streams, event attributes are received dynamically during
event processing, meaning session->evlist is not populated prior to
perf_session__process_events(). To handle pipe input correctly, register
the missing .attr, .tracing_data, and .build_id callbacks in cmd_sched(),
and perform the trace check after event processing when handling pipe data.

Additionally, validate thread__get_runtime() against NULL in
map_switch_event() to prevent potential null-pointer dereferences.

Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7fd63a9db457..fabd99a18aad 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1833,7 +1833,7 @@ static int map_switch_event(struct perf_sched *sched,  struct perf_sample *sampl
 sched_out:
 	if (sched->map.task_name) {
 		tr = thread__get_runtime(sched->curr_out_thread[this_cpu.cpu]);
-		if (strcmp(tr->shortname, "") == 0)
+		if (tr == NULL || strcmp(tr->shortname, "") == 0)
 			goto out;
 
 		if (proceed == 1)
@@ -2001,7 +2001,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = sched->force,
 	};
-	int rc = -1;
+	int rc = -1, err;
 
 	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session)) {
@@ -2018,18 +2018,25 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	if (perf_session__set_tracepoints_handlers(session, handlers))
 		goto out_delete;
 
-	if (perf_session__has_traces(session, "record -R")) {
-		int err = perf_session__process_events(session);
-		if (err) {
-			pr_err("Failed to process events, error %d", err);
-			goto out_delete;
-		}
+	if (!perf_data__is_pipe(session->data) &&
+	    !perf_session__has_traces(session, "record -R"))
+		goto out_delete;
 
-		sched->nr_events      = session->evlist->stats.nr_events[0];
-		sched->nr_lost_events = session->evlist->stats.total_lost;
-		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+	err = perf_session__process_events(session);
+	if (err) {
+		pr_err("Failed to process events, error %d", err);
+		goto out_delete;
 	}
 
+	if (perf_data__is_pipe(session->data) &&
+	    !perf_session__has_traces(session, "record -R")) {
+		goto out_delete;
+	}
+
+	sched->nr_events      = session->evlist->stats.nr_events[0];
+	sched->nr_lost_events = session->evlist->stats.total_lost;
+	sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+
 	rc = 0;
 out_delete:
 	perf_session__delete(session);
@@ -5167,6 +5174,9 @@ int cmd_sched(int argc, const char **argv)
 	sched.tool.namespaces	 = perf_event__process_namespaces;
 	sched.tool.lost		 = perf_event__process_lost;
 	sched.tool.fork		 = perf_sched__process_fork_event;
+	sched.tool.attr		 = perf_event__process_attr;
+	sched.tool.tracing_data	 = perf_event__process_tracing_data;
+	sched.tool.build_id	 = perf_event__process_build_id;
 
 	argc = parse_options_subcommand(argc, argv, sched_options, sched_subcommands,
 					sched_usage, PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.55.0

