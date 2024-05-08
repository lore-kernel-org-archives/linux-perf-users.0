Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6623754;
	Wed,  8 May 2024 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148331; cv=fail; b=H52gjrT8ddvTjfOX4yzZCkUogBr7FgFdN2iZJ7+zMMFPlfJNWAZhJc6CdNedV77NqPrrNL9E7yonYLY43vxKFVLHmc0owsfSnyjWnkN4kuvstSB1Td6nvsADmvYL7X3TDnL5NCkVUsr6qqIBotcIii6qoZopGUnSpJemqqLPfm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148331; c=relaxed/simple;
	bh=J/ec2gYMHoMnU5ZoH+EPySBsc7X6uqEJNH/qylcOXeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSdPH5tS86owJ3/2WPQ3hk9d5j+WLW60t1Qyl2qKC6knGTqOmOhCBOXXOjMq1gVxdh97i6NY49MCb4o8e43KgS4p/lExUEgf9qq9A55HOG20vY89armbu6BUD/Dm1EhfBs25x8+Z0vsA/6vfVypHqXJ1d0MF3xdZwObhKdhYMt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NYVTeZ8R; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NYVTeZ8R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGovUkFA/1N1bFOnhh+J//eIy5crsGQ6mP3V3Ef/iz3vNx5OD/8exPZ9lHIALe5U5VeXEDB5xZrtj7gdqx5gBEOhoZLpteC7MmjS7TD375dKtJhHxgNAv62x7p5hDwkbrr+FJzJ/fqQBfypmT/YGSzifl3m/Ei0r9VOYoUkSgmTM7zcykljYRJpGJ0S5fPKBbXA+IRfJkL9OIz6DHonAO1/dvEeIQcH2w09STvtDEMkpO8i6i8+GCUK+yF8mgrled+aOKUNSKzo37MMdVw7QPp2i/UiF4VE0UkqlpO2UKd0OqPn24z3QbWqX2yQeB7Iy7G2tLWNZQkTeRKBxX/X0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQVasa1lBb+ZNnThoqNsFLOVF+lax3Z5cFSqOeRUesE=;
 b=UmnveLncJFUuMRhlT4jQ5mZIuUZejuYD1KoyN8vV136EoUZpaRPXRfIo42zqraABYiam1yDuldvUyiUFPVLeqe1uCI7eJqS25Ox+zJd9geBT/SSCatjhQeOAiqH9oTPLNdAjprqgGc0LrhBuLCpgnPC+36qd7w5nSYAMktBnz5NBdVZfiLSOXDy+o/7peNRanD7qd5JC8jQg8BEwnxFKIwx6Q27QANiGZHCqofo25oKkwYTXt4xBi4G7MRU4jQka99wgG2HO1rdnyw9WVs9Cu52e32UGA/5cgQxXZchw1cORhLNfpUVEcT7nciaG7cMBEfssYrXqXJ0A2KUyirthhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQVasa1lBb+ZNnThoqNsFLOVF+lax3Z5cFSqOeRUesE=;
 b=NYVTeZ8RCCzG5gjHOxP39onKyJ63Gml7f3WcMzCYIJuwfnuvUPBC39nyY/3URnXCOogJMheRZje7zuHOgIiIJT1j501poqxMNUh98kxKNHseMpvMyKBebEqivD4ld5hCxpuV8mTNLVjDi8YudXRKF9nlYAI0ni/ng0RTu82PdWo=
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Wed, 8 May 2024 06:05:26 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::74) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 06:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 06:05:25 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 01:05:16 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>, <bristot@redhat.com>,
	<adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [RFC 2/4] perf sched: Add template code for schedstat subcommand
