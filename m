Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020076.outbound.protection.outlook.com [52.101.189.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B727A925;
	Mon, 28 Apr 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858042; cv=fail; b=mQlwG/39Bc2uuWDmdEsi2kKTVODIRJOTzl0uA4FVyD40ywI0EHm67NK+bIgT63q0a4XY4zVOTNmwD7/RnygdTCt5CYkKDXAb4iwjBiyhYwDK8q5zvnrFz/igKfaM3maRuCm+qd3UpEZPvYmnZAU0Nh4Mnk1BgousKovzx7UblCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858042; c=relaxed/simple;
	bh=e6ME95Sw3fDuNxTSrv7l9kQjQJCvFRrqpMEwRHuwSog=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=huxkFNB/abUV5wjyulDS9NMgS6grrdrWAdz4KTXCBQ3mGhSnA/3REcz4PpjiHLcRSwSAXFlgCKMM7S5YhDAfch2RI1TgQZVqHHu+aWAlzPXxhDCJdc6bfgHVOinuat55UEeT7VGdKawdxtgsXtxfkg0V8mI9nodht+0jHk2PK74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lYZVZXW/; arc=fail smtp.client-ip=52.101.189.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lYZVZXW/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nzpul0vdCD4tW98JDOuM9yGmTf7kwPZ64/tdyhLki2suwivkN4KA7xdMl8UtFUS6Cfna5HMs9Byte4mCIji6019Jh5/AicxClpRmmvcbyVAPeoFR9q1IsJUUAcj077EX85pZ6AgvJkEDb7QjRGj8AA83S21qNltwE+lZqs3sDWxucMLJZNuDcPWMZhVFXFOmbWhjPtmvJs8qAs2qkgC20oyzPwx2SKZFcAVl1r0RmALOieJpEitIhlhnxdptibQPGe/0DwsB+jKdVRYNa/g6pRh8hQbQs48igYCHoeG+U0KW0dEZW8V9d/cNss3RIYZm+p7CD9p4AFoSqSLwJVjRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsU6NWAv2qZdGzzlsedzjcyzkaeJXpxvUdcUBUuujcE=;
 b=YaY8sM9e31VnolmAoxdFXIFJfbFYIErhi1FiWszXZAo9W/5arJROcuUZTakWjRSao03kOVjcwZOqPbTCij5R1SN9FGV0tKXOSTH7/y0K+LxvKcP/7YtLCBH9o9JDt64XN1lHufgkEjiR56kZpaO2wnVspxFEtA22UtNZdazqGQdZeY0xNY5AQloY/Km+F8b61bpjepPu43oJ0vVLSnnTb1mk5Q7kK/S0OfUy36ZaLFhSJQuxsn+OnztviRmbYQcoIwg9UMMijEa/PEg4eWOrdvRRPmAO25Ii8GXysBm0OlwdLwzoA6jswcEne/WjCNx+eKUuUP0HnM+8dP6IlskEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsU6NWAv2qZdGzzlsedzjcyzkaeJXpxvUdcUBUuujcE=;
 b=lYZVZXW/J5dDQcszf1f+hPj+hP0Xau1UEpRyvMtURCZ1CC9ah0n17lleKm2AbrIw06dgB/8L0WBA0wKLP5wWuHCu5rYHY0kFN7Tb+yZTsZC1nSp0gGXrUC4/C0UV9daaqwB9d1+Gp3smdyiU2VjRPsj7qZXiiLpd9mMuB7flsMtrVyOK1ktkTVwxOOaXMd9kiEGoAu5ExQYqDcjKwCbbFX/3Pe4chdNlqN/t1pfloaHFJz1j6egzbgXskAOLPg0LyVK4knv6YPr/G5be+k2D7dIzpwORLxMeJ3mgtVgEmcRkmsnqpNwdwCmTu3UwAYU433XCBMtj/T71iBT7OOwCOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB11186.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 16:33:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%7]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 16:33:52 +0000
