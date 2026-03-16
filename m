Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823933CE88;
	Mon, 16 Mar 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684003; cv=fail; b=tEhqVtxTS2a5ikkBMbxAHJGjaLcO9AkB28UCXZLUMzknxCE4nFC4LvQUT2+NwYXJ1BWNSwqfxxuBJYxZunYCxH8CKwRXiV+cHnoopM948tkV1OfXH2vuUvg7NnSZCn1NgkAMxG/hJxQK60IEeebKR2h5fHWtlrCSx2HaAw0+eHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684003; c=relaxed/simple;
	bh=JrGMnwJJ+6WdtsBqE+RAvcqyKS5K/FzKNy8hHY8bqKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DWwek+83f33NPAKLPVwq6TjkG7L9rCb+PfyBPgzTeaODFsZrOJI+qs3k3sR8pKHJ4HzpNm4pnask/HjaaZWBd1arXpwm2eA9s/B1SkAxynhVOB9dppbTHe+nLAwCbFq+rpfX75r81NT9miYyICumQNt45L3cFYU2yEnnw1oqyww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i2Qca1PG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U7Bnax4r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i2Qca1PG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U7Bnax4r"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GChLrS729985;
	Mon, 16 Mar 2026 17:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TKhvktujfbZEXOADIyxeKL6Bx/U9nnDW3Ptxzz0qsCw=; b=
	i2Qca1PGIo9lC007hiKjOAXqs2E2kivyJcOrfd59cWFHdYu4iPDpa8RmxZMujZMH
	oAHNbZeN+P5tqqD3SpyeeORmcyLHnXzFftUrmiO97awvrcuHR0AYLL8RqIwlt9Fz
	VbjOckP47o+0ua7N3VmbgvKBDZT7Svp0EYspeT+n++DyH3ZNzWRzGhjFMORtQJ37
	iEZIcAoyh4aK9L8JQWOtSd0CG53Jkm3Yf9XzxFK1ebZZ4oJyaCwT2fSXo21OSQbf
	LtAhsAiBr9nnLyr8eRvSlXW8kfdjY7G9WmX/NkOexAF61A5AO1IeCa7cDkALORe+
	qH4EmXIZDZVnrAcdXvSWnQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8auwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 17:59:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62GHx5WP030497;
	Mon, 16 Mar 2026 17:59:41 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx48xps2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 17:59:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjeIFpsqkIIfUUjNxbtbQBK8COmWnRNypLIZ8ZBZdLG5/av40gAbTQXk0XDADNOxsGDA9mCdEvyOcGNBDXDfb4AwpItY2zjG4PIjC3RQQTodA3dINAhM/LdGK+VGjcLbnnQBDqc17Yharq70zqLidDwl0EoHnvicfnpBY4aU0S8hL3OxCXo9G56GWdRRWkA/nMIZqqCs/2RuVebAuuT+roL6rlNX0iFppGpvH6Fgu1wc52gPd1EDarLsRFNQhYGvLkXxXpJKL2tGwX5CFFjBixNISRbCKXgwnsbazLaymi/vV+3aRDsqEoG6Mvmz3+vpzhWV+ufLcR2U32qOSQHbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKhvktujfbZEXOADIyxeKL6Bx/U9nnDW3Ptxzz0qsCw=;
 b=Lwegq8xe6CGMtZoqWBGF4nMgAjIe+K10qjknV9vi2xHuejn604Htd3DihcE4b1Fg2CcA/Buc8R6TySBKZWviAm9T6INUTNqsa129mOB41iKUuplhc1TEYHhWxZJZ6v2U5dxCUKQTVrMtxUo3/3DWpQ8JviuOfHKykRimvr5dB9+NlMEY4WouOmyIhlIbLTX9dnj5IEKxtYg/vgH7tPT98MvDSyRjQnxFwu9p4BfWwNZ4lmSsjI0EBlnCApRCsEbhMpwgFDizgc5G983dGvoFpPG3FIvaSUdRgIqSkqT9ZbU/scrViQcqriG8o+orvRt4imIXQbERF1iRooSF6RfkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKhvktujfbZEXOADIyxeKL6Bx/U9nnDW3Ptxzz0qsCw=;
 b=U7Bnax4rj40Oc2qR2lqKrz+Wsem+jakfZVbhztvupA2BWBslcgUcar+7tclae0xePegS1d6xuhZ64FUhMN0mdPMCtm47i9MNn0ips+BGF++f9w6IxpymrA4E7fyywe7YWrDzZfUjAjot2Y45N1efA+Wh3dcUFW/4lL4BYzicMdA=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by LV0PR10MB997639.namprd10.prod.outlook.com (2603:10b6:408:33d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 17:59:39 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 17:59:39 +0000
Message-ID: <83903c3c-10a3-423d-a420-51c29602494b@oracle.com>
Date: Mon, 16 Mar 2026 10:59:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: perf: add comm_ignore_digit column
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter
 <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wangyang Guo <wangyang.guo@intel.com>,
        Dapeng Mi
 <dapeng1.mi@linux.intel.com>,
        Tianyou Li <tianyou.li@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>
References: <20260305181847.3249498-1-stephen.s.brennan@oracle.com>
 <abhCUFPsyWGJ6DNn@google.com>
Content-Language: en-US
From: Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <abhCUFPsyWGJ6DNn@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:610:b1::16) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|LV0PR10MB997639:EE_
X-MS-Office365-Filtering-Correlation-Id: c1be5483-32c2-4078-bcd6-08de8385cad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LFcX8Gk6Ax0w/sZO9hEPE3UM1mewbut9OtWU5KWbAY+tHLqTnBde2CD49kS4Esjzv+4zSHkTk7gL3/riUgEp9MLpO6Y9vZM8h+Ite5Ndarm4NdW27ahzYDZXsRgPuy5fvlIqfkDesEcRg42ziSjB1YDaTGOrG0JAdapENQNCRVNqi2A1Bso5bIPWf8GiOwckuVLYImIcOlOhQ54ltRb7dyMI3rOn72PrSxpVm5dpIlxbhozCTgONQJCcQRMZyCx+SidqolJhvKvJDEBaPup/HBPI2jlZCbDUDnp+krQ+NMm5swkAixx/2hwQEQttnIA7moKN4SVqA2hQmmpYNElo7l0Oy9nQkKVLcXrxtYXShTpIJDFaIQ58pimkqL1nGvgVuWmKt417798t+fkW7tHD1gvE0vKKzLgWrDLxGN4F2LMytjfBi6uFpOzCOo69OkqwiemqyF/Qa77W32t7HfhytzJgDlYb6Z1INekFZk1Ox25IkJ21DFZ7L+hCB/Mm46kT2Av3Gobe0gk1gviOal8LTntC+E9NU2ywQxr2zJtQaG4B1JxfzSeZtRjASWh4ic7ASIq+vXa6qpl96Pj1dq46j8o5oT92NJOFqTl5gzfVZh4MAcBL5f1B0FFFyjWw9T3oy8u1rXrRqks1HJZAJb3uYreoXzGJbly/HXbdwqBqrItzA357CkspOMT+LSfAUeLPrWvCGbpb172IrxozR7osD8M6JTPEbPzp3PUpKf16sWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akowRXAwdW9pdmxhaUlicllDNTYwRjh0Z0JzL2xKdVlaRGJiV3ZDbzRyN216?=
 =?utf-8?B?ZEh0bUpoaFFVZVNHd1hwS0tXdWhJemN2a2Jybm1VR3hSb3N0TW9BUkltRWM1?=
 =?utf-8?B?ekYzZTRPbFIxRzU1ZjVlTkUvN2VZdlZrWUpVWGo3N09GUXVUUm9scVp6dWN6?=
 =?utf-8?B?T2NDY2N0TisreGxuUGZtVWRuWVVuMUsrY09lWDhsbE9senNNS0ZMUzdOb2lQ?=
 =?utf-8?B?dnlWMjRmWERRUkdreFh4UUNkNDJzTWdXeThFRGpUZUJaSm1MZWJiZHZsamF5?=
 =?utf-8?B?YTVQaGF2c1ozWE00NjZJTFZmTmw5VjdjQUdicnJLTzE3L1hRcG5UVVpvdHg1?=
 =?utf-8?B?K2JpenA2SGUvcnZ3NTdaUy9XWEF3ZFlMbmhId1dLSG1wQWF0THRGbzRLaXFv?=
 =?utf-8?B?UEx1Lzh0NVo5b1owSUxTYjR6NGlQc2JSdTBXMG0wM0s4SmhJVHpCVEV1YThW?=
 =?utf-8?B?UDcrY2xpd3BZMXhTR083Rm9ZM2tINWZCc1k1TWwySzVudkRzQ1lSMlpUYlJV?=
 =?utf-8?B?TktITHd4QWNzM1pZMDVLZW1kZjRHSGxseHBERlNHTERDdjZqbldlTDl2d3hC?=
 =?utf-8?B?TmVpSnZFNHplSjU4eFJVakNlb20veWVjRE9RR1VUdmVkTkdlU0JhV2w4ZTZ1?=
 =?utf-8?B?amRhNlppWEZrZStnY0VpQ00yeEIvVi9xdFRsK2ZwNHpIMDhuazJxRGRVK01j?=
 =?utf-8?B?QW1qWTUyeGJNRm1aZUhkZUtkSi9POVpVVVJwSVhTSW1VbHVJQlRDbm1EcTd3?=
 =?utf-8?B?dkZQOVY5VlV6cUtIZFZjUmpIanNYdUxWVU5YSS9oYTlVNERSZjdsdzRDOUYv?=
 =?utf-8?B?dStHa3FTTk5Dd1JteVVidjlQSmJaNitGWVZDMHRtNEFBR1UxbGJ3ZHBKa3B6?=
 =?utf-8?B?Y1JrRHVwVUUxUXk0S2VVUUtsdlJuVmU3TjVCcUNRcnFBSm9DNGhjalVrTFF4?=
 =?utf-8?B?K3dFRVBwelRES1B3MTRPQ1hsckcxdUtSVnJvQ3hWcWM3bE9wODlXL1V6dk9B?=
 =?utf-8?B?aG1HSVJYUVB4dEZXNFg4S0xiWGhyQlQvbllRdnlyRjZWWHVwUHZqZnlUamVE?=
 =?utf-8?B?M3ptV1NXWmRiNEZ2ejZDdS9TQ1duMnBPeldCaHZYSVlIK25SSk0yNVI2Rk9Z?=
 =?utf-8?B?eU94bkN4RjVSSWtiRlFCUEpZUit3aktGM2VxclRwSlZ0elh3K29jWTh3NUx6?=
 =?utf-8?B?TDgreUgrWmowblAxeENXK2tEc3NPUTJKbGFCQTNKd1ppeU1RVDdJdHQ5dVpU?=
 =?utf-8?B?Z3FUb2dNNUl0enVxQm5ZRXN2a01sZmM2OGV3THl4QWtybmY1MVJGOXZraHpD?=
 =?utf-8?B?QjMwSVZUdjdvbjRoR0dWd3VJNmIvVHVxb3hKemNoUDZLYzZLbkpPdjZsUEo3?=
 =?utf-8?B?MlhTazljRGpjZGVkQytQMHl4L3NldlVPSEpJcjRlK3ZuVHpoZmp4TXlwWHBU?=
 =?utf-8?B?aFVzeWVDN2FKNEZZd2QrTVdoN3FMYkpiUU9abDBhRkFzN2RQSTZqbjV1ZTQ4?=
 =?utf-8?B?ci9icTFSY1RJeUhmamRkbURIZCsvcFdwV3JwWlBGK2lXS1BPMzNlZk1id1Vz?=
 =?utf-8?B?Q1dveFdwUHBNMCt6dEJuSFRYOUo2b01uZTBMU3RRb0RwNktGTFlSaGZLcTcr?=
 =?utf-8?B?aUxXZDV6eFBRYm9CTzQxY3hFM2xNaCtzNFFhZVlKUUo1eEVjdlk0L0VSeXJB?=
 =?utf-8?B?a3c0REZBWms4cG9nZ21vSWdKMGw5a0wrQ2tqOC9Mbit5Ykx6aXY1ZnJuYjN3?=
 =?utf-8?B?SkZteGNRQnBkUnQzOWoyeVR4eW9BdHJrWXR2ZlgxVGs0TkhCN3VtVDFpOGZ6?=
 =?utf-8?B?QnNFa1R6K0s2Z2t1R2owZzdINEpMQ044aGdUM0g4L3FGMVp4MGlDd0V0SXpZ?=
 =?utf-8?B?TkI4Z1BOY1dZV3ZIcVYzNGFkaTZZajV1OFRzd1dNdXFpTWwvY290aUxkYjND?=
 =?utf-8?B?aGNYNC9DVVB4ZTN0NGV4ZHNvZnhDS2JXR3lMencvTTJZUHJKbXNkRzNqQ2VY?=
 =?utf-8?B?U0t2QlpiMTZML01WcHFvcGJmMGJhdnB2U0U3RTA4NzVjV0trM2k5U2FBTlFs?=
 =?utf-8?B?elhaRmRQTkNuVURVK1YxRnltL1gvWWxSZVlHRlVxSWNNTmFXU1RKWW1GenFY?=
 =?utf-8?B?ZVZVSUlINmE3bzJEb2d4WXBXMnB5clNmWlkyOFVzUVBmVmZNU2oyRWY2UFc5?=
 =?utf-8?B?NGx4WXBEeUZTYTYvRnNGcUJ4TVdJQnprWFZjY2JCYkJXazhuaGlvK3lLRkZK?=
 =?utf-8?B?UmRQajVSR1FMZnNBaHJlaUc4QmtFY2JPMEx4Mk8rekdESzQrcE5ZdS8xMHF0?=
 =?utf-8?B?QVA1OTNuRlFJTFd3ZUY1SWo3eGNDTlZKMDg1eElxemZ0NkVqcE1hRWxIaVNC?=
 =?utf-8?Q?wdnHjdfAqXsAE5jY=3D?=
