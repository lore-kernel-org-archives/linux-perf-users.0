Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021120.outbound.protection.outlook.com [52.101.100.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB327BF79;
	Mon,  3 Aug 2026 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791333; cv=fail; b=DYXm6nCZIzmVCzVTYp9zcU8/yhM65cKLfe7ZRMItWMFkUXhm0eG4dQOrO7D/yaaZH8egc1473BOw7Vh+cs3YhZ4JUNeEjjP/EDIyoF4/aPcjbKTUYlvCJhpOA4GIyTodOcNpAB1fK+ccfaMy9GB1LwRTeHHEtWOwkWPgCUYaIsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791333; c=relaxed/simple;
	bh=Zd7J0EMQ+v++8rXzw55KDjiWp6EDjD+LIc8/nfuyIbI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fo5i3wLc3llDnq/BR0BnC5lUIpPYP5W6gtmp+FeALBKsK3rfEhz+axyDGZP6L5LnCbSf0ju0gXy34jhSGEWCsrms5+DnCHYRCPY+Mk9tJGOHGY3G+h4ZICUtvOJdT8hvwAqpO/AEd4wIf11FmFHmL0NRIYfb+48xF+6F5maZhy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAHG5EaLUQ2RT8TGoj/TiD0seifeZueHI5x5CyxrsBTYENaGcEf3ZeWeL3izyuwq/JEi5R3iDHOrygJU+88h91F/d3kHnNz4gxe89g4omaTaA7l5ewcJhv6NIyOdaV4i6tldSZOp1wA7W44zFUrqQRMjEdCjgetQIVphlWvVEui2YqN3TibFsM+R8WKF1pEDZuGWomYPSl6ArF3eLYlSUrPqFrSbSLwSvUcs13VkkLZAtoSQivAXlN7OjTvDGswYLGkjUFkNFLiEaLwyRCp17G+f51agpdO8sGFNgQEwo/Fxz9z1ZAhKavNM4ZmwBONu3GJvf3XDa7bF2dSIuoRqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=bdmZ61Vp3JD5UsP1A5uprsVeZ3+fNBAffVLiJdACcmw=;
 b=Lfg7ARr1J/iW/2UuzWYtIIAl+WVx8kuh+fxbNp/30X6o64o3HAN6AvZt33U87CMC+qgIFvQFLk2lVX00FL9eTfVsHPsbRMVrLDB0rUfXhBrvYBRExoQJUYAybhKWRlbeA5Q33e/LWPqASALQXD+hkB4hnU9ac5FK3Fv4ln2GVvQ48sUpXSZMuFBj6wv336HxFtUr3KZDO91qrJ812jbEKUfXgEb59doDjg3raEV/3102nlvF6zUYva9YneNunRiBAbDWBprN181hYhWFrJYHTYL6Z39v85BWkPgYnkyHCMhyTAGBfGAunUrHP1t43UaK7l/tbqbAvnkPbDDf9bAAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8695.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 21:08:47 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 21:08:46 +0000
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
Subject: [PATCH 0/3] perf trace: Symbolise kernel virtual addresses and function pointers
Date: Mon,  3 Aug 2026 17:08:39 -0400
Message-ID: <20260803210842.245789-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bf6ccd-454a-4530-dfee-08def1a36828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G//qKSgBfZbHSPMKHSfULzr8Wl3f+XA0RreWznUBFbFx5YFxHKPkn5VRkKMX9iUKpPvsFalYnJGuE2hjNOquUibFI+BmtPXTOm1h0CjW5o2pySJynBjvlcJCqmguJRx0LC25YiX283kGDm/zd4+XGRqKIlKnk8UaVZfpnxVZsfba1PQ9NT+v0kOOjYIcbZtdityI9dq9t0LaGnEGxrCD6RH1By0ELdYMcWAYEFmKMw8qe6I6RrQGlTpRmpuDEKKXnktHKOk+1ltvBosPPVueQ3wunPJJVmBuXROTBCtsYzj02EkcUFG3ywgXG1emp3/zqpkmm/vixjyPoc2lqaI7qDyDdNqHYMDVKPnJI7giok9jksaRe17eyaH+Z7JpLdSzFXPGHoJ9ddiRnL3xkmPILzbrkLNHXBC3QC2u7BO1G+WagWRfFOMVD0bFc4p/Z6AnUmD0sUpN87nsxBmnEAhwz6XG8lTSYBpKwuu/lS9lmqPu2qOi63tc7tTOBqBVNeUEAl//LP6HNq7EXWiF2GrxnNl2V+s83qpIs6KAtBCjvE0YL0dmowGB30tP1fQZcAI5PnQxTkLSALL8RkCq8NsLhQXHpYruAPEdu+4oYJRJLOtj/3jrbQh/BY38tBVepzlz3Vh3lgazvDONdT8pFfEkmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kaFeoFWw8HNV57cM5+ZWoOacXnGyPNQdUb+/gkWfHtGaFhMuSdyUC5/tOkNC?=
 =?us-ascii?Q?M4JfkQhggW6OOrWIHY3uCrAA7rTbgAnXE88xMgPC1u3Zs8LwsXIZgRH5StRc?=
 =?us-ascii?Q?NqUcGndHlZFFQGTUqlIhHtYl80fbD3KIP7XlMYn7Csh+goYMlqCv5utRWw3d?=
 =?us-ascii?Q?ENTSZ1WUa7nweZIH0EGQYF3P0W3yA+0ESG/qw0pAcEioBRpXDqwwqFM/YRia?=
 =?us-ascii?Q?3SykbijKDxd54d/+dUWpASmlXI3dYZoELzNynSoEYXMpLPpHB68ndNHuuJlj?=
 =?us-ascii?Q?U/CeLiiI3Rlvrtlq6l/e/eQH9oGtFg6/A8373vNfifxY7+BCpUDmyqBtln63?=
 =?us-ascii?Q?fLO6HUL1hw9LkDLyHqu4YPA5REN9PlQGJ32CKd8i/LZb8DG11kGkTF4nm5gx?=
 =?us-ascii?Q?HcqVaN+SkMCKCjbvjgt4FxH1DAlS/IZX/PxYP/ebbFrq7E8f7gAM+M1Lt0oe?=
 =?us-ascii?Q?mP6ZAn0kZ206vwLuruYPDyQpAcD+pOJzQ+dTyq4U6B0XV8p52tsXnn9zFykU?=
 =?us-ascii?Q?chQXua0K17d2UYaCDnm2LkvSqTHgL907GQ+yPDiAyw4W0Oqb1wYfincdhq8+?=
 =?us-ascii?Q?yemxkFkD2SJgjhktRpshJiaPbcdgN76c1z6lYkz8tidRRDi8VE/KnqCTstWV?=
 =?us-ascii?Q?KOC0s63gts+DGUgDeJbJDrVr1BB6OZeF9W5KvujaqCrRxwKjRnLl7NAKuSD8?=
 =?us-ascii?Q?XFYlPApb9RwiT++FGfyBb9lZg3POPNuhEtgneEwv6llcTQJgmeFbfOgqEtlh?=
 =?us-ascii?Q?XOi75JkrGQA/aBWybTtvVyzrt//OVO6draWcMZu7OIiH13alD8MqsYoISJPr?=
 =?us-ascii?Q?Q/LIwlg+GBsDiOpJ8QWV0RrLbIE8p5YBcCph8Nw3SBLZNXeAVXnnHl47/Q09?=
 =?us-ascii?Q?l/gHpekPAoJ3s14i/Kli0xK0u9+iqXJ7Ns4NhqvwLJROnDhuSMavQbxs5YTL?=
 =?us-ascii?Q?CJPuGmmV9oAPAVnd32C3ihgHbWPr045fbCFwcj008zDdSYUL9n/me5joaFI3?=
 =?us-ascii?Q?qakZeOillnkv/OFF7ASQwteDpRwsefJvzNCWBfzSLq+eaGjI7pCXQwWdbSjh?=
 =?us-ascii?Q?F9Z6QDCtW2b4zXSrrn8ngnJblbQreSyD/CPYRmpP7WAMnAnRPYsgQpdvVPit?=
 =?us-ascii?Q?WY4yp85sa89IT4W73c1KSCmN7WKTmty0pbi/ofdGNRJnyLsDR6E/HT4WNYI3?=
 =?us-ascii?Q?fmztLwrBVj9/R4+QRW53FW88HYwU++vch0ph7J5NRLoaxtom1lV3fFJ16/ZQ?=
 =?us-ascii?Q?n4yvKPwWK+D75DmMArg8EXatbVBPasBuyKXycq3W3bXcYUTlpIdAJgdmyHC4?=
 =?us-ascii?Q?tT3+oqWv0RTm4Ga1S4HMmFlvx2F0xtwNrmgLeFs/A5EJcE0KFWv0+L+lo0by?=
 =?us-ascii?Q?oHJo+jfRNYpgxVzWNqWt009lECOdzEyEp2ZOVJ7lZbjywXQzTuwisUlC5AVq?=
 =?us-ascii?Q?FhL01G5WHmwZoDfmpdpjoNmAl3/Kz2785IPBpIW0Hrqv9hr2zovcu6Km8057?=
 =?us-ascii?Q?lukc0zvx1SRHk6qx6dFgMxingOoutiyxF7ogJZBbXPVPbtwSnFKxbevnHyrS?=
 =?us-ascii?Q?bVHclGqGWbL45be6Z/gwRKhfNiooYakHZNIbl65N7EMvZXHbgiJn+Ngd8Ge+?=
 =?us-ascii?Q?nu5668/iImJngcI53k3D1cQgYOjQp7GDdVGZtKE1N2uyC10hhLrH001zYxGC?=
 =?us-ascii?Q?61BSooCzFHnff/RYpOLsOvBKgSkERucy8IXrU5cMp3FUu52yE5c40TTqaQkL?=
 =?us-ascii?Q?l9NM8cdRcg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bf6ccd-454a-4530-dfee-08def1a36828
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 21:08:46.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+sEpBUky4se97jb+R1V9jBnviALliwU/3TbCGlFT7YKF/yO0VIzMqUJt4tepJY4qvMuExdUr+35d4WsExn0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8695

When inspecting kernel execution flows using 'perf trace' (e.g., when
monitoring workqueues delayed work items, timer callbacks, etc.),
tracepoint payload arguments containing raw kernel virtual addresses are
currently rendered as hexadecimal values (e.g., 0xffffffff81234567).

This requires manual symbol lookups against /proc/kallsyms or vmlinux to
identify the underlying kernel function being executed.

This patch series enhances 'perf trace' by introducing kernel virtual
address and function pointer symbolisation using perf's native symbol
engine (i.e., machine__find_kernel_symbol()).

  Before:
    workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: 0xffffffffa8046b50)

  After:
    workqueue:workqueue_execute_end(work: 0xffff8ac2c420f270, function: wb_update_bandwidth_workfn)

Patch 1 adds the 'syscall_arg__scnprintf_ksym' ('SCA_KSYM') beautifier
which resolves virtual addresses via machine__find_kernel_symbol(),
formatting them as 'symbol_name+offset' (or "NULL" with a hex fallback).

Patch 2 updates event format initialisation in
syscall_arg_fmt__init_array() to automatically assign SCA_KSYM to
tracepoint fields named 'function', 'fn', 'work', 'action', or 'callsite',
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

