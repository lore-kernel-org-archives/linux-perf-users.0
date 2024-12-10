Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFE212D77;
	Tue, 10 Dec 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823388; cv=fail; b=OG4vqeAN2f2ZF8s8yFkixYKqhDCbVRzpqgr2Z+peHGoUEIlHxcQuPIFbiR5NcyDjF1N2CIuWHVApsCd1G26KiM3YZxZCxOQLXqpNMux87fyqxlE3n98T578+V+qzVuyr71jklCFWyawY+HXo4dhvkUmlE8pcNlOSurux3yvHVOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823388; c=relaxed/simple;
	bh=x9tA8RyeYZI+52FfN6PhPV963Vi7bIMGtd957xcShn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfMY8Btth999C0NC6Bf2YfkniJLe/uYhB4HgGHMj8pNtA4FXxrCV8EfSH2iovlJzzi7JZhqjzJwfBzjuxWOT351eDOxbbqqSMnq9KdKRx5MweXMexg0u+5ErQPqO2lpxK+jduOenXDNojvf0RpI190bQoQZtnSwMtywBsMjbR7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nR4IH4/T; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nR4IH4/T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyxzu+XqYGq5WaqH9Hi85P6E3MF1EBVl9+tD6uLYNWbFKLh7z7KSNZDuF7Q2Uq8Ww7JFgeYpR0WKeDh0RAuI4IikgOT+JOksEMQiHJ5KzW+emwPr7QatT+93VhvW3HR1tUmgpMwiLQpmQkY8HIy8mXBTLECOK5Ffy7rFXyNINz3TuHkJ8UQEMSEx0xulh+yjJnep61ahjafLziNYA0K/Qr1mGpzrIvip0MrJnDptcBj5P01P4tEyWbJPKIF8draErqwczKNGh7qjD2y/pxZYX4ULXMPA5kc5qVIuFx8wKmRNHTetX81CvemUPskoYa+bbKiCaV6vLacF2+W/6XG/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xvi1bFW/ctZ3eZSPrs9Yg7NkhCpJzt2/nCOA49KIMqo=;
 b=mqHw6Pdwz9CZVeZy3W+4/TxDIi3lkqD9YA+p0Pz/cTRO4lgW32KwGsyoVMwYQZuy0dZwB1zThdMgv3njCQ0pyBBkGisyDLKZcKQrOkfxIPkEfT5gM875KeMMKeoog85SBazho+ByhUW69mJS0eztBFtBd8aGmgD/pqQJqI2gvvuuEBi5pldX73Km/fCNFau7qHl0rBlUlsHx/nmK346ff27ajF8RM71w+wgpePiQtKa3pARfHtaZyHHv1KhyzpgRRNNps79I0SWSrLpyurLm7MYK6a7w3BJ6anoWTZIFFyGr9o9RIeYpoib+5nzETMWGsMnsc6UPV3LGOTQWruM73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvi1bFW/ctZ3eZSPrs9Yg7NkhCpJzt2/nCOA49KIMqo=;
 b=nR4IH4/TGSE5mXG5lv8QKPFvO7s1HSTNBVWe45dI0D8h0X4ZYNtU9SVv1vXO11p9voSBT0/LQDCT+yfqyhRyYQNf22q+iYpZNS9gBiRjxn4mfiY9BdEsZUSt7SF73zPjHA93+wP1jWqkaD8SVNfPryo5dOs3uGGLBQGsf+qoKrw=
Received: from BLAPR03CA0090.namprd03.prod.outlook.com (2603:10b6:208:329::35)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 09:36:15 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:329:cafe::d4) by BLAPR03CA0090.outlook.office365.com
 (2603:10b6:208:329::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.18 via Frontend Transport; Tue,
 10 Dec 2024 09:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:36:15 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:36:08 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 10/10] perf test amd ibs: Add sample period unit test
Date: Tue, 10 Dec 2024 09:34:49 +0000
Message-ID: <20241210093449.1662-11-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210093449.1662-1-ravi.bangoria@amd.com>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec9ea9d-f3d5-434f-fa0e-08dd18fe17a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGXX+7DYOqcemGN7Pc8jRpX4J8X44gYqS8lrCFNJSKx+cDh82Ie+pfE3w0yr?=
 =?us-ascii?Q?QhCW7yAkyzPtFUVoDXGfxnvdk1GPJTP3NfjtsfwP4tu9xhPNRBCKYgy2cNAN?=
 =?us-ascii?Q?FlYrAkfus2kxXa0BQ6GmXMtn4dx1m7e8uxzsIY4s2vJIiPRyEIsPVMEIvt5U?=
 =?us-ascii?Q?XeViCWu1wzFE+b7kI9IhvHN3ElHKu6iq1JblpsFaykQfnGXoYTHeJwyR5KdG?=
 =?us-ascii?Q?TlgU+wh4XG50B0BsS7R69pK0Qh9X2tOXejMaQwpqWRhpkc66zCromL0f91V7?=
 =?us-ascii?Q?Dqw4bW4Eq5nPEIHwxjcYCLHgj0w7+zV11y7VZgGj2g6TArvESG/uCapaJFiA?=
 =?us-ascii?Q?bQ7lv4lHK6ej3cWD0BAocsEnBgbpTZ7MVNMxif55T7uGxmRddpHdDtggyObU?=
 =?us-ascii?Q?X+Y+yyNmxEIJFP12gc6+XoLeMbYtLiopw+A8DyhU6u+9XeQbCGIZExUZ+7+x?=
 =?us-ascii?Q?OTu1AWkf/RbyRPgu+l6sEUZ5ZRhxdY3SPzzQ+xXjBrjluq5PpvhpJV7VfuMT?=
 =?us-ascii?Q?nULcDTqMmPTc1ki5HOAXJqWl2Sv25drJorossZ1NpSoJxN7NS5/cH3FOpuRp?=
 =?us-ascii?Q?ab0uKgvrpiH6by6qZvGCDaMZ01Vo/FMnmP0WsCATi7xEqu7PjkBgeoScsBDx?=
 =?us-ascii?Q?GO/NTXUOQRnwmvSbbpcjOXYDKgQBgYZ507VAkXZUt4b1fVpXXAXXRklnLUyx?=
 =?us-ascii?Q?El7omF2Np4dPcRkonS8rnet9yyhCGNcEF+7ylYyixnBA1FDxgcVdy+a9pMSm?=
 =?us-ascii?Q?PMylt0jM980VWVnWrl296JA7xrYHWs0Q5NhPf8icAXttDMcnG0mitDrMs5yk?=
 =?us-ascii?Q?GlnrW10jKcbeGiM26OHlEinpeGNrr63+qIQZN+bZmw2ldQHnJ4bCDrXk/+6q?=
 =?us-ascii?Q?FjBvgHmlDfz9xGWIKBPPKSZo0c+qaOf1XYH0bH1y2Xcy9IcZgvLATAsQDYi6?=
 =?us-ascii?Q?S5xTDs7cn1ZpmOdr6SwgKuCqNLcgp8N/mR5X0f5xVkxFiuunpMg7b2G+b3oE?=
 =?us-ascii?Q?JC5cGmPBrhrl+RLi5o22GmerkdXgJyRS4u5ryNm+b5RILIsy9Fh2sO9vzrvw?=
 =?us-ascii?Q?1gFVFjaCfo5umuwKc3XaZdS3IuZOWru0+grF+V+1Z0x2+3T3dlH/ey/HFrov?=
 =?us-ascii?Q?mpQCpbbw5ilL8rsMRd0S2qlhe22V2jJZ4F3lEdy68uFjUDhi6OUgIv3uR79B?=
 =?us-ascii?Q?EgSzzw5UbAtIi62cyaCqTLo18lFeSZXCtp9gGc7qj+s/lv6Thc97VY7ImGI+?=
 =?us-ascii?Q?Sbnv9lTbuqLSr2WMrg/WARu4xo97NbsbcIlnp36bTUSupvgq3GiKTLd76SAE?=
 =?us-ascii?Q?D+EUgiedgpnCflYcWlZ9JETr3GEYFdVOFhASWmsB8M/78+z/6ZK24Or6cLZ2?=
 =?us-ascii?Q?Gvnqb9TaOPLbrbpPCF31t1lnmzaxL2jJ4usawzwkn+O940UcCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:36:15.3628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec9ea9d-f3d5-434f-fa0e-08dd18fe17a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

