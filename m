Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2026.outbound.protection.outlook.com [40.92.91.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418712CDA5
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Aug 2024 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723893732; cv=fail; b=EJuSHBpuyepXx+W7tbSlb3JpY/Ho/7zDKoNR1KclAuTHfFc+2mOpdgMb7K0M0BKswkgutrRWQDEDkhO0EjHEpDLRCV3m7pk/otRQy8U87TpFOcpPcW4s6CYGbCeAwAya9lIN6zwXTSq5k2/KoYAjRjJSK97a8ynZ3gvorH4HHxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723893732; c=relaxed/simple;
	bh=CeFS99e5R5z6SVERRQE6JbN/cLUZwEpJYB9q/A7cSVM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oGRW+4Qd6Fsw8+sJDu70mtpYqDptKW7u7VapP/44g/54DWJWHM70V0GmP5eGLhDSHb/AhRdz2xWbfgKXjlKbqnUDID+MlerxO2FvMEHC9gGiRyvW2KWf/BOFlG7V1aKO0C87BrQc6TvthIBFuBFnI5uL4vS7ANSfzWf9jxdPjw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=lBWq/0wx; arc=fail smtp.client-ip=40.92.91.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="lBWq/0wx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX4f1fUS8bAeqRfdKLb56h4ZJNfhOBR8KLdWZnxoeRxkuBXsn49fI2SYeeQEbwOFJi7U70yiUyV6KAukpuFSxQhk6oQsIvlnim6+o/vuoUK7Yy5rrs3PIC4ho9NER2XmedoGqfhes7iIRN1emQ9BwRuEmKPEqzru/BJ+MKPl3rrT/kJ8WPrpl695HtZSPuaZOwHBb6Os92dHkFi7txlEcBYJ5IOdmGz4P88o9TMnrJMOTjyi7osQDT1HQ04jqh83dpQfl/15bIvG6entl3laimYmRQCuw993H1h2MH9febn7rbKG9ZWXh2OZUbdlvjAplzpvagCVDGYdGVT63uJBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du4OsOMsHvPrQgvyGeqRdfME4m2N1GIY451JfjkzYV4=;
 b=Ku4AR2dBUBU09uDq884ozdrRQzR2bYXgeQg9KSI25Q2dFpbNdHBhmCL5SunPAxfgc0uV1agJo5WeEVZs0Bnoel/SzNHU7mUGy713kRsMJ9JS9VUj2aoRU58oOpU5R7wQld7ZUZwVzIIdvvtf5b0P2uFz3ugolNabYjdOTF9LHhsso7el7VhwVdCjqsHbWU15/xPG01ukZvnaRQbfcAjd62+hiaA9exGGjO6DgvNj8KdEPKMLccr3+2ZmzJgNwgYifTe/2BQc/0YpKNMrkOevLAaFDxPc6c81N6MiBdK4sIOrBOXFeG/0z3DYM69nVEC2pkPwCknRoVUA2wisPp0WkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du4OsOMsHvPrQgvyGeqRdfME4m2N1GIY451JfjkzYV4=;
 b=lBWq/0wx5NG7q9nAkSjvh4bJ5jloYQesyTg/jX9aFAuMiCxY7onpzUUixpxRccwHc4aTcIcMqz/1D7s498oFx8xme38Ff0fu70QJ4EPl5JvhMOUk83aWwxytrUrvXYRWGAOMV2qP89N7vsxSdUlUOXGDZP4InBJ+NQSeTq9/zSR+Z3gdRs2QuBUfWZytuc5QP0Zse8uxY7r7fqUe/f5LGwph14FLjiHmroT4QUrTCt0t7n/HaceS7hcMKFIOyn1t3XVDG2joXAo335UMubcb2DnQZF7HKqmYdALZRqFuOEPMAy7JMehfII5p5A+NcaJbPNTwZe6W9uCQu6hbygdg8g==
Received: from DB9P195MB1682.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:392::9) by
 GVXP195MB2647.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1fd::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Sat, 17 Aug 2024 11:22:08 +0000
