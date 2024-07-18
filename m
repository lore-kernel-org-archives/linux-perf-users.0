Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48B1B86D0;
	Thu, 18 Jul 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310151; cv=fail; b=YStcB9lMTfz/8naYcLkgnI+47MkvMjYFMqscO/5u95mUz/iXpQ7mGeGLZ9N0h3ud3noP9/KT5d7BCVU41zVYaXM6tcYCK26lFO90vw4j8jO7h2Zqf08MPn2/V5+PKQPaCwzp1TpCC9lyaBki9oQuRhte09x5spaDSjx2G9xaX2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310151; c=relaxed/simple;
	bh=YJ8PdLdh9koHJXUOSf6ClD2J73bqO5i8sUzQmL1GKXE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sgMsNIxOkpGbiHSxzCPXRGpjgq3A64vK6sL+qcYZ/mJMhFo2iup+2tvUEEa4yNPqOR8N0RjBqaX2RTx8PD9zQu9+DAEzdvLIlXNFtMsAXVjShV+NxyjBCpU6d1kV3NQ0VGOw0RZwkNDyuWVbEMi/3YDSDAE1qbEgcwQ9AIFrl0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gihxT+/P; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gihxT+/P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ga7b1K3FyOnh/DFPY3RSaNl6Gj9iF6QTktp1f17FqdC3XS5WguDlPgw2t79LXv0M3uYAntCTM1uuiFfLrVErLSubSncXNmT0yjREms9Vqg5/9gPAkXe7oxXQ3MFgmARH7nHfOj9yw/njUymkX9jrZdWf/IBorE37mR4UzQkmL1AX/zrvLRC6hriSgQu8nCIFz6UpbO9ug8U3XFH+k3o2sERzS6AF4YvvC8HaQCuCdET3vtOo03TptsI6u9kPQNQK48P0iEJfECBN0hHW95ZcVajeR9ePhw4v79ILThq0nbqc/xK0U/OMwDlaRftU93SRcRgEF+EU9dWvizIQikzqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7AOBMx+++lBCocQYvNfH6rx3LfQMLXnrq51FfhkYz4=;
 b=idfRecQqoA2CpGoE1vslQWkRPeUWYZnern5w8uhzPWuyu432KxuptEVQrJQbxDFAVKE4taEbMeV6pIDofYta0CB/CUsNqINezGIfrUj4nXlLbixqV9Z3iDFcUT4kI7D7ZiKaNXIu+8TmzlkapKeVruKDRly1CBQE7D7HQpMV1W/3ghSTNbrn2OQ1MgdVbWK36VR/izJJTog6rpI3vWtzZ5AFS1eWFB9Sdd1boXmp/6LPd/8cLDK9zhS8R1WLDc2JEEAJIm3NSpMS2IM8kJbCG62JJColRAQe9sXmK0iV0bSUTGlA04m0eLAdTN8mPCKnXrvIayVMKNGKLWU99+bInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7AOBMx+++lBCocQYvNfH6rx3LfQMLXnrq51FfhkYz4=;
 b=gihxT+/Ptu7PbU8E7pybm2fT7NRVp4kTGdE8Yzf4kwhsHzXtTZT6HCAe4VhgAe9h2rpqWalcesFMdUBEzPr1/ayzpIyl6bgJx4AsoONaH+bOyfxjqm5DKgRLoe3tH4edH1Y95Btkr3f3XDL21i0rLXAtdYs+NhD2TUsr01KYe+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 13:42:26 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%5]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 13:42:26 +0000
