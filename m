Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794628039;
	b=HDrwmNN4+SzP6uF3w+nf3HkpTzhOvNYlxoqj8VPb2O+3nDh0soo7f2kSxFEzXKISamNI
	 vWZ5ohh+FfjZnviBug8w+vp+SdtU2t8NoGsIH1R4DHUkQ9r6NZrzzkYh03K4VWoRugOh7
	 +ZxgKRzKYLIX0umA0643O8h+s9CocscR2rDina7guerEG757vS1AGOcYfxgS+GprtNb07
	 u8RkON74I2QmJWAxCG/M0KU8IgIORAQd+3H+4bQiLvitz9f+lm0TNi2iiYsrcjGkhOh69
	 mgdJJ6pvz+oDV+aCuQwI0AZVOCRgavjo26Coy4Xq3Irb37u6EXO1fa5kW35QzNVycTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628039;
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
	bh=4xIPU62UVSXOReioFF3EqREumwnq+6nu7nM/lzN31Jg=;
	b=sH6hXUp0LHVCPjIMWO9yBamfLNyl3dpoxD01WgUhs3jbZ0lpfjzJULdVBFt2BMQI9x3j
	 dPXr4at85c4kAyNw98P9BK47Js60YXPILlbhZ+GXMzoxe15Qfa66aIXlbeFVd4fyRxFs9
	 Qjjv7bCPGx079OE1amCiOd4RPogdQ8fS4sFzef5Xep/VLsKeutbCruDw6ztjoFgIEKLUR
	 5aq0IyW3l4+2jLf51CACb82j7U9s2Jga3wAusPe+z8SoTTY12ew3nBA/zo+6nGy+5NUtM
	 j7hnBQBdh5OkHcOnh/qIoRHXT5zDYJb8IMMscHPiIObylillqDp0QFuYKEv1K7C7IMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WhpFqH9W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.31
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60347606A327;
	Sat, 14 Nov 2026 03:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60347606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WhpFqH9W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox4/Ewre9581RlYhGNP//mEjowuWT2z7+gyuUSt6CnRcQL1AEuuN7TmdVJD3E01ufVf7WpvX8aftzDgHL5Lph136ELKdLMLKfuV9dIH9RCaaSCRFrMGkEntWSB722g4R8t1LHXSRBql7NJS+D/DmgfBrQUwT987cByWE3R3ncnqz6pdDtMgVPA80fT3zh+qx2OPSoB+PerodvMrYQd8Nl+4z6pQzi5YeF9BunRUw3dFsOdzR0tlTsgeX2sgL2Ok85DnvSHPE/vkRBjTrdjoj29gDsDA+fKYT82UALstcuQGgPBs9hAyo1oNaU9to+e4vX528Xpw++BGwfpne8lYZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xIPU62UVSXOReioFF3EqREumwnq+6nu7nM/lzN31Jg=;
 b=ot3HkV+7JQGBBWwLlPm+haZog5xaXmCIf/3/Nr7c0S2Kf+TJJWDnM8iS6CJlBLSDmZ2cwDxYUPU8g/ckOJn4qhStNrBccOzI/8W4tEdTeH5bfzPIf/J2YspgAzeeHSOq5/ypZ/hnneQId++ZqD/mfO68IvYpPdz4qz4aNzFX3oKsPxFgqzvgB0J5oP1dmaGWP1PDXL5qpfgCsHzTFfoPsXDmkwjFQNu/H37T1P2SM782Oh4LvRMYL1hWgnWRPlevv9Cigw29HNoArt5ato6VCrHKkqVqWgkI3LWfv4Smik4nlGNBSixOjBtBU+5/ON4KM2TVLnJr73QmD22Xs5uByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xIPU62UVSXOReioFF3EqREumwnq+6nu7nM/lzN31Jg=;
 b=WhpFqH9WZLyIFcUmbtzCVvpbI8rJ8FruZmUcAX/mVAS9KwQXinBhbyWC4QwHsfnEP3CM5j/E6A0fy+N3QolOdL9fOdWTTwpP29E/M/szUic6vEUd4OaGNC/xYgYyzRHkbJmT6Nw/EQzKc/NDJVAkpckCENqxrdq5Q7iTAvbB5Vo=
