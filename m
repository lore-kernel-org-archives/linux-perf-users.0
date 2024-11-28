Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976539463;
	Thu, 28 Nov 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732826873; cv=fail; b=IV/je8MkPCghnlekdHQ/nMtqaVP2Z8q4hJcTZro/tB1CNSDeZnaG2GpKqABJgYdtmeFq7u4PBV3E9il0VgrStMMoe8VYX6HrtAu4ZyTDFUFgMjQukaGLeoRU80rU7RT7dRSnPvMQnTyYxlK3j8XwUvDGp8wGmfNC38RRMYGVLkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732826873; c=relaxed/simple;
	bh=9bNjXvhmTIlvWH/uwyqFNGX2OzNoyQY8M/hvbgdq/+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CvkoXcEJzbWuU7U5s9gGljGhHxQsRoT1V1LuOxgqlEodSpLR6fHX9bINKV38p9DDH2nJ413itOlqoXwfZqNmGwP3AeOR2rmKa/fPYiMlPhXYuIXn4eqo76DyH11/StXJOS/oGe5RZeyURnx56csVyA3tuhOMXx60rGJN58Tlmxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N3vPsZKR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H3xUaxfy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N3vPsZKR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H3xUaxfy"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASECCMW024792;
	Thu, 28 Nov 2024 20:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ELBMFDaNcBuda+0ZU2
	uGtaQ6jhqKH5kCd8AiZiXvT4E=; b=N3vPsZKRPIXZYwcUzggHHVAWkmqp/u6klz
	H66DuIcxsLyufo0cp23srDjvIYdTxvHuSIjnEkEBC5hndV3oN1gt3V5WSDkyka7T
	8FBvp+LtOhJRM2+9EDghLqkjIsZESkLIwiGhgxgGdTS11Bd4Y+C8syyxZP6aE9Vv
	cpP15r5P1YLcSrsGxYs551gBZlsMz/6GUGN2Bs+4Jo1CWYwNcUVICxT6uSJxl8Vq
	1yOSQoMAelIUrfCATE6uBbFgzyiZBAywtFtKeujWN0ToZ3ZP53NjS7wPsU7L/LfG
	P+wn7btaDtzE8sh5Pbr0HpmmZ81lf+pQc+T7+/CLvs3/bULZruFg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xy2bbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 20:47:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASKjWlO014338;
	Thu, 28 Nov 2024 20:47:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4366yyy273-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 20:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXymRB7JhAiIrPYBDQZ2iYQ6FO/SfCrQK8BTRcn4GFPqujBEh/3rEVZOd/GjcqANoiC9p2J1Qg3W79kSMAsrgfDT0jFz+MeY15KQYUH177hhks1wgNl5FPejgQsRdVXtXkhb0bpvcomwZUYiy6g4PEk1/md/SsgrNbso5DCZP8gbbtyySw2dDIhIwdoR4F8yIGWYQEXFiEsPg6ae8JsRSi+MSu6f7DozAQ91SIrts2QsrP8CvZneMMkL4egLBPUJ2dQb6uv1aWX0Yv37FGYEnWXLxx/0Q5nDyJFuXjadi2bYWDKq/bX6TpBnzWvx6NynVENCXkSDM5XVgt9l+0ia5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELBMFDaNcBuda+0ZU2uGtaQ6jhqKH5kCd8AiZiXvT4E=;
 b=BUgG9K4WY8n2v5P3T0i7hCrlLJOB6A/R0TSBgugGsojXXxGxkmC6WLK8cQI7OfZLeg8RXLQhguvxx2C+3uIq4ZJNr1oLDD0njETEnwfEWdaoRSjHFOSZ0R5GsAtVn7fqmabRUHLQ0PITEXKUoX5kswbEkIjFp5OhyFpUGkWXw9Idud9rwx4GePtT29u5lLYM2Yeuqdbln0G5gE6oyvHwMSq3Oek0OuitDfRYCCe1/kVWgAzEtnXdU2S8rEouMLmzbZ0Su9gsSpXzJAeIwz8EjKWwitfHvk8tz237wiNDDyXZaoHG6HPWCD91ZxQBpqv7a9fVTpNrmURmwQIBNHfz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELBMFDaNcBuda+0ZU2uGtaQ6jhqKH5kCd8AiZiXvT4E=;
 b=H3xUaxfygx5uggPiyWl+WNmQcePmgWHVSnhiCnu118ixJ0Z94Q/xC77vqkB2VCgqLZEPWL6WxGZr5Bi5jKMoelmiaGdJhnDY83uxIi9VOqo3vZnv5tt6MVPvx6pVP0AYN5oGdyhPlSipaA9+nAsXhfDfcEsw3wBCRf1bTF8ImdY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6685.namprd10.prod.outlook.com (2603:10b6:208:41b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 20:47:31 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 20:47:31 +0000
Date: Thu, 28 Nov 2024 20:47:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] perf: map pages in advance
Message-ID: <2550a3c6-b0d9-4ad2-ae04-5735d7b4cf5f@lucifer.local>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0686.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c24a4f2-458e-406d-233f-08dd0fede0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XQ93EY7+k2VxQEvjMAwNmtoiimVuVuIYAql8JWGEfl0Za/hCpKQS07sJHgV9?=
 =?us-ascii?Q?tITDy5X21hmC++yHJ3gMP0huGHjlsp2SbabQRQkNpgBe1SVl1k1BjrLK6Dlu?=
 =?us-ascii?Q?o2GUMyz5B5wpAFIDXbEX41VD55+riE2ulkI1VCtJkt2hIg90vnz0pPZb8JeZ?=
 =?us-ascii?Q?vdRR3cfnWb481qEiEMw3P+RSNxborqEYtulyR7Q4OKAsMuLdWc6yjAA4oUDc?=
 =?us-ascii?Q?sW+inI3LsjmgPQHXvUu03IQII1KQqXQRlGaHvOenq90iCzHXVk9PEZCyv8k3?=
 =?us-ascii?Q?yHPaboUcDgB/MS+C+GnWVw4/akxm8usA86b1bo0cPWau1C80ju00obWNyjUN?=
 =?us-ascii?Q?03rtdF62rJrzrloEyhzJ8SzkRoSSOZ5kTkTAvolJAuHXaMwy+Va8VEbwiPbW?=
 =?us-ascii?Q?c+hAzOlVGGid9jJYHQUlzjkEFtavNA+fi1rcTeSWNNaoOGkFobp+yz8cDFLo?=
 =?us-ascii?Q?SQJLFTsx4q8r7ALj5Js9m1kyLdlFAdTCEU9yx53sJNbTcXKypswv+EtQZddc?=
 =?us-ascii?Q?k9lT3QL6rQwoYrOAlGrUVhqNgohvIquiTo2M6qr9wmqiuh+8CzJyuSeK2VCm?=
 =?us-ascii?Q?4Phbkc0O4W0qwWYqufyB9M0sUMfWuZspGxPzaf1KFUGleDjTyf6T6SA+osZ9?=
 =?us-ascii?Q?B1U/siC/+KlNf7iuaF01LYRUYdtnh2+ugeBGvLErYXRRQKJp9trB3n3VtVB2?=
 =?us-ascii?Q?zJFtliz+WC2hRD1QxURi7ku30jp/71EMb2qrH9v+1NWhfeHw3KiusfffFmDm?=
 =?us-ascii?Q?tZ/j3yo4mYKlfC4ZGpgf3fQ88aLcAhTOQvRolR/YcuwzJOtTkUX40TSw2rF4?=
 =?us-ascii?Q?9A8GYCxHeI5fnUJnCXe6lOqTsXTBISfNQXHGovADqFrcTlHUDf7f83kUneYb?=
 =?us-ascii?Q?OkRLafjxv7dSvtl3MfCc27o3InqKlOzQwDOGs+kuWuQ0VjIl42gZ3/ap4051?=
 =?us-ascii?Q?O8WvuCIJoaJX7543T679v9K7CwZVW4lhKulX6aWJzj3HzICVETXDs+ZwX6Xl?=
 =?us-ascii?Q?DaZ6PQ/dq+Eb2Lrh3jS1QTLETFHcyql2XhWDTTSbxuq8TYc66ujaYB7WutVc?=
 =?us-ascii?Q?dpp2Zeulf0r5xxw8VVNEXtsu4YL0c2QjC0VwsWx+UjO7IRrm9UcSAV7VK6m8?=
 =?us-ascii?Q?SqZAhOoFibJ4i8wBE/Lo56iPBrNtxBo05kq2l8iLNgiR7xECcLLy2lIlYAES?=
 =?us-ascii?Q?WO+Th826IPaYfcaDAIeiY5sPs1WrGq4gfiMCgxDZrjAo9ZT7oTvLBZYuy4oG?=
 =?us-ascii?Q?Cb8nb9Jiy8hsTy58AmP8cdZGxAyvRY1Ibt+4uRlXV6O4FxGu5wgzhq5C+d/V?=
 =?us-ascii?Q?T+NGyX7x8eOV6CQ7K2KUHjXGaPLoiSv7hE3SHMGouXMCKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I8zkbNwQUe9r5qbBX+/xQHNqYwG2KRzvmCXjvbl7DbWr1BVy7dVCdTfpDPsD?=
 =?us-ascii?Q?G9gTYc9ZQ4DuTqxWxVs5ean1QfwZ1mMD13oNG7dN49H1LDZv3jsjQjYarhW9?=
 =?us-ascii?Q?itq/7Piqwde6aPFHFkKwDQm2LBAbB2U/FjaQES35F+YXjNiFT5ej+5dxwLsi?=
 =?us-ascii?Q?qpp+egsThMkDBY9U9I71NXS7CsaPzuRCdGih75BopHROG230lEeVVCBS7VFo?=
 =?us-ascii?Q?rH5btU9QTjF2hA3G2z4tG+pWH7HInGlIfDFXRJwrx6a8ApmK1ZUWN08vCVlj?=
 =?us-ascii?Q?DhrxEn1Be8G3+epA2Gm4D+BDTfTYatmL2AxPirkLs4ULp6fGlwmpK/fFIgbo?=
 =?us-ascii?Q?dRf9z978gBZ7uISFMnwTLhd/eXNX/6MH3Y2lWyiqGgk/E99ROad4omOb0+vL?=
 =?us-ascii?Q?tfVUHOBjzX4k4ULjpqKH5El7LYPXwvqGz2U8xqJdCWzE88J0dJ+8xJxhuyve?=
 =?us-ascii?Q?Q1PbZOaDTaTKQ5QJACfVhaeFDgui/9H49zjVJkVXtvuN5oIn+kfRN95f7pnq?=
 =?us-ascii?Q?wqXIr6+LfzbwgUodNY3rHL5OVkaoIQ3Ix4IyjkbTSEh7bybVWExzEGCmHLuN?=
 =?us-ascii?Q?v7rliUsbbjvjBOsfhBuOBozMB9n4py0SR3Egjf6nVAmME73q4UEHb6SugJ6B?=
 =?us-ascii?Q?gZsSj/lIWOIJ5ZiKpnOWCbfGBnSH8pzr2YaMJr/WkahXEOlP1BlPIxlSZOMM?=
 =?us-ascii?Q?rBAayX2VQfkuRCgcTv/QrvtMBKGC56YWCENdEWVYSYAG4foCCKS6QDQSNUQC?=
 =?us-ascii?Q?u5SetLF4cWiJTJ8cKnIqWb5KWoyHnjAiJnjsYw7QUvl1Xh/e/S/RqNID0nfk?=
 =?us-ascii?Q?ASsDMLkar/+26RY7szDARssj2pNXtsHgEfgtLyJoXtmrUlcsfsHSVtMbWOAJ?=
 =?us-ascii?Q?nAtQ3EBLQatG7HFSYnq+Dpx8+rzI15zsUkzKcLf2WnSLf2YLhDSHtyLCKbiT?=
 =?us-ascii?Q?n1aAPdZa0/5nv9vyCF2U64PEWb4DEuDbpr+2ms8Z2tkaipAocjCp3DgKUdXE?=
 =?us-ascii?Q?KhChINIEOqclMLsI80cbmXefnYK91ZmuW8jYBM9KI7lrsR7nZwBU3FPU4CHj?=
 =?us-ascii?Q?F+athWZo9QkMB7jKKgczLqkuWTiauU9NCyXMYKYDz2ed6H1n6FDcZzQzD3ZN?=
 =?us-ascii?Q?4ZgjLmp34lOOydJiZ/AA5726RUO0EvC/dVU6dmkLpi96jAQDshGAT17pmANl?=
 =?us-ascii?Q?k6Nj243T+I0AbTnIF0F65rxuGUB91SO6bLsgwdyudN67uGW0QdttM/cxh8//?=
 =?us-ascii?Q?RE95PdTskF9cHG4st2k4fi5dR9g6ELuC9BzW2h7IwuUsJN15D/6QrZaiBiKC?=
 =?us-ascii?Q?wFIv38e+DtHuFIo87zgjlwql/6H5J4tMMIhJ1yfup/7P/jIzdtPpWN0ZTFNj?=
 =?us-ascii?Q?bjsMRAs/1lsRz8bCfKumNurY1RsrxCQnj53j4nkmCGwzPRMKpeaA5I4bHNbc?=
 =?us-ascii?Q?Of0s6+M1IDQbSlsgsZI67j8ndImhJ8RIffb3cywcBcEU40X07D3XUtrFQ2nq?=
 =?us-ascii?Q?3xpR7xGK6PoTaNCAUlUJ5ope2ev3U1hH0Vfnx5ackYvkJUrTS1quWWoHHBBf?=
 =?us-ascii?Q?Brg5DN7s4Vx3ZQ/EZq/Vhw+RN5EiSjpgfJk3C9KE1o5/U5rHjOdtiQ57el/0?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F+kv4hhiBOfDHe2XO30YsOepWN0Xc3m6pAn/3FOBUH4+6yqZHwAJ2eSmg3X8DfSiOaVoYjrZHXU/MbjoS2wPENjDlW9GGLbf+AgM0PItH4/tBDBBjmJ0Tjz7gE7PnMMVchoFQyAGryg6rcBIIU4mVChmSiC7njrHGD9XRDvDYBooHBDootdC2+Rf9bX1r7n3ViAhgUGao1fsQm82SLXAotYA9ZEoAPkaAyVrPYCSFD2hw77qqg59q5S5nY0yS+LS3pT3WrQFA5us+DIMl3b6sSK8BJM+z6rEQrAv/L7FOk3fnYefB9E5LE7ELNLZYp9nviOFXb6tsQYJ3cfhFXNeeYB7R992c3yS2MvkVWeXLje7IOjhERSxivaVmA38dFOdiCMCR27PxiA/1F83kCqxqpuofpdBJYaESKhnFNoX/du+k0msoCHAiSGVgGgyipED+sNBuEUYFiL51c9L47X/wCVQHkJWZ9ud0vy9E5LlXUX7e4uCpdL0LGzHLAzKVGK4LFC5Gm1zsVzORhaz11j55iZ6Bg5+HDXoWfMEUKykjh56qsybqmYCEwWaGzB2YDu61Ql5LBulkdxqB/hv/4djhqOwtN0vXadMhoiNqSgPUyY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c24a4f2-458e-406d-233f-08dd0fede0b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 20:47:31.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt0r5WuXjCbK3llro+fTea4t5D9gpG6HPN06OEkRv7p5nfNK2kQ+skzdz/zZMZHEJCw65e17Fntpb8ZF+DotRoiv/UwyQEDu4YMv9ySzCoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_19,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280165
