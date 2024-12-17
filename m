Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D49158A13;
	Tue, 17 Dec 2024 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417395; cv=fail; b=ZOXHvR24j5lz4LzkEentTOZt13wX4i66cWb0Qndb3peygiuU7Un2ivs5kCZq5JzRsPvTLRrN7lbD+Ug9xkiCMDrkRIu1rwzRV5Fe0zZMzXEQUe+e6qGGcHVj1LCWLP78SONj956lQV2McMohREDbTKIEzw3RetsMoGaRwX6Mpm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417395; c=relaxed/simple;
	bh=+WUEpkzLOGMWYgZLNDAuP49n5HcpdHB66PEf+FTHneM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rMzgDavuHllwyhgxz1DHVC5+EVwwkPrIPlJlZs0BKfjQi66S7h3FCX2sGWxV6OPGJv/8/YAFq9EScCFRzMdZK6uBFo0vWry4C8/QC/DLhry5LeLyHfnpP4U+jxXYJRR5zCHu9Cwnb/rF3jcgJMMl8wx5MJPRdCoywtcp/C+SACM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=O+cVnABf; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="O+cVnABf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1734417393; x=1765953393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+WUEpkzLOGMWYgZLNDAuP49n5HcpdHB66PEf+FTHneM=;
  b=O+cVnABf1Cpdsv4YlRRmFFaKweGKxI+gOopfRqhf9emXHMh7zobcrI1J
   48kPHfvbz4UYN4NGZYgb9EgQq+VyNNdEL3/Ot/cWR1dqFsTZdGFEBnJjT
   4YTt3SmMKdztbYKSHeKvhni3azlSREWsOX2rTkdO7i3HI1PZnQ8gJ715x
   xwKvJSGvSRsAFa4YGGBZVPpGjdyF7VojjA9uEBukE8pGzEyOFlhtGwQul
   AQsECLPyC4Ws0T6LUlYuyCR+7JnsZIBnX6OrtBPjQTmJCOi9NVpASXsAw
   xWkertc/Fy+dE21TvNq3HCrlXhwyQ46/0np7OXEzBFjbhlMKJ1uaMqsMv
   A==;
X-CSE-ConnectionGUID: jAivvgX4T1u5BBGV3AhUOg==
X-CSE-MsgGUID: 12fhqPfXRzGF738w9iilAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="51513170"
X-IronPort-AV: E=Sophos;i="6.12,241,1728918000"; 
   d="scan'208";a="51513170"
