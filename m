Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794481778;
	b=eeKL/bGlQ0OaMzA1mbo+LRLxi21C2WViUtYSqyuD/hH8UsZ/wFrn0kVVRDfKjhuNn56n
	 kD/6d/ChlOked6377hdrr+BhxFKmQgX9mSMGyvb+zo/drI9vQvlVOA0Xb447+v2c4hujO
	 /M2c9PRbK1Tk0QjFYR1wdcFKimd2ARhe/XOSOwh87Vfa8DgqhYRtFHdTzBc4XS8F2UCl1
	 iMe9On7XXktdwvTZ2IDfdp0f/nvh02EKfzxPUcqb77jKRwIMdIWkmODdvBnKkwbeSD1r+
	 0oOZH1mgiiyLu9o5hmcaW+MF1vHfUooJTINzcLWOxzAux8Zu07yHj+ZWKupwigxtnOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481778;
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
	bh=FVxlTlX40YKtO/GMYcSquoT/YfnpG+GrGrMZ9EHrYQs=;
	b=Hp9i5XcSEplzxlMWZ4TszHJroC/SF3vNZEr/BRnlSbgO/S1vTRJ5A4glLQD/2TiEO85z
	 BPmpgg47MM6EyN674zXBH5o0qyOoURMwnjaqHK3DvLXiI4hrbEvge8U7ee154/rDMCHXV
	 aX5YPNJcNWXvf7lOKabiPjAJV9b89nEt2qSreNaBow6SXFdT/ouhnG3DIzN0XcUpXtunV
	 FS0C0YEr0wglv8wX7iQsjmqqGrtAfxttdvwK52mQxqdXJsD4UbFFeTHb/DaLQKYStSa8J
	 3AbScNl0es+Se5tIYA9qnHhqYiR8q7JGp3q6opWV0r4C64WGxDjOn215vMmEIL1+9og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KllOMYCu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.64
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE49606A31C;
	Thu, 12 Nov 2026 11:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE49606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KllOMYCu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EY2vdT8wUkVSMY5imBp9QHZPx5Tk0QQuSuOUB84vfCmraQrKOYlOSi0ShvKopkyFqWDfRBUl30pF0Rmx54DX8lska5tKAOKUKbgBFD1qdCejx4IFMQylscEsA7xO1XpAip4QE5TlYV4FWWakYevVvQNxyLk1xgjYX8B1TdpDQ8tUi9n4ihvane0wW9iV9tIfzhwvjB7l4/IuNMzfPxGYnOcWxxrQCAFLOMHTUFVeVp5eRgvOM0VTLCbNk9nIKjTfzYjxdTCEQz0xXeXeXfcXjYzfzaM3GkAQxr+reksVM4Fi9gVClGXE/aT1971csEPMq/K2wgmZoRSaMasybBDJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVxlTlX40YKtO/GMYcSquoT/YfnpG+GrGrMZ9EHrYQs=;
 b=izyUZmp3qEduapIarvusTMeTOK2hiLCI1zAZ+uO0JcnoOyTj8YqZtgyXVy/DfYwg/+/Zmtc3XXmx/pYbvi2G5jC8II8zJzD2JQDP1SnHhJjATGZYSUN0twqEIES6TVNeNMFnq/nhAEmNOONnc6Cro9fhVPgQURukZsJJyPYTbV5qIprtM69h6c+9Fqn/cM06rA4bfw0ZnAcVSMN1kUb7lLg12LmzLyVZDbfWODGGpzJDZgFCsxBXd519EUpQddMuk8fGg7hgxJpyNjprtIQyT/5YQclWun2lNP3o1q4fs+4Dq5h54weYc5dhZg7g7u2Wfv5v/rIt7p+p3wUEZsMFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVxlTlX40YKtO/GMYcSquoT/YfnpG+GrGrMZ9EHrYQs=;
 b=KllOMYCuWv7QJgoyHzzgxAqfUuqoerl4Jn94NsWaZ/a71FEF0Iy+MjdAI8eyCQGDIgojbDlm1DPoM5HVsK42r4zUL+OCpbaLCLxsUkChJPyoWWC64yMIXoY4jJG+/VuHXBhSDjrRYDFf0TXk0Z+LvMC9Ll1X/rtIMsdL2b9+KXg=
