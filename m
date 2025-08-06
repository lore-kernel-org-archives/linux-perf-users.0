Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010021.outbound.protection.outlook.com [52.103.33.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AE207A20;
	Wed,  6 Aug 2025 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460585; cv=fail; b=mrZVpWOfwNCadYl3bQuy4Ak+4OHP2nF5lYNc+jitJ1rSq0ddBprXUwjzbvvT8TIMS0tg97Diohbua6z16T2JeFKGJUmZhSz1ZPyd8Gz6wcR5K3M95BIXfI96vhGJ+Lme1Sbb6Ej+E/+dTQQjeNfoK6ZK7pY1C2x1oi1TSkSzXF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460585; c=relaxed/simple;
	bh=f9BTdT5zdQ7qzQ2spY4Vj6TGwgnrYRImE7IiC4nz7iM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N3MAICb9u2hd4hj8pabOa22McOUuxo0kEApRqESSRm1qpz///YAD93ZI+qP5qe+PAGYd6X/pLMnLfijc2f0/3bEwHNZAS9ZnjoR7GuszAuesplWk/5AqleIinYWz6SZNbrkFjc4GZEvUELyRfvtLkIX/Zg0OwwYSKLq9vGe6syY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=kZwUcfEz; arc=fail smtp.client-ip=52.103.33.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="kZwUcfEz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQVHvu6jqOkAplh6gEH/GCDWHUD4c7If3CCqC6r9g9ecIyg/SyhlpJ8n1NHtmwazWAXiWZKsK0hRevb2V2GRCTtow9YQNPwlUe0PFMnIfxjuNqHkIsMHkkv6Hetgrnrv3bVwSb8txYup4tr0lpoPU4sGUaJO3+c+xcQYcVtfIxP5NKcEqJ1JSBocWv9TsVZvj3KH5+Qv58xNHzjRh45vIJbwKei8VmlxINZta4dcT3Vi8/zkSeGDPAy3Y2WUz97MtYoL5tRjRJl8ZDh/73cCEGWoBXzem270ZeXSIGGWejMdMA0Rf/nCbtkXyaDX8T98nUHqQ22rrJgyIo/fdfaPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxWq2uSUdn2Pc4z0yqPrV3J13BQHw4S+Yt96EN+Qha8=;
 b=Rm7GXer37WecflLHudtAwYBAs6LNTX/SQyevTMizFFbdK+IrLEAvEDNSGYoBnOlPYM06xAOE+G0c4iwkIT7n627cyTzKAFrqdR4PHOIXlS0MeRTzqirlp6y5JzYzTooAWRpR1dJ6gp2lqxCqhR9WoNBJQjPD/Zwr+YqwqoxPFvsOGZX2Lk4YMrX829AKnd84+qfp+8rjOXRYIQ4yMjt0dnnhT8tC9CKXHKpHGhPNC60SojSDirIa4nRW2plrUG0oxdbYeRUJ5iEFlhaRGULM8j1USlQy6U3lQaLKaYB84KMmGpw8IIU7+MQW9RbJWTzf909ifz5ktRmSzGJbImmciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxWq2uSUdn2Pc4z0yqPrV3J13BQHw4S+Yt96EN+Qha8=;
 b=kZwUcfEzM40bT21bKwchRyaicEBBmePJ8uiTTELpgAxL7YViEywe84Kn/jEOCBKkNx2ht42O2WwC++ok6u0jkjfw0DFX3mZzvTLTmx1fVeY2qMzc3EgxYd80wvvdQhCuCAfc+bLQeyzyxzdAlB54e6Djme0qLhRLTuxdTVsGCZRR5Ti+TZlRZceu03lGOxjzIJ1xvHZc46SOAUX9bDhh8X9f0JkgN2B5kdoD0soL82VndR5fe0Q4LSIMcKiiSSpg5aLcet2Cu6GyJ9MMkxf/2jNW8aDjbyGQZHQ7AOZ5IKFhCzoKnfKTUvUuWDh6bOVV0rpNX16KF+aZ+vfyMo1ZLQ==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by AS2PR02MB8789.eurprd02.prod.outlook.com
 (2603:10a6:20b:550::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 06:09:40 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::5556:4de5:6245:a3c]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::5556:4de5:6245:a3c%7]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 06:09:40 +0000
From: David Binderman <dcb314@hotmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "irogers@google.com"
	<irogers@google.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-6.16/tools/perf/util/tool_pmu.c:242: Pointless test ?
Thread-Topic: linux-6.16/tools/perf/util/tool_pmu.c:242: Pointless test ?
Thread-Index: AQHcBpg9E5AKwgPdK0agL0hVJ+bmAg==
Date: Wed, 6 Aug 2025 06:09:40 +0000
Message-ID:
 <AS8PR02MB10217286997CFA78F802121F39C2DA@AS8PR02MB10217.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|AS2PR02MB8789:EE_
