Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8651A680B;
	Sat, 23 May 2026 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500015; cv=fail; b=FA6zTcbsD5488t/t+fImR/+uhU5ZnkYBUOS7n169qmjTISStOEMqXG8UehZjtCvQkHd8vCK74P+mHbPosveJoKuFmD3fPe5VYTWWf59r7EDZalLqCxUtgN6lfaPBRjxLc24j4H5LjtdvB1ZeFdtW4sEI1TIf6oCFNynlxW8J3jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500015; c=relaxed/simple;
	bh=lytbXjlxf0pvYoYqN//L8/agP9dYAX6Pje5JKEWxRnA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q1LSgcqxXmn8/9JUqGXc6bC+MWH126ZbaVzDrGQNKk1IdyKXQgOoFTxS+OBHqqmpkzDnFGVWARob7/02HvYWxgAmfgQRHrR7xACPou2Sy5zUzMpR6MkCWJ9wTLM3acrNBMeTnKAmXpyxc/XzwzJGen5Zglp4noHa68MrCBzhK5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=otaAPCtV; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="otaAPCtV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wju/9O++Rit6J2Zs7YaHRPxkWUymef+5jNZEYY6RXgXiV9PdOw7B2kIpXzrZpM58hM8422E1k0IfGPOUXjg7qb5e33u6mt6NWfXfWYfnU32NpaHYTUAoLKFresDVo20JjWAIs3BpSFCYGbCF7EQH8pdiGM9vigqyvaJTM6oCah7VFIJ0e740epCWYDaVIkj+AU4nnPxVWoQY58TfGPIWv8tCwXb7lsPkC/Nqh7vsl1e+vR+UjDEz43oFUzk//Vd39gOUlF8Ii/Pb1/yZQ1cfK0Fyv9jQdBO5huCOxSUOVRMH0K3cvQnobjaZ3Klhi80ML4dwlQ0i0tmNNYaCi6qJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OJq5Xpec9OsRiEBZLbw/k4JAM4YZrWGH12rAr/qCUQ=;
 b=ghEERjGG+FlZE/Vng1n5pc4VugAsl7w2OTNA6c3ozQYgBHrUXQHDgxvRl9pWFoH78gmjJc7ceudd1/Z7t6EjHlOqymUqQhMZvuqvFbwFDKendUeclx47u1gf4ShpDYedUEJ520eljKPDTsnibENvfevbiUwsnqpQisrCajThUjuGaJXUfa/uRBl1wUk1SIm1vJnFDXjNDRw3KneM4SawIAgtO6pso0/3zLdDr5BV2ETKbuMAbIyiwoWSYFvUOtL4inhmxhacgcWdsHBkCGOLuFk7A1k9IAuAP3pIQ8wNPa1C4pOhHOMvk/TRa7N5OwRxwl01TIsBoWP/jhSQEyV4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OJq5Xpec9OsRiEBZLbw/k4JAM4YZrWGH12rAr/qCUQ=;
 b=otaAPCtVxLAA55myN4BNYabmNoF7NHG5EbFrOL15qOmBsAdNFcW8MbIrPpK1zQW/6DWD/3jrfRImHDK+UdoF/av/80gWo2lGL3p/YtgLIJbk/E2eH2LZfuwwDTflRtAi2gpZmF9bFhwCLAbb17QCBSbfwQBvxdA9pnT7hsJHhtAdCXrH2hfEHlU+VZKLPveLontwSAHDn4c7AKecimDy1SUdJS7hd7ryeF20EVTuzu20pkbqbgXlsQObFuNf4Yo5GNOL9PLdC0gnbbAN89xyPvBYGMOTCI7AYhpeeezNCge33bQaf9drJyuzybYa4S3n92VkoFE9+xGllC8ljeYGfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Sat, 23 May
 2026 01:33:29 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 01:33:28 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/2] complete perf_allow_* trio and use in drm/xe
