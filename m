Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20338193099;
	Fri,  7 Jun 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769109; cv=fail; b=tRUJ9AKhTe7FaO5KZemJ3yw3JEwG55hU7NNDtTI2RjlHEmzkCe6TAXI91AU2+Pja/Q3RTdamYsiIbfO79TGqVRbWfisq+tYj5EDoOBGZ1TQJtc+OBVRM3uZYoOa/BtM3WrER0TzKOydnlBh7s52ztP1ga4cJ7IUBz7JiqRR6ID4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769109; c=relaxed/simple;
	bh=ttoPa/owNOf7DJuREZ/8Rs8bKwpo+dTTfHRsIY3b0GY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lBIPx+Mtb+JwqDZDZEe2z6EyNflaBpw86ZXY4FuzZpc9S3unZTBgiiU1MwP42/7bPqG47JV9rURTP9MW21tDeREg1KppP0Ffasl7aiSS63zTwE9HuiE/7JmrLifo3MiwplpUn3KFTJDn1rnSRmwIa7zcUzdFxdNnkxzn0zYNgcU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oc3wfim6; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oc3wfim6; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oc3wfim6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oc3wfim6"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=WKi6xsXVtXNK2qRL883kc/Nk+QLXx2GUPRRcSBMVYHJIW7fNSpc/6qSy3y4cPcbKUxii9uUddDXrFgIuCRu7fvEDut3cWqhv2Q9eLnBiJG0nvVkrOAQE1/rlSS3jqF4iT8wOe/BRURv8696DWFEbeihB9aP6NDTdHtilBv9yCC/9hXNzQHKbTwI8gW9LI5DwVh5n5am8nAg+z9fLfiZDoOjz2E4EDqU6Zlp83L8U45t7Fcbvqh6esuj6javQ7kFU3rt/274ZM3g46cSZar61JPlB+mOqf6bHYVgLZsYdyjdLH/rO2rq25cRasi+6ma0vjsY7eskanhQozE2GQeLO/A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttoPa/owNOf7DJuREZ/8Rs8bKwpo+dTTfHRsIY3b0GY=;
 b=G6r2u0oXpVbO0jw3P76zghmY2/4AdJpuGCkaDGh/IWjuU+TFh0/NqGGpmUApioxeH7qmHXhLERcXme+lNLsociq2vljfoS8dQnqI4kpU5lGY7tOWLM6q60LDzQBwppkcnJ6h0f79bvcrEt0w9CeUyA6mWJpX+catJF4Qwhl31AEc5Z/WqHI2K28yZN7NLEWEPszXNVpEtMJSyPXmralSEN9zTG/ms4rNrqMWG6PX0ISIrBH1U0S0GuIwUi91tEgb/d78tGyrYya4G92lpbjnudrgtDTvCPAdudi2auJzt5WczPoz0xTz+Uf0rLUaIiz0SWvZUNCr7rny8qInwP6U7w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttoPa/owNOf7DJuREZ/8Rs8bKwpo+dTTfHRsIY3b0GY=;
 b=oc3wfim6Pv/do7HJ9xEu3nwA0wWWybdyqsJP+ghGescUrlPu8hCktTeQNaK7JL2kuDH7fRcxSwTT18k/zfb88TLtkZtDMZB2S5+GV4yIL5VH+SS8/GL3LTjRf5JY7D4x//71YzQtSrBnZO13NFLL86OkoHBKovUVuAceex75s80=
