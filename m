Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E2C1CCB44;
	Tue, 19 Nov 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023349; cv=fail; b=MnDGc8URkJpp3inxWD7PI6NUYy26P8wr9jZwVZb3/ZY5Vqjxc0Tuj5RZi7UxN/Zaz3adEInDOabc4Boro2m+uskhFy3foHQI7L+pthkzeehum8ScQPFSwm7huYbE8K04VJEqHgdMDXmO1ks7pj+6wg3xA69WDTHB9XlasInGwu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023349; c=relaxed/simple;
	bh=mTK+rLSONnbJwHxsr7fDGAdNkCZ8OCCp7j6dVD6bB1c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FUIld1JIfS/pQ+UR8fcOtGIMiSI2P5WOgEDmw4bruVoFeWfU9AgTHnDRp1FBQvhDhhmhmCGC2ls8Y/WS21cIaAkENovckxVHbNFmUqD2H08UFjDfckN+OTyFCsZVzFDtUq0zg3q70K48WPxvpqNZKmz/pXuGzNbLv+OVtP606Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kib5armB; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kib5armB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK1SWBx8AxVkbL74FPBvZjWQSOttLQhGaahQJIVjOV//fcwLEm0vK7S3HtGTKvOa9tFbaVduHLNcNtdypnTBbXJhxGDe5J2frvYZ1Po3vx/pFdFxZOXkkIl8E5+GeodKh2O/6M2nKuz8WeEx+0bkHka3l01HUULW+ctKfuz/ckHp21FpVuZj0xHkdQm6cIxDNFMWfsD88KouAQtgK/+IsESL/yGUB0iwchF2cNwWUFCvS5gJFuZpnjW7u5scKeSqU+Biu3l/BjtbCD7BB9YeZpmH1SX91MKO/f8qtkmv/qsb6wDAPduswN4IJOgDYQGE7iNROdMLNgZ4orxhdoisqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY1W7C4+CYigHJD7IP2aKQqvO212+uTXnqS85REArJk=;
 b=KFJYG7jMJMxtb2NcIdJLFD7sNYQOcTUSHMGINn1pk4A1NvqMYDdGIDP2RC+JnRHWNerwWwIdX9GhN2s0jS27TUGhBh+35Xz2M75yJNglWdZ/a23Q/f4BFwkdU6LZdBqZdysbKI7KBO28fKjxvwxG+7Fj1vvBiBE2SN1fSONRoffCF4JNbSGx1qLoa5XquBNUHsYH3UGbsB8zQ0t5Ylq1enVApXcpb1vyj1CHPwLPmXGKb0OuM1fO2hf53KEuaTsIS4NE/WXN+UkBylF4LSvY3tn2BtjMAUN2yNbyJ/18dadoo8wz/UPrXYmyiNWpsL1ZvvhweW/POmudYla4mKSo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY1W7C4+CYigHJD7IP2aKQqvO212+uTXnqS85REArJk=;
 b=kib5armBy7A9u7ZDOLMpvjNrR6OFKTqbsLpimY07zP1Br7w+vYOFsxJIQzpRoRW6OlSn7WjWrGq/N//I6yJCJLRgbUzHHemdfPTps9tsvFQ/+CGxp5iYtVirL7pYGRtkQ+fPCkpbGhqsCdKxdyasurPjwgMqNNEBpwJnM64Xn8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 13:35:44 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 13:35:44 +0000
