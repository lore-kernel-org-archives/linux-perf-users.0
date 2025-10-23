Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E532634AAF2;
	Thu, 23 Oct 2025 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245829; cv=fail; b=WrlBtL7oF/b64uoi7HaklZ9G1zlKgZuCc+H05fVLpnKTLH31jV9/WlaWsYLY+Wq6C+k9IeFL63sypjCTwO2wTLyaWpVnyIG5HkOvr0Owj5Y0uzzjPyeQbrwEkNVqIKAOc/lEF6rZsa/BKmPXVSEOJ9JqQQGxidb0i2mDDGjwmFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245829; c=relaxed/simple;
	bh=xnGUaS+rjYNngbG/VtNHaNp8teml1Ku+SNgvLiyLmW4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GQeOoWwPz6iSh5gtlIw0mIe+h4offcuymrRlBc6X5bmP/58FKSFjC3JZhf9fG7Qoq+PWK6k+riqqyZDDT+60xUxV/tbbjXCdeohowCOtHM8voT0ka3N6/ykfwA9lHhDk2x53sbazdikEhIb0a9Kk+t9boWCDxzyFPfp3+q017wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VugKS6r3; arc=fail smtp.client-ip=52.101.72.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VugKS6r3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSgQIsRs3blcmCi6lxMS/rnj5os3YDVYTt2j67IX7fobMktwzh08xx+2TycXQXIGT4TifEewSdDmoLA9f6K8idYq+YqME42GUMpWlNMlrBa1XKcOLxsD+ajQnHeqdPgQeXsGb0yYX/7fEQ8cZqBQyv5dKwG2hBfTFehJOD+XhLhjvi74lDpIRd/Q71atG2u45K5WMsBrKtWFE9nPVhvT5gWNWB7xm/ALQtOA3prtFn9YLuRz88MN3/JCjmB124tJbNmLouQcqXrK1exyw7BFGP0z1yFSqKFHYAZUCUiUCVJZUGq8b/3YhpjBAZr1XAm1l2KaBOjRsM14WLTrjxPoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVSmT7BUJhaizUk4kXG/nOeKLkEUJ6Q1MHhn2z+vfG8=;
 b=f3aBfNACazQcfNwNTZ75xum/yDS3TrfRcTjleYE1zGjqPnBJo2X9RcWVxDl2TSA5rD8xTNFHyCKmORPausUFsBBT/QQ8WpXGgY+HghC90S/NF5NHeJrPYWcugPQN2elQqHDa83rRVmW18eG+z7e7Or33LpLkYpMI9nGYAOqhJONsa5usOqPy6HZbQNnhdgO5JzegpPpcTX5f5jlh3AyvQnJALmRMMUv+BmK7A6TSJgXz46aiMltJk1QLSu2lAkVYn68/15+eUkTUyD4i9pNG6RHFwqkYJpST6bS9Y2XtQWzlgiCypmaXvDS/Iye/0lTE82vg0WjkYLUZ15Md09jtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVSmT7BUJhaizUk4kXG/nOeKLkEUJ6Q1MHhn2z+vfG8=;
 b=VugKS6r3J4ltR8f4V5GqSZakt7NInHbXC6yaKx+vimPDxx4pdThgYUuVnkF1yEFjeq1PPs+KIhFYFGq76BbpM1+UFgkx12qTvhPNRIVOFKQRF2eTzO5qUU5lq23XynX4LnrRl1MCyjP+7Q+M12QarS8D0IDG7Dax8BOIs5hlfNkdWq2YP4fhQFRoEfO69JSCRGz1U1/M1p+QQoAMZIiicTrcg4hpaEs/mqDCBJEoSRhaL9LrfGxmtZt/uJP8z8FVWnz8dDJfkVZKeXuBLgVXBJ3JEVYHqTWQrJEOQaoS2eTZc6ssvsH8STGequUvFVC7cVT/vc69G83atnqp69hdGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Thu, 23 Oct
 2025 18:57:05 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:57:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 23 Oct 2025 14:56:41 -0400