Date: Fri, 22 May 2026 18:33:24 -0700
Message-ID: <20260523013326.129491-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.54.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c752e3d-126a-4bf1-9253-08deb86b4a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	/jTjXKU/+f+9g215+Pj879pyB8RXedxwLZNFSasmXJZogr21DsCotrkaZ4a67+mGxDx36V0IIWY8fNOYt/OYO4C5F8ENfKsjPIEX2ei144N819CgXVETwTz4Vc1ifTskC0OcufJ5iRUKiKIO21qjNs760Cg3qyzQby4XIovNjNm/fd3Ooxk+XOy5wCGOpOtv828y1oXc8MMEyQEtdXQfv0BuWmPNxcEaAPIlsXERr3u43Pyrbi/aVLymUqYHGIfLBQoorFqc3hGthO5grqxXSKrTfwJiE1Icu1jlBKycyErUfiX0RKJhkPaV660bmNk46AVsoQezrw2ivwAOqp6HWFdrRdJQtfL/0J1h0r5iN3oEnAmOK1vcwHvH15EE+wTXjOysHhK5+L8iaZknJtOMvL0Ug1OhfRlyYD54usedy5w8hOnGriXrySIX2RLQhg3HgTj0kCyIOsem6ug37X1QbrZbKpdLkgETvdTuSdlpsY6V+Sho4QgX17E2cdY/WLH9EbYL00CJKHEbK4oIFDt9H1hJQxonpMS/ZNENmib35DP5iEXQH9Noplox9boWGacYTkK61GHcGel1zriIaggRUEmI1cyzcuGj+AAXmhmDl+ObfE5qWd+yIzBFWJfFZD12gSagojvOLEQSRwx9Ew3gWii6NJ5IHpK1eoayYdIatIRgjGNjDr2LWbg+kY5BMws7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mMsF+4aGSuAzVzlcgREuqyuAxDaZkbr5Shnxgw24UrjzsLrDHt0YoajSoSwG?=
 =?us-ascii?Q?uK+QA1X3mx+NNQ6oFo+8xR296gyj6RwSddoFPvd08k7h0wfP+Pz3eZzKocAM?=
 =?us-ascii?Q?8MnoZrmRzASWHd6ruFVuU7KYGn2ySN4SxguXTwSDOZSZVZVrR9QIBAsxALjm?=
 =?us-ascii?Q?M2uk5Q+NNAMBnv/GinDTPidiWtZJiaDRSecshznWBzi4f1UJTYXUfBIplZ79?=
 =?us-ascii?Q?GPTrUgKQ9Vc+bWEZb/vL2JVZLY9u8K7BC01PsYbKBXKVoDvSBSgKNJHTd6JV?=
 =?us-ascii?Q?S0hOyPnlLyRzdHqndGhoNNnTaOWyzdt3dqTQPoPfOnUfn/DVdktxpY6Amgzw?=
 =?us-ascii?Q?In87hJkSXcqNN4s5KcR1DPx5DtLCPNeOFtuoPgf9O6wILp0cZy4AKSwV/Vkf?=
 =?us-ascii?Q?NNQx2uaqfPFqsMo+XOYU0CD1+jRdI2XTqXK83UiBqzes1Fyq3ac1Ih/oSB8W?=
 =?us-ascii?Q?tar0WFPKblr/pDB5D7s06gSZJwjavjyh8MC+3nWvyExWNltcVLQrpdZB8aaL?=
 =?us-ascii?Q?rBNGFSyMzCo2Dk3Q62RXUhVE8/VH8Ry1a7JVO7Ak2hgQPGtfy62gPBOPYINw?=
 =?us-ascii?Q?RXiJBYPe7c8zKYiR6GfWWt+yEW/p3/rMfkaxB4czFnRz7ZuPAGa74P2/rZir?=
 =?us-ascii?Q?BUfGd71dPvFl/+k8FbTl4qMoVanB7pOFJqjEBTOuWDPPKIrIW0bOHKcJJ19H?=
 =?us-ascii?Q?Z8n6FCX7qg8y8eFNNZwn9kAhpTyRSPw2fs5HGaa6q6U9r/JAKDSqRBz9QzjT?=
 =?us-ascii?Q?rd7t36eBvcszkuZ1uzNcdPgHxLhcV78b6o+/CxGQyJ/CjnjFYp/Dn/6A5kLK?=
 =?us-ascii?Q?9LWghGFRkcGrm1xpomdqLEdXwuz93plY/QqUtwSWxtG85i3Xe6c8ojSTd5+v?=
 =?us-ascii?Q?D1av+I2uV74DTu30/RR5TjngopghDaT3UJDokUijYR7C1ggAPUOwMwtmgt2O?=
 =?us-ascii?Q?neQqsRHocHCHjAvR9ZLSoMAvghsiWuc5Le5LzBbSvkkXaGfqmfz6q4A4ZKLR?=
 =?us-ascii?Q?VLcc2lma2hfZxNMpmhnOAurKPSKpDEb/tVIsNvPKZ3JxhrTrk5ksmq080XOI?=
 =?us-ascii?Q?QGmrPaF/zKA3PHh6kpmCeHgfnhRDV/DnHshH4uMGn+j5ZoQF+KWWThR48oUN?=
 =?us-ascii?Q?1woCWVic4YZFly3cnlzZ8qiF+/J9A5XxaN5H6D1N9RXfblq6/YZDTyhlqsOv?=
 =?us-ascii?Q?qP3cnwdn6Le6vRkG1j7jyRRJ2bPvWMAVRNRF8gTANScAmCfq7QiI9A/NYvKn?=
 =?us-ascii?Q?9PRK+/t9wPoyzYx8lzTb2YsnVJ+RFI71cVbUO5e1cQnomX9qU6CEcu6w1OFS?=
 =?us-ascii?Q?WJpgXKEU5EW69n1HeyKx+QgZbD1jPubsQxPQzoUqQaMcJRc1u8IEPyQcoaYH?=
 =?us-ascii?Q?zxxyn95Z+e8p8szE5uC2tI1QNVrO4+9SxyOSujmC3aKRYs3RoxTfAx8Mm5ir?=
 =?us-ascii?Q?pOBMk6EhDY2+sYFK3b218qCc/j+3x8qe6OTH7LR1JwQAXdnebryS/MhBM1s0?=
 =?us-ascii?Q?hdDNHQ023p5jr98fcYcQajTvIZpNefYp9/QPkJygngbCsqq4Kp6YhShAt+Qg?=
 =?us-ascii?Q?EI53uBWiQYxIjRd+1CKKmQ+ojhMKEamefAxWkwEmacacxcr0NhKj0M9YstdE?=
 =?us-ascii?Q?+OnR2veJWJDePZz+QjeMOqeQ0gnsT5SMaNaumtE42GI06ea+ZLU9Tg4Qq7aU?=
 =?us-ascii?Q?QkAVrHGmCzzcqUQtP4+XkM8X+QDqwrjvqMie8sAAwHnHimv+plja1rWegbgU?=
 =?us-ascii?Q?mkqYDO4+vA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c752e3d-126a-4bf1-9253-08deb86b4a69
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 01:33:28.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNdJh1jScQau2HKvtozKJsA+6nYnpjUWZ/kzSZ5fo5gO+rjCuNLOBk1M5o5c/aA/xm1TaWPxiVjX8M3uDoQ/Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580

