Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0253B19A;
	Thu, 30 Jan 2025 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738273224; cv=fail; b=kYOVz+PIo5+G62ojJxP9r4dcl1gIh1/Ogl63aTxREfrJWjxRSBqAQd1XJCw/P6qbOBYEdzF3mcz8hmywutp7h+LB+yTX4YFe5f/iFyj4mN5j+7Uqx/LXb9m8RDsC8oDPMTrgHwC9G1DntMgM2aZUtwmFaO8IsY0d0yy3e03EmhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738273224; c=relaxed/simple;
	bh=7VBYmNF80WJ54vy9kc7JWQmIvoIysGXgbfAvm6D6ygc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FwSTuaVtK1ziSXYyZ+TPkjR21PlxYVZdpEnhNYjb/5iHHeLlPCvH61Bgp3naDz8VkAxeL3zgUqV2cdg2hedmY/PUjsAfDKcjiLykR3y5+YmwWaHFm8hGBa0mCOA7xCikBsArWJJ6c4lgqbZKKTSTkrB4f2BNGSvXu+/V0B9kwvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FljAXOnG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CGDvItp1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FljAXOnG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CGDvItp1"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ULBi6j020934;
	Thu, 30 Jan 2025 21:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/B8MOXfOGK1v4JOuFqO+iW01zXh4gVCveQrQ2Svh/gQ=; b=
	FljAXOnGP4PaCP2dn6arRwMtqEcCHOcDTZoXEpxH0USt8YfEOzxetuhCBDGrnP3R
	aR8x3IBEO7Leh9vBOBFVahQ0Rec3X0WgqxcovVG6U2/DlgCMXbpPzQcMIUWMfG5P
	vOrm8a3CRm6QlpIH8hMdF8+Yb+RSWyAfVCkRrhmA5NGxCdekTakZS+OCLIRIKD4E
	L7cf8kRRdKH8KZ01+yMoVFc3sUgBumTTAEKTW/D8mUrvHOxMPhwjamB6oJKjHSCX
	wpOv+8fPAK5KMQ6k0kfAde44lzVH67GhTrcKEdP/76lHdSThxuit2PAyLx1fbQS/
	O82bXffEkmswFm2bHqmetA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ggaqg54g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 21:40:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKPVMl032220;
	Thu, 30 Jan 2025 21:39:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44gf935yk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 21:39:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjErYXFm+P26u0yN/SSyvuOvRrKPfptr1afexgtsdlyfX8vP094C3icnCsXSldy5Ecr1bQ47zj98+cPvJ3ISryrLxFbR6y5QvTauEtDqJN0Rp6Gj9Yfioe+qWZiJMzT/abBSKxhn8REBL13qh77B3ArEnrNAn43Z61T8UM49fVXLiLYFgB/k9O+vPSOS/IJSPEAGWw7rDylzGAEvbsXRsqGiBD0sfCzShKcQ8KQSdlCTlLPtqWx8K41y+3PUUCeermVzuuBM0NsTgvc03h7uf+bvyapYY4u52d+FGyJjuRhXHmxeQnkpLR7TxvMGPCuV+yzo7mcCEkkAC5EDrF+jnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B8MOXfOGK1v4JOuFqO+iW01zXh4gVCveQrQ2Svh/gQ=;
 b=jgn0vTRvs13xpQJVdmXkUJLlH8KnBuS3Hkv86xo8lxL751dRaXUuwQSOuCszncUREKs2bSEko+3inR/cxrAvOclKAZgmYGELE9V0GWOPiRDvWpU3jRfV8SOky8AGnv23MJWzAsryWkx7IkwqGpQw5kLazEqxOJICWE6fFhvYrcRYkN7Egdon0iQR3yURcXmLKlDF03edSP7+A6T9FfwGkz1r69ZBCGD9ANFx+8U+wb/ly6eS9TqsVpjjsQy7GHPsYDnou6o0mPB29TTFSsOLbl3B+Xoj4VQStzIBqZboHkQrFHGTutPcbvFqFdieZ613Takbz3xCgXcw3Qn56bHkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B8MOXfOGK1v4JOuFqO+iW01zXh4gVCveQrQ2Svh/gQ=;
 b=CGDvItp1+uZl1uYalgeRKhpnSfDpSvMqhBCuIa31VjlwkzWJ41pRqFGqln1OVszBy+cxVIhryCXlEpUmVtP+lu2xmsFj7kfLejAMdzN2TA+TDtqOAvGzGpl+mQRXA++qG7IMTNDw/BtQLAiaN2gm3rscPSssAw+Qak6fxwBj2QI=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by DS0PR10MB6270.namprd10.prod.outlook.com (2603:10b6:8:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 21:39:55 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 21:39:55 +0000
Message-ID: <e4a52247-af59-4c0f-9215-00ee83a61339@oracle.com>
Date: Thu, 30 Jan 2025 13:39:52 -0800
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
 <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
 <20250129020249.owmklacvuvss7z7n@jpoimboe>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <20250129020249.owmklacvuvss7z7n@jpoimboe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:303:8f::29) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|DS0PR10MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 564b2d96-571d-4be7-ff22-08dd4176a335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXUwemd5bGdtalFnT0s5eDJGY0ZFU2hVQmZxTHY3bjNUdE5yeEprNlg0eWtk?=
 =?utf-8?B?dTU3Mkc4RVh1OVNmTGFMWE9uZnR6NmV4RmRFclZHRllmT0pRa2lFU3BNWnZl?=
 =?utf-8?B?VVkwS05pT3U1Y0V6OUMzVDY0akorRDhuUDQrVmtPd0h2eGJWaE5iQVVoNUNK?=
 =?utf-8?B?UmdoYmo3M2ljbE4vTzBZV2srVzZ4NkRFU2dGaldGZlZ3R1U4U0pHeWlxckNX?=
 =?utf-8?B?SnBNVW00TGlrakUxeWRuNWdFYlZ1Nmo1U3hYY1pKZitpTnNuOGRLNjl0WjNI?=
 =?utf-8?B?OXRnbXpsMDlXTTQvT2x3b2xKd3dOanBrQncvRUNhc3dHdWNDSEZ1Q0J3bnhx?=
 =?utf-8?B?akNsT1ZxYXNkUERNTzMxdVR6bWlHbDhjT2luVkJjOGFCeUo2c2plQXA0akdz?=
 =?utf-8?B?QXBaSlpzNzhoZmRjTlU3YWNQV1gyQ09qQkdGWEwzT2cyRUdUamxCcUhHSWg0?=
 =?utf-8?B?eFRXRW1rYjN5Y013SHdBNS9xbUlOa29tWHAvTFFUUlRWSkQ4SXhSa0Y3Q3dW?=
 =?utf-8?B?MjBmZ290aHJiOTNZTnhjWm5KYUY0NWM0VUo5c0hnSFVkN1pmSWVoNlBLZkFv?=
 =?utf-8?B?bzFBcG9Hb05SM2psbzZyUzlQaXpra2NkbXhRMGZadEZSRm1lN2RmVzl6bS94?=
 =?utf-8?B?ejlUL2treC92KzByWXFCUGduN3BRU3prOTZkMDhLRlFHMjNTbEttMi8zdGVr?=
 =?utf-8?B?L295QUJYbUlwWGVyNEJJbzJ4T1FrRnJTMjVkamZNMTJvNGRQd3Y4NThGWVgr?=
 =?utf-8?B?ODc4MTQvZWNLV3hGUG5hOVhFV1pTNUM1Zlo2WmNqSEdLT2hGMXlsRXVUdXMx?=
 =?utf-8?B?N1VxcWFMRHpFc2JUVElueE8zZWJPblBKQVNIS2lPTllOeHFGNzcyZ1BVcWZG?=
 =?utf-8?B?a01Eb2VRZlh0VEF2UFJVblRQWFZqUTlwaFNWOVdPeFBQdFdGTk9sUS9XZHdr?=
 =?utf-8?B?c2ViellYencwOWxkRHNWb2JiQTRWZytjOWNUSFVVWEhhL2o1TkZFRkx1aERo?=
 =?utf-8?B?RkFoSHZZWm1PRmo3Slh0OEN2SEZ0VEtlb0EwOHFMOC91VG5FMy82QnpoL1ZB?=
 =?utf-8?B?Vk1YN2hGdUFpL3J2NStTbEtiVEF0WU96OXNTbFBvRTZqSXFqQ2pZRmV1RUU1?=
 =?utf-8?B?eFByYXRGMFU0WkpNUU92bjdqTVFhaHFmdkVPOEo0UFBsZEZkc3F1cXQ5Yllt?=
 =?utf-8?B?Y2dXRDQ2dkZ6TXpUb1RmRVo2RWNFbGg2UVdUeFpDRFkrc1hjRUVuSHZ1N3dr?=
 =?utf-8?B?eCtSTDVEU3dMbmNRdnp1d285NzdSSExYazJLSTdaWlQwZFRiTCtKaVpFSnBE?=
 =?utf-8?B?d25UeGR6cTNnenI4WmRVS3VlNVZta0lGeFlRWjFxTTFIR05YdnFJRVhnOEdk?=
 =?utf-8?B?a2tXWjg0UTdoRzJGZlZKcncwMldEU2FhaVFPYWF1VTREUUZVNnFMT29ab3g2?=
 =?utf-8?B?cXMwY3ZNRy81ZlVQbjNsa3ZsNXFSZzVTSXVzV3o2d254ZHhCUVcxOWxYZWNl?=
 =?utf-8?B?OWxjWS9BQXlpcGJ4UDJlMys3b1RWQ3hPZHQvN3pocXphQzZhY0l4bXc5c2J3?=
 =?utf-8?B?Mm1BZEdPN2tOSWpPdUFhVHdUVVFVSWsybkU4d09xWW42OUtTZWZ5dUFtK291?=
 =?utf-8?B?MVJkM2NSanRUNWp1UEtwNVZoenJRMFFxZVRES3NFYUZxUVFIVDZDTFMyaVE5?=
 =?utf-8?B?b2tSNVByeEkzeEw0ZUI0c2ZkNTZtWWwzTzFFTms1K2FLMitDSmFmMDRWdWlK?=
 =?utf-8?B?Y0JUOEgraHdzalpGTnJnbUIzQzhBZm9BUU1NVWlXNmpOTXBzT2lLRXNZUnNm?=
 =?utf-8?B?OFBpN2VCZm9WMndSZ2VNRmlPV3UyeEQwdEVIbWhqUlkxelBBOUt1MVNJS0Q1?=
 =?utf-8?Q?gbzGWV5qyQ+Qe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmxndHhMQlpiTE9aYy9lQ0hTYXFhdTRyejF3RGpIdVNiM3FRa0E1a2ovSkt0?=
 =?utf-8?B?aHF1aTc3ZCtQQ293QWlUV2wrQmdjaXdLZmNGQnpCd2trcS9PRENxdFBDbDla?=
 =?utf-8?B?b05GQUlNMUpMM09JTFFzYUZQZGFHblFxSEpNZjhDYVVsLzVVS2x2VWtSRW9u?=
 =?utf-8?B?UGhCeDJqV2VTbkZ5RzNXeU95OWJHOXRZUjhucEx3Szh6TFV4RVVoWFNwbHhp?=
 =?utf-8?B?ZDZoQWxrL0xCc3lORGxXOHM3RkxjWFRnQ0VRNklIOUl3S1o4d3BsVkt6RGRK?=
 =?utf-8?B?OW1zaHJrc0o5aEJhVHVNSFg1V2VCdFVrd3E2RUJFd05LTEtjVkErODhqcStY?=
 =?utf-8?B?WTNLZzhQLzF6M2lTNE4xZnArWjhobUNLczQzYXhjWHF5U0I1bG5oREZ5Z0xo?=
 =?utf-8?B?cGNGL1dxdlBQQ0dZNmNXMVgwd05oejRiNXl2NkZIYk9iSitPRnNEaHpmK1pP?=
 =?utf-8?B?UEo0Z0lHOXMxbVR1OWQ4Mk9Nb1lSdkM5cEcwNnJsbURCSFhacUhCZ2FlK1Bh?=
 =?utf-8?B?MnJBSmtiQkViTW10Zm5SQmR6d0xzUUNzYzdMZ2tGMWxBNmR6Y0V3dElMbUtC?=
 =?utf-8?B?SEZXeWpYN20vdG1jb2ZOYVhVUFYrNlBlVW1jS21Bd3plNzFSUG10ZmF2TzdX?=
 =?utf-8?B?aGJyMmoxU3BhVVpORFhvWFp1VkxrdWtGcEU3cXphK0hGWTdaY1QwL2laZHYy?=
 =?utf-8?B?SzM4SEwybUdPZHRHTEp0YmxmeWRqMTFVd0p4QjRuNVZWQ2g4ZGNyYXppZm1C?=
 =?utf-8?B?R0NLYUJmMmpidytIV3Y2bktZOGRBZHBIZ1E0ek9ucWFOMDdFanVpa0grSTFU?=
 =?utf-8?B?QlVwcnc0cmlyZXRjQkNhS3Y0VjM4VU0yMEdYYmZmc0VYZXY0eUx4NC9yNGRM?=
 =?utf-8?B?bGNVY2hISG5uZkJoRmxRWElyOTJtWlhRS1ZKcWp5NUpRaE5RaFJ2SVpFbWli?=
 =?utf-8?B?VFVRbU5wUm9jTjVwT21PRml6UlBEdHdCdEIrVTBIalN0Q1JlRkJ4dXk4UndQ?=
 =?utf-8?B?TWdFOUNVd0Z1a0NoMFhvODJpcERaV1B2N24yWjVjYTFjWUFoQjlyaU9IdFJL?=
 =?utf-8?B?d2ovNmJmaTBhSC9DMVVDMTlyRUtTenJCNGJ5OUV1dVNDK3FKcFZEZ3BnUVVH?=
 =?utf-8?B?MURiTzluNFRJdDZNUzByREpqQUtSQ1RWdWF5UitvWW9DU0tnSXdJUjRPQjFu?=
 =?utf-8?B?b0YvWC9xZHRSTjI1Y0FYanhqemN5cStpdXR3QzlUdFQ2MWZOWUhJK056b0Jp?=
 =?utf-8?B?NW50aCtwLzFOcTBwYllFTmd1dHhORit2SmZZTnRHbkdEc3hBTjd1K1pYUS9w?=
 =?utf-8?B?dWRCTkVIV283MmRROG5iNDZsbnV3Z1VDTG5HSFlpWTJGTXR1eEkybFpwK0Rl?=
 =?utf-8?B?MUZaTUJvSWFuTnRlZEp3bm9ZalJqVkIvbFBmMUlVR0V2aG50OFNic3NSdW9t?=
 =?utf-8?B?UnBNckpkRkxvZUphZTZna0cvbE04dVJ0cnBidldwUXF5Zjh6emRZbC9vb3c1?=
 =?utf-8?B?d21nL1BQSkQrdWFKaHo5c0hEUXJXY2ZLRDMrOXJ3djVrS0hxamN4SS9GOFY2?=
 =?utf-8?B?VEdROG11L3ZwMStZSjRrOGxSQmd2M1hMUEpwU2lxUGIwYm9MbEJkc2s5TVZG?=
 =?utf-8?B?bXNKN2drVlhqMzRSQysxYnNsL3M1QjVmS1hwRzBjRDRZTm1YRWp0cmRqc3k5?=
 =?utf-8?B?dk5xVzFDSHd4L0lGYms0azZWK3IyNzJmUlQ0Lzd5UUd4UDRyT0JRWE4xYWdo?=
 =?utf-8?B?NWEycm1UTTY2Yk1PRjR4dHB4Q3dHazd6UnJqVHhQYUpMTWxGUEEyK1BkQkk0?=
 =?utf-8?B?TkdNclI2YThWTjluWGxZWFh0MEFYM1JRVXM4MExkSmYwalM3NGUwb0hqVlIx?=
 =?utf-8?B?bG9NQUVBb2E5TjVWVkIzQ3JoVzlER1E1Q1V3bEV5TStWRGkxTmxocVNqYXpX?=
 =?utf-8?B?cStDc0pzc0NzVWl4MjMxb0gxUzZNdldQNkFVTlU1NWpoNXhWZ3lPenMwV3lS?=
 =?utf-8?B?V1FsUXNsRTRKcXlFQ2ZkaFhra05YbVB4SDNwcGVHaTJCWkp4MmV1K2t1Mmxh?=
 =?utf-8?B?dWttVGt5RzdpdEVLVVhMK0ZSc1RJTExUd2U5TEVTb3ptZ1JGd2dRWHh2a1Q4?=
 =?utf-8?B?bk1MeHk3NG1zMVRoRmpweldNY0xPYTNnVlFya2ovdUNFbUhzYlJwS0VHbWNH?=
 =?utf-8?Q?fNjAhniW8ENa3mYhjbHcZL4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zF+JLHVZZ2IGJZPctHs9eRslDnvaLFqGc67nYMiaBgFBxNZNkF4dKMuTyvkaWvGAYsfA/v7FThyBTb2XO0EQGttO3mPWzThWx3KuEfYX9B9/+U3boLZKbSFj1qR/t1BlMasXUqLD08URdrJ1LPWah2aVuwl+s5u4bRUK+uw55Y8qCzsQG6UK/4W3hIDAEsHKCuA/bwBb7fBTlceH64xnVhnqDsg47/T8bJ7tWXmSUGmWdnGqQBS4ndpuyVKfh4f+EwPsjcSSi624OzcFxqPERnLxIoyU/wNhAM9M32oX0/pfO34EUAPJVoXmftQuGZX11/03p6NDfCaEZik+bl3l6VdNn9Bj3oIJyOopMPnevu4Ji5ecc913IA35QggMFFeY1RgkF5/cQwWSfH81JHT8YsOQy7kPYGsoRlUKCCxvV/zXTakl77L6vCxdQlXEMXqG4oxTNqb2HkDKh9W8+YfG13ieOq8TDrWKTzpiIUM6XZhDUoh06cCWbZwx+R4LIwveE//3yGpD+6/qfLjfzZcBT8rrYlcpqO82vAIft68WWZzW/V0sXe9alpetb0e6Fus1QuUx3nGhYDHr9/UUDJrYnNHhY5aZkqXltdgbe7Po//Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564b2d96-571d-4be7-ff22-08dd4176a335
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 21:39:55.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9aPzxWdXUeyH72or80Tsr4Ieu4zpJ7VCW+Xja3WDmnioN5hqzBNqEgoovJbItt9s8zgVA0oIn7iObjxYBYhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501300167
X-Proofpoint-ORIG-GUID: Bcn_oJZKAwe0Ce_74fOpRvUaIhG2FX53
X-Proofpoint-GUID: Bcn_oJZKAwe0Ce_74fOpRvUaIhG2FX53

