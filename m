Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135793BED70;
	Thu, 30 Apr 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546541; cv=fail; b=MhYSXOKKZjgjr3NlnGQokKGYrrPRIRJqZCIaMh5QL035blGDFFnYqLIsub8SYX0Ee6QnqZi8FyZouNU/rysis43qC7xsGMuESxMd8Xz8q8/gndPUjWb1rF28ULji36XKZ8m0EL3AkYZNUOspExBY7tE+Ma95eIpv/9WVhIgitXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546541; c=relaxed/simple;
	bh=RP9SD6OW+R3UzyIfJtIbgHt9+O+k4MJRzsi9YyE5F5s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=baGgv/XF5ZsMj59lCoNS7FGn1aCZ+yendaHE9sDhtNMS9HY4j3h9dqOy8ro3F7ijGPtPnfcAg+CeSpBG99NRgXtMUl5gh+9xGmpj8btuwFiMBTR6P5SVKehDtBPElMwjtkonLXUozd4EE1fbtGacLGPnpDIJCLHS18NBpHeKCTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=JOUGzd61; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="JOUGzd61"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4WbkigktiIvcGLCVq5hxl4gEXqxJw20ixBPqN1kCdn3kHIw/xyPZkH+MU220wvgSxjFmsgEjAX6fEnFPLAQYvgGShUzI6sRmYvKIjtfxDednJd+eUgBamV4n7I1JLFbltNdhN9s/u+NQlE2B0QRpXo8JXRqpTSEoLqLqDMcTmslky077jen1Gd1sG43Khs1B2DacFFdDJ8M71MNUNmYru6YreFMrxTlQiSTpb9R0vc/MCxmwpkONkomNtZ+KW79MpTQhd9ymCDGsYm07rNqUBiRoi2bIwcXlWOxEs3zuEbKmwxo7aPpT+CnYa/XFhWO+B7N8a9CL3gcukyCTTipog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I18cS2GCA2ZTbrUJZMuRxK5qLAhwQ94e0IJv26AnbIg=;
 b=Ne0pAGVJlmsWKQcfJvWrhWBXAsX+huAnwTEo2KiO0RMzwWp+HhWuUrSEcFCGb4uh2ZAWc90gYP76T3JSPSaKe6s0slEPnL+bewAtYtfeP3WI7HE2OzJwAiyHiZlg2ImmZl3PRS/Miuo0XtX0tX1gvdTt3buwCqWKMXxLsGKVVsHZg2Oa97z09zKOMrKUTKPNq51Wxii3AXcB/caKBLbjSRGcXARFVzCZ1rmNU8z9MitIZXOOOryOAM/9KHhHjwBpQGCuJ9PdVofpNN5KvuLqUf1iEr0V/xQjC2/eZ1U+uc1OIf96kEeeZv0lSceMHBrpwHtoZcEwQaFAAYThLxSyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I18cS2GCA2ZTbrUJZMuRxK5qLAhwQ94e0IJv26AnbIg=;
 b=JOUGzd61QhXWCPcEyvXQdRR9TJksvvAEdt44tzdzjxcDm37Y+zGjxO/JH6vaGdJOqd48gs+2ZeAr9nFQPnbdW0ht08H3bqlBQrB6y6RVsOF/P9zZLqEPKr+ykn9E7FhV4vXKbsgcmVLJIRQekeeH1xVu5I2nPajlkCKtvFGThkQ1dlVPnzDxeRDZ/mkgj/edBwkYMr/hwjjDfVmU0Y+rBoV7kFD8wpFZGFQTb0I4fzt+NgdBUmdXpQZ8gBuQOV+RNFDqvZuQI79j2hbxJKj2x0If1uL8pE2h8H7XzqBYGzEES00cZM7zmhnjRtTadMxwEeo102SHTQ5h73V50bwGrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:336::8)
 by DB4P189MB3117.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 10:55:34 +0000
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884]) by PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 10:55:34 +0000
From: Fredrik Markstrom <fredrik.markstrom@est.tech>
Date: Thu, 30 Apr 2026 12:55:14 +0200
Subject: [PATCH v2 2/3] DO NOT MERGE: arm64: perf: Add skip_vmio parameter
 to control device memory callchain guard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-master-with-pfix-v3-v2-2-bd526ec04a75@est.tech>
