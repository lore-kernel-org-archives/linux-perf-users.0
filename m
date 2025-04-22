Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078AD10A3E
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305317; cv=fail; b=C4FVNTvTmrJXZd/M4UdJM8lHVWRQAb3mciJBbjM1RwbMtUr7zvs+HZbPcsLgzuK2w1Pp6JYTTMNpV3SxvLw5NK5UHfFAD13b13ioBVzNU94KUxQuTMo/87w/AElNQ64HynTl1PYFWzbRTho2VCpe93d5SN1hFoujyi5bPIB9V30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305317; c=relaxed/simple;
	bh=1G5giILNjLYkeKUbfFtNgg4vCU9e8RGSdvxwvzxYAuA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XeZTqhvdsFZzadL3CXh4I5C0STWuEdiaHmpWMJKzRosp2ZcFZlDw9Qlk+zJl6Q0C6tqekXYxkoFqwEvas9uq3sqAo7Bkl7/1/juuAy7SI0BEjQ/NO+QBtZekfizAK8xkZVTM7MHu5VSVPSPNvTXnpp2pPsuIV81tS9y8718ZlHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYK1WQfZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYK1WQfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745305316; x=1776841316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1G5giILNjLYkeKUbfFtNgg4vCU9e8RGSdvxwvzxYAuA=;
  b=fYK1WQfZfNAGGgsdNkHVWhDLAyqma/kqL5oNdxsacpdbXDK19Hi+YDa4
   hWVWOf+wzjqsAttUCRLaCOO1+ZoWYRxxUhl7XBUdX1/3GrWXR11dRh8BG
   gEfkV5QuUNYDwM7gWjEXsY35b7KWG+WBLpkgSAy8hei8txwtd8dfbRyM9
   uYhOGLufKXOGl3rRHpzmiTVk1vBz5+I88y4XnxM1jZJd8DaS5hk/ro+04
   P0fw3WGpR61tp3eg1dsQjAUg5aANemGPqXbkeuXPqGxSRvBuz6Vv2LxMt
   Y+Jh6yWg59tpL8grR6P6DkMS1lwOXR5yq2HXwCzkn/KMBVXVcZezFEJe9
   g==;
X-CSE-ConnectionGUID: 6J8kbd9vTG2ZDWebR35njw==
X-CSE-MsgGUID: voy36DuoRLq1eZlqlWbfdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46737909"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="46737909"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 00:01:55 -0700
X-CSE-ConnectionGUID: E2Wu4owoQTy0/tGu3EgqIA==
X-CSE-MsgGUID: iCfXOgCpQmKtnF/v6N8miA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="132809475"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 00:01:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 00:01:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 00:01:51 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 00:01:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plRR3sztSu0l+XLnpfk4FxNcDjEbG8B945SQrdTy3Hxn3VuTervHvc3+XjybBYFZ1WxIzpG4fN63bvmY5KrnrpezM0ACeO3x5BNNpc55PonCrSgn+FF4dvT+LShXIE9t2KjpzEH/9y4zng/KQJ4syM44xghGeXRuShfgciXlpCxdUsrp/qS7XB8l+hazh50vKdi4s+UWvecuszO+ZEe1wqJjq4oLV/y3SVCXg7WFBbnCw2CdqSjEw65nQkKwzUHCkb28sOBd+Ju0jBRTd89Q/6tF8SKaFgTMB8RociF6Y1Ktzfg2orURZexFYdCKxjKjbUT13Wr0O+8xWxl7agh4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR6aJ2cwY2ei8z/XwHHdXuQmudhuz6CDD+wdeR/4olk=;
 b=HsvkjyOcWIro5Y1SJQCmrFipH9CxBIVNvaWnzIYh74Tv7eTbp6CgVmQv1KzCtOMaZzJ8AyW+HcNsUWdPvfb3WodcQa//D2GeVCX5psxjUCfmLXGip16i5ZfDSjXdpWWXvtyg2BLOSfsiSDEyX5zbuD1pZx2VitXu5xiDSIPGMo5USbdRROb3DOVOkAtTmh+JsnCYgiBMMX5xsxRtVxi8Y7ha0sk7BgKk93ReCOXq3F2WFmbcgF+J+B+XpedB8R16hva/U2+tfOOspX/rqP0CJyBb6J6rXaKTqpXcGlm092SgDqXIUgAm0Q+titt5UPhCSql+jlupJshHYnWQAqWcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by CH2PR11MB8833.namprd11.prod.outlook.com (2603:10b6:610:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 07:01:18 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 07:01:18 +0000
