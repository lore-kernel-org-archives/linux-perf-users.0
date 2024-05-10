Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE920309;
	Fri, 10 May 2024 04:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715316395; cv=fail; b=NI4mB/0YZesN6BUyB4yYGvQGUXtKxVgWq4dFxhUEy7BX+jmN+QoH7UgsXE2mf313KcvNDPNnQNFtPoQSQZBapSFrsr43kTTSDVb8ZlnFQvJ2RXB2dpLg/ihLKXWpcFCjedMxe83hsPyEP6+KsaBeaOsfWA+4N4DMT+2C0FNMxGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715316395; c=relaxed/simple;
	bh=b/eG1nxXiMPuunAQbb4N6bf5LTQPL9GWnGLxjVdEDh0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OinFs26yobU+WUYUfIwGa9zBe1IQ0bCg7g6f04OPwvYD/TkzaFKHhft2ozA5T89fCytmblNj7cds32TfKtUC6/LmU2aGGiebhn9JT3SI+4m+5MXFq+bjRCgw1h4aX1nENK71LjQkkRFS7W+jGwus8rV+ts13tdwVOPZb+V2g4XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U6fpCxuI; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U6fpCxuI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+Fm92In5uJTDBj5+5dTnRmjjBks5lopd/h++ZrXN4nf6gBa0XbRIPaWLCM1H/cw8Eb7ztWAW9wjRqXXFQ9sUavFA87LNx5nNVV3ML58llpgwc2VVRYUX2z1rLFXCEMmqSAwImCsTA81PZAEZaTBBoC3im0NjA8bwgqJ9FHGlE5H3xPz/uf5QnYGyRsH7dddUPRjvUrn359wNqgfFIfPulLJNoIBj1CJ1Cn3LQ3QWu79QPS5pjJ6POeAEg8SMGjm8CQ2H/4tnIAPQrHf1+kgV/zMq3E78UcefsGRtwLTb7Y+utzy9olk6Fwv257+gK7tGXNC4do5u2dbW42QjMIttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+O75XBbK3NhUfYPaZU2C+oJd+SXogKdrm/0M6CA8Tg=;
 b=fhJ08IlQuANt7ZrR+sTacRJ2QABKcWSroeC4LKa/SgGZLDrFlrvJ6bxkiRc0X3YEvb5L7jUdo4YI0VIEoOnCmoOPyBT5Y/Qr/MTG5/1uWOmEG5z/2s5HPMPBLOCVpX4sGe3Y/jSZfTB4KmqiOkQUEmGlOVPLM7sLP3jDZf/5nA90nIQ7mGeOjnGBjFRPwK/j46XKox971msu2924h0sfFSaHa8VDxatzFFWRTzmv0ITMn7PJ7nfjMC+x1u7WIKcNuRy3lECE/tQTMlVMODT4ElzqWZaDKXaDAUGX2bmiecOIcfUSjE+ONzCOdF0OR1LFAwyGQLunyd8j8YfE5Ibw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+O75XBbK3NhUfYPaZU2C+oJd+SXogKdrm/0M6CA8Tg=;
 b=U6fpCxuIKP9h9gYOVMXSmnSleN9YGp53KslkMgviBG21Vf/NvWcv9layJu4ygcEhAL8twNWRbvEY5b0XUs2kbpvGDrBEewgGbbwLb9Z1gYypmRIPtuKCC6/+ZS0pKxOaQh5vPYMjrVA2LB+oEhg+4Bs3qML2XZwE3ds5juuozcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 04:46:28 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 04:46:28 +0000
