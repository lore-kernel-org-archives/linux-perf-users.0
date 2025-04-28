Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021084.outbound.protection.outlook.com [40.107.192.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202BE2973B0;
	Mon, 28 Apr 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864006; cv=fail; b=q/xGpiUnF9DdMeTqiFSVfNwhouK9IPhmWOJAjZlc3SACQDtO0ovWUX2Fg3s64YFOzhuglxTPbtl6JEGEDAG+HwpPxEuoc+1bgRD3GzD5pfkGGV3gUSNXFVu12N4BXKG5ElWB9057EORBOYwfWzAmpNF18UT83k8wja8cGUCabSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864006; c=relaxed/simple;
	bh=6QqdASXE+RHGsfAN3NfyI8Ln9eLkpBsie4eIHF5s+3o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JnR9Ji9t/saFbMb75aB9aRpimUaN2mH3Z3REcQQc54iKcsXKswryFyEazoO3iiQlQZGVAh6T70AAlCi/GVJOYj40kKJQwsXJR8it8J9VVnU9O4jpzMdQCiiOT51Y1NDXbXEUqfSCI40cl6onSutL8nWkIS6zFghOo0GGSC+0K+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=U1FuXskb; arc=fail smtp.client-ip=40.107.192.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="U1FuXskb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw7ycORx3GllqBay/n8ndHhAjjkn6i1ZkYJjpxmzcg30CvVRhvFtAQsleJeBxRF7WPZCRe2iXKXFq6+OvJ2zqG11H1WeIybMBHVFjF+VfNNqhsD1iQ1Sk1toXLWALnPREAoOztnANCn5xllMVWps+0iOjGMhp/956o5RnrI3FA0LMQSnjV0ZVNXQQc/FIqfTI6tyQW8EozhBkmO2UOac1VSrsd25sFvbcC5SnpXuB4f7H/7BjGKU6QzeaPkSLbOAgoQeWHORxPBAzj6PCr867mne6hDFqXQMWg4Ezk5nFeGFoOS8OZbXrLGP3Bj7aNUzOvB5vmlOUAOhzjJcbfZsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJGSs3Zfwc0sO05yW5SILDTvLbYctZJBJrx+I97A/J8=;
 b=W2YCvj7koOLdVqcXmefm4Wh3yGI2IGXE7YyXKG1XtHaRKnbIpddUc41bBcEK5QhJ0FX0Z7b7GfIl+5kzcaq4Yof3VM4qZbUkIvtIM1mPDtGTA2z4VNerOEbgvgwxrGmj0MD4C5K2DTS8FqvaOvwRLiW48MZdrFbWHNokTxu019x7XzbiRQ/9C23e8dEDnXgl5KF6FcnN6AAubV6z/19xnXi4GrklHg0uyrm2IiCv42jbNCz6Z+LuIuzSvPJ/1SDSS0XF9HxVzN9vK6pSPP1kcY2nEix/bvxWv7mZhIl/WSwpMK3kXw632/IBDNUzGvHFeor5c27sjIdIrCJ5VEDVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJGSs3Zfwc0sO05yW5SILDTvLbYctZJBJrx+I97A/J8=;
 b=U1FuXskbL3iAVT26Sd8n+gZUdYIV76lGqUSTDIrA8ezfOCN8tRQz19S0nh14UhglwuIrzn133V6dQkAUvPOidEx+iUu4pg8yzcy4czBukPhPE4hJWPLOPai6fs70zSD+1Y1orhhDDEoNz5k9BKHzUVhQ6NNW231id2OOPpuAEE4+NpQNERZ6iGcMiXzZuNFDcLKr2BHl4YKg9zHbIe2l9bYPehW4MHhAtqn7t4NdWPgSMwARThb5uldEIGYQ6HfI6dTq72OR/FwuU6IwolMvKvfZxihfFGtv7jxuo8Vt70dDpIh7MFOR4ZrNm8ekvK4NpbqCLDDHBlVLTX82ddeC2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8273.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 18:13:16 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%7]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 18:13:16 +0000
