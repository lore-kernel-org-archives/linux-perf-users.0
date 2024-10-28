Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A01DE2A6;
	Mon, 28 Oct 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126132; cv=fail; b=BzjtbJRcXDtv+DAYwuR022dQsDFpN4LcvB8xvLtfhFb6xy/SroEVzvc8i3fkEX7JGXnFqYCJ0/eHQIingSr1P1Tfit/sMJhZHd1+MEwY1rL9F+egrP02c+jyokgiwNBx3gGMPDWwG92VoQf9mjbZsSs4zZJX4XRxgcv19Uvi17Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126132; c=relaxed/simple;
	bh=vL1U1VbtY/I8GEtjj9qHbzZnzKaqztESMFBRrR6xvZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aEixJs1EF+VxQSPqMMTATb1hRopgDCZhiIf+JQfQGao1E9LdkbLG0FuYNykkI2lvWOx9UhsoBYcg+4EUMzsf2oz70Xc66Dwhka88n+aAEagPsHPJLgfIBgPfy/OWI3OADINsDxcq7XpRyrgyhsFeLqGkcHJwi7mZwdqFGXBLv7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=acA0zMfQ; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="acA0zMfQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6MiBkjksK7uG3tyd/b/Qpbi7Gu0KwuJbNoXFaFma5QDjiUUoYbqi0x2tETh7Quw/KUPw1sHKNE0JlcW6/UaDIuLuh8wbN3830sN2eN2R4tsoqk3kEQat93ZUdIN/Ff8R+X8xbWwgtAmEZwZX0j3x1W0K4Giay/t0DimNqz3cfHy6x6rXsVML8Ndn/1pGsqQoLcU41Y3CHbyTdDcQSKHXKFhAnFBuE5u333m3MCJFjbUREJ6sWG1bvWLnNp/NqTl+NPzv5JsZ5r8HAuF6g1TONpjaACVli9lzjjPbbKRQpYJk9Au27I29FqZLmq+pI0FLmHlWGs2hJcLRt5C2Fs/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aoCFkmR8ku/BbYgOG9jswlYj9DEVjwgIloiecez/1s=;
 b=DLDXVwvONgr2w477yd/rjgb3eYESbGMRYiYWD/CQP993/yN5xcQmyIdMcqbpA1FSKRIeGZCDp0hfv4+VK+Iu5fGF44X+WoZzqx+cJR/Ykr3TKcKV2mKvKcuBT8QCyKUS5GMpNSlI1nio+Fq16ndiVO8z3RpzB8hE5fCB/8gkW0uSVlbSv685FOsCK6JFe+vJACN+IIAKPyUfxzCF6m0JDeNovWKbFXSCi2R7DM5nS1jcRb8QMAiaCCTUUvX1od/Pz5noDVc2lOQydbUcPmuVt6sZ/MWRkU8IHTWlLd1iAMAOAU6Hq3aGwQhKupWVYp2a+yQDsBVnk1IMa1JVXLJZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aoCFkmR8ku/BbYgOG9jswlYj9DEVjwgIloiecez/1s=;
 b=acA0zMfQ4fEfHfwCobzsfDSUCbLXA85mtL9CpuVRlcNwEC8nt7KZrRqrf3Qwz9JKosEEq41O8yD6CeMM+Fwy9gWwkyQTtGLcq0S/fbEUUYs8Tt1VhqjYD28oIS9mJpX0FO5vf4ofRJzp2x3zE5IJ7Fuwr9fu4o2gLuCTbnMxtpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 14:35:27 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 14:35:27 +0000
Date: Mon, 28 Oct 2024 20:05:15 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, ananth.narayan@amd.com,
	kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/10] perf/x86/rapl: Remove the global variable
 rapl_msrs
