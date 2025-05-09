Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021101.outbound.protection.outlook.com [40.107.192.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252428ECE9;
	Fri,  9 May 2025 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746793438; cv=fail; b=NsnTmldWUMu/X2pe8VLcghGPYRWRvbVCV0XUW76htgSEC7oJxmzmwo9SyMjcLV0a/fg42YNMz0rRsjoQfnI5KW6TZqb6dUHRuDfPavFAJbxWEseT842Bk8xZuT86UcuV+71J0c6nqP3d+jk2iJ3mZNtwwahBp6u58kQzdtEjZwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746793438; c=relaxed/simple;
	bh=bWnJ6iDCu1jKg6XIchDsVYlyBrOgpLU0si+4ckvc0nk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XeLWmFdcHR+Zv3PliyX6mJXLcNdJHMhe7JCt4L6yATydcl/jpfR0CNIM+/S5cOG0LSeZ0yGwxYDtfl9vrnC6P0hE+LlLiG5D93M3ChEVADIi5vRj1W2i20yxYL+8zuCfY4XQv5sNhOE8NI4ddh/1phvcxflW/hlOVNDvP+eAx+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ENfZKzbe; arc=fail smtp.client-ip=40.107.192.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ENfZKzbe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGKnBjB9C2SIn4OnQB6sdFcbOjIPoyhyfFkyleDo2DqCRkg2FmIZoFpOujLcJJusp8eE0nrQQ7Tlnyrw34/diAUODCaYIeW5Si7O0lwAmE7MJCZDZ8LDBD4QtzjfUpk7YDRkmwnLU+wm1EiDbLe4zdQpnUoOXfkNrT//W+vFkKmQIu3jpXQumdgFE81RXSnR85GtfY1iqjPEw0WKrca8z7m/CK6Warb0urSdhfVJaoD7aSTVEaYHeu9pwxUY2b+LB+ccuODu20meDF3iqw+AXbw7EBZhL26nnzUKKd/12zH7YDtzc/AnStDA7YsVVFxfvtQbWqN9eeqKrAH3sf1u8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wGYmimp7qd0JTIUq9UfCo1TRExZFkklUmiteqd03zQ=;
 b=jXJlyK5f2pvCCMmWZP/7cmOA6keynWCn2KDrT5Nk4DBWDnoj+uokhIENc5F9/z3vPPwlEIVkjY/nUPjdHITWhybHHSUtZ1XI++YIM1VnrsJz4mq6EOE8RP2GzoJRugK47iUvnAI5TDccKzIvxEc1rG9ZF0QVMJnhm65WqOowJHecQASTwGuv3eSV7GNUaURLor0ES1NFfTCNjS1JVcug81ZPnyVQ4/ajoxQO+8Ox2kj+FUS28f/rdqj2dnRctbMy/4h6cL8+vejPj/qcWz0buq2Oz5KAXc53TQAIbCoBPk8EPPfSJ+fBpgq66fmfKLS7f//5WfRTe9ETtfM+qGo/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wGYmimp7qd0JTIUq9UfCo1TRExZFkklUmiteqd03zQ=;
 b=ENfZKzbeHgxN87Lh925MoPc/JaZCpXDM2g9bEy+FulvHhvhkc7kyBCpAtzOaOqCcAT6UGV48lDGC65TLXr6frghVsHrh2MYoe3IT15KYo3yiMuxXjBJgm3VQPdrnLR5yEauyxj3nGwBW+gjKaM/xDzhWsknCiGs8tdWxdMUzxFMzMvjfiNFaEu5haUF8ZV5WyCoVgcb5xdbv8TSojLHovmWr9NCc28i2ekuzeY85Ive/c0PpL1XWBsdCtfw5tj6LfVGTkrrMobS1H3grKmPYz9m34ftYkJ1dVrK9GM0AdNOuHeWVqMeWlBDlEvcxLYZYkhjaCk2V02t3/CfbGETCPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10651.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 9 May
 2025 12:23:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 12:23:52 +0000
Message-ID: <8889c16b-9c3d-4ab3-b353-e00146532174@efficios.com>
Date: Fri, 9 May 2025 08:23:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, "Jose E. Marchesi"
 <jemarch@gnu.org>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.390748816@goodmis.org>
 <20250508120321.20677bc6@gandalf.local.home>
 <89c62296-fbe4-4d9d-a2ec-19c4ca0c14b2@efficios.com>
 <20250508145439.4c6482b7@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250508145439.4c6482b7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10651:EE_
X-MS-Office365-Filtering-Correlation-Id: 9133d812-40cc-4e44-700b-08dd8ef45b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3RKOU44SC9PbnNLQ0JlN1MrNlhYbHd2L2RlTzJZa29TMHRRaXVqSnlDRmUz?=
 =?utf-8?B?UFY2OTY3MHhpQ3BwK0NtTnpTdERxWXRVR3VKTE1PM3JBQWlzN0JyMFNpYnB1?=
 =?utf-8?B?N3htUHBDTzcyT0taM3RnNGk0M2NLMTdqcmNDSlNGWVplUXpWOVU1UHRLUmdp?=
 =?utf-8?B?Z1p4WEl3aHFnbkVBVWgzNzlLc3VjejhEVHBDaS9iOVBGdjFvU2pQMHEyVFla?=
 =?utf-8?B?ckp2bm5qaElHdy9IOEZIQ1FwWXhZNzViY3F3aUxUUlVXd0NGY0hkOS9ieVNj?=
 =?utf-8?B?bU9yRmo3ZmZCc2JEVEpwQUlIRUFpZU05bXVOdURmZTJBd2R0dEtVbGtPMUhI?=
 =?utf-8?B?b25FelFnRCtjU2tzOW1HcXE3eDE4d1VIbHB6R2wwM2ZGTkw5aTZ2ajlsOGpw?=
 =?utf-8?B?MUtJRmx3d2F3MDRCLzdGS2dJZmY1dEFnVittUDkvK0JmWCtqQXlJVVJwQ1Jj?=
 =?utf-8?B?elRnaWZuSnpMTjU5Yng0ZEI1cnV3Ti9QS1MyVmF4ekd6U0w3bytlQ0FJSFdh?=
 =?utf-8?B?TGZTaUN5TEtUVUtiS29JVWhET3E4cEZHci9kOENrRE90blJrS0VYZlYvQ0Ny?=
 =?utf-8?B?MVh2dEZzVkpEeFBMc1VTZzdJNjQzcUFPd2c1czNJSlFVbEZKY25RQWhpaThq?=
 =?utf-8?B?UEVobU8rVHFDeUdrZ241L0RIN2EvOU40U2JvcEU3S3l6RmEyczZYd0tESVB2?=
 =?utf-8?B?ZUorVjY2STJuanNVbGZJdENqRXZlbEJKMDJwaWg4QzRORkd3Nk4yWU1QVzk0?=
 =?utf-8?B?S09TMUZpanY5eU1ubERzVGV0U0wwVnJJcFZOY0duMmZtRGZTR0MwcndLZHNQ?=
 =?utf-8?B?eHY0Nml1VUY3cWRzNlVXSlloN05iSEhVbFpxRDFtWG5DNzdrLzQ2T1lOenVz?=
 =?utf-8?B?UGhZSHpRQis3WERHSFMvbnl0KzdIOGFvRk1MOWdMRktvL0FyZUlMSDh6UVZF?=
 =?utf-8?B?c05rQUhnSFRSZzRYOG10VElzdGJGRzUyR2xjdUJRaGUwL0FiL3lLQU9kaENB?=
 =?utf-8?B?a2xkUkNsQTJpdkhGRXlscWxxbTA5aDZJQzhLWGc4VGQyOS9OWkNOdEFOTGsr?=
 =?utf-8?B?UjZZZkxEUm9FZUpUMEprVHA4SHo1UTVKVzVmbElvMG5MUHc5aHpIQWZ6a0Q0?=
 =?utf-8?B?ZXIyeXduOGEzODVoZmxqaVN5VGF6SzZxTEw5RlpZRE5Qa0RMLzh3cVFjdmcz?=
 =?utf-8?B?SUtWeStGU2FoRWwvWjlpUDdtKzh4WFRoK3VVUUU0SlVMZFRGWEVYMDQ0NUhQ?=
 =?utf-8?B?VkVXZFVhek5Xa3lnNVRDb01SWE44TG1PMXNKdW1oUE9QL3NvWFp3VEFmRVll?=
 =?utf-8?B?Y3gvRi9DemR0RENxYzNUWEt1cXhUdzNudUlsWVRHYnFXQ1d2Z21TQnA2SHJ5?=
 =?utf-8?B?eTBQc21RcmxvQ1hsVVltallKdmREZXRucDkzMENDT1Uyak1JT0lBU2dEU1Y2?=
 =?utf-8?B?aEU5Z3NXb3hFcXZlWUVHNmxYM0hDdStBVEwzRlhlN1M2U3dyVHFtOVFEUm5a?=
 =?utf-8?B?dS9VN2xTYU9SR0ljSVYyajc0WTdsbzNBWGg3cXFBbzVqSmJ1NXoreHk1dlFq?=
 =?utf-8?B?aUF5S09uN1UxVitITnNyTVd2aUxZdVh2NUFoUGlWeEdSbWJCQnZDdWJzN3hT?=
 =?utf-8?B?WHNRVm50QitUVUhqSldLME0rN1VEZEd1U2U5aWxrdW8xeTRtN3dCVlpWM3Rj?=
 =?utf-8?B?YlBISDlBbzdZakYyMHo2dFpTY0pXd1hhQmFhZWUxcjVFUnhDUzNsSDVCblRw?=
 =?utf-8?B?V2IrdzRoRUVWRVNCczk2QnV0ZjZQdG5jTGZNeEx2SzdmNmxxTGdQbDZhYUJ2?=
 =?utf-8?Q?6CpnsXlVmk8+RAGHpyEadrCZ9o934TGfnNRIk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUFEYXhZRzZRd1d0V0pySjJVQ1BlYTU2dGNlUnVFWnBDZ2pySElUV2V5Sldw?=
 =?utf-8?B?R2ZRd1c4ak16c2puOXBVUlNyUnNKUlhsV2piNkZJSTRJbXJVWnpqVHpsTHJQ?=
 =?utf-8?B?WGJsYmE0MjdkRmMwek8wMk1LeWFOM2R3Smk4Qk9BYVNRWXU1MnBIKzFRQlFM?=
 =?utf-8?B?K3hRekNKMDlZYVdPdWpCc043N2NsV25la0p2ZDZYdE43WVlUOVhCUjZHSWJM?=
 =?utf-8?B?MU54Rk1KZCtMVml0cEpaemlUYnovSTMzcUpycjVWLzA3TTV3VkVOQjJFakF6?=
 =?utf-8?B?VGlNWVJGVlpTQk5UWEVVYlpJNHBleU9ESVl0clR4aEJxTFhwNVhscVM5TDVj?=
 =?utf-8?B?R0FYVU9MODZvYnR5cXBpMFYzSG51ckJBeGlyYnhWWTVrQ1cxaHVXbzFiVFBN?=
 =?utf-8?B?bDVKdkt1Y1B0NUtuZ3dpM05vQ3g0M21pSEU1UGtKQXc2OUtSbFgwRlNFeXIz?=
 =?utf-8?B?ZnF3Lyt6YVlRdDlLYnZFOEFkQXkvUzJYdWhDeEpocVVXdU8wMnF4R1owak5O?=
 =?utf-8?B?U29zbnROaUkxazd2cFZSRTdkbnAyaHBJdU5nditDOXc3VVpKaEcvVTFoMFdR?=
 =?utf-8?B?V3JPc3hoZDdac1lFU3NYSmJ4VkhYOWc1QjFkYWE0SzFjWFA2S3BqK1pUK0tN?=
 =?utf-8?B?eEl4N3FQMjVvZkZabUcrR3A5MG1SZlBWM1dmRmZ0WmVZejFhZWpVYjVGVGlK?=
 =?utf-8?B?Uyt2ZXkvUVdqaGFBcnp4eWZFbExLWXlYNVdUM1F0S1RnWnFSSytYY1IvSmEz?=
 =?utf-8?B?VkhOYUxpMDhNVm5ySHA2ekYyMkR1cjlQSzkvaHhxMEh5NDlJaXlYLzhYM2k3?=
 =?utf-8?B?WWx1YlZhZC9qZUxaVWt4SWthNW1uK3l5dmprLzB2ek1qekZPZnZiSVoyVXJr?=
 =?utf-8?B?SkV1U2lCWndxcHVvWEdNYUtCSjlxaURlcy85d2VPUExrZG5iaDN3VktpUmZC?=
 =?utf-8?B?VUNMNml4NUg3ZCsvai9uVHZlbmhzTUdiMCtXcHd1SDVZN0tieTh0OGdWTnlO?=
 =?utf-8?B?YUwySnlxa3BsNnI5ZDQva2RQNk1WRUMybVVaM0xGVEpsdFUvcFJmQk1tQ3ZH?=
 =?utf-8?B?c3pFNFQvMUYyVXovSko0Y1BsYS92SjV5QVJiQTBQUTc3UVNnQ3ptbjFtUGti?=
 =?utf-8?B?NHNkSkpBUE9yclBDYlQ2NW1ENjZMenJaWENqbEgwTGdhbjI4eDI0NVFXbHZq?=
 =?utf-8?B?amNzSHdMYVMwbEt0OE45USs5blZCbTZib1NjcHlMSmVtWkRqQXlSRXJyT0tK?=
 =?utf-8?B?aGtiT0o0K3o5S3d2WWYxN0Y4YWp0Qks5RTRsdWc2QzBWS25HN2svQW1pa3I0?=
 =?utf-8?B?ZnQzYUtKRjhmOVBiTFF3WGtsK3VNMW5mQ21iWVJTcHBWcGorSkNsRXE2TjNn?=
 =?utf-8?B?cFFMb1ZTUkJqeGxRbGtGdWpvS2tWUWxRbVJ2VVBwWFZLaDlHczU1UmVLbHBG?=
 =?utf-8?B?QmI1SUV0SFBaWHpLVWMreUpRa0RFUGk3SmpFdWo5U0d4UEhLYUc2RlVubFUz?=
 =?utf-8?B?djhqdEpUNUh2VW5zNUk5UUVlNW9NbzcvdlVpZ3BOS3FYYnRmUWJLUWFoLzNN?=
 =?utf-8?B?dUoxdzZadDROVlZXdWgwcGgvZi85RVlRdTNKNW9Nbmt3cTliM21PVXhNeEhJ?=
 =?utf-8?B?bGdydCtyU0RBQVhRTmpyZE54b3FxdVJJRTFHY3hncnRESC9ZOFhpMHFQZU5G?=
 =?utf-8?B?RE1nWDVKRTB2R2YvVlBVMndEMjZYQm53QXlDcEJvcHdzT2JrajdTSFF2b0x2?=
 =?utf-8?B?c2ZWUTV0TDlGVnJVS2ljUkF4cnJTTXBuTjZHTU9ON1dHZ1h6SStQakhDbktT?=
 =?utf-8?B?L1RnOUFDdHliRmwvaW1kZENCeXRtSisycEFBZEdRZUZEUjNnSkc1YksxMFkw?=
 =?utf-8?B?a25nbFAwNnZPSDh5eC9ZSHkxT1ltblB2amFTYXJDWFFiajhSSjUrK21oa1VI?=
 =?utf-8?B?bk9tRExOWVNYYWNFdEcrSS85bEFVZ29mL0tQTXY3MnBtM1F4QzVxMzRqdW9w?=
 =?utf-8?B?RTlDdW9aNHUvMHdmWEJIY283Y1JTVEIwTjd3N3FXSWFwV25SR2ZTbks1Z29T?=
 =?utf-8?B?anU1ZUtyYXBWeVNDcEtET1lXRnZHaUpVNEsycUtYaEl3ak9zUkJTWGZGdU5N?=
 =?utf-8?B?d3dDQ0U2R0tycDFhQ1k2VnRLLzNVUTV6MWVvMmUzNmJPT2U1enRUUjZkQ3FZ?=
 =?utf-8?B?R29xdTZ5M01XV0VQNngrd2p1aEo0VmJHTTMyMElUdjR3bGpkbGh6NHZ6NXI3?=
 =?utf-8?Q?Y8nU4mAFE/pzj+aljRrAGDS4Uwv2BPGEEfLkua7C8M=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9133d812-40cc-4e44-700b-08dd8ef45b9a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:23:51.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkpjUCuqVGUI4/1zKNavwUJ5/Mixpib35n1GIY6zwpM08QMl2oOAinfBVqFuCUb6gpXoyFpPyu9zt+/MLVpMQzA++cKtYNiCMI26PVBCsqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10651

On 2025-05-08 14:54, Steven Rostedt wrote:
> On Thu, 8 May 2025 14:49:59 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> AFAIR, the cookie method generates the cookie by combining the cpu
>> number with a per-cpu count.
>>
>> This ensures that there are not two cookies emitted at the same time
>> from two CPUs that have the same value by accident.
>>
>> How would the timestamp method prevent this ?
> 
> Do we care? It only needs to be unique per pid doesn't it?

Is it possible to have many threads writing into the same
ring buffer in that scenario ? Are all event records stamped
with their associated PID ? As long as we have enough information
to know which thread was associated with the timestamp cookie
on both ends (request for callchain and saving the user callchain
on return to userspace), we should be OK.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