Received: from BN0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:408:ea::29)
 by DSVPR12MB999148.namprd12.prod.outlook.com (2603:10b6:8:38a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Sat, 14 Nov
 2026 03:47:12 +0000
Received: from LV8PEPF00000060.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::26) by BN0PR04CA0084.outlook.office365.com
 (2603:10b6:408:ea::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Sat,
 14 Nov 2026 03:47:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000060.mail.protection.outlook.com (10.167.245.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 14 Nov 2026 03:47:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 21:47:11 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 21:47:11 -0600
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 13 Nov 2026 21:47:05 -0600
Message-ID: <5cf60aaf-2ee4-482f-9054-dff823710431@amd.com>
Date: Sat, 14 Nov 2026 09:16:59 +0530
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
Subject: Re: [PATCH RFC] perf/x86/amd/lbr: Don't freeze the LBR on PMI for
 user-only filters
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Puranjay Mohan
	<puranjay@kernel.org>
CC: Sandipan Das <sandipan.das@amd.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>, Ravi Bangoria
	<ravi.bangoria@amd.com>
References: <b7456dbb-16fd-45b4-8742-e9ea3f896317@amd.com>
 <20261105170340.165507-1-puranjay@kernel.org>
 <CAEf4BzZeVd4boXX4Hy1sKAM=dUPS7dvdmrOPybGrrZV+bU7eAA@mail.gmail.com>
 <CAEf4BzaGnsOhpz=bOxoSEyy-8W0epd5Go6juimoqDge+Rc-+Dw@mail.gmail.com>
 <3b28aa06-1496-42b1-b1d2-c654c7a1ff0c@amd.com>
 <CAEf4Bzarzbv+Dyg4poo5BM1pjsBT_ggycP-Wrafk5fAf-F2TUg@mail.gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAEf4Bzarzbv+Dyg4poo5BM1pjsBT_ggycP-Wrafk5fAf-F2TUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000060:EE_|DSVPR12MB999148:EE_
X-MS-Office365-Filtering-Correlation-Id: 02841915-c399-4276-e1bf-08df4201f797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|5023799004|4143699003|261021121427099003|261102123227099003|261026121527099003|56012099006|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4dB3RUe0HpAGaxkT9bKBrTerGalhcCr5B2a++mxqgWqiwqXAaC+h/A5s+nY1dAw7oRWU/rM9sTQNSnLExsrQvkSJVPaUjZCLEwWuX0wgAgHLnBrLAfsOqUckDGzcZwzByqJtbfaSro3NuNGQ95FVBkKSKxorAdIEZGGOxJSHwqDVNUt0LXycAcLPfU62vAZCVPcAG178J7UrFDGugJvzEanuxjEC748HAKZBrqYcGmJU5l/Ke7B5/vCZkZoGcv5r0D48DLpbGD0SCKieKD0l/FwcVx62fDSKmhPAImixKn7rrDGHSxZWeXln80MyvuJ6zis1JYfNJRE3qFd3QGvvntgS+M1VhD5z8a+QrHaJNnOw04NOZHKEOoweWP0HoDh55L8pUlzVmbkK6YjGWmdf+2oFQDyXMf2t3w0t0ZaeHQ7i8vazmfR3zmRTXlQ+1gPn3KhUHl9LBlFssmtKLfZT0fO9Q+qNPLlpOs/Q7WTuZZxT+egfVR+likTFNlAQ+n9GtwOePLwHakMKjIo7813tx+3png5b0FjVojCmT/cd79sQlimL+dP9yA1UDMfHG7uxvzZ57+wYq8k+YmlvBnxDdOD0y8OoWdGFROKfk2S5b8rY9jJ/dAug640gU16IpiKm1K4bjPN8AGVunL1jjHagAYSrkqwFtHpjEqRfY1gBvZjpsc94GWnZZ8hhvQyjde95wJb7aU8SdjveHTQ1vBkJCg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(5023799004)(4143699003)(261021121427099003)(261102123227099003)(261026121527099003)(56012099006)(261022075727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RDfxj324yqlnJfcYSHXn4gQd++aHou2mrocVmiBB8ulQrYrx9bEtX2D3V1BTSUAEv0s/6pAS/BxaDEmoTj+5fDzMliAUuwFAHIIswnc11qoyqmcFIDXyze2JmMunXf2gWqA4xTbxZXy2jgQY0VpaVGIOBMAn8aLxWnaPIXVQd19toSTmnJBg8dne4LSP+7DmqIbO3qqRSHsEXNL5aH0AQhS3w62amou5VQTeJBw13GtgJK/oVu02GmKRElsiXmNGrFk4j3YJfx6hb6IKLrtRECohQWF8nm0fiVsMcf/4WL5ppTffTqFynzu15DO4Ie+S0Gt/rVmy68WRyK0R6ksBtFm1aDVRw0c6nsinf/0VpCHkmOhY3X+a7Zp9Zz+FqqEir7e5JqabOniLzYJhilfS5cYmPC9+UGAAwn/PPcKQAW0OaudlBB7KiKE/VU97VsIQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 03:47:12.5778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02841915-c399-4276-e1bf-08df4201f797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000060.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999148

>>>> heh, so we basically either
>>>>
>>>> a) opt-in freeze with *new config*, but do it *only for non-kernel LBR*
>>>>
>>>> or
>>>>
>>>> b) opt-out freeze *only for non-kernel LBR* _unconditionally_, but
>>>> without adding any new config
>>>>
>>>> In both cases we have a behavior that makes sense in practice, but a)
>>>> adds some new config, while b) doesn't add anything. End result is the
>>>> same, just more configuration and need to change user space code to
>>>> opt-out the freeze.
>>>>
>>>> Is a) worth it, or we should stick to b) and keep it simple, Sandipan?
>>
>> Have you run a PGO experiment with the patch, and does it show a
>> benefit? Also, have you seen any regression in any benchmarks? If
>> no-freeze regresses some of them, we may need to give the user an
>> option to keep the freeze enabled. No?
> 
> One of Meta teams internally reported that disabling freezing
> unconditionally through the kernel command line showed a lot of
> benefit in terms of data consistency, and I don't believe any sort of
> regression was reported.
> 
> If anything, that same team is asking to unconditionally disable
> freezing fleet-wide, and this work by Puranjay is an attempt to have
> some middle ground where we don't have to do this all-or-nothing
> disablement through the kernel command line.

Sounds good, in that case, we can proceed with Puranjay's original patch.

Thanks,
Ravi
