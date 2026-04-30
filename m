Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300943C3426;
	Thu, 30 Apr 2026 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546538; cv=fail; b=N4r1uRI757FOEN0BuJ7qAVSJFHU+NbtFTz8u46ElCOx1MMdpe/apxb6/X/YD+Em665mwFJeGrowVD2Ehgk3SgeTMQCzMYfHs6WeX081jXOMeRUuNnU8ACrIxYYwsjYA5lZttvWwHF7YMDFPERpYrI2pam3mmuldvT81DLaUucMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546538; c=relaxed/simple;
	bh=yQ0Fq5dukHz0bpo48wg3pmP44EimYkNohO5/v0uEoPw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JxT6q+gPbM9FEpKfsX5w8wQCNGvwQAjhMZ3DHXeIKtIsPj0kJ4yEJJ6Y+xFZG+Jwb++P9KuG39PR2NZEHmvoTVQczezeEkAYE26LKTCLza2wYFOTAUeS6OP9IOmW964S6V/X8+MuVKNjpkAhYNqWOlYgLs9VfBvgX7gMi8ejl+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=T4RN+lnD; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="T4RN+lnD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2vl4JxExuHRoIm/WBFQhbJQAPfIyYQBG5Uv4HOqyjoeGV+k7cpI+MwFOc/OHVlIIf9LTy7BFQV+PaKcs5asTkC8FJACrpkSIlDLoleCpuj7+topoAl9juG3QQUkmpatK2pXr+vSsSL+KHPseFw9CtWcwUJQr0GQ4MwjFK/nMlOm3wRsDJcZi1bLvSVx0AKOPsTw9SFbpRo5z7lnMlZD6B249sNDgMAKrHgLRnOGKI1oI7PNCCSDTM6/5KMJ0CV0i4nhOn8xonv/1x4omAtA8fv99BzH1cRY77pZSUznd8Pz4isROPq024cpiyPUHFo6MM/YzJ3aspqXUUHUtfeXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLIumcBjdZ4/2ojapoQziXN0mBW27zcNw69zGs8Owc4=;
 b=M5X5TdWU1gMGpK2X9yZLa7Suy30+x4J+O8znXDAksqNM+OkMS6VW7l8/izaPwJixDRiMO3+V3bVY1253fKoTrcsThulS+R9bnRa4vVcZazgYQ4YAtjJngo+px5KGsC0zZYgtaKdkxMZx9i2K1MbSc209qZZ738gCRdaCvZp/b7wdb0NHcqYZWwlRvFkZB3EUAw+/ENE9klWGR5pziFSta2mseaEUIrIBjzsFMduR9J8P/7wb6kpmuf20ylM5C5Ye8G3/U960kuMG9pZainBOukYCH33puneCQoqr0V1rISX6W0o5CEjpVymBp+jfYtLzAlUFwFGFEbx9kx1vcS5Iaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLIumcBjdZ4/2ojapoQziXN0mBW27zcNw69zGs8Owc4=;
 b=T4RN+lnD79ZHrN2mKgp/sY6THtYDwed9fIQa0erv/dRhQ+I7KurmysBuXMxILF1VSIK6V/A6d6fLB2vFILLUrASq+BHGPBkWpnMAz2bOqLNeOUIOqTiqXiCprRDlpv9S4TP1h/FlKbKLhrxx2dpHcCbq1LCCvGrO15Y7WHTeTToCKsrf5aOriuScvk4m7lh7hTaj7h4R0j99UKywlG7X+EmSCFfpEmROC26EnzJZVZLVv+Bv8vmZF3Irt3ytSrhsXvS6QQnvYKa+esGKHOYbh7SoafxDJ/fK6GhLmJNTNbciodZoPGu2dxGrxytHn2Axy3uakzWq3gn6x67J2rmksQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:336::8)
 by DB4P189MB3117.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 10:55:32 +0000
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884]) by PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 10:55:32 +0000
From: Fredrik Markstrom <fredrik.markstrom@est.tech>
Date: Thu, 30 Apr 2026 12:55:13 +0200
Subject: [PATCH v2 1/3] arm64: perf: Skip device memory during user
 callchain unwinding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-master-with-pfix-v3-v2-1-bd526ec04a75@est.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777546525; l=7911;
 i=fredrik.markstrom@est.tech; h=from:subject:message-id;
 bh=yQ0Fq5dukHz0bpo48wg3pmP44EimYkNohO5/v0uEoPw=;
 b=ikXtLmcnu8H2EL3Uba+jHXn1iKel3o8bmfW+UlGxDWcn5TfWUTdvT/8UzCBYRUfaxYaQO1IM9
 2KFwwOiAF6jDY0JvDu7Cpl1hOC2KWJN8t6OeDnBvGKGZ16u5IRG5MIO
