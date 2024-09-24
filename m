Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44A155743;
	Tue, 24 Sep 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170210; cv=fail; b=tUoOD2KXpqTcXeDrHPFSRO2y8LkhjtbiL2xOmpbk7MtW5BpVKoZGQeoGNkJP6hVvtBOaZ6s85hiKEJEU8b514ag1OA0IFEuwNwKmf66JazoGrQKo446b7yzm3v5FAxWAh8H2jw8jA9M3y675nyNojm7gR+PfTVHWDOBKbpsTjzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170210; c=relaxed/simple;
	bh=quk8yn3npW5fj/ju1LAU5w9+o+oOz9tq7x311+qyBjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LD3syNR6Wggdpx+/LORQ2sNcShxzYzZR3boSMATSZ6nUzqLHV5kDtWbLFxbD8tSxBFprgJ1HuQAHrYUgAzZMlfcYpyvml5h+V2Xfd+g5hDuso8SnoS12VNz4h2oIln9prMbVCkC3r56Slh+Z58lfzkQ8eghmpFzueezFLDsNx7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cSv6VxxX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iQJJVEdG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cSv6VxxX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iQJJVEdG"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O1Mno6029506;
	Tue, 24 Sep 2024 09:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=jV+3yrpvsxyfM0stpYKwVMdD1A+a7jWJmo5lsZsiJfk=; b=
	cSv6VxxXJL8BLlggG4lRAdiUC6y6i0pjeX7ZEmy0CCBiigviqVJWOqZHe579Fp+N
	0qcnNInzs7ijfMQu1S84WTgNBqD3YoAbsklhy/U3UQoXoe8EoiiTta6yF3zX40wZ
	jTiEvd/AWpV6QoIZAQ3clQGdkKSThnTy+tTLe2xzxGfgO5f2/9R26ZJs7YdW+sfd
	vVAfufe29HWwk+aayp4vxjCqvbCAc6H9Z3EfWezYUiG7WAaOga3gIyfAHn7L1tuM
	JS6Bf8labAOzYpApB2RfrDWUpNraYMkEA1aiZL17MK5ORehavJlWfO/PL0dkhIsj
	OcO5W4Dn0iRHjpix3ZVjEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1aevvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 09:30:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48O8rwIh024933;
	Tue, 24 Sep 2024 09:29:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk8ym7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 09:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuX4lgJVSAXTRnDGRwlAiHRb7xlONYLK1tDqySNajFUOE456Dwi5HkOwdksYZTX1+4DMGr5m05AmO2x+rCHyza3VkWi+BcDNHtRHWSoCd+vwpZcEq6ui7xcT/LbwVWWGUoujxW6vzNLZe3XMgiLMOh3REnwPFLz1kGEsU95ZH2bbrgOt1qvI6939OIyfMIqn2jfHNxF3H+3XDGc2Pur769soN4DLZMmxPUiK4kFLxJzSe32K45n4dE17XyxlfzSMWkvpuLZsdm59Sat3sRy/8t6tLI3wPe9zZbmbVBsckgMoK3oZ9MWpjA82ZitZKRbPaGzyUwhWA1uuj00YKJdgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV+3yrpvsxyfM0stpYKwVMdD1A+a7jWJmo5lsZsiJfk=;
 b=J5VrGspp/TeMA6NspXUaPvaqD6btUljF+IccS3ndlZFeDIIY6gfL5Rl8CwNRYZEjV4/3PaGSvcI3QVz7eWJgQXoNxIcC1ADsW4pQnZPj5ipnTjTTtjBPNX/YAy/eIWIY4sYLUxxlBLIpLhYowfKMrskbOooRj02LggP7Pzq50PowXKHGKp0A9tWM+omd/iovyZDTV6cViLZ27ZnX968PZ3BXmR+F2qp9DnfSVKuK84M4f8SuScPjH7z7IDSvdpYYfR8rwra+GqJztGY30T+fepzJNMWcTn5Qf2fTsee+7WdG5u+iAD4SYofxgmRzikPntw1ZbXi8R97N5huCIHqtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV+3yrpvsxyfM0stpYKwVMdD1A+a7jWJmo5lsZsiJfk=;
 b=iQJJVEdGNqyQ0M6KfTixUN3yvp8m7JuX1A2xei8Nso3h1IjJUAyO/xQnGfKXwY7nYPngyDKwInAPep2jqpR/nQafxDfPx2Gs1sARKOn8mh2/p53h6rxXc8JkUog0GvvuHPEh+jJeaWS2QvMK8Xib4It/xAlD0RQSMpYnGNDGyZs=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6815.namprd10.prod.outlook.com (2603:10b6:8:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.9; Tue, 24 Sep
 2024 09:29:52 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%6]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 09:29:52 +0000
