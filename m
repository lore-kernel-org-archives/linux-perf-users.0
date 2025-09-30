Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012045.outbound.protection.outlook.com [52.103.32.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835642F6581;
	Tue, 30 Sep 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227564; cv=fail; b=hMYyfDGn70GypozX/sQdy3RLA5wPsj1xpcNYMz5v8IjoDpfgrAsTq9lhVc/G5KXujFQxojiUcS4napTmEWyjVi1u935xcpqAyp0HwztqZ57JsAz3WmtIsNlyS6tspGh2KbLknQ4CQ7cJiuWAo2xuEg/Zxt0D7Ye+obYpG7t7reY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227564; c=relaxed/simple;
	bh=vgIwFi9BQz3maQr6r6b3HRp4vRGya3wMeCXXgQiYexM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fZ+dBBONBfAKMaa0rZKlX62iMAiekKxZ3GQF7coBFJo0JfssyQICLRKD/1qk7CMEEagM+ncNJGuX+LiILjYKt1Up1f326zwPJmPLUqc9BGihCGVIqSHcAQ7dLRKNGIHdJgbEzrYRk1RGyHAVZC6rcMVo08bRXNMUVBdSablJqt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=i9g47bAX; arc=fail smtp.client-ip=52.103.32.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="i9g47bAX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6RyGzkWnXjNeMlhEFgCbhLwM0CV5UKFVg8bwnxlyCSOUHvzxEjNi7yLRCin7aMZZGG0OfgiXQFvrLcbjGCYpBxAbHAhgLvXVwG1WLKGWxXWHndbeKEyQLJ4XrqzdFnK1L32r9uJR5p6mes9g8kFTHFmvCcF606VlzP6Oxdyn8QX0Qaql17+l5Iu+S5PMA9xND3fD5I5Ze82VlvcTkgpOgoPIiH82i8Y+fBYt3nMcMF5Bre8leRc1jC+sH9GyJ/YS1Vdd8OOA5mvHSrtKFxWjVRiOTC3Pv/HIBniwxZTBuPnbP12LWbvUhZg/m8DL7pM3VCJHTafvEbrQ3XVbhSaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63dAqOXPjcPXdFAlOBjkgWFr8CG0Qgc8e7EvI9XQ0NU=;
 b=uJT6T5E3kCASGgKirBDqN3JTsAxUr1Xi3B8ym7mPSl2agxNs58Kt8UbQccJySdKbCFxsat9dvqAUrgaoKSVd8PZWreX+H1saN0eRWAejgeLv7XAf4G02u9h7GrqMWViQSMV6UtDewEoaRvmGoYPGLX+xcFMeWt43MVHULiw47bvfg5/HTIJtOQgU1w8lSIBRofDntumWqtbvHABAOtbSzJ/jpEfoQzaMzBZC3SVIBfEZepboT69UlH+6EoKpZlhpywMuDulANPj8PxcJDVn5ZCdJCyOmOy295kxOBqOdaWpPzyLk55A7HpAz3evbCbtJkcdpdvAK/wA9hE6m5H0MHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63dAqOXPjcPXdFAlOBjkgWFr8CG0Qgc8e7EvI9XQ0NU=;
 b=i9g47bAXPF4MJgiaamnjGc4SoOiDa+/iRoTO9mHVc9OQUigsqCN8lguWa4hjRf+GYcv9eU7m0A/77s549avuEzB91ksHKV8P0J2146/9lGcSAlHmYNtG7ovgKE6zWu8tLhzgH2wyUe9MQnuXgku7JV7C0nn/2L4md5hZqZ09B3aF764pfOBGZT4ZONCggufCKT6993bBtRW4Ia7oHQeS/MW69FLnpmQTWonl75BawSy1uGaYChCjIKQzBMuvTPCyzzr2DKkEcHNVofPKzoP7QleotH5/Wzo3+9t360/3uFS4QvLjw50/LsdeJlL6TaYc0B5yFEBNwdXuVQEbXX7m1g==
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com (2603:10a6:803:85::14)
 by AM7PR02MB6033.eurprd02.prod.outlook.com (2603:10a6:20b:1ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 10:19:19 +0000
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::60e5:4de0:ff18:2fb1]) by VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::60e5:4de0:ff18:2fb1%3]) with mapi id 15.20.9160.013; Tue, 30 Sep 2025
 10:19:19 +0000
From: David Binderman <dcb314@hotmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: inux-6.17/tools/perf/util/lzma.c:123: Strange return value ?
Thread-Topic: inux-6.17/tools/perf/util/lzma.c:123: Strange return value ?
Thread-Index: AQHcMfMTSwoEFFLcyEuvrfpR1GmUAg==
Date: Tue, 30 Sep 2025 10:19:19 +0000
Message-ID:
 <VI1PR02MB39525F61113D96E3671BFA1F9C1AA@VI1PR02MB3952.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB3952:EE_|AM7PR02MB6033:EE_
