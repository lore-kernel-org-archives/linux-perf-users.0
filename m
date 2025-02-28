Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA52594B7;
	Fri, 28 Feb 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736585; cv=fail; b=YBELDsg8Qztfh9B28CRVWbGE1+i9KBz4dWFWgDxRrgwpMqYfAVuo/yctytzCnnA8ivQGfVlK3CWiYupnyF6ILpI5WEgQq30pzwvOWWH8vPtVHWJmxZBh3x/AUHRQ0IQIAsJUceARKbzKxRg/c8aw6nfWTpmQbOrLM26XY+l587I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736585; c=relaxed/simple;
	bh=l6De3czXBfI7Zn3oYMWbRpXcYHVLgy5ysB7Kln6Vur4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fuY6DJCiAafY/6RLYKzVM+VoRalW6WJD1lto+mHh6UKAZ7JElp8lD+EWD9H8kbscZVQAJjym6C0kxrX2oN6edSYgGC1sfuQatM7SivV/zjKaurSWnlqNA4vhX8AMwKoe9vDMrly/U7TE36niR1Ttxe8vMUt5eJYrSWsF4mpROTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=F6uxNVwz; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="F6uxNVwz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740736584; x=1772272584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l6De3czXBfI7Zn3oYMWbRpXcYHVLgy5ysB7Kln6Vur4=;
  b=F6uxNVwz8M/dFPwUrdWiv/6678+PxQ0t9zOu6YcBT3Km0QHIglq4uBAb
   JcN/FUL16hy8eGzvTrpiGPiyHaXPJ2ZCv6ysMF5O83eOvm7S7nk5Q9HYE
   6mg4+YAqSiM2tS9MuUqzfPSoBfkfZImLojyHSGujAA9KjswHA3gsdpi9H
   vhnkyeAfkR3+BSqEV8RaCbt1LcIYZ28do7Ysv4lZMwOGBwsSDb3Umktrc
   Iw01mx1BOddqaVM43pet84AKlbOBET+4Wrm723HtFWVxnsKZGIB0TcGvp
   vYkXXwtvEWL7Z1MW6fU01qPXiURrMfgLLfJY/ie3F1I/1vDWkNxkb8NTf
   A==;
X-CSE-ConnectionGUID: 0htmSCSTTxGwcYp+kOmvRQ==
X-CSE-MsgGUID: ODJF4sPzRFyFJJCicWPdDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="58947488"
X-IronPort-AV: E=Sophos;i="6.13,322,1732546800"; 
   d="scan'208";a="58947488"
