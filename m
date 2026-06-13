Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022130.outbound.protection.outlook.com [52.101.96.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC26239E6C
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381102; cv=fail; b=PmiLGg/669WS8U0uhEnrlZo+97B38UQcewpDfna4V3Yh89Nl/eszlt/1zQ140ltDowGFxRgCRp6ovBo5LA03RxKgwUb0MZkOiLL0wDNda2BfN8wjyr2t9xHZDM5jBpKajAhId638yelwM2QHFEv+JDWv9xuvin9sXxNvkxs65Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381102; c=relaxed/simple;
	bh=tAxDCbrsvUyU2VK4foojMsxy13YpccWrlBFVJ83vRFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K1cVzIQ3lVU+MsIyHkmiTme8mQxQvQeHuRFozhqsdrHevXrla7nQHDmq7Bm0bw9h4Dnq79D9m6eYsS4lL8spWSf/V+sW7NCLAgYrI2Fj70Q4IanhGtotVbLNrLO27WN9uQXI1IEOVgvkQNBgE8xlnKSI8ao38MrQLV7iamJ1Ot0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLopAe4ARtgjlQbaRfDzHNKyiULMOFdG5RDeh3dr5vVOVD67fxXdVNL9e6cfioNvuRKrBomJT0d+NplF3a0MtuejUMTKgCDQbKEif7geMIyttSSMigPqvhmC1dyMd/LI17KVZqgn9mYBJzjk410sC5dW5Hncl4uzy5LGZYbSunLWXja6LDABzv92Wllh6CybEV1WOp+cCiLo0HnXRhJx/4PuabojLA6MT+YzknDI9E+LfLlacgg45KxJ/RI3wnhchLHTgU76TQG/giajknrkWKto5GHcDpb4aoN1v3+zYpamIgOYa+tcYQm59yj+d/UP6WoHMUAdY+e2V7ODGLbV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=iTCnnb4i+g3reXwsOv5JpCqNda4V0cIx5my6jjRlCGw=;
 b=scB5EwFlucn6ekv0K4VOZntIOWMWpIJ/a9/gAAHnSymXTRkEV4BC8SN4Upb9M+/uYIhz0ehu/RjLe+6kJk59W+Ps+IdqgG22obfJ8uJ/arosln36XbUQFiahxZ2KjgW9v50HUnXOFYPNpM29/EDnVVxza7Sy/SCsOfuuzvdZ1iH0q4ecDN3Dm09fgBZSwI8vgi+M6gvDD+grD24tGcWjIXxKtJcQsZfLzEphgaeIPiB6lkegGV1V22HkwKEmOu5a/GMz9ijUJ3Aw9dr6GT6BnVGj5zs5KaGFH7TBQurfcyWq42v/Cgdg0PViY2qqigMc3eUwNJZNY8WUtk2O8/PDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6084.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sat, 13 Jun
 2026 20:04:57 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0113.015; Sat, 13 Jun 2026
 20:04:57 +0000
Date: Sat, 13 Jun 2026 16:04:55 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: Fix noise and signed formatting of
 __probe_ip in bare dynamic probes
Message-ID: <kqz7pkmdhs36bfu7vo2p75ypynosejhubjgnq5g3zcrhbgqwbm@66jf3c74ef2t>
References: <20260612220843.1320348-1-atomlin@atomlin.com>
 <20260612221602.4886D1F000E9@smtp.kernel.org>
 <aiykBASNHYv-MR_M@x1>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7pmqqdda2g44buu2"
Content-Disposition: inline
In-Reply-To: <aiykBASNHYv-MR_M@x1>
X-ClientProxiedBy: LO4P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: b52639dc-686a-4978-44e6-08dec9870aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xIYwR9i8xwgYISOqa56lfvkIyxWdmcALAoyujNcdohWIiqKkRcTCEz1Bydzqr4GpFWYlI2dWiqyxaiRc4rPEf3+1gBOKCppihvm6c90TEYI+BqtCRKmgfy9397cbFC07nThULFx/RbCEHnkEAc6FX/Q6xyd+gczpYDwU5QYf3trvxOEGnyohUlj7E5L9+31/il+nTsElSE+XGps5rMN1eduYjfkHjGDMuawgW90sik11K/s9T4kBF+gTfMaSPEPU8sOFv+1ooiH74OfHj+hR1ZiQhvsy4MkhW5rNljvwwDbHL07fKCZ8W8eC+OCKbhN+E3OMtfmKqx3Ua5cxTeAhh+Wl4DOdVhoZ4a9yyrT7XWOplESgfnttHO0gR5XY3lB+0LKEjQelpGh1j+oPFqYlHJM8fFzF4l0DIDZaldQPpaiK5G5n1xXNt8Bwt1GQe8eeCkKOE8yxgqrh7gtctzWIAX83/Hb+GYMinb1a2AnwJZ38cmpODIUWoFnqzzlmkmwI7EuDxIZxE71zNSEM7BdR3NtT4lnf69cDm3MPNPoJOjCZf+PBTa7BENG9BKOF1wF5OyANlHAV0TFaGLz15qmqPK8qR63vszeP+mT1O90mKungTOIjk3o1vyya9HovBFeaPpqH0o8kCqlPIEcFWTEW1bHTJ8twd3VehyyXEUq0/snRHKBk9Ee0U0Quaf0XZCRV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXd0b0Y4RWFqWWs1N1UyQXJJU1JMc3NOV1ZJOHhSWXlhcWpFSW5oNHJDWnF4?=
 =?utf-8?B?Z3picURDT25ZbzF3bXlXSzVFWTkvdG45OWJUdDQzWVBDcCtUcEcvajkyMHFG?=
 =?utf-8?B?VnJBWWpZdC90V3Q3R3V3U0lMV05HNVM3dTk0S2tWWjJuR2pMZy9tVEVvUjJu?=
 =?utf-8?B?VjVtaG1pU1NpMFdXc0hKaDNkQ1E3bEJ0ZUlMbWswR3VwcVhmczhFK2ZhMzV2?=
 =?utf-8?B?VUZCUVljeTVnUVhla0RvenFyRnUxendsSloweDdHandUeVNEM0kwck5ub29J?=
 =?utf-8?B?eGdMUWpqOGo3Yk5MdVFDN0RhNlVsRU9sRFhnV2d4dkN5RlhGUko2OGYyR2p5?=
 =?utf-8?B?MEkyVG9zVHRCYzVFT2VFR05Gc0RHSVpRMVZ0VlMweEJ2NHR6V0RDY2FpMTRz?=
 =?utf-8?B?QXRkeHZDbDc0ZDJUQjRIRHFnQnVQQ040bTR5eS9jR002N2xHaEZJR2ZFYndm?=
 =?utf-8?B?akU2ZHNOQmRlNGQ1NHNIQTdWSDI1dDZudWZkTlV3WG9JL1BSbGxNOHBQaVQ1?=
 =?utf-8?B?NXEyTXo4S3FGT0tGbjA3TitHYUFXZU5lUVpOUXRBbStwL3ZPQTZwN25PZzBJ?=
 =?utf-8?B?bHhldlRMSlNvYzBWS3ZWWlA3WXhJSjJSL3hBc2JUQ3ZVUmNqQVVtOVJwS0Rs?=
 =?utf-8?B?T1VUVzVMajY5VFlJTzFaZUV4eWNMWmFBcFlYMHVHNWg1bDVzVjM1NGFyQ0pF?=
 =?utf-8?B?VlZSci9UTXNtWGlVamZDYWxDaS9waFB0eXRYR29PTWZUdktoTUtweENYVnZX?=
 =?utf-8?B?QzRJamNhS1BLZ3IrQk9MSzVOTWUrUVR6K09BekN1RjgrOTFIKzNtaEVoaHJO?=
 =?utf-8?B?QVd5MnNPNmhPSExSeEhxclA5SDloNVpHQ2FiRlF0eTgxVWgvOWFZMTRPZFVD?=
 =?utf-8?B?aFhscy81TFBZM2tSNElYV1BVbjhIQ1ZEL3h3QTFYZ2lVenhKWjRPNVBLaXF3?=
 =?utf-8?B?enJ2cjNsNlpQTXEvMlova21ydUlVbThCSmhNSTgzbVltRGtjc29wSU1jb0VU?=
 =?utf-8?B?NHFmRkVGU2ExcXM0MlJ0U2NBWnVQMTNDWThNd2xTcmpIZWVyVEM0VVBEQ3hW?=
 =?utf-8?B?eXo2RWVleWdzOUFZTGZ2dmlHWUVPZGpuL0txSjRUaVNONEFtUkpGUGN5RWtv?=
 =?utf-8?B?UG9EKzNlbE5KM0J1Q3l5Q1lrZDYyaXpER21XUEsxUTdsTTkyRFQ1L0k0TzlO?=
 =?utf-8?B?MFpXdTQrV0V1WUoxazFwdnpvZTdYMlVEZ1EvUVNHL2Y2dTB4UzduMmxCWnk1?=
 =?utf-8?B?cjl6ZU9xdGF4L0VFWTZlbVIzWENIL3NHVUdjOXhrY2RmNlo4ZG5pRUtZdEly?=
 =?utf-8?B?c1BNamJrdUNmV0wvdjhoaWNFWGtOcUY4eVpuc3hsKzVTcm5mSVhLK1c5eDBn?=
 =?utf-8?B?Wk5lODBnWVZCUHZSS3E0NUQxd3VZMit0QzRwQkhnQVhhZDZHalpDM05RWGJy?=
 =?utf-8?B?RnRmcXFIdGdGYmR6M1RrbHlJTW42eTBwMEN6UmMyN29hY2w2cy9VNFBoTXV3?=
 =?utf-8?B?OUJpUzRTaGtMeXNDQlh4NkRsamdUNTZ6Q2NqNUd1YWQwOG91Q1pncEVRa0Yv?=
 =?utf-8?B?TjYrSFFHWXFFbG84cHZyMWJoU2hJTXBmYVlNOUttcGpSQVhHOG5zWTJISjJX?=
 =?utf-8?B?ZTArMGJSSGdJZ0hqSUNGYW53bnBFUjlJT04wMWpYRHhTbFJ2WmFtQUI4djdQ?=
 =?utf-8?B?L0ducGZGNExGQXgwY3JCcUdMWFdiZnBlTHYvVDJQSWRENHFxVlBWQzRKMjdD?=
 =?utf-8?B?YTZLL2FWK3F0R1dpNFVYeW5MSEFXL2dYbmxCQ0FxK1JkTWk1YnZ2dlUyWkUv?=
 =?utf-8?B?ZmlnNDlWRk1nOEQyZW5xVVBzSVlRMUoxWnhENEprUFZVWXJXSldQdkpWUWNi?=
 =?utf-8?B?Z1hmejN6OVpEZXhqME9iaW43Syt4YTg1N050T0pqWTBraDd1Y1hxaUdFKzh2?=
 =?utf-8?B?QmJ4bWFIeWtGNDJncUdKMWI5WUFaak9PZ0gyeVFRMGdLMWF6dG1NeHl2MFZi?=
 =?utf-8?B?aThtZmFobDlHYWlablc0aDdTM0MvUFpMbFQ3SVNyUUhZNkZhNHZOUEh1L1Vi?=
 =?utf-8?B?enVLem1TUHB3bHpXNXM3MnZwVEE0TXhsZW5uRVdpRXR6N1plR2pNamxyTDdt?=
 =?utf-8?B?d0lBTGJ3dnhCVFJlc1EyTklWQVAxZzBQR0JTeDRZSXNvaFR4bHgyWllDTU5F?=
 =?utf-8?B?SVg2Q1phdVFlYjI2V0hBcmt5cTAyeFBPblRuNm4wRlBDSFpLUHIyOC9jN1Rk?=
 =?utf-8?B?TEtzYktyNEZrYWpwQUZRUlhnTHRoR29uNVNhUnNKVEh6ejhDQVljeUJVblB3?=
 =?utf-8?Q?s85jyZSILAxwGiq85W?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52639dc-686a-4978-44e6-08dec9870aa5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 20:04:57.2414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OATNxfkvoB3MzyF4CC2QK/1/ZjvrLHPyUtNwdf6KlfGNICGhBKpr2CZTGMXHJXvnh/Qo1hhwJEEKvUyXN+zxeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6084

--7pmqqdda2g44buu2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] perf trace: Fix noise and signed formatting of
 __probe_ip in bare dynamic probes
