Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B14A06;
	Thu, 19 Jun 2025 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311655; cv=fail; b=C6AE1Vi4ENnEWNetsqvRYxYq+AzUoyjRJRWqzlxPV7z3RVSvYgwAErSScRtjWSzgUqXIPWbugtOE9UepdaJST1GnRugvjBa3OdhJPw90mH55uU3e0NbscZfWCIjVfUXMHpXv+rqK+M9vkhsJvAS4yU6x6eoqqql/3zTl7JhwmsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311655; c=relaxed/simple;
	bh=RNY9i92RE8hJz+5xJP0rV+ZEw2w9ZVaro/95YeUHHRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CfR9CUY82XKre/8vhApcijXfmZUcuexRxBoyEID0d/9UkFAMTx3nYyv1GxiqHDjL2CGUGMQ8OB8pwPPp2fZO6pmIE+x0AxJdDEElV3kkhae8kaWpSNgxCsaQdtX9OYpbwlwEFQNGTeWX0yCA3QCP5aNI4jjoo214p0NnoeRFzd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eFPOV7dD; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eFPOV7dD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1750311654; x=1781847654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RNY9i92RE8hJz+5xJP0rV+ZEw2w9ZVaro/95YeUHHRU=;
  b=eFPOV7dDXuj7cCUITqrcWpCYoOduz7IHH/xO/xlDN9eI9PUA1JWbheXT
   tP7pesOiB0KFrqhmcl3I0Rv4LzAW/0uq9ftHubTTYoDP61sIz5p/sN5FY
   QQoWm79dhH5NE+lZm6om0cBc/dBdkcwxmzQuIsTaYp7xhmw4RjITQybyX
   dWRDrTUZsh0aFNUO8z1LhQzQ8mPzrOtQn6chOc5CnZnWREHww3abrcRzm
   sUtr5NfnuAkE6rzqjvNMDQ4lNeQ2zfIl8x77LdR43Yl/BdxfNhSrjODg6
   J1uD/W3bHWq1HEMWc9edN54oZXhC6CpSS7qsb8GmuSnn3FtmKbWARY+gS
   A==;
X-CSE-ConnectionGUID: DN0464+yQD2fzLkyEyBSVA==
X-CSE-MsgGUID: Sy441JYJQ42XP5t+M+ZvRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="158620464"
X-IronPort-AV: E=Sophos;i="6.16,247,1744038000"; 
   d="scan'208";a="158620464"
