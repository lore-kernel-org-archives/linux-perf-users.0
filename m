Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800B218AB7;
	Fri, 20 Dec 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.87
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709447; cv=fail; b=d/0HuKL7wtQtV2X/7L1yvbhMk1RgMLULwpQl+koMYLQ9BcwD9MWJd36FNxixm0Zz4rZkQkZFxokkltYhl/0qPaYdxQl8eQSsZ008y+c5EMPYw5Z91XUBrnVIxMx9G8am2MiC44emKtFlBmj10ivkZuqZ+JBzi0CnudZnasMfLvY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709447; c=relaxed/simple;
	bh=Qi9LTUSqZi+v1lvetqv7/xAZCgpAzbyUp15A6jdMff8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQZK2n6UDD2AYbFfLAaHGhBhtfmaW9/0uhCJHej9N7Ig6FB7efGKeJw1rvDpmL50tIVdyu+drnmsTW1jkGrjxpmOMLl1yKuX9pfsgOKoQad8t5qndIEWjUIVrEZEOGgVlfcnvXMdqDAL40QkbAVKws/8n6AgWlcCEERodhk8ddE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kaFxP2v7; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kaFxP2v7; arc=fail smtp.client-ip=40.107.247.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kaFxP2v7";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kaFxP2v7"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Mu6s++s4dEcimzlSvrFetdgOw4AiyQVkIZXwdM9rTo5kQw89o5qYYRtdDSSB3B+R2J1DeF2IXBK1Z0Sf/S/cHlnav9HRxFD7MIjp5GqVyIwbWvBq41aI19l0tHLKWSHVKjrkTjfM0muYEzbu7M7yBPmOaIWIHrPsM5PpH50NxEdHejzHHSNiyq3Bh96JK+wisEUwLQR6B3LN7Cq5FCuo9cShlai17JwAZoOkJQrw6tbAp8PFmOt6Ih7tivubi1nZ/xkGsI32ydDXy9v0Dvl/94a3ewBeghkITd1YrSZZwgXsZMqHHlx1KI3lvnLrhCa2nPh7LIDuqQRyNhVare/f1A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W+TlOiLBPVHW+fSQgg9hXBuzSjebSpg9NiJ/VCgTLg=;
 b=PbKAylONRdEpvPJdwbWNIN0AOyTViKr3pUZ+/bE+fOBzOSAhGmzvFi7ETA6ZyNHHGnyTYrF9GV6tQDGkX+uawOrpmRxBHVEzvBRyDHb42bWzkwul3377A/vyFf8A2yixNuzitPBrQmkf0CzljvG1JcoR7z3nUF3tmPe12ccpynsdxVVBcYt+LTiPgLeGHN2SX0+DtnGdpr3sMgIGm/Q4CiDry3UwXHJgHzwsXMeTt25+EhpubR4WFPBaJgupM5shwPKS4HLdXh26tf23sectJn7USr7+2nn6+6xtVu3NCFwCIRICneqv6u1mJVFQwSs309rpQo/jw1m0I3vaBPFLSg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W+TlOiLBPVHW+fSQgg9hXBuzSjebSpg9NiJ/VCgTLg=;
 b=kaFxP2v7CmFDh5pO5bnlS85bhr91aSABY58K/FLaArqX6pldO1SYdKiQ7nGnl8sh4L+zskNmJTRuxrB/qniVQDztNWa44jGYvxrD48JeYN13ZPY1mjdSXIuqnYTGujJMUaFwElE662RXHz/cbLj362y4/srOzl33dM4HiRDsJuE=
