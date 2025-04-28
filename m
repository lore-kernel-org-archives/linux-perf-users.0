Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020102.outbound.protection.outlook.com [52.101.189.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA351A5BA3;
	Mon, 28 Apr 2025 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863218; cv=fail; b=dcQZd/IygoTWWkyydseQdoiR2CzJ/ECWsS29MKFKL+Ly9N2e2OfMIObafTMxUFm7WRaZXak+yRVRpla2KNANSSfpJbtYZeCMeoSYKl4Ws01OYDp4uck67r4XHXlaYUqOiZCfJdRltHIhz6YZnPxfXvHloQSdewcEKTpYHTgMenc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863218; c=relaxed/simple;
	bh=Jmg8LssqZdeUwGuHAx1rFvL8dqHX7JeveMw0hnLbYN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cgPSGggrEFvVrgSvfgYdnTmEC+GLY+M+PeYimwkflX1XR75UAhsw7z54dtWoL81k4k9h38Zu+XeKKhYr90xhr0mNN0GpRbIWblTPo83gGdacjHmKHBWDh0PCMNcXUFj56MB9UBb6iTSkm4s/IlpR7eUQ+GiYItVP0rsXV9Uk6Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rhnwcmRu; arc=fail smtp.client-ip=52.101.189.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rhnwcmRu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+cHysvUh3fLasqlNkPcr9p0XrFg74nh7JrU4P/SUf6X4vSsrGuX1vuHBWj10X3cSwMnN/4Q7ADJ31ANRk0vydIUO/qnwbWURNPtm++c82841dVYGGvSxjyaJaNlcTLXKG7mLVS+6mB6UseY3A5/z/92Z25YjEoFiHEqSwCI4qHPttTjDhh72Sf1PnnwTHisSMayJe4qXbfBO04Zk9R1SxcAJ9t0IO1Shp0accvVJKvnX4MwuJ2bsn4xY4A6Nf+1/W/25WDUkEuI4gey/2B1QujbIkU84E8MDHpK2EHPphaZtMY7wf27iILW0eEqSbnMV4o7VvoCskQ2BeZQqkm4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxK6u4k0cV9Ef/i/y5nr+UpBpJQFCg0KCgZrlCWjzu8=;
 b=D48XICQH4KktWoPE5rWbgheOSdwDQzpXysvlBtJpsY1XZWjCr2jacgkrRQKlEmVZHNjmxw220Fqa5pqx1CxnPaLteqSdw5tLEu8VBqRfbWvc0+3G/Pnd7opYokZ+44WQWYTGa/FSYm6FpFj10upxG2czQAGAzATWKvF1j6g1boLriRzztbMjmDTSfUpxruPxNWgjMKW+KT512GbRpw+m1Uk3FIC7fTXs0+HjLyZk/W+880MeVhtE6FNzHa8J4FDbLABqjqKsjSY9sv3TI7z/a+hoJwPFguFWRVvwscROAI/ztwr7MhivPF1qW5WQhcXJeIsXsnhaCNo6PVhjqXu++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxK6u4k0cV9Ef/i/y5nr+UpBpJQFCg0KCgZrlCWjzu8=;
 b=rhnwcmRuV2QmiFL9hnK/xg5s4YAYTOEHD66swH0hl2PAy9LYIrs/Ujb4h8bNLte6VDODPnMnYTp7Jbe9dBsr9/R3JQiiCKkBtIbCXeh69XKwJNFSd6aS6869EkXObYB6pZiPjUiqlVJHuZAio5mJQK/FeTMmNhAqUpSEAmQXOcQ82ZOM+648UMqbmjg245sxCcbhQk072EjgK0khcdbfx2sCCkVXkEWNI3t+EGKAtWwaEsZo5ZIUsW2JDfLfv5gd4ScB/0Pn6WC84l9CT5d/XcdpdPYBv+yo2Td0EG0PQ3mOZEJsdJgAhSi7hLHJicPNyiCkRYRatLqNg+YiIvO/Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF1572B6ADA.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::50a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 18:00:10 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%7]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 18:00:10 +0000