X-Developer-Key: i=fredrik.markstrom@est.tech; a=ed25519;
 pk=0a8IXHEgAX55JPS8VZfTf1sDp7q/oAOf459tDQd40Eg=
X-ClientProxiedBy: GVZP280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:276::17) To PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:336::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP189MB2611:EE_|DB4P189MB3117:EE_
X-MS-Office365-Filtering-Correlation-Id: cc060908-d539-4d96-642f-08dea6a6ffd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	w9QS4WtI1js9jFJz/AWaMoAk6jNLQ4YCSScHOvldnZiY75ZftE1Pqwe8Q0vgLENEtFivvxhuYzd9aRGtirdaDQaqnAqJam1eYaS7cyOJo3RFTuOAnbawp6O36QD+gTlEe332LfIr6JupUR8CZOq6ayHIPiJkNhRRMWUxjmnRE9Z4yByeNgvEuAHN0ClTBjwNOKGPPfQs779O3bEYIZAXH7B7GwZy4fcDCcuv9WUgo1UbrsFxYzGZ+60giASqhnH9U4x/dWKyCbR15eOW0h0bCpmfsdb2V0zDYseJG7dBTIDBiHZodF47Pi7JzSPspwCwhBy5r9T1Nn0OkNokceYMzL+4exwHMA40L5nihm6x2GzygjaOn5nRCwWarMwe0+7ZgD47Eg5SP0gzxa8y4oHgpu+wrB8fjpPHRZwTHuvai/WX6ioVhRrZtjlqGmSw899sxpU0PcUKgtuQOwmDvKR6ZFv3OohFLWr9ZdahAYoZJR6BJj1DIgy3x5HHbhFenvC81Yrc3v3msvmcT80ha8+zeSUHDuxZm9QvIFd/I/ISPXnwNx0xnRpOrzVTPMpW2H83KnJjws3HW7dWX3r44gPt/veTfKaD/9dY3//8U5EdxqtxPfeE4ED1TBEDyD8NtxUSjF1Sy7QNx+Vir8joYVge3lcPtwAKoQYZhdCRp6wVZkQWOOBoyCkpz4DS6GslBbSlFSpNuBFoyhjO90K1hzkO9+TSnRjLw+bOv82vYUo2WZu9DM5orL0TQA3em++hPca6OtdaRlbAzU6WsLW63wD26w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWP189MB2611.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ymt2MmJqbld0K2M3TTZaTGxVTEtmbjlHYTZvd25yRktnS0VYcGw1dGZkK2w5?=
 =?utf-8?B?SXZ4MTl5RHdoOVpoSmd5eHZDeGpVamNhYUxtcGxxbzJmWFpXY1UwUnlxaHJO?=
 =?utf-8?B?ZzRpYXdhemhKVlNGWXdVeXE5T2p6eWhmNTI1d3VsUUJSSWNxekFzK21uWDVl?=
 =?utf-8?B?UElPbkhEQ2VMbENHV3dpdS84ekx3RWZ2RnhPYS85MnhJN2FQMFk2eWdVbEJE?=
 =?utf-8?B?a0hHclRIMGcvek5FcXR5ZnlXS3Bxd29GOXd2NjQ4V1VWYmhmQTVpSm9kcFQ1?=
 =?utf-8?B?UndyRVZ0SmhSOW9TYUE0UmVvc1pFZzIrRWhodHVQcElJU2JtWHhkUkNOUlBu?=
 =?utf-8?B?dW9xVUFUT3dQNnFtQWViK3NVenBMenVsbHR2b2o5dHVhY1RxQ0FQa3ptTnlG?=
 =?utf-8?B?bUJzZXpORXRUYmRqa29sN1p0aVBIY1lRUEtNTXFpdHhuRHVGSHQxMStZNHhO?=
 =?utf-8?B?bE1WYU1XQmpSbnVhRWJBYS9HNW43dnpZbGIrVVdTUnA1SWtHNDZXVU94d1dw?=
 =?utf-8?B?aXhrZU1MaHNDUGNaVFpSZzNpNGF6YVhMQW5Gd1NaRzlwTitKWTZTUjdqUWNM?=
 =?utf-8?B?R21RamNLam95bUlzYVVrVTZnY3JkSHl2eDk3VUthZE5YdFJhdk5VVmhoR3V5?=
 =?utf-8?B?RExzNHBaN0xsN0RuZU9OMjBQb1B5QVBNMGFxM2VIakRNbVl3Y0JzZ1VWNnhZ?=
 =?utf-8?B?aFpVbWNVNVhuMWx6dG9YeUpIYTlnYTQySmduSmhwYW9WNlRKRGhPZGhRMjVC?=
 =?utf-8?B?WGFERy9uZVlLbUwxelpVRjdKMy9tLy90V1NrWnZvNFhGZU82YXh3cUxYenJR?=
 =?utf-8?B?R283Vnp4Z1AxazgwelNSdGNDT3ovK0xzcDBCbmFxR3VtUTlTWkZaV0NhMWQ0?=
 =?utf-8?B?T0M1Y2trSFZEVVNVVUpmRmUwL2tocGI1MGV4SkF2T1dQdU10bGRzaUZhcW85?=
 =?utf-8?B?TlRvUDYyQlA0WmtPalpqS0xOMWRNMitrODBjQk9kb2tiRTBuVUdLU0JTTnZT?=
 =?utf-8?B?TjBHRFBhWlNyQXg2bnRJa2RqeUowSFI5ZUJ0djlvd2F5Q0g1ajYwYWkyQ1lv?=
 =?utf-8?B?NEk4MTJqcW1sd2xNWVJQRno3MFZIdHRCZENLRFU1L3FjSU5SMVNGVVB2Z1Bt?=
 =?utf-8?B?M3JHYU1BWnN3YWsxa2dIamhlSGx4RVVLZWJaeHIzMWYzbWNKZDJTVFdya3dh?=
 =?utf-8?B?SGs5S1hRbDNzSEFFYkhvTDZZcHdub08yakNEdUZ3QjZrK1FjZkRjZUdkRXg3?=
 =?utf-8?B?QW9QaWVKK3JIQ055UWJEdVJpL20zQnRacFo0WngydmYrQVZHZGRJUWRURncw?=
 =?utf-8?B?VnJ1bU1JTFROUHZKZFUrbWtuQVZqUUZGYW1QeWlTZFM2ekFza3ptYTFYYTBN?=
 =?utf-8?B?ZDZ1Tk05SVo1YjMyeFRlVHprbmVoNnpsWURWK2l1ZWFDOFR4SGVwdXFDZVls?=
 =?utf-8?B?WmN3bXYzVElSTHcxajQ5WDdOOERZYmRiU3JocTB4UDg1VzFsQnR2UjB5WHp1?=
 =?utf-8?B?R0IyWXE1b0thUDVOd0w5WDJhMmhuY3ljL1l6S2c2dFZTVVllV09PcysxMGoz?=
 =?utf-8?B?Q0JpaE9oWTlvUnVoMnp2RS9QcXdZMWNYSXU3cW9yWlFqUGhwK2poU1Zaekxa?=
 =?utf-8?B?dk01SW81OFpRQmhLVldCbVJBeGMzUlR3c29wMkx4eHJXN2JGeW1oVlhFNVRW?=
 =?utf-8?B?NkpkbGluOG5OZ3VTdFRXUHhGSTViTzJkTm42UGk3SXk0NWRZTGZxSmdmSml5?=
 =?utf-8?B?VkRQNG9XblZRS0VWcWc1ZDNaTGExUmViTGMvMGpiNmsxYTRiYzIyOTczdlhN?=
 =?utf-8?B?U1doTnhyOWpZRjF2ams5RlRhR0JGMStBQkIzQkFUT05JUFU5Wkxtc2hEZTQy?=
 =?utf-8?B?Z3BsYWtTZE8xSHg5b0FneXN2d0ZzSXl0Y3BaaGRZcHN4Y0hrTjJ2VWliQ2xu?=
 =?utf-8?B?QUlsRFBBN2QyUkg5RHN4c25TTzlKRWdNNUZ2clJRQjhOVFpoR1k2Q1pSemtB?=
 =?utf-8?B?ajZwS3RFMWhNajNaWXhxbk1kdVVpbWljSmNHcGlNYktDNFlxOGVYdjhuQ1ZW?=
 =?utf-8?B?d2tPVGxJR0ZBRFJvTDdEL21uc0RhMzRoRkYzc0NOSVZQZldwZ0lsWk9kZjRD?=
 =?utf-8?B?dEFGUHRPQms2WGdSUHZ4WUhadmkzNXdxaE9DTVhUSVR2aS9UZU9tUVRFck80?=
 =?utf-8?B?NUVWbDJBcTIxOG9VMGg4YTExTjBPR1BBNW44Rmlsb3Y4d1VsOGtxZE96bllX?=
 =?utf-8?B?U3k1cGxHbE45TDR4WENIczFVTDhEUzQwVEhkei85MFJXVHh0ODk4Ty8zNm1M?=
 =?utf-8?B?by9rQUI1RlBkT1R3amF2MkdvWGd4b3U3dENGdVpCa1Jvd1RIUDJCM1diQnVl?=
 =?utf-8?Q?IBWeCl+oXtdpWDcvarcied2Kkxgb/mxLJfmGLVSEuGoR9?=
