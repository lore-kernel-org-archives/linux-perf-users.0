Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=54.211.126.101
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792426298;
	b=Nmz3k4grBxb3wpsv4sLA/hOYyXaJ22Y9UovzKzXiN7sQ+Xt3zX+25UlzmyiDerPTNyNP
	 fE5u+P7dvpci7uyHhJCVhrwqnmxkeoc12DRd/JO4n2+ZbDbHwD5dgIEH9QrB6NZn7TAp7
	 enY+2RGa/yoVuVf1JJKBh4t0mGrSODTpwvO7sHR3WfvQZ3OJbQNj0RDYKw3qPmThVezYL
	 lzJykieaBCJG9uNuAxGZcqNXV/Np6K13SCAiazOyvIrA3TFnOCJbd1C/NvZ6Ci31Xu6mG
	 3uMwGM5D/hgKHkylKjWrg0LFcsvUf+iJuSh2Kf30XEFzg42HHQ4Vf6SSeCEMpz3Hrkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426298;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Subject:Thread-Topic:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:Received:Received:From:To:CC:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=3kgnZParezsrGWB+o0GbdZiKiJIOE3dfviHdpMeOs6Q=;
	b=WbOT/9dd4lKmMXM8993bAB9DhZvIblgMeIbfHPU3/BIPdg7ckvoL2077MMSN1s1j4F3e
	 pmlvbd8r55efVdJeIuikV+uVp9tIILy9OpFzkgylmJeLkMyrm85ImmKyo1QT6E/XOk8RO
	 1Q5tyDV2fZ4KQgNWQC0Q1tbptOQtGyDgi4MKyUvYezdqAdjEq/2nybhwwS3drYKfFhEqJ
	 QwIWei/VVS4m9lbfXrM+2fNd25cl8GqFHYibk4vZBqbO2HiWjgEtpmam9UzvKu5yZOOSV
	 d4b56qzdZKfbVizndeHt3ycXgVs0DCEf8cZuJ+FyJBRZkmX4Q0FFAvUqNP9WC4RsH7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Kiaq68oz;
	arc=fail smtp.remote-ip=54.211.126.101
Received: from iad-out-011.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-011.esa.us-east-1.outbound.mail-perimeter.amazon.com [54.211.126.101])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630A606EFEC;
	Mon, 19 Oct 2026 16:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9630A606EFEC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Kiaq68oz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792426297; x=1823962297;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=3kgnZParezsrGWB+o0GbdZiKiJIOE3dfviHdpMeOs6Q=;
  b=Kiaq68ozT51loUB+fW0WR5F1lmzuuykr7okTMO3Qq/9VSbuURBSyIDf0
   UrVPu6Lxl7xdPB6iMFphJNqUSL3MSeyksQWIqxGpC5kVjjMFRks7FMQa3
   fncgGO81SVyCu7vJxsf9PBBsJhtjnsvNS8EGOhe6SP2xYk2eoi7+p57zb
   cZhaoGZUqTpp1IC531bo04buw6cbMNRN2hS4MYCWow8nbhT9x+SRrrOpm
   P4sj+Wgl+VoOUik4wwzu+nNrsOXC2d7VOvtRkw4ioYZ6Gwm7x6rHsT5oH
   bq7QB0zhpln9L/F3HKLvXX9vjhi6drkxX2JWzNNtI+5NzvbCjgrEMcQwk
   w==;
X-CSE-ConnectionGUID: 7dx6n5+6S2KI+EBzwDd3zA==
X-CSE-MsgGUID: 6Uv5BfQfSIGzSs8rTrTc5g==
X-IronPort-AV: E=Sophos;i="6.27,167,1787011200"; 
   d="scan'208";a="29833504"
Subject: Re: [PATCH 2/4] perf/core: Add PERF_PMU_SCOPE_DEVICE
Thread-Topic: [PATCH 2/4] perf/core: Add PERF_PMU_SCOPE_DEVICE
Received: from ip-10-4-13-79.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.13.79])
  by internal-iad-out-011.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:11:36 +0000
Received: from EX19MTAUEC001.ant.amazon.com [72.21.196.66:29437]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.10.178:2525] with esmtp (Farcaster)
 id 3fde0284-9624-41d3-99ba-10ff36589761; Mon, 19 Oct 2026 16:11:36 +0000 (UTC)
