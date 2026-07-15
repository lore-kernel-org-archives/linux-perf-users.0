Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA31417D7C;
	Wed, 15 Jul 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138538; cv=fail; b=O8qqaInOw90SXTlKZNUsIFbedU2kves+qDq8HZXQRuxh2u+kX0mDBFC0jD3WealpWj2098l1nl9VZg70GHcZdCjwoPDC3UFHgPMKDD9eELuv36MmuqAZ2ofr498KacA0wjJlpSp20QDV255At9/i4BPqpauaYlfCa88i+ldX0qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138538; c=relaxed/simple;
	bh=YEGUl1SHhXjr3UOwRLRzKuIpRQN+vCbTN8fB9evEyYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kZ5aDWSOSGY/QE4YLIqCptd1xbr+QxzRfCR5E4uuSZNJz9ELojCi5j1YAnWq5w1S6R/xDakJNhWyunxQidByjWMK/uPZtODy8siTjgQAHeZQ6GjqokgVXXmLbOT3TiYKL5zQcixWFjJaMHyJoFw86rknCBnFDANGXbkSCLPdStA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SfBCoXp1; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SfBCoXp1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHouLMhokdt3127gixVHKTKj1flgj1aFHNqGp7+DRe9X4D3R7YGGXSEJVmZmnE5lXyWcxZky2P0ilJHb4eQBWRbyAreqiss5zQzI6LALvlVAcNsCiyccxb33sQrTbXvttfF9MuCtUJrpLq5CMtDJJk7plIhB/Bo5zUcWRncRZ1mZOoLt+hLmFJ7UU9bTINJWs0JckDaZSHVXavnKJ5N7xoqx/GFPWDcLa67EHx7Xl94ybtYzpB9ARxgFpkdTqvOLTlzP88+4e4meY05t1XQVQkB7g4Ly+OvngChOvLYDbvmc0LMpfmV4+18t+Hv1fp7D09dqPvhcVx+ugq0JwTXz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/B1KsGYoqnYSxc+QZGs+Tokkg9rPG1JPOU3ZbrVv4Y=;
 b=jfzJpHXqT25vNrC1zT4zeaICmFfem9HghaoWzN+W2R1VjCRN2EoivGPChcJzPNq4p5ksdUbqkZSts0Ds7YCXKMgsHYibFmsHIwfqkPcc+lkjvCa3A0hUIlq/ofxWvs8wcP7bEcbiuZZV5BAqqtiAqEee+svO/VCzXlfv1KEGmz+5dpPbIwMui+P84Txzcw68n6Xz4wfxkbw3F13ms+6nJl/noWBh59R7TTbtWjvJRv9tPHN5bBgs5XKhH+vbolGbwGm5PSSh0DqQ5uEMVSAmlC6l3iPT2/UyqGUSt23IljK1euQAE7ZOaPJWFPltoFBYzMVpIHaQD+2yu07EO8Injw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/B1KsGYoqnYSxc+QZGs+Tokkg9rPG1JPOU3ZbrVv4Y=;
 b=SfBCoXp1PmhFxvSODQalvTJwTG3yWl/QlINhn9axhgNLrXgv5NXIGXm9qUZQopARK7727ChEMHJsXEODoAYrhOd9l5AyzaSONx+OgzKwiJ4TA51apuZ5bAPgy/6nWvKOcR4oKKEWvXtqFTusLFbNypT7QyBqLhk1/DL52O8aI7c=
Received: from CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::26)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 18:02:04 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::54) by CH0P223CA0011.outlook.office365.com
 (2603:10b6:610:116::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 18:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 18:02:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 13:02:03 -0500
Received: from [10.252.223.236] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 13:02:00 -0500
Message-ID: <6e0e6934-2b81-43f3-bea8-bb74656edc5c@amd.com>
Date: Wed, 15 Jul 2026 23:31:59 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] perf sched stats: Fix memory leaks
To: Namhyung Kim <namhyung@kernel.org>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
	<irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20260713234536.2280374-1-namhyung@kernel.org>
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <20260713234536.2280374-1-namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f69230-44a2-4fc0-c7d2-08dee29b2d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|11063799006|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	mOZtVPshq351ph653bg3tDFiIbUbqXb6CKXklaogkL9ySD+rFmkXZzRBsS/KHjAqsTgqVz+peJE6R++KjEt23ApSCqYSGKj+hgF1vpFpRb8CcmZLAuzEQnPE9ESxKUrX0eJf/xgzHmC5MfAwWtJxl3Ao1Y52Y6/FmzhEey8u1WmSYqhq5I/7AYN6ErDbC9pdx2VEtLJO9V2iuS6PKvn4oUUI73hDEd70jlQ13YjuFY/k2zO9w1YXZUHatjEOxc4kFUhOLBoeZpiJ9kEdsUa3shDszIL+lJBgbnh/lgIgheKf37F6WJx6YSW3EjXUsr4227S/QKZLiMAo+P7GMg9meNP3uQi4myAFbyPalFkOi/jbG0+0iiTMa1z2BjPDg/m7qZtuFlsA+GZ4Wymbf0Ios56NHemJn4M35I9CVgVPedL3SRK8VLXxCmBM2Dx4uvlhECICguwG4XO73pIAtnC/oTLcNs3EmOmWIQOogxlBsHH4irXNjrvzxhVuW36P6I0ROYp5NM8ZETr9wBndXlnJz9Qob3b1lBfPKoyHxlCv2ztVaGfE5zlQMxXrykD3zl2LCv3pNE9uUX/MeHdvJVUrkkH88Gyfday392RAxII9KsPxcSqkhoMsCstLszJ2+kB3YLvroaNZRGujWJkZPF4MM/zlp1clDNk59HWtbaARg+vnGMKFv1/yabS46yFeud7HitNQFtGACh9v6NQCDwr+8Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4GOs3lbsd8QYheV50oKBfaqi9BfJzp4ejrsqp98WX8lP6Ufxt9xhCNtXW9e19yoi+re4lbzbKRqX3HKFYebCbtzBoMGujeNfd/+LKv5+YQiolpY5N0zKxch1paYJResVnpBKx4TJQ9ZKgvrN1bnu7vSaFqyai6/TEpZQ0cUb4A+lKhIc2G71fLOP4zy01MvuquzK1aW2CwxTN+GkxCboSsvaSnhYOHMnkurAEaWC8feJ5dUwyH0T8E7uZkJPqsWQHHirCeBeiGhO+/sFlYsD2UjBHqFeJ3BjXmE/M2QA3LEoaiqJYRy+oyXaQPOM1LJhkjZa1U38R21B51ffQ4+3N5QslnePIXKhTzDviqv8+YsOtDwMBlWIVGg89fFE4ttzPvOxcnWC8cMFarY8mlfszmMQ89TnTw2/6LCz8b2h0dn9VXzdycF91+v7Zgje+rJz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:02:03.8408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f69230-44a2-4fc0-c7d2-08dee29b2d32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

Hello Namhyung,

On 14-07-2026 05:15, Namhyung Kim wrote:
> Hello,
> 
> This is a small series to fix memory leaks in the perf sched stats.
> I've tested the changes with the address sanitizer.
> 

Reviewed-and-tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

> v2 changes)
>   * remove invalid file closing  (Sashiko)
> 
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (3):
>    perf sched: Add missing perf_session__delete()
>    perf sched: Fix memory leaks in perf sched stats report
>    perf sched: Free subcommand string after perf sched stats
> 
>   tools/perf/builtin-sched.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
--
Thanks and Regards,
Swapnil
