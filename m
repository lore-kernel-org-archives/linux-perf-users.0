Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29041C84A0;
	Sat, 19 Sep 2026 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789785531; cv=fail; b=k1a1gSKXMNjDuCdppmpAbmB30wbVbY61SPzNea49xmZRM7hVvYfx6F3llEjqLZTAzhQj+nRo0/whJLVOYM69/heUqbc6z1NnDzsMTCVjdGTpx7xATelXDf3XLEHHAp0ex4hZEOXHQl4NJcmcuaC+Z/omImDJpyLsHfRGq/U77qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789785531; c=relaxed/simple;
	bh=LTvLTR+mwjbaPpux9hKDR7LlW8qJOUcMgOdopDzux0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dCxBO2xZYH4Ze9jXaB3I1tYzCw2/5ied3GRFReziod/s9i7QzfsOIElo4+eZjj/ZU48JQWgrIqiBzLkD9TcGkIbuuFuIjEYeyFeVz/Xjye2QzzIUs3Zt2Spr3lEoFYOnzX+GrQkMsJhRESYS8+/L5J8EHnxQJJgFa+mEo63N0i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BBcNXSnz; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BBcNXSnz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdLXs77jGSLFyZC8fuYoGQrio2fIiFBjc6BRTRw1o5J6BBwV1wPF23Kjjyxmm0XBx5SeUxLPUt1h/jHc4UZPdOYOUk8LORThhJn9QJ5oTmvqnjY5yNKAGXGwnY0pfk35H0llDG3GWfRkURJAIGZ3Ju4rF5AX9/VVh+PM8RWrhucIGxeC/zU31Y3pI6i8gYz7rx8oSwC8bdaJrO6wxtjQOCYz9VBeFsdOEzKtYEbKqbECohkrjQcw/Lwkb6sGdyi8B+rxySU2pznnQpVUpvZUCSFkVpbnmiSP6iCgAWh270+m16KLV4MDn0BFGO458JWEfvViJ5WQQqAqiz+icJsH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+LwRPYgtMTWiflgtN1ER7Qn9qBbkIoRiq+S7+zZqCM=;
 b=WPpBxE1cT1zmKv+ZPZRk/alSazNM8vUry1htmvrIkOEaoDJQivZZawFNuveNrSZerBEKaAqdpB9UwG6U/zLpdLPy9MmKHWW6Zgbpijd2wQSS/NSMehlIwxDRHAVaqSYBINX7HonArH6r0a0D7r/9cKnUIabfCoLb1ZOr/4ML0v9PjAUp2MfyqhA+CEf8Qu4XHzSsCPsjiZtMMkwvOHb+zixUnKQkm1tzG4Tr5gBS19SPXFf77upELInKSdYjAMTmRFNm+PjBrm6MOziCvwSGL7cmz5WmjFSsWxYD/uPoBTfU5kaWbSte8pl1iMCkFDruhCZ46kh6Nf1ixPso0gGcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+LwRPYgtMTWiflgtN1ER7Qn9qBbkIoRiq+S7+zZqCM=;
 b=BBcNXSnzaNHIb6EZ3lQxmr92tlS/xX7aR6gKT3F3xzqpQTwiGFh98RjfObbRi0H3HXBgM28aglA9y1tzL7nAIWa/mfa1xfsA8GF4mtDsLUha1zcG9pve6unNRQ16j3+Z9WzBRv6Tf4O5V+z2swLOf8WWZFbJRChCfsmmbtIUpWg=
