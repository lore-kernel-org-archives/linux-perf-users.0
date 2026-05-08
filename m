Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D13502A5;
	Fri,  8 May 2026 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220055; cv=fail; b=RfXEnVMZtVtYoGCfcOlOLWL9JkUboOg2mTZI3/D/hhixYVAV/99phtRbjzMcm2p4IHyNvqmki7DpAEPClt7nEajjg3NMzWrP9ijvHiI84/zNlzgNAVJB4Cf+vGRNF8wdBwtM+mBALjUFsCoetrtIGBQMq3fLQjtrQMM/pDT/S8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220055; c=relaxed/simple;
	bh=vw+JoRBJ5/8OQRTs2E72bXir0o3RdgYAMXIUupf7AG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNvCNQf8TXDEqjzEEJWGNrwcAl084ihrcDcZFa8h2ZOFM5YROc4XByKBqRjuqz23reE6LLoIJYWmThXhweirW1cUuV7uMvTJiy1pcAnVmUQsAT72BuPUDFmyu01SnPAJNoPjUVdn7rdjmBstBw05De89zfZCf53Ra+O0C51AFoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ExXYOWS9; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ExXYOWS9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cC0ngIawoOX5Yc2iIdAdxlDT0dtnM3Q2BTXj6Dfhgg0qMjnxvqWKxwY2UMdrD01ezNW8NmuwLHyu7AbMJSd6ot0lYCNXjBE3PLii4mHiYe9NdlI1VOgGYtaeos6sVsus5qlIB/65K5Or5/ZPgG5wlfxH7i7BQF9R98PaG44T0bJ/hc5prCiLFOe42hmHPdcRBHFdHKVImiHH5vtNOBN11ugxRtDqgWRpjBVLmf8/yvw4Mk7HVtqTDf0ngt7Le57UDCvwX0x45RJk3HQY5QKzi+EttAy3UdrAh2+zrIAcQ///PC9IUUq2MN5r2GVPzQaMvUEx88YGuu/8LmHIi5bcJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3BgdtCx9dRDV1lta9WEP0kgVsnDW7FYnNJ5/ViNT/8=;
 b=MA4I116l0CGARimluL0ReN0s3Uwe0IqOy+gykB6QhyFBt1ff/M2j3NA6y1dfI63tFYPxwIxdEZTiACdFKhEOC/89ZKlEqfp95k5al0aN2soABIBHmYqGuZkBO7gHJ2HaFP6vXqBCke8KLV/gWwCzLRLFb5SzoK0v7BHIABFNCr8n2Sngq337nk4Hky1+gO/Nxr9+3cbPZvofvtuqq/tJId+fqrxUYC72LN58GOClvFxlWa9EMIYUmYgmHWRmTtB6VACcpOS13/ln/iBFARS1ePKTxZsR/CRyGQaoCVtSQWY5ps032OT1ZTSyFlnxhMrMEJxSHUO2wMQG/NfWjXmaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3BgdtCx9dRDV1lta9WEP0kgVsnDW7FYnNJ5/ViNT/8=;
 b=ExXYOWS9V0brYj/f7oUEQqLWIBObm0AwJR7nLuf5PzP+5lva6DPGGDWgDHt3shNzICpdF9FtjFOWbMzPdrjfQYTiKLW933Uv1u1FsOzv/VHcYHejGueQ+UF+W3BfGpzwGqiMgOrHtamqocg+MUjG6bVujSxIRIc1rcN0rrGsoIE=
Received: from SJ0PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:33f::25)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 06:00:37 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::10) by SJ0PR05CA0050.outlook.office365.com
 (2603:10b6:a03:33f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.6 via Frontend Transport; Fri, 8
 May 2026 06:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:00:36 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 01:00:30 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v3 3/8] perf test ibs: Skip privilege test on Zen6 and newer platforms
