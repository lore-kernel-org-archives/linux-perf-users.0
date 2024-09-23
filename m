Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA425634;
	Mon, 23 Sep 2024 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113696; cv=fail; b=iTThDSuVpmC6Oeyfy+4EPhdyR9LALG+/Ed13gNHFzutONxI60qTurdwglBd7xnJ9FrwM13e5gjVSsFx4gUv4FkEM2bB7X5htW9IpBEIvFPrNQREwuEI/VAnXcmLDbgM7dTpiJ6+mFwd762xjRSofkih0HzTrehoYCAnbW+HlWoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113696; c=relaxed/simple;
	bh=Crq+Epj+RuWEBiWdFN7hY7PyY7cXdBGdgjcoVyuq5Dw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDg3pdgnu5Zhf5RBHBBSrQ34epWsw597lDkvgJ+CV7GBPDBp/coAP1Z90JT0CzflDoF9xavVxsJc3rN5CxKmS5kCzDL8TVCfOcA9Tre1WqajdKfxMm8jA1LCqSPbfSwf1QC4UiHjrvRuVamJXuco3juXW7RQPr5Fq5sPr3VtzdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ze/unlxB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gy/EZHp5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ze/unlxB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gy/EZHp5"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NHXVGK015841;
	Mon, 23 Sep 2024 17:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=NOxlgGzsoiJYrPulqOQ0qUK4i0kcoNK4WcP9L30xjy4=; b=
	Ze/unlxBbFT7rmpTEp9JoHj0nWOmRleHwDj8/V2McIErvhzUtRaEGeOetVtxWuQo
	mKt/9n3X0E9UdRgG5N69j0Aa9FVlBVKvz7MzSBNU+3bYCbj58w3JoL8mcmUlGat4
	/w5NKxVRPWZgjJWDRIhLHIISMMXbr82LzdRd9nioIkSHhIH2+3+OCf+TrkHyDThS
	px1itoETEFe/xCfI3gYuE/UA07NXJTWIFlaBNwj8rRM8pxYXMrpKRztSr3/8O68L
	dRPPrvEzPRsz7hYBE6f6ck8nnxINkoIEcIzrEDjgW52JviOGszHw07V3KeCtQpNN
	gGRVQAFqDshNXPofThiIBg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6caygr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 17:48:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NHRhl7040950;
	Mon, 23 Sep 2024 17:48:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk7ut42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 17:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQk4ygI/kpYOywiFA9gARLdhLRzDHzOSNxrBuw83rx75eKvG0yzzNAILscTEjSEl/Z5UK3XW4MmQHtpR0qVVWGtjKrnKVwJuzbZwfHppTmn4SBxGH+uc4o33CnQaUCD6+4/ZDcFZIK3goIgMJbK7PYxN98p6LePqrWdPndTAx+TRHnhiirdQMbFct38S0PSJk2rsSM9OWe279qTraZPXZTKBLgE/u6TGqRr9bZqVEwDcvjO6KHZrClYR17kMJyQhZ7vAZKIA/nhtHO8pDTCpp6NXdVGaz5q5K7LSqKYl9VSINzg76RyoL5sz87Yk5NdubHrgyXWlH/aQEYBmHVFO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOxlgGzsoiJYrPulqOQ0qUK4i0kcoNK4WcP9L30xjy4=;
 b=f/2xysJo8PsMe5vrhe1xQHUlczQ/liov/jBjvmGtvW2YdtW5f9kknGpyjp4vqO8GCSLv7SDLZMbkqAErEegny5yMPvLUDsw2tJ4KwFbl5X5mhYA9ajYE+ONW81u2B0712BSa1FvA6jxMVjxCYC45oa6D4ekjeEUsjBu9nAkAafcNXcjvr76jGJwJyKJiDuaangCPgRZsIKe3pzx32q9DrefJSfD28Myj7v6fdfYocmBoytbTE0hLwpkBDy8cyFrBx5Y1R9kWL1aWMqSGZuj6PZd9KjvcEKHLuB3BakGvhNRt/LAo9o6fRKz6qaJ1Q/P/99MBuKZBAPzaEJsUXiGyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOxlgGzsoiJYrPulqOQ0qUK4i0kcoNK4WcP9L30xjy4=;
 b=Gy/EZHp5YFLsn1jUhnbzajPFMaHL7npw6LPLnpo9VeCXmyDC2Ro7WKnMi34+XbdqbBuQNK0307SMQWlnuoPkD6P+zgwVu8kXqMX9hM+MjJC4SijqmWyPZfOORoPde16A4e0rco2ylwcpT5SoylMLYvVuAtWX5kHrXsTTug9nnak=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.14; Mon, 23 Sep
 2024 17:47:57 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%6]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 17:47:57 +0000
