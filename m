Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9428642D;
	Mon, 19 May 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672774; cv=fail; b=K7wlyncwaUulrmvaR0kbENW8Ps1D06BEHwwDhIMNIWwCWns3SiRjeSt6GN+BOUEm+acGKgbbPG7KwmsAsZmpGn1em8bOapNRXJwOZmIrE58aRG9GNJtRq+GKoPrnUh2vMMXz2nVtIljhlknE9CXMXbX+LwqVEKIajjR2S3dceng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672774; c=relaxed/simple;
	bh=E7Bke9DaGKdkRUoUYumHChwA48ElMSBkG9aH6zsBnAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xdrb+gAGJhD49NdfrkDq/wOIJl3gd089WbKAmjINXdmgLIIUcRGgqKir2Gsrne5AIa1nRmMci3Lq1Vg6XTjLzSrarrP0AwrJQETPog5UJ+z6WDQ6Ev5mhBDoCPuoLXyt/bnCZL77rPbgkMzHXTVbt6NMC5RzcHpINDc6Nq7eE3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ikDLE6Go; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ikDLE6Go"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bu0W0FPb4bKC5YMwrIWqJOGshqiU2/511OSlUX1gDDEyGWHcYDdBKiHfnxtH5LN1AEg5kLYGvD5+0igEjDKALFtQ7q5BhVeONQtAaeFt2Cu2yTNOV/DlCtvlzNTVyGIP9gJNGEhkbX4J+9fI+WT5QnaJojEaO+kKEfyt/mAo+i2Cuz/zJsd69jD7PGAq8BhrzY3b0KPOLnOGjMTQlCqHqoo8s5kWbuxcBXJwl0AhISKXTPl5ndspWRMXVrXONYwwmD1+tcbYkEuBRQaM/asXsQTuso8ccsNCu4R7TAsjZ9qxOMaBBEmUYns9bH1erXh5xzOUmRmwjLtmVY18RcmsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o02AZqEXvC/XoyY/W2K1hkB/U3dq2YIuIFUgi8a3Vls=;
 b=TK7fVQewqmSeEsTz8SLemSeyClYOvCqBBCFM1Z0mbI3SWNEEQHzOpUy2xWj/730H83hA+aLtB00bMW71dJI0P1f47f3lAoRxX5hEH/8nyOQ02LW0Nu4ktx/BSOyB3/hcQS2TWo3qJCaU+/LssGcShlQMv2Q5SfegnqLfKwh8kouZTMR+SD1I8UXnC2yR52nqPd7e3RX3nHSnfnkLt10ZVCG8C+HEn88ItDFlU6YSqdB/joju91gg6mstq5PrMYxGZ3IGD0PMFD3Tx/6pRPIboln5N0q5St1VjkWry3CBAp2vEYDIwkH1lXDykWZv5Zu7rzPSEAUFa26UkAIEXnD58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o02AZqEXvC/XoyY/W2K1hkB/U3dq2YIuIFUgi8a3Vls=;
 b=ikDLE6Go+zBpkw2V4TQjFnpc5g3mU/z8Gph93Ur1PLdiZS6tAb/i0e0Nub4Y8q6ggC1rx+OVAJGsS92CkxdIKlHSMZ/XcBXXIdQtxOiAb+2GhU5y0wfrvupiein+3lKEKlqAovif9clpsWJT+p2RbbbJcjH65JGKaOGeDXC/9wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Mon, 19 May
 2025 16:39:29 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 16:39:29 +0000