Message-ID: <96a851a7-d110-4585-ae8a-410de5da72f1@intel.com>
Date: Tue, 22 Apr 2025 10:01:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf script: perf script tests fails with segfault
To: Aditya Bodkhe <adityab1@linux.ibm.com>, <linux-perf-users@vger.kernel.org>
CC: Disha Goel <disgoel@linux.ibm.com>, Aditya Bodkhe
	<aditya.b1@linux.ibm.com>
References: <20250421092559.75109-1-adityab1@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250421092559.75109-1-adityab1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::22) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|CH2PR11MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b10b0d-8012-4cf0-c24a-08dd816b7b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWpjRUd0TUxHQi9uME1oTFV3dGpBTTdWTjBBWXFMSnVZcGwwbTF3Umg1V1hv?=
 =?utf-8?B?OWVES1NIWlVpcHRsZVJYWDJCNEl4ZVJ3aFNaRTFxUFlNdkRtbzRkSllhOVRR?=
 =?utf-8?B?QWVCUGVtUkFlUGc2dTdUN212WEMxQTB6NSttMnR4REFFVnRyK3E4dEpvNlYr?=
 =?utf-8?B?OVp0U3hQUlhZWEJ3U0hTckpVYlhjZmJtcERvMVNFdzNkanZvUzhIL2ZEWlZX?=
 =?utf-8?B?SWUwLy9tbWRjWWMvd2RqTGE1UVgybWJyOC9zbiswS04zaGQ0YzdTK3lJME84?=
 =?utf-8?B?VzZrUnZHeXNVSnkzSjRTaCtUVEhGb0psQ0NlcS9uNDhvb3ByVnh3YWloUHZI?=
 =?utf-8?B?NWs1cXZrL1VUb1pjL2R5dkk1b1NUR2JTUVJTaWI0TCtlV3BZWGN4UG1hTjZt?=
 =?utf-8?B?Sk1EL0duUFBjb0IwSWZIVytWenZUREc3TzdJUXhlUkt6ZjM0WTVmQ3J5VFE3?=
 =?utf-8?B?OTlTOXpPb2x6cmN3QUkvcVlNZ3FMeFRTSHY3TFRiRU9Memc5bEszOFZaRmNq?=
 =?utf-8?B?RFVsbThtaUx3NlRqRjhEU01yL0pEb2cxUVpKY01PZ2hqRHQwNWEwZ0F2cHFr?=
 =?utf-8?B?RFBOb0o1VGwvS0F3cC9GWmV5UUpmVSs2NEtFTk9KSHBrbzU4anladi94R0kw?=
 =?utf-8?B?SjdDakhJOWh4bkNubXU4dUhNcDdXZG1adkM4ZWp5dzRCVCtBc3RxVktEemZS?=
 =?utf-8?B?RTQrOHJVRTMxbGpaTHJ1NFhIcmJUalk1RS9FcFlCTlpQZlZZaVFpa2w5aCtv?=
 =?utf-8?B?MVV4RFJBdTJhK2Roa1dhbGp3RnR1SHZ1UWhOTURKdmMzTjlzOGZQa1djMUtS?=
 =?utf-8?B?Yk4wQnBNS3hLZHFIakJ3NlJNVHlpSzA2WmJ0TUZNZFFzRHN4TVN2UEhIUkkx?=
 =?utf-8?B?QTRqMTVOYnlITGxrVGZTMjhDei9ZUEw4VkF1TXhvOHFYME5LS0wzckk5QXNl?=
 =?utf-8?B?c0V2b3hZcEs3cEwwaEpORG1WZ2ZQakxDams2TWVKWTFjVVFXYWF2V00vK2lP?=
 =?utf-8?B?MVo0MVphbEhzRXJrWkdicUVuMUtIZU0wbXN4WFlwNG1hVGlWL0p1ZFdrYWhM?=
 =?utf-8?B?dWdaZ0FveWU1YnJzMUZQSWdQNWk2QjZFYUhadXhwL3lEcGdqTERncnY2R0U2?=
 =?utf-8?B?V3d5Z2NwaGF0YmhZNWFBcFNuV1F3bmZoeEEvWW5QTGgxb2ZLSi9TUGZGN25w?=
 =?utf-8?B?Q211c2p1UTRLVUJTUnVMK3RSZjVHNDB2d0xrZm1aR1VLODhYR0tadVlTZ2ZH?=
 =?utf-8?B?S3gxNEJ2Q0xFbGtVV2FsbUpKUmRBQUw5VGJ4UWZKTmxQakZZdGJLZ1F2Qk5x?=
 =?utf-8?B?STZRV1Qrak8weVVZL1hNT2dkNkJkWjJsSy9nN01QRXFlRlZZN0NpdkM2YW40?=
 =?utf-8?B?S1lmRXIvSlF6Wml5N3lURDB1aHJpK21UYVlpcm0rOTRLMnc4OG9EVW1VTTIz?=
 =?utf-8?B?bm5mRStHTG1tVkJxL2paOERoZUxzalY2RzN0TDFiTFAwNDlwODVlblMrUTlz?=
 =?utf-8?B?eFk0MDd6QWo0bi9welpELzdTWVIvTUJRM1VPazUyamhWTlBtT0tGc0xualBl?=
 =?utf-8?B?bkEySXkxNSt0SkkrcjlwTHpuSEY2ajBKZHA2VVNnNFNqUXhzWkhXaCtTOGJR?=
 =?utf-8?B?OUNpUk1LSkwwcG9BOVlEOE16cjFXTG1FTFBmZm5FL0ZPZmVkYVJVdlhpbUhz?=
 =?utf-8?B?RlRUSTNFbUFXUzdJZXVHcmdrLzFsZTBIUHZxS3g5YnhjNUQvMkpTVjdKNWxI?=
 =?utf-8?B?cnBrOEMyd1BvdWd6eFJ1c2hteUh0UTVtQnBNNmhnYzE1VEtUdFZHYmppcU1m?=
 =?utf-8?B?dEFiaGVubGhWMTFMR0c0T2FweGJrbnhMZXpmcUFrL2hJaVBEVmc2cFpjcE9y?=
 =?utf-8?B?WXFCcmJvcXVGTjZ4blJMQUROdDM3T09JOTErcmlsQ215QkJURlJ3cjZ5eUIz?=
 =?utf-8?Q?+YiSEHGRmmg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2pud1FzbmM2ZXk3eVZCZEFvZytjb1htOUZmaXowS3JsSTUzdjBkTzBjbEdl?=
 =?utf-8?B?cnl4MGtPRlZ5Z2Y1NmFEQk1iQ2h2MG5lTkxWWTdtNEg2V3lmTWlzWnpGRTFM?=
 =?utf-8?B?UWVhWXM4UXlDNUhQdVEvUGIrcWNwRjBqMTNhK21TNnhJYW50WDZoRm5uR3dK?=
 =?utf-8?B?eEpweEtLalRWZ0xDMGo4clRZMkYyV1VDaHI0bGRENUY1dE5kcm05WS8xRXRL?=
 =?utf-8?B?Si9aUUZZZHhzbmFkM1VLanFzN2VWdHZUMzg0ZVpTQW1FbUM5Q1BFbStCZ3hy?=
 =?utf-8?B?bDAvaGM5QVV2a3ZsK0M5b1hiWXZYanRRcm5KMEx1dFpETGFPQ2VHSVRKb1Aw?=
 =?utf-8?B?aHNuclJOUHZsTE5aTkpFcGRxa3NmOWxPekVMR0N2S096V0ZwSkRoNEJYNGx5?=
 =?utf-8?B?cHljTnpubjZBYUtydUlHNDFYM042WUhpcUFaUjBVTTl2OW9OU3puSUt3R0FU?=
 =?utf-8?B?SE1MaVJwaEhSb0svTWdybkVNZWtQNWppUC9tYTJGRUhxa2Fob3hHTC9NTDBL?=
 =?utf-8?B?ZE9lamJicVB4WTdNakt0NGhaanU5NWFUcnhUSkZIaVdTK1JkaTB6WEw3Y0pV?=
 =?utf-8?B?Z0xJTzg5QlVReTcyUGtKbUU5LzBsL0QzaTR0RGh0T0RDMDA0aS92WVJOaWhS?=
 =?utf-8?B?aHJTTit2M3MvSmUzUDJ5WXFqV1pmdStmZWJxREl6a01sQUdvazRYd1RHT0tz?=
 =?utf-8?B?R2M3QVIrUG5wcGFCeFhVVUMvbmlKZG04OVIrSU4xUkkrdUVxMjY1VFhRT3Z6?=
 =?utf-8?B?RXNtQXhhdzB1Y2Q3WEVTU0lHdkdrZzZGdk1UM256TTZnaEpySmw3alpvL0dD?=
 =?utf-8?B?QjNXMW1mQ2dKcGhIMTlpOW41V1dnWmlnVjFYL1hxeWVObVB1WlA0VUFETG8w?=
 =?utf-8?B?ZjlpQ1AxMURxbWdnejNyRHJWc0ErWTlmMFRYQ0czd3hUOWVHRms5WnNuUnlu?=
 =?utf-8?B?N2l3VE9OelduODk5aXJpTVdaN3IrUDlqU2h3UXA5UFNvbW5DNDNNZU9jMGNG?=
 =?utf-8?B?bmpaMjdpMW42ZExxNnFlR1crZlJITUNTdzdPV2FXRk5RS1ZSc05HeUJrQldh?=
 =?utf-8?B?REJrbkZhL1Q2ck5tbElzMWNpZnhRd1loWjZ1ZlJGUjAraXFxZkxHVHZpd2Iv?=
 =?utf-8?B?S3NzOTlhdU0zTXpCbzIxcjFjOGhEYXQ5UGxjMmtuOG9tMGhzWUdZWjVzVE83?=
 =?utf-8?B?SHhMSTFUcDcxamlzalRIeGtWcExCUitkWC9VWXNFazdmVmErbFc0Vmo1b1Jh?=
 =?utf-8?B?dXBNMmhPU2NXOHE3UTNWTzQ5N1p0VXZvVnp3b3NQN09DSUtGVG91ZUdnRU1v?=
 =?utf-8?B?YzRQS2NBNndVY2o2VGErV3dic1B3OVoweGRmbWNmV3MvQUFBQW8ya0NlTlFu?=
 =?utf-8?B?WXZJdHowRHBXWVRZTjQyMTRadFNlekJvR1dUeWYxSFdIMzJJN2xzRm0xK0cw?=
 =?utf-8?B?OVJWaW9TZ0ZaTnFWd2hYVFNaemhwYkVTazAwblZuS3ZJWkpGYVZ2WFdyR2Nh?=
 =?utf-8?B?dEhIbC9qNnlRNG5ZNWpGbG1XVkNEVURNTDNXTzdpZ3lFVUNoMzN1MkxMYnc5?=
 =?utf-8?B?aU1sSks5eHVGa3J5bkwvNThNNXJyK0xxNlM4MXVUSGhwODErdUpXZHB3eTNj?=
 =?utf-8?B?ZnFCZUJoMHNYbWlWUzhmSHJxRjZQcTlHSFVyclFDR0xOcUgxSE1RMEtBOUFl?=
 =?utf-8?B?U29ESi9LSitHVWJKN0VTTkhrUGlvSTd4TXZPZmZ0czEvZEJac2NCMjJMblFD?=
 =?utf-8?B?MXQxY1ZqOFg3UnZsMjZnY2d5aHh6T0hDVmYwcVcyVWxGeE1MakdBS0IxdzI5?=
 =?utf-8?B?SnlDVm5YcVlTdUk4d1lHanVzYmxGYmoxcVZtNHo4M1c2cjdrbFg2cUloMGtJ?=
 =?utf-8?B?SWZpdEpGODA3SWZzK2ZpNEFYUjhzU2lsc0ZtZ3pIQ0liSlFQSE1pZGpvcEFx?=
 =?utf-8?B?QmVzR3E5Tk54VlJiTDNaeGQvdnR1eE1DZndRUEJUdXdnQm4xTE5mSitmdWxN?=
 =?utf-8?B?VFlFUDlCMzdualFRMzF1TGRPUm8wOFJodk1sZll0TUJ0dExveDdRdERVQUx4?=
 =?utf-8?B?T29nbGlTN1RDV3huQ1daTVdORURKM1dPR2hYamY4VTFtOGdoQWVXVUtBd2pJ?=
 =?utf-8?B?cjBHSFZqWWdQWHZDVGREc1dwNDRLdVA3QSs0Ky9PSHI4S0pRS2dzbDN2a1hw?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b10b0d-8012-4cf0-c24a-08dd816b7b0b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 07:01:18.5061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbnL7icte2vsNe4oQt9RuwQ/41APcN8WCx5hLVOQP132CHZfeoahMJ/caOKlrcogdnLR1pCOAkt0n5vVYIMPyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8833
