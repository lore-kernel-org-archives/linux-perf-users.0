Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175F5490E;
	Fri, 10 May 2024 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323952; cv=fail; b=H59ViNW5YC+Iv1ImeKczp4J91HytaOl5hXUiyV7R72iR8EYAkglFckQI5gx5kRa/EYdIriF+XSCCtQHgXXU8HST78NLBjpWJW50R4osbQwWwnShPyw9IBpT5gIw4J2eZUjvMHXV+9cqTUNTXODVivhKak3ifmBdb8+lMr0sHLfI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323952; c=relaxed/simple;
	bh=JxpzyG8LdFfAzH1xnYoYRg6gYmVsK/T3VhFJbgTqnjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RS4LL9VcMkPCJDByINGHFAJ3y6B7mEErZePT6ZdkZVkN1UdzL97xd2mCWNKsENrNXHDbXTWmvzG3QcOtweT5yQJhSgK6VcszIHCZMN0jzJom9nzLOtyU4Gi77XFqRMlZuCkQr7ELUAGRDEOqWEYCpVDVMrW/LxTpv5S5eqSNauk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iDRTYVAt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iDRTYVAt; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iDRTYVAt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iDRTYVAt"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=JBSO5EUOZT8yk2RXqiqhrgbmQHXbL4RluEIKC3SOO9QW5fmWlQQN8M/cis/rwDA3vm0uTQE75TRld7ZUVfCmA7OmxSuyWGUBZTgHNk3o/0k2ZLNPUwHtzINReZZwWxTkLk+Yr5USvr0WAiN9JJ1DdCjgC6gs6QuesfxZLzF6YI74CANCHDwAwxE8rrmGzsBYRvK1LudIHXnLKfRSgLu26ooDeFo/yCSUEXGV7fVoLhF+Urkho6/lvceiaYo13lgUUYYc/Y9uAxfDaBRoWP5fMtlLvEpu9CTVb3I/8N7VacWp9bVfjE/twkrfW+Sg2SKEDTI5mJhy7PPCPKKyeIFVOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxpzyG8LdFfAzH1xnYoYRg6gYmVsK/T3VhFJbgTqnjA=;
 b=Xq8ug/YUG7u6Ch1odIF9d1czoScjnCRRX5sykGmHL36qzwqOlmsTQC1xYBOsnPynAQfpNIBb4XyA/Eb9TFrxqcqSvTQacwtIkqcoZ4vZXFbHvuLx7oBJNXhu5jRnnZ+eG9d2zS+KBAGD6E31KD3fUx4YFq17pBH8UfA3deUIcGO+Hpvz09Ytu2Dh5hov1Z0kFqWWEDsBrn2PRBGGQQzmzNBy+9gK6tkvqghQyuL00hUTM4eISld2ZwlH/EpyRLUyJi6udkIGco/R/uc3kuugjI/zSzYlxx7t1oQUgGA/KEt4uh9y5XyPE9xxPwdAj4pz7/iWPRJqxnHIX7ACWASgjg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxpzyG8LdFfAzH1xnYoYRg6gYmVsK/T3VhFJbgTqnjA=;
 b=iDRTYVAt5O4Cm3L1hjhVlT80e3t3nt4qzMe/vd1HOo2cbMdisFD5XwOSAtMpxodquRU2YH39LU1BZYYWlD0z35QGNiC238Gox0E0MmOudfviYCHUBQ7283+jmD35IJ0jk9NWlfuBrEbwfGhU+ymcnwGUf6IVCc5LZV6NJnBji14=
