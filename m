Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB241E0DFE;
	Tue, 13 May 2025 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125903; cv=fail; b=FhYgbar8hBtrEPgu4NytlSOsOnHuWG5wNfGmFDjrOmnLkd3eanzV3wjCD2rV3mLJ2wZdC6fUlGvy2IbmBW+n6JVtq2c7q4xEQMVaKfzlkL/2t1lkNXbbJeAOXqzpMs4XtOXnEN3LobEdtFahdsaWMevy3vV0TooR1kAUAzGVFF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125903; c=relaxed/simple;
	bh=E5Eq6iYaKabtK7LQZExOq0NkITWwSlEEjZ+4CXmkQ5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rHwkqPXhlolVBG90A8mn9mem0PQ5j7iZZnCCT675PnayKpQbn3z8uCeKNZEoCPD0jnEYlAUTaDP6WXnERewTvzno950q+OwOJRQYzJL5fNgEbvQLu0zDSUMx2LJnWv7YwN6Yyl/kWB0Op8t+l2hK9Fm6zvrQB3YKbe4KEWdqvrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kITatKau; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kITatKau"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMXYTBE0PNXU4Mv8kOTLqo4ztC8CS+w912lLp3o/cvkSVu1sf+EeRqEABTPYny1Z5uzcW+VK89UE48UE3O2tYNqbjNsn++2IpsJFCuseOu10x2m+1ndWXca2vvX1BDUinHnNrEZrJjBHy2WAsZs6GTCL2i2kRdCgK0G7n33pXNQpPQualaGUdpcJUk1uNaV8m+gQVFk6PgHyqFEgeSMpQMRSfmtjmRglFY2naNGygsrFdnDec7A8mavgR4VjfdyhvxXs9GN8Pa294xFDZsS18/mJphB36kN9NuRlqpdMPx+PXtkzRuOJKgDdGeEhvyn+EPvj7K7e5H+IL3rzPx/Www==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJKVPQRPIxfWW0Q3XpuvbtCoiwIdDTcXugpPgY39UMw=;
 b=SscyRn/AZTcj1sCezMcVX/AHs8AZit37iJm3Y/rrEPs34EIeMr8ol32NYJ6G8cbF6Wd0TxdBw70jIQ4HQneBwq8+XF2Zr9EDvcYQtaCW68u96Um1ogiriQhBQWCuNmB+gmGVpJDHehvPC885Kbw0eKipVL5TCroEZSajn4h+iiRQaFUmscqndRBVhlZxVTfO48tCHpjSf6Fwf8yR7vkihS+RYDVaEL40kA6g2HosNOieO4Kq4JVamxKoI7PNKjsYF0KowZPHpZpZujfhC7ISrAeGgSnOnegwmCWPOD3uwyt7Z21/iOtXnp7g/C/Cv5mDPEhtOXRcr5wlCcJp4F5cEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJKVPQRPIxfWW0Q3XpuvbtCoiwIdDTcXugpPgY39UMw=;
 b=kITatKauiLJnUTQ3tFBDgYj/hZLAu5X/i7/ftUaRtZXFxmBxOGdIm3F/UHE90guixt4z9GIPHuRADyMdRGjPYpWIxFzjw/5Xn/ZlW/HPUIN33Bkv8WAG9LAyRV66C2Bko1nxpfGmewGXZvxiV03OWJtFoCynJfTzwpqFOwWPuTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 08:44:58 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:44:58 +0000
