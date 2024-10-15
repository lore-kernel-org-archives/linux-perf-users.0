Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5833EA;
	Tue, 15 Oct 2024 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728966124; cv=fail; b=Ynd2SIsVJy0KSZIO8qUFmMSFvKcKE1B3uml9mCMNd2NfVR5CMdCwQcCJwJYMEaEqp46xZLLAwnpg4gwQLptOun55vyFi+iNuiOQ1+3hBPW6oe5cr4B5a+BoetWCN7vc0vymYK05zNVqeC7sNGrfsl143mv7T+pfaUy1xb27YXGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728966124; c=relaxed/simple;
	bh=NixYgw2n86KlqulqGl/m5vkrANAhQiJS1zKMOtO56dQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gPRdnsXoryHCcZZOrb9LGhWWrX8Y3jpjnouKnhlvl1zGzH+Qj8XPC6OgvBNL+2Z6D+IRJRVv0dsb59LWUFDTzTIB9hk99q5equvOjSAZbF4AQM+xSuW/q/fx7cSOW/CbeYGoV9mUZHenKIQLXEkLz0sYXNJ1Pt/ep282/Sk/8kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zzCDzXO9; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zzCDzXO9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4ra3niTNR1yiQ+1IqwGji+NEdQk3xX5lCqkmDq1XEcnMC9I9TI8FC6CxHlrirdHqWL2T89ouD4Hn1PNrPumozINcLNKl03HzYFil0GqSQrGjUOA2Vx48h3szb6lzEtAOdrmyhudIUH4YI62NLYMr148ugAE2/jpTq4W2jRcfRyZNo8Wssru7fgHrHm4Y9PjUKxZaXVm/gddmkhmh6sbmx/NOZCOH/ad8PMWjyyd0vvhgTcmNk4SLt367G5LrLEcQVbBHWHV8Tv7qe/psLHDf0T2wDsMAYqxcoLWa1qvJDCjYpnxK1BpxjbmN6hLM3yiTCLWjPVu0afES+DpAgZ0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB4y+fPR965H5Bj96eM//KVLYRXJewGxoQ6utQ0AlHs=;
 b=RQZrIR5OUAh1jmf6zmzudfBFai9lvkv2SdnNkGDoFMhw+4n1CC0rVmeD+oJEZWPlmwy5PTXCUmf+HjGq7DJzEERJn/XP6RoLnZ6l4LkW0rx1V38o7xINAF0LLwRMvxQiL1UtyvTEKrTxWHfUQe9lLFDC4GAAChASe+dYTkkpNcIych3G28mVqi0p88XrT07IYS5R9WHY4X9Gr6oHo2bHeQF8HjKz6HptJubmIS13A/F0Wz+iMbhBbIGQI9RF6sE+GBOoxQtHkmkfGpbFIJHPwLLG5kzZEtL7oos04rtIaRHKQDPz6jc9/f7sk6EuXKnz+gvekJIuaAWa/ieQ7UvY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB4y+fPR965H5Bj96eM//KVLYRXJewGxoQ6utQ0AlHs=;
 b=zzCDzXO9BNpIlY7Q027Eerw0xs95kFUziZ4xAOuh5UgCLn7H7tjb85Dy2RJ7fnS4O+rSNsE3JQ7eMHpIj/i/2K6XnqYCi8phQlkec0Ko7KOuFCDBMEzYDtNnAZlqLI7BS0Dodm9TGrLEnEEQffmwZgMZGxRolIJuaJJaF4a/FoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 04:22:00 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 04:22:00 +0000
