Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B21FCCF7;
	Mon, 27 Jan 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968227; cv=fail; b=OIvIB+OpyEgv5jbfwBegfr+8I/jU8LMVvK0Jt7SsW6VE1BpNQ6mwqKjJJWQQN83EoeKiBxwBXfYMg0qBP+TOM8eQeUtQ4cPTcefkTO3FdiS8xwTcdiVP6vrUBNZNlTdgu/tO/yW4tj8r05Rt66P0W111X46Kuz5gGi0EK+Li/bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968227; c=relaxed/simple;
	bh=3qz1bMyM2LYYbHpxqgUHJpVqOuOy6gDLfVJ0RZZoyWs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eqOU4c5SXSyeTXCbUIo5/HMAkeP8rwSjOQ4YSq6W9mEEGDvaMYzIBNwyHBFcNFWBtTcuuvo8idYoeTWL+dfcXsiMjUD0xzKh9KaDnlQZMEvORBWeZSFAEKKSbOrunAsUvZLE6N3JAPk0saMQgZEh9lWZgDHuWXMXKWmn40e1W04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZLzV1KhO; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZLzV1KhO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqOxSRTjeeQYUVSf8bnEWgnmOJmHCySALEfT9daOrzTb71N8M4c70VCLuo8mjSVTBOquU+duF9GObSbPorVGRjyOyXdPrnJXXwQxh2FoRdPzPjt0ztEXZHzC4lT+/faovggfmdHqMBbKyT0Yiy9cmV++krXcZYnzgATxksgnBKG13i9Qk2cCL/4/e1jDYqg3OR7zQ++5htcdRzNMjHHNQCjTVcc0v4Ar4LVhcOq8TOAa32WtSAfaqE3a0o2xi6jE+EOnv5ILvQWxBcTRscRgMPwC2IkiLHYQbOCLX6grzPvoiMRIRYVwcCLPMK1Od383uoEsmonfOEBO+NvWMAarig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0fmxZTSkjpxQuSDvSp9bALh1dagzi0lvAK2faGx9CI=;
 b=oorl493XrCEt3brF0189TPp52nmeBg/4zAeaM514Go2CBxNCEq3bgs3pxSkboi5WIwbuCATq2IV7eRCCKjiYhoB/yBlLG3xmDcLewDI+uhmoqSAuLFYP7++h1ymULI2zPbxaDJnNeStGLaWZwH2tRJNHd3i4b0mR97k+DeIxk7/IHPDikz9fqoseUxG31H9CHaeOgm+mnDtswZl7KqHve/hExFMZfI+AkBplXOxUTgcy/J9ySCdy2BZtav9H7HhUHfKwWi+UxVlIteXDkPWzqzMQIPqP9T4bzG4bQDkGViwoY/+ktyZTjeNFmlG9D0/Of4iZ7ggmdeRfHfRTKA/HJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0fmxZTSkjpxQuSDvSp9bALh1dagzi0lvAK2faGx9CI=;
 b=ZLzV1KhO+ZOFqyNiG24g8qr9LOUuljAkJrujWYnYBG/cEppxhDWWa1HqowcHNj+bMBMfMXw40MgsBS0JcjN/wFfbmtCVooOndj6bHFk4k/3YolcvzZDjk2xRYlh5nd/b1cvQ1XJho54+hBIiyhPWdgiScal8SFhLbu+k/QvlA+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 08:57:03 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 08:57:03 +0000
Message-ID: <b2fbbc6e-0d8f-472c-897e-0056b4803e36@amd.com>
Date: Mon, 27 Jan 2025 14:26:48 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC] perf script AMD/IBS: Add scripts to show
 function/instruction level granular profile
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
 eranian@google.com, irogers@google.com, kan.liang@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, bp@alien8.de, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250124060638.905-1-ravi.bangoria@amd.com>
 <Z5PM9fNzMmaas0kC@google.com>
