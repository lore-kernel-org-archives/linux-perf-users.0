Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794628107;
	b=ZnOfBZ97673TbBUwqdaOMXvNEi8qQAar9z3y/K81DltLLNvnGjRZZEas0jt9ffweOye1
	 SE7Jys2sE7zt3geVmVb9WHxJd4pJBalnLfUMwScrBONOa8fIDS+o74tPbHzsB5UC9pIhP
	 AGat8BzwbUsorH4DlArl1nSwvUYfhe/8yyadgi6amZPSQwioOYgZUzJKOjncMiFv8cnIK
	 4073b0x9IMqHQl2R2hVA1d5aMCuLCJxC3Rgdjjx9/E/Ua3ME85vYh20LRHYA6mSjsEX4l
	 1xYpQ83XZLndIR5hzIx6FveVophw+c9v6h81Ccp8kNaA9NUsrMtJfNVrBiMQX2GzFWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628107;
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
	bh=JJH3AVBt65FbrWGuHJlyAnN26pEcxdMNdGJRaBbEO/4=;
	b=2qpeuCo0d5IvsdzDCV2NRcQEP1vgJ1pXtsPc6Lxmo3gtr0PinLGGts3ev8K8RgLTrQAO
	 fXR852iTA/XFFR/Bl7eFiUTxSwRvnclhwewZtg6qZU4WVEjjf/9HS7warGSjWEXRv7o4a
	 Ycx3SFkRLeY+P98414AtRpWldel3xzJ7+CQLZwTBrdHXSYyQJydKAyGWjeiwAbvKTNPDc
	 7DPEpD2pL+jYtfyEaNTezXDFy9muo0Aw+eUbntekKt3AaOZatMa3gji5ycGaahjeDolof
	 QPmhTfe3ZkazSuHH92qjB3D3Gl/GsFbQBcru0VfQhWVoxQTQhlG3OsNcHzGuvAcj0qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X198apLc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.65
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D14606A333;
	Sat, 14 Nov 2026 03:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02D14606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X198apLc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OingL1vLHFxgmTnqpWBjmarVROvIkRJCFmawZilnxONwfa2QVYO9U6LmMfP8I7TKR/non82knHphMpC5XpcijVwjF56i+/gD63s2mQ3s9WaASPh6l00MQbhcn3TQMdhEzTiiKg2mEyoMFxtXl2AeHEX07Psw//JvVu1JXZNU/NIWlx8KRDh+VC1rTNXekOTw5a4/VlmomsLLluAdig22RI2cjK5Oz3Vh+bP/Gs2YTmnDeOaOfFX33rUT3hhUPMNcIE/w8Imy4yms5sES6K6KrDtF1ynGccQfmu2soi+BAUTXB1/Stg9+ClaIjQyKKZyEkNQFdEVJiD/Jua3PYeo5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJH3AVBt65FbrWGuHJlyAnN26pEcxdMNdGJRaBbEO/4=;
 b=rb2c/OCTiqh60LsayMjK5RbHvkirgc+cFpRHNYFTZt2JwWcx/ukZsqrim7NCcwX47U903Ujr4uiPWgWikSZOxhAl6CwnP2oA1I83N+DbIM6oYTav3LE2u5F6nKZdDJfcpH7Xy6gPBoPy1JAr9RW2IEtWTlINy25zJAzQzcYPE6v8og0b7hHxHF/ZWGkQr0YYVarrMmud9sgKeUhFlopIJu7flNg4v+I8ZxSf3trbueIj4s0Ec1LxKvZaa0V6fKB5G6eK5shIWiGRP7hVS+kWTGtS9tXSKpjnUce8jZLyd7eF/Xgl5jI03WiyigiKXI7ndoPVIwPDrh2Tdm/4H+2Low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJH3AVBt65FbrWGuHJlyAnN26pEcxdMNdGJRaBbEO/4=;
 b=X198apLcwTd29hmWUJeXsrh8FE6dk16wd93+4N0QYTopyXDXiSTQLkVuMqvJcNC0Zdrn3RePoK9BNGMagq8a4G4KzDxeIYwLZqGs0jgelhbuDLhryqRV9FGOPFW1CcMMbhOwMpSLiKt/Jww05tUtUgAKPby0+3wHxaGtZrse1eY=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by IA5PR12MB999276.namprd12.prod.outlook.com (2603:10b6:208:60b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Sat, 14 Nov
 2026 03:48:23 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::6a) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Sat, 14
 Nov 2026 03:48:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 14 Nov 2026 03:48:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 21:48:22 -0600
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 13 Nov 2026 21:48:17 -0600
Message-ID: <0f97689d-fdec-4cf4-b6ca-4365aced16d6@amd.com>
Date: Sat, 14 Nov 2026 09:18:16 +0530
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
To: Puranjay Mohan <puranjay@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrii Nakryiko
	<andrii@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20261023124157.75524-1-puranjay@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20261023124157.75524-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|IA5PR12MB999276:EE_
