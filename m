Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF636E48B;
	Fri,  8 May 2026 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220047; cv=fail; b=eSHzqX3pc297oahFHoVAkMAv+KWnNnQi3jWrxTNkeFrhzO/fMorxb2Wd2G3ahAsYijbZwvs0UyS/dXoZaXOweH9RhtPo2WSa/nwcKWBq+POs6351eQrsrELXLgULJQ5wTQQNBFaHlI1YWKE+1OL+06SaMKlLTYK9a+nrtjcZy/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220047; c=relaxed/simple;
	bh=VqyTi/NfllLkagbdNqSanrnl9BqfLjVcGEgsetQzWR8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iof1MPoCk5m3+VlcvkUdgoHIp/dXGVFf1tMaWAODiSW+mroRau7aumJBPbCOGIlen2ABfk03AktLdMAnTiyqE7EPwxxcU9am0avb7Ksu7zwCc4gCPaQfcaatQs4sITrMTWloy5d8XEt0jm3CDmxMVdoGMufr0XqpfAn9ngug1+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jYecxA5n; arc=fail smtp.client-ip=52.101.52.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jYecxA5n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIv2l31yk764osdMJPUm1m2jzURD4Xpq/ncdjWrLlqUKB+jUGe1LqpGLaFt1hc2u4PVI5365snABzHMLtCGOP7T7XIxWSnMzqVtDmzVXJjof62ptgJCxqxK422cDk7o9FRwUeawUcbHtf6xdMrtX4MsRZj59MBQQD4C9Zr6x2Bo5VCGWyaGfD8NeWNTm226ixemIpGT+bPkYPtbS/CCwMz2+DGEvE+1C+wRdtfsQ2x7roIX81VIYuvyjZ5daPB5Dcc0c/IBGHkwfy6dQAHpSGsSAchh72iUjYVvHe72ln3dP/5F10jDQGtx2bG6lwuvuQ/DFG2q9Zsu/LIhTK8OjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tWlc045FzBabChddlyhke/tzmaI+wQpJUurLetUomE=;
 b=ncE+bSXqnAHngTsyfQwRhCHXl1z49y84uDp4RIC13mdGSJ2akBT7RKW93a8GcPlis133j6z6V/d/pXXb0Cvq2j9pzt2mOfO2igtGYDGH0TRCLHNrnvA0A6ETQDEzv+0GalMYXLUFx0BfwgTzwN9Mp/IAyBWDJt8wqkFPXl2zgPo5xTYZZgeVweumwGMjo1nTj5+qt/wjJrgBfDMCFcrence1w+Z0oQzpAbd02xfRN1Gbyn9a7p0RpqjLBxUGvr5Ugc87AqoZGaoHzxfjGRCo9vxJ7+LKo2r8fW2PNdPJjablwxW0K6+waNttAym9b9rTa00srplRI5z8t891B7L7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tWlc045FzBabChddlyhke/tzmaI+wQpJUurLetUomE=;
 b=jYecxA5nryvj880QseYyisOoi/eYLCr8DF9HjUXdTmeWKmmbffd+C++O4jtJwE+65q/82CoZz/dG8+KOQq/xfmFB1GCJAv7LE5EvnLHIfexTorlphwWinXTpD5KFaStfsVHrRqJESoTYDkVjQWKKB5pdO656D6EISWGCkjL5bRo=
