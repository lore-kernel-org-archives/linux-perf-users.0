Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022130.outbound.protection.outlook.com [52.101.96.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305A18FDBD;
	Sun, 19 Jul 2026 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784420120; cv=fail; b=p/W9uxDneZEPuhGVkfmtFOWa5PN7JotgKNXBuA6h1gyMWgva5bKfCb6UYc3KYN4X72BONcjtjbFhApJa1IenrHyOq4Yp2oRTzG2yUISvA29ekTU4rhoqXU8PCAiiyBjNDckF9OAvJDF8jb4gVwGOcWwbEuVtx+mPABj+q/SsSW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784420120; c=relaxed/simple;
	bh=v+ZOmfVV8VQUmS4E7sf5Cp7Be+zlvDJ7QCFUkY8Vy/8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AQ0vqbGxq/z9jB7kfke7MgrDfiUVywzUTvRBVosScHvxY7c4D7ibGY4EaQffwIHlnUwCLyBQJpzqf/qwZ+NttqpfCwV7t9INu22ULZrRu7qMcZ2uXExh28qBbPfmrCmyQSNt9MKrAo7HkF4kyC5p655PYoZA2XsqN9UUL3zTzZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSV/znTzt7GyBjQLUrXwlLvOXr+sQE1yJADUhPdIhvLuaF92xpuBvkdrnvh31pcBemXoFRTbs/1MfSw4ykrzt4NJ2NZWw+4UpsV8Kx3pfJq/yUgsPmhlXY2otZXJXlMly+A3bZ+69u5wETHBJjK74g+k7RoSRVTeSTGrBjBmGGO9C1taRA/CcqgbJ3O0Dq1q109jd9iYFj+VQzej8aBai3tHvUr5KQfGYM55T45B+TvTKDC6x2pFXbDhN/5QZhFuMJiEb35NdCfvLlw0OnRvYsSVZmik1H96gh5leUxiK0khy30EjbBiY/whDUmrpqN8bwoOw6f0uhCvYB4KjqvQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=WIrwVOnUK9bxJd2tp8RkVBwEISfNnZLwY/3ekUk1h0I=;
 b=g+3LLHFiiDNIbmPlGN3yp4/ZxdONyCnWqpSMswPDkH/TuQajoiJ73rPc8Dt8XHu3yy5AY77qi4Or/HUBnQZj/sCNT/CE640xDBXi/KYyAFTr6tg3zbhISQh+Cr1Hy3V9DqRi2r5BwrI0EHCFN1QPFJOnFuS8AL10OUs86we97Sxt2uYvHvTTCWFJAY5o64ukSCmQfR5q9ls7SHKMQiBRMqzpdvnRHZEWFU2Z33xYn6L4gfQLSM9Vz5WFp/Klefj2L9joth6Ng+WpX0DudSfQrIVnO4S3BbjazkAal0LFf9wKXGZZs4wg6BH1IP9ICNO8441KQScz4z9gDlaJoDu0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b2::11)
 by LO4P123MB6514.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 00:15:15 +0000
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383]) by LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383%4]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 00:15:14 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] perf trace: Correct cpumask formatting and add --bitmask-list
Date: Sat, 18 Jul 2026 20:15:08 -0400
Message-ID: <20260719001510.398616-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:408:f9::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6616:EE_|LO4P123MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 060596e8-2bfb-4dbb-319f-08dee52acde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|18002099003|10067099003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	h6HZX+A8BdiDim2IEa9xqldWGeoKNTDbqjsdVDETGMplzS0Q1M722eHQaIIcr5JiwKwRX5B58i6w8RtGXjudy8TWCVbX9kVlom6vv0bnaNJ4NO4dVGOpCTK2DjStU2XgT4YUfZFcAuOAUzLhu9kbTljuLtaMqBA/ijZQ6mCRIbzWSq6DpHPfeuHbk0+eoU6NT/JWRA0Qrm2qWPwhRg0tYRC8JrEwwjD9UoHips6SFWz6jZrVpm8kudNI6c44mah8XHw5QwXvZ7gMUiTv1KtyjV+mvLPVD4tDIpV1fJEaUmhzTgCsrUwt4nVSQdPaJ35idusJ+eXjpcO52QrkwA5xWKlSCjad5xkjriSBHMbPyb2XsoCQGpU02oNoAxwu4AsjZuaOsMe3NgQ4K+gAYPNAUlEZwtdC7Ms2/K8ZLDxi45gnu3iTnWqwdp99Fh0k9Qgt29EFAfM2qruFPHDvEK1+unPuSsty3U45P1z0y+RfQV3wMh81ZL6C8WbgAuXyjG01HSuKo5S+nYp5NCIi2YuhHs8uJvCoACrQvUoTAZRtmDd478WLGab0eEq1Q3r/cDOboc5w+sBigkzeo3m7c9H5NIH2LhFgTeMETA9x2qAxLI7DsqUMbEezr0mTFwswKMkrfY/gmwHLi03/Igr7mkVp3pY5+QxbhKhDDUDtnfoVjvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(10067099003)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DDWQZGzy1RQ+OtE/1fVKRoO0gVloTk6kwZMSJdhh51hMrDqrOClm7PNP1O0i?=
 =?us-ascii?Q?Ku4lK2P6saHyFvoewORlqpQ7WhxTcNLK62VVJYSqMcF/wmPsRusBg8Nz1f+6?=
 =?us-ascii?Q?2OYbplmUS1my1CJjUdnBvBE+yQdKioMFBMoxYs5mgFKDKidh//4/f3TengOb?=
 =?us-ascii?Q?NWgrLYnZpf3fqrmF7JtMd4PwuNwKavFGwbddd3algBMbj4Nm3+UB6QW116x3?=
 =?us-ascii?Q?RTLbdNcsr71ypkYalNAYJmjd8zwEa0fyfGKuvfUCrupCbA34wB3JrGgR8lyA?=
 =?us-ascii?Q?uTs2SrGpsaG9KfVJlmrBckp4OF0dot4aQrHSAF3fWC50e5HmB70doC1ast9k?=
 =?us-ascii?Q?mkWMC1yRAE1DyTV+Fog2C9b6bOezUxqFTz91dITJ55QhvAUeKIl8nbriF9/Y?=
 =?us-ascii?Q?CEv4vWLx/tKK3EOK8J4rZFtZu+S52pFicLN4Po93ebPoN7oAmu9DHj4xL647?=
 =?us-ascii?Q?oVq/ezZSRG7MqzHGGyj3QrumJBKd3b9/ZEGKDEHmnI3XppgzC2hkGeWP22HM?=
 =?us-ascii?Q?fG/33KNBAcnjWXhP+rXPzkgOKFLBfto3db/tXt04CbRfA5jpaaNudERP4EyP?=
 =?us-ascii?Q?7bylpl/AGX1RwuxPxceo7x0aa7AwtkTZvUz5okCHgWSQQo71fjJl3sLedgr0?=
 =?us-ascii?Q?e3mstPlZ+KLgacCZ9m8ykI84r6oj+wX3NcnF2ob+ohPETmPhsHoem05oScUQ?=
 =?us-ascii?Q?zNL3vCCvm0ckZ2geFy54X9DdcnqoPBK/N1xKZirTj0a7rF9GAGm/A/GpkaCf?=
 =?us-ascii?Q?Lchyjn/bug1VPGCR+CgCQYPI8UVQdifxDm0C1Uaq4lM42sae+2BFS9YJ652B?=
 =?us-ascii?Q?thiLUZCO9OzUC2z69kICwbEC1VGXW8b+9/vEfHlX3F6UQjhF+rhX//uSyanQ?=
 =?us-ascii?Q?qvyJOk199EJmfU5+b+80k1I0/M4OkRKSBscs0M3sCOYKcEyj4RWvmZKc3GHm?=
 =?us-ascii?Q?kK9LaZsQJUND+Z9llABTVOfW7dOuwmJPmrcbExJSjjFhrFv9TTQ1dQy+XCSG?=
 =?us-ascii?Q?5oU6hC/3GEcIJUsSr6tMZ+KhnYfTHu1PZcPPfK5L/wWeiUJGOvuvVQihgtv2?=
 =?us-ascii?Q?2SGB/vEl1hLWmQhikkM/gtOw2dGVyltb9O67oMXBtGMgbYCC2Qql7g+Jf969?=
 =?us-ascii?Q?VUwceFUBhlr/BRd8sxxaea/eJ7CJ2wZPNYA8SIWznnKgHqpFoyoIp9r7w1ah?=
 =?us-ascii?Q?DUhmYud5dys6tYKtSLGWJAhA0uFgzFtAiXLQH9Hfz6YaeNHguMYmUXRYkzPn?=
 =?us-ascii?Q?aMNkP0WhYMRQq9hP/bC7HtcFmFqgxlAqvobisoFKuzoMeP50MuKAMNasjK0J?=
 =?us-ascii?Q?aAw/0KOcs7TGhdpkwYgqenPCu6a6hEjDyaHNptVZmf4OZ/627xF6+S74Eahc?=
 =?us-ascii?Q?RrDBb26wXV3ZdQeNzh+PQXnu26cHYK2EYk76viNaKCTrYEsDTh5JHJm0Y1/x?=
 =?us-ascii?Q?PGxL365WbZA80StMHIyjvCH4PurkFsXUY+GuNJo+JYHyorm06llpUgGBSV0+?=
 =?us-ascii?Q?8qDmzdJcFv5WZj1OZTdg2SnMDrG5EUqrH64FgFkp4tyjrouWAm6INOuGcG/l?=
 =?us-ascii?Q?PqllcZEtYb2mQ2hYZj3Gpr3dZ8N7YXxYCVAlxOcyFRmK3sMJxSez1kZcwmJD?=
 =?us-ascii?Q?1ofRmIKH3qYtnaHKZx6OT1DIGQ9MmtMwspF1gMSnLY1NPJdaJP10B3yVK3BK?=
 =?us-ascii?Q?/Nf3GV5poj1T/bC3beST7Zx0Euz9oyi/RdpJze2/35VpA+S1HVsQf+oTcwHH?=
 =?us-ascii?Q?zhbPu7q6FQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060596e8-2bfb-4dbb-319f-08dee52acde7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 00:15:14.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+ICPCi+VRUDdhxFPgzVq9u68fhBu5WGfbqayBD2sPiP/kDXdkmdefKds/MIoNFeoIYBQchkVoZ1dAELHy8wFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6514