Message-ID: <Zx+hI+8sRPRBvv8v@BLRRASHENOY1.amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-9-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025111348.3810-9-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN2PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::13) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 4677b01b-c48f-4e34-5fb7-08dcf75dc3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8TVSJ+vdPAOSKpa7oOBVQ+ly+9J0kEUUyK4+FlA9Fcm8mLIvFOURzz+i16xk?=
 =?us-ascii?Q?qD43lYi4oYd0ozgAJu7RN4Q4OO6JJmXvcuGQxU/atofb/5KlrJUBRQiMqKVX?=
 =?us-ascii?Q?qaEQMxShPo6RPFCgidk/UvlpurlkxRj/505eZ5SvBPKrsiC7qNVdOrwYgrQf?=
 =?us-ascii?Q?VUGmPscUJQjPHzfAI9X4N5TnwfgilQ5Cni8gx6BSofB4kx2aSiN1w26egmK2?=
 =?us-ascii?Q?qCJzal44v29wtW+lD4rJryUdClOf+PWZgSRaZyH9Kc4Go+bJULWPbYG5QMSu?=
 =?us-ascii?Q?nLdQ07s6Vj8OpWKaCaSTNiB/TaqQ8mNQOVsOP/mgvtx8Qav56SPHy0ttbx8A?=
 =?us-ascii?Q?ociFR13WRLimMaIG4IQ8kHYELlMAyukb4dL74UZI0AchZmnxnly0YtBIxQPW?=
 =?us-ascii?Q?PYQ3KLnpePc2VOEX+fKuZIoOeda0hPhV0TUiCaw9rcS1R6WyLp5fwEcdIJ4d?=
 =?us-ascii?Q?VRp1moMGBfAp4RzmqWu+SMQMWh9rW8KxTJKho6jDLfR1sensbkDCPGeF+FR1?=
 =?us-ascii?Q?vvtxr2K7koVG0wO9JibzP/B0J0pJJW/98IyjwvBflKzIdvgJUkfOxV/+7xAz?=
 =?us-ascii?Q?6OsEGJ+RJt4Fr9Hn86JeXam7Ahj8m3OpuESLt4dokXbNp0Vjhco+pmMDEVWE?=
 =?us-ascii?Q?ffdQA3WCDgK943xjq6sQ1bkDGYkl0iDqCL8fphbL5PfjVOBijyYciFlaJZSc?=
 =?us-ascii?Q?UyTPUQunPxZgyudrwRTiDcXCk2M3DCs8N1yWcK3z6URG/yw7o5YxwEJ4KP0d?=
 =?us-ascii?Q?8cnS4h39oiiu9z1fNnkyzZ+JDtlUFnWOBe2sIxv1BlaIRJg4De/kBm196Qt7?=
 =?us-ascii?Q?g6bFW4HOa2DlJNvkP7x7z2sLKSNC4E7+ZLN9A4/TB6m4+4Wue7WS9poMypFo?=
 =?us-ascii?Q?tkc+W8Ps6iAdsbouAA5t9SKadiVxUYi3gcHM22fSBky924KUyJmXWg4VkVJG?=
 =?us-ascii?Q?OgfezIkquXjs8GQ0Kg2WCNLGbjjEjfYxkSsXE2JB5Tq0kQhWdvBXxifFslJN?=
 =?us-ascii?Q?wnnqO3NHMjnAIB4LdWwJ+Rsr9iYbZgIDaNeqlNTuYoAQYhBo2zIFOFWooS+I?=
 =?us-ascii?Q?E2oRhruvm3d56Cvamzskxj4WV2rS27JXclCoHqiul9u8jkdzsW4u6M7ZQ4Eo?=
 =?us-ascii?Q?u/Wtj88FdtBUYlPGQt0NvHB5DrFvfh2P/UbJB57otBFkXQf8zY7/9CPuPKk6?=
 =?us-ascii?Q?aqwyothRNVubBjg7rtrmgHPvQHjYN8vyeRwh2Bc8QM+Tzi78aChMeQGu6sGO?=
 =?us-ascii?Q?/3j4EqpbI1xTVLFtuw+2MYyYTo5q+03ZTZVEALLVfJyJgF6HT4c/EmN8ziuE?=
 =?us-ascii?Q?M/jrqTSv8JtGRM34MiAJmc1I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8wFJ5lgc2gyZGok8h+n8k1zu7KRaF1ws/PCPC+YIetjED9UHKiMho6vkYhjS?=
 =?us-ascii?Q?YzuiYL736U7bvq2taKzxcrqzsAPoehgFJwb/90vZxJ0/Z/9syvxKUilFRawm?=
 =?us-ascii?Q?46h3/Rj28GdbUQCIO9Ni4ajoAoK5lCTrMyKAeGt+gWap6SjvbU+il1DARJpA?=
 =?us-ascii?Q?c0YQ2/9aIQlJujaAb5pOY6ZQ2SWubgbc+BUpKQdS8fSNbdW/pThDVsLnU2Rw?=
 =?us-ascii?Q?W0ewT6z2bPPdFXrbLL5v/ZfhSq7QyGID8ZPwH97NF+sOlEacC17QyrdxmFBO?=
 =?us-ascii?Q?tOjEAwk2pPQp6rozEbwUVQpf5M60rGHWSFQo9wr+bjSn9lukk9EAHwn4HpTu?=
 =?us-ascii?Q?efO/491pPAEG3OgHcG6gJmTg9zzTb8lesiiP9kjvx84wkq+ozkg3kxywoabM?=
 =?us-ascii?Q?b8UiYMtjXP9/2Hlmog6tE6QawRf/yMIwxJMSYVnsdP/Yo7xT/ByvP8/lb1Yw?=
 =?us-ascii?Q?tXLIV07YFWywo5JCCldTVZLpNRvCmwh0MJQOOcQdXdsWITIELjNJLniosF8J?=
 =?us-ascii?Q?gE1uVHiwfgMo6OxS1lJi0/82/vrnIkQ6Y3vUyLg7oFbfL2AZfv9SxwRodq0W?=
 =?us-ascii?Q?PC/I3MFbS5Cfv0IZzHdCvCWBJk7nDU76KfyWZrYUf3u4xIJyHo6VAcqnD9hn?=
 =?us-ascii?Q?PDdEMDEnOJiJdjwDX1+xbuL6PYCObRhEv8r9GCRjyunbV15+PedvZeslMFjT?=
 =?us-ascii?Q?1u8Ke4VVRfmI+UA0x9m6VN/zgslG0CSHLC13QZ/+fub1LFmNgglfUs84JXT2?=
 =?us-ascii?Q?u7/lRTMu3pizG3TQVctmZrEtUlpy16Npz3GrqBDDI3iJ9S/04yciRR5cMqQ2?=
 =?us-ascii?Q?q2uPYuZZUaC5QSb3FNd4GkjUoRjOeNIRMXwoDTQGe8soxb3Tin9qfrBMfTmf?=
 =?us-ascii?Q?vHoSWQxxhX8zqSjnRzRjoYFP0IGCreXwYhAkgEzErf0ExseVb4mC/O3SZbpB?=
 =?us-ascii?Q?Y2BF2oBESZxsMFqAWhCMLhrhDOspaAlb/kRjZKakuheAPVbuTkSJp5+7L/+E?=
 =?us-ascii?Q?szi0lc1E+0MbJCoVklecjIDPep813/eXt4OWVTjQoFjDYvKpv91+fErEH31D?=
 =?us-ascii?Q?tCjZ7HmBN7S2282N3Y+ee/UOLdpjuSMp+pjgkaFN1vM/GJzGQaJr7JUxVNyT?=
 =?us-ascii?Q?yc0hUWIy5bQo/PiMjAankYL6HfwKr+t7JRgp9+avm0lXhxlOzz0gSCnmCBAm?=
 =?us-ascii?Q?EkA1OtEm+vCL8D9SkdkeDQJG123Elt1zFVnwRQ3Ipvy0EJ+xZAGSbn+OgHoy?=
 =?us-ascii?Q?W9tQmnx0ERIW49S8ZI1+AstYl8lF7eXGgUwhmaX6wQL0J/6IaOH3uHWMiaTg?=
 =?us-ascii?Q?BjZq+8SVvdjDt+2v59OBGvqNYG0Sh3p0Rtl0b47uHkyR62RdFZl8fjEXpajG?=
 =?us-ascii?Q?27iCQ+9gVf+7DAssSEr7Ak/3DkC93WnrSuZRp3glLBPoEu4/yrfAk6w2bopG?=
 =?us-ascii?Q?3d3etueZCAv3OzksTG7H/Mf+fbqPZyT1kdWO9ZK2GR2hZTilFJ4BwIwapAnO?=
 =?us-ascii?Q?W5+S3JCF5vLs8B/1E5IxzP0D8A9sDiOZHTy5kusREh5jgRQoKEGKQvgPezth?=
 =?us-ascii?Q?oVrNz7hwLV1CQW5yL8jvt6Axrc9JW8Bejgli3Qht?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4677b01b-c48f-4e34-5fb7-08dcf75dc3ab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:35:27.0378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZg+lfWh1IEGCjus4kb+aw4joJFYeG/GBCDuDHWUDRS0d1j71pT+b2h5UO2dctnfZOSIjxLpDWUBRQhVUiT7Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

