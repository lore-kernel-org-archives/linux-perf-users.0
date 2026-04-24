Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4327453;
	Fri, 24 Apr 2026 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777066183; cv=fail; b=njGEqWXMX0HS5uVU958ZkFeWErpDMG1/ah7zMzbcZYf5MfXJralQTDMZC5Xmsh1T8uNu0YW+qStBaOHMa1Ou7aA82UoU0rVDZ3LzTgOB5xEdSMDTkM4Q0KojaIY1/w1zn2sJh/VnZDhkdanHhWAl3hn58dWgy8B2yXUhdwqyiik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777066183; c=relaxed/simple;
	bh=377qNWaWQhmQdbfgUn9avJNy3nWMqg+gdtz/p0KvfVA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dFa9YbpWwjnZBOOlXUHQJPswjc3EeqJqtJjMyzFjPwvj/zvG8j9sCr/QnZaW2NYyI/owCEl/EbIV/GZIEY2H6uizI30iJ48Kj5Z39zpT1Z4rD7FQr0gb1nQhrZXuSHOwjcqbAW9LwHpLoMZ0Ozyq0IT/eD2KBYyIs3Z86MnItbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajF5fbJk3zqLk1iZ+qUH9aJf33xZDnFHkY/HeIAFZno7Y6g1YTHPACnQL7aC7NmaoRFmkZtYrmL3kWZxweKsXk6wqn/DCb64ugK4Ny1KuOFbQXMAxLmMEQOwZ4kXD8L3dsb9Q35T8Mie0Usxo4wJxZM+bRjcNiqUDboJZseMC8r9RmfS+qz8G0/+Vgs0+1Zn1zFbv05gXUjF98PZuJ1TWHKR1jP6dkamYfgUO52B1L9xfvBf8f5DzFjSUPEFe0Q77lxTGpjGI1IRF0wkXuXEtFRuR022UAT6CXG8+otede3BHpDaAbgm/PgiDekni3oHFBcOJNSnSiaZLnDDbxe4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rp3+2Z4CQRoxgPGkHmAHPS5wCqEwId0xqRuVj6IvfI=;
 b=ntkAe1zSbVyenBV9q8zEW/rseHjRIQjIQmnVj75WscvUDlU1hbq6ZciWf65wUM+vZDERi5K0rj6FNcW6bpeWhfTMGdu5mO/hrKS/iIADx2rY2vIe35WLTrjKG9bUL3oHC+9gWZfa43xlWEt+L5SIpXii8uRcOFZsoTWvbVFJWJiSoBkQus4ZO/GRqW9FCO+dpqEfQj3GDj22xJ7dv6+XKYUcNwo/gdiDKKkJoUezdyVs2JUrppp+DQkb3w7xNdSGXhALSqCu0ivqVElPT+T33zhoWjSplOcncclgL9IZ1+39W4fSTabAP2h1/TmmAGMdAb31gIhukUXlScIdMSTSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6366.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:28a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 21:29:38 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 21:29:38 +0000
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
	sean@ashe.io,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] perf trace: Introduce --show-cpu option to display cpu id
