Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E91DFDA8;
	Fri,  6 Dec 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477910; cv=fail; b=W/Clrq2yme+zmOXgW+WOnIgBCdgpAApfLETBosPpGdDvGbCnk3ogqGQP+lvSRD3jCqhIQtSaOj2jSM1YrMUfNDZFI6hRGjM7e8ciGOIrWgUrjbWyEEmJs3dC4CWUruYzMTEeMnNi+6KRwRcmS/weO9swOijHGXJd6AFXY9VsBUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477910; c=relaxed/simple;
	bh=Z8kiQQo0eBAUgBCuMJBLFiWa0BLx9kN1roH7tzoHoQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F50W0ig2/U5Rgwux4ugnSJEjqOexvfXE5fbRdsqHZ122Tt6+qEgksLGnH+D4Bbsy3+81azRx4JozoSDBBhs0UYGUR3Ot7gMk/lmud39I8he07xznEEikFZUQU0SIqj4BRyS4z6CnNbu88y5VHM8+97brA9NEup6KAE+K0AfSHWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sjhYThqP; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sjhYThqP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXj8nAUw702M9hQ05HHsxRDdl7npaAHXY5juZoYjGwkQqVshZc+xT4Ke1bYXqnzz8gnzgvFn2XSnM9D50Te3m9b9DbiOjdmbqfDyJ7wiI9/+nklcCDGpSFw+XvrwfZTjWo0t4AxhrCNBJxPKLdJ6zLZ0vTZv0/ru6ndFmWbVW1li0Bc+CJMPjA7W0QIFiU5DOvHtLHvIbCbNOzW6SeuRrWgcxgYYF3fzuqlp053FD9T4dun1/pXJa+fnQQLW8QrP+NHDTrapvblRMwQ2qM4z/9U58V6317xtqH4vNKMHF+SKC8YFFeQ9Ve8Gikwy0xEgaf0jr0EbGBDEI8LpNDb8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLapCf44ow7jWN6xgyuA6VNRz7vpHm4LO64abzIOTeo=;
 b=lG7uWxCDMDc5MULordVOKSCCVC9rkCE8TZ2SWet5xxLDLFzeFL1mu005wzHNKl3bGWX+LsJqyHHYCw0e30ORgjNJdN8CIDTDURCRyUZueZa4Io2QgNFXyjah6eDsNiURb79ydFTy6ckltqrMewfrCFspu/DnzEri0qfe0BNNOdU+TUhLEv1+hqIZUN0oQx59jMBNBJaKu45r3HM368QJIm9G9agm/Uql+XyVFDwM0YKtrE+QcfBmYOl142Jv8X571ZLTZ22RKIbtTUoLBCb/NptjwVYwyX0L2uxjtAU8QDvkX9qXeq3JeqWBx36hm8eRz9hxi1ZqDM7IrOqQZkspwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLapCf44ow7jWN6xgyuA6VNRz7vpHm4LO64abzIOTeo=;
 b=sjhYThqP1Lh4URf0W+EYIKVA7x6B8LxB9kF6OWI7vj3cGkDCXT9MIFaroJHcAaLKkd4gX0WPup25Cwiu5mXex69mNTIcBmDj/1WN7c6jSqvnxG2uyqoX+1t5uDcHkLaAG13/amPiLz9HRUJ5+yPkmn36V4Ur0q2HOAJ9QRg5vfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Fri, 6 Dec
 2024 09:38:26 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 09:38:25 +0000
