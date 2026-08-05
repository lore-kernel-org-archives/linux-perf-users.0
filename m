Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022096.outbound.protection.outlook.com [52.101.101.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D735E1A2;
	Wed,  5 Aug 2026 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964082; cv=fail; b=DL+e0qL/LiKWuBQ3rBj/N+NvnjkJxfbhwY0k3+soUDNNGxpQhbuBy7qSYWw0FZE0cCpGPrlPuJOEIakpWLmKBoZ/kahTjJ/NrOgL2025ovhznajnZ6NUPJZ4rjAMK1Av1i9UUFPHdmhc3G4CIWeKS6AfOsVJSWOKjuTbHIBHhWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964082; c=relaxed/simple;
	bh=yaNIg2UwWRc8Q6sAxMWhhhmnQE0DBDB7gHVZEQL7TSc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hrJC3WXNS0VCSderDJa4jgyFsEeFrRYCd9QgJFVsl31+1K9lsvHAUIOAMwGmNQ9y4GJssS4SuioIIW1Yb8Y/TIC/VgcqMQlmd1yKMLpRnql03IwBLS2pIAsD0YmrL+wMX7iGT63ZkQj/nD0lSPtuY4g4LjCpZ15vYB8oKVxPmWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nfc0WkY1PExj/4tsdJcvSSritffP9IJqFaYL1+3633eFnTufY4Qt0UYzCpS7ZxFoGiWzLGRRjJIwAF+Ll5nu5EG4WzruweFoiOFl1ZjmbXwhcFBaO2uo/3koWZ2uoyePd8BFyBWc3pYeKXl693Jo5uAowRd9e67fvzFQZ81JGRsC+QFBgaCx2ylfEzV1Dbc8SiXowofeDC3u3misOV5cLFur1Xn0knj/puPMlWo9Y2I728QxHiWw4LdUugA9RmcULn4OvtazfFJowtxN70WSmm/Ib9XBe++kTa8KaNRdNNJt2IfVLW/iYba5e8ZKcVqhmFdVfxo+A4fVHY5fV+sMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=3NaL0oN8CAZpja5bxcSBpwkaZnxhyNlWPelHpWhF/3c=;
 b=yv53arOjCQrZscx8nzHMMfv/R+Ngx4ovK097jAlBn0U3ZNRanUFLLpLKoGKKPZiza+nT+kzQOJwjlRhfl6fse7dqx5ftc7QCmJrSOWvdhBbUsmlR9GquA+tnPCaytAETfdIVG88mpqMnpPMZj9uzzHD0uJ0ag0WL1g99M8O/VKf5fZXfapb25VE7J1yKUnsUZnzgSdgLlm0jVIQazUFdBb+4GRPtLhCr2fiF+HzZIkxeStomOwMB+B+wPDb+nIhUG8e5PyuUMnf+kHywu3Uw9wF3UNj96RLT4g0l7iOYUi5QqOUGV5juXqL37TP+nSao9irdbpWU5kUzZJEIC0B0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8157.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 21:07:56 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 21:07:56 +0000
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
Subject: [PATCH v8 0/4] perf sched latency: Refine outputs, unit scaling, and histogram support
Date: Wed,  5 Aug 2026 17:07:47 -0400
Message-ID: <20260805210751.287746-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:408:f9::28) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d37581-a5f2-40b8-f0ee-08def3359ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	DQpD62Gi7135/bYZryHFQJkuVSMmySp6GRhvLe5Go+ZO1xhH502iuFnQO1lyVUEVcWFXOO9LSxnRiGt4GGdwIie55sCV4moIZKIAhqBKyQuEj7x0iN6wIQuoBk4JhbHu+q3Kn+963Y4KwJKyiVIBOUpIlK//UoHDcnyjf4i8j/9SZpTjQUEod1g3GlD3zXk3i5ipQ7gLDu3+CSorCTiiD45kby0bEfPbuB7s2MnIb3pKW+bV0eFJqaRIy9qMuh53I8bMCGf2qKIw8fu1CYpraEOMy0OXDe/rXgz6qHnfvOeD5GiOo2tYxFoKMkx8fIzP4Aq/2i9+Ql1J93TCVULe83eLjVCmRkPVWAEl2SuiT3ZuDT7xhnpUjB/3I1GnLl9UhCud27AigV3gzCAS6YViKQcJQ4/FR00GcK6a2VTqdvHLNEs5r04J6C+s9P7OLPgrvarJmd1v70T1xAe8DGJE34wnCTGmwTjJhQTyW1B2leofwMxQqx6MujKzwXIaITVVmDBhOcgAf3tf4WFVkDjR0F29+Ax/QFW812XQMZDf9nHLLHoZkMpogsDKpDyxkNcGfmZQZ0lOp6swoIlq838aFxuIgZU5uI3ZqzyD/2FIZXzkAq96GocEW/ajatBCheFlJsl/jE2RQi1hLCJUs5FuzKjKHruaMjqHpO5Cmp+tyhk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/5BPvumykhZmcLwm5f34LkqId3g6sqWkfzBIEdylpO4pNO1uEqhKPyj0l7u?=
 =?us-ascii?Q?bw5PcQyI/1IDJufQ5T3E0L1CvL/esLVQz6ok8zza13WKfAxwiaPsezFhOkz8?=
 =?us-ascii?Q?9D4ecs98NTseH6047M09ZEnlQ5699Ekkk/18hK3/XEsOLShHx6G4DXkqYaex?=
 =?us-ascii?Q?KAEJ0Q1uAe1S+bdPP+p1/oftcjpLCeyLJ3CbFr2V7CeAOXP2X5xZzsnSCSID?=
 =?us-ascii?Q?iplTtXSHGjb893QJ/iuYRuyDZ/KXTYn2d4FWrpscD4dCt/vexL/G63wWg1XB?=
 =?us-ascii?Q?62PGnx+gcNP0fN9p+nvM0hSnucXDOt/B5q975CokKIHspN36TvKFZuEtqOXy?=
 =?us-ascii?Q?rJi2FRK6bGWe6dInJgJxl4Zt8DFuiUyClTJRdO1UAz4nxWvOLzO7Q8FJWOQe?=
 =?us-ascii?Q?z8xlMdUz7EWhOMYJvj8CivjKLoftf7KOxN2ktyuh1ymVkPppFjjjOMkd8Iwq?=
 =?us-ascii?Q?P6N0jLHQnDQySBBH3VxuR8onLjGm1powGMFUPyZIgj6lrpnWfvHEmfJYoOJ2?=
 =?us-ascii?Q?63wYht//eeBmrH270rHz1t64P4eKRjr3EPd/L4FTxP4Z0ZvbEGVMEY30fNU9?=
 =?us-ascii?Q?IHdUEZIRlKYf8rjrMK81nvTneeqV7sr1NnCO/Enu99yr6V+c2XFm6ms5zEbx?=
 =?us-ascii?Q?xQl/fjmIw57HzQLiAJhd7mPUNyoKIUDLoO6jzD09a0894wqClCgUbCvZzROh?=
 =?us-ascii?Q?wJT/9BMnxPVClWsJ0OYvorOObYG2X+9T5SGkNb2KVoeVlZVw0qkQuYYl2BQu?=
 =?us-ascii?Q?d2RItchKP4HF5lqtdvrb/z7XcZBwLYd71dylbwSKegpS3JwbxMk/r3nT1QA9?=
 =?us-ascii?Q?F902O00LDrXW4VWIkRXbx/iGl+yVcaOQ2fW7gPQTViK9+DDD+BC7gcET+nZr?=
 =?us-ascii?Q?JBal83ZWyUiTANLDRGVZPMoNQFHCrwInHnNxVo1+5iU0cbpjVTYje5vHiqCJ?=
 =?us-ascii?Q?rix5nLGTjlznTfov2N/WVxSFU14eBeYq8MHgphXbTV9WFt2WSVGxzuEtNkag?=
 =?us-ascii?Q?JChDoT7XE6uBmo28LwxyT+Xlgc2ih8msXkfFffwnBofFKzVCL0WWlmbQ3V6F?=
 =?us-ascii?Q?/w3y44RUZF+r4/5hVw53NHCDr61NNA0IkSvEPLgf6FRcABHH5f2cXnOWtwkp?=
 =?us-ascii?Q?DeWK8KnRk+ZX6j1A9KGxIutSioGTOw0xLKJWFQfN9zaYe7Fa/IMVfE/zmbIW?=
 =?us-ascii?Q?y9xbkUg/6cTI9rK1/gDSkh7TMOwaBkgEwxjQRpwbvRm6lgiz/xHfipYv+1cd?=
 =?us-ascii?Q?4+jH3khymRqz3jqXMkUkXGTaln9Z2gbfarg48CBgTP+YmDL+7rDdTQNoTECl?=
 =?us-ascii?Q?Gzo7JRyNlPe0C6RMsb3ZdjZMbZjfwdi2GsfoLjZC4Ew53tVDpceeq3lwXHqm?=
 =?us-ascii?Q?w9Ei5zM+fbRv5pg4sEqMLOGBQQHoJIykn0dCNbFS54fB8ZCh55WNrgLZHaR9?=
 =?us-ascii?Q?B346I1QspNEf7Ji/9KVGJEwLnYtMJ+tQEMvI3R/IQV6UqEPJppI8Jmhp029z?=
 =?us-ascii?Q?mttSTiyc+2DBn2YoZmnAZadbDu9wXXm4exUiU63b7/E+DA/oIsG0ucWoy+mJ?=
 =?us-ascii?Q?D9Fwzwq8clsJ08QcKuQoLQymxCTRLjG8JyHuhucNSBqeWO7NOa3khp6iDY4T?=
 =?us-ascii?Q?U4eHiKR8ewO9ozYoKZfnln0pMJ4KfWadraGLslra6HAlJNPff+EBjmGNueQu?=
 =?us-ascii?Q?j6mCs/6Q1o4Mic08DolaDh8JWPwt9ATnEtwPbX5hqRsIMQbdTIwKIx024I4z?=
 =?us-ascii?Q?nOzhVIDw4g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d37581-a5f2-40b8-f0ee-08def3359ecf
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 21:07:55.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Bq/vi8OKqiqNf/EcIPhk24JSsILCWLXc39qPY3RihAczrETObnUlsr8M+sV0UmvOabKKxOqI+6UefowJVGSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8157

