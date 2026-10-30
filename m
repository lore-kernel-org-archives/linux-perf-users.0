Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793333725;
	b=0vTKU169WUB2uwbOCqq7vEqgDYTUHhJac8cm6/c6yN2T/sutJoUDbVr20xvSQ3VNyREF
	 ZgN0+rQjBQGhTAa7+uAYmMUew8D0XIDXL0tObo3l8XSejUc5EGLqpDU9DVQEQSI9GCXVZ
	 VIQSrJu2Swuei8wkA0Y9LG0ihJ6yScH7k0tET+Lj3gUTc4Y54jgFsUqNPXmCUPg3L08pF
	 wLy/BNOB9beT8CvrdzsyJ3s1+6uyHSAnk/5PWSN7PqgPgZjZCi5vQI7rMZCOD3AvMy63t
	 yN1iCy7paQH3X1kjWB5UaY+pGGWCENeA0PcOLo0uvjTul/PtIYM/IA4P/5ve+jdPckw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333725;
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
	bh=Xz4xFbJf08+YiAPoC5ryO+QPDn3xPWoH0ZWUiPKnLQo=;
	b=ky2odlpiO0xnIiwWoSUN1LD89fgws2f4+Yun+NG3rEYwNtTdDGOBhfMniW+AAgoJYmZj
	 JCUUlV4/BoxQje9xJOIcob90Cu72El+cfk/AjEAkJ1wcqxnMJTntDIWiC3rFSkOt1JYoU
	 nSjviAJwv/kaqWFScBIGw4QBGdpkKOQvMJ7+XSl/JmV5Io7IlDwNTaksHTmqMtjPEaLz9
	 FeX8h0blmaKVRTrO4xDiVFvMGCqVL75ihlHHk+FkR76HYLmKD7zRopDgTCBbHC5CUuB66
	 olIzPdUlUnJMPw8WMd9KAu4LyYOjZKyLxZhDQPgP9rztahAqBZSTMe98aHq+XL4/8Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BQOhL6Op;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.65
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E4606A31E;
	Fri, 30 Oct 2026 04:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 194E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BQOhL6Op
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf8TgBZBJYh6cPSFqj8m9NfXpchh3eQTBCiPR3WYGW4bFmAO2rdZn/g3mN0pOQg60Sr+5a1HT47vj0epbM3JsbRAmg8xMyTOMTGtzwLZGQ5FbHklSb1i/8bhFthoL+gckgYAyL2zKq+TW92g0e2TbqCKdg2C7X/XyLJIXAZKhyZ+2tYXszw+vtWcGTXErrxRUWlkLL9DixFKWwE+vL0HjNdXS3RUo2E4ULVo+S59vGXLCb+nvKdMnRVgjar2mdmOj0N1zn/u0aiOkLyts4DgeWMZiCm4LJ1Skh8C1PKd/Ib26iSrU407aFU9Dr40oyw7fjxHlOXatcyzsjp8kFT4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz4xFbJf08+YiAPoC5ryO+QPDn3xPWoH0ZWUiPKnLQo=;
 b=ok9RO/t152uCiS/4y+Kib20zrBbA1Xuda+LLvwfDo37qgFWDblkJadXnFek5v8NZDKn0KNc3ed/NyYJrRjcRB7L62gVQxSop4Ne+rQ3s52Js9PCUg43Ho/R/JMjEvm9FEmBhrjwHs2V81XXZE54X/OPxgQ+Wn4e3vkcuFQ9WSvYN4ThcmwquReVWbxDrYWG1rT7A1hBTC5iVy4hguth1CiP3HVpi5KJhZiFXiqyknZmW1KE9Nkq1yKJKVK5PpHFBiCdJQNuTWWXCru5/nAV3im7Ax1kYz02BkNxKaok0RhptdrlUefJEejBUNsI8AjFQgwkSRCZNqG7dKcRBDMGU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hygon.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz4xFbJf08+YiAPoC5ryO+QPDn3xPWoH0ZWUiPKnLQo=;
 b=BQOhL6OpP9lA/M8G7apFFS9Yb42iy2+CZL+12Q+qcUf+y/QAOM018auUI68gbyGCeGqVkA2uiVz09pQ13NtNPEqkbUyoFtmrIS0xIg6rpRTQf3fWx9nF+TrGtxDw08RylGjYRqZG9DnvsHQ5mN6QUJbeLbPthF4b5PlPuwn4/gI=