X-MS-Office365-Filtering-Correlation-Id: 60beb6c8-278f-4b57-28a0-08df420221ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|11063799006|56012099006|261021123027099003|261021121427099003|261026121527099003|261009223027099003|261026140227099003|261022105027099003|261102123227099003|261028144727099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Hm3yL8u95hIzpUMZ16gwDT0LhOzRIN7VMryjCcZEfQPGu1gggFl8+HWH8+k81qZg2HWgdIrR+7bflAvJ9CTadFTzNt7F4gEhYIvsPsT7L59OwDMmN0QMY1OC8S2XB+4UenjB39PpajFKLqiCyOKPJKExOBPVTtmROTTwIv+1r+FCgyA447G8dTufoagKHrM23ap6TmS9Q30KDMYfko9uyfAWO7yzcFLD08S0f5pINUYb7S2BbaWRBzEguHJup/pllUW3go2YJX0Y487SsfK56h7DHen3fApX+uLeSf26XodGLG0sa4EFQ9F/Bi1qqNoiJpCFz94lNxf7gwplmXHUjHFg3dluRdf2oL7Wtj7DeiOdTfMEBFKs/UoZ7X7LnXTltqn5hCIJziZ3Tk6waSAQxbWv1VbhnhqGM7r0q9a49DLGWzfqVNG1hno/kxMzsLbttkBuRqEH+OROGZCVb704vGYIL+3hFkWoZP4HKl/w6DVpQ8Y2ZXJvv7er7GOPqD913NNrTLapJ1MSQKjec1Bni9P/YF7I953i+Nt3eOWp7PX4WrJfc5K67VEBWwhvDknfw63xJ8qyWlzvq9Dj/uxjt1C1X5hnq3BGf41niADGFN0bJGmYB6UQxTbE7Z9dGQDrmbGBlDG5YU+FhpXKHxsQPmBcCuv++usyPH20ZpRgBQAiP90PYffLQ334R7G9sc53IA1MlutYRZ8HrDrFrFKP6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(261026140227099003)(261022105027099003)(261102123227099003)(261028144727099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iWkiC8L0UBocgWqQeW7XA0iRNgSK48fiSlMNm3ByAm4h9F/BgcE/ZgY8vNqZtLjiBF0E4pO7exK5iw+cx0R9hyLir2epp1Z665xQh93bgBvyB9H95EAFt/t7uinBtN4POP5kIxpB5P+lGhy0o6iyexLqmxLImeH+aN3V6ZgTn6YBWBZpHYszg0wUXGu4VqmKj+S1atw8DAPiTlrgP/a+RKPVDxMFhe8kIO11UFggdIrbX99e5vZVf9jDB8M+24S+c0az5r9NIANh8fwHXH9eWcH1FHW0mIM+9pf0rbue5ykLWwgkhqIBkLS1/1/YDKiPPK4ZcUbvCg+VoPFzbGGt72tpHsYzetYYw7cZdU4gOmNme1bnT1S71mlw+v6wqHp8PoqYXXDScG9d5EJPKRkFElhLD9z5h8ZqcSdyTFFKxqdGrPhQZ+Rf+HIspVLAKkyn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 03:48:23.0937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60beb6c8-278f-4b57-28a0-08df420221ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999276

On 23-Oct-26 6:11 PM, Puranjay Mohan wrote:
> On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen on
> PMI, so the branch stack ends before the IP and callchain, which are
> taken when the NMI is delivered. IBS rejects branch-stack events, so
> there is no precise alternative.
> 
> The freeze only keeps the PMI handler's branches out of the stack, which
> matters only when branches into the kernel are recorded; without it the
> stack fills with the handler's own branches. A user-only filter does not
> record them, and parts without the feature are never frozen (see commit
> 598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")).
> 
> Freeze unless the value written to LBR_SELECT, which is shared by all
> events on the CPU, suppresses branches into the kernel.
> 
> With perf record -e ex_ret_brn_tkn:u -j any,u on a Zen 5 part running
> CPython, the function of the sampled IP differs from the function of
> LBR[0].to in 84.3% of samples with the freeze and in 0.1% without it.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi
