Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022090.outbound.protection.outlook.com [52.101.101.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AC99460
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785031520; cv=fail; b=YGmGVPdcvtxg2LfNcJpUC95CQ4IMNhs6GEjl6h612uGp4XPp01GzaVsY/vzNLLhuXYmoSncEaVisKkSc7bWuN7Uu+FftSgvegohrkv/U8F44F8r0GKnAMYyQcF/RA2YbjAn1NxKvLxxCyWB2+JpLg/nKEOeQwagcrHtpSDKHbuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785031520; c=relaxed/simple;
	bh=sDomGNwulUKaCcDXd8Q4rCFZewzMaxw6aWGzBzWCQRU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kyVBpJoSbWhYtouuBEnrQ9BoqBU4rJZHDG935gpPASeqH6+oS0dkWK+GJSKT1+Nj14UmNpEi+XKKlxurWjOe9x8qfjy4Z3EF5lSyByEzpY7oFUTHMenm4sgx7aBvHq9z4cwqCnKqvhbeNT7YuPlO+tz+cGlc0SUlo3WDMAYljpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7Escah26G9/s7pSOKLbe/jB+GtLwlqUVwwD4DPXJe3Oxrm8TotCwSl5HZMh30asR4INbT7pbHHUwkWz3iSb8zOylyJl0fNfDbFEvOf6Pvt6Sp+TNe+caZgoB3N4Cup8vzrxsYTIaX+BJeEBZwz6zVgiN4+raNiiXKlJWlx0Wnh+bqJy5p7snldvcQ9ecoV2kERGqsMXdWcFTW0SqAa3bbX1EwfQLxVtA2KwC8o+kHBSDVKHkXou4rqpeUf8ZRSFv1pWYA0g1ya7SvXhC6kWC/OHtgL6Gx2MSFQ2OoAlq2QaoRV2Py3oJarL7T0nDF/vVFicK9a1VkfXFshCtRTWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=xkRp9Pc94zgt3nznf+wadJD8dSs5m/SgFgoU/JGv2sM=;
 b=LrDJ+/psE+zsAlN3vmRxxkgLfvFGiAfVKhvslDetNuJQSJm2aUDh8APASO/qQJztN72r4y9+XpEqo7/gQI7k+DzOs61iIoLD/5dJPw9S546pmSXI8dI6GjqrtmGxdqMLWxLVk41Qn2NnuDy7ll4J1f+/rOQItpzQs7kYyc7U238cOl7+K5laUVrhOdnnR5vcxXUKWHCRGnZrgP3hfw/yQvUml089hOxyl/90uFyaAJhDfGkmq15WN412lnz/b+K8hYthQOzByYAE3QNJcqUxSMfK3oiPlg7GeEnxm7NNKveY6hcy5y7G0Fb1fRoV4fL0P3ek2U3ktd8iPika77Avlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6083.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 02:05:15 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 02:05:15 +0000
Date: Sat, 25 Jul 2026 22:05:11 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf sched latency: Add histogram and time
 interval options
Message-ID: <a5urii2ypbzstz2cgjjsr7bnmu4lwczfjl2wcnbphj4ykyngc7@u3n3hsldgwxc>
References: <20260725173341.679782-1-atomlin@atomlin.com>
 <20260725173341.679782-4-atomlin@atomlin.com>
 <20260725174422.3BDB51F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260725174422.3BDB51F000E9@smtp.kernel.org>
X-ClientProxiedBy: BN9PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:408:fe::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c959ba-970e-42df-1744-08deeaba5579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|56012099006|4143699003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	6A5kY1sZjUaY/sfS2AcjrFOlJqJnmGsMaJ5cAJCkGhkqeyhegvAItxr8A2FUWIHFWvrt24mMmuybzlTIW7STIZLoBNWo7cx+oOiQ6jQPiVTxa+p4S3KWEt8+q5qEtBfPcpLPWbcmlqXV8NaUVPY/5e+2/XwsF5Z0zGhlMZd5yoxrUYeecMV9dxXGIjF+ipGVHk86JnTR2ucUYgItCz8jVAz8yYSUusLb++SPmEd/30/h5rIT2xMkg6ET7wyBXPcrcz1fQ1xFOYREq50KnL2dkaSnN6G8+WxtMXuroAuiYKd+0k2E/WJf32uosAgFkEBHjo76Ya32JNXHp0sM15JvZOe7GgL7I/xIYnbzojfitStCw85KeqlP/uC6uYN44hV/rJ9hw6T43DwONOQSAOwhaTXeNRrWzaZre8C9P1afcdOm5E8XsWLaIrZgpdv5iPAGFyVEBOfAdv66bKSOvvGE9I+7WP0D7+mGPPIVdqelLdrH1BgUYkMIzmOcfIIgN9fLEMkPUTuB/2D7Imt0dC8xdq0ql8pPIRcWRSuX1nQqEM7Q5q36vR0u7hM4sPoa8KcilYDh7iVuRrNg7+wmk2avkA4lWiu6mH+zQ280rWd1jjbuXYhjJwZiV6abHNWeWJAJL0sv3mkrutLTy4C55+v8J99xib9nAJpLiTPFAshf/lM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0YzNUFMK2U4c3VpS0FuYWhCOWprVDk4SVQ0RVErZXRidW02eHZsREp6dTZh?=
 =?utf-8?B?OE1DOHRIQjY3eGduNkJpZnlzUW40eXdKM29Nd0tBcVJrclNJa0czVUhqRVI5?=
 =?utf-8?B?OEVlVUNLcVllbzY3VTZXU2JPZitIaUNqQUVVTWRLcFRNaGdSY0tMTDA1bUdv?=
 =?utf-8?B?bzJRMEQ2dWVzTFVDVzA3VkhMZkVzOXRaWlllNzhNMmFTNTZFL252bnc1Z2pl?=
 =?utf-8?B?S0hYSVdMbTVFNlJtQ2NFMzgvRHNiYU1lejNuTW11U081bzZNSjBObm9lTGoy?=
 =?utf-8?B?dmdsWkNUTDZudkw3cFBWeTZxQVlWZ1lwSE1rZXdTS0VwRG95VEZGZit2c0Iy?=
 =?utf-8?B?STh4QUNveU1ZMkN6eDJjSjFvaHZpUzk2VkF4UjBHYzNoNUpOWFR1S1NBYnk3?=
 =?utf-8?B?RG41KzM1N28xZzgvb0dVTmY5TGFxcXVKeTdTYWZFbFovQk9xaVBoL3NZdDVU?=
 =?utf-8?B?REo3SStZa3hVc2o3NU5ZZGg0TFF3QUh3MjdrWGg0TmV0MVFGM3RXeWx6RHR1?=
 =?utf-8?B?d0YySVlqK2FsWHp5L3dVdVR5ZWIxdHlxcWo0bmhFWENVaFpaZVpBMGxSZFo3?=
 =?utf-8?B?Q29kNG5oQ0psVUJTVU1NRFc5YnhaZ3ZrKytqNUJMV2ZQSFNoM3ErSGRCWVNp?=
 =?utf-8?B?WXRuT3N5VjZnNWkvaVNLeEQxK2JHMnltNTd5RThzeGhYbVhzcWxWckxaazNW?=
 =?utf-8?B?VUFlZDBySTJKNFNxeExReUJucmpCN2lSMGJtLzQwbGVTWG8vR2tHRjVVbGdo?=
 =?utf-8?B?SUFwdHlwUWI4NVhFTFp5YjdQMUUzL2RCTDU4TzFaRjhTdTFkUGgvQVhWdFFR?=
 =?utf-8?B?RGJCTUp5N3MwQlZyZGlqc1M5VkdTQnNPZWdVWW41Nm9ZUDZMTlJUaFYxUHc4?=
 =?utf-8?B?OG95VHBBWjZCQzNEeFliY2JEWTNVSFdINmM3M3lHZTE5d2VJYkRmT090WG45?=
 =?utf-8?B?TmYveFpSYWcyakJQR2JXM2VWRlV3TFZCUGNCK2VJU1laQXZyZ3NBc3ZiMzBt?=
 =?utf-8?B?eGc5aDFwaTdMT09ETnRSZU9BRFFKYSs2WHJRWlZNTkVtZ00wR0dXRUVWRmpt?=
 =?utf-8?B?SmY0N3VrL3hmUTdXb3RTcTRYVzRtNTE0enFpWlk3SURKUkdEb2tXZDdtOGNa?=
 =?utf-8?B?UTllaGpwbXpEOEc5b2RCdWZhTURuRFRFQ2YybjFEYSt6cVpCYW9lTk4yaXlQ?=
 =?utf-8?B?TUU2TWpQR0ZqYVVPb0RsNHZsYU5FM1pUczlCVmQ5ZG9YNGdSSkdQZFdUdndT?=
 =?utf-8?B?b0JyTmpuZlNaeVFjZGZTM3JiRDNIZzJYSGpYN3FyOUhGVnVWV2FEdEVCV1hz?=
 =?utf-8?B?S1g3STdjSVEwK2FUNFRtbkpETDJSeml5RmdreDIyK2FaYkpCdHNyV0Mydnlo?=
 =?utf-8?B?VDFFd0xRMCtsbDl1M3RqRlFwU3NYRGc4ZEZ6eEVubHh0Y2pFNjVuY1FUM3pu?=
 =?utf-8?B?WTdQYkY3YXY2dGtEcHBrZXZXR0NHc3FLVEw0b1l5R2Q5ZFJ4V2cxUmR1Rmhq?=
 =?utf-8?B?dDdiMmpvUmR5SHRLZTJMZnNFVEZOZGR2a0RhMGV2dXptNHN2KytqRnc0UGx1?=
 =?utf-8?B?MVFmNGcrUHN6MGkyWFhDdlNGVmhsOEg1b0ZpaGYvRnFjTFY1SU5yenhHVDd4?=
 =?utf-8?B?ZDdmNWNKWTZlenlxWldlaW54UE9hcy9BeXBtbE9FcDV6c1ZVWWkweUVXeGxU?=
 =?utf-8?B?NTBmemNkeU1hNU9hZWo0M0l5cGF0RkFyMmRLdXJzSVV6MHFla21XSUdEUVc1?=
 =?utf-8?B?L2lqYTN2djlFdktNL1FRQlc1Z3J1WFNJV2t3aGxwZnhNNTh0eERzcnoxc2JI?=
 =?utf-8?B?RVA0ekFmNFVNS0VncDByZndRb0FiUTBDQms5UnRzY2pVaUlHTzZ5blNOSldn?=
 =?utf-8?B?TGtFYXkvd0hvdVBtNytoelVzaExUWVA5Z2oyNzh0cFliemxSb2xTRUEzbSs2?=
 =?utf-8?B?NlpBODBCZkIxMXBRRTB0Q2VQQ2tyVVh6TXdaTjRYUUptQTJUTVJEWm1hZ242?=
 =?utf-8?B?U1VFQm1xSHQvcmNIOVRrbFZSVkdDT3hzRUhLYzM3cmRpRGEzOEtSd3ZsQWhv?=
 =?utf-8?B?VmJBemdwSlp4ZVFzSTEwWHdKWGNIaGNyTVkvUmxIb1ZoUDNCUTJIWXU3MDN2?=
 =?utf-8?B?alpwN244K2YyUWIzOFJObk04YTRoQ09EZVZqUW45NngwL1RVVjE4eXRmL0M5?=
 =?utf-8?B?eTdVajh1elBYWlZBclV4cjN6ME1wYU9hVUUxK3FOdHlnbGloSTBxWW9BV01B?=
 =?utf-8?B?MnRJQ0V6cnNrVkZDV2VTOC8rRDBBUFZDYXBGcmJWUjYrcjF6K0JJSHMwdkZO?=
 =?utf-8?B?OVludVcwbVdWY2FIZit5SGd4dHJ3KzNjamQzaVRQNnhqa3BxY0pmdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c959ba-970e-42df-1744-08deeaba5579
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 02:05:15.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: likX9MLYITnkoYlHnTEjbvOZJgNiZCHdB+3Ud/dwWDVW4ztrRjHl8NtE93jul2KUgpFkFagA+ZPyq8bcNTUQvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6083

On Sat, Jul 25, 2026 at 05:44:21PM +0000, sashiko-bot@kernel.org wrote:
> > @@ -1169,6 +1291,10 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
> >  		atoms->max_lat_end = timestamp;
> >  	}
> >  	atoms->nb_atoms++;
> > +
> > +	b = latency_bucket(sched, delta);
> > +	atoms->hist[b]++;
> > +	sched->global_hist[b]++;
> 
> Will this unconditionally include 'swapper' events in global_hist? 
> 
> Later in output_lat_thread(), 'swapper' threads are explicitly excluded from 
> sched->all_count:
> 
> 	if (!strcmp(thread__comm_str(work_list->thread), "swapper"))
> 		return;
> 
> 	sched->all_runtime += work_list->total_runtime;
> 	sched->all_count   += work_list->nb_atoms;
> 
> Since sched->all_count is passed to print_latency_histogram() as the total 
> count, including idle events in the histogram buckets but excluding them from
> the total could cause percentage calculations to exceed 100%.