Received: from mail-japaneastazlp17010007.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 18:55:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfEAB9kWjIpxh4kxuYgJgC6tPL76dYoZunWJoeLE2FxubOuXpPUosLy1CbOzSCowes5B+OLm22RED4SpQ1HnQQq0jrFxKc4SnURBkGLsq6hCnBGuipOQWXo/4QEG0BSY3zvxe6IK314rXEOUvxMavrkP1DLYOO5eqLE8jGMvn55gXCYTKdiocFmDG9Wv/6Pjr0Td1/ZX5JurrB+TMuIQ+WAAN0jemmFo8agohKev9824OVjVtbpuDnVNG1MUGepq/osm/YrTNATdUIFfevs3XsaFwq3Lr3De1mHDTjcLdcZrtlL/rCdIALUInYf7PDwS97dPOd+FaqY5zGQT5Tgx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6De3czXBfI7Zn3oYMWbRpXcYHVLgy5ysB7Kln6Vur4=;
 b=DcM7JJkmOB+nrgjqfyPkdGm9v/qidvGkl7RMCoTo5GNjguVdcjNek7Vl9jD1VxuL+2HQxa6XeYpB+mDSzgsKKWns6NBXyhEYNaY9eBaUeOU2ryayrBetMZPec29CAlf8rOkWzccm7EnEZzLm2rajhk19A+TCy/WskdzNuI5hlXlTFJqcwZIDM9xYJ8wW8JBTrkGiykLogaZgocdJxM4MsxflVBwrZ+5Cw0oE1gQ3F2lXdXxjvDs8v4MSTkiQobMhvp7AWm1VlmqAS0Vz6wyUcEn8o4iT4sfpcHtlljdgoEbw0Mf2jF786+mBYpxhLQIyOX0y6sQsGa6BlTlfOaqydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6908.jpnprd01.prod.outlook.com (2603:1096:604:138::6)
 by TYAPR01MB5707.jpnprd01.prod.outlook.com (2603:1096:404:8059::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 09:55:06 +0000
Received: from OSZPR01MB6908.jpnprd01.prod.outlook.com
 ([fe80::ba52:b073:8bf:cc35]) by OSZPR01MB6908.jpnprd01.prod.outlook.com
 ([fe80::ba52:b073:8bf:cc35%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 09:55:06 +0000
From: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
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
	<linux-kernel@vger.kernel.org>, "Akio Kakuno (Fujitsu)"
	<fj3333bs@fujitsu.com>
Subject: RE: [PATCH] Remove some PMU events for FUJITSU-MONAKA
Thread-Topic: [PATCH] Remove some PMU events for FUJITSU-MONAKA
Thread-Index: AQHbiNpQ8JjCRF9TOkCjxP8mdt+sprNa+hOAgAGBj7A=
Date: Fri, 28 Feb 2025 09:55:05 +0000
Message-ID:
 <OSZPR01MB6908AA7CEB24ED38F9289D6DD4CC2@OSZPR01MB6908.jpnprd01.prod.outlook.com>
References: <20250227054045.1340090-1-fj5100bi@fujitsu.com>
 <96b323eb-15b2-4b60-8522-83bf2f57694b@linaro.org>
In-Reply-To: <96b323eb-15b2-4b60-8522-83bf2f57694b@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MTA5Y2JhYmItMjdiYS00ZmQ2LWIzNDQtYTQ4NTFlYWQ4?=
 =?utf-8?B?MjMyO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDItMjhUMDk6NTM6NTFaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6908:EE_|TYAPR01MB5707:EE_
x-ms-office365-filtering-correlation-id: fc1d3506-c0f9-4327-6218-08dd57ddfaa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dm0rcHFqVjZJYWdIekZmUEozbEJ3R2VIdzdXMGo2Qzd3L1Mrb3hKa0hINGNI?=
 =?utf-8?B?TjIrQ2F3VENscFpiTlJSSWJiWktzMC81MUN0R0FOSHJrNTErQWJGeGFnMDJW?=
 =?utf-8?B?dktIQ2FVR214dW1uZEthTFBIZnIwT0hmQ1RDNXVwTG5mZHpGL0lCRDBZbmd3?=
 =?utf-8?B?aEU4VmZ2Z2JRa294Y05pOWhxZXRIK2wzYVNnK215OTlrdjBQdWNaYUw0a0dr?=
 =?utf-8?B?VEV6TjQ1YThCb1hsVTFUdXRxS3Mvc0RPZnFqVkpuTHdzTnpZS3ZJSER5ZFM3?=
 =?utf-8?B?OVJ6b3I0c0IycTZ3WmdJT2JFRncvUXFPZ1JPVjA2Ly9YSXRZNU53ZXA1QUFs?=
 =?utf-8?B?cEpTQjR1NDNZZmUzNkc2R2FiRnUxVnNEaTFEcGsvNGJ4Q1FTTDBCWXMybnRi?=
 =?utf-8?B?Wklya1p3WkRaRDRpVXpzUlZENFRpM095Q1RjZmQzRjIwbEcxZzZGRzh6dnNC?=
 =?utf-8?B?SjJmUmdHaUFHc01uLzlKelF2Nmp2czhxbGVYYVlTeFNHL2VKQnhsaEt3dGpM?=
 =?utf-8?B?cG5wVHRBdVUwSEJWQUV6a2VaZUZSajA4b1ByY3VoN1dtK3hjUHE0SnRteWI3?=
 =?utf-8?B?UzNaQjJwVHl3N00rNzNpQW5VTnlJZk5Yd1VmZHAvT0RGeXFGODZyejNNbzNk?=
 =?utf-8?B?U0V5YmZ5S1dOS0dsZTlLZVlLQ0JoWC9oa1dPVW5ERmY3RmtSYlMwWmczMHg0?=
 =?utf-8?B?dThnWDRPb2pOWXgxV0padnB6anhqVjFTalBJRUQ1bDRFZUFmMGpKUVBQeitD?=
 =?utf-8?B?azlKY1Eza0ZMK2lrQmk5M0ZyVjFBYVdBdWtxNmlzUGozcXNscTViQTllTHJP?=
 =?utf-8?B?M1BkM1R2b0lpdFVqeWRIc2hBYjgwWkpHVThZcGVXSjQ1dTBUbUdTSzZ1enRw?=
 =?utf-8?B?bFQwejhMZUptTWFhZHJkOXkvSXBtY0NlOUdaMnEzcXpMZ1RZZmZDVnFiNVk1?=
 =?utf-8?B?T3BlMFR0RlJPWTc5RkpSeEQwejMzK1BiUkFNYWNjU2RaN3o3MVRIRC9MMDBG?=
 =?utf-8?B?Vk5mck1yejQrZGFZTG01anpwWC84ZEdLS2QyZWQ0ZnZuUlpWREh5YTkra0t1?=
 =?utf-8?B?dGozV1ozL1RUUk5hUXRickZ6NWY3UG92ZHhPL2tLdVNkVVYrMDVZN1FKZkg4?=
 =?utf-8?B?VW9WSkF0blRmZ0ZJb1pJdVJuWWVsVm5SbU5paXlCdjBMU1hTQ2FGai9rV1Vw?=
 =?utf-8?B?blg5a1o0dG5wNjM0UVNPWWRBTEliMFluT3lQTDhLaitPQ053Z0h3ck5BR3h0?=
 =?utf-8?B?SkFmVi9nUnJZbWFTWEJsL1hBYlNHTmQwZTR4UU44VTRSLzFYRmhsaWh1TWRR?=
 =?utf-8?B?cm5ZUGx1aGxudXRXdHI1d1FEWnBUZElacXlvMUNLMHhpYWRNaDJuRGNNUFNs?=
 =?utf-8?B?MjlkUm1mUS9sZlJqY29oWVQ2ZFdyV0RQbFpUN3BrSTZlL0x4MmRUK1U3dUpm?=
 =?utf-8?B?MW4rQnpTZk5jSkhaMzNEbk5jaWw1WlZtYWtraWNVaGNMNmUxLzdJWXF4dzcr?=
 =?utf-8?B?NDYwR1V3TGVxY1RvVmRkV0pQQjFFTHlVRjlSakdnUk9vbGRLN0V6WWlCOS9Q?=
 =?utf-8?B?SWw4eHBKVzc5T0U1TzlOT2EwMnhOcUM0RWpwcC9iQmZjUTFwR1ZSRzlOeXlX?=
 =?utf-8?B?eldxcHZvbVN3Mk9PcFdSc05KRTJZSHpmZ05qUFF1QUFjVzVCc1M3dFBhaFNQ?=
 =?utf-8?B?dEUwNDFCbWFKQms0RmtmY2NsZXQ1bFgrQ09TcjVTdWd1aUhOb0xhbXpVNUJ6?=
 =?utf-8?B?V2p1VisxRFB3OXcxSjYvMzFCbHc2TGd5cWJNY2xUNHRERXFpTXZIZDRqZHJI?=
 =?utf-8?B?RkJtUG96ZElMeGF0MkJRdnFsaS96dDVaZ2dRMzdRTVpRSXFhbTVkalIwdElv?=
 =?utf-8?B?N2Ruc3Y0QlFvd1RTVytCbmxxeWlEMXlCbGs2aEgybXRKUDBhMUpWTFNyRHZ6?=
 =?utf-8?B?dWFKeHJrY083d0t1Y1YvS2NZUWMvTEVJeWh2SERNaVJMakY0bW85R0RnOWlq?=
 =?utf-8?B?WDVEZWxFaHlBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6908.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkw4K3JWWGdEQXRCclpmckpTTUNtVGJXd3FJSzc1V0RKUVQ3UENzc00wandJ?=
 =?utf-8?B?N1NQK1c3bm8zanNTR09naE1Uc0wvUTYzTHA3MVFNVDZpN2VWb1BtVzBMRHBk?=
 =?utf-8?B?WkhacFFiMTA3QWdkUFpyUDcyRGFzVG93djZWNDNpQTdqQ0xXNkNzOEdueEI2?=
 =?utf-8?B?V0wzelBBbDVSdlR2MysyaERwbVlvV2hDUHFUcm9TQ3hycklkOUV1eHBaR2py?=
 =?utf-8?B?Y2hsRUlQYTkxSkNGTGJ2ODM2dVFXUW5Oc3gwTElNU0lOTWdVeVViL0o0NUhv?=
 =?utf-8?B?b0JZUWJPS21JMFAyaXZGaSsxV0d5Rm5lUVhxbVVpeXBLM1AxMWdaaUtoTUU2?=
 =?utf-8?B?UC83MHhzbDZ2VjhiWHdVdXNWcXpzU2x4K3psdFBMZUc3RjhMYzR3NGVaM05Y?=
 =?utf-8?B?VmlWM3lrd2J4YzI4RjUrQURpMTg4aEJQOE5CRHNEemR3QXB1NG5Ma1FDSFh3?=
 =?utf-8?B?ZjlBdzFJOU5kR3JUcWpzdWVLTmZMMHFvdlBXMHFWbFpDUU96V1VMaTU5c3ZB?=
 =?utf-8?B?c2JHVUQ2dGdMd0NvVGR2ZDAxcGIvaVVQVkN2Z2tSOUowb1pTcTY0Ti9UMlRp?=
 =?utf-8?B?S253VnVFSElYWFNyN3B1SGdjczc4cmRkbS9EK0ZyNCthN2hNZ2lsMlBHYU5O?=
 =?utf-8?B?eGJJaDc1MmpYRkJ2WGJWMmo2ZXRjYTJFRGxyc0VDQVlnVnF4Vk4yTFBTbUpS?=
 =?utf-8?B?SVpZYWkvN2EyZzl3MEMvRzNPYXRpdE53NG11enNxRmMyM1JzMUVBak84MUVJ?=
 =?utf-8?B?Nkl4ZGoxMXB0Wi9ZbXpJdEw1L1h5bW44V2tYYVhJekxxWWRYUWw2R3JZTDk3?=
 =?utf-8?B?Z2l6dUxjc1FZSnJTUXlXR0VabFZNZXh2dHl2U01vTXR2SnFCWTFONmEwR0Yz?=
 =?utf-8?B?T3lHaVQ2Y3dNTndvTW9JSlE1N0ZSMVhvcUh2SnZ1ZEUycUhlTlBBWEdTK3Y2?=
 =?utf-8?B?SXJoRXJzV3BTTW9aRXVJdFBJNjJJd3h5S1RyUEUzM3BPUFc5TDBXdjh1MXZ2?=
 =?utf-8?B?NkhrT2VPTjZlSHVQYkM5L0pWZlQrMVVyTmt0UG1TNFRYMXJZeWdQUHJyNkhw?=
 =?utf-8?B?WFVtRjVYYWlVN1VKQlJoQmtQMWdzLzBJRmpBSDVkcUtOd29SL1BCTW45bG5E?=
 =?utf-8?B?R0JFTTRHY0NrN1FzdjkvNXFFTE9lZXJ1Vk9rQk9TTWdhcVdiVFlqMWZteS94?=
 =?utf-8?B?dzlKUkFoS1V3WDB5RU80R0lYcGJRWFAzZGw1Sm5YM0drS3BWVlFJMGZ6SUVS?=
 =?utf-8?B?dENnZHBPZktjY084RDdmdXlyUytnQlUxWFhVTGdKT2pMTkRLdllpdFJ3S29z?=
 =?utf-8?B?UVZoQWNxb2JxZWpmUW05ejI2R05NZGZtaFRVb2Y2SzIwalU2MWczalNJa0xB?=
 =?utf-8?B?UnEzcVFOK285WTYzbWFCTmxGZWJuZUtQb1VlN2ZMMlMwYkpMNVFVSG52RzdT?=
 =?utf-8?B?bk1IcjdJZkMyTWUzYzluWlUxd3FvYXdvYnpxQkF5a1hBcEpHU05xRnY4K2pN?=
 =?utf-8?B?Z3ROV25KYjNLKzBPbEFYM1EvNG9EK2Q3YVlRc3RVYVhnNnk5bUdtU3E4Q3N5?=
 =?utf-8?B?ZkZOTDhnOGxlUDZFRENiZWRJK0NNb3JvbVRsYjBCNG1zQ01JVjIyUmVsMFFH?=
 =?utf-8?B?dkxEY2pGSVg1UzZmY0tqRUwwNENiZHJjSDFJdEpoYVVmRXNrNWtadGlyV0I1?=
 =?utf-8?B?ZExOaDFCOUFWR1RCd0NMcFFqVmpBc0hucGtJV2k0UjRudnlGbDZOdzN2VU9x?=
 =?utf-8?B?NG1GM1EwNkJscWxCZHVPM21wRzFXcy8vSUtjTUJMNXFURXl1alI0RnVPWlZN?=
 =?utf-8?B?ckxVU2NGOFo5d2dJelBXMWNseHlJZ0E4aFNrYkJxZ3dwY04ySjlmSFRHRFE3?=
 =?utf-8?B?cy9kNnlQeHRCck1RRzJCWkJrUDdjbzNIM3pVeEN6MTRKWUp3NlZQRURUSDBK?=
 =?utf-8?B?MFlVVlpDbjR6Nm1RdDZlQTJXV21xWVY4S1dic1dFc3p6SFBhOUprZmtOSURT?=
 =?utf-8?B?MjVVRWJKMmZ5L3duZFZZdlk4dXpnejkzNjQvT3NjbDZqN0w1UkRobEZmMllV?=
 =?utf-8?B?QTB1ckVyM3pGamJlQU5hUTFETVlwcmVHOWhzRllPVkEyTWlNRUY1dUJpSGI2?=
 =?utf-8?Q?tXkdauY7jgq2SBhhRsjJ9OF3B?=
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
	UVedv/yABreC0JUMuvVW7pJsGDc5gNUTTrWE7w1ooSLpLHhY7BkQtZtjNCjO8ZMrJvILggyWyntDwpiAA7baiGWgHTgfm8Z2aFtrlBueqaXPtMKBTJ5pDvrpOg54kUtgb7QeGvg12ZW2ixAq3Na6CNYhYADOyyvHN22/unFPqGsR1/FkJ/h+CQe50A121W9zk5M7KXRsWrdtaoKYFmwG6kU5Qxdz7it1tdahs2JCIquirjap1VrR3bJI6/6UbJMnEYSNqHyabfg41MpDT8SEjdE+2iVSFROxYrZUmat9HwV2+0/Fbynvbr4CjA1ligpUG7T0d4CJlFinUXXTxr3sWI69oC2FGujhFRZ3ziRyPrwsQsn+roYYC9BqB9kUK7rSDOHmzuKnHPYJTA8G7j1bdxZAsuR5yFDgUx2Q/sOLGzGlz+J4g1HiiItL5ggyBlhNaTB/NPffFjgU2wZgfUo51q4m9NVggU3gzQqiixU4phKih0U8aoQU5B/QjBMUoIf7F2I39sDImzL7C2B8rHc9fizs2IB7pP5My75uLZBGmtmUMOFcV5Kd4ct4Vzyu4E18zNFB/ZRaF4FcKfPB/Wi2JtDVbZFEWEXsSCaLPTyBS5ogije6S06cvHlyw9KaHjPS
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6908.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1d3506-c0f9-4327-6218-08dd57ddfaa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 09:55:06.0827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2EeJx+JW9ZSI5V+XeEAVcGgzWrkforVOI1LB45XFCaZCZEhad0EHFoPuhdlT4zmv7S2+Qsm3CTMBI11TTjsKFO9I/Tr8MjH9V9IzQSXNnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5707

SGksIEphbWVzDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4NCg0KPiBPbiAyNy8wMi8yMDI1
IDU6NDAgYW0sIFlvc2hpaGlybyBGdXJ1ZGVyYSB3cm90ZToNCj4gPiBUaGUgZm9sbG93aW5nIGV2
ZW50cyBhcmUgbm90IGNvdW50ZWQgcHJvcGVybHk6DQo+ID4NCj4gPiAweDAwMzcgTExfQ0FDSEVf
TUlTU19SRA0KPiA+IDB4NDAwQiBMM0RfQ0FDSEVfTE1JU1NfUkQNCj4gDQo+IFRoZXNlIHR3byBh
cmUgZGlzY292ZXJhYmxlIHNvIHdpbGwgc3RpbGwgYXBwZWFyIGluDQo+IC9zeXMvYnVzL2V2ZW50
X3NvdXJjZS9kZXZpY2VzL2FybXY4X3BtdXYzXzAvZXZlbnRzLyBpZiB0aGUgaGFyZHdhcmUgc2F5
cw0KPiB0aGV5IGV4aXN0LiBJdCBtaWdodCBiZSBiZXR0ZXIgdG8gY2hhbmdlIHRoZSBqc29uIHN0
cmluZ3Mgb2YgdGhlc2UgdHdvIHRvIHdhcm4gdGhhdA0KPiB0aGV5IGRvbid0IHdvcmsgaWYgdGhh
dCdzIHRoZSBjYXNlLCBvdGhlcndpc2UgUGVyZiB3aWxsIHN0aWxsIGxpc3QgdGhlbSBhbmQgeW91
J2xsIGJlDQo+IHdvcnNlIG9mZi4NCg0KSSB3aWxsIGxlYXZlIHRoZXNlIDIgZXZlbnRzIGFuZA0K
YWRkIGEgd2FybmluZyBtZXNzYWdlIHRvIHRoZSBkZXNjcmlwdGlvbiBpbiB0aGUgSlNPTiBmaWxl
Lg0KSSB3aWxsIGhhbmRsZSBvdGhlciBldmVudHMgaW4gdGhlIHNhbWUgd2F5IGFzIHRoZXNlIDIg
ZXZlbnRzLg0KDQo+IA0KPiA+IDB4MDM5NiBMMkRfQ0FDSEVfUkVGSUxMX0wzRF9NSVNTDQo+ID4g
MHgwMzlBIEwyRF9DQUNIRV9SRUZJTExfTDNEX01JU1NfUFJGDQo+ID4gMHgwMzlCIEwyRF9DQUNI
RV9SRUZJTExfTDNEX01JU1NfSFdQUkYgMHgwMzlDDQo+IEwyRF9DQUNIRV9SRUZJTExfTDNEX0hJ
VA0KPiA+IDB4MDNBMCBMMkRfQ0FDSEVfUkVGSUxMX0wzRF9ISVRfUFJGDQo+ID4gMHgwM0ExIEwy
RF9DQUNIRV9SRUZJTExfTDNEX0hJVF9IV1BSRg0KPiA+DQoNCkJlc3QgUmVnYXJkcywNCllvc2hp
aGlybyBGdXJ1ZGVyYQ0K
