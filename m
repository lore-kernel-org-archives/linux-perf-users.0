Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069E383C6F;
	Tue, 28 Apr 2026 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409378; cv=fail; b=bHbq3vYSRWq23Jja/a0O3jBuO/fgPI1nZNb+m65Gw7F1a0+DO4YwgfOj6SXlXBYH9xzZJUKWH0ACHa7npmCEadqscfEnMhcLNJ1fPM7JseZVSDKyU8TidE0v4WHCJEUDpY3FzMlaprGTZdyfVhJTlCX28d8k3LgScyywEUUrqtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409378; c=relaxed/simple;
	bh=bBX7vhTEPM8VHvHKiA0Ym3Yzh1fwYEeNAqoMothC140=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n27e7x9XAhnmiUUCKCIeRgBDMHmRqbVx/RpOL+D0PvMHyRatjaCDlc51KVFYotsCb71ytYcyWMGMUe4BxXCGtvPszDSZ7JZTShI01GQAunHlb4mfdb7StIOjrziZ8QFX1jWl9fqgUvQRCHNovcmk3GX8Vvzq38Ky0TRpD8hy2D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=e6QIJvPz; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="e6QIJvPz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asEPKVAd3VHZMhuWLxPG6Qk0gWel9btib7Nl44T/0B3eT8jS68rA9AOpXP4bcp6lecliHS+v+hlhPUII1+egGne4MdVvlrqcfqkme7vmI6Pa/Lpxg4/ANz5+sw9D8LwsP+dXag/K72CREwneYYnry7hUvHWwp2QfAT5wLKx6GD5BrxcVq9eNYotNEMHXBl1owS5Agznl0IQswbZoqny500ody9Rwt9+bvWLM3zxmNWFt+zNhnY79j39e2iBn08x7Z7uCtwTBHH9uzwkd7K1WLH4UTvHj1vPD/DGEleRL4N1yuKhbtxqUQxjLlJ9L49EI19cmL+dyKT85a3W1pPi42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRJxmHEJPyPlISKYCzrQJ/oeZLUTC7kvEd+zQihSk54=;
 b=TAv2/Q5DJ/AWWN26zx8p7VftSRoijt69zBkppj+XvlA1ai4w6z2tM/oLVzp9beJOt2+wjhNA+GHisWnZKLj5Q0znonoMntMj1ys/mK4cYz2s7+PaDalNIUFFA1hsEZxHK+qS3UlZlVmCJoYZPdDCkkEOO/q96fYvbo15F4Y5sRsjvHz+7jm+wZCxSwpyrPGSErrBntpxYC1qSBmys5eEYK8ieRssb+dhnqCK1VLniSAR1zZdHgKfJqMIK4CRf4hDNE2nNCCvRuhIqziD0fcGSrIh3PKNxKMwumVgCMZekE/ZzPT3Ny3VYmD4Yvbz+6fGkT1c5l/8J1KVwQco2liaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRJxmHEJPyPlISKYCzrQJ/oeZLUTC7kvEd+zQihSk54=;
 b=e6QIJvPzFvzb9FNDD6QfHGaHeQWLJsSELw2JpbB5EK4rlEMCpsrJPAirPRJDHu3M+ozao1WczotLTKadghjNfZvJAFCrn/4MZJzq1UKSfNu5ku2xp81oI72N2D2OKLvQ445BmfaAjQHjGh/hZg2/jr5OmFf+DKrRn8gVUvzD7qKjvtm1xUTOgBzRcRmefxelt6ppTid1sS+45L3+BQMkaw9tEI6nG7xFSYobc+czKHZp05fNSebadU+EtEjLh3sJubmq389aUou9xnSPL3+Op9xKzOSY1i9+1BnEDsqIO5fu3RQ+HdvsxKWaoUpL3OC9hDLWebQr7PNzAdD5AnSVDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:336::8)
 by AS4P189MB1894.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 20:49:31 +0000
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884]) by PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 20:49:31 +0000
From: Fredrik Markstrom <fredrik.markstrom@est.tech>
Date: Tue, 28 Apr 2026 22:49:00 +0200
Subject: [PATCH 3/3] DO NOT MERGE: selftests: perf_events: Add device
 memory callchain unwinding test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-master-with-pfix-v3-v1-3-c384d3e53092@est.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777409361; l=6255;
 i=fredrik.markstrom@est.tech; h=from:subject:message-id;
 bh=bBX7vhTEPM8VHvHKiA0Ym3Yzh1fwYEeNAqoMothC140=;
 b=3pI6s49K/+qGamD9eFs/pJfsGW4CRgPzdqK7BgLUS9PUlZvYoS/kkjKfneMvVwBIaPSOA77vH
 pkzF1oHxNQhDbYLaogmd9IV3kh8Il7xXyIuB4G0faNr2Co72DJi90xN
