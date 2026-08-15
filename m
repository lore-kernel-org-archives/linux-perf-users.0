Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022129.outbound.protection.outlook.com [52.101.96.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D818DF80;
	Sat, 15 Aug 2026 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837022; cv=fail; b=moyT8rvmsyJJCmZwj8MIpC0VTjneRJ1jkfylyhEPwAmhpjR+juqzlNNRPmV70A91bQOAebpNYYE1y2AJOa85XLxi6Fge8oIyue/BST6AHAdbRzgld2DnSkAg47KD+0pDzMboTQCHjlY1nNTrKmFb1ZKSUY5fJeGCv3ggqpVLjxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837022; c=relaxed/simple;
	bh=hBFk+8xvwghwrKVkgUj6I5QF6kzzZIV4sHa8vggkNfw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DhKV+OsaS+9mWsmxdeGGRC0RHuoG8SjhaWrvkoZIORZtYCATE1MRorN0aWyCcJgKHNxwUIm/SJYvlL70sY+E816zBqbrvvlV1/fo0EZii7w3eUKsLdNfzgQNUnY2raGN9DhaxE/PcHKsVWWlbjM5mv3Qdo5oZB/ivy45Oqaxvjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHwOG1ZbX6KxlG5yA1eiOsK9fR3HGGqqnoTmxeElC+SoKAh7dHSFIOzx9NYKfVXU+yHNE5ZPHoCm7Jj1Mz2+HQOeaY8gQ6Nl+tm6Qd1MFke8FD9r5coX8zKmFMVONaSrtFDWZRN30m7ldtwK9KHGiVBo/Sa78mE3JLpg3KJPucK3qLBFgM92EIvbyEjULtZcKVif7TvGdwO+ZIOLc3j05Qb8jCBEHIrra48ndn88PW1NpPllHtkMdNxr0z8hxDUxMEdec1k9OW5w/xYbQ+NMUUe1/TsXWkeXX4eILoYBBV4CkQI2VCpA/PFVaBdfCPwPstrGqVaA1X1LpUumeg7HVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Mj1MjUiclUIwv17X1lzrIgDSAmuh0m+gqlz/K6yZz5o=;
 b=efXRce7mvCN//xeBHRVOxCCI9dp+CB0x+mCpGHjYBlesdxc7aHDsa2q+V99L6A3AUjKo+eHHiBTg92cPPhuoF68fOpc/zqOFFhzGKpPFHy5tU5vmR+40v2hkWCiJgMLw/kye3GQdBQOHW7RfhpvGzG75INtvsZpKjmniYE2FuSE28jrrqRBcJlPQysAWZ9bxHO2PlnAGFJw+o8G2gyiOjj/4VcbxynTNwy8td4TzHyiuCy8+S6a2XsRI3d8Qxy3Su3HEDBX9flCSSro2cpLtp9h75GSg+kCMx9XorN6NYeNNLSwIt1dFbgHc1VkyPMTk569uiTE6at+1KnbNdZKVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3254.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Sat, 15 Aug
 2026 23:36:55 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sat, 15 Aug 2026
 23:36:55 +0000
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
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next 0/3] perf trace: Symbolise kernel virtual addresses and function pointers
Date: Sat, 15 Aug 2026 19:36:48 -0400
Message-ID: <20260815233651.527936-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:408:e3::26) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3254:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e19def-7fbc-458d-d8ae-08defb261706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	FShkOa3lgmO1QEk6pEJLDgxwA1IavlAOrT80BH7SC1BRFLVerz7KcuH6Zsnyovnpj9wZkloOv0b3NYqs9U0c/6qA9ynx0CqRSbUTvw7Zr373amkGsElcuipGr+aIrLjyKq1Qgs+/1BGFFvHAFggjWmhbpM4/U6wEjgKCukYiVRHjs4MUji8lw8TE7uazphWglr5E4QzHIvntV8XGdd5k2rwyG6re0f34IbPF+jKCMs5sHo9GMMp3/7d6gDunrkd4fPe4Y1joYO6gh0UQRcLvuVCPeYcQY9Dal7394tIoeMU3TU4mqHEDKQvdKYfpFS0ldemyUVwME/AOULVDQtZa77ZQIejLtW7mEd1VlwqNh7EGEFQHA7ZZIPtjXtlo4CeG1z0yJ4xPweMJQfgPjteIjyVBVGfjOVkhcsyGgkcUu5svec1F/iuNcS9Gw4p3U9JB4/lgD//WpTUbmPIz1cV6e4D/fmxUUgvSqGYYHXacp5s9pArZqRCdemvQmn3o6ClvyirqrtN6oUZLbJEkEJI7/uIV3baI8l2EDP4r6pMf8f2PewnWskoYd/JqoAg1N54zd+0jw00dqu+flvQvVHBd/i9+qf6zIMGNn74Sn5j4xyjc3JAppuiWBJ5d5r3Bv23w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w8TLHfxq/lEyifOtLseqwrVLsmjUYdXX4kXnCHvHuUuGkOn5hqiFEnOjlY5G?=
 =?us-ascii?Q?ykTXg8UlwDTJVrd84IGTpt5A0dMcSIMwPTDiulgJm4AT6TlOW7syWlsw+jiR?=
 =?us-ascii?Q?4AX+lIQweeh1HOCkdQOa62KNQy4RWIdQT4JhSdGYcfyjQOY8unfdO67lYT+i?=
 =?us-ascii?Q?IkXc94d6hIKsSMqyJFonLa7UuF8Ks2rtNuUEwjZyzYUTQDsUEeFedsDeTyzz?=
 =?us-ascii?Q?UVlq99IbUDBke6zoMnHu10abdT3rIhnv7OXK8x2JsKZ74PvsgvrfI1JOku1b?=
 =?us-ascii?Q?pTWGCyl10qgEXdsxRHJLvPM8stJiUqy5v5s3YN8OtLplULEgAycttrTdg0IO?=
 =?us-ascii?Q?qQQ0e+qdodNIqqVauvhOJWoQqgEj1qWfskFNzSeexMxJ2wfrQWiAVtqtmBAD?=
 =?us-ascii?Q?lbSNzr5rkRG4gm/u2yl0K6Mvwi8OLCYvy156qv0cTfHT6Jce2LH9XfMaqK5p?=
 =?us-ascii?Q?xwXzQGP9f+sgGax6bVzYaR2qdGG2oI3f9rlk7oaNu7uN5qy/qzjYAGTuh/GF?=
 =?us-ascii?Q?vEJiVszFUHQ4ebaAHorVCc/Mq8AlwplIFZG/tJjGNpg6hEhw8VKNAJehs3gg?=
 =?us-ascii?Q?lMNArTtFJpkdeJ+Zt8uaiw3dyS3Nmd/Xt/v6tXp0mtBnHIlWZ1PncBVJ2mMS?=
 =?us-ascii?Q?rQGx07o2soPjwQUSOgtWrBT1h0nfPf7zTYBwtJmhMfpCVog6AabSlz3dvFfN?=
 =?us-ascii?Q?excqqSl/uTsReCptA3nMAG2FTsGZpfFuR5M++1MrrBVkz7UP8fpSigkESaEt?=
 =?us-ascii?Q?jvxKFjXuh5Exbfr+4a2MgOvQhHSv6KCtSZy7JpdpkR6iUzZePwB3sR5ccfXS?=
 =?us-ascii?Q?kNdgtiRTDwbmLIuZcLF8uCQ7I2Yc7f9SgTSjhQv2+72wLQDEw64RhnROpDie?=
 =?us-ascii?Q?NmaQ1NxW2/tRKWPGOv0dCAfUIsaMl9fxczha7OI9cgMem2tgS4n3LHMx4G+l?=
 =?us-ascii?Q?caI4RE5gPpRWowWy1bxd0PTg6BDqZEORuB2C9xkWiz/gTilUshMnzcLHsZHT?=
 =?us-ascii?Q?6ncAAQfdXYE8tbVmMlktroy2pck5fbcO9vRvc1+lKqZOaHlS2BKGU9hIIHWU?=
 =?us-ascii?Q?I//YZ7EfWVPjdBXoYRcZmuyei46TQ5dcVVn+0VjuNKb8ePU8aoDw9rbKMpZg?=
 =?us-ascii?Q?zANKBo6ROyaICEpJKzgP+gFhkIacdW8pTs3/6CJLgbMsmk3VHwVN8l6DOD+k?=
 =?us-ascii?Q?J+YStflBoIg7yGYpxNUWBajQTSyJRqx25ZmdU48AnsAm7sFzfNQjamxAx2R+?=
 =?us-ascii?Q?nmTdhNKAsFcH5WIv4EgSLwuMuUIQFlhDCZm40ALG8VHh9zqEeRGoIRqm20jp?=
 =?us-ascii?Q?chE9BOAzIbg2TPTADUAMXD3RQ49F2AmyZZcgEonBQC9HyJGpVMNsUpboWJAF?=
 =?us-ascii?Q?pMPdG2iRJ/IJ5RLCaQmNsPjHIe9HHe422aO79v7B7ApQS5PdiXmJTNYkZMCJ?=
 =?us-ascii?Q?CfGhs7TKVzqm6zpDa7wpkgfJXseVyrw2s1LqgkD7u1cW7HackINXVaor4ETj?=
 =?us-ascii?Q?eLg1N706jpUJkFNQfhD//UnUYyHf2LdvQATjtv4PTdXLEn1UTIVa6ia/vRAK?=
 =?us-ascii?Q?8eMF4HQ2nZ9i+lp7VFY4D5Qn8T0snJeuIPnml/Nc/SUOOvAD81Ewa6XZ2Bho?=
 =?us-ascii?Q?jefq69fqjeIbY5v5fx71+L+lN/mK4no8Qucgg4P9U6OxJb+EJGQNOiYkTh0h?=
 =?us-ascii?Q?TxRvi2RJDa39YgGzbcdrk6e4LK12XIouWhLqWcN5edKeZw50iskg3JF3V5Qp?=
 =?us-ascii?Q?KXm3WTTQZg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e19def-7fbc-458d-d8ae-08defb261706
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 23:36:55.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlgtvTq0fggMKvn6FSH80mt4fVVFOQZmBFXt3emYPfWb0C+t+RHptQQsZMqPGwDb4XXcYEZDBNFPuempBrDeRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3254

