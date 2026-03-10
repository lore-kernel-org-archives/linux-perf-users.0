Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05F42B750;
	Tue, 10 Mar 2026 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137302; cv=fail; b=JHyapwGOLufxBcTnQC5l3Xq7M4cNwYyJI7M7+/qoIUPgdBiqIaPc9Q4TlfKpfLlhO6FWZmnddwxvANeLs8wJy0VjbVGGjVf/7G+ezmzLXJXQbjnAcWvlcuJZwP8kTGjXb1CX911WleDn9e5uRBoKoPaPjE+ux1gxgPFc9qfkjsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137302; c=relaxed/simple;
	bh=UmwYAzyiB0RQ1Eq7FLxiWY5g9oy/a3ydU6bMcV6Ru+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pr3nCxrMgXTu+ZEhwFOVGVTEBt2pn7TJ64mksUqhE98XKtuRQNQ/FTRF6T/8dR7907xPy7w10INeyNBZbpaPlEvk+kChN8p4lF/+OKd7O/YEGurAxl41Yf0XZ2//9OwBYzAMhnTY2F0z/ZVTXM6TpRRue9DTVhNNLtBYMA2KTao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oxcykaGn; arc=fail smtp.client-ip=52.101.53.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oxcykaGn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mifYNh3e3KJPIr7d/OeGEU1YmX9NUwvFNXHJyjdFaxvP2j7hgSZWbhiyYqSp4PIN/8bB8BQgMFw1F/+s/i9dY//fhxo/zT16Jok0fDBfmZhry2X8CE3gqWipR0SAz9vhXeIUa7H5LImdec35TB7DCRG3Cf78gR4hYwIqqfL/QjvTwCkO8Z45j87DI8jLYRqmBFkSGOXTUc+F5GSzVaaK3lHidWKkwmB46w1XMh8hEvLokvhmEe0FKVzq669iiK8qvcoUSjAg9z+QOR9aygGuh716IzkNb7cyNvZpso03HyphkVIhdkVHqVKjT+gBSIduSs+7ybkMniaAjN8v+mhElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh48anBO1ploRY5gEhfKAjxGWxbiTY4oirL5owCkuTw=;
 b=oBK1vmvEQiKsjr78tfhUY2ZyKiJDcqXnYmUUstOtMLfvtE0JPFOPF8h4wzK5G+vQE6X8LxEaqMTkD4nzirsyEZPF2OV4WnM2hfY/21MEPt8dBbgH1rAmQBKzLG/ZshQACgOoDLlknlkwa54LWYj1QQ3VG/RCUX+JVjqnt4jrLEY0iJ9lT1oG79LxdV2IqcxrkpN2QO5r6fLAsH/yXBqTLA5lUMu3VxNoNDb6N0Cd1NEPqtthAqfJPillEEZdxuE9N4sBlmHtzn/mFe9FZnOlwyN+7SXcIykHRsqWlpn+OQhx0D3pUK3pjF5SUG3Y9wk+qi68EFO5vSYmDIImTjTfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh48anBO1ploRY5gEhfKAjxGWxbiTY4oirL5owCkuTw=;
 b=oxcykaGnRFxucja5RjssYHiFCY0eW5bTFoFXm/OGkNi1eHsyfNJDqeqP2STbsgS6XvA2twQ/UB4WB0P/XXaV87ZQ0cP+GivC+rAg3J44ICyKjnBRjotd7AVYzPpAmJs2FKpMDaWwVtz4JrYEq/DGuJ9bnQwtIsp7rU7On5rJi9g=
