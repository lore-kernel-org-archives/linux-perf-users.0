Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F71BC9ED;
	Thu, 31 Oct 2024 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410757; cv=fail; b=rmVYIpJLcUVmLkUwOkCyFaaemRp0kQGsMkMUVvamoZtEpiIC8AfIt8htArWeOJS9TTgbcezxNhzzdHA4rP2ASZl4yq54zNMavxDo6h80lIk2Rg36V/0X/jYPCe//nmuBRUsz2fNdPJGtZZWOco89qFJ2WyZeDg5w07NrstM3dTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410757; c=relaxed/simple;
	bh=WprEuwGOqRP5roMiNyknuQCiKoKZk96D1NefFoDLr5I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tW2JBVlGaHuJKfd7zP1IXOlmS95UboLux4BaJ61RC2PG1o8auhvILeFak4LXA+HgL5SA4UsJk1geX+ZKLmJOQ0Vg+2so1ULZDdN2D1FRx2E1IdMpnXYT2lSCXuCJcPydiwYQsTb6nT0dUPub77QBifX2pSD/fdppXOkKU99cuWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MYAJ+lNI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kTHHOt1l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MYAJ+lNI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kTHHOt1l"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VKrwlU019165;
	Thu, 31 Oct 2024 21:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4AvAyhVGTcI3lM/VfI3IJvPhTfv6gRNjaq6QL4M4Xik=; b=
	MYAJ+lNI63/LIxy06JXmoAbBWeTqTeRkT20KBjRSRiQickEzYCFrjQaAF2GqjdwR
	ogAcNPfaTeL06NoFD+XHYKUEvM8dPx1kdRr5yx2DbYtG3Q2GokrDvx5G9JVJeicO
	SuZd3de7XIhtapq5qBdasIDVUNIe8UDkzXPjnP/5PHFSBYEX3ACQ/3TdURcJRinZ
	uSzR9m0Aro0XvDngniglc/IYDWDzc84K2CR0z1Dq+cYn/dNYSaAy4TB5lczH77u9
	ovKyWflCAxzhW63O7wcO91BdrHSpxSYFKBPBMZuwuKVI/wzYQ4A6tmHUwqlNfqEx
	qpl/AJECNbJeSK9v3muPaQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxu9kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 21:38:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49VKVs1c008613;
	Thu, 31 Oct 2024 21:38:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnecvjyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 21:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDGkY3U5RRbHnyszSavLBW/1K/CVh79Hss7AA+XpGcGheV3e9UcnkcPsCME97by0DBLHZvBv7yc+C8pdBVFdZOSfaKIh7SkzWJD7aYOguqHoLwfYLS1HrJYLTcxd2YEGyZ/AvIgX0581Jk/k0iod3i5MSiKFSZjICeoZR5XUkzt0WgWr+bL5wI+MGnnCPcczbQbyhr1e8TOmwKdx4rhLW5ZXHXQTaYiktqMhFL+g4m7pahqGQ1dFqJNUlKACYOA6pE6qUeRoWjNdTI5mCN5cG7YQxHuApEhia/Wo2CbEd2aeoXq77hxc0hEUqsFbEY1RQhE2f/zSW5aETs0n/VcuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AvAyhVGTcI3lM/VfI3IJvPhTfv6gRNjaq6QL4M4Xik=;
 b=QSr2Bhv3gvzQVkLc0IxKRd5i7rqpk41yuJD6RJLRwof7IiUI8xiHRjbj57g1jX6kJRCVTQbOqoBHJs0PDzRMlHPFduAppZSPw8brd5hW5SkaAe1qXF0cDc/aiI+izxQdjacpDtLKW9mlOTHv/27CuVwHA4n+w6xLRByxLLIgvOgxSzzW+VExtXG+9uNS1YrYc+QiQNe++YpWiv6zkHq3AVVbmEAgFlDsZ3gcNExMldlw0eJcNU1Ufj4FrJR6ugDHXPxojFvHDarvcPkMjTadrxCE7pS6fgLnxJvUuPNTLlZQG4BSJVQX0IevYOl6pelHMjOeEUfFi8Wg4qt0Xi74iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AvAyhVGTcI3lM/VfI3IJvPhTfv6gRNjaq6QL4M4Xik=;
 b=kTHHOt1l2U6Eqra3443/1mZbdpPB9LB2thAknlIE01A8kHr22Gqs6NefXK5USO3uPi4uBW/3Aoq2LifiD7kGrgwb7/F6jITGSESfvfTW4ojKq7MpZHjXTHs+Zla/5cVmOTvfjFV1xVT20A/x79jxBvQzXhs7Q9MFN0485Uxz2os=
