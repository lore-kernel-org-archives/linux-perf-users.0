Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C541F131A
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823260; cv=fail; b=hiCYKFfoAmh5v441hL0Pn+pALHL5DLp+LfOANJI47wTkC8i/1rmYeZ33Ne29H5xxhspZDABbAAQ+mXJLJfGtD+kefDnm8wgb1xC6vhH0s4lPEgpSD3GOGsM2h2u8PZRSoPijY+9ITLFeN0YhThb+3gTa7VQZBJf5PIB/MDloPZg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823260; c=relaxed/simple;
	bh=Af4jfRb5SN/0aVYNCO3LJQsdQVwe/rtVq7beaOepYvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EAU2p2n6OE2C9AJH5Z+Gp4axKkAOmSUo7OGc/9otSSKUcIDsNf319c0I87nuiSYmvczpKRKrgTOjccRncO9GFBY8rZO2eYOq/WJOOfP2K746/Bx3gTK84ba9Ho0OUttBAjtbc34K2nbekhaLFRnMGIzhH0IZ1mNUmmVL0SfSkHk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mGJpF0Xv; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mGJpF0Xv; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mGJpF0Xv";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mGJpF0Xv"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pwycP9FzgKFci4R2rpbYIQ93Y2QEe4TyKmEFViyNLTWJ7pkVexhtFrzKkddYuyRCJIJ9Lnj9Gqw8kYIlJ7ntf81Ha/c1H4EBzRzIfvi66Bo0hchFCCm4nwkXaDD31UrzCfICETYLu6mq+ozfpr6dW1HAc2T7LALdPVCmn1H5f6JvmXQVBUZiqthcHIJaGa5rhWi5mj4XepUJDMtSB+QyvQNpkQ7+alwlVci155g2/Naix3clHwbv7fatOuJvVehpYI/k70QtgKovXlIDC6SV+bulQspmomeoS5CAD/c8NPkljMTILo6GXYQ0QChDBGD64C4J+mXPTENvtuL9krvypA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af4jfRb5SN/0aVYNCO3LJQsdQVwe/rtVq7beaOepYvU=;
 b=gKdfoNeKMeqi9RX2ILIfmgs9O8Dgf/HgSHZynuRNmML9Nw3m5iFZcewp0NDIz8Hlf/h3no80rqfci19FUpf/ezjGBqxv9+cVeklF78VonM6ZqjY9gGHNjpY6t/7pUZ6UEnLWKVg67Vtk+aFlql6yqhziayMFVGnFiBZFBGr2ogt0WJ7XQi5LmKXf+/SMJZZ4NgC6TlwR7hAwKCM/0QSJfLeE3uCMTVDsUwBhczwRGgP/KHJTU4CJxOiGSoTjrImA7ueJrFOzG1Yi3LOobNRsayhvuJMQUVgFi/d50NFegTFEQWAu9nxvh+awsSKWnQHrtmZv4utqQTilSzWSHsjNtw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af4jfRb5SN/0aVYNCO3LJQsdQVwe/rtVq7beaOepYvU=;
 b=mGJpF0XvQ6tbhhpoomWOFB7ywq+B5Aixy4GDv0WdHT+nMPOjbAygyMvPvufcKQCh6EITlVs7cWkEiwwLS/6P3HIysQ77GHBvsii9HkDbbJKIpPTG4CsaT2B+qczalpgEyV9/OTOh38Zw9HYGOoVCG+7g6V7dHaI0ur/Yd41BJRE=
