Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C8A6125;
	Wed,  5 Mar 2025 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156910; cv=fail; b=BW42MFCXjJfvq3oSQVpkbCfiKsTvD1K30/xOi8svNREFax/B4dxsrLKcTvGOKMvxqvmjrV876vm+DvchNV/ttR+cYh1hI2AJv7vXRep7DrFMipBhwES5aREgYVqSRyx+appI4N0lXe4nIBfk5Kz6u25vxJ+vrdT7mveEL5z6aA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156910; c=relaxed/simple;
	bh=MxRhsVHfAsp+6eIhIFsvDn8QtMTWOVpm2Zc4w3mUiu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PNHOS7g98PiEK1oFSh289EEkuzL5UKbqvcon/vsAHQvhOECOYj3cPW9vXzDG0EZorhRqvyc857WNd37ucPsz4PWBGFRCq8GT9MktbcxqDuOCPBQ7iEn0ofeFK3jWzKuBazTkWffr4SzUEXkt7JYdRkC7eT+fk95u2Nefna1YWN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QDEHP1qF; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QDEHP1qF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741156908; x=1772692908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MxRhsVHfAsp+6eIhIFsvDn8QtMTWOVpm2Zc4w3mUiu8=;
  b=QDEHP1qFVKfo0YOaqn6YDisXem+bK60nL20+q8clmW12S8qz3lJ4WOw1
   Es4P/LM3/V9UHfuxNNnKPzojLOP8c4v+nKJVg6I4KrHFvEfiLI1XslT2o
   fwFPd8EXjtJQmmBWoeMFvDX/pXGf15WQaMPmQhDbweHVPKbltfPosnDso
   rzu3GjuW29n6E3nEgJ5/D5gDHvDigdogf5/ZbHYrSmvF+fy45Xm5AEtCa
   PePg+vsQeWfVVhSJiWz6aWNo8Q2juBD9uyYelvxbXvnTkEL0R+V12Anpj
   LQ4FB3IvXGOJdeYsOz36Bs8dYrQhu03vy8UGkwkleoynJb3nmBxKflM41
   Q==;
X-CSE-ConnectionGUID: Yl7a+oNbRRWuTfFoo8+7CQ==
X-CSE-MsgGUID: 6C2A21Q7TtaX0pQju5bmpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="148899427"
X-IronPort-AV: E=Sophos;i="6.14,222,1736780400"; 
   d="scan'208";a="148899427"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:40:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cy5g7cgGCHgToGxtc7H60lhdgIsLfWpi6FFKchuBlkuV5xVvM5alf1OHm6ThdyOgY1ystfHAisrBmg0jCp2RjvmhU7LfVwKlqGE2R1Y5jnbsltMh3vH3FDPHXL7nNS4FMv4A/eCqg0xx+/m4Wa8mOHSp01gBGd6uFYZIp5DeRiqQxu27Vjd/vYDXrZ+Ssr2Un2C0q06XenS4l+MHQokAK8FLqiUZSh+QcTzNurjfWSQr1l9n/Dg67RpluR52fCiHgnAULhTtUnKDxRgYXcVk7v3gUXrMZuxzF9rVqrMc+FlrA4k9XOuY6dO/2GaKV7CEAsKiEVym4B4QGq+bIGSdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxRhsVHfAsp+6eIhIFsvDn8QtMTWOVpm2Zc4w3mUiu8=;
 b=h+fAtB4yHVqzPMxDfKYhMnujU/9OgoJmJSGNUKdbVgC4C89iyUpSSItzKygmb05XF9p2opbkF0ySHn7hjzpCk78c96KkOgXP3beqbzXaiAkTYR+zDN6yttstt521GIYXCa1xPwxSF9SV6vd463sd4HjEjz/38QKUbsbTBaIoY79p3b9dgghygMoAe/P9+pDHgrThX2gTPktitoPIX9xvxvnStcneLsIB3NuhedxB2yp4oAE6NzkEUYU+o6nFDSZ3iDBNyeqg0kWtqaZlaLLVRewxP0m3aTuG/nWmiK+xWz3NRM2L1JfMMJ7rJEVvNzKVZDJjDSq/gtyzJvELOLVFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com (2603:1096:604:12c::9)
 by OS9PR01MB14066.jpnprd01.prod.outlook.com (2603:1096:604:35e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 06:40:29 +0000
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe]) by OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 06:40:29 +0000
From: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
To: 'James Clark' <james.clark@linaro.org>
CC: 'John Garry' <john.g.garry@oracle.com>, 'Will Deacon' <will@kernel.org>,
	'Mike Leach' <mike.leach@linaro.org>, 'Leo Yan' <leo.yan@linux.dev>, 'Peter
 Zijlstra' <peterz@infradead.org>, 'Ingo Molnar' <mingo@redhat.com>, 'Arnaldo
 Carvalho de Melo' <acme@kernel.org>, 'Namhyung Kim' <namhyung@kernel.org>,
	'Mark Rutland' <mark.rutland@arm.com>, 'Alexander Shishkin'
	<alexander.shishkin@linux.intel.com>, 'Jiri Olsa' <jolsa@kernel.org>, 'Ian
 Rogers' <irogers@google.com>, 'Adrian Hunter' <adrian.hunter@intel.com>,
	"'Liang, Kan'" <kan.liang@linux.intel.com>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'linux-perf-users@vger.kernel.org'"
	<linux-perf-users@vger.kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "Akio Kakuno (Fujitsu)"
	<fj3333bs@fujitsu.com>
