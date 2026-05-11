Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABA29D26E;
	Mon, 11 May 2026 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536124; cv=fail; b=NF4o6o8rS6wiXWP6io/amMqtCCwZOTTq68HATM9K3hDpCul2vEpUVeSpw7DeSebP3iuIY0bxXjqu2k/FUhmxz+BRN96p9xWxD6erR2McZtQmcYtfxd9SjCI3GrSuLNzB4Ac42Oza6LVoI13aO/uYUjs4Je53I9DCqvIUw8UMUn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536124; c=relaxed/simple;
	bh=BeW61KeGQ0WB5MOQZex7KTXzIoLc1PVes8Qqt3iQrSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vzid00lBnOUDZ0NRDLBfi5vtHLzVuEus2LyFyNpTyibkCJSgOgPzodiTWvnu62n9OHip/qodXk4w67ziqZIIsOrAkMy7Q7Anm3RoHGNoTqaB6Rp8ngQOXZvQsxTj7Lzx5JiM/xwK58SjPvE1Rqp8iumRmVb3gvPiPXXQ7Rm/gCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cqh6EVO1; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cqh6EVO1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXt2BrA95XrxOlukCC44CYnPrh3ITl5t1WDWolqqoD4LVeDe+eSZ7VuWvL/GVYmzQftECkf41D42npgCbR+NVfWcHZQVNqqdgqdG8F199Gt4Q4QfyqfR0YYfSAlkoeCxQvXZegRTKirhakY5tUj6U7+/5TKlpiaSaLaDZLYlJY+FL9B3HJ1hleGVOmweLZfI//CYBtz52JIwyPPYhVlvIEBMzs666ZbbsMuctEK2qXxOqSKM6xTRJqDdFzME2r+cvvHsNZ6ljRqdfUR9syN9R07KeVp0/TOYZ6xiBUDbLxzPkn9KM3P53IPIPRTO5ZHnN1c4p4fRMk1YRIj4h9Vj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoI4ytuFa7giHeIrOFRBYsp/75gbOS8l3jI8xWSL4Qs=;
 b=K2jy55R78O12s5A2NQoUqVe29dmNKwN5Vnv4Wn+4hxLm0vMms2yFVM1G8fhG+7Bk9Iwgd/jZrV1hxSrHo/wm5yS6rsGLwa9wQqioadMo+/6WkK45yQGpxHZ5gNbN1g6gq77jxkPQX1oMLQ6KakvOpumWx4OaSmjjfs3JKnRLyTfQ0zcvcsokQ3LDq00OtZBtEwaEI4VIhXkXOvj4ussnc7DRgRJAO0qNR/wJa5+Iwb8PqszyRFxwK/dddbLCryIhWisO9oQIRuLJemnBdjqYdnE1qea3X+SUULrfZ57jN3Mpx/pDzDmrNM12e7MaoNSajZCpeIARIMYkbMdKO+S0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoI4ytuFa7giHeIrOFRBYsp/75gbOS8l3jI8xWSL4Qs=;
 b=Cqh6EVO1Jp24rF91xKmCed7AZVjXXj93W5o/DlDEWSjAXODzDWdVD0p7j6Q4OQf5w0Am/nhzGZJHxtb5YfRV9Dq0ll+cTDasgJUrRFMAV7Ez3zCyd8kOSRqPeC92FfDldAw1N4aeLdVHllOa2hF+qcIw2pKR8bxFJe/eV8aUvQqx24qsEislgQ3OPwtFJh7CaF1Y2GrZvyAcTXV5SxJJ/3nkISoHrNRAltS/hCaVTjNTKgazfIMmfYOYNFM1CdYpfaZq5+ISn9fJfsmK4oBqvMhl8zU2XrVe4i3Pa9Uwx7F3cz6/yUUWGF72NMIdAP60a/B+KDaZN9GVxPNN6dV36Q==
Received: from SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 11 May
 2026 21:48:39 +0000
Received: from SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807]) by SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807%5]) with mapi id 15.20.9891.008; Mon, 11 May 2026
 21:48:38 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: Saurav Sachidanand <sauravsc@amazon.com>, Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Jon Hunter <jonathanh@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "aghayev@amazon.com" <aghayev@amazon.com>,
	"juew@amazon.com" <juew@amazon.com>
Subject: RE: [PATCH 3/3] perf/arm_cspmu: nvidia: fix BDF calculation examples
 in PCIE PMU docs
Thread-Topic: [PATCH 3/3] perf/arm_cspmu: nvidia: fix BDF calculation examples
 in PCIE PMU docs
Thread-Index: AQHc4YqIaMNh6YudaEO8OrfxRr/KiLYJWlhw
Date: Mon, 11 May 2026 21:48:38 +0000
Message-ID:
 <SN7PR12MB72260CAFC4E3603312A44EDDA0382@SN7PR12MB7226.namprd12.prod.outlook.com>
References: <20260511210905.91917-1-sauravsc@amazon.com>
 <20260511210905.91917-2-sauravsc@amazon.com>
