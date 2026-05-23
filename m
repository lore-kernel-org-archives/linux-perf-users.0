Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848B1FC7C5;
	Sat, 23 May 2026 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500016; cv=fail; b=GFgDpWL1Hm9Fpho4yHzbk5Pcm6bOsbjqaCqo5FFE63t+Dzh3AxsP6O9jkLK9TP1PgjcPx/T4bbn3WKi6SQ11nrm0js6psVnRN77VcBpXQZUsh4jImg8llXscICrKainXTKp2XS8IhwCEn+4FLARPBhB5Teq5fGux+/W/maMTDkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500016; c=relaxed/simple;
	bh=pdBhv+OyzW11cJggV35bXPtWFBak+zI+l7tFb0n+w9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4rpVcVV6fTghWeVyES7KAZCelcaR/EAJ8b8VmPBWBGeNWdfI8YhNucRgHK+CS6sQIZP4RSZ1s4RQa2SsUtj6mG99TtjY0gK7sGVNVoTp+Ve6LED+OtqXwjP9gkDGEnOhhqnwxTnOrT1t1bLqH69kqcI3JzxJPuq1k811f2b0O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LUKkv4sF; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LUKkv4sF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HC42BMhY5Y2hUZ8CaTxfvQpjQ7Bg+geISYI2FINSauCAzrTQgzXQnu1ho/5CpiR2u5om8s2YRwkmvtAuaNg6hvn9ceB3YYbV1vS5OeuIRJzXVBWYydIBZP+p/Jk8uynxdbwQTdyy1cCMDpah1GYrNatFqEQ58xsv35EgIo8QPKL2dd7QGdM2Ufel6eatc0tJ6mDox7373VXkbO0uxMhA/NovNv/j9oYnYbYZKofAE4uZ5dbZ5HgBi+/Ps2C+y7kndqbtqAWzx8sl3ztLCvezmIQPWSKhfNo8pQgg2Som/VcMz5/QHuNW1CSXBkkCQa2lMXWNm9oW3XoarV7Hr3MpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVNrry3ePPio9ywsljg31pRuO0QaUUjqGsMXEWZKvXY=;
 b=Ifh4wjCKexQ91I/PTzAMFrYfvWMuAEbAwh4FDrvGSw8S/02HMZEzrvZ1a+D87JHUKULBnjsRXYtsZ8HC2yXW+846usXWxUp4G7dy+iUbFgs22Gq84mUU8WjGuyxnqgYXNSriTP5QRcicG5LCaCtAvC9tgW9cHmbYWwPy5nwTDIvihab7vHxFmzxG7gtNad7rakqpQd4DxahHnIXAuG1BpI37dlPrDghfrElN24qWjPtrsUc/eqg31W9U7VDaNydILu8Zu/hG3+0YyzhK9KsJS137SKBK78uAx8PvoZ9PWFpzwYx9jVJg2vp/kuq7kEBCpt4HdKlMdHXHo2A3sFmCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVNrry3ePPio9ywsljg31pRuO0QaUUjqGsMXEWZKvXY=;
 b=LUKkv4sFNFo+1RQkLC+2CWLaaAlAAm5JUBqo15vyGqmybTW0DK5smBA7yHKh9MLa4k7SNO0Tchkx9cKD/NZMdN2YKdZq/nJJgLe1DgKx1tQsvTvH6pvq/jOOKnXQxfkKjpx6bh3+mQYv6M8n+ru/1d0zXGCFRNsr5f0fKRIENmvhr0oBiP1zAFZU/ds6ggEGSpbHa/9DGGINHU4ZiwxUz+K/m4NP1D94YAQF7CYyI8gx2/ujusABU6+T4L1lXrFIl5HwjoqHzYXrDxAaajEmAzIEhlFdUZOr16HPQQEFJCI4er9ZoEIuiSc+oNtWq+Oe2yiWUbmsbmXjISglfYcFnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Sat, 23 May
 2026 01:33:29 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 01:33:29 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/2] perf/core: out-of-line and export perf_allow_cpu/tracepoint()
