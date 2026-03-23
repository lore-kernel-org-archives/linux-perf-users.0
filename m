Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F38370D77;
	Mon, 23 Mar 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262473; cv=fail; b=t3MEzz7l2V3E57XQ7VIpyA+tkMYaDKkSn/F3nl2wALZMNRpdHkC0Jn20QuLjRARDSDyTe4XgNg9nZu/A0jRDdLzUz32z64k0yqiqqek3gTwgXn6z7HMtOnxhYNQF0OnPEFmqkux8ATSe/PFu+h+jCioFmIL1APHo7l/VgWrpj/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262473; c=relaxed/simple;
	bh=Huum9issLk/l5Dgif7ZihqZCQqZq85Bavsu6UoDSbUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uaCW/lWGAmf8xywOgY6qPpwOYFY96iyyn+W/u4xs35oWR5VYfBYwvnt1/JwtVg5bxPeMLf4jwOnJ+rrkqwFDDlppWLp/WE6hXElPi0rORBw3WwIPrhOfe++8jzQLIJH5A/+c9dSzPU/RWTlF5m3e5+Wu1CffZnKJx0bCg6SgaZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LSxfK+Lq; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LSxfK+Lq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjyWu+A6m6CfYWK3KRq2MbSMHbfk1rBe9sWL8/7jkLEh2MOmx48sErFt1IbSmHZLdqeKJLPR8XL6SG6THLbf60yqvvMYshdR8T7fOEpUjoD+lwtb8evJlExilsbrPWVz1gaJUgQvxb2dEvKBUB1FhwMjM1GAC/YNDC0BXScJbeHQJcsYFkAKkWBdyAjUbW3RlBGWyZVXbVoQeq3HNh8hCjY8Dt8e1Om8AgC+hVXFwpEy4m1Bm1UGO8ZDPx4h+95JvT/WGmzoSeS7Iphhr2BP2iC2rCRB11dEApX+iXeEQry94jW79WTfFTsCiNNSYXLFINxna64l+tJfn47QqXNzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWAcZhplpV8uv9ZxplHnDG4mug8pBstGmAMBA+Wch5Q=;
 b=TCOUKzm54qEBzKuaCpi7LX5DYUfKZYSlSt7H0buIJGaxNafb6s5BSzJE1ct4NzX+bH2ADGtC+mHZffB8p2ekcTa1HtcSqqAEmCEGPrJ2FxJJAB+akZ3GwX5huGFFJZXXZPpVxvSSS2UPLIIdd7NKwV0l2PCZA5d4JLS/jUg6jECNpB4TNOZatwkB1XCw6yIn8Sup3EcL1Dhb8TZEtin0gZNFxOHUD1LeYljthfIZ1cFvWB4pirIRkOmGzhAG5muqN/GoVqTocqeI3oXEDwLaniANIKlWyIX1iCRtJq2g3vxvdp+6bvybgaRh2tDTsttopFAeiij+FyGwOu2esNwIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWAcZhplpV8uv9ZxplHnDG4mug8pBstGmAMBA+Wch5Q=;
 b=LSxfK+LqOGiYRxXQqepTNldkAZ7ZV7X0p3dzB+ieTjkYm2/ISTQbNvpuqLBWrUG7HT/MfPcArcCPrcnoC34K7BgV0v1Z381yUvd6ho9tW/+jGVmDK0lNXemNtKiobIbnGCiy+yb1J5+MJx0sa04VDHYdsQ/lGTeUHeoN67nr34c=