IBS Fetch and IBS Op PMUs has various constraints on supported sample
periods. Add perf unit tests to test those.

Running it in parallel with other tests causes intermittent failures.
Mark it exclusive to force it to run sequentially. Sample output on a
Zen5 machine:

Without kernel fixes:

  $ sudo ./perf test -vv 112
  112: AMD IBS sample period:
  --- start ---
  test child forked, pid 16675
  Using CPUID AuthenticAMD-26-2-1
  
  IBS config tests:
  -----------------
  Fetch PMU tests:
  0xffff            : Ok   (nr samples: 1001)
  0x1000            : Ok   (nr samples: 15557)
  0xff              : Ok   (nr samples: 40993)
  0x1               : Ok   (nr samples: 40543)
  0x0               : Ok
  0x10000           : Ok
  Op PMU tests:
  0x0               : Ok
  0x1               : Fail
  0x8               : Fail
  0x9               : Ok   (nr samples: 40543)
  0xf               : Ok   (nr samples: 40543)
  0x1000            : Ok   (nr samples: 18399)
  0xffff            : Ok   (nr samples: 1191)
  0x10000           : Ok
  0x100000          : Fail (nr samples: 19)
  0xf00000          : Fail (nr samples: 1)
  0xf0ffff          : Fail (nr samples: 2)
  0x1f0ffff         : Fail (nr samples: 1)
  0x7f0ffff         : Fail (nr samples: 0)
  0x8f0ffff         : Ok
  0x17f0ffff        : Ok
  
  IBS sample period constraint tests:
  -----------------------------------
  Fetch PMU test:
  freq 0, sample_freq       0: Ok
  freq 0, sample_freq       1: Fail
  freq 0, sample_freq      15: Fail
  freq 0, sample_freq      16: Ok   (nr samples: 1604)
  freq 0, sample_freq      17: Ok   (nr samples: 1604)
  freq 0, sample_freq     143: Ok   (nr samples: 1604)
  freq 0, sample_freq     144: Ok   (nr samples: 1604)
  freq 0, sample_freq     145: Ok   (nr samples: 1604)
  freq 0, sample_freq    1234: Ok   (nr samples: 1604)
  freq 0, sample_freq    4103: Ok   (nr samples: 1471)
  freq 0, sample_freq   65520: Ok   (nr samples: 2294)
  freq 0, sample_freq   65535: Ok   (nr samples: 2130)
  freq 0, sample_freq   65552: Ok   (nr samples: 2253)
  freq 0, sample_freq 8388607: Ok   (nr samples: 26)
  freq 1, sample_freq       0: Ok
  freq 1, sample_freq       1: Ok   (nr samples: 4)
  freq 1, sample_freq      15: Ok   (nr samples: 4)
  freq 1, sample_freq      16: Ok   (nr samples: 4)
  freq 1, sample_freq      17: Ok   (nr samples: 4)
  freq 1, sample_freq     143: Ok   (nr samples: 5)
  freq 1, sample_freq     144: Ok   (nr samples: 5)
  freq 1, sample_freq     145: Ok   (nr samples: 5)
  freq 1, sample_freq    1234: Ok   (nr samples: 7)
  freq 1, sample_freq    4103: Ok   (nr samples: 32)
  freq 1, sample_freq   65520: Ok   (nr samples: 530)
  freq 1, sample_freq   65535: Ok   (nr samples: 406)
  freq 1, sample_freq   65552: Ok   (nr samples: 129)
  freq 1, sample_freq 8388607: Ok
  Op PMU test:
  freq 0, sample_freq       0: Ok
  freq 0, sample_freq       1: Fail
  freq 0, sample_freq      15: Fail
  freq 0, sample_freq      16: Fail
  freq 0, sample_freq      17: Fail
  freq 0, sample_freq     143: Fail
  freq 0, sample_freq     144: Ok   (nr samples: 1604)
  freq 0, sample_freq     145: Ok   (nr samples: 1604)
  freq 0, sample_freq    1234: Ok   (nr samples: 1604)
  freq 0, sample_freq    4103: Ok   (nr samples: 1473)
  freq 0, sample_freq   65520: Ok   (nr samples: 2159)
  freq 0, sample_freq   65535: Ok   (nr samples: 2185)
  freq 0, sample_freq   65552: Ok   (nr samples: 2105)
  freq 0, sample_freq 8388607: Ok   (nr samples: 24)
  freq 1, sample_freq       0: Ok
  freq 1, sample_freq       1: Fail (nr samples: 4)
  freq 1, sample_freq      15: Fail (nr samples: 4)
  freq 1, sample_freq      16: Fail (nr samples: 4)
  freq 1, sample_freq      17: Fail (nr samples: 4)
  freq 1, sample_freq     143: Fail (nr samples: 5)
  freq 1, sample_freq     144: Fail (nr samples: 5)
  freq 1, sample_freq     145: Fail (nr samples: 5)
  freq 1, sample_freq    1234: Fail (nr samples: 7)
  freq 1, sample_freq    4103: Fail (nr samples: 33)
  freq 1, sample_freq   65520: Fail (nr samples: 554)
  freq 1, sample_freq   65535: Fail (nr samples: 561)
  freq 1, sample_freq   65552: Fail (nr samples: 551)
  freq 1, sample_freq 8388607: Ok
  
  IBS ioctl() tests:
  ------------------
  Fetch PMU tests
  ioctl(period = 0x0      ): Ok
  ioctl(period = 0x1      ): Fail
  ioctl(period = 0xf      ): Fail
  ioctl(period = 0x10     ): Ok
  ioctl(period = 0x11     ): Fail
  ioctl(period = 0x1f     ): Fail
  ioctl(period = 0x20     ): Ok
  ioctl(period = 0x80     ): Ok
  ioctl(period = 0x8f     ): Fail
  ioctl(period = 0x90     ): Ok
  ioctl(period = 0x91     ): Fail
  ioctl(period = 0x100    ): Ok
  ioctl(period = 0xfff0   ): Ok
  ioctl(period = 0xffff   ): Fail
  ioctl(period = 0x10000  ): Ok
  ioctl(period = 0x1fff0  ): Ok
  ioctl(period = 0x1fff5  ): Fail
  ioctl(freq   = 0x0      ): Ok
  ioctl(freq   = 0x1      ): Ok
  ioctl(freq   = 0xf      ): Ok
  ioctl(freq   = 0x10     ): Ok
  ioctl(freq   = 0x11     ): Ok
  ioctl(freq   = 0x1f     ): Ok
  ioctl(freq   = 0x20     ): Ok
  ioctl(freq   = 0x80     ): Ok
  ioctl(freq   = 0x8f     ): Ok
  ioctl(freq   = 0x90     ): Ok
  ioctl(freq   = 0x91     ): Ok
  ioctl(freq   = 0x100    ): Ok
  Op PMU tests
  ioctl(period = 0x0      ): Ok
  ioctl(period = 0x1      ): Fail
  ioctl(period = 0xf      ): Fail
  ioctl(period = 0x10     ): Fail
  ioctl(period = 0x11     ): Fail
  ioctl(period = 0x1f     ): Fail
  ioctl(period = 0x20     ): Fail
  ioctl(period = 0x80     ): Fail
  ioctl(period = 0x8f     ): Fail
  ioctl(period = 0x90     ): Ok
  ioctl(period = 0x91     ): Fail
  ioctl(period = 0x100    ): Ok
  ioctl(period = 0xfff0   ): Ok
  ioctl(period = 0xffff   ): Fail
  ioctl(period = 0x10000  ): Ok
  ioctl(period = 0x1fff0  ): Ok
  ioctl(period = 0x1fff5  ): Fail
  ioctl(freq   = 0x0      ): Ok
  ioctl(freq   = 0x1      ): Ok
  ioctl(freq   = 0xf      ): Ok
  ioctl(freq   = 0x10     ): Ok
  ioctl(freq   = 0x11     ): Ok
  ioctl(freq   = 0x1f     ): Ok
  ioctl(freq   = 0x20     ): Ok
  ioctl(freq   = 0x80     ): Ok
  ioctl(freq   = 0x8f     ): Ok
  ioctl(freq   = 0x90     ): Ok
  ioctl(freq   = 0x91     ): Ok
  ioctl(freq   = 0x100    ): Ok
  
  IBS freq (negative) tests:
  --------------------------
  freq 1, sample_freq 200000: Fail
  
  IBS L3MissOnly test: (takes a while)
  --------------------
  Fetch L3MissOnly: Fail (nr_samples: 1358)
  Op L3MissOnly:    Ok   (nr_samples: 1422)
  ---- end(-1) ----
  112: AMD IBS sample period                                           : FAILED!

