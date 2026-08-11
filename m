Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022094.outbound.protection.outlook.com [52.101.96.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F442A150;
	Tue, 11 Aug 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450243; cv=fail; b=X1GduCp/QCuQ6RA4xFG/Amn+/5Dj/E9RvY7u0JgjicDBGlJ1v8q0+sQ4DNKG3GJyEjWOVcRiAzmu3RE8qALuxvo2YE5UvLMZib0IFCT9pybctbSN2hzXJCD2JOD1j6QeIrXRjVUFWrsrS/g1fKI/7Qn+ApP9wnJE8nV/GiKM2do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450243; c=relaxed/simple;
	bh=AYE23eMfRWreiRT7QGKE4IO40oVmZ6AteYv+0d47BUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V4GqWiIDJ3NAi7iERf09gm/2GkVl3hE0zg1ffQVOCIrt4TJzeSUXkcfWaA3MPiKqtT1mII7DXl2FV6jGbEfd8IU7b2uh5IjDbvNgIynKzPXAMulIMAedGfOUpYGbe5eKG7z8r/gbSfZH9U3gkFyb267LAK9XJwoskPZbX7RDfmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCD3KWvE770cn3UJ52ijCtQzN4wBBXL4S/xPm4Dufu/C9hn6O6lW1RJyplcBkxTQ4WbyU6g8xdiVo5Wv1neeS7AMNp11SQGKj1LLPRuNtGji626lpwf8FCi5RsUVqn9C1+V0mrQTy5lYShanidd8eMAkMLBJUU5YIkHJg4sgPV8Po+nrQ6wsDWcFbD++y7uG/dP8zijcSNG/rAnbcd7y4Oyudfa9Xfr9gFx/mRSmGewsILS3N1PLlvObsGz1kFRqZCjf+gm6XGkb1+Z2769z6M4QitsV1d7egQ8pNvHqi2Istuki+yWnYR2Y3ltMqcptZ1Nr9vKduiYPVI4oY27C/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=C6sqBGPDDMxfYw6NGGAsIz8hJmyE/p9Cf7qLnKg5/sU=;
 b=SXdLUBQkVYJpeyjDk33eIUpVclpfryO6VWuVyS5TVFU8m/ZevSpSHuVjv01OM9iAp+xdskZ13jBswhmJoubziCkBv3YyqnklhBAxFQR874duVBRjyUa+ClHc/KuXaidJ40LWKQRXNkmCZsw7mLAyLId8AX1WwUyWCVhCZg71cyKRvJ+co9G+XpBo6wYA8619uHwIUwsWORx/mixhA5QbSlh+cF1ZKSxEyjQXby3NCA3P9jyjwWsTSypVfP1x4krNt8wKYRxmSEv6Mn7FBlGwSSjKTIZv3J+9UBbe6nlcXdz8wiWUOa/bkRrVnftXr43nr7IYvSx/Tee+9QDMhyCsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3355.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 12:10:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 12:10:36 +0000
Date: Tue, 11 Aug 2026 08:10:32 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/4] perf sched latency: Refine outputs, unit scaling,
 and histogram support
Message-ID: <ot7k2ycvntbxthepc2x6zixg7cmcibi7644dkvszvcvcidiqf5@2r5omvciwj2p>
References: <20260806153926.300499-1-atomlin@atomlin.com>
 <178614675174.2923192.12057881964440578941.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178614675174.2923192.12057881964440578941.b4-ty@kernel.org>