Received: from DSSP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::17) by
 MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 10:41:08 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:8:3d3:cafe::31) by DSSP220CA0009.outlook.office365.com
 (2603:10b6:8:3d3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 10:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 10:41:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 05:41:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 05:41:07 -0500
Received: from [10.143.205.249] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 05:41:04 -0500
Message-ID: <d6891df0-25a1-4bb1-a7e3-364af9282d68@amd.com>
Date: Mon, 23 Mar 2026 16:11:03 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf tests sched stats: Write output to temp file
Content-Language: en-GB
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Adrian
 Hunter" <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260321061448.810525-1-irogers@google.com>
 <20260321061448.810525-2-irogers@google.com>
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <20260321061448.810525-2-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe56628-05e2-450d-7629-08de88c8b12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|921020|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vecnyQ0w/h16i9/X91sgT0Hx71FE+6bW7yQCsRqfrfQoPzSQFwrbr9YMd1loqI1rmuhSVjvwSr3Qmhtp0MPHgAhZcdaiG4zi++Gfo6m/jCc9511P2k+g0VCI2qFppFFqFEqeNxfVO80Gw6CBFqJslBaBKNhiyg9MLIzCLWoFxIDpyK9VrVovnWHqtRmkoTApgtjC5jP2QivwRu78aVqCjvcEqkEoowLiDWU0qgxxJgkFYgZvQ3kbZlQ8Vy833rwUQvheGzeq+Wt35tuZA0E7aty0uiOyPERvZ7NB+QVcePfSYu4HZN8o/oK51Kth02oa6pIEFNJeU8T8w4IzIhi0cEXUL5eVWVpGre9OEHggrJ9DNqepXsOFEU5Y/CDOIZaVxipuBp+12j9qn7qdH4oame5WizVJw/t7fQbcP1W+QR36W1TK4wwbtf2Lwaj+8Rat973YRP9ZcTSCeufcTL1XcbGeJ6+8fvTRkDfcRc6Dpomp7v3wHFeStYP0C2KPNCpRboRES0CB9gej5LCBDlIX9nErZL1b76r/e7KHKVnGEwIw8PK/nJv0zAiKlXDNK6jrn78CryQjO6Uj+KCdpyyyM98M2yvcaZDEN00R6B7LCmTE54QQD/QqfIZA9HbcZTMDTOiN1TjfBU6w9uWvbrCQdujCOhk+ehgKE1fq1AuscOEhICRDSm6VlyShHm/Frt7zfbd1aZLDPBCsCUDL/y2ZR0S0vbw6YEHM8JY+SpSJ4kvPsqOK74P0QcoZwARmfe8gOlV5BpXeW3GRtQVWoCXdhq8oD4z+jZNiymEqG3uF0hEKR9xu5ABLvk9YXlJVC8xa
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(921020)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IlfOp7Bq/B8iukfwWEHA49/8LBPI40pHqhvQyh4iqOr9A39jujuTTUz/cqbwjNHXryz3k6/QzXjAt6cBAsOngmjzLrLF9W1d1gee2C8FtQ9pExElDq6cpjtnWmCb07ZUS1E35fMeP5+o43pB2i8WpHtMwyYqNz2pruYFkcsKFSrscFov828dpIeLMwCCgcZ7qsinaH7+f0w0/G0YTNs9JHpVQQMYDX3wuCAsNTz71Vk9iqmqTnXDsedaKkwUrvpOlXANvSyQufJKPoyBxFehYv0NcmHAlG/7DA7pGDGLmlxRONmhhLhAtppR+2TfNoKNi62TqM9bYrKcN69JA44wVCSQgp9mzAqlPp6UoszjPXf2eaGSWDxiEBFDLIca8u68C3GLNYHGhsQrkYMziz5owIS5u10TbSz4/xt8b9IRQ6w+RzzbjShNRZ6XiQ8IU7UY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:41:07.9711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe56628-05e2-450d-7629-08de88c8b12e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437

Hi Ian,

On 21-03-2026 11:44, Ian Rogers wrote:
> Writing to the perf.data file can fail in various contexts such as
> continual test. Other tests write to a mktemp-ed file, make the "perf
> sched stats tests" follow this convention.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/shell/perf_sched_stats.sh | 37 ++++++++++++++++------
>   1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/perf_sched_stats.sh b/tools/perf/tests/shell/perf_sched_stats.sh
> index 2b1410b050d0..bef7714ef37a 100755
> --- a/tools/perf/tests/shell/perf_sched_stats.sh
> +++ b/tools/perf/tests/shell/perf_sched_stats.sh
> @@ -4,10 +4,29 @@
>   
>   set -e
>   
> +perfdata=$(mktemp /tmp/__perf_test_sched_stats.perf.data.XXXXX)
> +perfdata2=$(mktemp /tmp/__perf_test_sched_stats.perf.data.XXXXX)
> +
> +cleanup() {
> +  rm -f "${perfdata}"
> +  rm -f "${perfdata}".old
> +  rm -f "${perfdata2}"
> +  rm -f "${perfdata2}".old
> +
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
>   err=0
>   test_perf_sched_stats_record() {
>     echo "Basic perf sched stats record test"
> -  if ! perf sched stats record true 2>&1 | \
> +  if ! perf sched stats record -o "${perfdata}" true 2>&1 | \
>       grep -E -q "[ perf sched stats: Wrote samples to perf.data ]"
>     then
>       echo "Basic perf sched stats record test [Failed]"
> @@ -19,15 +38,13 @@ test_perf_sched_stats_record() {
>   
>   test_perf_sched_stats_report() {
>     echo "Basic perf sched stats report test"
> -  perf sched stats record true > /dev/null
> -  if ! perf sched stats report 2>&1 | grep -E -q "Description"
> +  perf sched stats record -o "${perfdata}" true > /dev/null
> +  if ! perf sched stats report -i "${perfdata}" 2>&1 | grep -E -q "Description"
>     then
>       echo "Basic perf sched stats report test [Failed]"
>       err=1
> -    rm perf.data
>       return
>     fi
> -  rm perf.data
>     echo "Basic perf sched stats report test [Success]"
>   }
>   
> @@ -44,16 +61,14 @@ test_perf_sched_stats_live() {
>   
>   test_perf_sched_stats_diff() {
>     echo "Basic perf sched stats diff test"
> -  perf sched stats record true > /dev/null
> -  perf sched stats record true > /dev/null
> -  if ! perf sched stats diff > /dev/null
> +  perf sched stats record -o "${perfdata}" true > /dev/null
> +  perf sched stats record -o "${perfdata2}" true > /dev/null
> +  if ! perf sched stats diff "${perfdata}" "${perfdata2}" > /dev/null
>     then
>       echo "Basic perf sched stats diff test [Failed]"
>       err=1
> -    rm perf.data.old perf.data
>       return
>     fi
> -  rm perf.data.old perf.data
>     echo "Basic perf sched stats diff test [Success]"
>   }
>   
> @@ -61,4 +76,6 @@ test_perf_sched_stats_record
>   test_perf_sched_stats_report
>   test_perf_sched_stats_live
>   test_perf_sched_stats_diff
> +
> +cleanup
>   exit $err

Tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

--
Thanks and Regards,
Swapnil
