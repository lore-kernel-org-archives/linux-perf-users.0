Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3691B0F2E;
	Mon, 25 Nov 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554723; cv=fail; b=X7uz03e05ckZ5RZn3Ln/aMYXOGcMVMEcBw3JCBH62e1FyWmkO1d+W1EepNpDO40QppmjGibYYBwdxSWEAU94JqE6fGQb9FTUBIPmx2G/pdIeLYRLK0hRFLwyEjyBbjhrKeHC93rdLbhNCV9IbcNYTECdR65g5F8t5xqDlrRzYNU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554723; c=relaxed/simple;
	bh=1SHzM5mVf3QPVS4IiAc8Xl8NLxOtlfqi0nNwiUqRuJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WOagXSkVs3m63sJt2I/osGjseqVEg/xiWWDLRlhKe2vD0LUQIUMvrJZ5Djripqu5enfw+katl8fu1yCFOubb82jA0lDquYiQZIQG0vt1X3qRv6tkUT0xYF+KhNcFJTsou14s2Q+09Qx/fisKgV1e4eEGFwNdBBLE1qe86fZ6MAY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZCXktzTf; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZCXktzTf; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZCXktzTf";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZCXktzTf"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vk/BQfS4kfb1YYEurjrhZbAmLRmuuOIRGOW7F27fGOHTRMeJu5TU13G8NUOqmupEgFdEBEqaXF22cTugcU7rDLufFAB2rGxi1r7+n1eSbWpJMVAMLRMc2cyP9UGReSeZMph7nuUoJcxVGZF9H713g0eSXjY3iLmg2u8YXJWOAi2Ai+qw1StKiOwOMuEm3KwCf8FIDaNtnovd4QFQU2p+6EgX6bRP0erlFji44wbgqMd/8A4WoTrUqUuDkW6wU4r/bYi/NKK5R18Hj+fX0RlL6vPfoR4D8dnS1A/BSOvk7nMjHZA01Z7hnbd9cEiBlyh7f78xN5Vuts1OCCE/J6YjxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SHzM5mVf3QPVS4IiAc8Xl8NLxOtlfqi0nNwiUqRuJ8=;
 b=hiqcLJ+V4lXRu5PRPb+1zvCmaXd7+KgBVqgqAFItTIWbKwwuktO1HaWzr1lBur7gY/Z4RFbAVRWQ5k0hAoNlSN1/fcWomjADohRB9GvJunODwdGt+D244/VMiaQCwV3NT/c12jkOwHqJptoHHlW6WhP2WS/msCcgeAtQNXK6k4Vx5TOfda36o9g+zqDpSF0MB/DBvXERgKR17SvZCVIfRW6Ww56ReRaZKsN2aGDclcVWw4i3S5J+8opreLWbNqwCP45+/ITmbM3Rb8c4c5CLwg9fOYSu/yXx11bEj4SKalbJDMIa87Rxbgn6/KEpn0FzB8f2djx3pzHl9N9Syv1Yxw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SHzM5mVf3QPVS4IiAc8Xl8NLxOtlfqi0nNwiUqRuJ8=;
 b=ZCXktzTf+9wn2EN80g19DbiDh1n85nc09D+hN9HNVoa1MHkDny3DIkOXUheYzjnXlXY/BLcVE7edv/9lWdOjxLv7a/cOZOv7q78q80XLaJ3xVVftfQW6K8ArBpf9zNPABFNdZBW6nMZHEbZ6LYilxsnwjGLdp/oyWo+LHtumkXo=