x-ms-office365-filtering-correlation-id: 66f752ac-7fa2-426a-3678-08ddd4afd4a8
x-ms-exchange-slblob-mailprops:
 4VtScROZs21qKsZbQ/+3hOXi8TYtpWnwA1urBHetdbAO3imqI84DLEqMTTCw+Lc/vCg5o6g0FLhAw2j8p2w3O9jeS4/YiL9rHrebnKim5hdSWylk9gWUp7HmRUIlbSKg/LlxvDefbhoIVB3u6mmzLJQQcpMtT40hKYKCUV2j4t2DzIEw2tL9epMo3kp3IYm2ZH9u7PyorxoRBHE67oZlfmFPQJAjBVV4g/lqjeu/ivhyvMJhGI+DW5PiJ7MdNUycnntdSshWeA22qintdRo7LRYGF57Iv5FAtpAWUrcJ24DQVze/nRJcr64MjHtU8KihvKDyMzefO7O16VpCFzHWIvFrQ7b4yBOBy25rX2NOYVntc2/6ilunQhOwwO8chdM/khZY/KL5F43tjnfXnE0xRpRrhaAtPi3refFGdtvbs1KoBUOLoudzX74Jq9eolHr2PPIY4l0wruZEVrsDf92SAO+MOtZDmeQn5jTdl+fEo/ymmNUu0QNRRMgA9+wXHz9quQybpH69E1+NlDQCWMAvnTIwRVCUEeBKsnKQ6ce3WdNrIQjc/px0am/TcMdXGBRmcBDI5lv/RBY8F3NZRb8VnCZQFQKoMQWqgnPOx1600cFwSn9iu4iYLPz2s4Ii/QZFAyS4Hr+zWgYhWdY8Kkq/7ngtlmDPlDSeQ4C2uk2JQx0GL7VwEXA5nw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599012|19110799012|15080799012|15030799006|8060799015|31061999003|3412199025|440099028|51005399003|41105399003|40105399003|39105399003|21999032|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?aAHLoJWzAwx7IzSRh/ua1jMEfjCfE4MkCqYElwKFm+0tys25aLfUG7o1P1?=
 =?iso-8859-1?Q?o+rX3275L3GPpe/fsxfW9iH638cXNrAMtKlb3mUChNsUZ7TLVylj2ah04m?=
 =?iso-8859-1?Q?5sNJPwcDnnPcHusViWIQkx9jzoh5DaI11WOtpzD1DGxJPVAcxxMKKGNuBW?=
 =?iso-8859-1?Q?2ehJ69kXSh81qBlPjnxqvzz5XSimCaAuI0vhAM04eaxGrWVAI9TYtpWg26?=
 =?iso-8859-1?Q?tyDWhR0nhGevryVTwwEK5eHCRY9EzDxmSiwMxO49TJt5II6dTHqJBdsJTx?=
 =?iso-8859-1?Q?1qJh+znwu1/Tv5IE0NjsuiCy7I+01qmzVVi2xJrr9tHRMVtcMvkixIxpJL?=
 =?iso-8859-1?Q?BuLsH1Avn84fAojZGI47W68427meKoOOD+7sdIA49Tnc2VrBbWhawOj9kp?=
 =?iso-8859-1?Q?I2XGEOPc13FOSoOfYsSsNsu+6J/4n8fhHO/nMMcH6xMujB/7Ajs+oF7tT3?=
 =?iso-8859-1?Q?K0zD+6G6gXD+dAF8Z3jUYDTdg9PZ11zTim7fVEEQXDEOswyN7WTaJzFXjx?=
 =?iso-8859-1?Q?pjFNMAty6RFKFZ/KvK7ZRpOGJJ9Th4d+few32pzFLPMPlAm3RAmo7HKIt0?=
 =?iso-8859-1?Q?Mym9UvQFOnWegedAQK/jPQyL+83P61samsk7w1sV1+91i4hN9EBEZDaMUK?=
 =?iso-8859-1?Q?EjuB97Nnre+U1U6bhazmarIJTEbpKtVlmfP5b3MJaZLJuEG7ySGs5uOHdU?=
 =?iso-8859-1?Q?IIukYGxgYFfHwHkLXtdVX2AGFyjNLk4VeEojOlrgbyrhMx604PMszzlfkR?=
 =?iso-8859-1?Q?8zk+63EuYp7mVS2xF7+mAY2DgFVkp4YWoM3oBhF69d3f+JFeROnn4eWM9F?=
 =?iso-8859-1?Q?qxV3F0CZaXk7PSP4MpvArQtXu4j8JM+NNia+UlIc9VMMTDjhowrc53zW2C?=
 =?iso-8859-1?Q?2fS8Bzq1F8x1uTLZLJ8EqzrZak2aI5aARWVStzFvSPPJ8+ep1f77IOdTvR?=
 =?iso-8859-1?Q?gwXW4w3C0jHr+qMTxpfVDfqWI9AWz7TlHx5J9Kn7f1tlqsjpMQxUdakei8?=
 =?iso-8859-1?Q?rTdmYtzupayC9ISTnwJfe7Lmdk0ROzIlqmOOF8husZRYCFcd5PlpDQ3yQ0?=
 =?iso-8859-1?Q?rjQvLJZxMVkRH4IwXqblMUL90Xu33OOtZYyFgWXTVVlQr0AE5tUyJcdWGk?=
 =?iso-8859-1?Q?2RMWLMZvhpykq4+wRMVV/rm5WZ4n7V05gVumwTp5rVu/Ma2sNj4k3xFcaF?=
 =?iso-8859-1?Q?okEN4fXy4NZ/FYjI7hAmWY7rJ2SiQDbTRM4PG6PGyK335pjnd/c+j4KlHm?=
 =?iso-8859-1?Q?LSXdl936QUyfkvDOZTaFgLzqWEkHY+uJs21+M6sy4X4qQ2o26f9RXN42yO?=
 =?iso-8859-1?Q?3qtO7CJQUd+CxSx8o3sylYxzaA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8foZn+4NIoJ1TR/6QjHCmrWG1X1PyInBLuUfqnti6cNhhX8HHj0OhYF9Rw?=
 =?iso-8859-1?Q?aA+NZZ+VdVN0QaS+fD0cWF+1xyQdln6lGcEM7+Echcm0WxvuAAfwwVA0DE?=
 =?iso-8859-1?Q?98lffQJyG3PzzRs5wlZ0x6Q9PCDjRvASxqelJGgeWRAirfjgTfDWTM3gb3?=
 =?iso-8859-1?Q?uJHGrsgSCHRp5DZIush5qrJ/nlEyfGMs9tJ/mza7D4s6h+j92t4V6682NR?=
 =?iso-8859-1?Q?3Qi3NoOsO5JYcXspxh0l8hcQuGdB8O97COC2ThxqY77PPjVHpYsuAmXoPC?=
 =?iso-8859-1?Q?dSJgVpnJ0gPJ9galimtjzE7ay/Ql7Sx09gRLHjiRy4vj3ZZmaPhQHd9w5j?=
 =?iso-8859-1?Q?tgkIu/fAgcQdeAzA4u5SaidaqKe+QxPbkmqdDmgjp4ToQ79BdZXM4VlC9N?=
 =?iso-8859-1?Q?Zy0YXcd9iQ0xpQ8/VtPaL7qET9qrUV2MjaPJXHw9Mf2WsXT5p8NlPQzUwB?=
 =?iso-8859-1?Q?rlr2isdRmzl18Vh+r0+1TdF4/NsnU3P6EFFv9DRzRE5V/Idj2gv7mVK9sy?=
 =?iso-8859-1?Q?8kVnq961JrKYkfmAHJ2zUIoyC4/B6V4OkTKJeW48XZRTxO7Zbd22aIELlx?=
 =?iso-8859-1?Q?CCyLNGSUddJiJfSDr/3xNF2DDCcKWRaa6/0WV/Jhn1iX3hKiWoaNsOaygW?=
 =?iso-8859-1?Q?e2I8UvLbnJIA5+RK6bgyn1W0eTOZu8RMtFKGz6+4Tl/ZyPt3/i+u6mc0pY?=
 =?iso-8859-1?Q?H66ugeGmkAV9lQ4cAHzQ+e8/Pj9OTwbYUrIxMzX9ovCjoacfpLApe6wBtq?=
 =?iso-8859-1?Q?5bmkKx5w6P75tvgAQiPRzfjUPg9WVmR+VNL0aCQU5xYHPheVdi3BXyjJoN?=
 =?iso-8859-1?Q?dvBUfmJ2fFiMuMhs02dq78Zn4q43SwuBcaaj4FaBgw0EkNneUoKvePAQeq?=
 =?iso-8859-1?Q?iwMlYnAppjtp6Jiys6CtysoXZnecqNjqqJ0b6xpoHEp97nir56KPeDmIht?=
 =?iso-8859-1?Q?ocvJrx++BFmYw1QHMw2luO+xvdPC1qT6m7BrGeMpT7xTPMp3zEd+8JpEFK?=
 =?iso-8859-1?Q?9BIR+HcH5jklYJdqOwnsVP3Lt72CkVNnoh8KG9WmHyfLxqaoURkSeqVieS?=
 =?iso-8859-1?Q?M4g4C9q/mkXNHpjuv7KOwCm/Y7W8tRXD87Cgw7bqGv0zXFmsIGF0qdNA75?=
 =?iso-8859-1?Q?Qx+ENFydjlJAdakcp/QIp0YH9xAIgPZknvkaT+I56Yux6Q8Wh2p2JvwII8?=
 =?iso-8859-1?Q?IDT50R4vDP0hGqTCda3JYCdXggb0buheP4ZHmftJnAL4pyAqcWI7BBuknQ?=
 =?iso-8859-1?Q?nLJ5kKQ9ppQ/xVVbp9VQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f752ac-7fa2-426a-3678-08ddd4afd4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 06:09:40.8506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB8789

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
linux-6.16/tools/perf/util/tool_pmu.c:242:15: warning: Opposite inner 'if' =
condition leads to a dead code block. [oppositeInnerCondition]=0A=
=0A=
Source code is=0A=
=0A=
        for (thread =3D 0; thread < nthreads; thread++) {=0A=
            if (thread >=3D nthreads)=0A=
                break;=0A=
=0A=
Suggest remove if test.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
