Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022086.outbound.protection.outlook.com [52.101.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529EB37882A
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119979; cv=fail; b=l8jOzav0HXtS1C9C2pjruNyV6an5y0EcZmSf8l9ecAKsOHFi+CJD5HXT9DiJN/wtWyKs2XdvWATPn4mMtlYSaMsz6951p5XMzQ6mwRLIUVZLLLYhtYt1/LviX7Zqsjbdbbl9hmkea0FbGDZ4B0y0tu5iw3vpu2eF89JEPNi0pVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119979; c=relaxed/simple;
	bh=msa3/eMpQMJF5/u0P43vgomCGfeRXgF+/BTBPpfMeYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uhtkBVIp+8sSBOq+wI6PO2KMAcd7typ8Wo7d70kGo5x1l/dC25rQQQqne7P43bPj6Q8VuixWJFJh7R7d1ZnN/cYXl5DwkEDu41XMSpIRFt7j9GNAih6904L8qrRikIb0Aq3lQsaXxf6wLzy5doKoTI3yB9XuJt2T4EWwNVnPGHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kALBRndhhPJVJgsrloGTd3sESM3o5bkBCnJaoeCnCoFfBwcusSe6ph0qYpsT9Ox2fgR96FcPt8trz62EZWZXI1eAUOOCXocWwRaGWraeqcgBRSGF4y7Dywuk7yq0JXEy1yiv38atZLdmmN7PCmmwRfdCDwBjzG444k1ok2oDFEcQ1+rSWRGCQP1UiWltLMtjyphMCptcMRic7EEdAB2yzYTv2ugzq0qV3MM5BLILqDXuocQcld6G3UFu3aaJV2smUvBgBM/gRkzmQrC1ulZ7IUrLJhT3x0WeNF0HX5TEFySuadMTWE6/G3h3/zSXbuSuSufKiqsnJIsqOl8neil7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=tu2Ln+ANl5v8tW2WcIOqvToyN48K8zZTYTGOdPfcrZA=;
 b=jmr6GU53d3vJl41/kQhAab69VNAQv7ZkI0FUk/CiDO4ZS3NK9nSMjmdj6zGTok8D7tVZmFjciz6aDjZiLhujOOj8IU6G6Xtjp5ndqZbp9SQwBAScP498GOEajoeUp8Pr3f8cvJOgaaQGL5YKDB553/jlAUpul7TxAamUi6ihgsoYaDLD6EK2M2HKR7/591SX+ETBxrCyq1zlzZBOuNh/DH6vrtrkv2WbzNEDNirjSp4UN3S3WrCJiSWzgNA+QN7WCYMIVyyRvg+wMjMIzlop7G2iUuCl8fTdb4dVHI24udIaBqXFD7950gYQkKcHALMTS3dSyOl2YQC5mnHIRRe2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8679.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 03:06:13 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 03:06:13 +0000
Date: Thu, 15 Oct 2026 23:06:10 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v5 3/5] perf ftrace: Support display of
 inlined functions in function graph tracer
Message-ID: <bw4dfy5nynggysxoqgtvrvpvltbwzfcq4kghj4damvo236cryc@cwxnnu23542d>
References: <20261015011155.414667-1-atomlin@atomlin.com>
 <20261015011155.414667-4-atomlin@atomlin.com>
 <sashiko-outbox-172087@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-172087@kernel.org>