Message-ID: <d8e45b04-d746-4af9-a55c-c3e46f8f952c@amd.com>
Date: Mon, 19 May 2025 22:09:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: IBS perf test failures on 9950x3d
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <aCfuGXUnNIbnYo_r@x1>
 <33e86415-c90d-420a-b7a8-6a360769aea4@amd.com> <aColYM3RqE4T5t5c@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <aColYM3RqE4T5t5c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 4faa8687-daab-45b9-c0ae-08dd96f3b95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGVCaUQ3TFBVS3Npdk1TdUlsSEV2WkF5ejBJMnlEWEJ1YkExd2ZlQmZVK1R6?=
 =?utf-8?B?RElWeVZ2LzRKQ082L0xxNzhlcHZjM3RPNGJGblE4UHpidVFjWUxyZWhFMTN6?=
 =?utf-8?B?em1sOFcwUlFxcmxQSHAxL3gvb3BxWWxWa0dqZWFrUmRMRUt0TFFOb2hqUGpO?=
 =?utf-8?B?V1d6Z0hDOXVIcEpOYUdBaG5vRUI1OG5xUmxrVXlNTHh5YjUraFJ2NndnbGcy?=
 =?utf-8?B?bzZuVlN4ZnFRQSs5eDNjWGd4MnF1eGN4bitxZjk5bDlXV2FiU1ZPNXo1c0dC?=
 =?utf-8?B?SUtmZ2JuSzVzdmMxSjh3eEdMZUQ5NXEwd2NRVzI1L2c3ZklzWnRtR2dMcTNs?=
 =?utf-8?B?Q3hYSGNlaEFLTmw5TUd6eWRJZ0QrRUdrWlZuTXpSOWRsQ1VnUVVOQ1cxc2pr?=
 =?utf-8?B?MzhwVUdNZkxDVllHN0JaQ2h5QWxTVU5iQStYRllPZFVZejlHOEgrRHFMWWNr?=
 =?utf-8?B?SHN0eUFURzdLa2kySW1wS3VNczNhQ2VUcnh0bm9iRGNaQVNuU21yU0xBUEZW?=
 =?utf-8?B?S1lBU0oyOXJiNFk0Q3p5UzR5RTZkQXpIWU9BUnpCTW1yYng1STkzRzF3T0Ju?=
 =?utf-8?B?cWJuMURwN3ArZHRkWTdMd3YrangrRDVVbksvMGtBRzN3bUVUc2JsekpZazZ1?=
 =?utf-8?B?U1lQeWR2bE5oN2p2bjdnUVA2Mnp5UUVEUFczb1I5MlRQRHNtV29TTWJpVGhB?=
 =?utf-8?B?MC9BaGQ4b0tOeEgybXh0eHRsQ0xqcHgyVVc1ZS9WREVIZEFDWVJRV1Vjczk0?=
 =?utf-8?B?bElVbFcyR3VTUHNyRzBEQTlvTFgzNVRyRXRwZ1RXVUVSQU1wMXZJQmJZYW1h?=
 =?utf-8?B?OWRVVUpjNENZN3JTZUI2U3JMRS80eS9vQmJldVdlZFVva0tqaFRBakNlWWxR?=
 =?utf-8?B?K21oSGJSbGpyM0NnRmRzRE04UEhFc2dWSExNeHVSZVEwWGlidXd1c1JNNGZq?=
 =?utf-8?B?Z1F1YjQvRklKQkUzVFJ5TGVqZStxenB6K0N4U2RWY2NLS2R2cWRhdU8yc1VG?=
 =?utf-8?B?WENSRVZPVzZ5SFB2Q3FPeGIyRFRSeEluWWQyN2YyUEpZc0tMbEVSdnZiazlF?=
 =?utf-8?B?Rk4vL05XN0p3M0ZHZXRZRDdDS1AzeHZmRlRvblNSOGMvTktoby94SndwZTlI?=
 =?utf-8?B?UWtNK3B3dlZSNk9vWUlBd0htZjRsZ3oyUWNIM0F2S1pOSk4wVk5lOTlia1JW?=
 =?utf-8?B?bU5tN0RxdE5waVVjZ2xwSks2dEpRclRSenZnSUNiRXRXY2hrSUhhbkVpbFAw?=
 =?utf-8?B?NndJZmtQMW5rSEoyTTB0Y3NubjZ0amhWai9hbW5lS09VaStZSWk1Zkdtcml0?=
 =?utf-8?B?WEJWMWhpS0RLWFgyOWR2NXordWdQZEt3MFJ3S1ZwbmxmNy8ramtBWXF2Yld3?=
 =?utf-8?B?MHd6bDhsY1l1ZHNoOGlFbWU5SVl2VUErVHN0U3Y0eEZrOVkyVG9DT0pUVytU?=
 =?utf-8?B?blYzWTg5WXpoRk1PMm8xTFh5RW00bkpOWEN3Mkg3TjJSb3NOT2hFQ3lwRDBS?=
 =?utf-8?B?NFJMMzV4R3RLcmFOQ1BBNTdsa3NEYVBMK296UFV3cTRJNUlTeXQ5Y01CaXAx?=
 =?utf-8?B?eVIxZCt4YjJ4MXZlcVZlTmFtRTBhNXVnUVNlZkoyVmtQVUp5WjBQU2tRdlF0?=
 =?utf-8?B?RlRYNGdVQjQzNmJjbStwM1hYQStnMng2NDNUS0lEMVh1T1NONVJWcjgzUzMv?=
 =?utf-8?B?Q2hBTGYzeDRaQ0M0T1VvdWdiL2F2STJOakx1a0l0MUl1WVR1dlo2azgzY1NS?=
 =?utf-8?B?VnVmREFFa1VMU3FLWVZRRUNNT3Znb3ZFU0w1ajBhZzRrQXZCMm52QWo4VW5O?=
 =?utf-8?B?dU5XQzByRDc5R0FUcWJlSHRDR05rR2V5ZHg3TmV6UHpPdkNGcmtCRDgxWUk2?=
 =?utf-8?B?Zm5sZ3prajlEeUppRXM2b0NIcWxsbnd5R1ZqV2ZIVFdmN250KzBlMTl0UGJW?=
 =?utf-8?Q?zDS15gr7E4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dktyR2RUb0JqSVRzZkdvZjJtUGx0Tm56NUNzNHRHb28zZEZURFRPTzZNYlFt?=
 =?utf-8?B?RmdYeGt6Q3pYTnN4UEx5cDZRUGUrdWYyemJ1amtLbmdhTG1nS1lSd29jY3pu?=
 =?utf-8?B?MlFsQ2FkMTc1Y3MwQkd6TUJWRS8vbVp3c0VqSEg5OCtGdTdENXNRTmVOcDNl?=
 =?utf-8?B?QkY3TE9ZQm1JWW1EYkh5OUdMSzR1SVJTanlQQk9BWmNmeGhzdGl3aGNCNXpy?=
 =?utf-8?B?cW1mcnZGUVNkaGJEbnBMK0RFYlFQVEhzVkxnbXduSG56NWJORFd1NkFPYldl?=
 =?utf-8?B?RVdpcE9LM2FyRTlyV09HaHlJNDVlcXRXK29CRDE4TjJYZGlXcm94WW1XdFRX?=
 =?utf-8?B?UGQrNHlaL1oyWDh0T0YrMlIzbXo2QW8xeEY5by84TmMxVm41LzRxWXRlLytP?=
 =?utf-8?B?OHdYRmJmYmYvTGFYUGJ6RGlJV29qZHNGS3pBTG1EZlpxZXhiUkVVdE5ra1ZP?=
 =?utf-8?B?LzkxSkVGbnRJRVdsS2g5VExtK3U1ZXdvL2F3M3BoTmxnZm00NU1ZTHlVYXM1?=
 =?utf-8?B?QWVIZmJzWjFsTDdjN1djVyt6TXlmT0V2elNaWUI1aExvS3FlZ0dMMWVGd1la?=
 =?utf-8?B?ZVpEQ2s4UlY1ZXZrMjhRQ1JDRXdWTzdXb0FTeDZVUUI3WjB0aldmWkFxTGJS?=
 =?utf-8?B?MVRkUjZmZElja2NuYVlESFpHQU9Kb044c2lHSGFrcVN0elVtQ1JibmFLbk1Q?=
 =?utf-8?B?eHA0bXpadU8remlCV2dLOXczTHJkenNmaWlJOG83QWY5alI4WlhWcC9jSHJJ?=
 =?utf-8?B?RW05enFlU3h0MTQxTVNjWE5CQWpLZVFrTHNDUVh0MEYzQ3hrRndxNnorR21X?=
 =?utf-8?B?UUhOblNkQ0ZDTzhVSnBrR0ZBZDlUNjc2ZHdSNzVUaTFVUDZCbGdyZVlncVRi?=
 =?utf-8?B?b3NkVytMN3MrTTBYVlA3T0RzVjhVR3BtR1IxaVNRenp5eEhseVBiTTdpVi82?=
 =?utf-8?B?aURMSUNKSzhPbHN6SW1tUUIwK1hiVDNjSG54NFFpTGJtZTcza2Z6aXVsd2hG?=
 =?utf-8?B?Vk5BQ1EwYVNpM0ZLaGRPNjhKaGlhNTdxTjdodUU0TWZ5S25WVGVQMnRkRUtV?=
 =?utf-8?B?U09sRUhLVUZVeEE1NWRkV0xHVjlvLzBXTUo5ZTBpWnlFNURYeXdrREJZM3JT?=
 =?utf-8?B?Nmk0aktOT2JJcy9oWWZlOFhXOUFiek9YV0hlTHJVSnNoSy9hVUQ2N2RseTlp?=
 =?utf-8?B?U003RDNMbkhscWpBZ0taMlBpZFFidDlxZ1lxT1VhK2d2b3paRk9vY1ZoaGlh?=
 =?utf-8?B?b21TbHgvWkQzL0x5c3UxUUFweXplVm1paWpNMjY3dzFDZ0E4KzZoTDBCdVp5?=
 =?utf-8?B?ZUJQWWZCYlFaMGVjQ1h0MGhISDM2ZTdKcDFFS2xWVG0yTHdoQyt6V1Nvdi9R?=
 =?utf-8?B?V2FmSXBaWGhWcnVNYnlXWkhGRVV4RUJuV2dhUXNiVDlaS2VDMzNUN0J1VHFj?=
 =?utf-8?B?dzBlYnB0K3pDNHBockcxYm1lWFZHZXl0OEtsWEloRUgraWYzdzJOVDhrbXdF?=
 =?utf-8?B?eHgwbnZzL0lCVjhXN2RIUTBBZi9nL0hpUkdnUHh3REV4NVJtS3IxejBxeGp3?=
 =?utf-8?B?UTQ4Y0huQWdHVEwwQ29PVVhiTExlNk1pajBLVGMrUjRQNFI1ZS9xanRoejAr?=
 =?utf-8?B?Wm5JRmlXSEgrNEtRbTZ3dS9XK0JEUllGaXA1c1BONFBnb0VVSFhFU1czd1pX?=
 =?utf-8?B?M1grR3lOT3JmSFVHTDFwZ2FBQ0JnekhFZ0Y5V3g2MGhsTEduVmtXeEQ5Q1pU?=
 =?utf-8?B?RUs3bUllRWpOaXFmMm15MjFabFRDK25TNFpWcXhyaHdyNUdpcFE5VDJjSnpX?=
 =?utf-8?B?TUxudEF6d3NKZU5hNGJ6QVdpODFHWnBrSGlJY3EvNG1hdEh2QmxrOFU3RVo0?=
 =?utf-8?B?L2MvaXBJdmdhVjlTU1h6djBZbmY3K0xzaFZkOHZ6Zm95aHlMNUp3dEpuMVFU?=
 =?utf-8?B?SFZLR1BBS0JBc1d4WEduSllDRDZRWnhjbVZtMUlyNC9OZVhDNlpOQkZEMlFm?=
 =?utf-8?B?NGgrRVE1WFZQZmR0RTZCeHh2aUJOTUhuaTZHQjhLejB0Y1grclhXQlFhWE1C?=
 =?utf-8?B?SlFNMzJPUXllcFZ6c0R2OFJtVVl0aXo2QjVhMVE2MXBqN3p4bUQrMzlWdjN5?=
 =?utf-8?Q?+wdk7bNB9M/Q/Mwyo2FMuXu/R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4faa8687-daab-45b9-c0ae-08dd96f3b95c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 16:39:29.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svOKAAKAYoxm4n+o7Pxuc4S/yGLXUskqxiu2TldggcsUUWzDIn0nIYm0a5YTM8JclRDwBWrKGAR9zGkJPIO7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

Hi Namhyung,

>>> If it needs a specific kernel, then the test needs to cope with that,
>>> etc.
>>
>> 1) Bunch of IBS kernel fixes went in recently (v6.15-rc1):
>>
>>    https://lore.kernel.org/r/20250115054438.1021-1-ravi.bangoria@amd.com
>>
>>    Since you are running on 6.14.5-300.fc42.x86_64, the failures are
>>    genuine and indicating that kernel should be fixed.
>>
>>    I'm wondering how would the test cope with the buggy kernel. Or
>>    probably 'perf test' a wrong place to put such selftests?
> 
> Maybe... some kernel internal changes can be tested in the selftest.
> 
> And 'perf test' should work with any kernel versions.  Is the test
> checking any invalid configs?  Probably then it should move to the
> selftest so that it can be tied to the fixed kernels and 'perf test'
> should only use valid configs.

Sure. I'll prepare a patch to move this test from 'perf test' to
tools/testing/selftest/.

Thanks,
Ravi
