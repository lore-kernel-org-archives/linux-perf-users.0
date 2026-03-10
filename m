Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2736E498;
	Tue, 10 Mar 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161179; cv=fail; b=JjwX3Glzfxwo8qt5e1YgAS/xTEZ+493UNJVopYjmUidYYTwgBIbdKGhVZ+i82pc02rdAvJzkYPfiYu+7pZjKfNOmaKw8Z86C9wUxJluRwS5ewfu+KzGyO34KSjVhALO14OT9ocgrMOyx6H3cpQSTBDZW4bH3lpZSHvgqjKW8xhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161179; c=relaxed/simple;
	bh=51Ox5YUnS6A3jIREqZqz9VT41vtfOI+kqzN4zdoCcJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HRgFv/OloVbFSvCOZ8MFQu9r0/eCLSESQ255BmFMJGBxHqiM0zG6eZHpDAPDxFjlW5/5zMs/eILBG4debOdFSPtRPT/hG53K2dCJ2oUBiRWJL8DFoLjA+n8S9RXKLEW9UWfiRB1tpmelQKKK1AJ2/Os0dDdpEhtIvXBweNBFNxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WjK+/ols; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WjK+/ols"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAwh7okporYdbDZvodFABZpn2AU496qTYrDvH8Lr6q8Q+c7V2muX072q3svlCJz7H+zZgyXv0/5OyMjUobs/AhfBFauOuUmE+ADgSV9hCUm9vR640zZMZCiSGJDLNthRRjWL1yak+UBfqAC2G18v9umHYiQSwebcR6BrCxVY+3Qf9Nv2EHMt74HcOuZa2pd6j3RsRGWubPKKTMzAZUuahPKJFh0YEecR5iRS6+6/rillMxJya4g7P0ezkKoyCmMo6O6P4fyEHHFMXwsMrlIvU1/6FBxHTtj/swi/seke4JrpIlb8rCqvVb0MB6XEDa8gSJrmo6XXTazAkIadnUVe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8Ww/EZJEa2Xbn9tFtaEJSHlZOb/yL+I33LQi+RibQg=;
 b=F6G/RvjwRLCrd9rdAq0Vm2rKD0OsSEgPVeFsaJ1VXhseOEiYA5wQrPzLYmhWpbA1L5XC0ephTlnu57ZyD+pprCXc3P69FAMrXhQIMGWM+IObBUu+gwlyYV4FnpPJbWkQJzAk6bTeRt65TSzzTHF9KouXEhNjlzIdKls/aiqtiPtsjoHr1VFdl3ZG014/MK1NaALmjl8S94ENLnu8yvYot35xhqcp1TLziRHVnw6V6JsyyaPtmc/PRbKp5nOtfODZKoR3+yq2QM/2IyR2rfrrYiMrrpsJ255bO20qJeHPCwQDbf1RLHtASg+O/eOVw0j2spIt+0cC1H1QrJtn67+Tbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8Ww/EZJEa2Xbn9tFtaEJSHlZOb/yL+I33LQi+RibQg=;
 b=WjK+/olsEQ9Dj6S6mPj2qxf5aed1oANG9gCIOfz9lh9bWfBe/IYzHhr7uM1YZdYT9CHlfdO+QM6DuQsQ0rDl0Ts3ZAYpREUI1rBKkYzUCfbIdMAtTEpc+dSfuenIQe/f363xFVhuK9JYEL05e51kuUG1zyuwpQGtqi0sUeD08YE=
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:46:14 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a5) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 16:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 16:46:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 11:46:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 11:46:09 -0500
Received: from [10.252.223.199] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 11:46:05 -0500
Message-ID: <9b49bfb2-8f0f-4831-943e-a82d10007680@amd.com>
Date: Tue, 10 Mar 2026 22:16:04 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] perf/amd/ibs: Avoid calling perf_allow_kernel()
 from the IBS NMI handler
