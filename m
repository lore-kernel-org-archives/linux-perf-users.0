Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503A34D93C;
	Thu, 30 Oct 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843871; cv=fail; b=ltMWvPpYGhCGHZTKzzOI11LITE+olTUL+XyR4ZntOyFwaCXvOUOZ3jsWCKEHN88Cv+Ox+qw5txd8kuAzzGce1kSVXqm2o5YfFmOWqjkiTeVhzjXctoA2UVqtqRQebWP0NEFgEmnGkBK+Loz9xGwXplaMvFa/NlR3ostLFCRqqu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843871; c=relaxed/simple;
	bh=UqQ1Nd0QdxNnMdwQF/1J/cQr3GYCmFP7ngCIKw/HG2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=MKjbsn4rc4sK1tUAgUROZZwXmdAEk6su+F6TTcjSaBmDVZiHbK2cXS6KMvUGBeHBAFkvH5AZS4B6omJpa7jpAcZsMyTYr3pvx/aXMGffsYmb9Y99EgT1wclu1Pwtn4uis7iQv7vW0ewaZHSmppZ3VxVzHWg2MJ0zX1rFM39XplU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cHN60TQc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vNsDXiXK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cHN60TQc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vNsDXiXK"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UGuUtE005241;
	Thu, 30 Oct 2025 17:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bcV0dZMlTIEKEDwwSWFpjZXtBL9cxQAK2vLgMi2qnI0=; b=
	cHN60TQcvE8nv9p0TrwpucQLWlMhWIljijJJqkPszHJVYaC8WdJQ++7btQs8eEKe
	Rp1AK1K3xAMOHMyqqtaxBFqamhKO8HAfDiYLPj6b5EpsTJsUUyPw8hte4q+aoozz
	9BsaNy7M8NfmHPqd818D58Ski+5cmkPUzgXDjhB5kM/asQc4sSDg6qPWqf18cT3P
	0elbZiCiUFng7iFznnpKNLymc7r27TJP/3YCEBllmQ0WqI4NHZ6MBSLqlnVR/DS2
	wtHzSDbEeY84CX2NjNEr1eFbiukLFvP4ATmzoIos1r4sScLG/o/tbBKNj/hRDZjU
	W1iY1Iuj1/EtvsCwkoG7Qg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4amrg7dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 17:03:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UGH86J027700;
	Thu, 30 Oct 2025 17:03:39 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q9bwww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 17:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2K7RbWslz/vYFNsw1EeNhDc764Mf9e8ep3hPDuUHjJalWM/0cFEchRkNScZyPAClBnHngwl+xEF4Yp+N1EOz+foek7XpAWcWPQD+sO24EWDo1GcPZVG+30JnyGDtD/CyOPTU8yvY9S0ZggaIBSaeJo9gz9oj3AS7r1bxQxoBRq5VFmeZG7dQpZaC5XDkRZ5Z7ii3xR+vj+EhrVgfAehczIg1j3CNEmkL8XVuaj9VPLNgss+d/x6plcD77G/U/afd3y3TXp7dIIx8dAb5QXqdVVwngLtr0w2l/0yyD1YvDA3i0Inj3uO6Ok4o5B9r+qCLZAaZgwvPAAHlvacUJifZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcV0dZMlTIEKEDwwSWFpjZXtBL9cxQAK2vLgMi2qnI0=;
 b=XLTPMwFeIQEp3HYawl92Pi7cJpKy/4bbGheLV7G4hR5uvufr5D2mtuV+kIsfjqOzmehdL+aqmCjwPmIfyNIU5zGekry15L4SU6KfxuPXyhRF+pglLwqhaZ57y3y65Ss6dHrj0FdqAJMlA03Z4IhB7gJpTPvbcFaTAySyCWqcdQ7vt4DRsu18ohOGgmajGpmwMFGLTx/tut4k2Okq7RmTraKG0WW8qulhihGrx9+usvCVQYBoNU5GaBa613d2+tSSZvpuJ/X/NAS07ZcHrm5iFQwMc2dILks+zBIhJ/exXqfnnXD/ulSq/wPaFJYWBI0txaXNgGDRjkQv4a45pF6vCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcV0dZMlTIEKEDwwSWFpjZXtBL9cxQAK2vLgMi2qnI0=;
 b=vNsDXiXKjRkS56RspaDJiqCfxRt9KldYS4wTgmTJwL1f2E5RBoG4Fzo1R1giJBS9LJBfIAN1mxY0ixRs9+/sSD6kc6r7jhUfozVIkHVoeGYPwKAf+CqfDMmu6j8JqqSH+xP/YTkpTHQNWNmO2+Rl2qwgh5qt3jVk9fyttZRlehg=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by PH3PPF2B2347B8A.namprd10.prod.outlook.com (2603:10b6:518:1::792) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 17:03:27 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 17:03:27 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Fangrui Song <maskray@sourceware.org>
