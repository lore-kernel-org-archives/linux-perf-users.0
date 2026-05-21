Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C02E277026;
	Thu, 21 May 2026 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331755; cv=fail; b=sKrly6Ykuouiy/CxKQAuOq7Prbce0qeWV2Ehk3K+f/ciM+bYEyZ18yrezu1DuM0eKqWLBfYWDqr/OYTsC5bmItSCAI4VUBpQHv5r63F1nJksH4nFw2FU9QlPwTMImexucinyb/55L6extpjJg+F/d0lwkniAlBADLoEphVYejNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331755; c=relaxed/simple;
	bh=ofrnz1TadilO+m4n7QYjHKvxDp484oZO0ouI62RUE6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pHKtwCSB8My/TzRTDeFGQb1LAHIwLBudy1kFNennMx/JGAw68XWZkKAGQl15BhYA0OzeYETKHw0B0u3yNuDvrx6HU/22mV25jVcMZnW7Fh7gxdX6yUx+FHQ21u7FqMzlxKkJBsUiNLkk6APA1dBoAZAWOIf51bLqSgd6qsXIvcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VjWMvcEJ; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VjWMvcEJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1LW8Nr6Y9aoKHXbQZRQCmmqSLhPWLaMeeuP9rXUZG1bGx/3ag7iX6fD2wKE2/G6/xllnL8if3iXaQNmMf9QIMbqYlhypsixIHVncQKUzlCXcloiLLHLtcH1bqrtp2k7QxXysW076MKWs0KjO6z2vj3CMO00C1gGWTMtHuECD0TfF8inHVnw6cAPENcLKbjpWXfGR1HR8g+IVy3OvaS5NWNgmb3xKFzwK/4y69tD6mGhcvoK5/lJIvfA9NBleggHX9n0FqCDi4kV01vpcIu5Qydy+40JYmwIsp3Oa3Zdu2dCZO+1y5xD/AsbY7RysFnypmVo/dl01ifI6UovTxIK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AQkD6WxI0J7RUKt12W4BvnLaDyWcwmOkTyZoYBzhlc=;
 b=PXEuNnZTC57EKdOfXzRfN9ggJyr8E1jVPxXS9nSnl5ZWPTD67wV/lt1KA3mg0K75KaYwt259LooybcpDNr4KGzv1aa/+FrEjSoQk1xqMBpI65a6thcUJ8ca2Dkxbo483iNDoWaZ8gNLVKV569+WbDgui+R2S7Ch4uUMXCBQpQhn10DNJvB7gF+LJwaSS3eS3TP8Ek2RSIyZDIzxWkTOhUzc4MUM1gnORszdJ5Y35IIFlKyK9pSQBkI9xGrBFSO+tdeyc6EquWKH5XhfXc8cL7pSbDFmlHsp43CiKl5aS0SlE4gPlNFChgEYuemR4mMmR7KfGcOH5F29PYlcQFABqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AQkD6WxI0J7RUKt12W4BvnLaDyWcwmOkTyZoYBzhlc=;
 b=VjWMvcEJdThZMri60stInMFkBZGH+6dhlwHMa6EtMN2uLO2AlU9O0jbwV3T0k4IYfV6RJMymRt24gLWUx4XmT7xhnOpbTMOpabbTznQciEowKAgUAwr05ws7E5ZKvgWmnNXxNONgbCJxl+USaZtfcDIaqBlLEYgv5ckapo3T8ISPSholkRGaiU7wVF9tHMGFmp4pdcHOiTzEGIag8uf8/sRy1yHmd1oUCw0q7qYbdG8nVU6QKb/LsmEFfcvsKgAqsggFNZ1eNUco0UDwwdAJV5wQhb8uPiEYcblE4GgJ/o4Zn2H5BL1/SXt13HeAG+GSYWUqguiCW3CfJqIQ7enjkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 02:49:06 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9913.012; Thu, 21 May 2026
 02:49:06 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/2] perf: complete perf_allow_* trio and use in drm/xe