X-Developer-Key: i=fredrik.markstrom@est.tech; a=ed25519;
 pk=0a8IXHEgAX55JPS8VZfTf1sDp7q/oAOf459tDQd40Eg=
X-ClientProxiedBy: GVZP280CA0044.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:26f::17) To PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:336::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP189MB2611:EE_|AS4P189MB1894:EE_
X-MS-Office365-Filtering-Correlation-Id: 4673c93a-1378-4dcb-2457-08dea567a592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ECI5XBvlJNeHEIwkq7uRgcD4SZv6t8/r02KS0s3DIdeo28V1CwOOpG2z2/eA3/5lpgDr5ib2Cliuo+AHLKQgbGFMYF1KDlMTt53aGpuOoi8Rsd+0AUSLuo+ZninBj5ffNThSNP7Gz8kb5wGm0JFL84U+1lA3RWZaNUDEiaU5FceNFqBnaynHBdapT41MIr4yyKstOy2B789MaR5MOtfjy+D7HJ1eaAtBQ0WhJyOvsBgai+eeEW/tq5/7KaAdP29eRiJJCbBezioO219QGA+ZVwFDN5lyFuhq1p0ZkATqCSvDT1v+pGBcMm5L2GBYrihfGb7CW28t2LDLPzCnqvC4YcvG+zl9tptBokki2HHqVUI4MWDxSoN/1oVXNCPejOvT8ZKtl4mB3ZLWxNoFfNo5UQyEN5ARSNvTVwm87pz565TM+LYaCDjxdroAPq0CrF1sTcLpYYyCIs2suXr2V9jo48euf81kIwwoccEuXFNJJYGKdpoTdgDJdxScps4blRdNBsOmsboJV6EP2HAAqWse1uvEp5w5z76iwGQIxkOQ9dshZURz4OVaiHMsxm18eRCLy6b6ZtYqLOCzVgUKrDSSKtfznq+mAQDl4h5n3g+JaO48EkkJkgSazvr7uQnqVTWmMVY2rFighs2WpkAHB/QODcD0Xo6HGbDpcAWu9rMtABSKpASkwcusBH0EXTtWeqXbmbm+ri31XsbUPjKyoTk7poPaDYOJgWpo8ZpT4kPvhw0HMHH+qWrEcixccXByWSqV7KC29kVhyTvqr5ooDDzd8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWP189MB2611.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVpYUWg1ZXJiRW9Ddk0xT3lUMUFKVlJFNDN2eHloajNIbzZsb0JXdlhiT2dn?=
 =?utf-8?B?WWo4VXlUMkU0RGdoN1JyZWphVTZZSE83a2RNT1dDMXpFcHRvZUF2bDJ3V0R1?=
 =?utf-8?B?bVEyOGdBV0lIbCs5d3pMRno4N1BsbnEvV3FteDhzelpIRXlHSXpUSmpNbnZO?=
 =?utf-8?B?Y1Y0WGd1K2JiWWFYTm5lY2o3WmJPQThuR05YdjR1UEVTYWxER3pEeGNPdVk0?=
 =?utf-8?B?ajNXYnFmdXZBK3dvcnRXNmUvY1ozUDNvcG14M1B6ak1qYkVxOWtyc041U1NL?=
 =?utf-8?B?NTY5bG94V1A5OHNNbk5ma1VsSFpjRkM4My81RDZSS2JuQzl2YnR6cGZJK1JE?=
 =?utf-8?B?QmYvbXUvNEFFTlEycHJDQTVaQ2U0TW1NR05ZQkVnZFdwY05NYVk1cEhUcyt0?=
 =?utf-8?B?QitsRmMrSTJ4VU0zbHZqN29ZcWxsaFR2aDYxKy8zRWcvL2UyaXRJRW5tdUFm?=
 =?utf-8?B?SDg5Q2dIekNOL0ZLcE5RSzhiWnNXbllBSVk0V2I5V0hHbUdpVCtFczBWMExR?=
 =?utf-8?B?bGwyWWxySkc3WFBwVENlSXdpQVVPYlAyOUw5V1NBU0xZRXFUbW9FZFRCTWo4?=
 =?utf-8?B?aXJGaDllY2d4SlhGS1Z5b0x5VC9yV3JQWmxGRlprNUZheGlocTdCUmIxWHBJ?=
 =?utf-8?B?ekhKYzROekRUSlVjdCtzTitQR3pBMFVuN3p0UFdDckh1MkNtQXRaL2xIWGlo?=
 =?utf-8?B?djN6S1dFK0l5LzVIOUoyNjBMU2tRV1BjOGR3Sis4Q3NyQmJWSFY2V3c3Skxp?=
 =?utf-8?B?RGpmK2IwalRBTUZWUS9DUVNYMmtpSW1KUGtwelRhT3JtSHdObUtmSlAvUzM5?=
 =?utf-8?B?MW1CYnV3d3VDR3pOYkQ1Ylo4dE91TmJqa2lDaStNc2dlV0JnRitjb3JtKzFB?=
 =?utf-8?B?cGE5MXFqem9nZWV1eTJhR0Q5Nmx0bW4rVm45V3h1NkZlbTQyYVloNjVXUTVx?=
 =?utf-8?B?TEFtNlVGVzVVL3dkUUhIa3NIdGcyTFVwc05HQ0w2VTNEdDFIRGx1L0V3QVZK?=
 =?utf-8?B?VG5QOE1XTWl4ajM4UGdYTmkxNXN2Y21rNkp4ZnhLcGdoQ093eVFCeGZiN1cx?=
 =?utf-8?B?UnJ2Rzh4Z21ieERzWkRwSWRLTy9yRm9JT2JFRzVSUkwrN3dvVVA0Q0pDN2Zl?=
 =?utf-8?B?ZXFiUW01QzlTRFVabmw3U3czU0FsUFpRbWIzK3UxLzBqTHRlRlQ5dTVXZFNw?=
 =?utf-8?B?REthTXp6b1EzeU5Bb0RieisyWm8vSXBoQXkxSStXcTFseHBkdE4ydWFkc0NY?=
 =?utf-8?B?cXpTN2NCMmNvZ0txZ0ZoSkRUMFBmVTNhK3orVjlrbUJIREcvWVJvNXZJeGtu?=
 =?utf-8?B?c0VabXFaZnJrdE91OC9IUDMvcFpjaTVMbmgybEs3a01HS2lhQTN4WUdXTXV5?=
 =?utf-8?B?bm5SYkVpcytXV3RjZnhRUUU5RS9pM1NwcXFQMWsrays4Q0xjYTdTdXdXall1?=
 =?utf-8?B?UEptZTlKRGhNU1AyUm1HTFVyQ2M4RWxKRFBlWS91bFhrdUJ6YXdVVnF0bXZt?=
 =?utf-8?B?QUt1dGh1TzBuNzlDb3F4OXk1UWJpa0RlMTcrNTFyZ2piL2dRK1RIZVhzZWt1?=
 =?utf-8?B?OXZyRTZkZTJWMlBzclpuN0lHRCtBT1ZIRUoyZTdNaU1XZ3RXblBFZW5qQ01I?=
 =?utf-8?B?WGNtSnUrUFVZU0V2MU5rbTh3MGhEMjcyeko0ZEtKNVBjTEllNkl2K01UVmc2?=
 =?utf-8?B?c0ZXQXFZcjc0dVdUT3JOSURwVG1UMlVxWWYwcjAwZ00zQjVJbWNzMnJnajQy?=
 =?utf-8?B?NFQ3MmVFSmFSNmZKckdhUkpnY0ZJWWJLNzIyU1dNNHgwTVBqakt1cFJjNUo1?=
 =?utf-8?B?QzUwTnB2VzVpNE9ISTJ4N2hpV2pFbmF2T0JONzNUZW11QmtnWjNpRExsbGdX?=
 =?utf-8?B?djVuaFRGRnpxNXVUekhmdnFiK0JXRi9HVHNKWWxrYzV3VkozRFM2ZzFnZHdT?=
 =?utf-8?B?c3FsU3EycEhMQTNROU1CV2hwK24wVHBhT2Jadm1COGFqSnYrNUxSbnE2UXVm?=
 =?utf-8?B?YXliQm5xeDUyWHlXQ3FtVi9jYkE0SHM5bzVvQ0duOHJJN1g5SHo2b1J6amdx?=
 =?utf-8?B?MWRseUNNN1NMUnFNeXg1ZDMwbmRtTkZqTzFVb0orR2dwa2ZYWmVBZVFIV0lV?=
 =?utf-8?B?ZmdZYXBHa2czbWdVbXVyZWRVVlRlZ0w1ODA3UThIR0h0dklERTAwR2RRSkhW?=
 =?utf-8?B?UkJpdVdabm5QdkVzWFJVQnVhTG5udEdlU0sxRzVaeGtlNmVBMDVQUHRDUE1M?=
 =?utf-8?B?MjhsWGlkK2h0N3ZWTWl6dVdhREhkU2lHSmJFM1B4dkI2L013VmExRTlNU2pW?=
 =?utf-8?B?cEk2WVdQR1I1c3d4SURUQURkTEJzN2hPMHRBTnZia0MyUjBqeStqOW16Y3pu?=
 =?utf-8?Q?rUSyVjaj3oRnN+6o=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 4673c93a-1378-4dcb-2457-08dea567a592
