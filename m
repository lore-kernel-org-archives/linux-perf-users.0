Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74E433C7;
	Fri,  7 Jun 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755408; cv=fail; b=efUCDsx4iBWrTkhlCxhF/xT+QkiNH/vgqPra2+hxjbi3XjsDxNGjhSIij9JmdVv7lpP0EBE6r2zGwdUDGm0l/bXp9s+FTBq/JB+12VzQODyL6scDuifLQcHGoRt9cSAlWahTi3cGKmsaAbitBcK+Rj3lGZDoJ+l0CtmYAsTL544=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755408; c=relaxed/simple;
	bh=QqNE24hBfcAK5045z7dEBME0uTAael5eD+LRYE58CgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tp11gjqzXa4PIECfjCLVGTiPSwP8Slli3jaeQRdSzurs2fZ9c0Wo8eq+KicHAi6zQFK1xXmtChvKQFmJhX52FmaB3evXNWFfcOFijFCmnmuEKz7yjzUBQTwDZEbW68x8Q+UTdoUBq7z57ontIhpB42Sb7zyOU2DVXU3u41Xvgo8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sIkYCbUm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sIkYCbUm; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sIkYCbUm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sIkYCbUm"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=XBJWySrBuSbmfc5bWvqmWbYC5QH30fk2rSM0KkH5c0x2pVw3x47BXsV9UyBbFLKyHKBWfiLehK9YtpWqVz8t+YW/8DuAYZ7uNiNZj3sqKzJf3TAjHKq8M+M7B1wdNs0IfStJkkaw82n/F7na3YUX1Bk0CPNdu5L+DyDcbXdR+mIARWa1krNjdFTXuwghg4/irXZBfg2lBK2eDn0oMhv1qCcbeD1BDf48s868+aF/ZLKGrgWdCR/b8PcFGapY8hsRWhfmehpX9Wwzg0b4MTOFeALPNRpHpKa4LVxgfeaSqIQe9BhD1NOwQ02VTlkOj80NvzwPJBpO1EWd9GQnHueL4w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqNE24hBfcAK5045z7dEBME0uTAael5eD+LRYE58CgE=;
 b=E8n3/A+l0dkfgskKmabG4/JMIuK564HeWsWuNEbMrhdeWEiuvKVi4IhmCM0k2WdoulQsC1bRqcZXd3GTWuxKS2N+fTvZZSTxZ8M6JCqvungkQLaP8t/r29XqakOAeNujYaWRYuoe7Sq+f9pH36kP0Y93xYbYJ/5FBPYs3muuNXo9x0j1P9X4/DLdD2swJXKviOE2CFilbNhtyp+LMBEh6zwMSK//ZICv9eILHH9Fy1dPKkhFsTojLe8a0hwy9WnG6bS+g89bpZlTs21sOZ1coz7Zjg34Qx5tdOjz+WXZ89x+Ch6FusvjlUbEkHYvif/BhczHCvChC5q/aTvdIJdzdQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqNE24hBfcAK5045z7dEBME0uTAael5eD+LRYE58CgE=;
 b=sIkYCbUmG6RggRxShJgx/JlJqjF/T+F1EgxFS82Ic/51Zta1YuGxi3ttS/OIXx5C5hKt0aBnrEbOWdbRBRqKRDwQKPYTreTlCESzE4x12vrloB2/FnOVQMEN2TIshyHIBtrTKO9VEZSopKNJFZnsdLzOm1Bu1+NdB+tWH/YNEdU=