A valid concern. Moving forward, sched->global_hist[b] is now
incremented only when strcmp(thread__comm_str(atoms->thread), "swapper") is
non-zero. This ensures sched->global_hist counts only non-idle task events.

> > @@ -1313,6 +1446,9 @@ static int latency_wakeup_event(struct perf_sched *sched,
> >  	u64 timestamp = sample->time;
> >  	int err = -1;
> >  
> > +	if (perf_time__skip_sample(&sched->ptime, sample->time))
> > +		return 0;
> > +
> Does unconditionally skipping samples outside the time window break the 
> internal state tracking?
> 
> If a task wakes up before the time window starts, its wakeup event is skipped 
> here, preventing its wake_up_time from being recorded. 
> 
> When the switch event later occurs inside the time window, the task might be 
> treated as newly seen or stuck in a sleeping state, potentially resulting in 
> false zero-latency samples or dropped tracking. Could we maintain the task 
> state machine even for samples outside the window?

This can be resolved by removing early perf_time__skip_sample() returns
from event handlers (latency_switch_event, latency_runtime_event,
latency_wakeup_event, and latency_migrate_task_event), allowing state
machine tracking (atom->wake_up_time, atom->state, etc.) to run for all
events regardless of time window bounds.

Finally move perf_time__skip_sample() inside add_sched_in_event(). So
sample time filtering strictly gates the accumulation of latency statistics
(atoms->nb_atoms, atoms->hist, sched->global_hist), preventing false or
corrupted latency values when a task wakes up before the requested time
window and is scheduled in inside it.

-- 
Aaron Tomlin