Received: from YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::35)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 02:38:46 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:b01:2d:cafe::48) by YT1PR01CA0096.outlook.office365.com
 (2603:10b6:b01:2d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.14 via Frontend Transport; Sat,
 19 Sep 2026 02:38:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.0 via Frontend Transport; Sat, 19 Sep 2026 02:38:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 21:38:41 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 18 Sep 2026 21:38:38 -0500
Message-ID: <d2ebea79-5f38-4bbc-98bb-9be353c4778e@amd.com>
Date: Sat, 19 Sep 2026 08:08:36 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] perf mem record: Use the IBS swfilt filter when
 available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>, James Clark <james.clark@linaro.org>,
	"Jiri Olsa" <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-13-acme@kernel.org> <aqsRVABj23jaaiSq@google.com>
 <4349c387-5b8a-4e8d-932a-5175a7598e1e@amd.com> <aq1ceh61m-n2-b0z@x2>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <aq1ceh61m-n2-b0z@x2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 703195ec-f86b-496e-7694-08df15f7205a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|1800799024|36860700016|376014|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ngSk4k9qmQ84NYg4ZlGycCZD2taxnBg9cBP6xdhDSVA+Yn7Np9YyGHotv6bwXIEHQJWfJWkah6LLvDHrwG7WGXOFOfgQyEVtXr0h4bcsa3pkipyRFpiOs9g86yXeDZIKfEttTveW73wFVCVSjyp4Bs7y5vfFwcBo1kzYa8XKTuvs37igyIGt0DWkfrhhm2i75r4ZZAW8U6NO39Fh9ke06SjLib4MdQhxhqcahOub/obGv7qmO8inNmT2oL6rb/IcP5tG2qTXK/J3D+nPD/9EeZ5LcGEAZvRY5yViDgHX1xR4o+RZYzhQIAirLxjheV4A1/qq2F0yM8LkxVwYqh1uJIpNKgMsg7DW/Scc/4Umis32Tb70yoFLY1COneXtZQFWDuknD+nH92Kdhwk+vICkgyYEf6OzfwFPSI4BL3rxR4J7tNZU5TzfDwXl4wdG4g3xy7TLwNi8wS7cgKTurgLNVAPen4NPLYw6g7SDEBNq6jps1wMW3t/D7pDFLJjNtDNeqdN6IrNd2H1MatFVJ9HXpmk8Ev4g1i28L15NjEHz5/A51EyKHu+Ea0UYA4wxWh3CVHnCLFExquYoF9NNq4xbBeh17ThroGgn3QFZGMVWy5zjaTgWtk5i6Y33HSoIsyY+5mHRp18IJhvgSfsLD10s1PDWm55W/cdGM+dpALQ2VC+voU+5J5AQDQdtyDkc30HPnxIfNyf2TC1avJKaAv6Xfw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mo5J4x340CxtjNWU4wxUlYUsqnt8Y+UQ62f3QBPsXOsY46m4uQqRMJeZ2EL1Ehr3xOfKLEGKAWm9bGawE8AX1sS9bm1K2bPszW52b/iTsXHJ21bm7q8D6H0flm+KEPHPxyPhwPvOpermxlH5bRl0WGAKkcUnfChdzxaY4aDKBAUXeodlNXyk9ca3FFzw5PMZbEK3Host/vF3z0L5Onl1UYUUqXlDoQinG0CiUH0GfUqDMlcKrgwErOBcRMEfGUc6yJ0iUVODgC3L7QHL8TE4lUmtCftuTaC7pl+2LGndHMI1VSE3zjGljphZwir+juk/wAoHgZprcUD/ZW64HNdOJjs4AHvt/o4tklPqroYsbiSdbrFk9JcvwhsYVpLEHQZr9IiW5yOq8AKWnmpt1D9Bm0oSCYUVylXYQ1NvGp/AASib0qE2SoS6FRMUhszFfrBz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 02:38:45.3373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703195ec-f86b-496e-7694-08df15f7205a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

>>> It's a bit unfortunate we hardcode "swfilt" here.  Probably better to
>>> have it in the mem-events array and add it to the name format
>>> dynamically.  But as it's only needed for IBS, I think it's ok for now.
>>
>> Something like this? (Untested):
> 
> Seems ok, I'm trying to use it now, ok?

Sure, Thanks.

Ravi
