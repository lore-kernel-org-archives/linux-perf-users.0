Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022136.outbound.protection.outlook.com [52.101.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A121379C55;
	Sat, 19 Sep 2026 00:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779378; cv=fail; b=q8xuVYHx5eKK7mdRGZ9gUVVtng/7azBIoupDuDo0RlF7ixI0dqbd94/rR8oJKy5buUguhE7Mh9/w/8griHip0qbnA1eLjHnszxO4fzVpW5LW/1TsElgUUbh7nRTOxsrxM/Ld5sx09521mkKWSm6HsBSkq91ziDIGKTlKkV1Bods=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779378; c=relaxed/simple;
	bh=FmUO7YhiAdEki5ymZ1uW5FJ0WUSiX1RjN1LzM9IQ9WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HuBnDMAOTzWVAp7g53oN9wquClpzo0JclZYr8lj8UhcZjBY3HFLeOxb0797GbIMcOnPsWGnPxuei5Vu9m8Cmz3fShNEja7rjH0Oz1pGD1+ENcrzDGcFRE5B1yMHtmbCulKmGdAfHw8FGuG5o7eYNmwr1cQl9ZVazIN5hy3YHiXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY6pcghQAuzb1in2wHhgrKhOh7MsOg8qmYCQQdmgFvYbQNZYFSJPcVSMlhxeI6df06LCdvcN7H8f4/glxqOfphM3bgiNLhtasebihoWXwKeXOcHYsQlr8pJNHPCfaq8vsq6d3jbWvfTaa785a3TvtJxTiJJGiApSG70vvgYyd6Axwrxt5xCPEZFV0oSlC8XRoDC3oCecITR+gtGRIm9fSwJBZj8YiNludUCXM73HUn+pz4IMdkYx3D09YN/6vYNzcp8SfLPi2zeI6nNlQrMttjQnDuGmfg5s0i+H+8N42ABrq99DfILqjV9b2Y9CDMt7jQNJ+pCs4IDMqYepLbIkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=boTounzmg+TdIbEc04SlE7JJCkP0C52jwcdoCuwScsg=;
 b=hGLLCzrkFlyDO5+z4r+V87Hs6+dnpYE28GZP2sxbSAArjU8sMQ6jEolDZoggweSbgj5CgE9GIYDOBjSJKANMC6vdnRP6XXr7XmXSap5Fcq28XVe82psnj7TbEyKxbFvtZVedj0j3dd5cMZw/Q2TbhAle66EF6W7Gb2e+f3jkXO/7UBnrYF2Bc/orAtpA700WMIgBJLJO+6YYJp9rRbWDOvNH2qL2VUFolZ6mJFMOeJv1IitiQMNudl0nABLfbyY4NwEhK84e+NYzsLNDVGA2ROlFjn+L/C076Cqn63fPwCW97D9n6NEEXIWylZcRiS0cBKWXVPJBhkqdY7ayJXbS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB2769.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 00:55:52 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:55:52 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 perf-tools-next 5/7] perf trace beauty: Validate payload size in augmented timespec beautifier