With kernel fixes:

  $ sudo ./perf test -vv 112
  112: AMD IBS sample period:
  --- start ---
  test child forked, pid 11681
  Using CPUID AuthenticAMD-26-2-1
  
  IBS config tests:
  -----------------
  Fetch PMU tests:
  0xffff            : Ok   (nr samples: 942)
  0x1000            : Ok   (nr samples: 15396)
  0xff              : Ok   (nr samples: 40547)
  0x1               : Ok   (nr samples: 40543)
  0x0               : Ok
  0x10000           : Ok
  Op PMU tests:
  0x0               : Ok
  0x1               : Ok
  0x8               : Ok
  0x9               : Ok   (nr samples: 40543)
  0xf               : Ok   (nr samples: 40543)
  0x1000            : Ok   (nr samples: 18656)
  0xffff            : Ok   (nr samples: 1187)
  0x10000           : Ok
  0x100000          : Ok   (nr samples: 1178)
  0xf00000          : Ok   (nr samples: 77)
  0xf0ffff          : Ok   (nr samples: 69)
  0x1f0ffff         : Ok   (nr samples: 34)
  0x7f0ffff         : Ok   (nr samples: 7)
  0x8f0ffff         : Ok
  0x17f0ffff        : Ok
  
  IBS sample period constraint tests:
  -----------------------------------
  Fetch PMU test:
  freq 0, sample_freq       0: Ok
  freq 0, sample_freq       1: Ok
  freq 0, sample_freq      15: Ok
  freq 0, sample_freq      16: Ok   (nr samples: 1604)
  freq 0, sample_freq      17: Ok   (nr samples: 1604)
  freq 0, sample_freq     143: Ok   (nr samples: 1604)
  freq 0, sample_freq     144: Ok   (nr samples: 1604)
  freq 0, sample_freq     145: Ok   (nr samples: 1203)
  freq 0, sample_freq    1234: Ok   (nr samples: 1430)
  freq 0, sample_freq    4103: Ok   (nr samples: 638)
  freq 0, sample_freq   65520: Ok   (nr samples: 2018)
  freq 0, sample_freq   65535: Ok   (nr samples: 2002)
  freq 0, sample_freq   65552: Ok   (nr samples: 345)
  freq 0, sample_freq 8388607: Ok   (nr samples: 24)
  freq 1, sample_freq       0: Ok
  freq 1, sample_freq       1: Ok   (nr samples: 4)
  freq 1, sample_freq      15: Ok   (nr samples: 4)
  freq 1, sample_freq      16: Ok   (nr samples: 4)
  freq 1, sample_freq      17: Ok   (nr samples: 4)
  freq 1, sample_freq     143: Ok   (nr samples: 5)
  freq 1, sample_freq     144: Ok   (nr samples: 5)
  freq 1, sample_freq     145: Ok   (nr samples: 5)
  freq 1, sample_freq    1234: Ok   (nr samples: 8)
  freq 1, sample_freq    4103: Ok   (nr samples: 30)
  freq 1, sample_freq   65520: Ok   (nr samples: 1604)
  freq 1, sample_freq   65535: Ok   (nr samples: 1604)
  freq 1, sample_freq   65552: Ok   (nr samples: 1604)
  freq 1, sample_freq 8388607: Ok
  Op PMU test:
  freq 0, sample_freq       0: Ok
  freq 0, sample_freq       1: Ok
  freq 0, sample_freq      15: Ok
  freq 0, sample_freq      16: Ok
  freq 0, sample_freq      17: Ok
  freq 0, sample_freq     143: Ok
  freq 0, sample_freq     144: Ok   (nr samples: 1604)
  freq 0, sample_freq     145: Ok   (nr samples: 1203)
  freq 0, sample_freq    1234: Ok   (nr samples: 1435)
  freq 0, sample_freq    4103: Ok   (nr samples: 1467)
  freq 0, sample_freq   65520: Ok   (nr samples: 2209)
  freq 0, sample_freq   65535: Ok   (nr samples: 2230)
  freq 0, sample_freq   65552: Ok   (nr samples: 2265)
  freq 0, sample_freq 8388607: Ok   (nr samples: 25)
  freq 1, sample_freq       0: Ok
  freq 1, sample_freq       1: Ok   (nr samples: 4)
  freq 1, sample_freq      15: Ok   (nr samples: 4)
  freq 1, sample_freq      16: Ok   (nr samples: 4)
  freq 1, sample_freq      17: Ok   (nr samples: 4)
  freq 1, sample_freq     143: Ok   (nr samples: 5)
  freq 1, sample_freq     144: Ok   (nr samples: 4)
  freq 1, sample_freq     145: Ok   (nr samples: 5)
  freq 1, sample_freq    1234: Ok   (nr samples: 7)
  freq 1, sample_freq    4103: Ok   (nr samples: 31)
  freq 1, sample_freq   65520: Ok   (nr samples: 548)
  freq 1, sample_freq   65535: Ok   (nr samples: 446)
  freq 1, sample_freq   65552: Ok   (nr samples: 541)
  freq 1, sample_freq 8388607: Ok
  
  IBS ioctl() tests:
  ------------------
  Fetch PMU tests
  ioctl(period = 0x0      ): Ok
  ioctl(period = 0x1      ): Ok
  ioctl(period = 0xf      ): Ok
  ioctl(period = 0x10     ): Ok
  ioctl(period = 0x11     ): Ok
  ioctl(period = 0x1f     ): Ok
  ioctl(period = 0x20     ): Ok
  ioctl(period = 0x80     ): Ok
  ioctl(period = 0x8f     ): Ok
  ioctl(period = 0x90     ): Ok
  ioctl(period = 0x91     ): Ok
  ioctl(period = 0x100    ): Ok
  ioctl(period = 0xfff0   ): Ok
  ioctl(period = 0xffff   ): Ok
  ioctl(period = 0x10000  ): Ok
  ioctl(period = 0x1fff0  ): Ok
  ioctl(period = 0x1fff5  ): Ok
  ioctl(freq   = 0x0      ): Ok
  ioctl(freq   = 0x1      ): Ok
  ioctl(freq   = 0xf      ): Ok
  ioctl(freq   = 0x10     ): Ok
  ioctl(freq   = 0x11     ): Ok
  ioctl(freq   = 0x1f     ): Ok
  ioctl(freq   = 0x20     ): Ok
  ioctl(freq   = 0x80     ): Ok
  ioctl(freq   = 0x8f     ): Ok
  ioctl(freq   = 0x90     ): Ok
  ioctl(freq   = 0x91     ): Ok
  ioctl(freq   = 0x100    ): Ok
  Op PMU tests
  ioctl(period = 0x0      ): Ok
  ioctl(period = 0x1      ): Ok
  ioctl(period = 0xf      ): Ok
  ioctl(period = 0x10     ): Ok
  ioctl(period = 0x11     ): Ok
  ioctl(period = 0x1f     ): Ok
  ioctl(period = 0x20     ): Ok
  ioctl(period = 0x80     ): Ok
  ioctl(period = 0x8f     ): Ok
  ioctl(period = 0x90     ): Ok
  ioctl(period = 0x91     ): Ok
  ioctl(period = 0x100    ): Ok
  ioctl(period = 0xfff0   ): Ok
  ioctl(period = 0xffff   ): Ok
  ioctl(period = 0x10000  ): Ok
  ioctl(period = 0x1fff0  ): Ok
  ioctl(period = 0x1fff5  ): Ok
  ioctl(freq   = 0x0      ): Ok
  ioctl(freq   = 0x1      ): Ok
  ioctl(freq   = 0xf      ): Ok
  ioctl(freq   = 0x10     ): Ok
  ioctl(freq   = 0x11     ): Ok
  ioctl(freq   = 0x1f     ): Ok
  ioctl(freq   = 0x20     ): Ok
  ioctl(freq   = 0x80     ): Ok
  ioctl(freq   = 0x8f     ): Ok
  ioctl(freq   = 0x90     ): Ok
  ioctl(freq   = 0x91     ): Ok
  ioctl(freq   = 0x100    ): Ok
  
  IBS freq (negative) tests:
  --------------------------
  freq 1, sample_freq 200000: Ok
  
  IBS L3MissOnly test: (takes a while)
  --------------------
  Fetch L3MissOnly: Ok   (nr_samples: 1523)
  Op L3MissOnly:    Ok   (nr_samples: 1771)
  ---- end(0) ----
  112: AMD IBS sample period                                           : Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/include/arch-tests.h   |   1 +
 tools/perf/arch/x86/tests/Build            |   1 +
 tools/perf/arch/x86/tests/amd-ibs-period.c | 953 +++++++++++++++++++++
 tools/perf/arch/x86/tests/arch-tests.c     |   2 +
 4 files changed, 957 insertions(+)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-period.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index c0421a26b875..4fd425157d7d 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -14,6 +14,7 @@ int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
 int test__bp_modify(struct test_suite *test, int subtest);
 int test__x86_sample_parsing(struct test_suite *test, int subtest);
 int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
