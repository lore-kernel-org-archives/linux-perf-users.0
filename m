Received: from BL0PR05CU006.outbound.protection.outlook.com (mail-eastusazon11021080.outbound.protection.outlook.com [52.101.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6E20ADDC;
	Wed,  6 Nov 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921829; cv=fail; b=pJ39Bc8LJL1hHPzWp+hh7OumT50fQrhDm1ncwz5xAskueHk/k0/eZePdWxgXt3S55Hdjl4vDnSJdeP8OmOlQshqDU2SFKJv2iQC7/ZIoRsa6H7evwdu9sZKVhhe46F9mGrurhXBeibdM+uqbJMOnTMjTnhRF9JkYp6KlVzHfMF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921829; c=relaxed/simple;
	bh=qq37zE6G7az9lJIqk/pdBJ73NBKNfRB6B0TMLt6pLGM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VcfiL9epagdH1Q5rwo7zeu/K1BvxNeh5EVS8KcgyIN29HcSyItDlpgX8afunGqqi94A3cVIukt28/8EiQEz17inqxTxZn2Hc4K9TYn7oO5wvTHEO5Lm/PZu/bX9iUQrCDr+CkiaXoopgbNigJE3SrmGWHdpkZn5tOksyII9KueA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YWDeRcdD; arc=fail smtp.client-ip=52.101.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YWDeRcdD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoxSPhcVJgBBlW2vAeujAd7yyC/94WXpdZ2sNPaiDNgpInHJFElxdIAXmFBC9uuvGFccoBkdZn8YF0uOqH9UHScaXTjt2bfsk6/2bCzRz1eUoRJOy3ru1brzbxcEvmmvG72o8EVIXFx3CB9eDzEUTxr70FOGeJRa15X8iKyDg4P499bB5gliNcVBHyZGIVvl/llulhcrWleBK+ittIwl2O/OHoYMo86Hbq7VFT9+Zl6JH8E/UhGecA5HIA2AZ+98Fsh3XZckOMBe9ca6Rv0arAohcPHHoc6XuD8TSSveYzXOQSTVyvck6ZUNgSP0XlCVWXafAEX3vWAx77yyjdA1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/lUbTxaqWLpO2jwM0miN5zXaAb24E+6j43pOyerS0I=;
 b=Oi59dK9+w4+UJ0MUpEMvowUHOe1eo8TeFB4x/vFs9pmgNNvEfi9X5FyMY3Dtnh0Du/hZFx0vwH6mjU2Ci8UCTPjVV5Yv+kIj0+scLWvoCPy9W9beJCoeMor0el1q7et8GAqb2zI/BE/o8NSxXQxv1wtWLYBu98CttN1QOTAom1qZHG0gHJMvW2+E8dsJBR6s6MAe1J4PhTKzpvxu6d5LfxkbZEwj1yeQfwwz3dg7EadJlCpFuzL99fAtxU+vSwkzRfqxbLNmmklZc60nW5kfv7blkTM1fqr86AsXFtNZpvY9tYeCiYS8IDH8cbneTo3NnTzgE2q+pmHGEUoV8XKO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/lUbTxaqWLpO2jwM0miN5zXaAb24E+6j43pOyerS0I=;
 b=YWDeRcdD0Y5LmyJGqVXEgjWRGbEo9dSYJBgaB0rUchlJ3N28c26P3fazkmPgeR6b1wVWQloja71MTgKAqhIcn2Ckqdxu5BcPNN7ckL0OJfJca4eWDT+bFZY2+7GaM1HYcoR334H18KcLyO8wMgoouDxgtNh+qJ1w5g3fqim/ySk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 DS1PR01MB8775.prod.exchangelabs.com (2603:10b6:8:220::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Wed, 6 Nov 2024 19:37:04 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 19:37:04 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] perf arm-spe: Add support for SPE Data Source packet on AmpereOne
Date: Wed,  6 Nov 2024 19:37:38 +0000
Message-ID: <20241106193740.6159-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:610:11a::9) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|DS1PR01MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: a6655d08-555a-4e7a-187b-08dcfe9a6442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HW4gKospNLQXZb9OOqBNEIR8rW/OQUpv3YbRKeLaIsCJOLzAPG+XL7WWaQQ7?=
 =?us-ascii?Q?nngJ+lB+s/jtuKD8bZnXgB9WzacaA3d0uXeGU67jspgshsMgxveFDwOz1qhE?=
 =?us-ascii?Q?4Tb/bS36OCKD9z/06fSjg6zVXKWIOVYt8Q40tth2vnx18acfxsmenyO88r94?=
 =?us-ascii?Q?fA0JaLbLhpVudlTT6wBbk6y3VH62Uv7d6awud3ABxu4XPeP3HP9yVdg8Q1Uf?=
 =?us-ascii?Q?w9W9/5FdUZR6xfI74ubD9cyfxh4TVqoDAeFoVNneziHp9o6eXeqTwhhbnXEG?=
 =?us-ascii?Q?qau1FW5Iq/PE4dkPK5sZ01/u+zNy4i8e+63gwMuQXPQJXeRr4/YP1rcG6STD?=
 =?us-ascii?Q?SaA7pwJf+XxJiTx+zq4yDF3dS3i+NHLHspGUxLBrV+ljIE8PKJgznDHkhEsy?=
 =?us-ascii?Q?ny9SulSH93eHBWOVQ2Dp5Xq8CB2TF5Ydz3SENEkC75Yv4aMGPH7Afdrrm/vH?=
 =?us-ascii?Q?6q62qgJu/5zglCeHq2W8+9NspE3qRny5kq3aCcBg9DfY9KGlKw/Tlo/YnVbD?=
 =?us-ascii?Q?YRG+c5rKr5YfLCAdEjH35GzrTzlOCJZPkAsktpDk+5o/5nitxDyZRMk3PtQj?=
 =?us-ascii?Q?csl31dnS2PWTO3W3FwbtTJ6LPsZN4c1tePQQJIMFcDtsgT125ok5hpmwyTdN?=
 =?us-ascii?Q?ny61+/C1LVmwsuXhuPaR4oss5hHfd+L21GtaNpmgJ+WNuTuwBAo/NVFIRj/E?=
 =?us-ascii?Q?IugZfSKC2xnhShT/j7Bqos4xMeWkXgmbvV2xGr7QBTSeddVjRE9yz2yp8Ois?=
 =?us-ascii?Q?bcMgE/1lMNchIV0d4FQyWo+2+w93C9uQa21cA/sVc+4TvqAqdfW/86e1r8+q?=
 =?us-ascii?Q?fLG2TITP9TbPyzNo25SNfCTqIgm9P7HY1gQEC+dSHx6WPsieUcSjxf0qxXsp?=
 =?us-ascii?Q?dPL3DY1ieigoubIxkkO+8kkp+D1NahnzwnxwB9xWg8S+bCp9O9my+TMY5yO0?=
 =?us-ascii?Q?QfC1+KuLpmTUFE1Gl5AhHxdjKNA9SMhLWki7J2B+KBn5UpWegCYaHa2m4VRE?=
 =?us-ascii?Q?NrCUjax+LnWH+JKOhab9emALlXhBWpZQ2sGRTLdyp6pRbB1VZhFnjcJKyPWW?=
 =?us-ascii?Q?LymKoCyvvVJueGw1e80NVCTM7kirar2ftPTnz3L5Pw0wgBOvd3Ba6wG0c9gB?=
 =?us-ascii?Q?lZq8iTqXw4nvNiKziSpUl+eVhXJGnV5AhgtxKeaErN/eiJ7J3yCmbeNuFGDt?=
 =?us-ascii?Q?Qf6590bwROLgpHfiBbxsFqr7MrSpBlEEI4RU11BTeuKAzH59VUyvBWBBzn1R?=
 =?us-ascii?Q?M992rDYs9nPe7v5TPN4u6f2ld0HlBSGtaXAuhr6NKXf781teRa/J4fhQMIYO?=
 =?us-ascii?Q?P7f04tv91Eg3ag1Cf23aTlnUKFimdLwSgJROYfh8Bcc77iUKcctMbQozzEk3?=
 =?us-ascii?Q?Xf6mSk8/HrQ7cZbnnbQu3m+l6XvZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m4QHNWnp3RLYPC0roNXX7KYSNIyD8noDQyRrw0IqZZFvoCbHq2hO+OGW9XQ9?=
 =?us-ascii?Q?/LuUalIvbqFa6mR5c1R0Yk5R687nLRQDaj6nwbYgKxf2BmFoD5X8qkkC3aq8?=
 =?us-ascii?Q?PPMFqQPRUM9bE6/o5LpyWZFsQ3waWvwxvj7//4G5Cvcax2uta5lbV6CYG3Qs?=
 =?us-ascii?Q?n+hAmX2Kjphyq+qlZPkARRXfsdQVaNJAA+/DuzGSf3+Jdkig6eVoJRq8j4uY?=
 =?us-ascii?Q?+4FS5E/1SbI0k+nnpDicEtemi94o/m5VL0Y9fl+pHFPVqyKzohSF6Ae+viXd?=
 =?us-ascii?Q?RcoqyFxQBQ9ZVvLEPWMgD5j6xgHt7N1E6F/OcKMbORzBqFfCP9TXKo3M934A?=
 =?us-ascii?Q?GJITC2c23ibidcQh1NAQe4KYsi7cO3iafX5+deS7VcrNXo07QnzHvZuS2W+r?=
 =?us-ascii?Q?TeBVKn8elHSOaNuX2wnh2mJdNaEL1eY/tQLpFPCJgK3MeaWPM6R7+QqRoPTr?=
 =?us-ascii?Q?znD2VdObpi3EDxtCV/jLAklaR4O54biFrCbKvH8nOZgXYIhsGbBRW4ids8Gp?=
 =?us-ascii?Q?ITiER8AB0qp5LvcikZoBPDUrfoZ8J2HDGDHAu3jVUdAgzyMHxxZIh/fnch4T?=
 =?us-ascii?Q?SAtQ3G4CIyH90rn1zDGqg5Yk47q+Q0iNQVXfbk3UCvq9QMgzgHxXiG19HaU4?=
 =?us-ascii?Q?+9pPJaAW9J8DdSNOz9lbTQFKK/U+OgVaXVAX1+dnj6xbVGsYAf9HkJu+Di+a?=
 =?us-ascii?Q?H+a030I/8gJUZTEM2GYLwbhTpXDHVYLiWC8RJS7+IvgbVbysRJo1UEbhH4xh?=
 =?us-ascii?Q?UIkGc+wKHza0tDzRRHK6D/ucI3NMuvY6eUmPTkFjGYGR+RjYQHK4/VnGYX69?=
 =?us-ascii?Q?CLavXscSZ398D28u51EK1CZQ7zVyWr1rlw9xccVSSurl5aLVP8kyccaP/nJw?=
 =?us-ascii?Q?W93luwu3CaDoeRRtDxHIKtmta4RmqkFFvrQ9UaBQwEoA5hL/eCK9oyFlabJr?=
 =?us-ascii?Q?hjuI2RDbgbgvVPbnwdRkBacuRwdNgo8yl3FkfhXV2HdhFgwAuMvkqKYcwDuu?=
 =?us-ascii?Q?v8OpIfjQ6FOSViusFQcoYkdN260uOyEY0ov0QgIFHyLC3blrNmnZG/RhZgl2?=
 =?us-ascii?Q?JSLdtmQJWWc0bCaecvF2NxIY3XubCdJe/KxC/cXrybNkJ9XljP9wOHYYV9CA?=
 =?us-ascii?Q?kqf38o18CCnEiFIc49A3Jsj8hTKBft9cd9IeeWn64+gwyjaoWpQmTEmQa0O1?=
 =?us-ascii?Q?xiprIg/Ilg7H6A+cka8U9NTTc+ZTrZb1LDZSp4vMNZUIbX90A8jh7BBy1+Ly?=
 =?us-ascii?Q?N7/XkKTT7VObgPRmhcanOK26kV2+KfCgOQbE/CQM/uFVWuZy4+MKDiyzRLEq?=
 =?us-ascii?Q?yD8Vp2BzJKFg8UxNuba/gFozLRBipNNIuR0K/CgF7Js1dhutZowra4XGvgJo?=
 =?us-ascii?Q?J/Crm7zDF8YsDLqLPYoiF8yi99ZPAS1Gft4IQqWmHYGb7CtxOxMGvtqrtzNk?=
 =?us-ascii?Q?GmMSdvpSA60Vv5yZD+HLeQEjPudm+surrltlBb0aDIfUxGcRt/kPBUV82A8N?=
 =?us-ascii?Q?2duD52FhBxS7z6uY7yQsiHD78490EuXxoYOG39Xut1Zo/2ArmEPRshqpwHNg?=
 =?us-ascii?Q?HV2RwwK6uWmXgEPeIteAWKmg5OqwFfkOnxpkQ05JAmjOD4TaMw1xgd6mnHRq?=
 =?us-ascii?Q?UAOeR6RkL5vEMZ6A/nqvVjM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6655d08-555a-4e7a-187b-08dcfe9a6442
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:37:04.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjvdHmo2bZuypxefHv1FgzoS3BsqrnpkNuqDd+/IBLV4fkQrkVoTq2Zw6El9dwTmbYzYUqhhEy2v8pz1zpezE5zKoSvUUZQ656paIVOB74nBCxUO4tnbauSUIPxJvQqc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8775

v1:
	* https://lore.kernel.org/all/20241024233035.7979-1-ilkka@os.amperecomputing.com/

v2:
	* Doesn't use read_cpuid_implementor() anymore as that was broken and
	  unnecessary.
	* Convert AmpereOne source field to matching common source fields to
	  avoid duplicating the code.
	* Rebased on top of perf-tools-next/perf-tools-next (ba993e5ada1d)
	* https://lore.kernel.org/all/20241031213533.11148-1-ilkka@os.amperecomputing.com/

v3:
	* Changed source mapping to simple switch statement
	* Dropped is_xyz() stuff
	* Added table to map midr to data source decoding function

Ilkka Koskinen (2):
  perf arm-spe: Prepare for adding data source packet implementations
    for other cores
  perf arm-spe: Add support for SPE Data Source packet on AmpereOne

 .../util/arm-spe-decoder/arm-spe-decoder.h    |   9 ++
 tools/perf/util/arm-spe.c                     | 104 +++++++++++++-----
 2 files changed, 88 insertions(+), 25 deletions(-)

-- 
2.47.0

