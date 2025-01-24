Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1501E98E8;
	Fri, 24 Jan 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756907; cv=fail; b=HqkTF9ep/7iY/hJmyzgrQITSGhAK7xreQLJkuM8v0N1SyEL3UusywGJv7n5mvLf6prHzMrQx7f7uz5AwN4crZPI2g7juDo/NIHXW7uQ8RelhjTSgSVvc4LSCujLAnjF3svEOnwl4gZXycjcQBVsCYVyAKZ4OZqbvz//q2lA3TMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756907; c=relaxed/simple;
	bh=h6Q4I/ET/54xydghxRxjl9l0gks1pnNm4WoomAGYoe8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bdnwLkH1xFY7lns0LrEr4on+7pb407d3DXhVNeo4HL5pxcpogYorF4aQJtNebNObJqy3M/WVN3ubXMMPYP3dwXeQblPV3C9uakuSn0OdYk7oLKg+FVgcZ1cp2awyJgDbgLuZnEhS+wpi4nxn6oHt3fzRo06q9uSZJHOEpOBEj28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N6Nx6i8q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qOP6hOd/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N6Nx6i8q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qOP6hOd/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIcGNm018174;
	Fri, 24 Jan 2025 22:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=a43tV+o3rnFup4RwMzZ/XPWe/5wSst7UjZzZbTWBQHc=; b=
	N6Nx6i8qPV5vMa2rjTQKFY07QmgRtvecnDUMjhSunUolhNUmVMMDbcS7Pku87NBA
	J4+ZEQ4F203b1pnjr15nvg8eYChhGxvmSxpHM/HSqwYvNF724BqcXo/mrfjc+MYA
	kG7O6MqbyTqvoXYv4CNOrbG5/Rf4JzQfoyPL4Qw88lcJxXFVn9rFOkfUUrEdqP8g
	BYiwKO+Dl4Aq5MXNFtQXIC9H166kEJ6QXD6zmeEOzvMnb2GYPfGvRZUvjdiB6lpl
	mepfXR0b9Vcl4S/iS5JDYLJKyhztcmigVz3L4M+2nwg6ZOUPto0EjDIJHpBmJI6K
	Ygnun0IhJChmoZivLr8tKA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b96am6cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 22:14:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OKRllo036433;
	Fri, 24 Jan 2025 22:14:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u1y1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 22:14:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INWxQqSUYAjfGyxtNiheDeqFMVkwnDTWDyxOVbsQsI4n72M72cLVLLtmwH54QYDO3PynY8zmodH6iHjAJoNhCVgxXKJyvDLfiJowAfED5rT8sqIE8H/o4MYYLGyK7aDvedQbwlWgfsgwGY38Puww/gnyZoZWBHWubSVsuWQlI9kVEjvOnmlBaLxo6Ca0QZ/d0RwTpLFAuNrkSL8K9sHYaPnpcCZdCAp/xmEhTHkicm+Co8uzot0ESNHCf1KF308UeVddT+WYJOzSgNAUWBqGbOvdkFJJ0t8bYL8wm9lMM3vXMFYvrbxoywxnXIMDH7crMRBP+lctdJMTYv/MjUrOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a43tV+o3rnFup4RwMzZ/XPWe/5wSst7UjZzZbTWBQHc=;
 b=q8FiiwwrOnh32EVG6en+RSr49zlMBxzcxfE271aDF1qGxPqgOS0ObW9ssp++pTg78JnvwY1CtpI1CpKVRCo5aRaYDWh86NAY7iUFBvkgbCdQUAwsjhceUKG5RgOUwgo9SnTP9qT5crfo3i3PZkjDNdcU9pueWKfso0hGkjtNXYs5o3ZC4NUmDzPbtrekgAwocqwPM4p+oywy2dSuPpglF+2hDJYTYLD8Jo/Dy+/77xTUSG7SxOmweGwh4JzzDoA2jvLYvGxK2bacQq+qTooe9AeOKz0wG8BHsG18auAzSehGW8U6+AHxHMY7SkJU2GA6QczH6vLQbZut+mWO42uGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a43tV+o3rnFup4RwMzZ/XPWe/5wSst7UjZzZbTWBQHc=;
 b=qOP6hOd/wT73CGhozTIDWdnOrLSaaMbNUNpDVpSkYfTUP/BOVrWcdS1Bs/NzV5CH72o2KbXVP8TfXby5YLgy+/8o7+XMputTDU+jK8VYSV7f1pdBH3r49lqEs7L8K0/S2VTX9m9K2ZRVa4kPxAZ4+ap7Vrc/pj3XrpeoUvfiyMk=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by IA1PR10MB6076.namprd10.prod.outlook.com (2603:10b6:208:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 22:14:00 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 22:14:00 +0000
Message-ID: <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
Date: Fri, 24 Jan 2025 14:13:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
        Jens Remus <jremus@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <20250124192159.ypvqwoqjvhasamev@jpoimboe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:303:6a::7) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|IA1PR10MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb7842f-667f-4085-34cb-08dd3cc4678b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0ZKME5iMXdhc3RmOFF3L3J1VHErRFAxUjNPc3lHb2Y5ZkdJREh6L0NLd3M4?=
 =?utf-8?B?WVRUMnBUdGtjd0crMUFJMFBLSDRDd25OQUdsZVBCRzRkd3hCdkI0UGI3VGNI?=
 =?utf-8?B?VmtBVmJRK0RPQWV6T2w4RXZUVVRveDkzQXhPU3I4bzlrQUFETitHN1lkY2xW?=
 =?utf-8?B?VTNaUnFad3ZBV1BxbWNTeXZZVVF6aVVDTTNSS2UxdnpZVThmZzlPOXJSVVVz?=
 =?utf-8?B?R0VBdXczbEI5ejdlSkpzZTN0eDdTc3E0UGQwZHdobURNUmNYMUVGY1duSlVR?=
 =?utf-8?B?MVpEZm4rSHEwUldJNTlmVXVLR0x1c1IrZkcxaGtjYUtJazVDQUxST1RUd0ds?=
 =?utf-8?B?bktTYW90Ylk2QjJ4TmpDdnZHTmxKY0p6QUNDaUJ6TERiREgyNTRDajVIb29v?=
 =?utf-8?B?YVFKN0FNdTBEZndpa1JzdVFaMW8zT2pnY2JhdGJ2V3VGa3luaTJxbDQ1REdG?=
 =?utf-8?B?MDFBL0JSYjZsK2RlNjd1eEh0UVBiNWtBK1dyYWpMR1pOUCtiWWhjaEFFL3I1?=
 =?utf-8?B?dFZaM0Q0L2hORllSdmhuTXVacStxcjczYzhrOXh6RTdzWklYNVdMTGhWeVBJ?=
 =?utf-8?B?cVhhSlVFbWI2STRSSnB1RmE1ekNjMFRhSERsdllwM0Z2RkdCclZRelh6dlR6?=
 =?utf-8?B?aWRRRDdHd0NBQW4yMjNWWmNUUTllYXpJR0poTmlna014L05iQndhbnZBa3FJ?=
 =?utf-8?B?RTJSaWwyc1Z6WXkrOGxkZkpnUmt5cEhPc0V5OFllSjNlbTh4R0ZMT3NnQnRB?=
 =?utf-8?B?QmtneFI4eTFPYXY4L0t3RllRbnNHMnZCQTZCRHgzMG85QkhOWldVenlCZUxa?=
 =?utf-8?B?K1BBemM3dlAxMkZKd2VXb3BMNEROYnprWjBZWDRBUXJySWpUWVBqck1ZWVNu?=
 =?utf-8?B?Wms4RXZpR0VGMFNJU2dXMWJNSENYYlNiR2IvVGxKRWhSTmtRaEZQZnV2VDlC?=
 =?utf-8?B?ckdzUUFCVUFqWTFLcnVZSWVnS2xjdDNPU1NMZHpkU29TRHllNFpnNzJOdUxi?=
 =?utf-8?B?OE9kU2d5emowcThybFBlNnY0U2RYYStNTzZGMEhGM3lzdDhiL3krTVQvVXZ3?=
 =?utf-8?B?UlZOWGlBSXdhUXFSdmZMYkJ4S0w0R3Y2MDRBVGJrbnp5ZnlBRWU0Qmh0c09O?=
 =?utf-8?B?SzRwdm5ray9FNGF3WEs0dkQ4OUFNMjYySnRRTGJEc010UEFPeWJIa2hBNzdW?=
 =?utf-8?B?TFNENzI4SjlDRHFyWm00VkoyeDBLcXBTaTM4VStReEJRUnIxVDZsRm1nWkU1?=
 =?utf-8?B?WjQ4cjBMNVdiOVFBMlpmYTRlVDhxTTNOUnhWY2hrQ3dMZlN5U0xwNm43Vkxn?=
 =?utf-8?B?S29HdjRGY1pZQW1VYUZ1d0pHZjVNYjAwV0RBK0I5a3B5dkJMQjVjdzVOcXll?=
 =?utf-8?B?blphSlZIYTljUzd2QTJMN0NZdGZ6OXFIV2hzLzZ1bUt3L0ZKeXVtWmpHKzVY?=
 =?utf-8?B?aDJDb3BPWWU0a3hTWXRKT3A5NFNaRkNjdE1DUFozaTFPWGZRVGJzZmxHNzhO?=
 =?utf-8?B?dk56dlJpclQyektWU1ZkWUp0WXM1OGVHcmFWT0MzT2g4Wi9Mc0owSGlwZmpB?=
 =?utf-8?B?Z1psSERRQVB2NzljaVN0Uko5OWc1T29lQmR2U05wNWRhQittZEIxUWViT05v?=
 =?utf-8?B?WkRWTnNyYVdoaGpiMEZQVGRBMzFTYkdlMHFZS1FHMU9SNCtxWWN4THZsVm1j?=
 =?utf-8?B?QktLSWxSM09LMXdRWDFoYmV5d0tXZHFDNTc2dkgrY2wwVnR6K2tuV2NwZjZI?=
 =?utf-8?B?ZWF5OE1weWRudjRNd1dTYTBOcVBSak9YSkxyb3RGRVdtcVZwRm1vbTNpY0hY?=
 =?utf-8?B?Nkw0cDJnOXdyOEt6T2JMclE2ck1xZTBLZlZhRURsNDc3SU5hS1F3N1dudlJ4?=
 =?utf-8?Q?m5gBymtjabX9Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDlFbTN5QXFjMFV3MElpdWp6K3VLeHZnU3N4K2kxS2tLTVhMQzNTSmFuOVFn?=
 =?utf-8?B?OW1TYm10a0tKeVpTNWJKZmxjaHJSTk10SEl4Mk5wWVBWNFV1dDBPcWxYenBP?=
 =?utf-8?B?ODVSd1ViTDRrYmF3RjdtSWlOaEZsVExNdTF4QVg3V2MwTTUvN1pFY1hsbFRr?=
 =?utf-8?B?OWd5T3hCaSttcHNHSGxVZDNaU1lKOUdTQUNMcU5MMUtwN3pKTVF3Z1NOaDZH?=
 =?utf-8?B?NjRSUDhqMm85WVFKT2p6SVkxVDRKRyt0V2FJRjdXdXBMQjFoUUZoYXJZVGY0?=
 =?utf-8?B?TVNqK3p1TTBUVityWEpHdzN6SmZCYzV5S0FqR0E1TUFjS05QTUFTTHZiZnI0?=
 =?utf-8?B?Q2MzTkhRMllqaytCWURqMzhNMVYxZWJHUWhLSlBNZk9ONEpwS0NFNmdtbHdC?=
 =?utf-8?B?eGh4YVNza3M5MjhUaHBrM3FlS2dhUWY4c0VERjdKWjZMc0pKOEl0YTMyY1RQ?=
 =?utf-8?B?K3NZSXFBaHNZVVlBakk0ODRpTk1HUXdEcSsxb2RzREE4SkNyMG1uMjF4MXAy?=
 =?utf-8?B?LzlVak9UZGNIcDZobXdLTEZpa1Fiakorc05TSjN5dVRtc05KOVdzeWdqcFFw?=
 =?utf-8?B?eHZpSWFOc0pSS3E4ZTQyZ3lkTlJuQ2JSd3JvYjU3aEJmQlUxczE3SllSK1ho?=
 =?utf-8?B?TXJWK3o0TU45QnJIdWZwNXd6NDEvNE1mM3BYUUkrSE1SL2tGMXl5cllSYjFv?=
 =?utf-8?B?cG9HclUycE9PTzc1bDlaWW16ZVFxME43S2ZRTklQbWk1TzhVTzJFMGdraTVy?=
 =?utf-8?B?aHoweFZHN3VjaWRNMmt6VTI5VU1FNlJ1NllUcVBDWXZtamR6WHZObzJTU05n?=
 =?utf-8?B?VkVyWjFDSmRWQkJaK0RIa0p3bThVNkRwS1RoNFZINHgxaXE0YzhTTG9XZlVz?=
 =?utf-8?B?UGZyeHB0bkRRZUlVVCtuUkZudnRGZ1Q2SVVaZ3ZnVWcrT0M2REYzTWZIVEdi?=
 =?utf-8?B?ZSs3VmdkdzdrK2lZemIyMitvbEhxR1IvN29zZzBiaWM3NE4yNElFSkNMV3k5?=
 =?utf-8?B?aEhGYTdEcm53R2F3ckJEZUxiSTZ3WmlIKytHWmR2ODlaZllCK3FuVjhxa0J0?=
 =?utf-8?B?dFRLUDRaT3R2NGhHY1JaK2FUZFNaTzd3NU9KVnZ2MDN2NWxIZkFGL0pBUlox?=
 =?utf-8?B?emJIS0tudmtrT2dMeVVmTVhNeVVlS2lBNUF2VFQ1dVphdmZhNTl3dVNVSDJn?=
 =?utf-8?B?V3RrWVZkKzVlRkZwVnhyMGR3ak5wdXNKblVIVmdUK1Y4YmtEbWRlbzNJQmpl?=
 =?utf-8?B?MXZKblJIbzBWMTBDWGZmMVY0RWx2ZmZKR1hicm5yZEJrWkJHeTU3c3ExUnJB?=
 =?utf-8?B?Ym5aNkN5MHZKd1lrcmE4V08xT2NaRmQxTlBhQlFEektGditqcEg3d0EvUlor?=
 =?utf-8?B?a0dVZFFoa2VNa2YwUnAveTI5SzZqUGZGUjJWb25mT25BWXlzbmNEL09WeFJP?=
 =?utf-8?B?dWRnczBFc3p6d1NXaE9oRzNGSXl3TkdEcmVaQ0FCWjBWK2NnOGFmS1Q1ZDY1?=
 =?utf-8?B?eG9GdzJWNGN6ak5ZdTk2ZHZ0cjJqUHhXek9YbDk4eElWeDI5VlRsWlhvbXVp?=
 =?utf-8?B?UWE5SUhpWVVNRjh3UUd4blZCQ3FQb0FzZVlHWGFmK0xQeWdtck84cVUwU0d0?=
 =?utf-8?B?N0N1OGVEdmlVRUdRQ3RjTFNkVHc5NmJjQWttaWl0VTZKOVBOZEhuRm0xR2JY?=
 =?utf-8?B?WUZuUzdJaEVJNU11RkpsKzNFUDdaaWRmUTdKOEZ6VThOOUYrWTBXRDFBbVp5?=
 =?utf-8?B?c2F3TTIrWDhRSTNIazA5MUdTMkViaERnaWUzbjNYa3l5ZkcxTWxOQmw4RjhI?=
 =?utf-8?B?dEZqLzJBbTNzOTAxYytvS0VhWGZOUy90MS8yZVhud2YxbDZGOE5rRGhIbkd0?=
 =?utf-8?B?elc5SnhPcG5JdVY4RGltcVdVNDdpd2RNM0xxNzMvN1dsR0k5ZjhNWWxzdHN1?=
 =?utf-8?B?VC93ZHZnQjZtQ0JNN3d6OTFqV3BJV1lDOEM4bmlLd2UxdW9TWmRsN3ZUWElI?=
 =?utf-8?B?NWpPeXFYQWVHMGlmOUZGSHJxblpYQTFhM3FwWlZhNWpDNm0vUXpDQ1dTRDZE?=
 =?utf-8?B?YmhEU1RlMHdGL2tRS3NENkZDaTQwVnc1VnFwKytLWDNjaklxWlRQNGFDTFhm?=
 =?utf-8?B?OGV1YlZEZTExZCsvVTNUTTVxUmd2dklVL2llZSsrNktqN2tBUFJ4YnRNYkpn?=
 =?utf-8?Q?WVUCWPQrWxDosctSn5tIYag=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	psePm9bBGNxcmdPBuXztNDzE4UpHch8zATWlVPbrUBaOpCg59k/bFx1wpNALQP7WuFX5b2i6jDTAtyFRDpmrjgNirpzhSqlkR+RXyLiy5dGt/Az8ZDXSohwJJntU9zn072XJO4RljBhoQqLPPuVoPxzobATs5woDcavO7ZRR2wVyWcbM6hm8TPdYXmBOB24GqhlKiSw3Ef07v9F11AsXCBDtN7kttMX6f5vyeFkO0TchQRWTUuWPByYxuFW2lhh5omprt9Wu9v5wmmFZGoSniZ5g1OVemPyKolTiUHb14KGjfuCLmPqbQf7pnHDRue4RSctdtz4eDcJkTAnEFrJFCC5TV6PH5QLtrUJGo8ORk56K44vEnHoI+jDpG8f29M7oDc3mDuOf7Lpe2i4moC/ySmXn/Z1PvcROnFGlCsukznZsVPhJkH3H7cMJPDOEpVGCdP/z6vhKU0BKVqtRXfIdhczXFONoRD1Bcy18gXIzqcEd/Og+H4mG7cvgn0/LC0MAJbPa3jU3JrA+U3nctnN3ASqWhQyPpKqVJgS3Wnmb14qRFxY9u2VrHAJDOlfMdQ+k9ihdyopBDQ6t3LPA6lB7xeCdcskXDyxlpEYkfF73kLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb7842f-667f-4085-34cb-08dd3cc4678b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 22:14:00.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJUYai9YHZmi02gTxhwEe+XR+0qLcbB+1MRNjXDNgbQVVByAl0NG99y4FDcMHJMonLR+ko/+bMiSbCW8/FKHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_09,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240153