Subject: [PATCH 1/6] dt-bindings: perf: fsl-imx-ddr: Add compatible string
 for i.MX8QM, i.MX8QXP and i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-qm_dts-v1-1-9830d6a45939@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761245814; l=1914;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xnGUaS+rjYNngbG/VtNHaNp8teml1Ku+SNgvLiyLmW4=;
 b=kYJthGrIab+3ccz0hwg1/pfiBaWeuu+nQZiF5ZRSyjNI/FYHpGD/HJtPAkORSmoW5F40mATKF
 bbMaIKL+seNAu3hKyDiUq8X4aLkGvYq/omf7NkKUpH7/a76htYegLEN
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
X-MS-Office365-Filtering-Correlation-Id: 006820fe-fc79-43af-4dfc-08de1265f4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dW9wQ2RjY3d0d3JtUTQ2T25Uc0FyZmtFdnhNVHNIb0VMU2pBNDM5YWRDR1ly?=
 =?utf-8?B?OCt4eDJ5ais5OVQxMG9LR3RSdUs5akVOUjF3Y2ZVcFZna0F3L2ZKMEZ1YjhR?=
 =?utf-8?B?QkkraDAyNkJmQ0lLMk1qR1NzZzJrZG0xM0Zzb240dVlyL0NwYUc2akZiRUNy?=
 =?utf-8?B?TklyWUJVR2JTeWVZSW45dWpkZjFUelRWVll2Tmd2NlZFbEdnQ2NGNll2Zm4z?=
 =?utf-8?B?U0w0Nzl5Z25sNjhzSXgra2M2WXZVOWMrQmU4ZFVZUnpDNVNpOWdBNWVLT0U3?=
 =?utf-8?B?d2N4L2UvNWtIN0JnVGJLSmwxeVNnZkVlSytOMU56azdaL2o3dXJrU1lwRlRF?=
 =?utf-8?B?dEo2Zjlvc01jOTYvdkNkdTBEdXB2SXZHUXhzd2VBd2JKQUhpV2NNNlREMWZO?=
 =?utf-8?B?YXB4aGU3UlR1Tm9uc0JRVEx1M1M2WVNTakkwWVBBbHhEbHh0dFl3RFA1WVhk?=
 =?utf-8?B?NkE4VGg0R20ralEwYTE5VVNSSzRTRjExalh2eWFoOHU0b3M0M2VIUXdjRmRm?=
 =?utf-8?B?TXF1cUVCVllkR0xkdXdzbmo5cDBNdm9RZkdyK0NmVW5QYlhZd1ZYZnZHc3Q0?=
 =?utf-8?B?NWd1Y1hvVlhZOVRmS3dEeXBEWXNwdVlzK01SbFhMaUFjRmZ1YlRObWJvWm5h?=
 =?utf-8?B?VXp6YmVBNUgrQ2R0RFpXSVEzQld1TnBJdFBBcUpVZStwZ25keVE5VlBCanUw?=
 =?utf-8?B?YXVMZk5sdEJ6WXhFVVRHNGtqWElvcE9MS1BXMTNkNzNYVEdkOHVqQmY1UnV1?=
 =?utf-8?B?dVNSVXF2NXFVUHpLZVhWdmhNbHcwNGc3S0VXMDRuU0ppdGNqMWFxMlBycSti?=
 =?utf-8?B?d0NRWW9xVVdRNGdCR3pVek9kaHM5QThzTW5NenpvNWpKa0VhK0JLbWt1MFg3?=
 =?utf-8?B?VVRpZ0FhcHdBR1lBbUZjWUZuQWdhMlFFUmVzbEIrRkp4eE5IWWZIRE9ZcnNh?=
 =?utf-8?B?dmNqNm9FeU1ZNnBXTzczZmRNWTJhMWp1cmFYYVgwLzRBL1J5eEh3S1F2ZFMz?=
 =?utf-8?B?dVRzbFl5N3FHNks4QnNmWmZCTlFtZy9td2U5RG9PN25GMGptT2JxSUhMYjNC?=
 =?utf-8?B?dkwrV3UyNEZ3SXJCNk9QM3F6LzJHUXdWanlXSnpjRjRQWHZyTjI4M2ZTRmIy?=
 =?utf-8?B?eGNGMy9kTGJwOWtUeU1TMjNGN1VndXUzMmFOa2ZaQVdTSXpJZEsvSjJ1eGpN?=
 =?utf-8?B?dTUrSjJsNW5sWDZaQXIzeWp6ZnVoZWtoZnVJWm44S09Od2hxZU51TFpUYkgv?=
 =?utf-8?B?alQwK3ptN0hCZlQ0eUcwRUF6OVNUWWY5cWxhcFRVVWQvcHdhV0VkSzJXZWxk?=
 =?utf-8?B?RVpaM0lNNGxSbXJkblovRzFhRHI3MEtFQk0vR3pFQk5kY1FScnM3c20xeWlj?=
 =?utf-8?B?SUFNNFRzZXh0NE5oUnRpaWtIR05mZ2hQRUlNem5yRTVYUlc4NkFHNzVKQUd1?=
 =?utf-8?B?YzNrYkdEdnNYWXkxSWZMSEVyL25MYUhMd2oyRjJBcUNVYmxoZURGbXRvZnpN?=
 =?utf-8?B?anZvc0VPOEo2NVQreDIvbGliZVVmdUxMSlBkUmhMaXJNdVdyYmxHQm0yUEtk?=
 =?utf-8?B?WE52ZGFRaEdjWlZLdmF1bGdSWFlBcHBKSW1sUnVQTFZoUTYydk5naVVHcENM?=
 =?utf-8?B?Q1J0ZFJ1WklQZWRFVFA0OWVEK3plQzhyUXRKQlk1UXNNVEhsNzNCQ00vMEh1?=
 =?utf-8?B?SkQxb3VZU0tBWTMvUWxXMGEwL1hhWG5FTHpCUk94eXNVdi9Bd290RzNEVk10?=
 =?utf-8?B?dTR5a0JlaHFhRElmMzdHYTYwZWhOS2xvVnZrMHZ0R0J3M3ljVzhnVFN3cFda?=
 =?utf-8?B?ZndBY0FabnNRdG94bGxuOHJlbVNScXI1cWprODE0TTFHdFNPTDdpby9IMSts?=
 =?utf-8?B?RVppRlE1SnlmU1V4MXluSWNnaUxEbmRXQmdSUnhMakducXVWYnJPUElGLzE4?=
 =?utf-8?B?dUxXSTFBcmpvcWE5VmtUYlNoMVJ4NGZsTHc3dHg4V1NTTXFVSkVYZkVxNDNH?=
 =?utf-8?B?NmgzUjRudktsK08xMVJOR0UwVTRIUVhURERyTzBDUG5vMlFpYngwOS9NMEVm?=
 =?utf-8?B?eU84SW16VFlDeFpka3lKMVYwNEVhQytaK3I1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnprUjBFWnhYcjk5S0IxYXVQLzEvT3BoZWVxN2N3elRadDhhWHR4bE5wYUdV?=
 =?utf-8?B?WVVhZGRpQVJ1d2RiYmxDTk14NXpPUlNTdG5Qd0xNNmk4QmhxeDBEb2tQTURT?=
 =?utf-8?B?eVNWamlzVFdWdUxOWE5KVTM4UVI2SDZMS0R6QjRTQWNPU2VQUnRSZzRzMWtL?=
 =?utf-8?B?RFJ5cGlsZWRvWDVJdC9iM0FDMW1Lc0dCYlZYM1pOdTVLVjRuMjhSVjZ5KzZj?=
 =?utf-8?B?Ujc4OFJMZ0JLeTM5a3pCSHFNZGp3b09mcmpJQ2Nka1RLSjQvV0ZTK2JUTEdJ?=
 =?utf-8?B?eTlpalkwUTJGaE1ZVjErWEJnWWp6bmRGT09qMGdZWnI0b0FFeXBZbWNIZ0tx?=
 =?utf-8?B?V2FqalVHRnBsUHVHL1ZxQ2k3bSsxMFl4WGdXT2gvdHYrMWVFekNlZ0htckRS?=
 =?utf-8?B?aUNMMHg1TWl6Q0VDYU1hUkhmRTE5ZmFUYlF0UGJGK1pacGlwallWd3EwYWRF?=
 =?utf-8?B?b3BqbWdRTFc0dTdwc1BUQlVNKzZDaTVVdGtTL2ZDeTRsVEF5NnN3eEdIaUlS?=
 =?utf-8?B?dWE4NUNXaUt1M0ZwdTh0aG9TNjlhdmNFVDh3dHAyeTgyVzlHTldJQmhvNzhP?=
 =?utf-8?B?a0dJTWYyR0pnc1hXOUxtSzVlSTljMmF1VC9IeUVGN0lodXcxS0lhdTBzWVBT?=
 =?utf-8?B?dUdEZ09YTlVBZENHeXMvbkdWM3Vud3RJb3c4b2pTbmhVbFdPWmwyNTFJSXl2?=
 =?utf-8?B?elNtMVQyVXQyQW5STDlvZXdCTTEyTnBTbzdEODE5WnB1NkZkRFNyMFc1TEN4?=
 =?utf-8?B?YU1IT2k0SUNoYnpHMWZ2YlFkWkw4UlNjNU9IRlh5OGVZQng1TnU0YTMyZ1I4?=
 =?utf-8?B?ZHExQ0hJMTlUcFVMN09sTFVNODlaSStCbVdYNkFIcXVUR0M4S0svZWxRQVBQ?=
 =?utf-8?B?eE1pZVNLZjhyemdQKzJNaGNadEkrRlkreGtyaHNhc09UdzFSSkl2NndCWmNH?=
 =?utf-8?B?aEI5VDJXaklIajJqaEVKZ1BFSnpUY3Y1TkdyN0VwVTUvNm0xRndCZHNld3dN?=
 =?utf-8?B?Y3c3ZDcxM01LSlJVblRDUi9EWVVKa3htVlVGZC9nVFlncHFzMlhKU3dFWnNW?=
 =?utf-8?B?SFBaMzF0clgvWk0waW9Ka3BGNTFxZnpyc21EcmdyZHF5Z2RUZGhJSktmQVkr?=
 =?utf-8?B?MnJnd0F3WW9mWVpRUTdFNUtsUEhoYno5Q3h3MFBnQWNsQ0l0SnZyWU5KcHEw?=
 =?utf-8?B?YTk3SkM5TWVUTHNBM3g4NEhzN2dFdE03REZoUnpLZFc3Y0xGSlFWNzVmdWlW?=
 =?utf-8?B?UVFSZ0VWRzVNLzNKL3NmR1JRWVAwNWZuYlN3cElxMWN2RElOTFlJVzhCd1Zw?=
 =?utf-8?B?dE1tejUwM2FOQ1d0Tk9SemszTU82QmdTajFEK2ZuYVh1TzdhSWxXSlJ4eWlh?=
 =?utf-8?B?N2laK0RkNSs1TWNFVUZNaWZqVm84WUJaYTNXRXhIUDk5YTFvRGhVSitVSmVT?=
 =?utf-8?B?NGJkYWFJZ2dJLytyeGRkck90RTVTUE83MnBycklZYitKVGZVVi85VXhJMFFL?=
 =?utf-8?B?UlJGa2RqUnAzY0o3NnpOWjN0YSsyTXh1d1lIZVA4ZTlRUHZLMlNSTFFodmla?=
 =?utf-8?B?b0hicTBHU05XUFNGTUR0ejdvZ1lRaUhZb0Racnh2cVoxaFBYSlBqcW4xcG9F?=
 =?utf-8?B?RitYV3JBeForUlFXNDRjOFkrN09FUm9rMEQ4WEtNNlJrdVg3VzM4d0I3bTlV?=
 =?utf-8?B?azRjUmRrekNuMWlzbHV0NE9tRFQydEM3b0dJSlc3ZUYyTVNwY2xrU0FyQ0to?=
 =?utf-8?B?VWxSUFBHbktLUTJXcW5zalZ2c25Fb0dncDhRSVhmYWhTOUFlaC9FYy9MeTN2?=
 =?utf-8?B?elFqazVVSEhiUUkwWkYvWW9kQ1krTjZob2Z1OUY0RUlOeTBvejE3ZDhrOStp?=
 =?utf-8?B?N1I1bmNrWjRNR1FSemlVYkJHOGtreE5GVnUxVlZBKzVwWWIxN0E1TVc1SkdU?=
 =?utf-8?B?QzI1U2hVM2FBZ3pZcjgxbkpybjRzd3MyeHlocFRCUGhndnNqb1JER1ExeTdI?=
 =?utf-8?B?V1QyUDRxNFZza1pic1RiWVR3T2NXdmMzWTJZOVFLdTdRdFR3UVZmbXl2cEJB?=
 =?utf-8?B?Z3RMcU8vV2J0Yys5c3czb2E2clhhVjdRcHVURlZQREh1b0pOTjM2aHROd2xS?=
 =?utf-8?Q?51WlxYJjDcQr5ZLxI5QBthsE8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006820fe-fc79-43af-4dfc-08de1265f4f5
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:57:05.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IO3zTbN9DD3Y5/piWD/tpR1cWYOSwj7iPnUA1NUHDwD/2FtsMqkyJj+EWoCQrYigLYrQjwomwQcCPwic6EaOTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