X-Proofpoint-GUID: b7Sx_54uiHC47aqKWxmrg-F7C4pBLs0E
X-Proofpoint-ORIG-GUID: b7Sx_54uiHC47aqKWxmrg-F7C4pBLs0E

Peter - not sure whether it's easy for you to make a simple adjustment to this
patch or if you want me to just send a v2, but I have to pop an #ifdef CONFIG_MMU
into the code.

I've indicated inline below where it's needed, but if it's a pain/not
possible for you to do a fixup in your tree I'm happy to just respin, let
me know what works for you.

Sorry about that!

On Thu, Nov 28, 2024 at 11:37:14AM +0000, Lorenzo Stoakes wrote:
> We are current refactoring struct page to make it smaller, removing
> unneeded fields that correctly belong to struct folio.
>
> Two of those fields are page->index and page->mapping. Perf is currently
> making use of both of these, so this patch removes this usage as it turns
> out it is unnecessary.
>
> Perf establishes its own internally controlled memory-mapped pages using
> vm_ops hooks. The first page in the mapping is the read/write user control
> page, and the rest of the mapping consists of read-only pages.
>
> The VMA is backed by kernel memory either from the buddy allocator or
> vmalloc depending on configuration. It is intended to be mapped read/write,
> but because it has a page_mkwrite() hook, vma_wants_writenotify() indicaets
> that it should be mapped read-only.
>
> When a write fault occurs, the provided page_mkwrite() hook,
> perf_mmap_fault() (doing double duty handing faults as well) uses the
> vmf->pgoff field to determine if this is the first page, allowing for the
> desired read/write first page, read-only rest mapping.
>
> For this to work the implementation has to carefully work around faulting
> logic. When a page is write-faulted, the fault() hook is called first, then
> its page_mkwrite() hook is called (to allow for dirty tracking in file
> systems).
>
> On fault we set the folio's mapping in perf_mmap_fault(), this is because
> when do_page_mkwrite() is subsequently invoked, it treats a missing mapping
> as an indicator that the fault should be retried.
>
> We also set the folio's index so, given the folio is being treated as faux
> user memory, it correctly references its offset within the VMA.
>
> This explains why the mapping and index fields are used - but it's not
> necessary.
>
> We preallocate pages when perf_mmap() is called for the first time via
> rb_alloc(), and further allocate auxiliary pages via rb_aux_alloc() as
> needed if the mapping requires it.
>
> This allocation is done in the f_ops->mmap() hook provided in perf_mmap(),
> and so we can instead simply map all the memory right away here - there's
> no point in handling (read) page faults when we don't demand page nor need
> to be notified about them (perf does not).
>
> This patch therefore changes this logic to map everything when the mmap()
> hook is called, establishing a PFN map. It implements vm_ops->pfn_mkwrite()
> to provide the required read/write vs. read-only behaviour, which does not
> require the previously implemented workarounds.
>
> It makes sense semantically to establish a PFN map too - we are managing
> the pages internally and so it is appropriate to mark this as a special
> mapping.
>
> There should be no change to actual functionality as a result of this
> change.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  kernel/events/core.c        | 76 +++++++++++++++++++------------------
>  kernel/events/ring_buffer.c | 19 +---------
>  2 files changed, 40 insertions(+), 55 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5d4a54f50826..0754b070497f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6284,41 +6284,6 @@ void perf_event_update_userpage(struct perf_event *event)
>  }
>  EXPORT_SYMBOL_GPL(perf_event_update_userpage);
>
> -static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
> -{
> -	struct perf_event *event = vmf->vma->vm_file->private_data;
> -	struct perf_buffer *rb;
> -	vm_fault_t ret = VM_FAULT_SIGBUS;
> -
> -	if (vmf->flags & FAULT_FLAG_MKWRITE) {
> -		if (vmf->pgoff == 0)
> -			ret = 0;
> -		return ret;
> -	}
> -
> -	rcu_read_lock();
> -	rb = rcu_dereference(event->rb);
> -	if (!rb)
> -		goto unlock;
> -
> -	if (vmf->pgoff && (vmf->flags & FAULT_FLAG_WRITE))
> -		goto unlock;
> -
> -	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
> -	if (!vmf->page)
> -		goto unlock;
> -
> -	get_page(vmf->page);
> -	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
> -	vmf->page->index   = vmf->pgoff;
> -
> -	ret = 0;
> -unlock:
> -	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
>  static void ring_buffer_attach(struct perf_event *event,
>  			       struct perf_buffer *rb)
>  {
> @@ -6558,13 +6523,47 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>  	ring_buffer_put(rb); /* could be last */
>  }
>
> +static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
> +{
> +	/* The first page is the user control page, others are read-only. */
> +	return vmf->pgoff == 0 ? 0 : VM_FAULT_SIGBUS;
> +}
> +
>  static const struct vm_operations_struct perf_mmap_vmops = {
>  	.open		= perf_mmap_open,
>  	.close		= perf_mmap_close, /* non mergeable */
> -	.fault		= perf_mmap_fault,
> -	.page_mkwrite	= perf_mmap_fault,
> +	.pfn_mkwrite	= perf_mmap_pfn_mkwrite,
>  };
>
> +static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
> +{
> +	unsigned long nr_pages = vma_pages(vma);
> +	int err = 0;
> +	unsigned long pgoff;
> +
> +	for (pgoff = 0; pgoff < nr_pages; pgoff++) {
> +		unsigned long va = vma->vm_start + PAGE_SIZE * pgoff;
> +		struct page *page = perf_mmap_to_page(rb, pgoff);
> +
> +		if (page == NULL) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		/* Map readonly, perf_mmap_pfn_mkwrite() called on write fault. */
> +		err = remap_pfn_range(vma, va, page_to_pfn(page), PAGE_SIZE,
> +				      vm_get_page_prot(vma->vm_flags & ~VM_SHARED));
> +		if (err)
> +			break;
> +	}
> +

Need a:

#ifdef CONFIG_MMU
> +	/* Clear any partial mappings on error. */
> +	if (err)
> +		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE, NULL);
#endif

Here to work around the wonders of nommu :)