Message-ID: <8ad3ada6-f719-43ca-bf16-0095be555302@oracle.com>
Date: Mon, 23 Sep 2024 18:47:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: perf trace: substruct BTF based pretty printing
To: Howard Chu <howardchu95@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <ZuH8qhuZB6mr9JvR@x1>
 <CAH0uvog5akiwUp+28w5u7+-j_fYvQLWahJ6YvEzWjdCz3Ky9Wg@mail.gmail.com>
 <CAH0uvoj_2An0QQgCSenZiK8XubS=amyrxhAWK7ragAFfi+Hnqg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAH0uvoj_2An0QQgCSenZiK8XubS=amyrxhAWK7ragAFfi+Hnqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DBBPR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::30) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a0b347-d624-4a02-d063-08dcdbf7dbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE5SVWsyZHJUbkJDQ0h3VzVXRUpia1N4UzkyNW9qV3dJSTFMQWd1bG1ZeEEz?=
 =?utf-8?B?ZzF0c1ZwQmRNeWR0QnhldjRENUhpQjhtaXdCSE0zZzZSeWNoeUxVVWdXclYw?=
 =?utf-8?B?UzBtNlY5akYrN3FxYTZYTUNrblNYYUFXNGxWTElkbGpOSmx1YTA3YnBHOGpM?=
 =?utf-8?B?Ny94ZlN2TU5wK2sxcENZc00rQWRDRlkxKzlSdjdwR2l6cE5OK2FXdlVxa2pj?=
 =?utf-8?B?VHNmS1JrTzloRHV5ZFNpT2QraFlxemZNM0JuQThyckNseTJ0SWJYQXlCNW9y?=
 =?utf-8?B?WXgwYjJ5cjM5Vms3MnptLzBtWkNPRlgxOGZiYkV6VlM2NWlTZkEzY2lsR3JM?=
 =?utf-8?B?Um90amhiT2xtdVJ2R2RpclhJK0pCZHFxd0g0QzJtcVJZNnZmK2lVV014c0ND?=
 =?utf-8?B?aURsUEpVNTJsdTBjUWFhMXpoRTlITEhlQ0tBMU9ycTRzNFI1OEZCN3FlNTRF?=
 =?utf-8?B?Q0oyUklYZHZjSVRSRy9QdllMTEVJc0pSRlgyN3ZsMUpSVExUaS9DV2M4Y3p5?=
 =?utf-8?B?RUplbXYwSjJ3Wm1jdGZjTmRPV2dSUFdORm5RbEFDZVgzVm9ZakpCT2tiWHNI?=
 =?utf-8?B?UW5RVkZlalJReGNVb3prdEoySFhyZjVIUS9ZSnpjcEtNczNIMnhlV3Z0cjk1?=
 =?utf-8?B?dlNGWE45TW9YbjhZVlBZUmdrb3RQSmhHNGZnblhlS1ZiZzdueXpCZk94VjZj?=
 =?utf-8?B?SkNPVXlyT05vMkFzUjZpSS9Ia2R2RGU1Zi9SV3h5N1Jzc1FHK2UzUjJ6NkNP?=
 =?utf-8?B?ay9hbWR2WkQ4cXJMaFhkVmQ3d25HanpSVjNZYjBDMWJDY1A3MURFMWZhSTZN?=
 =?utf-8?B?dmNlUXF4dWdKYWNXd29IVi9CVW1Hb1lYRlZZeGY2MkI5aVllenduYXNXbjRq?=
 =?utf-8?B?Y3pHdHlOQzN6NVIrYm5nTFcvN3VpbHhwTDNyYkdRQUNMeGtaaCtmcjREcHM5?=
 =?utf-8?B?dTR1VjNFaFBnNUVsM3pnbFNFSEVGVlk2TGFDOVpUWENIeHBON2NqL2ExMU1l?=
 =?utf-8?B?UkdBOGxrN1J3RXRmQWNmenEvNkwwMkNrVWJFYTMvYXRMZVBmRkUvcHBIUWtR?=
 =?utf-8?B?M1k5UUZXYUI4Z2xtWUVydWlPb0I3ZmJGVWxFaElyRytWK294a2FhTjc3UE9o?=
 =?utf-8?B?MFhzQ1ZPMWg2THNiNTZ3a1prMTdmYm9HUVlpRkpqenJGaWY3MThNcXRyaWtR?=
 =?utf-8?B?QnZBZkNCL1B1UEpnaVpoYnV2Wm5tUVN0eG5VTWQ5UjFuamZMTXpxbTZ5d0U3?=
 =?utf-8?B?dlBNRy9OOUpNNFdVeWpVVXptZ2NtamlXRXp6cm1XSldhUEhEaGlhQ0NZc3Za?=
 =?utf-8?B?SjRDanF4SUdmcU1MU28reDBvU2swbUZLSWJZNW9KQ04ranNWd1BGSWEzV2pH?=
 =?utf-8?B?Q1dBRWVjd1JDT00zU0tQOHpHUi9xVTl4T1FiVnVnd2dUdnd6dzZEbFlzLzFa?=
 =?utf-8?B?dHdsOU5MQ0RFaWN0SXI0RFBzalJQOE41QzBVaVI3RnkrQVlTbjhOcmlTYllI?=
 =?utf-8?B?V0tHaVpadVpWQUFic2h0OWpEdERiUVB0MEdEaVEyeCs5NUZoZFZRV1hvV1Z6?=
 =?utf-8?B?emljNWVidk9xNTM0c08ySGlJQlZXVzNHc3lhNlRkL3Zpcm5CaFpGQTBtd3dX?=
 =?utf-8?B?WnBLUytDZ0VWQmxYbEh2V2FRdFIxSFFEdzByQ08ySGtOaVFxbTlCaWljOUg3?=
 =?utf-8?B?K3lROUttTWlNcnRmcXZjTHdJTGxvL0s4N3hTaFEzOWw5MERpSUhtR0F3Z1Bw?=
 =?utf-8?Q?O5uUEb8hq78wMxsE+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHd6YWh0K1BaOTdXSzZZS2lHb0xGNTE0eUxDcnBvNGhSVTh6TWdlS2ErWXNk?=
 =?utf-8?B?dU5KSFpIUTRrZXlyR3dhekVMWEFrS2hzWktiK1BXVERBT3A0YUhnUFdidzFY?=
 =?utf-8?B?cmExaFk3TWpiZS9IZ0pHcUswUU5uZ09qTCtQNlBubHo0RnpSM054eHlYZGlM?=
 =?utf-8?B?c0p1Z0lQSEY4WXMwL3NYNm9WTWR2TWVoNzAyOEhrOUg4MS93YU9CYTBGUzFW?=
 =?utf-8?B?N1B3OEEyQmkzM2tSbVFYV01TdTYrU3QrV3JYN1JUY3JUb2sxc0traVVsbkJo?=
 =?utf-8?B?eWdpaEtSRnNFS0c3VHd0dGh5bFJkcXU3SEYzUEZCU2dhSHFWdzcwWU4weUFp?=
 =?utf-8?B?YVFBclUyUGJidlBndkJPVjJoNjlJbFF2N1NEVVhKakE4L2xFOGpLZHZLR0RG?=
 =?utf-8?B?T0RtRXNHV3N0Znd4TkEzTXZUcW9KWHF6SGF0TW9tbFY3RTNTZS81UFBsb1k0?=
 =?utf-8?B?V0VzL0UvOXZVNzhzYjc3QWZNbk81djIwOUZ2KzZEeUNuQnFsdk1icFQ3akpO?=
 =?utf-8?B?TmJ4NFhSVkZ3NFB5dXYxcWtIQ1dhQkF4UlYrY3NYQUFoVjByVHltUmkvK3Bm?=
 =?utf-8?B?cjBjTjFlZko5VEo4VHQxQk1iVjFDUVhZS1lJWTFTU2dDdE1maUR5QzhqYS9G?=
 =?utf-8?B?R29OR0ZIeWhLT294cjRJL3FvUy8xdkVFT01IMGRESDF6dVhjZzA5MCtQWjdz?=
 =?utf-8?B?QnF1VUN2NGZXMUtTNHlaTlFlZHowSXJjRTkreDh4UFZYYUtFVnVMUUNQdUZy?=
 =?utf-8?B?MUg1aXNYTGthQ3gwaG4wcDJlWDZRVEZKUTA4VDNDak1ZekZKY3FPODJ1emlz?=
 =?utf-8?B?aXBPMnN3V09tNHlPQm5udDdjaHlWdW9lK2VhczNIRnEzcTBFSHcyV3g5SENB?=
 =?utf-8?B?YVdEVVYyeklSRWhhUE90UDlyWEk4S1JYdjl5MC8wVHdYbnFJYjRWNklNS1VQ?=
 =?utf-8?B?WEtQTFlEWThzQmdsdjNYdjVrME0rMnhSUHZCUUhnZ3JJa2NLcW1zOUw3Z1Fj?=
 =?utf-8?B?WVRta3BGeTFlenBub1ZQUFIrWmw4TWlaOGViK0dQN0U0OGwwaS85S0FXcTBB?=
 =?utf-8?B?NHkxMStjSjJkL0RRN21acTZkVUtKMmZxdG1DRFdLM2ltVmtPYmdwN3Vvdk5V?=
 =?utf-8?B?eS80aHlVSnN2VW1DVUsrelNSVzQrM0ZjbEE1SlpKcXAwc3BocnRKQlJpWCtZ?=
 =?utf-8?B?WjE4ZFhkeUxhbUZFc0MwZWZid2FpcHJzaEVsejFQVEF0bkxiRDdkMVpEQXpE?=
 =?utf-8?B?dUtGMHRYeTRFZTBPb3BYQ3dQZC9WR1V6SXRKVmNKTHp3VDduZ3NwdmxYYWRr?=
 =?utf-8?B?dWlDNFZHOEFpYmV3UTdsZEtRUjYrMlplNTVzdDNna2FmNkRLelBmZlFmQXR1?=
 =?utf-8?B?YzE2bXJnRUVnTG5IQ1BDLytXTFYyV211U1Vlejc3dmowbjFyN0FUODZsdG16?=
 =?utf-8?B?eWFCeEc4UWo5SElRWHNkSGVOeE13cXN4RVJuMkkyUWp1Z21NdU1nRjRXOXcz?=
 =?utf-8?B?dm5DZEszWThsajhPanFKNlcrakNKd2wrN1Z3NVhoaDBwaDh1SW9MRGp0TXkw?=
 =?utf-8?B?aFA4L1ZCVmNMa1BIMmZXNG1YSnNIK3pDSENjNzR6TEIzemxiL1ZvZG1oSWJa?=
 =?utf-8?B?cWFta3NUMXd2anlHMGRSaHVqTjFoSncrS0hiMzBkQ0k1WGlxUVFOMFB3L3ZU?=
 =?utf-8?B?R2xETEQrTjZKUkp3aHBDci9yNll0Y2pUcTVRa1BtYlNyOFZFd2NocS9NZkU1?=
 =?utf-8?B?NGpJWDhVRTJiUmFaVFZwMG5nNDByWG5sLzBTTWJRWHZ0VS9zMkJLSzE0V3Q2?=
 =?utf-8?B?ZTBrQ0Y1VVpYWGtuazVqaVcvSjlZY1NudENxS3FFSXlWSFQzbTEvOXYwc0lC?=
 =?utf-8?B?cWFZbDhaeGFLNXBLWEZOdnVOTS9HT1ZqeHFzNHBMa2s4RCtJR1FKUlBTK0tw?=
 =?utf-8?B?VFRwaVowRVJEZi9IWXBnZjZBNlpub20yRm1RTjUyOVR0Nm5jZXpCSTIwTXFF?=
 =?utf-8?B?dUQ2aVJHYW1lZUl4TFVaUW8zVHlGajIyT083SmgyWUdkdXlMdjJGcUdKQjNR?=
 =?utf-8?B?ejFDNTBUcjQ4VDBkeUFvZzlFR2pJdXpzczVoTGd5TjVkNjdRdUxYSm5yS2lj?=
 =?utf-8?B?SzhvRVZQL3ExV2VkbHZ3c3lESm9sUzVoTW5HN2s3UDJBNXZDNit3emp1cHM3?=
 =?utf-8?B?N0tTYStKbVJVUkVERUt1OVVEYmJNYTRMc1RQanJqKzlJSllTbUJ3bTBtcnZ0?=
 =?utf-8?B?czAyRVhGWE0xRVFpc05nS0M4bDd3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L/r+5fLn1uKGBngScvOdqOFIg8vYMD25+iXxIZL4E61DkBMCAuTN2qTkQkkOzQr35KghBf9g5PH2xy+tSXiav35HU6Pzx51uVTCdqA3jo3fTWhsTHCKoBXlriXUgdGiW176+mUwdu97P2XZK2GQHDSyddfMI/AckwAm9RSWwBZndRH0UAHPX4Q9nTK0kD8UbZODuybLnLjAsZg1jlMF6L9tQenTIXbYv7y3L+LSGhZnizIQouMYIgJjlnpQxQqrRUGYmnwDP8NjvHHshkGLE4l7r7MFQRkugruazcBFslVDxZ1kiHWd5uVnkZpSl9qza/kY1NE3UHDqcJtl/iMUtEfkTbWuzWqQ27ey33eJkXQeK3JcUVEliAPu/ko5BmCXUL950uF0u8wzaU1F8W2+XGdFK0pbDxwA9wji96AExUSTyhD7AMAilpftV2WipOyr+Ppjxv9vquQdi8ITD5pqSbOdkXdXIa3R9S1eVtycPLKYc4FjcmBQFcKKY6WRbST6Wq4762cyiRxgvMt6ncttr6mAGYB7o5bmi2NiHZwSRV2IWqXeaPWlz73udHlGOIg4PCdgK5wgZNw0XDiBmXuwHGBZy+us5/8l3Rg0IwHn9EMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a0b347-d624-4a02-d063-08dcdbf7dbb1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 17:47:57.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+OW8RYot4s7zn5HDQhV1y+i1gj6xCEQBd3naLqdaaRlaTKM7p1zkhIUk67pWQC0rDtB+5axtTlE9Az4DAT6Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_14,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230130
