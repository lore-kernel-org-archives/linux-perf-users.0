Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020075.outbound.protection.outlook.com [52.101.196.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2BA219301;
	Mon, 15 Jun 2026 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527402; cv=fail; b=LoroRVs9EI6avA88t7ku7DT2dVy0pPryEsU5YISedsboKvbdZgb5nK9zLEx9Vq/TlSbUe+OSsqppPy2Yk1C59pcAwCvxcRIWsJJSklw/RrIPi9WkbF+nsJNNZQMU3vPuYIs3qIlrHhc10KVXNAga0IHd2yNQHvDIODYFrRFFibU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527402; c=relaxed/simple;
	bh=2CRWS6AA4aJyCxB9amD+paOdXufHiGo0FQ9uShc0WTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CQTB72Pn4lDVaxJmX5dM3jXyep7tw50KoEOUHGWFzuz8pK6Q7z2mkn4geWmE2+iY71msFDf1SqdIJbCMVAt1/A7UrU0pCCzMpMNne5vBqzyeO2Htl63pw5+EW3MNcnxBuFr0qgZ6kQoSK7dwkfYqsPV9+obA0pmamY7cEToF+TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJ7fbE3ZT9BfK7BfdyNQJdGsQi9e4npd/r+0rj8ebKqB/MWXCiTpE1es+sm5afN3lgFOHOHumAUsCvHei3rLp3GxJBUxPH0O2R+k/0PFKA9x9eaTdELEU+UGJjqLqaPbNgYO72iF1PqJsN3KxCzrE2jmSGQl7rh3Z0vP+BWavcdMjX2qMCmolKjO6VWeiYKLF1GYx3SYmnOGtGznWCugOokQPz9hWs8uhdD+pNJwkw69SOckjKcqCHtU65z1MUZJ3lKaiFFCjE3Br58fZMasTZLGoD6pDkHqWkZDyN0GgA5W456WDDI4QFqbpsGnHzZCUf5EuYLlgDvpOhGibaap3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=yQGBlkjntRhB5160lzm5O2xoTrd1+9yXt8yI90nX/gQ=;
 b=vYzEZHg0zWMCU9oFliCf74pPCv1qOKHcv3f3tLNjiGVsp7vz+9U4n6LMkSI7aSWUVYClwbybCas6LP3ONWnQPCDBb6OwymeoW8TZG7LfiS/GjFus8gzYV4UEeXGSZL8bAucunY83oCgJFrtBYzMVn9JFONQupCnlP1NcgrDPmh+WCmEySGdIhKJ+VsJJrZ9v/i7CMgTiM9YW07BAVZqK0F1AAi3Ed68+Ot64pCNFE6P0UItcVUIF3mhDuJ+sGOtvTvVhcgQxo2TXZgZTkRtF03cCZLs2KN3g46LiSD2DLXZAFtqwOx9Jz9eSw3aBMBJRyFlyyTFt6NNnBZw3Guw/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8550.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:27b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Mon, 15 Jun
 2026 12:43:17 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 12:43:16 +0000
Date: Mon, 15 Jun 2026 08:43:15 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: James Clark <james.clark@linaro.org>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	howardchu95@gmail.com, neelx@suse.com, sean@ashe.io, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Subject: Re: [PATCH v2] perf trace: Fix noise and signed formatting of
 __probe_ip in bare dynamic probes
Message-ID: <eelbfodoczptemllh2cymr3lvxe2tpt467i65a76c7ox7zbn2e@qan7xlaq3wkt>
References: <20260612225610.1326644-1-atomlin@atomlin.com>
 <78d7e5c8-9f00-47a1-972b-33b42c5dfd99@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w6lpz5xdchyxodyl"
Content-Disposition: inline
In-Reply-To: <78d7e5c8-9f00-47a1-972b-33b42c5dfd99@linaro.org>
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4c77ee-e129-408d-fc0d-08decadbabf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|3023799007|6133799003|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wQJKLL3J2hvRMfpwSVmoKxODIj6i+W3P8UsDtL9V2SXcVamsO7L/wzY6SEgbPxDfGKjNl1+FUbwT4p4fOzUQpriU9Q8CTn1ND9Br4uv08S9BaCQk87ZwPGAoSOTtEO2MhfHZq8w/77CxYSdqnkOoVWshoL1v/nDbwu/O/L/LePklbPCgFDXml3lfZqcFLpbeWhCahcQaXy/SVUtuQbQU0tnVgkXioMU0X8EGpaytdPHR9dUVMQ4fcZZCEcwokNL5vMhTad4y40IuIJjI4NC/nusBIBAeO5mvxLFNnIqRxc1g+7SArkrhiYAcCtw5x3JgvstiJt2lf9a71hiaNQRhv2vBnEOIYNWtc5ROHEhvBBqtNcvIe6Bb3ddDaI6ZYz4wzYd0BYldRSa5BhF3hT32n7z5hDHn1lj/CBksJ/zlghKx1DCQCOhAWC/e8edocoRyqsa0n5ude6t5r0OBBmsRUcidoSC85CLl/RVH0VAXNG8RTOUWPxrmWgb868ihNCWpozTYixbIwgSRuzYbIwMITJi0AHJaAPoR7vuyFCSbJQIfTwfNi7g5po+DLwPULGoXIvu0tqdKPVcKhF2U69BitFCqaYmVgounqtERz1gAleOLVmek0u1v05ShZwmfR6z0ztalQMguSz61m50mHuabt+gBg6F5jhn61ecBdKqtk4TrFLqQZHShs04ipbQKK1E21e3jx6CsvuUd0xkExXh7rA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(3023799007)(6133799003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1FjUmdqa3dZZ3EwbzF2bzVRTWJOakNCb2ltbmtrL01DdUFUMm4rVVpEK1ZZ?=
 =?utf-8?B?TldzeDU3SHZCSTlEYWZyZUpqNitDNGVmRHVMUlp0eFo3bmpPazVsYkNEMlpW?=
 =?utf-8?B?eDdhNDZ6SkZ4TkhqU1BHK1RZb2hoZ0Q0TXI5T2ZyWEdqNCtMTDVhM2YvL0ZF?=
 =?utf-8?B?UzVKQitPaE03OGwzbEF2UnBuTXNJZ2dvWXI3R1crUnFaN1JKNlhaY3BaZDVw?=
 =?utf-8?B?cDZzMHpCeXU3VXpwbWRMMFhWdDB3OUFQVzVvcmNGc1VTSE05TWxzNGpKeWp2?=
 =?utf-8?B?QjZiZ21qY0VEeFdRZjFQVlVLdGNmTVRXVXB5bVdsOGtMZFZJOERBZXlFUXB5?=
 =?utf-8?B?RThnYU9wZkEzZ2tWYnZDSXFYWXpIL0tWNVJqOXJlWm9wSHVFbnRXbFFrZldu?=
 =?utf-8?B?UVVIVE9MajEwbTlWT1c5YzVoQlpQUy9KaWNBd1k1YURDa2hKVWdYWUIzUGZJ?=
 =?utf-8?B?NkVDV0ZESExzT0EyWTNoc2YxOXYrdnJKOHdFajZkR0d6SFFvNE9qWnBwcjVu?=
 =?utf-8?B?RWJ0QjJZcXIzeWRQTE9jM0UzQkJQVXpvTVNtM0M5YzUvZkQyQU9ZNjZlWTEv?=
 =?utf-8?B?SEExcXpJYWJCclhjR2xkWXFUSndQSEMyOTlaQVU0aTdiU05oSmc2SS8xY2Zv?=
 =?utf-8?B?NCtnNzJHeWRWekVPaTFlc2NMZEhzWW5HSHk3UStCSVN4THJqSUtQdnd2am9t?=
 =?utf-8?B?SS83cWU3SjQxbkFDMGREMnNDVE5GUmp1OGtpR2xnNjlIMzFzT3JNckE3MGlC?=
 =?utf-8?B?cWhTV1RRUEdsQ2NhMUNHaVpXcnVUMXY4YzlSWDNZbHdGV1IyclArWEJQeHpx?=
 =?utf-8?B?NWZjY242elRoME5MakdXSC9EKzdoTndlSytlVXFqWlZyWnExb2p6dUF5bDE3?=
 =?utf-8?B?QVFOR0Q0WS9WZ0ZkMnRhakxMNU5CeitwRXdjaDBmbTlSNGd5TEh6aXdoNDZj?=
 =?utf-8?B?bXNBVG1hRWpIK2Zzc3FObzhmdk9DQkxTZ0ZoVDJqZDhSMXQ2SW54b1FWcTNF?=
 =?utf-8?B?OUdJdGZPRjRzZ2ZITWk3U21PSHpoY0FEUkRuNmMvRTJpNHZ1YlkwT0lycXVu?=
 =?utf-8?B?c3VyekQwQnIyeWtZcjdUNzNEUlRzWHY4dmV3N3I5OWdwUUdpNG9UWW8wTERk?=
 =?utf-8?B?VG5TTURBVmwyRHZXODhjTWplVS9ycVN0VUY2SXFWUjFEbGtQU29VRE4wcmRJ?=
 =?utf-8?B?dXl3KzlXSkpqY0h6SnVmVXFDOVI5dFcrdUdqOWd6TytPVkM0VUZVRjQyWlRm?=
 =?utf-8?B?U1NFUi9NK09tUDc5QW5TU2lUSFhJUnl3QUwyT05yVEFFaFlZa25xOVZsL2Mw?=
 =?utf-8?B?bXozUDVJSlZSQVpreXphSWk5MUIwbzBiRVd2Z0ZSanFTVzM4Qy9QSVBEZzBa?=
 =?utf-8?B?cngzd3pGSjRDMnJQRVNwSjJEZHJsdHYrdE51Q2wxdGhhd3dtV2M3aEtreGhr?=
 =?utf-8?B?WVMvTDYrSTQrTGF1QzRzdXZzRGh1QUZNd2x4R1hFR0ZDWnZYK3JHRDB4cFgz?=
 =?utf-8?B?MUFxSkFqTlJscUpIMzlXeU9lRnZ1VTVtVEVqbkg3RmRNUnVMVUh3d3l1ZGx0?=
 =?utf-8?B?bVdqRUsrbzByNjBEQ1pCWGZjSnlLRUVkNnNPVk5pUktqN1g2RzF3SENUVDdj?=
 =?utf-8?B?WVh2TlZ6OVJXYUt4ODZZaWM0bk9UbTgwTFBpRWlWOVNCaCs4bTZTdlJQd3Q0?=
 =?utf-8?B?aGpzclBQSU9JOVY3YVFITGxnYUQ3VFV5VjErNnVVa0piVXcreDkzTlVFK0Z5?=
 =?utf-8?B?VzlyTzNScFhLenNyTVBXazhHeTBOZWI5Q0pRaWF6WXJCbXlWNG1EdnZaNHhk?=
 =?utf-8?B?a2pwRWNGZFF5dERFNGp0SENHUGYrMDR3RHRPUnZUOFVGUnNQbHpEcGk5S2lO?=
 =?utf-8?B?MndhTHlDdk5nWHZ2dk92RXQ5UlZYdUl3QUNZZ3U2aHlySDIxTXpndllMa0I1?=
 =?utf-8?B?RXFJcDJ2YkpuNlcxR2FPN1hWVjZJVmsyL0R3ZHRUVm4rdURxNW95ZHRoam1k?=
 =?utf-8?B?emFBOEw2dUJQQU5xZGhkbVFpanlQeU55MHRieXluQnp0dzBwdysxV3M4akhZ?=
 =?utf-8?B?ckExVU5Udnc3QVVFZkZWcGVwK096dDlZQVo4a1F0eUxhRERzSDk1V1BHSTVL?=
 =?utf-8?B?SW1iMjZvaFU2UFI4ck5TNG9Dc2N0d0dSS0ZybEE4WmozTmo0NVg3WTZzKzVF?=
 =?utf-8?B?SWgyN29jMVN2L0V1YnhaR2g3SjNRQUtMZzVPeklJVkc2SjE0ZnR6Sk5wbHoy?=
 =?utf-8?B?SCtRS1NQMzNoUGxZNzNONTBsdytYVVpqalgxbHlTSy9jWTY4bldhN2JrNXFv?=
 =?utf-8?Q?pgNSaaqfl9zMqtATxJ?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4c77ee-e129-408d-fc0d-08decadbabf4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:43:16.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/f+lzncoTylKcaZ9EzFVsNKty/XQcTJyqrbVoSWb4PKLSSeqll/zNB8pAj4u6/YuH6EL2XTD6yHY991TSrUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8550

--w6lpz5xdchyxodyl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] perf trace: Fix noise and signed formatting of
 __probe_ip in bare dynamic probes
MIME-Version: 1.0

On Mon, Jun 15, 2026 at 10:32:59AM +0100, James Clark wrote:
> > Currently, perf trace prints this implicit field by default.
> > Furthermore, because the formatting logic defaults to a standard signed
> > integer representation, the kernel space memory address is erroneously
> > displayed as a meaningless negative integer.
> >=20
> >      =E2=9D=AF sudo ./perf trace --event probe:proc_sys_open --max-even=
ts 1
> >           0.000 ps/1316543 probe:proc_sys_open(__probe_ip: -1406056956)
> >=20
> > This patch addresses the user experience by combining two refinements:
> >      1. "__probe_ip" is now hidden from the standard output, as its
> >         presence adds no contextual value for a bare probe.
> >=20
> >      2. If the user explicitly requests verbose output (--verbose),
> >         "__probe_ip" is intercepted and properly formatted as a hexadec=
imal
> >         kernel address, restoring its utility for debugging inline
> >         function hits.
> >=20
> >      =E2=9D=AF sudo ./perf trace --event probe:proc_sys_open --max-even=
ts 1
> >           0.000 ps/1314074 probe:proc_sys_open()
> >=20
> >      =E2=9D=AF sudo ./perf trace --verbose --event probe:proc_sys_open =
--max-events 1
> >      Using CPUID GenuineIntel-6-8E-C
> >      mmap size 528384B
> >           0.000 ps/1314366 probe:proc_sys_open(__probe_ip: 0xffffffffac=
314604)
> >=20
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > ---
> > Changes since v1:
> >=20
> >   - Fixed a bug where the hardcoded format string for "__probe_ip"
> >     bypassed the trace->show_arg_names configuration. The formatting
> >     logic is now properly decoupled to respect trace.show_arg_names when
> >     verbose mode is enabled.
> >=20
> >   - Linked to v1: https://lore.kernel.org/lkml/20260612220843.1320348-1=
-atomlin@atomlin.com/
> > ---
> >   tools/perf/builtin-trace.c | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> >=20
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 48615ddccd93..ac15b5588a27 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -3234,6 +3234,27 @@ static size_t trace__fprintf_tp_fields(struct tr=
ace *trace, struct evsel *evsel,
> >   		if (val =3D=3D 0 && !trace->show_zeros && !arg->show_zero && arg->s=
trtoul !=3D STUL_BTF_TYPE)
> >   			continue;
> > +		/*
> > +		 * __probe_ip is implicitly added to bare dynamic probes.
> > +		 * Suppress it by default to avoid cluttering the output.
> > +		 * If verbose mode is enabled, ensure it is formatted as a
> > +		 * hexadecimal memory address rather than a signed integer.
> > +		 */
> > +		if (!strcmp(field->name, "__probe_ip")) {
>=20
> I checked to see if it was possible to include the #define for this const=
ant
> (FIELD_STRING_IP) in the tools folder, but there wasn't anything existing=
 in
> include/ that fits nicely. Either way:
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>

Hi James,

Yes, unfortunately.

Thank you for the review.

Kind regards,
--=20
Aaron Tomlin

--w6lpz5xdchyxodyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmov82IACgkQ4t6WWBnM
d9YtrxAAmU1m/d9R8772DYjo2J3wl+R9kGkwTzPEpei2WNITa8hVuH81PZVf2Aja
rMDTXcjGF9tLEwsksuwNMAZ+fJXhg3HNPRo3QeIH2hUUIDloWq3dVRFGDdUZ1Sf0
NgfCWVTgQlPKhLoyTt57y2/tbTqux9Xy4TETV0TCHLYbzT4YhJtXAJS8w9MZhrow
gx0ma8ZTGT35cB7Epokktt1aV+nDZWbZeunfNYZhcrc4SIL31BbVX+EFrsHsYsZu
QSGKOnYJAy6W3ssxEXfQV5ngFbkMj3g/h4CRKKOtzFsRYKPoYkOKqXwMcUjG/GIQ
qAFI0BgUaNrgNbvPKQqZDIyr7WYnaw9Vo/42QcC9YQmMAzJwEfciKcnen3l2TtOw
ljwIui9Dc6lz6OfE7fsZaOviykoP2ByBZJGgXJ3zj67XdfVlu47+Ewios2TQsSba
eh9p0MDLS+pTdqYqM5nRq2KNe2mCzeg0EwxTLtnvFrRQ94gNdsYyk+erdhgdEVZY
F/PmpTBUJVS7R3qwTDKyqRQqRGar9ZDwnakSZCYm4D16lQrD0gVraM9dxKL4C0H8
8rCpK/J8o1C8d5fWMq2kupOroLqsnxX80sjbwqxarEsD6fiyIffZH2QLU/JwJ2+w
5Fi/ehZ8jMQ8MjJcuIzQEBl2CgbWE8v45VareGQF8brTrZ8NbnQ=
=oUTW
-----END PGP SIGNATURE-----

--w6lpz5xdchyxodyl--