Received: from DUZPR01CA0318.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::7) by DU2PR08MB7357.eurprd08.prod.outlook.com
 (2603:10a6:10:2f0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 06:52:24 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::40) by DUZPR01CA0318.outlook.office365.com
 (2603:10a6:10:4ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Fri, 10 May 2024 06:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7544.18
 via Frontend Transport; Fri, 10 May 2024 06:52:24 +0000
Received: ("Tessian outbound b7675f20d34d:v315"); Fri, 10 May 2024 06:52:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7266b6cc2547a6bc
X-CR-MTA-TID: 64aa7808
Received: from 282032d13ae3.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id E2036B58-52D9-43CB-A3B9-044E942027ED.1;
	Fri, 10 May 2024 06:52:12 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 282032d13ae3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 10 May 2024 06:52:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8YW0vodWLrFKm+FGf3UYIVskni3pfwTBBdOJJl4gyXd9KQPjtLSnGJUhmLZVsuINj2eLtPZoRc2h3iQPmFtGyYQrS0rUG+FsD71s9msszTk08PFywZcIKCeu2Awwaq5IR75YjzNDACvSVGiU6ArIBYDZCbfMeKyxQnEg4R1xuOy6WnTebyLGTB9lMEV6FJhfdetUzRvHVyV/tBYRzpOjoKUomnek2nDL+hW0nMEnL7FoaF6y49HrLbQ/WEZXr2sh9ci+Bs6x6pZzPG3o1sAkxgJU2/I50KvDT8T6gHdzVNfgZ+aadpi52NXLdZXLJTpBq2oqTlwt4lnRxKRyeyd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxpzyG8LdFfAzH1xnYoYRg6gYmVsK/T3VhFJbgTqnjA=;
 b=YkFZrZSYL61r/n45olA+kYoF0zhMFckTqL9x96zx8py+OSusd0wBTXiYU/qicaHwtZkBCdRMvaoYfqjEpCnZYBbii6WZccKx46imSj6bjqbvxE6/ZsL5muBkUsQ9JefJTTipmbaK/8tU4zx0GcavSdLbzOXIi+fVoes8Ph3FinhdU1rICyGxuMty9lfjbMYv7XvIxR29ZB+uRTzht4rp4jvl/q/TB8wBJ7R2wOObQoYmBSeHglgjcz/cj2KQOiNPGH9EY2FQ9T6IXefVNq9zioWN/ch7v+tsIPtJISueOqaH/QN0rWYpyWIcxzKdNKRN9O5XTh4yFlektrVkjBsf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxpzyG8LdFfAzH1xnYoYRg6gYmVsK/T3VhFJbgTqnjA=;
 b=iDRTYVAt5O4Cm3L1hjhVlT80e3t3nt4qzMe/vd1HOo2cbMdisFD5XwOSAtMpxodquRU2YH39LU1BZYYWlD0z35QGNiC238Gox0E0MmOudfviYCHUBQ7283+jmD35IJ0jk9NWlfuBrEbwfGhU+ymcnwGUf6IVCc5LZV6NJnBji14=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DU0PR08MB9607.eurprd08.prod.outlook.com (2603:10a6:10:449::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 06:52:09 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::e33b:91d9:dd96:4862]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::e33b:91d9:dd96:4862%3]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 06:52:09 +0000
From: Justin He <Justin.He@arm.com>
To: Ian Rogers <irogers@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, James Clark <James.Clark@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd
	<nd@arm.com>
Subject: RE: [PATCH 2/2] perf pmu: Fix num_events calculation
Thread-Topic: [PATCH 2/2] perf pmu: Fix num_events calculation
Thread-Index: AQHaooSADiN3mLJsT0mSvkfFRS8SX7GP/jQAgAADRBA=
Date: Fri, 10 May 2024 06:52:08 +0000
Message-ID:
 <DBBPR08MB4538A157B81F2BBD2DD9E40DF7E72@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20240510024729.1075732-1-justin.he@arm.com>
 <20240510024729.1075732-3-justin.he@arm.com>
 <CAP-5=fVGD-pK1igABj0wiq6-KVM+Z4i7rnRhM=Vy7bFHW4pLQA@mail.gmail.com>
