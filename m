Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93728345CCE;
	Fri,  1 May 2026 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629297; cv=fail; b=Qs2O8WGOfQZfHLNwgonIOfS8aW2v0Kx32b87naJ4DAw2McZ92DzVdTrkG0ldMtoOs+QzvLexZNRMEwVuSxORL/dFH9i7jnUeaUzaydUwIcMaqPsgm4PCWFETcAoC2OB7SQ8ILHpFr8JJ4ezFxLkGZfeoY9FSKd/jszrDNIAd4Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629297; c=relaxed/simple;
	bh=/SMR6eKtPgBh7Z6dA/3baKdDkx9ChecICahB8dDewGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ky0DfD6XCRjuDSJqYVNvcNENO0g9roTPBapqCOhPmiePiictLUV2yTWIuuI1WF9wv+bodsAkjXHfCtVFZNSzQJ+hypEuN9kz83d5rmyb3v0bw70dgydiUebAy4vIwWCcf9usQU2m7SEwVXDpJncksX+NCz6aDwBVRvRdhhUCXls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=JOiVy5F9; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="JOiVy5F9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBOlAA9d3nFyha8r7Mr+MFSqoVaxu7F8Fb3I0XtvYo1L+XTBEA6gql3JTp5bhLxCQsvvlc0LrAGMxgBVPkFkNn9Vfbwx3rg2DMbgfIXk3jYxPIhYdr4HXmy/DGhDMCyV+atbpNHHFy4COTKOLAWSCZQVy9U7oPWvlZXWa5ftBTsVaRT2vKnCvIRxUNDwJ7Y74OK7dX+KUrg9FjKDNaNL2WyGaWILdPIhiVk7P1mzExMRzIQeI498JStSep5QsxYSrgwEklpITaH6h8VXNfkKYHt5YZWGYVv5bRYm0WktS8vxkNUQcZ2GyF8/bjlJX5Pa2oF/vvFURv6OqRG9cmGjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVh18dbQkIUQXPMSoTzzeNJ7COJOHTfURBaWpeEbNpc=;
 b=Sieh9aTWrqF1em+PQZTK7jxlgl4AWzw57YSBhfsXlXGdrCG6KhMSmf47X6ApSxUR4MJHj7FlxbPDg0IzmzlQ7H8HBhB0EK4ABubudeHMDnwOLIwornG8ADTVR5u+EjpL62yQKGYfwPgihobDJIJC3MrBL2RK9vjMr+g8XyAQOQ+RBr035f8WscwaMF2KTKPUy6OU+EL5n5MKqXxa82ef0UlC4EJ8FktyvKl8SXMRovdMETtJ4SlO/Hmx501wEudP7nSVO8zspQAE4EussyUKOHW7qK0fkpyCaibF+ed8an/j8+yanH+fa7/qyiiRVwFjj63AMq/0rwB7VEeDw9cLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVh18dbQkIUQXPMSoTzzeNJ7COJOHTfURBaWpeEbNpc=;
 b=JOiVy5F9LwZuVx0t9PkHiqq3auLHJ1W+dWJ5xPza+5pm+bUutSC/+8gSVZjKt+Wzbc1bN0x5sSUCJxJrrA9ElRKkenVbJrsyC4UU7cChhMSA3gbGEkDIsb6yY54lPkQkzHcbp+oc7yke3HCqzyo8Gz1VXQPKQv3tIeXXzXob5zw8fsYAd7PDWpg5FBtdz0424ujedsihS+R/KqPwMRI33AZVPLf7aNmj5KwgZ5JJnNmhl/gQnJfbb53tj42wGd8K9OynxgaGnGl9V0nSGCtKuNxWJR9Z09fQ0pfdSOdrb0EQbt9+d2kJpT67i6OZgkgksINcr3YbIv5T+hK+hMaesg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:336::8)
 by DBBP189MB1163.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Fri, 1 May
 2026 09:54:52 +0000
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884]) by PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884%6]) with mapi id 15.20.9870.020; Fri, 1 May 2026
 09:54:52 +0000
Date: Fri, 1 May 2026 11:54:50 +0200
From: Fredrik Markstrom <fredrik.markstrom@est.tech>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Ivar Holmqvist <ivar.holmqvist@est.tech>,
	Malin Jonsson <malin.jonsson@est.tech>
Subject: Re: [PATCH v2 1/3] arm64: perf: Skip device memory during user
 callchain unwinding
Message-ID: <afR4an4IkuvjwOog@elx-5cg6022w5t>
References: <20260430-master-with-pfix-v3-v2-0-bd526ec04a75@est.tech>
 <20260430-master-with-pfix-v3-v2-1-bd526ec04a75@est.tech>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430-master-with-pfix-v3-v2-1-bd526ec04a75@est.tech>