Content-Language: en-US
In-Reply-To: <Z5PM9fNzMmaas0kC@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb3c889-f998-4ed0-2c04-08dd3eb09144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWVoMU9Fb0taOEFxUlo5TmhYVzNwZVRaeUFEOFhheUNhZVVVbEd2bHRJOVVR?=
 =?utf-8?B?eVJFeWMwT3piM1E0MWIvTWEyMWtJK3JTVlJHdjlObTVPelgwcWtTRk5XRXh6?=
 =?utf-8?B?YXgyNnRqZCtjZXh5Z010WGQ4c0xCalF0ZElEMWhHY2dudnoxa1NLRUdQakRk?=
 =?utf-8?B?OG9kSEpBOGh1cW5BUHVRR2VMdzBvK3VFZUdhejFSblh0RTNISmFqNnBKWklE?=
 =?utf-8?B?NEFGNzFkcHVVTXFTcXpPeW1MWjE3Y2RjSVU3S2xjZWsxOE9DRis3RnhJY1Zp?=
 =?utf-8?B?VHU4QVdPYVJrZkZONzdRa3VUeEU2bDVPL2wwbjlWVm16SEJrTURHS3I2by8r?=
 =?utf-8?B?ZFp6ZE1ubVZ1Y0dWSjFhWFhqQzNGTWFDVFpoQ25IdHlFVmFKK0c5R3BwYXFp?=
 =?utf-8?B?ZUVKZEZNS1Y2T0tHdWFIU24zVFdxc3hUWk1yd3doUzZ3L21PSktuT3JuaE1L?=
 =?utf-8?B?L0dYaE5oUGRwbEY5akN6RWlmTm5GSitVL3FwUXhPU3pYVzJ1NDZZNE90ZGZw?=
 =?utf-8?B?VVVGbWM1TStiL1RjdmwwalhjcjRQa1lhVTE1bWJrNEExeE5pNlRJd0VsNW41?=
 =?utf-8?B?RXg4T2RzZDg5cGpVay9jbUszWnJXQlVQd05DbGlvc0d6YmZPTG12OUNWT0ZN?=
 =?utf-8?B?V2huNlhZck1OWStDZnhtVDNrYUUyb01SNGFwbkwxL3l3T2F5Y1EydWpOVEdm?=
 =?utf-8?B?ak9BUWtjbit0ZS80UlN4MTFBUXNMekxrZEpRRTFCbVNheU9WVTZYZmRKQThj?=
 =?utf-8?B?VGtEaFhzUFRac1hPb0JwS3BiUnhEUWhrV3RQQTVGT3dUZVpURWg4ZDE4TUts?=
 =?utf-8?B?VjdVZ3g0WXR6NzhDWUZhRUdXdnpGaVc3elJzSy94L0FYSDZkMHFaSnFEa2Fm?=
 =?utf-8?B?Uk9GRDZxRy9HMjY4WkgzMkl3dzFNNVZsZTFEK0owYmFwRThPYkJRRGJUeUtL?=
 =?utf-8?B?YTFOUjFLR1VvbWQvbDZscUpPaXkrNnRuajByNTZSMVRZaUlDU21tWmRDcXFu?=
 =?utf-8?B?YWJ2ckRTTlhuWWJDR21KYXRrUjhLZERINVRvRFdyMmkwZ29SQUNxWjhBZE9G?=
 =?utf-8?B?NEZKZnZSV1pCT1V0S0xKV3FKWmVpRjFweENHenhFR0tsY1hHS0V2QTV3Zm95?=
 =?utf-8?B?Vy9JWW5VTjBSajlNUkdLdlhxNXNnbmViWjdWeFBkQXphZ2hXNFNqMktPTldv?=
 =?utf-8?B?VXFpOUVJaGpQZlowazg1cW81a0t6REVxYzVqWVN1dURITzR3blZaVDdpYlY2?=
 =?utf-8?B?dlNCWmNiTm9yeGN2MGpheU90NmRPSGNldXlWdXIveXFESVdISk1KRFl4cENw?=
 =?utf-8?B?MHZpT0pFTS9BYWxJd3VnOTNaU25heVd3b2I0azZXMHBXbG91R21VZmh6WTF2?=
 =?utf-8?B?Sk5UZ1AycDdTTTI5TmFCNUV2TXAwY1piNXlDVkxRZ0NIaU9hOXNSbldhQlV2?=
 =?utf-8?B?NWxZemFadk9FT29RMnI3Z1JrR3VnZ2R5R0NHYWJ2UG1ZOU90akJPMzhJZlhE?=
 =?utf-8?B?aHB4VDJjUGc4Ky9UejQzb2xBR2pqejJRQUI2azIrVWpWNm5Td01HQnpWdkJR?=
 =?utf-8?B?QzJtZjZBcmVLNVlaWko1NisvVW1DSFE2bk9zeVdOVUNuVWJKRW1LWmRIZUFx?=
 =?utf-8?B?b1dxSmRKRXk2bUR6aWY3Y2tSQllRejB5SStYYlVjVkJiSkRTaTZWSjJBc1JY?=
 =?utf-8?B?NVhlVnFOQUNmcSsrWHRqNnF1NjFJN3lsVGdLOGFiUUJpaFRpYnY2dVBUVGlq?=
 =?utf-8?B?TG1zT25ySVJDU1VTRmFFSWdpRkNRb3ByZlMzeVlTN2s3WElwam41dGU1L0c2?=
 =?utf-8?B?SDRheUhxeWFmbU1mU05JdVZHWWU1STFEQXEvWkZoanhYbkM2dTRjLzBwdVla?=
 =?utf-8?Q?JSZc5dhUc3G2a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STRSUEV3M0szb1NObm5VdkpGcFE2UHR6VlpWM3RuOWFqdEdqREp6ZzMwaUl5?=
 =?utf-8?B?OW9FcWNjVjh3azdPTXpKODdpWkVKTHNqN1FlU1VzZDhwNE05bmQyNU5HSlRY?=
 =?utf-8?B?clIyc2haVFUwYzV4WjJLVGt4Si9QZ2JRcTNVOFEvN1BXcEJyeFp1cWxRZUhX?=
 =?utf-8?B?cGNaaEVNalJ5d2U5eE5oSnlKOWFlSmZyRkFlWmVvVVVJcUVzVktPTFA1MjFD?=
 =?utf-8?B?cXNVZlVGMWdSMm00Y3JFZSsyMkJrUjhRQ2Z4dUN6NFY5ei9uN2xBbXlGZDlN?=
 =?utf-8?B?QzJJaWJmb01Xb083dXB5MnYvNFZ4RWV3cDU4eG55RVIwTHQ4T3ZDN1oyNkJn?=
 =?utf-8?B?T1QxTllQWitYMitLY2RURW9aaWZNM0RiUVRXMVpvdXdUdVdEc1ZpVjVTU2tw?=
 =?utf-8?B?TzdkK0M2RC9EUUhyWEZtSlZpVDlZZ3hKRmZWaGkyTlhCTUVZWFQ4WVdYL3F4?=
 =?utf-8?B?SzdJOWhGaWhiVnNkamI3Y2Fxa3hEbW5GTHp1enpBam82VllhUEhuYit4bG9s?=
 =?utf-8?B?RExlcE9rMy9Hdlg4NDlDZm14V0k5RTRvYVlKSzRHLzREcnAyMDFoM0ZEZ21l?=
 =?utf-8?B?TmJNRTF1c242c1FqUWNaV0hXbDRiekF5ZUpQcVd6Y3p4cUVwWDVOK0hhTnZR?=
 =?utf-8?B?TnVYVVRWZkw0emppZDU4VytJWGVmTDhnTlN2anY5S3B4K3ZPVi9XNEJLZ3hD?=
 =?utf-8?B?MEpwN29Pek9xdHlDSUd5SEdUaWd6K1VhOHo1Y1YrYzU3ZkIxUytYaGZvR21w?=
 =?utf-8?B?MWY0ZElWSEtnUVN6eVNEVHpCSlhmWGZUclU5cGVLYlo2aENSZ3dRT3QwU1hH?=
 =?utf-8?B?SS9iTFhkTjJ3M3RFYWhXMVREa1ZId3dGKy9aaUtWZnhYN0xwdGo2dGhXZ0Yv?=
 =?utf-8?B?S05zTHlFTCtuSkIvdmdZWjFLZHZpSFFNeExoVGcwTlljZVdmUVlmUHB1T05Z?=
 =?utf-8?B?NEpSNE9nQ0k5VGg4K3JMNndpT0FBNW5ZeFhGVlk4b2VkaTNoUkszdC9CZ0E0?=
 =?utf-8?B?T29EcjFQczhQVGhZSDdqcnhoc1VmcmU3VW50amk1dFJFOFdnZ3VZZlNMcTRq?=
 =?utf-8?B?TlcrNnRhWTg5Sy8yS2RCQ3JMQ2h6QXorQ2VCL2dHZGhmR096clR6UVhIdXVz?=
 =?utf-8?B?RHhRcGdMT1MwRE5uVVhEZGFES0g2QWJOVXlRQjhoQlZEV2xUVWpyYUJ2Mi9y?=
 =?utf-8?B?K0lNVHZ3TjRhcnRrZ2NXUWR6TFN2SWRqbjkvMjdTbzI5N2FvRkJmM3BqYXFZ?=
 =?utf-8?B?ZS95MjR0TmlUVW9ONCtsT0NWakdZWHdrV0J3T1dOL2o2L0k4L21OaXZzTWV3?=
 =?utf-8?B?UmQwRkI2dE80cXhnK21uejM5U3A5QnJWaEVTVndLZU5vZGM3OEZKV0RGQ2Vi?=
 =?utf-8?B?UzFiYXBtWEdXYXh4WTdhOFI4TXZsRFhTekhEeFVTRlZaTisvSlBzRzJaT0Rj?=
 =?utf-8?B?MVlhcmo5d2F3TEovaFlwYjQ3RFdOMklxZjhMMkp3V0JYc1ZvUG5ZZys3VlRV?=
 =?utf-8?B?MlpsYXpNWFd1REhGUHJJR2d5elZ3TGx6Sll5TGliRHUzQWc2eFhtM2RjR1Nh?=
 =?utf-8?B?MTNtdkw3QzFlN1NUTmdpWXFLSU1MQU1UanBlL01IZWhqbHk1d0FFTmFobHdS?=
 =?utf-8?B?Vk9sU3dyQVZSd0c5Q0s3Ni9nSXBYNEdHdTV6WEx2dThDNlB2UlU0VFNWbmJL?=
 =?utf-8?B?UXdHNkFmS29JK0NLeUFRTnJZaStLZC9MblRDM3M3SUp5SFdRZjRJNW9KaU5r?=
 =?utf-8?B?cVdIejBiTFBGWGhwclk4SXYyQ1ZSTExSK0F0MitiMXFyNXBBTlI1QnFORHh4?=
 =?utf-8?B?Wm1WSmhBdzM2cWYzaWxpTXpCeGcyVUREVTZnRFFjT3djeVFiZUFOUHZtWnkv?=
 =?utf-8?B?RVBlcSttaSs4TVhzOVVyTjFCYWJqdzhKU1RqQ3hrZGNqYWZMSU1XUnlQL1JK?=
 =?utf-8?B?UzZzRVFIaGNmZGtCdFdsSFFweGZ6ajJJd09HZ083NWZBU3ZTcDUrTWhsVERi?=
 =?utf-8?B?ZkhReThUZEZvRDVuaERoYUFITncwV21WUTRZa1l3V1VsNmgyVUNxRDNwNnJ5?=
 =?utf-8?B?NzYycmZtZXcyb0l3VC9Iem15SW4zTkZlQWxPMU5HSXlTS1ZqYlVnS2RJd0o2?=
 =?utf-8?Q?ekjGjklNIzX/4HFVNfikTyZNq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb3c889-f998-4ed0-2c04-08dd3eb09144
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 08:57:03.2391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X9HXZLQOPi9rXqx6ujclJOPGY3uZOih2AAx54hAkpeOFB/xGO6BDQ6ZI4MGlrmxEW0ZUiCj3KCRMofdU83Z+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

