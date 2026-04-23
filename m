Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021098.outbound.protection.outlook.com [52.101.95.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B5346E50;
	Thu, 23 Apr 2026 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776973241; cv=fail; b=tIM94NXlxe+r42OIl61RMZdpvEETYL+E7CJZWTPWqxRjFayt87ccOXLVXkpLhHWwcWUkYac8qDRJgljkNFoP3EsTdS2BuG8/rAneM8Cgmwg7QaXKmgk5d6AiHfSnkDP8R26zlgm0VClsUMH70Vjke09s9ZWaw6/IQWSnDpWH30Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776973241; c=relaxed/simple;
	bh=IpcyiQ/oSvrVHr3DW08d17t65XSzOUgDYwCAIs2Da+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BsybnWUYitr7X18XvtFZSls9V44BVJQIGUgxs3ahAdJ5doAnEbbhCsEvTAYU7Sbx+814gNfnVb/uRTm2NemsBFC5LNogaWTFwt1ozautVkj0q4k8u6VMT3mb94K9FhkApyRoORcuMg+05tkhITNyEt8Nattww5qFNniPnrZuvts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b64OqGUSPjTbLTpFuqs8aLDwWOb5vlOeEygyE4FnFfRJRWa0SgPULkEt+LD9kEW/LI52sVxpKOUnDt+U8Y+tVg/IZqGKdZX9HONq1F7i+icZ8ealvfL+p5bCeR79imW4wNQyjnmpxkmZ4fOskrg6YKq6UNvTOwmmknS0fz2ZE9ymzPFCqjC2yiwIP7NZIK5rkoUCV8e/9b8Kc5DTTt53oOh5GFONgvWRMe1IjSLtImD6Wg0+3B8KgwZgx0OnVNQYAhBuhFxlqyaXwd3ZSNvwIvfFpfAWUvYqO2PLk4YBRt26mRjVItajCuPsn9LZxfVAs+x1Lj9gpU6QLk7Ybrs0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVbpwxX/f2bFMPyrFWd5yNS3CbAOnOlLQi+K5nRmk6M=;
 b=t0Rudv4XsVtp35KqL++SfxIMovovk+N+CW41ZqOIAIyuZIju1Dd+eMqAcM3S7BYJdxWGtP2FM7+rFvJWZ9bbBR5JGFZlM8EMlUgBTtECvw5//qv7T+jJI9bCqjI+/FrEYtjRnUegRd9dMyig4Ehj6uq6WXGG6JEBj8mMaP+D0k2gmw7DztKaWa8P5Js9ntTnNv4s5MEtpBS9j1EwboOL49NwLlDY5ylvTTZCAplCV3cdSGqrphPMq4Rvsb3YOmRIxGw6o2saX9FTfqVYgRIxCJosadOjRFg0PdOYRoQ+XLG1AjxGdISna5B4mCSVVoT4DFoJR8idUH1bExocE0xbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB7030.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:343::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 19:40:36 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 19:40:35 +0000
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
Subject: [PATCH v3] perf trace: Introduce --show-cpu option to display cpu id
Date: Thu, 23 Apr 2026 15:40:32 -0400
Message-ID: <20260423194032.134416-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::25) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f6ada2-2fa5-4fa5-ea98-08dea17030a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pMl1IjV7u+mVDkeKCtzDwdT2IG2sdDOY2I4xgzaLbcQIrtPfRSJlzMtQo54blJsgYl2O5GXKHQuG/owYy6Ku8GGgzWB5bOi8fX69jylS2KYwu2YPvNe0cdh8ywAbd6K4wnUG8PtCGAjyDTOFOI964mytxDewvR1TZb7XqQNbIBZP3VMlA8I8G7OWxSwRTBj9r+KQWy9V/CeoyKXQu5NGfQwFVtbEbyvDl0bXLp7vBdodTff37sQLIhho4/nG8A5hpVwqzAD6wThr65rH4TGCuvHSJ79GPY0lU7mYPxjB6i1Nr8tOXM0ucl+nGewEurzWG2ZOWkJ8cGyEOOzQ/6epi6fEd1/hpAoqlQ2d+lxRD+BTv5CJGTgeG8/SCPXMFCUpHFkcNd5bSSJyX4mD9jgLr56yUTyylmNGdNPiBcc6+I9ymghPqEvZK/V2FEXpnrjKxdJbwQKa/Vk/0TNITl1gnvG4jl2xQiQ3knbr7F625GjPj+vsDw3asBqPik0P++8LEP/UjS7Bnk7MD7oMqzV2sFS007xaXbXw1CtrlYXhfFqAMaAsPym1Cw6G6Hge0eu/NW46bI/mAGcaDN/EYe0zFKgfrLxH6e9YZSuBypumGz2V3wHOs9hJMoQia+5wktmmiXO87MRmbxyd3hnkmNTApShWyl/FTntnex0BmxkvcLtgq1nE4ggwSbLnmhotdCjy+f14n1oMJkWIhfeXPpuaxa9KXWrDLfgMwxChkNGP8/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GLTUp5KZcxgEJvTBTj5FCpPkOfaUUQ+njj1rtSfljFyGAMMZojReSYERo9pF?=
 =?us-ascii?Q?4lYuv9+evXR43sDckoFHhl4fB7mo1unOIon4XHwy+e3cYz01ZQC2Ttr00WRw?=
 =?us-ascii?Q?KEGnnWlavErjd+i7Ja8ovkC7rHrofHkEUAgwlo3M07MkqLRLgY4BLnZC7Nth?=
 =?us-ascii?Q?Ea/zt11j4gRvOCxulbCl0OP0ggj5fINoNjY6HbqdsjcpxNa5WEmRfNQisW/8?=
 =?us-ascii?Q?LHNhAP8cjdgt1bF8I/cqmDwAWvHhggm9YsECDINpBpqkIRhoQmi1NwNYa1el?=
 =?us-ascii?Q?KhpH2cM7c5z+vX2IraGeHxZXovXHX4qvSFziJH5b2+DONLlt2btRy/1B+UAF?=
 =?us-ascii?Q?szaYxlLW63jeoaXCpTDJ1tEQuMa8t03/wzorzPtsQ1US+2Fzo6B5lmOg12k8?=
 =?us-ascii?Q?EWP0USitnV9bMPXDb1oslMnLjXhYgkautseupzGXhbLOwJBx3Mh6B6J4uY73?=
 =?us-ascii?Q?ibu1KHB5FL5PsgBNsBCH6xltrrxTLehhlVKkaSzByAeagpyu5b/XpYi2wiUb?=
 =?us-ascii?Q?Qm9tIjB/IeqvdfKEz7W1+SkymWVrwP0QX+SEWj+5yIIsC+u7ywv1Fg0vjGH+?=
 =?us-ascii?Q?ot2S4szZD/KuR0EDGhVGoGU80GEwqZajmj87ue2oyLhZEnaTi2fSQ6ciePmj?=
 =?us-ascii?Q?UGwsAaz+0AouOLj2BJh3xTBVoqgdlGLyIG9HN2X42bh9zBHpkEgnYqBo5JqE?=
 =?us-ascii?Q?d8T2FcQ8+CkWVUkgDUhbJhDcHDa8ZemPxcdpWa25fjcpEvnhkNYEkwSwIz6g?=
 =?us-ascii?Q?j9vuatT1kZDBUDhwTGf6HTdSqFiHtXYB12GwFqBK5ooBq1xmW+MK4T1u6erM?=
 =?us-ascii?Q?BTo7p2QIjwJ0jX7NtLjrk3NMk557UOSkC+2edpubpjEsiEtvO4K4IwmyhsST?=
 =?us-ascii?Q?CkzCHHN52IyzZqsbEw3zrohcITKdCCtIth4mjeeyN0CJgWPDGknVSLHQ60Qz?=
 =?us-ascii?Q?FfJ8aKIrYRmrTwcvurzX1O9B3UsrqN9QbATAVZBN3H6JDeUfw1x0D+VVitmJ?=
 =?us-ascii?Q?kkddMSNr3V4S+CvLce2bD66al//ecU3wHb2KQFl0verGvfbIHM7LQHE+W+Uz?=
 =?us-ascii?Q?I4iyCfrHD19KH+wSW6DpnVJ0CBIa4hAUPjhTNisSaoV63P4jV/KyHMgtddvA?=
 =?us-ascii?Q?DBgYxWOkpRV9nSHsO4g8pYUCOlwGQOIpeuIfML2WhVp1hyBTbfp1RsJQBBP3?=
 =?us-ascii?Q?Y5lCHN+uNWeEwn+xPVqdZztHjsvp6wiUnYOe54QjW9uQAFHaqbbUjPp6jDxm?=
 =?us-ascii?Q?eAr64m1pCQgIHfDDFbKpWTognTPWqolB/eVsmGfOmwMz7RRzuUug+BjfiE6D?=
 =?us-ascii?Q?fDI6Z2F6skQMxW2Bv8eydMoIQKfuyox+4FqrM2+clBhwOi/Vt2rZozqyfMdu?=
 =?us-ascii?Q?1JN/cKeW5NU8DqtUDXOCl5T4G7poCJOSNor7szhyCXNBDCSvMRFIJ/TUCTEL?=
 =?us-ascii?Q?qaz3ykGsOaM4jr9Dm7EEBgj+0df931ESqppb1oDkuC6bRuFAJnjp7H2J82cf?=
 =?us-ascii?Q?ObPhOUPlS3bZrIIDKMOgB81mJzdeelBpXll2YSj8S7qfHBDr39sKZQfQZzSP?=
 =?us-ascii?Q?4XxVYYAkFwxI/NmbMZbZoEXM8XsstDnm1BOBThPk9i2gNYH5w+bqfbVrTm2R?=
 =?us-ascii?Q?rZKDIUQh7KIecv1dADuS+s3gkogd9iyc87UW8R074Lg5atcJyHWjL0Bwpu1q?=
 =?us-ascii?Q?oG5q+7n2lTozJBKkQ5cLY31oJeFhlkO7l4/i4FF0vF2ZEI1kQBFBgy5ZoB8b?=
 =?us-ascii?Q?X9ctv9S1aA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f6ada2-2fa5-4fa5-ea98-08dea17030a1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 19:40:35.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BD8JOQ+EFaXU+URLDhD3bb8cpOsxNeSi/uIXheX7lxapLWqLQeyhK5kU+YH73ExnzUFixPTz75c5NVcvoRuNJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7030

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
Changes since v2 [1]:
 - Fixed a tautological check in trace__fprintf_cpu(). It now correctly
   guards against missing CPU data by checking against (u32)-1

 - Corrected the format specifier in trace__fprintf_cpu()

 - Replaced the hardcoded CPU ID of 0 with (u32)-1 in
   trace__printf_interrupted_entry() to prevent false CPU attribution

 - Refactored trace__event_handler() to utilise the trace__fprintf_cpu()
   helper, removing duplicated formatting logic

Changes since v1 [2]:
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

[1]: https://lore.kernel.org/linux-perf-users/20260423192445.131351-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/linux-perf-users/20260421203934.64032-1-atomlin@atomlin.com/
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
index e58c49d047a2..165eb19c9c86 100644
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
+	if (cpu != (u32)-1)
+		printed += fprintf(fp, "[%03u] ", cpu);
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
+					    ttrace->entry_time, (u32)-1,
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
 
+	if (trace->show_cpu)
+		trace__fprintf_cpu(sample->cpu, trace->output);
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

