Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE072B9BB;
	Tue,  8 Oct 2024 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365452; cv=fail; b=tcu7v54Y5mOsSK9UADj4Xstb9BAT00ekVgZ5VpDdkMzXw8FGtzrYWNoaEN6zHVk06CDTbo9eIQZhBgCu3tIsWkl6ONyRE0cOm97knJ5S7LImLktLSyKNWsKQ5O1Bek/PkDGYbhLUFa+tVEurpnf0qDd5h9b4zMW/SWRR4KnGLbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365452; c=relaxed/simple;
	bh=X8Ofo0O4EmbQizzv+GPgwvSt8Ur4UWOetaNby5R2b/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/yQSKS4/T/bQhzMxP13exoWUJFsKn31M6FlaMaCKCmx0vA4ByDWwwWHsPVvuH/yxwU9Kuwy/lzC2z0yfXwHpskZzbCqqGGErZq8j9BDY1CCVqiPJ+8FJ26rBipyA5e6r7g6xvBlfsMn8CoFraqx7QAFGY+0wg0XsojCk3nb4+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OZr6QWeL; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OZr6QWeL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJi57nK7sMTF7nDvTBgsEjzGW9vAXCTvgi+sVn0hbZ+bQFJAR+qBppRLxifwWcKTM7CFkM5IgsJ4FvcwGBj4h0Va5ieRKh4/rLTAk6DvXLUr+6Ekze89bQ5/yo89rHJqcz9QgOeuli9Aaf3JfQHkhWPMiiFF+K7QMU6A3aVa8zuogWMu12xC6pYrNefGZ7Y80Ih+aHqw6mu2aSYqEfkuzBgPvqyRRDpIF+olxe9uiZEw6zAKLnmhZfTb5e8Mj/va8vUeqnVEfbfzXTiCJoJUJRtb4u//sp3CWwV3knQT2sli5qTAmlBio+W1NI+iQS3ReFGgc6l/eq7WhvJpmDvcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/tIILYUVGmyfSe4D6OGP1pDnHn65LRbWpfFeERZYOY=;
 b=AaLyl5hVbUZ67PpnuepMoSRjbEQ3u4KrnOmHb6FH3J+q/SaG2O6jFenu5qLwW/WfMHn9SP8Bkr34T9hWIN0sNCD903jSdLIV1ML1BMyy/Vdzb/3kAetUifMgKT88qFOzkhd2kk92eDEBElxnrdVD8uZUoIsYXve3krNCyCs26Rgcum/dNk9Ayq2s75ZC0SUR5zI7eo5jyKU76z1nrLhIUoa+weZJMO8lIATCsX27E0HhiK1aAeWlLai95Ffg1mzOMwG13nuh4z5qeTPujmwqRcXik1LAkk5P5yix0+pj2Umfg105QMChxjMWkBWCQDwdPF/lqcMrXOb440mXKus4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/tIILYUVGmyfSe4D6OGP1pDnHn65LRbWpfFeERZYOY=;
 b=OZr6QWeLJfweTA3HUbiUHUsbn4Yxg6AIL2BH8jMnPVkw/PD3hJuQVMTtmbQbTyGfYJc1XA3NHnGhrHdC6PpC0F5kbrI2X1uLK1fgXNDVSQUUoyBQP+uqRFU8Lp2DWWuNHus2S2zujIZ5sl+hP0c+cPRXJ7XGJYmKdpuIbthLbA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 05:30:48 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:30:48 +0000