Hi Namhyung, Arnaldo, Ian,

This has been rebased against perf-tools-next/perf-tools-next.
Kindly ignore the previous submission [1].

[1]: https://lore.kernel.org/lkml/20260803210842.245789-1-atomlin@atomlin.com/#r

When inspecting kernel execution flows using perf trace (e.g., when
monitoring workqueues delayed work items, timer callbacks, etc.),
tracepoint payload arguments containing raw kernel virtual addresses are
currently rendered as hexadecimal values (e.g., 0xffffffff81234567).

This requires manual symbol lookups against /proc/kallsyms or vmlinux to
identify the underlying kernel function being executed.

This patch series enhances perf trace by introducing kernel virtual
address and function pointer symbolisation using perfs native symbol
engine (i.e., machine__find_kernel_symbol()).

    Before:
      workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: 0xffffffffa8046b50)

    After:
      workqueue:workqueue_execute_end(work: 0xffff8ac2c420f270, function: wb_update_bandwidth_workfn)

Patch 1 adds the syscall_arg__scnprintf_ksym (SCA_KSYM) beautifier
which resolves virtual addresses via machine__find_kernel_symbol(),
formatting them as symbol_name+offset (or "NULL" with a hex fallback).

Patch 2 updates event format initialisation in
syscall_arg_fmt__init_array() to automatically assign SCA_KSYM to
tracepoint fields named function, fn, work, action, or callsite,
as well as fields typed as function pointers.

Patch 3 extends BTF pretty-printing in trace__btf_scnprintf() with
btf_is_func_ptr() to automatically detect BTF function prototypes and
symbolise kernel function pointers without requiring manual field table
configuration.

Aaron Tomlin (3):
  perf trace: Introduce kernel symbol beautifier for virtual addresses
  perf trace: Auto-assign kernel symbol beautifier to function pointer
    fields
  perf trace: Enhance BTF type formatting to symbolise kernel function
    pointers

 tools/perf/builtin-trace.c       | 76 ++++++++++++++++++++++++++++----
 tools/perf/trace/beauty/beauty.h |  3 ++
 2 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.55.0