On 1/28/25 6:02 PM, Josh Poimboeuf wrote:
> On Mon, Jan 27, 2025 at 05:10:27PM -0800, Andrii Nakryiko wrote:
>>> Yes, in theory, it is allowed (as per the specification) to have an
>>> SFrame section with zero number of FDEs/FREs.  But since such a section
>>> will not be useful, I share the opinion that it makes sense to disallow
>>> it in the current unwinding contexts, for now (JIT usecase may change
>>> things later).
>>>
>>
>> I disagree, actually. If it's a legal thing, it shouldn't be randomly
>> rejected. If we later make use of that, we'd have to worry not to
>> accidentally cause problems on older kernels that arbitrarily rejected
>> empty FDE just because it didn't make sense at some point (without
>> causing any issues).
> 
> If such older kernels don't do anything with the section anyway, what's
> the point of pretending they do?
> 
> Returning an error would actually make more sense as it communicates
> that the kernel doesn't support whatever hypothetical thing you're
> trying to do with 0 FDEs.
> 
>>> SFRAME_F_FRAME_POINTER flag is not being set currently by GAS/GNU ld at all.
>>>
>>>>>> +               dbg("no fde/fre entries\n");
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>>> +       header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
>>>>>> +       if (header_end >= sec->sframe_end) {
>>>>>
>>>>> if we allow zero FDEs/FREs, header_end == sec->sframe_end is legal, right?
>>>>
>>>> I suppose so, but again I'm not seeing any reason to support that.
>>
>> Let's invert this. Is there any reason why it shouldn't be supported? ;)
> 
> It's simple, we don't add code to "support" some vague hypothetical.
> 
> For whatever definition of "support", since there's literally nothing
> the kernel can do with that.
> 
>> But what if we take a struct-of-arrays approach and represent it more like:
>>
>> struct FDE_and_FREs {
>>      struct sframe_func_desc_entry fde_metadata;
>>      u8|u16|u32 start_addrs[N]; /* can extend to u64 as well */
>>      u8 sfre_infos[N];
>>      u8 offsets8[M8];
>>      u16 offsets16[M16] __aligned(2);
>>      u32 offsets32[M32] __aligned(4);
>>      /* we can naturally extend to support also u64 offsets */
>> };
>>
>> i.e., we split all FRE records into their three constituents: start
>> addresses, info bytes, and then each FRE can fall into either 8-, 16-,
>> or 32-bit offsets "bucket". We collect all the offsets, depending on
>> their size, into these aligned offsets{8,16,32} arrays (with natural
>> extension to 64 bits, if necessary), with at most wasting 1-3 bytes to
>> ensure proper alignment everywhere.
> 
> Makes sense.  Though I also have another idea below.
> 
>> Note, at this point we need to decide if we want to make FREs binary
>> searchable or not.
>>
>> If not, we don't really need anything extra. As we process each
>> start_addrs[i] and sfre_infos[i] to find matching FRE, we keep track
>> of how many 8-, 16-, and 32-bit offsets already processed FREs
>> consumed, and when we find the right one, we know exactly the starting
>> index within offset{8,16,32}. Done.
>>
>> But if we were to make FREs binary searchable, we need to basically
>> have an index of offset pointers to quickly find offsetsX[j] position
>> corresponding to FRE #i. For that, we can have an extra array right
>> next to start_addrs, "semantically parallel" to it:
>>
>> u8|u16|u32 start_addrs[N];
>> u8|u16|u32 offset_idxs[N];
> 
> Binary search would definitely help.  I did a crude histogram for "FREs
> per FDE" for a few binaries on my test system:
> 
> gdb (the biggest binary on my test system):
> 
> 10th Percentile: 1
> 20th Percentile: 1
> 30th Percentile: 1
> 40th Percentile: 3
> 50th Percentile: 5
> 60th Percentile: 8
> 70th Percentile: 11
> 80th Percentile: 14
> 90th Percentile: 16
> 100th Percentile: 472
> 
> bash:
> 
> 10th Percentile: 1
> 20th Percentile: 1
> 30th Percentile: 3
> 40th Percentile: 5
> 50th Percentile: 7
> 60th Percentile: 9
> 70th Percentile: 12
> 80th Percentile: 16
> 90th Percentile: 17
> 100th Percentile: 46
> 
> glibc:
> 
> 10th Percentile: 1
> 20th Percentile: 1
> 30th Percentile: 1
> 40th Percentile: 1
> 50th Percentile: 4
> 60th Percentile: 6
> 70th Percentile: 9
> 80th Percentile: 14
> 90th Percentile: 16
> 100th Percentile: 44
> 
> libpython:
> 
> 10th Percentile: 1
> 20th Percentile: 3
> 30th Percentile: 4
> 40th Percentile: 6
> 50th Percentile: 8
> 60th Percentile: 11
> 70th Percentile: 12
> 80th Percentile: 16
> 90th Percentile: 20
> 100th Percentile: 112
> 
> So binary search would help in a lot of cases.
> 

