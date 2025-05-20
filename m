Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E31EB5DA;
	Tue, 20 May 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738901; cv=fail; b=TFReCSZ8V071pMqmio3YYtHWNeEAw5K+WIp2ppaavi5lZh0/O1xrM+NwgzqE4C0uZBaFRwnlfop5WlTqcyK9FvDllo0ULk7FCWSnnqh2kmqbOVYsohGoPy9YscZCFvbCSDvbq7FBpqzpsMQlZr+CSL3oNWRXu89qzeuKO6Z6m78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738901; c=relaxed/simple;
	bh=yPPVfOyOGUhfwNjESjZykWRu/FTBfOeipDaDB/LItw0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k5Fs5O01GC6PJSkjp9vjICCqpAcXvkODoz0uVasOr9pu2Fm3+t9yXv/HBM74ptgqKFNR+TTKTWmCCgBTEp2lT6mWAIL4sbGt/8J8cDm6jW5Eo2DJx6QJ2XBy4Ssp8NE5sQERZGDalSjIMxDEeJp/HufNHyoZI7jC8i5HiyZprs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pf3/LHz0; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pf3/LHz0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOCf/srJAs0s5QGGBMON6XETVT83/VAV5zFRybDejAQcN5/piLCl3xT57l1eoCzqU0DeeMKapcKS1WBOlL4jV8ZZ6k9JXDnw8XjDUnC6mb4TcFUQtaJsPqIfrH0KplRemj3l/4Ge84Hbym4q3We9Mf63CIwhl9UYBX1WeS2SkliGJliyB63M+MmR5bR4lRNSwyE/1LOYi3AryW359O00e1O94y6HpEZgxBuLN8325GhmcAkm5f00YI41lxULfogmoJpyKO7VhdDohaX5Oebg7pTId1VWTAGTgkMBB8cBY8NMv2KoE7sKDcsaHQqRWEwiTqXoLxrNWoGjgf71Chbyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtZsqtC7WCi8rTmwpWv/LIyxKiagDw5WsQnAuq33mqs=;
 b=o7WkrJC2zohrmVKuTnrPzKhCZw7pqhyU0zG8e4Cp39jkwpvs55gnEspBFVcR8wqEjwJ+CgLUHpgKJvvcjEmbrOcKUg8R1fQ7Qe+KurJDhZ3TvgtidBHKMWeKPlMlBoZdWgbBCJAf+2rablnDLWN31tz3nhpkAEgisAgCBVFBTyHZgHKS+VA8OHjzCqE1kafJiGSdDXL+1aVbt61XVdR1lpJ/dx40Wn8O+s/Z/3HaYpYVwjuwlqUjKUr/7KAe0JV4UsVvW05gps3Svo/d3JllMT2+/TW/hxwt59H5CfE+N5as9evZAnUfCbXxllktHym1fZ3z1+XyJWqEWFURzmk68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtZsqtC7WCi8rTmwpWv/LIyxKiagDw5WsQnAuq33mqs=;
 b=pf3/LHz05HXntxZK2Qs5RiYUaoouzP2s8SmB6hIuFyVMK354WFyRUYqUa4P01L7HjoO2oJHGdrUSH/M7O+XHqBInXcZXN0pSf7BeivtkMllsbW9riclGKoDwdNAgjsp7brZ71aPopPq+ZrjglvOkiqWxVhE0x5H9VPI1EusJo9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 11:01:37 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:01:37 +0000
