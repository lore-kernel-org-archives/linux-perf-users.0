Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022104.outbound.protection.outlook.com [52.101.126.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CECC36654C;
	Fri, 16 Oct 2026 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121072; cv=fail; b=p/HQ2myHVLBVOYPowHsuyLaI+47SAV/uwNUyN17WcpqBbL1R7UabyFoFCBPwHtmUSX0gH0zGoXJVIi7Txs5bRsB/7pUFs73c7FalUYkNwOMY9aV0cuBmhAAtUTF6UAQWsqmtYz+CPE9BqtjjeAcQYy8V7gfloaO+qLc9nB03S5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121072; c=relaxed/simple;
	bh=Y3+92d6jmWCcnIBw8vt6hb0eUdVIwF+ZZafLIfxU19U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2YzeQlyPv7JOvpSa150FMNB+BBgPxtfueJeBy81Qza5ll7QQfrR4U03El+INDhm+cJPc5i4FfhLIn77CCtYy7mnbgypDfdECG/5gqTS05YbnEA95OjFgRZ9datoYeO+jwBSa1kc3jVQTmUzESM11HfjK1/juNb5v7Y2ubGBtcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sa4j5FltquGwrH+HJbjEQRvvthFZxVwjk/kfvNVI9K7NQGvOhkfeBlGsNiajVGL/nRszEgK/x0/i4XGRDroVSDJ24H7Z+UNtRYshtIwgPwdQ+u2g6EPqIPASeYJvxoCJl5MmFWS9jM6tTpruwXngm/6Xqr7pXuwiIYVaKgQa63CRgyTZJNaWge5znW5HAZ1cE/4YVOze8fwo90MI33nsGOJqzxoDdm9Sufz7WK4Mg6vvVhvgkGSVWRZqlI8y8w9oMPe+qnKUXRy3kt0EuPws6mNljYKjPtq1vEHwM0kca7BQQQifqppk54VUSuQhGeGDcvQxwokFH89mZMk77M2j/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0Mp+FT2y1w5C2fg2cvV9czSHeE6CvbZI3w2HRIlyUM=;
 b=vNBpKyW+qCqBCqScMrMd4ZYV5dr407cG0DEjk5d7HeestRWPGn5tN8/GoWA6Fo94odteOl6Qw7z7fYm3k+AdJwzUdR680TxZKStdGKlh+JDEjsApXmd7wcDkSkYu5vG0rAAwo85iqH5flujmu+stVySeo1YMHXeubxEa4djHsL3QKzDYNwObdd1Pa9JhwaAj24GaA3xLvQZjnB/D8zjB+LH9pHv45YXkUB6bPlvWjzEh+vw9TZxEuYrM4qvGe5dIEKIP83kyyXHiMUEucZfJ6UbZ+J/MR1eXJIs7XpnzU1XHkXJkGEmm/X/fpWVUuTn4eG75C9AqJwt4wCfRJpxAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from JH0PR06CA0008.apcprd06.prod.outlook.com (2603:1096:990:77::27)
 by TYNPR06MB8452.apcprd06.prod.outlook.com (2603:1096:405:3b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 03:24:26 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:990:77:cafe::13) by JH0PR06CA0008.outlook.office365.com
 (2603:1096:990:77::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 03:24:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 03:24:25 +0000
Received: from JohnnyFan (unknown [172.21.64.24])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9604C42C6441;
	Fri, 16 Oct 2026 11:24:24 +0800 (CST)
Date: Fri, 16 Oct 2026 11:24:23 +0800
From: Johnny Fan <johnny.fan@cixtech.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	james.clark@linaro.org, jeremy.linton@arm.com,
	cix-kernel-upstream@cixtech.com, bob.zhang@cixtech.com,
	jie.fu@cixtech.com, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH] perf: arm_spe: Support heterogeneous ACPI systems
Message-ID: <atGY5+kzQggCZboX@JohnnyFan>
References: <20261015062908.3565761-1-johnny.fan@cixtech.com>
 <86mrsf1bnv.wl-maz@kernel.org>
 <20261015141926.GC26205@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015141926.GC26205@e132581.arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYNPR06MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 5281a5df-c820-4092-1d64-08df2b34fac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|4143699003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	A8rze1UTN9RXIAH1b2zgozfkkpgDPuMA82zfeDAqYxepQDyG7hMi2q8pOonovqdAwrcizrRmplcPSeCH+J1+wVpSCV2JmlOW2l+sEcaMVkFDowkTv9MbTp/PcasZ+dk9za5dhNtoAiYKnTo0tZ5t4zJuHtC5/2DNOhKTlPTN4qFFYIiiuXKPTGAj93MBfuFeY++VjZT0I5OmcDIPulexg1NvsCFEQToJh3dc9E+Aqg+oavuyLaRQTwWwflH1ES6msupZaFyhEV8yyY5RwFiQgcD2YN0WlHgSrE85+bhv6OI3cUPJwe6BPvMe8jjHc77V91YFfrrMxTA68xEo1nz46JvhpqtdaS/Sk2u8dyBkO3qoPHn3QBgECj0rMD+mjR6J/hC0anWUO0AET8jvbaMn7zU8P5fyX+ZKRkdrAVtz3MFi9szq+Pz0txRK9ttHJbrg6THZ5DcxnPYtRIsFkI1g/q8Fl34Zum2UGNH73uNy0D1Zw1b30FSvpRx+zMWDiZtwCK5jmQtcZ5J6kqKnAwNtjTZc83ZAI3nCIqgqDgEUH9g41R51IHP+h/6hc+b/Zdujh3J8Uk0NtYl1fkQmgZSuP+mwl2OTVEVplBYaqO3YL+ZRihm+Dg+a2m1bBIj+vzZNlDwa2+1zYBUV3/9ARH+dQBi1qNGFkWM6q/68SKTIv/X2I4fYTHUK0IzU+BAtnZmR
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rJYUZ3idnNMj/tdlf8TF85dZusqIeAaRFtUIF5X7feIrn+80s3XIcdf0/AD/90pbIDkY/rzqI9ZmEtecRjhoKe0/NWUxh954lNJsb8IF/H7EMd10MJ6L6hjCxCT981mjINss8d43wGiOmXfVQ7SVrItNxf9DG0i/62Z22YvCY46J8Ir5eTPwFN8QgbAvtpBiuBsU0NO8JGcIQaMTZCGfzREymxG5V78J9IEzcUaBwL+L9s53Xp85JMKNddaCloKqUqImtM6Jc9auK9Ob/wU3UOuHE0vxXLom3bLn03DPtYu4/LoEi3X/wVU5enmI22F4m9ae8N1WTk0vzu2B5prcUiQ5a4dm1JLNVfREwKdcbG8wTrA37O+2gajXbTJJGbLGoQ5zdhm6MmWIECzvM3/d8W6bpNg2BjVrPgqYtceXeQ1LEENpMnIC0HKIw3IBhHGw
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 03:24:25.3806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5281a5df-c820-4092-1d64-08df2b34fac8
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8452

On Thu, Oct 15, 2026 at 03:19:26PM +0100, Leo Yan wrote:
> The SPE driver probes its capabilities on one CPU selected by
> smp_call_function_any(), then performs local setup on every CPU in
> supported_cpus. It therefore relies on that mask being accurate;
> including a CPU without SPE could lead to accesses to unimplemented
> SPE system registers.

Right. On ACPI the driver gets no affinity information for this
device, so supported_cpus falls back to cpu_possible_mask. That only
works today because registration is limited to homogeneous systems.
The PMSVer trimming in this patch works around the heterogeneous case;
with the mask taken from the MADT walk, both go away.

> There is also a grouping question for SPE and TRBE. If all participating
> CPUs implement the feature, but have different capabilities, should ACPI
> registration create separate platform devices for the compatible CPU
> groups? DT can describe separate CPU subsets using PPI partitions [1].
> 

That ACPI cannot describe: the GICC only carries a per-CPU interrupt
number, so CPUs with different capabilities reporting the same GSI
cannot be told apart, short of probing PMSVer. Such a split would have
to come from hardware wiring each group to a distinct PPI. For now I'd
keep it to a single GSI, and leave grouping to be revisited if hardware
that needs it ever shows up.

Thanks,
Johnny
