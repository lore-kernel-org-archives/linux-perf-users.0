Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808518;
	b=oRV1u5rFjUKQFP0W7CNP4WzvRYT/yauptdcOo8T/5HZYoTY9k0YcF11scE97WuYcZ9/H
	 mwEomlWqitqrPKn6scnJQeGb7FEcsKvXqPtpwWaM4vOz8S51+M9AnNu5JJozStYW7Tso6
	 BJnhdHn6lOda7seB2Igi26UCXrWOmhrCbCabo3fbuol4geDZZDeqokSRDy3RJbWuuKuA6
	 NJpQBeUVkE5tvkQRRYs4NyhefwyTc8erqTIRIGth5+5O9uPt3VUKrLbguCIi6S591sY5j
	 OJVqBn6mg39LpzRl2/binGB8+3GTYdjcpEe7n/5Fh4oeIcLQAwYyUXr5r/MTZb5MVTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808518;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oMLcEwVO2df24OivEvid9p5dhun6r6sEcWy/p87BTaQ=;
	b=lK4aljg6qxOZJXK9WydOu5UeJhY85RedxoTc5O4vGzuO87vb9d2FLs8DlARYZC88yEsg
	 rQXSBKdQ/uJI9BlyILLI+FLIkYjhWNj+PUk2dhbR0Fg5jle6FomNyaID2eZddCmqIDwm/
	 6NfSQh+drTqj3lYb12HiuXE7RdtinBNhrliG3pOaO2QsDDROKuLWAhQNhYCtf2ASvrBVo
	 6TeuEUjlzzeyeV2RO6+ymxj2/Mu+aYsiZFkwg+3eTZ4XR657utZ1YggZ+3iQYDNQSSztn
	 +5DjUmeDQlhJDwxSDWhfIYn60DsU3FAtRFcYQXewJIvlajg0GOIK/XpRIXBcuQcC7iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fCFSgl1g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.48
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA1606A31B;
	Wed,  4 Nov 2026 16:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24EA1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fCFSgl1g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ2xzvshGF3LfbMICWlr5pejgbuscs0nSK6uSrX9uzYEjXDImZOh1mzjlNi3T3P3eWuSXoEqfxGpO766+Jf+pOYuxH8jBIMQffXQYON2J05wAg+B3rMLhUBdc1cNZMTQ0jMonwphkV+M4tlkQ1bnScb+XxCZog9iSNdxNX0RCAllsvpdoiyJfb9qr9+/JqN+ZT/Ih8Dp8Q3l+g7VqHf0IEedaZx4NizAMF9juZyahpYNKHMfsyA86gw9Kc0JCU2+jZLihDvV8N8r3vdxnw9Ae1YeDZYmHxka58F3UcUga2AC8CRJqaLcW8z0wVZazEXXpK+hEas2Jst0CYpcT+hBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMLcEwVO2df24OivEvid9p5dhun6r6sEcWy/p87BTaQ=;
 b=hZFe7kgUKPioaCcYBsvliOeLNjy6DQeS9P+wzJJ0FdGQ0nuYnjJKdl7wk2h0iaci/CJ8h5UiE9Br5Pxq6fAWd7YHX50ve5cZ+1L4MtJ6wFtmmuIZSh8/SzSuc5KPHY91UBZ/zpqf1CoAT0YGuhkiNMhRxngks3UDv3A2OOHveQ7WKoAxmjOgcu3ly1z5KQ4C5XB0/PFZlR1DI1LBKu/AJit4khnNf4ddVaDlvwzLHDc8R0nzvUo77/F/ltCTB3Nt8Nfjx2gauJ3AvcahJkuQZ38yOqNjGAWNMZMk6AOomxG4sYOkgUTTMdQ4gN76kkvS4qZyihCB3H9g7k/awu0zSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMLcEwVO2df24OivEvid9p5dhun6r6sEcWy/p87BTaQ=;
 b=fCFSgl1gY9WY0BuvjDtYdhmgdp69U4u3fzQogzjZJDvc6o0D0/dV8OSbVcnrbHXTXMp18JdFZOmji5daOw5MUTfeFQMPdTc+w+bxmTtwVQX/9iYvmjXzK+Rx6Q1j39FtxU2BeShWmVlUXFTgd1Sd+w0EbEnLMyxNN1l9RwMkJXaoV8QqmfSmJ6ugucCzd4I27VRhVaXwUng3oWnmRv4/LtBrQtMG8jWAAXSZzaDwqvcMMVJVxqUjbW9p7qgSVDKfZtQf/HPCKA2+0iC7VoVqqRHQ+c3TJ/ok8XyiV1fOuel5kVLUjS5FbBbO0ymE5OKgVdn57BEfTLpiCBqC7UBzYg==