Received: from DM6PR02CA0120.namprd02.prod.outlook.com (2603:10b6:5:1b4::22)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 11:09:32 +0000
Received: from CY8PEPF00000054.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::ae) by DM6PR02CA0120.outlook.office365.com
 (2603:10b6:5:1b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 11:09:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF00000054.mail.protection.outlook.com (10.167.247.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 11:09:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 05:09:31 -0600
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 05:09:25 -0600
Message-ID: <3b28aa06-1496-42b1-b1d2-c654c7a1ff0c@amd.com>
Date: Thu, 12 Nov 2026 16:39:23 +0530
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
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAEf4BzaGnsOhpz=bOxoSEyy-8W0epd5Go6juimoqDge+Rc-+Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000054:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b0c68d-b61d-40c9-8756-08df40ad6d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|11063799006|4143699003|261102123227099003|261021121427099003|261022075727099003|261026121527099003|56012099006|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zNnhFg5JJ2M/uAdMfcltPd216nFC5lJOwWfW/LTsDS1Rfv7wYmfqMm2ta4SPTm5lWscASKmqFF3fh4DYZ/h98rOVXLU+jaYKwKcWQIdckHKnF1Udm33B6YtAOUyjgWV+ElqFadhUeYOyl7ehUYLuATzIFw/PNZ2GsoScdM8xeAXyBTio7bJk+/tBQL68bXoViw4GYcdQzaCecPfSY6oPZ/6vK7wdYrcRlyC/jBrHtuPWUcRS/RkBRBGb+fG52XTTdqm11xjz6v/Q1Bse6w+dO1+mB8WR4Vy7S79ZXwePwYUE2Hyk+41gwSUnuqnnOALwrJvGheBxyHqM2OkXMJPUQS4YWBetDLTzdK79bShYyLgM0NpPq52bAsUU2tGrCeLlpKM+1qE/2c1fay+9j6gel4kukQXv0O6EiWffCURhySDyXJXMCdaAgSCyBXZy/NCoyPjFzP5fU4MZIPukRMr5RzZruvYhX+y8xLoSjFAMNNWwVnznvITT3l8OayFFRRmxETOELN0b2pWpmBIb+GnYkYyeGj5AJEadGb/oPv0t3ixx4PvOuG48ZdMSMqHjJaeBBHBUmdHb4Oph7dZrJ6Ap87Uv1lbVIHHztWBSo9Bh+qN3dmFApntfafCZcRnEoaFSXjiXuZgm94AddwmT9xtuQV8u3YEi8YEEGVGhcblInTqn1f8H2dW9TA4aRlDEZio25/QLIiJbGVnYW+xoZ+jbQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(11063799006)(4143699003)(261102123227099003)(261021121427099003)(261022075727099003)(261026121527099003)(56012099006)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZKDkwyYFUBb53RphUrwfisUDW5rPEnK7AnbQqBMx8EqAM8HX3eoH9tsBKZXZjnDJEpr5Lc5MlpKuKoswmRziXP0zgrpRjRx49Zyfy3HAdR9BHi30WqxZ1GCjc0chBby+IYCopjBumh0gO9cvo4fWIN+vsvVhZfSfG4+Bsk+ChxWa50i/OI/D06Fva38g8lb6bH7H+/h4zBuEQlr0Ykh5qTTCTQI0R30tVNHhc/JkoFNO+o0KrjwsQxVoffh/IuA43vyFotzb+vVDjhyymxEjmXcW6NfiKEDJO80+oZub+6wH4lSjrsgCrOu1d0Xu+i9d5DjX6IBd5CgLIdRx+tkmv4STBimIGmOpxPBCL5egoRCQmx0RMSUSpIcKZy00b8qeE6fO0ZfQOQDvAbqwHTkVSpR/QP/dKr6gSk8HY8tN4zRuBfiaLS9+2r6LB0HZ+xXP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:09:31.8694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b0c68d-b61d-40c9-8756-08df40ad6d71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000054.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774

Puranjay, Andrii,

>> heh, so we basically either
>>
>> a) opt-in freeze with *new config*, but do it *only for non-kernel LBR*
>>
>> or
>>
>> b) opt-out freeze *only for non-kernel LBR* _unconditionally_, but
>> without adding any new config
>>
>> In both cases we have a behavior that makes sense in practice, but a)
>> adds some new config, while b) doesn't add anything. End result is the
>> same, just more configuration and need to change user space code to
>> opt-out the freeze.
>>
>> Is a) worth it, or we should stick to b) and keep it simple, Sandipan?

Have you run a PGO experiment with the patch, and does it show a
benefit? Also, have you seen any regression in any benchmarks? If
no-freeze regresses some of them, we may need to give the user an
option to keep the freeze enabled. No?

Thanks,
Ravi