Message-ID: <218f9d7c-135a-16a2-3585-4b13d2d39526@amd.com>
Date: Fri, 10 May 2024 10:16:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 0/4] perf sched: Introduce schedstat tool
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 irogers@google.com, swapnil.sapkal@amd.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org,
 vincent.guittot@linaro.org, bristot@redhat.com, adrian.hunter@intel.com,
 james.clark@arm.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com,
 kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20240508060427.417-1-ravi.bangoria@amd.com>
 <CAM9d7cgFKcHXeTXxax7GRCK__0U3HUnG3Ls09GpnD8FipyJk1A@mail.gmail.com>
 <0689aa59-426e-2f37-dcc4-d79b1e89403c@amd.com>
 <CAM9d7chvDczhMoOJFLz=MW0ojGm=Ex90CgHhfOsZuLre3vSE3g@mail.gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7chvDczhMoOJFLz=MW0ojGm=Ex90CgHhfOsZuLre3vSE3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::10) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d194d2-9a15-400b-4ae1-08dc70ac2786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGNqaTdld3d5eTJlTnYwU2hXbTM1RHdmeTMvN1JJdFlaSHdZL0NSTmtBeE13?=
 =?utf-8?B?WHlpTG44cmtKcWhNNlJUVXl4YjhUb3NrYWpnSU10VS9FOW9rWjRteUpYbzJE?=
 =?utf-8?B?S3k4T3NWMGE3dDBnVlhoWFAyNGNKNC9XYmJDdm14NGgvQW9Sb2VOcis2c3JP?=
 =?utf-8?B?cDhVL0FvUW5NRUl6czhoSDlxOXJLMHRvMHBBNUFnWGxGMmJrTk5BYjZhRHRv?=
 =?utf-8?B?eHNVOHhLaXIraWIrYXpGcDFrbjBmVVFuT1UrKzVTZXVxMHg5NXRveWx4alRP?=
 =?utf-8?B?L1VOS1Q5ZWl1SVU1U1VtaHc1eUZmUlFWUXRQSDA0TVB2Q0pRYklSMm5MWFJ0?=
 =?utf-8?B?QTJPUHI0YXVpdHVxczR6alhQV0VobUZTUG9xREkwUkRwTlVTSHN3ZGFIbEQr?=
 =?utf-8?B?K1Y4NzVFb01WUE9Rd2RmdVBKN0pxSEdXK3FaMTNGOFRiZGpDZHdRTW1hcUZG?=
 =?utf-8?B?UG93S2tZR0hpaVB5NjNaTm1qVlBtYzRITFYxQnEyT3ljT3N0cjVTMzlCbTlD?=
 =?utf-8?B?c2swb3pJa1JGcnY4ZTNRMUdQNXI5aXFYdmNLbnpXUk9FbnhDUmFxb3VGWk1Z?=
 =?utf-8?B?RUxXbmx5Qk03ZW12Q1pWT3FweGNSTTFsbWt2MUdDdmlBTkVueXRTWDlZL0FU?=
 =?utf-8?B?ODBaMCtKMlFBaGk3VEhNV1dXaXBaaXBuWXp5NWp5bDZsSk4xR1FHaWx4WkVC?=
 =?utf-8?B?OG1HSytDZittKzhxbXNmNFdCVWY1Um9KbWJEdEFheVN0Y2NGakw0cHZycE42?=
 =?utf-8?B?YUpZclJ0NGxXS1VCQ2FxSDRweDFlWHBoSE82eXVFMDhkS2JyelhTYlNOeHor?=
 =?utf-8?B?ckFKcGdEenYrUmxZdm4vcm9mRUlDYkxHWG1CcHQrdW83SUF5UWV1NG1TVmtC?=
 =?utf-8?B?blFDM3cwK3lRRklZZFJsazdnb1BDRFhnK0FlM1AvTEVtVk41bmtUc1B0R09N?=
 =?utf-8?B?YmZXUWxSNlJDR2w1MnlGOVlKODRGSk1kaVFGQkdaWUtJbFJMN1ZmNzd2SEZG?=
 =?utf-8?B?dC9VVitUNER3cFdRK3dqQk5WdGhwZkFFWDBoK3BCaHI5WVYxZ0k3dmwzeTVQ?=
 =?utf-8?B?bHM1b0hpSHIxSGowcG1VSnU4WjNrL0R3cVUySkZrWkpMa1Q3K1VlL2s2dkgy?=
 =?utf-8?B?TXVmOEI2QjBXL1NCRG9aZGU4Vnc0YWNkUlpHN1lyZUZSZ2dHRkNwaUFFU3l3?=
 =?utf-8?B?bWlLWFV2aVJpOFljY3ZxejNNM001eWd0TWJqZVUvelU0VUNVYnMwejNaaGJm?=
 =?utf-8?B?TjJMNmpKUjV1UzBNWmdrL3paQVlsNmg4aVR1eUJMTEx5UWlBalJlU0t4TUN2?=
 =?utf-8?B?aXlnNTExTmR5VnV4eGVvYUhMN2o0cVpsNHFtTkJhM0VUNjU4dG16OElQMUYx?=
 =?utf-8?B?a1pqOW1qMzFHa0hJSlVFMlI3QUxLVVo1RWI4OG04V0lINWdGajRXZlU4RVhn?=
 =?utf-8?B?UitydUZqaEp6TUhUcHUrM21KYU5qZkRjMVFISXY2aW1qSXg2bDk4TEVHdU9y?=
 =?utf-8?B?c3B1Z2J2NmRqMnJ6MUJTMys2eTZ3Z1kxQ1c3ZWRJVExjSElveGJoS3RlcnJi?=
 =?utf-8?B?Mk1YR292bTFoZU85NjJkTENjM2Z5RnBYMXJzQXhGRlBzZkZDTXhKYk5pc0h2?=
 =?utf-8?B?VDFKUG1tMzBWMHB1bnJrZzNSSkdKb3FYeUwvQjlnU2RXZUx4cXdNaGJJaUFI?=
 =?utf-8?B?ZHd2WE96dkJZT3BnOVAwVlNTeTNnT3YzWmd3R1BBUFdXZUo4eFdjcS9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWl2VmJyL010TE9NSFRyN241bFRXVHNDOFJWbWMrSlgwNXlxbHM5Qk5sd29F?=
 =?utf-8?B?eGc3UThxMURWelpMQTZFTncraEpuOE1aYVFxVFJXT2MyeHJlQkowT1MrSm8y?=
 =?utf-8?B?cGF0NnVOM3dWWkhDNGFPbzRidzl4MzRPWkZRZDlNN3JzODBKNnFBVXFrajJp?=
 =?utf-8?B?SXFjTlplUVcxRXZtcGhVSFVYMWNxSWwxWTY0aXVpMHBVamtaL2NINU50QVRk?=
 =?utf-8?B?MUJGaTZBSXFkK1pMeUtKUDdTWFlKM05LS08vU0lid1FsSnBBUWM3Y3B3cVFj?=
 =?utf-8?B?bVRCd0tqRmFyVnExZGN1SG5pUkV0T1VtT3JWZ0l3UWVQRnpSY1c5ejU3UXpW?=
 =?utf-8?B?dUxpczNBTE80SDh5K291RGxEeFpIaUx6TStJeC85ZW1qUFVsUklyNkg5bWlh?=
 =?utf-8?B?RXpaOUZyeDYyS1UrNjRHUTl3R2RaM3JDaUFPckN3ck0vY2tGU09oU3orWmJW?=
 =?utf-8?B?M0ZLa01TcVVVam9TWVVwa0NWSWtxVmcyUitoRXJ6dyt2MS9qaWRibUdkYXkz?=
 =?utf-8?B?RHFkWHd1alJBZCttSWVTS1ZIbkpEdW9qS1dINVB1QWV0Q2szUS9uNysxWjBp?=
 =?utf-8?B?QzBlakxBdzE5K3NpUUk0V3FUdW4rc1IwZXVyRGJ2TmZGVU16amhpeDdQTVZz?=
 =?utf-8?B?MG95NVVocXh5ZEFVSyt3SWhOaS92dXhEOG40TkZmaWsxYnhKVWpZNVpOaVk5?=
 =?utf-8?B?cVp6c1ZrM3Vlb1VuSzh6TVl5c1k2Ry9ZeGltWGF0TkZTVnBzbzJseHBXSDNJ?=
 =?utf-8?B?RjBXTkJqM2dHUDhFZkF6R1NKTUx0NDRySzlZaHVWUnlrZkRQUFVRSHJYRHFm?=
 =?utf-8?B?SHRaQXlCQjNkbklncVNxekZDZ0ZCOVdRdVRWUFVJanZqNGU5REt5TVBtS1ZJ?=
 =?utf-8?B?bWxXd1ZWaDlaKzVQVFlMZkhLSlFBRmFYa1dZaTkvRmpKVDZQQ0J0T002OXI4?=
 =?utf-8?B?UWdEREVtbkU5R2pXUUJJeVdPTXBmRDFZMTdPOVRKcW1hU090WjgwUENRc3pu?=
 =?utf-8?B?am9adU5MMTZCQkgrdTNwTFVHM0M1cTVORVZVRkNRVTZESWc5bkROeEhLM2Vh?=
 =?utf-8?B?OEEzRE0xNXdNWk5oQVhXWk1nckhPbTFOVG91MmRjN295azhFS3pTazd0cy9U?=
 =?utf-8?B?Nng2ai9CWHBWR3cwbWc4UnJVcXVPbjFTSWs5ZWRGMWM3Z2t4ZGVzZ3UwOE9h?=
 =?utf-8?B?WTBUbUpWS3U3bmRJb3JuZ21JWjBldlNmZUlEVGNkakg5OTdIZUtSQWdXejFx?=
 =?utf-8?B?cUZRZk1lS2IwdEVwUmYvTGNFbEh0NnV6MlA3QWhNaGZ2VzRqV1hQOGFjM04z?=
 =?utf-8?B?RFlTV2JBTFZzRTFuNlVZcnB2NVhnTUxiSFB5QVBBa050NHhtZzcvdXREY3pJ?=
 =?utf-8?B?UFhFQVNLV0trckNpVVBZVGg3UjJ2eDNSTXYrQ2VqaUx1NUxlVEhmM05yMmJl?=
 =?utf-8?B?V3FNLzdQWUlYbWVqWUJvWDhxTkpJbGw4Nk5KeDRqUVFyMGhEMTFZa0pyK3Zn?=
 =?utf-8?B?dnA5NEVhU1dPb1JjakhqNTlzaGVjSEN6MjBCYUI3LythUERYUm9DSjVRbnlm?=
 =?utf-8?B?SkI5b2xwQWg0cm94cTVKQ3VUSGFjK1pVSi96S3JJVnYveU8xVDNhUytKajRS?=
 =?utf-8?B?MGtrcExqSnBQYk1XUXVsWVhxRzJ5eFlpNG40dHgwbzd1RjdzTE8xNDRoSjdP?=
 =?utf-8?B?NmJnYTNDUHVoQzg5Z2pzcDBaSFM1L05yK0lkVlhUb0IzeFJuNWV4dVd2UnpI?=
 =?utf-8?B?R3dSSHJKWEh2N3V5dm5qSHAvYXNabUttalIyUmpYeE5aYjlpNUlNUWF2ZlBW?=
 =?utf-8?B?cXFGTDFPZ0MwVm5UWEwwZmpjWDNKVG1KVGIrZC9rOENWeldYZ2FMUktZU3pS?=
 =?utf-8?B?aGt1VEJsV2g2QXlmTmFOYTB4ZG5GMUw5alkzMXZ4cEtnUFk3K09ISkpxYzdZ?=
 =?utf-8?B?ckxBWFNiMDg5eEtDcWNLNndNejRPbEwzSURQbDhEajBzS2dEbVp5a1NseHoy?=
 =?utf-8?B?cDRyQ1dEK0hXOXE4b2w0OU1mWW9YcGJZNXNJS2dqdEhzUi81MDQwWFgzQnhZ?=
 =?utf-8?B?U00yR2JDUGxwSzZ1b0oxSFpVQmJXSGFWNEtrS2NUbDR5aHdkaE9mNGROV1c5?=
 =?utf-8?Q?Q1vX9tDdT0j0PigxIr3hwS3S+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d194d2-9a15-400b-4ae1-08dc70ac2786
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 04:46:28.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPsjYLIIyBNG+eQAQZZtR4PdbAPO9NZCJvzRoyD5+8qOPsnzx2HlqCffEAu2sT3qPTDDyACYlTey3tLz8080yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

>>>> USAGE
>>>> -----
>>>>
>>>>   # perf sched schedstat record
>>>>   # perf sched schedstat report
>>>
>>> Hmm. I think we can remove the duplication in 'sched'. :)
>>
>> You mean `perf sched stat record/report` ?
>>
>>> Given you are thinking of taskstat, how about making it
>>> 'cpustat' instead?
>>
>> Sure. How about:
>>
>>   # perf sched stat --cpu --task record
> 
> If you plan to support both cpu and task at the same time,
> then I'm ok with this.  But if they're mutually exclusive, then
> probably you want to have them as sub-commands.

Sure, will think about it while preparing next version.

Thanks,
Ravi
