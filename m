Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794627057;
	b=bbEUrM42BsbFI+unWpXe0SlFxVKD0OLmov5NknDUXMbToamIIhfvU+ZnQup3Yt23hcyt
	 sZMehB0XI9oaqU/suDgRF2KiwE8KCEprE0Xf/Sea4D4BWlNcWu58sY+521dw1BEk7lWDh
	 Crx19SeSec90jJMDFxyya7nS0YND0cYgnRqrKUfpI9y9AS6Ewkm992ZIz5CsRbtDfegdv
	 ekMmSBfrMQ/DNQzY1IYSXHkGMnPRZ4zL7deiphzgPGNvPkXiFWv9xWfatbjOZRF6T4Lj7
	 OIGsrOOhCMfrDqIWEnaqgY4CnSPGw6YFF/ivsIQj9ASdkziSaqVCgEpxlJJKqGK6sew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794627057;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=TShSUWaC/CwznJNFbb/T1JvG1tUcj6WVz7GZW6L8fHY=;
	b=bk2FZGBGg1lRPOsxDfaWQIGychh4LFDJoniWxz9+2+ECLeRk1BU155IKkdpkAC6ba/b0
	 2LAuP8Qlm67d0QlRLxoZtBSa1YMAVlzPx/CSU456uv4TDvnAuxmRm8VStHihOyT2sOdHB
	 2pN4neHF+ZV0klsVfQSYIJMF2hF1xU46TI1F75Fu3e6FDEkcXUlG0t8rMZId6TZH/Lfgz
	 K6CArgSTPQE2WtP79xrP5Uo3VeCwwvDlBDlXaSa66A3iTdTsMrVN3bJeYC8EXWTGeDYKL
	 7vPF6T9ddVMOZwgSjTnmr8hl4J/pYvqELZaoKvRoKR2y0h+LX3hJJdFsu8OJe9Y6teg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N40wROO5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.7
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D11606A889;
	Sat, 14 Nov 2026 03:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D11606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N40wROO5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTKk0c4/Mp6Bxx+nxmIlE1+MRTCfz/DiZxWqbEQfDhxZ+Dof68vHopStmCpnpeHLhWZml3tsenriNTEjXPtanCk91L9j+ucX7YRKiv4fsWuth31QFn5D6aHQ2gXjoNWYMVlZbcXV3W2Eno8SzjgLhFwqAOxey8bXi9hs+sFofze8CeHEFvAE/pbSPF4ZYkORyoD1MopLINh6h1jqY1nHu6qFVtk3vuMwGgpDTUE6jpUuSZE/OKANAmicuj9uYVytasQiQQwDoxNbtCyd+Rbc9WyHbGjk2yKqTJ2n5LbgPGmmRdbpW0jgnpjTvdx34V6JsrNVvMgUXABxeTYGgE/k9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TShSUWaC/CwznJNFbb/T1JvG1tUcj6WVz7GZW6L8fHY=;
 b=EnewR8ZYQ024pokyoRqF0tDqrc481dsdGtSDVUz7osgbJDGBNeS0PXT12IFEBZbuODPz0gd9yA0pCMjGwZiebf30YijabuMPoXA6jh3DC5metNhdwKYGldJdDrv9XFXirAXWfZP88sY6d9R+o4qttq23HNDzuqLLfRq57/mkw8xWFhlfJPlMWyFf4En+EVyX42daXSqbjJ1RmfmYiXXpHA4/2c8uYpl68Ou+qZB7/xxnB486xR+rXQEoSpnDoX19OoTDuzQoZ/+iowX4cZhKB7Y2DgLfwltcOjBmDPXK3IgOvobAWrEtU3XG8rIY4YfR+ik4aQqhir60zI/+ug7BBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TShSUWaC/CwznJNFbb/T1JvG1tUcj6WVz7GZW6L8fHY=;
 b=N40wROO5VmVRjlM0yEMVYZMam6LZfWQ/IYuQvPHQkKl9nU75MswUyi963pNwZTHcbnujku8aO0UpXqYDWWufaaOQEYiwEplOlCFoUFxfP4PrICQMc5Jia1klAcJPQYCk6TT+FbhhJ08aJ/jlKieUbUCzyHfVwCT2QxARtx7EbUM=
