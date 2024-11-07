Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D63364D6
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730950874; cv=fail; b=FhsOwIbHVvUmHvcZ3oE3f+8ek/YfzdzJQGX7qdU3PWSdkgG0rOp8jDVMSlqW4LG5PqLCHPcZNSrePcpMP7vOBiN78SxCluXUs7upRXVHA2auYbgUwoHQn5FFp2tA6GCTqNqniiRsl9pWwGAL8+UU+T0nuHnt9e59lE+b9MNxHUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730950874; c=relaxed/simple;
	bh=5yXT2JTq69Ao1QMgOSCnjvtQ2eduaEiGi+LHxiQhcqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ltUuV0709FzoxEpeyg9Q5CUH1DqFM6gcd4hMR7NPyXxQKB1qBS9y3uPh3KkBE+vglnIzyKWa//T78nOijAqVO5E/FLkwb7mmS0UJkQEt24J1cIVrWRT5t2QJrAa4Fvq7vwFOG3LDeLC8BwMJmluICUXd72KAMrwpaP0mVTeFLg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NBnv3ZNF; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NBnv3ZNF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7oS+Lv51zdSr5c4/KNAwX2HzOP8Fdb4S6qLb8gRG/5TIXPaHm+cft4OtBwpifF115oJpMMHcS2jb/1hfraRAFLbZzb2QCfcPFCwtqrT6zg6qBtKkWGre8U/Oz0OrsLTVLUMiz4Z22G7rOw6bv6vbr0O8ql3NsLcgXJcWG+CSEJJU/leAiRhuZ2HT8s1e8MsyeUR9Qvxhh50d1WA2tMWS6ikSTzaYoxHx4VmmzvtPnARn35bG68yP9PdNBvvtx5zcDwLe7oNCGwB5bVVE2wgyAC6AOPd+BAyUlXL0fT7EkQfxHTr2OO0y5KEJgirNu1jhj1kgY/ClAgeiUghhFp+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewHgEtXH5EQDxrhGIfYCz5Ugdx2JCfOjiqkpsnfSNNk=;
 b=gIa/vgVxqnEdNgLiD3jnff0l3dnVRjXgHeeCjsVzG3IVPQ9wCGpvyuGzXDXsq66Cm8iaIhwswx4ponX6lwqgD71bQECyGfNlUnVeaCiAYbghJhMahUoZ8QlOiv/5RauDNy0ZJKsOauzlouQ+N0sGBXzs98oco6ul6ITVzxuiMtFPeGxtbrGE39VIHrbGlq6OPu1dNmYoxD2V/OGHrLUsheMxd++toBd1I/9wW5g4yuJUwDbwKsHGA6bk5C84HljCcJPBhU2Yswc3NenZXjXVyRnQDkTJhYzOSYTfuC9rcbIFDOA6cIMSYjvXWdS2U2i36+oz3kQTDVowAYALlKHGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewHgEtXH5EQDxrhGIfYCz5Ugdx2JCfOjiqkpsnfSNNk=;
 b=NBnv3ZNFeR0xBZUKfUP4SqprbHAWSAwRZhidDGka9L3TNYrrUWYX51CFZ1JAiHSEed4sMV/NNePdZxfZTD4UbOvKi+4vfE/pC1C9Wg1+iSZMXGSkCQwtQDMFkkfYrMkJ/zCOy6LYfOyarjcravVFIS7VZ/pFWkrYOegOzAJttNbfWrbSpE9j+FAdWtqRvE2lxoQzbaAfwqX67/NwnsIowdaj1HgR8qwh3ff3bT6t4rPm98Rp4AYNERj86e3m3NuBEiLFiJ4SiPxekF5SJCVMsbzUpT52f/uhxRTn03trh13wG2dWpY7zNqsWdGgckAs2H4H7i5wzS+8NTp/jfmMUpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DBBPR04MB7593.eurprd04.prod.outlook.com (2603:10a6:10:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 03:41:08 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 03:41:08 +0000
Date: Thu, 7 Nov 2024 11:38:53 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Ian Rogers <irogers@google.com>
Cc: john.g.garry@oracle.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	sandipan.das@amd.com, bgray@linux.ibm.com,
	linux-perf-users@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] perf jevents: fix breakage when do perf stat on system
 metric
Message-ID: <20241107033853.bd57dmjszw2tqhvk@hippo>
References: <20241106085441.3945502-1-xu.yang_2@nxp.com>
 <CAP-5=fVN93EJN9FqMmF6h2meiLbU_OWJ2=Vt0EVdZds6nZSKpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVN93EJN9FqMmF6h2meiLbU_OWJ2=Vt0EVdZds6nZSKpA@mail.gmail.com>
