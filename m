Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F271D5CC9;
	Thu, 23 Apr 2026 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972296; cv=fail; b=T0Rvwza2LhKH4r09eu+uLRY5odsikTB/JSgcAKVTatvvkjZGF/m024yOfM0xFHKki2OWVCRWVPvhH4XMfhQpkH1vE+LzXZY9jqslBTqPtdE4lh9v1/0yA/ur1vu9l99TitgLrVMS9x+uGpzrHZUjxD816x10k+Eau7jVE2phXWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972296; c=relaxed/simple;
	bh=Ow0WLHbMlLCXHsioxQcmJ7bNuaIfCcPek2L2KdXcUIc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p9j8JkPptLVSWQZPVZa9vy9PwXYKVShE0SkHlL2HOOgkeiheqJzL8NCX0i5ezPgji42YaUWWJnaUitxmGA8BAhLIt1iFb6Dzd7cPaoh1VJBNSWyGVwLnfQQGYFQFC5c+RI1f2lfzRpRimwBjPWOBydCARH22KUY1RU84OSAi6Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhCn2qLHO6lFNNqpQj9C6hFxq385tjAOijb3n5q9auAh4ur9X1UBsAzueDvoFLar7l7oW2Sn/L0XDdBBSBx2PaASBs/TyqzGxKnji1x1CVcJvpQSzFXunp2uNUE2UaMcUyMStQUvZVBinY3tziEcr+nGClNkeWf0q3DczPmaBU4g3riP3f6A5h9jcN7h17P3XErQK7Dc0H1/SZsHfCMm1O/lNy7B/kZgp5w+TIPBY57kmtANjtngelXyIm2sh4/nLmU66fZSDBTl4E5Hqq0HepzOVHySJ5M2Q8l5LD2/XEVSBYM6Fo1NTVrFzvOXqwfIBU58+yh+7G6Jqni4+iGOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWzQb/jiGIt9a2lCC9HaS+XxLz+WNGOLHYK9LB2rWso=;
 b=BzwGCjCTizu3v5RvMT/mcu6xFiktxbnmbhsvUytp5/jJqWTzLsiR2+JUlVDVr+evzQjbfKv7WIJBOo9QpAPeYsc41+8sE2gkJtq19FmmIm5xV0bTaWlpV1vd9tcix7rPlRSE6qqsXIUx+Y7VzQjV+9ZlxLAiavbi6ov5VtiAi4UPgVxWLgoUgb6qS6gyAopt6Dt/yOi8yThIq1tTCNzpC4e1d6yj831wS0etKDGyMiLB+xUA6uL0OH4ZLZG9XLx/vSyx8zwidrYuQtIuzDiEpqszLuc9TsmRSxy/mMKMqmaMxi4ZyVWcthHdXNW2jwh3jqiFD/Q3RgUokGDKMJwpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB7665.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:203::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 19:24:50 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 19:24:50 +0000
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
Subject: [PATCH v2] perf trace: Introduce --show-cpu option to display cpu id
Date: Thu, 23 Apr 2026 15:24:45 -0400
Message-ID: <20260423192445.131351-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0336.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::11) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 4278f73a-85c2-460d-8d41-08dea16dfc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ctLwEQWZGqgJq40dzg5pVBqToHnq9BYgWf4HI+ygDsoKNXYYravnitFis1BTcE13ghGzixQ9CGg4dztWCoL3whdAwVKN6tiIi69lsqH/GqrJmdp/3nk8bsiVZsoCA3xQkRrn5/jZ8OBwsAfHYc6TXds+W00NNFPCWknD34twnzFAnLhEShkGsyGjghdAa1Z97Yd4SYxPitkdsR315WCSmp4qFO9B1y+dPh0fg8yVXvHjNJu5oZTpELgLGN3zx4DYPbg9kFkA14DSx7upVDmC5LZ8puVd7QM9gGBJDUdRCIA9rMA1n6vqoK2hcwnvvVwUrPMUQaTUJcP9kCXvoZekcuIttHgLt4bwqj200QSHNYY1vCaDik1BRkRJq6Kxoet8u7o5bxWfLVyJYv1qo4SZviJJAXKH2epkiY+2f7iFG728UzEMTArzW0fO4FLFmjop/0FUD95RLzOtjQ9FQ0ni9XKHhsghn3VXL+niErL0MJfTrBJ9ENzRuGobgPgziKaDWiV+mPLH8JxA4WxEjl6JhtFEfsvuf4zJkJgdEUwxZLEbK5Qh7JB1TPDyIDSu+i3wQ/BS10NMx79VdMl9OAI7b9QRgSviASDyrs/1MmLUVa1aRDI9yYi8xXnAwasbU5uOaDVXIakZiuKZFgUnCR/RJBPmTFnensBOPlBxLF+4AuUbcDvy9AsR6Rd/woqgBQEt6+zsD5F8P3FxT57bHJLGEEUXsAFr/jGGRZ6iElnCCQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FOidnRv1JMFozln98RRL7Q0nsmVo0YedW5Cw2P6FbZDgFhTsXelZj/2V7bHd?=
 =?us-ascii?Q?uvhXK3MIIBxlEvbCBuVbXrp/xUU5OVvnH9HuwcwXGtXC21X5OhOeEOS43Aaq?=
 =?us-ascii?Q?sV0jLr5apUd+ZaeWBxkEEaoFBLH2VlCKlcOHGyHCIKvlhj7IVdZvJAnAalBC?=
 =?us-ascii?Q?Xd4Tjhr/Ly4ynly2SezPCSkmLp6CaPgWtUiUAFl0CGYRL7icE3gpR7STB3g+?=
 =?us-ascii?Q?+gUu0cvszCW9CjOvW/H/1+CFEzG7aQfvjKjFNZlaeO6MBKLWyCs2/J89h6D9?=
 =?us-ascii?Q?Li2+/7euLx1EWqHwFbLqzBtm8evvLyrtF86wwqMq0JSuIKdLw7MlRJu++z/p?=
 =?us-ascii?Q?fvoExEGh9Doj7sjg2S7XLzJRYRXQtpXvFVRZyKBwo5Mrwrx8PvQn38cTX6rq?=
 =?us-ascii?Q?GikM/9SIoCNnqjEI31te/8nF1L83vZOwg14SgnAB5sirwxxvzrc6F36N9L/F?=
 =?us-ascii?Q?GukQXEZu2MQrYTI5qnZP7zQ+cB8unje2jPYjIJdn8+mlDRKT5sSwBEc5a9ie?=
 =?us-ascii?Q?AjUfs3l9NurfNhjDJdNSnV+PIVSK2Zz64DOEnt6CjrrpgCG4zgnGWj8BHp6m?=
 =?us-ascii?Q?dJnZ/Zs/x/TirridRadLxeNe0dLKaxrtLp/bOL8tExqz3+ZsyvNwTCPcgwmx?=
 =?us-ascii?Q?YAd52XGC6PDyZ/iHSIlCjDnFxx6UnwUFpOqGmiXUPA9SGzkn2gHnmk91+tpI?=
 =?us-ascii?Q?PjGkiPHWWSO9cYPlUbQ+cYTYaYh6nGEN43fjA0lhEA2Rh3qitTmD2oME9vtv?=
 =?us-ascii?Q?fAQfJ3TzLfFMFiJAyr1vCbDej/fu3E2KRgy79esFm2l1GXT/vvIj42Bg3kAq?=
 =?us-ascii?Q?pEL7jclrbIzx3MFwLEA1XTTX6Svk51o/KqjHKFow4flRYLnKhZlGv/Rx1qRE?=
 =?us-ascii?Q?mNz/+E6tnDMamkWDeinQz8RJyl56Gnv1WMZcblI5HZ2XsuQfgBNki/cPfQy0?=
 =?us-ascii?Q?E15W13FOTaoYKF4x2LbTA+jl63H7LvnpLYnrKtmExkDaFzHcI+h5d7He/F6g?=
 =?us-ascii?Q?jzdZuahvShRCHPTemjF23h+7G64TtoIjbQCPrNanoreVO9Th6ONNIf1pQPNl?=
 =?us-ascii?Q?1Qgjd0g9b+A9F6r+xW1B0Y42dnKoexzUt770FLIOrSjTvupTONOZQ7ziTC2A?=
 =?us-ascii?Q?sc/iZ6L0bkIUFRvjHY4iZSZhG3CFMeRZdcfcoVTadMaZCaKYSi3/6WIpH1+U?=
 =?us-ascii?Q?we3hD7O6VrN3C63axYgDi7Q8IaVwwiCXXuWTYicW/bzlr2942X/hDMcER+wc?=
 =?us-ascii?Q?SisVg5NsR4Bh7haFO23T9kCtYAtELvl6OPjyG3cLmmiivadOyouUrqV0MpKl?=
 =?us-ascii?Q?SGPkrSwtCxcmJDi2y/O+8qdNk/b47dYSk/5LQxEKw6Y+03fz0vd4secj29yW?=
 =?us-ascii?Q?Smg65NgYITKRPm+MIwju37Hy/d9t9kgZsoMu7jSaqkxkaiM48ZglI1Ftv5kZ?=
 =?us-ascii?Q?PJCg4w4ExaVB+PpUjKBGo1Z6objUvCkhjl0vXpqDcGDJze+EIy6GxRMunhoH?=
 =?us-ascii?Q?UeUyRV2jnu1EZ2rGeL3fnxPz9lBmlz+qX6WQK0o/4XpoPylWlsOg3/9bW5f3?=
 =?us-ascii?Q?6YNlQCzhv5KOXkH7aeuh0xkLEpLLRGTGLQnfhuUGS7mw5VUoGo35SfHqbv5D?=
 =?us-ascii?Q?L3ENa5DaJYDzEiwI8/Wkzl4K+om2DsjThEue1b5Yxd68B5zVMvjQkYsx9LpJ?=
 =?us-ascii?Q?H0vT4XBKt9o8HUF9EwWEzmjdKh2jNnAbEM6Iw8TYk6mPDteGoYy7kr6YQ0hg?=
 =?us-ascii?Q?5tn87lFilQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4278f73a-85c2-460d-8d41-08dea16dfc51
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 19:24:50.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YlHHArNznc9NvDaS7CLJW7SCoaXu+rFPbOENOxKGIJatH0SqVEv0Izv/q1/jh4vtQC1gASkouqB1bWHkXiGPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7665

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
Changes since v1 [1]:
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