Hi Namhyung, Ian, Arnaldo,

This patch series improves 'perf sched latency' by suppressing misleading
empty table output, extending pipe mode stream processing, introducing
dynamic unit auto-scaling for latency and runtime statistics, and adding
latency histogram visualisation alongside time-span filtering.

Patch 1 addresses an issue where 'perf sched latency' fell through and
returned success (0) when perf_session__has_traces() failed due to missing
tracepoint events in a perf.data file. This caused empty header tables and
zeroed summary statistics to be rendered. In addition,
thread__get_runtime() in map_switch_event() is guarded against potential
NULL pointer dereferences under memory allocation failures.

Patch 2 extends pipe mode stream support. Because event attributes in pipe
mode are received dynamically during event processing, session->evlist is
not populated prior to event processing.
To handle pipe input correctly:
    - Register the missing .attr, .tracing_data, .build_id, and .feature
      callbacks in cmd_sched()
    
    - Promote the handlers array to file-scope (latency_handlers[]) and
      dynamically assign matching tracepoint handlers (or
      process_sched_ignore) inside perf_sched__process_tracepoint_sample()
      when evsel->handler is NULL; replace process_sched_wakeup_ignore()
      with process_sched_ignore()
    
    - Perform the trace check post-processing when handling pipe data

Patch 3 introduces dynamic auto-scaling for latency and runtime display
columns (Runtime, Avg delay, Max delay). Previously, all values were
unconditionally formatted in milliseconds (ms), making microsecond- or
second-scale latencies difficult to read. Columns are now dynamically
scaled to the most appropriate unit (ns, us, ms, s), column headers are
updated, and format specifiers are aligned character-for-character with
table headers.