X-ClientProxiedBy: BLAPR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:208:335::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3355:EE_
X-MS-Office365-Filtering-Correlation-Id: 153ce5d6-391b-463c-38b1-08def7a18d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|56012099006|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CMuQTRTLot6K9wpeejhkRs+Vn1PIKzLnlBX+9nenAZD67OnMLnPtdJC/99Q2cYRfA8lIwiInHmOk/S03kJi7vKaaojfX9JikmogXdkNQcnoRLHkIV/yjrKUzPqVtiA6fDrc8wUid05S2O9NZkqUzSa4W4sBUfQ5Cb2CQxNsjQQ+JiD2qyuQx/IU0O9NPHK+D8mPE0H/NxAhQuPbyZgjuFji4cus8yzQDx7aWy6vKuJiJmT8/M2hNt9A+liVuxHQlFV5iCZcIdc0GMpyzct0M7TWgPqQkHXvC6NI6eZ5dnWicf9NxiRB23Q2fOMGj5UmLTZ1EtoLgBn6+7RX8B2Q+ziHv4acrbzrk4Ir5Al+FsgQN8IG1gS8teo0n2hZacEbkcdSIHb7Ks41+g6msgvVlYSuzcHrsGr0dkx/+9raT+YrE2OWS2IkWn+lWAAe4qNA/mzeps1v/o3ZeXZLNmRdhqFNCdN3nF+O5a51B15iq0otcVEWh7b+fC7WRemSIEwXTJzxkOKZv+1xhzuv0W0roO/xy37He29jH4xf5tDzj/yE1QKVo5Xv7EgSkEBtgoIrPbk93qik6K5cTtIgAZy/aKLgwO1UUG9U7R6ma2t30jN6an8WMTPT4lR+w6aOpkO8ss+rVELNvAU4e2i7e/HkXGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODdEUXgzMkxYZmYrTzFUclBzNENmY2xJeTJjcTd2Q2t6aC8xUGx1TXpFaFgv?=
 =?utf-8?B?WVhEaFFZMC9ublRaNFk5c2pPckRLRWFPNFJ6MHovUGxZTU83Yzk3aGs2b25x?=
 =?utf-8?B?MVQ0cnZ4a1puWjNGTDdMS1hhS0E2TE9CRzd4YkpEaS8wQ1djbll6c0F3enF3?=
 =?utf-8?B?ZHQ3YWp0VWZoT0cycW5wckIzeXdPMkZtN3FINWc1c3BqcVNWWGZvL1JTZjl2?=
 =?utf-8?B?OENpRU5tYnpWOTFZMGNkT2w4dE1TM3JHYnJqRDQ0bVZWaDM3WWMyYzg3RkN3?=
 =?utf-8?B?Z05YR3FsUW5uVkljeUZpUEh4OGhSQWFmY2xOSDR4azl0TVB6MWFTckJDT3lG?=
 =?utf-8?B?Tm93SlNxdm1Tck9sd0Y5VmdER1RSSVpSMjk3V2ZqNTVpNitMZGJhcmxHTHN6?=
 =?utf-8?B?TndmL3o0OVhrQmR6czBDUXJwMTBMQUYvQlNrbUVydXZGa1FneXRnWUoxSEFl?=
 =?utf-8?B?bnZ2MXRTVkxwLzZBeHJKUDg4Ui9iQmRXc2p5bDdwZisrV0ovNEFubDZFSWRs?=
 =?utf-8?B?eTE3dXlkc0lyNmhTelZ1U2JCS09GdnlBUkVVWHBpbHQvSXA1Z0ErMEtZRlov?=
 =?utf-8?B?OTJaWmkybW9NSUVPT3RLYjRvN2JCSXF0Tmp1eHk2ZjdYSTZEK1haSE1zbmx3?=
 =?utf-8?B?ZTkrSzRvTU5hMjZPZExLdmxPZG00WnF4amZqcitIbFZSS3lSUWhlMHJYT3hC?=
 =?utf-8?B?eld3T01qdlZDME0xbHdTWHVTMFBrTnBNU0VhMjdERmRhTkM4dkNHUENGdWNG?=
 =?utf-8?B?NFZFTjFObzRPcTIyVlZzTEFPUlNRUUxHR25pTUlyYWRpcnRLMjA0M20rUmw0?=
 =?utf-8?B?SWdmVW8wT25zWFZYUDFNdm5PYTREWlM3VEw0emdubDJ5bDBOYjQ3RHFtRmR6?=
 =?utf-8?B?SFpaVnY4WWp1eHY2RithTXBkakNjaVhNR2Z3dDRNZ1pBNnJFQXYrQkJCVkVE?=
 =?utf-8?B?OFNYdzRZTURTS0I2NkFRc1pwcUZJTjJTNmFUWklWS1hNTEVXTDF6NUJHcUE4?=
 =?utf-8?B?N3I2NGxLLy9QYnNSVnFjaGtxeHlBWDhaeUVpNSsvZktZWURYV0ZKT0FXQkZY?=
 =?utf-8?B?dU10VWlCdjRMVVMwRzRxeEZZSHIzODlua0RmVVR2VWxZeVoyN3hrTlV0U0xI?=
 =?utf-8?B?SmRtOG9Hakg5cDNFNlhEVnp6aW93alR2NnFFNmJuMFNDc0daOFNIWUlKU0ww?=
 =?utf-8?B?R0w5TEUxYjRoV3VVRFFJVUdFKzdoS1ltKzdwZGtQb213bCs3UWxQZTh1Slkr?=
 =?utf-8?B?aFlNSk9BOXZ0cXlyQWN1NzJ6M0twcTliTUJsT2ZPUWFSbHNjMHZlNXlBL0NY?=
 =?utf-8?B?UXlLdC9kNDJTcm9MRGVNeWNVZG8vaDdZMWVnb2ViZ0poRWRGYmg5WktEOFpl?=
 =?utf-8?B?WEd4ajdGeU5ubUpUQ09WTzhIL08zTGZ5bHBCS09KNVZNa29iY29ycEgxUG9N?=
 =?utf-8?B?aHpPYTNQSG1pSnEyUGV4S1piOXdpM1hUMi9CZ2lQTWJld3hCSUl2TlV1b2hy?=
 =?utf-8?B?OTFnZVFuVjZ2TXYzRGV1SHRYMHpsdjlVamM1RjFJMUZLdFUvZjZBRTVXRGFp?=
 =?utf-8?B?bGNQT3ZxQmllMDRzeXQ0QnQ4NURla0E4V3JZSXJsMnhDQmVPUExXTlhxcmxM?=
 =?utf-8?B?TWpyOUc1RFhVckpQd0FXbXBCR2pPdnM4eW01SGxSWUl4d2V0UGxBakFCWDg1?=
 =?utf-8?B?VmZoTUNIUmNvZGhMYzNheXdPVE1OblVxYlR6TEFhdERibmQxMjFTVEtjYWJM?=
 =?utf-8?B?V3UzcmlKWGJEZ2d3M0FBVjZRdXptaUF3T2Q0bWpGa3lyQ1BlTEtQaitFWEs5?=
 =?utf-8?B?NTlYRlQxVEJBU0RYMDQrMmxGYlRBOHNuUm1TMC9rRGMyTlh2Y0RSRjdyNEQ3?=
 =?utf-8?B?a296QkhHUmZSTkdLVWxIcUdVei9OaGlwNXVGSVhKTTFNVEY0TmR3RFhpL0Fy?=
 =?utf-8?B?aE1KK1ZwbEFXb1UxMm4ydlU1MU1sajBWTXBuaUkrYlhiVVVpb2dqaloya3pa?=
 =?utf-8?B?NTJsUDhUZTNqWkJyN3VTMXozWVlrMTBkTHMzYmFwUTZ3TCtjRGwrT2lwOEFx?=
 =?utf-8?B?TndtN0RZM3JTbGxnbHdhVWVhR29oUUJvQy9YNk5lbGpyQXI3c1JJM3ZESHRL?=
 =?utf-8?B?ZmdnZUdMNG5WSDNRY3NZN1VmNXNidHVzVUlFaXV5QUhjSHVTNXEzSjQ3U1VT?=
 =?utf-8?B?MFo5UXMvQWJIZG1NVGNiZjZiaGlNM2NUbHg1QURYVVkweG02ZDl4Y2g2WGNq?=
 =?utf-8?B?cTZ6d21RdFZPQ3c5ZHAvMDFxZ0RjS1drclpsUG9mMk9pVlhQL1pNWWxzY0NY?=
 =?utf-8?B?Y2Z6eEluYzlXd2JwN0J2SldZVkt6eEliQ0pUKzUwWXhXUzFab0YyQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153ce5d6-391b-463c-38b1-08def7a18d30
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 12:10:36.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9ZhFT4HgtZSu2sioV6veOI6rDRGmgxAyU/1UXhoi/GeGKM++NlcaTg9zmRG8dUo/+ldWtO/MYY7vkX3PG68vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3355

On Fri, Aug 07, 2026 at 04:52:31PM -0700, Namhyung Kim wrote:
> On Thu, 06 Aug 2026 11:39:22 -0400, Aaron Tomlin wrote:
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
> > [...]
> Applied to perf-tools-next, thanks!
> 
> Best regards,
> Namhyung
> 

Hi Namhyung,

Thanks!
-- 
Aaron Tomlin
