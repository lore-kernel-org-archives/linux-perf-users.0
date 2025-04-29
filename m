Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2227055C;
	Tue, 29 Apr 2025 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899286; cv=fail; b=ISAMYS3mlQHHPi8CDF2OI0zPhs7EXpaI4VHw+IWUMRT82JQqIisWh/qER4I0/5cdaPidm9QBRjB3oOoOezslzhB8mfoKCQXne1VItQgsVMGfTTfyF2psdq5n4glFMUw534Q03Wnd/SauVHNvOnGjQUCToM1U5UjIhfP7Ges3yl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899286; c=relaxed/simple;
	bh=hj6t1L7eVbSMtCpmS1WlQyHv3CMp+WFDyopf/mgMerg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgbDAXMdTrQM9Zc31KPDuTsNGxS6pHK5EuutM8j1gQLpcqRgBAieVdQqIYV5U7Zc5pxJ5BPfCE0a+EuOxMSoOafmUfdv3qc3tTPkxxFTlF1hkGaOJBa2QEJEFRpCvoIVvSjP2+ZdkYf3QfrmJbzCN3Qsx9j7HWw6ZLycDbq8a+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H6JBOzmv; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H6JBOzmv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe/xWuNyqViahd3pPrFvO0QFYkQZkJTY5w3j6/uC1URAtrksDOpw36U4ldkflyKZ/MlaxrOEXOqotflInV2KoOgSw/JnLEw1rR7cnncz3hBXBitKyIClfQF/t3s1xSXV4gBSbqtbT5M/dAmb5OqV9diP0l2sgVtBtnKnXTeRkKrDgpoL73Q+U1DsCOfLNPX51aiq1UdDiqfwhOOJ/GQ9Gj0uKGoMELyMURNCC7JuMIfJhSsUh+a7mV+cnqH6t+Cs3ogMt5aGjwHdRdrACCPEgqMk7VLyq9K1uNoNILSSaSfYxtCelhipbRY7GKKvr7ECUbxGLqR1mWadKqCQM18XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS2aoN5Xb2rm6HXXD74GZOYlJUYczs2p+AqGIjYgBtQ=;
 b=EwDGy+XSAyZjcU5Dyf3TmJYJ3Mu7Zc8G75ZnIPrGVrgNLuHXXuCbIgaQ0/LBg7nKRRqZ3f051ZJ0RhqXyGrNPg3wQoDqSmV+BirovoHA2ugtS1T4ELMjNmuttJ5mQUgcbk5GQuVwtJpBSsi/Snk0gLGq/I/pgYFA4K46oA3EzhUPgxjqFaRy7ZiYOarBT+H+Itg7nTTMgmAecjFKZUdrIntjuSmNCcJIns+cw3L504pO8dl7W9j4QqYUU1ck3DI4nWpDjaAxZvF8KXYV6mAPLaeeNAMOO87B0PiNB7ez+SoDJfJmBk6kA0njNLYOOyRM8opQxTy+TjAz6UqjkzRRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS2aoN5Xb2rm6HXXD74GZOYlJUYczs2p+AqGIjYgBtQ=;
 b=H6JBOzmvhbiO6/U+MBas5zQYsDk2roWKT0LSjtQcE4PuUjIX2p6UpMPQTSklO8XDg8mANmGHbtga8LoRTnI59kPcbzhu6arL/uNcqmYd0fpsNn2sDm5e1YmUZANMNjMbS8e2s7vIwTLDq7AoBKCtslojOfySeZqTHd7iLerJG7E=
Received: from CH0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:610:b0::33)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 04:01:16 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::21) by CH0PR03CA0028.outlook.office365.com
 (2603:10b6:610:b0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 29 Apr 2025 04:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Tue, 29 Apr 2025 04:01:16 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 23:00:46 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Joe Mario <jmario@redhat.com>, Stephane Eranian
	<eranian@google.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
	<irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v4 4/4] perf test amd ibs: Add sample period unit test
