Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2101.outbound.protection.outlook.com [40.107.237.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537D1F4C9F;
	Thu, 13 Mar 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896766; cv=fail; b=HXb7PR/mPEUFRTvfWclNV6Rt6cqOFPjIg2ClDJCDDjlHqcv8IfKdrfKNgjBu5RL7lQVEekhHJdTzob8CaEHQ5j5BaDux0g8JFHKv1uqFuOcDlxcrdwjmwm0D3VkEabauxfBPSwAmM3Al07TR/dCUjP/Y6+t2Ok/ePrNmFTyCrVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896766; c=relaxed/simple;
	bh=brqunsE2mck7yAcTyI7FIMkBJt2n7szU+bbXXNDyJhk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=raNylF9XugfyHu9gXS8w/DkqOQKgNEZaD8AbqMLX/xM53JKjqajFgbT8g/pWK2PBKpPXWP+ZC+iZuzqZLSIS/SRbgxVhTgwb3P2NlMmQ9sSD0+lVChS7vqhOkBSi9t5H1+zeoCxYjacfs3wWfs04+UElZp0mrjJTXwCMCdoZVec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=m1sm4b1D; arc=fail smtp.client-ip=40.107.237.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="m1sm4b1D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFgSPawHY6parFkLnoYuoBh93I5Q1ihOfoVy4FKLoD251hFtnpGs8+cQF09gpdIzv5FQ6B4inuKTsvbi1RjxJ+AmPuZ2CxeHz70i5Pan8ALeXE2LgUcISzYbv/JVGdnVva4xFkbQbpR3mVWNaqtRQg+pFZq8GceT4xKFy0Nho3MdXDYuydBTsGzIWgMgs0Kr983V+yYSPUX+sVXKSkJXsxXfxg02Ns4YGrC1AvsI2gyctT7lOwBz3E9RWNyF5Ydp3Q4jNohBQKRjI/v9AZ8tC+/MsBK+OdJBcFFIn6fmToBmZOD+lwmSRY71vw3OBtC+6RYsAqdz893DW0zHwNQNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxz3jYQkOVek2CToo7fVFpoZ5PO2+9EgkRvmienlXow=;
 b=fPL3b1oDxIeXn5zUgbioQWGaI+ao5q0C27+m1wzPMmWC83PvqAFSFf1ZcJ1cBBfuId2tOTM8dhg+82b3mrCaGCI2pUQX7yL2nVJgHLS9ms1PTEyHwcMV5JHHtXNzq/WlIZ+TWC/cK1Fe0OYsa4UQWIJLUQbS1ft2zczm6gnDvrdWr4QrRst+hoCG/qE5XWaxDkg6Q5Duy5NcCNdRc7Tb69C6SwGn1vzI7s//7caROPXpHwBRGlJ5x9v7nR0dgVdBYTvThElJOuD6r+PKKEoO+9d0n1B/dv+XG6pJtH8q3HyVS9el6umUsnPXQhteRrmDfA8V0lsYXd37rcZRb1Jdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxz3jYQkOVek2CToo7fVFpoZ5PO2+9EgkRvmienlXow=;
 b=m1sm4b1DuTtBT7iefNsC05l+Ow0bhvfIP0IhPC530aYapRCdL34oRf/1Y9/AUahkjLRtGCwDNAlSQxtf0sytuIq6wBZMxCsMo0JWl0H0E0cvvBX4YSBZjTyoBbb+PqKEUH9C98l5I8MwKmEbZ7j9O11x7BEs6E31CUR/68XfMHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 SJ0PR01MB7415.prod.exchangelabs.com (2603:10b6:a03:3d2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Thu, 13 Mar 2025 20:12:39 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 20:12:39 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf vendor events arm64: AmpereOne/AmpereOneX: Add a new errata and fix metrics calculations
Date: Thu, 13 Mar 2025 20:15:57 +0000
Message-ID: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::21) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|SJ0PR01MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: afe1b8c9-8482-4243-da6b-08dd626b67a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IloF7UsYP/6+qZqkrPZsnzficz1MGsQVYDx4mdOkf4lx5RhV45lO1rFIIMxf?=
 =?us-ascii?Q?4bffcT8Dty7SVQRs1dWm7Y75uyZqthxizFNADjYwxNisxbZ5Mc7DWvb5zdDc?=
 =?us-ascii?Q?+P8G+5/kJg+kizuDpDTOy3w51PEQ5lLEYV89N1q11jdge0O3Sjjs2KSWgHMr?=
 =?us-ascii?Q?9+PGIZ9PskiF2FKJRpuo6no0XK54+XmoD6f5OmssqpRIeYMhnyJb6uwBCRxH?=
 =?us-ascii?Q?PXsFTf7m4CAElUjxckfH9HJqJvxtuBHISaLVLdMpZzjaGGwtpDeVPjaH38Hq?=
 =?us-ascii?Q?5zz0YQwOUasQKXMQaY/tLRDWe4g6/SQFoTl+xvh4aewW6N9Nz5d7yvr22zdV?=
 =?us-ascii?Q?8ynIkdR+tsAoPi+D7f4VyNnxOVRN5QuKPHWJUw9vv6YQTqJ2wPGyKrrrO8ql?=
 =?us-ascii?Q?1R56CJbQin6EmXNEcVQbqRx/US+g4EDlQRzQEFWCC+PVjiw17n1FuUwosYhE?=
 =?us-ascii?Q?4nO1JbkNsvLrp9f8BiKJZV0K9rU7z0RCk+7tRLBiFfYNFtdBVtFBIwBMobdp?=
 =?us-ascii?Q?IlNCqqKCFbzIJnKYBNu+3eSx4Na7Jz1JRywoyMFt3Qq6a3WeqOkybbxXNp1p?=
 =?us-ascii?Q?irEHqtbXYfQbyNPDsaOZ/Y+ggoxwwjcB8GyqYuHX7NoPnavt06HOk71pChoh?=
 =?us-ascii?Q?ARzRHQAmifhW5CQEsO6bNzSOngKIwcySqlpidTE0+nFnxqgiKsWPvNlhY8XY?=
 =?us-ascii?Q?7l7Sha7eMMH4ri3490/yGbhY9LsD6ckqD7IQIRknrGFT8XulXPaxra7r8us3?=
 =?us-ascii?Q?HVm7BrO56kACl0WSVVmtqhDV1CMzNm7KHQR4Kuss2d5qBtNPl4Yo2yigmEZN?=
 =?us-ascii?Q?hibAnouSnOJRzag7RYZIc4UgOHMvcP6hAgBKvw2Gghq8PuUBMXLNOt+3vi7m?=
 =?us-ascii?Q?26ZKcdlPi5p8uDZLM0QrKxlNz1zuwKRaV4pE2PLKyUkpRHs7AlLU4kRTI8v5?=
 =?us-ascii?Q?ZmfhlgCShgtIPpSM0hQSiWhbAnfyyVTUudz06E4je4G4WcQeP/ckx7N7Lje+?=
 =?us-ascii?Q?AWayirw0H8CshDxMrEMn8l822ZkpxPmAHiTFKPsxXKWCEiyc3AId/0U/UoOv?=
 =?us-ascii?Q?R1RgLOXqOr54YnQ0jHuN6wUWIb/GVLeoAM9wtUtqA//Mmemmir2s56kCBX6Z?=
 =?us-ascii?Q?3cTtBmzjh/BH0IPuKlfBuC7fetwoE5a1EnoYBEfUmjfJh68P+cPzlssAkGCP?=
 =?us-ascii?Q?g8kzN7QtS3NKjdEcOUOPA3/871XqWmqphExTGpvbKuDT1Zk2UfI0caW0EFlD?=
 =?us-ascii?Q?LMzBVLCW68G8CsVF7ptzpLdlHmYr/X9Dy8uEblsrxWN30cM/eQY+ttLgP/lt?=
 =?us-ascii?Q?1hlqjgqY3349p+x1QGF0qM5fmgxy0GnAeES0reshbsAGUB65DbGkjI7wf5am?=
 =?us-ascii?Q?qd8jfZP6H9pf9QHkkFhXobFRy44FX+tx67/aq4dcI/6blhXvnCpic+RkHx3b?=
 =?us-ascii?Q?Yj3nwVx/EEqkQawD0mwAyCYw2uxmdFwvDHnGP7SmyIo1l7LEboknSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Ik6F6YlsjGnwcMYeGvUVScNdAgAhZCZKzGSLC+z/yaa4d2VSjZMWJLdKzFz?=
 =?us-ascii?Q?bzF3DwDJhJcSfnAn2Y4kIMyR6Kn7rMPtyNwT+rNLjq0sQsgJPohPvtV4fOvd?=
 =?us-ascii?Q?9Nzm3Mey6+WcEwyWcDW9Hd6PujJuJBFWqy2lDOYSFoRkJShgV4ism9tq6O+k?=
 =?us-ascii?Q?fqRfC9lzwokayBefpKo3MZAkClHBjemyE3dhw1obioRVZfHqMH4nF0wPWKhd?=
 =?us-ascii?Q?YbOuyt4Impmq2MMnWyUgDeKmJ5ml3wDnJxjiAuTTeFdU1sBvYlMsnbQ1P2mh?=
 =?us-ascii?Q?8HFhAkqRyn2jYkBolUd2OXgPqmeFhuQ5dESJL4M/v85JC6CwdvklwDwAy+Wa?=
 =?us-ascii?Q?j+O3UnY/45FKaRg0IRYHd4OVwXD7T/lV1fhKJnaevVm4XlzR3B8REYWpAvX5?=
 =?us-ascii?Q?18IdcXm/8aMotorq5OO0IXoxA1vpVrOf1g770lO7I2jtmDjXKVkn9FzJtDuA?=
 =?us-ascii?Q?3RqkwPVR6i9fiMqgdVXr5u8mYEMkwsHsQ500pFM3PjQTP6p3kQHZdjCEkpAR?=
 =?us-ascii?Q?UJKYwIYRQwFmk5ljRFS3w792f3O6TGrMsXeCBRUHEPBnHvMk/FA4oLUMyYoa?=
 =?us-ascii?Q?F8R83IiK2Hta50JPt30JF8J/C5VbjWZ4YI1ZuV13JlZpL6XwHjvb3ExHfjny?=
 =?us-ascii?Q?RyaIXjSqmoFuGoQQfkKgpsYAGItfi3YfX72agWiR0uG4PysW97rWWfb631Jx?=
 =?us-ascii?Q?qOWqvdMPKWeYIkQR+gcCf9aENwOSDqKSZD7ynI2zBWDil8qiSQNCj3/GNH5p?=
 =?us-ascii?Q?9BFpeheZZbQxCxDnaiv0wM1uZ+tD830671pECG99fefJREjvSShszjPMhU1x?=
 =?us-ascii?Q?+csj0hpoBnrjRf0To8P7S5RAfwrzy2xk24SvSfCw3xofFdApKNMPtrCdzj6O?=
 =?us-ascii?Q?5RyBzMTjxA5vSTghWo9K8OiN6MHWRwI5UuSoo+bXIjBloixEUXhhuEdXK8Dv?=
 =?us-ascii?Q?PhD971WAcnL2n4Ipm9BTg/4tARSL2elQoraSl8SQ1soZPBC8ncWzNVXnvzGQ?=
 =?us-ascii?Q?lyMgEF/6WEtXEBTpI01z1sitQJ2zrllG6bf7OfgQzDSAoBqFPEvlP0KQWx02?=
 =?us-ascii?Q?toIOhp6AQeEKcc9cDMHUOrMtP0Xqc1dAaD8OrLwGWftk5BeT9S/XrvYwHXiQ?=
 =?us-ascii?Q?MKVdCOvqq+Nd74mlr1jyhw55UqTbMY28Hros0mhEb+8TgLr/lhwl3N/xkFWW?=
 =?us-ascii?Q?SoiQJKqUGAm+tCzjMKDdavFoQyFNq+Hq3BUP1wDT5B2nb2/w+vztJGBcbKg1?=
 =?us-ascii?Q?uNDKgcXcsQ6x0IGDSWjwCGtpWUmDZjDLEX2EeMKnc+dyB2KKt1P+OvMEJZiJ?=
 =?us-ascii?Q?bX1tON8GDIvI4eYJmx69xRdybv9gg7xEbZCrhlryc87O9nM6fyuFIDkJwxyM?=
 =?us-ascii?Q?jus05STlTm+jbbbImlkA8NmK5cGm8bIFS00LZf1hTf/eRc5mSqpfP8iWPWy1?=
 =?us-ascii?Q?+JkW1LrU+TsEMQwjybPkJq33Hv7tQ/rZkX/PVpVrRxvtS/5gCiaZVxG+Zkk0?=
 =?us-ascii?Q?gcMDCe35+8RivsYR6XDDn0zi/ZhsqJswrYSMQtNXDlr6WYAwFjB5aWirDKm+?=
 =?us-ascii?Q?yAOdeNHlyV/v6HGI9e98WYdE+1hocgslUds2mOLSsRYjGmYt9ZY42/VpNAiP?=
 =?us-ascii?Q?itUGtTuAxscLvh8tGDCkjS8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe1b8c9-8482-4243-da6b-08dd626b67a5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 20:12:39.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUA1s3dWVbCy1+PNIq+vQndfwpxDeXBSN+xpotNGhx4JaDjmFM8Ho1tDp935kxtUR1FlWu26uizBq6ywniX2hn/CT82wlg4kXgyG9NzPkYKohzjw848utKX4PktjiOUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7415

Add an errata reference to a impacted event and fix metrics calculation
caused by a scaling issue.

Ilkka Koskinen (2):
  perf vendor events arm64: AmpereOne/AmpereOneX: Mark LD_RETIRED
    impacted by errata
  perf vendor events arm64 AmpereOneX: Fix frontend_bound calculation

 .../pmu-events/arch/arm64/ampere/ampereone/memory.json |  4 +++-
 .../arch/arm64/ampere/ampereonex/memory.json           |  4 +++-
 .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----
 3 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.47.0

