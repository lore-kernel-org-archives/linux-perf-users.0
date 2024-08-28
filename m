Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022092.outbound.protection.outlook.com [52.101.43.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7C64A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821800; cv=fail; b=C+Gbv9bCBYL/UfhEE5BpSKTExBLcZk0Ayxn86VTVqsjN1Daakv/F4R1qG2+4A6D8lJj3R4ckdEl3UQ0azccDVew6/AafdEWSOpm1tKI+/XM1CLHRlxaxpHho+Ye45ayiypyOkSv8OaKS2neFUN8aAexMPkHhArgb5obDXOZtE0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821800; c=relaxed/simple;
	bh=fOtGtNIfviqc+tR0octYlWhz/Ce085hAZNdrGONbAII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajSZiQlp4DLhLXD5TPrMt65N/RI23xETHNJ5zbG6j9dfHdN4odWQNmT61R4pKcFgzaaWoAwnhPXp1KQTKjhkFZenQZIyQNYGYSQO9GdN7Nm4+GssKecCPt3G3Oioow8FA/yks9gBJVoxHIdcHLu7cJIQx7dFYk99JJEcfUUBzx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rJHIszSQ; arc=fail smtp.client-ip=52.101.43.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rJHIszSQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paanykcPn+0K3fiOIA3+g4hmVynyCu/oGNlUdRk+tU5v72Zf06AG2tGBW4Vc1KLaqellaKVGyj30ixUIR7dcGNsX0KQjS+hIC5RkoCyaGEexmWwjRxaodEkxm1uOgMESirW409HG6QXC63RfRfbp36ImmFuYZd/KwN3uoFRnHCBsxORYRjwkh1e6FwKSJkzlTOfIHHtj7koADOvCjuD25b9dC7lSl2TjL+knVx1Yyt1/xFQXA4PlHOXbOe6+2wY2CwJtDCikzmEqgKPj7qF6TL8j9GntsLWMRk71uF9dKozhOqW98SVK0eA3Tsc3v9l9PuaIYoyY1hxnaqtqvZy+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YigPosKCyA+QVqyfOxzq74WG+dtaoYHC96nYTYgVgG8=;
 b=CGPU7trQcp0sIfwDkEyvq0QdWcCvbHzAZxKBYDwLBgnzkJtne6VcwJezOO63tRfJDDn10W8xB1uaaKaQ9p9rJ9CTG1zu98w6cFo/tQhLukslixfKdS6WZav544Z7ZTegYvmfBjrv+tq2Q47LHoiUQ2RCGJQmvFTicqzjB4ibAPXxZeoSiprt1TMePBm4Lc2uYhwlF0/GAGEbHu8zdJD7HKBLw0DvSmqiPP+HhaluZq+jbBL2v3u/yHpBkm+25LfQX3wNClF14BCC/fOS34zrCsrhKVB9LIrstonm0UzQlbxccktIHEXifz/n13g4yWNYjYOlaYN8gA3KqMKnjBzxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YigPosKCyA+QVqyfOxzq74WG+dtaoYHC96nYTYgVgG8=;
 b=rJHIszSQVRGSFcHwSvMEmSPA14UuALXeNi2Yxr6aRqLtjDC2KALlCftqNfrKf+VPCGhlVolS9gjC/IzDMPI6G0tfXfizhf53GxxsnjsEFlQHAGguE70ntEMK910dhgxFdz7W3o1oW2B7+6bKfGgImER59v84PDzKFsae+2NBoTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA0PR01MB6506.prod.exchangelabs.com (2603:10b6:806:eb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 05:09:55 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 05:09:55 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 4/4] Adjust objdump start/end range per map pgoff parameter
Date: Tue, 27 Aug 2024 23:09:36 -0600
Message-Id: <4db11c591f56f4746b17fbd3468007cc89048881.1724820993.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::27) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SA0PR01MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e62a766-71a2-4848-fd65-08dcc71fa7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzJlMGJxVXFXa2ltb0pHL05nSVEyTHJJcnJhWVJQdzFqRlJVbmp4amFHbnVz?=
 =?utf-8?B?NkpCZ0dicW54RU5xSnpnRThDQlRLeDE0RWJYOTFVVG1rdW9OZ0VWS3p3Y0lZ?=
 =?utf-8?B?akpNeGsrOW1GamZONUF0N0NUNS8rbUJYenVJR0Z0eExnaWQ1eS8wTWJReUdV?=
 =?utf-8?B?QnpxTktMTlYrRlVSUFZhMVhiRFY4aWVRblhTQmY0WTFIVTNOZFg3eWdFNEg2?=
 =?utf-8?B?dXhucjlGMEF0RWo4QVNyTWR5a0NMdThUSUpYNHFYeEtPMjRGclVGQ2FGeXNK?=
 =?utf-8?B?TzlXaklBYS9OVnMzTnY3VjZTSkcrUnQzUWdJZWFLOURnelpacmZ0MkhkcEN0?=
 =?utf-8?B?aGVLWWh2UVdVWjJaeGszVzRkcVovekMvMmVhT3dmdHFJei9WY0xTaFc4ek9o?=
 =?utf-8?B?V3VYWWVOWnFyL3E0T1VuVDhqVjFRMUdVWWRJa0ptR1NSRDRoOXpSN2Z1Z1Ey?=
 =?utf-8?B?SmpnMkxibkkxejhvcFlBYThsY2JWTTRWM1FXMW5JaDRnYmkwT3NhN0FHTTNS?=
 =?utf-8?B?WkdBcEp6bUVhVS9adjREcXJ1STVOVVBMSWU3ZW00YkdZOXhrRGdHWXNXbGdB?=
 =?utf-8?B?NnAxSkthVHZyNm1vcVZBb2pSeDE4VVpONDk2UXBLRU1WMy93Uyt5cUVEaUo5?=
 =?utf-8?B?ejkwRXZaQzNhQjdVb3EwcHN1eVFHRzhiZnhjOTVsZU5HcVR1VERMbGhXNjZP?=
 =?utf-8?B?bFV3Z040TXpQb1FhcjhYU3R1UzhwZUZnNEU4VHBEQlVndnBZSXJQaGd2Ylp0?=
 =?utf-8?B?QmtFMHk5dnAzTUJmajhnNU9RNnpuSlhQRXdkaFBZOFVuKzkrMTE5Sk1ET1FY?=
 =?utf-8?B?WDZabER6QitIWUI4UkRDZlZwV3cxaHB3L214VWtYTnU3d3pwMUtKb0xuMk5I?=
 =?utf-8?B?ditjZUxZblVNRkZqMWh2TEdSUnBVamhmcnJ3SHd6cW5FZkk0QnFza3NXbXRO?=
 =?utf-8?B?L3k3Umx4NHp4S3NGNURHNHdTNUlRTEFFTDQ0TEZqZUsrSTB3V1A2ZUVnNk9E?=
 =?utf-8?B?SzhVWm9vdTh1blREcDNzS1ZkR0FmZkpOWFNiOW1yQVc5SWJQVEhyNDJMZzdy?=
 =?utf-8?B?VytiSkZhcGwvT3l1S2lxWTJ4eE0rcUhwQU5xUnNiRmRTMkUrdmxQRFMzY2lz?=
 =?utf-8?B?Y3FuWUw1NTlDYmRZdzkralpmZ1VuU0h1ZDJRK1l6WE1ES01JMFFEVmRMV1FV?=
 =?utf-8?B?MnNqcU0rSk84eWJvS2VvMFVLblFCUWk4RVR4anhzc0wzT0E4WUNvQVZ6TlMv?=
 =?utf-8?B?dVlFTldqZWM2OGc1aDhZak5kdjVhbi9QRkhtbUYzRGthQm8xNk55YkNFVjhG?=
 =?utf-8?B?WGhaSWtIamhqNzdpM0ZuOCt4Z09iODEzMGNNRjh0SE9UTnFiQnBkNjJtY1Fx?=
 =?utf-8?B?WTFvanNFUFliZk5yZFJ0NGF4MWxPbUVYTURlbmp6V05BdlVoYXk1QU1sWW9t?=
 =?utf-8?B?QTRHMmozc1VHcnkwajVRekdhM1VIc3pwQnR5UVdic3EvRzJpeDU0UnBTdWVj?=
 =?utf-8?B?VGJwVjZtT0g1M2FaT0FFZFJRVVhnWWJzeWUyenFvdjlDcEozb2FpVldmMFky?=
 =?utf-8?B?a3VaS3ZRbm5rbWt5bkRJR3gvOW5DTjVISTlFOUsvdGV2ZTZWY1ZFNll1WGVt?=
 =?utf-8?B?Y3I4Q3RXSWhaZWV3T2NXc3VkVFIxWGZkcXNXMXMwZTVFaXEwdE9wRXBUbXht?=
 =?utf-8?B?WXczZEJFbDNTU1daM2RSMHRiZkU3YUtTYnlpc0FwQSt0UEVNdk5Qbk9kRWJy?=
 =?utf-8?B?UndvNWdmdDZSR1hLOU4ranFsRnluSjRreEFVdTZRaXZNOGhtdnZHR3lNUHhB?=
 =?utf-8?B?cjlqd2lrSjVQWnZXUGRqL3NjK1FmNzZwUFAvWUk2S09SRHpPV215a0dZUm9y?=
 =?utf-8?B?TGdKYUE2QUVlNURtbUJrN0k3UnZLbzZ2VkJsNDBaS1NqMHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlNtQ3AvWDZucTNHbE5jaDdKai9nK2lGZzNtbTJvcWpoNWxZa0FBSk9oaEU0?=
 =?utf-8?B?NGpndGxXaXVoZVRhMGVUMm5jUDVrbDY3YXFnSXlqcWZOaWVLekZ5SnMwMlRH?=
 =?utf-8?B?SXFVM1M1dmRhb1NJZXRqVmRvU3FCNFI0OGN0N3d2ZnkxRW1sSEtEZ0RlVk96?=
 =?utf-8?B?R3NWNm9VMGtjb0kxYjNOdGU5NDNpYjlvOGFwTWJVS0NmRWpFRnU5RU9XcXg0?=
 =?utf-8?B?cW0vaWZySnRHUWNFOUFPVGQvZGI2ZG9DK3Q4RTB4R0o0ZUJtNnRPVmUxc1Qz?=
 =?utf-8?B?SStZaWdIdkRtTkpRNVZhNE9IVzE0cmMxdk9hc3dRczZuREt5cE9EZEgydko5?=
 =?utf-8?B?NGxRbjBRb0RLQVdIMDBPdlZORzNpL2RLMW5KTllsRURKU3V1bFh3cWpER2ky?=
 =?utf-8?B?VElGaVc5ZW12Z0dKOWFHNDlFRjA3UlE4T1pqekJCcW5ueUNHN2ZENFcwZjVz?=
 =?utf-8?B?OXlrNmIyV2dpTk9aMUpjMk04aHlWV3lDK2tSVmtlMlRwUWpTeU9GRSt5UUI0?=
 =?utf-8?B?LzBIQzcyY09nL21FTlhHRnRxdW9QcENKSnZWODVmYndFa2RJdkdNMFArb3Np?=
 =?utf-8?B?R3J2R291cGx6L0J4TUNyZlkwb3hhK2g4bzhSZHFuRDMyemV2b3V0MGpnMXB6?=
 =?utf-8?B?dTlxZXBkUGFBeGJXMkltdUxZL1JRcjB0Y1V5Y2trM3NaMlB0WXVRK05SWDR3?=
 =?utf-8?B?VEUzcnhsSmNHMFB6OVVoZ0RPT2pjNVp2SDF1T1pPTXNmcjVUcU8zbG5KZ1dC?=
 =?utf-8?B?bXN1cm4rMEtVVFpZV284QWE4MzZBMUJCSWFiQ1NZYllDUzdyaExXSXZDeUhq?=
 =?utf-8?B?N2dUMlE2dDJtenpnK3dReEdNdDZkZWtKMjJKUG1LcTVvRmYzNXpjbjNDZEhm?=
 =?utf-8?B?N1k4S1JNWDZXQTRkMFByRUxnZDVYaUNxMjVWQWpQUUxYZ1RHdm1UcG5kZEV1?=
 =?utf-8?B?RmY4KzNhOUN5amp6ZktLSFNLY2l0SXlaU3V1Q1lCQ0I3ZE8yWDRVK083aTJv?=
 =?utf-8?B?U1ZzT1YyVVRVVkRqVmdHM1M5blVobnJIKzIybmxYZ0xNWk1LL0hCVmMzcENs?=
 =?utf-8?B?S1RMWXBDRVlwM2V3b05EN3IwSnEyQWdOcnhSRUl2OTAwbUJETlRpcllwQ1Nl?=
 =?utf-8?B?UHlLanNLU2JyZDhxWW4xUE5JOUVDZ3luKzhMeFdiNHNSd3d4dVBnWlk5THFR?=
 =?utf-8?B?VTJGQm5tQ2liNndEL2JJYWc1dUN5Q1Y3cEdjOWtjNFFycmpGY0Q5bVJRMWxy?=
 =?utf-8?B?aEVhYmpYcWF2U0luSHZ1NTNwRmNkUG1LTVUveHBIVXhIYmYyTzZtVklNMktN?=
 =?utf-8?B?UGFseFN4UEFNcGJsc0dQQWY1RTVvRGIxSHNwYlBXcURFVGpCb0hOMGhKOXJa?=
 =?utf-8?B?RmVpZUprejN3Y2hMOVY0emJXNXRaVmVXODA5L0lTVFpZZHh4WklYTjhaYzM1?=
 =?utf-8?B?MjE2VmJJRWVuQWJrUVZndEdUNWZESkdDQjhzblAycG82SUhjdnVkOWw2b1ZP?=
 =?utf-8?B?THJxc2NlQmRTSXVuWFVaWUdTM1htUTZJZFQvVloyK3VrU2JoRGZZcENVcEVm?=
 =?utf-8?B?WmxPeTNET29HUmdrV2ljeGJaQzdGTDFMZzNPSHBpUzF3azI1RkpHRlZuTU91?=
 =?utf-8?B?UXorUmxXL0QxamhWM0h1cUJ3emlqelV6UkhCcVd3dHcyekp1L29MUjV2Vmk2?=
 =?utf-8?B?NVdrZ1g0d0JDM1E4RTBEV0trMVFuMTJYMVpFN0txT1FMTWdHZU4rSjhPUHpN?=
 =?utf-8?B?dXh6UnNzRVhMVTFSalQrK3dEdm1pNWh0TFJSVVZIUlV3NTArdTRkeHl2eVk1?=
 =?utf-8?B?VHVpVTIzVmNFYm9wLzdNL0hteWN5bDg5RzNya2JzdFJuOTVzUkhlNU0vZStC?=
 =?utf-8?B?Y1dmVFNLOUxTdDJpVU1WYmFtUjVDbEJMSEk5SlJEWUk4QWhwd2s5K3lXeERC?=
 =?utf-8?B?TFVYVkdvYThiUHlkcGsrWk4zRU9hdmFybmtOcW5YYmJWejhTWmZRMEdDWE9y?=
 =?utf-8?B?NjlUakNpS2Z6OWgrY2I2RlR3MFZnSWlZWjdpL29FQTRGeElSTVpaU2tEcngz?=
 =?utf-8?B?amxvWUVEeCtyOXVHWFg5aG90YkFyS01obUp2em9JbWhqRnBZc3BPS2xpNHp4?=
 =?utf-8?B?aml2dDFHR0VCVmFHK0xicTlOT0RuZWhLWm1rZjNoUFlZYmdVTVR1aGhwUGZW?=
 =?utf-8?Q?/JFn60d4iHTZhDaHINLpyoq8BnCg1w/hSBtxYdpeMxYT?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e62a766-71a2-4848-fd65-08dcc71fa7c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:09:55.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezxBxmp8cWtJGbZ0jHAX2NV4li9u+cPJ0mYtFeQpVEHU7obgLJr5FMDiYUioRfIHLQzHq1TDfF9629Y+P598inuYKID3zlxz5A1GXH4JAxzaWki374+1argoFpqyHZuH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6506

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
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..e8cf5d80d850 100755
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
@@ -267,7 +270,7 @@ def process_event(param_dict):
 
 		dso_fname = get_dso_file_path(dso, dso_bid)
 		if path.exists(dso_fname):
-			print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
+			print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
 		else:
 			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
 
-- 
2.25.1