X-ClientProxiedBy: GVX0EPF0005F6DB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1f4) To PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:336::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP189MB2611:EE_|DBBP189MB1163:EE_
X-MS-Office365-Filtering-Correlation-Id: b90d239b-b01d-4970-695f-08dea767b0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZLdLqKThD780R8STqP8ZvZX16USIfy0wyX/QNFjyoH5kKKDn6ykFQuaSMFzYz45phWBFG/Ca3V0/bfgUDhsZ39OpuY3BqKTg8el/1WPpa3dITfaqcxKOLvFtjXB6SivBTdhtD2dREOzCym5kXRgwzDjo2PpTy+q9/in9TfkWbGToTTDtbFmmu/Q8f63gvioMEmSo9/Z66eGbid/qmedsyjz+gpRO7+ad891UYv2jqHA63huiSVsTlmIWCfuGuw8P6tV4y+kNdGsfb6+ndvImO+kT9GQ3NEzSQu9z/jFqR1t8nt+1VvwJqBhIBFyv2cgM8PCN+QZpgDzIZJPw1JpTgJd52ZfOyWPEXjU9LOhmBketdqeirgD0+qjXfL9yTrYg77eNkunppnXlWvwjGFd7k4bO4yvL/rhw6yS7IGDzJBrVIwklAczTIcmdF5kdjGr4eaQfbaEY7g9K22oVRVxwfJAheTulRZ8FFfgR7kukdxw8f0BOObj1fYeBHQKp31Ms6nG3F+iaelawKkicYO4T9vSiZNx/IrKQv4qzr9OdIqYvsij6v7gKnB6r6RPkL6jrnxaGnaz8cstsNIKWLWi6eXVfkka2MUEiSvXuwou590y17Gslg8RyPUcVMZnJa0vetK6pzU8LxNqP05N/Yr31X2OygPSeLNa8H47HYntrnyAG1NR3mu8Jv/SROl3ac2I2WxeLhKZz6o7AU5THt9QB42p61tu4tq194N8xwnAFldI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWP189MB2611.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFd6OHMvNU1PalpQNXpQVFdlbUcrR2N3RG5EUVJaTm16T243QzIzWURGVDRZ?=
 =?utf-8?B?cTVmOWNxeWowVFV2ZnBsbGQvbGFKT3JtSUtZUVhXTElVdWxZNlhtUGVZb2FI?=
 =?utf-8?B?dGlkcjNCZmZGRWZ4QWE2K3dlUm1ON0JNb1laQjN1YmdOK0xRUTAwV2x1dXAw?=
 =?utf-8?B?eTIxSTY2aUloM1pSSld1eng4dkdsc2dTTWZ0eTdGRGFmN080c1BKbFluOWtP?=
 =?utf-8?B?bXdaWDlTVnJEVkd0WXdFeHdnOEoySVIwUUh1cndQc2hQUlV5U20zOTBFVC9G?=
 =?utf-8?B?SGFIcFJWYUV0cWI2QUhRb2ZGSkg3eVRFVGhpd3VxUU4xY2xxVitRVmRpd2ky?=
 =?utf-8?B?SlJYbUJZTThhcU03Y1pUZW5ndmRuckNoZjVQeGk2WEYxSDBwQXBPVDczN01U?=
 =?utf-8?B?SWg1dWFUQ0drNnBicnNkNXdPTFg3bytBSzViZnRoRE96ZGJ4OEVpSVA3M2xE?=
 =?utf-8?B?aU9ZK3VnWnVtUlNENWZ4N0s0U3luKzZ0MVFackFkcjNIem1MYUlXc2lsbnBa?=
 =?utf-8?B?QitvNlNTU25DZGx2SUVMN1NLSGNrcmlYWC9WZjhlZ3NNdUlMU1FEK1dZdGlW?=
 =?utf-8?B?TnVGNHJHcnpkNzh1WGxCSEVybHZTck1tNnRuby96RkRDUlF6OStGSDN5V2hN?=
 =?utf-8?B?ZWpvc2RRNmsvQURJUzcxRjlEZ1gxZXllVEVtQjB3TjlmWG1JODMydTkydFNm?=
 =?utf-8?B?YlllSENJSHBXVTBMQ0NkR3N5SnJ6d1hyR0lyRnVrRlRvUVJyR0Rpa2U2aDZh?=
 =?utf-8?B?VUlEUlBta1FHYkhpbGZMdHZNb2F2ZUFieUZSaTFTZ0s5T0dqZE5OSkU5NWdX?=
 =?utf-8?B?Nk85VzRra1kySUZTRkw2Q20zd2o5b2g5OTRoeURJSk1YREFlNWd0U3JUSmtl?=
 =?utf-8?B?R0ZNTkNpcDBHY29VRzV4S2lnVVgzMGRTQ25YL1RoVjhlekFoVzg5VzZxMlJh?=
 =?utf-8?B?ZTl5WEdZVk5uV0ptZkR5WitPS0h0TDhlamlzQ2Qrb2g0Q0MrNVhmSDVROFZX?=
 =?utf-8?B?TGp0V3VKSVFxOXNWd2h6L3BVZnIwTW1UdFgvSHVvTUtaVEJNaExaRXFGZWNz?=
 =?utf-8?B?a2VGd21ucnZmRlNMZVl5U0JHUExncXgzMmRMSm1QZVVIaGxMRGJkSGtNQU5B?=
 =?utf-8?B?UEl4R3dONjc2cVlqcHNMS29TT3VTa28yOFdRWUlrVUpqdkVMT201dTVhU3ZU?=
 =?utf-8?B?TGdIT20xZDNiRnJHZ2JzNkMvakZxUGtjUEY0Z3ZMWGhRNk5RY09EekRKSjJF?=
 =?utf-8?B?OWNoekJYOWhNL2VyQkVwV1dHL0tyVDMxcXE5NTg4RmJvTlVwR0hCa2tGSG9w?=
 =?utf-8?B?RERCN2RwZ1ROQ1locjRFS3NvaHhxcmRaR1d6V0RJTzhzMjduVU9HR0o0Qm9C?=
 =?utf-8?B?Zm5CQnVONXZJLzFrYWVaR1pzb0dkaWJXaEFFZVhnWnVTUkl2RWVjSW9wOFYy?=
 =?utf-8?B?QTlsOUl1ZkU5YXlSS2NNZ0lEUVJ3NUtSYm9pNXpWM0JhNDRKdi8wUGtUZi81?=
 =?utf-8?B?cXhlakVERzVGZ093aHZ4U3FBTzdrM2UrQmNWZXN2MmY5dWpvWUYrdTRsd2tt?=
 =?utf-8?B?TDdDTmtSdnhYL09UNHo0ZDZ2NElpcTBPeFdncjdTc3BVMnlZeWNxRjk4WlZY?=
 =?utf-8?B?ZXJxRVdacFdWQXFGZG9xaFU3dGN1b2tDd0VJZFhreXNoNG4zaTk2cGlzMXY0?=
 =?utf-8?B?NEJyUnZPZVFrTHFVZWpzWTIrNjJGNVM5ZmZneHNOYlQ4Zk4wc0J4Y0VLMXpn?=
 =?utf-8?B?NmttNDVZcUM1M2NmTDV2NmxwelpjNEZDT1E3RE82ekQxSE9OUWdBTWcyaysy?=
 =?utf-8?B?ZGM2R1ArL1ZESE9pUVYyT1lHVmJBaG03TFA1d3hab1l6UnJlUDRqbUdOOWZv?=
 =?utf-8?B?S0JJUWJtUjZkRk0wUzY4QUVRSWJFcEFZWkdEZ2pMOE1POFZMcElRWnZST0pz?=
 =?utf-8?B?bitISDk5eGlqYnVYRmNiTnQ5bVZya1dseXYrOTJHR1M4QzRvbXJIemtqclV3?=
 =?utf-8?B?WkM2YnpxK3dQNk1nVVB5VFVVaFdoY0Jzcm90bXF2anN6R1NYR1lPNmlQMEtY?=
 =?utf-8?B?NkI3eVo0Yk9ZWlhrOWNnUnY1dDcwRTRXYzVtZHhrOFY5S1N4d2x5SjA4S2Y2?=
 =?utf-8?B?M1pXQjB5eW1YbG9FVUNXWEZ6RFVSWUxTb3RFK0ZZbkoxdWVrWW5iVFQ0NjJK?=
 =?utf-8?B?aC9yRkc4VUV2NjF3Rm5WOXBublNvY21QSzdEQzBraHNqUlpoc3ZHVTZNejlM?=
 =?utf-8?B?Vm54WlVHU3NwaFp0K0R6U0xQcmxwcGpla3BEZzExa1hwbFAxNzZyN2FNN1VD?=
 =?utf-8?B?REp0czUyMmJCZ1pFcDl1dUJvcXpCQmQvb0dlcXZMeDdoWGQrQTZOcWl5N3ZI?=
 =?utf-8?Q?/o2bxqJYRVL3EE88=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: b90d239b-b01d-4970-695f-08dea767b0a5
X-MS-Exchange-CrossTenant-AuthSource: PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 09:54:52.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhFQ3A8xde64tZ/I2bgsOos13st4sEs2+algunZMUh5Ioc2AaOthn6YOabMBv/cgIGGuyPoSuL0bnj0F7DT8Wsc5rTSbmx9rdKStx3UBzc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1163

As pointed out by Sashiko there is a TOCTOU race between the page
table walk (which checks for device memory) and the
copy_from_user_inatomic (which reads the frame). Another thread
could mmap device memory at the target address in between.

Three options:

1. Accept the race — it requires a cooperating thread with precise
   timing, and the guard still eliminates the common case (stable
   device mappings).
2. Use mmap_read_trylock() once per unwind, held across all frames:
   a. Fall back to the lockless walk (best-effort) when the trylock fails.
   b. Stop unwinding user space entirely when the trylock fails.

Option 2 adds mmap_lock contention per unwind. Is the race narrow
enough to accept, or is the trylock approach preferred?