Received: from DB9P195MB1682.EURP195.PROD.OUTLOOK.COM
 ([fe80::a0a:2cc0:d82a:d8fe]) by DB9P195MB1682.EURP195.PROD.OUTLOOK.COM
 ([fe80::a0a:2cc0:d82a:d8fe%2]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 11:22:08 +0000
From: Odysseas Georgoudis <odygrd@hotmail.com>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Question about perf c2c support on Alder Lake
Thread-Topic: Question about perf c2c support on Alder Lake
Thread-Index: AQHa8Jb9KmK32xrWE0+MmnsaBTztqA==
Date: Sat, 17 Aug 2024 11:22:07 +0000
Message-ID:
 <DB9P195MB16821F21F5D8EEBE68D24B0ACC822@DB9P195MB1682.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [3EcUVv1HoSYmyp423btLgS8w0G3+TYXqzA8A5I6Gi40uNd16GIq32o6BaO/R6Ht8XoJ8I8UI+WE=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1682:EE_|GVXP195MB2647:EE_
x-ms-office365-filtering-correlation-id: 718dc0b0-1fdc-4db4-063d-08dcbeaed493
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15030799003|19110799003|15080799003|8060799006|440099028|3412199025|4302099013|102099032|1602099012;
x-microsoft-antispam-message-info:
 HxIbusTsq/GGqpZyUi4qiDeb2v5vqv/uj/XoW4V6tvwEy3NW2W11RmszslnvH00T3YMTllv7JrZVrZOvimQXTxLnVb2JrywxSeTKZg+OS+EJ2hir4KprArZk26rrMCC3TjLqViI1NeAXuOAm9VuAY6Gp+iySKfPVhYCw+ZJw3k/T1QTPU6DYMOmOwNqEX+inmnqvYtbKFySYt7CZBtUrDFIk5Mr4QjwAph69i/KcdcWMswaL8B8uh1/XvbLTofYvRnc1O/87ech2IiRBn2Uch9xV3LabKTURHXnKbRJEWXui8Nt/klia4UNXagv1R2NrnQiFGEdPjciGutYTw9XqeVx54Y+uYVCHSt5Y1+nksZAfbhywcMKzR/vUUO5FzwfVk9bikPEeusMGdvI1CIAvUan+pUbvrXAgfTr/JFgN4J8CviL9NpMoY0Y6zyF9zqnZQUta7ferNgaSsw4hRO2oGAnzI9lISbznxWOs0/ij3f36wWTt0U3ZqrI6G592Jin82B0XRXiOEj1gKNGtpii1yXmrO70vweWpwMxseJyhm7P5AcKuEcqWv8L161ujlCUIVEb/SIMTwRIzKzf7wA/j6WQRR4aE4KYd/iuPnBd9el4Wlf54y+6kgk0gmIYupKXXpa/03s7gOoReOltV/vt5T/aC3j9cc7utMX76mS1lF6Sk0GHVzl+mUGHF5Rf+vMX0NrQLAdIjv3/DEWov0QFOEOtCSyeaRT2M8Kp/2yyJBKqnIJkahc8U/P6U+Zo7/uwPpCOot7/3YiO5XhUn4OB6AUQbpZ138XWq4aNuPLAu2Tppx6046QBJe4MYU34YgIxY
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?3aOLJze2ynfrhK9qkvZZc1Je2iARqjB6oLi2x2UGMuGWv099uTj2JR2w?=
 =?Windows-1252?Q?bT4k4tyglF+uAN3IYZ+qKeSV4fcXNFxZ9R+Gb1EbXUWr3geD77Rfrrc2?=
 =?Windows-1252?Q?dXLvf5XpHYvkdUI3/b6kG16KKi3DliecW9BaXU6/s85sb1e6ai8XmYat?=
 =?Windows-1252?Q?1oJFNqfxvReJCauh2Bg9KDnQxsYf1sJuaFRGGt1kF5otj+uE6L9EHC3L?=
 =?Windows-1252?Q?f8M+7+MH8QG99CLv4d2ajRYy9bx9bsqNmiHWMeIpZM8Me15sdSE4yQeE?=
 =?Windows-1252?Q?Vqe6QJ7gPxzCOQRMLjwXdOJKdFB8bz/ealMnhCur3gUn8oeP/Xzu+3Ky?=
 =?Windows-1252?Q?htqZ1gE8aNtAiPfGOsSYYtkO+dbAla4rLM0XApMA+USEG2qoHgEPwBKn?=
 =?Windows-1252?Q?CJoxbgGsSBlB3eXSvEMwi1t/3a4DRoIAhTFGPjdPTL3OkbDr+gA3+WUS?=
 =?Windows-1252?Q?QY2iQ3WipvuWab/6txMCgHnxEXw5zBAz28USdY9lbabLGKvLUVodQI6d?=
 =?Windows-1252?Q?3JVANVSCenp/sqNK80QoLXgGM3/g00K3x9JMIuU8brSu8Wen2cF1PyBn?=
 =?Windows-1252?Q?zDuY+zrlse9WE3Cgy25Z+hhj+xljoLLxlB2D6tL+enWRBrDCcMFfNjNj?=
 =?Windows-1252?Q?FtMCUBezOWdk+UE0vKufYKGEl3co9bR12Edf1BiBLFvK4fvhVn8bpPr+?=
 =?Windows-1252?Q?jJCT+UwrbrzMCTm9AmYNgzyUaMOm/GN7qSKT5XIH0eU1+DFgeDjX0XHW?=
 =?Windows-1252?Q?OAxpM1gZHmGh/6MbMobI6UDzzr4e8H9mR6CnrzEHrDucwknjx32ED0WG?=
 =?Windows-1252?Q?L+63SrkWG4Ado1EKLX6iFAlHuCm4Kssq2GGwR5cvG3qFelURR2uqGfWA?=
 =?Windows-1252?Q?UIwKsUMX3LYCNvj9WdXcdAZQZCuNsI2MaYkbH251wRdOjug7+PeL5JEP?=
 =?Windows-1252?Q?fO0XLLkyylC/cNLLKd/v8UlCXuT5ZO99jB57haN3kjyITZKNlqr7AYuI?=
 =?Windows-1252?Q?JP/cKZAVNSi7Ro9EXNF8K9B8yHJA8XyC6R2ynNzSUIraSLt6Zgh3Q7fW?=
 =?Windows-1252?Q?XAO2T2nGWpndwL0fZQHdIgQ6O//me6J5Z5kWppbltQEziylK9sYh30qv?=
 =?Windows-1252?Q?kdmmViQrEce4MPzFxD1DoGHIH/XB21NUxQGPtO/yB68InLCi2MfsY6nB?=
 =?Windows-1252?Q?yYA9bJL8RdRk8g89y9wCh1c4OrbW1lqS38LYYbY+2vTWrChe5KW/H+Fa?=
 =?Windows-1252?Q?YMMKUhCTdgd1wV97rHjfWdIpRiMtc69NKYTvNxGkzF0IHDe8TvOPr6wo?=
 =?Windows-1252?Q?xWfWSNO2HXVoHVIv2qxmsZJDzAyjATqPv+l164wvPM0d8jczOHpYwSl6?=
 =?Windows-1252?Q?SpE9R2FzdJ+DvA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1682.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 718dc0b0-1fdc-4db4-063d-08dcbeaed493
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2024 11:22:07.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2647

Hello perf-users,=0A=
=0A=
I=92m currently attempting to run 'perf c2c record' on an Alder Lake, but I=
=92ve encountered some issues. =0A=
While 'perf record' functions correctly, 'c2c' seems to be problematic.=0A=
=0A=
When I try to run 'perf c2c record', I receive the following error:=0A=
=0A=
event syntax error: '..em-loads,ldlat=3D30/P'=0A=
                                  \___ unknown term 'ldlat' for pmu 'cpu_at=
om'=0A=
=0A=
Kernel Version: 6.8.0=0A=
Perf Version: 6.8.12=0A=
CPU: 12th Gen Intel(R) Core(TM) i5-12600=0A=
=0A=
I=92ve found this patch that mentions adding support for hybrid architectur=
es: https://lwn.net/Articles/852302/ =0A=
However, I=92m unsure if it extends to the perf c2c tool.=0A=
=0A=
Could anyone confirm whether `perf c2c` is supported on Alder Lake CPUs in =
the 6.8.0 kernel ? This would help me avoid further troubleshooting if it=
=92s simply not supported.=0A=
=0A=
Thanks,=0A=
Odysseas=
