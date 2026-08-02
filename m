Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022120.outbound.protection.outlook.com [52.101.96.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC633F582;
	Sun,  2 Aug 2026 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704963; cv=fail; b=feNImyVG2izO/MvTCoQw+v64B0KFK/dihvhF/OXKlcvlbCA4AJ8hMsKrvz3NjxdDk8pp/sfyt1v9eprnKMn1PBTT2t11BDIJzrdWMi2m2IZE2k3FUMfccrKzQPi7uvuwg/1DO8Ajs2izZRLtWXLdjBQJgtD6WU2URzHMK2dbcuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704963; c=relaxed/simple;
	bh=YSJjgP6tvfZKPsTk8TCs0jHLTvvo8nfKaPQAAQOVP8s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MNABAV0xDAdYXYF+oM01dPCyGASZDQFR0Eg0ig/MjH7D7BJnTVfce2ZM+diVLewGdSLq7PR0Gj4dvrmFSgXVYBMLhcENovAjZlBo5Z7/GnQR7dXckeS+NWD8DZE4EdLodOAvjjTVrdEUFqgJKl2PzPF/tLCeO0vldTxcMpN97yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpGNN01O6Ya9j/NKKFjaRdcKAA4w7QxL4QhKq84eotqYM355ALHGTKboLTaD28xh7h+Br+IUlYvZEvARzqXZ0DGGHfrLGeIrNLRIPIqI0NbA3TrERieWu6l56wSuDkKKogB1OD6p+9i8adPJsYcvEYi/3qHthUkt0d24pNA9f02bWG9cDt5gV1x/l20HIcrYtPhkGHVHEFy5LU9eSq1HpU5DAyZZuKXilKZIZubpUCqNVN7P9Zu0PV/Bj+GdqDz9TDYmMzXdb0o74kWuitrlUnVD95pkjWY5zFk74sWYIr6iTmmW94Bj+Txnk7JE3QAEKsaaYvPJmFZhjk2RKRWysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=2xVRE03YndDYG/57NakflczCSX75YqbXcGvuVbg77uQ=;
 b=INoxP6t1VJFSJw8YIEE28GhgrOGohz5HcLo/e2SMPiyCyK1NTZNACXI36kzPkzeupo3Va7tgl11vn57TlN224tfBEv6Dd2HQUJBhbGyjJAfI+kxOEOXVsdR6mcnMnWRxs55TV41y0p6i78rGnj7QqCRiV+m22gWXamfu3ixc4sWeSk5j3xLUXO+91c+NNGgGt61IqpCd+nWsDYQmdOj1eWsmu37M6p9LDSvL9XTiafJjhj2Ix40m26yWgsCn6f7AbEze8M5kV1WFuEhB521wXxpcXBwRsIXmjo3sEIAP84aMkEWDBrmsZCsHtYwaoKXkYNdBGmlR5GiV44M0AWhcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB5940.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 21:09:17 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 21:09:17 +0000
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
Subject: [PATCH v7 0/4] perf sched latency: Refine outputs, unit scaling, and histogram support
Date: Sun,  2 Aug 2026 17:09:10 -0400
Message-ID: <20260802210914.199941-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0776.namprd03.prod.outlook.com
 (2603:10b6:408:13a::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e83a891-2e20-4181-2909-08def0da5027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|5023799004|56012099006|10067099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SydnjA9KtFNyKDwidNE0HLYDhiF6HsQB0WzrkwaXMOD90C2zg/iEK4ZiVgG4eE7oPvDfLWIyIZbvaJKfU7hOygLnH+F3G9Sl6HRqakyDY+dMvYi6diRq4nQ8yxIKDgSokoW97p+0mc5yWAIL23mrZ6xwlXFKxhpwVuGjXlbcWcy1L5WzGiA11fZ7ywHaNwQbjbZRYfhDrMoVM/FrdSL0ydLkpmKXC7Gzt+u+RSUYOLiUf6YaB9n18HbHYIr7OqTEwD1xJ2HfVO1hx8e4RBZIgDZ2Y9JlhZNRPr8YWmKykH1Qul6D7+BCztI19iJNRmVTNahyxn/va+TrxspWHc6Fw11a9ywBBwBA+FeH+WhMIA/NjfZXqhJn8XXn04oCGl91CZJNQjKFpgRiP4B9wBfp+Aa/4k3Ue6R4FPpYLrgulY0hKteqkt0LXgyLKDGezEj+nTFTcyvaQff9pOfGa2KfUYtJiIoaz21I8DtuZwU/ITdVH0dGPsspP/D1IZwOh+4fcifAm1JqgJXZke1OaS8GPRqEb14Qho7RyRC9S+wHyTu0w5D009QMYVXwrENq9dLE8/J0y4YluVSN6V7if0HjFeSE+Mk8yJZwXD0pTHnFWBMYqUUGtaZM8fINkjscTFJWjHlvEUIPYmwidIDPEi0IIgQ95cENnZZ8xZUUGzzmroY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hwhXpalJmhAR4UkKOCoATHhuV8Y9YshLjy70mgol6X+BzJ7U81m0bA0+fyTB?=
 =?us-ascii?Q?bZPbip+FwkBNKu4dDAj3CnBZIZALrr7tDI9zmlQm1E8z+C8tpCowl49HHnXR?=
 =?us-ascii?Q?GDCjyTUub3ZIzjtIsa9cQ7obypGuxPEr3vxKWcG5NwyJX+kxwxATuNjhoTWf?=
 =?us-ascii?Q?BeeZnPtFH8oAalOpalQeS9OzOkYi/cMVnNGKX/Sp6wsMVinllQ+4sbi6uieC?=
 =?us-ascii?Q?PTHcI2vbjBkONOzGNdgO1i1m+ya5HURJLZAh7r/iCwyhu8G7JFBDI7vi98S4?=
 =?us-ascii?Q?uik9GakV0YNN/KQOEVBUK8gb+8CevWVmpm2NHF1FBbee7vGJIY3hYVdpQ7jv?=
 =?us-ascii?Q?tVwtBhSXOWHZSqsDKv0btvovfiFOeYj7X369Kt+2xw8x3gk4DHwmyY8uiCRL?=
 =?us-ascii?Q?s1sDXCPcYK0quhWnJI7aybzM/AxY1lPzuYFypUftstLdpgS37j2Cd2OCwM7T?=
 =?us-ascii?Q?BFtq15i6NeL0dYF5unv8thqHDIpbm6FTStrP/Czw29+0ORjsxeb3jVlxiSQh?=
 =?us-ascii?Q?6Ar30HZ1XbesOoyWTDUXKFeJzJVpKGUVuLspH8vrP/TCkUyY7aQTTDHijy0y?=
 =?us-ascii?Q?+ol1wCEMdEhzXozmLYlY1usFT8WYkyUxXW7eeBebMmMmyO1fCEYM2LUlr64r?=
 =?us-ascii?Q?z0WXBZWLjOjszgfu3xYdwoZ7zQWKh6sFSQv3rccGkGO6bjq8zWE24ELJ1FU7?=
 =?us-ascii?Q?XtjVQFhsFLM11vmNMQf/Hef5b5xdU33Xx1JWDwCq+GUfKMeFQ1xVxd0E/qIv?=
 =?us-ascii?Q?bM/LLUQe+EmDA/UNdW9BV59/4u6WxkxnFQO93tlZJdlj4lOSEDfz2NwaaVZe?=
 =?us-ascii?Q?ZugxaksVpDQg9KZ0RubHuCI5RxtEFd286PVJ55+XHVvf1Nu1uWAJPHeuQ7Dy?=
 =?us-ascii?Q?fP+VkhTOCDhGjy36SuY60XzHECoMr8hs0428KyV+Xx78tK34CgotY61kCGFu?=
 =?us-ascii?Q?lNbTCE1zjHWjsd2k9GyOnE0Ni8McnTn81yQqOPrOm/y0qa2a9S93WUZwQiuD?=
 =?us-ascii?Q?lv0RphAGSiEoFa01v8F5jJ0vBOLUAxQZ9cuiz5eoqou3LtxFwN52G47FEj0U?=
 =?us-ascii?Q?5xaDHYTgsobknESPN0NV7midYCW4SSa7+7jdLf1F72UveWMDXS9zSc1PrKna?=
 =?us-ascii?Q?XiAGONtiQtMXc3IztUadb4i8XwdZ51+zLIVueBfYU7E7Hdwmi8arZvH/sAjx?=
 =?us-ascii?Q?cPok/WxnwhjejWddQ6rzzjxd1K/lUyDR3rDNIYo2CfFUTz0f2j5Vt05R9bje?=
 =?us-ascii?Q?Ebc4utTjb27Eu/QceWSbqR+OAzEolHqWkUY5w/tmz4GQ1MrRIhcWTdxH6Kut?=
 =?us-ascii?Q?Kro2GQkZTlXW7aFMweuFZAz4vuL0ecaotabac9UWDzErHR7TrO1p87hPMkKF?=
 =?us-ascii?Q?B1VIYv/Jb2ALfC3C8NrazRuu92nZ2Xf/s4tmMtV4XHQhhXkwJXn0qeIeftKB?=
 =?us-ascii?Q?W7sydIxs6xFU5V/JZgPXOhTMaaDmEecf5NxR9euTExSm4qG0nXQXclThu+vF?=
 =?us-ascii?Q?yxgfQgwNtZbcPP//yr/oRWZhge16AOoGpkRjLq4JPM1e+A8m9D4fHj1NTtTo?=
 =?us-ascii?Q?3vYT1gJ9+bsF+M1oeEl3fmkVNCBAN7Fxjb5BXat9PljpN40kD/JhnWbgouBT?=
 =?us-ascii?Q?Afc3OPESgKu5PGWRJ1kUVhKfzBHJeEppkoAlCYnzDlwp2JW+OacmdOPtDQcq?=
 =?us-ascii?Q?ie82ElrX3xjufIt+LwaAd4FeatyrUlwAMXXnR3xJJwfD6Oq55UTDMg1wQzVS?=
 =?us-ascii?Q?042GpqU6jQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e83a891-2e20-4181-2909-08def0da5027
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 21:09:17.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqcL/YkYpdyr4nBQuNR9eNGqMd5QwBC6yTY8Ql0qk6l9DsMj31J99ApE3sFCAEqAVpYL+orT6Jv7shf+6J4FNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5940

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
 tools/perf/builtin-sched.c              | 338 +++++++++++++++++++++---
 2 files changed, 301 insertions(+), 43 deletions(-)

-- 
2.55.0

