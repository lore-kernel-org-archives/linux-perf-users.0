Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020109.outbound.protection.outlook.com [52.101.196.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177EC4A23;
	Sun, 19 Jul 2026 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784421884; cv=fail; b=nwyxRIJFLTs273IsZM8yDUlpWZpLMoLZ79jGa+MPA+l0MK2uWw7sVVw8LTduBJZKUGJVGxYHtkENiD0NT5plsxhZUcPy+Uy9wTjlYJoqv8SNW22ZajLwzmg8yoBJkpCswwD/M5rKRWkHdJ+8LtNpcLiJ4HxuMwpSuIfPcY20314=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784421884; c=relaxed/simple;
	bh=YlHoD1nYv2QQGe39EG/XfYjlAzwUQ4PuC57BNfaaKug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XbFVa+YIGnBht+0Aw/dr8tzL8nsWvTfI9CysacXdvqNfGKceOvIHi2cuL2C5T10pel8x6QUBnKyDHBw3wKxQA4oK7ddV1WJHePpI3Mor2Qi4kzwcSZETtDaFk2onP8FbX4QM3zlmnalhgnl8spPnMMsH0je+FaT9jC910kvS09A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvLBz6sMx+JOfl5sy9D7THpRViSe58PrkqoQ+59iXia5Ti+Mb1ecoHqQYWfl/EVFT0/jGut1fXK2F7olG4B1iO+VZx+Qr/XsiXrkHINpDzoZMQxfh6DYLGFzQeUxR4mCAw3DujT4jODaYkI2U4Y4Ibrq5GY1j6bHbMTQ5NER+yJpWuBbkcGw+E2w4nfzoumujfveLFtR7Aq0lFPhHiixzu3zCpd9ErLNaRzQYJs6cqa8YpBOeJQoja4bSChCFd1nPIVAUAef5SZnFAQgOrT63UAFLXsvGFk6h4L2jHpkGuBAfMdyHLX+meY5A1IY3tnHaDiy1kVfXAsSHNwWTd70ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=HFVkpHRVdMmipp6hefBnqTUbgebk1z0+MNTdcajuDJU=;
 b=IzAz7jGL1xDUbIilzuM0bVWRtTzLk5GRITfBELdos8XWv2FMd8gDa7f2vZMfqJT6iw5ZChFbKkKAHvn+jPR6FAw2o6lOjTROnow04mDLlF0i15TiIyzZ2fvAOs90Q85qOdQKIfGn8QZnX9L5LZFz/ZsjCSmeky4mWz1YemKclyExVnsj15Cc8n0ho3IwvGnopLWdCIj8186ViD67yKlD2+SbcrPOu1iF6YlSh5Eo8qEZkBGCoUd/MXc4QHMJPJSZSa2ZVpHkoQEiWYKp77jPHMfDEkiP0kiHyXMAJYS04XbWQ+HSSfNlbDVwQH0v+HuN3y1JPoJ8ZvrgRAJks4Vf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b2::11)
 by CW1P123MB8568.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 00:44:39 +0000
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383]) by LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383%4]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 00:44:39 +0000
Date: Sat, 18 Jul 2026 20:44:18 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: Add --hide-zero-events option to suppress
 zero-count events
Message-ID: <tx4n275gjqgyfgaufpvsxxycpusgsjspafmvsi4grkyehqvvfj@qbegiktb5wdh>
References: <20260718011039.278310-1-atomlin@atomlin.com>
 <alsQFlmM9tl8ySH4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alsQFlmM9tl8ySH4@google.com>
