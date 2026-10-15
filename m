Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023121.outbound.protection.outlook.com [52.101.127.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166B4FD260;
	Thu, 15 Oct 2026 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065193; cv=fail; b=cOlxfOBIFJEm5zX1jTusNT/YSxdCfyo38Z8U7cYKWqb8dI8vdMlVGf6KhLAC9y6LV3k7g5qqOtMesbRTIAlJ3JegbQLobt6O02eptHpXYjypl30y6FrUUDVojCKLeYeaCjt+7g8SSR6y/dXhqEcAqcTi/9IGcSU5+1rTuMmwYyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065193; c=relaxed/simple;
	bh=DvOp5WhE45cWs0i5ccuy0htDAXF87YrWT6s7r0PKqjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBdYEg72RCXYSdxCzf0igZpIyN2I9iuJlqHCv0INDofILt49oryKdk/6ycW5nzChlgwKptgDV1hIa8DuovsKcdOI3hUJEurCHuDpHmIlz5nh82Fvw2MtSwNBqm5BOcWK9FxmqnfiiiTk9CBioWWtMlC3LjaawQT6wmkfGxd/9kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgbaFnMIdx7hw1/R7VrrIjGmLgh1V7/CBD7PIAr4d3ey0vVRfPUd8uqhOOMUR7IMbKFqtJvLBtmB9mpHY+XrUNL6oIx2Fn5An9DwRxFFAwB+Y8qDXt4DG/g5U/t7FsSm6xNb0bDrOOlo2lG000CiyLs5TJQ5YtObeOFWdhgcEXpK7YSRIifZZEr98/tINqL0tdMOGqm72iPrTi3s3k8R8QDF0FcYpCeP1ywQDIkiQ/OndjHVPTlBADdpoKtw5qIGrb9DOfyaG8YzOTrvJy6FXWcsyFxwJHT7DasRcyjVj0rcXJosS7dXANxL2lPcQzPlOgoF6L5PzOySlCm5yuKG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLUXZYQHnrv5dnJvW9S0SeWM2jKlG9nQfpauk7gahWQ=;
 b=THMZG9yBJmts2WdbIlCT6Oa7Zegexu4ALKPCg5lBL2fWM4SwHwgljRU4x3M4LjNrnk5VbWM4n9p9wuw4FauyqeHHL5VyP+CZgj/6GuBzGfOyCbzqyD8N51kMEGQOipmcAQkdcxFDzcyhx6ui0B0XaGPKON7/00vsjpIBkxNAu9qOCMZQv9ncP6zYhwt0O+h9uhDC2M1bqgx6JqjHgNwplj7oDpoavEkbemC7stxaUwLgxD/5z0gTYUFCkw/oidTZhdl0GIjL4YnvR/2tnTa0tW8Te8y4dOY1pzfWOlq/4FatZe1yZnNA0Bp0UZVm9y0igaZdelTLH/jCssrxFmk7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14) by
 SEYPR06MB6108.apcprd06.prod.outlook.com (2603:1096:101:c5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Thu, 15 Oct 2026 11:53:06 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:b6:cafe::2f) by SGAP274CA0002.outlook.office365.com
 (2603:1096:4:b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 11:53:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 11:53:05 +0000
Received: from JohnnyFan (unknown [172.21.64.24])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C53B342C644D;
	Thu, 15 Oct 2026 19:53:03 +0800 (CST)
Date: Thu, 15 Oct 2026 19:52:54 +0800
From: Johnny Fan <johnny.fan@cixtech.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, will@kernel.org, mark.rutland@arm.com,
	james.clark@linaro.org, leo.yan@arm.com, jeremy.linton@arm.com,
	cix-kernel-upstream@cixtech.com, bob.zhang@cixtech.com,
	jie.fu@cixtech.com, fugang.duan@cixtech.com
Subject: Re: [PATCH] perf: arm_spe: Support heterogeneous ACPI systems
Message-ID: <atC+lsWALy6ueGAB@JohnnyFan>
References: <20261015062908.3565761-1-johnny.fan@cixtech.com>
 <86mrsf1bnv.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86mrsf1bnv.wl-maz@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|SEYPR06MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: c7227726-30ad-4ac9-3486-08df2ab2dfd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|22082099003|18002099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	557c9TQ84HWUt/+HA+CXEieK3RRpgmYPHJHb+qKjbg7asxL2uIZ8zjtSOncMjfL0mmuslJ/E1ER1VsQeFFHTAfPPunFlGcAe7BraFVy7355bor9boNyMeetmZbfo2QJ3Lu553FHMghcfULAg8Zi+WHn/Uyx7t7QxVVv/D9Q8Wut2wJLE3M7qGwb4PFXWER09OewNYrs81jmN360tloLZ7NvHkmchvCoKP6OzFKeg3UhxZ9KAWlPK67CSxuk/MlIKAdCW2P4eC2kSlpjsSNkAHRfXgVan4AdVrZ3NL3Br3dm1EiCtfAxXjmcYOzK0puqyQ/QSFhzZDR2nX/25XvTW04gMJ0c1DqPyM/7Pj3UsMlnf1ytDYspXQ/EPWoCJg+7cQ9oIdLcnEb3S7oeZtQdMfO7AmWLw2Yl1pP9hGGDzXnlVBp6EEd0WH8dlyX/KDPqnilY20WGrwiiObUsV6JIeDiQRc+jc1Z408aA3bvsHbocfcNDf6geTFQfF5jjN7LHGR3gpMAVEgiyD4o77Cur2jjhN/JeKW7uyuucGnm2G8SEaUR6gJxdnfwKkxzuiEZy/HuNJQIyyFedx/M6r9rKA8c3EEZH5J7x/wVhhZBW91vtLVtjsmL66p44k5DZPBXUI8NusBb7l5TN7lkqr0/7nUaZGOXfV0j75uvas+pJnaODDxg3z4yW5bGLUMRyRnX0SzPoKhnXKTUk+NTSv5VNA8g==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mMp4SPxpQ2oQeQXCT7AC2x7ntuSmJ3j30H8ARIaxTnnEPmUWFEz+d89p9ibi9y2d68QD9RbEsEBvD5EtSOMX2Mt90FZXCH8wDmb0vIW5J7jEYyASVu7cQZ+TWh6UXoqmKgfj+stkORuhVtqRJSnmwthET2HXjY4hO4xtvwRTzaxZd5LclEXpkHVh3DrkMwidlr83cuO//FXx67r7FKHPjIrhSZGa6DCVISkbk3r4Lm8Jtr2GdFH9+JJrsgUzoXqQ4LX5NbbWNjVJtNL3ysGfgs6/eBCHIu9YxqIDcCUI9qpJrsWxoYxRMXijgeMRGJBipzHqspps5ROXUChC0d0MjVRaGTvrqToxtACZKNSf3v33ssqB/6zaEMPFjIKRCgZmYhDYMMUFNA4RAC+EOmCjrTd3Gl5ChNLLx4RM63QN9ZitDjGtA77QhR+p4lVgflEK
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:53:05.5975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7227726-30ad-4ac9-3486-08df2ab2dfd4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6108

On Thu, Oct 15, 2026 at 11:49:24AM +0100, Marc Zyngier wrote:
> This is a bit odd: at the beginning, you are stating that the SPE
> interrupt being 0 is an indication of SPE not being supported. Then
> you check for PMSVer for the same properly. This seems pretty wrong.
> 
> It should be possible to build the mask of SPE-enabled CPUs without
> IPI-ing the other CPUs, and only rely on the firmware table.

Agreed. The MADT walk already tells us which CPUs implement SPE, so the
whole PMSVer probing (including the hotplug compensation for CPUs that
were offline at probe time) can go away: the driver already consumes
platform_get_irq_affinity(), so once the mask comes from the GICC
entries it needs no changes at all.

> This "optional" parameter feels very wrong. We now have an
> infrastructure to get a set of affinities for an interrupt (see
> 5324fe21ba9b7 and following patches). What this needs is ACPI to be
> plumbed into this.
> 
> Unfortunately, ACPI is awkward and very badly abstracted in this area,
> but that doesn't mean we should make the driver code more bizarre.
> 
> Treating SPE and TRBE differently is just as odd, and there is no
> reason to do other than suiting your particular platform.

Also agreed -- the TRBE overflow interrupt has the same per-CPU
semantics in the GICC, so both devices can share one code path: build
the mask of CPUs reporting a non-zero interrupt, and require a single
GSI across that mask. The current hetid check is replaced by the GSI
consistency check. 

The part I'm unsure about is how to convey the MADT-derived mask to
platform_get_irq_affinity() for these devices: they are synthesized by
arm_pmu_acpi.c without an fwnode, so neither the of_node path nor the
_CRS-based ACPI path can reach them. Would you rather see the mask
registered with the GIC domain keyed by GSI, with a fallback in
get_irq_affinity() that resolves by IRQ number, or something simpler at
the platform_device level?

Happy to implement whichever shape you prefer.

Thanks,

Johnny
