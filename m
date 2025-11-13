Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DFD359F81;
	Thu, 13 Nov 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049797; cv=fail; b=nMIxEwnAdWu1JbmEp9Sq2J+qC/hW82CaMoGLm4KYrYOittf8LLpUqXUiTCiHnSEc3SvNL+F3WzSheVvq2KIH2dp8KUQFGR4z0u6KCrEmZrB6FwmLd1B7Kf6OIEMo5/YKef/OFNEnLkXAIoA5ZE6XAfZiquwBQxX72npBPh+f8sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049797; c=relaxed/simple;
	bh=S/6MVWRBoVrDldyLxNTrZQlhkjNaa9f6Pgu/aPncE4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jslts/9ZSU6sd2kojo7GIlL2qzyeF3D+JArF8BcPKsmW54ZIqOogEyfeWLFQM4tukI/GQRr9Fut+sjEztgq21ZIi4KNLw3WAuwwAogUZZOPOk5w9R+ihEUy3n9ULSmFvjq35W9CgCtl330Crq+QJqdTJYlk7B4g0jYwyMsOMB6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3N2jsrTb; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3N2jsrTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5Tw1luZ70vkdv1XCwBjjxeoTSAbsS1umomwixpRXUkz7G84DySipxJoiDUfiaVxuqYQ+DcCguoQlRSzX8K+stTQTarTBBVrf4dTfoui6h33LUsRubefa5EZa5yKX10uajpuxSxBUCC2xFAauQ9Ub56ZZx5lTSD9gOQs1rWdWvscMeTv85x4YHAXkGJacKIW42EhSlkVZwikMtnfsREGHfOumbnFkYgA7X3gYnrklk8fL+nmSbuuLwrqMdFPOk9QuqRuDDWaloBbqmoI301vARq64AWAwKFUBNaIg21kELKLfqD/IL/2KV2j8EuSzr9C2HGjgos2cjaQixj6WJtcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T45yqGliEcc7povJTtzjKqk3bygF0nRhfq27EfkUwOs=;
 b=w4O6AftrhRnLLME8tWuFh9hWurW7lXGe0GBM6fXDf1/Uo20K+YbXdv8yJ2R0qPeO1B2ssQWGNeCXBSXiIzjPLfAx2A/Mv0YMRdTwx0gC4FA1939sRQJ0lvDzPPZS2XkMyRketiSAnmBJ/7se8UrMcAjDJIa+1YiDUKlWWm9uei4Jj2TgEwyswzzYeNNlLK5tEPjZTHJydVI4FlMb9uwrmZfPyG21x92wg886h1su9n1amZQh76vGdkEZHHAM8VvyuV0Pskjp4srka4RKnJWNghh3O13MRFLvIYO0/eIjucESvVQ1JM27P1lJGfM9GntQ2pJdlidkkfkMVAegplcd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T45yqGliEcc7povJTtzjKqk3bygF0nRhfq27EfkUwOs=;
 b=3N2jsrTbVXEPhkaG5zUAHCpvlV/S2b4p6s+wOxIB26FrxjQwLYEWIv9iWu+Ry5n7V8BrkKo4lk3Fc28zE97jaQ2D/LvkqKz5uX5U6xlrvpwmTFJG36MbX7kgjRWAgmQ9Qz8+118xxI/OsQwOvJpxa6oiLn7WzeisL3LV+G/JYgI=
