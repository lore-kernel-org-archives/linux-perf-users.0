Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021083.outbound.protection.outlook.com [52.101.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD32E764D;
	Mon,  7 Sep 2026 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745914; cv=fail; b=HyPzTQaLMxWqVqtL9/1HSKGoEHwJ3UMX/XJHrkxROAFV7sSKaFEIrkmrywWsk6+FIjK+4BqFa0ZrKQZNt4JQBpZp8Fbhl7xGvVFrmsppYNMiV8Fd8hwPW8rBv4yM2l4iBi3tX9Em2fdCyWc440prmguvDYgu+06095Am4DYPTEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745914; c=relaxed/simple;
	bh=C0ho0ECfUSWhfjusBtkxaMEDbiCpn3omFMqSt1NAkDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=edcvZUivi9eDu6L3rWAFSVRqEu5jeNjGQiqHmyl6RleqjhXoR1l9ERMPSxcRBBHRk67eXmzsVlrm4TVAzSUnsCLIypFR3WMPTLtK1f7iQnPubDgud+EfWFXxyh7FSj07DDbOaMPHM47fQJPYnwPJfttPAxvbX6HIv7r+QJgDQ+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFLfuIO4rLKEhzavA9sO3Wa3zIKOkndxeGpEyRuJ6wAS6gg9Ea+dOI6EPRJ4HGi3d9ghU5PpgkKfvn2Mbf/YX8qyfaTAm9GT9/cvFj4GZuYROWxTQRLl62JW2iIdMYzni/l/3UGcJtzFDhpf7kYBAjnAiG8J60zrSeBeQQ3SrrjqKpXVGkiNwqFGRnkwDg289IW4dOcSiiqVoLGr5Y589b2oYoQqnuI8b7OsL4WLTYYCuyUIFD8I7tjPdrjiy/e37huSrTzmsQ3YTkkAJdxy3/Jn2AIRn1bTYloO0tKWb/6BqsDfrdmwkct8qbwxyenjIynv/J2md4nfkDBS28KCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=NOh4e6+0KJwE8pI0XdW3en9J5OAlN2E+WPL5u6yEnys=;
 b=AUIiNJ3VX9KEjFownncocNLEertFsfDXq9U99HALgk1lYI8ju8zdBFI4wd26xvodPkx/hkFmyoPVTb0cleM9v5gCqS7gqRR5kyEEGVNt3ZBgtwFr9wObaveK+Y/nlLzEmIPhvEdF3vBMi0Qj3hFCKdt9vWJl1eZa1THdqA5pCeFA3VJnL88LsDZLxFJt7/ZWvcNhcbz7z/33jfUNg042mlHS/Q7zNDkbF+myNDr0fG82uzqaRG+AytdyV4qmadrJdjcmnfjUb171aTN2TiLzxUV3LQk61ajBOSHZ51MJE3pL1wvXzSHcOtEp6vwxEeT5/gbSq575WB8dkUHrtmc7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7403.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:51:51 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 01:51:51 +0000
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
Subject: [PATCH v2 perf-tools-next 2/6] perf trace: Validate payload bounds in augmented string beautifier
Date: Sun,  6 Sep 2026 21:51:36 -0400
Message-ID: <20260907015140.363076-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907015140.363076-1-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:408:f9::34) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e2ffec-0644-4e20-897e-08df0c829602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	A2GuVKTyU7/4/GJ2pIky7Tm53X6HZ2aH4g2pSbbZhDbbb3rHYrYe2NI1Md0PGy2Q0A0ExsgZcRWJloI8i2CDpOiCEZXSvMs3oCe83DrPVtvaO6XYaVSgr6wcgPL8HQJmdtw0YZkUT0ejZRhTOcoSYZV5s0ph6BYJAismhOlHpG8rcrr+JI0QAIi/NFoyhCJUomRxAHiq6JYGtx4Hrwqvu4gZIAcGJJyYjIlL42xoV8NefEv/AO7T7iMkX7G8ftoujr5msGqKBlQtc3Ug+fNP1TKoPw5PePApQ/qTDP2UCXJm1gvpzCayDt098ORk3ZBtmqYZewtuslVMnVLMQ5WacH6yiQGlniFkWl5rImCQprTBkOctHRB/RQyrxEpK5LqKtsapQlXGiSNFgIQWTe3K60Wx7+tiGqmZ36nb2JTSsxAOH2NBdIMIKWIG/wdGZ1ib0Kp8swnW5Jo/MAdm17JkairYtF7rdW9nlq5kwbftDaqgjjY38gGN34fRBXamrm5kZIOXTzoYtf16xoRWcCLbKEcHGQwC6W2AoWqrIdVeFUmfOzmpa8CiIHXF6U7xLEFD2kcYGAQOfnm7UmrAA1Ov8bVdwD8sLU2o/8lw1YQdDw3YcM4MIAuBceQjcvDzWoKGxfWEejEnz/YVCULxP8PQPKpJD5tTrZnAv5C6WagLUiI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8Fts/3tgkuJA2HVHbeGz51zpVxF9MOVVfvwAzMxz/tXFze7PNocXT5W5sWx?=
 =?us-ascii?Q?jxQX5EOdkKmZXrQnIExRSzHQ3cFPSu33m6FWT9bo4dSTpo5Q1rLDRI3th8em?=
 =?us-ascii?Q?zMmQtiIpRLBzsICxl5WInSmlpR3wRTcOG2b2C0RnYN9TplQ8v3MOX+xFgh/X?=
 =?us-ascii?Q?byNX/u77ODJqlTHRT1AKqZTheJ9kCS5VYUS/9SPXAEcGw9+fa+bN2/bAyA4Q?=
 =?us-ascii?Q?PKOaPjxTTcxlPzdJM/HEHmlZBzqTzGSOqkRdAO0DfsLZHYsttreYih3sN47e?=
 =?us-ascii?Q?QLolY/pv+6fLxbBb0GfDSgw5PPCuNrcm+4HMXsHtdWB7X72hWxsyUGC46eXV?=
 =?us-ascii?Q?75Z3PCA3kjl6Tcftf4u9xK3+bygN77Vy3RB7dfmLK+s2x2+Pbml+ceqJr6iu?=
 =?us-ascii?Q?jNNpE9D2u3OrvNfmxGQBDWL9vhF8T8ypIcZGAVGA22p1esTT+UI6/bKb9oOE?=
 =?us-ascii?Q?bvJdIZzJOe4Hg58qa7+7RfxY4cOcD6rerHpRFIb6+DFHD7d/qRuAoD8HXHX0?=
 =?us-ascii?Q?TcyQUhLv9dCNqNeoa5Rn1J+mMwrN/otEk7vf6BhDf0GEg2Mj7PMhsIouhjeY?=
 =?us-ascii?Q?ktNqvdLm7EfVBZzKPbkKf30uPCLhm7MZSCBX1hdXxYY8fE07lIVMSAcXebAc?=
 =?us-ascii?Q?FLW3OwQCQxLTFtw0yn5bhCZp5ZfE4Fcx9bblIobNxp49fEMhUrQgo2JAMm7E?=
 =?us-ascii?Q?fpzwk/quQhbdHGnxPnMuYCaNLm3t2rI4TDRz7Lt5kQwT4i5T+hgIwH/yNxm2?=
 =?us-ascii?Q?8uqrU5rS8JHzElp3BsDkdoQSrJEEgOxT3lb7n02pqvmF2jEwZtctWYDUpyB+?=
 =?us-ascii?Q?XOxEKd+aLm7HNI4SzJYNOJJwRnWcurANZJjGSnfjqlZZ3zK7RU1ez7h8hss8?=
 =?us-ascii?Q?bRGGUGfk4qsiULcyl4+S/N7OSCy6w+8cWimWXYQBJ+iECInkW1O04jJcfEJv?=
 =?us-ascii?Q?1ZTHhRdyn2oISUtuQXLRYQD1vbGM+W62aWiUCakoW6AaE8/RWdK115vk3isj?=
 =?us-ascii?Q?CjkCo4YD0zL5nlfVZcX1anim/iTD1HOwF6OSV+3Br/qRXF81E6fJeG6MnrMu?=
 =?us-ascii?Q?JLsBerRwf9YB5FFMRnrXSI80aFMlZvkZeRYFCBTnGXmvZzLHdVp7MCqHijhQ?=
 =?us-ascii?Q?yxVzN6v1+gLwpX5eNXS4cgQ1XebctlhaRqbB3dXPn8bVB0C6YGXZ/bdOD6dp?=
 =?us-ascii?Q?wZhcOwu2eXiqpq22iyiRaIyVtFMWk4/gItqIsdOFkDNx8bf1wcSZ3owqjYlq?=
 =?us-ascii?Q?nQfW3Ffnlpi8AqSCglGGDCWgTyHzTJRhmVV1eXKJhdbRrkPSjNHydD+y/+Y3?=
 =?us-ascii?Q?0RHyKuunUl+0M7h0dNupmaQOAhgGBADM8oL3YdHMI8gZoDw1wepBi64grHB/?=
 =?us-ascii?Q?Oqcc4uccoHMmX5iBSdqzexqiblevFBHvCVcLoLsHCLAvS5fJHmqdAD4ZVKHJ?=
 =?us-ascii?Q?sg1KsIUZ5xR20cEypFWCrb9Ww2oojiOyyGvNyf+2JY227rINAmtTeu4JVE4g?=
 =?us-ascii?Q?ZfpaGcFcpMQkY1i5HRaraCAlTlKb/YPm9Z1Kt7XpeOqJEHX2CkoVm2muSxDU?=
 =?us-ascii?Q?GJ6UNHcxS6NTc6cAd2FP4X+vNWC67+gINsLZA0F/dBkz+cNzBfMBgs+srqYP?=
 =?us-ascii?Q?l+pwiisViXKslNQzKrVYy97cS9F0IFuvxbmJQa+vWlv9x2tUAkdr5kC1Gv5a?=
 =?us-ascii?Q?F+q9jbPa9VRzFmRzZ53a9hDhDT4X42lzepxvpadGlcbe7bT98g0V7QJXougm?=
 =?us-ascii?Q?id0F3Rl+UA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e2ffec-0644-4e20-897e-08df0c829602
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:51:51.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6N2jySKPcvUGryxoVPrYJsGvXYc00uDc0bN2RrGzr76OGJ0Gj+HbvWTMoGWAuuxxTYbIDsaSooUkNJlwYRomqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7403

