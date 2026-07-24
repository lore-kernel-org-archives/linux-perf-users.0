Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020072.outbound.protection.outlook.com [52.101.196.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5E3E717A;
	Fri, 24 Jul 2026 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903162; cv=fail; b=r639XDsB2q0X74CXz4Z3PsR3AqWNW26+OeXdw1d7B5SKSR+2Wke3VobkhYLL3Kzq164coScl0V8qoKqwwEAhZuCKSmue9tKltO7/dcaT3kVlo8TejSlANUlNwwduqZaXoFApNYb2KenjIrfQ/BTXHfQiAU+3f5QqqDbB9SS3y6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903162; c=relaxed/simple;
	bh=bUEWCbZL9uX/ufdzEJ/TXbWapoXxr6NcU2w3FjzDj+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jogpyv2qYY+nKYcjuv6voesaxIZVOqhAK9hQAHsGrKn1+n/M1m59C9gr0tvOd508K242TYFZXP+puSDf1bSuLXoFvSt6d6nSajI1j4gSJ/995MAtpC74hQNBjWT8arWNYnP5jDZk9Xkn/ZgmrUgN/W5Uea5e/2DKyFU0fWUcoTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAn/CrHYw9qwBIVp5r4f2nD9xXEZzlbUpJVNFuSXCLyQqW74kBAVVfL5cnVoQmODlJ69XUHmGcIywz1lDtqyEj/qi1PNNaoY6waeZ1jY+psL5RMzZ/4/o1rdPq6O8qDsXaeKUDUTEVJWJ8RATJ016U2kBXUQWDVjCXa1txA4IDBzwj8NoVIApgLOlRruI3tRY7RHd5Afiyar7j+DurExb0bb2jbnFc1fAFmcA30+yg38fLpI5edYC/6HAp6x93pOTGTVYNoot8vaBuyfzTqu/ZzEu3prOotHNaz2Rn8Zi/TYH4U2GJvOXa+2IXKUixWED4POLuxN8OiX+c6n9sWSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=VmgWybyR3xQtZkGeK8/UxB2iCUQ07If+Br2UJ2v9GZU=;
 b=dLdue2rGAy/fKUKDPMagyCTCL+yRl24/dlp+bE+Qxaw/n5dDH6ELpJVYXTJvSQtIcS1yV+YA+rYB9GTyX6zYEcRvyhDsXRQ9vI8nkJOg4Rt3UaZMzkpiAg29YeWE6SAIRnm9dOH4lysrylV0/+oZWqPBuQp8K8jZx52VlwAMxUONeSG+DdvStb0coCQoCopEskw4sCH6YL6BMpG+bbHEjQDxKuFNhokGgnsoy++RxsbpjtxNe+OeAw7mH+jeo+egTgQUBFrQAQ6l3hsMwFSY1wZLsGIZD+SlRhW9uIChNjEwVwAM+bpSUy23dUHe9s7PLyuclqSUBWmb6uY+tDxTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB3679.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:12c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 14:25:56 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:25:55 +0000
Date: Fri, 24 Jul 2026 10:25:52 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf trace: Add --bitmask-list command-line option
Message-ID: <wpysr5lkoclas2pvreosgyc2ngrwfctzef5ftt4oyfgqxxxx7t@vh3wkrotbdo6>
References: <20260722155050.503516-1-atomlin@atomlin.com>
 <20260722155050.503516-3-atomlin@atomlin.com>
 <amGrbXzdup2hvg3k@google.com>
 <kick2ndzn7nisgdnxjit2tp6tfyub3nor54dbgqxqwy7ctgsdd@zxy23kkhc3uh>
 <amL-G7h_LC5Vsa-U@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amL-G7h_LC5Vsa-U@google.com>
X-ClientProxiedBy: BL1PR13CA0336.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB3679:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0c912d-af0a-4f79-f940-08dee98f7940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PlzgkqHC7V85eD4JIaT5QpiCgdMaEn1qqhmDHoOZHsWTdWSJBiIyAH3Skv9u6snyDiKMKOBAToJtPDypVNrBIK2XofmMKjgLcGS9gxMAR3RqNZhSVY76HxynCDywFNGWEvhE4wg37vtEwKic3aJ4/NQ2R4fmT8fqB1J4VyFS+YAyFjX1WQbENTmlHuCX36KDzf4xGCxrnpGcpbnGfoRjd2aogn2X2fBnrwZooO2tax0hda8nzYxUF8r5eKgHQCxAfalWx0utV6y0uztt1x81pbdNSl7aF5Ge+GUc3666EOrn0thd9iFMpMH+DbFL4/BKTW2/u/Ji9UhVISKgTyEaEftuUbduVSOtrlfl/Wuo11D+lQcvxhbtmmsPJ1IQW00HeZZO43z3nF/9GecXcIi8+gfG6CyZk0ni7GyQaIFhMfqQJa9zuHKVxbxnmJpJUu8ieoKIjpaj36qzQKMs4xyRDnlQfYg3yvLZcTT51gz2mYTgxVIEYwrn4cmUq99I/U0KN4Vwcn1tTiIrwL5dCYXWKDnMIOoDlRGRlp/+O/D1GioynnxDgFq6dC+t/hKsPN2msuvNeSjnCuJjRc4GUPjRVTTLhWnUXCa5+Wiwd6XTbtuNoEvwkblLLKV/EpF6ctOkxIZ7W1vSQgV3WQHy/SYjEKswuIKp4JOGqAeVmaenWNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGsyTkllWTZ4UEJObkJxV00xbVNKek5rUEdwR2RtVEdCVDdHdklWTU9TV1NZ?=
 =?utf-8?B?WmIvRVFBSkpPN3RjcmR5TnFaMnZwTjB4VU5SYVgzT1YrenR4cWJLL21ob09O?=
 =?utf-8?B?NFFmb0hOTXo3eVBlcFJhZ1VkcVNuWkpiZG5TZS9vZGNvVkdDU1pRNUF5WjVT?=
 =?utf-8?B?UjQwV3U2UUk1dDdnYVZhbkYrMk1GVXZEWnNBMWN6bzl2bmJXNlJmSHRtb1VN?=
 =?utf-8?B?WWg0aVlkaXFhTWQvYTVMOGhYNzFLQjJMYjEwMjIrUWVEc3R6eXpGVnU5dGNZ?=
 =?utf-8?B?dnp0VUNPSlZzQzRmY3E3bjIwL21UeisrRlNpaTd6UGVEM3pKRkMydGNvTFF1?=
 =?utf-8?B?V2NEeERVanVMSkJ4VnRiMUN4QmJWeDZsczlhYVNSY0pLWVZoNUNYbS9CMTB0?=
 =?utf-8?B?MklEdjN5dlRIc1lIREl6NUQ0Z0xHSHRwWkIvd3NvMkJPZ1hEazZnNTUwbHpi?=
 =?utf-8?B?NHJZYWh0WFNvUzE1elhBYmlLYU5kMnUwVkdSQXZlMk1wVVRoaExlRERSVFVz?=
 =?utf-8?B?bDVBU2dHWkFGUFFKTVQ2NGd1WG8yMWg1TVVVQUFGUlVwWHhiRE9MaHE5Y1I4?=
 =?utf-8?B?dnBVUXF1WnlWSWpaYXFjODN4R0JxbDdUekE4TzVkaE1weWkyd21jbW5OOTlL?=
 =?utf-8?B?OTUwUkI2LzN2TnBJMzdaNzdYSmNsVEpZTkNmY2ZrSlFIdW5VTCs2RmZJMXo2?=
 =?utf-8?B?L2xCTDI1aFRuWjJTUHBYYlFiRXM3Y1BoTHlmRW9KYXFnR3FoLzdJcEJFSkxG?=
 =?utf-8?B?dVhabkM0KzNtVmEyd1J6L0szdGttbitReVpjaGh1WDJKQVd3QU1mRHh0OEIv?=
 =?utf-8?B?eDU5TU5VeWU1TTFaV29nZlNBb3VIVHVWUW5NRHhxdXFJZmR2TnJiWWEzWXFq?=
 =?utf-8?B?QW12S2lNRTMrbTZtL0JxMlFianFiV1pjaTArS3FlTmpqNGozRUlrSmdlQUNx?=
 =?utf-8?B?aWliVmJsbHFNUndlbEc0ZkdwdHFrZmFvQ0FVbktBbUhhUXBoczJ3NW4rTGs1?=
 =?utf-8?B?SDRrOE5rb2oyYXpUWnNEajVQNnFkdXp0UU9Ka2ZmdHJBNjFYaTVGUStvSzdJ?=
 =?utf-8?B?b0ZPVlhiYVhqbmhEQW1WYmhQbTBaTVRGdXZOclZRaUFpekdRRDNTWG9hb01h?=
 =?utf-8?B?aE9QaGc1cU9xOUxFSkFyb2dPNVZHT0FOV2JtMEo3YWZua01QY3ZWU2o2OU5v?=
 =?utf-8?B?dEdQUGExemdUTWQ4S3BibzQ0RmFtUEFqSHRES0ZEL2tCelVtZDlVZmlMQjM2?=
 =?utf-8?B?ZnN4MnZkUVhQRG1WaERDc0w0dGZwT3JXWjNNUktmK0FtVDBLdE1JM0M4L0h2?=
 =?utf-8?B?RURscXJMbGJJOEx3N1g4ejgyS2Y1eE4zcUZlL2ZncUo4OVFVMmpWQXRMcWF2?=
 =?utf-8?B?YmtqNDJPY2w1SDVyandsT3VoRDJBZUVrYXkvK2RXZWY3QU5wejJkR28xWHlt?=
 =?utf-8?B?VWJpTWphUGJBT2dDQTYrcFpyYUFtNzBtb2VDTVEwN3J4dFh2ZTRvL0FWNDVx?=
 =?utf-8?B?MkU3NldFRm83Y3dzSnpNZlBEaVpFTEV4SnVBTjdBang0ekR1aWgzNENzWDVk?=
 =?utf-8?B?U21ZTFM2WlB6cGNIdW1kbC84ejRqUjVrUFR3NGZFNGpoeG12K2FyYmsxR1lL?=
 =?utf-8?B?QXB1Y1lWWTRFb3FBaTFSbGFwK2FOV3FtUThnT0R4cThHa2tRVXR0K3k1VS9u?=
 =?utf-8?B?TldqbkpGREFXeDVERjV5NVZXR1Z3Y2JUQWZJNzBlNlJjT2FYcnpmZ1JPeXpj?=
 =?utf-8?B?Q291eWpaaXlmWlRLbGNJUElzTGpGKzMvMWxPcDlWZ3NlcTc0ZFpOL3ZkVGcr?=
 =?utf-8?B?aE9sbnllNjF5V280T25jZDhFOUlYTUlGRDJsNHdqUWpGYTdDMll0Z3g1cGJx?=
 =?utf-8?B?dUhXVEtQTm10Wk1MS0ppVkpiUEpMb2R0OUFIcUtMWDZSblpvc1k0dHVSR3VY?=
 =?utf-8?B?SmVCMlFzQTNPTWdvTFFra1FjVWh3djNRQXFaYWpGV2NKSnBtczJEZlpxN0dl?=
 =?utf-8?B?cHErTGVrUnVPMTQ0TmVBdm1qdWRMRDgxYVBQZUZONWJHWFZNQUhOeTJsNm9s?=
 =?utf-8?B?bXZHaGxxRVZQQTVaTmxJQlhsdE5GRS9QRHUrRFZDTnNYcEJlTGVTRWM2cytH?=
 =?utf-8?B?UWk3alQxTngwcU5yR1QvOUltSzc4aGdENStVS0krZFpmQTJBMEFjMGdDSlFH?=
 =?utf-8?B?UkRQSC8vZHc2OFFTU25OWExIbHZKY0UyT3AvMGx0ZDhiV0gyUTIwMGtpcHZF?=
 =?utf-8?B?YWYxaTFSOHZhYWE5aldnYnpJdHNYREd2aUJUK2wzdE9ZSGNYQ0VxU2J4RXRU?=
 =?utf-8?B?SitacUhaU0xwdVZuVG12K0NaSlpnbnd2ZE1qZVh5T1lydWFuWnUvdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0c912d-af0a-4f79-f940-08dee98f7940
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:25:55.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STMvePifJ3e1vIWF9Z8DTARLzk/pqvUEWUUWd43k6xxPbAfIPBSc/eHnC/mRYJtCurRCd3Rb7xDni5zNyPrHmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB3679

On Thu, Jul 23, 2026 at 10:54:35PM -0700, Namhyung Kim wrote:
> On Thu, Jul 23, 2026 at 11:28:48AM -0400, Aaron Tomlin wrote:
> > On Wed, Jul 22, 2026 at 10:49:33PM -0700, Namhyung Kim wrote:
> > > On Wed, Jul 22, 2026 at 11:50:49AM -0400, Aaron Tomlin wrote:
> > > > Introduce a new '--bitmask-list' command-line option for 'perf trace'.
> > > > When this option is specified, the formatting of cpumasks is delegated
> > > > to bitmap_scnprintf(), enabling cpumasks to be displayed as a condensed,
> > > > human-readable list (e.g., "0,2-5,7") instead of the default hexadecimal
> > > > representation. An example is provided below:
> > > 
> > > Do you know any other places than cpumask use bitmask too?  I'm just
> > > curious if it needs to handle other cases or not.
> > 
> > Hi Namhyung,
> > 
> > As far as I can tell, currently no other users.
> 
> Ok, I was thinking about --cpumask-list or --cpulist.  But I'm fine with
> the current name as long as we can update other use cases in the future.
> I'll process this unless others have different opinions.

Hi Namhyung,

Thank you.

I decided to be somewhat analogous to commit 2cddfc2 ("tracing: Add
bitmask-list option for human-readable bitmask display") [1].

[1]: https://github.com/torvalds/linux/commit/2cddfc2e8fc78c13b0f5286ea5dd48cdf527ad41

Kind regards,
-- 
Aaron Tomlin
