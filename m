Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAC33FE0A
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451469; cv=fail; b=cUCrtoOLjsQkmsl01pwHSzZdt5KyiIp4mh8Mi0s2jI65UPc1tmmu1coclV2JYYH+3AVhTO3dc+dTdxzrwq4ABtXyvyzSw6SLJ9o8NtBbSDkDPNDtafBMJNwVECDWVl+w4vq6NnIptNh6n/BAStw1lmk0CZB+hsfTIBR2egiHgBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451469; c=relaxed/simple;
	bh=i/C/wDveLwjpuMd8ALKfmp0Tqq5/gl9+fK5fSXLWYOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ldA/Cx05euvPuNwYQleq1y7vc6HGPVkvOPzUzr3WOn/lHEmJBBw0Xcq0VCCj2tn6u8BnIDUbIyiOa8LRyv1nksyKy+slr+OzfQuRZTtfTaVaqY74x0UyMERxT/JPtxCS9GGDOdMB8J877N5ohYBgVXWI2VN1thy74nrLb4pZBxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fIgYxP89; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fIgYxP89"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLKP2U4wtd7kux/cS0MXu+j/1k7qpT/UQWxzgYA1NvBZDwW0oVx93H3O+wG1pSxmBxRPIH6wGg+Uj6lfbMyCmYTpAXfA53QdNBr7YxM2D3T2ISJnRSMEmuGzGiu+sBRve2Gv/w0oMczWduGaJlM6ARdzHV2WwE6F8H4i3oICVHOcfgefgdSqm1uRuZzeps7dB2Ggo4HxXnPE1NYnJR4l2KsSY2Xee55mTWXnYetqDT8KJOAuf6+k77ybIdhvi56Hb6ghYRyKc7MWMzu+9VfgyUzgk/LMlB+5kfIrjBpIAQDfXPUz1wMhGioZ0/dIma6oiJxUCSS7HmqBOUbeu682KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yk//IWvAJca9X6w7Pwgk9VdK1sB536CCFf7FZGszr54=;
 b=CPGl0Hc+8OzV410QYuNWULUUN2P8fQtqmRLcZwxhwpBDO3ShY30fG94nOofinZtPY8uTnadtbY1WQi9XXZqtZQyg7vSk6X8n9ndsqUWU7PwDGB0jkvjvxeziu80kiMAQpOnyi8D0cHKspUu+9jP4TrxSIRcvXnPEhOZwkbxXH7YEuwnvoIN/EPbtPmAN67kulriXyGsDdMgNg3f7nc3dyl/5/x/8jOAj85ROMRb0DJtoRGKB3tcY6eGa5YzIh7i/8KrDMx++/s0lIR7yAI5L7MGLYTykB8M6JPrQq/BWA1vDDMRyjJQcTf7m7NIcKnYWDLSLucpRmerMTB9M79BmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk//IWvAJca9X6w7Pwgk9VdK1sB536CCFf7FZGszr54=;
 b=fIgYxP89qHMrQ51qTrTf9X2Ft0F91Y3p0ZU3hJt1ZqwysdApNRvnTettBtHGuDd2SL3twqnibBN7azRrqd+Msw79SJ/YMkGrfll4m9ztGnsCHZ9LZX+ofQ0PMcxc8BefOhLs3T4qgYKgeUkf3/k+tyIdDtxouQlaDi7C35U7k70=
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 16:02:58 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::2a) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 16:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 16:02:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 11:02:57 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 11:02:55 -0500
Message-ID: <0e5e1fd0-0a46-4c1c-a391-5c245d903834@amd.com>
Date: Thu, 3 Sep 2026 21:32:49 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Namhyung Kim
	<namhyung@kernel.org>
