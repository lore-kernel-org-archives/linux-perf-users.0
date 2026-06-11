Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9CD2BDC2A;
	Thu, 11 Jun 2026 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173968; cv=fail; b=NlIl1tS2aQOmlibPhTI7zUHaB+MxpNuMc8MK8kXJv4s29yWsKkULh+n9phwHYsXFVp8yZD8dGfg31k1nHSJah0qp1yNEmG19fa3zyJm+ek8uvEUrV/hgGUBjCDyhnL8C3MxCzHLEm3ZfFXZUUIVyEt7gueXnEr54GPM351bKT8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173968; c=relaxed/simple;
	bh=C8n0cOvP3wq6ySPsnxZUbM8QXKwzAWWUZ8B2Qietboo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mK+3O5ORXJRTzHIUoAY+vlF6thsU/GERL95t0aIEbKPA8edNoq+CVyMKtwfz3swOQCfOm0Vzor497GdynBZNWmyaqS3e45wGA+Zfw3e9x6zwA2y5s6Q4vfL8/U/M98UAocf0Mv88jjIgsfadh6ABl5NAUNmBBBVMRXqqATSa3uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=GDn8+Fep; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="GDn8+Fep"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1ARmgkmjWRdkHEmtv5IIgC6ysUy+v2TIBkk3j77t9yK5RkVfefQK+HAcWZplxoU4E6O5TWO4PUiLg5FcJ0hZp3lSMZBU97ldwNRSgj0p+WDC2zvLvrnL4MyM6cyr4R1FoTzLQCrQ212wMxt89wU7sziVcvQmXHf1hPt8klHzpjxt1M3dea83LOl5PYwhz8j6zXIQy75nYnPTq2dj0z8cobzJtlTDjGE+g/L7KKiUxqbrCGZirALRAzMTHhFD/BIX4Tc4CHPDe2+cKGQUbs/1KBQCz02lXM/Uh2FKjuZj+LHH2HSaB20cIbra9vEAS0UU1CVn7zKIMv0mTyuvpQYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnd8vlPEsWgjfybe30t7rk9585OMv/hmR4w5iE4Faao=;
 b=kj7OURoXeajCMGbcB895WSllM00tmGkWjO7d2OlKbHOqq4yIPH+Eb37V/R2oGu8NZixNL3KCzaySF+La16wXVcPN9vmP58D5rLpqLo2bFn3XjYoTs0lz5ZNh8kse7GrjYshfhLLeduI3hhc7qViPZeLvT19OtFQUmX4+ta2yDJ+wgs45RxPKgCaANSy9R9JMIbfWKmXd4o1XZl+kAUHvqaOZN9NKSezpHbisPX4LVA6fWam9r6iY4bMPyH5OAjTBZ65flMG/ucgObTici2Zu8t7tCxyWZvfQhF3ziTW58XT9g4lKkjrDPz7uaOd5DAUSZrf5dB5Jt6lo/95Lm1XMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnd8vlPEsWgjfybe30t7rk9585OMv/hmR4w5iE4Faao=;
 b=GDn8+FepYOgfP9qvwyMHAFJvohhz293b+LXEITLr5DsaPU0PpTu8DyUiUJIa5pb1ZU4aEBIMCHsMooAoLbL9zkWA9GP8/c6rTbiWabYHdkyGTJxasI9IpdF6/T12xtAjN/UInESJPImSffszBpyIwaAgMm9mYn6mku8CIR7SjSAsDned2wX1JKMtOkxMf9PYgUEPVViOBrFaBuscV/T8kLY2u/fMxM529U1wMO6s4/1vWwxG2X1xOR+tpV9nfExjOGeDS6loHion3aQpozRGPMT4yxm8rCnNflokTreKmDCGuZ2ZcjGynSaPpSMyW0oWdvyM6XZnErFFG6m8NieoZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB3P189MB2624.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:438::18)
 by AS4P189MB1848.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 10:32:42 +0000