Hi Namhyung,

> On Fri, Jan 24, 2025 at 06:06:38AM +0000, Ravi Bangoria wrote:
>> AMD IBS (Instruction Based Sampling) PMUs provides various insights
>> about instruction execution through front-end and back-end units.
>> Various perf tools (e.g. precise-mode (:p), perf-mem, perf-c2c etc.)
>> uses portion of these information but lot of other insightful data are
>> still remains unused by perf. I could not think of any generic perf
>> tool where I can consolidate and show all these data, so thought to
>> add perf-python scripts.
> 
> Thanks for doing this.  I agree that there are many rooms for
> improvement in this regard.  While I'm ok to add the scripts, I'm
> curious if we can add something as sort keys so that it can be used in
> the general perf-mem and perf-c2c.
> 
> For example, function level data source breakdown can be shown:
> 
>   $ perf mem report -H -s sym,mem
>   #
>   #    Overhead       Samples  Symbol / Memory access
>   # .........................  ......................
>   #
>        4.58%            97     [k] psi_group_change
>           2.89%            51     L1 hit                                 
>           1.38%            35     LFB/MAB hit                            
>           0.19%            10     L3 hit                                 
>           0.12%             1     RAM hit
>        4.54%             1     [k] bpf_ksym_find
>           4.54%             1     RAM hit  
> 	  ...