Message-ID: <9bbfe425-1f2b-4846-a5a3-a31618742e9a@oracle.com>
Date: Tue, 24 Sep 2024 10:29:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
To: Howard Chu <howardchu95@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: James Clark <james.clark@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <ZuGL9ROeTV2uXoSp@x1>
 <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org> <ZuL_0V5jgaaEUOY_@x1>
 <49fe18ff-827a-429b-9d74-9d8ed02ac409@linaro.org>
 <CA+JHD936J-q0-7LANQ3aW2G-PEmFP8PnXQ-TF-AMs9MtrCqfew@mail.gmail.com>
 <CAH0uvojUEXiT2mk1pknLS1nc-gA3Py+AjmEW22ETiCCyOLLr8Q@mail.gmail.com>
 <CAH0uvogXyYP1LqF3fbjZGHHDL6BFZ2ZKu5JAASnK_brgnymf0w@mail.gmail.com>
 <CAH0uvohEozKixjDM9_jJ5FFxYK7agsqVO-BrAsm=4hCTDQAx2A@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAH0uvohEozKixjDM9_jJ5FFxYK7agsqVO-BrAsm=4hCTDQAx2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: a1367805-646e-4a67-3307-08dcdc7b7164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDZOUWNpWWxIVi8wa2E4VDNWQWFFTWo4M3pIV1g5djVHVmRwenkraUVFRzJG?=
 =?utf-8?B?dmlCZnRmK09pbWREZjVtTDBPSDRkN3RmNis0SnFiZWhqRGJ6N0Vwc3VpUzcw?=
 =?utf-8?B?V0FqVjR4TDFwSmV2TWJ2bWNld2p2b1paWHhndk9zY2NOZldhNXpjaWRRYXdm?=
 =?utf-8?B?SnVzaUR4UUNLV0NEdkQ0V1FUT1JlVUR3b3BSdGRBTVlrNW00MXpyTjZFL1dU?=
 =?utf-8?B?cXhPMEpldnhhMmhZR0lmSHlrNWtMSlN4Y3NGREtoK21KZEQyR0tLbW1FaytD?=
 =?utf-8?B?Vk1xdC95WURLM2pZVWtjeXE2UU4yYmhXYTlBanFFenB6OXlsbTdvS1lCbkNB?=
 =?utf-8?B?Y2ZSd2Q2Vy9CRXovNFdidEZXbTF0V1JPRjZxYk9aWlkwR0FaTElvWWM2ank0?=
 =?utf-8?B?SU5Fa01YUmJxZXFwQlVvOEFvTkRteFlpSVdyZytyMzMrUWo1K2JpNFRBMSti?=
 =?utf-8?B?TmpPOWFQeCtyU3QrbzU0S0J5YlpRTmZSbGJRWVNIZ3RKNDEwQVJqbFdSTm9G?=
 =?utf-8?B?NW9QVHJNUytBYk9JL2MrY01iYjlqTG5NTmh2Qy9FbFUyd3NjTDVLSHhnRnIy?=
 =?utf-8?B?TFdiL1ExbTU1Mkk4YnVBSjI4ekQ1cFRab0dlS2lDNVB0VHFWUWdJOGhMK1Iy?=
 =?utf-8?B?eitmVDBDOHd3S2FiUXFqRys3b0wxVGFzT3BuZ3BDNVdqL3UwZ1dIbTZXdUJ0?=
 =?utf-8?B?RUpNR2tGUW5SS3cxYXhDcU9jQ2dPV1V5UDNTSVdUZjBLKy8xVHRxcHBNSEZZ?=
 =?utf-8?B?WVhKMEN0Q2Z4K2ZEQ2xaOHN2ck9RNFMxMjhSa2xJVkNNWUtkOTJLU1oreVIr?=
 =?utf-8?B?VHNpcWFvc2VFTzJocVpqa0ZBV00wRjcyVVhMcnovd3ZWTlRobCtESm5tOVlw?=
 =?utf-8?B?SEpTajlZU0ljNGNxZUNMb0NFTWVNT3piUGI0VndnNExMQjVvaWZ2d2VPNndD?=
 =?utf-8?B?OW51aS9sUHVOSVpNUlB5dUkyQmtsVnpXbHo4Tm9xQ24zNDh4WGpoU01ja2lH?=
 =?utf-8?B?ZlpsQnZobWpTbHdsVEJZZm1vSE9ZcW9SOURSTHQrNVR4UzRrSEJGZEhaYWN0?=
 =?utf-8?B?S3lESGh5MytVcGE0dEtIZnNHRW1qOEtRTVhFVFZJZ0wyUVk4UHVHQkQwVWJn?=
 =?utf-8?B?VlhmM0ZuYjdsdkFxWWdmQ1lXNS9GU25uM0pkcGhGa1BNREhTZmlIQ1NrQUZw?=
 =?utf-8?B?NHVZb1g0RlBlTFRUaHJCcGF5V2J0ZjJPZ09BR1hOb2FYblA1dmprNldyRWhp?=
 =?utf-8?B?WXhvWVk3WmdkOG5vUjh3QzFSZ2ZYeUJqOWlnblpZaVBQNUVYaHZrV1orazJx?=
 =?utf-8?B?UVdCSU42cGk0NGl6VjlUUUtuaGdPRHNkYzBoSzJyaFp2M2Yxd0xUTTlpTXNa?=
 =?utf-8?B?UklvY1l6Ulg3emxCZGViNFhYcExvQ3RYNElQOVE5T2FTUnY5ckE2c2JWMHlL?=
 =?utf-8?B?NmxzVGpPbmJMcy9lZ2syc1p3eTByVmVOejYxd1RvYUc2NkgyUldpa1FqQ3pU?=
 =?utf-8?B?KzFFMStOMEZ1OXJoZ1JFZGhGbzg1NHQ3T3gwM2NyZEVjbWsxUExwZ3JGcWxZ?=
 =?utf-8?B?bDROSE1ibXVocTBIeUpEcUU5YzZqbE1KTEFIZmRoeWFsamV3NzFwR2Rad1Zr?=
 =?utf-8?B?RThrMk54aW9yaXBqMDgzcXdTNHB3UmovMFhoMGF1djhzRnV2ejVteWNLa2Yz?=
 =?utf-8?B?bXNYSWprOEdZZDBxUGdEZUhOZXBlOUJxc2x5NWduMmd4YUJyOTdoUWFNd1hj?=
 =?utf-8?Q?T50PakTHFFRHlEAafI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDZaV2NpWUZXNzFINnRMd0F6SEpJSmZEY256RitMWFczbXBGaFk3ZmRmeDBY?=
 =?utf-8?B?eUd3dVhvV2ErRjVTRDlTS1p5bnZlanI3MW0wVk9KeHh4WVlNWTlwZkhJSHZZ?=
 =?utf-8?B?aXZseUdGVi80cUlIVndNTUJSZk54VzA1d3FNMnVGWklDVFBrNitKWWVmYUV4?=
 =?utf-8?B?dG5POGFZZ09PemFWc0YzU3dJakY4eXFEeHdJUUNOSU5uTlptUG1QRzBFb09Z?=
 =?utf-8?B?TEtpelA5TUNITDBWaUVVdHRka3dWL2YvWmJmL2hVSkpIWFMwcTNSamhXZ1hL?=
 =?utf-8?B?T21YSlkwYTVkU1o2STEzNG1RR3Y3N000NENOTHBoNGZVM01YYnp4QTd4eW0v?=
 =?utf-8?B?OHBIdFNOWTh3dG9tL3JTMkFvUjByN0xnekF3V2l5RSs3SHlJeDRieWJSeUdh?=
 =?utf-8?B?cnhSR1FoUWVRVzlVYlhyMUtESTlidHZCSXFvdXNLSU12dkxVK1RLeHozK2k1?=
 =?utf-8?B?U3pUTkhtWHZmTFBsRC8randrTkpJQ25xUFRnL2NyakM0WGZrSThvNWVOckxB?=
 =?utf-8?B?QTJGSE90elJKeHpTeUNudHVqV1ZEWldoMUt0dmM5L1FINkMzTUxHcVJ6R2xk?=
 =?utf-8?B?dUtyVGlCbkQrTzhMdEJseVJLcEJkUTVjelRmY3VqZU1ZTEJYelljSk4rNWl6?=
 =?utf-8?B?cUNxeVpaOFpyNFp0cXBvZWlyS1BYenZPNEJ3N3oxeXpWYjFCV1RHNExGWER5?=
 =?utf-8?B?SE9yQUFuRnQrTFFLUGZydFphTkRod1JYMkpZQlE2amdwaVE5N2lBejFLS2o2?=
 =?utf-8?B?b1RjWFRwTFEraWpTYndrVHhyZlFiTzYrOExqdXIyTWdpWHBHcHoxN0lpK3cx?=
 =?utf-8?B?OEJtUEliZHBXc2RwOTBRREdLVTQxQnJYTDZYeUZZNWpTNnRJdDBxWW9iSFVR?=
 =?utf-8?B?Uk15S01FcHBNWkJWbHBXUDNucHBxdXBCeDJaVSt6R2plY1VWT0kvVWR1aWNJ?=
 =?utf-8?B?QmtybVZZUkZ2UGc4ZXZUd0xSOFBtQTgyUUVGR1VlaFJiaHZWMDJSVXVDMDJv?=
 =?utf-8?B?QnJCVFE0MElOVVcvN3E0REg5SldBZkdIUlNoTGFyUitRMDhyMnlUUm9pck5P?=
 =?utf-8?B?RER1OGhZMEFMcXE1ZmpXV2NHUXVKN3did3NpWVJ5a3VrTUpnTE1XUFcvSlN3?=
 =?utf-8?B?K2hsQ1puRi9jb3ZONmhIWnF3VTFYaUxoWDR0VXpPYmFoVGp1SXBCUkZHMlMz?=
 =?utf-8?B?ZXdaUnk4c0pOVzFiTGNYMHhPZXFpWDNjc1V1emNXMUE1RFNzNCtlR3JLNzRm?=
 =?utf-8?B?RkdyUUV6V2NLcnZnbGk5eHlydG9hb2ZRTXFsUnRXbjI2OStiMFJiYnNQaEFm?=
 =?utf-8?B?a3NBd0UwYTBnbk51WXQyQXB2OUFjaXdnVFpLSE0yTHEvbEpmUUtjM0tFVjIw?=
 =?utf-8?B?VGFjN05obm5wOGx5RDYzaWRwRlRVZXMzZ1hRaUZmM0l2L0hYZlBPQ3k1dFNm?=
 =?utf-8?B?ZzgzWlJXME5WTUtKckFxSndCcEZkZjZxaGVYRWprVXF0cWtCRWVlRVE0NS9h?=
 =?utf-8?B?VDhUVXV4UFdtYUREd21QMURUTXdSS2hnNSswbzlWSzJGNjFtTGVOWjBjbE1X?=
 =?utf-8?B?UWZDRUxkUnNjblFTRmh0RHlOV1VkWW5RUVZwcGVhSVVTRzcxT1FPQjk2dlpy?=
 =?utf-8?B?VER3QmpLNlZFOFdpeTZNWmRCVVBiOHZjSjJrQ2o3cmt5YjBJalFMaG1PQ3VD?=
 =?utf-8?B?VWNCdERhVHZjR3pJR0g4ZDRKKzFxN2xZY0NQRTdIaWYxbmFvb1h6U1IycnNE?=
 =?utf-8?B?UTdJUldiM2I5b3RLU3BPTllxNGlRZ0hSdjJSa3hxRlVFazFodHdGV1FxWDhp?=
 =?utf-8?B?R3ZQS3B5UXozUGlWUVZtcWgvaDEzU2lhSGpyVkVkMG9HaEJZeE5KVld5b0U2?=
 =?utf-8?B?bVJYOFZsT3EzKzB2bHhvWm5INTBGOXNLY1VRNnpJZmFEekJIaVEzcHhkT0Q2?=
 =?utf-8?B?RkE0RU9EdWt1V3hwMStkL0dJVStUYjdsNy95aG52Q2svVW9Ib3pTRUUwUS9G?=
 =?utf-8?B?aWtQRzVmZzdKQzJCaUp0TVoxSUFCLzQ4NnV3eVUrZk83MWkxUyt1OXBlbS82?=
 =?utf-8?B?ek9iTG1SWHliQ3ZMNncwL0VXRHhQZmlXVEVWVk82QVRhaHhSTTdTeFB5TWVN?=
 =?utf-8?B?a3pKT0ttbjNaYU94dkpHYnVjQWFKTUJCVlpWWkhUNVFmcDZ3NVByNDhVSDZk?=
 =?utf-8?Q?W1n/ws+3z5oXhjKobsjqkJ4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4a24MEV4ro+nHV3xTfSaQ07b34jcj5b+YWOj5KbAq+nhC7rvPY7E7dU6qFuPBm+dMKDmOuXhUUlaOiMZYBmjfBh2oA1cXWdsFjKqZ8HYhJzUYPbd3UOYs5gmVFkdWHyFqFruW4XOqZPkIbHBsBI4QiVi4TwS46q+qgwBgQuLy0ziIHxvyNOH+o1XUsAzYmW33xef/RT+h+vSVrCT8mMgH9xEM+bTJeFRXBbjbWZBlqxa1rGUQVfisrA4eEYk+LgnJO7Lj+E/wLk+U1YzOMxykF8qdpNlRJyQerm9UAWRBN6xQf7rz9WeI3T22cL2q2wOgRD1TjmMfmw/jzi2hzKgFr9s64l/RzIEXY1L+xr17Ynv9vKvPncx8DpGy09rUw7Og3qDCnikkQn3vuq2i2TK+LjCr/nlU0g4mgnSZP3+dgrO4cHeDHrg2/f1uyVvUOM5Qle2P7N3vcjMlO0+J+RjPJt+5yHieRZBds6a01/yh/RVKQLdeWw+yG5aErHeWwK2uW01MYmUClWpcOkP8RPknCsbUHt5wtgr2RfffYCQJ+mZcKbe8sxzJCjUOVvOjzgs/lfvw7fgG2ZRxMzPz0WGMYmPEJ2hgD/gO6VTRNDM0nY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1367805-646e-4a67-3307-08dcdc7b7164
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:29:52.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYMK8mfbjUdiRgbktcAQBa9eOudYYEVuGSWYCnohVAHN2eB/eRYYlREhBcm7IxikznKgHUuO7GAQUf/eDDJQ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240066
X-Proofpoint-ORIG-GUID: yjOCPANVsccPTjyUV8uJe3VcnwpR6qj1
X-Proofpoint-GUID: yjOCPANVsccPTjyUV8uJe3VcnwpR6qj1

