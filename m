Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612B18B0A;
	Tue, 18 Aug 2026 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029163; cv=fail; b=CReiA1BtXLduirKbxXZeGH/35rQUqNJIbA+LEBW4CzGpGanOKiJswR72NL7byp93v3FncMfGqPo3moRGudyuPGNrOegZTcEW3CpLCdSVclrRvAFA0D/WNsdqg2LfPDZAfgDvCXqJuMfT2MiwZJzJZCe1SN51WDg6S06X6cbKbes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029163; c=relaxed/simple;
	bh=wx1jAQlpqs5a2Iu8NDE+otly6eCkTxLYs8Xd/RAUw5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iBkz0DobO1qTV+W4Tr3DqPegDCt27eqnZxUtUhb7PwiElXWWwfsu9xgWCO8EB0iBkgieXP/A1YwEJ033HZ5wPHPhZSfLdQ9U+xOxsC1mw7dY+LgqPZshCr8188fK9FBVP28QlNkUCx7nJ00r+Jc7xdJAuBW4ShOKCkUUykn1bVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NCJMTinF; arc=fail smtp.client-ip=52.101.53.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NCJMTinF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcGI4sCsDNxgh6Y4ZV11JCDb2CRVZgiSCStH83ZRdjrtnuOohP0flyuK1jp9asiufnukp9AmwKEo8xT7FVEbHTLwgNhAzo93MEHnOsyNb9306PYjbvC5CPS1HfP3vi6vnVVhLAR31wxO+I7Kp0v1lTTOCe/nnPqka8LtCtVuki9az98oALDlyMQhYyZOeeQu/FqZTtrRzOih3UXFK+WMdEReImKOzSny9y0SSJ4yE7ut+ljDgrgPXEPN5wnnAc22BHv3/Ph0mEFw7aYrBqm/Sa62ANkR43piUnf4BCAAvtwJi5ZbRDcM/lelwvwr5syA9oNVgAQzGogZgDFagbn+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enZrtro2tzrDpEeyOsWo78Qrmw1iGy9c6eVYiR4N598=;
 b=r1k9QoxeCgRxmkqKadrSIQHfwkkEABF2I77PBwoK8PUJerJPiT2RJrjgi3NCdU8h6EMfmIg7bmHY/MfM51xJEOq3/6q5RntJkfdF4O3IpM3OctHpnFr/H5RqXfdhxmoZsJ///Yg9JlgK0VUfHMbHWX3zJsjj5F8ZK7cMYtd7vjlIgyhQ09Bno/2Ly/xoyRcCaMbbf1XFKybrSLRvE7jWMKyXo1u/9wh3AuMcwfQrSD3ce5m/oYHzYIFsoHraZr/wiwP44sHlHiSGAzQE+rMYXAP6eB1soUxAo8fnwK1JT1iyqSinxCiYgPB4d+vcGTf/go9oeimVNC5oV9oiBfkVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hygon.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enZrtro2tzrDpEeyOsWo78Qrmw1iGy9c6eVYiR4N598=;
 b=NCJMTinFfR7WIqaEqCXLtQZtp3jolyM3GkrNIwF8nJHJOkjQ9F6Gz62nfzYPyBZeUTa90nB7mJ+8HqIYNkbcmfxD/6qM6entALTj5xrlkW91yr6YmepVEkCUpHLIL1Qj/ybww7kgm1omv8xg58Rt7eOSsWJbcwdmW5cQfZNTGdc=
Received: from SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 04:59:17 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::58) by SJ0PR03CA0378.outlook.office365.com
 (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 04:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 04:59:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 23:59:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 23:59:14 -0500
Received: from [10.136.43.11] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 17 Aug 2026 23:59:09 -0500
Message-ID: <9a39e681-3184-4841-9e19-7fc40956e917@amd.com>
Date: Tue, 18 Aug 2026 10:29:08 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] perf/amd/ibs: Report physical address for IBS fetch
 samples