Message-ID: <94491b9a-bdf4-453a-9191-25bf431957e0@amd.com>
Date: Thu, 18 Jul 2024 19:12:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add support for sysfs event.cpus and cpu event
 term
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
References: <20240718003025.1486232-1-irogers@google.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240718003025.1486232-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 096412b3-f9ba-4f78-e16e-08dca72f75d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTVic29BVW04RUkzRzZEaXVBZGZaOU1MTGFMOU5oWmQwSWxXVFgyWHlsaHdm?=
 =?utf-8?B?RnNpOTVuZUNmMVBYRk42dW9maFRrelhlWSs1aUcrVWlCVWpjY1VGTlRwSGkv?=
 =?utf-8?B?QjBWaXhpdUdVaFcrblljZDlwSTd6aDlVY3V4dVgzMm1FckV2TnNoRVRjMnRk?=
 =?utf-8?B?eGNGNDdmdW1FTXBnaGpNY1o0Q3VFdWY4UGxmaHU2VytYc29qQ1owK2xOQnNQ?=
 =?utf-8?B?VXZGOUREejkvNndPbFpJNHQxUEV0cjY2QURSSmw3dVRudFFpeGcyd3NlZ2Vk?=
 =?utf-8?B?UWZXbVQ3ODdIMFVGeU94VDBhRWg3d1lUcXgxdnFRT1BkZTRkekY2Z2V5dHRo?=
 =?utf-8?B?RE5TckR4Nk14YjRqbnNVU3dGaG0yWFpiVmswRGFQcUorWVl6aEd3Y0tWNjda?=
 =?utf-8?B?eENyUTJNKzE2NXRlSTcxbnFxUzdFYUZrbi9wZUo5TUdaaW0wY3JnWXpTZk96?=
 =?utf-8?B?Ry9aQjZGRXJQMXBObEtQZzhpYUVFY0Q4M3o0aGZKTE5RR3A1K3dpV3RFWmpt?=
 =?utf-8?B?OUIxSHNvemJoVGxJVW9kbTVKdmRUSWxlRStBNGRXY2RhWmFqSXRUM0RhMnU0?=
 =?utf-8?B?czF5OFFuV1diRStwQ0pjQTRraFMrWlJaeVc4a2dZSVVtbFhlSGIvUW1SZ20y?=
 =?utf-8?B?SDRSdWhPcmNxa2R2cFZ5L1MzZTNKTmZJbG9IdG5KbURIZFhZU3JhZjdBeXZO?=
 =?utf-8?B?TWwvZ2UxS1lBZjZDRGtXZzNlQXluaWdLWC9SdmZGZ1AxYW9KcTk2d1A4bkJo?=
 =?utf-8?B?SGFGV0c1dGNqT3FNMng1d2tkYmNveSsyZlpaWE9pcit6YW8xMjZ6Rk9HZlVU?=
 =?utf-8?B?R0RDSnZFeTNxdHArdG9Hcit0MGZ6TE1hWm5jajFYbm0wbmdwQXI4MkI1K1Ft?=
 =?utf-8?B?UmlYZmdyMWJWTTkwcHNPaDNpNVgzSVA0L29yd1hNYnJkTFpaMlhxOGR0S056?=
 =?utf-8?B?OEdkeTBsbWh3Y21DZndCZTgxWVJxR0R6UHZlZzJlbVVLTm9TZXpJNU50Rk1C?=
 =?utf-8?B?WE9qMkZCVWZJNW9XQ2hYVHEyQTlFY2xBMFZvSzNMVGdyZjhFS1Q4akEwejBH?=
 =?utf-8?B?c3l4UnNEUUZvTjVuOWh4WXozM3g0MCthM3RwazY0TEYwZ1BNOVd0Zmk5cHVo?=
 =?utf-8?B?WUdnNjlHNERkVUJlZEZCNzVyK25RY1QyN3hyQVl0U2Z3Ti91U293N0ozM0dT?=
 =?utf-8?B?eU1nODBGSGZuTzZVYVdXMExDUTJaZGg3a1VpUlg3ZzBLclNqREkxY3llMEFD?=
 =?utf-8?B?WWZYTStEMkVPVUx1NDJ2ZG44Y0hpVGg1U1Q1cmNBeXJjblZtdTczMmtjVGZT?=
 =?utf-8?B?VjRrMUJETXI1V3k1NER6YVF6amxzVkFrYVJBWTU5L2VvVG1EVXpwZ09VeWFu?=
 =?utf-8?B?Z1UwQ3FNRFh3ZUU4SEVDdUxjaEtpWmFjVVI3M1VaRkVEcTg3Y3pCSFJ1WXh5?=
 =?utf-8?B?Y3N3djE2TGYzWGVkQTNuWU5hRnBvM2xEMW1XaElJWWI1WmQ3Z012OGpNOW4w?=
 =?utf-8?B?OWZsZndtelNMNTJxMWdGUU8vYTE3Y05jUVhpcytheU92R3pISDF3b0V5QzZv?=
 =?utf-8?B?SzNVTGdoVms5VnRSWFdITXl4MDlDSjhCOHdERFdPSG41bUJ4SVVneC9ZYzE2?=
 =?utf-8?B?L3N4c1V6YUVSaER0eUlkVVFmeUZkZ2xrckFCZWRNRkpUbnBac3doSGV5K2I3?=
 =?utf-8?B?RVpNTzNsZGZ4NmVkcUcvb01wTlErd0s0d1lyNGM2RjRkUzU2ZUhSZ1BBM2dr?=
 =?utf-8?B?anVPbFJNZE9wazdZcXpmeW9RamtNYWFSeUVYbVJaUVRiQ1BYYVAxNmgyWjVv?=
 =?utf-8?B?L05za1F4cmlCSlZkZytDUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHdQRmUyd0ZCRnR5SCtFenBmbjROcVJBSG1iZytsVVNiQjFLV3RVamUya2d0?=
 =?utf-8?B?ZVVLOEhtd0pCdGhHNGFteUxZdldpWU1ZWVVrY25PcFNiRTk2aDhYME9ySXFF?=
 =?utf-8?B?ZmVnamI2TElleThQQklhSFVrNlJFNDJ2R3JLb0FLWnZrU21sRm02STUrdEg3?=
 =?utf-8?B?QlhyNzg0cEN5QzU5L2hUbzQ5TVVxK1NEbXB1ZUt3czRDWFE0NDRBMjBEZ3Ay?=
 =?utf-8?B?bHpBaW50S1ZyTm9WNzZHRGVueVBZS1dFS0pRNFExOXJnNzFzQzNjNDdHQWlC?=
 =?utf-8?B?ZitKV3dGSWJwOUlRR1o3ZTdRdDdnV1dBakU3UmRrMyt5ZUg0VS9IMkJNbmlC?=
 =?utf-8?B?ZnlvZFc3UDZST3VmdVUrSUpNWUpGKzlRQzZ0WUk4cmNqd2J2NFh6ZU1aak10?=
 =?utf-8?B?S0pLTmVVdFB3bHY1NHdrb25NRlJYOUgza2p5SkI2MFNRTG55UlIvNDdDMVdi?=
 =?utf-8?B?ZWEzY045dFJxWFFaVEQ3SXZ5UDZrNGdkbGIvRHg1M2wwR2tXVEpzVjVPdm5u?=
 =?utf-8?B?UHVaUVVmUHVJd1htc0dCcUxHZ25ubWxGY0tjMmRoQ1NCMzhqZHNKcms4SDlL?=
 =?utf-8?B?U1RTQXZ6NndYd1l6REcrS3UvbnZtaUlma1lodEJrOFBvWGcwTFkwSTJabGxy?=
 =?utf-8?B?VTBySFdvOXJ4MjY4WThkVHFUUE90VmJaNVhWWGdVajZSRGVEdFd6VncweG5Q?=
 =?utf-8?B?SUh5SUtrVFlpanA0c3BaUXpjaUpNbVhPanpscjlXOU42elBHQ1Q3b1VBSTJk?=
 =?utf-8?B?RmFab2Fpb3RYdFhRd3cyODhrcmNUVVI0Q3Y5UzlzTWlwSVdlMWc1Mm12bXZY?=
 =?utf-8?B?bEVWekZxR0NZL2YrWkFKWHkwa1JnQlR4bERDYXdoVUxVOWZaN3cwZVFVWVdY?=
 =?utf-8?B?SzZSWUk5UDJZaHVwV0VKL2VPWGNlR2lETitnYXBGMjhRVEx3dDdkUmQrcnFo?=
 =?utf-8?B?dWw5TU5ac3ZYVDNaeDZvQUVMVE1ZQW1Fc2d6NTdxaWpBMXhydzBFeURkekRC?=
 =?utf-8?B?SmdWTmhxQ0FwcDFMM2JHeFZqWlNiWkdXMjRMcmZWVW4vODcxVm9CRFpFM3A2?=
 =?utf-8?B?SHB0bzJ1Y2t4WjFEWEgyQzNvbzBBTmQ3TWQxK0lRdS9Kd0hHRDVLVk0zcFpT?=
 =?utf-8?B?OGxrNVd5K1VRMjBaaHljNTIzcXF0UG8yZnZOWEpJY3I2dDZqY3VacVhlaDlQ?=
 =?utf-8?B?dmJoK3A5Y2xnMTdiSWp2cnljNWJpUUJocWN0QjdUSFRaMkRtdm5EUFlmZVlN?=
 =?utf-8?B?S2dVNmUyY1FNL3IwYjl6ZDYyanh5K1dueGk2NkJTZER1dUpwcjJMeVpCb2pD?=
 =?utf-8?B?UGNmZDZ3ZzJaSkZ2eEhPL1pOZ2svMmFlTzc1MjdPT2VsNkJpZDh5UDB4cUJT?=
 =?utf-8?B?OWhPRC9YMllyMWNSWlNGSGZ2U2c3S3g4cjhheDdPbUJkOXdjbjJaS3Q2TDlF?=
 =?utf-8?B?Qzk3ZjB6OWxoMlU2RndrSmlzWnpzUmZFZ3V2Qm1YMFNOQTFCYWEwSUMxM3A5?=
 =?utf-8?B?Qmp4NjJKS29mN1BDQUdwMkxvWUx4UTAyaW9lL1FmVjBtR0VtaUx0L05sS1Ay?=
 =?utf-8?B?UnEvTjFBMlFTVFFieXhTcldxdVpSTXNJa2MwVjEyYVROSnIwcmppZk9BRHJ5?=
 =?utf-8?B?Z3NiZXBFcVpYZ1lhUWtZdUlTTWp5bjQvcXpJUVFabVptUC8vMjd0NWxFWWlV?=
 =?utf-8?B?NVVNbkR2NmVPM0NudEgrZWlYMDg1d1BTc01meW5xdDlmRXZFS2J1aExFSnhT?=
 =?utf-8?B?ZnhZamRON2lGa2xQeFhoWVp2OThnVG1aeHRnc3g2QXM5bUNxcHFNaGRUZTFM?=
 =?utf-8?B?Mlg3S0pLWEY3bmxqZGtOUjd5dlZrU21FZWNyTXF0SVVUMHovNVBqNk5XOXV0?=
 =?utf-8?B?dGhud3dZbG1UMXlzQVM2dFNtY3NkcGlTWkMxNUhtUU9pUHFkNWVEYkxuS1I3?=
 =?utf-8?B?SGJNdTVmcHRRdm80d1VoQVRYYkl2R3JaL29yZUZFbkFVcW9EOERlOXRNMWIv?=
 =?utf-8?B?a2dSQTZIV1l6NDNxaG9yZkkwV2JMekE4OVhZSFlLc0NLUVFsU3BBeUF3UytM?=
 =?utf-8?B?dDNYKzlrcG1FNWxQWEVRVzF5Y29BMXQ1bnp4am9BZm4vL0tlWTlMNWtkTUNF?=
 =?utf-8?Q?03H701jHjEsAA+6d02FUN+3cR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096412b3-f9ba-4f78-e16e-08dca72f75d6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 13:42:26.6487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kg+zV+EU7GTyF8/5oi+Q8qyGOJviBbfeW4AkDhchahgxbPjWcBnq8gjpPz055ZpIeFgx6vIBDqyisznggAVRTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744