On Fri, Oct 25, 2024 at 11:13:46AM +0000, Dhananjay Ugwekar wrote:
> Prepare for the addition of RAPL core energy counter support.
> 
> After making the rapl_model struct global, the rapl_msrs global
> variable isn't needed, so remove it.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  arch/x86/events/rapl.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index ae8b450caa9b..e80b62cf9abc 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -150,7 +150,6 @@ static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
>  static struct rapl_pmus *rapl_pmus_pkg;
>  static unsigned int rapl_pkg_cntr_mask;
>  static u64 rapl_timer_ms;
> -static struct perf_msr *rapl_msrs;
>  static struct rapl_model *rapl_model;
>  
>  /*
> @@ -376,7 +375,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  		return -EINVAL;
>  
>  	event->pmu_private = rapl_pmu;
> -	event->hw.event_base = rapl_msrs[bit].msr;
> +	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
>  	event->hw.config = cfg;
>  	event->hw.idx = bit;
>  
> @@ -805,9 +804,7 @@ static int __init rapl_pmu_init(void)
>  
>  	rapl_model = (struct rapl_model *) id->driver_data;
>  
> -	rapl_msrs = rapl_model->rapl_pkg_msrs;
> -
> -	rapl_pkg_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
> +	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
>  					false, (void *) &rapl_model->pkg_events);
>  
>  	ret = rapl_check_hw_unit();
> -- 
> 2.34.1
> 
