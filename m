Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654EA199FD3;
	Mon,  4 Nov 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707488; cv=fail; b=Q2DVVaWOVzyQyQs0LJ/G+b2epwYH3l1UkMqMrJf148oBRMRFmS0cxnr9YYlxrfm4sX4bEyBaiVCIT4P3E8MAXtAkpqoq3YWqH0Dk6ROliT40itCo5i8/9XbXht/Te1jr0Xr4Gu45nFOabB2CNXCSxM22EVRgd9ceFU6TlTldAX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707488; c=relaxed/simple;
	bh=6lq5l+6ZB+KDAiONNHKZWsiDwTynV5+KSatue3uZFp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ENLEG4ZOVtfr90SAaXvtdokB3lLhj9yK8/fHOd58v3zum8pNLa7j3PDOsLACHwXd39RL6TIhJLquUROW8/Vc0irLS7mjh3Rtj6K6y7AAQ3piZw5C7P8OsKaeXwTriB3vEuvqaI/JrHg+aqOkWvKO08GiZdJjgVlVGdsHTSwSVVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=taamQ/fm; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="taamQ/fm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPuNRr08hlEgnqqp9t8XzHmttW2LnGA/zYF6g6lXceMiVzs6Ithckp4J1hnvQU7o/T1QA8IsHaVZAuxRbbawnt/BvxSBaqH/ufSyoFWjRAYNQOHCk7RMUK/M8fBlrPZJKJkcvhQC7evJpW2yAxNG05AdXeBUbUbUqUIvZPab2n6WgMboVrsfZsuDELW2tZRQoN1Bxzzr4CICFG9Z2AGT2oqSAKmfkfls+SFNrooHBxw4BCDhl5ICJW/K+78MQL/p1VudUxcKx1l1u5H0/g5CJFdjfK9fLugwpadORPpFYwLqttFMgqMMJ/dKD5Gz+nZk+W4XSMnhjaJLpHOnt+gA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl/rriJCdfkF09CJMvqUTjOm+A0jJ751WsLAiuKj9vo=;
 b=DlTED/YPKoYEI5AaN28TOcI5nTM+KEQm8/qevv25gOtMWlhZ3a913RfScVBViCU+SuMbSG/3bSKF+xEaels9HW2EGjiWyF76y5CyqW/RWxShNweBfx4JdIUOoM+mpWTSFWWKxs44fDn5dQGFpR++YpHnT2ay9QM9Fhe8TrcygBCjOekQxSjPoff9YeXnIZeg82smux8KHfho1nX7Lbvp+WYapWXzwxnzopvE9/pAotr9eYlbKc0o797zd4vmkus+eolOWct9iBdaduGOGDpI7LrOSjtNuICF9P3BxSEApom+mbkxgv4p18tDPFRwnhc3QMqQsCszAFdj2afPjBGosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl/rriJCdfkF09CJMvqUTjOm+A0jJ751WsLAiuKj9vo=;
 b=taamQ/fmW68av+LNF27ZLebvEjyzLKyQ6j9l3083Uou0M9Nd23PYlD/NcMk1hjGfqzYo3GxF8KoRZOcWpvDf9lqfOyvv4G230KdYHLLhwy2fzlAUv4tk1Y8JPM5Pqu18gw+AMMyG+/4PH+YSSrmZYnZZMxZIH9MXeGic0euhC+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:04:41 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:04:41 +0000
