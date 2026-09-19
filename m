Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022136.outbound.protection.outlook.com [52.101.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B36373C1A;
	Sat, 19 Sep 2026 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779370; cv=fail; b=a1CS1JTEvbGyV3y3jXIgz5a4HqEdiuEM00VMcRHqyhndxGLBRCA22O5CIr2ZKwAkEUCTFc8Qb7+Yzk2pI9VXBE07M03EFQaHl/+KciifXPwsVMBUBh3VDkwCxNK5Y5mwYy+UVUWYKztXIN0JAH6tFkMoY2DHgF+0dChvJYKlmxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779370; c=relaxed/simple;
	bh=0f2tTg/Z1iGoWsori+kZwwS09pHPZ5TCcUw6IvXwWww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8WyXwS+ufr6mHqXkpnI5Nc9+8bB0/+Bd6k6shtKZmAtbGBCTklMomjpmfGy2+cE4Y27uwDCX4AZLWYOGgC3x2xxvocsnCUncQqlEMymgvnmi+5cn3fGyoQCuOb2AQDOQ+7zpsaDMXkOkHubXXtz2/D994wHW/D0aRWKXf7rrnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjes6srvXQP4CK7xheQRdfiS6+rXeEQJUKTH/tNLv3Lk8e+z/50OoIthLpsAOrmKdxAugS+n5GJV47c0DgjISNGDq4z/Piz7vkvkGJmzcwJn+Sx7OFpxPz3XswL+xCH+9xvkJwLN0TFxdC4XVPmnsGynpCvYCkP9+UYu6sZhp6so9o3svxlWcnF6EZBFOSi/HBh6+AwLO+r2JfilEBPyCkgoD6HJiQYKWgBUTaPtdU+ts51u/DcXhC0Hc2c2dL70Q8syJePt+XBImeUMltH0G71M9u82X1Zc6Khue2XTvJocvtRv8qgTKjrtUIewaouvvHk79lxFA/0s2eAD9LMQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=iUxT8Ui2ScMhBW/NABaE6eq5P0rcyo/zVZMZA2qeOTI=;
 b=O0XhnNLpIEJtZDM7BSwPa+FWadTOV4HnO+ySaTJwSDtdrFupiy24VFQtGGh1Pz0/WI+zr0+hVcYXlswyywkfWKa7W9WT8MWvGDE4BJFpVrgGpEysfk5NnGrq+VO2zfEtowjd3BN5Cbomw3syK+pDEiLV2YNh8+k8cR+bSe3xvE08rFIaKlFngaPn/WnocWYNX4xZbNulmNpooZmKntXmRvFsmAgPFvTaYakSN4tjx0dowZb+nRGMnZNPJcqig28xj1yfr8B28ZreMSXTky0lIp5lT7S9tKtN0T2+IEYa16EybY2XHC8bB0LOMFdGAt89kPIMPEgnzWFi+slXidjY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB2769.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 00:55:48 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:55:48 +0000
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
Subject: [PATCH v3 perf-tools-next 4/7] perf trace: Validate payload bounds in augmented buffer beautifier
Date: Fri, 18 Sep 2026 20:55:27 -0400
Message-ID: <20260919005530.728615-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919005530.728615-1-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0664.namprd03.prod.outlook.com
 (2603:10b6:408:10e::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB2769:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cf73be-f693-4a8a-2c58-08df15e8be62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/TPCyzaecJOMLCnsnmQW+WCAxcViRTaNEfYTyT6ulXSm6MLHAw+3qbiGU8xkY7gZvCShwlk1NvM+uyRxCJFwco39qtHk0BhpuXBS/6S9iAoAPHV+sho4e9NX+SrvZIUoJlVde0qX93dtMxmRIRrGk/kA/qX1Fb8SG184wKC1HyW7REgv/YAbSQDqGz+i3SY8tVKCwd5rEqQ9PsxCSe8TGORr8ixu+cYP+xMRBTPlC22/uOya04V3Gt2bfaH8kQadhyjlKls5WIpsCgswPvGj/CPBs0fVWCR6sDF7BHr905Zh9VYOd/p6vPx79MqoTQuc2Tvb3uTdPvw+KWyNjyUwHS7hYXqI559qKfdb/TLMXSXI61au02cEgP5HuCqeZbMBuHkeDSLBVoBvpd4kzams5GYDDGtypnbdkObm441FMOisdkmL8r1iaSTz0peUkIGkhJlxuRQyCtbq+dajYdVycFK7wwHrLKs7PixZReWPZO8OfGChPRNJ9ZQbg9zY+hdYUkZsFmG834m0FZ+jUr5TGzBDOznk3B3w2QX9GC9Ys2hLVmmbZl2/oAUqmNI3gxyrzIZ7JzX5cR5ZN9JdKBTpF4abGWahxmm1t/Kb3zdK8J2p3jxT+mNioe8J7eCqp/b6xJ8Wvqp7RXQP2RfOh5draeLZGfgdrJSj6nZHJjuMIKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+k02vgO4zJmtE6zeOMJ+4YvyJUVDSDY8opoKRd3+pZcI7YHGK8l9nFeynS73?=
 =?us-ascii?Q?OfwPWKDAmtQL1jCEwFit3lPtCcyU3YeWzzXh7rhn69GHLzJwskFrPtA6xDgt?=
 =?us-ascii?Q?ljQAdub3LvBODJp9stoszet3V5dA/G75q2eWx48sdjkQBf1+r/RXHnNYu05G?=
 =?us-ascii?Q?p2xXpkQGoylZh5FFB1Pu5PWRo5l4PiGOdaTtskbcT4UruYzESu/tIpb1HoSv?=
 =?us-ascii?Q?mK+ShSGN3gxyjbm8DNwIk6l2e/R2PqEcZLAnPQELo9zPkrItq8CHoQFFPxXU?=
 =?us-ascii?Q?nzUtZgB/bC/gKVqjzNtwcjMm/PWQDBhA1IDR2DimaPdbRGUXOJxZ4kTbXIq/?=
 =?us-ascii?Q?ZJl1U9gYYZCH6kVFKlM849NKBwCibKlCxxQeiptbJUT98LxsU6w1LcnEaR7+?=
 =?us-ascii?Q?2/5lQNIMbO4y1OXRWbhnokT/sksWO9akmCM54WFhE3U3qmaRAQjYYrxFrd2J?=
 =?us-ascii?Q?x3ULfWN2BHV7HVIu6Frq1ajeH9AcftDQBJIVFNY3FySjXNWs4mNR/Uumsbzi?=
 =?us-ascii?Q?PrnUVar8Lt6u7ovHq+Gi2r/nMeCo5TPOUmcZep2mlkqdoU7EL1h7dKVtS/iZ?=
 =?us-ascii?Q?LRmr62wITZlb4BOGaHkuOq2f+YP3+BxgpaYOSc3Xd2YV0BhuOSNGJFWsIzyk?=
 =?us-ascii?Q?ASDw3/VHCRiBzLIjIW56aQhIYJ2O9crOxas3/H83e7XpqwWH5ELA5a/AtFHL?=
 =?us-ascii?Q?LYTAT8qTH1LnwFhdz4g4oB1nLITkVAIIOJHJeTDqCM5dawC8jZVvgbazfmg2?=
 =?us-ascii?Q?mBpydCFt60bIRQDdglfv9wPKF3/dciKtjvDn9eclrWi3NWVwpU7C1/Hwh82h?=
 =?us-ascii?Q?k9zRT2Rck7TBjUL94BOHpil/O1lMekQ56JWWhwG60/4YPl3fRiUz8xe1mvLQ?=
 =?us-ascii?Q?7E5drRsXF5LV2OmO+7ttnU1c3yMvO1Z5lI2HGU+15Fg3XCDorOL2v78t1j/h?=
 =?us-ascii?Q?b+zVvgFDAkWPhoQaKq7xbsakP1PCCQ7uVSkLCOp3w+Y6RBdYAe9hE5qlb5fM?=
 =?us-ascii?Q?CrlamE4E63yyR+wW+v2a5WLR66eAEG6STo+BBeWIYaUIbJy0K/r4bJegK7ZT?=
 =?us-ascii?Q?hdEobkaEbIA+s4NwHFvvjz9WG44oPk7lBanqVMch6j5u/RnXTlh0YwKQBBI8?=
 =?us-ascii?Q?X4mayXGxbex0lpeqI7V6giy8PUt+m/Ok+RQtyf57QUyea7z6KzU2fx6AS7I4?=
 =?us-ascii?Q?IuyIXKc812SjSkdzVghld5i4SguPiQRASnMf+ehIP0OasYTi7Lc6gRlfgXLX?=
 =?us-ascii?Q?oYl6UAnVKnJ0ZawQOppFM1ZxOoNgi5J7e8w9t2szHy1Hw1T5iBr9vTmbcFqb?=
 =?us-ascii?Q?Q5lp/NcV36zJDYiVv0nMWa0FQ6ugoNPblQSSN8tDIoX3tU1OgxS+FY3bVzj0?=
 =?us-ascii?Q?u+2D3oVNFU/XFnfH7k21ySpMeGawW+GbPJ8zHmr7T3tYaMNRdqyYDI8mY6qC?=
 =?us-ascii?Q?zz3enqHtcPqhHKCsysesw5/D2jWuvprzKe/V1tDElTvxz2fLhwQPhUKN9zUb?=
 =?us-ascii?Q?f1olFIv4tAnl7vITU+aSAWpJ2dfmxziFHmak0Tg9L6jmKtBLE2jqCMAdQi0E?=
 =?us-ascii?Q?AreW4/OhkHCF7xS2wk5YWaHS8smIBE4jCvKDpxm2xC3v4iKnnnLJ3cQXHLxU?=
 =?us-ascii?Q?VXji6WK2yvL2zlpkH8zUq2cATcBAtrUpBvx/VSpkaqOl0a96g2SdBesl9Je3?=
 =?us-ascii?Q?I06tzjlLLXUd12dEfC2C70Kq4UA30ls+Nhr8mJNwarMeAEn15Z2MIYkeQKOt?=
 =?us-ascii?Q?JyNJ6U62Rw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cf73be-f693-4a8a-2c58-08df15e8be62
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:55:48.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gOk3C/47bGkH3hNYVt993FegZk76/1jkLnDyfQ4KRylFja6vYAk6NAE+H6/51D62UgXWb2crsIhG0mXXk8snw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2769

When pretty-printing non-string augmented buffers via
syscall_arg__scnprintf_buf(), augmented_arg->size is not validated
against the remaining buffer size (arg->augmented.size).

If a malformed or truncated perf.data record provides an invalid or
excessively large augmented_arg->size:
    1.  If arg->augmented.size is smaller than sizeof(*augmented_arg),
        dereferencing augmented_arg->size reads past the available
        buffer.

    2.  The loop reads up to augmented_arg->size bytes from
        augmented_arg->value without verifying that they exist within
        the buffer, leading to buffer over-reads.

    3.  Calculating consumed = sizeof(*augmented_arg) +
        augmented_arg->size can overflow signed integer bounds or cause
        arg->augmented.size to underflow, advancing arg->augmented.args
        out of bounds and corrupting the parsing state for subsequent
        arguments in multi-argument syscalls.

Validate that arg->augmented.size is large enough to hold
sizeof(*augmented_arg) and that augmented_arg->size is within the bounds
of the remaining buffer before iterating or calculating consumed bytes.
If validation fails, fall back to printing the raw pointer value.

Fixes: b257fac12f38 ("perf trace: Pretty print buffer data")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 21c16e4c163a..af1ca4c02a57 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1950,13 +1950,17 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg)
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
-	unsigned char *orig = (unsigned char *)augmented_arg->value;
+	unsigned char *orig;
 	size_t printed = 0;
 	int consumed;
 
-	if (augmented_arg == NULL)
-		return 0;
+	if (augmented_arg == NULL || arg->augmented.size < (int)sizeof(*augmented_arg))
+		return scnprintf(bf, size, "%#lx", arg->val);
+
+	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
+		return scnprintf(bf, size, "%#lx", arg->val);
 
+	orig = (unsigned char *)augmented_arg->value;
 	for (int j = 0; j < augmented_arg->size; ++j) {
 		bool control_char = orig[j] <= MAX_CONTROL_CHAR || orig[j] >= MAX_ASCII;
 		/* print control characters (0~31 and 127), and non-ascii characters in \(digits) */
-- 
2.55.0