> +
> +	return err;
> +}
> +
>  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = file->private_data;
> @@ -6783,6 +6782,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
>  	vma->vm_ops = &perf_mmap_vmops;
>
> +	if (!ret)
> +		ret = map_range(rb, vma);
> +
>  	if (event->pmu->event_mapped)
>  		event->pmu->event_mapped(event, vma->vm_mm);
>
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 4f46f688d0d4..180509132d4b 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -643,7 +643,6 @@ static void rb_free_aux_page(struct perf_buffer *rb, int idx)
>  	struct page *page = virt_to_page(rb->aux_pages[idx]);
>
>  	ClearPagePrivate(page);
> -	page->mapping = NULL;
>  	__free_page(page);
>  }
>
> @@ -819,7 +818,6 @@ static void perf_mmap_free_page(void *addr)
>  {
>  	struct page *page = virt_to_page(addr);
>
> -	page->mapping = NULL;
>  	__free_page(page);
>  }
>
> @@ -890,28 +888,13 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
>  	return vmalloc_to_page((void *)rb->user_page + pgoff * PAGE_SIZE);
>  }
>
> -static void perf_mmap_unmark_page(void *addr)
> -{
> -	struct page *page = vmalloc_to_page(addr);
> -
> -	page->mapping = NULL;
> -}
> -
>  static void rb_free_work(struct work_struct *work)
>  {
>  	struct perf_buffer *rb;
> -	void *base;
> -	int i, nr;
>
>  	rb = container_of(work, struct perf_buffer, work);
> -	nr = data_page_nr(rb);
> -
> -	base = rb->user_page;
> -	/* The '<=' counts in the user page. */
> -	for (i = 0; i <= nr; i++)
> -		perf_mmap_unmark_page(base + (i * PAGE_SIZE));
>
> -	vfree(base);
> +	vfree(rb->user_page);
>  	kfree(rb);
>  }
>
> --
> 2.47.0
>
