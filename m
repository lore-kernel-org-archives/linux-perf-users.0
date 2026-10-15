Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610DA4908B2
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047001; cv=fail; b=usuF3Qbeyi/0ofDW8qUxkQ/a1qnnsYoyH+45cRrLCii72HyZWxCNrEqjSThinJDki3hmVjMK9DXF/MgAg4r/YySSZqFJBErnm90/zZkysS0bpUeUEkRsQzHzpKYjngVXlcDl92reS7uGk30X5/OKIY4fgjjsiisbNW3MrJBQPz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047001; c=relaxed/simple;
	bh=SoRAG7tArVJRlNF06mQzIBWuHSvnzpv/GyoxTHNiXqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AKuYkE/kj/INB87jbgBdU8Na+Hoq1JwbvDx9udMOKy30+Je4QlMeZxWfmQNaywrwFMHTTF+ljNpiJOMydtcUcLgeg7funhFkvJ5lAl1W8UmUABarX4uINAEdeAVdzu1D99U9EaAiPXHdIhN2ceNb9FLxl7jQck5VoN/b5N9B42Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g5Ro4YAf; arc=fail smtp.client-ip=52.101.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g5Ro4YAf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0XSaCyto1TUu34wigpFdijSFLJ3qKSyAZjMZQzce/rdbXN75yZ8DUIKBPFmoliA3QN4TXw63lYhwqvcLaK/ycP1j7dtF4YRLiGh1UQ8KJUcxMFfkIH2f7E/smMdEd3O/a/A8LsFMzEI72MApej2gnXoFpFeA1W0cOsRDkHRiJpm/hE6vd6K6GrErNO70oQDLR8tthLuJzfLD+YhNxpfVTrWCwo5odIW8n95JmMAWJF/3m+Csc14KXrTEq7HcIuXPKAX/FvRFf1RHB8EUy/3uPkTlnUaRg/GG0Vy95hpIqoPFyvd07lboLUK3lIWwQoQfWRntbkWMWpEmgVD7Xxc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/E3fURLtIzRugzOWyI3bQWFPtXvs9O3C6x7QwmnB3c=;
 b=hYc8U01RXQEUM/E5t49zKAkw1l9FXj22zX1xuiJk4Y8TAcBJRimWsFcOKgr3EF4B0kL2VyhzidlQ2CRZ8+oAyT7zGIKucvfhmcRn43fPjlA0mFbmmjcJO6UieNK9k2lmwbF2ZUN2j2CctUmLaoAktnkYpiOalyPsMETZ7op2BQgz970raP+v6yPUvz44ci4yVegZbhg4I33EqvyJ+1HXw94IdMkLjJzeZxlUxmEQmsjaSML/UY9YtvQ64ZuoTbYKx0Ga6+n4fbBN3exHo3aCyVcv+lEYPisTaZ45PvcTR9L2dbitBrm/FaYMbvHnqbPhPryFdtzvkVdnMcwMg0DrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/E3fURLtIzRugzOWyI3bQWFPtXvs9O3C6x7QwmnB3c=;
 b=g5Ro4YAf2PsfpTCuGnYpb4PXRVD79dmoMmlDX1mHyt42TZBKUCcRZLcpZ8k3EPRm+P0DudvBsT+dGg8qlr9TitHUAyTYuWo8d1QlNOFWnPuZ2TOaQA7oDJOtb3zoxReCWGR6lQBqaPbTovctpGJyS7UCsIukrbT7+acJ8TnKUaI=