Message-ID: <ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com>
Date: Mon, 28 Apr 2025 14:00:07 -0400
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250428125600.1f50f476@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::23)
 To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF1572B6ADA:EE_
X-MS-Office365-Filtering-Correlation-Id: cefc0f86-9fc3-45c7-bba7-08dd867e8423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHh5NWhBMS85bE5PdHY3UElhVTI1dEx6NkhCeWtpS2NIOUd5MDJOZTlmODM4?=
 =?utf-8?B?d3FhRzdwQlU3SlpPRmpRVFIwNDRFQUdNcEVIRU5oNTNKaWJxM2sxdi90MDFI?=
 =?utf-8?B?QWg0eVRiN041MWlDcWd4cDY2UnlXeEc3akNSWHlGWVMyUzdNNW9hUndsZTJW?=
 =?utf-8?B?bVFNUExxSXFWNlRGNHN3Q0JmOXZoRzE3a0xzV1RCTGI1MlFvN3lLcU44TTZU?=
 =?utf-8?B?QWxGTGZoSmdEMjQzVTZwQW1RenlTRTFjVlpVb2VnUlRtMkVGSzZvbXNBMWpE?=
 =?utf-8?B?WExIUkxpcVFEU2xFSVBqVGJMTXFaMTF3WVRBZjQxK0NqYXhDTVhzU1JOanRl?=
 =?utf-8?B?OFBWaHU3c1lmQkQrVENlbDBqbzRERGdhQ0hRSWZBSGFITW1hUGNKK2xUcW1G?=
 =?utf-8?B?R0I3Vm0zc1greXA1V3Y4TUxveUFOZm00eXJZMTBGSkhlMk53bFdkQTJUaEpC?=
 =?utf-8?B?bUl4NXdiZDJwVlJxSG5JblUzTzdGU1pvUnEreTAwNnhFWGVyYVhwL05nWnlM?=
 =?utf-8?B?ZDB3VzVLRFRvMll2RS9Gck0zZUV3RTh0bnh4bC9kbHBCdVV6NXk5S20wbFJm?=
 =?utf-8?B?aS9IRjJXNDNpeGdwd21XaEl6NHdQa3VydHN2b2E0dXFuSHNUM3gweDVPTVd0?=
 =?utf-8?B?bjBSWjVCSE5tOFlEYjNvbTR0QjZUaDRjemNhTFBUNjFJdGdZdFlScDFRNENF?=
 =?utf-8?B?UlpSTUpwZnVrMDJJa0Zhb3ZwWGtCd0h1TFh2emNyT0pBdHRObXJBSXV2T05I?=
 =?utf-8?B?SkFFSTI0MHRtQkk1RzFWUzUrY3Z3bDN2b1krSVV5bHRYejZwZTNBcXdaQUF2?=
 =?utf-8?B?bFh1Z0RKOEhEYzVpb043Z0c5MjdCSkpOQURyVmZNKzJMaVlhOElFNk8zNXo1?=
 =?utf-8?B?dnhKQ3FpUHVidjU2b1M4YkRZUTRsZG95Y0NFRFRwUWg2eWw3SFUySGx2blNj?=
 =?utf-8?B?RzEzaTM3R2Zld3p0V3JnQStURnpiWG5hUnlLdFJVb3FLUFNkckdmOFdjaWJD?=
 =?utf-8?B?aWtpZHVjekovNnFZYTd6RitMN0lmcU8rVmt3ZmgzSHM5K05DT2NLeVlua1M3?=
 =?utf-8?B?dmt3Y2NaZGhCNTU5ZVhQZUk5OER2YVRGam4yQXd0c21kcThWQUdDdXhMUUJ6?=
 =?utf-8?B?YUtHNCttTmxvQk5SZ2dFcTQvb3NpYzg1cGRpNlp1OW1JUGJDcTFxRE9WdGhv?=
 =?utf-8?B?Q080NkQreS9DYnMyMng4ZWp3bWNhZlcrbEp0ZDZxSmtTRVQzZnYwdVlWSnFS?=
 =?utf-8?B?Vnpmd0hpNWZIV2hUM01WeDlKa2h1SEpDVVhRdVlsVjQ5MThQZE0rUVhqZHUy?=
 =?utf-8?B?YytnTExQdFpuUVF6WEFLL09BSE1ETFQrUER5eTlSdXM5bnJpNTlPbjBGeVhn?=
 =?utf-8?B?VHk4WVp2ajV3TURDTGRkNE8waHl6andnVTJvaGljRGN5M0V1YmUzRnkrOEV1?=
 =?utf-8?B?T09lVXVJY0JhTWR0dUlzelYyNllFdEpoVGw1QTNiYWVmUjFneVFlOFJjT2Ni?=
 =?utf-8?B?cDBHR0xmSGNLK3k4QTNwNnlhZ0pIa012ckZ0am5rRjdFRU5PU2JMTHcrMXNZ?=
 =?utf-8?B?bnlMbjkwSnJPOG5rRFhXSUFidzlLYmx0ampaTTJhdnlidFFkdXNGaVgwV2F6?=
 =?utf-8?B?cm1yVlJXcjU2YVI5Y3JGSnU3eWRtbFcrc3ZjaXRrS0lwOGFPSTZydGsvd2N4?=
 =?utf-8?B?RzhsU2gyVkpmVnhPMk92Y1lScXo0ckE2RGR3OVFMYm5tNHRVKzNuUHpTbWJV?=
 =?utf-8?B?WkdZNk1wenVheC81MzNqRFpsNEorUVFram5jNHpUVW9WcmRWUWRBUzJTNHdu?=
 =?utf-8?Q?0s4jaCSHNsg/rUFlHZ17Sqzguk1vjslMYZXKI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE9pWHZQUlp3eFcyY2kxVGNNSmlZbFhjRGIvU0hWTjhBdnVvUW5RTHJqb01S?=
 =?utf-8?B?NmRvdVBrSFYwUlVxN2Zlb2V6RkhyNXB2a0FHakxtUlhCVzRQM0wzWXBNSytZ?=
 =?utf-8?B?TEd5dndhSFJ4T3hIMlh4QUFERFc2aDJFVGtxZ0J4SmYveTF6RnJGR1BBWW9W?=
 =?utf-8?B?VEY1eUJEMDZsdU5Zc2phOGZsMFRsR2kvbWxqUWIxczRlWm01bVJFNHZBUUx5?=
 =?utf-8?B?U1QzU2o5TUZWTFhURExPZDlLcTNYWGlsR0M5dDdBdVFnaWt2U3d0ZWdOY1NE?=
 =?utf-8?B?YkZGc2hRM0tQQ0hUbGc5YlBQZzNiUHFCeUs0VWJHOGJ3OFlqT0RPcXpSbFJT?=
 =?utf-8?B?T2JxQTBSVnRvazU4TWxtQlRvMHZudFRKYzZYMnNCL3hycmVoSmE0RlJrTWI5?=
 =?utf-8?B?bVg3K1dMQVZWaGk2WXBEcldZK2hjWUNOaW5iamRjNVBvZWNHa1BuVS90aUtj?=
 =?utf-8?B?REJ0WVQxVmFrZzlKUzNpdE52K3FydDJpUWhKU1N1MDRLazBiTEJXQU15MWNy?=
 =?utf-8?B?UzZhVHFGVmRoQ0ZoNDlSRFhwTjlQZ0FsaWk2QjNyemJNVU1HelJsVUtXYmk1?=
 =?utf-8?B?NjJjZGRSbTFZVDhURDhrOExjZWt6c0VZVnBoaDNMZUthUUxMUkJMT2w1WHN1?=
 =?utf-8?B?SkxlMjJ1U1VwV3NVQVl4ZkZoMEJiOGpEcWlTb0pLQ2RndmpPQ2tIdEZYdGdo?=
 =?utf-8?B?RjZQYWNGamFzamJYbmwvRi82L3hBSENQRmE2ckxic1FoaUthWXJ2VVFyZVBH?=
 =?utf-8?B?VEN2cklrZ09Bdm1vQ3J5eTdzc2NKVDN3ME5xYWtvQVRMUlo3UHRqNndCMlk3?=
 =?utf-8?B?QkV4UFZ0MmUwUUh1Vmw4OXVEbFoyeGh1QWxxTzJ2SmJQcEt3c1Zlci9LQVA2?=
 =?utf-8?B?NHhWaW4wL2xId3FZVjlTVjdYRlRGS2w0YUlEOGhlMDZWNFZyRHRyMXBac0dk?=
 =?utf-8?B?aFNKb09nUXNxVE1BRkxmYWx3b1lzT0JyV2orRURPRkRJVHBzZUhnSEYyQlFL?=
 =?utf-8?B?M1FtVTJWUXZ3TWZVbFZtNXhNd09QNXd5ZDhLRTZubk4yWCtUVWZFekRDWHN3?=
 =?utf-8?B?S0hlUzBDcklVMzA1bTZVTmVDSnFEOUxzSkZVclF4R3VtUFpuVXMrcGNuN2ZB?=
 =?utf-8?B?OFNXbkM3TG55TGUrclZSaytLb1dpdUZ6WGowN3gwY3Q2U1R0bHNhMHlHc0Fn?=
 =?utf-8?B?VU9vWUt3TFNxRUNNODM3cnhWNW1YMCs2VW4yNlQ3UUJic0xoQVBHckdTVDcr?=
 =?utf-8?B?a0JZVklOTnJEMlI0VjlvWit1YkV0eE1xMmUyb1RXQVdOcFJwUi9tVjVNaVJN?=
 =?utf-8?B?dDV0dGxsTXAyc0FTdXdtR3JmTVp1VXV2M2d0bTFmdVZ3NG5qSFFYUTdGMjZv?=
 =?utf-8?B?QlZiZkRFbFBYN3dQbFBSQlord0pYQlg5OFVzK08vYXRGeXZJQXVkbngxYXAw?=
 =?utf-8?B?WjBnaFc0MWlYZnRDakRWZnV0Q2dvbFJodFdtOTA5aW8yRUlCZGVjTXBGT2dC?=
 =?utf-8?B?VFV6VFhsZTJRUzNKRU04TFU4VFBpOFY3VGhKa0ZXdnFES3UvbmowU0sxVGd3?=
 =?utf-8?B?VTY1ckRDKzhpa3kvSGcwcmVFUkg3SmZCTldlSkJLeVpjZ2lWQmhqdEdUVktG?=
 =?utf-8?B?VldyUUorUlRraWdCNHVuY1Jqb2ZORkZVbThtS0d0bmRnelZ3RklzdXJaV09q?=
 =?utf-8?B?U3FISktxQ3d1a0ZCSnBIUy9RaGV1ajEra1kzT0NST0JRY08ybUNicHpGdjQw?=
 =?utf-8?B?TG5xbUNubEZ2Y3hHTEM4dnI2Zm1uejd5enZBRmlZcE40RXM1c01ualhsZjg0?=
 =?utf-8?B?NXlaVU5oSDI5N3hDL3pCQW5nQlNoaFBKS0p0SWs4dTFncDdsMDhvNTNENWN0?=
 =?utf-8?B?YS9NM2FRK3o0UXJGam4xQ3V1ODJWSzVoVktCbzQ1V0wzR1hTNnRSdmw0L05p?=
 =?utf-8?B?d3Y2dDVZSU1oVTFPbk1FRG1DVWxXSjhDeFhZeFFyS0tlOGlLRDlTaHBDVEFD?=
 =?utf-8?B?ODFiRFhSY1NteCtHYmE0czZuaTdlbHNaSjhuZ09uZUcrcUlaM2NDVmVoc1BU?=
 =?utf-8?B?NGs2SU15Ky9kbTlEUnd2MVVhSCtWYkY5d0ZIUGFnRy8zYUFUZFRUKzBXb2kv?=
 =?utf-8?B?NXBjbkM5QWMySDRJb2p6SUI2b0RWQ0paYjNoM2pPTkJXcktVVlM0TUtVeVhD?=
 =?utf-8?Q?6S1BT42SFaWPVagvY6TG924=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefc0f86-9fc3-45c7-bba7-08dd867e8423
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:00:10.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+tRIJnI4hDxyg6TM8DZsOM6fmI0GC9Sq1i3ecm0AnODlN7oem74HVw87adN0d+Im9yl1pZokBig3vzmF+UHDjJGAABtRImW5AY2YzHe8fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF1572B6ADA