Received: from BN6PR1001MB2180.namprd10.prod.outlook.com
 (2603:10b6:405:32::23) by SJ0PR10MB5860.namprd10.prod.outlook.com
 (2603:10b6:a03:3ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 21:38:35 +0000
Received: from BN6PR1001MB2180.namprd10.prod.outlook.com
 ([fe80::34e:408e:c7a1:2446]) by BN6PR1001MB2180.namprd10.prod.outlook.com
 ([fe80::34e:408e:c7a1:2446%4]) with mapi id 15.20.8026.020; Thu, 31 Oct 2024
 21:38:35 +0000
Message-ID: <0f40b9b8-53a9-4b45-883b-d4d5ecf9fff6@oracle.com>
Date: Thu, 31 Oct 2024 14:38:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
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
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
        Jens Remus <jremus@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
 <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:907:1::31) To BN6PR1001MB2180.namprd10.prod.outlook.com
 (2603:10b6:405:32::23)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2180:EE_|SJ0PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fd8436-65e2-4710-da83-08dcf9f45fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE11MzRmUWFreERzalJBbVhrUlNpMnNkRUVzY3FCQnhldDV5NHJNcStHd0sr?=
 =?utf-8?B?djJXL3RySEFQMktFeU9GVWtJa3lLWHhoc1FpeXJyY0pZSmJtNEFCUXJyNzRq?=
 =?utf-8?B?ejlrVlBmOXFzdEJzQVNIMjRVdC9oNnpMUkJDUEpkUEIzcmxDTldNZk8xemZr?=
 =?utf-8?B?OE9kOTNsS3J6RFJHT2dLZjRMSW4zdThxMWptZEs1TEtVRjU2YWErTDljbWYr?=
 =?utf-8?B?djNBbWxuTm93QnRsd1VLNUtsaHJOYmFhOTFtUXRSWXpReVNaM0V5N2JBTGl3?=
 =?utf-8?B?UUhXUjgyWDkxVGJNNVFWOCtBL2wzTzJ1MTNqSjdzUlBJNC9yVGpwbldLU2Qy?=
 =?utf-8?B?SDkzTjk4WHVRN09MNUcxbnN2UUxublliSUdLYW1NeEtsMDJua3hJc1JJTmE1?=
 =?utf-8?B?OHFMUmF6Q2hMbmxxcG1iUXlhOTNwS2FqT2pJZzRpUUR0NklFNi8xSnpuSUJn?=
 =?utf-8?B?YjIyUU1yYkpLUDJYdkladnpRS29rc1pFMklpN3VxSm9kckRFQXpBelBLV2Fy?=
 =?utf-8?B?WS9vRUg2SVJ4TTJJYVkyZHlnaE5zZjVsOU9tS3lEdHNuZFNTTTNtNlBsWmlo?=
 =?utf-8?B?c3J3OWlwK0JWT0NQZzRORlBIZXlBblFrbkZSK1NJTnltK0VzZ2Y5OHRzZVVV?=
 =?utf-8?B?UWFtNHZXWnRDUVB0Um1QMEtqSnhMK0lpS2hEWUt2dTIwZVlEam4yMGpvTFd3?=
 =?utf-8?B?OEFZTFZFV3dyd1gySkVxQ0IvajNqVFh1bUZSaUErRW5PZ0VrZkZuSlY5Vy9v?=
 =?utf-8?B?WXl3d1l1U2hlYlBtUUlKUGRuSkZZSy9RUmVDcWhEOUNFOHlQUVJ1MTJ1cnNW?=
 =?utf-8?B?bWorSTFqNi82Q0oyWnI4VVJPV09VajdKT3F5Z01vbHpLM2RwN3lKemJaU1Qv?=
 =?utf-8?B?cTNUaHZBbE5CTGhtenNIQzFMQ2hVQTJocGg1YUJCY0VhUmE0S0Z0WllvL1dw?=
 =?utf-8?B?QWlqV21IRUdzNk10WWNCVm0vNXkvNGl1U2xOdnlaM3pqZTVOQTRxMUx2cFpw?=
 =?utf-8?B?SWtHQ3Fyd05EY00yTTBIVExpblArdmFPN1grUlU2cjJ4YmZzcWt4c0JqdkZT?=
 =?utf-8?B?RDVUaURZZlNrTTB3MHNUZkMvbWJUZFNPSjQrS2x5ZDNONEJENWl5a05udCti?=
 =?utf-8?B?QzlabFRINHFmbDdMaTFlcnNXYVZhcTlWelVrZUI3RDVDOVlqMmVHdFo4RVps?=
 =?utf-8?B?MytGaVZ1WE4rbkxGR1J5c0JuaVZNL3lDZ2pnUHBpNjZIT3FFUVpXK3ZKdVNw?=
 =?utf-8?B?TFBnb1JvSWN4TW55TmNnMmkzcll3S2ZreExybDh0UFRwVTExYUdGamlURGI3?=
 =?utf-8?B?TEVKblhaSmlTSko2UjMvZGt2RXZhdVJ6NkxRc2ZGKzdRVkNGMWwraUFnZUEw?=
 =?utf-8?B?RkpuUmdLMnNxMDhhYjBHR0xXaFFpOVF0djRGdW5rSnFyT01yTnkwNUQ0QkFl?=
 =?utf-8?B?bFpPU2hIZWFuNEVkZlBlZ0FLc0Zsait4NktBUXh3ZUNETG1QTHQxTlBHS3Bz?=
 =?utf-8?B?M3RTUXZhQXhIWnpGdlhFT2tqMjl1dnV1Q3k4a21SNWMzTlVNN2QrQ3FaNG5H?=
 =?utf-8?B?ajNhY3VxVWhrcTJCV0VaMHFTVG5uSTBaK1NPTVVFMEIzUjFnVy9EOTk3VHpR?=
 =?utf-8?B?UGVOcG1GSGJ4RjZFVTY1NGx4NWRSQmRENVRxSGhyT1R4QVhJTjgxQmUxSnlB?=
 =?utf-8?B?OHM1THZ1R3dITHo0cTZzVEthSm0rQVhlMWpiRElpYVpuZytyVzYxUmN6MHlS?=
 =?utf-8?Q?1/AQGz157+b12CN0a/ZABiCTp2mOH+5zGqsBeZS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1001MB2180.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2VpTmpBSDJmNGJBZjFwWXdia2pYZ3p4cDdjL25uRUxLQWJiSGVKQ09ISlFs?=
 =?utf-8?B?Z2Q4Q2Nnd0hDNTJKeHV5RDkva2VlRVd0SFVHU1p2M3dUTG9FWGYrM0R1K1l0?=
 =?utf-8?B?V21ISU43RUtnYW1HaWlXT1VBYS9Pdnk5bW9QdVh5b2ZvQnIzbFZ3QVNCbWJI?=
 =?utf-8?B?L0x2VkhJanErL1BjK1FwS1NWTkxGc0IrWC9FVTJmRXRoTUczM1pOOWd3VXh1?=
 =?utf-8?B?ckRsTkpKQ3VRdVJBaGxXbjlMME51RitrS3MvVkhJdDFCam83R1MvWGZBdzVl?=
 =?utf-8?B?R09Ya3ZLSVZFSVlJdmNRdjlLdmVOUFZpTEF5MHVxdnFkbmNDc3RnUmlTcDZR?=
 =?utf-8?B?YmhLbzRDejFwL3JuTVZUY0xtNWlWWXFjUTUxN05wMzNxbWhCelZtS05QaHJx?=
 =?utf-8?B?bm5KeVcxNGlhNlQ0VVBvMzJJTWVhcDRuZ0pLVDhLYjEvNWZaMUpkMjNPMWMz?=
 =?utf-8?B?dzhXUFI0enA1TWxCc1JSV0E2dTh5TEM4YmJsbEtPMXpkOWhOWnhjcnMwSVBr?=
 =?utf-8?B?MUFVUTNVakdMa09CaW1nUlN5c1BSWGFxbktjY2xOR1hpNk9JQXVwWXlGS1pr?=
 =?utf-8?B?WTd2bFBHcVdhM0ZIMXpzNXFJcDM5U3lsVjhtY0xwclVubDJVcmRWU3IzWVRh?=
 =?utf-8?B?ZkVvZ1BOb0RIc0ZlZzBIZitVZVhqcm1jZG9zRVVkMUVpb3h6L0ZSelNzYzNX?=
 =?utf-8?B?RkI3M1FBakxOWmtpMlhpY0ZORHo4SGFEbGcvU3RiZ21tdjB2dFpTWHI1dmQ3?=
 =?utf-8?B?T2ZpUnBMdlRzdG1uK3RPMmRjUlVlTWhyZXdVV3dCR01QR04zSTJrZUpxMS9H?=
 =?utf-8?B?clRpQm5VU1ByTjg5L0hvcUIxWDRzKzljRSt6R25JY00vdFRTenpkMHN1cEN5?=
 =?utf-8?B?Y01McDU2dEVQY0gzWjJKQmZ3aFpYWFZ1NEQxSElpVlhZbDd0M2hMS290WGhC?=
 =?utf-8?B?OFNmeHBNbmpUbXk5RjUvQVhDUDVtRDJNTkc5UHpCWWxZMHFZeVR6elhOTTlk?=
 =?utf-8?B?Y1FMSmFKbDhYKzZzdjdEWWdhaTY0dkJ2bmhhNVBXOFZzWEFnY0VtcWpWUDRt?=
 =?utf-8?B?bmZjQUpkU3pYSFJKaVErUDR6dkZ5cnBqYnFyN0ZBS2lyQ2R6cHU3S0tNbVo2?=
 =?utf-8?B?QnAxYzZ6ZitMUzQzdXRUeG4xTHZObWhYeTBtVE9DVE83dUJWekI3bnUrbXlJ?=
 =?utf-8?B?TThsM1J4Tk0vM3VYeC9PeXhYdG1tQWhQVStsYjhiTFdiT08zc3draXYwK3lp?=
 =?utf-8?B?NStjZHZNaHJhdStuUlN6eDUzcG5tRmV6YktJY3RQUWhpZ0dOclZ4allzVUg4?=
 =?utf-8?B?VzJwLzRkeXA4UWJYRlY4b09LVU1EaVJnSStKSWFzaElYbWNkWmNVM01xenoy?=
 =?utf-8?B?bWVvTWtCM2l2RE5wZ2M2RkU4TUcxbzhaWFEyaks2VDhyakp0L1dsOXloS1o1?=
 =?utf-8?B?SXBLS0pxWml6YTJvcDBGM1FMSGNXdm4xbHY2QVBaclo0VHgwK2dML2hTN2xx?=
 =?utf-8?B?TEdDZmQ0WDBsVURYNnhhMlVRL2NEOSt5QjlCQWhwTThPckFqMzNwdys3L0lC?=
 =?utf-8?B?dEY3THRPaUExU2EzWW1ZYU00WjI5aE9NMUtUOUY4SGhUWUFQQnZuQ2JkY0tN?=
 =?utf-8?B?KzRNTmRMYXlrbzNhT1l3TlQ2SFMyeGI5ZGFxMmsvb2xRVFBiRUhuYjVRWlc0?=
 =?utf-8?B?cTViaHg2eHhyYitub240NmVOMUJha1NXejQrQUJmaWc0eEk4TlpFUHFmeW0z?=
 =?utf-8?B?TEhaZFF0dWZzZjZ2WFZ3QlRsNFFMRlFCNm1QTGNSWURla2lUOHRJcVhtWG1G?=
 =?utf-8?B?c3Y2ZVVSV1UxdE40aHI3Sm0razFkZHcvZEt3Tkhnd2gwNCtsNjFkOE5nVmRj?=
 =?utf-8?B?NDFrc1hzMFZiWm93TEQvT3lxcHZJdEdoZXNxSzBoQ1IxUEorTUJHKzAzQVRN?=
 =?utf-8?B?bEVEZVZGOU9ldytEdTdsMCtYOFRJenFYMjNIYVcxT3VrektrNmltQ3BBZDEr?=
 =?utf-8?B?aWJRcHdMbkIrcVZnMXV4SkNaRGt1SU1ZMHpGTVVpY0VCaVB3cGZWeWxOcW1y?=
 =?utf-8?B?ZEc2akVrL0k3YU1kWjdxQ3o1VFNZRnBuRG9DTnRMdDlPeUYxeDNXSkpzU3lk?=
 =?utf-8?B?allkK0FHbWtZS1pKb0dVbitRYXFBZ0NVaThPL3pXZmNsM3ZDSUVrVDZtcU8z?=
 =?utf-8?Q?xOfVi1w09d0Vinl+YGfQnuQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L4XbxI+I7Vr8dF5Etl3+V6nApYw+i63+N0CyIl2BxGjfkNIMHrfUbNcyMv+38nCW/XpbJuRsLDNkwaZ4vcqZEy2EiPHbEAP/bvV06sUismuk+X38xi99PMcimNEJZywV5S4vhVN8XZAIKQvJ7eDc6ggz2U+OUUCj3xhvBtpz62Nwt4i+weLSyNYXoZkACsnLgWtyfZynfnSubIfk+yh7rqzTgFMiHApnt0qKabOrkrfwvPLLMYX8WwRayyJNLpv2cg8Bs7XJGk/YKjecBHlIBa14I6vyZUON7x5PPCVBzcjqCE/I/Hf+VqK9ccxTgqJkoXtve78dYD9WqdqqXUbtaE1YX/rbxbeIg0ZbrPuDFYIGT0IVM0klOfWWlBjxqKJyJMRYKftFvkKAZymo8f6naFLDL2PX6ofvU6bSAtuU0X2dlByauxlyyKcHXCd3IpvU2iOPce8tJs+ZZHhTz/q2JQD2XD7nb2lZaFdgouvy26Z8zADVSlkVv4t5CFDaXMQ/8oehgeg8UMeI6znQF0ctSfaJKlIVi1C1YzomdD2FOmoCKzNVjZiJyBsVvcqIOfqf4SFvbv/8g3xUja5NoYQqW0om9rtCxS+Yoj+lhaeevSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fd8436-65e2-4710-da83-08dcf9f45fb2
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2180.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 21:38:35.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrzuQv4nqbMUbrzBcJmb9tMIRpFBfAxqCnp41B5eR1WhVMooYUgSR6tLtzr8n4lkkmjLZ1Bn2KEd5QI+c+SAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_12,2024-10-31_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310164
X-Proofpoint-GUID: PjUPRL5VVqSKYLY8r9Ujr0g1OPdcVESL
X-Proofpoint-ORIG-GUID: PjUPRL5VVqSKYLY8r9Ujr0g1OPdcVESL

