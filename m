Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D338D69D;
	Mon, 23 Mar 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262413; cv=fail; b=PW/J53DPK/nkjVNvEJx0evMCY+OcyqgZdGEEGRLSwt0EVKzEgUiaMgmVgHhcehhSZttCyh1RmBaCcCCVtWtq5R8eWEc61EqFB3pG53Jj+j4DXJ1yqIqCMN4Z4o/y30daJEObDJoY4v/Q0JMBnZWyhBl+4Uonw9A5p/7KeBvogq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262413; c=relaxed/simple;
	bh=c0S5UXX5pg+LzNF2WGABlCdd3wNXko7Gyf72V86CA2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xkc0MNiV418zvvIUUr6khKFhPxoBkBOaHrGzVAypdISLOF+9x34F6t3HUykU9QUHIAlagHx5imyCj4X6PtDad305CjDuL0+bAmTVjXmkYomv41W/b3KsLko9X5hzBs4cQQzOYAf5Vv/a+2cx9ySdKvBrDBXN9UJLGht+PV/ptGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nwQ5lx9T; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nwQ5lx9T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udChEK8MV9wP7+uZ2QkxqjjZRnD/4Dqml1MWP/tJCEIP5GJtwbij+De1t+MhuE80OWqaNIi3GCNYoUYGIgpKky/WSquLrMWNDYBT7zMHQUTX46KsZjAShP6PEEbpO/JyfGhCaM8GLUJ9XJ+aYQP9ZeeSlYY0BywuVtMDls9QjbKZmgKTTWRxDZm8Vekr4a0q1Wcu1Cn9dr2urRnIAWs/Bjy659FUjtiVG1cWotGK6pRdpR5FZj7Kc2MkAYc8oGgHUrZTKHRitpI8TxHBF9alHOExfLksXhJLHdZbssPUd4TJdlMR2HSP9sv5sV1VctnRyhII4nMDblR70hhdrvsrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqm8CkMjrtrTufn56fna5CK9LI5PvDn2Ks65NpsL0NI=;
 b=OVEHbG+bpp7Kzl8FR26pt6V8Um15pf659rG5oayGTaMNiQpfXg10R49l7cDuQ7LOwmwDmV2l1JZeuDUJ54uuPy9bwhmceiBarYIOEVZ47xQV66Otk3lc/8IDumxFgmU1gkKLB7vMHFUjN903vb0rJ2YGWWaEfSIKc5HvE8aiJgL2pInqikp9gnxaQTWXKvgGjv/DxheyutPcrTJPw6bBY0XVSCH6n2jomGh21KfgpD3dFoc7WRQAAn1NRAcIqpQKWz5WBw0HbE7stAqyJW4ZloYC2/XfCa5s9WEPhBP+JpQMvQj2g9MLD/XpbeMiUdIQvFUA8zq9Q+keN406/CDFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqm8CkMjrtrTufn56fna5CK9LI5PvDn2Ks65NpsL0NI=;
 b=nwQ5lx9Tx8aRsRebY5omGGRArNj7nGusx1ECkLj70JcgahDV58t+2VcvufyWoQRBr8OnkMKyGDYAjbRrYgef+9Ta+0gKTT86WVJ6HrN4sPj/5pOmRWq4yw3Kmy7xBIS+M7MeNTvVvzczV2Pj7aCxd0ciI/fzsK7bCGhvQK9iy5E=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 10:40:07 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::3f) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 10:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 10:40:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 05:40:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 05:40:03 -0500
