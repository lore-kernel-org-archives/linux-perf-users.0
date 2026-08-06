Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020121.outbound.protection.outlook.com [52.101.196.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38204314A0;
	Thu,  6 Aug 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025126; cv=fail; b=c5KgKiRG2YRAKAWCOQQSi5YeYqPVhakQFSWASRZSkPm4WJnMR9enziAEc5eIOOm9aKtHw5SDRTFTUdKufs11xrTIHQvLL07ojrXk1t2lWYmlNGMoJ0iQRMDsWFTMihjCI4HCmUM8thKILLVNbXUNaf43tYRKxrjmcrHoNAillx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025126; c=relaxed/simple;
	bh=0ca5ym/qVsnseo6j2svol5phUE9izhSJ74QEFdG+iws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ilosbQsqon0pKkhNbxOSQvXEyJpI0n3MmFMCt5aCqWYUKE2CX4F8GvRaNZJIZOt4P+5VNi7xtZzyUTDEf3YKGu3dPTltV8lnycwqU/cFKQPQ6TGciMTILgku4C8GOo0LaExYE4c8+nAHROOUFBzhD0cFQtyxdbew+f4z4mQvbpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ih3p+ggMVDt9js9nxu38VoFGm9t2kz695HuamL4LqwdSOXvJaggCo01R0h9xuUR0ao8QiTUY0Y7QRJca/iRQ+7kQBUm7ZNtxaNm4SeF+QdtTBUUiuWAstAA/v1htg1p8feziakPWczpj87U7YE/C79gmcBXJWusBTlSCMuopdXMD7WJ9fxb1jb0+ucfzb9ZhHNLBDagHa0ktJiZWLrA7GvRZEwoxmfwnasEv0bDfQ68UeDgpTRvh7D+VUkFJjENAeNnufBpfTdTvwykprXvEe7sleLbGS9Qneq4hHsXHXNYZUMkCteFC1fFhEDCAHkkyu6sGO7lTDWP4zUD57SnClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=SFQOFkEC6mOEShmrXFAfITU4p7o6HgAU2uf3XdnfOMs=;
 b=mRzPFeNe3fdi7RPBJahNeycbqc+jzakkiirQGJcoguFTooJD8iKYjAuAIkgcP0gxMBspHftOLL9klrrH+lclaK3L/aT9fPwNHT8nDZo8O6CR2P8MLpU6+ttddCtA2oUqGkliBxJIvedk73Yunfe/cNhJ8dgbd6hod5PupOanseSoOix5KD8Rx7d/ACk5kcGzTepzNFT2eqd/mTabKTiqpFTwyaudI5CrtdjJbT/B1+Zj0FCkL8aJgWSfiyYfd8A3lqaGSh3HoxxdQGoshf7lmT5/Z2eJ7881hXZG6PdMjUJRgdcPm3HvjkGqz7+CTVgR6Cs8F6MWH7SxKumqSK6LyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB7150.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 14:05:09 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 14:05:09 +0000
Date: Thu, 6 Aug 2026 10:05:05 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/4] perf sched latency: Refine outputs, unit scaling,
 and histogram support
Message-ID: <tr6xylsuqp5qv4dqnxbdqdanwp3xjpfcmeeqyy7ulcflpg6j2e@fhvu5baonenz>
References: <20260805210751.287746-1-atomlin@atomlin.com>
 <CAP-5=fViE_+UoKhUJ2FHeyhuVKz6--yFcrADBqf1YMYhpLmOdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fViE_+UoKhUJ2FHeyhuVKz6--yFcrADBqf1YMYhpLmOdw@mail.gmail.com>
