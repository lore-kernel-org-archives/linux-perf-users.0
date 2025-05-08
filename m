Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022090.outbound.protection.outlook.com [40.107.193.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE42836BD;
	Thu,  8 May 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730210; cv=fail; b=fG84PCnraU0ithraw5u+JJEvzYO/eUlAw7G8M+OF5Ks3VfPPIkhjB5fwbvYwr56eYrpFC+EqWXFGqXS/EbyW4Kil71lp8sBFHUlxMMio3V0L/mDCTKoUyF8L/Udl4u906rZGXigJs1uFKdBbYjs6Dxlio77XG/CTE9u1Y9v6R5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730210; c=relaxed/simple;
	bh=9FP0F+px/9AFkLTctwMHCi2pFZivKCPHUkNWsYDIAs8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EOsRQlSLxvLoL8xG6HEcYNvbx5RPfKultjquBun5Sp0qB3Zjtut5WHF00pecM91H2xfi6uYYfGTBX9tv62wr82qnS5GpO0cL320ZaqYKpLTeph2LmjT5lrrjdb/JhVNZ86BB2V/KTAgmPTWD07ET/37WfHN7e9S6TQu82p7sjK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oRA4pnJ+; arc=fail smtp.client-ip=40.107.193.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oRA4pnJ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlZHGb4CpTwIGZrjx/i5P7u/MOYcoLjT9zmIrtxFu1mTtfJWNMCDnxiEymVIV28Vcno4Fbo37qd3fx2oCbIYwu2zU54OYt2BnNX4doLduU7AluJ5z1yQ+NPMU9bOA5an2T2ewmCHNQc26uLy7kNQ3LGOUQKhijlahLkI8fNv4PnGa6Wt+BTgn4o2ZBBQtJqyB4qXbq9nBHukwKHwRp9PjRn8fNIjBNssPe2EduOLlonpYdjeNYA2/HmKbGfv7zN9C8kEq42Tyz+4oNF3vJNmouP4r4FCWPi/hh0bpfXHB+xdhWm9ds6EHvWTWq5vsIM5Y686QMk8MgRh4g7wVRC7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YnKYKKtBpCGqhGRJmqTdS6rNmnkU6ZFEvGr0KNIxpM=;
 b=wQK8bgAgHipsMsPecTRm6aTOZ1/Bu5FEjtxVnAHl6eIBE5xY46PdpVdCsMsPj6nQLwtYWO4MYLJ2fYt5C/hY4aOq/6VAgt9ZobmvYrbYJMVBD7pXwrxIU837B5f8xEFPUXfTdRGqf+RxFYJx0QjIdMLrgrNUrr6hZFGc5bDzZ2lZVRRXKMbk/mhX5nPj5yAd+a/RMPInpR4zLGPueDOVEGidsRtZG10FFMmavnf+xkfqKObk1YOWVc5vKpsU7GUS47bAzqESJbnTRGyvV+Zt09+eX1QaevnB5ENRPNJYSN2vPT9uWxEeuKy89L8c+lmpeglPzbNqimU/sZpjGMZO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YnKYKKtBpCGqhGRJmqTdS6rNmnkU6ZFEvGr0KNIxpM=;
 b=oRA4pnJ+vLWzusMMyjbBFBqaR918zFH4hV0YAUX+/32cRGe/eu7NZ8kKbfRh3l49t7NyYAIrI6nrPezg79M3PaUNKzcO8h1lf/Y5H+5d8uw0d2sMK29ZYdGr0LeDxiB/F8IbX4xDtOAEP5ciqh3fdBqw1zgq3KnxYXr5N/NPsHjeMdDCyN+BqrIrsyFdh5p+tweITLPOvMv84fytkJvwQgw3SaqeZCWnciXl9ceIfhBwGyDPy8LMaDUtmgzgyCZQWyAkoIj7jaHtQkh3I5WbOjzzyIEOYY+e1/ZIK6EROA60YG6R3ZOpJs6nu2Fml7vh77ITRaVi9cJ8nIQFbCbftA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 8 May
 2025 18:50:01 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 18:50:01 +0000
Message-ID: <89c62296-fbe4-4d9d-a2ec-19c4ca0c14b2@efficios.com>
Date: Thu, 8 May 2025 14:49:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, "Jose E. Marchesi"
 <jemarch@gnu.org>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.390748816@goodmis.org>
 <20250508120321.20677bc6@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250508120321.20677bc6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0333.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a657098-6384-4dac-2a82-08dd8e612324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUxkZjM5Q1dIOWpDZHB4cXpwQ2FCai8rZ09icVJXQnRnNHI0ditXU1ZxNno5?=
 =?utf-8?B?dlRnWkgwTmhtMHhnSy91MEsycFNmRTk4T1NwNGs2QWllN0ZGTHZVTTFaMVFm?=
 =?utf-8?B?a0ZMWXVQZ05hSnh5YU9SRUxYRWdQNmwwUHVoSEI3NEs0L2h6cm1mSko3Nzds?=
 =?utf-8?B?S29HK3RWQk55U25velduSkdPYkRmOUM3MUZ3S2wzSkRSLzd1Rit1ajdhRXdh?=
 =?utf-8?B?V0lyVkpHQWlXai94dFZCRDBKY04xcmplTmxFRWFVVVYwbHVXNWcyT3MrdE1S?=
 =?utf-8?B?OUNaVm9OdGtTNHVMbm81dVM5dVJyc3FxOVlTZFBtOS9vNjMxNWJHbFhlTGFG?=
 =?utf-8?B?dGlmMHd4a05DcjlYeWpub0N3djBHR2IxV0FXU2Y4Vk5FWTZMWU1EM2VkSCtP?=
 =?utf-8?B?TEVFaEhYMjFLMEY2c0U5dlNYT3VKSUdTVitTNkswNjBMdWhwbkRxZTVQSkY3?=
 =?utf-8?B?T1FBMDVHODB6K3JlQXBkbzVxWTdoSHQ0WW1zWmY2cFRlWE4vZ1BEMkZyK24r?=
 =?utf-8?B?RHhhaHE3RENxcGV4SUFnbkVUOEhJeE1VMm8zN2dVdys5TytJVGc0NHlvelVO?=
 =?utf-8?B?ZjRWOWhyT1FmV2lIY3FKQXI0aEcwVDhHUmtNcGZMcStxcE9CS0p0dURnN2cr?=
 =?utf-8?B?bnVVWVkyVUpCTnlXYWhQUkVFWGZ6MnZZd01Pa2JvV28yU3Y2NkFMeXRQTzlY?=
 =?utf-8?B?VmNQV1lCay8rRzVRTlNLNWNzM2pBSkU2aDdMR0cwMXBBL0xWY3poUGhuOUo5?=
 =?utf-8?B?ZmxBSVpmYkJIMVp4UlJueVN2WU9RYks5Mno2WW9WU0lMMXFxNTBKYXFWdi9P?=
 =?utf-8?B?cURZQW9ic3RGbTB2dUpLeXV2RHE2TzFHRVBib1FYTWczeDJGdGtQUy9mWWtw?=
 =?utf-8?B?a2s4Z29MRUt2M3RBYlRvREFlQ053c3RqZ3JONmR0Y1d4ZjBNUUtaRUg0Q1hB?=
 =?utf-8?B?NFcxOHJYVEZuRU1udE04bzkzSkpBaEw2R1hNMU5xdERQSk1pbW4xSWNMSEJF?=
 =?utf-8?B?MmxZY2U4UzE5QnVBckZBd0EvYW0xbzQrTUpxZmNzYkFVd283VHVubjRBRGVq?=
 =?utf-8?B?c0F0QVNTQUkwblFxSzNVVUJRajFIRFQ1RHh4ZEI2SDRTVmdRQW1QZHpEM3Rj?=
 =?utf-8?B?aGZSLzV4ZVJZbGF4ZGpMN01MOUNiY1FuL2JMbFpFWkRQaGdmTldveitGN2dy?=
 =?utf-8?B?cTRiQ042cERNQ0tCM1l6YzFRaU1SdEpYQ1R5WC9jaWFIYXh4OUdobGh5U3pu?=
 =?utf-8?B?Mm55NzdCbURvUGlNRFFmeXBHbE9HZ0E4RnRiRUd3QU9GN1hJbUl6ak5aZXhM?=
 =?utf-8?B?SUZ5SVhieURycWxCOERVOXM5cFdnazd0OHVPSDBEQnVuem1TYzV5dERnUkNp?=
 =?utf-8?B?VUR4NkdPSm1NSEdZU3dTd3R6NlJwQWZyS1V1L1BGY1VEM2ZHeUVpamxjVVdo?=
 =?utf-8?B?TWQrditoRENwenhDUFJZZHhWWkRMbU1CNUVDQlNVYy9icVJSL3gxL3dpSlBM?=
 =?utf-8?B?MzNZM1pKMjlreFBWck8zNmhzSVpLcWlPdVk3eVUySTF2TnN5clRDSllqUHdX?=
 =?utf-8?B?UnRUOXNaQlBCeU1kNnk5aTR2VUFEeTR2Sy80TiswK2hVL0c1R01UcU5QRnFx?=
 =?utf-8?B?a243RFptZVNZYnRxYllaTnlGTzdtOXp3V2doeGlKN2VzVXEyRms2b2cwS1pl?=
 =?utf-8?B?QnlqTGZvcWdNU0ZFWElkcHRFMkJyV09qREdBY3RmUytFRndJcTFoTVhOVEpi?=
 =?utf-8?B?blUrMzVTdDdGaXpDVDh2NVFnU1VqMjRZdXBSblFCRThEdDFVeWEyUXkwdTJw?=
 =?utf-8?Q?pTaTnZf4KLpTNUsEA3kQDeB5jftYa1Q7JvmYs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEdJYWlYSysrUmVla255VG9KdjZCdS9JQ1NEcTNKZXRtOXFvc050Y0JLOEdK?=
 =?utf-8?B?bmdYY0czaDdoam1LMTVmTHJjQkZ1UWUxVHVRcGtFVGdpZlRCdDY5ZXJNKzhL?=
 =?utf-8?B?VDA0bjBBQjZYQk5GbXkyK1hZWmEranVQYWVLQnN1dllYUk1lWnBkMjJvU1R0?=
 =?utf-8?B?WjlOT3g5YUFnREkyWFI0OVdjOEVuZVdoVkk3L1EyY3FSbFRKY3pkTHJIYzlW?=
 =?utf-8?B?ZUVPcDJHeldWalRjTExTZXdET3Z6Z29pWng3UGkrQnRIRk93YTVJTHVRaDR4?=
 =?utf-8?B?WjNZZENibktNMW9OQ2xZZ3hEaHVIRWlHSTg3Y09xU0FOcGxtU2tIRXdKZ05n?=
 =?utf-8?B?M0xERFo0MmtSTTRWTUR1elBKUWJ1S3N0OGJ2ZUgwUkpIMmVzanJrOXV0RDQ1?=
 =?utf-8?B?QnZBaDIwYVBwSFJ5MHdQUmVxSkk1azd5MDI2SExRS3A2a2R4WnlUL1lxN2Nz?=
 =?utf-8?B?Y2FZTU5mUkhXMjJ3SE1sOFp1QkdPUE4zYkhiV3VCR1FNOW5aU3VLdG40cnZ6?=
 =?utf-8?B?Rm0wbUp1TEttbUlWTEoxK0w1dEJldHUvWlR3VmQ1ZTBiRDg1alBCdktzNk1q?=
 =?utf-8?B?Z0V2K0UrbGV2aEFKSUt0dGNqTlpMaE5uamhOaW8zdXVLcUFGcFNmRU1Td3FM?=
 =?utf-8?B?UW1CMGduNkZwTEFBR0JzRDJTOXhNOVp5VmFCR3owQ0NubHd2cE51dHk4OFBK?=
 =?utf-8?B?bzQ3VjRiYXNWUnBkU3JLRW9Pb0FhRlUyS25MamNGMTJkb1UycG40M1c3QTk3?=
 =?utf-8?B?bStsK01YQ3RaZCtUYkhoMHpMSlBvZzI1Y3p2ejAwRHNRdGVOR1plTHFjZnF0?=
 =?utf-8?B?RHlnVGJ6cmFZd3VaT2RQaXJyZmZ0L2s5Ris1a2d4cnEyUUMrNzZvTFYxcU1U?=
 =?utf-8?B?cjYwYnRYaHdrSlkzWWRqNHlVVFZUZVBtVFNycG9kK1BWZERiOEJ1Uk9nQnZu?=
 =?utf-8?B?eHpibzhMc3FVbUxCRVQ1MnVOd1VObFVudlc5UEUwZm16aFJmdmtXUzA0SExM?=
 =?utf-8?B?dXU3bWMxek9VZlQvNmxHbFY1UWhzUkJHdUhqSHpXY1Q4Z0tVODEyNzNIUWU2?=
 =?utf-8?B?THZSamhQUTRVU1JyblY4cXlpdy9DdVl4ZmRDalk0M3dheHd2L0Q5M0JpU2Fy?=
 =?utf-8?B?K1ByWVBheDdEV050Y0FuUzVZNktZaVBHalBtbzhWRFkvOGFqclZDUVFmOUwr?=
 =?utf-8?B?QnBTQlhkdlpvcU9hcWpwandXWmh1MFdrRUhzYksvcGlRN0svcGZraGdadVBC?=
 =?utf-8?B?bnBQQmN1a2hwWWhQdnhscGh1TjhFei9mZUlIYU55bEJPMXVHb24zVHFMVzBG?=
 =?utf-8?B?WEtCZy8wWE1GY21JbzBPNjF0Z212dnhzK2U4M1h5OGs4VjkrUlVaUHhQNjRw?=
 =?utf-8?B?TVRjbGFuck9ZVzZaQTc4YmdaMUtMZDFnMnNLV3VqUWJrZ29LbHFLdlZFYjY5?=
 =?utf-8?B?RkdxTGF6Qjk1UTdWeDBkZ0dNaXVUUXhSaTI4SnkrZTVCNElsL3dHSW9URGZ0?=
 =?utf-8?B?RFR1QTB2bTB0ZVR2OUlVWlNEY29JVGozU0piQmprVkFYNjVZUG4wU3dKaWFv?=
 =?utf-8?B?eEpSWEliZmZaSFErVVJmdkdBanJwTS9GQzdJUTZhQTA3NWJROUltWXJIT29L?=
 =?utf-8?B?Z29MOWd3bnY4YlY3Qy82TndTY1Q2blQvR3FENXdWdTdhRUFnajBGRjA0d1Ur?=
 =?utf-8?B?WXNVOUI0cHpVL2p3YnlnemM1QngxWFJiaDZMRGJ1TElqM1ZZeUY1ZlMyd3cy?=
 =?utf-8?B?YS84MTlmMVNKMTZjSmdSQ04rV2Fxc1pPN2kwYVhzQnhQbE9GQkZpZEE2RWJk?=
 =?utf-8?B?UGZUSUF1UE5lZzRiRFFrVjhOU3NUUVoxTWcrbFpRRVBSTDZtOTNva0FpNkpH?=
 =?utf-8?B?RUIvdis4bldrNEJuTVFjYStLbERPS25oa1JJVmw0TEhJYndBQVBVN0ZIOWVP?=
 =?utf-8?B?ZitTL2tYQUxGenZTM2pvdHROUHBsTXRuanJMM2VCTE80N3Z6ZTJjUm9LY2Yw?=
 =?utf-8?B?U010a3VHekNMam1GU1VnWS9PY1daajVaWGtNM3IrOTk3Y2Q3ellNOUNLQ0Rx?=
 =?utf-8?B?Z0JRSUM3ZW1OeXkzb3FJZzlhaFA5UzRYWTBvejQ2Z3h0VDV3QUVqRGVsY1VN?=
 =?utf-8?B?Wjk1UnZWRnJFMFlCZE95N2x4V09UQWIyM2NKNDh1UUJVYXJwMS92VjN0WVp5?=
 =?utf-8?Q?u7vkFrgRt26p6ahaDQT2i28=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a657098-6384-4dac-2a82-08dd8e612324
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 18:50:01.1896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgyC5G0Xz0Ljop9vwJmzcslCSIFRrXURbe4TD1RySF5Jruc5W1ht7H2GRo74AsuiFKFKB5Mc1oCuPoZiN/RH2zpGdGjXfGe8GZCmEbsW4Cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9013

On 2025-05-08 12:03, Steven Rostedt wrote:
> On Thu, 24 Apr 2025 12:25:42 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> +static void perf_event_callchain_deferred(struct callback_head *work)
>> +{
>> +	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
>> +	struct perf_callchain_deferred_event deferred_event;
>> +	u64 callchain_context = PERF_CONTEXT_USER;
>> +	struct unwind_stacktrace trace;
>> +	struct perf_output_handle handle;
>> +	struct perf_sample_data data;
>> +	u64 nr;
>> +
>> +	if (!event->pending_unwind_callback)
>> +		return;
>> +
>> +	if (unwind_deferred_trace(&trace) < 0)
>> +		goto out;
>> +
>> +	/*
>> +	 * All accesses to the event must belong to the same implicit RCU
>> +	 * read-side critical section as the ->pending_unwind_callback reset.
>> +	 * See comment in perf_pending_unwind_sync().
>> +	 */
>> +	guard(rcu)();
>> +
>> +	if (!current->mm)
>> +		goto out;
>> +
>> +	nr = trace.nr + 1 ; /* '+1' == callchain_context */
> 
> Hi Namhyung,
> 
> Talking with Beau about how Microsoft does their own deferred tracing, I
> wonder if the timestamp approach would be useful.
> 
> This is where a timestamp is taken at the first request for a deferred
> trace, and this is recorded in the trace when it happens. It basically
> states that "this trace is good up until the given timestamp".
> 
> The rationale for this is for lost events. Let's say you have:
> 
>    <task enters kernel>
>      Request deferred trace
> 
>      <buffer fills up and events start to get lost>
> 
>      Deferred trace happens (but is dropped due to buffer being full)
> 
>    <task exits kernel>
> 
>    <task enters kernel again>
>      Request deferred trace  (Still dropped due to buffer being full)
> 
>      <Reader catches up and buffer is free again>
> 
>      Deferred trace happens (this time it is recorded>
>    <task exits kernel>
> 
> How would user space know that the deferred trace that was recorded doesn't
> go with the request (and kernel stack trace) that was done initially)?
> 
> If we add a timestamp, then it would look like:
> 
>    <task enters kernel>
>      Request deferred trace
>      [Record timestamp]
> 
>      <buffer fills up and events start to get lost>
> 
>      Deferred trace happens with timestamp (but is dropped due to buffer being full)
> 
>    <task exits kernel>
> 
>    <task enters kernel again>
>      Request deferred trace  (Still dropped due to buffer being full)
>      [Record timestamp]
> 
>      <Reader catches up and buffer is free again>
> 
>      Deferred trace happens with timestamp (this time it is recorded>
>    <task exits kernel>
> 
> Then user space will look at the timestamp that was recorded and know that
> it's not for the initial request because the timestamp of the kernel stack
> trace done was before the timestamp of the user space stacktrace and
> therefore is not valid for the kernel stacktrace.
> 
> The timestamp would become zero when exiting to user space. The first
> request will add it but would need a cmpxchg to do so, and if the cmpxchg
> fails, it then needs to check if the one recorded is before the current
> one, and if it isn't it still needs to update the timestamp (this is to
> handle races with NMIs).
> 
> Basically, the timestamp would replace the cookie method.
> 
> Thoughts?

AFAIR, the cookie method generates the cookie by combining the cpu
number with a per-cpu count.

This ensures that there are not two cookies emitted at the same time
from two CPUs that have the same value by accident.

How would the timestamp method prevent this ?

Thanks,

Mathieu

> 
> -- Steve
> 
> 
>> +
>> +	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
>> +	deferred_event.header.misc = PERF_RECORD_MISC_USER;
>> +	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
>> +
>> +	deferred_event.nr = nr;
>> +
>> +	perf_event_header__init_id(&deferred_event.header, &data, event);
>> +
>> +	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
>> +		goto out;
>> +
>> +	perf_output_put(&handle, deferred_event);
>> +	perf_output_put(&handle, callchain_context);
>> +	perf_output_copy(&handle, trace.entries, trace.nr * sizeof(u64));
>> +	perf_event__output_id_sample(event, &handle, &data);
>> +
>> +	perf_output_end(&handle);
>> +
>> +out:
>> +	event->pending_unwind_callback = 0;
>> +	local_dec(&event->ctx->nr_no_switch_fast);
>> +	rcuwait_wake_up(&event->pending_unwind_wait);
>> +}
>> +


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
