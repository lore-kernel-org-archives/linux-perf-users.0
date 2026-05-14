Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864882C11E8;
	Thu, 14 May 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774227; cv=fail; b=TV10CWVw/yzANWZQLzp5FopSMUIBVZfaELmMHz1mkJIVdz/3Y+Jur68HtbjQtebKO+XovJGtOr1ecGc19vOr3f2cRN8Z679aCuGPIdZaL4eUn5jEgniWFz3wS5ZxMn2Jf2Y9VfcVuEWBI+k/tpc41PjikbwbvVTzUw+NE8bhw6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774227; c=relaxed/simple;
	bh=v4WJF+LhU+yHzqCrpugye0WGw2UIcwpPqYyewkQClfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sM+FqGS0Avx3+ayVHTzSLD9ho4yDQq5eYfLZL/2/HpNjzOE2ZqOM1FdEdJ02TMZlIzr2QWGxdtXJfxJz5LGWkEsEMosVEbJh21f7/hHsRFrYZH0itclvKeP/cXZapVBtr02e5MlOYXad/5WsTCa/fKvWM2jXhsv4lZjg9LHTVMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sajbokMt; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sajbokMt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkNYjvaPYAHlK5ul7sGaFwRXCrQpjKqrvV5bAFKUPQvHkk2hliKlpOquHvKd+fQ1LuWsJvQgj8DT86urp9gcNrWS67PvIFOQGGLy9spZLiKWPJth4wJUTmow7GJ+6C88KVPTNv5OyPYyBh/cIcTMdkH5JazVlwNMabSvHFlNzqiKa08Ix9popo3tpTBGxs0Yv0oxRhbFsi6X3ajLWGzgduqPGdG9Zhc0etuCoZyWd/z2EGDCGeHADotUoO2hvDVv4ga+pLED7X6lDunlX2LZpJ/oaNfE+K1+moFPBYMY7GmT4gsjLo++O7MqfFMDwPvgEaJm6VHwnd42YtSk/lNksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mi64BuRO8NdTH7knlbbkksPN0TFxatHGR6WduoK+YDs=;
 b=l6xOeVjnoZI6FfydfthcKxUhvAUTeaMGDcHaOOX/Q/gnxhjA5w1+y7t5f53AaJn09OoSp8fZYR9CELml0bOs9xCVTW+XE58ofu/Y7aM0GP6G9ptbbbaOkvlgCNDxWrsUw66rAADLcgudvc1BQEFlqFL1oLzrKVXlcQPvAA1x+RXK1Tw3FvGy++BByE+KzWk70uJfc4KnLnHGL7E+bb1s5a8G5qhvBahVUtYryHuX828dex0Ppp2nGuiYxmFz3Lwufa8i9lV5GAwrH+W4BFW/3MYYqlgdeAYrc25MrcCKQAfXPiJh0I3Wv9ueFcQXZs+LtnWzTUoe6O3uU/KmEQJ5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi64BuRO8NdTH7knlbbkksPN0TFxatHGR6WduoK+YDs=;
 b=sajbokMt4bQw53ccjwTfPesGl9NMZeJA8Z/4/t/NU4yAfdp9gZzoJQKkxspnh7E7/aNqpVCYx2wmNdOx2o63uqWEiQyrQTvgw5fk3q3WMewZXVp7vsLHo7vwuv19sktH+9GKl2RJp6zqqxNRcO/lIdoLKOLGKIWVYYwUxVP6EHHD9KGmL2pKFUKxOhZB9Jo3182ngp/Fwe/7eV61lnAWboit4Pc6Bq3w/HsBR/BqTuYII8eEtaZm8+4bTDBTb0fboqi7euCK1PSu/m9v3K31Qt2pb7ynqT8LR/+qGp1myICiYMxRe+koXAzplXmwdHSaiHQbxNRIYSN20jicWg5Mzg==
Received: from SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 by SA5PPFB29794CA1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 14 May
 2026 15:57:02 +0000
Received: from SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807]) by SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807%5]) with mapi id 15.20.9891.008; Thu, 14 May 2026
 15:57:02 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: Saurav Sachidanand <sauravsc@amazon.com>, Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Andi Shyti <andi.shyti@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "aghayev@amazon.com" <aghayev@amazon.com>,
	"juew@amazon.com" <juew@amazon.com>
Subject: RE: [PATCH 3/4] perf: nvidia_t410_c2c: fix cpuhp state leak on init
 failure
Thread-Topic: [PATCH 3/4] perf: nvidia_t410_c2c: fix cpuhp state leak on init
 failure
Thread-Index: AQHc4z4POcudY68XvkGy907BbceP5bYNrfsA
Date: Thu, 14 May 2026 15:57:02 +0000
Message-ID:
 <SN7PR12MB722653C4D316E8EC0B2F54ECA0072@SN7PR12MB7226.namprd12.prod.outlook.com>
