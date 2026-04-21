Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022140.outbound.protection.outlook.com [52.101.96.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EB27FB0E;
	Tue, 21 Apr 2026 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803983; cv=fail; b=g3DdvV0ei4OdQRSUaPHH38nVNWDUxXdRLYavNK1VWvM8inZPqOqWO6C1b0JdNegQCiHvnETuG354sUxgbCrcVLkSc7iKqOB1u7AhA87RDghHQgcailM2WZ0pS3dXy2xJxelqI/Qlg5dTEe+h/GLhScvhiC5q1bsPtwOILceS/QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803983; c=relaxed/simple;
	bh=624DFDKxZ7REdQX79YVXaxabNF9MO9melRoF3okpLUY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MM1laxfyNndWgE12BdLqm0Dkh0DZ2Crr5fb2H1X3W9o7onLniZ82DGwXSMCcp1HerWiXtYZmodjEagsYx9v/R82sNQIpbaT56snspjdzo2vVR9dlZqEpeIiZ44B8cSnF4fC98L44kdnAulyDLH2BSfoLUWn062Uy/XMeMmniYTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDsX5n7TpbO1XssVmjwHEdcNwF1X1EbGW08gmhlKtwu8xigexuDCUGVpTIzL02V/W0kIGXEUP+VAwEzFAze4N57WfE1l6PuL8ygZj2Rh8liHN3Bb2fgWHeeTLUv6USi8f1d3etmm4BP1XLrLoUn+ZCe/jt6g4VKDHPVU9Iq1SbwWzvJs0aQlOS2kYmLA89gWtTleFn4+j/YVnsREzqt7aSPKlEV95UAuvG7+QZwnCoTrweElyAdbq3mChuHlZpKbaUg/jsSjXYWrtZ5+3VY2ljdw2GFo4hBLNrLBXao+On4uvuJ6ITcBkKz4xxaCQKry4nA2queQ4VKT9ZCYFk8f9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwV4jwRFc8PsILEVPpnbT8Odtzkorn7RLafqvUhqCJA=;
 b=aTiVsHqeY+jQ7y2nS5Ddq3TjvZ7Q28jkYHRa2+qCggSRz5KKVnscDpEfU49ukoUNZP6iPugobrYrMUMvWc1bqBBRF+2FpvfFyFpD9khrT4f2KcfVhZvPJsIswA6+uyI76Y9eii23zauX/RzCh3eojSk7cFBlz7xHokFXQYZPOmDzy57UFTGVQGsgFfhP6i127w9n+nXMmsaCOYDOU3NsUkh3U801xH7iSBLm3SxVS9niq5mweKvZtQnGOcSH0xzRG3W3vFa4bCkfvi8vqqnHsOfoS7NSMKcfX+WJXIM8+LwNu8F19EOQy+uo7pusndp4bm79Ti4GRyUq8wToPdV0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB8613.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 20:39:39 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 20:39:38 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf trace: Introduce --show-cpu option to display cpu id
Date: Tue, 21 Apr 2026 16:39:34 -0400
Message-ID: <20260421203934.64032-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::16) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e0c6ec-8427-456a-b638-08de9fe61b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fTzivTftmemFRmB1QkXOZTRjXQ/EWYJm3MvWw0TpauRZlYDEI/xrBFRbvPMsjMyHAmkSs2XT7SwVAk/zPzueZ6htbJ+GdkYiscf5T5qhaIuX0eKSlHQtKG6IoV4SHVUiN/+4mhnQG4kudPEd1+hJjc0K5J5rn/fLCNTi9Vif5JYOwDKBvbQllkLQJxJHZ7h3Zbgh+mLQj8grDw/kDEmgYQmw8V/LuI+uDgFMuFZTmeATQkHzt0atdc+QY92lKry6bc+hwBX5v5s/Sj5An4npLsQyISIhzTWgPRmuNLUUpzQWj57oJDyUtMj25r+mU+YT2fROOvB03Sk0L/wabX3gPeY4w/Y4/2ZOImA+qDWV71M6akFLxxY1z6QKnSl0uTdJ8awE5s+qskOl8gcNDjz8EgroDEtM/0INwFTjWNwlqiVJwkX5MUhi5DR/mqABxGQmRqFb+fUjqWjwFdNIwVHY3O74TFCqCuF1klqgNO/KHzBVruTaypmXJcjc/lqbMF/NV+z89TLJpfXDr+aV0XBLJMaFR4V+yqqDFC+sMvKWOk1qboSAKIwtVOusL5uVJ9EBHb4f6R1xAceTN3aMp9XnKg/lyCXpveRMRTtzZePfJeKTklgSJcIudmCM7ysg+CM66I619jahQIqTCOKVnRNKuMrhwk2T1kL0d7IVOgZShoZ/r5tqS18fHidIwYvcfLg7gTkW0oSaaiXj4ytWbp5K7jkR7WR7LTM5myXJ9Uo+CeM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPKLkXAj/Hrs3rcKScxX9KGxUBnZO9HLvHnLd8IG50OBox066wQp0b2mXcMn?=
 =?us-ascii?Q?lOCd5ojp0xV0o5tz+a1cqhtR6dm6RgemXllvjN9cSosYGyJQBLeBUkGbuvky?=
 =?us-ascii?Q?h++14v2P/G+pF1XNe+qeYWimuIAdy08ct1567P8m8CBWLk6rxDjE3PeTx3yL?=
 =?us-ascii?Q?Zy7cz8gpIAHAGnrz5eot/NK/J8yvIynxnBxBNBmIh6xN19LYGy36MuCLWUEj?=
 =?us-ascii?Q?U9VYcrEhZfYK6CY5SUh7G8At+kKbXU0ao+L51Ap7knHKJGJ3v6yXJa+MhMLQ?=
 =?us-ascii?Q?T5qHcbEUZEuM+MKZUse8ybLq4vEqXwO9gZ6J3Gm4el7lEcRyVIGTpceMTbDq?=
 =?us-ascii?Q?l5j0GUTF5nLY3ejiCFWOguAsdq2itmO1Rnd3uCPsADd7EafP/+exGaMljQEw?=
 =?us-ascii?Q?vLhXMQ6uxj9GRLtkI47ANE+fIaAq/x0DFRa1ia+s9FlLsluFSSWbRmzAppAX?=
 =?us-ascii?Q?ua+rQZYO4fX8eMNLllJzRD8CnhD+Blho7f30h6/6REAd0/jTQDKJj6NxN4nR?=
 =?us-ascii?Q?NlLZpqX/TY3NB3mdKjuU5rPdSs6wUFNYMzJu9ZdwQngc8vfRTOVQjFbsUD2z?=
 =?us-ascii?Q?J245YvlsHT+4AnPuomIjdL87fzm01RjT7s7xhjsisWYKT8nP9A/okfT0pelx?=
 =?us-ascii?Q?5foqmwDt8BDbWZw6VdOSpHC+Uz9uFViDeh4f8sQohgExvLZZEK4vAcxxHjkN?=
 =?us-ascii?Q?RAfMdqCaprw3nJy/B2/R4ts10yJTAPTBNbyj6qLqsl/zyV4x4wGHIHl+fYPJ?=
 =?us-ascii?Q?BJn7z83l3mhG+QW573uPHWGKDm1+s8N8NnFz2LZGxrM8Tdw81fPXgk/64l4v?=
 =?us-ascii?Q?FNyqIa15bmPjbqrYhGEtSa2CaQJcAoqLJweNzeaxgAY5AgIQZ+meZKSBFsHo?=
 =?us-ascii?Q?pSQGwgoQDEKoj2WSKThYmtxODhdadRnDE0vBsbLiuL5U2QY77efJban8fpsm?=
 =?us-ascii?Q?Ejxqxv3XJed++FKraV462GHQMWJrFIxWJ7pm3t5Kv7y+pBY0i5zJlCQgrki+?=
 =?us-ascii?Q?01IoU/qWVub+GnNCiELmLUbIH9zMk4jc3sx/CIeXxGodL9haOr70coESH8hw?=
 =?us-ascii?Q?dqppjRqZwMFQ2l4qR7CmmG+0h6BxKVWnEjIoH+/wpPYTY5Ol2nd2VSWHCO8r?=
 =?us-ascii?Q?P3g/wMEtaP7s2AUaq2SP9IuPQGdzzvIG2tRKwTGNyV8hUSJQbnDjc9ArlOa0?=
 =?us-ascii?Q?EzhAkw22OGYX4U5039KSz/D03702fehXqKau3sPt8PKQfph06Boh3IB6VpJv?=
 =?us-ascii?Q?gOVNFhg1JekVuOTRamtyj8W33gIz48u/uD0/esSCoyWmFBZEgmG8pVC6RFU7?=
 =?us-ascii?Q?GqTBqkDGV5a0IQ/y91dx9g6ZXzfjdqq0JI1MKpNIfQx78HuLyfTe50A679Xw?=
 =?us-ascii?Q?y2t2emIjZeRSY4QD6HiCwP5uXr7RZ00ARb6f4MQmlgjd8n2dANvFOe1iFDEn?=
 =?us-ascii?Q?UbCrqZ7Rz3h3nUltV+10BR02BSbnGbI14xSFJ/rIYD/u5c7aPyBQ7FDbBa3I?=
 =?us-ascii?Q?jds2rjDIKcm4wVdW242e8hUt6q6YtcAAFS4nQr5TchNZPWzPcMMkFQR6KGDm?=
 =?us-ascii?Q?QXubEVvDN7KYgyE+VO/4hy4hmux2Jeufo6wide/NxJwOvVFUNqlGVQcMOU/A?=
 =?us-ascii?Q?3pC1p8k0438pPrS99vyL2Pd+onbn7Pfl4yA7rMEQIuH8mCi6/4JmGtmaqqRy?=
 =?us-ascii?Q?xq5t7jY3xdhh5wJeBDStnxqnfgaiM5lqK79xEfyP5peGXUlMQt3liDjdwFOL?=
 =?us-ascii?Q?vto9PWyRTw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e0c6ec-8427-456a-b638-08de9fe61b13
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 20:39:38.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNcle1WFVEnWFd2jcbe1knll12OXq1enOU6a17QXRcYvAs1hqrnfNCGYz58C8YRMmrG3mRaqzN5N0PEMb7PPWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8613

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
 tools/perf/Documentation/perf-trace.txt | 3 +++
 tools/perf/builtin-trace.c              | 5 +++++
 2 files changed, 8 insertions(+)

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
index e58c49d047a2..be4104e88285 100644
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
@@ -3280,6 +3281,9 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	trace__printf_interrupted_entry(trace);
 	trace__fprintf_tstamp(trace, sample->time, trace->output);
 
+	if (trace->show_cpu)
+		fprintf(trace->output, "[%03d] ", sample->cpu);
+
 	if (trace->trace_syscalls && trace->show_duration)
 		fprintf(trace->output, "(         ): ");
 
@@ -5432,6 +5436,7 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK('m', "mmap-pages", &trace.opts.mmap_pages, "pages",
 		     "number of mmap data pages", evlist__parse_mmap_pages),
 	OPT_STRING('u', "uid", &trace.uid_str, "user", "user to profile"),
+	OPT_BOOLEAN(0, "show-cpu", &trace.show_cpu, "show cpu id"),
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
-- 
2.51.0