Message-ID: <804ac0d6-22f7-40c3-9ff5-e5f9d863d37e@amd.com>
Date: Tue, 20 May 2025 16:31:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: IBS perf test failures on 9950x3d
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <aCfuGXUnNIbnYo_r@x1>
 <33e86415-c90d-420a-b7a8-6a360769aea4@amd.com> <aColYM3RqE4T5t5c@google.com>
 <aCt4akGLsuuC4aLP@x1>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <aCt4akGLsuuC4aLP@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 662276ad-8584-4958-21a5-08dd978db108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em4rMk9wUkNjd21DU2UvU0R0dWk0UHNKTzNsN3lxcTZpdExqWjl6VE93cUxG?=
 =?utf-8?B?S3BqYlhuS3ZaY2JjOVgxQjNJU1pRVG1EdUpJQ0cxNzUzaDJyVVh0UlA5dlV3?=
 =?utf-8?B?U2RQbmY1RDVqNlFQWUx2UGwrdm80RnhxZ24vWmVlZHZ2YnZlL2x5em0wb1R0?=
 =?utf-8?B?L01LUDV4Wk8xZWllQ2JUblZwWWpoNmoxWU9tYXJFNHhVZGhIbEJjOFRvYVo2?=
 =?utf-8?B?T1dNa0ZvRjk1dlhCV09Raml4ZGpiYkZDT2xlNXFiS01RN3RFK2ZvQ3kvWkE4?=
 =?utf-8?B?cVVpWTBVSzNzU3FqSUFkT1p2SmdoU3BTRnB0V3FTRU01RFRsaHc2TWFBNW1i?=
 =?utf-8?B?Y0NJSm9hRzJkbWQrQ3E0NjNrbktnRCtSYjZCMFc3WURSVjZjNUR2QW16VW8r?=
 =?utf-8?B?dTRVS2l2QmdKa1JWZEJWUjJjTGE3RFdYK0hxc0VjTmNjUTd2V3JMZ3Y5cVRR?=
 =?utf-8?B?bzVqbkpRT0xpRVZsTTE4OWxwc2VnVmZpLzVodDZqVkY2UTlkTWorTmFHU1VV?=
 =?utf-8?B?ZWRyVmkza0xQQ1lMaVVkOTZOeWJUWk9kNlJIcVhoT2psYWhXek9aYlJlU0Fk?=
 =?utf-8?B?cDJXbzQ4cjVmMUk1eDVCLzBtVmpUa2pyNjZKdUxZMk4wWm9sbDM5WTk5Wm1o?=
 =?utf-8?B?QXRhUGtVSjUxQUNkMlhMd2psdG1FSGMybWN2aHBLS2JnaVhOQ1c4aEVUNHpP?=
 =?utf-8?B?b2Z5RmpUd1lTSFQyM09ubGhHV2JJUnlOS1llbVV2Vzh5RFp2ZGM4c0t6TkJK?=
 =?utf-8?B?Myt1ZHhWVjJwM2NGNWhyTDl4dTg0RG5oSEpxeDNBNW5IZDJGTUlQY2oycGE3?=
 =?utf-8?B?WjdwTlZxbVQ1R1duSncrQTdWd1JDbk15bkRiSy9oVVJpSjhTdFFtYUFla082?=
 =?utf-8?B?dmROYk5XUnc3bWc0T3psblRsMklLZi9zandWTWoyVHI0VkZHZ1BtY1oyalMw?=
 =?utf-8?B?S1NVTGFlc3ZodXJ4KzVmS0Y2L1NnYy9ZRjkyM0lOdTZMc2lNMXl3cW1nNUxB?=
 =?utf-8?B?NzhFM1VZMEUzd2pIVW1OaFpEYmpLbEJ0eXh4dXM3Mm9MTzhjb0VLMXh5SjlL?=
 =?utf-8?B?WWZ1U0hRNDBuSUdtY2xqS2JTYk1wMFl0YnA5UWJHdWhEQllJUDRvVVVMaWxX?=
 =?utf-8?B?dmJmdzFvL0lybWJsSFhrODRpOWF1ZzhlaytMRVBqUDZ2dFYzK2hSeTNGK2tL?=
 =?utf-8?B?TUlZQXJUb2ZlSUpHTnNoU2U1K2Z0R2ZBbW9iRGwzRzI5OTVjUzBCRkhGRWYw?=
 =?utf-8?B?L2Y1ai9KVUV5cklyMTNDZm9Ba05QU0wvQ01NTmUzQWR1dEFvRVEzZUxCVnJv?=
 =?utf-8?B?WFk5eHVhdWROTWxQdk8vc1ZRYnJUN0d6cnhMUVJlOEE2R3dweURiL3Y3enRq?=
 =?utf-8?B?R2kyMjdDQUdlaExWVUVudjhWNXBpQnNrVXZoWkFzbnd6amJNNW4vSy9Oa1pn?=
 =?utf-8?B?QTBtWFoyVDJWWkdzZTlkNW1kSGU0NjdmU3lVcHpnMnppWWxJMVpYeFJUS1l3?=
 =?utf-8?B?a0FnZFFIQWdFMG54RGxPbVovaHFobjBOTlh3ZzhNSDJGRDBjVEttUWc2cDU1?=
 =?utf-8?B?citYL2JjWWxUak41dnZCUSs3SGtGeHZsejNETGJ4ekhoTFNzQUVUek9INTBN?=
 =?utf-8?B?ZFBsN1kreWdmQ0FLY0J1cUs5OUQ2Y3gvN0ZlVXY4dEZDM2lZbzl3OHFtTEx4?=
 =?utf-8?B?NGFzWEU5S3duZ2lXWG8zbDA1M1cyd1J5K3I1TEtPZjZmdWdRL3dkVlBHQU9j?=
 =?utf-8?B?SWltbHM5MlVsdlhBT3VIbXhkYmg2TU82THNENUVMOXU1ckN6QUwrMGhETVgv?=
 =?utf-8?B?LytWcUdzeHk0aGhBNVdERWJYL0VYbThIMWlIc0lKUmdVMllWZGM2QTZVc1pW?=
 =?utf-8?Q?rqWbEpJ35KAvh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3R3UEVkdmhraXJOdkg3L094QnBUWEgwYzB2SWFZRFVxREwyTkZRbGlGMndV?=
 =?utf-8?B?b1I3YmZZaS9PQzJQWGp6MXp4Qk95VW1rN2c0WEtRUFlYZVcwMG02OFU0cVRn?=
 =?utf-8?B?Y3R4QXJmdHoyb3krZWRvNkcyOXdBMkVPUEZUOFpETEpjYTdxVnBhVEhSK2pz?=
 =?utf-8?B?TEZpeTR6V3ZQZERodWEyQ2NDQlRTakJjTmFhWCtxVmhLSWhjaDVnMWplR3px?=
 =?utf-8?B?MzlvOWszdFEva3hIR0ZTaDdrc1RCWUFQOXRkYlJpdzN1T3pLUmx1UXpMS1p1?=
 =?utf-8?B?cEdqVjJOUzZGbTRWaW5qd3duWlBxZnVXMmp3dDVURW8rNGdzTUhvL0lpTE9t?=
 =?utf-8?B?ZUIzbkxLRGVYTWRWcVQyMmhDenpkNlpBS0JOWVN0cjB1YjlTRGg1dUU5YUd3?=
 =?utf-8?B?NGUxWEY3ZlhScHV0TmtrQW1mdlQ1UUw3Q2d3ZWE4YWtETDE4TjRZT0dURGpZ?=
 =?utf-8?B?bGNOUEIrUStITFVNTHEvMW5JSjdBN2tONWJGM1A3YXI5M01MNldkbks3MlZ4?=
 =?utf-8?B?cUkvd1ZVRUozazJaZHl1M2xkTVRxbkY5cEhnRVJmK3h4RjBsNUNsRDY2bzNQ?=
 =?utf-8?B?TDB6N2dUd1ZoMUk5RlRWaWR0RjZjb21XNGFNYnBWUytEcWdHSGwvZkFGa0FL?=
 =?utf-8?B?d3NCM3VKV3E1TTdlWEptRk8zM1o4NXB3TU9pM3FkQks0em5nNFEwazZ5YTF3?=
 =?utf-8?B?dVFtMXBpYmEwM3JSRzFlRDl4bEJaMnpCcE5YMEtSM2IzUmVpSmtYUER1TU1i?=
 =?utf-8?B?YzVzUmtjMDhJMG42ek4rb0dIdTFtc3BEbGxlM09US0FGK05XczRUYklkencv?=
 =?utf-8?B?aFhaM3dUd1lBZ1FvUmJUTEpwZTBRSXVlSjRycTQ2ZGwyQy84OHQwcjRWNE5B?=
 =?utf-8?B?UXNONjFmRGhzTDNRd2NLWDhuL1N1dWFFL09JMnVNbmdnYzJtQVZLZ0ZPMmxQ?=
 =?utf-8?B?Y1ZaNXdiaEErdTM3VUUxOXpuL0xuN015VEZwNmRYR1MwVjFOUmFKOTgzKy8v?=
 =?utf-8?B?TlIzQkNFbDMrdnRJNjdYRVIwOGtxWHR2SFFoL3RWQmhIak5tTXZtK3R6OGZT?=
 =?utf-8?B?QTdhb0ZlN1hFQVorR3pqS1NQVzFtUlNncGVzMWNKNmVJM25qNG1KdWQzTmFh?=
 =?utf-8?B?dTZ4WE5NZzc0QndVeUZXTWo4UFQ5bjlvMUdUQkIvandOSE1XK0c0WE84bllT?=
 =?utf-8?B?N0sxWjVMa3FnUXZkbEdmejdpU3hORFVFRmtyQlBTWS9YdnFpVGVUZHBDMDE5?=
 =?utf-8?B?SVdaSmc0RGlxbndkdms1YXlFY1IxbjJhUkFJdkQ5aks1RSt6Qlp5U0FUNHRW?=
 =?utf-8?B?MDIrVVpkdVI0ZmduK2pxVVVCWUM2anh1MzBUQ09XRm5MVFhMclE3M3ZCK2NV?=
 =?utf-8?B?TE44RmhMemJuUjVCNjZlK2RrUHQ2Y0I2K25RaHFleVFaNnlmVGVBTWhaQnJY?=
 =?utf-8?B?YWJlTjdESmtpSmJ0cWM1NTNTTnN0cVhZU1JRQlJWQU4zZXpDY3FIdkN2Nkxl?=
 =?utf-8?B?YmlHMGFFOWNjZXNQVG1VMmc3aVo0YUtoK2Jra0xkK1lUa1dNK0pLelZvL3cx?=
 =?utf-8?B?T1ovN2Q3ekNXSitqdUMra2s0ZDFIcDBweGJDc0lEK0xxcm51Y3pZQ0NjMmMw?=
 =?utf-8?B?WDd3anAvREJ3cUJNMFRYSnlTK1Z6enZWa2pQQXNlZVpYZkpONUh2dGlmQXBS?=
 =?utf-8?B?QWltRWdoakttQW9tVG40UU1PZmd5d2c0UkQ0T3o2a3U4bmpUUFBydUtGeDRU?=
 =?utf-8?B?R1NKMldKVWsxcmNDL3J1UDBPaFp5Vmc4WWRwYys3RldkWE5uNnhIY1BHdUxa?=
 =?utf-8?B?cVYzNHNTR1AxcG9obGNhOWdWejdtYzJwTUhNenAzdnM0azJLeVBhR3BIL3dr?=
 =?utf-8?B?U3FPSXFwWHFZUnozZ3paQmZvMjJBVVQ3YkY4RXZudDBIVWQ5T3FiL2crelRz?=
 =?utf-8?B?UlhUOHJQNWJ1Zk1TUUFKdXozK2tYM29qM2F2aGlYWDl1UFR1SkNzSFlzbEdH?=
 =?utf-8?B?N21NYnMxUUFJRnp6VVl1djRnc0RYWUF4Z1BsUDZWMWFTVG1JZWI0d1o4b3pa?=
 =?utf-8?B?djZJVVJJL3ZsOHZ1WmFEaWZQcXpGMjhIT1FJcE1QRk5OOEhMaG1ISkE2YVNj?=
 =?utf-8?Q?wM6kE+S2Ut7lNBQK4eGN+CN2e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662276ad-8584-4958-21a5-08dd978db108
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:01:37.6682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0WL4tJJ6Kj7BQu8jXH8iZsRLcosb9aLynSjApFNaFpPHMzAEmVUtI+GsNzNzuksir4Vrxlsdk4TE4xYT/pQRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