X-ClientProxiedBy: SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DBBPR04MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8d4ab2-104a-40cb-8e06-08dcfede03ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um5VaHJtWmVhbi80dHF5Vko5bThDY1dzZ3VQamQ2Rk83ZTJvcUg5QmZhYXBO?=
 =?utf-8?B?NkQ4Z0FEaTNyS2M0bmtid2RUU0lCL0ErUWpnN0h0UjRiamp1cGhBSkZPeHZT?=
 =?utf-8?B?UUQwazZjdkF6WGdxeGlxblJjNGtmdDlpTUpWbkw4NlpEc01LWUYxTG4wMmla?=
 =?utf-8?B?L0s1Z24zTE51RjVTRXo5dVQwakVQMTVpci9xTkwyc0NyOEpsejFnTW4zc3BJ?=
 =?utf-8?B?WnZja3djMVNZWkhqbzFBeDNaOTAyWEluN0YyQlNvdEx6WDZlSklWM2doSFJq?=
 =?utf-8?B?c25OKzVKbWpnRWFVUDBkUzdJVU9vUGNJWDhaZ3RxVkxWTWNTUFRsUlVrU3lI?=
 =?utf-8?B?a2hNUERiSFZJbldDd2E2SExIaW53SHM0c2svVVIyZjR0WVZjMjRjUzRzT3lO?=
 =?utf-8?B?RUVNaGFJQUkvSTdJRlMvZXJxYyt1ZEpSS1V6VTFKWXNyL3V1ajZ6SXp4T1lW?=
 =?utf-8?B?aTgxTnJXbUhHOU1DZ1hQR25YWnQwckRIMU9kelZwaWx3bjJYT0M0TUdMV2ZY?=
 =?utf-8?B?WkYwWkpDQ1JYeExsWnUvV0dmNW1rQndwWkMyM2FvYUd5QWhYMnIxeHk5WGQy?=
 =?utf-8?B?blIzVTgwTmVOV2VTVGhscEdaQldUNy9qS1RDUVpLMGJ4WkFPa0lHbkdRYjRC?=
 =?utf-8?B?SDlTY2t4YlpSTVQwKzFabDFUaDlLcTlVYUxTejd3SHZidGxsZER5OStoemFU?=
 =?utf-8?B?K1NBS2wyOVFJT3QyMlJMUnkzczI4RkxGWGVnb3o2aWJsdUtlaFNudkQ5UFcy?=
 =?utf-8?B?cmtUYmdJVXFyK2xBUVhxZWlwS0RvZWs4VWJBMEt1NjhNQkVPeHJaOUhzS2ZP?=
 =?utf-8?B?QkZ1K1lBNWFzYmY5SmNJY3FEaWtIaWJORk9XRWJ5MUVLYkMvOG1qeG9iK3hh?=
 =?utf-8?B?aEdHU2I1Sm1CSms3VFczZXZVeFBySE5XMkptdjMvTTVHL1oyaWN3Zkw0MjVY?=
 =?utf-8?B?WC8zVSt0VElsbUN5SzFnY2RMSEIrTkhNVldjUGN1L1F2dEU0TXFlbTErT2V4?=
 =?utf-8?B?enB6VFRCcnNzQ2EwWUZSVTdWODJ6UG9DWUlEN1orWUMrRmFqQ2NXKzFzcy9U?=
 =?utf-8?B?dWd3OGZBZUNzNTNyeG52S09DK09malc3S1VZOExaYTZqM0Nwa1Nub3crQ3Rn?=
 =?utf-8?B?WTFhbHlvcDBhdyt1a2hQYXFuWGRTYUtsbWRVaThZdTBYUXYwUk9Yc2ViVVR6?=
 =?utf-8?B?M1RCeExGQkxmemRVU292UUowdm92ZVloMDgzd0hUaTNhNkJvZ05oTWF4V0pJ?=
 =?utf-8?B?QWNYUVpCTGdhSGJBdEE5d1k5bDlVUytLbFFLV2diV0tiVzBDWmFZVk1EVWZ1?=
 =?utf-8?B?dXBVTGRkRElOdExKakVyYk92R1B6R29iU2RTSFJlREU4VTlWZ3hIdmdlWCto?=
 =?utf-8?B?N3NyWDlaVnIxczRYaUhkT2N6cGN5WDg4U3BFamVyeXVqWEhwVzl5NDhQNkEv?=
 =?utf-8?B?SlZXUmt1SFpFQ2VYOERjSlZCcUVuZ3RmcmF0WEVFaW9LZDdNZk9Ta3JMdkFC?=
 =?utf-8?B?bGJmTUFyOXVkMEgvTmRIVE9nZVBMRkV3NEFYQ25mb2llUjNiL25EOXk0WWI0?=
 =?utf-8?B?VFlWcFUyVkVxcGRsaS9MajVuclBBK0hyQlRnc1FYUldCeXZ4Skh2R2laUDNv?=
 =?utf-8?B?TW9pY0NBQ1pNSHlZMW5mdi9GQXN6SUVucXJtc0lPdUV0amFhYTZTdTJ6ektI?=
 =?utf-8?B?bkM5UEJiWU8zaTJYN3JONDhxOW95QVZjYWZyN05iMFY2VWZoWmxHSXl4ak12?=
 =?utf-8?B?QkVvS09EaGV3WmlxQk1CYzJwMUNESy9mZFllMjZlbU9NdVY1dm9FWmF1b3JN?=
 =?utf-8?B?T2FWMXZnTzA5L2JxNVVGV0VheFdONTlhditTcXhsZGhBT0FuUUcrM3dYMDR1?=
 =?utf-8?Q?pVKj9aZWMF838?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnBuaytIV1RXRHZrc1pHZXRTU2xMWkhKYnZnNEt3dTlKWmhINnhHM3NydDNK?=
 =?utf-8?B?Um03TXhjY1kvZndOMCt2NXFUOWs5UFNIbFVsMXR5VjZGdG1QTjVNeTV6OGFG?=
 =?utf-8?B?enAyU1hkZVFUMjI5eW1HUXAwQWpvWmlFb2R3a1BKOHZBOHphUGQybkhJOHdW?=
 =?utf-8?B?WU9XdWczdUFGSjR0NkEvRDJDalQ4Vys5K0xYaWZmRTdjTHNydzdjSEZHMnN0?=
 =?utf-8?B?RVcrVHVCU2dENlVYVnJDZWx6aUwvblhyLzJjMkFDYXV1M3hMOW9weGwyRUNW?=
 =?utf-8?B?TlJ1N3hmTUdISjJQWHV0UitvWlZOTG8wTDJ2VVh0NVV3UjZQbWR5YWtTa2pJ?=
 =?utf-8?B?RHg0dHBoaWRnWTF0TnpSYlMrdmphbWtPa2pRMEdJWFdnOG1DLzk4eElrQlpa?=
 =?utf-8?B?UUFqbE9PZmgvTlBSZ21aT1gwMSsydzcxeW1rcmJUeWJCRTBwZzRhQll0Y1BX?=
 =?utf-8?B?VXlLZmRzVUFoN0hTSkZDMEZtV1oxTzMvSGJ6ZmpRTG1UUEpiL0V5U3F4clpY?=
 =?utf-8?B?R2tONHN1MU5KeEVFRmJKb0FKemlIdk0yQlR4d1c2WUwvaEtObUw3ZEFLbnBR?=
 =?utf-8?B?RWlpazhyaUVDV1ZWNXZpaXhzNjhhZk9iRkxYN2VnZTUza0pkWTBRY203YUE4?=
 =?utf-8?B?VlRsb2FlOXQ4QXdwNUpiaXN4ZzBsS2VLMnlnYjhxcWZpZVZuanEvU1l4Wmtp?=
 =?utf-8?B?WEFHazVsT0d6S1JXTzMwdEF2Q1hFcmlURzlVVkNFclN0OXBOU0N2UFJHOHpx?=
 =?utf-8?B?WTZwRFk5UEkzaEk0OUxPVHpQTUdLZXdsQnUxY2xZRVVvTHltamZyS0xQM2pF?=
 =?utf-8?B?NFlweHJIQ0QvK0xWdHNndGs1alRiUWdSRU1nNVEyNDlsMWNXSms3V1pqd1M1?=
 =?utf-8?B?Mm1NREt5Z2lRblpSRCtzMXFjSVZCaUZiaTdqUkVZZTBjZWd0cW44Vk82S3RX?=
 =?utf-8?B?azdOMzRuTlhBNUdPa28zcHRlRU5jNCt2ZXZwME5oWEZLMVpvOUpxSk5TSU1m?=
 =?utf-8?B?M0tyZUNwLzR3MlZVbWNOcGh3bDJJcEg3RzZ6L2MzVFhKZmFreWIwbmhiMmFW?=
 =?utf-8?B?UTRnZzdKRUpSaXB0b2YwaW9wRURaMXRBamxER1V6TTM0eXBONHFHZXFSajB4?=
 =?utf-8?B?Y0Via3hSYzdxTXVVS3hIbDc3bERrMlFDajhBcElOOGpBdFdSODJYcmFMRDY0?=
 =?utf-8?B?c1Z2WXYzSXdkSitMWGZUMTRIZXdrNExXTWpkUzZzZEhSN1hHdG9TLzRHaUgw?=
 =?utf-8?B?N2RwVUt1TnBzQTFYcVJCY29takc0UWtpRG9VeWUvSW1SbDM1MkZWKzRKZnRN?=
 =?utf-8?B?bHJsc2ZnUUNzUU9QK1RBWHIySCtYRWJCZ3MyS0QwVWVkcnk0ekxaQzgvT0sz?=
 =?utf-8?B?dDdIdUdMZDJUSWVmZFpHeng0L2JOYzZVaDBDR1JtMkswSEQreEJZSU82UTlV?=
 =?utf-8?B?THZjT244bXhsczBuUEFqbklaK2Z5d0R6TEtyZTM3VXBnQkpnVzN6UExkUThs?=
 =?utf-8?B?THAzU0pSNjhJaGcxV2cvaURsRm40eVREWk00TjdkOGdTSU8rRFdOQnNqSnpB?=
 =?utf-8?B?eUtlYW9kdDZRM2YxNnJzcGFMT2YyMXd5RG1aUml0VlduenpjbFdWcW05bEFt?=
 =?utf-8?B?THZpaUZCSGtZVDdoc2I5R1Q0Z3A1a25ZbWdmV2I2S01zL2NzZkc3VXVGVUht?=
 =?utf-8?B?TTVXdjVVZ2UrMVNNamFHMStES3R0alhKLzQ3SlNQc3prclBVUGYvdjdWUUp0?=
 =?utf-8?B?Zk52VUdHZ2FyUW9qT1ZVeExseEFiYmFZNVcvYk5QMDd6RWVTaDd6SUczcDQ3?=
 =?utf-8?B?SWdHYnU2a2k3SHpRZDVBeW5MYzRlc0FrNjNSTkg4YjJWMUNpTXYyTWVkdXVB?=
 =?utf-8?B?eWlxdzNpSVEwSlcwak5QSVBSaFhJOTBIdFJTazdDNEhVTVJTMkF0R0kyRUFx?=
 =?utf-8?B?TlpBa3dDVGlpZ0hkbUdpYm11UldSM0gzRlduS0NPS3NKZnRmd2xWUWIrU09j?=
 =?utf-8?B?L09Rd0RRQWxoN1h1WFB2MDNQQnFCNFYrbnRtM2o4SlZJUHVsbDFiejk2aDR1?=
 =?utf-8?B?UWFKS3NuMFJWcS9xRjgxNGJIQm9NNEJxOTBkdUd0NW1ST0d4RVRaL1JrYk9h?=
 =?utf-8?Q?hZq5o0pzXw0z9bAR28ljb66Vg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8d4ab2-104a-40cb-8e06-08dcfede03ae
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 03:41:08.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwLYPHGkElDqM54Q+xcDn/uN5tyOvFZR0U72CMSzIZ5RONGYihV6GDzets1uDgH2khUAF49aYbBQTNvU3bV/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7593