Subject: RE: [PATCH] Remove some PMU events for FUJITSU-MONAKA
Thread-Topic: [PATCH] Remove some PMU events for FUJITSU-MONAKA
Thread-Index: AQHbiNpQ8JjCRF9TOkCjxP8mdt+sprNa+hOAgAGBj7CAB6SosA==
Date: Wed, 5 Mar 2025 06:40:28 +0000
Message-ID:
 <OS3PR01MB6903726FDA70250F72A73410D4CB2@OS3PR01MB6903.jpnprd01.prod.outlook.com>
References: <20250227054045.1340090-1-fj5100bi@fujitsu.com>
 <96b323eb-15b2-4b60-8522-83bf2f57694b@linaro.org>
 <OSZPR01MB6908AA7CEB24ED38F9289D6DD4CC2@OSZPR01MB6908.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSZPR01MB6908AA7CEB24ED38F9289D6DD4CC2@OSZPR01MB6908.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZGQ2YmU5YTYtNjUyOS00YTkxLTk4NWItYThiNDk3Yjhm?=
 =?utf-8?B?YzZiO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAzLTA1VDA2OjM5OjA1WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6903:EE_|OS9PR01MB14066:EE_
x-ms-office365-filtering-correlation-id: b9414f45-bc4a-452f-5e27-08dd5bb09e86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tkk0MmNLWGJCTWRrMUc1NGFZczNvb3V4WEpFbTlRU09xVHpmSnNnaythMklM?=
 =?utf-8?B?eGNOVkJvakxyNXpTMXRxWVhmYXJVN01WVmxOS0JQUXlIK2dNL0FNL1BkWHZG?=
 =?utf-8?B?WExwdldiSHMxKzAzYXlKcElOYVk3RTc0TURxeEJFb1pqa0huRGpCbEMvNFEv?=
 =?utf-8?B?WjRoR1pyNU01bUxJUFhIY3k4d1VHbW1aMXV4YlYraVhuakZncmordmZXQ21N?=
 =?utf-8?B?REp2Y3VDK1N0SE1XK0JWWDNBSTN5WHBseXZwSzFDUm5SZlUweWxMWFRmdCtP?=
 =?utf-8?B?OGpuL1k5eE80cDBvS1NMVFpzN3dLeE5MMFdYdGQ1VzhBYUJubHFzV2VzTGhp?=
 =?utf-8?B?d1lnb2w2QTFvVFErRXp4SC8zellRT1oyV0lmRnd4T2dOWHk0QTRZZlArRkkv?=
 =?utf-8?B?dUpzSjV3ajM4UW1YRVZIeEhFUkdHSmVkWlJhVzgwcWhReG5zVUU4TDZtTHpv?=
 =?utf-8?B?WTZnTC9ueUVQenM5KzFtUzVWZVFRY0twbkMybVYwOXc2c1M2ajg1S3QxaVp2?=
 =?utf-8?B?RktPbkZCbHM3dWQ4U1liaCtPNHNsckM5RTE3RE8zaUhkSGJkbU5qR3pibWZ3?=
 =?utf-8?B?c1JNdUNsazFmYStteXZDRTZhbm9mU0Y3U2dORDJRMVhISWUzSVBJNG50SzR6?=
 =?utf-8?B?NWY4MHg1a0daTTM5Q0Exb1dBcG9MTnZNczEwaGxPTmxrSG9rTU8rMHRNWUFL?=
 =?utf-8?B?dTdjby9CMnMweWtUbnpKeEhLcTFDemRrZHBvbnRXOTFlTUdubWZxb1AyL0hn?=
 =?utf-8?B?dVRVQ2hDQ1FWV2JGcDRETEtIaTlBaERyeDdtaDFCOHZDWXRVaVpRalQ0dlh2?=
 =?utf-8?B?Z0JCMTRNei8xUkE2YUdmTXZaazZnOGZLcnB4WVoxSUZUbittR20zZWlSbU1q?=
 =?utf-8?B?bXFZY1ZqQytEc2t3enV1NVV4Z0JRSEhMNGd6aUg3Qk1rLzNScVA2eGtUSUNV?=
 =?utf-8?B?RDE2aEdxWEwzK2lINFFsU0lQU09xekxNVGVnNGZBVVMvSkVDYkovNGVsQlRt?=
 =?utf-8?B?Wno4enNuS2tnci9UbmtFeGNVTGg3TjJudE9kWWhuSDZWMW5PWWZHUVdGOUxi?=
 =?utf-8?B?MVY4SUNYSzl5TkFiTVIrMUM5YkJMQ0hQUWIrZTY1VWVPTWZmRGhvVFNXdjNT?=
 =?utf-8?B?YkZRL211T3dUNFozQ2EzcVhkMmQvemFqQlRvcmJYQXBjRnhZMUM3NVdUUDFY?=
 =?utf-8?B?aS82d2RRVU5mQWUyRFpTczJuekxZenFrUWkvYVVWOENTbS9EbFc0VVdXZ3Ux?=
 =?utf-8?B?YVJmQWEveHVDUHUxT3pQVTdEdTJ3YmxiN2NjZkx0U1IxTDgzOGM3R09iN1A2?=
 =?utf-8?B?WkpyMDF1QlkzdU5ya1RiUlVVMDRCYVJ1QVY5YWc0NUNMMjJKL0NTdC9Xc251?=
 =?utf-8?B?OUxFQ3RYSnpJRWhwVXROMWpLdjUwV0VSdHp4K200SHlBcjI5VFZkTFd4MDNH?=
 =?utf-8?B?dVBRSC9tRTJZZGloTEdYT28yUklPVThCMHlUZWovY0NaZ0VFekMxb1N3QUY4?=
 =?utf-8?B?dHcvbHhlcThTbWNQSjRDeGV0bXVTdmdpcndYTkVlZVhUdVlFOGgxWGw5UTJN?=
 =?utf-8?B?eGNOdUk0RHYwWGQrcFZVR2dXZER3YUkyZGxZdndwS2hIZ3drT1BwVnFhMndU?=
 =?utf-8?B?UDhsZ25qWE03ZitSNC83STUrNEtEUEhxM0V0aGlLZHdTdXVDNVBSZ0VIUHFO?=
 =?utf-8?B?eWxMUTBzN2NlaUpDZHVOUXBpSHRDVlNjWkpwWUsrZXh1M2pFWkdpT3oyR095?=
 =?utf-8?B?dFhaNjh4U3JnZmg1d1JreGs4U3M0YmhvK0pOaG1UTm5jM2V2VXlSVWh4d0sz?=
 =?utf-8?B?aGtqRmwrNkh0RWJvbzdyZmVDK0o5U2luTG95dW1WNkxVM3ZaRmdWVXYwV21i?=
 =?utf-8?B?U2Z5b2NBK21qM0VaZHRtbUo0TlYwWTNBR0lSWDk0SnNZNFhRWlFRQ05pTjhX?=
 =?utf-8?B?V1FYY21tT1lLMCt2Qlkraks4SnJlcXVOejhpdzNaZ3RjazFTUEZ2cEdUVnNm?=
 =?utf-8?B?TVplc2QrcXJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6903.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1I5NWZ0ajNkV1ZjSEZDbWVuRFNZSm44SXQyUXpIUGlNOTdtOC9wTlJqQ2hh?=
 =?utf-8?B?Y2h4SXBsQ2d2TjBtQUxZT3dQNkFvaDJiOG1UVkw2OENJcjFMT2FWSmFDck1h?=
 =?utf-8?B?ZVFRVHZoQVpCdXhWUFlBR1Iwc2Noa3A4eUhqNnVpd0lYdEdxUnNvdWFJUW1i?=
 =?utf-8?B?ODJhWlhPVTZNYSswQzFBNEloVkc2bnJKM0ZoQ1RTMGVROGp0VkwwTXQwZDAx?=
 =?utf-8?B?SUFkeE11QkFvbVRpeWh1RTRLS0VxMEY3eW9ZN1NKZnF5dnpjSEs2QzA1NkdZ?=
 =?utf-8?B?akIwQ3lLSS9PSk5FZUcyY21qL1BNODloekltYjN3UDJOZU5HK0pnK09MUFdy?=
 =?utf-8?B?dEh4M2F5Szh2MlZLQndqMkRDa3B4eGN1R0VYTnhuRDY0TkE2Rk5UMkhMUnJD?=
 =?utf-8?B?TEtETFYyaGdpWEtvamozMkxZV0xQbjF0SVpHT3h1OTVPdHIxTDJCaWN5Rlc1?=
 =?utf-8?B?bnpYNVFZSFo4K2JhOHhaeENodGNoWjM3MFJwbnNoWUNNbFByb3VOU1hFRkE0?=
 =?utf-8?B?YmNYYnBZTVZtdTRvVWkrdjlHOVJXaHl3VVhwYUlGdU9ZNkdUQkljTUFyODVm?=
 =?utf-8?B?UldxQUpSSHNxRklNczc5SHVka256WCs0UGRSVTltSlV0NGVjREtoeVJIYkR3?=
 =?utf-8?B?R0gvSmVPOCtXblIxVmk1ZzA2TTJyOWFKa1g0THFCMUVmMnhtSWQ5NDlpa2pS?=
 =?utf-8?B?TEpWSlIrMFUzcFZpelpwbmFaOVR0SWd0aGNlQzBuQnpWaTlKRGVKQUZhbmo3?=
 =?utf-8?B?d29xWDV3U21sWUVtVEcwTnZpQUFOQ2Z3QnNOa3c1aElRTVpCQmV3Vi9VOGQ1?=
 =?utf-8?B?T3puUTNKZHFOWFd4UThGcWNiMVRMcUdITms5WVFzVUw5V0RBWHdYWjFDKzhX?=
 =?utf-8?B?VHc5TlpSamRmb3BxM0xvbjJndXR1WjV1ZU1SVFFtVDg5Wi9pWGRyU1FQRlFI?=
 =?utf-8?B?ZnY2d08xMkVUS1JNS1RaQmlsVVg5UjY5NGJBVW41Q0x4N2NRRmtaeFE1Ymhl?=
 =?utf-8?B?eFY5TWVHSXo3d3FhUUlFZDFVeCtwMkMySmFPZGhLWDJtN1hRNUlpNnZ3THpi?=
 =?utf-8?B?ZUVTU094YXAzNm5vcHVDNmEwTGhrQkthdGxIbEZXQ3duNHRpK3ZsTTc3anRn?=
 =?utf-8?B?Ylhlb01RT0p1Rk5zNGd6L2xlWnVWM1JHRWM5MER2bjFLMjNBTkxHbnlCUG1q?=
 =?utf-8?B?cG1WV0RUaXpVZnVxbTdUcDM5cEpFTy9aTVdZSFBYdHBlaXpHR0tuMTd4MHdS?=
 =?utf-8?B?WnBiRFYxK3NvUmhaa1dLRUVWSUdDZUNsWjYrWVdhR0JMN2VmR2V5aDBkdDhM?=
 =?utf-8?B?UkNKSE5GTkt1dnA3UjFDOUE1ejJtcEZ5UG5mVzZLN1QyRzBkdzlXOUJ1bHAw?=
 =?utf-8?B?TDlFcFFGREJkdnJmdHZKWHlTYldHTWxVbG0vdTNOMkV2SHRoVUU1aGp1RTNP?=
 =?utf-8?B?bW1yMGRPclViVzdraWVXRkpCT2JkbkhMUGRRWHRGZnZVNVRhQno5bkdxeERy?=
 =?utf-8?B?OFowbTFHbjR0S3d0cXRxbWtaSEVnd0FCbGhiTE1LVDRRZlVKd2ZRQmNGUTcv?=
 =?utf-8?B?M0R3OWlHSmQxRElzU3M1b25nL20wYktQcU96b3MwL2RnVFVFTGpHeTRzd2V3?=
 =?utf-8?B?R1FpVHkrSGxkVkZkN3dCSFNmMlg3cE44bHg1UHBrWUhJZ2IxMW1JK2pKMGFH?=
 =?utf-8?B?WWxKMEVYclg0MmZPaGVla2lTZkRydXRHekNkZ0ZWMDNGMWt0em1oRVB6YnNh?=
 =?utf-8?B?OXd1cXozMlc2RmZVblpwOVQwME1idWVHNXBlSjduU3pVV1ZRQnhqV0ZtM3Ez?=
 =?utf-8?B?eWRKUUpRTUpIV094T0szemxqTCtETnZQS1VIQStrV2tyZnViejh5MXR3anR1?=
 =?utf-8?B?SUxBeVBMUnFJY01IZ2hDQmVzRnJoSmUzTWt1cGRzaEMzR3UzY3BKRWt0djNL?=
 =?utf-8?B?SmhWWE1uaUlzWmhJbG1zQ3hDd0dwK1JiYzBhMzQvaTl5ZkNhbWQ3cEFQc0hB?=
 =?utf-8?B?Z0ZtelNhTFFXNUNtWjl0NEZQWkE5UEVlcy9HRGVQcXE2ZFhNTDRUU2R4ZnNG?=
 =?utf-8?B?YVJ1VmwrOEp6U2pxL3dtQmV3d3kxQ2RGUDVvbmpqaXlPWGxQNjVUTXVCcmU4?=
 =?utf-8?B?WVgzalQ1Q1Vpb3NSeVR5THpBSzJyRXVaOXdIcE1wQ0xoMHhuUk44Qmd4R3dJ?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/en/i56s4SU1D5hSfK5wgQuCXY+TzBglnkJJlmt8p78ovezjZOaX6emfubCtapwFBRc0P6HfTIBSiptSW0+GoS2w4c9ulSULpMb1bFEDwyBWsLbvqJSsEUdcPycYKkfGa0cHNt0F7oIWqWjSxAEmiA3bJgcD3c+E3bKI/hR7ya7145gNgsOSpstdbI+KmZd7ofbp2vkklb9esTM5KSTHxnisayHbi0xM0M7tG7qx199HVs8JbuGOsL84LKxK+WmOMzBhaawza10oqBEOmEFhiS+wbuRDIHaYLSZLD9IudNOZr5Kv4dGm61NrffS8FKfy2ZB4b76jpdSH4ALWxoBsAg61hd1pFqHSL13DU9DQkXqbM0HrKwezcRlUSg7/m9fS2Epvsq/UfWzCJDHo0UzJ2f6q86XGCqk2qOfVTVbABcpmOZFKvTZcEEy5BKhlQZgV/NOkSSLRa1l5Rv96lxk08EZxn4BBybeFiwsz8EqSdkrL3K/kClOBQu2rbIXJyg/8UyAR75HZnb3mmB0K1/qxjVMqi3llguOSRkLt++99nwVED0BvLizZwlrywOPf7ACP/GZ3fZVStT48QmqiztZEKgIecN1z/ZATEj/N6BHiXEAkBNOMplUJq0DBE8J1M4Cc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6903.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9414f45-bc4a-452f-5e27-08dd5bb09e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 06:40:28.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTi5kaTL+pY9yAaUmy+suMS1ydsfV5BzKLNOaDs+Fzdq4ipHn/+CdZw5YjFQvJbBtX7vAN1YBnT8bwqFpQUq1aKr1lxGhRDdY5xTH/v9Yxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14066