Message-ID: <dec0176c-d47a-4277-97a6-65afb3564c7b@amd.com>
Date: Tue, 13 May 2025 14:14:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/15] perf/x86/amd: Remove driver-specific throttle
 support
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, Sandipan Das <sandipan.das@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
 <20250506164740.1317237-4-kan.liang@linux.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250506164740.1317237-4-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0085.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 519e56e2-148c-4dd6-bb17-08dd91fa70cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2VoNjNMcjcvajJET0RHMm9yaXI0clU3U2ZUeWdyL09mRWFnT1ZrQU11dVB6?=
 =?utf-8?B?OWI1bzNSb2RGZ1NMcUNFVjNUVWdNYUVYOHhGdXhsbkN2blZWR25OU3A3SzJL?=
 =?utf-8?B?SHFFYVhXZXpQRklUV2QwRmtGcUxHSzcwMTFNSnAvaGM5RTVUYVhSUzBJenRG?=
 =?utf-8?B?Q0xabkk3b0hIV0tnRjRTZUt0UCt2UGU3cjlvaVZHbGVWa2NhZm9FRytJVjg2?=
 =?utf-8?B?V1hmWVJCUVpLZGlaMGJ4TlR5S1M1VDhRcWNzUEMxOHduZFU5R21vR3ZUcXZ6?=
 =?utf-8?B?V0pYdDdML3JqUUJUM3B4bktIYkMvemNmKzZiY3JrTzBFMURzVzlSaUFMSHBF?=
 =?utf-8?B?SXJNRVhsemJlY3JsQllzYkF0WmRvVDdkK054K3FHaTJZNGh4Wk9ZMnF3aWdp?=
 =?utf-8?B?Vm5LRWxHQmRESE91SnQwelQ4Vm9DTmUzd2c4OWNTa0puUkI2QjJQZDg3OUlT?=
 =?utf-8?B?UWtnQUxYN0pxdWFzalA3RlhRVWVsUkxpcVU1b1RZbmZmaDNRVXIvd1FwZnBW?=
 =?utf-8?B?UitIYzEvZ3RwcUJNL0hoZ2JFZDh1dmc4ZzNmcFJKWkRocFhuVXFKWkFIYW9h?=
 =?utf-8?B?TmxKVXc0WWs1cEw4Um1paU1UZWZkZ0h2NlBJbll2Q0w3ZmZwcWNHSWtjekhu?=
 =?utf-8?B?dVRHRDg4UUVESkxxVCszRzk4OG51YnlzTkE2YjF5YmRpYThSN053RGZpQkZx?=
 =?utf-8?B?RTFTVk9jcWIweDBnSk9neFR6RzMwSkJmQnVJdzhKaVVaQ1VzM1FlU1VaRER2?=
 =?utf-8?B?SEhFWWZmTzVEeUVjNHZsa1Y2Z0ZuWUNzZVA3ZllWbkNKcDRHU0VFUjdLN00w?=
 =?utf-8?B?MVRva3N6bTNLUFBRSWg5N2w3V0VRK2MzUk0xbmFncm04cFpRbWNLZGhYeEh2?=
 =?utf-8?B?MHZwbWl2Z1JoTGJOUnB0RVVxZmhhQkdOcFdDTWVXc2JpS05FaFdmSVZkdXZ6?=
 =?utf-8?B?ZTV5WUFuMXZmcG8zc1Y1UHF4RWhsTmZFVzFLSHBqcCtNcHdGUVNEbXo5MVhl?=
 =?utf-8?B?ejhzRXBSeVJQek5vOFFJNlowV2lEUzdrUHQwMEpsMXdZdUJwU2lrdnNkMlQz?=
 =?utf-8?B?N1Nub2NsRWNCQXoyRDdGOFRRYm9jOGoyNGVCNzJ6aUpYZXdnUzlyaUpaakRX?=
 =?utf-8?B?dkxacjR1S2dLUk1oWW5vVUNVTk5qU2tqVGFBbFNZS2d2SmtEajhIWmNEUzUv?=
 =?utf-8?B?Yy90bEFTQTh2ZFhMVG1ydGJORmt1UUZsZ2Zsb2ptUVNKTWxoOFBwamlMenBq?=
 =?utf-8?B?N01pSWFySDFGd2RTcExSNHdGN2M0ZkxQcDdFY2RDVW9kRkI0RkNmaGFnTU1n?=
 =?utf-8?B?eWpXcEk1clRibUJ6d2NheVM0c0wxejRxZnNhOXgvdUcxUU1SMmZUTVl6VlJn?=
 =?utf-8?B?b0tpeDJheEhmRzRsbmRldFk0eGxaZVRKQVFSTnBXRVVoN09Wd2JSOVJyK2U5?=
 =?utf-8?B?M3hDUldLRW1IS3ZUY2lZMlpIcnRuUzRLVXNHRkRtTzBZTkFBWVVOM29qWkxH?=
 =?utf-8?B?azltK0pvSm5nK1lPc0N1YmVCVmhNTFJMREtwRHM1N0ZsTUFQd0w3NTRlcHd3?=
 =?utf-8?B?QzY5OFhZMmJnMDErYTlnR1NaVWt6aDBvSWRjVHV5Q3dzOTJTdDJIOUpxZnA4?=
 =?utf-8?B?dFU1cEhOMWt1TTlUTFMrZlpEVStYUUE5TzlxSlVuYnBqaUlubzRGeGdLVC9k?=
 =?utf-8?B?NWdtaVYwZ0U5QWVtM283N1VNYkpucjY4eTZxc2tNaTlYR3VBT00zRXVMSUZT?=
 =?utf-8?B?VVlsYnVwbG5CTFVuVWJaaktxMWQxcFNqdmQwdHVRZzFSYk9RNGNlLzlhZTVU?=
 =?utf-8?B?b0lSblNDeGpKaUFMWGFjTjBGT25SbHo5NGU1anNyNFJWa2ZLejlEaDU4ZzBm?=
 =?utf-8?B?MDFTQ1BiMTFvQklTdDNBQW5KdHlMRTZkRFJYWUY4amFIbGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3MxS01mNVFiT2RUMzhkd0hXUEliVHZ5UCtjNE91M0s1dmJzZGhLMGFzKzl2?=
 =?utf-8?B?K3NTbEZIYm5mR0JXKzYwSmwrZzAwZDNCZyt1TGliMDJabTU0elZTTVVBbEp6?=
 =?utf-8?B?U3VzVXdObjV2OUpGeXJSaTZCSENFcFdMNUxZUVVqYW5wUzFVbFBNWUtkcmZQ?=
 =?utf-8?B?QXhYNUNrYjFCZlo1OTVkS0ZEZ0FsK0gxUmI1aWJuQ3BQckpaSzJ6R3V2TXlI?=
 =?utf-8?B?em5jcFB1RFl1bm9JOTMvMWtMTEcrR291YkdzK245U29MbnJCa241RTZoVEVs?=
 =?utf-8?B?Zk14Ny80U2JDUUF4a0xFbGVOdlM1MEZvNE5kMDBYUUNvQVNreVJwemVLVFBL?=
 =?utf-8?B?bldzVllNeUZwWk1PcGFZQ25xR2FsSHlFUTR5c2U2QXZoakRKSGJIVGM0Ykwr?=
 =?utf-8?B?ZGtoUldTU1kwVzg5MGIxTXF6dDBvRzc3T1lONkRvMU80Vk9rSGg5TGxvU0l5?=
 =?utf-8?B?aUZiTEdZYXE3QnFUeE5wQmRUZGY4N1dRT01Kb2pLVytYYlNYTWR5WlROOFJn?=
 =?utf-8?B?bWlOazZpWk5aZEtVVk9ZcnREMDhKbk4xL2JGUjhWKytvNG52M2RiUGYwN05W?=
 =?utf-8?B?SmJ2bXdyNVJDbXIvYy9HTE1PcERNWGk1UlVzQUNvMFpMZDlSVlNtZFA0Qk5Z?=
 =?utf-8?B?M0k3dEI5b3YxajBRbGNNaXBkOWdYTHNHTFVGRHRUckNWUFR5MW9uWm9KWnJl?=
 =?utf-8?B?V1lqekNZSG9paTgyVVk1Sm1yUkN2V01ONFpnb0YzaHVEUUlqS2pwaEZtNTVW?=
 =?utf-8?B?dTVuUTdad21DMk1waHdjREhlc2JER1JCMGFpWll5NlV1TERGa2o0cjFEcHc1?=
 =?utf-8?B?d1I2ZmdQVzRJNFJxeHQ2VUg5aGtiWFZnYmptc0dFUVFnSkZ3ZTZrODE0bUVa?=
 =?utf-8?B?Vnl2L01SSGN0U2dzNE1kRnI3SjdNUzhqd1VNSlRrazFYVzB6VkEyS2NITHpO?=
 =?utf-8?B?T0c1MEtxMVdLTElnM3M0YlRJQVBNQUE1a05PbmlwR0lrNHVqMFhDWXkxSnF3?=
 =?utf-8?B?cHJZbHBFSWZJaTYzVllHL0Z1c1FyTGM5MXNMaXZPbkxjT2xxNXk3V1lLTjJB?=
 =?utf-8?B?eTZUOW45R29kOTBoYmY0TkxabUY0VXEwVlllNXZyNXhBT2dsNUZNTVZNSnlZ?=
 =?utf-8?B?dGhGcGc5dGd5TjJVSG5lQ0psWUlHVGNXRVZodGw0L3JTcC9PdEljV0FUb2U1?=
 =?utf-8?B?SzFzbWI4eHJJeUszeFg2ZzNCU3VrZHE2QXJobGQrSnhpN3dia05PeG84OEth?=
 =?utf-8?B?SWd4YVQ5bU01T1p3V0NOUmVnV0VLU00wMGZtZlRBdTlZdFA5Qyt5cG10cVo1?=
 =?utf-8?B?dVUrZTV6VGtPcStjVXZ1eVQ3M3IzN3ZJTVpsSmVBVGhwVEFOcUphaUsyeVhx?=
 =?utf-8?B?WnFUSGNUVi9IRi9MRktuSHpqOG5FeHBmcmp2eUxTNmFVdlhEWmc5cGhyaWhI?=
 =?utf-8?B?SFBHaXQ2L2hnb0lnOWVaa2pNMnl4K2JLZDdGL0lGQkJPMi9Rc1RxdUh5MUh0?=
 =?utf-8?B?SmhkY2lrUG1qdXN4U2VGZkk2MzV0d2FuUzlxUVRQUkU2RTIwRmlGRU1ORCtr?=
 =?utf-8?B?VDhXUTNyS1BxSUhvUVl3bDRmQXRkQXBXWTdZNDZRTS9lVXdKVGN3NVNZY2NZ?=
 =?utf-8?B?VmVxWFBybUpqZDB2Y0llWS9UL2tRQnpDVnYxNWtwbVZhY1ROQ3RsTytFN0Rj?=
 =?utf-8?B?ZFppS0RXOWxYbW9vNmgyWEgyWWJGUDg5TTZ6WTZZeEJiMFhUaTRJZzI4S0tB?=
 =?utf-8?B?M082UEpTYU5IenErUUdhT2o1ODZORVJGM083aUNtZ2Y2K2VmalFUcUdydEp5?=
 =?utf-8?B?YmZ3U0VQRklYU2Q0RWJ5UDFJbW0xaHpFRXhTd1ZndW1YQzZiNm1BT3hZSnRP?=
 =?utf-8?B?V3FidWRjRlFhRGp2MEVmbUZJVEIwTFdTR3JoYkYwcVg4VmRkWnFwOUNUNzJx?=
 =?utf-8?B?bXpuYktoTHdqdkxRVXRrL05DblZ6SWJhNkwvRDVkdFhIT0YwQ21FaFBaSXZZ?=
 =?utf-8?B?YmhHQUZDTUNmZXJCK0U2ZTFCcDlGV3BWc3AyMmxpUWlvTnNVZEpNTHYwd3Rx?=
 =?utf-8?B?cXVIcEN3TWRQcEkzRjJicGZMbmJiUHRJd3UvSFV6WGhFYTg1eStNdTZhS2xz?=
 =?utf-8?Q?QL651fBFzlBlDnzPUnFxPSJpy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519e56e2-148c-4dd6-bb17-08dd91fa70cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:44:58.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wUwBartM04DZXDnMEV8FfYwLxjHRJcO6z5XYTac1kMVJnW8oXGJcIjJOVx+rU3v/HhmqlSxpDRg93K4+hOQbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

Hi Kan,

On 06-May-25 10:17 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The throttle support has been added in the generic code. Remove
> the driver-specific throttle support.
> 
> Besides the throttle, perf_event_overflow may return true because of
> event_limit. It already does an inatomic event disable. The pmu->stop
> is not required either.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Sandipan Das <sandipan.das@amd.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi
