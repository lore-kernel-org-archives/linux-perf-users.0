Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022080.outbound.protection.outlook.com [52.101.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE813A244;
	Sun, 23 Mar 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742755163; cv=fail; b=Jbhg49GYzJxt5XqYA2SrG5doAX25II07xHm3u4i/onFa0i3NY33Evoc1KG9k2qUAXGMbmjZvUpjf6aqPfJcQEFp+Nb9bOL5tse4maP2ODIplVi/JU9oT0jmXM063UZaaUA0LFUXB3Ig0Zg68sVeeRrLKix1VA2W51iD+X3M7gr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742755163; c=relaxed/simple;
	bh=xMIP2k7jeVEy8DA0AUzB4aPUXrrkwi7PBLTbJHQ443w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EvZhr3ninoV5kjUPdxPboFndqV1Td1kF2gAVI5iIDHC9ZIpqm3MSsWv+hwMDcYp4FFspRrmEdM9Ovef8e72cbWMsu1PJrBkpFowcJX/MyAMpDUJbKZl1EfdY2+d779r95odl0uppwiyrxLRO0Wz2IpWZRwq6y1wrD9vyre14dvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zO4PWWJH+wNOHvv71/5aEUabM22nsxd5XLDCbcVoYJ3tqtiTloJgmhN9DqlkyNNm5WgFgms8QtOtUNdTyFifEtQTEaVV/6NfcfyoIjaoW/8oFLGiQmwvlqvR/ewPIhuGb3sKefRjULES35MvQapfkF3eQS7JnUg1qaAnsUUOcn9g4yHFhIljcUayxiCIhe1GFeZVEKztRXWLSrsr6BdbzKNuc0fDR8OtpBui0kmPnmRWwuaECn2rb+wQQd+T9/XiQeIDJwGsae+9Xi141g3ufAiNHACGUQfOPynTNvsJKpErThRPv5TFAO1cVRpYuPnac5WRdJYcXShP1VBxCYlmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUyzx6BfXUOoGb+mSA0FCk4LRf+nScYL+F0kcEPUebU=;
 b=uqJDFDD7SFwsJqjnTWwWMfqAnJ0Hhg16qkDIIEE+/aslq1z8y2D6/n2gC8uaTRAjBlW6ZXXihgLsHiWU/3LRjE9bjW2Qtxy7HwiY+DFL2bVzbsNGYdixF7J0+5VrSSWCtqcX1ayOV0m7v6bItb0i/dLr4ayrIX2L6Zc3f1P2sbv3v4oqt2Xhsrv+3N4YRbywaOGc/M1Ba+lgdh8Yt77vreOI7YEqcqGPKW2Nn8T0hTubM0mA+H1rdN5N8HE2F5JODXp34x2jVnh5V+kfKl32zdTWHi4SniDcaU9zouvPZX6u6AntNZaRqnaVKovfAQap7T7gKBEdNbKwi/xuffXk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6861.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 18:39:18 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%3]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 18:39:18 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: namhyung@kernel.org
