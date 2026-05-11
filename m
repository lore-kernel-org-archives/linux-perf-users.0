Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4BC47CC96;
	Mon, 11 May 2026 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537373; cv=fail; b=W3PnRxAkKulTIHM3yhYVE5uSxywfLni5iqB7qx4oNBo9H6X+UssmqbrpAdwF3WU4V3HLCIdPBcnn8vjg4fEYUOx9p9s/4cfJYktt4WJp8EEiVyY9P8/2I5vvpxfJqfVIGy+znh1W7entRf85G9sqhadGFk0gLtCsF5B1m7Fz28o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537373; c=relaxed/simple;
	bh=0QZNa/p0wKDmc/x3R0X7nGybzytfOYZv42dzjMskMi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bseEKVd6cskpyZb9CR57Hr4c1WTd46WO/NNPY57v0KAdBzAbDDB2Y07cDpeTVSLw7tNpPTXjGPvEYWLadnY7XS0yRdlVJH93MtteDgwU0NkRFsV5fVVBpeSAIbZy2cE9cxaLmZ+KjTYOTF3yJjlFipPF0HRtdZWulHY7AJrV9hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pbR9qGf1; arc=fail smtp.client-ip=52.101.52.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pbR9qGf1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qt80r0AbyvZSK7p61hbwUaRo97eDvSl/dRjWPMmXOix9j14km8EWELvbUPoLYBVvCbwOpNoXfmsODQ41AC1RWbsc7JQ7/DO/YLtyK4CfNnSgUTuIZQkKJKKzdvI4KH/2AXPDslj1u6B0GOmzryCzOzapMMfs33sZxyl0DaO1h0VI5TfKanD+Y0JiIXLM5fqceudqWUzwbKPb87ICfFHERfX5/blXzPqp9Ys6ziV8rd5/roYozdoMFTITWfk4J4OBH0ebhb18Xyntl2i9HnTvdsDcyBMWZl7aergIxgnHhKQtPIT0lVTG8D59G2UsKnjI0w6NWR+moghUWqAvFShvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk52kVcFNcPLoh4pFGpo3a7sFwDo3wP9kDHD5b9pWlI=;
 b=VBxVvvKZpD9larDjVrKeN/O+POdCecRvVEQdfVYQcoz3F6fKcPESqca49x004c1D0zYMbmudLTgtwDZlTXY4JGy0HFa/NY3320ONz2aRNnIliB5B4khgVq+8TRsl5uQ3ECT6FKwhGN1We42KzD5Y1Cxqyg/PDW5Fl7QLq7pAHkDhfABtIjHe0sA8mg80XkjXARzzTMTC5va2eQoF1ZqJPsa6Nog8uV/+7sxKE/+wOR9atXgIU+DhqHDxB0wbeyc12q1hrylVQU09RRZSATcnCvzCk0hrWc3pMPM8V4dwn04Jb7UjNZ5FPvoZFGg7/O5IKkAfclasgT3daLAZc6a1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk52kVcFNcPLoh4pFGpo3a7sFwDo3wP9kDHD5b9pWlI=;
 b=pbR9qGf1WbjIRh4ZQhsiLbM17A1Ls9ImkmrNEpNNlbctrHd0i2XnX9AcNLjW1RtXM5/bMaw0COuOGJv8s7yHTRRml+gkN14TJmSJkoEhGN3CyvUNo+X7OGM1d47H5IW/E1n7zTOgJ8EBouOjgsncY6qkaEyjzKsStBnVs0msuPhbiRwic/jnfcf5n1eGPJuPoieAlTtKyUlk463MKAUAMZBosucBngSqDLSlBqHFeal3J4zfMsI0AvJKQzqkz+S1vBWMYu4DLUbNaP1TEWBD5jFI6d1aT5hu+QeyhwEL5qkYhl6xwH1wrFrSVxMZEzaqMPrA+V429GHfZS31oR+LfA==
Received: from SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 22:09:26 +0000
Received: from SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807]) by SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807%5]) with mapi id 15.20.9891.008; Mon, 11 May 2026
 22:09:26 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: Saurav Sachidanand <sauravsc@amazon.com>, Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Jon Hunter <jonathanh@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "aghayev@amazon.com" <aghayev@amazon.com>,
	"juew@amazon.com" <juew@amazon.com>
Subject: RE: [PATCH 2/3] perf/arm_cspmu: nvidia: handle empty resource list in
 PCIE-TGT init
Thread-Topic: [PATCH 2/3] perf/arm_cspmu: nvidia: handle empty resource list
 in PCIE-TGT init
Thread-Index: AQHc4Yp1JSp71u71sECssA5/VfSpDbYJXWYA
Date: Mon, 11 May 2026 22:09:26 +0000
Message-ID:
 <SN7PR12MB72269B1941185BB5C745D032A0382@SN7PR12MB7226.namprd12.prod.outlook.com>