Message-ID: <02339b93-de9a-49e4-8dbb-137d02fc6ea8@efficios.com>
Date: Mon, 28 Apr 2025 12:33:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] unwind deferred: Use bitmask to determine which
 callbacks to call
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, "Jose E. Marchesi"
 <jemarch@gnu.org>, Alexander Aring <aahringo@redhat.com>
References: <20250424192456.851953422@goodmis.org>
 <20250424192612.844558089@goodmis.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250424192612.844558089@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB11186:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a4ca29-eaf9-4e92-2912-08dd8672763e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djd1N3dPRnptVmVYdlFjUWlVSFlIR0J4M29tVW5tWEV6N3psL0p4ZGRoN3JU?=
 =?utf-8?B?YmlvQ0RRa2cwMkFEOWltbjZmRytEcmJVa2xCUk1heDB1dlNxUzRBKzlFUUR0?=
 =?utf-8?B?S1pCdWZSdVhkMHhRZG5nQmloSUhvWExjbXVOVnpueDBlVkMxV3NRUzdrT09F?=
 =?utf-8?B?QUp3T3RURGFhVDlzUmVBM1NIYzh6bThhQVY1eXMyYmNUY3F3WFVvYTZZNC81?=
 =?utf-8?B?VWx1Nm1aNXo2ZkdTeGkxVUtLSjhKQWgrdU1lQUlYT3hWbXBwQnlLQ3kwZ0Fy?=
 =?utf-8?B?WXRNWUVuenJsNnpWaStVKzB1SGFoNzlXaG16SlJ1bVRqbXk0eXd4WnN3NmhH?=
 =?utf-8?B?UEFTbDV5TVlUdDF4ZFpzSWptVk44WVZ1T3VCd2N1dVhwMXNtcmxjc1ZCcDhC?=
 =?utf-8?B?TkRTZ3gxY2NtbnI5WEJRaW9MVlBRK2JIamY2a2ZPL1ByRTFvOUFEeHVTM2xv?=
 =?utf-8?B?MUYzdjk1eVRvTFFUMldMYVBUZFZwa1VYVUxRcGQreEdKSko5RkZucFZOUDdK?=
 =?utf-8?B?S3VwUndaWUFEclpqUnlRQjVpWGdFanNiaFJzWUdWSHg1Yk5DdTBWVHpBdDM0?=
 =?utf-8?B?ekNIUXZyc21GbmJiWjZzekFxK2VjWkk1OGdMYVpkUndSVTNveG94YkFmcmtZ?=
 =?utf-8?B?czZqck1HVTUzY0tCdk1LRnVhN2M0WE9NQ29ZcGxLOVlyMVpZeitsNk14Y2pn?=
 =?utf-8?B?dUtpU1JkWkNRMzFDbnhtZklybmE4OFhBeS9JOGIxMzBXUUY1anIwOC9iYkJy?=
 =?utf-8?B?bTJqZmJnb1VrRWhVbjBBaWt2bjdySHE5bW8vdm9UbkptNXg5MUx5ZHl5Y0xM?=
 =?utf-8?B?MThvZTdKVFFTVWpSSjMrQ1k4aFNCLzFYaXNHZ0RZMlJObFdoMkEvUU9pQWRH?=
 =?utf-8?B?MVdycSsveWppYmFUZU8wSE5vNFYwYmh3dVd1dnhzTlhVVHg5ZmFXaWFNeVVG?=
 =?utf-8?B?UWUybkhKcDVtclBWdlZtbVc5SHNOQmQwNm42dXBCZkJPdDdJMi9MNW03WHZQ?=
 =?utf-8?B?Skc0LzZNSlZsVzJ6VWVDQUZCaFVJM2V5eTZHeVZBNE5JM05ya2RQYVlvNkxO?=
 =?utf-8?B?aG5ZS0hTWVNZZnJabTVMRGNZRnhiN1o5SFp5WE9mb0h4VE90ZHB4NkZaVU10?=
 =?utf-8?B?TGpqR2lRaHoyS3YzR3h0R0N0MmY5dE1qa2xNLzd4TTkrVkt3QWNpZUhCUU56?=
 =?utf-8?B?eVRlRzZJUDFoMTdubktMY3QxWWRTajZaT21xL1NlNFpmK2YzWEw1OVordEFk?=
 =?utf-8?B?YXlVTWtLR1d6UWRJZ0pBcGloUmYrbkFZUkFvQkpISkFCblp5SmErUWd2RXZX?=
 =?utf-8?B?ckhYK0ltQnJNbXZPNE5FaEhESndHY0lQVkhqSWJXdE0yalIwdjhpZE1mWDFv?=
 =?utf-8?B?WmpEdWVGMm9ET2pNTitWV28yWTdQYkxmOFlYZkd3bFV6MUdlcmx6aG5KMHlJ?=
 =?utf-8?B?TEZVNDFqY2pab2UxSmVsZzJETllONHlUVW9aMnh2SExVZEM5ejRYWmRrMkJj?=
 =?utf-8?B?a0VtWjljMDZ4Z3VvNExJbDJ2RHRqSlk4OGgvbWE1cFlzcWVRdGlQbTRWTXVI?=
 =?utf-8?B?MmJ2QUtnaEc0TWRaRldXbWdFak5Ebmt5L3pRVGZnM1FJN2p6TC95MHh5dmR5?=
 =?utf-8?B?V3gwYVgrd0UwUUVEdmlmclF6N2htU1ZLTFNRVzY0WCtkeXk2SkIrK2FWb3hj?=
 =?utf-8?B?OGFSWFlacDlwQzVETFNMQ2MvS0hmdUlJTWJnZkRDS3laOFhBRUlmS1A5UG5p?=
 =?utf-8?B?eGFyRDVXOHliRXdTTkpqUW5mdGtpakJGSkFNLzl1WWhLUFdQbGRHVVZDL2N1?=
 =?utf-8?Q?DZIyIa3h3DM2B6ctGgZj7u68l28k90SyU+Qyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlhZSHFCSFE2ME9UdFBIK0k1T3ZCdklxWXkzVXYxZUhLQk83b2JJN2UxbGVY?=
 =?utf-8?B?S3R1d09LWlpwOEpjUFNCb3pGSzBuMGRFdzZqL0F1eDA5MDVsZ0lvaG1Kc2x3?=
 =?utf-8?B?UmpmSjlzRFVkTjRzR3dlYjl5SjRjL3NzQngwUGxZT1VhdEkyWVEyUUY1dDE1?=
 =?utf-8?B?ZXRvSDladE9ZNEM5QlprcGpzbVhZZW4vU0swUm45a0M0ejVSTkFwbUUyeERX?=
 =?utf-8?B?K0lkWEYzWWsyb1RLMm9ZNm4xTGRjYkdhSWJjQnlkTWtVMExXclVnNStnR0NX?=
 =?utf-8?B?aHdEbmZJZDJzYStzS2hDRFVVWVRybmJPbi82cSsxbTdEUE5sMjNTTXYrQnYx?=
 =?utf-8?B?Q2xURUQ5cGUyWis0U1N2SHU1Q2ZDcXRZY0FJRUlrYTNoZ21nNm1Selh6Nllr?=
 =?utf-8?B?UnJ2NHNHMytKTzczekV2S1c3aFJiQ3ZBZWdxYkxFTTZNT1NsYnU1SUNkaXZJ?=
 =?utf-8?B?Rm5GZzFndVducUY3UU9xZ3A2enRVOTE5UkpUdUhxcElEM1RGbjd0Q1FPanMr?=
 =?utf-8?B?Vy95dFpOaXg1RVJ1ZUFjcjJKZnVwSTRXUWpFanBkRmlWcDlYWWJlWXc0a1lY?=
 =?utf-8?B?elAzWTZBNnIrUU9LK3g5aU8ySWtmN3RLRFVFNkxjRzlHdlpNK044SG9YRG5l?=
 =?utf-8?B?OStjSFE1MUJ0cy9JaFlWVGVTM3B4V0FWN3pWYjZhQmkycGhidXh2Nmt2ZHVj?=
 =?utf-8?B?b0FEWjZZWHd5bEhPdnBBWktQR1NWSXJ4NDZRSVdaM3dTanJEaFY5VmxaUFR3?=
 =?utf-8?B?VXJzNTZSYnpscWhPU1NDMTd2MGJzV2xXR0loMWYxSWYyYTNXVm43TVp0MFBq?=
 =?utf-8?B?Vkc2MHpKNTNQVWZHeEE3b01QNU16Vmp4OGcyaGNpbHBtOEthRzd2dHpONC9J?=
 =?utf-8?B?L1pIRkgxWE9ETEhYa3kwSFIwRnYzcHp0SzlRbGdKS3VjWmJFVXJMaDhNd3Fv?=
 =?utf-8?B?SURNK2FkU3RrUExIYzE2bEVWL1BTK1lTVUFyZEpDNWx6REthV3pOelRvbk9t?=
 =?utf-8?B?UTh5cXRaQ1JBSWdPU0lsSHJjTkZueUROckowOHFONmlkK09kVkdIcHdrM1NU?=
 =?utf-8?B?eWd1N3U3bGdwS0F2aEV0K3Z3RVhnU3VYMUJDbWx4VXZLUVZkQ2F4eHlXTXUr?=
 =?utf-8?B?eUkzVTFXRFBPZS9GYWg2OTJpZURnVzlVMGtWQXVidHFkdUltNkNydmJXcGF0?=
 =?utf-8?B?N0VSeng4bUVjamhJT2JqMzM0Z1dFZnVra0VKd2JYeTdHdXowNE9jY3ZQcmVa?=
 =?utf-8?B?MzhVVTlTUE1Jc1JvZTNpV1l2NWlpZ1R0WjI1MHpSazdWeU9mMVdoY2k4QXd1?=
 =?utf-8?B?emE1VWVmdmRZMXdRd241MXdTRC9hTjVHcGJHclZyN21mdjZYNTgzWU90cEVP?=
 =?utf-8?B?c1FnY2ZVbUZYNUhLbzQ1d2FKY1FPOGRvS1U3OUpFU0pwMzVJTUtyY1lING1V?=
 =?utf-8?B?amRKcEpTZjhFejlLMFQ0WkxqdTRXek0rdG53dC8rSWNNb2FhTkFvUlA5MVdp?=
 =?utf-8?B?bHhYZjRCaFR4UUt4Y2VWYjB1d2Jsd0RiSTJ1Sk0zT2tydk1CYUxDYW1qeWlC?=
 =?utf-8?B?ZVp4VlY4MVR3cWVxaU5zMHZ5akJiRjlNUEo3K3dwOXJFdzVRNmdlRnBtWkVG?=
 =?utf-8?B?dHNqZ3pBWC9QQjg5Qm54WTdyTWo2OHUzOW90WUljeldpemU0ZmR0RHVwOE1l?=
 =?utf-8?B?QnhEQnYzQWIrcFE1VW1VZWhPSysxNFd0bzFUczA1WmovSnBqaWxNenJaUExo?=
 =?utf-8?B?L0NqdUNDZEFwRlBVNFliSzJrbElOOE1ndkp6cFpwdGdtckptOVdRYnp6NTZW?=
 =?utf-8?B?MWprUlZTQ1JtaG5zYkxTSUxRYnV2WU9VWk9ud0h4MTdXNFVSUmN0VTUyTHFM?=
 =?utf-8?B?eldDUzVMdll3NExyQkhHYUh3ZUxBQVpoQjdnd2lmQU9tVTNpN2FVYWkvcVM3?=
 =?utf-8?B?bnQrY1dVTGhTNndtc2lUWW40T2VVU1BZK3QveFVuR2ZHRllHL2xBMXN6TjNI?=
 =?utf-8?B?Zzc3Qk43L1FoMWdPUDZkajNBajNVbVNzNi9mbVFJZ1hoVklWNUJrekF5YmZD?=
 =?utf-8?B?OVowWXpQUG9WYmIxdTdXRnFoTUV0MHRSTTEwUUhtRExmTzM0M3lTK0prV1VU?=
 =?utf-8?B?QnZnbEVTOUhBRzgrSEJNWTdLZ0J2YmZqa1ZFQnhvOWFrdjdEVGhSenRYRVlB?=
 =?utf-8?Q?0sTd8iCQDAPQwzE7PC/gjR4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a4ca29-eaf9-4e92-2912-08dd8672763e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 16:33:52.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWcWfOFrBoODUvKM/Y/OADW87p2bjREAlCHNo7f8Z9hQYc99vZ/Qcq4L4Pg2WJobvf6bV1WTWfMxlofiuCqmoIp3z/IQZ5Vrf/Act4kxwdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11186