Cc: Peter Zijlstra <peterz@infradead.org>, <linux-toolchains@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Concerns about SFrame viability for userspace stack walking
In-Reply-To: <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
	<20251030102626.GR3245006@noisy.programming.kicks-ass.net>
	<CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>
Date: Thu, 30 Oct 2025 18:03:23 +0100
Message-ID: <87zf98tj8k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|PH3PPF2B2347B8A:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e0efa2-1caa-41cf-13e7-08de17d63e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEtkanVjRGx2bkdLWkRuNXRwQjZwRTVxOVdBaUNEdlhvdWQ3emxSd3lGdW40?=
 =?utf-8?B?aUVXM2k2Z2ZQdEdGMzZNMFg3UWh5TDFwWEhtcExSWnh3Y281T2JHRkpUUEQ4?=
 =?utf-8?B?blhkWWpVaFFoaXkwcTIzL1dhLzYxMEhzaE1NOUxTREYvQzg2QmJ3a2RRZnNO?=
 =?utf-8?B?VHBMYWswSCtkZWQ0ZHFYZS9UdGQzdlQrOXlodTdpRlc1OE9GUm1wYzR4ZzZm?=
 =?utf-8?B?V2E4WDUxY0lJZVhvNzJRU2hrRmRMOXNZUHlGVDBxM3VRdFlSR0Zjdk8rd2JN?=
 =?utf-8?B?L1BsMHZOa3MzMXNCQTEvZU16UmVkSkNsbnhCWGtiWHVBUE4waGp5TkQ5Y2dq?=
 =?utf-8?B?emZDZG55UEpNSXNZMUd1K0o4dU1QWk5nYXdoWlREaXBud0lBMXQ4NHk0dXUx?=
 =?utf-8?B?NHlpTzhabkYwTkMyU3FTbng1TXJ1My9ZMG8xa2FqbkVmL3RpZDBRTHAxY2Jy?=
 =?utf-8?B?Q056QnloeHlEenNjN1pIa2NiUktpM2VOazEyUmZnSlBiNXFOc1ZxZDEyM2hV?=
 =?utf-8?B?RXl0aURzS1p0aXlaOUdncXZTaGs1aFhtamZ2T0JreFk2RHlyMHR6ZzRXalkx?=
 =?utf-8?B?L3RWQmFSTGdtUjIwazhoQ0NZaWtlSTlSeE83T1dRbWpzRHVSQlJwSG02WkhG?=
 =?utf-8?B?ZWNoejk4a1I1eHNCVmMxM3hPTWpCUXNIbEt2MlRDK25uaC82eTlsM3ZIZUZN?=
 =?utf-8?B?UDRseWJJT1pYbXZncXpvbDNFQVo2NWdjV0RhZ3lSczlkWWtXbXA1blM1S014?=
 =?utf-8?B?LzdseE5UMlVKODlFTXFlbXpQWkJIeWhrMmNNT3BCQ2h2aHlHTW5OSFBhWnEv?=
 =?utf-8?B?N3lEcU9hVHJxOVI2SGdaYStMTzlpN0ltZTdMMEFuV0JrRjlDcE1LNDlZNFYr?=
 =?utf-8?B?OWd0MjlRYmlBMDRHQkhhMENMaTBtK25XOGVFbDAyTGZTWi9ldnJUU1A2eW0v?=
 =?utf-8?B?a1NCaHZZTDhlOVF2YzAwcGRaWjFmMmZTWFVVcHdQWUVsM1FpU0xXL0Rwc3cw?=
 =?utf-8?B?SUlWL1A4eGlTbHAwcTNiaklYM1ZFUWtNT3ZqbzZXaks4RUtKNUF4OWNBY0My?=
 =?utf-8?B?TW4yOE9KQm1Ncjk3eEJ2Kys0a0VGM1pEOWNrKzQ4aFowK1Y4NFVOajJzaUtV?=
 =?utf-8?B?RUZ3bHNyc1BlRlVGWFpMVmMzUGl3bjBSNk14T1lqMzNmM05ST1piWVJMbCtL?=
 =?utf-8?B?RThybWFCR09EY1dQaGRnU2l3K2dDeTlQcVJOd2RQS0NZMkxQUUEwdHJTZ3dn?=
 =?utf-8?B?bTFhUHl1Y3hSSVBHakVFOVNpejNRc0NoUmhqT1EyUm1KdXFITk9Obzk3OThY?=
 =?utf-8?B?UWplSVJuQXQ4bkQyM01penJlK0wxQ1dSYThSS2NOUTZQY0VtNkMyZlpJUVBk?=
 =?utf-8?B?eGJUU3MyQ25UMUNqdWdCUkp0aEhNd1dka3F1Y2pKOThHaENkU0NkN0RQaWI5?=
 =?utf-8?B?OEt0Z1hHeWVjcDBqU0t5R0UrcWlZbWxoVUdFZ0RBYVQ3d1JWYWlEcDVHQzVl?=
 =?utf-8?B?bmhVai9hT0dqQi9TV0FUaGg2THBzODdsMjY5UE9DRE92MmtHaGZxcm5vck9s?=
 =?utf-8?B?eFdSRXE1RTZzVEQxQ1BUMUVWYUl6amwxbGEvY0pnbWozaFhvUnp2cVdMSWpR?=
 =?utf-8?B?UmdQNjJvNmVSQ09qL2lVZEV0WGNXdnFlMEdYR2x6cmp6VS84RFRHZkRhSExT?=
 =?utf-8?B?a2hEalgraDJnKzlzZTQxYUhvY0JEYkxBL1pPTCtXMnB6bTZCUkRvN2NVZU0z?=
 =?utf-8?B?ZWVpT1Nsc2pDZFJlLzE1T1UvMTVmY1NJRkZwOVVBREhYUVAwVFZEVk1Jb3hP?=
 =?utf-8?B?NjludVNESVc1cDBTejBvZlhFbFFXK1R3Si9kbEMyZ2JkT0xzVUdtV2ZtSmN6?=
 =?utf-8?B?eFVqbUZiM1BzNWhPV0djVWJoWVNvSXZHbXAxV3VIbUxJNmlEekNlcFFQNVJD?=
 =?utf-8?B?WUxFaHRudFdwN1ZNMGtyR2NtdXVYNXFEbFVYTU8rbThhb0ZaS1RPT1lyRnBo?=
 =?utf-8?B?MjBZcHlRM1hnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtBYzY2YUlsZ1JSZGxDNlA0cWsrVUNXQzZKOGdGazlWMkpYNjMrMHdKWG9h?=
 =?utf-8?B?cFVDYlVoQ3laTUZoRzdaQk5oaTBVSmtzcUd5M0NIc1VWMG10STBZTC9kNk5u?=
 =?utf-8?B?TWFjQlRRYmRyMGIzTzBtMkI5Mjh4aTVxVGtGNnhRZmNrZXBBam5UcDcwUHNL?=
 =?utf-8?B?ZUY2U3BKbXF0c2NCZ0VtWi9jNEgzZjJPVndlT1lUM3dkTG9IVE9HRks2djJH?=
 =?utf-8?B?V1ZoVVFhRnNNVVNHZGg4RDdKMTRSVzByRmtXZ3BnK29lOHRkR25GcDM1aG95?=
 =?utf-8?B?bWkyRURaWWJ6YnF6Vkh2ckh2UFJSaFdQS0laLzg1cTJxQ2JLbmVFZkJicTlK?=
 =?utf-8?B?UTdxZ0pXREVGQzFXV3VrMDJPY283aHRBWFlsK1lja0xwZXVpalUzWExSUFRv?=
 =?utf-8?B?dnRrT1VVOTA4dVUyeFV1NmQvK2tUTEZWMVRNM1NEb1dhdHFQNHZ6ZDd6QXV4?=
 =?utf-8?B?SEpHYklqam9uc1hpQ1krVHRROFN4R0l4b2dtU0RpbU5CRkorUFdUYUNyZjNG?=
 =?utf-8?B?Tlh5VGF2cml0b3pqOE1pRVJQRU5vaGcyL0dPcTlLcFJ5ZlV1eUZUcFJHc3A1?=
 =?utf-8?B?YjNXcjBydTZnK0JhZmRWK25FMzl2VUdIcm9Vd0YybDl2NUxGS0RJeXEvUG1S?=
 =?utf-8?B?TmgxZFVUZllnUjBhR3hZazhIaS9OeStWMlNNb1NuRS9yaTNQdTBweHVLNmVq?=
 =?utf-8?B?MUhKNE1mdENxM1FRc2t6dG5ERHVlR1B0NmU4ZW1PZ2E5QkdIRzB6YjQ4WDR0?=
 =?utf-8?B?U0Y3cGNiWEFsMDNVYkRnb2YrdEpObW1UcE5KMnJCSDA4SkdJa2RXTUpGRUN4?=
 =?utf-8?B?S3ZiaUREK1pMTEFseHdKRjdsT1l0cjlJM0twa1JWb2xMdG5jNDFTSDBaOHhD?=
 =?utf-8?B?eHVzdWs5WFcwWlJJZllZMzVWTjAxVEpSZ1kzcHRvNHowVFQzVWRQTXhDVm1a?=
 =?utf-8?B?Smt3L1R0UFZ4TGVmUFZybUF6ZjBxUldqRHhlNmZlSllpY1Q1c2NDOWpaTUkw?=
 =?utf-8?B?NVN6U3REcU53VllZWUYyTjhFSzc5ZHlGSEtYU0lRZ01FNzJzdi9vdlVmS016?=
 =?utf-8?B?UmFtMU03SlZNRmMyYkorVXRMK050TXF0MHp5V0cwd3N2OHVVUUpyNkNJcVV3?=
 =?utf-8?B?a0M3NTF4dFRSMDJGNkhtQ3BaK1pIYWVmNnM5UGl4ZFRLVXhrR2hoMHoxeTJ3?=
 =?utf-8?B?cE5GejlPUFlRV0xxcDd6dEl4eTkycmpWYmxwb3pUYXNpN0tQOFVtUTl2YnJM?=
 =?utf-8?B?RGgrV1JlUGM5SEFSci82aStyZ29QVzY2T1lXQmdKZXdDVk04ZEthMWR5Szkz?=
 =?utf-8?B?TlpHT3Z3WmcwVXNWK1lwaDlLQkRKMTBmTTZKSGkyMkNnUXA0ZmZiOGdTU0hC?=
 =?utf-8?B?US96SndUV0p0UDBpL3dRY0RwNy9Pd2lITG5YTEFsYU9obEpFRU1rOU9RMDhw?=
 =?utf-8?B?S09RbENlVHdxZ2pHcEpPZzRwamFya3ZNSE0yVE5tMlJKQnAxYldYdEF3NC9F?=
 =?utf-8?B?KzcwWkJBNVFIalc4eURVUUZWNGxOQlQvUFhWQmpQOVpyc1RmMmVSaldWTHBZ?=
 =?utf-8?B?RU43Z25EbjFKUzcxa0YrUktsRERVMElFZkdMZHVWbkhaVE1USGFKZ0JZRXhC?=
 =?utf-8?B?VnBZblJxaVFBMVJRODh6dTg5UFFBMGhjOXFyYUtod0FpWEhWVUp2YVpsTS9r?=
 =?utf-8?B?U2tFTmtXMHdleVl3SDQ3QjV3aCthdnpDWmIwQlJnZUoxZ0tOcVJUY1JBaFV1?=
 =?utf-8?B?MmlzRmFoWnBGZUFtSm5wSEFKcWVkdzVnZU1HZzA3ZWI3VVFVdlZxQWU0NFk1?=
 =?utf-8?B?V1lHUjhBN0U1ODQvbGVSeGF2VHZYc1hlVTI0aTdiTG5PV3pvU2R6UE5leG1Z?=
 =?utf-8?B?NEpjd01BeklZOXJmN1dWaC9vcHc5K2dRNmZmZzdIa0QyNlZpQnNJSld4V3Fw?=
 =?utf-8?B?UkQ4MTc0ZHlCdHB3RUhINUpSWFJoUVRHWW0xemhBZXpxdzRFcGRwOVZCQzlQ?=
 =?utf-8?B?MnJ4TXduQk0xYU9WQ2VhbWhyL3NVM1UveHk4MjdMRXdPZllwU1kwMlhxcXgz?=
 =?utf-8?B?aDRSOWhYK2FPQkpHeFQ2K3ZHTmw5OVdqV2ZBbEx1dW1hUUxwQ21CSlQzZTBZ?=
 =?utf-8?B?R0kvMjZrU3cyTzJlcTFGMVgvdm9oWGlLN1NEMkticUlQMHo5TVVEaE1kQy9Q?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rdehWU1QdneGgBnjIJyOZwMq51isBB91NHm7lkOl6XSlQRZN7wEtoAvV2q2t4SLX7cg88YUL4I5R6Cfx9aa4EE8O12czJahSbKzZTfEb6nRk50eQewjS2/EP0X0x5Tvu+lGmbrtkgIA/giajHppTvXoZEcan3cF+UvZt4k5Z8/pJJh0njLcMbF+u0wzWJag5dqIEZ2Vw3DoFOJA2fJ6khzOT4twVhApLpOiqcXq3rWzP4oeX5B+SfM+e/WDWvuWlbqOe2y9QU8CRVO3qUHggfowwNvGhb3lrFwskrNbycXVOYlCiWsACAA1RtPJAeAiJYv7WdpFsM750upqeqzo76FJilihW/Tn4BBYjZSfscO1BbxT5WgitKw0MU7bikGxOWNh9pa7oo3Cyk3HSq9DFe2inXN0o4gY+TQ6pco3brDhP1smJR1M7ywS33K2Ormzs1/c7vJFwlBQS2EGnfmp9ZjAfP9DGjFKNAI/mw81yLaJ6/HAp0pjkUiZo62D3yoqsAPA5xRi/lI/gMCC2XjVvyx3LqiKh7IH4VN1oeDrpMDLpV/a/Pewg9PRmgNO3TDktC8Si8fScXGdQsyd804RMTQDc6ji3cif1taF9FuxKk/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e0efa2-1caa-41cf-13e7-08de17d63e5b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:03:27.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6c/X8R8URtBD2zeguZ0RYTL+UF6BQvP1pekGGbLdNw4sswnU/R+gaxIl4DtIre0FSq2VeoVQR4e8tQ/1S88NyrqPEvA7pskHoqHDkwJmIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF2B2347B8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=764 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300141
