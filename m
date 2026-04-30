Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7013BFE3A;
	Thu, 30 Apr 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546550; cv=fail; b=BqZ5sXXp5yfBnpqS/mREC84hic4jgBfWidWbFEc+TbUb5KpqMNj3NIrefkmg1pKeb+OiWwQfjUUMwXXliDh9IsGeVTtvw3SlmETrIeSFJog7zGAJBLC5ovGapdXFLs/Kd2OyzNM20a5OQgBKyQnJiF/niN9eTdIowe5PQiu8PtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546550; c=relaxed/simple;
	bh=0tNePIa2kQRXIa/Bj3oJrrHN/P8EaLRtEp6RYIHY8Lg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FqupQTqsmjL/zUr/Vn85BJos8A9eplxBCmT4ZZHi0n8laU/vmI+QQWsM/bjT+rMYDxP99LDdy7L74LrekS4cFtDLrcA0KfW7vVoIIteligA2nGRlpKhnBpBzzfu290crRCfo07eIWv508w3XQfFHUesNx9UIO0zbwKiLKMcOdj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=RpzcjQ0i; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="RpzcjQ0i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoO3KMR4gaz9z7PdBje6WJXLnuy0kBMMBVrh+K86KeFY8vYTdZjTyVspaIZAq/BeT0pKEgq8PC5b+1i5xcff/svsHJFMytbzV247IkSdp7uxHGC9y5Jr79PO4qUgO4I8jmc4WdBr3ZHThPmApCJrR6/NBqPI8PiOhTKC+amr7t3NADVvfuQ0Vkytbn9dVUxLElen+k7ZP7wdQ3w/7cGrX28Swvwjhngt1hm/1y2wpJ8CqkS2Kux55cv4yrbE68DUNjMn63AjRypw1oMhHpeceoidYgy6EYnLrLmdscGPymurz0vW928gV1T2nLvdoeZB3KssmNDJHMLnkqKhgeoxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7PLHIF93Vk5dxSnqUydDv0irtq8kaE5CWfBQ8dQF0U=;
 b=CWPGCzWgGy80J3WDGtZ2CedMgft+IOqf5L2HMxy31TO5abs+/ngofy54PQFiF7wX/Njoy8c8t3bPc+ovCwq3MqQVfjFO9PLTQWH5vdSzHiNpaa7sNVfcAjd1ja0pKuLDnEYjWthNNI/aPlS90y95HHgK8RTa0CC2HjM0P4dzux5KNa7Lr9GFpMAxwGSER1wz5wyT0jy/aAI5QDavBZK5mQJau2jSf3zNKqQvyYx+MHBD6Pr7NmvAN0FJ2Xic2SfMfWYGMq+zBO1+QnS18wOga0xRZRhss9eNBMDp+Baxq2JcC5AfEBscoEvNK1hib6mrpgR2drluNyXo0ZuQlFfyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7PLHIF93Vk5dxSnqUydDv0irtq8kaE5CWfBQ8dQF0U=;
 b=RpzcjQ0i50E6yd5P6TNYy0nnYsV9SEDc3J83eR2OsVTztOI4cdMEGmeeeC457YfdE7c+GApl/F4I8k9an4HmMxxDaWgQ9/EqKd/g3tplOIG+TbFnaVBGOLLQCXTOfy04APSU9a9yh7UkrMiUqcpCAlHha6fAFyyAdyimO8LeiiK+06udxFISbujDiQPkJNmr/yPY3VNYBc3QXIR1lDeME2uSuYXS3Kxe89X5i7zNj8uoWPVdMwunekjv8m50nvoKZl6DtucPx8oK3A0LkQaDAyqGuGC0IMos0Ih256XqiLT6WHj7hHafWg5PpaJN6bWCGgFDuhWTTUGXT6jvZpiGiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:336::8)
 by DB4P189MB3117.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 10:55:37 +0000
