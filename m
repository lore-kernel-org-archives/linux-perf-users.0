Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888752C21DC;
	Fri, 23 Jan 2026 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185963; cv=fail; b=DpMZr33oS4cmvxGpI5shiyATbS8DrjPAUZZjmGYLKHh9DPje6r2VxT1lC7iPpCBFerQaF90oD6APZPC9SrY+RDKlGpt6Q9ZNsnF2PnWw6OTFmGJYYLFBUUV5Yhf2gYozF3deQLGcM0nDSjFrtjR0Gr+qVq2doTQfbdv7iWULGNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185963; c=relaxed/simple;
	bh=UwJCG1Wr9xFfp7leqzTa/A4Gmr+rVOZE8yt0nk0xldI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=olHc4J/2qzmdXpThZQ8ypYHSJ/OKDeKiDS7aCDn+oH7DtbCKMZlEHWGbGp8JDqMTOppE6uj38tWIGWFiRZGuwuugVA9nfuMslP24sJArLgmBa5JXou94/In+oSSmC2oS+3Az7ImvY63Me1dWba2Qt5d0KokuUuAsQ5osvbQIS5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YR2Os6ay; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YR2Os6ay"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6pVpea7KDnGi8KgTKGyhgFR2LKXLgLAf32S/1ozsygE9cbbQFkwG7EpprmkXliGLXGVU0znb8BOIj/WivSja5y62jRq+fX3JQXPytvTpaEPc1opOBF+uR+d9QuXPY/IAJwxH6EkrUIGIryI5yPL7l7Bzqw7zvjbNK6r6Zvtn+80x9/0V+EMWQ/EUqpvHdreZNjqoOxxsywXaO8Qqfwmoa2DaCxpiObIlUD+ImQUp50D+0F3P8Y8V7Muie0NP0ByW6uJmyy+k+yhAXTrCRGpEIIIaryJ+URWVMOX/B+MBC3D4JPj0Lr+WK6/CHMXsn76pCKglx9UGvmPNE/V/S90mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO5E3x7zrM4XOsh48kCV4cL0Cm7/M/qMXAsLJyOEbOg=;
 b=D1l0LoiOB8yaDfSdr82C7QBUumvDUN3SgjNZ9T8cDqRwzaJB4yC9ZgATT2PY+diu+/L1zquZAmuRBIV4+549RMT/38lz4BpUfkp4a/2mgfmMJHkJAG+0gKTc+duYTn81dYhzIn9uw1ZwxXeRFajY3YWAuW8Ssv3Q1lo0z71t7esp3oO+k3RVrlNV02Tc6nFLVFZ4/tqaUhSADy5CHMHoD8G2ycsVB8WON9KuiatoFveh0RWdu9Eat1k1Op2Vavb1g3DlHnJ076J8eEwj/oEhzZFYCr7Stjn7/KfD2XkuNJI0aylcHcCTgGB9ysZZwrrmOHq7iR00/dfKEAZ1bdXpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO5E3x7zrM4XOsh48kCV4cL0Cm7/M/qMXAsLJyOEbOg=;
 b=YR2Os6ayOCpTUuBJxPqfV4STkzmKKedDRwg8CvvUhO1weiuz/qPXPVjmfdq7mOQJJLAQoNIvacRm36s7sxsU8od6V2II1DM27UjFOHiVfTkFUczt/7bXJ+7h75BQwRaDw3AvJ6DELNcMrXa8rWSkHY4ECGdu+I0n6zIkwl9dulk=
