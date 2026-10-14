Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020094.outbound.protection.outlook.com [52.101.196.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD85616D2
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001646; cv=fail; b=qfSdDa4VNKLdtSGUG49qSWiZZF4uqBaIepgtTslTdnqzbeeLbe7fjHnamv3KwXBZaWpHY2ERPNohHeKiEMHdLRY/VvAmTQl7Zou7upQAi8xn520bxEMOy9bfsnPMOVmXpp+jpIGJiPmprqxZrzaLLM15m0lPIsnl1CeQTM7roxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001646; c=relaxed/simple;
	bh=U2HluvUPqDsBPStc/CeVQkYPo7SgnWL/8kSmOBWnANE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=So1lXMMLEw7D7U1wx4QCUgHr7eeQzOhWnfBXJsM0jjCXEivg11aMFH3N77ot3uOpq5BGGx678lNAROn5h84+Hr6dW9m/zdRlNtbm0eBOicwRRreXPRApWoSuhBx8IbpKCxiR4lgqpkG5p1XvM6ShUhLoVDQ74/n6bYREekk7q5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBugw8bYn1x/XRw2fjXw5Su+uEYtlgbiHmIOb45uvo256sKdiZce8WQP6bnfCQpD9f5a0OdsbefH4G5PONE5kWmMCWjIIvliNbuSqBQrj7+CfOlLtTRkxkDl9RQCi3yXnKJC8Do8yF7HoFtGR5gtUu3BpBUDOMc0OqroWNdejR3g3aBtz/BUMOM+in1zsg2niRttlx0viVeP8vapQc68Mv9qMDG0Kbv8EH8UCW9NwByOaWwHMaaQ/gdTuBSBqGE0JuLhsIZaxucvU5t8Kay3pw5Ido5/UbhyCInpoWFqEEZUUIAa5Anho3jl2tzhF6iYPwQnqvZ5IhUs2FEyzV480g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=4dDycUp9QVeXu0+gnr1ekBjpDRprCViQfAurJWnF/iI=;
 b=ojrLYWQg/AUUkBlNejSrBHjDBiqlhY8nCDTpXDHnr5/xb71iY3VefL6u3bb44qLgxPvGYrTNAo1bLyADepYM5+PNyzm6UVJkEbLNL6CjYN+J/nMLoWXcNTFbfWpj+uatqv+MglIePGIwbaMp/TQA9aXh9eyyHYZsyVaPVAI0BB/jDI4T07QI0iEXNSVtrismcT7929N8g8gz5pegBYqzl0peENEPJMda6L84vGMKIXC/zG1x3YsO9WjyamNGqODZoA+Rw3opGLGFn3086v1Lh15NKyEis2h32Bj4vcrZbJTMT4y2m3JcpL17ruKtNmsMAOpBwRKmZnr4FlCgB5lzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB3233.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:5f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 18:14:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 18:14:01 +0000
Date: Wed, 14 Oct 2026 14:13:57 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v4 2/5] perf ftrace: Support filtering
 return address comments
Message-ID: <ooxbuadvpfsqjkmc2yocosnpb7wr44p7w4dqc5gdw6nxdp6ahw@2ah7ob62eh37>
References: <20261014161457.373253-1-atomlin@atomlin.com>
 <20261014161457.373253-3-atomlin@atomlin.com>
 <sashiko-outbox-171524@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-171524@kernel.org>
