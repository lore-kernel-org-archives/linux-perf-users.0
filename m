Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7A3A0E88;
	Thu,  6 Aug 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030777; cv=fail; b=i21yXHB3sx7ZUP3c+4kMvaHoyAVG7KLggsx2w3349XYFMCI8S2D5TZ41ZzfSqr7X9dMY/Lj2nCyjY+RcWv3No6D76TKDSa5K/TtmuDQqmQ9Q/ONHP6+/IklvB/+03uvwog/xBJt6ArFF2EcbKK6eucrdIaKMGdUN59jVuxL1UKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030777; c=relaxed/simple;
	bh=2kWvkzYbB4VomTSRrW9QVOSo8FIxWpz/Elsl6pk2sno=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qKDzz1Rs1cpiHj3YijSbarjT3H6YjnpuAot0Dg7qzi6qEO4MLtaTtW9EZbzavqTfzDST64urj7tqvPft6p/kSGZnW4cKo4tHgqVyzf+1t1uInucruys62IQRBb32Z0Vkt+JkVyQnzQL1fB+prvmhyiiWp5w1apoeLXt2TCVG3tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrcBuf13R/21MkVTnim7vCV+GEmdoGoIN40+l7msJOU3Jlx+Cq/kqtUcxPXlVXsl9+cj3UeDWcJtEI4ZLfHnWkCQuQtuZTQKN24NElkuFB2Xwh1iWWlZwsAZTuHFxX8QsqHW1M3JfqMQZ/6lcXCZqPvtPvWD24VPGuNcYzHJhQzJ5Zil96VIarNr5kzFVxY3HguXt8f/FE/5LocJyrtRJgr8xOCY1CCUcJDqTbylGfmrodJXP3gXq2AuNxoCfYpxzfBIx3UhSOsJPisog/T/iUIHqplXUlN9S5uS1jhb99UvL69zUeOuCZZ8+uvEaTgGsLVDuERjalHTVzToEl1Wyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=bLa3F5ZgX842WCBqR/v0vHkC1XoCCIXACzvLAvJxxKw=;
 b=Ls+7j1kkBaT26Uuy8oymQbnt8YqrBVGwqU56CtZ/e5dpptKoKOH0aIHP7TchGl+jC+P/NHe4jF1ZfCRT2DcLnqy8s2K4+PFOCwaLI8TFsFBstSbpIzrxTqCx5/QxvQJ3Mbv2LPa50Dxi59WRtjkPoazJ64HkEQVedbvRbkvwSPwcjKSj/mJ6Pr+AGsVtTOQTMc+v/hk915buj32MO7igcUU/5uO8ZYLfhbwHbvVoNs3BTuTAj4mwVQwfuqWc6R9oXE9y8MCNwbbPDEpd9P9AK3kxW+6lDMgzklglVmd45fyRyhtwPvX6a0nB3QqERy1I985Y/yqZJBXF6Kw4LCxafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6694.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 15:39:31 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 15:39:30 +0000
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
Subject: [PATCH v9 0/4] perf sched latency: Refine outputs, unit scaling, and histogram support
Date: Thu,  6 Aug 2026 11:39:22 -0400
Message-ID: <20260806153926.300499-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fa4ea4-1cca-49b0-119e-08def3d0e79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|56012099006|10067099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LNQd7utAz79vSdvEBZe0xEC4YkPJAdFLY9fM86hFoM8rehqCfqgBwho/mgvHRRSf+y33+tOK2HrBm64Wdjn3XXEBXizaWjzd2Nq4yEU4Wgn12zw2NYKV+YQX1VZ1+km1Oy5r801/hh/Bg8IJK3lKQ5oY90DS0rmBXaRmSPK7uBzB8ft40E4J5nce6jhmMAHPtLDBVh3YIFDYaFhU8VARwIf943SjbSybQIjjfsi2y2/wgcBwxN10FkLUpW216l/G8M+5vSrbS9/p+5A8fldClhXCKgHH6hky1YfefoelItm7P8Ebe1/emFCGm+WS/d1OYIOeSbgBH6jQHsrB7C9ug5Y94g3gRxSbbFxKVKNz29Dw/uIXmEDyt9Gm2ts5QyuwAhUWvXy/yKpLTeFqJAHBXrt4E1F5Cwb+Jz7yJCE8WZD+hQb99mPgRzUFv2Vg0Fij9kMJsalIUmpo/jfUMIpUySkbAMFuVfLHEu9cO6Z5+VaCR/d5Xk/CW8Kh8Pw0ZJ9NXgKvUkvuH8PilZG54UlcT0hA64CEK/CYqOXbcClqMqimTrREstWXZhn8bHCvOEQJIH5Gag7DobQAylaIruD66GQ2o/+yHS8xcLwagzQbKoPWmEidJrAibzmGCCbDy6qa6ZkJ+YvfuTpzyAg+rXqvIW61YXfTHx+J9cM5dWyUPCA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wxb4qzg/oDee/vD/RXckVWOaryjwxKS71DdkxPxKAqRPsKksdCOwd9FnQzbl?=
 =?us-ascii?Q?nkknl+JHqohOwvO50Ou4/48jFGV6mGNo9sU6lOHOuRaRLLyAlUnmK6NvCJpc?=
 =?us-ascii?Q?XvyMRsvCMElutZdlPXJK9/CayxxMBXTGSHKyMvD3I/yV5r8mSMlhtw+IkshJ?=
 =?us-ascii?Q?FHo1PGmNeEDq3rvY2j91BIIF1m9Efkv3aCISJXNEMrgbea0PdmIL/IP8UKUA?=
 =?us-ascii?Q?cnTTQZ0tGV9YVzkH88XQlkcQI/Q8uKmF0a8CYbyJHAULt+LmqP/nDx75ESOm?=
 =?us-ascii?Q?lUOkW87+EAl0/pEBrnTlbcTwk/dmwhzs0o38ERuTgbp1azni2+uRhKz8PNNj?=
 =?us-ascii?Q?cEAYuirNv0phrQk7m0E+TxZ877+WBSBEBmyU4FAV2wn2z3SDAZg5bjQwKgqa?=
 =?us-ascii?Q?1CB3i85XF0+aehkyjeCrfYza0cnZr8s5brTvaSDulgWjvxQCGX8GYBMM4vnt?=
 =?us-ascii?Q?A1ybWPqXyhZuH1q6cGCJyGVQDsOXm2eSDgNAZ7knGWDCgJ/HFWF8HYaeqCIB?=
 =?us-ascii?Q?qr8QUNmYLoGSch2wy0v5+CyCBBnfTZEpGpz0KaO8qmfxaVkN1KVMUgPkdOKb?=
 =?us-ascii?Q?QzhWd9kR72dc5YnM1pLC4ILz/sEsqhEwkM6eEtlhp1yPB2pua+tSR5/xuvnL?=
 =?us-ascii?Q?Pal3Y39mAr2sNEzNwT839mS6Hm5V21MY2DVYaALuBgET85iJPp6aDCYnXITD?=
 =?us-ascii?Q?90gH4abdZLJ4xZGAykL6jr36Q01zi1YgMUISphxDWOg3d2FZfiQ8AoFx84RU?=
 =?us-ascii?Q?mnU+wLvhZCbE8kT4sigIrdvUkUduDKpUQhQF+xm6PCsbMwtA6GpuEfQaBRNq?=
 =?us-ascii?Q?iIC/R0TVB5WUoUrlg9pGNtw0SmE/g1W6EpYWtMrZb3IBLa9l4429Y2WJz9nl?=
 =?us-ascii?Q?HWyzbGrvky3VeFXa5DJJ/J5q9CHYbVmx8hLxDist+q5E7S7PhPpxO5n5xBz7?=
 =?us-ascii?Q?EcZ16hZ0S2MLcR1znUlHdgVe+8cDtklOPnB4Ps0YmCyrPWNOzwOBzKCpiQRw?=
 =?us-ascii?Q?+Fnj2T7Mz17USX0Rot03pyXhPA3uDhsODyH29wM11ejsW5cT6MATNvOrwFjv?=
 =?us-ascii?Q?l9uKUlCAyShhcWUw5Hre+HNCwNh3BboP80Eiz5AoigjRoJRSjbV4bZ/YNN01?=
 =?us-ascii?Q?fntMvCGI8emi1j0lZs2fl9qDzejAKmYrst9sLPX5Yy9LxVMjSFIfxDcaFhGD?=
 =?us-ascii?Q?/q83hkkS05UrV9LeCYxOxgJytRZzTpwWZt80eIlukLOjlXFiJoCIviQ+h+6O?=
 =?us-ascii?Q?Q87VUcThdagFr4ym4d0UanjG1i+kgAIUp/EiscRHAD1XTjskavpDrB0Cfey+?=
 =?us-ascii?Q?fmUs+8HRTHsyXH8PWmhc2koR70LVM7C4fTMDgYIx5HsmcHdRbGM5sdPOCCNw?=
 =?us-ascii?Q?jzu3+gotedxZUwwxZF4XpyYdexiD9AUNIYjeqiC5Tw+jCT2OI0C6noiClIwM?=
 =?us-ascii?Q?sOcg56N2MFDvObWnyy2fEq7+/oYGhyW0CrpFMODexsumkZY1gJYSU0VjZ1LG?=
 =?us-ascii?Q?bY1oTSlQnajLJef/xaaPABNlOuKEqG9lpkPbdtATXMyHMUXDvveOfEo4w1v0?=
 =?us-ascii?Q?6RpBx61W9IhpTIoQ4PgTnB4yqcXR82AqYI4mMSJWVCXBanzhLUF8hjbKFb9I?=
 =?us-ascii?Q?m/zthiXKsOCKivZWFbEjyOOIRw4Q9yFna3FmerRuVcYJtZk8JpgcHRzWdFfO?=
 =?us-ascii?Q?vT6JdDvPLS7f8K83rr0vZiKTp49yA+ltxiO4HIEEd7nzZJs0ojhXTYyDuFxe?=
 =?us-ascii?Q?n8kITenkvg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fa4ea4-1cca-49b0-119e-08def3d0e79e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:39:29.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsp9NKL0Dp+eCiUJfG2w/0ohhhmp6jhWCgWy8daY1RVgojwyflA1FxAsdzzHeG6O7eLvwNaEMqSVL9vbjdIU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6694

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

Changes since v8:

 - Added Reviewed-by: tag (Ian Rogers)

 - Rebased against perf-tools-next/perf-tools-next (Namhyung Kim)

 - Link to v8: https://lore.kernel.org/lkml/20260805210751.287746-1-atomlin@atomlin.com/

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

