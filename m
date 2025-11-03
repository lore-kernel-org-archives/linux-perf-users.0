Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918D2D593D;
	Mon,  3 Nov 2025 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206534; cv=fail; b=l7RcZo1g4XjAa5AzLlY3isFemjp9C2aexjZb3KtGGhDG+gp5ytiEsbNeCwwdu4RsTc7hDa2IZiT00QTzJG4K5BkAl/Z6trIwxVD4vmSlrwxev6nYlLlzPX0Fs4Xfh5s2PdnLadC723LORDZGtSmjBE4dcIHNFRvhkUk8Y+0mBRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206534; c=relaxed/simple;
	bh=jds4+oyFZ/dU1p+YnhNMaOBRN84Rs6a3pJTB39RIvV4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QvIYJhfBBIn3bgo/Exnz25jCG1PeCnKy8v2jgUw7h/VHwO1MXN7NgSwcBwFAsyU+NyUpPeeydpsTjKqp0RF+AG+kOmARa/9FSYzEqZqM4nWgaJNMGboUE86rvmWyEa9ViZomlzWkG3liF28SD0E4a07lpqItnFgNO6eUKcwJPAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SYQE68ly; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SYQE68ly"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6djUd/2V1WC5J3lpy09C9THujiNt46NZeOYw/cfKiez+f+89cV4USi9/KPc0wFs0WWYfQZCxZL5h+08EfJbcQd+nlNq5NEDU5RwfuUJkCDylu2mOV49sU5vj+51CiVf4oNAviAf4R/Aa0frviOGy6Wt06MBCREuNoBF1wq9iMyruDOO+gdK7AxBLBCDZ/4n2dRoWKYDQDdwUE4uM/Lb7mZqfV/XAlWGlouwbij3mHeIA3Dut5l/9Gss+f6I9y5E/+1FOg6c0X6XuYKSdmWIfhCfPeolWAcajOf2vQMhHEmL8JtpY0Vo943Ozk9c5zPvIuQ0yfsokKLYhy+EVirbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m82bcvAtGsvzPI1IWn9yaPiuyeSwJACYqLy0NUpXgnw=;
 b=B3E1e8k+o/lrCsQm9kwx7j7PY/1ayMe0w4erWjxIAU8jJbYRqvZfFwHa8lcAO5EWE4GC8BPT8Atte3w9eB2PEEDuoGLTltCkZfHUYWgwqVFo6ydAwW8jzfsw1cN5YT44F6wk0ChoSxY6B986/HwAPpYpqHdy5/djI+2oadNSSQA/ye+4P01gHVW0+4Kl7v+hKw9Wnu9KcbwN+fyDM+zR07C9+rq7lfWp4+ryE+Lz+FmdQ508dtW9bkVzfKCsx/FyBE6yO+rBKUEjm8hn4btpQg0AlNSDY1rEQoTw1VtiQEY5gEqllPAgD0MXRHX03D4aFzJIn4aYMIjY3qi39yEqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m82bcvAtGsvzPI1IWn9yaPiuyeSwJACYqLy0NUpXgnw=;
 b=SYQE68lyF2H4qiQShlnDefV1fx3TQ3zaAZxx0UkrCenQSUMYwgR1t1M8ESXqVQxEFHo8TL++grZ1LxlkTmbOcTJVnWPwVZSkiaC0TTBEOgiN/XZnE2m91kvsAfRQwJ99UvHYI1eVx1JVv2CVIC3lnEwoFBEDLwFsyiWrYOqLgctPkjp0pa9qGoXVtlbtHgXncn8fRGdTdDOzMsny0D3rOtSboK98i5V7+KqSDWvRmfwyw0f9b7cIa/bNLc1c8srJW4cK1ZrNFK+wWsGbrr9/T2k/PPslftvegzCyKzxNWqzmYgx8FbWRd4DxoYkiMQEJlsmrFIfDSjaqbuahW9MPsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 21:48:49 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 21:48:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 03 Nov 2025 16:48:28 -0500
