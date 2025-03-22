Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088F86353;
	Sat, 22 Mar 2025 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742657969; cv=fail; b=qZ8Skn73UpXcXd4QjAfChVPtnvxwH3vKQwl2eRJsCbsyqBCdWHC2t/CyIEJQOTdEOgMjGfmfvN7c23fbEL796mXXpm9H6sCx9QyUOkI56J3QrSoXHVNtf6ldrmKN7R9qSkzAM4LvDKHVhXB8KFr4vGX+tNCUh03Wa7f5hmbaWf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742657969; c=relaxed/simple;
	bh=mkS0ITX93Pd0kl+nvVodpi9Ozd2ngTpTVkPkwuPyzS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EzFH8s+pMOo9Yq+j0GunRs5eQMhKtAijYQOJ0wWFAHlIWERxPLa+Hhxv1qLFxLyMgT12u14hS4oRWQkqnp84c7I7hUoVJPlOTyvBt0o0klOf0XYAIg39/XaYm2Uyw0ZizFaZ7W31rWGPsyIPB2o2S3Mh2rQWh1691eqR439Kr58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=abTU5Cv7; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="abTU5Cv7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRzyAteUDA1JvL3Dx1cNioeu3ywqkZZOgCl1yeAvt4HsLoPPQa4L6VYWY+BJNH1XbiH66xzbL3e/MvqqdH1nq0WQ1PtKIem+vic2f0r4krUikov1Dvq7Pvxk4yoMfjwGshC9dghYBuc5Fn9wKFy6V/cuAVI0lKiObvHvaAhvGGGKv3t/2zAlhsr7L1WTRrr9+9mjadH2xiFroyYKL7MfHUicezrTJ6+4sgY2NjjammlgRxncEBIF2pM51m2+hSGJr39aht1LqYzjav+b2AmEwjRJWrjujX7MpZ00jtdiXCIalzCSBKSTvgs7LkjiaEtvU22gT9aXkPFgupLwz9dxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcAB3aTy2x8+WVNPKz7l7mj+CYpe2UEPSaWO+bp69XY=;
 b=HQ3n3zwttnLcAA9/tDdAhtJrCIqMh8tTF7m0/8tsJYnSq8ML04ao9HHy1kU6IuHEFzWzBOYX4V5s32sceA6hQTxbraQb5wODnp0dpvGD/gj2uOhk8NIxdHayIP5z0ewCBZWg0OH2gXfFqr7B0+1tiNzKhO0mwyOJzvrI2Ceu+ADq9TioAP5Q5xI0GfuI7CiPrVPkVnT/FunTc2OAb1gOD5nyDCzihwwMVm5hE0VWVa9YGPBr8AmKN+fMhV+hvvzbVWo/GvU7dClvt5u6tBfUXQ0vr2RYzKmdKqbn/p02UD+WCGcJHWMluIm7QeaNCRViKJbc0m8yGSp+jQcviZ/JtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcAB3aTy2x8+WVNPKz7l7mj+CYpe2UEPSaWO+bp69XY=;
 b=abTU5Cv7rzUBvJ6HEo1Zxf4Mr/s/d979QjakK5Tzm9VKsveI/c/gL7jMudBw0Qey0KTLa5vEtXlWVtvMyo+n7lGDuFZQoama5nLI/rtmXaTiFXoe23uNZ1wjgwzOOxRAxW92YByd2euSLDh2hZGiQ2FiOZzw+ctoF2+QZBDlykE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Sat, 22 Mar
 2025 15:39:25 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 15:39:25 +0000
