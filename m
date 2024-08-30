Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016514B96F
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002482; cv=fail; b=CcsYtenQBb7qk/WKqCXwUK20r/wPtBwje7hkWVurY8IVI0nNvdlW8oNMahuar4RdzvJuRhG7yr2YSTtHM1CzYvF/1dgJC1Uh63UMx6G+WKpp+dlkIUSL+MpeKia8PEvYON6xsHenx4phOGbOP/28Z9fRngFHKliGkE2VwfB22zE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002482; c=relaxed/simple;
	bh=u2z4Lx1UpYYwyPq1WqoqbBrBUDQq0sQ83YEOcnow1ns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LV0kcDMEl1MxYT8siCGaZFroe9LOO4MIQZHZGiocuh3KMvXB8E9cUFuOwpBi0lXlmwGmqIHLVZmQ1ETm9o9I8zqfrbWtUZEDy2UIxfOkEQuAl3kJZZMT26WqYxbk+c755GFyVWk0xJp8sGEUoldZ5Pvz+fsiuWCUZUcrIIJ/PN4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UahXS9xw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UahXS9xw; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UahXS9xw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UahXS9xw"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HaaZYkJMpEs/+eWmGmpb0pnYFxQ0PUxklck9b5mt03WpBwtWdXsjWtBCzEyoMKZ2tuAeAWY5nfneND4nUaWSaaiSw5e8urU9YeZ/5eD5f6LLl7qvjeLtzycOMJvHWBEcAthZSvGE//JCN6HjRCc/Aq++x3/WVFD+BGQkQSxkH4Dp4EpttQJmP9r0Z3dcspr72tHctzVbJ//COmprS8KH/9MfSpeZ30gEiIPBXfJt7BgiUXU7CE/Rf7cpuqoWCPtDLvnviRBuIhoq8BVNUbng/hQS06B6ffReYEE9oq2jBlEyZISH790SPgz7MHAjr8K8+f/3GzolTLHAOvi8KbHa5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETmuAvrVw0fJhjliZfsZX4ITWNaYnLTBDYT76KcF/+g=;
 b=ZlU5U7ekGjQZHk8CFQL2CJQ+pjuLRYoq3Boa56Bx2/x8/e8cGv5DUCpfbwDRPrXRwjIuAsTZr0OGg5/mfUwvFbt/iAvq3Iu3sm72KSMefEcwU3Ss2TwkrYUA4wrVVzyIyA8id/pBq/5vxBV88cV0PEzNwxz3J9a1Ercu85B+UwdGftOOXJ34kumg+mgH7fZsxBy2Yypj6k3oWViiE0rXEHVarsSlFspC9pV7plPqcWhd3A3ozGz2U4/Zf73f5WdCRqrbsycErR22DZP1G8v7u7iPQNy9ivHq78BxFfSBN4EbbQS2j1sIC53dTwoHmeGHurIixp+7sR5HkbyqF1TheA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETmuAvrVw0fJhjliZfsZX4ITWNaYnLTBDYT76KcF/+g=;
 b=UahXS9xwBtSYskVlnubJJypo/pR50mDbDOWDbh1K0WavyzCPCRp+TOCorF3+jEnXm+TPTHd79K1nC6wq4xyYDnQhQkgRwmotefxpDIdG1EUm4q19bVUQbtULaI/3D2tu8US6vE7/gzewTs6YoQsRUbh+6Ne8np7xRApoHYKbuwM=