Received: from DBBPR09CA0021.eurprd09.prod.outlook.com (2603:10a6:10:c0::33)
 by DU0PR08MB8786.eurprd08.prod.outlook.com (2603:10a6:10:473::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 14:04:59 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:c0:cafe::b6) by DBBPR09CA0021.outlook.office365.com
 (2603:10a6:10:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 14:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15 via
 Frontend Transport; Fri, 7 Jun 2024 14:04:59 +0000
Received: ("Tessian outbound 20dfd856a3c2:v330"); Fri, 07 Jun 2024 14:04:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fee4ba8c59073527
X-CR-MTA-TID: 64aa7808
Received: from ecb63cd9427d.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 912B9EEB-A32B-4B19-9E90-519D5C1AABB1.1;
	Fri, 07 Jun 2024 14:04:52 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ecb63cd9427d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 07 Jun 2024 14:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLXYIrGu/0Kp87HDPzFFR77FGbAFs/3ERwEVO/+1DUZLfVw0EFhXrV5xUr23pdt+/ORCawaIb5XUzUJE7bFIe6XSo2ktCWAcHX2lW1DCyJCSq/8mdpb3MmspuON+l5eDm66AXkwuUkRlCTlOlD9ovb7KCOVg+S4P5+m+SEfw9xZ1LJD3UD7apOqkBs+F429apnfSwIql3p7we0bmdY/sCzxFPYoLl2L2dONFZ4t7HdglRtjMjlYd9M+fWY9TOwVZOcIKLdDiRi38zUXNsZ5++2y2ve9nhSYXlv8ifi7PBJpO6mxq+65u06/SPk9Bmun7EnvdXLPiIProGHYlrUEbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttoPa/owNOf7DJuREZ/8Rs8bKwpo+dTTfHRsIY3b0GY=;
 b=E3uEMElhnVwL1n1UBWsgH/VdAiYs0JS9nLlg+FVLqyt+sT/SuCu8VetYrxSrL/Hyx1RznYSD2X6c6QMbAeC3GPWk6/NQ9gwt9BJE43ULXNNYj7U/otoMaVisXjAVee1XpqDC8j3W2JQazup26/eg6qYK7AI5TkecRHfYtBrXMrtJgbbT52p3wg5RTV9JCnwMFsph7Rva0XSqw07dW2Dy6kzGHuSoKGeLOhnV441EHw6CC3FZ02fGFfYqZICpePy1dvO6lJYkmlUKwK6g4EvOImrTanBbWiE+nV7iowNyM7dZOT/xfYH/0mJz4AFnqQEUCUwQbIAkyOc8fXgvenDoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttoPa/owNOf7DJuREZ/8Rs8bKwpo+dTTfHRsIY3b0GY=;
 b=oc3wfim6Pv/do7HJ9xEu3nwA0wWWybdyqsJP+ghGescUrlPu8hCktTeQNaK7JL2kuDH7fRcxSwTT18k/zfb88TLtkZtDMZB2S5+GV4yIL5VH+SS8/GL3LTjRf5JY7D4x//71YzQtSrBnZO13NFLL86OkoHBKovUVuAceex75s80=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by PA6PR08MB10740.eurprd08.prod.outlook.com (2603:10a6:102:3d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 14:04:50 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:04:50 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Mark
 Rutland <Mark.Rutland@arm.com>, "acme@kernel.org" <acme@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, James Clark <James.Clark@arm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/4] perf: Support PERF_SAMPLE_READ with inherit
Thread-Topic: [PATCH v7 1/4] perf: Support PERF_SAMPLE_READ with inherit
Thread-Index: AQHauB+aYPUvOE0NMky2m9mad2CDerG8CxkAgAAMHYCAAAzZAIAAMwOA
Date: Fri, 7 Jun 2024 14:04:49 +0000
Message-ID: <60ed550e8cb5e5aa4004fb2d3857a605ba1da23e.camel@arm.com>
References: <20240606144059.365633-1-ben.gainey@arm.com>
	 <20240606144059.365633-2-ben.gainey@arm.com>
	 <20240607093254.GN8774@noisy.programming.kicks-ass.net>
	 <451afb8eb03f1519c482a84a6c1cbd1e62222988.camel@arm.com>
	 <20240607110214.GQ8774@noisy.programming.kicks-ass.net>
