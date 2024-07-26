Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A957176235;
	Fri, 26 Jul 2024 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977622; cv=fail; b=V09RKPXT5svFNYn6deLIwVqvXxPXiaBYFT/YnZV+UZdsdjGujRaMy8KLl+TntZZ/kS0/yH9NYT4EymR8ifnb3Kijo19U4YxHJKACXPHSvMWYxb/kB+yrZXm06OjErcN6e8Vi85PFZrm+HT9HZZjuZTF7XOFvdYTMSl6iXxybhX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977622; c=relaxed/simple;
	bh=ycKcmrD2qsJSg6Tj181b6wptyMEAyMlByilrTPsTX4Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b0QLEVl4uPRFKN0BKzuUe4PDG7oNtph9wfFJ4JHlfnzuObOrZyBb5eUGpZb1Dqo2Zf7SNsurRZtCZEJ7eN3zcaHo7yPV6HQjOhrW6Xu2N8rWKVqKLmZlzDcxpHbqIKhA1PtUJl9WIRe51n0UFQLGOvqC0x4tgBkLYBpx9N4Ri8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TuipxlOC; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TuipxlOC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL1SEunz1D6xe34ZYEJSDcuQE8Ty9Ox5iyD9T3D8aXbWFxTQsEqKos7ShyZwulUDrFafwH7uIB9O4POA8rFTC0JsozGo58hCXmDPZVUnSkJo6S85mdEZKQTqPSmxaeqckHyLOFKFELSiVaGpSuUN5lUpXQOIQozPgYQtebOcQYxpA+iNcqGu1u4rUupzm8j05J3Y/pmRDllSQc3Gxp/d26XRcdlb3Vkt3gIMoeTNAohHLPgw9mcAYDD2jPuE0BSbcMC2szDGszj4NmnXozheeeTj+vG4aHm3bKDbT9Sacr8b7H356pHEzF5cFNiu1vjEI/C/suqHwkQ0O0A9lAuPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVt7q71c/zkZFQNmDW7tuOaMB++LQU5vjzXjX4Rp1TE=;
 b=jar6CfTb/8qaRYNEb+lPtm3YH+28m2tUP+4hZmjLX4awLkSPyxdUITO3VkHF1gw3jwegnAwlArFx7sfUOl2HrkXzjS6lGt4prEkRCU+jQlJ0pAeF9IvdtU0xZkP4VMeX7KwrIijAOUoiLLZfHnqWMQLL+fymkF+YoaM6CVQb+XAYuPr0Hgl8pYP2omXutyXuXwlikuI18TAQUsLJ9c8gLvQ5yDknMgRFs0msy9HcCWMwhC6GNE1T1RtwIBlDiHMYdPta2DovbptfxJA118LOFEXpj8YQ6Pwk1D+4NBWrgsJnYIt9F/K+7hCSUsEulzLcFY9Ef11GTNjDKBzKbCttMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVt7q71c/zkZFQNmDW7tuOaMB++LQU5vjzXjX4Rp1TE=;
 b=TuipxlOCDXmjmnF8wAf/iWJUN1A0AJlQSHBqrgFQgS97EfGMFEAGNpk7Bz6fQESjN08MQlqPymdNI91VBBQXNpie0TwpzpTiyqU9rQsi2OERn2vbD3AgmxR+srw49vr3sdOPhVaKuuaustGlG53b+hexW4+T5PH+lTJrs1F6YVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 26 Jul
 2024 07:06:56 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 07:06:55 +0000
Message-ID: <c4b499a5-7d2a-44db-bd0c-c123417337a5@amd.com>
Date: Fri, 26 Jul 2024 12:36:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in
 sysfs
