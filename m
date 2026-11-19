Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795063336;
	b=RwQsPrNkrjuVWSEMspB7PXNzcMHifk3q5L8fTBpXoYYaPLsV/G23cn6250r4X/3LuxI/
	 20ueubmrxYjiq2KdtlK11Svf8iYCfxL7NarXw0BnXNqRadfDSUTxUxLvSB2nifqLHwJG8
	 v1PiDT0N52YJ+uEsfYH0fKQWTYFsI52Bj6Xtzp1c5yywZT1oJjqMGd/Nk91TkZOD5vpOy
	 gKLqF1qrQv/DZn8Idx0SMh30q5Kl//t3grO4gzy+puFuZgDsdtm0FM/ha1NTPC64AejqM
	 gvEZsJemNWox3/eWeyYFkbE1nu4Ak1hWFWVeiq4IZu9RBFZl9vukhDSpzMVTX/IEmTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795063336;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	bh=H7/Cba+wgihdYbt4JjwHiaV4jV74MhNKlpm0JFrfTPc=;
	b=NUo2Q7cOr+rRr0zZE1WtQa03BZlxhRCgbgLymW2m0JLyAZrEI1xnMCaRQat5N5a7uujG
	 E+ZIKxZz5vdy6Oa8cb4c3OIkb2fwjzfiDMtZfEiIT4iFqr6yHipBjXI+ki2Fd/wL5ou+1
	 xyJRV1jzDI8Eit8tMGPc3tbywiqKuKum8klCqiVKZdT42QH7BWs5YZJ8idmuALldtQMTd
	 MDxl+aNKibklpkae55NOx+06oA3FBhKgO3WtxZxREctq9oHNXOxlInXkrK4Ue0X/XtQf2
	 3QEwfsSFrLQZQ0DI2VJJC7QEoFpbybn8K5Lyhnzu1wSQyiOkTmI2vo6+ByxHt+OE0Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="kkk/WMqG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.39
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC80606A331;
	Thu, 19 Nov 2026 04:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFC80606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kkk/WMqG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvXo+KEVlq25L3RhH06l16nus81UV4W/OcL0sRQYaTdBZnT1raru2QeISFgw8LJTk0jqSHUJYl/q0nxXkOk3oht4K+ZLOcyiUO4rJShKDmnOt+FhhspcUYXHCYgY06ZBqXUIslgiwNyUOjDNps38Vevm7TFp2vb0IFE5zFdN/A0qZJQSBBKgWqN1Ik0e1oPn/WREiuZAQtmOH9eb2E9G/1nL6pmQjOMpfphPoG6OURsDnIOxagKbBNjPsx7SXiyPf32ZdIPo6u6njXEVUsht84mlenNChX9N0vqZrvxhzBBQVnV6VFRReaIFdoECfP2RQQHCf79CZgOBuYMcfiVh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7/Cba+wgihdYbt4JjwHiaV4jV74MhNKlpm0JFrfTPc=;
 b=x1yGN28YSvpVLteuOGZnN5Hb0+F/LrWihLrBr01MpXCpJtgZ9L5pjSL7XST023lJmH4BscNG7EMvyhNQtt0eZLakSpFiJT8uQ8T60Ty5xkMCUWymcJkVlNWrFssyhR8VHzmT55GVr9P4EMgtYk4RlH8P5qwD+HaMDSQCn9FacrRWjU6CWQ0c+VehKP1Ei66GKktfzpyxUyq848TQsAdoDmNFCEJftXOSybm7i8vAWEF8DXqtNxYaKuMf00Ay1kYRcvZFCr9GJu5S/AIQ+NnEk164nqRhZp3jWjkISKQ61q033X/3oFS63lquFwTclhQvQlOEHdf9wF7a/cClRyTeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7/Cba+wgihdYbt4JjwHiaV4jV74MhNKlpm0JFrfTPc=;
 b=kkk/WMqGAYHKVtkmR4LnarLFI97i45KCuEynYbFwDXMNa57ciuC/z5N4svMqRdr1RnGE0mqhWjCf/LI9s6gHwJ0gfCpqG9sM/w4CiEpv48scLjUIQaEC+IpoT3Wv9iuKGn2JNG3sbFGUkg5516y4wz1apUAOD9CdFPVoNUGbGZo=
