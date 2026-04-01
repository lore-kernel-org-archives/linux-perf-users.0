Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693B133F383;
	Wed,  1 Apr 2026 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027091; cv=fail; b=A27XMEcjG17WVASGOeYxDRJNJIZQLDFrOMQ/96ke5vzPKOzz9uU+u1Nx57eggACX/+tokDGFusF40sNB5OiHGcQOuNXPlZwF6P4hvA6x8TPH+4E+6PGc4e8JO1fMdU97RbPpWdFn8Mq24znJdNKG/3FutlpFKGRUxkVbR+bhpwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027091; c=relaxed/simple;
	bh=7HP5ZRxu4lsUaWzy7GRnOIzFjrQyrkiFCJ6aI58yQxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HGIbUpAbFe3BRRXHsokLkNAy8ozITyMwZ3TNF4WT6g0siSP0zLQZMThpYBpdcjmkyJ5V4srE37r67OlExFFSKoiGrj+oQjgGhi1Kjd81+YttxLXgzKA5vZb/UYaNZGzSoP0Rzg+daRw+xyLepGjAjHB+qC40yl4jjHHqGYmGU9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5mX0tKKn; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5mX0tKKn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XH4V7nTck+epn/CnOSgQZ+L/KLxEuWIn3tNg1TfBC+JX3xh66bc0wE7nO1kL8Yl6we8hN8T0SuwQYeBLHnTycS7LvxqE4QtLdbpZVf9mh/spQ59uXcZ2nVXU0KZzDblPflIil1y2K9z9orzEYu+JM4I1EyocEytfBG1l1szIiEYVwy473Frvfh7kjw2PeiIr/JqnQh5E7HC3RAlkhtkFHBB0evQtQSEKZGzqhk3cuqZ2eJ7kb39Rbm+JGyVOo08oy/489SCxogKslWo6uodjkDECYSYzme/9FlfKeWV96WZ7TvauqHUUWKMp+qG9azBAVWROCJHJ2ZgPzCw506fvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD8R/1I5Oy6JNvkSu92/ILbQokaQcCUsY64OqwRGiFU=;
 b=U1h7MAZI/ACMMSuYu2FgzUg2TwEVgxhPWyDbkBA8VgVFZ7rjI3RESHdiJEkY1gplHuGrTvIVkWcW4fSi/3n33jjmY3KR/WdC7PoeLt1oGgRXC/qZtVjj9QkLP2K2xqWdOqmn1hOa2WN9izJqMON2UEztIj2CYh8IgfNUApWFeP1rHUIc4CXi6n3Xou1mDmoQXgc6bVbxMSTmc7UKga37g8Nc0+ZKBxnYw/KzLbTxhMVgG7FnTzOazh374xbjrVhivoj+Z20Bx4swGBNVvgvDQ0JPiFx7UphK5s4M9V4U0TnUU3LD3E5fV57WjOIXut0nsUN2rdyP0kGzpwDgShoNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD8R/1I5Oy6JNvkSu92/ILbQokaQcCUsY64OqwRGiFU=;
 b=5mX0tKKnFUCT8yltHeEAG/qon09IbwdoRfbULgzZS4HgHPchRp3h/e2KgacQCt4ZlWW5TN9u9CD/1v5aDIT/CsMc6nNJOOfxKpcKv/yRiSdkaaZFVwtxoXmIQieDD6O9oiGWJWZUobxGi/KdpsUfkszizj+e/wYJruWHqFfQb0k=