On 24/09/2024 03:00, Howard Chu wrote:
> Hello,
> 
> I got some good news:
> 
> Not being able to pass the BPF verifier is solely (or bi-solely)
> caused by these two functions:
> 
> SEC("tp/syscalls/sys_enter_rename")
> int sys_enter_rename(struct syscall_enter_args *args)
> 
> SEC("tp/syscalls/sys_enter_renameat2")
> int sys_enter_renameat2(struct syscall_enter_args *args)
> 
> The problem with it is double-string augmentation, but I haven't
> figured out how to solve it. Can you please take a look please,
> Arnaldo? Now I just commented these two BPF functions and perf trace
> runs no problem, built by clang that's older than clang 16, for
> example clang 15.0.7.
>

hi Howard,

I could be wrong - and I don't know this code at all - but I _think_ the
problem is here:

	oldpath_len = augmented_arg__read_str(&augmented_args->arg,
oldpath_arg, sizeof(augmented_args->arg.value));
        augmented_args->arg.size = PERF_ALIGN(oldpath_len + 1, sizeof(u64));
        len += augmented_args->arg.size;

        struct augmented_arg *arg2 = (void *)&augmented_args->arg.value
+ augmented_args->arg.size;

        newpath_len = augmented_arg__read_str(arg2, newpath_arg,
sizeof(augmented_args->arg.value));


