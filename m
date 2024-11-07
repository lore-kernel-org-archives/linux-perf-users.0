Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020119.outbound.protection.outlook.com [40.93.198.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB71F4273;
	Thu,  7 Nov 2024 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023822; cv=fail; b=uKFtWCN9sF/SAYrgdF03MGj2m/eBfDwti+o+DZR5zRezAzJpX80Uawzx7veXWjo6wHQpmcxBmdNfHbjVAkKv0YsiFQfKUKK0z0XmR+2Iw1NXOyE2xJt6sdh4zfvk3eJIrPOsuU0yM826z/XPTYbTzUw0Gy8LtOrwxlj9DAcf8YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023822; c=relaxed/simple;
	bh=r7pen4Ia4ydwmXwQBUoQiEXbVOw/bjgzoxeGSqqyKtc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=NgdCPy4VdVJBXNlp9XnVWSMea6n4AvhyfozVtC5Z+qrqF6/FLLRym/R2SevJKGcvGQn6OGpmsllXywAyG06VKn7xhbbjlWHucghyGOhUN3/XZGt+NsSao3BUON+t8zkpVTW61nFt6m7QOMNx6bPq7q7Wugi8Jo80z50ulDkVVEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=duwMV3xA; arc=fail smtp.client-ip=40.93.198.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="duwMV3xA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAUFGCvwz1TJlKeBRO+w9k7yyYwVKh+6La6BL7We4NlcBxtItUeESRSPjwcK+rhtYqsEoWMVCRoJSx01s9VhbYMWfrzB8n0CYhDKzJ6yLToQ9SharjWElSuOiZzJLH/woC00w8x5Uh8CsCciHE4NsfqOafVIDJUbmW2HqQBf48C0oV0K6GoaY+RV86qIbnPFeTDIPkmisJbVUhtJcVOqx8JkcUWRgEhMDhJkak0LOUFK6BeMAyeX28Pb+s32kId5JzqbsM9a5mEmu9UPgUm+F/BrjimU/zqjqFr/+q3DuQhibQIkcvJ1jeqGbO7pT+TDzskYfSatdTm/FzXH/J2RBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7qcSVM4UvCtKzfDy6UYFuX6nQKTa/HHU949RTZpUTs=;
 b=QWCWTyJ/MwYHlfYPBEesPSeEA8Ke5uyusPU/i4hyjOBBna+qZzRmeGaoXhozOYHllfYkpRc1Bf0siSwPwwLBOYtVulRRyIf3vzBXDVemIp8SaVLIvS+xeOwlDQFR8JwcpbiprfUiuEpP1jiZCx691nqzuypo6g5xunSnkhs+po01ubBrqA2RPJ6ynyqUlTDEzTD1szpwgWTPwiVzXBOuZf0v0CuhOv4CH74zSqmzyEDiZO5G1IwCb4/tRgfCSneyw3cuG189154CjUTPXzlb8anjbTdrPkYJWYDudUGtwLw3Fb0q0BhyaGf7TKrXaYI3sS3PVebFxnS3t+5/Kku/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7qcSVM4UvCtKzfDy6UYFuX6nQKTa/HHU949RTZpUTs=;
 b=duwMV3xAxs1aKrhqdDNCbDurQFjP9d8KJ1KfDuOvIZr3RNjDIYrALaVHQxPIhc8eo3qG5KXDxmmhJG9OQ6qW7YsX1G9PAxXStYqi51ShVnIkLkqoRNuo6t8LY9HDbRyuYx0OtlJmTAlT7rVE7ab+rl/DARPSHSz9TJJkzbSvPyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 DS1PR01MB8720.prod.exchangelabs.com (2603:10b6:8:216::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Thu, 7 Nov 2024 23:56:58 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 23:56:57 +0000
Date: Thu, 7 Nov 2024 15:56:51 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Leo Yan <leo.yan@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
    James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
    Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    Graham Woodward <graham.woodward@arm.com>, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] perf arm-spe: Add support for SPE Data Source
 packet on AmpereOne
In-Reply-To: <20241107154424.GD47850@e132581.arm.com>
Message-ID: <f84d3b6-ccea-bcc-b628-4966fa19f227@os.amperecomputing.com>
References: <20241106193740.6159-1-ilkka@os.amperecomputing.com> <20241106193740.6159-3-ilkka@os.amperecomputing.com> <20241107154424.GD47850@e132581.arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:610:b1::13) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|DS1PR01MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: a82177c8-b34f-4f1d-af1a-08dcff87dcb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ep+ho7/s15J4IrJYjWuauphmYmkIMPPtRjS8CmcNslQcEO95kr1MzZfy0ACI?=
 =?us-ascii?Q?p6fRi4SFqAjzK7PwgeV3mdOso4qcTtZZZvi/1cYzuA5XCYF7l1iPd3PNSyR4?=
 =?us-ascii?Q?ME3mVW3cDDJpCdkcvlDBrSJ6kImp7O4xFK8q9duhXhh0PnXh8wJLLITeL7Ws?=
 =?us-ascii?Q?/6gRy6c2tjsSPj5uBenQ5nXyfxRLrVSi1jPwqDi0EquzN2AhYUIvuNhyGhHk?=
 =?us-ascii?Q?qKU8iXnAp+m5v9B2SSMWyGyBQ692i3nX7nbGhA4m0GHmhP3Jgsf0ETqCxcWI?=
 =?us-ascii?Q?VpK0iXAse1Bc1lkrAAQt99/rPV9PS2GQYQlnaWI6m+9WJlXw9DNMynWAluC9?=
 =?us-ascii?Q?Q7rF1OBB1G85lYIEtM64Y7PiFHvhu2hyJkOE28y5u8X4MOKOm4sgGCdRizI0?=
 =?us-ascii?Q?r9PXSLjoGOGSBDrSXxiVeYLn9Cj8LXI+SB46YStmRRQ+s4heuuklIBR9PyPW?=
 =?us-ascii?Q?fnZDBRtn3/Qq63VY4AAwSdUN5hH8fRsgK1bTAHFw9mAq4u6Hfnz/m01iP7Co?=
 =?us-ascii?Q?McgeurRH5MIIb2LMVhQzKP6mMnue1INPZg4EdljRonNejz7fSMONMAc3XNbP?=
 =?us-ascii?Q?KA6QavFtf9yEnRS9jMN6SHv6J4vuBX/KjvtcyONxfGj7q1X7JdSK1+mR1ZDo?=
 =?us-ascii?Q?2NuoJ5qlj2gd4Cnf0x2bNxvr3VJ3tM1iiiQjyrWLtTbA4+9rr4QF1HWzYLME?=
 =?us-ascii?Q?N+bBPcqC6vhcHLL7XYpHG1S9NUIsO3P44Vc5IOy3fMraQHzhujJTkwoFaUZA?=
 =?us-ascii?Q?i/fpPjwBNrHdUdTadI2VIC+IUhLNVNSfwmvyP4j06yE8UHi/TzCYpgSorxiQ?=
 =?us-ascii?Q?mioRXNteeHEUthJwRwMXQOTmEswMP002sCmkMU3Ns/xIlBbmtNM/6N03ci7G?=
 =?us-ascii?Q?Al+niruWeCIQfdKOo8HhvLc6AE0lUlzMFAy1AfMxJaGEDr71wgc9kx0FRr0u?=
 =?us-ascii?Q?vuahTebDpDH7lvOlx9BqIn6Tkj+lX2qFoGxsb86YjG6pQqJFOcO7pMdvyACG?=
 =?us-ascii?Q?WRuRAnWKcVw0rt/pQ9cKEu5V3CKrd/0G9zhKu7qwEqpZAYSO9vVTkYnRe3L4?=
 =?us-ascii?Q?Nl/qnzlXu/bF82k1rA0LmWGm2VWpK8FkFTWrGWhI7Hjv869Ya+6y7wxOxyjS?=
 =?us-ascii?Q?5mvLyIppjt0ar26zQpX6jvQIPwDaXfxCYHAHei0HogIXneNjYtS352v7GMYA?=
 =?us-ascii?Q?UWNRSoonxG4qmrli1whvVy1JAD3mdpLFEbeDB+9nlKxXRcYrpJ5QNaVfrzxM?=
 =?us-ascii?Q?VhcXOS+2mxRp71iBl/33fm+Akh918LkftckwA/MgDEBwbBk0+e5jnolmte0w?=
 =?us-ascii?Q?Pn3CFsnX8lQCVz6jf6/uZY8X614dxpaA+TWX1nlI0acOdvmesRG2/4qi0brU?=
 =?us-ascii?Q?8z1S3qs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XiX3zce2BBf4oboHiaJeRzHDs8InyTTNBan82X3mDm3KjI90MjL97Dv7NM+4?=
 =?us-ascii?Q?q93smH840fUM9rd0bcjdMkUl27ejvJ0hySsB1D4wWA9n4fyT5l7wLyennwN9?=
 =?us-ascii?Q?Z1y51YpiTM3Hu3tUU8O6UuuMIc8MiThLQeM4mq/L1UCTgvYOdztcjTEEbXQY?=
 =?us-ascii?Q?KougmMRyFF61A65senx8hPVMazSyXixs5VpgLIgKM3FR0MkO2aBfaSBWyGqG?=
 =?us-ascii?Q?WXMRdgjb9yU6yYRIsIeezDQpr72Dtr/GEnEnz4ab/vY7SPM3HAcDv7FdpAs5?=
 =?us-ascii?Q?/kfoBWP3PoBtWMysjbr/QvGRtAshwmxvW2OND1BNMBM42QDp+DjjQmXDUo3Z?=
 =?us-ascii?Q?dnNoHP6ixJYQe1owrL1d5veXk6O+BBL2EbO0ceT0tsKlgRo4CrHQmthRl3XX?=
 =?us-ascii?Q?ihl7NV/TYyD3zeguOvo2TPZ1A6cZpC8r7FEzzEX0+wHp+Q88EYzedzZmL6QR?=
 =?us-ascii?Q?1vT5EF5UvFwnrplwGei5PbyPBz+JnzpO6UJAksMn/7WDyX6o3W1euug7CYHK?=
 =?us-ascii?Q?/wlbzOEhe3IAoFFkuYfskRgf/bJpPJ18+vhChSSAehkcqRq5np7oLedy4Ece?=
 =?us-ascii?Q?QLxrTJd/5bs5N7rOtDRW8jENyo/x4doXsVznWBhC9HyMA1zP3/6X1BQ9YBMO?=
 =?us-ascii?Q?e77/a/aPkXC5VJkdxOB7lQmRiOoLnXCMIZ+sUz9i2/+dFOPdLvPFrqFtwlOF?=
 =?us-ascii?Q?y6tvxNPmz7OWNhDln8xm1G8c/2gq8SGJardvwNT5uy0AJ6lwfSuFF9nLF0eI?=
 =?us-ascii?Q?KWJInv6ar3CDNcHJHvf5snJ1q+fecHonUBfVywZRanu0fPlcBkPrrA4ojy0o?=
 =?us-ascii?Q?Utc50fq0XZ8EWkouaRVJPqABx8S43DC3q6KxIxVNxxe9lWUuO2sTP+u2BhxB?=
 =?us-ascii?Q?stCvNDwSQq0OZgyvV1kkuUIzfkmNXdAP2je3UC6ab4sRC8AQL4W4l1J4m4OY?=
 =?us-ascii?Q?YYhlhe4+w2Mj0l9fGEGQaX2sArGL50v817r+e/8txuKW19IUcFmI3eJGP8/F?=
 =?us-ascii?Q?CD5UMNlXYMsvhCRdajyF5pOlhVSYqNKpuxPpCfmn77lmYaEb/pEbQhSzKd5E?=
 =?us-ascii?Q?D4gkoEAAhWI3ABtIzRjA1sAjkM1bBqsxfcGOLUIwbN8A0kRIZl5FV223EmEm?=
 =?us-ascii?Q?psyiZzHHMzu1ZJt/I6ET1/L2MNEdkjD0Mde91xUxYAW9JQz+CC23ZsLl+WJe?=
 =?us-ascii?Q?s4UysmbNmyKaUHDIjaQjtyd8suRFxKxQ71xDwWb7x7zQkT/8M1rRWGUHRrsq?=
 =?us-ascii?Q?Rn/pTbl4629i3nYu1X6yuzYmMT18l6xDqmlrymYxQ+rcWv22iGVHHW0qYJmv?=
 =?us-ascii?Q?eICwQeGDmxSra7ouExvfqHSt/JE1N0f9qGTgcPM1VQTtQGxOxPJidJnvNQiA?=
 =?us-ascii?Q?m8XDt/oehqx0h1EWV5ziGs2xKnVxi909eY401WlBl0E7f1Rwv0pRDDsP0k5f?=
 =?us-ascii?Q?kiM6h242oQQDLwbEXelCLAqKiOF38kLHhlvebV5p5oBc7lGSkdhTNxjQjcb9?=
 =?us-ascii?Q?eygqzJHrhI4L7FJl/26q1C0g+VlIgFn895ykna4zCndoKEcjsV58OoSmSQQV?=
 =?us-ascii?Q?A+EqZwAOGNtE4OHnq4gW7RD9WXRijvz49OVkPy9Hlo/CU7175Qnxcg0rBOpK?=
 =?us-ascii?Q?1nGxlD4OycS7nLdeFKrW4ec=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82177c8-b34f-4f1d-af1a-08dcff87dcb2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 23:56:56.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8WfSeB9dLM1NcmB38g3uUwuZKylpMDeOSwDDl4nYevaZFCXcnvu+7hzNSN/3HQKBkt3IFeWDqj8pTs1C29i/Ea8umIDUMWV1K5t2DWH3HEjTaAxG1Wg14MciAdkjzuF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8720


