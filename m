Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6510F1;
	Tue, 31 Dec 2024 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735653798; cv=fail; b=iidrEN1dvCwvJCtWInGT+deg+GkQ9R46LBHq6W8LQxbMtAjnEyoAYqqKAHTDd3jISFQbSnZ8D/JYvPpgdGCaTW0d9ottmcNM2Fr6DHlHZ5D5ussGAhwWR9BKrD95nDwwfz7z5cv3gPSM7ntuNHZBl2A4mxiWCpkVZVw5UIrjiDQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735653798; c=relaxed/simple;
	bh=KMDuANt8jjAqwBO/3VU7+CvI+7QBmGQl8gG8SeURe/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eJnlHmpXDR2RqnCGo3m4CMm/sW0YHMbdmULCiVRlWEXdEQvDmcQfl1M5rU5EJjsorDx/tdvX0fFcZ/PcfaTnr0qZ7htb4iLB8xVrgiiddhDgutZAM/RXDhKiTN1Xos8iHNeySxi2C0S1iayPYYvLg0e1y8rCF9u0zTPAWra5swU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YSTH9fe6; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YSTH9fe6; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YSTH9fe6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YSTH9fe6"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yS9BIl9hKseZC00G/Qc8ztNB4paqSHcBaT0G0p1XCFC/M9tjaVnEHJg8z+UDVH/mlvYPbfkGYk+k08cvK+Poq9BGzn4rdqXIJPu9PzasHBIFujgfYErSZwfDzSpVOe6np/f2S7yAmFbpvtEmJCnqSvUCndBf8ycEtA1+8lxVV/kQlyfAmmcgqMrn4mflwLgDMEhv6IkCoj4Xrneg7rRFFyGJQF2OGqx35JaVbwqBOb9BbOlLhQZwJ2u1bejm7hv45wBBebXb8n0EGLJQ3+Ph2P1kOrYr7MdZPlMnQ2LbwvorETSrEoAo/KVjrap7M6IPhhZRP+TIUpqVTjtwlhHKQg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhAbJSRjxdpbGmDuWGr+CweIoC+056qBOj57twWsX2I=;
 b=O7t0pub1sNQEDMc4T/HUpfTnV9xflV87l2oeO2De02HLyp0YdsXgXCyfyGaZ8aHgt7nYo1NBS/TgezLdDVPEIrjrDRV1wK6T45iEi0lv8EelGkbiq1fCBm8vfv60JbZrqMPGWX8t1Mq6Qomf0Fyxg8UD0t7ZdUMRfSk5OTNBuWN1vHqbyVYTrsIkVYdo41rQRVP1RokYr6tDW0u/cRnBY92zJQxzIeSqnGcovyMpFLk1slKV1nQoHlaPntyeoAk0z/QtGQNYXa4vhMHncoKjGq8/fnrlIdIsHA1uLXIqibfviv00oc4XKWuz5902d2KP6JKKHU0+ATW5bMuG0a0zdg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhAbJSRjxdpbGmDuWGr+CweIoC+056qBOj57twWsX2I=;
 b=YSTH9fe6nYBEP+pBzf5xRM1UqlYziwLKhlqOfMX3NZfqa0pfHkj5sIt9J9ZPyBv+OAqZwNIodaZgve1kKxBXAHgBaer2zg2pyl9Z2jdms3cs5Q9cHp+g8SN7W7ju06B2WjnsP8JrjC31uhTrzZHma+Tx7OKE00YJ791yV3nMJkE=