Received: from BN9P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::15)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 04:42:12 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::50) by BN9P223CA0010.outlook.office365.com
 (2603:10b6:408:10b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 19
 Nov 2026 04:42:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 04:42:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 22:42:11 -0600
Received: from [192.168.0.101] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 22:42:06 -0600
Message-ID: <664ee2ad-d11b-42d6-bc9f-85f88b5e6f32@amd.com>
Date: Thu, 19 Nov 2026 10:12:00 +0530
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel
 branches are recorded
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Puranjay Mohan <puranjay@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Thomas
 Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>
References: <20261023124157.75524-1-puranjay@kernel.org>
 <0f97689d-fdec-4cf4-b6ca-4365aced16d6@amd.com>
 <CAEf4BzaPDnopvSoS=AwN-gNPdzD0Bs4PvVPP+qCrdBFQ8CyJsg@mail.gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAEf4BzaPDnopvSoS=AwN-gNPdzD0Bs4PvVPP+qCrdBFQ8CyJsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: d2212e17-3306-4b8d-9419-08df45f77a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|7416014|1800799024|18002099003|22082099003|261009223027099003|13003099007|11063799006|261026140227099003|5023799004|4143699003|56012099006|10067099003|261021123027099003|261026121527099003|261021121427099003|261028144727099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	4UivDyDUlptwq+VPqvUN99G+ukFk6svSs8ZvVNphXCnEUBgq029LYuJt+ypUccJASOk2CyQUshgr9UCPoTeh/1wABvI1HamO8+mG2av7K5dvsbE116tjimGo4Xj+OccOSDyCEqwLRsMtyTMQAxEubTdfiJNTbLKO/HFRvzByuLrP7BJ6QyoUrqrUAAVZqg76pwXcXrs1qFevJRnxpz98FynEZe+QiqWYD/puS2mNPdkETlwvRtAJxyFtyhJtIxjlFU1h1FayJkHkvcHPPkdLCEAfo5cj5EodBbsxvMZSTlH9FKmC63Ed7TRrVpQJIgqzdBsyqHuqJ6BC6wMjkiaLHFubCgkPWb+k4yk3SyIgxMpCWfiu7DMKfBbBQ3iSzGz7K0uDhZxdiNSxDC5HZPQTdiQBwbGZl0MaOI3tjSICxAAG4Ul2ZwYAKF783nL6euS4BKafSulg+8d1YGKXdaZX62uoolMV6gW1Puu0zY8CyAQlVDw41gfg4xzyWeBm6LbGdrvh018J+XpoBR5yp/NEeGI16ZqYe+P9LDRmUo49sYSHOljGfU1oowE9IideV8eTBCoSKeC5ZUBD+zhFbtloCOi2RDsKZw/agvWU1LZy2rHBPIwrmCMTSNUwFwEXur9Amcw/iaUxiuogiJ00I7xtXw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(261009223027099003)(13003099007)(11063799006)(261026140227099003)(5023799004)(4143699003)(56012099006)(10067099003)(261021123027099003)(261026121527099003)(261021121427099003)(261028144727099003)(261022105027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XE8kFGyCxoTNXt7LWRoIeRXpVMjFtyW7cIzYKeosg5J48lHmUMvx/T1IBwIX9tK16NtJc0pRJPrvdg1dNQJ91qGLU4wEc5x/Ylz5p+Xpq3Oinav+2Q0uzJvqx6JkYZiBDNXueeGZaHAgVUNvkSQ4m5exXmtoYwNQ3BDuvo/Oipvt4bhhYOCQmXAC71VvDpJ7YYBs6Kf9VsKhGPR3ZeMfUsURdiv2SQaIjzTvVQ7W9RHsMyky/BilNVFjLWNZbnMl4nxNtKKPmcaNG8sPxhg9eKXe98kXbq2ia5sueII3ULL/egFJ1bs5gD4LTqSR2ru5GOQnLali7jxmurEUvtv3//aiytMPovuBrWCiJe5U8EQyA8yOzuhCi8cUpJ2apathYpLS5DzUnLz2WcmdAJr3yRpBp+merlXlThPP3Da99ZRiYA8co8MzdUqMDYvdxD38
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 04:42:12.1458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2212e17-3306-4b8d-9419-08df45f77a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899

On 19-Nov-26 5:35 AM, Andrii Nakryiko wrote:
> On Fri, Nov 13, 2026 at 7:48 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> On 23-Oct-26 6:11 PM, Puranjay Mohan wrote:
>>> On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen on
>>> PMI, so the branch stack ends before the IP and callchain, which are
>>> taken when the NMI is delivered. IBS rejects branch-stack events, so
>>> there is no precise alternative.
>>>
>>> The freeze only keeps the PMI handler's branches out of the stack, which
>>> matters only when branches into the kernel are recorded; without it the
>>> stack fills with the handler's own branches. A user-only filter does not
>>> record them, and parts without the feature are never frozen (see commit
>>> 598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")).
>>>
>>> Freeze unless the value written to LBR_SELECT, which is shared by all
>>> events on the CPU, suppresses branches into the kernel.
>>>
>>> With perf record -e ex_ret_brn_tkn:u -j any,u on a Zen 5 part running
>>> CPython, the function of the sampled IP differs from the function of
>>> LBR[0].to in 84.3% of samples with the freeze and in 0.1% without it.
>>>
>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>>
>> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>
> 
> Thanks, Ravi!
> 
> Do I understand correctly (from [0]) that we'll just stick to this
> patch and there is nothing from Puranjay's side to follow up on?
> Thanks!
> 
>   [0] https://lore.kernel.org/all/5cf60aaf-2ee4-482f-9054-dff823710431@amd.com/

That's right.

Ravi