On Thu, 7 Nov 2024, Leo Yan wrote:
> On Wed, Nov 06, 2024 at 07:37:40PM +0000, Ilkka Koskinen wrote:
>> Warning: EXTERNAL SENDER, use caution when opening links or attachments.
>>
>>
>> Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 +++++
>>  tools/perf/util/arm-spe.c                     | 39 +++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>>
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> index 358c611eeddb..4bcd627e859f 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> @@ -67,6 +67,15 @@ enum arm_spe_common_data_source {
>>         ARM_SPE_COMMON_DS_DRAM          = 0xe,
>>  };
>>
>> +enum arm_spe_ampereone_data_source {
>> +       ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE    = 0x0,
>> +       ARM_SPE_AMPEREONE_SLC                           = 0x3,
>> +       ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE             = 0x5,
>> +       ARM_SPE_AMPEREONE_DDR                           = 0x7,
>> +       ARM_SPE_AMPEREONE_L1D                           = 0x8,
>> +       ARM_SPE_AMPEREONE_L2D                           = 0x9,
>> +};
>> +
>>  struct arm_spe_record {
>>         enum arm_spe_sample_type type;
>>         int err;
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index b222557cc27a..40847a3d18b0 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -531,6 +531,44 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
>>         }
>>  }
>>
>> +/*
>> + * Source is IMPDEF. Here we convert the source code used on AmpereOne cores
>> + * to the common (Neoverse, Cortex) to avoid duplicating the decoding code.
>> + */
>> +static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *record,
>> +                                                union perf_mem_data_src *data_src)
>> +{
>> +       struct arm_spe_record common_record;
>> +
>> +       switch (record->source) {
>> +       case ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE:
>> +               common_record.source = ARM_SPE_COMMON_DS_PEER_CORE;
>> +               break;
>> +       case ARM_SPE_AMPEREONE_SLC:
>> +               common_record.source = ARM_SPE_COMMON_DS_SYS_CACHE;
>> +               break;
>> +       case ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE:
>> +               common_record.source = ARM_SPE_COMMON_DS_REMOTE;
>> +               break;
>> +       case ARM_SPE_AMPEREONE_DDR:
>> +               common_record.source = ARM_SPE_COMMON_DS_DRAM;
>> +               break;
>> +       case ARM_SPE_AMPEREONE_L1D:
>> +               common_record.source = ARM_SPE_COMMON_DS_L1D;
>> +               break;
>> +       case ARM_SPE_AMPEREONE_L2D:
>> +               common_record.source = ARM_SPE_COMMON_DS_L2;
>> +               break;
>> +       default:
>> +               /* Assign a bogus value that's not used for common coding */
>> +               common_record.source = 0xffff;
>
> For unsupported source value, just bail out and no need to calling
> arm_spe__synth_data_source_common().
>
> It is good to use pr_warning_once() to print out warning log to remind
> users.

Hi Leo,

Makes sense, I'll do that.

--Ilkka

>
> Thanks,
> Leo
>
>> +               break;
>> +       }
>> +
>> +       common_record.op = record->op;
>> +       arm_spe__synth_data_source_common(&common_record, data_src);
>> +}
>> +
>>  static const struct data_src data_sources[] = {
>>         DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_A720), data_source_common),
>>         DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_A725), data_source_common),
>> @@ -541,6 +579,7 @@ static const struct data_src data_sources[] = {
>>         DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2), data_source_common),
>>         DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1), data_source_common),
>>         DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2), data_source_common),
>> +       DS(MIDR_ALL_VERSIONS(MIDR_AMPERE1A), data_source_ampereone),
>>         {},
>>  };
>>
>> --
>> 2.47.0
>>
>>
>