SGksIEphbWVzDQoNCj4gDQo+IEhpLCBKYW1lcw0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVu
dC4NCj4gDQo+ID4gT24gMjcvMDIvMjAyNSA1OjQwIGFtLCBZb3NoaWhpcm8gRnVydWRlcmEgd3Jv
dGU6DQo+ID4gPiBUaGUgZm9sbG93aW5nIGV2ZW50cyBhcmUgbm90IGNvdW50ZWQgcHJvcGVybHk6
DQo+ID4gPg0KPiA+ID4gMHgwMDM3IExMX0NBQ0hFX01JU1NfUkQNCj4gPiA+IDB4NDAwQiBMM0Rf
Q0FDSEVfTE1JU1NfUkQNCj4gPg0KPiA+IFRoZXNlIHR3byBhcmUgZGlzY292ZXJhYmxlIHNvIHdp
bGwgc3RpbGwgYXBwZWFyIGluDQo+ID4gL3N5cy9idXMvZXZlbnRfc291cmNlL2RldmljZXMvYXJt
djhfcG11djNfMC9ldmVudHMvIGlmIHRoZSBoYXJkd2FyZQ0KPiA+IHNheXMgdGhleSBleGlzdC4g
SXQgbWlnaHQgYmUgYmV0dGVyIHRvIGNoYW5nZSB0aGUganNvbiBzdHJpbmdzIG9mDQo+ID4gdGhl
c2UgdHdvIHRvIHdhcm4gdGhhdCB0aGV5IGRvbid0IHdvcmsgaWYgdGhhdCdzIHRoZSBjYXNlLCBv
dGhlcndpc2UNCj4gPiBQZXJmIHdpbGwgc3RpbGwgbGlzdCB0aGVtIGFuZCB5b3UnbGwgYmUgd29y
c2Ugb2ZmLg0KPiANCj4gSSB3aWxsIGxlYXZlIHRoZXNlIDIgZXZlbnRzIGFuZA0KPiBhZGQgYSB3
YXJuaW5nIG1lc3NhZ2UgdG8gdGhlIGRlc2NyaXB0aW9uIGluIHRoZSBKU09OIGZpbGUuDQo+IEkg
d2lsbCBoYW5kbGUgb3RoZXIgZXZlbnRzIGluIHRoZSBzYW1lIHdheSBhcyB0aGVzZSAyIGV2ZW50
cy4NCg0KSSdtIHRoaW5raW5nIG9mIGFkZGluZyBvbmUgb2YgdGhlIGZvbGxvd2luZyB3YXJuaW5n
cw0KdG8gdGhlIGRlc2NyaXB0aW9uIG9mIGV2ZW50cyB3aGVyZSBpbmFjY3VyYXRlIGNvdW50cyAN
Cm9jY3VyIG9uIEZVSklUU1UtTU9OQUtBLiANCklzIHRoaXMgb2theT8NCg0KMS5TaW1wbGUgdmVy
c2lvbg0KIk5vdGU6IFRoaXMgZXZlbnQgZG9lcyBub3QgY291bnQgYWNjdXJhdGVseS4iDQoNCjIu
RGV0YWlsZWQgdmVyc2lvbg0KIk5vdGU6IFRoaXMgZXZlbnQgZG9lcyBub3QgY291bnQgYWNjdXJh
dGVseSBiZWNhdXNlIGl0IGNvdW50cyBhcyBhIG1pc3MgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRo
ZSBMMyBwcmVmZXRjaCBpcyBhIGhpdCBvciBtaXNzLiINCg0KSSB0aGluayAiMi5EZXRhaWxlZCB2
ZXJzaW9uIiBpcyBiZXR0ZXIuDQoNCmV4YW1wbGU6DQp7DQogICAgIkV2ZW50Q29kZSI6ICIweDAz
OTYiLA0KICAgICJFdmVudE5hbWUiOiAiTDJEX0NBQ0hFX1JFRklMTF9MM0RfTUlTUyIsDQogICAg
IkJyaWVmRGVzY3JpcHRpb24iOiAiVGhpcyBldmVudCBjb3VudHMgb3BlcmF0aW9ucyB0aGF0IGNh
dXNlIGEgbWlzcyBvZiB0aGUgTDMgY2FjaGUuIE5vdGU6IFRoaXMgZXZlbnQgZG9lcyBub3QgY291
bnQgYWNjdXJhdGVseSBiZWNhdXNlIGl0IGNvdW50cyBhcyBhIG1pc3MgcmVnYXJkbGVzcyBvZiB3
aGV0aGVyIHRoZSBMMyBwcmVmZXRjaCBpcyBhIGhpdCBvciBtaXNzLiINCn0NCg0KQmVzdCBSZWdh
cmRzLA0KWW9zaGloaXJvIEZ1cnVkZXJhDQo=
