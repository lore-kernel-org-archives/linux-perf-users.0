Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022133.outbound.protection.outlook.com [52.101.101.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B812B94;
	Wed,  5 Aug 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961017; cv=fail; b=YVWacI6M8t8A5R/Szj9wq6rl1Gl8o4JTBYjClepfWjDBxvJnUMZQTiVv1DoFz8gzMxdRRWyGu8Og9HYwN4ZJgdzxEQaapGll7NyShWOh+YWnGneyCNZIae4rF48hayYRRMe+dzUbegmG/z3JKeq0gX8vWiUelwSw8B7M3/+51qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961017; c=relaxed/simple;
	bh=qpPyrN5B1X2e6F/Yc6qVCtxQ2WPD7Og6W3L4hZt3IvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lsUEHy4Z2w2n3FDCB+xCSMcqbjfZsObVJsGCP9uX8B/pbd6LHg9l0Ny6hnSGAVvYH1Ugwu2or9rVM084I/me7YhJpsi/6W4v63JCQJYWofO7f7G69l+a6dgxK0etKP0zDFLhelKECO5VJ13gMYTeYPfJbqQOWGwn/NuQA0zClN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRWGoxMqSYs3Q/K8zvVYfu3/tH5GF8NZrvD7TkGlKyoaOPajiUWnYbbYT3W7tbNL/OirIZ+/IZlOQOMM/yWbma31SItsg9RO1xy5IcX3wzSeXsiCd8eV9maSGuYjscJa6XXzTJNNsjfjlaj40nn/v89NDyXhwId3/R6y5tFHGjUHZzsNNh/sz6rSh6RvrELCih7B8D2kp/Oic0sY9pgpLcIw9UmChpCLwQvIQXBp8T0uMeFxl6/+tPwlLLV7wustoDYhiM78QG66RTq6VcbHqd124N9s2ROywS1Mfe2gUcIDU6fS58sbvPcVGgNR5dE7ALb9+2hjK5QtqrCnfVhogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=gMkOGP1agTO8xVN9wnf2zMS3RsAdOv18t++kDIqIaU8=;
 b=S+Fr1xytpid/qomBWqW8WuNQlJbzNugAxPzw+geL+ve/h7afpS/gSTIwRG3a/3XkTGlm8BVidvocniF57IpXtPgcV00IyP6Q07SvAifJy8nFzsYJwUM3qJB8JM/UM4jdYjIvPScFwp4Fdxsg1EuAEGSdP97q+yz4uoez77Ol6g/nj+1D46vV5HxHvziFdEp93IGKP4EC0NUy3HFDdZYYEcso6lJBxC8dCmEt+JI2ZYgt350hxunnozoQoAVFVTXUaZ1dfWSQejnBe1ZmNwef9W8ygCPybINQ/i50sQ+1+Y9mMCLUvWVk2/4iDGNK23QCdk+MWpUtW0Q9MAB2Tnk3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 20:16:52 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 20:16:52 +0000
Date: Wed, 5 Aug 2026 16:16:48 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] perf sched latency: Add histogram and time
 interval options
Message-ID: <zjntzmhulwpk7gf63xudwbfvyuvzjwh4wi7uuphlllwnyx57mg@a3sf5pvdtyh6>
References: <20260802210914.199941-1-atomlin@atomlin.com>
 <20260802210914.199941-5-atomlin@atomlin.com>
 <anDYmITjYFalURtB@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anDYmITjYFalURtB@google.com>
