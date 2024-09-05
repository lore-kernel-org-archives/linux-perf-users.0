Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDF33E8
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495137; cv=fail; b=USUj5qBZat0l2qAwoK4z4duaBKN3of1oO214LSMk5JN0hBeyvQfuuSUea/nmKTwhmyyEfdcgkCZG/qUM/g8PvXN74L5vmNSMLOR5cDkUYHOWwFTubTMTa4Cm0KLwWYJGXul2Wr57edK+kUxK1jB97SJqCpwL6q7SAAa9AqtrA70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495137; c=relaxed/simple;
	bh=AaTqilBGbHgN0QgL031LO4qR3N+FCg0ta5f5tYJNJGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=An8iW7RqpdSSsufdN1UA5U+c95xfz8+EJZPE8WqaXk2SZVy/LuEXq7y4M4AcOlO+jSIa4VIgWkg5VLiN7qPGcSn9/C0OBUt+TKaF7DGtqZPes8DddYWZLifKn6nHzOeS8D0KHu+4qM04hlL2x4lG4uOiTrtmrH3pCLyHx8fw2cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RkrbwVyN; arc=fail smtp.client-ip=52.101.62.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RkrbwVyN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HofWpih6/Wb/90HwQUN5vl1IhBxqGZ8mDTRR/qteaKmOp3YBU+0BGcoVHPNHp1mwDKaUHD1ywlYScBNYROG8dxwx9t6ug68gf3UtzbKiZo5VyU9jOUHj5XumgNdWx9BxdLvVXVXGL6rMe7slA9EsG4n3QcezglikRmDy4LkYnutAD2JVmxG2ii286jkZypE2j+OFQzQqHkmflD8qFaRp5RV04YbA7urEJftBjnzvfPIYXu/7fQye4wGC1m66V+y3ZmCkLjZuBiUQzr6WiCyArhMkSiEVQcbmnUIFBF6oFXxAqwCL8Ik95xWdxb2q+teQx611KkH0xL51lxxQt0vQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vde1RhZn4Nnk8Yd4s26pbPnI2jqVYJavvhAarBMb1k=;
 b=weKPsU9LUFKQGqCrsY5yUh1+dZ06wvCG9XyZxzAscT9TidfRYgA0bwjJ9TmORxtwjp4NP+TmGNgyF/yzgZTN+S8ZYUVsC77Fq2ZP/YEfnDi2oswpu+R1xXW57b6se93SPD/eHQdIEwIT+yTcN0Z/qVFmhgU4wLoY/GTMozZIk3V5unavVQVChpmEjsSNvordaj2cX7M+1L4uzVCh+83Suqh8HdeivI2nZKC8veOtvva7g1KGlNgQa+6PLaXGjHUfYYshvZjnvNVSTGdUx0yrMU/h67rkioP1WILnd2byyKDypPNnJ97ax6UZttaRjA6jSX+kgHYH7JSUzT2AgGMG3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vde1RhZn4Nnk8Yd4s26pbPnI2jqVYJavvhAarBMb1k=;
 b=RkrbwVyNKb2pJVSrRmIpPLvlcmYBBx3NxtEy1TCNv1gWT5ZAgtlsLvcBrN7klSiqt9WkhSmVt5LHh69Or2HaOw/6rVqySjf9Dlt/BtTULITw2gypATXu8HZBe5BlHhu5i+WiJ1aAKkVPD2eaE2OPaUF8iHhIae71Lj0eUKNnMpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 MW6PR01MB8365.prod.exchangelabs.com (2603:10b6:303:248::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Thu, 5 Sep 2024 00:12:07 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 00:12:07 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V6 4/4] Adjust objdump start/end range per map pgoff parameter
