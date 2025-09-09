Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2127.outbound.protection.outlook.com [40.107.94.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B022173D;
	Tue,  9 Sep 2025 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451704; cv=fail; b=cThQyOb9IoxMuzqb4PWbX34xTyzUhPSzLnGexSujqgX3306h+TJwHTJ949TOQWsb/umW/27LE8LuRlm/5gsFUBI+u2dCNDB2Bnv188BKGW//IoubfuvTu0BDuiV8tFzVhi7RrwAS8Eiu/q38lmUrHyxrYwuaG6mHUO2jxYZxoPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451704; c=relaxed/simple;
	bh=Po1t/7a7g2Ku1iPCD2sshKvSOdnab4DyrfbZ8M3QBd4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NQF5gc/nOzTM3bzPx9dgkzge5lGFeUoOmlFIGTya5rESFM7hGKVk7+8ELY5A98aHOcA11En3mw3OZk6NN6+ooKam4h/F7adwYU7DZHthcpiZsS2kfSofiuWLjhnIB5ATjuKGnsDKawz/c5VjeaD5MTp2KPteg5v7ljsSVnTtoj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=v2lK9Mex; arc=fail smtp.client-ip=40.107.94.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="v2lK9Mex"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bi11EtFE4lVqStc9QzcOOF3jMIAlCZYSCAO5kH8ddyCR+2MKswIv0Om6CL9naXOg/BWOhOSqcwV+NSeJ7VdGf0OaEF6UvPP8fvkhwqc/xYsRjkknZ8N8rSeBqhWhasGuklvJ+5I+E2lwxpKO+wOK0KYMij7qMbiyX7n6b2a1AfTcczOMCHvAL16cN36CU7PSNN7psft2bkpSK3SEn6MI6nn5MG6BA2o12T2RZDYmy8dgdLk9tPlumURLCSM/tpoM/9kCMMeHvIKD9aN0dx4mNnogQ3W13b+e4ykPYiZpM2w4y10r8AQj3xzNVuxpEuVPZIw6wv75E6om8IMyzvtrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJsmgd6XqU5+V3aO6IPPySNCZETtyS/JLPHM13pOQnQ=;
 b=fEYK/hkSmUTnMnemNVnJWVMcEyho5+H3GCmEZLtKPrBMHuIUS2qPZmeW6kJ6PD1gW/yInI8Bjp5DfxRSfQdV3YFgiZDBKxzpLG3rrL8SdqxlIBnQbmUI8Mhy3+I7NFDqrk0PDM/ImPj6JEtMHSqfvNBsjIRyPAJMccxHYiGu4iePconv0RSq8uDmk71WEapNKUMyiy9D+/UlWcJpnwkYsr2Q/aRQY8T8SkmuUtwopA+DGf4sPbkOdsbKuB8p9WIJSA1bh5LX7SvjJdIiuUJ0nN5eB7Hnyd6lQ/5BOZ+MZUqgPeY5n/kaj9yGmOeRUzw23eAtJ/4+JYK4sDdHbuayHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJsmgd6XqU5+V3aO6IPPySNCZETtyS/JLPHM13pOQnQ=;
 b=v2lK9MexfYRSbzo4hxOVgi8asNxGzOACsSBmfQ5fM55P4XUAZnA1XXVquu4btAcDAs28jcJMZ55AIGMn/qGASos4NqFX7CPi04EaETESJbMBALDwIviGlKK8vF9POz8MP3k2UI2UTsULTGcJ0D3Mp/JH+uQIMSOr0pNTbXD+JeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CO1PR01MB8865.prod.exchangelabs.com (2603:10b6:303:275::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 21:01:37 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 21:01:36 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf vendor events arm64 AmpereOneX: Fix typo - should be l1d_cache_access_prefetches
Date: Tue,  9 Sep 2025 14:01:20 -0700
Message-ID: <20250909210120.9823-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:930:a3::7) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CO1PR01MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: b92495e4-e9c8-4aea-21ee-08ddefe4109e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8935EYn4Hp3UlFocwnSJ3b/hSOMBJl+iDZCm3QaawsPvaH4/k6QkCaKrfAcx?=
 =?us-ascii?Q?p6Oqd7DxE8ox+tuXNeG1scYpao+lyuU9F6M+OoYIrUTU6i2T8OdPEpy4ilnx?=
 =?us-ascii?Q?yt/UnP7LV+xjrI3BGqAkLgBYdcKhybNipsDiHDEL17oU2+vKgTMFeEBZl8cs?=
 =?us-ascii?Q?Pwncbs2UYsQ6y6UEJ0caFOJlN0/NDqsDbtZRBC0dkZfZndXQzFkKc70WUJhc?=
 =?us-ascii?Q?xAwrKfFuZkS0i5DYQR6S7Forj9Pro6VcYHKuNVQua5QfDyreem2gTNd6yfp2?=
 =?us-ascii?Q?gKnzfmEx0f7slZeyNZL9gjlNXb/8BsdmHsjz3fpCirnFeqk0zJh9fhTbCD57?=
 =?us-ascii?Q?yh6FL9hcSH5Ih42CfUXED5I+DjRe0/TREbQCMob0dAkXTHvPPnZ2v76VPdK2?=
 =?us-ascii?Q?gIDuhGQmglRvh/YK+YumfzTPZnR6jEuJIF5ooNEV4bY5K0QjyG4Cb9G0PaxA?=
 =?us-ascii?Q?lSthDOAj8qtlDMxE9eWUFZQei5PwDu0sB2R3bnOHdTWThypZtggVBp7JTF2Z?=
 =?us-ascii?Q?G+7j2Z4umnZeNGVw52soIotU2ayOFWWL+gj3VHRLdicPUIwI7Xsd583psiXt?=
 =?us-ascii?Q?bIlOoOmBdfrQmz/qm4fxByGc5CLqI5CSLJsSRsF7A/MPT6pFzcY/m21ziBnF?=
 =?us-ascii?Q?q+1vUkeMCByvou2SG6nzmRdZN+RCmWDL9PQDtfLgRr0KLq8ij3/YT0evybv7?=
 =?us-ascii?Q?rh8eEiZ+DO3DR4N6vZdpNuDitjXhwh/s/PJuflE0Y4PQRPvy8qY5f4iqR5eU?=
 =?us-ascii?Q?YiYl3FlAQcPJgGYqp32Uua97ZGwf4z/JTDHolpGmsaUFCqNgTLYGhuFZMe/C?=
 =?us-ascii?Q?GRPgvGI+ICTwAcUrksyiWgpRhqTOqTZMyb5Hc+Y99aojj/zMJCMf6f4EEJrf?=
 =?us-ascii?Q?RK0fy9aCWLJYXmzc+w2jGFKFFtltGfwwBqUpB4iloNGXula36KOJJdbW6w5F?=
 =?us-ascii?Q?Aa2MClLWm3EedWzJF7IsWlH4RlLeD57JoThhB29FbQNdXMPp4Xhu3sSeAh75?=
 =?us-ascii?Q?cbhv7bc+sDxfdK+FMDi9nJGOTFreuXzbl63dkLVTLeyfMheWGYys2vjZ3kEH?=
 =?us-ascii?Q?jIdsSyrI5k8XAJ7pXkGhHBKv6VUYpS9GS//30jhoU5G3eZI2bPO15z6nOc/O?=
 =?us-ascii?Q?VJeSEHGt0yRQil05zgOGgegrQgnlnwxUehgZZm4vnT8bgqIq3LrikvN4CKvG?=
 =?us-ascii?Q?JQaNHBZhatoEz1ltQzAaVxWWV/puJYY8LlNS+yN1dgiwHiD7UBnY2+VVlcxU?=
 =?us-ascii?Q?m95NwWE3C2VsCWmQ/+RN2IAT9lw1Ikk6ooFwQEDSA3ezQRbs6+77qLcUuRrq?=
 =?us-ascii?Q?/JmmLDsmrLib/CqTFSobhFb1JzyFpSXo1hzR/y0cotSpkR2je3EXFq0knNZJ?=
 =?us-ascii?Q?efLe6CLTv5Pclsc1Hqp5gz5Wj/CV2t0RSf7WlqrW0vslD7sj0ScFy+d3IlRK?=
 =?us-ascii?Q?OcgJi3MNK2KX1JfiRkI393b2MqwBEPMZbzhXFxN0gds8UQZOnyD/9nhq4ac+?=
 =?us-ascii?Q?EeWgU96l+zJyRGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yEArb32cWfyopqoWtnPw7YB6I0MuYW6jCCI81tKR51d76mWayVQYymBn8Gqw?=
 =?us-ascii?Q?ihJlM7EzTLHHhILeRgbywRMYYByvlwB7mN4FEj30tqdtih7IzKWZxy1bKzm/?=
 =?us-ascii?Q?9dRuqNze/JLyop4+kzC+SggE4n+Gt/RxO/fMJTvIdo9NacGGcC21Bsjf5FNT?=
 =?us-ascii?Q?DkntypKrHAQ/CFtmAw0lWYsmfNtKdLlFVe5cdQZeeB4VzxSMItvc/SMJioRF?=
 =?us-ascii?Q?P/jsG19zH58F8aszfZ+O9YC97rMmLAgMdksuVhAz8ZYQXLMPR6FKrdaPyQMk?=
 =?us-ascii?Q?C1abzenTrlp4RtXdXhxfM7glRhW7Efo473FfF2wc3lPpkNYE6+VffzTSgTIX?=
 =?us-ascii?Q?R7h3RKpA+WjEXE/e6EeScIV/JkOfdDyZgvrnrAQyeTNl4EJNm+FZ44a2mRKI?=
 =?us-ascii?Q?jfkI0ww2pB4uQq2BGP5JwDHCUhToDaUyMZBumG7ikJk+EIoD4BRyUy74OgMo?=
 =?us-ascii?Q?OSvI55XLQdeGUB6gFsN3l7zXpaatDd++I5uUW7LVZIb8HreGCcZgyChbRyro?=
 =?us-ascii?Q?ChEyrk9Wn8OoJ3FDQg39L9nRKa3BIgAoh4wL8uBemEfKjJuIDpZWvXfjU5GZ?=
 =?us-ascii?Q?snRqIvzQxa+4xClyVVRkbRTWYD4ZHvKkL1+GhL5Bk9reImPYdYaDe1VeO7QV?=
 =?us-ascii?Q?joUQREFIBw2YpiSbLqz105DRyD2iCUmEby7nVWqGe97mdhX+NtV9xFeSorK6?=
 =?us-ascii?Q?Z4sKq8pry0HYGgNfipGsX74fQPUMAZYEtxyP9hRQuyx5d/YAHhdLDRgI4xQi?=
 =?us-ascii?Q?LQG6T4+0Bq+o5ZuYZDJytpBO21VJa2p2/QltHu5vAzFJ2RuONtw77i7RiN5l?=
 =?us-ascii?Q?nR10ai0YRIlB+0+dB+lFyg/QVWo2GPmmgGRnWZQ3pXq071CNIE076pYDzPZM?=
 =?us-ascii?Q?sYLs1QFTvAWZOhNzj++l2oCirMSZ9WYL3okwCm6aQkorpW/Rs2TcVgaW/Z1u?=
 =?us-ascii?Q?6z07E0wxf1Q3AXJaTAlVv73eXw59H8LAO63K6OEcVlOB6CCxofHIx8Tk6khA?=
 =?us-ascii?Q?LSJiqhjDK7pI5QfcRbxCyeVsd2yi8F5lk8iFJ7Mj5hQqe9zk6Ywm1Z+Z5+/0?=
 =?us-ascii?Q?vQcVMlm4vaYmhzUeSmLf5UikQcWrqgZFMDEXEHXlQgm44f7yCG+ox3fUbZgW?=
 =?us-ascii?Q?p5Bd3h9B7obdqBQjJzHZHDZ1Z5kTeKxv6gvKn92dtLaPxUgwPVAHH1H4y/NU?=
 =?us-ascii?Q?6X9kIKFnmMQbNbMSdyVCP99rBttzen/ePhFUX4vBLdlRYBH1/mIOYjq5cFkR?=
 =?us-ascii?Q?JMFZQoHVGYnRsEkOa7XiNhhlA6ZP2OaoN3rez8IjFG1NggzPVXB5D/i02ApR?=
 =?us-ascii?Q?gEYjA+wzgQ/+NblZuLCbwlpG89NzOpr2DzFcBClCsMBPjzrP4wdfT3g7Je/X?=
 =?us-ascii?Q?T16LtKS17lkOlq+K4acQo1bAUHWyqafWgVSVK1DWuxrXI0ur0ImVblpD2Z0/?=
 =?us-ascii?Q?rI+vo0QdBSmMde/eZe+/5+K15kWwcPIODRhykZoXR+ZMOUZdAxQFV1poJY5J?=
 =?us-ascii?Q?xdQw6wO3E1g2DtPCmPcNn/Cf/ctlkAD8/b0UGnhn5/OX+X58Si/zZ7Xbb1r1?=
 =?us-ascii?Q?la+y1LNKLkhTdXZ6tRQJBJ1UkhnUYDqSGQJCJgx0JdBIvE1D9uJ+7uzJdZPW?=
 =?us-ascii?Q?0lRMfvLS6PIg4JNq6tM/6sU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92495e4-e9c8-4aea-21ee-08ddefe4109e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 21:01:36.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAhuY3KAGPwcVgAbDIjpHOaD+pvG+/KoaWgsbBBNwos2pVC7+sKhgJISdpIqZehQ8WHg6J91zBBu5yc6tnBHO7YsPgcd9eAp8yeudrIB+lhnBbxGozlRe6XSCVisNayD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8865

Add missing 'h' to l1d_cache_access_prefetces

Also fix a couple of typos and use consistent term in brief descriptions

Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
index 5228f94a793f..6817cac149e0 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
@@ -113,7 +113,7 @@
     {
         "MetricName": "load_store_spec_rate",
         "MetricExpr": "LDST_SPEC / INST_SPEC",
-        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speculatively executed",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "100percent of operations"
     },
@@ -132,7 +132,7 @@
     {
         "MetricName": "pc_write_spec_rate",
         "MetricExpr": "PC_WRITE_SPEC / INST_SPEC",
-        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speculatively executed",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "100percent of operations"
     },
@@ -195,14 +195,14 @@
     {
         "MetricName": "stall_frontend_cache_rate",
         "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
-        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
+        "BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and cache miss",
         "MetricGroup": "Stall",
         "ScaleUnit": "100percent of cycles"
     },
     {
         "MetricName": "stall_frontend_tlb_rate",
         "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
-        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
+        "BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and TLB miss",
         "MetricGroup": "Stall",
         "ScaleUnit": "100percent of cycles"
     },
@@ -391,7 +391,7 @@
         "ScaleUnit": "100percent of cache acceses"
     },
     {
-        "MetricName": "l1d_cache_access_prefetces",
+        "MetricName": "l1d_cache_access_prefetches",
         "MetricExpr": "L1D_CACHE_PRFM / L1D_CACHE",
         "BriefDescription": "L1D cache access - prefetch",
         "MetricGroup": "Cache",
-- 
2.51.0