Date: Fri, 24 Apr 2026 17:29:33 -0400
Message-ID: <20260424212933.151154-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:208:19b::45) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe241c7-c2fe-4e1d-7252-08dea248966f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	G8gIphbramkmnkcYAhz8E/HXEC/8KljvZ102tLND/kp4yWifp3ammRPl5ueNUyQZKt81o4519nHawNsBUqLMAbEEW6EULXspe421JjiQDIshRzl3pef5kJ/pIAM0DZygqrErDIs5wyKFOWxyYzqIiSJjtC5cuwrsY5PhkvthPMivcK2j3QTM3fAjD3muwiiO5tDiX0+riEG/kZfYfhJ3M/kU3go/prJmolX+pRtb6S5HK9EYiL55EQxGRLVkyFon+F3z8D0Oph8/+t0bdcRkxQOF8iObdLeORdsDZNZ5rHxjQInzi3QROSzMzJnRxdkk5mBkJXa3GF3l0rkhhOc5rNI53Mj6ocdiaJXvMooziH9PHK/rNCtLDRUzmzYxEpKMwJb5nBiIZxQ9TmgbDiqQE9KAMaeE9u6KRSXXI8GVY9xKaHUm9QgY682hD6ImuMh9F5cW//jUXke/TnF0Q4xAmRkrSah/rQSAQCfpzh2C/qZxeH2W2VDZUy1fLbHBkU9y/RqhJzqwd70QCLTLk+mVIYQoLNakmyeH+V68LuUOXm8dmndjKQgzXNKs2/xBgH1NgYZEonDV2yZsyKo3ycU1PmwgGcrZf2v9j0dYmo2wmq1SQtuxIodjY4Og3U3r0ONmjRAMrXfyMsu41VfLuWnDg+Z/RV5nifNDQFOCAq9pOLZLzkNDAc5mXVpTZY6HABafpGGEy0TW0yGv7XwKRUn0uW5nlwzzAhODEmMXNDolCMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eq01Ic/vfnVJITPnKwE4l1KjFBYJVI8k2Fd7LBV8iOCKnVxESYNiODXZcKLs?=
 =?us-ascii?Q?9J/v4SgJUmlAKRaTfxbCyl1hNyHf58/ESMdr5KIm/w8v3mm3eqkvDqsTZCdY?=
 =?us-ascii?Q?t7m00GFCj49n8unUkOHJDv5V5N7oA06pWLvPh9UXb/tm+wS9u8aSud8LdIxw?=
 =?us-ascii?Q?jMHsolY6y9+DSqejJe9UFAFDBtLEWFG6AS92250c+VyhdImF+9ZlAdoJp5qn?=
 =?us-ascii?Q?nDHgNpwp7RRnYc5XnUc30CWg7F/6uUlTrmfkgGS2eh5s0qEnVmUzDShkEOCs?=
 =?us-ascii?Q?zGownzk7FsvRXcMLJ8XeJAM//8Xtsenj2osi+7WdO291fjcnLmEVv3k2H/h5?=
 =?us-ascii?Q?I4ohD3mLT5mdI+y01qGYGfAaC8nQclpOR+wlL8Nd70/MT+KB0GrjWC5PnuzA?=
 =?us-ascii?Q?VCFtphVp8rhf7qiLIB/dPbxyx4hX0jZcffMSw1BLlqtmcjiBxSj0QdZbD35y?=
 =?us-ascii?Q?fuljdjaobFVT8tOehno1BqcJ+HLkhJF8LVYTO6m5MQkB1IezPR2KkdlwRukL?=
 =?us-ascii?Q?TDLotqFjG3gwV9WNKaCafWBMvhJ5boByVKSOESG4jHSjjmyz+3eRBK9BwWXp?=
 =?us-ascii?Q?HdjqdVRL/yi6mfXaFx0XlO+yxgGc0ARbBKvZapLGPJyF64/2Eu/7bf7dTNJ2?=
 =?us-ascii?Q?XybW+uh605baCJAkF+961VvI96Zmbv1oe3SrY3MMnTRjQnYdO8jY+piFkVn/?=
 =?us-ascii?Q?EgtKrim36SdL6XQoC0lILB0D/ULK0+FBP5wdclsQyG95KTXkTJK/hSH6NFdO?=
 =?us-ascii?Q?Z94G3CYsaLHRerMY8OsqWa9mtTSfGdf2kNKrJyanQekRZ+93B0gR5pLc/PFh?=
 =?us-ascii?Q?bms3LDMndiVuBzIvuCA2ace8Fef6Uh5F/I+qzxxMCb23tYE8nSf/j0zLFr/7?=
 =?us-ascii?Q?Qqi1uc0jSb9E3U3EKStqE5FO30AW4TuOAvSt8PB7RYDejcV4bBqpete53KxA?=
 =?us-ascii?Q?+jGf39CYzow1NboqIHt9RJkFVwk1PziIjbOBbPhb3LzRZ25NyFzkAPxchtcl?=
 =?us-ascii?Q?L5n5+Gfug6pIksSz/mA3H0gW2p/cTw4b5q0tx5FNrlLZEPutdHL8sxEalRM0?=
 =?us-ascii?Q?afZM986OdaMAwLWSt/LBXB2yasdlJ0xiynE5z7lVTmYK39tkUSwZKXBVIlSp?=
 =?us-ascii?Q?YMfe4yB8QBQD7pK03lN9lMFkrHoeDHXza45WWcoPhBZ9GbszTvrRrDDrKOhi?=
 =?us-ascii?Q?TA4TgasABrt8O4ij+nMKRK+RxaIg+S6nBPsYG0xFgyy43WDEU1MizLoRGtmq?=
 =?us-ascii?Q?X2d4lLNrnTDBXWvb58OtaI5GVO8yXcon6kd18EIzfOF06qY4hLXe+CPRiSd2?=
 =?us-ascii?Q?EgfAwiCNd0YItNEsa8goFAOMotTFLr82CNEopA35xMWSlfbzEpJQLaYZFufV?=
 =?us-ascii?Q?CQi54WxPGHxFLZkZGNOqwn7YaA542RmXehLpkQUxuoO+BzdNiIpJ2LxDgKRP?=
 =?us-ascii?Q?RyyRZjaMlmpQH9ZTHYWX4Q1bl5Ou3ckPluoOQCamBFlIp0fUrTkHV24XbToi?=
 =?us-ascii?Q?tVpw1yJ+zxYQ4tfkT4xbNbPruwSpCmpd6blieRLEacevBAD7MVHxSb4m0s54?=
 =?us-ascii?Q?rUMPqnFwPXSwaCm+o74wTmQ03BhxU6b5X4mkM5sx71YlSwld2Gmuys0TdXq7?=
 =?us-ascii?Q?5m9JhgGWzrOUSkflocr8jtsaRGpBfg6aBxcz/rDSMNl9T2cY6xsJti6YpSfT?=
 =?us-ascii?Q?AfrIWEoEnAXXQkLpSQ/pIk5rrfq8IiRaJCSnDE1ugxJ3NnfieA+Mb5Dwory1?=
 =?us-ascii?Q?Tm0gn2XLeg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe241c7-c2fe-4e1d-7252-08dea248966f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 21:29:38.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsZ1OhB/XADtPe9MiE0RXZxavdgM36Lbmek7eTjp7vXwQShhhHKjz5iAoqYqMZyKn0xnDDwFi1B0YDNCK9jjKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6366