CC: Gennady Kupava <gennady.kupava@gmail.com>,
	<linux-perf-users@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com> <apG-RzV0zyjoC-FY@google.com>
 <27d79477-c469-413b-95bd-c6c1f8a40f55@amd.com> <apbs8gywyAfFVzqm@google.com>
 <c38b254f-21e5-4a02-8934-7a4da61e4571@linux.intel.com>
 <7b4cba95-dacc-4cf1-953f-c59e06e693d0@amd.com>
 <a5d3798c-7d62-43d0-88c6-eec26bd4f63d@linux.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <a5d3798c-7d62-43d0-88c6-eec26bd4f63d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d2d4f7-81e9-4269-f9dc-08df09d4d264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 tIgQ9gxPpiQ/4F+CDkti/EWy/2bu3RdjZdZbuT0imvzRNAxhedYuE8Ml08K84eabIX2VGln8t8i+UjbPt6y1lHP56w6FC0xBeDwUwd5SBVCxtC+2OPg3kAW/eiRT9ge0IhIIINMCl8TUG0pLItqBmSSlNrXAcn8eCuavjfJ/nvPrXj7oDyTeNEkB7wJUxZczkCS1G11y0rEjycR1eO5EYGR/HrnskBaxDpKT6Gxc4BDBlQJrQmhA2mB424IvGTag7nLRTB62Yv/YqvWerwFOF68EEAi3FLrccdMQyZahu+FU6jexpBoStyXmpTdqmhBHTPQZSMXsJP+E2VUQj83H1422IFBC26PNXFIX94sXo8uwAnSKwnrZQasOvXpT67JmopfidZj0jK18QDTT6npWkTMa/VIaAH1QKTl9mbeiVQqthZDzRY9lYbQgvd5va0pfGVYWbtLzyXJd6ufrqJF7D7lV00Hh5zo9fqtygpdagju2M8stwZZpatIJAa1PSPlCNwWhkaw3nHbqHiG28g/XTLrSKXSeMtvaSaQzxGGcpSgGy01+fVSG0DYMbjOclDZDgk9KcCK5wViVi7BYoCDMIfq2872c+MkXc0lnDqPw1C5YFQ+66sXBrykl1DrKHwTIAKuEUpzgsdQAgL/eoPuwyEZNlCQOuyKs8SXTklgEK2WhXQt662drDz0tPsOTw7nj
X-Forefront-Antispam-Report:
 CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 nvTttgf9d3nB1ivY0egXlYiYPAm79i3M0g79DxPbRgxkPX4xek5Nq3REPYnVe+5GzodKcKf+bYebsd0Z10DLAHZDFJEbOOAxiHE4rqFy6RpRQ3O4+QSOqi5/3cE0fFgVucVGa0NXdt333kmzYLxMru3bXtwLD8T7oWUPp5SJRKk0I5l0wBpvKkmDCyjLCsxoitNoVJIld6pLQ/Ilu7oULqpMdeh5K8tSL1KJ9Q9rLqsAdNrNSr1y3oUaByXz6Pqz0wB4Y4Cmp4Hz7JLLcBlQcGyUwAbCt8N1QJaAOMZZVgU0X9/lKLbM23RcjSgZKT1FHBgMB3odHG9oWDxap9r3SkZR4KYy7i0yknkpi0xfxcLKq8Km0Uiza4Mn18z13GmAQo8gc1JWPErqeaetga6jcNMSPHfdqmjUrBOFXNBhaKMsj2nmwLnXedfqN1WcUI+y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 16:02:57.6769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d2d4f7-81e9-4269-f9dc-08df09d4d264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

> Suppose we need to follow below 2 rules to ensure the correct call-chain
> unwinding and register snapshot consistency.
> 
> 1. All registers including IP should come from either PEBS or PMI, must not
> be mixed. This ensures to get an consistent registers snapshot.
> 
> 2. Either SAMPLE_CALLCHAIN or SAMPLE_STACK_USER is required, the PMI
> registers snapshot must be used. This proves the correct DWARF unwinding.
> 
> How's your idea?

Looks good. Mind sending the patch?

Thanks,
Ravi