References: <20260430-master-with-pfix-v3-v2-0-bd526ec04a75@est.tech>
In-Reply-To: <20260430-master-with-pfix-v3-v2-0-bd526ec04a75@est.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777546525; l=2497;
 i=fredrik.markstrom@est.tech; h=from:subject:message-id;
 bh=RP9SD6OW+R3UzyIfJtIbgHt9+O+k4MJRzsi9YyE5F5s=;
 b=roX8WpkSV9v0oQZ80uSGj7SX2JMUq4/DWjnxDBHLv1rVu7Tlmhs2tyex7MIELV7Sge5bvN/wk
 6Gv458GcTpMAnZZxX9sFlwP61l81ocXTvglyfQjZGYDNDrcBenogNcO
X-Developer-Key: i=fredrik.markstrom@est.tech; a=ed25519;
 pk=0a8IXHEgAX55JPS8VZfTf1sDp7q/oAOf459tDQd40Eg=
X-ClientProxiedBy: GV3PEPF0001DBF6.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::306) To PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:336::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP189MB2611:EE_|DB4P189MB3117:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f41ad77-5b11-45a7-69c7-08dea6a70161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	/DWH6d8IKhuUq2r4acoCZQYVmM2pJ8OXfddsKde2jr3UAVd8SEvT0wPRfJDQN0g9MkGf2wHDsYOT1uQDaojobCzAIlENqIKFSvwa5wF4uNKDpBytytAAvlo1+j9hJXFhknUtVHgaO4OchlC2rdRrVMxNz2OoU9Jvm4gRdJDfm1DD0xR/Auj/9Sd3qfyUs+n3+HtuA86H3q+hrSVHBpuhUP7L98PQyHn0Qm/H8q9oyrytnfJpMgGYeCM7kFU827Ah/gUp6vzRdo2zFXGZKloKGe8nob+76qgHSOVXpvqUJaDUwbXgJAyZYvKk7Hjp8aU4z9lGAXy8EHhj3Tgv+BLRL3Q2unRorPodv/ZTvbTNYHogUGNQSMzUwcl3bs76FeWTOsC7JQ3LFjPyanDeLh8lIiHCWfo5rz9ao5ZA7Tc5JKEdkAIqXKZjh/g1xmeiyjfsCiEa+bkImhAR9ko+/YCddWzZMtR43nqFHbacdfLb2TyGiJFWgssXN9R3zU32L8PPMTbzMvd8q+rj1FaGw/Z/HiLhVLWZAk+xH8qt4L2ZhjFEhXlAmCoJiTXECqSZUhzy7VEZGZJWss2/eizx0+ERKVyuo9yS8V4/YLVEGuHT4ue2TASyizTRKkPcgP/0AV5FTNqlBEge+bKQCgqTKcQoWMRGGWfMPcfvVrDppwz1yykAA3/hdFnI58/VYDW6e8LCoxg4ufkV/uVd8rYVefRgq0g5OHFTOF7ywQn6Qy+0Z4SzBA82zZORrgru5wIPErfJVoctb/6hw5OjHhYtiKtUyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWP189MB2611.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEo5RlFNQU53cWs1dFF4WVNvOEVMNDN2cnoyTmNPSVlTK0RxNmhEeG1wVzVh?=
 =?utf-8?B?aDk4RFo0RXhVZjE4Mjk2Ym1yaWVZYmVsQkswVG1McWhueFF4L3FkQ1ZXVXVj?=
 =?utf-8?B?WFVRUjMrKytUdW8zejZ2RnNKOUZrQnZwaHZNNlpuN1lDZTl1TDl1ZE90Wkt6?=
 =?utf-8?B?bXY0bVduKy8zUWxubnArUDJhaFRzeUUvZ045dXhzck9xMy9iMnNtVC9vcVgw?=
 =?utf-8?B?czFwRGJlUEZBdGxndG4rVHpxeU94bDBUVVh3TGpLL25OUi9UU0hsL21rZ1cy?=
 =?utf-8?B?ZmZOU1pDNzNXaWlqcThvNmlDYlFrY3orU3BqZTYyVVorNS9xd1NsblpPZnAv?=
 =?utf-8?B?ZDdpRVlqbkR1OG80TUVXN1ZkNjhTU1dVVDcrUW9odDdpTmtwbHVBcWc3K2tz?=
 =?utf-8?B?eXFHYit3SjgwclJpdkZlTFFWRTF0VGp0TnpYN1poWjVoT3JUMXVvSk4veEtC?=
 =?utf-8?B?RmEzbEFqUHdQQXo1cGhNOHd2bEQwaXU1bVJxOUhDSVlNVXB4TDkyeS9wOW52?=
 =?utf-8?B?UU1ZaTNCazN2QnVUN2RVVW84R1BMeVJ3R1dURXRKNUxwT0xKOWdKb0tUQzI2?=
 =?utf-8?B?TTM5RVNVZHpKR1o5WVhIKzl0a3RFWjNvN29Ddzh1ZVJmSVhDTGdFZjBmZDhW?=
 =?utf-8?B?RUdRMFdUU0syWnVXQzdyNmN3MlBDTnV4WUMyNTBQcVpwNWEzUFRMbEgzaVJB?=
 =?utf-8?B?a0Z5djhrdGxNcHlSUzBZZkp1Q1dlNFpFYUVoa0RSMWx0MWs2YkY3b091M1ow?=
 =?utf-8?B?L0p1OTJLVUFpTUViL2tySk5DSHpDa1RGNU5GeHdtWjh2aEk5NU5FcHZFN1JM?=
 =?utf-8?B?RVdheksyaGJoVjJ1eTZsRlJzTVY2VC9jS1RzZnByWG9oNmpQdjNJNWdKcUJv?=
 =?utf-8?B?NTlHY0ViZUE4TWZGTGJUWTVxY2taOC9HMXNwSUV2dGlieVY3SnREcERrbEpm?=
 =?utf-8?B?eTBHY0lycmlYK2xlVlByZE1nWFE5eEUrb0krVmtYRXFUVVdqd1B6S3d0dWx5?=
 =?utf-8?B?Y25rb20xYUVCeWRDY3VHVUNGQ1hjOXBkaEZBSDU1U0xGbVg1cWllWlFFWHhH?=
 =?utf-8?B?SVBOQWZvRzg5dmtFeDY4aG44ZnRWNHNjRGxUeFYyY3VtV0VXOVVsWXdpQXA2?=
 =?utf-8?B?SEFQbThYTDlDdUI5cEIrM3VtekR5bzlvS3pnMXp2NWYxTU83Tml1M2JrbzVt?=
 =?utf-8?B?U2pEeTBTUXBaSzFyVVBmWEZuaFlDYkQ5eHdYVk8xR0E2N3FtODhzL0I5bS9W?=
 =?utf-8?B?aWtGMWxYc0lkTy85YjBEcXhONFVDR2VMN1BhTGVIa3JzcXVtUzRjWHlIY0RX?=
 =?utf-8?B?TGp3VkplNG96b0MwaHF1WDZKRG1ONHRsa1FPajFSRm04ZVNaUEF4QTJsNDVU?=
 =?utf-8?B?aW15eU82L2RteXkvUFJ6b2lET1RBdU1UWE9jUkpleDUrVXJuenFCNngyWFJa?=
 =?utf-8?B?MmpqMmc5cVVPZldUTmlOQjRZV09XM2NFYlpGRFBvZFJSRFZaV3crNXA1WU9D?=
 =?utf-8?B?TjBNT0xpVkZDaGRsckV6WkxySktJZkhiTzFMeDVSS2NQT3hzRFFxNmpjNThw?=
 =?utf-8?B?bGM4cXd2Z1FBVEx2bTRTVEI2cld4cVlJWTBpL05BRkhGRTZWbXNVamo5MWtF?=
 =?utf-8?B?WHkrcjdBNE40MFhReTA3VVA0OWI3VERPMWVJQk10V2hKa0NKOHZJUXpuYkFo?=
 =?utf-8?B?bHBpMmNUSU9PQ0FxYzR5RTkvdThsRDhOSlBDNk9jZEFiMjdteEFxUS93RHdT?=
 =?utf-8?B?SU8ycnVuTk5NNEdkVTRtbGxuOFA4N3Z4ajZqTG1CbkJCcmdkNkRBVi80QzBQ?=
 =?utf-8?B?NVEyME0wTFFzc3c2K05KMjhlRDFnWVRuNmR1bGZpT0ZMQzVYQ25nVjhLcjBa?=
 =?utf-8?B?cGpqZzhmSlRxUHl0WUg2aTlObDlZR29uL1BOK05LYjdUTFdvUUQyYmkrQjgw?=
 =?utf-8?B?cjdzcnNZSzFTUkYwZGlRR3dHSkhVZVZmZWh4azBMTjIxVXBtUnVGZWhZL25n?=
 =?utf-8?B?T1VqL1d5dk9GK2R3NXZkS0FNa3kyRytSdmRwUUtGYkF1RFhTOERnTDZQVVZa?=
 =?utf-8?B?RWRzMEIvN1ZlNUkwZ0tsS2M5UTJ2cWtsWnJ0NS82M3NSMndrUlNaUExyVUY5?=
 =?utf-8?B?eUsyNG51WS83Mm83RnZKTHN6NWVkNDZhVjk1Vm1kdWhtcDhoT3V1d21XL1FP?=
 =?utf-8?B?MFpMQXFYdEF1cFVCK3V2U2FnQkVUTm45K3Q5LzdwRlM2UzdPQnBBeVJoTC9w?=
 =?utf-8?B?RkNYM254Si9sSkRNZitSdFNqVGtQenV1d1FLbXBHUjRGMWhmVklBRk9WcEdq?=
 =?utf-8?B?RjNzTnJjVWhHcVEwa2xqNXA2dW9PZTk4RUlKakNFZWQvSml4YjBJbEcxc0gv?=
 =?utf-8?Q?Tbq9I2bdlU3CyhP26MbHQc0ec3oseDxiGOwxToiSEgTKc?=