Received: from mail-japanwestazon11011032.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.32])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 14:39:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baLYUvBeUNOGvs/GThxN01rUPgo5TApPgBZrgDVJ9lxQv+SXRWsox4TryFG+wh0rd1/JKJDli/aPnCQqD8lwJApiAWg0pbQWYaz07Dwv8WeRUPs8aTvg7rhzO8XPhMvcJm7TqljcsvFRaPjctWKCZqA45l7+iqyaF6OOIXt5lDpEtY+JMzV88Hll4ivUa5VN0e37tHqUtUivNPD5W4YTYvKTrYEcrXcqFEw1zeRGRbHPP1lk4nwqK2Ye+y0OtRocHZfX/rwN5HfXL1PAj0eqowpZekDi+Jxy3pQJWxuqSrCZRrVqo6ItS+sYq2Sv0utySnE02NOkGoG9vnggwBcN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNY9i92RE8hJz+5xJP0rV+ZEw2w9ZVaro/95YeUHHRU=;
 b=lNDogcP/GSYie2j0h6Wlldy7CxDWyYORVXscpUt4zf4IDr+oFMHlPDhNWDtvIVN7XcBlPkKVCShC0f3RGo7FnHmlMQFt9on0qcyhTdRWdgLCKq59Ha9ZGJIO/1Q34DE8SoJPZH8hejE24hWhf5Asfllj3XWtRc1jeDqgVHt7u69seaBNMOCmtIpioRBe7/HThN22i9iJrFqR4Vg1dujJkfaqaG4615ClwJJzo0jNXypOUDnsHK1C8E7QihoY2BfA+A4i9FzSqX7VfgbK/VgjT5KBpWp+S95928BXnsjsLp89NAEz1ctuAMbS3qYb8941C4Z3Ot3czhSysvFkiGpOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB14006.jpnprd01.prod.outlook.com (2603:1096:405:207::7)
 by OS3PR01MB5656.jpnprd01.prod.outlook.com (2603:1096:604:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 05:39:35 +0000
Received: from TY4PR01MB14006.jpnprd01.prod.outlook.com
 ([fe80::f9c0:4fc0:a518:4514]) by TY4PR01MB14006.jpnprd01.prod.outlook.com
 ([fe80::f9c0:4fc0:a518:4514%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 05:39:35 +0000
From: "Kotaro Tokai (Fujitsu)" <fj0635gf@fujitsu.com>
To: 'James Clark' <james.clark@linaro.org>
CC: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Mike
 Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] perf vendor events arm64: Update FUJITSU-MONAKA pmu event
Thread-Topic: [PATCH] perf vendor events arm64: Update FUJITSU-MONAKA pmu
 event
Thread-Index: AQHb4BtkvwnElPRNPUWLH0b4SfLYU7QIldkAgAFfF2A=
Date: Thu, 19 Jun 2025 05:39:34 +0000
Message-ID:
 <TY4PR01MB140068534B3D76C2CC7ED2C96DA7DA@TY4PR01MB14006.jpnprd01.prod.outlook.com>
References: <20250618063618.1244363-1-fj0635gf@aa.jp.fujitsu.com>
 <0060a6d7-ceee-4ecd-b4b7-1c9fc422efc7@linaro.org>
In-Reply-To: <0060a6d7-ceee-4ecd-b4b7-1c9fc422efc7@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZTM4NmExZjItZThhMS00MmI1LWI2ZjQtNDBhMzA3NDIz?=
 =?utf-8?B?NjMzO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTA2LTE5VDA1OjM0OjU5WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB14006:EE_|OS3PR01MB5656:EE_
x-ms-office365-filtering-correlation-id: 2dfff2f2-0df1-4b8a-de3f-08ddaef3ac72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0dIS2NwR3Q2aWVDcFY0YnNtbXJINmRHRlFIbHhMTUxWNDZRMG9FTWJzMmpU?=
 =?utf-8?B?TWdWQUp1MVZIQm9WcDJ3OUx0K242TGIvTWZpRzlVbEtXVjZXU1BwNmFhWTRi?=
 =?utf-8?B?K1IrVW1Dby9QZU9RRHp4aDJNNFNlQmUrZlB6TkM4Slg5dGIvb3N5eFlGd3FG?=
 =?utf-8?B?cWNVOHBWbVp6NTlvZWxxbjU1ZWx4SS8zOWI1M0lvQ3VmUEd3dUR3RGpFeVl2?=
 =?utf-8?B?VU9pYUE5ZndWeHl2azVPamNVbHpoUFNWTjJGK1czbmhGRGM0SGJlZmwwK2JE?=
 =?utf-8?B?d3N1U3VTL1VQVSs1UUo0SmZCdGFWeXR0MTJwdSthWGQ1cDhiUEVsN3N4YU9M?=
 =?utf-8?B?d3ZET0hGM1ZIVGYvSnMzYjVnbFRJdk5jSG5YRnFpZU1KWjFvTGVnelR3SVMy?=
 =?utf-8?B?YUdCQlhqelBIWkczc3hUd3hVUUI1eDJ3OGcxYUhXMFc0bEN3USt5V0JMWG1j?=
 =?utf-8?B?NjRoNU5OZXBNRDFTeVBid2pJeGhzZ0VyQjhqUGdCWVNUa21CZm1RdE9rVG9E?=
 =?utf-8?B?dzJad0J2alBIZ2hla3FwVU1IU1haUnJUNG1GTTdDQ3pGdk00clZ6dzRwemxT?=
 =?utf-8?B?anZhYlFzSFEvQS9CN0VVNFBmVnRtWjE2dHZCUVRCYmRxcktsUDVlRkFodnRa?=
 =?utf-8?B?d0FqNGpNU1ZVWnJ6dUZldFZJMzRESlpyWXlVNXdPdk9HZTRLK3h1RUdoaDFa?=
 =?utf-8?B?cEFTMzFmVC9UM21QTk1qMk1HQkdKa2pVR09RSG1Gd0VaNjAxOGg1WFFTOVRY?=
 =?utf-8?B?dFNTSVk1Y3k0b2JqaFcyTHVwZzUwOXJmZDNvb3dQUUZqRUMzN1lXTTBhRzhw?=
 =?utf-8?B?aEdyYUMzeVpUUzdvNkZSemd6R0pzem1zbTIza3BDSDMwTVRJeDNjc2hNT1F4?=
 =?utf-8?B?SXI5ZlJlbU1LeGdNa0FXUFBnYkVObGZNdWF4b2MxelZSKzU0eEV2aWVqaWpM?=
 =?utf-8?B?YjlyQlVHTm5rWmw2S0dYUzU1MFpjbU4yREVFQVFMa1A4UXoyZ3JSWEk4OGdi?=
 =?utf-8?B?YWVObE4xK211d2hJWXZSTGp2ZlVtZnFwdGFBZVpmUkhqS1VmdjhkUGFnUVpQ?=
 =?utf-8?B?R2xsRVMyVEs0ZGg4Ylg3OFNKeFZBYXBUcVYrU3pvTDVZS1ZyNmJWeFQxeTZB?=
 =?utf-8?B?aFdnY1RoL2ZiNi92bHJ5TU54KzluZ1lRTGdwNk9scER3NmVZTGVSTm5aNFJ6?=
 =?utf-8?B?QW8yQUdtRUZDanZ5UHQrQjRrUERTaXpONUF6dHc3anc0My9rU0twYU9VbjMv?=
 =?utf-8?B?M3pjcHJUcUxwb1U4U1F3MGx3THhFdXRJV2RmUlM2ZjRNb2NHNklyeVppRXE3?=
 =?utf-8?B?cEQ1TVkwM2c3UWw0TjdGL0NmK2g1ZlJBUzVQWjVLU2crN2hXR2hab29aMFZI?=
 =?utf-8?B?M2tuR0xBZjhpNnpEOUVhbEQ0emtaRUVaSU1obnhWa09YQ1I5ZDhIRWZGb1kz?=
 =?utf-8?B?ajc5TXhFY05vajJyNk1URVpIVjlSaHExYjFsZGF6MTlvL2FRYnE4eUkrcGIv?=
 =?utf-8?B?ZGVBZ3AvQndwY1JFcnJjdklmN3lSK3hRUGE3MnUwNUticTNBTE9WUWZWb0ho?=
 =?utf-8?B?cEJxdUxMaDNDRHR6anFJN2JucVJDT2lCNmoxZDN2QmlxRlVyVi9qU3lxb0py?=
 =?utf-8?B?UEw2Q0RZa3oxZjdCRnlZMEpvWHRmeHJwc25Tb2Z0U1lZY0NMTnR2amJSbzdr?=
 =?utf-8?B?THFWdVJZZmJTQ2RFbjRVNW54RVJOQ0JCOXhHanpoYUdsSmFTcDFzYm1qbFJT?=
 =?utf-8?B?ZElDOWpMRWNXNWxVeWdxdmZyVXpzUzE1d2haQTV3N2NabWtoKytqN1RvUERn?=
 =?utf-8?B?SDd0U3dpZUdRSkYzQWFTOVBqZy9pM0NqOC9mZ2pUWkgrZXQ4dEcxYm1nMDN1?=
 =?utf-8?B?UFJSVEhqcS9BWG5tSHRNc00zcTVEM1h4RjZCYjU4ZElHODl4Q2JlOHBVYW8y?=
 =?utf-8?B?Z001bXFVQythemlLbHA3eHdZa0ZsWDdyMkJaK3hOUGhEcndEUWtKUTdzV0tP?=
 =?utf-8?B?b0JaKzVyWDhpSGx4ZzhNcnVPK0lGY210QU9lcHNIU0ZVVDFqSU5sV2p2MVVm?=
 =?utf-8?Q?IrM1Vy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB14006.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHRXbzlPUFlZRTQ3Mm1DTFd3RnM0aTRLU1BNd2V1UTUvL05FYmVNSm0wTEFR?=
 =?utf-8?B?TVRwTXVhMHVrSGFwY1FOOTZzRUdlYWdWaW15cXlnTzlFbHAvSGpGN0JRcjl2?=
 =?utf-8?B?eG56TUV6eXBtTG0zNVFrb0RpMFdhT1VSZWJOYlZRNFhzUzA4a1NEVWR5R0RN?=
 =?utf-8?B?M2FEUlVUaFI1NzI1c3BzSnhlVXBLbVpwWmZUbmVVNVY0Q3ZRNUVDMFM1M0w4?=
 =?utf-8?B?Y3hVOERieTE1TXN6YkhxdXFVTVd5dy9RVnJ0WU1lZlF5SXZhalVodGp1ajU5?=
 =?utf-8?B?ZG44YjdxdlNuSXBxMjNxREtzUTRHdzdEUU1vTTI3TXdWNk02NzRJVEl4aE1O?=
 =?utf-8?B?UDNuSldGRlF3cW1oam5WbGtjYVhyZ2pJQ0NzVUdyMEJSK0pjbXo0SG1LKzRz?=
 =?utf-8?B?eU1rWTRuUFQ2ekYwTEladWp0bEZQdjg0bE5aSi9VMkt3Rnp4aDlUZ1RPN1Jy?=
 =?utf-8?B?NGhuSzlReVg0K01FTVRyTW1iMlY4WGRPTmFhQ2R2OE5xQnVaRm43cTdWQi9r?=
 =?utf-8?B?L2xRYTBkalFJY2Y3OXpFK3grdE11UmovYndPOEpvZlBpckxhZGlBWVg5VS82?=
 =?utf-8?B?dWk3NjRCeGpUSS94UEx5QjZCajEwc0pwUEszWjJsUnMrOS9ieVgwTGlPaXRQ?=
 =?utf-8?B?KzZXeEt0c0x2dFlJckZvdFgvN0FjOEhPR2Y0QVNYTmQ0TTlNaG1FdkdDWWtw?=
 =?utf-8?B?Z2ZheXFCYzVCOE9zVXI4UnVYY1FzeWd3cE1iQmhIY0loclFPWThvc2V4R2Y3?=
 =?utf-8?B?S1g2K0VBMkpyKzZYS20ySWNBOU1ZTTl0R1UySzRLNlZTeVcrbUF3dTYySWZl?=
 =?utf-8?B?UUVQYWFZWXhwRE1wVmxGSnl2OGVBbzNzZHY5NU1xOC9TVUdvYXNDRHNJWkJF?=
 =?utf-8?B?ZkhTTkVCU0pxWlhTd0Z6RzgwYkdGUDZENjAyZjJtUDJGRUd3dFBTN2FtOTZK?=
 =?utf-8?B?MVpJTThVMFlzZFhGSVlwSzMyV0k1cnc0dkJ6VHg5TXRjSmFmMVA4TlZ4b2xT?=
 =?utf-8?B?ZFdrT1JqZEo3eHFlZmhpN1JocDBtN0haSmJSOVI0dUVjNUxGSG9relBuT2FH?=
 =?utf-8?B?Um5uZFJvYTFoNElKY29vanJabGhFbnRLdlpUNnFITUtxbmRhcm9BQXllRm9l?=
 =?utf-8?B?ZnZDUE8vQ2FOcnM2TWJvSVE1bnlmcGxSc3d6Sm96Z0xBL2E4MEUyQkxnSmUx?=
 =?utf-8?B?bXhXWHQ0aXlidVJ3cXZhR1prVlJEanh4UCtZNG5Qa0RXQk43SGxtcFA4Q1A2?=
 =?utf-8?B?NGUzcERBTEVKZlFTMW42NDFnOUgzWmdzYitpUUZHczRtZUJOK2l1SzNDUkpv?=
 =?utf-8?B?M1diSXF4S2xmcjZVeUtMaU44YXNkSTBkeFQ0YTVMZzBlOXlhM3FKREFFNEE1?=
 =?utf-8?B?VjVONTdpdzlvMldIYUgxWjVTbVBDenpiaXdoZTJCRWV1cU1qVlZRTVJGbEhS?=
 =?utf-8?B?RUxWemZNYkhmQzhjZnh5NEpGeHZFR2Yzb3VDRjdSV1pPTEFiV2lOUVcvVGdD?=
 =?utf-8?B?TW5tVVFBbnBGdmsxZzQwZDZlVTI0aVVid1JRWldmdVUwb3lnUURJMTRwZEpN?=
 =?utf-8?B?U1pVdUN2aXlGZzBLTnJXcE1HN1lkNFMxQ0R3cDFtb29zdzVQYk5QQWYvQUpB?=
 =?utf-8?B?SmkwNlpJSDNFZUE5Z2o5TzljcVpacHJsTlpHWHRUNjZ6a3F2b1ZmeEhjcW5J?=
 =?utf-8?B?ZWFBN0lLU1BVbUFqS3BzUkRDVTNkajBKdUVkY0VqMHc4UkwwT016QkF5R1JL?=
 =?utf-8?B?cVpmVGYzaGUrQTFIMGcxeXpwQThaaWZmbjVuVXhqWGpFeVg0WHFTVU9LOGV6?=
 =?utf-8?B?ajNLQWdaY0xaZHJtMXZuRVE3QXJQYlk2WkFsaC9aU1U1dnFmanJNZkZaMm9k?=
 =?utf-8?B?RmFkNGZNc1N6ajlQZ25zRUYrZ2pMdzlyMTQ3QzhMQjBXT2k0MzY5cld0Ly9z?=
 =?utf-8?B?M05zZHJmYTNLcUlLL3RLZHJzRjIweC9PRUlZN2xKVC90Vm5NVDE3Zys4YWw2?=
 =?utf-8?B?NmpzZGJTUm55SDJHR1p6dUJvWGVxVXBWdzJ0ODZ4OTIrckRUODJ1K3NyZ0FG?=
 =?utf-8?B?dnZhS284eEFPWmFneGhTVlNwVmRETFp6ZlY4MlhVNC9YeGtjck1IV0swZG5i?=
 =?utf-8?B?MUc4d0tLRnBjWFFBRUlVaHdaY3A2ZHAyQ0ZkTmJWRExNMGdRTnFmN2F3aHJy?=
 =?utf-8?B?V0E9PQ==?=
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
	ztCfzhBzqfs8YPlAORmwOQNs/IGv5miGfMppbDrbXqoBMiAwFG26zf8yjyHL/MzjnHJqdYpTZl8kYDbj7iyE5p+83YWC1RWoNQWFEn2WjGPnNjGDxfhUP/Rgp2tu4y8O7pWzR3iltXI8hYG0CND+a389W7Pvx7wsV30uUXMKBQdM7QqDJXlKl4cgaAwcX5KaYHq6CyqmIXLgVeaC7iQGLhS9GbLZGhudE+My53cmGuYN2cpzz8Py/o6pWt6fL6hZVdWil6eVBQjNUL94UeMr73WLlhqyDmzOrUE0hhXTeN68Znpc0eBK5r/od8fy8OAih3GUwQxMH/TIRPSrOvFTZ0xgaCB9rXVHjjygRQ7rEq13QORdx6Nrm37rcR73Xqjds8sIKu/TqlANhCa+aY6IN783Lqm6/V1d2y74I3bTjkkHdHfTZO2bHzMDEOmvd5rHrFECLiVWZJ4lk0EJXq3wG2vS7EzMYxXAF5nVTJJF96NYykK0Q0Iv1X3hucf9g36rqzz5NfnfoBQJ9YzLkD/fMEbE2xgMhl48BZooRnYmSHNgxxZlcmrgHFSrpNistyEefWwx8LGivbda/ED+a5+mDk3poZpbTogiMb76GiXToK6nXZeObao6IxpkmsBLjxXR
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14006.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfff2f2-0df1-4b8a-de3f-08ddaef3ac72
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 05:39:34.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpGWxENFplpRUZCZIA/40uYD/heLSsybv9HLHEQRJBmGLnUxiY9aeJKH3aHBsq4rwYW+SeCAkZ1NKOJs3p50sVv1/j9am2FIpr5RLt8wHcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5656

DQoNCj4gDQo+IE9uIDE4LzA2LzIwMjUgNzozNSBhbSwgS290YXJvLCBUb2thaSB3cm90ZToNCj4g
PiBVcGRhdGUgcG11IGV2ZW50cyBmb3IgRlVKSVRTVS1NT05BS0EuDQo+ID4gQW5kLCBhbHNvIHVw
ZGF0ZWQgY29tbW9uLWFuZC1taWNyb2FyY2guanNvbi4NCj4gPg0KPiA+IEZVSklUU1UtTU9OQUtB
IFBNVSBFdmVudHMgU3BlY2lmaWNhdGlvbiB2MS4xIGFuZCBFcnJhdGEgdjEuMCBVUkw6DQo+ID4g
aHR0cHM6Ly9naXRodWIuY29tL2Z1aml0c3UvRlVKSVRTVS1NT05BS0ENCj4gPg0KPiA+IEFybSBB
cmNoaXRlY3R1cmUgUmVmZXJlbmNlIFZlcnNpb24gTC5iIFVSTDoNCj4gPiBodHRwczovL2RldmVs
b3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGRpMDQ4Ny9sYi8/bGFuZz1lbg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogS290YXJvLCBUb2thaSA8ZmowNjM1Z2ZAYWEuanAuZnVqaXRzdS5jb20+
DQo+ID4gLS0tDQo+ID4gICAuLi4vYXJjaC9hcm02NC9jb21tb24tYW5kLW1pY3JvYXJjaC5qc29u
ICAgICAgfCA3MA0KPiArKysrKysrKysrKysrDQo+ID4gICAuLi4vYXJtNjQvZnVqaXRzdS9tb25h
a2EvY29yZS1pbXAtZGVmLmpzb24gICAgfCAgMiArLQ0KPiA+ICAgLi4uL2Z1aml0c3UvbW9uYWth
L2N5Y2xlX2FjY291bnRpbmcuanNvbiAgICAgIHwgIDQgKy0NCj4gPiAgIC4uLi9hcmNoL2FybTY0
L2Z1aml0c3UvbW9uYWthL2V4Y2VwdGlvbi5qc29uICB8ICAyICstDQo+ID4gICAuLi4vYXJtNjQv
ZnVqaXRzdS9tb25ha2EvZnBfb3BlcmF0aW9uLmpzb24gICAgfCA5OA0KPiArKysrKysrKysrKysr
KystLS0tDQo+ID4gICAuLi4vYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9sMWRfY2FjaGUuanNv
biAgfCAxMCArLQ0KPiA+ICAgLi4uL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvbDFpX2NhY2hl
Lmpzb24gIHwgIDggKy0NCj4gPiAgIC4uLi9hcmNoL2FybTY0L2Z1aml0c3UvbW9uYWthL2wyX2Nh
Y2hlLmpzb24gICB8IDI4ICsrKy0tLQ0KPiA+ICAgLi4uL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25h
a2EvbDNfY2FjaGUuanNvbiAgIHwgNjMgKysrKysrLS0tLS0tDQo+ID4gICAuLi4vYXJjaC9hcm02
NC9mdWppdHN1L21vbmFrYS9sbF9jYWNoZS5qc29uICAgfCAgMiArLQ0KPiA+ICAgLi4uL2FyY2gv
YXJtNjQvZnVqaXRzdS9tb25ha2EvcGlwZWxpbmUuanNvbiAgIHwgIDYgKy0NCj4gPiAgIC4uLi9h
cm02NC9mdWppdHN1L21vbmFrYS9zcGVjX29wZXJhdGlvbi5qc29uICB8IDEyICstLQ0KPiA+ICAg
Li4uL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2Evc3RhbGwuanNvbiAgICAgIHwgIDQgKy0NCj4g
PiAgIC4uLi9hcmNoL2FybTY0L2Z1aml0c3UvbW9uYWthL3N2ZS5qc29uICAgICAgICB8IDQ0ICsr
KystLS0tLQ0KPiA+ICAgLi4uL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvdGxiLmpzb24gICAg
ICAgIHwgNTYgKysrKystLS0tLS0NCj4gPiAgIDE1IGZpbGVzIGNoYW5nZWQsIDI2NSBpbnNlcnRp
b25zKCspLCAxNDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gWy4uLl0NCj4gPiBkaWZmIC0tZ2l0DQo+
ID4gYS90b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9mcF9v
cGVyYXRpb24uanNvbg0KPiA+IGIvdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gvYXJtNjQvZnVq
aXRzdS9tb25ha2EvZnBfb3BlcmF0aW9uLmpzb24NCj4gPiBpbmRleCBhM2MzNjg5NTkxOTkuLjJm
ZmRjMTY1MzBkZCAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL3Rvb2xzL3BlcmYvcG11LWV2ZW50cy9h
cmNoL2FybTY0L2Z1aml0c3UvbW9uYWthL2ZwX29wZXJhdGlvbi5qc29uDQo+ID4gKysrIGIvdG9v
bHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvZnBfb3BlcmF0aW9u
Lmpzbw0KPiA+ICsrKyBuDQo+ID4gQEAgLTIsNyArMiw3IEBADQo+ID4gICAgICAgew0KPiA+ICAg
ICAgICAgICAiRXZlbnRDb2RlIjogIjB4MDEwNSIsDQo+ID4gICAgICAgICAgICJFdmVudE5hbWUi
OiAiRlBfTVZfU1BFQyIsDQo+ID4gLSAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiVGhpcyBl
dmVudCBjb3VudHMgYXJjaGl0ZWN0dXJhbGx5IGV4ZWN1dGVkDQo+IGZsb2F0aW5nLXBvaW50IG1v
dmUgb3BlcmF0aW9ucy4iDQo+ID4gKyAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiVGhpcyBl
dmVudCBjb3VudHMgYXJjaGl0ZWN0dXJhbGx5IGV4ZWN1dGVkDQo+IGZsb2F0aW5nLXBvaW50IG1v
dmUgb3BlcmF0aW9uLiINCj4gDQo+IFRoZSBvcmlnaW5hbCB3YXMgbW9yZSBncmFtbWF0aWNhbGx5
IGNvcnJlY3QsIGJ1dCB0aGUgdXBkYXRlcyBhcmUganVzdCBmcm9tIHRoZSBwZGYNCj4gc286DQo+
IA0KPiBSZXZpZXdlZC1ieTogSmFtZXMgQ2xhcmsgPGphbWVzLmNsYXJrQGxpbmFyby5vcmc+DQo+
IA0KDQpIaSwgSmFtZXMuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyENCg0KQmVzdCByZWdhcmRz
LA0KS290YXJvLCBUb2thaQ0K