X-Exchange-RoutingPolicyChecked:
	kEfoWuWRNVtxWiDD0tAZsJhepCTsGIvJVyALUaPn+H9XXT4t/y1l1ZOGVo8lT5gFXn0JZhE2nZxkeCHhLg8b6zm9TRjPbe5nsC6AuIPEFztVDRR89bgnGMII9mTK8kCvo/NyiF9JozVyWTFWlgygL4C81nTC1EqBYTYuxPz/hx4yRrl6D28Aif6VZ1kmbdSzDjMyrr0yOSD2Q9bvk/Q8ayVZQe/T6xFrDXLszSz7mCqOUu9mnC/nGo2zp8HMIAinnhZK/4cJ/LYv5xQA49H/cg4+sb12DcK99/b1tJpHZiZ6rww1YomElvffcQHR/6NzejsbzvU3tjrIqor4/R21NA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7Ppl9U9lXiW7UwyAZY10E7gx8WjgHyBtJQ2AINS2LobZoJEZIN83mdEs6t6GwxPumVspcX0B6JWQ+BeAEqiWZ6ns9lSkjI9WeeUBQdu19YMaeMHK+apxdmDgEyN3PHFvyr1G1zx4vRtcsFkJHjf4KZAWJ5y0e1kk6uEqWAuZVCOfM7P/AkWZpQDYu5bLsj/9hb3sbt4krI1pyOsmwfTx8jDujM2tyH/CGW7opghGkIEyUPg9C8bMX3f2w/2sRh04DNVRcpir3gToB4BQlyb6WQtvyGcqCoGV89s3Jfa8BaqafDTg8VGLA2u2PJRZ0DOMk7VnBjQUTmYM7HJNqoK3bh1fR5Qji0/fk4N2CsqdO18oay1+ZrgmWQuiHadkC1QrQiNWkz6HK2ECyBsSIi+Es1gzvYs+pE3BTq9MKRHO1oeanxmhi5RHPfpsIZKWuztoWJHunjuthyPMxts1BUc/Z3TvTj5gq8xKzDaQ7HhAIpx4MAAgYTe2TYMi3yF6GHHedfmj5kNA6CWZd+qtVkUSrQ1Xp+MrIY6OFIoaSFcOG83pDXmn777bwLBlb7iMqxwcSq0H/S4Qw9WWgTJ8vLTSzLTj+TiohSawbkBy3ythxOs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1be5483-32c2-4078-bcd6-08de8385cad8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:59:39.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptZyicjGYgx0OC6NhdoqeeIPO6ELFkyvuINUtrL0Lsoi3US6XI5OfAkdXJpMFmmjROgioMePUoz2euCA/m8fPiQcvczWVgNl0rd2wdaOgEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE0MSBTYWx0ZWRfXySfyjo/rczhi
 nWqSJzYAGw0f9hV+6E1nNFpJQLqDMNjcsfOUhth5AoDjOhp1B4QkTxqpPjz3cCufosb739iY5dR
 FWsRjNyzBhzr2u/W/6PMEZfx1AbIdxjfIM6y2pYxynqaRaX5C5JppgxC7ZupYpkGH1mfCtCNK3n
 t+nSq1wLKfUa/B8raGP0P98b1e3aQiO6KIGWeQ46shg+oJSpFJEZazEFRyeoTln5kTAqOfnPnNG
 JahrpC00ldt9cUfyxUisrGXx3MkqEV6wk8SLcOxDzQZ7EuQkr7TRPmbzofqMDIsxMKB25mVapqF
 aBim4ue6z6DvtrJmwrpWPOriCHQ7wKL0ikJ2m1AkOojiUMlnHebQsCXr8Ts4EBvn9EFleNQD+JM
 FyWFSN9enpYbJZ4RAaueGjH1oXg0YYI8pztotsvNxx38dxnpZQoXFucA5auhwy761MFFp7YAMa2
 p2wLONZF6/HM7ZB3zMg==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69b8450e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=8VT_f_JQjKcgCu-8pv0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lKcK4HrrC-NY1IpXXcZBFH8gFr_Npoox