In-Reply-To: <20240607110214.GQ8774@noisy.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|PA6PR08MB10740:EE_|DU6PEPF0000A7E4:EE_|DU0PR08MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df47b6f-f289-4eb4-f3b5-08dc86fad171
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?L3kwYTdMSzUySVRSRVhKc24zMmNxWkZnaVhIS0dzQVhGekZ4R0ErMTd1THh1?=
 =?utf-8?B?NXIyWVgxOHFMdUlrYkkyYXF1M3BpQzE1dmQvOWxtTjRVVG9NdUdpZkJDK0wz?=
 =?utf-8?B?M3BoaWI0ZVRsNEd2cmNGNXU1N25ucEZPNnFsTVFaNHFxWGk1bmFPWUZ2K2xB?=
 =?utf-8?B?QmVvQ2ZuSGJBOUg5dklST0lMRmdzZytqa05rRWZpYisySzc2NkJPQlpmNlph?=
 =?utf-8?B?QzBaelIxbmsrOWM4OHFZbldQTlVIc3ZBMmNSRW9JRGhwamhQMFhPdVVObFQ5?=
 =?utf-8?B?eEkrMzZUbGxyOHQ3SkY1aXRXb1dEUzNKcGxRVHl6eGVUS3p3WjR1ZnJQdVpH?=
 =?utf-8?B?OEtsWEFuVmpCOVV2dG45T1NWOHR6MWczSDZ1cWwzeUNEaGdTdWJFVTdJa3F1?=
 =?utf-8?B?eXpMZVJrOWh4WUJ5d3Vib1ovdVhPTDRhcENSdW5PWDRBc3kxVjJJTmI4N0I2?=
 =?utf-8?B?TlU5UGsrZXVhZHRwZUszUWwxMWFGMXRsM1RWeTJXdW1ncWVHdUc0UVVCUDlQ?=
 =?utf-8?B?OGZCYU1oZEZvME5McFdrV3ZadUdsNnFQamJQRDlac1BXTm5jaStrVnFXL1BN?=
 =?utf-8?B?cDRaMnNKSDY1V3BjeHhvTEdET1hnYVlGbGM3TWUrekx4VmdwRFg4Q2ljVUEx?=
 =?utf-8?B?UjRuWlRnVklhS0xRQXpvSmZ0OW0zU3RzOTNhQk51M2VVUkl0VkZGbkIxc0sy?=
 =?utf-8?B?L1U1SjZHQ2llMGRkdG5HK1NFdkpmSm93bWxsWUY0MTZDaW5iVm5OK291Mmtk?=
 =?utf-8?B?aTZVMTF5SHMyWVdzcERsZSszbmpwKzdPQURLbDAyRjZ5VXp4eHBUb1FVNHA1?=
 =?utf-8?B?Vzh4SEtvcVR4V25VSmJHZmtBSXNML1FaNkl5eXdxNG5HYkJUU0dkQWJ6ZHBq?=
 =?utf-8?B?d1Era0lqYVlUL1JrdFEvRWhid29VUUZJSTJSd1BtQ1NBTmw5MGh6S004UTNj?=
 =?utf-8?B?WTBhUUhWRnVWM1FyR2QzSFdVK09LWC83MlY2cERJU1BvVWJxMjJudTZmTHJI?=
 =?utf-8?B?Vi9nL2dJK3hBdmNhc0dmNUNrV21lNDJOdkFmQmRWSGlqcXRvUCtGaTFXa3c3?=
 =?utf-8?B?OUlUZVJrYWRZQ3BJR01Oand0Ulp5U0p6clA3TElGUlcrSmNFTTR0bDVqd1p0?=
 =?utf-8?B?Q3dOc1h1RnNYWGNFdGI3enpEVTRnQmhOUjlWYXU5NUhlWnZJUURPRmtURUgr?=
 =?utf-8?B?d29Qc0hldmN3T3JtNDNhSWFsQWNRWTgyRldSWFpFVFhZdksyejRMZWM3SHRx?=
 =?utf-8?B?ZXdDV01FYXB3d2ovME9pcTI1ZHpCUnplRmdxeFRTMWRxaFlYbE1NM2hkL1Ez?=
 =?utf-8?B?VjQwNERueEpzelVQclcvNVJrb2hsR1duMkhxSVFoTGYwZkpSWENqZ1B3NHRH?=
 =?utf-8?B?SUt3NVZHbFJ6anVmTHZhMENSZGZTek5zTmU4T0pNUWlPTWV2KzZtc1ZLSXlK?=
 =?utf-8?B?OE1PRTlLM2hIMndaYXNTUDJib1E1b01jc250QlpiRVF3N1hMdmJhWm1qRmxk?=
 =?utf-8?B?Wk5uY2dMdURWcnRoaTlmL0wyTk5ZT1BNS1prZkMxU2tyamdqZGxNRmhZaFNG?=
 =?utf-8?B?T3V6ajFubkRIeTZncVhuQ1laeTJhYkF3S0hyUnMyRlZJUUsrWTQvUWd1QU1m?=
 =?utf-8?B?ZmhTbllsMlNrMWNvRVZlUGpabXBnVDIyMEdURW1QZVl6OUlvaHVzb0ZNWmo4?=
 =?utf-8?B?ZjV2a3lvak92RjlOcUM2UWZIb0RBTytsSFVWSDNwMWI3UmNpVGNVTkYySy85?=
 =?utf-8?B?RlZCY1FETGxXNGd0NldxYnhMTnROQ2lQMjdnL3lSMGxCRk5KWmlEcXpPM3NX?=
 =?utf-8?Q?yhM0nuYtI5ckY97FnX/aelBjpiJf85QJa4a28=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <675FEBE8BB3F7C42B07920E66CA0F648@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10740
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4f3329e0-2369-469d-c2e2-08dc86facbda
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|35042699013|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHdDM1BNOU95LzZqZzV0amdZaWp1MmljbXJqeWsyZWNRS0thblVvZVJNVWQy?=
 =?utf-8?B?a0Mxa3pqanBKTjJKTGRWUFh5RVBVZ3lmWkhGazZzUTYyckhzVVZHOUM3VHFw?=
 =?utf-8?B?UGhKZkFzcU1xUkhjWHlIbG9Ja0pCMUNrZnc0dy9hdnpONzA3VlYzb1J0UEFz?=
 =?utf-8?B?NEwyTlc4dERkREJjemFPQ01PVzhNaFRDdGxRK3FlWkJtdDVzVXhZNE9KNDJ2?=
 =?utf-8?B?UGN2RVk5R1o0QVdVTUxwRmZLQTdXUGtDNGtjSjVzNGhzTUc3WklOU3NYcWRG?=
 =?utf-8?B?NWdmUUVYUi9admF5US8xS01YVk04VnRLYWZZVHBpMkVZQjZ5ZnFkVmFhb3V1?=
 =?utf-8?B?aUxnRFhoS3RmT3FDV0cwUVYra0QzWE1qZEdPWFgzMzIwcXlEUWl2dkpvYjZO?=
 =?utf-8?B?QXRZa2d6VmV3TERLOG9qbEFBK3E1Skp2UWg2WUIxeU5sSko1ZGZDYnNBbjJv?=
 =?utf-8?B?N1A3SEtSRFZOMnp4Qk0rL3cvOFNjaFpueHlsR2lhd1kzcXNuS3lKcXk0WDJv?=
 =?utf-8?B?eDBremF2aHhkZVhUNlF6OHNQekcyT00vV3gzWTNWNnA4MERUSmluQjdRTGpp?=
 =?utf-8?B?aFNoQWhmTXpENGxKMlczSERBQVV5S2JJTFlXdlB4VEJmeEJCRUhuZDJ0Zjl5?=
 =?utf-8?B?eDBxTC9qRFlaQmJjS2lXeUFQajhDbFVLTmJwQitSUU1NSnBnSjJXYXlSbFU1?=
 =?utf-8?B?LzAwMXdZcTNzZmo0QmYvQ25ER3lpRWx2V2U3VU5XSlhGQ0c1RWx5bXVEZnYz?=
 =?utf-8?B?Uy9FV2xMRytJMHlQV1J3M2M0Q3lPRU5QQUJMeG5XN0YyOWFaaDVHYWZxK0Nw?=
 =?utf-8?B?Q2NPb1FZM3NqWFJvdXdITk5SbVY0WmhmWGZQUTJQRkNPUDJSN0RrSDhMREJ6?=
 =?utf-8?B?NzR6WXFQcndidER5R2MyakkzM01NZWdDZEJZVXFaS3NnanZCcUxQS0JNV1kv?=
 =?utf-8?B?b1dVTHUyeGhJWVVIZGt2b1NaUWZNUXZZZVBMejRXb0oxMTI2cmMvQVFpNzFS?=
 =?utf-8?B?aUZCZnhPdERhQmU0cjFRbUFRMGtrVVhlWG9NWHlKak9uUkRyY00xVDZ2eDdn?=
 =?utf-8?B?YnMzWWxxL2prczNNaThVeWlpZCs5ekhyQ2Q3aWcvSXRkVTZCeVpYL1NWVkd2?=
 =?utf-8?B?cVdxRTNBaW9sTzk1c2o1dVdwWjlVWXhJRStIZVVKTG4wQ2hYRnNLbkJOdGhj?=
 =?utf-8?B?OW0zVVEyL1B5MWI5bmNIZU1nZFJaMVB0b0hOcmd6VFdUWUtWb1Y0TzlqTW0r?=
 =?utf-8?B?NTliUDV4VGg1UkpqQXpmYTF5V0ZORW4wNXdLUWlhRzV5NXMvN1JiOWRWNVN2?=
 =?utf-8?B?Z1VVK01OSDZ4ekF6aTF0dEh1S0MxVmwvZE9nTjQ4RUc0V3UvRHYvSlM2NDNE?=
 =?utf-8?B?TTFuaHFRT0NsVGZwUDFlM3lhSDRQMDNSRmhpeGNzVVh1VWxMcTZRWmgyeE5M?=
 =?utf-8?B?WDBOdlpQTXFsSlB6M3VYZmtHR1J4bWlwbUdHTFdjMzE3aXJrUXE0WlVTdmdu?=
 =?utf-8?B?TUk3UGVzU1BGM3cwajBXbVNIV0hIZXJjN2ZDWFZROHdFNEg3cWNoaURjZTJU?=
 =?utf-8?B?RzNyd21IdGdDTEhuZ0tiRnhyT1FRNmxUVXNHcTNieEo1ZmJNWHQxOHlwYWZ0?=
 =?utf-8?B?M1F3NnVPWUl6Q1p5OENTTUxIbXd3dFlqZ3hNbEE2ejQzMVZYaEJTSnIyN0x5?=
 =?utf-8?B?NUpwaW84WFFTNGRDS1lEL3g3RUFGdzJWS2VWVzN6dERYenRyWklqdHlwQ2Jk?=
 =?utf-8?B?M0lRR2NGSm9Ock9oMmRPRXNHbDMzSVdIbzJ0UWlIdzF0VUU2NmJvdytxaU4z?=
 =?utf-8?B?VTZNdGFvdUdBQzI0cUVEemNOTlgzT2hUeTVoTXNTSjNGaWJ1T1AyYitJVCtW?=
 =?utf-8?B?WUdMZmR3ZnMva2J5bHpteFoweGVJM0ZlVzIrUlZNSEltSHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(35042699013)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:04:59.3307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df47b6f-f289-4eb4-f3b5-08dc86fad171
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8786