On 2025-04-24 15:24, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In order to know which registered callback requested a stacktrace for when
> the task goes back to user space, add a bitmask for all registered
> tracers. The bitmask is the size of log, which means that on a 32 bit

size of long

> machine, it can have at most 32 registered tracers, and on 64 bit, it can
> have at most 64 registered tracers. This should not be an issue as there
> should not be more than 10 (unless BPF can abuse this?).
> 
> When a tracer registers with unwind_deferred_init() it will get a bit
> number assigned to it. When a tracer requests a stacktrace, it will have
> its bit set within the task_struct. When the task returns back to user
> space, it will call the callbacks for all the registered tracers where
> their bits are set in the task's mask.
> 
> When a tracer is removed by the unwind_deferred_cancel() all current tasks
> will clear the associated bit, just in case another tracer gets registered
> immediately afterward and then gets their callback called unexpectedly.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   include/linux/sched.h           |  1 +
>   include/linux/unwind_deferred.h |  1 +
>   kernel/unwind/deferred.c        | 44 ++++++++++++++++++++++++++++++---
>   3 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a1e1c07cadfb..d3ee0c5405d6 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1649,6 +1649,7 @@ struct task_struct {
>   
>   #ifdef CONFIG_UNWIND_USER
>   	struct unwind_task_info		unwind_info;
> +	unsigned long			unwind_mask;
>   #endif
>   
>   	/* CPU-specific state of this task: */
> diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
> index d36784cae658..719a7cfb3164 100644
> --- a/include/linux/unwind_deferred.h
> +++ b/include/linux/unwind_deferred.h
> @@ -13,6 +13,7 @@ typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stackt
>   struct unwind_work {
>   	struct list_head		list;
>   	unwind_callback_t		func;
> +	int				bit;

int or unsigned int ?

Rename "bit" to "requester_id" ?

>   };
>   
>   #ifdef CONFIG_UNWIND_USER
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index 2afd197da2ef..f505cb1766de 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -26,6 +26,7 @@ static DEFINE_PER_CPU(u64, unwind_ctx_ctr);
>   /* Guards adding to and reading the list of callbacks */
>   static DEFINE_MUTEX(callback_mutex);
>   static LIST_HEAD(callbacks);
> +static unsigned long unwind_mask;

Perhaps "reserved_unwind_mask" ?

>   
>   /*
>    * The context cookie is a unique identifier that is assigned to a user
> @@ -135,6 +136,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
>   	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
>   	struct unwind_stacktrace trace;
>   	struct unwind_work *work;
> +	struct task_struct *task = current;
>   	u64 cookie;
>   
>   	if (WARN_ON_ONCE(!info->pending))
> @@ -156,7 +158,10 @@ static void unwind_deferred_task_work(struct callback_head *head)
>   
>   	guard(mutex)(&callback_mutex);
>   	list_for_each_entry(work, &callbacks, list) {
> -		work->func(work, &trace, cookie);
> +		if (task->unwind_mask & (1UL << work->bit)) {
> +			work->func(work, &trace, cookie);
> +			clear_bit(work->bit, &current->unwind_mask);
> +		}

You could change this list of callbacks for an array of pointers,
indexed by "requester_id".

Then you can do a for each bit on task->unwind_mask, and all bits
that match end up calling the callback for the matching array index.

>   	}
>   	barrier();
>   	/* If another task work is pending, reuse the cookie and stack trace */
> @@ -194,9 +199,12 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *cookie)
>   		*cookie = info->nmi_cookie;
>   	}
>   
> -	if (info->pending)
> +	if (current->unwind_mask & (1UL << work->bit))
>   		return 0;
>   
> +	if (info->pending)
> +		goto out;
> +
>   	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
>   	if (ret) {
>   		if (inited_cookie)
> @@ -205,6 +213,8 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *cookie)
>   	}
>   
>   	info->pending = 1;
> + out:
> +	set_bit(work->bit, &current->unwind_mask);
>   
>   	return 0;
>   }
> @@ -244,14 +254,18 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>   
>   	*cookie = get_cookie(info);
>   
> +	/* This is already queued */
> +	if (current->unwind_mask & (1UL << work->bit))
> +		return 0;
> +
>   	/* callback already pending? */
>   	pending = READ_ONCE(info->pending);
>   	if (pending)
> -		return 0;
> +		goto out;
>   
>   	/* Claim the work unless an NMI just now swooped in to do so. */
>   	if (!try_cmpxchg(&info->pending, &pending, 1))