x-ms-office365-filtering-correlation-id: c0bd06d7-c869-4438-b3a4-08de000ad13c
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799006|15080799012|461199028|31061999003|8060799015|8062599012|19110799012|41001999006|13041999003|51005399003|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lD/wALv1C2jQvUBFNZOVlM79mAwgkv7k+FadilEj+RDV0jvhjMZ9B+DMWn?=
 =?iso-8859-1?Q?GFrH2MEBX40T537Ap1+ASijlt0pADq2pTIRQYZLwV+kn73puVospqNwT2S?=
 =?iso-8859-1?Q?fQ0zbMs7l8OVVW+hSQOdL/fv982PijtCptJLcnr7L9iuItjElXxgjAAtD8?=
 =?iso-8859-1?Q?AVGw6y+U/pMA/hjOHaiI5yTWspyesNfCJ+6gmHqdoQDQd8oavyH4vPRYT5?=
 =?iso-8859-1?Q?cc/A1RJWcdbvj2Z6c3iUK+ViPqJT3vjkj5k8Vw+ydLk3091zR8XsIM2DEg?=
 =?iso-8859-1?Q?YsXTRNLhdQf3CCMIqBcASSOzbmVsRrPQt+lOpU+QQaLRfBcWzgvD5nhqhu?=
 =?iso-8859-1?Q?/Y/JUcxy8Zdeaq+q0oOURaKFi1T76jO5fJ6u4hGHsKCJ2O8MESdimNGNrB?=
 =?iso-8859-1?Q?oWCA4QQ3zx0ndsqZrSB6v1DoBvpms4rDf11inKLM4D2ompBxFCoDSAZ5/k?=
 =?iso-8859-1?Q?PQQdq4JMDoKUsFewsexDJl7aQDjXxS//sckH49SHeXK+50xgsaq5QJTMMR?=
 =?iso-8859-1?Q?cwaiYesDB1uQlt0M5dGVR+S2SWGw6yWRg+9sSTKnSqPeCGSDJxSj7glcLc?=
 =?iso-8859-1?Q?ue1tzrXl6B4DoregbGLcCTWGk24oxURFl7OJvHnNFTIyengahtnykYG0Ny?=
 =?iso-8859-1?Q?V155FCmY9/nzFu9lwjQlSE41ONYfN3IU1mOwu2/Z1tcovPPpyIpVzVqrKy?=
 =?iso-8859-1?Q?fjY8N7APNN7TChIEWbmmToeEwU3DdFRRqZNmFjklT4bsw/EF+NuX246X8h?=
 =?iso-8859-1?Q?0b0YqCO2flTsxzuSSJ7qIZMxGC6c0sUzSubuHIl5SZHdZYQXYbLWLbOTjq?=
 =?iso-8859-1?Q?kB2L9Kmxvk6iDasVdlRuBhEV6m6SRTLrhqxVVq/T9nxJa106TS3nGH3tyy?=
 =?iso-8859-1?Q?qgSgufD7l4ORxYXj+v/IDx8slJDMSLB5603hD8V5RyckOtpBpAm4rllGcQ?=
 =?iso-8859-1?Q?T0mBRbPuBBhEZApxC6nnrOM/gYQKK8U9xLPxGWr6fCvWXGL36Ijuo+E5XY?=
 =?iso-8859-1?Q?81Tt1np4BZzWkl5zF4BH/LlYICsh/LZ5uQhshHj4fp/TLblAjtGwGKhqmy?=
 =?iso-8859-1?Q?gIJh6BV7y8nSe2VMctTqUrbl3l7dSkL5c697ntrTaCk06xx46Dbs10wPUU?=
 =?iso-8859-1?Q?IOkERgQWirMQd259JKdnp6gSTFoesf3yGHQSHWFgal2VJ0ookjKMHo/kz9?=
 =?iso-8859-1?Q?XTqth/SOcTO61IHKXtsRJvXju5vfFzAr1Nh66s2bg0QgODqxknV5CMbGdD?=
 =?iso-8859-1?Q?Swc/7rb5Gwlfh9TYooq7D91HizHm57V1bWqUImzCr6a0TClELMuMk/ZFow?=
 =?iso-8859-1?Q?J6MNXn1nFbxwiskXf/N5p+ICGw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XZF9z4/nqb+wIbrDAHYoNCswKkMVwNGMkdQP8PSbZb1zulL1B1AZArYiCC?=
 =?iso-8859-1?Q?WUvA7ByOY02WgTEkRiEX3s7qdPfEcL+lEvnFjTMr2Th4BLUsaIfx35YYWy?=
 =?iso-8859-1?Q?A5J0kaLc5HvP8AQIIDdG5DgLXGD7tr6SQC71AtO1Cn9AOBFtGutMM5TMxk?=
 =?iso-8859-1?Q?8g5K1JFGwCpzbuH9zjbojUjSSOWZa+UaWGnP8wGXqIH0XQLB3g5ZfYnmsI?=
 =?iso-8859-1?Q?sT6+P2CjvrxNsH5pHfLI0M7MxSUsIcwl6htM6qJrERS2KyNKTiMQY9bdWD?=
 =?iso-8859-1?Q?fFtAqQsMnARC8cwFpkJLsr1Pn6Bk8t/jvHMB0Mhmn86FXZ+zYqm8ZJzWIN?=
 =?iso-8859-1?Q?0Rvh5fzaKBkF4RVjGj42XewKKMH/cb+FKf00vPtV/MbehkIDhAKfdE2Vs8?=
 =?iso-8859-1?Q?GIIWbROuC03umdiL99NXyul/AuHlDWOkK0sdVSDq4CnEuZ5Hj6lz5Kpbia?=
 =?iso-8859-1?Q?kiFjoXuui0+d21/Hkha+Qy5LwduflyzIoe5yMfM3FjG4YefhmJckyVEEZW?=
 =?iso-8859-1?Q?GSL0uJrENbx6+kYaUQyYGQFA3fB9jmO3uvnbH9t398CSbxaWlh5j/WpsOs?=
 =?iso-8859-1?Q?PRVQHmEAKVV6eDqANJHiy4+KL2bM+cbZ3npsAT3ksSAHCN6Hkw2/Ek54Po?=
 =?iso-8859-1?Q?xxpFdSMbCdcDhAfL6qkNOXHvWrANzsnkKEEq1IFrrraONvV48PiDp12ZYi?=
 =?iso-8859-1?Q?4RGJE6/F+vhZIhUJ0XZ6As3Rh8Md1XvdEn1oLr3mirRHxveCvkQbUNcLKU?=
 =?iso-8859-1?Q?a1Heegs66qhAv2zEkw+uJB9NS3/l7XPSa+xPAqT3hPqsqLIpAgq76shVb7?=
 =?iso-8859-1?Q?5sNY1QdPgJ/7eQ07HZGgywNo3f4ECXSrLoVpyQw6pDCvhTyEp5YM3I/lhD?=
 =?iso-8859-1?Q?rR2k29CUlxo4mqCqLlxxyr6oUebwO6YggbQFgH773ACMIfCup6QgA9cx06?=
 =?iso-8859-1?Q?t4fE/pzBj6le8Wi+EP4/K6+OSA5M46q7Gtp5fmJlVybOcdjNao4hDxhh6O?=
 =?iso-8859-1?Q?sDydVqqAn1J50EcPyxnUz3wXCyvPpfpEIIKxKTZB/N6kP7hlQlUZMCoDbc?=
 =?iso-8859-1?Q?valVysBj8izmCLInd08S3XsQ4h0AfhkKWnIrT5jsCcHwR34YGSgAnw09/V?=
 =?iso-8859-1?Q?VCwvNa4RUDIxDlxA0WJe1naXJSE+r1ti5gRa3rUfOzC6faoJ+Cvx0QhEmF?=
 =?iso-8859-1?Q?xHqMi4DouLSQ4ZBbpDxkxiGkPhIpvaP28bWyaHvhdjF1JUa8gb++tGZzkR?=
 =?iso-8859-1?Q?nwT8l6Dt5fKpqnjU2Hug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB3952.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bd06d7-c869-4438-b3a4-08de000ad13c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 10:19:19.3052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6033

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
linux-6.17/tools/perf/util/lzma.c:123:3: style: Non-boolean value returned =
from function returning bool [returnNonBoolInBooleanFunction]=0A=
=0A=
Source code is=0A=
=0A=
bool lzma_is_compressed(const char *input)=0A=
{=0A=
    int fd =3D open(input, O_RDONLY);=0A=
    const uint8_t magic[6] =3D { 0xFD, '7', 'z', 'X', 'Z', 0x00 };=0A=
    char buf[6] =3D { 0 };=0A=
    ssize_t rc;=0A=
=0A=
    if (fd < 0)=0A=
        return -1;=0A=
=0A=
Suggest return either true or false.=0A=
=0A=
Also, there is a duplicate of this problem at file linux-6.17/tools/perf/ut=
il/zlib.c=0A=
line 91.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=
=0A=