Message-ID: <bbffa9eb-0102-4c35-8b1a-4e26634aa878@amd.com>
Date: Tue, 15 Oct 2024 09:51:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] perf tools: Check fallback error and order
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@arm.com>,
 Kajol Jain <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 Mingwei Zhang <mizhang@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-8-namhyung@kernel.org>
 <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com>
 <ZvxrQsHML0A1kF1P@google.com>
 <CAP-5=fUAqmvA+pzE15Lmk4Aakj6tOzrqYFhYb43UX9B3E3Odmg@mail.gmail.com>
 <Zv7O_XJZcSIS9I_i@google.com>
 <CAP-5=fUVLEo0f5ygccnf11J2zdZbFmoGF5UatAb+E8T9vwbeAg@mail.gmail.com>
 <Zv8cyZN1p7EI08XA@google.com> <Zw1vcnX-HdnmJMU1@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Zw1vcnX-HdnmJMU1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f66b289-46f7-4643-c631-08dcecd0e9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0ZoVmdRblFDdDc1ekFJdHZYNEp2eUc2ZVZKSng0cjRDL1lhdWRoK1pITlVj?=
 =?utf-8?B?OTJHdUxlMVJMeTU1S3hES2NjUnNTRUFMVTNNM0pLOXhtejU3a1BNcExJb2Z0?=
 =?utf-8?B?dnBHOVZhUUorSjFKRFVWSndEb1FLVnQ1K3I0eDh5NkwrdWIyUXB6a2QxdWw1?=
 =?utf-8?B?WjlTUHdFUWw1UGdWdERqTnN4OHd0VDMxL04vV0pUV3M1WnFwc2I5Wnk4K1h4?=
 =?utf-8?B?aXRFaWNUU0U5bEhZZVF1UFFrcit3UFBxaktpWCsvWWRyNmk4QXF4Q0c4QWVx?=
 =?utf-8?B?bGtCaFZiL1VVZjFJZTBDanFlM0M4NnBCcTRXNnZGc0dnRjhKUmRVcllMdjhw?=
 =?utf-8?B?U21qZGJKU1p6bW1ZdHgvNVpBQmVqa0xqbm5YWGljMjBnam9abkNXMXErSjgw?=
 =?utf-8?B?UGpBRzVYTk50aXprS25IOE5jU3I2ZVBhSE5RMlZSOGUrME5tby9YNEdBNTlG?=
 =?utf-8?B?SSt2WmNCWXgrUHMvcFc2bHlMZjJCY0VtKzVralhPZVNZTWF6WE5tZHNVZnFW?=
 =?utf-8?B?NkZ0R0dIVzJGa0Nmb2U4VU00NmtSOFV3emNzOHFMRmllb0lQMnBZZHI5OFVq?=
 =?utf-8?B?RmNmV2FndjdqZXpuQW9vb0l6Z1U4NG8raGpIZEltNURudldxSGt4Zk44M0VF?=
 =?utf-8?B?NXk0WS9aaUQwZnBHdDNodStUTnk1RXpoVDlJdjJWeGhVSVhxbUIzSE9xUDRw?=
 =?utf-8?B?KzAxOE1qNFdoellRMHFvM0xyRXVJY0didTBta0t0dTBvL1RZSEVXeXZIdUF3?=
 =?utf-8?B?M1d5a0c4QkFIU0xEYTVpVGNaOTV1L2dnQm5BVUJweHRKQzNNV28wKzF0VVll?=
 =?utf-8?B?Ti85bytSK2R3SFZCTkd4SEtLd3hnZVhyVzZEdUJQdElucnQxL2lNUERHNHI1?=
 =?utf-8?B?Q2UrU2VSSDhrdkVZMFdoMS9YSHdlY1EvelNPbEhCMXVMZU1PL2g3VWhETmV3?=
 =?utf-8?B?T2NoTHp6NDlldEEwbG1KbkJOeXhraEZzSDUxQjNBakFFYXhiS1hFTExKWGFW?=
 =?utf-8?B?U3o0b2oyWm1tbU5Sdzh2b3lPWExBcnhxc2NUMVFza1pkNUMybVd4bGtkWE54?=
 =?utf-8?B?WFhnNnh0M0pyWnNTVFJtWndiYmw0QTNzcmdiNWY3RGhXS2RlWTVPN2dXVzE4?=
 =?utf-8?B?SjNLMlltMkdSMllNeGE4MkpveFhtSDhyZkZUSnJiYmJZN2xGNFY2VWQ3V2NY?=
 =?utf-8?B?SXVjeExQbmlPTkVIdzVzTy9DMkRXaUV0ZHNWTnJyTHVNc1pzM29MYWZEd2tO?=
 =?utf-8?B?VytqdW5Bc1hDODliOTl5QjgvTkhRRnJKYkRjbldGV0xYNUI0SGVHTnNFZHlt?=
 =?utf-8?B?d093SUp0dEFPRndsbkVFcTg5dlczNEtNTzNiK1V3dWt4VDFGVEJJV0lmWkZY?=
 =?utf-8?B?RUJVcmNNZSsrUk1sRXVQM2k1Y3ozeElneTRsT1lJd3NqZFdkZFNBblB6cTJ6?=
 =?utf-8?B?Q1A4OUUvSytjLys2cWZna0g1NjJDbXVKdGFXTi9URWlJc0ZBUmZwQlpFTGRX?=
 =?utf-8?B?akZOajN2cjVzZ3k5S2cxcjZzZ25PVDZpQXE4SXpjcUNiTmZDYml6enlTdXZo?=
 =?utf-8?B?R21xb1ozaDFyR1pMeVlCcmpZckc4T2NXUFplRVVRem55cVRuVnhDRCtleUtH?=
 =?utf-8?B?T0xRTFFPQkt0MVJzU216a2U3VFpWT21iMXFzQjF5THQzWjgxU3VYMjNhSFRJ?=
 =?utf-8?B?YTFtSHZkV2lnZmlLd2pDQkpRYmdwc3lTcDlJUFRPOTlLd1ptbnVaT3pnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjFzNkxGdnR6aGhSTUZsbnhBeFJGMHVLeEtrYU9hb1FkTHFNOEFsWkJ3K0Mw?=
 =?utf-8?B?S1FJQmVhU0lLZnZuU2hBcU5TTkV1NGx2aUxIRTdCV05UbFJ5SWJDZ29QOVNn?=
 =?utf-8?B?VzhzQmJBVWRxcTRoNEZXdmU2SCtGUnhIYlpnVExHOG10TWJUaUYyVVJEcXRB?=
 =?utf-8?B?YlovcVpsWE0vQW1yZGl2NTVuaTRCR0kzVDBLWGlBemljNFBpSm95YXA5T2hP?=
 =?utf-8?B?bkFnM1h0MjdkRXEvejNneXd3SXdGaWlPMkE2VmxRQnRjL245MjUwMXplNWZk?=
 =?utf-8?B?YzRDV1Z1Y3JZOG0rQ0oybUxFbUhwcTVRYkRya01OTXJUckFaODVxbXltWkRI?=
 =?utf-8?B?TEVoTTlNbzJBRVMwcjhITUwwRzF3VVRHZnJjbVZENzRDbysrOXdsQmdTcHBI?=
 =?utf-8?B?ZUVpMFpsb296OVZJYmc5VFlXNWg1bGZhVHF3ZHhJcXZmMG5OMHJ1M29wQ0VL?=
 =?utf-8?B?RnNEYlZld0tleWIwUmV0MlFrL0hCWHpVKzRZazM4M05BNktuakF0dGxSL2V4?=
 =?utf-8?B?NlhpWUx1ZkhmOVU3dU80TGM0RENrVEJCZFBhUnhLMkJOWlN3TjAyQ0V6K3VG?=
 =?utf-8?B?eUdFWGFockVSRlh4aVZQeFZyUkpESzd1VHJpc2dNWWUrd3ptYzE0UkNZcUZJ?=
 =?utf-8?B?cEUxR3BhV3ZhSDZ5c1pyU053WTBYZDYxRU5hZlFra2dFWmphTy9pSUhzK085?=
 =?utf-8?B?WkxKdStPeERZZlJaUGdNaTlpTlROc0tEVXQ5OHJsTmovS3dDWmNoY1VpT01G?=
 =?utf-8?B?WHVnT0dSM2RwaVhGa3A0akJlMjFnM3gyQ2dVaHc2K1o3N3BDUjl0cW9WbW1n?=
 =?utf-8?B?RTRXTEVyQWNCbFJMVlZNVldUOTJnK1dVaG5sSFJQcTNOa1RIbTVMNkRoS3hI?=
 =?utf-8?B?cHZkYmh4RVU4c2ZOaGk5K2lwa0J3Rm5UWDZNUnlIOHBFN1VYUEZyTGRIQkFp?=
 =?utf-8?B?dzkwdDZoYXI2dm83UEszSkFXVVIvdDlXaE01L1BQQUg0MHZxdE9lb1U0SlpI?=
 =?utf-8?B?UjZJTmxsN3RlNWRjYjA2UThoM0s2SGhKVVRrZTMwR1hGSVdIdXJyWmR6UGky?=
 =?utf-8?B?YjdwSDRVR0FXY3p2OFBqeEhIa3h6ZElDM0NlcVZSWXRDdmxjVWhFQjVZVjlU?=
 =?utf-8?B?QXAxcmRaM2VVY1ZvREQwK0NjVnczRmw2SFZPVWpnc0tUai9iNDhTSGgxQVVL?=
 =?utf-8?B?L0VYSGFvcFc1dXRsS1ZiUk90NHI1VUFUZGdERmtMWFBUaXhwelFBZGxKRkc0?=
 =?utf-8?B?SkRjemFxcFZZRUNxVjgvT0lYWXNJTVBYcG9aS0c4c1l4V2xVS1hzUnlja0hP?=
 =?utf-8?B?QjBpYjRIUXdwekJBaGFMb21xNy9kQlgvWDRZNDYvZ1VoWE81TFRwL3g4U0lB?=
 =?utf-8?B?RXFRVXQramhLN2Uxcnk0cGgxYWx6a3d2SHVSemZYck5kVUcwM0JNbWJtWGl5?=
 =?utf-8?B?dm1JM3V2KzhuRkJiVnhSSHM5b1dCM1JHN1MrSEJ1a1JxWE9UY2NhVUFmZjN4?=
 =?utf-8?B?TkE4OTdaZStuSFl6N3BVS2huUHNpYzJ6dHNyNzJ6MElLMVBTUXdZazU3OUJM?=
 =?utf-8?B?bDM4SkwwbzdHYy8zRU8wbTlkcVg1OXBnM2NPaEVuZ1BzdHNpZ01RTVAyd2ll?=
 =?utf-8?B?QWlnNDNoSE81Y2M4R09ZVUhhRWIwTmRRTm4xYm5mbUVGaHVxOElMemZkd1dl?=
 =?utf-8?B?V3QzSWJnT3JNRDYrS1U2NmE2ZnFHMytPVE5wS2JGN1ZjUFNzby8xYm5qS0hk?=
 =?utf-8?B?NlYza3RCNEVib1M3M1Q5Y3g4TFVzcXlEWkNXZ3Z5TDlkNUxraHhwMDVLR1Uy?=
 =?utf-8?B?eU1ibHExK09tN044WGJWZ0E2UXduRThtSVJEMk8wMXRKckNPV3NSR0tpNUlW?=
 =?utf-8?B?QzdOWUxSN1Nyem9Nd084bHRtTXczMHdQRko3djV2a1FGcmp0VHdhRi9IZFhR?=
 =?utf-8?B?WVNHSFZTWC9tY2paKzdqcU1WTGJoSk9mQ3dBcHlTQnY4KzFlQ2pLalJyOFNM?=
 =?utf-8?B?S1AxU2krK2lnamVGRWFKYThhalk3clBSNTBIbHUyK21xelBtMFBjQm4xdWd5?=
 =?utf-8?B?TUlqNDFSTGtoTXUreXhEa1JnOWd1M0xkYWxMclNTc0hpQnhzQUc4djVIczc2?=
 =?utf-8?Q?pCkOo6HlLraJXFBV+M2NRc5oG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f66b289-46f7-4643-c631-08dcecd0e9f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 04:22:00.5667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s37ar4r5Wxr9MC4gILqglqHnveZ+q3Z2CeAR1eYqO6Kq2oY873Rm2Nt898mhSO8uspC2onewgRNvi6FEV/n6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979

> @@ -2366,9 +2403,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	return 0;
>  
>  try_fallback:
> -	if (evsel__precise_ip_fallback(evsel))
> -		goto retry_open;
> -
>  	if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
>  					 idx, threads, thread, err)) {
>  		/* We just removed 1 thread, so lower the upper nthreads limit. */
> @@ -2385,11 +2419,15 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
>  		goto retry_open;
>  
> -	if (err != -EINVAL || idx > 0 || thread > 0)
> -		goto out_close;
> +	if (err == -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
> +		goto retry_open;

This will change the behavior of events like instructions:P on AMD.

Without patch:
  $ ./perf record -e instructions:P -- true
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.009 MB perf.data (9 samples) ]

With the patch:

  $ ./perf record -e instructions:P -- true
  Error:
  The instructions:Pu event is not supported.

Thanks,
Ravi
