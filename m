Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D437CD34;
	Tue, 28 Apr 2026 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409376; cv=fail; b=ka/FjeHOxlLESRrA8FVBU1N7NI4GY4HKlwa3B3oUP4MC67CiY3+3FrdDsEImhtKkF6uV3ZNnbzHKrUgd3EzU7WKtDJOZQ7+vJpy4h/gaJItdDnqTOrk2S3LJ4XaUVDavEzwV4nNkytrr5G68wt6ruLeh/1d/M8hTpEOF71XMutE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409376; c=relaxed/simple;
	bh=bI5QOtRFiMWeOTWPQToC4ruxZUof4xo1g6fCO8Xz8gA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=L+vwGjK1an+pJ1ib20V4XXYgDY1ZblPDZm9CHY55c69VEOD9vSKsQejwOYFm4f1RtkgcXwGySE6uk+pd6iQH1r7NjXSc6KxJqbIeZlD3Htrea8kmhf8IM9QNaTA7vJ60R6lzATrtMpYSEDQaUXsvc/Axp/myRsLqtPxDbRd7RwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=aGl+JmBk; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="aGl+JmBk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjFN2Il/cU7TDda4kWZ+Ro522gH7mwrd/8qi9bdO3b16KkDJbEu56RrMt1Vr1vnlzb9lEv1GeZihV3MLZC/uyCgevEt/vmhCkSjWmRfOWlmsPYXhM+d/PFgiHuXhFJiVl3HHI65aA9dY1iZ01m9Put7oARNF+oEXoqfbuxZBNcVhivqYiMTS46hxtwbchQqip8rrij2ssulqWhl/UJz6+Wxt1e4z6sBXBYMo/Cv/mp72Zr9hPehmk446pwiO0Cjr1guUt7IPAoM4YRL/4LgBhxRPBDllHY2sY6+itqLal57MriORjqGIrFPtnBa5xoTDaj2L4cAThQDZsW4c4ROwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K8JHXM0+GK2t5s5m9e6C5FJ3+4682IxGlj+WBnNsaM=;
 b=v+VC8esjBBn1bA+hF6KPYh5lwEkwRPz3r8TNvipADnrCmrSNoEwvaqFYOIB2/QX4Usy4sfK9QULxOU+lvw5Jm5YYVK1uzEcAf7qYbvsXVymn4P5ykSar7ldXbzg7xjrWfMJr2bBXoBTvEny3LtVy2ZGvFlubKrwe3lQTzF7v9NtKnNu3u6GSZMOY3+tfRIOOsTZRspi2LFrdTqc3oVQSqt3x1/s4wCoEFlKYpMzaLiDmt9pFToetEPSSZDcQGhHKneLNIk5X4RF5zaQU4YOqPfinK9zAYRip7zT507jiV8ZpRQJOaNBN2ZQ0gGCow9CKPIBkpoEASzQkhgnEui+O3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K8JHXM0+GK2t5s5m9e6C5FJ3+4682IxGlj+WBnNsaM=;
 b=aGl+JmBknJ2J1RnkXos0zspKUFD6ZPpgOIPr6RIX8WEdwt5rBd8sHvQP0jdtJH2vJjOJTReRyRcqOo3SLYU1+GpCKIL3/Hj9toR+USKMste1jJGaqQelp9no2Gtb5DHXC2ivktMUoRDVxRMQDVMD/5gvGcZCpB7ZkWYzwy9wvBW2/An7IfcNP72H6t/EqcMVFn0XDDbxn4U9XgmcxZDTmBBe6JU/Uengpml3j6SRoDB3eNpR3uik/uMILHTlWLRFY29ba+YHhXVKqkVBjCdVogE+DFyqVoNQqagR7aN9XKz426Ov5M0KIkAti5tFwfjTfqeFsbYU3BzxdmoTyVynjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:336::8)
 by AS4P189MB1894.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 20:49:28 +0000
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884]) by PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 20:49:28 +0000
From: Fredrik Markstrom <fredrik.markstrom@est.tech>
Date: Tue, 28 Apr 2026 22:48:59 +0200
Subject: [PATCH 2/3] DO NOT MERGE: arm64: perf: Add skip_vmio parameter to
 control device memory callchain guard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-master-with-pfix-v3-v1-2-c384d3e53092@est.tech>
