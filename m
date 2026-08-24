Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2494316905;
	Mon, 24 Aug 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578298; cv=fail; b=DgaxyzCaZu/U1DNKvPiReTnLXRu/121rBrn4eqGbh/WyA4Za1Ck6/UpJ1p6rx+CIZqEJP4Xr0b/8AKsL28PzFMqaIXNQGmVKupBQCNst9sGM8e3Pm+DH6VUsBYu2sHgu8bcYsxaCrUdXDQfiyQRx6FYnyOOx67OCaYcbojVzJqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578298; c=relaxed/simple;
	bh=MGRd9NWdwHk9p0LM7n1/6EFNeiuQdaFpMI151FNP4g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qULD10QE7jNth3Vb6Xf8T+jYVSX09b32XENXsC2hSfFmnxysT55Mpk2JGMnJNReR4QSlVnEqoK95xhH/poredv2CRi5Gj8amLhcCnaKmhNadhxeCQDghIVP3n/Knerkttzr2douiYvoAr9IVFe0FXxIE+5KxEtJhqS4OnOogiPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT/GeXd5NxAHqwGeTf7DDOngNytEJBrUHW+/jbRRB64gPvG5/w3tWJHUatAOJiMfHVM68EBtR22rSsXcC0Bkg1gcOkrTgoDkrf2FM3d4XC+yjsrOMWeGF+4QHmqwvM6IjeZ5VJOo1X4UHkSrEqdFAjPsKwSC7qO0T4cJnKFkfUzXABm15t29H2D0U4lf/RK0VV5hzm7BatmpTkMOLseENCZASqi2gn0OELeCuz0ZKtrE86CmM3D99RdgI43vv0Or9OwyzOv+V8A8ONIPxlIhfO7RFimB9dnOSrqnicdUnZtGoByxmrALv3BRzY3NU2tvc+2aKPDhug9MlRswhj3GzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=vxreZWh59LFtD5z0gZYQMEf99hJKezsTArgfe3ZFH54=;
 b=loHkKKCpvz3ov7goHKJZFtLxmcdm+xqYasLm2dByQevxKIavWYJQAY4jN9/51q15rmeOCLhjxxNckSHG7JOZWYt97EERW56o0tBnnUQDsoEOkF53oQoFZXfmDPOGpYHDz4nNbFFJ35pXTwrRsH/5KLznA/EFZHtpdPpdiLUFujTRKo6dgUIZz997dZoZnaFaBEccB7nID98TBJ0HBh36RCh8L4UCnXycIj+sfyjHWbr5BHOA8jCTFHud9lgxav4DA1Wl3v9sakpAN05JkyklRBkGpCVtM/jsbnGcqlOjddIz+avNV18o9qH9QCKo6eG5FTz86XQn1SXEWvJpO5Qg1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8950.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:271::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:31:26 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:31:26 +0000
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
Subject: [PATCH perf-tools-next v6 1/5] perf trace: Fix error checking in btf_struct_scnprintf()
Date: Mon, 24 Aug 2026 09:31:18 -0400
Message-ID: <20260824133122.751733-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824133122.751733-1-atomlin@atomlin.com>
References: <20260824133122.751733-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0103.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 3897aa28-ffdc-478d-2bee-08df01e3fee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xdTBcnN162vozdOrEqllIjarkwx9mol57h+8vM5FqJklu3rLCrSWk7Fc1xUSF9Eiup4m0ZCXH4tv9UM7uEGgTm7r1YAG1vO2U/zh2CV0VSBzdMeVypskPGoEHc/bZVU/736ke1+kJrj/aH/7af+aL+ax0KPcMIXAYzXOsaP0m/4Fe79Cj3y/4FcIGKP4J52rh2FdHqwqxiFWwUOmMX0rkLIlL2F2GqoTpBYKErLR59WuSt/Dp12jiNxUamRrTt6ZieFu5Pm/Zp5qWL+AQ7iC0D2fkiBEOK4kZjoa/4Cu9v3KztroB5J6AX3Nr/Gp+Kam73hDEZR7cYLUhnzFZ86p14fXyH9TCg7lqdSIZszNY4sXgYCF7yOt2ugzPMo/eagjyhcMeJJD+R2q8J4DW2nnYn/JHNlq4lLtK+tv381ybJi4mtXvBWCs6SXik1y3c7cfnDuuuSjFgEhOw/kRd6TMv0bafz+pMJIhUX3T8dVDV+9R6M+eHdmDFlHra+GVznHHsWskE/ryzFGmIlsbWbcfWZ8tJuIlzqMzPwc+m1MeKUT7H7x0SbKZQKH4MtypFREBFNlhtdsBunkSCQ0NCJBZPr+c+WCTWCZbG5EP4cmDQ8k6G4BQ1usynZ2YJGCLNfkHTmtk0+1MHsLPqTLRHSUPP9JHutaD4F5KlubL7P0yw34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?52Ss8rG5T9y5md/E92kQyOnm5AXfKr8mQsrwnov118fd/kBUO1RaofQFUcX0?=
 =?us-ascii?Q?W9WlWFSYX/3RQFZ6ITmSbEM2P96Yb5R7pTjQEg79W+nkFSvhndwIIltx6FeE?=
 =?us-ascii?Q?ypTEiuHnd/mHlFktHmku+NxdgdYijm0go9vPz7HuFsI/wIWJ2biYdHTAlZkt?=
 =?us-ascii?Q?AbAqJR9IuGHrCNgmfu9moUTtMqoX527VnDXPqWy+z3OTnPAp1fvLJ2yGLOOb?=
 =?us-ascii?Q?ZoHXpCaBvsqNgL/3NJtiz6vy9sI8CVggtS+ydHVZVD6ao+cFxF+0eCREy50w?=
 =?us-ascii?Q?xOI2nXBM+dG6KyYeMZ6ron9zw2zeg40vYX0s3NprsuCq1A+TtXq1PDXL9OZD?=
 =?us-ascii?Q?RBZG2UlakN8/OthtOtEftZl891pkugagKySQBDFoDwzrNehw6VhCEy2F3Lxa?=
 =?us-ascii?Q?oa1keuQ13U5CUHnMiH/ZJzbAbThxsPdsdXMhSbJqtIH9MCoDo0mSDXRn5GFb?=
 =?us-ascii?Q?Myz0pPfYeBYK0lP4X5pDAhn37DoABl3L/JacSD+TMHtBLQ1m+3bh6KiAgOGz?=
 =?us-ascii?Q?h2mGxicyFSMcsV6DLLn8enjfPt9xFa1hLV/aGyCp4uyVW8JOMO2f+AFedeGm?=
 =?us-ascii?Q?tyUXsfXvaviuTG7cPulFkA2vkuyKB7o8qJw9LWuwQh0eQ0XVEIY61gQsavlx?=
 =?us-ascii?Q?nX1xckW0mIQisgUBdAd+pp72lXccf/cqC1SZk9QEZgMZEe23XYDafif3w/S2?=
 =?us-ascii?Q?NE3FNc15sSZvhiccFfoCWD6skbhXKRt+xoKnTKClfJ2yZjS2tvHfnFKTNUh8?=
 =?us-ascii?Q?0geN4/fvbWzw0ozkG7Qqz+sr4s/hKssVJQfTjmtYLQXNfF7gzvvZF0JHOHew?=
 =?us-ascii?Q?h3eS1TELLSzktroMHktHfw6bw+EvgsnRo8c3YbH2BwZZo0wi20DSF/V0fqGI?=
 =?us-ascii?Q?UccL5Fu+A7pFsK0AL4TwCMhm26whUwBgZbD0VkkYhDuGeXNoxOu4lboGY+VT?=
 =?us-ascii?Q?if/jZKgWwPtbsDSRbA067tBT70kmSWLeVmJkci+b8Ey5OahfFimRDiPSwcWS?=
 =?us-ascii?Q?UKOWqSGlmyQx2RmyvBGS5gb8QtE2elYO6ZOdIkWObm/1bce/qrBV/rSIz8QJ?=
 =?us-ascii?Q?XndmbNa3OVWU82oPcnQm/6z9hoayrV53aBhnKwZT4wxO5B9+TFGJrULVL3BD?=
 =?us-ascii?Q?deAdiX6UYcwizw+X4V6sIZjpWU3nIMQAH4pMcAgcIm46yPr+MJOV7FDvgAsT?=
 =?us-ascii?Q?b0O23gbSs4xyKmSok8twcjGtOpvrU8TEoVDtUA9UWrPLE6JeqLh62UQB1JS8?=
 =?us-ascii?Q?XI4du7DKaJk7BmdWnbmOD65/wKmJq+p9A2HWfjvAxyJS1xaPvTlnjqTF9ipH?=
 =?us-ascii?Q?PsWB6dzJd/YYf7GTK2ELkIEA0n7o2Hiviw9OnTZXoCLOwU686Hy9EJaJZIvK?=
 =?us-ascii?Q?5Ualblh1elNJzzcZKhxQIiypKXhs6y5tNRm7XsbXMvY8TwLKNr4hFzHac76K?=
 =?us-ascii?Q?bDJERX9oeajfApduL+KrQ685Arud3Mnj6fJZG44Bc4+neGYlWhWEKfdXr6tX?=
 =?us-ascii?Q?Zch1y+elXxM050qxNhzmk+j7S216s05scO9e6vbYvkdy3OewAoj6v/K4so0v?=
 =?us-ascii?Q?otD4Xdz6oVUFIP0z+9a15qTvsGyYWpQeg1N5YdJSAPl+T0vsQ2mjDJJk+lxD?=
 =?us-ascii?Q?ZxhYaxQ1/iLY9vxR7cDfdqUqJdqTV9K1AxglEIVJJnmfAN3NnWhp6XGxDBNY?=
 =?us-ascii?Q?+TMSvD2go4YPxJQ9RvCAh/sY2eG9F28rowrOHC/2HKvChtiL?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3897aa28-ffdc-478d-2bee-08df01e3fee4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:31:25.6647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jE4AbCa2qCrNOrwTDHSGzk9MtCXi01J88PXmRmJvu5oaNUD4rs01bcvhlenwRROFOapG8jyzt8K6dYqg9xVJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8950

