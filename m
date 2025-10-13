Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012055.outbound.protection.outlook.com [40.93.195.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF12FB0A3;
	Mon, 13 Oct 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345583; cv=fail; b=PFmDIepmnaRQS3Yc2tZZaAhq0SVu2Q12knhoPxXE+2ZtbzG0igtBv9Z/JY3SqfIKLCQcHdG4H54+t6lTPKN9oFyXQyZ6UHcKSjU69HwYn1g8h7PXrHcsuBNvL+wpbpKGOQu+s6oQ6xUAI/OC1bXZ7UDRmweW5cObUDPvzGD3C2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345583; c=relaxed/simple;
	bh=jjrZpYtsKwZuT5qkZVNAy9PYzfk+WOZzEVclQlR2VLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q3GOzka+fhp12v5QB1Ks+9A8/wN/gw/Lo8ieGiGAwgEJjQaxRCmlBTCItQa2Uvmf8WwquVO/n8/AOOCuuB36+0peTwpXBZvNgSIdlgZPtfdg+uWVM2ofzMCR6LMT30WmDcoUk4xA4J1nVcaTGgvgWrmiDXw2+izaYDXxFoh63rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dRAQgOcr; arc=fail smtp.client-ip=40.93.195.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dRAQgOcr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZASE6BipV4KfthZdoxNkcpQBOZyBwa/e7YOnAS/gOIH7YGsN9+JJRMEPdnh9xS1QEBZs+Z31yQvgphS73bZwAbLQWf0B003BP/onKvbCvVfF45gAspIf3y1DYQjlX4iuZaVtM3i99v6XDDQOp2RR4d+uI12dhYiujgIrRHV4zGTdn6Ue9ATQtdxVhe8tOqMu5UlHwpv7WT5PYMV14A9voWLORkV0F1tNedCP72xqoZH1gxsCCg0nm32Uf3BJ0uLEp5ViNjO6b5lNjwgqmlEemWcXxZBXQCRS5Of2NNRrjVjYu3BAn8I1TcaxWy5ErDH1vlThZZ7Ar+HUutSf8Y8DSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gNLomOSIwN/J/juCwD88BUWLWmnVBrLxtK9m9v56j4=;
 b=PoPbz/nvCcyphgKL2Pz4YpIcnUBDyvOjrXDAhSqMPbBf5n/qwbZd7irnr7og/tWqecHOFS2srZJs58IGZSWYIBLLs4qjUoJ3goorm/pl3OBBXLL+DIjrvxDfRLGtXMuNCnW4bef1qd6A8WG6o1qo9DuD4ssKMx0loGXw0uhPHGHsK976FrGxuTw/sU94QZ12IzpMrEgf5+rBO6v9vnJMywhzDe8PKywbEltI7GYu1lehe3tvY9b8Lfk8c3WLVB0uobHU2Jm6mrVbk128LYAF5pI+HJJZs68C/DfO0DxA1IyLIiS8ChDlKcN9SHsC/Es5njG9wO+HZSTBSVpvGcoiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gNLomOSIwN/J/juCwD88BUWLWmnVBrLxtK9m9v56j4=;
 b=dRAQgOcrtkWt9kD9KixzM5dAo9sWSm1OkRJUWAe80LlU2wi+Fr4w6WJvIMxQVut6oTWkE7jZMIPTMjSDhxuG76ZFPoL23jeKXUeY5ScRSK1sdQEY964NSvBELcEByXL/L7AqeUBwiyXI1QGytH40MbZ4J11eIB4H7lFmQl0WJN4=
Received: from SA9PR03CA0014.namprd03.prod.outlook.com (2603:10b6:806:20::19)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 08:52:57 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::6b) by SA9PR03CA0014.outlook.office365.com
 (2603:10b6:806:20::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 08:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 08:52:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 13 Oct
 2025 01:52:57 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Oct
 2025 03:52:56 -0500
Received: from [10.252.82.201] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Oct 2025 01:52:46 -0700
Message-ID: <660c8ba1-635b-4acc-8824-d195f1b133a0@amd.com>
Date: Mon, 13 Oct 2025 14:22:45 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] perf tools c2c: Add annotation support to perf c2c
 report
