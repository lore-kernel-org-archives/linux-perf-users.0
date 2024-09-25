Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D521A1C;
	Wed, 25 Sep 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268076; cv=fail; b=uIcan0QiXgFkPZsyuCe+KCo7hSHtvoCTHoDvu0k3e9zYHxTdMVf1yuMAxlIM64KngKHaJlPFsaYx1gafVSfzwaUHr4ON2x8kDOXvIxE+FJWTP0IK4/zQvRtONScdylnPr4ACrXUHKG3sIlpSm3rm0PLx76N8kFtEWlJLuov1oTU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268076; c=relaxed/simple;
	bh=TGhX5uXQJ3jwl1Z5m0qBVoDLDKBSLGN0zN8o8mBQj/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TJjl3OWD/9CqHg23LtHS/E2MiAWTptFPJnYatajAC4bzFmF53i7qcA9kBHD/VybSrtM0PbvFj6PGRCamxLfDkuxNXVuAw6OLs2J348Y/0mxGrUmmMldseWV2ZIiy+Q9xws7XryniXlyV62bWrcV0YQrnntFlbmvCKWkCHfuwJ2A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p9+oMIHM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p9+oMIHM; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p9+oMIHM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p9+oMIHM"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pdAceqcWH2U9ByYQH84lPYebVwkDo/i2Ufenv+pheNa4izpN8TuNxSh91Xu4l9DuebB0NWDgdQFULPTy6ciMkau9UYaamd7vMnmkumrc87N/n5l3JCSWTNEiyXtmsB1w8bbuGiA2fklCsJCRLZhz1fjJCGOdx8db20t+8l9boBYH/7Lq2QbKrHoH5AfElxIb0eEjjp39kC3TnqZTMDMdjAeJ31tVa7Cuxyk3sgudBZcrOLnfjczmWfE4kN/qTFOWnfGRjRJnLIxbyml02IGOmA2Xw1biQeALeTkVE9fyurpaHs3kP2+T0+JJEfgkPtcIWlUVWskhEWapd1Ntld8g/w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdhDnr1iq3yxzkbV4hHJSTzAI6r2qGlWAtiEjjZ2txQ=;
 b=soq0AiTVTjFAfjzFjYnVqi7iM+yTToUv6n+UtlJ+YgRtg7FYE01SX523+zQUjD0C8icysxPKhlyt240inVvO65i0mp9P5FniKqUoHbn5SjEx671Rc05rnj94MPLObFL4DKYorVL5jUEm+LS8/BMSRwK2UzvYJeCJe5ixkK0rnXt3mjXUML7eDmyrizX2/dwKIHFsrCrnmHmD88Pko8VsejuDBlF3GOuIlAtWZNOadlXEgFfmmTWZ4ji5D/+0a9fzlk4pLCr3uCXqjpuA7yucjl9JBrq+ls+8G9L5naN3atzPK4yOJRjcQ/DwqvheGaVtLdGHc092YwNYYTlOQrZu+A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdhDnr1iq3yxzkbV4hHJSTzAI6r2qGlWAtiEjjZ2txQ=;
 b=p9+oMIHMGYL6EAHF7Fk7XKWbbmz0LNHr69HMgLbdpQ6HyBDWG+KcwVQ64V3mIYfnWs+ORqf+2eKbB6Dwm4y4/7Vrm09DCyB4hgDDZMaORZ4lyuLCxQMfAn0GDI7BnWydgqUeVzON32h5/41sCUbk6iS6teK0cDhpKeNAsnpnnVM=
