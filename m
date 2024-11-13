Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513001632EA;
	Wed, 13 Nov 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511478; cv=fail; b=eie7jE4HiCu+Vy1ijVLAD2x97wo7VcqkYG2nRzofnSA2zvJS83AA/ToHCfPHdDyTYUWm0ma+oiOVL7Uv5pgVxA5EOQgXFVn0lPwuCbqKjSkqSP0VH2goLY6SYlcJagvDjEK21Rm8/7loz0vUrbHxDAQsB1c3lYWYb+gH0AMk1VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511478; c=relaxed/simple;
	bh=/Ka0BDxuvdcBit0jmQjRQMuSQFEmrH2JWbmGV7Gaqwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M4NVgV0OLZCqz+hfzudvTD5p2UcP+ivUkLcDc/4BhwgD3S+5Y0+5B7+ddKc8S5x1JpAIuVpcST7vaGt/lvBtk3yEspR2xtcyu76TyJfn9MduWPEcu0HIOemjQIOXXWxuFxgH6isSlT/Eh4JJ6hKD3MYhEiGaYXsKuPXfT+sQTco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=my4XDP6E; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="my4XDP6E"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADASx4b012138;
	Wed, 13 Nov 2024 15:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=/Ka0BDxuvdcBit0jmQjRQMuSQFEmrH2JWbmGV7Gaqwo=; b=my4XDP6E
	O8GoDZhKcEfIn5F6ftk4sMwlRz03V3cEBOUYId3Sw1iRnq9Q4kOGQkb4J8TtB5Tp
	JKbju5MPzeDS6IxxOMY1VFMfFDK4uxvJwikI/0MdODGU5X0r6bCxnCH0JPly79UK
	P1wSHBGzM/TnSGO9yXR6wCzbFTBFIq0dr29h8YeCvqZvVNsSjaHjJk3c1hHfnjSd
	qTYZMuNiaQV1imXbq7XumJIX0ezOdgoNtDymX2DG3eLK9iFKo+eG0khRCZNE35dB
	C+kOTBZB1GyilJDn7uGY1j2xp6HFRSC7pcsm2+oasX58yNQfBlxmRJGHCJCR1G1V
	nn2dhVKubdRcDA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vqfuj2wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:24:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ADFOBqN004349;
	Wed, 13 Nov 2024 15:24:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vqfuj2wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:24:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G38tg7DmDj9Ni8mAlUTNxtYdK9UObaxGwukSGMcpJJybx5R+drSPQcWghPfmAtG8KLn1AgImzwx4t7VGucKeRaxN0Iy2anIeI9CRm8MQbsfFMkVoyt5chZlFuqLMPaskO/s02Sj/8agycecd+i4HXgigYjKAhLQVYNw4201HxNFPaGFdiyPxYPkcSXgFOUUrgpky8L97W/ULUtQGIcqjxny6SH9GOlND1NcE9h5fyhUtJIYfZOd7F1xrMW59HvJXJaoRLvpRzLNQTkDADVpp0c/u+49b26HHyCEKAl0/uOor+MaWhBp+C3kb/zjVX05YoxYUfuj8zA5J6PRTruqeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ka0BDxuvdcBit0jmQjRQMuSQFEmrH2JWbmGV7Gaqwo=;
 b=m6InxNUiujXUTgszZoPO1AH8GGR6mkqO56BN+K/KxVt9nepydtz82dxhoUv3OAIHCfFilF/0RZAS8UfDUkbSEjTEu50MbqZNevrxSZq8tNs2kqge0Bo56r0mLo5GplZ7mhHxb8MjsVrI1kUEzDX1VgnVDEVu3s8JGC+oJpMuCzOZ5UubOJbu3FNhALaLLoQ2jkDyxqWOlfH8U/vsjnAvk12NoXxCeEwJycTJXGd2A82V7wydpSd8ZT+NpdmfFhZSu3N0GxM6RjbYJzjZpMO50A8kh8KLuW+LVbnovOSa30QwEHKR0HsoPGoZto+pgqycGyrROX/r9r0JVmOkQ9xx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB4839.namprd15.prod.outlook.com (2603:10b6:806:1e2::11)
 by BY3PR15MB4884.namprd15.prod.outlook.com (2603:10b6:a03:3c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 15:24:08 +0000
Received: from SA1PR15MB4839.namprd15.prod.outlook.com
 ([fe80::c3e4:66da:7486:d945]) by SA1PR15MB4839.namprd15.prod.outlook.com
 ([fe80::c3e4:66da:7486:d945%3]) with mapi id 15.20.8158.017; Wed, 13 Nov 2024
 15:24:08 +0000
From: Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas
 Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers
	<irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang
	<kan.liang@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Melo <acme@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        "Steinar H. Gunderson" <sesse@google.com>
Subject: Re: [PATCH 2/3] perf disasm: Define stubs for the LLVM and capstone
 disassemblers
Thread-Topic: [PATCH 2/3] perf disasm: Define stubs for the LLVM and capstone
 disassemblers
Thread-Index: AQHbNeAV8194NPtvDEGWdZaYHKSM+A==
Date: Wed, 13 Nov 2024 15:24:08 +0000
Message-ID: <B78FB6DF-24E9-4A3C-91C9-535765EC0E2A@ibm.com>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-3-acme@kernel.org>
In-Reply-To: <20241111151734.1018476-3-acme@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB4839:EE_|BY3PR15MB4884:EE_
x-ms-office365-filtering-correlation-id: 6f3fe8eb-7adc-4f2d-6a4b-08dd03f737fd
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3BuV3l4NUZwN1BKOUtrVHRJNmt5cHgwcG02SEc3MGhWT1BrVktUM2NpaDlU?=
 =?utf-8?B?RkhEdVR2NW1UdU5NWlhJVGNUK3dldWQzTGp2NE9sRXJWN25CSFJ4V21wYXFl?=
 =?utf-8?B?MDk0elNQSk9EUWlSTXBuaVJ4eWI4dFVsaW9Pc2pwTWxhSE1jdkdEaVBKVXdi?=
 =?utf-8?B?YnNodUNwQmdTOEZQekdVY01BTHNqYVRrTWRGWllYdnVDbE9uc2xQNkt0VXIx?=
 =?utf-8?B?ZVZzNGtneFh3YzJ4Z2JQRmJKYktqYlpRazB2enh2ZUxMNDRhbkJubFcrZldI?=
 =?utf-8?B?RFRrYUpBVzUvbGVkbitPOC9UQmR1OS9RU1BKVDNZTEtTQmlnbGNSOTZPSjhr?=
 =?utf-8?B?RkhLTW5oclRROENmMWJhQmdtNjNGWFJSWFlBRVl0c0tVT3F2M01uSjRmeHdF?=
 =?utf-8?B?c0p0MUlpTFBZMUY1Wkw3eUdVbDRHZXBnei9vT3Zaa0NlSHNHa0NDNEk2eGRp?=
 =?utf-8?B?OHdMa0tZUmNYM2pRU2lsaEVVQVIzMU1KTjI0Z3ZqdktBc3k0eXlQampxQ210?=
 =?utf-8?B?VG9ZbnRoWUxSRGRiNmc0N1pSUDd5OURBWERpaVA5V05xWGNmUThDcWNFQjhr?=
 =?utf-8?B?dS8zVnVJRG9nMWRZbnd6SDd2NUxweFZ2QjdyVU9mYTErSnBPdzhxODJ6ZlN5?=
 =?utf-8?B?QXNpV3BkNjYvaVJFMXBMbmFCd0Q3Z3dzd3RGTWJwY290QnNBMVRNV2VLN1Vq?=
 =?utf-8?B?WjZlbXZXV0NNQWhtVUUwMHl4ay9UbTlkbTBkandWSkVWMWtPb3YyRFZOemMx?=
 =?utf-8?B?L3hRNlJaUFB6ZVJQWTRUTzZpNlpVS0s5L0F3bXBoT1lZZ0NWeDdDOEk3b3Nm?=
 =?utf-8?B?RFVBd0NwcEFXWk5rZzJVVFdDTGV6NkxyNisyUndaUXhtSjg1dlJVOW5acUFr?=
 =?utf-8?B?dmtnNm1Yc1NwZklEbVEwSElXUHdqeG1yUjBLQWhSa3RXTEdiYW1sUTkxWEdv?=
 =?utf-8?B?ejdDanovc09KRUhpTnlzU1RCYUN3Sm5xMC90ODBKWTBub2JOUTBVeHhhVVZD?=
 =?utf-8?B?aUJxNHdrbUxaZ1hVelhaSmNETDVMaFZNc2trajlUZHczaEZhbWlnRWdJaUo0?=
 =?utf-8?B?ZGNSbndzRFlmUEkzZ2QxaU04NlNKQXp2SjB3a1RLaFBMOHB5YXg1MElIdmt5?=
 =?utf-8?B?ZStLRm5DVUZwZU80Q01hby91VFZIbFo3MjhOMC90TUNZdWNOdDc0RFRMZE5O?=
 =?utf-8?B?dzVlOWJrWXhhV2J4aDRUUmxGRmM4MEM5dzlyeWY5RktScWg0a2ZrSzBzSm9U?=
 =?utf-8?B?Z2tIMEJWQ0V1VkdZU1RwVnVma2VJZEdoUE1vTm1oRkY5YmZNWFpULzNzM2E4?=
 =?utf-8?B?cnQyVzR6WmxUNmdLUUdsVVdTYW8xR3lhMmFrZE5lWVQvZEw4RnJFNXE2R2pK?=
 =?utf-8?B?UTltNlpGSFNWUmdZaXpxTXhPblRCMTZvUkhPaHE4cGVnUGFLazdxa3lFMHRa?=
 =?utf-8?B?V21LWjV6QWIzc3FSeWhLNW9nNXpKV0MyRjRKa0NUZ1BFWFBsMFVKbzRGNzM4?=
 =?utf-8?B?eXpwelBRREdtYm5sc2I0T3pCYzJ3eG0yUWR1c1F5RVk0MTgreGZwbGlVOTBt?=
 =?utf-8?B?c1lEY3BPNVY5cUxMbVF0RWhocC9uNXltWTlxaHJZTzROd29HNmN6b1pDRStE?=
 =?utf-8?B?S0pEcFN0WUdDM1pnWGVqYUEza2h3eCtOSVZrdldjWmFCdm9JSHdWY3c1M3dw?=
 =?utf-8?B?dUY1MUdBeW5VZ0VBV09UNWx4L2ZjN0ZVWHQxUmZJR2FMQ2Rjem83anB2SnJR?=
 =?utf-8?B?NmxLQVB1WGV6cVZUalMxTENMNmFwTzdESFZhT0MvMkphZTlxTTFaVWdKM3FH?=
 =?utf-8?Q?5lEqht/c4MxV5zCosdnafulZgF133UAbaQ5gY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4839.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1J5V2kyT1RIK3JoR05uK3FwYmduMEpxbUxvVWZWQmwybmFnMVVjaDJlbnlH?=
 =?utf-8?B?VjdWa3Rkd2JLa3Fwc2QyTWpURDFSUFpZamEzelkzcHRid1g3bmZzWUhraU5K?=
 =?utf-8?B?UkpWeW1XQ3N4eW1VdWJKV1BuSWducnpoU1FocmFFNHJMUE9HS1kyMkFJQ1hS?=
 =?utf-8?B?WDFibnpaYXQvY3FETW5RUHFZczRGSnRCRzVSMXNZM2k2cUFvb0c2MityQURs?=
 =?utf-8?B?LzBlclZXeVJBczI5aHZWeklOTEptUUJwYVZHZWt0U1BvL1kzM2hhMytibjhq?=
 =?utf-8?B?b0d2bm5NbnhYQ0Q3eUxvSGFFRG5UeitzUmRUSEdrQlRDSzdDaHA3SEVXbVow?=
 =?utf-8?B?RG5lUERVZzkzV1M2MTZndkpMWmoxUzdzMlBCc2pUTktMSElIUW1oZ3Q2R0xW?=
 =?utf-8?B?OEpKMkttQUJNaU92dWUwemY4WHBvRUliRTBsYWlMZ3JZRnpDUlA1NURKNTVR?=
 =?utf-8?B?UDlONkp6OGtDMFN3YUpTU2syci9JdFR2ZmM5NXJIK0d6OWY5NUZpMVZRYzVk?=
 =?utf-8?B?T0pSUEdBN0xrWmNDSDczcVZnUXF1S3lFb295cTlhNkxQYnJCYlBTN0VoT3Zj?=
 =?utf-8?B?ZU13Lzlwdk1LQVhBZUNLRFdZcTlvd2FlTmhnOEFYNzJLZHBHcGh6QVhaZlAr?=
 =?utf-8?B?V1YwK0ZiUmFqZjk4U2kyK3RJYTB5dXEvejdLc3VFZnZUR0dRQzIyckdTTGRQ?=
 =?utf-8?B?NE13UGNCUmJJcVlqZjgwYUdKdjZ3d0dXTlhzSzMrMStpYXJRcjRnM2hJbnlS?=
 =?utf-8?B?UlhKblBtbTg0aXNaaGw2cFZ3by9VQ0JzSVFtM2NQTUNVa2ZQK3NmYkVZTUFz?=
 =?utf-8?B?Sm9ibTJUWHhZb2tsanpBdHhQaEVaTnZXVDFoYXgweUJwSm8zc05weWhEckM0?=
 =?utf-8?B?OHN4RXFtTHV5SHdxOXlCcjhLcnBnSkpCK2wrRWIvbzhvQkVvWWVCaVprdisx?=
 =?utf-8?B?bU1tM08rV3BBVXZQWUtMbUF5d2d3SWRUZXhDVEpobWsxbVBqY1gvQjFLcERq?=
 =?utf-8?B?czd5VTIxb2E1ZzErQlhNNUFMWVJzak9Xd0VpbXB5Z1dzbzZIaUUrSnBqeHZV?=
 =?utf-8?B?ZHd1Z1Z6UjRYbEt5a3B2aktHWGNvMjlFOURZOElkbExoN3Q5SDhJRHZhemMy?=
 =?utf-8?B?dzdoMk95RWVQazVxNWFiSGhTZU5YSDkwNmpiSVBORzcrWlh6QmhyeS9NRDJF?=
 =?utf-8?B?QURBZWI5eUdHSzNhN0kzU09NMkk1WVA5TFBnSUVsSXNPamFmdC82aFZPV1pR?=
 =?utf-8?B?MEFjdnZKV3QraWo3VjNpYWtSZzBqdm9NWVZmYVpaSWxyUkJsODYxY2I3SExV?=
 =?utf-8?B?cjVLbDhJV2xXbWtMdjJ6WkE1REorcjVhMllUUEtCbU5OZVg2OGlvbmlCM1o5?=
 =?utf-8?B?YkYwM3UrOU1qQU0zaitkbzlXRjBBeXp0NW9RS0ZGTERnSldrcTAvcGVOaklR?=
 =?utf-8?B?QUlueE9aWGRuQ08rMjBBcnE0RjJ3N1JtUVllZE5ZcTRxVnRMR0V5T3UwL1Jl?=
 =?utf-8?B?dmdUTnBrOEFHQUhHOFppVUJqdEJVbW4wMzA2bmU0RHA4MVFTSGpKSWEweVBt?=
 =?utf-8?B?bTdqdGwxRkhDQzMrZ09mTVZaMHRENTI5eEdJdTA1SVNtWE8rOVFDdWp0UjlU?=
 =?utf-8?B?cXFKeDRqeDllNDRhYVo4Ui9YTk15dWk2ankzYXFSakhxUVRpbzhCbktycW1E?=
 =?utf-8?B?L05CWG1LTnU1cE9KUGZwME51TUhZRHVhUndYNC9jaDc4NC9SMEhtd25nMCt5?=
 =?utf-8?B?a2Iva3NZbFEzaHhXMHBiaStPU1FNekNoaFNtQ1oxS2pFbng1WEs3amZlS0lW?=
 =?utf-8?B?aXJxeDEvS1J3S0Evbm8rSU9SRERpWXpFcWtwdzd3SFg0R2NGeEU2dTdxVURz?=
 =?utf-8?B?TmJJbDlmaTlRRklTUW5FMld0MVN5R2ZkT0grN1U1bVhQMG84bWRUa0w0Wkl6?=
 =?utf-8?B?N3RlY1NDSERZeW9Bc1FmSzZwUXNYWGlaNnpvVTNqb092YTFHaXlienJnZ3hs?=
 =?utf-8?B?dW9jcDYwY0F2bllIa3VvaVJTc2U1RFFCcGIrVEN4Rjl0QU4wdGdiakFrVlRq?=
 =?utf-8?B?U0NFbDBKdE95WVRhYnpZM1J3QWZYdS9LQWEydjlkVGhSL2hNemhUdVdMSEEy?=
 =?utf-8?B?NGFaRDc4ZnFleGkrVnc2cFc1Y2RxNDVzVjBZVmxXUWlmT3U2OStOQ3o3cUls?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA5D65B586A9A5448FD42E27E38E1365@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4839.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3fe8eb-7adc-4f2d-6a4b-08dd03f737fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 15:24:08.7610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgKauy2IOl6atV3lPsMyqhdF5vAx011iT1vX/KITi+6/WOzF2UIrQRLAsvvkcO+quG8U8SMlDY3O9WC6uKIrEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4884
X-Proofpoint-ORIG-GUID: dkBtWxuAFe3o96YZ5GPBa8BAV02jxAFY
X-Proofpoint-GUID: 1NrIjz6fFxeuIOtsWnb09s0w5d1e9daZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130127

DQoNCj4gT24gMTEgTm92IDIwMjQsIGF0IDg6NDfigK9QTSwgQXJuYWxkbyBDYXJ2YWxobyBkZSBN
ZWxvIDxhY21lQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gRnJvbTogQXJuYWxkbyBDYXJ2YWxo
byBkZSBNZWxvIDxhY21lQHJlZGhhdC5jb20+DQo+IA0KPiBUaGlzIHJlZHVjZXMgdGhlIG51bWJl
ciBvZiBpZmRlZnMgaW4gdGhlIG1haW4gc3ltYm9sX19kaXNhc3NlbWJsZSgpDQo+IG1ldGhvZCBh
bmQgcGF2ZXMgdGhlIHdheSBmb3IgYWxsb3dpbmcgdGhlIHVzZXIgdG8gY29uZmlndXJlIHRoZQ0K
PiBkaXNhc3NlbWJsZXJzIG9mIHByZWZlcmVuY2UuDQo+IA0KPiBDYzogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IENjOiBBdGhpcmEgUmFqZWV2IDxhdHJhamVldkBs
aW51eC52bmV0LmlibS5jb20+DQo+IENjOiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+
DQo+IENjOiBKaXJpIE9sc2EgPGpvbHNhQGtlcm5lbC5vcmc+DQo+IENjOiBLYW4gTGlhbmcgPGth
bi5saWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IENjOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtl
cm5lbC5vcmc+DQo+IENjOiBTdGVpbmFyIEguIEd1bmRlcnNvbiA8c2Vzc2VAZ29vZ2xlLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQHJlZGhhdC5j
b20+DQo+IC0tLQ0KPiB0b29scy9wZXJmL3V0aWwvZGlzYXNtLmMgfCA0MCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRp
bC9kaXNhc20uYyBiL3Rvb2xzL3BlcmYvdXRpbC9kaXNhc20uYw0KPiBpbmRleCAzNmNmNjE2MDJj
MTdmZTY5Li44M2RmMWRhMjBhN2IxNmNkIDEwMDY0NA0KPiAtLS0gYS90b29scy9wZXJmL3V0aWwv
ZGlzYXNtLmMNCj4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2Rpc2FzbS5jDQo+IEBAIC0xNDIyLDYg
KzE0MjIsMTMgQEAgcmVhZF9zeW1ib2woY29uc3QgY2hhciAqZmlsZW5hbWUsIHN0cnVjdCBtYXAg
Km1hcCwgc3RydWN0IHN5bWJvbCAqc3ltLA0KPiAJZnJlZShidWYpOw0KPiAJcmV0dXJuIE5VTEw7
DQo+IH0NCj4gKyNlbHNlIC8vIGRlZmluZWQoSEFWRV9MSUJDQVBTVE9ORV9TVVBQT1JUKSB8fCBk
ZWZpbmVkKEhBVkVfTElCTExWTV9TVVBQT1JUKQ0KPiArc3RhdGljIHZvaWQgc3ltYm9sX19kaXNh
c3NlbWJsZXJfbWlzc2luZyhjb25zdCBjaGFyICpkaXNhc3NlbWJsZXIsIGNvbnN0IGNoYXIgKmZp
bGVuYW1lLA0KPiArCQkJCQkgc3RydWN0IHN5bWJvbCAqc3ltKQ0KPiArew0KPiArCXByX2RlYnVn
KCJUaGUgJXMgZGlzYXNzZW1ibGVyIGlzbid0IGxpbmtlZCBpbiBmb3IgJXMgaW4gJXNcbiIsDQo+
ICsJCSBkaXNhc3NlbWJsZXIsIHN5bS0+bmFtZSwgZmlsZW5hbWUpOw0KPiArfQ0KPiAjZW5kaWYN
Cj4gDQo+ICNpZmRlZiBIQVZFX0xJQkNBUFNUT05FX1NVUFBPUlQNCj4gQEAgLTE3MTUsNyArMTcy
MiwyMCBAQCBzdGF0aWMgaW50IHN5bWJvbF9fZGlzYXNzZW1ibGVfY2Fwc3RvbmUoY2hhciAqZmls
ZW5hbWUsIHN0cnVjdCBzeW1ib2wgKnN5bSwNCj4gCWNvdW50ID0gLTE7DQo+IAlnb3RvIG91dDsN
Cj4gfQ0KPiAtI2VuZGlmDQo+ICsjZWxzZSAvLyBIQVZFX0xJQkNBUFNUT05FX1NVUFBPUlQNCj4g
K3N0YXRpYyBpbnQgc3ltYm9sX19kaXNhc3NlbWJsZV9jYXBzdG9uZShjaGFyICpmaWxlbmFtZSwg
c3RydWN0IHN5bWJvbCAqc3ltLA0KPiArCQkJCQlzdHJ1Y3QgYW5ub3RhdGVfYXJncyAqYXJncykN
Cj4gKwlzeW1ib2xfX2Rpc2Fzc2VtYmxlcl9taXNzaW5nKCJjYXBzdG9uZSIsIGZpbGVuYW1lLCBz
eW0pOw0KPiArCXJldHVybiAtMTsNCj4gK30NCkhpIEFybmFsZG8NCkkgd2FzIHRlc3RpbmcgdGhp
cyBjaGFuZ2UgaW4gcG93ZXJwYyBzZXR1cCBJIHNlZSBiZWxvdyBjb21waWxhdGlvbiBlcnJvcg0K
DQpDQyAgIHV0aWwvZGlzYXNtLm8NCnV0aWwvZGlzYXNtLmM6IEluIGZ1bmN0aW9uIOKAmHN5bWJv
bF9fZGlzYXNzZW1ibGVfY2Fwc3RvbmXigJk6DQp1dGlsL2Rpc2FzbS5jOjE3Mjg6OTogZXJyb3I6
IGV4cGVjdGVkIGRlY2xhcmF0aW9uIHNwZWNpZmllcnMgYmVmb3JlIOKAmHN5bWJvbF9fZGlzYXNz
ZW1ibGVyX21pc3NpbmfigJkNCiAxNzI4IHwgICAgIHN5bWJvbF9fZGlzYXNzZW1ibGVyX21pc3Np
bmcoImNhcHN0b25lIiwgZmlsZW5hbWUsIHN5bSk7DQogICB8ICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQp1dGlsL2Rpc2FzbS5jOjE3Mjk6OTogZXJyb3I6IGV4cGVjdGVkIGRlY2xh
cmF0aW9uIHNwZWNpZmllcnMgYmVmb3JlIOKAmHJldHVybuKAmQ0KIDE3MjkgfCAgICAgcmV0dXJu
IC0xOw0KICAgfCAgICAgXn5+fn5+DQp1dGlsL2Rpc2FzbS5jOjE3MzA6MTogZXJyb3I6IGV4cGVj
dGVkIGRlY2xhcmF0aW9uIHNwZWNpZmllcnMgYmVmb3JlIOKAmH3igJkgdG9rZW4NCiAxNzMwIHwg
fQ0KDQpCZWxvdyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUNCg0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Bl
cmYvdXRpbC9kaXNhc20uYyBiL3Rvb2xzL3BlcmYvdXRpbC9kaXNhc20uYw0KaW5kZXggZGY2YzE3
MmM5YzdmLi5kYTIyYjZhYjllY2YgMTAwNjQ0DQotLS0gYS90b29scy9wZXJmL3V0aWwvZGlzYXNt
LmMNCisrKyBiL3Rvb2xzL3BlcmYvdXRpbC9kaXNhc20uYw0KQEAgLTE3MjQsNyArMTcyNCw4IEBA
IHN0YXRpYyBpbnQgc3ltYm9sX19kaXNhc3NlbWJsZV9jYXBzdG9uZShjaGFyICpmaWxlbmFtZSwg
c3RydWN0IHN5bWJvbCAqc3ltLA0KIH0NCiAjZWxzZSAvLyBIQVZFX0xJQkNBUFNUT05FX1NVUFBP
UlQNCiBzdGF0aWMgaW50IHN5bWJvbF9fZGlzYXNzZW1ibGVfY2Fwc3RvbmUoY2hhciAqZmlsZW5h
bWUsIHN0cnVjdCBzeW1ib2wgKnN5bSwNCi0gICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbm5v
dGF0ZV9hcmdzICphcmdzKQ0KKyAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFubm90YXRlX2Fy
Z3MgKmFyZ3MgX19tYXliZV91bnVzZWQpDQorew0KICAgIHN5bWJvbF9fZGlzYXNzZW1ibGVyX21p
c3NpbmcoImNhcHN0b25lIiwgZmlsZW5hbWUsIHN5bSk7DQogICAgcmV0dXJuIC0xOw0KIH0NCg0K
SSB0cmllZCB3aXRoIHRtcC5wZXJmLXRvb2xzLW5leHQgLCBJIGhhdmUgdGVzdGVkIHRoZSBhYm92
ZSBwYXRjaCBmaXhlcyB0aGUgY29tcGlsYXRpb24gZXJyb3INCg0KVGhhbmtzIA0KQWRpdHlhIEJv
ZGtoZQ0KPiArDQo+ICtzdGF0aWMgaW50IHN5bWJvbF9fZGlzYXNzZW1ibGVfY2Fwc3RvbmVfcG93
ZXJwYyhjaGFyICpmaWxlbmFtZSwgc3RydWN0IHN5bWJvbCAqc3ltLA0KPiArCQkJCQkJc3RydWN0
IGFubm90YXRlX2FyZ3MgKmFyZ3MgX19tYXliZV91bnVzZWQpDQo+ICt7DQo+ICsJc3ltYm9sX19k
aXNhc3NlbWJsZXJfbWlzc2luZygiY2Fwc3RvbmUgcG93ZXJwYyIsIGZpbGVuYW1lLCBzeW0pOw0K
PiArCXJldHVybiAtMTsNCj4gK30NCj4gKyNlbmRpZiAvLyBIQVZFX0xJQkNBUFNUT05FX1NVUFBP
UlQNCj4gDQo+IHN0YXRpYyBpbnQgc3ltYm9sX19kaXNhc3NlbWJsZV9yYXcoY2hhciAqZmlsZW5h
bWUsIHN0cnVjdCBzeW1ib2wgKnN5bSwNCj4gCQkJCQlzdHJ1Y3QgYW5ub3RhdGVfYXJncyAqYXJn
cykNCj4gQEAgLTE5ODMsNyArMjAwMywxNCBAQCBzdGF0aWMgaW50IHN5bWJvbF9fZGlzYXNzZW1i
bGVfbGx2bShjaGFyICpmaWxlbmFtZSwgc3RydWN0IHN5bWJvbCAqc3ltLA0KPiAJZnJlZShsaW5l
X3N0b3JhZ2UpOw0KPiAJcmV0dXJuIHJldDsNCj4gfQ0KPiAtI2VuZGlmDQo+ICsjZWxzZSAvLyBI
QVZFX0xJQkxMVk1fU1VQUE9SVA0KPiArc3RhdGljIGludCBzeW1ib2xfX2Rpc2Fzc2VtYmxlX2xs
dm0oY2hhciAqZmlsZW5hbWUsIHN0cnVjdCBzeW1ib2wgKnN5bSwNCj4gKwkJCQkgICAgc3RydWN0
IGFubm90YXRlX2FyZ3MgKmFyZ3MgX19tYXliZV91bnVzZWQpDQo+ICt7DQo+ICsJc3ltYm9sX19k
aXNhc3NlbWJsZXJfbWlzc2luZygiTExWTSIsIGZpbGVuYW1lLCBzeW0pOw0KPiArCXJldHVybiAt
MTsNCj4gK30NCj4gKyNlbmRpZiAvLyBIQVZFX0xJQkxMVk1fU1VQUE9SVA0KPiANCj4gLyoNCj4g
ICogUG9zc2libHkgY3JlYXRlIGEgbmV3IHZlcnNpb24gb2YgbGluZSB3aXRoIHRhYnMgZXhwYW5k
ZWQuIFJldHVybnMgdGhlDQo+IEBAIC0yMjQyLDI0ICsyMjY5LDIxIEBAIGludCBzeW1ib2xfX2Rp
c2Fzc2VtYmxlKHN0cnVjdCBzeW1ib2wgKnN5bSwgc3RydWN0IGFubm90YXRlX2FyZ3MgKmFyZ3Mp
DQo+IAkJCWVyciA9IHN5bWJvbF9fZGlzYXNzZW1ibGVfcmF3KHN5bWZzX2ZpbGVuYW1lLCBzeW0s
IGFyZ3MpOw0KPiAJCQlpZiAoZXJyID09IDApDQo+IAkJCQlnb3RvIG91dF9yZW1vdmVfdG1wOw0K
PiAtI2lmZGVmIEhBVkVfTElCQ0FQU1RPTkVfU1VQUE9SVA0KPiArDQo+IAkJCWVyciA9IHN5bWJv
bF9fZGlzYXNzZW1ibGVfY2Fwc3RvbmVfcG93ZXJwYyhzeW1mc19maWxlbmFtZSwgc3ltLCBhcmdz
KTsNCj4gCQkJaWYgKGVyciA9PSAwKQ0KPiAJCQkJZ290byBvdXRfcmVtb3ZlX3RtcDsNCj4gLSNl
bmRpZg0KPiAJCX0NCj4gCX0NCj4gDQo+IC0jaWZkZWYgSEFWRV9MSUJMTFZNX1NVUFBPUlQNCj4g
CWVyciA9IHN5bWJvbF9fZGlzYXNzZW1ibGVfbGx2bShzeW1mc19maWxlbmFtZSwgc3ltLCBhcmdz
KTsNCj4gCWlmIChlcnIgPT0gMCkNCj4gCQlnb3RvIG91dF9yZW1vdmVfdG1wOw0KPiAtI2VuZGlm
DQo+IC0jaWZkZWYgSEFWRV9MSUJDQVBTVE9ORV9TVVBQT1JUDQo+ICsNCj4gCWVyciA9IHN5bWJv
bF9fZGlzYXNzZW1ibGVfY2Fwc3RvbmUoc3ltZnNfZmlsZW5hbWUsIHN5bSwgYXJncyk7DQo+IAlp
ZiAoZXJyID09IDApDQo+IAkJZ290byBvdXRfcmVtb3ZlX3RtcDsNCj4gLSNlbmRpZg0KPiArDQo+
IAllcnIgPSBzeW1ib2xfX2Rpc2Fzc2VtYmxlX29iamR1bXAoc3ltZnNfZmlsZW5hbWUsIHN5bSwg
YXJncyk7DQo+IA0KPiBvdXRfcmVtb3ZlX3RtcDoNCj4gLS0gDQo+IDIuNDcuMA0KPiANCj4gDQoN
Cg==