To: Michael Petlan <mpetlan@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>, Sadasivan
 Shaiju <sadasivan.shaiju2@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com>
 <20260216042216.1440-5-ravi.bangoria@amd.com>
 <81204aa7-9d81-8d53-b82b-6c4ad8c89c2@redhat.com>
 <9145b8b7-fb83-49c4-aa17-acdba069359a@amd.com>
 <21f41878-254f-191e-eaa9-26a9faf68d45@redhat.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <21f41878-254f-191e-eaa9-26a9faf68d45@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbc5999-df0d-4336-2b6f-08de7ec488ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pWC3GnqpIv2xhqfJJS2TZR60yicRaOCqIH/edqovrH7MQ87bgv4tNZt6mF5giofAp/hsCNzRjNXU9VcQwviQkyFuwyQC/fvQNZHAsg6gNNNWL24PoCONk77PaDr92DuzZAaRcV9H/Wk4CE0cny0htstAya4ASdEMfK1bJv4kePbwBMWihKZ/w69g1jdAZDIFFJ0t8IyBV21zR4513/jzvzW+FWMuusRkIEi/DeXd/5jlCPsMj6Y/5QR6B7fwmhzUUWVcSOjL4YC4XkR0703ukkpcxM7OIiMHyfO3jzhJ2Kxc499tojdk22l9wbOeB7L8rbKGgIpah01ocUJTn3MORJFBYNBgvxJoDgreDpYOZcAsMOmjn/Zq0JJMc5rhZIuDh9jjVvJaY+OK1BktPvgE7fdQ8/eRPb8nUHP2/PGRMSb2gdc9xW7dlJQeFE6wpAOGm96IWW47bNiZC/V5dapCJY6aSp77D69haChLMtdh7nbFTNVKlYvzaDH0fXl5OkzeuKEejKLYMFxWeOuT6eUaRNSIaXRF1xNyRRLVuNsVxGIUqE91DNY8nNriLL2Zsi5+gnRzU9iGgslml5H4a4qFG68U0vIC/dpzMwcYMP0ARc9hnmrUCroc6QsVr6vfX5G0L1kHYlFUiCWwM3bWmJz/8wJlVsaSvhBxAXZ1JZ+ULdXMntHjzlcl36Y+14eWohqiP9AuWhx+BKc964EHtK1P8YAGGi0449XQhwQl/WuF24E3JYnoGpqTfydJzMLVneSoI/TEfLM/AKV4EQ6RLs+lnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IGDZqU49kvsk/xiGKouu9erS5rWIszYi/s2tBfNZVmwAEhWCTTMLEWMxSJzUpZ0QT4cCrfULWCkwbvtUnSal2lv9dhUGyqRsD6hjMMUFn/to1laaSn5/IbM9//YpLEmpDrVI0YvGUvdzGDjjwkpFOEqwY9RvaY08MN9jIo+QvtKCS2T+jDZBCbRUpGhjPrVuGQxkltAi5RbtFi9fDzxh+QYF0lairPQFOBvDj3Klu95XsMYN8bLFfttgaWbivpnnhjXmCSvEar330Pbpibwv4THVI8+MuT+Bmo6AWWlQ2IoI7Ne7ACn9UXzKgfwgMM6d5q9v2bZOnwadNvlucZYik298vbhV1DJPTv9YPXb6NGsok/VPRxSF8QKU77G1aBC+TtLTswnIblh+3k5SUE+iF6TdqrJPH8W8pV8TmSSOr9/M1cNMxCzoTuE9ytNmM0vV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:46:10.3982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbc5999-df0d-4336-2b6f-08de7ec488ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515

Hi Michael,

>>> By evaluating the privileges at the event-init moment and using cached
>>> value later, couldn't it lead to the cached value being obsolete at
>>> some point? E.g. a setuid program later dropping the privileges but
>>> still being able to read physical addresses?
>>
>> Yes, but wouldn't the same concern apply to all other call sites of
>> perf_allow_kernel() ?
> 
> Well, I don't say this case is worse than the others, just raising a
> more generic question whether this design is fairly acceptable or would
> deserve e.g. privilege adjusting at the time when they are dropped or
> something... Nothing more, just a note... :)

I understand. However, performing the privilege check at the beginning
and then continuing to allow accessing the privileged resource even
after privileges have been dropped is a common design pattern, isn't it?
For example, I assume something like this is allowed:

  fd = open("/root/only/file");
  setresuid(); /* drop the privilege */
  read(fd);

Thanks,
Ravi