Thanks for gathering this.

I suspect on aarch64, the numbers will be very different (leaning 
towards very low number of FREs per FDE).

Making SFrame FREs amenable to binary search can be targeted.  Both your 
and Andrii's proposal do address that...

> However, if we're going that route, we might want to even consider a
> completely revamped data layout.  For example:
> 
> One insight is that the vast majority of (cfa, fp, ra) tuples aren't
> unique.  They could be deduped by storing the unique tuples in a
> standalone 'fre_data' array which is referenced by another
> address-specific array.
> 
>    struct fre_data {
> 	s8|s16|s32 cfa, fp, ra;
> 	u8 info;
>    };
>    struct fre_data fre_data[num_fre_data];
> 

We had the same observation at the time of SFrame V1.  And this method 
of compaction (deduped tuples) was brain-stormed a bit.  Back then, the 
costs were thought to be:
   - more work at build time.
   - an additional data access once the FRE is found (as there is 
indirection).

So it was really compaction at the costs above.  We did steer towards 
simplicity and the SFrame FRE is what it stands today.

The difference in the pros and cons now from then:
   - pros: helps mitigate unaligned accesses
   - cons: interferes slightly with the design goal of efficient 
addition and removal of stack trace information per function for JIT. 
Think "removal" as the set of actions necessary for addressing 
fragmentation in SFrame section data in JIT usecase.