X-ClientProxiedBy: MN0P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::26) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB3233:EE_
X-MS-Office365-Filtering-Correlation-Id: a751af2f-3c08-4bad-033f-08df2a1eec10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|261009223027099003|3023799007|4143699003|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	fy8vfAoIKek+DpeRMvaXBndrKBxM5OgllvHagzgrM43+wEMGdgrFj+8Ayuh852bH+vfIIIOsWgjp68gLDVoyCkcC23ywkYm/n+pY+yz34eM98kcQxrowvOsM2Nnn7ohX2J1QDiZf4+EUpq1RKNUNLGQK6qe1c9CkTQ50DnKglWJ4ovc9oT4lZKelM8Fd/QRm7+TgthQw39YWBs81iZQoG+jkhVJYd30zT0LwjhJmgjRA5KBNPQgbL3uRZ2NF0VCA4cKbw4nxNXwxkjM5ZAjDQmQbvk+84yx+eKURfv63Q30IUeA4HhwXw5uNss2mXIBL9lQDXhReFDp0hYnk0/wS1lMSGmrOJoDZifiKYzh6jha+ap+8N0hufubICuycUTW+A4bz87XN9VDThkR0Z79+P9ICum5W/xzNlGePPZSg16cyu07LvDYU+viYmuEJmDP15HboQrMMIDeCffO8a8G/nG2+oojIy91nPgaGXl+cUkMWqmlNs/JH84mWR93IzIUVv9rrDcMflrp8FWS7AjKc+iyv7hcRpUGUwLcOcA/bheleG002QKPChWRZwLGwZZi58/2tgDRn+N8zGu0lYKKd3XL7qV2wNTNSeZ4jNvc7PQTkTcK3I08S+yoBNZI050yVG/G14KPjvkQth5NA2rH0fFZQheaKiKQ4s7WJSa5Q6oA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(261009223027099003)(3023799007)(4143699003)(6133799003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGpFMnBOOVZLVEtBSTd0UlhmMnUrL3pwbVN4TEN0ZzhZczJubVlWeHFBWk1z?=
 =?utf-8?B?QkVZdUd1R25hRUhRMDdYRmNIek5qMHZnM3FvK1FST3NPZkxYeFFQTEEyc2VS?=
 =?utf-8?B?S3pEVzlRRnc1UDR0cWJaKzhUNzJ0MTUyNGhsNGJFb0ZjVjlCYjZtUzdOZzZp?=
 =?utf-8?B?WEowdTVKZnFuenVWWUllT3RFK2x2a3BXYTIxWWV4ejRtcGRpbVlMOURWc3dz?=
 =?utf-8?B?V1NwS1hsdm1xL3M5ZWRPVkpXSVdPZXlOcGFEQVVHeVZ5SjRUV2ttTVRGd1V6?=
 =?utf-8?B?bEJ0ZWIxUmR0aVBDc0dvcGhPT25vZmNHenVHYXdqSFhQQlVXY082MHQ1WGht?=
 =?utf-8?B?TXlWZFRoYzJQNnFCSmpuNDg5SDdGck9xMXdYWGhjdVYrbEQ5V21EcHgvVWpt?=
 =?utf-8?B?cGx3dW9nTVhiY2l2WlIxb0hFdHFrT0pEdWgzVWlYVHZOOWo2d0ZDbklpZjlB?=
 =?utf-8?B?dDRPUUdRcUNLWDk2MklMQytnUnhmV2RSVzhyRkNXSXZtbXJDdWpzaTMzQlNa?=
 =?utf-8?B?SkVJUFhiL0pqdTgwYlVnTUJNQmNqODF5YTcyK2lqTEJKcWN0N2o2Z2VBSE9s?=
 =?utf-8?B?SDZUOElraHJFc0xmNG1vUFFLcFJsV2d5YVRrWmFITmxESHFDclp6bk9ZaWVF?=
 =?utf-8?B?d0xVTGJhd1JtaE13T1hFaWxWaTBqRDNrUk1sNDJvZHdhV0dYS1kzd0Rvb2gw?=
 =?utf-8?B?T2RhZGxCUEVhVHBZbUZLUys2NzZ3blNxSWJrRE83bnlPQklwYzZib0pHOGgz?=
 =?utf-8?B?YU5nSnBEMTRrbDB4MUlRaE5VQTRORVJ3VUJaUzRzNE16TGhRMXBzZEV5cGFG?=
 =?utf-8?B?UHZyOUxjektDTEpPRkxUQjE5YnhQSlBWQ3YybHpob0pocmFPMGVsTnFURTN5?=
 =?utf-8?B?NTZpWGRVcDdoSi9yR2ZPbTNRWk13N2QzK3hMOWl3RlV0czZwWFFaZDJGR09Z?=
 =?utf-8?B?M3dIN0xEbHp2ZjhJRFp2a29sRWtxeSsweEJiMnJqbTlnbmVTbXR5VlUra1Jj?=
 =?utf-8?B?OWs3S3VySDlFZzBCV1doQUR5aE9nZFhmMkNxZ3JLSm14VFhmaFdzSCtBOGdl?=
 =?utf-8?B?WXNxWGFhbWw5UmlmcUs5bTRCY3JIQlEvYVo2R2hRK3Izdm5FS2hFK3ZqQ2Ja?=
 =?utf-8?B?elFCTHV5alQ4ZjJUS2hlVmZBU3lia21hei81anpZcHZxNmtPRzlLY3hBRkZ0?=
 =?utf-8?B?Z25GdVdTcXFUY1Rqa1VabDFkWGR4dUVvVGltSFRuQ1JBUDVMeWJTeXNSSUdo?=
 =?utf-8?B?QllVNjNrZDRYeGRPeXcreEYwMUF4QnhXL2s0MUp5WkhXaGZFbTZjZTBuKzUw?=
 =?utf-8?B?UERvVkF1UmV2Z29BdkRjaHVzUXRDQ2MrV3YwT2NUcmFZRW4vV2JvRTBTQUg5?=
 =?utf-8?B?ajhFdWc2eXd4ZUJRNTB4a2Z2MlNRdEVZZjhEcWR6NXV0cE1zblhFQ21EWWE2?=
 =?utf-8?B?YXNTTTFZUDlzQWFjTjJUVnZEY3ZuQ3Vxd0psVUZjM1g3bkNZSTI5aHl3Z2l3?=
 =?utf-8?B?QXZoSmpoWFh2aWwxQkpMRk55MXBUNUFMcmNKeHZQTEExNkUrZjdidXgxS1Na?=
 =?utf-8?B?YzN3aGhiZURGNk9keEdqaVdpTVFvRVlac0Nlc3Z5dDQ2ZlJSY0VWdUZBcDlk?=
 =?utf-8?B?NFVjOW1uRWlFLzhndE11QVZzaTJyYTREd0Y2RHRhRlQ4a0toY3hkTDNaWTA0?=
 =?utf-8?B?ZXBMc0xPUEtobjh1SnFqREF0d2hMN0dCMCtLcEY5NDhwVkdTbW40Q09WZjBq?=
 =?utf-8?B?NjVkWXl0NUNnSVYrMUpmZ2wvYTdDNXpnMEVFTGd1c3ZVaHVjWUxYa04yZVNY?=
 =?utf-8?B?NWNOekJmRkdrY3d0UTBzNUxVaVgvU2NNa3FrcHQ3eFo2bzd5Q2ZFN3ZTYmJx?=
 =?utf-8?B?MllOckIrcSt0UHBxT042V2dMV2FaQ2NITUg2Wm5adUcrSDQvZ040REJYb3Fp?=
 =?utf-8?B?dHhhS0lNMVB4TlFGa2JLWTJ4RllnQXZsRXNvQ09TQVRqNklnL2pEZHNqZk5m?=
 =?utf-8?B?ZlcrcmhVeHNIdkloa2Fxd2ZQZVV1eW45ekpBcTA2Uk40a2Nva3pNR1N3dmp4?=
 =?utf-8?B?bmxmd0g4Q3VoeWdhOWdhQ1hsVFVhVHg5SjRJYnhPdWU1cmw2UzZMWXhhVUpi?=
 =?utf-8?B?WVJDbDJ3dXNoSGF0U2JCeDAyZHdGYjNCdUlFT3VVTytiYjFPb1ZPUEVaV0ht?=
 =?utf-8?B?MVdhSjZ0K1FGL0NjemdSMnoyNnZ6cks4eFh6Smo0aERBZW5YV05kekxnYUll?=
 =?utf-8?B?b0ZBdFdreFJOdkNTaURIM3JuZXhSRUljRGNSWjF4Zjc4Q0ZJWDVJMUkrb1h1?=
 =?utf-8?B?SEptZzNaY0RSYUtUL3l4UFFWL3hGTXM0RmxQTjVpN24yUEF5bHhQUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a751af2f-3c08-4bad-033f-08df2a1eec10
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 18:14:00.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU8HfTVRvVey2phsAhAWAa3E/ddaQHhA/IWpClYtDJz7RDZ0ZeJUsiMa5yyNaHLuE+O4PluMSJIiAlZe7VfDhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3233

On Wed, Oct 14, 2026 at 04:24:14PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Will this cause a build failure due to an unused variable?
> 
> The tools/perf build system enables -Werror by default, which elevates
> -Wunused-but-set-variable to a build failure. The local variable endptr
> is written to by strtoull() but is never subsequently read or evaluated.
> 
> Could we pass NULL to strtoull() instead to resolve this and avoid
> breaking the build?

Indeed. This will be resolved in the next iteration.

-- 
Aaron Tomlin