Message-ID: <0f4cde6d-7726-4676-aa7e-9b24f0a76e03@efficios.com>
Date: Mon, 28 Apr 2025 14:13:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] unwind deferred: Use bitmask to determine which
 callbacks to call
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
 <02339b93-de9a-49e4-8dbb-137d02fc6ea8@efficios.com>
 <20250428125600.1f50f476@gandalf.local.home>
 <ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com>
 <20250428141210.6ef945c6@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250428141210.6ef945c6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 465c912c-5cab-4257-6485-08dd86805903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akdrVHVLZFZhd3lpTWl6N2N4aHVpa0QzYWxUaE41TUVXZ1oyNlc3QnMxNkVN?=
 =?utf-8?B?M2o5cUVzU24yWUx0bXN1ZW9uUi9ES2pySG9ZOWxlYk5DUGU3eTJhSXZ4TWk0?=
 =?utf-8?B?ZkM5OEt3MWR3QmVyL2tyc0lJNFVoTTdoMmUvOWNnZjJTTkpSYVA3RnRXSlpx?=
 =?utf-8?B?K2RlYUV6endoczFpK09EaFFtdE9veWlNTVhWQlFmRThsSnhGb1Ruc0ZCOVFp?=
 =?utf-8?B?TE0rTitoOGxZSGZGMjRTQThqSzFVdENjM2dxdUxEZWoyaU5kT0Jrd2NBYXJw?=
 =?utf-8?B?UVhrdUd1MGU2YjQ0Qllla1YxWDNBS1BJazk5U3BtWmptSWxmNUdyOElxZ1dQ?=
 =?utf-8?B?YXlFaUxBcUdsM3ZwL21wUVVWNmpLUUpZSDhPeUZ2QU9iOXB5WmN4SzQrRHJQ?=
 =?utf-8?B?cVZzQjJrdWtRRG1rN3NMWlkyUVZBTVpNOEtqYktTeEJSYVNIYlY1ZjBjb01X?=
 =?utf-8?B?VndFeHc3MnYxSkJ6MGdxOFJXOUZlRDVWUUVNb0VpNUNvbFlKbGRrYmxWNith?=
 =?utf-8?B?ZTVnSE5YRmRkenNHZ2U4QUhnTW9YVUhXTk5ER3ZEQU8zdHdOMkF1cC83RE4r?=
 =?utf-8?B?NlgzSzAwaVdVc3ZteW4wTk5rRWtjVDhLaXVXdVF4QWJWRGN3SSt6YmhzdUtM?=
 =?utf-8?B?Y0puWjRpMWtwS1lldFh1b1dXbFI1MVh1elgxcGpVYUp0M1BDV21MSks5SE0y?=
 =?utf-8?B?WGpBZmdYWEZXRGxZQjA1eDNIY2J6c3IrQWs4ZzZOMy9QeUlQZ2lYYldhOVJw?=
 =?utf-8?B?R1lJN2FLeXBVUG1WWHQvbDlUS0x6cTU0NWliUEh5clVhWlNWaS90NUo0ME1k?=
 =?utf-8?B?My9ReE1YbUVXL2pyS0xuUWd6Q2F6M1I4dVZ2ejVNTE9vOW5WL2hUS3MwRHNK?=
 =?utf-8?B?MTlubnR1dzduSkhTTWlPS3JNUkNBdWppWlFiaUQzc3NDek5OTlgrSzVIUWlm?=
 =?utf-8?B?NDhBQlkwUktwNm9NcHRvaHluZjlMWmVPd1FxZ2VTNXdrL0pBU0hBOEZHU0JL?=
 =?utf-8?B?ODBpZWlQNzJZSHRRVGovSkFJUVNRVkhjREhqVy83TnFyK1dmVEJUMkc1aGIz?=
 =?utf-8?B?eEcxbUhremdaWk9iY2hkYW83YkNoMjZzT3dydW5uWHZGbnpuSGFNdklBWC9Z?=
 =?utf-8?B?cHNLQndVVllLbmdhU2RSYWdxUEhVaVhvd0Jxc1NSeFdvdkQ3YTBIelVKQUpU?=
 =?utf-8?B?T0p0Skw1NzZLMXRFY04zQWNpOEl1c3l5RDluNnQ4YXNSQzAvaFgvRUJsZWRw?=
 =?utf-8?B?b3lnYi83bU5lVm9mUVlxdjJ3aWN3UVhCcFhqUWhyZDlkRHN5cnFQaGIzdzlN?=
 =?utf-8?B?MW00SThVVVI1ZS80LzZYTHlPbWk1cmR4L0hjZ1J2T2NDVGFoUUFSeUJRNDN4?=
 =?utf-8?B?bTY0bDE5aU1IeGQvTzFVYkFrYUsxTDNGbmVJbXlWeGdrNW5USE1OZVQzVHk1?=
 =?utf-8?B?WjJYR2tsc2phNDlZdER6SWJjcXlESnNpdTR6U0FGNXI3czdZZ1hOVkhKeVpj?=
 =?utf-8?B?NE1hTTc2VFVIT1V0aTVEL0JoTWR0U20vWjFFbmYydjN2b005TitUbmZxZkdl?=
 =?utf-8?B?TFZKd1VuWlhMRVR4WkJVeVJrcEtodnVnTXpQWXVaaWlVaTk0NTZPVnhqMHlG?=
 =?utf-8?B?Y2ZmL1I4R1Y3c1R3YkdZdzI0azA4VVIvRURnWlI5bTd4dVZuRVB0NXdLUkp3?=
 =?utf-8?B?NTFDeGl0Q3ZLMEJmclorSFQ4R1N3bCtYcWdSMTB6ZnpXUWp6VE5ocCsxYVRM?=
 =?utf-8?B?c28rNXJqcVI2anRoUjlDTWhHSDdLcHA3YUttbkcvZU5oUGRrY3dZYWZUMWFr?=
 =?utf-8?Q?TOo4OCmITw8iYOQJokmlWeIrLaigl22m+7RdA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVBKM3VNY3MwR1YzT1dad3d0N21SQmJtNHJWWUQyT1d2RlVzc0RLZkFQZUJX?=
 =?utf-8?B?SFdVZWhuTDkrdW1JenliMGxQOU9UMWUySmNTRVlPS2tuUjBGWTNXcU9qbkpC?=
 =?utf-8?B?S1RlM0JMd2g3Qmt1U0R5V3d6ZElsTTFwQ1JKWnFqaDJkRENYVHA5ZDJUbFlC?=
 =?utf-8?B?akYvWmg4S01YYUhhNkdiRlRzcmpqWE5ZK1RVWXVrenFCckZmTUY1UStRUVJJ?=
 =?utf-8?B?SVJYVDRPVUpkQzJkVHhNaFVmT25KM2QzeC9FM2cwZ0RNWkhvRUR6cG13UndG?=
 =?utf-8?B?UnVZMDFsZGhKeXNVYVE0aDFvbG5jVEIxTW9RZjZFNlB2UzRrMFlLRzhQMTYr?=
 =?utf-8?B?T3p3VHl1bTA3VC9JaEtjNVR2dEc2OXFJU1dsRUV1STVtQjZQZ1FQZTlLOFlJ?=
 =?utf-8?B?UWpacVRzbVZwQnF2Y2I2YWtmVnd1SW02TG9rOThyZSswcGc2dU9DMjNLVldO?=
 =?utf-8?B?WXFHc25kR1pIK05uSysxblgxTW9rc0JEUHhwT1pFZTEwZHF1MUlLQXhBb2pw?=
 =?utf-8?B?NXRuS212R1ByZG84eXJkR3loaURxWDVrb1lDVk1OM1gwbjZzMFdsL2lZSEZM?=
 =?utf-8?B?YlQ0S21RL1FRaVh3aDBpdXc2ZjRMNWxVa0toVW45OEdQaEJHUU1OWFZpcnJM?=
 =?utf-8?B?VGJDV2JuL29oWjNCMDYydkt4WUp0YzJPMjZYVVpiRUFSWFVtL28xQ3k5eWVr?=
 =?utf-8?B?b05FU2hPWitCQmx3SEVQMHNEK3ZTWUs1RmNuUStWWGdXZmtZZ1FKOWU2SG9K?=
 =?utf-8?B?ZnFya0I3dWZRUnFYays2UW5LMWxjUXJXbmFDRnZKYk1vWTZ0RUZYTFlRYVFq?=
 =?utf-8?B?MTgvSTM0RWtGZVZrMmt1RDJWc1pRcVIybFZIdERHQytETXkvZDJTampRc3Vm?=
 =?utf-8?B?cmd3Ny95RG9BUlc5dDhLa1NhZld3T2ZHcHp6eGpiYUJDb25WQ2JMQVRlbnh4?=
 =?utf-8?B?ZUpqQXhqSE9yMmo3M2graFNzN2dpMkVVR1pQaFlmU0grNjVlVXArME12Y3Q2?=
 =?utf-8?B?V3AxZ2JlT1VSd1kzSlFzRXhYYnV3YnFTYzNjUGtCOEZEUWdwSGpwZ1g5RUVv?=
 =?utf-8?B?MHdSM2Vaa08xWVBMK242bVBqNDh0MCs2R3B2QUxIeDdPcUtBdmNzU3d5cVJx?=
 =?utf-8?B?dDB1MExPZERQZjNwQzltY0JkWnRWOXp2b1hLeEFacVkyUmw5TG4zeW5QUDB0?=
 =?utf-8?B?dXRBRE9LSW56OHdVbGhqRjV5akhzQlEvU0J4TmNRY05kRm1QVFZyVWtlTk4w?=
 =?utf-8?B?ZXBoQlFxSUNic0R0Vnd3SXdQU3pWUUhoV1p3S2d5TUsweHZUamNjU242bWxH?=
 =?utf-8?B?NFYwajhlUVI3dzN4VDArNFBVMkZDQmRqMDVMK2lRVXVlajFPajlqODZwSTVD?=
 =?utf-8?B?Zk1PaWIvZUp1Tk9UeUlKMU5FM2VZOFFmYm9CTWJLczNrbUQyVjlNZ2RFcm9n?=
 =?utf-8?B?UW84WUJFUkd6cHl0WFlxWTNraWxDQUo1N1FZTFpCTG1tTVAyVjhLbHBmNDNY?=
 =?utf-8?B?VnhOb2dxOUFMQVdkZmdRNzVwQit1NzZxVU1WY0tjYlEwa1I5MSt5VGlwalNN?=
 =?utf-8?B?VmlVc1phTXhneUJmU1VxM3Y5UU9ScjFhNUZTY3pteURmQUtNSjFjOThmeEZn?=
 =?utf-8?B?OXJrTS9Za0lEMmZlZXdpOHFOWVNsaW8xSEJkRnpSbUtaL0l1K3U2YUMvMGtU?=
 =?utf-8?B?TTNkbVFuWWQ3RmRvV2NkRFVFWDU0UDVSSS91eE1jL2hDdmVOS2R3VkIwQ0Vw?=
 =?utf-8?B?WnpKVklLb2phZ3B5QW1oeXlPcnFZSUIyY0p5YVdhc2s2czNXeXJweERhMVRm?=
 =?utf-8?B?NE82Z0FxdzlsNnBYWEpheVBXcHNCNktSTWIvZWJMQTdDRFl3aVFESitIUytF?=
 =?utf-8?B?UHI2OFF2NGZOKytsK2VjQUFXN3RVNGR0d0UrbHcrT1FVdnVmWUhHa1U1V3N2?=
 =?utf-8?B?WW1tV2U3WThIQmpSTXlXalRpcnAvbGpWNFo2QytOSFQ2NUt3SVhQWnpiSGEz?=
 =?utf-8?B?VFZqVnV0VzV0aVhmRnkrRnFvNDhMc0RBSFdKUkhJV3RBTE1KdUhUQ3lFSFQ5?=
 =?utf-8?B?ZmRObmR4U3N0aG9IeXl0VlNHNU0wYWtlclFSd2FQWVJZcEdkeVFhSHEwODZU?=
 =?utf-8?B?d2hmSDhiVkhaVzFWdEFUUmkyMnk5R29zL1VUNlZrTG1TcU80VXZNL2xDaE53?=
 =?utf-8?Q?pjSQhN0Keewj3ul5HPt3JPo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465c912c-5cab-4257-6485-08dd86805903
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:13:16.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpcwOSucqieOBAvEKhsJ/Q9jSiF66rUjzcfCIfiWngOEtVPu/9Xng+bc4noZVZ1NSaqHHi68WgdBcDNoUqqXVySdHYqLWH0S55tb/Dyv6ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8273