Received: from mail-japaneastazlp17010001.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 15:35:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Avz/SgyueVeP0wZfwlgyReKbuuXEGGUoQnPRWJq3DXj70dtdZfscZvf+ROBtR3OBDiYDaQZFkke6qNrdr8PR8TUccA+m09p7+OrsIStUCqTytGLlBuf5xvqn9cza+7YofVx3P0jd3Azdrel5jK8dweHROQsllGjBaHUcTcPs7FGzfyXMELp+OObRy3t9TL+lUTXjdO15qazZUZ6v/weoZWvpo76hr5zzGKcHqcNuP0tyKx7P6I0laOaaEn+hxQKUZPeN2N/SXlP2d8xu9fZjrA2owGo00VxhGh0cZDnp6UsCtkWVwQXy3yMvO11ZQpwJJi1OZ0EwsqDoslsJa//kZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WUEpkzLOGMWYgZLNDAuP49n5HcpdHB66PEf+FTHneM=;
 b=BOJ20uRgWdcRwljAysJ3EmCbn1kUPz/TR2ihgXhASjeYas85Hzni4adTCz7NRG6dY+5QsLbZDuD8F9SuErAN8RDs+A6dsBUmW4C94fEhKnBAbEg7fjQeQW9RBNrmp+TTfLMM454v+kho5l1L/WK6RqiL+2ZWVqnGPkg1e0qhyYYdIn9sETMFGPemLpRu+L9SOvbzGEYnT34PHd7SmZRW5B0C1BNEyS0V/eQPUUgdOspjvQSwaSA5qcOP+ykvpoqoRuRdaPmxpU7oOzKnUVGmNcLDeG0J3WGTHlKq05G3tObkcmg8tCKVNAbJW7BUjeMVNsDsvuyT+RzeAicpeNONBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com (2603:1096:604:12c::9)
 by TYRPR01MB14013.jpnprd01.prod.outlook.com (2603:1096:405:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 06:35:14 +0000
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe]) by OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 06:35:14 +0000
From: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
To: 'James Clark' <james.clark@linaro.org>
CC: 'John Garry' <john.g.garry@oracle.com>, 'Will Deacon' <will@kernel.org>,
	'Mike Leach' <mike.leach@linaro.org>, 'Leo Yan' <leo.yan@linux.dev>, 'Peter
 Zijlstra' <peterz@infradead.org>, 'Ingo Molnar' <mingo@redhat.com>, 'Arnaldo
 Carvalho de Melo' <acme@kernel.org>, 'Namhyung Kim' <namhyung@kernel.org>,
	'Mark Rutland' <mark.rutland@arm.com>, 'Alexander Shishkin'
	<alexander.shishkin@linux.intel.com>, 'Jiri Olsa' <jolsa@kernel.org>, 'Ian
 Rogers' <irogers@google.com>, 'Adrian Hunter' <adrian.hunter@intel.com>,
	"'Liang, Kan'" <kan.liang@linux.intel.com>, 'Ilkka Koskinen'
	<ilkka@os.amperecomputing.com>, 'Xu Yang' <xu.yang_2@nxp.com>, 'Jing Zhang'
	<renyu.zj@linux.alibaba.com>, 'Lucas Stach' <l.stach@pengutronix.de>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'linux-perf-users@vger.kernel.org'"
	<linux-perf-users@vger.kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "Akio Kakuno (Fujitsu)"
	<fj3333bs@fujitsu.com>, "'nick.forrington@arm.com'" <nick.forrington@arm.com>
Subject: RE: [PATCH v2] perf vendor events arm64: Add FUJITSU-MONAKA pmu event
Thread-Topic: [PATCH v2] perf vendor events arm64: Add FUJITSU-MONAKA pmu
 event
Thread-Index: AQHbNAXE9up773d9C0m6SoSVyIeLDbLd2qmAgAFgUmCACvfz4A==
Date: Tue, 17 Dec 2024 06:35:14 +0000
Message-ID:
 <OS3PR01MB6903A0317D8BB90A9B4DD7E8D4042@OS3PR01MB6903.jpnprd01.prod.outlook.com>
References: <20241111064843.3003093-1-fj5100bi@fujitsu.com>
 <ee89c235-a126-4874-994d-b2489eb1c00f@linaro.org>
 <OS3PR01MB690303F6D0FAF71ADDE7AA4BD43D2@OS3PR01MB6903.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OS3PR01MB690303F6D0FAF71ADDE7AA4BD43D2@OS3PR01MB6903.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZDdiMTg4YjctYzZiMi00NmY3LWE2N2EtM2YxMTg1ODJh?=
 =?utf-8?B?NzY5O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTEyLTE3VDA2OjMzOjE4WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6903:EE_|TYRPR01MB14013:EE_
