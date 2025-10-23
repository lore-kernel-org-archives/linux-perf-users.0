Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60C34C992;
	Thu, 23 Oct 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245855; cv=fail; b=j8Zh2pQ0jONJNRmL2Y9d79RZJYpTwc/Bbo9wNKIz6wSFMqn2vbmrTY1P+kShKpZmylrZmCLK5ycyAKEeKKTW+t5WRz0GqYfZaLtnAMctC3v3FS9Tea2fLy3XgagFb/mJnWKCj7gDuevtebGz8ZxX02F/3V+TbLm3pscplzKdPUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245855; c=relaxed/simple;
	bh=IzPz42kZYkel3mbsEy4e8aK9oVFJ4u3XRLB7emfUw14=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=f9gx85K5BoupUgaVZBC+wURGDTGE+/emwWU/vFEiLBF0bIJn6UO35Ck9E70cAAz16Gq/gcNQZYjnYqIjfb96amm3FUIcf/uNEjJiltWQbCd3jd/Seu3GZ+Ci/i9WxiAIdbq/htiGzcTwDAqt2kzg1hJ0vMOSSiGKNn7+qI1Wkq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J9o11f1D; arc=fail smtp.client-ip=40.107.130.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J9o11f1D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jve8O/ivE7INol1fARFDbenx3OPpqTN5EAuYLQpp6jNjIorARCguhW4WDTvSAzw4PWuwFOxwHghki9ewH9vBSmLnxcCSjiHGydIrvh12XzLUSY/IpbN/V8sIBpZ45QCIZ41PAYFJhmD6AKhpctlrdTt0golCJ0mbeGERi/f5Cnh8shoTsYara1gJ6anZzmUKhbMdbCD6uaTu3osiCEBPlGFQoEbFAISsdVDOtL3PAG3ampRzu435yBD9uvDmYlejtVs4QyyBAFjJUNBRmXkTFTIY/7HMi2vaIvCmOU1QM9H/KkQjFZusRohyiHyrqRlmvzfWY48Xub/GrjK9XcWwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl4+ESLDaqabthAGbMiPOD5RVu+uN1+JkfUaWSd3crw=;
 b=J1icA0I5LANtJPXjixY1brs7Pc9dy3Vb5yK9RZJFmbQjk2GNd0NQm69cSIXHGvRohb2sH7MwZ2Uj/74DyZjFfcmKUpS5DLf0pZRT1IVh9Uk4aN2yj8U9NFpsPDczGW1xCDB+/8v5+JYFwIDqtM/KPWws8//P0qWM+5w3ahN9mw/o5K1WPv0noMzpxKwxXHS5ztOTfSS+zoy6vq8AqRmR37j16JyLU5Dy/f7wAm/L+2bebEK0uD5TofR/ec5Gy4TcsPb7AFkv2FhloPFxKRSkSRLZ+ycvYQSaln68li3YZSrWAMLjCri+hSedhcnd3PaB1Wol46gThpQkJqEx4p+Okw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dl4+ESLDaqabthAGbMiPOD5RVu+uN1+JkfUaWSd3crw=;
 b=J9o11f1DzfBGFVfWszVEe8uo37t5ZhdPjHJzSisU7TY31JM5H6RgXA3+fVTZSTqtrzieVFYVDK9hmOFGPTrAVza1Zx92lMczSduMljzey/vMUjuVpG0SGLsrRFyNhbY7S4qeKV5g/wjbJcfadxvYMvtOhSHKAWZuJgmJGNOJUGvG68T0R64lp1oYbOjYRIbMwUtMIIK+OF9CDgmdsdtnOdyotVgAbjLmOusQIAkSjEV5EQZs1/Qw0e/uFyK2g4zbMM+NlYarkLa882XqVbcnJTHpoBYPOGdOrmEpaOyVJhbObC8Yh+0x+k6aZS7G87yR7xjf47C78TIJV1obqLFoGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Thu, 23 Oct
 2025 18:57:31 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:57:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 23 Oct 2025 14:56:46 -0400