+int test__amd_ibs_period(struct test_suite *test, int subtest);
 int test__hybrid(struct test_suite *test, int subtest);
 
 extern struct test_suite *arch_tests[];
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 3227053f3355..db4b7945fc40 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -10,6 +10,7 @@ perf-test-$(CONFIG_AUXTRACE) += insn-x86.o
 endif
 perf-test-$(CONFIG_X86_64) += bp-modify.o
 perf-test-y += amd-ibs-via-core-pmu.o
+perf-test-y += amd-ibs-period.o
 
 ifdef SHELLCHECK
   SHELL_TESTS := gen-insn-x86-dat.sh
diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
new file mode 100644
index 000000000000..573fa8de81c2
--- /dev/null
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -0,0 +1,953 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sched.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <string.h>
+
+#include "arch-tests.h"
+#include "linux/perf_event.h"
+#include "linux/zalloc.h"
+#include "tests/tests.h"
+#include "../perf-sys.h"
+#include "pmu.h"
+#include "pmus.h"
+#include "debug.h"
+#include "util.h"
+#include "strbuf.h"
+#include "../util/env.h"
+
+#define PAGE_SIZE               sysconf(_SC_PAGESIZE)
+
+#define PERF_MMAP_DATA_PAGES    32L
+#define PERF_MMAP_DATA_SIZE     (PERF_MMAP_DATA_PAGES * PAGE_SIZE)
+#define PERF_MMAP_DATA_MASK     (PERF_MMAP_DATA_SIZE - 1)
+#define PERF_MMAP_TOTAL_PAGES   (PERF_MMAP_DATA_PAGES + 1)
+#define PERF_MMAP_TOTAL_SIZE    (PERF_MMAP_TOTAL_PAGES * PAGE_SIZE)
+
+#define rmb()                   asm volatile("lfence":::"memory")
+
+enum {
+	FD_ERROR,
+	FD_SUCCESS,
+};
+
+enum {
+	IBS_FETCH,
+	IBS_OP,
+};
+
+struct perf_pmu *fetch_pmu;
+struct perf_pmu *op_pmu;
+unsigned int perf_event_max_sample_rate;
+
+/* Dummy workload to generate IBS samples. */
+static int dummy_workload_1(unsigned long count)
+{
+	int (*func)(void);
+	int ret = 0;
+	char *p;
+	char insn1[] = {
+		0xb8, 0x01, 0x00, 0x00, 0x00, /* mov 1,%eax */
+		0xc3, /* ret */
+		0xcc, /* int 3 */
+	};
+
+	char insn2[] = {
+		0xb8, 0x02, 0x00, 0x00, 0x00, /* mov 2,%eax */
+		0xc3, /* ret */
+		0xcc, /* int 3 */
+	};
+
+	p = zalloc(2 * PAGE_SIZE);
+	if (!p) {
+		printf("malloc() failed. %m");
+		return 1;
+	}
+
+	func = (void *)((unsigned long)(p + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1));
+
+	ret = mprotect(func, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (ret) {
+		printf("mprotect() failed. %m");
+		goto out;
+	}
+
+	if (count < 100000)
+		count = 100000;
+	else if (count > 1000000)
+		count = 1000000;
+	while (count--) {
+		memcpy(func, insn1, sizeof(insn1));
+		if (func() != 1) {
+			pr_debug("ERROR insn1\n");
+			ret = -1;
+			goto out;
+		}
+		memcpy(func, insn2, sizeof(insn2));
+		if (func() != 2) {
+			pr_debug("ERROR insn2\n");
+			ret = -1;
+			goto out;
+		}
+	}
+
+out:
+	free(p);
+	return ret;
+}
+
+/* Another dummy workload to generate IBS samples. */
+static void dummy_workload_2(char *perf)
+{
+	char bench[] = " bench sched messaging -g 10 -l 5000 > /dev/null 2>&1";
+	char taskset[] = "taskset -c 0 ";
+	int ret __maybe_unused;
+	struct strbuf sb;
+	char *cmd;
+
+	strbuf_init(&sb, 0);
+	strbuf_add(&sb, taskset, strlen(taskset));
+	strbuf_add(&sb, perf, strlen(perf));
+	strbuf_add(&sb, bench, strlen(bench));
+	cmd = strbuf_detach(&sb, NULL);
+	ret = system(cmd);
+	free(cmd);
+}
+
+static int sched_affine(int cpu)
+{
+	cpu_set_t set;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	if (sched_setaffinity(getpid(), sizeof(set), &set) == -1) {
+		pr_debug("sched_setaffinity() failed. [%m]");
+		return -1;
+	}
+	return 0;
+}
+
+static void
+copy_sample_data(void *src, unsigned long offset, void *dest, size_t size)
+{
+	size_t chunk1_size, chunk2_size;
+
+	if ((offset + size) < (size_t)PERF_MMAP_DATA_SIZE) {
+		memcpy(dest, src + offset, size);
+	} else {
+		chunk1_size = PERF_MMAP_DATA_SIZE - offset;
+		chunk2_size = size - chunk1_size;
+
+		memcpy(dest, src + offset, chunk1_size);
+		memcpy(dest + chunk1_size, src, chunk2_size);
+	}
+}
+
+static int rb_read(struct perf_event_mmap_page *rb, void *dest, size_t size)
+{
+	void *base;
+	unsigned long data_tail, data_head;
+
+	/* Casting to (void *) is needed. */
+	base = (void *)rb + PAGE_SIZE;
+
+	data_head = rb->data_head;
+	rmb();
+	data_tail = rb->data_tail;
+
+	if ((data_head - data_tail) < size)
+		return -1;
+
+	data_tail &= PERF_MMAP_DATA_MASK;
+	copy_sample_data(base, data_tail, dest, size);
+	rb->data_tail += size;
+	return 0;
+}
+
+static void rb_skip(struct perf_event_mmap_page *rb, size_t size)
+{
+	size_t data_head = rb->data_head;
+
+	rmb();
+
+	if ((rb->data_tail + size) > data_head)
+		rb->data_tail = data_head;
+	else
+		rb->data_tail += size;
+}
+
+/* Sample period value taken from perf sample must match with expected value. */
+static int period_equal(unsigned long exp_period, unsigned long act_period)
+{
+	return exp_period == act_period ? 0 : -1;
+}
+
+/*
+ * Sample period value taken from perf sample must be >= minimum sample period
+ * supported by IBS HW.
+ */
+static int period_higher(unsigned long min_period, unsigned long act_period)
+{
+	return min_period <= act_period ? 0 : -1;
+}
+
+static int rb_drain_samples(struct perf_event_mmap_page *rb,
+			    unsigned long exp_period,
+			    int *nr_samples,
+			    int (*callback)(unsigned long, unsigned long))
+{
+	struct perf_event_header hdr;
+	unsigned long period;
+	int ret = 0;
+
+	/*
+	 * PERF_RECORD_SAMPLE:
+	 * struct {
+	 *	struct perf_event_header hdr;
+	 *	{ u64			 period;     } && PERF_SAMPLE_PERIOD
+	 * };
+	 */
+	while (1) {
+		if (rb_read(rb, &hdr, sizeof(hdr)))
+			return ret;
+
+		if (hdr.type == PERF_RECORD_SAMPLE) {
+			(*nr_samples)++;
+			period = 0;
+			if (rb_read(rb, &period, sizeof(period)))
+				pr_debug("rb_read(period) error. [%m]");
+			ret |= callback(exp_period, period);
+		} else {
+			rb_skip(rb, hdr.size - sizeof(hdr));
+		}
+	}
+	return ret;
+}
+
+static long perf_event_open(struct perf_event_attr *attr, pid_t pid,
+			    int cpu, int group_fd, unsigned long flags)
+{
+	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
+}
+
+static void fetch_prepare_attr(struct perf_event_attr *attr,
+			       unsigned long config, int freq,
+			       unsigned long sample_period)
+{
+	memset(attr, 0, sizeof(struct perf_event_attr));
+
+	attr->type = fetch_pmu->type;
+	attr->size = sizeof(struct perf_event_attr);
+	attr->config = config;
+	attr->disabled = 1;
+	attr->sample_type = PERF_SAMPLE_PERIOD;
+	attr->freq = freq;
+	attr->sample_period = sample_period; /* = ->sample_freq */
+}
+
+static void op_prepare_attr(struct perf_event_attr *attr,
+			    unsigned long config, int freq,
+			    unsigned long sample_period)
+{
+	memset(attr, 0, sizeof(struct perf_event_attr));
+
+	attr->type = op_pmu->type;
+	attr->size = sizeof(struct perf_event_attr);
+	attr->config = config;
+	attr->disabled = 1;
+	attr->sample_type = PERF_SAMPLE_PERIOD;
+	attr->freq = freq;
+	attr->sample_period = sample_period; /* = ->sample_freq */
+}
+
+struct ibs_configs {
+	/* Input */
+	unsigned long config;
+
+	/* Expected output */
+	unsigned long period;
+	int fd;
+};
+
+/*
+ * Somehow first Fetch event with sample period = 0x10 causes 0
+ * samples. So start with large period and decrease it gradually.
+ */
+struct ibs_configs fetch_configs[] = {
+	{ .config =  0xffff, .period = 0xffff0, .fd = FD_SUCCESS },
+	{ .config =  0x1000, .period = 0x10000, .fd = FD_SUCCESS },
+	{ .config =    0xff, .period =   0xff0, .fd = FD_SUCCESS },
+	{ .config =     0x1, .period =    0x10, .fd = FD_SUCCESS },
+	{ .config =     0x0, .period =      -1, .fd = FD_ERROR   },
+	{ .config = 0x10000, .period =      -1, .fd = FD_ERROR   },
+};
+
+struct ibs_configs op_configs[] = {
+	{ .config =        0x0, .period =        -1, .fd = FD_ERROR   },
+	{ .config =        0x1, .period =        -1, .fd = FD_ERROR   },
+	{ .config =        0x8, .period =        -1, .fd = FD_ERROR   },
+	{ .config =        0x9, .period =      0x90, .fd = FD_SUCCESS },
+	{ .config =        0xf, .period =      0xf0, .fd = FD_SUCCESS },
+	{ .config =     0x1000, .period =   0x10000, .fd = FD_SUCCESS },
+	{ .config =     0xffff, .period =   0xffff0, .fd = FD_SUCCESS },
+	{ .config =    0x10000, .period =        -1, .fd = FD_ERROR   },
+	{ .config =   0x100000, .period =  0x100000, .fd = FD_SUCCESS },
+	{ .config =   0xf00000, .period =  0xf00000, .fd = FD_SUCCESS },
+	{ .config =   0xf0ffff, .period =  0xfffff0, .fd = FD_SUCCESS },
+	{ .config =  0x1f0ffff, .period = 0x1fffff0, .fd = FD_SUCCESS },
+	{ .config =  0x7f0ffff, .period = 0x7fffff0, .fd = FD_SUCCESS },
+	{ .config =  0x8f0ffff, .period =        -1, .fd = FD_ERROR   },
+	{ .config = 0x17f0ffff, .period =        -1, .fd = FD_ERROR   },
+};
+
+static int __ibs_config_test(int ibs_type, struct ibs_configs *config, int *nr_samples)
+{
+	struct perf_event_attr attr;
+	int fd, i;
+	void *rb;
+	int ret = 0;
+
+	if (ibs_type == IBS_FETCH)
+		fetch_prepare_attr(&attr, config->config, 0, 0);
+	else
+		op_prepare_attr(&attr, config->config, 0, 0);
+
+	/* CPU0, All processes */
+	fd = perf_event_open(&attr, -1, 0, -1, 0);
+	if (config->fd == FD_ERROR) {
+		if (fd != -1) {
+			close(fd);
+			return -1;
+		}
+		return 0;
+	}
+	if (fd <= -1)
+		return -1;
+
+	rb = mmap(NULL, PERF_MMAP_TOTAL_SIZE, PROT_READ | PROT_WRITE,
+		  MAP_SHARED, fd, 0);
+	if (rb == MAP_FAILED) {
+		pr_debug("mmap() failed. [%m]\n");
+		return -1;
+	}
+
+	ioctl(fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+
+	i = 5;
+	while (i--) {
+		dummy_workload_1(1000000);
+
+		ret = rb_drain_samples(rb, config->period, nr_samples,
+				       period_equal);
+		if (ret)
+			break;
+	}
+
+	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+	munmap(rb, PERF_MMAP_TOTAL_SIZE);
+	close(fd);
+	return ret;
+}
+
+static int ibs_config_test(void)
+{
+	int nr_samples = 0;
+	unsigned long i;
+	int ret = 0;
+	int r;
+
+	pr_debug("\nIBS config tests:\n");
+	pr_debug("-----------------\n");
+
+	pr_debug("Fetch PMU tests:\n");
+	for (i = 0; i < ARRAY_SIZE(fetch_configs); i++) {
+		nr_samples = 0;
+		r = __ibs_config_test(IBS_FETCH, &(fetch_configs[i]), &nr_samples);
+
+		if (fetch_configs[i].fd == FD_ERROR) {
+			pr_debug("0x%-16lx: %-4s\n", fetch_configs[i].config,
+				 !r ? "Ok" : "Fail");
+		} else {
+			/*
+			 * Although nr_samples == 0 is reported as Fail here,
+			 * the failure status is not cascaded up because, we
+			 * can not decide whether test really failed or not
+			 * without actual samples.
+			 */
+			pr_debug("0x%-16lx: %-4s (nr samples: %d)\n", fetch_configs[i].config,
+				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
+		}
+
+		ret |= r;
+	}
+
+	pr_debug("Op PMU tests:\n");
+	for (i = 0; i < ARRAY_SIZE(op_configs); i++) {
+		nr_samples = 0;
+		r = __ibs_config_test(IBS_OP, &(op_configs[i]), &nr_samples);
+
+		if (op_configs[i].fd == FD_ERROR) {
+			pr_debug("0x%-16lx: %-4s\n", op_configs[i].config,
+				 !r ? "Ok" : "Fail");
+		} else {
+			/*
+			 * Although nr_samples == 0 is reported as Fail here,
+			 * the failure status is not cascaded up because, we
+			 * can not decide whether test really failed or not
+			 * without actual samples.
+			 */
+			pr_debug("0x%-16lx: %-4s (nr samples: %d)\n", op_configs[i].config,
+				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
+		}
+
+		ret |= r;
+	}
+
+	return ret;
+}
+
+struct ibs_period {
+	/* Input */
+	int freq;
+	unsigned long sample_freq;
+
+	/* Output */
+	int ret;
+	unsigned long period;
+};
+
+struct ibs_period fetch_period[] = {
+	{ .freq = 0, .sample_freq =        0, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 0, .sample_freq =        1, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 0, .sample_freq =      0xf, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 0, .sample_freq =     0x10, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 0, .sample_freq =     0x11, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 0, .sample_freq =     0x8f, .ret = FD_SUCCESS, .period =     0x80 },
+	{ .freq = 0, .sample_freq =     0x90, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 0, .sample_freq =     0x91, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 0, .sample_freq =    0x4d2, .ret = FD_SUCCESS, .period =    0x4d0 },
+	{ .freq = 0, .sample_freq =   0x1007, .ret = FD_SUCCESS, .period =   0x1000 },
+	{ .freq = 0, .sample_freq =   0xfff0, .ret = FD_SUCCESS, .period =   0xfff0 },
+	{ .freq = 0, .sample_freq =   0xffff, .ret = FD_SUCCESS, .period =   0xfff0 },
+	{ .freq = 0, .sample_freq =  0x10010, .ret = FD_SUCCESS, .period =  0x10010 },
+	{ .freq = 0, .sample_freq = 0x7fffff, .ret = FD_SUCCESS, .period = 0x7ffff0 },
+	{ .freq = 1, .sample_freq =        0, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 1, .sample_freq =        1, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =      0xf, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =     0x10, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =     0x11, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =     0x8f, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =     0x90, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =     0x91, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =    0x4d2, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =   0x1007, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =   0xfff0, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =   0xffff, .ret = FD_SUCCESS, .period =     0x10 },
+	{ .freq = 1, .sample_freq =  0x10010, .ret = FD_SUCCESS, .period =     0x10 },
+
+	/* ret=-1 because it's beyond default perf_event_max_sample_rate (100000) */
+	{ .freq = 1, .sample_freq = 0x7fffff, .ret = FD_ERROR,   .period =       -1 },
+};
+
+struct ibs_period op_period[] = {
+	{ .freq = 0, .sample_freq =        0, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 0, .sample_freq =        1, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 0, .sample_freq =      0xf, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 0, .sample_freq =     0x10, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 0, .sample_freq =     0x11, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 0, .sample_freq =     0x8f, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 0, .sample_freq =     0x90, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 0, .sample_freq =     0x91, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 0, .sample_freq =    0x4d2, .ret = FD_SUCCESS, .period =    0x4d0 },
+	{ .freq = 0, .sample_freq =   0x1007, .ret = FD_SUCCESS, .period =   0x1000 },
+	{ .freq = 0, .sample_freq =   0xfff0, .ret = FD_SUCCESS, .period =   0xfff0 },
+	{ .freq = 0, .sample_freq =   0xffff, .ret = FD_SUCCESS, .period =   0xfff0 },
+	{ .freq = 0, .sample_freq =  0x10010, .ret = FD_SUCCESS, .period =  0x10010 },
+	{ .freq = 0, .sample_freq = 0x7fffff, .ret = FD_SUCCESS, .period = 0x7ffff0 },
+	{ .freq = 1, .sample_freq =        0, .ret = FD_ERROR,   .period =       -1 },
+	{ .freq = 1, .sample_freq =        1, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =      0xf, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =     0x10, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =     0x11, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =     0x8f, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =     0x90, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =     0x91, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =    0x4d2, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =   0x1007, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =   0xfff0, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =   0xffff, .ret = FD_SUCCESS, .period =     0x90 },
+	{ .freq = 1, .sample_freq =  0x10010, .ret = FD_SUCCESS, .period =     0x90 },
+
+	/* ret=-1 because it's beyond default perf_event_max_sample_rate (100000) */
+	{ .freq = 1, .sample_freq = 0x7fffff, .ret = FD_ERROR,   .period =       -1 },
+};
+
+static int __ibs_period_constraint_test(int ibs_type, struct ibs_period *period,
+					int *nr_samples)
+{
+	struct perf_event_attr attr;
+	int ret = 0;
+	void *rb;
+	int fd;
+
+	if (period->freq && period->sample_freq >= perf_event_max_sample_rate) {
+		nr_samples = 0;
+		return 0;
+	}
+
+	if (ibs_type == IBS_FETCH)
+		fetch_prepare_attr(&attr, 0, period->freq, period->sample_freq);
+	else
+		op_prepare_attr(&attr, 0, period->freq, period->sample_freq);
+
+	/* CPU0, All processes */
+	fd = perf_event_open(&attr, -1, 0, -1, 0);
+	if (period->ret == FD_ERROR) {
+		if (fd != -1) {
+			close(fd);
+			return -1;
+		}
+		return 0;
+	}
+	if (fd <= -1)
+		return -1;
+
+	rb = mmap(NULL, PERF_MMAP_TOTAL_SIZE, PROT_READ | PROT_WRITE,
+		  MAP_SHARED, fd, 0);
+	if (rb == MAP_FAILED) {
+		pr_debug("mmap() failed. [%m]\n");
+		close(fd);
+		return -1;
+	}
+
+	ioctl(fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+
+	if (period->freq) {
+		dummy_workload_1(100000);
+		ret = rb_drain_samples(rb, period->period, nr_samples,
+				       period_higher);
+	} else {
+		dummy_workload_1(period->sample_freq * 10);
+		ret = rb_drain_samples(rb, period->period, nr_samples,
+				       period_equal);
+	}
+
+	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+	munmap(rb, PERF_MMAP_TOTAL_SIZE);
+	close(fd);
+	return ret;
+}
+
+static int ibs_period_constraint_test(void)
+{
+	unsigned long i;
+	int nr_samples;
+	int ret = 0;
+	int r;
+
+	pr_debug("\nIBS sample period constraint tests:\n");
+	pr_debug("-----------------------------------\n");
+
+	pr_debug("Fetch PMU test:\n");
+	for (i = 0; i < ARRAY_SIZE(fetch_period); i++) {
+		nr_samples = 0;
+		r = __ibs_period_constraint_test(IBS_FETCH, &fetch_period[i],
+						 &nr_samples);
+
+		if (fetch_period[i].ret == FD_ERROR) {
+			pr_debug("freq %d, sample_freq %7ld: %-4s\n",
+				 fetch_period[i].freq, fetch_period[i].sample_freq,
+				 !r ? "Ok" : "Fail");
+		} else {
+			/*
+			 * Although nr_samples == 0 is reported as Fail here,
+			 * the failure status is not cascaded up because, we
+			 * can not decide whether test really failed or not
+			 * without actual samples.
+			 */
+			pr_debug("freq %d, sample_freq %7ld: %-4s (nr samples: %d)\n",
+				 fetch_period[i].freq, fetch_period[i].sample_freq,
+				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
+		}
+		ret |= r;
+	}
+
+	pr_debug("Op PMU test:\n");
+	for (i = 0; i < ARRAY_SIZE(op_period); i++) {
+		nr_samples = 0;
+		r = __ibs_period_constraint_test(IBS_OP, &op_period[i],
+						 &nr_samples);
+
+		if (op_period[i].ret == FD_ERROR) {
+			pr_debug("freq %d, sample_freq %7ld: %-4s\n",
+				 op_period[i].freq, op_period[i].sample_freq,
+				 !r ? "Ok" : "Fail");
+		} else {
+			/*
+			 * Although nr_samples == 0 is reported as Fail here,
+			 * the failure status is not cascaded up because, we
+			 * can not decide whether test really failed or not
+			 * without actual samples.
+			 */
+			pr_debug("freq %d, sample_freq %7ld: %-4s (nr samples: %d)\n",
+				 op_period[i].freq, op_period[i].sample_freq,
+				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
+		}
+		ret |= r;
+	}
+
+	return ret;
+}
+
+struct ibs_ioctl {
+	/* Input */
+	int freq;
+	unsigned long period;
+
+	/* Expected output */
+	int ret;
+};
+
+struct ibs_ioctl fetch_ioctl[] = {
+	{ .freq = 0, .period =     0x0, .ret = FD_ERROR   },
+	{ .freq = 0, .period =     0x1, .ret = FD_ERROR   },
+	{ .freq = 0, .period =     0xf, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x10, .ret = FD_SUCCESS },
+	{ .freq = 0, .period =    0x11, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x1f, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x20, .ret = FD_SUCCESS },
+	{ .freq = 0, .period =    0x80, .ret = FD_SUCCESS },
+	{ .freq = 0, .period =    0x8f, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x90, .ret = FD_SUCCESS },
+	{ .freq = 0, .period =    0x91, .ret = FD_ERROR   },
+	{ .freq = 0, .period =   0x100, .ret = FD_SUCCESS },
+	{ .freq = 0, .period =  0xfff0, .ret = FD_SUCCESS },
+	{ .freq = 0, .period =  0xffff, .ret = FD_ERROR   },
+	{ .freq = 0, .period = 0x10000, .ret = FD_SUCCESS },
+	{ .freq = 0, .period = 0x1fff0, .ret = FD_SUCCESS },
+	{ .freq = 0, .period = 0x1fff5, .ret = FD_ERROR   },
+	{ .freq = 1, .period =     0x0, .ret = FD_ERROR   },
+	{ .freq = 1, .period =     0x1, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =     0xf, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x10, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x11, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x1f, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x20, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x80, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x8f, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x90, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x91, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =   0x100, .ret = FD_SUCCESS },
+};
+
+struct ibs_ioctl op_ioctl[] = {
+	{ .freq = 0, .period =     0x0, .ret = FD_ERROR   },
+	{ .freq = 0, .period =     0x1, .ret = FD_ERROR   },
+	{ .freq = 0, .period =     0xf, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x10, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x11, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x1f, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x20, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x80, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x8f, .ret = FD_ERROR   },
+	{ .freq = 0, .period =    0x90, .ret = FD_SUCCESS },
+	{ .freq = 0, .period =    0x91, .ret = FD_ERROR   },
+	{ .freq = 0, .period =   0x100, .ret = FD_SUCCESS },
+	{ .freq = 0, .period =  0xfff0, .ret = FD_SUCCESS },
+	{ .freq = 0, .period =  0xffff, .ret = FD_ERROR   },
+	{ .freq = 0, .period = 0x10000, .ret = FD_SUCCESS },
+	{ .freq = 0, .period = 0x1fff0, .ret = FD_SUCCESS },
+	{ .freq = 0, .period = 0x1fff5, .ret = FD_ERROR   },
+	{ .freq = 1, .period =     0x0, .ret = FD_ERROR   },
+	{ .freq = 1, .period =     0x1, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =     0xf, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x10, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x11, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x1f, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x20, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x80, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x8f, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x90, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =    0x91, .ret = FD_SUCCESS },
+	{ .freq = 1, .period =   0x100, .ret = FD_SUCCESS },
+};
+
+static int __ibs_ioctl_test(int ibs_type, struct ibs_ioctl *ibs_ioctl)
+{
+	struct perf_event_attr attr;
+	int ret = 0;
+	int fd;
+	int r;
+
+	if (ibs_type == IBS_FETCH)
+		fetch_prepare_attr(&attr, 0, ibs_ioctl->freq, 1000);
+	else
+		op_prepare_attr(&attr, 0, ibs_ioctl->freq, 1000);
+
+	/* CPU0, All processes */
+	fd = perf_event_open(&attr, -1, 0, -1, 0);
+	if (fd <= -1) {
+		pr_debug("event_open() Failed\n");
+		return -1;
+	}
+
+	r = ioctl(fd, PERF_EVENT_IOC_PERIOD, &ibs_ioctl->period);
+	if ((ibs_ioctl->ret == FD_SUCCESS && r <= -1) ||
+	    (ibs_ioctl->ret == FD_ERROR && r >= 0)) {
+		ret = -1;
+	}
+
+	close(fd);
+	return ret;
+}
+
+static int ibs_ioctl_test(void)
+{
+	unsigned long i;
+	int ret = 0;
+	int r;
+
+	pr_debug("\nIBS ioctl() tests:\n");
+	pr_debug("------------------\n");
+
+	pr_debug("Fetch PMU tests\n");
+	for (i = 0; i < ARRAY_SIZE(fetch_ioctl); i++) {
+		r = __ibs_ioctl_test(IBS_FETCH, &fetch_ioctl[i]);
+
+		pr_debug("ioctl(%s = 0x%-7lx): %s\n",
+			 fetch_ioctl[i].freq ? "freq  " : "period",
+			 fetch_ioctl[i].period, r ? "Fail" : "Ok");
+		ret |= r;
+	}
+
+	pr_debug("Op PMU tests\n");
+	for (i = 0; i < ARRAY_SIZE(op_ioctl); i++) {
+		r = __ibs_ioctl_test(IBS_OP, &op_ioctl[i]);
+
+		pr_debug("ioctl(%s = 0x%-7lx): %s\n",
+			 op_ioctl[i].freq ? "freq  " : "period",
+			 op_ioctl[i].period, r ? "Fail" : "Ok");
+		ret |= r;
+	}
+
+	return ret;
+}
+
+static int ibs_freq_neg_test(void)
+{
+	struct perf_event_attr attr;
+	int fd;
+
+	pr_debug("\nIBS freq (negative) tests:\n");
+	pr_debug("--------------------------\n");
+
+	/*
+	 * Assuming perf_event_max_sample_rate <= 100000,
+	 * config: 0x300D40 ==> MaxCnt: 200000
+	 */
+	op_prepare_attr(&attr, 0x300D40, 1, 0);
+
+	/* CPU0, All processes */
+	fd = perf_event_open(&attr, -1, 0, -1, 0);
+	if (fd != -1) {
+		pr_debug("freq 1, sample_freq 200000: Fail\n");
+		close(fd);
+		return -1;
+	}
+
+	pr_debug("freq 1, sample_freq 200000: Ok\n");
+
+	return 0;
+}
+
+static int __ibs_l3missonly_test(char *perf, int ibs_type, int *nr_samples, int min_period)
+{
+	struct perf_event_attr attr;
+	int ret = 0;
+	void *rb;
+	int fd;
+
+	if (ibs_type == IBS_FETCH)
+		fetch_prepare_attr(&attr, 0x800000000000000UL, 1, 10000);
+	else
+		op_prepare_attr(&attr, 0x10000, 1, 10000);
+
+	/* CPU0, All processes */
+	fd = perf_event_open(&attr, -1, 0, -1, 0);
+	if (fd == -1) {
+		pr_debug("perf_event_open() failed. [%m]\n");
+		return -1;
+	}
+
+	rb = mmap(NULL, PERF_MMAP_TOTAL_SIZE, PROT_READ | PROT_WRITE,
+		  MAP_SHARED, fd, 0);
+	if (rb == MAP_FAILED) {
+		pr_debug("mmap() failed. [%m]\n");
+		close(fd);
+		return -1;
+	}
+
+	ioctl(fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+
+	dummy_workload_2(perf);
+
+	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+
+	ret = rb_drain_samples(rb, min_period, nr_samples, period_higher);
+
+	munmap(rb, PERF_MMAP_TOTAL_SIZE);
+	close(fd);
+	return ret;
+}
+
+static int ibs_l3missonly_test(char *perf)
+{
+	int nr_samples = 0;
+	int ret = 0;
+	int r = 0;
+
+	pr_debug("\nIBS L3MissOnly test: (takes a while)\n");
+	pr_debug("--------------------\n");
+
+	if (perf_pmu__has_format(fetch_pmu, "l3missonly")) {
+		nr_samples = 0;
+		r = __ibs_l3missonly_test(perf, IBS_FETCH, &nr_samples, 0x10);
+		/*
+		 * Although nr_samples == 0 is reported as Fail here,
+		 * the failure status is not cascaded up because, we
+		 * can not decide whether test really failed or not
+		 * without actual samples.
+		 */
+		pr_debug("Fetch L3MissOnly: %-4s (nr_samples: %d)\n",
+			 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
+		ret |= r;
+	}
+
+	if (perf_pmu__has_format(op_pmu, "l3missonly")) {
+		nr_samples = 0;
+		r = __ibs_l3missonly_test(perf, IBS_OP, &nr_samples, 0x90);
+		/*
+		 * Although nr_samples == 0 is reported as Fail here,
+		 * the failure status is not cascaded up because, we
+		 * can not decide whether test really failed or not
+		 * without actual samples.
+		 */
+		pr_debug("Op L3MissOnly:    %-4s (nr_samples: %d)\n",
+			 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
+		ret |= r;
+	}
+
+	return ret;
+}
+
+static unsigned int get_perf_event_max_sample_rate(void)
+{
+	unsigned int max_sample_rate = 100000;
+	FILE *fp;
+	int ret;
+
+	fp = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
+	if (!fp) {
+		pr_debug("Can't open perf_event_max_sample_rate. Asssuming %d\n",
+			 max_sample_rate);
+		goto out;
+	}
+
+	ret = fscanf(fp, "%d", &max_sample_rate);
+	if (ret == EOF) {
+		pr_debug("Can't read perf_event_max_sample_rate. Assuming 100000\n");
+		max_sample_rate = 100000;
+	}
+	fclose(fp);
+
+out:
+	return max_sample_rate;
+}
+
+int test__amd_ibs_period(struct test_suite *test __maybe_unused,
+			 int subtest __maybe_unused)
+{
+	char perf[PATH_MAX] = {'\0'};
+	int ret = TEST_OK;
+
+	perf_event_max_sample_rate = get_perf_event_max_sample_rate();
+	fetch_pmu = perf_pmus__find("ibs_fetch");
+	op_pmu = perf_pmus__find("ibs_op");
+
+	if (!x86__is_amd_cpu() || !fetch_pmu || !op_pmu)
+		return TEST_SKIP;
+
+	perf_exe(perf, sizeof(perf));
+
+	if (sched_affine(0))
+		return TEST_FAIL;
+
+	/*
+	 * Perf event can be opened in two modes:
+	 * 1 Freq mode
+	 *   perf_event_attr->freq = 1, ->sample_freq = <frequency>
+	 * 2 Sample period mode
+	 *   perf_event_attr->freq = 0, ->sample_period = <period>
+	 *
+	 * Instead of using above interface, IBS event in 'sample period mode'
+	 * can also be opened by passing <period> value directly in a MaxCnt
+	 * bitfields of perf_event_attr->config. Test this IBS specific special
+	 * interface.
+	 */
+	if (ibs_config_test())
+		ret = TEST_FAIL;
+
+	/*
+	 * IBS Fetch and Op PMUs have HW constraints on minimum sample period.
+	 * Also, sample period value must be in multiple of 0x10. Test that IBS
+	 * driver honors HW constraints for various possible values in Freq as
+	 * well as Sample Period mode IBS events.
+	 */
+	if (ibs_period_constraint_test())
+		ret = TEST_FAIL;
+
+	/*
+	 * Test ioctl() with various sample period values for IBS event.
+	 */
+	if (ibs_ioctl_test())
+		ret = TEST_FAIL;
+
+	/*
+	 * Test that opening of freq mode IBS event fails when the freq value
+	 * is passed through ->config, not explicitly in ->sample_freq. Also
+	 * use high freq value (beyond perf_event_max_sample_rate) to test IBS
+	 * driver do not bypass perf_event_max_sample_rate checks.
+	 */
+	if (ibs_freq_neg_test())
+		ret = TEST_FAIL;
+
+	/*
+	 * L3MissOnly is a post-processing filter, i.e. IBS HW checks for L3
+	 * Miss at the completion of the tagged uOp. The sample is discarded
+	 * if the tagged uOp did not cause L3Miss. Also, IBS HW internally
+	 * resets CurCnt to a small pseudo-random value and resumes counting.
+	 * A new uOp is tagged once CurCnt reaches to MaxCnt. But the process
+	 * repeats until the tagged uOp causes an L3 Miss.
+	 *
+	 * With the freq mode event, the next sample period is calculated by
+	 * generic kernel on every sample to achieve desired freq of samples.
+	 *
+	 * Since the number of times HW internally reset CurCnt and the pseudo-
+	 * random value of CurCnt for all those occurrences are not known to SW,
+	 * the sample period adjustment by kernel goes for a toes for freq mode
+	 * IBS events. Kernel will set very small period for the next sample if
+	 * the window between current sample and prev sample is too high due to
+	 * multiple samples being rejected by IBS internally.
+	 *
+	 * Test that IBS sample period constraints are honored when L3MissOnly
+	 * is ON.
+	 */
+	if (ibs_l3missonly_test(perf))
+		ret = TEST_FAIL;
+
+	return ret;
+}
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index a216a5d172ed..bfee2432515b 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -25,6 +25,7 @@ DEFINE_SUITE("x86 bp modify", bp_modify);
 #endif
 DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
 DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
+DEFINE_SUITE_EXCLUSIVE("AMD IBS sample period", amd_ibs_period);
 static struct test_case hybrid_tests[] = {
 	TEST_CASE_REASON("x86 hybrid event parsing", hybrid, "not hybrid"),
 	{ .name = NULL, }
@@ -50,6 +51,7 @@ struct test_suite *arch_tests[] = {
 #endif
 	&suite__x86_sample_parsing,
 	&suite__amd_ibs_via_core_pmu,
+	&suite__amd_ibs_period,
 	&suite__hybrid,
 	NULL,
 };
-- 
2.43.0