X-Proofpoint-GUID: RtfnUJjKnxboOKIAws_yHc1cB6i2Ll0R
X-Proofpoint-ORIG-GUID: RtfnUJjKnxboOKIAws_yHc1cB6i2Ll0R

On 23/09/2024 18:42, Howard Chu wrote:
> Hello,
> 
> On Wed, Sep 11, 2024 at 6:29 PM Howard Chu <howardchu95@gmail.com> wrote:
>>
>> Hello Arnaldo,
>>
>> On Wed, Sep 11, 2024 at 1:25 PM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>>>
>>> Hi Howard,
>>>
>>>         Not really a requirement on you to do work, just a some notes to
>>> add to our discussion/experiment on using BTF to pretty print syscall
>>> (and tracepoints/whatever) arguments:
>>>
>>> root@number:~# perf trace -e setitimer -p 5444 |& head -5
>>>      0.000 ( 0.017 ms): Xwayland/5444 setitimer(value: (struct __kernel_old_itimerval){})                   = 0
>>>      0.050 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel_old_itimerval){})                   = 0
>>>      0.142 ( 0.005 ms): Xwayland/5444 setitimer(value: (struct __kernel_old_itimerval){})                   = 0
>>>      0.174 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel_old_itimerval){})                   = 0
>>>      0.293 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel_old_itimerval){})                   = 0
> 
> First of all I bypass the from_user check to make perf trace use BTF
> output instead of just printing an address:
> 
>         for (i = 0, field = sc->args; field; ++i, field = field->next) {
>                 // XXX We're only collecting pointer payloads _from_ user space
>                 /*if (!sc->arg_fmt[i].from_user)*/
>                         /*continue;*/
> 
> Got the bad output:
> 
>    500.218 ( 0.015 ms): a.out/112335 setitimer(value: (struct
> __kernel_old_itimerval){})                   = 0
> 
> But after switching on emit_zeroes from btf_dump_type_data_opts:
> 
> dump_data_opts.compact   = true;
> dump_data_opts.skip_names = !arg->trace->show_arg_names;
> dump_data_opts.emit_zeroes = true; // this
> 
> My output is good:
> 
>  96058.828 ( 0.010 ms): a.out/104347 setitimer(value: (struct
> __kernel_old_itimerval){.it_interval = (struct
> __kernel_old_timeval){.tv_sec = (__kernel_long_t)0,.tv_usec =
> (__kernel_long_t)500000,},.it_value = (struct
> __kernel_old_timeval){.tv_sec = (__kernel_long_t)0,.tv_usec =
> (__kernel_long_t)500000,},}) = 0
> 
> So I think this is btf_dump's problem... Because most of the time we
> want to omit the zeroes, but that will have the side effect of not
> being able to print the whole output. I'll figure something out.
>

One thing we could think about is if there's a way for BTF data dump to
better represent the fact that a structure is all 0s; currently we will
show "{}" since we skip emitting zeroed data, but maybe - at the
toplevel only - "{ 0 }" would be more expressive? Thanks!

Alan

> Thanks,
> Howard
>>
>> First glance, yes this is a substruct, but we should be able to
>> collect those substruct data in BPF, since it is substruct, not
>> substruct pointer. It seems to be the same -p problem we discussed
>> here:
>>
>> Before:
>> ```
>> perf $ perf trace -e open -p 3792392
>>          ? (         ):  ... [continued]: open())
>>                        = -1 ENOENT (No such file or directory)
>>          ? (         ):  ... [continued]: open())
>>                        = -1 ENOENT (No such file or directory)
>> ```
>>
>> We can see there's no output.
>>
>> After:
>> ```
>> perf $ perf trace -e open -p 3792392
>>      0.000 ( 0.123 ms): a.out/3792392 open(filename: "DINGZHEN",
>> flags: WRONLY)                             = -1 ENOENT (No such file
>> or directory)
>>   1000.398 ( 0.116 ms): a.out/3792392 open(filename: "DINGZHEN",
>> flags: WRONLY)                             = -1 ENOENT (No such file
>> or directory)
>> ```
>>
>> I will test and fix it later.
>>
>> Thanks,
>> Howard
>>
>>> root@number:~# strace -e setitimer -p 5444 |& head -5
>>> strace: Process 5444 attached
>>> setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=5000}, it_value={tv_sec=0, tv_usec=5000}}, NULL) = 0
>>> setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=0, tv_usec=0}}, NULL) = 0
>>> setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=5000}, it_value={tv_sec=0, tv_usec=5000}}, NULL) = 0
>>> setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=0, tv_usec=0}}, NULL) = 0
>>> root@number:~#
>>> root@number:~#
>>> root@number:~# grep -w value /sys/kernel/tracing/events/syscalls/sys_enter_rseq/format
>>> root@number:~# grep -w value /sys/kernel/tracing/events/syscalls/sys_enter_setitimer/format
>>>         field:struct __kernel_old_itimerval * value;    offset:24;      size:8; signed:0;
>>> print fmt: "which: 0x%08lx, value: 0x%08lx, ovalue: 0x%08lx", ((unsigned long)(REC->which)), ((unsigned long)(REC->value)), ((unsigned long)(REC->ovalue))
>>> root@number:~# pahole __kernel_old_itimerval
>>> struct __kernel_old_itimerval {
>>>         struct __kernel_old_timeval it_interval;         /*     0    16 */
>>>         struct __kernel_old_timeval it_value;            /*    16    16 */
>>>
>>>         /* size: 32, cachelines: 1, members: 2 */
>>>         /* last cacheline: 32 bytes */
>>> };
>>>
>>> root@number:~# pahole -E __kernel_old_itimerval
>>> struct __kernel_old_itimerval {
>>>         struct __kernel_old_timeval {
>>>                 /* typedef __kernel_long_t */ long int           tv_sec;                 /*     0     8 */
>>>                 /* typedef __kernel_long_t */ long int           tv_usec;                /*     8     8 */
>>>         } it_interval; /*     0    16 */
>>>         struct __kernel_old_timeval {
>>>                 /* typedef __kernel_long_t */ long int           tv_sec;                 /*    16     8 */
>>>                 /* typedef __kernel_long_t */ long int           tv_usec;                /*    24     8 */
>>>         } it_value; /*    16    16 */
>>>
>>>         /* size: 32, cachelines: 1, members: 2 */
>>>         /* last cacheline: 32 bytes */
>>> };
>>>
>>> root@number:~#