Received: from AM6P193CA0050.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::27)
 by AM9PR08MB6641.eurprd08.prod.outlook.com (2603:10a6:20b:306::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 12:41:02 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:209:8e:cafe::77) by AM6P193CA0050.outlook.office365.com
 (2603:10a6:209:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 12:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 25 Sep 2024 12:41:00 +0000
Received: ("Tessian outbound 245dacdadcd4:v465"); Wed, 25 Sep 2024 12:40:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dc2c6ad2767d5f11
X-TessianGatewayMetadata: AJnB0/Gd6loBe6UNunwjHS8vjyGyw7XMMsT6+dPjqULuDQDOBZ+L1L9MtSRa6Flv9+1VRM5cmwIT7MX0IUgKXq8MsGZFF3YCP0wTTkmexycxV0XScutcIsk6rBF6nceylc13ZjmPzYUhYI5DaAYKJEX3ZfmqrT13Ghx4p7kPPW6OFo65pBTxzP81e4+gAVtg3BFmoczYYUdKqLtq/nmswQ==
X-CR-MTA-TID: 64aa7808
Received: from Lb2367fa49e66.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 736662E7-7501-43DE-9BF9-3EC509639667.1;
	Wed, 25 Sep 2024 12:40:52 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb2367fa49e66.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 25 Sep 2024 12:40:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qz/Ta/X98WOlcF0mABuNyPu43uWJWWrhmpXxnG59t+cSu8Q3CcZWZyQjWuoWxiDyV9j46GdaZgbXtEWCx0d5RV/MAW5cjmC2z59wULf0HoNBznnK8751OYQQ9vdjB8vM9eqvlrT8aUbS/qtgPs+EXZjXt7gBJg9+EHt8UTVee8mI1jJrnvL0/3DHd3h32H7XT2gHhBfqoazwFMD7PHJCoYFXqt7mqTayfzHv65Mfpm9+Ag1DkOlT+gXGifktAK/XDTzP1il+x7v/6VBU22LVhnV23cP9kHmMQ5hmNjgmZgOS9TH9sCmn8VJEnmEX6f3beSUQmqYP+rC4OIxUUc+ATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdhDnr1iq3yxzkbV4hHJSTzAI6r2qGlWAtiEjjZ2txQ=;
 b=tTuTiRlVNnSGUZIDEovX1cC8a86z+KuEHJRETAz6Fo0c02WBwORktmvQIDeXTaMP/igOuV+31/CkYYq1uJ1HOXDJ6+4vgjtNE4hh0UayZ2djD1Tql2Li9DTgp4BT5R4DudW9Tcu2FDGQlEtJaJ/C7PqKdo9ioQt714OMyRq16apPUqXr+CPlj8LVZ9d7+mc51Wja2i8JSbERWvGDdbIMqcRzRrjVJ0ujMvei8U8Vgun9FIEpbxIUc9p/UiZ7Ttc5/Rsa6MrW0ABnZF4igpJdzU1UCqltY2TAs2BfodYbUri+/ah29oeRQK42jCBLg12o3zgFqTm1caaOhmmtEJerXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdhDnr1iq3yxzkbV4hHJSTzAI6r2qGlWAtiEjjZ2txQ=;
 b=p9+oMIHMGYL6EAHF7Fk7XKWbbmz0LNHr69HMgLbdpQ6HyBDWG+KcwVQ64V3mIYfnWs+ORqf+2eKbB6Dwm4y4/7Vrm09DCyB4hgDDZMaORZ4lyuLCxQMfAn0GDI7BnWydgqUeVzON32h5/41sCUbk6iS6teK0cDhpKeNAsnpnnVM=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB8834.eurprd08.prod.outlook.com
 (2603:10a6:10:47b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Wed, 25 Sep
 2024 12:40:44 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 12:40:44 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Andi Kleen <ak@linux.intel.com>
CC: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "james.clark@linaro.org" <james.clark@linaro.org>,
	"howardchu95@gmail.com" <howardchu95@gmail.com>, nd <nd@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] perf stat: Close cork_fd when
 create_perf_stat_counter() failed
Thread-Topic: [PATCH v5 1/2] perf stat: Close cork_fd when
 create_perf_stat_counter() failed
Thread-Index: AQHbDzs6psDj0+kXbUmsBVR1VzPiTrJoatE5gAAF01w=
Date: Wed, 25 Sep 2024 12:40:44 +0000
Message-ID:
 <GV1PR08MB10521644365A907A4301AABE9FB692@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20240925110802.2620613-1-yeoreum.yun@arm.com>
	<20240925110802.2620613-2-yeoreum.yun@arm.com>
 <87msjw2al8.fsf@linux.intel.com>
In-Reply-To: <87msjw2al8.fsf@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB8834:EE_|AM2PEPF0001C710:EE_|AM9PR08MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 6856f4a9-eedd-45e3-493c-08dcdd5f4f59
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?LrrMI0qqnO8gkOS0iDNNRL4I922dVIjWE2e/TmWWRsUdmOFdasqze4j5AXeO?=
 =?us-ascii?Q?yFvjMqvy4HaSvtcCPSgqE+w4BM0AVNJkn8rp+AfQ5VE5EvxeFnffOx53b8Hw?=
 =?us-ascii?Q?eUEZGbXdX0K38RPQ655trvs4EoY8WczvS0TlX9KoG7hB82ech8gJF8fEeDch?=
 =?us-ascii?Q?djVQVt0THc+k3F+TBt8cc4BZqURWvmJJShO5BXA08g4ve04OKWFIeF8l/TpW?=
 =?us-ascii?Q?dJNiLcY4IazWKTf8LtqIYuKKa5BDcYLGSaXKC5YRmf6oNec+sUSHMTwri1Xw?=
 =?us-ascii?Q?4sGuMd1MerDZQfHm+N+NBSBuL73OVyvjw1pwGG5smVla0Ff8JMn/FSrbdl6H?=
 =?us-ascii?Q?cCz+TDavF5JL/gMJLnGQ8v1q0rgbtM6vul1Ztm3J3gyMUqFl3QexMyy1Cpn0?=
 =?us-ascii?Q?SFM4NHKBJRe6wIS0V/3+jRphAO9EgAKW56sb66IKka/FA9U6cG822AQ5IoUg?=
 =?us-ascii?Q?dWxJYrqqZm3q36PK1OHGTNkZizZJVMfR2mP2MkqOS9SiVJ0gu2sAn6zUmwzL?=
 =?us-ascii?Q?80YwQInh5N2dwYNA97U3i50vEPShUXgkG4tfmbxOkxV9AaP1DE10K7s6S6G4?=
 =?us-ascii?Q?/lWdNsTddFc2LmFRnr5EVTwSx9uAdopuEpH7WkEgTbIZEV3fFZZrfiKV20Za?=
 =?us-ascii?Q?ngz6F2y//RDQ+7ikOlCneM2WPv/N7baA1V7IkPMt9p+cSP4AzStZKZw70rJc?=
 =?us-ascii?Q?dEuzaW39HIWk5x3WsN8p4Up6wmq7Dwu4pzjaytgU3ETmWvmVUuK6KNgwohDq?=
 =?us-ascii?Q?w1Jjbi3oYcs8r74Az4Rz1ApsRXHXCOuHBSAnsfTSsMS7+aPYKkCPaqwD+cMI?=
 =?us-ascii?Q?La9FKcMk+1IEY685FyVJnxMkva8I8YL3jcwzWeFlY+oHJh6v3INUhUYCUpXa?=
 =?us-ascii?Q?E3aJGck9Dr/tXUJeVBUqcY93KiJSJiA1qMo9SsRHiYeDeV9kTA/GsjUM0iK+?=
 =?us-ascii?Q?zoUqcr+6ylmEwolb/9UicGVMJV6hJAAQiy/LBUFmbUNUd8NGH5aWQep4xQS6?=
 =?us-ascii?Q?lUh+G7z7gPgrwPD1TvbEfqedXYOCMfzK50nU11JDMIqbPXV5T3xjWk7js7YJ?=
 =?us-ascii?Q?xW9YOTRlHcxEKzOvbhaNAv6/idRwOgRAxGw3KnpW5eAyxCEMYnhudfvJPDMe?=
 =?us-ascii?Q?2xJrRyexk5tFFvy+yDu6vFLimpi8VNZL8o5oHeJ013wd622jxR1DvjlZ8c9c?=
 =?us-ascii?Q?rVbJGi8wOrc1CVXpBG2wfAR0ePMM83VB5VnTMHmSWisY34sBdpKi1MX8Gtch?=
 =?us-ascii?Q?BuWw6nRlCboxm4ajdLniHaMNfv07wP1Bfk69QZidHNaHprolxuZO4ewUeb4d?=
 =?us-ascii?Q?4QQbyiwjcdK00MIepsGtNba8OrZx30ljsIQzBMfXW6UUSWdX4y5mIpmuLVCy?=
 =?us-ascii?Q?tKrQuFpKZ0VrqsMX4C+L9Ak/aGKr1YfpZSsdPcSYmhfR1ryKfA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8834
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	de799097-8b49-495d-ea17-08dcdd5f45c6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|35042699022|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JwfeGjUloRX6wyfdqPE4HcSAvo9Bh3nI1HkRslA7ojvxZOO4iCH/m9zG4fy/?=
 =?us-ascii?Q?fgrUxi1bl5WZbYuGu0QQGEuuduPgJVv5dMDCAW1TfaNE5r5J+V3v7Nq8x6lc?=
 =?us-ascii?Q?Kd2b4r6kUfPQWb8TIYtTKWfih0AvzgGKkM53EVXoEvxeygApaKTWdxxuKu6a?=
 =?us-ascii?Q?hc+wWsOOlia1C4o0L2WqOwrXfRNDlj3Xry9gyxc8XIz8/K2yQuuh+vmbxIYt?=
 =?us-ascii?Q?sSoKFv0N+e5FSWkDv5bfEBw8g2mSxMzVjPPEy69dWJfLuUJYadFwuaVU/RYI?=
 =?us-ascii?Q?IimFQiVA5Y173oEYMB2CCCIUvjTcaQ/XUcqCHiW0SvMkhza+uidQmqmlsrbg?=
 =?us-ascii?Q?w98AcRjNnB7uLDzus22jXYvxlwcWj45PhGZxDmqhLLVa3dm+SpLhHtaQO1n5?=
 =?us-ascii?Q?06cBCPeC9zhmwsjug3K+59ILXbsCjX4WnOG8cbXE2O0WZW4x4orIN8FAbM2o?=
 =?us-ascii?Q?9KfinFGA7hNHIOFu7MfoKn5lIfXD93qsWNHfHFQHuW5wjb+3KwkYTZJuoBoZ?=
 =?us-ascii?Q?Qwc8RSuSquEC9r60cLAX8meDyGqscgf7hkIYo5W+uR9Gmcm2KWzezLyGB0Xw?=
 =?us-ascii?Q?WLFuhrE25W3G8PtpUAS87k5wsa9QClID977a6BeCsOpykV+l6t+VzUtLF+FE?=
 =?us-ascii?Q?PJKWYZBdB7NO+M+1eovF8UB/ggpu0Rbn3rdeJaipn+RhVWSTMf4JdJzacWtH?=
 =?us-ascii?Q?lSNNe8Tf6+guLP2hPx9RXhYNi9nf/jEQx702L3dCvnWTnF5+fA/qNEqOCNxD?=
 =?us-ascii?Q?6e9/t1E4KR10CnwFg1PZI+AfIk9Dm8AaDrSELxVnYXRzVYv5J/E4b1ejm6/o?=
 =?us-ascii?Q?LsdM75NXmUP69dZzM8kVfZOKpxHuec+iBhnYqpCy3vdDQr8606YKsfkqr67m?=
 =?us-ascii?Q?ahj47tGTbCnx/QZX2KUC3vAaYkfTcspmbWMbzMAg9tY0u3KrVebN0GB+YUBC?=
 =?us-ascii?Q?vrTCkxMZI6Dy5AbP0zM8fFgiB52zPZpxx/ZyysdtbIJMjPsHewOS25khWVno?=
 =?us-ascii?Q?XGQnIehuJjCt9i6yxsHRxWjoagUJww8ygNNxZkbtSsKZ1CNYUSHii0zLctIQ?=
 =?us-ascii?Q?pXqmQ+vH8A1bkPGKKaZl192kv+bkSeHuuucME5KmPhQho2bEVgk2vP935bzQ?=
 =?us-ascii?Q?1bjITSuVane0PG5+yGWU4LlezF2gkhg9eQ45dzHBfnLURWzb5tekcoCl9B/9?=
 =?us-ascii?Q?NguXPbi3K+E3kWK0/sMJFs3+jWCOzTZT6806e4t6g2oSB2RrhQEl5qvrtnTq?=
 =?us-ascii?Q?J2cVuFAMKUBjJRXi31eHEkGu0MLOgOuL58uDBiNZYlvEffO0Ggt8lr46GKLC?=
 =?us-ascii?Q?Pd0vvF7eVoAx4PJ9v9uvTEurqbTDvG3a0MX+8PNyqE9QP//HM5K3mN8253+f?=
 =?us-ascii?Q?R3PO95nT9xSXGf/tY52mj+gRb32cgUlCtitCqEibHc5M/QTWmqokk9YsQazk?=
 =?us-ascii?Q?RHYJHXFUiNUYKBk0Xgm17lqJfbJsskZ3?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(35042699022)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 12:41:00.2025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6856f4a9-eedd-45e3-493c-08dcdd5f4f59
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6641

Hi Andi,

> Technically 0 is a valid file descriptor. Check for >=3D 0

Right. However, when I see the event, evlist__start_workload(),
it checks cork_fd with

    if (evlist->workload.cork_fd > 0) {

Would you like to change this with this patchset too?

Thanks.

________________________________________
From: Andi Kleen <ak@linux.intel.com>
Sent: 25 September 2024 13:15
To: Yeo Reum Yun
Cc: peterz@infradead.org; mingo@redhat.com; acme@kernel.org; namhyung@kerne=
l.org; Mark Rutland; alexander.shishkin@linux.intel.com; jolsa@kernel.org; =
irogers@google.com; adrian.hunter@intel.com; james.clark@linaro.org; howard=
chu95@gmail.com; nd; linux-perf-users@vger.kernel.org; linux-kernel@vger.ke=
rnel.org
Subject: Re: [PATCH v5 1/2] perf stat: Close cork_fd when create_perf_stat_=
counter() failed

Levi Yun <yeoreum.yun@arm.com> writes:
> +void evlist__cancel_workload(struct evlist *evlist)
> +{
> +     int status;
> +
> +     if (evlist->workload.cork_fd > 0) {

Technically 0 is a valid file descriptor. Check for >=3D 0
And make sure the field is initialized with -1

The rest looks fine to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