X-Authority-Analysis: v=2.4 cv=HeQZjyE8 c=1 sm=1 tr=0 ts=69039a6c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vTr9H3xdAAAA:8 a=JfrnYn6hAAAA:8 a=2UGR-1-_37yoZpKuNr4A:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12124
X-Proofpoint-GUID: LI-MfO1c5y_PjCKjCNUv-_WHUvIfollg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEyNiBTYWx0ZWRfX1B+M26hDyc6R
 pvnBG3SXLHtnnZLURog4eBAowVB+rU/jisJmOcVzT64a+ws2l9jLOFPnyY8cRM2HSvW9Qopjbud
 LkXT77+doUu4whCPCMSwYCnNa+8Op2nJpSoZulMBEzsJ2CJzXSDEau9X12e8m0rlhqBYivu19HD
 OPg62u1DcsRGnLDG/a4JIy+mey8T9T0+R7oPwdgNpaNzUD99OKGaYdP8K5mNKbhS99ZrqZOkqhh
 S0cfOa67Rri1CE2+0vME+jaOAD8L/Cg+qPJD8zV46qEtd8a1oL91vzCLYflb6BzCqELu16ZMVt3
 QP+iVgAnzxXDxAl326kdS08taUFBfxVT19BbyLEOimYOrkyW94EIvRKYuI+g1PpjFvRxK860Uds
 dO8V8TfGPTo/nfpzPphTdqkMSjizRwZXo9MeEsv71xuYMwrTSQ0=