When tracing system-wide workloads or specific events, it is highly
valuable to know exactly which CPU executed a specific event. Currently,
perf trace output defaults to omitting CPU information.

Introduce a new "--show-cpu" command-line option. When provided, this
flag extracts the CPU from the perf sample and prints it in a "[000]"
format immediately following the timestamp. This mirrors the behaviour of
other tracing tools like ftrace and perf script. For example:

  # perf trace -e sched:sched_switch --max-events 5 --show-cpu
       0.000 [002] :0/0 sched:sched_switch(prev_comm: "swapper/2", prev_prio: 120, next_comm: "rcu_preempt", next_pid: 16 (rcu_preempt), next_prio: 120)
       0.009 [002] rcu_preempt/16 sched:sched_switch(prev_comm: "rcu_preempt", prev_pid: 16 (rcu_preempt), prev_prio: 120, prev_state: 128, next_comm: "swapper/2", next_prio: 120)
       0.033 [002] :0/0 sched:sched_switch(prev_comm: "swapper/2", prev_prio: 120, next_comm: "kworker/u32:48", next_pid: 35840 (kworker/u32:48-), next_prio: 120)
       0.041 [002] kworker/u32:48/35840 sched:sched_switch(prev_comm: "kworker/u32:48", prev_pid: 35840 (kworker/u32:48-), prev_prio: 120, prev_state: 128, next_comm: "swapper/2", next_prio: 120)
       0.045 [002] :0/0 sched:sched_switch(prev_comm: "swapper/2", prev_prio: 120, next_comm: "kworker/u32:48", next_pid: 35840 (kworker/u32:48-), next_prio: 120)