Date: Tue, 29 Apr 2025 03:59:38 +0000
Message-ID: <20250429035938.1301-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429035938.1301-1-ravi.bangoria@amd.com>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 401a4d5f-a40f-473d-b4dd-08dd86d27d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yYHLFKAMWEVmAOJFnhlVO1tjm+WKQiMh+RGxMJw1MQg/CE78Da/FMxeyhgYe?=
 =?us-ascii?Q?J5seLnyv1sctSClD13fSHfLNH/7+7b2tXBEvxD5Xe5GlrLNhJiWk9BsCCk7T?=
 =?us-ascii?Q?e+uqGgVyhcODyhk3uDSflNuW/zNmvYFfaboMkANWxy55gdp5+Z2ZTKDN2/zv?=
 =?us-ascii?Q?83gCK88+vv55JbXyag3r/QzGH8WzqSDXtwZPCLmroAsGAXkkajPvz3vMzdPK?=
 =?us-ascii?Q?tUQRW7pDEOExZ6Pggg3Oejg5vZlLSYUOQ31bNuVXTkndwtww+m0QMCpVk+SU?=
 =?us-ascii?Q?6gf39BL0Mc+j9q5Kylp1R3d4KbeHhsQdLB5qfUgTQv0MvATDoxILUAfHbFr0?=
 =?us-ascii?Q?ZZYyNnpHhkzW6MaYAPxM9rz1J/Yl8rToEboEDalHuAlRcbKdDXcNuphdfEVx?=
 =?us-ascii?Q?/QYG+pghb2r/A7DRbeOm9r/p5VHDC4uodA7u1GSMnVfMpwaaHlw4thrp2D8y?=
 =?us-ascii?Q?amWkFQSEBT9E95H/uUMeJTGuyhwA0eJ5UyrHEwB7ywydj39E5EVikxAhXeu/?=
 =?us-ascii?Q?LEMVVSmssnLjWbXRKzwCyV36bMtmXkqOx9MYFkbg1vd2uLX5nqnFDXQsmfRj?=
 =?us-ascii?Q?/UhD4jyrx0k9N0jav/DNRZKU43yRBL6RGpQEdiKTzUfBQritWvZ3LoSYUlbt?=
 =?us-ascii?Q?dylMGdkcEAPMRgxWEDyN9rqdLTRpPj6sw/fvQRfh9wvLzfVlLwfVE2lS4rH5?=
 =?us-ascii?Q?sZgkVIRP/9QYjCpsxmvS+IQRtw4YgQ66GPwf8iapcZVQM/Txojpp49UBogTD?=
 =?us-ascii?Q?C7msOMcC7HArd+cJka/h0GsiJUx+Hjs9Ps73NNqEBWZYr+Nbc//DBe6zxl3T?=
 =?us-ascii?Q?luymFdjacrqflybqKBhlTz7JN3qyD+OzCz93C1vKbk+o1bAdLFIBgeUIzGkA?=
 =?us-ascii?Q?4QocgW9bBOyCzzoR24VwYmeURdc+3/4oZAcRmGHnyAFdF365L0K28GOQSsSG?=
 =?us-ascii?Q?I4eC6mJh+ttDm34hnQu/MkDw5ptsP70t7+Q3JcK4ruqOaYWjQjk44ZhDh8/s?=
 =?us-ascii?Q?dPkAN8+aVH+KGBcoETc+FboeZlHvflM6jbQ4MWTIqf+5PuN92DBwad2BGMkT?=
 =?us-ascii?Q?lQrRyvYhZ8dNb5zU1Ps8lEBOgHFRljRAyVHTzZ6W26JKYl3Ed/kungAAYdLC?=
 =?us-ascii?Q?E9El6ALd3td04C5CMBI3TwXnj6sbH+u/KKFgO26kYqy+k4bFXJaivnTMUaqt?=
 =?us-ascii?Q?/AKha1EwYIob8OdQaHrOaegwNuuF4eTMC2lYDskofdOkiTK6nXIUUEgdkItA?=
 =?us-ascii?Q?c1Rr2lJdx8TtCQ/drNEBCmIvxusLuvNMKM968VFz0/N/rzjqjX7EPbS3UJgx?=
 =?us-ascii?Q?EnT7h8ItQfZ4uiJcMzCVVVnlfuq1b/OdquLtu5MUjVcpllzIf55GmN3vUWt1?=
 =?us-ascii?Q?NvJ0QECUFlQDRQDpCFts6+7ipD0rXPQEuqQDu90VcFo3LXExsY9FsDl1PhNQ?=
 =?us-ascii?Q?dazOU3cANzsrxMFIobvHtR0gSbzWWZPiUR1+ux/6UOLSeY0qUOFkhsuE9lUk?=
 =?us-ascii?Q?IWLvcx6DfJ1icW55uRyjxQxZcrWawwrOqNqw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 04:01:16.4317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401a4d5f-a40f-473d-b4dd-08dd86d27d99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