Subject: [PATCH 6/6] arm64: dts: imx8dxl-ss-ddr: Add DB (system
 interconnects) pmu support for i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-qm_dts-v1-6-9830d6a45939@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761245815; l=1667;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XHJ2WysPMuOdwF0hjFCJYH3uy2+2EtxPONq/JZdjmJE=;
 b=r5Vwo0pnsXKQgcLi8L8Sb3CLiHx3XPCDHZ5v4NNKZhnoYJp+lE66+i0eSiaAlL5Q5qzK6QG5F
 pq1i5970Uy8AIf/A3Q9uQ5zjselSqL9B5JANFhk+ja89pX7aIXx0P1Z
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
X-MS-Office365-Filtering-Correlation-Id: 85314ef0-6ae6-4631-8328-08de126604c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1djR3gwSzErUE1JNWVKUldJeEZ3Zjl4T3Z0N29uc0FGUDh5cnp6TlJyc1hD?=
 =?utf-8?B?V3I3SzkyTVViVVdSME9QQWJjaFcrV2xQbzNUT0piWkZoRG9sMFd3bjZIOGNN?=
 =?utf-8?B?UFkxbHlScVMxcElKN3BWRExQbXprSGtHNkZCK1BMVkUxOUNuK3JCOVlzWVlP?=
 =?utf-8?B?RERhSElaU2lDWCtyUXhHVFVBQlRjaE14QlBvN25FMFU2STRZaWtXa0VDR0Zr?=
 =?utf-8?B?NFFFRGtJYUVMeE9tNFJjaFBva2o1elZQNWQ5Smp6ajUwNHB1WjFEZDRKdTA2?=
 =?utf-8?B?d2Vjd1ZQN251clV5ZWtRVHdaazlNa2s0VVBKdUp3cEE0aW41eVAxS0NYek03?=
 =?utf-8?B?dnkxb3JaNXN6S3FzWHl4bGNRVWFvZWtzMnZqRGFUUXdGMVV0MXE1SlBOL2lv?=
 =?utf-8?B?cDVTNVRGcy9xc1Y1ZnhIYS9UdVNuT29yVFV4ZERMN0J0SW1XYzlCZWJEc250?=
 =?utf-8?B?aVdvUjh2N2J6YURmQXNBeittZHFjMlVuODJUeUNrUmMzMFZ6RytUdXVuSE8v?=
 =?utf-8?B?VHppaWZ4WXF4U0ZXRk1UUlg4dFp3Q2NBNzJkNnhqeG5SQWpIK0orakRhN3Ey?=
 =?utf-8?B?b1ViYTRSdGdXbFdrVUU5eDhMS21iMXprOWFQTkR6bWVtcXpNZ1dCTVloM1F1?=
 =?utf-8?B?N0NNQ2FFUXNwUXBFbStiaG92M2RYWklUaFdrYW03MmJXL2ZIeXBlT2hlaGRz?=
 =?utf-8?B?ODA3WTF6aEM3c1dCdGpJYTZWbE1WWG94VlgxbCtJZEFSUXNGeFZCWUFBVHha?=
 =?utf-8?B?bGJUZFdFSG8vZmptd05tdDFpc1UxSWNIdWdJclNlNGtDblhkN2NYcDZaaW42?=
 =?utf-8?B?cFdrZUU0T3kzZDltZ0NVVzJKdERxa2lPbUYyeENnSEJiVDl4aHRPQldOeHgx?=
 =?utf-8?B?cHN3TXMxS3ZxelRKalNuYm5XNSs4R3pVWHNpZjhUeUVZa1BxdEt2RFkxaVVL?=
 =?utf-8?B?bVNBRk16Ukp1VHJKRTBDYzZvR3U3MDRJSUM0Q2k1c1VjcVZRSm1qdG9XOWgv?=
 =?utf-8?B?QVZEbFJ0ZXQ3aklXVjlyc3BqMXN4VmY3TEo3ak56Qmg5NHdvUGJublh6ZENl?=
 =?utf-8?B?Q2xPM1BhQkozMXJPVFU1M3Q0MUFxaU5vOXdkbnMrSG1pNGI2c2o3N1N4Y01S?=
 =?utf-8?B?bGlhYkhOZmRUOXlnRTZnam9FcFBDa3dDeFFtTFlYTG5DdWplVysxOXlwb0dL?=
 =?utf-8?B?ZTFDam1rdXM2Yk91bU5RZU9DMGFsNEsyaGJ1Wjl4dUI2SW9UYmFrWFZra203?=
 =?utf-8?B?ekk3N1BGcEFuQ2R1RWZrOVBTSUJ1eEhYcnNNVFQ0akIwVGdNWUxBQlBTWUJ0?=
 =?utf-8?B?cXF1a3h0ZExnSHZpNHFiaWtKUkY2cUpwZkdLWEhGZHg0cjlEMzVZZ3FxRVpL?=
 =?utf-8?B?ZUZoL0RIQ0psUkRLTkc0Skt5NHhoVkFZYUtuRDltOENFWndRc3U5cDljbjBn?=
 =?utf-8?B?dDlFWDBYMExDc3lhUUdQcytkdHFtaVUyNXRRWE1GTVlwUXZBNDFRd2M4blBv?=
 =?utf-8?B?U2NiTnMvWEtoUDFhNEsrdGtSM2IwRTJYVnp4MEw0QjhpS2pIZW5GdW4vOWl3?=
 =?utf-8?B?bUpuMEZBSEZpTThpUDFVc0ZsdzlhOWUwZFhHMWg4RkgxQS9rbFp6UG93VW1Y?=
 =?utf-8?B?RTRJb3FLUldKK0VMdzUrZmRieW5DRVJ2cjZGM285RVFnZVpuWlJ6S1Ird3Iy?=
 =?utf-8?B?VFQvSzlKUEpBYUxBV0gvTFNrTHo0OEk4cDF2aWhHTGwxZHBZV3JSeEwvZklU?=
 =?utf-8?B?akhvZjA0Wm0rNi9pei9NVXVtaTU1eHo5ZldPQ09RZlVyWElLcHlVWm9pOE9M?=
 =?utf-8?B?OG1pUVJGZ0VWczJYZExFSzI2UzhFYU9uN2Z4Mm90bFgzQzRjNmtQT2NrWWVD?=
 =?utf-8?B?QXc3YUdyeU9EdFIxc3ErZXE1QktTY2pUK2p4R0RpQlN5dHFkMFNNOG5TdU8v?=
 =?utf-8?B?WHpWZFcwdWpQc0QvV3V3ZmhGdjFTTnZYL2hzZkZXaXZsMmh2SlFSK0JVTHdN?=
 =?utf-8?B?RU1iMmVuUk5yVnlXcjM1cUJTZzhSZTZ3WW40aFd3WXI3UnF5Q0pyZEtmS0Uz?=
 =?utf-8?B?a2FEcFYrU3Jqamlub1JSTXhpZEcycDk2UDVBUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUpCS08zcnB5WHFPUkNZTWhEMGpialR4Qy8rYmM4anpRNmoxRnQ1eUE1d04v?=
 =?utf-8?B?dDQzaTV1VEZNVHZZTUVEc3dwMkFsQldMK25qZy9IY3VRRExSWUpHZk1Bb0Nk?=
 =?utf-8?B?WFZYSCtoclVwbzR0S25lUnhkRjlFY3I3eGNsdkwxYWtZV0wxY1dObXZlZHh0?=
 =?utf-8?B?ZzNNa1FsY2VSRTFQTGxGeEVhNmJ0UmUwdHFuVndnaTFNbTJhbHlZNTBMcnVa?=
 =?utf-8?B?TnQ5N29hQ1FhK2MvcVB1cENKcFphTHIzOERDbDllaG5BeFFGd3I5aVRVeEpN?=
 =?utf-8?B?NlQzVVQ1UGdwak5yRURXMjhSS09GZXZHNWQzNk50WlplaytURnFZY0ZjYVla?=
 =?utf-8?B?Q0twSGZiTm96TUVQYmZXRUNJT0JFRkUxQ2NYYzZXVm1TQVdTMXJ6dGNpaXVa?=
 =?utf-8?B?NU5SNHZRbEY5UFgwWTdvb1N5bVY1V0tpV1VtOGFoOWJQMHJDWHVXYkFkWkhj?=
 =?utf-8?B?YkJoekhhUFoyYWpoemlTbzhHYmJmOUJ0bHM5SWdDcnhoTlRPTHFYNmtqS01v?=
 =?utf-8?B?OWh1R0djVHowL2JxaTU5UzlFSzRLZGZzcGF2VWk3ZlZBYVFPNnBCNHlSWm9M?=
 =?utf-8?B?TGhnV3pGcW9JWFRoZ2lRT0h6dVR0d3EvVS9QT1AwWERxd3RiRUJwZmgwbEdv?=
 =?utf-8?B?TmN2eWpxa01GdkIzNlJ5QkNZUE00a0xkbW5NZGZVcGk2V1locjJzc1BoQmZT?=
 =?utf-8?B?WlpyQk1QQlZUOUlpcmhFWml0UWk1WEw4VG5paThDTURybWdQVmJLb091bUY0?=
 =?utf-8?B?YkJZZVNyZWNrdVpiZVNvVEZBYU1HUk5PU0NJYnVHK3ZRSXpBRk5TNWpWNUhm?=
 =?utf-8?B?RU12eHVlMktOTHBQZFlWaFdEUTFKV0ovK0EwVHo0TUlkL25SaU5MdzVObDhT?=
 =?utf-8?B?dTRMWTVnMVhTQnN2Zm1IMmJGNjV1REFzVWwvS21mNmw4VHRUOENXWHJEUVkz?=
 =?utf-8?B?MjNqbG1Xb0VLMVlDaFhML2NIV0FCYTRFaitaMTVWcERPU3FzN0RlMHdPSXNJ?=
 =?utf-8?B?Q2VDOS9WOHA3bGdYZ1I4SDZSend2cXhzRTJRbFNFeTNuZFhLNStTakZKVWhJ?=
 =?utf-8?B?NWVKUE9FUTcrM1phT3RqckQ3ZnZ4aVV0dURZeHN4M0w3Si84bkpKY0NXY3ds?=
 =?utf-8?B?MEc4RDEwV0lJaW81WEZPTldzTTFqTWVzVEUzZmROLzJhRVBqaUhNVTNhWW9r?=
 =?utf-8?B?TTN3Rm82QWdNRG9iMmZDcVQrNVB2SUNtOW9MbWRRQ2NqUCtzV0dJclN3T0dI?=
 =?utf-8?B?aDdYWUhDUlVlVm00SXd4Y0JRcDVRL3hSQ3VIU0w4aGd4YW9pSFJLRVZhdVEr?=
 =?utf-8?B?MXpzUWdUWXV3SlZVNHMxZFN4R3dMbUNYOUVsQWtZMllkM3NFMWg0ZTRqdURY?=
 =?utf-8?B?VUt2QXBqWXZDK0R6UWd6N1F2RnlaL0c3bjhjdXNjUnlydFVCdk4vMS9sdExV?=
 =?utf-8?B?Z2VNSG5tc0pSR0VRTmhicUVWcXJ1MG84dDlSYTNPMTZvMTluYXJRS1k5M2FI?=
 =?utf-8?B?MVBjQ1ZuWkxLYXNhUDhGZ1lnK2ZCdnlDRWVNcmxmRmdRcFVMcXFGS3BHY0pB?=
 =?utf-8?B?ekVyMmlYMURqcGF1U0lHNWEydElZMWs0UnNKUHdlYURKVjcxRnRuY3dROEFE?=
 =?utf-8?B?aHdYNWpWTzFYc1RrRjRybm5Bckc0MEJmaWduUDE1OWVNaGFvUWZXS1VINEs4?=
 =?utf-8?B?c2p6QzZWRXBqd1ZuMWFKVlorZzRIbGVoc1kwODRacDJ5TmpiRUM0T2g4NEJB?=
 =?utf-8?B?V0ZieHlSWFozb3JkUlRIS0JldE1TMEwwenVPZmZ2dWhMVU8yT21UbHVSNW5k?=
 =?utf-8?B?UWhlTkU5bE55WElBOUlOL2hPTWJJSWFqT1krbHBBNDVUcmlyUVYrTmQyLytI?=
 =?utf-8?B?QU9VTmxqQ0dPVmZCNFZMU2ZCd29XblJpL0tQMU1xVUdIWm1CdTZ1R1hkUSty?=
 =?utf-8?B?NE1KMlFHdkp1OU5DZzVZMjlvbm41ODhwUmlGR0ZzcHI5cEhBSnhPdkRjMkJi?=
 =?utf-8?B?amhwNTRvc1RsbGtvMnBuWGg3WTVmTXJEcFZ1Ny8wWmFhZUJBQ05oL1NsVWhL?=
 =?utf-8?B?dVVpWEhKTE1GS0dWV2pSNVNocERPdXNGM1JQMmtpYnNlM0VyOWxpWDhxVUd6?=
 =?utf-8?Q?9/wgkuXdbHhbMnBOS6u+900H6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85314ef0-6ae6-4631-8328-08de126604c9
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:57:31.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qc8+i7BRXLA5a50kDaS7OLEjvZAicSGAIGjMkVlsjYfauYxNd6NvXmjvYstNtVMIWeKjGI1soPwcWpO07bBudQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

From: Jacky Bai <ping.bai@nxp.com>

Add DB pmu related nodes. This pmu is in DB (system interconnects).

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
index 3569abb5bb9befd4d1504e3e2a352c64229533c0..b9ca15d6b7f623e990ac66a770f7a34e82bf4b17 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
@@ -7,3 +7,33 @@ &ddr_pmu0 {
 	compatible = "fsl,imx8dxl-ddr-pmu", "fsl,imx8-ddr-pmu";
 	interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&ddr_subsys {
+	db_ipg_clk: clock-db-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <456000000>;
+		clock-output-names = "db_ipg_clk";
+	};
+
+	db_pmu0: db-pmu@5ca40000 {
+		compatible = "fsl,imx8dxl-db-pmu";
+		reg = <0x5ca40000 0x10000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&db_pmu0_lpcg IMX_LPCG_CLK_4>, <&db_pmu0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "cnt";
+		power-domains = <&pd IMX_SC_R_PERF>;
+	};
+
+	db_pmu0_lpcg: clock-controller@5cae0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5cae0000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&db_ipg_clk>, <&db_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "perf_lpcg_cnt_clk",
+				     "perf_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_PERF>;
+	};
+};

-- 
2.34.1

