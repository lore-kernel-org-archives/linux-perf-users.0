Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020140.outbound.protection.outlook.com [52.101.51.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92620ADE5
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440201; cv=fail; b=YTK2WFRHqdfH/fm20HksM5WCc8K7Sblvq+yeOytWoo3xkbO1TgYYzn01F9OnSYGsUUWTmhO307jXEQ4QCYq0Ic8Q+jMVBxlIZcHngIH2PGPIcbjs/B84ETjyBJGD/JfhI7H2ARx/+jzwpIxfyAuXOBng7clTdbDBquUyuYenEHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440201; c=relaxed/simple;
	bh=oFmCsdQz5F/q/iRdXF5JRtWADR7TIPwdLALoIN8xCUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CptqGDoHD7PG8KoTQtaynGClCN71ys4lJD0rNxcb1FEOsbxWhReAZkfFCPd9k6VavMGFbtlRiEq1G2xIxB90Y4rAmTPFAHdydX944j48nOD09uGgsT3lA9PHtuvmfQPQYoYLZTNdv0Eo+vmwN5JfUs+HRLewRfJMZHVDczVClVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MUTryFL2; arc=fail smtp.client-ip=52.101.51.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MUTryFL2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFuhvxhVQsc1r774QHhNCsP3dVU1+/pc07zbQbfsozqoGYm3M29BJeN9ExhjtNkFYhI+6ksLlLPNRLyZZKOszanuDPcnXmtbAfPz7PEOG9/ISIqzRSK1foE6kc7HBZBY+cPBaFDW8KaTPISKyvWuhMrhzVvW6uJ0nNVDXOMacgSgZtI8TBOYc2l6ETy6ZLVseSzpQILeiqL7k+R0EjkLu8O6OnNxO4aT1cbpyQMryBuz9mjXfg2/jWptPjNB3cE0Ld0kcwfMDXKmVrguAkTe3dZWThHbPm35KnMy+Gh+r68iD7HoYHTfgbM3lDP8TrMxymqNs7mERGnwxORQBbtW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FnBoANiU7XnN84zAl7sM13O5taCsK9rQ9HR/eEjlYU=;
 b=DzUQUTDxG5dSfm7dHGmvUd/pEJ60W8sIe7zbwnPp0dQsqplIoj4yi0jihcUMTezj6D0W/rUqLX19QUjZtTKf3OkjrPjo7RRI8+YpQPypgSykMCrGEGBi0FxncFiBMVX4e0y0lNDxDfbjVl8nM+KO+pm3ZL/8q0PavB2OgACxh9B87UeIDTc2u8E7YxcBSsO3Vtk6qyHlR3xpHrTnXeEsO6w8hJ/4rwLWsX+rVFlB5z5O+E9Bs1P8Tj3qikZ5ECING4zdv4diC063/8VxqPQYxUa3taBBCQCrYt7rOm9pYqFx9Zu2gWYr2TYdJ0e43RnZCepnI+V7Rge824FE2ckIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FnBoANiU7XnN84zAl7sM13O5taCsK9rQ9HR/eEjlYU=;
 b=MUTryFL2dl0mJ351geVK3PzuJWyd7BPydrMdp/00xrXL6bn//pS6d+7T0+xmMX/y56vBz9TwEFD9CqqmCxKd/LQVpHEHSY0vzVLTpTW1YgMJ7H3rf4s6C1lEle8LaVv9AmKNh//DyU/1/wRK6wNs60Wz+9jfuS2NgDVE+0V1VTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 DM8PR01MB6869.prod.exchangelabs.com (2603:10b6:8:30::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.16; Tue, 12 Nov 2024 19:36:36 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 19:36:36 +0000
Message-ID: <17f62268-f3b4-46e3-accf-eb42dd2436e3@os.amperecomputing.com>
Date: Tue, 12 Nov 2024 11:36:33 -0800
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V11 0/2] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
To: Namhyung Kim <namhyung@kernel.org>, leo.yan@arm.com,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1731027120.git.scclevenger@os.amperecomputing.com>
 <cover.1731027120.git.scclevenger@os.amperecomputing.com>
 <173117023647.3738736.13855747983305853936.b4-ty@kernel.org>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <173117023647.3738736.13855747983305853936.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|DM8PR01MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 1494f5db-e902-4f80-c723-08dd0351521b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnlhdkZ4b2NMY1RTanRydXJqVk94RllCZnRFWmlnbTBUNi9kdHpWeTJCVVZx?=
 =?utf-8?B?ZngyMFhtWjNTWE04TDZvS2hkQk8vTEhXSGsvQzA5M0lUcnJqUzVaUldRa3FH?=
 =?utf-8?B?TXJVdjAxVk5XRWlnZFplMXNhZzVxVnZya1d0anhQOEFDRGVESVBFb0Z0MlA3?=
 =?utf-8?B?NUpMMStTc3gxK0p4SkJwb0VMVGtYUkxZMGdzYzlrcENwTGVLZFBEQXl3YWNl?=
 =?utf-8?B?ZEVITCtIdGNnL3lDeEdWR2JqbEo0Sis0aGRHallienpGQW52NEMwcGVVQXJF?=
 =?utf-8?B?OHFGdzVibkJmSU9VR0tTRG1KYVY5NVhZdzY0WFVuN0kwREVlbFpQWDErRGx0?=
 =?utf-8?B?TGZOZkh3ZmtQajdsMmRMV1RrTjdFVmo3REdDWWgyK2ZUbE9rUllSaUNPTnhm?=
 =?utf-8?B?Nkp0aXIzR0J2UTFWM1U0UjRtNEJORFZXbFFpR2ovQ3cwaGp3Mmw1Y2NRWlJM?=
 =?utf-8?B?NGVROVlhaVpybG5PcWJYYkI5V0crM0xZaGQ2NEJsS3BmQ1dPQm4vNElhRVZa?=
 =?utf-8?B?TVRBTUZuN2ZuMjk5eUFrU2FGZWpkWWROUzZPZmhYUzVHVmNTY1AzL0RZZDNX?=
 =?utf-8?B?Vng4WU92Q0RuTEV0ZWM3dHFNVUxvSFVwUjRacEUvWlFRWGxpSnpCRVdKMzdo?=
 =?utf-8?B?RUUrY043dHRPS1JwT1hrRWRwcjNBRkREN3gyNjZudml6N1VCTjMwYzVUYjJI?=
 =?utf-8?B?STdWVG9JWDYwaUF0QXc5NTU3YU1KQzMxOUEzTW1GTXVwMjJiR3RDc3ZJMDFK?=
 =?utf-8?B?bUdTTFgxZHpETWVyaHpnaG9JamYyL3FEbHBPdDY4dTZVcUdsbFpCT1BGQ0Zy?=
 =?utf-8?B?MGY3bEJFeUxndGtSWVlKMStRd3pYcit4NWFUdjJHZUVJaGdnN1pNdGU3Q2lK?=
 =?utf-8?B?M3FzUlJjTG1VbkN1eEZpWGpERGxHTytmQW4yM29FNlV5L1MyN21STkI1Z00r?=
 =?utf-8?B?d1BUQWorQVcvcEtUMHVEck04SU1HTWprdk9VRURZSkMwZmFDc0RQUlJnS2pV?=
 =?utf-8?B?cUZqWGJnSnN5V1VPR05EWkRBdFZmTHZ5UlRpM25sakc4c0RHMmxQaDJONFpi?=
 =?utf-8?B?aTB4My9IemExandVTjVBbDJMNENKcDhRSUVOUzloRSsreEkvYTZqSElpeHBm?=
 =?utf-8?B?c0w4aVo1ZldXcW10NStCa3VYRUtlUkNWUXF5Nk42Zk94bXNONFNjcE8zUTdQ?=
 =?utf-8?B?SWhacWtud2U1dGExMm01a1dxejdZVDU3SEVvT0lWNTBVc3E4N2xRWFVjRDNC?=
 =?utf-8?B?eSthd3RzMCtTNG9ieFF1K1B6Y05iaG5FalVVWVEzaWVIN2VleXdIenl3Z3NS?=
 =?utf-8?B?ZUZwOFFPL2tzNHYzbXhyQlVseDdqSFFUZnBTdHVqMzBtN0dhZHBVVTRpTmNr?=
 =?utf-8?B?a1VkV3JFQ0Vyd0JjNlFLdUlpNndGNlJvbWMyVW5vSWlhZ1A2TjZNYW9mNVVv?=
 =?utf-8?B?NVM4UUo3SFM5RTM1M2ZDQ05wMFkxOUtvRnZXN1VqR1RKQWl6cHhhUmlzTkRk?=
 =?utf-8?B?ejNBd0xBSGxlL0VLN3RqODZSWTlvOEYxd2JYTGt4WVNSTVVhV3ZJM2MzTlQ1?=
 =?utf-8?B?a2h2RXcwM3UraXkxbVhLZDFIcTVjOHQvMG40UjNIZmtSSU5oVVpRRE9mQll2?=
 =?utf-8?B?Qi9Fc2JnZnp0TURMR0EzcVN1M1RyVThrWHNyemhlRitLRWl4T2NWaWpPS1Nl?=
 =?utf-8?Q?uGA94PTtRekdeXBUpCZG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVBXMDArWW9QVUk4REZMZUUwMU9ndnd4T2NKSkRHMFdUR3JEckZEeHdQQUFw?=
 =?utf-8?B?a25UMFU3WlR5SE9Lb09mVjJBajUzbHJKUjZzM0h5UDV2OXBIK0d0eUg2VkJL?=
 =?utf-8?B?Q0NHdXpVd3hSRXdYYjl1elE5ODhkSnNOczBaNnM3aWE5c2w0SHQ0NzBPVE51?=
 =?utf-8?B?NTFLSVBCc0hPaVQ5cVdjTnBFNUp1UkNzbzNMSUlkd1BsWmhMeEVzV2FPd1NZ?=
 =?utf-8?B?dXR4WFNTcXd1VGg0OExrOU5NTTc1SFdYdzkzYU1PZldST2JqTkIvOFc4WGRl?=
 =?utf-8?B?ZGQ0OFFHR3ZJaE9Gb3VqTVFpdm9kWHpGVW1VbVNoSDU0TEtGaWJMdFg4MzNa?=
 =?utf-8?B?RVl6NklUb3p2NmFMMVFtMnpxbG40UFYyRGVOSE9IMTZXYWhtTm9xSnp6a0FG?=
 =?utf-8?B?LzlvU0RkMHpCSGtxTmZiWURySmlncERFNnhvYU5wQzF6N0ZoNVlTRU1UVlkw?=
 =?utf-8?B?TUpTNFBETG81RlkxNHFVR0FJQ3lWb2JrYi9IeDBVQTlOU0VqMk9hSEtlVGxO?=
 =?utf-8?B?cHN0djhVUHhrRW5GUmk2eVJRVHhDRTM1anFSSlBNSXc1Vjh2bTdsckJGcnV6?=
 =?utf-8?B?TU9RQm9qNzVQczlCTmRVRG5yRm5UTXB6SzNHbENseldVdVExZGNTemlVMDlm?=
 =?utf-8?B?R0tkV01DaFp2VEpUdTlCZTRCWVVjRnArK3RNNzIxREZ6MDVjZ1dFTTRpTzZI?=
 =?utf-8?B?dkdhTmpMcFFiOERFSnFLbG0rWjloS0M3aERPRTNxRUtpWHJpamRtVkp4Tjl0?=
 =?utf-8?B?Vm84dmRLWkIwb1dUajRLdXY4RzNraUZJd0ZrSmlycWpXSFFyRm9YdktCRS8x?=
 =?utf-8?B?eHprakRuVVVSdmNVb25hQTBiMzFFMHNaN0J6QldKRDU2REtZUUNtbkcwSEdT?=
 =?utf-8?B?NlBncXQ1RmNpV21XRFB3Y2tWb2d2SUlMUGFFZWJFTi9YODBzN1Z2TWJYVzNr?=
 =?utf-8?B?akxPbEZPRFJvQys1V1FHWU5aMmdlOFN3REtPdU03ck5hS1lTc2hDWTdIMDNu?=
 =?utf-8?B?TFh5VEJaWEZVMmFSZWs5Q0dPR2RLMnN5MXJXeTJ5bndMT0hEM3gwQnRrWkZ6?=
 =?utf-8?B?VjMwVTVHRnI4ZkEvOHlpbnpySkVwVVdzbm9POEhBVDJJOVRBd3R1Ung1WEpw?=
 =?utf-8?B?UVVvSXZCUE9zL3BTdTNmSFF1M0RsMW8yMGlhd1IrNTQxUU5lOVkvaHBSVkxi?=
 =?utf-8?B?T05tbzh2RmkvSmhXSHJzZytZV0YvSHljWVYrQzgvMTU0Nmh6aXcxNnZTMlBC?=
 =?utf-8?B?RUtQRXlWazF1d0czWkxkQms3cGdvdzhLR3NXV2xNd3FNeDZ1RlMvM2NXY3FR?=
 =?utf-8?B?UndJMzgrZ0NtcXowZnhVdlBFRGJlY04xcWhPbVVJQ3dPL0hTU09JTHR1aENz?=
 =?utf-8?B?QXltUWc0OGg5amdjUkROeDNnQjBMWm9xUGtHdlRTS3llOWkzWVhsQUcyOWNh?=
 =?utf-8?B?c1drMlF6MUFLbnZlWlZpV2RhWW8wV2J6Z1RaR21MOWtnTDAzdlZWR1FaQjZQ?=
 =?utf-8?B?V1JPRkpnaDNabndidXQrNDFGYWtTWFYvYkxPU3IxS0RRVzdXSDJTS0xVUUkz?=
 =?utf-8?B?eFh0RHpmSE81YTlrL3c5WFpxU284RTc5UWJ0c3ExSTR3Rkp6NkY2NEZIemZ6?=
 =?utf-8?B?V25uazRsR1lrbWpGWFppdGh0aXZxdjNrTit5S0dBZzh5Ni95TzVabXhGbVJP?=
 =?utf-8?B?WjhvWXBrbjNvZlB1TmpWQnJJczdxOUd0bzk4eEltd2ZOdkFuRUJhc2JCTGF1?=
 =?utf-8?B?OE1qWS9IVE5jQTE0S3YyMk01ZTAwTmNWOWQzbnQxd2hGRm1xUnhmTDhzQy9O?=
 =?utf-8?B?b2hIWlNqNUVNVFQvTXMyNzBoSFVtSUlZWGlBVzJCejRYM0RHdnRZMnZESkZ5?=
 =?utf-8?B?OXY0OVVEZjJHL1NhL2lTby8yNkhMUzE5ZC9mMFFsSVdqRnVvdGp6YlJuRW0x?=
 =?utf-8?B?R2hGTjdlemtXbXMybWk5ZFkxTXpMdzhZNHIyT3p2SU5rOVBZQTBuVFgvZmtw?=
 =?utf-8?B?azBzNU9MWmlRazZ4MmhYcEhRTnIwUnFOa24xbUNsM0d0SWxZV0VMbUJ2WExW?=
 =?utf-8?B?WTY5SUh2YUdHdzVUMm9tR1dxMXpCMnlVcmRqVzhTUTRIc2xZUzIrd0NySFZu?=
 =?utf-8?B?YVAvYWZ6YU5UUWdSRkw1OWh2UDdTOFNLQmlSM0VvZlZQRENYcDh6b2pLeWlv?=
 =?utf-8?Q?0cdKxKhvyNM8FnDtcCeGwJY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1494f5db-e902-4f80-c723-08dd0351521b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:36:36.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdZjTYkrXkP/TtExIQQJLy0TqmLpMjrilLyO6YfuJkOVR724OOKRPZK1WcFxBtNBk1NYjt76E8oXbNOLDvsXx1hOrXbJLLZCe17nFQXLpCpGgftdXv8Ss9AGGQh9wH2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6869



On 11/9/2024 8:37 AM, Namhyung Kim wrote:
> On Fri, 08 Nov 2024 12:11:19 -0700, Steve Clevenger wrote:
> 
>> Changes in V11:
>>   - Corrected prefix.
>>   - Fixed compile-time error for perf debug build by substituting in
>>     the map__pgoff macro (trace_event_python.c).
>>
>> Changes in V10:
>>   - Removed errant space in patch file 0002. Passed 'git apply --check'
>>     at perf-tools-next, 6.11.0-rc6.
>>   - Added back missing prefixes.
>>
>> [...]
> 
> Applied to perf-tools-next, thanks!
> 
> Best regards,
> Namhyung
> 

Thanks, Namhyung.

Steve C.