X-Proofpoint-ORIG-GUID: lKcK4HrrC-NY1IpXXcZBFH8gFr_Npoox

On 3/16/26 10:48 AM, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Mar 05, 2026 at 10:18:47AM -0800, Stephen Brennan wrote:
>> The "comm" column allows grouping events by the process command. It is
>> intended to group like programs, despite having different PIDs. But some
>> workloads may adjust their own command, so that a unique identifier
>> (e.g. a PID or some other numeric value) is part of the command name.
>> This destroys the utility of "comm", forcing perf to place each unique
>> process name into its own bucket, which can contribute to a
>> combinatorial explosion of memory use in perf report.
>>
>> Create a less strict version of this column, which ignores digits when
>> comparing command names. This allows "similar looking" processes to
>> again be placed in the same bucket.
> 
> Can you please rebase this onto the current perf-tools-next?

Hi Namhung,

Thanks for taking a look. I went ahead and sent v2 rebased on
perf-tools-next, which resolved the conflict with commit cbd41c6d4c26c
("perf report: Update sort key state from -F option").

Thanks,
Stephen

> Thanks,
> Namhyung
> 
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>  tools/perf/util/hist.c |  1 +
>>  tools/perf/util/hist.h |  1 +
>>  tools/perf/util/sort.c | 92 +++++++++++++++++++++++++++++++++++++++++-
>>  tools/perf/util/sort.h |  1 +
>>  4 files changed, 94 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index ef4b569f7df46..6759826be8344 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -110,6 +110,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>>  	len = thread__comm_len(h->thread);
>>  	if (hists__new_col_len(hists, HISTC_COMM, len))
>>  		hists__set_col_len(hists, HISTC_THREAD, len + 8);
>> +	hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len);
>>  
>>  	if (h->ms.map) {
>>  		len = dso__name_len(map__dso(h->ms.map));
>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>> index 1d5ea632ca4e1..ae7e98bd9e46d 100644
>> --- a/tools/perf/util/hist.h
>> +++ b/tools/perf/util/hist.h
>> @@ -44,6 +44,7 @@ enum hist_column {
>>  	HISTC_THREAD,
>>  	HISTC_TGID,
>>  	HISTC_COMM,
>> +	HISTC_COMM_IGNORE_DIGIT,
>>  	HISTC_CGROUP_ID,
>>  	HISTC_CGROUP,
>>  	HISTC_PARENT,
>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>> index f3a565b0e2307..e6012b2457c5d 100644
>> --- a/tools/perf/util/sort.c
>> +++ b/tools/perf/util/sort.c
>> @@ -1,4 +1,5 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> +#include <ctype.h>
>>  #include <errno.h>
>>  #include <inttypes.h>
>>  #include <regex.h>
>> @@ -265,6 +266,93 @@ struct sort_entry sort_comm = {
>>  	.se_width_idx	= HISTC_COMM,
>>  };
>>  
>> +/* --sort comm_ignore_digit */
>> +
>> +static int64_t strcmp_nodigit(const char *left, const char *right)
>> +{
>> +	for (;;) {
>> +		while (*left && isdigit(*left))
>> +			left++;
>> +		while (*right && isdigit(*right))
>> +			right++;
>> +		if (*left == *right && !*left) {
>> +			return 0;
>> +		} else if (*left == *right) {
>> +			left++;
>> +			right++;
>> +		} else {
>> +			return (int64_t)*left - (int64_t)*right;
>> +		}
>> +	}
>> +}
>> +
>> +static int64_t
>> +sort__comm_ignore_digit_cmp(struct hist_entry *left, struct hist_entry *right)
>> +{
>> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>> +}
>> +
>> +static int64_t
>> +sort__comm_ignore_digit_collapse(struct hist_entry *left, struct hist_entry *right)
>> +{
>> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>> +}
>> +
>> +static int64_t
>> +sort__comm_ignore_digit_sort(struct hist_entry *left, struct hist_entry *right)
>> +{
>> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>> +}
>> +
>> +static int hist_entry__comm_ignore_digit_snprintf(struct hist_entry *he, char *bf,
>> +						size_t size, unsigned int width)
>> +{
>> +	int ret = 0;
>> +	unsigned int print_len, printed = 0, start = 0, end = 0;
>> +	bool in_digit;
>> +	const char *comm = comm__str(he->comm), *print;
>> +
>> +	while (printed < width && printed < size && comm[start]) {
>> +		in_digit = !!isdigit(comm[start]);
>> +		end = start + 1;
>> +		while (comm[end] && !!isdigit(comm[end]) == in_digit)
>> +			end++;
>> +		if (in_digit) {
>> +			print_len = 3; /* <N> */
>> +			print = "<N>";
>> +		} else {
>> +			print_len = end - start;
>> +			print = &comm[start];
>> +		}
>> +		print_len = min(print_len, width - printed);
>> +		ret = repsep_snprintf(bf + printed, size - printed, "%-.*s",
>> +					print_len, print);
>> +		if (ret < 0)
>> +			return ret;
>> +		start = end;
>> +		printed += ret;
>> +	}
>> +	/* Pad to width if necessary */
>> +	if (printed < width && printed < size) {
>> +		ret = repsep_snprintf(bf + printed, size - printed, "%-*.*s",
>> +				       width - printed, width - printed, "");
>> +		if (ret < 0)
>> +			return ret;
>> +		printed += ret;
>> +	}
>> +	return printed;
>> +}
>> +
>> +struct sort_entry sort_comm_ignore_digit = {
>> +	.se_header	= "CommandIgnoreDigit",
>> +	.se_cmp		= sort__comm_ignore_digit_cmp,
>> +	.se_collapse	= sort__comm_ignore_digit_collapse,
>> +	.se_sort	= sort__comm_ignore_digit_sort,
>> +	.se_snprintf	= hist_entry__comm_ignore_digit_snprintf,
>> +	.se_filter	= hist_entry__thread_filter,
>> +	.se_width_idx	= HISTC_COMM_IGNORE_DIGIT,
>> +};
>> +
>>  /* --sort dso */
>>  
>>  static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
>> @@ -2576,6 +2664,7 @@ static struct sort_dimension common_sort_dimensions[] = {
>>  	DIM(SORT_PID, "pid", sort_thread),
>>  	DIM(SORT_TGID, "tgid", sort_tgid),
>>  	DIM(SORT_COMM, "comm", sort_comm),
>> +	DIM(SORT_COMM_IGNORE_DIGIT, "comm_ignore_digit", sort_comm_ignore_digit),
>>  	DIM(SORT_DSO, "dso", sort_dso),
>>  	DIM(SORT_SYM, "symbol", sort_sym),
>>  	DIM(SORT_PARENT, "parent", sort_parent),
>> @@ -3675,7 +3764,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
>>  			list->socket = 1;
>>  		} else if (sd->entry == &sort_thread) {
>>  			list->thread = 1;
>> -		} else if (sd->entry == &sort_comm) {
>> +		} else if (sd->entry == &sort_comm || sd->entry == &sort_comm_ignore_digit) {
>>  			list->comm = 1;
>>  		} else if (sd->entry == &sort_type_offset) {
>>  			symbol_conf.annotate_data_member = true;
>> @@ -4022,6 +4111,7 @@ static bool get_elide(int idx, FILE *output)
>>  	case HISTC_DSO:
>>  		return __get_elide(symbol_conf.dso_list, "dso", output);
>>  	case HISTC_COMM:
>> +	case HISTC_COMM_IGNORE_DIGIT:
>>  		return __get_elide(symbol_conf.comm_list, "comm", output);
>>  	default:
>>  		break;
>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
>> index d7787958e06b9..6819934b4d48a 100644
>> --- a/tools/perf/util/sort.h
>> +++ b/tools/perf/util/sort.h
>> @@ -43,6 +43,7 @@ enum sort_type {
>>  	/* common sort keys */
>>  	SORT_PID,
>>  	SORT_COMM,
>> +	SORT_COMM_IGNORE_DIGIT,
>>  	SORT_DSO,
>>  	SORT_SYM,
>>  	SORT_PARENT,
>> -- 
>> 2.47.3
>>

