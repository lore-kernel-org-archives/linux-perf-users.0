Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3987202F70;
	Fri, 11 Apr 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744364683; cv=fail; b=ZNJ8K3h2xANAYo5mv9iuDMz3iiQ7MtkxNfIfDNki0AzU7/YBGs0cvzdFlgevZUfsYEtyuMXfeqspw5o0C+I2T4xCqiihn/kM8ZDwHACLV0TcoDja26edrOyE0jmpO+DDp5WT1QJwuwWZXmwRawr+KwnK7oiVftYURZ+KB64s4WY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744364683; c=relaxed/simple;
	bh=ghys4xnlcrr/wwjWk6Ig0EeTAKJmyy/sjfUzXCrIGxg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zd+FC4NxUiY5wySwMVPq+OtHSXTo6YYCS3bG1xbvXUufljgcRHLR0dFjdG9tsEENfbHDaJUbZv1pOcyj/otRRBXvk49jjz71pAxRvXfDkYTrjrJI+07u1IEHpz2T09DggR8KgQgCoihZM7Mx8nW0qpzX9iSH6J3z6pZmIyoctRw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ad77ZX++; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ad77ZX++; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ad77ZX++";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ad77ZX++"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yeKB8dSOb/hV/PkXdTlPiOOw6umaDGU1txPjn1KlPkwnC/SNXZHNbSx5EKGpBe5qMbJCpBOINmwHcOAOY/0YGTJEr/Stku7ZxU0uaysrae7ffDw8H9qWWKCLmdcqVQx8j1DXuWKPUD7rs4dHoMOhHje+vWry5zPU7jeaaZE4bHrMsdK6yiQlfCZEqNRA8zbKtJQ0Qkz+GepowsgObfU39Cm3SE4pR2xf1jUxN7CD+RLxL4tDQPnSV0PHPA2ngfR/d60l/awBtZYAC/M2j6zQepMv0V4qieS3v3X1vJkeCjV3STdyzzfmY9SIjy7jdTo8TtHh98hRt0QzKV35SIUVaA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN+gjfMrAwKQVNLdB4WSFk3dB7GyUQMzz7FLORuq3nc=;
 b=Q86i1VXTcwqXV/xxKIzduH6W12xkAHstMyCXMSFYHFmq4Ds9uYikmJqsEQS2VibUK2yc7F+eLNmN5i/19QjukJ+qfsn1HstOBmZirFZDs+OqdL0dsx82eav0qVnZdsF/3U5UXYEDckKnLHG24bWS2slwaIyBao2+AuZjN+8z0dbg896gDePHwXHcL07gWtwVe5XGDKZ+PJFSH5OJCxKnc9MGWVxl1/D27/G5GV0wiz4Ghfrj8hh33m7GQiQskIZo+bsDrvtEpdApNTVNXnJjSLPerpWggm3c3wMSD2ZGxUfPJdZcPrVydfsp6fATgt2W8KHa6/5FgcoqN3HV5WQOjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN+gjfMrAwKQVNLdB4WSFk3dB7GyUQMzz7FLORuq3nc=;
 b=ad77ZX++0ZGczf588n8gELMhvwRSSFXk3EmO0L68vheENNi0gk59f1dD/ElThuEyT0Y+DIWs6CXmc2HBKKVuXZsOiz3UGy/7iJ8j7vtXFL4Si1qu52fx0wKGBa0sq1ClrNcOKqSHVYUqU+MFdxhU8OCcb9RaPiIn7gZotDzc9pE=
