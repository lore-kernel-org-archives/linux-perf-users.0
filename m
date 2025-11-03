Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4042C21F1;
	Mon,  3 Nov 2025 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206549; cv=fail; b=LmhDy4OU5Jt7HZlXSrthAQh8b8a73iKBSVhFrVCOKmsIOXoff+65lRONVopY3UHocqPXS1NaTtqx7adCfbCxGgoZvNW9R+ra3GOceJ955WgawaBNJGrU7Rnoy8/6PZ6VDBC3752MjmfU9Ammxz7JzyFXhozsv+5BZn/rKu94bSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206549; c=relaxed/simple;
	bh=TqMcqW+Kxz6E/IDdqx3tbGfcadJsWFZWwfFnfFLUkqc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rb2R5W4OaO3QrVn6HmWLxPGUt/jIlkVyGpkHAiWmh/iC9u0pvr7dECgQWF0M9hGBBNH+QT7Mx6GL4CsxxYooLltwl1BtHSfivAjVbaPCoicFDMV4KvGJ3+4eUMC0PRQtMAszkMHx6pNHx7GInoaKLMqKoOcrn+NF93QunZWWfQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IlIva+D7; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IlIva+D7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMe4wgOH8CxtBrR827q+T0E33ZkjIrPLG/KMekDSsp+HwO2q+LJkb42B6FwXupwolsl2aR49j0GScMo5AR+/5ADSsF7FOGYMRb9zLRsBVI657KEryj3jL9PwEO8ymYLhl3VWpUCQmLac4kV6q8C5LwGLrgXekZrcMAxXLxBzEg06LU7q8nPdpRC1UVC5UWXlS1WeWm/rcjP0r/SyK7OwIA9XHe5Qj2LcvTEbo9+brD2v5k4g3ND46eMvqXLXFQR6JvovzvUZKwlrTJJDboFmG+kzsgPsE2WyKDyTcOWiLMeGEW2lQY2qkOVHvRF7/mIaQ+TZCUAMCpRHhFljKrKGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzqdn7CrUP1/Ij9Q4ieLj3cGHYshb9divfuyKT3t8Ms=;
 b=uCOkhyF6WHgdFior2LojvIMjILpWjIOrg2hJ+fvkXFuOGue/8kBC7MQlLYEZ6irBKgXpPflXVu2vEsrQWP2Rv3cEGHpwkFLRLpdoa82C7FLdwJCCld39gW7uCvSjhefqmVwtKu1NGdwx4sD0e0K6BeR7qpB+6AGdxg6XFtVAgVtriRTsYdHxllb5cDWumlo6mUn+5xjqRSHgxWN5VphJqhkh1MKSInBQ3PIXP3M17d5Wy6iVJvt8O3X+FuVpxwP85OFeUvlkqxHedsC4gAO5paIcsLJwSJ4NGEAzjtwyGMLmSRkNmFRYQZs1qQ76i1GGR+kjwiaBiGDnpR7l0AgN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzqdn7CrUP1/Ij9Q4ieLj3cGHYshb9divfuyKT3t8Ms=;
 b=IlIva+D76ECl/ToVlGUfgc68dhdCuZUic1+gmOj39qTCYthCPl39VOTKW/emT+hIT2Z45D/PMdbzA65+J4+zpiCnahmjz5Z4xrdL4Z3KK21ciyA2ktbi7Wy91/7r/J+BkTW59tdSHo8sKGLk/VAgKhBfNjqVQj+Fps1PHCg8X8PAXSRlrt54OTejSO3epezeEObyn1B5MeEC+alurTBt68R8N0z8bkBUnnZrYOk3N+P1sWbFeug8pg6Y3FwTkUaEg7i0gPZeZqE0VmiRQRAa3faDdnCJBagMr289/o0YS2B1iTB1It8LiW7Q+cVGTU9nM6G0oHmxAUxkAC/gZVJ0yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 21:48:59 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 21:48:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 03 Nov 2025 16:48:30 -0500
Subject: [PATCH v3 3/6] perf/imx_ddr: Get and enable optional clks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-qm_dts-v3-3-2bfda8ee14c2@nxp.com>
References: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
In-Reply-To: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762206519; l=1320;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TqMcqW+Kxz6E/IDdqx3tbGfcadJsWFZWwfFnfFLUkqc=;
 b=HrCVpVPXfc+5CanROVM7Kf8aMFF92Rr2iYVK56cDYEw78R52IsRAbQmY+aZR8noHMxLgqdlVy
 fKxEVoSU8z+Bw37MYsQX1CYEDxvjcaNX/N+kc1NAdYVz+S2vYzQWWxM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB11503:EE_
