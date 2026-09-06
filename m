Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022108.outbound.protection.outlook.com [52.101.101.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE61A6814;
	Sun,  6 Sep 2026 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788657102; cv=fail; b=LdLiKjic2IFTynKUKWktvIts+5VaEkkjjCx2cBLB2vMuqhVShXDsIvpw0E8oizDCJIK5dBwOLCFYS/h1m7e6QsPXlDCNN5wmrP0cWvsoesra8SEjRfwMaLoqlcv2u62qu6wlF4sX6GIx36eKqwU83bysjgnV/zs73j+j/rcrqho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788657102; c=relaxed/simple;
	bh=qmTc7WXexs1TTx85utU47n/owBC0D9cSdKfbvDYGE+s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fZPvJIbtavlhjFuxWDnUNYzU6RvdQZB1FVj6HnZnYuZYIZHq4hgz9166MrNuLyjder/ZJg24oKiIkMk5ZYaIc3z6G6nHLP78xajgkJOQInmQwmuVJGBOsLfMMnV+5AGROK+QlP0MQimYPfFCIVeR6U62eRLedCBJ3W7ZZ/DBy9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/v7F2VvOlAuucV4ENaLaV8KbEuRF9ZaNFyIGNqOJPq9MxiPJFeOE9YBF/tA+P8QVS5IpaKx78pRdA4ruymIysftj7VnlHk3yH4UvVPk/GB68w61LyjaRIgAo09xUD6LPZErWT1teK3LhEMgerf/zEdSYCWkMsZmtlvLNnMrM90mAl/3LanUihS8aFpzFYVPuW1haKukDhrMosXyyVrGm8xe6jkHBmZp1KwrlSIeS2G3LdUqm3GMVPTQHOm85w3Xh+kW02Bvm2wj4LLsjlWSd4/AikBlqfDRaT+QkcQdNtCOEpBfq8Y8OCeizhWLHakNh77fsOfKCFO6KqNuwANPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=2TUyh2oW1XwKwAEoRdCE/Ho3LCcLIHSHr300hEib+pE=;
 b=K6T+bz2tmSruthYzJAz75fnYI6zMqlJpPYEFkjdilLZx+C0VA/BhWRytDYH/KCBbyi+9c8JCkoW6OLRK9VbXXsN2WDWPlQ/+JWy2Nofbw8fdhCDFBUSYGYVD1PVpRV92isz5n/bqWjMR5lIcggG1S6Twc5ZhY/cGtbecRMb+K2m93Qb3ig3DwDIGp0NTtmnrhoqr9KkHEYbqsv20JU+pKi6EYQVhJvN8bdu59kLAWErYAjsOOwVgJv79Sjwvz2ECJFNftAC5yIcL0Vl4vCY0sp7Rng95AUSlWfCew6DQDkw2Hsg4+R5PZQ7ojK1wpHzszYgAo2nkKn7ck9z1QjjWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8065.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:24b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 01:11:36 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 01:11:35 +0000
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
Subject: [PATCH perf-tools-next] perf trace: Add upper bound checks for augmented BTF struct printing
Date: Sat,  5 Sep 2026 21:11:32 -0400
Message-ID: <20260906011132.279321-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:408:142::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 37eb1e3f-6778-463d-1591-08df0bb3cbdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mcYZ2BTbumY5gzjEIUvi6Yn45x9WuMVKthG43aNFmqg03F8nihOXCu54OYFJiqoenfcQvJ7fr/I9j5niJ7eij2DwQOGO9ioID1a82DT3wz/2NdIIdNRCLUYqpBMe+Rs4zT0wDZnr3HAhlTlnHKNZvPZErZlcuS5505SL2RRmyx7XmfyDBWxPiq/5eK/w3yoYHp741SGQuUXtT4jEli9aqcJb+HIrrVAI1y0KUfRltMcsB+qY8U2jmnIpZQY1trDGKbEjbQTU3zlHbu6pW4AWUvLI+3ZphvWe7FQRH7K+m0BFqTL+ouL78H/2oKR1fvMwMeF68G//KlX1X5RdAiDGdlVdAnEvQO+mlCx2Q9sNTamEovSvBOd43GeyiG24+640LZA02fhra7uftKIvaZpyeFX6LOCLG9NpaCN+RoVDDjL8pdH+7YAaHIv3OHqZyzCWb+Q3n5chNFCkjjDiPkhVUauzu3dBqQxoBr5WmBM1kRoaFxxlaPiEAZm19qUhhEmNUcCBqDsdcwQPZmUM/q55rTxF7KW+A7MysV5LBBfeWVG0fGorGBlO77tMSizrq5SNOU/IVtVnmOD1SSWdRZ98hY3T4W/qMohZKsKHu6pH6U99KYBBo0pJns5K5tdSnLoU8D8zlAbVKV/kzIZ/45FqyrhVbMInP1mUscp8gj9+2h0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(6133799003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PqbhCEkRZ8H5vabIZw4oijeKrnMZEkL86g+YzL9VLV3TO6iIRqA14kvxmiZ/?=
 =?us-ascii?Q?YfbVKVnPL8GmBPFEoe49Ik/ao4mdLTegoIvEksEnSnUuKiO3jjwd5uGJ7yjz?=
 =?us-ascii?Q?3t9TvUHSJraSYOpOUpLsqy8cbHBGnp/YmcSR08HqOtdaq6c0VgXj//nTYjUp?=
 =?us-ascii?Q?tjK1EHn0UhOnETvtU9y9357R+XGmNRa9JD2VxxWbgdjqeBeLKfNWzoqu+3Bo?=
 =?us-ascii?Q?lkglSc0QXrrRojI1dQYzSv9LoS4RHG0qUUtt+1U0vhavv/n8cSHz/hzy596r?=
 =?us-ascii?Q?cNUlYMyo78thTU2gvLJERiN2L4h/807wMUAzjrsQJHTOFbHahRuSg9xysZTq?=
 =?us-ascii?Q?HMA/BBsB1kueHjIS02ZG1ij1cdYsQ3T+8crISVzhBt0ilWcK7fYV/X6udbLF?=
 =?us-ascii?Q?y1wAeRylgovpT10S8fATjXeK5tJXZpu8uRVGPfZVEYbwUQx2KhULY/M6J42U?=
 =?us-ascii?Q?uUZQ9+SIPNWmeH0ktozVERDg3KoWlYLIsDLHeyVpnh+r1CPlzxzQ3CISPLxj?=
 =?us-ascii?Q?LN4A0DK07igpMyhwF2pABtjrcZ7L9YAMKBpMYkwCRiWfzsJrt8p02hmZflPA?=
 =?us-ascii?Q?TVupUVdx/B2IpBnw/UP64dKhMVn1F+Ct2AtPJOnAW6IsLiWxIkMeG9nw/AF2?=
 =?us-ascii?Q?UDeuimlRAPF13sgNv7GVSMF+GZFR3kXAIM+ztomY4zBzeC7l/AtqjRdfL8q1?=
 =?us-ascii?Q?pnzilV46s34iBKMoNfJ2sNHqLMBqD4Vx1z60RjfTXjODVXCZEjR1hN6Oe5mL?=
 =?us-ascii?Q?mZp0me7lVTVE7isSwDhARXg491NXj/ot1MBYFgq6hfFHJnJIBA4Z9pMRCYM3?=
 =?us-ascii?Q?PKWt3O92HtUJWg6UCVOovBm8GettGgMCqUObJqAFIOZNJ0KEQxFdHMydUsXo?=
 =?us-ascii?Q?+HKNuscN0djnSHry8jzfsQ3CYBfR79WVskUr21mS0ZBuoAOscfDbcntUXleQ?=
 =?us-ascii?Q?BTghd1VGgI/289aoxdWrTOdSCi02pRNwsyzgakhi2R/C1W0K5uO2kdR3lBbE?=
 =?us-ascii?Q?29Yvy4MBrAXArXWOILDQHJ4w3TefdSZiMxJcoNgzYLKSJnkWNZzjdEBsYinY?=
 =?us-ascii?Q?o5TvKrua8H43Lj8pYXh521xtbkIRpWievp8NmKNkOeY20jyJ8xcHMdKQJxMn?=
 =?us-ascii?Q?rd0QJNvsWjgbLuh1Ap+BruMYwh2BxCdkW+ygLHgqn3G5rjFm373Hxg0U0Ju6?=
 =?us-ascii?Q?nWVxFQ7YRCCcBa63CCq7zHWHbAP6mbgziLirX4UBrS5KsVUfdzIj46USkq8A?=
 =?us-ascii?Q?7gY6HZJUKw4D9BpjFkyX32uOB7nwOUqM7bwKqHBHbQkN0BCUV/CcOuUJuSRC?=
 =?us-ascii?Q?JB2Vq9eQSXOqlYqt7dtjWTnd1yAF22aFLdkTp+WBeSRxLgssSsqxbRbY+PBV?=
 =?us-ascii?Q?Y+e8XniUwN7chPTWmDQE2QBa1mOu05VUmeE4JeMjFx4tCl5OcuCZHRLYtg5W?=
 =?us-ascii?Q?g+0cKOs9maddiFC9M0VOIQUswueIyTuyNwd8uIKxW31Yc2q56chdWH57I4mn?=
 =?us-ascii?Q?kVZ5OCoqlrWjiXcrfQoEe6RYj+SJCjlWzgAsPJWB9WwK3UUOaPCS3/jjR+O/?=
 =?us-ascii?Q?0q0QHccTuKsv+AF4cqIRIo+NNKe0uYXMKeKDDCQ8s3VBrGIlYgA5j68ii56t?=
 =?us-ascii?Q?Rbm3sTW3vzVoVPrMogxhBexl5XLAurbTUq3Gp7eEM/ebzHkg3J4LgHXCzfN2?=
 =?us-ascii?Q?iOOXJ+Igf7rNXO2qiulYjCEtZ7L2Zs46DKkRq95B4/5PliSFs/rzaqew+4C2?=
 =?us-ascii?Q?qrqdzkMwPA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37eb1e3f-6778-463d-1591-08df0bb3cbdf
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 01:11:35.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNx0dI5gINWjFDQzgDVSflFZV+A/JFcM6Gfid/KbRRNvn83G8Uw+K6RGiX543p19X/hGEbBkU3gVBSXwohJpDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8065

When pretty-printing augmented struct payloads using BTF via
btf_struct_scnprintf(), augmented_arg->size is currently only validated
against values <= 0.

However, several edge cases can result in size mismatches or buffer
over-reads:
    1.  If arg->augmented.size is smaller than sizeof(*augmented_arg),
        dereferencing augmented_arg->size reads past the available
        buffer.

    2.  If augmented_arg->size exceeds arg->augmented.size -
        sizeof(*augmented_arg), calculating consumed =
        sizeof(*augmented_arg) + augmented_arg->size can overflow signed
        integer limits (e.g., with crafted INT_MAX values in an
        untrusted perf.data file) or cause arg->augmented.size to
        underflow. This advances arg->augmented.args out of bounds,
        corrupting the parsing state for subsequent arguments in
        multi-argument syscalls.

    3.  If the captured payload is truncated (e.g., short reads in BPF,
        or during cross-architecture analysis such as replaying a 32-bit
        perf.data on a 64-bit host where host BTF type->size exceeds the
        32-bit target payload), passing type->size to
        btf_dump__dump_type_data() causes libbpf to read past the end of
        the payload buffer.

Enforce an upper bound on augmented_arg->size against the remaining
buffer (arg->augmented.size - sizeof(*augmented_arg)) and verify that the
captured payload contains at least type->size bytes before passing it to
btf_dump__dump_type_data().

Fixes: cb32035214b9 ("perf trace: Pretty print struct data")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index be19d70eba09..20fffc24507b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1133,12 +1133,13 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
 	LIBBPF_OPTS(btf_dump_opts, dump_opts);
 	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
 
-	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size <= 0 ||
+	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size < (int)sizeof(*augmented_arg) ||
 	    arg->fmt == NULL || !arg->fmt->from_user)
 		return 0;
 
 	augmented_arg = arg->augmented.args;
-	if (augmented_arg->size <= 0)
+	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg) ||
+	    (size_t)augmented_arg->size < type->size)
 		return 0;
 
 	dump_data_opts.compact	  = true;

base-commit: 02f6847e1822714a4201b87e42f92b0d43e8549d
-- 
2.55.0