Received: from BN9PR03CA0866.namprd03.prod.outlook.com (2603:10b6:408:13d::31)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 06:49:54 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::e) by BN9PR03CA0866.outlook.office365.com
 (2603:10b6:408:13d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 06:49:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:49:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:49:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:49:47 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 15 Oct 2026 01:49:45 -0500
Message-ID: <b65d8983-aedc-46c3-986c-6353b56e472f@amd.com>
Date: Thu, 15 Oct 2026 12:19:39 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf/amd/ibs: Simplify event state handling with
 IBS_CAPS_DIS
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-perf-users@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20261015060430.5877-1-ravi.bangoria@amd.com>
 <20261015060430.5877-4-ravi.bangoria@amd.com>
 <sashiko-outbox-172339@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <sashiko-outbox-172339@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 924ba1a6-4c45-4cff-a2a5-08df2a8884af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	muQjZ6fe1ba8C11ev9uDUHjK/j7Djr7YiySv/bwfnsUOJf/YdSDZDRSQT9C36ygrgTdQTSsqgGovXuNtwxxO+3D24X6d4kKAetWq0chjoNL9ICBlAMJGG0I7gxaZtMflAfyW5kSrVUEnRJNktjs16noDtXvcTn/fpuPHiiRIK1qEE5roEukLqEkg0NKMlCb1otYNUzk/CD6MTiKnfPHjNCoIxyynyBccRHpOuVes1oSWQJ0oYz3MmK/AtY7FjowNRxFsEprtpdmcc1LjmAOWsfeHEair1/Ww/VZ6AKvEfsCeWS/1f+IfzxihG7x/OBMgEEg5lN9v4SZ2lHyqHqZo9MIVuvJlgjXgQN4AvQEkjhRXIkMGw7tJh3kp2iyhzy1YoJzbplFaEwLEHg8xpnQf89tWhwvkzvT3+BFPfJDkPKsqmKcLkIrhewvUoa6u0GdM+UtW97Kt5D9atMqozC9r6Rnt7MtNEBasjsFA/7mfPuk6FR3yGQpmoqRJ9OubxzhaU+nUEwPR2QUlrqg7eTtjqTMpdYqEGWlNJA1zgpmlpY3HhBgnK4UnvG7+Q77r0wXA3Q9VOEMTpJsTkXvgxeFIM0PvIOMdfMmLED3Xu1acZlr9EXKs7xcqM3RIVwYAT+27HZjbdB8xGgOtfZiFWNtmGrCmfLdAnS72ppkknWSKhW+4PCFtQ0YEzc3kX6b7yNRqTgISYLUExF08ay4HGUzO1g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zsl+zBf7SIKTXZQ7qO9fxTwstRWWe+oDhbERKPEHBPMbfpAEJT49OwuxHhYb9heEtFrdxe3d2yi38sSZv8ckjBzbXQJme7PugwsjH8HM50z04tXkN2BqgXL7+MbgjhJmU6+otM0tVDhWlHRiUgm9sqnNDqiOrhSEOeVMxruPCiydVlZadzskVIRcBWw7VeD2LGauMFixVB3ECamAf/nA4tIIdub2kxSprWH44G5aSvvT/sRqNomZEmYkRc0wZ7XmrwroHxxiNrsUHtk6CTB1BicyGi2HodrpF5Vqot503N60rqrQQ1zLlFgjYqf904K7hJv54xmyknLN77jwuFvns1O1DTsc06yhTIEFs7lKMn3kPApkt6w5wPOA+el8mhJEkMv3yWttdyXjTBkBpZ8iI8ssKvHg7R4nvwkw37fpoOz3ySFQUmegdm+vlP+hSSyD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:49:53.9538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924ba1a6-4c45-4cff-a2a5-08df2a8884af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

>> +     if (ibs_caps & IBS_CAPS_DIS) {
>> +             /*
>> +              *      IBS HW                     SW
>> +              *
>> +              *  o Capture sample       o ->stop()
>> +              *  o Set VAL bit            CTL2[Dis] = 1
>> +              *  o Raise NMI --.        o ...
>> +              *                 \       o ->start()
>> +              *                  \        wrmsr(IBS_{FETCH|OP}_CTL, new value);
>> +              *                   \       (wrmsr clears the VAL bit)
>> +              *                    `--> o Receives delayed NMI
>> +              *                           (Unknown NMI since VAL bit is cleared)
>> +              *
>> +              * Handle this with induced delay.
>> +              */
>> +             rdmsrq(hwc->config_base, ctl);
>> +             while ((ctl & perf_ibs->valid_mask) && delay--) {
>> +                     udelay(1);
>> +                     rdmsrq(hwc->config_base, ctl);
>> +             }
> 
> [Severity: High]
> What happens if the delayed NMI takes longer than 50us to arrive, for
> example due to hypervisor scheduling, nested virtualization, or SMIs?
> 
> If this delay loop expires, the code proceeds to call
> perf_ibs_enable_event() which clears the VAL and CTL2[Dis] bits. When the
> delayed NMI eventually arrives, it appears it will be treated as an
> unhandled NMI.

A delay exceeding 50us is highly unlikely in practice, and even if it
occurs, the consequence is "Unknown NMI", which is not fatal.

Thanks,
Ravi
