Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA534DB54;
	Thu, 23 Oct 2025 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245851; cv=fail; b=prylsZkEBvTH74nHIN3DOJNTGGTHcRbrmTs4VWyW+aGre/b85NA89SSeULoiyjQYj8QrwxcK4rcmCzyaIYk3V9I+bvB5XdAxVEyhPl+V+H+bxfyAFM0UvmxtA6cidv8csA6qY6v4HgeiMiVVClVUdCGOjssaYP4KEw0u/983Mcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245851; c=relaxed/simple;
	bh=lL3PHbQB9BliLrPOwqyoxNzEa2Xr3lLa2ZMWIrSgXbo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bAZjUHe6ODbNZ+FJIEX/VnkST5vkDv180unJJgMRkMKGGEa+FuHahdzwMXg4d2/5NIT99Tbnzb2EaKSjlqTTgxYP2Poj24Axbet/jsXaqF/6QaoL+tW7TyJ5qvRL0l6Hu6RLf6XMlKHqvOmdw26PqB4fq674qA63NkdkjgSceN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K8qVbXOz; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K8qVbXOz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caZo4hgwsM9C4SmPCyFqcdg3Qb6di8x+kevnTyqJMadb4QeLTzWvgKgP4I7O2mZwiYXu4Dv2dxEiB314OztrLjx3A0V/a7g3oqlbpMawrpzHIMiLtHNaU5p8+L4fps4ORoSlm8A76GzAcdOwCjGYf+pG2Y6ipqunkowgcbVb2BLkSeFJxjGwp77kaWe+eW1IeeaiEeQ8+fKDm4vGtaetu9AU1RIjC5l/2FRsIA82VCxjj3cX9juQEKV3rKKGnHvcHGOmXASA/LMSyuc4Elx1wgYP8WIb2OLb28ZIWfcZjFVlGBW4z88PywJ2HiCZxOYZG0Y80O2nxSr5QeN80RQ1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgowNT4jGBUzcmPNcJ06gqG0j872POtXYzkSObd50OY=;
 b=ACIyEldKOHnubxn+FQLJ6ICJ2iJFjrEoRen+6yPuBQ5VoO7j6+pEantEfhBhBtN9tdnPGmgEGY1sR4z9WPZOQa+MC1qDPRFodBiYL8n3dSWtrpTVCrdV9v2GlSMcdFgEJ+enNY6Il92AcS4FeG8j++fMsUheyWzAKft42DJT20oPW8hEXpWk9iFz74AsA9MzR7aHkvJ+WwJLWIjFym6O3Q7aJI4fQrXvSCdKlLpeOjFkyDM22UJ2Pkb1Rs7+CPIPuugWv7qX8keNoGWEMNSAiDpnJ52Bb2MY+rMSXB9ZylGHBT5IHwizHtPtxXEEZBdQOz4zZR5ep8qPxnRwJ0CgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgowNT4jGBUzcmPNcJ06gqG0j872POtXYzkSObd50OY=;
 b=K8qVbXOzcTqUb1HeIxagMewkH1S2wPdXHUKqagPtpDcaKdlJcBJo+GsF7cjNViTFQgVvKzV3183eF5E0wJIlZDmpKlIshG1NA2yOOIIK4j6BEkmINDOdXHq8IL4v5yLonOo1Pu6R/JDBmcAxAvMP326VBvW9ifEdjSfHPUzJ3MM6hXIj7zYxaaq9Z7wnkkgAM/lQMwD1qKRgVl36rFVjtHzEiWxuxMHTZ/+VVWVsVX+GXip3INuVVqAXYJVq5tx7xGk99ot09jyzTqtOq5aAGg90fsPv/J940h5vRCj8guGccgnyf8uexV0GpUwQoc3CkN+hXZrQdGOr2wbG1vfwQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Thu, 23 Oct
 2025 18:57:26 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:57:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 23 Oct 2025 14:56:45 -0400