x-ms-office365-filtering-correlation-id: 2b28f266-9b3c-4055-269a-08dd1e64f706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?azhjMjN2dFgwMFBxeW1vUWpyY1FqNGlFRTY4ZWRobE0vcVRJWjhUTU96SVpn?=
 =?utf-8?B?K2tCWWNJVXJiUFFxOHZDR1NYRDVxNnc5ODc5bmxqL0xJY2Rzd2JnOUYwTUta?=
 =?utf-8?B?MVllaVVsUmNaKzI3YU1lWTF2VWhmN05oeUZDVGtkbnYySEZkaXpFZ3ZnM1A5?=
 =?utf-8?B?RlJuc2J0ZS9HSUlnWWl2dldWRHhSNUNrTjk1MzBuTjlxdHpRWVJUQnNVVHRO?=
 =?utf-8?B?bmd5RUtGSUFlekJ4bFAydzRGWjR4RWtwdXltKytBaHRCbkQzWmRIR0FnSkJK?=
 =?utf-8?B?ZS9jSDRDcitVanZrR1VyQjlicXNqWGRzckdRVU5pWCtFSjA1aUxuYUNIUFZM?=
 =?utf-8?B?Zk1WMHpKcjBMT0pCbTRCZmVMZ05JMUxZTWlTUkY2ejBydHBac21JNi96UEVh?=
 =?utf-8?B?eHNXUmNvRkxDNm9qL2kzMFNQL3lzZldmOUJQQ2JEdmNsd3Joc0YySUNSWVJh?=
 =?utf-8?B?aFkyY1FlanZLbHdNTlcwNmNSbUgyQ0lINitlOVcxWDd6alkvbWNmRnl3Sngr?=
 =?utf-8?B?Z1hLSTBPRkg2ZkpvRFlnMXNkOHI0SlMrbTRZYW41QTZESXhJektoekJicXRn?=
 =?utf-8?B?ZDhqbHBUbVJUUGJ0NGIzZzhjVERjR0tIbWJRM253blgrdWpyT1V1NEYwOUlq?=
 =?utf-8?B?cW8wN25IYUVDeUdwaHptNXQrU245QTlxOTN0aHpIRXN2eFRzaWcvU3FRM0FU?=
 =?utf-8?B?RTZPVGNwaW5GU3QrVnpSTFZmb0ttbmJWdytzeTYzL2lmcTlDODVpZXp0eFln?=
 =?utf-8?B?ZERZUkF2cEZKRjhVMWFmeFhIOUNWbDZBQU9zcjd4NW51V3ovMGluUW1sOXVK?=
 =?utf-8?B?RnA4M0hxZ0VlMnlaOGY5WTBJQ3pvMzJaV0dhSEVrL3d2T3pWYm43VU9nenpV?=
 =?utf-8?B?MUl4NFVNVXYwZHFabGZxaC82alAvRU8vVWo1SW42TkRqOWZVaWpGUUo2ZEdX?=
 =?utf-8?B?MjBuY1lGbk5Ec1p5TjZZZENHWWRiM2JObGs5QjdqeTJHTFdZRDZCMUxzaEI2?=
 =?utf-8?B?UUF4Nk9mS1NOb08zeSt6RTlDUlplaUhsRXZCSVRKUVJrd0VoUm56UkRkN2JE?=
 =?utf-8?B?ajNjd0llNWJlUDFnTmdLcXRhaXZadHFpMDhkU0J6WVFnc29iYUpFeHZVUlJ5?=
 =?utf-8?B?NEZ3RURKWWRFRGNZZmlVVjd5R1BCS0tSMG5IY2hUVkZrQlBEMFd3VnFzbkFY?=
 =?utf-8?B?LzFybHZScSt0L1ZHcE1PMmE3b1NnYlRvcmNvcDdaa01TRTdURzB0dFhTMlZJ?=
 =?utf-8?B?TWg3TmRhZ2pMeFFOQnNqdmJUeTZEbzlHOE1wS0JmU0tuNEpkV2hVTXA5NDd1?=
 =?utf-8?B?OUs4Tld4djR5Nk43N0pCVmVLUC9oZG40SDM5MXdkOEFiVVc5ZmNlbm83YytR?=
 =?utf-8?B?bzNYNzJvMFErbGNnQkI3YTNxdExYWHdpSGNDYnJneDh1OFJHaVU4dWl3NmNt?=
 =?utf-8?B?VXF3UjBmZWZZcEJrdlVHOEwzUzd2Mk1rZUp4MjdyUC8xcnp1MnFicDVSaS96?=
 =?utf-8?B?enpTbnZYNlp0N0k1aHEwYXFSdnl0VUFaZFpXYkw1L1FYeW9YRERVSWdBeDJQ?=
 =?utf-8?B?b0FtWHBqLzZaamJMN3FGN1oxOHZOMmRYT011eUhBbmtORGYwVzBuRzRvR2sz?=
 =?utf-8?B?RHZkbEhhcTltMUtuM1R5RldkODR5RE56Rk1ibFVkR2pSTVBxNFNTODA5N3lv?=
 =?utf-8?B?VmVXQlBnNldORTZoYnRwcFFFSTV5YUpUK3dPbEovdzlidjQvbjc0TDZjMEE4?=
 =?utf-8?B?aWMzZjRWMGRyU0JvWks5MjVCS3dyZlpYdTRFT0d3YnMySHBpem4wVWZvVE53?=
 =?utf-8?B?di9ibVc5ZFNMSy93NGViRWowSHA5b1BDa1l0eGp1YnFVVDREUEZ0bjlEVUVH?=
 =?utf-8?B?MWNmY0pYTmNCa2w0M01rcVpPQS9PcjhwR01zcmpBd0NFY2xBVHhjKzNIdVBD?=
 =?utf-8?B?MFFjVlRDa3pmekNUUVI2dEZRMFk5UERrNWRpb3ZJRk10N3o2clRkNmtBZmoy?=
 =?utf-8?B?aUo5Nm9tSi9nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6903.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTc3d0RlSHU2MHZNaG92a2xVSjYxR3ZTZkFXWEFnTVo4THZHYjZVUE9BTFZL?=
 =?utf-8?B?N3dDVlhzZzFrT0FCYlh4dE5mbGFMdUk5eWVVdU9xWTQydFhncGNQUnVQMXBM?=
 =?utf-8?B?N2lEdGJrNWFIWmIzK09UODJTei9waDh4d2lSaXQ2RkFHeXdPK1MrN3NFZ3V2?=
 =?utf-8?B?L2NIU25SYnplc2NDK1dOMHozS0c2T1drZkdVNXdVb0F3aTZjSWpmYkhmcGF2?=
 =?utf-8?B?NGdWcllqK00weDhDZDZlMU1QT2NYcE50NkN4TGJKR2psbkhjMW9QdCtFYmhK?=
 =?utf-8?B?MmcxZVNmYWFKOFZ0UTd4WkpzaTlFTGZWM3VsSDhCVENJclBHdWIxYmRjZFNz?=
 =?utf-8?B?R2RSMmMvVFY3amQ3OUZVQmRzNmNXeENGNlN4S2pIVitrK1E3MjViek1BSzN6?=
 =?utf-8?B?S0hGTnB5MHFvSldLV0NHZE9uZEN3M3Y4SWZLZisxU1JKaXdGdlpuYnFOMjdF?=
 =?utf-8?B?dHVRalRyQ0RTWHdHdS81dnR0VmR1RElSdzJLSCtGUkROaXFKbTEwZ3Axc01y?=
 =?utf-8?B?U1VtYnhNZ29yMnZmU052SXZMZURhazdnVkdoSHFHOG9PRmtyOHpxTThWRDJX?=
 =?utf-8?B?Y0Iwa2pBVW1qazg4Mktvb1Rzbk9KQkxzZUNjcFZpbXYva1BZVlhYaDdQZFN0?=
 =?utf-8?B?NFNTcnFrWTBKdE1IWVhIMlQ1UkJwYVlvcDhMV3JIU2JJZjA1MHlIZlpyS09h?=
 =?utf-8?B?bURiYlMrM3RVQ0o4THhSU2lrY0xBWEw2SkJybC9HeUwwZlpNaUMwN0c1UEFP?=
 =?utf-8?B?amp3WkZCZW5WNnJ1cXVCVnpkWHBwR3JYZmY3czRtd1o4SktMUXcwLzZtUTVR?=
 =?utf-8?B?cVkrUTNId1NQTFhxZUc3bFFkaUtuamNzVFpwMUFLWWh6S0tyOEdpY0pmQnI4?=
 =?utf-8?B?MEtCclhjRlV1RGNLQmFSTlRFREdyQ3NuNDlPTWlUdVBrMG9xbUJyVTM2NElI?=
 =?utf-8?B?NFpQc2pFakJzUitHZm56SlNHME9pa2Z5bCtNdVh2VUVDRkd3Q2FKclB2WXNS?=
 =?utf-8?B?bXJKbEFZdWdncHVmaW5EQ1E0amRPY1JiR0EwWjdPQkJVa0ZGUWZwbGlpcU81?=
 =?utf-8?B?Y3lJOWkxb0ZlalEyMWVsS2UrdDNoZ1dlZDJuOE04aGN0c1lLbHh2anZ3VjdB?=
 =?utf-8?B?R1hGWlhFRmlDdEJXcU5YY1U5a0lKUUNUckFGMWdXS2Z3NlBuSzZka05sZG41?=
 =?utf-8?B?djhOYld4VUxYVlJwaWpoeElUYVVIdWFaR2tuejdnYTJibXducEpZbzRYQjIr?=
 =?utf-8?B?VCtJVG85eDYxbkw0eit1NG5wWHhqb2xpd05kZUpGUHB2L2tMVmQ1VlgvOG5M?=
 =?utf-8?B?QTE0L0lxTE10bUt0cEtBOXVvOVNBcFB6cTdLM2Q4YS9LaVFKM0JPemV1U2sx?=
 =?utf-8?B?VFNucWwzUG9jMVB0RzNDNk1PakhJRHpHdVlHZXloR29ESi9kNlQ1RFpSOFVz?=
 =?utf-8?B?TExoM0orS0Nxb2d2ajUxcURtdCs2LzlkNFlYa3o3c05Ma24zOWxlb0FCYTNC?=
 =?utf-8?B?ZFV3YldvbmlnbzR1K3lpS1E0amZROURCcUFnWXM3M2p3Q3drQjd6ek9CbGFE?=
 =?utf-8?B?OVZJcS8rbHZRa05rNktSS0RNUldldStuTmdiYnQ4M2RaOGJuZ1ZEQ1A4cVIz?=
 =?utf-8?B?YTdGekRsNWJUZE9hbmFWK1g1TzNFTm5Ldk5kdDhFL3l3eDdxYXlQZE1SYzVW?=
 =?utf-8?B?bW5MeC8zNHhsNjBOU1VUZVYvWngvYjNnc1dRZGhGbUVmZWRzckk1WGV3UUxI?=
 =?utf-8?B?VnRudC9lbDRaYzlQYUc4MTc0bmhrQW4xRldIeE56SEJDM2l0NTArMW4rZmNh?=
 =?utf-8?B?YmhyUktBNUYwbHN1bzl6Vm92dEg4cVlsOC9idlRBbjl4RFJhRm44c2xGc2xh?=
 =?utf-8?B?RjFFYmVUWS9QT0xzQnc1cHZLNCtyRTFTeVpKK3dXRDhmYUtxeTMzZE11L3VD?=
 =?utf-8?B?NEZENzN2VUFmT1ZlR3Y5VDlXaEEzOHFmRkthR01Nd0piWHVyMlAyclB4cGtX?=
 =?utf-8?B?TEtYRU1WYU55NWZxS2hjNTVEbDh2VXZCVjE2OVdhS0pHdlRVVTdnV2ZiOGRM?=
 =?utf-8?B?cThZcndneEp3WkNhK3RaNERCU1NGY2ZMWVVJY1ptQmhVTzNwQWE1Vk5NaXdP?=
 =?utf-8?B?MXhIWHIxZlBTdUJ5bDA3bmx6Tm5nT2IwVVdwQWt3ZFVveGZJVGtxZW5nYlhE?=
 =?utf-8?B?M3c9PQ==?=
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
	r5YwyGhFfiZs75/ln0wXFXD+zpyKX7rtQgSnrZKiWd7jImSGEYJyvE7kgyhUvlUitjl/7XO1YHz+a//Zlz7b6Cqx+Y3YCBsIdq1ZsqcGS8nmLg60ibMhzNwKb3bp9kgJDv1Hu2hTCA35Wz0AtP+Q+5O0WWmVp8tqraBAc9yKBTW/CXesWR+r5KI6xw9mmLWx7D7BJvnL4+SDJD7AJHpzff1YOTezzaF0nfQPemFRYJ1hnzNcK56eN/5WHMw42KMmIS4wiRiRdsY9YdtTc3GFQwZuiwWVTCuXIZwhfAgpvfxdL9q+nmASTW58KLJqfdAH8sZJLiFqEpip0wRUs00n0yT6bf3OtnDLQkbJWnlBipSfpxA28s65d9IkErsq1Jlpd11xPlANgnBEjcF6Pmj+N3OV3gQvFUqzAWU8QLjoGkRFJymleDddUwdyaDsmpFcYHpYPh56rBP4s+jXLVe7jmS7TyjZYq2Z0L9mQib4LS9soqVv8mi8OBXsbIv1Q1Ilpgx83vuFCYFX7kDeiMZ/YeSD/MmUfhRZvVA2qc78fLux6AkyOW1bzgrA0BcAk2oup9X6SnIMG3GXI8CdrnFkwDGqJrhQLp5nhhueaBHfn9AAI9+StxHFkohVbFuTz4bLv
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6903.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b28f266-9b3c-4055-269a-08dd1e64f706
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 06:35:14.5985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJH2amA1TzqhgDbYWTOUoNEb8cvqZqxucKMMyC17B2DAn3usw8RzgeCdduSUOpzbRtpRq5+P/VKkuFQMh0TA0WCAfo/h3HldZAk/bf8KRWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14013