Received: from AS8PR04CA0120.eurprd04.prod.outlook.com (2603:10a6:20b:31e::35)
 by PAXPR08MB6718.eurprd08.prod.outlook.com (2603:10a6:102:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 14:03:06 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:20b:31e:cafe::b7) by AS8PR04CA0120.outlook.office365.com
 (2603:10a6:20b:31e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.11 via Frontend Transport; Tue,
 31 Dec 2024 14:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.11
 via Frontend Transport; Tue, 31 Dec 2024 14:03:04 +0000
Received: ("Tessian outbound 867970499bdc:v528"); Tue, 31 Dec 2024 14:03:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c25c38b59106d6d5
X-TessianGatewayMetadata: 2uUc6bzwSlwJUL5L2bdzUrHuecVnsO9qN5O2fYksHsvEOZ9yJSMz4RZcmNdgSKCKtk2Nu/3dbBWPR6089zOkUu+LYBt4w3nbo0ibhE6mYn9ypIp6VYNkEWTyb737Ttl0SdNOFChio8wnvXtft/z+6hmDB40ZHXbabiCRfNRlMCLGPqnw0QjNXktA/ci70S7AF50NW5TZnxty9uaeSNi25g==
X-CR-MTA-TID: 64aa7808
Received: from Lf2515ebaa09b.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id CEFB5B2E-D8E8-4578-A9B5-93CBF9FDDDE5.1;
	Tue, 31 Dec 2024 14:02:57 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf2515ebaa09b.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 31 Dec 2024 14:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cf0Wz5bFKSCxZ8XiA89dQrIF0iyJGImKX7uy37VW2XeLhR+/l2SP3Nu8llJIDjj6zaU1Kq3/tmM+MTbAXzvGf684rw3jv3yIBii6YQg62e5fXx3s8U2dhp1cmXMf9Xzub5Dynmgr9FpjFoHdD64tRGa2TOGAA5jqCc0bPHm587FdUBHaRAW6dLTDiQnGZOITU7R+PlKWvIsgl6zPlmI7Uq+kJJ63AyVtJ64A1IAop0AkmI/td9v5RT+hKrOA/goOGpDygaPi0H+BOopxGprkNJTR8z0JA92Uf/ryaWrw5au53ejIg4eE2jscNthBJxK59Mlg1lPTmNzAlQ+NuR1/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhAbJSRjxdpbGmDuWGr+CweIoC+056qBOj57twWsX2I=;
 b=v3YBHYtfqX2+cGi5nyIFZN7yr/JzLn0+R3dD9bYPM1Bder9AAC4o5QEe/c8MT8kWQ9xoni8jF65FEXTis96iG7xuYlpcWj0v11O7GEqWvN2WidHXc9TIKC1Zl55wKIkDWd0w6MWWvlGliPKTF+cidskGYn4DcCiLUNSXtkS34FESflowAJAtZyJRTZ36K1N1AImNrsGot0GkklrmUmUGxKYZg+5HHnEIaGd5nXIJOZI1SntskdCZE3sdclZYxVHVxRR34jKIHwSxXG22STPbUgF4+KX0285w8A2BGhpPrsxOraMzOlWlRoAy3paGDE1NqJ0ms9iHjg/nfSxJvcAeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhAbJSRjxdpbGmDuWGr+CweIoC+056qBOj57twWsX2I=;
 b=YSTH9fe6nYBEP+pBzf5xRM1UqlYziwLKhlqOfMX3NZfqa0pfHkj5sIt9J9ZPyBv+OAqZwNIodaZgve1kKxBXAHgBaer2zg2pyl9Z2jdms3cs5Q9cHp+g8SN7W7ju06B2WjnsP8JrjC31uhTrzZHma+Tx7OKE00YJ791yV3nMJkE=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB8181.eurprd08.prod.outlook.com
 (2603:10a6:20b:54e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 14:02:50 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 14:02:50 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] events/core: fix acoount failure for event's
 child_total_enable_time at task exit
Thread-Topic: [PATCH v3] events/core: fix acoount failure for event's
 child_total_enable_time at task exit
Thread-Index: AQHbUv68XCF/XfvinUO0+frjmXZgxLMAc1GM
Date: Tue, 31 Dec 2024 14:02:50 +0000
Message-ID:
 <GV1PR08MB105219E653F1BE93C055456DEFB0A2@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241220164628.1079271-1-yeoreum.yun@arm.com>
In-Reply-To: <20241220164628.1079271-1-yeoreum.yun@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB8181:EE_|AM2PEPF0001C70D:EE_|PAXPR08MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: f1de3835-4a1b-41f7-df1f-08dd29a3d85f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?21xKkLTxFETSMUK1JMqebw55HuR/yafIr58amd3MNYZ8z7zL7wbVNxqrxE?=
 =?iso-8859-1?Q?VA0wNt/Bztm2k6S5ik+raPR0Ot/Tj0hY/StS20nw3soPPRAW1KlNlZ0Nd5?=
 =?iso-8859-1?Q?/999/lLqdtHWKBb+HZMDYe6AKsV7esPteka340L95WOic63b4R+yw/SYZQ?=
 =?iso-8859-1?Q?TZxo8wkZR13L3d8y1VQfsV2kDBHq6v0ib+34jrUGDy+NCiqq83tI//PVTI?=
 =?iso-8859-1?Q?ZW7LxcEcxn3z+X8J6vsorViMAq6r49fIXxzO2S583uZDbRX3aV9wAYObYk?=
 =?iso-8859-1?Q?mkO9sfbAOIypkBHTajA1VNtR9DHKRn8YkSEQQ7yUxIJPQC8AiREWiUJYJl?=
 =?iso-8859-1?Q?l7I8hbulIAWv71660zU5uSk8bRW1v/3uMhyU54ofz7DG1IPTPezZpO57Hv?=
 =?iso-8859-1?Q?3r03tBwHEFgxg5id++ovYJroSihPvNnrlQmqL2FPnM6a57SV/z4LDf27/q?=
 =?iso-8859-1?Q?fNyxWwBAJpd0+rbJ4NcMVpV927/UBWYRzSrUMjuj0afEfeMYayu35U0NAP?=
 =?iso-8859-1?Q?8g0eSZZN/jpGSgoKnbd2XXiiuKtVbFxUzIEmU5lle18YK2pBJLY0qxkAPv?=
 =?iso-8859-1?Q?QRibJ6fNcGrzrxX066BSKWcYl01eqBFpCCVn36I7mHwMdadpN9qjIzDniQ?=
 =?iso-8859-1?Q?E7U3S1eESEGLouI2bsbGpZG5a+TIn2I/9PWgU45GjeRP+FojJTLZSTBn9S?=
 =?iso-8859-1?Q?sxwra4TdnGnDPxMw2s4K+wjYUieq3cWgXzojyGjqtiMTBe2DzqIGvu77xb?=
 =?iso-8859-1?Q?4FfdmFaunjhwqYGGkkVyhyP8l10YDcOuA8dN9orknHdt8AVX0ezl5h5fkH?=
 =?iso-8859-1?Q?tuQp8eWvu191MPqk4uc/jkToc+1XYLpsuMJUP1R0bXGZNx8GTIgcIZCkL2?=
 =?iso-8859-1?Q?HKvGYU/SPsOVqyhosMxGswCzK5sXarPzWtYGyG01AF+vdlZn4Y3IFK2FAk?=
 =?iso-8859-1?Q?J3j1wUDjqS4ku4Z2yYYJhQtJ2+CclPWIK1xGPXEjy3jqZbixu//E1iLO9d?=
 =?iso-8859-1?Q?muAm1fnIrpsgrFxkAsh+sIJiZS4Ip69oEpIn6WpXz9ukGKZOr9KGz173Oo?=
 =?iso-8859-1?Q?6ZuFC28MaG02qcyXeLbJBLE6ru0U7NFt0O8OorbyvW9dc3kCdo5yE4i4sQ?=
 =?iso-8859-1?Q?VpEwm66laphlo0psp6zkx66Z7WZdJCjGsPrQVze3iKioyjcfWY/hsZDvCX?=
 =?iso-8859-1?Q?zU31BwoyOcfFPH3OoF3n3jRFuetARnSdAgHzjKpmO8Kka3N3yJpGGtZO1m?=
 =?iso-8859-1?Q?IuVfWXazkYWYqRWTe6cmAZzUSlJHJI6ao6lwJfKGPmjMFL2hAuOnjakOQ6?=
 =?iso-8859-1?Q?wUn8e8vezIVmGgOvVWbLxV+SIayTxr+1MXc8DYVh+oHrQ/Z+ZQ2mhSsTpS?=
 =?iso-8859-1?Q?RrJO7WaIUhywz46PoPJaOds99Y0BJ85LKR1PAzTB0Ldft4W71htspDJC3S?=
 =?iso-8859-1?Q?qsAWIqBmcv26xPOptVIoV20Dp1FDfk3o28KXkq2XmkHm9d0ogNv40EqNDd?=
 =?iso-8859-1?Q?GoE4gk8LHDD6t0Ctadiv2NPBMuoIMB8MPboBTwLN1ZYg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8181
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3f078b2e-3d56-47b0-3faf-08dd29a3cffb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|1800799024|376014|36860700013|35042699022|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?cZ6XoDIZsEpIOBJlQOHiJCWxonUxDFApM5V/l5fsnFcQFDJB1WNBJmdgtJ?=
 =?iso-8859-1?Q?5r2jE8S/gHJ0jZceymBBBv18sfXBHjIfo9F559Q2/5QGCIRUOFpTi89TI7?=
 =?iso-8859-1?Q?Ib3oDZv6CPwvZ283He5PWt0BucVJLOT/W7kOxcaLbsXh/SpH2BJBPmWh2m?=
 =?iso-8859-1?Q?sy/O+NmonYWBIH9v0BxCQqksq9heAYokCoEs6f3UM6m6FajuDwGEUfrQCo?=
 =?iso-8859-1?Q?JU8KM1wCMGuK3neKFvp60CPFvcvvp9WbWFU/WbMtPY2SZMuZM8H5WifiB4?=
 =?iso-8859-1?Q?2dgYuESQofY1jRpka3SjIkeaiMn6TC+qeY9o4b2KrfAFOmPp+lgxMM1BV0?=
 =?iso-8859-1?Q?ppdTrDWhaVMuJ/NWTW5B+QGCj+dqfjQkcAqnxQ7oc8pIUnQw9zHThFEvxg?=
 =?iso-8859-1?Q?ZVQ/27XYalIpTS8JxBQAlhIyBhxxfOSdDuoX0/GPynYvmF/gZR7ar81l0T?=
 =?iso-8859-1?Q?hDl+MFtL804Z3rV3CLSL4lPAvqeKzDPeqNHfhWxAWBjviOceVry/4hxbGB?=
 =?iso-8859-1?Q?s+jmTk+CrC+BIPlX25tllOLsK9bzXGn8IaxP9s+1N21FG3aSZnUJ8/JkJL?=
 =?iso-8859-1?Q?XU7+TXBJrZRjo4n43sgJTv48V1XwvS1NIsyH2IgdrP1CUG4e4dvGh4/hxa?=
 =?iso-8859-1?Q?OpKi3+UPe9hQByYev5NwysukfJnawWu8DyoZRoKT+Vi7VHxksRPwq7GJxB?=
 =?iso-8859-1?Q?5KYAvQFQRw50KU1dhGE+zniCxqLt9htrLAcEr3biMZD+i1a0YWv3lxdm4f?=
 =?iso-8859-1?Q?O4V/xdSS+R3qHMSSvrrFH3lLpGQWs+8O+4IVnCBsTv+jZucmmKDQ5XW3Xr?=
 =?iso-8859-1?Q?NKUap6/QZeuCr7STYmKCYmkuLMfK3XMBrZgKDytpvQ48wnd3M+8NdemqCm?=
 =?iso-8859-1?Q?PxXKKp2UJqIOSK9jQ8T6kfdNsOFBeQhvx8OWKrQbjrT7udCYECGVuLDpPV?=
 =?iso-8859-1?Q?Y2FMW51ts4+P3DFgX7oJol1jG00Igu4VdQAEtDxAtZyxNFCyBdipR5r9rw?=
 =?iso-8859-1?Q?skycVyskWFQRKFkVbiQzAqlvnLfuB2XFHS1SCkWSdg+yKWk6xmcruwNyhJ?=
 =?iso-8859-1?Q?5TzaHXIltOkb6vF6xetp+BdpJKecq1CtU2IYKy5nrwDnim3Vv2VsBWIhJJ?=
 =?iso-8859-1?Q?aEZIJsnvhyhvGFyT27YARgJxNyu+WeeBs2Ol/9tbDP+AVob70Mw6yArnPL?=
 =?iso-8859-1?Q?T9gxKqyQ3SpYtlYryoK9mZlkZqRfiwsC3NvkjxfMuWJD1p8tIDNExTioqU?=
 =?iso-8859-1?Q?FwFVgun/wu9VK1pS/b0LG4lc32eRGaM67YHkn+PBVMfrHb43Mj6Q0AYhn8?=
 =?iso-8859-1?Q?ZD2AfBmDhk2jtU63lUmQFjmxNSmFtLYxuOETvovQgP6MRdKAm/GC/W5Waz?=
 =?iso-8859-1?Q?ub0QHaYbLFHh/d4TO3lvKuczQaFp49lsGSs1iMNLWhWCBnNyl7+G18d8Ol?=
 =?iso-8859-1?Q?1fsc+2Bm5X2/BUNSsdSfGSDfrnnpt0FECvLGGM2eLrIPcvlkPKCfFORjR8?=
 =?iso-8859-1?Q?p/Oeu1nPLNV3R7p77H3M3WrX1dhpKd9f3amYVdwuFy0U05+c0ZmcLJnKkF?=
 =?iso-8859-1?Q?y7On5a30+oTNXgFFUpjcP3eJJsj6?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(1800799024)(376014)(36860700013)(35042699022)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 14:03:04.2266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1de3835-4a1b-41f7-df1f-08dd29a3d85f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6718

Gentle ping in case of forgotten.=0A=
=0A=
________________________________________=0A=
From: Yeoreum Yun <yeoreum.yun@arm.com>=0A=
Sent: 20 December 2024 16:46=0A=
To: peterz@infradead.org; mingo@redhat.com; acme@kernel.org; namhyung@kerne=
l.org; Mark Rutland; alexander.shishkin@linux.intel.com; jolsa@kernel.org; =
irogers@google.com; adrian.hunter@intel.com; kan.liang@linux.intel.com=0A=
Cc: linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Yeo Reu=
m Yun=0A=
Subject: [PATCH v3] events/core: fix acoount failure for event's child_tota=
l_enable_time at task exit=0A=
=0A=
The perf core code fails to account for total_enable_time of event=0A=
when its state is inactive.=0A=
=0A=
Here is the error case for failure to account for total_enable_time for=0A=
core event:=0A=
=0A=
sudo ./perf stat -vvv -e armv8_pmuv3_0/event=3D0x08/ -e armv8_pmuv3_1/event=
=3D0x08/ -- stress-ng --pthread=3D2 -t 2s=0A=
...=0A=
=0A=
/*=0A=
 * three number represetns each=0A=
 *   scaled count / total_enable_time / total_total_running_time=0A=
 */=0A=
armv8_pmuv3_0/event=3D0x08/: 1138698008 2289429840 2174835740=0A=
                                      ^^^^^^^^^^=0A=
armv8_pmuv3_1/event=3D0x08/: 1826791390 1950025700 847648440=0A=
                                      ^^^^^^^^^^=0A=
=0A=
 Performance counter stats for 'stress-ng --pthread=3D2 -t 2s':=0A=
=0A=
     1,138,698,008      armv8_pmuv3_0/event=3D0x08/                        =
                       (94.99%)=0A=
     1,826,791,390      armv8_pmuv3_1/event=3D0x08/                        =
                       (43.47%)=0A=
=0A=
Since above two events are belong to the same task context and=0A=
mutually-exclusive per cpu (they couldn't be active at the same time on the=
 same cpu),=0A=
the total_enable_time should be the same (marked with ^^^^^^^^^^^)=0A=
and the summation of ratio should be 100%.=0A=
=0A=
This account failure of total_enable_time because of=0A=
account failure of child_total_enable_time of child event when=0A=
child task exit.=0A=
=0A=
Below table explains how the child_total_enable_time is failed to account a=
t=0A=
exiting child task which switch cpus as time passes by (CPU0 -> CPU1 -> CPU=
0)=0A=
=0A=
 - in means sched_in.=0A=
 - out means sched_out.=0A=
 - exit means at the exit of child task.=0A=
   NOTE: the value is before calling list_del_event(). which mean=0A=
         the value at exit column will be added at parent event's=0A=
          child_total_enable_time when child task exit.=0A=
 - ctx is the child_task_ctx,=0A=
 - e0 is the child_event which set with cpu =3D=3D -1 and opened with pmu0 =
only=0A=
   added in CPU0,=0A=
 - e1 is the child_event which set with cpu =3D=3D -1 and opened with pmu1 =
only=0A=
   added in CPU1,=0A=
 - e0 and e1 belongs to same child_task_ctx.=0A=
=0A=
          CPU0 (run t1)        CPU1 (run t2)          CPU0 (run t3)=0A=
          |  in | out |       | in  | out     |       | in      | exit     =
   |=0A=
---------------------------------------------------------------------------=
---=0A=
ctx->time |  0  | t1  |       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2 +=
 t3|=0A=
---------------------------------------------------------------------------=
---=0A=
e0->ena   |  0  | t1  |       | t1  | t1     *|       | t1 + t2 | t1 + t2 +=
 t3|=0A=
---------------------------------------------------------------------------=
---=0A=
e0->run   |  0  | t1  |       | t1  | t1     *|       | t1 + t2 | t1 + t3  =
   |=0A=
---------------------------------------------------------------------------=
---=0A=
e1->ena   |  0  | 0  *|       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2  =
  X|=0A=
---------------------------------------------------------------------------=
---=0A=
e1->run   |  0  | 0  *|       | 0   | t2      |       | t1 + t2 | t2       =
  X|=0A=
---------------------------------------------------------------------------=
---=0A=
=0A=
The value marked with * means it doesn't updates since event->state was=0A=
INACTIVE.=0A=
=0A=
Please see the last CPU0's column with exit (marked with X).=0A=
Since e1's state is INACTIVE its total_enable_time doesn't update=0A=
and it remains with former value without accounting t3 time.=0A=
=0A=
In this situation, at __perf_remove_from_context() while exit child_task,=
=0A=
sync_child_event() where adds child_event's total_enable_time to=0A=
parent event's child_total_enable_time is called before=0A=
list_del_event() in which event time is updated by setting the event state=
=0A=
as OFF. that means child_total_enable_time is added with missing=0A=
amount of last enable time -- t3.=0A=
=0A=
In case of parent event's total_enable_time is updated properly in=0A=
list_del_event() when the task exit,=0A=
However the child_total_enable_time is missed when child_task exited,=0A=
the perf prints error amount of enable_time (which is summation of=0A=
total_enable_time + child_total_enable_time).=0A=
=0A=
To address this, before updating child_total_enable_time of parent's=0A=
event. update event time.=0A=
=0A=
After this patch, this problem is gone like:=0A=
=0A=
sudo ./perf stat -vvv -e armv8_pmuv3_0/event=3D0x08/ -e armv8_pmuv3_1/event=
=3D0x08/ -- stress-ng --pthread=3D2 -t 10s=0A=
...=0A=
armv8_pmuv3_0/event=3D0x08/: 15396770398 32157963940 21898169000=0A=
armv8_pmuv3_1/event=3D0x08/: 22428964974 32157963940 10259794940=0A=
=0A=
 Performance counter stats for 'stress-ng --pthread=3D2 -t 10s':=0A=
=0A=
    15,396,770,398      armv8_pmuv3_0/event=3D0x08/                        =
                       (68.10%)=0A=
    22,428,964,974      armv8_pmuv3_1/event=3D0x08/                        =
                       (31.90%)=0A=
=0A=
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>=0A=
---=0A=
 kernel/events/core.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/kernel/events/core.c b/kernel/events/core.c=0A=
index 065f9188b44a..d27717c44924 100644=0A=
--- a/kernel/events/core.c=0A=
+++ b/kernel/events/core.c=0A=
@@ -13337,6 +13337,7 @@ static void sync_child_event(struct perf_event *chi=
ld_event)=0A=
        }=0A=
=0A=
        child_val =3D perf_event_count(child_event, false);=0A=
+       perf_event_update_time(child_event);=0A=
=0A=
        /*=0A=
         * Add back the child's count to the parent's count:=0A=
--=0A=
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}=0A=
=0A=