btf_dump__dump_type_data() returns the positive number of bytes dumped on
success, or a negative error code (e.g., -EINVAL) on failure.

Currently, btf_struct_scnprintf() checks if btf_dump__dump_type_data()
returns 0. When a negative error code is returned on failure, this check
evaluates to false, causing the function to proceed down the success path
and advance arg->augmented.args past the unprinted struct data before
returning 0.

Consequently, when syscall__scnprintf_args() falls back to the default
argument beautifier upon receiving 0 from trace__btf_scnprintf(), the
fallback beautifier or subsequent arguments read from an erroneously
advanced augmented arguments buffer.

Fix this by checking for '<= 0' ensuring that on any failure or 0-byte
dump, 0 is returned without modifying the augmented arguments pointer.

Fixes: cb32035214b9 ("perf trace: Pretty print augmented struct args using BTF")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c3c7f1f85c53..1bc39f674f11 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1066,7 +1066,9 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
 		return 0;
 
 	/* pretty print the struct data here */
-	if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) == 0)
+	if (btf_dump__dump_type_data(btf_dump, type_id,
+				     arg->augmented.args->value,
+				     type->size, &dump_data_opts) <= 0)
 		return 0;
 
 	consumed = sizeof(*augmented_arg) + augmented_arg->size;
-- 
2.55.0