Subject: [PATCH 5/6] arm64: dts: imx8qm: add ddr perf device node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-qm_dts-v1-5-9830d6a45939@nxp.com>
References: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
In-Reply-To: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
To: Frank Li <Frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761245815; l=2726;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lL3PHbQB9BliLrPOwqyoxNzEa2Xr3lLa2ZMWIrSgXbo=;
 b=EUcCOsaO4WPOAC+ADdRReC4DlzM8i9nV3XrBYK41bp1NDlSQpk9az3Gdc6pe34Q36fsA/BVdz
 4lyJsVuKQk5ARQ7cCpSDU/za4DSYA45JjFgguzgn/7Gokgs4ZByyeoj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB10443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdf61e1-5f98-4da1-9c46-08de12660196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVRNemhHaXRBMFVzSEt2d1gzVkhucVdIZCtZVmNFWFNoQU8wbzROQndvRGRl?=
 =?utf-8?B?WlliN0FaRkhHWjZKaUlkdGVnbDNoL3ZtOW1SNG5pckRuQ0J5cFQzay9mekR3?=
 =?utf-8?B?bEVRVEtraTJtVEhRWkV6QmE3WW15U3ZnYXZHcWxqemdHRUhYTlZCbnNaUCth?=
 =?utf-8?B?MEwvNjUrdTVpT0ZGdXZpc0FnL0pCOFo0cWZOUnpJZFRxNFExVk9sRVRKS3ZP?=
 =?utf-8?B?ZGJiRFF0THZNNWo1V1d6bEt2NVIyN003aEpkWDFmc0toY3NNYi9JbWtmTTJH?=
 =?utf-8?B?NENCS0lsSkJkaHN1UkxTemVvdlVOVTE2aG51WTY4V3IwOHQyYVZFVWlEL2Nt?=
 =?utf-8?B?VFlxLzZoemtETGpjcEdpeEFZb2Y4YnFXU1d5VS9yZzFhaGlZdzh3emhkNkZP?=
 =?utf-8?B?aHBHM0Rxai94aHVNSjhwZFpWWWVreWhHNmpnWjBVNC9YY212K1VVYThJZ3Ay?=
 =?utf-8?B?bWw3ai9BMXh6WStUVzBFdVIvcEpPWnYxeFcwUHJQV1k1VExzWWJWQlBNK1dG?=
 =?utf-8?B?a3dSQXcwVGRYSXdWT0dML1NlcS8zNmhQT3hHUzhaazBkT1FpaG9sT1k1Q3dI?=
 =?utf-8?B?SkZPVWt4MUVtQ01uR2JHR3RHY05KK3FzejlZUWwyajlLTFVqU3dXZ0tnR29o?=
 =?utf-8?B?Mi9nd2VHWVh4UW9wOG1UZG5xWVd0WWNwWkpkZU9ROTVmbFFjNTg0UFJCYldE?=
 =?utf-8?B?MGZUbU51MXQvVDBicU9sSi9xS0hGK25rTlJJRC9lbmhobnhsSzM2ZE5sc3BK?=
 =?utf-8?B?Zk9IM1RlZHluMk1HMmV5V3hzQm9oVVlyZUNjOGpvK2NJdWp2dWkrTUdoS3lw?=
 =?utf-8?B?dGdKcFhIc2t6QStyUWxqQ282NFFTT2tJWWZHWUNIM2oyL0JQUGlQeVFjeml4?=
 =?utf-8?B?ZzJKOFErM1ZqalJFR29QSVdTNEp4eFFIN2RuWkFkcU1namppek15Wm92Q1FR?=
 =?utf-8?B?ZTM2OVRoOHJNWWpma0NiWlU0NmFtMHpXYVVSVGNldW1BMEFsb2pic1ROUGU3?=
 =?utf-8?B?YzMwRmd5Wk42U09mVDRLSnpWM2xkZnB2VXlSVGxiVG5lMjROaHo5QXRCTG1i?=
 =?utf-8?B?T2I4VWRZZEZ6dS9TY1ZwQWFhbDBQWHJYUUthY3ZnRHcyemFJN3dSdzBQczhQ?=
 =?utf-8?B?SnhIWGUvUG1jdmMrVjlDbnBVbDNCQ1J5elJSTkE1Vi9FY1JqdTd4TE05UElR?=
 =?utf-8?B?M2tnclVlTWZUakVQREFSU1phbzltK0ZRSm8vUjhzaFRkdzJhcXhOQ3piS1Zs?=
 =?utf-8?B?bXBXa3FFNGVwYWNlNVN5dXp6SThrQmRRdlc4WmdCN3Jsc2h4NDh4bHNCdUFW?=
 =?utf-8?B?RVdrSjIxQ3hHOU5XTks2R1NUdFJsQjYzOUtTMncrUnRCcGtNTUtqU3huNW8v?=
 =?utf-8?B?MW9waXJHMk1UOENRbEFWU2wzMHJtUy9zNmdQY1RwME5KU0N4OWp0ME1ZUkEr?=
 =?utf-8?B?SkZjWFBOc2gvTjc5WTVHZWxHSnF3aG5rL0NwMnovaVJZeXE5ZGZPeTZmYjdt?=
 =?utf-8?B?Ny9qOE01VUprUXdVcnk4TmROZU1mS3NWZi82ZmpWUGhVY1E5Wjl2OTFJK0RI?=
 =?utf-8?B?SmtqMERQemFuVEtiMWV5ZE0wYnAwYVRVaVM4Q2tGUnpkWVF0SmwvSnNobytv?=
 =?utf-8?B?UmJEUEFneXcrc0J4TGpQTVRRempyTlhLU3dkUmpuNVlQVFpPY2E3Nm9jTEo4?=
 =?utf-8?B?RWtzWHNUaGh0RVNjdlhReE1jNy93K0l0UURYakZoM3IxSXNJRjdrck10VU9l?=
 =?utf-8?B?eVA0em1PNEZrMUMxZDMwWDh6STQ4bXZlYlJkUzg3Vk9rV1NuYnlWckRrVnho?=
 =?utf-8?B?di85TlhHOFlzVHY5cXNUUnhySFpZZFZpYnRWRUN4Rk4xdWtURWZWcjVFUU5T?=
 =?utf-8?B?M3ZMTkxoOGZYcCtnY1Vka1ZFSG1FRWIrUEJBdkozbGt0M2RZOUU1VytIc3d3?=
 =?utf-8?B?eVR1cHlwRHVBQVZvNDl1a3l0OS84Vy9kaGdVVm9QektKL0JJRnJPK3VLWnpZ?=
 =?utf-8?B?eE9NWnZRWnkxWFUwem5yTHJ2NmppaUp1UDFwZllGYnhBMGc3L3UwdkxMTkZU?=
 =?utf-8?B?Y1d1OWNaVjYxNHAzc29qc2RRazhjZmxXRHZVZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0JpNk9naG80d3FaTVYzWHJCalhaMjVXSGkzYVlqYnltTHBDQVE4SUV2SFlK?=
 =?utf-8?B?TnlLRENZQStFRkVyblVkWUdBTUJzM1VHTTFtbjNDM2tjS3Boa2hFaDRyK0Rh?=
 =?utf-8?B?Mm9KcFliN0grVDE3WFhKUjF4V3d2QXIvUUVHb0R1UmI0WnhuSWtUQTNWemJv?=
 =?utf-8?B?RE90Y3FKZDdVMmt5NkF4M0xhYjR5MWNLdEZFODZURmJ2OG5XSTlaVHl3aW5G?=
 =?utf-8?B?ODkzczZ3aEMzWGJDVmt2RkNDaW14L2I5M3I2M3Q3bEFScHcxVld0bXJ0QXdp?=
 =?utf-8?B?UnNXZHV3U2xjOTdrY1o5ZWVGTTlzb3orNk9FcEdkMDNxMVFEVEUrNXFmTjVF?=
 =?utf-8?B?bTNjeVZZTXpXdytENWk2L2JFaGhOMldZUlJwSjFoNFlONitONlF5dFZWWGlz?=
 =?utf-8?B?TnEvQkNuS3F2VUtJdjczZWpDcDE3UCttTGxWdWdXVGFLa3dRSThCaTAzemFH?=
 =?utf-8?B?ckpiZWNzaHNFVVdsRG9ZeE0vdndiKzlKbFpmcmd2RTJxNmk1VmlLQ0U5M21D?=
 =?utf-8?B?R0Q2UU9qekJTTC8xaS9qOTlGbHBaa09KRUxxZjVDOU1uTzdOdkN3MzFIZnJk?=
 =?utf-8?B?UmpqNmE5dmFtL01HMTNpVFNTcmFNZG1ickRFTHArKzd4S2c5TFJYaWpNUUJZ?=
 =?utf-8?B?M3hHUGZJUlJ1eFNCcU5zU2pUNVpuc0xSWFdIUTloeVZKNzZKS3R2eXFWUUZB?=
 =?utf-8?B?MXpsbVRMMXk2aWpVeWExQldha2l6bi9xMW1lODNuNm5UZXpYMkxldlBrYTlJ?=
 =?utf-8?B?ejI4WmphQkRGeUF3Zm1GNVF5QzFnb09GNVJRZjNWRVZsZzBKaExKc2xNRHJj?=
 =?utf-8?B?M2FVZ2FlbStuN0k5Um9qNjN3dDJ2UURyRWg2cWtlcTk1dExWc0VYVitNd21X?=
 =?utf-8?B?MGUzTWZTR3BrZ1E5UWtEbXV6a3F0cnR2K250MVA5aGFvU0gxb0dpdU9vaXpP?=
 =?utf-8?B?cXNQVWx4NnlseTdBc3VlWlU1ODlaR0FVblY2S0NqcFlBMW5GS3BoRkJwNncy?=
 =?utf-8?B?K1RJcHUrdUVNK2J3ZVRWYmkzL2R0SzRWY2V1dUlBYWhyQUlrSlhoYkhSNXpw?=
 =?utf-8?B?eDA3d0ZNRjl2dGZJMWtQZk5SQW5jV1gvaEdQaGp5NXF2REJadWQ4TVVCM1Ur?=
 =?utf-8?B?QjNUTTZIdjZRaGd2UG9mZUxWbnQxRHdobmlpR1VTNi9HRmkzWXd0azZEQ2h6?=
 =?utf-8?B?Zi93Tm95WnpmaG5pM3hwSy94d3F0SGp0c3Jhb09PNGZoSXoxRkhLdmhYT2xK?=
 =?utf-8?B?N1cxMU0rYXRlNXRGMWpQTmdaN00xcGZCM2dGN0NZeWpHeTQ3TEt1RnR0alRh?=
 =?utf-8?B?bDQ1WWZkR3kvVk1OZjU3VC9BV3BsZUh0RXFXOGFSTlhLYWQwbnMyUnJzNE5a?=
 =?utf-8?B?WkR5MUltOGorNEwxT0M2ZmFhTFhTZldYeUtoQTQ1Qm1nTVo0STh5RC9qT0lr?=
 =?utf-8?B?QUlJZ0ZNOUhXZStZL2kzV1FDVWFVa2hDL0VRM1pvKzU1ait1d01RcFNodUpV?=
 =?utf-8?B?aDc3Vm9wZFZCTi96OXpDWGJjZmVTYTZKdWtPaldYVFRBWHhQSnplNnU2Y1pr?=
 =?utf-8?B?dS9lSHBHQTBIU1pXSVJuL3RFOWI0REJSUVZvY2s3L0o0NTIweTZlZ3hkc1Fk?=
 =?utf-8?B?TWNwbGlMZHB6Y0NqMS9kbUNrejRiNyt6UUpldmd0M0MvWTd0V09pYlZlc3Uw?=
 =?utf-8?B?TEdTbFV0RXN0K3NrOWdwUXcwTFJlZDZsL2RGaVNCOUxnRWp5RjFWc3ppZ3Yz?=
 =?utf-8?B?RlRlTkhEUWdEYmt1dlBJcmczTEhOM0F4VkVCdkJvdmo0VS9na2RzWlcvVXVn?=
 =?utf-8?B?bjBTMVhCaFptTmlrZ1k4amp1QUROQjdMekNxd01wM1VqUlcrVVRzWGNXaGxX?=
 =?utf-8?B?TWdDRzNpS2tBT0N4ejZ0SGNHaXptRWxvSHdCVUtPMVl0ejVqUDh2bDIrYkxa?=
 =?utf-8?B?NTRQSnNxTm9YOCtkdGNzeVRPTWhiSElVNkJ3L01ZOEh4bUw5ZXBDdHNHMkt4?=
 =?utf-8?B?c0ZZKzRVcWZvd2ozNjE1Q0VnRGJSSk1pSzFMZk9zZitFTmJhS0pvZTVmeVJm?=
 =?utf-8?B?cDdOcU8zSjlwSFRLT200dE82QTJJdmluYzJabk8zZE1RR0N0QTJEaEVLc3NS?=
 =?utf-8?Q?4mlRwCGZlf0ecBWosucrSIlCe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdf61e1-5f98-4da1-9c46-08de12660196
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:57:26.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sSY7A/EMzQWLXDSZAxcwq/kZ7wgpchQUItp8ChF/bIcAF2N8PJMh740LlhvYVxg3K0K2IQxW1EtCL1rxFuYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

