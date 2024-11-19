Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA9A1BF24;
	Tue, 19 Nov 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023422; cv=fail; b=Xo6gmQUbNrZXyyOtfmpmaBD2l4fpQ49dcl76C7t2H7dZMPySHIWIGTVavcl4lLo0MXVOoZrwhjPizlm8ZudpFTpO+3zr0nZ37HS7oTjRPzXsxCCxuIaSGWHXdLnKWwx+ELRdfgg2mKSXgcCGBUwJMsEb4jkvQl+UM0zR7gLUTxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023422; c=relaxed/simple;
	bh=F+70F8QNx8wwfugDpgpb8EQlrrJqwJXeeooim5cy9tw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T4H3zyXKvFQn5ul4ymHZk63RNyoE6gVZnXKEt9Cb0Fse0fb/b0i21kvb2dNzVlfrbw4ItPip9JWzPevcp9tHkai9QExXWFwfzQzo9uDyepxkyVxU3l3gdjK+Cz1spj3zydbmVQgU6s7KNjGH2TJnzU1XWGhtzTJv4+f9t9KqBsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZmveOCcm; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZmveOCcm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Whufq/WNSLStw8x+PB+Dpx8d7YrvwD5ZrWdzYX54v59TvYkH8EQJTTo0/xdm4ei/8DhNjE+8xKqJ8LieKAQWkD20I8sYYGyepSvlOTtgOlaiQQ2LOgmaAicjb0/tZyz8yDvtiGFimNEzjX4qo5XE0eiHvytoATqzinncz3BR4G6TeIFEShS5AKg7O56M/0gxBwQ2D+6VBRwWAJ1KBtZUiUYmjIRQQYZtOGFS84mLmL4k30wlzs/vNyPZE3+hb8+Rti5ePf64gN45ZdaMHuNhz7kJAldcwYsrMZ3+R2GbOVPkM/pw9ItltD9eR0D+AFC6wr2YTBl4d0SXDWQDl0NZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FchXQqAmXIkyt7xcnVPXmAH4llWHa47nErQd49Drs7k=;
 b=QgKU8jfl+cJRwbl0kcCKBGYyChbKi5KqLOC3/CPmZ0WWrGZWqosS+4Q9ZoVaxchD/ghBbJBU5AsP6EJB8r+FvhT8fev/7pmfLI9iCpJPFOzGZp3aKYFsptrN2VslXLiDXSRglU3jBHFa1VS2QQCtktwOitnLI6ZnjtUx9c4e8arKbBdOb5uPxtASS3OL13QOJnB1TqGayMSQFYShZVPOe10g71DZ4s5gjjAIX3V6+kX22hebju69EVEAq7DAZtfx5+jrMWyNga4wdsuibMWsi4++IGLu1ChN5JzrYIgXW+qehX8Ud3rZYv5cDXIBbw/G3Mbeefjw3oDeGeW5o+doqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FchXQqAmXIkyt7xcnVPXmAH4llWHa47nErQd49Drs7k=;
 b=ZmveOCcm8ZcsmHRIllBgO98a/vVnUzkIsozqtPaXzq3AJ4oEcOMkLmjecm4BcyYRD9mAyTury0wSvbpx4FHjhko0LxKxXO1iDwfeAPprnzn73pBa9Yfc0EtIwVQfKTksNJ2TuoyHrW6/IrtUSDFC8WgTmQagrD9G9UUiNFeq8iY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 13:36:57 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 13:36:57 +0000
