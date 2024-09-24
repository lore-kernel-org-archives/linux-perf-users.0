Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076312F375;
	Tue, 24 Sep 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198076; cv=fail; b=RjTuCE8/X1NovtPmKnoL5un1dHf492HQco2ReaSICC++dTQv7MVOxkxTwhTHifVHTxMn4AxGMkcoz1wkxJXaDa1doMEpdKJ4ZUHjkL75BRj9wlc6zdrk56tqDiXC6vE1YJw0NQtDMMd06lIpKZGMKRQ9I4o7Il8VS52phQGgYbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198076; c=relaxed/simple;
	bh=IOIdQHpgeFP3lS+WfFTGJEHqR/AJS/O9KfF7/sfHaFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MOK0HIk9fLMskwaDzYC5KEUrKvylWV2j5AHbHFaVxUlmoeKu1k2MDOVYPpmGYQNxHV/nfbFetgz19azx5WcxVstwLAAHkuH0Nkq9TJq93zEIsM1qJPdBdJEaz69BbtgZ3AZibYf/pIjfduN13f6q6a/dedyY42MoPdsWh2KL4Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J7GpopvE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z44xefm2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J7GpopvE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z44xefm2"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OGtlag031078;
	Tue, 24 Sep 2024 17:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=F8wykl1Z8GqOPkzJkw9fvpIuNfybdOqoPp7csQO5FZI=; b=
	J7GpopvENN9+YDe4zp/H/sr2zQPUFrZk6lTJekfdd0bJRcVkok27wasgCGOEptAV
	7hK4MUQAVIz/xqM2wFdeoJ5V1uYHjigTSUM47YxvhApWIsnhhWVKAy+qpHDTwr16
	62feSzeeoGP2ILmaSsMl6VhJvDJXL8uOOjkV/qSSOCptIv7p1V8hhx0cfajO65zI
	A3T7DbwmLDCbbKo6Bb5pCWilMh7DQliCKu8vtIoIthyYlFCNreYtywUF+bTqKZ0F
	ijWdTTFItyYCArIUf71G+JqQQ1l5JaEb7mVBDpkS76uNwgz7EuqKStGAc95IeqjF
	6dfqtJJvPGo1YBvlusT3PQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx35nrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 17:13:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OH81RH025128;
	Tue, 24 Sep 2024 17:13:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9jmg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 17:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJM8upO2PaRT8g3hDwwFev+X+jDeEDFynafjamFSP3cldE8PrJuja/NGJz6QmZp4F6Z+UzMoQdsbY3Alr8whqhP/ubP3haYtdb+f+BYSN3WCmorAPzRzXUCsuMRnj07gK/p01p+Ku11dEyLJ61vIAEyGFSUqTAZsivx2RrbPEDgGijQOlPVeQ5DJoc8NIEpTMGPAljPl1gNA3pyhUBDmXagfTd3hwXFSAXPkUCaZ57KCODJ7+CE4oAPi6O1FvkEjoZ276Tq0fY+bAuj20O5zZ7zijtadRXr56h/+bw+ScSAWaxEvZBJFhD+zjQTcL8Rh0HUbj1MKh9Jr/qS4q98MyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8wykl1Z8GqOPkzJkw9fvpIuNfybdOqoPp7csQO5FZI=;
 b=H4FHSEjS0Yv+U9/j/RJppYnXrvfD80OSDoLq+fdRvXJuBcBcJn4AGrkdxqIMmRcH3UOH2nLyVmxgen600lQGccJfwvrD3Jw0QtLj40Iv0x+6WkryZTZGUX+FqSzdLhYGh10J39lQxQzvdmwiMFD2Yo3/K2vJtJmdOf8ulM5+9qw7z558oS5cjWnufc14GngmXnl5k22Uaxldxv3Pjp1pFDiBRH6QMTT1tvUJCuJoYr1wfZuJtDk3/p8cKaj8QtpQLL1t6uWba5Nscy+eT9mxa1EXkb8QuTz4xhEfpH3XITJ6SDujBCGPXDewYZEZOQ+pxTCiNsAXLsTdvlCt78A4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8wykl1Z8GqOPkzJkw9fvpIuNfybdOqoPp7csQO5FZI=;
 b=Z44xefm2B5bFOJglarv9GanXlYi1COtUXwv2EhJ1k/h/V+fnic9IwjmUaRCtsiS0Mdikkxl+VF9gEvI04+e1jvASAhHiZcZJ9xkYT3doQe/NuwGOijjJEacRcytnCNqQ/HGRLsFfRsTlB10Y4AbvT5BYwZewVEFTZ/ojRPTRzFQ=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by SJ0PR10MB4560.namprd10.prod.outlook.com (2603:10b6:a03:2d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Tue, 24 Sep
 2024 17:13:43 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83%4]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 17:13:43 +0000