In-Reply-To: <20260511210905.91917-2-sauravsc@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7226:EE_|SA3PR12MB7921:EE_
x-ms-office365-filtering-correlation-id: 59db016d-2132-45cc-7fd1-08deafa70f85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|11063799003|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 U1nsOjayKiOxruk4+zcgC1BAgax80by/hJf4qBPyDtKgpE55fCbGBAIX2zulKT7m8pJKVf+t8ZtBJoJJagpOaijC8Jlub4uoPV5bGinUVBasifYDTRpJn0ttdne5ypcLVNEu+FaRQcOvjw0aw7OE2WomVd/H5XnUJIsKFmDqmTEv3/v5NX2cdPsFIJWR7voWB1byMYDXrvIofR4ZRleaYQgcZxdP/a9Cva4YUDyhYuPG6Ghfqn5rSVIb3DaMBD3uS/Ys4IznRNS9wEKvWJoz6dwZZTQA0fMpUkqHpDY8Di3v/capBmJGHzladW7kj4wbEwfSgoh6iegdKyCh/4wkWD9qzoFUvaspSTx1If9rMhvdqNFE9+ZB87IG4D+ZNDX+Zf+2NdqTe4F3KoBGcrJx4rMRNbIQy8es8YP1Au8JimiMQ5VXSTVvmdLxkK2Q9ovInfAfSswx3UsyiqZEUalEmspzAN2aMejIPP2+OKraJRtSKJfDd5whgC2DwbmuG7JnvbdeMW+ztVhoPk899oIOSL7MzrS8hVU6Vdb8RdWY5vVAlTnBJicNYHkLpPyJDEdDZNbHdeS97apr9/1K3TThpZHOgEcXkuplA2D3qP+HQluxqXS/aqKQeaqofXIDK9KO37jzrklQA5EGNWJTuKkzP0TmDV8J5DXDPkWU/wlNibk3/qph68lmBIw3I4w04zGovjGP1emVqqfa7qkX4+4/b+KdkG1wT/Ac2S6i4W4bZOnxNos3hP/Zd3FdFadWpNFd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7226.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GUaZvBf/W8LhNuJ1GfcrBbxhe3GqyHTqmOwKHBSj404gv4e7CFmAriKzgAdI?=
 =?us-ascii?Q?vGg9D1bU3p/RuWYlbepQSkQtcpGF5cCkqLF0zZ/VXdvg43zquF0tkdAPO1IZ?=
 =?us-ascii?Q?yTSubFTM0wuVt/RupYgSgQO4YlDIEpVb2ARDBBpHBDzWESePkmAEkYbJGIsZ?=
 =?us-ascii?Q?ViTDPOkEd0NgUYw5xBMGRUScrLzEwi7Ex9RmqbiOhmQqcRI1vGfO3aj5HUYl?=
 =?us-ascii?Q?NCfBCL2GDvEVeIl5xd3sXgH2pw18QM7ETCg40m6GbimtyG51QyH10p69/n5X?=
 =?us-ascii?Q?jrQ9mblqve8un89hY8JZb9654TzbUGG8sYeGCKw80RoNg4JLr5Unqf7U2Lck?=
 =?us-ascii?Q?LPuMY/MOaT/OLO7y8hSje4DdRL5nqn3MQDj7f8aKqVlTwpn9riz6Mswsf0DY?=
 =?us-ascii?Q?OWFP06SjP5+h5+DY63r+4yzt+v1gTc5PopMSObAYOFP7T2by4IikiexC27VL?=
 =?us-ascii?Q?klYrb20QEQJ/QMxEfT6dkf0PdtZ3IFiKR/hMWKdERI+GMOGEoqqG2gLtQYOk?=
 =?us-ascii?Q?6WQ+wwUtAgLQ7dHJriwEwNCd+UvZGgnW6R1a3xTMareFPLHzpPdTtEKbCB1Y?=
 =?us-ascii?Q?rddXM+nkXItnFx8cEGna1cu2mfVgwoxOateeGCquCXPNeww/0jQZumRKuSWb?=
 =?us-ascii?Q?X57SRPjSHuEZ8nRzN0aqrYXjzL1m0AfP4BYYmF7vEAYRzkNrKnnN944UyoVD?=
 =?us-ascii?Q?aDMXuZwv3kb7M1hmhUemvsTf3v//ybrhTVoOgQxf+vtPY5uEj3yFfEtZKrqq?=
 =?us-ascii?Q?yLxTtMcDnLIZdqgtdpulw4X8RZBGqkxlNAxDAuZuE9CJmvrc0UgF6MWQJG3Q?=
 =?us-ascii?Q?TbvFOnpN1IDm25avrDjFKtgSXwDQnk+LHLOsciMKoDxvGvEdvZ2KvqITsSH5?=
 =?us-ascii?Q?GMg05vCvOs+gMDmJyoztTnAtH7VBduWzymuYKugy1Seak9UscogcOvJhWuki?=
 =?us-ascii?Q?O2Ev5YASqyoRCrPDBDGv90EFFPmhm/498Uu8ZL9FEFFwaEogwgWZku+qoDWP?=
 =?us-ascii?Q?CKRssBQuIYj+zmimYnle1oDi/2lubsagB43xZkDmdW9S9U5EMoF1029h7nLk?=
 =?us-ascii?Q?prO3DTopI21TIKGNWnWNgyf/nz2qF/wW0nuQTKY8/E1odO67o5+D8/zQ7kg6?=
 =?us-ascii?Q?vgOONRP4BJmEiv9ToxTOJyU7PvEHZN7JpjD9zlchjWS0eUeld56rnV1a0ZKl?=
 =?us-ascii?Q?4ukBi9pOuoDFdF1VrEWockggZEbHxFXhixYjMh56Yk9QcIUtR8xEXg9CsT9U?=
 =?us-ascii?Q?36uq0sWS2f4ZCckXz7vsawp1GLmcR+/ktTM4YpYmoUMSv0pX4QUyPpOSkmgV?=
 =?us-ascii?Q?dmHhw/YPZwLYtAd6v5GDpxzd5L4j+1WeMnOpTIOpho30FWzcao4So6V3MUvK?=
 =?us-ascii?Q?q7KhJhzfi3PIFu2gubbltMbMbbDvq3JGSZyGLd3ChtuhNyE/+GXKehL1dxIs?=
 =?us-ascii?Q?6dS2s6b6hq0JFMvYDutWRxkR1XXk0YMGz9yzxXe5cA0tLRO0fh05DrE5ollL?=
 =?us-ascii?Q?cdXOmustfcb4R1QF5jjaK1bZR4Ho3eSkkRPqWuxoImtaZbKVHKtVcfVgaQpc?=
 =?us-ascii?Q?DG+iTaJjWZ3QHbfvGjtsEH0EGAXypFahtFIyBskEgMTVQYws8SbapmrbzBLs?=
 =?us-ascii?Q?tiK4UxeC4WsnOhRt793TOEHly5RXqRAk5AsiEbq1OS06aR7QLI60MuDFnG9c?=
 =?us-ascii?Q?lryeXXDZu0c0RogBUd8j+gLIM3qUSUYHhjb7Zj6/UEVdfdcCsQvJYFuHjuGj?=
 =?us-ascii?Q?/IrwGiSVWA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59db016d-2132-45cc-7fd1-08deafa70f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 21:48:38.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qq+f2DGjJ+Bs0Qp6qLlibBv9tPCP80lZ7Nf1haLe6BpaoWGmEB77zdwYHMySaIktjsq2NYQDX4lSnp+7iAhNCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921



