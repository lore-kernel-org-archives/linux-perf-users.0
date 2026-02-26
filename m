Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F439E16A;
	Thu, 26 Feb 2026 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097640; cv=fail; b=OIsasaqEvL+Rx96jfslZcSTDSNQTZeIiu7aPEqFCVNXCfwQNkNPuwTSp2sDHDpjVdN5cocU+O8zsj4oLZiCNrqbU9JlP7EJzES/e4naP+XFDEUzAanzZDcwI7Em2WqISgo49BH/X+ARXNtcJ6VLljmqoMK9ryVzRWYh3mr3FhKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097640; c=relaxed/simple;
	bh=BiJ8/g/MQtlo3Oh4vv6iKEYDWzrKpyKgJMmku9K1lPc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=usriIUyIZLyJ0/RCHIlEpzBJC2fXy0WvGNCniRW03dcyCqwfg4DU0CYcR/szx93zJwkSGKw7BouNcjvFpSGv6+h4fVSxS83s4WWOHiwRCRuQ+OOv1xDctMv9sinaw4RjzmsJnAzAwruOrhbXsJhZ3gTnBBplIQTJVb1JSi67EGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VjWN7Z/G; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VjWN7Z/G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOLjuSh4da0YcqIgnvZVfbVVdhVyCp/vYuPkwjIvAOwNCFVTOo6QtW5dWSzuwpQJpH56CuoAMSTr3vrSkPaXyX6wve3CX0Mz50YnuJGLHLQgg23C4CTReQueys++GHYMBG8+F4RdUgvMOgx+thoRyrBZl8l0EOeccAALu8sxZEfckJ53zAbCh8IEYT2KrYBBrA6a+EelwDiy870O4F5p/kL8zJ2NIqvBozdUAel5EfVo0VDE6o9JyrcK1F4k2hmnkwJ2AB0nh6vVQHrTGS9C7HRUHgAJtt6O2cmUkn+v7h5vpLdfgTzCfH9xTA+Kj+Acw24X7QL42/7e2SS3kRTsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SQnt5H1nxQrAIACn1viZYdMQhj3kAuNCaoQ1G/UpRo=;
 b=LEuSmP2j+PZv+dJCjOl1h/zuppI5bULi+eY/Iol672MXu7g96Qfj5sYuoYK9MIwecXKGhjtcW7LD5zq3cj+N0L4ZNJgQyRVdw94MF0UXPXeVJFClw2EZ4HW03tJZA3Q4DiNWBegVs7p0bPp2YgfF7glvizjZ1iI1h9DFTnEigXqxShLAiZoVClMTFZuKHm3FTAUJ1kkiRO3ffXYfisHGc49tRX/jS9ahK6g4njG+tFa201F9qMpSS+s49e7xvdTnu2KFv8DDT3L7GTvfiuCbVO1BQvRpq6sY9RMniRRUD2gDSZ632oflw4cyXFfzj4UTC6zU+HW42JzjHw3BakH1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SQnt5H1nxQrAIACn1viZYdMQhj3kAuNCaoQ1G/UpRo=;
 b=VjWN7Z/Gfko/IDNIXRbwx28fOEbY2k2ZBqmBNtEpjY/eHeK9vwgm0sSysO0gwS7az1chngEAhVSEpAuefcxNEqMg8KaDg37YoeeAH0+I3kk7J8XneuNUqZSnc4+lyqrpZnCioJY2owGOn9JkXfT8QacbltZub9wlCeDI+OG1zec=