Message-ID: <e54ecf69-9b44-4a15-93e9-4cf294b85584@amd.com>
Date: Sat, 22 Mar 2025 21:09:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 tip:perf/core] perf/amd/ibs: Prevent leaking sensitive
 data to userspace
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, namhyung@kernel.org, mingo@redhat.com,
 acme@kernel.org, kan.liang@linux.intel.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 matteorizzo@google.com, linux-perf-users@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250321161251.1033-1-ravi.bangoria@amd.com>
 <Z95lo6J37emCRvme@gmail.com> <7c9a00c3-b2a0-4f8a-945b-cc90e492988a@amd.com>
 <Z96qQm6qqRRcSL9j@gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Z96qQm6qqRRcSL9j@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: b329601a-9216-4e14-c2c5-08dd6957b957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmYvNnFjblhHSm82ZnltYkpnNkFDdzBDd3VqcXVaUS9qdDgwd3VRZFB6MkZR?=
 =?utf-8?B?TXRVQzRmeDFYSEZEUmQ3MHdxSW5YQ3AzUFZOdVhRMm40cjNXTEJ6N2tEUkI3?=
 =?utf-8?B?Z2pJUnZ5QTZwQ3BzYXQvOE5CQlNybGVNSTVlcGtidmRVVWRQQzkrVFFaNk9K?=
 =?utf-8?B?VVFxQzkvYklVNkdTby9jblg4N1VBdi8welIwZ0xLbjRhWVNEaVFGVGsvcjA5?=
 =?utf-8?B?YStCMENyM2hXd3REU2pqTnQ3ZS9ITTF5MnRYV3J3ODM0U2NqVEVPL0FmTnR6?=
 =?utf-8?B?MmdtL0xCaE1UVnpEamlPaitKM1dPT0FsUi9IWTcvUnBkT05WYzlRVThHMitS?=
 =?utf-8?B?QmtUQ3ltQnNqUGhNU3BkQlY4RVl2L2lFUVRCbW15MVhWekVRem9kaWRTZGhr?=
 =?utf-8?B?MHNlZzY5TWZGTGhtTVVuWnVobWNnS3JYUlVrb3lkSFVJZTZaV3piMmNLRTMv?=
 =?utf-8?B?akd5bWVMZ1AwZkVOcmdQUDhvd0o1eWRUbmJUWVErNFNoRmxsQUVrNUNvTWZ1?=
 =?utf-8?B?UzNYakMxOVh6NEVQelBlZENEZmEwdnZMMkRkZjVpY3B5STFPaHROWmRjUGk4?=
 =?utf-8?B?SGMvYzYrU2ZkRm44K1l6YllWYi9BSTEvK1Q1cVN1bm11RHkzbmcxSEcvZE5i?=
 =?utf-8?B?TlFuNk1acWl6Y29CdDMzZGxObTlMVXB5MDBZM1U5cklNRnIvU0QvQi82VkZX?=
 =?utf-8?B?WUU0MS9FeUxodUl6YXlqY3JZTzg5Z1pLSUVCc0V4N1hMZFRkcGxFV3dCdnA3?=
 =?utf-8?B?OUhFMytJQnhacXkvMUdDODVyaXBLOVQrajlGVEg3bXkzUkpRS1hZckhISFFS?=
 =?utf-8?B?Q2tPUFNwRG1ROWVaWEZLYlpmM3RNdlhWd3BpU1pNb3lRcjRPcGtEcHRHdkNY?=
 =?utf-8?B?MnRvTCtqc29mdGhqL3RXWEN1V0FHZnZPaVJhY2ZNS1dwZEUrMnRNcEZKRW4z?=
 =?utf-8?B?SzRGZkJIVzZudlFYUjhjNEVwRmVHR0pjTjNaL1A0SVhoMnJHVkRqU3BwNlJG?=
 =?utf-8?B?NjluMjgycEpoNmV4WVRGeTdNbFRhOVdpMWdYWlg4S3EreGNKaWpDbEVmRTgy?=
 =?utf-8?B?R1IvSmZ5YzA4K0lrWUF6alp5LzNtSTgrYlNqY2h0UnlOcFljT0pXL2dHNkRy?=
 =?utf-8?B?dTJyN2NURWdXeEhnZWN3UnMyTWpHQTZWWERoRlFRSjczK25UL21ZNEhNU0pt?=
 =?utf-8?B?OGFqSjllUkg1SjJ3U1NTeHdYR2FtdmdOeVI2L2V2L2FwQUcvdzFhMjJvQ3lP?=
 =?utf-8?B?L2NrQm9Nc3NuM0xNc0p2dm5aU2c5bFl4SlVLeUN6NkIzU2pSOTlBam5QN0h0?=
 =?utf-8?B?Y1UzWnlNVVJHR3o2QXJFMkNseXowSVBvS0xsOW8xVGFWUDlDaitmeE1JSFpG?=
 =?utf-8?B?c21nTmtKVUhwT1M5TytHNlhpNk9ETXFMNnplR3VBb3FBSnluODFQckNQMHlH?=
 =?utf-8?B?N2pRdG5aNzZuaHQvYlZueWFMVGs2ZHZKWGZaVzRKRVVTbHlpWHVpY1FiS1RE?=
 =?utf-8?B?RjZQd24wM2R4WUthY0hVaGtXZWFMeWtlTkhEOVl5OGlrMkdobStVbXBtZlk0?=
 =?utf-8?B?NHVIV2NLK292SDEzMFpnRXpzZEZCTTBHK2I4b01jc2Y1WVVSZURtTit5a3pW?=
 =?utf-8?B?ZzhZSkJvaUJObjBlYjRubUVJdml6aXVLa2RRa2c3Nm00MFZvMW0rN2hhcnll?=
 =?utf-8?B?cXlQNE1MbGVIbWtQazA2VHlLanR4dC9yM3FYSE55RG5SbDRkMmNjejdjVjZO?=
 =?utf-8?B?amJ5M3M0NVdzRDlmQnR2UFg3YUorK2U1WTh0Mk5mT2NhemJlOGJ4c21LVWpq?=
 =?utf-8?B?NkVJQzJma21VWk1sRlI1d0Y0L1B4WjV0Z0xsL0VEZzhHYXF6aENjWDVaOU9B?=
 =?utf-8?Q?9Q+pwhlGxQX9U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGVhL1YvOG52bHhFSFVWZkR5dk1IWkNDSWlySTl1U3dIM3EyMzZuNEtaQmFL?=
 =?utf-8?B?TVUzaFdSa1EwV3kvY0VMMmNBNWczZi9rdWtjSXpzWVJDNk5QcEFmMTlRM0hW?=
 =?utf-8?B?SzdBYXRMRTBadDAvM1dDUG1iYkEvU2hIUiswMW9JU2k5aVFIT3N1OUxHeDE0?=
 =?utf-8?B?M0hwd2xoZmw3T1dMa2pabGpvYjhmaVl2cHdwODBKOFhJS0JBWml6dVBrVjBr?=
 =?utf-8?B?Z09tK1Nwc0lqM2RsL1JlZUEvYTVwVUxRcGZSdllUZU80M21URzJJZHo0WkU1?=
 =?utf-8?B?VzJ0YmtXNzBXR0l5U2NMNTN3cnlHUlZYWWdFa05iK1BYRFRDUjAwdFNSMDBY?=
 =?utf-8?B?dWRGMXZ5Vk5jTnc0VkMwVFFjekltdEpyTkZxcUYyU0xuMkdHNWI5OVVlbXRU?=
 =?utf-8?B?NEpQWU9Ea0VoeGxmMmVwaXUvM3pIb1FEbGw0dm5IUFZGc1cveHlrc3U1b2dE?=
 =?utf-8?B?YVJrS1RvSC9QRGtoRjcvV0Rid0pjTno2SjNTdVFZQ2lTZ0U1a2MxbnBpMmtn?=
 =?utf-8?B?MktBZFhKMDBpdnNWQ1RiajBNUkdONTB2Q0tBSGlpR1c5VWs0bzBXV2RLTTVy?=
 =?utf-8?B?czZXTUlzc0d5SmtQQXNIcVNpTGVDYnRlTG5hL3NHa3U0NnJsdmNxR2Jxd0Zh?=
 =?utf-8?B?SDlYMW9oYzBIWlZseG01b3lsNEdqcnZ1OGIrcFpxQnU0TEZLYTdRMTBtSWxO?=
 =?utf-8?B?NlpGNGlQR052bXg3R0JseFZLYVlON3JsOElFVlorSVkxNDBESzc0OXBHYitP?=
 =?utf-8?B?QmJ1SUY3LzJ4UjFiTkY1MUMwTTlhRCtwZkNzcXpraFRHZkI4bkVEZlk1VXlP?=
 =?utf-8?B?ZVBmMHhTam9XbzFYSG16aThrRUswK1NDVmVSR1N1VnQrTURlRW1BK1d3cmdp?=
 =?utf-8?B?aC92bkx0SHV6WEhidzN2TTVmK2N2bkpvdW5nNVhGT2prTHVSSXQ1Q3JVb1hz?=
 =?utf-8?B?Ui9SMVJESlNzT2svWjRvL2gyTjRGQmNzSHdPSmc2VUhkUXc5TVAwUjRJT0Za?=
 =?utf-8?B?N2hwV29QMEUrMXZGRFhWQ2lqT2krQ09RL2xkSm1tbFMraVZDVjM5eWhoMXkz?=
 =?utf-8?B?akRYREw0RjNKa1Y3Q2wzZjNEWDhCQ09PNVRuVEpBVUJoTkZ2MG45NlUrODVK?=
 =?utf-8?B?MUVYQlphc3pZMTdOZG5CdEJpVHNpMVRhVGhmMnZxbGQvTlQwLzlZMHN3UjRi?=
 =?utf-8?B?RWRieDR1aWduNXhoN0hTVWh1RXhRTFF0a0t3aGRCTWpQdVpGSzg4Yk12dUJO?=
 =?utf-8?B?WE94ZnpHamVaWmV1aUppM3Q2VnRtY08wSDd4bjk3K245blcrM1NWSVpQQ1Vh?=
 =?utf-8?B?Rys0TWFVMklsVThBc2JWSmhwU29mT2lYcC9ObDBUZG10LzVOOWhjbFlYMW1P?=
 =?utf-8?B?eVE0T0JrbnBUd3IxQVZYZ2lMU3B0cTM5T0prUlNQc1BhejhiTzlXbXBSWWV4?=
 =?utf-8?B?ajBnSFUreEI4YnNLVmtIaW9HY1VidWFFTUsvZVdkaFBPVndoS0U3VnNFWjlF?=
 =?utf-8?B?ay85MG4yeDA2UmxpbCtVd3gvNk11TTEyb2hyZ0o1N2ZSczFoOUhQNERVVEV6?=
 =?utf-8?B?Q1U2cnpJOUIwNW1wUmpQUU5WSFdhejhHam5HUUt0Zm01M0QvdHNpYjZJV1Q5?=
 =?utf-8?B?cnpPRGpiNm4xTlk4T21NMkpnZW1obGtac05WcjIxVW9YTlk4c1FQSmhPSXpp?=
 =?utf-8?B?WmxQeW9EN1ZyN1FVUTRUMUl6R0RjU2duWEYzQ1hjZlA5aVppWVViRTNIVGJh?=
 =?utf-8?B?RmorYTR2VC9rMGRrbVBUcnhNc3pxaGpwakEwc0x1VEdpVDdjT1NlME5TRTVh?=
 =?utf-8?B?UlJNV2hYb1VqcGdtOGdyMENsaEozYWc3UEFiMkRYZmRIUFprSmpTdlJXVkJi?=
 =?utf-8?B?ajJPSlFFcUhDbys2REJsSnBnZ2R2d01iY1Q0OGFtaEN4TnVRSTVIVTFnV3RC?=
 =?utf-8?B?cTV0YWMyc2MxYkNMSVlKRlAxd2kvT0hDVWhjYno3eUZpVFZlMXFRZXV1NHYx?=
 =?utf-8?B?UnU0VmpDTThlTWQ0VjZYcUQ2M1RjRlI3ZFpIMkY1ZmN2TGJzYlZhTGd4bUVt?=
 =?utf-8?B?ZHU0L1llNllHUXYvbVFvUkpZMzJYTysvUHYzeFRuZldyMk00dXo3dW5PZ0tu?=
 =?utf-8?Q?Ar1UflquuuiMpAhxhqV38A1hJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b329601a-9216-4e14-c2c5-08dd6957b957
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 15:39:25.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/uieEpxh6Lx6RYBkBoVgti5jMYjWe59EvsatnBjtesmVn7bHPMghLbd4dOd9Oz8xBUtQ0boX/hu8nxfQVXTZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321

>>> How well was this tested? v6.14 will be released tomorrow most 
>>> likely, so it's a bit risky to apply such a large patch so late. 
>>> Applying the -v1 fix was a bit risky already.
>>
>> I understand. Although I've done a fair bit of testing and ran perf- 
>> fuzzer for few hours before posting,
> 
> That's reassuring!
> 
>> I'm also not in favor of rushing. I think it's safe to defer it to 
>> 6.15.
> 
> I'm leaning towards sending the fix to Linus later today, because the 
> leak has been introduced in this merge window AFAICS, via d29e744c7167, 
> and I'd prefer us not releasing a buggy kernel ...

Sure. Fingers crossed. :)

Ravi