Received: from BYAPR11CA0083.namprd11.prod.outlook.com (2603:10b6:a03:f4::24)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 16:32:32 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::7a) by BYAPR11CA0083.outlook.office365.com
 (2603:10b6:a03:f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 16:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 16:32:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 10:32:26 -0600
Received: from [10.252.192.223] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 08:32:17 -0800
Message-ID: <f735d3c7-d3b9-4056-ba76-e0b4e8366356@amd.com>
Date: Fri, 23 Jan 2026 22:02:11 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ian Rogers <irogers@google.com>, "Chen, Yu C" <yu.c.chen@intel.com>,
	<ravi.bangoria@amd.com>, <mark.rutland@arm.com>,
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
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<mingo@redhat.com>, <namhyung@kernel.org>, <james.clark@arm.com>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com>
 <20260121163342.GI166857@noisy.programming.kicks-ass.net>
 <CAP-5=fX=QuRw8M4Xco=A8WbBfDSPmyjtQ-JdnBEM-VRdX65_1g@mail.gmail.com>
 <20260121195155.GP166857@noisy.programming.kicks-ass.net>
 <aXEyJCSqlPPUS9YG@x1>
 <20260121201034.GC171111@noisy.programming.kicks-ass.net>
 <aXJJirXQ9jsnewn9@x1>
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <aXJJirXQ9jsnewn9@x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cc5c99-1bc8-4af7-fa39-08de5a9d01c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emRpY05IdjhDaHNDZHJvUmszUllTOVJTN2phUWptb09kWU5Ud2RXbzRLYjds?=
 =?utf-8?B?TWZPUFJ6WTRESEVYVnYyVU1TcEhQWEduVEFtYk5BVU5XUUlBVFo4ZU8xMU1z?=
 =?utf-8?B?QUtheWVFOUxWWmFGNEdvVFIrSkZkU1RZa245dktOeTd2NUdCK0FKeFZ0a3Q0?=
 =?utf-8?B?ZE9vRVBHdC9JYVZWcEFmU0EyUllkZW1GODQzWXVlVmZod0lwNDdPRlh6bXh1?=
 =?utf-8?B?OElUbStjc1dVNFVCQ1VpWkJzVjFRQkFMc2dwclhobGxvNzFVcE1oQjRwZ3cw?=
 =?utf-8?B?YzA0WlVBdGt0anA0UGNmV2tFamh0NytKc09NeHdsdFhSdVpBVXJSaFppeU5H?=
 =?utf-8?B?cUtKclBydzB1YWJIeDJMc0tqSUJGSEdNMmRVSXRsL21SMDN5cU1haXl3V2xh?=
 =?utf-8?B?UnBCNTFURkJGQldPblRoMkNobnJqV1VIaGtucmg5c21SMlc0QmhQVDZkMTFW?=
 =?utf-8?B?L1JlcXFBWWhXNS9OcTVNQjhzR0szNHVFV0FYOHA0SnQ3d0lBVFhNZklFVFZB?=
 =?utf-8?B?WGNFV2I1V0NSVm9pdUJYZFBYZ3JkL05IWFltQVRjNXJQallCZk1sWVVQckta?=
 =?utf-8?B?Mm5JYnlQejhPRG8rY0ZhK0hjRzBjdXZYLzA0Nkl0VmhGRkZZSUxRc3FUSFdV?=
 =?utf-8?B?WlJFTGRzV1JhZXlBZTBnczBaMDVDUW9aanVoYkhsMEpXQ1hJUlhZcEwvck1l?=
 =?utf-8?B?Y3JyMU83ZmpJTmZIZGVQQWZDZ3Q0NFU4Q0J2NTlDa1p3T2tDOEs0T3pCYVkr?=
 =?utf-8?B?S1crUTNYQ3l6OUQ4bUJmWE5kbDdOSW0rSkVLK1piQ0x0d2tWbzFzQzZrem1H?=
 =?utf-8?B?eUVBaUx2elpYS0p2cHNHN1JRQXJWMkFCODQyZ1E0WGFQRWs3dWw4N3pxWHp1?=
 =?utf-8?B?b284ZnZDWkNBU0kzaTNjOFduZWZCazkxb0dIcTY0cm9TUDdabkNWb0NSNzVY?=
 =?utf-8?B?T2k3Y2pZNjdoNGdPMzNWNDdGRGJsb0U0U3JGTFRkTUNZN0YydnZkWHltQ281?=
 =?utf-8?B?bG5oazk1cyt4WmpiOFVUY25oRXJOOGdQWVhLZkl3SHM4eko5KzR0TDh6RExa?=
 =?utf-8?B?T0xnaVBaTUk1TitlcUZ2bjZZbU5yLzJ4dXhoL1IxSFVHL0NIb3B2c1dlNndV?=
 =?utf-8?B?aGk4dFJsMng3VHgzaFNrK2ZlZkp5NVpBd2JGVDZuWFg3eUJ0SHdnbFVTRmI0?=
 =?utf-8?B?NXJ6MEYvM3ZRU1BhZlJyWC9nZGtCMXduekNjSmMzcUNnQnI5UXZyTTdzWEZZ?=
 =?utf-8?B?UkVHZ3NPSDVybHFkWnhyYTFzKzZLS0V2Wk5wMXZLVzVPenljVGV3Y2JjZHFa?=
 =?utf-8?B?UnBIcjdoUUhML3BJVnI5VXpobk5JcDZ4TzZTaUZhWWwzcU5nMzJUWSt3emJ6?=
 =?utf-8?B?Q2JoMEZHdC9Uejg5VUZaZWRtZEIraUNkYVhXUXl6Q3gyRlFiU250NkxQMkFG?=
 =?utf-8?B?ZzhqMEs1eUFFYlo0NkFxUXlIV014UFAzSWtvZkVQdVFHdklDaFRUeXQwcnpS?=
 =?utf-8?B?WWhWeUVhLzhzNjkzL2lwSlhNT1J2WGU3NXRySFZjWG1yUkYvRHI0S1c5Z2J0?=
 =?utf-8?B?NDdqbnRMSm1zQnY5aVhqVlloL2dDd1lSMi9BdUQ1VHArakRZTU5RbUdLZktE?=
 =?utf-8?B?WVROMlV6NVBXa2thUXJURldsS0lPOC95RjJ0RUQ3dVlmQlRQQWJha3JNRytG?=
 =?utf-8?B?UkRIMEFPSWRxUSsvUWxVSjVLSHNRbE4yaVRxb2k1VEN0UWl5WSs1YzR4cVc4?=
 =?utf-8?B?VjlMS2hadkNBdjdSL3FtR0Y3THRzbkUwZml4dUhGZ3E5amtHSEphcmVnemFO?=
 =?utf-8?B?UllZSzVJZDdKMG5zRVVjTFBHSkdLL1B5dXUwSTNrMFFFbU05N3B5Nlc4Sk9v?=
 =?utf-8?B?dzRjM2swR0xUaWtRWU1UYWZtZi9BY2x3VzJ6TmNUSTdMMTVQOVFwSm1haGZt?=
 =?utf-8?B?WmtIR0hvZ1lUdHZUTVRKMkxkN1NzY2pabHpZbTZ5bXFHeTZUd1M4VXdEem5a?=
 =?utf-8?B?WU8ySU9UekdFUWE0bE1KL3JTN1RVTHcycmpOTVh6VHA3enBkUERMVnZvUDBu?=
 =?utf-8?B?dHh5Z2wxZW1YSkdCUE9VOTV6TDJoMWk5dk83aWVxQzZmYjRoU3FDU0RKZnpB?=
 =?utf-8?B?UmxUUDQxZC95aHZwcWVheWIwckw0R1U4TE1KUjR0d0VUQ3RVVnVZS0l5REJV?=
 =?utf-8?B?T3BENFZmNVpScW9qdUFxakx2djQxNUU3aGxEQS9OTXRTMmtjcGtpcmNTTEhV?=
 =?utf-8?B?QW1QUUtBNWJqU0lOeWVyVVJhQm1BPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 16:32:31.8203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cc5c99-1bc8-4af7-fa39-08de5a9d01c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

Hello Arnaldo,

On 22-01-2026 21:30, Arnaldo Carvalho de Melo wrote:
> On Wed, Jan 21, 2026 at 09:10:34PM +0100, Peter Zijlstra wrote:
>> On Wed, Jan 21, 2026 at 05:08:04PM -0300, Arnaldo Carvalho de Melo wrote:
>>> Until then, since you and Ian acked this one, I'm going over it and
>>> tentatively merging it,
>   
>> Thanks!
> 
> It is on
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> 
> Has the two minor fixes to overcome that 'sv' maybe used uninitialized
> on the error path + 32-bit build, I will move to perf-tools-next after
> it gets built on all the test containers, later today.
> 
> - Arnaldo

Thank you for the two fixes.

I have a fix for the man page, do you want me to send a separate fix 
patch or will you please consider it with this series?