Message-ID: <96075e49-5f99-4f43-9c43-5b01fdc98897@amd.com>
Date: Fri, 6 Dec 2024 15:08:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] perf/amd/ibs: Don't allow freq mode event
 creation through ->config interface
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 acme@kernel.org, eranian@google.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
 <20241206051713.991-6-ravi.bangoria@amd.com> <Z1K6IckahmlME6Py@gmail.com>
 <abe58150-735f-4d9d-8ff4-a20b0fc6b376@amd.com> <Z1LCTtw99YTutYOR@gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Z1LCTtw99YTutYOR@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f3710b-0fba-481d-49bb-08dd15d9bb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnR5RVNPbWZsT3NMRkQvcEs0RkpoVGdHakk5akp0U3l3VVlFajlITG4zSUpo?=
 =?utf-8?B?M3I2ODdxb3JQWnVRSHJlVVNZSVlNWkY2ZjlTL3dOd3JjS0xpaGNVd0IvSlBZ?=
 =?utf-8?B?L3M4aFN0UVJldDRHdGJJTjdwTXdyNUI5QzJkSE1pS0EvOUdYa0FUQ0ZzeEti?=
 =?utf-8?B?T1BHYndheXNUZ0NYVmNnM2RBZGQxcG1OZ3NmUEFCTDRQUzRWNGh1Uk5TcDlO?=
 =?utf-8?B?WE9DRjhJNE9Ud0p0LzNpdU5CbkZWZDVSL2toQTlQakZLeVZpakJvU2U4bWNz?=
 =?utf-8?B?WHVkYUJ2T3lHVDkyUXM4bTA0blluWjFnQndEcUFUMHFkK3dLMmxyQ3FGRXZ5?=
 =?utf-8?B?QnZLcEFIT1NZUTNBazZDazBGVFgxSFQzYjN0ZzZnVU5qQWVtRWJIWkE3Zmto?=
 =?utf-8?B?YWxWclY4dXZOazlIcUtmY25yYWJFQjRXbktGNm9HRndWaDVxbGdXWHdmM2V6?=
 =?utf-8?B?c3ZGMlFWYTgwNmVrUVpPalVCcm42MGtxY3N5NStvR252M2tzL0ZDQjkzV1Jh?=
 =?utf-8?B?dVRjUmExaEt2dlJXNWU3aVhNQTF6TVFqTllSbTBpUWtHMEU3SlQwa2JiWmN1?=
 =?utf-8?B?NHFrSnZpYnVpZ3VpMHpmV1JJTnVzdklVdytXY0g5TkVTQlpsN1BBTWRlK2o3?=
 =?utf-8?B?Zm9LL0NlQm9YS1ZBem01RnJIbmQrRHBEZldHclVsWnBXSW9YeXlCWGdIUU1C?=
 =?utf-8?B?eG9XUkJ2OEFFOTZzNnhnUFpvZTBvUDZPSUtvd1FQZHpEcWdpelc1alUybGZQ?=
 =?utf-8?B?NUl0V2FWdVh4K2Z4cW5GUHRKWks0eWtEN2hEWUhYVnZ5VGE0L2JtT3pMVnZt?=
 =?utf-8?B?NmlMVmZtSkV0WGZtUEJHblZmZ1ZYYWxsVktQckJQSDduaGZ1eGcxSndlVU1I?=
 =?utf-8?B?Qm8rY3lKWnR3cVVpcm4vZDF5Ynd4cDNYSGhTUnIvTGd2Qy9uajNoVzhMSEpj?=
 =?utf-8?B?NWJDNU94b3g4eU0yaHpKc3B3RUIvS1RsQ2NGVFZVdSs4Q21mM043VWN1OE8w?=
 =?utf-8?B?WXRXa1ZJSUI1ZTRUMFo0WEF4ek16ekhQYnk1cEMrOTE2SWlYR0tsWDgzT2x1?=
 =?utf-8?B?WXQ0SDlkakJMNHRYR0FvYXowdFR5WklCSHE4ZWNpRkRuUHVGM0Y4Wlc2eG1M?=
 =?utf-8?B?MkpPcmhyZTZRM3V1czU3WlpEZ2krK0ZXTVVOZllEaElJUUVNUFEyeUVDYnlT?=
 =?utf-8?B?a1ZmN0ZyMGFzaURXVE42Ykh6MTlpN045R3JqUVJ6cUloOHovMnI2Vy95RDlp?=
 =?utf-8?B?SThKVFVsczNZakJCeDh0a1FoUm5YRkVRb3pDMkcvTVpHeXlYUzU0emZDellr?=
 =?utf-8?B?cjhaZXFKYlpFeE9uRlM2MnpZNVR6OWxZbFJQMG5rZHoyQ00yMFVrMXI3QzJW?=
 =?utf-8?B?aTZ0SUh2czJsMTl0eGRYS05qZU04ZjgycGlRWGlqTThEVUVvL0xGUTJMVXRP?=
 =?utf-8?B?YzZIb1RHcU1obitVUUszcmpyaDNkV3YwbHZzQlNVZXJhaEl6amt5aVNhQjVE?=
 =?utf-8?B?eDNVZjYzdDF5c3RxRmxtMjZEcmVXcGVQYXVwT1YwWU9sTEpGM25LMWZmUklN?=
 =?utf-8?B?bllIalh0dnNubENjaEd0K3ExNFl4NUh0RnlXZG9yVS9lRzJ5UURNT3VEOFBY?=
 =?utf-8?B?V3FTY1pVWk5SdjZzVkt0cW1GaVFBTUVjSUhWSXV5YU1xYmFEcm8zOWlNd0JB?=
 =?utf-8?B?QndCU21ySFFpZktVRVdSbzlLLzJkdXhaTUNOcE9Xd0U5aDZ2L3RCSWg1WHlm?=
 =?utf-8?B?MkdYVGUvZjFxVVBWay9XbmZlelRDM3I3K1g0NGtNeUl2TU13M0NrSFZ0cGJz?=
 =?utf-8?B?aU1QWTJQU3lWS1lOVDNXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU1leEdFak5jMHpDeXZkZTllZFBiclcvOGZYcjA1d1FSUG9kWXRDSHllQmVN?=
 =?utf-8?B?TWQrYUtIcXJPVkFtZm9NUzNtT0dhVGRseGFJbHJtYWtubm5EUWdiaUpsQlBo?=
 =?utf-8?B?c2NQTjB5cW41U1Y1QjVibnAwK1gvd0RIeE9talIveUJucHNKbHE1WTBWWm1H?=
 =?utf-8?B?UEc4MTNsRGRsdDlkY1NyalVzSThFS2VpbTZRNTk5dkdld2lQRkw1VW1rcVVW?=
 =?utf-8?B?SEVoL2xNeForVGFKc2JSMVZJcG9EbTR2OVFKclQrei92WlVjN2h2ZVh6QmFn?=
 =?utf-8?B?OFJUbGhhVVpvNi9VaXM0QkJ3ZC9SMTc4ay9zTkJnUUhyUnFJSWpmdHBFSWNY?=
 =?utf-8?B?NDlJTExmMUFMR3lzQ1daMGlvR0xKa0I0VXZkYXZrV3BKNDlTd3pkOERlbWRo?=
 =?utf-8?B?MEhyMUdNNVc4WFROVDYzak9ZUkpJZmYrRDYvTG52NGpKeWF5K1RlWENJRHpp?=
 =?utf-8?B?ZFhlcGhBWjV5Q0djYkVCVlhDTjJBYTlQOGQ2TjRRa3YzajhiQmU0b2JxWHI1?=
 =?utf-8?B?dEEvelpTdXNEUEI0VEVvZHlBVEF5TkI1RjBqTEZ1dHNKczN6dDExVnhkTWx1?=
 =?utf-8?B?TStXVGY0Y0ZQTHNtWk1PZnY4dGpiMlEyR3I0RWJyUE0wc3FjcVpQOHJYS3NV?=
 =?utf-8?B?VDM4NWl4dVFFWUFqUXltcld6cVZLSnplcHNETDdZN0ltTGYxcjRuYWg3RExp?=
 =?utf-8?B?Z3lHTGZob3VLa1RQcWtLTTN3eVdEK24ySDkyZDZhS0IzZ0dDSThhdEFOQXp2?=
 =?utf-8?B?dGxxcWVsSzJEVFVLbTBRZEY2TDJRSEtYK3NEeWFzWU9SRklVRFNLdVptYjNz?=
 =?utf-8?B?aUF6R0RlY0Z6VE4zbktwUUQ5TG9LN0lXOGFEMjVFc2RwQS9MWUc1cWVGR2Rw?=
 =?utf-8?B?UFlScDFsaU9SdnhpM0ZmWHozY3k3QlVHNGptM2hzd1N3U2ovQkxRN2RETXhG?=
 =?utf-8?B?Z1B0cmdVbG83dzByYitmTVM2SXVFVDIvZTJ3UEVibXIwZkRJRGd1cWsxNjNC?=
 =?utf-8?B?MVBJeXlGRE91S3BrU3BFMmpKblRYc1d4WmcybkxVMDBnQUJDV1Z2RmF4Ty91?=
 =?utf-8?B?T3ZFQzNaNTl3Q2ZxYk5BK3MyYkF3bXhmamxZZ3c1WjhIZVYxc0wyc0ZJV3ZC?=
 =?utf-8?B?Y1JsM3dtQ21waWswSFd2VzdIaTcwa1ZTaldlakZWNVdpUHhOL0J3azVzZE95?=
 =?utf-8?B?eENDTFFYZXRXbnFkTC92UHA3Tkk4dWRwdXp2TS9uc2FjaXR0dG1LK3hmZVpB?=
 =?utf-8?B?RnR1WnVySWVCRkpvWm9lU1QzUzA4eVM2S1RtZTNlRllPM2srNkZhajZqcmp4?=
 =?utf-8?B?Rk9kOWgwa2FhUXZaVkN1NXZkNmdyNTBHUmRsNkFsVTJKd1doRzk5bjRqbXdU?=
 =?utf-8?B?OHBHOXo4QVdwL1hBazEvbWhsdjVFdGh5ZkZIMTFLZ0NRS1phRXhiK2ZFd01Z?=
 =?utf-8?B?ejJZMy85MVR6dlFOQncyVGN1VVYyb0diQ3I2UVBOeEVSRW9DMTVUbXl2VnZB?=
 =?utf-8?B?eW1mV082b0FEZjRzcjBqQXFYNk9Iek4zZnltZ0RwY3dJNVdXZGR1cWtlbm92?=
 =?utf-8?B?V1hKeWZKeTlhV2NhWEJrWGsvMzBjZnNhd2xkNy9IbHplZEdac0NWOGI3Rk1E?=
 =?utf-8?B?TytDbkF5OGh2cVhmUUVQaHkzWnFuQWY3a3A3bjgwN1FoWEJTWjRiOW04TTEr?=
 =?utf-8?B?bHNJNDIyTXVsTXBZR0F1dnhKVGxPVjRWa2hhZ0hhWWdacXZJYzNPOVEwbUwx?=
 =?utf-8?B?R0Evc2E2RSt4RVFBMG5yZHJ2MGdrRmdtMGE5Z0tnU09UQjUzeWZQMk1kQ3Fm?=
 =?utf-8?B?Syt5U2tCYklVaWRxajVmamkwUysrb0Rya3lhOTFRUVRlM3JpRVkrc0UvY0N1?=
 =?utf-8?B?ZGxoN21tVlIweGtmQXV2MGF1dWNRL05qbUZNejFBS0I4Zk5lbVYrdUJFdHNO?=
 =?utf-8?B?Yzd6YTRUd2RrRjBub0lFMnMzekNrbjZUWWpXM3NGb0FVeVRWU3FnTVRoN3l4?=
 =?utf-8?B?bWwranNjSHZRWjRhNzlGK3JnKzUwdjVCTHVTb3I5SkZaTzdEc2w0UFBDQllN?=
 =?utf-8?B?RStrSWdHNmpyN2dWa1hyQzVSN3Ewa08wNFppTlJHbjlocnhJbHNRRHhuOWJS?=
 =?utf-8?Q?93AMWttKqgM/nKhKr4xiqtXwb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f3710b-0fba-481d-49bb-08dd15d9bb49
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:38:25.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4d2C40OZrf/IWGDP+wBEnv37VSPz4bSiT+WaAQHwfFDNeJ2K3ZUuU3Egq7RAXRMvtjsDuI/3FdyVPXvVieeAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497

