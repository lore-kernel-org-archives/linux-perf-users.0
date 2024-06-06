Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175FD10E9
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691345; cv=fail; b=V+MFKvKENLqxLmiaj/5wLB1b0dflUdUlZDVzPvjoUSdFzPGYs61QCDeq4OOtXRjj4lbteYdp/ckctW0kjhKkeD+1piF0ktVwUwZyszfdcQCUcmx08vSAf1JWDij4ifNoyglZ1uh3zC1oEWZvOMsMYF0lB58HAvxKkqz1qPqt9QI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691345; c=relaxed/simple;
	bh=Kt26rVptadPdlAUXwlGKEjfG/cFF6itXSRqqsZ5ZxnA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X8cPZKPOOO8/kj7J3AYMers55NYx+KsIDL0O0ltEDH9i2csx+dm8RBuTNJ4jpCBhHUsmGj9lEDYwAzmYFRNYR8XdxqGJIQ7m2/UePubRswG1kOAtK4T7qnKdoNMTr4rucvYdkgBTucisVig5mC9zivw2/zSD5xtzAZJo9EKwkaM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IW0bHVvO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IW0bHVvO; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IW0bHVvO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IW0bHVvO"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=C2Q3qFkoUut3ibskRVHbLZOEkWhhzYQK/1iiRU17krGF3co/LkF8R9BEXX+S68UvTs4pLh0pnaHy3ONjtt+2MdfzKiraaN6GA3xGj8ZsOXw94WyELHPpcQcUy1SQrLD+hqknbIg48e4tf2lafAfkWu65HivJ2HJYXgjkb1zd3WDF+d+5l+t46vXlnHd5+LMRGkZWOmyE0L23QkM1RReUvzog+Bcqd9ySwbNE4SwiOxUkLQHY6y0aFfZ72e5m74xFiyyZT2ItMhMS0gYLE4c6GoV+VLChZyHlP/UkJdCbpignvPvTVfU44kJqA7ip0v6kgpn+Kh20uKB69/emW5b6nw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5KtuWlAaRcGaiukFoe5Iao/GeqRcE/i0kJiRzezY7I=;
 b=PEFfn923vnzh0vJfvRSBPcgNYZ76BvtzR+PApHHYc34LlEdo5hHmvI8tmdev1TzHHfqXLqNUxzsDe4m/9hlfSzRKr771qIzIOCMlt6sbosBvHLDM89bfJszfbmUhk7xfaErIAKpzSQHKPS3wAj9CjPsUpW8lOZDGHy4PfLMEfSlwwrgE6s4XCv2RFn8nMxVIvSQTYudB8yyQMPDfHLX9CRr3Ja41Bc1ztelVZ/LfnFAMRjvjHBzAnE4SwT+8UEbothtQkY0UCtiq24QeZq3kUEUOvzRphvp4njt7i4YL0BKkT+isWkJ+ajZJJqAkunUSaWgTtwzCL3x1S1uaXu4HSQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5KtuWlAaRcGaiukFoe5Iao/GeqRcE/i0kJiRzezY7I=;
 b=IW0bHVvO24Cf2Jf8uWbtF9RFE3ScZiqACYI8WOem0uhZ06+9sjnmpFW3Vawmcnr7/9Zc5Bm13gueSIxOtNIu+BSPNn1RL8KMgX13XORcNQt/sa7tGyVvONj5sPLpi8UXIzWeX9lyqfXVYxxuP0vRh71bKwcIDGvSbCH8GlXO6MY=