Message-ID: <5a8e73b5-7bb8-4669-a255-808abd2d2132@oracle.com>
Date: Tue, 24 Sep 2024 13:13:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
Content-Language: en-US
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
 <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
 <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
 <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
 <36e86320-1a43-45d4-b25e-a5d60857f4b2@oracle.com>
 <78db946d-db24-408e-92fc-b7ff79c80728@amd.com>
 <e193949b-d969-42e7-a0f3-fbea6e4dfe12@oracle.com>
 <7a34a58b-9366-46a4-92ca-e36e378311f5@amd.com>
From: George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7a34a58b-9366-46a4-92ca-e36e378311f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|SJ0PR10MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cf4e25-535f-43a3-a364-08dcdcbc3db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHllRkZWRmNKWUJKTExOcXlwbE14V3VSV3kyYlNsYmhpN0xCMnBxLzZrMWlP?=
 =?utf-8?B?SjRDNkxCQm0rMHdGYVpQZFpTclRyV0tYMnBFVzQraEhzajlNS25CT3kxQWo3?=
 =?utf-8?B?Uys2Yjc2ankwYjBERC9mamJmVitpTkE5TjZCalRLck9aWHdwemx0dXI1cVVx?=
 =?utf-8?B?cVVtRmJBMktlRnFHbEV3NXpxKy9xU0RvaCszbWI5cy9HQU1rUEZoaWZGR2RZ?=
 =?utf-8?B?QUIySmd1cDJvMXdBazE1Mkd4V1djSy9pL2x4Qy81VW54dnNPWVJmN1RmV2tW?=
 =?utf-8?B?WXVLNDdDN3QwR2VZT2VSOGZ4QVJ4TmRjUjI5SFVtSGZaZXgvMDRJZFdIeU50?=
 =?utf-8?B?WmJ6cFdnYUNCYWxNZzAvRlY5ZVU5NitjRW51R1lOUTRYKzZGVTJoMllETnBY?=
 =?utf-8?B?TmNQcU1OWWxBbXdHRUpoa3ZMaFU4SHE3Nmt4Q1g5KzcrWGRVQThpR0diOFdE?=
 =?utf-8?B?aGxkMjdRZ0lMZGs1QmVJbzAwWTh6bWVLYUg3UnB5Vk1meEw3Wi9WR2FQSW4x?=
 =?utf-8?B?K1R1Q21GVEJFUkRlcGlJQkNibVI4NUxDTWozOEdJYnZ0RXVuNGFLbnk5LzRp?=
 =?utf-8?B?TWo3U2VFbGFPV1QzTzUrc1cyTktXeko3WmYxR1R5Zm1JVXRRZGdaVWNPMFBN?=
 =?utf-8?B?R3F5Sml3QVNSWUZlMGo3UHNzM0xTOXVrcjgvbUtYVmR6SGk1YkF0ZjNHMXB5?=
 =?utf-8?B?N0dma2xMRjBIRWI1WXgvLzIrSzRhRVVtdlFDeWRRRldCdmxhZXlsN3dDL3VY?=
 =?utf-8?B?c296QkRQM0xqUDB0SzJpSVl3eVN6WERncWloeG1OdlU0OHdqemoyYnV5ODR2?=
 =?utf-8?B?NE0rN3BjRVNHRUtnYkh5cjJaR3BTVVpLUGUyK1NvWS9za1hsMTdvWWpnRXhK?=
 =?utf-8?B?Njh6V2JoVHVqWDhFVzdkY21lZTc4V1JTcFkvdVhmcit2S0V4R04wdmkwTWxj?=
 =?utf-8?B?Wk1JeFBHYTI0aWJKenJyeGZoeGw1NnJ2aE5kN2V4b0N2bFNmM0dtQkg0QW1q?=
 =?utf-8?B?M01CUVBUWm1ya1c4eGZFdzJMdm9JWUdwTW9BcGdta2Ezcm1nUTY1VG8zQUtY?=
 =?utf-8?B?SlJ4WFBsTnJ6bGVESklhNmk3MjJabDduanRWVnlnRSs1c3ZNeVFyWG52RkZ4?=
 =?utf-8?B?WUhONXIxN2xZeGZ4L2laMGt4Sjd2dG13UHA0R1Izbis5UVhCaksyRDkrbkVZ?=
 =?utf-8?B?dDZ4YXhvUVFFYWlwTWg2SVdSQy9mNmxLM24yZFVXYzFZTmVMYVBBRkJ5M0Q0?=
 =?utf-8?B?Y1BiTFZQWjVud2ErMjZ5dy9GS20zZVpXTlFyMmRSdFFpQ3EzWWc3SlE1MmZF?=
 =?utf-8?B?WkxjY0crSHF6UEZvYmgydTlJUWJ1OTRKMHZFWmg3NnVIeTJSbjM1U1NBSHIz?=
 =?utf-8?B?RlkxVXp1bHU4MFBTSGhpUjVTUkhSQjRESWFjMU0zOEZBZ3A1RVB6L25pcHZW?=
 =?utf-8?B?ODRreExXWUdLeFlSQXJvYWpwZGZzUTBuVGZPMkxYeVgwS04reUM1YkFqRysx?=
 =?utf-8?B?WG9wYU1lN2VSbjJXSUNuNlhDTkpzWk9pV0NuTWE0cUdQOU5vWjh4VUp3N1JP?=
 =?utf-8?B?Z0xiRnRWdVVzZWFMVXAxSXlhRXZ6cUdiemJQa0lzanRLSURiTVQ0THhDM0x1?=
 =?utf-8?Q?mQUAW1+Xh3jVULvOsovefyn/SLmjnVwl2g0oFURQddV4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkJoVmpLQ3FmdytPa1dSNFAvZkl5WVhZVkNWL21heUFBTXR1YnZhNDlqMGFI?=
 =?utf-8?B?WVRUVVVLMzZ6ZWpIaW4wb2krTjU3QXdPbFNMQlI2SHo4L0xGQ3JORmhmOWpH?=
 =?utf-8?B?SzNkMXJZUXVoclZlTlkweml6OW10K0hpTnZXeTM4b1NEVWpHaW0wdG5xQ1ZX?=
 =?utf-8?B?NXBGeHJRUEFqVm9XQlpUeFhKTTFYV1p5MXZ0dmg4NGhwWGdIN3YzelMrNE50?=
 =?utf-8?B?ZTV6THFwWDNTdGhsdVBqUDIxRlErOVJ5TDdHbWY3ajZsZk5vQUVlUGN4aUdW?=
 =?utf-8?B?Umptc1lBM29jdFREb3BuY1Q5YTQrTVdvYjM1aUFLQ0ZMd0NSL2xwQUxhUHpi?=
 =?utf-8?B?ekJhYVBCbDV1c1IvcHFoa2ZMWFRFUXVEN2RJYmt2bmxTQTdiSVpqcmhoQVln?=
 =?utf-8?B?bGZQblVwVGNacFhucldtUzVHUmhtS2NHTSt5Tk10RVNDMVpBKys2QW9ZQ1hT?=
 =?utf-8?B?L1RaQ3FNblREOXVxM3BxeWZ2U1ZPdmVvcnpuUWd4djdhSVhWOEpUTnZRTlVu?=
 =?utf-8?B?NXpteEJzUGRKeGZ0MjVmZVRGOWdudFMxSkRxVExVWjl5VU4rb2V6NjY1YTdD?=
 =?utf-8?B?UDBmUUZIaG0xVFY0ZThmdWsxNk1JdzhJaXFLR3lBZGJBVnluM0FXb2tLa1d3?=
 =?utf-8?B?b3NCaWgvbGR3UFBaV3JPOU5QbGJNU005Qm9xT1N5bld2MWlYbXplaWoxanZF?=
 =?utf-8?B?eWNPcXpONUY5MU1Gc0dreWlGWm5EVXhsWTdENWI3aVphclF2WGR1SlA1bkZm?=
 =?utf-8?B?U3Y2QXd0UDBsRHNzNzZjcjZYcklIVzJMUFdvT1NBakgvSVY3NHBzbHMxaGxL?=
 =?utf-8?B?L25zSVl3dTBOaGdvMEVIbTJHbHorWDNuOWNiWlQrMEhsZnE4ajd0dW9ydWlO?=
 =?utf-8?B?L0VZMGtaZ3hWazVVMVZiWTZRU2luNTEyZlVodnlmYWtvNDdxTXRWQURmV0hF?=
 =?utf-8?B?S2pMcDVEbmxlWnNEYzFJeW5ES0drV3pnVzBQeGxaK2VCdzVua3dYSWNxWWU4?=
 =?utf-8?B?N2hSQy95ZjU1QU4rS0JJRkJMaCtCaElvMFhOZGI1MjRqdHYrQVRyT2lPMHdn?=
 =?utf-8?B?OWFxMGc1TFlwdng1TnZPNTl3NmUzQ1RZQTNqQnJFKzhqclJNNksyYWFtSlNV?=
 =?utf-8?B?WUk1NG1OQ3lib05talVZVTlYZlp1NnM5VldvOTlONmVreStDWFdxQ2tLb0F2?=
 =?utf-8?B?dklXZzc5RERxdnFaUUNYb2xGaFd4azV0bjhKRWwrWWVDSE8zZ3haZldYZU5D?=
 =?utf-8?B?QlBFb2ZsaE5td2YrV0JiZDNVeEhaSlc0QjVPbzVCN052cnNpNU42VklZZVRm?=
 =?utf-8?B?c2RFMFZLM09EbStOeE5NU3JaalhIZVZZdkhEMkRocFpyd0VTM2pMcVVwemRH?=
 =?utf-8?B?OGJCaWtUVThxZGNqTG1YZXpFYndITm5oWDJxcU1WS1hYTTJHNzNYVnorY0tI?=
 =?utf-8?B?cGNpYzVlRElHbnZtbHN5ZGZ6U2ZvTEQvMEQ5eXFzQ1E5eExwa1l2QzNXT1lB?=
 =?utf-8?B?ZjdObUFYSTFhZHkxQ0hEVmhPOVc1QWVIQUtoQ2NoeGtIRVl4Um4vY2g2OFY1?=
 =?utf-8?B?cEFKa0drRW5LWGtWNGZOVVJITVp1b3VmeDlQNzYxSzJ2WFdNU25aL2FoODkw?=
 =?utf-8?B?V3RtdG8rZithNVpMQnRQaUVBK254K3BtTFR5R3JLbmwyYU9DVEltai9BeFE1?=
 =?utf-8?B?MnR2TEVTWlArMFBsNjJncVFscjlRU2VTeXRHems5b3RkaGJMajZTbXRucVlZ?=
 =?utf-8?B?RDhDQWVjTXp2bE1hNXFsMWs2bU5nellBRit5QWJZM2c0NkQ2NTBxek1UbTAz?=
 =?utf-8?B?RzlvZGlRMTdKNzYrenJaYUFnSHpuTG5EcHJYT0JGL0FlMWloR3p6aEhDdnpN?=
 =?utf-8?B?YUdWd09KakJibnR2UEdiT3dBT25nSWR3VktZQkZTRWswSEJydXNqV3lpUmVN?=
 =?utf-8?B?WGM5c0xmMk1aTmdZUU0vSURsM0hJSXg1Witob1dKTjRnT3BnQXd3Y3drd05M?=
 =?utf-8?B?K3RrNFZxS1RocEJLMy9XeTJWVGxhOXRua0xmcDNONDR2MkQ2N0JyWjFQVHI1?=
 =?utf-8?B?dHFZckw2ZjVWOXBrOHJyaElDY0hNWmZRb1NCTTBKUkFQeGErcXQ0RGtjUTBi?=
 =?utf-8?B?bUYzNlB2ZjB3b3Vtemgvc0ZCZVBEL0I2dmQ0WDdNOGdTRW1KY290Y1RrNG5o?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u9ZHwvKbDnqJHgbLXd9KOmMHVz2FxqH6028mI8Cy0XG2Pb2Vbj4VMIHtRJz9CrZMTzUO5J3yYBC6n5zk/ERFgwrRykvbxZCTvKOWlA2Fm48m66T77fYd+bmtFnc5/ccKwpLf7h+V/wF4ONCTXgpXxfMEgND9KhbxvCDFS5CiCVgq7Z1W74wX0E6nJBgl3R6sjFn/BHk/XGMMYbUyx7ExFYqN7I6b2TwTDKJPxvR0nyKvbsheB/Vzb/UphgF3gyIpHKE+qbHMAcytjXCnVOvhQR/UR5lfU59tKz4mGtfWW9v+rIeFnECUiS8lg0ThxmsZJ2PdxE25oYafTAqceqsVpmwmNM8XOc4F8Zc5GjmtuOWiprBHUQFMEAwR6BF8lFZvPnBRsX0YRW/uAsP6LnhRCcwryj0uqnDlaAGApsMyupJ4Hbmo7YiCwkNObiIycM0fyD+uIvntS0faJnjdrlcytZhIf8Ej0ZFNj39nGQSGLQ4TdNR96ZTekKe9LQAoZV2FdRySqhieKTj8kY4lDNTlIx3sUbocCdw1nbFoXVgbXWZcV9KKMc2iEwzU9Hh+os7zjZpcrdhHTItmsUvko5JBUTB8I9mWWzjHyFj7/TaC4Xg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cf4e25-535f-43a3-a364-08dcdcbc3db8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 17:13:42.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9q/zXKuCxw5GZ4R3HlFK4BpDZJduPN0SQ6XmXv9SiRU1HamjvxLUVWRhzGPkwGV7ZmvKC7LmIpK72xeWJ7lxwkt7zW1CUtqXsptuKhuRp8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240123