[1]: https://lore.kernel.org/linux-perf-users/20260421203934.64032-1-atomlin@atomlin.com/
---
 tools/perf/Documentation/perf-trace.txt |  3 ++
 tools/perf/builtin-trace.c              | 49 ++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 5 deletions(-)

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
index e58c49d047a2..6314332ad711 100644
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
@@ -1893,6 +1894,27 @@ static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
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
+	if (cpu >= 0)
+		printed += fprintf(fp, "[%03d] ", cpu);
+
+	return printed;
+}
+
 static pid_t workload_pid = -1;
 static volatile sig_atomic_t done = false;
 static volatile sig_atomic_t interrupted = false;
@@ -1923,12 +1945,15 @@ static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread
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
@@ -2707,7 +2732,9 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	if (!ttrace->entry_pending)
 		return 0;
 
-	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
+	printed = trace__fprintf_entry_head(trace, trace->current, 0, false,
+					    ttrace->entry_time, 0,
+					    trace->output);
 	printed += len = fprintf(trace->output, "%s)", ttrace->entry_str);
 
 	if (len < trace->args_alignment - 4)
@@ -2835,7 +2862,9 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
 			int alignment = 0;
 
-			trace__fprintf_entry_head(trace, thread, 0, false, ttrace->entry_time, trace->output);
+			trace__fprintf_entry_head(trace, thread, 0, false,
+						  ttrace->entry_time,
+						  sample->cpu, trace->output);
 			printed = fprintf(trace->output, "%s)", ttrace->entry_str);
 			if (trace->args_alignment > printed)
 				alignment = trace->args_alignment - printed;