IBS Fetch and IBS Op PMUs has various constraints on supported sample
periods. Add perf unit tests to test those.

Running it in parallel with other tests causes intermittent failures.
Mark it exclusive to force it to run sequentially. Sample output on a
Zen5 machine:

Without kernel fixes:

  $ sudo ./perf test -vv 112
  112: AMD IBS sample period:
  --- start ---
  test child forked, pid 8774
  Using CPUID AuthenticAMD-26-2-1

  IBS config tests:
  -----------------
  Fetch PMU tests:
  0xffff            : Ok   (nr samples: 1078)
  0x1000            : Ok   (nr samples: 17030)
  0xff              : Ok   (nr samples: 41068)
  0x1               : Ok   (nr samples: 40543)
  0x0               : Ok
  0x10000           : Ok
  Op PMU tests:
  0x0               : Ok
  0x1               : Fail
  0x8               : Fail
  0x9               : Ok   (nr samples: 40543)
  0xf               : Ok   (nr samples: 40543)
  0x1000            : Ok   (nr samples: 18736)
  0xffff            : Ok   (nr samples: 1168)
  0x10000           : Ok
  0x100000          : Fail (nr samples: 14)
  0xf00000          : Fail (nr samples: 1)
  0xf0ffff          : Fail (nr samples: 1)
  0x1f0ffff         : Fail (nr samples: 1)
  0x7f0ffff         : Fail (nr samples: 0)
  0x8f0ffff         : Ok
  0x17f0ffff        : Ok

  IBS sample period constraint tests:
  -----------------------------------
  Fetch PMU test:
  freq 0, sample_freq         0: Ok
  freq 0, sample_freq         1: Fail
  freq 0, sample_freq        15: Fail
  freq 0, sample_freq        16: Ok   (nr samples: 1604)
  freq 0, sample_freq        17: Ok   (nr samples: 1604)
  freq 0, sample_freq       143: Ok   (nr samples: 1604)
  freq 0, sample_freq       144: Ok   (nr samples: 1604)
  freq 0, sample_freq       145: Ok   (nr samples: 1604)
  freq 0, sample_freq      1234: Ok   (nr samples: 1566)
  freq 0, sample_freq      4103: Ok   (nr samples: 1119)
  freq 0, sample_freq     65520: Ok   (nr samples: 2264)
  freq 0, sample_freq     65535: Ok   (nr samples: 2263)
  freq 0, sample_freq     65552: Ok   (nr samples: 1166)
  freq 0, sample_freq   8388607: Ok   (nr samples: 268)
  freq 0, sample_freq 268435455: Ok   (nr samples: 8)
  freq 1, sample_freq         0: Ok
  freq 1, sample_freq         1: Ok   (nr samples: 4)
  freq 1, sample_freq        15: Ok   (nr samples: 4)
  freq 1, sample_freq        16: Ok   (nr samples: 4)
  freq 1, sample_freq        17: Ok   (nr samples: 4)
  freq 1, sample_freq       143: Ok   (nr samples: 5)
  freq 1, sample_freq       144: Ok   (nr samples: 5)
  freq 1, sample_freq       145: Ok   (nr samples: 5)
  freq 1, sample_freq      1234: Ok   (nr samples: 7)
  freq 1, sample_freq      4103: Ok   (nr samples: 35)
  freq 1, sample_freq     65520: Ok   (nr samples: 642)
  freq 1, sample_freq     65535: Ok   (nr samples: 636)
  freq 1, sample_freq     65552: Ok   (nr samples: 651)
  freq 1, sample_freq   8388607: Ok
  Op PMU test:
  freq 0, sample_freq         0: Ok
  freq 0, sample_freq         1: Fail
  freq 0, sample_freq        15: Fail
  freq 0, sample_freq        16: Fail
  freq 0, sample_freq        17: Fail
  freq 0, sample_freq       143: Fail
  freq 0, sample_freq       144: Ok   (nr samples: 1604)
  freq 0, sample_freq       145: Ok   (nr samples: 1604)
  freq 0, sample_freq      1234: Ok   (nr samples: 1604)
  freq 0, sample_freq      4103: Ok   (nr samples: 1604)
  freq 0, sample_freq     65520: Ok   (nr samples: 2227)
  freq 0, sample_freq     65535: Ok   (nr samples: 2296)
  freq 0, sample_freq     65552: Ok   (nr samples: 2213)
  freq 0, sample_freq   8388607: Ok   (nr samples: 250)
  freq 0, sample_freq 268435455: Ok   (nr samples: 8)
  freq 1, sample_freq         0: Ok
  freq 1, sample_freq         1: Fail (nr samples: 4)
  freq 1, sample_freq        15: Fail (nr samples: 4)
  freq 1, sample_freq        16: Fail (nr samples: 4)
  freq 1, sample_freq        17: Fail (nr samples: 4)
  freq 1, sample_freq       143: Fail (nr samples: 5)
  freq 1, sample_freq       144: Fail (nr samples: 5)
  freq 1, sample_freq       145: Fail (nr samples: 5)
  freq 1, sample_freq      1234: Fail (nr samples: 8)
  freq 1, sample_freq      4103: Fail (nr samples: 33)
  freq 1, sample_freq     65520: Fail (nr samples: 546)
  freq 1, sample_freq     65535: Fail (nr samples: 544)
  freq 1, sample_freq     65552: Fail (nr samples: 555)
  freq 1, sample_freq   8388607: Ok

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
  Fetch L3MissOnly: Fail (nr_samples: 1213)
  Op L3MissOnly:    Ok   (nr_samples: 1193)
  ---- end(-1) ----
  112: AMD IBS sample period                                           : FAILED!