Received: from SN6PR04CA0089.namprd04.prod.outlook.com (2603:10b6:805:f2::30)
 by SJ5PPFE4FC9FAB3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 16:03:10 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::93) by SN6PR04CA0089.outlook.office365.com
 (2603:10b6:805:f2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 16:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 16:03:09 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 08:03:05 -0800
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Tycho Andersen <tycho@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 2/2] perf test: Fix lock contention test
Date: Thu, 13 Nov 2025 16:01:24 +0000
Message-ID: <20251113160124.2695-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113160124.2695-1-ravi.bangoria@amd.com>
References: <20251113160124.2695-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SJ5PPFE4FC9FAB3:EE_
X-MS-Office365-Filtering-Correlation-Id: 524f353c-77c2-4530-584e-08de22ce2441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1zw9/vauWAU9hxS4oUDjKauP+/nl+B8hox2eP+SHBXbO3LLxAejZilFhErhC?=
 =?us-ascii?Q?uPul54NU514popXCuOpJ+O/q39rm5IbdEMAwEo0P72vGrHbIYkAVsiTsfFvI?=
 =?us-ascii?Q?Yu3VDWSGcihacq2ecExSH8ljzIWdblicCxPemZqTnnASLXQVt4QsgAUpD8zx?=
 =?us-ascii?Q?2PAxY5jshT+eNC+whQ4CP4Z2kTQiTifr8x4ut3fIoKAN57+ArDuB0YPbZqPA?=
 =?us-ascii?Q?EU2nqGTsYLikrnztnJWNmx71OU+N3HlOcUAKMzd6BYGZeENL1tbRgh02PU4V?=
 =?us-ascii?Q?T4MjG1jaT/aYN+i7FbRCnO7Atd+JbQNMxLQqgiBbqc1q4BgSnG1uSEczHuIm?=
 =?us-ascii?Q?RK7nL28t490S14d8mUGQx+wKU6R4PoffBL7rTq3ixZR5SYeCoFuvLa3gBG5L?=
 =?us-ascii?Q?0v/SmmtiMYxazLbj7SVCAllCxXlSApW2qe6Id6YXUU6srFrbL/RWW15HZ3Qq?=
 =?us-ascii?Q?drcLnZxG/kCjwFQ+ArPbFWgEMaOQuqsIxcKFt0+BhW+wsUnydUJPF/EF7rc/?=
 =?us-ascii?Q?h6LhK2FYRIVlhdvr82xlXy1TZFfb1NZZ/IPypX4vus38nAFyoLPcevKxLT8v?=
 =?us-ascii?Q?f9k81YdnaJn4P3ggg5xOV1GCpEIFzAGcfcuM9rY8kJ8Z2V6RhOgD65E2HoAO?=
 =?us-ascii?Q?vCW6MKOLAB4aqm6Qo1OycLFPCxMzPp98dXhmtiROuCJeTC4jqhnnhqTzw1hB?=
 =?us-ascii?Q?giF57Yh5woxv09vFo5P9OtFPYRwcl8WW2J026cHokGMONRbz7hYzJTvGJwkl?=
 =?us-ascii?Q?tufdNuhFL3DSuRf+qFjRi6Y74OfLGSMxOCbMXjEJR3kvX6M4Y0okd2UJhfO4?=
 =?us-ascii?Q?jWfzu65qqoAtLck+eXvsuaWYESYL6EWXSRSib3YZMY+jsWVE/TPb93sL1N/J?=
 =?us-ascii?Q?MYkxCF9bx1wFUFJ/89haRaeiByHPGlbA9s9N86t8DmBAO1al2sKdjdHh3jcL?=
 =?us-ascii?Q?SHleJwQwruDxtpcR+8JINaOZasr0epSlhexfAz+ztH4l0LiHLUm66a+bqNPD?=
 =?us-ascii?Q?ylJMBbIcHc3Mr8UIueN1/hVPwLn8HHSUAmp9A8+mjcnxIDvIHK1wa/lEc1qz?=
 =?us-ascii?Q?df7IyuNSKP5OoaFEKQVh2AVKLbTGNftBpI7BtJdU/UwV9M9+1nSrIZP4vIn6?=
 =?us-ascii?Q?HRaeWv2RLrp1A76wukvOC7PQwAJvDJMENJmp9BPHFtkAjLIIs+jZqN24Igrh?=
 =?us-ascii?Q?7eFMDb6hv6vZJyiu26+t9fsV2TRhUSiK4UzwV7MciVMmzPlplEOjltRJXdgS?=
 =?us-ascii?Q?Pzaua1N9NDT5/F64cJnxI4UoC0hn7LRrkF51ueNL0nmZ9HHxTKV5oBmXdHH9?=
 =?us-ascii?Q?ZdM+90vvuOCWv5AwgQiSQwTcx+1XwHX2RjFEycEHFmHLlSgqh3XUjJhyPL83?=
 =?us-ascii?Q?bRzqEXBl3aqGN8H9wiTC/9qYjeo+3mtCHsuLuyyPXi+t47ib2msNYLVoEDtj?=
 =?us-ascii?Q?x9fRtCkBn6LoFcReCcu/TJFdX++GmgxfOgek9qWLE5nWHrtOVSr98AUchLPv?=
 =?us-ascii?Q?yMIxTVri7Lje9VfWeFUSUdmppJZpY3vVVyBm7uH1/tiIY9/vkoafyXJVD+xt?=
 =?us-ascii?Q?Tkz4gxe7Jq9NFMjHdxw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:03:09.9344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524f353c-77c2-4530-584e-08de22ce2441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE4FC9FAB3

