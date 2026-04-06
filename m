Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748E2D0620;
	Mon,  6 Apr 2026 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775453400; cv=fail; b=ZB0BSKhm2bBrZK7tROyF0FmxD8uekDfsMkzo6v0WAO5Z3rsye9a18JBIOle0CZnc1ABDWCkiZIQmDZ5sfm+pOUfm597/o8XDa1+fe52WEDyrtCwveUW9zGRZvOLXmh7pIRDnfsRxbcGlWba87WjPBK7tpTegkdY8ePF+MFZVykI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775453400; c=relaxed/simple;
	bh=cEC7Yq6e864hLB2wAfwlApT0tyfJlHBpvpZYHph5Tqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ubV+48mxeOqV2ldKhsyktQ/FTzEqb5nzmUj/YsOqKfb/wy2BqfKlFqBPSqX2nbVugP8CRuSt/R1w3Nphqxn28CtvwuwaMW8mxQ22sbulp7YaYOEibvxhEWtMuNfmQHJvs43Q8NwXYUiyM4K4cLJKi1kGrDfeQo6nivd9axHVEPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3JtOzTRv; arc=fail smtp.client-ip=52.101.53.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3JtOzTRv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7zCxpLHnldPTXmDDCLAEN2E55um1mPtOpQi+sf9d0Ac9XuHdb5fhA/U3frbbUDUC1p4hwIlfvAJZoswnY/aH8z3LiDKmngYwCYEp7Go0xh8dMpbNqi8Pp6Cs72E+zyo1g4CRA0GaVSn0Ddob0zt6xVcuTkzbGHhKV8RWPe5A1ufcYDTXGQYk/kzWru1scPTMHcBoscVtf15W5nw32dPluLRQB0ttug+35F+wYVuiI7caNZevNA2RKqBnFWsB47hVcF+iQxI8IGr+iqUIS26utL7R+STTgtx+jj4xfLNFXSxVvIfB0+Al1KYg4qnSV5YZj7Uuh+2J6ElrubV54z5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SwdxTVpNU/sbHtHhkbCpa7dAgkBunWBpl/zABRC4C4=;
 b=eFkr6t+aNilg4cou6AfhfllKuC8FwDzk+vLt0rJs0DVP5MWCcuwaDleqIJD0bnmt/PwbSCnNRVdjnx984JjUoCUoOgD2bHP+LWZ6Ocs0KUgNoULFATFWmkZIrTc+RFk3swqtX6rWeLmZL7duNF+/lOr0DQ3qnAzO+mbUrXuibWVfCp8LYbhXmlKAzxZ+1HDm1oa/a1CB1Avk6J7+/MXvL/E2u/h3pMUFV/4n2KGr+iXaf11ZPyV5LmDpnKGRM267VRc1XR2TrjkLU3da2HWXauOG/XpRSgHP3Zcb4VBAYEv1w3U+NAt3LQy+cUHi+ohxf0GurnYYiWwa7jARQMg2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SwdxTVpNU/sbHtHhkbCpa7dAgkBunWBpl/zABRC4C4=;
 b=3JtOzTRvaGlHrUo/hPM5pI7qyBAbBUQS0zYSx5YTclep127tXJUA6o25rlicAqsv4LJ7EXAfTP5o74M5eY+UVZsocXaIUoNcCwP1Jpr2zDQapJp5n5/OIst1p/vxOhKChQtciiMGFHvxNVCecCtKn2Pu/dvzV5rE6kLD86Fhj3Q=