To: Ian Rogers <irogers@google.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
References: <20240718003025.1486232-1-irogers@google.com>
 <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
 <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
 <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com>
 <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
 <e8872317-8e18-48aa-9f23-b98af9345bed@linux.intel.com>
 <CAP-5=fUjEYwdOdmfa5N7b8OOLWDitJKBdeOr8-+UOYWA5+ehkA@mail.gmail.com>
 <775d8f1d-437d-47a3-b4b2-da476e914cf5@linux.intel.com>
 <CAP-5=fUH+n+f_q1Tc-a3oV3vDV60VGOLANRFWUemDen197rYog@mail.gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <CAP-5=fUH+n+f_q1Tc-a3oV3vDV60VGOLANRFWUemDen197rYog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: f64a6edc-639d-45b2-f0ac-08dcad41886f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDBGejFGb2dzb2FEaWpMcVVnbWNjcHBBNWxiWWNER0dmdVJsMkNHTTlvZ2dy?=
 =?utf-8?B?d05HWTVkTjNMVkJkMzg0dDZ6SnZ6em9zaE1XSnR5MG1vVzJtQjJtRUROMXgw?=
 =?utf-8?B?ZXd5aFNNQzZoSjF6RTZPaFI4SEhzVVhSZGNOb05WcllKdzdEMFY2bVNqUWls?=
 =?utf-8?B?MFBUOUQzQk1sM1FSREFwcHNCdkdyVWFZT3F5WHIwNC9hcEZpWDBYaHJpZ01x?=
 =?utf-8?B?VXhlYyt1ZnJSWTh2T1puZzlEeWR3MHhUOVU4YW5vNTZUTjBtQWhIWnNJY0Uw?=
 =?utf-8?B?azkvdmdLdFZ2MStVRC9IREtraktheEJwdUplQlhQMXlYUUlVM0V1TGs1aFBw?=
 =?utf-8?B?Tmc4YVB3cEg2RjJWc2lMUW4rSzFsL29CUzZjOUVaWVVyQXZqUzZkK0lmRTU3?=
 =?utf-8?B?cWIrdklHOEFaUyt0c3FKOFBiR0REVmdUekJkUlJ2dnJIaUx0aHZZOTB4c1Ir?=
 =?utf-8?B?RkF1WnplYSticXNDN08rSnpYZmMwd2Y5TUo3dlY5V1FvVmlDeVE0WDJaWnE1?=
 =?utf-8?B?Y3I1Z2Zpb0F4OGdBdkljMlZvaG9rTk1vRFFTZ21LN2NMSmJNd1p5aENjSWwy?=
 =?utf-8?B?a09aaWVVUHFONjN3M3NvK1lsbGljZEVKRDFjRWRHa2cxcVI4aUY4bUxlRG80?=
 =?utf-8?B?VUI0dUpvRzlKOHAyWGF6MWpYaVF6OXcwOFR2bzBzd084d1hQTHNCK2ZkVW9V?=
 =?utf-8?B?ckhzcXdUeDZCdklUTHRteXUxaS9PUE5uM2JVN0dzU3pjcnVKazBtSE9JZ0du?=
 =?utf-8?B?d1ZDTldXUWpwa1hyd05CRFprODJGcDdKeDFZSEs5Nkp5bm5VczJqemh1T0xr?=
 =?utf-8?B?bDl3aUFtVzZNTG4vRTZPcFd0NHNtUWlWVXpyS3RoM1BWVGtLVFpOeUN6cEN5?=
 =?utf-8?B?bVZaTjVQdXlQSlMyL1oyYUJQdy93RXN4ZExibkNkZGxHdzBMTkhzN1l3ejl0?=
 =?utf-8?B?VkdIdlZDemJwZEhBTFNEK0QvZWVqS0tuR2M5ai8xRko3YjA4NWgvWkp1MHRE?=
 =?utf-8?B?WVJvYUh3SUN0VTdRTkJjVmFmRURBTnowTnJQZnowRFBzZ3g1ai95Z09uVE80?=
 =?utf-8?B?Y2ZtQ3ZFZWRPRmp5TXFqRHN6em5QSUhUZXZ5MXFXV1p6OE13bG1OdmRRcmty?=
 =?utf-8?B?aGNnQ01LWjNHMXRkMmNVTUlDeng5aUFraFhubW1RTUhpU2FEait0Zm5LdEd4?=
 =?utf-8?B?Q21SdGpweDRLUk9pUXZiZHppMVF4d0tob0dxT1RjeDdxejJVNS9sWlVxbGVM?=
 =?utf-8?B?c1ZselpqUTNTQ3dObzcvbnhENXQ5VjBDSi9uUDlNVW0wU1BMdXNPMVpJdE82?=
 =?utf-8?B?dlhDcjdBRTdoT1JvRS94ZWtCOVBYWHZ6eisvTVQrOElhQXd0NUhCSW5nNGFS?=
 =?utf-8?B?L24zQTN2UC95M0JQQnhUeTNxTGRLWVFKTHI4MEEvVFUzNS9vSlh2VGs3a0J3?=
 =?utf-8?B?cHc0MkozTEtURTYyV0lvMzBkY3FyaThNMlNmcDF2V0NTT09Fb3krZWNWZVg4?=
 =?utf-8?B?RnE5WUF5dFdsMXNMUkI3UHZ5NHNqU2orLzBBT1lIM3RJcFdwbmovUkQ5djlY?=
 =?utf-8?B?V0VzL0R4Uk1jQkFRVmllRDhwb2xGcWI0V25sR2t0cFBJVytYblUwWWJWM1U1?=
 =?utf-8?B?WFZjWEFGM2FNVC91WkxGa0p4Z2Z5UlpLdW9yS0E5NkFiUmxYWVlGWm1hTDZu?=
 =?utf-8?B?SjdHbVJZYnNhN05UMDV2SEcwbzhid3lqeEpTaXlxb3BKdm9VY1ZGKzdNR3lQ?=
 =?utf-8?Q?pAlAHB+cG8z9oWGpkmTKgAB8OqAOCL31nqoyv/e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmpJcmZPeEVYTkZMVmxWT1IwUm1CNndCVHFzRUNGUGVZQTlGYWt4YlQyZm4z?=
 =?utf-8?B?TXNEWkFlY1pabVllK0F3eFdlcHd4Tk9KalhGdDFFM1pvL3JoN3lYWUU5Rjho?=
 =?utf-8?B?VnYwb05za0h0aEIzd1U2dXBhbStSVmNLdy9TWHY5UERvRG5nZysydHpoSUpG?=
 =?utf-8?B?eThPclZTZTFENDlkUU11S2oxczFoTFl0TFo4aUV3dGQ5UkZlT3pRRVhHZ3hE?=
 =?utf-8?B?TmVWajBFSm1VMkRLRFM4Rkx6c0RDWkpxTXR0MWpPZUVyZGpVTmhNQXNBQU9R?=
 =?utf-8?B?d2JPTmZCZ2N4VlhWQjBXUWNFOHJrc2JLcWJCVTlYam93Zll4ZTFRS0N5aGRG?=
 =?utf-8?B?cmlJUkIxNXJaZHNUUTJqTG02YUtCcEc2Q0YvUkJ5Yk5Ya244cTNTMVFtbVZL?=
 =?utf-8?B?N1EzSHp4NFRZR3IwV2ZPOE9CUmhVRVlIS0ZLRnFURkROcDJHaHdGUGFnc0p5?=
 =?utf-8?B?d2Z3eXJ0V245SE4rcXNZVUc3dUlKUEoyNEM0ak5Uc0xXWkpLWC9BR29LLzZt?=
 =?utf-8?B?UmticzdOK0xSL1JZc2VrSmN4MHdHd2VMbVFQRWlRVkZxMXRGS3NuYVdmeitG?=
 =?utf-8?B?Z1kyOUNPUVFSK1E4WnFnUy9vMndLeFFiNElUaDlDcm4rS28yV09lV0dpSU5z?=
 =?utf-8?B?YldkNUpTQ1BxcC9sWXBjTFhrMkdTOXQrMFZpalNBSlFISjBka21UdkhhazYw?=
 =?utf-8?B?dmY0Vi9Eb09UWDRFZ0hXUWoreU0zQnJPdmZQZyt3NkR0NnBoQzVBWkF5NmZS?=
 =?utf-8?B?NDY4WmgzalhQT3Y5bi9GZ3RTTDZCMHpxMTBVampxMHQ3MjcrNjhFNFVGYVpW?=
 =?utf-8?B?blF4NGZsZDRLQ3BsYXl6N0pIaXUzQ3FzSU1lc1RXV21qeW9UYnh2TWVBTUpI?=
 =?utf-8?B?YTlzSFdIRFJSSEFReGVNREdQYlNoU0dRMFVXL2FyZnMvM2ZKQURRZ0lNV0Qw?=
 =?utf-8?B?OTRvaXdjVEpmUjl5UUxuT0FuL1p4Q0RKSHE1L1F6SDJZbkhpQ2xEbW1oNzE0?=
 =?utf-8?B?TFVSY21NNWwxeVFydzJMZzhrT3BaZXViOHJldnVZLy9UdVVOWlgxZWo2ZWt3?=
 =?utf-8?B?MjR5eitKcUdXejdDNy84UDNrUHYwUjhzbklnaDFrQzVHSWVHYU9wSWtrNVJt?=
 =?utf-8?B?U2Nia05nemttZlNXazNFQjAzMnN4ZFNKVkE4aERnTUVEdGRKRHdsL2pBbjB3?=
 =?utf-8?B?TXV2bWJaT0ExK2tKMXM3N0h2eFNZVDdrZjVEOGllUVcvdjlXK0NpajV1ZDd5?=
 =?utf-8?B?TzZoRUlHNGN0L1VZVFNIc1hXczVhbGtjWlFCRlRFQU9BMmVRb3hPL1V0M3dN?=
 =?utf-8?B?SElWK1k1Y2FxZmlIQTVzNENtWEMzQzRZWWVvN2R0ekMxSThHR01icVk1NTM4?=
 =?utf-8?B?VkdZUUpERVp0NnJjV240ay9hTEZZNjJ4M2hsRWVGdjNlZVVYM0t3bzYwRTRY?=
 =?utf-8?B?emVEUHZ3bjkwc1RDekNOSGZEa0ROWVk1bnErSmhKUjE3S2IzWkRndDhWaTRI?=
 =?utf-8?B?QktCZ0FyNm9rb0hrYzNGOURlRWx3UWJsbTdnQ0JmRzdNRFdMdUcwWEZTQWR4?=
 =?utf-8?B?ei9VWllRNHZ0d080OXNJVW50MVRYdU8ySWFZWnZObDIySGpFZG4rLzFvYkFq?=
 =?utf-8?B?ZVJxWUVRYTkyOFZNVDF4eUtUMHYxZEhMcTlNSU9lTGpET08zV0xtTG1DWkdk?=
 =?utf-8?B?V2d6SVJIa045T2h0RVErTlg5bGh4K1dPS3pBbDRicVBidXcwT3dyWkUwZW40?=
 =?utf-8?B?TFQvTVJVUUJaR2JMU2xhTnF0ZWw1VGRLSFFYL3FHSVEweXY0OXczd25XSW9k?=
 =?utf-8?B?KzlRM1B3Rk16YW9xcGREd21XdnQ4YU1jekpKTG8vOTZ3elRnZFpOL3JNZTk3?=
 =?utf-8?B?RW1vOTF0dFFQY0ZEQmxNbGRFc3RuT3BUTWNLUVdnS1d0ZzFQeUw4K0xnMVMr?=
 =?utf-8?B?OUozNmY3cGhlMkZyYmk5eVBFWVFDNDJHL3ZzZ1llUjc5WklWeklNdWhsZEpE?=
 =?utf-8?B?ajdIRUdUYmtOSHdCTmlOclZieklnMHVjN0pYNHJ5dDRjZ3RIT1RxMmhzQmlz?=
 =?utf-8?B?ckhnQVpiRkhwYkwvUWV3T3h2REt5cUlKYVpKNWMwTndOUDFhaTFsWjJrcHZy?=
 =?utf-8?Q?zKTNOEZBbhA9EdZ4L82z2B6rU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64a6edc-639d-45b2-f0ac-08dcad41886f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 07:06:55.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnrz/ugtUJtG1pNVntKyW8YwSYowMmhBT6Py0y0SiLhVgGx6r7mBTY0S09VR9IEh0jqfEKFizV70ngNhX1vLog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229