X-ClientProxiedBy: BN9PR03CA0769.namprd03.prod.outlook.com
 (2603:10b6:408:13a::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: a0217082-6a20-47d8-fea1-08df2b326fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|4143699003|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dZT00MI6nxTSKJzVhJxMDnrrWJInP7xy9vJzrLnXNGou1PNgp8XJBp0FsMw9lkdgEYvcEREAgqVUKUo68FjzXTM1qvlJCNys0Yp2mCqQrXsSnGdGJB7YOx8GSswKrT3DIqwUJ9LgRsucjuBMlkMQsDcrjet5nq1zBSHIVDBQGEH8EvA7I8l5LumOdOGEKieDu58MJEYd7laOEEUnzGLKA12f3v/w/4zMY4p7+oRd6d9iLEUkrH9fPZTzozNgfuL3aKGkNdh5A0XbXxdBnhtJXPnP4Onu1OLKS3IxIfsjJ6DCyhUpUxFrYl0uxb/tla8uWYtDO+vWw5gTYvwrOJx+c4SywKQEQ9Z+OEkIDc/YA9VgTTkv52WO4q8bPd0F6fD//tXD6eN74X+tZm+2MXk7GwDSlmDUmStezXFhy+MzCKAFzoTiQPzTI7yHPEjZYdZx1wn2sNnXR3sEAwXh1trO3ug1Kasx9qo46XZgK3nFUR7PKkSRc0grfMnnZuuRkUTBHI6dSXa0MaFB3+9WaWe0LcC6qaqLjgQghlLMZkD1iOSAB9k2vI941r7B0pUvHJxalLzaKEp4CH7zOoPdeGQ4UlGe8o/dGkcWnc86m1ElQrD8V0cCOi30YOD96JKPyZ83+rQHq+rfDmbNq1MFEHHeU9/gwrQ8G5ZLvBupPmbImy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(5023799004)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUdBSVFPUkZHMzRUYWJGSldBUEdnNVMzZTc3bnVhb1hENjEwQ2U4d0pNa3Yx?=
 =?utf-8?B?MTduY2NSRWpNTTNpSFh0SXY1WEhWd2ZmT0tiRFF2NzhsQTNSZ0VwMFF0bHdo?=
 =?utf-8?B?RUdGVTRPQWozZVVTN0VETlJybDl4Y2xYL2Zkai9kWnBubnhGdWJSaC92Z3Bi?=
 =?utf-8?B?RWNpbEdoWTErNEJkRzVwMUMxcXJXWmZJMEsyR3ZhdGJQUWswazZycnJ5V1RI?=
 =?utf-8?B?WDVSb2pJNmpTZCtLK0hFd2svUU9zVmhyaHJ6NVpHR0RrUW1nUERjRG9QOWps?=
 =?utf-8?B?aWU3MFBFU1l5c0tPT0VsdVRMVUdvT2x0aXEvaGJHL2lWNjQ2a1VOUnF0S3Vs?=
 =?utf-8?B?U1EyQVB4WjBmMnhtVmhXYVVpNjZNbHR2Wk0yNkp4U2l5QVZhMWVKQ2dLM3BI?=
 =?utf-8?B?MXFLZURBOGRjZlp1WUhiTUtEZ0FGMnRqcnY0cW1YNVRkZFpJbjRvalNSdWZi?=
 =?utf-8?B?R010YWNqeFllWUgrNGxIQzJPYTlVV0VCRDFSczZ0VjVETFQvWWsxN1dxZG5N?=
 =?utf-8?B?S0Jhd083N2FYdEI5UFVMZDRYcWJXVUZsMlpJWGxla0RvenVKMmlHaGxBSHA5?=
 =?utf-8?B?a3JwVlhMV2hYSWlkbnNUZWt6NW1ZTS9YWmlENzVWVm9wR0NuQk1sRTlGVUs5?=
 =?utf-8?B?YmJZa3AzS0l6MWhVNzB1UkZRdFozMm03aWIvWVo5c1hHVExtU3ZES28vQ2pW?=
 =?utf-8?B?eTBVc3dLUXQ3MTlpakRvTFJpVi9SdkxvUWhXY3BZazczSGJqMTJLbWdUYzdw?=
 =?utf-8?B?T3ltM2J1dkZxaFZQYkR1emJQUCtQMEN1L2N0REMrWEFCVVNibDBiWFhTUXM3?=
 =?utf-8?B?UDBHUmtjUHlhaVVRbmRVSDltZ2djNWkvOHFjUlpYZHRhNVpsSGtkM3paOWFx?=
 =?utf-8?B?NWRoYmYvN283NXFWaitjeU1MR1UyVXBRTzNZUlFBeXRrelZRSmExcmZjUytQ?=
 =?utf-8?B?V290ZEpRTUlGY1lpcGtKTVlvYTh5N3lLYWpBQlljaVFWcVRlSmkwbGV5VXow?=
 =?utf-8?B?Yk9XcklpWUppN0ljeWljQWlhb0FsbkRjZCtuTUNVVW1JUmRaZmlxUWpIRCtT?=
 =?utf-8?B?UGFKNTRpQURiTzdVb3pGcmtZYWJQVGsrQ3J4Zk1QaHBuSERTRFAvVXR0ZVhx?=
 =?utf-8?B?aVVESU5tbEJZY3hsNnluT2lzdHA4UlVITDhnWkdjRHpiTkh2VG0xT0dzYjN2?=
 =?utf-8?B?V2ExbUY3QnNQUlhFd1BMRUFYdE1vZjk5bmlUc3gxTmozRkZaNkwyY1VSZkxF?=
 =?utf-8?B?RFRMYVVyOUg2NUpZRkI4aDZrWXFhblo5Q3ZUNzJ0VUhyN1V0RXlKd1A4SWpT?=
 =?utf-8?B?anpjK1d2NzI5MW40akVwak1NVnhBaWxBSGdjQW1mbjRFUjNwTmlCWTdxeHdp?=
 =?utf-8?B?cDQ1S2lIcWtQUWgvb0pnYzlrd2VoaFRvd2NQdDlHcEZibHJvT2YyUmdTTjZ1?=
 =?utf-8?B?RTI3RjFJSXEwMU9NSmJrRERFUWZ4K2NHS3JOckNzM0N0WUNOdVMyRWJ6L0ts?=
 =?utf-8?B?c1BaV2o5czNaQ0ZVQjJ6TUczcGxTL3RmZzJKM1plWTh4RUZUZEVKUTN1WlNj?=
 =?utf-8?B?MWtuNWR3cUhNZEQ0T05PNWNnSTd3RURoUVFTeHBzbHdJQmJJKzNHWXlOQXJD?=
 =?utf-8?B?V3RxS2NXUFN1UEtCOUhqd1ZpRUdGT0hmSVJkQ3owNEljcXpndWNRdmlIYTR3?=
 =?utf-8?B?Qy81VWd6QmlJNFkyc3dQeXJLZlo1RkUrcjR2M09nL1cvYlB4UVF4TlgrUUdW?=
 =?utf-8?B?ZUJBLzdGNHQ4S1h2NWl3alMwNnNLS25QUlNCTyszZzhCenloUUVNN09ZZG5T?=
 =?utf-8?B?WG96VTB0T0J4dVYzUGUxWWxNRE9zK2NteXRWT3FNWHNIekgxQXJQV0NkR2dD?=
 =?utf-8?B?S2lOWGdTQmJUc1MxZWFGUnlMNVNkQWlVeTN1eVdKY3FSWTZoTWIrTjZQalla?=
 =?utf-8?B?ZzMvWkVlcG50aHBCTkhZQkFwcklhbmVMZFE4eXRITEppQkJKaEEyZmJuRmpY?=
 =?utf-8?B?cWZCeitNbnNJZ0pvZ1hKQlh0bEtoZ1RVcW1uNVJTUDFIbGZPUGxEdVJ4V1M0?=
 =?utf-8?B?Vm95QVFKK243bEIzS3dEakQvYitYL21QVWp4ZnhvNTIwQWNUTThHODlWNmdT?=
 =?utf-8?B?ZFRtWWNBU0J5UTM5K2tFVFdUeEJLcklQWnFmZ2lWRFA5b3BrcTErc09FcVl5?=
 =?utf-8?B?N01oR1ZMU1ZlWEhUUnFiRjhkbHdteHUya1dsOGtWSllPYko2VGUwVVR2R0tN?=
 =?utf-8?B?L1VwTkFUSFBpMjdqaWhsVnRJMExhM0p3eUQyQXljTmpUL1NCRVlHUmF1NHpT?=
 =?utf-8?B?R2NBTGMrQ0FHTWxWQ0p1TmcrUjNBa3FReG1GR0F5U1poeVlDMmdBUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0217082-6a20-47d8-fea1-08df2b326fee
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 03:06:13.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gya0QwD6YMnm5i8oDrt1k/yilLhv8BgLbsXF03p80PPlXt+s+eSSHKHusc+RtP2VWSWFS2Vhy1KEO4URPnhfBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8679

On Thu, Oct 15, 2026 at 01:24:43AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Does this code leak out_buf if the assertion fails?
> 
> The TEST_ASSERT_VAL macro appears to return early upon failure, which would
> cause the execution to bypass the free(out_buf) call at the end of the
> function.

Acknowledged. I will resolve this as follows in the next iteration:

	if (!strstr(out_buf, "|  base_func() {")) {
		pr_debug("FAILED %s:%d no indentation drift after stack saturation\n",
			 __FILE__, __LINE__);
		free(out_buf);
		return TEST_FAIL;
	}

> [Severity: Medium]
> Will this cause a build failure or pointer truncation due to a missing
> declaration for zalloc()?
> 
> Since the appropriate header providing the prototype for zalloc() does not
> seem to be explicitly included, the compiler might implicitly assume it
> returns an int. 
> 
> On 64-bit architectures, this could truncate the returned pointer.
> Alternatively, modern compilers configured to warn about implicit function
> declarations may fail the build entirely.

Acknowledged. Moving forward, I will include: #include <linux/zalloc.h>.

-- 
Aaron Tomlin