When pretty-printing augmented string arguments via
syscall_arg__scnprintf_augmented_string(), augmented_arg->size is not
validated against the remaining buffer size (arg->augmented.size).

If a malformed or truncated perf.data record provides an invalid or
excessively large augmented_arg->size:
    1.  If arg->augmented.size is smaller than sizeof(*augmented_arg),
        dereferencing augmented_arg->size reads past the available
        buffer.

    2.  Calculating consumed = sizeof(*augmented_arg) +
        augmented_arg->size can overflow signed integer bounds or cause
        arg->augmented.size to underflow, advancing arg->augmented.args
        out of bounds and corrupting the parsing state for subsequent
        arguments in multi-argument syscalls.

Validate that arg->augmented.size is large enough to hold
sizeof(*augmented_arg) and that augmented_arg->size is within the bounds
of the remaining buffer before printing or calculating consumed bytes. If
validation fails, fall back to printing the raw pointer value.

Fixes: 8195168e8779 ("perf trace: Consume the augmented_raw_syscalls payload")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 20fffc24507b..91461ab927b6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1898,12 +1898,21 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
 static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, char *bf, size_t size)
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
-	size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
+	size_t printed;
+	int consumed;
+
+	if (arg->augmented.size < (int)sizeof(*augmented_arg))
+		return 0;
+
+	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
+		return 0;
+
+	printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
 	/*
 	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
 	 * we would have two strings, each prefixed by its size.
 	 */
-	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
+	consumed = sizeof(*augmented_arg) + augmented_arg->size;
 
 	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
 	arg->augmented.size -= consumed;
@@ -1916,8 +1925,12 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 {
 	unsigned long ptr = arg->val;
 
-	if (arg->augmented.args)
-		return syscall_arg__scnprintf_augmented_string(arg, bf, size);
+	if (arg->augmented.args) {
+		size_t printed = syscall_arg__scnprintf_augmented_string(arg, bf, size);
+
+		if (printed)
+			return printed;
+	}
 
 	if (!arg->trace->vfs_getname)
 		return scnprintf(bf, size, "%#x", ptr);
-- 
2.55.0