Received: from AS8PR07CA0023.eurprd07.prod.outlook.com (2603:10a6:20b:451::23)
 by GVXPR08MB10666.eurprd08.prod.outlook.com (2603:10a6:150:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 07:21:11 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:20b:451:cafe::e2) by AS8PR07CA0023.outlook.office365.com
 (2603:10a6:20b:451::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Fri, 30 Aug 2024 07:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Fri, 30 Aug 2024 07:21:11 +0000
Received: ("Tessian outbound 901f45c3f9e8:v403"); Fri, 30 Aug 2024 07:21:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 17b4e3344829989c
X-CR-MTA-TID: 64aa7808
Received: from Lb4a4e5197208.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D45085D2-0E4D-4C4F-9AE5-8813BAA1107B.1;
	Fri, 30 Aug 2024 07:21:00 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb4a4e5197208.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 30 Aug 2024 07:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuZwwHRC2Ok0loLJOGEqdsV44v9Y50kTWzYKGOuovuIQHDAvrtcobkaw24/hFqgHS+LeeHbQgyCMdsLGnLy09CO7lx9mVQWS30mENEd+EjZ/B/sDx5Hxw04KsZzimLucokVoOzBhOND1KDlW9eqRNwLwGyWIlCdbIihRAFR+a7TEoO34402ov6xoXBCuNj0quTJheWpM/L/1HyYfgvZFyZCdf/04O85oP6tNyfQu3JHq5n621x7n28P9ed2CDor10DuATu1SKW4WRKwNHM4f6LMqesrRG1f2hsDTtbO3XgQNHmw3Mjj+HrhZhe1T2zo0cDFaYN2PAqbzeYyDhWafXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETmuAvrVw0fJhjliZfsZX4ITWNaYnLTBDYT76KcF/+g=;
 b=ktoh2XN6deM3gaA71nxggItUMZMGDuhhXOw3ZicuzosVHXIn+gFkoPjwyx0L7qtiHJ7uF2XBosB8yhPwg2SrdlMaWaeOF/JOLS2qGuySpjKJ/taLvYKm59C6z/43SFirsPLtkB5Rt/VqyAWW6huzuKx6fcKgnJ4OpI5Po69sb00OXPEI+l7OqExYWBfasJSSW0Hx6mE6i3tT3malktboZFfSnPxcMsay+dGfD/EKEZNFTrl8mqy2BqhhMbbiDTX6ctMgXoD2YcXFG+y9g0FCr3/pKNPqB+Vo62NDBt5aRHW5jpWeQkxr7ZLm9b9CSur5tQUUNCT/lOiBU5Fdsd0zTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETmuAvrVw0fJhjliZfsZX4ITWNaYnLTBDYT76KcF/+g=;
 b=UahXS9xwBtSYskVlnubJJypo/pR50mDbDOWDbh1K0WavyzCPCRp+TOCorF3+jEnXm+TPTHd79K1nC6wq4xyYDnQhQkgRwmotefxpDIdG1EUm4q19bVUQbtULaI/3D2tu8US6vE7/gzewTs6YoQsRUbh+6Ne8np7xRApoHYKbuwM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com (2603:10a6:102:150::13)
 by GVXPR08MB7799.eurprd08.prod.outlook.com (2603:10a6:150:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Fri, 30 Aug
 2024 07:20:53 +0000
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad]) by PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad%6]) with mapi id 15.20.7918.018; Fri, 30 Aug 2024
 07:20:53 +0000