On 2025-04-28 12:56, Steven Rostedt wrote:
> On Mon, 28 Apr 2025 12:33:50 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2025-04-24 15:24, Steven Rostedt wrote:
>>> From: Steven Rostedt <rostedt@goodmis.org>
>>>
>>> In order to know which registered callback requested a stacktrace for when
>>> the task goes back to user space, add a bitmask for all registered
>>> tracers. The bitmask is the size of log, which means that on a 32 bit
>>
>> size of long
>>
> 
> Sure
> 
> 
>>> --- a/include/linux/unwind_deferred.h
>>> +++ b/include/linux/unwind_deferred.h
>>> @@ -13,6 +13,7 @@ typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stackt
>>>    struct unwind_work {
>>>    	struct list_head		list;
>>>    	unwind_callback_t		func;
>>> +	int				bit;
>>
>> int or unsigned int ?
>>
>> Rename "bit" to "requester_id" ?
> 
> Perhaps just "id", as this is only internal and shouldn't be touched.
> 
>>
>>>    };
>>>    
>>>    #ifdef CONFIG_UNWIND_USER
>>> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
>>> index 2afd197da2ef..f505cb1766de 100644
>>> --- a/kernel/unwind/deferred.c
>>> +++ b/kernel/unwind/deferred.c
>>> @@ -26,6 +26,7 @@ static DEFINE_PER_CPU(u64, unwind_ctx_ctr);
>>>    /* Guards adding to and reading the list of callbacks */
>>>    static DEFINE_MUTEX(callback_mutex);
>>>    static LIST_HEAD(callbacks);
>>> +static unsigned long unwind_mask;
>>
>> Perhaps "reserved_unwind_mask" ?
> 
> Sure.
> 
>>
>>>    
>>>    /*
>>>     * The context cookie is a unique identifier that is assigned to a user
>>> @@ -135,6 +136,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
>>>    	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
>>>    	struct unwind_stacktrace trace;
>>>    	struct unwind_work *work;
>>> +	struct task_struct *task = current;
>>>    	u64 cookie;
>>>    
>>>    	if (WARN_ON_ONCE(!info->pending))
>>> @@ -156,7 +158,10 @@ static void unwind_deferred_task_work(struct callback_head *head)
>>>    
>>>    	guard(mutex)(&callback_mutex);
>>>    	list_for_each_entry(work, &callbacks, list) {
>>> -		work->func(work, &trace, cookie);
>>> +		if (task->unwind_mask & (1UL << work->bit)) {
>>> +			work->func(work, &trace, cookie);
>>> +			clear_bit(work->bit, &current->unwind_mask);
>>> +		}
>>
>> You could change this list of callbacks for an array of pointers,
>> indexed by "requester_id".
>>
>> Then you can do a for each bit on task->unwind_mask, and all bits
>> that match end up calling the callback for the matching array index.
> 
> Yeah, I thought of this, but that's just an optimization, and something I
> probably will add as a separate patch.
> 
>>> @@ -244,14 +254,18 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>>>    
>>>    	*cookie = get_cookie(info);
>>>    
>>> +	/* This is already queued */
>>> +	if (current->unwind_mask & (1UL << work->bit))
>>> +		return 0;
>>> +
>>>    	/* callback already pending? */
>>>    	pending = READ_ONCE(info->pending);
>>>    	if (pending)
>>> -		return 0;
>>> +		goto out;
>>>    
>>>    	/* Claim the work unless an NMI just now swooped in to do so. */
>>>    	if (!try_cmpxchg(&info->pending, &pending, 1))
>>
>> Not that it necessarily matters performance wise here, but can this be a
>> try_cmpxchg_local if we're working on the task struct and only expecting
>> interruption from NMIs ?
> 
> Hmm, sure.
> 
>>
>>> -		return 0;
>>> +		goto out;
>>>    
>>>    	/* The work has been claimed, now schedule it. */
>>>    	ret = task_work_add(current, &info->work, TWA_RESUME);
>>> @@ -260,16 +274,29 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>>>    		return ret;
>>>    	}
>>>    
>>> + out:
>>> +	set_bit(work->bit, &current->unwind_mask);
>>> +
>>>    	return 0;
>>>    }
>>>    
>>>    void unwind_deferred_cancel(struct unwind_work *work)
>>>    {
>>> +	struct task_struct *g, *t;
>>> +
>>>    	if (!work)
>>>    		return;
>>>    
>>>    	guard(mutex)(&callback_mutex);
>>>    	list_del(&work->list);
>>> +
>>> +	clear_bit(work->bit, &unwind_mask);
>>> +
>>> +	guard(rcu)();
>>> +	/* Clear this bit from all threads */
>>> +	for_each_process_thread(g, t) {
>>> +		clear_bit(work->bit, &t->unwind_mask);
>>> +	}
>>
>> It is enough to guard with RCU ? See syscall_regfunc() from
>> tracepoint.c where we do:
>>
>>                   read_lock(&tasklist_lock);
>>                   for_each_process_thread(p, t) {
>>                           set_task_syscall_work(t, SYSCALL_TRACEPOINT);
>>                   }
>>                   read_unlock(&tasklist_lock);
>>
>> To prevent concurrent fork from adding threads while we
>> iterate, thus opening the possibility of missing a clear
>> due to a concurrent fork + set bit.
> 
> A set_bit only would happen if the callback was live and accepting new
> callback requests. It's a bug for a tracer to call unwind_deferred_cancel()
> and then call unwind_deferred_request() (which would set the bit). We could
> possibly set the tracer's unwind descriptor id to -1, and do an
> WARN_ON_ONCE() in unwind_deferred_request() if the tracer's id is negative.
> 
> The loop is called under the callback_mutex, where no new tracer could
> register and be assigned that bit.

Ah, that's the piece I missed. The callback_mutex prevents reallocation
of the ID by unwind_deferred_init while iterating on the tasks.

One more comment: if we change the linked list for an array (or make the 
linked list an RCU list), can we remove the callback_mutex from
unwind_deferred_task_work by turning it into an RCU read-side ?

Then we just need to wait for a grace period before returning from
unwind_deferred_cancel, which then allows the caller to reclaim "work".

Taking the callback_mutex in unwind_deferred_task_work will end up being
the single thing that does a lot of cache line bouncing across CPUs when
hit heavily by tracers.

Thanks,

Mathieu

> 
> The RCU lock is just to make sure the current tasks that existed when the
> loop started doesn't disappear before the loop ends.
> 
> -- Steve
> 
> 
> 
>>
>> Thanks,
>>
>> Mathieu
>>
>>>    }
>>>    
>>>    int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
>>> @@ -277,6 +304,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
>>>    	memset(work, 0, sizeof(*work));
>>>    
>>>    	guard(mutex)(&callback_mutex);
>>> +
>>> +	/* See if there's a bit in the mask available */
>>> +	if (unwind_mask == ~0UL)
>>> +		return -EBUSY;
>>> +
>>> +	work->bit = ffz(unwind_mask);
>>> +	unwind_mask |= 1UL << work->bit;
>>> +
>>>    	list_add(&work->list, &callbacks);
>>>    	work->func = func;
>>>    	return 0;
>>> @@ -288,6 +323,7 @@ void unwind_task_init(struct task_struct *task)
>>>    
>>>    	memset(info, 0, sizeof(*info));
>>>    	init_task_work(&info->work, unwind_deferred_task_work);
>>> +	task->unwind_mask = 0;
>>>    }
>>>    
>>>    void unwind_task_free(struct task_struct *task)
>>
>>
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