T24gRnJpLCAyMDI0LTA2LTA3IGF0IDEzOjAyICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBKdW4gMDcsIDIwMjQgYXQgMTA6MTY6MTVBTSArMDAwMCwgQmVuIEdhaW5leSB3
cm90ZToNCj4gDQo+ID4gPiA+IEBAIC0zNTMyLDExICszNTQ0LDE4IEBAIHBlcmZfZXZlbnRfY29u
dGV4dF9zY2hlZF9vdXQoc3RydWN0DQo+ID4gPiA+IHRhc2tfc3RydWN0ICp0YXNrLCBzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKm5leHQpDQo+ID4gPiA+IMOvwr/CvSBwZXJmX2N0eF9kaXNhYmxlKGN0eCwg
ZmFsc2UpOw0KPiA+ID4gPiDDr8K/wr0NCj4gPiA+ID4gw6/Cv8K9IC8qIFBNSXMgYXJlIGRpc2Fi
bGVkOyBjdHgtPm5yX3BlbmRpbmcgaXMgc3RhYmxlLiAqLw0KPiA+ID4gPiAtIGlmIChsb2NhbF9y
ZWFkKCZjdHgtPm5yX3BlbmRpbmcpIHx8DQo+ID4gPiA+ICsgaWYgKGN0eC0+bnJfaW5oZXJpdF9y
ZWFkIHx8DQo+ID4gPiA+ICsgw6/Cv8K9w6/Cv8K9w6/Cv8K9IG5leHRfY3R4LT5ucl9pbmhlcml0
X3JlYWQgfHwNCj4gPiA+ID4gKyDDr8K/wr3Dr8K/wr3Dr8K/wr0gbG9jYWxfcmVhZCgmY3R4LT5u
cl9wZW5kaW5nKSB8fA0KPiA+ID4gPiDDr8K/wr0gw6/Cv8K9w6/Cv8K9w6/Cv8K9IGxvY2FsX3Jl
YWQoJm5leHRfY3R4LT5ucl9wZW5kaW5nKSkgew0KPiA+ID4gDQo+ID4gPiBUaGlzIHNlZW1zIHVu
Zm9ydHVuYXRlLCBucl9wZW5kaW5nIGFuZCBucl9pbmhlcml0X3JlYWQgYXJlIGJvdGgNCj4gPiA+
IHVzZWQNCj4gPiA+IGV4Y2x1c2l2ZWx5IHRvIGluaGliaXQgdGhpcyBjb250ZXh0IHN3aXRjaCBv
cHRpbWl6YXRpb24uIFN1cmVseQ0KPiA+ID4gdGhleQ0KPiA+ID4gY2FuDQo+ID4gPiBzaGFyZSB0
aGUgZXhhY3Qgc2FtZSBjb3VudGVyLg0KPiA+ID4gDQo+ID4gPiBUaGF0IGlzLCByZW5hbWUgbnJf
cGVuZGluZyBhbmQgdXNlIGl0IGZvciBib3RoPw0KPiA+IA0KPiA+IFN1cmUsIGhvdyBhYm91dCAi
bnJfbm9fc3dpdGNoX2Zhc3QiID8NCj4gDQo+IFllYWgsIEkgc3VwcG9zZS4NCj4gDQo+IA0KPiA+
IFN1cmUsIHByZXN1bWFibHkgeW91IGFyZSBoYXBweSB3aXRoIGp1c3QgY2FsbGluZw0KPiA+ICJw
ZXJmX2V2ZW50X2NvdW50KGV2ZW50LCBmYWxzZSkiIGV2ZXJ5d2hlcmUgaXQgaXMgY3VycmVudGx5
IHVzZWQsDQo+ID4gcmF0aGVyIHRoYW4gcmVuYW1pbmcgaXQgdG8gc29tZXRoaW5nIHNob3J0ZXIg
YW5kIGtlZXBpbmcgdGhlIHR3bw0KPiA+IGZ1bmN0aW9ucz8NCj4gDQo+IFllYWgsIHRoZXJlIGFy
ZW4ndCAqdGhhdCogbWFueSBpbnN0YW5jZXMuIFlvdXIgY3VycmVudCBwYXRjaCBhbHJlYWR5DQo+
IHRvdWNoZXMgdGhlbSBhbGwgYW55d2F5Lg0KPiANCj4gPiA+IFRoYXQgaXMsIEkgd291bGQgcmVh
bGx5IHJhdGhlciB5b3UgaGFkOg0KPiA+ID4gDQo+ID4gPiBzdGF0aWMgaW5saW5lIHU2NCBwZXJm
X2V2ZW50X2NvdW50KHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCwgYm9vbA0KPiA+ID4gc2VsZikN
Cj4gPiA+IHsNCj4gPiA+IMOvwr/CvWlmIChzZWxmKQ0KPiA+ID4gw6/Cv8K9cmV0dXJuIGxvY2Fs
NjRfcmVhZCgmZXZlbnQtPmNvdW50KTsNCj4gPiA+IA0KPiA+ID4gw6/Cv8K9cmV0dXJuIGxvY2Fs
NjRfcmVhZCgmZXZlbnQtPmNvdW50KSArIGxvY2FsNjRfcmVhZCgmZXZlbnQtDQo+ID4gPiA+IGNo
aWxkX2NvdW50KTsNCj4gPiA+IH0NCj4gPiA+IA0KPiA+ID4gQW5kIHRoZW4gYWN0dWFsbHkgdXNl
IHRoYXQgYXJndW1lbnQgYXMgaW50ZW5kZWQuDQo+ID4gDQo+ID4gDQo+ID4gRmFpciBwb2ludC4N
Cj4gPiANCj4gPiBJIHdhcyB0cnlpbmcgdG8gYXZvaWQgdGhlIDMgc3Vic2VxdWVudCB1c2VzIGFs
bCBoYXZpbmcgdG8gcmVwZWF0DQo+ID4gImZyb21fc2FtcGxlICYmIGhhc19pbmhlcml0X2FuZF9z
YW1wbGVfcmVhZCgmZXZlbnQtPmF0dHIpIiwgd2hpY2gNCj4gPiBmZWVscw0KPiA+IGEgYml0IG9m
IGEgcGl0LXRyYXBweS7Dr8K/wr0NCj4gPiANCj4gPiBJIHN1cHBvc2UgSSBjb3VsZCBwdWxsIHRo
YXQgaW50byBhDQo+ID4gInVzZV9zZWxmX3ZhbHVlKGZyb21fc2FtcGxlLGV2ZW50KSI/DQo+IA0K
PiBJSVJDIHRoZXkgYWxsIG9yaWdpbmF0ZSBpbiBhIHNpbmdsZSBsb2NhdGlvbiBhcm91bmQNCj4g
cGVyZl9vdXRwdXRfcmVhZCgpLA0KPiB0aGF0IGFscmVhZHkgaGFzIHRoZSBldmVudCBhbmQgY291
bGQgZWFzaWx5ICdjb3JyZWN0JyB0aGUgc2VtYW50aWMNCj4gbWVhbmluZyBieSBkb2luZyB0aGUg
YWJvdmUgb25jZSBvciBzby4NCj4gDQoNCkFzIGZhciBhcyBJIGNhbiB0ZWxsLCB5b3UgY2FuIG1p
eCBldmVudHMgaW4gYSBncm91cCB3aXRoIGluY29uc2lzdGVudA0KdmFsdWVzIG9mIFBFUkZfU0FN
UExFX1JFQUQgd2hpY2ggbWVhbnMgdGhhdCBkb2luZyBpdCBhdCB0aGUgdG9wIGxldmVsDQppbnRy
b2R1Y2VzIGFuIGluY29uc2lzdGVuY3kvY29uZnVzaW5nIGJlaGF2aW91ciBzaW5jZSBpdCBtYWtl
cyB0aGUNCiJ0aHJlYWQtbG9jYWwtbmVzcyIgb2YgdGhlIHJlYWRfZm9ybWF0IHZhbHVlcyBhIHBy
b3BlcnR5IG9mIHRoZSBldmVudA0KdGhhdCBjYXVzZWQgdGhlIHNhbXBsZSwgcmF0aGVyIHRoYW4g
b2YgdGhlIHNwZWNpZmljIGV2ZW50IHRvIHdoaWNoIHRoZQ0KdmFsdWUgYmVsb25ncy4gVGhlIGN1
cnJlbnQgaW1wbGVtZW50YXRpb24gbWFrZXMgaXQgYSBwcm9wZXJ0eSBvZiB0aGUNCnNwZWNpZmlj
IGV2ZW50IG5vdCB0aGUgc2FtcGxlIGV2ZW50LiBTcGVjaWZpY2FsbHksIHdoZW4NCnBlcmZfb3V0
cHV0X3JlYWRfZ3JvdXAgcmVhZHMgYSBjaGlsZCBldmVudCB0aGF0IGRvZXMgbm90IGhhdmUNClBF
UkZfU0FNUExFX1JFQUQsIHRoZSBzYW1wbGUgZXZlbnQgbXVzdCBoYXZlIFBFUkZfU0FNUExFX1JF
QUQsIG1lYW5pbmcNCnRoZSBjaGlsZCBldmVudCB3aWxsIGdpdmUgdGhlIHRocmVhZC1sb2NhbCB2
YWx1ZSBldmVuIHRob3VnaCBpdCB3YXMgbm90DQpjcmVhdGVkIGFzIGluaGVyaXQrUEVSRl9TQU1Q
TEVfUkVBRA0KDQpJIGNhbiBlaXRoZXI6DQoNCiAqIEtlZXAgaXQgc28gdGhhdCB0aGUgcGVyZl9v
dXRwdXRfcmVhZF9ncm91cCB1c2VzIHBlci1ldmVudCB2YWx1ZSBmb3INCnNlbGYNCiAqIFJld29y
ayB0aGUgZGVsaXZlcl9zYW1wbGVfdmFsdWUgaW4gc2Vzc2lvbi5jIHRvIGJhc2UgaXRzIGRlY2lz
aW9uIG9uDQp0aGUgc2FtcGxlIGV2ZW50IHJhdGhlciB0aGFuIHRoZSBzcGVjaWZpYyBldmVudA0K
ICogRm9yYmlkIGluY29uc2lzdGVudCBQRVJGX1NBTVBMRV9SRUFEIGZvciBldmVudHMgaW4gYSBn
cm91cA0KICogU29tZXRoaW5nIGVsc2U/DQoNCg0KDQo+ID4gPiANCj4gPiA+ID4gQEAgLTcyMDUs
MTMgKzcyMzIsMTQgQEAgdm9pZA0KPiA+ID4gPiBwZXJmX2V2ZW50X19vdXRwdXRfaWRfc2FtcGxl
KHN0cnVjdA0KPiA+ID4gPiBwZXJmX2V2ZW50ICpldmVudCwNCj4gPiA+ID4gw6/Cv8K9DQo+ID4g
PiA+IMOvwr/CvXN0YXRpYyB2b2lkIHBlcmZfb3V0cHV0X3JlYWRfb25lKHN0cnVjdCBwZXJmX291
dHB1dF9oYW5kbGUNCj4gPiA+ID4gKmhhbmRsZSwNCj4gPiA+ID4gw6/Cv8K9IHN0cnVjdCBwZXJm
X2V2ZW50ICpldmVudCwNCj4gPiA+ID4gLSB1NjQgZW5hYmxlZCwgdTY0IHJ1bm5pbmcpDQo+ID4g
PiA+ICsgdTY0IGVuYWJsZWQsIHU2NCBydW5uaW5nLA0KPiA+ID4gPiArIGJvb2wgZnJvbV9zYW1w
bGUpDQo+ID4gPiA+IMOvwr/CvXsNCj4gPiA+ID4gw6/Cv8K9IHU2NCByZWFkX2Zvcm1hdCA9IGV2
ZW50LT5hdHRyLnJlYWRfZm9ybWF0Ow0KPiA+ID4gPiDDr8K/wr0gdTY0IHZhbHVlc1s1XTsNCj4g
PiA+ID4gw6/Cv8K9IGludCBuID0gMDsNCj4gPiA+ID4gw6/Cv8K9DQo+ID4gPiA+IC0gdmFsdWVz
W24rK10gPSBwZXJmX2V2ZW50X2NvdW50KGV2ZW50KTsNCj4gPiA+ID4gKyB2YWx1ZXNbbisrXSA9
IHBlcmZfZXZlbnRfY291bnQoZXZlbnQsIGZyb21fc2FtcGxlKTsNCj4gPiA+IA0KPiA+ID4gLi4u
b2JzZXJ2ZSB0aGUgZmFpbC4uLiBmcm9tX3NhbXBsZSAhPSBzZWxmLXZhbHVlLW9ubHkNCj4gPiAN
Cj4gPiBCeSBmYWlsIHlvdSBhcmUgcmVmZXJyaW5nIHRvIHRoZSBkaWZmZXJlbmNlIGluIG5hbWVz
Pw0KPiANCj4gVGhlIGRpZmZlcmVuY2UgaW4gbWVhbmluZywgb25lIGlzIGZyb20tc2FtcGxlLCB0
aGUgb3RoZXIgaXMgc2VsZi0NCj4gdmFsdWUuDQo+IFBlciB0aGUgZXh0cmEgY29uZGl0aW9uIHNx
dWlycmVsbGVkIGF3YXkgdGhleSBhcmUgbm90IGVxdWl2YWxlbnQuDQoNCg==