Message-ID: <e6ee937c-f72b-4a04-acba-b00784414603@amd.com>
Date: Mon, 4 Nov 2024 13:34:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu()
 function
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
Cc: "alexander.shishkin@linux.intel.com"
 <alexander.shishkin@linux.intel.com>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "irogers@google.com" <irogers@google.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de"
 <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>, "x86@kernel.org"
 <x86@kernel.org>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-4-Dhananjay.Ugwekar@amd.com>
 <Zx9RHtFAURrORTrd@BLRRASHENOY1.amd.com>
 <52e578d0-a885-4d6c-836d-fc3ec0f491b2@amd.com>
 <2884838e95def2a0ca3d2c263de10d9aab991501.camel@intel.com>
 <2fd6bad3-cb37-4a4a-8b47-d7c2ffc96346@amd.com>
 <d92fbaab082180740baa7a1ade0edaaac51e005b.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <d92fbaab082180740baa7a1ade0edaaac51e005b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: dff4068b-2e7e-4a88-f763-08dcfca75603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEpZQTFkRkh2Sy9iWVY5bFU2SEpQM0Z5aU8zYWY2TjVwbE11YVV6dEsweSs2?=
 =?utf-8?B?YS9ab2h4YU9kZ3V0Y0c0WmlQQkVrSXdUajBQU0Z0alUvbGZ1SlB0RWo1dFhL?=
 =?utf-8?B?VXFRcVEyVU1zMnZnR0JXM2dmV0FJVDFYZEZLNkc2aW9WVmtqcGtCRGJGV3o1?=
 =?utf-8?B?NkV5ZFplVkJwNFZ0VmpJWVBLN0V6M29SaGpjV2RvRHQzdHNhMDJCaWVjTG0w?=
 =?utf-8?B?bFFxRll4UjhlajVHaFZkbE1QbHgrWTYrSXFUT1IyZEFINGUzKzM4Z1ZJeXFE?=
 =?utf-8?B?NmsvbVRBUDd2OGNkNHRIY3JMMEtOd2kyRmFjbFlySGl1WkN3d3h1VjBBTDJY?=
 =?utf-8?B?a3c5QXhmbVlnVmVnbmZEWFpnWU93MjJaQWl6ZjRaSy9qQk14aE5BMTQrRC9J?=
 =?utf-8?B?WVpNTC9Kd3JWTXk4NEo3SFU4T2lwM1JVR1lvaEN5dFYxL2JNcFZ5aGNxRjNV?=
 =?utf-8?B?Nm5NbkU2ODA4SFdrY0lMQkZiSEY0OGtwT1pJQnBZOUJiTURaV2VSSHd4ZEFE?=
 =?utf-8?B?UnFJUDFwVFdYcFFKKzZsSURkVVgvRUc1UllNczZBWWtVV2J1cFdvbnJ5bFdC?=
 =?utf-8?B?SEdzZ0ZHZUtkQ25KaWp1a051bTE5Ti83cmdHT2VKNUM3ditNc3JxajI0UEJR?=
 =?utf-8?B?alBuVEZpWlhPVVlRRFA2Z2RXYmRYWVovdHNpNlVRT2N5dDl5TU9JTkc1UGJn?=
 =?utf-8?B?UkNVbEdRZlgrMXB1UnhybFR4dEQxbzJoVWE5OWlnN0RqQm10eit5VUkzQzFw?=
 =?utf-8?B?SkZoaGtuSDJFWllMcmVQanRMSDUyUVNVS1hjWXhucW9WVklTeXZ3UFU5aHZX?=
 =?utf-8?B?UllLMFlCSTVqYnhNNnNzQjdWckU3RlI2RUQ1Z1Z0YjQwMHl6L3k4VDhiNVI2?=
 =?utf-8?B?ajZKMlJzMktJbGhMR3kvblkzZVVEWXpLOUFCOXdWMFdWbUVqbjJud2Q0TGta?=
 =?utf-8?B?WFZwblVuckpMbnNXNjljWVloSTE1MEs2YlAzUjBYT0ZHZ2VJQnZZL2x5Y2Z2?=
 =?utf-8?B?VlQ5QXNBQmdEdjNrbXpreWRuRFdFL1ZYRW5zZmgrNjZRWVVpUVlIL3FzYkJT?=
 =?utf-8?B?RzNPeHFRUFhpRjd6bi9Wd1lkMFVPUWx3bmxzRVVQVUd3U3VpdURwVUVkVFMy?=
 =?utf-8?B?REFPckdiQUJNMlFlQWl5dXY5Wmd5Yno1bFdzWm4xYzcwSVdSU3NLUGpsdkVw?=
 =?utf-8?B?RFVGblk2dG1IR21DMTQxZ3JTdndibUxQc0o4QlhJbzZRMHhuV3Z2SW1oM0k4?=
 =?utf-8?B?MTAvV0hlbHZKR0hJWVRQbFVOSHIxOEczTE55ellaUFl4UytSQ0hDQ0JVaFFt?=
 =?utf-8?B?Yy81M0ZQRmNoZVB0YkZiZXZrc0dmRTl6a2ZBVHJiWGdRd2hzK3NkRXV3SWFo?=
 =?utf-8?B?U3NiM1RvK2NaNnRsN3RMZ01lbFdacXl6RUNKOXNBUzFWeXhFblJ3dDlnVENk?=
 =?utf-8?B?V2owLzFIZG44dEk2RHI2NVVseW1Ud0Y0Q3ZuWVlwMzB5ZUR2L25hblh4eXBa?=
 =?utf-8?B?elpVdlZOZklxcVJWWWJ6N0pNaGJRblNGaDhESW1peTUrQUNUdWdPR1dMamNH?=
 =?utf-8?B?bmVDY1hiTHp6VDloM2FnK3dSYXRUeXhZR29ZZkx1ejVaYmlscnlDdTRIekE4?=
 =?utf-8?B?NC9TVjJBdTA5UTJMMXkzU1gza0djN3IvVVNyR3F1UnQ5cHBiYmhyS0IyN0pC?=
 =?utf-8?B?disrVWh4Rm5JWHV5c1BhbXpXZkVkaUdHOFdOakNodjZLNnRPeVYrd2gyNjR0?=
 =?utf-8?Q?sDbVs5lNs+89lhvAio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TCtic0Y2SXhsREMxMmt6U1pVbnZNMy9sem5uczl0RVVqeE5EeFB0OG16dnpz?=
 =?utf-8?B?cGowWkloc2toa3VJT0NIcnZkZkRaVjVmRnBpekx2Qk1pZzV2d0ROU2dyVFp5?=
 =?utf-8?B?QmtRNFdNcGYxd0xwNkh2N3p3TEFoeHhobkdtZ1JNUWF2dm1IYXc5T2pjMEtC?=
 =?utf-8?B?N0dNaVFRQUZ0ck9ZWG1GRm1QM0VCVU1STUZMSmRJNFdkYTBqdXVIc2NSa25F?=
 =?utf-8?B?ZHVweGZqWE93U1RQNmRrRzJOZzdQWm5KdnVCZ2NVUFBjR0FiV1lsWVQ4ZVNO?=
 =?utf-8?B?cVVZTndmeVJIb3lVRU5xUEJZMnpMc0dGVHFBVEJKY3Rtcy9QYkswaDVUcWc2?=
 =?utf-8?B?MzdISXhkL2lQRFdQSlJLUUlRVUJxQWtLWVE0Q1drUHJweFQ4MFZycnVMdXZR?=
 =?utf-8?B?ckxtUGh1Vy9RdHlhU3NmVGNIbWpibC9YY0V5RkxhdUpLMk5EUDBveTFrSmRx?=
 =?utf-8?B?RzNmYmJNZGZQS3BIRzNLMDJhcElWWEw4U01hdFJQQ0dRcDgyNHdjVzIzcE9s?=
 =?utf-8?B?L3UwM0c5UVFCSDNnY3lUZEREMTJCSHZZM0pPWE1oNHYzTnhkT3dvMjZ5V3U5?=
 =?utf-8?B?bHhnOWRQQVpXYkdFZTdhc0RwdUhyVXVJT3hibzJ2cWlEaFhSaFkrNkxzWGdt?=
 =?utf-8?B?ZzBvL3pTK1NYdC84aHhYZVBFOXEzN3hwSzdKTjFTQUdHa3k0UkRnQmgwdDV2?=
 =?utf-8?B?WVlpcFZaUTlmSWU5T1NxSC93ekcrc0dKUVR0a3lESlJQanhaV2hqT01wVGJI?=
 =?utf-8?B?ZDlwbi8vV1NZM2dFRXliZ3FlUUl6MGcrTjd3VGgwbG4zd2ppaUdkZ3Q4TjVr?=
 =?utf-8?B?WlRHMHUvOS9SbWgxOG9MVVFiTmkrRFJqRkVPK1NGOEVYNkJBaW1jdFFmS2ZE?=
 =?utf-8?B?RWZlSHFxTzloa2RrQVBsMGNWTWZOT2ZNTjQzK0k3QUs5b3N3S0tLZlRCMExB?=
 =?utf-8?B?N2M5RmViUGwwNzJrUDkzK2dFeVlPUHhGSjhMc244bzBHdG9JTGZCRDFyeWV3?=
 =?utf-8?B?V1FNdTBOcTgvT1JpY1ZGdVFLUVRrM2dxVGw4ZS9qcHczZVRBSFdkU3ZmV0dY?=
 =?utf-8?B?T0VxTGtxWklIcmlYbWdoakgvdmtlUjY2N0JYVGdDZDhBdEUzUHVhT0dzc09Y?=
 =?utf-8?B?VEtFUGNRZlpuNXBOdDNQL1JkMnhoU2FnajJjd1hGQVMyUEh3Wjcwd1hNVkNM?=
 =?utf-8?B?UE9Yd0xkRXVTeGcwS3lOOXFqd1ZacWo1UmhaZzk1Ni9EWkk5bk1mc1N2ZGtM?=
 =?utf-8?B?eDVnTDgvL1JCWmMra2tjeVZlZzUwLzlOMzJWeE1MSEpRM2tFQ1FpRHZ5VGpp?=
 =?utf-8?B?alZtRnZNWmFYYVRRWlVzemdJK1JReDVkOHE0bm5BaHVVYVJaNkxiNGQreHhE?=
 =?utf-8?B?RGwzSDNTV1FuZW03Wm1ET0QzSk5pVllpMlJSZ1pDeWx2V003S0ZXR3BkaTR0?=
 =?utf-8?B?eDNIeFJpVkpxVmdWTkk5NndPWDQza3p2ZmR2L2dZRzB3bjBFeWdFL09qbWpx?=
 =?utf-8?B?TzhveGt6SWpBUG91VXJ6VWxCMzZQYVZhMW9XV1gxNmRKZDZ2ZU5IN0UzWlRT?=
 =?utf-8?B?U3VQZHBOR0p3L2ZteGpQL0diSnNuZ2ZibU1zcXZTaHZFSFg5WUdkL1lMYUt5?=
 =?utf-8?B?QlluUjRaY0NxMklEa0ptUm5nZkxmY1l0eU1aUFBYQkFjLzdwVWhYM3dBdmJt?=
 =?utf-8?B?YkJPQlIwblpFNHJYVUlSZytnM1MzTDNyQk0zaFhOa0NIZDFaL3VOd0xkVU9o?=
 =?utf-8?B?QTdid291NUFqWXhzTW5VSDVHKzJoZTdTOXpKQzRFMlZQMlFjNmozQktCVm1l?=
 =?utf-8?B?ZFEzTlpWaHNpY0JLTDJmdnBHM05JdDlVajVKMjYycXppYkZLbmEzZVlsVHVQ?=
 =?utf-8?B?RzMyVGs2aW1td1ZRTEZKTFFZcmlyTkhkM0dkUzVsbElhVncvaVhmcHJWWVhq?=
 =?utf-8?B?T3JZVlVaVXVlTGJWYzBjSWlCbHFoRzBESjZQUE9DRGRQSEVsTnZVQUhkYmRl?=
 =?utf-8?B?SitkaXBiYjJ2c2R3bm5yY0JDOWhIancyOUM4OERYZi8wMy9qTnZpTjlOeEtB?=
 =?utf-8?B?Y216dFlDOExLTTE5bFVzaitITnBXWm9BT1p4MGFkYmZyUDJ3eXdsY3dIWFY3?=
 =?utf-8?Q?dHNsBNlqsSUH1cIthpcluP169?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff4068b-2e7e-4a88-f763-08dcfca75603
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:04:41.6121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtdUOh5g/fUw73Tt8MZQFM6ujapfiLRfH8WgclFABEOAR4L0EGYoIo0uDjzhHbVwbR2Sd/6gwtvqnGyzZfDf7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169

On 11/4/2024 12:45 PM, Zhang, Rui wrote:
> On Mon, 2024-11-04 at 08:45 +0530, Dhananjay Ugwekar wrote:
>> Hello Rui,
>>
>> Thanks for reviewing and testing the series!,
>>
>> On 11/1/2024 1:36 PM, Zhang, Rui wrote:
>>> On Mon, 2024-10-28 at 14:49 +0530, Dhananjay Ugwekar wrote:
>>>> Hello Gautham,
>>>>
>>>> On 10/28/2024 2:23 PM, Gautham R. Shenoy wrote:
>>>>> Hello Dhananjay,
>>>>>
>>>>> On Fri, Oct 25, 2024 at 11:13:41AM +0000, Dhananjay Ugwekar
>>>>> wrote:
>>>>>> Prepare for the addition of RAPL core energy counter support.
>>>>>> Post which, one CPU might be mapped to more than one rapl_pmu
>>>>>> (package/die one and a core one). So, remove the
>>>>>> cpu_to_rapl_pmu()
>>>>>> function.
>>>>>>
>>>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>>>>> ---
>>>>>>  arch/x86/events/rapl.c | 19 ++++++-------------
>>>>>>  1 file changed, 6 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>>>>>> index f70c49ca0ef3..d20c5b1dd0ad 100644
>>>>>> --- a/arch/x86/events/rapl.c
>>>>>> +++ b/arch/x86/events/rapl.c
>>>>>> @@ -162,17 +162,6 @@ static inline unsigned int
>>>>>> get_rapl_pmu_idx(int cpu)
>>>>>>                                         
>>>>>> topology_logical_die_id(cpu);
>>>>>>  }
>>>>>>  
>>>>>> -static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int
>>>>>> cpu)
>>>>>> -{
>>>>>> -       unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>>>>>> -
>>>>>> -       /*
>>>>>> -        * The unsigned check also catches the '-1' return
>>>>>> value
>>>>>> for non
>>>>>> -        * existent mappings in the topology map.
>>>>>> -        */
>>>>>
>>>>>
>>>>> See the comment here why rapl_pmu_idx should be an "unsigned
>>>>> int".
>>>>>
>>>>>
>>>>>> -       return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ?
>>>>>> rapl_pmus-
>>>>>>> pmus[rapl_pmu_idx] : NULL;
>>>>>> -}
>>>>>> -
>>>>>>  static inline u64 rapl_read_counter(struct perf_event
>>>>>> *event)
>>>>>>  {
>>>>>>         u64 raw;
>>>>>> @@ -348,7 +337,7 @@ static void rapl_pmu_event_del(struct
>>>>>> perf_event *event, int flags)
>>>>>>  static int rapl_pmu_event_init(struct perf_event *event)
>>>>>>  {
>>>>>>         u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>>>>>> -       int bit, ret = 0;
>>>>>> +       int bit, rapl_pmu_idx, ret = 0;
>>>>>
>>>>> Considering that, shouldn't rapl_pmu_idx be an "unsigned int"
>>>>> no?
>>>>
>>>> Correct, with unsigned int we will be able to check for negative
>>>> values as well with the 
>>>> "if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)" check. Will fix
>>>> this in
>>>> next version.
>>>>
>>> you can stick with unsigned int here, but in patch 10/10, IMO,
>>> making
>>> get_rapl_pmu_idx() return int instead of unsigned int is more
>>> straightforward.
>>
>> But I have one doubt, there wont be any functional difference in
>> returning 
>> "unsigned int" vs "int" right?
> 
> yes, this doesn't cause any issue.
> 
>> , we will still need to check the same condition 
>> for the return value i.e. "if (rapl_pmu_idx >= rapl_pmus-
>>> nr_rapl_pmu)" 
>> (assuming we are still storing the return value in "unsigned int
>> rapl_pmu_idx"), 
>> I think I didnt get your point.
> 
> With this patch, below comment is removed
>  /*
>   * The unsigned check also catches the '-1' return
> value for non
>   * existent mappings in the topology map.
>   */
> And we still rely on the unsigned int -> int conversion for the error
> check.
> 
> So IMO, we should either add back a similar comment, or convert
> get_rapl_pmu_idx() to return int and modify the error check.

Correct, I think I'll prefer adding a similar comment and keeping the 
error check as is, will fix this.

Thanks,
Dhananjay

> 
> thanks,
> rui
> 
> 
>> Thanks,
>> Dhananjay
>>
>>>
>>> thanks,
>>> rui
>>>
>>>> Thanks,
>>>> Dhananjay
>>>>
>>>>>
>>>>> --
>>>>> Thanks and Regards
>>>>> gautham.
>>>>>
>>>>>
>>>>>>         struct rapl_pmu *pmu;
>>>>>>  
>>>>>>         /* only look at RAPL events */
>>>>>> @@ -376,8 +365,12 @@ static int rapl_pmu_event_init(struct
>>>>>> perf_event *event)
>>>>>>         if (event->attr.sample_period) /* no sampling */
>>>>>>                 return -EINVAL;
>>>>>>  
>>>>>> +       rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
>>>>>> +       if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>>         /* must be done before validate_group */
>>>>>> -       pmu = cpu_to_rapl_pmu(event->cpu);
>>>>>> +       pmu = rapl_pmus->pmus[rapl_pmu_idx];
>>>>>>         if (!pmu)
>>>>>>                 return -EINVAL;
>>>>>>         event->pmu_private = pmu;
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
>>>
> 