Date: Fri, 22 May 2026 18:33:25 -0700
Message-ID: <20260523013326.129491-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523013326.129491-1-jhubbard@nvidia.com>
References: <20260523013326.129491-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: f2af6726-92e2-4283-d68f-08deb86b4b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	AoYuk28rmm6smjNutzcQN0+GCDbjENLpO7WDb1ifQuyhMiExoU3k0/WuOH1rP+1fFR0fqs92W9Yui5aaYRcbUw1ugGvhJFGc+bS/SQQkd35N3cDbe6jpLddWeAV9wezH1kfBzI9+TY4nQuKRI2cT5+nfHeuv31zjbJA1LyMLRZJhaprGFB51MU8b1SUXLEGGT31jsYwfWnpIB8Nr8VLgEEiEZ482KXzE6RMZAExix0gn0pjDHTD6u2Rl4+KgnA/qSm1cULoLzcMsn7Jfnqn3EeSgjzfLw5FiYqFnHB/m70joQT/kj1+v7XRvnaBYfQVCDBcsEbqwsxA9W/ZXPY8R1kWpJtyPAQ3SBltZDey7vwPvkNdka+VGWWarS+82pTxl5WTfIO2aT/CQfNGnxez2JltnD4rInb4/v9Tr8JGEtB4SgbfZpr3s1i2NyuLRxRlbD3bA3/8kdr8MmW8MEGVk2fTm7qs8oG8PA+9Bv/qIWB4WLQQLFlZLu2yI67d8PbjGHZ3WU3YSfpWNaYHWw7ZuBzlxgkmppL+Ys0sqJsN1BXX7v7hFESjAZCw948Y5L/IyW7twcB2DsDnquMi71lqclGNr1Jnn+R8In5ostuz6JT3srsuOLNWb1tZzA4qFRMdrvsPi1hC+EwTcbTcXzETT7uHUZwjvodvE32b3IW3LythyZEoz22KwqOKBlZsLQaRH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6hVekFzMMuMoqkSO8D8a+hFcPZk7uPTrKlPePaN7FLijp/Se3c5ot4bNzDOX?=
 =?us-ascii?Q?ilRFJxbPye4DjBbBM526rAww4caywZzuKgiTeCk5rc/AzBSAoYk6rTBj/nfM?=
 =?us-ascii?Q?/BC2qMA2WKa0VdiO8RyjRAoAiQB3OwzXbQnsedosGiTLwiTG3vei4MRY1812?=
 =?us-ascii?Q?dwfbdSaKd9CqI7thBd4WZ7ZgFI/lu8knapd9LmhGcbfo2b4q1YEYot0BOj2E?=
 =?us-ascii?Q?1pE9681a8x9pJfNfu9KtBP1CSmCrdFiVJPvs0rYRQd41PzU2ePsMVDB7I4kM?=
 =?us-ascii?Q?6OSOuYM54Tt654ZVlJNNGNh2qG9XuuBm0D08VKrCGVU0AUVn51rMnRUEdnKt?=
 =?us-ascii?Q?85YFUQP3NdcWMK/PWJ7Jnkhxy8IhcCSeL+dVr3YI8fay6YOWpZY3LqsUolvs?=
 =?us-ascii?Q?k9xUOHE8o6QSsmUCAGfWKEijiVI3vvXDSSuZt5UDKy4Hn/CKf47y59zmSS4D?=
 =?us-ascii?Q?G/jffhELiDZo0JP31GgGqIv42W7rS6JVVwCwQwDDNK3ZgjvdnbTOKn3icPBe?=
 =?us-ascii?Q?RSVuZUo/l1kfUzOBLhiBJLYGrRsqLmn5fs3vi197EPERQn41nZ7lA4urQFkN?=
 =?us-ascii?Q?I89NvAabO/31QcuHY1Nezyb89p5gcHwLxT2d8iVg6vJQGeyDY+kpbjFdXflM?=
 =?us-ascii?Q?YS+JdOmLasmrOJFBbDck0Twqdm3OlkvC9Jqa3etNvEZ05CaVWzlW5qPmXYfZ?=
 =?us-ascii?Q?N7xqjZJkgMqBQUZeQ59UV8yflHg3MvFYMIRT5Tw4YkQGy82IUusW/+g+rWEY?=
 =?us-ascii?Q?Z6np9MaffnJxL2UvN/Vddtr/cqEWAglSaP+D8KiSLZTwaMfPBM3oN9m2DTIk?=
 =?us-ascii?Q?dPa2a+89mrujItQEbburSLHhB+TKNpN9tareBDGIew89KCcVUXBHqJ+pBGIR?=
 =?us-ascii?Q?jPpXWC8uDEz/pKMmaYlog0xIWajMEEGJSoyIGptTi+hvFPydFXEPAhpecMvX?=
 =?us-ascii?Q?HFXBE/EcSegF1dTlqF7kaBqugLTkQW1CumCrnaqLwklCvHhi16/8ldsVtUYk?=
 =?us-ascii?Q?sC/g5f8KyzyTa3MDlqJbFO4cZKuwb8jpCTaeG4XhltrUw51bRvHXeyz5wESz?=
 =?us-ascii?Q?DhNKXBX91irPUamd68+IWkWZ2gNhdgtri40XGZRCrFrXABdRnrpvDrvZLBcB?=
 =?us-ascii?Q?Xiy75hOnh7yW7S4IJfc7IrU6Nw9ixN7Np07FicgnPMUUnskm5UWBEopa//pt?=
 =?us-ascii?Q?g4JGXk7d6U2hP2uEo3bJaVQ0Y2AZTiohj6Ivo18IYcFhLZSqpvEBvHC1wPQU?=
 =?us-ascii?Q?ZgKAtXbxAvARE703ruu+/kjMDWf2vvzgu+m2wZe2cKu2ICD1eZzUvIwKhQj4?=
 =?us-ascii?Q?KQcpvnCYcFn3ZOU6XUQqgL+0klxUVJDAqYaj9MRWgUfHSKlOaz0nyTrgm9Uq?=
 =?us-ascii?Q?Z+jfQDoNykT/qkH1/F1y489BG9cZB0mGg2e6oL5niAa0vD6Q1BcqEuEHZdjo?=
 =?us-ascii?Q?K0orzhEB0mL82MzJije24WAiuAsGFWfHl6V6gsOUrXCcZodfYcsa4e/UUYn+?=
 =?us-ascii?Q?qfglGjWnmY6S9B6i6nmvxD+3YTZLvpTBKYuRZgeGj5GGnGekt5mDYrrzmxzL?=
 =?us-ascii?Q?9waC4w+rF6jfSHRNE4X6briTaXnRNYHCLWihs0/dw/EudTGSyz4LSqUVEm1f?=
 =?us-ascii?Q?ytJZrYMIFRGAN9GDRcRQKc55pndT4t2g+TwDfvmhRYks2JKmZoYF2PRVGwWp?=
 =?us-ascii?Q?M+oA8ClwEe5BXMwLAm9mkdCCZY31RjG6Eqv9rHNMWLD0QtXmM2wthYo7C1Dw?=
 =?us-ascii?Q?bUY2qNX7fg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2af6726-92e2-4283-d68f-08deb86b4b3c
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 01:33:29.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGdtyW4sTGiHRgf+4GLthtkIXPlU9PipG1iC+EFWj0BKkD9T9/zElTAd3kzekvl6s6NkxcC0p7EZvkWJLvCHnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580