Date: Wed, 8 May 2024 11:34:25 +0530
Message-ID: <20240508060427.417-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508060427.417-1-ravi.bangoria@amd.com>
References: <20240508060427.417-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 099447f6-4745-445b-e0cd-08dc6f24dac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YiBsZGHIoVL3rdsrgGBsV7cfqDmi4BSNT8b+lWEjUk+JNJ8PrGl1t4QkGFjV?=
 =?us-ascii?Q?yP3S++xxMDHo3c9j/t2nBYXr8Ph1PrljmmLohmPwxsvRc57HC9UuTreXLyrY?=
 =?us-ascii?Q?ipSTKR1Q9WGSOghGwtp35A7LI1MeFuoEdlUiEsS1Mofq4n3sdpdahubmfqS6?=
 =?us-ascii?Q?omWorXE0wOpfAFfXUYJPbr1vLYok7ziBS8L3HxYUYcI+71UgAf1CS8ZpNe+x?=
 =?us-ascii?Q?MXp14j/yCkPyAKCxE5NfPa2iIf5eVI6Xqot2TZ80Wvsl3dEi+0uFxzlWVkt0?=
 =?us-ascii?Q?jOmizuggPO/+WYlaHMdzPZL4d2TihjIZ7eqkHOJUYMirThdhoG9E6yWxsqQT?=
 =?us-ascii?Q?EPCmTOwbPq2ne3r6ZahYbVznifWbpLKZZXFScEwqy4ggIEbcvu0Jvph7BZD8?=
 =?us-ascii?Q?YE2r5Vf93HX9joVhrNrey0tiowRagVBD+zk2ETKao7wxGC9qv4nIHB6zhxEM?=
 =?us-ascii?Q?8HywZJNiJo9E+/tc3/PDIktOzB7qAMHwhG74mllTLpJhd8s1/BruMSkTS39f?=
 =?us-ascii?Q?+J9FAfWnJ7vhm3E6rurL9S2XyXiYNVB5Pv3fOzfqbFPKIWvVWfLSmoXFZSCF?=
 =?us-ascii?Q?GE8XCqbGTddoHTRWB4xf/1KlSVl2GZh8TGIy8NWbYw/YjNHGaYWBWUtulab5?=
 =?us-ascii?Q?tOyZ7Kf/YwozsqvDqBerw/noSV1/rYttUQR95mtw37FabrdNRougpPz62DMw?=
 =?us-ascii?Q?FW3DT9yQEKCLtN0N3mCYWPaZ+SXAAtlhJI1Lz6SFL3Ly6Lu3RxBIOMsuOCfO?=
 =?us-ascii?Q?2bR2okQn4suY5kqvWUSNkoePBTOtHVhcfVwILp8IXVFn8WnBCNlIT8UMAvFw?=
 =?us-ascii?Q?T3+fECcT3P1W86gcQKzLE5/62Zx4R8T+VYb30nbzj+nJ1fWD4PZEM6p+aTny?=
 =?us-ascii?Q?FRGjQYKzHqlOX3WAbNb+116jUvN8S2eurCoQJAAjpFvRj4XyWRxli7i42js9?=
 =?us-ascii?Q?fEKo4jtIlPEoWiklma3rcT1bD+Zo7Tk3OrddznxU71GLk9DRuVAx0mXcAX7u?=
 =?us-ascii?Q?ZPTaeAhJo6C59K6PA4KoYXAEjQUByydfA/3l4uAEEWme6LH56YNlpt6+O0jT?=
 =?us-ascii?Q?/mLGxoGOONHt18UWYz1YwaFuEo/FaBiXZNiQUQLuQPGv9pgA+RiCyI2UOk4G?=
 =?us-ascii?Q?z4RR0r6t5oHK7u/a+LD7LW0tPkRNXWiu2nuuPJTT9CKBeIczqFrBrsRDsEYV?=
 =?us-ascii?Q?KcquiyJ7tNq1hQ2Nc0O/u9k7/Pd4NCqdxpk4mKu1KJDn8wSzTCa3uyEmH4Eb?=
 =?us-ascii?Q?Q4bJuKyBktXSoG2NYkYO6AoDYEPcLO/6lJOFjTc8q7jQOCz1Km22QUWDmvtd?=
 =?us-ascii?Q?35oRzlF0yYUXPDd73k3rgm39Tt23hjonxVTjBp2NAckXq8R4Qnjc/VzMUwbD?=
 =?us-ascii?Q?gNL16YU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 06:05:25.8384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 099447f6-4745-445b-e0cd-08dc6f24dac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508

perf sched schedstat will allow user to record the profile with `record`
subcommand and analyse it with `report` subcommand.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/builtin-sched.c | 48 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index bc1317d7e106..717bdf113241 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3504,6 +3504,21 @@ static int __cmd_record(int argc, const char **argv)
 	return ret;
 }
 
+/* perf.data or any other output file name used by schedstat subcommand (only). */
+const char *output_name;
+
+static int perf_sched__schedstat_record(struct perf_sched *sched __maybe_unused,
+					int argc __maybe_unused,
+					const char **argv __maybe_unused)
+{
+	return 0;
+}
+
+static int perf_sched__schedstat_report(struct perf_sched *sched __maybe_unused)
+{
+	return 0;
+}
+
 static const char default_sort_order[] = "avg, max, switch, runtime";
 static struct perf_sched perf_sched = {
 	.tool = {
@@ -3593,6 +3608,13 @@ int cmd_sched(int argc, const char **argv)
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
 	OPT_PARENT(sched_options)
 	};
+	const struct option schedstat_options[] = {
+	OPT_STRING('i', "input", &input_name, "file",
+		   "`schedstat report` with input filename"),
+	OPT_STRING('o', "output", &output_name, "file",
+		   "`schedstat record` with output filename"),
+	OPT_END()
+	};
 
 	const char * const latency_usage[] = {
 		"perf sched latency [<options>]",
@@ -3610,9 +3632,13 @@ int cmd_sched(int argc, const char **argv)
 		"perf sched timehist [<options>]",
 		NULL
 	};
+	const char *schedstat_usage[] = {
+		"perf sched schedstat {record|report} [<options>]",
+		NULL
+	};
 	const char *const sched_subcommands[] = { "record", "latency", "map",
 						  "replay", "script",
-						  "timehist", NULL };
+						  "timehist", "schedstat", NULL };
 	const char *sched_usage[] = {
 		NULL,
 		NULL
@@ -3693,6 +3719,26 @@ int cmd_sched(int argc, const char **argv)
 			return ret;
 
 		return perf_sched__timehist(&perf_sched);
+	} else if (!strcmp(argv[0], "schedstat")) {
+		const char *const schedstat_subcommands[] = {"record", "report", NULL};
+
+		argc = parse_options_subcommand(argc, argv, schedstat_options,
+						schedstat_subcommands,
+						schedstat_usage, 0);
+
+		if (argv[0] && !strcmp(argv[0], "record")) {
+			if (argc)
+				argc = parse_options(argc, argv, schedstat_options,
+						     schedstat_usage, 0);
+			ret = perf_sched__schedstat_record(&perf_sched, argc, argv);
+		} else if (argv[0] && !strcmp(argv[0], "report")) {
+			if (argc)
+				argc = parse_options(argc, argv, schedstat_options,
+						     schedstat_usage, 0);
+			ret = perf_sched__schedstat_report(&perf_sched);
+		} else {
+			usage_with_options(schedstat_usage, schedstat_options);
+		}
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
-- 
2.44.0

