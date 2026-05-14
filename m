Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB972C11E8;
	Thu, 14 May 2026 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774350; cv=fail; b=K7DzNCEOzLFVj5zFaZdfcqjfdB4VSjiTjQIGkTk+B5vYFnQIC3rZYJWOd02I8J2cBSXfyw1kY/lN1dspBNBeRxVhBa1q1qQxdjhPexO699rRr/M8Zu3StvbR21pMwskNegByRlpfU19rXLyuo6WkaecmXZ3WlwEHa58jBLJ0VPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774350; c=relaxed/simple;
	bh=siu18bAzuUUHXDDP/2OypVaNMUVbcPi89ZjIeRE/a2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BV60Usv1noB2XD00VqsMWw+yNU8Mgm90JCXhtbGuedVvySI28ji11SFjPXH8zfNfaFQ+nAZRKWLzy7q1/eUoLlmctqRzLKzoAt7eCMJWv3BCz5Tc9+XrOovbiy+NbpTrE/ZkKsDVsUY/vV7nVCfbhJ1FfmvDDNJy9iRZ5bLptfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UvsOvmNZ; arc=fail smtp.client-ip=40.107.209.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UvsOvmNZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK3tWUtaAzDeTYmdd9Ov0z8AXSnx5K0Q6Alw+t8mIEPyxqsNi1196jm41P3KJIDVy3HR2tg4BP8Cp6M3ZuyibfQ99aOiiBrk0Fzzkg+Oxpu21vrEURY3iaySdSeK1681DJUqT2KNhR8m11zZVRiWDT+EpxJCCvH7h1idwFDZWDl3Z5ugUvb8LAe0QBTouBsQygno29m/+a+cipq1hJS5TxaxD4AwL/dPkRjzYwSD28f9yirk8G9IbQgsfvUVjmGarn5D+hseuAPqkaEFgGmeq4vyiOZKjVjh1E/ZBcwFtEslqI/tXYsHiF1eYU9eoUbVEue1+M6rdRfnim3eo9B5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3c828GyX6BhWH/py7eg4oGSwRX3wLGFgRXYOM4GoqI=;
 b=TheLE/i2Yp4eRiZsP4bFP5wSWQeMpJFlnzEl/6nYczom/LkpQs39VUOlPAQ24cPoip3W6D3hsmqwk50qKtJAZormjMFjKP4FtQh+2d0FLkDPmpzx1/T0Wt/qf/zISpr84+W0Yf4mF5J+/1BBpIpVooXPWZ16U+rn7szhxUNsb84pQOF0WMf8pgZ5++LlmR+kcI7Op68Uf2a0InJaqfwkMvEwN8rBGHx+cQA1sRTJ7u8NsgqViwjzgn9XxbDq5yDKexVXoXKORCCogV+mqpQ+M7Sr3h+5i4YwChL50nQ2OGlwApBsTWB3/tEnn31QgyVTDRxa4FMuQ0zD8lRV91rZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3c828GyX6BhWH/py7eg4oGSwRX3wLGFgRXYOM4GoqI=;
 b=UvsOvmNZ+PulLG4ICOU8dRu+r8p4n8f0tmTqblnp9D8P0vCG+xa7+dBisCzYNPTA/LxRoltRrQJBCBU+t/yBAV/E5oO/4F5XxHq+VbrtQ5xrkVZGHsWfZiM2wib0nRDEIv/li/6/oAiLTHBnjcUrWycvweP3Q1nF8hggArd14ySbfel18rXfgslgHsu7CbkL1MlnsgqNNbFHcFhWY75oWC8VSH65cyM3dzemOAK7VX65WM/4nA+6AZ6lh7hvUVB8D2CVcFtdHaBpYTzvFEaJADel0288+Y9/YY0ZEhruxwYc9DrBVJDdNEIJqs9jmGna9APB0eLUkZahWvXg4ZHP0Q==
Received: from SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 15:59:01 +0000
Received: from SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807]) by SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807%5]) with mapi id 15.20.9891.008; Thu, 14 May 2026
 15:59:01 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: Saurav Sachidanand <sauravsc@amazon.com>, Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Andi Shyti <andi.shyti@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "aghayev@amazon.com" <aghayev@amazon.com>,
	"juew@amazon.com" <juew@amazon.com>
Subject: RE: [PATCH 2/4] perf: nvidia_t410_cmem_latency: handle PERF_EF_UPDATE
 in stop
Thread-Topic: [PATCH 2/4] perf: nvidia_t410_cmem_latency: handle
 PERF_EF_UPDATE in stop
Thread-Index: AQHc4z3/l2BRjPUjKki1q7sgpZIScbYNrkpg
Date: Thu, 14 May 2026 15:59:00 +0000
Message-ID:
 <SN7PR12MB72265A5BAF273508462074F9A0072@SN7PR12MB7226.namprd12.prod.outlook.com>