References: <20260428-master-with-pfix-v3-v1-0-c384d3e53092@est.tech>
In-Reply-To: <20260428-master-with-pfix-v3-v1-0-c384d3e53092@est.tech>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Santosh Shilimkar <santosh.shilimkar@ti.com>, 
 Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Nicolas Pitre <nico@fluxnic.net>, 
 Fredrik Markstrom <fredrik.markstrom@est.tech>, 
 Ivar Holmqvist <ivar.holmqvist@est.tech>, 
 Malin Jonsson <malin.jonsson@est.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777409361; l=2371;
 i=fredrik.markstrom@est.tech; h=from:subject:message-id;
 bh=bI5QOtRFiMWeOTWPQToC4ruxZUof4xo1g6fCO8Xz8gA=;
 b=YceM1Jv58tT59cLFHBbFsGX+DaYw01ix7P00wAJFrYalAHsBxWjTbbX26lhSAbaN3TTO9E1DR
 rOpx2iuKo98AGGZ4Bw2kdbmtiYCpErJu6FksDmMleCNuw7+6mVD24b2
X-Developer-Key: i=fredrik.markstrom@est.tech; a=ed25519;
 pk=0a8IXHEgAX55JPS8VZfTf1sDp7q/oAOf459tDQd40Eg=
X-ClientProxiedBy: GVZP280CA0037.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:26f::15) To PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:336::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP189MB2611:EE_|AS4P189MB1894:EE_
X-MS-Office365-Filtering-Correlation-Id: cd13b5d6-8028-404a-5ca1-08dea567a424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YviL8IaT5/9k8bJkfwsZrRprB05ypbGIFcFiaajVGbckqyB5958N+IFh54V0J6hvC3H744/JRNgcOqQRUDb1A2qLUq4aqt4pRjsh4oS2IRXnt+2VrnyNIgy+OZNgPUvW4iPD8n44ltQdb5V5jj6ZawmSHOv9/o2SGfJ7i/tWZIKJ4v0qYyAZIdxIIPIY2PI8K2YBUUdvxdwV4jN5akJKT8Nd4m9mzldqVNnky3YrlM4EW1f2tqAlMoTLbJyG/gjAuj7+nuxwxU5aNzalTpQkaod8Iheqq6IP0b7ORxnUMm22X0jc+mWP3VveLcsMJJwty6jMzXi6Pc0GB5/YwHSMCZ30FmZyw2IBgWwY3cn3502LOIzYNZfD8J4pFsm7OOBE6rM0tkMQ9Spkpq9HwNKTN3szALXtSYU6qaH+xnVoGiNwWJ2BsDdOWF3ibGe72nzKTqF5HPtp0AjOodI/MwzKYz+uRl6udF6qjO/CBeFZfhxXVH0Eggs80tVkMzrn/YQYpfLug6cCJ4JvB4NXm9JmSA0aA46+X3ydckwGxDcmujqnUKzX39PWdd7Nvy9OLvMW+XDzIuhgysCgKGwhpY+DT1XpxyUnq6jkJnduL0i8txWBRgO6x5DEEkxX5mN+BGGI3J9YhCAo/UkQ4zwc3uTtb9rO0ElEZvGztHRRkuebFWkxyI1mMCIZPQeQEXjjpWsOCn3KL+CK/66MtXd6H8F8PKdb3bwJd+uRgmlJIC2zz0FxH2D8vzUktmFXukdLVOgbtXGWaqbnpG3Cb8zdJZdz/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWP189MB2611.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWJXbVZNSUNVSXU5ditTVnlrZG9henZnVC9semFrOXpXekx2dkRKVW5pbnEr?=
 =?utf-8?B?Qk53aXlCaXVUTkpXNXVtakNvZFFwWW52S0tYYmhMR1VnNVk2K1N2UFdDT3lV?=
 =?utf-8?B?ZEtlcklhSmttZktLZXRMWXhxOU5TaDgyVnM3L0Z6Z09TbTV6WmpEcmNmMzZJ?=
 =?utf-8?B?bXdGNEpBZTV0S0drZnZJWFA2aUhDM0wzdUIzRjFkY1p6ckJ0RU9SWFZGSDQ5?=
 =?utf-8?B?eUdpOHg5bThka2lDS0oydVF6bkh5RFc3ZU9lL3h4NGIrd0RVcE5ERHNrTGtF?=
 =?utf-8?B?QzBSRUhYRDJLYW1CWDJwRFVwWXZkVVRoOFpMdWdtNTNrbDE4dm83N1VSNlQx?=
 =?utf-8?B?bW0rKzBmalV4N05nWnVHVmZEandsVndyRkRTMFgvTkFNTktuTDJ3SVIyRWJo?=
 =?utf-8?B?VDFueERVUkFkVG5YR3Q0NmRJTXlqWjEvbzBFNmJVdmdyb3Y5Sk54d0FVMXp2?=
 =?utf-8?B?L3N1aWNDVFlNUVcweXl1NkI0RnFGTGxpMVltWWlQMkJtdjVVTkkrUWFJdnZ4?=
 =?utf-8?B?UGpTK2JBdDdKWldQQVpGSHBCMWdaYnU4OURsZXZ2QTdWNVJFRUJxVHhNQTBI?=
 =?utf-8?B?ejdscUhQRzJwQmJaYnJVK2IzM2F2aC8wUDMwcWVtNFU3VzltcmhVSjZPd3JS?=
 =?utf-8?B?TzJraXFEN3hPTkIxejMzR24zZHNvbWM5cjM4U0IrcTY3eUFUVEQxZUUxZWtY?=
 =?utf-8?B?SXBPaEd0VWwzRXZNQUJIL3BMb3FNaXM5V2FpaEVWSi9YKzB5SEorcnFtc3Ra?=
 =?utf-8?B?alFTakxUcVhIU3Q3cHZ5Q0dDWWRCM1lOa2EwQ1lSYnpQa3ZlcWtEMk55Ulhq?=
 =?utf-8?B?QmIrWWdYZTdWSGxpUjVMaEV4M2piVWJKYnVBKzRPenhYK1ZKMmdVVmNtRVd0?=
 =?utf-8?B?K0thQTY1QlNpTXo1ZU11R1Jhc1Y0bkV2djYvMWJjd0NibXN2cUozM1g2bGdp?=
 =?utf-8?B?OC83MEM5akdjanpvY3hJYVArcGhJTFlwejJocVpUMnJSKy9xMmUxc0dZMmcr?=
 =?utf-8?B?M1RHVW5zM1FsUmxZMkp2Ykw5b09NU1I2WDNGRjhoenNOYm1wOUhLSHZyNXhL?=
 =?utf-8?B?RnB6dFlYdUlCUUJHMk54Rmtkc1FUcTJCRER3dVh1dU1ZTmVMRVd5eVc4WmdG?=
 =?utf-8?B?MDBOUkdSK1UvdkZHRWdYRUROdmZsYTBWZHV6Wi9ka1hFelBuR2JXdHNUUHZt?=
 =?utf-8?B?eHh1aEFSZGEvdkY2cStTWkxtQlpaRHRCRkMwQzZncm1sbW90eXdQc2pzU0pO?=
 =?utf-8?B?bG90aGU0UklGNUdKS29jWU5tSUZMazVzaEtxZjF5aDlKbXVaNm1DMkovbzBJ?=
 =?utf-8?B?YmZ2aEE0UjZpUXY2bWJwTFl6eUdrS0d3Rk40Skc4ZFEyRTJxYXV0eWIrNDF6?=
 =?utf-8?B?c3gxR2dzYVRxSWVjS2RlSnBDaDZacTZLWHVOK3VuVWl2TVB0L3BiZVZPUFpX?=
 =?utf-8?B?RldKNDQvUzlVdGVReEszY3lSajFoZ1RWWnNEbFY3M21uMXFpUEFFalJkTldi?=
 =?utf-8?B?MjB5V1lMRlFrQ1RMaG1xaDlkTFNJaDZpVzFkYkI3ak96Q2cwS1BvZzhnK3Fs?=
 =?utf-8?B?SjNuK2d5OXIrM29Da1B2Sm1CektBYkdjVEVVWlNPL0xDWmlYanpTUGJXQ0lH?=
 =?utf-8?B?SGZWTDE2RzUwZjBBallVVHlTNHdpSDR6ZWNQT0hZOXFFNUNnUW5kN1ZtTUp4?=
 =?utf-8?B?VUJsYUM1THppQXJOaGNuemdsSkdTQS90dHhTV1ZQRTc2UTZjNmQyOW5oMkZi?=
 =?utf-8?B?WjRmcTlFYzJ0WU55dkF4RlQ4bFZYNWlSeGxIYXlIaXBtdHFLWmpYZjJidmRL?=
 =?utf-8?B?TEpsbERwMEdwaWNHSEhVTldleGpJVy9Kd05lem5SL2RCYU1sdFA3bEljbEE0?=
 =?utf-8?B?YVJobHhqVmlnSS84Q3djczFOY3VoMUpKalBzNWJkbFJkVzdnYWlLMTJaMDY0?=
 =?utf-8?B?SkJzcjN6eklDREE4bmRnd3cxcWtzWkJDZHhuK0h4bGJyZ2tMcVQzampVZVRs?=
 =?utf-8?B?U1JRV0IyYTZZcDNYUzlLdG8vK3E0YW10aGhKNkVnT3V3WSthSTMzUUJzaDBW?=
 =?utf-8?B?UlNKN0prVlJ4WDdrUlhTaUJjTGtIY1I5ejVNNmxPZ2tPN0RyeldyUUJmMkZv?=
 =?utf-8?B?RFhuMGhUNDI1UHBjdjhSYzVBa3NYVWs1cElBd2lYc3AwYUlWK2xuYnlmeURa?=
 =?utf-8?B?K0xDV05xVUJranowbWZ0NkxRZmRHeThWbVdNRmdNU2lWaDlIYi9mc1R4S05K?=
 =?utf-8?B?SFEzWW5YWHFqRndBdVo1RTZ1WFNBcmdZS0VDSG9QUzVFN09jbk5LdUJEMFJa?=
 =?utf-8?B?ODlTWTdTbXJjdTIxMHJXcEk1b3h5Q2FpNlNuNTV3dTNoeVNnUkhtQWQrcXp5?=
 =?utf-8?Q?hKm4Lf7NMTYQS724=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: cd13b5d6-8028-404a-5ca1-08dea567a424