X-MS-Exchange-CrossTenant-AuthSource: PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 20:49:31.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqPNt1kYYvMxXMlfMyv3igHU6DVs2glZ2m/gHdLAvAwkgwbfdS3+Gk4FxMQCeI//1uP47CKlQhtcYmve9xbP109Q+vg3meHVmuIhH7OWvRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1894

The device memory callchain guard introduced earlier in this series
needs a regression test to ensure future refactoring does not
silently reintroduce the vulnerability where perf follows frame
pointers into device memory.

Add a kselftest that exercises the exact attack vector: a process
mmaps /dev/mem (creating a device memory mapping), points its frame
pointer into it, and is sampled by perf with frame-pointer
callchains. The test passes if both the process and kernel survive.

The default MMIO address is 0xc0000000; override via the MMIO_ADDR
environment variable if that is unsuitable. The address must be a
physical address that is not backed by any responding device, so
that an access produces a synchronous external abort rather than
returning data. On QEMU's virt machine and many modern arm64
platforms, 0xc0000000 falls in an unused region of the MMIO
address space and works for this purpose.

Since the test only sets the frame pointer to the address (never
reads it directly), the only reads come from the perf unwinder —
which the guard blocks.

The /dev/mem mmap must happen in the child process after fork.
fork() does not copy PTEs for VM_PFNMAP regions, so mapping before
fork leaves the child with empty page tables — the unwinder gets a
translation fault (caught by extable) instead of a synchronous
external abort.