References: <20260514010629.76558-1-sauravsc@amazon.com>
 <20260514010629.76558-2-sauravsc@amazon.com>
In-Reply-To: <20260514010629.76558-2-sauravsc@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7226:EE_|MW4PR12MB6850:EE_
x-ms-office365-filtering-correlation-id: 2dc4b9a6-e124-435f-2ece-08deb1d1b704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|11063799003|4143699003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 +LaReyS95DQiAxRYgkSAZiHypEFMHvjWDsd4HxiTOzIlgammM/AGi7PQMidPB7ZWJ9o3Wwlx8h7Zk8fqsjJ2WkmoUqeb0X36aNEJhnvdmWNBR0hZfsv6B3BfJs9MBtCsEGpzux3UHgqPNX1sHJytUQIATBUS1SFSy4FKKvnEFvQJqQVx8fzslLJt7AWLY9cqr8tPwJyaEey52MiXdk5iwICtD5QnOC/KP0fK4e9axab9yII1c9DC4hjcE5uIDrB2qXLBYCVB0Iijis4F+P06nzF1XcEGPEdcr+rnh5L77qCoMqu9kVjhnGHTSWpGq8ozfKbxqb5Ni4lFIHRcjyrYuWZ4bpez1O1dkz1IcGVvVDlY2mmTBZdPFTotIxnyxDYA0odRuslaYJGeFtz/8tX3dg0k0b/XER7i0J98kHNv9yC8W6FCLD2Mn/uJ+dvolA9oZ+04AnaXVKrYkhJgeSNhqmZndkS9dxh7qDsfpIzh7ZtV7lwrReZXvd34oqHwmCTekyPHvD2UcjpkJCpLX5V8zOkC4H/d1Ji3yv0aHROENPCh7g7Lx+Nq0X9S/M7+RWk3m2cf5cL1i6ni9hmkob15pHzwgawpCI6a7uO01ods266gZa3f8nQ+9Eb5Hz+E55enLdVpxgkDCl6TG3GDcM3/pVqr5nRbbxLBeSiQspdVqcMMkNY8HpzTHa+sqEgGASQ5Jt2YtjwixbgRVjwomBQTPnVmu75ruimtl39W9TA+bZz6V7If2DwS9lzBY5Jh6CGX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7226.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(11063799003)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5I74GYjBeG0wSXtf78mcyM+ElB30DaI23y1tyf6ZTPI5TLeDGBzw8cE0ep6t?=
 =?us-ascii?Q?Cs/Fj1p5tL7xYzpGnMw8/fV1nROw5x5RzNR0fPrT+9C6VEZ4lJL4u2u8DRPS?=
 =?us-ascii?Q?RyRvud/dGbQVHRytMD+cdxV6tRP38AuJzA4CiQFErpP03wh/JqwWWBYxvOiR?=
 =?us-ascii?Q?g40+oKz9qr5+e75nCj0A9tHq7ceQFRu4cjjl7nTwQIM1K3/ElfDI+pMxJSqb?=
 =?us-ascii?Q?ZI3eYnWYmQ7B+b1qAnXwX09Ez8QF8W8DIfUoycH3Cn93qZyQknPCgpog/Lkg?=
 =?us-ascii?Q?G366tUAY19lzUXdQWur76eHXS5H7toEEAtrfntcD2W+A98kNcbr1Ro7kZT2H?=
 =?us-ascii?Q?xn+Aju9ydhkvjzkges302WPoMVxr4chHk8AxdjB29qqRx+kT1jokQ4jFtPfn?=
 =?us-ascii?Q?woSmz5dpLBmspMbDQ2Uj6wdzF4MH/HdoZOhjZZZH+xe9I8lhpNLUDanOeGi9?=
 =?us-ascii?Q?onxfaWAG/JzlkpxeIlusBoulCZ9/knetSzYCjG5w0ABaU2CtB+MgXY1u9qRm?=
 =?us-ascii?Q?ZzmvDno/xv/PMQ5zTYJFTsko6xRF1HAs/alwXfpU663tIBd93JHcqmrQTYO3?=
 =?us-ascii?Q?yPfBV75o5vP8LTQopZXnGthE1CVyOnNSSPglF2oabo37es6kMfktj3d/tRmk?=
 =?us-ascii?Q?l5DKKHL4E9PCX7yljGjrvDhpud5CrBahu9JpZnu5CJYXivCd8EDf8CEaSDn5?=
 =?us-ascii?Q?kKmk/aXkjNlCpmRrM2ylw3HXaV6GVkCWHUWb976QSe2jmJX/1VcfItldbPqb?=
 =?us-ascii?Q?+k0ppAOMGRkK7uWzKdXGQZnbksAifJLT5+3rG3vxhDCHIKO0osSDHhdLFA2e?=
 =?us-ascii?Q?i19UQvJlNO9AmJAJH8k9OpQ1mqGMwrqv2UCj8GQiqMDvv56/eslbI2nkY2+5?=
 =?us-ascii?Q?N3oOvcrdMXrQhdDj3dEPB6tO0ORIlAxt21SEX2tQjD0F/M/2aOJ7IJ2rkbGe?=
 =?us-ascii?Q?MpaDCSI3BU7/Z0sQuCQTWntG1SCHymTzgwjMu+UZ5LuFsfdxt9H+woaRJt1p?=
 =?us-ascii?Q?rwB+zLqWu4dWVitdBW+VDXw1v7Hq6qrdorS7VIdydyM1xIlknggvj7GX3SkR?=
 =?us-ascii?Q?TmDoMhN0HiShWvaaYwT7m75Nnij5DmgDQhe+yOxk5wQk3KnWfsp27CRDCmi0?=
 =?us-ascii?Q?PywjDIm1vvInKMmcg4hreF7t/udryLeQaZGalCr1tOIpUHdppCq0Olr0W0gt?=
 =?us-ascii?Q?PmTenHCCtldVNLucSzq8QsKV4A+TCdf82qiUDBxtI7olBa8fHFPlHLeIUdLY?=
 =?us-ascii?Q?mYa24SCrYs9ymvNqzGtI8n08K3SMe0FSbLhWq+TaOTVoDdcvZ8p19GSMDqPe?=
 =?us-ascii?Q?MJHvPgPsqzx6j8I+LaA6lDhzaFJRbc2soF4mD11mvsv9QWrhsK1PPtFM1PkE?=
 =?us-ascii?Q?FEiVeUjKp9/FYIB2kdGCpFXMdL5yWY9zDagI7J4kUxMq5d9zvMOdcaD2sGOG?=
 =?us-ascii?Q?9s8nykXKA4nnMuTktxwStRSE1l8f/MQq4kpN7AOJapzd0PA1qWej31LnxmZ8?=
 =?us-ascii?Q?bU79+2x/ROrU5CL4d1tFBbvaOTO8i+6eDMcyhp4Vkye6KJXfZTZwdhc5ORW5?=
 =?us-ascii?Q?k/+TmzPt6OkDPc9vK7kfsIPUHlQfTXCSfJ8j928HRHfLd4Ki7yfyssZ+H/IU?=
 =?us-ascii?Q?QmMYREMvlbUkBLRHAPhmm7U40gHaUNGVJQFR3mmz4X6HeUA5e9ftc5wxvoWY?=
 =?us-ascii?Q?G/y8p+KTdkLEC1AzZ0poc0cknqLmoaxIlMZLg0i6TJNboCeEXUUY1v+SkM0T?=
 =?us-ascii?Q?iUAjnJTqkg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc4b9a6-e124-435f-2ece-08deb1d1b704
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 15:59:00.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4IvWl5a4ny+LWz+0Avmyb69KGPtXP4AWEqD5lNEFD0SptvpXwkuLSnvLmUYM0MSGdMOFjYnj+DwmnM6P46okA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850