X-MS-Exchange-CrossTenant-AuthSource: PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 20:49:28.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyhBfuNku2Q4EhUANBftoJ5J76Qdyjaf4BfLE0fkmpXE55Eu0YLqJvRx7wEarFV6PahBcFm+XevaC2+7BBIVyhEQQxRLQ68mNa01s5bDlGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1894

Reproducing the synchronous external abort that the device memory
guard prevents requires disabling the guard at runtime. Without
this, there is no way to verify the guard is actually needed or
to regression-test the crash path.

Add a module parameter (skip_vmio, default true) that controls
whether the guard is active. Set to 0 to disable it:
  Boot:    stacktrace.skip_vmio=0
  Runtime: echo 0 > /sys/module/stacktrace/parameters/skip_vmio

When disabled, perf follows frame pointers into device memory
regions, triggering a synchronous external abort and kernel panic
on arm64.

Assisted-by: Kiro:claude-opus-4.6 [kiro-cli]
Signed-off-by: Fredrik Markstrom <fredrik.markstrom@est.tech>
Reviewed-by: Ivar Holmqvist <ivar.holmqvist@est.tech>
Reviewed-by: Malin Jonsson <malin.jonsson@est.tech>
---
 arch/arm64/kernel/stacktrace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 6426a307b8f86ae756ea444247ae329591a89b4b..ebe909012e4edee7bb1ddbebac2d3c49bdb91665 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -11,6 +11,7 @@
 #include <linux/filter.h>
 #include <linux/ftrace.h>
 #include <linux/kprobes.h>