On Wed, Nov 06, 2024 at 10:06:24AM -0800, Ian Rogers wrote:
> On Wed, Nov 6, 2024 at 12:55 AM Xu Yang <xu.yang_2@nxp.com> wrote:
> >
> > When do perf stat on sys metric, perf tool output nothing now:
> > $ perf stat -a -M imx95_ddr_read.all -I 1000
> > $
> >
> > This command runs on an arm64 machine and the Soc has one DDR hw pmu
> > except one armv8_cortex_a55 pmu. Their maps show as follows:
> >
> > const struct pmu_events_map pmu_events_map[] = {
> > {
> >         .arch = "arm64",
> >         .cpuid = "0x00000000410fd050",
> >         .event_table = {
> >                 .pmus = pmu_events__arm_cortex_a55,
> >                 .num_pmus = ARRAY_SIZE(pmu_events__arm_cortex_a55)
> >         },
> >         .metric_table = {
> >                 .pmus = NULL,
> >                 .num_pmus = 0
> >         }
> > },
> >
> > static const struct pmu_sys_events pmu_sys_event_tables[] = {
> > {
> >         .event_table = {
> >                 .pmus = pmu_events__freescale_imx95_sys,
> >                 .num_pmus = ARRAY_SIZE(pmu_events__freescale_imx95_sys)
> >         },
> >         .metric_table = {
> >                 .pmus = pmu_metrics__freescale_imx95_sys,
> >                 .num_pmus = ARRAY_SIZE(pmu_metrics__freescale_imx95_sys)
> >         },
> >         .name = "pmu_events__freescale_imx95_sys",
> > },
> >
> > Currently, pmu_metrics_table__find() will return NULL when only do perf
> > stat on sys metric. Then parse_groups() will never be called to parse
> > sys metric_name, finally perf tool will exit directly. This should be a
> > common problem. To fix the issue, this will keep the logic before commit
> > f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PMU")
> > to return a empty metric table rather than a NULL pointer. This should
> > be fine since the removed part just check if the table match provided
> > metric_name. Without these code, the code in parse_groups() will also
> > check the validity of metrci_name too.
> 
> So we carry this code for ARM:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/arm64/util/pmu.c?h=perf-tools-next#n21
> 
> On x86 and other architectures the PMU is always passed as NULL (the
> effect of this change):
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n843
> 
> The blame shows me as the author, but that's because I factored event
> and metric tables to be separate things. When I did that I brought
> over ARM's event table logic to the metric table.
> 
> Why do we pass a PMU to this code anyway?
> So on x86 the cpuid will give a different string for
> heterogeneous/hybrid/BIG.little parts. On ARM you get a different
> CPUID depending on which logical CPU you ask the question of. The CPUs
> associated with a PMU are used to look up the CPUID string.
> 
> This whole thing is spaghetti code (fwiw, I dislike the whole arch
> directory plus weak symbols thing that is a by design breakage of at
> least cross platform work - hopefully the maintainers will review [1]
> so we can delete a sizeable chunk of it) and the ARM situation looks

Yes, the logic seems like a little mess when parsing metrics because some
system metrics don't bind to any core pmu. But I'm not familiar with the
whole code, so I unable to make big changes on perf tool.

> sub-optimal. We really need to scan a plurality of metric tables for
> the heterogeneous parts on ARM. We're passing a PMU rather than just a
> CPU, I think passing a CPU would be more intention revealing.
> 
> Then there's the pleasure of system metrics, which are only loosely in
> my mental model of things as John Garry did the heavy lifting for
> these.
> 
> So the problems I see:
> 1) ARM needs multiple metric tables to be parsed in the metric group
> logic as the invariant of 1 CPUID 1 table doesn't hold on ARM.
> 2) The lack of a metric table causes an early exit from the metric parsing code:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/metricgroup.c?h=perf-tools-next#n1700
> However, the system metrics pattern conceptually match PMU names and
> aren't tied to CPUIDs. The iteration logic still uses the metric table
> though:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/metricgroup.c?h=perf-tools-next#n1283
> 3) Crufty spaghetti from the use of arch/weak that means we aren't
> testing the same code paths leading to divergence and rot.
> 
> I'll try to pull something together. But for the sake of expediently
> addressing your issue:
> Acked-by: Ian Rogers <irogers@google.com>