> -----Original Message-----
> From: Saurav Sachidanand <sauravsc@amazon.com>
> Sent: Wednesday, May 13, 2026 8:06 PM
> To: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>; Besar Wicaksono
> <bwicaksono@nvidia.com>; Ilkka Koskinen
> <ilkka@os.amperecomputing.com>; Andi Shyti <andi.shyti@kernel.org>; linux=
-
> arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org; linux-
> kernel@vger.kernel.org; aghayev@amazon.com; juew@amazon.com; Saurav
> Sachidanand <sauravsc@amazon.com>
> Subject: [PATCH 2/4] perf: nvidia_t410_cmem_latency: handle
> PERF_EF_UPDATE in stop
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> cmem_lat_pmu_stop() does not read the final counter value when called
> with PERF_EF_UPDATE. When perf core calls pmu->del() -> pmu->stop()
> with PERF_EF_UPDATE, the last counter delta is lost because the event
> is marked stopped without reading hardware.
>=20
> Add the standard PMU stop pattern: bail out if already stopped, call
> the event update function when PERF_EF_UPDATE is requested, then mark
> the event stopped.
>=20
> Fixes: 429b7638b2df ("perf: add NVIDIA Tegra410 CPU Memory Latency
> PMU")
> Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
> ---
>  drivers/perf/nvidia_t410_cmem_latency_pmu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> index e27bf31b2b366..c7fa54c7a7c9e 100644
> --- a/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> +++ b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> @@ -303,6 +303,12 @@ static void cmem_lat_pmu_start(struct perf_event
> *event, int pmu_flags)
>=20
>  static void cmem_lat_pmu_stop(struct perf_event *event, int pmu_flags)
>  {
> +       if (event->hw.state & PERF_HES_STOPPED)
> +               return;
> +
> +       if (pmu_flags & PERF_EF_UPDATE)
> +               cmem_lat_pmu_event_update(event);
> +

Hi Saurav,

This call is not needed since the driver called it on pmu_disable callback.
Adding it on stop callback would be redundant.

Regards,
Besar