X-Proofpoint-ORIG-GUID: LI-MfO1c5y_PjCKjCNUv-_WHUvIfollg


> On Thu, Oct 30, 2025 at 3:26=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
>>
>> On Wed, Oct 29, 2025 at 11:53:32PM -0700, Fangrui Song wrote:
>> > I've been following the SFrame discussion and wanted to share some
>> > concerns about its viability for userspace adoption, based on concrete
>> > measurements and comparison with existing compact unwind
>> > implementations in LLVM.
>> >
>> > **Size overhead concerns**
>> >
>> > Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is
>> > approximately 10% larger than the combined size of .eh_frame and
>> > .eh_frame_hdr (8.06 MiB total).  This is problematic because .eh_frame
>> > cannot be eliminated - it contains essential information for restoring
>> > callee-saved registers, LSDA, and personality information needed for
>> > debugging (e.g. reading local variables in a coredump) and C++
>> > exception handling.
>> >
>> > This means adopting SFrame would result in carrying both formats, with
>> > a large net size increase.
>>
>> So the SFrame unwinder is fairly simple code, but what does an .eh_frame
>> unwinder look like? Having read most of the links in your email, there
>> seem to be references to DWARF byte code interpreters and stuff like
>> that.
>>
>> So while the format compactness is one aspect, the thing I find no
>> mention of, is the unwinder complexity.
>>
>> There have been a number of attempts to do DWARF unwinding in
>> kernel space and while I think some architecture do it, x86_64 has had
>> very bad experiences with it. At some point I think Linus just said no
>> more, no DWARF, not ever.
>>
>> So from a situation where compilers were generating bad CFI unwind
>> information, a horribly complex unwinder that could crash the kernel
>> harder than the thing it was reporting on and manual CFI annotations in
>> assembly that were never quite right, objtool and ORC were born.
>>
>> The win was many:
>>
>>  - simple robust unwinder
>>  - no manual CFI annotations that could be wrong
>>  - no reliance on compilers that would get it wrong
>>
>> and I think this is where SFrame came from. I don't think the x86_64
>> Linux kernel will ever natively adopt SFrame, ORC works really well for
>> us.
>>
>> However, we do need something to unwind userspace. And yes, personally
>> I'm in the frame-pointer camp, that's always worked well for me.
>> Distro's however don't seem to like it much, which means that every time
>> I do have to profile something userspace, I get to rebuild all the
>> relevant code with framepointers on (which is not hard, but tedious).
>>
>> Barring that, we need something for which the unwind code is simple and
>> robust -- and I *think* this has disqualified .eh_frame and full on
>> DWARF.
>>
>> And this is again where SFrame comes in -- its unwinder is simple,
>> something we can run in kernel space.
>>
>> I really don't much care for the particulars, and frame pointers work
>> for me -- but I do care about the kernel unwinder code. It had better be
>> simple and robvst.
>>
>> So if you want us to use .eh_frame, great, show us a simple and robust
>> unwinder.
>
> Hi Peter,
>
> Thanks for this perspective=E2=80=94the unwinder complexity concern is
> absolutely valid and critical for kernel use.
> To clarify my motivation: I've seen attempts to use SFrame for
> userspace adoption
> (https://fedoraproject.org/wiki/Changes/SFrameInBinaries ), and I
> believe it's not viable for that purpose given the size overhead I
> documented. My concerns are primarily about userspace adoption, not
> the kernel's internal unwinding.
>
> If SFrame is exclusively a kernel-space feature, it could be
> implemented entirely within objtool =E2=80=93 similar to how objtool --li=
nk
> --orc generates ORC info for vmlinux.o. This approach would eliminate
> the need for any modifications to assemblers and linkers, while
> allowing SFrame to evolve in any incompatible way.
>
> For userspace, we could instead modify assemblers and linkers to
> support a more compact format or an extension to .eh_frame , but it
> won't be SFrame (all of Apple=E2=80=99s compact unwind, ARM EHABI=E2=80=
=99s
> exidx/extab, and Microsoft=E2=80=99s pdata/xdata can implement C++ except=
ion
> handling , while SFrame can't, leading to a huge missed opportunity.)

The purpose of SFrame is not to be a more compact replacement for
.eh_frame.  It is intended to be used to walk stacks, not to unwind
them.