X-Proofpoint-ORIG-GUID: LaxK-1I7lF8vS4cL2kbjtBqfwAJ3x9gY
X-Proofpoint-GUID: LaxK-1I7lF8vS4cL2kbjtBqfwAJ3x9gY



On 7/2/2024 12:03 AM, Ravi Bangoria wrote:
> On 24-Jun-24 9:48 PM, George Kennedy wrote:
>>
>> On 6/10/2024 6:51 AM, Ravi Bangoria wrote:
>>> On 6/8/2024 12:43 AM, George Kennedy wrote:
>>>> Hi Ravi,
>>>>
>>>> On 6/4/2024 9:40 AM, Ravi Bangoria wrote:
>>>>>> On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>>>>>>>> Events can be deleted and the entry can be NULL.
>>>>>>>>>> Can you please also explain "how".
>>>>>>>>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>>>>>>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>>>>>>>>> This appears to be an AMD only issue.
>>>>>>>>>>>
>>>>>>>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>>>>>>>> Can you please provide a bug report link? Also, any reproducer?
>>>>>>>>> The Syzkaller reproducer can be found in this link:
>>>>>>>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>>>>>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>>>>>>>               if (!test_bit(idx, cpuc->active_mask))
>>>>>>>>>>>                   continue;
>>>>>>>>>>>       -        amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>>>> +        if (cpuc->events[idx])
>>>>>>>>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>>>>>>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>>>>>>>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
>>>>>>>> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
>>>>>>>> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
>>>>>>> There are subtle differences between Intel and AMD pmu implementation.
>>>>>>> __intel_pmu_enable_all() enables all event with single WRMSR whereas
>>>>>>> amd_pmu_enable_all() loops over each PMC and enables it individually.
>>>>>>>
>>>>>>> The WARN_ON_ONCE() is important because it will warn about potential
>>>>>>> sw bug somewhere else.
>>>>>> We could add a similar WARN_ON_ONCE() to the proposed patch.
>>>>> Sure, that would help in future. But for current splat, can you please
>>>>> try to rootcause the underlying race condition?
>>>> Were you able to reproduce the crash on the AMD machine?
>>> I'm able to reproduce within the KVM guest. Will try to investigate further.
>> Hi Ravi,
>>
>> Any new status?
> I was able to reproduce it with passthrough pmu[1] as well on a Zen4 machine
> where Host has PerfMonV2 support (GlobalCtrl etc) but guest do not. I've
> debugged it at some extent and seeing some race conditions, but not working
> on this with top priority since this requires root/CAP_PERFMON privileges to
> cause a crash. I'll resume investigation once I get some time. Sorry about
> the delay.

Hi Ravi,

Anything new on this issue?

Thank you,
George
>
> [1] https://lore.kernel.org/all/20240506053020.3911940-1-mizhang@google.com
>
> Thanks,
> Ravi