X-ClientProxiedBy: BN0PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:408:ed::26) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f1d11d-e336-4284-d98b-08def3c3b9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|18002099003|3023799007|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	3njllwJgKz4UvB6CfAsfhtoQhKOs1Im0TVUPVKlpu0shPbqFZEdCYA9abQGShuVOPJ25YY/6CI6j5y1YiiFENrqeTxudFCMTzDD/AoNge14lv+7XmDSmN54TQhVI8fQLpao8FZMqOnjc7tI34jWY80js0tOqaAfPk6ePECPctfyZ0y70v2tWm+c/ODcwIXH4FK+P3IpnY93CWJ5F4fJJskWbnmFGkWoVJVpIMqWQ0L2KO32GWnmT3L6LUv/7D+x+0AHCs3YDmFLm0avZmyKShALLegsFXItsex02pwSsQBPEqCWkpV+EN/MFK/BR1+SHmdHRIxdnlhan/6ss9n5oXYCKZ1uO2dSpsHMBMtdiKrjsOW6Qdw/4zG+Bs51LmOSG9M/WMWpqdeknXBDvd4gJ8B2YFnd0/k44ygko4Oui4XL4mPNenYhVHuNcFJThZJpxxdGN4ZFNr5KGjY2NzoozaO90AyomoaCWuqRn88qP1/qDjIu+P/ywglCd++h1LhLKvfJzN6oRMlgs7M88sv6MHQX2u4TyD2/iXYr6oMOQqZpuoDPTB2V4TN7zOdm5C/nBj2hBgVFSDkEgw8aUoInfL/eZMEP4a+n6/maGoZZTQtHPSfevn+v3FPTxyVdkXpV/vmWeSXyajyyP6MwaAxOlXOGyqXP1DNLc/Zf9T+TtMQA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm55bGI1a3VKVUc2aTFPVXZSRERNYU51UHJseVhhQUNFLzFqSjBONldKbzhL?=
 =?utf-8?B?Ym9XcjVKbEZzVmFxOTdpV3h6L25yWlRNaXlSVGRtdkNXQklxMWpTTGdEWkN5?=
 =?utf-8?B?cGRvMnI3bVdiQnhEdVJGT21HV21ycURXenRKL3ByUnlsdTZHWGc1MHA1K2FW?=
 =?utf-8?B?QUlyTEF1dDJIbDNKUE9zUmg5OW11NTN1clE3dXhIYmdlQWRvcE5VazhFQTIv?=
 =?utf-8?B?QURJMEFONGtscXMzeStQbUM5UDk5SW42aXBMWkt3RXBFQWFja0U4NHg1U3BH?=
 =?utf-8?B?WVdmOFZOa05JOGRwQlZzbWZ3dkp3YWtMbHBNclZxQ0sxU2diZnMwa2N6aWtI?=
 =?utf-8?B?ODc1Qllia3B4K1k5blNEWFZWSU4zT0RzNWR1V2I1eHdJVVcwUWNaeU5ZaGtj?=
 =?utf-8?B?ekdycVd6dEliVHFETmxkZkhtOGpNYXBBWGIvV2VpVStDRUpjRk1ZVmpjY0hk?=
 =?utf-8?B?VXlsTHgxNWF3dzhwaGp2cnp0TS9yZmhJY3JIdVlHczQrUklXNTBDZjVSbVI3?=
 =?utf-8?B?cnN2YzNVZ3ZZejJsdmpkL1Bub3lPUDZrRVBGN2x2ZityR1lRYlZDUHVUZ2hS?=
 =?utf-8?B?M210Qyt6aWFUdnJaVVE1dnREOS96UkdnWnNxNmE1TmQzWmZqd2c5WjQ3c1NO?=
 =?utf-8?B?a3JMcWRzU0RIVUVXdGhLQ09WaG5Wa3d2cStvc0lhVlZlQ1dtQVV4TnhsNlB0?=
 =?utf-8?B?TUxTRHRHYkw1cjBvKyt5dCtQejhCM2JFWklDVEExd2Q0QUs2U2gvenA1b2tP?=
 =?utf-8?B?dGo5d3BPL0FvQU8vQlBYRmRRaHFhM1B6clRJenhSdFBiMzIyK2RtS2lSNkNU?=
 =?utf-8?B?MTRQV1JlbEJleE1XOHNxVGxubmd2K3pZcjN5VjRCdkxCOWcxNTZqK1NqNzFK?=
 =?utf-8?B?aVI4K1FpcmlrS2J3VEtXdlJhdTJKaFcwbkQzZ1hEQ1p6SEh0N21iNHdQcWEr?=
 =?utf-8?B?V2JBN3RhVjlKZS9SdURmaEFCSmVBd2JoM0I2V1BJVUlWZTM1MXBCU0dVSkdK?=
 =?utf-8?B?VFNqdE9La0RqSU0vYXJ6VG9YLzhFWjZJVldob2YrbU1JRGhJQmFyc1NmbXFG?=
 =?utf-8?B?bkVJUjByb21FUG1HWEl6cC9JR3JOS2NoYmpMNENodjczUGtiNTdKQjlQWUNI?=
 =?utf-8?B?OGpmdEVUQTlEWDV6N0R5cXpVTTVyK1BPMThYbHJTaFhCODJ1WHIvVjZwMTk2?=
 =?utf-8?B?WG5LR1grSDRtdGw2NWFtcGdBR2xKbUMraUViWU9TSnVDc1N1V2gxL0REMUR2?=
 =?utf-8?B?bDgrZjV0TmV6VTEzaTd4aDVocFRZT1ZhaDVsV2dkVC9yZE1HYXFWSHhXdEQ1?=
 =?utf-8?B?SDVWZjBVaUdaSVFhQWRtN2hyMEk1c25qTk04eWhUZm5zTW9ldEgrUVNmTXlk?=
 =?utf-8?B?Uy9DYk1ROC9SMzluNTAxQmVUdkhOTkJYT21tTEVsOVRXSHdmUE54NFdOU2RQ?=
 =?utf-8?B?YzdpKzRhd0pDZEVvdWEvdzJCcWxVandSUWh2elhwbEdiK3l3VXg5NlpwcHF2?=
 =?utf-8?B?dWRpRUJKcGxHT2xsVDNMTlpDY05uT3JNTmZkVCtjb2p4VFB4eDRjTFZHeUs2?=
 =?utf-8?B?RWtqUjdJMHR1ODVhNzRXckRrNnhrL2RHYkJHNE1CZVlaQXlwTTNEa3pUbks0?=
 =?utf-8?B?M01vU3RLT3E1dFI3UkFIejNFNDVtamtEQ0M2SjdqY3gvNDEvdmM5ekgwNTQv?=
 =?utf-8?B?K0lvd2srbC9qRjJZbGcxRENROU90WXpZUEdLa2h1Sk1LeG45QTFwS1ZraTZ4?=
 =?utf-8?B?R0ZvdkVXbm90Ym54Nno4Z2xydm1sNWM1U2t3anlZcGt0SVZCR25UQmlQUkFZ?=
 =?utf-8?B?UWZFd05WZkEzOWhCeVJ0NjZTaEZOdEpkdC9PZFIwOU9NbkhIYmo1YU9iWU53?=
 =?utf-8?B?eWpSZXcxR1Mxckd0QkMrODA0UzEza2hqUTBYNnFaZmgwMUtkSFFlZXhwUG9U?=
 =?utf-8?B?RkhiTFFOdTJha2VDTHpRSEpqQ3c1TkhhZ2k4LzBTNnRDbXFDTlQzNkgrWUpj?=
 =?utf-8?B?eU1Wd2FzY0JVclA4MFpzMmg3bWlNOG1QTWkyLzBLeWI0L041TVg0WjJCN0ty?=
 =?utf-8?B?OWpod0VlUHpPV1ZaeDY0dlMzdCtVNllBeG85cmlxenhUYnRLS21kRG1nWmRZ?=
 =?utf-8?B?T2JJbDdOUXFDM3lNZmE3S09OMGFSNWxQRWNvNjQ2enBacldtRXZEd2M3bDM5?=
 =?utf-8?B?YXFwM2Q4ZHV6eWhDTm01QXFBY1JXTVpram5JbmdJU3FYUU1pSStUdXVaazk2?=
 =?utf-8?B?dytDdEg1Zk1id2lJT0VsSUtQUEUzcVNwVENseUM2ZW05VTArdllzSTZONGQv?=
 =?utf-8?B?M2RVMmdhcVVOWFpyQ0pySlp4VmV6dXI2aHJXdDBZT2g5dGgyVkUvQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f1d11d-e336-4284-d98b-08def3c3b9b7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 14:05:09.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WA9XqNI9EEO2ev5d8pHQHL68fd1OaoD8FQUDfONNZuLkIC8IYFSvKNOmkmK17US2PNmDCjt2vSOHp0YIybcZ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7150

