Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96F11185;
	Tue, 27 Aug 2024 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726783; cv=fail; b=s1ss62IaehTfi2QAZrGr+63qQHb04OA3Hf5JH4o4WE2CqR4H5keYtk2Qff+jvT8+v0mU8R4+S6lLQYb423vJJ7T5VyJXoLWShf4MgMFZ9GDvMLtixoQBhydyaY5odR2U2g6lo+GQiE9deQqye/5s4sfVj6bBLpUz7Nfoum4m5B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726783; c=relaxed/simple;
	bh=hZcR4dUcD6J347eGsVgkuyDL1iQAfAF2Ox6DbbTIF58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ERl0yofh9wlqDL7m2Z4ptMau0jaC/Y3Q7No8nH1b1m5n4e6DDSEa5kzD73fzXrUlMfCPA88tPK7xLF4Ggh2HNmivIVgWMuKYnB0q8GniqNtp+TUWFdfQ9TLgp99xs9BF6hjRbErYJfgQdc/T7bKGbfUJssa09s9XHOm07HebpAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=hJ3APv+v; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=vyQD9VBo; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hJ3APv+v";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vyQD9VBo"
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QItCE8000361;
	Mon, 26 Aug 2024 19:45:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=hZcR4dUcD6J347eGsVgkuyDL1iQAfAF2Ox6DbbTIF
	58=; b=hJ3APv+vUl9Zd2A/i+zWMH3ar4hZnPIyCdpqrX0Q9wAfPrGzPqvMRWoqK
	j/9VIlaX2G09OI7hXZh1MvRhy0GI66Q3KLI+L4eSD7GfdnHbUGP//c6Dk9A/ogxb
	LT8nRCafjNUHo4+P4/2VgeuT0CEoduT9D1ixhOXAcQCehTApznpk/tqwgc+0lVrU
	q2JmOHxcW11nocP9MX+gQGKLaILtladaCF+Da1wX8aVFTHZtoHGHqC+1S6Na15Vd
	rtLrYxBTxoqCshcj83GxvnAwfHKJnENz8vPWd1uYKzVu9WCRet0xKeEFK0iJb0G4
	jYbsXSAjZw/MkhS5mHm66DmP/u1mw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 417dmhd13y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 19:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILyG2IhMijvurWctcuY1cpA7qlCUbdCD9PezTRXXlyIA01aL6uo92f9W5JCYl9UotBkqjQyi2vPaDReAQLzpMO+cX4IkijHCMIEnau0tC7ia+UyS629lTPIVJGdnpn54bMdrgIVlWRtiQPkHiZPUH4eRg8HaxXdM5f38323WqBo+OKOrqc8PAvR+XCmoq2XprmYwiRIaDgggfmE06Sr85Ytg4o0/qjKmUIsZ3KqlMRplyMejXnRoCbKe7leM8pxatc9HiwqQwsWPZyp4Iz91tD9My1fzGIfQIHymL0KsEnNs6f0tU1LfC9ztWlcBD6uCORGcjVycCMXpVht1MoigGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZcR4dUcD6J347eGsVgkuyDL1iQAfAF2Ox6DbbTIF58=;
 b=P7SD5vHq4RmldhITQPkZXBu2Jsu/lEvghRm7EtwW9ejCOd4Hy2+kKrjMOV6P0A9kM9DzqdSzZCRHvrzdaoEZuzf6vvSEL4bKiIqmcohLYZGtREYk4cP1kn5u9AJYIVboC/E0V8AfsQtaETd9JF9Z/jXPiO3hjSyC9G7ioY8KIA9VIPhgZ+RC9IgV6iL44C8h/rlMq2CwFgVg0GYhplK2Ib3OXs+k9JaVIE/1Rd2caevq/eR+LATbfbJ0d8ohlTYpU+QYt9DhKjOn0ZX8drgJnjME3HT7hurO5eB1GdrrYTKTqFGkDPGCOZQrlyc3sDH+vhDcLAXp+x9GV5rRBLhwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZcR4dUcD6J347eGsVgkuyDL1iQAfAF2Ox6DbbTIF58=;
 b=vyQD9VBoBW+BYAvgEKn2CDz68nxPf/aJwTNanz9LJkYwoEyrI7AnYaEPRXE5vfBPIYLwHUP0711W0DmQzh/5ePEHNXEvg7VXXYbdyH/EjmMp8pSn/VojNr4lytoIDp/M07X86oc/M4isxn6kgd/AgUKdfwC8OR57jaK8TXq4bMVv8gI51/elc4htQdNGCRrSh8/7/eIF1o9YVq9ChQiE4um6wHDhIr/kqT1wjHz0sFtja9txRuyFk0fSq+YOvkSmjyMHWjOZW8IaLv2Dhg6zfeKcZTE6eYhXlovKLjJ0G4cJF+tiMZQy2updUd5vGAUbbktAaxrD6d0RHh2KxMQYrQ==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by CY5PR02MB8920.namprd02.prod.outlook.com (2603:10b6:930:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 02:45:47 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 02:45:46 +0000
From: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "irogers@google.com"
	<irogers@google.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "james.clark@linaro.org" <james.clark@linaro.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built with
 -O0
Thread-Topic: [PATCH] perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built
 with -O0
Thread-Index: AQHa58iFg0Q+913iDEurf7AueZctN7IZw9OAgB81zYCAAMMogIAAygcA
Date: Tue, 27 Aug 2024 02:45:46 +0000
Message-ID: <CB550CF8-B45D-44D8-BDFC-3633DD99AFB0@nutanix.com>
References: <20240806061749.143072-1-eiichi.tsukata@nutanix.com>
 <4D19AE26-E1B4-44B6-A8C7-639EF2B69317@nutanix.com>
 <C00F1D39-9A12-4D1C-85BD-48A6D7C0290B@nutanix.com> <ZsyUVWXtzBmm-U_q@x1>
In-Reply-To: <ZsyUVWXtzBmm-U_q@x1>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|CY5PR02MB8920:EE_
x-ms-office365-filtering-correlation-id: 81748160-c1e1-426e-0291-08dcc6425a7b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzlwVGJVdm1INWRZRU1IVFRBRjhVaHhmSGFyVFpRNklSU2tqbXFiVXp0ZHZB?=
 =?utf-8?B?dW5WUVhwU0RDSHM0ZWdLYk4zN2UyN1dQU09pcktLM0pRaC9vNzNJMDlqdEh1?=
 =?utf-8?B?NXZtL0pUL3IvbElNZE1PbE93M3FWWHpZYlpXOXpLQ0pJdGlLdWZLQkJqcE9a?=
 =?utf-8?B?UWFpcm4yaTI3bWhmWEV0TUcwNjg5QnJPcnZGb1V1Ukovb0FkbkNkUWc3UVlo?=
 =?utf-8?B?T3Z4dzJhcEJVL2hjNmEzcDl3M29xOStJMnord2hsK2ZvWVhlNC9Wc2Nya0ZE?=
 =?utf-8?B?aDc4YmJoUnpCUWRnREs5RFpjMXg2aWs4L1ppeDZXMzhCUG5iUWxmUjczK2Zr?=
 =?utf-8?B?eWVNSGFXcHZEeFlyRlNTb2dhYTN1QlZaRTM1SkRLd0h6ZDBjSXJKR1YwNzVs?=
 =?utf-8?B?TjBTU0NGcmQySjFxSm1BeGFaeUpzZUJ1WjVybVJEdDd2WURJQ056c05WVEpx?=
 =?utf-8?B?UEhrbjBkdzV2UTQ5dEJ6bkJrMUVKRXVDU2Y5dHZBcjZDYjBhYzMweFRnbTZU?=
 =?utf-8?B?MzZWcGFWWHA0Rm9uQTdHT3N0QVRGUDRHNVpxOXdSSTFkL1NwRm1TL0tUM0NU?=
 =?utf-8?B?MVRxZWtsd3ZodDV6MEVrK2YvZVJkK2ErYkp6M3oxY1VBaHF2cjlCM25DeTlQ?=
 =?utf-8?B?eXdSaVFjK00wUVdlWkloQklyK3VCcDBMVWlEcGUvOTk1dzlCMi92Nk1wWjB2?=
 =?utf-8?B?QXZqeDNOVWwvSHZGTnVMcTRDa2xPTmI2TTFxSDdoMHI5dWJHKzNWdzBUY3Bp?=
 =?utf-8?B?Z3lJNzNHTE0rc0lIaE45Vjd1UXNjR0NyZzdZSkZETXZId0hPaVNtcE5zSDY0?=
 =?utf-8?B?c0V6MCtSVVVwUXpsbU1CZjk4SHhnaElhZndUZ3pSRkljNEUzMTJtRmxRazBp?=
 =?utf-8?B?ZC80eUJFVzV2RHJCdjNwL0dpVWc2cGo0WUhLOFdmdkx2VDZLL09TT0lGUDJS?=
 =?utf-8?B?WVBpOWJ2Z0c0QnA0NGxoNy8rZlNRMG1kVWZZWjcxeWFQVjEyc1NmY0o1NFFT?=
 =?utf-8?B?b1lPYTYwNlI4Ukc3bXJVMzJWYnhoQkN3ZFl4R3lia2t5WHkwUWVaUW9rb2Fv?=
 =?utf-8?B?S3N4SjZYTnI4SnRqaUpUK3Y4dUZnSjRSM28zZS9NNXp2czR1OUZTTHJkU3kz?=
 =?utf-8?B?bzVPZHBRU3VvcUJQZmZ5azFXNXFDb0dpd014c2VxTkNYNHlLRlFEbS8xbWVi?=
 =?utf-8?B?S1FqcFZkNTIrcnUxWDgzSHVHb3JQRVdDYlBjQWFKTEc5TVVoVzYxZHpLNlNU?=
 =?utf-8?B?bFIxRGh0V1Vra0ZMK041R3BXbzN2blpMN1JnenZ2Mm5xeitVdWtsdWhCWUI5?=
 =?utf-8?B?MFY0NmFxR3FFWGI4ZzJTUFBqMFJGa21Ycm1mcnkyQW1ZZkJFbm1uZEtsbjZ6?=
 =?utf-8?B?b2VQaFRZVVliRFJ0TzBsZXU0bC92Y0xrbTQ5eW5UUm1IZzhsSURZdmlkN3ZV?=
 =?utf-8?B?dzljYjFZUUtFcnF0S2grekNXdkgxWmc5MXgzTm1zYm1LRUhIaFVqYTBXcmxa?=
 =?utf-8?B?c1FJVDJSUkd4YTMvVDV3QjJMalArVkF3b2x4OEJWQ1dGblhIdlZNYTNBUnFK?=
 =?utf-8?B?cXgwWERvN1lGdTlHRWs1MXBPLzNWRWJ3YkJxM2tMckU2WTFrVzdZSWtEeGZp?=
 =?utf-8?B?SWVHdEtNMzNKQXVEU2hMTGRMNVphRE5yNGd2bHc3NnBDU0RLVFpnblFNVzNR?=
 =?utf-8?B?YWpkQk5hOENiNU1uTi9LNzVRdTFHNU9EdzdOeWw4SkkrWTFhK0d1QnMxemhr?=
 =?utf-8?B?alRPNkNLV2xobkFwVEM1cVlsL3lEcnpndCtkdmpVUkZWeWdHb2pvUnBNNEZP?=
 =?utf-8?Q?eUD3PmSkDcAwuEoi9taBIboY/R/UK2ICOVFZ8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkVQeXdmS0xMU2dvNWtzWlpJQ0VHak1ZS2JmQ21vMCtydmxpMkFxaEJpNk9a?=
 =?utf-8?B?aWdkZHhjLzZkTlhxRFZFNWpKbGtlNm5TdDc2NW1CM2F5NTVubzliT0hQVTdT?=
 =?utf-8?B?T0RuMm9ZK0gwd1lKL1FtNFpZVC95NHV2SXlETTlVZXh2L0w4UkR1aXpEYWh5?=
 =?utf-8?B?NlhMSkgza21YdURGK2o4RVZzS1J1TnNlaG9FME43NXRwK05yYW9zTHVwZTJp?=
 =?utf-8?B?anRjc1dBYjFJbUdmb25kcjZqbHFjRDFoTzdQcDZPWW12N0ozNDZiYVdXWVJO?=
 =?utf-8?B?OXVRcWdIRDltY1pLMXlIWUtVRkg0VWxQay8wWDBreTZ4am1ieFdPdDdlc3FP?=
 =?utf-8?B?cGhRb2hTazBZRndLMGZnWDUxNXVkN3VUNUhqYnFiektOVXEyQkpGTktrNXI1?=
 =?utf-8?B?cDdnN1h6NEN2R2NoWFlRSGZpYzNpRmx6OGcwYTBya0ZiOTdjdGdNK28xb2NY?=
 =?utf-8?B?UGFieitYN0c1TERzaWw0UnZiNGhGajlKeSs2U0dBWEI5Mk9wU09ZWW9iZGo3?=
 =?utf-8?B?eDFicGFsRnp4M3prRkIrRmhaSTlmK1dTK2pQektvdFIwV3ZQeDRNV3JWS0N3?=
 =?utf-8?B?c051dFVZczV6RW9uQjQvU05UUVJxKzZGOVV1eFRWY0tnenZJZGc4MnRPMGlN?=
 =?utf-8?B?bGV4N09SQjhUR2M1UzBNa0ZwVGY1ZGpTWXp5ajd3bTNSb2ljU0JQdzdiV2hj?=
 =?utf-8?B?TC9PaTdKTldyejNWcmJQeTB2ZnhGdmRoMnd1MmtOUUlaSXpWdkh1NHhLSUZZ?=
 =?utf-8?B?ekhOTVJpbm9Pb2twVXBCaXpFZDI0bTVyNUlLckhKQVVkMVVGbzhGVkZaU0hC?=
 =?utf-8?B?T0JLaW5qNFpmZUIxS3FTOFplRUlRK2ZCVEVwMUtZZ3RqdFcrL2hJS216VmY1?=
 =?utf-8?B?U1JGTnZsN0kxbG1Wc3VpSnMrVThnemtCZ011S1lITGJNNmNlRjFHMWh2NWdW?=
 =?utf-8?B?ODNoRjJJRzBHZFNQdmM4NkFuVXBXU0VWKzJSWmpNdWVHMytFaEhvUU13TWtv?=
 =?utf-8?B?MDFOWUpJelNGV09xV2tESTFXb2I4dzZlTWVXRnZmQzhhWjdMYTRBZ3h5ejFP?=
 =?utf-8?B?L1NXeitjMXdwcmFHVTVaTEp4V1k2Z0ZDY0J6dVF0azlCME5TclpWaDhlUWQv?=
 =?utf-8?B?dGdUakxjOXVDWWc5RjBKTjFsdjRYOVJqUW1XODAzM1hvdUY2SUYyZ3ZiTzFB?=
 =?utf-8?B?SXdjbU5pY25vVWpVQlRrRjRIQ0QyZ09lZkd1Snd2ZGJHR3Q2N05XaTJvTUpF?=
 =?utf-8?B?ZVYwT0Z1ZmxHZE1kUktJTk5KcHNrT3JNODRSNVBUNkZOSUpaZEpmTXg4RHpw?=
 =?utf-8?B?WFhBYjVEeERON2tDWG44OTkxbjVQZXdLR1V3bVlWaENDLzl3ak5vNHlLaEtW?=
 =?utf-8?B?WVJqeHFwMTZmbkpQR1ZkbzUxZXlabTlSc29SQ1hnUnZHVFlweW1UcnFkeGEy?=
 =?utf-8?B?VVYvbFVOdTB6ZGwxKzFTNUp6WDZkWmpJdmtRVHRwdGZxQkZSUks0dzNDWWZT?=
 =?utf-8?B?aWNzVVR1SmhsbTlKV3RFUGxGaXQrK3oyUnk3ZzJvdnBZckVaQitHWUwzMVI2?=
 =?utf-8?B?bkZPN0VnK1U5WnhqeksvTXp2cmo5a2V5c0phajJzeUx1QTRqMisvREtnMllW?=
 =?utf-8?B?RU9nWDZFWTlzcENubXlzenVmLzNYMEpsakFTWU5ycVAvcERNK09adWduUklI?=
 =?utf-8?B?ODlCTG5YQXlEVWxkenIxanJIbDRDaE1wekFrMmphWEoyVGptQTYyYjlNMm95?=
 =?utf-8?B?V2xFWE1wRTVGdWlXUVFnNzFrRTFTV0U0MDA5VjlKaHlhUXJLRVVmd3NLV2lD?=
 =?utf-8?B?RUwwMkRNZ3ZVT0tvREJMcDEwS2VxaTVDbnRrMGY3MzdlUmYvc3RQK3RBSXNI?=
 =?utf-8?B?YWl5cTFMdTcrZTI3OEdqZDlTWmRVbjhWbDd2VjhDdi84dytnKzBHellURlpo?=
 =?utf-8?B?QloxR0g5bUtIaDZvTm0wc1dEdVgySWpwRFpvanJodlZyMkh4WGZBaDl2ekRo?=
 =?utf-8?B?UWhkMzJwYWJZYkY2bFFpSlVtbVNOd1AyY1JneFQxa2k1Sk8rVVBpam5NQktt?=
 =?utf-8?B?N0tYZkVTZjRjQzJXOXBTU21TZndPMXk0aEU2RDdXQ0ZXYzB2M05Ja0Y3cXJ6?=
 =?utf-8?B?RTYwZE5uL0lCUDhVVm80Q3Rpai8yb0pERUFuUmtRa0hScHV0QzhoTStyUmJv?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE83A8C9BCC50C4D8E74CC70B770067F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81748160-c1e1-426e-0291-08dcc6425a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 02:45:46.7546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoJgRpG6hVk3rdOudRrxf2Wf5a0QNmsQMLXVWoQqli5RyoZZrz04F9ClmrcF57X6tGEBI6nuVrFcXw0/uCBR48DQlzihqRFjshSWBFwb34I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8920
X-Proofpoint-ORIG-GUID: DXu8TKEkj-gIT6ncIl4MYNgEDdSbyrMk
X-Authority-Analysis: v=2.4 cv=TK4XSEla c=1 sm=1 tr=0 ts=66cd3de0 cx=c_pps a=O5U4z+bWMBJw47+h9fOlNw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=0034W8JfsZAA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8
 a=20KFwNOVAAAA:8 a=vTr9H3xdAAAA:8 a=tBumzC45FfrXMkWmbVMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=14NRyaPF5x3gF6G45PvQ:22 a=7PCjnrUJ-F5voXmZD6jJ:22
X-Proofpoint-GUID: DXu8TKEkj-gIT6ncIl4MYNgEDdSbyrMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_01,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXVnIDI2LCAyMDI0LCBhdCAyMzo0MiwgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxv
IDxhY21lQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBBdWcgMjYsIDIwMjQgYXQg
MDM6MDQ6MTJBTSArMDAwMCwgRWlpY2hpIFRzdWthdGEgd3JvdGU6DQo+PiBQaW5nDQo+IA0KPiBU
cmllZCwgZGlkbid0IHdvcmssIGNhbiB5b3UgcGxlYXNlIGNoZWNrIG9uIHRoZSB0bXAucGVyZi10
b29scy1uZXh0Pw0KPiANCg0KSXQgZmFpbGVkIGJlY2F1c2UgInBlcmYtdGVzdC15ICs9IGxhbmRs
b2NrLm/igJ0gbGluZSB3YXMgYWRkZWQgcmVjZW50bHkuDQpJ4oCZbGwgcmViYXNlIHRoZSBwYXRj
aCBvbiB0bXAucGVyZi10b29scy1uZXh0IGluIHYyLg0KDQpUaGFua3MNCkVpaWNoaQ0KDQoNCj4g
4qyiW2FjbWVAdG9vbGJveCBwZXJmLXRvb2xzLW5leHRdJCBiNCBhbSAtY3RzbCAtLWNjLXRyYWls
ZXJzIDIwMjQwODA2MDYxNzQ5LjE0MzA3Mi0xLWVpaWNoaS50c3VrYXRhQG51dGFuaXguY29tDQo+
IEdyYWJiaW5nIHRocmVhZCBmcm9tIGxvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA4MDYwNjE3NDku
MTQzMDcyLTEtZWlpY2hpLnRzdWthdGFAbnV0YW5peC5jb20vdC5tYm94Lmd6DQo+IEFuYWx5emlu
ZyAzIG1lc3NhZ2VzIGluIHRoZSB0aHJlYWQNCj4gTG9va2luZyBmb3IgYWRkaXRpb25hbCBjb2Rl
LXJldmlldyB0cmFpbGVycyBvbiBsb3JlLmtlcm5lbC5vcmcNCj4gQ2hlY2tpbmcgYXR0ZXN0YXRp
b24gb24gYWxsIG1lc3NhZ2VzLCBtYXkgdGFrZSBhIG1vbWVudC4uLg0KPiAtLS0NCj4gIOKckyBb
UEFUQ0hdIHBlcmYgdGVzdDogVXNlIC1XcCwtVV9GT1JUSUZZX1NPVVJDRSBmb3IgdGVzdHMgYnVp
bHQgd2l0aCAtTzANCj4gICAgKyBMaW5rOiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5j
b20vdjIvdXJsP3U9aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19yXzIwMjQwODA2MDYxNzQ5LjE0
MzA3Mi0yRDEtMkRlaWljaGkudHN1a2F0YS00MG51dGFuaXguY29tJmQ9RHdJRGFRJmM9czg4M0dw
VUNPQ2hLT0hpb2NZdEdjZyZyPWR5MDFEcjRMeThtaHZuVWR4MXBaaGhUMWJrcTRoOXo1YVZXdTNw
YW9adGsmbT1fME9PYlpzbXg2RmpqdWVIWmFmUGpKajhnS3piQnNGY19EZS16OVYtTmxEcUJkUDJK
WGtWSGV5NFpudmJDNWV0JnM9UncydmUtNFY4eVNDeXk3Qjk5UDZmYzFiaUxBZUZrY2pwY0IyU2pU
QUFjOCZlPSANCj4gICAgKyBTaWduZWQtb2ZmLWJ5OiBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8g
PGFjbWVAcmVkaGF0LmNvbT4NCj4gIC0tLQ0KPiAg4pyTIFNpZ25lZDogREtJTS9udXRhbml4LmNv
bQ0KPiAtLS0NCj4gVG90YWwgcGF0Y2hlczogMQ0KPiAtLS0NCj4gTGluazogaHR0cHM6Ly91cmxk
ZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdf
cl8yMDI0MDgwNjA2MTc0OS4xNDMwNzItMkQxLTJEZWlpY2hpLnRzdWthdGEtNDBudXRhbml4LmNv
bSZkPUR3SURhUSZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1keTAxRHI0THk4bWh2blVkeDFw
WmhoVDFia3E0aDl6NWFWV3UzcGFvWnRrJm09XzBPT2Jac214NkZqanVlSFphZlBqSmo4Z0t6YkJz
RmNfRGUtejlWLU5sRHFCZFAySlhrVkhleTRabnZiQzVldCZzPVJ3MnZlLTRWOHlTQ3l5N0I5OVA2
ZmMxYmlMQWVGa2NqcGNCMlNqVEFBYzgmZT0gDQo+IEJhc2U6IG5vdCBzcGVjaWZpZWQNCj4gICAg
ICAgZ2l0IGFtIC4vMjAyNDA4MDZfZWlpY2hpX3RzdWthdGFfcGVyZl90ZXN0X3VzZV93cF91X2Zv
cnRpZnlfc291cmNlX2Zvcl90ZXN0c19idWlsdF93aXRoX28wLm1ieA0KPiDirKJbYWNtZUB0b29s
Ym94IHBlcmYtdG9vbHMtbmV4dF0kICAgICAgICBnaXQgYW0gLi8yMDI0MDgwNl9laWljaGlfdHN1
a2F0YV9wZXJmX3Rlc3RfdXNlX3dwX3VfZm9ydGlmeV9zb3VyY2VfZm9yX3Rlc3RzX2J1aWx0X3dp
dGhfbzAubWJ4DQo+IEFwcGx5aW5nOiBwZXJmIHRlc3Q6IFVzZSAtV3AsLVVfRk9SVElGWV9TT1VS
Q0UgZm9yIHRlc3RzIGJ1aWx0IHdpdGggLU8wDQo+IGVycm9yOiBwYXRjaCBmYWlsZWQ6IHRvb2xz
L3BlcmYvdGVzdHMvd29ya2xvYWRzL0J1aWxkOjcNCj4gZXJyb3I6IHRvb2xzL3BlcmYvdGVzdHMv
d29ya2xvYWRzL0J1aWxkOiBwYXRjaCBkb2VzIG5vdCBhcHBseQ0KPiBQYXRjaCBmYWlsZWQgYXQg
MDAwMSBwZXJmIHRlc3Q6IFVzZSAtV3AsLVVfRk9SVElGWV9TT1VSQ0UgZm9yIHRlc3RzIGJ1aWx0
IHdpdGggLU8wDQo+IGhpbnQ6IFVzZSAnZ2l0IGFtIC0tc2hvdy1jdXJyZW50LXBhdGNoPWRpZmYn
IHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoDQo+IGhpbnQ6IFdoZW4geW91IGhhdmUgcmVzb2x2ZWQg
dGhpcyBwcm9ibGVtLCBydW4gImdpdCBhbSAtLWNvbnRpbnVlIi4NCj4gaGludDogSWYgeW91IHBy
ZWZlciB0byBza2lwIHRoaXMgcGF0Y2gsIHJ1biAiZ2l0IGFtIC0tc2tpcCIgaW5zdGVhZC4NCj4g
aGludDogVG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgYnJhbmNoIGFuZCBzdG9wIHBhdGNoaW5nLCBy
dW4gImdpdCBhbSAtLWFib3J0Ii4NCj4gaGludDogRGlzYWJsZSB0aGlzIG1lc3NhZ2Ugd2l0aCAi
Z2l0IGNvbmZpZyBhZHZpY2UubWVyZ2VDb25mbGljdCBmYWxzZSINCj4g4qyiW2FjbWVAdG9vbGJv
eCBwZXJmLXRvb2xzLW5leHRdJCBnaXQgYW0gLS1hYm9ydA0KPiDirKJbYWNtZUB0b29sYm94IHBl
cmYtdG9vbHMtbmV4dF0kDQo+IA0KPj4+IE9uIEF1ZyA2LCAyMDI0LCBhdCAxNToyNywgRWlpY2hp
IFRzdWthdGEgPGVpaWNoaS50c3VrYXRhQG51dGFuaXguY29tPiB3cm90ZToNCj4+PiANCj4+PiBI
aSwNCj4+PiANCj4+PiBGWUk6IEZlZG9yYSB1c2VzIOKAnFJQTV9PUFRfRkxBR1PigJ0gIGFzIOKA
nEVYVFJBX0NGTEFHU+KAnSB0byBidWlsZCBwZXJmLg0KPj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5w
cm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fc3JjLmZlZG9yYXByb2plY3Qub3JnX3Jw
bXNfa2VybmVsX2Jsb2JfcmF3aGlkZV9mX2tlcm5lbC5zcGVjLTIzLTVGMjkwOCZkPUR3SURhUSZj
PXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1keTAxRHI0THk4bWh2blVkeDFwWmhoVDFia3E0aDl6
NWFWV3UzcGFvWnRrJm09XzBPT2Jac214NkZqanVlSFphZlBqSmo4Z0t6YkJzRmNfRGUtejlWLU5s
RHFCZFAySlhrVkhleTRabnZiQzVldCZzPTlFS0Vnb2JrNGxhbUxHekZYOUcwaGZTakptcXZtVTFj
T2VvSlVHVlhuX2cmZT0gDQo+Pj4gDQo+Pj4gQW5kIG9uIEZlZG9yYTQwLCAgaXQgaGFzIOKAnC1X
cCwtRF9GT1JUSUZZX1NPVVJDRT0z4oCdLg0KPj4+IA0KPj4+IFtlaWljaGlAdDQ5NSB+XSQgcnBt
IC0tc2hvd3JjIHwgZ3JlcCBSUE1fT1BUIHwgaGVhZCAtbiAxDQo+Pj4gUlBNX09QVF9GTEFHUz0i
JXtvcHRmbGFnc30iDQo+Pj4gW2VpaWNoaUB0NDk1IH5dJCBycG0gLS1ldmFsICcle29wdGZsYWdz
fScNCj4+PiAtTzIgLWZsdG89YXV0byAtZmZhdC1sdG8tb2JqZWN0cyAtZmV4Y2VwdGlvbnMgLWcg
LWdyZWNvcmQtZ2NjLXN3aXRjaGVzIC1waXBlIC1XYWxsIC1Xbm8tY29tcGxhaW4td3JvbmctbGFu
ZyAtV2Vycm9yPWZvcm1hdC1zZWN1cml0eSAtV3AsLVVfRk9SVElGWV9TT1VSQ0UsLURfRk9SVElG
WV9TT1VSQ0U9MyAtV3AsLURfR0xJQkNYWF9BU1NFUlRJT05TIC1zcGVjcz0vdXNyL2xpYi9ycG0v
cmVkaGF0L3JlZGhhdC1oYXJkZW5lZC1jYzEgLWZzdGFjay1wcm90ZWN0b3Itc3Ryb25nIC1zcGVj
cz0vdXNyL2xpYi9ycG0vcmVkaGF0L3JlZGhhdC1hbm5vYmluLWNjMSAgLW02NCAtbWFyY2g9eDg2
LTY0IC1tdHVuZT1nZW5lcmljIC1mYXN5bmNocm9ub3VzLXVud2luZC10YWJsZXMgLWZzdGFjay1j
bGFzaC1wcm90ZWN0aW9uIC1mY2YtcHJvdGVjdGlvbiAtZm5vLW9taXQtZnJhbWUtcG9pbnRlciAt
bW9uLW9taXQtbGVhZi1mcmFtZS1wb2ludGVyDQo+Pj4gDQo+Pj4gQmVzdCwNCj4+PiBFaWljaGkN
Cj4+PiANCj4+Pj4gT24gQXVnIDYsIDIwMjQsIGF0IDE1OjE3LCBFaWljaGkgVHN1a2F0YSA8ZWlp
Y2hpLnRzdWthdGFAbnV0YW5peC5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gSWYgRVhUUkFfQ0ZM
QUdTIGhhcyAiLVdwLC1EX0ZPUlRJRllfU09VUkNFPTIiLCB0aGUgYnVpbGQgZmFpbHMgd2l0aDoN
Cj4+Pj4gDQo+Pj4+IGVycm9yOiAjd2FybmluZyBfRk9SVElGWV9TT1VSQ0UgcmVxdWlyZXMgY29t
cGlsaW5nIHdpdGggb3B0aW1pemF0aW9uICgtTykgWy1XZXJyb3I9Y3BwXQ0KPj4+PiANCj4+Pj4g
VXNlICItV3AsLVVfRk9SVElGWV9TT1VSQ0UiIGluc3RlYWQgb2YgIi1VX0ZPUlRJRllfU09VUkNF
IiBmb3IgdGVzdHMNCj4+Pj4gYnVpbHQgd2l0aCAtTzAuDQo+Pj4+IA0KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBFaWljaGkgVHN1a2F0YSA8ZWlpY2hpLnRzdWthdGFAbnV0YW5peC5jb20+DQo+Pj4+IC0t
LQ0KPj4+PiB0b29scy9wZXJmL3Rlc3RzL3dvcmtsb2Fkcy9CdWlsZCB8IDggKysrKy0tLS0NCj4+
Pj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4g
DQo+Pj4+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3Rlc3RzL3dvcmtsb2Fkcy9CdWlsZCBiL3Rv
b2xzL3BlcmYvdGVzdHMvd29ya2xvYWRzL0J1aWxkDQo+Pj4+IGluZGV4IDQ4YmYwZDNiMGYzZC4u
ZWMzNmMyMWUzNzVlIDEwMDY0NA0KPj4+PiAtLS0gYS90b29scy9wZXJmL3Rlc3RzL3dvcmtsb2Fk
cy9CdWlsZA0KPj4+PiArKysgYi90b29scy9wZXJmL3Rlc3RzL3dvcmtsb2Fkcy9CdWlsZA0KPj4+
PiBAQCAtNyw3ICs3LDcgQEAgcGVyZi10ZXN0LXkgKz0gc3FydGxvb3Aubw0KPj4+PiBwZXJmLXRl
c3QteSArPSBicnN0YWNrLm8NCj4+Pj4gcGVyZi10ZXN0LXkgKz0gZGF0YXN5bS5vDQo+Pj4+IA0K
Pj4+PiAtQ0ZMQUdTX3NxcnRsb29wLm8gICAgICAgICA9IC1nIC1PMCAtZm5vLWlubGluZSAtVV9G
T1JUSUZZX1NPVVJDRQ0KPj4+PiAtQ0ZMQUdTX2xlYWZsb29wLm8gICAgICAgICA9IC1nIC1PMCAt
Zm5vLWlubGluZSAtZm5vLW9taXQtZnJhbWUtcG9pbnRlciAtVV9GT1JUSUZZX1NPVVJDRQ0KPj4+
PiAtQ0ZMQUdTX2Jyc3RhY2subyAgICAgICAgICA9IC1nIC1PMCAtZm5vLWlubGluZSAtVV9GT1JU
SUZZX1NPVVJDRQ0KPj4+PiAtQ0ZMQUdTX2RhdGFzeW0ubyAgICAgICAgICA9IC1nIC1PMCAtZm5v
LWlubGluZSAtVV9GT1JUSUZZX1NPVVJDRQ0KPj4+PiArQ0ZMQUdTX3NxcnRsb29wLm8gICAgICAg
ICA9IC1nIC1PMCAtZm5vLWlubGluZSAtV3AsLVVfRk9SVElGWV9TT1VSQ0UNCj4+Pj4gK0NGTEFH
U19sZWFmbG9vcC5vICAgICAgICAgPSAtZyAtTzAgLWZuby1pbmxpbmUgLWZuby1vbWl0LWZyYW1l
LXBvaW50ZXIgLVdwLC1VX0ZPUlRJRllfU09VUkNFDQo+Pj4+ICtDRkxBR1NfYnJzdGFjay5vICAg
ICAgICAgID0gLWcgLU8wIC1mbm8taW5saW5lIC1XcCwtVV9GT1JUSUZZX1NPVVJDRQ0KPj4+PiAr
Q0ZMQUdTX2RhdGFzeW0ubyAgICAgICAgICA9IC1nIC1PMCAtZm5vLWlubGluZSAtV3AsLVVfRk9S
VElGWV9TT1VSQ0UNCj4+Pj4gLS0gDQo+Pj4+IDIuNDUuMg0KPj4+PiANCj4+PiANCj4+IA0KDQo=