Received: from CH0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:610:11a::12)
 by DS6PR12MB140904.namprd12.prod.outlook.com (2603:10b6:8:4f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:08:32 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::7) by CH0PR03CA0355.outlook.office365.com
 (2603:10b6:610:11a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 16:08:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 16:08:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:08:07 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 08:08:06 -0800
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via
 Frontend Transport; Wed, 4 Nov 2026 08:08:05 -0800
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<ctshao@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vsethi@nvidia.com>, <rwiley@nvidia.com>, <skelley@nvidia.com>,
	<mochs@nvidia.com>, <rajjoshi@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <john.garry@linux.dev>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v3 6/7] perf stat: Check merged PMU instance's cpumasks when skipping zero counts
Date: Wed, 4 Nov 2026 16:07:15 +0000
Message-ID: <20261104160716.2910873-7-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104160716.2910873-1-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|DS6PR12MB140904:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a2f5f7-6a2d-4920-89c8-08df3a8ddf9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700016|376014|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|3023799007|56012099006|11063799006|5023799004|261102123227099003|261009223027099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	YeqSk/F5OEJH0O+j9Ly8R+og3iA89m50ahoEZItStfuwapeyPOHvxcC+tbltY66Go8DRIAfYenYZnankTy3UeCmJaqi8Litmb5qQf7XWX47puSL+Hp0NmgGAUtZqt5692UDvRPFM9254opz3+3QyzG8isIdlI7Nqh7VyqEQaz9wVbFop+1N0+Z2rD6BuTEpgwL3Wt6H8aAsD1uxhXTfbGWpCeD1T18PVIm287tksOHusora806+VIG9w9m2GMn3rEtOiADtuF0HN8pzGynTTwYSJaMssjGAa4jOQiI643EbZ61hOgzAvLIy40q1n/LqRVl/wYuVBVf/869tx275xB10E3YWGZZjHl9dbc2Ijx7B9XPFu2m2gfrsFr7kv5Pmz+7zm5MQKibcipiZDCmG/KeBLLKYrVOr+Qg9Nr7fG+wnwAs3baY1NSqGZLrWNBelrvo0MW7fbKZeDPJygXrCBp34ik/pSgMoFSxTI900EluHxhDaDr44DWkvfqNqmoXH+gVYUJoLVlgLaiqN6khh8pBPeI+RLCU6yaAO8W2IIPG3sJWfieUjXiekeBJ4drF2+M/PWXZk5D3yrZ3m/NoCL/fxBO4p9U/YcWbnxPPnsk0n8cuxRZwb5kfsHdkOmr1NIAR7bHvDAoRQYM+Sh0Mk8mp8z4albX2xLR3vud8UZBGKUcc9vcEjMR4lsSDLyrmusUko157AdXhwl5GqUu0hxhg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(5023799004)(261102123227099003)(261009223027099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tcNOqrHrydPih5zsLTYTjP6NLlFUDW5Dr41WiuM/PIuSdAF6tN3W0eu6gCjrDQVIZHCJbzZ0y381ZbWJjZzVv+oMIUSpOP8tI0Y7t2aJpyU76VAj5aexklYEnbn1jS+PCOymPxHEm+/yPqOZ0Y5DCc2rCNCInEQ4tNjwtKt1TSI/Eh/rA2L3QcVUS2+v+rMmmolGf/EVktG0TaFaIG6XGu2tXURI3rIX0O1wkB9HDfhDkGhmhSQbA9Azjv/+GwY4fHIc8VkacRsWL+nQaaXlPPyXhP9eLpqwpyP9VTOHSPO4lr5fMQ2+vwwSzgQY6d2fj5SrdY9O9Ko3MZQZopy2Q2/etqEWpTize26/KZ/zBZ6EZnZtEeM0M4ICDC6HSoEBWfN666QuSinqzlvvtYO1ls5NFjxaQcPXog5qkryLED1wb1b22qNMABPvAS9RgxhE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:08:32.4934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a2f5f7-6a2d-4920-89c8-08df3a8ddf9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB140904

Commit dd15480a3d67 ("perf stat: Hide invalid uncore event output for
aggr mode") hides a 0 count of an uncore event in an aggregation id
that the event is not counted in, using the event's cpumask. When an
uncore event has more than one PMU instance, the evsels of the other
instances are merged into the evsel of the first one, and only the
cpumask of the first instance is checked. A 0 count in an aggregation
id covered only by another instance is then hidden, while a non-zero
count in the same id is printed.

For example, on a dual-socket NVIDIA Tegra410 with one UCF PMU per
socket (nvidia_ucf_pmu_0 on CPU 0, nvidia_ucf_pmu_1 on CPU 88):

Before:
  $ perf stat -a --per-socket -e UCF_SLC_ACCESS_ATOMIC,UCF_SLC_ACCESS_RD -- sleep 1
  S268435456    1                  0      UCF_SLC_ACCESS_ATOMIC
  S268435456    1          3,407,373      UCF_SLC_ACCESS_RD
  S285212672    1          2,086,640      UCF_SLC_ACCESS_RD

After:
  $ perf stat -a --per-socket -e UCF_SLC_ACCESS_ATOMIC,UCF_SLC_ACCESS_RD -- sleep 1
  S268435456    1                  0      UCF_SLC_ACCESS_ATOMIC
  S268435456    1          2,669,279      UCF_SLC_ACCESS_RD
  S285212672    1                  0      UCF_SLC_ACCESS_ATOMIC
  S285212672    1          1,006,579      UCF_SLC_ACCESS_RD

Also check the cpumasks of the evsels merged into the counter. Zero
counts are still hidden in aggregation ids that none of the instances
count in, such as the other cores in --per-core mode. Core PMUs and
--no-aggr output are unchanged.

Fixes: dd15480a3d67 ("perf stat: Hide invalid uncore event output for aggr mode")
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 tools/perf/util/stat-display.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b337cc23f413..493ed6c88685 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -894,6 +894,7 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 				     struct evsel *counter,
 				     const struct aggr_cpu_id *id)
 {
+	struct evsel *alias;
 	struct perf_cpu cpu;
 	unsigned int idx;
 
@@ -946,6 +947,25 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 		if (aggr_cpu_id__equal(id, &own_id))
 			return false;
 	}
+
+	if (config->aggr_mode == AGGR_NONE || !counter->pmu || counter->pmu->is_core)
+		return true;
+
+	/*
+	 * A merged uncore counter also counts on the CPUs of the other PMU
+	 * instances merged into it, for example on another socket.
+	 */
+	evlist__for_each_entry(counter->evlist, alias) {
+		if (alias->first_wildcard_match != counter)
+			continue;
+
+		perf_cpu_map__for_each_cpu(cpu, idx, alias->core.cpus) {
+			struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
+
+			if (aggr_cpu_id__equal(id, &own_id))
+				return false;
+		}
+	}
 	return true;
 }
 
-- 
2.43.0

