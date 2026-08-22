Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1B25C804
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787431639; cv=fail; b=XhoFnZTxTCtgvh8+wC/cwpFwbSKGJXHl55ymOzGMn8OBLlX+n9j7fEg5GYW5Sg/V/DkEq1JKunOKF3hgywSLMTDytp89liIWIC80srDUT0DtFtR16CLn96sYhz0i8p58Rb+gaowtH7VffZWMwdpbOnqXQrmX6GXYM9xROYKOEuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787431639; c=relaxed/simple;
	bh=P6cVNJhCEeLtzhSlMW/+GlKfVlueWVG1/q6zbjJjG4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tiVqRVdLf5N4XfdkNCIPxocAp+dLCymypYUl2PYX6gEqE3WgTmqpEcoJtak7hBm+6BGEbce3Q4XuJujbgw/eSJGJX+YZ8qg5ef+PS7VntsdOIirtVipQ3pssDtJuvIcECY2bUsQI0Z4oStJPaTI1PFZng+cq10id8YWzvlFvEKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeVEdlBFuCM+IwiZXXTIuUSAB8xi+Kg2n+ZP/Gfx2JYXc74VUlX7mzoQq7tgbhvpNV+2/ZquDxJpGrpCFOWe9qzAprenHRRYFMNG/AbywVOv3MgBi/bgI6gVdMIBh3sNqBYFFpfWpLBLjbIcUVER8dP5Be+gOg1HqPyWMXw5Q4Ncmxag2pdMkhW3cLbprLRbn7WJSqfZNlWg33m+6sSkvZYa75UgibCmjSr/u1/x5YDEQKE7EZAoXpcfTtfy7VF9yITdnyND2oKgnxbYXkU66el7ivERs/rUmbrl/GcLS3PuKr26+Lu/0ojwjB1Obv61uF7opDdl2hFlPAIenIbZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Hb35nuyfQ5r0KDssPJyPANuRMzg/GJTVlltpI7HWxjY=;
 b=h0n4oSYDsLfHJRexLDKNNp7yY3IUhjP9Yv3wEjFpYNZbqWJpMSAPMliWi5LZZwLDwe3GxCmT/qFnV82Drz8P0JHVzAqHvrmPeCYooFs6mNNnEcqSR0cp0dfvOeaPmJTEzNCBJ1Z5sGt5qc+4+ViH4MGInsg/L5Xy/EhGBjr1KIKiAgmpT0vvDDvkLb4MqLw8qk3w6XtVPjF43FhWZPNJwpLpey/T6T9WaOVthRx5Skt/os3r5FDUqe1Oc/AxbMbQc9VUtV+Z6R33oZmLrsyjoAu37esXcy1m1ge4iM6KV0hCtMZet736q5hRwWh0sNww/QBbPJK6Prcr7FEaQos8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3225.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 20:47:14 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 20:47:13 +0000
Date: Sat, 22 Aug 2026 16:47:12 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev, namhyung@kernel.org, acme@kernel.org, 
	irogers@google.com
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v4 4/4] perf tests: Add shell test for
 kernel symbol beautifier
Message-ID: <7rw7wkivh5dqm6npbvvokvypqd6ueer7vqscpvx3dktujg7eh4@hfz7vgbrygkp>
References: <20260821204930.679027-1-atomlin@atomlin.com>
 <20260821204930.679027-5-atomlin@atomlin.com>
 <20260821210155.E243F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821210155.E243F1F000E9@smtp.kernel.org>