The feature is implemented strictly as an opt-in toggle to prevent
cluttering the standard output and to preserve backwards compatibility
for scripts parsing the default output format.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v3 [1]:
 - Extended struct thread_trace to track the entry_cpu. This resolves
   a visual alignment bug and prevents the loss of CPU information when
   printing pending/interrupted system call entries

Changes since v2 [2]:
 - Fixed a tautological check in trace__fprintf_cpu(). It now correctly
   guards against missing CPU data by checking against (u32)-1

 - Corrected the format specifier in trace__fprintf_cpu()

 - Replaced the hardcoded CPU ID of 0 with (u32)-1 in
   trace__printf_interrupted_entry() to prevent false CPU attribution

 - Refactored trace__event_handler() to utilise the trace__fprintf_cpu()
   helper, removing duplicated formatting logic

Changes since v1 [3]:
 - Fixed a silent failure where core trace events (e.g., system calls and
   page faults) ignored the --show-cpu flag. All primary workload events
   correctly display the CPU ID when required

 - Updated all core event handlers (i.e., trace__sys_enter,
   trace__sys_exit, trace__pgfault and trace__printf_interrupted_entry)
   to extract sample->cpu and pass it down into the entry head
   formatter

 - Abstracted the CPU formatting logic into a dedicated, documented helper
   function trace__fprintf_cpu()

 - Added a safety guard to verify the CPU data is actually present
   (cpu != (u32)-1) before attempting to print it, preventing dummy
   values from polluting the output when sample data is missing

[1]: https://lore.kernel.org/linux-perf-users/20260423194032.134416-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/linux-perf-users/20260423192445.131351-1-atomlin@atomlin.com/
[3]: https://lore.kernel.org/linux-perf-users/20260421203934.64032-1-atomlin@atomlin.com/
---
 tools/perf/Documentation/perf-trace.txt |  3 ++
 tools/perf/builtin-trace.c              | 51 ++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 892c82a9bf40..d0b6c771a1b9 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -199,6 +199,9 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 --show-on-off-events::
 	Show the --switch-on/off events too.
 
+--show-cpu::
+	Show cpu id.
+
 --max-stack::
         Set the stack depth limit when parsing the callchain, anything
         beyond the specified depth will be ignored. Note that at this point
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e58c49d047a2..e9cc870a5acd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -217,6 +217,7 @@ struct trace {
 	bool			kernel_syscallchains;
 	s16			args_alignment;
 	bool			show_tstamp;
+	bool			show_cpu;
 	bool			show_duration;
 	bool			show_zeros;
 	bool			show_arg_names;
@@ -1531,6 +1532,7 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
  */
 struct thread_trace {
 	u64		  entry_time;
+	u32		  entry_cpu;
 	bool		  entry_pending;
 	unsigned long	  nr_events;
 	unsigned long	  pfmaj, pfmin;
@@ -1893,6 +1895,27 @@ static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
 	return fprintf(fp, "         ? ");
 }
 
+/**
+ * trace__fprintf_cpu - Print the CPU ID to a given file stream
+ * @cpu: The CPU ID to print
+ * @fp: The file stream to write to
+ *
+ * Formats and prints the specified CPU ID enclosed in brackets
+ * (e.g., "[003] ") to the provided file pointer. It is used to
+ * align and display the CPU ID consistently within the trace output.
+ *
+ * Return: The number of characters printed.
+ */
+static size_t trace__fprintf_cpu(u32 cpu, FILE *fp)
+{
+	size_t printed = 0;
+
+	if (cpu != (u32)-1)
+		printed += fprintf(fp, "[%03u] ", cpu);
+
+	return printed;
+}
+
 static pid_t workload_pid = -1;
 static volatile sig_atomic_t done = false;
 static volatile sig_atomic_t interrupted = false;
@@ -1923,12 +1946,15 @@ static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread
 }
 
 static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thread,