Received: from [10.143.205.249] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 05:40:00 -0500
Message-ID: <b555b000-35bd-49ba-88e6-a77a112a2b68@amd.com>
Date: Mon, 23 Mar 2026 16:09:59 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Adrian
 Hunter" <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260321061448.810525-1-irogers@google.com>
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <20260321061448.810525-1-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 119fe827-ec1a-4451-186d-08de88c88ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	XQWjol+iMFaG8P+3h/+dtQqLq0NSDunRhNeon2m6PxbaOJSpuYzDNwzmjIKAbfGSIArSBvMexcj6WWP494ub7EYKiZv5hOjPe9J/gf/23wxVAghcphOahhP95i4Sm5eh6ImvOJ7IVcnnXFy/vv/+pdYfae9ADIAxX9q5sHVGX4jpCLcVJ/Ix0j8mCQB9h9OGXQW5S9jTougjiyxhTCiIEyzIj4dk5Ve+nSH0sWQ8yd25M3E69k/8trNArIBf2Cye8Nfmun/1qmW1UC77JIOuJhiheQvcVl69lYEHnSi7xaW004NompoWwWzX8Y5A+3pIYPhXuStPIMlAOEUZXU+UacBuZ2+3iYgmPdiOVHpi6laLMtA12j4ijpiz3tnB/mIGSAkJ8Qx2amdxXpYFrlRrLewBxMdRkJ2vkBNzwAi7bL1rCXS9oOip4aus59rHPXV9Rsxt5xlA6iFK6dSkOzNCB0vXsNa/FhO5pt2cxJL7IaRx84EiwSEfKSdwDb4+Pr4pRWXpTLIcCgt7Gu+rd3x9GdFDWXBeWCtEtqCoZlluGfkJyC5ZMJAI9VXCRd00XHeRFEm6Saq4jISpP5gNSpFxQyhbv2E1oEEek3SxeUBRIVwqMJE/8/+UxAdkkwEzRL8LFHhwhbwElPX7nDHG79bfAN51we+dfbV9ZO+LkeiJ+LFoWW0f588S+ZM4FFMkKsa3SE3ey7svKTOkb9HRdLIGovrra8mCDihLHgjZ0HWW+1LXdY2tIKoR/kkJjk8CVPdRLaXmY2y/xJV8JdL0cYzrePmRKuwBVEvOEyN7xk/OBb3YEe14hRTysNlZridHL9tW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iEMynuM2Wzk+ViSYAhD25JFzQAR9qj2P74Xue68eg5LwPajH+VBTvDhyB36Vap8XhB9aTIerZA2mQMbynx4PbCula7xHVuEK+JwD/iB17/NVHyrpz+fcIxZqAr4aeCRStVlJueMSOPQzCmodi6yU5G9DpSKs149EpnL8NMOmUFHYj/75Ca/EOtvPMtQwoaBRpmf1eApZx4i3W9XW0x8b0d9i3EgodyFLHV0JKGUVsHZ8Ghx2xAsetNa6iZnyN28BEuQZmKUOkjGeDZuM1OlglgLfAbd01kT4zM/nnLFavN0ha0ZPV5sUWVShBjfSQ7F+ogTCM/S4+0gDq7zgm3Q1GeOCPxqk9Le4c29ZKBwNRjta8kqNkW17+1qS7wL6k9+Nd4W9qOfFzZ1EedcJ4jMitmZr6Cyh9COuCdZb8d7xfXr1W2UZ1rNi9HjZH3ipwEou
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:40:07.1287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119fe827-ec1a-4451-186d-08de88c88ce9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494

Hi Ian,

On 21-03-2026 11:44, Ian Rogers wrote:
> Doing a `perf sched record` then `perf sched stats report` crashes as
> the tp_handler isn't set. Add extra checks that tp_handler is set
> before accessing through it.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/builtin-sched.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index d083e2bb7703..196f263ff667 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1525,7 +1525,7 @@ static int process_sched_wakeup_event(const struct perf_tool *tool,
>   {
>   	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>   
> -	if (sched->tp_handler->wakeup_event)
> +	if (sched->tp_handler && sched->tp_handler->wakeup_event)
>   		return sched->tp_handler->wakeup_event(sched, evsel, sample, machine);
>   
>   	return 0;
> @@ -1809,7 +1809,7 @@ static int process_sched_switch_event(const struct perf_tool *tool,
>   			sched->nr_context_switch_bugs++;
>   	}
>   
> -	if (sched->tp_handler->switch_event)
> +	if (sched->tp_handler && sched->tp_handler->switch_event)
>   		err = sched->tp_handler->switch_event(sched, evsel, sample, machine);
>   
>   	sched->curr_pid[this_cpu] = next_pid;
> @@ -1823,7 +1823,7 @@ static int process_sched_runtime_event(const struct perf_tool *tool,
>   {
>   	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>   
> -	if (sched->tp_handler->runtime_event)
> +	if (sched->tp_handler && sched->tp_handler->runtime_event)
>   		return sched->tp_handler->runtime_event(sched, evsel, sample, machine);
>   
>   	return 0;
> @@ -1840,7 +1840,7 @@ static int perf_sched__process_fork_event(const struct perf_tool *tool,
>   	perf_event__process_fork(tool, event, sample, machine);
>   
>   	/* and then run additional processing needed for this command */
> -	if (sched->tp_handler->fork_event)
> +	if (sched->tp_handler && sched->tp_handler->fork_event)
>   		return sched->tp_handler->fork_event(sched, event, machine);
>   
>   	return 0;
> @@ -1853,7 +1853,7 @@ static int process_sched_migrate_task_event(const struct perf_tool *tool,
>   {
>   	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>   
> -	if (sched->tp_handler->migrate_task_event)
> +	if (sched->tp_handler && sched->tp_handler->migrate_task_event)
>   		return sched->tp_handler->migrate_task_event(sched, evsel, sample, machine);
>   
>   	return 0;

Tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

--
Thanks and Regards,
Swapnil
