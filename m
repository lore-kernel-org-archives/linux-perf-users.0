Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022110.outbound.protection.outlook.com [52.101.96.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEF1E48A;
	Sat, 25 Jan 2025 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737808297; cv=fail; b=g4CfjFvi0SL1h9v9HD9CthACLW52N/mOu8qvfqCng+NViVAmmiOCQqoNwBlEggOPs+pQmfjxKEn2ijdcx/zqtnPkJFAxoTcDZ0giNeyfkP8Dy7mOwNjN49qrIV5ZWaNIf435W5AtBa4OUfG6HjOGTYYuBDaJ+4bvvuqJoeo2KY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737808297; c=relaxed/simple;
	bh=RFR+8cySRi1rzeSxmtKpvZzAQ5cq03oPQNW06ntnlnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YCs5eSAU3nhzuUKVKNwji8d3jlsKSVFHfoggYrxyweQXJUOzvQSlKz8VFeHxuKYp2lXIB9idyH2fXbNPGwLWvV4CDPVb+U4e1EcbNqCm6B/xhBpXjDGgMTPpte4joyXqFqSllo5FV+SNTgcvXNe12KUc4Nl7DcmzBunSXvYlSVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv5lbHrRHnNuWeB8IjHo99oMivpWq/72lHmzhOZ4fqZOGF552MM1ioPOImf1VljewkIyxKe+KqFXElmoT4VG7GLPufvsKEW0heTdtoL0h4Cbe1hJY1EbOpX1a2dEGhmZiSi7SXz/FMB+sR+v4E8ZZ0KklE9nKjLQCHMjS/mHCyNr4xhD1Y4jaJQLVHEzxFfSZviUQOKJCwhhBP7xlWioakVGV2wuTovZB4II+VkLpGaWmYFzk/I1Wm1208ae56mvCC3VXamnGAKSDIxf2sDIScc+n8Bx0KxjD4ymIJooq3GZJ4qz7t5W54VjCvCH+WB4ax2pQtGltMPv7e3ylhyFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7l2OmCFYuV8vDuoxzQBjR+WfD1VCZb2b5ZUFMaJEPtU=;
 b=Yz/34YjUrdDh60kzsuM7fcWf+SC35k9of+FMEMoMvGzIpjlfIzfToGVMEEU3m6OQ5LqePVPdApqVyA9HKoex4kZzegwknk8buH/E9ZGZv2VgIsnAMNjHXh8hZ3D/LQcyBmaZAsEK5i6852buE+KNJpI0tUV5v8OPtYcMvPehJGgQrHMHqrL+m6Crfb5GVLmbLlDpvbFEZQhxRVSdn1mATsqJUk0IR0lfbGaFV3DSgaBFtIyLbBOhAU7mCxtwLFA/uq4Ztyy+bK4V9jGxm5d3L7H4o77G2nzasCqJaZpdmQTZzC5qNxUOemEt7vg2W4nNjIVlTYPK8GF6SxQdnMgmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB7007.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:335::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sat, 25 Jan
 2025 12:31:33 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%7]) with mapi id 15.20.8377.021; Sat, 25 Jan 2025
 12:31:33 +0000
Date: Sat, 25 Jan 2025 12:31:32 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf probe: Introduce --no-advice option when a new
 event is created
