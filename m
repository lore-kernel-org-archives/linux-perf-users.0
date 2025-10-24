Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3C242D67;
	Fri, 24 Oct 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329856; cv=fail; b=YxIZlDs4NfuUccROlBe54Omc6fvP04Odyvw8JB+bkQSs22n1WB8ZEhseFNqQyW9JdSac4z27JL3g+4YoAOKKMVkWpo26+F2MKfEKuWm1UGNftS5yBFiuc/JmJSBsp6QaMb/q6e5uDTP7iGP78ZeQAC5DVtxoSkChUv/719AEeIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329856; c=relaxed/simple;
	bh=DzMA3UaZE7MMc9k9ziaEASK4a4CARKa9pEIiDzS+1ho=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kA4llKDBlBpLmegK0sgHQ4bS3rpdGF6zJkFA1X4Q3fdxqguI5QHZjhl6kFFbDKGeiVh/ar00WN1+mxL/kXGjVxf6ZwmUvgV3czgwcdRpxXX6vt+Xpt2O7BBEZWRO47/45zKIlKnizRIXbvsOoXX4SBrLcpcQvhLYy2WBMNTKutw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZwC/kJRk; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZwC/kJRk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veNCrI3PIGcikw5w12LtGeSNXGooIPdwF1oqQ6nFquW76HnplTwObnWxZodXvSwqrgJN52ru1ujyqqr5gr25G+33hfvr+Nq/4XI6cNGY5tnAo9Kr/Ret4hdEW08RsZqM6PzUJ42VDJI6cDhHWvnOzrj939mWChT8a9AnQv/ThC3GehMdmKHGjuc3D59+vdUQAtWA5Gp1SXVm4lETAk3lrXmj5dzWdksFmrMN4RBJURSq1PvqhYTmcPJueBiQDrinz+eeiglgGAYPYoszlQfpeWdJJf9XQUn3uuRW2QU4I4F5iR/iX+Ecjuab5anrWMLuCZhja0YEO2Waw7y+BTKcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQC2WI9RIFvGyP53VpPEUVjZkap68ACowkD3tQvLGKs=;
 b=V5X3UZI5g8My0IIQ70dWjZxB9wkUS2ax2KJ2uVtlU92WenPtJOWW8RI7qiCEhCfBDVcJS1ok/NYD/zioG1V6fMBNFse+x2iSjU1mC19jif8QFgffROrWpjPQgp+rhgRWHkyoNZWeA2ZY3qOcbUd5bd7OMZo1JkaLO5i/G85HxW9bEbic0qtvMFbIrvF9qqU1+5+Yjml0/0Ug2DswSinAFC/6NDPveP2Mz26mnKUQKPh8b3ww6iYdYKRwat1lqn5TC3hSJEf2HzXyOld1iB4ImofyrZ2DrbHdflLqAld/kQaYH46nPAQiOsurLsc7BiDCGcLdXs/29WJkQWCv18e/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQC2WI9RIFvGyP53VpPEUVjZkap68ACowkD3tQvLGKs=;
 b=ZwC/kJRkU5M/bgSna5B/wmVdj4twfRrQhAnALEx/p0lknCSiMeTCpFQnQKjNSdGcpPAxpJ5NnUxwoIpJX0tm6kzTjji0iz/I+JPWp7hbqlE+00FS4SWUhZOIZJVDyWjuIBOmzBHUqxqhSPo8WALsMDWh+B0dZbyfA9wpvfaPYn3emKoC2s3ju3BuCRafwspQ7lwB4hJ17eSei+6I/rpWTVOSjBAY5fFekLa8FX0+9x5fVMC87kx2CA3fXHEFq8GcWQI4QDtN3CQLUv1jWHr7cZXyb894lkKCXhXZS1FnVbXp2iwW0eHaI22sW2Jv9r/87Iwed0PAvuzw6HXMVGnoHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:17:29 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:17:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/6] perf/imx_ddr: Add i.MX8QM and pmu in DB (system
 interconnects)
