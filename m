Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AC36403C;
	Tue, 28 Apr 2026 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409374; cv=fail; b=KEgMUyIGnE2SiQeMJPjzQZvpmQWyXLY4382iVEw4mwp5Nxaog7LZ7aZ13Cdh66ucNs7HAmc+WQY5L2fAUCo8iTbYmVInnu5hpNrWffXrEIZiIFXlYPsV16FkHGI8jRMyazc4C1lfe0LuhfQiEzTR9mUECaPq4WvOtnAg7oiWcUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409374; c=relaxed/simple;
	bh=ZbkqlPIm4a8Jf8JYfrB3XmMwUE6RdzhrdFih1KCd910=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FVJ12sQoLEDzOMrFjUDxoQNh0NSUUEd4XIedEYy9sV0MtKf2OtFNbccj/3zPjvQsNuGjs9CxC4hd3RBiUBPoP3XmnnLovlp87JfTp6va8tmK1WWpvM25feu4NEkGcC/+xYpPuy+CnZedxGk7r55wI1gW/AQJ78dB/90Z83lY0vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=shzqaP3M; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="shzqaP3M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NakGt2f/hzBWhyLOQg3s/Y3Ts4wYJeHSNiN/UTf9iiKp2QKS6ATnbAst3V/W2u/xksTjRrJTrpNUEGbixJiOSp4dq4iQSiP+lSCHggmK6DjUsram8t/0Nb3OnC///Fz0IOZ8EqgdINL5tG9VXzpkupKu5mEIZYQJSAs3SyZGOdgMSw9CbarZ5te2eFZRrsfacV9PqPzh2xyhKNyjbEobDjN4r18iivA+WCiUikQ5FGRj0WWJOC9Sz1vE/bMv/F3nK2m0yFInC2ZlAt3yvVGpLlr+pzicRpMCUwSEZrDz8kS8CljIqikfSmn8MYgcYU8NwGHnASb6r5YJVuyTteulQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8xdRKCXnOKwYSwCHs2zizaGyKeS9Ihk+Dk2be6W6Vs=;
 b=jMgwjPPVzaxZW70Fmo01k07XssCbe11vE1h8Ej6L0CWqTCNsSkHCVFobIWOsPuDQpzlNhsUZ6pgoSC77OYuqq8TmG370HU9xP/X5EziMBQnqiGWqGWU5bgWeynRZHw2CurxHV09+4NHiVa5yfOes8/cFnqoApURnDbbmp2tu5XXTV5ux9ok056J4Hh0zfkHNhbDUIOnK0oGb+QDQ0gFy/BMz27gZlXRbZsBcdYpo/OJlBaCHP/kAnqLxQJv+YWF20EW8ptE2KSQzC2KAQGuyD0CM3dmm3Lv3mPWJIt/RdDcojvizF4vVzzzlfE2iFdYNrGsfzTAvX22OIrT5cMBqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8xdRKCXnOKwYSwCHs2zizaGyKeS9Ihk+Dk2be6W6Vs=;
 b=shzqaP3MYD5RfSN/1jQj5UgAjOGTI0cFvfGip72nazE57JRIMpUH6ZfXK2goReJYpiiBrqVjrH5nLxqEidur9/UeUh7UqkYstkMi/ZMxBSkHc/JMz/Dd2VOkXpffQq+EFQzbkZvj1UgdEJi1I3d0QyWl5FAJfRCiGvml2L4vOOG0kmttaV9fajZ515wDzETNkBp06aPOoqVWdL9X536eDDTgVdlSt2E4w8geHcw0lZGXS5Otbi+9LTzU9nFsKJE2Pqal8I+NiRSz7RVVXkrHsRNq9TDnl0gQih8Gjv889r6N+8665vJrwM6wOvdZLVWbFy+mXfjtwEIUPKunME9Kow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:336::8)
 by AS4P189MB1894.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 20:49:27 +0000
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884]) by PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 20:49:27 +0000
From: Fredrik Markstrom <fredrik.markstrom@est.tech>
Date: Tue, 28 Apr 2026 22:48:58 +0200
Subject: [PATCH 1/3] arm64: perf: Skip device memory during user callchain
 unwinding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-master-with-pfix-v3-v1-1-c384d3e53092@est.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777409361; l=7346;
 i=fredrik.markstrom@est.tech; h=from:subject:message-id;
 bh=ZbkqlPIm4a8Jf8JYfrB3XmMwUE6RdzhrdFih1KCd910=;
 b=/0IjSmpalakOWO/cgogmLgI7Ien+Vp806mNDiL9if6tnRCDHaLL8qse91m+/fiNzBKVkcqpnl
 /hNC/PDZbdfBmHgHUWkx90S/d8meSXPvdI2AJ5YKrzBJ6tjgrIawswe
