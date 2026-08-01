Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022088.outbound.protection.outlook.com [52.101.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122A34CFC3;
	Sat,  1 Aug 2026 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627618; cv=fail; b=JJWPiGG2DekHs2zkBDsc8SeMyfEvpph0J+TSXT8teFoacLtyHdbuBpL3j/lHEEPr1gdALcZEjSUeLY3paPEaokAEuIchbj+FoSpNqqjaVTtnpX5BWlRskXAWEuY3J5vuiLrvf5FAvYugOosXbcMjCqD3CJU73fXIfyJy/vY9csY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627618; c=relaxed/simple;
	bh=r8oVIFcTdXQXcMXZ9VYQHOh1JM7oSRWOJDf2zhEHG80=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WQyCLBVUsmH+nnfcYmk9yB0zJH6+RPEK8J1U36KjbUvhDombdsy7I9iw/eAHKfmUeHJtn33/RDZrn3G0vKlzD9TgrWJLlThgEF6TqBjC9g2IBFL6iC4+jR/UuCkC5alfZMk9j/dvXVH4JgLOC7FybsKW+CuPTtK/mUCBcv0LdK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAfa0UBHzc/Alu/IjMfqX6ccB5nDLaMy/9CooCGWuN2oOi4kh4bXrhcby5ZILWBZjXyVKN8uOjpQs9EAHACjN9LuK6q99QPj4Iu8YMcLaTtpn1Hl+8EX9SPFF3TCCx87GTCf77cgkIT6fMQR3V5fIuK57gbUgYmSyqJ22+MjeMO2dfzbUA//sePRb9uVIm4IgaOvcAAgsBk48K5GuXY+Pb54kLrz4HxY9XAM7Gu2Vwy1SrFWh0nvEluxHXiVeJd/JqF4rbcGcSR6DnrXkew4VnDgRZ3LguFt/5LzOb8b409pQ+9cpGlWY3D5u3gWlhYgqUJMquNK7AuIVeusPRmP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=NMpjTD1C0fsqQCsB7xtTyMWTFSPs/bkyzWWCFMjIurM=;
 b=W1lsHzujh3UHjcT7F2b3ajQvzKF4YKx4aOylS4rAIiWYcheUI4J4gydpCZKpwTHsT+eHIjmCMX2Oq/Y0h65Artskl6WWhVldWBp6JVqSrBIwhWMUxVJahh0ey4NiqFfucXWVa1k85C9MfyFx5+xNGhEcasUXxVJluXOqkEWOQvUmCLFLM+i0jA/N64kcXjh4ZwY2kXDnakMihNAMvxHh2fA0+NgH3No0Kpt6TB6APgkyGmQYqA72c8NZqVwfPWUYkwwZqNZmYjEDggR0LdWLqBiCT64WenT0B70k6KxJrVF+NuHgIsiuYFtNodhvoRzAnvpig4JPOlDHPVohCF5ElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8812.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:480::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 23:40:12 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 23:40:12 +0000
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
Subject: [PATCH v6 0/4] perf sched latency: Refine outputs, unit scaling, and histogram support
Date: Sat,  1 Aug 2026 19:40:04 -0400
Message-ID: <20260801234008.176724-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:408:ec::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d80146-1017-4c15-ac80-08def0263aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|3023799007|6133799003|56012099006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	jC1mQhXGfFu/B0eVlXZ2ANS7cGeTEDcC4ftYipgoWEArnDotWplK2+iSbgmaJcWAGuGHuTxQfW5RzvZR6/WlZkBwVkwFr1AMbt0PvpDyC7eyc86I0E4MeNN2wLXE4DY7oAshQgDLC/SwZAfazReFiE7f50e3VdzX10F0QbP7fR/fh+Oyg9oAOsPetYBMf3VgZu+Rj98u/Ui2gcJ7gVXH9UbVrYpsqkUmdnenUHOeFIrtQVgNJ/Q1QioPM4o/cqoj7gFavLd0VHOiTAxdRVi+HrAVly6/Hp09ARDHI6Ew45OTYqSsOC09LyEFI7V3X5lCZypiGomR8BcyqqULpnBmiQwt7kmnTpxUojuVgR777xVYlGnFG6Xtjl5hhR9RtdiTrvacMbyfu0D4Q7b5K2JcolhO8nVTwvFxuBLXf06GNW6iyxgBYyBJ92McvyxaWA3hUsbpwnE4UBlJrz7Fk1Umvc9z3mfRoc0a5qI70MT7/+ZNvmyvSo5ZJlNNmSwqNmwofokyySN1bj/pFzXpv7uTC13gmNXzNeWbK00fpKpvqlgCgG1gzZok9YQG01QRoya8L50n4kzLYxf3n4M8wizSOvshsqyr5U61Ja0VOfmWnnCrcQ1b4w0HhhtJ4QPJEyz0cfDukga9jmzhSUTEcpyjhylsgWY0UbgrqrfZYgZopVc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(3023799007)(6133799003)(56012099006)(10067099003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cjgjP/9hPH2wuQyeTFdDXjvEKLbEtpcizNKcZxG5GrPQMCBt01ax3L2HAWIs?=
 =?us-ascii?Q?P2EZJkTG4MPrHJ34ay/m7cTqX6a/hchu7MvfglVJV7QbWWrNNdrVIBpuwfzn?=
 =?us-ascii?Q?53hg8iADKZNj9Om46Fx5eYW+WZtg+NfhRJE9/RsJfKdA+B+w07l3GbEjdRSD?=
 =?us-ascii?Q?Pdu23JBaYv2hbyvBhxSwkEFWcyhR8FOAc9vB0QQ8geZrbrXR2JXhgMEt4nvF?=
 =?us-ascii?Q?3MfQ9SB5+gjesF7yY6ZfEK8U/Ck70nuALLwUPyoo29fpDGWZ41ZtteY2T+q9?=
 =?us-ascii?Q?rxAHCXuFTwN0dB3PsjdiXQi4JcAs3kjYC7SAMmVRdjY3rcQ7hMWjfDiSGbA+?=
 =?us-ascii?Q?iRP6CSlLEXq9gqEPbFBprCia24h+bfIn6azaMR7RQBWQiaEeAdN8Oy8Ep8cL?=
 =?us-ascii?Q?ur4pRLYhexhnWVQ9IaCVrN3Fk0ZxREFF6xy8b1A0Z37cZstrVmoUVS00fRBr?=
 =?us-ascii?Q?lYSpKc18u4UHhvqYkzjD/YJWGHJX3wTxTkgo3vIx17ghrPR8FKHogvBaZKsj?=
 =?us-ascii?Q?cljPa0z1lGND9l0lEVeyp/PvWSffPGLgSgBOcWKIZ+j1VU7IvViVunjfrDbO?=
 =?us-ascii?Q?8tzFikDWlPw/tFpo6PIsONvnjtovJ2kTffruFuE/beOpKlnnWZrfnZ/qqmnN?=
 =?us-ascii?Q?xPfAy4idYUtvn4mgG/9NqwgHuiP++9oLTuRTgSF2OGd2opd5Zf47UMnFdRtp?=
 =?us-ascii?Q?y4BXTLSwH6U7pzI3fdisNfdGg86qEucJAR2ofgj0WHo5P8pQi72WErKBaBgU?=
 =?us-ascii?Q?kzrrFYVLM5rgay+o45Q33ipxntn+OjXQOJllZyshtGb0JmhGZUmZPafZbOV3?=
 =?us-ascii?Q?RsZ9fl8Kq53ORSbzAMTL90QmvwMIV+QiOhkWytjpqrCfAQLgSOXXIAheQsS0?=
 =?us-ascii?Q?KHFBgFAurSfP6qL8lAAg7308admzwH9oDjuYetLeD2HpYl0EkDoxa8nap6P8?=
 =?us-ascii?Q?Q74O3FEDFAwJQXDDUPRfcOJGc6Req3lyxzlB0BJi/bEcv+G0DV/716EBmihO?=
 =?us-ascii?Q?9f4IL3iDy4MOxwBspOOQJRbTXd4TxNSAbHkqrMTForv/PHUejWe8d4QJ4LK9?=
 =?us-ascii?Q?EFJxHAGkTX5haAs2a5EFN0qkNZ1lDLzlC1L0LZTepOcteFJexLnxojv+0Vnw?=
 =?us-ascii?Q?Yky0rdHy10zr+JAFhzzY8pkaRXQhtSwzo8qwyIMrP/jM7vBx2GXawzkkkLvy?=
 =?us-ascii?Q?My9XlZ43pAbS9ezs86MexB5UyrM6TczMTnVCsmuHCrjxfcpWHnLvHS8y8ABN?=
 =?us-ascii?Q?xQuy+Zrxgm20mBL5NYCrjSegvLR8ktlGGBb4n0ymTm9x91D6fdDS4UKhf1mr?=
 =?us-ascii?Q?7gNgfgQmgj9S/BTPsjkM2/B9Sw5aqtaDJZHYCCSOTPOe/I0idiy9jkYUNgDc?=
 =?us-ascii?Q?fIkd1RAxawihTQLrV6gSKERAECFLqwh3h3eE990IWHwq5Fb8bZS55HPBVwvV?=
 =?us-ascii?Q?vnm0Fw9TR6oZANLQu1VBppbawE2e9PqStdtibcRtqfUTVq3RvNSqaqe10Syf?=
 =?us-ascii?Q?nuibfmXzFsKamAJd5cEPnK3H0mo7qZP+p409ji4lp4n52BA8y+Y1VCkExmzA?=
 =?us-ascii?Q?j30etkTUk6P8Vq3CHbF94U4m4L14t6yHvPByiN563y0otR67xpJEAveuOUwk?=
 =?us-ascii?Q?PnYqcwMrKl1ug+VXQwvboDzld8SQHK7BmWVecC1SQtKE2qG5QS1jfqJLmCM1?=
 =?us-ascii?Q?6EXInl6FmM8XNjw1AVwykDuroZBjqyfBOljoO6bjmHVJjpXj3EUoTDvFDZ8/?=
 =?us-ascii?Q?hU9JXXa2CA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d80146-1017-4c15-ac80-08def0263aad
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 23:40:11.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMaeQhCVD7B0+06gtvOwKX6PUG08dcHiX7OapSnmOIwyRWDEGI7yTvtJ/XFgTqXryVXZcfXq6pkJHRwHzh4d+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8812

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
    - Missing callbacks (.attr, .tracing_data, .build_id, and .feature) are
      registered in cmd_sched() so header events are parsed correctly

    - The handlers array is promoted to file-scope (latency_handlers[]) and
      evlist__set_tracepoints_handlers() is invoked dynamically inside
      perf_sched__process_tracepoint_sample() when evsel->handler is NULL

    - Trace presence checks are performed post-processing when handling
      pipe data, while non-pipe files continue to abort early upfront

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
 tools/perf/builtin-sched.c              | 322 ++++++++++++++++++++----
 2 files changed, 286 insertions(+), 42 deletions(-)

-- 
2.55.0