Patch 4 adds three new command-line options to 'perf sched latency':
    --histogram (-H):
            Displays an ASCII bar chart of CPU wait latencies between
            snapshots
    --hist-mode:
            Configures the bucketing scheme to either logarithmic (log) or
            100 us equal-width linear (linear) mode
    --time:
            Filters trace event processing to a specified [start,stop] time
            span

Changes since v7:

 - Added a guard clause in perf_sched__process_tracepoint_sample() to
   reduce loop indentation (Namhyung Kim)

 - Converted dummy process_sched_wakeup_ignore() references to
   process_sched_ignore and eliminated redundant code (Namhyung Kim)

 - Replaced string comparisons with faster integer checks (i.e.,
   thread__tid(...) != 0) for swapper (idle thread) handling (Namhyung Kim)

 - Added automated test cases for --histogram, --hist-mode, and --time into
   tools/perf/tests/shell/sched.sh (Namhyung Kim)

 - Link to v7: https://lore.kernel.org/lkml/20260802210914.199941-1-atomlin@atomlin.com/

Changes since v6:

 - Fixed O(N) hot-path traversal overhead in
   perf_sched__process_tracepoint_sample() for unhandled tracepoints by
   assigning a dummy ignore handler (process_sched_ignore)

 - Replaced evlist__set_tracepoints_handlers() in sample processing with a
   per-evsel lookup to prevent -EEXIST early aborts and avoid dropping
   late-arriving pipe events

 - Updated commit message for the pipe mode patch to reflect the
   single-pass handler assignment logic

 - Link to v6: https://lore.kernel.org/lkml/20260801234008.176724-1-atomlin@atomlin.com/

