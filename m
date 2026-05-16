Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020076.outbound.protection.outlook.com [52.101.195.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05FA266B46;
	Sat, 16 May 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778940229; cv=fail; b=Vg8HEHY7C0vtynS1H/VeHzeBeesoYtdGyxxYwvGxUnjCaRP4uXj+9iN1cVlN7zFGPnHixOSzwzFHn5TKScEsV3QFJolFLMHPUOJt0IvsW7yfbYGd2PMUhHxazU9hiyKtDlveD7YcNoaXabA9hDT+e96oy8tbGUUct6lHrDV4eWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778940229; c=relaxed/simple;
	bh=Aj20vwQHyE+gK9hXdHgFS/cdYl30yeKMV77nneNfJhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DyC14YTG6341Gb5NluT9qG3+jz1yYX1RbrnOkbyvdcO786wQunszb2KV16Cxjwl1S4EuJt7mW3lp1vhzTjgkfHH8EMIzmS9fikVBkY2wtW1b7HA+8AG6INq5EGkwWMnJo0FMcY0UlWPrNVh4mkaIVLvj8wd9edPcuk69M2QR1CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUCErfUVAygjtYlJVs056NMuQ3BsJ082wRXJQJ7CF77W7okFNmCaayPTxtuoWaKnE/BPUAB7isjW1DHgpGzAvlZ3B6xadNVWInQfE9CCdD7EG0+7ap0g7YHeZ3xivGmioB2WSzX/w8iAkM8qK3Tvk2G9l/5tBVMd19RrTsYJ5sPgsbIT+Kv4kh6M/EJEKfG1mjQKAF9Q8/TcRNZPV9pWDlzq+wOOPOJQkSFmV05WE84ykQJjkLW5A0Qo6jJyeFDf1eCXJmhHG/cBgWSiLveATiNauOaiOb/B2sOU0KmehQ16QSker0XbwWvWYWAsBxpotd0wNyFHWSzv/9AZJbr2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3QoD3nmGQNIdmm8jqiKk//lpUIwCIbr9FRiTyXWgGQ=;
 b=xtW3eppHjW+KGrHs9LpjtUWqlHn9xiJ5CxdQUiFar3ej5QRy18kmPPZFHXk3oxPOcQbVVRleHNXRpBpq5hLGct8t2od5aRTbKhkzvA8Zn62HA8PHwNgcm1jZhdnl00f38HiHujJt3GOjmoC6aPmvk2udWogmp4Kyms041+CXoCEqeTM9jhLKqLc8tC/FIAsvjtizAULsmatInHbzfdyOG4ZQTjO482m10dV3rAjYQ2Qh8rwdK5VKxeZFSRcLMSmYECaRXeMApqeveuGCt+5ote/V4uxbJ6whTlRczfh82Vz9djjrweIc8wzg+4YNmsfZoRabGnI1aVWg5p7qgTyUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LNXP123MB3595.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 16 May
 2026 14:03:44 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 16 May 2026
 14:03:44 +0000
Date: Sat, 16 May 2026 10:03:40 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, sean@ashe.io, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf trace: Introduce --show-cpu option to display
 cpu id
Message-ID: <fjphwjezyi2rfq54kyx6f7z5nee2iurou4ll6rhlporzbqvonr@5qxhd7q6qvej>
References: <20260424212933.151154-1-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ngrdeafkf3efhu3r"
Content-Disposition: inline
In-Reply-To: <20260424212933.151154-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0798.namprd03.prod.outlook.com
 (2603:10b6:408:13f::23) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LNXP123MB3595:EE_
X-MS-Office365-Filtering-Correlation-Id: 288a9377-a902-47bc-00b1-08deb353f0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	Ug7JMpAc/TlrDa7lgVOM99oKcntWMmecxn6dXwU1Hmza+LVMOuwtmd1FvEeMyM57HFI8q5ssA/t3h6fZOXRMHdttdDa3VHs+q1iHq2dz6EsT29RMWf5M8lID5UCYjtPdbsDZWl3vdGFH4KX5U+JKYblvrW/WkM+XpDJphiGClEhoCoZ9Hje0qco9r+YMy9BnoG4AvJCpUV4EXaOkXdFUR2bJ11Ka56VpAZIpx/fWT6chA7/tHYc+0FaduSiEkAw0Q3qZ4KF1lQIZQdu+G+eXGns8c0q6/AmFELBoELgjXAjugMSJA9wzAH/Ir1qPQA8PbHLwBUxFmq6xybIPhTVyBXAbj70DfYEXNfUmBUpjKME02GPRi0V0ciUuTIpTxosukzrq5dlclyUqu8jrVOejiomZ7zzZ9T8pZyfUYlDM7jiprq3A56IiqeaTSWClw7JvcFNwFtS3luefwloliQQMkRAcYvwZBhNNNI5Dp3UhJ5z/DBtoKqAhQCgVLWgCQylIQlVLLkjUk+mQKSVYXlPQiH5DujSP+BYrsI2CcUBlS98Cm97DGMXNe2gt2yjzF4csWZtLVg4AeQhCPIpd0e74OdSz+UMWMijTG12R/d6Dy2b8VS4RXtDopBavPSgmpH89PTLDzPwgc/mMlv221UmE2YZQuMeULaiNtfjNbDt0ihN3RH5GHfYpOV6YP1TkZby84XlrmhlqKFKnRbNq79UApQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnlMQkhEc1dXZlBpdnZEWHlpZVVUQzdUUldVU3kyOWhmYzZBclFBM2NaU3U0?=
 =?utf-8?B?SjFnM3RQODJqNnFZS3RCZ0ZLVU1TODQ1SDJpTzg3eXlQN0FGQW5YV0M4YWJC?=
 =?utf-8?B?c1J3Z2hSM2FDODE3aDA4WTRjVlhWeUJsV1h0T0dyNHBUQkdzaWNCWlo2Q21u?=
 =?utf-8?B?ZTFFM25TbStmMGVCOEd6YlRWbjBnWUc4dytJUGpGaVhIM3NVT2I2RCthVzI2?=
 =?utf-8?B?Qld5NS91YTZYdDAyd051VGd1clNwUXVTZS8weURsaVI2V2NrNm15bWtwc0xN?=
 =?utf-8?B?VC91NXRDcGE4T09tbnNxVVM1eEYxb2ZTTTZuNDRQdHo2V2Q5ZlVBbE5PSHIz?=
 =?utf-8?B?VTlPd3RoeW9CMXhOMlMxMm5MUXdGTjdXOHFNVnhrMnprWUJRSFpXS201VW5G?=
 =?utf-8?B?d2ZJVDJqa3I0WkFQVUpDVkxLK0oyRzlMZUdEVmNPcyt1TnRZTTdYRUlyempN?=
 =?utf-8?B?S1NQYnpaVHJGZTVIQ0oxNmw3K2EvQ2krenFLbi9PVUhIYTI4NnEvM2lIR0dL?=
 =?utf-8?B?LzlYVDVKTTBCdXhRdU1JbVgxRXMrRnAxeHdXTTlmbU8wWmtJQU92Y2JoZEJp?=
 =?utf-8?B?REI0YVdkNEVnSEpNZTJodk85QXhLMlVFWGYxM0F4dEwvL3RBZ2sxNk04Yjl2?=
 =?utf-8?B?QTJiV1ovcVBzOFo4WU9raUVtRWJhTHFJR2pDUzlmT3c0UEorSGkrc0ZzUFgy?=
 =?utf-8?B?b09iMmlEaTdTbkU0ejlRMk8vdWROemVKZmhFRDZZZldNdmxiVmxOY050UHdj?=
 =?utf-8?B?NC8xNjFUS1dqZmU0cVVZZDgwV3JlRU5qckhsV3YzNWduTnVzMWdETlFoc3hV?=
 =?utf-8?B?NTZxMXVaVGoxZkRKbW9TVGMrQWV2QWRTQUUwb1JyajJJck5YNTZoSjBjVEox?=
 =?utf-8?B?TjV4OW9odGFJY2ZaTWpiWlJuWG9IRk9iUUF3Q203cmVTN2tyOWs5MjVreUl6?=
 =?utf-8?B?MUNQMWtoNVA1Qnh5RS8vSGdnRi9XS1lCcndvekdIRkZ0c3NqZU1zMzlZanF3?=
 =?utf-8?B?a241c2d3Tm1zZVcyQVgwVUZpaG5NbmZvc2lSQlhvd3dDdGhtSFB3ZTQzdUpN?=
 =?utf-8?B?aHBUMGsrL0lWdENvaFQ3NkxDczVJRnpxcStNbzg0ZGNBemxkYzl1dkQvYU50?=
 =?utf-8?B?aDkxU21oNTN5Y3g2RW5uQVlTZmdsTllPV1pXVUJ2T2VsY2Z0TDlhaGJDdG5U?=
 =?utf-8?B?V1NPS3B6dUdGN3FiT1BNR3BZR0FIaG9WMDd3RERJdWkxYU8xQUs1NStFQm43?=
 =?utf-8?B?VHZhNlk4bHQ1UEt0c3c5Z2dhV2VvcUVaSE16S1dHUjZTaWM2NUVqU3ZyMWkx?=
 =?utf-8?B?R2NrWVpTc0phRmJlQjZuTFdoQ3hYdlNWdWNPeDZNeDZPRzJQOU9rVnduZ3JN?=
 =?utf-8?B?MVZuOWtsRGQ4bWtCc25VKzVaQ3lsQlBaOXVzalREa085ZGM5enlRTVZUcW53?=
 =?utf-8?B?UWdFTVdVeXp3SUdoTXlDUGpySFZCMytyL0YvVnRjckpuMlY1N3BkcFhoUk5i?=
 =?utf-8?B?cTBBeG1tM3FoRnl2WUt1dS94MjNjREswZktYSDhJNGIvbXE3cjZlaU9uUnZS?=
 =?utf-8?B?b3YyL3p3UlMwSk8xV2hkSWNHM3lOTGZxL3V4RE9KS09acEJHdUhaeU1WRmVX?=
 =?utf-8?B?WDRndEJDRCsvZ3pINWhLbm1zRWhBdzNMcGs1a1FkYWYwaHk3SHJRcU92S2hK?=
 =?utf-8?B?YkVLT21jRXpCZ1FsSTBDOHA2TWd5bVlHQmFvalNKM1d5S2NnQ2tjeVZydTkw?=
 =?utf-8?B?N0RNVlY0UCt1S3JGM1hEMXVvaytJSXNqS0ttZVJqcUdXdURDbVFySUhoSUVH?=
 =?utf-8?B?djVnUGlFS1lONysrTDVmRUhid2pick9wOUxUZDRBQVg3UlE5MElIY0E5OHNi?=
 =?utf-8?B?akJwcUlROHlib1lSTC8wUDVDU0c4UEpHQkRwRjRaQkVSMUNwS1NTbW1FSFBW?=
 =?utf-8?B?d1l0VHY3YzZ3blkrcXY5KzkwUmtCQzlrbUdWbFVkZS9TbTRYR2FLSWdMTmR6?=
 =?utf-8?B?b0JNaHJFVlk1MzY2elhQY2NmTmJSaEtUcTJKRDNZdGwwTVptall6TFRiclJF?=
 =?utf-8?B?VGZSMHd4OHRxMkc3U1lzbms5aEJBTHZwZitvWHNZWmo4aFJaSWVMRUtzVTN5?=
 =?utf-8?B?ZnlxQnR4K0N3aTA0cUlGT0w2cmM3RW45UTdYNUxieFhWNWoyS0MyT3k4WktG?=
 =?utf-8?B?amdHZE1TS0NrSzNJeDdVWUI4UDkxMjdpcHZrWER1OWdYZTBjNlo3VDg2Tmgv?=
 =?utf-8?B?L1N3NUpkQkJ6a3lPVW5hWlJ6R21JSGpVMFpNdHg3MEhBUGlVZWszRVdqVnhH?=
 =?utf-8?B?OXNSUkxtdG4zUDBRUFc2OXN6YW5MdEg5RlEzeWQ5T0N0OFpxTHlPQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288a9377-a902-47bc-00b1-08deb353f0e4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 14:03:44.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ydg5Vin33TWzaSxvb2Q+vDQfPy9hh6r0aQ5M+qPr8imH+MYokjESXgMFOE78XxQrJDPLbU9lWdZqnWtXvW8ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP123MB3595

--ngrdeafkf3efhu3r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] perf trace: Introduce --show-cpu option to display
 cpu id