Received: from PH8P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::26)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 09:20:32 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::10) by PH8P220CA0016.outlook.office365.com
 (2603:10b6:510:345::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 09:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:20:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 03:20:30 -0600
Received: from [172.31.177.127] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Feb 2026 03:20:26 -0600
Message-ID: <8b99652d-155a-444e-8395-d461714bf4b8@amd.com>
Date: Thu, 26 Feb 2026 14:50:26 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v2 5/7] perf/amd/ibs: Enable RIP bit63 hardware filtering
To: Ian Rogers <irogers@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>, "Stephane
 Eranian" <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260216042530.1546-1-ravi.bangoria@amd.com>
 <20260216042530.1546-6-ravi.bangoria@amd.com>
 <CAP-5=fV_cJskvLRZhQQXMGAcPUb_Rg_b30PDJNXzxL49JK4B5g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP-5=fV_cJskvLRZhQQXMGAcPUb_Rg_b30PDJNXzxL49JK4B5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: c2409a98-8910-41a5-521b-08de75184a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	crelVZvM2/WHuQMj1b9s0ofKsCKWL1W1K5ubxW2nsBdBbNBYPsB1+zgaJb1XgKvzxXgICYF2cdRZfSgRwUOcsmXSb0kMDYCEyfxrMi6q7uRXpwXbuU70XS3pU9nO4X5hKDbebqoofqOtZBiUNKJqof3CQUrhKhSq0lJaEy0Q/YIXzs8F0rJOels6WaLgk4KF17Fq3hcOJLA0Ioq+ZS3SHJ8jXdDvXShUp3W7tzYttQMzV4BHUk7bIF3BI/GXtlj4UdCX7kbUBtFqQI81YLiV5sCixzGIqLwYCxtFoO0Jb5ZME+27snaEC+RPJSOErTPC4nliUxao9YF3UCbF/oCP3PsP63GlbjVtgScw/VG16We9S12gap2TFYE89PBA7rcnsy3r91IovGhZlBE8diRamF1vMMny1rzn94tz1cfJCN448Vi5mq9cRNQ7oT2dvxjLOTr/yrQgNeH0OSRA81yxbPdVo128kqR1DskeVFhjQyCQjFoEqNDZ1dxJyt0YQgGIWAJqWzIgqg4wQPFbZO2gV++/4qfQxn2j6beOwzonu0wzulQUNrTdTTsxlCON8GaTKmUMezKIXYaLP3Up9+dajILocmWvpXveLDtDQMdiDubRUgiVnQtB+xXYoMKExdtY/i7/dUCNHJV4JzJ1RXcTRwkeLuw28tUxQuVW/oIHymiN/FtxDQVbvfR9NVKUFFlZBqmcy+af9onWiiC7z3lQpB/M1MAiirmNMHOATes+kg3eVkXG7miI8zYus8LfOXSN4Pi3AOj8MT73DUSpik/yx+gexbIcpagzhokC7aLiFJ8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h4GJ33g0w5mJX9GbboRl8SKkqopLIqamDH+A1G2/uGaL1xmWA39M40PrdHV7k6ftXX0oYR5Z6SAoY83iQrVbB4xwk6y0jz0A7eDPIoJPYnifdVdxsbOxtZO8CL/2M/uvWXtlyba1x/rAhCjDEKQwjDbRVD2j3NOyAW7VSSyqV/FhMX+p2LwC2aw/URDGhCV5XYWLYSrgjEYyj+ZdosuzYcBj7Qb1jeOljQR2Ddq6LHBmaM1jBGq7+Dl1NZWI/ehqoyXU+KZXknJ8tIeq8zJVfHIKkFrvbXHFGeyw1zSUq/+q/FKhjjPua0bOWRXOIxK5XLFcwqfkZHrGgIXT04zDoacGs0F8PHUUACq7ICbqAl4qZcM+ioSuSOKboGBmAMK/PNh6u5xrWoP0hpot/aUWrXWOIujJj3tQiaadsS8G/R57Bg17evvPZmTtHPZaxL4v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:20:31.6178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2409a98-8910-41a5-521b-08de75184a29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547

Hi Ian,

>> IBS on future hardware adds the ability to filter IBS events by examining
>> RIP bit 63. Because Linux kernel addresses always have bit 63 set while
>> user-space addresses never do, this capability can be used as a privilege
>> filter.
> 
> Since x86's top-byte-ignore/linear-address-masking leaves bit 63 could
> this break in the future if the kernel later ignores all bits,
> including bit 63, and user space wants to use bit 63 of the pointer
> for metadata?

The AMD equivalent feature is called Upper Address Ignore (UAI).

o Identifying whether an address is in kernel or user space by examining
  bit 63 is so fundamental in Linux that the UAI design was revisited in
  UAIv2 to restore bit 63 as canonical:
  https://lore.kernel.org/lkml/6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com

o UAI applies only to data addresses; instruction addresses must remain
  canonical.

So I assume this should not be an issue, at least for now.

> Does the bit 63 assumption hold for guest operating systems?

Yes, this seems to be an issue, even with current swfilt approach. Let
me inspect the code and get back.

Thanks for the review,
Ravi