Received: from AM6PR10CA0084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::25)
 by DU0PR08MB9702.eurprd08.prod.outlook.com (2603:10a6:10:446::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 05:34:12 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:209:8c:cafe::98) by AM6PR10CA0084.outlook.office365.com
 (2603:10a6:209:8c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Fri, 15
 May 2026 05:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.3 via
 Frontend Transport; Fri, 15 May 2026 05:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPmPVP2rPWPjh3sgdrgMEvnqNGh99e0SU5IQGJ4mc0gNiYNfWCxueRpZdrSS8YX1/EQbsS4C15clJ/7GrK5Mtj+At8RBV+o5XeG1iw+vBgv5POPHa/JQK9QymOsI9a57uQMy3/NaaQmt0dknXy+yk2qdwn+WR5LHxbdJN0rlrhkXJMXD1OT7YNqU43AnIk0Fopu1clwaAMd8AqFpQLII8XYlWdqhP7lVGp5wERBL1sNI5ryblLNN22PjHw0qhZRVpJ4I3iMuhT6Kqrwq0ow00hCJOdKhefXsqT94bC4xi4N6Ufe78nXE5XqLmFksVJ9KDlp47ic3f7jTTVYn9gO7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af4jfRb5SN/0aVYNCO3LJQsdQVwe/rtVq7beaOepYvU=;
 b=CYkTQKs5S9gEV604hK3cxHNsfvQyGN7Fu7J1ugCTU280rixUts0jDBQA20fPYXv3HzHIUNPWXKqiLWOk5ZsHB63Np0bULSzLVAfjw8Mdsbu+/1jRgGSOXUgM+XcNvYBOCs2nD+G+DR1w44R0ojZnAfnMwakKVHXKjhY6s3vkb8xAlbT6EyNUCxUlXtRlH6M1HZMsN8mEPY01H0ZOEUmFNbhERVvamTpyggOye3n+2FZO4Bdoykx9EHKXtAWYxAlc+h4S6O6fOfHlYIhwHMOtcgJBuB2trR4Y+2VRDmCFC8gSBC9EgFnOzhRDxDON5WBMHJKCsAVj7IMAcZOtZLgJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af4jfRb5SN/0aVYNCO3LJQsdQVwe/rtVq7beaOepYvU=;
 b=mGJpF0XvQ6tbhhpoomWOFB7ywq+B5Aixy4GDv0WdHT+nMPOjbAygyMvPvufcKQCh6EITlVs7cWkEiwwLS/6P3HIysQ77GHBvsii9HkDbbJKIpPTG4CsaT2B+qczalpgEyV9/OTOh38Zw9HYGOoVCG+7g6V7dHaI0ur/Yd41BJRE=
Received: from AS2PR08MB9786.eurprd08.prod.outlook.com (2603:10a6:20b:605::22)
 by AS4PR08MB7806.eurprd08.prod.outlook.com (2603:10a6:20b:519::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 05:33:09 +0000
Received: from AS2PR08MB9786.eurprd08.prod.outlook.com
 ([fe80::d721:dfdb:2f83:155]) by AS2PR08MB9786.eurprd08.prod.outlook.com
 ([fe80::d721:dfdb:2f83:155%4]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 05:33:09 +0000
From: Justin He <Justin.He@arm.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH 7/7] lib/tests: test_ratelimit: fix stress test thread
 lifecycle and leak
Thread-Topic: [PATCH 7/7] lib/tests: test_ratelimit: fix stress test thread
 lifecycle and leak
Thread-Index: AQHc41+ydwJDBgx6s062FfZxU2W/NbYN1VWAgAC8LJA=
Date: Fri, 15 May 2026 05:33:09 +0000
Message-ID:
 <AS2PR08MB9786AFAA7D2639E257C0A5B3F7042@AS2PR08MB9786.eurprd08.prod.outlook.com>
References: <20260514050455.2954509-8-justin.he@arm.com>
 <20260514181819.C0713C2BCB3@smtp.kernel.org>
In-Reply-To: <20260514181819.C0713C2BCB3@smtp.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS2PR08MB9786:EE_|AS4PR08MB7806:EE_|AM4PEPF00025F99:EE_|DU0PR08MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c503c0b-8fd1-4448-3296-08deb2439887
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|4143699003|11063799003|56012099003|22082099003|18002099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 Iy6GLXVHDxXuuzTL9dNPyZ9kvkU462baZxvzqNSzuPtzvFWZCAa+IRJtDYWU6JAyas4Ci99DZ0fgte3mvLmGProIQJmyLsD/+oR5QROHMHtTESZE8c5LkqFGx0dq7l9Vyh324BbJ0XupBIaSMmLwB7loBLlQjTuCd6+HpJGKK1DNKtLSkchNLS034Gh6gm2SblICVLnafIJn/4bBE9U89xunMl+dzhe7gKvhDrbMkMOJppzPv1/G3AchwO3Yn1T3X5WQXbfxxRm55wjXO65e5dck2BMsSMzPpinv6uWWS0ddJjC2v2OyxDSdMnA8eh3u+k5zrouneGk4Ws/bhyPhediiCY9E5cbFliK2AxMOCoN6+a5fYiEeIwhJ849Sep0fqsuI9atpev0UI12YPblIysGVIga2x3L+xbWjQvMXkH4UzZTuUqJaky/Ln8tZKu7bqohRcXgTh4Pu7z9EGmE2jvqEZIVuapKf3XnRbZ3SLSm4N8cVA9YjQjZIHDFymyyxgMoR4Nb2jQVYi3CeJr2bd0yuyklP4DIM6t6fWz/L7BkwhUupkO6JaXo9d0bHF08Bf07DHckrolsmPwpymIhslbl5RHJbJXpqh8dzudfh001Ii6wH2rAxp/N9w1Uqfxk37PIBLMhSsb438jrVTCmJyy7qmFf+RfzKs5oQ7XY8G8U+JBvvYFO74TBsr18VGl+0DopfffTdnoq/Z3l/3eCjXKugqhP4TqBQIfVg7sLntRvgeP6nryzwX2EehK5ueo3c
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9786.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799003)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 WxIOaKs2TFo8umFswoJgfmuYvdkfv8HgX2ErMINVpziSTW1oUymFAREQi/iTRGCQwVJdGxemvaj7TV+z7g9bTQJlLT4i34zwLrSF52tPe8KGQz232kIqszUJFhg0GPSwviHAZR2MA4cCvQop9gH7kr7FTGM60OfDRJOB8ygOykX/bAR4JvF/p1tWeaq16XdDm6Jz9Hfjehbzxuu+8gt9siNnEEW0k6wgt+rEH4mikH7jMLvIlaKCcOngdXMcjNVSa1IxmuQXGJXPkr9w+sQEf3Gk5e9NBNfi83gokbfADYYNIEOupKzgTPg66RxIk73hewFJ0JQehnp9wRC+zdoEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7806
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	33e4c112-5774-40b1-c660-08deb24372e3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|14060799003|35042699022|18002099003|22082099003|4143699003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YXeDNBmAT7DZejNb1aYbrZapxlI+P2ChBJ+B6OYLih5wOxtFrt4/ZWvHzTYUxZIBFlVucK8RGvYN5p9XnmqwhdBhSqsyoipk2AzTFvH9xgPSc42DNzM0axvPy2NzfNl4XyTdXn0bObo7CDkzuP0yR3wkkxTJ5sMPVBxPVjBVVbcXOXB2v1gOpYABScSWrWRVKmj0EUdb7Ttf26tkulFjefLT3Su5A44RXq5CbVOxon/+AoyZ4M5f3nwxqdXT6E+UMzgmJV+iEE8AGynd5yEC8KqJn/G4/w4MnBM5Gex3sm6NDt8v8NK5bkrzBMuu3vyoUwQ67LC8YACy/M5vJlwLw+779HB38+DM//wHaUuQgEPdOB1+81uPmox/cYYoToVwWqWulNBZmoySr6rLwKAivFdCaQWVM0JgPmELq9+ComXpNocyTG2sXUVf4n3rxBggbO5UC2g0Mgi2HrbZU7+aBjGJnUW+F8lUTLJEnir8s6M5SD4UF5T1rWdzAbkDCM9HBk3si8twiXf117HzIxPLsG2pR5vucRhUx1g2DrS7hn+BYZ7WqJzvDLzwt5ghOpzkecD6rPKE2X3GB50WHgJb8heBClbFc521wCo4xocg8n0InmsHcLcWwJjcEDgV5rISDvOcZ71mJOwKGKEkNvYnIHkWQB6AaQ0d7K4D2OWmar1PjNRkUISI3Xn71kpBUSbIVn4JOZcoCNGVh8ApV6x8bCzQoHaimM8/zFnM3ho5YDg=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(14060799003)(35042699022)(18002099003)(22082099003)(4143699003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3UuhiaOHlwfH1QRVdN39A9xBVgkQS9N09dp74eErOk5o7TY4LbgZofE8T1bplv/nwLv3NoJDH6yB0HsZfcFP1t6Xbvs8sy10xZsGhGq3WrhXosX9GEfqrmH04WWuIE2lOZeFyChfIVgc+5uWBtMwc0E5WTwEiGffMdS4etJ7cQFkiEI/1qa0t2IlLXKnkvyjf3WWHTN+izrbX25xYDuRTRk3vg1Wiu0GI3pUNPgSgER4DEbL/xjGEO281NLiuZq7jieGlgiqgGL2T8gKuYsmb+j1NO2WPlm4/SL1sCsFySRjW+KsYqIdSqm4U5zqs5b+/s7ybQekqtXjzKhHQvl6XiGH9//V8HSysgHCQ+qziNxnwP8eyaW4qFPprAZJ+Kqew7Xdp629rlj8ce9fXGxvheJBpxpwqfXLB4J62Iq8NyNrdkDw/wwf0FWi8CA+57Z+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:34:12.4333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c503c0b-8fd1-4448-3296-08deb2439887
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9702

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2FzaGlrby1ib3RAa2Vy
bmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTUs
IDIwMjYgMjoxOCBBTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4gQ2M6
IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
Ny83XSBsaWIvdGVzdHM6IHRlc3RfcmF0ZWxpbWl0OiBmaXggc3RyZXNzIHRlc3QgdGhyZWFkIGxp
ZmVjeWNsZQ0KPiBhbmQgbGVhaw0KPg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9u
ISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKQ0KPiB0byBjb25z
aWRlcjoNCj4gLSBbSGlnaF0gVXNlLUFmdGVyLUZyZWUgaW4ga3RocmVhZF9zdG9wKCkgZHVlIHRv
IHVuY29udHJvbGxlZCBjaGlsZCB0aHJlYWQgZXhpdA0KPiAtLQ0KPg0KPiBjb21taXQgY2I5Yzdj
OWM1YjNjZjdiNjFkNDM0ZDhkYzJlNGU3MmViYzRjZmQzYQ0KPiBBdXRob3I6IEppYSBIZSA8anVz
dGluLmhlQGFybS5jb20+DQo+DQo+IGxpYi90ZXN0czogdGVzdF9yYXRlbGltaXQ6IGZpeCBzdHJl
c3MgdGVzdCB0aHJlYWQgbGlmZWN5Y2xlIGFuZCBsZWFrDQo+DQo+IFRoaXMgY29tbWl0IGNoYW5n
ZXMgdGhlIHN0cmVzcyB0ZXN0IHRvIHVzZSBrdGhyZWFkX2NyZWF0ZSgpIGFuZA0KPiB3YWtlX3Vw
X3Byb2Nlc3MoKSBpbnN0ZWFkIG9mIGt0aHJlYWRfcnVuKCkgdG8gcHJvcGVybHkgaGFuZGxlIGNy
ZWF0aW9uDQo+IGZhaWx1cmVzLiBJdCBhZGRzIGFuIG91dF9zdG9wIGxhYmVsIHRvIGNsZWFuIHVw
IHN1Y2Nlc3NmdWxseSBzdGFydGVkIHRocmVhZHMgaWYgYQ0KPiBzdWJzZXF1ZW50IHRocmVhZCBm
YWlscyB0byBzdGFydCwgYW5kIHJlc2V0cyBkb25lZmxhZyBiZWZvcmUgc3Bhd25pbmcgdGhyZWFk
cy4NCj4NCj4gPiBkaWZmIC0tZ2l0IGEvbGliL3Rlc3RzL3Rlc3RfcmF0ZWxpbWl0LmMgYi9saWIv
dGVzdHMvdGVzdF9yYXRlbGltaXQuYw0KPiA+IGluZGV4IDMzY2VhNWYzZDI4YjIuLjY0ZjI2MjYw
YzBkODUgMTAwNjQ0DQo+ID4gLS0tIGEvbGliL3Rlc3RzL3Rlc3RfcmF0ZWxpbWl0LmMNCj4gPiAr
KysgYi9saWIvdGVzdHMvdGVzdF9yYXRlbGltaXQuYw0KPiBbIC4uLiBdDQo+ID4gQEAgLTEwNSwy
NiArMTA1LDQ0IEBAIHN0YXRpYyB2b2lkIHRlc3RfcmF0ZWxpbWl0X3N0cmVzcyhzdHJ1Y3Qga3Vu
aXQNCj4gPiAqdGVzdCkNCj4gWyAuLi4gXQ0KPiA+ICAgICBzY2hlZHVsZV90aW1lb3V0X2lkbGUo
c3RyZXNzX2R1cmF0aW9uKTsNCj4gPiArDQo+ID4gK291dF9zdG9wOg0KPiA+ICAgICBXUklURV9P
TkNFKGRvbmVmbGFnLCAxKTsNCj4gPiAtICAgZm9yIChpID0gMDsgaSA8IG5fc3RyZXNzX2t0aHJl
YWQ7IGkrKykgew0KPiA+ICsgICBmb3IgKGkgPSAwOyBpIDwgbl9zdGFydGVkOyBpKyspIHsNCj4g
PiAgICAgICAgICAgICBrdGhyZWFkX3N0b3Aoc2t0cFtpXS50cCk7DQo+DQo+IENvdWxkIHRoaXMg
dHJpZ2dlciBhIHVzZS1hZnRlci1mcmVlIGlmIHRoZSBjaGlsZCB0aHJlYWRzIGV4aXQgYmVmb3Jl
DQo+IGt0aHJlYWRfc3RvcCgpIGlzIGNhbGxlZD8NCj4NCj4gV2hlbiBXUklURV9PTkNFKGRvbmVm
bGFnLCAxKSBpcyBleGVjdXRlZCwgdGhlIGNoaWxkIHRocmVhZHMgcnVubmluZw0KPiB0ZXN0X3Jh
dGVsaW1pdF9zdHJlc3NfY2hpbGQoKSBvYnNlcnZlIHRoZSBmbGFnIGFuZCByZXR1cm4sIHdoaWNo
IGludm9rZXMNCj4gZG9fZXhpdCgpIGFuZCBkcm9wcyB0aGUgdGFza19zdHJ1Y3QgcmVmZXJlbmNl
Lg0KPg0KPiBJZiBhIGNoaWxkIHRocmVhZCBleGl0cyBjb21wbGV0ZWx5IGJlZm9yZSB0aGUgcGFy
ZW50IGxvb3AgcmVhY2hlcyBpdHMNCj4ga3RocmVhZF9zdG9wKCkgY2FsbCwga3RocmVhZF9zdG9w
KCkgd2lsbCBhdHRlbXB0IHRvIGFjY2VzcyBhIGZyZWVkIHRhc2tfc3RydWN0Lg0KPiBUaGlzIGFw
cGVhcnMgdG8gYWZmZWN0IGJvdGggdGhlIG5ldyBlcnJvciBwYXRoIGFuZCB0aGUgbm9ybWFsIHRl
YXJkb3duDQo+IHBhdGguDQo+DQo+IFdvdWxkIGl0IGJlIHNhZmVyIGZvciB0aGUgcGFyZW50IHRv
IHRha2UgYW4gZXhwbGljaXQgcmVmZXJlbmNlIHZpYQ0KPiBnZXRfdGFza19zdHJ1Y3QoKSBkdXJp
bmcgY3JlYXRpb24gYW5kIHVzZSBrdGhyZWFkX3N0b3BfcHV0KCksIG9yIGFsdGVybmF0aXZlbHks
DQo+IGhhdmUgdGhlIGNoaWxkcmVuIHNwaW4gb24ga3RocmVhZF9zaG91bGRfc3RvcCgpIGluc3Rl
YWQgb2YgZXhpdGluZw0KPiBpbW1lZGlhdGVseSBvbiBkb25lZmxhZz8NCkFncmVlLCBJIHdpbGwg
c2VudCB2MiBpZiBubyBtb3JlIGNvbW1lbnRzL29iamVjdGlvbnMgYXMgc2FzaGlrbyBib3Qgc3Vn
Z2VzdGVkLg0KDQoNCi0tLQ0KQ2hlZXJzLA0KSnVzdGluIEhlKEppYSBIZSkNCg0KDQpJTVBPUlRB
TlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRz
IGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUg
bm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1l
ZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVy
c29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1h
dGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