X-ClientProxiedBy: BL1PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5032a3b3-67b4-4b1d-9b62-08def32e7cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fKnFqb5mMJwlhObzVl8T7PKESOn+i5N35ep2hIfQ1Jdv7reI04c/+/aX2JqShqqb5Whpk1Paqtc/lqba85BLrwa2MAwXhu6HLXAl4gHCRzI3ZlepkjNFaBGC2GlScRmq0M4YOQtgaTYHGoewFiARo6GbcwdACZryhxYpAwokuqj90nkld5TOF+SEPxlPv4iv13/Vg9JTSarxL0K1unEiUUFmM+kGF/fenqlkhAykHmRPJ1qfiCHN3zVEbTEiD10WXwuTvM6Xe30MDqtfXpo8yXVQowUi+ABpP0zdSTJ8EekQ0cNlD/j/Mf2MySZzwJsCB2JLKHyJBVY8olGzNutm95cOrWJCaLWuF8aQsZSat3cpVwQpwQyQ/9B+vLDjDMXjWJqC3uWh+umrFuDjKfHRYU4nvezhNO7MJecqou4N898RSkofXu9nGjsxaCbgMt/n7ODfGn5vyig0gO6R83hYUmIjSwwcjEi69K6/avhMFIpNHzwVqOiFajpLKz1/WujZK3B+F40HlG0lWpJjK114cVV208U3zeZPt8w2lVnwejfxOYEg0ATbGBo4n4dWpaeNFQRpk04dBfz1F+FK/4+i/+alyta2mOecq/i9eXCXAPV0m1jI6E44mBvM1V5EyEBbCUYVKmwy4dZY0mQ6ldowM0radjSKNYatCNqAzmVOHhQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vjhha3NQdC80OGtsdi8ybjcya3dUUFkvMmxLeTlHWUJwOVppZW8vbjh2RHp0?=
 =?utf-8?B?cEFaaXBUbytuUUIwVGhMeXhESURwdENvU1cvc2NFd2J0N1d2RTBrZllBdHAy?=
 =?utf-8?B?MXE1RE4vRlJkdC81U3BYRXRSK01CY05SMzNCZWNYbkh0ZlZ0SWxZMFBxcG9o?=
 =?utf-8?B?R0JFUDJhY2RnY2pHMnRCUkdVRUpKTGJhblI1ZVNET3FVUU1Na3dBb2hjZUtU?=
 =?utf-8?B?Qkt1YVVNOCs5UlJUWGtYWi9YVzlpU1JoblZaUitSTnRGLytsWHEvcjhJKzVj?=
 =?utf-8?B?NGdVdmdFNEVWSWNFMWhTcTFBUnlDcUdsZ0RRWkN6WDloeEhhZlZKSTBKVDFM?=
 =?utf-8?B?cU8yeWlFL3RnT2d1V2ZkeFl4MzlucUZFQW9JK0k1TGU4VGhrQ21Bd2d6V2NE?=
 =?utf-8?B?UUZiSTBuQVhVS0gzZjVtSHpCS1NBVlU2NnVmZjZPZ25yeW5JUHA3M0RDNUtH?=
 =?utf-8?B?SlJkS1NqOFdDS1FaTVlzSVdUdnpsbldXazVVTFh2WGlOU0orbHRqZlFGTzEz?=
 =?utf-8?B?Rmt5dVd3Q29FaGRtenRoYWdLUUpyY3VkcGwzZGtEMEg3S2U1RkdsZzVCODBI?=
 =?utf-8?B?bHZjbjhFVWh4a3U5THI5eGsydytmZGM0dEU2dUxaUkxreFFCaTlSbVZPTjFN?=
 =?utf-8?B?eklFZU1UbzdXQ2VkQXBGL1poWHlyRVZJeVBMcnV2ZXJ6Q09rcmRkb3NYanVH?=
 =?utf-8?B?YUtybWxqelRzYzRDOGlYSkFibno5N2xIdG5MZHo3UWJrOUJlRlc0RnJDQUhE?=
 =?utf-8?B?TWcxK1dTbEJUSndudnlCUGlJMGZYNERHRE4rYXBHS0NYVkFvaElDc2JGQ1pm?=
 =?utf-8?B?dmV4SW1kYkxqYlpjbGEySEhuWXdVazRLUHhidzl5dk1FTDVPR2FsSUk3KzV0?=
 =?utf-8?B?TWJKQm1SR1ZUSEVlYnVONWZvblRZV0M1TzZackE5aUJGMGZhMGlIVHhRMUIr?=
 =?utf-8?B?aGpFN3MyTGplQngyOHdBU2JWSFIyeXBCNjVmRHhiNmxYdWh5WG9ZdVlFOEF4?=
 =?utf-8?B?UDhWN2FzNzJ4RmgwdGlTUjNkYlB6cVZ5a2FjNGpvbU1aZU0xR0dCR1dyUW5t?=
 =?utf-8?B?bXRyVnBFOU1FVWk4TTBKYUdpWjUya050dVBaYmtqRERhcURwNFJXaXhuMy9z?=
 =?utf-8?B?ZGp5YnhqUlJUS0hEaDRrR2libjhjMndyY3laSFI5WFBGMUZ2UVl4VGtLMUl5?=
 =?utf-8?B?QzZDRTk2RnJIVUdEaDE4WWRWMmgwV21xQ1VGN3VvcUEyb3ZrZHlvclVtOFZS?=
 =?utf-8?B?dEhCUUROcGFVUjkyQmFXTk9pS2NFVmQrY1JtTlloV3M3MkhpTXNZWW5jV1kr?=
 =?utf-8?B?QVE1UG5zTEJNUjNXWDBHTkFRMDJMU3plVDRqb3JpWjF2TjRwME83TmNjYVRB?=
 =?utf-8?B?MjVhcURqUk9kV0dsMi8rV0cwbU1TV250VnBFaXdoNU5kSzcvcFZmdzU5ZWNq?=
 =?utf-8?B?MlBmMmJFTk0zTlhENS9mRDZuZTJtYUhDMGM4ZjRMWUlZdUptbUQrMXNuZnRM?=
 =?utf-8?B?bE5NajBwSFFzaFZqQThaSkQrSkQyL1dHc3Q2OWlJekNZR3M0SkU3eGdmV0pj?=
 =?utf-8?B?b2lvcGtNME5IazN6amVwRG1hUUpnK3Y5YmJPTHBwTlRXRk5IWEY2ZXg3Qlg5?=
 =?utf-8?B?RjJyd1hSK0NWcGwrdDhKam40REtkYnBUc2RUZjVoeHRCRjAxK2FrdzdjZjNt?=
 =?utf-8?B?OXNDRGk3VXlFREtCZlVJOFlEN0d1ZnpxZ05KYXdjcHozMVRXRmJJZ21DMlhp?=
 =?utf-8?B?SDhQQ3VTL1htYnJrTkJHREFyZVVIMWxyZWhPRnZOT0FZeHQvMGZDSUlLNnoy?=
 =?utf-8?B?WHlRVml5Nm9rS2FWMHZWWGVuc29TV3BIb0FMVks3U3ZSN2VKTXZSVFdGTDZT?=
 =?utf-8?B?MVdRaEcrOXFYYmVRMnFRQ3Y0RktYaEN3ZWNlNFRRQnBWcmEvTUk4ckd6UHVZ?=
 =?utf-8?B?d041SndFL3pNMnFrRFJWaHZ0dFg1bzVYdFJoZTZjdTgyMEhUNXllZExtQUdJ?=
 =?utf-8?B?b0JPNU9qSWNZSm82M3prckk4bjc4VElzV1gybnhiR2NlQVczbmMvMmQxZXdX?=
 =?utf-8?B?dXFndlZYdDBCaGVzOUlzY1NiNGJGVFRZUjhtR3V0LzJaRkV5cjJJakNOQTk4?=
 =?utf-8?B?YWtMRENwdmh2SS9lNzFQVFo1Z3ZVWXl4MmFreGkvb0FuSkFWOTVXYXJGTnIv?=
 =?utf-8?B?Q0J2aURaWHBld0E0WG1WVmE1cmlTamV1SmJoSkRqbjdIRzJXQ1lDRTNQdDBp?=
 =?utf-8?B?ckdOOTFmclVwR1hQZldwZHNHaFF4dUt4VC9WTzlUakIzcGlsQ3NJZGtXVXBx?=
 =?utf-8?B?QVRMTkNEcjdDNlJHdzVIZGJMZ3JWeEdWR1BNNGJTVWVnZXV1N25uZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5032a3b3-67b4-4b1d-9b62-08def32e7cc9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 20:16:52.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuyI3JdgBTNpR288eqd8nbQfYVESfoIQEVUQescVABjxqnsuavr+r1EHKsOyifxdU+N1yDrmwzU5mErZjp/7WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3040

