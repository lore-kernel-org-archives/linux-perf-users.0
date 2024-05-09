Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1114A0B8;
	Thu,  9 May 2024 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245557; cv=fail; b=Mlt5x0EEKmk2fmIKhO+nhW3beEfg6wYT8JHYkMTpTyuSX8UWfpUVz6wOq6IvAVu9ppx0ilefSai5CjB7WPTynwWuftgjh6uVEdWIgmqHLjiEV+TIapd2KX/XrhIxPQjs6xJ84wNlKKhIpqSm4OUw76tSidEGltFjRe52n2eUNiU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245557; c=relaxed/simple;
	bh=vXda33H0+yJXNjz8a1V2AthgS0O/sJN4TIBgTMLnfj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KRVkbyN8Alztpuzd45FNLKAy3QFWS8Dt56p+vKasJ1PFrr4ol03+sca/bCMBnv8E8CHm5Lm0UM9+6DLs9yJ/eeGv7TZTV5pbIGa1Ac6CwgtzkK8XJpKMQ72gigta+b2+wpAbCQgQ2TJz5HfyQhpKPa9Px1Q7ygd+kZVW8C6Pm6U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZgLp2Wkw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZgLp2Wkw; arc=fail smtp.client-ip=40.107.8.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZgLp2Wkw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZgLp2Wkw"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=XkbEXZePfg0vZXeDCOLXcj/ORDaUiD7hDlS/qcDFWrV7Dhc0QcprBtnQ+N+vFLntwEeLgM49JFG501WWhlRsn0u4D+9e835s19HeZTwbxj9AbIQMXKTveSVRNgjIb8Co/A8otVCSwWsa9vAxm42jwZd6BpWOCWw0YE8gpEwhycYi6hE8rAtbYFpIDE7mBWLZZAbDB7YNXRoc4H61xMGJQFoLNLEaEt8uMKIDE70yVJjpi0y+RoGJZ3x6Zr48lAKMIfJILjuRDm0UEXn+VDhD6/mvYPTbK8OshOraF6dzqKUZiCloFo/3xdz9mIHNSJQGmbztaCXbAO8/ptsfE3Uucg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXda33H0+yJXNjz8a1V2AthgS0O/sJN4TIBgTMLnfj0=;
 b=TfVyeR0Bge+2bN3fBboAKSYC44VUlQVTwsEmLNhU27EzP4B/CrsyOMnW++EUfr7WoTfb//KMbnBg/EljWYuKynwkvO50RxQcGdGp0o8GfhqQMSU2cnZ+E5Mx+pXCbNC/r+HQHhZ1u5UAGnDcr0dxTRJA5TabfUwV/omus7wm/WLgiW4zU/gOJkNhsjLs4WXb5zMcZxySRO3mJsttEgXZZaD77/CTClpmVF5nnmPygY6XvhFQ5Joh5WORfxNY9umBRPhCBhpM2lA4mI8S9C2yihwtanLLX0uMqblbdnJMbU9f2sSj5uuLnq7V9jE1kdsvcmPD5Fb4cJtBSSMEZ7tUdA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXda33H0+yJXNjz8a1V2AthgS0O/sJN4TIBgTMLnfj0=;
 b=ZgLp2Wkwe4/ZvAXL+ZDcajYjhW8HLWOZsOo/R6hlFzjoPeMUQ2SEQEmkW1LYRELfHk2zj0DNWT9C5er/3ixAUZ8LirxyBL+8LQebZRCvHlsQiq1q+2TkhNi89kzkJUfz0XKm5ETsZXZzao/AKIRKtOhU9CNO3/VZ6NErQf3b6A0=
