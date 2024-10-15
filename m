Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96C21E3DB;
	Tue, 15 Oct 2024 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034459; cv=fail; b=F+pavoyzNF7C5TazWpcI7MmyYLUhy2vN+72tvFgOE0HxLQBN3JceNd1FtJGdJujF9RD54x6FBnhfLsqCZ0+R+gHfZnt0vcN0nPVI5Y/GteBdyIeGGzz/GNbfIg/vOAcd0Vs21dW4cx/OzzE0qVI5stbmIlqHrmDYchoxpA5/oY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034459; c=relaxed/simple;
	bh=SpaBJM/OtphyINrBZA7k4CCVjMZNZ3EZ4Ub6PnY6Bwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kjGdyV4rnsbbjZG6dISQT8S7Kjum04ggsciRcYKbmTYTc0SkyYvaihupzbNv/K8aZqQRI4hnOJh5mS4HwfSmEGy8iojdTNxtt916Bv+Iwu4boBDuG0fisBDNL6sEon8I936oJi/TIv6KB28ArxTr0I6+Ra1+L+07SCXGZzRW91w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EMQmGe9o; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EMQmGe9o"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FLr6w9030470;
	Tue, 15 Oct 2024 16:20:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=SpaBJM/OtphyINrBZA7k4CCVjMZNZ3EZ4Ub6PnY6Bwc=; b=
	EMQmGe9o5QUFyY6m58uftMFDu1+tb8oUWfYENFEfwrS2oGYfsRyvDsi6VSwDAd0p
	ZpPXsztNaubjDf8pucrGWmXI5jV3AC/behPvzhx07UqyFNU8jCkawiKdljFc/gyP
	auUHTwYr4UA+VU5qXSJ4OF/wkYrH0hYsAnWehC7a7ZOXeeJQE1x9RwuBqUmpUl3l
	el9po6M/SBKPAxeMvFvw99liiYMiKYumJojvzFwOZ62KnnSNQmrbixDFeeMFwF6U
	v3uGiFPUsffMCJbnlrQJDh7kKgAJNh/BlIJWtQwKYulwfsTsJoGLlOANgiPwChQ5
	x10O1ZsehGbMkGaxAyJRBg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4291s3wbs4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c579WI26Pyyz6b5RHKZ+4NueWcE7yIoNNBGcorY98ZzNaysQFe6D8a66r0tHkZWj18UGDPnN/AikhROnVwS8ODM1+dSrIGa5XdMOikplgtTGXO6+/g33mFzTNJQtGOE/K+5tYrKsR3ogR4t3yrpRRBh+G6+Yb9VQiKJUY6vb4ONmswluhFtsNRftcuqvbffnTSGVNJKL2GL9g60CkdRf1/iNKsd+EeKGxBDn234e5MIO6BHJPGiUtljGszGet2vcEFBTDLFXS1saXGy6Oz9ngfgEyj8r2SeGBn9+Zkutv/rR7whyaJGtKki6ADlUW+4Oa03Mi8SEmXuL2xAzvV2wFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpaBJM/OtphyINrBZA7k4CCVjMZNZ3EZ4Ub6PnY6Bwc=;
 b=mV1OapAp4nVFlXf2j9nsMn3AHzdddX2KF1K0KMA8G8yYxuGkCPeOrvVTHq2mumck4Lps0AnOcbZiLjI5zeVburxZ9iRVM3KlEU316M3oKNhZAYT+PCmC9wLUStbmO7xNN3+Mz7Gfz3SGw8vY3jNHhRUHZcOoAZnt/3PS9HPKZJZx4yK4ZR598L/wOFGK0AWYEJErHPRWok4X7SjAwxiUpVPWRc9cPdtMj13ezEPz90+oke1UbGtQ0I2hptxVTddEffNH03iDQGPbuDL68LzeAoTUFfk23kc4dpK5jsNthzoUNZya3BBlFvcqwEs23MkaXgb4goArHXeNWJ8rnwQffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW4PR15MB4459.namprd15.prod.outlook.com (2603:10b6:303:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 23:20:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 23:20:52 +0000
From: Song Liu <songliubraving@meta.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC: Song Liu <songliubraving@meta.com>,
        Arnaldo Carvalho de Melo
	<acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Howard Chu
	<howardchu95@gmail.com>,
        Andrea Righi <andrea.righi@linux.dev>,
        Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland
	<mark.rutland@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan
 Liang <kan.liang@linux.intel.com>,
        linux-perf-use.
	<linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "james.clark@linaro.org" <james.clark@linaro.org>,
        Alan Maguire
	<alan.maguire@oracle.com>
Subject: Re: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature in
 clang 12
Thread-Topic: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature
 in clang 12
Thread-Index: AQHbHzliofByVWtRGEeIpmwTo98uyrKIOuIAgAAK0ACAABC/AIAAF38AgAAFUIA=
Date: Tue, 15 Oct 2024 23:20:52 +0000
Message-ID: <B0F77B6E-D6B4-4658-B0CC-F566A208848D@fb.com>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
 <Zw61TUe1V97dKWer@google.com> <Zw7D9HXBanPLUO4G@x1> <Zw7JgJc0LOwSpuvx@x1>
 <Zw7SkmEaz730uVbL@x1> <6FEB3225-9B3F-4ECE-AB68-AFF00F5E03E8@fb.com>
 <CA+JHD905Xtbb2OYqm3mGbh3C1dKOd-avnC=01=uJfTVEnmA1zQ@mail.gmail.com>
In-Reply-To:
 <CA+JHD905Xtbb2OYqm3mGbh3C1dKOd-avnC=01=uJfTVEnmA1zQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW4PR15MB4459:EE_
x-ms-office365-filtering-correlation-id: b8a7ad63-a025-4c76-352d-08dced700308
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFBBVWNjcjRwQ0JIempCL3NVSVNVdU5URWtCb1V0eEplTThhQjRuTzFDaXpo?=
 =?utf-8?B?QW02L2VNVnJNOUZkUXp6Q2hTNW9TUUU3aldQLzN6RVpDaW9NTGRkb29WNmk4?=
 =?utf-8?B?TjNGM0JleThwN2Ywb1U1YllOZUZoeHpnMFA5TnVUZnhRZlJHMU1oQnc0VFdD?=
 =?utf-8?B?bW9MV1lLbUJCR2xEZ2c3MW9aYXUvbFdiWFZrNE9GNkdhRFAyZkxNUU91Tjdl?=
 =?utf-8?B?b3M3dTRrSWEyTlI0YUZlaDVHT2dIYW9mQnlsT0x5cHhOOXZBUXRIQkRZMFNu?=
 =?utf-8?B?UG52Z2ZzR01RdE5rT3BrSzA0dVNhR21scklFblM1Z1RrQkUxUFdvVXUwZlA4?=
 =?utf-8?B?ekcwSklKUGlQZVlvQ2lIcVV6L3VjMFk2T1dpMXQ5TGYvVDRtVkozVlNrU3VF?=
 =?utf-8?B?RnZ6SndxVlgyUFNpQnF4LzNmeisvUGRxbjdQaXJHMUk4RUk3TUtPQmxHU0VM?=
 =?utf-8?B?eEY1WTgrcGQ4ZGZ1cklVVVplMmJ1MThJLzhRSzhTRlViSlBMblBtTEtMbWk1?=
 =?utf-8?B?QnhQcHRYU1o0aWQ3ZkZnNFVFaDF5Uis2UCs3V2poUUFvVVN6VldLSjZ5c1ha?=
 =?utf-8?B?NVdIV3p2K3V6d2JmdnIrUkVYTEdkenZQenNYdWxVdzVvcXkrVTZ3SXRPZXNE?=
 =?utf-8?B?MldBLzZuL1A4cE5YbTBTc0JCYnhUR3lCZ0g5ajlubXhiN2JlWUEwWjdIQVAz?=
 =?utf-8?B?YU4vTE14Wnh2Ty9HQ0ZHOTZQb2ZuT1hJdkNDUUdhT1NiQ3paZmNSUWIvWVFp?=
 =?utf-8?B?dUFnNzBadllTaDMrYkY1NnE3cHNnd3p5RVlINzBDeW1sKzBkTUxFS1RMeGpa?=
 =?utf-8?B?ejJFT0hENDNqTXdsby9xQnhBWDA0Uy8rSmxOKzZ2ZlIzS0xjb0xUelk0eHRz?=
 =?utf-8?B?N2VHbU1XdzYxeTVrYmk4T1VDU1QxRUNNTkZrS3dCb0xweS9oYmp6cXVTQ20y?=
 =?utf-8?B?UnI2TG9IYWpOcmRoNEJreDZUamxUT3VBMTliZTQzSlhpcmp1a1A4dWpWaFd0?=
 =?utf-8?B?ZDRtNUlod3RrSGY3K0lPdlpBT0xJR0FOTS9pTzBDc2lHa2ttdWdEcStzZXVT?=
 =?utf-8?B?bER0UXpOM1dGeENONllDd0dUNEVQNnQ0OWRmQ21mZmEvclNiSHp5Mm5CMXNk?=
 =?utf-8?B?akdJbHAxaWZPVSsrZms4dHRINUJCWnBZK1R4aXNZNUJML1R5aFA1N0F6U3Ji?=
 =?utf-8?B?R2R3UXovUTFNYThXeDA3cHM0b0pLOEdKbzFnQzFLVEJrZTc0T2dLNkRvM1dI?=
 =?utf-8?B?ZTJTRFFDWmtNMXlRR09iYTVPalBnbFBnU0dnUVRFUzNYazJ2RzBYY3RiMU0y?=
 =?utf-8?B?R2ZaUmNNVFpzRGk3TTNjNkIxRGxzcU1Fei9ZTGlVMm1VY01RRDB0NFEvVVBX?=
 =?utf-8?B?aktodzRpeFpRejR5MUw5dmVWblNDbzkyK3VqRDdWaTBXUFBFMGZIWTFIRlAy?=
 =?utf-8?B?eXRrTGFNeUxjQmVlUzdtdnFyTytJRGU1K0I3ZHM0ZVZjbE10ZytzbFQ2Mk90?=
 =?utf-8?B?YTVVQTRVQXhuSXJOcHhwZWxxRlYxUDdCOHExa2FibHBOc3N2MjZ3WXVpenlJ?=
 =?utf-8?B?QTVyRVIxYyttWWRGMDRFYlR1MjFsWGFCY3E5NityQTl0SytaMU80Uk9OQzdn?=
 =?utf-8?B?RFJYUnBPYllSSHJyL1RMdHJrYm4ybWgvMWFSSk5odjRqZktidGIzZkdVbkpa?=
 =?utf-8?B?QVU3N2JmNjBMcDNueTRoaUFBS21oVEFaQnc5Q1VWdzltaG1ZNUR6SnVWSVNO?=
 =?utf-8?B?VFpycFpvelNaRnlwZUlLcXVBYmFPNUlSUEVVUjVuaTlvN3JKYWlUS1JUZ2Ey?=
 =?utf-8?B?MXVQaU0xZklNcXQvSit6QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UG1GWHZXNTd4ZGhFcmEzY0RZd2toWURyZUw0U1A3WGduNm9EaUhtWURaa1ZP?=
 =?utf-8?B?alpVbHhkYXVzMmlwb3VCUnFNb08zbHlScDdnNEZFSi9jN1dpMGZENlJwcUFl?=
 =?utf-8?B?K2d5YTgxdEJHY01aK2NRZWlDaDhpS1RVeDhHZC9xM1BOUjFPVDZhQmc3c1k3?=
 =?utf-8?B?NEZvYXo1Z2hnTE1LWlI0bmxKTXF5d1Q4RWhGMW5VRkI5dndZa2RmUXZCYjRJ?=
 =?utf-8?B?emx3YW84UTBhOVFTRGJsKzg2Vk9ZMW03a0xBTVVnZVFYc3daTnJXRWJzMkM3?=
 =?utf-8?B?VWtjd0laaUVjRzBVSmc0V0w2OG5Ec3pGWmQxN2ZyU1RuMVdiVEM2cU1PbVVh?=
 =?utf-8?B?WWlScEhvMzRjb1Q4aS9iM2dSSWRxbU5BaDZESXZFYVh0RVdpNGpwWlk0N0tW?=
 =?utf-8?B?V2JMbS9RY01ZRDV0anM2ZXo3bDFsdWJmMm1CQTRGSkdlQnlWVGwvR2xKbjhm?=
 =?utf-8?B?VUVXNmhhY2RKTFJtcStMdnlCZnVlSmJRYnlrMU9rWHZQajEwbldxU2FGZTJS?=
 =?utf-8?B?VEhGRTlZMis0ZzBEUGwvN2RTZUFHckNYU1gvTm5qMHRyTG14Zldtb0lYQ2RZ?=
 =?utf-8?B?THN1enRneVpJZ2JkblA3bTM1M1FxSGpTYjhlSUViUjhSQ3U4TlptWkNKSDhi?=
 =?utf-8?B?ZUJHUk1UUkxZZmFoclhtZ3BBNGppWUJQOURKRXorbHlpOU5mTzNWVU9XNkVZ?=
 =?utf-8?B?enNRMjNDREpJVy9vT25CeVF4YWh2cDFZTjFwcGdsaUhTdnFWczFyOVFmbmRh?=
 =?utf-8?B?QWowTlF1QzlFRzJ6U0VBdmpac3FHUUs0dWxra25jRHArWEQ5Vnk0M01XYUxO?=
 =?utf-8?B?ZFlVekNlUnVDWUdqU3U0YUZQaE14NzVMd2xESnM3b0pCalF3b3MrWStpRHZ1?=
 =?utf-8?B?eEk1SThXRk0xcUNrM3o4cE9hRUVRVXB3SDc3cjBVL2JuamxvYkZ0SnY4dHFu?=
 =?utf-8?B?RTkvaHBsMFB0bG14S2tyT0xLbFFDQkFtbmYrZjBWdHh3R3BiSG5GTStXSUtR?=
 =?utf-8?B?bkpiNTVLRk1FU3BKdkdIYjBmMTVIMDJ3ckpmSjgwNUtwVEltR3NNb080QitH?=
 =?utf-8?B?Tzc0a3JONmtFMU4xMUlJcDI4QVhSR29sL0gvSzByMlhpLyt0VjgwZmVWY2ox?=
 =?utf-8?B?dkNOeXM0MXlDak5hQ255MjNWYXluWHdvQUVzaVpmMCt4S0tZUkJRRU9JR0Jy?=
 =?utf-8?B?dlVuTlRBNlIva1IvVjJSVG04blJzRWZIS3BMd0U2c3NwdjRTOHhIOURwYWhm?=
 =?utf-8?B?SEgwZ05jN2g4ZDNPMDFCTE5leTdWU2prZ2I1MUlTcnBIeXJoTjZwdXNaUURV?=
 =?utf-8?B?bkNGWkdjb3F1Y0JPTGlVNUo0Y3hwaTA4akZmS081WlJSVndhcW94SXZnc3Zo?=
 =?utf-8?B?OGhnbVJhRHFTaHhOUzFKRGJVRmw5UjQ5eHFHdE9scDJvVkF2Wi9kZHFlZFVr?=
 =?utf-8?B?ZUpvSThuZ3dwRGhNR2pNZUZEaTFxTTViRmtDM1lCYmRsL0RVcjJDcWVwRmRs?=
 =?utf-8?B?bE1uRmJ3VTJMSVlQTmZQcUdPWk5HUkNXRkdIS0xJbG0waVZJQ29PRGwvOFZt?=
 =?utf-8?B?c0MzNitzSXEwak9ra043dmlMRkRQT0hUcnZEZEhackRaWTRwQ05TeXVpd0J5?=
 =?utf-8?B?NS93NEk1YnhUcGxja0E1a0E3bDUzVjM0ZW1FTHhpN2k0cTlOYTc4eWczZlkx?=
 =?utf-8?B?dFQ2enNkb09pZHNOYVR6SEQwSC9vWVg2MTJlRkVIK0VtK2tla2JJaytjcGhs?=
 =?utf-8?B?TUJISitBcWxkc21jRmJHTnczcUhySjV6NlRJYzlWT2lsc1g2aFRtM0I1eGZ5?=
 =?utf-8?B?cVlTMEtJMWxZOVpoU1dYczlYWVBScnY0N3VOTFp1Ymd5OWhxdktNUGNKTDg0?=
 =?utf-8?B?VDR1R0VBM2xtWTdNbWRpdmtyekY3bmRuRXZwN0RrTGgvMzBVSjRCcVVIaEJv?=
 =?utf-8?B?ZC9DbW1zMW9oSHhPNjZIZnIxbGRZdEtNMjFTRVVpRFo1bXB1Ry9HNlAyUkFU?=
 =?utf-8?B?VlNhbmZvNjR0bEZNYlZ1czBqR2xUYjNKK05RVTV6cVBqOXIyeDRZcGpmakZX?=
 =?utf-8?B?N0IzWStUWTRxWjFpazNGVHVVYTM2R29FSEppZ3ZHb0xJYUR2eXNYcGliYmpZ?=
 =?utf-8?B?UzcwRjdLcGlXRUhIRjZtWUJyMmRBYXJtWDU5eDNYSFpkUnRNN0RsaTJUamxa?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <742DEB642E60E840A375E1AEFC8E7D15@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a7ad63-a025-4c76-352d-08dced700308
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 23:20:52.2216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISNUkW6nb8pBsiBJdtHiC5yCe5rA9MEZqQ++nqU7WSp+4QqOg/38bI8LSDHAGG375R488goLNU2UxnI6QS4BcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4459
X-Proofpoint-ORIG-GUID: pLY_YfMOMD9P6RpgyeepOAD3LkGJcuFH
X-Proofpoint-GUID: pLY_YfMOMD9P6RpgyeepOAD3LkGJcuFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gT2N0IDE1LCAyMDI0LCBhdCA0OjAx4oCvUE0sIEFybmFsZG8gQ2FydmFsaG8gZGUg
TWVsbyA8YXJuYWxkby5tZWxvQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBNYXliZSBhIGNvbXBp
bGVyIGJhcnJpZXIgc29tZXdoZXJlIGFyb3VuZCB0aG9zZSBpbmRleCBvcGVyYXRpb25zPw0KDQpJ
bmRlZWQsIHNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmcgaGVscGVkLiANCg0KU29uZw0KDQpk
aWZmIC0tZ2l0IGkvdG9vbHMvcGVyZi91dGlsL2JwZl9za2VsL2F1Z21lbnRlZF9yYXdfc3lzY2Fs
bHMuYnBmLmMgdy90b29scy9wZXJmL3V0aWwvYnBmX3NrZWwvYXVnbWVudGVkX3Jhd19zeXNjYWxs
cy5icGYuYw0KaW5kZXggYjJmMTdjY2EwMTRiLi43Yjc5NDdjYTg5OTYgMTAwNjQ0DQotLS0gaS90
b29scy9wZXJmL3V0aWwvYnBmX3NrZWwvYXVnbWVudGVkX3Jhd19zeXNjYWxscy5icGYuYw0KKysr
IHcvdG9vbHMvcGVyZi91dGlsL2JwZl9za2VsL2F1Z21lbnRlZF9yYXdfc3lzY2FsbHMuYnBmLmMN
CkBAIC00NzcsNiArNDc3LDggQEAgc3RhdGljIGludCBhdWdtZW50X3N5c19lbnRlcih2b2lkICpj
dHgsIHN0cnVjdCBzeXNjYWxsX2VudGVyX2FyZ3MgKmFyZ3MpDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGF1Z21lbnRlZCA9IHRydWU7DQogICAgICAgICAgICAgICAgfSBlbHNlIGlm
IChzaXplIDwgMCAmJiBzaXplID49IC02KSB7IC8qIGJ1ZmZlciAqLw0KICAgICAgICAgICAgICAg
ICAgICAgICAgaW5kZXggPSAtKHNpemUgKyAxKTsNCisgICAgICAgICAgICAgICAgICAgICAgIGJh
cnJpZXJfdmFyKGluZGV4KTsNCisgICAgICAgICAgICAgICAgICAgICAgIGluZGV4ICY9IDc7DQog
ICAgICAgICAgICAgICAgICAgICAgICBhdWdfc2l6ZSA9IGFyZ3MtPmFyZ3NbaW5kZXhdOw0KDQog
ICAgICAgICAgICAgICAgICAgICAgICBpZiAoYXVnX3NpemUgPiBUUkFDRV9BVUdfTUFYX0JVRikN
Cg0KDQoNCg==
