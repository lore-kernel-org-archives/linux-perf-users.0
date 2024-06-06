Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3001EEF7;
	Thu,  6 Jun 2024 04:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649119; cv=fail; b=NUy64GVR96paoO9ZTAHbsL7bAh4O0v6n5H1T1RHx4jB5Df/ONB2KdaUFhO4j65yxonByPhJRNhQcCv+PI+Et016gf+9Myiyxq4RI/G6U5EQ2yLx0DCWgyjsDu873gqKrQhOjHrhCtPKrt6l0mlbI1mZn11rDUzoobnXG2JvcY4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649119; c=relaxed/simple;
	bh=+FHjpg1ZgGsVhmOuLJqkgFi0TO3KuOoAfPsHVuMjnXU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WUncUeeDGrbYjMy74Kl/HTznkJ1chiTOgamQxOgdYbfXdXs8lTQDvbRVzL17sUBqHeyDV0tqEsyrhA1oAS5RdFcck/KTRW2TjLZ1cOuYillUGf+AWHr9PdFdq8fFhu5RYdc+k9HopdqjLtccCakO0TUA5X5MmBpcRdTgVzmqHtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RxnzQd8Q; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RxnzQd8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH1LtYimrRVWWT/wdwpeCNNp8dbKpUu4z5xMbIGTw46YznSPP9Ne6guTHuEQThe42sswRIhR5af1qinfueiMWW9A7+/yLqNKXYeqE685IXacN8xEEmKwzrOLq/nrsFU2Q/q35/OMslCs52xG0mLs5aZLPgUhhi9+rKyRpfk6Nkxij9XfQg19v9xrbLb6rjf3WO/rz5xacE+dOG9r1toXi6gmgCR3OPvbOXx7/WmJXxbuyyxUZqjchA1D96uYGqEL6tfSCS9XFNAQZnBXgK0pQBzdi7m1UuObRxnDROg6VnlFIJ5Cmxta0QN+e9lX2zOepy+7kt+aXIY6cakgJMrvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FHjpg1ZgGsVhmOuLJqkgFi0TO3KuOoAfPsHVuMjnXU=;
 b=arvOZQV4zuOampgpm2QuucPbkXLW+CUWB9GdBU8TP9I7QbpXj0HY3SK8EAuvXOZwv8qr4EDxUxRW/rLAvXVgiVvEHOGCA0w/xhIrIp6JLc9PVbu50hpy4KYeIQzp0KsR4BUcB/zTOHaIinXjAzJDbwPd7xi8MkkkjMoPWzxl3Np8p/JQ0DdcrsTSPQP5Pv+IEkeEhK1ofi6ScmYOIgf0CfwGMrZYgFHJsUJEfII5v6dqtfR1xxoWZfxMjz42iEbcnur+oLvrkkvDg8cWcvU4sWT6x9kSLgn1RbZuw5/oRCR1sI1MACPxPzDMXqV5uaXgAu8Bi1lYARKh3oG+Fk5rjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FHjpg1ZgGsVhmOuLJqkgFi0TO3KuOoAfPsHVuMjnXU=;
 b=RxnzQd8Q3+Ec9rgd2Jc6jTAf840SgoibZLoR5TYPONVmKkrZLWQvTGpAmZRaElE9icWDovaDO+oSiJXNFDD9yOzQ8E/808ZXrqneJRYG6wGpgwYH9iLafz7P8HGyFcNUGTkpw/DMbe7d3mIMl7iN58Rk8TORYj29EDF7nVrEPI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 04:45:12 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7633.018; Thu, 6 Jun 2024
 04:45:12 +0000
Message-ID: <86136e0d-45e9-4bf4-826b-359e4993488f@amd.com>
Date: Thu, 6 Jun 2024 10:15:00 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v1] perf top: Make zeroing histogram on refresh the
 default
To: Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Mark Rutland
 <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 ravi.bangoria@amd.com