This series corrects cpumask formatting inside 'perf trace' and introduces
a new command-line option to display these masks as human-readable CPU
lists.
  
Currently, when parsing tracepoints containing 'cpumask_t' fields (which
are represented as dynamic non-array fields in libtraceevent), 'perf trace'
incorrectly interprets and prints the raw length and offset descriptor as a
decimal integer (i.e., "cpumask: 524320") rather than formatting the actual
mask data.
  
The first patch addresses this anomaly by introducing helper functions to
correctly parse and extract raw bits from dynamic fields that do not have
the TEP_FIELD_IS_ARRAY flag set. Once the raw bytes are resolved, 'perf
trace' displays them as a zero-padded hexadecimal string by default.
  
The second patch introduces a '--bitmask-list' option. When specified,
formatting is delegated to bitmap_scnprintf(), allowing the resolved
cpumask to be rendered as a condensed, human-readable list of CPUs
(e.g., "0,2-5,7").

Changes since v2:

 - Provided an example output of the newly introduced '--bitmask-list'
   option (Namhyung Kim)

 - Updated the documentation to include the new option (Namhyung Kim)

 - Linked to v2: https://lore.kernel.org/lkml/20260717013544.257768-1-atomlin@atomlin.com/

Changes since v1:

 - Refactored cpumask parsing by moving the dynamic bitmask
   reconstruction logic into a new helper function,
   format_field__get_cpumask()

 - Made bitmask parsing cross-platform, word-size, and endianness-safe

 - Added a new helper function, bitmap_byte() to extract bytes from the
   host-native bitmask in a host-endianness-independent manner,
   simplifying hexadecimal cpumask formatting

 - Cleaned up trace__fprintf_tp_fields() to remove complex inline
   parsing logic

 - Linked to v1: https://lore.kernel.org/lkml/20260714162947.214270-1-atomlin@atomlin.com/


Aaron Tomlin (2):
  perf trace: Correct default cpumask formatting to hexadecimal
  perf trace: Add --bitmask-list command-line option

 tools/perf/Documentation/perf-trace.txt |  4 ++
 tools/perf/builtin-trace.c              | 75 ++++++++++++++++++---
 tools/perf/util/evsel.c                 | 90 +++++++++++++++++++++++++
 tools/perf/util/evsel.h                 |  6 ++
 4 files changed, 166 insertions(+), 9 deletions(-)

-- 
2.54.0