Received: from AS4P251CA0028.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::17)
 by DU0PR08MB8884.eurprd08.prod.outlook.com (2603:10a6:10:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 10:16:31 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::91) by AS4P251CA0028.outlook.office365.com
 (2603:10a6:20b:5d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.27 via Frontend
 Transport; Fri, 7 Jun 2024 10:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Fri, 7 Jun 2024 10:16:31 +0000
Received: ("Tessian outbound 7136819eaef8:v330"); Fri, 07 Jun 2024 10:16:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 23ab990221f49467
X-CR-MTA-TID: 64aa7808
Received: from 63e1c0ac13fe.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id EAFDEDD8-BEE2-46F9-B8AC-7F98A968B391.1;
	Fri, 07 Jun 2024 10:16:19 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 63e1c0ac13fe.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 07 Jun 2024 10:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK+3ig3T6tvtFU5nQVmFkma80b0VIsXTblQIC8M2FwqlhEbBAWTxtzIPOvsBgY9ISnEfoZ5wMYOaOJZgEOvix+3+dVpeD+K0jqNnH9WWIKSepbimHIyuRQ/qdImVhHQ3RrE6eHomAqX5e4HQgv5B0oVHZN15oZZfF6590l8DN9+y/VUFTff6ehw1YszLVdbK3ODbCwXn1H7DClVQZX5Wr6PX7LkIeUzJpqM0Hzp+FKKpD/HUCCD35fg5u2PfuPh4DWz5fT4p2qiMXcPVE9tMOMXhrLHT4zdnwItTzLIY7uAqhkGmnxPsHsN6YHEqXfwBRWUrMURtoGY1nJIKi80fvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqNE24hBfcAK5045z7dEBME0uTAael5eD+LRYE58CgE=;
 b=n5+xPKzuXtiqOLEzdrCq6u1UzcsdvUGwZijdo8KiveQATkkeem6TU/QvhLIOYKnlad5HZ3YVvbvqfEpSsYlEyijSo7HLDBFNLl9eily3zhvnC/Lj2xgzEGCLr0ATjCS2Zk/wK67NcdC4jBjayCj4SAc1nMK3cfuePIQ3Gik/aZlydVAm1I3aOkUdtYZVzpiYoG2RWQ2QKY+FCUVemlO5oRLzvMUdpV/eRAMR9QHgy71SF7dYKI/4CC72yb+45BMzku7Ju+8dEErYerLCoumIeJ2GBdXCVvfdJ7FBZ8Vh20Dm6cVDTdFztlOiqFZGaoLiwtG7bzVQeSwkMhifoQK+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqNE24hBfcAK5045z7dEBME0uTAael5eD+LRYE58CgE=;
 b=sIkYCbUmG6RggRxShJgx/JlJqjF/T+F1EgxFS82Ic/51Zta1YuGxi3ttS/OIXx5C5hKt0aBnrEbOWdbRBRqKRDwQKPYTreTlCESzE4x12vrloB2/FnOVQMEN2TIshyHIBtrTKO9VEZSopKNJFZnsdLzOm1Bu1+NdB+tWH/YNEdU=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by DBBPR08MB10625.eurprd08.prod.outlook.com (2603:10a6:10:53b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 10:16:15 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 10:16:15 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "acme@kernel.org" <acme@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, James Clark <James.Clark@arm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v7 1/4] perf: Support PERF_SAMPLE_READ with inherit
Thread-Topic: [PATCH v7 1/4] perf: Support PERF_SAMPLE_READ with inherit
Thread-Index: AQHauB+aYPUvOE0NMky2m9mad2CDerG8CxkAgAAMHYA=
Date: Fri, 7 Jun 2024 10:16:15 +0000
Message-ID: <451afb8eb03f1519c482a84a6c1cbd1e62222988.camel@arm.com>
References: <20240606144059.365633-1-ben.gainey@arm.com>
	 <20240606144059.365633-2-ben.gainey@arm.com>
	 <20240607093254.GN8774@noisy.programming.kicks-ass.net>
In-Reply-To: <20240607093254.GN8774@noisy.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|DBBPR08MB10625:EE_|AMS1EPF00000042:EE_|DU0PR08MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 448a9acc-05c0-48be-bd87-08dc86dae6d6
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZG82UExJdFl2MlVWZEVMOERucWdxOG05eTNqTnNtMFkxWFJ1NjRiTWgyUXlY?=
 =?utf-8?B?NVN0NCtRcnBvcHJJQlE3Zld5eUxKdnpSOG02L2lFRWE4T0dmSVlEc2lIcTUw?=
 =?utf-8?B?Ly9jRHdKYkNDMFNvSUwrcGpYaXNhTjV2ZU9GQlppVVM4YlVaUVlicGpIQ2hh?=
 =?utf-8?B?eGdLSWRHVy9ocElQOWZ1NnluSDVGTHkxQWFwNkM1Q3VrTE51ZzVacnRzNDg2?=
 =?utf-8?B?U2pEZjFlQjJ1UXdhM21kMDFDRCs1WDFwalJKblNwcDhDWi9jZXQrUm1HcWZ5?=
 =?utf-8?B?RjdJM3ZtMituZXBwOXVvS2lMSWtkVkJLaGltcGF2dW9NRmJZK3JSVlVubTky?=
 =?utf-8?B?Z284ZkpGb2JSa2phSDBCbjZUK09DemtOcnpFTERGSU1rbHFtbzFtTUFCcDVO?=
 =?utf-8?B?V1lQMW16aGlwZDNiNUhyRmRrSTdZb3RYN3FKRHBQQlQvUGM1dXpqWllneW9Q?=
 =?utf-8?B?bC96aE9UcURrZkhuc0h0dC9nOXRINWxRWVMxdlpxZUhWQ3o2OXVDWFFJSHl6?=
 =?utf-8?B?Q2ljRkZIL0VCYldGMHBkODQrU05XcHppcm5KSXJ0bnE3ZXRVUWRrdW9iNFhx?=
 =?utf-8?B?dEVPR1dIcENXZ3pGMjJFNmFPdnNqS3k3S0VXWEJHZHI3Q3BXcWE2NjJLSnlR?=
 =?utf-8?B?NUFBTG1Yd0VMS0VpVWwwODNsa0tteVhyQlBBU2tyOEdONm1mQkRQQXoybE9i?=
 =?utf-8?B?dFJWM2FyUXhheDhDZEYrbkZkREc5QVFORTlULzRjTnlmVmY2b0RQemdwNVBJ?=
 =?utf-8?B?VnA1TkxkRURkN0FBZmNLdlFYSGtNNVhyT3Ruai9aWmFJNEJlc2NRcitWclFB?=
 =?utf-8?B?dko2eTVVV2k2d0FuNTNtam5KMXliSVZNQitVNkxySWJyMDNxd0hzMVRDekxl?=
 =?utf-8?B?ZW96bVhTWk1mYnJzeHIvV0dLb1JiSzAzYUk1RjUxZ0JRb2ZmZ2dTYjJJWFNx?=
 =?utf-8?B?RzFUNmtETEZkcmhqVU44MDFQaExJT01ZSzROMTFudFFEL3RkaUpncEF1SUt1?=
 =?utf-8?B?S1VramVxT3kxb3BWOGxCWDhISmVleWNvWi8ydWppd3Y3SVROL1U5SGFuOW9F?=
 =?utf-8?B?cHlEdUg4MkJFZU1JcndMVlNncTdjaEtjKzczK3FFM2hiMTgvQUh2QzNLUWdL?=
 =?utf-8?B?Uk5nNXNNakN4MGRRWnA3Ri9QdlhxbTZxaldzcndnclF5K09jdmZsTktiejZ4?=
 =?utf-8?B?aVY2bEpYTGs5T2hsNkx5ZzNvQWg0N0NYQjR4ZXNxVCtFcm9NS1JIT0pXY1B1?=
 =?utf-8?B?akZRVVlMMDhWeTNjdmo3TlJTNzM3SGRDL0lrT3RBQkNCUzBBdjVZS0drREpi?=
 =?utf-8?B?UzNRNktEdm8yZGJnTzgya3FLa01ubXh1Mm14SU1HcVlvbi9zZGk4dTBodC8v?=
 =?utf-8?B?dlJDRjZhcVRyekQvcURhcVorQVVGWXBxUmdQU1RXQ3hpTitUeTQyQjE3TFJv?=
 =?utf-8?B?aWJlbkxmcjJFdDNoeUIyYmQwUnZsdzhSNjM0K3BiTUdlc2gzaE85VTl2V25Y?=
 =?utf-8?B?VjU4Y0xjY2NTSkp3WmdvQkw4ZWpZdW92OWFxbzV4Q0JNK3pYYXF2UnpGSUtq?=
 =?utf-8?B?eWlSSW9NcE1hTnVlWXBnald0aGNXVVV2L3BJZEdKd0tPTW1KV01UWkF3ZVg2?=
 =?utf-8?B?MWFyZDJ0WDBBV2FjdGx1dU9sbUkxeHNEQkhwdkF1bHdaTytuK0lGR3hzUDFB?=
 =?utf-8?B?a0J2N0NDR0kzK3BTOWpBVnRvUnljYWRWRjBna3ovcVNnSllzL3FlcFA5aWtp?=
 =?utf-8?B?UDhVcmdCNDFMaGhzQ1BiK2dWRkNvZGVxa1F4SjNja3JidDhpTjR2S2J2b3RF?=
 =?utf-8?Q?ZA4ktwXKS1xDnm6/WpLdRxLyDYJONa3QaP0ic=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD8AC78B6797A946B9E1E29545AD9591@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10625
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	71caffcd-e68d-4da0-3e86-08dc86dadd91
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|35042699013|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDRITWFoU2FvNkRZU0tjL3BnenROdE1mMmgva0k4U3c1UDB3ZCtYbVpKMVNo?=
 =?utf-8?B?bDRVU0o3MG4yRGw0MDJCT0VwOUl4OHA0V0hWeW02TXdraWJMUUxPbktKWEVw?=
 =?utf-8?B?c2tCbGRpQVJSLzI0eEtnc1cyMHZ4T2JiQU1wVU90U3hGMkpocG1kaTNjMFls?=
 =?utf-8?B?dUZkYmVWM21oNFJTeDIxYkpINnVTSzFRdDdONHBldk40VG1Pb3RyUHYrS05z?=
 =?utf-8?B?dzM2Tm5CbFRnWW5Ucm9PY0xSR3ZkZUFhZzlUbG1meXBubXVBWVBwR3pFcTJJ?=
 =?utf-8?B?T2o1c2VNeU1hZVlJODE1dXJsR1NSanZOekZvdmFnSG96Z2YyS1puTjdPM1pJ?=
 =?utf-8?B?eU8yc1FlNUJLY254YzZ4VTdzU2s0SXBHdWhob0lkSUJrNWhjMUZEVDN5Vmpw?=
 =?utf-8?B?bnlWM0VGT1pCNnFUREZJVGZnTUNIMGRWWCtmVHB1K0FlVzhLOFRhWnpDN2s2?=
 =?utf-8?B?UlpWVGN5UVNkYjNZc01wUzVITEhoRGxTc0xUcUtpSlBrZ3E4K05NWSswL1Bo?=
 =?utf-8?B?QktNaURmbjJac0ZBaUNRVUZrck1MS3hacWpMc2hzdVd0QXZaMXpLNS9pRXZC?=
 =?utf-8?B?ckhWQmUxYk5PSkhqdnV3TVRZVDJqRVF1TVdsQVVyeUhqYXpDbGd5WllEVWdE?=
 =?utf-8?B?N1pWaW9HTUlqV1RXSmdTZWFjWm9tOCtIekljTy92MFp3QURvRE92QS9QczlE?=
 =?utf-8?B?Rmc3ajVkMWhjdXlrTlNYdkRBclF3RXFERVNLby90ckxZQmpHbVlWK2RSY25t?=
 =?utf-8?B?TW5adWNSN21jWklIa3paL2QxUmI4MnF2TXNYVUpPVEErdzRoWHZQNFViL3FB?=
 =?utf-8?B?ay9NQndhYjRWeVppSDdKL002WEFMWS8zczU3OENBS3JwNmZ5WnlFNHp1c2R3?=
 =?utf-8?B?SFM4bVFVZ0k5eDRIWmcvT2dXdnRPUytDTU44ZHZQVmZ0a2pENThNcVVqRXZZ?=
 =?utf-8?B?ZEZ0ZWN2Vkg0WlhvWUVUMERHcHFWRk9oRlBSSnFBQ01PL0ZwdVBZMFhWODRZ?=
 =?utf-8?B?QkRmZlhsWkZ1L0pyOEJGRjMvRXhHN0pLVnpZdlFlUlV1dkJjTHVpbW9PK2RR?=
 =?utf-8?B?Tjg5cGM0V2ZMelM0aUJMaFlUdXVveHUySjNiUk5vUE5JTzhTcUE1bkt1T1M0?=
 =?utf-8?B?U1RCUmJBNTdGN01LYXlpclFtMnlocWpQNmNYN01lZ1VkaFZpeHB0cEdmWXZT?=
 =?utf-8?B?M25oeFdWQ0RvZDBaNG1LaUlwbUF6WnlxYmROOS9xSGlOOElBcUxydGhkdGtU?=
 =?utf-8?B?YWFBRTJMUFZlY2xUaG90a0xWeHhObVhOVTJMYlJRWUdIUHZVTURKd3NESDgw?=
 =?utf-8?B?bitpeERXSmNnVHlNU0xEYmE4WDZlMngrSzk0ZmZaeXppYXZoWFU4NDZFUTFa?=
 =?utf-8?B?NnFINjYwbWdiemVYMGFEYXRBd1lucm1Vc3MvaWV5T2VsWXdMeE90dTRTdktm?=
 =?utf-8?B?SU9iSkdWeEVxS2RmeHlETEtOM2ZPREhNck1CUlU2TlpCRWc1NzcrWUNxSG5J?=
 =?utf-8?B?aXhjVlN4VG9qdHBsaHlPVXBWODMwT0hQdWNXQ24wNlZibGQrN2h6ZW56S3Rk?=
 =?utf-8?B?K0tmMlpvTzY4c3paWHoxTHZWMkUva2xkeFpCT3hxRTVoK2R5Q01wUk5aS091?=
 =?utf-8?B?NUs3Yk1HRURIQnNWSTBvYnA3RlZqd3BlZjh6T0p4R3F4OGdRa2lrVm9uK282?=
 =?utf-8?B?a01PWjZ2MEV0MEdRSS9objVpNEE3T0hKZU9WMjFTbzRtTzRETlQ4N0lmWjYr?=
 =?utf-8?B?ZHhlT010dlpXOG0yR0VaSXhhbUduTUc5eXA3SmlJYjM0OHpPK0FFRmtHQy9p?=
 =?utf-8?B?RnpNYkFhRUZXeDRTWjFJUkJ2eGhkeXN6azMxK04rVS9FeWM4Z0xWNHF3NWFj?=
 =?utf-8?B?aVN4cWtDWnVLTDhIc05JRFhsN015QXZEUlZFenczMldZM0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(1800799015)(35042699013)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:16:31.2187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 448a9acc-05c0-48be-bd87-08dc86dae6d6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8884

T24gRnJpLCAyMDI0LTA2LTA3IGF0IDExOjMyICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBKdW4gMDYsIDIwMjQgYXQgMDM6NDA6NTZQTSArMDEwMCwgQmVuIEdhaW5leSB3
cm90ZToNCj4gPiBUaGlzIGNoYW5nZSBhbGxvd3MgZXZlbnRzIHRvIHVzZSBQRVJGX1NBTVBMRSBS
RUFEIHdpdGggaW5oZXJpdA0KPiA+IHNvIGxvbmcgYXMgUEVSRl9TQU1QTEVfVElEIGlzIGFsc28g
c2V0Lg0KPiA+IA0KPiA+IEluIHRoaXMgY29uZmlndXJhdGlvbiwgYW4gZXZlbnQgd2lsbCBiZSBp
bmhlcml0ZWQgaW50byBhbnkNCj4gPiBjaGlsZCBwcm9jZXNzZXMgLyB0aHJlYWRzLCBhbGxvd2lu
ZyBjb252ZW5pZW50IHByb2ZpbGluZyBvZiBhDQo+ID4gbXVsdGlwcm9jZXNzIG9yIG11bHRpdGhy
ZWFkZWQgYXBwbGljYXRpb24sIHdoaWxzdCBhbGxvd2luZw0KPiA+IHByb2ZpbGluZyB0b29scyB0
byBjb2xsZWN0IHBlci10aHJlYWQgc2FtcGxlcywgaW4gcGFydGljdWxhcg0KPiA+IG9mIGdyb3Vw
cyBvZiBjb3VudGVycy4NCj4gDQo+IFBlcmhhcHMgYSBmZXcgd29yZHMgb24gKldIWSogdGhpcyBp
cyBpbXBvcnRhbnQuDQo+IA0KPiA+IFRoZSByZWFkX2Zvcm1hdCBmaWVsZCBvZiBib3RoIFBFUkZf
UkVDT1JEX1JFQUQgYW5kDQo+ID4gUEVSRl9SRUNPUkRfU0FNUExFDQo+ID4gYXJlIGNoYW5nZWQg
YnkgdGhpcyBuZXcgY29uZmlndXJhdGlvbiwgYnV0IGNhbGxzIHRvIGByZWFkKClgIG9uIHRoZQ0K
PiA+IHNhbWUNCj4gPiBldmVudCBmaWxlIGRlc2NyaXB0b3IgYXJlIHVuYWZmZWN0ZWQgYW5kIGNv
bnRpbnVlIHRvIHJldHVybiB0aGUNCj4gPiBjdW11bGF0aXZlIHRvdGFsLg0KPiANCj4gVGhpcyBp
cyB1bmZvcnR1bmF0ZS4gVXAgdG8gdGhpcyBwb2ludCB0aGV5IHdlcmUgdGhlIHNhbWUuIEFsc28s
IEkgc2VlDQo+IG5vDQo+IGNoYW5nZSB0byB0aGUgdWFwaSBmaWxlLiBTbyB3ZXJlIHlvdSB0cnlp
bmcgdG8gc2F5IHRoYXQgb25seQ0KPiByZWFkX2Zvcm1hdDo6dmFsdWUgaXMgY2hhbmdlZCB0byBi
ZSB0aGUgdGhyZWFkIGxvY2FsIHZhbHVlIGFzIG9wcG9zZWQNCj4gdG8NCj4gdGhlIGhpZXJhcmNo
eSB0b3RhbD8NCj4gDQo+IFBsZWFzZSBmaXggdGhlIHdvcmRpbmcgdG8gYmUgdW5hbWJpZ3VvdXMg
YXMgdG8gd2hhdCBpcyBhY3R1YWxseQ0KPiBtZWFudC4NCj4gQWxzbyB0cnkgYW5kIGp1c3RpZnkg
d2h5IGl0IGlzIG9rYXkgdG8gYnJlYWsgdGhpcyBzeW1tZXRyeS4NCg0KDQpZZXMsIHRoZSBtZWFu
aW5nIG9mIHRoZSBQRVJGX1JFQ09SRF9TQU1QTEUncyByZWFkX2Zvcm1hdCB2YWx1ZSBjaGFuZ2Vz
DQppbiB0aGlzIHNwZWNpZmljIHNjZW5hcmlvIHRvIGJlIGEgdGhyZWFkLWxvY2FsIHZhbHVlIHJh
dGhlciB0aGFuIHRoZQ0KdG90YWwuDQoNCkknbGwgdXBkYXRlIGFuZCBhZGQgc29tZSBqdXN0aWZp
Y2F0aW9uLg0KDQo+IA0KPiA+IEBAIC0zNTMyLDExICszNTQ0LDE4IEBAIHBlcmZfZXZlbnRfY29u
dGV4dF9zY2hlZF9vdXQoc3RydWN0DQo+ID4gdGFza19zdHJ1Y3QgKnRhc2ssIHN0cnVjdCB0YXNr
X3N0cnVjdCAqbmV4dCkNCj4gPiDCoCBwZXJmX2N0eF9kaXNhYmxlKGN0eCwgZmFsc2UpOw0KPiA+
IMKgDQo+ID4gwqAgLyogUE1JcyBhcmUgZGlzYWJsZWQ7IGN0eC0+bnJfcGVuZGluZyBpcyBzdGFi
bGUuICovDQo+ID4gLSBpZiAobG9jYWxfcmVhZCgmY3R4LT5ucl9wZW5kaW5nKSB8fA0KPiA+ICsg
aWYgKGN0eC0+bnJfaW5oZXJpdF9yZWFkIHx8DQo+ID4gKyDCoMKgwqAgbmV4dF9jdHgtPm5yX2lu
aGVyaXRfcmVhZCB8fA0KPiA+ICsgwqDCoMKgIGxvY2FsX3JlYWQoJmN0eC0+bnJfcGVuZGluZykg
fHwNCj4gPiDCoCDCoMKgwqAgbG9jYWxfcmVhZCgmbmV4dF9jdHgtPm5yX3BlbmRpbmcpKSB7DQo+
IA0KPiBUaGlzIHNlZW1zIHVuZm9ydHVuYXRlLCBucl9wZW5kaW5nIGFuZCBucl9pbmhlcml0X3Jl
YWQgYXJlIGJvdGggdXNlZA0KPiBleGNsdXNpdmVseSB0byBpbmhpYml0IHRoaXMgY29udGV4dCBz
d2l0Y2ggb3B0aW1pemF0aW9uLiBTdXJlbHkgdGhleQ0KPiBjYW4NCj4gc2hhcmUgdGhlIGV4YWN0
IHNhbWUgY291bnRlci4NCj4gDQo+IFRoYXQgaXMsIHJlbmFtZSBucl9wZW5kaW5nIGFuZCB1c2Ug
aXQgZm9yIGJvdGg/DQoNCg0KU3VyZSwgaG93IGFib3V0ICJucl9ub19zd2l0Y2hfZmFzdCIgPw0K
DQoNCj4gDQo+ID4gwqAgLyoNCj4gPiDCoCAqIE11c3Qgbm90IHN3YXAgb3V0IGN0eCB3aGVuIHRo
ZXJlJ3MgcGVuZGluZw0KPiA+IMKgICogZXZlbnRzIHRoYXQgcmVseSBvbiB0aGUgY3R4LT50YXNr
IHJlbGF0aW9uLg0KPiA+ICsgKg0KPiA+ICsgKiBMaWtld2lzZSwgd2hlbiBhIGNvbnRleHQgY29u
dGFpbnMgaW5oZXJpdCArDQo+ID4gKyAqIFNBTVBMRV9SRUFEIGV2ZW50cyB0aGV5IHNob3VsZCBi
ZSBzd2l0Y2hlZA0KPiA+ICsgKiBvdXQgdXNpbmcgdGhlIHNsb3cgcGF0aCBzbyB0aGF0IHRoZXkg
YXJlDQo+ID4gKyAqIHRyZWF0ZWQgYXMgaWYgdGhleSB3ZXJlIGRpc3RpbmN0IGNvbnRleHRzLg0K
PiA+IMKgICovDQo+ID4gwqAgcmF3X3NwaW5fdW5sb2NrKCZuZXh0X2N0eC0+bG9jayk7DQo+ID4g
wqAgcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gQEAgLTQ1NTIsMTEgKzQ1NzEsMTkgQEAgc3RhdGlj
IHZvaWQgX19wZXJmX2V2ZW50X3JlYWQodm9pZCAqaW5mbykNCj4gPiDCoCByYXdfc3Bpbl91bmxv
Y2soJmN0eC0+bG9jayk7DQo+ID4gwqB9DQo+ID4gwqANCj4gPiAtc3RhdGljIGlubGluZSB1NjQg
cGVyZl9ldmVudF9jb3VudChzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQpDQo+ID4gK3N0YXRpYyBp
bmxpbmUgdTY0IHBlcmZfZXZlbnRfY291bnRfY3VtdWxhdGl2ZShzdHJ1Y3QgcGVyZl9ldmVudA0K
PiA+ICpldmVudCkNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgeW91IG5lZWQgdGhpcyAtLSBvdmVybHkg
bG9uZyBhbmQgaGFyZCB0byB0eXBlIGZ1bmN0aW9uDQo+IG5hbWUuLi4NCg0KU3VyZSwgcHJlc3Vt
YWJseSB5b3UgYXJlIGhhcHB5IHdpdGgganVzdCBjYWxsaW5nDQoicGVyZl9ldmVudF9jb3VudChl
dmVudCwgZmFsc2UpIiBldmVyeXdoZXJlIGl0IGlzIGN1cnJlbnRseSB1c2VkLA0KcmF0aGVyIHRo
YW4gcmVuYW1pbmcgaXQgdG8gc29tZXRoaW5nIHNob3J0ZXIgYW5kIGtlZXBpbmcgdGhlIHR3bw0K
ZnVuY3Rpb25zPw0KDQo+IA0KPiA+IMKgew0KPiA+IMKgIHJldHVybiBsb2NhbDY0X3JlYWQoJmV2
ZW50LT5jb3VudCkgKyBhdG9taWM2NF9yZWFkKCZldmVudC0NCj4gPiA+Y2hpbGRfY291bnQpOw0K
PiA+IMKgfQ0KPiA+IMKgDQo+ID4gK3N0YXRpYyBpbmxpbmUgdTY0IHBlcmZfZXZlbnRfY291bnQo
c3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50LCBib29sDQo+ID4gc2VsZl92YWx1ZV9vbmx5KQ0KPiA+
ICt7DQo+ID4gKyBpZiAoc2VsZl92YWx1ZV9vbmx5ICYmIGhhc19pbmhlcml0X2FuZF9zYW1wbGVf
cmVhZCgmZXZlbnQtPmF0dHIpKQ0KPiA+ICsgcmV0dXJuIGxvY2FsNjRfcmVhZCgmZXZlbnQtPmNv
dW50KTsNCj4gDQo+IC4uLiBpZiB0aGlzIEBzZWxmX3ZhbHVlX29ubHkgYXJndW1lbnQgd2FzIGFj
dHVhbGx5IHVzZWQgYXMgc3VjaCAtLSBpdA0KPiBpc24ndCwgc2VlIGhvdyB5b3UgdXNlICdmcm9t
X3NhbXBsZScgd2hpY2ggaXMgc29tZXRoaW5nIGVsc2UNCj4gZW50aXJlbHkuDQo+IFdoaWNoIHRo
ZW4gYWxzbyBjYXVzZWQgdG8geW91IGZpeCBpdCB1cCBhbmQgbWFrZSBhIG1lc3Mgd2l0aCB0aGF0
ICYmDQo+IGhhc19pbmhlcml0X2FuZF9zYW1wbGVfcmVhZCgpIG5vbnNlbnNlLiAoYWxzbywgc2hv
cnRlciBmdW5jdGlvbg0KPiBuYW1lcywNCj4gbW9yZSBnb29kKQ0KPiANCj4gPiArDQo+ID4gKyBy
ZXR1cm4gcGVyZl9ldmVudF9jb3VudF9jdW11bGF0aXZlKGV2ZW50KTsNCj4gPiArfQ0KPiANCj4g
VGhhdCBpcywgSSB3b3VsZCByZWFsbHkgcmF0aGVyIHlvdSBoYWQ6DQo+IA0KPiBzdGF0aWMgaW5s
aW5lIHU2NCBwZXJmX2V2ZW50X2NvdW50KHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCwgYm9vbA0K
PiBzZWxmKQ0KPiB7DQo+IMKgaWYgKHNlbGYpDQo+IMKgcmV0dXJuIGxvY2FsNjRfcmVhZCgmZXZl
bnQtPmNvdW50KTsNCj4gDQo+IMKgcmV0dXJuIGxvY2FsNjRfcmVhZCgmZXZlbnQtPmNvdW50KSAr
IGxvY2FsNjRfcmVhZCgmZXZlbnQtDQo+ID5jaGlsZF9jb3VudCk7DQo+IH0NCj4gDQo+IEFuZCB0
aGVuIGFjdHVhbGx5IHVzZSB0aGF0IGFyZ3VtZW50IGFzIGludGVuZGVkLg0KDQoNCkZhaXIgcG9p
bnQuDQoNCkkgd2FzIHRyeWluZyB0byBhdm9pZCB0aGUgMyBzdWJzZXF1ZW50IHVzZXMgYWxsIGhh
dmluZyB0byByZXBlYXQNCiJmcm9tX3NhbXBsZSAmJiBoYXNfaW5oZXJpdF9hbmRfc2FtcGxlX3Jl
YWQoJmV2ZW50LT5hdHRyKSIsIHdoaWNoIGZlZWxzDQphIGJpdCBvZiBhIHBpdC10cmFwcHkuwqAN
Cg0KSSBzdXBwb3NlIEkgY291bGQgcHVsbCB0aGF0IGludG8gYSAidXNlX3NlbGZfdmFsdWUoZnJv
bV9zYW1wbGUsZXZlbnQpIj8NCg0KDQo+IA0KPiA+IEBAIC03MjA1LDEzICs3MjMyLDE0IEBAIHZv
aWQgcGVyZl9ldmVudF9fb3V0cHV0X2lkX3NhbXBsZShzdHJ1Y3QNCj4gPiBwZXJmX2V2ZW50ICpl
dmVudCwNCj4gPiDCoA0KPiA+IMKgc3RhdGljIHZvaWQgcGVyZl9vdXRwdXRfcmVhZF9vbmUoc3Ry
dWN0IHBlcmZfb3V0cHV0X2hhbmRsZQ0KPiA+ICpoYW5kbGUsDQo+ID4gwqAgc3RydWN0IHBlcmZf
ZXZlbnQgKmV2ZW50LA0KPiA+IC0gdTY0IGVuYWJsZWQsIHU2NCBydW5uaW5nKQ0KPiA+ICsgdTY0
IGVuYWJsZWQsIHU2NCBydW5uaW5nLA0KPiA+ICsgYm9vbCBmcm9tX3NhbXBsZSkNCj4gPiDCoHsN
Cj4gPiDCoCB1NjQgcmVhZF9mb3JtYXQgPSBldmVudC0+YXR0ci5yZWFkX2Zvcm1hdDsNCj4gPiDC
oCB1NjQgdmFsdWVzWzVdOw0KPiA+IMKgIGludCBuID0gMDsNCj4gPiDCoA0KPiA+IC0gdmFsdWVz
W24rK10gPSBwZXJmX2V2ZW50X2NvdW50KGV2ZW50KTsNCj4gPiArIHZhbHVlc1tuKytdID0gcGVy
Zl9ldmVudF9jb3VudChldmVudCwgZnJvbV9zYW1wbGUpOw0KPiANCj4gLi4ub2JzZXJ2ZSB0aGUg
ZmFpbC4uLiBmcm9tX3NhbXBsZSAhPSBzZWxmLXZhbHVlLW9ubHkNCg0KQnkgZmFpbCB5b3UgYXJl
IHJlZmVycmluZyB0byB0aGUgZGlmZmVyZW5jZSBpbiBuYW1lcz8NCg0KPiANCj4gPiDCoCBpZiAo
cmVhZF9mb3JtYXQgJiBQRVJGX0ZPUk1BVF9UT1RBTF9USU1FX0VOQUJMRUQpIHsNCj4gPiDCoCB2
YWx1ZXNbbisrXSA9IGVuYWJsZWQgKw0KPiA+IMKgIGF0b21pYzY0X3JlYWQoJmV2ZW50LT5jaGls
ZF90b3RhbF90aW1lX2VuYWJsZWQpOw0KPiANCg0KDQpUaGFua3MNCkJlbg0KDQo=