Cc: arnaldo.melo@gmail.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] perf probe: Extend the quiet option
Date: Sun, 23 Mar 2025 18:39:16 +0000
Message-ID: <20250323183917.230567-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <Z5PP3vPpYOccGWIv@google.com>
References: <Z5PP3vPpYOccGWIv@google.com>
Reply-To: Z5PP3vPpYOccGWIv@google.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::12) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ce9b25-d29d-4224-8aab-08dd6a3a0541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2NvelRTSDRnU3gvQjVKZFJ4b05SdE1IS2NMMDZIMkY0SWtxZzcwVFFXcFor?=
 =?utf-8?B?azNTYWxack8vcnh5ekNXL0Z3WTVWZkRnL3ZYM25mT0lQbkhFQ0NTbVpZRFM1?=
 =?utf-8?B?dSs4ZENxcFppbmQwUVJMbm9HM3lXQUh5NXpoUnZkZHJZWDcxcTFBRm84b1Bv?=
 =?utf-8?B?d0hQMEdKdEpOVnJFcE5kc283SEJpaDZSN2FxMCtvbDZHbS83ZHpwK0J4Y2cy?=
 =?utf-8?B?U25haEF5Y2tVSmJvWnE2ckNHMVdDVWVmV1c2anBhUktPYmtxYmR5emhOZFZG?=
 =?utf-8?B?R3oza3JTUEE0WnU3TjczT2owZ2NncEdDRWVDYlB6VDA3czhwQzZOQkY1blJJ?=
 =?utf-8?B?aDRZWUx4a1RvRk0yTTBnTnNhQ1pEVTlRSW1VbE9YejRBcUM5ajljS2VxSXR2?=
 =?utf-8?B?dVdVVGVSMElVT3hORUpMNWNHNE9TRjA1ZGF2YTQxaFNGdXN2S3l1WG82OS9Z?=
 =?utf-8?B?Yng5ejdYdXR6V2cyNTkyelJneWlkWFB6Q0MzeS9obW1TcnBSM0ZjQ1hBNHp0?=
 =?utf-8?B?eWJiaE9IS08vamN5SnVQV0EvMXZLV1JUOWxsU20zRW9JNTk5UnlJK241WDhq?=
 =?utf-8?B?L3RIblMrQ2dnNFVrMWN2MlRFckFRdlFxNlFqUTRaSW9rbWJOSTB4VllQT0Ix?=
 =?utf-8?B?bmN6TjdoQWNTYUpyUGZkTjJWaWV5N2lCWlAwVkI4M01POHhDY21ZV3BnMVFL?=
 =?utf-8?B?aU1rSDkrL1VzUWxtVG0xSzl3VWNrS0c3bTU3WGowNzQyVFl6eEtQRWI0aU8w?=
 =?utf-8?B?VCtyV2hqVm9TazNxK0hLc3BBcGNiSjJsaTUwZnZvb2RTYkloNHBrVjk0ZC9k?=
 =?utf-8?B?NGxMT2RWcE85aDU0MVg5akVQQ1lML2F0SERGNDVnSVErUHhsaHl0Q1l6Nmsr?=
 =?utf-8?B?Y3pKWFNIY1Z1angrK1JVQVk1dTFhZkx6OVNkeHRWZS9HamQ0aU5YUy8rWnYv?=
 =?utf-8?B?UVF3MXl4a2NvYzV4YkRDcU9FVzRmYjJUTkUxbDdSNkVzelRWQTZlM1Fzazln?=
 =?utf-8?B?aHVGNTVybW5sMkIzZmNSclYwYWlGMVZieW5OZjQ3RzNpZG96RVdERmZWVkRD?=
 =?utf-8?B?c3grdXRGQTJnaUtzNGZtRVBwU0VoQmhBZ1lFbGlUMlg1Rko2M0w2WkYrUTVk?=
 =?utf-8?B?UXFGR05FSUVLWFBhQkVjTUtmWjA1M1ZBSkFnT01xVlRieHJLR3dQa3pRRGho?=
 =?utf-8?B?UmpkMGpSOWlMaVVjc1Rxa3FNdzFlelFDVVptM0cveXM3Nkswb1pwZG9PMzBD?=
 =?utf-8?B?eHlRcnNEQ2tjS1Jsa3BaclNMRnRtbHB5Qk5HWFVxb0VmM3UxRHZrei9KY0Ur?=
 =?utf-8?B?citBN20xRkxISFN5TGRDUE11TGY5TExiLzduS3VYMWE1dm9yYXJwbzk2eEk2?=
 =?utf-8?B?SWwzRFpqcGFvTWpvYzQrZGQ5Q2JaV2tYampmekNEYzZZMHpRU3ZscGR3RTFl?=
 =?utf-8?B?QXBtVUt1Z2lVbGxwRWpPeHJHQTRBOWZoM0RndjRNU3RVTFZ0cVZGaUxOSyt2?=
 =?utf-8?B?T2FIelNIRU5aQVZhYVNkSzE3Z0ZaL3FqQVJsQUZvZ1lYZmNDMWpTSHBWdkd6?=
 =?utf-8?B?b0V1TUJNUGtGK2VNNUQ4elBmRHV2eXlMZHZDbm04aG1oUjZGY3dXWitKU2FL?=
 =?utf-8?B?SEZYSjl0UDlzSG9KSlFJSzFwT1BJdnc5VS9Dd0JMQko2UXZGN3ZBbXNWaXlJ?=
 =?utf-8?B?TmJuVWZTSDZ4MVlpQ3hDaFZQWVB6Y0s0K251RmFJcXRodWl4WHJZQ2xSNnBH?=
 =?utf-8?B?a09Iazl2MFdFVFNBdmJGekZYWnhnUTBnTVBUbmpYRVdlQjV6RlRsb29iVjhY?=
 =?utf-8?B?MXoyNEFnanVrZkZRSnlOMjVqOFl2TmR2Vk5sMk04aWs4eDFQNjIzMWhTVU4y?=
 =?utf-8?Q?lT9YaoVMhavFQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzlIcHNPbmt0czc1UjM1TlZxTUFKSld1aG9qNllTOGxiQmsydzBkanpUOGFq?=
 =?utf-8?B?NjFzNmQrMXJvbnNWT1ZWL0JjZ24xOHVMTU1CTE5Jb2d4Skx3b3Bxc01vYlJk?=
 =?utf-8?B?RS83Rk9sMjBDRGZDSElEZE1pTnNFekZnM0VXSG9DMGpwc2JXWk9xTlYwK0Rt?=
 =?utf-8?B?cWg5YVUzWW56aC80ZFJwM2ZSV3NlVUtJbkcxbmRWQ0NmUzFXSnZERDlvTGl4?=
 =?utf-8?B?S1Z6cnZrTysvSVNnUi9SdEhSeWd0aHdlTytFdWFHbVhWUnF1QVQrQi95SFhZ?=
 =?utf-8?B?NVNCNk1pNk9pZmVHcjJJeW5yZ3U2bVlFWXUvditSRi9TTERJZ1Y1cDAwbVQ2?=
 =?utf-8?B?MnpLU0dlTEJFMER5ZjJWSVRGeERGa2QrOE1sR3hJclZsVmU4a2I3Rnlxc2h4?=
 =?utf-8?B?ZHVVZE01bnIyeEhWYzM4MzVyUkZmaVd5Uk4rNmpzQjFVbzEvK2paWjNvMTd0?=
 =?utf-8?B?eGNwM1FpNnljN2NzSS9TdUlxWTFZMHA0TXNIbHhyOE1vTGJNTmhld2RDMTlM?=
 =?utf-8?B?Wm5LQ00ycDJOZ0VpTjg5MklWc0RQaFg5Vk5pYkdyTEhTSGQyeXprY3Y4KzRR?=
 =?utf-8?B?OTM4NVpBTGliaUhDTmRyNHJTbXVYaGZweExrWmJXTmUwaFBSaEF0MExBT1lo?=
 =?utf-8?B?VTgrR0hkdkM4bVBPN09BalZ6ZFNHMmo3ZkJTRTZZbDhQV28vdUlsTXdpRHdQ?=
 =?utf-8?B?NUFIM0hSQ2F2b1Q0V1ROMGZ3cnVwdDJnTHYxR2l2TXcwQnhEYklHeU9HdHlH?=
 =?utf-8?B?YWtqVUR4SjdFbkxDbW55NUI5RjQ5RFFaZmp0eUJCZ2RMQkYyYlRmSE1oZ0Nl?=
 =?utf-8?B?aElEcTlGb2JENDJybEF4bDZUenE0elpLSkFzUGpuU2ZjbGNMaWdWZllSdE8r?=
 =?utf-8?B?TW9OaVZrWElHZ1prYTRCZytSWHZXV2ptVkVPeGRkRnEvL2hDb1dqcWY2US9Y?=
 =?utf-8?B?UXVGSkMxT21KNllwTEx2MlRwYlVad0x3OVl0VnB5OUNjd0ZHWW1TZHFIekNn?=
 =?utf-8?B?SU9GVTVjTU1XcFVyaTNkbzVnd1lWVFBLeG1tQkh4Y1VVcXdxN1FCY2c4bVVH?=
 =?utf-8?B?TG8wTG13Tk10Q0hRYmJrVjEvcTF2b0k1bUFqSHA1RG90WDlTRjZDMDNLaUtw?=
 =?utf-8?B?Q0dtR3ZmMHJqWFFKdzBUalVkUkhDWUtOSFJaaXFIQ0FXbWtEcDJ5a0lqbGZZ?=
 =?utf-8?B?dmNmSGJUcjRDQnFGT2h3L0Q4NU85L2RpdituTzNtZGtOUXRFbzdZTzNiTGZD?=
 =?utf-8?B?UUNST1cya201RzU2VWxrbFB4UnBVQXRuTVFOaVFDanhSRXJMaldtU1czSlRP?=
 =?utf-8?B?TGpBVE9mWGl6NGJicWNrSS9hRlZBOW1ZRGtQQ1JlaGxpU1ppRkRYOHhNS0wv?=
 =?utf-8?B?Vit6Sk1zeFhSZ0ZQck52azhSY2dNSEtBUmVIOUFTR0g5b3lBK0dnbHZTT1U5?=
 =?utf-8?B?RytLVm9aU1M2ZTZ2T0gxWmhzNWJsbk5YMkROUmtnemZPL2x2M0gxMmZka21U?=
 =?utf-8?B?c21wbHExNEU5Wjllay9vQnBrV0p4aGxPNTZMbU5rVFBDSkpYWCtOb2FESDl0?=
 =?utf-8?B?dUdWUGd3YmRrVE8xaWJYL05CRDlEWGZaUWFxT2s4ZDZadVpkM2dsVS9IRXUr?=
 =?utf-8?B?bktZYzdWMmkwTlYzeTJEb0lZc2U4VGtrMTlOZnptOG5oM3pJZDdkbHZvV1k4?=
 =?utf-8?B?b1lHRjlJcmhXc3BuMkFNU0UzOWdjZ3JkejJiWCtkVW1iUytwTTFQNE9UQStt?=
 =?utf-8?B?N2paTFAwZVNPc05hTTd0OHJ3UDd5alZFRWprSzJkSWRaeDBNc3FWVDdJTURG?=
 =?utf-8?B?NlVIR2NMd3NGSkRKN09UUzE2dk1ma0huV2tvOE4vODNUcGxTZU1sY2ZESzR2?=
 =?utf-8?B?UlIveFlVQTFtbExvU1BHK2lOb0dpN2VyZk5TQUVQYXFtb0lyOTFqNDRxaUFM?=
 =?utf-8?B?Y3BoR094Y210bE12OUxldkN3c2U5MEl1UVcrZUx4TEJFMzY0OWxLRi9pbTZC?=
 =?utf-8?B?dFBpekxmQzVRNGNlbUM2MVJ4dTR6bTJTcmRrVXhKYjdNVysxM3NzZDl2WEth?=
 =?utf-8?B?cUhsUmtVRUVrZU1MOVRZKzhGc0RiTkVBZmJYN2ZPYjhhSDkrTVJ0QlptaHpX?=
 =?utf-8?Q?Nv2vrRoyAmQd0uF5srBB8eey2?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ce9b25-d29d-4224-8aab-08dd6a3a0541
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 18:39:18.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJaiT2Ze0SUXO3ZsyXid0eUXiOkzWSFJBBOYZL+w7Vk8NVLUWJp9j46FfTupZyOXVqN9iiPovsd6j9C7Om7KTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6861

Hi Namhyung,

Apologies for the delay. I suspect this is the idea you had in mind?

Aaron Tomlin (1):
  perf probe: Extend the quiet option

 tools/perf/builtin-probe.c    | 16 +++++++++++-----
 tools/perf/util/probe-event.h |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.47.1