MIME-Version: 1.0

On Fri, Apr 24, 2026 at 05:29:33PM -0400, Aaron Tomlin wrote:
> When tracing system-wide workloads or specific events, it is highly
> valuable to know exactly which CPU executed a specific event. Currently,
> perf trace output defaults to omitting CPU information.
>=20
> Introduce a new "--show-cpu" command-line option. When provided, this
> flag extracts the CPU from the perf sample and prints it in a "[000]"
> format immediately following the timestamp. This mirrors the behaviour of
> other tracing tools like ftrace and perf script. For example:
>=20
>   # perf trace -e sched:sched_switch --max-events 5 --show-cpu
>        0.000 [002] :0/0 sched:sched_switch(prev_comm: "swapper/2", prev_p=
rio: 120, next_comm: "rcu_preempt", next_pid: 16 (rcu_preempt), next_prio: =
120)
>        0.009 [002] rcu_preempt/16 sched:sched_switch(prev_comm: "rcu_pree=
mpt", prev_pid: 16 (rcu_preempt), prev_prio: 120, prev_state: 128, next_com=
m: "swapper/2", next_prio: 120)
>        0.033 [002] :0/0 sched:sched_switch(prev_comm: "swapper/2", prev_p=
rio: 120, next_comm: "kworker/u32:48", next_pid: 35840 (kworker/u32:48-), n=
ext_prio: 120)
>        0.041 [002] kworker/u32:48/35840 sched:sched_switch(prev_comm: "kw=
orker/u32:48", prev_pid: 35840 (kworker/u32:48-), prev_prio: 120, prev_stat=
e: 128, next_comm: "swapper/2", next_prio: 120)
>        0.045 [002] :0/0 sched:sched_switch(prev_comm: "swapper/2", prev_p=
rio: 120, next_comm: "kworker/u32:48", next_pid: 35840 (kworker/u32:48-), n=
ext_prio: 120)
>=20
> The feature is implemented strictly as an opt-in toggle to prevent
> cluttering the standard output and to preserve backwards compatibility
> for scripts parsing the default output format.