Date: Wed, 20 May 2026 19:49:02 -0700
Message-ID: <20260521024904.331912-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.54.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: e8313860-797e-4543-bbb3-08deb6e3867a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jU8rJcm2ewHFlXpfABDgoxkAn/W8kQ3ReVip4QxJnODlVOyVVL6zpzRb2UlHMrnYPx4+wFPr1FeryncUvtpNkG1COcCdPLmuUZQgXK6eYrY28678UMvI2h4tcBFKXswKpRjsBJXbYELMbIEwJ/RTJrdTte+T2mP1P4PVCzcnpnbOLMOVUgLhuqjSzIT+GTFDgTqmg5LpwGmXKGqPw5r7eLgLrwE7TWKQ2Ze2d3bb51TNGffc12dSwI8oLGsI5yvO6eHqttKCbVJBRBuGy1g9sNtbUGNlhyvDR8ZPpEBMSARbeYLP/gLfhcNXPl/lickyPqa4cpg7GwkUzvTunvhezfl6XasxBGrJ4Yi/fr+gb4ziLtKVTDHSAdh9EOQ9q3iv2jgYRa2/a12mX0g0cVD97Km/TOvBY+BWUksZ/xbroMgkBiysQ/mOgEGoDZAJ/WGWAUZcAJrq/Z8XncqBpnMwYeOYSsuPi457htPPAKblH8aCIZsSZGAbVU2Ud+ncTjRMiS6YoXRxt1WLI3wgYWXJi3pBzDELtmAYPd9bvHea8TQkW3JpJdbMZSLcHq5YjMGiZ3TfDJK2YLjTAWtpkPO8kWZDP0UJ3A2FYGzoONTWKFta5x7a3jQQq4lc/GJzm0/eCSPpHRL95YwMmvmcJkxXGFimIfyLwqSB3p0CiX32+bY73zzU57dMrHrDibxtWcDz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(11063799006)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6x+CIl65sO0WW2y7FVNN1fNXSUNyvcKaDLNTNq2Ugwkq66pVa9rzHyyHEIBk?=
 =?us-ascii?Q?bkgBU8VmNfugSHDDfZ3E7HO8hL9wZZAD6FKqxwvpAedY+FRXGjhzoY9KrRB0?=
 =?us-ascii?Q?dvLTicFLQR6jqcQf9XI3ELj6c1jtsTJQUFeJGHD+hSJcL/nnwMLRymJ/Rg0f?=
 =?us-ascii?Q?/JJ3t1PaaBTe2vih6E6KhT88jBYGcOVO6KI7raS1ilg4MgW0zfpeI8CnIxDu?=
 =?us-ascii?Q?dA+iLzI+6VPsrMiucq6ShIOV/6AJ8puHQPi0pWCfjNyTfh22XqR4SrmKlPAY?=
 =?us-ascii?Q?8vk7qTaIeYdbgtyMtcHKj0xBA6zT7jzIkzGIjobowZ14N0iVV43kzRrDjIpp?=
 =?us-ascii?Q?wKazSnCTxa51qeAyjB4lBSPrb5fWyL1mhI1zqN04u2R3Xqz23Yb6sX6WA8Av?=
 =?us-ascii?Q?dU471sxZMQYKYATnPyUq9p8DdOqu96Vyc/4oN3C5THTsYAfIu44vFYRUnbYZ?=
 =?us-ascii?Q?1eFhvyerOr22lz3UEPgiVE+OEaUIJF6CXn+y8dH7ytdM7YChUUDbLBQ1lK4r?=
 =?us-ascii?Q?gCiYYqiua8EhpeBv3O+MPPxsi2ii/QntDQrG+xFjGi2ZSaCScKjjRXWy4YIi?=
 =?us-ascii?Q?OVQusFwV0VeigSDiMbKkmt9B1HNxDI2w4qogTnzo3AF/QTHmLy1NPCIxTi3G?=
 =?us-ascii?Q?Jvdwq2yQ289ZS8vOIu7FoL47n+zOwadbUqvlVW/fjRVV46CCs3nm1GyTEInl?=
 =?us-ascii?Q?vO7cWQ6fVqKyt+QMBUyu+66mci57Qsz38aRFvx2QdN90H2jwV2vFj7O1snp4?=
 =?us-ascii?Q?lUl38y2eGra78bua+3T6QOsknrv6LhjNRNt8suwvQQhbw5bkk8A/I/rW9HAa?=
 =?us-ascii?Q?AbwKrxwjD1P0Fd6nQ37H7wKQV74pTOZl0pP4QH9cvsoBVN8eyF0/bAz41ztM?=
 =?us-ascii?Q?o+rYGaMjgONrAGTMwtWXa4J5bM7vxjfJeJ9NkXQCml4+IpOINWiQiqfImIXy?=
 =?us-ascii?Q?n/eA9sGJr+4UAvU2Vv4+e3enORO1vhanneUIvZZBa851nOjSU/tB4/nGbOKX?=
 =?us-ascii?Q?qR91hgJ5wWx0Lsj1iyjw5+zAeMhPKG363OEg42Q7/e6oqNsa5+VNa3u4HJeR?=
 =?us-ascii?Q?U51n4td7SWXp0dKu1xYMfiuJoeiSzOc8LL/xonvJu6zYYTZslmZ3eyHJ3QZs?=
 =?us-ascii?Q?vpd/7TH2ny8/fytjKDFvBkDYUqoBmDI8YUvQWhyi4MUoWJzSlhjjI7cDmYuW?=
 =?us-ascii?Q?bogCLyp9FZBdUz3YEdARVM6xsOALcluQN85rvMUUXOqdadXhBPd2Cq0nGzbc?=
 =?us-ascii?Q?8JmauCjdZD8icx9LcYGmeRdClIOZRQrD9y2A9Eounpao4ksj1Wb4MtnpK03x?=
 =?us-ascii?Q?FHGUUfNXDSvpkCIEf2JWGhJP/6aZ5UovlqwP0YErAiU4C4lvTSsE+nYumTgi?=
 =?us-ascii?Q?jQ46MIummtTIAz53Jw/N8zd6V9szCfrHj0gguUti3grdvs/jyTps8/JgQTwX?=
 =?us-ascii?Q?VpjNEZ6CR4nNh9YCu+dQ7Pg60jvOyQ7s7F+90cqdbf/3KJ3JyMNfquaIAfO1?=
 =?us-ascii?Q?xwSY1+pocQVkh68ceKvB1W1EZZt1pR3Sp7OxmAPFc8A8MiPfoF0ZlPzKbDUW?=
 =?us-ascii?Q?5jOk33Cgch9z9Ct4w0rnz2sFciHL58pPWEGNDX0U1lyXxIju1zuMmCDIl5hk?=
 =?us-ascii?Q?ZasUlfk0+8/22Wle23ziTg92L4x/WC5HHRY6D1tJ3dhnUIYXMQcZF6fhQA7i?=
 =?us-ascii?Q?l4+q54b0QC4h2GbAu4tbLipb+rotAbbnUZjQq/I12m0vTgj3fgBAAX+1F9XR?=
 =?us-ascii?Q?FYcp6HApyw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8313860-797e-4543-bbb3-08deb6e3867a
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 02:49:06.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osWT14BQw6Z2A2VXV8RgPjNdotEE7Dbx3JImON7Pp2spcfPIbY76MkYJmfYePWd+yR13t7DufAgFGmoSJCNBRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