Date: Fri, 18 Sep 2026 20:55:28 -0400
Message-ID: <20260919005530.728615-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919005530.728615-1-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:408:143::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB2769:EE_
X-MS-Office365-Filtering-Correlation-Id: 154c753f-dc75-4828-2dd8-08df15e8c0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AbQmtzwawgFdn5HdlX4F6lGmXAwVlNvTONZ2x7JzDjDzXkF4iMh/tjWe1tdq/tlLVyoMtsxLAQHnoVjmb8tW4X8OcKdtQcsOA2b37tGl+Ge93vNZgh9OYEmOYigPE5/pXGKAKR5cisBBYf1obwPU+OKh4vzhOqhVgsKoNdgGuWxPa1PSoXsqwwEFeJ7jnQuVIZFL+/F2GVjoq+ipQi1eh9oFe3yADlg0sKFjTx7todPyCeOK6s9NURMMFbA7F2dysgi7aXW4Egjb2RRiEpxDK64BxKMdaa7A84tZFQ6ZplLD8JzLNdMJZqdBfDDE4yYI5okEZnxOjlOsyz3rQD88CTUxhpI3+gMbfvx8kKvAB3PL0eExHZiB10lyvyWTHZgkKniaKmJpVO20lLSWmoey0WI6t8g9PIWFadXNGQa13YW05wwhm+eu44+IUbhQ7h5jGMODx5ukPjSqGIDmIddH50I2AvuU5S7C00OEdJTBS5x9R3yNIlqFmRT1V9/Fl20WagPjveAIwT485JKYJaWMiNP1Smse7wMQbGHrFNsbZzZE/NLXZ0DTKsqc9JnJgbcOPDgjBxcbXC+cszkY4NYD46Gi93sT01lJSA6YIzNx1iZNupFIpDeKTdsnDMBMy36RfoZUNwE8DZoThMN0lo3hRSGGMbn8Q7loqOZXBPGpfrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J81UPu3TxeAlGKnhCVWpUNwbvo1usFCYcND8tI7GVn36bpUPcPjrvSvgGuCT?=
 =?us-ascii?Q?aWYF07zrj69EnDAmumVDte8AYGpb+Yj5Kw8qIfgJ73vkyMxd4AQkgq7qTswf?=
 =?us-ascii?Q?EEhVEjGEC5OcXWqB1FU6s5bVyW34Bg1+m+yQLIEIy9mUVDP06PAxFOcDBfZo?=
 =?us-ascii?Q?hXgynKCQ/cxxxQsSYAVdT5H8hYVnrBJvSBg/iYbaMPMREKssLIGzhs8dWvAR?=
 =?us-ascii?Q?Z95Ws1VLwYQ3ixZLBF60VFqeGcqGX21oFvKMazid9e7eCC24yEBVX6M6RHWK?=
 =?us-ascii?Q?Is98yfHi6mWWwAe5j8G/7K2vTG5IWpGpB00WsFwDfzoR+4JwWVAgxdXTfbdU?=
 =?us-ascii?Q?u1Pz3+6DCMUO0Pm4DKIxLK+DF3bovj9Ajeh81s5R7WDdMm+rhUeSenKL4sLx?=
 =?us-ascii?Q?72+OjZFiob5t2yIgzcBlfCPuNGX096k8a8FtJQJ3TsTuHHeUutCUoc1n3Z+D?=
 =?us-ascii?Q?MpMkxHuwtaGJ+9u95Pe9ssnrtqt6i4pVESoXkpgUO2pIHyI0QVlcbMqxm9z9?=
 =?us-ascii?Q?6+GZ7n9MZMF0ghtEE8apvDhXg3tBllUO/bDAbFVmFKZnYls9fV8pAttEhyAv?=
 =?us-ascii?Q?+ubYhwqjWEncjJeYWfaiHo945gcJuvKCmFxK580L9tyaqoMxylXj0DwnADah?=
 =?us-ascii?Q?+WUc0bJfZlm6KnVKDhzO378+9S+3K9WTf8vjyoFZU9lQKmfgPIuruRyejUTF?=
 =?us-ascii?Q?VRC2icCuFOQ4BGKWidqLSZv+KU87HgXLOdI2EBy5flQkGwyhSkYOCtsKqd2i?=
 =?us-ascii?Q?wEADPe0Pv/AW8XYSytMbGRtX/qdg0ieAQ5YTdkGM9EpwUoDINqjbse0kavgR?=
 =?us-ascii?Q?U9q3nZ5HA4+TboAc+oCsfUuZpRazgLo+Qu3WPrcitcd0dpddowbUNNV5RtW2?=
 =?us-ascii?Q?b2WrLD2O/BfYvv96iroOmKLZrjypx/bunPHWVul8yr3I+Yo3z96fi97JcSA+?=
 =?us-ascii?Q?sZ7cxyMif4Co0gyY6NUoPqvM27bl9brQmb2qQZeEBhy39T9+PxsUQp2HsS3i?=
 =?us-ascii?Q?IK2YLzKi7g+XIxRa1vr2A3JpEaPEOI2BWL1Kl1hdA24eyF1Cvd+2qmtSmg+X?=
 =?us-ascii?Q?UuTiAmevUBjPDLvNK8oJpjqgYPBQDRK1dZg8bUdN4+5aEzJHznN7iU0tYFnW?=
 =?us-ascii?Q?BY82BlwWZvupFnKiyCY3XEC7x8XccPIHLzXmqQlORR1J7d73NbtwuQ1BuD04?=
 =?us-ascii?Q?VSNMvXY/1GXS4pMyPOUbWvAQA2pj3kp0688HUC+ShDqSIx7hilwfsPwQhCTl?=
 =?us-ascii?Q?h18y7Eoaf6HYwN3VYA7l5hqH/b7AT8D2xtil00Mrnd4Qr4CnDOQjqcxceQmO?=
 =?us-ascii?Q?ZmUfFbX3981ixfgL3r2s04C43j+Sj/Nhz4cw8awvsrzKgzuR5Wp+Pqo3+fzu?=
 =?us-ascii?Q?f5wx57uWTinc7ScZ4Fvjp6JWxHLL5hRp13miieTOZBgqH/k8gRC5xbX/wvWU?=
 =?us-ascii?Q?bBUDU9jxCV6OLAnyGzRM/tDwpqfYv0wsClgwLwMNMnWaeVKzQK9bUAxWg+1b?=
 =?us-ascii?Q?7gqGFcqZzYUPPB/uhjpXMy/4z3B7gx2FrCJDiyr3mXGvLKxDbCkZys3EXG4g?=
 =?us-ascii?Q?P4Y3xtk0kNiMVWt1b89qyT9TVazHPCwAc9h/i1kkSj5rZa4LYwRMB8gEArOF?=
 =?us-ascii?Q?9yDQYP4GlyucQhIskQxCltnos/LupQIeG1OeUfGKj5tbKRbzb1UNsZI6TRNF?=
 =?us-ascii?Q?FmUy3SyGxze1eHnE8SLtDefzWMw0+0KcqRWdBU6bZSIZO9rom/Y2I15xnkwK?=
 =?us-ascii?Q?fodLadOMWQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154c753f-dc75-4828-2dd8-08df15e8c0d3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:55:52.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGHFtQjZok/ksgrrNMzlbA0mDXi0wga5px0Kx6nqSkmg00O6T3IYlfe983ieIKL+PZcWwk0Vsj+jQHs85JLZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2769