Hi Peter, Ingo, Arnaldo, Namhyung,

Just a gentle ping on this patch. It has been a few weeks since v4 was
submitted [1].

Are there any further comments or revisions needed, or is this in a good
state to be picked up?

[1]: https://lore.kernel.org/lkml/20260424212933.151154-1-atomlin@atomlin.c=
om/


Kind regards,
--=20
Aaron Tomlin

--ngrdeafkf3efhu3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoIeSQACgkQ4t6WWBnM
d9YfkA//cQnhZ4itnGfpT1202OpLO12XOvOlV35gMwUnymV7PmySapKzeKBMhWoW
fhpllnnUifhaA3uaORjkGKMUmx4ZpzBzfSMR8SMtyHsMEdgTp6oYI9Nytf2N/fK8
ubO64u6Ndk33B5EwBC/M2OXK8VRQ0WKf/N2gGye0XRgTjk0dbn6j/DxdsrWrBMWU
tHC54/rwciKn6jr+Ua47SB5xM2rAaBYxsV3Fv+OB3I6e5XxIplZACT//tF0+Dd6i
M2gccDn/Bxqg6pWe9p/xYyqObCa1WTaBjMH/Jlu0KuOvwllXCIlvO/pHJxYdwPe7
90Tl0YL1XMRnsZMbhDCT1Wmp0SkeDKL9v3xi01cHuUV+k1bIdoW6GKCyDASfD367
3fPQ3q6NZlJdiLxDt48u4f10DAS/GuhrSO+7zPEjPNN7CzPxyawc9ogZBpeTOTUZ
5fhJHdj4mh7i3rBmK1R1TBWrUtD/j79IZsKCJV6Wmx9RAUpAxd5QaYGKddSNEZvt
QMettjH2Tz2THY9cnXs4pyivvTSqCNTrkCpR78TsVXXQL4lcRsVarJsDIcjg/SKI
2UKQSgTx6OXz0lymR1OLmOknhJFkA/0nRVp8YjVinXJM91QXafYHS+Tt+nWFW75p
ygpiT0OKMwStBGzs4aMGJMBxLMTSxcJAzjKR6qKjRycF/xuTpY0=
=dC7r
-----END PGP SIGNATURE-----

--ngrdeafkf3efhu3r--