Received: from SJ0PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:33f::6)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 06:00:21 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::9) by SJ0PR05CA0031.outlook.office365.com
 (2603:10b6:a03:33f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Fri,
 8 May 2026 06:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:00:21 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 01:00:17 -0500
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
Subject: [PATCH v3 0/8] perf tools amd ibs: Fixes + Zen6 enhancements
Date: Fri, 8 May 2026 05:59:56 +0000
Message-ID: <20260508060004.2575-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 90865db2-03cb-44b0-c309-08deacc7170a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|7416014|13003099007|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	4FKBl8RebXh0GjsEbRQp8tcqwUvADlck1FtdxTcI48QOdvjeSwU37K3sUr9LfBPTFbmKGX5E65Xn1qs25ZYnqMw9/ynO2l2uVZWp4Ku7p/mx9HKQ3roHuaRv3Gc5zIsv9pUi4W3diPbbvgAOmjgBAB/4ZXrMVNHEoDpn8Lmz2UUVCd7EkWNaHCIjRui39o+FdK7kjech4Y1qGSvxhkiENji2JJ3Gpv3RAW//VuCfMosX8eneMIlJD2Bc+IaaRPvuQunG5WIB/hCekzCjwcpay0t5RIry//UrsCPP1LzrZx5+3Aw7KYuto4oJ7iWniDln6eLqjsFP2dSSqLQuQpJmju58p1o0LJ2AQRGAMOXx0Ue3jIPiqrdQPGmU+wwkkFgBBoPfskrdmRveuGgRJ+RfyNkY5ug4bpFaN12vPSHtPohjWEy+wEdeJvXzrz9SvLI/Jo5Hqwya3I1DNUj9UWunHsN4r40a8KIEE0/5RWM5ZLEwGu89qphb4RSb7JkUDiqTwKNys2HYzwiJmgKr3njd3HBODkkin+6VaZL+SvhfhNsEaYBZ3j2J5NRplPVfXGI+AP2WNq6yzM/PdwG9N6IsGEsHvwcylaGJAUnhCxbppRnwYiF/8Sj126VUOgXAswkXMDpVbTotoTdiCaBcCluCZNZFp3vl9Mhcsm4CTOwIUsbt0cr/uAwa7m+D7tARi4ogOeE3AOtCwPhwdqDIVFGOPAj98VnFC4OCFOZI+0lYpfQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(7416014)(13003099007)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ut+oT7bp6QDlfepol5t5xI1ms3bZNr5wFp2m5x8kNKsVdtgbn1uz6BueYtUZC611E2kdutcU5MlmNST4skMfSUwLUaiK4SoNF6X/IzLrJdFXyo8afQlPjrisK013GJcJ8RT5Vye9eOnVb58d61wwxpZHuCKsE6xb/7GWKkaj+aRbShiao0aX7/4Xxi7Ch8vXaJqPFp81BZA+UUXPtJkf9u07V+HaT2Q7gqCgUPL3pS5eeYSGJd83DWeZsFcZrboFWsixf2RM7XxKjVQPE19DMXJ4p4pXl4mCUUk88sBfKh69N8L2KyOw9cH9ZjYiusCnzksOerCaQ+gKEjWSMaTokie3Mt459XqtRRIrhC+SzNcvBoW18HVJK0k5+X6+2eQa63CijpOB+eRxOk1j50g4fyWMpyNkE+Nf6QAl99iMZla2xLK3sjhjbIQoDkPBGKW/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:00:21.7084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90865db2-03cb-44b0-c309-08deacc7170a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

o Fix kernel version check in perf IBS unit test.
o On Zen6 and newer platforms, skip perf unit test that assumes IBS don't
  have hardware-assisted privilege filter.
o Starting with Zen4, the validity of several IBS fields changes. Add
  the required dependency checks when decoding IBS MSRs.
o Zen6 and future platforms extends IBS OP with Streaming-Store and
  Remote-Socket indicators for load/store instructions. Add decoding
  support for these new bits.
o Document new IBS features in perf-amd-ibs man page 

IBS Zen6 enhancements doc:
  AMD64 Zen6 Instruction Based Sampling (IBS) Extensions and Features,
  Pub. 69205 Rev. 1.00 March 2026 
  https://bugzilla.kernel.org/attachment.cgi?id=310002

Patches are prepared on perf-tools-next/perf-tools-next (53bc03289278).

v2: https://lore.kernel.org/r/20260430061115.10266-1-ravi.bangoria@amd.com  
v2->v3:
 - Instead of removing the priv modifier unit test completely, skip
   it on platforms that supports hardware privilege filtering. (Namhyung)
 - Rebased the series on latest perf-tools-next/perf-tools-next.

Ravi Bangoria (8):
  perf test amd ibs: Fix incorrect kernel version check
  perf tool ibs: Sync AMD IBS header file
  perf test ibs: Skip privilege test on Zen6 and newer platforms
  perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+
  perf amd ibs: Make Fetch status bits dependent on PhyAddrValid for
    newer platforms
  perf amd ibs: Decode Remote-Socket flag in IBS OP raw dump
  perf amd ibs: Decode Streaming-store flag in IBS OP raw dump
  perf doc: Document new IBS capabilities in man page

 tools/arch/x86/include/asm/amd/ibs.h       |  4 +-
 tools/perf/Documentation/perf-amd-ibs.txt  | 39 ++++++++++
 tools/perf/arch/x86/tests/amd-ibs-period.c |  2 +-
 tools/perf/tests/shell/amd-ibs-swfilt.sh   | 37 ++++++++-
 tools/perf/util/amd-sample-raw.c           | 87 ++++++++++++++++++++--
 5 files changed, 156 insertions(+), 13 deletions(-)

-- 
2.43.0