-					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
+					u64 duration, bool duration_calculated,
+					u64 tstamp, u32 cpu, FILE *fp)
 {
 	size_t printed = 0;
 
 	if (trace->show_tstamp)
 		printed = trace__fprintf_tstamp(trace, tstamp, fp);
+	if (trace->show_cpu && cpu != (u32)-1)
+		printed += trace__fprintf_cpu(cpu, fp);
 	if (trace->show_duration)
 		printed += fprintf_duration(duration, duration_calculated, fp);
 	return printed + trace__fprintf_comm_tid(trace, thread, fp);
@@ -2707,7 +2733,9 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	if (!ttrace->entry_pending)
 		return 0;
 
-	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
+	printed = trace__fprintf_entry_head(trace, trace->current, 0, false,
+					    ttrace->entry_time, ttrace->entry_cpu,
+					    trace->output);
 	printed += len = fprintf(trace->output, "%s)", ttrace->entry_str);
 
 	if (len < trace->args_alignment - 4)
@@ -2825,6 +2853,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	if (evsel != trace->syscalls.events.sys_enter)
 		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
 	ttrace->entry_time = sample->time;
+	ttrace->entry_cpu = sample->cpu;
 	msg = ttrace->entry_str;
 	printed += scnprintf(msg + printed, trace__entry_str_size - printed, "%s(", sc->name);
 
@@ -2835,7 +2864,9 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
 			int alignment = 0;
 
-			trace__fprintf_entry_head(trace, thread, 0, false, ttrace->entry_time, trace->output);
+			trace__fprintf_entry_head(trace, thread, 0, false,
+						  ttrace->entry_time,
+						  sample->cpu, trace->output);
 			printed = fprintf(trace->output, "%s)", ttrace->entry_str);
 			if (trace->args_alignment > printed)
 				alignment = trace->args_alignment - printed;
@@ -2980,7 +3011,9 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (trace->summary_only || (ret >= 0 && trace->failure_only))
 		goto out;
 
-	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
+	trace__fprintf_entry_head(trace, thread, duration,
+				  duration_calculated, ttrace->entry_time,
+				  sample->cpu, trace->output);
 
 	if (ttrace->entry_pending) {
 		printed = fprintf(trace->output, "%s", ttrace->entry_str);
@@ -3280,6 +3313,9 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	trace__printf_interrupted_entry(trace);
 	trace__fprintf_tstamp(trace, sample->time, trace->output);
 
+	if (trace->show_cpu)
+		trace__fprintf_cpu(sample->cpu, trace->output);
+
 	if (trace->trace_syscalls && trace->show_duration)
 		fprintf(trace->output, "(         ): ");
 
@@ -3405,7 +3441,8 @@ static int trace__pgfault(struct trace *trace,
 
 	thread__find_symbol(thread, sample->cpumode, sample->ip, &al);
 
-	trace__fprintf_entry_head(trace, thread, 0, true, sample->time, trace->output);
+	trace__fprintf_entry_head(trace, thread, 0, true, sample->time,
+				  sample->cpu, trace->output);
 
 	fprintf(trace->output, "%sfault [",
 		evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
@@ -5432,6 +5469,7 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK('m', "mmap-pages", &trace.opts.mmap_pages, "pages",
 		     "number of mmap data pages", evlist__parse_mmap_pages),
 	OPT_STRING('u', "uid", &trace.uid_str, "user", "user to profile"),
+	OPT_BOOLEAN(0, "show-cpu", &trace.show_cpu, "show cpu id"),
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
@@ -5566,6 +5604,9 @@ int cmd_trace(int argc, const char **argv)
 			goto out;
 	}
 
+	if (trace.show_cpu)
+		trace.opts.sample_cpu = true;
+
 	if ((nr_cgroups || trace.cgroup) && !trace.opts.target.system_wide) {
 		usage_with_options_msg(trace_usage, trace_options,
 				       "cgroup monitoring only available in system-wide mode");
-- 
2.51.0