Received: from DUZPR01CA0138.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::14) by DB9PR08MB7675.eurprd08.prod.outlook.com
 (2603:10a6:10:37e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 15:44:00 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::9b) by DUZPR01CA0138.outlook.office365.com
 (2603:10a6:10:4bc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 15:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 15:43:59 +0000
Received: ("Tessian outbound b519d6c64997:v528"); Fri, 20 Dec 2024 15:43:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8d4d4055117d1a9e
X-TessianGatewayMetadata: 6Gze74M400P6wR54X7Kh/TlN0Nqf0clmBKsfbVhOK7irE5d4bj1CFnigEr4cEc8s5P0yIOeXEf34/hbGvfOzkLJr7lMcV/l0+w6x+wWkDYihI2B+OaEnw9x5pZII6cdeCKBZqh8GI0pno2GDUFPH2A==
X-CR-MTA-TID: 64aa7808
Received: from Le6c47ca15ae1.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id F02C0205-1DE8-4F01-BC75-D0473FA490B1.1;
	Fri, 20 Dec 2024 15:43:51 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le6c47ca15ae1.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 20 Dec 2024 15:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNJn964DzHkXW+mlP+Wx7pLrw7+6RDA8GUGA9i6Jvn/BxZdAAt9U5V8bjCBMPt5lvn6QsMFdMEsNlT88k0nAWKxMJYCh/HG5GFI7E415XDZp63oAQqQ4ApEllzDJe/NGgd1yglhGo4R034WlHl00OolsjeNWNtt8/B/mRd2ym+sNin/SrB+YyvKD9tmPASm93RxIpu5G9t2JqvJaicndBAbC9ZbuZ1bSq5jf0JUI8fxYTmIEvoqI+pA28l3rh9XVD67Xt66jbZrFI8/BkCqZMRemigcpk7nmKwtVFRhkezeMiZP9qw3O6dMFhRn5FvwOH3fNh+/2mokzvPqdfD31Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W+TlOiLBPVHW+fSQgg9hXBuzSjebSpg9NiJ/VCgTLg=;
 b=u7YNC2XxzmVxgzg0jzi/za+vPzZPEesVuju+1478d3Oz1Gt+RRTxfYc/w6NFHSDcawIFbPEp9rJEhj5iBicuG8jPRxDgwTFTAfoSyHffvpwRDkj3P2wL7+EZUwhE+d+ke8jxzH1J9oQ/QWnJNEaIMyldwe0hFNexQf6Qy1rdQDITa4y5cPTNKQ9sKsmh3mt2ltFIsS8odbxSp7ZLEUEYqq3a+TyrmEhH5jJ2HTeXtGY7V6ypT/d8NO1gG337IJwDoh/V354mt6cFn+JSNzJufdm0DsiKzsNM6TJrKK7jCMAkIA4oes4mQOFQpDgNk9OXyZhAfuV+PdI9HFT/k7KIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W+TlOiLBPVHW+fSQgg9hXBuzSjebSpg9NiJ/VCgTLg=;
 b=kaFxP2v7CmFDh5pO5bnlS85bhr91aSABY58K/FLaArqX6pldO1SYdKiQ7nGnl8sh4L+zskNmJTRuxrB/qniVQDztNWa44jGYvxrD48JeYN13ZPY1mjdSXIuqnYTGujJMUaFwElE662RXHz/cbLj362y4/srOzl33dM4HiRDsJuE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB8034.eurprd08.prod.outlook.com
 (2603:10a6:150:99::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 15:43:42 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 15:43:42 +0000
Date: Fri, 20 Dec 2024 15:43:40 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <Z2WQrO+kjJ+w2Sur@e129823.arm.com>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
 <Z2V5s2JM4W7BRckR@e129823.arm.com>
 <20241220151414.GO11133@noisy.programming.kicks-ass.net>
 <20241220152810.GK12500@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220152810.GK12500@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: LO4P123CA0503.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::22) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB8034:EE_|DB1PEPF00050A01:EE_|DB9PR08MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 8683afc0-3ec4-4fa8-accb-08dd210d1f16
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?spc9Dd/JFSs+v2iN2HNMcjrKwm+XmJdTDQcOkxMIWbGz9Yl5WQmf66fxfDVD?=
 =?us-ascii?Q?HTzfRMjBhg+PTJQ2hTyjx2QIti59YE36qwJvcWVn1IwMexRKeWNykMn01AIB?=
 =?us-ascii?Q?mLnAAX2O7SdusDh8N1JgI4G/eDhDWDB7u7QFQeuULop2g5pFjJso+OwflMOK?=
 =?us-ascii?Q?CLZ7OxRSVjnCe+d7rkrWci9vsX/cBdAT9C9Ubai8jkUXoZEF9tzjaeh71M7I?=
 =?us-ascii?Q?6aBihTXoFHGrZDNw9oRH54fMcC9trakjmtNOGXijttYbJvJfzKPjG4I+C+K5?=
 =?us-ascii?Q?TkpRjE5kNvFrNV2tXIdLY8I8NKb581xuec8MckOzffCROILB1+M/NW3boA1k?=
 =?us-ascii?Q?w153qdmqDrp/7+nJ/Vwl7kkf4ZQBG0JZjbSTIVODnwN2KYnRbnld2aP8TkhP?=
 =?us-ascii?Q?8EDgHCpzZh/HUtus02PNntAHzQhQ/9rqFC/MZy9CY+Dr0TKi+ofOD8jov+LJ?=
 =?us-ascii?Q?8Nkoksa0piOR2hq8arAZZyk2iu0Q5PBqMB4onmf5tRA1jP0sjICr0o0QOUcS?=
 =?us-ascii?Q?Y/Uve6eM9QiRHqh15WZ1dpYO0GaRbgQKz8c2Oepo6pPTUUGkfYJ2hkH6dzf1?=
 =?us-ascii?Q?VbwLO9Tbm8RIsV5uPFK8r2DTRFnCY+mOGv5eX/O6M6nMDrRIGFzLN1fIyHIx?=
 =?us-ascii?Q?QwVZUZpGEVFxvo5uSMfDpkk37PQUgk2RVHrRVq+k3rLpbFYGcZLD9YgK3h/w?=
 =?us-ascii?Q?609RhhX2rzxZK7ovqtHoM3uKfIZrToB650odlZygfyMk97QDijEarAu74IZP?=
 =?us-ascii?Q?Q6bzb2RqcIK97QM8aQWr8/NXeZKY6PIOufgpjyghfqX4PsY2WYLroTBhBFFM?=
 =?us-ascii?Q?35Z4deDgvtvFcREANi9DX7CNs9ckhCdZp9oN7itBpNXL4/eLPiflso3w0Va/?=
 =?us-ascii?Q?9XAVhG9fkVYHYFqU2xgTxWVC4gHulcZMdcB/qif5zbrbe+3tILfMFCczbXy6?=
 =?us-ascii?Q?ligXn+3QUK+gAw7syF/no4V06v2wlh51+v8dZDcBT2FLs1pMP0wawyEcRL+c?=
 =?us-ascii?Q?A/PX41w4pzDkoZK5PLRn7HpeSICBuC3iY1IKC8BmISGa8pu1VIA3jv+gKGGt?=
 =?us-ascii?Q?x032FvmBXMGWzDPfsoLpYZdS+H5rJ5+XFD1w/pv7C8bU5DgFN1feXvTd6b7Z?=
 =?us-ascii?Q?zlhgjf0eRFY5qkKN1dL5u/Sq9t9lJtHJHQ4xeMUFQ+jz+/8FOFGNsZWXpld/?=
 =?us-ascii?Q?3HOGi/F5Mhfr1Vgw/vA222A6TsJVG0XD1KfHhTjr2Z/ciASd9y/sxhUdXUkO?=
 =?us-ascii?Q?83MbRPfWgQxqUImFeBthIqoy3Lx1Ho9Hj6EZllNACe/LhmEZdHulLuUhzOtq?=
 =?us-ascii?Q?q9qfcUto3uhUjKWMlODr3GH+ip47tK2GReDGeKCOeprKeWrWtFdZ8d1N5E3j?=
 =?us-ascii?Q?Vx9bvpKWgVIRNwQbdA0vpZ+WA3iI?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8034
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d5bf911b-b91c-468e-9288-08dd210d14ed
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|82310400026|14060799003|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dybw9qq3xKnK4aafDy4KHHtpEAQkJE9MiGVqcSGRJx3YvlCgS8rmRaZngZzk?=
 =?us-ascii?Q?QzyahPZN4vquV+umrAXHuBWemiLIIuARCvLwncBorgFdtz0CZI9cttmTYPSe?=
 =?us-ascii?Q?73JrdyT+U5DMAav1Vk5lW766QVeOk+YQgRUAWRBaCwHz4GL2heQRjXyHjChK?=
 =?us-ascii?Q?M21TVk4X0Jiyr/ReRk+hc0V9nRIJJepxwz9FwYnnCArQvhvRmLfy/RL7rR0/?=
 =?us-ascii?Q?AwWtBaa/WUEdAQzfUQMTeEwy6+EYj+DQ0JiBDwNJKHMPskTXpOgvchXJeLU/?=
 =?us-ascii?Q?Swzr3ToIFfzs+YwY8Bn2mCp2qz5dLug86s4OBLGLQ1e9fDqVYg1nt3L+Zmts?=
 =?us-ascii?Q?/KXPFk1uJdeaK+pMjGtt+9q8dJuujL0GGuJ4Jvq1V/PeENYOLCOj+MJWM++Q?=
 =?us-ascii?Q?jbE24NMdqDHPdFgDRkvwQIM+4L7DpBMRE+q8lkyBrPLYFG15H/i31I4Zn8og?=
 =?us-ascii?Q?y/EPpZyJskhpxHzPGypbjes9CCxp1hJ687gAPvdI4LaaOZmmrwtBzZxRPKGQ?=
 =?us-ascii?Q?buYgi9a/3p3PTpsdTZMgCMScTMrGYQ8b0EaWVrGfgCf1BVdhUkPm3rj/JX9n?=
 =?us-ascii?Q?POaKoRd9zaevRViF/XEKPu4yhODBdsseDOf6s+W3V9SkWg/wNgB7DjkTzT3y?=
 =?us-ascii?Q?d5mbM8AVqaHyzH9kl3p0CpDw8/0aedqbKOnxB7azLj/3HFk4p4Y1XE+qEn6F?=
 =?us-ascii?Q?RGo0EMtc8Pyfe5nqkjRWKcfaxAceZJxgosgafgGB87UqkKfwOhvW9QKwnzmA?=
 =?us-ascii?Q?d00+Leo/ixpg5aN5s73q3L3esb+4a+E/IzIRhwrKLzLSNOTjxPaBj7TjE4Tv?=
 =?us-ascii?Q?hGz0/WOSfu8Hf1z+UOerdvWiWOYyq82jarQRjcB4FF5OpQQuSRPPVIRFWa9d?=
 =?us-ascii?Q?N8gwtZSTsQL+HNf43azGRE0N2FhGSOEkqLCQskXrRE469kNch2dWoSpxMUTx?=
 =?us-ascii?Q?kArDNrrGkKUBN4qcZ6WvsPXZ/nHewHsinS8IFwFF5ib2RSndjiXLxAJAop16?=
 =?us-ascii?Q?E1TExmLeyfj2iNHtCvcCLb6x+PiZiHyMt00YIUw9GwrDIrn6pn5FdpnJVsnC?=
 =?us-ascii?Q?GtAdzgA4H1WksCjuHSUd9e076O0caLjKugcR85aTviEvh9KukJCtd71Nf9Fg?=
 =?us-ascii?Q?rmwhzk1OZQboyGNDP7wwm9REAL5P6XTAO1bRdubsBO2ats8SEc+sGlVWh/Om?=
 =?us-ascii?Q?1EKFYxDaG/hHA/FfCiPVQelsZh59JCNss/JpoXVjYzj96RxPpCpxM41jzqWE?=
 =?us-ascii?Q?XOzkJHXyG5h2QH0epuGqVtU4rNbgFu+07oByt9mgJgOh3ZClezOBeCFqRMe7?=
 =?us-ascii?Q?Z8p6hmi4oi9aAN4haerZYx9D6NXFLs9sZvgXxZAzEfHT81Jei+fnRl5ANs6L?=
 =?us-ascii?Q?0+74N9hJcv68+N8599BaeLOqMR+piExrndH/Om/pk3lXupkpcYvhtnpmZA/h?=
 =?us-ascii?Q?q5/9QbVG/YANIHU6HWoxqDmGSGM4kn9E/kBvZEEE6sKrMrW+2JpDg2vZfd4M?=
 =?us-ascii?Q?mJrIGeMF/ACQjFs=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(82310400026)(14060799003)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:43:59.6349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8683afc0-3ec4-4fa8-accb-08dd210d1f16
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7675

On Fri, Dec 20, 2024 at 04:28:10PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 20, 2024 at 04:14:14PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 20, 2024 at 02:05:39PM +0000, Yeoreum Yun wrote:
>
> > > the answer is in the perf_event_exit_event()'s
> > > perf_remove_from_context(). in here
> > > event_sched_out() is called via __perf_remove_from_context()
> > > So above case, the enable time is fixed in here.
> >
> > OK, how's this then?
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 065f9188b44a..96a00034b26f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2406,7 +2406,8 @@ ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
>
>  #define DETACH_GROUP	0x01UL
>  #define DETACH_CHILD	0x02UL
> -#define DETACH_DEAD	0x04UL
> +#define DETACH_EXIT	0x04UL
> +#define DETACH_DEAD	0x048L
>
>  /*
>   * Cross CPU call to remove a performance event
> @@ -2421,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
>  			   void *info)
>  {
>  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
> +	enum perf_event_state state = PERF_EVENT_STATE_OFF;
>  	unsigned long flags = (unsigned long)info;
>
>  	ctx_time_update(cpuctx, ctx);
> @@ -2429,16 +2431,20 @@ __perf_remove_from_context(struct perf_event *event,
>  	 * Ensure event_sched_out() switches to OFF, at the very least
>  	 * this avoids raising perf_pending_task() at this time.
>  	 */
> -	if (flags & DETACH_DEAD)
> +	if (flags & DETACH_EXIT)
> +		state = PERF_EVENT_STATE_EXIT;
> +	if (flags & DETACH_DEAD) {
>  		event->pending_disable = 1;
> +		state = PERF_EVENT_STATE_DEAD;
> +	}
>  	event_sched_out(event, ctx);
>  	if (flags & DETACH_GROUP)
>  		perf_group_detach(event);
>  	if (flags & DETACH_CHILD)
>  		perf_child_detach(event);
>  	list_del_event(event, ctx);
> -	if (flags & DETACH_DEAD)
> -		event->state = PERF_EVENT_STATE_DEAD;
> +
> +	perf_event_set_state(event, min(event->state, state));
>
>  	if (!pmu_ctx->nr_events) {
>  		pmu_ctx->rotate_necessary = 0;
> @@ -13371,12 +13377,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
>  		mutex_lock(&parent_event->child_mutex);
>  	}
>
> -	perf_remove_from_context(event, detach_flags);
> -
> -	raw_spin_lock_irq(&ctx->lock);
> -	if (event->state > PERF_EVENT_STATE_EXIT)
> -		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
> -	raw_spin_unlock_irq(&ctx->lock);
> +	perf_remove_from_context(event, detach_flags | DETACH_EXIT);
>
>  	/*
>  	 * Child events can be freed.

Yes. I think this looks good to me to solve this error prints :)