When pretty-printing augmented timespec arguments via
syscall_arg__scnprintf_augmented_timespec(), arg->augmented.args->value
is cast to struct timespec without verifying that the captured payload
is large enough to hold the structure.

If a malformed or truncated perf.data record provides an augmented
payload smaller than sizeof(struct timespec), accessing ts->tv_sec or
ts->tv_nsec reads memory past the end of the available buffer.

Validate that arg->augmented.size contains at least
sizeof(struct augmented_arg) + sizeof(struct timespec) bytes before
dereferencing ts->tv_sec and ts->tv_nsec. If validation fails, fall back
to printing the raw pointer value.

Fixes: 6ac73820993c ("perf trace: Add augmenter for clock_gettime's rqtp timespec arg")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/trace/beauty/timespec.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/timespec.c b/tools/perf/trace/beauty/timespec.c
index b14ab72a2738..84755d8d2c87 100644
--- a/tools/perf/trace/beauty/timespec.c
+++ b/tools/perf/trace/beauty/timespec.c
@@ -7,15 +7,24 @@
 
 static size_t syscall_arg__scnprintf_augmented_timespec(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct timespec *ts = (struct timespec *)arg->augmented.args->value;
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	struct timespec *ts;
 
+	if (arg->augmented.size < (int)(sizeof(*augmented_arg) + sizeof(*ts)))
+		return 0;
+
+	ts = (struct timespec *)augmented_arg->value;
 	return scnprintf(bf, size, "{ .tv_sec: %" PRIu64 ", .tv_nsec: %" PRIu64 " }", ts->tv_sec, ts->tv_nsec);
 }
 
 size_t syscall_arg__scnprintf_timespec(char *bf, size_t size, struct syscall_arg *arg)
 {
-	if (arg->augmented.args)
-		return syscall_arg__scnprintf_augmented_timespec(arg, bf, size);
+	if (arg->augmented.args) {
+		size_t printed = syscall_arg__scnprintf_augmented_timespec(arg, bf, size);
+
+		if (printed)
+			return printed;
+	}
 
 	return scnprintf(bf, size, "%#lx", arg->val);
 }
-- 
2.55.0