Interesting, I wasn't aware of this mode. I usually group them using -F.

  $ perf mem report -F sample,mem,sym
  Samples: 531K of event 'ibs_op//', Event count (approx.): 4359237
     Samples  Memory access   Symbol
        4922  L1 hit          [k] perf_event_update_userpage
        3028  N/A             [k] perf_event_update_userpage
         281  L2 hit          [k] perf_event_update_userpage
          48  LFB/MAB hit     [k] perf_event_update_userpage

But, AFAIK, -F (or other options) does not allow grouping and showing all
the data at the function granularity. For ex, if I add a TLB column, the
data gets further split hierarchically in -F field order:

  $ perf mem report -F sample,mem,tlb,sym
  Samples: 531K of event 'ibs_op//', Event count (approx.): 4359237
     Samples  Memory access   TLB access    Symbol
        4920  L1 hit          L1 hit        [k] perf_event_update_userpage
        3028  N/A             N/A           [k] perf_event_update_userpage
         280  L2 hit          L1 hit        [k] perf_event_update_userpage
          48  LFB/MAB hit     L1 hit        [k] perf_event_update_userpage
           2  L1 hit          L2 hit        [k] perf_event_update_userpage
           1  L2 hit          L2 hit        [k] perf_event_update_userpage

Thanks for the feedback,
Ravi