X-Developer-Key: i=fredrik.markstrom@est.tech; a=ed25519;
 pk=0a8IXHEgAX55JPS8VZfTf1sDp7q/oAOf459tDQd40Eg=
X-ClientProxiedBy: GV3PEPF0001DC47.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2f2) To PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:336::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP189MB2611:EE_|AS4P189MB1894:EE_
X-MS-Office365-Filtering-Correlation-Id: 719de2b3-11a4-406b-13f9-08dea567a301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Gbwe9Da0TRs/7YEfQ2WGLIYrHVEmgYiqMYDSBFszeGFFe7AKudm+b51Vztmq0fsvJVxaKjOTUiz1MPcmGAn2UJOKvMwkw0qpoIlawndc/DAGpim7EGySSACPhTedNxCzHF6UuIVMFuuk74S9GKPiGS8F26b9f6OlHmvSMIOEUouPfOBJ+QSEqCmiC7JN2MpyfrxyOYELoWp8r3+T6fMhAxKQsnN3pWVW14tUUmRJe8rT8qsDNkRTGRJd8in3d7q88jqRgf1LPpoTE0sHbJjDv9jEzT2HkGcIEKQYceqGL4/iUe/vRUi0SG1cSZh4mSICa9uKJpDU45q04F36I/upQmZ4ehOpYK9NS/MPLZKshbQ5JdURGtV+hXpurvzS2iwbbLAMN7y3n+YO0PtUGlr+v7twj28bT+fosX7CKeB0RZ43feYMO21J8fRcI2uVUawuFeSJyI1NXhPJk8DbpLBPezosDmiCuJTNXMdtVXdXMMosQtRQrAojXTu8dsekWhC10qA/A2Mqd/L6wZLTKEzSSVNEcUY9enBCrsSrqClpZFIiObyyLepecmGyW0XiC/Z1XuPzrFMl6cB4OlaiQB/eHqDWguIMp18uu0uwqZEXzDea2mJjuqu0d6oxDKrFAHmfjr1ZIHf4oNIdicFdFFKIdlxx9WQ+ywKeDN1idWNXUD4UxCF9/3IsHLyWgqqYfhxFA7gSIiywoPfEv0lKWHJUassuDxzIyjJrSdFAszUP54YXwz8vsFfrlqdNFvkLKrfV2Vq1GzVo8Jiy26dSy2VNdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWP189MB2611.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlczclpIQ2tYdUFnajFVRFlFckVxM0d1N3pDWnNRWEFQZ2xhVnRkYm9UMDV2?=
 =?utf-8?B?ZzlzbWhEODd4ZS9GY3Z4ZmwwYys2L0pFSkZsMjF4Z0hmdXpoMys1TlJWQjIw?=
 =?utf-8?B?bWN5M1VpNUM4b0RyOG9BbFg3dUZkNjN1NVN0bzg1cTMzTjZXMFc4WmdKMHQz?=
 =?utf-8?B?ZlB3RWdqTzgxdnA1U2VaR3creHl3V2NkS0p6YXlRU0o1QVRMSFlmYVE4VjJ5?=
 =?utf-8?B?WDN4aXpTNjVqaGJZRWF0MHhra0o2SDZndHdLSExyQjAwMEVyd3pERUpONmcr?=
 =?utf-8?B?WnZTYkI4bnNzNkRWWVRETHRBTmR1THl1bzVscWhuYmUraHdvK3Awem9oakZm?=
 =?utf-8?B?aUI0TEx5c0NUcVVOSFJWRE1ROEFWTjNYcDZObkdCVVdoNmVNSHoyYnlHQWMy?=
 =?utf-8?B?TGprTHE0N25wVzV0ZzZsWnVONERWM1ZGR29rRW5TaERodWY1blVXcVIxeFFT?=
 =?utf-8?B?TGZuQmQzOWo0R3pxMmNwamJNZnVzRWlHUXdOQnc4QTBhN241Y29ydEZxZUZG?=
 =?utf-8?B?L1o2eUhxRVJVSGNad0ZHdmJ6WlR0RDkzN3Rla1FJUnVrZjZtcEpJTm1kZ2o4?=
 =?utf-8?B?aEtuT05YMzFhSGdFMjNvam15dUw4VkhkeU0zQm53MWJBQ2taS3dURkZVcld0?=
 =?utf-8?B?Wi8rbjFKU3lVcnZlSldhdUZZeEMraC9ocVFjNWM1eXVKZ2IrV3M1NUo0YW1P?=
 =?utf-8?B?ZVdQQnhFMnlZVllGMTlSc1FyVWlubERWcTM0YmtIWGtidHdRRnB1QTB6aEgy?=
 =?utf-8?B?cWR6eHo4cXRJQ3ZwRllMUHRURTJOSkpJRzVpRXE0UU5SL2tsTHdScUJHRmNN?=
 =?utf-8?B?T1NCWlVnVlozNk5NT1N4Y1JUZ2hPVkhDNng1ZEJhZzBwZzdFSUgrNk11Y3Vt?=
 =?utf-8?B?eS9iOFlvZkZsaHhOaFR3VDN2d0JGTXRqc0hsY3BzR1U0bUVOc2IxS21FdmNK?=
 =?utf-8?B?V253MTZXZjJwckp1bFlZZ3NJNmR3U05IWGJ4Y1Q2WWJNaHlRQjYxV2xacUFJ?=
 =?utf-8?B?dUhSeVdaemNDNTIva1htcWJoWVQrb2lMTjBuanR4RmUwRnIwcXpIdnBRZEFv?=
 =?utf-8?B?dW16ZXVxeklFZHFuRnJCU1B0N1pUNm9yaENBVEFUd0U2eVFyOEhCTnRVOW9X?=
 =?utf-8?B?VHlVZ0lQK3g1TWVtVGVwVVFiVWt3MWhlYlYyQ2FXbi9KL0RxM3IyUWF6blBw?=
 =?utf-8?B?Znk2c0dXR2E5Y0M2QU9nQytLSGlxS083OStMUUZQR2tEb3BJYlovQm1CdDV6?=
 =?utf-8?B?aERMVEQ2aXRIVU5Wa1hLMkxBRk5wMGQyeG0xNWkyWlRkdUJPSWFRRWpsK2kz?=
 =?utf-8?B?b0RkNjNKY2RhM2Fma250blBkSG1tWVNrMDNYWmc3cm84MGh5a0JpdCtnSHkw?=
 =?utf-8?B?K2N5ajMrNWd0cjJQbnpEUE81RXl5eHdCTmM3M2xWalVZNmkxeVk2T3U0R2NZ?=
 =?utf-8?B?WDZvc0RIaTVlUk1ucGZVM2Nud1hsUTl6ekNNb1ZST3RMYjhyaW1xeUdENG5a?=
 =?utf-8?B?L0o5MFF6Mk53emMrVGFyemUvci9SN29VNjVRTEIzZTMweGhNRzBNOURQdmVI?=
 =?utf-8?B?WGlhWFZiT0FncXo5TW0xaFdlY0YzUGtucWkwNG9vM2xHWlU3WVBuVDY0cHo0?=
 =?utf-8?B?anFuMkJGVXlOUUg5MjVsOVhtdTc2L2h6aXVoS2FycENTN3dBamRtNFhNV2t3?=
 =?utf-8?B?NW1wcElLc2xoSEpkMDBsTzVhR01aRkp2aG5ONG5kYm5kbGl2MW1HYjlvVDMy?=
 =?utf-8?B?WUhQUDAwVVd2SndtdjNuQkg0YVoyeG5BQk0vamlPcS9JRGFOS2RmNDFWYlFZ?=
 =?utf-8?B?dUViWkxlTU9lek5wSVpMMkgvMU5BU2dlOG1XNkpkd2ttb2NCV1laZ01EOW5S?=
 =?utf-8?B?M1BUdi92WHdRa0FKU3VoaDQraW9xMzhza2trVTM0WDV6YzE2SXkrcDhLeTNH?=
 =?utf-8?B?L3RLZHRNcDlQMEkrSUo3TlVmZmtHV1dmV2x0amZJbjRtSVBkSWgwZXVickZV?=
 =?utf-8?B?cXNRVVR2TTBPOEJ3NnpVZk0zTXZoN3A0TVVRUXRDQUpSL1BBN2lPZHZiUmpL?=
 =?utf-8?B?aHpMRVlrSHBGaERJL01nSEQ0aXpqSjEvUFVpTGFKWHRvSW8rU0s4WnVmdUcz?=
 =?utf-8?B?V1JsRVVYUXIvL0JwdzMyM3ZONUhCb1E1U3NzR1V1eGJZd0FrU0lXbndGUjFU?=
 =?utf-8?B?bzZ3S1dleE84U1hES0tEVFQrYmNBMGt4eDNpN2lLS3ZMNWF0T3Y0SWE0SzFn?=
 =?utf-8?B?aGc1NWdoQ1I0U2EvbmdIRFplSXJZVXk2OXk5WlJpMGE1cW5YSG03ejVlMUFq?=
 =?utf-8?B?cEhyYVA4YjF6SkJQekVqY2JiUFdneHQ4MFZwK2J5V0t0WGI5akhmRVJIOWNm?=
 =?utf-8?Q?5E92RdmrveFjr45U=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 719de2b3-11a4-406b-13f9-08dea567a301