Message-ID: <e08cef5e-5c89-4f9f-8210-9ce68e789bf2@amd.com>
Date: Tue, 19 Nov 2024 19:05:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] perf/amd/ibs: Fix sample period computations
To: peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, eranian@google.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Namhyung Kim <namhyung@kernel.org>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
 <ZwYjtkf6E_Pf5opB@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZwYjtkf6E_Pf5opB@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de07815-0755-4fae-f93b-08dd089f1163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjdPN0hqTXNqUHlYMmVyWTBqSWFnU2hZTm1OQUJuTDR1OU5RNnJPbGg2N2pr?=
 =?utf-8?B?Q05jeEJYQXNicVgxaEd5dE5GK2VVRFdMeDFhaGhWK1QybSs5OVMxb3hhdnBK?=
 =?utf-8?B?L1BqSGZBQzhtNjhHNkxuUlBzQjZ1dFhQSGFQeVl3TElPWXBHeEFSTXFpQ1pD?=
 =?utf-8?B?TzNzSFkzNDdRTHRGVjJud1BSQlloOWptYmFSbllFbTYrZVdacThZckwyTXBh?=
 =?utf-8?B?WTlMSHM3Sk9Bb2NDVVF1ZUdiOUN6SDRRYW1xU1dBVjJqeitvcGxsWXNXRjVF?=
 =?utf-8?B?WUh2TERsc3ZSWlBwTEJTaklSejhNdjU3aGVwUGJaOUhSZ2owMDdObzZFVGgx?=
 =?utf-8?B?bEpmamtZTEJ2b1lQMXBWQm9zWis2NXBhMGZ2enI2aVZLa0VDN1hYcm1kWkJp?=
 =?utf-8?B?M0ZCQXVwK0JSMTN5VkFVeVNldmtIZFlzNXpxK0NzaHV4azZOSU1mNmtzRklh?=
 =?utf-8?B?OUJzTjJWUC9lRGd6TDhFS2FxWVl2dFpDYjN3UGk1RWZ4SUJKRnVodmlMSStu?=
 =?utf-8?B?eXhzRk91KytlNWd1UnNrZGFMc3hCY29MWGhBSjMyNHIyQ2EyeldWRnJmQW8v?=
 =?utf-8?B?K2F1dm52anJKVDhobkdmOUxiVS8wVHc3aEl0R213ZWlYOHRFTVRXTTJLUWh4?=
 =?utf-8?B?Z0F0ZWl3RFhwV096K0Y1czZTc3lNY0ZFN2tCOXF0aExzbnJCUUEwSkRidEYx?=
 =?utf-8?B?akZOTkFOaVNMQUhwc3FuN21ZQUlCcFpmdXVUR2pieTEyZE5LRGoyMm9DOENB?=
 =?utf-8?B?MzdpZEF4aCtLUTdZc0VVNU1JZ2tkMFk0SlZZM3NVYjNDRFFKb1gzcW5iVUVo?=
 =?utf-8?B?Y3JCR0Rub2hlRU1rNlU0QVo2bmQ2bjJDK0hIYTE0OFNoeWthcFBBbFIyVS94?=
 =?utf-8?B?OVJKUEU1QUNCNkZaTk44ajNNc01Da1FTNHR3SUhiS0xjRVcrVnBnTnFpUWNP?=
 =?utf-8?B?TXhGZm43cnpOeUZ2MFU2dzdONDBwNEovaWl3aUNEM1puTFdsRzdraUNiVVJr?=
 =?utf-8?B?alJvTm96SGpFUXZMR0FETkI1YUlwZEJZTTV5dDJrS0xuOW53dzFqL0NxbVhQ?=
 =?utf-8?B?aXVUU2o5V1NkYndhSzBPTWczWUF6S21ERGh2SFVkUHdPQXZMMUVqS2ZHd2R3?=
 =?utf-8?B?SGdtMXozYzBWZjlSbS85alpQSS9iL1RNVzdhY3RpYlFUSEhQeHl0QTBETnV6?=
 =?utf-8?B?NkM2cVdsMXIwLytHNnNaV0RuQTUzV3F5L25UdEFJc3paeUFjeEFVUUUySnl0?=
 =?utf-8?B?aU1aNGJTQ2tnQVZFM3g5MXFzOXE4RnlQQWEvdFZiRzFRcDlrSnArVUVOQ1FQ?=
 =?utf-8?B?dHZoa0lrVXVQc1I5ZERSUks3ek9pd3J4THU0ZDZ0a0FXT0M0VVFpRDFHVkpw?=
 =?utf-8?B?d1ExUEFya2xLWFhadzRkbFdjeTVJMGxiVkFqWHlhZHE4WG1NdkRLVVN4UmJW?=
 =?utf-8?B?a28wN0RyR1hMMzNPdXNMMGFIYzFHUWNUTjhtaWkyRloxcTd1cDR3ek1mQkdl?=
 =?utf-8?B?dy9hQ003azAvM3Q1M1RSZ3VGNHNHeisvUWFjWHJrSVRGazRIVzdlRk1xQnRx?=
 =?utf-8?B?Y096R3RrOEFWeU45M09xZHAyK3FDa082MzRQV2d5VlZjWVVHZmtqMnBvOG05?=
 =?utf-8?B?VVdab2h0YUN4b2ZtQms0d0wrQUhFY3NEdWFpYWd2OElwK2VXSFNrenFoSHNO?=
 =?utf-8?B?YnRGOWhQbStGMkNkVmhFRmlScS9RSkNGSlZncmFHeFRZTDd6My8vNmJIMmdY?=
 =?utf-8?Q?YIF6KgS0PfRMu97c/HiE30szo1XNvrhxU7i/CpO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rmh5TGcvQS9FdXlKVmJHZXY2NlJKRmlCQ2MwMDhCR0xoQk05bmdyTjNqNFpO?=
 =?utf-8?B?VWQ2R3V5OWVpa28yc2RZK2p1cmJxZVhKbDgzaGoybllWSEFKNTdxZndveE5G?=
 =?utf-8?B?eWxrSHBkNzVPZUh4bi9aVVVwU0ZWbnY5SXpYVFU1TlFvY3cyNFhMTlpteGJk?=
 =?utf-8?B?dThrdmZRckszYzRUOVJKMCtRQXRnclQ1SlAvVGk0bVMwWWtDWnRpVWdZU2tp?=
 =?utf-8?B?TjVIVm5jUjBjWmtFbUI3bll0TGdHZkhYV3hPdVRxL1lnVTRzRUk0VVFRbWhQ?=
 =?utf-8?B?T1hVa1FhdDg1RWE2Mm1scjJodXZMeDNzTGlvaHVuWGh2cVQvQ0I1MDZIdGE2?=
 =?utf-8?B?QjdwTmpsR3dZU01JVEVOaFh6Rm5acGFiSndQV05DY0hqVzhLMy9SQmlUbUYw?=
 =?utf-8?B?ZzR5ZWlCOEtPWUFOU04zL3ROaHpoYWxSMjRYNnlHMUFVN2pnUVphempuWVBX?=
 =?utf-8?B?UmZQcGVvZHVXMVlhQm9QR1BhcDA1dkRSWGMrV0x6OUMxd3dra0R4ZHR3MGlK?=
 =?utf-8?B?QkxGbFRldnhESEpyTllBeXA4MG1rOXN5TDhEZUloNTdzOWx5clovaHU1WXc5?=
 =?utf-8?B?dnUwQ0tDMEkwSW9EZG10S0wvRnAxdWdZNnpTUm5GRWIrVnk2RlE3aEhvMXcy?=
 =?utf-8?B?aTJrQXR0ek5QblM2M1B2UnoxMy9zYmQzb2JVYXJuWnlVTFRveHErOUM1THFM?=
 =?utf-8?B?Y0NoTGlldkpyMjQwVG5EVUxkN1JWSG1SRFMveUJ1ZlhXL0RkTUtOQmIzSWhj?=
 =?utf-8?B?T0htcGFVYi9uUmRqVERGY0hNbDNtUjRTd05GMjE0Qkp4Zml4OGxFNzhGa2d2?=
 =?utf-8?B?S0puTGdORWNjcmloczNJeDZlSGRMYzRZVENkcHpJbzk0Tjk2YnNMSU5zK0dU?=
 =?utf-8?B?OFpSOXZRME80TWJRcEJPRk9uME9MS2lhdy8zM042akZYVjdFMHRZbzFBSVBa?=
 =?utf-8?B?STFYSVlvU2xhd3hKOVhOTVhTYmRYK0ltb201bDFjM0VkdkQwZVE4RWoyZlJ3?=
 =?utf-8?B?bVV6dGVWaWdnbmxqemZMbkZ1M3RkZHVqT0dLbjBBNHl4MGN1VEpocjA5UGFy?=
 =?utf-8?B?RE5DcEc0N3pVdjZMZkpyWHBPT29Lc2tVdUs5VGduNmI2RGNJTkc2UU96VTBw?=
 =?utf-8?B?Ykw2czdwY3NjTGwwZFRlQmYrSjNTRCt1L1JqcVFOMzlIZURTcTBlYTRJenJh?=
 =?utf-8?B?Y2xLY0VWb1A3dW1qQXVvMkVNdVovcDNwemlkdFZZR3Q5amdpdHo0NFBNWFRZ?=
 =?utf-8?B?SS9PeWlSVW1WTEVHRmdNTmJ6dVllTktXSy9sR3VSQzgzbWlnM2s3NWJoL2Zr?=
 =?utf-8?B?QnVDZmNuUzdCa2x4aU5idTFVbC9IWTZaRlZobWJDdkM0QVh2ZmdWWHRNbEFZ?=
 =?utf-8?B?Tk1OT0V2L2c2U21hdUhQdnd0dTdXd1pwTk9ldXJCM0h6QTZDVFlUa094NmtE?=
 =?utf-8?B?ZlZNbjZUVmlmUmcyMjJPT2ZueDVJWnZ6YlkwVzI1a2JIWjFsd2xrcUY5cWNO?=
 =?utf-8?B?QkpxUmtYVWo5cldMT3NHZmYrQkloTG1zd05JZUZaQmdUUW4ydnR4SnMyMjFU?=
 =?utf-8?B?WUVaQlI2THdSU3Vic1F6SHlKMGxLc0psd1dGYzM0OTBmalRqVmVqOWdMQ2RQ?=
 =?utf-8?B?SXh3eUdsVjFBZk9sRGY4WWtrMGxqQ28zc2RVV3ZzY2ZFME1sOHNMV3g1QTU3?=
 =?utf-8?B?TjdEd2l4THB2akR3MkV6S3NNQ3IwaWdkQmhIWG9pdktWS0xoeEZvTUdrcUtP?=
 =?utf-8?B?eXdIOVRNQmFHemUrTHNwZDc0N1BPdmFnRmY0YWppRWlnSktvT2FEanRHWm1V?=
 =?utf-8?B?cmZoU0YweUdkOSt5UHlEYmZxRDVNK0dyV3dUVEFPaU8wNFZMVFdwblhHK0Mr?=
 =?utf-8?B?d3JpYkRmK01aYTlucFFMbHFmTzZWNUpmVWZxV1dGWnRGMm5uRGdFazk2SFhF?=
 =?utf-8?B?U0NpclF3c2NHSDNFUTV1MEk4WnQxNENlY04yc04zVkJFa1AvKzYreG9uOVNs?=
 =?utf-8?B?TUhlSC9FSHF0K3hFZDk1Y1N5TTQyYnl2SDk2MHNmZGNwa0NVNkpvYTFPQUJQ?=
 =?utf-8?B?dU9xRFhNTXgwTlY3OXd0SFc2OExzQk5xeHg2WkVNSE1uMVBQTkI5L0ZBTEx6?=
 =?utf-8?Q?vRoZo4Cx4y/K3w+vK5lGifNp8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de07815-0755-4fae-f93b-08dd089f1163
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:35:44.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWzoE0l8yUce6QsdZiwVacMMmRz29vPgTrJx7Y5fX6aGy4yEEbzLemFD7mJ4sLaL7fqqnrqSF63ca56+xoIPoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840

On 09-Oct-24 12:03 PM, Namhyung Kim wrote:
> On Mon, Oct 07, 2024 at 03:48:02AM +0000, Ravi Bangoria wrote:
>> IBS Fetch and IBS Op pmus have constraints on supported sample period
>> values. The IBS hw behavior could be undefined if they are not followed.
>> Currently, IBS driver does not honor them correctly and thus a malicious
>> event could cause issues to the system. Fortunately, the IBS hw is very
>> resilient so far and IBS pmus are restricted to root only, so the attack
>> vector is minimal. In any case, these are genuine bugs and must be fixed.
>>
>> Patches are prepared on v6.11.
>>
>> Ravi Bangoria (8):
>>   perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
>>   perf/amd/ibs: Remove pointless sample period check
>>   perf/amd/ibs: Fix ->config to sample period calculation for OP pmu
>>   perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
>>   perf/amd/ibs: Don't allow freq mode event creation through ->config
>>     interface
>>   perf/amd/ibs: Add pmu specific minimum period
>>   perf/amd/ibs: Add ->check_period() callback
>>   perf/core: Introduce pmu->adjust_period() callback
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks Namhyung.

Peter/Ingo, gentle reminder :)

Thanks,
Ravi