Hello, Ian, Kan,

On 7/20/2024 3:32 AM, Ian Rogers wrote:
> On Fri, Jul 19, 2024 at 9:35 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2024-07-19 10:59 a.m., Ian Rogers wrote:
>>> Thanks Kan. I'm not wondering about a case of 2 CPUs, say on CPU0 and
>>> solely its perf event context, I want to know its core power and
>>> package power as a group so I never record one without the other. That
>>> grouping wouldn't be possible with 2 PMUs.
>>
>> For power, to be honest, I don't think it improves anything. It gives
>> users a false image that perf can group these counters.
>> But the truth is that perf cannot. The power counters are all
>> free-running counters. It's impossible to co-schedule them (which
>> requires a global mechanism to disable/enable all counters, e.g.,
>> GLOBAL_CTRL for core PMU). The kernel still has to read the counters one
>> by one while the counters keep running. There are no differences with or
>> without a group for the power events.
> 
> Ok, so power should copy cstate with _core, _pkg, etc. I agree the
> difference is small and I like the idea of being consistent.

So, it seems we want to follow the new PMU addition approach for RAPL 
being consistent with Intel cstate driver, should I revive my "power_per_core" 
PMU thread now?

Thanks,
Dhananjay

 Do we
> want to add "event.cpus" support to the tool anyway for potential
> future uses? This would at least avoid problems with newer kernels and
> older perf tools were we to find a good use for it.
> 
>>> My understanding had been that for core PMUs a "perf stat -C" option
>>> would choose the particular CPU to count the event on, for an uncore
>>> PMU the -C option would override the cpumask's "default" value. We
>>> have code to validate this:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evlist.c?h=perf-tools-next#n2522
>>> But it seems now that overriding an uncore PMU's default CPU is
>>> ignored.
>>
>> For the uncore driver, no matter what -C set, it writes the default CPU
>> back.
>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/intel/uncore.c#n760
>>
>>> If you did:
>>> $ perf stat -C 1 -e data_read -a sleep 0.1
>>> Then the tool thinks data_read is on CPU1 and will set its thread
>>> affinity to CPU1 to avoid IPIs. It seems to fix this we need to just
>>> throw away the -C option.
>> The perf tool can still read the the counter from CPU1 and no IPIs
>> because of the PMU_EV_CAP_READ_ACTIVE_PKG().
>>
>> Not quite sure, but it seems only the open and close may be impacted and
>> silently changed to CPU0.
> 
> There's also enable/disable. Andi did the work and there were some
> notable gains but likely more on core events. Ultimately it'd be nice
> to be opening, closing.. everything in parallel given the calls are
> slow and the work is embarrassingly parallel.
> It feels like the cpumasks for uncore could still do with some cleanup
> wrt -C I'm just unsure at the moment what this should be. Tbh, I'm
> tempted to rewrite evlist propagate maps as someone may look at it and
> think I believe in what it is doing. The parallel stuff we should grab
> Riccardo's past work.
> 
> Thanks,
> Ian
> 
> 
>> Thanks,
>> Kan
>>>
>>>>> 2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snapshot)
>>>>> files parse correctly and have a corresponding event.
>>>>> 3) keep adding opening events on the PMU to a group to make sure that
>>>>> when counters are exhausted the perf_event_open fails (I've seen this
>>>>> bug on AMD)
>>>>> 4) are the values in the type file unique
>>>>>
>>>>
>>>> The rest sounds good to me.
>>>
>>> Cool. Let me know if you can think of more.
>>>
>>> Thanks,
>>> Ian
>>>
>>>> Thanks,
>>>> Kan
>>>