Date: Wed,  4 Sep 2024 18:11:29 -0600
Message-Id: <110501d82b12ea7909eb7d02899ef60ea42c7e19.1725493961.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
References: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:610:5b::24) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|MW6PR01MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 51043bb3-635b-4dac-ff2c-08dccd3f60cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTZ6MFZ3WnRhVzZiYjBxOHVIdHpxdnNnUjRBZlVtWXRFZEdqU2FvUDkyWW5C?=
 =?utf-8?B?MDdoUWt1SkkzWk1MRnltMzhJa0Q1OU5NR29TTTRDWlBlczg3d29ka0RZejE5?=
 =?utf-8?B?UUczdmExc0ZldHluMUJXSFQzdzFHRUQxVkFYYkJQRm14ZklmOTJGUXBwc21w?=
 =?utf-8?B?L0dJd0pWUlR4ZUxhbWU5NWFJZHd4cWR3TFdpbGNhOFczVlJUUk9jZEFqbnFV?=
 =?utf-8?B?VEZMb0VleTJYTlp5MVNteDdBUFA4OGpuYUN0a0tVUk81YUlLR2E2SjJYeVBP?=
 =?utf-8?B?MGJkRTMzQ0RVdTVTbGg3ZWpvZHc3L21BRFRPMmhVN3R2Slg2YnRocW5zaEVO?=
 =?utf-8?B?OU9TL2hGSlNqT0M3bXY1c1dTSEpSZDhwS21HRGhSQTJZbDhPN2pZUTdIVFdN?=
 =?utf-8?B?em9sYXZRQjA0VmRYWSt6YjVVZDZtQ2JWTG9vZWFBN0dIc1JRYXFXUjIzaHd5?=
 =?utf-8?B?ZG5MS2QvRzNRNGFNWDlXK1U2MnRaS0d0ZDN1ZlplMXdBeHB6TmxnMkpZMmhs?=
 =?utf-8?B?WTVxZjRuUy9vOHAwckluZzl2MGlsdGJWRG1nT3dHREdRQWdEUVRLaEpUdXZh?=
 =?utf-8?B?dDlXejR6MDdtNXkrWTlEVmtYMG12dm1JRXdRaXBlVy83ZmIrSzFTYmpWWW9R?=
 =?utf-8?B?SitsWkRsU3FZTkltb1BLUmlCVytGYnFReEVMa3VmT3U0cmFiTWVvci9hclla?=
 =?utf-8?B?aWxqNXc2SDVTWTNxeWY5MkcxWkF2aVRpY1M2WmRseUo5REZjS2RUb21kWTFN?=
 =?utf-8?B?djJPMEtCYloyNEZ1WmdlcU5mRkgrcFg3ekh1N3F0UVNNUEFmcU95V2NJUUQx?=
 =?utf-8?B?a2JLUVVCOVpzbGY1R1JvUmRpRU5RMWZYdTdLQ2ZLSWI3RTM5dzEreDlGNm1S?=
 =?utf-8?B?NE5HVk9LOUYyR1VMMHlwRDFvd0J5bk56UzhYTkxER2lweWk3UVl3TDdONjBh?=
 =?utf-8?B?UVBqWG9yQ1QxVm1nbWVHMnB3Y3hyZk13emoyUGJhOWZKUXJrcXJlcnBESCtC?=
 =?utf-8?B?ZkV6NUZXamxDc3M1R1FSRHlCOGRMY1pkcGlPKzBhYmM5Ync4S1lnZG9NeW1B?=
 =?utf-8?B?NnZvbnpuZjBUcmx2blhrRU9TZXpVaXQxbHlIaGFMaW8xY0o4YURzR1ZLZkVl?=
 =?utf-8?B?WFZTUmF6YnhVNXFzVVFZTUR1cVgvbFcrOWhNa0o3cGVVOUVJV0NjaHIvZ25D?=
 =?utf-8?B?V3NmNzBXTlNpMVpTQ2N5MlJ5a2plOU9kaWNSMzZCNXhQc1JhcWpmRWQyeTN3?=
 =?utf-8?B?RjNxNk12UDI0SmFOV3pjRHdyR0paLzVvNXJOM1o4UWJ3VGN3MTJlTFlqM1kz?=
 =?utf-8?B?RDd2UXRmVW1USjk0QWZGVGsrSVVFTHRaVVVNNG1QSG0ybktKZ0toL2FlS2VY?=
 =?utf-8?B?bVVzcEUvTFI3SXVPMjNhSkNPK2IyeENZSXJGZmh1NVRVRm80M1ZJTHFCV2Jo?=
 =?utf-8?B?dm00QWtkM0laZ3JDTjNtZVNEZkhPWnRLSnpZanJ6YzNpTUlHRkcwWHEwZDhu?=
 =?utf-8?B?VXhLb3JZYnZ0UFhZcXJ0eVR6bitYNDV0QXBNditsQmNqdEpOa0cxNDNtVWNQ?=
 =?utf-8?B?NHhWYS8xWFlPUklpVEt5cDBDZ2RVaUNlemptTm81WEo5SlRqVkNBRVMyZjU1?=
 =?utf-8?B?NlVYZnloMjhaYlhPemVic2tERjF5cFd5TzdOYUxHZ09BU2pZdUh3dzM5UDdN?=
 =?utf-8?B?MEMyWmkxOVpQSTN1bU0wWHJkaXJub0FTNUJjRmpDY1UvUjFXMEgwZ0xsaUdC?=
 =?utf-8?B?NDdsRlVwUERsSTM4UHV3VTRHTnoxMUE0NVdSenhJL3RVU1hFNWJET2VjdzdV?=
 =?utf-8?B?MFU2WG81Y2g0ZHdHcTIrWm0rc3dpL3BqZVptZE5WUFFyOGh2ZHkwNDJFNjRP?=
 =?utf-8?B?aWRhOWg4anZ5akU4ZjVQMTZMMHVWWmpydkd3UlZJN3I5RFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUJxTWhHOTZHNG9aVjZXVFN6SFFVUXY1NVhsV0pUMTNiSmRxdlRBemxYeVFo?=
 =?utf-8?B?eER6cVpVcWlwenk1aWZRYzgzTzZnWjR1enkwdDJSK1F2eW9ZVnQyNEw1VGFL?=
 =?utf-8?B?K0JJdlJVMmhVVm1Hb2FTVWFRTjRtN2Y5SnZVZ1Fka1BqL0MxTmlrWXd3enpM?=
 =?utf-8?B?ZlYzelBicGxnQTJNaTVTa0g1NElWczRGR1dpZUs4eHAzSkZwU2FwUmUxaDha?=
 =?utf-8?B?RStUU1Jab0lNbTZLUHJMMFdmRzBnNERrT0Z4SWpzZWp5a1ZXZlhURlBTZzlw?=
 =?utf-8?B?YXBOdzR1dkYzdEtDSDJGTE1kZzBZUkFmcklyODE0UzRKR3k4aktWMFVCYWJz?=
 =?utf-8?B?aE83bVBRZ09HNEczd3lsbStiOU83bFRLSnZPZDczME13dEJYc0xaWXA5ODBm?=
 =?utf-8?B?My9RUWJtUlduMUp2OTJNTHpDYmNXVmZndjRybHhPYmdLS0d4M1BicWkvWTdm?=
 =?utf-8?B?a0FiUHFGZllwMTNyWkk0Um9XaG1KdDhTb2x4MVpnell5azA0eW5FTk1EL3I1?=
 =?utf-8?B?bEFLOEI5NjFBRFFvbnp2bndRS2J4YjJjVktlamloSk1Pc3cvZjR0RFhFazZN?=
 =?utf-8?B?SnpkZ1lvNGNSRkx2NnRmQ2F6eEQ2d2J1SnNIY1pEMXpscGxJNENJV2NxUVVU?=
 =?utf-8?B?YksvZUZLL0cyd2JBeVZSOTVMd0sxQS8zM0EzTWJHckllZkFMVTN5VGhIZzBl?=
 =?utf-8?B?aXVMRDgrM0luUDFJenh2ZmNHbitEWWt1SnZ6VWI5MnZwbFAxYmExUm04VWtz?=
 =?utf-8?B?eldxT1h0SU1pemhDT0RuVjQxSHQzTGtRWjR4MGp5T1BEY2MrL3FCZXlUYkln?=
 =?utf-8?B?UnpjUDd0aG9NVStkZFBLaWxqMnJLM254L0RmMjh0anpLc0NxMU9JVm14ZzhC?=
 =?utf-8?B?dmE2WWVvZ25mVDBzUTNaVzlmNnhxY245eTdwWjg4M2NzR2ZRTEpHRWVKVVJW?=
 =?utf-8?B?Q3VRdVk3R0I2T1Z1bllzQzJPRzFqbGZjS0VGMEg4TVNBS0ovSWNYRzRQdmli?=
 =?utf-8?B?UG0wNFZraFYxeklpekw4UzFEVjM3K0todlgzSVZNbDZ1R0hDSWFtaktwSW01?=
 =?utf-8?B?Qnh6ekxZNktRSmtXOXJHaW5aMkpxSXpOR2IyczBlOTBlSVZDTUIvbUc4VkxO?=
 =?utf-8?B?Rzl2ZENnVWVqbCtLOU1xdy9uTHdqNmtUZW42aS96bEN6MDlIQXhZMTVSYkMr?=
 =?utf-8?B?ejlsWE9uajZqZEg4YzRBOFJXenVOODNPN1hPcStucllsWUlIS282emdROTZw?=
 =?utf-8?B?ZHFDQURsTTlZQzc4c0NGNGVzT2d3MmZPVnVNbUx2Ri9ySUg3RDhWZWJ4bllU?=
 =?utf-8?B?TmkxTDZDdldsbHJHNC9XaFBuMlFoRkpReGM1SUxUNkZqZHRxQ3FzSFRKQ2Uz?=
 =?utf-8?B?UlhQYzVCd1NkdTdKNFI5UCt1b0VIWHJvVFB6dHBzaEg1VUI0MnNXT3MzRzJl?=
 =?utf-8?B?UE1KbGxUSjlJWjBoSUFZOWt4Y3pSdDYzYklSQm9rWks4ZXVrOE1DV0pOS2Uy?=
 =?utf-8?B?YXdBUGZXanhrZkFrUEZQSE9ySUpiR2ZBVjh4R2hrRnBNanpxeGJIQitlUFNk?=
 =?utf-8?B?dDE3SmJobDUzQXNwWVd6SzlvZ3ptSlZsQ2ZRa3dwRERVbDQyS2psMENZNWsr?=
 =?utf-8?B?Yy92WkVPNU1tRkFrdlovUkRCZHVyZVVzQlRNcGhUOVVKKzBraDB6Qk1vQ0ZU?=
 =?utf-8?B?UllOUG5jcllJOWIrNzlnUzFPS2tidjE0ak8zN1ZJcFdvU1hkOWdPM0UwOTFK?=
 =?utf-8?B?UjBMb0kvSG5YaDRIdUtlMDQ4aDNKYUJLS2IwZ3lhVlJqaFJ5QXhRcXlSaDkv?=
 =?utf-8?B?emR5akY1Q0cxckE3MDNjTERjc3psVkViUnM0RGVwKzhmN2EwUkVsSENSbCtK?=
 =?utf-8?B?cW4rNmlxc2JYQlR6RE9KMFVacEdNeWh4WVhMVXNnd0V6M3FkZjJPOGFHYjEy?=
 =?utf-8?B?OFZzc3JYd3UzUmIybXVzRVVZVmhobUd2TnErN2haM2dUTDlFNzdOeURIMG5a?=
 =?utf-8?B?SmlJbGMrNCtNQkQwSnZ5MFlZeFJLWFF5NWtyMWprWUV1b05TcWpScVlpR2Ja?=
 =?utf-8?B?WDVwbFhIWUFwdk9wQ0dqMURkcnRwQUEvcHkzS3F1TFZRTlQxT0s5TURlelFv?=
 =?utf-8?B?REhvTGl4bDlmY2xtdVh4R0Y3bi9UcUhHR3ZFdFFrTC8wbGhFSmF2SUsxMDY4?=
 =?utf-8?Q?ydcbNcjKT4POtVrGxteGe7ExQserEV0+A3cqB69sGsnU?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51043bb3-635b-4dac-ff2c-08dccd3f60cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 00:12:07.2079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpgTQDpSy+jrjlEA4B2WoaujFYv1AOg9iHBIp9rzxOFBONAhkwsB/bPKHzzqRWvFbKOc0vs+6El92oXyi6HYxYKo+s/gtg7M31zan1I0ukqGjZoTS0d1HlMaHeksGe9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8365