X-OriginatorOrg: intel.com

On 21/04/25 12:25, Aditya Bodkhe wrote:
> perf script: pert script tests fails with segmentation fault as below:
> 
>  92: perf script tests:
> --- start ---

Using --- here and below messes up the commit message
e.g. when applied with git am
Needs to be prefixed by at least 1 space

> test child forked, pid 103769
> DB test
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.012 MB /tmp/perf-test-script.7rbftEpOzX/perf.data (9 samples) ]
> /usr/libexec/perf-core/tests/shell/script.sh: line 35: 103780 Segmentation fault      (core dumped) perf script -i "${perfdatafile}" -s "${db_test}"
> --- Cleaning up ---

Ditto

> ---- end(-1) ----

Ditto

> 	92: perf script tests                                               : FAILED!
> 
> Backtrace pointed to :
> 	#0  0x0000000010247dd0 in maps.machine ()
> 	#1  0x00000000101d178c in db_export.sample ()
> 	#2  0x00000000103412c8 in python_process_event ()
> 	#3  0x000000001004eb28 in process_sample_event ()
> 	#4  0x000000001024fcd0 in machines.deliver_event ()
> 	#5  0x000000001025005c in perf_session.deliver_event ()
> 	#6  0x00000000102568b0 in __ordered_events__flush.part.0 ()
> 	#7  0x0000000010251618 in perf_session.process_events ()
> 	#8  0x0000000010053620 in cmd_script ()
> 	#9  0x00000000100b5a28 in run_builtin ()
> 	#10 0x00000000100b5f94 in handle_internal_command ()
> 	#11 0x0000000010011114 in main ()
> 
> Further investigation reveals that this occurs in the `perf script tests`,
> because it uses `db_test.py` script. This script sets `perf_db_export_mode = True`.
> 
> With `perf_db_export_mode` enabled, if a sample originates from a hypervisor,
> perf doesn't set maps for "[H]" sample in the code. Consequently, `al->maps` remains NULL
> when `maps__machine(al->maps)` is called from `db_export__sample`.
> 
> As al->maps can be NULL in case of Hypervisor samples , use thread->maps
> because even for Hypervisor sample, machine should exist.
> If we don't have machine for some reason, return -1 to avoid segmentation fault.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>