Received: from BL1PR13CA0365.namprd13.prod.outlook.com (2603:10b6:208:2c0::10)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 10:08:15 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::94) by BL1PR13CA0365.outlook.office365.com
 (2603:10b6:208:2c0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Tue,
 10 Mar 2026 10:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 10:08:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 05:08:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 05:08:13 -0500
Received: from [10.136.32.224] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 05:08:04 -0500
Message-ID: <bda6c5d3-94cc-4f34-a3b6-b9a50c6b28e8@amd.com>
Date: Tue, 10 Mar 2026 15:38:03 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] perf sched stats: Add support for live mode
Content-Language: en-GB
To: Ian Rogers <irogers@google.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <james.clark@arm.com>, <ravi.bangoria@amd.com>,
	<yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "James
 Clark" <james.clark@linaro.org>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <20260119175833.340369-8-swapnil.sapkal@amd.com>
 <CAP-5=fXNtVXEjDD-euueztjO7vj+6LQ2CHgHfxVoHuRF2Nb0Xw@mail.gmail.com>
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <CAP-5=fXNtVXEjDD-euueztjO7vj+6LQ2CHgHfxVoHuRF2Nb0Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: swapnil.sapkal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: c2508272-c6ec-47d5-cc01-08de7e8cf1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	8dDSjvBg3yiaogi+w3tBDKJO3Srx5eywmH+5f6Mowoq9z3io3p4sc5KuiqJRs6k3E0rHsd6bA+VFcSzAUB5BWdBwNsjCKxI/S2kvW6HgpAaPfcGr6CgFK0nwrG0P2/iyDkVSNvUHyqjbNiQ355c6Ev0ZPlLfwjgXXFfN59nf4NaRmSRP9/lrHh4TTlmAj0jqd36VSx7lfx/eHFLkrGoYtdt5V8gN57aOqHeNEe04Jx0CTOFOtlTjXTTIWg11DTx+5EFRAR1vnVBEpZ/BhUhigqBtRwNN1xRP3y5dzHSnj9wnYhg4XvwrcNN9FzbPCh20R/U/i5JEZ2/vSVqfw41ZQJWBQU86/FyyWAp+nEHMnScu2isVdNZfGZKoNCeeMxJF5yVLI3chOaNHqEadwJiGkSd/I3IJU1PPcL2K5t+AZxIw+I5hE+JkZhf2bWpCnCFpy1kDZC2afBGB3pVQgNFNMYh/HmMe7j0sqD9uDGb9A5vz/Lv8ZSYW3cJIeXizcOVHTkcCMi7kcXIE3bIs1jHwMlWXmkkCQUj1hn130GiyLRGPa5iteJNmgTrf6eZRM23PBQWsrgHoB6/KU4RFAILt0M41yVo7vOn8zu+SozWM61+pLgCT5NvfrKVPysu9SLOh4MYLLkyKn3WkW26xZBLkJe4WmrJvBFC4xT/yYlCyQ4RrEBYLElwlU6NJ+pYvcThsTMNBBRLdNOqRIu+hiCLuGRQiDGuOW5yyd7TKuNRywIq81E3XMhhhW7JZFFsfH1it7G0s8rvtQCX7NQ3OsAUx8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6937pf8ipW074M47e90KWaNQBu3II8xW0MqLm6mmBdBkQVRGgRSmK/8B0W0vUYV8SvW7uxYfpvYUt0uMOwt9Kn+L47LT2rz5Mqq1pxfhWH0rRMflTMfh6AUnG2vQhXcW8VfJyZWx5jo62vXLf6A+waZzZK/H32wk7eCEZN3xLu5w6xjnGLKawUARHOpIamgrYeH1MN9amSisl0DBbZ9470sG7AYTfBAhfLyiDS7VNiDSAJ+fSIcX8ZgXxogzN6vRDpS/fuTK7TMm6TAMigkVy1JD+UfwegfTKTRHJS6ge7+uyY3w+8khEpGeKMbZ5gsiCER+OpMXou3cBPFRFnPJe2jKJY4i70Opq4eXH07eBnGSCT++oNKV53hUK7y12NA3QAwYv8AXgOYXn/dQeEQnbK/g+qyHfmJHOKkuhhPjqLD+H+rYTr5DccN4cXXy2yqK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:08:15.0704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2508272-c6ec-47d5-cc01-08de7e8cf1d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823

Hi Ian,

Sorry for the delay.

On 04-03-2026 00:17, Ian Rogers wrote:
> On Mon, Jan 19, 2026 at 10:02 AM Swapnil Sapkal <swapnil.sapkal@amd.com> wrote:
> [ snip ]
>> +       /* wait for signal */
>> +       pause();
> 
> I'm seeing the perf sched stats test hang here, requiring me to kill
> the perf process started by the test. It is unclear what signal is
> being waited upon, but is there a race condition where the signal
> could have occurred before the pause? Should the pause at least be
> conditional on that happening? Given that a race condition would exist
> even with a test, would it be better to use a condition variable?
> 

I am able to reproduce the issue. There are other places also where the 
same issue can be reproduced. (e.g. with `perf lock contention -b`)

I will propose a fix.

> Thanks,
> Ian
--
Thanks and Regards,
Swapnil