On 10/31/24 1:57 PM, Andrii Nakryiko wrote:
> On Tue, Oct 29, 2024 at 10:53 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>
>> On Tue, Oct 29, 2024 at 04:32:40PM -0700, Andrii Nakryiko wrote:
>>> It feels like this patch is trying to do too much. There is both new
>>> UAPI introduction, and SFrame format definition, and unwinder
>>> integration, etc, etc. Do you think it can be split further into more
>>> focused smaller patches?
>>
>> True, let me see if I can split it up.
>>
>>>> +
>>>> +                       if ((eppnt->p_flags & PF_X) && k < start_code)
>>>> +                               start_code = k;
>>>> +
>>>> +                       if ((eppnt->p_flags & PF_X) && k + eppnt->p_filesz > end_code)
>>>> +                               end_code = k + eppnt->p_filesz;
>>>> +                       break;
>>>> +               }
>>>> +               case PT_GNU_SFRAME:
>>>> +                       sframe_phdr = eppnt;
>>>
>>> if I understand correctly, there has to be only one sframe, is that
>>> right? Should we validate that?
>>
>> Yes, there shouldn't be more than one PT_GNU_SFRAME for the executable
>> itself.  I can validate that.
>>
>>>> +                       break;
>>>>                  }
>>>>          }
>>>>
>>>> +       if (sframe_phdr)
>>>> +               sframe_add_section(load_addr + sframe_phdr->p_vaddr,
>>>> +                                  start_code, end_code);
>>>> +
>>>
>>> no error checking?
>>
>> Good point.  I remember discussing this with some people at Cauldon/LPC,
>> I just forgot to do it!
>>
>> Right now it does all the validation at unwind, which could really slow
>> things down unnecessarily if the sframe isn't valid.
>>
>>>> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
>>>> +
>>>> +#define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0),
>>>> +
>>>> +extern void sframe_free_mm(struct mm_struct *mm);
>>>> +
>>>> +/* text_start, text_end, file_name are optional */
>>>
>>> what file_name? was that an extra argument that got removed?
>>
>> Indeed, that was for some old code.
>>
>>>>          case PR_RISCV_SET_ICACHE_FLUSH_CTX:
>>>>                  error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
>>>>                  break;
>>>> +       case PR_ADD_SFRAME:
>>>> +               if (arg5)
>>>> +                       return -EINVAL;
>>>> +               error = sframe_add_section(arg2, arg3, arg4);
>>>
>>> wouldn't it be better to make this interface extendable from the get
>>> go? Instead of passing 3 arguments with fixed meaning, why not pass a
>>> pointer to an extendable binary struct like seems to be the trend
>>> nowadays with nicely extensible APIs. See [0] for one such example
>>> (specifically, struct procmap_query). Seems more prudent, as we'll
>>> most probably will be adding flags, options, extra information, etc)
>>>
>>>    [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-3-andrii@kernel.org/
>>
>> This ioctl interface was admittedly hacked together.  I was hoping
>> somebody would suggest something better :-)  I'll take a look.
>>
>>>> +static int find_fde(struct sframe_section *sec, unsigned long ip,
>>>> +                   struct sframe_fde *fde)
>>>> +{
>>>> +       struct sframe_fde __user *first, *last, *found = NULL;
>>>> +       u32 ip_off, func_off_low = 0, func_off_high = -1;
>>>> +
>>>> +       ip_off = ip - sec->sframe_addr;
>>>
>>> what if ip_off is larger than 4GB? ELF section can be bigger than 4GB, right?
>>
>> That's baked into sframe v2.
> 
> I believe we do have large production binaries with more than 4GB of
> text, what are we going to do about them? It would be interesting to
> hear sframe people's opinion. Adding such a far-reaching new format in
> 2024 with these limitations is kind of sad. At the very least maybe we
> should allow some form of chaining sframe definitions to cover more
> than 4GB segments? Please CC relevant folks, I'm wondering what
> they're thinking about this.
> 

SFrame V2 does have that limitation. We can try to have 64-bit 
representation for the 'ip' in the SFrame FDE and conditionalize it 
somehow (say, with a flag in the header) so as to not bloat the majority 
of applications.

>>
>>> and also, does it mean that SFrame doesn't support executables with
>>> text bigger than 4GB?
>>
>> Yes, but is that a realistic concern?
> 
> See above, yes. You'd be surprised. As somewhat corroborating
> evidence, there were tons of problems and churn (within at least Meta)
> with DWARF not supporting more than 2GB sizes, so yes, this is not an
> abstract problem for sure. Modern production applications can be
> ridiculously big.
> 
>>
>>>> +       } else {
>>>> +               struct vm_area_struct *vma, *text_vma = NULL;
>>>> +               VMA_ITERATOR(vmi, mm, 0);
>>>> +
>>>> +               for_each_vma(vmi, vma) {
>>>> +                       if (vma->vm_file != sframe_vma->vm_file ||
>>>> +                           !(vma->vm_flags & VM_EXEC))
>>>> +                               continue;
>>>> +
>>>> +                       if (text_vma) {
>>>> +                               pr_warn_once("%s[%d]: multiple EXEC segments unsupported\n",
>>>> +                                            current->comm, current->pid);
>>>
>>> is this just something that fundamentally can't be supported by SFrame
>>> format? Or just an implementation simplification?
>>
>> It's a simplification I suppose.
> 
> That's a rather random limitation, IMO... How hard would it be to not
> make that assumption?
> 
>>
>>> It's not illegal to have an executable with multiple VM_EXEC segments,
>>> no? Should this be a pr_warn_once() then?
>>
>> I don't know, is it allowed?  I've never seen it in practice.  The
> 
> I'm pretty sure you can do that with a custom linker script, at the
> very least. Normally this probably won't happen, but I don't think
> Linux dictates how many executable VMAs an application can have. And
> it probably just naturally happens for JIT-ted applications (Java, Go,
> etc).
> 
> Linux kernel itself has two executable segments, for instance (though
> kernel is special, of course, but still).
> 
>> pr_warn_once() is not reporting that it's illegal but rather that this
>> corner case actually exists and maybe needs to be looked at.
> 
> This warn() will be logged across millions of machines in the fleet,
> triggering alarms, people looking at this, making custom internal
> patches to disable the known-to-happen warn. Why do we need all this?
> This is an issue that is trivial to trigger by user process that's not
> doing anything illegal. Why?
> 
>>
>> --
>> Josh