Notice that these strings share the augmented_args->arg.value for
storage, but in the second case (reading arg2) we have added
augmented_args->arg.size to the offset where we store the second string.
However at the same time we have also told augmented_arg__read_str()
that it has

sizeof(augmented_args->arg.value)


...to work with as arg_len, where in reality we should have specified

sizeof(augmented_args->arg.value) - augmented_args->arg.size

...and ensured that after doing that subtraction, there is still space
to work with (i.e. the above is > 0).

I _think_ the verifier is likely complaining that we can write past the
end of augmented_args->arg.value , does that sound right?

Fixing the arg_len parameter for cases where we record more than one
augmented string by reducing arg_len available should solve this if so.
Hope this helps,

Alan

> perf $ clang -v
> Ubuntu clang version 15.0.7
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /bin
> Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
> Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
> Candidate multilib: .;@m64
> Selected multilib: .;@m64
> perf $ ./perf trace -e write --max-events=1
>      0.000 ( 0.008 ms): gmain/2173 write(fd: 4, buf: \1\0\0\0\0\0\0\0,
> count: 8)                         =
> 
> But plot twist, it won't build on clang-14
> 
> perf $ clang -v
> Ubuntu clang version 14.0.6
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /bin
> Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
> Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
> Candidate multilib: .;@m64
> Selected multilib: .;@m64
> perf $ ./perf trace -e write --max-events=1
> libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> 0: R1=ctx() R10=fp0
> ; int sys_enter(struct syscall_enter_args *args) @
> augmented_raw_syscalls.bpf.c:509
> 0: (bf) r7 = r1                       ; R1=ctx() R7_w=ctx()
> 
> This time the problem is my code in BTF general collector:
> 
> ; payload_offset += written; @ augmented_raw_syscalls.bpf.c:497
> 
> I'll resolve this.
> 
> Thanks,
> Howard
> 
> On Wed, Sep 18, 2024 at 8:13 PM Howard Chu <howardchu95@gmail.com> wrote:
>>
>> Hello,
>>
>> I'm able to reproduce it on Ubuntu 24.
>>
>> perf $ cat /etc/os-release
>> PRETTY_NAME="Ubuntu 24.04.1 LTS"
>> NAME="Ubuntu"
>> VERSION_ID="24.04"
>> VERSION="24.04.1 LTS (Noble Numbat)"
>> VERSION_CODENAME=noble
>> ID=ubuntu
>> ID_LIKE=debian
>> HOME_URL="https://www.ubuntu.com/"
>> SUPPORT_URL="https://help.ubuntu.com/"
>> BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
>> PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
>> UBUNTU_CODENAME=noble
>> LOGO=ubuntu-logo
>>
>> perf $ uname -r
>> 6.11.0-061100-generic
>>
>> perf $ git log
>> commit 4c1af9bf97eb56d069421c3233ce61608458d5c8 (HEAD)
>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Date:   Tue Sep 10 13:54:23 2024 -0300
>>
>>     perf trace: If a syscall arg is marked as 'const', assume it is
>> coming _from_ userspace
>>
>>
>> perf $ clang -v
>> Ubuntu clang version 15.0.7
>> Target: x86_64-pc-linux-gnu
>> Thread model: posix
>> InstalledDir: /bin
>> Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
>> Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
>> Candidate multilib: .;@m64
>> Selected multilib: .;@m64
>>
>> perf $ ./perf trace -e write --max-events=1
>> libbpf: prog 'sys_enter_rename': BPF program load failed: Permission denied
>> libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
>> 0: R1=ctx() R10=fp0
>> ; int sys_enter_rename(struct syscall_enter_args *args) @
>> augmented_raw_syscalls.bpf.c:275
>>
>>
>> With clang-16:
>>
>> perf $ clang -v
>> Ubuntu clang version 16.0.6 (23ubuntu4)
>> Target: x86_64-pc-linux-gnu
>> Thread model: posix
>> InstalledDir: /bin
>> Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
>> Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
>> Candidate multilib: .;@m64
>> Selected multilib: .;@m64
>>
>> perf $ ./perf trace -e write --max-events=1
>>      0.000 ( 0.021 ms): sudo/4741 write(fd: 8, buf:
>> \27[?25l\27[37m\27[48;5;96m\27[H[trace] , count: 205) =
>>
>>> I'll try to build it and see. But Ubuntu 22 only has clang 11 to 15 so
>>> making 16 the minimum could be an issue.
>>
>> Yes, I think disabling any distro that doesn't come with clang 16
>> (released in 2023) is not a good idea. I'll try to tame the BPF
>> verifier.
>>
>> Thanks,
>> Howard
>>
>> On Tue, Sep 17, 2024 at 10:37 AM Howard Chu <howardchu95@gmail.com> wrote:
>>>
>>> Hello James and Arnaldo,
>>>
>>> On Fri, Sep 13, 2024 at 3:42 AM Arnaldo Carvalho de Melo
>>> <arnaldo.melo@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On Fri, Sep 13, 2024, 7:20 AM James Clark <james.clark@linaro.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 12/09/2024 15:50, Arnaldo Carvalho de Melo wrote:
>>>>>> On Thu, Sep 12, 2024 at 03:40:32PM +0100, James Clark wrote:
>>>>>>> On 11/09/2024 13:24, Arnaldo Carvalho de Melo wrote:
>>>>>>>> Howard reported problems using perf features that use BPF:
>>>>>>
>>>>>>>>     perf $ clang -v
>>>>>>>>     Debian clang version 15.0.6
>>>>>>>>     Target: x86_64-pc-linux-gnu
>>>>>>>>     Thread model: posix
>>>>>>>>     InstalledDir: /bin
>>>>>>>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>>>>>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>>>>>>     Candidate multilib: .;@m64
>>>>>>>>     Selected multilib: .;@m64
>>>>>>>>     perf $ ./perf trace -e write --max-events=1
>>>>>>>>     libbpf: prog 'sys_enter_rename': BPF program load failed: Permission denied
>>>>>>>>     libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
>>>>>>>>     0: R1=ctx() R10=fp0
>>>>>>>>
>>>>>>>> But it works with:
>>>>>>>>
>>>>>>>>     perf $ clang -v
>>>>>>>>     Debian clang version 16.0.6 (15~deb12u1)
>>>>>>>>     Target: x86_64-pc-linux-gnu
>>>>>>>>     Thread model: posix
>>>>>>>>     InstalledDir: /bin
>>>>>>>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>>>>>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>>>>>>     Candidate multilib: .;@m64
>>>>>>>>     Selected multilib: .;@m64
>>>>>>>>     perf $ ./perf trace -e write --max-events=1
>>>>>>>>          0.000 ( 0.009 ms): gmain/1448 write(fd: 4, buf: \1\0\0\0\0\0\0\0, count: 8)                         = 8 (kworker/0:0-eve)
>>>>>>>>     perf $
>>>>>>>>
>>>>>>>> So lets make that the required version, if you happen to have a slightly
>>>>>>>> older version where this work, please report so that we can adjust the
>>>>>>>> minimum required version.
>>>>>>
>>>>>>> I wasn't able to reproduce the issue with either of these versions. But I
>>>>>>> suppose it could be an issue with only 15.0.6.
>>>>>>
>>>>>> Interesting, that complicates things, probably the best way then is to
>>>>>> try to build it, if it fails, mention that 15.0.6 is known to be
>>>>>> problematic and suggest working versions?
>>>>>>
>>>>>> - Arnaldo
>>>>>
>>>>> I still wasn't able to reproduce it with 15.0.6. And I double checked
>>>>> with V=1 that the build was using the right clang. I suppose it could be
>>>>> a build configuration issue, or maybe with a different kernel version?
>>>>
>>>>
>>>> Howard? If not reproducible we can revert it.
>>>>
>>>> - Arnaldo
>>>>
>>>>
>>>>>
>>>>> $  uname --kernel-release
>>>>> 6.8.0-76060800daily20240311-generic
>>>>>
>>>>> $ ../../llvm-project/build/bin/clang -v
>>>>> clang version 15.0.6 (https://github.com/llvm/llvm-project.git
>>>>> 088f33605d8a61ff519c580a71b1dd57d16a03f8)
>>>>> Target: x86_64-unknown-linux-gnu
>>>>> Thread model: posix
>>>>> InstalledDir: /home/james/workspace/linux/linux/../../llvm-project/build/bin
>>>>> Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/11
>>>>> Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/12
>>>>> Selected GCC installation: /usr/lib/gcc/x86_64-linux-gnu/12
>>>>> Candidate multilib: .;@m64
>>>>> Selected multilib: .;@m64
>>>>>
>>>>> $ git log
>>>>> commit 003265bb6f028d7bcd7cbd92d6ba2b4e26382796
>>>>> (perf-tools-next/perf-tools-next)
>>>>>
>>>>> $ make O=../build/local/ CLANG=../../llvm-project/build/bin/clang -C \
>>>>>    tools/perf
>>>>>
>>>>> $ perf trace -e write --max-events=1
>>>>>
>>>>>       0.000 ( 0.026 ms): gnome-shell/5454 write(fd: 5, buf:
>>>>>         0x7fffa102d9b0, count: 8)                           = 8
>>>
>>> Thanks for the effort! But this output seems to be unaugmented? I
>>> think you are testing the perf/perf-tools-next branch that's slightly
>>> older (perf mem: Fix the wrong reference in parse_record_events()
>>> 003265bb6f028d7bcd7cbd92d6ba2b4e26382796), and I think that doesn't
>>> have the new perf trace feature yet...
>>>
>>> That's why the perf trace output looks like:
>>>
>>>>> $ perf trace -e write --max-events=1
>>>>>
>>>>>       0.000 ( 0.026 ms): gnome-shell/5454 write(fd: 5, buf:
>>>>>         0x7fffa102d9b0, count: 8)
>>>
>>> With the new buffer augmentation it should look like this:
>>>
>>> perf $ ./perf trace -e write --max-events=1
>>>      0.000 ( 0.011 ms): gmain/1408 write(fd: 4, buf: \1\0\0\0\0\0\0\0,
>>> count: 8)                         =
>>>
>>> The new perf trace can be found on
>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/
>>> perf-tools-next
>>>
>>> perf $ git log
>>> commit 1de5b5dcb8353f36581c963df2d359a5f151a0be (HEAD ->
>>> struct-aug-arnaldo-2, perf/perf-tools-next)
>>>
>>> Also, if you want to test the clang, you may want to checkout to the
>>> commit before the clang-16 guard (otherwise you can't test different
>>> clang version).
>>>
>>> perf $ git log --oneline
>>> 1de5b5dcb835 (HEAD -> struct-aug-arnaldo-2, perf/perf-tools-next) perf
>>> trace: Mark the 'head' arg in the set_robust_list syscall as coming
>>> from user space
>>> 0c1019e3463b perf trace: Mark the 'rseq' arg in the rseq syscall as
>>> coming from user space
>>> edf3ce0ed38e perf env: Find correct branch counter info on hybrid
>>> 9953807c9e01 perf evlist: Print hint for group
>>> eb9b9a6f5ab3 tools: Drop nonsensical -O6
>>> 89c0a55e550e perf pmu: To info add event_type_desc
>>> f08cc258431d perf evsel: Add accessor for tool_event
>>> 925320737ae2 perf pmus: Fake PMU clean up
>>> d3d5c1a00fcd perf list: Avoid potential out of bounds memory read
>>> 4ae354d73a8e perf help: Fix a typo ("bellow")
>>> 74298dd8acb8 perf ftrace: Detect whether ftrace is enabled on system
>>> 83420d5f5863 perf test shell probe_vfs_getname: Remove extraneous '='
>>> from probe line number regex
>>> 9327f0ecad48 perf build: Require at least clang 16.0.6 to build BPF
>>> skeletons. **********[[[[[[[[[[[[!!!!(This is the clang
>>> guard)]]]]]]]]]]*****
>>> 4c1af9bf97eb perf trace: If a syscall arg is marked as 'const', assume
>>> it is coming _from_ userspace
>>> e37b315c17df perf parse-events: Remove duplicated include in parse-events.c
>>>
>>> My machine is debian 12, and I cannot build perf trace with the new
>>> augmentation feature on clang-13, clang-14, and clang-15.
>>>
>>> perf $ uname -r
>>> 6.11.0-061100rc7-generic
>>>
>>> perf $ git log
>>> commit 4c1af9bf97eb56d069421c3233ce61608458d5c8 (HEAD)
>>>
>>> perf $ make CLANG=/bin/clang-13 && ./perf trace -e write --max-events=1
>>> ...
>>> libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
>>> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>>> 0: R1=ctx() R10=fp0
>>> ; int sys_enter(struct syscall_enter_args *args) @
>>> augmented_raw_syscalls.bpf.c:509
>>> 0: (bf) r7 = r1                       ; R1=ctx() R7_w=ctx()
>>>
>>>
>>> perf $ make CLANG=/bin/clang-14 && ./perf trace -e write --max-events=1
>>> ...
>>> libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
>>> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>>> 0: R1=ctx() R10=fp0
>>> ; int sys_enter(struct syscall_enter_args *args) @
>>> augmented_raw_syscalls.bpf.c:509
>>>
>>>
>>> perf $ make CLANG=/bin/clang-15 && ./perf trace -e write --max-events=1
>>> libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
>>> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>>> 0: R1=ctx() R10=fp0
>>>
>>>
>>> perf $ make CLANG=/bin/clang-16 && ./perf trace -e write --max-events=1
>>>      0.000 ( 0.010 ms): gmain/1408 write(fd: 4, buf: \1\0\0\0\0\0\0\0,
>>> count: 8)                         =
>>>
>>>
>>> Anyway thank you so much, I'll try to reproduce it on Ubuntu, like you
>>> mentioned.
>>>
>>> Thanks,
>>> Howard
>>>
>>>
>>>>>