Received: from DU7P250CA0005.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::32)
 by DU0PR08MB8162.eurprd08.prod.outlook.com (2603:10a6:10:3ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 09:05:39 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::22) by DU7P250CA0005.outlook.office365.com
 (2603:10a6:10:54f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Thu, 9 May 2024 09:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7544.18
 via Frontend Transport; Thu, 9 May 2024 09:05:39 +0000
Received: ("Tessian outbound ba75727f6dca:v315"); Thu, 09 May 2024 09:05:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c50920cfb9aaee5d
X-CR-MTA-TID: 64aa7808
Received: from 677a02c24341.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 63FC59FB-96DA-44FE-9E5A-46A2D98B3C61.1;
	Thu, 09 May 2024 09:05:27 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 677a02c24341.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 09 May 2024 09:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kluS+OXkH98PIOKzK1SAVp7QNqtNvXT6bxm+Vghz7BQ6ASGY/TUeXNErYsRxTCRQkC3TmPuPpi2u2vP//0A/infX8awWLOinfJS+tKcyduhDFXaoY56JbRHGlPOyXj9F0Q4oFAyUucNPnDLchMLZxPEHOzQE+KBEcHnah9LcZr8S6JT8fOO4VtNvFPGy6ewq6g6Z88sK9kH9sigi3vDOpQO+cveuN6rJo0cJWTro+hINHC9JUNUvK/rxbblstOjUfY4hmHGbLD54a5iR7VjNl4MYZF7EVQr35CpFDrNY6T+N4hUxb0GEMzuPSt2pcWkAIZXQLfyWqG68kK9XNvw4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXda33H0+yJXNjz8a1V2AthgS0O/sJN4TIBgTMLnfj0=;
 b=jYscLnd2OfGhRQDJCtmBpN3AzkTXfHtziPCjyhkYoNRMxN2nmtG3iXaYpEa4QmLBUkm/ex8Zf1gm7JLgPlDoHwo9fQa8Wp04o7U54d9vmFS6C7TvOIHYgBiVe0dGuEhRekG+BMxjn3qpOY9PrNotBGt/FVV95sC7kqRto3gsBvLK+fmbeZPDnpSn6sKGB2YSfpLeuK+7d6idZp5q5ujnyKHpvE+lFlLd78urKlHiqDPrkcrnSitOzj5u2WRMv64KB8ujEzxYRazpw/B6wQHljULCBuNF6qNnGfs6RruYQ5kWRsFSAZYCXfZW4rliDBYXfS6FCbm9xt52MUWY1ooamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXda33H0+yJXNjz8a1V2AthgS0O/sJN4TIBgTMLnfj0=;
 b=ZgLp2Wkwe4/ZvAXL+ZDcajYjhW8HLWOZsOo/R6hlFzjoPeMUQ2SEQEmkW1LYRELfHk2zj0DNWT9C5er/3ixAUZ8LirxyBL+8LQebZRCvHlsQiq1q+2TkhNi89kzkJUfz0XKm5ETsZXZzao/AKIRKtOhU9CNO3/VZ6NErQf3b6A0=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by FRZPR08MB10901.eurprd08.prod.outlook.com (2603:10a6:d10:139::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 09:05:24 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 09:05:24 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	Mark Rutland <Mark.Rutland@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, James Clark <James.Clark@arm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "irogers@google.com"
	<irogers@google.com>
Subject: Re: [PATCH v5 0/4] perf: Support PERF_SAMPLE_READ with inherit
Thread-Topic: [PATCH v5 0/4] perf: Support PERF_SAMPLE_READ with inherit
Thread-Index: AQHajw0LniC5BClu6keyIAKrf3gYNrGOwfKA
Date: Thu, 9 May 2024 09:05:24 +0000
Message-ID: <76bfb0dbee9347a43ef88d3712c30aa7b24fde9e.camel@arm.com>
References: <20240415081448.123789-1-ben.gainey@arm.com>
In-Reply-To: <20240415081448.123789-1-ben.gainey@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.1 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|FRZPR08MB10901:EE_|DU2PEPF00028D01:EE_|DU0PR08MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc5e7e1-9a7d-4329-a6d2-08dc70073246
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SWVxbFNTQlltZWxnencrNWZZdkNLa3UyM0w5UThzcmVsRVBQbTdqZlNrZFlO?=
 =?utf-8?B?bUJPVFJZenk2dlR4ckp2dExTRXFpc1p6WUpsRW1nZGthTWxxQm54UmhrUENy?=
 =?utf-8?B?WThzZWJhZXcwUWlKdkpKTzV4RDA4MXhLSTdFaG9aaGtoZWtEeHVYc0RmUFFZ?=
 =?utf-8?B?a04zWVlCVUhzdjRMVG5KR0dQMWVvMklZb2JDWjdseTRDVXJQNlhjVVhvekVt?=
 =?utf-8?B?M1NvN0lFSjZKR0lHUU9UQlRiVUFoYTd3NmdLeitnVFp6dTNBOHRWL3hxeksr?=
 =?utf-8?B?U1ZGdEVBbElGSmUrS2pBL3Z1U1VTSzYyblh6NURGeTVwZlArMXRxVzRrSkFU?=
 =?utf-8?B?TkNUbmRUVWR4eTVFVyt4c000V3JkbDc0bHB4L2o5OVRHdkFMejhCVDdLK0Qx?=
 =?utf-8?B?WjRRcGVCc3B1eDViWmh2aEJuUllUWmtGV2dvdG9zaUtQOWtFOEgwcEpqTzRI?=
 =?utf-8?B?cWxJbHNHMFNzQk1mczhlTzhzTVBWNUNQMHVWd2ZRMkFBcDdhcnVzUmNVZUEv?=
 =?utf-8?B?RXErbHJWYUdTVWc0YWt1MFlDNk5CTnBJUkFtQnZnYm9ZcEwzQnh6NzlianE2?=
 =?utf-8?B?ZDhKdkxDRmxSWVdVVVl1LzNtRkI3SDE3dytxd1gvYUtKY0dUWjBycktnWW4y?=
 =?utf-8?B?QVE3VG5GOXpyWW84a3I2UktNQ20zL2Q4MlZDV3BNdENBSVRjYWlLSjFreTk5?=
 =?utf-8?B?N09MY1QvbGd2TjQzbUdkWE14RG1McmtjdzZaR3R2dlVVVjFnQVZVUEp6UnM4?=
 =?utf-8?B?QW11cVZzOWtpUEdZMGVqWTNpaWVSeDl6ekFhWTZ2WHcvRXJxR0xtWWQ5NnpL?=
 =?utf-8?B?di9CcFYwUzRyS3pwcWhRT3gwZFMrd09UQlQxWlcvcnNMQi9PRWJXQ3lSMjhi?=
 =?utf-8?B?MDdPMkJLb2hZTWFqcElMWWhMdFV6SnlkY2NiaTlkQXNZMDdPREkza21Bd3I1?=
 =?utf-8?B?d3VrWnpsSEZoR3FYbThvOEZqMjNody9USnI5TlR2VVJxbkhXeWR5MTJPbWFK?=
 =?utf-8?B?Y2RHS0dNY2ZianAzQmRLTVFOTGJvcUoraDlXaTI5SUM2U0cxWkUzN3VEMStu?=
 =?utf-8?B?MVlKQ1NqQUNMc05OWCtMOFd3aUFJZ3dERW9jbDYxRVFQUU9vYjY4WEhhbWxk?=
 =?utf-8?B?N2JCa1dIKzdoZ1dpNHhBa0tmdDdmZG4yek44Vm05VXhPQTNkb1drdWxyV2Jv?=
 =?utf-8?B?cEt1U1gzT3l4bzVSMVBBM2R0dk1mNVQvOWZPT3kxY0VjZ1JkOXlsYWlETWNG?=
 =?utf-8?B?TlI2TE1SNkNzRE93SFY0WjVBSitETFhCM3h6RkRrTUM4VjRuY0JkN29nWDlW?=
 =?utf-8?B?c3l3dkdHR3dpaEY2Y3JVcEVyZE1iK0VlSCtsc2RpbU9WcHZWRldPd1QrUjVk?=
 =?utf-8?B?SDVpWE10U2NFWmxSK3A2cVc5UGlEaklQeHlFNmwyZFI5ZCs1QzJaanlpZ3p6?=
 =?utf-8?B?Nm16V3U1WWxmb0VnemEyY1ZJUG81QnpRYzRNZUdsSjhBRXkrTVI3dWJVdUhp?=
 =?utf-8?B?aFQyR2FoYitXbUcxL2FSZzhLcWhhME5KVTRqSG1kWnJQRWlxS3p2U0h1SjZM?=
 =?utf-8?B?STdGZVBETWVlblcwMTAwWHhWbE9kalpiTDN6REFkS0I5ZHMxaEU2YUpLRmNV?=
 =?utf-8?B?bjgrWUZQMlROS3FicDJ5OUw4Z0VHQkZZSHFMMXR4SmVWNExEVmJEUlVrLy9k?=
 =?utf-8?B?NmVWVFBYcGxNQWRQK3JCWU54NFZjUFhuTHBkTVNvbzZHNlZvTkFkeU5VNFow?=
 =?utf-8?B?QjY4Y0w2OCtCR1FDREo1RzdQSVRoZGRmbW92YUNhTTlTMlNRK20wRUNtaVJO?=
 =?utf-8?B?bW1nQy9lVjJwd01jdjdNUT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA500188A2C12847A79249159590649A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB10901
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	df616096-38bd-4b3d-0a54-08dc7007297f
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|35042699013|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGJKR0dhZlRCekFPMjBKT0x3L1JhM2N3QkkwZmp0SXovZDRJYmxqcEVzNzJX?=
 =?utf-8?B?L25vNTR2OXJSTE53SWRlV1FHVHZraFhZT21yYXN4SWc3T21QcjVtcXJBdHMw?=
 =?utf-8?B?aThzSnFvNXUxZnNMTEVuNmJjcHg4YTN2Z2p3WUplYWY1R2hhK2ErVmRRaTg2?=
 =?utf-8?B?dXVWY3R4RUxBbDNCdGVUZWZ1Mml3UmpQc3ErUjNqYzRVRTdYV09OcExVR1I4?=
 =?utf-8?B?TlFTblc5dXcwYXRZMWpDRy9NZy9mdkFJcVNMeTdQREJibnZPKzd4Q2VEOGp0?=
 =?utf-8?B?WFdkaG9iMTI1eE9pUHM0Qjh0aXF1TVNYYzlnS3VnRE91b3UvTDE3U1dIcTNC?=
 =?utf-8?B?SVU1T2FwMXQxbHJtSGFNVy9rRHlCdXpjVmtsVmd0bFE5QTVhWmZxNDFLT1pm?=
 =?utf-8?B?VXMzQU9XSENiZ0FFQ1dubGt5UjhDNkxWVU1SQlYySlpVS0x0NXRBSU5oMWtp?=
 =?utf-8?B?UjhZRlhCdW5PazAxZncxZWNUUEhGNFUxdlQ1bEpnelNGY01mMFcrQlM2RmRz?=
 =?utf-8?B?OEtRZ3J0ZjB1ZEJBNDVucHA1OTdnNG1iOStqeUl4MW5kd1NwYUtudmxHUm5V?=
 =?utf-8?B?ZzE4Rm45c2RVQTRuZUlZcVRyK1lIU3pSTEw2TnhlTnlHeGYvZnNJN1hyY29y?=
 =?utf-8?B?OUVSbVNjdlBPT3M2YzE2NmtPRmtzbFhHYTNzN3FDeUpMb2lzR21OQ3NaQkFS?=
 =?utf-8?B?elRLZ1oxM2RYMUVRTldhYytOOU5yQ3RNbEdabDVFQSt0dUk1N3ZRejFzVUJo?=
 =?utf-8?B?bThJaFZJcmZLcjNDZ2NlMEtyNk9CcTFTMDhHZmR2bVpTbFluU1ZPWmJwbHlO?=
 =?utf-8?B?cDlPL0VHRHdlbUpZNWp0UGlnQkpWYWw2OUsvNnhONDRDUUdtczVTWTIxZnRv?=
 =?utf-8?B?VmJhRitMdWdHa0I0bnBURE5DQWRpV0lreStGSWZBS05HeG0ya0dRVVBVT0M4?=
 =?utf-8?B?Z3Q4NHdOUnNZcTRtQzdWdXZrSmNGUURtcjJpL082TEhCcUd5OXRsQ2E5dGNr?=
 =?utf-8?B?M1Z1MlpkZzBvLzVyencrN3JPa3dZYVhZempSZEZZZkswSEtIb1J4M3NwS1Fx?=
 =?utf-8?B?SitBdGVmVmZzUE1yRVROUytOSW1MRmprdHh2cjZVZHAxdHA5ZWUwY2hiYzB2?=
 =?utf-8?B?ZkMzcCsyK0gwZEhRSVdUSTVhMWRBTUNsbVJ4VVBHU3pzbnZqQlozZk8rM0ZJ?=
 =?utf-8?B?ODd0VWdnY2d3WjhMS2wwK2lWUkRmbFJtcUpPYmRCQTFLM1pJV2g5eG5TdCt2?=
 =?utf-8?B?aU1tQ3FJUm9JU1AwNlZ3aGFjcEZBRlhMekJWMWEvbTZYRmZxQVNMNkIvVEJ6?=
 =?utf-8?B?dWZES0cwS0pOMUNpRXRKckFTUkxVZTNyMVNhQjZBdi9tRXRuYTY5K1Z3RFk2?=
 =?utf-8?B?SVZlN1l4U0pzL0JNbEh6MFUrYXU1TVpleFA4S3J6M3RVa3hSNHFLWVNRaVE2?=
 =?utf-8?B?bUx5YUg3eDdaSmY3Tmo0YzVHSVZwUmYxK2IwS0Rxbzcxbzl0d3p2dVEvN1Bi?=
 =?utf-8?B?REs5SnUvM0lLelFVbjROWlY0emdSRlBVUVphZXgyRDg3UmtZTk5Ic1ZVNTFG?=
 =?utf-8?B?Nm50MEU2YnVjM0k5ZDFuWWxYZ0RmTi9RaUFKZDgvRmVWSkhuRElpZDFqazVC?=
 =?utf-8?B?dHphZWFCSyt5MWxEaE4xb1NXeHJEM3c3N3V1V3g4RXdWOHFlQzloTHJpMktV?=
 =?utf-8?B?QUQ3VVFPRFI3SjVMKzJRaHJJSlA0Tk9ZN20wU0lqWDgyclZ1ZFlGZkJraDc1?=
 =?utf-8?B?ZVl0K1k1TktYcWpxU2FwdTluMS9GV3Q3eXB6bjBlc0hhYXRkdkJ5RU1uTW9L?=
 =?utf-8?B?OVFaMHJpWDRYL1VtbHo5U0dIVy9vaDloem83QWdxNTNmZ2FWOWlDSXUxRTVR?=
 =?utf-8?Q?LhxRiUO6MdHog?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(35042699013)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:05:39.0184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc5e7e1-9a7d-4329-a6d2-08dc70073246
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8162

SGVsbG8gZm9sa3MNCg0KSSBhcHByZWNpYXRlIHlvdSdyZSBhbGwgYnVzeSwgYnV0IGFueSBmZWVk
YmFjayBvbiB0aGlzIG9uZT8NCg0KVGhhbmtzDQpCZW4NCg0KDQoNCg0KT24gTW9uLCAyMDI0LTA0
LTE1IGF0IDA5OjE0ICswMTAwLCBCZW4gR2FpbmV5IHdyb3RlOg0KPiBUaGlzIGNoYW5nZSBhbGxv
d3MgZXZlbnRzIHRvIHVzZSBQRVJGX1NBTVBMRSBSRUFEIHdpdGggaW5oZXJpdCBzbw0KPiBsb25n
DQo+IGFzIFBFUkZfU0FNUExFX1RJRCBpcyBhbHNvIHNldC4NCj4NCj4gQ3VycmVudGx5IGl0IGlz
IG5vdCBwb3NzaWJsZSB0byB1c2UgUEVSRl9TQU1QTEVfUkVBRCB3aXRoIGluaGVyaXQuDQo+IFRo
aXMNCj4gcmVzdHJpY3Rpb24gYXNzdW1lcyB0aGUgdXNlciBpcyBpbnRlcmVzdGVkIGluIGNvbGxl
Y3RpbmcgYWdncmVnYXRlDQo+IHN0YXRpc3RpY3MgYXMgcGVyIGBwZXJmIHN0YXRgLiBJdCBwcmV2
ZW50cyBhIHVzZXIgZnJvbSBjb2xsZWN0aW5nDQo+IHBlci10aHJlYWQgc2FtcGxlcyB1c2luZyBj
b3VudGVyIGdyb3VwcyBmcm9tIGEgbXVsdGktdGhyZWFkZWQgb3INCj4gbXVsdGktcHJvY2VzcyBh
cHBsaWNhdGlvbiwgYXMgd2l0aCBgcGVyZiByZWNvcmQgLWUgJ3suLi4ufTpTJ2AuDQo+IEluc3Rl
YWQNCj4gdXNlcnMgbXVzdCB1c2Ugc3lzdGVtLXdpZGUgbW9kZSwgb3IgZm9yZ28gdGhlIGFiaWxp
dHkgdG8gc2FtcGxlDQo+IGNvdW50ZXINCj4gZ3JvdXBzLiBTeXN0ZW0td2lkZSBtb2RlIGlzIG9m
dGVuIHByb2JsZW1hdGljIGFzIGl0IHJlcXVpcmVzIHNwZWNpZmljDQo+IHBlcm1pc3Npb25zIChu
byBDQVBfUEVSRk1PTiAvIHJvb3QgYWNjZXNzKSwgb3IgbWF5IGxlYWQgdG8gY2FwdHVyZSBvZg0K
PiBzaWduaWZpY2FudCBhbW91bnRzIG9mIGV4dHJhIGRhdGEgZnJvbSBvdGhlciBwcm9jZXNzZXMg
cnVubmluZyBvbiB0aGUNCj4gc3lzdGVtLg0KPg0KPiBUaGlzIHBhdGNoIGNoYW5nZXMgYHBlcmZf
ZXZlbnRfYWxsb2NgIHJlbGF4aW5nIHRoZSByZXN0cmljdGlvbg0KPiBhZ2FpbnN0DQo+IGNvbWJp
bmluZyBgaW5oZXJpdGAgd2l0aCBgUEVSRl9TQU1QTEVfUkVBRGAgc28gdGhhdCB0aGUgY29tYmlu
YXRpb24NCj4gd2lsbCBiZSBhbGxvd2VkIHNvIGxvbmcgYXMgYFBFUkZfU0FNUExFX1RJRGAgaXMg
ZW5hYmxlZC4gSXQgbW9kaWZpZXMNCj4gc2FtcGxpbmcgc28gdGhhdCBvbmx5IHRoZSBjb3VudCBh
c3NvY2lhdGVkIHdpdGggdGhlIGFjdGl2ZSB0aHJlYWQgaXMNCj4gcmVjb3JkZWQgaW50byB0aGUg
YnVmZmVyLiBJdCBtb2RpZmllcyB0aGUgY29udGV4dCBzd2l0Y2ggaGFuZGxpbmcgc28NCj4gdGhh
dCBwZXJmIGNvbnRleHRzIGFyZSBhbHdheXMgc3dpdGNoZWQgb3V0IGlmIHRoZXkgaGF2ZSB0aGlz
IGtpbmQgb2YNCj4gZXZlbnQgc28gdGhhdCB0aGUgY29ycmVjdCBwZXItdGhyZWFkIHN0YXRlIGlz
IG1haW50YWluZWQuIEZpbmFsbHksDQo+IHRoZQ0KPiB0b29scyBhcmUgdXBkYXRlZCB0byBhbGxv
dyBwZXJmIHJlY29yZCB0byBzcGVjaWZ5IHRoaXMgY29tYmluYXRpb24NCj4gYW5kDQo+IHRvIGNv
cnJlY3RseSBkZWNvZGUgdGhlIHNhbXBsZSBkYXRhLg0KPg0KPiBJbiB0aGlzIGNvbmZpZ3VyYXRp
b24gc3RyZWFtIGlkcyAoc3VjaCBhcyBtYXkgYXBwZWFyIGluIHRoZQ0KPiByZWFkX2Zvcm1hdA0K
PiBmaWVsZCBvZiBhIFBFUkZfUkVDT1JEX1NBTVBMRSkgYXJlIG5vIGxvbmdlciBnbG9iYWxseSB1
bmlxdWUsIHJhdGhlcg0KPiB0aGUgcGFpciBvZiAoc3RyZWFtIGlkLCB0aWQpIHVuaXF1ZWx5IGlk
ZW50aWZ5IGVhY2ggZXZlbnQuIFRvb2xzIHRoYXQNCj4gcmVseSBvbiB0aGlzLCBmb3IgZXhhbXBs
ZSB0byBjYWxjdWxhdGUgYSBkZWx0YSBiZXR3ZWVuIHNhbXBsZXMsIHdvdWxkDQo+IG5lZWQgdXBk
YXRpbmcgdG8gdGFrZSB0aGlzIGludG8gYWNjb3VudC4gUHJldmlvdXNseSB2YWxpZCBldmVudA0K
PiBjb25maWd1cmF0aW9ucyAoc3lzdGVtLXdpZGUsIG5vLWluaGVyaXQgYW5kIHNvIG9uKSB3aGVy
ZSBlYWNoIHN0cmVhbQ0KPiBpZA0KPiBpcyB0aGUgaWRlbnRpZmllciBhcmUgdW5hZmZlY3RlZC4N
Cj4NCj4NCj4gQ2hhbmdlcyBzaW5jZSB2NDoNCj4gIC0gUmViYXNlIG9uIHY2LjktcmMxDQo+ICAt
IFJlbW92ZWQgdGhlIGRlcGVuZGVuY3kgb24gaW5oZXJpdF9zdGF0IHRoYXQgd2FzIHByZXZpb3Vz
bHkgYXNzdW1lZA0KPiAgICBuZWNlc3NhcnkgYXMgcGVyIGZlZWRiYWNrIGZyb20gTmFtaHl1bmcg
S2ltLg0KPiAgLSBGaXhlZCBhbiBpbmNvcnJlY3QgdXNlIG9mIHpmcmVlIGluc3RlYWQgb2YgZnJl
ZSBpbiB0aGUgdG9vbHMNCj4gbGVhZGluZw0KPiAgICB0byBhbiBhYm9ydCBvbiB0b29sIHNodXRk
b3duLg0KPiAgLSBBZGRpdGlvbmFsIHRlc3QgY292ZXJhZ2UgaW1wcm92ZW1lbnRzIGFkZGVkIHRv
IHBlcmYgdGVzdC4NCj4gIC0gQ2xlYW5lZCB1cCB0aGUgcmVtYWluaW5nIGJpdCBvZiBpcnJlbGV2
YW50IGNoYW5nZSBtaXNzZWQgYmV0d2Vlbg0KPiB2Mw0KPiAgICBhbmQgdjQuDQo+DQo+IENoYW5n
ZXMgc2luY2UgdjM6DQo+ICAtIENsZWFuZWQgdXAgcGVyZiB0ZXN0IGRhdGEgY2hhbmdlcyBpbmNv
cnJlY3RseSBpbmNsdWRlZCBpbnRvIHRoaXMNCj4gICAgc2VyaWVzIGZyb20gZWxzZXdoZXJlLg0K
Pg0KPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiAgLSBSZWJhc2Ugb24gdjYuOA0KPiAgLSBSZXNwb25k
IHRvIEphbWVzIENsYXJrZSdzIGZlZWRiYWNrOyBmaXh1cCBzb21lIHR5cG9zIGFuZCBtb3ZlIHNv
bWUNCj4gICAgcmVwZWF0ZWQgY2hlY2tzIGludG8gYSBoZWxwZXIgbWFjcm8uDQo+ICAtIENsZWFu
ZWQgdXAgY2hlY2twYXRjaCBsaW50cy4NCj4gIC0gVXBkYXRlZCBwZXJmIHRlc3Q7IGZpeGVkIGV2
c2VsIGhhbmRsaW5nIHNvIHRoYXQgZXhpc3RpbmcgdGVzdHMNCj4gcGFzcw0KPiAgICBhbmQgYWRk
ZWQgbmV3IHRlc3RzIHRvIGNvdmVyIHRoZSBuZXcgYmVoYXZpb3VyLg0KPg0KPiBDaGFuZ2VzIHNp
bmNlIHYxOg0KPiAgLSBSZWJhc2Ugb24gdjYuOC1yYzENCj4gIC0gRml4ZWQgdmFsdWUgd3JpdHRl
biBpbnRvIHNhbXBsZSBhZnRlciBjaGlsZCBleGlzdHMuDQo+ICAtIE1vZGlmaWVkIGhhbmRsaW5n
IG9mIHN3aXRjaC1vdXQgc28gdGhhdCBjb250ZXh0IHdpdGggdGhlc2UgZXZlbnRzDQo+ICAgIHRh
a2UgdGhlIHNsb3cgcGF0aCwgc28gdGhhdCB0aGUgcGVyLWV2ZW50L3Blci10aHJlYWQgUE1VIHN0
YXRlIGlzDQo+ICAgIGNvcnJlY3RseSBzd2l0Y2hlZC4NCj4gIC0gTW9kaWZpZWQgcGVyZiB0b29s
cyB0byBzdXBwb3J0IHRoaXMgbW9kZSBvZiBvcGVyYXRpb24uDQo+DQo+IEJlbiBHYWluZXkgKDQp
Og0KPiAgIHBlcmY6IFN1cHBvcnQgUEVSRl9TQU1QTEVfUkVBRCB3aXRoIGluaGVyaXQNCj4gICB0
b29scy9wZXJmOiBUcmFjayB3aGVyZSBwZXJmX3NhbXBsZV9pZHMgbmVlZCBwZXItdGhyZWFkIHBl
cmlvZHMNCj4gICB0b29scy9wZXJmOiBDb3JyZWN0bHkgY2FsY3VsYXRlIHNhbXBsZSBwZXJpb2Qg
Zm9yIGluaGVyaXRlZA0KPiAgICAgU0FNUExFX1JFQUQgdmFsdWVzDQo+ICAgdG9vbHMvcGVyZjog
QWxsb3cgaW5oZXJpdCArIFBFUkZfU0FNUExFX1JFQUQgd2hlbiBvcGVuaW5nIGV2ZW50cw0KPg0K
PiAgaW5jbHVkZS9saW51eC9wZXJmX2V2ZW50LmggICAgICAgICAgICAgICAgICAgIHwgIDEgKw0K
PiAga2VybmVsL2V2ZW50cy9jb3JlLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgODIgKysr
KysrKysrKysrKystLS0NCj4gLS0NCj4gIHRvb2xzL2xpYi9wZXJmL2V2bGlzdC5jICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxICsNCj4gIHRvb2xzL2xpYi9wZXJmL2V2c2VsLmMgICAgICAgICAg
ICAgICAgICAgICAgICB8IDQ4ICsrKysrKysrKysrDQo+ICB0b29scy9saWIvcGVyZi9pbmNsdWRl
L2ludGVybmFsL2V2c2VsLmggICAgICAgfCA1NCArKysrKysrKysrKy0NCj4gIHRvb2xzL3BlcmYv
dGVzdHMvYXR0ci9SRUFETUUgICAgICAgICAgICAgICAgICB8ICAyICsNCj4gIC4uLi90ZXN0cy9h
dHRyL3Rlc3QtcmVjb3JkLWdyb3VwLXNhbXBsaW5nICAgICB8IDM5IC0tLS0tLS0tLQ0KPiAgLi4u
L3Rlc3RzL2F0dHIvdGVzdC1yZWNvcmQtZ3JvdXAtc2FtcGxpbmcxICAgIHwgNTAgKysrKysrKysr
KysNCj4gIC4uLi90ZXN0cy9hdHRyL3Rlc3QtcmVjb3JkLWdyb3VwLXNhbXBsaW5nMiAgICB8IDYw
ICsrKysrKysrKysrKysrDQo+ICB0b29scy9wZXJmL3Rlc3RzL2F0dHIvdGVzdC1yZWNvcmQtZ3Jv
dXAyICAgICAgfCAgOSArLQ0KPiAgdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMgICAgICAgICAgICAg
ICAgICAgICAgIHwgMTkgKysrKy0NCj4gIHRvb2xzL3BlcmYvdXRpbC9ldnNlbC5oICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxICsNCj4gIHRvb2xzL3BlcmYvdXRpbC9zZXNzaW9uLmMgICAgICAg
ICAgICAgICAgICAgICB8IDExICsrLQ0KPiAgMTMgZmlsZXMgY2hhbmdlZCwgMzA2IGluc2VydGlv
bnMoKyksIDcxIGRlbGV0aW9ucygtKQ0KPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3BlcmYv
dGVzdHMvYXR0ci90ZXN0LXJlY29yZC1ncm91cC1zYW1wbGluZw0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IHRvb2xzL3BlcmYvdGVzdHMvYXR0ci90ZXN0LXJlY29yZC1ncm91cC1zYW1wbGluZzENCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3Rlc3RzL2F0dHIvdGVzdC1yZWNvcmQtZ3Jv
dXAtc2FtcGxpbmcyDQo+DQoNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlz
IGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28g
YmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxl
YXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhl
IGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9y
IHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4N
Cg==
