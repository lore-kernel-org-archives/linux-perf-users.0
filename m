Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2098.outbound.protection.outlook.com [40.107.93.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C021CA00;
	Thu, 20 Mar 2025 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501421; cv=fail; b=B8/zBibWwe7wkvq1xSTRxCWnj5LWmn3cw1vT0ztTmYHuNHVbOt723QHJopsRtGlKxOUiJzXqZgfj23dePgLBR638/Uj/tUL+BCWL6JWsyJT7p3TJhgtfZzIugrYNjUTh1a9gm9ZBxGIY4NybdzfUGXTrzKGsRwW+rsYJaEo3u4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501421; c=relaxed/simple;
	bh=z1AlpR80411EqjXcuf9s1M1d5cbF3ukdpdwBM+ajUdU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=LIIYPUTJl9yW1sIvTBL/Y9ymexNX+ot4YcozkAvbAVux5A/T7zh0FT1/j7jDGsNfM5K3BfuN4ozdENc+Vqialu5OkafvihwmNnJBQjZols/eLsW8G0/ZoEU4Hsz30UqorzSs65D5rdV53jY1aQg85RNWLG0uzqHjij1WYBFIAdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ws0sw74k; arc=fail smtp.client-ip=40.107.93.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ws0sw74k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hETXRcnny9av2xMnoD47YxglQFjfmiRYHPyFXgmtiEcJuCgNM0eL0vVW36Wbld0JPMyyvW04/AkE5087MUbrPsRW+6K2TysqICFod1npthXc6zHRGUBcNSOijQXoZ8AhYS2ZHozKoGdgxP44xncQi6g6jZGnwi8LPZsiGGvLx6WdXdhPYgZL14UW1SoRRYmecF3nx1G10yNxnDF9mdrDIBwE5+c4qpriBkf62uG2JiD0505sw0Th0sXMzXDBDyjckTRiYIA/vFNVSVLvsnr7kuG9+t7wqxE+WFrAb6thcm/hN/qppExWqnxhFnu43B4SQq0fUGEAKFkj4Fqh4BN3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOKtfZePp8Y2S127TiF/SWn31UOfb+CCeRKZgPvKb5U=;
 b=dkWKMKNxo2Od795Ly9S1AziKqxyMSfeXlJ6df7w4nvEbuFwDTzxD4ZUPKXCcOPBRuWUW/qFDLEeq/fYW5yXXEM2bZ/ZDPTxhuFT+/GGQwyhZHKfeFUFVXqV+qGIfCXrS7rzcKr+3uyjJTJarEJUJXua22tPbW4Fr7s/EgyUhcf/dVMO/ggchNuVXU8xhOfQCqkbJY7bVNPGwqo31jrZ9Rzg9lKZrF1hCjyz2vY6OKO32TP3UeVwR0fKPpxYjmg7SNhe31eP2dQ1/T074sBez5+sX5yc7UONnosf0SU9C4bSB3cUw6z7dQ4g3CODT+ffUlhU1Y/lH4uUVGo6suGHcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOKtfZePp8Y2S127TiF/SWn31UOfb+CCeRKZgPvKb5U=;
 b=Ws0sw74kAN5YIHjSoriNGLwErivgd2ebwSHBI4f2FUAvekxCWgiSbUWz3OThk1Q5WZbKVrmLzhG4yZilxQuXH+k2dKZ7zEg2gJgPrYEzzzhtSbnu6uK81x1C2+iCf9aMrPiWucJ5fXakIw/fJNjsn1vtzK81eHTnvWb2zY8JDn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CY1PR01MB9340.prod.exchangelabs.com (2603:10b6:930:108::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Thu, 20 Mar 2025 20:10:16 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 20:10:15 +0000
Date: Thu, 20 Mar 2025 13:10:09 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: James Clark <james.clark@linaro.org>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Ian Rogers <irogers@google.com>, John Garry <john.g.garry@oracle.com>, 
    Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, 
    Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] perf vendor events arm64: AmpereOne/AmpereOneX: Mark
 LD_RETIRED impacted by errata
In-Reply-To: <9fe071f9-27bb-4694-ace5-f23eb0d0e50d@linaro.org>
Message-ID: <6a88e749-51e1-fe61-5122-f4c046dd3485@os.amperecomputing.com>
References: <20250313201559.11332-1-ilkka@os.amperecomputing.com> <20250313201559.11332-2-ilkka@os.amperecomputing.com> <9fe071f9-27bb-4694-ace5-f23eb0d0e50d@linaro.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH5PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::17) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CY1PR01MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: f86b7f84-19ec-4f8e-1106-08dd67eb3a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VmEeQLToA8Y6Lzb4QYAD0Ay3Oq1zHI7bbnak2WEw6E+kMHB0IaTSm4ARtkYW?=
 =?us-ascii?Q?IDFxtUfHD9zTIL1IWKcu6fNSQG4RkJIutEbM57KoIwStPOkmh3Q2Qow7z0I4?=
 =?us-ascii?Q?/mZyFzQfLRncbr6b0Pe9ktneIuzw+a1KTnnAQlPKaBg7hP6DHXehb1l69m0L?=
 =?us-ascii?Q?Pu2K9VBgY15TGjvwZ/ubNWp4OJnEgw+7y3mSO6V/qJT11mE0O2Iixp47hchW?=
 =?us-ascii?Q?QpoF1JcUm6r5Nb9W92BrFjcmPh8au/a718i6PzlPsuK4OF9FDD64xArK5Pzb?=
 =?us-ascii?Q?csAPWrjfuWVOJtOosJa7jqQLn8cF40LCpUWdSZgEiC/nSIUjY2bp1woIctnL?=
 =?us-ascii?Q?e0AkrdG9gVicZaGirVEl3YC2Dq0oYZeKjMBvEiLHcV24NPs9frOCYrln8vp+?=
 =?us-ascii?Q?8VVLB3O03ZCg0x8KpOD+/S3hUf+CSYPiL9FDh+2KsSvGYl68vFWDJqyvqhPj?=
 =?us-ascii?Q?pUOQkOkdMMQMJ0is5jarC25vBX4hNLJic6BalUwJ7PLdPKNG5pLX81iZPHsS?=
 =?us-ascii?Q?8oPDh2xTba122Qaamuf2VXNFHBtPkS6v6rs6xveyF74MPDgEvKpCPoqQn8oo?=
 =?us-ascii?Q?W+0+YNnpmnEnfgLsSb6B4kduD2J8sqwDjLhUMtAIlvCN8m7mEsDHjjJH0/Kq?=
 =?us-ascii?Q?FzifUKpBquS1PIqJo++lZjGvNwvVDy2w0zb++tBDzu+ORDoN5uMYP83X1Y2k?=
 =?us-ascii?Q?5ddUGksvWIcq5RgySU9o7LBUQI71EJHTSuc7g4Uxc64nYJUdjrx4cS86RSmc?=
 =?us-ascii?Q?Ub3nfa+MRSMSzklaCDO/kc5G7zFW3Hceoad+O9b49MdPFj4128Gw/5eTtsFd?=
 =?us-ascii?Q?ffuVA7abvUMOqyguvpjgnDNaU95M7zkuDqaCHpl/PvmO79yMmA/oQcIovsbz?=
 =?us-ascii?Q?ybhIbu8aU8k4/cxxiD3ZXPkgxRwgjmbbfit5yp3gTWp+PjL9IGdGk99rHHBT?=
 =?us-ascii?Q?NX29hFULj8hqgyUwQEKmh5cHS0QHc+AphGd7zNECEGZWD3aRPMKlWtpzl2MF?=
 =?us-ascii?Q?GxGbKX8GNUtovX4Yruc2EhjOAeZdmoXJ9OxSLLSDtBxZZKbnjBVaygMJTTqM?=
 =?us-ascii?Q?CCawrbHb+OoEwpgIjbJiGAbK/HHlJ6NDW3FV8M3se1ddlGjF4Fzd0/Pvtfdm?=
 =?us-ascii?Q?guIKG7uQ+YEcjM1DPjEuFgJ+RsjO6iL7jEPixWjn9DedD4Opb0mEEcJQ1D4R?=
 =?us-ascii?Q?VjDfYVR95F8Znn7nMFWkKrTQmL6GTgznuL/e4hMaq2vvKZ1J17sQ+a/tXDOi?=
 =?us-ascii?Q?VhWQS1Fbu0sMJ1dSe1o17ksNMTHWCIXpmhvpPLxrEpXl7OspQE0q/lR82YKf?=
 =?us-ascii?Q?/XZ+4nz0JPCZWb+1yGi8TxlcgZeTdJKp/QUA38552q0j9Es2Pzkff+LKPNGq?=
 =?us-ascii?Q?1cbeXcAr8Mjcqs7qnTxGmo5Bgcup0pFOf2jLLZOdvAyCS/qwQaWMhG0Dh3SQ?=
 =?us-ascii?Q?QnwvVLkpyiypajpVVWvmNeEfp+xcaHCG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qm8wrf38WumiDwKooQ9mncxnb9trwiezs3gC1f9SuqKCk/eNaVRo5qGochNS?=
 =?us-ascii?Q?VVImQz7AAJIjCns0ztMcaZDccjwFlLGo9vtvtcu8IVWJKWKJ5Dw9u/TvSSD+?=
 =?us-ascii?Q?jnitTVcQKp5ReCUYq2n/scyRV+/CaMmH6fNs7lj5FcIEjX/pOVY0fEb355mz?=
 =?us-ascii?Q?TcjVmt5HMwu3FLnP4Gi238M3gbqUmZUqPerdLpLYSXOwl1U30pAgRV8TYE4b?=
 =?us-ascii?Q?DkXhPAxeNXHmWiikmSrB0belgG5mWvkNxCJmy8JtFqCbiyu1xaqmdawdFaAq?=
 =?us-ascii?Q?i4bX7aFNB1cx2xLbFiaoLFjMMZQxp0Y8MwULQsXOGnAgEuXzG5qZyCFXdPXq?=
 =?us-ascii?Q?ZjDuZOR8yJ74791CgZJc5wac6TMonYMu73C58MphQfGm3OrK2ClZDUBfA3Eh?=
 =?us-ascii?Q?5wc15urE/PuNfAx5GtR+WVUjEYxc9+3vX2C2pTflPRnBIR9DktQ/uP8TQ/gt?=
 =?us-ascii?Q?ja0AV3uj1hlWFE92J6qjPgN+KuPM6QVSRdWEDLrW2YmaJoMibrAm4YTe0dad?=
 =?us-ascii?Q?cPBRCC6ppvlGShskPNaL+4lOcBVOt68/ciBQ7Wp8ef0R/Ey8fCxajZGyCAbU?=
 =?us-ascii?Q?y/yYQeAHvj7yevMgwofBaUK+/kzuM5R0CPJ3I+5ksKxFrBgZaYJL1IIjB4sD?=
 =?us-ascii?Q?qkqFRP22p21uT+UTHQUiGRTm3r3ZUPVJ/xIf019ZxAqtG+FXquGKD3CMU/mi?=
 =?us-ascii?Q?uIWuHFwavt0oxWbz1RbCnR1cN73XSnpAjlFwXNXrJ6b6U4QZriVX7ETXLNyP?=
 =?us-ascii?Q?592hbTNCeN+LN/q07shXUe2UGVNHTffc0yMcy+UvBWtBh6sfAkbnH5M07m1E?=
 =?us-ascii?Q?G/lwaMbrBy2e90nqRrzqY3wVy1/3fSlDBvQsQhY6a4MYUIEBCCH/u+e3bwzF?=
 =?us-ascii?Q?oWZR9TQFpWbAhkx9hqI2q/CVwH4WU/rXMurZwv72n4J5TGF6V6VcgeQakxti?=
 =?us-ascii?Q?L59YDLcToZRM5gILF3S53DCPFwwKmmayuXb/UFlUdviHi3RXnP+YbDePctos?=
 =?us-ascii?Q?QQsyrnZZDn6EECleg2zaqZCmKms5+j116DjC1PANKXtRDK7dw8sYDD00/hde?=
 =?us-ascii?Q?0POTirKiCYhfgBCDj44aP5RpgcSROozWhThMXYbDuYYZqf6/HM2t83sokWuP?=
 =?us-ascii?Q?RHZs2kIcrEklm+oWLdmsJcBFc2VipDJ9CBKk0/Z1SYuVNDKBOVpyC0Sxz9Ed?=
 =?us-ascii?Q?USLpHacy8JsGmG3Oq/RAHSQ9YzkRsJLr/mrSCbZehPnQp75YW2oMTJfwY9aZ?=
 =?us-ascii?Q?dRi8rRW3D5ZXJf5McusdDVBdDfnypkvRlz0dYW5Viv5RB8QxDrZK1SbxdxvK?=
 =?us-ascii?Q?v2xL1BTSG96aOeWtbGj54bB49733IPQ9h+f9u59ZvpF8fXDbe5zmd1vkxsUd?=
 =?us-ascii?Q?zr3MPuXP2QWNLTnQ5kjwOSSUGTJ2WjFK6WP+rnBAn/BmA1xtG4R6rM4u2plL?=
 =?us-ascii?Q?ppUKVQdsryVt+gqE4wL4owz854xgarhESwKIpqguG/1qkRI5huBxLFzMRwBs?=
 =?us-ascii?Q?GGpl4XhZd97Qs9xOXjcXxNq9m9pAd3he04mq2AupXzLFToTLnK0L4qbAiBZW?=
 =?us-ascii?Q?SpbMIcKOGIc/YLPehlIdThbkc9tqjZBMlBOcMPd/48MQZSDqqa26pjlOVZxW?=
 =?us-ascii?Q?rb1if+gN9oKDm47kjwa9gI8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86b7f84-19ec-4f8e-1106-08dd67eb3a9d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 20:10:15.7086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOa9dofjw7kaIVjGZrKU0l0dUZQHpUMvj37kPxftC3aIchgW5SY/HNvfYT2XKkUnXqq06rvpYpQCSdpLt6Pa53dCp06YEcJpZz1k9OupmkifZrKLOxGoDxZ7jmS5sm2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB9340


Hi James,

On Tue, 18 Mar 2025, James Clark wrote:
> On 13/03/2025 8:15 pm, Ilkka Koskinen wrote:
>> Atomic instructions are both memory-reading and memory-writing
>> instructions and so should be counted by both LD_RETIRED and ST_RETIRED
>> performance monitoring events. However LD_RETIRED does not count atomic
>> instructions.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json | 4 +++-
>>   .../perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json  | 4 +++-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json 
>> b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
>> index 0711782bfa6b..13382d29b25f 100644
>> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
>> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
>> @@ -1,6 +1,8 @@
>>   [
>>       {
>> -        "ArchStdEvent": "LD_RETIRED"
>> +        "ArchStdEvent": "LD_RETIRED",
>> +        "Errata": "Errata AC03_CPU_52",
>> +        "BriefDescription": "Instruction architecturally executed, 
>> condition code check pass, load. Impacted by errata -"
>
> I think this could also have a 'Fixes:' tag, either way:
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Yeah, that's true. I guess, I was thinking about using 'Fixes' more on 
broken patches rather than when adding a patch dealing with a new hw 
errata. Well, given you're find with this, I don't think I'll resubmit it
with a Fixes tag this time.

Cheers, Ilkka