SGksIEphbWVzDQoNCj4gPiBBbHNvIGluIHRoZSBjb21tb24gZmlsZXMsIHdlJ3JlIHVzaW5nIHRo
ZSBkZXNjcmlwdGlvbiBzdHJpbmdzIGZyb20gdGhlDQo+ID4gQXJtIEFSTS4gSSBub3RpY2VkIHRo
YXQgdGhlIG9uZXMgZnJvbSB5b3VyIHNwZWMgYXJlIHNsaWdodGx5IGRpZmZlcmVudC4NCj4gPiBU
aGlzIGlzIG9rIGZvciBub3csIGJ1dCBpZiB3ZSBhZGQgYW55IG5ldyBBcm0gY29yZXMgdGhhdCB1
c2UgdGhlIHNhbWUNCj4gPiBldmVudHMgdGhpcyBkZXNjcmlwdGlvbiBtYXkgZ2V0IG92ZXJ3cml0
dGVuLiBGb3IgZXhhbXBsZQ0KPiA+IEFTRV9TVkVfSU5TVF9TUEVDIGluIHRoZSBBcm0gQVJNIGlz
IGN1cnJlbnRseSAiT3BlcmF0aW9uIHNwZWN1bGF0aXZlbHkNCj4gZXhlY3V0ZWQsIEFkdmFuY2Vk
IFNJTUQgb3IgU1ZFIi4NCj4gPg0KPiA+IElmIHlvdSBoYXZlIGFueSBhY3R1YWwgcmVsZXZhbnQg
ZGV0YWlscyB0aGF0IGFyZSBkaWZmZXJlbnQgZnJvbSB0aGUNCj4gPiBjb21tb24gc3RyaW5nLCB5
b3Ugc2hvdWxkIHB1dCB0aGVtIGluIC4uLi9hcmNoL2FybTY0L2Z1aml0c3UvbW9uYWthLg0KPiA+
IEJ1dCBpZiB5b3UgYXJlIG9rIHdpdGggdGhlIHBvdGVudGlhbCBvdmVyd3JpdGUgKHdoaWNoIGxv
b2tzIGxpa2UgaXQNCj4gPiBzaG91bGQgYmUgb2spIHRoZW4geW91IGNhbiBsZWF2ZSB0aGVtIGFz
IGlzLg0KPiANCj4gSSB0aGluayBpdCdzIG9rYXkgdG8gb3ZlcndyaXRlIGl0LCBidXQgSSdsbCBj
aGVjayB0aGUgc3BlY3MuDQoNClJlZ2FyZGluZyB0aGlzIG1hdHRlciwgdGhlIGRlc2NyaXB0aW9u
cyBvZiB0aGUgZXZlbnRzIGFkZGVkIHRvIHRoZSBjb21tb24gZmlsZXMNCihjb21tb24tYW5kLW1p
Y3JvYXJjaC5qc29uLCByZWNvbW1lbmRlZC5qc29uKSB3aWxsIGJlIG1vZGlmaWVkIHRvIG1hdGNo
IEFybSBBUk0uDQpUaGVuLCB3ZSB3aWxsIHdyaXRlIGN1cnJlbnQgZGVzY3JpcHRpb25zIGFzICJC
cmllZkRlc2NyaXB0aW9uIiBpbiAuLi4vYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS4NCldlIHdp
bGwgcG9zdCB0aGlzIGFzIGEgdjMgcGF0Y2ggbGF0ZXIuDQoNCj4gDQo+ID4NCj4gPiBbLi4uXQ0K
PiA+DQo+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiBhL3Rvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNo
L2FybTY0L2Z1aml0c3UvbW9uYWthL2dlbmVyYWwuanNvbg0KPiA+ID4gYi90b29scy9wZXJmL3Bt
dS1ldmVudHMvYXJjaC9hcm02NC9mdWppdHN1L21vbmFrYS9nZW5lcmFsLmpzb24NCj4gPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjgwYmYxN2ZiOGY0
Yw0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysrIGIvdG9vbHMvcGVyZi9wbXUtZXZlbnRz
L2FyY2gvYXJtNjQvZnVqaXRzdS9tb25ha2EvZ2VuZXJhbC5qc29uDQo+ID4gPiBAQCAtMCwwICsx
LDggQEANCj4gPiA+ICtbDQo+ID4gPiArICAgIHsNCj4gPiA+ICsgICAgICAgICJBcmNoU3RkRXZl
bnQiOiAiQ1BVX0NZQ0xFUyINCj4gPiA+ICsgICAgfSwNCj4gPg0KPiA+IE90aGVyIGNvcmVzIHB1
dCBDUFVfQ1lDTEVTIGluIGJ1cy5qc29uLiBGb3IgdXNlciBmcmllbmRseW5lc3MgSSB3b3VsZA0K
PiA+IHB1dCB0aGUgY29tbW9uIG9uZXMgaW50byB0aGUgc2FtZSBleGlzdGluZyBncm91cHMuIFRo
ZSBzYW1lIGlzc3VlDQo+ID4gYXBwbGllcyBmb3Igc29tZSBvdGhlciBjb21tb24gZXZlbnRzLg0K
PiA+DQo+IA0KPiBJIHdpbGwgdXBkYXRlIGFzIHN1Z2dlc3RlZC4NCg0KTU9OQUtBJ3MgZXZlbnQg
Z3JvdXBpbmcgaXMgYmFzZWQgb24gdGhlIGdyb3VwaW5nIG9mICJuZW92ZXJzZSBuMS9uMiIuDQpX
ZSBmb3VuZCB0aGF0IHRoZSBncm91cHMgaW4gIm5lb3ZlcnNlIG4xL24yIiBtYXkgZGlmZmVyIGZy
b20gdGhvc2UgaW4gb3RoZXIgY29yZXMuDQpGb3IgZXhhbXBsZSwgIkNQVV9DWUNMRVMiIGlzIGNs
YXNzaWZpZWQgaW4gZ2VuZXJhbC5qc29uIGluICJuZW92ZXJzZSBuMS9uMiIsDQpidXQgaW4gYnVz
Lmpzb24gaW4gbWFueSBvdGhlciBjb3Jlcy4NCg0KQXMgYSByZXN1bHQsIGl0IGlzIG5vdCBwb3Nz
aWJsZSB0byBjb21wbGV0ZWx5IG1hdGNoIHRoZSBldmVudCBncm91cHMgb2Ygb3RoZXIgY29yZXMu
DQpXZSB3aWxsIGJlIGNoZWNraW5nIHRoZSBjdXJyZW50IGdyb3VwaW5nIG9mIGV2ZW50cyBhbmQg
bW9kaWZ5aW5nIHRoZW0gYXMgbXVjaCBhcyBwb3NzaWJsZQ0KdG8gbWF0Y2ggdGhlIG90aGVyIGNv
cmUsIGFuZCB3aWxsIHBvc3QgdGhpcyBsYXRlciBhcyBhIHYzIHBhdGNoLg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpZb3NoaWhpcm8gRnVydWRlcmENCg==