On Mon, Aug 03, 2026 at 11:06:16AM -0700, Namhyung Kim wrote:
> > @@ -1168,7 +1306,13 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
> >  		atoms->max_lat_start = atom->wake_up_time;
> >  		atoms->max_lat_end = timestamp;
> >  	}
> > +
> >  	atoms->nb_atoms++;
> > +
> > +	b = latency_bucket(sched, delta);
> > +	atoms->hist[b]++;
> > +	if (strcmp(thread__comm_str(atoms->thread), "swapper"))
> > +		sched->global_hist[b]++;
> 
> Why is the swapper thread not included in the global hist?
> 
> Also it's probably better to check thread__tid being 0.

Hi Namhyung,

The CPU-specific "swapper" thread runs when CPUs are idle. Therefore,
preemption/wakeup timings for idle threads do not represent _real_ task
scheduling latency. Throughout (e.g., in output_lat_thread()), idle threads
are explicitly ignored to avoid inflating 'sched->all_count' etc.

Indeed, testing for 'TID == 0' is superior. For example:

@@ -1168,7 +1306,13 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
                atoms->max_lat_start = atom->wake_up_time;
                atoms->max_lat_end = timestamp;
        }
+
        atoms->nb_atoms++;
+
+       b = latency_bucket(sched, delta);
+       atoms->hist[b]++;
+       if (thread__tid(atoms->thread) != 0)
+               sched->global_hist[b]++;

> > @@ -3659,6 +3831,21 @@ static int perf_sched__lat(struct perf_sched *sched)
> >  	perf_sched__merge_lat(sched);
> >  	perf_sched__sort_lat(sched);
> >  
> > +	next = rb_first_cached(&sched->sorted_atom_root);
> > +	while (next) {
> > +		struct work_atoms *work_list = rb_entry(next, struct work_atoms, node);
> > +
> > +		if (work_list->nb_atoms && strcmp(thread__comm_str(work_list->thread), "swapper"))
> 
> Ditto.  Comparing TID would be faster.

Acknowledged. Thanks!


Kind regards,
-- 
Aaron Tomlin