X-ClientProxiedBy: LO4P265CA0087.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3225:EE_
X-MS-Office365-Filtering-Correlation-Id: 59aeaa07-d943-4780-da90-08df008e8b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9QXZpEkqzr/zqr4J9CiSC/xVIiZVCjPKRNd3DZvZCpu9ZkrZPOQmDJAs4wBTNxpHNGYAau3t1UvL4bWChHNy06KX40Gu2C00z7qmahuLN8/mUjZ2/3YahoHbHgmPve9fIfM2tGeJE+rK3yFv7ac6UkvtQFQT0SGOJmzeqdiwJLby3jwIoNdMGiXeyPgP0xYg/BsCAy+VBXezpXPy6eG++bfaWP0/MWW6H+Ayfu/0cG6qgxR4xh9apSezA1q62GrNeelsPaWUx34xCHvLHyahjbey3HOx9Y9JZRTOlB54nLSXNQLSTyf+pPXYZOO9CGd5vYxmxDTrX8OAL8/Ocul7nuroIOnDvg3pV3ThYCTB5l/UpUvkaUUO9hrEemHf0lxg9AwASCxdqethGJyiRLM4XI6hHjevDHc1xbOeeiyGWeVc08XnoTmd4o9HqVLsbs6CHta9W5ZedzKUnVqKpURTRo6eOrybp0mooUyZfpybPj9ea5eVoolpkR7kt5/ZaNgxaGVOgxdF1exl6babq6ch4DBCzeLIu0WjnJ5Hc0KGIeOSeqpwjdeLrjKbnUpsX53g1ueFVFEwUaT4QhY35oF1Fok5xiH4pQZD2NNoeeQv1+JPR8UN3badu6Kmwz7XWMlQ4ulttoqlBQZtaZHJuerpSfEW+QnczfJCl9xw9fYtw68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0oxV2lDcTc5MTVIV1Awd1ZDdC9XQU1DVXJrRlFFdng4TWFDY1JlU3ZBWUUy?=
 =?utf-8?B?MHlHNW1NZUVGSndWR05Wb0pKdnRKNFdDd0dBbzRoeFhIcEJyQThTY3dhRUx1?=
 =?utf-8?B?QlNWcyt2elFnNjE0ekdJeXNXemVYTUt0d1Y4NkpvUFFCTDVkOEd2Z25Xcksr?=
 =?utf-8?B?UUhXbGRVVlRJZ0NobkNKNFhudGU3RUdOYk10bDF6a0pBRWc0ZUZPWWxGdzFF?=
 =?utf-8?B?SWhrVSszbnkxUUtZOVROVFpUSzVCWXFOTG5RcU1sZFhRK3I4bkJ1Wm1ySzdS?=
 =?utf-8?B?WjhRSHZsZjZNdUtxTlVHdG1Ecit3M0ZWUGtEcWptOXdkTEhvS2hTdEJST1Zi?=
 =?utf-8?B?bytoL2F2N28xcGdRektEbFBsRFVIemR2ckFQQlZrbkI2YVo0aFdQbHp1eFBS?=
 =?utf-8?B?TjU1MGg0b0QrWjU2bFc0LzdlRStMRUIwM1JIZ01vdmViZHU3NUx6c2tDM1dM?=
 =?utf-8?B?Nnlzc2pNR1VPVWI5ZmMwWU1BNnM2a25rZkJYUkJ4TUx3cHVQUkFPMC83RWY2?=
 =?utf-8?B?ZStDSVhiTmdSOU1PUUIyYWNQQTdnK3FqT1FnRlhmQUVmbDEzMWpHdjRvTWpI?=
 =?utf-8?B?ZmlRdUZlOHIyS2ZnSXRHaTlYYlg3a0JTZ3JaZUZiMVE3dWsxbE5SdXdHVXBH?=
 =?utf-8?B?Zm9NQW9JUm9RNDZVTURlNG9xSUtXZnNWRnJidlA3cjhIeUZCMENOa0xpVnhQ?=
 =?utf-8?B?QUsxbEo0ZDMxeW5SY1V3eENXcVRPR003cnN1aGZaL0xObWhwaXp2aDV1VVc4?=
 =?utf-8?B?MXk5VXpQL1k1ZkpacEM0R25mdUZJdTRSZnlsd0tVOElZUzUrZkVJa1I3MkxM?=
 =?utf-8?B?c0IwdTlETXFTTWxhZWIrb2duNnN6Sk9COGJ6Y214OFRFZjY0QllxYXVvVUFC?=
 =?utf-8?B?S0lYNmp1anZpOGVtQXNPRFZEMVo3L2doVDRNWGZJUVlnZGo1OVJGMVN3djQ1?=
 =?utf-8?B?ZWQ1bm9telBLYW9iY05SUkpTMEF4OWpPT2FhVEFtblFYOTFEMFVRbTRsTEVS?=
 =?utf-8?B?VlBUeXFrYzFUU1V4T2JuWS8zRjh6aFNOaDM3SGdMUEVKOEY4bkpVaWRiNVcw?=
 =?utf-8?B?ZUgwUFpLWmJiWURUaXB2VWN4aWJ2bjA0KzFXdzVSRFhHOXgzVTlXKzhGS1ht?=
 =?utf-8?B?Z3VTRjdDeHFVR3pGTWtoTFpFUldJMjZPUFlxTlkzQkxnWlpzaHcyMlV2NHBm?=
 =?utf-8?B?MGJ5eGRuRS9wQW90ZmhqQU52ODRGMm1lNHhWQjNPUXd0OVo4ODJlUGtDRXNm?=
 =?utf-8?B?WHloclQwRHYrMjFuM0dEVmdTdktoNDltUTVuc1R4Rk5LOERJeFBFMWpod3RW?=
 =?utf-8?B?VkU4RUtTVG4xS2xseldHcVFlUE9Ca0xtZWRxZmd5V25CaUdxUHkzTFJna0I1?=
 =?utf-8?B?NVFrMi94YmJNdVFHTmh1NzFHU01NYzU3N08wWXlzUE04WURXNFVIaHZuSlBt?=
 =?utf-8?B?TnpFTVB4Z3ZmY0toSzRFUDIxMXdOdHZIbms5M0x3alhEWTJ2SmhOSy91WFpD?=
 =?utf-8?B?eTVuRG40RVpUSjkvQmZUT05pcTBwTXd1WEVzSG5xVUJ6Q0hTbGtSbkNjeHR2?=
 =?utf-8?B?N3FtaGU1MjRiQm5pcnV2RjNRREF4NmFPaWlGekJHVjRvVkpQNmJBZHlDQ1A3?=
 =?utf-8?B?Q0daY0VZVUlSQVZtVFZ4NUIvWFZGZElraEFBU3p1UndYaFZ6L1FlUVlCVElv?=
 =?utf-8?B?YmNaSnZFTmRyaWZyRWE2aUk1c1hrdUQ2K241Y2F0VG44Z21xN0J4RlREdFcr?=
 =?utf-8?B?NVNJRUNLaUl3d0dZUVFWVEMxVGxmUHlPTzJnVnRmd3M3SzNiQjJhbnZVNGt3?=
 =?utf-8?B?RllGM2JuczBNTU02eXpIenUvRFYyam5xR0U1R1FJUFJMd2lOaE9kNi9td2hx?=
 =?utf-8?B?dW5jMng1QnUyRXJDdmc0QUpzVm5PajBJWjd5UmdLUjJxekpIT2FrcUM3R215?=
 =?utf-8?B?bWRxQVVDOTY0bC9wV3JlSkdaalhGMm14emQxY3VhL3c0Tk1zeTh0Uzg5YnBF?=
 =?utf-8?B?ZHk2WnlMVmd3UlVuc1lwejUvT3dEY1EySmxWbnNyS3V3eVpQK0hteDNNU2RW?=
 =?utf-8?B?cGxkMERvS0oxdjQzNHpDdXNoM2ZoZ0dWUmd1V0lqdnQ4eTZubEg4d2pwdFB0?=
 =?utf-8?B?OEd3M3hNK1JXR1p0ZTBSTmUrc2VlWk9NbEJreXZMUlZYMU1UM3NYNnJVVU1a?=
 =?utf-8?B?dzdNeEdFMHNXU3Jud3FVMXlXcVEwSGhZc01SdmE0MXNhVExvbndON0dHUnN0?=
 =?utf-8?B?MFpHT01mTUhIbFRvb05xZnBHOTZBMHp1SXRWWHh4RzFwWVlDVHBqL1I3UkJG?=
 =?utf-8?Q?QwP0aA+kxmaKWGR/t2?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59aeaa07-d943-4780-da90-08df008e8b84
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 20:47:13.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+QMpd4Cf9akg1nHVxsmwaYOzxWhFOcfE+0u8mN8iBoMMgZk/A5tWaIn2CSw3OsYUFMhKG/tZRySH+v/LdYT6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3225