Date: Fri, 24 Oct 2025 14:17:10 -0400
Message-Id: <20251024-qm_dts-v2-0-7a7e07022ed6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKbC+2gC/zXMSwqDMBSF4a3IHTclD2NNR91HkSImrXdgookEi
 2TvvRUc/ofDt0NyEV2Ce7VDdBkTBk8hLxUMY+8/jqGlBsmlFlxKtkwvuybWcFHrlkZ1s0DnObo
 3bgf07KhHTGuI38PN4r+ehDqJLBhnplXcNn2tjTIPv83XIUzQlVJ+md32i5oAAAA=
X-Change-ID: 20251022-qm_dts-60145802537d
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
 Frank Li <Frank.Li@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761329844; l=1667;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DzMA3UaZE7MMc9k9ziaEASK4a4CARKa9pEIiDzS+1ho=;
 b=HVyoNIruzyD7BEDFhsphDSa5EB3V+lKkiuE42Os162AAQle9QYJwuO3z0e89JqAn3zFy1Tv5m
 top5BYwdHyOBrfBNTasypt1nXPADfSgfpX9UIVBJScpeMlrI6p7IiwK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0047.namprd11.prod.outlook.com
 (2603:10b6:a03:80::24) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 8298b370-4cd2-40b5-653b-08de132997c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUdLTkJYN04rcm80R3ZNU0tuQThNVjFJeVVzZWtkUUZjYlJnNVVFN2JsUldC?=
 =?utf-8?B?VWxoSytKNllaYXFDQWEvKy9mdElyZlRTMUw3Ui9SWlRSU1B2eUFoSk90d29v?=
 =?utf-8?B?Rm1GT21WaTFoSUFTdTJQUXRWTDMvOGd3Tms3b0JtV21QenpoMWREOUNpQVNS?=
 =?utf-8?B?eDdDNWVxeEZic095V0ROVUNUVFEyczZxdWFxN2o5NnAyV3pmeFI2TUdjeG1D?=
 =?utf-8?B?Tk1EVlpaN1FoMlNnLzVlMVI5ajUyakQ2YnhLZWorbVJWQVZDNWFvVyszQko5?=
 =?utf-8?B?eFdPWWwrV01aQmJGaVVYUVJlV0F4elhlb0s4T3o4cFVJUlFUQS9USkVvaEI5?=
 =?utf-8?B?UnNoeFhvdkx3bmJHNDBqSkxFQzNObUZYT29RbTZsYlYzRjRHRHkyeWx2V0JD?=
 =?utf-8?B?RzBEMDhxUUpkczVlSks5L2JOYVV1THVpZFJKWEJQdm1Cd21BckhPSmJwbVR3?=
 =?utf-8?B?aW1TWGJRTzV2QTZFSHEwa0Q1QWk2Y21QMThNTHIrekk5KzhDSjJlYk03RURW?=
 =?utf-8?B?dXRJWkJOMTlFNXRuS2JvTmRvRlVPTXRRNTk2WjB4dE5BamlNdUdBdFlZTjdh?=
 =?utf-8?B?cUhLNkJLQktDclpvei9KZkoyRjNWbGhLZ0kvMzMrRjg4TE9ybVBaS21MQjBk?=
 =?utf-8?B?TWJBb3MxNFhvb29XL2pkeFNOczMrMFlLakV0bkpWMVc3d2oyUnRDanl4RWV0?=
 =?utf-8?B?QlBqM210c3Vqam1JbkxsMGZ1bnAvNkhmNHIyQUlxeHp6bVNrRS84Y2cwQkVl?=
 =?utf-8?B?Yk5uaGdJZUs5WWJXS05XZnBxRFFOLzkxQUN0NzFLZ2xBNjJKZW02cUwxM0N3?=
 =?utf-8?B?ckhaNFhoQUxvMXZuTnJpemxOZTI5akp3M1g4K2NheHVOanFKUU8vcG5GS081?=
 =?utf-8?B?M2RVMFBSZVFVNXBKOW9Gb3pwWnRhayt2bHV0R2ZqN1dBTjk2eXI2WmpOUHFj?=
 =?utf-8?B?WnBJWmhXMFphRitGTVh2cTBVSzlQOUFHdnlaazNQRWd4TDdERVdadWtEMnZG?=
 =?utf-8?B?dlNyOHgzS1F4UUx1WklxRHN1UUZkU0VHWWJ3QW13b1NXTk8ralFHdGI5Q1FX?=
 =?utf-8?B?R1FzSnJaajlOM2xPb0lzSk9NWS9NR2VOQ25jTW5PeXZoSzdVb3daOG5SVDVD?=
 =?utf-8?B?MzFQUFRjL1NQUkU4enc3b2NCcGpPUHF4ZFJWRnN5T0FvcTgzYm5tOENGY3dv?=
 =?utf-8?B?c3l3aFJjSFNpdWMwQjlEK0daVXJrRmpIK093Rmk4UDhManJFMS9lbkRSV3F0?=
 =?utf-8?B?ZGE2Yjd1blh0NWdJRjUyNno2QmpvamQrSU92T3ZjRlFONXVxTjQycTVmVUtv?=
 =?utf-8?B?Qm9FWmQyUmRrQllqMFlPK0JRWUEzUWUydXNQcWNCamJERmV1YVBIUHMzaUJP?=
 =?utf-8?B?QmcrYUtBNFVLbWJ0anAwQlpMdUpSOXFTUHQyVlZXZUNKRWFtM05lclVjQ1d0?=
 =?utf-8?B?eDNscnRZT0wxZG1yd3lBTmJYd3l2WVFzSzdmTHZPZWN5OE9CbWhQb0lTMEY5?=
 =?utf-8?B?c0FUSkZEWitLT1ZBeGxhdzF6dzNOZTZoYXliN0ViSFhDU3d0TFFTcDdzNU1r?=
 =?utf-8?B?NWRLdklRaEVSQTdQY1czRkY0OXZ6YjJqZnZib2J2c3Zhdkh5eU1NdGpudzR3?=
 =?utf-8?B?NkRGaVpoaGFrOTZUOUIvcVlwNHExZWpVdEJ5bkVSTU9xRDEyRVdjQ2thcC9U?=
 =?utf-8?B?TzdOMHBKNjE3emluOVA1SC9ZY1grRnJmSGpETHN0LzZ4dmlkL0VwcWFWM2lC?=
 =?utf-8?B?TlhuQlJWWWhrcWRrVHRxVnhTMytiRTVMQ2xIdExJQ2EwS1pZeHBDQmxuYTJ5?=
 =?utf-8?B?a3FvbXNRK2xPTkxjbmdISWNGRmFVSmphbm11SENnOGUzREpodEtSTUFQMjNE?=
 =?utf-8?B?Q2RSOWFYL1hNSDAxRjBxa1BsSFo2Y09UV2tJRDRzK1p3ck9Oams2K2l2THph?=
 =?utf-8?B?RThwMGkwL1V0VDlVbXZHNFoyNTcwRENYQkZTeE9OTHFOaE9Ka3BTOG0xU2pR?=
 =?utf-8?B?ZGtNOThyaTk1cWJlRkZPRHVPcEFjSDN6cnYwU2x0bVRwZE81MEcyd3o2eVcz?=
 =?utf-8?B?Y0sxd2NUMlFxWkFhT3RmM1FGMHZDOW9ybGhpZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rlc2SWZka1JBTTgxaHd1dVpCUWVPZTFWUm9xWTNjR01CeHZxUDZSU1NudC9j?=
 =?utf-8?B?TkZ1TjZqUGZTQnY3aFhpOFdPNnF0cHVNWUl3bEpsN0hNVTBsaDRwZ3plakpY?=
 =?utf-8?B?dVB5WjNZMjJnMlFPUThsZW5UMkcwaGRueHZYcklJY0F1bU9ZdlN6YU1aeGgr?=
 =?utf-8?B?K0hUWDhFclpXYWpYTEY0blYxRnY3VFp6RVpiWU1pZjUyZTFwYkpGbzd3WDcz?=
 =?utf-8?B?TU0xaC9rZUYwRXlsMXFsUWM3aUg5VllyTnJoeFZ6UnkrRDNBclFLYVZpY1dv?=
 =?utf-8?B?VnQzdldNY1pXb0VxYjRpS3JkeEUwZXhwWGdRN2Z2ZGxpWC94MXBSdWJkQ3JQ?=
 =?utf-8?B?Vk81U2lPenQzRE14K1hjWjhzSGxlOHFCNjhCanM0ZWlLVW50eFlRT0w0MDRw?=
 =?utf-8?B?cithZ2xVSDVmNkdNUzRqR0dYYy9RZXdOYjFwZ09mMnNRbTlSNDJZVGswR1dS?=
 =?utf-8?B?OUVMR0JNNC9VaGtaeHd6dkNidVkreko3NFpvWVV1VzhXdWwxS29PSTNBZWFF?=
 =?utf-8?B?a3V0czhqYnArK0JrL2NmdmQ5aWpkYlJ1SkpETkZHc3ZqTWYwaU5RNEFNcXY1?=
 =?utf-8?B?ZGZXbXVOYXVFVXNKRVpQUE1tcUc4TnVsdG0vbVR6UDhGQldNOXFRK01JamtB?=
 =?utf-8?B?Tyt5U2QwMVRlUVlxTnRFcm52ZnU1NFNMR1RsdXhtWUc5Tk1hV3VhVG91NnRz?=
 =?utf-8?B?S2VQeHpFRGdoMnNJS1ZvU2xlK0luR1dlazkyN210WlNQWXJLUnI4V3dGZ3RB?=
 =?utf-8?B?MW1JbHFqWldYcGJKUzJ4TXg4RW5nd01mbmU2N3ZCZkp1VkF3UC9FQTJydGNM?=
 =?utf-8?B?TU9uTkVhSE9lMlBUekV6S01UMzFvTjFzbHZRWDBBazFHaC9hNmNYWW9wWERw?=
 =?utf-8?B?Ym9ORmtSdHpVTGNMSXU0VmZGTGtOOXJUV0dudnliRkQySEFmS0w2YjhLR08z?=
 =?utf-8?B?d2ZVTlJIazlySHhUV08rS0Z3dExhQW51QTdrL2dEMFBuVUd3bmlCcUI3aUx1?=
 =?utf-8?B?ZTFtQ3ZiWkNYZmI3ZFRHdnhsdHFUb0VVUGlWYk5ML1gzamM1dXBRRmgxTE1z?=
 =?utf-8?B?MkVNaXQ1K1krUzJLYzdNUE81bmtocFQ4SFJENHY1TzAzcmp4eTlWbGxNaEtT?=
 =?utf-8?B?K2V2V2U2VStnRlBlUFhXL0FlTVdPU1dYZjNJbENCbm54U2k4YXlqbGI2c3NW?=
 =?utf-8?B?OThFUVRob2pMWkhyVGZiSTAybGcyMEt5d2hrZkNWRWdDNkswdUFVT1hKQXda?=
 =?utf-8?B?WkdWUVJ5NzBlUmNPWHJNbkxoRUhpZXB0NndGejBKNms2cEtweGFDREQ3eDdX?=
 =?utf-8?B?SktmUDZRb3VpN2lrc295RllMQUhPWk84Ri9jdncwU09OWGlRNjZSTXNnMUVa?=
 =?utf-8?B?RmlnM1k0T1d4OVBWK2lEMlI3cFE0RE53TlA2KzRZOG5ZUVJGclFkbllaYnpT?=
 =?utf-8?B?Z0NJQktwc0MrYnJyZVdPTzVEVVA4UzF6OUZpT25nSDJwRXlkQVRJMVZWekZx?=
 =?utf-8?B?NVVHTU5RZGJjd01iSkhVWUpIZytPRFk4NkJDMUE5M0NYclFoQjVnYnBHUWla?=
 =?utf-8?B?UEJUMWVkZERORk1NUHJkc2hiT3hoT1U2MWg5dE45cEZPcS85TDNybFM0SElk?=
 =?utf-8?B?N1VFS3hJQTFDMDcvR25TdGNBeHdURUIvZDMzN3Q4OWR1aWcweGYveWxaL3pV?=
 =?utf-8?B?Sk50a3hSckNLSVBWYXlkemNDbjl4Qk12aTgwOTJzZURaNVVMK0pqczFKNUpO?=
 =?utf-8?B?aEZGdTNMd3FVdnNWSFJLK0NBRlEzOU05dHRVT3RNSk1STlZwUkFDWi9FWjl4?=
 =?utf-8?B?WHE0MlVLOGlnTVNXNGQ3Nk5vRXZYbU53KzhKcWsweExjMlQwWDltZ05ycXI4?=
 =?utf-8?B?d0Nzc1Vhc1l2WGt4TG9iYUE5RXFMUnRuaVVKYSs0ci9tVlZodkdVK2N3V0h4?=
 =?utf-8?B?ODdxK2RMWTJRbDFSejhkZm1sd0dKeUdOazI0YUdlNTh1cmU3WEhjcXFHVG5W?=
 =?utf-8?B?VU5DTWo2eUo5aHVJUjVMaUhXY0c2TlR0TXI0aVJzbkxJZlRxSVdZNVAvOTVF?=
 =?utf-8?B?MEc1d3pzOEtQOU9IZmMwYiszWDZCUjNIRnZlT0ROQmtBOVZqTUdlR0JNZ05p?=
 =?utf-8?Q?JP/jWR5rh+CNOgfFYnce6ml4Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8298b370-4cd2-40b5-653b-08de132997c7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:17:29.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCgl7PxO+MUN5b4GCJXBp86NiWXbb063KC/gpCQwJh7ofUW0Ha3xTnT5mZFyrLDGY0fI7f345Fp4xt9qYSiDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