Message-ID: <79ccf66b-6bf0-4cc8-b001-aae44f09dde9@amd.com>
Date: Tue, 8 Oct 2024 11:00:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] perf/amd/ibs: Don't allow freq mode event creation
 through ->config interface
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 eranian@google.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
 <20241007034810.754-6-ravi.bangoria@amd.com> <ZwQ1cRhRuE3kunjK@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZwQ1cRhRuE3kunjK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a92653-2ecb-41b4-291b-08dce75a5d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0M1WVhLMGQwNTI5S1hydEtJY3pNY3hjWGltTEd3ekZUYzA5bjV0RjJPZVc0?=
 =?utf-8?B?bmMwdEJtVHFHK0hBeWFSclpPR0tEbCtIV3RBMjhBZUZEWDdac0dERml5QTF3?=
 =?utf-8?B?YkN4YVRUY0R1cjlIdGZXeGV2L1dwWTk1UEh4S0JYeU8rbXRTd28wczNHeXRv?=
 =?utf-8?B?WXJvUXRMcUd2T0pRWitUdmxuUHJxY0lPNlpCQmtseGRSYmtnOVJlT2ZHSXhN?=
 =?utf-8?B?ZDBNeElkWUY1RDBSUWlKMkt5djM4QkoxUllQaWdFSk5NM0ZwZG1jaVZXSjFE?=
 =?utf-8?B?am55QUx3OEM2Q0x3dmMwMXRIU21mM2FEKzBzejFFcWlPc0Myc3FWS2VVZytZ?=
 =?utf-8?B?Z1J2dTcrcHREaGtVOERlOFV3MllGNmllaHhSZGJCZkl4Sy9ROGt4U2V4RGZ0?=
 =?utf-8?B?SlNFWmZoOE5BclNjWk9LMmZLK2ZsMVhpckNXc1JaY1JwMElFY2V3RDlERThk?=
 =?utf-8?B?THRpQ3paMng4ek5qRVlPM2U4RVhLaVFxRlozaitETzYzelNPZzR6K1NZUi9y?=
 =?utf-8?B?SGVqSWtmbGJJZnliRG9DM211ZG9nSW50OW9CcUsvaVVWNlAvQlp0ZnMxRzgz?=
 =?utf-8?B?c1FvbE1ERE9JSnVlbmZZV29Fc01FUzVtVXlqOXRZOWNuMkFkbUREek5WUjk1?=
 =?utf-8?B?NnpScnNaK1hmRUdSUEJIdkV2UHFsRnQ4aXR5RE54STNVRFo5dElFY085cCtV?=
 =?utf-8?B?bFhKV2xNUWlJeUo3eGZ5dTVMODJvL080RjJNaFJlVGlMSDJaV1NPZTBqUURN?=
 =?utf-8?B?YW9adno3VVhoMWlTaXYwNUpsK3RoekNSbk9QejVZVmxEZjV6M1VGdWdoK0lu?=
 =?utf-8?B?bEJhajBqb2dpOTlxOHJ0VmNMYi9uWEVOZGRuY0Z0SllhVnNkMVprWitRZWN4?=
 =?utf-8?B?NlNURlNLL244MmlHS0poOGNDNW9VanFVVThWMitmR1JPUEVQWjU3WjJTaW5M?=
 =?utf-8?B?WkJjMXhyNm9KSzlLei9LVHNkV3dlYW9aa1VETVo2YWdFMVoySEpIMlIvOENn?=
 =?utf-8?B?bDVTc2dwOVBJNDhpZ3pYNEJPd01LRUFNQ09jOFNPT2xGMkFFSGxlbldOVVB5?=
 =?utf-8?B?YVdlWTF6SzgwZHlxdU5WTnkxNnA5dGFyN2dkSDMxN2NSRUZKZk1UeUZhdDNQ?=
 =?utf-8?B?c2k1ZzRoMmF6dW96Sm42QmxaeE9ZMkZleGtraWZtVCtLVStQcFpXYlQ5RDZ5?=
 =?utf-8?B?cGZyRzdaVGxnaGRabjZvc1RnNFZwWHppU1IyYWVpQW1pNnBVaThnUS9PYU05?=
 =?utf-8?B?VTJ2eVYxMWU0OU45TkRNdGlPV1VDdGJURDlzSk5Va2NmNEx6MngyNHdYU3RU?=
 =?utf-8?B?TUJ5OXkydkFnbHFlN0l4cUpaL3ZONXZQTm9JWkdlSXBGdDhvL2RCRENscWtr?=
 =?utf-8?B?TC9Tc05ySE90WXRjR00rVkhWeXB0eTdKL0tXRDhyQTRBbSs2dGR2Qmw4WStJ?=
 =?utf-8?B?ZktFMW44VXJMS3Nkc3lJUWVPb2oxNFBNTWFtSW1sWlRkSWV0cjBHY1pwbDBr?=
 =?utf-8?B?ZTdTMnhLZTZNcE4wb3JBRXplT0REMmt4OTkrdVBnYk1nZlJoeFFXczJNYXY3?=
 =?utf-8?B?bVNIRlRRaEI3YmJjNUYwNmRPSnloajJrTmtHa3AxM2RVK0xqL05mWlNVMmlZ?=
 =?utf-8?B?MWd5ckVtcFk5V2x6NUoxczk2VmJwUUpWSnNZd1YrWU5aQy9KWjlPWk5MWTBO?=
 =?utf-8?B?ZlZWaVpSdmJuM1U3VzZHdUZUd0FGaHJkUGlITUdzblBtVTBnVjMrYXl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0NtUWlDeHRjVitPZlFiLy9FQk9UNWFrUE5XUjRHV3VpMDVHOXhsYSsvdjFq?=
 =?utf-8?B?RWFYT0wzc0dINnpML3dCbzMxUGgzeURXTlQvdHZWTTYxOCtia2tkQTVRazk2?=
 =?utf-8?B?ZGdia0NXK2RDT3I0eEZKSkY5TDkwN2R4MFRWclhzT0dJNDhhZkVpS21YaFdi?=
 =?utf-8?B?M2JqdjNLOVN0dkhoYnY0S3pveEk4NnkyOWZwWFh5S3pyYTZEdXVuY00xM00x?=
 =?utf-8?B?OHdHUFRjamhuMHR4c0w5RnFpRmJydXZYTzM5THBzeWFTVXJSMjVxTnRXaEZM?=
 =?utf-8?B?VW4raUFEVm5GVS9zOXMxeVcyRmprN2Z3dlJPUHNoanF5Rm5pNFk1ZHM0NWNB?=
 =?utf-8?B?eGNaZHdqUXBOVWszZGZscEpEN2l1WHVFYzV5RTBOVEh5bnRNRjhhb29vclFl?=
 =?utf-8?B?WlIyeVY0MFA2YXM2RFoyMHNtNlFyclYyY1FML3JtM0h5RVc0N2RsL0V2RTcy?=
 =?utf-8?B?NDdWUXcyQXRHWmFrZ2NnVENWTUJVVktjVTdrNERhbldhUElqRE1CR0duMGtL?=
 =?utf-8?B?NlFWTk1GMnYva1o4bmZUNHJGS01SNnA4L0xPOGtKMzQwd2N3OFRXbVFHMC91?=
 =?utf-8?B?c2ZGMU1NaktWSDZXUGJ4dXZrdXhpcDg1QlkzalR5RGdZRmZwUEovaVA1RXBa?=
 =?utf-8?B?L3h5b2p6ckEvZmZxWG00RFVCRWwyWEVhdTI1dTNzeHZJYlJucDZKV25LWWdo?=
 =?utf-8?B?aHM2MUhnOExIM0NuVGRmWEs5YTZLUWhqTDY5NktIVnlEbU9iZ2JFdDFVS3c0?=
 =?utf-8?B?bDZQejhTQTd6bzdaUk95UzI5RUtxb0RYUlVza1A3UTVPRTM0TXNIQXZoTFJC?=
 =?utf-8?B?ZnExaG5FMDlhRkY2bXMwTUhWNXhHZU1kemtQdDgrZTIyMW9YekpJRkE4azhr?=
 =?utf-8?B?Q1hxV1hDa0JMSlNaZWd5YTRYdjBuNzhrREk5Z2p3SytVNnl0bUx2VWRmYkM0?=
 =?utf-8?B?ZGQxc3dzaDBnQjZxYVo4UHI1bGxaNmx1VjJadjJId202SE80QmxSWVkxRGpj?=
 =?utf-8?B?ay9uNEV4Q3VYWVRSUWtMMk5iMmZILzdLTzVzVFZMN3ZEMDFMSWNmWmtPdkFh?=
 =?utf-8?B?dUYvS0tIOGg2cVNIY05qVGJNTCt5MkRwRThXS242MzRiU0U3RjZDdndzcTlM?=
 =?utf-8?B?WHJEMmt4b2dxNWFoRGZKU0Q5NDloenljNDY5QVdmRnhBQXFZTG01aU13ZXB2?=
 =?utf-8?B?VmtYdzVKeUlMUFN1ZUpnVEQzeFZJODVWR1lOK0IxZ3Q2aHlzSDg2STRvUmxO?=
 =?utf-8?B?eENCRHpHbjlYQTU0OXc1ZXFCTTZEY281R3pvUmRJT3lrLzJqRmVRdXZvb3BY?=
 =?utf-8?B?VitjUWJwUnpUYWthKzJ3b3NPaWNTQVVUd21SdytoTVd6d1orMm91bHc3MFRE?=
 =?utf-8?B?VXdrMzdaTUlZckhhM1Rmc0RhS1hybVpjM083VzJONE80ZjdFWTR1WWFBTlMr?=
 =?utf-8?B?MmVRMVJKWWZDU2tuakpZUWFydkN3K3NmVXhoMXA1TUdoZE1rd25IdEQvSEtl?=
 =?utf-8?B?K2Q0U2ZTK2pwbFhRWGxXc1RKa1RuK3EwSnR3bUhrWmhyR0lubklCamt5TE9D?=
 =?utf-8?B?NSswWlhSZytZUy9yVVE3VDNuWkhCdmExa3NCR0ZVMG1KYzU2R0JLSTNSOHJT?=
 =?utf-8?B?cUxRaGw4YUlkOXNPQlczVHBuTTFrVTZVc2o0czVnSlBtWGoyYVNkZldycHps?=
 =?utf-8?B?Sk5ySWorakUwdmhsZkJiVVRDOWVQamRNTnhkOU5NUUdtTi9IMXlFU2d5MzhB?=
 =?utf-8?B?NlVIdC83NjV0V1licUk2cHVHS29nN3ZXSjU2MHAraXBoTDErSkV4dFJGT0dt?=
 =?utf-8?B?WkFIWnkxYy9BUFEvaTFYREk0ekVTRzFYVWpGRTRYeUFUdEhkRlhjUUExaU1i?=
 =?utf-8?B?UENnQUNNa1NkMDFxVXJzL0JaWGN1WExuY1U4UlhBTlhMNUdnWVVIVXprWG4v?=
 =?utf-8?B?TEV3Z2RyMzJkbnJEUkdPVjJucGR4ZEZYa3NKbWhoaWJFdmJkZ3pOa0N1TTUv?=
 =?utf-8?B?Tzg5d0gzUzBKamZxc1hvSkQxOWxuL1FnbEFiVDZtQkxsUzIrTW1DNUJjMmN3?=
 =?utf-8?B?QnIxNFBjY1hyZEs1YVZXMGJIT3NxVk5VRVRueVpkbHJrc0RadVJFaGpJOTBo?=
 =?utf-8?Q?dtUS4QJtCz0lXSgAv85IkNitd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a92653-2ecb-41b4-291b-08dce75a5d3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:30:48.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaqAzAnRAE0eMfHMmVypeM+Ep5/30fZM47WW9iPHKZf3GKhAkFxBuwMLp3uzzOd6soBqU34h5FkOWHZmweV+cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738

>> Don't allow freq mode event creation through perf_event_attr->config
>> interface.
> 
> Sounds reasonable.  I agree the freq mode should use the standard
> interface using attr->sample_freq.  But I'm not sure if the behaivor is
> defined when attr->freq is set and attr->sample_freq is 0.  Maybe this
> should be handled in the generic code.

I also could not find any reason to allow {freq=1, sample_freq=0}, but:

1) perf_event_open() allows it.
2) ioctl(PERF_EVENT_IOC_PERIOD) allows it.
3) all generic code explicitly checks for ->sample_freq != 0 wherever
   ->freq == 1.

I will prepare and post a patch to reject such event and see if there
are any objections.

Thanks,
Ravi