Received: from DUZPR01CA0335.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::19) by PAXPR08MB7365.eurprd08.prod.outlook.com
 (2603:10a6:102:225::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 09:44:36 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::e3) by DUZPR01CA0335.outlook.office365.com
 (2603:10a6:10:4b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 09:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Fri, 11 Apr 2025 09:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isifIShXJUtnCbP31TywUT1QEXPLVGr1c79uVTBtiOlb1SpagKDXz13dzErfTBbO9jjzR9R2tBGJBXOl406orT0tUT5hKHD+eo/A+oYwxASlN2mJoZscw4jJXz6fxR9hT+Dj7ez31t26XpZMVyoBlflVeiC1rYQS2qtpB1e35hOtjd2AY5pMRaiso6MHGuy9n66eZC/Z00rMlbk3uSkzw1nf4p/3Oo4qLqr8NtJXIMaNH5IRbRi9qEgGtnkhbLQfSoJu4lJqKM2BMEQncTmCPqEKd0y6gEj9ZguI9XmCxfcbliImF44JyMkLuTU9Sz8wC0JhrYMrWZcv7kMM2/+5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN+gjfMrAwKQVNLdB4WSFk3dB7GyUQMzz7FLORuq3nc=;
 b=o4YuwzkDjXvlFQJWqZw/yOyTQTErsxatTTRv7NfFnvTYadzWBVNpY2u6zNxReu74We7CgQeHh9qSz9sPTTrCbzKYi+N5wSf35yoH+XeS4U1dDDpwAodImnEsKIXLk9Mt+/kPlejgIuwCbZYI++6cO+kq+KaQpKsFUU38dByjseA7i7odFwn3SN/eoEuFNd9e0sZPfh0V8qhyVhFT0BeDQWEm8pewNvP5jmvyS0VTIlvdy5FWr/BImxTkyA6IPZ6A3V/0MLucpLx2RyUGJn9IDskgOd/MZhc/9MSUEwHnFo4EgbzyuJj3wfpSlTCnYgjBKcCvspKtvpTD9lUu6Y6W9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN+gjfMrAwKQVNLdB4WSFk3dB7GyUQMzz7FLORuq3nc=;
 b=ad77ZX++0ZGczf588n8gELMhvwRSSFXk3EmO0L68vheENNi0gk59f1dD/ElThuEyT0Y+DIWs6CXmc2HBKKVuXZsOiz3UGy/7iJ8j7vtXFL4Si1qu52fx0wKGBa0sq1ClrNcOKqSHVYUqU+MFdxhU8OCcb9RaPiIn7gZotDzc9pE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7584.eurprd08.prod.outlook.com (2603:10a6:10:308::6)
 by AS8PR08MB8063.eurprd08.prod.outlook.com (2603:10a6:20b:54c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 09:44:03 +0000
Received: from DB9PR08MB7584.eurprd08.prod.outlook.com
 ([fe80::5144:343:7017:bacb]) by DB9PR08MB7584.eurprd08.prod.outlook.com
 ([fe80::5144:343:7017:bacb%7]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 09:44:03 +0000
Message-ID: <eb056314-70eb-48f0-ab00-6b13209adb02@arm.com>
Date: Fri, 11 Apr 2025 10:44:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] A mechanism for efficient support for per-function
 metrics
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
 ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250408171530.140858-1-mark.barnett@arm.com>
 <20250409142900.GD9833@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mark Barnett <mark.barnett@arm.com>
In-Reply-To: <20250409142900.GD9833@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::16) To DB9PR08MB7584.eurprd08.prod.outlook.com
 (2603:10a6:10:308::6)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7584:EE_|AS8PR08MB8063:EE_|DB1PEPF000509E3:EE_|PAXPR08MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 755f63f4-90bd-4730-87b6-08dd78dd78b7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WFNjakVvcDJETzlrblc0aElOZ0REc3hwQzBaZGIrYWQxZ2UydDlaYzAyV3ZT?=
 =?utf-8?B?VGlRUGNiU1hTTkNTQ0ZuVmpFUlBTeFNuZjcvZWFCdDNqRC9rM3NJZmlzcG9W?=
 =?utf-8?B?QmdoazBxUmFQcnc5QW9CUTJzVEcwSUN2S2x3Z0U2T0hxb0gxeXgzTjFLS2NI?=
 =?utf-8?B?N1NZTkdCQkJ5aDhGcHFDY2pKUk44WktMcUxTZXNmWDllcVZRSXNnYUduUE9X?=
 =?utf-8?B?bnEvMEx3bDY2OE5YcHA2N1hEZFNCeWF1ZTJBSkZPVGZPbGkvTEtKK2tETjVu?=
 =?utf-8?B?cmZKam0remg2SGNhOFFtcnR4UmRQVWo3Rkd4anZ1Vy9SVXVuZEtaQWpVa1Iw?=
 =?utf-8?B?c2t1dVhSYUhDWmlDK3hnWjMyWjFFa1FaTmJySEdLc0p3NkI5Wm95SERmT3VG?=
 =?utf-8?B?T21DOWdzZzA5SzVoc3ZCNmZObGRBeWtQcXNpT3l6d1Rvam1yUTJ1N3dHQ29O?=
 =?utf-8?B?UjVDbkN2YzRpZ2VzMFptUzdmdURSL3UrRFgxckQ5bDVodTh5aTF5NG82bXVI?=
 =?utf-8?B?RU1TaUhxQzFmTU8vZld5V0F2V3IxcklNRmRFaXhXTmY1dWlwV0duYXhGVXdq?=
 =?utf-8?B?OGNNeEtHVmovT1diS09wQm14MUtrczcrTWJVUE90VlUxYlNZMUtJZHJyWklt?=
 =?utf-8?B?ZGE3N3BKVVc2K2lnS2MxaS9oTUh0WTlxMzRjR1orUnBJQXNXWkFlU2FxNmFx?=
 =?utf-8?B?WjV2Z1pCcVVIUlErM3VoYWpWOVV4TnNIOENiZ0NyN3JTRnlHUmMzNWFiaFZh?=
 =?utf-8?B?aUdTYUkyNGNuVndHMTNBelY0emVIODNnQ0tIUml0Z3FTRFNKMGZRdFZ4WTZa?=
 =?utf-8?B?S1dVZWNRdVFEcno4UUJUaVJNWU5jM2RvY3N3VHlJOXFUcTQwZWxDRGNmTW5T?=
 =?utf-8?B?czNiU0NiNnM1VG1VaWdXUEdyRndVV0w1RTREQk9MdUUxUzB0SW1DVlJHK2ht?=
 =?utf-8?B?Z1M4eGE1RGtRVFJvUVZNZ3VudlJ2MGVtbGlhTlRGMmg0V3dzUGg2NEJvVUhJ?=
 =?utf-8?B?Z2MxaXFsNStmVk95TVVZT085NkI0amNwTlBpR2hSRUpEZU1kWTBVeTVvRjdQ?=
 =?utf-8?B?SW1MQ3N5TFRtamRvTTB6ei9EVmFYN3J1TzA5cHVNYTB3TXlFdDNaQTB3Umhq?=
 =?utf-8?B?a0FPNUpVMUQ2WS93clFSWVdwOEpzNTdFQlJ0enZjWm9ycUtkS0ZNZDAzR0h2?=
 =?utf-8?B?NHl6WG1YUnQvR0dyRmY0WS8zejZyZWx1R3o0QS9vRVNVbTUzZnFaNGZ3emli?=
 =?utf-8?B?R2RzNVlWdloyaE1UTkl1cjRmQ2JXeEZIeW1LT1U5cENJWkNJQUFTSW9UR25k?=
 =?utf-8?B?aHRSU0JucjJvZU5vWDZiYXVldGV0aUh4ZmNuRUtEZEt1bFhOVUR3VGt0aCtU?=
 =?utf-8?B?R01kR1MxVUZTK1N3dG9kVGE5UVJ1WnY1VytUU2ZRNEEyazRUVXRsRVBjME0w?=
 =?utf-8?B?SGJ4NWVTeXY1WFJvcVJtSG16NWltZVMvcnJoYjdjSWRGWm9lTHZYaDFtWlJ0?=
 =?utf-8?B?N2U2RGpJSHkzblF5WlBtRnFmN3VNT0JYQmMrRTNRM1ZiRVVNdlJRS2xiWFNP?=
 =?utf-8?B?bVdEL1VJOE5uY0Q5ZTVmZk0zaU1USkVIRnNpOG1Za2svSnFwUXFNQ2ZvTC9u?=
 =?utf-8?B?RElzbUZzNWlSejBHZ2lnRDR1SnY0cmhPeWRZTm5iZGlyMFNtQ1gxTm8xaGFq?=
 =?utf-8?B?K3U0a29RNTI3Nm1aYkxPWCt0RGpyQTR6cytQeWd5cWNkZ3FkR2RVOFFZbWhv?=
 =?utf-8?B?NnZ3QmlFYS9wR3NjYWVyazhRdlp2dlVTQkNRREcwUTZnVGFzQ1NYc2NRRWg0?=
 =?utf-8?B?WFNHTjN5TWIvUGh2YjhsbGV3eVN2ZXJQdkFVaFMzZEVZbnQ4UVNuMHlaay9C?=
 =?utf-8?B?Szg1M2NtU0RYL1lMZXNhSkw2SlE1KzFjNWFlLzZ0dWdSemc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7584.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8063
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9c917f62-38ba-42cc-8dca-08dd78dd64ea
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|35042699022|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk9rTis5YlNuSTRZeWE1N0R4NjZES1hWbU45REQ1OG04a21qUGd4K2RRMVVJ?=
 =?utf-8?B?VTZGaWNaUmdzcDI5MHRnV09XYzFRZUQ4S29XYlNlUHhSVUsvMnYzdlVZMGpI?=
 =?utf-8?B?NitkenoxN1ZjTGpJT1BQTTVJRHpNbEorMDhXeTlPZGF3RGw0Sjg3bm9BanRr?=
 =?utf-8?B?bXVJdHFnVDdyZmZ5ZjJsY2NFZFQ1bEd6b3UwYmhScGVGVDB3WllqK2cwbWxm?=
 =?utf-8?B?UEJVK1drSTZ5aDc1TWJ0Vzk5eUtnUVFBeU5jQ2tPTnVGZ2pTTDNtY3pXSEZx?=
 =?utf-8?B?UG1CRnEyR2Y4N0tLQnBHMmNTcTI3b01JRDVFemo4em1waDIzcmhleUVtWHZY?=
 =?utf-8?B?dGNrSENJdG9zdHFubUxlSkh1QzFuRWZYR1lIRjJVYXQvRTVDenl2TEVPanU5?=
 =?utf-8?B?SjNKOEl5UVBkNnVic2c0c0tpb0tsM3poSGViSE5HNm05Q1NIZ1Q1M1dxVnlJ?=
 =?utf-8?B?cWlXVTJIc2l3dFQ2eU5jL2hGaUtHeThNdWdqVEltYlZHV2sxeHZUM1JYbEVW?=
 =?utf-8?B?Uk5veElKWjJQUko0cmhkdjl0dytuQ3hWenpwZGMwT3cvWG40K1lGTFBraXZl?=
 =?utf-8?B?eTRsT0RhcTVGSjVxWGlpUDZPdmJuQVdDbjR5ZXZQQWNmU1lCdTY0enBFQ1dF?=
 =?utf-8?B?ZHlBV3lSOHNma2wwVjVsM0hvY01ZRElTZTVpUXRLLzNWU09vZTF2UDh5SUpL?=
 =?utf-8?B?c01HUTRXVDRGVVNPczhhVk9vb3k2UmxPSTcxOTBBeS8xZ1FhdlBDSGdELzdp?=
 =?utf-8?B?VnREeFdTa0twcmFqdXQyNldDWGNBcEJ5M0g1djBOWU1zaVZwTGgyTTAybW5h?=
 =?utf-8?B?S0dGU1p1ZCswT1FXdFdhSHNRSXc0U1hqMGpBaktieCtmaFFwc0RqbnJxeWhG?=
 =?utf-8?B?TU9yNXBwMmx0SzRQZ2h3c0NoNlk2TWlIR1grNUw1KzEvNm9DZU5GY2IrYStU?=
 =?utf-8?B?cWVDSEhybzU0N0ZlZWJZZEpiRFV2d2lFWEVrTVhEa21MUWpjK2NsTjA3MHpQ?=
 =?utf-8?B?ZVQ2R0hENFdReWxjZmI2UFVjU3V3ZnhNVmxaNHlkZWY0T3N6bW9rZjlOUk03?=
 =?utf-8?B?Z0hNbmVTbXFtaTl2VEZHdENFekkzWTJmN1VwdkhPclRCWXNraTNTS0x1Qit2?=
 =?utf-8?B?RlZUUUQ5WUJyYzloYmY2M0FyQXJ5QmMxRDVaUFFnTFJES3ZpK210cDhIYlJj?=
 =?utf-8?B?bDFNWjJDRXZrWTdLcG5QWE1uS2JVTmd0azVXM2pvVTNjcW1qK2xsV0JRc3dT?=
 =?utf-8?B?UE5LY3d0MWNpTExRRURNNzNvYTd5ZjFpRTR1eEdlWW1aYXB6NjVaV2dzMHdr?=
 =?utf-8?B?aFhFSFhYVU5rRVl0dkgyK29xd2xrLzlSajVxRWk1cEJ4R1NJN1BkUGNxc0Ry?=
 =?utf-8?B?YzllOWxKK0pkOTJzZ0ZZeTRVdFVjWjNzVC9Jb1ZNOXlGbmd3Ukh5bUxuLzda?=
 =?utf-8?B?SUFrbGRjMHkwdXdMbzMzZkM5L0pnTEFwbnd5TmtzMlVLVTNtKzBmd3k2aHZn?=
 =?utf-8?B?N0lrMHplNTJpdW1CKzZKYnkydnA2dkxlNXNUS05SL09TM2VYNFhvUC9XTnJ3?=
 =?utf-8?B?U29JVzJDNjZDK3FtWFFQdzJOMk5DcTFjam82eVMxd1FEZzNRUTJ4eDFYRDJI?=
 =?utf-8?B?WFArM1NDRk50SWpyMzZOaEN2ODRkeXFxTVVBNG1mdGsvckVLRjFUWlRyOEV3?=
 =?utf-8?B?VFF2KzBpL2c1NkFwK2Jlb2JyWlg1TjNFd1RrY3ZLUW93SE9qNk44R01OUEll?=
 =?utf-8?B?NzB3ME9MMVR2RU51V1dNMXJFRFpnYmJsU2RVNGpMVHlkOG1BazViSHdqeDdE?=
 =?utf-8?B?TzZKSVZLdnQwTExWanNXSm14Ykpwd1NuSWpxRllWc0sxOXhsbHNodDhrWHdw?=
 =?utf-8?B?MGkvSWN6UWhJTlFBUTZQNjBXd1BKQ0E1NTZoVGkxbTBZVXlQemd6b0pEL1V6?=
 =?utf-8?B?bCtSRkM0RWdobmJMMTZrVjcxaHdNalJIZGhaVFlMSVVVYmQvajRkY0lvR1hv?=
 =?utf-8?B?SkZVOEZ3SFoydElhZ1ZLd281ckNZMDVNWkxpU3BJNkVhZUh4b1hnOGFkRGNX?=
 =?utf-8?Q?hNDOr7?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(35042699022)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 09:44:36.3940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755f63f4-90bd-4730-87b6-08dd78dd78b7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7365

On 4/9/25 15:29, Peter Zijlstra wrote:
> On Tue, Apr 08, 2025 at 06:15:25PM +0100, mark.barnett@arm.com wrote:
> 
>>      perf record -T --sample-cpu --call-graph fp,4 --user-callchains \
>>          -k CLOCK_MONOTONIC_RAW \
>>          -e '{cycles/period=999700,alt-period=300/,instructions,branch-misses,cache-references,cache-misses}:uS' \
>>          benchmark 0 1
> 
>>      perf record -i -vvv -e '{cycles/period=999700,alt-period=300/,instructions}:uS' benchmark 0 1
> 
> Should be updated to read something like:
> 
> 	cycles/period=1000000,hf-period=300/
> 
> right?
> 
> Also, cycles/freq=1000,hf-period=300/ should now also work, right?
> 
> Anyway, the kernel bits look good to me now (with the nits fixed), so:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Yes, freq works. I'll update the cover letter and address the nits in 
the next submission.

Thanks!