On Wed, Aug 05, 2026 at 03:02:06PM -0700, Ian Rogers wrote:
> On Wed, Aug 5, 2026 at 2:08 PM Aaron Tomlin <atomlin@atomlin.com> wrote:
> >
> > Hi Namhyung, Ian, Arnaldo,
> >
> > This patch series improves 'perf sched latency' by suppressing misleading
> > empty table output, extending pipe mode stream processing, introducing
> > dynamic unit auto-scaling for latency and runtime statistics, and adding
> > latency histogram visualisation alongside time-span filtering.
> >
> > Patch 1 addresses an issue where 'perf sched latency' fell through and
> > returned success (0) when perf_session__has_traces() failed due to missing
> > tracepoint events in a perf.data file. This caused empty header tables and
> > zeroed summary statistics to be rendered. In addition,
> > thread__get_runtime() in map_switch_event() is guarded against potential
> > NULL pointer dereferences under memory allocation failures.
> >
> > Patch 2 extends pipe mode stream support. Because event attributes in pipe
> > mode are received dynamically during event processing, session->evlist is
> > not populated prior to event processing.
> > To handle pipe input correctly:
> >     - Register the missing .attr, .tracing_data, .build_id, and .feature
> >       callbacks in cmd_sched()
> >
> >     - Promote the handlers array to file-scope (latency_handlers[]) and
> >       dynamically assign matching tracepoint handlers (or
> >       process_sched_ignore) inside perf_sched__process_tracepoint_sample()
> >       when evsel->handler is NULL; replace process_sched_wakeup_ignore()
> >       with process_sched_ignore()
> >
> >     - Perform the trace check post-processing when handling pipe data
> >
> > Patch 3 introduces dynamic auto-scaling for latency and runtime display
> > columns (Runtime, Avg delay, Max delay). Previously, all values were
> > unconditionally formatted in milliseconds (ms), making microsecond- or
> > second-scale latencies difficult to read. Columns are now dynamically
> > scaled to the most appropriate unit (ns, us, ms, s), column headers are
> > updated, and format specifiers are aligned character-for-character with
> > table headers.
> >
> > Patch 4 adds three new command-line options to 'perf sched latency':
> >     --histogram (-H):
> >             Displays an ASCII bar chart of CPU wait latencies between
> >             snapshots
> >     --hist-mode:
> >             Configures the bucketing scheme to either logarithmic (log) or
> >             100 us equal-width linear (linear) mode
> >     --time:
> >             Filters trace event processing to a specified [start,stop] time
> >             span
> 
> Thanks for these improvements and the tests for coverage! For the series:
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian

Thank you Ian!

-- 
Aaron Tomlin