Received: from CH5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:1f4::24)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Sat, 14 Nov 2026 03:29:49 +0000
Received: from DM3PEPF000265B3.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::6) by CH5PR04CA0016.outlook.office365.com
 (2603:10b6:610:1f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Sat, 14
 Nov 2026 03:29:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265B3.mail.protection.outlook.com (10.167.23.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 14 Nov 2026 03:29:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 21:29:47 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 21:29:46 -0600
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 13 Nov 2026 21:29:42 -0600
Message-ID: <c52fb4b3-1b9a-40ff-ad6f-5d2325443a73@amd.com>
Date: Sat, 14 Nov 2026 08:59:41 +0530
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
Subject: Re: [PATCH v2 0/2] perf jevents: Add IOMMU PTW & device entry metrics
To: Hang Zhengyang <hang.zhengyang1010@gmail.com>, Jacob Lefkowitz
	<jlefkowi@akamai.com>, Vasant Hegde <vasant.hegde@amd.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Ben Chaney <bchaney@akamai.com>, "Matt
 Pelland" <mpelland@akamai.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261102-perf-tools-next-v2-0-4d237f886710@akamai.com>
 <20261110032232.3080268-1-hang.zhengyang1010@gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20261110032232.3080268-1-hang.zhengyang1010@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B3:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: efc38d67-e7c1-450c-12e6-08df41ff88a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|22082099003|6133799003|261009223027099003|18002099003|13003099007|4143699003|56012099006|10067099003|5023799004|11063799006|261026121527099003|261026140227099003|261022105027099003|261102123227099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	CWkvun/+NzM3U8AzbAVqlGeudf58dRUsYAB5gZXerdFy31PiS7fyjTWHl95yfaY3Kr8heqXS7xVJHXatpu+lMjMbXM3dkaHgYiC21FgRgyE7+qC1iqy8n7zNfSwOb8LEhEqp94d0yDCKkv2r2CYnkqWgQ/Uo1qq+FomK8PNUkChSzyQx9oLpCLP7FpqKEhJQWInUf/CbPYTJyT9s1EXydN648LZ5VAGPgU9CGNJQBmjGwTiSvr3qcTnhFnQttkNVO/ezCdF/VE4sNQ2D+1otWYN8MWqak2AcR5txQO9sE7/Zw+yFKew6f08/1+8ClOVU2/EW/0iFprvf5zlIm32D23p4muozFSrvipJbwhfDqFn7HihxlhYQl81ZXtvPn+Wn13sOoqmZFYv4fpdsALKijOeEys8fWJbbkLbepnZomSMDvgKhsMTul/JAR9dAq/BMBATUAfCvXlHXYymTfmGdllq/cZm/xcKJ7mndXs1NIDHuOQbGgxfuI7PDFxjwf63qXXHismiSs2bwipbpYaiA35mq7HtqtRtDUJP+1dj3InoJyQuCGnEraQBDBMTY/nLDRTN48UXxAWKajUWlw6ki2YXnLmQl/ymZsRcACs9fO2WsEtlU8uBm1WKk8X3qR4J8HhWggQptXpDDnTS3yIVcS7+mJibJEqsbg0jqILeb+IoVCZVfdtthRwMOlbuCAhDzWj0OQuk6WYn+CSqN3Sps4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(22082099003)(6133799003)(261009223027099003)(18002099003)(13003099007)(4143699003)(56012099006)(10067099003)(5023799004)(11063799006)(261026121527099003)(261026140227099003)(261022105027099003)(261102123227099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SNC0TPxd4s5HfUl0kRYmmYXs8sWNAE5TlNQk4RHvCfA1DxDFgP7lX8Dxy92Ul88SLD6bTJVx+wODmeqYsW7KVu+T76Ei80VKbejjZ2Q/sRoJGCzn76u1nLR87Op88jAWNOYmx20JP7hre9XEFAQErdNp6kktuAQoSrwAHCPm7NYX2UMLa5uNBSpiOeIY9sQeg0eL/XgSOZo+QYlQi574rQY+EYJUzLBOXYnVU1DoZ3SbxOmQyNBZyXBo4ImakYfoVBYnNvF/zIZkSgiMc+MkfIzpMsnQshLtTDUk4H6nvNDM/jbtRG+ZLQnIkJhoJWEX+C0SQ0friRY+qNswRMErqYNtY8ApD6Gu4YxmR1WxyJcANHvKZPqA4vLHxtXmwELKfj7YqOFLm+Ie4QqYgN3Blbl4UHG2vTVMhdRzwfrmJQMvYGqSqnB5McFkQdCpi3oC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 03:29:47.4342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc38d67-e7c1-450c-12e6-08df41ff88a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118

On 10-Nov-26 8:52 AM, Hang Zhengyang wrote:
> [You don't often get email from hang.zhengyang1010@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Mon, 02 Nov 2026 21:14:15 +0000, Jacob Lefkowitz wrote:
>> Adds AMD specific metrics for the IOMMU with respect to page table
>> walks and device table entires.
> 
> Tested on Zen 3 (Ryzen 7 PRO 5850U) on top of perf-tools-next
> 13a8d580433a.  Both groups show up and count, perf test 130 and 131
> pass, and under O_DIRECT reads from NVMe the values match the raw
> amd_iommu_0 counts.
> 
> Tested-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
> 
> Two values look odd on this machine:
> 
>  - lpm_iommu_ptw_nested_read_ratio is 100% with no guest running:
>    page_tbl_read_nst equals page_tbl_read_tot.
> 
>  - lpm_iommu_ptw_reads_per_tlb_miss is about 0.2: 142588 page table
>    reads against 440805 pte and 192018 pde misses.
> 
> Ravi, are these expected on Zen 3?
> 
> (Tested with the help of an AI assistant; I checked the results.)

Adding Vasant, as he is more familiar with the IOMMU PMU area.