With kernel fixes:

  $ sudo ./perf test -vv 112
  112: AMD IBS sample period:
  --- start ---
  test child forked, pid 6939
  Using CPUID AuthenticAMD-26-2-1

  IBS config tests:
  -----------------
  Fetch PMU tests:
  0xffff            : Ok   (nr samples: 969)
  0x1000            : Ok   (nr samples: 15540)
  0xff              : Ok   (nr samples: 40555)
  0x1               : Ok   (nr samples: 40543)
  0x0               : Ok
  0x10000           : Ok
  Op PMU tests:
  0x0               : Ok
  0x1               : Ok
  0x8               : Ok
  0x9               : Ok   (nr samples: 40543)
  0xf               : Ok   (nr samples: 40543)
  0x1000            : Ok   (nr samples: 19156)
  0xffff            : Ok   (nr samples: 1169)
  0x10000           : Ok
  0x100000          : Ok   (nr samples: 1151)
  0xf00000          : Ok   (nr samples: 76)
  0xf0ffff          : Ok   (nr samples: 73)
  0x1f0ffff         : Ok   (nr samples: 33)
  0x7f0ffff         : Ok   (nr samples: 10)
  0x8f0ffff         : Ok
  0x17f0ffff        : Ok

  IBS sample period constraint tests:
  -----------------------------------
  Fetch PMU test:
  freq 0, sample_freq         0: Ok
  freq 0, sample_freq         1: Ok
  freq 0, sample_freq        15: Ok
  freq 0, sample_freq        16: Ok   (nr samples: 1203)
  freq 0, sample_freq        17: Ok   (nr samples: 1604)
  freq 0, sample_freq       143: Ok   (nr samples: 1604)
  freq 0, sample_freq       144: Ok   (nr samples: 1604)
  freq 0, sample_freq       145: Ok   (nr samples: 1604)
  freq 0, sample_freq      1234: Ok   (nr samples: 1604)
  freq 0, sample_freq      4103: Ok   (nr samples: 1343)
  freq 0, sample_freq     65520: Ok   (nr samples: 2254)
  freq 0, sample_freq     65535: Ok   (nr samples: 2136)
  freq 0, sample_freq     65552: Ok   (nr samples: 1158)
  freq 0, sample_freq   8388607: Ok   (nr samples: 257)
  freq 0, sample_freq 268435455: Ok   (nr samples: 8)
  freq 1, sample_freq         0: Ok
  freq 1, sample_freq         1: Ok   (nr samples: 4)
  freq 1, sample_freq        15: Ok   (nr samples: 4)
  freq 1, sample_freq        16: Ok   (nr samples: 4)
  freq 1, sample_freq        17: Ok   (nr samples: 4)
  freq 1, sample_freq       143: Ok   (nr samples: 5)
  freq 1, sample_freq       144: Ok   (nr samples: 5)
  freq 1, sample_freq       145: Ok   (nr samples: 5)
  freq 1, sample_freq      1234: Ok   (nr samples: 8)
  freq 1, sample_freq      4103: Ok   (nr samples: 34)
  freq 1, sample_freq     65520: Ok   (nr samples: 458)
  freq 1, sample_freq     65535: Ok   (nr samples: 628)
  freq 1, sample_freq     65552: Ok   (nr samples: 396)
  freq 1, sample_freq   8388607: Ok
  Op PMU test:
  freq 0, sample_freq         0: Ok
  freq 0, sample_freq         1: Ok
  freq 0, sample_freq        15: Ok
  freq 0, sample_freq        16: Ok
  freq 0, sample_freq        17: Ok
  freq 0, sample_freq       143: Ok
  freq 0, sample_freq       144: Ok   (nr samples: 1604)
  freq 0, sample_freq       145: Ok   (nr samples: 1604)
  freq 0, sample_freq      1234: Ok   (nr samples: 1604)
  freq 0, sample_freq      4103: Ok   (nr samples: 1604)
  freq 0, sample_freq     65520: Ok   (nr samples: 2250)
  freq 0, sample_freq     65535: Ok   (nr samples: 2158)
  freq 0, sample_freq     65552: Ok   (nr samples: 2296)
  freq 0, sample_freq   8388607: Ok   (nr samples: 243)
  freq 0, sample_freq 268435455: Ok   (nr samples: 6)
  freq 1, sample_freq         0: Ok
  freq 1, sample_freq         1: Ok   (nr samples: 4)
  freq 1, sample_freq        15: Ok   (nr samples: 4)
  freq 1, sample_freq        16: Ok   (nr samples: 4)
  freq 1, sample_freq        17: Ok   (nr samples: 4)
  freq 1, sample_freq       143: Ok   (nr samples: 4)
  freq 1, sample_freq       144: Ok   (nr samples: 5)
  freq 1, sample_freq       145: Ok   (nr samples: 4)
  freq 1, sample_freq      1234: Ok   (nr samples: 6)
  freq 1, sample_freq      4103: Ok   (nr samples: 27)
  freq 1, sample_freq     65520: Ok   (nr samples: 542)
  freq 1, sample_freq     65535: Ok   (nr samples: 550)
  freq 1, sample_freq     65552: Ok   (nr samples: 552)
  freq 1, sample_freq   8388607: Ok

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
  Fetch L3MissOnly: Ok   (nr_samples: 1301)
  Op L3MissOnly:    Ok   (nr_samples: 1590)
  ---- end(0) ----
  112: AMD IBS sample period                                           : Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/include/arch-tests.h   |    1 +
 tools/perf/arch/x86/tests/Build            |    1 +
 tools/perf/arch/x86/tests/amd-ibs-period.c | 1001 ++++++++++++++++++++
 tools/perf/arch/x86/tests/arch-tests.c     |    2 +
 4 files changed, 1005 insertions(+)
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
index 86262c720857..5e00cbfd2d56 100644
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
index 000000000000..0cf3656e4b9b
--- /dev/null
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -0,0 +1,1001 @@
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
+	else if (count > 10000000)
+		count = 10000000;
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
+			       unsigned long long config, int freq,
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
+	{ .freq = 0, .sample_freq =         0, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 0, .sample_freq =         1, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 0, .sample_freq =       0xf, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 0, .sample_freq =      0x10, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 0, .sample_freq =      0x11, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 0, .sample_freq =      0x8f, .ret = FD_SUCCESS, .period =      0x80 },
+	{ .freq = 0, .sample_freq =      0x90, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 0, .sample_freq =      0x91, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 0, .sample_freq =     0x4d2, .ret = FD_SUCCESS, .period =     0x4d0 },
+	{ .freq = 0, .sample_freq =    0x1007, .ret = FD_SUCCESS, .period =    0x1000 },
+	{ .freq = 0, .sample_freq =    0xfff0, .ret = FD_SUCCESS, .period =    0xfff0 },
+	{ .freq = 0, .sample_freq =    0xffff, .ret = FD_SUCCESS, .period =    0xfff0 },
+	{ .freq = 0, .sample_freq =   0x10010, .ret = FD_SUCCESS, .period =   0x10010 },
+	{ .freq = 0, .sample_freq =  0x7fffff, .ret = FD_SUCCESS, .period =  0x7ffff0 },
+	{ .freq = 0, .sample_freq = 0xfffffff, .ret = FD_SUCCESS, .period = 0xffffff0 },
+	{ .freq = 1, .sample_freq =         0, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 1, .sample_freq =         1, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =       0xf, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =      0x10, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =      0x11, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =      0x8f, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =      0x90, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =      0x91, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =     0x4d2, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =    0x1007, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =    0xfff0, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =    0xffff, .ret = FD_SUCCESS, .period =      0x10 },
+	{ .freq = 1, .sample_freq =   0x10010, .ret = FD_SUCCESS, .period =      0x10 },
+	/* ret=FD_ERROR because freq > default perf_event_max_sample_rate (100000) */
+	{ .freq = 1, .sample_freq =  0x7fffff, .ret = FD_ERROR,   .period =        -1 },
+};
+
+struct ibs_period op_period[] = {
+	{ .freq = 0, .sample_freq =         0, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 0, .sample_freq =         1, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 0, .sample_freq =       0xf, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 0, .sample_freq =      0x10, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 0, .sample_freq =      0x11, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 0, .sample_freq =      0x8f, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 0, .sample_freq =      0x90, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 0, .sample_freq =      0x91, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 0, .sample_freq =     0x4d2, .ret = FD_SUCCESS, .period =     0x4d0 },
+	{ .freq = 0, .sample_freq =    0x1007, .ret = FD_SUCCESS, .period =    0x1000 },
+	{ .freq = 0, .sample_freq =    0xfff0, .ret = FD_SUCCESS, .period =    0xfff0 },
+	{ .freq = 0, .sample_freq =    0xffff, .ret = FD_SUCCESS, .period =    0xfff0 },
+	{ .freq = 0, .sample_freq =   0x10010, .ret = FD_SUCCESS, .period =   0x10010 },
+	{ .freq = 0, .sample_freq =  0x7fffff, .ret = FD_SUCCESS, .period =  0x7ffff0 },
+	{ .freq = 0, .sample_freq = 0xfffffff, .ret = FD_SUCCESS, .period = 0xffffff0 },
+	{ .freq = 1, .sample_freq =         0, .ret = FD_ERROR,   .period =        -1 },
+	{ .freq = 1, .sample_freq =         1, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =       0xf, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =      0x10, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =      0x11, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =      0x8f, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =      0x90, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =      0x91, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =     0x4d2, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =    0x1007, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =    0xfff0, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =    0xffff, .ret = FD_SUCCESS, .period =      0x90 },
+	{ .freq = 1, .sample_freq =   0x10010, .ret = FD_SUCCESS, .period =      0x90 },
+	/* ret=FD_ERROR because freq > default perf_event_max_sample_rate (100000) */
+	{ .freq = 1, .sample_freq =  0x7fffff, .ret = FD_ERROR,   .period =        -1 },
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
+	if (period->freq && period->sample_freq > perf_event_max_sample_rate)
+		period->ret = FD_ERROR;
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
+			pr_debug("freq %d, sample_freq %9ld: %-4s\n",
+				 fetch_period[i].freq, fetch_period[i].sample_freq,
+				 !r ? "Ok" : "Fail");
+		} else {
+			/*
+			 * Although nr_samples == 0 is reported as Fail here,
+			 * the failure status is not cascaded up because, we
+			 * can not decide whether test really failed or not
+			 * without actual samples.
+			 */
+			pr_debug("freq %d, sample_freq %9ld: %-4s (nr samples: %d)\n",
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
+			pr_debug("freq %d, sample_freq %9ld: %-4s\n",
+				 op_period[i].freq, op_period[i].sample_freq,
+				 !r ? "Ok" : "Fail");
+		} else {
+			/*
+			 * Although nr_samples == 0 is reported as Fail here,
+			 * the failure status is not cascaded up because, we
+			 * can not decide whether test really failed or not
+			 * without actual samples.
+			 */
+			pr_debug("freq %d, sample_freq %9ld: %-4s (nr samples: %d)\n",
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
+struct ibs_l3missonly {
+	/* Input */
+	int freq;
+	unsigned long sample_freq;
+
+	/* Expected output */
+	int ret;
+	unsigned long min_period;
+};
+
+struct ibs_l3missonly fetch_l3missonly = {
+	.freq = 1,
+	.sample_freq = 10000,
+	.ret = FD_SUCCESS,
+	.min_period = 0x10,
+};
+
+struct ibs_l3missonly op_l3missonly = {
+	.freq = 1,
+	.sample_freq = 10000,
+	.ret = FD_SUCCESS,
+	.min_period = 0x90,
+};
+
+static int __ibs_l3missonly_test(char *perf, int ibs_type, int *nr_samples,
+				 struct ibs_l3missonly *l3missonly)
+{
+	struct perf_event_attr attr;
+	int ret = 0;
+	void *rb;
+	int fd;
+
+	if (l3missonly->sample_freq > perf_event_max_sample_rate)
+		l3missonly->ret = FD_ERROR;
+
+	if (ibs_type == IBS_FETCH) {
+		fetch_prepare_attr(&attr, 0x800000000000000UL, l3missonly->freq,
+				   l3missonly->sample_freq);
+	} else {
+		op_prepare_attr(&attr, 0x10000, l3missonly->freq,
+				l3missonly->sample_freq);
+	}
+
+	/* CPU0, All processes */
+	fd = perf_event_open(&attr, -1, 0, -1, 0);
+	if (l3missonly->ret == FD_ERROR) {
+		if (fd != -1) {
+			close(fd);
+			return -1;
+		}
+		return 0;
+	}
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
+	ret = rb_drain_samples(rb, l3missonly->min_period, nr_samples, period_higher);
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
+		r = __ibs_l3missonly_test(perf, IBS_FETCH, &nr_samples, &fetch_l3missonly);
+		if (fetch_l3missonly.ret == FD_ERROR) {
+			pr_debug("Fetch L3MissOnly: %-4s\n", !r ? "Ok" : "Fail");
+		} else {
+			/*
+			 * Although nr_samples == 0 is reported as Fail here,
+			 * the failure status is not cascaded up because, we
+			 * can not decide whether test really failed or not
+			 * without actual samples.
+			 */
+			pr_debug("Fetch L3MissOnly: %-4s (nr_samples: %d)\n",
+				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
+		}
+		ret |= r;
+	}
+
+	if (perf_pmu__has_format(op_pmu, "l3missonly")) {
+		nr_samples = 0;
+		r = __ibs_l3missonly_test(perf, IBS_OP, &nr_samples, &op_l3missonly);
+		if (op_l3missonly.ret == FD_ERROR) {
+			pr_debug("Op L3MissOnly:    %-4s\n", !r ? "Ok" : "Fail");
+		} else {
+			/*
+			 * Although nr_samples == 0 is reported as Fail here,
+			 * the failure status is not cascaded up because, we
+			 * can not decide whether test really failed or not
+			 * without actual samples.
+			 */
+			pr_debug("Op L3MissOnly:    %-4s (nr_samples: %d)\n",
+				 (!r && nr_samples != 0) ? "Ok" : "Fail", nr_samples);
+		}
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
+	/*
+	 * Reading perf_event_max_sample_rate only once _might_ cause some
+	 * of the test to fail if kernel changes it after reading it here.
+	 */
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
+	 * multiple samples being discarded internally by IBS HW.
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