Hi Arnaldo,

> Telling that to the user and possibly skipping the test if viable using
> uname to get the version and if less than v6.15-rc1 print "Skip (needs
> v6.15-rc1 or newer)" may be an option.
> 
> Then if the bug somehow reappears, people running 'perf test' will flag
> it.

Sure. Attaching a patch at the end.

> And I think having it in 'perf test' as well may make the feature to be
> tested more widely, both by those who run selftests as well as by people
> trying just 'perf test'.

Yeah, that was precisely the reason I did it in 'perf test'.

Thanks,
Ravi

---
From fb8c9f77231a9361a5055c45e75aed3d2414f685 Mon Sep 17 00:00:00 2001
From: Ravi Bangoria <ravi.bangoria@amd.com>
Date: Tue, 20 May 2025 05:32:48 +0000
Subject: [PATCH] perf test amd: Skip amd-ibs-period test on kernel < v6.15

Bunch of IBS kernel fixes went in v6.15-rc1 [1]. The amd-ibs-period test
will fail Without those kernel patches. Skip the test on system running
kernel older than v6.15 to distinguish genuine new failures vs known
failure due to old kernel.

Since all the related IBS fixes went in -rc1 itself, the ">= 6.15" check
will work for any custom compiled v6.15-* kernel as well.