Received: from BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:04:42 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::61) by BYAPR06CA0072.outlook.office365.com
 (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 07:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 07:04:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 02:04:37 -0500
Received: from [10.85.33.6] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 02:04:28 -0500
Message-ID: <444a3e60-152f-4b5e-969f-0f8f70298497@amd.com>
Date: Wed, 1 Apr 2026 12:34:22 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] perf sched stats: Add support for live mode
To: James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>
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
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <20260119175833.340369-8-swapnil.sapkal@amd.com>
 <CAP-5=fXNtVXEjDD-euueztjO7vj+6LQ2CHgHfxVoHuRF2Nb0Xw@mail.gmail.com>
 <bda6c5d3-94cc-4f34-a3b6-b9a50c6b28e8@amd.com>
 <3e218109-261d-4046-8cac-86aa1362ddda@linaro.org>
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <3e218109-261d-4046-8cac-86aa1362ddda@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 211f65c6-8460-4adf-cc8d-08de8fbcf27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ou5bmTwdPrJbwkdQk3eoUiFR/5HEa7jJNqAv6iKdBEUv4jYERAglOjfUAX1084ON2VSmnUf9xVp8Yr+L14tGBZCIwE4NWblRrXikYR3T1Pbb4AwxPpmh615kmTija5PQa4HtJbpo+ZcRwRi1fKCsy+SbZvy9SRgNIc0+G9UD+HOXrfL/JF37gicUbHXq38RRIH9asJlKm7dHXF+b0xzzyEgvJjRUXDeS1JSLymm9r2jc62iYTsq8bjaEfclr2b9brT0/XJJ4Ve1Pu5H4amaqCkB5U1dHJZvWZx7wcpTV14He62VbUxH9lkfogVpOOktybdNlMiuLy/OiKNqbpwCMGFkbdnndYoySJbFDXbTHBfvnv85R16052yj8vgCm5XvzHAXEUzYO8Pe1zPwTreKleAYfqL+zFEnWFupE1Sezo8hlIPAX1MFk9DTv3Ez1Hjqp+nxSlPjSZAbDi0fQHLwR4RkHwR7NAyPVHotQPpkr8RhFgSy7SnapMXx8aoYpVBOgGwtVWKV871cwN5d/XCr80l94YLEC/TUwuc2vCnT3+5+Ihp9hU5V5yj7wIfqscoi/jy/tWMi17sTJBeB5C+dRfnH0VacMGLqgHp1YRagNaQy1yNF3E5S+bXTnnvvJ4TqR24FohyANJPSpnbkr/eDgT7ENkESb3pF2AWChOxsn7obaW/qyqBQVzcvqfwN3kOL/J1NzyVnEOOTiZhED2wrxkQsf1uZv7GYZWKi64l5cSmOG6MnWTi7FSoh58s2O7a2DgSbxFug0u02rZUijo8bstg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Crc00g63ZGS8dhVlVi3jceZ6vxTyK3A92hE7q5d9uXFtBfXrBaVAJVT0hzATMZf8I2/248aI3Cv5dBIhh0br41lJrmom0oqXVZ/rrhEAnfD2PDdFA+TNSEpLmgw+/tuufl3KL2cgAL2pGtuvMg0Mbk+06TvcBZYmZY8rOtXUY5HQC6vy6kFAeuNLzt2cjFPWjdAfysKzyEsP0ygkeb96N/3sfodbT3xBR7ne1HvmQLRmcPfw09U86nFvZNRTnSZdqh0j6dOMaLAd7EATJIwXJ7pRTxlz+1h4RYqql1Lnag1Sp2DNJtbCzLrUZqVURjP9Bnbcv4sE5h1X89MkjI5VjMVeUSORMr178OQBMx38/ahk1QV8Grq7JUJQUKIGzATV/vcKHFTEbzfX0vY7LZ0WS1/VVLZCKFTGgqGLpQUCcTKvvDN7xfm+5T1Q5Yt3FsXB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:04:41.6931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 211f65c6-8460-4adf-cc8d-08de8fbcf27f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578

Hi James,

On 30-03-2026 20:05, James Clark wrote:
> 
> On 10/03/2026 10:08 am, Swapnil Sapkal wrote:
>> Hi Ian,
>>
>> Sorry for the delay.
>>
>> On 04-03-2026 00:17, Ian Rogers wrote:
>>> On Mon, Jan 19, 2026 at 10:02 AM Swapnil Sapkal
>>> <swapnil.sapkal@amd.com> wrote:
>>> [ snip ]
>>>> +       /* wait for signal */
>>>> +       pause();
>>>
>>> I'm seeing the perf sched stats test hang here, requiring me to kill
>>> the perf process started by the test. It is unclear what signal is
>>> being waited upon, but is there a race condition where the signal
>>> could have occurred before the pause? Should the pause at least be
>>> conditional on that happening? Given that a race condition would exist
>>> even with a test, would it be better to use a condition variable?
>>>
>>
>> I am able to reproduce the issue. There are other places also where the
>> same issue can be reproduced. (e.g. with `perf lock contention -b`)
>>
>> I will propose a fix.
>>
>>> Thanks,
>>> Ian
>> -- 
>> Thanks and Regards,
>> Swapnil
> 
> Hi Swapnil,
> 
> I'm also seeing the same issue, did you come up with a fix yet? I think
> checking the finish condition in a loop would work as long as it's
> sleep() instead of pause(). Or if you want to use pause() you have to
> mask the signals before launching and then do a sigsuspend() to unmask
> and pause atomically.
> 
> I was able to reproduce it every time by using the runs per test option:
> 
>    $ perf test -vvv -r 10 "perf sched stats tests"
> 

I sent the fix for here.

https://lore.kernel.org/all/20260401064114.141066-1-swapnil.sapkal@amd.com/. 


> Running multiple in parallel also showed another issue because the test
> writes to and deletes perf.data in the current working directory.
> Usually the tests do mktmp somewhere so they have a unique output dir to
> not conflict with other tests.

I will work on this issue.

> 
> Thanks
> James
> 
--
Thanks and Regards,
Swapnil
