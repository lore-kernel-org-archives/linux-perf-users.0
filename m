Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2101.outbound.protection.outlook.com [40.107.237.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899231F4E34;
	Thu, 13 Mar 2025 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896769; cv=fail; b=JPsDMuH8IXLG1VVQnbdpOtFrRuNHDaO1ougNhpxiub4iUy2QADOMX568lieID0XWCr07ck2CrI38jqwP3P8x7VcIjdSfSQw7wptuQcvpzuRIayO7cJtAhQFI2dM03sK1t75ycP/s2rDvEswcLrSHx/ljwaLTb4Q8Uz/a62vQKGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896769; c=relaxed/simple;
	bh=v0Ozh6sRM3rS/i+KQyJEZVCSqEa3W5uM6rviFT0/LQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUgGhWS6Cc20U7QiRJjIIcY7Xtvwvy/JF0TtmS2eaS6dIGdrTh2CmRoWoz4Px2VCyIIJXgg4TVVli8vfooFufXeabdnY8htfkiH82vSeHT8tOmR7HD4OIBsTTBzeb0NVwhVTrslPO7KE/gKEoI9XJJ3FyqCqcFyQzEsMixq6Pr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cA4y+iPK; arc=fail smtp.client-ip=40.107.237.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cA4y+iPK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doaJuUFpi/d//HbjEjZEBA4CjeW6005YjSsl/U2dIfR3N2Q11YF6qdEc2iJDbkHG93vo5B61J0aBzrbxkd3VFRkMwlO8Nql0VhOpG8NdQKP/N1M3uEZ9LkQlJ6meyLkqQ4SBAW+CwYW57Wmc+wIDKVfadzfUDbvDhJCYrlN2RE2s34Esx8mKzGSa6cm5hjzSre5YF+HRuTYUCSzDx++g4/bMKEDkPer0ECWK4E3rarg7FS+j1l2Vogn9pPG8CJyDtkdWzYlOPmm+4GYnkb4QEcNOs+plf8BimFNk6N0DbWCB6g7QmEBThS2vi1Yn9QgFJgJ8iZzHhKTc2a3CbYA9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqWevJuHC1S/1RDCWIGY5BJPGNQI2xZl80Hc67zBASM=;
 b=JY3k81D271Sltp0SkZTW+hESwybe53Vw4pVdqdT/NFN2xBGOFCt1loTo3u3V6nIl0QNbEQ8s5M6mpE5XTnUmEeqgm9a/C597jwyNvzaMk/AHiAjynwZR0ZgR16QS2CDvQpGKCJXoUYA+iNjnq+828TpHETWiE2fF5oaEZGaT1o/1b8owyrKE9cUh/FlN2jg6NLOBKYZCinsh/U5ukSgQb1LCufK+SA20Lh5robVV4IykNVJG2FaCpviScR4H8V8YjIer5iZUu10+9/zlXZll3a2k3ovKbiMIbpvt54msTxopwvkLh6jEnsJmOktQJ1OQKi/4PgQP4W3aPj11F5ipQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqWevJuHC1S/1RDCWIGY5BJPGNQI2xZl80Hc67zBASM=;
 b=cA4y+iPKPAaiixpBfy4dl+nCRXBXFqUy86r3+Dpa2UTOqdPO6HiGFLOsF/B4C6RuY1NCY8Dd/4MfiXEqWiiMDzDyA1bJPdyV4+BiMYjswCiTec+C59aVXqoLj9yNHk65AjKvH+8uEZu280V7T7D5P/rbeIzpMs84pTO9sH8M2OA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 SJ0PR01MB7415.prod.exchangelabs.com (2603:10b6:a03:3d2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Thu, 13 Mar 2025 20:12:44 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 20:12:43 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf vendor events arm64: AmpereOne/AmpereOneX: Mark LD_RETIRED impacted by errata
Date: Thu, 13 Mar 2025 20:15:58 +0000
Message-ID: <20250313201559.11332-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
References: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::21) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|SJ0PR01MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: e85a5afc-5f76-4b49-3d73-08dd626b69fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nflxAx89TFKEzaVt4FaQH2o9+SJlOCDoj+nmWd5NdyX+rxmOI+FvygMQeqAZ?=
 =?us-ascii?Q?w9xWSBCR7MUgRcYmpbwNzT0oQuj5h5DeyUfQCm2gbblNtxtgTqGzO+858ch3?=
 =?us-ascii?Q?Uq3U90pyj4LXTPPx5T7mFdWleln3cg4egkAs27K04+SWeXZqlzampjYdRLbT?=
 =?us-ascii?Q?1hTjZZ9SieU07NjdNRsETaT8WAhaNkX8n2X1qe9vB7qVfHxExnhLdwFd2VUl?=
 =?us-ascii?Q?2Y9cMLHRbF/CFZMJeqNgfgaYH00VlhhVqT8vo9MwG5gZQewDGL3/cqvK9LrB?=
 =?us-ascii?Q?p1yC1IwG0JXVHDK0PymAFCp9/eqIdemzybPslWVNMTisjOGm9AjMBi1qfqaW?=
 =?us-ascii?Q?cP8xwraeXeieHrla8yxFMTqOXarObOxG2EFU3dktIVf7vfmDopd39c4TOz/x?=
 =?us-ascii?Q?JfQy5lfiy+il9tBP5hHDaAJyVOZu0Eo0GqY1D2INRsz63DhumptbqrxS8bET?=
 =?us-ascii?Q?G6u2RycFIqoL8ZeIL1ebN/ip5B0nFub66JkOKU/le7XoZKBfIneeCMBkWMQ7?=
 =?us-ascii?Q?i4jypxshH2Xddus5CGp+1vlRyHBRwh/tqErkFf9gbFiW6ddoWfresqVieDSj?=
 =?us-ascii?Q?t0afcjjg4wR8orYvTIOXPDyJVgHziHiz8u2uwY2Nau7m6lKmtsBwPe/wOn8k?=
 =?us-ascii?Q?SpwmNV/SAvjUnlf80KmJP/XI3bwqf94+wUx7M5WPkteT5HEqFsIZK3pdEn9L?=
 =?us-ascii?Q?4EIJKYQszgH2LYfjB9HAQYytTt/GUVbb1pmOutbFpic7u4CxxShmPBFI/cC6?=
 =?us-ascii?Q?8jXddSQoHD5PdDr6r5bqLy77QQyQM7cs1DxzElHihAPv9mGgd1UPytdYkwd/?=
 =?us-ascii?Q?i+AajDvaLNYVqv3Vxv7kq45CrynM7OmavRwyt1WR6YARHmA62G0b87mn59Ht?=
 =?us-ascii?Q?JLukQAFj9SLc0b13qgiLVJz8Jnd7bBOU9Wy8bavPoqu4HnF0UCfduhYkgNIL?=
 =?us-ascii?Q?g+WyVYL2aBTHIj9oSAF++Bp6hKtTkxN2/HbtV1HPDH8sS+1aWkn+hsYDByup?=
 =?us-ascii?Q?3n58Q3K2OZm/Y79lTE5QBFS/mz745dnEDedkzDgt5WgTAzS3Ah4PUO6Xs37l?=
 =?us-ascii?Q?5RC8Thr2YEdiOoyggMhSHDnLX8EfNqMgOo3wL/gHe039g0F1Y2aTdFQi5F0e?=
 =?us-ascii?Q?A/bTfzha3wf45yy68+nMa1VdFjdygB5YFQN5I1/eU05pIUA9ly/pwh3Yft3D?=
 =?us-ascii?Q?/cWOAZPgvngt+IA1OIjqqwYh37HtMQbvNN5Z7RFFk/2hdA3Io+DcnwWvEIy1?=
 =?us-ascii?Q?XKOi79D+PJrrwiSEC/D75iMBB4i8Uy6+owgjzbJB0EBAZR0o4rqvPrUPUxhG?=
 =?us-ascii?Q?edH7GcmiVjcOHBgh1h5EbRQNB7l4gQrQUN65Iw1Oanz69g7uailzf4u2+jwr?=
 =?us-ascii?Q?SDImFdjiCMx1pXPoqeRA8mCuvFf0AJRNB8aCBYS3CEHGW2zfrzTwdHWSmUz1?=
 =?us-ascii?Q?VRX0boL8X1BYBg/dO85VTFSamga3WFWGxDfY2dpVYNM2eoUKqU90Fg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?irSCd16Mm17OQ9DRHCiaCMEWIT2vFHMg3DGliPPZEteTRlhVId7J3kLNDoUG?=
 =?us-ascii?Q?tQ0bwTmhd7Aol+Mxl/DLXYav23+kMN9Bje2x7B9NHlmR34EfN1JVCQyDlUgz?=
 =?us-ascii?Q?nHyCxSpIX1MCNJKpdB490PUMKnxDs+mqDTgbbth+fZ+C+XzLAPOCHZcgYUve?=
 =?us-ascii?Q?Lxy3WhtKuSaWUzWuaBYPla5w2y4DqERjU81XYFILRmoDPY4jlJ7ZmLshd5HK?=
 =?us-ascii?Q?Kot6gi5/SeFSRrLTqFmPNZIujr1WI6mEEEtyzvzvrZNtNv26WyOJ8u3jH3DC?=
 =?us-ascii?Q?0NkYY9fGTQfcchnR/6C+ksxI6Ljyb37Fj+p3kapbmJkTMYwQrF7K1GSSkpWA?=
 =?us-ascii?Q?6PvKLTwH/MboWtTZQHZWGSpjlHt3f5mckZcDatQH3qij6eW1c1VEbeVpim3i?=
 =?us-ascii?Q?YvvyogmbsDPMhb8Q0LF17I8Y0FEW8nkCPc+wxDPR8PyjQxYS+w4wzOcK24+O?=
 =?us-ascii?Q?51/s99ADiZDeYctAvZCTsyDLkAuVeHK2ZK8Z5P0aE1hrx5sTF2czPkeY/LzU?=
 =?us-ascii?Q?XMlxq2clxrssHu2cnVLKmZ5DamNg7PfmeEtAqyZ8PwtpMGn9ErYmZYq4xjRC?=
 =?us-ascii?Q?bzWWKjjJ2X7YNm3YlXvRjbjHoIBg0wGfgTUzrdyX9APyQ8I8o2QPgSOUs/60?=
 =?us-ascii?Q?KCBOtpQJu5pRDttav2Vsr+eUkvKGMP3lL3jWaZGVm1bxVJxCY4k83q9IKyDm?=
 =?us-ascii?Q?+UQESt461QwJJUvqn3hSn40elJvlh4wRbOlnlb1f1Kjvg4JEAZKbPaJ6eR4m?=
 =?us-ascii?Q?pxez5HrPtnU+eEQvwu+I3oqZiVBmzb0j+ZBgv+HJ6RzoI4tX9OeSTds3ucFn?=
 =?us-ascii?Q?wjIqCKMJoFCfnGYL5/cXopmSNV/D7HODLD19fW7eWxOfOblOy81M6XS/PkdO?=
 =?us-ascii?Q?zlShEA0TJTzu5OROb/BYiSBe4/N6sPTnPVX5C1LJD7rROCWZWMEutG35V1D3?=
 =?us-ascii?Q?ZUo0kwTT0oDG0Y1e1WAnyvsQxyxSEByIPDlUOu/59wNsRAmz+CRoj54XpCmb?=
 =?us-ascii?Q?rhPLGsDhZZYgUqaqMag8YmtcI3Y/5UxY3DlaYLebIbKKUbAUVFKWmnSDzGAh?=
 =?us-ascii?Q?nwq8M5PMJewETP7OGMZ4a/eSrdSaaC+/AHPvO7OZcOlQ4lYfgdkiaDPY+Gzn?=
 =?us-ascii?Q?BMCswEt09l3HVAB8knHbrz+UtN8oM8SDOk8VeLNVMlO2DnJBZrmuhroHVkh1?=
 =?us-ascii?Q?ilqMZ7Gd4dyo5Q9Xf14FNSZG+mHjasFbZ20fNdS93qIDCNjICYGA3TcfhDPz?=
 =?us-ascii?Q?gljCLII0h4J0hQKzjSIcGuEPkbVUGO3eXZf/o1B40y4GC0ydLjiQKkK+7J60?=
 =?us-ascii?Q?HLtGfvLg9NIWWMi9DalKZBRmdHc8UBI663dFgDP1IyDGMjC9fGak3Xk6FQd5?=
 =?us-ascii?Q?GppVPYbjlocpqaHKLDRN/FZxlZf7lQLqeHqk31LeEzTOz4NbHx31RhCUlVMt?=
 =?us-ascii?Q?B3xRMFa3vVDHaF6NX+YCkK/DrDHpzw7dX9NhYQdVCfHyq9EsH0j8qfyDJce8?=
 =?us-ascii?Q?huOwtAoLzPZR1nSLg8g8ILLU1WlIVuIgro5MoKWCyqNNlm66tp1cbdAa+s/v?=
 =?us-ascii?Q?2OJmCgNzeglqZ/PfCF3WYolQ1P44MqiH7s4bKWqDX841PQ6bvwvPYGJgURdr?=
 =?us-ascii?Q?97+S6Ggd0RH6OWDjDx7UdAM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85a5afc-5f76-4b49-3d73-08dd626b69fe
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 20:12:43.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8mRnyeZ4irLAIBopmJF9gW5wQIGkQeqMDcOvChizu82T3xLIrnqFv1ob7Nrgc4xgpZJ1WF5IM2mpGUgnnjEKh+S7S5nroytvzgw9CIPiJDMTRt4fv81cOGtbexYoHVh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7415

Atomic instructions are both memory-reading and memory-writing
instructions and so should be counted by both LD_RETIRED and ST_RETIRED
performance monitoring events. However LD_RETIRED does not count atomic
instructions.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json | 4 +++-
 .../perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
index 0711782bfa6b..13382d29b25f 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
@@ -1,6 +1,8 @@
 [
     {
-        "ArchStdEvent": "LD_RETIRED"
+        "ArchStdEvent": "LD_RETIRED",
+        "Errata": "Errata AC03_CPU_52",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, load. Impacted by errata -"
     },
     {
         "ArchStdEvent": "MEM_ACCESS_RD"
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
index a211d94aacde..6c06bc928415 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
@@ -1,6 +1,8 @@
 [
     {
-        "ArchStdEvent": "LD_RETIRED"
+        "ArchStdEvent": "LD_RETIRED",
+        "Errata": "Errata AC04_CPU_21",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, load. Impacted by errata -"
     },
     {
         "ArchStdEvent": "MEM_ACCESS_RD"
-- 
2.47.0

