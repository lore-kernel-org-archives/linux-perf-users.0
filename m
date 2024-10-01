Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12E19922D;
	Tue,  1 Oct 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772569; cv=fail; b=h6uFXKw2sj6iKggTiSHNoApJWTd4cplL49fyGEVOdv1TV0Tv+8rUP0Ilhv2e+Uh9koJGN7utGKe5D5aV6TU8EXvBaXZ3C/vvPQgFDyr0MvCzLSnQDxkE1wklyGUaiev1v62Hfz4226o5MXt5E2WgAmqSJ7q7HCNkfvpG+rY+R1I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772569; c=relaxed/simple;
	bh=2ugUiomhGmbzxDg0mHHQorXym12muT6VictP3hBNfas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BRjW8KWjCIgDDuJAHyahaydHCeHXGfK+XnGZI0OhSNtHL0UJM6NT3WYYFsCTz8iAlPGegV98jixddvlg2P97QjZm00d2e+ENw4zLSe5r/647l1NAmJRKkR83A1XkaU4qEBFKGdJRoy/Tsx7zQVXvP+Pbk3IRfMZpxjdL6eWszV4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lkEGe/v/; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lkEGe/v/; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lkEGe/v/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lkEGe/v/"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oiv4iQ3x2Q5noTaHgwBDLWBgpEtEzMGelgNgUd9Br4nBKCVal83jcULduQRXpXDDkFrrGHuDmSLg+6SkvXeyneyI4MmjLG/7Ia+4JmMHTffn+34awcKva8D1i6HR3DYhiXBgpEL8q9yrw9/cvtK106bpzeNVBpi3LNyOsuEnWVuUjZXWZbRICtpjPyaIH64nO3GJi1dKtgGe5x3vXr+j3F0P8ddBdSJXmiQsvQXISIVzpwc0clP6inyZEvBssfrhc1YvOWPQbtWp/7v6DJYZZcGdOgl510zXMNOBoMe1Nxl3Kg6Hm2j6uCSL4sbZHmWo2JqhLieS/UKLL9rUo9cHIg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl7bPm6tLdLU3W6dthUUs13iVh8yZVAOAcYHhd+1FQ0=;
 b=OW2sD6vrSC0L3ZdE30PLitt1lOrREi56IXG9+Nu2JVE/R9O8Kv0Uvq6Z1gibivYcV9RFP0F9Sh9Nvpn3bW1GKLQ0UAccj4Kgr1aAi1OGzstZEdDUmYxYt0E/yqgNEaEEWRWniGDFlvu8ZCyAg1QFjsSHutZQEk4CyuTTMhy+DMstW+fUmrqIboHqt0CwXGzIErDko81jYa63zh9SlCCAlQ5tBU07nOXoiScQm4bEw7sWgqAyMVbg15vdczoKXXRmHaqk/YBlxDAOTMfQfvtXXcia8vFrF9pLGqaPHFjez66Z6KI2J1VTrz15IGWn+5RRjvRwFHW9hJs21ExKsJLUSA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl7bPm6tLdLU3W6dthUUs13iVh8yZVAOAcYHhd+1FQ0=;
 b=lkEGe/v//MEg75z+XoxxUwxpQYkeCO6ZNFe3sbrI2TFFvvyRFnqfF8+FQRKXaoOkTzoMGkvUX+SqmP6nLHhBNWpaX94YBQ1DywQuKoG87PeNKJMB+rbb8XT8c1btEwZ+zf5Oj3lBJUAk8Nf0HjihcITdxlH44awHJfUyFVnKfxw=