Received: from AS9PR06CA0613.eurprd06.prod.outlook.com (2603:10a6:20b:46e::34)
 by AM8PR08MB5633.eurprd08.prod.outlook.com (2603:10a6:20b:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 17:11:54 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:20b:46e:cafe::76) by AS9PR06CA0613.outlook.office365.com
 (2603:10a6:20b:46e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend
 Transport; Mon, 25 Nov 2024 17:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16
 via Frontend Transport; Mon, 25 Nov 2024 17:11:53 +0000
Received: ("Tessian outbound 6970ca6dd121:v490"); Mon, 25 Nov 2024 17:11:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 03c7fce63493c7cd
X-TessianGatewayMetadata: kI2c9o/BJveIV9LvVm2bnAaKPpz/CrxB+r0jbGX083+PQOpX8A1OPthWf3bMq+Hl0z4HYjkho8fNY52Gl5hLyAHajNcsd+H4bYzb+VNb5YfDp94REyLn7bUJcDn5tDSswAmj7xK6PcqaYozip+aqIgeKNtelAsb1ej7R7Eyw3qeIfGF8jlw04e/t2ygXW8ww
X-CR-MTA-TID: 64aa7808
Received: from L67e62060a11a.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0F2B6157-33B6-4200-AD4B-18E099DE157C.1;
	Mon, 25 Nov 2024 17:11:46 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L67e62060a11a.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 25 Nov 2024 17:11:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXZqz7M1ncFc0ttC1iuv5FY923/pTG48DbYUDo59VeKwfY4VjELmHLA7NTLVGw3Ry77Q6aEL8EBQOemZEanTdfiohQlqm7aXz55PkQK6W1ew+9Tqp8NhgsW0nKCvX2KPGEcDv2vgGKAXw/PjyuGSpHcxKBC+1xgr+RCUX8HI5rMOWGLkFgfaq7wydTu3C0Lbb7nl7ay2HwJLRTTuWUu7Va4CAMazBNXuVps1JYNLD7A3zZvJwP8JPqs7BKAnkBM7KcGOUK60N9qYDtO3KqmFHEUJqpF5GdlnTYyW+qr2TqcIt/cgiWotSgfF7Rt0X7PVI7VsA1bxC3WYN4lYHs4aKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SHzM5mVf3QPVS4IiAc8Xl8NLxOtlfqi0nNwiUqRuJ8=;
 b=Txnxliw6aDG10zXOgu7PJ1WlxbDRyn7hkNW6goK6wKvwU4Z/vMV/CeOjveCddlw7hB/IKkws36nCxlOiOsEjiy7nVH599I8spcwFei+W3X1724teH4KW27IWvkuMwSR0dstCftZPILKqzxH261Yg1C24ng3Sztt+b2zkz7rwN6r91cnxioqbayPs5UG18H2wINsn9XltAgjzP/XHyTzF+Ikgd6+QcN6pN+FA3YAaOY7O8GmJdW2g9XdNjNGPzAW+jjNEInd5it1VPvZ68Rg0El7Q8gAWn0LZZoj5+IwPqIw4FzmPV9y8yOq8cEcyPhK4CwdGBS/N0E/gNgkYGUJ1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SHzM5mVf3QPVS4IiAc8Xl8NLxOtlfqi0nNwiUqRuJ8=;
 b=ZCXktzTf+9wn2EN80g19DbiDh1n85nc09D+hN9HNVoa1MHkDny3DIkOXUheYzjnXlXY/BLcVE7edv/9lWdOjxLv7a/cOZOv7q78q80XLaJ3xVVftfQW6K8ArBpf9zNPABFNdZBW6nMZHEbZ6LYilxsnwjGLdp/oyWo+LHtumkXo=
Received: from AS1PR08MB7539.eurprd08.prod.outlook.com (2603:10a6:20b:483::14)
 by DU0PR08MB8254.eurprd08.prod.outlook.com (2603:10a6:10:412::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 17:11:43 +0000
Received: from AS1PR08MB7539.eurprd08.prod.outlook.com
 ([fe80::79a0:141e:923b:2]) by AS1PR08MB7539.eurprd08.prod.outlook.com
 ([fe80::79a0:141e:923b:2%2]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 17:11:43 +0000
From: Deepak Surti <Deepak.Surti@arm.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: Ben Gainey <Ben.Gainey@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, Mark Barnett <Mark.Barnett@arm.com>,
	James Clark <James.Clark@arm.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"irogers@google.com" <irogers@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>
Subject: Re: [PATCH v1 1/4] perf: Allow periodic events to alternate between
 two sample periods
Thread-Topic: [PATCH v1 1/4] perf: Allow periodic events to alternate between
 two sample periods
Thread-Index: AQHbMS86SwDvYLR3c02/NoX5hQcGoLK26ecAgBFt7YA=
Date: Mon, 25 Nov 2024 17:11:43 +0000
Message-ID: <026914337fe69ed388e42a59e97d4a838bea6832.camel@arm.com>
References: <20241107160721.1401614-1-deepak.surti@arm.com>
	 <20241107160721.1401614-2-deepak.surti@arm.com>
	 <20241114150152.GC39245@noisy.programming.kicks-ass.net>
In-Reply-To: <20241114150152.GC39245@noisy.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS1PR08MB7539:EE_|DU0PR08MB8254:EE_|AMS0EPF000001B1:EE_|AM8PR08MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: db25c149-e9c8-4e6c-409c-08dd0d744278
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ay9Mb3dzTFU5SGllaXZUR0E0cFZXdEJoRTdpc24wcy8zOEtOZlhXTXdxYysz?=
 =?utf-8?B?bmpDcjZxeENMTXRCdi8rYUZqVjFlNWxjQ3VZdTNqMWlpSGx3NkNBVnZ0eFVK?=
 =?utf-8?B?N1pXTGUwQmRvOWEySEE1eTBTUUVTVDk3TnBXVEsrVllJa0lkdUhDc2hzcGh6?=
 =?utf-8?B?TmV5MXJTY2VmNUV1eks5eWk3cGtvdzcwVy90SUZzSDg3QmxHZ0RSVlNIdVJX?=
 =?utf-8?B?SENZMG1QaThqSTA1SFRzVGYydGZ3QWJvMnI2cVhMZ1J3TG40ZmlHUjZCdU4v?=
 =?utf-8?B?Z3N2LzVSTVZOeE9lSkxIVEdDZ04zbXNyTU1TZzVlcCsxZFJIQU1oZ3NxRCtY?=
 =?utf-8?B?aXVDWnpIdHo3WGZTTWhqV1pxS0tybThkN2hsM20vNkt1SGpzbGFlc3AxM1U5?=
 =?utf-8?B?VGtrRnNyL2k2alhKYUtIWHRhOVB4N1orY081S2QvM21GaWFtUFNhckd5YXNI?=
 =?utf-8?B?cXJ5S0I3WmYxRUx2ZVpEVGwreit6eElxNUJFTGIvclRzRUZPK0MzcVkwOFEz?=
 =?utf-8?B?YTFlbS83QjNXeXh1a05VODE5NUlWL04rTXpMdkQ2RGIyVmp0YmpKZGp1TndV?=
 =?utf-8?B?ZnYydGhXOWFDV1FrTjQ3M2JxWDZsZFZDRzZFRHBUZ0l3cW1EVUlkMGJTSlla?=
 =?utf-8?B?cytGQUNKM2VqZncrTWhJaGVEaTBkWFFXYVZFcWVGQWRpSG1JVjJKMm5KK1RW?=
 =?utf-8?B?NHo1dWM4cG9ESnVOYXg3ekRveHpsT1QxdzZsbTUrbldZbUc4RFg4cEdQOHo0?=
 =?utf-8?B?a3l6QTZTNHUvdWt0dkpUWmdNcTh2WXZSRWtnTjJmRmczamVBZDBxMHNBc0J2?=
 =?utf-8?B?MnRldUdtWGxrQlhpaHNIdEVpVzBXWjRkZndGVWxuS3hIeE1qak51Zll0ZnAx?=
 =?utf-8?B?bjRWMWNjRFJRUTBIUXFGRzZ3UGJ0N3c1bldVblB0M0ZwaW96Y0hMREFFT3lH?=
 =?utf-8?B?dHMyOWJIVFA4RG9mSFFZV1gxQWZjTTNUY3V3OVd6c0t2VDJIbkFsQnNTa1dt?=
 =?utf-8?B?SFFzSU4yeWxtbjE0Nk5MSTFwV0VxZFF1R2kydGlKTHZML3ZoNDJsWXFiUXVN?=
 =?utf-8?B?RUhSaVNpM2NjZmRPN3RLZm1tdWkycTMzdFJXTTljL3piTlBtR1JPVU9NRjFt?=
 =?utf-8?B?RmMxMStqSlpCMWZEbExTS3pyVm1KNEhYbTIzN0Yvc3BSQmhVMHo0SlBqUE1U?=
 =?utf-8?B?bTk4TkZCdGFpUXdGQTJhSUJja1h2VkxqL2VFeE1wYUVYWXVkTTlBYXpoVzQ2?=
 =?utf-8?B?Q29LRnYwVEpnOVNkbzA4NUxWNTQ3Q3FZRGpRUkY4TktYbEIzS2JHcDRxZlFs?=
 =?utf-8?B?VjhFdm9OZFZoWXowY0pnUE1PR3ZjcDFQWkM0RlJiRjlYa295NG9sN2xpT3RE?=
 =?utf-8?B?ZUVNT3V0a1d6RGF5NzIwWThaY2dacHJHNTk0VytrSHZTSjhtRHFvQ3VVS0pr?=
 =?utf-8?B?d0hyandBd05YRkxJR1ZSbmJEK29mdmZ2YlJEY3JMMGtSOE8vNFV3NkVoMjd6?=
 =?utf-8?B?T0R5RDNoVDYrQ3B5T2xhZG84bk0zQ3JCa0g5SDZXZDk4KytJMmlMQ1hteHNh?=
 =?utf-8?B?YjQrdG56TUE1RmNxY29wM1ZQbnByTzU1dlk3RCtubHhCc0pDdnB1OExlV2ZK?=
 =?utf-8?B?NVI1MlJLcHJnTTdDUVNLRzBuRWlMUmJWakVYVnBoVFMvM3ZybG5ka3dZRVFV?=
 =?utf-8?B?R0VjUWd3dFFmcGsvT0YxRXliL3BuS2p6bnZSbXpaYkpWMDZHZDhZdDRJdXRB?=
 =?utf-8?B?SGxvRzF4SkZ4Y3hZSmZvU3F5bEYzWjI5My9OSG9RelJNWSs3amRYRUJjZ0JL?=
 =?utf-8?B?WituSzJxWi9heEZ0c3ZQNmhaYS81anJaMFJJQUMxK1h5UkhnL09WRURFZzda?=
 =?utf-8?B?VGt3ZXpMajI2MDNROGNKQnF4bmlJTW9jejhKLy90UU1ibGc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR08MB7539.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <66A15A906C44D04DA1B628604FC925AB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8254
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:483::14];domain=AS1PR08MB7539.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	993a0d30-e5ff-4a25-6285-08dd0d743c5f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1VpTjAwNSt3ckRXTkdFWGNSYUF0bnBYYW5CS1MzcHdYVjBObzR1UElFS3dM?=
 =?utf-8?B?bWsvSCtacm1jdkREWXM5amdpSkNHc2htWFd3STQ1SlI1REdJREQ4K2NpVDVr?=
 =?utf-8?B?QmMxM3hHeDlFSHFobmtZcjhoV0FBTVVzQ01Ld2NWTXpoS21aYVZMeTJSekRZ?=
 =?utf-8?B?dXNqNGVpbFc2Tm96WVAzRExRd2UrcW9XZmlaeGlCdkdWY1kvaHpTY1VzdWNL?=
 =?utf-8?B?ajh4MVRNcFhheWpFckRDSmI1NjVLYklvQ1NjSkl4ZDkrQkRWb3JpQ04rNTRx?=
 =?utf-8?B?aTJjckR5VEUyWmlvakVLcDFBSGhybmtTWlc5YWFIZmtsaTFNdlN3WVlVcFRt?=
 =?utf-8?B?amJlR0Q3aHg1dUFxTm1Zc25vMVAyUjdXOGxvcmU5UzJLSzdrT2ZoVWZuRkEv?=
 =?utf-8?B?aGJqejZVSE9zekM0cVFSTWpkM2YwOUhCdmJwUlpDallMVmhGbmJHTzNKL215?=
 =?utf-8?B?dTRFSnZYdnNHTzBSSFBJOWppL3U4U1dIKzdDK1dMM3VTN29kZjNHeFhWaytw?=
 =?utf-8?B?Y1ZzWldDYTFmTWdpUDlGNnJEK0EwaDJTYzd5eWxKbXhSTWcvbDlUQ0w1SklI?=
 =?utf-8?B?WHdudTVrakUzN1NmU0RlNEZLcVVUTDgwSFRJVzhpSGVsS3NtSUprU0xoQ0tB?=
 =?utf-8?B?MUhLUHQwYUtTVi9EcmtLaUtNcElQQTFBc3ltRkFYOC9EUnJ3NmpqTWxuaFpR?=
 =?utf-8?B?OWFMZUltQTBqMlJjWmQ4S25HSE9aekt4YjZYNnA0b01ZMCtkVWg1RFNsZ0RU?=
 =?utf-8?B?OG9FdkR3QmZmUlZPclgrYk05WjlIdlYzdGpUR3JjaEhzMFNTaExCTWpXVGIw?=
 =?utf-8?B?MDIxVkFaWFFQbkxOdEFSU0NsMU5qTVorZ2JmNkJvYzV1aklTbE9aNlphZXA1?=
 =?utf-8?B?ZER1Z081eTZwOG5JVGFlSHdsYk5JU0hOd2xQSzg3UVNkMVFTYzh6MGF3aVNV?=
 =?utf-8?B?VGhUVDZPY1NROUZuWGhPQ2hLRGRHenlMYUptUkUyV0Jpam9rZVlsQTFQc3Y5?=
 =?utf-8?B?alRvYkRQeFFNa2VCS05nMmRjUi9tZDJGaEdCck01aXhFUnhXRGdEbFhzTDY0?=
 =?utf-8?B?RmJDNmR4RGY5WTFhV3liMVFiaEUxdmpvOGpZbzZFOEpLMnQ5UncvbytkWFNy?=
 =?utf-8?B?Rit3NndZS0ZyTVlqZm5PaTlsVVJQYWhCMmgyckgxbEhCbk5La1orS08rSm5R?=
 =?utf-8?B?WkhYNktHb3JVeElqNUVETDRZeTQ0Q1pnMXk0WnBJUkNJNGkrSUZqaUlvM0NO?=
 =?utf-8?B?bFF3QnV2QmVlMzZHK1JaQ0s3NUZ2M2VuMURwZVRJbHpFY01JcDE0MGpKSDhN?=
 =?utf-8?B?VEt6c1RyZ0R1dVd3NW9tZUZLMGVRSFBTQ3R4ZjJqeERRU2tVT1JkK0FEWHVK?=
 =?utf-8?B?RDlGcXhsQjdMV0NNRlpRak03Y2xyMTZpMWlQc0FxMUN6SU1ZV0w0cXVHZm5I?=
 =?utf-8?B?Um9BeExVNGhRTEFvVUpmUUt6b3ZZUnhWZGVxbXdMQUVCdVB1ZWRndDA4S2NV?=
 =?utf-8?B?RVpIeTNocW53WGZjcnM0UnExdUNGR2hEd2ZCNUVlVWx0SmQydytndHBQYXJH?=
 =?utf-8?B?cnI2a0w4Rk5aN2h4dUp0ZEdUSTh2NksweGF2Y3lNbS9vZVQ3UlZQS3dHTko5?=
 =?utf-8?B?YXNBY29mM0F3QzFjbDBmbUxnVmZTUmdLaHNwVnlKOVpWUXdLV004VXZpZSs0?=
 =?utf-8?B?UlM1Y2gyVlliK1M0aVVWa3REM3ZWVUJkeTVrSFpUd1JuTXArZlZVcmlUbmdv?=
 =?utf-8?B?YjRxeWFHY3Y0VHhvVnRRd0pEOVZ4TmVRUUFNbkVxRmpSVHNibEZpMUtPemN3?=
 =?utf-8?B?aUFncHMyQmVDOFlDeHl3bHkwK1ZpRE40anZHMkZPVUNTdVVUQWt6dkdPdG95?=
 =?utf-8?B?ZUR4TDZUL0ZsbUQrUHQzTDBWQmVnaHNtVk9TaTJFWEI5YjQrVlE1YU1aYnhh?=
 =?utf-8?Q?pRqCvk+5zDKbbMbuc7nlEfFouSh1fENp?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(376014)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:11:53.8085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db25c149-e9c8-4e6c-409c-08dd0d744278
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5633

T24gVGh1LCAyMDI0LTExLTE0IGF0IDE2OjAxICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBOb3YgMDcsIDIwMjQgYXQgMDQ6MDc6MThQTSArMDAwMCwgRGVlcGFrIFN1cnRp
IHdyb3RlOg0KPiA+IEZyb206IEJlbiBHYWluZXkgPGJlbi5nYWluZXlAYXJtLmNvbT4NCj4gPiAN
Cj4gPiBUaGlzIGNoYW5nZSBtb2RpZmllcyBwZXJmX2V2ZW50X2F0dHIgdG8gYWRkIGEgc2Vjb25k
LCBhbHRlcm5hdGl2ZQ0KPiA+IHNhbXBsZSBwZXJpb2QgZmllbGQsIGFuZCBtb2RpZmllcyB0aGUg
Y29yZSBwZXJmIG92ZXJmbG93IGhhbmRsaW5nDQo+ID4gc3VjaCB0aGF0IHdoZW4gc3BlY2lmaWVk
IGFuIGV2ZW50IHdpbGwgYWx0ZXJuYXRlIGJldHdlZW4gdHdvIHNhbXBsZQ0KPiA+IHBlcmlvZHMu
DQo+ID4gDQo+ID4gQ3VycmVudGx5LCBwZXJmIGRvZXMgbm90IHByb3ZpZGUgYcKgIG1lY2hhbmlz
bSBmb3IgZGVjb3VwbGluZyB0aGUNCj4gPiBwZXJpb2QNCj4gPiBvdmVyIHdoaWNoIGNvdW50ZXJz
IGFyZSBjb3VudGVkIGZyb20gdGhlIHBlcmlvZCBiZXR3ZWVuIHNhbXBsZXMuDQo+ID4gVGhpcyBp
cw0KPiA+IHByb2JsZW1hdGljIGZvciBidWlsZGluZyBhIHRvb2wgdG8gbWVhc3VyZSBwZXItZnVu
Y3Rpb24gbWV0cmljcw0KPiA+IGRlcml2ZWQNCj4gPiBmcm9tIGEgc2FtcGxlZCBjb3VudGVyIGdy
b3VwLiBJZGVhbGx5IHN1Y2ggYSB0b29sIHdhbnRzIGEgdmVyeQ0KPiA+IHNtYWxsDQo+ID4gc2Ft
cGxlIHdpbmRvdyBpbiBvcmRlciB0byBjb3JyZWN0bHkgYXR0cmlidXRlIHRoZSBtZXRyaWNzIHRv
IGENCj4gPiBnaXZlbg0KPiA+IGZ1bmN0aW9uLCBidXQgcHJlZmVycyBhIGxhcmdlciBzYW1wbGUg
cGVyaW9kIHRoYXQgcHJvdmlkZXMNCj4gPiByZXByZXNlbnRhdGl2ZQ0KPiA+IGNvdmVyYWdlIHdp
dGhvdXQgZXhjZXNzaXZlIHByb2JlIGVmZmVjdCwgdHJpZ2dlcmluZyB0aHJvdHRsaW5nLCBvcg0K
PiA+IGdlbmVyYXRpbmcgZXhjZXNzaXZlIGFtb3VudHMgb2YgZGF0YS4NCj4gPiANCj4gPiBCeSBh
bHRlcm5hdGluZyBiZXR3ZWVuIGEgbG9uZyBhbmQgc2hvcnQgc2FtcGxlX3BlcmlvZCBhbmQNCj4g
PiBzdWJzZXF1ZW50bHkNCj4gPiBkaXNjYXJkaW5nIHRoZSBsb25nIHNhbXBsZXMsIHRvb2xzIG1h
eSBkZWNvdXBsZSB0aGUgcGVyaW9kIGJldHdlZW4NCj4gPiBzYW1wbGVzIHRoYXQgdGhlIHRvb2wg
Y2FyZXMgYWJvdXQgZnJvbSB0aGUgd2luZG93IG9mIHRpbWUgb3Zlcg0KPiA+IHdoaWNoDQo+ID4g
aW50ZXJlc3RpbmcgY291bnRzIGFyZSBjb2xsZWN0ZWQuDQo+IA0KPiBEbyB5b3UgaGF2ZSBhIGxp
bmsgdG8gYSBwYXBlciBvciBzb21ldGhpbmcgdGhhdCBleHBsYWlucyB0aGlzIG1ldGhvZD8NCg0K
QmVuIGhhZCBvcmlnaW5hbGx5IGF1dGhvcmVkIHRoaXMgYXMgYW4gaW50ZXJuYWwgZG9jIGJ1dCBJ
IGNhbiBsb29rIGF0DQpwdWJsaXNoaW5nIGV4dGVybmFsbHkuIElzIHRoZXJlIGFueXRoaW5nIGlu
IHBhcnRpY3VsYXIgYWJvdXQgdGhpcw0KbWV0aG9kIHRoYXQgeW91IGFyZSBpbnRlcmVzdGVkIGlu
Pw0KDQo+IA0KPiANCj4gPiArCS8qDQo+ID4gKwkgKiBJbmRpY2F0ZXMgdGhhdCB0aGUgYWx0ZXJu
YXRpdmVfc2FtcGxlX3BlcmlvZCBpcyB1c2VkDQo+ID4gKwkgKi8NCj4gPiArCWJvb2wJCQkJdXNp
bmdfYWx0ZXJuYXRpdmVfc2FtcGxlX3ANCj4gPiBlcmlvZDsNCj4gDQo+IEkgdHlwaWNhbGx5IHBy
ZWZlciB2YXJpYWJsZXMgbmFtZXMgdGhhdCBhcmUgc2hvcnRlci4NCg0KQWNrbm93bGVkZ2VkLiBX
aWxsIGRvIGl0IGluIHZlcnNpb24gMiBvZiB0aGUgcGF0Y2guDQoNCj4gDQo+IA0KPiA+IEBAIC05
ODIyLDYgKzk4MjUsMjYgQEAgc3RhdGljIGludCBfX3BlcmZfZXZlbnRfb3ZlcmZsb3coc3RydWN0
DQo+ID4gcGVyZl9ldmVudCAqZXZlbnQsDQo+ID4gwqAJwqDCoMKgICFicGZfb3ZlcmZsb3dfaGFu
ZGxlcihldmVudCwgZGF0YSwgcmVncykpDQo+ID4gwqAJCXJldHVybiByZXQ7DQo+ID4gwqANCj4g
PiArCS8qDQo+ID4gKwkgKiBTd2FwIHRoZSBzYW1wbGUgcGVyaW9kIHRvIHRoZSBhbHRlcm5hdGl2
ZSBwZXJpb2QNCj4gPiArCSAqLw0KPiA+ICsJaWYgKGV2ZW50LT5hdHRyLmFsdGVybmF0aXZlX3Nh
bXBsZV9wZXJpb2QpIHsNCj4gPiArCQlib29sIHVzaW5nX2FsdCA9IGh3Yy0NCj4gPiA+dXNpbmdf
YWx0ZXJuYXRpdmVfc2FtcGxlX3BlcmlvZDsNCj4gPiArCQl1NjQgc2FtcGxlX3BlcmlvZCA9ICh1
c2luZ19hbHQgPyBldmVudC0NCj4gPiA+YXR0ci5zYW1wbGVfcGVyaW9kDQo+ID4gKwkJCQkJwqDC
oMKgwqDCoMKgIDogZXZlbnQtDQo+ID4gPmF0dHIuYWx0ZXJuYXRpdmVfc2FtcGxlX3BlcmlvZCk7
DQo+ID4gKw0KPiA+ICsJCWh3Yy0+c2FtcGxlX3BlcmlvZCA9IHNhbXBsZV9wZXJpb2Q7DQo+ID4g
KwkJaHdjLT51c2luZ19hbHRlcm5hdGl2ZV9zYW1wbGVfcGVyaW9kID0gIXVzaW5nX2FsdDsNCj4g
PiArDQo+ID4gKwkJaWYgKGxvY2FsNjRfcmVhZCgmaHdjLT5wZXJpb2RfbGVmdCkgPiAwKSB7DQo+
ID4gKwkJCWV2ZW50LT5wbXUtPnN0b3AoZXZlbnQsIFBFUkZfRUZfVVBEQVRFKTsNCj4gPiArDQo+
ID4gKwkJCWxvY2FsNjRfc2V0KCZod2MtPnBlcmlvZF9sZWZ0LCAwKTsNCj4gPiArDQo+ID4gKwkJ
CWV2ZW50LT5wbXUtPnN0YXJ0KGV2ZW50LCBQRVJGX0VGX1JFTE9BRCk7DQo+ID4gKwkJfQ0KPiAN
Cj4gVGhpcyBpcyBxdWl0ZSB0ZXJyaWJsZSA6LSgNCj4gDQo+IEdldHRpbmcgaGVyZSBtZWFucyB3
ZSBqdXN0IHdlbnQgdGhyb3VnaCB0aGUgZWZmb3J0IG9mIHByb2dyYW1taW5nIHRoZQ0KPiBwZXJp
b2QgYW5kIHlvdSdsbCBwcmV0dHkgbXVjaCBhbHdheXMgaGl0IHRoYXQgJ3BlcmlvZF9sZWZ0ID4g
MCcgY2FzZS4NCj4gDQo+IFdoeSBkbyB3ZSBuZWVkIHRoaXMgY2FzZSBhdCBhbGw/IElmIHlvdSBk
b24ndCBkbyB0aGlzLCB0aGVuIHRoZSBuZXh0DQo+IG92ZXJmbG93IHdpbGwgcGljayB0aGUgcGVy
aW9kIHlvdSBqdXN0IHdyb3RlIHRvIGh3Yy0+c2FtcGxlX3BlcmlvZA0KPiAoYWx0aG91Z2ggeW91
IG1pZ2h0IHdhbnQgdG8gYXVkaXQgYWxsIGFyY2ggaW1wbGVtZW50YXRpb25zKS4NCj4gDQo+IExv
b2tpbmcgYXQgaXQgYWdhaW4sIHRoYXQgdHJ1bmNhdGlvbiB0byAwIGlzIGp1c3QgcGxhaW4gd3Jv
bmcgLS0NCj4gYWx3YXlzLg0KPiBXaHkgYXJlIHlvdSBkb2luZyB0aGlzPw0KDQpUaGlzIHdhcyBk
dWUgdG8gQmVuJ3MgbGFjayBvZiBmYW1pbGlhcml0eSB3aXRoIHRoZSBjb2RlYmFzZSB3aGVuIHRo
aXMNCndhcyBvcmlnaW5hbGx5IHdyaXR0ZW47IHRoaXMgcmVwbGljYXRlcyB3aGF0IHRoZSBJT0NU
TCBoYW5kbGVyIGRvZXMgdG8NCmNoYW5nZSB0aGUgc2FtcGxlIHBlcmlvZC4NCg0KQnV0IHlvdSBh
cmUgcmlnaHQgdGhpcyBpcyBpbmVmZmljaWVudDsgd2UndmUgdGVzdGVkIHdpdGggdGhpcyByZW1v
dmVkDQphbmQgZm9yIFNXIGV2ZW50cyBhbmQgYXJtIHBtdSBldmVudHMgaXQgYXBwZWFycyB0byBi
ZSBmaW5lLg0KDQpBIHF1aWNrIHJldmlldyBvZiB0aGUgb3RoZXIgYXJjaGl0ZWN0dXJlIG92ZXJm
bG93IGhhbmRsZXJzIHRlbmQgdG8gYWxsDQpmb2xsb3cgdGhlIHNhbWUgcGF0dGVybiBzbyBpdCdz
IHByb2JhYmx5IHNhZmUsIGJ1dCB3ZSB3aWxsIGRvIHNvbWUgbW9yZQ0KdmFsaWRhdGlvbiBvbiB0
aGF0IGJlZm9yZSB2ZXJzaW9uIDIgb2YgdGhlIHBhdGNoLg0KDQpUaGFua3MsDQpEZWVwYWsNCj4g
DQo+IA0KPiANCg0K