>>>> Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
>>>> MSR. Since the sample period is programmed in these control registers,
>>>> IBS PMU driver allows opening an IBS event by setting sample period
>>>> value directly in perf_event_attr->config instead of using explicit
>>>> perf_event_attr->sample_period interface.
>>>>
>>>> However, this logic is not applicable for freq mode events since the
>>>> semantics of control register fields are applicable only to fixed
>>>> sample period whereas the freq mode event adjusts sample period after
>>>> each and every sample. Currently, IBS driver (unintentionally) allows
>>>> creating freq mode event via ->config interface, which is semantically
>>>> wrong as well as detrimental because it can be misused to bypass
>>>> perf_event_max_sample_rate checks.
>>>
>>> Then let's fix those rate checks?
>>>
>>> AFAICS this patch limits functionality because the IBS driver would 
>>> have to be fixed/enhanced to support frequency based events?
>>>
>>> I'd strongly favor fixing/enhancing the driver instead, as 'perf top -F 
>>> 1000' is easy to use and it is a useful concept.
>>
>> No. This patch does not prevent opening an IBS event in freq mode. User
>> can still open freq mode IBS event with usual interface attr->freq=1 and
>> attr->sample_freq=<freq>. i.e. 'perf top -F 1000' with IBS event will
>> work fine with this patch.
> 
> Oh, I see - the regular tooling uses perf_event_attr->sample_period, right?

Correct.

> Never mind then.

No worries. Thanks for the review :)

Thanks,
Ravi