Message-ID: <irb42emsc7gduedasmfzwlb5rjw73iachywemetbsvgraquc7w@4y6spp7zhwrb>
References: <20241214193452.16627-1-atomlin@atomlin.com>
 <Z5Ld5irdG--_Efgl@google.com>
 <oqon532hz5nktpgilvpmvd5ywuasppbkfw2f6z5gjluyzo62ow@n7ynrou6uykm>
 <CA+JHD92anFo9rNOZ8NVyY4j23ukyWO-LRroHfUTnuOLnL-05-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+JHD92anFo9rNOZ8NVyY4j23ukyWO-LRroHfUTnuOLnL-05-g@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0355.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::31) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df142d1-1e41-40da-411b-08dd3d3c33c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHczcTQ4NEVmcEpWcTduanUvaVR4SW8yVk1KTHkybHRMQXUwbXcyQmI0V0VM?=
 =?utf-8?B?MzF0c25XNkROTmFvWmFFVUc2Q1RqdmVSM051eGM3S1BBd3ZFUDNlVHVxcHhv?=
 =?utf-8?B?NjM2cjd0ZmxzZkRwQkxma3VvdjVsQ2ZpaVdjN1FuYXFrbUIrbjZRckdNcTB4?=
 =?utf-8?B?KzlrYkdTWURnTTEzc01BMHA1VjBXT1k2cmpaczA5QWgwNGdCNWhCSkUvNk1p?=
 =?utf-8?B?VzI4bUhUR09rM1U5YnJIaFY2eS9rRlhBbFhrdzA5ZzBmdmVIaTNQeDlTYkhu?=
 =?utf-8?B?V1J2WHhwbnJOYVY3SWpsVDdBM0NQVExDOXJQK1l3TWVYZzU0VGI3ZTFPYzZT?=
 =?utf-8?B?d3Y0Z0IzZXZjUjdieDJpSFczTWZjTnArM3NNM1BDbVV1TExlcVpuRzB4M0Zo?=
 =?utf-8?B?YTlqRW9hdzVoNlppanV3NUhWeU5pYjlaVmNsVkIrSlg1ajFYTncyb04xTS93?=
 =?utf-8?B?aWVCYXZEUHhOdlIrR2dGc3VFZHJLVzdVVm9zbUdZWm1ZQlRPWUx5L0w3RXZq?=
 =?utf-8?B?Y0NhMTlCeFc4SmJaaWlJdkJkSXFFWTVLbkhJZnZzWlJGcm9PaU9xZUxtZDNs?=
 =?utf-8?B?NGxudml6NjBuMzJrajVHYmQ5NHI0Sk9yNGVjRXRsOWVmRmNrMU5PM1h4Zk1J?=
 =?utf-8?B?MDZ3WldVY2lIVVJBWENzclRBdVQxZlovTnlYVEt6KzdhdGMwTWxLWStNRE55?=
 =?utf-8?B?aXp4bkdLSmtXNkdNVFovZ3Z3SkhTbGNlZjJUamxNSHRwQUNLZmwwWk8xYW5i?=
 =?utf-8?B?ckRycHI5WEs1QnExZS9wSEwvb3kyQkxXRkN2cW1EclpZSmZ5Tm9wRkJVdzl4?=
 =?utf-8?B?blFWOEVVSC9tUXphZk9aUHNnMFROc0IxNysxTE1vZzV6Y1VINk1OS2tGdk5R?=
 =?utf-8?B?OWZLZzBkaWxhNklaU0pjcjlPUjJRSGRhVW9zYW8vcC9LeGQxOElpSDlseGps?=
 =?utf-8?B?Yjl1YTQ2ZklTV2k3dDNUdENFTThlVVJYTUNScThiOG5ua0lEazVLNGhMQmFH?=
 =?utf-8?B?bTVEWDdWKzdsMkMyMDUvc3VpN0ZLczlvaDlYVDRQQ0xYMi8yMm1SVTNNWE5r?=
 =?utf-8?B?UExxRVdpaHBFaHdrK1VsRCs3MEg2a0xNN2MxTzNuclVOemlSbmxnbEdvV0Vn?=
 =?utf-8?B?TlI3V3JFdVhFRWtEN0o5TG9QVEVhR0pmS0Q2S2x2R21qdVVXeTZMZDhEdFZp?=
 =?utf-8?B?d244dFFsM2hsaHRRbkJSclM0cEhHTVBMbVZaaUFsdmtsMDBybDVldUpvUVd5?=
 =?utf-8?B?TTRiTVJzZElRYS84ZE05b0VQSEtITm1pZ0t4VDBWejJqNjNMdUI2bmw5QnRZ?=
 =?utf-8?B?TStKWStiWGd3K1BxNE9kdDExblo0MVRkbkhGeTg1WUlXbS9XdWNpcFE0aVR0?=
 =?utf-8?B?Qkp2YkNWek1ZditJRDdmdHRBcWZyNitJQktGUWpOOXI0OTlzUEFYVFRDd1Nm?=
 =?utf-8?B?Vk9xbWtKcmwxNTFJWmxJUVc3bTk4MUZzV2Z3QURLS1hGeHV4SHUzOUVhdnpB?=
 =?utf-8?B?VkZSWDMxVEpTTm13TE5VeXBTT1JMQ1phY1NJM1g2OEY5UXZsSCtHZlZLZklC?=
 =?utf-8?B?YS9JOEVoMXdpNWJpRWUyUzloQjNNcnZIZXordW9IRERrL3FzR2R4R2ZTbkcr?=
 =?utf-8?B?SkY3eUhLTTVoR2R6K01idkgzdm9xcjFRUjZoN3dtZ3lXRnR4L2QyU3dWcFNq?=
 =?utf-8?B?aXFnTDY1OXB4N0pneDI2SzhzL2pTS1dzcWlDT0ZWVW5ZZjhUWVpUd3dTQy9B?=
 =?utf-8?Q?2n0C2kd84yoLw5U2LePuyRtGF7m4kf+GHUhnP7d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlFIVCtHTlJtME54NFkxWkorN2YwdWlnQ05FVFYyNm4za09HbE5GYllpRFMy?=
 =?utf-8?B?Ym1kSWFVb1BYQkJLVm51WVV3TnJ0YkdkczZvS1RRVU9jb3VXbWs0YmZKV2Rr?=
 =?utf-8?B?Q2ZtbGhqT0V6MXJPMDdlalE3N1FvUFVuS0dERW9CYUlRM1NURTRNdkJSTDFx?=
 =?utf-8?B?THArY0FTM2RyaFJXMzhWa0ZNWW40MWNRZGpsYXMrTmZyNEpBTXRjcWd5dWk3?=
 =?utf-8?B?ZVBBUlVoK1VZZ3VKb2Q1dGNNQjRKU092Y3pzaSt4V0U5VTF0eW92aFlaSnRy?=
 =?utf-8?B?ZHZRaDN2L2ppUkZNekVyUDRONStYc1ZtYXYyb1BEY0tyMm5JR3RQcnEvR25x?=
 =?utf-8?B?WFJRNlcxdW5mQzF1WjZnanZ5eUpDbTFVSzBOVnB5VjhpWnQxMlcxdDZjNHRX?=
 =?utf-8?B?eDdFSldkY1Z3R0YzMDJ1aTVBQkZySlNkNEk2c3BZU29WMzFkdXp0UjhWTnJ6?=
 =?utf-8?B?U2Z4RDFUS05ieEFxdDV3ZU11OWZLWlM0Y1VwdVUzeFNFaEkvTkF4THlPREVV?=
 =?utf-8?B?MGduZDg3ZGd1dXlWMGN5ejNEbnF2aHFlUlpBUEZzMXlCU2x4bmlpSXUxVUJu?=
 =?utf-8?B?QU85TFNtS3BqSyt0ak1IU0dJWFhkM1g1b3dGM1Fwb3EvSUV2UG4wQzNmam82?=
 =?utf-8?B?R0ZrYXNMUE0xS0Mvc0VuSkluRFcybFA3eWl3R3cyOFV0ZmR3UzdieVZTS011?=
 =?utf-8?B?azlvV1g2emNOdExiTFFPcy9YN3JLZ0JaQ0hZek9Oa0JmazZ1eGVLWnVoNTQw?=
 =?utf-8?B?ZG9EMUt0MlV5a2swR0tSZDZKZmlnQk9MdStUK2trc2VkdndkeGhsSEJobGZO?=
 =?utf-8?B?cFIvL2tNZFB3cWU4cXZKbi9HUUNZUmlnNlpoSVBDT25WMi8vSS9ITmRPNzA0?=
 =?utf-8?B?MEN1N09YVWZ1eHdZVUFiL0UwVVg1MCtUQ01rTXlUSkNHUG9LUzlQYmtMcXFl?=
 =?utf-8?B?S0J0Yzk1NVptRzJrbDR0VERuVjNsdHlic0FQTzlRMnZNOVl4aUtsKzRwaEI3?=
 =?utf-8?B?djJtdUMxZnU0K0NnVnpFZmt4MHJWdklpTVEwOFhid3ZycHlHSnZZeXd4UGRV?=
 =?utf-8?B?aXk3aTk4clNWSStPUUEwUEwyZ0puZWdieFBHajJpd2tzazZPazhuMWNsSTZh?=
 =?utf-8?B?V0VnbDhweVpIRVZFa2MxNGNVSTlhMG1ENXlBeDQ4NktZTGZHa3UyL0J4U01n?=
 =?utf-8?B?YzE4bnR3Mm1vdUJWcURCaS9oV3ZsMWlSSm9WdVVoZTkrekdIbzRxNFMyTmtp?=
 =?utf-8?B?OUhmeHNhL3RwRGJ3V29RSFlsdjFENDgvZEVUZ3oxRTR1ZXo1SDBHVlFFQzh1?=
 =?utf-8?B?TWI1YytWSXU0aitreUVhKzROV2wrcGZPUVJhWnlMNmZyT0lRSk9JREZMWnVa?=
 =?utf-8?B?UTdBcm13ZnpJWjJ1dkhYa0cvbkNkcHQ3QzhUWkZjT0QzVmR2RmhsaHM2Q3Fp?=
 =?utf-8?B?SS9KY2NIdzRrUHVXRE1keDNIT0w1bktqMktoSXlkelp1ajdkSzlVNjdmM1ZH?=
 =?utf-8?B?SEJZcVJWNDRMcTNwcFlPMVE4MHZ6THJtblB4Z1NycGpaVXVMejd1dDBJTXVh?=
 =?utf-8?B?UERidStQY3orS0U1S3QvTHdZOTRlaUtvVDdoWWpiaHA3OEpwc3VqZ3lFZVgv?=
 =?utf-8?B?bEQ3KzBKdFM4Smg4MUJZRHNGdmdQZGJEaFU5c2lwcVVmWWEzcE8rZnVqM0JP?=
 =?utf-8?B?eDVOTlViaSs2Q3BWUFhHSTJTNmJsdDZPeUxVZk8xcTUzbkNjQ1U5U1dyLy9p?=
 =?utf-8?B?U3hZZ2FSRjdzQjQrc044bmdlU3QyN0VMSTMxNTVoc3NLS2lOU3FPUU1NTU8z?=
 =?utf-8?B?SGxsUThXUnlVL0M3L1B5Zk1vbWQzbGFFcmNRSDEzaWhLTCtnOHRGLy96MzU5?=
 =?utf-8?B?eHJTY2ljVUZJbU8rOGMwenB0M1ZwODNIL1BpMzhBQnRmZms4a2UwYXFkbzBz?=
 =?utf-8?B?QllmYXZPUXBsZmdqZGxxUDFtWHV4N3hHM0FpNnFiM1NFbmJFSmIrWUsvZ1Ur?=
 =?utf-8?B?eFY0UEl3MHVkNDFSMDFDY2QrZmg4dkFEQTZDdkVHbE1jczRmdmoycThubnNi?=
 =?utf-8?B?MzBMeGtkRTVlVDNKQzh1d1JmNlhqMDlIeUU2d2hLRXFzdzFJTSsyejludGtz?=
 =?utf-8?Q?TUMKpWwidEiOHjH38XxpjraBI?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df142d1-1e41-40da-411b-08dd3d3c33c4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 12:31:33.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdfLbi3SOfs70nmMjBI1jxQHKN44a7d/8oRbqOsXc/PlGAXSG+dhto+Hq5l2txsA2CleH15rkECATktpoxRjrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7007

On Fri, Jan 24, 2025 at 12:42:26PM +0100, Arnaldo Carvalho de Melo wrote:
> Consider setting it via 'perf config', see a recent patch I sent for the
> wall clock profiling feature, it would be something like:
> 
> perf config probe.quiet=true
> 
> https://lore.kernel.org/lkml/Z4akewi7UPXpagce@x1/
> 
> - Arnaldo

Thank you Arnaldo.

-- 
Aaron Tomlin