> The storage sizes of cfa/fp/ra can be a constant specified in the global
> sframe header.  It's fine all being the same size as it looks like this
> array wouldn't typically be more than a few hundred entries anyway.
> 
> Then there would be an array of sorted FRE entries which reference the
> fre_data[] entries:
> 
>    struct fre {
>    	s32|s64 start_address;
> 	u8|u16 fre_data_idx;
> 	
>    } __packed;
>    struct fre fres[num_fres];
> 
> (For alignment reasons that should probably be two separate arrays, even
> though not ideal for cache locality)
> 
> Here again the field storage sizes would be specified in the global
> sframe header.
> 
> Note FDEs aren't even needed here as the unwinder doesn't need to know
> when a function begins/ends.  The only info needed by the unwinder is
> just the fre_data struct.  So a simple binary search of fres[] is all
> that's really needed.
> 

Splitting out information (start_address) to an FDE (as done in V1/V2) 
has the benefit that a job like relocating information is proportional 
to O(NumFunctions).

In the case above, IIUC, where the proposal puts start_address in the 
FRE, these costs will be (much) higher.

In addition, not being able to identify stack trace information per 
function will affect the JIT usecase.  We need to able to mark stack 
trace information stale for functions in JIT environment.

I think the first conceptual landing point in the information layout 
should be a per-function entry.

