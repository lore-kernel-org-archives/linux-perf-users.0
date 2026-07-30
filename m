Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020107.outbound.protection.outlook.com [52.101.196.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB2A3A4267;
	Thu, 30 Jul 2026 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437667; cv=fail; b=WOOinKOJhc2QuUH4wWMHXE2byQHU0BSHI/lSai9+yewGHCTeB90CdR4YeIhxnnQE3B/V204fo6xstW5ROUZuRW/2OxZgPpDkcxt3fFVU7SUFfdzY26CGCHFKwcmqV6RUekoauvKk/pjiyXXY148zd98p5A858HfgBolFFTfmRxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437667; c=relaxed/simple;
	bh=5TwGa6I95xiCr0x6LvsFlJ0B+hShcpvVJMYGN+eifBI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oUkzPLkynjITS5kyy1EMgPYBhtH4hc/NfZXkKj1KYVpDVN21REtjeaEqm3LB+Rcw6IkImNZLmsAeb/wPIIXpi3//I9F7vvpczN3M75pRUOpZKOiG4EV40zP3dHp4S+fO3qiOV0t/40J4okmZ4nUYyACc1/AkgjD6DtKJSllUMbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sotBtdXQFBfsmpwmUYqEbPbao/reryc9qmLECgoflIEYj8OCc+jYe+zIcjovGDGpaeNyCV0vNiv8VLrcEi2nLFWiAcNHOMkD3P4N0wvW/G2eu6/gzYxm6J+tYahodALtXO5oFPGKPwQ0l+hGRSC/du1hvVqRiKv0GwYeoNgrnf3JqwnfSysYevOhIFuVRDR8c0a4WEcecFtDzssZ2JebbByTyP746Brjj1deocWf6GYFaashWKB9WIArahp38qnimr/fvoq7/4oFZNzaKOESbYUD/cR4il2FjRuXpYi+OtAvAJRIVS8ElHBWxlKNqT38LHP2eu+s9O747Ft4FeC5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=5QI33MUsjhDAzA06MlDw1pYSZGXBjUlibOC3j/Eh3s8=;
 b=PV+m7DMIxGPV5fWhCKEBMaogkSTaIgdMaeesu+z7ObDxZMyiJw7hy5vlvfHpVxKQVfdt+msBdsrhROaOJXp3Lp/2I8oOAqg3gg0TVH4MvnrC4RCrQBgi/W2SOdpgjy5+eFFbpQHYeEAGGjhmCpmHxB1CwH6SZqyTs+zgWNEhN0SshyeR6eM46xDYNPDVv+A/DSpJbJpvIvsEEAKRvpl57Fp+z9xBiJWItIr0+BI9sv3oh/FZoVzDSgvyX6Uzuu1mm0bLEHBrF4x3e9DRLWP1eHXVU7aYslCsiwC1Rvr5lfM7yk/vuigOmVfUbSQ14iRKTI2nhoR3LTytikmJyMED8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3654.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:54:21 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 18:54:21 +0000
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
Subject: [PATCH v5 0/3] perf sched latency: Refine outputs, unit scaling, and histogram support
Date: Thu, 30 Jul 2026 14:54:13 -0400
Message-ID: <20260730185416.97166-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3654:EE_
X-MS-Office365-Filtering-Correlation-Id: 94921dbf-eff3-4853-9203-08deee6bf700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|3023799007|5023799004|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y8844rZCwFsvWka/b5c/d1rNhEeOZeR+Q7hivFHJ3j6w6GGpCU3gOlPA7vhUTBEnCABkWeyHWTi4FcKGq4kQNdTVq27YUqABTOnD+CoPJEdxM4F+cRwqrYX1bDsgpchEWjl1khkzkgey8fwPbI8vcejHfhBAmSeZBfqeomedNSqDU8eUZYDbskTZrusa4hQcil3c9QOmOQE9cRSpsXZztU/HO01RuymoZzPJvZDpRdZwBny0UydNSPmBmyNlOGAeU+N9k2Fyhnraw1vn7WtXolGOuCX3Sax9BjwoexAJLMORgqYx5XV4oF//FlfnTij0c/Vd1kAvQPWtr8LxkohDSK0ApL4jgThdR2bGRkm21q3VnOddek/2J0VNqnviX31qteGps1K0AC+DKAMuUvMNc/aQp5+yR2hOAkq9xfIhyoKXl4wXPHy9+YO2Ee9P5Zyn9KWPXklvontPDAM1Duk8w6g/fsB+ABM3ZNlYAOp+rw68ZQpwJiU6sZYQ6uKK9J8V14MVr+MVscu2y/MLYXvMzbSNZ0Y71w+riN03fX3AADvBZJtf3Vh1MR99N2CQNVF28HPXNflTGESO6GCFFiwWDuRLS2N+sNo0Ko6VmNwVBYqGKHAPAOUw+R2n2EDVSKcjdaBDqy6wxDDBU5aDTDuUmhkM9Gv9fh7bkFaFOyDZGHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(3023799007)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?plwna4quMCEhZJs1X2SVQAgLZY1Up5ozhDXuX1PxyMwZgRXhxu9IszHprZ4C?=
 =?us-ascii?Q?LcmxboVKmVbcmzLbnpAkw47szVFhDgZyTYOjy0YDKGGzr/ZJZzCwnoF8iwF3?=
 =?us-ascii?Q?CpKwav8rQfVSC8G2BYYqBDygSxnsFH/H+/+HafaLTdydY9g3wXH4UMAnZfZ4?=
 =?us-ascii?Q?4CkiNZL1Au2HKz9GYTa8CvusZfdkDRJX2IHonyidwoJzp61shCujCRzLZtB6?=
 =?us-ascii?Q?NNyaJWbteGBGRETBj3TnVFOVKlrx3/AL/6YMF9DGIyoNzsol5ADmXLu5WAOi?=
 =?us-ascii?Q?K2IOzCNDENGD60UgZFMBr1/rmE4e0ziemsAFnDLuii/uQnc6aVqGakegWllX?=
 =?us-ascii?Q?dG4yD3mTKyE3KnbXP4jb3vjxdbhgDWXs1o3FZ59arbqAsOfMVxtd6uU0ZjaA?=
 =?us-ascii?Q?boTXrdUv91c2iCZu3NijWedDMQ7Mfa7UHndZmrjynAvAk3iRhjFOUAMWufiE?=
 =?us-ascii?Q?1YMD9B2wV77fMokMydbWVVz2jiS+oppLdIlSq3sHl8oRJUuzlve6q+laewmU?=
 =?us-ascii?Q?jRTp/Rwavl3so1qgacpZcj3CkxKbzNhuj4MK1XhrquiIUSWnV2ka5BHq4lr2?=
 =?us-ascii?Q?kWeK9zZtmo/lWH0Bwp9bz3lk+ZBnBf5qge6sV4KkyQI001qW/kRPgJUm63Sw?=
 =?us-ascii?Q?F0LV6AByXFSK7Us2VCsixRg8wUJIg50ecbcK69mqRS759XRIKGehQbQENF2N?=
 =?us-ascii?Q?6qxIksWzqzU7XR+j9mWHK8Z1cYRedr2YwC4mVp/bCl8NyTk6NUc7tZ0muzzy?=
 =?us-ascii?Q?zVSyOmPUhEWsEmpfQ328tiaEvyXzNsq6u/8j4mJCq8NpSkC6y/HJcMrjGHKJ?=
 =?us-ascii?Q?Pk4EPsF7VD6FBOXB4zSF9vPVFUKxFw0Xq0OY2nDmff2Dlu/QaWuM3OOODfzQ?=
 =?us-ascii?Q?WNU2XzVKEjrm5N0zD5C+QrATQfJcnt6f++OhhLkwGurGYR3gulxrKu/XOewV?=
 =?us-ascii?Q?XfCmRiTuPDeavP7v0nzrNy2wlLcQ6BszTSHaUvjHWbjv5bzj/joXsZ+YcfDA?=
 =?us-ascii?Q?LO8fKROZYOk+FyZsvCsGBUNe4JfPROuPdyUmCwonjvX5+VqyvxgKWnc6PRCR?=
 =?us-ascii?Q?GeZGwHUTVXjDLiOLsNP1uMwivce2YFgzG3CVmERotZTTVDsgexXhEG5WvqVE?=
 =?us-ascii?Q?TSIjxWo551XjkkbITbhgA2KFMLkVjsqan8TwPJ4S4NbwD/7p8yfsp34MXnka?=
 =?us-ascii?Q?JpfZqnNoVJyAIuX27b88fj+8MYv0CK5TgX6Uy898dE8ixAngR8dxNG2ayEtI?=
 =?us-ascii?Q?Yc5O4NgYu8vq/vSQHHYlQzzpOlf/YySiQ9B0jwu4PvLo/YtHz5AAzrk4sG1G?=
 =?us-ascii?Q?ZftKMxTxjuAYL1cHvjeA4bTi+XFEmf9g7Krtg2MNURterCGaIKhCcDhurWS0?=
 =?us-ascii?Q?iJis1zyc172962s240ilWv2LWh5W2JXGUQDsVOpPVYOo15/TxN+TyYYrOwSu?=
 =?us-ascii?Q?4h3uAgfK98tm6et7aY1l2MLr8Pz9Xd7RY8xby6dKkRFof+5wSBNsyHjeTxcr?=
 =?us-ascii?Q?5V19AbjoHvf9ciVUliImNiPvt7THnOukCDIYn2ZDU8LfKxyd24qjGgtVK4I/?=
 =?us-ascii?Q?bPZ0YgTpmxdISaibtsyd/4u6MadhAROsMw4EvacM9OgYJ+TEQq67Gd4uWYNT?=
 =?us-ascii?Q?26jBVqJuUi9LoOdR8UKpKOIvOUw5ecltQbTNX5QnKJ2rg+W65BNcWgIwRfeu?=
 =?us-ascii?Q?f+HA4fpWl6JMwfdBNR0+lwrpGi1+uSeub0zK/9Wn1jcu+MxtEu7IgC77ChlQ?=
 =?us-ascii?Q?Pz3SGpAE5Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94921dbf-eff3-4853-9203-08deee6bf700
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 18:54:20.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vt9ilX3eX8hXKRwJb8xZafMdajw4ExTpx7ek/Q0Ne0yvFqgiQPqaSq7ywKIcbOGKegUvjZYK0BzuRIsc1lbpjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3654

This patch series improves 'perf sched latency' by fixing misleading empty
table output, introducing dynamic unit auto-scaling for latency and runtime
statistics, and adding latency histogram visualisation along with time-span
filtering.

Patch 1 fixes an issue where 'perf sched latency' would fall through and
return success (0) when perf_session__has_traces() failed due to missing
tracepoint events in perf.data. This resulted in empty header tables and
zeroed summary statistics being printed.
To support pipe mode streams:
    - Missing callbacks (.attr, .tracing_data, .build_id, and .feature) are
      registered in cmd_sched() so pipe header events are properly parsed

    - The handlers array is promoted to file-scope latency_handlers[] and
      evlist__set_tracepoints_handlers() is invoked dynamically inside
      perf_sched__process_tracepoint_sample() when evsel->handler is NULL

    - Trace presence checks are performed post-processing when handling
      pipe data, while non-pipe files continue to abort early upfront.
      Additionally, map_switch_event() is guarded against potential NULL
      pointer dereferences under memory allocation failures

Patch 2 introduces dynamic auto-scaling for latency and runtime display
columns (Runtime, Avg delay, Max delay). Previously, all values were
unconditionally formatted in milliseconds (ms), making microsecond or
second-scale latencies hard to read. Columns are now scaled dynamically to
the most appropriate unit (ns, us, ms, s), column headers are updated, and
format specifiers are aligned character-for-character with the table
headers.

Patch 3 adds three new command-line options to 'perf sched latency':
    --histogram (-H):
            Displays an ASCII bar chart of CPU wait latencies between
            snapshots
    --hist-mode:
            Configures the bucketing scheme to either logarithmic (log) or
            100 us equal-width linear (linear) mode
    --time:
            Filters event processing to a specified [start,stop] time span

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

Aaron Tomlin (3):
  perf sched: Suppress latency table output when trace samples are
    missing
  perf sched latency: Auto-scale latency and runtime display units
  perf sched latency: Add histogram and time interval options

 tools/perf/Documentation/perf-sched.txt |   6 +
 tools/perf/builtin-sched.c              | 318 +++++++++++++++++++++---
 2 files changed, 284 insertions(+), 40 deletions(-)

-- 
2.55.0