Received: from PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884]) by PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 ([fe80::b400:cf4f:b2e1:d884%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 10:55:37 +0000
From: Fredrik Markstrom <fredrik.markstrom@est.tech>
Date: Thu, 30 Apr 2026 12:55:15 +0200
Subject: [PATCH v2 3/3] DO NOT MERGE: selftests: perf_events: Add device
 memory callchain unwinding test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-master-with-pfix-v3-v2-3-bd526ec04a75@est.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777546525; l=6672;
 i=fredrik.markstrom@est.tech; h=from:subject:message-id;
 bh=0tNePIa2kQRXIa/Bj3oJrrHN/P8EaLRtEp6RYIHY8Lg=;
 b=4Yhf0lC4xgm80/9H7DwHJ7l4cawXTt9M0lBdJeSkAtJKEMEgZaLUixrD/+0XQ3w0mcCacTdPj
 RyUFLEUSoS/Db6aGEp1FdJ5nWETjXPg2fe2Dzu0HlvG7nfEV7lY8tZ7
X-Developer-Key: i=fredrik.markstrom@est.tech; a=ed25519;
 pk=0a8IXHEgAX55JPS8VZfTf1sDp7q/oAOf459tDQd40Eg=
X-ClientProxiedBy: GVX0EPF0005F6EF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::256) To PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:336::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP189MB2611:EE_|DB4P189MB3117:EE_
X-MS-Office365-Filtering-Correlation-Id: 3617eeb4-94f9-4002-8f18-08dea6a70311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	fLIo981yaqP62uv4JuW2s7Ia23Iyq/rJQ3MBGcYFz8DwrdvYD/tdKEUk4YNObd4dzBWAks7272QO5iSBH4EU8HHv8pKORCtvoyajAkEDKSCnoM1OP0EYtd7W2bna6nvMqVIyVrqIl9VfjoD4mmTrH4G2gu7jctVbuxC2b23PxBX4AEUsNgrYzC1plCIfGkwG75N/hjx9c390YRi78v3DXTskTyuBh00eWi36PIfBT3CJv5MvrVApCUQ0uw5l7Vx4mYhxV/8hhzI9xxNeksLbJlRasy7gINmJdnYLMmHBkT9cZukKqgXRnwlDz0xiP3YqT5wJyT3SVdzo9OJYpzKJT8u/O3L9hXSExC3WymkXmSchmsmNj2LAYPZcZhnFhcjE8CauezDmMrd6t+zaj3LHNOW0UGKTT+8s0gOeP+CYEh7V4gen3uDjcxPqkiy6hOmOtQ/anN3ViFvQ0ORaYt4A89qp6CX4Cm/3UDFbc7R/QAPfBrdTkHYnXyiLKGbuEibjOYGZRrTyW9B3KRyRhIsh1gxejZXyEHBlfJB6jmXdRT22PB6KzDsZwej93GxAuKUsQKHx6JLJrYUcsYgSIJ0bhpJ7vMQgHgX3MeYb1dsES80WDKnJMbLiDje7lS8bAwL/I9/QGasDbLm3rNB5F1P7OP5XnTw5AuhZi2dcOMYKnA2OovdJ4aMxnVfh5PRbT+9HLB3YuZmWYQC5ml32AJLFwtHMynbFyiTdXskbXXwJOqNzJmR0/H8yt+5RBDY7tYnxpvuC2w+sPZSI+QEWmBuoxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWP189MB2611.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTFKZUVQWlg2TG9JVXVTemlXWGJOOWFQUXZBR3BoWWxjcnBmRHZNOTd4cjVK?=
 =?utf-8?B?TDUzOXlYZUtnemV4RW40cFJUYjdrVzBmUzVTWU5qODdxK2JZU2lOZjhhS2lE?=
 =?utf-8?B?eFdDcjNCTnIzVzBtRXBrYVk3eVh3NmFZSzNwTEk5QkVNOTMzb0wrMVpOUVVo?=
 =?utf-8?B?RUd5Z0RGWVpEdXdCZUNvWGdoYTVWMEdsZzAzbVpjcUFJN1UyOW5lY0dwdTlC?=
 =?utf-8?B?R1hCVDhQOTcySFZBTGx6YTZiMGczK2VOTjlEbkVwNUl4cy9UbXMrZ0VOVHVH?=
 =?utf-8?B?VCsxSXpnN29Jb2tXM3A1ZWxtQmZZT2Ezd3NPNGZGdGQzcXduMWZqQ1p1RFVU?=
 =?utf-8?B?b1FxL1A2Zm53c3ZXaU5mKzJManFLVVlBdkVzQ0QzMXRGOHp5dlRLMlA1MUJJ?=
 =?utf-8?B?UnZiNmhqWXVSV0pQQlNWOG16QWlaRHprZFE4V3luL3dVQW5HbktzUWg4QkI3?=
 =?utf-8?B?WC8wVGxaVmVmai85Nm5hemFQK1hKM3RoZHlVSFFqWGliZWdlMVpPZE5nU2dV?=
 =?utf-8?B?c0FReVd2REVRVkFaVlhtRkhWWC85RC93RDhzZ0NKdkROK0hrWUw4a2x1SGNk?=
 =?utf-8?B?MUNnM1g4cEhCc3RhbWR0RVR4eHhTQTBZSUkrcG9qSm1Oa2hGNjNDeGZFaVBQ?=
 =?utf-8?B?L2FNczMzOTQwK2xqaVZadDJIRWdrVWxYbVRvb3VXQy9GWXpMaFhXbG1FYnA3?=
 =?utf-8?B?UjR2Sy9tYmlkSU9LOXlhWExTVHpKdUlISDh1bFY5MUZwaWprQlNmNVZVNTJS?=
 =?utf-8?B?emFjU1p2V3UyMllMeXpwdmZ4cWNZWWcvUlFiaUNONlIzZ1NzL3hKaDNoQVlC?=
 =?utf-8?B?S2o5OHJiWjJLaXZJdTREN2ZNa0xjd1MwWmZJR0NVZjBYLytxZDhPM2VjVFlF?=
 =?utf-8?B?aFcyNDQ2eE5TRzZCa3dqY01jRUlMZjVjWXRJL0xhMXNYcGYwMTBPSkZEQU9y?=
 =?utf-8?B?c21VcDR4SWxYRG51YXBmUFZaOWZNdjlHUHFOMml1S1NBZE1KT0ZRc1ZsaHVa?=
 =?utf-8?B?aWh6NnRpOGVVbksyRFpiSnE4SWVZZFdWY1FIU2VmbFdORlUwblBWYVd6NWw3?=
 =?utf-8?B?T3pDV2ZPUGNKclIyYUNqdW5Ibnh6eGJtODcxNEhpdGFkL1JEU254NGUrZGRq?=
 =?utf-8?B?QmdlL2FtVG9ueUdYaFA2N2dIU2I1YzQwUnFLaUt6MnJFbGljU1RjOHF1MW9s?=
 =?utf-8?B?bUlJeTNnaFdxeTFjL1ZlRkx1ci9Ob1N2V0tmWnplMDBldGp0ZG5wc0VjRGpa?=
 =?utf-8?B?L3oyT1gvdHlMMHlNb1JrOG1abEtPQmc0ODlWM3Zad2M1eW45M0JIcEJlcEVm?=
 =?utf-8?B?aldyZ1JLRHA5NzAvaDh3a3g2cm04SE1aTzFFNDFzUDREb25wMlRhdU04Z3RR?=
 =?utf-8?B?QjZtNk5QTXVmYy9DV1FVSXVud2Z6dVFyVFVRMnB4OURtdWx2WmtoMCtSTzhN?=
 =?utf-8?B?dGdPajBXa3ArR2h3aG0xVGdyUUIyc2ZxVVl3eXdPWitGTUVhZjk1ZC9DZ0t3?=
 =?utf-8?B?TitZZGkxTWRvYkxwKzlUVG9LNys4bHJSTEpJNXI3TzZkUktJVWVvajZtQmxZ?=
 =?utf-8?B?T3NsemNlbnlDUXVyeTNYUFc0TFIvM013enB5ZEVZZ05FOUk5M1lmNTJaTGZH?=
 =?utf-8?B?aWdBa2VWL3JHOWVjdksreUh6ckx4T0lMeG1kUURnWlRNT1lzYzBxK3RoNkxD?=
 =?utf-8?B?eFZrbmpudFBRVGhuV3hiQmdDUWtHTkh6VTc0RkhNOEo2MmJlR045b3ZRZ3Ft?=
 =?utf-8?B?Um1VYWdUZUJaNUpXTWtiSkhpbHZGMlJTeU9XOXViT3I2aGIvVDZtazMzdkwv?=
 =?utf-8?B?TzFqK1pxN1NZV3lPWTFxSDg1M3RWb2ZVNkQyaWtVMERDT0F6RU1XeEcvZkw5?=
 =?utf-8?B?VkhRNVFuL1BENE55L1B1K2hwdnNQaEpLUUg3bHZHdEMrU0hGTDM0c2ZMZGdM?=
 =?utf-8?B?RU1Yb1JyS1IzdVNHNTV0OEJ0NUhLUFl2bk01YnRick40UGZ0TVFNdWcwM1Fs?=
 =?utf-8?B?eE1XVzRaSzRZZkZVeGl5aVZMcEh3K1VzOVNzSTRwamJSUHc4QnhFZ0VENjhm?=
 =?utf-8?B?YmZ3OElHWHpUejZjakI5NlJVUWw5Sno3RUtwU2FJN2xGcyttTmFvM2lvOHhB?=
 =?utf-8?B?bG5uZ3JYQXF6YkNJZktlTUlPU3RrNGpmUktqMUgwbmp4ZitLSUJRVHJ0b3pI?=
 =?utf-8?B?U1QzSHliTGpjencvMCsydFYvME5QeCtYVEJ0UGxWK3lkRzAxNGNEcFoyOWYz?=
 =?utf-8?B?UHd1RWp1QjlrbEFnZGVFZHJ1a1ZzM0J6VEp1aUp1Yms2eGc4by9KTHh3S1dB?=
 =?utf-8?B?dEtwTmJDSks0YkZEa0g1KzhaMDFtUEtEaXFNbG9VVE1UZ3JvdFRLQVFNeWE0?=
 =?utf-8?Q?9/jED/dIvh0DaA3QLHfy/Wia446eVj+w98a5ha73MiE2n?=
X-MS-Exchange-AntiSpam-MessageData-1: DSFlCrvg+C2iITtngtH/9Wv6uc7jpdrFX/A=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 3617eeb4-94f9-4002-8f18-08dea6a70311
X-MS-Exchange-CrossTenant-AuthSource: PAWP189MB2611.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 10:55:37.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQ7yyywlZhvKp1hYMfnv/r8HodNQ+gYKOfF3y82m4EPYeC6MOL5MW80Q/de1YOSLYXCNF315srYwsOLSyxwH1hxp5bano3CGcEH7au2t1Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P189MB3117

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
 .../testing/selftests/perf_events/test_perf_vmio.c | 131 +++++++++++++++++++++
 3 files changed, 133 insertions(+), 1 deletion(-)

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
index 0000000000000000000000000000000000000000..c9ceee3f15927f26e299dc9ac0edca6cff49c9ac
--- /dev/null
+++ b/tools/testing/selftests/perf_events/test_perf_vmio.c
@@ -0,0 +1,131 @@
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
+	unsigned long page_size = sysconf(_SC_PAGESIZE);
+	unsigned long page, off;
+	pid_t spin_pid, perf_pid;
+	char pid_str[16];
+	char tmpdir[] = "/tmp/test_perf_vmio_XXXXXX";
+	int fd, pst = 0;
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
+	page = pa & ~(page_size - 1);
+	off = pa - page;
+
+	fd = open("/dev/mem", O_RDWR | O_SYNC | O_CLOEXEC);
+	if (fd < 0)
+		SKIP(return, "cannot open /dev/mem");
+
+	if (!mkdtemp(tmpdir)) {
+		close(fd);
+		SKIP(return, "cannot create temp directory");
+	}
+
+	/* Fork a spinner child with FP pointing into device memory */
+	spin_pid = fork();
+	if (spin_pid < 0) {
+		close(fd);
+		rmdir(tmpdir);
+		ASSERT_GE(spin_pid, 0);
+	}
+	if (spin_pid == 0) {
+		/*
+		 * mmap /dev/mem in the child so remap_pfn_range populates
+		 * PTEs directly. fork() does not copy PTEs for VM_PFNMAP
+		 * regions, so mapping before fork leaves the child with
+		 * empty page tables — the unwinder would get a translation
+		 * fault instead of a synchronous external abort.
+		 */
+		m = mmap(NULL, off + page_size, PROT_READ | PROT_WRITE,
+			 MAP_SHARED, fd, page);
+		if (m == MAP_FAILED)
+			_exit(2);
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
+		rmdir(tmpdir);
+		ASSERT_GE(perf_pid, 0);
+	}
+	if (perf_pid == 0) {
+		char *const perf_argv[] = {
+			"perf", "record", "-g", "--call-graph", "fp",
+			"-p", pid_str, "--", "sleep", "3", NULL
+		};
+
+		if (chdir(tmpdir))
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
+	/* Clean up perf output */
+	rmdir(tmpdir);
+
+	if (!WIFEXITED(pst))
+		SKIP(return, "perf terminated abnormally");
+	if (WEXITSTATUS(pst) == 1)
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