> But wait, there's more...
> 
> The binary search could be made significantly faster using a small fast
> lookup array which is indexed evenly across the text address offset
> space, similar to what ORC does:
> 
>    u32 fre_chunks[num_chunks];
> 
> The text address space (starting at offset 0) can be split into
> 'num_chunks' chunks of size 'chunk_size'.  The value of
> fre_chunks[offset/chunk_size] is an index into the fres[] array.
> 
> Taking my gdb binary as an example:
> 
> .text is 6417058 bytes, with 146997 total sframe FREs.  Assuming a chunk
> size of 1024, fre_chunks[] needs 6417058/1024 = 6267 entries.
> 
> For unwinding at text offset 0x400000, the index into fre_chunks[] would
> be 0x400000/1024 = 4096.  If fre_chunks[4096] == 96074 and
> fre_chunks[4096+1] == 96098, you need only do a binary search of the 24
> entries between fres[96074] && fres[96098] rather than searching the
> entire 146997 byte array.
> 
> .sframe size calculation:
> 
>      374 unique fre_data entries (out of 146997 total FREs!)
>      = 374 * (2 * 3) = 2244 bytes
> 
>      146997 fre entries
>      = 146997 * (4 + 2) = 881982 bytes
> 
>      .text size 6417058 (chunk_size = 1024, num_chunks=6267)
>      = 6267 * 8 = 43869 bytes
> 
> Approximate total .sframe size would be 2244 + 881982 + 8192 = 906k,
> plus negligible header size.  Which is smaller than the v2 .sframe on my
> gdb binary (985k).
> 
> With the chunked lookup table, the avg lookup is:
> 
>    log2(146997/6267) = ~4.5 iterations
> 
> whereas a full binary search would be:
> 
>    log2(146997) = 17 iterations
> 
> So assuming I got all that math right, it's over 3x faster and the
> binary is smaller (or at least should be roughly comparable).
> 
> Of course the downside is it's an all new format.  Presumably the linker
> would need to do more work than it's currently doing, e.g., find all the
> duplicates and set up the data accordingly.
> 

