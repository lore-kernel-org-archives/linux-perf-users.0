Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FED12F38D;
	Mon, 13 May 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566972; cv=fail; b=YRIPSmSl8koRWPIQbeIAh7ZPzWsfXhAZBqYOjEiKCUhuwQiBKT67yiGA4Wk3N8jqhYMGUve83uE9Topctt1ou9B+EyaA7WX2Ut+JLpLesEMIaWI7sES/svY1S/Z9XaOgPBGy35Bn8usVFZ5cyaBkfd4Ib1u95ZUTk2NwmBUT8X0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566972; c=relaxed/simple;
	bh=jIx28tmQ92Su7n+8wD87d2sZcyKEwhcmuYgL1BFcScU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MiFk+0HAGGr6ZhVyoWPoHXVVit/Lz6SJwc8uEmpT9FNQ0JC+uGZi5IbJQEhRJiHRY7qOWdnHknWL2SLLWA2Jy6JFkDTHMHoxV6gyDKR4r0rsEevHm7KT1HBiivcbEaI8+o6AZGcAmNAJvOGyUV/pDEXmHKz7018xcsWphSqBozU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UaLXbDG5; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UaLXbDG5; arc=fail smtp.client-ip=40.107.104.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UaLXbDG5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UaLXbDG5"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=VRuVaUN/7cKC6sxDvpvzDBZjUKd9wcAyAucxPiH72SDG/Ei6ksVIzzFvAHndGIvMLVkcpQfbVFKkj0/DjbDpAvmAE0/cPLzAMSXmMci7Tcz32Ch+AmB5rDAms5dUEdKiHWIVHjwhYpnACb3ofEQjXQRZM95xiniGvoAz4AT0BR/EXDFz73N+oKdYo6Y71yUZLC3u+cihGGdTJO0Buk+3y1Aa2fLDUElrmTOVsN7UwCAvWhbp5YbEjuAsj9tEn88vzhKZ9QHsXZ+JkTnCJ+2lZlrDKrHRz5CGK1AXK2CdAWTMywp3zfIyW9LZM3KNNeO0BorhjZrVRVK4cp6spVYXtg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIx28tmQ92Su7n+8wD87d2sZcyKEwhcmuYgL1BFcScU=;
 b=knlprZ2Jr2g0gVl4dELcm/2ihFrQ7nMQ2mJnvbYqd820UMt+vecqOQhFon/mEG4Zmu/5rqe0NSMAbtSif1G8uWuJGAoTyc4sWa1+etoTgcsyIwDvc9GAboTEt1ujrgufh/O8dQ1zbERn50JOQW2oLn5cfr6HjG5gW7/5YKxXstudPO2UlTnKh6YtX0InTOAsmx52RViGHTShfKgeqAdjWEF/MyESgRMXIryCUXTF0YsBIp7WAmt6DywZZ9AOkEVMbfevvW0BHfIm2i6NSopjLeOcs2XIFuGtX68GzubQhTRg+214Ha3IvcLjZDUumldv7gWbTIEarDiwaAoFoz7Vww==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIx28tmQ92Su7n+8wD87d2sZcyKEwhcmuYgL1BFcScU=;
 b=UaLXbDG5miuwTt8aDC1kvIQwV8dxGV3kkp2LeUEhu/ToWiu9df3Ba8WGjC9TAA8wVdJ86zCfeakberwubWPbithYUrOxJJIi6FH6aeRc0DUtS/B04IPLLcom5BKYWeKvUvVjaHM1xuo/x2g3lJ2rhRg7IAFG5ID9GcCmWomnwRY=
