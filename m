Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020127.outbound.protection.outlook.com [52.101.193.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70610A18
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Sep 2024 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643643; cv=fail; b=iAdXhJAxrAiBcnnlx5nBw2Q9IuvlUvoSIXpoe/ojQfJlCSU6HN/JDx1xpnrEDcwP5wuWLo/xmbGmNJqGYqrl3Mzxz3C3Em9O540Sa0uL3e5m0o0Xi8aOlqjoycMPS1aYvP19gQTibo/PYANcWzNEBsYsarwsyKMfTi55qCUCw04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643643; c=relaxed/simple;
	bh=Pi82mvl3oBAm92VK72JutXW4bNfbzbdEx4Ulmc8Bb4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gfclti2/0ek6WLlhxtitwQRu8hDwUn9aLGjOyoEyI6Ketau7LsFzZWAG6A0h6SYXx76nGAcIlLtFWB7XOMLzFw9xai+KGqIPT6t96QwNP/Z4/wIZM5J5ePtwyUPsmEvzTDDr0PyyF8S9JpOSkhkuSPQEjBIaC+lnQd5S929hknA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LU2138O5; arc=fail smtp.client-ip=52.101.193.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LU2138O5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCcSIKJ8i1v1CZdEpgpBNtkiTnnUTwyV3OTNhV2Nugc9psFqVFK+pW/ZKEM8tohw06uzb0foOX0q4R4nbIBlaPWK+xoXm9dof54zcS8jG/1omWU21PpGjbD0rna19x5/9l4KA83VWkjLafTvQp4a+/zN8Ccx8+EmoCWlw/DaPgo9GCAQonpo8yCKCr+3E/yiwUPE9H4vOH08x+C2UUBU1t1BOVwqzS52CM6+CzvRNtsC3pYYRJxtNZofb+cNq3KVwuDrpcn4FxKfa23NKL/NvwcMfWsAZQRXvHh0Msl65nOSrYLuEY+8gqS2WpsrQ4p/UpAmG7PfhsCQiq25CosdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1Fb0Q/t7WhW8rFc7LsLsVf8xxeOxoX+0warid6+KyA=;
 b=qxBcmo9JeV91ftPIhg7arxJ0XFrgKy/I3di5Vf3J5rUphBOGLuBAj7RWIOXI6hfiDMEUKTp7BErWK3iQ22k4SqUr0KxTbJKMXwCQlK7whFsALCufdG63wlblCpOeCRvI8k5RHysH33dYs0MCXn08+ZvijaA67sraUsgyiavV+hwrljgmOmJtjq+paZGw+wqpRi1dDOTI9e50tl6XTqnxgWvX0K3obLPVsNxQy+BtG9eCg4Cmru48ctfrSVM1NXuxPOBVqDNHWudTMDkMEm8FJL9kEhe1xfURin11vJk6E+bBSC7W1TJLJ8F9kPBgbJOQ8DOyZg9mjmYW7oCHQbzJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1Fb0Q/t7WhW8rFc7LsLsVf8xxeOxoX+0warid6+KyA=;
 b=LU2138O5pt6cRdDHcHMXJCjo1ziK4ydfJyXasfMHjN2qtn07mTZaSSiCtPjgchxGL1gZcpB4SveKi++7tjNlP8xH3cM9Sj8AAVQWZSOkFyb0Tw9AiKh8V+lBLX+L/ltQyUOvkH6zIDzwTg8M5V9UH9iBByljCRBHrzSRnk4U3lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA1PR01MB7342.prod.exchangelabs.com (2603:10b6:806:1f5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 17:27:18 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 17:27:18 +0000
Message-ID: <723912a5-4d9a-4fe0-ad86-bbd79ccd4a45@os.amperecomputing.com>
Date: Fri, 6 Sep 2024 10:27:16 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V7 4/4] Adjust objdump start/end range per map pgoff
 parameter
To: Leo Yan <leo.yan@arm.com>, james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
 <d730ad217936d952008edf703ba4c34393d89dad.1725573309.git.scclevenger@os.amperecomputing.com>
 <22f7ecdb-14e7-4bb1-a20a-bdb447bcb64f@arm.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <22f7ecdb-14e7-4bb1-a20a-bdb447bcb64f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SA1PR01MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4da091-d13f-4dd1-c7df-08dcce992850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck5OTWcvQXcwZ1ZDOGFzNUdMd3I4bUIwdVJaVDVrNFZNZWF1aEtwZWQ5SWlF?=
 =?utf-8?B?VVVrSjY2QWlyMyt0S2JNU21tNDlsQ0JoZXFmYUNNVWZZcXlnMEpVSm52bjBT?=
 =?utf-8?B?cUJocTRkb3RGSFA0WjJRejdMeHZVR0JZZHYxak13Y1J5dWQ4YS9tamdWcXNB?=
 =?utf-8?B?NUhIRDZQOU1YOVJXeGo2NWMrWjE0MWdYL2dTTU4vdGR4YjVjZE1wcTFxMXJn?=
 =?utf-8?B?UEprbkxXWG41MmprTE05bm5rQ0hXeXBiTXJqUEtYb2ZUWUN3YnM5SEtvQTlz?=
 =?utf-8?B?UGNsc2QvdHpsQ3E0Y0kvNEFDREJsZHVqNWxaZEp5NDZHbFp2MEhEYWJKcllR?=
 =?utf-8?B?ZUk4QXR1cjFuNXVmdzVSelUzYnRTeVhIbllWY25ySEVnUjFpMWFCd3NraW9P?=
 =?utf-8?B?WGxhVjkzMWM3UUhFbGcxL09EaUhHL3F0L3BWV1gwNFV5anlVVEVpbG5ENm1j?=
 =?utf-8?B?MmlUT244ZXRUWGFBZkZtWWZWQURSV0dvLzRQaEZiY2tEdWtpRHdDRUg3UDd1?=
 =?utf-8?B?cWQ4a1BVL2hBZ21FREQ3cFduVGZBcHZ2eE1VbEo4TEVUTUZGbHZLYmk1VWRX?=
 =?utf-8?B?R05SeHRaY3cwd0l6U09YNDRUa1d3aS9LR015UU45ek1kNjBlZGROUVBxRDRS?=
 =?utf-8?B?YTBzUFN5Rm85YjVibW5FSnpRUk9ZbnVhMTJwa3FsQ2lSbEluQytpL1RRRHl3?=
 =?utf-8?B?WXYvR3lmVm5HLzhWVWoyQ0h3ZVBDeFAwU3JXSC9Rd3pyTnRCbUVsUnB2ZWNJ?=
 =?utf-8?B?UGY0cnJoY0lwNWc0aUFEN2Y3dnN3Y0NLUmRWOGZzRVNFaHphaTVLQnF5OU1E?=
 =?utf-8?B?aFlHZSs2eE54bG5ERFdVT2lzQzBuaGU5VEZFNXVpY1d1NGs5bnYvN2JPek8w?=
 =?utf-8?B?eTgvS2lCQVFVYm9BTko5b1hWZU0ybnFpUDVjbWN0L094dStYaWJBODY4UC9H?=
 =?utf-8?B?RWVLaE5DeHZhTE1OWGFxb28remFmUzJlQ3J4RmIwRmIwV2RrY1hnRklHdlVp?=
 =?utf-8?B?VWpmTEtzL0RJdXdON21vUzhYbGc4aExPcXRYZzhwNmg5ZnJMdGE3eHUvYk1Q?=
 =?utf-8?B?c3hBQnozVlc1UHpIMDBwajJvK1RjRVNLWndZdFlZbDUxQ2x0cytwZ2Q5MGNK?=
 =?utf-8?B?NXpGUENCZ2JFait2cWVYbHk1RVNHSzFma2NTeVpjQUE3Rk5ibXVmMzF3c1VJ?=
 =?utf-8?B?VFFtOEhkeUpEempkVUJzVStHellOeGczdmdBeVY0Zk5EUHRpUldIL1Z0cjlq?=
 =?utf-8?B?bXdTRFc5MWRFcStyK0lEUVdjaisxUE1tVi9pbFUzZm81bTlYT2FPUExYRzJo?=
 =?utf-8?B?djllRFpJVmsrZ0MrU2h5N3ZmOUVyK1pJODM0ZHZRa0swaVIxdDdDb3FJbkp5?=
 =?utf-8?B?S3dMQXJYSnBQVkJvNTBUMUdJWVJTWTBjeDByZVlLY1Y0MlN1d0dHbEliTlFl?=
 =?utf-8?B?Z3QzZXZOMG9IdEttUzBiSHZDYTFGSVRKUkNWLzdqWGVxTVI4L3ArNmxVbElH?=
 =?utf-8?B?Ynp1SEJVZDNYN2dOYVhyOGxBeUNwdGJMclhVYUxadFdjbzZjNTg3N1c3VlNq?=
 =?utf-8?B?aHVSRWZHRFdDRW9US21aV1l1SXNWcUJHQnMyVDVyUWdPQlpEdCtQQzNhdDl1?=
 =?utf-8?B?WjRPWmNZaE9FOGhVOHllYU1QOTI3c0U1ZVB5dmJpOEtZS0JGWllhK214TGxW?=
 =?utf-8?B?aVl2SWw3VDVwMks3QThQQkkrMzNheTdNL1o0ZkM2U1ZadDRaRVlOeWtXcm5u?=
 =?utf-8?B?UlQrNWkyVzlyVHJYR0RpdG90L3ExOWlKOGxGa21nN04xY2sydFl2a1gwYitw?=
 =?utf-8?B?eEtBZzNJdVBXNWRJcnNjUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTl4TFdWZTRRQlFKSmFudWxoWktIbUdybDBBQWFQZ2piN1E2NzFoUjJPK1lL?=
 =?utf-8?B?dk9DUUhQaVZ0OW85bWJOekZub3hXL0lPbEFvL0hDenlzaFU2YkJVMDBpM21K?=
 =?utf-8?B?Q1JqY1NSNjh5RnZOR3Y1OFlhRys0SWJOdmNnVXRmN3JYKzVKWXI2QzEwUEhn?=
 =?utf-8?B?MWJYMlg0ZnJ0N1RQVkM1Uk82WDB2MFE0RUhmTTN5NE1UdU1ocHQzeGtSdmdJ?=
 =?utf-8?B?SlhweWd5U3VwWkdZZjBvaEFseDJwaWRJc2FqdXA4VWkyUGpTbmxFYmp3N2ND?=
 =?utf-8?B?Nk9NOFdnY0c2U3BmN0V6NVBMZWlzbm92bWltZzcvVWlJT2hldXFWQlE4citt?=
 =?utf-8?B?aEFvbzNrbG0rendhRmNtaWRHVnoxVkExV09rVkZSQXhKdVp1dnY4aHFXbWEw?=
 =?utf-8?B?Qmh0TjhoWnZ6T0ZmSUhYakxGeWN1QTg5ZUVDWUszanNYTFFFaDlGTVlVUDBZ?=
 =?utf-8?B?VldHMHdVNjNLV2lQa1Q2QkdmRVB0cVk1ZzVtcUV6bzFOTVVDVXlRY2l1VmR0?=
 =?utf-8?B?eTMwSEFGdmYxdXJkU0p0d3huSldCRDkvOXdwMTczeXJ1VDIzUDVsazRMWEZh?=
 =?utf-8?B?bXd1elg4dWQxaVp6eTR1MEUrTDY1cnFVbnFJUURuZG1PSmpFWUZoNTVRaXNs?=
 =?utf-8?B?QWdUdTFId09HbzFMMit2VTBGL011OXNHUzNGcjgrRy90eHc3WmcwQXd2akk3?=
 =?utf-8?B?WHh6a2pQNWp1OWF0ZkVnSzJXQXh6eU1EdHJZYVp5RGJNVjRPcXpyZ3h6NHhr?=
 =?utf-8?B?V2FabGgzTTF0SmJ4R2MyYnowSzJiVVdHMHlHV0U4NHhod2VuTTRvSUtQUWNu?=
 =?utf-8?B?REptQy96dGN2dGFpZndNU3pMaUNSRnU0UCtJVHh4bms0dTlkS0w1SU9Mb3VO?=
 =?utf-8?B?KzM5THIrTXE1OSsxZ0pwcnFUdThTRFNqQ1RzWlZDN1pjTXkvQUJlMUU5RDVt?=
 =?utf-8?B?ek5QeG82RFdSVCtLbkdHUnJHc28rSWtLMzVzOHE2am5VMjR6eWNrQ0ZMVnBv?=
 =?utf-8?B?bDloSzNmOUZmbWlWRXE2MUEvTVRZOFBqVHlBaERJQlV1aDRPNjRNYkRSYncy?=
 =?utf-8?B?TDVYNkNRT21HcHpPckhTakpuUWR0RjU0WUU2M0RlMHdqWCs0Z1ZSWmdzaXFN?=
 =?utf-8?B?YXpCQ2x6dWd4VFZIektITDA0MVdqWStpRVV0UUpZMkVLM1VJRFIrR0RNZzNh?=
 =?utf-8?B?T2JDUy9mRGkyRzR0WFV0cWE0alhlc21PNzcyY3p5eUtRdkVvWFhHYUEzQzdP?=
 =?utf-8?B?dVdwVnFjY1Q4aHdvWU9IZkR0YmlQNmZ6S3hOY3hjTEFpWmlkcWxOOXFmcWxi?=
 =?utf-8?B?TE1hdmRqSWpIcXdVOXQrM1JxQjBjQUpLUWQ3UUFqK3NBR3psNS9sS1pISllO?=
 =?utf-8?B?N3ROeFVOU1ZLL0UvVFJpNUVXMGVZdUYvUkFqMTVTOWxPSjV4b2twVWZzSVg5?=
 =?utf-8?B?V1FReHhWZ2VNT2tTaFc3NC9OUHZhUzR6YUpWSC9hTDNvMmZ0ZU1WaVhyQ1pr?=
 =?utf-8?B?cXFGdjQrTXJ0UDY0QWdycUhFd2h0SFIxSXdSTUMzejdCc1JoblJwUnRFNS90?=
 =?utf-8?B?NnptS1JCdTJjd0E5WVJhV3dpcXA1bzVrUlhJUElGVWRGY0RXb1V0aFlXbEZH?=
 =?utf-8?B?eElaakNzY0F4UWdzekRuRk56cEpldTZXV0RDVU5IQTBML0FPZ0EvWXJML1k3?=
 =?utf-8?B?RnZGWEJrNVNTR05VbEE0eUtRUituTUpFR2dFcEs2R3JYQ1hmQ3lDbzZTbkEw?=
 =?utf-8?B?RnM3QVJtM3haTEl5b1ZneDk5UUFpR2UyREVQdFNZZGZqdEhLa21qd2MwYW9I?=
 =?utf-8?B?OC85MlJya0pYeWpad2dZaEhsRXhKcHBjaXJOcFA0Z05RRU5aSngzcjFrNWRG?=
 =?utf-8?B?Y3dheENmbWpHOHg2MHpDcUxieWNTeVlLY2JMYTNsQkdrcGRCK3VVOU1UNXNu?=
 =?utf-8?B?NUNDSTBnZklVYndLVy8xNzhnZmZCTUxPVjI1OEo2MWVHaWhQWmpZMzMyeXQz?=
 =?utf-8?B?WHl5R3kzOUNqSjg3eERKeHhOL0Q4cHlVK2FPazRNaEgxbFAxZnFtNEJhRGhJ?=
 =?utf-8?B?emFpdnJsNS9YayszR2ZhL2FhUU1zQWV5dy9WMi9IeWNkSThjQ2RiODBjK0Mr?=
 =?utf-8?B?cXZ1VFpGOXE1WlNxQm5GWkpSalUzUStHeEpxcE81eVg2eXRRUDJ6cFNmc3JB?=
 =?utf-8?Q?vWD3/fAf/t7St1+CFqJLyuw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4da091-d13f-4dd1-c7df-08dcce992850
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 17:27:18.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlzrr6J+55DG+NImhJaQ+M5IzOiNGASzjjK7SU4x30PO4ugPYqVboEGXjD92xaA+UKxPnoPqeshkzx5k0lFYhazR6fDMrLre8OH/o6KhbzDEwZ3ouxzsBofn978FetG9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7342



On 9/6/2024 4:27 AM, Leo Yan wrote:
> 
> 
> On 9/5/24 23:28, Steve Clevenger wrote:
>>
>> Extract map_pgoff parameter from the dictionary, and adjust start/end
>> range passed to objdump based on the value.
>>
>> A zero start_addr is filtered to prevent output of dso address range
>> check failures. This script repeatedly sees a zero value passed
>> in for
>>       start_addr = cpu_data[str(cpu) + 'addr']
>>
>> These zero values are not a new problem. The start_addr/stop_addr warning
>> clutters the instruction trace output, hence this change.
>>
>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
>> ---
>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/
>> perf/scripts/python/arm-cs-trace-disasm.py
>> index 7aff02d84ffb..a867e0db02b8 100755
>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> @@ -187,6 +187,7 @@ def process_event(param_dict):
>>          dso_start = get_optional(param_dict, "dso_map_start")
>>          dso_end = get_optional(param_dict, "dso_map_end")
>>          symbol = get_optional(param_dict, "symbol")
>> +       map_pgoff = get_optional(param_dict, "map_pgoff")
> 
> 
> I am concerned the two sentences below are inconsistence: one uses
> 'start_addr + map_pgoff' and the other uses 'start_addr + int(map_pgoff)'.
> 

Valid point. It's working fine as is, but how is it even working? I look
at print_disam/read_disasm, and no type conversion is done in either
call. The dso_start parameter for these calls is actually dso_vm_start
which is the dso_start integer conversion.

> Here about below code?
> 
>            map_pgoff_str = get_optional(param_dict, "map_pgoff")
>        if map_pgoff_str == "":
>         map_pgoff = 0
>            else:
>         map_pgoff = int(map_pgoff_str)
> 
> With above change, 'map_pgoff' is an int type. As a result, the changes
> below can simply add 'map_pgoff'.

I propose:
	map_pgoff_str = get_optional(param_dict, "map_pgoff"
	if (map_pgoff_str.isdigit()):
	    map_pgoff = int(map_pgoff)
	else:
	    map_pgoff = 0

The int() conversions in the print() statement can then be removed.

Steve

> With these changes, LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> 
>>          cpu = sample["cpu"]
>>          ip = sample["ip"]
>> @@ -243,9 +244,11 @@ def process_event(param_dict):
>>          # Record for previous sample packet
>>          cpu_data[str(cpu) + 'addr'] = addr
>>
>> -       # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
>> -       if (start_addr == 0 and stop_addr == 4):
>> -               print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>> +       # Filter out zero start_address. Optionally identify
>> CS_ETM_TRACE_ON packet
>> +       # if start_addr=0 and stop_addr=4.
>> +       if (start_addr == 0):
>> +               if ((stop_addr == 4) and (options.verbose == True)):
>> +                       print("CPU%d: CS_ETM_TRACE_ON packet is
>> inserted" % cpu)
>>                  return
>>
>>          if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>> @@ -262,13 +265,14 @@ def process_event(param_dict):
>>                  # vm_start to zero.
>>                  if (dso == "[kernel.kallsyms]" or dso_start ==
>> 0x400000):
>>                          dso_vm_start = 0
>> +                       map_pgoff = 0
>>                  else:
>>                          dso_vm_start = int(dso_start)
>>
>>                  dso_fname = get_dso_file_path(dso, dso_bid)
>>                  if path.exists(dso_fname):
>> -                       print_disam(dso_fname, dso_vm_start,
>> start_addr, stop_addr)
>> +                       print_disam(dso_fname, dso_vm_start,
>> start_addr + map_pgoff, stop_addr + map_pgoff)
>>                  else:
>> -                       print("Failed to find dso %s for address range
>> [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
>> +                       print("Failed to find dso %s for address range
>> [ 0x%x .. 0x%x ]" % (dso, start_addr + int(map_pgoff), stop_addr +
>> int(map_pgoff)))
> 
>>
>>          print_srccode(comm, param_dict, sample, symbol, dso)
>> -- 
>> 2.44.0
>>