X-MS-Exchange-AntiSpam-MessageData-1: R6j1vgMdPDJsZORfUlKjN8ax2b9odvwot4E=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: cc060908-d539-4d96-642f-08dea6a6ffd7
X-MS-Exchange-CrossTenant-AuthSource: PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 10:55:32.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0x3L9l+lbvFCWUsnoOZ/XUhKDEYShNeJBkeUGlweyWjXQsEqBhs/Ae1lfhHQJsnhsUyfSxmRcniTV1p7N1tvlftLFDZRgFqaCZTpQLs4S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P189MB3117

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

A TOCTOU race exists: another thread in the same process could
mmap device memory at the target address between the page table
walk and the copy_from_user read. Preventing that would require
mm-level VM_IO tracking (e.g. an atomic counter on the mm).

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
 arch/arm64/kernel/stacktrace.c | 109 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 3ebcf8c53fb04050488ffc110ff2059028b6772d..4a28df9bbe763ea7e88f02c1797bf0d4f1bbac2d 100644
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
@@ -17,9 +19,110 @@
 
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
+static bool range_is_device_mem(unsigned long start, unsigned long size)
+{
+	unsigned long end = start + size - 1;
+
+	if (addr_is_device_mem(start))
+		return true;
+	if ((start ^ end) >> PAGE_SHIFT)
+		return addr_is_device_mem(end);
+	return false;
+}
+
 enum kunwind_source {
 	KUNWIND_SOURCE_UNKNOWN,
 	KUNWIND_SOURCE_FRAME,
@@ -524,6 +627,9 @@ unwind_user_frame(struct frame_tail __user *tail, void *cookie,
 	if (!access_ok(tail, sizeof(buftail)))
 		return NULL;
 
+	if (range_is_device_mem((unsigned long)tail, sizeof(buftail)))
+		return NULL;
+
 	pagefault_disable();
 	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
 	pagefault_enable();
@@ -572,6 +678,9 @@ unwind_compat_user_frame(struct compat_frame_tail __user *tail, void *cookie,
 	if (!access_ok(tail, sizeof(buftail)))
 		return NULL;
 
+	if (range_is_device_mem((unsigned long)tail, sizeof(buftail)))
+		return NULL;
+
 	pagefault_disable();
 	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
 	pagefault_enable();

-- 
2.51.0

