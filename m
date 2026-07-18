Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022119.outbound.protection.outlook.com [52.101.101.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561CC1A6815;
	Sat, 18 Jul 2026 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784335766; cv=fail; b=eXOB/l0nqkpK0zEyDGAK5b8fiLtEWML5arbpgj84rwENMnUfJz/VdnGiZj1qoUAPlK/6mGKomYckMY5PsqDGstTFPSeiLbTu1aWpC5TRPi+fRW0cq65p0l3NVxkk/CJDBRryJgF7BE/xtJWcgy3SHF/pXHV5csTJiAcjCrEgxAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784335766; c=relaxed/simple;
	bh=me1/eMUqFzh2zkn1ckIwhyhywqSKOrVPGfP9XEb+Aig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kFXE4INGJwM3Lnq1igeqxvLcHbhv7+WCOuc8OH+It/FDAHbTM+Cb0lbZglrO3dObk51Jg2hsCofvByxpuvscnSQTQnVkKymvnW7USgm3nM+rOmLpfkfd/S+el/QaUY28uKxLVHvXTVyhZLe1zUDptD6UPnESub9HAbGkxUDEU64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azy57TnGsH1L9H6EtxF6eV6Kr5I0bOdgg6ONWL3eVzvavuYZuiCRPTSCbtfUBBJW4ogkOp7i1T5SYrRlQp7ql7QI0qRDuD1LfF9SYgk5vTsin3NNWt38cbtgmVrxQjyBEP++k/zJPbvV04bPo/O762p6q9TatvIquvxlI6fuqQG5AxneWauXjyfR6t2Hg6P1BpWG++3kup7dtjHlcRsJWcJKLpp9ySym1uMLUKVhnCCDGmaLa7ViTR7jRwMn5DkhoLW+CJaxiedCaee2CpphzBWs9fGHq5kQIRFlN1ST1J7ceOZAd3ulVUs2eaX3NxXd4mAzamjQpswopP5jIb8sMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=kotsjSO4WAS7lP+a5aqpV3ilSvO+xOXOQRBjGeWOYGQ=;
 b=Tv0ipsXJ3vit0X6Lvu1HbHQW26qmJksKz5ojutFydq/Ejw3U7rKacnrv21byULL6TJunza5hBhhwg1YwJYjzYTpQOe/vsn9/WK7qSYG3XmG4bO17zW8oFw3YNp2z9uhP/hqx/qXXlBguoFg6Zlfp8NzDH9F7FLqqEg/5sGkYvLP53xi64NHeV7ZA2kTbex5snF8+NP9uv3NZi8h1zjAtxLRoVQB4SgVy/3NpnXr8Z62Qcb277WoGkDU+kYXoyuE7gx4UmfCQJo2psuFPIq1DnknrCuXMZb2YS2GGSPiXb3/nuYtsKW0HdlOdHG4T/JeL2DqaBwL2o7eCUse7CInv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB7267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sat, 18 Jul
 2026 00:49:21 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 00:49:20 +0000
Date: Fri, 17 Jul 2026 20:49:16 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf stat: Add --hide-zero-events option to suppress
 zero-count events
Message-ID: <c6ohh5dtz7pziovntfu6d43zqfueflbnc63aidkhtsweqhlyly@gdb5kzo5qz6x>
References: <20260717023134.272578-1-atomlin@atomlin.com>
 <CAP-5=fVcpOPKoqRzYS0i0XzP8KwOhUFEwzuXtM3FbByBGTvO7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fVcpOPKoqRzYS0i0XzP8KwOhUFEwzuXtM3FbByBGTvO7Q@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0686.namprd03.prod.outlook.com
 (2603:10b6:408:10e::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9a9b3e-554d-46ee-967e-08dee4666720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|18002099003|22082099003|4143699003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	CSjUKiHlQUwLTubRIMvJIsYt+FkwP1p7coL2jTxQrVeToVuPJ8JQk+zWoA5VsNx5AlMcz6wmum75CXyGpcjbwO+8gkpZD9LP35A2evPo2pN15Xy7OJfLmYIImkWoENEbXPJ/mN1tDjti5cEz2WaI1R6/1HJ+6vDlMRXYw2a8sIs6593Hhgou+xaytq8d/e8FV8f7wdtdxrayEC1uDaNhJRLNDr9UKSRhdrTGcYTDc8vVm7+L5tkmYqRRy6HLFByEmngLZ9/Lno/aa9Lk5/Vf2WPlyx0lgjMNY9ImuwmDFw7eLTO/pai+v5B0HUuF3XllxzOvy3yWSBuRXsKeq6hiXpRC2cG0XIZnqsvBsb9ogmI9oVFQTF9td09N+/3i49VA/vaAkgFJ1DpV56GjMgov3Q8uV0vAtcus9JbmZ98fF/4x+/9gCTOE+uIDLo6tcY1kmPuGHm2hadgc8gUN3dJv4ROzNScKCGQR+4oXYti0DJn2i+dI+z/MQ1Qji4TlLMYU8hK1hekqyTLdOAnVLhte9JKQIQEWK4XkRdM5CAlXPOC76tA4LG9qQGyoIa2rdDFNHD8Fi6GPQcnvLWYFpAUCzJXozfbtV5G4vGCKHCy3IMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1VPWW5YSzEwQU1DVDNpMDMvUTA3LzgrZ1BHakFVbXpGV0ZjTituRnFZSHFr?=
 =?utf-8?B?Z0w4QWZIYUpnZG5tTld6SGNJZEpKeWxjYzRwaVdsZkp3ODlVVi9ORmxrdnVP?=
 =?utf-8?B?d2hCQWFYU1h2aEZqMklHZGN2WnJzL0o0R3ZSY3RNay9leWZ5c2pIc0dYeFor?=
 =?utf-8?B?a0JBeFl0Nk1BanV4eG1jUTJ1SWZzazVQcDRNZEZRa2ZKMVQ3c0lWS05LZ2Ji?=
 =?utf-8?B?L2V3d05zYzdwb1lxK0svOEZvNlplTUVDOGhGRk9haGhaOEhyaTVydTVYUzhQ?=
 =?utf-8?B?Z0xmbWNpZnUvdXNtWS96d1pxNXZVR2tVY1NaOTRhSitPV0NKL3kzb05URHlD?=
 =?utf-8?B?MVZiL0JmTUhQd3F5RjRBbXNPcVhOVWU2TVhZVVMyQnVMc2RPY2EyTEp6a1Jx?=
 =?utf-8?B?TDd2SVFWVy9rZnVMMndhMnVLemgrKzU5VE5ycCtNbllXVm5yZEYwYnd0U1NU?=
 =?utf-8?B?eHJxMkZyTjZKaXNqb2VRQjB6YkJ0SHNjaVRVeDBIWmtXaCtDWE9SVE1SOWdm?=
 =?utf-8?B?ZnplRWhSTWJGbEdnbUlITlc5SGN2bHRHTnJKZnRwVDdITmZjK1EvL2s2QnBr?=
 =?utf-8?B?ZHB5aWtqTnVGVU9BVHRDbmNzOUtwZVlzdDVtVjlWZVRaaW1xMlpiSDNQTWxM?=
 =?utf-8?B?aStnYXZMaldRQUpZT1FMS2lKS1hVZ0FyNERVcVIrdCtyVkh6VW1EblpPYXlt?=
 =?utf-8?B?ZlhOUkxGeFZaNmsrVEdKbDZKanp4ZXJsYnI4ai8wVVBVbklrTUpzNVlEcDBS?=
 =?utf-8?B?OXdMdkV2UnY4eVZaYThEd1dGbnY3UVB6a1padjl3NWNqRi9kdzM4Y1RRa0tC?=
 =?utf-8?B?eUI5OGhEOUJ4ZzRVL3VnWVN2NnJhaXRtS3U2dVNlMEpyRzFKVHErcnRnYjVk?=
 =?utf-8?B?Nyt1dEdyWmZRMWp4dXUvcWhOK09XeG53eEJxRDJxTG9SOVRlVlFEaEpRRHND?=
 =?utf-8?B?SmVDcGw2WituWDZ6TW9XWE9odktPTkVNbmFJUHVVaXc1aUdhM2hLamp6TXBV?=
 =?utf-8?B?MjI1ZVZSVUJhanBmMy83dHFpcTBhem4zaG1hOHA0RS92V0FMc1F0U0hrdlNN?=
 =?utf-8?B?VUVxUmhrckd5RldHbEpKOGZzeWdjdkFoOFk2VklQVXM2UnNabHEwYjBZbTBY?=
 =?utf-8?B?YU84WndQcHUrYTdqdEs2V2cwRGx0am5FbTBMOEdTNUk4OFlVcVk0WHljQWRa?=
 =?utf-8?B?SFJ4TFMyc2piaXJQQmZsekg4Z29hQkE5VzFNSlNIMjlZRFUxcC91QzZidWRo?=
 =?utf-8?B?RDh4N1QzbVAwSFZPeUpFdFhyRUVKNU56WjVDUzUwTGdMdytHTS8xL3dWcUJC?=
 =?utf-8?B?cFZEWVNzU3VkdVl2MDlNYW1PNENMRmdVcWxNK0p0UTBHWlJaaFM3anFLb1VG?=
 =?utf-8?B?U21STytGWTNSMGVxVUpsTzdvajY1S1o0RDRobkVsTzl3dHhzZjJWckVBNTN6?=
 =?utf-8?B?UFZ6eGJVTGRyMjRpeVJIVlBuZnE3Y1d5RDIrektpaHkrcUVsY1JDUFBleHUv?=
 =?utf-8?B?cWwxQjdNMGE1UW9zZGRuVVRjM2hGUkQxRi9xcWtIaFRsZTF3cnY4ejM4UkVT?=
 =?utf-8?B?dUZ3YUx1bWo1VVF5VjZxOW1MNmZDL0pKUHJtcHJDdkVYbncybkhYNzJTMk96?=
 =?utf-8?B?QThMdjUwSEE1amFSM1RKUDFyeFEvODVZUkpkYlZENDJFY0RqdGJzSVZQM0VD?=
 =?utf-8?B?cy9RbmNoMml2eCtTUzEzMlNoRjA3N0h2K0VYNmQ1THFTZFNwbHd4Mm45aWNa?=
 =?utf-8?B?d2oxUGRObGFmWEtqeU1RT05jc1ZmZmhCZGFIRlpqbWl3YzZKKytIZUlUN1FS?=
 =?utf-8?B?SjBlM0tBTThBWWZYTWtsTHBoV0FDSng5Q21rd3Q5UmNKS0RybHBZSk1mRmlD?=
 =?utf-8?B?eUZIRzFUSFVBYVhqZjVDUyt2bWV4N3pqelQvd3hOaWlxODBMZHd5V2JWaStI?=
 =?utf-8?B?TWttL2k2RTh2MnZEaUkzWFowNGdkbXNXVTYyd0dnbVN3Q05weWF5QWdlVlRr?=
 =?utf-8?B?UFZwZ3RqWmNqZHg4U256aXVpbGE0NGxvVGdwRzc1VU01YjBjTUlsNzFMbEwx?=
 =?utf-8?B?RVQ4eXd2bkhiVCtvT3hOc0tpVHk4Mkc2SHZPZnBaOW04VytQYzludnRVNndK?=
 =?utf-8?B?S2I5WFhrSFMxZUUwbFlCaDA4L3dXb29aelVFWnI1elljeWpaaHZSTEhFZGph?=
 =?utf-8?B?cXdPaVdaQmlaUnpLSldhRGNZbFhTVlB1NGpXSjd0eGI2MDQ3bWNud2RuMStY?=
 =?utf-8?B?OE11ZUgzTHNwd0tKWS9Zd0RMeVIwWG9tQTJZV2tGcW8reEdFVGprVDBCdTNQ?=
 =?utf-8?B?TWp6NW8raEZDWUQzV2lpMkxpNXA5VEg4UHRaRTR0SmRiVW9tRXJnQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9a9b3e-554d-46ee-967e-08dee4666720
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 00:49:20.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ21jFdklrXnAl6b8aRwtkIyRv/EzJbSUc05m3GfFlfWHblIqlv/ZNnzkEMaISANYgKmSYK0KF5+1waZLIudag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7267

On Thu, Jul 16, 2026 at 10:22:01PM -0700, Ian Rogers wrote:
> I think this makes sense but perhaps the Python interface makes more
> sense for what you're doing. For example, the ilist app shows all
> events and metrics:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/python/ilist.py?h=perf-tools-next
> 
> Perhaps we could also add some tests for better coverage:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/stat.sh?h=perf-tools-next
> 
> Other than that:
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,

Hi Ian,

Thanks for the feedback and the "Reviewed-by:" tag!

Regarding the Python interface, it's definitely a powerful tool for custom
scripting and listing events. However, I prefer using 'perf stat' directly
on the command line for a few reasons:

    1.  Standard 'perf stat' works out-of-the-box on minimal production
        systems where Python and the perf python bindings/dependencies
        might not be installed or packaged

    2.  Having a simple command-line flag like '--hide-zero-events' makes
        quick, interactive profiling directly on the CLI much more
        convenient

I have updated the patch to incorporate your suggestion and added shell
test coverage for both '--hide-zero-events' and '--metric-only' in
tools/perf/tests/shell/stat.sh. I will submit v2 shortly.

Kind regards,
-- 
Aaron Tomlin