To: Tianyou Li <tianyou.li@intel.com>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, <wangyang.guo@intel.com>,
	<pan.deng@intel.com>, <zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>,
	<thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Ravi
 Bangoria" <ravi.bangoria@amd.com>
References: <aOkFWaFD42Jy7V0f@google.com>
 <20251011081625.1953652-1-tianyou.li@intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20251011081625.1953652-1-tianyou.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad703e8-693d-4feb-4c86-08de0a35e828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlJMYmdIRGU1NXRJdHlqSkRwWUIxQ3F1T3UxWVFoTHBRV2R0bThPelJaOEJa?=
 =?utf-8?B?U29lQzJkTjY1bHdZQmxSaUd6eHIvdEkreGttaDNNSFpSNzFjZmE0MTZPRmdO?=
 =?utf-8?B?a3Q3T0MyTExrbXlseERsZm52UXdTZVBoV0xNb1dUYlVHZWFrSnVRRlNaVXlz?=
 =?utf-8?B?dXNJQ0l1R2NrTWM1SmZJSVE2QVJpbWV3eU5lV2Y3TDlnU1lpZ2tNRG01TWEr?=
 =?utf-8?B?eHVQNkJENW9oTmphRHZYcWl0RW5FWnp2SGUzc09FZFdDLzlWTUpTankwZkFm?=
 =?utf-8?B?dys3TkpJa0JTckJtd0llTzhlUTcxTGw2bGQ4RjdZRUZaNlp4aCtHZms0cFNX?=
 =?utf-8?B?L2N0R210WVVjRzhKQTZUUFRQUUNEMDhHNFcwOUtwY3VEbTNTYW41R0FkdDJ5?=
 =?utf-8?B?dmIxM1BLSGhHMk9aTjBBUnl2VzVDSXdSeWNKbzRPdWRGaGpMaHFsYXhLZjFR?=
 =?utf-8?B?VEZLTzVmLzBzTWxYU0JUMVAwMTBIdy8rcHRIcTZYalA1alovSTdVZlFRRmFa?=
 =?utf-8?B?NmhITHdkRGdPdWJnbklHMGx2U1FNaEZ1UTRDY1ZzcE9aWjBtL1FBYTZub3JY?=
 =?utf-8?B?RFE4Rzk1TjJvR0Y5ME9MOUFTallxQzZDQlhnamh5ZnZjMk5PNHVVVGhxOXIv?=
 =?utf-8?B?MXhnUndwWm55anVKM3NTN2U0WUEzWWhjUFU0VTNyUEdRTjlKdmhsa3dkSjg4?=
 =?utf-8?B?NGRvdUhnZVdsaGU0dFQxYUYzTzVLZmxmcnBQZmZjUnRpbkZOdGY0dkhpcjgz?=
 =?utf-8?B?YldVMlh2c25UR0xNdXN0cmh5U2d2UjRSbkFmcEVVMFZXY3V2b1BBeVZiRERq?=
 =?utf-8?B?Wko0UnpDRmMya0hiNitiYkREMjczS2dqVWdWZU00WG83OUhEd0o5bVpDVC9h?=
 =?utf-8?B?c3JyZitCYTExTm9TQk0yVHFnWlZzM3BXYnN2YVkrSEt2NVhyVVpjdVNFTjFB?=
 =?utf-8?B?aDBSRWl5YzYyaitEZm03ekhVclR5K2lTTW13ODhkYm9LS0Q1MkVwdVBCQzBw?=
 =?utf-8?B?bFU0TDd4d09YdzAxTk14ZWNHenoranNCSU9nUzZTQlNLOHdsQ2xidWNDODNs?=
 =?utf-8?B?SmpXdDdxRERqMXltVkFrREdhWVJLRmE5b01KM2RFTGFwblVGN1JncFFWREZN?=
 =?utf-8?B?MG4vRXZUYlQ2VnZLcUFrNTBZbTJ2VVltdThmc3BpclNXb0tyanI4VWJIbFJm?=
 =?utf-8?B?MkQ2aWJKZ0hxVnBGQ2dRdzAvZW9FRXdabkN5enlwVFRMVUxMZjg1L2JYRHIr?=
 =?utf-8?B?cU4zUkVmK0g5ZlVoME1POU8yRnpCUDludWlJOWI5czNURUUwYWtoK05vb0Jv?=
 =?utf-8?B?MWVra1orVFBTU21NcnpySnR5WXZGS1N3QXBBTzl5VzdMNmVzZFNSRmdNTXlM?=
 =?utf-8?B?U0s4WW5ETklhaWZpYkpZaEV5Z2NoRzJjVHpKRmg4TCt2YXhVeVVyUWtLd0F4?=
 =?utf-8?B?NXNSTjFUNzdBVTNaWDZKelVQYU80TXFhdzl4QnF5Zk1tVDF0MlpaYnFiUnpJ?=
 =?utf-8?B?TDhLUXhjQS8vcWxnWGJiUVhqWjVqdlJDT0RDRGJ6ajZkU1ozdk5iLzBNR2d4?=
 =?utf-8?B?ZGJhZklyaW9PRHdWZzBwbjNYbkFwMVZUbE5FZkJCcHVQTEUxemo2cWhhVy9x?=
 =?utf-8?B?OWJZUFhXQTRmMGw0UHppYlNpZlJrS0lTeWduaHVJT2VDTFFWdEtZLytDNFVE?=
 =?utf-8?B?cTZwaWQ0bWMrQTREcmRYaDJLUUlqSTZ4VjhzWHFVdy90bWRFR0F1ZzdUcVNi?=
 =?utf-8?B?REVkc0RNQUhtNE5IY1U4djVBbm5aZEpFa3JDaWVoK2JJWlJuajV0SWtMWkV1?=
 =?utf-8?B?ZHhSSlJpMmN1YWIyRjRKQnVOWEtEdnVNVytPZE5LTVF2SitaWFJnVS8xcmI5?=
 =?utf-8?B?UFo5WWc2R0xoeEo1bHlZdUJvZXNxM3VmMHd4dHpPMEhZSC9zbTVTNTJPUGE1?=
 =?utf-8?B?Q2lqak5uLzgzalZCY1RQQ25jYkNoUXRHUjQwdXBKOFJYYi9BSThLU0MxUTVR?=
 =?utf-8?B?U3N5a3B6aGUrNnhydVJ1Z3JpV1p1SWRCOEIrV3Y3Z3JFV0NISXpJL2s4OWQv?=
 =?utf-8?B?aHRBUGxpdUNWM2xDcEdaSEFDT1BlTjMzQ0NiZWwzaUtPbk93eXNYQzg0YUZJ?=
 =?utf-8?Q?+PLw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 08:52:57.7041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad703e8-693d-4feb-4c86-08de0a35e828
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902