Add ddr perf monitor device node for i.MX8QM. Change imx8-ss-ddr.dtsi's
compatible string to fsl,imx8qxp-ddr-pmu. i.MX8QM overwrite to
fsl,imx8qm-ddr-pmu. All fallback to fsl,imx8-ddr-pmu.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi   |  2 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi | 19 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi        |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
index 7d5183c6c5bef9b57f2ff92c5184272e43054a03..37e68865b026deb73ffb6a52207f5c05a0dbf5fb 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
@@ -11,7 +11,7 @@ ddr_subsys: bus@5c000000 {
 	ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
 
 	ddr_pmu0: ddr-pmu@5c020000 {
-		compatible = "fsl,imx8-ddr-pmu";
+		compatible = "fsl,imx8qxp-ddr-pmu", "fsl,imx8-ddr-pmu";
 		reg = <0x5c020000 0x10000>;
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..c831567cfbc1f2df7e3642c1f0ff080551462543
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&ddr_pmu0 {
+	compatible = "fsl,imx8qm-ddr-pmu", "fsl,imx8-ddr-pmu";
+	interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&ddr_subsys {
+	ddr_pmu1: ddr-pmu@5c120000 {
+		compatible = "fsl,imx8qm-ddr-pmu", "fsl,imx8-ddr-pmu";
+		reg = <0x5c120000 0x10000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 5206ca82eaf642a32299147e9c1b45704075e2b2..9ff0d56fe97078cabafb66db95b4ea82f95ebec2 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -635,6 +635,7 @@ vpu_dsp: dsp@556e8000 {
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
+	#include "imx8-ss-ddr.dtsi"
 	#include "imx8-ss-lsio.dtsi"
 	#include "imx8-ss-hsio.dtsi"
 };
@@ -647,5 +648,6 @@ vpu_dsp: dsp@556e8000 {
 #include "imx8qm-ss-lvds.dtsi"
 #include "imx8qm-ss-mipi.dtsi"
 #include "imx8qm-ss-hsio.dtsi"
+#include "imx8qm-ss-ddr.dtsi"
 
 /delete-node/ &dsp;

-- 
2.34.1