X-MS-Office365-Filtering-Correlation-Id: fadcedb5-117d-44f2-bc09-08de1b22cb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHErUFlLQlNLUFpjV0c2SGVHOVV6MVlPTmxObkF0RkJ5YjV5SGJVT1E3anRF?=
 =?utf-8?B?VFlyNFNOVXFibnhxcDRZN1VhVmQrQ2xtMXM2T05wNytnZmFuWC9VdExhZkJs?=
 =?utf-8?B?a2paUXdLcW5ZNkN6aFZFTW81RHpNNFN5YWxPT3hlMEVQN1FGdWZtUnBKUWhj?=
 =?utf-8?B?bHpsdGo3NUdSNDBCLzkvbm1VQ29qYmtVMG9DMlpoQnhPdU1ua2N1bUtVMEgr?=
 =?utf-8?B?UDNxcHVxalg4cFB5K1lSQWl1ZzNIKzI1NDR2R01lUkhSb3JnWW1UNXF0RU5Z?=
 =?utf-8?B?SGFrWmJYTXRCMHd4YVA0d0pXdmFMQm1OV1BoZkdyTFVrT0lVREs4am1mU1pk?=
 =?utf-8?B?cDhHWDIyVWFZNVJVaDFMeUxvSW85SGE4dHlBTHpWaTZsR0hpZFVLYWJKTDFB?=
 =?utf-8?B?bmJ3cVFDTGd5OUtsZko5akZBWnhDT2s1d0dmeEFWSkd2c0RsYWhmOGk1Zzdw?=
 =?utf-8?B?TnpiUisxUi9OaDVBOWxhdGJrWnZSWWVmdUxYcmRoQUFwWFE0dm9oYU1DcmRp?=
 =?utf-8?B?aUs5aUUwNTdEVFpZOFlTWUo1WGk4SDFaOWRmUHVlWkRSaFpHVmVHb2hMbjdv?=
 =?utf-8?B?VVhNT01KQXovYXB4V2cwRGc1b2V1c0FBeW9VYUpTOGowSWptRkp2UGs1SnIr?=
 =?utf-8?B?ZnFucU55dEtPWWhUSHpWNVFwSjR6cFRPWVBUTzBZS1RidEpTQmY3QnNVYjdh?=
 =?utf-8?B?RWhSaytyUk5wQUtXandjNjJlcGRsR3hDRGw1a1RZeFZUVnJiMGs2dTY4Vnc3?=
 =?utf-8?B?a1hZM1FycUhzYzBBbi9oNG9kY2o0cktNV282MnlMODQyeE9mZHo1N1RNS2E5?=
 =?utf-8?B?T2VsMHRQTS84YTN2dFBVaUpmRGp1UVhmZnlQaTB0V2lCVG45d2RBY3ViQjBM?=
 =?utf-8?B?R1hnVnRuMVVqREs2WVczWWJJbTQvUVFXZFlmbm9OcjlaQjd4emYzNHFWL0Z6?=
 =?utf-8?B?ZlZoTHdzdmdXUGxyRzlCdEI1bCtmRndlWHNHZ2EvaXZacW8zaU5jOEg4c2Fk?=
 =?utf-8?B?cGhLbWpGL3gvTDV2d21aSlNwMXZpWDlDQjVvZ0E2cWppNU1PeXNGVzNKQWhW?=
 =?utf-8?B?TnZBbDNJOGQvQ2pWeGJmWDFlOCtsaEt5NW9ZQkFPdTNpSEZiNTREempVZUNs?=
 =?utf-8?B?dmNCbDE0eUQzN2k2dExmMWJ5TE9JMTl0bkFXdU1Cakp3V3o2VjdqUGtCNnJj?=
 =?utf-8?B?cVlic3VjRVErMlhQdDZ5Y2JVQVhFMU1Xalg4YUlIbFpXS2tuSGdBdmJ2RWds?=
 =?utf-8?B?N29mRFptRXJlSjZhR1BlTkNSYTRjekJXZXNNZ1lUdU5nUjlDQnU2VEQzOGFY?=
 =?utf-8?B?aWY5V3pWSDlmMERpR0Z0bWtwQ1FXb3U1cUNKZHdoTXZzV2c3dlBLVXowQlhV?=
 =?utf-8?B?M0F1TXY4eEZPcmQwb0FvUlViamZ1VFR1WFdyZU5iVm13NGN3SWY2TXcxOGZM?=
 =?utf-8?B?bW5JL3c5ajRleXdPTWVBbXpJazJzaUdmL2xTVHNZUFQxQnJVcjBnU29xT3M4?=
 =?utf-8?B?VFY2alhiOVU4MWFkRWlCdENka0R1VCt3TTBkaXFBZ3ZWL3pzQytad2ZCUGNF?=
 =?utf-8?B?aVp0T1lITklwWjNPMDlzWFNESGRGbU1ickw1Z1IwZ3BDdTlWYW5FeDR3dmlm?=
 =?utf-8?B?bFhuSHp2M3NQVWIvbHR6bnVlQ3lEYno3YW1CT1NKbkRqWXF4NUJLOGZ4a1E1?=
 =?utf-8?B?WjBqbm1TbEZFTDZkeHhlQ2QrUmJtTkhoL1puamtBZCtpSENhVWVtT3VSRTNZ?=
 =?utf-8?B?eElZNmVjRHFCYkJ5ait5a1JZUlRZVCtwejVBSFlSRHZuSExJSjhVcDNRbFRn?=
 =?utf-8?B?dUUrdCt2RS9XRk9QUzJ4TjZrZEZvTTZLNzV5d1NMeWQyblNmbjhLb05GT2Na?=
 =?utf-8?B?V2VuMDh4K3g1cThmM3kyTlVqckJnZHh0RlBEeTlJTlVSU21USHpiMWUvTmZa?=
 =?utf-8?B?cUhWZ3dxbEhBTGY0ZExYZW84cUdudTRpVElDb1pvbXhrVzhmUlh3bnJ1d1pO?=
 =?utf-8?B?Zzk3RHBIbyt5bFBPWlBPY2RxVnR1VmdJQThiaFM1TlpLN0xlS2E5RGdQUlZs?=
 =?utf-8?B?bG5aTnBrMm1tSXRCQlh6azNLcWVadVNYcU96Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cldmTVdaRFdNTWc1QjllRDl2SmJkQVRFUlR2VzJNUmdFWDBwdm1rRGpkYjFH?=
 =?utf-8?B?dTh3VnM0SnArVHQ1R0h1VHpITGhRcGZZRkdscmVBL0R1Qms5VC9IS0luSm82?=
 =?utf-8?B?U0JUZ20vK1ExNUlCWVFOSHpCcTQvWXNGajNpZTB3a2dyNHZpWGthdE1ZaWVF?=
 =?utf-8?B?RUpaNEszSlRtMzlKSlZYdkg3TU8xQkpHQzVUUTVVdlRtcHZhQ0VESFppbE8v?=
 =?utf-8?B?cVREa05SM3JJUEQ2T1A4VjAvZlFBMGVudURlK0R0aS95Wlh1YkVNL0lndTZI?=
 =?utf-8?B?VDhkZWtFU1dJclJ0dVl5WndONFpnWnZVUWJtTXZGMnUvRGpwNndpcWoxNXR6?=
 =?utf-8?B?Q3gzcFpoblhTZFI2aG5ya2RxakQzWUNJcTFzejluMnZZV0diY1lKQnRYc002?=
 =?utf-8?B?VTEvSGlBTTRSMnRxbVArRVJvellDN0c2c0RHcUYvMHZTVGZJTVRxVXVzQjVE?=
 =?utf-8?B?ZzVUSlgrcE9XTFp5UnUzZjRCUnlrdDZ5dkxIYzFOTnk3VUV4amFSZzhZZFJk?=
 =?utf-8?B?elozam0xLy95N3hHZ2Z1YUVrRkVwVzRndkN3dXlZbjlRaWNEZU5nNDRzR3Ay?=
 =?utf-8?B?YW9zcVBOVnczbnc3TXJoUUJ1ZDMzK2FnLzdsaUdTVDhlek9CK2hiUWRaYlhV?=
 =?utf-8?B?dm1OcTUrUUc4UzVLV0ZGYTlkdGlhSU41RUNMZnhheFVkdmtqQzlBZWMxZUpi?=
 =?utf-8?B?SU1lT3loN1ptTTNSSkRnMzVUN3QwaEhNL0daRjNydGxrRlFOMWFNdEtVRU1U?=
 =?utf-8?B?YUtZK2JIL1hCTTVmYWxLUW1ZbVJoOGUvSzd4eGZGZWJFYklrb3lZekpyem52?=
 =?utf-8?B?cDl4dWQyUGZLMnBESjF0bThQMVM1K3JjRXg2N0RTTkZMYUZXY2J2WUQ2V092?=
 =?utf-8?B?VjdqZ3ljVlZCakJIcnE3Q29xN0I0MlBXby8vbFdOb2JjaEFSNXZnbXZmdnBG?=
 =?utf-8?B?QUJvdGFOQWRzMm1rKzVXNW84SmFkYXJlWEdrenJkcGJLNlJQcUplaitHUGdq?=
 =?utf-8?B?c1NkeXlHbGlPU2w3ZFVBck9JWnQwSG5ZclpER3luaDVhYjJLdTJEd0ZUZ2kr?=
 =?utf-8?B?eGpzZ21IZXE5U2tTem1iZDU5emJ3R0tweHAxR2V5U0NwT2I5aE5GbjVIdzVn?=
 =?utf-8?B?clRMUmNpMG94MzVnd29XMHpGa1NhQ0JTRUxDL0d6cWxibXBsck14YkltT25x?=
 =?utf-8?B?YllEVUtKakV2NEJXVDZvbWlkWWFlZ0JQaVpTVStuclRqbGhUK25HVHd1OVhD?=
 =?utf-8?B?Zk9UY2Jld3lYTkowN2xFYzhwNDF3Ni91OFdkNDZPNDl3L1Uza0xtL2Z6aHRk?=
 =?utf-8?B?Qk9XV0Q2UU1FMXVMeks2eTlnakJPZnNYM3JkVURkQ2tnaCtPcmNsUzBOYTBX?=
 =?utf-8?B?NWdSQ21ldnNmek9HeDJBNzRLaUhPUGFCcm84Z0pYODhSSTNLcWRub0g0Vlc3?=
 =?utf-8?B?MXRUNVU1dERhY0F3NkVtNTl6VXZrLy9tTGdxWkJ1YTVMTGdHUVhoWlZWWVFC?=
 =?utf-8?B?Y0RHM2lrRGZnNjNOVy9WT2dpUWMzdDhFdFlwNzBzeVdvdUtGT3V5SWFEaXVu?=
 =?utf-8?B?c0tiNllaaDd0akhtWnl4bTlVV0dHOWlyMGt1T2dOQzdBdEJ2dTh6bUhYMUsv?=
 =?utf-8?B?cGZvZ0Y5NkVWQVl6NkNCK0hOT0lCaHNKL3YzeHNYQUsvWklKYWZwcm92YkM3?=
 =?utf-8?B?TEFUSmlST0VPbFJuZ0ZBUnJvUG0ydHp5MlZZeGE2NmRrd2ZCUHZGeTByOW5x?=
 =?utf-8?B?OCtiOHJtTzFUZGxzRkEvdTRES3l1SVcxakZmSUNWdUlxZFpMQ0FRYlBzVm9I?=
 =?utf-8?B?Q2RCNUZGdE5lNklmTTROZ2lMRitkRVhPNHdnWHVONk14TFkrSmQ4UUNEZHZR?=
 =?utf-8?B?b2hHNkVoNmFMVExleEg5TWdDckFGYmoycmNNTlJwS0o3aTlUcDc2WDlzWDgy?=
 =?utf-8?B?dGx1bDRnTVhENzBZR2xsY3JPYzZiTzhnTldLUFd6bmppOWhtOGpncklkc3Fw?=
 =?utf-8?B?OTU5NHNicXJ6UkFmanpDTUFiRHZ4ZFo0UGxjOEFBbDFmb2ZBUzdoNE5kcXp3?=
 =?utf-8?B?V1dlbElKVTJua0Yxa09Mbzk4WEpSTnE1QmZFekc3M0hWRXJlYWNKaFl4MFd5?=
 =?utf-8?Q?w1Fw2IXz1PpeSu/QMEnh8eBdM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadcedb5-117d-44f2-bc09-08de1b22cb77
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 21:48:59.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAmEhN0/iOayae+ytLrFKlNhO6BHPHNSz3Ahgk1nf23sT136pBvrIjulz4YNDZSoN1WAP9FFMg4R6NTTwJozPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503

Get and enable optional clks because fsl,imx8dxl-db-pmu have two clocks.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 5ba34c606213d255edf27081bb9f63763cca3066..2a8426a74af98cf46725c2c70534829e198746f3 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -732,10 +733,12 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 static int ddr_perf_probe(struct platform_device *pdev)
 {
+	struct clk_bulk_data *clks;
 	struct ddr_pmu *pmu;
 	struct device_node *np;
 	void __iomem *base;
 	char *name;
+	int nclks;
 	int num;
 	int ret;
 	int irq;
@@ -754,6 +757,10 @@ static int ddr_perf_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pmu);
 
+	nclks = devm_clk_bulk_get_all_enabled(&pdev->dev, &clks);
+	if (nclks < 0)
+		return dev_err_probe(&pdev->dev, nclks, "Failure get clks\n");
+
 	num = ida_alloc(&ddr_ida, GFP_KERNEL);
 	if (num < 0)
 		return num;

-- 
2.34.1