References: <20260511210905.91917-1-sauravsc@amazon.com>
In-Reply-To: <20260511210905.91917-1-sauravsc@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7226:EE_|PH7PR12MB7965:EE_
x-ms-office365-filtering-correlation-id: 969c4dd9-1588-47a0-ab3f-08deafa9f76b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|11063799003|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 0kIa/cw0bA5ifPvhOfluXCbiPKupBfU8iZwVTcWlCE73Hod3AIZp/F4PCTHuQdgtAh4czy5Jryb0DpyRqiiozoPBbd83XTclSe/7/9u/y1mhDvvVVEpWS1v3y2PK4OS+Cnm118GkTwOjM83ZFZOzDRZvx6k8KNPmhgKwAYL5kXLnA5GsOWLLk/Azu0stIFUw3W89hITF0s3kt8n555rJKKO/KdWEGDslK/v3Zv6PO6avpUXXdKfBMvxrV3BYMdZdCHeqIl0Q/fXynrmREbY3cGpXbRODmeGPKdsL4bfr+XYzb/UMVB5bsrgsfPC+n5x5+cZgH71FBgeP+RZoMWWrgISuwxmPAHZljIofrHZOAsnPonxWQvBwOg/tCd3jcw3LIzGyz7G9Pi7A14DkwCM+bU6xZlJdUbu7TshsTRll6NEqNTkc9nu43jzymZsj0SwVLy9c6tB12TrN7uxuuq0MbayrY3aR1he7YBvW1ptntxuSM+gDGHF+9DIsmkENW2xF4yHpQNApPV7CEGPORTAWgjcXeCts7RxhG+stqovfM8KN1Tr0bmEUcaMcYG6Wv+/wF3kP137oXW3Fnn2FIsVws6BRXKSEuR64epqchGV4PawEGhwrqq0oRUgXrlXxBU+Jv9cEoUefEZXGF1AsYhveBOfBMj/RXscMV2jPz+pKXfN3OxGkaaMTxfJXMdYrTmnR5ZKQQB4Th0FLorShrDC9Gfyhfkq8yuBTFE/7I9Zqsmw6R8Ku1FoIRyEFzbKlasA1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7226.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VxMIUC49i0tejSwusrQ4PllfODG/YgB0yM664lx/CQQ+gOlNC5h4Avf61G5G?=
 =?us-ascii?Q?JdmE0/nmhPm/RK39DYmjSCt7/1YueibbGm83vER7/nRqZd65XLf6Q3MdM7ce?=
 =?us-ascii?Q?+nYVZXiOp7WT5GcxtkmTNWTeAcMCpIXWpTTstt5cMNhpgaHl9wSdJkd5GMHp?=
 =?us-ascii?Q?AwGoHJ+dYMJCskdJL3DpI2zy5Aombj95bynxZCSVVRFoP8lH2P1eCjmEivPk?=
 =?us-ascii?Q?hFxsWWBd/8kBOKy/A3O7sPVKxhXbOuQIQHWYhvhR13jk8uIK+4XVCrspU+tf?=
 =?us-ascii?Q?k4RVGQJgmdn0S06hHHifxykhMbpJdGfX5RgDR0fjvgvO9cmCi6p521GSiI6/?=
 =?us-ascii?Q?8EPmVcDYb/xfBmOMmDvLwNPmDb6KEZZ6ocqliYCSEfASX4CmRzpQPsNjpcoM?=
 =?us-ascii?Q?czQr5+9CL7UcCHWMdTLlP/npjiHAXEEUgs2rvWIUG/Np4rbGUig5cd0H67BF?=
 =?us-ascii?Q?w59owhW0RrxsfSX2E3YF4DwoW5G6D+TVY9bGIrmC6BXTnkQ3hEJHkboDxg9d?=
 =?us-ascii?Q?2KaqO+o/WYbAY2FEuYzaRG8A45w3ZUD3ermqxBpQ5OGVqMWEnwTKDKlwpekO?=
 =?us-ascii?Q?+aEjupQpdq8UzXCMo1TDSzXu08GDRzIv++L04mUYtTfe2OGfDVSQkJNgh/tL?=
 =?us-ascii?Q?DOF1M4gQDVcP2FzMPviDRuSYN+8HPnUX0DT5ulG5puPyuXgoGlHiZ0JSrE5k?=
 =?us-ascii?Q?yEUBNBLKwl0qfYT6YwZikhKI9ZLDzELRs2grqUOerMRD4uLkCsSaSCRrBcgN?=
 =?us-ascii?Q?LI0qoZEWnxLTdEac7o7YourP/AOAxnxBwkXUOSF5T0KwEbRmjLbsaKitWpj8?=
 =?us-ascii?Q?J3ajON8i6izugzs8as0+OZrMF9TO6sBjiYms/7mnYPoREXT7et7dFQR5KgO7?=
 =?us-ascii?Q?Gco/wtl5znp1NaNcC0H54xd/VkLgXVe/N6QyFqJIVixNspJj544psQYdo+oe?=
 =?us-ascii?Q?BU/eOq2IDW/4i1xIfC2/h+4q6x/SyyTfd1YaAyWUYr0cadL5cd43jMtuWZhI?=
 =?us-ascii?Q?0P0jWp4DLQyy4jlbVsEUAraj68LE8iumklIY4/7bsh0/+OBxrLg0g7Diuo9l?=
 =?us-ascii?Q?mrg0tD9oG10g3U/IzHMhLXX/DtP+e1yBxP0/gy9mgsQcTQcIKySSuLNAZCVg?=
 =?us-ascii?Q?zmInM+zNd6+54Ol/RIAw+81gboXSsAxP/CIwbAyFamgIOeBRpWFzgYBHzCcA?=
 =?us-ascii?Q?U3O4B1MnQ4uPeeIcsDkpxfpvy6F3SRUpTYdJndx7gW2qU2uLy46BKAMXMdlj?=
 =?us-ascii?Q?9Qm1G6G3WV5PxJRZhTIPSYA9j5lfU2/rvkLBsSPoTWsud+bERs+3WoVRHDbJ?=
 =?us-ascii?Q?S/G616FHNew6Er5vVJ0tipH7VZ1KxZWDfcn3w2eFLtftEzLrSkayUIyJXVvN?=
 =?us-ascii?Q?kCUvhZzvrXxTugXBDsO8vxiFBoL+EQLfbsuj8iGXnGEDT5zCZcyL0y9Q3PPz?=
 =?us-ascii?Q?nQY9Xt8EaWhfECDNmPjl+riCOxj5mCBKdl/tAVD9xOj/usES8uynaXzPObu5?=
 =?us-ascii?Q?MsH/bXb4081xtYOa7ZwXVPo21helOUEAxARTg6zbDsYi7oWHkB3yrKjKnXmn?=
 =?us-ascii?Q?PSIiw2rLfrpJPQI3FZ2+9VCRApQwuF+qu/Gps0jSafC5306Z6TpIsj7p3Zz7?=
 =?us-ascii?Q?9XAamGSihRzs0FXpK1DmAmNl8lSI4Qk6iBU/MCcdFEccOwf4nitLJhcpgBxo?=
 =?us-ascii?Q?bVkvuZGpyP9Y9UAE6HtaCXv9Zag/O8tU+PZDI7rJ1W13fe1NbhBZXfGZWIC8?=
 =?us-ascii?Q?YLv8WMkrpw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 969c4dd9-1588-47a0-ab3f-08deafa9f76b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 22:09:26.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKUYIoknRoQA5fDLVJOm/2MJurlgmZBOxdK5DJDfh21qdp5RFclvV48v/D/fNcY7wmSjogpk5XW9g7pi8Mr7Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965



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
> Subject: [PATCH 2/3] perf/arm_cspmu: nvidia: handle empty resource list i=
n
> PCIE-TGT init
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> When acpi_dev_get_memory_resources() returns success but the resource
> list is empty (rentry is NULL), addr_filter_reg remains NULL from
> devm_kzalloc. Since IS_ERR(NULL) is false, the function proceeds
> without error and later dereferences the NULL pointer in
> pcie_tgt_pmu_config_addr_filter().
>=20
> Set addr_filter_reg to ERR_PTR(-ENODEV) when the resource list is
> empty so the existing IS_ERR check catches it.
>=20
> Fixes: 3dd73022306b ("perf/arm_cspmu: nvidia: Add Tegra410 PCIE-TGT
> PMU")
> Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
> ---
>  drivers/perf/arm_cspmu/nvidia_cspmu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> index bac83e424d6dc..bae722e263e91 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -555,14 +555,16 @@ static int pcie_tgt_init_data(struct arm_cspmu
> *cspmu)
>=20
>         rentry =3D list_first_entry_or_null(
>                 &resource_list, struct resource_entry, node);
> -       if (rentry) {
> +       if (rentry)
>                 data->addr_filter_reg =3D devm_ioremap_resource(dev, rent=
ry->res);
> -               ret =3D 0;
> -       }
> +       else
> +               data->addr_filter_reg =3D ERR_PTR(-ENODEV);
>=20
>         if (IS_ERR(data->addr_filter_reg)) {
>                 dev_err(dev, "failed to get address filter resource\n");
>                 ret =3D PTR_ERR(data->addr_filter_reg);
> +       } else {

Thanks for fixing.
Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>


> +               ret =3D 0;
>         }
>=20
>         acpi_dev_free_resource_list(&resource_list);
> --
> 2.47.3