These helpers are static inline in <linux/perf_event.h> and reach
into sysctl_perf_event_paranoid and security_perf_event_open(),
neither of which is itself exported. The perf_allow_* trio is
therefore asymmetric: built-in callers can use any of the three, but
modular code can only call perf_allow_kernel().

Move both bodies into kernel/events/core.c next to perf_allow_kernel()
and export them with EXPORT_SYMBOL_GPL, following the shape of
commit 5e9629d0ae97 ("drivers/perf: arm_spe: Use perf_allow_kernel()
for permissions"). Existing in-tree callers live in built-in arch and
tracing code, so the change is invisible to them.

Provide !CONFIG_PERF_EVENTS stubs that fall back to perfmon_capable(),
so the helpers stay callable when perf is compiled out.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/perf_event.h | 31 +++++++++++++++----------------
 kernel/events/core.c       | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..5842552294c1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1791,22 +1791,8 @@ static inline int perf_is_paranoid(void)
 }
 
 extern int perf_allow_kernel(void);
-
-static inline int perf_allow_cpu(void)
-{
-	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
-		return -EACCES;
-
-	return security_perf_event_open(PERF_SECURITY_CPU);
-}
-
-static inline int perf_allow_tracepoint(void)
-{
-	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
-		return -EPERM;
-
-	return security_perf_event_open(PERF_SECURITY_TRACEPOINT);
-}
+extern int perf_allow_cpu(void);
+extern int perf_allow_tracepoint(void);
 
 extern int perf_exclude_event(struct perf_event *event, struct pt_regs *regs);
 
@@ -2023,6 +2009,19 @@ perf_event_pause(struct perf_event *event, bool reset)			{ return 0; }
 static inline int
 perf_exclude_event(struct perf_event *event, struct pt_regs *regs)	{ return 0; }
 
+static inline int perf_allow_kernel(void)
+{
+	return perfmon_capable() ? 0 : -EACCES;
+}
+static inline int perf_allow_cpu(void)
+{
+	return perfmon_capable() ? 0 : -EACCES;
+}
+static inline int perf_allow_tracepoint(void)
+{
+	return perfmon_capable() ? 0 : -EPERM;
+}
+
 #endif /* !CONFIG_PERF_EVENTS */
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944..cb13f3ad11a3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14731,6 +14731,24 @@ int perf_allow_kernel(void)
 }
 EXPORT_SYMBOL_GPL(perf_allow_kernel);
 
+int perf_allow_cpu(void)
+{
+	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
+		return -EACCES;
+
+	return security_perf_event_open(PERF_SECURITY_CPU);
+}
+EXPORT_SYMBOL_GPL(perf_allow_cpu);
+
+int perf_allow_tracepoint(void)
+{
+	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
+		return -EPERM;
+
+	return security_perf_event_open(PERF_SECURITY_TRACEPOINT);
+}
+EXPORT_SYMBOL_GPL(perf_allow_tracepoint);
+
 /*
  * Inherit an event from parent task to child task.
  *
-- 
2.54.0