> -----Original Message-----
> From: Saurav Sachidanand <sauravsc@amazon.com>
> Sent: Monday, May 11, 2026 4:09 PM
> To: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>; Besar Wicaksono
> <bwicaksono@nvidia.com>; Ilkka Koskinen
> <ilkka@os.amperecomputing.com>; Jon Hunter <jonathanh@nvidia.com>;
> linux-arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org; l=
inux-
> kernel@vger.kernel.org; aghayev@amazon.com; juew@amazon.com; Saurav
> Sachidanand <sauravsc@amazon.com>
> Subject: [PATCH 3/3] perf/arm_cspmu: nvidia: fix BDF calculation examples=
 in
> PCIE PMU docs
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> The BDF hex values in the documentation examples are inconsistent with
> the stated formula (bus << 8) + (device << 3) + (function):
>=20
>   - BDF 27:01.1: documented as 0x2781, correct value is 0x2709
>     (0x27 << 8) + (0x01 << 3) + 0x1 =3D 0x2709
>   - BDF 01:01.0: documented as 0x0180, correct value is 0x0108
>     (0x01 << 8) + (0x01 << 3) + 0x0 =3D 0x0108
>=20
> It appears (device << 7) was used instead of (device << 3) when
> computing the example values.
>=20
> Fixes: bf585ba14726 ("perf/arm_cspmu: nvidia: Add Tegra410 PCIE PMU")
> Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>

Thanks for the fix.
Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>

> ---
>  Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> index 0656223b61d47..24f0e801d7b80 100644
> --- a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> +++ b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> @@ -170,7 +170,7 @@ The list of event filters:
>      devices in root port 0 to 3.
>    * src_bdf: the BDF that will be monitored. This is a 16-bit value that
>      follows formula: (bus << 8) + (device << 3) + (function). For exampl=
e, the
> -    value of BDF 27:01.1 is 0x2781.
> +    value of BDF 27:01.1 is 0x2709.
>    * src_bdf_en: enable the BDF filter. If this is set, the BDF filter va=
lue in
>      "src_bdf" is used to filter the traffic.
>=20
> @@ -215,7 +215,7 @@ Example usage:
>  * Count event id 0x4 from BDF 01:01.0 of PCIE RC-4 on socket 0 targeting=
 all
>    destinations::
>=20
> -    perf stat -a -e
> nvidia_pcie_pmu_0_rc_4/event=3D0x4,src_bdf=3D0x0180,src_bdf_en=3D0x1/
> +    perf stat -a -e
> nvidia_pcie_pmu_0_rc_4/event=3D0x4,src_bdf=3D0x0108,src_bdf_en=3D0x1/
>=20
>  .. _NVIDIA_T410_PCIE_PMU_RC_Mapping_Section:
>=20
> --
> 2.47.3