Couple of independent fixes:
1. Wire in SIGSEGV handler that terminates the test with a failure code.
2. Use "--lock-cgroup" instead of "-g"; "-g" was proposed but never
   merged. See commit 4d1792d0a256 ("perf lock contention: Add
   --lock-cgroup option").
3. Call cleanup() on every normal exit so trap_cleanup() doesn't mistake
   it for an unexpected signal and emit a false-negative "Unexpected
   signal in main" message.

Before patch:
  # ./perf test -vv "lock contention"
   85: kernel lock contention analysis test:
  --- start ---
  test child forked, pid 610711
  Testing perf lock record and perf lock contention
  Testing perf lock contention --use-bpf
  Testing perf lock record and perf lock contention at the same time
  Testing perf lock contention --threads
  Testing perf lock contention --lock-addr
  Testing perf lock contention --lock-cgroup
  Unexpected signal in test_aggr_cgroup
  ---- end(0) ----
   85: kernel lock contention analysis test                            : Ok

After patch:
  # ./perf test -vv "lock contention"
   85: kernel lock contention analysis test:
  --- start ---
  test child forked, pid 602637
  Testing perf lock record and perf lock contention
  Testing perf lock contention --use-bpf
  Testing perf lock record and perf lock contention at the same time
  Testing perf lock contention --threads
  Testing perf lock contention --lock-addr
  Testing perf lock contention --lock-cgroup
  Testing perf lock contention --type-filter (w/ spinlock)
  Testing perf lock contention --lock-filter (w/ tasklist_lock)
  Testing perf lock contention --callstack-filter (w/ unix_stream)
  [Skip] Could not find 'unix_stream'
  Testing perf lock contention --callstack-filter with task aggregation
  [Skip] Could not find 'unix_stream'
  Testing perf lock contention --cgroup-filter
  Testing perf lock contention CSV output
  ---- end(0) ----
   85: kernel lock contention analysis test                            : Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/tests/shell/lock_contention.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 7248a74ca2a3..6dd90519f45c 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -13,15 +13,18 @@ cleanup() {
 	rm -f ${perfdata}
 	rm -f ${result}
 	rm -f ${errout}
-	trap - EXIT TERM INT
+	trap - EXIT TERM INT ERR
 }
 
 trap_cleanup() {
+	if (( $? == 139 )); then #SIGSEGV
+		err=1
+	fi
 	echo "Unexpected signal in ${FUNCNAME[1]}"
 	cleanup
 	exit ${err}
 }
-trap trap_cleanup EXIT TERM INT
+trap trap_cleanup EXIT TERM INT ERR
 
 check() {
 	if [ "$(id -u)" != 0 ]; then
@@ -145,7 +148,7 @@ test_aggr_cgroup()
 	fi
 
 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -g -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b --lock-cgroup -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
 		err=1
@@ -271,7 +274,7 @@ test_cgroup_filter()
 		return
 	fi
 
-	perf lock con -a -b -g -E 1 -F wait_total -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b --lock-cgroup -E 1 -F wait_total -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a cgroup result:" "$(cat "${result}")"
 		err=1
@@ -279,7 +282,7 @@ test_cgroup_filter()
 	fi
 
 	cgroup=$(cat "${result}" | awk '{ print $3 }')
-	perf lock con -a -b -g -E 1 -G "${cgroup}" -q -- perf bench sched messaging -p > /dev/null 2> ${result}
+	perf lock con -a -b --lock-cgroup -E 1 -G "${cgroup}" -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a result with cgroup filter:" "$(cat "${cgroup}")"
 		err=1
@@ -338,4 +341,5 @@ test_aggr_task_stack_filter
 test_cgroup_filter
 test_csv_output
 
+cleanup
 exit ${err}
-- 
2.51.0

