Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010070.outbound.protection.outlook.com [52.101.228.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424D381B0A;
	Tue,  6 Oct 2026 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280375; cv=fail; b=DOQrUMak4g331cgnmJnJF5MeQE5iF6qRb2HGJT0JUiLdI9+PWgmQXN22sUqAkxV3JLQhk5+ZQpr+eBRRkoq0oV8VvcOX+8AqB/NM9qS/N6hKpckSLjFxo1VYG6KgAwgWY/4G07MH6DAh4mzIsaJbNJ1Ql6hlMPllOlX0Ojmgufo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280375; c=relaxed/simple;
	bh=9LtM6fDlOMHIHV/WHTmMuN1kLHaqSOoD5Jx9567OatU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ECfqbXp6Ymt5DAMqWEzyl2FRsbu10m0SGQ8QHCJbpO9v5bykdFBG4dK1rqZlXqetrNLQ24ux4WBC5wp1lm2vxpE8c2sxr4kwuUkmIi7LKCCTlq8hTudn5fwZIesnU4lcJUYiHx4XtNa8zEK2Ah1rMYSdQurMPiXdtQxvPzhyk18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MRoYG5HN; arc=fail smtp.client-ip=52.101.228.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MRoYG5HN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thvUAigVTMEjFFQgTm/7lN/vqtaRgp53AHLTUDhcaZnqLBenXOCMUH1GftznhRi8f94CShOT4kVnWKAeWresRnRzEG/na6EoRnUJuGOIIHYOCbOSPKDEjfnGUBCRROxMjfZ5ar93BlsOQweiCBMW/A9XUAfNM6lCjVVe6gzkDDZhb6pgI0/gUv80tYjPD+uknH+10kf4u8qclM8HvTeNjuj0fCRkzZwTwX2qU6iPcy5nD4Xp6AUKFP5H4e7n3P4XXu5OwgF8R8GWoBOkauHu8yZ1OE9UR52EsVtbWGFgTiZ2yQwqsQb3E5a/98NRMkbUCZWHGCFEY4ZJH+gr6n2Pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3XniGZuThcHRW1tMvQ9dHj7oebyGCwGhH+t1bGUrQI=;
 b=AVhHPHSBW9a+4Tvb9jsO2RZyoK/c49asS6hF6V3H0z7I4sELoB7H2jWvRKi+810kGdh5rMOOm6mFASxYeNCRn+HDUoko29CtxkNZN4tDJHEDKLqhrEoTbtlr8jL2Mg/z9l5bB+tLLP3SRoQBOG6v0WE7fvvKGSFrZjVvNY05mtNPeq25nvG/fmvkv5EkZdiavOG5V+yaPsZdagw/XN1O0a7dZN7QBlVuRCZcD+PqG5lhLC8ZrFc6EAqkhp+mtuozeLMmp2/Hah7BCIRJmPQYOImdMiXvq+mtZiP0RgVFtRfpRYvFJKD1cAU6a6L9J8geoSSNhMtwE+t+0tNM0/SNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3XniGZuThcHRW1tMvQ9dHj7oebyGCwGhH+t1bGUrQI=;
 b=MRoYG5HNPHb0fWza5yahv07GtCKN/xfMl9T20ZMLbwpX6bAMdyqFCdDsXqznH9ikv3iM5GC8Yy/ocC9A3leH0BKuShUxbD26wB8FPTxyYOXM2uT/TGgTi01AHYerALYL1YcEeu4hMg/xY4+PpR/T4U0n7JATohRUt8/jXbw6mNyXCwNVEyNEZr43mORN17ZNxoamgosw1auemDQ6Wl4tl2O0hh+tFZBvTlojmfca6MREPYq4edxXRLGK7VCltkGWTcRBBsR2a/mds3fBF3At36zAg8JxXn/oln7ksKOfnwkb7trtQBOZShJ5J5EIcFnxD9dmVMuhD//jalEcljFQGA==
Received: from TY7PR01MB15746.jpnprd01.prod.outlook.com (2603:1096:405:290::6)
 by TYCPR01MB11956.jpnprd01.prod.outlook.com (2603:1096:400:3e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:52:50 +0000
Received: from TY7PR01MB15746.jpnprd01.prod.outlook.com
 ([fe80::bc79:d427:b0a9:a793]) by TY7PR01MB15746.jpnprd01.prod.outlook.com
 ([fe80::bc79:d427:b0a9:a793%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:52:50 +0000
From: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
To: 'Will Deacon' <will@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Marc
 Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec
	<radu@rendec.net>, "Kohei Enju (Fujitsu)" <enju.kohei@fujitsu.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH 3/4] perf: arm_pmu: Add workaround for FUJITSU-MONAKA
 Erratum E#030002
Thread-Topic: [PATCH 3/4] perf: arm_pmu: Add workaround for FUJITSU-MONAKA
 Erratum E#030002
Thread-Index: AQHdUli9ajIjaEgYl0+XVgJJHVc2p7bqMucAgAYYAvA=
Date: Tue, 6 Oct 2026 09:52:50 +0000
Deferred-Delivery: Tue, 6 Oct 2026 09:52:50 +0000
Message-ID:
 <TY7PR01MB15746A62C5592528FFDD45282E5952@TY7PR01MB15746.jpnprd01.prod.outlook.com>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-3-4aec0b0cbe34@fujitsu.com>
 <ar-nPJyVzPcvbICa@willie-the-truck>
In-Reply-To: <ar-nPJyVzPcvbICa@willie-the-truck>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=e03b4fcc-d58a-49f7-8b04-f6c4c3949f6f;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-10-06T09:48:12Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB15746:EE_|TYCPR01MB11956:EE_
x-ms-office365-filtering-correlation-id: 04cb4c0a-d415-4c8a-72fe-08df238f957d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|38070700021|11063799006|5023799004|56012099006|4143699003|22082099003|10067099003|18002099003|6133799003|1580799027;
x-microsoft-antispam-message-info:
 4HqHy5B4T1GCZyLZvAmgdU7yKomq8GXV145dWZr2l7BE2T00DCushxfZgFYWTPEZzdy+T+9YWERiZL0kwFOtRp/Qi5lKuWWp+0peDD1B+f7qHNpUZY19xQJOHdwrwQ7v0x1IHTbtKRSprSEw5UI8gqe/M93Y+z+UKVcAMpAMS9r5ThZsaI9Hw83ksS8vkLfJ4tsUJZIjZMeY7BAngW8ZxyRoHi4p8gc6AmkP+Ce9JEzAnPr/sREatTzCe7towfO8eHoOudxWWHmYwQz1mNRoRXlOVIu4ZeoIL8VcQQsVuO+9Jzg5xaNlkmIgiOL1Z5+5F8p+ssO4hL5Y6+Ug7Ws1SaurDuepsO0sVWUXueJ6/PRyuCv0FNhnmfgbPrz+UtpEyVq0OapPbh3guebltMytWi2Ss/5kQdk7u21EUS1rBH0F4hnMKWLzuYzdH9v2zI1LFXUM57pz9v4XNBI1GmsfVcoYwWnoY/TaZ56QClilHxZVnHigJyr5zH36cVhy8huKAKLAxL2iX5I5Ash+dT4EX4Jox09lEHN1mpPhAJUM42JV8oMCZqH8/N6oB03dTkYzKNMgSQVe0czLjM/jPsw4e6mVFbDKNMjJbq2p9foW3WP41h4q1idvpnJ4/ekP8IsZg4+p3+preOJ86XGEnrLGM00v8L27nVYJ2e7V2rQxWZBY+IA8f4o5ayC7Iv/QmMrVebLOYg/HzK6L2iK/6D2rLWVz5X2qjF9VnCoAeQRXEUlf9bboYAKqM1HmBmQHOdfO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB15746.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(38070700021)(11063799006)(5023799004)(56012099006)(4143699003)(22082099003)(10067099003)(18002099003)(6133799003)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?aTNKWjErQklpMmRRVFNkZDBNazJ3NytURy9pSTFaemlRVnNoZ0dQVTd4?=
 =?iso-2022-jp?B?OVFDV3IyZ2tvWmdudzVTVERqQXFPRzduVlE4U1p0Q1pHaU9UNFlCSU9W?=
 =?iso-2022-jp?B?ZnhTY3lOTWV0bFZjYmRLekk5c0pJSHFOaHlwZ1BTR1Z2NXM0QU1UWmFL?=
 =?iso-2022-jp?B?ck0vYzg1TXZ3R2ZUVi9KSkxLbmtHdVkzS3gwVFhxbERRd0tOUXp5Q0Vq?=
 =?iso-2022-jp?B?UGkrVW5xbXAvampibkRiT0V4WWZxY1IxM1Z3MXNrSWV6ai8vMnRsTmUz?=
 =?iso-2022-jp?B?b0QwTDJ3UnJsa1FPcWhud0FHaFRUeEVxRXBLN1FkUHBNTWNHN3JFQTJX?=
 =?iso-2022-jp?B?eXBIVVJpUmxiVWtKWFZyYW11TlBoaEJBbWVEb0xWbFJwSEwzZWVad1BP?=
 =?iso-2022-jp?B?bE9DZEY3dlppa0phVk1TbHhyelBnK200YWpoUHhxVVoxaUg4cG5NV3B2?=
 =?iso-2022-jp?B?ci9hT3VCa1AvNnZhM01jL29MWnNWL1E5L1RLNTNsZ05mUHdqa0Y3bHk1?=
 =?iso-2022-jp?B?QzBNVHdDemFEcUZIclJsUEJzc1Z3VFRpb21Iam1iclZUUko3SjdQQjZM?=
 =?iso-2022-jp?B?bDJDNzlQMFRBU2g0cHpjc2ZldHYxd2RxQ0ltMVlhd0o3UlhNUW0wMFdr?=
 =?iso-2022-jp?B?TzJTaFBSWWdBWWpoVytHdVJ0bkJyODJLSlBxY2RjT00rbDNTS0lnNk1S?=
 =?iso-2022-jp?B?RmtoeXVtcGVodGxVRks3UUZuZUE1T1Q0ckNVUXlRL1pLVUI3SjZTVUk3?=
 =?iso-2022-jp?B?UmZySEVuYm1iTnduMkhjd0JSQXhBQkZwN0p1TktPOU51ZktYVjhsUDlU?=
 =?iso-2022-jp?B?NVJDSVU2Zkd5dDVyVUNMNHdzN1d0MzluZWJNNXNZWTV5RGwwTFBiU09x?=
 =?iso-2022-jp?B?S3JVSGlsWkE5Sm9ISXdqcFFiVUdpRjRwa1dxOVpCOXBVcVY2M09WbklU?=
 =?iso-2022-jp?B?cUZ2Q0NYd05FNkcyYVgzMUJscUEwWEUvUUpVaFFnSDNOVzUzY2JLNy9v?=
 =?iso-2022-jp?B?OGNqcENreFV6WE9ENzFDQ2xEZG5wM1JEM2hYN2ZqQkd2eGdsc3FrTzdY?=
 =?iso-2022-jp?B?RGQva042T1NqNDUyUzRDZWVNY3c2Wnp0NGxNZzRCdWJPQnA5NjBaZ1pM?=
 =?iso-2022-jp?B?dWVpeGwxMm9SYUdVbmxZMnNkN1Jsc1ArY2ZUMDIrUWIyU1FUT09oYXhk?=
 =?iso-2022-jp?B?aWZ0Y0xRVFVOSVU5WVZvZTlvV25tWU0zdzMzNnJ2aFkyRFQ1T0M2aVI2?=
 =?iso-2022-jp?B?QlhxOGM5aUp0eW5teEFaUDJwOGJEdUZPSVU1VDFUT0plYjdLc05hZk1a?=
 =?iso-2022-jp?B?RjIzMWdGTkQzSmVTWXpsSUZLT3N3YVBJSGtZZzBBRlpKMGM1dFdnUTRy?=
 =?iso-2022-jp?B?eHg2NDl2UHJjTUxMbkczOXA4ai9iNzdTTmhNMEl2VFV0eWFtdmNmVWQ3?=
 =?iso-2022-jp?B?UWVVdDQwdWZIMTVJWjVhejVVWldRU2xzVXg5MTZrb09KL1RqR3BDeXZ0?=
 =?iso-2022-jp?B?Zjg4YUdIT3E1QklkQlRwLzFrdW11RGg1UEU4TFU5bnNNWGRaSlpKQk1L?=
 =?iso-2022-jp?B?QWlPZENVQzdveGZFMlAzMWJadXZKdUUvcGwwTUo4L3NkK2IvOFJ3M3dI?=
 =?iso-2022-jp?B?UVpIRVJ3UDlTZUMzQzF3NmVCbnFaajc1MmxIYlN5QkxkTkRoaExYd0dy?=
 =?iso-2022-jp?B?dzh5YWFTNHowWUNCb2xYMk9TZE1QTXk0N3dKa0ExM0xmM2pmVStJckJT?=
 =?iso-2022-jp?B?ck54WDhhWlVzbmJ4NEVFbStVbkovMU5SZXhuaVNDRkttSFU5QjVKakNO?=
 =?iso-2022-jp?B?eEgyV1pPOXQ5dEwrMmZXTVhvUmhTcjhTWFJQZ1JsSHZQSDZFTWpBTUlT?=
 =?iso-2022-jp?B?MGxlM1dzN29YcWNVMnJTWkxBbmFnVjRlTGdyb25ZcmVGRzdnQnRWWDJs?=
 =?iso-2022-jp?B?ZUZ6UFQwNzFFSU1rZzZkRzZVb3BYRWphVGF3L051MWptWDliTmhSSEhh?=
 =?iso-2022-jp?B?Z0hvRkpXbXlwaUdsUFd3d2tjSEZjV3dwV3RmdEdpdENzUXhyNzZzMmlh?=
 =?iso-2022-jp?B?cktobzlNd0FkbnZPMko0Q2tzbEtNUEU3ZUlONlhZeW9HcHAwSnNYUmhi?=
 =?iso-2022-jp?B?MWVjYzdLbElpcWxkRW9XRXNSTEp4bFIvT2Njb0ZKcWZGRFBSVDNVVlpt?=
 =?iso-2022-jp?B?b05aaXZJVEdJMVQzL1ZvOVJ5enpXd0U3V2p4MlRYWGUzZGwrMHNYd01q?=
 =?iso-2022-jp?B?MjlhYkR6N1FQay9sYzdSYzM4eUxjNWpBSm44Nzd3OXFQT2dPY2NpdERj?=
 =?iso-2022-jp?B?TjNwRllrSG45ZGJwdkFnNUZJa05KK0VQQ01KUWlyM0trQloyM29WdDdY?=
 =?iso-2022-jp?B?YmY0ay9vN0lYZmpTeWdxejBxNlhVQjFmaTFsMjUwdXNFUkVSczArQ2Ft?=
 =?iso-2022-jp?B?VmtXQjllZzNjMkp6dm5MeExtR0ZSSzVRSkJ1WVJOOGhKOUJ5VDZTTnlv?=
 =?iso-2022-jp?B?c29sYllGd3loTXlsM2phSWwwR0lNeE1BQU1YU25reDk3cGNOSXdmMjV6?=
 =?iso-2022-jp?B?NkkrOEFuUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	r6Jcgfho4mz2bYnRsfT/SlRwFwWVlgyg/PJ/Y0UqQog/bTsGE10vmClcvJYDqxk/ccGlz7qqF4OhoVRXyT8eCiocwXEjbHIGmP/VFFaiX7mUYKivKihofZ7z8+9hr/bnfyqCqz9kMWcqd3TUM5R5qFbEHhHOBSk64p2LN+UnmeeYF5ou1j4XhsIO5oWrvuVmf6+l2Wke9JA1Ujh6L+6rXmFoa/WKiTTQ7o7XEfnvJfjzx4oEBTwd5KIbs4P0YpkUupDG0WX8ZHhf/geWfXPTNYBKpHG14qRjEd9ELvgeDxdIP4NwFNTsf4r3+kvE7hpLsuch/8d68Ea9pfMKEPvHzA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB15746.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cb4c0a-d415-4c8a-72fe-08df238f957d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 09:52:50.4993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqn3qe4TybGLU6nbrknQNbGQrZJxH4pxPvcMh9R5dzwThjBDemp+7B/IxjBdnmXf/LXY8bVr3IBplPyZBXz1vxSlvxKyUORZt+TiGFSIciY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11956

Hi Will,

> Subject: Re: [PATCH 3/4] perf: arm_pmu: Add workaround for FUJITSU-MONAKA=
 Erratum E#030002
>=20
> On Fri, Oct 02, 2026 at 07:26:51PM +0900, Tomohiro Misono wrote:
> > FUJITSU-MONAKA Erratum E#030002 affects FUJITSU-MONAKA CPU.
> >
> > On affected FUJITSU-MONAKA CPUs, after a PMU event counter is
> > stopped at a value just before overflow, an overflow might still
> > be incorrectly detected, resulting interrupt storm in some case.
> >
> > Work around the erratum by avoiding programming PMU event counters
> > with values within five counts of overflow.
>=20
> What's the user-visible behaviour of this erratum? It's not entirely clea=
r
> to me why we need to do anything at all.

In short, this would cause a softlockup when using perf under certain condi=
tions.
Let me explain.

The problem is that an overflow interrupt is incorrectly triggered regardle=
ss of filter settings
while the counter itself correctly counts events.
For example, if the following conditions are met:
  1) Running perf to count an event in user space only
  2) The event can also occur in kernel space
  3) The counter value is set just before the overflow (when using the -F o=
ption, initial counter value is -1)

when the kernel is about to return to user space after enabling the count,
an overflow interrupt is incorrectly triggered by an event that occurred in=
 kernel space.
Since the counter value is not updated (correctly), the interrupt handler d=
oes nothing
and returns with the same condition. This leads to another wrong interrupt
and results in an interrupt storm and eventually a softlockup.

I will update the comments in v2.

Best Regards,
Tomohiro Misono

>=20
> Will