MIME-Version: 1.0

On Fri, Jun 12, 2026 at 09:27:48PM -0300, Arnaldo Carvalho de Melo wrote:
> > [Severity: Medium]
> > Does this hardcoded format string bypass the trace->show_arg_names
> > configuration?
> >=20
> > In trace__fprintf_tp_fields(), other arguments dynamically check if the=
ir
> > names should be printed:
> >=20
> >         if (trace->show_arg_names)
> >                 printed +=3D scnprintf(bf + printed, size - printed, "%=
s: ", field->name);
> >=20
> > By explicitly formatting "%s%s: %#016llx" using field->name, it looks l=
ike
> > __probe_ip will always print its argument name here, even if perf trace
> > is executed with --no-arg-names alongside --verbose.
>=20
> I think this is a valid concern, please make it follow the
> trace->show_arg_names for consistency.
>=20
> This is a nice improvement, thanks for working on it,

Hi Arnaldo,

Thanks for the prompt review and feedback.

I've addressed the 'show_arg_names' consistency in the next iteration.
You can find the updated version here [1].

[1] https://lore.kernel.org/lkml/20260612225610.1326644-1-atomlin@atomlin.c=
om/


Kind regards,

--=20
Aaron Tomlin

--7pmqqdda2g44buu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmott+AACgkQ4t6WWBnM
d9ZN9A//Ru8rgjl/+v1hMA4sepJN/evRDcLI6HVPprNFu3oBmzZBOyOnAiZ2uaj1
/pZfVRseJvcyOhe8AUNwieZpK4vkH05/CCjRX2dkCxGiaFiv+9Tq12zRLz8DD0c4
xzYWUKAbE9sSYP4bdrEwDWpvjEodToZyzNcP0WFA6NLSnHAPziS0QVvCfhqfELAL
eNk+/a2h/XGTyZeDgwDmVT2diWza1RcWMKX0DmEqc7IaklYH/P2OKwe62Ms5nWKX
ZRkb3S9QYGCgXMkxZLNNC29aQbEjPQ96kYXdrTzFkaUEc9uUbkMt+8LbUbUmql2g
bSni/jslAYd9E2BX0B7N+y9Hm8Uo6yf2zNNln15JD/nU2/zoAD4ear6iZZoesTRL
onY3N+1EVoCl9TwFYkoUPxbhRQe1sSuf+Wwgqcy65lTtAZWOi73DEJBqnq5N5Wz+
mkNgr06zJtyrq4gSBG6xV1K07u9QthM8x5nt1No80y6PI5c8dLn4t6jd68v7sTf0
USPLeMGoc+4VzhOB9Yf3H27NgTcq4LhRwNdIX8IP/fGqCuuuUqStHmlENk//gO9l
l4tOGE7+ZJR9bPUD6aIBvb8XNu69YRVQvGLUwokHI0ATZrvjaYMKjTJ5/lAOZqBn
eUcRdmsC+JgpvlsAs5D4j9bZ6lvUHf7lJsNixdUvD0Ci4368/74=
=Bypp
-----END PGP SIGNATURE-----

--7pmqqdda2g44buu2--