+#include <linux/moduleparam.h>
 #include <linux/pgtable.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -112,6 +113,10 @@ static bool addr_is_device_mem(unsigned long addr)
 #endif
 }
 
+static bool skip_vmio = true;
+module_param(skip_vmio, bool, 0644);
+MODULE_PARM_DESC(skip_vmio, "Skip device memory during user callchain unwinding");
+
 enum kunwind_source {
 	KUNWIND_SOURCE_UNKNOWN,
 	KUNWIND_SOURCE_FRAME,
@@ -616,7 +621,7 @@ unwind_user_frame(struct frame_tail __user *tail, void *cookie,
 	if (!access_ok(tail, sizeof(buftail)))
 		return NULL;
 
-	if (addr_is_device_mem((unsigned long)tail))
+	if (READ_ONCE(skip_vmio) && addr_is_device_mem((unsigned long)tail))
 		return NULL;
 
 	pagefault_disable();
@@ -667,7 +672,7 @@ unwind_compat_user_frame(struct compat_frame_tail __user *tail, void *cookie,
 	if (!access_ok(tail, sizeof(buftail)))
 		return NULL;
 
-	if (addr_is_device_mem((unsigned long)tail))
+	if (READ_ONCE(skip_vmio) && addr_is_device_mem((unsigned long)tail))
 		return NULL;
 
 	pagefault_disable();

-- 
2.51.0