In-Reply-To:
 <CAP-5=fVGD-pK1igABj0wiq6-KVM+Z4i7rnRhM=Vy7bFHW4pLQA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DBBPR08MB4538:EE_|DU0PR08MB9607:EE_|DU2PEPF00028D03:EE_|DU2PR08MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 9283309e-1e52-4678-385c-08dc70bdbf6a
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WnRSeTBmdi8rdXA5T0lUNWlqQWkvYkRXQ2dLbTh6cHhZc3NScWRvaUZPUGcy?=
 =?utf-8?B?Mm4vUjZZYXdJeE5qSEFJM3JBS2g0a0tGcUVac1RudnpLdmpES0dlY01SbjNE?=
 =?utf-8?B?RmZja1cvUW9SdnRHNzdDVUZNK01RNm9vV2pKMWhJbDBuL3U4aWFWV2lVaElD?=
 =?utf-8?B?Y1oyblk2aTY1N1VjeHdOY1pOM1lKN2pCNEpyR0NQa0JMWlgrR2VzTExobWdl?=
 =?utf-8?B?QWZOZnFkM0FpdDNRN2x3bXdnVUlHL2hqVk93SXAwbVpjSnFYUm40QUFLbFZU?=
 =?utf-8?B?V1FKcE5WMzN0WS9jRXQ4OU9lSHBYZ2xDQ2Rmcmt0dXVaMzdsTDBicCt2MVFP?=
 =?utf-8?B?dXBzOHJGRW1GcmlsckxKQkc2a0IxMjJranlIcGxCK0VjVnRHdm96U1hRNE4x?=
 =?utf-8?B?RlVweEFOaS9IQ0Y3bXNQMjJHam1ub2dBd2JpR0ExRVN6NDYzQk1maU5rZDNl?=
 =?utf-8?B?YldjK2JHdng5ZDA5ZE1vVTVGYnBGUUovY3o1ZHBQamNobnYwNFNVNnFzc0dq?=
 =?utf-8?B?bUZOWjhTVmppbG1HUjFpeTdMVEVQcFYxTzRLWjhwK1EwUldtWlpUcGdMV2xo?=
 =?utf-8?B?VjJLdXQ5b0JXa3RGQXNJR3I3UXh1S1BtaWx5dmxWVnFDQmh0dDVyQm43QlMz?=
 =?utf-8?B?T3hFMnNnTDFQV2JiR2V0OHBkL3dRZ20xNTA4eXF1a3pPWlA4N0I4L3R6Q3Z4?=
 =?utf-8?B?TVFBZ01vQWx5dzFVdm91bWZ0cHdKWjF5eWdFUnJ4VGFESEFydzFFeGxwbm1R?=
 =?utf-8?B?QU1sQjVHMkZFL1NWU0NjZG5NNDE1cGVTTFlEek5pUE56dThNeVF0aGRxa0VQ?=
 =?utf-8?B?Z1E5RHJMOEwxT2JHeHVEZ1grVHUrR2F1bFR3S1FHYXBPTkxKTWtvMU83TjVr?=
 =?utf-8?B?bVBzUFlCaTVhMkdPVXZQaHZYdzRqT2ptL3BLMjRMS3g5MXU2SzllMWxEemdw?=
 =?utf-8?B?VUNqVm5zQkRXVVNCbGhsVjM2QU0wU0txVkR4VkVFNThGV3N4ZjgrZUp0Ykxk?=
 =?utf-8?B?b2s1NHYxOWc5UnBpVHZpRDBaZGRUTi9xNytKVCt5V3duQUUwZEJKNkhSYTNT?=
 =?utf-8?B?RzF4LzBrMUMyelROYllYSmtHS1prUHd3M0Z1eDU2RHR4WCtSYjdXYTVGUUxB?=
 =?utf-8?B?ZTl5enRnenZMVzUxZnlsRy9LWDlyRDdQN2E2d05oNW9zTENUUkRBN0NtZFFK?=
 =?utf-8?B?K1dNQ1BPbStsZUozZU52RldHT0Y0NTFrUHFSY0tBOGRRS21ZNjVCRXMxdWVh?=
 =?utf-8?B?Z0NnWUhMVFdBMzlrMjhXa0svNFFTQlhZR3hmcmt4SzRlVjdSaEROVkQvQzFx?=
 =?utf-8?B?VDJZcTdSdkovMDZIMmJ0SVZCZExDR3lCbVlyMjlqN2lPTzRaQnlaMUdvclRp?=
 =?utf-8?B?cDhQeUZHdkhLdUVUN3YwS09zTW5zdmVGM09wSCtQcDNkUVJVNE1pVStHL2FD?=
 =?utf-8?B?OExPZW03VUFxYlgxVzhKbzZqRlRLK2JTQis4VmZ0eGFEb3M3VENTcjNxM25p?=
 =?utf-8?B?Ym9sR0FGTlFhN2tZK21UcDY1WG9VSHVHSENrYW1tanh3NjAySzg5RFRMRFNw?=
 =?utf-8?B?UC8wUlZISEVRNFRNUHZVU3lYK0hjMm95aUZDY1kxWXJ6bzRkMDVLWkhXWTEv?=
 =?utf-8?B?WWZ3RmJnMWsxZWRVcittekYwbW5uOHJ1TFlwanRGZXc5NmdjV3ppNS8rN3I5?=
 =?utf-8?B?RjdKeVhSaEJIUkZmRnJ3ZFo5VXdTZ1dCMUNRdzNURVpTVytVWTVoa0hiQmh3?=
 =?utf-8?B?UDY5WEJXOXVjT1hKUDFTTTh4NFhKdW5BRzZGMjFaSHhTQWpOeEpPa2l2MjZi?=
 =?utf-8?B?UWlzazZRUVRPZDdkeGhndz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9607
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9ea0a761-de84-40eb-0397-08dc70bdb64e
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|35042699013|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE95eUo3Q1psQlZsOWN4OXlxeEx0NHdKNG5BeDVxbm44ZjdpYkNLT1oyeW1E?=
 =?utf-8?B?SVBtMjhoNkQ2NFBmb204WUR4WXZSUmVHYUp5RWJpVzFKR1Qvc3oraHpUdnFi?=
 =?utf-8?B?bjhRM29PM21yUkZwUkREd1dDVUVFZ2JEckpTUnFWMWlDVkNWcmo0K0J2SHBR?=
 =?utf-8?B?V24vZHNESk1DeE16Z0Q3N0FSOWNaZm9USnBhbEFLeVRTa0tSU00xaGVydTdn?=
 =?utf-8?B?eXhDQlNhNDJ2eGl3QjhWT3d2NmtFK3FKM0VETnRiOEtCeFZsMFpWdjhJZ0c2?=
 =?utf-8?B?UFRmRW91cE1pNTE5d252QXhoMlhqMTBibE8wMW5lcWcySUJHd3RyeThRV0dQ?=
 =?utf-8?B?VmtvMjNwWDR2cWhqRkFzeXMyeUd3RlRrcnl0TFZOYzBUMU1uRllNYzlQS0Nx?=
 =?utf-8?B?ckpBTVhROVFSOVJZZFVsRWJRcG1Oakhham1SWHhJaDhOVHkzb21wK0EyZ2xk?=
 =?utf-8?B?L2U1YTdLR2RRVDhaTGQzSFl0MlpXRGF2aURydkhwck5DMUpJUGhidXdBYjZ3?=
 =?utf-8?B?TVlnT2xYMkJDb2hRTHNxamJOTndDME9MZkJUZjVCdHE2MEtSR0hCNWZoSDBP?=
 =?utf-8?B?V3lGWnJYKzJoMGlFMUFXVDNsOVRBWStMVHhFaWJsdWNObXl0T3A3cVpzRUlR?=
 =?utf-8?B?dmwxQ3VhM0YrMWppdTROMVRKcnZlYldGamZJRnRlajJKTlNQOWcxTHNRS1pC?=
 =?utf-8?B?QW4zeDVsOXR2Uk9lOEwxcC94SGd6bTZnMGQ4bzVGSjNTeW9ocEYydHBSNjdq?=
 =?utf-8?B?azg2STBFb1JWV1FiSTdGMHc1Z0UxMEhFSEtSRGppak9zL0dxUGFkc3FBN2li?=
 =?utf-8?B?cS9UWXBTR0VGb1pGM0FNOHRqSkp1VURQOFNaZE5oaUhKWXRJZFJBV2FWeERi?=
 =?utf-8?B?UjdLek1hcHVmR0FRcTJFY0k4QjBNaW96WGQyNE9ldFZqZFQzQU9VamFtaDRv?=
 =?utf-8?B?MmgyWkluMVBsQ3dycXJ6MXNlZk5RMzIrOS82UjFYSzF4QU9ZNFNLci9YWlJE?=
 =?utf-8?B?bUp4N1JvTmJFR0dpbk9BVTZRb05ESzhsaW9iblcxOUhXcjBHOTJwVEx3TVlQ?=
 =?utf-8?B?MlBrSkNacjBqQWViZjVrbjZHekpHOHo3M3lIYU9CbVlibVRwL0YxM1lNWDVN?=
 =?utf-8?B?QmtST1FzK2VKbGs2Y0JmcG5KS1dkMGszSUdBend1cWhPWWJudUdiT2NVL0pm?=
 =?utf-8?B?c3FrcUc0c0Z3VCs5V3BMUTEvOWc0cEtOYkZQRnA4Y3N4a0ZkMyt1N00rNFpa?=
 =?utf-8?B?bXJFVUpKQU1TbTRWS3d2ZEwrRVZ5VDJJUGI4VTRTQXk4OEMva3pkSHBFanhR?=
 =?utf-8?B?RUJwdEQ1bmpKZ0lwS3pZamhvKzl4S1k0akRkUjdrM3lPci9nQzVMQkVINUp1?=
 =?utf-8?B?UGhzV0RET3dqaXppbnNkUUtjRzJES2ZKMlVvMUx0dTdjSFIvTkNiWlJpUDZ4?=
 =?utf-8?B?Mmp5V0hJcWtid3hjdGZJTWEvNDlTd2RVWHFvaHk5dktMUGllOWd0T2JwZ280?=
 =?utf-8?B?d3pxZEZqeFZEdXBidjYvbmpEQmpTOVFWSkpSOTdycEs0Z2ZTUUVveCtybFVs?=
 =?utf-8?B?T2pRWElOSjlxLy9XcmxENHdqSjhzbGRITyt0d0RUcmlvQWZaUCtEY09jMnRK?=
 =?utf-8?B?UFRXWUJldnVDckEzczhoRmxCMktselhYQXJwWGNuTmVQbEVvZDJXVGQ0VGlB?=
 =?utf-8?B?ZTh5OFlGanhURmJIeHhQR2JRK0lIWWtsQ2FlZGVORFFSUGxqOE1HcGVVYXNW?=
 =?utf-8?B?K1o0U3NYZnF6NW9xOHpsaC9iNGxGYTlTTit4NzU3cXRtVnVsMGNsY0x0Rm1N?=
 =?utf-8?B?N1VsTy9qczl6M01aS3ZXNDdCUWM5OWFBYkVPSVZzNkJEaTRuVG9hd0hwZkFV?=
 =?utf-8?Q?XWADgJgGGEg3Z?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(35042699013)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 06:52:24.2307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9283309e-1e52-4678-385c-08dc70bdbf6a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7357

SGksIElhbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IElhbiBSb2dl
cnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTAsIDIwMjQgMjox
NyBQTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4gQ2M6IFBldGVyIFpp
amxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQu
Y29tPjsNCj4gQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQGtlcm5lbC5vcmc+OyBOYW1o
eXVuZyBLaW0NCj4gPG5hbWh5dW5nQGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPE1hcmsuUnV0
bGFuZEBhcm0uY29tPjsgQWxleGFuZGVyDQo+IFNoaXNoa2luIDxhbGV4YW5kZXIuc2hpc2hraW5A
bGludXguaW50ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsNCj4gQWRyaWFu
IEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBLYW4gTGlhbmcNCj4gPGthbi5saWFu
Z0BsaW51eC5pbnRlbC5jb20+OyBKYW1lcyBDbGFyayA8SmFtZXMuQ2xhcmtAYXJtLmNvbT47DQo+
IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBwZXJmIHBtdTogRml4IG51bV9ldmVu
dHMgY2FsY3VsYXRpb24NCj4gDQo+IE9uIFRodSwgTWF5IDksIDIwMjQgYXQgNzo0N+KAr1BNIEpp
YSBIZSA8anVzdGluLmhlQGFybS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gV2hlbiBwZSBpcyBOVUxM
IGluIHRoZSBmdW5jdGlvbiBwZXJmX3BtdV9fbmV3X2FsaWFzKCksIHRoZSB0b3RhbA0KPiA+IG51
bWJlciBvZiBldmVudHMgaXMgYWRkZWQgdG8gbG9hZGVkX2pzb25fYWxpYXNlcy4gSG93ZXZlciwg
aWYNCj4gPiBwbXUtPmV2ZW50c190YWJsZSBpcyBOVUxMIGFuZCBjcHVfYWxpYXNlc19hZGRlZCBp
cyBmYWxzZSwgdGhlDQo+ID4gY2FsY3VsYXRpb24gZm9yIHRoZSBldmVudHMgbnVtYmVyIGluIHBl
cmZfcG11X19udW1fZXZlbnRzKCkgaXMgaW5jb3JyZWN0Lg0KPiA+DQo+ID4gVGhlbiBjYXVzZSB0
aGUgZXJyb3IgcmVwb3J0IGFmdGVyICJwZXJmIGxpc3QiOg0KPiA+IFVuZXhwZWN0ZWQgZXZlbnQN
Cj4gc21tdXYzX3BtY2dfM2YwNjIvc21tdXYzX3BtY2dfM2YwNjIvdHJhbnNhY3Rpb24vLw0KPiA+
DQo+ID4gRml4IGl0IGJ5IGFkZGluZyBsb2FkZWRfanNvbl9hbGlhc2VzIGluIHRoZSBjYWxjdWxh
dGlvbiB1bmRlciB0aGUNCj4gPiBtZW50aW9uZWQgY29uZGl0aW9ucy4NCj4gPg0KPiA+IFRlc3Qg
aXQgYWxzbyB3aXRoICJwZXJmIGJlbmNoIGludGVybmFscyBwbXUtc2NhbiIgYW5kIHRoZXJlIGlz
IG5vDQo+ID4gcmVncmVzc2lvbi4NCj4gPg0KPiA+IEZpeGVzOiBlNmZmMWVlZDM1ODQgKCJwZXJm
IHBtdTogTGF6aWx5IGFkZCBKU09OIGV2ZW50cyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhIEhl
IDxqdXN0aW4uaGVAYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgdG9vbHMvcGVyZi91dGlsL3BtdS5j
IHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL3BtdS5jIGIvdG9vbHMvcGVyZi91dGlsL3BtdS5j
IGluZGV4DQo+ID4gYTFlZWY3YjJlMzg5Li5hNTMyMjRlMmNlN2UgMTAwNjQ0DQo+ID4gLS0tIGEv
dG9vbHMvcGVyZi91dGlsL3BtdS5jDQo+ID4gKysrIGIvdG9vbHMvcGVyZi91dGlsL3BtdS5jDQo+
ID4gQEAgLTE2MzksNiArMTYzOSw4IEBAIHNpemVfdCBwZXJmX3BtdV9fbnVtX2V2ZW50cyhzdHJ1
Y3QgcGVyZl9wbXUNCj4gKnBtdSkNCj4gPiAgICAgICAgICAgICAgICAgIG5yICs9IHBtdS0+bG9h
ZGVkX2pzb25fYWxpYXNlczsNCj4gPiAgICAgICAgIGVsc2UgaWYgKHBtdS0+ZXZlbnRzX3RhYmxl
KQ0KPiA+ICAgICAgICAgICAgICAgICBuciArPQ0KPiBwbXVfZXZlbnRzX3RhYmxlX19udW1fZXZl
bnRzKHBtdS0+ZXZlbnRzX3RhYmxlLA0KPiA+IHBtdSkgLSBwbXUtPmxvYWRlZF9qc29uX2FsaWFz
ZXM7DQo+ID4gKyAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgIG5yICs9IHBtdS0+bG9h
ZGVkX2pzb25fYWxpYXNlczsNCj4gDQo+IFRoYW5rcyBmb3Igd29ya2luZyBvbiB0aGlzISBUaGUg
InN0cnVjdCBwbXVfZXZlbnQgKnBlIiBpbiBuZXdfYWxpYXMgaXMgYW4gZW50cnkNCj4gZnJvbSB0
aGUganNvbiBkYXRhLCBhbmQgInBtdS0+ZXZlbnRzX3RhYmxlIiBzaG91bGQgTlVMTCBpZiB0aGVy
ZSBpcyBubyBqc29uDQo+IGRhdGEuIEkgYmVsaWV2ZSB0aGUgY29kZSBpcyBhc3N1bWluZyB0aGF0
IHRoZXNlIGxpbmVzIGFyZW4ndCBuZWNlc3NhcnkgYXMgaXQNCj4gc2hvdWxkbid0IGJlIHBvc3Np
YmxlIHRvIGxvYWQganNvbiBkYXRhIGlmIHRoZSBqc29uIGV2ZW50cyB0YWJsZSBkb2Vzbid0IGV4
aXN0IGZvcg0KPiB0aGUgUE1VIC0gaWYgdGhlcmUgaXMgbm8ganNvbiBkYXRhIHRoZW4gbG9hZGVk
X2pzb25fYWxpYXNlcyBzaG91bGQgYmUgMCBhbmQgbm8NCj4gYWRkaXRpb24gaXMgbmVjZXNzYXJ5
LiBJJ20gd29uZGVyaW5nIHdoeSB0aGlzIGNhc2UgaXNuJ3QgdHJ1ZSBmb3IgeW91Lg0KT24gbXkg
QXJtdjhhIE4yIHNlcnZlciwgInBtdS0+ZXZlbnRzX3RhYmxlIiBpcyBOVUxMIGJlY2F1c2UgcGVy
Zl9wbXVfX2ZpbmRfZXZlbnRzX3RhYmxlKCkNCnJldHVybiBOVUxMLg0KDQpJIGFsc28gbm90aWNl
ZCB0aGF0IHBtdS0+bG9hZGVkX2pzb25fYWxpYXNlcyBpcyAqbm90KiAwLiBUaGUgbWlzc2luZyBh
ZGRpbmcgY2FsY3VsYXRpb24gd2lsbCBjYXVzZQ0KcGVyZl9wbXVfX251bV9ldmVudHMoKSBsZXNz
IHRoYW4gbm9ybWFsIGNhc2UgYW5kIHdpbGwgdHJpZ2dlciBsYXR0ZXIgY2hlY2sgZmFpbHVyZSBp
bg0KcGVyZl9wbXVzX19wcmludF9wbXVfZXZlbnRzX19jYWxsYmFjaygpLg0KQXQgbGFzdCwgcGVy
ZiBsaXN0IHdpbGwgcmVwb3J0IG1hbnkgbGluZXMgc2ltaWxhciBhczoNClVuZXhwZWN0ZWQgZXZl
bnQgc21tdXYzX3BtY2dfM2YwNjIvc21tdXYzX3BtY2dfM2YwNjIvdHJhbnNhY3Rpb24vLw0KDQoN
Ci0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg==