@@ -2980,7 +3009,9 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (trace->summary_only || (ret >= 0 && trace->failure_only))
 		goto out;
 
-	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
+	trace__fprintf_entry_head(trace, thread, duration,
+				  duration_calculated, ttrace->entry_time,
+				  sample->cpu, trace->output);
 
 	if (ttrace->entry_pending) {
 		printed = fprintf(trace->output, "%s", ttrace->entry_str);
@@ -3280,6 +3311,9 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	trace__printf_interrupted_entry(trace);
 	trace__fprintf_tstamp(trace, sample->time, trace->output);
 
+	if (trace->show_cpu && sample->cpu != (u32)-1)
+		fprintf(trace->output, "[%03d] ", sample->cpu);
+
 	if (trace->trace_syscalls && trace->show_duration)
 		fprintf(trace->output, "(         ): ");
 
@@ -3405,7 +3439,8 @@ static int trace__pgfault(struct trace *trace,
 
 	thread__find_symbol(thread, sample->cpumode, sample->ip, &al);
 
-	trace__fprintf_entry_head(trace, thread, 0, true, sample->time, trace->output);
+	trace__fprintf_entry_head(trace, thread, 0, true, sample->time,
+				  sample->cpu, trace->output);
 
 	fprintf(trace->output, "%sfault [",
 		evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
@@ -5432,6 +5467,7 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK('m', "mmap-pages", &trace.opts.mmap_pages, "pages",
 		     "number of mmap data pages", evlist__parse_mmap_pages),
 	OPT_STRING('u', "uid", &trace.uid_str, "user", "user to profile"),
+	OPT_BOOLEAN(0, "show-cpu", &trace.show_cpu, "show cpu id"),
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
@@ -5566,6 +5602,9 @@ int cmd_trace(int argc, const char **argv)
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