X-MS-Exchange-AntiSpam-MessageData-1: /hc50Ez3klqOmWeG5OLO1KQX3FvjOuqhhnc=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f41ad77-5b11-45a7-69c7-08dea6a70161
X-MS-Exchange-CrossTenant-AuthSource: PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 10:55:34.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVacin3gH3B7OXiCiYcgxe+9BcrUke/XFKMl5CdOcQzl8RSn3oTldk0iGx1G6AC9QvXAAudeIooUIxJXoHwvpJWw0Rvx4lBOpcEJLMxO3Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P189MB3117

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
 arch/arm64/kernel/stacktrace.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 4a28df9bbe763ea7e88f02c1797bf0d4f1bbac2d..19b5251f214f2f6e083e55894ebaed84a3a4f585 100644
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
@@ -123,6 +124,10 @@ static bool range_is_device_mem(unsigned long start, unsigned long size)
 	return false;
 }
 
+static bool skip_vmio = true;
+module_param_unsafe(skip_vmio, bool, 0600);
+MODULE_PARM_DESC(skip_vmio, "Skip device memory during user callchain unwinding");
+
 enum kunwind_source {
 	KUNWIND_SOURCE_UNKNOWN,
 	KUNWIND_SOURCE_FRAME,
@@ -627,7 +632,8 @@ unwind_user_frame(struct frame_tail __user *tail, void *cookie,
 	if (!access_ok(tail, sizeof(buftail)))
 		return NULL;
 
-	if (range_is_device_mem((unsigned long)tail, sizeof(buftail)))
+	if (READ_ONCE(skip_vmio) &&
+	    range_is_device_mem((unsigned long)tail, sizeof(buftail)))
 		return NULL;
 
 	pagefault_disable();
@@ -678,7 +684,8 @@ unwind_compat_user_frame(struct compat_frame_tail __user *tail, void *cookie,
 	if (!access_ok(tail, sizeof(buftail)))
 		return NULL;
 
-	if (range_is_device_mem((unsigned long)tail, sizeof(buftail)))
+	if (READ_ONCE(skip_vmio) &&
+	    range_is_device_mem((unsigned long)tail, sizeof(buftail)))
 		return NULL;
 
 	pagefault_disable();

-- 
2.51.0