perf_allow_cpu() and perf_allow_tracepoint() are static inline and
reach into a non-exported sysctl, so modular drivers that want the
same permission model as system-wide perf end up writing partial
copies of this code. Let's instead export these properly so that modules
can call them.

Commit 5e9629d0ae97 ("drivers/perf: arm_spe: Use perf_allow_kernel()
for permissions") already moved perf_allow_kernel() out of line and
exported it. Patch 1 does the same for the other two.

Patch 2 converts drm/xe's OA and EU stall paths to call
perf_allow_cpu(), so xe observation now respects the system
perf_event_paranoid policy and consults the LSM hook. Sites that have
already configured an LSM perf policy or tuned the paranoid sysctl will
now see those settings honored on xe as well.

John Hubbard (2):
  perf/core: out-of-line and export perf_allow_cpu/tracepoint()
  drm/xe: gate observation streams with perf_allow_cpu()

 drivers/gpu/drm/xe/xe_eu_stall.c    |  5 +++--
 drivers/gpu/drm/xe/xe_oa.c          | 25 +++++++++++++---------
 drivers/gpu/drm/xe/xe_observation.c | 32 ++++++++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_observation.h |  3 +--
 include/linux/perf_event.h          | 18 ++--------------
 kernel/events/core.c                | 18 ++++++++++++++++
 6 files changed, 66 insertions(+), 35 deletions(-)


base-commit: b1f7e321a65b3defd5982ead219029ca6d5c8d0f
-- 
2.54.0