X-MS-Exchange-CrossTenant-AuthSource: PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 20:49:26.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWcqIF6EuSD2bgIQGNctCkbvcLXx6BwLgd1KOKlv9fM+hqJWWQOxJIb5Ic5aGJw9KPQVtHHDu8SlIDdYhTqNDUOAxZbvboWU7AZLH0eZ9Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1894

Perf callchain unwinding follows userspace frame pointers via
copy_from_user. A corrupted frame pointer can point into device
I/O memory mapped into the process (e.g. via UIO), causing the
kernel to read from MMIO regions. Reads from device memory can
have side effects, trigger bus errors, or produce faults that
crash the kernel.

Add a lockless page table walk that inspects the MAIR attribute
index in the leaf PTE before reading. If the PTE indicates
device memory (MT_DEVICE_nGnRnE or MT_DEVICE_nGnRE), the frame
is skipped. The walk uses the same lockless accessors as
perf_get_pgtable_size() with local_irq_save/restore to ensure
page table pages are not freed during the walk, as
arch_stack_walk_user() can also be reached from process
context via ftrace (stack_trace_save_user).

The walk is guarded by #ifdef CONFIG_HAVE_GUP_FAST to match
perf_get_pgtable_size(), though the lockless helpers all have
generic fallbacks and the guard may not be strictly necessary.