Extract map_pgoff parameter from the dictionary, and adjust start/end
range passed to objdump based on the value.

The start_addr/stop_addr address checks are changed to print a warning
only if verbose == True. This script repeatedly sees a zero value passed
in for
      start_addr = cpu_data[str(cpu) + 'addr']

These zero values are not a new problem. The start_addr/stop_addr warning
clutters the instruction trace output, hence this change.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..35a2ab60ca12 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -187,6 +187,7 @@ def process_event(param_dict):
 	dso_start = get_optional(param_dict, "dso_map_start")
 	dso_end = get_optional(param_dict, "dso_map_end")
 	symbol = get_optional(param_dict, "symbol")
+	map_pgoff = get_optional(param_dict, "map_pgoff")
 
 	cpu = sample["cpu"]
 	ip = sample["ip"]
@@ -249,11 +250,13 @@ def process_event(param_dict):
 		return
 
 	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
-		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
+		if (options.verbose == True):
+			print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
 		return
 
 	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
-		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
+		if (options.verbose == True):
+			print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
 		return
 
 	if (options.objdump_name != None):
@@ -262,13 +265,14 @@ def process_event(param_dict):
 		# vm_start to zero.
 		if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
 			dso_vm_start = 0
+			map_pgoff = 0
 		else:
 			dso_vm_start = int(dso_start)
 
 		dso_fname = get_dso_file_path(dso, dso_bid)
 		if path.exists(dso_fname):
-			print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
+			print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
 		else:
-			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
+			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr + map_pgoff, stop_addr + map_pgoff))
 
 	print_srccode(comm, param_dict, sample, symbol, dso)
-- 
2.44.0