Subject: [PATCH v3 1/6] dt-bindings: perf: fsl-imx-ddr: Add compatible
 string for i.MX8QM, i.MX8QXP and i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-qm_dts-v3-1-2bfda8ee14c2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762206519; l=2181;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jds4+oyFZ/dU1p+YnhNMaOBRN84Rs6a3pJTB39RIvV4=;
 b=JS+3LCMSp1iEE3KNVmtMzJMpFxIrBIZhikTXvxgr+qEfmvlnEQSVMxhasvEY1hTNn1u/4LXWV
 d84xksm+T0sDZ/o0hpZaplyg6bYyQrCsEa5wt2kuuOXIe4UH3mEdWjy
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
X-MS-Office365-Filtering-Correlation-Id: c73f19be-32df-406f-ca37-08de1b22c5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUpDQjlNcEtIcEVUd3BjbUZtVnZlUEpzRDRGVDFtS280WW13QzNLbXMyMFUr?=
 =?utf-8?B?aTREYWxMUlUwQmoyY25yV09va0hYUFJydDl1OFZiQ092dk1LSUxHNlkxUkM4?=
 =?utf-8?B?SWM5MVNhWWFRRkE0Z2hjby9hZjNjWUpjbjd6WHc3TVo0c25RU0xxQkZXajJm?=
 =?utf-8?B?M2kyR21nSnpqU3ZDQkN5bWRVYUdYRHJhUVlLTEFQcXpCbDY5R2R4SFF4Sjcz?=
 =?utf-8?B?dEhLSXdsVk0yVWs1eW5CeVUyUXJEczNpV0ljWFgwaml3eENqa0oyQ0NSbEFI?=
 =?utf-8?B?T0tpcTJ0MGVpTGs0RHlIcVY5QlJHeEhtd2FwWnhXRFdYbXBPNURPMUF5alJV?=
 =?utf-8?B?ZG9hZk14SkZqbVAzSys2UVkxZXV1NXhvS3k5L1lKQk9GZFZDalR2SXFYenlX?=
 =?utf-8?B?M3NyeitwQ3FrSmFsY2xwemVJK1ptajI5NjBsczBxak5RYTlYQjlQM2dIdnpl?=
 =?utf-8?B?QTZLU1lpSTZkMmtEZEdtSEZYSFZ2aEI2K2RoMEFrUkVydCtqVFlRSjZMbUUw?=
 =?utf-8?B?UTRhUklMNm42YS9NakkzZUNRYVRKQXlkWFNVTDNkeVBjN2pFRnlXZ01rWjh1?=
 =?utf-8?B?WHdSWkVsa0gwdk9qY21qY1VkOGpCVCtuZkR0OHNUZ01idkFhTlBqTis0Rmwv?=
 =?utf-8?B?VWZBSFpCbXpPV29GQ2JuV1NzZVZoK0phMW1maE1oZ0ZDMzBRa1RsYk56TEE0?=
 =?utf-8?B?RDRhdkVNUUp6bjFQc1pnRUJaSlhZbjIwWlQyQWowMUlCSVBSaEhkazczbkg5?=
 =?utf-8?B?QUhnS283YThjOGxiWmRzb3FydkJvUHBFc1JvVlhlY0dOSURLbVEzajU3MTF0?=
 =?utf-8?B?dEdRR2xDY1pZRUliN2d5djc0UEJsbzZLM09iUFg5bC9OeThtV0xUSUFBcWxj?=
 =?utf-8?B?OTRSNmNNT1doNEpMdWFCODJqTmdZWlMyU0RrMmxuNWZnWndIdG1waGdTMFk2?=
 =?utf-8?B?cHk2T2RxUjdjbVEzb0NYUHV5bHFlUE41Y0NxOU8vM1VnU0Z6alc1MEIwbVU4?=
 =?utf-8?B?S2lMWjVGK2E2UGZtL21KZ3BSRUpkdml1bzdMY0JlNmtGNGYyTlpiN0xLS1RW?=
 =?utf-8?B?cG53M3BISlZqWlZQUC8ySXVJcG9Ycmp5NTBndHFmOWxsRkI4SG9IT25tU1B3?=
 =?utf-8?B?RVpWc0RKeG5VK0ZWS2xYdCtaTDBhRVZKZVlpNjVMZlpGNy9YWTdHK3FiSlR1?=
 =?utf-8?B?R1RyY3hmbUFpZ2luMkFUbzZhWWpyVFZCRHBhV2kxUkNrTjJOZ2hQRHYva01C?=
 =?utf-8?B?TDNiTkdVbEw4QnRxVXRsZU4xK2l0NHlVY1crSzMyRHZSQ1FtbXg5RVI5M3FF?=
 =?utf-8?B?MzhpYWh3ME10V0cwblJCYmxCUU0yRUY1QllUUEpVZkdZZitPNXJISk8rNFRY?=
 =?utf-8?B?MGx2QnNQcVFhQnNUS1NKUHEydHpsMjU4RXRwalRNMTg1Y2dCMktYa3Fxc2FL?=
 =?utf-8?B?Y0M3UmdlNU5GcW13dzBpRlFjRlY4MWpqZDlPN09vYUVKT1djUDZjc2lNZmFQ?=
 =?utf-8?B?QUxlQ1lESjFzbnlmVm0rTUo2dlVrVDJRZUwyLzh4U3dVMkhEeWlheFhOYXdR?=
 =?utf-8?B?WmhlR1RxYkliV0wvQkhCMzcyaXpIcFlMZ05uZFByOVpqMEtOeitCMGdpeDMr?=
 =?utf-8?B?bndnVW8ySEFwVm4rSlY0dnZYd016OXpzcUhtcWNZSFBnTjRRSU93OXB0bW8y?=
 =?utf-8?B?bmNZeXJaV2hrSXEyL0VKWHE2dlJpNTcyLzl3U2JGUmg2YXFNT1I3d0JRTFRv?=
 =?utf-8?B?VDgyVGo2bXl2OWNxTGFFeFJYNVJjZWUvdGZocEJWN0NxbllsZ3VhU0dUV1hE?=
 =?utf-8?B?YkxIL01jYWU0LzV5OU92b2g4V2lzSjNyRHIzTVdia25PNFdaakRCNjlNeVBi?=
 =?utf-8?B?L2Y0YlBtMDhBSHBuLzlUOUdtWXFSczhZMWh4TnpwMHVOMWNyZDJwZ2FRZW8y?=
 =?utf-8?B?OEpMTE5DOTZ0dVdBd3oyblhRYTJpWFF0NjJlZlhwbHRoMVdaN0ZYWExoWFJW?=
 =?utf-8?B?ais4V2x1ekYzUG5oM0pXaTBCS3pCRkRXN3d5TUhCRUV5Zmx5eFQ3YkdUZE9K?=
 =?utf-8?B?eE9qeVJmdGVzTmYzc3ZZeVhTaFppM3VleEpPUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3RjYXZsZ1N5S0dZMjQ5cWo5NmxEUkgwRHdFSEJTV0dKWG0yeDNMeWM4N01k?=
 =?utf-8?B?bGxIekhTRzFrK3g0OHNibzNKcDF4YmRnNHFVUmRKUG5uclFrVjJiQ3lnSmls?=
 =?utf-8?B?UWEyWENHbkJqejJuWDJRYU1Jclo1TXlmblJxclI5UmkwWnBuQ2dxQmtmMXhz?=
 =?utf-8?B?QnRqWU5yZStDRktCRUUxYmRhQ0xMV1JtWHFiWktNSWdIQ29TTWNIbFRSSVdT?=
 =?utf-8?B?a3FkZEhBdkJMbXFhbkJCRTVxcDNqcXRhSlBDb1ZpLzkzVEhaNWJ5OU5UY1RV?=
 =?utf-8?B?cjZmUlNUd3llL0NPbmtlR21QbWdkSGFQVU1xM0t4OXhndFI4UmJmWlU1bC9Q?=
 =?utf-8?B?OTJrWm9ZTExucjFUemI3NHhUc2xBUjRaSHpLc1BGQ2ZvRURVeXh1TXZ4Z05p?=
 =?utf-8?B?ZXpLeFR0b0NjQUtCTGkzcWVxS0gyOGFlazdmendyeTNmOXpwaitGVy93bmNQ?=
 =?utf-8?B?QzRKd2FqVEhtRkJDL0lMVjBNVE1qMmhDTmdvTkQ4MjgrQStCYVJUOHViMzAv?=
 =?utf-8?B?UlBSVXlBUWc1Tjltb2ZPb204cGFLR0R0N21lNU42VkNUeEFUeGxoZXlKeS9S?=
 =?utf-8?B?NzcrV3pnMnNSWXd5YjUvL2dGL3BDcWpoamptdm9mSHNHZCtVcUw1eTBWVlNF?=
 =?utf-8?B?WjVjTm9MT1BmQUpuMUU4WWUyUGF4WEhKTUpMSDdqSWxxUU5rejJhcHQrTkRj?=
 =?utf-8?B?Uk1QZjZCZHU5MUlsejlLcCtWK1R2akxsaVlCaFRZSzE0S2lpakN1aWw4WXM0?=
 =?utf-8?B?dkFnTERBRS8zeHcxaEN5WmoyTFgraXpxbi9maHNuVHZNR09MZml4U1g5T3RY?=
 =?utf-8?B?TWVLeDNOZHdvYXkrNTltTFM4UW84aUFIaHBVRnZEaS9nY1lZSVhOQjdHbUR0?=
 =?utf-8?B?QlFxSE5EREpQMHAxWm9sTFg0Y3VzSm13YkdjTGIxY09oZThnSHlBNllqYlZY?=
 =?utf-8?B?TWRxWC9GMDFPTmlsM3JVRWlNQWdUeVF6QnljaGEzT0tOTmZhdjltejBCeGNT?=
 =?utf-8?B?dkhmOURVa3hFSmpGQTJoUjZ1b1lqZ0xrSVFGTjk3S1U1MlR6Y2duSjdkbERK?=
 =?utf-8?B?ZXcrZ1FnV3JISjFDQXpDWFZMU2RuM1d4RjFTVnRQTk9KdndaSXBNVDgycndv?=
 =?utf-8?B?QnByeEwzZG1vcEdldlpmaW5ETStRUUNVN25uZ3pzbFlvK1lYNko0R2hBWVlD?=
 =?utf-8?B?VXcya0h0N0JiMyt6eTNHd3BJbGsrNENwZ1VaSXhIdDBUcE02ZFByQ3NWUzhT?=
 =?utf-8?B?aUtZbEJrRDJRRUp6Q2lWODlobkJCWmRSMCtKbjR3d1k3b3l1NnJWeW8xSVBJ?=
 =?utf-8?B?V3J1eGNiQjlQU0IyZGRHbHdaK2dKaWxsY0VYbGlQbHEvYUpabWJkMkJONnZT?=
 =?utf-8?B?QmdnbUpIUjcrL1FNSFFCY1JLU0I0VTJaZTNyVjc2WXZOMU1HM0xkVGhqZ2oz?=
 =?utf-8?B?UWFDcXZEbmxraEVsWXlpNWlra0l1SnF4MjNSUG5Oalg2cHV4dm41ZUZnb0pa?=
 =?utf-8?B?WDBoY3RtanEraTU0SFQrajlEaUMzclJxckpWajJmM1VOMHU5bzJiSkgxL2ts?=
 =?utf-8?B?UU5MaDVkdkJKa2g3Zzd5LyswNzBQeHY3NGE3bUk1Y212N3ZBM3ZzRm5wTEkv?=
 =?utf-8?B?aC9yano3Q3dSOG00dExJY3VUQkxzNDFXdmlZMTdXQXB6bkVGKzkybTl3bG9r?=
 =?utf-8?B?cWNvckxBbWFnYk5vK2hhQ1Y3UllzdjF3WEpIeGFIZzQ3Z1FvYURVVENobG16?=
 =?utf-8?B?MExSYTY0endHY3A4M1YvMEUwcFhnUXVCUDFmSnNyQ29GYjBiZnVFRDVORzJv?=
 =?utf-8?B?elJmRk9iME51Y3hMNzgrN3RoUm9TK3R3Wmg4b2NSaWN6SXAvQTY2RTUyT1pB?=
 =?utf-8?B?MDZRSDRNR2ZjUjBJTjRtQzUxNXRxQTNFQ1RzMkpSbHN4QlNEekpRa2NPRko2?=
 =?utf-8?B?aTZ0S3VNTGZzTml3TEp2MkpmbVV2SU1uMnQ5Sy9tdWZXWDZuMTM2Rm1ITFhL?=
 =?utf-8?B?MEp4SFZnVHRYK09Lc2YzNXJrVThlZERSeDlHWmFDc3c2UDNZakF3RG1NeDFo?=
 =?utf-8?B?Z2QvYnMvVFB2YU1pZmtVQnhZZWhMNHVLL3Uxc2d3RFhVZnpRUXlEaUptSzhi?=
 =?utf-8?Q?sJGMRtnPbioMeyRjxRJxHNCT6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73f19be-32df-406f-ca37-08de1b22c5e3
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 21:48:49.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT4+En9EUBe7CJryZZfC9J6J60UdMFv+BAidwBM3ScnTwcffGDnN7vofm8GRi0M+YlCjs7AgD/t37U95mm2W3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503

Add compatible string fsl,imx8qm-ddr-pmu, fsl,imx8qxp-ddr-pmu, which
fallback to fsl,imx8-ddr-pmu and fsl,imx8dxl-db-pmu (for data bus fabric).

Add clocks, clock-names for fsl,imx8dxl-db-pmu and keep the same
restriction for existing compatible strings.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v2
- move fsl,imx8qm-ddr-pmu, fsl,imx8qxp-ddr-pmu under enum
---
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index d2e578d6b83b8847c7a0ca9d5aeb208a90e2fa6a..103e4aec2439424129fdb9a76edd2ce1c598b5a1 100644
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
@@ -28,7 +29,10 @@ properties:
               - fsl,imx8mp-ddr-pmu
           - const: fsl,imx8m-ddr-pmu
       - items:
-          - const: fsl,imx8dxl-ddr-pmu
+          - enum:
+              - fsl,imx8dxl-ddr-pmu
+              - fsl,imx8qm-ddr-pmu
+              - fsl,imx8qxp-ddr-pmu
           - const: fsl,imx8-ddr-pmu
       - items:
           - enum:
@@ -43,6 +47,14 @@ properties:
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
@@ -50,6 +62,21 @@ required:
 
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