Message-ID: <2743666a-f592-4ee2-af43-757c6d8ca64c@amd.com>
Date: Tue, 19 Nov 2024 19:06:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/amd/ibs: Add support for OP Load Latency Filtering
To: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org
Cc: acme@kernel.org, eranian@google.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com
References: <20241010050815.751-1-ravi.bangoria@amd.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20241010050815.751-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067F6.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::37) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: ba360498-6cd3-4a86-11e2-08dd089f3cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUV4MkxNcjdnbWExdWdLb082WnQ1MWkzcGMzOXJwbWxtTWE2WGhlN2RJeEJj?=
 =?utf-8?B?bjNaRWNmT2NwR0NzalI3ZFdQc3hoZ00xSzZ0MzJScDUyZ3g1VWZ1Nk5nUEY2?=
 =?utf-8?B?NDc4OE5mUHkwU0lTRzVuVG1DNDFHM29YaTdpWDNPWEpUZ0ZRd3o0WXJDdEpj?=
 =?utf-8?B?NnlQUVpsTThOOXFIODVTZFVUZnhiVWxXcTRrOWNERUZlV2Zqd2IvYlJpaTNC?=
 =?utf-8?B?OWlXMEtjb3htTzdNUFRxVXZ1L2NncjZFTGUrSXl6NjlwWitVR253UGNBY2dx?=
 =?utf-8?B?dVROUTc1UFlOVGtFdTZiVnY4aUZOcWRsOEtjRjJjNlg1K3pHUkVqeHNxTnJD?=
 =?utf-8?B?R2lScXlIWGR0WnBaLzhsMFhPaVlhNnJDOHVCbkdzc2NYanhOdW9hZEdGNFl6?=
 =?utf-8?B?L2k5ekpDUEM5TER1Y2RQWkQrM2xzU3J0NS9Wd295NzlwVCtsc1B1UmJta2s5?=
 =?utf-8?B?U2I5dXQwdzFRL1Q5dnpaYUF5VE5YOXc3TWh5VVE2NWpNWUJSNnVFaUVneEFB?=
 =?utf-8?B?SDk1Um0rK3VlR0V5cDAyLytVRG1yTkJLN0Fnc291d21iNHJFZjNZRU1nVitl?=
 =?utf-8?B?ZzRhOEwrOEMvRmFESExFcExVN1VoejcxVFVLVFhiQnNhZEJVRldseWJLSjQw?=
 =?utf-8?B?OVB6RnpZVTJreHRzbkl3cTNNaTkrYUhDWi9JaFlzN29tQk5mZmV0ci83c2Jr?=
 =?utf-8?B?UlNsckUwVXIrYWNqVldrZ3o5cktSejg0MnNxYUtBc3dicFZmWml5RlBYcFEx?=
 =?utf-8?B?cndRKy9GdTE2LzdvQTByWnNVREJDd2lxbEREanI3ZEhlSktaWEdrL3hpQUpY?=
 =?utf-8?B?K201bi9LQVgrcDhhQTF5R1lEaFZ6MHFIbXZseGhFRWU2T2twak4wNmxCdTM5?=
 =?utf-8?B?L0l4bWhpb2FFUG1wK3FvS2tlMFFlbHVWRjFpV1VBZWUwZTRQV2d1R2M4Q0Ja?=
 =?utf-8?B?WDZNdUI5RDhud2lFd3JOcWl2blQ2NUoycjEvNDYzM1lBNVkwTzZTNHpxMU1N?=
 =?utf-8?B?ZWp0ZHFFR2NTQldEQzJoMmMzNjFsOVUxc3pRZzNsNWpPS3VuNXlIekZabjZn?=
 =?utf-8?B?aGhoY25TZnlxOFFTRjNXY1ZTTWZIbldDMU5CV2N3M2E4ODlwbGxaZnRMN1Mz?=
 =?utf-8?B?NVlVSTFFWGZHVkNYNCthUnU4ZkYyMmducnJvNUZGelBjTXkrTTBPNXlHNmtX?=
 =?utf-8?B?d00rQ2NXUXV1QlY1QmQ2UmpTRkNxRHkvaHB5U1R0RG80TzVhWFdMY2RxcWN5?=
 =?utf-8?B?ZkRYT0ZpbUQ2NXJIUVBtV1BQS3pqVG5ILzA5MlZtUnFiTHh2K2tDQ3RVN3RW?=
 =?utf-8?B?Y0FlUDcwdDlBU2U5YTZxQ3hzL2gyd0UrNnU3UUltd0ZFMjAvZ29nR0dYWGFQ?=
 =?utf-8?B?MlBhaGJVYk9QdHBHUVZNbnFiN2UrNGswWExRdmNvSGtDNWtRRU1YaFgxVGtI?=
 =?utf-8?B?L29GditsTXF2ZjA4dEdYYlVqRk5xY1FQdUgreGVjdDBSSlZ3c1habXNOVjBr?=
 =?utf-8?B?dmhSeE5QeGhCc1FyVDZMSURCQWw2QzdDUG50blRrRWlGOWFoQUZzUVJ1ME9x?=
 =?utf-8?B?bWxZd25Qc1EwWlkwYWFTdFZpLzUxRFpvTTA1ZXR6RSs5R1dpR3Jqb0ZpeWVI?=
 =?utf-8?B?RWs3dWx2Q3BtV2pFUVkxVXlXYk5HVmZLeDR5cTFzaFRRK2I0a3g5TlVIazJi?=
 =?utf-8?B?OVlJS0R6WWZmR1dKK25DRTdDNlB5dFVvcXh0R1ZyRnh0ZHlLVjZVRTNPZStQ?=
 =?utf-8?Q?TtoumG7+a1Z5nZwGdA5vmaI5XXbRE26VHd8Tsk6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk9kNW9yOUNNUzZHOHRya0tQN3Rvcy9VV2tTUWhWMG9FM3NDWTNLMGVBZ2Vh?=
 =?utf-8?B?M0JybWpVMWZQY3RiTTFEUmJPblltZ2RFYjZLaGxETGhUN3RHckVwMmhhbW8w?=
 =?utf-8?B?Y0VVdmlyRTJwaCtTVUs3N3BCYkNpTnRnNGxxV1Z1eU96OHM3V1k1T2ZDaits?=
 =?utf-8?B?VkNMc1lvSVprSC8yV3R2VmVVTDBLa1B6ZFl6UHpmUUhDajRBMWtwOHlhc2dh?=
 =?utf-8?B?SlVuU0JqbFJOcFdEQytCTzNGcFF0N0ZERzAyZzVIZzhQYTRzOHh6WGZwS3BT?=
 =?utf-8?B?K2N3aEtxTkhpQ200S0JKWExDTmJtUXZoMmtjWHExaE10U2kwcktuU2ZCYTJu?=
 =?utf-8?B?Y0l3bmFaM2FGZzNoZmx2VGVrRjJGMmZ6UUwxVlhST1dTNVdycW1XUUdyNm44?=
 =?utf-8?B?Y3k3MFNTb01OMWtmNm1HSTRORTEySHBjM0tmalhQODRMZDYzTmVpWWppYkJ2?=
 =?utf-8?B?R3NaS09Wc2tQZFdEa0pmQmwyU1k4MkZWMnVnZ3NBOUlIelBkcG9uMnFZYjZI?=
 =?utf-8?B?NVphcWFlck5nUnJLQlNaNzFwZjJLYXBUc1BQKytNZ0FFT2U1cHFKNjBIWGJx?=
 =?utf-8?B?bFVkN3NlMXFTOHhoWG16SHpKSmdCdFRnejErZTVQY2diajJvbk8rT3lCcDVu?=
 =?utf-8?B?Y1JmdVljU2htL2pKWi9YT2Q3K2ppbFJHYjNJYnJTV1ZBVUwrOW9qeCtvZFRD?=
 =?utf-8?B?YWtvSlJPWFI5NlhPRkdkaHJMV0Zud0NGajNlelQxYTl1Q29jaDNyVHZhcjVQ?=
 =?utf-8?B?RVhaM0FmbDdFUDBUM3FpZXVCVGZJbHkzOUdWTkV2by93TlFaNmd3OE1jK0th?=
 =?utf-8?B?V2VLRXk0Sy9sVVY5cTU2a1Jma0F1Y29KM1QxRWsxK2U0RTBXd0gyZXVqbHRF?=
 =?utf-8?B?UE0xT2x1SGxTL0graFZnODF5ak1jYUExVUV4NjlRYjUxaEE3RlQwL1dHRVU1?=
 =?utf-8?B?UnN1NmM0UkJCY0pMRElSS2hoY3J2MllwajJrajdaVnBBY3BVZGc3THJmK1FD?=
 =?utf-8?B?TjFtODNTYXFYcWFPZkZTN0U0ZnJpYXFJQmVoTGE4ZUtnYjNWc0FrbmZwMXg1?=
 =?utf-8?B?T2M1UGtDOWQvRXFkdHUxZmJRZ2xtM1l6ZU1aMG5INzRyblA2MkpqREhqN3Fl?=
 =?utf-8?B?NkRUbmdRajlKTExsQzlrUVJ3OFFwdUFJckRYSDloYklxQS9TRS8zYkV4T1Fr?=
 =?utf-8?B?MXNKL2VNOW5HRFFXT3BWNTg1UTVBUUN6WHJlZjlBTjBWZmc2ZkE4VnpFRXAz?=
 =?utf-8?B?YzJrS2dTNFFwSEt5N2paUHVhcmVGdVpKZjRuWXFaR0o5Zm96RzBsSHAzclp1?=
 =?utf-8?B?WGpOUVR3U2FONDRuak5SNE9HbzNOK0JvSUM4ZjNpNTBoeDRLZll1bkx3MzJG?=
 =?utf-8?B?aVE2TXlzQ0c2VnB2K0tJY1hONUYzekl2WUx5YzF4dDg5RVBWazVYekQrVjlr?=
 =?utf-8?B?QXVvc2pOTU9lRTNDYjBhQzlOUXNkT3I5L0NtZ2FQcE1NenUvTUp4MlZSZVM0?=
 =?utf-8?B?ZUJBSUJJUElRbkltSnQydFRqanRpZ29xYmZVek4zVkg4S1JGNlFqVDJlV1pl?=
 =?utf-8?B?aVV6YzBzMjZJQVF3ZmhGcXMvR09RMzJRUlRjMXo0ano0Q0tPYTQ0dXB0STlk?=
 =?utf-8?B?RmlnblRuUE0yZW1mQW5CR25hdU50S3ZQNnE2MVp5N08wUkQ4Y3dSaHdrMkx1?=
 =?utf-8?B?d2MxU1lwcGYxWVBBQUw0ZFYyM1pqcUh3YmJjbjJwakF5NWZ1QjhvamI5Y09B?=
 =?utf-8?B?ZG5KRmZBU3p2Q1M2amE2dXROV1Y0c3V0OE9SWVlPU0htNEN0M1l2ZVlXeTk4?=
 =?utf-8?B?K0d2RlpsZkI3QW10Z1p4S1FtWmUxY2IrQk1WT2NXdGIvRnhIY3VnbzVpZlRL?=
 =?utf-8?B?WDlHRzVFWTVaZ0VaNWJCc2syTzhWMEJrMngvdDhNM0tLdFMzcGV2Z1k1azVZ?=
 =?utf-8?B?dGtBM3Q4M3ZZd1ZZRS9odkVLbWZWVzZMOUFMMWtQSEdWU2NwamhZeU9CVjM0?=
 =?utf-8?B?MU5aSUM1VlBhMkREVTI4S1o4TWNBa1c3REdlT3dmWFV1S1lmMDUvSGVzUFR1?=
 =?utf-8?B?ZDFqaktRNW1lckxubjRBYUpmV05EZEMwdWdwNmxkM2FYby91TEFKSmFVVDJt?=
 =?utf-8?Q?ijbdIR/qWU8fRFUbc1Ns8cWPx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba360498-6cd3-4a86-11e2-08dd089f3cd0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:36:57.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWaglfjg/TdANvAXDn3GOWAHxRMrG0/qoFPatGBMe039Cqtgcm6RbHwHl/PFHPF3mNRIVtTidl4VMDmVPxIq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840

On 10-Oct-24 10:38 AM, Ravi Bangoria wrote:
> A new Load Latency Filtering capability is added to IBS Op pmu with
> latest (Zen5) uarch. It's advertised by CPUID_Fn8000001B_EAX bit 12.
> When enabled, IBS hw will raise interrupts only for samples that had
> an IbsDcMissLat value greater than N cycles, where N is a programmable
> value defined as multiples of 128 (i.e., 128, 256, 512 etc.) from
> 128-2048 cycles. L3MissOnly is a mandatory dependency for LdLat, and
> like L3MissOnly, Hardware internally drops the sample and restarts if
> the sample does not meet the filtering condition.
> 
> Add support for LdLat filtering in IBS Op pmu. Since hardware supports
> threshold in multiple of 128, add a software filter on top to support
> latency threshold with the granularity of 1 cycle between [128-2048].
> 
> Example usage:
>   # perf record -a -e ibs_op/l3missonly=1,ldlat=128/ -- sleep 5
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> 
> Note: IBS sample period cleanup patches are pre-req for this.
>       https://lore.kernel.org/r/20241007034810.754-1-ravi.bangoria@amd.com

Peter/Ingo, gentle reminder.

Thanks,
Ravi