Received: from BYAPR07CA0077.namprd07.prod.outlook.com (2603:10b6:a03:12b::18)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 05:29:55 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::7e) by BYAPR07CA0077.outlook.office365.com
 (2603:10b6:a03:12b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 05:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 05:29:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Apr
 2026 00:29:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Apr
 2026 00:29:54 -0500
Received: from [10.143.192.133] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Apr 2026 00:29:51 -0500
Message-ID: <303dfa89-9f81-4a16-ac28-03ab00be0f09@amd.com>
Date: Mon, 6 Apr 2026 10:59:45 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Skip sched stats test for !root
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Ian Rogers <irogers@google.com>, James Clark
	<james.clark@linaro.org>
CC: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20260405051644.61511-1-namhyung@kernel.org>
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <20260405051644.61511-1-namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: swapnil.sapkal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: aabbbd36-4d3b-4130-1ff8-08de939d8919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8pefDtJqBxuzf+mqfiP1y0nW6AM+yMYsoGVTbmUWheQLOc5qIef8yooLivpfUMXI+mUgfh/B7eznBcfmrPX8cEVQ7Vjn/6U9CBnGVtLCuiTLVQrfp8INqnCk5iiGwoT2kfi3LJl2co20yUUvuD/DrW5+0nviUXwxHLd0sGildyYUSJc8gYUtMrtmTTvo8oHHpl+m5gq8dHfoFBsGN9VnHsffR34H4DouSFp0woo83RPv6roWc20F6+Fo+9DuCYLEMVYz/MFcJMEzIGWc+I8H0WRTYdmjRWDhkS7LYgq3gIP4sjj8S0Kwnzna3LX0Fse/2WB3hznVrW+LCBIs00IbvVgth6ngSPkEhUl6aWuhC3iFcpJS6fRF+JTDz4Jm3vfvtsPp91qvT6/5BUAOgiIUZwP468wSwlYR7ZAVXxxJw+b9knFxtiEJFoqScf0wXVI3Gs4TNbfcLh09vEvJ03ZmBG/mmO2ncA5on9ifvtWIdkUPgEYzNqdlwDsPcclV0D2NiFwmHFHt5VbL4mroMv0OWMenJr4X/fPthlmdX8F20M7DBYuOS9rJBUQ5dVhr7Vapa9WSWXNad72E/zMPTiYvJnOGoKYn3Mf5CJpn3yfswAaB0CcLfbU622eS68QjDbn+t0uC1Z3XkU9jK6kWKUNBLZ0dyrYbYmtJT8CKXEkYPv8SB/V23sFDrUelm/QIOZnd02RS/9iN/uT5rBsiCSlO7OaYHBaXLMHpTJQZZMMd6H/IOFBJX7HPEt5t/Z1ttdk4YaNGn17YrCg5L03dPFvfig==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aEw5ik74CKzTyz/WXRtyeTzhaPYU/rHVnL0WbdWOh4AzNNi6FnoZTy5NVeQ/bYLbD1M2XtRa2A+tv5jtsMHMeey2IMzj0jPJuDyq7KroJaMiM/S3vS1ReUcgd6SLMfhwtwYRPbcZ3YogfQeTJpwy+SU8DX3YISCDRqKuUTj7jzlKWaCcdCsEX5kYuwT3aAxijMBdxbyKmVTgzH4TlXO+OTyHLT7+5jdRNc1v/00xOo16ngCBW4Mrytpf2nOi5Dft6Cit9DiPJs4zKvv7XBJSPqK0enQ+KTMFL3LtBSYnKxa0RGIGjrr6Uj09675IeXDZBnH00honW7AWbdlUdOowhZn4YDjx/fw7rwGU8Z7QEuT2W89UHOTpqiKPV5uh4yfBRtQ2Ou02B1DzCB3+klYK1tscV4LeyDMXQ6LbHnQBR307t2VV7ohcKUhehJgm1eKS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 05:29:55.1118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aabbbd36-4d3b-4130-1ff8-08de939d8919
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492

Hi Namhyung,

On 05-04-2026 10:46, Namhyung Kim wrote:
> Running perf sched stats requires root and it fails to open the
> schedstat file for regular users.  Let's skip the test.
> 
>    $ perf sched stats true
>    Failed to open /proc/sys/kernel/sched_schedstats
> 
> Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

--
Thanks and Regards,
Swapnil

> ---
>   tools/perf/tests/shell/perf_sched_stats.sh | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/perf_sched_stats.sh b/tools/perf/tests/shell/perf_sched_stats.sh
> index 2b1410b050d04737..41ee41fbf0253d55 100755
> --- a/tools/perf/tests/shell/perf_sched_stats.sh
> +++ b/tools/perf/tests/shell/perf_sched_stats.sh
> @@ -4,6 +4,11 @@
>   
>   set -e
>   
> +if [ "$(id -u)" != 0 ]; then
> +  echo "[Skip] No root permission"
> +  exit 2
> +fi
> +
>   err=0
>   test_perf_sched_stats_record() {
>     echo "Basic perf sched stats record test"