On 2025-04-28 14:12, Steven Rostedt wrote:
> On Mon, 28 Apr 2025 14:00:07 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>>>
>>>> It is enough to guard with RCU ? See syscall_regfunc() from
>>>> tracepoint.c where we do:
>>>>
>>>>                    read_lock(&tasklist_lock);
>>>>                    for_each_process_thread(p, t) {
>>>>                            set_task_syscall_work(t, SYSCALL_TRACEPOINT);
>>>>                    }
>>>>                    read_unlock(&tasklist_lock);
>>>>
>>>> To prevent concurrent fork from adding threads while we
>>>> iterate, thus opening the possibility of missing a clear
>>>> due to a concurrent fork + set bit.
>>>
>>> A set_bit only would happen if the callback was live and accepting new
>>> callback requests. It's a bug for a tracer to call unwind_deferred_cancel()
>>> and then call unwind_deferred_request() (which would set the bit). We could
>>> possibly set the tracer's unwind descriptor id to -1, and do an
>>> WARN_ON_ONCE() in unwind_deferred_request() if the tracer's id is negative.
>>>
>>> The loop is called under the callback_mutex, where no new tracer could
>>> register and be assigned that bit.
>>
>> Ah, that's the piece I missed. The callback_mutex prevents reallocation
>> of the ID by unwind_deferred_init while iterating on the tasks.
>>
>> One more comment: if we change the linked list for an array (or make the
>> linked list an RCU list), can we remove the callback_mutex from
>> unwind_deferred_task_work by turning it into an RCU read-side ?
>>
>> Then we just need to wait for a grace period before returning from
>> unwind_deferred_cancel, which then allows the caller to reclaim "work".
>>
>> Taking the callback_mutex in unwind_deferred_task_work will end up being
>> the single thing that does a lot of cache line bouncing across CPUs when
>> hit heavily by tracers.
> 
> I'm not against this, but again, that's an optimization. I want to keep the
> initial code simple. And then add the more complex optimizations when this
> is stable.

That works for me,

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
