Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022135.outbound.protection.outlook.com [52.101.96.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21073F4DF3;
	Sat, 25 Jul 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785000836; cv=fail; b=NcyoGxEQrsGk35lisQHrRKbwEdNrUUlTy6PCEHjrJwr23a4YLkRv8SfN/OsmaVxSklSDhHSa081rXhmZRE/Pj2iuur4fZweMhmgtIKwYu1iQZjZ0ZtoV6GXqZ5HZXZh0+8Zbxrn52zNEWefTQ26nerAVJ8RUGX7vj0zsYlVeHyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785000836; c=relaxed/simple;
	bh=AzVE2MAho7EV9YVirdBmkAbeLSab3RHkh5abS+u/n20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDBQDDFCKAV4vt/V8EHp9DhIOKLyAowYRXdq0XNXB3+Drt4HFdvgDtYRVAdwcYPnxTIdRbvOuNc711jy7R7K8ivjXHpP9N94VVwlFQ1k+KK9z2/5Na96RQKTOqW7dop4IfykiQLAcSZm9vYo14MNCNjgd31x2lpqgC8IGiwwxKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJAHTEDp4t62ijAlHg5fqRCAGfYOwwFScRlyMevMZN+GjGTlS/4q6NKtBnk1fhsFKwpUcxPjnCB17m8nGu8pQI5vrgBHlaADjT2WGXBUsW0TyK5ObLhyg6ngP04MkFcI20fb8IzgkA8cYtkj1BuMIlpxgb3PHnW4Ved51vQEqc9XWFJP5+gWZhXL072DM8C5BTE8CiW6F0LqlMcjMV6ppg1lEhPFdy6ucBq+vkQ95FiE7xr+ExW3gdxUNZCScD5WzVfJnrLdmrvTsUCebcI6XF6D9RzhnTLfcunaqlzkDWlUO3cFFV1K4F/MMAVvrSvQ1DG4inXLPyV3YSvoU/YCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=5CsDdTm9aotaWc3LfQHuysx/jE6ZIKMr8aQuIY87R7U=;
 b=VPShu7Z80CY714faUNnfYGP74APOBxaodaWMujVMTEA1bGKsJ9Cvu0TtQof7GVuMBbHeK4gxPla27BY1D//IEFUJaznQsiJF/aPAEbfgptehc3iGelNJar4w1OStQWr5jqJuDSplW/L9HTro6cQNIzyiLP4ZRbN6z8efwNdzJwkIprwdeqMj9tSe9IdLqr+T+504I8nKUp+NLqHvCfig4Y2Bu+jgleSkfcx5hIS663WFlFIUQikFhPIdQRbvwOtJ1BX6bzt9XPK5LzH7XXkIhOKosshNg11kugSVSzGJbQhisYvTuqf5EwjVNr8FmZA7KZM6HJoEm/U74nySImhb+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6915.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 17:33:49 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 17:33:49 +0000
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
Subject: [PATCH v2 1/3] perf sched: Suppress latency table output when trace samples are missing
Date: Sat, 25 Jul 2026 13:33:39 -0400
Message-ID: <20260725173341.679782-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725173341.679782-1-atomlin@atomlin.com>
References: <20260725173341.679782-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:408:f6::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3af103-dc02-4035-a53d-08deea72e355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|6133799003|5023799004|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Jqmb916Zlv2RsGJsssyZZilO7NjJoa1bVifnkrp9myYRZ/1hXf9z59FMRkHN5f0akqRqkp75anOXRck4y67jJjL8ccE9FzLtGgJ9IxXAc38HSv/xTE8BPZle2qvuF+1ct+L6oFg964M1S+71qM/8OJ5iVK8XnNymEjQ/qqtAuaKCDENS605DEiMhHGGf/saUyPuSJjfJMtvRbcD0JOn1siuyV1uVLfwWyblIQ0k85zLSkzWQD65rD6Hxw+eviwgry6CQqiXfpfs7RiAaEfvNhzmXcPhjVc6/jI6IlCYqX8JYNDSBtFTkYrFbRryIG8kr9LMAaj+6nixyvQdZNDWsgpQJyP5ki4AJuOo5OuH354G9u45+XlpX8sbQ3czeuSGJYVXo32MeWruCAFaVSal0MkShF7OA2hanfRHhMMzOsFP+lXaMH/38u/M8zHl6Csle9SfL1dUKxw64RmHF7mmB07Z9HtUJRMsDImOT5wU0FgQYTqvSNIV+d+jkoojauqFhOfonPFRgYsrA+OZGDqURkBT/63wUSKEFMr0FT2xhv6eerX4vcIqB4nypkQotO1DMGX4oSr1rsJRE9UKThA86kf+g5K5wReXnCdis0Wy+6P/E3y4wVW/h5bce/pWW84p2RkVRRz/eLHFFknX2KSLOnMOqiNwgpspu0M2gqByWgmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(6133799003)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VFaVmcwnfTVoVfBl8Z50tXU5/Vh/NRVhDXkP999JJrYPQagMCtbCVPwgCgQw?=
 =?us-ascii?Q?9l2bd7+Eqg4hEPF2qMscQLu4PETwcCBUcI/Z8X6i6vL+mSCmTAHs0VrsJ6zm?=
 =?us-ascii?Q?bUV/PFCctxt8a7V6yNfFBuLbfs3P986dOYA44qn24xyzvDynWxd3dFNElxks?=
 =?us-ascii?Q?Bxa2aIUkJfBbP4j6ZgL77ifbQMuSI6YvFlEL+4eOXhnM99K75M7KCAtS0SkW?=
 =?us-ascii?Q?s/pnG2EmGaLGEIyjYIA7qYY+x5WVDeyAaO6hJpLRCQwQ/uLAW9260DG64tig?=
 =?us-ascii?Q?CUhfhzk7Cvbf4J41igVMBPoRtmvR1RIYf5zrGUxFM76x7DgwRQ10EEywb/uc?=
 =?us-ascii?Q?YOKAVJJox4o81lSn4AgYeXhsLyJ5nOx1Up+eQwMWiPst+y9vDtZK0DD3CDG1?=
 =?us-ascii?Q?InMRNVFiFr2bgbxVs8qht/NTX1XPNMrolHg/VsM3SPGQD7425U7VW7obzMP6?=
 =?us-ascii?Q?MkH2WjkDB8zbatJB0SSWx0ZrBDKoCQenbcmaEDqIQ/SzdM9iO8qom5RNtlBN?=
 =?us-ascii?Q?yRCU2UOTw6wRsPpsdNznqi6VobHQNnZvuS2L6AvK5MSF0na6Fgba7xpwMNkk?=
 =?us-ascii?Q?qoM4CcuQSBvm/IOyc7BQQbKFQ0g0U3FeHIxf115GKCzlLhNH3pDkoB4SXP6p?=
 =?us-ascii?Q?CzGuOCRTP4GE5ws2vNbbCsB1ATHC8Zmkv2qms4bKDtfG+JUHw2qrg96Uh6MO?=
 =?us-ascii?Q?ymz1U53ELaRY7yizyi5Vf3ocGEuamQYVo5R1ipHXmiCFxRrFiisWfnuNOs58?=
 =?us-ascii?Q?vA+r43HDvdbTkSmaWpz/B+zB+JnMyr2JtxQmLCFASqbpDs3G+WBBmbZ8vMVs?=
 =?us-ascii?Q?jTX7LLNNZ5lDC59/WtKAImp3ywxWoghgVC9cW4XmMAmsgyxhyQoJ7QbjhMM7?=
 =?us-ascii?Q?uXRge6kaM+Obc6Lm0xL0xaFLRsLPbiPhlfZFTOJtH3yW/1ZR9Q+lTbX5U8qp?=
 =?us-ascii?Q?iv1ASTS6/LlgaSLL2CaOvAQjAtnOg22EO5hAhS1SjccXw8y90E5NgG1h5JHX?=
 =?us-ascii?Q?3nLYuULF6s6/GzxPQ9/5qT7U7D0+07NGtdK6D/JIywIpWkMB4uQ31Kq80JS4?=
 =?us-ascii?Q?W55uBtdrpIPGZhpzj/wFEumbS96H8WzakeNfu4Ae0+MNJycB2AX4KXQN16of?=
 =?us-ascii?Q?7VRk8v/MkizbUX7Cs6kJynEoOTmXW49527ZzllS2UytNVzyFM5OnLeGDeh46?=
 =?us-ascii?Q?q9LWjTyTCYoknLXEk4vGstT71XAY5ptpLwsjeAky98K/96RWy8yy1lZ9RsAL?=
 =?us-ascii?Q?zj669z7B4gHJmx3Vgwr5Hj0bFZoBup3pE39T9fCIOIpwVoNddl5fNQPKzLu5?=
 =?us-ascii?Q?IrZ/ERYewHYMIkrqKRQV6up+Xci7hQ9Tws2aUO5nmUpRuCaO82YBhPdvZftt?=
 =?us-ascii?Q?dUNqU0RpnRLiLKrWAwil4VHbFHGrTDnnJwhTLieEwIg7WFSh+2EZz+ajQadi?=
 =?us-ascii?Q?ZjR3ONEv1vnnIhc4ljoWxrZtEWYBVaTN3Kna40pSQ0D77fLHmjP9S1+dygpY?=
 =?us-ascii?Q?+3VwDSj0skzXPeUDt6kcMA4sy+RbovBeJto3/+WYAln4k0lVwnjWzZbVTI9Y?=
 =?us-ascii?Q?z/e/tItw51Q9vj6FFO08EE2b5AuT2P6b7oOK+7TzCM+wMpfRVCUcNaX+1j8J?=
 =?us-ascii?Q?2M3Oq/MnClmyFFl3fyDMr6/GSLbVwSPXU5GVjNFCv+P1yTZIbxoTFIn3dGm6?=
 =?us-ascii?Q?hCp9iz/OjctRzX/Q3+Ig2jmAHIJbwdbvbqK3+Xp64v8yRbvHWYTTmvqJAe/X?=
 =?us-ascii?Q?RpKKAmDclA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3af103-dc02-4035-a53d-08deea72e355
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 17:33:49.5157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcVVvGZINVcs8dCpqwRGTrAjtpj5VB0+aDMMLprVDARnku5ddftbd8cfFPYTg4TogNSBRjp6h0OP/2nW+t8DOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6915

When 'perf sched latency' is executed on a perf.data file that lacks
tracepoint samples (i.e., a file recorded without the -R flag or
containing only non-tracepoint events), perf_session__has_traces()
correctly outputs an error message. However, perf_sched__read_events()
subsequently falls through and returns 0 (success).

Consequently, caller functions such as perf_sched__lat() assume event
processing succeeded and proceed to render empty latency header tables
and total summary statistics.

Fix this behaviour by ensuring perf_sched__read_events() aborts early
and returns a suitable error code when perf_session__has_traces()
evaluates to false. This prevents superfluous table output from being
generated when no trace data is available.

Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7fd63a9db457..b3cf678573e0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2001,7 +2001,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = sched->force,
 	};
-	int rc = -1;
+	int rc = -1, err;
 
 	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session)) {
@@ -2018,18 +2018,19 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	if (perf_session__set_tracepoints_handlers(session, handlers))
 		goto out_delete;
 
-	if (perf_session__has_traces(session, "record -R")) {
-		int err = perf_session__process_events(session);
-		if (err) {
-			pr_err("Failed to process events, error %d", err);
-			goto out_delete;
-		}
+	if (!perf_session__has_traces(session, "record -R"))
+		goto out_delete;
 
-		sched->nr_events      = session->evlist->stats.nr_events[0];
-		sched->nr_lost_events = session->evlist->stats.total_lost;
-		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+	err = perf_session__process_events(session);
+	if (err) {
+		pr_err("Failed to process events, error %d", err);
+		goto out_delete;
 	}
 
+	sched->nr_events      = session->evlist->stats.nr_events[0];
+	sched->nr_lost_events = session->evlist->stats.total_lost;
+	sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+
 	rc = 0;
 out_delete:
 	perf_session__delete(session);
-- 
2.54.0