Date: Fri, 8 May 2026 05:59:59 +0000
Message-ID: <20260508060004.2575-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508060004.2575-1-ravi.bangoria@amd.com>
References: <20260508060004.2575-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bca0e40-bd88-45ea-06c7-08deacc72008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	c/Mj2sI7gKDth/as0n7PVk3LZOwqCKP3t/iFcNJPkVR/0RxC/VsarPD9gbH4pvKY9xg5XnbY0HGjP70YPTqF+s3RwKAT+9dDaHprEYAHr1abARkhnaBR7TH7Y7TBLpXtfh4IVFcZRNR+DG7HtQ3Z4P4IdXzUsdk8AbfhQeHuVl7JbpJxqQc0WR1HoZfVcSDSyJsYS+7r03C35z4MKYM0oTGIzbuCqY+luSIxYH7ANBFAKLQUTvJwdM5+sjuFI5ijmdeGeoc090eMAQcH7l1SdzGMWIzc/Hj1QTQI6F5DNi5WScGyarYe+VNJOw/RzgUvrhmpUp0BcAJty/LI4buUbyzAA+nGYr4FBuMZ6XiNo9wzX8Gcee7/sqAbJA1SLU8UF21S9fzXwsk3hoWuQxk6U8q6ucxcldBB7v24nH334cIqFyrr1het7y1n2LCHGAcYJkCQGaWV4m968HxJeffm1gRAiasvIl4kL6tpBfi6TYtIb/ovsvDuV+h6SIFYivULWiT64szlIVhIIQuQx1nHQal/rXmBevqcnNTWKNbYvLUekqMG1UHTor9BkWG1/sHxIQMEZ6b/Prglv+CrdU25VNNzzUBpHk+ic0PcQXI3MgXU1njcMU64jpZoR33kJvx3EVJdu2X40TlHP3PYFy0YTnA+qNhngUgktvl7zYNkMfgCdpLtCy+WkAGbN6CJXXJ6Sf0KzYezkhPhOwE5t8OUQrOsEFuPQv6NO3rbs8kWHGA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D7TZHANhUxODsa1NcEhqAZS7VbMgAUbmtJ1GnQCQZ3lV9TLSJE9TzQZJ6PbFxfH1sPaE5AkudW6hItme1hhl5PnwgjYi1LG36ba8zRxPEypAUc7wVUmr1w2Fj8SnYxJrgJZdqUQ919EnV7caM1Ct+2ty4YA48TY12+xrHGoeT9Hxebdr+kKslURV7jvfG19XUYPqp6GfF3KFz+Q5vbID0K74/P+gVZ4CgKUNF/573xENtxrPcY9MR6JEBfcmmvJbhO0m+OPiDthd1ffu0TLD9nu5hlDpf+bQuk7dp34Q+yJlomto2qtNRdDolC1cYLk6o/ucUlSq89pba40tlJpRSgHi9+GsfPAu/pz1RTBERjoB1QxCxGqbXGxxpbJ4QManyVU2U+FQnqEJWpA8ydGoTy+ACvaDG1E3TSBirrbyo+YAKQfG6Vo7NWQXSf5l+E4P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:00:36.7948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bca0e40-bd88-45ea-06c7-08deacc72008
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167

IBS on pre-Zen6 platforms lacked a hardware privilege filter, so the
kernel enabled swfilt=1. Zen6 and newer platforms provides privilege
filtering via the RIP[63] bit, making swfilt redundant. Skip the perf
unit test that assumes IBS has no hardware-assisted privilege filter
on Zen6 and newer platforms.

swfilt is ignored by kernel on platforms that support RIP[63] bit filter
i.e. all amd-ibs-swfilt.sh tests will test hardware assisted privilege
filter.

Without the patch on Zen6:

  # sudo ./perf test -vv 77
   77: AMD IBS software filtering:
  --- start ---
  test child forked, pid 30813
  check availability of IBS swfilt
  run perf record with modifier and swfilt
  [FAIL] IBS PMU should not accept exclude_kernel
  ---- end(-1) ----
   77: AMD IBS software filtering                            : FAILED!

With the patch:

  # ./perf test -vv 77
   77: AMD IBS software filtering:
  --- start ---
  test child forked, pid 30903
  check availability of IBS swfilt
  run perf record with modifier and swfilt
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  check number of samples with swfilt
  [ perf record: Woken up 4 times to write data ]
  [ perf record: Captured and wrote 0.051 MB - ]
  [ perf record: Woken up 4 times to write data ]
  [ perf record: Captured and wrote 0.063 MB - ]
  ---- end(0) ----
   77: AMD IBS software filtering                            : Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/tests/shell/amd-ibs-swfilt.sh | 37 +++++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
index e7f66df05c4b..e3738436773e 100755
--- a/tools/perf/tests/shell/amd-ibs-swfilt.sh
+++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
@@ -1,6 +1,33 @@
 #!/bin/bash
 # AMD IBS software filtering
 
+cpu_family() {
+    grep -m1 '^cpu family[[:space:]]*:' /proc/cpuinfo \
+        | awk -F: '{gsub(/^[ \t]+/, "", $2); print $2}'
+}
+
+cpu_model() {
+    grep -m1 '^model[[:space:]]*:' /proc/cpuinfo \
+        | awk -F: '{gsub(/^[ \t]+/, "", $2); print $2}'
+}
+
+# IBS PMUs does not advertize privilege filtering capability. Rely
+# on Family / Model check.
+hw_priv_filter_supported() {
+    family=$(cpu_family)
+    model=$(cpu_model)
+
+    if (( family > 0x1a )) ||
+       { (( family == 0x1a )) &&
+         { { (( model >= 0x50 && model <= 0x5f )) ||
+             (( model >= 0x80 && model <= 0xaf )) ||
+             (( model >= 0xc0 && model <= 0xcf )); }; }; }; then
+        return 0 # True
+    else
+        return 1 # False
+    fi
+}
+
 ParanoidAndNotRoot() {
   [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
 }
@@ -23,10 +50,12 @@ echo "run perf record with modifier and swfilt"
 err=0
 
 # setting any modifiers should fail
-perf record -B -e ibs_op//u -o /dev/null true 2> /dev/null
-if [ $? -eq 0 ]; then
-    echo "[FAIL] IBS PMU should not accept exclude_kernel"
-    exit 1
+if ! hw_priv_filter_supported; then
+    perf record -B -e ibs_op//u -o /dev/null true 2> /dev/null
+    if [ $? -eq 0 ]; then
+        echo "[FAIL] IBS PMU should not accept exclude_kernel"
+        exit 1
+    fi
 fi
 
 # setting it with swfilt should be fine
-- 
2.43.0