On 11-Oct-25 1:46 PM, Tianyou Li wrote:
> Perf c2c report currently specified the code address and source:line
> information in the cacheline browser, while it is lack of annotation
> support like perf report to directly show the disassembly code for
> the particular symbol shared that same cacheline. This patches add
> a key 'a' binding to the cacheline browser which reuse the annotation
> browser to show the disassembly view for easier analysis of cacheline
> contentions.

I still see annotate browser title with samples/event count as 0.
Something like below (lightly tested) should fix it. Can you please
check?


--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -299,6 +299,18 @@ static bool perf_c2c__has_annotation(struct perf_hpp_list *list)
 	return !list || list->sym;
 }
 
+static void perf_c2c__evsel_hists_inc_stats(struct evsel *evsel,
+					    struct hist_entry *he,
+					    struct perf_sample *sample)
+{
+	struct hists *evsel_hists = evsel__hists(evsel);
+
+	hists__inc_nr_samples(evsel_hists, he->filtered);
+	evsel_hists->stats.total_period += sample->period;
+	if (!he->filtered)
+		evsel_hists->stats.total_non_filtered_period += sample->period;
+}
+
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -363,6 +375,9 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 	if (perf_c2c__has_annotation(NULL))
 		addr_map_symbol__inc_samples(mem_info__iaddr(mi), sample, evsel);
+
+	perf_c2c__evsel_hists_inc_stats(evsel, he, sample);
+
 	ret = hist_entry__append_callchain(he, sample);
 
 	if (!ret) {

Thanks,
Ravi