perf_allow_cpu() and perf_allow_tracepoint() are static inline and
reach into a non-exported sysctl, so modular drivers that want the
same permission model as system-wide perf end up writing partial
copies of this code. Let's instead export these properly so that modules
can call them.

Commit 5e9629d0ae97 ("drivers/perf: arm_spe: Use perf_allow_kernel()
for permissions") already moved perf_allow_kernel() out of line and
exported it. Patch 1 does the same for the other two, and provides
!CONFIG_PERF_EVENTS stubs so the helpers stay callable when perf is
compiled out.

Patch 2 converts drm/xe's OA and EU stall paths to call
perf_allow_cpu(), so xe observation now respects the system
perf_event_paranoid policy and consults the LSM hook. Sites that have
already configured an LSM perf policy or tuned the paranoid sysctl will
now see those settings honored on xe as well.

Changes since v1:

* Patch 1: add !CONFIG_PERF_EVENTS stubs that fall back to
  perfmon_capable() so the helpers remain callable when perf is
  compiled out. The sashiko-bot AI review caught that the v1 code
  would otherwise fail to build with PERF_EVENTS=n.

John Hubbard (2):
  perf/core: out-of-line and export perf_allow_cpu/tracepoint()
  drm/xe: gate observation streams with perf_allow_cpu()

 drivers/gpu/drm/xe/xe_eu_stall.c    |  5 +++--
 drivers/gpu/drm/xe/xe_oa.c          | 25 +++++++++++++---------
 drivers/gpu/drm/xe/xe_observation.c | 32 ++++++++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_observation.h |  3 +--
 include/linux/perf_event.h          | 31 ++++++++++++++--------------
 kernel/events/core.c                | 18 ++++++++++++++++
 6 files changed, 79 insertions(+), 35 deletions(-)


base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5
-- 
2.54.0

