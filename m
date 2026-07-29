Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022078.outbound.protection.outlook.com [52.101.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392B47FB0A;
	Wed, 29 Jul 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336300; cv=fail; b=rCe2nyURCdpYzkpkwLlxc5w52ukmQ+vVyDI5x/P76OIH9nv6sTTckQbUS32hHX3VQjtiq0aDxTLkrrzSofvDNwRy7ftlphJhpx0Am5XBCOUZxpYKvKsgyB0BI0/6NdatgFs/2XPCFYlq80FkU1O3JCi/ZLfts9Y7FNcJySghlpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336300; c=relaxed/simple;
	bh=uR2ERUjs1EpiH4jJukknesIzN4dndrsLHeTnRrnPYqY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NWCJAUQXjEWKEg2UrvfK2lOqe/LQrlofzR4ebSuinlEUJKYI1eBl5uRaFeVboToSJKkGNN7/jsHXBaagZYy85h3g58+n5nj5MnZEcSdVm3zDzvcg4Q3k4tSBxKJ2OTBt4bflTCxzjwHphBmgllg5ccPa9gTKoIo3veY+m9buL38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmiS96LW4dgN1OdQYbNAArx2tCFaoMCb2DEEiXX76zCy7iDxTKAPe+Ws/GLowyanDTO+vXKO3e8BPYZo3oGkIVEO59D9tAmoTKaI4PkbnNCymhcgyMm8sE10vO7woLAn1tRYQupxRNK0ldzv5ez8aIWJhupaVgqePK7rxF7nBjI/hLrbh+VzkD+689u6bTGysP6kxIUx+lqIvulWL6WqfijpxAZPCCw4KR5sxjAYIFP7HCw2QC8bnMcdeq5vK3/exbkDJAI4Y0/SrvSC8hvtgGsj0y/ZdkcsKI+ZzuAcXYPcID2g9EVENXvWKDaAQLj2vsXdM5zgvXfYe5/BQy21Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=fhLGUQkVhjrXFwQmJJFhLxLAmqKGwinIb620J0slbSQ=;
 b=rhnWIdkfouPrz6bMTXx6JnNx7u7H14a1x9Ch9v7KjGA1l5oG54A0XTKoDTKK4kaac4Wox8yjyErNNG4b3+wbWAqwtqHvqYmEBRD3OMzZDuC745woFxkBBnV3A7J0+82mpFvwkPA7QaeUKnJuGK/PkWOrEgyzF/+/uFNyWiHfjPuJMikvxDO1zfiotYTq2j+9UqSN3uu75cvVi3CgI1rjDu7wx1uNf/Jd6aQny0A2BjRsXBcrHZ8126lH0UnN4MxIMcLEx/nigS592nMVfoFNgOj7XM3YpTSNMeYqU9DSnLoZ/ugRmtsRTGkw1pkaEuqZJwGsLxRuJWa9CetZklOijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8527.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:487::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 14:44:55 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 14:44:55 +0000
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
Subject: [PATCH v4 0/3] perf sched latency: Refine outputs, unit scaling, and histogram support
Date: Wed, 29 Jul 2026 10:44:48 -0400
Message-ID: <20260729144451.38286-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:32b::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 944287ce-196f-4a07-480f-08deed7ff446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|18002099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	e1hthbktUbeCCHqO5rMlJTc67AXUNvWeRWqHl7WVqaoi5GiV/fcRONQBpjMt6NVkoUPrnSznl49R0U3edYl9+OlnYxtEPiMcGVlTMHMUhp//22g1q3s+TD/MBFAGABFPB487AawZyIo3FvWB3DUlvDT8t7LWWUdCGWvYFK+o/XsJi8kYFNYLRTVeqdPyKjBdxfOBUquNoo2tpDRaNnKrdHonBgfp/L1G4z/lwvXqmPeLht3AY7l03cdZxVjFC/riq39AB2hZh7jcvbRFuP7gpjEPLCTtQxZMVO+S6p9hpvMJqkvgTCubh0I2ZqYEUydkCqKSWKBz1/VOLFncjKY+k9Xq9RvRD97maNPFHK9stxw7WH3ngnBuZzo4IrAQZUWmLhPthZjKOADL0QGpb0pWEhv/vhh2hnKgBMriFlnoaQvRA/ZamowtJo4sipkBKuxn87axZG4/hvP5iyxohf1qMVmPABfc2kWX2bOxJfaGpeCLTgSFDO1SI6dHPrr/tPVKu8CNtLCVMQG2OdOW9HKAMAUKSiPoUDdLWFcsbY6r2KDm6ExaQq2aGqTUgoHdJjt5Xi2lFImUziaq1RQ7WE6ecql3q4iRHsRtVr4VF6nsJHj2QpiZqbObMTg4dUE8P44zaw4kY1LteP21A6W59fB30J513ARjnzm4rEwctHRF5Cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iH50ZTv5NXDtrbf4yod+28yt3i0p5Ub8p54Ozi7G7vejc5b+yEC+1jlxAkxU?=
 =?us-ascii?Q?mT2pwcctPbeV1Ryvpn2Gty6UnGwd6nIgTe9xonELkbOcHM4jKRZWoYIHvtCX?=
 =?us-ascii?Q?kQ0GNJwcbTc2B91H1ETBPl2Vi2ZOKym8XUmPecW5qUXMCnyjUK+X65v4qV1z?=
 =?us-ascii?Q?ssOUpWBm7G56VNBvjBUp20c9U6Ww0poKo3aBW/ZgnaxW9swsJ559QN/S6Pru?=
 =?us-ascii?Q?ohCmIaFBSUkwUnwd8r/KnRxcUPLIBZUZ09nA6Nr0S+NYNYdfVGEvkhPLPf9L?=
 =?us-ascii?Q?2gfzJ82HtUdgH99wiTnXzLHYgc71JX0QQQ69ol/MYhlDctI/Ih1MLMYS3uh5?=
 =?us-ascii?Q?JZQzioY4qjBypNDOp1DOi4KnmuBM2qGNmXBNmViZFY/3qXs3E8fXYw8zWNgg?=
 =?us-ascii?Q?fBVxIAfpU5y9Q55y9AZFzob1nDl8PtxmuTpeMjwWfyRjKdIGbz0S1pR783ID?=
 =?us-ascii?Q?A5q/TINndVoaVdPT0zb1lIqpas7RMU+T15UpktTAEtfZBMzXQDwQeh54I2e6?=
 =?us-ascii?Q?hqqmZN05LEjMLDZKKMtS35a+ZDaGlI8v0ddzki0jhKkhhfCugb7dWrLQvYIL?=
 =?us-ascii?Q?f2P5Bu2AUGvuIG4UD9HOA+AiMLrAm3xGQOUhzxs6Zqr/R2CC73zWzVwPo3RN?=
 =?us-ascii?Q?Z1TcucGo/5F8jiWKuG3TCQOntKqLmcF+khc/Qa/zF3fKCCkhOseCyObJYhbh?=
 =?us-ascii?Q?EvDcGmYdpgMYYPql/YjQoiwTS2BQ1yU88natI2k9ZXzvkGdd7Rj7tjiENAYx?=
 =?us-ascii?Q?OgLX/8inOCSu3hiknHi5cefnSQLq9g7QHXWutLRMC7+SzxBwIzKpOHpzSrGd?=
 =?us-ascii?Q?E/AuQRjDFO7qUr+cHdhTivkH1qLrVMtgRyJkaFBT+TD4L32FGGT/5pVMQrGA?=
 =?us-ascii?Q?+DQfcrrJDF7Xz3USJMsDTbAEjLsVrnhW7ps27Rxl3ns7hBp2zwYLwDiugYp+?=
 =?us-ascii?Q?mYIWbOFKogi3NAGbFblXfx5Yb//q6LDLOQ+DI5uiRMBbygc6Aq/eTfm9aayx?=
 =?us-ascii?Q?OE4US8IOMr8xnm6lnaZA4rQmsrQ+8deHNb5mGtBvo4B7k/bhTm3fuQJfJw+Z?=
 =?us-ascii?Q?Q4k7niG81gUGT08VuqKGcY/shMk54YlaKrbvd1DGY+69lrKfbo3nus6yiBxW?=
 =?us-ascii?Q?1Yku2Ec6++7DjUCwKn6aRiEx9ZYXNfPSuZuAlzqn5yqLNzE8ve9VaUgAIqBR?=
 =?us-ascii?Q?0HfMXqSSP0xd5XOjiLo0al+ZtcfWA/mTQpyM70oQOzXe6feLOlMklu0UPtKH?=
 =?us-ascii?Q?5RZGqtT2s5yewcEaApphN2m+37IZDPM7iMIboPplEsHfFnYRM/KFFfAJJtgi?=
 =?us-ascii?Q?aypoinz49BlW01Cuz1eL39mRUrK+A7mTrbUKVJ1SBfniT4D8nSNjc/xo9yD6?=
 =?us-ascii?Q?Mce0cACkRx3ha2pYV8aKTE5By6ukwdb1CwMSDmiaL3DqLmPQ/9YhhNf8M6mZ?=
 =?us-ascii?Q?KUHHMNsPHQiFXA2Yc7LzMXwspPKg5sm7hYdgKkUWNWYPuiqEfqWyY3aQ+Bcg?=
 =?us-ascii?Q?m9CrGCMWUKc4J15oRSXapPROv1y4uX7WYRG4VGnkHZKLr6JIukQRH90+5pzX?=
 =?us-ascii?Q?3otoW2sJaNnDWot/1kYo3hkMYOmwUZxSghbBrDi2oP99CTkagp25euJoXBd0?=
 =?us-ascii?Q?gBnubkxuQiFij+tepOxk9Xpr8AfOxd3sL59E47sFETmMHfZxaGP0XLa03fMI?=
 =?us-ascii?Q?U8nvDFTAOgucCoySffum72k5jB4VykYtxgC+vtmAMiDPcD+HhqRocihk0Vtn?=
 =?us-ascii?Q?d3LQhjoZMg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944287ce-196f-4a07-480f-08deed7ff446
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 14:44:55.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDTATl0OPuhG9Sj/aOBdkvwolsbh5DXO/QPlngOpHP7fFPWx2PUX/ws8O4MTqd0k/dvLUGY1jboV3cairrM54g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8527

This patch series improves 'perf sched latency' by fixing misleading empty
table output, introducing dynamic unit auto-scaling for latency and runtime
statistics, and adding latency histogram visualisation along with time-span
filtering.

Patch 1 fixes an issue where 'perf sched latency' would fall through and
return success (0) when perf_session__has_traces() failed due to missing
tracepoint events in perf.data. This resulted in empty header tables and
zeroed summary statistics being printed. To support pipe mode
(i.e., 'perf sched latency -i -'), missing callbacks (i.e., .attr,
.tracing_data, .build_id) are registered in cmd_sched(), and trace checks
are performed post-processing when handling pipe streams. Additionally,
map_switch_event() is guarded against potential NULL pointer dereferences
under memory allocation failures.

Patch 2 introduces dynamic auto-scaling for latency and runtime display
columns (Runtime, Avg delay, Max delay). Previously, all values were
unconditionally formatted in milliseconds (ms), making microsecond or
second-scale latencies hard to read. Columns are now scaled dynamically to
the most appropriate unit (ns, us, ms, s), column headers are updated, and
format specifiers (%14s for Runtime, %11s for Avg/Max delay) are aligned
character-for-character with the table headers.

Patch 3 adds three new command-line options to 'perf sched latency':
    --histogram (-H):
            Displays an ASCII bar chart of CPU wait latencies between
            snapshots

    --hist-mode:
            Configures the bucketing scheme to either logarithmic (log) or
            100 us equal-width linear (linear) mode

    --time:
            Filters event processing to a specified [start,stop] time span

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

Aaron Tomlin (3):
  perf sched: Suppress latency table output when trace samples are
    missing
  perf sched latency: Auto-scale latency and runtime display units
  perf sched latency: Add histogram and time interval options

 tools/perf/Documentation/perf-sched.txt |   6 +
 tools/perf/builtin-sched.c              | 263 +++++++++++++++++++++---
 2 files changed, 244 insertions(+), 25 deletions(-)

-- 
2.55.0