Received: from PH8P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::28)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 04:15:19 +0000
Received: from CY6PEPF0000004D.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::29) by PH8P222CA0027.outlook.office365.com
 (2603:10b6:510:2d7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 04:15:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004D.mail.protection.outlook.com (10.167.247.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 04:15:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 23:15:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 23:15:11 -0500
Received: from [10.85.35.88] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 23:15:04 -0500
Message-ID: <f151155a-54c1-41b1-8905-2347a1404001@amd.com>
Date: Fri, 30 Oct 2026 09:45:03 +0530
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
Subject: Re: [PATCH] perf/amd/ibs: add phy_addr_only software filter for
 ibs_op
To: Huang Shijie <huangsj@hygon.cn>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuqi@hygon.cn>, <lijing@hygon.cn>,
	<wangfengyu@hygon.cn>, <wujianyong@hygon.cn>, <shijie8@gmail.com>,
	<1537577747@qq.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260902085251.4046240-1-huangsj@hygon.cn>
 <auMrUXp42Djz3zu9@hsj-2U-Workstation>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <auMrUXp42Djz3zu9@hsj-2U-Workstation>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004D:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cb2e93-b79b-47b3-770d-08df363c67dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|10067099003|4143699003|11063799006|6133799003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S4qpD1FJ3hKVqOEl7UTsoPwVry8ZfHEQFhAsy/KRlQK46C9XnWApT4jfWtjdxn/cS5IsaX9xaE/KgZDY3Y+j97f1oX0dS2APCDzGBPznzrq19PbTLUTLNC1+jbXG5JI4OfqMtfviD7lDx8gQrsCOzVajgVldWmn99+banWYpCweXNOLsAhhO2hua5mVZRlL7+gdkUIOKfTVHiuyEzqQT0KKxvgIZeArFkrJ8JKYFCkhnr6Cx8svUvwzoQ2hnr+2O2kt/M/nQBoCL94bFnMfPCZ8UWuEclieEfCRqy8xo97C2z77cFBYWLyMb5/3hisFWVdPiKrBAnkosXg+hjiDXD7Xvv3ngdNRfxGN0ViFtZVaQtuYbTFWHE6tvVfHgwRGY806hOMQy9Du7zZtzLt+yuDs6N9qbqtRgs9nkTmn5ZuxxW598nqd2uuKNp6PxgEUtar6JiYmmtaRrpUD0qpQ6g44Ji8dr/9LzKQvLrR139NVEQc8C4Q9CB3DRd7gNFu2YXZaOnjbke9SDFsNvExUixFCF/CRtAG2sCGChExoW5QMYOOlJYiH4Rmone2zp7iV+CqEdntdAQyDHz0bWM/Ua5ljU9/MNLUOmXqxPYEvJkVVOGoVJ+IC3XJfOuiB7XELrv+FpFyWdqGcC71UWq+7/VFrjk6qesEyvvDmrF0K63kklFJdpCPxQzzy5+6K1Vy6gd2zgP2GGZWKAsXrqlSTX+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(10067099003)(4143699003)(11063799006)(6133799003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n6W1sWquc/SxmWWhkI/kPnlU5/ByLyfstAdbu2/DUaqPBuTEZCCfLPiZKTEaJEA1C9cxQ+crIcbmVhR7eYpi3Nv14M03+L34Wp2SgAA/JI1AlXSY/qh7bOxTkSncWPnHWkZ68jt86B/NC2r3kGunWgJ0E8iqwxMaxE+eqOkgehl9GUeIw2GFRlpdHStKhJAQY1su3xHklJw2YEemwW3LoZGHtVnqTofLmTYII/9luOQLk9NIYGHUi98O8ZxyIb0PW5uf2980dy8+HbWfVQogIQU1VUjSXL6VaP1sseuu9xgyKb73DlsH+sEP0FrCRdKYIFgs7FTOVNAFKxgFQ6M7cu17hGoaTqsRlwSXUuJnLEsMR7wRHjtUKzlTkXsjuAI1EMXlKnbaeAgxh0AnXB0C6dKFKvIX/MCuNPpdy2mijZ8LXsPFG1hANqEvtq3OfczX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 04:15:17.7464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cb2e93-b79b-47b3-770d-08df363c67dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777

Huang,

>> Can you please confirm if those additional samples are genuinely valid.
> 
> Yes.  
> To answer this properly I re-ran the mysql test,
> and verified the physical address of every captured sample against
> the System RAM ranges in /proc/iomem.
> 
> Setup: 384-CPU Hygon box, v7.3-based kernel, MySQL 8 under sysbench
> oltp_read_only, 400 threads.  Each round is a fresh 60s
> sysbench run; after 15s of warmup, perf records ibs_op for 3s:
> 
>   $ perf record -e ibs_op/phy_addr_only=1/ -c 100000 --phys-data \
>         -p <mysqld>                    # my patch
>   $ perf record -e ibs_op// --phys-data --filter 'phys_addr != 0' \
>         -c 100000 -p <mysqld>          # your suggestion
> 
> Rounds alternate p1 -> b1 -> p2 -> b2 -> p3 -> b3 so both methods see
> the same load conditions.  Each record's phys_addr is then dumped with
> "perf script -F pid,tid,phys_addr" and bisect-checked against the
> System RAM ranges (read from /proc/iomem as root).
> 
>                      samples    phys_addr==0    non-zero in
>     round  filter    captured   (valid=1,MSR=0)  System RAM
>     -----  --------  ---------  ---------------  -----------
>      p1    phy_only  15710042        0.10 %          98.61 %
>      b1    bpf       14041851        0.00 %          98.55 %
>      p2    phy_only  15580497        0.10 %          98.56 %
>      b2    bpf       15416187        0.00 %          98.58 %
>      p3    phy_only  15732582        0.10 %          98.59 %
>      b3    bpf       15447397        0.00 %          98.58 %
> 
> Two observations:
> 1. The validity ratio is identical for both methods.  Of the non-zero
>    addresses phy_addr_only delivers, 98.6 % fall inside System RAM --
>    the same ratio the BPF-filtered set shows. 
> 
> 2. The only set-level difference is 0.10 % of samples where
>    dc_phy_addr_valid is set but IBSDCPHYSAD reads 0. 

The BPF filter is giving more accurate data here because neither kernel
nor userspace should access the first physical page:

  $ sudo head -1 /proc/iomem
  00000000-00000fff : Reserved

Thanks,
Ravi