arm64-only; skipped on other architectures.

Assisted-by: Kiro:claude-opus-4.6 [kiro-cli]
Signed-off-by: Fredrik Markstrom <fredrik.markstrom@est.tech>
Reviewed-by: Ivar Holmqvist <ivar.holmqvist@est.tech>
Reviewed-by: Malin Jonsson <malin.jonsson@est.tech>
---
 MAINTAINERS                                        |   1 +
 tools/testing/selftests/perf_events/Makefile       |   2 +-
 .../testing/selftests/perf_events/test_perf_vmio.c | 114 +++++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16388f590a77c04e08d2d6d002f5cc..5416f80c4aac28a5f1d780c76bb23110283dcdc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20881,6 +20881,7 @@ F:	include/uapi/linux/perf_event.h
 F:	kernel/events/*
 F:	tools/lib/perf/
 F:	tools/perf/
+F:	tools/testing/selftests/perf_events/
 
 PERFORMANCE EVENTS TOOLING ARM64
 R:	John Garry <john.g.garry@oracle.com>
diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing/selftests/perf_events/Makefile
index 2e5d85770dfeadd909196dbf980fd334b9580477..a432e24d9e493f77951092571989249703d22351 100644
--- a/tools/testing/selftests/perf_events/Makefile
+++ b/tools/testing/selftests/perf_events/Makefile
@@ -2,5 +2,5 @@
 CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDFLAGS += -lpthread
 
-TEST_GEN_PROGS := sigtrap_threads remove_on_exec watermark_signal mmap
+TEST_GEN_PROGS := sigtrap_threads remove_on_exec watermark_signal mmap test_perf_vmio
 include ../lib.mk
diff --git a/tools/testing/selftests/perf_events/test_perf_vmio.c b/tools/testing/selftests/perf_events/test_perf_vmio.c
new file mode 100644
index 0000000000000000000000000000000000000000..780c5800dd6bd3b7a9d3813b490d4621da876da3
--- /dev/null
+++ b/tools/testing/selftests/perf_events/test_perf_vmio.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device memory perf callchain unwinding test (arm64 only).
+ *
+ * Maps a physical address via /dev/mem (creating a device memory mapping),
+ * launches perf record to sample this process with frame-pointer
+ * callchains, then points FP (x29) into the mapping and spins.
+ * The test passes if the kernel survives without crashing.
+ *
+ * The default MMIO address is 0xc0000000; override via environment:
+ *   MMIO_ADDR=0x10000000 ./test_perf_vmio
+ */
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+
+#define DEFAULT_MMIO_ADDR 0xc0000000UL
+
+TEST(device_memory_callchain)
+{
+#ifndef __aarch64__
+	SKIP(return, "arm64 only");
+#else
+	unsigned long pa = DEFAULT_MMIO_ADDR;
+	unsigned long page, off;
+	pid_t spin_pid, perf_pid;
+	char pid_str[16];
+	int fd, pst;
+	void *m, *fp;
+	char *env;
+
+	if (getuid() != 0)
+		SKIP(return, "need root");
+
+	env = getenv("MMIO_ADDR");
+	if (env)
+		pa = strtoul(env, NULL, 16);
+
+	page = pa & ~0xFFFUL;
+	off = pa - page;
+
+	fd = open("/dev/mem", O_RDWR | O_SYNC);
+	if (fd < 0)
+		SKIP(return, "cannot open /dev/mem");
+
+	/* Fork a spinner child with FP pointing into device memory */
+	spin_pid = fork();
+	ASSERT_GE(spin_pid, 0);
+	if (spin_pid == 0) {
+		/*
+		 * mmap /dev/mem in the child so remap_pfn_range populates
+		 * PTEs directly. fork() does not copy PTEs for VM_PFNMAP
+		 * regions, so mapping before fork leaves the child with
+		 * empty page tables — the unwinder would get a translation
+		 * fault instead of a synchronous external abort.
+		 */
+		m = mmap(NULL, off + 4096, PROT_READ | PROT_WRITE,
+			 MAP_SHARED, fd, page);
+		if (m == MAP_FAILED)
+			_exit(1);
+		fp = (char *)m + off;
+		__asm__ volatile(
+			"mov x29, %0\n"
+			"1: b 1b\n"
+			: : "r"(fp) : "x29", "memory");
+		_exit(0);
+	}
+
+	/* Launch perf to sample the spinner */
+	snprintf(pid_str, sizeof(pid_str), "%d", spin_pid);
+
+	perf_pid = fork();
+	if (perf_pid < 0) {
+		kill(spin_pid, SIGKILL);
+		waitpid(spin_pid, NULL, 0);
+		close(fd);
+		ASSERT_GE(perf_pid, 0);
+	}
+	if (perf_pid == 0) {
+		char *const perf_argv[] = {
+			"perf", "record", "-g", "--call-graph", "fp",
+			"-p", pid_str, "--", "sleep", "3", NULL
+		};
+
+		if (chdir("/tmp"))
+			_exit(1);
+		execvp(perf_argv[0], perf_argv);
+		_exit(1);
+	}
+
+	waitpid(perf_pid, &pst, 0);
+
+	kill(spin_pid, SIGKILL);
+	waitpid(spin_pid, NULL, 0);
+	close(fd);
+
+	if (WIFEXITED(pst) && WEXITSTATUS(pst) == 1)
+		SKIP(return, "perf not available");
+
+	/*
+	 * The real test is that the kernel survived. If we got here
+	 * without a synchronous external abort, the guard worked.
+	 */
+	TH_LOG("kernel survived perf sampling with FP in device memory");
+#endif /* __aarch64__ */
+}
+
+TEST_HARNESS_MAIN

-- 
2.51.0