X-ClientProxiedBy: BN0PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:408:142::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6616:EE_|CW1P123MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c74ec8c-d4be-46c6-a723-08dee52ee18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BK52S7w7tv92GSD9BVXMlKhNfi7KFV5MgCZKUzoqL13Cg1z7GqfYs7wNS2JOpMyRoSAwfSi2K6IA5HHDo6nQI8Mfn4pGBVDE9fRsKHivLRAurXxaAP+kRskmziH2xczEO67tHmVqk7CSIFa5xFA3F+4952yXW1aGrBhud535mkEG5WD3LcaT3uWOi5K++4xwgk4Tf9vLFE6x7nKcUATLYNSu8QPbL7qiDZ5Htg0m/EVtBgHkGZhktRP7mdSTeu5Dh/HxKH5l1oLT4wvh63AkLgXKX08OKlMIUZ2faZ4hRX58OiSCKOwGK68O2fVgJ/pdI1xSkwLlO0//Avi5UJIA941Xh12hWBV5b+bLrDLosFiBOD1uD/cQ7UTg5C3V/05t7swC5r2ZFwr8zx2BBPq4gMYjiSp7lpSH+GxFL/fRuakJHVD8STrIgF9AZfFe/P1jErqtMsVtxAf6JqWekibTIP8oAA+6kclCuuQuJrZOBpr7Nr90ldkrrpyih3bz3Ho6JA5U3N81M7TsOF+uWcrWYKqGR7SlyJlNrFdHRV8w0RHOf6t5fNk+T8Gyi65JjUPqff6u8AV6IEb1p1xS3bCARrvnzcQoV7ozPcTe+EigNahm3gHhNSOFW2hFDpnvuiHSrL4eXzk0dF+/hQ/paEjcIawe/y3+6ESjuSlwVhqWY8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czhvYTZUUFZpYTRFZHV3OWZMaStzT0Y2NkVFUEJQZTdlUklBTVdkejNaS2lS?=
 =?utf-8?B?bFZ2VFFnQldoVkxaTlRRbjU5WlN5ME9SWCtOeWZVWjVkSlFJM3RiL0VDNE4r?=
 =?utf-8?B?NTg5MUZTT09kc0JsZGRyTmtDTFBXOG1na2hMTGUzRVFsMEI3UVE4c3h4QWNh?=
 =?utf-8?B?dmUyam9uaE1GbkthL3JPUVNocHYvS2pwdnkwaTltQzcrUk90a3J4M3MzYzZu?=
 =?utf-8?B?c2t2OTFZQlorWTYvdGZrNDkyZ3lYTmZ2Qm5aelo0REcweUdRWmJMNW1FYU15?=
 =?utf-8?B?OTNXSjVpTklmNktNbjQ5VlNRVGtuc2t3aHVHQk12OEFjKzQzT0NBYnl4cDRQ?=
 =?utf-8?B?a3JWMjFIQWVzSm9hZ05nbVBYWGJhV0tXZ2NCSUpyemlzSitXOHc0U0xIR2I5?=
 =?utf-8?B?LzgzSU1UK1c2bUZTR0lEVW8rMmlLWkl3dEUyZnNWUHh0eFhlY3lpaXFRemEy?=
 =?utf-8?B?T1BXZmRCM2c3VW1PM3REMFNuU0M1amt1OHE5LzN5bE1jS2o0TzhSNlRyTVR5?=
 =?utf-8?B?QTYyKy9KUHVPWERPb08xTCtSb2hweDhselB1NWx2UHNvNlNCR1FzWVhvTkhu?=
 =?utf-8?B?LzQzU002eUtoelRBOTBhZWJEa0phU0x4ekx4di9SVjZvOTdkbjJFcVZvSEZO?=
 =?utf-8?B?Sk9TNGtpZ1l4OHFjNnJncUJURlpDZnIvVG5YNEpxVWJjVlBqQTJPWDVxSzd0?=
 =?utf-8?B?SmxMNEh1RWJFaEltQzhnMUhRempkWS9lUjlzZS85TzhyMlltVUNGSHlSRHB1?=
 =?utf-8?B?eVJLayt0WVFLaXdBaFIrR0tsamlKcEJKZEVPVkNxRWl3WU5tV2M0WWVycjZ5?=
 =?utf-8?B?L2R1Y2hDWncwaGhralJFU284Z2FtVWkrTU91VkhRSkJpdGd4QTQ3aVVqWFlR?=
 =?utf-8?B?RkNtajRabkpSMEVYNmM5Rmh6NExuT0JMTTZBUVMxVEE4ZWtSN29JVXovcEgy?=
 =?utf-8?B?VkJVUnZvTDVLS1NUOHJOQUhud2lDVHBtNzBTY29FRWFVS1BrejQ0RmkyS2xn?=
 =?utf-8?B?NHZkakFua1poVjBJeFU0dUhWdXFvYjFtWXFHSHJEVDhBRUFQR3RaOFppUkJF?=
 =?utf-8?B?L2FGZVNtUWZWRFlOb2txTE5DQzNQN0ZXVjMyb3pQOWZoMDUyMW1HV3ZFQ3lG?=
 =?utf-8?B?RjM1ZkxJSkpQZGlja3g4ek02NGRzU0M4YksvNXQ3RU9COCtwWjNLQnVRcmdo?=
 =?utf-8?B?bXh4eVdHQXRwdXkraTJ4K2VjRHJxQldxNFpVbWdmUGNqdCtsbWFIV0VIM3Vn?=
 =?utf-8?B?YUF3T0hRcjViRFI2Y3RlNVlQRjlPUWpXT2g2UlRSZEY0MlFLUWMxbndTK0Ns?=
 =?utf-8?B?UnE2Q2dSM0VZOUdGVCtzc3dnSi9SYWdXZFljWGRGL0tKS0pLUXp0b3VzNVFO?=
 =?utf-8?B?ejQ2a0EzTUpPbjgwK1pGOG9CdHcwTmZmTjBaeVRZV0wvWm91Rmh4TTFGSU9H?=
 =?utf-8?B?SVFUbW44WlE0SzRjNE9LREJlNmN4U01FNi8zM1BEZWNkeEdEcDkwclRWbVkz?=
 =?utf-8?B?Q0JJcXpKY1pYVVUzbXBlM2VYdUVjUXpMdW5oeTF5eDEvemxZMDRVYnUyZWFC?=
 =?utf-8?B?Q29UZnBGT3hPZk9sNjVsZnpNcm1GZTlkYmtlbDdmTkRjR3gzb0RpOUZabHFo?=
 =?utf-8?B?MUtWeXU1ZWNtYWRiSVhBS0o4Z0JhdWgva0FGbkFlbzJlci9xeTFzUFVDb01z?=
 =?utf-8?B?SHdIQW1qblF5UXFuRHRoeDFxMlkvRHg1WjN4UnEzWEpxRHJJMDNhMmd3VDkz?=
 =?utf-8?B?OG9KTjFTVlVNRmt2N1hFMjg5VjBWLzJRVTVHMGlPUEdKaEFncnVONGx3cnN3?=
 =?utf-8?B?VW5Kd1R4YXk2T1VvZUx3Q05VenQvVkdPN2xKcmx0NEpLNFdWejNCd1JVTlg1?=
 =?utf-8?B?blFWd2FvV2k3bVJObk1SMXY4SnJUYnc2OUNSeC9kLzRKR2JBZDErcWVoeEhE?=
 =?utf-8?B?c1g3alBkRXRnQzBvb244aW9NMnUvUVN2SnJRcTVrSEFpdWp2UDhtdzgrVDBI?=
 =?utf-8?B?dTUzS1MxUnRBOXVOYmdkVDh0clF6cXlqd0pCZW93bk9pejBpdndrZTdXdlZm?=
 =?utf-8?B?N3N1dWlaQjdWZ1p2WkwwMkxoNEYvczM3MmR3SU4xS1FwczVqZDBteDlwR0hM?=
 =?utf-8?B?VVR3OTRYUTlsby9GS3FCVTBoMG5OWVZOaTRoTWx5RzRBK085bWcxYlJtTytY?=
 =?utf-8?B?amlrZU1idXlKRDR2VnZzYWlhK0hSeWNSV01xRDFWeVhPV1Nrc1FGMTI1VGt5?=
 =?utf-8?B?SFBHYWVIbzcycWp1eEFHT2VSUHczaEMzL2g0RzFtL0h4V005UURTSXlaRHhz?=
 =?utf-8?B?NzU5NlQ1UHNwM1NiL0lOalhVend6aEQrc0dHZ1g3NzNaaG9KVVdQZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c74ec8c-d4be-46c6-a723-08dee52ee18f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 00:44:39.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIz7i4SenN72MBbr/VZ0X8aHlYcqsinN27xYlB9JSiWcJptr6lxrk7/1sg1ifn92XKX2zxXPr7lvH/LiXVRx2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8568

On Fri, Jul 17, 2026 at 10:33:10PM -0700, Namhyung Kim wrote:
> > Changes since v1:
> > 
> >  - Add shell test coverage for --hide-zero-events and --metric-only
> >    in stat.sh
> 
> Unfortunately the test was updated recently.  Can you please rebase?

Hi Namhyung,

Will do.

Kind regards,
-- 
Aaron Tomlin
