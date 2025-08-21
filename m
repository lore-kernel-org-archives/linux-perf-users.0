Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34732E88A6;
	Thu, 21 Aug 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774171; cv=fail; b=uTeaf0kb+djOe1bHVbBo0wqSsmeT5ZcNPGIOuVYv3+Io/A+6XoqQ0xTGsF3/u1cUZveVsA71owLaR5LbxmTJHct9Uv19U5M2vYRrpPR0GHHKeidTZZbb1tQmvU5yAdcMzqz/mEnuqYUIxqA8uBc9SFjK62EbC7TsN7oHaCzMbl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774171; c=relaxed/simple;
	bh=0fSJVdD2sIzdNPPy9aRxegaB6hp7SySM5Qa0Kg+JQ3Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=suaBYRqCc9gwH36r8jT/jx6kdjgodrb45sK9SXi5xbAxuYp8Ea8QbxT7CzdonG+pEx8AZYRx89xvEA5Jrbzh2VQqkS7fzX3JMK3H7/KZ7ZmcD5iM7CL+HnlhizwtfGPAMcuVZxIlm6pWOOKBv1SjdNjKftr48oFNxBPCdtE1yNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eQms5SbC; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQms5SbC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgXvX+f1CPIKlruaRf4M0avD2qF7f8enSJ/chbW5kjSUlbhHotlPVDHiFnCUs1VphF0ewaGQeflzHH2wtlYNlHmowdsp04cIzVJ9zbQky4bpn2vdwFZvBiWDRJc1SpuKgSeGuB3FW7vHsE/F7/9IxXlzu0JIWtSy01/BYRMo14K2JIHN98sxqZ7Zi/i1kGQwosyH5qcOaRfX/UUD/0bnuirzx9szh7HhN9N1b4NhtujBNm3fW8CO9B2AO76Dp30fuLTjJEwrPVAg5dpNCUuzIPRveaWEI2zeWIXsHN+6P8RH9jwF/NdmoECEGwqrwCN0XpqcHPy01OhGzQDeHCjIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p2uJZJW8h0FLdMNjUEAIucpw+KHJ7t8h+kOJER1tos=;
 b=k9CyPmdEoopq86P0rb9WoeCE0RVMpXqH/Gxqw8hWf5DsEcWssn8cRS5dKB8zTdhz+VdJQX72O4YHgZs9j3bZkVx3Eo4cNq2eLWUjKfklH7dTM52p66KkRZk33XxIycDrksl8ecX72yWIZiKVDUb27RBYClq1enz4mWbg4rgDx4WUKKvXgJ7IVzAvlLM+uvtIQuQf3I23ftrMpglfR5dZRbvieLdeiOqR8xb+eUaUNTbg4LYrDaO3Y6nW1q+oJLtfqcOlh5MHFqz6utYHyg2/SgQ1NiLSdelfUVELEHNj6paO4sEjnG+YuV9r35Zw1fg+A2VWCfVSv53ULTnVDZZfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p2uJZJW8h0FLdMNjUEAIucpw+KHJ7t8h+kOJER1tos=;
 b=eQms5SbC2n6wyIx0kuOQ8Y7WQxEDBt/mObpGVC9om2VNBIaqMFhFk5r00Kar0Mds+P4OD8K9zafXvmDRQUXcn1dkylCt302oZehUC/R+vJWl61RsZTdB2k5nCIYHRA5ppwbgIy9cT0Zd3sM3ChQMWn8OBz1KtFQSJBAPtH+oFMBqzFUO2uydS6cSU3Aw5FBXa3Y6iEpEtY8N17qabj1PetKgMlFGYc0LhF7sKyvCxGFKRcQJ+xHW6a5YR/eI2Y2P5LNUmDlUxC8FTEOHjRmrvu9nGj7Du3OXGp6tmiqFV/EjXw8HC4itJ73JAoDvcR2Hxs9RMXRbFkeO7hWTScFfiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI0PR04MB11540.eurprd04.prod.outlook.com (2603:10a6:800:2c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 11:02:46 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 11:02:44 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Thu, 21 Aug 2025 19:01:53 +0800
Subject: [PATCH v2 5/5] arm64: dts: imx94: add DDR Perf Monitor node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-imx94-ddr-pmu-v2-5-052c6420605d@nxp.com>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
In-Reply-To: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
To: Frank Li <Frank.li@nxp.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, John Garry <john.g.garry@oracle.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755774118; l=805;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=0fSJVdD2sIzdNPPy9aRxegaB6hp7SySM5Qa0Kg+JQ3Q=;
 b=fFLEQCxuL/Sx81hch6oT5FMG3aNHCxt93Dlw9tzmWisUNBDH8QENDGzwQYuPxV2PVsWt2en41
 ZuBAEdpanwQDRjeEPxXpczC7vBA5Ymz6MxqlIj4gflgvn8u98NS5HBx
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI0PR04MB11540:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a34883e-5807-4b50-aa6f-08dde0a24199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDhKb0xGbmZOYmhkVDdpM01kR2s2K1RtNDhFSDNnTUQ4dUtRUkp3Z0kzN054?=
 =?utf-8?B?ZURMVTBqLzY0TWlqVWtQTW5SNkQyM0RBUnFCSThmQ2tyeVhhT2s2cC9uaEpT?=
 =?utf-8?B?RVRuV2daU1dwQU9LN0lieUgra1p1Y3NNUzAwUDdGTE5FK2VFandWbUtqT29P?=
 =?utf-8?B?am9tNFNzZVY1Z1ZMdHROMHN0THZGanloS0xhRE5WQ0twbHdRenFoeUp5SUY0?=
 =?utf-8?B?RTdDbkY1aWtUVzVKNVgwdDYxVU84TXZCazlzb3VDVndmYVM1WUpvbTdwOENO?=
 =?utf-8?B?SGY0V3NSbklnNjF0UnJLbHhiODg3eGNKMlZ1ckd2dWxTVEtwS09CTi9QaC9V?=
 =?utf-8?B?M2pqWHpUU0dEUHB1NldPY1BFWGFVcUFhcEdvYnBYc0RDZjgxODJLTHBGcWhJ?=
 =?utf-8?B?dmJVWDFzcEVWTGJlNThaVWJmVEV4SEl5WnF4eUFsZVEveUJkZjA0T0o1M25u?=
 =?utf-8?B?RG1uaUlwUFk1SEVnTUxXRklQV253QWVrczNDZ1BQQm1TNU1OY0trQ2FnYVU4?=
 =?utf-8?B?Tk9BUHJoclBMTGozQUNFcjA0QWdtb0FEeFVjYWE5RzczNlhDWGJtN2xrajlH?=
 =?utf-8?B?ak0xRzN0VGU1U1FyZUx3ZnM3d1F1WlNlQlorQ1BXNC9pN1FMNXhRQUx5MCs0?=
 =?utf-8?B?VHRiZzQwNjlLS05hbDRTV1BYdnVtTUYzbDArdHVuYUpncUFhWmJxVXptRWQy?=
 =?utf-8?B?bnNaRWFyY1ZieWpuaTVBVUc5bFNPWmlpaThqTUNMQnFXSFNOa3lLODk3N1FC?=
 =?utf-8?B?azd4L0Y2WEhaL0J2NVY5dEs4TWl6dEFjNlJHblNSb1ZKVWtnUE9HYXVmU2sx?=
 =?utf-8?B?M2VFM3gvRnRMRkQ5WTR2WlgzQ0FZRTFmY1lRZlhBV1FXTGhCUXcrNVNkQkZs?=
 =?utf-8?B?TUlGTkFtL3g3aVQ2djhDelRKcFUwZkpGNjZsb2IxVjZ4SEo4RGlWU05xeW1W?=
 =?utf-8?B?eTg3aUp3LzhpWUZmUDgwczRvbmhOaDRVSDBIQWltaGVpL0pFem91dnZFOUpu?=
 =?utf-8?B?RVVGMzc0V2RwM04rOVpaY0ZpZWFyenVBejZXcU1McnVUT2hOdHFWaUoySFJz?=
 =?utf-8?B?TWFRYzc2Nm5xc0VJUjQ1eUovaEJ4RE4wZjc1UU15SXJjRXB1WU95SmJOVERq?=
 =?utf-8?B?SjQ0QnllZzFQRE5VZ0Naanp1d05yY1pFdkdjQ1JBaEsxWXArazNhLzljRDcz?=
 =?utf-8?B?MFBmOEdGU0pJNlkwUDhSTDZVaDIybGszYlhQWDdOcjBOZWxzdXNDYnJyMlVS?=
 =?utf-8?B?U1RaS0FDMVFVYnJzaVRsamIxcDNYZ2VCNStmaFJlZmE3UG5pNkFuLzhYbko0?=
 =?utf-8?B?ODB3R3lCMVJMRWUxV1lRTkIvT2ZoWGt3SzlhZFdOTjZ4blJXNGdyNENKVlQ2?=
 =?utf-8?B?ZFBLTEM3c2lzSTFoYVFURERpNGF6TXFPbEZONTg3QUhVb1p4VnlPUTg2UE1E?=
 =?utf-8?B?YkR5b09ja2FPbWoxdURkRzVJR0JWNGc3U0s2blVkM1ZXdTJ6bGpUbXhjOUtT?=
 =?utf-8?B?eDV5RVg1RCswMjhoK2JxRDVmYUE3eFFZK3gzUDIyRFlJSXdWWUVidjRxRGN6?=
 =?utf-8?B?ekJBY2Jza1FBdTdISmttMTFZM0RqSktMUDNVbGlQbmdzQllhUEtpR0dqVjVL?=
 =?utf-8?B?c21PVVloRzRsTjkvSjUvS2RYYUVNVjRxOHM5OW90MXJhS2NhV1ZKQU1lNEIr?=
 =?utf-8?B?Y28rL1VoSnlUYUFMbm1UeEVacjM0SFp2blJaa2NzWGRMNFFaWk1EczJIWGlW?=
 =?utf-8?B?ZEY4N2hycXg3U2ZxYkV6UkNjNnBnY3lnNjBzK1piTjlNaE1iSkJOaHBVMkwx?=
 =?utf-8?B?ajJSZVl5RTZJQ0NqQ29oWHNacDVObDZQbWdJbjhqS1FJMjI3SkcvRjNsRTcy?=
 =?utf-8?B?RVQyQU5KVExQSWQ2Ukl3b0ZEYlFPazU0UlZaNUhFQ2dCT2wvYnNWc1FRcUV1?=
 =?utf-8?B?dTduWVFoVGNtRURJdkhLL0wrOFdHM2hXQVJtb2tLdEdwUWxHQnYxU3JsNGpm?=
 =?utf-8?Q?EsFsvqCAtAu9Trhd8zGS1Y/Ji8hc/I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alBxY1JrWWU2WDBKYmpvYTU5cTV4NTFqZlZCdWJGcDBPWm96anJVamQzQU1U?=
 =?utf-8?B?WGs5aFVRbGt1aVd5dmpUQlE0aEJwNnFkRXZVL1U1ZUs5OU9JRVNkV2t4MXVK?=
 =?utf-8?B?T0kxV2MwVTFGZGVqdGZEVGthcWR6djZzdmxxNVhzU0luMkl2dEhJclBpaTVI?=
 =?utf-8?B?cDJNZFNGcDZ5TlRKWVN6ZEo5VEFES2tzeG9XN1pnQXJFTmY4VGZWOXl6alJH?=
 =?utf-8?B?bDlXMEJ2MDJZMGpoTXlzcWhxcmZhVXNlYU1sV01Vcm1GVGJTdi9uV3Vid29S?=
 =?utf-8?B?akFKUDNEQm9TN1NnSHpIeUJYVmpnSkhhVFZjWS9QUVBwOHVVYTkvd0NyTndu?=
 =?utf-8?B?MHdRTEsvNkQ1Vk9rLzF5UVk3UEV3NVE5UWszb1RSWms1UW5naWhRRGZwdTFi?=
 =?utf-8?B?UGRZQTArSllEdk1vY3JCZC9vQ1ZXbzNqazl1OTBlbFh2MkJJM3cyYkFaL2Iv?=
 =?utf-8?B?eUVreUg3eEZ0NWViQkZBMnEzM0w5RURSREZKMUdkUzFJbVFHaG1DNzFOTTdC?=
 =?utf-8?B?TVpHSVp6K1k0cC9FckRvOTFmeGpTVjAwa01VTWxOblJOb0FMQW5XcmUyTWxB?=
 =?utf-8?B?aXBWU0FDVW03Zmc3M2oyNWR0dWx5OEpmVENoVzlkbnNmblFHZ3lCRVZLTVA4?=
 =?utf-8?B?U3J2c1NrWWhMdWRubUVpbkR1SGtyRU9URGFLNVBYbFVVa3ZzSGVkOStWUkNz?=
 =?utf-8?B?SXRvNDBiTXpJNHhoZnI1QjRocGkzbzZwQWp3MFRnUTdOSEN4YW5qUnJEQWU5?=
 =?utf-8?B?WUwyZlRWYVJSaG0rWnRaRE9MeGN5dWhEYU5FeFpIWUtTWGFoYVd0V1oxMVNV?=
 =?utf-8?B?WmpiUjFzdURWamovVkZaNmdXZi9YNFkxNFdKZWxtdTB4TFQzSzk4M0lpeFFl?=
 =?utf-8?B?cUFIZ3VYZWdtNG5NK1BuMnNSd3k0QXRUeVd2Nkt3MHlQK3d6TmZ0Z0kveU1y?=
 =?utf-8?B?U3pLOG5YYlNlb2hYalpyRFArL3ZwRHp5N0U0eksranJqckdUeHBBT28rRUtp?=
 =?utf-8?B?UDNhZkdGUnh1MHBtWEZXUW5iMFlZc0tJRTZmSXdkMU92ZFRmanRDV01WY0dt?=
 =?utf-8?B?dHJoeEFOWGljL2xxN1pZT0V2ajBpaC9CNGQva1BhWmMvdG5xWFU0ejd6akFF?=
 =?utf-8?B?aGJ1emRodGlManYvcC9VZEs3U2QzZ0Jud2ZiVGw5M3pKbm0yUjVvV1lza0Y1?=
 =?utf-8?B?UTB3OUU1bnB4MVlMNnk5Y3U5dWJOZTc4Y0JURFNLVE5LQlRDVUVyRnZNSW9U?=
 =?utf-8?B?bFJnOE5iSTlUZi9NaFVJYzVsd25TTW1KNlVJRWpxNHJTdzBFbHduZzZLVDFj?=
 =?utf-8?B?V2M4NDh1SklCRjdvSnF0aXgxTDFQeUV3YjJuMHhiaHc0aG1DL1hHTEtaU2dw?=
 =?utf-8?B?WTNSdTYwWXVtczhMaFZnaS9DbUJ3c0FQSWt4S25sTG1QaFY0UkZvVUJUZUFP?=
 =?utf-8?B?bWpFVTU4ZFNEVGxxOE1RMzNuMTRYakE1ak1VSUF4MS90V1BCZUFkR2NQVFN4?=
 =?utf-8?B?ZkhpTXF2UmJkMkVHMVRJclB0WFlZTW9NeGRiRlFXdnBnczhZTWYrdEJEbWNL?=
 =?utf-8?B?VFVITUtvaFpWNkRUaVVCbWhqVVZRTEJlNE9MdEhQTGQ1bWNqSDdXNTlSY1pB?=
 =?utf-8?B?cko1QVFDb0R4OXZ2QzhsNzdYa2hYdlF1ejdKSnhVU0Z1dGFiVDNHcDk0bmJC?=
 =?utf-8?B?NEswUVhhZEkyMXZOdFJ2SURJRW81dFN6WUlCREpseUdIeDFmbzkwNExOdS9Q?=
 =?utf-8?B?b1QvZm90K1RQNERVR2l3UnhuNDdJRjZUeFhzcjJTWjRENjBldWRUWlpOR1Ru?=
 =?utf-8?B?ZTZwTzI2QWZGWFNuUzZBamRxTnd2Sld6bWpUQmRVamdXSVkyMHVlanJNdWpt?=
 =?utf-8?B?N0l3Qm12M1c1cnFnVzVEUkZPNktVbXhvVWxzWkxtdmgxbWQxUGZIZFBqNTQ0?=
 =?utf-8?B?dTNYYWxqOGJhWDBzMGkxNU9aS1lNV1Y5Y0FSc2l1cmhiNFpLZWVhd2Fpcmtv?=
 =?utf-8?B?Q1dLaytaWE9CZ2hVcnFOa0Y4WjF0dDUrcmlhTy9sTkhjVmlFTlBFSWd5S0JV?=
 =?utf-8?B?OGg2azBxczRhQlkzUHVKajZKbjBEQTh2Umo0TTV2cXVKQThhSTNkejd3Smlp?=
 =?utf-8?Q?/QajprIeEZgBAlQ+9M4sRPVDz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a34883e-5807-4b50-aa6f-08dde0a24199
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:02:44.7690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hdH/7JTI/gv1wj/ugTici/mmrDH07O0ZD4diooMG0vnz9mQi53Mm7s7EnZ7Nyg+a8pjdEDVT5BdTEXXoEf+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11540

Add DDR Perf Monitor for i.MX94.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix typo
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index 44dee2cbd42d4bc765c33a9ce663ceda095b6c66..6a2d86d67200facec76a7880b4a2268b4191452c 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -1188,5 +1188,11 @@ wdog3: watchdog@49220000 {
 				status = "disabled";
 			};
 		};
+
+		ddr-pmu@4e090dc0 {
+			compatible = "fsl,imx94-ddr-pmu", "fsl,imx93-ddr-pmu";
+			reg = <0x0 0x4e090dc0 0x0 0x200>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };

-- 
2.34.1