X-Farcaster-Flow-ID: 3fde0284-9624-41d3-99ba-10ff36589761
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Mon, 19 Oct 2026 16:11:36 +0000
Received: from SN1PR07CU001.outbound.protection.outlook.com (10.252.134.239)
 by EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53
 via Frontend Transport; Mon, 19 Oct 2026 16:11:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kX7sOhq1fRQF817zq/0nXWbcfixg59Ws3tt+dYg1eMyHU2Ziw7KKfU+e/ZTyU2GEDjHoPBtMk0KvkzgkxE6Oe/1e5U83oJLCO4uDdmaEhSG5SJY1lud9T3zICciTZz7+a12hn/aMjJWhBjgsgTGaybvSIFhy5WgLdXL+mPSynEG6qTurc9aD438mDGliT6jJRxVvCAkJwo/VTD05z8hyCYwvBydH5rmiSTR0iFZ3dLnmrGXyIBJxE0VHL1Yj3Utm2GB8g41PrCs0DUj0z7lEI/IS42SiMB+XYocboQ82SQDM8wnLbK1M6KNkm3ST2BNsHckwLdhUaIlatcm1ZZKB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kgnZParezsrGWB+o0GbdZiKiJIOE3dfviHdpMeOs6Q=;
 b=UndkYRDMQKo7kWrlM4T2C06uUECOfgwmBoS6o1olp36/87Ayd/3zlxRjn53tgpGynZXSoDTSX5CgcZCatPz7Wy7AKFTlHAMvpiTQxvj484BHnPxLTAK8Qshd8yAgC4M5APOPmaWteSL9y40IRLdfgPooXzUczh/kQV1b7rbS0RlLEDwGOD4rb8y7XxIWg08RH/zcwB6Jc4SodvB+HX8PHDcQtgUBozBcK5YCkLnGjocV6GSkYWCzE7TrTeJ3JkuLk46IbLSHiwycpny18vfbVIILGC9Ob1ELcQfdhH7aLYTYL7EvDi2YE+j0oPIls0m7LA9XnUcN7GQw1IR7gfs9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MN7PR18MB660231.namprd18.prod.outlook.com
 (2603:10b6:208:5f3::23) by SA0PR18MB3614.namprd18.prod.outlook.com
 (2603:10b6:806:9c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:11:34 +0000
Received: from MN7PR18MB660231.namprd18.prod.outlook.com
 ([fe80::97fe:4c12:b98c:3b70]) by MN7PR18MB660231.namprd18.prod.outlook.com
 ([fe80::97fe:4c12:b98c:3b70%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:11:34 +0000
From: "Okanovic, Haris" <harisokn@amazon.com>
To: Robin Murphy <robin.murphy@arm.com>, Peter Zijlstra <peterz@infradead.org>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Index: AQHdW0SSK3v9gKZPRk2g0ZPmg9Dv9rb81o4AgABC0wCAB/iKuQ==
Date: Mon, 19 Oct 2026 16:11:33 +0000
Message-ID: <MN7PR18MB660231538D0AFB9CCAAA805964A8982@MN7PR18MB660231.namprd18.prod.outlook.com>
References: <20261013185603.1347265-1-harisokn@amazon.com>
 <20261013185603.1347265-3-harisokn@amazon.com>
 <20261014102700.GC4121339@noisy.programming.kicks-ass.net>
 <e9d01b93-3658-4ba3-a15c-e6b4122b5c08@arm.com>
In-Reply-To: <e9d01b93-3658-4ba3-a15c-e6b4122b5c08@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN7PR18MB660231:EE_|SA0PR18MB3614:EE_
x-ms-office365-filtering-correlation-id: 7075c78a-ab87-4584-1749-08df2dfba519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|38070700021|11063799006|260925021911599003|4143699003|260925021311599003|10067099003|260925022911599003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: mYWTZnC8fXCuD6AFfq01R6cG7T4nl4DZ9gg+ol1OI1gZxWvFT63AEBF1/qwFO2cfWH+j9KZuXkbbA/RM5rFd8HV6vqEX/L1g8G08GMF9N2Pmr1l7E4Qh97ncSdhfbYXfTlLixcFVjf03rHdMjBopO9tQ+WZ5jQysQPjTxsUxJmYCAUA6zXCY2IOqyYA8vtvszYcnP3C/A9Eba00e1CrirW3GqvkMyJE01a1zdzkDsqytoB5YqNeQpvgchs1R5/2at0OcV1t1qolGHNS8u9o5bLTk3sPNS8EQ9RwdjaHWoz+3R3wzT6qelWT2U3Mn2Sp8GHmtXh5ob8fCeA9WznsBhnj+SkFo4UJJQLcj87HW6kaGU1gsr5I+cIo3/ZbZtU0vLKVxVWjFb5q6yyAazb4HFo9s6FelWEk/PM0wz5E7JjuYhd9GWzYB/Tqx9Qt9Y3KltIf8ltTTCgnVJ6O3ZaQq8qgNGQHoAIBzCZ/XNf1TahzqkLopxQXFaFWdTDXWse0d1aZH3COq/dPJf365CW9zK+065Z1U0t3ZBGD3kHtqjvvqz0bqsKacW8gXFHjwXpurA1QVvX01RDQ5bLuE7MfhhkDBb29XAhSTqPfOmE3dJsGuHq1HgbLRoHzUwbNLGxcnvtpUSkfuUAxpBLbqKPpi0FpI9DOezphSMGY5z61VsrQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN7PR18MB660231.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(38070700021)(11063799006)(260925021911599003)(4143699003)(260925021311599003)(10067099003)(260925022911599003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qyGz+7nbHGyxdBY0GN4IiVcGnYD8DW3UDISwu5SaXFIQgsqMxpz6DwJ+VO?=
 =?iso-8859-1?Q?pv48P0RL8cqTxpXXewWP68DT98b9tpCN7SO7fccyb0oFU6oAOmQaF5id+D?=
 =?iso-8859-1?Q?RW89Gh5cPxJAMZ51I2a1gdrCt6OaJXjl62iX9b/EbK/u1zq0s2axmeT4DN?=
 =?iso-8859-1?Q?Gz+Ht3JeTMEtkocBuP03/KM3ajBgC0/Kc/jzHlw3LOvzku0HNHI+NwD17M?=
 =?iso-8859-1?Q?1Wj8pjNH7xfRvdDlk7rVrn/HruP+SWPxHJfJI6JQXS3m1YidB505Tuioj+?=
 =?iso-8859-1?Q?krKTUGxwfkK3gWrhSR89KhlHqK4BUs8LHocdQUYlfwh1ryWa16E4NRK3ek?=
 =?iso-8859-1?Q?qtBc6RTHSMJ7QF5z3KirkSd35PpapSf6gn/kLBoY/FjeQdR3A+UzyULnXk?=
 =?iso-8859-1?Q?yq/xWey88kM+WHa/rsg3WrBYBfUZwraEKsT26o6emvgNJQ8/TnIZypcFKc?=
 =?iso-8859-1?Q?tADzLddY1v/Hhkq3cLQUPAikPUbYAO0Zvbpw5CrxxyiHuzopiCQwe8Oe6F?=
 =?iso-8859-1?Q?t1+XqRXwEOcc/cHmrsyAO3LEf7WPaV+CJemzwJjObg7aMXqvTUGN/d2mTd?=
 =?iso-8859-1?Q?xmGpy9rNtUlH0MdaI3nnCASsK1VG24EfeVFprgIoeRNKyjtcxygBP6Y/j1?=
 =?iso-8859-1?Q?xF7pTDg7CEP16DfaQPBpnLYt5w1D8Zg6aLaOJSPc6tGyGw1LuFl8Zi1/df?=
 =?iso-8859-1?Q?d3NqFXE87wV98i1+JZsOovfZ6lCKu4bS42awvXbeZi3ZhCxABMX7OBa5uO?=
 =?iso-8859-1?Q?kXyyUE5ffEuJWh2Pps9Wm46MJoQ5Xql8eYKNJO3PepqRhzdJbxMcJo8cNY?=
 =?iso-8859-1?Q?IkbAhqI9Ji08JXUeUWGlu7T5zGj9v4BWe/q1YAUqqDRRFwpd6TB5lWCNDa?=
 =?iso-8859-1?Q?RKdE1zRsYqrIVMQV8ZhvZcvSMl3SQPPBXyVhrz0BFOS21rT2/Ll3/LSSgi?=
 =?iso-8859-1?Q?s51fcR9p+cquylnj0MFeR6SnAden3t/lOMtAyxV9UWV9FdvebhKBq+J/xI?=
 =?iso-8859-1?Q?huvI4tZqoZokKyh0oKo8HxLocLGN1J6xCix6n13B22KrEAgBmcmlfjIc2n?=
 =?iso-8859-1?Q?akV4C9h9HebZMyoTH17UfRHP10HtNRkbgYkhjilqeqm8u6nlTz5heZJUkD?=
 =?iso-8859-1?Q?qHhl6aPOkxkjpXl8mQk7Ex8RKdXBaaGJQoarbvbtRC3l97uUNLaaJPaDkJ?=
 =?iso-8859-1?Q?NyAJpWdYUe0x6S0QQjjoiq7phqAZoSJvadilggdKuKw2AY/+Y74H6b5kj5?=
 =?iso-8859-1?Q?+bdZPr1vKvPFhRNIM0n67RmKtjbsdQPmwMHiJPsyQi5Mxq7UKik4145Aut?=
 =?iso-8859-1?Q?/74r/+WJ2Gk/9G8NXcPNgBSYpht/IrNSO4oU/bzxoII4PNbG35B2R9NGwU?=
 =?iso-8859-1?Q?ThCL76dBxLKlhGFqtUV8Cda+WzJ45PTIzGXKwh80orVp3xxpUx56Ir5pSt?=
 =?iso-8859-1?Q?2WZAsWfR1G7LP8fkcsJtqHWpkTv7Cj+8pRCcbjYVU0DBP18sgn2Pn7oIMZ?=
 =?iso-8859-1?Q?1xi1f4ei/Jjf9f+uhnZSIVu5aSOecg3T5eLnkvzcAKuV4Kqi0bEp6sks+j?=
 =?iso-8859-1?Q?41NqjmYfOL2bBr3uQIImuo+eNjMm/WB49uaJzpq4lQNKutVV3ex4/q4Lqs?=
 =?iso-8859-1?Q?BlZ9a4YjANHh/rEBnbOdZPbyjyqXZxH/gK0iWOsg6iKnDXMGiXm60tJ7so?=
 =?iso-8859-1?Q?JwwgJcbLU5Wctz/17f7XQiZR2jUMz04eVFMRrf+j4nkqRIwU0CqLt5e39g?=
 =?iso-8859-1?Q?7Z00/0HGqIU8GEH0xEwPtrt+iZNbbsif/leqNCyqkSJDQR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1hVix09Q0zdPtrw+I5S7T6e4qk2DCGbGeII8b//v/aTc059BuZqoB26iQlcS0XRv8djH6x5cNdDHkFPEDJA/xSNDAKXVkRG5EqZYl9WCgwmWlZ6DCqWamTHOQ875Rbntn0YAJvAwr3tTeiCPoWXquJ6DvCY7lUZTY9l40colKmX2IAGgpqxO0gN+Tc3D//3PhB4FRslv5t2Q3xVVsFckS96x6TWEBhrTxgri/Eqaj5bG9B8gL5dPmDryQdRmKbnw0TcGa4fZLNqAYiWDwav3MXSKjQU0ryxh8oqwLlqJ/k04IZpik6ONQ5R/uTJairjyJ0ib+B3PVZFVyjODDKYnyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN7PR18MB660231.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7075c78a-ab87-4584-1749-08df2dfba519
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 16:11:33.9448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61vYwN5mV/JY9qHbaCW9PqTW4tNIxZiIQ0GPVdhZXunbTL/vOiCPxKwtYlpWX574B4AjehC34gyQ03HIfNSwaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3614
X-OriginatorOrg: amazon.com

On Wed, 2026-10-14 at 15:26 +0100, Robin Murphy wrote:=0A=
> On 2026-10-14 11:27 am, Peter Zijlstra wrote:=0A=
> > On Tue, Oct 13, 2026 at 01:56:01PM -0500, Haris Okanovic wrote:=0A=
> >> The initial CPU assignment can race with migration, leaving a stranded=
=0A=
> >> event. A sequence counter is added to close this gap without additiona=
l=0A=
> >> locks. A count in struct pmu increments on each migration and is copie=
d=0A=
> >> to struct perf_event on init. The copied count is checked again before=
=0A=
> >> the event is installed, under the same context mutex, which causes=0A=
> >> perf_event_open() and perf_event_create_kernel_counter() to return -EB=
USY=0A=
> >> during migration periods.=0A=
> >=0A=
> > I'm not entirely sure on this. How is this race different from changing=
=0A=
> > CPU on hotplug?=0A=
>=0A=
> Not much, other than that hotplug is at least already serialised against=
=0A=
> perf_event_open on the perf core side via perf_online_mask. This is also=
=0A=
> where I was heading with my generic hotplug proposal[1] - once perf core=
=0A=
> can be in charge of that, it should then be viable to also migrate PMUs=
=0A=
> for reasons other than hotplug, and it would all look the same to the=0A=
> drivers.=0A=
=0A=
Agreed, it's not a new issue. It does get worse once migration can happen=
=0A=
outside of hotplug, which is the next patch of this series: stranded events=
=0A=
don't get torn down since the source CPU stays online. I'm happy to split=
=0A=
the sequence counter into its own patch if that reads better.=0A=
=0A=
> (Yes, as-is my patch still preserves the status quo of drivers picking=0A=
> their own target CPU to keep things simple, but that was one of the=0A=
> points I was hoping to generate some discussion on...)=0A=
=0A=
Having perf core choose the target lets us spread load across CPUs, which=
=0A=
was a good point from an earlier thread [2]. This change does that with=0A=
a simple cpumask_any_distribute().=0A=
=0A=
[1] https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.mur=
phy@arm.com/=0A=
[2] https://lore.kernel.org/linux-arm-kernel/2d70be7b-12c0-46e0-b308-744a31=
59388a@arm.com/=0A=
=0A=
-- =0A=
Haris Okanovic=0A=
AWS Graviton=0A=