Without this guard the kernel panics:

    Internal error: synchronous external abort: 0000000096000010 [#1]  SMP
    CPU: 1 UID: 0 PID: 33 Comm: test_perf_vmio Tainted: G   M                7.0.0+ #37 PREEMPTLAZY
    Tainted: [M]=MACHINE_CHECK
    Hardware name: linux,dummy-virt (DT)
    pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : __arch_copy_from_user+0xb8/0x23c
    lr : arch_stack_walk_user+0x218/0x258
    sp : ffff800080433ba0
    x29: ffff800080433ba0 x28: ffff00000097ed40 x27: 0000000000000000
    x26: 000000000000001f x25: ffffffffffffffff x24: ffff00000097ed40
    x23: 000ffffffffffff0 x22: ffff800080433c78 x21: ffff800080022db8
    x20: ffff80008032bc60 x19: 0000ffff9e575000 x18: 0000000000000000
    x17: ffff7fffbfac5000 x16: ffff800080430000 x15: 0000ffff9e575000
    x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
    x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
    x8 : 0000000000000001 x7 : 000000000000007f x6 : ffff800080433c10
    x5 : ffff800080433c20 x4 : 0000000000000000 x3 : 0000000000000010
    x2 : 0000000000000010 x1 : 0000ffff9e575000 x0 : ffff800080433c10
    Call trace:
     __arch_copy_from_user+0xb8/0x23c (P)
     perf_callchain_user+0x1c/0x24
     get_perf_callchain+0x130/0x138
     perf_callchain+0xac/0xc4
     perf_prepare_sample+0xac/0x5d8
     perf_event_output_forward+0x44/0xa0
     __perf_event_overflow+0x190/0x230
     perf_event_overflow+0x18/0x20
     armv8pmu_handle_irq+0x154/0x194
     armpmu_dispatch_irq+0x28/0x54
     handle_percpu_devid_irq+0xf0/0x11c
     handle_irq_desc+0x3c/0x50
     generic_handle_domain_irq+0x14/0x1c
     gic_handle_irq+0x80/0x98
     call_on_irq_stack+0x30/0x4c
     do_interrupt_handler+0x5c/0x84
     el0_interrupt+0x58/0x8c
     __el0_irq_handler_common+0x14/0x1c
     el0t_64_irq_handler+0xc/0x14
     el0t_64_irq+0x154/0x158
    Code: f8400827 f8408828 91004021 a88120c7 (f8400827)
    ---[ end trace 0000000000000000 ]---
    Kernel panic - not syncing: synchronous external abort: Fatal exception in interrupt
    SMP: stopping secondary CPUs
    Kernel Offset: disabled
    CPU features: 0x0000000,000d0000,00040000,0400400b
    Memory Limit: none

Assisted-by: Kiro:claude-opus-4.6 [kiro-cli]
Fixes: 030896885ade ("arm64: Performance counters support")
Signed-off-by: Fredrik Markstrom <fredrik.markstrom@est.tech>
Reviewed-by: Ivar Holmqvist <ivar.holmqvist@est.tech>
Reviewed-by: Malin Jonsson <malin.jonsson@est.tech>
---
 arch/arm64/kernel/stacktrace.c | 98 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 3ebcf8c53fb04050488ffc110ff2059028b6772d..6426a307b8f86ae756ea444247ae329591a89b4b 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -4,12 +4,14 @@
  *
  * Copyright (C) 2012 ARM Ltd.
  */
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/filter.h>
 #include <linux/ftrace.h>
 #include <linux/kprobes.h>
+#include <linux/pgtable.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
@@ -17,9 +19,99 @@
 
 #include <asm/efi.h>
 #include <asm/irq.h>
+#include <asm/memory.h>
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
+/*
+ * addr_is_device_mem - check if a userspace address maps device memory
+ *
+ * Walks the current task's page tables without taking the mmap lock,
+ * using the same lockless pattern as perf_get_pgtable_size() in
+ * kernel/events/core.c.  Inspects the MAIR attribute index in the
+ * leaf PTE to detect device memory types.
+ *
+ * Returns true for device memory (MT_DEVICE_nGnRnE, MT_DEVICE_nGnRE)
+ * or if the mapping cannot be determined.  Safe to call from IRQ/NMI
+ * context.
+ */
+static bool addr_is_device_mem(unsigned long addr)
+{
+#ifdef CONFIG_HAVE_GUP_FAST
+	struct mm_struct *mm = current->mm;
+	pgd_t *pgdp, pgd;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+	unsigned long flags;
+	unsigned int idx;
+	bool is_dev;
+
+	if (!mm)
+		return true;
+
+	local_irq_save(flags);
+
+	pgdp = pgd_offset(mm, addr);
+	pgd = pgdp_get(pgdp);
+	if (pgd_none(pgd))
+		goto err;
+
+	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
+	p4d = p4dp_get(p4dp);
+	if (!p4d_present(p4d))
+		goto err;
+
+	pudp = pud_offset_lockless(p4dp, p4d, addr);
+	pud = pudp_get(pudp);
+	if (!pud_present(pud))
+		goto err;
+
+	if (pud_leaf(pud)) {
+		pte = pud_pte(pud);
+		goto check;
+	}
+
+	pmdp = pmd_offset_lockless(pudp, pud, addr);
+again:
+	pmd = pmdp_get_lockless(pmdp);
+	if (!pmd_present(pmd))
+		goto err;
+
+	if (pmd_leaf(pmd)) {
+		pte = pmd_pte(pmd);
+		goto check;
+	}
+
+	ptep = pte_offset_map(&pmd, addr);
+	if (!ptep)
+		goto again;
+
+	pte = ptep_get_lockless(ptep);
+	pte_unmap(ptep);
+
+	if (!pte_present(pte))
+		goto err;
+check:
+	idx = FIELD_GET(PTE_ATTRINDX_MASK, pte_val(pte));
+	is_dev = idx == MT_DEVICE_nGnRnE || idx == MT_DEVICE_nGnRE;
+	local_irq_restore(flags);
+	return is_dev;
+err:
+	local_irq_restore(flags);
+	return true;
+#else
+	/*
+	 * Without GUP-fast lockless page table helpers we cannot
+	 * inspect the PTE.  Preserve the existing behavior (no
+	 * device memory check) rather than unconditionally blocking
+	 * all unwinding.
+	 */
+	return false;
+#endif
+}
+
 enum kunwind_source {
 	KUNWIND_SOURCE_UNKNOWN,
 	KUNWIND_SOURCE_FRAME,
@@ -524,6 +616,9 @@ unwind_user_frame(struct frame_tail __user *tail, void *cookie,
 	if (!access_ok(tail, sizeof(buftail)))
 		return NULL;
 
+	if (addr_is_device_mem((unsigned long)tail))
+		return NULL;
+
 	pagefault_disable();
 	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
 	pagefault_enable();
@@ -572,6 +667,9 @@ unwind_compat_user_frame(struct compat_frame_tail __user *tail, void *cookie,
 	if (!access_ok(tail, sizeof(buftail)))
 		return NULL;
 
+	if (addr_is_device_mem((unsigned long)tail))
+		return NULL;
+
 	pagefault_disable();
 	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
 	pagefault_enable();

-- 
2.51.0

