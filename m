Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2051.outbound.protection.outlook.com [40.107.103.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCCE19DF9E;
	Fri, 11 Oct 2024 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.51
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665131; cv=fail; b=Ic0QmTmOszcRoJKVCH/7ac2sNifRTiCv9McJ6g2rJ179Oiu6YPrM2A7ebh7pR2KQsNjH86DmDHVjqLcr5GUUl5dMZTESEJgcUJhO0CTwI/4OX2EFOGJgWv0Nww8+xYDtPgiMfJc2bsHgpO9Ch4/CT7GeJYbTZSsfYHJwcTz9bxg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665131; c=relaxed/simple;
	bh=ujyVW5/7raj5lllAxETdyBBcSA1btJr7uNx2Fu4mYyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cmdde1i5/fZwnzLY1O755ZWwAPYXz8T4aFlwaVJpjRRCFpb6cA1D57Y9pYlJ1PxYCDaxjl0oYeyd04uZjMmx0rGC4srkE5ygf702XmjCO/3vDDLKI9jTXmi29ONQHZ9NkXH/2spIAu4z8RVNVBkYubQ3Xgrzwc+wfevUo6xHUWo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZpK/YINW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZpK/YINW; arc=fail smtp.client-ip=40.107.103.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZpK/YINW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZpK/YINW"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gDSiH+BsFHFeLL898RxFNZXVJp/hJGdxJFMFm7fFmyMHfcAIymGruzV+pSOlvvlj9UkAaLEgTr+JMKaU2KKKpIByaBaqO1wY6IdBgDZvHgXjzpg2OtyseDBecucm7TyXEKDPSnsHzs69IKxX9ljWU4kyGZfVwB83s2ZFDBoEuDbaw2ihPVMQJxSwtX3kQqO4rtyVb1qvQX1NXYjQXa6sfUJ/fly5hNPyFJkr8AHPS+W8y6otZK7G7eiYpDDWT2UafDk/BxEYkWWZHSQ3OA2zP+ZwL2uC3KNw/IXQOjJ2EINVDxsMHTPSFNl4IfkCQ5RL7QXbupYMnK1wAltnkqmFWw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujyVW5/7raj5lllAxETdyBBcSA1btJr7uNx2Fu4mYyE=;
 b=Pksv3/zhMW9n52Lud1nhWA7b4nV+2HMo9f6A5gQ95MNoC3ooOVwoBB/ubVDupbgkMVBmTRdbQ06AcY6o925hIcN7Qt66f6vC1el+h7Zm8FE69u5n+qW4qpw36K59aED4IoDGHHkP+a3KM/npE7mWlmx9SzRXXoDVRi8NvwXPqMxNNPy7xcSHPvIuJOY9aSJZ+TZwNo7rwL7W9McnoCRzcY0O+GiJBw4iBQdCPbOU/Yd+dDYzBtAiFfIjtr2utBZkf73nNY9zLMgcB4LL6Fq1ERwPVX603LuNUB1XBtsoBWtseFdqHxfnbR0EB+aMOuPUaKnEXR/dFGG4s30PRc1rCg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujyVW5/7raj5lllAxETdyBBcSA1btJr7uNx2Fu4mYyE=;
 b=ZpK/YINW9BBA4LObBOo66wZMomotC/FY/OZ5joHD6kI62ofVnJ4NvDFNoDB07GM9uL+Zk96Dc4blxLu5oeLMqnZs3JIOsitYT0dr6rX3abFquph1NVnc3dkRtFmrLrzCu0RrXYfunMj9+QEecAOJsiZAp3sz6soV3HkYJZF5p34=
Received: from AS9PR06CA0710.eurprd06.prod.outlook.com (2603:10a6:20b:49f::26)
 by PAWPR08MB10119.eurprd08.prod.outlook.com (2603:10a6:102:364::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 16:45:21 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:20b:49f:cafe::ad) by AS9PR06CA0710.outlook.office365.com
 (2603:10a6:20b:49f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Fri, 11 Oct 2024 16:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Fri, 11 Oct 2024 16:45:19 +0000
Received: ("Tessian outbound 0658930cd478:v473"); Fri, 11 Oct 2024 16:45:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5ab5d3d59c66ff4b
X-TessianGatewayMetadata: i09zK234O5iI7MeHgpKa3Mezxdb97OgldoXSv+ZjAtXEABI2wiyHv0PIxAxzcKWRW85/pmImlWkyrY1+RpTbthYVAqk+hSUYNjhGuHV4xF1wn7QHFrsHWeBRMG7qvmPEHKE5ob86Ug1qf+HUGIrO7y4ZhsQA6jAz56/d3XVScZ8HXIgIeDec5hJiFdpJ8fRT
X-CR-MTA-TID: 64aa7808
Received: from Lb4960a5060e8.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 14F181CF-CA6B-4627-85F2-F21F5EBCB295.1;
	Fri, 11 Oct 2024 16:45:13 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb4960a5060e8.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Oct 2024 16:45:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXLz3q/WxBPzFjX3RAIKakecRLcsfOghlRN68/b+23WZVaFNy8kCknv6R5NdWSgFb5CtOrYp0zdX09yZdXTRC3BewBIseTzLeiGKu5Q6K+DxLXMKqTEZha+jCa6qcbF0sehE4r3nP26QrK6ZTkmdNPYFPZSh9y1AlWaaDXwqyXXNoal8ZA7LQeugM0RimU1Phs39GPU4U6vud1BiHKI3hrQJEfSmBTWVum2DtijfPZUi6/swsEi0kcHYw2Lc0WqbB7jb9HFJHstvwY2KJSE1XfibI/l7faBF+BkkqswfjpOFHVWBHUz5bQD1cjuiGQbl7nKbEDtoGItuG7ubMefS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujyVW5/7raj5lllAxETdyBBcSA1btJr7uNx2Fu4mYyE=;
 b=KEBsKVz97Wg7QK+vlfdxyy4qL6AArZpgG7ZK/SmF6k5zmdLqp5wafalvzdjMelmq0LNcFN5/lWIn8tjykX6co2c1yVLgIZRSttNL1XILdxfpcOYJAtiiFozQy05/tQS8SXsrnd3o4xXutCnr4vNJKTOy2PULP3Gss7hLQWk5pVxMehqZfjquNU5vYYH0eg8e6APZ4OakrN+kW0ru4Tcutpkw6x3O2sVC71S5jJzlRxsnRvMeCPnkCccHlEP9rlwoux9i2Mp2sN6dCyOEyrFO05uj+VAcfA0Dx6ptcmDVjbvfwm8su/sv9cAMByBKivgzYSg7ibpyUXx/QhPBpn2cgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujyVW5/7raj5lllAxETdyBBcSA1btJr7uNx2Fu4mYyE=;
 b=ZpK/YINW9BBA4LObBOo66wZMomotC/FY/OZ5joHD6kI62ofVnJ4NvDFNoDB07GM9uL+Zk96Dc4blxLu5oeLMqnZs3JIOsitYT0dr6rX3abFquph1NVnc3dkRtFmrLrzCu0RrXYfunMj9+QEecAOJsiZAp3sz6soV3HkYJZF5p34=
Received: from DU0PR08MB9486.eurprd08.prod.outlook.com (2603:10a6:10:42d::21)
 by DB9PR08MB9465.eurprd08.prod.outlook.com (2603:10a6:10:457::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 16:45:11 +0000
Received: from DU0PR08MB9486.eurprd08.prod.outlook.com
 ([fe80::814b:b5cd:2cf1:554c]) by DU0PR08MB9486.eurprd08.prod.outlook.com
 ([fe80::814b:b5cd:2cf1:554c%6]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 16:45:11 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>
CC: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "irogers@google.com"
	<irogers@google.com>
Subject: Re: [PATCH] perf evsel: Fix missing inherit + sample read check
Thread-Topic: [PATCH] perf evsel: Fix missing inherit + sample read check
Thread-Index: AQHbGhOtKNh/V83HGkq038YD2Rf4BrKBM4+AgACQrwCAAAF6gA==
Date: Fri, 11 Oct 2024 16:45:11 +0000
Message-ID: <233c349762cf31f3733b1bce1f5a8f5869df6d7a.camel@arm.com>
References: <20241009062250.730192-1-namhyung@kernel.org>
	 <7ced2109944c4aa773804a2d25854974b76d8fb6.camel@arm.com>
	 <ZwlU2lpeekYntrGd@google.com>
In-Reply-To: <ZwlU2lpeekYntrGd@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DU0PR08MB9486:EE_|DB9PR08MB9465:EE_|AMS0EPF000001B1:EE_|PAWPR08MB10119:EE_
X-MS-Office365-Filtering-Correlation-Id: f860b6ca-afc4-4d28-9057-08dcea1417d7
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MjljL0NNeldMTTgxTWxDeHRra3R3dlJMYTYwRlBmL1JsSGcxR3hFcEJDZk9r?=
 =?utf-8?B?VDhkYnJ6cHlPOTM3TmUwTW1Ybll5SWZQY1Q0am81ekRYY1ViNkN5aFRTbzgy?=
 =?utf-8?B?Tm1oUFpJZUYzZlJPNVcyb3JzQ2MvRHdyZVlzbHBmMmZ2TTJ5bUxSTS96SDlq?=
 =?utf-8?B?TjZtRm8zWE1heDBkdEdJWHFkQUJ5d1A1czJMUGpOQUg3S0hoTnRubFlQbmZX?=
 =?utf-8?B?T1pCdzZ1THJvOXZNeER6R01nbXljK1Fra3F2OTFHbENRQTdFdFFIMHZieHJu?=
 =?utf-8?B?U1JwbGdjMmxsYXNQcERZNnBnUHhTZzVXQjB1VUZWWjVMNng1bXlKbHg4WE95?=
 =?utf-8?B?MStPV3pqNGhiTHFJbmZKYzNwRi9ZS0diWEkrejhuNVdDRysrenZUZ1grUGQy?=
 =?utf-8?B?cUZIb3FCOVlkdUtsYTArN3h0VS9PMmx4ek13c1FYVGcwbDM2ejJoc1Q2K0JW?=
 =?utf-8?B?cUdqVTZ5bUwxVTV2bVBpQ05oSjNMdGNkMWhVaGxRU0xnaGp3V0hQbUROdFls?=
 =?utf-8?B?L2tVVXZpaUJGQmlzTTBMd2o4QS9raFZwQ2VJR0k0d0UvY0NxL0doVjZ1alF6?=
 =?utf-8?B?OVNyQ0FpbjFBTXlMUFRVanBJL3hJREZKTkVxMGJoZWNra0trWkNFdFBMMWVO?=
 =?utf-8?B?NjVpSjY2UnJRRUtSWmEzNlVpZGQrZE10QzVmUWZqWitQam5oaTE0RGwrMXAz?=
 =?utf-8?B?TnBlRWVtVGZyeDQ1bWh1T0dkWWlVcWk3OUtTYnlqWFdXdXJBZmg2eW9OVjRw?=
 =?utf-8?B?REdoK050aVZRMmdKTWNQS0EvekxrNDJ5YXFJOUpTaTJXa3FrOXlKOWdDTTd3?=
 =?utf-8?B?M2laUjRhZ25CazVkNU8yTXJBMDRwTnpXN2tBTlJFZ2YwcUlvVnorbFlrbVVx?=
 =?utf-8?B?bzMyNnZwaSs5TmYrajZweUtDWGRPWEhjSlZjOGNJdndIbEdqeWprQW92RUVJ?=
 =?utf-8?B?SFRLdFZWVGI2Nm1xYUt4SW9kRlZ4ellpU3VRb0E5N2gzNFlENWJUeUh6UUhr?=
 =?utf-8?B?RFdLRmFwNC92WHR3ajd3RFMwYVM1THJTYTNmOUVwRWNZTUtMOEljd1MwSXEz?=
 =?utf-8?B?VzN4eVRHRDliOU83TmdDZkJnOEZtR3B1Q2JYNWVJSk92TW1Rd2xYL1ZGdjY5?=
 =?utf-8?B?bzIvQXdmSHJWeHJhNEdZK2dYYm9tWkd2N3p6UWxrcTNCN0hwZHhwdE1VS2ll?=
 =?utf-8?B?OExCODJtaHpDSERqSTdVbEJoM3VYWHA5bTRPNlVEdE5LTEZ2WC9RRDBpajcy?=
 =?utf-8?B?WTAvdWVYZDk4TGhGWDAyYkNETWdYMDl0dzRPWEdoOUpxalRKMUtBYUZKaWpR?=
 =?utf-8?B?c3JhRlIrc0RSYmhYUXFzOVg3MkJ0N2luS3pCUmdWckxkc1ErbWNIQkFyNmg4?=
 =?utf-8?B?cXVtQVh2VmhtRTJYdk55Y0IxbzBKNm9KQm9uRTlnZ20rcjlCQjdVdHJyK0NH?=
 =?utf-8?B?U0RDOHlBaDZqZ250azlvTjNycDVIR2E1djNscEpIRDMyREFNL0JOdEtpYWFQ?=
 =?utf-8?B?TjY4cW9xc2g5cEZzUGxRdXN4N2Z5VFlwSDJ0eHZIY1JjdmRHY2E1NlJJYnRZ?=
 =?utf-8?B?S1BuS1VHeVFIMmlzUjB1aGs4dS9abmxaOXJQV2FHcEVYK3dKSkkvVDdUQ0ZE?=
 =?utf-8?B?Mk8zb2Z1NWp4cnJrN2VGQWt6RjdhWGthZUo1SkZ3MXdZcjVRbGJjdEZhNmlV?=
 =?utf-8?B?Z1RRU2NEdzdmMGFaNklhWGhTdnhHQ1RnVGxnaUlBb3R0dDNETkJQcnhwVDRL?=
 =?utf-8?B?Ui9JbUR5RGNTTjdxOGNJL2RzMkRsY2F3QXM2TzU3UlR4MlFxMFpsVFRqdytS?=
 =?utf-8?B?NStsNHpNVndzdlhYQXNsQT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9486.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEF2EC3A9EB2CD4889A852ADDFEE0971@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9465
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:42d::21];domain=DU0PR08MB9486.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9049e980-bda2-41b6-3158-08dcea1412e4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFZTQjN0eldDMVNEZWYyS2JraWlVb1lxd0ZhRHZ1QVY3TmFSWnZ1M01ueHZy?=
 =?utf-8?B?SjZEMTlPdmN2TlliMG9IUDh3aFc3SmVpRkNhekJOa3NmejRhRzQ4UFU0MmdW?=
 =?utf-8?B?WWhSMDlEK3FIdDZOLzhMWm9QUE1EcnB0ZDR2bFRmdWJCMlh6eWx1ZUlZUURt?=
 =?utf-8?B?OVAvaTV0S2o0aVNHekZuZ25kYkFZdnIvMDhsQS9FTEpqcTZDdHNER2RtOVBW?=
 =?utf-8?B?dm4yN2NqcU04dktSeVdrVkpCMHFRSTRzZG94Y0IvUko4ZGlNWGJ1aXc2NEcz?=
 =?utf-8?B?RUU0OWIvOVRDbVIyelRtRy9RbGU3NFpKdjhVd1Y0blZQT2NNaVptMktTd0hE?=
 =?utf-8?B?UWlJOTlGK0xKWjhNQjA5QXhXL2U2SWFBdGFJQzJMMDN3ZlZkTW81ZmR0MEp6?=
 =?utf-8?B?TnVQNmh4YnhyMi94SlNyazdmL3ZpWTFCMWNlUlVrSEFGYkIzS3FqeXd5ckt0?=
 =?utf-8?B?bzJHVTRtdS9OaDF1ckVZQ1Q4ZWZTdkM3a0JNOFZVaTlPL3lyWGdnd2N0bndl?=
 =?utf-8?B?UHJNTVRmRmc4SGFEdzM4MFFQZXFPMmxvYUJZamFKNFZ6cUNrOS9pNitPRU5M?=
 =?utf-8?B?Y1o4ckxoTURwekYrK1FBdWN4WkF5bFJrZXhLenUrSHlSSnF6NzRKWXQ5SDRo?=
 =?utf-8?B?V0ZpQjQxSm84YWRYTEhnY0s4TTVZTmFzVEdFODV2Vi9hVUJiSnI3OTllMTYz?=
 =?utf-8?B?ZjJkWThjL21JTlVLVUpOaEMwcmJHdFRETS8xcDlEa0dLM0NaN1BFd0NRZ0tq?=
 =?utf-8?B?NlpUUXFFeWw5K3RtWVZOOEN2NVBGYjBrcTlTTFk1TG05bE9MMTRFZlhIWi9p?=
 =?utf-8?B?RVN0RHB4eDdKYncxNXh6L3NFcUZicmxONlJZNExBZE5DUnl3RTl2M3JhS253?=
 =?utf-8?B?NkdiNnd4K0o1Qk81eWRzK2NibWpCbWx4V21EVUl1NTAybS9KbzJNUzlGd2t3?=
 =?utf-8?B?Z3p4b28vOStqc1lQZ3ozaUQ1MzQwMXN5dTA2U2N3blc4S3RteU1SZEp1VmQ3?=
 =?utf-8?B?WXYrQWtwTW03TGNGdEF3V1JueVp2T1RFQ2tOTjBnZ243MTg3blVVbGpLVERP?=
 =?utf-8?B?OUdDM0YrRE5PVVZ4UUd0VmpVSkt4OVIxcEh3ajJGRUxxeEtIU2duMVNvYVFT?=
 =?utf-8?B?NmptT0NzZmNVU3g4TzlCbThTSlp2bU80ak1Kd0VZRTgrQmt1aUhHMVMxenRs?=
 =?utf-8?B?Vi80OVdvc1lkYnZSTXVwaS8rUUsvaTZSSXFaNjh2bWdpZUVDSEdNZTRtei9W?=
 =?utf-8?B?dm5ZQ28yWFdoNU5Md080Nnd0OEgrUTBjb056WkZuajVFZzRoTGdUekxtNTgz?=
 =?utf-8?B?WFFBd0orSjZDY0dWVWRlV2hYUWhoV3Rpb0ppbGM4dEF2cDh0VXIwSU9yNDky?=
 =?utf-8?B?U2NVd2g2ZGhpVUh0YVJiaFBJd2dSbndXS1BlREgyNXFjOEg2WUcvTFE2UnNu?=
 =?utf-8?B?ODJtT3JHNGpZL1paUzZwK2hnbWRkOExpZ2FpTGNEZUNaTG9wRnFyU0V1d0My?=
 =?utf-8?B?VmcwR1FoWkZvSWdIeGdDWXZIc3I0ZHduUjUzdmJNZ0RMSHdPMkZtbFM2S1M5?=
 =?utf-8?B?eXdRcUFrZm15L3ZEcVdSQmxSTllEWTQ2ZEl4QTRUTnhWL0RiZ1NISitSdk5N?=
 =?utf-8?B?cjJjQjN1NytrbCtUaTVlanNFZ3pkZ2NRckxva1lGM2FLaFp1ZG5VbHhLdEpz?=
 =?utf-8?B?WTcyZkZVL3hWSEZSc2RxS0JNdWpOZTllbTlGWTYxNlRlSGJRRWJ4NWNkNDhH?=
 =?utf-8?B?UDZJZzNXenplVms2YVNaeHlSMkFLSTVaRVVsbm1aRktwL1RKWEJ4TEFPK3Vy?=
 =?utf-8?B?OENRdlNHaExiTit2b1hPaUFFckV1L0NBOEJFYWhvNzM0Qlp4cDlrRzB6NWlI?=
 =?utf-8?Q?syQjVjy03+2Lg?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 16:45:19.9391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f860b6ca-afc4-4d28-9057-08dcea1417d7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10119

T24gRnJpLCAyMDI0LTEwLTExIGF0IDA5OjM5IC0wNzAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IE9uIEZyaSwgT2N0IDExLCAyMDI0IGF0IDA4OjAyOjA0QU0gKzAwMDAsIEJlbiBHYWluZXkgd3Jv
dGU6DQo+ID4gT24gVHVlLCAyMDI0LTEwLTA4IGF0IDIzOjIyIC0wNzAwLCBOYW1oeXVuZyBLaW0g
d3JvdGU6DQo+ID4gPiBJdCBzaG91bGQgbm90IGNsZWFyIHRoZSBpbmhlcml0IGJpdCBzaW1wbHkg
YmVjYXVzZSB0aGUga2VybmVsDQo+ID4gPiBkb2Vzbid0DQo+ID4gPiBzdXBwb3J0IHRoZSBzYW1w
bGUgcmVhZCB3aXRoIGl0LsKgIElPVyB0aGUgaW5oZXJpdCBiaXQgc2hvdWxkIGJlDQo+ID4gPiBr
ZXB0DQo+ID4gPiB3aGVuIHRoZSBzYW1wbGUgcmVhZCBpcyBub3QgcmVxdWVzdGVkIGZvciB0aGUg
ZXZlbnQuDQo+ID4gDQo+ID4gDQo+ID4gQWgsIHNvcnJ5LiBHb29kIHNwb3QuDQo+IA0KPiBUaGFu
a3MgZm9yIHRoZSByZXZpZXcsIGNhbiBJIHRyYW5zbGF0ZSBpdCB5b3VyIEFja2VkLWJ5Pw0KPiAN
Cg0KWWVzLCBvZiBjb3Vyc2UNCg0KQWNrZWQtYnk6IEJlbiBHYWluZXkgPGJlbi5nYWluZXlAYXJt
LmNvbT4NCg0KOi0pDQoNCg0KPiBUaGFua3MsDQo+IE5hbWh5dW5nDQo+IMKgDQo+ID4gPiANCj4g
PiA+IEZpeGVzOiA5MDAzNWQzY2Q4NzZjYjcxICgidG9vbHMvcGVyZjogQWxsb3cgaW5oZXJpdCAr
DQo+ID4gPiBQRVJGX1NBTVBMRV9SRUFEIHdoZW4gb3BlbmluZyBldmVudHMiKQ0KPiA+ID4gQ2M6
IEJlbiBHYWluZXkgPGJlbi5nYWluZXlAYXJtLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE5h
bWh5dW5nIEtpbSA8bmFtaHl1bmdAa2VybmVsLm9yZz4NCj4gPiA+IC0tLQ0KPiA+ID4gwqB0b29s
cy9wZXJmL3V0aWwvZXZzZWwuYyB8IDMgKystDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL3Rv
b2xzL3BlcmYvdXRpbC9ldnNlbC5jIGIvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMNCj4gPiA+IGlu
ZGV4IGQ4ZmQ0OTNhZjAxNDU4YjcuLjUwN2Y1MjZjY2JiY2ZjMzYgMTAwNjQ0DQo+ID4gPiAtLS0g
YS90b29scy9wZXJmL3V0aWwvZXZzZWwuYw0KPiA+ID4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2V2
c2VsLmMNCj4gPiA+IEBAIC0yMTEyLDcgKzIxMTIsOCBAQCBzdGF0aWMgaW50IF9fZXZzZWxfX3By
ZXBhcmVfb3BlbihzdHJ1Y3QNCj4gPiA+IGV2c2VsDQo+ID4gPiAqZXZzZWwsIHN0cnVjdCBwZXJm
X2NwdV9tYXAgKmNwdXMsDQo+ID4gPiDCoA0KPiA+ID4gwqBzdGF0aWMgdm9pZCBldnNlbF9fZGlz
YWJsZV9taXNzaW5nX2ZlYXR1cmVzKHN0cnVjdCBldnNlbCAqZXZzZWwpDQo+ID4gPiDCoHsNCj4g
PiA+IC0gaWYgKHBlcmZfbWlzc2luZ19mZWF0dXJlcy5pbmhlcml0X3NhbXBsZV9yZWFkKQ0KPiA+
ID4gKyBpZiAocGVyZl9taXNzaW5nX2ZlYXR1cmVzLmluaGVyaXRfc2FtcGxlX3JlYWQgJiYgZXZz
ZWwtDQo+ID4gPiA+IGNvcmUuYXR0ci5pbmhlcml0ICYmDQo+ID4gPiArIMKgwqDCoCAoZXZzZWwt
PmNvcmUuYXR0ci5zYW1wbGVfdHlwZSAmIFBFUkZfU0FNUExFX1JFQUQpKQ0KPiA+ID4gwqAgZXZz
ZWwtPmNvcmUuYXR0ci5pbmhlcml0ID0gMDsNCj4gPiA+IMKgIGlmIChwZXJmX21pc3NpbmdfZmVh
dHVyZXMuYnJhbmNoX2NvdW50ZXJzKQ0KPiA+ID4gwqAgZXZzZWwtPmNvcmUuYXR0ci5icmFuY2hf
c2FtcGxlX3R5cGUgJj0NCj4gPiA+IH5QRVJGX1NBTVBMRV9CUkFOQ0hfQ09VTlRFUlM7DQo+ID4g
DQoNCg==