Add compatible string fsl,imx8qm-ddr-pmu, fsl,imx8qxp-ddr-pmu and
fsl,imx8dxl-db-pmu (for data bus fabric).

Add clocks and clock-names for fsl,imx8dxl-db-pmu and keep the same
restriction for existing compatible strings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index d2e578d6b83b8847c7a0ca9d5aeb208a90e2fa6a..13eb13a79e2100ae1d747ddf6fc4db5b470112a8 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - fsl,imx8-ddr-pmu
+          - fsl,imx8dxl-db-pmu
           - fsl,imx8m-ddr-pmu
           - fsl,imx8mq-ddr-pmu
           - fsl,imx8mm-ddr-pmu
@@ -29,6 +30,8 @@ properties:
           - const: fsl,imx8m-ddr-pmu
       - items:
           - const: fsl,imx8dxl-ddr-pmu
+          - const: fsl,imx8qm-ddr-pmu
+          - const: fsl,imx8qxp-ddr-pmu
           - const: fsl,imx8-ddr-pmu
       - items:
           - enum:
@@ -43,6 +46,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: cnt
+
 required:
   - compatible
   - reg
@@ -50,6 +61,21 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8dxl-db-pmu
+    then:
+      required:
+        - clocks
+        - clock-names
+    else:
+      properties:
+        clocks: false
+        clock-names: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>

-- 
2.34.1