dts: add soc specific compatible string for imx8qm, imx8qxp, imx8dxl in db.
driver:
 - did some cleanup
 - add support for pmu in imx8dxl DB
binding:
 - add compatible string for imx8qm, imx8qxp, imx8dxl in db

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- fix binding file by move imx8qm/qxp/dxl under enum
- move clock-db-ipg clock into imx8dxl.dtsi
- Fix CHECK_DTBS warning caused in v1
- Link to v1: https://lore.kernel.org/r/20251023-qm_dts-v1-0-9830d6a45939@nxp.com

---
Frank Li (4):
      dt-bindings: perf: fsl-imx-ddr: Add compatible string for i.MX8QM, i.MX8QXP and i.MX8DXL
      perf/imx_ddr: Move ida_alloc() from ddr_perf_init() to ddr_perf_probe()
      perf/imx_ddr: Get and enable optional clks
      arm64: dts: imx8qm: add ddr perf device node

Jacky Bai (1):
      arm64: dts: imx8dxl-ss-ddr: Add DB (system interconnects) pmu support for i.MX8DXL

Joakim Zhang (1):
      perf/imx_ddr: Add support for PMU in DB (system interconnects)

 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 29 ++++++-
 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi  | 22 ++++++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi         |  7 ++
 arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi   | 19 +++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  2 +
 drivers/perf/fsl_imx8_ddr_perf.c                   | 91 ++++++++++++++++++----
 7 files changed, 153 insertions(+), 19 deletions(-)
---
base-commit: c31b21db1c04ba719c3889a57873f0f7eff54670
change-id: 20251022-qm_dts-60145802537d

Best regards,
--
Frank Li <Frank.Li@nxp.com>