Hello Ian,

On 7/18/2024 6:00 AM, Ian Rogers wrote:
> The need for a sysfs event.cpus file is discussed here:
> https://lore.kernel.org/lkml/CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com/
> following Dhananjay Ugwekar's work on the RAPL /sys/devices/power PMU.
> These changes add support for the event.cpus file in sysfs and also a
> cpu event term allowing events to have differing CPUs. This was added
> in order to test the parsing and map propagation for the sysfs case.

Tried applying the patchset on top of v6.10, torvalds/master and tip/master, 
it is failing at patch#2, what is the base commit/branch for this patchset?

Thanks,
Dhananjay

> 
> v2: Add support for multiple cpu terms on an event that are
>     merged. For example, an event of "l1d-misses/cpu=4,cpu=5/" will
>     now be opened on both CPU 4 and 5 rather than just CPU 4.
> 
> Ian Rogers (6):
>   perf pmu: Merge boolean sysfs event option parsing
>   perf parse-events: Pass cpu_list as a perf_cpu_map in __add_event
>   perf pmu: Add support for event.cpus files in sysfs
>   libperf cpumap: Add ability to create CPU from a single CPU number
>   perf parse-events: Set is_pmu_core for legacy hardware events
>   perf parse-events: Add "cpu" term to set the CPU an event is recorded
>     on
> 
>  .../sysfs-bus-event_source-devices-events     |  14 ++
>  tools/lib/perf/cpumap.c                       |  10 ++
>  tools/lib/perf/include/perf/cpumap.h          |   2 +
>  tools/perf/Documentation/perf-list.txt        |   9 +
>  tools/perf/util/evsel_config.h                |   1 +
>  tools/perf/util/parse-events.c                | 162 ++++++++++++------
>  tools/perf/util/parse-events.h                |   3 +-
>  tools/perf/util/parse-events.l                |   1 +
>  tools/perf/util/pmu.c                         |  92 +++++++---
>  tools/perf/util/pmu.h                         |   1 +
>  10 files changed, 221 insertions(+), 74 deletions(-)
> 