Received: from DB9PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::13) by AM8PR08MB5858.eurprd08.prod.outlook.com
 (2603:10a6:20b:1dc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 16:28:59 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::73) by DB9PR01CA0008.outlook.office365.com
 (2603:10a6:10:1d8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 16:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Thu, 6 Jun 2024 16:28:58 +0000
Received: ("Tessian outbound 35b4523e1022:v330"); Thu, 06 Jun 2024 16:28:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: af2a5f1878e7f629
X-CR-MTA-TID: 64aa7808
Received: from 9db93a9f3f71.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 551E6A19-9914-4C91-838F-E7C93F3CC64C.1;
	Thu, 06 Jun 2024 16:28:52 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9db93a9f3f71.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 06 Jun 2024 16:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT0Fhb2gpdupXt2ZAz827F+MeuKQ46je2+FxuPbii05IEIYGVcpxTexFS6UjCUbK7YZiJQcCBCbyd4eqHVmnmyE2z1kJf7gZCGiefk5um5b2r/TAZoWl2CIjXqGTcihjSHlXmIsiffBNHylsD/x75Br6q/jtVAkHwBcB5yvtXuLNhkRuhec1pqBo4ydTj1Qv/IwNgI3gQk1BKqHXZ7czhwl9VlrnFAMT3zOtGttLeHbDGHNyi/EAfzsL69PGakTCZplhrmeqyQDVGxzUBpwfmcXlNgAC/bjEfLAYmXAr0oqahAKn4YzXAFEfgtIZuREhADRQ8uaGXEQvyAIUxGxWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5KtuWlAaRcGaiukFoe5Iao/GeqRcE/i0kJiRzezY7I=;
 b=QckLTl/njQCCOWtjjjt1grHHJi0Rik1JMzPKqmOLa4pU6ZNMi8NmeDI4FvtZ7+Ra12SmEzD2Bmt8MEQC1LueVtnQ7g5hq3lg14XfKmlzoj3Qw6DLg72DxZ4wDYabtS2RcuhtfyAhACPCE7S4czajrIMhR39bWAt02joB5HHSwrGWF0Cy40FA4coFXzJcKgv244P4g9nZ+0ug9OHx8C54Fc3BHNHdBY39xnVfoErGvTr3LWZqxRU5h70icICO+i7PNQ8G3cJgxPiJud2LfV6thHXlI+SLVj7m6Dcuz+73KgSrBrWylLVxo1scaymI9Tvxr4IpbN8CntM/xq7ag5tQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5KtuWlAaRcGaiukFoe5Iao/GeqRcE/i0kJiRzezY7I=;
 b=IW0bHVvO24Cf2Jf8uWbtF9RFE3ScZiqACYI8WOem0uhZ06+9sjnmpFW3Vawmcnr7/9Zc5Bm13gueSIxOtNIu+BSPNn1RL8KMgX13XORcNQt/sa7tGyVvONj5sPLpi8UXIzWeX9lyqfXVYxxuP0vRh71bKwcIDGvSbCH8GlXO6MY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com (2603:10a6:102:150::13)
 by AS8PR08MB8327.eurprd08.prod.outlook.com (2603:10a6:20b:56e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 16:28:50 +0000
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad]) by PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 16:28:49 +0000
Message-ID: <b914e8b4-c3b3-4809-8708-69b53c25a294@arm.com>
Date: Thu, 6 Jun 2024 17:28:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf build: Use pkg-config for feature check for
 libtrace{event,fs}