X-Proofpoint-GUID: Hk3lzqhmAw5RPmK8NmR2CbHOk0KXsOaW
X-Proofpoint-ORIG-GUID: Hk3lzqhmAw5RPmK8NmR2CbHOk0KXsOaW

On 1/24/25 11:21 AM, Josh Poimboeuf wrote:
> On Fri, Jan 24, 2025 at 10:00:52AM -0800, Andrii Nakryiko wrote:
>> On Tue, Jan 21, 2025 at 6:32 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>> +static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end, unsigned long text_start, unsigned long text_end) { return -ENOSYS; }
>>
>> nit: very-very long, wrap it?
> 
> That was intentional as it's just an empty stub, but yeah, maybe 160
> chars is a bit much.
> 
>>> +       if (shdr.preamble.magic != SFRAME_MAGIC ||
>>> +           shdr.preamble.version != SFRAME_VERSION_2 ||
>>> +           !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
>>
>> probably more a question to Indu, but why is this sorting not
>> mandatory and part of SFrame "standard"? How realistically non-sorted
>> FDEs would work in practice? Ain't nobody got time to sort them just
>> to unwind the stack...
> 
> No idea...
> 
>>> +       if (!shdr.num_fdes || !shdr.num_fres) {
>>
>> given SFRAME_F_FRAME_POINTER in the header, is it really that
>> nonsensical and illegal to have zero FDEs/FREs? Maybe we should allow
>> that?
> 
> It would seem a bit silly to create an empty .sframe section just to set
> that SFRAME_F_FRAME_POINTER bit.  Regardless, there's nothing the kernel
> can do with that.
> 

Yes, in theory, it is allowed (as per the specification) to have an 
SFrame section with zero number of FDEs/FREs.  But since such a section 
will not be useful, I share the opinion that it makes sense to disallow 
it in the current unwinding contexts, for now (JIT usecase may change 
things later).

SFRAME_F_FRAME_POINTER flag is not being set currently by GAS/GNU ld at all.

>>> +               dbg("no fde/fre entries\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
>>> +       if (header_end >= sec->sframe_end) {
>>
>> if we allow zero FDEs/FREs, header_end == sec->sframe_end is legal, right?
> 
> I suppose so, but again I'm not seeing any reason to support that.
> 
>>> +               dbg("header doesn't fit in section\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       num_fdes   = shdr.num_fdes;
>>> +       fdes_start = header_end + shdr.fdes_off;
>>> +       fdes_end   = fdes_start + (num_fdes * sizeof(struct sframe_fde));
>>> +
>>> +       fres_start = header_end + shdr.fres_off;
>>> +       fres_end   = fres_start + shdr.fre_len;
>>> +
>>
>> maybe use check_add_overflow() in all the above calculation, at least
>> on 32-bit arches this all can overflow and it's not clear if below
>> sanity check detects all possible overflows
> 
> Ok, I'll look into it.
> 
>>> +struct sframe_preamble {
>>> +       u16     magic;
>>> +       u8      version;
>>> +       u8      flags;
>>> +} __packed;
>>> +
>>> +struct sframe_header {
>>> +       struct sframe_preamble preamble;
>>> +       u8      abi_arch;
>>> +       s8      cfa_fixed_fp_offset;
>>> +       s8      cfa_fixed_ra_offset;
>>> +       u8      auxhdr_len;
>>> +       u32     num_fdes;
>>> +       u32     num_fres;
>>> +       u32     fre_len;
>>> +       u32     fdes_off;
>>> +       u32     fres_off;
>>> +} __packed;
>>> +
>>> +struct sframe_fde {
>>> +       s32     start_addr;
>>> +       u32     func_size;
>>> +       u32     fres_off;
>>> +       u32     fres_num;
>>> +       u8      info;
>>> +       u8      rep_size;
>>> +       u16 padding;
>>> +} __packed;
>>
>> I couldn't understand from SFrame itself, but why do sframe_header,
>> sframe_preamble, and sframe_fde have to be marked __packed, if it's
>> all naturally aligned (intentionally and by design)?..
> 
> Right, but the spec says they're all packed.  Maybe the point is that
> some future sframe version is free to introduce unaligned fields.
> 

SFrame specification aims to keep SFrame header and SFrame FDE members 
at aligned boundaries in future versions.

Only SFrame FRE related accesses may have unaligned accesses.
