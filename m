Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2137.outbound.protection.outlook.com [40.107.92.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D5193071;
	Tue, 29 Oct 2024 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730168912; cv=fail; b=rA6SCLjb2+kPDhZVx/Bv7fSU0ajGH50TROpp/LXz0UANj47Kz9zTxEBc73dxEOonOx5OvXr2K9gklUURtBivojZJ4uO/rTGe1q8L+/OOMznjBJrREVRZWvnWfLBTJ0Z/QjGyfxcT4EExkhweLKvXIT5oq8rj2TeyZV26yANoBKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730168912; c=relaxed/simple;
	bh=fWI8iCnaCWPuizeq81KKeFbl5zx/uOZBuvwBxBUrIGw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=NetE7OqlWptfE6+Le+pNXtFa/bFtlt2aPmkOX4zQXVpBAn/PNV28TmB/53xmP32CodiwodxeADdvseZZ1ttYmT0x66bUBZzltghsa+Rm/z676hlrWmu1h1bTm5V2VXw2NZsknMxX+O4dstpFHhUBjEvdI39gf7LYp+1rKg/ZXd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LU6ilx61; arc=fail smtp.client-ip=40.107.92.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LU6ilx61"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okT5zM91ETUdO4NZQ181tSGzgwpZFitOk1NW4Dfja6gAgWocXm2Yifyovg2+U35OVbnAgqFmu9gx8h3lhrMKMv1WuvLQP9E17pIRpupP+5bbMiOk2N2lMVBxdLAc8ElLtIt/lCu6tnPFjXXHXHso2BgxPwRrkWLauhTG0GkaHJHecSppOEt6LW0eAjMyAu0C4Cw8VhM1O7MszeNPPW/Ke6FdxkTk/O6FBdh46TsndxzG3sa+NcU6JqSv/DEYDyqsJOj/z4yBshfEeq3eXmrfWO3HnjxjzQkZee3xOB/H/BrXbM27PguetPNcmGET7X7Qcumez6SCBMM0JYfYodR/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt53l+pja8ONBaITY56BmrjpC2bEhHrO+ohjtBHj8cQ=;
 b=RsZ0LSMe5mNbudLT/YLX5QR8AHSFOUSxbYPeatv/i4lllBSNk9Sz5B/3DKxiF50X7B6XkuzyWg4yRfHy/3WJy2hCKy2IesC64GxrlMPj2o6qB800XlKkscirXs1EeDh4oK1znO2wtGcIxYJJ7mV1w94hwXVeQuZqeoCZSVXvygaBPRz9tgAbXj+oomVVGhNYWKfMjIxZ1uyycRTb+ZY6VkC5UaHbiZvaRweY3q0BvA1MWK9f8+xjT4n/j1rGhqJMS614U6Jv7diN5ZgHIsJ+CHVN97QkRIg/FYCjO4eY70MOXjTwaPltJxtWkE6DsHHEXyhWa8kNUT4s4AJ2pf0Dkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt53l+pja8ONBaITY56BmrjpC2bEhHrO+ohjtBHj8cQ=;
 b=LU6ilx61+vu+Hng6YzWO7FUwFulN4r6R41TPUEKBmjGwWjP9vLqSAgcEXM92QOv9bxkT8oFS2VJwXKyVruQkpPXUUXLX3tzCOfmSU6aUpzeVZEXX+5gHNl0xWuwJghIizep1K8HX6DGr/VNB03Z2IA6hFCYgZjpIM1qiCRc/Trs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 LV3PR01MB8676.prod.exchangelabs.com (2603:10b6:408:1b4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.15; Tue, 29 Oct 2024 02:28:25 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 02:28:25 +0000
Date: Mon, 28 Oct 2024 19:28:19 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Leo Yan <leo.yan@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
    James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
    Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf arm-spe: Add support for SPE Data Source packet on
 AmpereOne
In-Reply-To: <20241025144303.GC359792@e132581.arm.com>
Message-ID: <5929238-399a-b4d-3b8a-2f5b8b7a473@os.amperecomputing.com>
References: <20241024233035.7979-1-ilkka@os.amperecomputing.com> <20241025144303.GC359792@e132581.arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CYZPR14CA0034.namprd14.prod.outlook.com
 (2603:10b6:930:a0::19) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|LV3PR01MB8676:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0423ad-4b35-4def-cf49-08dcf7c15da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNQSNk3YydIw9GqPdCcwzW7TvpOcSl3LnE3yiqIAn8RXNVae0GXLJVaS5omX?=
 =?us-ascii?Q?HgpTkB1VW7U1kJDqLvJmROpk5UCFevx8PpH1F9sFIhSpD4lJPZwbb9yeahOJ?=
 =?us-ascii?Q?9NlG6jdwC1BnRT2JLfme35D7d/nxvfxfBzPJcCpKHju8kbLAXZy9OaaJSmvT?=
 =?us-ascii?Q?cxxj7l2/18XqVtHcZ1yUShcPLcj4niT6UUfW7EhnVf/mnKW8/wU8x+blmvaS?=
 =?us-ascii?Q?ieqiXEyyBUVNU5cv3ewBkZnwXYTKYsXcmSs5IZDZEA1vOUgUKxZkJFEJtcKT?=
 =?us-ascii?Q?l6lkYkuVxDM+GXnTsGQyGQyF9Yom946GAKsytipwEMrU49TmEd1ECdVa0bBX?=
 =?us-ascii?Q?RJrxHyq9kypwUjjQ9Ky87TFmEZRXxJ22N8QCjji52kbJ7U48sj3bmidtIM+T?=
 =?us-ascii?Q?BnIS/pOduKYL9+JTOy6Av7iPK5KS7l6JFmlXA5dWUmCvw23aAwwCBmwUN4FZ?=
 =?us-ascii?Q?gzmeHDj8VAk7zGzEymjzf99aMKIiTvax0j5xsnPPyflPZE4ItPTO+GVaGChn?=
 =?us-ascii?Q?tBNH6NLRtavU+vXthXaAtkLYCtm67RBAKXmzmMraJatMJY/uczgUSFj9VddO?=
 =?us-ascii?Q?B7aUt20otqjgcNnEs6Tu3xZgdfJ7GUGA1Z+DgRP2jc6Yxbqf9Fmqo7BLHe15?=
 =?us-ascii?Q?Vx7KPUS5oYPWSXYYryuHN1ZaBNiaTFOywG/ImD9150hh4hf1spWXKpgg3wBq?=
 =?us-ascii?Q?QJ+OhO7UP507ZwgkoOklNhM6ILHMz7wX1tgwCSEOmIE+y1lBdjCmhCvhAyQm?=
 =?us-ascii?Q?cQ5aU8Wowp5m/42dNUuMdfFyNxisUK1bKl5WFVsh9ER9/6t24PrYy42a5rLL?=
 =?us-ascii?Q?FlR1K9WqhzjKqqKUw0eThsz0G06yQXyCKz4l7TNklk3SvcDhNWscz+afrMaU?=
 =?us-ascii?Q?NaZJkOQ8Co8QwgZiZ4i8pGWVLNG7qHCCzNY0735McKvWkQ43Y32CaT1Egaru?=
 =?us-ascii?Q?TsluCig7W73wDfz8B/APaqjRGS3Pv+w7JYUwS2UogR8SaM5RqNvUS9jy+DI7?=
 =?us-ascii?Q?WI9zJT9En+YAfF6alpyEC+I37vxcViTUplD3D+f9eey4f+xjF3QPqo88e0EM?=
 =?us-ascii?Q?dEhJKR91DrJKcZxMzJH3xJ2nZG+KI9MSrs1QL/8RML/GI+nixfuSvt/LqG4J?=
 =?us-ascii?Q?Uc5SbGwoSrjxYyR4ySHuxB1XO9vEP4HhZ0sfRZLSkG9zDUPR4Ai5gsR8haTz?=
 =?us-ascii?Q?FeEiObUr04Uw1/UggPhm7aGkDaZLVZWrQ6bTq3R9EaFJUoUdpp8Q6U0JRsQJ?=
 =?us-ascii?Q?4YdgNFob+Uuu/nCnrQ22RW3xAW343XOWr+E1e2M/Ldr6ktKj60zj/BmoIKBC?=
 =?us-ascii?Q?aBdfoKdqD5A40Kfjr6kLxouj+Vzr34mZpZf9pwk2asvHW01eJodVJANb76M6?=
 =?us-ascii?Q?nOgmusLwmFZ+wbDpmu2c4ByGSTU9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sCT+NBBoSdZo7JKLbBjMW22+7J7bUAqxnJpLBRZPf+P32y4Z0n8mrtsGLMQe?=
 =?us-ascii?Q?B83GzOzOFkvgW26mz0VTmfl0X2BAr8YDCCZEuUnwpdo4hBSwonA0WnbCNbX8?=
 =?us-ascii?Q?6vyvTpL4FmUgRqemDqyqmdqYZxLDrp1A7TgowiGi5xizvQ9VXWE0OlLxdPu9?=
 =?us-ascii?Q?ay3liQuvdYC0ChqP8veuaJT50UA/H/ZbbsnuEMD4LobBDFcbvnB0szsbleVb?=
 =?us-ascii?Q?Enpxxx05VI8GYhpTTKAyWnrYkuFZV8R9uUD1fVdq0NXcH9/HofRzsjeypBl2?=
 =?us-ascii?Q?YFmQu+sg7b5R6LT/LI+2AcpeLRvWeHBq1OOsXVxcW9hdw6NCDFNlbG7YQFFv?=
 =?us-ascii?Q?9ZU2CQXmVCjAvnHQl0JmM8vzhRO3q8LrBL1K102tKLphBcFse9ToniqyEMv3?=
 =?us-ascii?Q?5ma5h7DH9/t/YRja0W7j1ybW1hmen6MjKoYXD1+Z7UUI5yuCdrhap9Lmq43k?=
 =?us-ascii?Q?h2cZ6qnCt20az613SEMsHlEkTqJYy2lqJq5qLCB6xmMeFvbd6W48oCVDV/xf?=
 =?us-ascii?Q?mPuIDmzCV8tYHPmVCNAo4cjtTAassZFklr1wcXme2xQhTSQPSjYFUSavp3O+?=
 =?us-ascii?Q?OH+R4L3M7mWbm3fseE9osFGjYOfJufSvGrcmyLtKahwuRT9xPJqQso+gc8zT?=
 =?us-ascii?Q?Ih2fHNCAQ5Uu8+Li3SJq65MKHC3oiEhd2nb2aLzt+AFizSRxDDtomarQjMUC?=
 =?us-ascii?Q?OhPK3YYi/YtaLXKIyZUgwv8Nr6mnWpQJdKbcCG4RVwBvGEFEmaGKfuAM322U?=
 =?us-ascii?Q?mFE/im2lADNue2rZgNhLW+BTLO5lMX16HzXGAHToVqntdmdwH+uOhRn5c0Ci?=
 =?us-ascii?Q?8aLd+c/89mQD7ocG7xVWbtW7CRAjcj5M2UTlAlKwhMV4330/3S2ZvIHcSjrI?=
 =?us-ascii?Q?eQA9BqYK2zWcuJFWXjQpuuRQS7+TDCEgmGDR1vMBhAvo1ZW5fRaHw0omxMmq?=
 =?us-ascii?Q?B61r5dT0PY2eqePSl4ihYyyNS9aGEVBPCs72RKG9Zky41xlyXS4UGcsIFOVV?=
 =?us-ascii?Q?ocAe2oGNCVDS//vo8xmEj+8rrJDqLDE5Lem8TN1/ALCNwIc0WmCUXWvPQv5f?=
 =?us-ascii?Q?7yFB/Rr46wfHts1TA8DGo3OAxfar0KQZMl+FvEdFn+evDgtzElkq+IZYhyq3?=
 =?us-ascii?Q?CZc8vSaRDRJCFI28yR9IuNJ4DUW4lK5RwtfDEbPP2VnN7BiqNKF5VpsDAx07?=
 =?us-ascii?Q?7AAAIhEUBprCKmCudFxFYOGPYoOHNKziMdSa06+9V7bBwpnObyJ+yJCy6Ofd?=
 =?us-ascii?Q?Gqa7A5uT1iPxyAgKIfg8/29XhmnWcHkSzssSaOnR5qGRPB0AE1ACTKY5I5WN?=
 =?us-ascii?Q?47eTU6fbruD92ZPNxOt8Y4Trz65TpNTW0tCTYMnsGbhHXWmngnzlfBsHe5u8?=
 =?us-ascii?Q?CsngC3XZa1H0GmC6FiQpoieFMpWdic9zIPX6871aTZUPFiImg9TfTPQeaQ9W?=
 =?us-ascii?Q?mpDfCS8kcnYHvSFbFXYjBItO7B1oidg4caBDuMa4Os3pDTWXi2CZZhTiw4MM?=
 =?us-ascii?Q?dXBbGh9j7ZZ4bj5TXnAZgnTPSfx6d5Kl+if+6DO5Y1W01dnwwrs5V6elzj04?=
 =?us-ascii?Q?teE9o+nKxT/EDlz2XZvjmqVPjaI6bhXLIN0vx9OPJAhF5cvtDLyrnlODsXNe?=
 =?us-ascii?Q?Zrvm/3zQcVJwTQja9Fk/etk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0423ad-4b35-4def-cf49-08dcf7c15da3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 02:28:25.2717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9K31VNbwrB0/6DE4cLw9dLcCJ9ZbM6rX1UhI7VmFdjEA1a7KlR+cGHr51+ZBiSAqUqvQyxkdA1CaOKYW11dsFaQ35aOWxy17anuPCYrjw+3Js3Eue1CXiMIzRoDBX8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8676


Hi Leo,

On Fri, 25 Oct 2024, Leo Yan wrote:
> On Thu, Oct 24, 2024 at 11:30:35PM +0000, Ilkka Koskinen wrote:
>>
>> Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 +++
>>  tools/perf/util/arm-spe.c                     | 61 +++++++++++++++++++
>>  2 files changed, 70 insertions(+)
>>
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> index 1443c28545a9..e4115b1e92b2 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> @@ -67,6 +67,15 @@ enum arm_spe_neoverse_data_source {
>>         ARM_SPE_NV_DRAM          = 0xe,
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
>> index 138ffc71b32d..04bd21ad7ea8 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -515,10 +515,69 @@ static void arm_spe__synth_data_source_generic(const struct arm_spe_record *reco
>>                 data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
>>  }
>>
>> +static const struct midr_range ampereone_source_spe[] = {
>> +       MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>> +       {},
>> +};
>> +
>> +static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *record,
>> +                                                union perf_mem_data_src *data_src,
>> +                                                u64 midr)
>> +{
>> +       if (!is_midr_in_range_list(midr, ampereone_source_spe)) {
>> +               arm_spe__synth_data_source_generic(record, data_src);
>> +               return;
>> +       }
>
> With James' suggestion, I don't think here need to check the CPU
> variant again.  All generic data source generating should run in the
> arm_spe__synth_data_source() function.

Yep, checking the implementor ID was just wrong and unnecessary.
I fix that.

>
>> +
>> +       if (record->op & ARM_SPE_OP_ST) {
>> +               data_src->mem_lvl = PERF_MEM_LVL_NA;
>> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
>> +               data_src->mem_snoop = PERF_MEM_SNOOP_NA;
>> +               return;
>> +       }
>> +
>> +       switch (record->source) {
>> +       case ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE:
>> +               data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
>> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
>> +               data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
>> +               break;
>> +       case ARM_SPE_AMPEREONE_SLC:
>> +               data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
>> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>> +               data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
>> +               break;
>> +       case ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE:
>> +               data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1;
>> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
>> +               data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>> +               data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
>> +               break;
>> +       case ARM_SPE_AMPEREONE_DDR:
>> +               data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
>> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
>> +               data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
>> +               break;
>> +       case ARM_SPE_AMPEREONE_L1D:
>> +               data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
>> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
>> +               data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
>> +               break;
>> +       case ARM_SPE_AMPEREONE_L2D:
>> +               data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
>> +               data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
>> +               data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
>> +               break;
>
> We have another way to do this.  If convert the SoC specific data source
> to common data source values, e.g.
>
>  ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE -> ARM_SPE_NV_PEER_CORE
>  ARM_SPE_AMPEREONE_SLC -> ARM_SPE_NV_SYS_CACHE
>  ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE -> ARM_SPE_NV_REMOTE
>  ARM_SPE_AMPEREONE_DDR -> ARM_SPE_NV_DRAM
>  ...
>
> Then we don't need to maintain two functions with almost same setting.
>
> I have no strong opinion for this. A dedicated function for Ampere CPU
> might give a bit flexiblity for later tweaking. It is up to you.

Let me think about it and see how it would look like.

>
> Last thing, please work on the the latest perf-tools-next branch:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
>  branch: perf-tools-next
>
> Recently we have Arm SPE data source refactoring, please rebase on it.

Uh, for some reason I rebased it on top of Will's arm64 tree. Sorry about 
that.

Cheers, Ilkka

>
> Thanks,
> Leo
>
>> +       default:
>> +               break;
>> +       }
>> +}
>> +
>>  static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
>>  {
>>         union perf_mem_data_src data_src = { .mem_op = PERF_MEM_OP_NA };
>>         bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
>> +       bool is_ampereone = (read_cpuid_implementor() == ARM_CPU_IMP_AMPERE);
>>
>>         if (record->op & ARM_SPE_OP_LD)
>>                 data_src.mem_op = PERF_MEM_OP_LOAD;
>> @@ -529,6 +588,8 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
>>
>>         if (is_neoverse)
>>                 arm_spe__synth_data_source_neoverse(record, &data_src);
>> +       else if (is_ampereone)
>> +               arm_spe__synth_data_source_ampereone(record, &data_src, midr);
>>         else
>>                 arm_spe__synth_data_source_generic(record, &data_src);
>>
>> --
>> 2.47.0
>>
>>
>
