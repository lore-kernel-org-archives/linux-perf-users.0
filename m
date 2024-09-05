Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0BE2107;
	Thu,  5 Sep 2024 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725500977; cv=fail; b=GRI15F5Acbb3DiICTLpmZ2EJXnD7VBQsRhXk8wyIBgAWCPn4xxmzMmOjEV0P9C8sJWh+m45eIIU50xKuC45/KJzQiiGUNOls+ua0UySkNddsf2/zjLremdimgExgnUj4m0ORxNoI0LxvJnE4LdT99eIdRF04zgxN9EdQORer/TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725500977; c=relaxed/simple;
	bh=ug8INZQUxgeuedltgIpydERICPTHtHEj80eyLx4TWwE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3zXdXV8/FDDgM/922GeVI17CeILeSH21eoi2D3HL6/RKX5i/zZNbzUVHuS2LpMeAis7OB5ye1NgCjNZkTofmI76YSpxtuMPKvNNpm4L+PyY1J6zYhZ0ri8aJX0RA95ZftSK5EpefvXwP4kZszoyPlX5h4/RodSXOm9/pKTcDt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=iuw2TxKF; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=WrTzJ08O; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="iuw2TxKF";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="WrTzJ08O"
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484NkrpZ007996;
	Wed, 4 Sep 2024 18:49:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Bvw8Rm5A90cdsSUVYi+hpzo1BQzjQ+yCes9VhxUon
	Hw=; b=iuw2TxKF0SC6+Wut6ejXucRRks0pilfy95v04S1QgkvLlUBD4qhiAlmqB
	Loq+zASpYFJUbdjhvYsXCEF0kaJ6V7YVCvocwBSfOfHLfS95uVP7kRed3spc6ph2
	TYVXQUxzu/7zdadPBjBWgf9m/gpyaKlchbsnIDlKK4NbrPJInD4Gto8qKg3byKwg
	lsfhpr9Q4v6gh0CM1jfi+VshDh7z1bPynbColY/s3zrg4SLycgCOBNgPu7BWxn7m
	ytfMNTM3NqYZSIeg/8Hr7ZsK23TbeIeeP21TThBpO7xQgOJnTrojFBA/V1xOExmk
	zuiZFitWxz9fM7Z/Kz2GyekiFS35Q==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 41f1h1r59p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 18:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+JsaWL/Nq81NX8DpeCHmqiSKPTe2fh7bDrbawBJs0D18XL6sEWrY7BTFaPVo6g1tBfeM20CS9tx3qp6HYhNC+q1rM5rAYEAm6WHz6ylOJAdY8w7EuFoOHZjqmFsGWZ3kPOAf3wLyD2j0TbmfOMyZwQLULyOMw+T0QBSTOvNIRhrGWRAzbLabVm+I6d6fLERgUhlmsQQNQj/0FdN/+Ka8SZpL46VJrmDfKYV/Y5UNVFnRaH/vvuirrypg7NB9BRPUJQ5aDkkJz78fWUfzd4clw7DyZo0yaDBiSFMnrCAuQlG5wlzVLoOJb+0a6MTk55B9T6jfB7uc7LLXxX6GJTlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bvw8Rm5A90cdsSUVYi+hpzo1BQzjQ+yCes9VhxUonHw=;
 b=MnHhuPFitA4X2w8LP3vpwypTUjIkaiL94RBY8/x1Evfmd0F8xIa2HCkTejXoPnaOY6u6AhBYgTsYEkLP2SHu/abwW8y3d7MSKgluaDvybenlIHMf3EvbfCYcIf0owj3MelwaV8Lzr5i/OsqMir8X9+XZyUJAx5bOEz5+FsLB0oWm6mREi+qAx2XskQgu4VPMCd3nq04yerdXjG7og7iU0skGGW/Guzws7u/2NU2f3CdDbffmZyiDdfFei9Wq3+hn6qtx/rESPy8nZ4JlVBJrciJYUQrPdBNIYPNQP5cIoV4B+BL2IBvPT2p5l8twE9XNoBZsAtcM7iF+Y0FofsiMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bvw8Rm5A90cdsSUVYi+hpzo1BQzjQ+yCes9VhxUonHw=;
 b=WrTzJ08O3Z05gpnAQNljd3PBQiXnlX4SFJAStl6TWpi4ygv+jqvoVvQaJJMDNygszrF87NVezPe18UiqwLcUhzh7puFyG3NUecmB3cf2EDvm6udYNoKfvG3tnexNEYUrCxNCggEf23VRWboSiuS8JZ/r/B8+PosmUpv/KcTMxkPDMnFhKo3uyGQOlObGTC7xvWpcslHC9rkqjVnSRQjcpZSXIrhgk0A4K/8uTQvn9zQN4BIJMaWqUO4cnU4oPoxivdCyvYYRshPLoISUAUWCU+9kAwXoCreUPFQF58DbvYuQ+9t2+kywUVWnEmj2GTCTX8q0BdXLnitguhA2gGOtyg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by MN2PR02MB7087.namprd02.prod.outlook.com (2603:10b6:208:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 01:49:08 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 01:49:08 +0000
From: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To: "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>,
        "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>,
        Eiichi Tsukata <eiichi.tsukata@nutanix.com>,
        "howardchu95@gmail.com" <howardchu95@gmail.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built
 with -O0
Thread-Topic: [PATCH v2] perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built
 with -O0
Thread-Index: AQHa+CvsObcsfORf+EmH03hnObqbzLJIezKA
Date: Thu, 5 Sep 2024 01:49:08 +0000
Message-ID: <D753C41A-F941-4FC0-B622-ACD8709B06FC@nutanix.com>
References: <20240827025026.157595-1-eiichi.tsukata@nutanix.com>
In-Reply-To: <20240827025026.157595-1-eiichi.tsukata@nutanix.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|MN2PR02MB7087:EE_
x-ms-office365-filtering-correlation-id: b0c5129d-1ed0-4946-e8e7-08dccd4cee84
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3g6e9sGcNCwyK6/1gKy7eM+xpRmtwpfXDNB0VdHeydY+bVPcuCsYFXgewDM5?=
 =?us-ascii?Q?T/PxdaLTRFTC9++A9wAzZnBF6NnlLQULCRL9be6zYWazCpbZOjemenrvQZg1?=
 =?us-ascii?Q?HB1TREQJmYnLLvuGLAX7fQSy1GA0mBrh8IknyO3HpMMMaE7YsLhF9LnHxDKN?=
 =?us-ascii?Q?SBOz2/tmF58o8h1XkijfMLTyRxiXJ4QlvjkGfMwYCTDzjcCdgekvvN0MvtXm?=
 =?us-ascii?Q?DsZSPAN8HfvHKY5rNB5cs80E6BcMjNzgCspWWsGbD3JspcKr136aFe4k5I0R?=
 =?us-ascii?Q?93dMrM5gS2EEvb5ZMjFoFJWHGcDdQUjGwr1GuT+od98Any1sSkR+v/pnu4lM?=
 =?us-ascii?Q?td0ZxMuYx7DrvpMli5M3XbniIvu8EaOh6e0EGuFt3s9xcx/CEYLv9tuWh++M?=
 =?us-ascii?Q?QqWGZUimqyCygXxViAHn+maKNDzlS4nBQ9rTSbVZEe873A1SKCGy5kBc5pq9?=
 =?us-ascii?Q?kNF4Lmcc8qbxl6ip82n97O39yEOd0cx4W5T8pQjBtvlPUuW9z09zx/DVc6xi?=
 =?us-ascii?Q?cjKmJrt1CCxRN3wYGB3WVrJRtCndtD40SKXhXhKDkG51a4Wq8i7f8UmLSiCx?=
 =?us-ascii?Q?3ZRor4s7914qobChueCq+hpUcT7MDDXUtIce7cbHKuAj3AZDQ09Dh6ceBwVa?=
 =?us-ascii?Q?+oNYYCHcySSTMXXdFpwv+Ace2U63nQ4+G45ayIQwMSjPxdCyK6RaKI4Qamvs?=
 =?us-ascii?Q?Py4bl1FJkU7KWXxoSATwjpgtLbsQSe2YSyVNQDSxbngp4Q6k83Q3HS21KpXC?=
 =?us-ascii?Q?tsxl+4u14hzyknFvsTNP06g8C0GBuC/fR4Xs6HphU6UQ7BLfvviIm7RQxVKk?=
 =?us-ascii?Q?6CTo8g1DUhFE3vcHTW0XFgIQlYus6yNMB8t0UxOzeXUiMXnFwxHpURV+7nVM?=
 =?us-ascii?Q?BiaR79H3glaYqFsNB9cnn0sJsdETi0rlCiAXivIrBrSg9BoL6GmvneQTQXrk?=
 =?us-ascii?Q?tTF+WD3gu6/jePaOKtpUUp5uRkmXyRFhA2eu0XWfVDZ2RXhP6+MfiL+U9H4S?=
 =?us-ascii?Q?FDue4fu11s5Ze8d9KAg5epfs1Rsz1YxqG2VSOwgBKa0q5+ad603GManob6tI?=
 =?us-ascii?Q?7otMHz9kMzCZJNHW7y7HCzfoeQsRXuu+nva7O7aBOG+hIv+fuR9Jsnhr7Zc2?=
 =?us-ascii?Q?MCiZyNz4GtcSKdVtv8oYwLLFj6M49SMXM628HuCEOEfgS/JzOjOInpy8vvjr?=
 =?us-ascii?Q?i+ePtotW6Kkt9p3Pm/7nXJKBRkK6uPk7I6H3QXeEteKTBPHpb+7SucLv9lpe?=
 =?us-ascii?Q?t4R8q4RwuFyHn3uFzV/Tf5GaVmR3ajabySYcrY9272rfjNn8JCGRo3jWyVDG?=
 =?us-ascii?Q?OlRGw6FDMARXcbNmCv9Y2tezk5vpGNolE78l0DLkrLHLUnr2kX04mHqWF0Qt?=
 =?us-ascii?Q?if+jbGZ/IYVPWYlfmKQlQbhxbD43PyIJS4lJ4Wp+JRxUGBvh8RRwje4KKDWt?=
 =?us-ascii?Q?CvTf8WfQLqU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LtP0sdOdnGLtJ1zsyRcQhQwc3sX58T/rMZQj8bwDKW6vMk8z8ZwLcaj1774i?=
 =?us-ascii?Q?bxzLqHoXu2kziSSqNyKgZbWnrswWrsrL1kuS+yKbmKTHp77AJMvl49ZOy0k0?=
 =?us-ascii?Q?Q2mufn8qxqhnUSKjIJL8wVgSQ4GfhAYtSnxsz91hRMlTK6cBxgngwjGGp0Yn?=
 =?us-ascii?Q?t9zA10qA3mPG/zVjKx5F/lHMxfA0PUYobcB0j3Sjf2huisOuGONkdfMUZHY9?=
 =?us-ascii?Q?ZunianvAl/aKIojcO7R4e+b0lPa/+zl/RFmT5h3vqVBq/G04cNPi/AomPYc6?=
 =?us-ascii?Q?QVblw/bM6LiQYMloiB7EeeFFiAILxEC6OJL1b+gH4W8lNF3KDxovVAksgG2o?=
 =?us-ascii?Q?xeGq6fKcbuiMIXoqYaJcko5ZoefZTPXO/Yo2wQjyTGi4I7vyBr1mkebbqXZj?=
 =?us-ascii?Q?lYJpaiKUCmuLzUbWcySagvpb9axqcRB7qzCM6zGFMKvbMSdDL0Ra1Fvq0FRx?=
 =?us-ascii?Q?9GVQdDninPep7E7/Hn493M9WpW7QvNZC9G6ADQZrlf8hVdBA/oG9NoNU7PRM?=
 =?us-ascii?Q?kPdv+pe0pjHqSyJBn3EuH5LBG4UxnaIOjck2Ec2B+7vCbbIcrs1zCj0nsSm2?=
 =?us-ascii?Q?jyXSP/js9VkI7ANiNEbmFqCkMs+jOtmauyzZhOTSBiVxaQDWaV2KU7wdims+?=
 =?us-ascii?Q?BdN/S411sFSSasx1Ji+QgyZ7afx+Q0Hg5w0WgqgjSQEd1lfD+7VedUOzYlMV?=
 =?us-ascii?Q?IJU3WZGF1bSESeTt6BBG0KyiHw80tshnREqMbicsEeWVfcDdbFDVS+csxGn3?=
 =?us-ascii?Q?pxy90s/T0O3VLaYxNntFxRv1Gm44QLHnqrKNBLQuFanQOa/bFWQCyc8gP5Bd?=
 =?us-ascii?Q?7+9muoTqcQuG4ktqnuvBdvg0f6LFxAKpUOpwZsD5LYYaOlYhPhhqzWK/Zzwk?=
 =?us-ascii?Q?ciAtkTURc4UWtbCTZhamT1kFFjkezy1CCVK0RZoz+8FlNDMmnczMS7cKGtM+?=
 =?us-ascii?Q?oO4fhXqFTN611rNIts9x9QOrKPG9HxinVd+cHdwdb/Z1HQHPBaWtnPB02AKz?=
 =?us-ascii?Q?oQdQCFIOfGKvsxup6Urbp7GmOP1rRM1pDERcv9C1nkZNDwTp2JtMpruGnb+E?=
 =?us-ascii?Q?zQqZn1Y/kDv0xmuH8pZY2ozpshRfGLRgn50sJGW8njIAsl8QFV0nP0d1Q/D9?=
 =?us-ascii?Q?eoOgSzb8QwTrOCZRCe++0euEa5JB2HHh5hxWENFmyjOOVfCpThajVIwiiK6a?=
 =?us-ascii?Q?MNNA0jmK9zmDXa7k3Pa9QKl1j0nYrRAjbwxoJsWMEFPfViwD6W+1eYsx0sTu?=
 =?us-ascii?Q?XbHX2RyRK7D3soBpuJc1CrI3JRo8KzxqSSyJdQBEtg6YcotOX12km8dF4P0D?=
 =?us-ascii?Q?KxheATJCCXvJD5xZ21XN1bB42yVWuADlp3EiErqSHpYAffL21B/FgnNwvPch?=
 =?us-ascii?Q?JSPoV5yMw0uwtlnJkLcbsiNTDlOSDjk7OZffxvJ8ffYbEO1rPUf+vfeKhY9M?=
 =?us-ascii?Q?/39JP0gQ1/UWEETxx8nB2lli/GuANTgsKqYxKFJak0kiYA+b/EoV6q4YuGfY?=
 =?us-ascii?Q?z3oww2SF2OL5f5zWqlTlXkBIw1mthQpQtrv16UkBc9Ncf/uZikrF1//V0B0T?=
 =?us-ascii?Q?V3uUDudw5gJAsqfdCEAkEtKcX9bLg+uyU9pTIuAYp+A0McYCwbLEKptiFmFU?=
 =?us-ascii?Q?hA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E25D0C93DED00746B63EB68334AB5925@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c5129d-1ed0-4946-e8e7-08dccd4cee84
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 01:49:08.2179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSKBtrRM8jIPVt9+CKj6UPlJGWZL0k+xY0JbsVAYEgQJu2leHlIEbeQ7klS0UBLLus5Hg1wIEC+tpQYhaEEKemSBa7716e8kloJDdumEXqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7087
X-Proofpoint-GUID: OPGEB8tOePfS7gmVY-1WxGv45UJNThN_
X-Authority-Analysis: v=2.4 cv=PKpd+uqC c=1 sm=1 tr=0 ts=66d90e16 cx=c_pps a=28bFCgguF5sZfysLuYgbMw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=EaEq8P2WXUwA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=5sl8H7gAFxKjBA7jt5UA:9 a=CjuIK1q_8ugA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: OPGEB8tOePfS7gmVY-1WxGv45UJNThN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_22,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Reason: safe

Ping

> On Aug 27, 2024, at 11:50, Eiichi Tsukata <eiichi.tsukata@nutanix.com> wr=
ote:
>=20
> If EXTRA_CFLAGS has "-Wp,-D_FORTIFY_SOURCE=3D2", the build fails with:
>=20
>  error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O=
) [-Werror=3Dcpp]
>=20
> Use "-Wp,-U_FORTIFY_SOURCE" instead of "-U_FORTIFY_SOURCE" for tests
> built with -O0.
>=20
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
> tools/perf/tests/workloads/Build | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workload=
s/Build
> index 5af17206f04d..e9af6b903770 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -8,7 +8,7 @@ perf-test-y +=3D brstack.o
> perf-test-y +=3D datasym.o
> perf-test-y +=3D landlock.o
>=20
> -CFLAGS_sqrtloop.o         =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> -CFLAGS_leafloop.o         =3D -g -O0 -fno-inline -fno-omit-frame-pointer=
 -U_FORTIFY_SOURCE
> -CFLAGS_brstack.o          =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> -CFLAGS_datasym.o          =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> +CFLAGS_sqrtloop.o         =3D -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
> +CFLAGS_leafloop.o         =3D -g -O0 -fno-inline -fno-omit-frame-pointer=
 -Wp,-U_FORTIFY_SOURCE
> +CFLAGS_brstack.o          =3D -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
> +CFLAGS_datasym.o          =3D -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
> --=20
> 2.46.0
>=20