To: Huang Shijie <huangsj@hygon.cn>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuqi@hygon.cn>, <lijing@hygon.cn>, "Ravi
 Bangoria" <ravi.bangoria@amd.com>
References: <20260817073323.2504767-1-huangsj@hygon.cn>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20260817073323.2504767-1-huangsj@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: a397a9d0-7ebf-46ea-5c3f-08defce57428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jDZ97LdmQ0m2BP6b5z+4DyJOHN+mGVbE/9g9fpTOAzczhOnfQRDcBHPK1x56BgUzDeDq7nW2SH/bEeI2JGqH13slRWvbV15V80nCvehfOLeIojf+uFUMBDyPUyg35Mi0TIvh8BDroQq7ZcW+Tbb4nM0ah5ERtA3TwAbN0SdsmVC4nI9ESo1r+CBXV06PNroraTmWV3P/PtZpiOCDrYC89UOg3hNqpAIjhUHoZk1IWBm0Yl/X8AavX4Kq65/g+ToxRuUBQn4/LaNtE6TEVaGNJGFvRSBz5p/YdBW6+uwrQCmS4aUshP0LRblIEDQsb/FRUsnzusJrLeMybDKLCzxzpW3QW/wWbhbzPEVIGOx3FxUUqmjW9UYPtjlRYxs1OBSgUIPJtVlIbD72nEjujFdEvzHlm6W7t0cCiobL3GA14+7tHtH+EnTMyMyJD8nsx6Nr9kUio0/UgwWMWEL9KYgFo/lnpNSsCzoPUEOtCDPNoFkAjrSN/SB91dcv9W9e8uJ9RQ+0IOx1avgKT/ayOpQ9CY8OOmTSg2xJRcclHD1xZSebYrUta2vITmC9AmiPmyd9X2APfrNSiDEYhyWHWb97KBpzlaoF5muwpuhk+BcLIKg4dWiiL4Jphw2k/dbYX10bNgb1ldhFwbw1Sf5gFiUya+qY3WFckpaY3/SjwKM5kDqmS5uhcdDWiTDWg34fJtONI9Gyi4QX9CLVtwSqwhsNAg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VVNfzgYNkyNIy6fA77atvtFk3CdqAJc/ESVoaDQdF1HrrnK1PFFyxcEKySn+Mmp54WItoggGfEeUZ/7eTJZ1AL79EOHoxphD2jC4zlCDDibko5n5uwxn8ywu0taCR488aV0r0qTngsmfMz4s/Ot8c+sRLfiM5yMgqaGozXELgwJohy0G/lxfYARHmrhxpWEg9YfslxwxAExOrmnQ0pLBw/SCzTPmkR2NF67efs3HVnU6ZLenNAC9fvG0WFNMHrSvWMZfZV4I68GjfIxCTZ8cjOd0FVbHp7Vc0t7FClh7VwAxsI5ier28ddhk8vIN4wzNkPbDCcH5vtw36jG9aSBSsfHhVEJIPxGWjqWF0US/MLVDwYmKOqSaITlA23YrdXDwviFXcJ8cFUHhLHlETcshxJzyGANAhgO7arUalToB6XMuoB7988Rgztmks3Znp8WI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 04:59:15.9023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a397a9d0-7ebf-46ea-5c3f-08defce57428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662

On 17-Aug-26 1:03 PM, Huang Shijie wrote:
> The IBS Fetch sampling does not report the physical address of the
> fetched instruction even when PERF_SAMPLE_PHYS_ADDR is requested,
> while IBS Op sampling does.
> 
> This patch reports physical address for IBS fetch samples which can be
> used for profiling the running program.

PERF_SAMPLE_PHYS_ADDR is meant to capture the _data_ physical address, which
IBS Fetch doesn't provide. So, repurposing semantics of PERF_SAMPLE_PHYS_ADDR
for IBS Fetch seems reasonable.

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi
