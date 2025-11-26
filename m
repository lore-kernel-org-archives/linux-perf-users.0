Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186414C9D;
	Wed, 26 Nov 2025 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764135777; cv=fail; b=BkdgZj7I+BzEzN+V1aSGxUyJ7no69NpmQHu1X5x8RZb/AcZgxkcCL0TvCjPJmmzoS6hFK0Ae/vqPz5+t/poy2KdePX7BgQU+7XPpKDwm2iWNhnVCfQnNCCtCVSszdPI99NpK4bkc9i9cxpkb60Fy3IIV4Rur2kuJYoH72Xec4QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764135777; c=relaxed/simple;
	bh=DE7SLCRqRe0aubZV/VW9sjVqMtZwuD1LTzWqfPI4twE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sIprrXHZVTjxYDlbQZ9O8nWWbuA012WT1Vh/jueyd/e8cWHbYYlTawEEZFmeG03py/2u2EQsqfWXi0MrXCJ5mcSSuGnDj/mRqCYZZaINhGW+42a3MOT1g82FiDym5nVCQF70OemeOeA8Ctj75MbHVK5Taxt6+Ph26BJQ6cGm06E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jtzqp3zX; arc=fail smtp.client-ip=52.101.43.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jtzqp3zX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn/AfxTqmRC43pq/G2+uY9AQ5ez+zJilsHUowQjk+fp1JNTrYI9c1C7gCoQAt4cq0SjfEe6PX4rUiFqPv6sB326J2lo+kDFuZivDiN/k8ZjqbgRbSYqebZxlymzfrguqJFVWz77+QJ3fyCpruLeMdI9xYxYUivZkEcveK1jo5iuDyOpC0wY9YK8fuyCek+5OmXfUL3Hddn6cJKnxTEVJjFB67icnSNWKz9CSEKOFqX9pcr9r97QQX6gno7iZgCyWTMfxmLyfgG377bJzPMjwixV97EgbCRQeBmG4Czx6eyZ1nem0pEp7dZ5TZFvRspGRv2iEevSLwoVsMCyaA+aYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6qrNZM7qY3/scaeY4yywn1/aXQvvGo4UzL6oDpp0Ww=;
 b=PEewjktCSm5yBNCfcSB5Dkuv7/CkGvYP/Y1ZDWyfo45MOYyhHqRP4ncks1NIk2veAJw+52l0nWYJwePbVf80WlAHq+U68oqrWU0iPeUXvh98M4nWDGNZ4g91IammdFOwY+xfPu2lS5Yb4+m/c9qy9KuBrehCJmg6TjG8FuEFPr2FqZKA17+vikgsQpP/Kp5V5NuiQEjUJchgtIXgkQwrNEK0mzlKMehLwRd3m5WUxIx3sQJx0Uy422CcRx5pxOi0/CiPLClainQaijjQE1kFp6VCUjJUCTBCQdbouwtaUEEvPr2+vK93/ecRwCZSaTBJ3DBUb0bSowRwqnS+EJcmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6qrNZM7qY3/scaeY4yywn1/aXQvvGo4UzL6oDpp0Ww=;
 b=Jtzqp3zXHkcAn7/LGGlOOOUkMNMRf4tHt5260PzjPvP8sY6j9XEZsgmtk9iY1EKfKrb8jzN0SPeol44HDZenJjdazRUk+IOE/uKGCOKhqOn6RaNndDhr7m8/KVJj5soVioqFlVXSOZDa1P/ZAwv228lM0gtDQpeagK7T+EsuQ2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 05:42:53 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 05:42:53 +0000
Message-ID: <15a6e162-2b1f-4d47-9bf2-aea1b7523685@amd.com>
Date: Wed, 26 Nov 2025 11:12:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 27/52] perf jevents: Add uop cache hit/miss rates for
 AMD
To: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Benjamin Gray <bgray@linux.ibm.com>, Caleb Biggers
 <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Jiri Olsa <jolsa@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Samantha Alt
 <samantha.alt@intel.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251113032040.1994090-1-irogers@google.com>
 <20251113032040.1994090-28-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20251113032040.1994090-28-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::13) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c0f9ed-4e2b-4b44-a574-08de2caea479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEVQeVQ5YXJ1UW82NS94VE5UcHhLby9TbHNBdDdwdkdKRWpwYUdiQlpsTXQr?=
 =?utf-8?B?c1cxdTEvZ0hneG5lSWhaM1h6ZFcxelZhRzlPN1pMaHpBTlBLSFVJdlJGams2?=
 =?utf-8?B?OVczN0o1TTlycmJZaktycUZVbnhHMThPbXd0emI1VVNvd01ZTEE1Uy9ObzJM?=
 =?utf-8?B?ZWxZQXozNjNONTRFb2VXdXp1TEtpY01TM3VUQzYwNk9oT2lTWHNGM1QyTXBr?=
 =?utf-8?B?SU4ycEF3SE5PMmVRU0kxNWdNd3dSbmRweXZOYnhlajBlQ1Qwckk0RThFcEpq?=
 =?utf-8?B?c2hGajRMNXRiWmQ5eUNRMzZkWkR2WWZXVTJrVGpMODV1WmZvaDJLZ0UyN093?=
 =?utf-8?B?bDBvd1IvbDhFRE10Yi9peGZLR0h5cnFOUHptQnRjU3Z6MzBvVzJvS0w0Vnlq?=
 =?utf-8?B?RlExK0QwWndYRWxFTWZETGNCaElhMHZTMHFuTER4d3Y3cUp6dEQyaE5xUE5X?=
 =?utf-8?B?dzhPSDg4MW53dEJtdGFvS3M2eTVlMzhSbzVaZ3IzeVhiSXB1UmVnSWVkK0Zn?=
 =?utf-8?B?NktEWW1iRGhiWjRSWlFGeU8rVEJGcGU2RzRaK2RZalVTYS9ISjJoc1hTZktG?=
 =?utf-8?B?REw1MUJrQWtjQlBKL0ZjVlRMZXl1QzJEWDJVL05lK3ZaRXBkQzJUTjkyQTYw?=
 =?utf-8?B?VlVTQkE5TUF3c3R0M3ZYK3lHUUtsWGNTKy8wdTVDM2laN25WMmVOL1p1VlFK?=
 =?utf-8?B?c2VoMC9zVXd4dUh5SEw4V3BnME1XWXY1ZzlVQ2I4ZGxlY05ySmhsWEpGcXFP?=
 =?utf-8?B?RUVxUEdKLzk3M2ZBSXo3UFVWODRYK3JCT3VlUlVuRkNLeXJnNXVLV21Rbi9D?=
 =?utf-8?B?VjVSZG44NUdVaWlBbG1NcGcrODk5M2t1ZWNxSnNrS2J1SU1tY1FnK3FteUho?=
 =?utf-8?B?ZlFsTU0yRDZaLzNzeEVTLytwWnBGSTl3Zmx5b0hsNThQR1U4Q3p3Z1A2cXpI?=
 =?utf-8?B?d1VNc3c5ZWtpZHoyUzFjeFdGOVJxbHVwV1o1K0trOWxzcmM1MFE2S1ZxNlBl?=
 =?utf-8?B?Zm1MSFBHWXdsNHJibjRzekRUZTNhRVROeDZHRmVBKzVRNXdvMU5BYmtYc0lu?=
 =?utf-8?B?b1A5UWg2Mk5ZVGRoek55S0dzLzJmZDlWZVJqV3J3QmFHZzFIbUZITTRZRnNF?=
 =?utf-8?B?OUtXM0xDb0ZkSkNBUklsbSt1ZmtrWThjTFM1M0U0c3UxMjlCeTg1WGJCV3dK?=
 =?utf-8?B?TmpEM3hrTmZkN1k5TlJkVVR4UGhxYjlPZG5UOXBKb2NjZjlGckhrM3huMHFS?=
 =?utf-8?B?TE94NUdyWjZiR0hYdm9LQWdlY3ZETHZXMm0xYnJWUEF6S3NHbkt4SEoyWk9E?=
 =?utf-8?B?eXJEVG42RFVaNzYyOWlNd0dKS3M0allQVTJmejgrOWo3MFRSY29sSFR5WTlC?=
 =?utf-8?B?SHdienFUNVJSV0ErNER0YmpTUkRhRFdPeGRqZDdaK0YvdlV4UXphdlFXT3BE?=
 =?utf-8?B?Q3B4ai9Ic2k4MWdIZkc2ZHJ4SWUvb3JJcVladGIwNGFuQXA3bVZJR0N4eVZO?=
 =?utf-8?B?YXpMb1I2R3Y5OUpHcEg4eVcwY3hieWhaSU9WcFBYWC9Ja1Vicmx4TUUzSTcx?=
 =?utf-8?B?cTFvRUVmT0owc0pOM2pZVlByVkVJano1ZGhnQ204TU9HN1gxWVdBa21Gbmdw?=
 =?utf-8?B?VzdjQVlBUE5SWTE4c1ZEaWVkaGlCblZKM2FHT2pSMUhTWm5yaVQzQy9CbmN0?=
 =?utf-8?B?QkxQNkFKclF4dnJWRldCb1luL0JUMkdOUGlCVEZYZ2orQ3JRNGF4ZFVnV0pX?=
 =?utf-8?B?NjFIdmxiclBlT1pHU1NvRlR3QTQvTlJmUmVCbzNNZ2tOR0ZrQXdlbDZLcTMz?=
 =?utf-8?B?OFU1SnZhTGtobUM2TkxFN3FaQmRYbFRoaFZxZjYwUUhtWFlNb3RLYzhsMXBN?=
 =?utf-8?B?c1NzK2NOUTVDcnRGV2gvMXF2ckZtaFdZT2VMUTVWVGdPbHg4SG44Yy9aRGtC?=
 =?utf-8?B?UjcvaWlhWlY5MW1kNWZVOXErY0RXRVFPcEQ5ZHpndk1rcEdBMll1Q0lyRDA5?=
 =?utf-8?Q?exbw3mLdc0c6ge+ZxSo4bttiQ3v5aM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekNSTmpyS0paSzdoVzZCbUE1ellORnpKa0RSK3pDN1RzS3A4Z25vR3BkanFI?=
 =?utf-8?B?VW9OUW5ZZnNOTlIxT2luM2FEcnNiRnBPUGhSalBaanI5UEwxV0JyTHNLSmJr?=
 =?utf-8?B?eXpwWDhRa0llZXhkTmcrUDVuVjNKajZ4MEJTRFlKNG5zWm15UG1DVERQZ1kv?=
 =?utf-8?B?TmFjai9zcGVSaUxNM1RwTm9LdHBPek5EM3g5YjZ4dkEyWmZNOFJGY2pCYmtT?=
 =?utf-8?B?bmdJdVdKOWE4MUJtS0xpdGdxa042UFVGNFhhVnNNRUcvMjM1aVFVTTZVRXFC?=
 =?utf-8?B?SGM3STZ5ZTZ3eGdaZld4S0xKaG5WZThac0ZNOUZYVytOOGNWVnhvenFhdjRG?=
 =?utf-8?B?VmdIamZWRk0yY3IzNlJWTHc0Qmp4bHZqb0dVSlB4ckVFSGpQa0Y3WWlhTkNy?=
 =?utf-8?B?Q0ZISGZPWWtkMDBUc2J5MEJubjVldjI0TENUQXYvV1hOOUxFUWptbEN1QWdn?=
 =?utf-8?B?M1R1SWtOTTNTYlNGRW13Q3B6OFFYREVpbXNVcXVJRFE5N3ExYmFiUGcvcUhj?=
 =?utf-8?B?a2dlbmt6Y2FrbHFPQ2RaNXdnVm9QT1pzYVl4OTNzT0k1NHliQk5NZzlsd2VM?=
 =?utf-8?B?ZWNWTFczcEhXeTExOGovQ3dkYzhLa3JOc0lCT1RNR0dDU2FWZVpnUTcxcElY?=
 =?utf-8?B?bWE4eVZ3clU2cllOTFYvWDdKSGdvVFdKZml3RURGYUIwR1N0MTJvODNEQ2da?=
 =?utf-8?B?MWdsQlp4cndubWhwVlBkUFc4WlY3cmtWOWVZUFQyYUNmRS93VDQ3bFJBRUFi?=
 =?utf-8?B?TkluQ2EwSkRvVU54UE02eFlBeGpaNkNzSmVwWmZiK0FkZDA2YWFmSmtPRkZU?=
 =?utf-8?B?ZzhMWlJESkNjdEpvTTBFKzZZNFFLMlZZZXZBNXVEM2dpNDNISnFqVWFpRFBr?=
 =?utf-8?B?Rnd5Q09GRUpRKzAxRG1nN2d0emczRUJGZ1p5a1Y2LzVRbllHZG95Njh3R2NU?=
 =?utf-8?B?MEZtaG85S0pUdExWbEJtdmgrbEFUakMwV0pXYm9LSU5HdnZacGpxMUx5NGNW?=
 =?utf-8?B?YlZ2M253QzRlYVJjMEdGdUxseGpnYk1tUGRCazViY0xtTXFtUlhhZ3hLS2dW?=
 =?utf-8?B?dHRxcDE1eTZYckFSV1lkeVhmbDhyWHNVN0xkNUdDMFExcU1kL1l0RUY1eUlm?=
 =?utf-8?B?QXYzb2VnYkNvdCt6cjBKZHppNU1WOXJRVWtlTWs2Q2JHTVQ3MXlDYU5NaU9Z?=
 =?utf-8?B?RDZxRzgwRXZKc3NVMEFFczQ4NWZhaTBLbzhaMUxsL0hpOWJVQzJSVVdHc04y?=
 =?utf-8?B?TjByOU5nZjBLRTNpMkQ2OEtCYzZNNCtPVGhpRFJhRTN2WllnTDlPNGZpNjNq?=
 =?utf-8?B?QVhYdXlJc0ZjV2lzcVRiOG5WSE95MnpMd3Y3NGNGV29qYXpIU0JVZjZhN08v?=
 =?utf-8?B?NVl2b0xLVjdNMmxlRGVja1JUSWpPcDc1dmtnbFFlVVNqN0pCS0pmbFBhUVFH?=
 =?utf-8?B?WkhUb2tBekg1ZUVJQmVqQWdKbmVDWmlrMENFcjhTdTF2ZG41REtCSFlMR0U3?=
 =?utf-8?B?OEVUdXhHNmRVVkdpZkFCZ1VXOW1Xa0lUa0pFeURLSVV1K0ltdTZvZ1hCTE9K?=
 =?utf-8?B?TzFIYjM3Uzkya1V0RnhjMWJON3cvdGYyVmZNRE8rVW9LRkRUalV5b1hOMmtz?=
 =?utf-8?B?RjQ3OVlVNzkvZndiSEszd2VWSmN1ZUVwdnNEaUdJMnc5RGtpWnBMNkpPbTh5?=
 =?utf-8?B?WHFERFppUC9BZUlQQjFsa0dWdHI1WG4wVU9qNlZ4NTNOMzNlaXhzQmlVSGpR?=
 =?utf-8?B?RHZIMGtKN2VhaEZZZlVWWHA0MEY3bDJpNUEvenNXdDN3bDNxU0IzY08yam9j?=
 =?utf-8?B?VTVLQktFMkRpVytDOStXRVAzbXkzNEViOUxta3FoT1kyay82d2ZtZVRTRGlO?=
 =?utf-8?B?UU0vOFJIeUpGSXV3WDBtMFFJYXpBUjFtd1JJM2hSam9MNXZ3WlhQZmx6SjRD?=
 =?utf-8?B?TldjNjhvUlg2eEEybkZzTDM5Q2Zoby9yVldkWkZYSGxzNHp0M0RHQkdmNWJM?=
 =?utf-8?B?cU04MkkzQ1NudWNCRmZVemlkYXZKRDh3TTBzTlkvZHo4N1VhazF1Z2Z2YlBJ?=
 =?utf-8?B?ZXJaNTM1ZENuUlA1MVdHSnRiLzdFY3BIallvSFJtSmZ4QmlFWERFZlNveG85?=
 =?utf-8?Q?EiH7Z7yU8hB2xSgDoaG7K1s5o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c0f9ed-4e2b-4b44-a574-08de2caea479
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 05:42:53.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9HM0P2Qp1gvAafAnWr1Wv5vv3TIXHcsUCljv0t9T6IDhuYjqCEGsp9l6RfRhG2ULdRs35KbiBTFA247DHFU5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163

On 11/13/2025 8:50 AM, Ian Rogers wrote:
> Add metrics giving ratio of uop cache hits to misses.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/amd_metrics.py | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index da50337557f5..b2e3e2883022 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -584,6 +584,23 @@ def AmdSwpf() -> Optional[MetricGroup]:
>                         description="Software prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
>  
>  
> +def AmdUopCache() -> Optional[MetricGroup]:
> +    try:
> +        op_cache_hit = Event("op_cache_hit_miss.op_cache_hit")
> +        op_cache_miss = Event("op_cache_hit_miss.op_cache_miss")
> +    except:
> +        return None
> +    op_cache_total = op_cache_hit + op_cache_miss
> +    return MetricGroup("lpm_uop_cache", [
> +        Metric("lpm_uop_cache_hit_ratio", "Uop cache full or partial hits rate",
> +               d_ratio(op_cache_hit, op_cache_total),
> +               "100%"),
> +        Metric("lpm_uop_cache_miss_ratio", "Uop cache misses rate",
> +               d_ratio(op_cache_miss, op_cache_total),
> +               "100%"),
> +    ], description="Micro-op (uop) hit and miss rates.")
> +
> +
>  def AmdUpc() -> Metric:
>      ops = Event("ex_ret_ops", "ex_ret_cops")
>      upc = d_ratio(ops, smt_cycles)
> @@ -675,6 +692,7 @@ def main() -> None:
>          AmdLdSt(),
>          AmdHwpf(),
>          AmdSwpf(),
> +        AmdUopCache(),
>          AmdUpc(),
>          Idle(),
>          Rapl(),

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