Okay, Thanks for your input!

Thanks,
Xu Yang

> 
> Thanks,
> Ian
> 
> 
> [1] https://lore.kernel.org/lkml/20241017002520.59124-1-irogers@google.com/
> 
> 
> 
> > Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PMU")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > ---
> >  tools/perf/pmu-events/empty-pmu-events.c | 12 +-----------
> >  tools/perf/pmu-events/jevents.py         | 12 +-----------
> >  2 files changed, 2 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> > index 2b7516946ded..b8719dab264d 100644
> > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > @@ -585,17 +585,7 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
> >          if (!map)
> >                  return NULL;
> >
> > -        if (!pmu)
> > -                return &map->metric_table;
> > -
> > -        for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
> > -                const struct pmu_table_entry *table_pmu = &map->metric_table.pmus[i];
> > -                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
> > -
> > -                if (pmu__name_match(pmu, pmu_name))
> > -                           return &map->metric_table;
> > -        }
> > -        return NULL;
> > +       return &map->metric_table;
> >  }
> >
> >  const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index 6e71b09dbc2a..70f4fd5395fb 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -1101,17 +1101,7 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
> >          if (!map)
> >                  return NULL;
> >
> > -        if (!pmu)
> > -                return &map->metric_table;
> > -
> > -        for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
> > -                const struct pmu_table_entry *table_pmu = &map->metric_table.pmus[i];
> > -                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
> > -
> > -                if (pmu__name_match(pmu, pmu_name))
> > -                           return &map->metric_table;
> > -        }
> > -        return NULL;
> > +       return &map->metric_table;
> >  }
> >
> >  const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
> > --
> > 2.34.1
> >