Changes since v5:

 - Split pipe mode trace sample handling from Patch 1 into a standalone
   patch (Namhyung Kim)

 - Added a Fixes: tag to the pipe mode patch referencing commit
   27295592c22e ("perf session: Share the common trace sample_check routine
   as perf_session__has_traces")

 - Updated commit log with before and after illustrations of table header
   formatting

 - Link to v5: https://lore.kernel.org/lkml/20260730185416.97166-1-atomlin@atomlin.com/

Changes since v4:

 - Added the missing .feature callback to sched.tool in cmd_sched()

 - Fixed memory leak by reusing uncompleted work atoms when sched_in events
   are skipped or lost

 - Promoted the handlers array to file-scope (i.e., latency_handlers[]) and
   added a dynamic lookup via evlist__set_tracepoints_handlers() inside
   perf_sched__process_tracepoint_sample() whenever a sample arrives with
   an unattached handler (i.e., evsel->handler == NULL)

 - Prevented double-counting wakeups (i.e., ignore sched:sched_wakeup)
   in pipe mode and non-pipe modes

 - Added missing trailing pipe in output_lat_thread's new auto-scaling
   format string

 - Stripped redundant prefix strings from each row's format string to
   produce a clean, tabular output

 - Link to v4: https://lore.kernel.org/lkml/20260729144451.38286-1-atomlin@atomlin.com/

Changes since v3:

 - Registered Missing Callbacks. In perf_tool__init configuration inside
   cmd_sched(), added the .attr, .tracing_data, and .build_id callbacks.
   Without these callbacks, pipe mode drops header attributes entirely,
   preventing tracepoints from being populated in session->evlist

 - Introduced an explicit post-processing pipe check. This ensures that
   pipe mode aborts correctly and does not produce superfluous empty
   latency tables when no trace samples are available

 - Prevented potential NULL pointer dereference. Added a NULL check for
   thread__get_runtime() in map_switch_event() under memory allocation
   failures

 - Fixed column alignment. Modified format specifiers to align
   character-for-character with header column widths across all rows

 - Adjusted header label padding. Updated header label padding and column
   width delimiters in perf_sched__lat() to match the exact field format
   specifiers printed in output_lat_thread()

 - Fixed swapper histogram inclusion. Excluded "swapper" (i.e.,
   CPU-specific idle thread) from global_hist buckets

 - Preserved task state machine across --time bounds. Moved time-window
   filtering inside add_sched_in_event() to gate latency statistics
   recording without breaking wakeup state tracking across time interval
   boundaries

 - Link to v3: https://lore.kernel.org/lkml/20260726032533.712462-1-atomlin@atomlin.com/

Changes since v2:

 - Ensured vertical pipe separators align across all latency table columns

 - Excluded "swapper" (idle thread) latency samples from global_hist

 - Preserved task state machine transitions across --time boundaries

 - Suppressed empty table headers, total lines, and histogram graphs when
   no matching trace samples exist (e.g., when --time, --CPU, or --pids
   exclude all samples), outputting "No matching trace samples found."
   instead

 - Linked to v2: https://lore.kernel.org/lkml/20260725173341.679782-1-atomlin@atomlin.com/

Changes since v1:

 - Fixed integer overflow in latency_bucket() (Ian Rogers)

 - Linked to v1: https://lore.kernel.org/lkml/20260724142901.634761-1-atomlin@atomlin.com/

Aaron Tomlin (4):
  perf sched: Suppress latency table output when trace samples are
    missing
  perf sched: Handle missing trace samples in pipe mode
  perf sched latency: Auto-scale latency and runtime display units
  perf sched latency: Add histogram and time interval options

 tools/perf/Documentation/perf-sched.txt |   6 +
 tools/perf/builtin-sched.c              | 347 ++++++++++++++++++++----
 tools/perf/tests/shell/sched.sh         |  29 ++
 3 files changed, 332 insertions(+), 50 deletions(-)

-- 
2.55.0

