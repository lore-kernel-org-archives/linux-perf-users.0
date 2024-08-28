Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020115.outbound.protection.outlook.com [52.101.85.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070C3BBEF
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809758; cv=fail; b=P2znR3voIC0F2zpfSJWQJjuuR3ypfVnjCfmXL/PYKs76TqYePfbLzHlSxVJHxkozpdfBmU8xfb4dSi5lHYb7fERyPJeH1fZRjAPzSXppGcGLRqXp4uxuTnOFAuROJLISyZLEhUlWfzg6oIDIC8Eu7+C0WlQCkUsDVLG4ziLHzxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809758; c=relaxed/simple;
	bh=xM2wcwo2ZAxaRdBvjIfFOQ88evKLvzAQaz3YTtmpZBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hWXxvbqXIhdITe039QFZYHCwB+EcNztj9p2EU7mWmRf+ZE6ZhBQvXusBOqOG1XfmqO/T1Ww5WLWI8l9MDto5vKHr0vijUnnP4/o0kJiupXLmlt94KSyuRiwKSlZlpi2UaflgSUjHk4BuSWVl6BZJV8TgzsyDXPkwPOfTFYiAWew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TCda/5kq; arc=fail smtp.client-ip=52.101.85.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TCda/5kq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PztYbFX4Zfx6ruhOHI6FfjQwU0jjl4Ag6mqgCUQnLIDx1AVhqQRFUyG0w85gHWF0dx38bTmpS2hE5ML4/TEj5dTd8qLoIkhqwE2pUzQ8gNR6QkRWDBfLSBYPYVGpcgw1BVZ4hVNolsZH16JSdW+REap6vy8srnHfGXfSPMFPVCSIwrAeOBlk6Oxn4ymv0OnfD0bV0sOcDvncoW9FHAepadAQKEtRxG48vFXr/WAJC9wqayXsmbA++iF/B8+KXgC/hqIgYcALbQbtarc7k7+i3WRa6UM8nfmWJKsani45lKljGHv7o1uUqCcPZdWDsy++9e2MyG01DDxBSCgyPT5iKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdODCNAeD12ZNDFGtvrkXcbLUCw9KA2NZFlinKb725A=;
 b=RPtlKGeWnfAa0vJjcK9QaspM4XLD1AwyA4oM9qzE9hCE/b9HdlvBhS+u9hoAjkQhCucf2PiiX3J2zJVB3m3k5vC03yOgeGJykx7Dm2Fyw5vP6LC8yOWarry2wRU7hAzE9XYBfRu9Gc7SPsbftxSMpZOLsN/TLmLLAYi9Mg99/2UO30mwKiOKK5Tf1wNFiLueE7xDo89oYYLSCU9tAH9m2FbNNnVz/xE1m3bHti65AfqlEBdJYRaadwfFSI5mAW0wUMI6bD7ZJXMR1c3ASHIyn9Oev6mRzTcUdAEvdnj56hkiOH409MhnHIRVOJjyvAZyWJFKHXZT9z5LXWYR4wV3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdODCNAeD12ZNDFGtvrkXcbLUCw9KA2NZFlinKb725A=;
 b=TCda/5kq3nrgh8aawGDf3764Ze0kh8Q4bZB+80svvFy6ch3l89VO7iM9C3vGb/wlOfZrPDjqRTQ/XV5JtoIdQFePhvWwRYY2HCZzNNblUb33nmCMHbKN7Rs3lG6EvhlMWmw8aAHACnzSr9wTU/8jB1U6d+IG1NykSGJREDJef2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 DS7PR01MB7568.prod.exchangelabs.com (2603:10b6:8:73::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Wed, 28 Aug 2024 01:49:13 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:49:13 +0000
Message-ID: <349400c1-076c-4660-bbea-553b84e9eb50@os.amperecomputing.com>
Date: Tue, 27 Aug 2024 18:49:10 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V2 5/5] Adjust objdump start/end range per map pgoff
 parameter
To: Leo Yan <leo.yan@arm.com>, james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
 <7bbd5ca482b052d1c52efc52742f5c2713d5c26c.1724698250.git.scclevenger@os.amperecomputing.com>
 <23c27981-76c0-4921-b8aa-04f46ac3d6f1@arm.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <23c27981-76c0-4921-b8aa-04f46ac3d6f1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|DS7PR01MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d356775-4ea3-4099-a6c4-08dcc7039e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFdIU3MvWnYxMnlHSStyYnE3SFl2azc1dGx0cjd4YW9leXRsM3FSSThpWWpp?=
 =?utf-8?B?QkRtVnQwY2ord3lGSEpIZ0QyTDJJSWxtN0ZJU21RbE9BVGJuS240ZHd0OFJ1?=
 =?utf-8?B?Y2tvbCsyWWExRmdqdERCQXgza21SNHd1eG5JYmdFNG5qL1JDZlBzVjZtM2wy?=
 =?utf-8?B?RTNWelBXa3JHeDQ1OHFxY0l6V3oybDlZVUZ4dUxWdHJmSjFZWThsZlVDanM1?=
 =?utf-8?B?di9NajVtTEhudkZMNU5NZHVnSXg4NjRiKzlBMHYrK1pUSlUxNktZTHM4Mmxm?=
 =?utf-8?B?OVg3cU9VNk5lMmkzYnJ2cTJBMUxabG5LbUdUS21UNVZ0cXQwOU02NW4rZDJ1?=
 =?utf-8?B?UVh1RU01MEFyUW9jeEFva3lZK01abEZ5Y3pXUllXOWNDNnprdDhBM0k3U0Z2?=
 =?utf-8?B?QkMreXJsbmdvNkdmNStRbmFHbkwxdnVLbk4yOUtndUNzYTk1K1kyaG5RYXRM?=
 =?utf-8?B?aE9uVHF2TnNYTUg2cEdDWjBKV09aL2laVUcvQkxxVHhDT0FlZDVuRU16ckF6?=
 =?utf-8?B?aHgzOXE4bVF4SWd5TjVma3FSQlUyL3Y1QllmM3g2WFJ4ZHRkaU1YVFFSeEZF?=
 =?utf-8?B?ekl1eWNxM1hHRG5PekpDby9na1liM3ROKzhmRE9GMHh5bEo5cThKOXl5QVdB?=
 =?utf-8?B?U21VbEttM3R2c2xnZXdZMDVGWmJLVkdaM0lqOTMzQVUwMnFzTUJTU000WjZ5?=
 =?utf-8?B?S3lJckRmMTBIamVERzhKZ0E3VTNaN2FxMWpTWUptV3ppcERNSk5JRHJMV3RT?=
 =?utf-8?B?YlYrMmJhSmtzbXc2ekZwZVRsNFpyZWlidDVMVUdxaFg4NUNuR2pxVXdxL3du?=
 =?utf-8?B?dUp3eXZYY2M3RkVSaVQvU2E3aTdpZ25zdDZxWVZjVyt3eHU4QWVhUTJPOGZU?=
 =?utf-8?B?cEs1bEFvOVRXOE9oYWJGZ01nTWJRRWQxT2U1OUJrQ3FEanVleWhYM0FHSFRQ?=
 =?utf-8?B?Rm5DaGVBMWhsaUZWZFJvMnUrMmcvb1VHbHJpdGNHbGFmYnhJd3NsYmxsTC9Y?=
 =?utf-8?B?clJxem1wTEwvemprVmJUTkZsazMvR3dQVXAzYTRJUE5KRGFxbWlWdTFIS0JT?=
 =?utf-8?B?QzIxamx6bkl1MmtiYVhKN21WSDcyYzk4cFgvcTN3SS9jTmgzSVBmSGIvMnUy?=
 =?utf-8?B?S0VRb2RsenhuQVZWakJOOWFJYldpK2MyL3JHeHRwNGVtZm1yQlJOcCtjRWc2?=
 =?utf-8?B?THd4QVVmVnZOKzJZYUR3TFI0RldiMVNEQ3llTkRFQlp3R3pFbDVCQzZmSEht?=
 =?utf-8?B?ZjZUaUZuRHJHNlhLVmNqeXhnTjVuSU9GYStnRFZ3S2VRTG9qNFpxczZQbHpQ?=
 =?utf-8?B?bHY2NmhjaDBxcGI4cFB2ekFvYy9mMHAxRDNJV1JyZGtHd0NOVmtwbEN1ckhU?=
 =?utf-8?B?ckdJd2hNOS90UnJUUWxNUlhPSjRIZDFQZjIyRExiL1hrRGJqd1YzVFo5M3Av?=
 =?utf-8?B?ejRLZ0o4QWxXK1F3Q3J1Ykk1aWZqd3RJM0FIZnJuWHZYWHBjeUtheUdUWmxz?=
 =?utf-8?B?b0ovUHZZM2ZEMGJRR1o2ZStKc0FEY29EaXBSaUlocEl1VTgvT1p1ZGtQM3hm?=
 =?utf-8?B?TlZQM1hiZWhoYW0vZHE4Wm9DeEJ1eURFTURtV2N4dCtmNXdqdVFiaTRlTFRl?=
 =?utf-8?B?YUdNUi9zTVQyaTBBMWl4Q0FUQmVCL3FrTFoxbWZTcEVralVsL2NGeFhMbWlR?=
 =?utf-8?B?NUFuUWlRQlI4MUxOaXYvZkd0dVkwb3FiSUJnRVJEa0c3aVRUSFNlV2tFSzNi?=
 =?utf-8?B?dzdqU3BnQ2NwRjJ6bHFKWVdYK3RoeVlIQ05MbVFJNld2OEJDTW9pL1VhSngx?=
 =?utf-8?B?SVRmUW40SkplS0kxeTlHdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3BzUG9uSFo0QXY0T1krUVpaeldPekgrQXlacVRyQ3o4UTdNNGE1WEdlMkNy?=
 =?utf-8?B?Y0t0QW0rMTUzeGRHbURCMndoTWRTUWNrRGFZVjh0bWN1MFJyS2VTZTRrWXlM?=
 =?utf-8?B?RGx4WFF5S0ZuakxZekpNV0tTOENCV2dMVWczaFM4ZE9wZDd6REYxbHIvbVFm?=
 =?utf-8?B?elZIbUxMZHpPT0pacWVNam81Z2hwNUxSTWMrTHJqZDl5OGpINUNPbmNCWWlt?=
 =?utf-8?B?Y1dZOFdsc0tsaU9ubUZhenYrWkFvdzhaS0w0UmREdkFXWEdLdDJSeGhvTUtP?=
 =?utf-8?B?VUhWVXBwOGgzZVJkM2pvYU5XYVEvUzgxZ0tzOEF0OThpOWFsWVgvUW9qZGdF?=
 =?utf-8?B?eVVmVDZMR0c1STN4UFF0SVM1TDFiMTgrMWUxOXNJcHkyRmFkT0NuQVJTV0xQ?=
 =?utf-8?B?SFRQbjdQZGNIcHpybHM3aUFEV2NDdWFIc0EwTHlWdHhYaDRQRk9wTU55bXda?=
 =?utf-8?B?TjVRMWV2OG90TTVhKzVab2EzdENUL005SUwwNXpsRXZMZ1pxT05YR29LanFw?=
 =?utf-8?B?S0Y0eU9NMVJCTHdadmVhbzI0clA5RGVGL1pmSThOaDhXTW9BbUxYaDZ3b1dR?=
 =?utf-8?B?a0FkaFh6bzYrZWtnZzZrS3k4N1M1bU9LZGNOZzF1aEZLOFFQNXVka05ibWxn?=
 =?utf-8?B?a1RFd3BPaWxxWjl3aUthNzczQ3BOaWdvQVVFMWo2SHY0OWtCR0RSQWFMREtl?=
 =?utf-8?B?dkJQcTRhUCs2RjYyUkZXeitNWEU4ZFBXVldiWUhlUHRVTVlDaEhCVnlRMnRB?=
 =?utf-8?B?RFFjWDhCMTBxano0SzBSZmhvN3NHaGIyck51RU5RY3lBS1FYbzhvay9Dc1g0?=
 =?utf-8?B?b2RqZExyM0xjS1JBUjRIY0pDbm9CaGlocW51OWtONzZsMFo5ckx1ampKUGxo?=
 =?utf-8?B?USs2TVhpUGZ2dzIwY01WK2Jvdm9DZEtvVW84TGVqK3hwMlpkYlNTTk9LdGc4?=
 =?utf-8?B?VGtJaVBFOFpXMGVnaUQ2ZFRseTVhL29QOWYxS3VpRzNWeUxzODBncnpBaDdr?=
 =?utf-8?B?cTNSbitvRUxWdkxtYk5sTGpqMTBPSGNucmN4U25mRUU5czZRaGFua01PT2lq?=
 =?utf-8?B?K3hYNjlDVTFPUzBLZ2dRd1dzNEt1WlRPVlRBQjNyYU1iR09JdmtLU2VTMnFo?=
 =?utf-8?B?R2RlUzE0ejgybVNTeWdIaUhNUThocGJMNkVwenNlSy8zVTBkeWFScURzSnZN?=
 =?utf-8?B?djFONmdrNjl4ek96T3dOL3lmS0YvcTRVUndlcVlQdFZBNmJWRGlqTXpqUXht?=
 =?utf-8?B?ZVBoMVVoeWFENDBZdzBxSll1UDMxSHpCb1lLcWtzQ3BZMStsN3hyYTNjd29y?=
 =?utf-8?B?cThtN2tjMm5maWNMZnl2WEdCWkJwcFVvSlpxT3dnSDZUM2Q3NVBkMXpOYTVZ?=
 =?utf-8?B?bDEyclV6ZnRPUkhGcWQ4aXNZdmEvWERHcVo0U0dBTkRvVnlxdkppRUd3Y1By?=
 =?utf-8?B?cksxdVlDeUZIV3g3Tk82YUswMDVkeHRHTTY4NTVyU0NYTUgweGpwVmhRN0xm?=
 =?utf-8?B?TkwzZjdKLzdnY1pjejU0SjlGTFl2RjFPVmFoRENESWZrcWN2dTFhSS8wRHo2?=
 =?utf-8?B?WHE0dGhHL2hVOWlyUGtNa2JxUElybzk1dXpEeVE3bXFSVWdtMGZCcjdhTFBp?=
 =?utf-8?B?NGRhaS9rR05FQ1BSZ2JESmNCQ0dLUFdaYmhtT1B3Z1BRT2diTVU4Vk5JZDI3?=
 =?utf-8?B?d0lFRk5vNW1ndHJOTXhRaytnMnF4NGhJcE9hL1dqOS9FTjRYZzRPT2ZRczJU?=
 =?utf-8?B?ekVMWEtSZHhoS2VoNU5ZdVdZbjRLdDVTK2JFb2x6MkVVK01GSkZ3M1MzWkRv?=
 =?utf-8?B?WWhEY2dwUGswUis5ellsWGo0MlZ0REJwTDV0czh0M3lTUXFnbzFxM29uU0h2?=
 =?utf-8?B?c3MzSkZsMHNiazExamQ3V3owczlXeEswSEpDWWp5azFWZEFHZkp2TzViNlhV?=
 =?utf-8?B?TmNRYS9aMjdveTk2bHB3NlhUU2xyOWc4LzJoNmtvWnM3NEJ5SUM4RGt5WUY1?=
 =?utf-8?B?K3VCQ3UxRUNLcWVHRnJnYzJnaXM2bmdVUkVuL0tOVEpwS3dia1lnUEUvNFlN?=
 =?utf-8?B?RmVUNStXVjRxam5KaUpKMXNZc2FTYlMyRnBTK3JQOXFQT2ZMb2MyM3JrcEV0?=
 =?utf-8?B?U0dFVU9yQ3RWYkF1b3pzdytTOUJONlR4VUlsYXhqVXN0SWZtelZCWE9vMVhM?=
 =?utf-8?Q?TtC72oi1InR9iGPvn9UeSos=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d356775-4ea3-4099-a6c4-08dcc7039e3c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:49:13.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpTrTiZQWwNRJ8A/oM2G8s75fhOazu7RJwi4JUMWBkEHw9Esik98X+duiwHS2yA1TLXHMaEkOa8w15MZA/mJrX5RVYmgupArJJ7M6J29+kKDEt8/UiTE7jEJTAykeIYb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7568



On 8/27/2024 1:23 PM, Leo Yan wrote:
> On 8/26/2024 10:35 PM, Steve Clevenger wrote:
>>
>> Changes in V2:
>>   - Updated mailing list distribution
>>
>> Extract map_pgoff parameter from the dictionary, and adjust start/end
>> range passed to objdump based on the value.
>>
>> The start_addr/stop_addr address checks are changed to print a warning
>> only if verbose == True. This script repeatedly sees a zero value passed
>> in for
>>       start_addr = cpu_data[str(cpu) + 'addr']
>>
>> These zero values are not a new problem. The start_addr/stop_addr warning
>> clutters the instruction trace output, hence this change.
>>
>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
>> ---
>>  .../perf/scripts/python/arm-cs-trace-disasm.py  | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> index d973c2baed1c..6bf806078f9a 100755
>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> @@ -187,6 +187,7 @@ def process_event(param_dict):
>>         dso_start = get_optional(param_dict, "dso_map_start")
>>         dso_end = get_optional(param_dict, "dso_map_end")
>>         symbol = get_optional(param_dict, "symbol")
>> +       map_pgoff = get_optional(param_dict, "map_pgoff")
>>
>>         cpu = sample["cpu"]
>>         ip = sample["ip"]
>> @@ -250,13 +251,25 @@ def process_event(param_dict):
>>                 return
>>
>>         if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>> -               print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>> +               if (options.verbose == True):
>> +                       print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>>                 return
>>
>>         if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
>> -               print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>> +               if (options.verbose == True):
>> +                       print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>                 return
>>
>> +       if map_pgoff != None and map_pgoff != '[unknown]':
>> +               if (dso == "[kernel.kallsyms]"):
>> +                       dso_vm_start = 0
>> +                       map_pgoff = '[unknown]'
>> +               else:
>> +                       dso_vm_start = int(dso_start)
>> +                       start_addr += map_pgoff
>> +                       stop_addr += map_pgoff
>> +                       map_pgoff = '[unknown]'
> 
> Every sample has its own field `map_pgoff`. So I am confused why we need the
> sentence: map_pgoff = '[unknown]'. And you can see with above change, we will
> set dso_vm_start delicately with below code section.
> 
> How about a simple change like below?
> 
> @@ -267,7 +268,7 @@ def process_event(param_dict):
> 
>   dso_fname = get_dso_file_path(dso, dso_bid)
>   if path.exists(dso_fname):
> -     print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
> +     print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr +
> map_pgoff)
> 
> If this change does not work, I am curious if anything we missed to handle in
> the perf's C code (frontend).
> 
> Thanks,
> Leo

Leo,

Sorry, the map_pgoff = '[unknown]' instances are actually leftover debug
artifacts used for print type debug. I resorted to print debug after I
didn't see success attempting mixed-mode debug with Visual Studio Code
on AARCH64. If you have a known working launch configuration, please
share it. See V3 of the patch series. I've rebased to the
perf-tools-next branch.

Steve
> 
>>         if (options.objdump_name != None):
>>                 # It doesn't need to decrease virtual memory offset for disassembly
>>                 # for kernel dso and executable file dso, so in this case we set
>> --
>> 2.25.1
>>