To: amadio@gentoo.org, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
References: <20240606153625.2255470-1-amadio@gentoo.org>
 <20240606153625.2255470-2-amadio@gentoo.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240606153625.2255470-2-amadio@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO0P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::7) To PAXPR08MB6591.eurprd08.prod.outlook.com
 (2603:10a6:102:150::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR08MB6591:EE_|AS8PR08MB8327:EE_|DU2PEPF00028D01:EE_|AM8PR08MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fdfd9e4-29d3-445c-d922-08dc8645c48f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?S3ZCR0VXUzRDM01FN0U4empSS3VJWjFVMk9wTTI2U000YmdmWHFkZEYvYitz?=
 =?utf-8?B?bjlUZVV3bm54NWhxcGJ3M0pvemw2bEJlL0R3NHpvdnJGREl3RWQ2cVZERXBL?=
 =?utf-8?B?S2M0WGZqZUNNWENWeDU0d1ZyK0l3b1BJWVlyNGVZcjFPQWVPTEZLTmkwTFg2?=
 =?utf-8?B?V0E0c2pJMW1RaE5ueTZ3VjRmMm5rSkhGZnFENloybk41cGIrYkIzdExSV0t2?=
 =?utf-8?B?UXAxMVZRWEdnMmV0WU03cVdXV0RJS0dEMFJ1eXY0QUJiR0VYOHJtcFNkN0lN?=
 =?utf-8?B?b0F6dkp3TmY3NXo1UzIreFhaSEtmaFkxbnVOdXEzUnNRSllXSmdIVk1QTWtP?=
 =?utf-8?B?NlhtOGVucExXemhSakU5VjUvTEI5TW05eWJlNUFQdk9OZmkxc3hxdmV4STZ0?=
 =?utf-8?B?K3czMWdjOVJhZjZtZThaS0JiNFhTUTdOY0ZyeFF0SGV1YnFvSEdqcmdYSnV3?=
 =?utf-8?B?N0E3VkFvNEx1ZFVIdFE4OWJSRnZ0UlJPM0xhWmltNXc4YXVhTFpsQWpFRlV4?=
 =?utf-8?B?Y0twZS9semZMMlUwTTNockZpR2lRSkJmTHRKUXVOVURLWW5oZGNBbkJMMTd1?=
 =?utf-8?B?eTA4ejB0MlJPalFmNVhNaCtqODZ5aE5JMEphNXlwakROT1k2Mm5RUnRqMkIz?=
 =?utf-8?B?Y3FIaUdZMHZIcUNaUjhFQjNlS0ovK01CR1c0ZklpbVZ3aVRpNE1MMVpSU0tK?=
 =?utf-8?B?MDZkZDYvcW5TL1BQSENYOVJBZ1lid3duWFAzNVhWT3FBUGVGOW53MExhWmtT?=
 =?utf-8?B?dnVyVU11UmxIaDJqTDZaQWFHOUwwRTBOSVI4TFEyY1NEVWoxdXM2a25SRjcx?=
 =?utf-8?B?UkNtNm1vRzQxSU1HcGdOSEVGTVpnTW02ZnprZi8vcXlOUk1OYmJrQUpQMTQ1?=
 =?utf-8?B?NmtsaWoydXR0cTlVTC9ub0hGNVRmWS84WHFMSUloT0lvbG9VTmZxSFppQWND?=
 =?utf-8?B?T0x5cW4rZ055dkpNVCtmbkZoVTl0bEYydHRyNlJEbCtUb2JNWTMwQmhvTzQ0?=
 =?utf-8?B?cTNSTUhnZWR2TUQ1Y05YU3Ztek5CcFBPWnNKSDVvU0RreTFwV0RPV3BkUlZT?=
 =?utf-8?B?VnBRRnRNWHBRYzJiWS9CY3EwSnh5OXFUYVByTm1yNmdSZFBvYVk1QkVyWUJP?=
 =?utf-8?B?V3B0aGVrcG5hdTFQY0Y1MWJ5dmZiUlYrMktOTVVDUEhFei9BRFhOWEN4ZHpo?=
 =?utf-8?B?aU5pVG1YUGdRUXdqelZpWm9JRGRDWFFsUXE4aDE1Mmd3Y3JPam52TlowRmha?=
 =?utf-8?B?MzZBVjFZeC92RVhEazIvOWdiQlBPS3lNZmI3Y1RvNE5oV1hiVFpZZHdXNEVr?=
 =?utf-8?B?a1ZRSGlzNkhwUW9qSkdybUlXdGt5WmNZRWhBdHhaTVVacW5YSVp5b1dra1A1?=
 =?utf-8?B?dzF5anJFZi9hc3RqSnI4Y2xkK2ZMTVRodG1vcUhnQWNPbHFseVhJNkllQXJa?=
 =?utf-8?B?MW5MMXJLYno5OWFqSEYwSlA5QURvTFAwMlNjTFRjUGNBSlBBU0F6RkwvMWQv?=
 =?utf-8?B?MUNaNTZKbHg1TzFvYU0vait3U0VQb1cxY3lRR1FnZkdvanhvYXFyS241UHZN?=
 =?utf-8?B?UHVFZ2J4Y2lGYlBxMFN5ekFzWkNoSDc2QTlKL3JrR05UTlBjT0QwZ2VEdkhh?=
 =?utf-8?B?aUdQK0daaEZXdEhTTzMrVzRQcDFhOTlxbnBFSTdlK2w5YkJMb25FRzlUaXZU?=
 =?utf-8?Q?Tt03e57LDipEMyGx4psc?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6591.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8327
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d0444147-18e7-4cba-ce04-08dc8645becb
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|35042699013|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU54QWRGVCs5U0F1SFRqQ0ZhUlhCNWVwVlZLbXVpVGpjcjgwcGsxUVFxU0dz?=
 =?utf-8?B?SzliU21BNk02SlZTY0xOME9HMUp4VTBXQ3lmbmhiSXMvOHFKSThBU00rU1c1?=
 =?utf-8?B?WS9XMHBwVFY5cDhxdnp5dytZOTB6TUQ0SGhvbGFHZUlsMjg1UEllbXlvTFRR?=
 =?utf-8?B?cFdyYlNlZUkwYUhYY08zOHZvWlVNNHgyc0FSZGxHOWJJRE9mY092Y2x6OVhu?=
 =?utf-8?B?Ym9uMFVpcEsvLzNpRUZ0dFNtbm43VXU3UjJvMjVWY3BGMFdFaTZOR0hlMnlZ?=
 =?utf-8?B?aDhVUy91QnpRNk1JMW9vUDRMWFVWZFlJSlhaMHcwRGdrb2dWN3dOaWUvdTB2?=
 =?utf-8?B?YmJhZWNJZExwdkJ4TDE4c24zZDRhOVZ2R3VEdjZyZC9iSm9aSVZENXh1UkJH?=
 =?utf-8?B?aERTaWN0cTd6SjZoaTY3ZW9KcklXM0pjY0FrTXlBYklsYndoM3BvRUR4bWtR?=
 =?utf-8?B?clFTYTF1cFNlM3FCMldwZ3kxclFGcWg4ckdGeWc3YnRZa3dhWlE3eVpoQVp0?=
 =?utf-8?B?ODRWYnJuR21pRDVFL2JEbTFscld1a3VPWG01V0JHa0ZJelN5akE0NTZhdXRu?=
 =?utf-8?B?QnpFN1pKN3puYmhMT3NSQ1VWN1R6cDB5T1Roakd6TGhZUHRhbkg3Uk1rQkhv?=
 =?utf-8?B?dU1rcGlFTVZvYmVHN29UQ0JUY2V1aWliZmtqa0FNUkxXZUIzT2phdk5qaHVx?=
 =?utf-8?B?YjV1bE0vNDZWVFBleE84RVRuR2J2eVNhSUtLRTcvTnVoQmpuK09WUnJVT0lT?=
 =?utf-8?B?OTB2VHp2N0syMVE3VndMRXZaUjJXK3lydWl0SDNsdEV6cnR6cGl4a2Z2Vjg1?=
 =?utf-8?B?VStVQkVPOHhzYUh3aWh4VlRQVDE2RHFZcC82eTRHY2xHMTZqVCtpMWoxUzA4?=
 =?utf-8?B?eFh2UnRRQStYQmd3ZHZsdHI3WjRhdDN2VFNRVitJTUVGZXp6dm5uVkZnVWx6?=
 =?utf-8?B?MkJVWndCTTdFQURKY1VkdzhCT25aejhKTTdQYk5hdFM4a1RPUkgyYTloZzNs?=
 =?utf-8?B?WDdWb2pQK0dhUytCb2RldFdYRFlqaCs5dkJWTERFNjNPN0p5Ump4VnpsalBV?=
 =?utf-8?B?OUUrWmQxWUJHQ29VMHJvcStJT2lwd2wyUUlwdU5RazhBcUNBbTd3ODBNRHpz?=
 =?utf-8?B?eUZMZGFEN3RQTUNCWVMwS1JnREZ6Y3JZWWVGaTBESDhhbUFpeWs2S3BxMGVR?=
 =?utf-8?B?S3ZsYjc4SFhpb3R4V3AwaTRaUlY5T2NRQk9aSFpYbmc2OEtBdXh6L3dQeS83?=
 =?utf-8?B?NmpHR2RndWRxUHo3eHoraEl6RUNLSWJlQ29qYjFCR0JFVE5uYVBUUzNsR0NU?=
 =?utf-8?B?UTlqZlBMM0Vrdm9rY3BsNkJvcEtPMHFpdzVBWUVkb0dTUzBkQS9MVVh6R05m?=
 =?utf-8?B?NWRIYmV4bUVIT1hWNVFnU2RYNHVWSHZsMHJ4WG1HbENoVEFuanJ4WFo2M3o1?=
 =?utf-8?B?dm81UUlPVFlMQ3dJTCtUeVJLWGNxZnVGQk8zaDVJOUVIR1lSb3g2OVgxMTk3?=
 =?utf-8?B?SnkzbnhOcEQ4bVowb1kvZElMSDkzdjZtV2hUYm9YR0QzMjZNSlFkRmVOYjFy?=
 =?utf-8?B?b1JLcHBkOHkrQW9aZDFGaEEybEFEdEhHVHd4cXkyd0dWSEJwellSdTRUT0t0?=
 =?utf-8?B?ZVQrcmtPVk5GZkRLUWpCemdkdFBxRHlnaWRjMEl6WUZoU0xWVHU2K2pTSndK?=
 =?utf-8?B?dmNkSDR5N04vWnhxeFY1UGdFNUgrMHNXWWZmUFFFU0FGVkFOd01XS0tlZDdK?=
 =?utf-8?B?QitNWFVGd3ZnMHlydklHNkQydGpteXVKZ0J3NDNTTThDT2dTUFlsK3ZRSlk1?=
 =?utf-8?Q?Rskwuj9WwoY8/MBLNgBNanmsqr5lOrI06/Dv0=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(35042699013)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:28:58.8394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdfd9e4-29d3-445c-d922-08dc8645c48f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5858



On 6/6/24 16:33, amadio@gentoo.org wrote:
> From: Guilherme Amadio <amadio@gentoo.org>
>
> Needed to add required include directories for the feature detection
> to succeed. The header tracefs.h is installed either into the include
> directory /usr/include/tracefs/tracefs.h when using the Makefile, or
> into /usr/include/libtracefs/tracefs.h when using meson to build
> libtracefs. The header tracefs.h uses #include <event-parse.h> from
> libtraceevent, so pkg-config needs to pick the correct include directory
> for libtracefs and add the one for libtraceevent to succeed.
>
> Note that in baa2ca59ec1e31ccbe3f24ff0368152b36f68720 the variable
> LIBTRACEEVENT_DIR was introduced, and now the method to compile against
> non-standard locations requires PKG_CONFIG_PATH to be set instead, which
> works for both libtraceevent and libtracefs.

Should we advise users to use PKG_CONFIG_LIBDIR or PKG_CONFIG_PATH?

When I wrote the patch set [1], at the beginning I also used the env
PKG_CONFIG_PATH, but later I think PKG_CONFIG_LIBDIR is better for users
for only lib path setting.

[1]
https://lore.kernel.org/linux-perf-users/20240604093223.1934236-3-leo.yan@a=
rm.com/T/#mec2e44d6091dc1cf5f827b6542592b2938f1b697

> Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> Cc: Ian Rogers <irogers@google.com>
> ---
>   tools/build/feature/test-libtracefs.c |  2 +-
>   tools/perf/Makefile.config            | 27 +++++++++++++--------------
>   2 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/tools/build/feature/test-libtracefs.c b/tools/build/feature/=
test-libtracefs.c
> index 8eff16c0c10b..29a757a7d848 100644
> --- a/tools/build/feature/test-libtracefs.c
> +++ b/tools/build/feature/test-libtracefs.c
> @@ -1,5 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
> -#include <tracefs/tracefs.h>
> +#include <tracefs.h>
>
>   int main(void)
>   {
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..54a6c6bf23c7 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -183,14 +183,12 @@ FEATURE_CHECK_CFLAGS-libzstd :=3D $(LIBZSTD_CFLAGS)
>   FEATURE_CHECK_LDFLAGS-libzstd :=3D $(LIBZSTD_LDFLAGS)
>
>   # for linking with debug library, run like:
> -# make DEBUG=3D1 LIBTRACEEVENT_DIR=3D/opt/libtraceevent/
> -TRACEEVENTLIBS :=3D -ltraceevent
> -ifdef LIBTRACEEVENT_DIR
> -  LIBTRACEEVENT_CFLAGS  :=3D -I$(LIBTRACEEVENT_DIR)/include
> -  LIBTRACEEVENT_LDFLAGS :=3D -L$(LIBTRACEEVENT_DIR)/lib
> -endif
> -FEATURE_CHECK_CFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_CFLAGS)
> -FEATURE_CHECK_LDFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_LDFLAGS) $(TRAC=
EEVENTLIBS)
> +# make DEBUG=3D1 PKG_CONFIG_PATH=3D/opt/libtraceevent/(lib|lib64)/pkgcon=
fig
> +FEATURE_CHECK_CFLAGS-libtraceevent :=3D $(shell $(PKG_CONFIG) --cflags l=
ibtraceevent)
> +FEATURE_CHECK_LDFLAGS-libtraceevent :=3D $(shell $(PKG_CONFIG) --libs li=
btraceevent)
> +
> +FEATURE_CHECK_CFLAGS-libtracefs :=3D $(shell $(PKG_CONFIG) --cflags libt=
racefs)
> +FEATURE_CHECK_LDFLAGS-libtracefs :=3D $(shell $(PKG_CONFIG) --libs libtr=
acefs)
>
>   FEATURE_CHECK_CFLAGS-bpf =3D -I. -I$(srctree)/tools/include -I$(srctree=
)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
>   # include ARCH specific config
> @@ -1178,10 +1176,10 @@ endif
>   ifneq ($(NO_LIBTRACEEVENT),1)
>     $(call feature_check,libtraceevent)
>     ifeq ($(feature-libtraceevent), 1)
> -    CFLAGS +=3D -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
> -    LDFLAGS +=3D $(LIBTRACEEVENT_LDFLAGS)
> -    EXTLIBS +=3D ${TRACEEVENTLIBS}
> -    LIBTRACEEVENT_VERSION :=3D $(shell PKG_CONFIG_PATH=3D$(LIBTRACEEVENT=
_DIR) $(PKG_CONFIG) --modversion libtraceevent)
> +    CFLAGS +=3D -DHAVE_LIBTRACEEVENT
> +    LDFLAGS +=3D $(shell $(PKG_CONFIG) --libs-only-L libtraceevent)
> +    EXTLIBS +=3D $(shell $(PKG_CONFIG) --libs-only-l libtraceevent)
> +    LIBTRACEEVENT_VERSION :=3D $(shell $(PKG_CONFIG) --modversion libtra=
ceevent)
>       LIBTRACEEVENT_VERSION_1 :=3D $(word 1, $(subst ., ,$(LIBTRACEEVENT_=
VERSION)))
>       LIBTRACEEVENT_VERSION_2 :=3D $(word 2, $(subst ., ,$(LIBTRACEEVENT_=
VERSION)))
>       LIBTRACEEVENT_VERSION_3 :=3D $(word 3, $(subst ., ,$(LIBTRACEEVENT_=
VERSION)))
> @@ -1194,7 +1192,9 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>
>     $(call feature_check,libtracefs)
>     ifeq ($(feature-libtracefs), 1)
> -    EXTLIBS +=3D -ltracefs
> +    CFLAGS +=3D  $(shell $(PKG_CONFIG) --cflags libtracefs)
> +    LDFLAGS +=3D $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
> +    EXTLIBS +=3D $(shell $(PKG_CONFIG) --libs-only-l libtracefs)
>       LIBTRACEFS_VERSION :=3D $(shell $(PKG_CONFIG) --modversion libtrace=
fs)
>       LIBTRACEFS_VERSION_1 :=3D $(word 1, $(subst ., ,$(LIBTRACEFS_VERSIO=
N)))
>       LIBTRACEFS_VERSION_2 :=3D $(word 2, $(subst ., ,$(LIBTRACEFS_VERSIO=
N)))
> @@ -1315,7 +1315,6 @@ ifeq ($(VF),1)
>     $(call print_var,LIBUNWIND_DIR)
>     $(call print_var,LIBDW_DIR)
>     $(call print_var,JDIR)
> -  $(call print_var,LIBTRACEEVENT_DIR)

Except above comment, the change looks good to me:

Reviewed-by: Leo Yan <leo.yan@arm.com>

>
>     ifeq ($(dwarf-post-unwind),1)
>       $(call feature_print_text,"DWARF post unwind library", $(dwarf-post=
-unwind-text)) $(info $(MSG))
> --
> 2.45.1
>
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