On Fri, Aug 21, 2026 at 09:01:55PM +0000, sashiko-bot@kernel.org wrote:
> --- Patch [4]: [PATCH perf-tools-next v4 4/4] perf tests: Add shell test for kernel symbol beautifier ---
> commit c9c4a1b0dcd918dc4702b41032200c74d4363a15
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf tests: Add shell test for kernel symbol beautifier
> 
> This commit adds a dedicated shell test script to verify that perf trace
> properly symbolises kernel virtual addresses and function pointers using
> both the default kallsyms beautifier and BTF type routing.
> 
> > diff --git a/tools/perf/tests/shell/trace_ksym_beautifier.sh b/tools/perf/tests/shell/trace_ksym_beautifier.sh
> > new file mode 100755
> > index 0000000000000..c030b03e2b662
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/trace_ksym_beautifier.sh
> > @@ -0,0 +1,43 @@
> [ ... ]
> > +test_ksym_kallsyms() {
> > +  echo "Testing perf trace kernel symbol beautifier (default kallsyms)"
> > +  output="$(perf trace -e kmem:kmalloc --max-events=1 2>&1)"
> 
> [Severity: Medium]
> Could this wait indefinitely on a completely quiescent system?
> 
> Because it waits system-wide for the kmem:kmalloc event without a timeout
> or a deterministic workload to trigger it, it might stall the test suite
> if the event takes too long to fire.

Fair. I will propose: 'perf trace -e kmem:kmalloc --max-events=1 -- true 2>&1'.

> > +test_ksym_btf() {
> > +  echo "Testing perf trace kernel symbol beautifier (BTF)"
> > +  if [ ! -f /sys/kernel/btf/vmlinux ]; then
> > +    echo "Skipping BTF test due to missing vmlinux BTF"
> > +    return
> > +  fi
> > +
> > +  output="$(perf trace -e csd:csd_function_entry --force-btf --max-events=1 2>&1)"
> 
> [Severity: Medium]
> Will this test fail erroneously on uniprocessor (UP) kernels?
> 
> The csd:csd_function_entry tracepoint is defined in kernel/smp.c, which is
> only available when CONFIG_SMP is enabled. On a UP kernel, perf trace will
> fail with an unknown tracepoint error, which the script would parse as a
> symbolization failure.
> 
> [Severity: Medium]
> Additionally, can this cause an indefinite hang on idle SMP systems?
> 
> The csd:csd_function_entry event relies on SMP cross-calls (IPIs). On an
> idle or isolated test VM, this event might not occur organically for
> extended periods, potentially causing perf trace to block forever without
> a timeout or a triggering workload.

Acknowledged. Instead: 'perf trace -e timer:hrtimer_start --force-btf --max-events=1 -- sleep 0.01 2>&1'

Kind regards,
-- 
Aaron Tomlin