With --- fixes:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog:
> v1 -> v2:
> The below patch contains changes suggested by Adrian Hunter<adrian.hunter@intel.com> to handle the segmentation fault ,
> as well as initialisation of al.thread
> 
>  tools/perf/util/db-export.c                           | 11 ++++++++---
>  .../perf/util/scripting-engines/trace-event-python.c  |  2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index 50f916374d87..8f52e8cefcf3 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
> @@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
>  	if (al->map) {
>  		struct dso *dso = map__dso(al->map);
> 
> -		err = db_export__dso(dbe, dso, maps__machine(al->maps));
> +		err = db_export__dso(dbe, dso, maps__machine(thread__maps(al->thread)));
>  		if (err)
>  			return err;
>  		*dso_db_id = dso__db_id(dso);
> @@ -256,6 +256,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
>  		al.map = map__get(node->ms.map);
>  		al.maps = maps__get(thread__maps(thread));
>  		al.addr = node->ip;
> +		al.thread = thread__get(thread);
> 
>  		if (al.map && !al.sym)
>  			al.sym = dso__find_symbol(map__dso(al.map), al.addr);
> @@ -358,14 +359,18 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
>  	};
>  	struct thread *main_thread;
>  	struct comm *comm = NULL;
> -	struct machine *machine;
> +	struct machine *machine = NULL;
>  	int err;
> 
> +	if (thread__maps(thread))
> +		machine = maps__machine(thread__maps(thread));
> +	if (!machine)
> +		return -1;
> +
>  	err = db_export__evsel(dbe, evsel);
>  	if (err)
>  		return err;
> 
> -	machine = maps__machine(al->maps);
>  	err = db_export__machine(dbe, machine);
>  	if (err)
>  		return err;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 520729e78965..00f2c6c5114d 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1306,7 +1306,7 @@ static void python_export_sample_table(struct db_export *dbe,
> 
>  	tuple_set_d64(t, 0, es->db_id);
>  	tuple_set_d64(t, 1, es->evsel->db_id);
> -	tuple_set_d64(t, 2, maps__machine(es->al->maps)->db_id);
> +	tuple_set_d64(t, 2, maps__machine(thread__maps(es->al->thread))->db_id);
>  	tuple_set_d64(t, 3, thread__db_id(es->al->thread));
>  	tuple_set_d64(t, 4, es->comm_db_id);
>  	tuple_set_d64(t, 5, es->dso_db_id);
> --
> 2.43.0
> 