Message-ID: <9822c444-69d6-436d-b1dd-6d9c910678ee@arm.com>
Date: Fri, 30 Aug 2024 08:20:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 scclevenger@os.amperecomputing.com, james.clark@linaro.org,
 mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
 <cover.1724879699.git.scclevenger@os.amperecomputing.com>
 <35c19a0f-580a-4d97-b0d4-b8708a4dbdb4@arm.com>
 <01419593-056b-41e9-a3d2-6ac490f7734a@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <01419593-056b-41e9-a3d2-6ac490f7734a@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0313.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::12) To PAXPR08MB6591.eurprd08.prod.outlook.com
 (2603:10a6:102:150::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR08MB6591:EE_|GVXPR08MB7799:EE_|AM2PEPF0001C709:EE_|GVXPR08MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d7888f-0f3e-4483-3ed7-08dcc8c45307
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U21lc1IzUXU3MS9meURia0xyRTNDR1BvWGpDd0VqSXpLTnNYOGVJeGhNOEFI?=
 =?utf-8?B?LytuM3lZVW82T21rdmVaUFIvYzE1QU5sU2xWaUJVMEF5ZGMvbjJkc0cwTUNq?=
 =?utf-8?B?bi9kK1FFM3lnN3F1QldVK0xmdWdmOUlqZnlWMDUvcUFOclhKaUJITXdiekJw?=
 =?utf-8?B?dlpTNERuejM3a283bUt4V1R3Q3lXUTUwMUJ3MUpIekMzcWNuN0h6bFh2bi9I?=
 =?utf-8?B?WjZQNC9pNUt6NG1DbGpQMHJUd25NbC9qc2lNajRUQ0tZOUNxOS9hK1docjl6?=
 =?utf-8?B?emY0NS9pd21vWDJPWTNWV1pGeHlUUnFPWGNFRTFRYXpYMUJHWFR4K04xdkc0?=
 =?utf-8?B?Y202cnVaejVwWHlLZ0tPb05maTI5NVV4T0ZMNmhVbEdTMk9iM3R6M25QVjZC?=
 =?utf-8?B?bzNwVUh2SGdxNEZaalFMOVYxNjhCSVVUczdYcFg0Zk5lWlp0aG43UXV6VDVp?=
 =?utf-8?B?MHhVdjBWRjdGd2ZHcjlIR2VIZTdqb0ZOeGVyaGFsSVdMNGFWUitnMmNHZ1Fa?=
 =?utf-8?B?ZU8wTXYzTVhtL01RV0ZuR2YzVUxsTnRRZzlVWkZCNDVxd0xsb1o2V21YSUZn?=
 =?utf-8?B?KzhCQnNUaDFQWit6MFFuUjlqVUhFMUh3Y0Jxd0pBNE8vUnphMEl3K0xwdWsv?=
 =?utf-8?B?R3lIWUMyQllUbUxNOUkyNHBZdjJNNXFPL2ZlbUN5TFRrN2ZLSmZKYnRCT0N2?=
 =?utf-8?B?Wnk2NHozSFNPRUl0bGc1MUZMTFFhbFBXMUJnS2puQlhOK09TdmhGa21TTGF1?=
 =?utf-8?B?U3pJdjZZODR1WTVqUUd1Y2ZBcHgvTW4yd2doMlY5YzRUTDlrTktRZFdYUTh6?=
 =?utf-8?B?QzNBZWlHajlyVVBVNUE0TmZkOUR4aSs5eVk3UDU2WFZXRVBiWFRQanJYREwv?=
 =?utf-8?B?cmIxUWx6T3RSMks5aTVkVmRRWE9weTRuaUdDTjlQeFJiQzA2SkRtdDY4S3F3?=
 =?utf-8?B?cEx2K3Bjczc3a0tWTGlVZUEwUUZ4RmFhNlRrOEoraW9mRXU0K3FBcXZRTXlV?=
 =?utf-8?B?ZGxWZU84b2dTSkZqWUlNTW1CRU1WZXlaRzFtOEMySVBVWlk4L0pvUG1HajBU?=
 =?utf-8?B?bFVTMmlYaXRtMHBnb21ZWnlIWTNlczZNdGxSSDBRdHUxN1g5ckpaVWtiblI4?=
 =?utf-8?B?ZmNQTlJFeUdGSnhOdXFlSjNleWZwZXppRW10Ri9VNktRZnBUVEltTnZ1eW01?=
 =?utf-8?B?K1Q4RlVYNVRvU1pnNmcwT0svM3UyQzNDY0lZa0ZXV1p4TTNtaWZRMS9LOElu?=
 =?utf-8?B?VE01b09SZUF0R0tTeXJNVWs1RGM0Q2ZXbGd2VHBtVG9TbTNOWFp4cWJsYUtP?=
 =?utf-8?B?RitHellLZkJ1R2p6YzJwaFUzZEVPRk1KSFovYzNDNlBYYm1HV2dhMFY0MlVi?=
 =?utf-8?B?MFZvUVpKMkVUT0tCbzV5VU1OczZheTNjSWVLWjh6ZW95YTFvSkNSYm5pUXU5?=
 =?utf-8?B?Y1JFeUtVMklMdDVCcWFjc1kxSnNsQzF2Ui9XNWdlNEVPbVI3VGQvZVJ5SHlL?=
 =?utf-8?B?NmNTeFo5NXcydmRsNTN6K3dETm0yRndPQkthVzg0YUgvQjBmdUpwRllZOGlO?=
 =?utf-8?B?dVdpY1N6Z1VESXhKbDJLQkJCSlZVYjBpU3FPQWdvR0xpeEJUUktkaWk3ZDN0?=
 =?utf-8?B?K0UvV0R3MElqRjFseVh3YlFWMmhjeEhUWVg5SmpsbmsvZjQ5ZUhvdllnQVhH?=
 =?utf-8?B?YWFabW5NbFVHb0JYeXRpL2NVc1BOT0VZejg5TlBmRm0ybzFZOEJmM28vMUF0?=
 =?utf-8?Q?A9EiaoU1KTdrpzSNbk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6591.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7799
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:150::13];domain=PAXPR08MB6591.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b807344a-e43c-454d-503a-08dcc8c44852
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWdOYnFvUXpWMVVBcjV4QnFLdHJtN0l6MFBFSWd2ZXJIRHdpK0NvSitPUit6?=
 =?utf-8?B?akxDaWF3YmFxaUVtQWlBTzFFZ3JVeExuMVBkanY0US9sd3lIMkc1Z2tJeXJz?=
 =?utf-8?B?WGxZWWJuaWY0Y3R5aDNweTZHVEZtSzg4OTRXQ0ZEeFVOUnNlYUlob2haWktN?=
 =?utf-8?B?TWpsQUphT0xTSUJrQ3U5RUIxKzlwVlNkMGJaUnZTYVRjUWVMdWhQTGwzeVU3?=
 =?utf-8?B?K1F4UGZ2ZjNiemE3YUY0dkM5anRCSGxqMElLM3kzWXJNNk1aYVJYTDFLeUJ4?=
 =?utf-8?B?TkNyUCtjWmJWb3RyNUdlbTUwZ0U3dmJwMUJVSlJxcDZKUU10TjdjZUU3aTFi?=
 =?utf-8?B?d1V2eE1OTVZKQVAxRVJ4ZFd6bHJSUEtWYnlWN0UvZnZYLzkrMis0SExaWE80?=
 =?utf-8?B?UXdMODFjcXlVblNGaFdQZnBLejlSbEFkZlg4ZmFmNlJaYWxwd3NzVkRXSDhW?=
 =?utf-8?B?U3pSOUdTcTZFTUtNaDZ6K0JTdEorZlE2YVhoRlpucnc4a3pWZ0tUVjY0ZFBy?=
 =?utf-8?B?aUN5V2ZqcnlUc0FUelJBbFZmbDU5MkVBVk9xY1VrNzJ4VWZELzVHWjU5elk4?=
 =?utf-8?B?U3pLd0RtYm1pdzZRNzViSG5MbUtacVliUWhjUGJRUE9nQWVwTUxJRDlwNkk3?=
 =?utf-8?B?Z2xpenMrbE9YSVNRZk5VM3d0cFRlMzNSNVpLOW82M29zaXFMait4N3RQK2U1?=
 =?utf-8?B?R3diV0xOdlVqR2NPbHh2WGJzZ3N1a1pIY2c3RXVHeXpNdFZndC82NTZOajVn?=
 =?utf-8?B?Q1N4YlBvc29iTzVnaFhOdGJ5NXU0ZWRVU1Bud29nL2llY0ZzZ2FOWmFTbU9h?=
 =?utf-8?B?ZWJsek90Qlc1Y29TaVRUTE9LMCtKTWZSOUZGWGY4UDE0UXJMa0hIcWhpTmJo?=
 =?utf-8?B?a1FKZzFneXA2bThZcEdRZVB4bktBMFVOcGEyT0lUQ0N3dHBVV2grYlRlS0Ru?=
 =?utf-8?B?WGVJUndnSnRpSjArNlFGYUplMXJ1ckZQYkRrSnV6a1lteVNmNUtwRFhlSEM0?=
 =?utf-8?B?QWNnMkNKbStwQXZ4RU04c2EvL2JvWGdURWdlVW9jMmhONGVNSWFlejZ5dU5t?=
 =?utf-8?B?OUEyL0laRGViTWV2VXhlYVJraTJYRjhWMWRVYTYzTFZIemtrVkFrLzk2blB5?=
 =?utf-8?B?V2NHd0lucmV4T0ZVZ0c3cHF1SnF6ZzI3S05hc3kyWll2QVQ1RlJ1WUptNHo3?=
 =?utf-8?B?MUFYNnZCVXh5VmdrZGlHSUxMQ1ltNTZCUWY2K2ZlVEtPMExDMEl3SDc3V21n?=
 =?utf-8?B?djlPZTUvdDRYU2RIQ1RmMnVNcnVPR2FOZTFRTnVwMDRYSDcvTFFkZ09qRmsv?=
 =?utf-8?B?cVppUXBZdmMwb3B3WTQzTndqV3BKR1lTRGZERkFYOXYxaUFaRVFyVzJXek5X?=
 =?utf-8?B?WFpiV05pbzFIYXlySjJqeWN1eUx4dHFaalZuZDY5aUE1dWY4WTdxY2NrMlFF?=
 =?utf-8?B?bGR0QW12MzRGbjhEVXFWMk5HTWthZnJoaWw1QW5WWmI3djJtNEl0cHRoK2lw?=
 =?utf-8?B?WlNBcitWNncyN20yQWlUZ2YzYU1zV2lNbWVMYkxEMy9sYi94ci9YYXFudTZE?=
 =?utf-8?B?VnR5K1RCOUxycXpoclMydXZFbDdNSzBOTkdWNTlQZ3hXWHNaUlh3R1Q3T3pC?=
 =?utf-8?B?YzNRM096TmRVM0c5U2V3N0l3QmIvbTJ3R3JCS0QrOWI3eDRqZi9DYjB5MXpV?=
 =?utf-8?B?LzlYVWlGL0lNVm05U0tOcVVxYjNyejFJTmhFVTBmaWpTODc4UDIrUlVxN3Ny?=
 =?utf-8?B?aDF0aG9uTWpJQ3AzelpqV3JWMllrcGZEVU1JeElaaDJITDFjTlE5bG5rWllP?=
 =?utf-8?B?UytTTCtndWpHbGl3Uk5nVUFlNCtjdGl0OVF1ZGNxNHRacDNLM3ZCOGxOSDd5?=
 =?utf-8?B?MmZUaS81WFRHc2JvN2hpbGdMUm5lUTI5UlpXVWlmcXBpWVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:21:11.1428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d7888f-0f3e-4483-3ed7-08dcc8c45307
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10666

On 8/29/24 18:39, Steve Clevenger wrote:> 
> On 8/29/2024 12:55 AM, Leo Yan wrote:
>> On 8/29/2024 12:17 AM, Steve Clevenger wrote:
>>>
>>> Changes in V5:
>>>    - In symbol-elf.c, branch to exit_close label if open file.
>>>    - In trace_event_python.c, correct indentation. set_sym_in_dict
>>>      call parameter "map_pgoff" renamed as "addr_map_pgoff" to
>>>      match local naming.
>>
>> For the series:
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>>
>> Hi Steve,
>>
>> Later when you respin a new version patches, it is better to amend the review
>> and ACK tags you have received. (Just remind, b4 is your friend for helping do
>> these things).
>>
>> Thanks,
>> Leo
> 
> Got it. Thanks, Leo. By the way, I noticed when I rebased to
> perf-tools-next the kernel version was 6.11-rc3. Is there any chance
> this patch gets into 6.11?

Linus' master branch now is 6.11-rc5, it is not far away from the 6.11.

I think we still have much chance to get it done before it. Added maintainers
in case any missing.

Thanks,
Leo