Not that it necessarily matters performance wise here, but can this be a
try_cmpxchg_local if we're working on the task struct and only expecting
interruption from NMIs ?

> -		return 0;
> +		goto out;
>   
>   	/* The work has been claimed, now schedule it. */
>   	ret = task_work_add(current, &info->work, TWA_RESUME);
> @@ -260,16 +274,29 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>   		return ret;
>   	}
>   
> + out:
> +	set_bit(work->bit, &current->unwind_mask);
> +
>   	return 0;
>   }
>   
>   void unwind_deferred_cancel(struct unwind_work *work)
>   {
> +	struct task_struct *g, *t;
> +
>   	if (!work)
>   		return;
>   
>   	guard(mutex)(&callback_mutex);
>   	list_del(&work->list);
> +
> +	clear_bit(work->bit, &unwind_mask);
> +
> +	guard(rcu)();
> +	/* Clear this bit from all threads */
> +	for_each_process_thread(g, t) {
> +		clear_bit(work->bit, &t->unwind_mask);
> +	}

It is enough to guard with RCU ? See syscall_regfunc() from
tracepoint.c where we do:

                 read_lock(&tasklist_lock);
                 for_each_process_thread(p, t) {
                         set_task_syscall_work(t, SYSCALL_TRACEPOINT);
                 }
                 read_unlock(&tasklist_lock);

To prevent concurrent fork from adding threads while we
iterate, thus opening the possibility of missing a clear
due to a concurrent fork + set bit.

Thanks,

Mathieu

>   }
>   
>   int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
> @@ -277,6 +304,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
>   	memset(work, 0, sizeof(*work));
>   
>   	guard(mutex)(&callback_mutex);
> +
> +	/* See if there's a bit in the mask available */
> +	if (unwind_mask == ~0UL)
> +		return -EBUSY;
> +
> +	work->bit = ffz(unwind_mask);
> +	unwind_mask |= 1UL << work->bit;
> +
>   	list_add(&work->list, &callbacks);
>   	work->func = func;
>   	return 0;
> @@ -288,6 +323,7 @@ void unwind_task_init(struct task_struct *task)
>   
>   	memset(info, 0, sizeof(*info));
>   	init_task_work(&info->work, unwind_deferred_task_work);
> +	task->unwind_mask = 0;
>   }
>   
>   void unwind_task_free(struct task_struct *task)


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