References: <20260514010629.76558-1-sauravsc@amazon.com>
 <20260514010629.76558-3-sauravsc@amazon.com>
In-Reply-To: <20260514010629.76558-3-sauravsc@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7226:EE_|SA5PPFB29794CA1:EE_
x-ms-office365-filtering-correlation-id: 95b98928-0b5e-4803-0719-08deb1d17035
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|4143699003|11063799003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 6+hClPKPNWnvHwzSFQNfGTwl9qV2IJUu3IqEo7bgPF9KwYoFTIJaHS5FDJRD5s1k8AmfHZyHsKpHVH7moonglvHRPDyfedgdYrJe6yeuM/6/Mt8lBOa6ANxcYK9iF71L06EkLqdJDKC9GqEyKKp7ksC3620vMCBmYSIWXrKzZ+csHnF1VaW7gdzN07YChXyyIT2x83dqav+uqfdgaFtmr4BvmU900ss5LSnFv8cHYRMOwznHa/mQSk8iyBy97QshkEApKNIhKkXDjj8zXIEg8YgWQzWBgcQHgO8YPfYljShQv3HmJ2RYYxlpYnJUSwubtzrXoIX6/Np4Yd0uZVl4NIEYNTE6SAAK3rqZia/EdwXws5x+Bu0ygvU+E8gmE8qRb0GJqOyQHv8mqfuwNyLay3BaiOkinPVw1C3BDxi5OECmzDZe7go3QDLtJA/2JCeLTN3m1TexOiNIs0JJhrkq5Q/ind3ke6X2uAO5d2lDSufKDQ5ihPhTBn7EawP7SGphR+NIuKH0OMzyS87oMm3XmHQRGmZJFr5ZwmyRM0KqsR8o8baN5WwcxYdiQ78/MhxPJZFyieNQze8lFUhG3tXzi+53yEywbgg9200KJZIElnx3Wa6uX56+Cno3opi7ju+memHms9V/7c3eZdZxo2lFtZiTTR89VJY1latONXAhuAq7T+1xRviajYhbQoDjC3OtC0kz/ZtzcIr+QwVgvGTyT3DkJZk4OUia2U0qUr53yQKEhpOROyem1vkpzLki8giZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7226.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(4143699003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sCT+oHDVUTfhlu4YN3tRp8uEhhphoZCGouW6ZswNVMMAGOAgriLW8y1RIRvO?=
 =?us-ascii?Q?Y2I2yKu/udRmdCEeexxr8zg2MkX+CiZOVM4T0iCl2KWneR6lEG7Ao9CD49XW?=
 =?us-ascii?Q?XN1+OkIaIR/FZWr1cSwOzIDPqDWuQFseTYmtCP/a5/imRAXg6D+DmSYsYSaU?=
 =?us-ascii?Q?854pvG0U70ZPetemvaOEd8djNM9QkgbB3kh6NIJy7a6jv4SC2tQll4YyR/Po?=
 =?us-ascii?Q?Xa1iKREYOSVHwADRsnAzWPnrSEsKAbjxAnkbTpSYc3OWbD2lY4PdkSo/upS/?=
 =?us-ascii?Q?q/St1lkE5MP14JKxYisn9RnGymKp75VawtFlS8yH2N6TlVIPU5sgc/2/Y/tg?=
 =?us-ascii?Q?z8tphW0LiuCuEHf33SwWkBWLEzVv7I4krBafCHoDlW4XFwz4W1FU8GBFbnr1?=
 =?us-ascii?Q?rNUeypiq/RFYu5oaTmMNtspElim5K7MctgOAuZ1iEcma47+SblaGa/HPFz5v?=
 =?us-ascii?Q?qCbMuSk9SbE9keJZOAxtJ0AGVttI5UtUqm8UYpuEi/bI1uXGxmxTaQy0fx8s?=
 =?us-ascii?Q?2S/aGV9QXXswBYSMY6LfdudVKp1nnaGGmiMma6xDobv31GHxmKsD2xQzLYiG?=
 =?us-ascii?Q?/NXIiDEVbj0SH9Zut65KfwMLq1W0z1FIAb61070OqZz5Xh8zdr0ZIbQRaY9E?=
 =?us-ascii?Q?Dnp1bEnrCWIMrxvJCTUs1DpFwWQkf6DYUAQ5nXv50cGiMZsiHV7lnh5SNXFJ?=
 =?us-ascii?Q?Vsfs5Els3bHpLILI2LvCrKU6+M4WEL3oXInJLkDOX3H7J9DOmiOX5tuvLAh/?=
 =?us-ascii?Q?Qf5U96sfVGHAanawdDxG3hhMPfH/t/bwKDzZ8Fr1TNqqBSkXtwedKYlOU/70?=
 =?us-ascii?Q?IatmcGRPiSU0+4xTsfAeyUI305ZuSfO5Ggl47Lqu+ZLCGF5Ot27Jt9wtHcMt?=
 =?us-ascii?Q?0JPFF96SL6VbCuyV2WsC8+Bosf0pT+XhlXdRTRHDU/XKeAFmItmPhtg70dy1?=
 =?us-ascii?Q?rUBd84k0b0mBQRW0U1ErTB6nACAqxOV9ySnwM7O6Ioc4XPE6gVMjb86Pgggn?=
 =?us-ascii?Q?nHt/MZAvpzVXARdc2hMxEUPYgzXqcYOYmQfCJikYt4Fzfm41ck8eW/6f4Qwg?=
 =?us-ascii?Q?sc1XoywJq/1oMknCOjn5+e8bUVFnP8b21PSLnEfVziBCgt/1c3LjEUBBSxYP?=
 =?us-ascii?Q?4gfB4D7SPzdMtLhsGsl6VYNQPD05l+15TIl8ByPc0yBQJ4shHOelCWQWA65q?=
 =?us-ascii?Q?0Epfs2aZbCnW5BdFO76Y7ScE1SZ4PawtMR94hlf9+CdbCjJJAeb9PQuQBmGa?=
 =?us-ascii?Q?pr21xCM/xtnpdOMwj+erfW/gtsxTvEbh+Wl4eeuTk1Hf5TfE1ziMTAa6WCfp?=
 =?us-ascii?Q?xeeIfq3qB7XFX7ckrPNeLkXqTNMvvys3E0l13SNbs2HNKWhs0piYCoAmJIVQ?=
 =?us-ascii?Q?Zbc6BLva+hprpe6aiCUQIjxIj2TUFuV0plAaJy12fU1Ft0p/ERIzLW5EgOQY?=
 =?us-ascii?Q?SF+R0CyXco0J6i1UrKIqe36vBTn9jPBQY90yU8OcVpdJwUe5CeDP5iVBOQ4e?=
 =?us-ascii?Q?JnYxb5eVJvR+NfAaRGr0rdBOorKMeNFNl0MZvIpgpUO8gwa4vqXQmZlIe6aY?=
 =?us-ascii?Q?1FZ3ajB2vzVMrBXzvvc/EEbC2etAGGEYZfeQbdTqra8tG/qmebpirr5W4JAL?=
 =?us-ascii?Q?JIYOdYRhBEZ9trWB0/tbDU954+5aSS2i2Va9J8OWe6I0FOkj9FIFfNJwqWT6?=
 =?us-ascii?Q?mIJuLP34sFsOiVRu65fKySTr1UWRgRsobRdEIL17jNHHk9LzcJcmQOZy3MzE?=
 =?us-ascii?Q?Ctb5vmeGPQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b98928-0b5e-4803-0719-08deb1d17035
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 15:57:02.1455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTlZP+GIDaaL/0UIeqRZ2+trnITjWr/Wh5qiRa2+m+Gdd74lzHv4QGyA0CZ2ro+W/Bgb33tU5M6wTluOOGaQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB29794CA1



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
> Subject: [PATCH 3/4] perf: nvidia_t410_c2c: fix cpuhp state leak on init =
failure
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> If platform_driver_register() fails, the cpuhp multi-state registered
> by cpuhp_setup_state_multi() is never cleaned up. Add
> cpuhp_remove_multi_state() on the error path, mirroring the cleanup
> in nv_c2c_pmu_exit().
>=20
> Fixes: 2f89b7f78c50 ("perf: add NVIDIA Tegra410 C2C PMU")
> Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
> ---
>  drivers/perf/nvidia_t410_c2c_pmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/perf/nvidia_t410_c2c_pmu.c
> b/drivers/perf/nvidia_t410_c2c_pmu.c
> index 411987153ff3f..662fa1bc833a5 100644
> --- a/drivers/perf/nvidia_t410_c2c_pmu.c
> +++ b/drivers/perf/nvidia_t410_c2c_pmu.c
> @@ -1034,7 +1034,12 @@ static int __init nv_c2c_pmu_init(void)
>                 return ret;
>=20
>         nv_c2c_pmu_cpuhp_state =3D ret;
> -       return platform_driver_register(&nv_c2c_pmu_driver);
> +
> +       ret =3D platform_driver_register(&nv_c2c_pmu_driver);
> +       if (ret)
> +               cpuhp_remove_multi_state(nv_c2c_pmu_cpuhp_state);
> +
> +       return ret;
>  }
>=20
>  static void __exit nv_c2c_pmu_exit(void)
> --
> 2.47.3

Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>