Received: from AS4P192CA0007.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::19)
 by AS8PR08MB9954.eurprd08.prod.outlook.com (2603:10a6:20b:638::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:22:38 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:5da:cafe::b6) by AS4P192CA0007.outlook.office365.com
 (2603:10a6:20b:5da::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Mon, 13 May 2024 02:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7587.21
 via Frontend Transport; Mon, 13 May 2024 02:22:37 +0000
Received: ("Tessian outbound 082664cc04c1:v315"); Mon, 13 May 2024 02:22:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 269d4343f67ae506
X-CR-MTA-TID: 64aa7808
Received: from 9a880bc60bfc.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 75C0FC56-6A8C-481E-A050-B6ABEE7AD6C9.1;
	Mon, 13 May 2024 02:22:25 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9a880bc60bfc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 13 May 2024 02:22:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr50BTsJRx5JY6AfUk2aAigYDqzn95uuEGFw7Nr1VH8QKrI5WOjk6+0wvNJIcACrPVhdAd4Uv+Mpuw35zhxKceOa4LvZ3fvnetyM1XQAGpyGXTlkSvnqhO62lR3s19W06jrp1Nw1CzQhWxaT/IRwEyI7IGx7GMgPwUUj3+4dNFF3uYnXHL4Og72f7NT3C41CjCHvxGqig4N/BLunAN1ArjqKPBuNn/WorC9REVpuE96DqjEvZ9JoQV45ZU+xBBGdq9HnWCKZVXxA/nnEo8uMcTGE1OHQbH37q4B1zVKXx3c8BMqkfUppsYcNG9P+/r7esBylr0gosUUmyyPE32QTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIx28tmQ92Su7n+8wD87d2sZcyKEwhcmuYgL1BFcScU=;
 b=Yzlvq58HUo05iUmD3iGiSCV95dRt8ieRilVh6H9NNCps7t41SXEij75DSjh8S81mw4yuOoMKYHQNjCKFGPjV86JXOMpGbfLvejLOw6zNJRb8XBJOzRdNbx2npD52/rIGyl0UhWoZ2SqoVXbL3r4elvt07cTGTbDABTd+0tbmVp9tIXcERwIGw74aDtJpfFqOkkIiBE2QsC/ZPEYPFTnBwOpyr3evAy8OExXiHwfrs16k61hwNBcRRHyqq9XGqp3H8CqsBxaLb2zk0QTwCiQyOYf/UV1Vo3iSRU5TphQRAtQ9hGPV6CZ8Ng88y6e9MAApXVYAcxTDZXB5icTUFJlyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIx28tmQ92Su7n+8wD87d2sZcyKEwhcmuYgL1BFcScU=;
 b=UaLXbDG5miuwTt8aDC1kvIQwV8dxGV3kkp2LeUEhu/ToWiu9df3Ba8WGjC9TAA8wVdJ86zCfeakberwubWPbithYUrOxJJIi6FH6aeRc0DUtS/B04IPLLcom5BKYWeKvUvVjaHM1xuo/x2g3lJ2rhRg7IAFG5ID9GcCmWomnwRY=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by GVXPR08MB7871.eurprd08.prod.outlook.com (2603:10a6:150:17::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:22:22 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::e33b:91d9:dd96:4862]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::e33b:91d9:dd96:4862%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 02:22:22 +0000
From: Justin He <Justin.He@arm.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, James Clark <James.Clark@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Garry
	<john.g.garry@oracle.com>
Subject: RE: [PATCH v1] perf pmu: Count sys and cpuid json events separately
Thread-Topic: [PATCH v1] perf pmu: Count sys and cpuid json events separately
Thread-Index: AQHaoztADnVYs529I0KUljRo9Buqc7GUaVYg
Date: Mon, 13 May 2024 02:22:22 +0000
Message-ID:
 <DBBPR08MB4538FF1CC6CC1C3CD37FCF76F7E22@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20240511003601.2666907-1-irogers@google.com>
In-Reply-To: <20240511003601.2666907-1-irogers@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DBBPR08MB4538:EE_|GVXPR08MB7871:EE_|AM2PEPF0001C710:EE_|AS8PR08MB9954:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff21008-ef83-4f55-ff62-08dc72f38eaa
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009|921011;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VldxU2VqUjdhSGxPYjlCaHN2WVVQNVZBWUlzdUVjZFgrNGxUZTlrQ2tLTjZT?=
 =?utf-8?B?NzQ1MDNVWm5QS2ZRUEtQMGgxNVRrZVYrVmJydFFxRks3MVh5Y0xqZmJ1aDll?=
 =?utf-8?B?VGtTdURRWGlkaldXMVZmMHJvVk5jbzZ1Z0RETVhvUTJZZVo1Zm1GWEYzelJG?=
 =?utf-8?B?WDVuVll0RHh0Z2VweHNQdVg4TllxN1g3dGtZRGt1b09OYjFZdG54eUJlTXpE?=
 =?utf-8?B?N1pHZ29MUHYvZWdhK0V2OUNsVCtXTFFKRk9Ubkl4cWhvK0RBcGhSYUNaaGJp?=
 =?utf-8?B?R3hjTkQ0cmtpSWZLY3lheFo4Ym1VRjRpU0ltYUtFTmlSd3hwMDg2bXRzNWEx?=
 =?utf-8?B?Ukdab0w4SS9aQ3cwOWZuOGpLVnU4Zk5sVE55RjNzUjdZdWJtVitIQk9ZTk0y?=
 =?utf-8?B?alNIYkoySGRyN3RwY2x4ZG43VUUwdzZsWGw1QlNIVEpZQ09USkp0ZGhpcEto?=
 =?utf-8?B?dCtjN0RDK3hLWUdORSsza2ZWSi9vbGZhTmZWZzBHd1N1dEhDMUhZRVc1RTN6?=
 =?utf-8?B?TGdxUExHTGFSeUNubjllWGpxOTVoZ243VkxzWm5kRVFzRUlSV251bFZiUXdk?=
 =?utf-8?B?R2dtNGo2ZWdpVmQ4T3JtM2oxeEZnODB5empmQTFwQjJoZ0hIbG9rMXVPcVpE?=
 =?utf-8?B?aXBES2lzRmd4ekRpK3RkbytaWjFlR0NWTVkxclc2ck5HVjEwY2lJSVdFWjRh?=
 =?utf-8?B?Qi9KQml5a2JWWmU1aWhRTU9GdWZSLzMySHdOaXFZOUFST0pSOVBSNDMxUkVi?=
 =?utf-8?B?Q0lqTi9zbGdyQ0E4YzhsMkNEUTVoQm5XTVhiMHJqbS9qeFZ1cTcyR2lVLzN4?=
 =?utf-8?B?MXN3ekpCeCtxRGNiRGZHdHNETGpiU1ZvbTNiUnN6eGcxUGw1Q3MzVGtaYVVL?=
 =?utf-8?B?ZXpQNW5PeHlyRnlVY2ZCd1VBN1lPVW05WHk4QnVaUlRlaXdrT2NaQTdRd0JT?=
 =?utf-8?B?a1ltQXlBdXBiQ2J5WklGZ3V6Nm84QStzdWxiOWJMc3hiejRBdXR4U3dZRjJv?=
 =?utf-8?B?cGEydkFRRlNxMmVHaEdWeUFhTUJPMG1pcldWMCt4d0xHOGFUeG9KV25TRXpw?=
 =?utf-8?B?SDVxSmJXSEhUNjZzVWp0MXBXb1BHOHhVdkJaUFhXbnBGLy9yMjJtdk8rdzhO?=
 =?utf-8?B?TDlnS3FmYjZRcFZQWTNEK2RoQWhwYWsrOFlxZUVZRTFldm1kUjlURndCeXE4?=
 =?utf-8?B?anVaWERPTE42RC96QWdMaTd5N1FpWGJmSVIrRUc1MGtEbmxEdWRYZzFNdXp1?=
 =?utf-8?B?enJNU0hoL3pOenBMVm53MEJUS1Q3RjVrV1gxNkE0bVg3YkpJQnZMNUpoZzRx?=
 =?utf-8?B?VCt0SHR3RndiOS90YTJpSGtNQXg3RjZ2ekx4VzBBdjJkRExOQnhBTVNkN1F6?=
 =?utf-8?B?Z2Vvdm94bXZhdmVZS3Q1dEJmT3RtR1dvTUc5U3FSZllpREZLSUJlSG9yeTdP?=
 =?utf-8?B?NFhoSFFDOTJzVkZZNmdhWDlYS0lWVjhDKzlJRmc4NW1GYVg5YmhTN3lhcDJD?=
 =?utf-8?B?WGtwTVdPZFg0QWdtamt1MWxtMEFhelh4WTVGM09ZYkdVSVJPTEhFOEFseU1v?=
 =?utf-8?B?SExFWEY3amtDNFZaM1lNWlBCOCtyc0I3UVJ2N1VnVmpzVUJJQTkyVlJod25T?=
 =?utf-8?B?K0V1Vk9HdHMzYU9NM1ZXajhuZTZXaFI3TWgwTTBHZWFJYXJUYmJ1bC9SMTNG?=
 =?utf-8?B?K0xSOUhpb3ZKYU9PdUNmTEdwbUJvVklkbjJXRFQ4M0diN0dBS1ZGbExQQis1?=
 =?utf-8?Q?n/yw5eVYtcPoINAbsQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7871
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c4bda39b-5e61-42ef-5217-08dc72f38582
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|35042699013|1800799015|376005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek42SEV1dFQxc0M3a2pETXZyTFMrU09pc3RGK3g5TUhncnR3M0h5L0xOTjgr?=
 =?utf-8?B?VFlIZVV0K05leWx4TE42MGNiYXJEK2cxN1k3YW1xVTB6aHZpOHJXMnByNkxF?=
 =?utf-8?B?WEppdnRQUW42dE4za3A3TXVjRnVjcFg2T1Z1TU0wWHRpTFZ2VGJQcVVVQnpy?=
 =?utf-8?B?Zys2RStOcWxvb25ub3V2YWExbkNCV0NIQk4rTm01ZjlDV2ZnUTF5YXpYQmht?=
 =?utf-8?B?dWJwWVJvYnQxWlg2MHVxRU1UK3FLK0gxWTZhOXZpUmRYcld0U200cE5SbHUr?=
 =?utf-8?B?MUtPVE82SzlDMFoyNGQ0N0Z3TXRDZTNnVTB3V2dkSG9QQTNRdEI4K3R5c1Bo?=
 =?utf-8?B?Mnh5WHR6eFl6Rkp3ZkZCWm9pdjhmM3dETExML3lxbDA3K2NSSVpBeFgrVEdn?=
 =?utf-8?B?aWxzUmtRSHNaL3NiSnZBTHlFcEhJTWxGUkMxK3RsR3d3elZ4TFlENkpGeGFH?=
 =?utf-8?B?SCt3bkNhU2JmYktZc2l1eHpoQzVZY294b3hMQ3VkSGJSRGQwYUNLeUtmQkFH?=
 =?utf-8?B?UGZrZi8yNjFtUTNXRmhMOXV0YUdWaGkrQ3dWNnBkdU5qdk9lREJIVUJwdThz?=
 =?utf-8?B?QjNTS2xoVmxzdzFUUC9ocnY0UVQ0c1FMeXJtR0hxOHJDV0pBUUxnenR2aSt0?=
 =?utf-8?B?b3NSTVhXWE0rOVI0bENuRmhqWHVMWnJncUd2REVXOUo5UEhpc2N6MjZ0TzFZ?=
 =?utf-8?B?UzhkUUNGaS9MZU85UFNCbU0zbTBKMFNVUDlhejhRSTVWSFc3U0NLQTB2WmJ4?=
 =?utf-8?B?UnlxZEloRlBpb0RaUnZzL2xJOFdJaHl0TWVoSWN5VHFHNStLa3QrQWYrRC9U?=
 =?utf-8?B?Y1lEM1dmYVZCenkxb3VwYkhDSjFHUG1GaC9yeitTcE43QlU2UjhyTzlNMHpJ?=
 =?utf-8?B?RjB1a1J2c0JiY2VZeW50akxReHhra0NtSUtvSDRhZmVrdEcwYlJ1MlBoR2Jl?=
 =?utf-8?B?MDZNY3ZFV2hrYTUrZll6WjhQYStjRDRZbW1BdGNweXhXRUEybTUzTjBSTmZh?=
 =?utf-8?B?YjE2U3lhWHkwbzVFb0cvM3VEdTIrOEF0cVgzZ0svbDAyWWdsTzQ4c2JVdS9T?=
 =?utf-8?B?bTQrUmN0SzdIQWRHeWl5cTFjNU5qZU5tMnZjL01YUkRxR1F0VkgrWVFrMFZQ?=
 =?utf-8?B?S2VRQTVSdmYyWE1JdmNCSXJXb0dLeC9TdU9SVGZsTFBteGVpSTlzVmFYQ1Er?=
 =?utf-8?B?TVkxY2VoVUpxcUNIRTJTVTRDNGlJM3pvZEFiTC9IZDdXUGFqSFgrWWpmWFl1?=
 =?utf-8?B?RXdMbDRldkFQRnBxV1lVbUg4cStJeHVZaEgwcGhRSnBZcllwdFNqK1J3VEU4?=
 =?utf-8?B?ZXZ2WU1YS0JtK1BoZVhDbSt2MW9nQ29tc3VCWmEwb3NrT0lmWnhrSUgyTkZL?=
 =?utf-8?B?WUZVSlhxTThpYkVCSEpBY2p6a0trRDA2YzBiT0I0eGk4K2YrQXp0aHJtd0tL?=
 =?utf-8?B?WWZtYVpsaWVCYlNGU1l6cld2c3oxNXFoR05pTVEweVFFRFFickF4b2srVXFU?=
 =?utf-8?B?TmR0bURKcVJwWEcyc2M4Y3I3NllmMmlzWUU4ZDdncmhXczFIbm1CK3MwYU9I?=
 =?utf-8?B?SExWVlJZaWpSYlZIbndSMjFaVGZWeTZlQkE2MmlEdm9KNjdOWnIzVWdoMkx2?=
 =?utf-8?B?Mmd2RnlUUmQvdVJWTmIrdS9XT0haNllWQ3VibHZtSTd2K2lwRkhocm43UVhI?=
 =?utf-8?B?bkdGbXl4MEFwdDVVb1FwSExhOStHYUNrUXZRR0RFY1FPM3NGOE1RRXVKT2Z6?=
 =?utf-8?B?NmZyWk9MMGVVWkZwdFN6TDZkaXZiVmNiVngwTTNaNmZTRGtiLzVjOE1rbFdv?=
 =?utf-8?B?STZlQUozNzVYY3FDcTdGdz09?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(82310400017)(35042699013)(1800799015)(376005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:22:37.5020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff21008-ef83-4f55-ff62-08dc72f38eaa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9954

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgTWF5IDExLCAyMDI0IDg6MzYgQU0N
Cj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+OyBQZXRlciBaaWpsc3RyYSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+Ow0KPiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IEFy
bmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA8YWNtZUBrZXJuZWwub3JnPjsgTmFtaHl1bmcgS2lt
IDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kDQo+IDxNYXJrLlJ1dGxhbmRAYXJt
LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0KPiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4Lmlu
dGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FAa2VybmVsLm9yZz47IElhbiBSb2dlcnMNCj4gPGly
b2dlcnNAZ29vZ2xlLmNvbT47IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
PjsgS2FuIExpYW5nDQo+IDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsgSmFtZXMgQ2xhcmsg
PEphbWVzLkNsYXJrQGFybS5jb20+Ow0KPiBsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSm9obiBHYXJyeQ0KPiA8am9obi5nLmdh
cnJ5QG9yYWNsZS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MV0gcGVyZiBwbXU6IENvdW50IHN5
cyBhbmQgY3B1aWQganNvbiBldmVudHMgc2VwYXJhdGVseQ0KPg0KPiBTeXMgZXZlbnRzIGFyZSBl
YWdlcmx5IGxvYWRlZCBhcyBlYWNoIGV2ZW50IGhhcyBhIGNvbXBhdCBvcHRpb24gdGhhdCBtYXkg
bWVhbg0KPiB0aGUgZXZlbnQgaXMgb3IgaXNuJ3QgYXNzb2NpYXRlZCB3aXRoIHRoZSBQTVUuIFRo
ZXNlIHNob3VsZG4ndCBiZSBjb3VudGVkIGFzDQo+IGxvYWRlZF9qc29uX2V2ZW50cyBhcyB0aGF0
IGlzIHVzZWQgZm9yIGpzb24gZXZlbnRzIG1hdGNoaW5nIHRoZSBDUFVJRCB0aGF0IG1heQ0KPiBv
ciBtYXkgbm90IGhhdmUgYmVlbiBsb2FkZWQuIFRoZSBtaXNtYXRjaCBjYXVzZXMgaXNzdWVzIG9u
IEFSTTY0IHRoYXQgdXNlcw0KPiBzeXMgZXZlbnRzLg0KPg0KPiBSZXBvcnRlZC1ieTogSmlhIEhl
IDxqdXN0aW4uaGVAYXJtLmNvbT4NCj4gQ2xvc2VzOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMjQwNTEwMDI0NzI5LjEwNzU3MzItMS1qdXN0aW4uaGVAYXJtLmNvbQ0KPiAvDQo+
IEZpeGVzOiBlNmZmMWVlZDM1ODQgKCJwZXJmIHBtdTogTGF6aWx5IGFkZCBKU09OIGV2ZW50cyIp
DQo+IFNpZ25lZC1vZmYtYnk6IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4NCj4gLS0t
DQo+ICB0b29scy9wZXJmL3V0aWwvcG11LmMgfCA3MCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tDQo+ICB0b29scy9wZXJmL3V0aWwvcG11LmggfCAgNiArKy0tDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL3BtdS5jIGIvdG9vbHMvcGVyZi91dGlsL3Bt
dS5jIGluZGV4DQo+IGIzYjA3MmZlZWYwMi4uODg4Y2U5OTEyMjc1IDEwMDY0NA0KPiAtLS0gYS90
b29scy9wZXJmL3V0aWwvcG11LmMNCj4gKysrIGIvdG9vbHMvcGVyZi91dGlsL3BtdS5jDQo+IEBA
IC0zNiw2ICszNiwxOCBAQCBzdHJ1Y3QgcGVyZl9wbXUgcGVyZl9wbXVfX2Zha2UgPSB7DQo+DQo+
ICAjZGVmaW5lIFVOSVRfTUFYX0xFTiAzMSAvKiBtYXggbGVuZ3RoIGZvciBldmVudCB1bml0IG5h
bWUgKi8NCj4NCj4gK2VudW0gZXZlbnRfc291cmNlIHsNCj4gKyAgICAgLyogQW4gZXZlbnQgbG9h
ZGVkIGZyb20gL3N5cy9kZXZpY2VzLzxwbXU+L2V2ZW50cy4gKi8NCj4gKyAgICAgRVZFTlRfU1JD
X1NZU0ZTLA0KPiArICAgICAvKiBBbiBldmVudCBsb2FkZWQgZnJvbSBhIENQVUlEIG1hdGNoZWQg
anNvbiBmaWxlLiAqLw0KPiArICAgICBFVkVOVF9TUkNfQ1BVX0pTT04sDQo+ICsgICAgIC8qDQo+
ICsgICAgICAqIEFuIGV2ZW50IGxvYWRlZCBmcm9tIGEgL3N5cy9kZXZpY2VzLzxwbXU+L2lkZW50
aWZpZXIgbWF0Y2hlZCBqc29uDQo+ICsgICAgICAqIGZpbGUuDQo+ICsgICAgICAqLw0KPiArICAg
ICBFVkVOVF9TUkNfU1lTX0pTT04sDQo+ICt9Ow0KPiArDQo+ICAvKioNCj4gICAqIHN0cnVjdCBw
ZXJmX3BtdV9hbGlhcyAtIEFuIGV2ZW50IGVpdGhlciByZWFkIGZyb20gc3lzZnMgb3IgYnVpbHRp
biBpbg0KPiAgICogcG11LWV2ZW50cy5jLCBjcmVhdGVkIGJ5IHBhcnNpbmcgdGhlIHBtdS1ldmVu
dHMganNvbiBmaWxlcy4NCj4gQEAgLTUyMSw3ICs1MzMsNyBAQCBzdGF0aWMgaW50IHVwZGF0ZV9h
bGlhcyhjb25zdCBzdHJ1Y3QgcG11X2V2ZW50ICpwZSwNCj4NCj4gIHN0YXRpYyBpbnQgcGVyZl9w
bXVfX25ld19hbGlhcyhzdHJ1Y3QgcGVyZl9wbXUgKnBtdSwgY29uc3QgY2hhciAqbmFtZSwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZGVzYywgY29uc3QgY2hh
ciAqdmFsLCBGSUxFICp2YWxfZmQsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bnN0IHN0cnVjdCBwbXVfZXZlbnQgKnBlKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBzdHJ1Y3QgcG11X2V2ZW50ICpwZSwgZW51bSBldmVudF9zb3VyY2Ugc3JjKQ0KPiAg
ew0KPiAgICAgICBzdHJ1Y3QgcGVyZl9wbXVfYWxpYXMgKmFsaWFzOw0KPiAgICAgICBpbnQgcmV0
Ow0KPiBAQCAtNTc0LDI1ICs1ODYsMzAgQEAgc3RhdGljIGludCBwZXJmX3BtdV9fbmV3X2FsaWFz
KHN0cnVjdCBwZXJmX3BtdQ0KPiAqcG11LCBjb25zdCBjaGFyICpuYW1lLA0KPiAgICAgICAgICAg
ICAgIH0NCj4gICAgICAgICAgICAgICBzbnByaW50ZihhbGlhcy0+dW5pdCwgc2l6ZW9mKGFsaWFz
LT51bml0KSwgIiVzIiwgdW5pdCk7DQo+ICAgICAgIH0NCj4gLSAgICAgaWYgKCFwZSkgew0KPiAt
ICAgICAgICAgICAgIC8qIFVwZGF0ZSBhbiBldmVudCBmcm9tIHN5c2ZzIHdpdGgganNvbiBkYXRh
LiAqLw0KPiAtICAgICAgICAgICAgIHN0cnVjdCB1cGRhdGVfYWxpYXNfZGF0YSBkYXRhID0gew0K
PiAtICAgICAgICAgICAgICAgICAgICAgLnBtdSA9IHBtdSwNCj4gLSAgICAgICAgICAgICAgICAg
ICAgIC5hbGlhcyA9IGFsaWFzLA0KPiAtICAgICAgICAgICAgIH07DQo+IC0NCj4gKyAgICAgc3dp
dGNoIChzcmMpIHsNCj4gKyAgICAgZGVmYXVsdDoNCj4gKyAgICAgY2FzZSBFVkVOVF9TUkNfU1lT
RlM6DQo+ICAgICAgICAgICAgICAgYWxpYXMtPmZyb21fc3lzZnMgPSB0cnVlOw0KPiAgICAgICAg
ICAgICAgIGlmIChwbXUtPmV2ZW50c190YWJsZSkgew0KPiArICAgICAgICAgICAgICAgICAgICAg
LyogVXBkYXRlIGFuIGV2ZW50IGZyb20gc3lzZnMgd2l0aCBqc29uIGRhdGEuICovDQo+ICsgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdXBkYXRlX2FsaWFzX2RhdGEgZGF0YSA9IHsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLnBtdSA9IHBtdSwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLmFsaWFzID0gYWxpYXMsDQo+ICsgICAgICAgICAgICAgICAgICAgICB9
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgaWYgKHBtdV9ldmVudHNfdGFibGVfX2ZpbmRfZXZl
bnQocG11LT5ldmVudHNfdGFibGUsIHBtdSwNCj4gbmFtZSwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVwZGF0ZV9hbGlhcywgJmRhdGEp
ID09IDApDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBtdS0+bG9hZGVkX2pzb25f
YWxpYXNlcysrOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwbXUtPmNwdV9qc29u
X2FsaWFzZXMrKzsNCj4gICAgICAgICAgICAgICB9DQo+IC0gICAgIH0NCj4gLQ0KPiAtICAgICBp
ZiAoIXBlKQ0KPiAgICAgICAgICAgICAgIHBtdS0+c3lzZnNfYWxpYXNlcysrOw0KPiAtICAgICBl
bHNlDQo+IC0gICAgICAgICAgICAgcG11LT5sb2FkZWRfanNvbl9hbGlhc2VzKys7DQo+ICsgICAg
ICAgICAgICAgYnJlYWs7DQo+ICsgICAgIGNhc2UgIEVWRU5UX1NSQ19DUFVfSlNPTjoNCj4gKyAg
ICAgICAgICAgICBwbXUtPmNwdV9qc29uX2FsaWFzZXMrKzsNCj4gKyAgICAgICAgICAgICBicmVh
azsNCj4gKyAgICAgY2FzZSAgRVZFTlRfU1JDX1NZU19KU09OOg0KPiArICAgICAgICAgICAgIHBt
dS0+c3lzX2pzb25fYWxpYXNlcysrOw0KPiArICAgICAgICAgICAgIGJyZWFrOw0KPiArDQo+ICsg
ICAgIH0NCj4gICAgICAgbGlzdF9hZGRfdGFpbCgmYWxpYXMtPmxpc3QsICZwbXUtPmFsaWFzZXMp
Ow0KPiAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gQEAgLTY1Myw3ICs2NzAsOCBAQCBzdGF0aWMg
aW50IF9fcG11X2FsaWFzZXNfcGFyc2Uoc3RydWN0IHBlcmZfcG11ICpwbXUsDQo+IGludCBldmVu
dHNfZGlyX2ZkKQ0KPiAgICAgICAgICAgICAgIH0NCj4NCj4gICAgICAgICAgICAgICBpZiAocGVy
Zl9wbXVfX25ld19hbGlhcyhwbXUsIG5hbWUsIC8qZGVzYz0qLyBOVUxMLA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qdmFsPSovIE5VTEwsIGZpbGUsIC8qcGU9Ki8g
TlVMTCkgPCAwKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qdmFs
PSovIE5VTEwsIGZpbGUsIC8qcGU9Ki8gTlVMTCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBFVkVOVF9TUkNfU1lTRlMpIDwgMCkNCj4gICAgICAgICAgICAgICAgICAg
ICAgIHByX2RlYnVnKCJDYW5ub3Qgc2V0IHVwICVzXG4iLCBuYW1lKTsNCj4gICAgICAgICAgICAg
ICBmY2xvc2UoZmlsZSk7DQo+ICAgICAgIH0NCj4gQEAgLTk0Niw3ICs5NjQsOCBAQCBzdGF0aWMg
aW50IHBtdV9hZGRfY3B1X2FsaWFzZXNfbWFwX2NhbGxiYWNrKGNvbnN0DQo+IHN0cnVjdCBwbXVf
ZXZlbnQgKnBlLCAgew0KPiAgICAgICBzdHJ1Y3QgcGVyZl9wbXUgKnBtdSA9IHZkYXRhOw0KPg0K
PiAtICAgICBwZXJmX3BtdV9fbmV3X2FsaWFzKHBtdSwgcGUtPm5hbWUsIHBlLT5kZXNjLCBwZS0+
ZXZlbnQsIC8qdmFsX2ZkPSovDQo+IE5VTEwsIHBlKTsNCj4gKyAgICAgcGVyZl9wbXVfX25ld19h
bGlhcyhwbXUsIHBlLT5uYW1lLCBwZS0+ZGVzYywgcGUtPmV2ZW50LCAvKnZhbF9mZD0qLw0KPiBO
VUxMLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIHBlLCBFVkVOVF9TUkNfQ1BVX0pTT04p
Ow0KPiAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4NCj4gQEAgLTk4MSwxMyArMTAwMCwxNCBAQCBz
dGF0aWMgaW50IHBtdV9hZGRfc3lzX2FsaWFzZXNfaXRlcl9mbihjb25zdCBzdHJ1Y3QNCj4gcG11
X2V2ZW50ICpwZSwNCj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4NCj4gICAgICAgaWYgKHBt
dV91bmNvcmVfYWxpYXNfbWF0Y2gocGUtPnBtdSwgcG11LT5uYW1lKSAmJg0KPiAtICAgICAgICAg
ICAgICAgICAgICAgcG11X3VuY29yZV9pZGVudGlmaWVyX21hdGNoKHBlLT5jb21wYXQsIHBtdS0+
aWQpKSB7DQo+ICsgICAgICAgICBwbXVfdW5jb3JlX2lkZW50aWZpZXJfbWF0Y2gocGUtPmNvbXBh
dCwgcG11LT5pZCkpIHsNCj4gICAgICAgICAgICAgICBwZXJmX3BtdV9fbmV3X2FsaWFzKHBtdSwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGUtPm5hbWUsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBlLT5kZXNjLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwZS0+ZXZlbnQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qdmFsX2Zk
PSovIE5VTEwsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBlKTsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcGUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEVWRU5UX1NSQ19TWVNfSlNPTik7DQo+ICAgICAgIH0NCj4NCj4gICAgICAgcmV0dXJuIDA7
DQo+IEBAIC0xMDgyLDYgKzExMDIsMTIgQEAgc3RydWN0IHBlcmZfcG11ICpwZXJmX3BtdV9fbG9v
a3VwKHN0cnVjdA0KPiBsaXN0X2hlYWQgKnBtdXMsIGludCBkaXJmZCwgY29uc3QgY2hhcg0KPiAg
ICAgICBwbXUtPm1heF9wcmVjaXNlID0gcG11X21heF9wcmVjaXNlKGRpcmZkLCBwbXUpOw0KPiAg
ICAgICBwbXUtPmFsaWFzX25hbWUgPSBwbXVfZmluZF9hbGlhc19uYW1lKHBtdSwgZGlyZmQpOw0K
PiAgICAgICBwbXUtPmV2ZW50c190YWJsZSA9IHBlcmZfcG11X19maW5kX2V2ZW50c190YWJsZShw
bXUpOw0KPiArICAgICAvKg0KPiArICAgICAgKiBMb2FkIHRoZSBzeXMganNvbiBldmVudHMvYWxp
YXNlcyB3aGVuIGxvYWRpbmcgdGhlIFBNVSBhcyBlYWNoIGV2ZW50DQo+ICsgICAgICAqIG1heSBo
YXZlIGEgZGlmZmVyZW50IGNvbXBhdCByZWd1bGFyIGV4cHJlc3Npb24uIFdlIHRoZXJlZm9yZSBj
YW4ndA0KPiArICAgICAgKiBrbm93IHRoZSBudW1iZXIgb2Ygc3lzIGpzb24gZXZlbnRzL2FsaWFz
ZXMgd2l0aG91dCBjb21wdXRpbmcgdGhlDQo+ICsgICAgICAqIHJlZ3VsYXIgZXhwcmVzc2lvbnMg
Zm9yIHRoZW0gYWxsLg0KPiArICAgICAgKi8NCj4gICAgICAgcG11X2FkZF9zeXNfYWxpYXNlcyhw
bXUpOw0KPiAgICAgICBsaXN0X2FkZF90YWlsKCZwbXUtPmxpc3QsIHBtdXMpOw0KPg0KPiBAQCAt
MTczOSwxMiArMTc2NSwxNCBAQCBzaXplX3QgcGVyZl9wbXVfX251bV9ldmVudHMoc3RydWN0IHBl
cmZfcG11DQo+ICpwbXUpDQo+ICAgICAgIHNpemVfdCBucjsNCj4NCj4gICAgICAgcG11X2FsaWFz
ZXNfcGFyc2UocG11KTsNCj4gLSAgICAgbnIgPSBwbXUtPnN5c2ZzX2FsaWFzZXM7DQo+ICsgICAg
IG5yID0gcG11LT5zeXNmc19hbGlhc2VzICsgcG11LT5zeXNfanNvbl9hbGlhc2VzOzsNCg0KTml0
czogZG91YmxlICI7Iiwgb3RoZXJzIGxndG0uDQoNClRoaXMgZml4ZXMgdGhlIGVycm9yIG9uIHRo
ZSBBcm0gTjIgc2VydmVyOg0KVW5leHBlY3RlZCBldmVudCBzbW11djNfcG1jZ18zZjAwMi9zbW11
djNfcG1jZ18zZjAwMi90cmFuc2FjdGlvbi8vDQpVbmV4cGVjdGVkIGV2ZW50IHNtbXV2M19wbWNn
XzNmMDQyL3NtbXV2M19wbWNnXzNmMDQyL3RyYW5zYWN0aW9uLy8NClVuZXhwZWN0ZWQgZXZlbnQg
c21tdXYzX3BtY2dfM2YwNjIvc21tdXYzX3BtY2dfM2YwNjIvdHJhbnNhY3Rpb24vLw0KVW5leHBl
Y3RlZCBldmVudCBzbW11djNfcG1jZ18zZjQwMi9zbW11djNfcG1jZ18zZjQwMi90cmFuc2FjdGlv
bi8vDQpVbmV4cGVjdGVkIGV2ZW50IHNtbXV2M19wbWNnXzNmNDQyL3NtbXV2M19wbWNnXzNmNDQy
L3RyYW5zYWN0aW9uLy8NCi4uLi4uDQoNClBsZWFzZSBmZWVsIGZyZWUgdG8gYWRkDQpUZXN0ZWQt
Ynk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEpp
YSBIZSkNCj4NCj4gICAgICAgaWYgKHBtdS0+Y3B1X2FsaWFzZXNfYWRkZWQpDQo+IC0gICAgICAg
ICAgICAgIG5yICs9IHBtdS0+bG9hZGVkX2pzb25fYWxpYXNlczsNCj4gKyAgICAgICAgICAgICAg
bnIgKz0gcG11LT5jcHVfanNvbl9hbGlhc2VzOw0KPiAgICAgICBlbHNlIGlmIChwbXUtPmV2ZW50
c190YWJsZSkNCj4gLSAgICAgICAgICAgICBuciArPSBwbXVfZXZlbnRzX3RhYmxlX19udW1fZXZl
bnRzKHBtdS0+ZXZlbnRzX3RhYmxlLCBwbXUpIC0NCj4gcG11LT5sb2FkZWRfanNvbl9hbGlhc2Vz
Ow0KPiArICAgICAgICAgICAgIG5yICs9IHBtdV9ldmVudHNfdGFibGVfX251bV9ldmVudHMocG11
LT5ldmVudHNfdGFibGUsIHBtdSkgLQ0KPiBwbXUtPmNwdV9qc29uX2FsaWFzZXM7DQo+ICsgICAg
IGVsc2UNCj4gKyAgICAgICAgICAgICBhc3NlcnQocG11LT5jcHVfanNvbl9hbGlhc2VzID09IDAp
Ow0KPg0KPiAgICAgICByZXR1cm4gcG11LT5zZWxlY3RhYmxlID8gbnIgKyAxIDogbnI7DQo+ICB9
DQo+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvcG11LmggYi90b29scy9wZXJmL3V0aWwv
cG11LmggaW5kZXgNCj4gNTYxNzE2YWEyYjI1Li5iMmQzZmQyOTFmMDIgMTAwNjQ0DQo+IC0tLSBh
L3Rvb2xzL3BlcmYvdXRpbC9wbXUuaA0KPiArKysgYi90b29scy9wZXJmL3V0aWwvcG11LmgNCj4g
QEAgLTEyMyw4ICsxMjMsMTAgQEAgc3RydWN0IHBlcmZfcG11IHsNCj4gICAgICAgY29uc3Qgc3Ry
dWN0IHBtdV9ldmVudHNfdGFibGUgKmV2ZW50c190YWJsZTsNCj4gICAgICAgLyoqIEBzeXNmc19h
bGlhc2VzOiBOdW1iZXIgb2Ygc3lzZnMgYWxpYXNlcyBsb2FkZWQuICovDQo+ICAgICAgIHVpbnQz
Ml90IHN5c2ZzX2FsaWFzZXM7DQo+IC0gICAgIC8qKiBAc3lzZnNfYWxpYXNlczogTnVtYmVyIG9m
IGpzb24gZXZlbnQgYWxpYXNlcyBsb2FkZWQuICovDQo+IC0gICAgIHVpbnQzMl90IGxvYWRlZF9q
c29uX2FsaWFzZXM7DQo+ICsgICAgIC8qKiBAY3B1X2pzb25fYWxpYXNlczogTnVtYmVyIG9mIGpz
b24gZXZlbnQgYWxpYXNlcyBsb2FkZWQgc3BlY2lmaWMgdG8gdGhlDQo+IENQVUlELiAqLw0KPiAr
ICAgICB1aW50MzJfdCBjcHVfanNvbl9hbGlhc2VzOw0KPiArICAgICAvKiogQHN5c19qc29uX2Fs
aWFzZXM6IE51bWJlciBvZiBqc29uIGV2ZW50IGFsaWFzZXMgbG9hZGVkIG1hdGNoaW5nIHRoZQ0K
PiBQTVUncyBpZGVudGlmaWVyLiAqLw0KPiArICAgICB1aW50MzJfdCBzeXNfanNvbl9hbGlhc2Vz
Ow0KPiAgICAgICAvKiogQHN5c2ZzX2FsaWFzZXNfbG9hZGVkOiBBcmUgc3lzZnMgYWxpYXNlcyBs
b2FkZWQgZnJvbSBkaXNrPyAqLw0KPiAgICAgICBib29sIHN5c2ZzX2FsaWFzZXNfbG9hZGVkOw0K
PiAgICAgICAvKioNCj4gLS0NCj4gMi40NS4wLjExOC5nN2ZlMjljOThkNy1nb29nDQoNCklNUE9S
VEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVu
dHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFy
ZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGlt
bWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBw
ZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9y
bWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