Received: from AS4P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::16)
 by AS2PR08MB9343.eurprd08.prod.outlook.com (2603:10a6:20b:598::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 08:49:20 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::cf) by AS4P191CA0030.outlook.office365.com
 (2603:10a6:20b:5d9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 08:49:20 +0000
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
 via Frontend Transport; Tue, 1 Oct 2024 08:49:20 +0000
Received: ("Tessian outbound ba07ec841eae:v471"); Tue, 01 Oct 2024 08:49:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bcd24b5d3666864c
X-TessianGatewayMetadata: T6+jGJaHbz7AwugEUWDtuDLdXXEhXgO5u9XVJAK2k/4izHe5kai4ylH6o+lKq/yDDKlTTfYa8YdVnheg99ZTpioiaHLldNuOOjEv2lthRPqqOCch7oHOvOU3l12FdyMXBBBMKQf5V8aBxRkk0d9GLNAPemhKWMiSww2wQzt6egehSTo4UP/yZAZy0tgwajS4DIU9Ulmcfcyi4BPS+Rrigw==
X-CR-MTA-TID: 64aa7808
Received: from L69bc66d111b6.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8F9C911D-373E-453E-9512-89998DAF9717.1;
	Tue, 01 Oct 2024 08:48:53 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L69bc66d111b6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 01 Oct 2024 08:48:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyNetAoc1XFVttjRz5SAC5yamMv0NigEYvRUCsNuctXd0BXE+eUSL7eXJJig3P6HFeQv1tolZiXjZjna0N2edJCuWthRmuJ3S5R0I07q17aDsVuMhW3SXPF8tK94GOO0uY7rDchvDRaAvXMspy5QNrdMINtylGwafnqjdj4iFyOC9rAFJljPAinjJdsvJxqWEkz3GVbsvpm0XcL1MgaBIW84LYjfoOwr7TNjIOWG9BCRJkEPw6smTX4MbgsXj+TocA6i/ewazapsIHvpknh1VP51VZB0atNEmG2bHvnIW618fy4Nc2CM5tNyF6JtpJHZC2vg4RvdKVENL8CaO5wBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl7bPm6tLdLU3W6dthUUs13iVh8yZVAOAcYHhd+1FQ0=;
 b=TjeD+twA45lrkaI+wIJSZBEqS0M13l5U/t/tVJz0KtOSf2xsj/nR7QgRV6Ktq054aA1+Y9wELcCMXL11FAbDKLgYQpxLRjY5TnP2YPOWm7V6Vv5QfXlFJnBbXqIlgmFTKiGz5xAxRxUbnuGipC+o6oQE5aT8UXjWUEX4S2B7NhBjWq+KwBRQqsJEjEGjiLAQ8oUc5ogrLwbn4fHnZMkizrKTDaZTIDRJCClaLZuBu2YIu+BUkH4oMdTCJ61U4Rscqx7qGfiRbIJEV2Ppt8gS5/YzsrACsLnHdn2Wu10RW4TAkTeaPPeQesz+GHIauzR2vhdAH6fuxkKt5gAdFBfM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl7bPm6tLdLU3W6dthUUs13iVh8yZVAOAcYHhd+1FQ0=;
 b=lkEGe/v//MEg75z+XoxxUwxpQYkeCO6ZNFe3sbrI2TFFvvyRFnqfF8+FQRKXaoOkTzoMGkvUX+SqmP6nLHhBNWpaX94YBQ1DywQuKoG87PeNKJMB+rbb8XT8c1btEwZ+zf5Oj3lBJUAk8Nf0HjihcITdxlH44awHJfUyFVnKfxw=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI0PR08MB10446.eurprd08.prod.outlook.com
 (2603:10a6:800:206::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 08:48:46 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8026.009; Tue, 1 Oct 2024
 08:48:45 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC: "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>, "mingo@elte.hu"
	<mingo@elte.hu>, Mark Rutland <Mark.Rutland@arm.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>, nd <nd@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker
	<fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] trace/trace_event_perf: remove duplicate samples on
 the first tracepoint event
Thread-Topic: [PATCH v2] trace/trace_event_perf: remove duplicate samples on
 the first tracepoint event
Thread-Index: AQHbBYKXoi2hw6C5d0ic7zmh6yP4AbJqGokAgAeXifk=
Date: Tue, 1 Oct 2024 08:48:45 +0000
Message-ID:
 <GV1PR08MB10521EC72BDB730710F3973D4FB772@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20240913021347.595330-1-yeoreum.yun@arm.com>
 <20240926085118.0a823138@rorschach.local.home>
In-Reply-To: <20240926085118.0a823138@rorschach.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|VI0PR08MB10446:EE_|AMS0EPF000001B1:EE_|AS2PR08MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 68355686-3adc-45d9-52f7-08dce1f5f104
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?dz+oexPbhUU3b1oZMjlQ+saSFKRrVEVBKjb/i24SZFKT6xVGEdEeiHW7hx44?=
 =?us-ascii?Q?QvedQkgyKX2eUhgS8pKTlQPaqC7EwFFbrUE8oLFsVzEsIxt+pfRfz0sr0mAz?=
 =?us-ascii?Q?WFn0Z1KvC97s5WYwX134y38X1n291MotJF5xcyOy14ny51f7H95Tp/RjOIRK?=
 =?us-ascii?Q?xpH/AMNnuOD/Uasr7OsWXY6khThmOi7IDhc2kZWvGrSiw6CNyr+nlUYKlaBD?=
 =?us-ascii?Q?tdBVxxHEebtBn8pI0hXNAOonLhfknpraFiAbCLjZ1AwltKd63zDbDHb3amAu?=
 =?us-ascii?Q?lFM4vKs4RhEN7b4tSOZvohvfJ04hzdnta3ZncJxfgBFlM10ws8dvwfe71PHz?=
 =?us-ascii?Q?spZJaVRe4dov2V9vBMZpIjxL2bq7r0sjSK098XKNyogg1d4/hGR2oIS/fUu4?=
 =?us-ascii?Q?Io5mbceXw2T4NptFq5XjcwGNJicsvFbEwl46xKjiKUW38IJh5N7nAr+BLdqm?=
 =?us-ascii?Q?bAUsUJzuE+4sbDAcaruLsSvxT/wdP8uRskHpw4raKbmPDFGJldNct3rbcrUT?=
 =?us-ascii?Q?9RToTo1O895lfdgv6YUggN4dDDp7egVCbCIdZyd0V5fqU2fC8hAn6B4G97qs?=
 =?us-ascii?Q?j+fFcyEFaHD/qAg2YKgf6rCBeowE7PFVrEIPX2qVCZU6L4JMkPmiWReej196?=
 =?us-ascii?Q?HE/o6lE7v2Vg0fPOOv9pqZtiRLklHVSb5qnM2Siaz1K1UFRbt/UMX381C+us?=
 =?us-ascii?Q?UQ14uHFZlsIJ0Ysm3Mf8kISjB4FnRpUcqr47jW9wddOU/DZIQkfSzojOF10L?=
 =?us-ascii?Q?nI/HQK48kYLj/xjENn+CKmuN5cXJY0f/0KB2V5SBIWaEb1tTexa2edav9KTi?=
 =?us-ascii?Q?yauaJIM8R84zHf8cIfchI0Go8wu7vavI5KiZkJnYmwYNE+uEyYlrxtUpDE1y?=
 =?us-ascii?Q?Hz2Js84To+ACUJRW33Y0UegAC2rHIAdjRAaKvouN1RYmJ8+gOpqpnMpj2m/3?=
 =?us-ascii?Q?Y/wKc5tB1yjxUtSD4jCWh4XNVh+8OU/wp1Oonnlvj8+czWcbpaVkHFyjBH/j?=
 =?us-ascii?Q?DUMHj0q2Iq/NYitXznCjL+LapBlcQ6OnWVN0DbMVZSZUaY50sKV0Wc0apWN4?=
 =?us-ascii?Q?vg0LgyxE6k+fslGi6jXP3p9eGY022sp5y+ODPAAEmSuYs841fAqCqZVlR2Pp?=
 =?us-ascii?Q?9j5NfPhdwlo2pRz75z1U/WyXgfyRxsIk5aKMtOJIq8w5Ytnjg6j17A0yR9zK?=
 =?us-ascii?Q?3zcG+4hF/V9w3j8YPU8bdv1mID3VptabZqeHMAOLfBpacv09QhwGLyu/eGyP?=
 =?us-ascii?Q?cATI2IzJTqs2V5OQvkpsYrU9Kw1oxaFih0jN054YdwHyxxCxykBwzrrUVOJW?=
 =?us-ascii?Q?chbVNRDnvEzGB+Z9vOvcjEZD/S149P9xB7DUt3EMj4VA1Frq0H6WBP+a2sz5?=
 =?us-ascii?Q?/m4uHoAxaw6/TUgwcpLRVOoniySN5Ry2mSc86jl6j4ECH8/UYw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10446
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b733eda6-75ae-4d1c-d5f1-08dce1f5dc12
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|35042699022|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VzW8LaBDh1tIWt0QQhJG6GYzeCXD1xQPuOdqr6E1zRCdYF+11Sn+CDiiQGRS?=
 =?us-ascii?Q?zC3EjrjhxmoJ6OJPzZw87vlC0NC+QgadHUA9MLhCnlT6y6yW0hfM+XXeI0NX?=
 =?us-ascii?Q?F2ra6xfslBoq3RH+s7fKvwwOMdLUHGrDsV6weaYH+LAOrLQ1y+9WkSU8AkXz?=
 =?us-ascii?Q?4k/ALlW0+ThzhkNCAfgBMiyDCGfPvqO2yylFUwROAwTs6aSAyGes0n47axiR?=
 =?us-ascii?Q?8lugHzwB1K87xi6Q9sEIlNxT4+ghPlEWb/q/WjcoKUrT6nUrAiBvJd+/viEY?=
 =?us-ascii?Q?rBWiqAjMiOAYSs9hDFDORxA6JazRgQI2j9fiP22W1SUmta8yw8YdyDKWze0I?=
 =?us-ascii?Q?ehlTtXK+HYOyCeipU5BWzfjf1DA7Xl9PnFmQmfu4//Aey08VDwGieGYPEYX/?=
 =?us-ascii?Q?9DNZ0af5CDTuacvR3w82bsdoyaZt03bGr0bK7K/orW5ieOQf06NUMfN4og4M?=
 =?us-ascii?Q?BefDWP6M3xX8gxvSKxf4Cz0ZTnixjVyLeoB5GliC8uSw6+sFqq8b81TcSeOK?=
 =?us-ascii?Q?4m3XO5vCcMgC02TK+w8eeMxYbcQ6qhSqsni2YS4QzcSOBhUFrNwbPYd4ULaO?=
 =?us-ascii?Q?Bl0jhKUp2RKU9uFSiA8Jg6h6DnrmCkWVsKximZbl22Ee4f368CtXFIH85fGy?=
 =?us-ascii?Q?n4dHV5vl9YIR4jRnJBFL3SbhgmSKQJR9MhgjTOmLxJA0Ao90Poy8xLmkORPM?=
 =?us-ascii?Q?3NP+erQ+p+Iz7x9qFIWKg0DlA1MNHtkEbTFQkGVC9ZaKD9cr5sZ5wHP8loFF?=
 =?us-ascii?Q?rAFPNXDhOJNg2+R+o4S4UcYcPkau20vZcU/21afJjUGqcZZovdFjw7alscB1?=
 =?us-ascii?Q?vNLrEcMTpjvE3KMCCHV+DaNqZypWiydfMcI6h8GKzMKW7U27lkrIFOqTHbav?=
 =?us-ascii?Q?IZRmAOZDe0qico3Rv7jWiC4fRlW2OVdCUdtYGjcBV5Tjfi3DQiAGdw4MQgd5?=
 =?us-ascii?Q?uq9wBAjsYzJCWE1+Ah4/rXPGKRjvAYdcke+H0CgCi27fkeMOocAGFCtjRhVT?=
 =?us-ascii?Q?1Fla35gYXqbRDJdw7dUVgf4jDb71oqvJYuCXyyzdCl/0M419VIACa1kwbzSC?=
 =?us-ascii?Q?hOywhEblZ/0wVFPN8a4zRTMBJDyEwK71QL9Q1FBGc8B+ks1Z8oFC/udkzb+5?=
 =?us-ascii?Q?pMQF3RfDtmaD6YULhJ2uffb4atlaqB6DypurP6Ozs4DxeJinL2WQcRcD4DCI?=
 =?us-ascii?Q?pDoOT3W6uU1nPqA38aY4AJZEg6sh3Ehy/xIOZj8T+UYQAvXIXmYUS2xu8qY5?=
 =?us-ascii?Q?kx1HtQ7FQZ9J2a+C6x7Ye47QGNjFDC8cMMFkXz8u3butoLk3xcsJk031vsp2?=
 =?us-ascii?Q?CBr4JR0hnRYTtbFhqiklgWaJNQE8k1D/EqvFmidhJW0Q3KB22UtGC/vWk3ws?=
 =?us-ascii?Q?J6aEU6Il1zYjBZkaYX4wo1Fyhce1UBG4zn6ZFaAPo5ugJDTgw/JjfUV2Vy6M?=
 =?us-ascii?Q?Zr7MJfNpEZaYhwiOHoWIS983MuQEEx3h?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(35042699022)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:49:20.4409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68355686-3adc-45d9-52f7-08dce1f5f104
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9343

Gentle ping in case of forgotten.

________________________________________
From: Steven Rostedt <rostedt@goodmis.org>
Sent: 26 September 2024 13:51
To: Yeo Reum Yun
Cc: mhiramat@kernel.org; mathieu.desnoyers@efficios.com; a.p.zijlstra@chell=
o.nl; mingo@elte.hu; Mark Rutland; james.clark@linaro.org; nd; linux-kernel=
@vger.kernel.org; linux-trace-kernel@vger.kernel.org; Peter Zijlstra; Frede=
ric Weisbecker; Arnaldo Carvalho de Melo; Namhyung Kim
Subject: Re: [PATCH v2] trace/trace_event_perf: remove duplicate samples on=
 the first tracepoint event

Can one of the perf folks give me an Ack, and I'll take this through my tre=
e.

-- Steve


On Fri, 13 Sep 2024 03:13:47 +0100
Levi Yun <yeoreum.yun@arm.com> wrote:

> When a tracepoint event is created with attr.freq =3D 1,
> 'hwc->period_left' is not initialized correctly. As a result,
> in the perf_swevent_overflow() function, when the first time the event oc=
curs,
> it calculates the event overflow and the perf_swevent_set_period() return=
s 3,
> this leads to the event are recorded for three duplicate times.
>
> Step to reproduce:
>     1. Enable the tracepoint event & starting tracing
>          $ echo 1 > /sys/kernel/tracing/events/module/module_free
>          $ echo 1 > /sys/kernel/tracing/tracing_on
>
>     2. Record with perf
>          $ perf record -a --strict-freq -F 1 -e "module:module_free"
>
>     3. Trigger module_free event.
>          $ modprobe -i sunrpc
>          $ modprobe -r sunrpc
>
> Result:
>      - Trace pipe result:
>          $ cat trace_pipe
>          modprobe-174509  [003] .....  6504.868896: module_free: sunrpc
>
>      - perf sample:
>          modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
>          modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
>          modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
>
> By setting period_left via perf_swevent_set_period() as other sw_event di=
d,
> This problem could be solved.
>
> After patch:
>      - Trace pipe result:
>          $ cat trace_pipe
>          modprobe 1153096 [068] 613468.867774: module:module_free: xfs
>
>      - perf sample
>          modprobe 1153096 [068] 613468.867794: module:module_free: xfs
>
> Fixes: bd2b5b12849a ("perf_counter: More aggressive frequency adjustment"=
)
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
> Changes in v2:
>   - Fix build error.
> ---
>  kernel/trace/trace_event_perf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_p=
erf.c
> index 05e791241812..3ff9caa4a71b 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -352,10 +352,16 @@ void perf_uprobe_destroy(struct perf_event *p_event=
)
>  int perf_trace_add(struct perf_event *p_event, int flags)
>  {
>       struct trace_event_call *tp_event =3D p_event->tp_event;
> +     struct hw_perf_event *hwc =3D &p_event->hw;
>
>       if (!(flags & PERF_EF_START))
>               p_event->hw.state =3D PERF_HES_STOPPED;
>
> +     if (is_sampling_event(p_event)) {
> +             hwc->last_period =3D hwc->sample_period;
> +             perf_swevent_set_period(p_event);
> +     }
> +
>       /*
>        * If TRACE_REG_PERF_ADD returns false; no custom action was perfor=
med
>        * and we need to take the default action of enqueueing our event o=
n
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