References: <20240516222159.3710131-1-irogers@google.com>
Content-Language: en-US
In-Reply-To: <20240516222159.3710131-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::34) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 7791368f-0add-434e-eb4f-08dc85e37386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXJHWWEyU1hnTEw3a2VYdmswam5NNFF3bjR0Y2c5STV2VUcyV0xDQU41cWFG?=
 =?utf-8?B?bVphcmxlbmUxMEM0aUhZZ1lOVEdTbzFka3U4NFRURjFYcm5tYkwrV0RxUzR6?=
 =?utf-8?B?M3d4YVEvZW95R1VDVkpBNTJ2UnFLSlZ1d1g4QjZ5N3l4bk0vM01mclJ0Y3lp?=
 =?utf-8?B?VDhVVEQveU9nK0JlVUFpbjZCS1l3cUtMcUdGaHZhSS9IR0RtQjVaV3pnYk95?=
 =?utf-8?B?T1VIOGxDYUdHWmhydVpCVnA3RVQwWGpuK0NsTmZxSHZ0bGNqNE42Ri9zWDRo?=
 =?utf-8?B?cG12UklSMExuRitEdFd1dDduM3I1ZlFXelltK1VpS0I4YmJiUCtzUFduR3ZL?=
 =?utf-8?B?RFVpajdPZitmT2dwemR1ejhkdUp5eWNTMWVNM0diSjBhcEZaYXdSS3Rabkt6?=
 =?utf-8?B?NXNWK29PUnpWRmtXeEMxZ2xHa3JjRG5KK3NCQ1FTK2F2aGpYT2xma1NTZWRz?=
 =?utf-8?B?eERzLzJGL0JHUHhmM005SjJ1Y0FFNlI2MVo2Q21SQTVDV2t2aWJ3T0hKRmd0?=
 =?utf-8?B?Nk5Wa3JzREZrdVkxZ05KSDhJbFl2Und2VGQyajZQZSt0bCsvazJneW5XMEVF?=
 =?utf-8?B?aVJmUEc1SmxKV1YrRXk4TzNGcWowRnl4YkNHSVp4c3ZpQmtHajdoQlJ5Ymg5?=
 =?utf-8?B?TEFhZFF5UTVtUGoveU9XV2NIbDhiWXZYT1NjL3dxOU9FUzU4UHorN2ZRQ1pj?=
 =?utf-8?B?S0lJc09hWkEwU0Vmb0J4b0lvNjNqOSswWnh0bjFjeEZwSTI1K0dncldpaU5P?=
 =?utf-8?B?b3p3VW82MDB6bE1GcENHRU0xbG4wYkZCdThnckJoM3pQZmpsVjIyZFF1ZWRa?=
 =?utf-8?B?QmZkMzBuOUJCQytUakRPWHhaTDR2S0t2WGFvbExpZ2crQWZpVnQvTjhYTGp5?=
 =?utf-8?B?YUZ4WjkvTUs1Y1dPaEYyZ3lyQWV2QitjMUQyWkdvTWR2YXdoQm1kVGhtN2xU?=
 =?utf-8?B?QnJCaDdSSWY1TXFkdHVLZDZoSWlKcU9lc3FwLy8zU0VMdGs4bDl4KzB4UUEr?=
 =?utf-8?B?MnB6aDZhQVZYaE9XU1I3dUxlR0Z6YTVpMFFnNEhtdUVENGhWUTZHVWVCRkpp?=
 =?utf-8?B?dHhGZThhcm5IVTBwR01xMDk5ZzdDVHJRYXR4SXV0aCt4NTliSmRPd3VGekV3?=
 =?utf-8?B?cGl6d2ZnMTBjVy9rSW1mRnpvdk1abStha2ttblZTQ3djNnRTZzVycGpqYmhV?=
 =?utf-8?B?a0tRV2M0RXRCU25HWWdKSmJUaEQwcU1tVE5ZMFZoTVIxQktyUnVFMTFndlB4?=
 =?utf-8?B?Snk5ODJoaGptcEpUZ3ZwWnFpTDk2YTdtdHRCMjl2QUtOYjBSZ1BPVGx6OFZT?=
 =?utf-8?B?cEl1L0FFeVV4S3NOaW5yZ2haQ0ZTbG80ejlyNFZCbmxjWEVpb3JsbEVFVHBX?=
 =?utf-8?B?OTA0b1R2eVVaNGk4ZEVaV0lVQTRwcG1BTGp4K1hEdjNoVWpNN0ZKSFB3Znha?=
 =?utf-8?B?S1NtZUxGU2ZySXdxSy9aS1R4cnJhL0JlZ05raHpBcW1qY0lob0F1QkdibUhV?=
 =?utf-8?B?MmhYaTdWbHBSa3o1TE0xaDIzOEl6UWE2M2NTU1VEV05UNjZQaWk2OHhoRUwz?=
 =?utf-8?B?SjF1bEs0OTNmeGE3V2o3VG5Ub3cwOTA3QmVLQ29XVG40bWUrSFRnSUJKS0N4?=
 =?utf-8?B?K0crWUVhbXR2SHVPZHlkME1lZmhKaEJWRkRSVWNxZklzb2JGVU93OCsyVE9K?=
 =?utf-8?B?NGxTektzUTN2Y0RHWEFuMVlKTWhpN3JwSndRaCszVTQ4b2ZhbUxuMDZqVnV3?=
 =?utf-8?Q?H938QVAhw2kpNZYUXIP9ePBxqGeepOZfiy+m1Zn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3hKWVRWdTRjUlZucjFqS0Y5TVNLNTlXbDZxVGRCNkNPOTVrMU44QmJHS2JQ?=
 =?utf-8?B?eGxkQk0zVktscXRjYjR2ZCtpQzcxZGFGTUpNRFl4Q3g2Vm8vb1ZGeFNra2FU?=
 =?utf-8?B?Tno5NjZLb00raDJxZS9xbDJuckZJR0NzS0lzNnRVa1QrKzA2WEFhT284WTBn?=
 =?utf-8?B?OXE0SFErLzZtdDlYN1FOQ2lEbW1BZFl3WmQrLzhYYldVZk5WeHRjTGE5L21C?=
 =?utf-8?B?L3lIVDF0UUFGSFFhK0NaanJ2clVTajRrY3RHZVZURElqMU5VdmN0bzkzL1lB?=
 =?utf-8?B?bXVtUHBJTmhVdFlIVWJyTlpMVmZQM0QzZmVUTTRsWE1tT1JETFYvZm96RmpP?=
 =?utf-8?B?U24rcXFROW1lYUFaODVXTk9JNVJDaCtvaFNMYk1CSXpSNUFENmdtVFVqUU0z?=
 =?utf-8?B?bVJOUHZTb1NlRlhYTFFJME9VcE5ENVBQYisyVDBUVmIrdGI4UzB4a3ZUYndh?=
 =?utf-8?B?SGEyZGZsWnhNRjlzRHJYNmRrMExUVFNsNDNlbllvRmpuNkZLK1ZteE1yTmky?=
 =?utf-8?B?TnFrUDVqYXowN1VvVWdIL0ZRS2x6MDM4ejV2dUdwdmNqVHM5N2NGeUFUTGlx?=
 =?utf-8?B?Z0c3NkFlUERzTHMwbHAyTjVvVHdnZTlxZUsvMWc1Z1NDZThGOGEwUHpNNDY1?=
 =?utf-8?B?QjQ2dHA3cXhqODV4d3ZXUnhic0VubFJscU1HOFlQWU9RWmZMWU83WjcwWkVK?=
 =?utf-8?B?U1kvUHVWMloyeFg2ME92WHJZODVZYmFKK2lYd2NXTkMybWgxNHpLZXBzMG1M?=
 =?utf-8?B?LzBDUi9YTG54NnFFSzBKN1VKVEJXUmFKTWxyVmlTcmlyZkxFMm9NNktEcU9l?=
 =?utf-8?B?OGNQRFpCR1hlSFp1ZE9wZHp3NjJQNkNCdHBEZGJRUWcwYUNvSmVlNy9kZTVR?=
 =?utf-8?B?eURyUU9iSGNBSnVveGJkZ0dweXdMREJwVHVIczRZeW4wVEFvMTVLb0ZUaEVF?=
 =?utf-8?B?TFBtMzdia1o4M0YxdUw0eS9xamJuTVBqbU5YUU4wTHhqaVBKQ1h1bUpOYVBt?=
 =?utf-8?B?QjhuT3pYS01mREJtVkc1dmZqZW54L0tYRk5HMTNoM1JYK1AxTEVkN1Fadnp2?=
 =?utf-8?B?TDNHeGMvQUZJT2NQTnJnYUV1bXVxVnQrTWgyRXgvVkQyd1NMMWxDQ1duZHo1?=
 =?utf-8?B?RzlyeGN2RlVyMXBEM3JhcE1zc1hBOUdJVjZ3VytkWmFhWnlROXlmUklFNElh?=
 =?utf-8?B?dm1HSis5Qnd5R2VKdWF1UU9IcDN1K0lhT003U1NYTGNPQUEzbGltR1lNT0tq?=
 =?utf-8?B?NE9GZVMrcEVGMzU3ZlFhMEJMdGh0QTJrUnh4eHIvYUw3SjlNTmZud1JDajlh?=
 =?utf-8?B?L3Foa2t1eHkxcDdhU0g3a3YwYTdXWjAyWk5iZW1maWNBQUxMdkZKdEUzVFdt?=
 =?utf-8?B?Q2pVRGNLSEZnMWs4VEdkWHUrVGhqWFZGL250TUs0M1FHdzNOS0FyTjVRaXUy?=
 =?utf-8?B?YStEdWRRdGsraExaVnRucEt6VkNjMzdWcWV3T29rbzFXcTZ2YnNDMVU0S0tw?=
 =?utf-8?B?ZXQ4QUNCQ2thcWtDWFhMbUcwOFl4aHNVTHRMTEdiaVNlYjhBNVR6TnBoK3lo?=
 =?utf-8?B?L1BLS1B0WUx3dmw4NGI4Y2JtWGFXZmZRVEhpeWZDMHBLV2RObkhZMklqUVlS?=
 =?utf-8?B?OW82MWFlNWphQTR2cVNPQTBsZHhWOVY5TkdvRU1HMkVXK1ltT2ZNM3Y0Vjlw?=
 =?utf-8?B?OE0vNEVxNngvczVoZTRXdmVwdWxvU2tsVmE2RDlrK1FHbGxIbmg0VzZ1ZHhj?=
 =?utf-8?B?QW5oK1dseVRZTjFoclpEUUdZRmhXMFVCOVZVK0txdTNXYXVIUDlDam9LUk5E?=
 =?utf-8?B?M0l5ckd1YkNNdHFRSStJbE9pWldIMjN1dXVFYjJRdk12Q2JmWDA4SXM4UXF6?=
 =?utf-8?B?UWx4S2JKMEZtQm5zRVoyUjliRmtLcU53M2xKVFJha0IvYmNudUxvbVp2NUd5?=
 =?utf-8?B?cVJ3Ym9nbGJsb3NhRktPVUNGSkw4aHN6b1BIa2lkZFVYVWJzazlzbVZTSlg4?=
 =?utf-8?B?THJ2NjJ6SEhwcWtIODlpQ2F3bHBWcGUzUC9ZT3gwVWZCeHB1Nk1qRHNPa2Vz?=
 =?utf-8?B?N0ZGd1pQL2ZEeFhSQXNLNG5tWHoxVG16UFo3aml6cmp5c2IvVER1emNUVVkr?=
 =?utf-8?Q?zLVNd11SRF66WtdIysPRCc0PN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7791368f-0add-434e-eb4f-08dc85e37386
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 04:45:12.5217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etYKol6WGFC6e0cAV+gCk9WT8OaanL/Z4xIQZeUr4rd+xH/f8Cvi4XOn8cpCbITUZYEwAo9axYKfQUCjgbOCug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475

On 5/17/2024 3:51 AM, Ian Rogers wrote:
> Instead of decaying histograms over time change it so that they are
> zero-ed on each perf top refresh. Previously the option '-z', or
> pressing 'z' in tui mode, would enable this behavior. Decaying samples
> is non-intuitive as it isn't how "top" works. Make zeroing on refresh
> the default and rename the command line options from 'z' to 'Z' and
> 'zero' to 'decay'.
I've also felt `perf top` decay as non-intuitive. Esp. when system becomes
idle after some heavy workload, even decayed samples are far more compared
to samples from currently running processes and thus `perf top` keeps
showing already finished processes at the top, which is kind of confusing.
fwiw:

Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