Received: from DB3P189MB2624.EURP189.PROD.OUTLOOK.COM
 ([fe80::8cd0:287c:2016:db67]) by DB3P189MB2624.EURP189.PROD.OUTLOOK.COM
 ([fe80::8cd0:287c:2016:db67%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 10:32:42 +0000
Date: Thu, 11 Jun 2026 12:32:40 +0200
From: Fredrik Markstrom <fredrik.markstrom@est.tech>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Ivar Holmqvist <ivar.holmqvist@est.tech>,
	Malin Jonsson <malin.jonsson@est.tech>
Subject: Re: [PATCH v2 0/3] arm64: perf: Skip device memory during user
 callchain unwinding
Message-ID: <aiqOyA_ygr_ZImii@elx-5cg6022w5t>
References: <20260430-master-with-pfix-v3-v2-0-bd526ec04a75@est.tech>
 <agsq4wZMGth-T3BG@willie-the-truck>
 <agweYAbxRWOs41BE@elx-5cg6022w5t>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agweYAbxRWOs41BE@elx-5cg6022w5t>
X-ClientProxiedBy: GVZP280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::17) To DB3P189MB2624.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:438::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3P189MB2624:EE_|AS4P189MB1848:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b7b3e6-0243-416f-8b9a-08dec7a4c470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W6jDP6Q/KxcEKJ1DRkyNj04HGmzzB0AcJ1mC7MDjuXCFMgyvz3TVJIVJ9jDc10YdptUBzAtQZzN3tKSD72VulmXGNZM1i5VN87Rqz72FzF3VtgPWNsxG8/ZljnVTMN1wW2bo27sG47S92+jL6Z1Ib+udC0c+xQxcVtO+U3sR3oq7b3spVynBHAk8q/imkQjmI4MiATBkLxoer1fhzKJqc0QM8AofZbS+YroelHccK5guLLxRl+DnSGwIvIHfdEov2tR4EGKmjLHdqLS8JXQ39Srp8ZjV9N4JZq/XPRSMkpLSjFIp2tlWFvsLk94KMUhOhb5CKwaO8OwjaGjBXz/kz761TpLCxAS1pg+cLIATE3yJbPGlllXNvFpYvHf4Xam+FrivlG+Z4gmYVPkpxNHxDQTcvZAl8/4BkJlzS02QozrsK5wBPV/gVPqaURQPJP0tOA0d+QuOLFrkBcBUOc5dI0WwmaASkkRsuat++gqFSKMk2Hw6k7zOVLzDZdpItdTdtAC7quvElK6YRA8kBCC7JJDL/PmZzgIrjI7Ob2cy7drrV0INHrxl5elp9TzMuKzp8iTyZZcBZa/LtUF71WXM8UYZ3OlTocOUfuU2K6geK7v99jn7droURlx5aFMc+4MrLwTbEvH+9h8oZsabI84gMO0q38JYAonybXUXIjtyg08/ODehj2mNb3RU6YvFyY89
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3P189MB2624.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1pWNW1UaWxxOU0zYjFPV0NhRXAwcDdjK0xpVUo5WVFaREFUdG13bDNXNDNN?=
 =?utf-8?B?MCtVdVZOMzVsbDV2bHh3aWFPeVJmSnFkOHZ5WGdueGNkU3ZBeHRDeTNmbzYx?=
 =?utf-8?B?NlNkeEZVY01MbktQdDBLTldOdU1ENmhkZktQaG1jdnJ2NUF1ZjhpUk8zdjgy?=
 =?utf-8?B?ZEdMQjNPMEIxNjBZZDhZVmFORysyVmZaK0JET2VmaFFJVSt3V0FVcUszNUNx?=
 =?utf-8?B?UzFuWUVnUnp6aU5LYUdyTUpaWjlWbWhUL1ZMQlhQekxoRTh0OFh2SDFNMGp2?=
 =?utf-8?B?aTM2bTl6bSttbXU1RklGTU5MSFBxQVkzYmF4RUNrSkU2Yk9NN0xmOFh6bDN0?=
 =?utf-8?B?UGU2WlB2NmQ1Y09nY2tyWFVQNktWb0Z6a3d2alRiM1JwbUlTeVB3aVNRRkx0?=
 =?utf-8?B?R1RGTzJuVzM3VU9SN2hubzBsR2hjQ29CWk05akhJeStvakVzNWg0VkdoWGls?=
 =?utf-8?B?b0trM29JZFRCZW5nNUI1M2JMVWFKY2cwY1lFelloVTl4bXlmL0NsdUxzYS9j?=
 =?utf-8?B?ZjRtNUo5Nnl4eEJHamNkKy9CcE4zY2gxc3F0U2ZBRS9uT0tQU3Ftd0xmcXpu?=
 =?utf-8?B?Sjk2QXczMUo0d1NSdWJxd05BWVhlYW1EK3pVZldtS3YzeHh5TFpuUDJ6OFho?=
 =?utf-8?B?YytUTEtyMmR2RWFUMEdhTEg0aEtyZ25KTGw3WElFelFsVlNYVUM2VVl5R3ZJ?=
 =?utf-8?B?NGVxWXBPT2ZXVVRmREs4R3FqcVBTeTZRVUpJT0pmRjc4ZzRVRmVoekVtRFFx?=
 =?utf-8?B?N3JHRnB6SGNMVzYvR05DQnBUZXpjcmVMTkJxcXBtdThSUnJ3T3g4aVhjTERE?=
 =?utf-8?B?c0UzZzBMSjM4VmpZdk5YWEs1cW54UE9qTHZaeXk2WnV0TXdFSWcyY29pRzVh?=
 =?utf-8?B?ZzZLb2NOUUt5d2tTa0FqTURQWjZXRXZmd3pHRkppNDdyWEVmbmZLanE2YXlS?=
 =?utf-8?B?eFdjeXF3VXM2QUZubWlPaVphaXBuYWUyUVRacndQWGV0b1lvSlZrb1pQU2pz?=
 =?utf-8?B?aCtrU3dCKzZBby9jcnVLNXVEL3BxY1lsa25lUEFXVUF6RVdMeTVGN3VmZCs0?=
 =?utf-8?B?eEwray9OOFhUMk1YN1hyWFBIeU1lQXVwUVA3VHZnUjgyVGJWSDRKWXBrbmRM?=
 =?utf-8?B?cmNFZGVUdHd6NWdGdWo0SkdDbENBWmxHaDVlOSs5U2JMay9DSiszRWd1ck1V?=
 =?utf-8?B?R2tmdzJWU2tvUUZIcHRMRVV5MFVEanBMM1pZS1VUSUdpYmtxZ0hkMEd5Rkg0?=
 =?utf-8?B?SHRDR3E2QTRnUW5rS0pRTkZFT3dna0crZ1dJS3Rtb3loVm11QXcwNTlXZ1l6?=
 =?utf-8?B?cVlQM1pMeU1jd2RHYllpQitIc2lMeWxRRUFyRHRjck81RWw3RFZ0VStjQ003?=
 =?utf-8?B?Tks4ZUdVZ3Q2SGs3Y0JOUW5KTnU0bU05cFFGclFNVFk0ZUtkZUFaOWhmeDVM?=
 =?utf-8?B?bGFYMGI5aGR1MThFYjhJSWxXL2F1aXZTekJ5bnI4QjlNVkNVVjMxRzIzYVN2?=
 =?utf-8?B?YnpGaE5hQnptWmQ4TUt0bjFvUFhYWVloV05LRlFrTUFtLzE4eThYWjJDUnZG?=
 =?utf-8?B?R0dzSklERDZXTW1XVGhTR0k1TnJCRmJDZElsbXM0R1dQUXoxSFZDcFBLRWls?=
 =?utf-8?B?SXB6bVBKVGxXWldXc0ZHTVVOWmNibGFVaUEvWklIVWx2UFlKdHRQVXJJTm5v?=
 =?utf-8?B?aDViVEIvdEQwbUdJVGFvUFk5bnJGVVpOS1pvcEVLT2pSOXJLbFBubWFwY0V0?=
 =?utf-8?B?eE9pM3ZVTC84R0tXa1RlVjZlWTYyaGpaT3NXY2ltTWJidE9FSFRMTFlzUGhD?=
 =?utf-8?B?SlRVQzRSa0N4aDNOckNybVNjMWgybFhvd2kzalM5S01GdWdicEUwTFZSNWFs?=
 =?utf-8?B?c3NIcDg0cTNON2VkbFNPMGFNdXRid00rbm1acnkyV0E3SjgyaEpoZFlLS0NS?=
 =?utf-8?B?ek94b2xCUWFmM0ZIWXdhVW15Rjd5MnhadEF1K05qYjBUYzJMVEZJQWtrekJ2?=
 =?utf-8?B?bmV2bmloeHA0dEhXTGprNWZqL3F4N2RJejV4SkJGTTgrb0p2bm52Q2JoaGww?=
 =?utf-8?B?a0JvZUJwMk5JS0lYaEZtU1duM2xqd2p4bkgvZ2NwOE5rOExLWitObEJkL2dy?=
 =?utf-8?B?RzhPbXViTHJuQVg0c3g1UmVxYkFvOHlaRC9DbEJsbW9CWVNGRVhVR1NvQW5y?=
 =?utf-8?B?TnRpdzJsK3dwWloydklmelR2QVFBblhTaDU4SnpybHZGeUt2RkJzcFJMZ3hs?=
 =?utf-8?B?KzFDYXZaaDJmbVp6VFhYaXJ1akU4MWd3alJTZGhHS1pobm5Fa0QyeThEUnhB?=
 =?utf-8?B?OWxHOG01OVBXN0lzTG1tcFZtd3ZuWXRhV3h4KzlBOGc3bHpLSWNRdXRGL2Nh?=
 =?utf-8?Q?MiYXIoTy1Wy8UOUA=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b7b3e6-0243-416f-8b9a-08dec7a4c470
X-MS-Exchange-CrossTenant-AuthSource: DB3P189MB2624.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:32:42.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAuRe2uRCxyrBEt+6HDnZK9eJOvQhqcvD+592MU6DZ/JKsLATTz6C3m0oEe7nKB1PVWqqCK0UVLMhXpv823qVpOJJr801FfpPYk7nKBEpX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1848

Hello, is there anything I can do at this point to address this issue ?

/Fredrik

On Tue, May 19, 2026 at 10:25:04AM +0200, Fredrik Markstrom wrote:
> On Mon, May 18, 2026 at 04:06:11PM +0100, Will Deacon wrote:
> > On Thu, Apr 30, 2026 at 12:55:12PM +0200, Fredrik Markstrom wrote:
> > > Perf callchain unwinding follows userspace frame pointers via
> > > copy_from_user. A corrupted or malicious frame pointer can point
> > > into device I/O memory mapped into the process (e.g. via UIO or
> > > /dev/mem), causing the kernel to read from MMIO regions in PMU
> > > interrupt context. Such reads can have side effects on hardware
> > > (clearing status registers, advancing FIFOs, triggering DMA) and
> > > on arm64 can produce a synchronous external abort that panics the
> > > kernel.
> > 
> > Hmm, but why is unwinding special in this case? If userspace has access
> > to sensitive MMIO/device mappings, it can presumably pass them to
> > syscalls and trigger crashes all over the place?
> 
> You’re totally right, a broken app with access to hardware like this can
> already cause chaos by passing bad pointers to syscalls etc. But the big
> difference here is who is to blame when things crash.
>  
> If an app passes a bad pointer to a syscall, it’s self-inflicted.
> 
> Unwinding here is asynchronous and unrelated to the application.
> Perf interrupts a perfectly healthy app at a random moment. If that app
> is using the frame pointer as a normal register (totally legal in
> optimized code), it might hold a junk value that points to MMIO memory.
>  
> If the kernel blindly follows that junk pointer during an unwind, perf
> causes the crash. I think it's acceptable that an app (with hardware
> access) causes a crash if buggy, but I don't think it's acceptable that
> a profiling tool is causing a crash just by looking at it.
> 
> Fredrik
> 
> 
> > 
> > Will
