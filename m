Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35D419303;
	Fri, 25 Sep 2026 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335284; cv=fail; b=h7ORBI1dXYO69ipN9Bu9cLH4fG9NHoCf5ZTMkVuUsp/4tqxcuKoUTuMqeM1vPCFFZ1m5HMtokNdj6nucKNcalLtvxwQazwX3yxRDfyxGyz6j1f2N3OdiabI3OYnJ3PpyuCAc6DjQ3eetUvlzA9VOstR3NDQGvpr3lWvl7HfELUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335284; c=relaxed/simple;
	bh=lVDFTt9bJ6Iw6P+6Hi4CS6lNPO2fq49ZCKoinFBmMvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kRfS9pPRSVbTN6lqjj+b3gtfZtKssR1RpkQuiP368hd1fdl87N7VlAv7emYywWPNwAxR5dI21D6APQCgTA2i3urDZl1BrRGZOlzXcpufIPiH76OWRjtPqHTQFsOhRvYHAcPX0zzWjegCIBWTREcncqoWR2qA/yyvx1MtUN3Z8Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K5l/TcX0; arc=fail smtp.client-ip=52.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K5l/TcX0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRBm+dZuWJl71c9dxvoROrVGavdT/O5VUqlAFfu6YnKlFp2NP9KqPKTP2CHmy1tX0Vfgc88VH/Bl3FyEuuFGbWojFC8IdWUeFVn7eORdWJsXDEOSVntm59TrSA4qLCmicrnHYBdQM1cZNhlNR4CfPkv8yrPIWt1C2iyWKRf1H0/duhksvS6vacrDJjz6G6bxNBrgs1VqVYKaiDB76OwFimXCgmIHT2ESbJ4sbnryytot7O0JLnKlibXXng514xSJcPQDzQpj8AoJA6eTF1uzy6eNPn46gWflCmDgzezqi1gMv++lAM9UWFBktYBAGkRfQmf2ncoFJxOs2vrHdxj/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMaqWbfR+ycNJI4+8CscHM75BOpZEAHONtswL3tfJb8=;
 b=A3d+RmbH8jb4MxsO3/DG/d9CnBk/cS/f2Y5gbPsKyOF2JAUqo4dRDHTxPeqsBiXCFXMT80yIW/zGaPt5AUlq++6+ZRyj8Wnnj93S3atWSnbGNA3tIyC0zLoDjUkbHSdg8PHuPRebX51sMK+uVxY9yelC/otOFrPOf865/z15f4tvvebfQ69ZMlYZCV9tkwMv+ObiDSFIB6vd6aUcN0C49NucobiA2JvzTQXw0bzmu+gxN4d66wGK1WR+W1fX4R98gMirJMSIZ83NQmhAnjHW8pSbFohRN5QrxR4FrqEkZZiH/bpmCwJ5O3KK+GWlp3YH2LCxwwcGKq/XsUWTdrN5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMaqWbfR+ycNJI4+8CscHM75BOpZEAHONtswL3tfJb8=;
 b=K5l/TcX0IvfORcG3ucBao+WMB7P4wLf/pxyg1gAT1CZRpVpN25wJrRgSz2pdSEyg0WYfPtGYuGUpDoC1iWQW9i5L4PNs2UoLqfz+Z1LmrVUcgBDdNhjujdv+RCbQQGkWhNm8/trrG9awU4sGgXdIqPUmYNWpNcWgVnBo7g4ZPsw=
Received: from BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 11:21:18 +0000
Received: from SJ1PEPF000037A7.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::82) by BY5PR03CA0012.outlook.office365.com
 (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 11:21:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A7.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:21:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:21:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:21:15 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 25 Sep 2026 06:21:11 -0500
Message-ID: <65d6b245-8714-4ab1-ac8a-5fc730cdbef2@amd.com>
Date: Fri, 25 Sep 2026 16:51:09 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] perf mem record: Use the IBS swfilt filter when
 available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, Jiri
 Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, "Adrian Hunter"
	<adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260924212809.1733663-1-acme@kernel.org>
 <20260924212809.1733663-7-acme@kernel.org>
 <76ef085b-e8e3-41a5-b029-2cd0489aa430@amd.com> <arZNlT3kb8Gg8kVo@x2>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <arZNlT3kb8Gg8kVo@x2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A7:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a16d64f-7651-4521-eb4d-08df1af71d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	PHFmk1dOuovOHVYVMfu5fxRKGgMGk5N//5rD5vEaNWpNOjJROX7VSuAKkdSlgYhbi4VoXx+JCDlsFz76dqgz3HRE2On3wz7RByWwFX9XWFW1ZDUgVzfODS7Hx1qn31mj8q4Z+Uo+dBeJyqbNts0vnDX185IQ/SunfYSny4ehIoeADtQ11J4GSfObZAAtjs5I15feaDJz38uJ7oQdRBiCxioDyC5pYdr4Oy+o/SkMii1LiI8YDiiPIRFsdvHDGwsdGEIgxd0EcwHObKL8vtK6jEHc0YONwuVmobY63FTBe4zpE7tTYcD5zptNpB/pPpd+Yq7kEvtawmD3I4mRQ6x3sVDTzeX2rqQZl4V3Wx2F2BA8KOeFRk+e7E1w0JRYIgp5mzdpGjBetx4BbbufiB45zCWjGKmQKdjLRUdS/XlQVW7BW/soRXFh9wW4VMEYxN2/kIF11qyGK0WZF4fg40Y5eSLOsZMe+SH96ATOOsN26NjVGwXf2pHw5ElxjldmHQdlxeggngknYVzoqBwPmAlz/X4k8eTGxsOCPOObl2S9SbNGGSPx0valEZUgiaPMggQS8Gne215EbeumXcYPQ3KO4AoowbxgKwazq9M0bt3yIEjvh5aUpXzqIhNf2jZnWlVFs299JCOCPthYcyhMM7ndg+UWhDEQ9woSBzt5DQ91WKcpYPtM4NwF05nYermg2SoMBee/LvLbo6eryQEJqkRp5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d2wXbFPWblKIkr26Ivq21zd+8Un7yv+bN7A6P2kWf75EBYSVf/zHBjBAGX+m9wuHw6iAKgKsl1zWsy2XKE4n2ELqOOMIujCATuukloMZ/ft964oNzHzstC9v8XHRe4a8oCIkUGL8a4zUVJJ+6DifOVzHxU4RbTpO+Pz9ueOD5wrUpTrgrDpyV/goT2l3ysoKBxuOj56IRgfJfYwXHbvH/BkH/sJ/9VpjpDV2P6t5bqfWp5g9eepAiklw0z4k23czJVP8/i/IqVBxV4DQiQUYN7bKFXIbAnX2CaupL6Oicq6+TpntbdoRpHtxg0Ao1chQA1Kl/Ie27hle+4qH15d3Jgf7B9sA1/8Ej28DZpf+F1liimx2Azlq1lJFZSqVvEwJuGHE/WgmCfWszFMNqkVTQr5OxxxCaflyFHKwpx3kPcWhm5fstx3yZ5W2VTwnXjXN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:21:15.9380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a16d64f-7651-4521-eb4d-08df1af71d4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

> Made it more concise:
> 
> +/*
> + * IBS events with exclude_{user,kernel} bits are rejected on hardware
> + * without the privilege filter unless swfilt is used: the extra tables
> + * carry the term, selected when the PMU exposes it.
> + */
Looks good. Thanks.

Ravi
