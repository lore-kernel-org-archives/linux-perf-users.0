Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3F235045;
	Sun, 16 Aug 2026 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913971; cv=fail; b=SorQtRAkmXEC9VZJwv1c4h65rRrS0cS0rgLhDmRB6nTvcts80m4eVISb9ZVVaWaWlr0++Rej7t1mHamxniRyekhGjD7jeKLromBu2SXDy4QCzrLAK3c8QWJ11ZeNJ3LkihPykgCNZd0bF9sj/Ml2L5sEFTt/7EycvnI4cnikxXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913971; c=relaxed/simple;
	bh=+U1D6pScWcfSnkmqg1/bOoxglV/zhFCNW7RzuJ6vzbM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f4x06u9GwPueYRfWTt8ZhoR4NR+rqNS9YyQC1kHbgw2yZthtt6y6cOhCnkODOqSVpEX8OT6Z2u77pldtgQL9vRmzncLm6BkA1g5ztSXldnODHK13VtO/uamSlIGdJF+Z0D8C8BS31HGekhFBce3yDTN0GOvcvO7/uUBwG/ASOP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ia+MeSPoxXZUGyEOqcmo23BLAW0cmteMag7ZZcGGfMgBPMCYeDpB4pBKRmTa13zoh18PAH97x9Kyu76+YOTPlgCixqLkN67pkXRgtQk2z5bQ9oVHf+nA/PnB4G0S9JgS74s88XzsjSGzk2P5FXlHB4eEgAVIiqwQ82V2LAOczcFHYcpS2UC48mZbLR9ThlmwdwaXaIfe/NXvJ3JwB0LeMjW4lRlOFMMfML/JCVUFOmKov/fIdO4RmvocS69pjlVaVPH4Qvf4FXPTsxZ+hFsrg3VHYHFoafTVpJEw1fo9VZLF/PhevVc5aqj4cqTZODdqQn6wTdQVfIvwtk5mWkEJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=GMDH0DKYPRCIqlGYpdocKMxamZrSQ8So53AFUUiXTK4=;
 b=CZsE4ij5H7DZJXFP6g56RW6kcBDVWF4PDgG8iLjkK0RtL/ZXvjQH5nCneqO0kMA/Jgw/5wC0RrYXsRyNfful5Lo+bnZoCW4iNkSAJAL8WtHxPyIvNr7P1xW9Tn0CEC81QnB7eu8PyQCcr2AMiIJ6heLBroD7PNBxcw7PNZpyhThaaOMvb1FQglbPm9cBsbOEauvbDAHIUByvP6oXlDTVDEWS6eOXGcUrkCLPI789AbhJD4VQ8uVYlmEHJ21jwJ7peYMli68pWjDot6oLCVCJh/rbHzsAzzBVSf8DVSum+7kEGnfKRRNp5niB6tXme1wkXVO7JkavTEswttn7vyMVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2682.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 20:59:26 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 20:59:25 +0000
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
Subject: [PATCH perf-tools-next v2 0/4] perf trace: Symbolise kernel virtual addresses and function pointers
Date: Sun, 16 Aug 2026 16:59:17 -0400
Message-ID: <20260816205921.576365-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0520.namprd03.prod.outlook.com
 (2603:10b6:408:131::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2682:EE_
X-MS-Office365-Filtering-Correlation-Id: 7655eeb0-cfb6-42f3-831e-08defbd94121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|3023799007|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bUUoQ5993AhQPIXm5+O64JGgSrDjXCr2yHibzxJ8ckETYIT3w/Y7cC88RaZME/6rn5ghfVwf7JlN+juCTffSc3K+B0UdMtHJGK/ovKJKTn3Fch81TDwCgYI+4GCww/1pjaCsZeQ66e7MTn8vE8lTOKFU5hJ/Fe7er5uk0u65O5jSC9SJr/NxsGHQ0b0gq8SDGP61RlhjltWxZwfvkdEgWp/akP/iP7vyZdKMHNuGmzYexfg/N2uAENxeqcfUBW5ZxP7vAc5gi+33XeQjZ4tR/ByMb3QbbHy/gWWvXyyItrTc9Khs1aqEc0eq/gnQpQleCEE5qd6dBcDCuM2rUs2hDY9/PUHolksBocv/FjwWN/liJD4RnYSYWHjHQ9aKDMBanILT5e4m9qDxPmdZekgfUxJL6qz7uhMt0FfsK+qdUVkwG5wAXqkyA4UqnX7Et6rBte8WPLtxBOPOCbuPy0xjN9tZUaab1BiHTOrjd6mURqagvNof/3FSivFesU8f3FCC3zOiXM+NOPDSwNnYEDK2SMu1b1y3C9JMh0CPM+NKCdWXQP/yL8XzXmFiLWILR0e4hHSUFWN+AZgau4dOsO21u+kcr9VzSyQKoS9qIQOJXrRLlwlFDpH2EecsOaDOvDHxFZkYdQMG7VRS7lmwykhGh9JP/H76VmF2fIYIwDKDgZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CcQrMdRepQaHFLLs8oAa7A1sbdThBASAQ8RUnB0Gw8UxJujT6kaMemeiDtIp?=
 =?us-ascii?Q?HJNRnfa53W7P1qhIooxg9TvnJJhHuZ+6etv1/xoIC+D++mRCnpqB2xSvwf92?=
 =?us-ascii?Q?CXQrmWKvjwCZxtezJV5di40X9aVg4AphGMiGAMm1ihPfMZTZnYa31GaolZ3K?=
 =?us-ascii?Q?69XReFAHcrhRFKlfu/hV+oRdqshwBoTQVqnzaQKsPhNyw1q+HHN4w7/a5+fR?=
 =?us-ascii?Q?7XFAkuet6D873r/i3GkkWdGWpn1UN4tw9N+xYsdEMqdS+5NbLxVZqjEwPAXj?=
 =?us-ascii?Q?43OTP8y9QAqW/8N8t8q69iNoH2+46qjljET6XNFRaLX/mkjyMw281mDMoBNQ?=
 =?us-ascii?Q?kB1RcMXzzzX8LStEv0bggcatViFIOX58XyLhfIrOhcFazc24v3RSnRIK9i8q?=
 =?us-ascii?Q?yCTFEcCTpWBu/9nlzQ+HCSpq14+HRjeuwbfe+nSqu50MO435YtmooRpRF7um?=
 =?us-ascii?Q?H+nGZaJ/9JwWJfUgc+SSZDLfNEmr4K6JI+Ktc9J+8HiOXqmyEY5T0cO3zGYu?=
 =?us-ascii?Q?aLgQt8OhugQzIB1MT5GDaT72PJLnlqY2CcDsj3OEwd2ZeAfpPYvWJZ8vcO98?=
 =?us-ascii?Q?6GjHVkxh6n12/V/HQVAQvtc0cpb2vpyRzOsb6CNtgnIv4gAxscYNeecPg+of?=
 =?us-ascii?Q?nNfyYcPu0E3BiG3ogZkUG8gfnceswyGma23BKCDwKRw1/zMvAxHeLqfOBLhR?=
 =?us-ascii?Q?q1N50LNrNYr2fZqspHPZc6fHGtlK9xzJGpmJsqOYme8EYoX4ParMbJDRPVs3?=
 =?us-ascii?Q?n4dJEU1GgZ5sqwHTOvQ2E7yafuES/aB5ZA8ZqHwZ/NM/6hGNBPD4sLMkR+8g?=
 =?us-ascii?Q?TAUGGuSmTdVG4lbuJHgBTLf/vxCNUy/zdLP0PMtry5mm3Y8snIos0snSaUGj?=
 =?us-ascii?Q?X9rygMFDz/LrGJ3jBkptr9XQFZ4b4E99uzZuwaelOjzNdR8yddBCHgtwIYWf?=
 =?us-ascii?Q?WleD/4EF7DYYTOpG4hQVadUluqcz9JaNmI0XPNH8oimgvZj1qiV7b2SIBRxX?=
 =?us-ascii?Q?R0XazZm8sI12QNj/2Hd9h8YRotpnZTPl0sRXtlutlqYyqksIuxdKDNzcRaFD?=
 =?us-ascii?Q?86y2sPTY7GD7PG3zstbx/SSDw19ErtNaUqLiS2zgqBeV7UJNoF2HWgMe0sW9?=
 =?us-ascii?Q?y26jcoih/JddYSujl47vc3cBlVFH5XdmzVFNyWajKskG+S1B2dTyOEKevXlT?=
 =?us-ascii?Q?brgp9eoIghwZdBT8FlLaVnaTXfJVFHatccQqHEEwyzlD31LuPu7KxzDaKrnl?=
 =?us-ascii?Q?QjMuiudgi1W+fRvdYUGkgc1wNn0GGnaHtt10grxLbQvDFCcpck4UfwaRuGq2?=
 =?us-ascii?Q?hi9M1stPXCINNe/75mJKpj1RjwiyjYmefBgjFpBVDNlLhkjiR3X+J58hrWfJ?=
 =?us-ascii?Q?wCZQFAO8f0GC7B9nhkmPlxVYzh/ipGHKhOjkHjwoX87ryn4eFV9HnTBza4wk?=
 =?us-ascii?Q?x1EyCSNd4g3aThAER/k4VLpZGNt0AtUS9+dh6pyGlWTljWjCHF2YrpEQip6b?=
 =?us-ascii?Q?iDuc5Gi8tstlf5pBR2d2bskCRNrRMnAlZkaKOjRFP6GXrTs7kekUEh1oNq9H?=
 =?us-ascii?Q?AUB1AG3LnFtbhRjm2rXF+JI3Gark64gCvCg85BPcl+YT3g21xmw9Ub4cynPr?=
 =?us-ascii?Q?fLQtUJgOuXQjpvkegD0LkxIZTLip242Qxj+EW76o8Ibolqi5yneqwsFRvfIg?=
 =?us-ascii?Q?yhcmmI+tzl6o0DRQ0REIg25/f0uCjxosNG82WIW+xL4ein5kX1/tpNlBRalM?=
 =?us-ascii?Q?bwu8tzEd+w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7655eeb0-cfb6-42f3-831e-08defbd94121
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 20:59:25.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wI/ckfJ8aUDIDAP+ZLefv10aK6nEDRik5JqEQGnp7bu4BU8qlRUmCRaJahvXLiOOErxvtDg1CIqaFg8W9z9nLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2682

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

Patch 1 introduces the syscall_arg__scnprintf_ksym() (SCA_KSYM) beautifier,
which resolves virtual addresses via machine__find_kernel_symbol(),
formatting them as symbol_name+offset (or "NULL", with a graceful
hexadecimal fallback upon lookup failure).

Patch 2 updates event format initialisation in
syscall_arg_fmt__init_array() to automatically assign SCA_KSYM to
tracepoint fields typed as function pointers (such as typedefs ending in
"_func_t" or "_fn", or function prototypes matching "(*)"), as well as
pointer or 64-bit address fields named "fn", "function", "callsite", or
"call_site".

Patch 3 extends BTF pretty-printing in trace__btf_scnprintf() with
btf_is_func_ptr() to automatically traverse BTF type hierarchies (including
nested typedefs and qualifiers) and route kernel function pointer arguments
to SCA_KSYM when BTF metadata is available.

Patch 4 adds an automated regression test script, trace_ksym_beautifier.sh,
under tools/perf/tests/shell/ to verify symbolisation across both default
kallsyms and BTF routing paths.

Changes since v1:

 - Fixed reference leak of struct map in syscall_arg__scnprintf_ksym() by
   calling map__put() prior to returning Removed unreachable and erroneous
   entries ("action", "callsite", "call_site", "fn", "function", "work")
   from syscall_arg_fmts__by_name[]

 - Restricted name-based SCA_KSYM auto-assignment in
   syscall_arg_fmt__init_array() to pointer or 64-bit address fields,
   preventing misclassification of non-pointer integer fields

 - Updated btf_is_func_ptr() to fully unwrap typedefs and type modifiers
   below pointer targets

 - Fixed BTF type name matching in syscall_arg_fmt__cache_btf_type() to
   handle leading modifiers and strip trailing pointer asterisks before
   lookup

 - Synchronised arg->val with val in trace__btf_scnprintf() and widened val
   to unsigned long, fixing erroneous "NULL" output

 - Added shell test script,
   tools/perf/tests/shell/trace_ksym_beautifier.sh, to verify kernel symbol
   beautification for both default kallsyms and BTF routing

 - Link to v1: https://lore.kernel.org/lkml/20260815233651.527936-1-atomlin@atomlin.com/

Aaron Tomlin (4):
  perf trace: Introduce kernel symbol beautifier for virtual addresses
  perf trace: Auto-assign kernel symbol beautifier to function pointer
    fields
  perf trace: Enhance BTF type formatting to symbolise kernel function
    pointers
  perf tests: Add shell test for kernel symbol beautifier

 tools/perf/builtin-trace.c                    | 103 ++++++++++++++++--
 tools/perf/tests/shell/trace_btf_general.sh   |   2 +-
 .../perf/tests/shell/trace_ksym_beautifier.sh |  52 +++++++++
 tools/perf/trace/beauty/beauty.h              |   3 +
 4 files changed, 148 insertions(+), 12 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh

-- 
2.55.0