Link: https://lore.kernel.org/r/20250115054438.1021-1-ravi.bangoria@amd.com [1]
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/r/aCfuGXUnNIbnYo_r@x1
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/tests/amd-ibs-period.c | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
index 7c77d86f369d..223e059e04de 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -3,6 +3,7 @@
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
+#include <sys/utsname.h>
 #include <string.h>
 
 #include "arch-tests.h"
@@ -912,6 +913,29 @@ static unsigned int get_perf_event_max_sample_rate(void)
 	return max_sample_rate;
 }
 
+/*
+ * Bunch of IBS sample period fixes that this test exercise went in v6.15.
+ * Skip the test on older kernels to distinguish between test failure due
+ * to a new bug vs known failure due to older kernel.
+ */
+static bool kernel_v6_15_or_newer(void)
+{
+	struct utsname utsname;
+	char *endptr = NULL;
+	long major, minor;
+
+	if (uname(&utsname) < 0) {
+		pr_debug("uname() failed. [%m]");
+		return false;
+	}
+
+	major = strtol(utsname.release, &endptr, 10);
+	endptr++;
+	minor = strtol(endptr, NULL, 10);
+
+	return major >= 6 && minor >= 15;
+}
+
 int test__amd_ibs_period(struct test_suite *test __maybe_unused,
 			 int subtest __maybe_unused)
 {
@@ -931,6 +955,11 @@ int test__amd_ibs_period(struct test_suite *test __maybe_unused,
 	if (!x86__is_amd_cpu() || !fetch_pmu || !op_pmu)
 		return TEST_SKIP;
 
+	if (!kernel_v6_15_or_newer()) {
+		pr_debug("Need v6.15 or newer kernel. Skipping.\n");
+		return TEST_SKIP;
+	}
+
 	perf_exe(perf, sizeof(perf));
 
 	if (sched_affine(0))
-- 
2.43.0
