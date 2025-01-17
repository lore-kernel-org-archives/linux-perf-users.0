Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF201917E4
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138686; cv=fail; b=lTNOtrM3NWR08alSwPTNuEjO7/qUXtvaw4uHm0IooEgPhIdt4muspdZX3MhnjAGZ8YeOIw0zz5eOiN+gHmT/x7xU+QncrhzAhzoRSeoJM2GFnNrpv4lRyjNMNjixppZJuP/TMXIY1XUoXWidU3nmwyfBhjQyO2Xt2zsZjuv2sjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138686; c=relaxed/simple;
	bh=iWyy50TkQDcwxOjeZ3gUFVYd+TOnXCHg08f76e2cpak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M71LXms7BVBeXrZWNaE2sYafSSCXpvgxgXhDi25W62FvavgZtx940nPJ6L7BypFY/zyL8ou7rmNT/s1zCXqaXTg0vLUaF/fK5O7AlDmfcfi+yokCQD3eMDaIVF3dchqm35cF7KYEpQRMSvEAZDoZjqEYis7RBETlt9GNXFLnIQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpdBlD4p; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpdBlD4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737138684; x=1768674684;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iWyy50TkQDcwxOjeZ3gUFVYd+TOnXCHg08f76e2cpak=;
  b=HpdBlD4p8HmVgEbfeiPeF1oQkyLrfUlgPUR545PzJmuU3Ho8SW9/9ad4
   MniS25CqLisk9IJPJRK8UDF9/jUihtw2ivx1SZ/MiR7DYHVEDHjVkO8e4
   80pR+us+1AeyNR0aVVxUUhDkHL0NwNM4PqGZLDIy7W7tKPPNlIbm6jOqb
   w74W3lUWoDtLbLWQUy5DB1WEVXfGfemUsRmBDWzOrkpOGCQVWmWWCpKaA
   Fv/HQYnCi/D7Fgca57g/vuNg/cRvyx7ALGeaHm1ScoyhVWLhAANCIO4bT
   YZeYAlbmCjIC/VK6siV4z2Gcmf9dEfgLgNNpGLPwwfiIQbOZTfPfm5vbF
   Q==;
X-CSE-ConnectionGUID: AsL050vBTAe69FLvkT0ZWw==
X-CSE-MsgGUID: kIElVyXtRByyXszZp0ydqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="40389575"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="40389575"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 10:31:23 -0800
X-CSE-ConnectionGUID: uK9vNRyDSeOeK5Va1vLrHw==
X-CSE-MsgGUID: fgsLPlhtSLurAons4wIzXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="106052039"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 10:31:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 10:31:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 10:31:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 10:31:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX51pwpdiFWejiBe5g0ISkbzbtPh0vtCLqTsS+nrW+Dyys3zQZe3cImMlnZZARL0TcuAqtXbHNYh7q5RNtFwl7hJwKNffUktDzQL+AKmvlsCZmhdmqjL4uAzLdrPwHsPwzV+I/JL2mTZjXLVxOb0AAv4Q3XQoFXLE0p2zbbpRJYHQvrJWEqHeBtc9WwPLqcPiMwndqyyjnTdjzMaUYSwe+nZvjamDsnp8WEU8kyeY25FAtlMa57NdQcnxw94xgYvglEeyZ+O7XrlaqQ0hbNw3pULMBbDysZRrYIyVSQL9eujnLqpLzPfB9J06khdVJH/ZH6D9l5GfUlf6Pn/r1H6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XF2HKoiS59n9s9T7zr2geL+8Dv82CB0C8y9Q0YXntyA=;
 b=nroU8EimQp30Nh8Vtt2S/mzuhdzT/oOup34d2nLbEUoYBdsgYdFMFSdBqgYoxXxEcoUOhRKB8bRxO6PkYS0OgbPBWy9Gn95ZuAAGnCWWwiJc48pON/sn2BzIvvAyl2f+7vLYrt9RPRc9qKiz30U3Tmhbgg44fAhetPX+fyyTszEzkWUMvKPHN3byOzy0m+dWOp1Ht1xbzJLp9ECYJthXYie5KUnvCM78CWhWavZzWlhA25zaY398ivY0AZLXQETUOXqrrwC+KD0yxLckV8KqDm2hd1pP3NnLQ+x/FrNHxOdXG/SDcvIXvtggiil9ml6A9we4WVxJpWwBnYg9PfXguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 18:30:39 +0000
Received: from SN7PR11MB8282.namprd11.prod.outlook.com
 ([fe80::f9d9:8daa:178b:3e72]) by SN7PR11MB8282.namprd11.prod.outlook.com
 ([fe80::f9d9:8daa:178b:3e72%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 18:30:39 +0000
Date: Fri, 17 Jan 2025 13:30:35 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>
Subject: Re: [PATCH v13 2/7] drm/xe/pmu: Enable PMU interface
Message-ID: <Z4qhyx5xRG6jNh-e@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
 <20250116230718.82460-3-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116230718.82460-3-lucas.demarchi@intel.com>
X-ClientProxiedBy: MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::19) To SN7PR11MB8282.namprd11.prod.outlook.com
 (2603:10b6:806:269::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8282:EE_|IA0PR11MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 687a54ef-4739-40bd-7b9c-08dd37250aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?vD6Q0P+tnTHhC8T0zJCx1faQIgXOJ7utgx5CgfLfg20LAR0EJ26LaigUiw?=
 =?iso-8859-1?Q?Ud6Imj/84rKb5hrcyBw7Qt4aiccYsagnQBN/yM3s8IjCwD9EnW5QKAcXCW?=
 =?iso-8859-1?Q?NU9PsAHK85skczhGBHFk8VbPxJgago4TtkStS7siismgvLZT7GWqRKIAt7?=
 =?iso-8859-1?Q?ZUkqsAPRL0YJdPKSxIUThSsgw8t5lt7ndwIlHUwBDxh5PW+5swbgFraACW?=
 =?iso-8859-1?Q?S6N4eGThmDznuRJqMtXn7FR59t0Sre2O42IsfRzNegfG+QPJ0TsdOHpYaN?=
 =?iso-8859-1?Q?/McuQPLmCnbxQmtYujNsvBxM7a9kIW+3BpcncT4zVb8wUu5mULOjqDl+Bk?=
 =?iso-8859-1?Q?oAjAVh6bZJ3HQP+KxFS9Ism1bGeUiQgMmibkyTKz84O8d7O9wWoHztb7rx?=
 =?iso-8859-1?Q?hKcxe24SzjX1hwkgOPYOPiHDM/jd4F4duglz0RQ0rnQG+Ft3bhtUAB9MWD?=
 =?iso-8859-1?Q?BgTBR0hJScpSBtly2lsWDE9XD9YSHtYlAl835glBaSiuyUNgyCzQhYEAo9?=
 =?iso-8859-1?Q?nz1vlAUzbaqIEKTW6KRKUlglmx0bR6t+oILfaAuvXLhGb1sdfu6Mls958h?=
 =?iso-8859-1?Q?eeoaEqptXFjuD9wVyCbdQn4UytTrwr+4BKs0W90WhXkpBjo0D6q1Vewo1h?=
 =?iso-8859-1?Q?recIMRGtNGMSFi1AUwc2fFJjwQkx+PDFF+j6PWEGMeu+9M1HyN6ZgGxZKs?=
 =?iso-8859-1?Q?CajXGqIdmoQONRSdzTcPLhx3aHHyzO8s2/M1eUrj8++04wcQCjx0CtId4O?=
 =?iso-8859-1?Q?XAJF0biZRM06zEu5iFlmIw7Jo93R8scCtmmfHlc4TkrvOVQ2acSjt7r26r?=
 =?iso-8859-1?Q?SkjfLsoLqEk7yw3QTaVfYUko8HkC4P6RjhEAodygcPkunqZcJowZkLhSZi?=
 =?iso-8859-1?Q?S/UKvfR6WQ8bifrpAYhC+R2zvSgqcLCSVwBcvpklZQPM/a9teLVJN+e1/D?=
 =?iso-8859-1?Q?n5MbBYvNw3X2bXw5IYPqrS6u4/uKQX8bHik7zPw12Vu8yF7qmV2QC+Co/A?=
 =?iso-8859-1?Q?v9k0ZmDv3lyauepEsPkcXTfRjXs/7gi3Tbav8j32ZmfJaAaMn3GHwv1Nr8?=
 =?iso-8859-1?Q?M8wMe9cixnXdxDbtVrLu2yJf33yyHpLpRW6aL+mmU2nXTR98hNnR5mItfV?=
 =?iso-8859-1?Q?vLMN04JlIC/NVgDlFu6X2hSVWOXjbBzA8S8Ryr8pgw6/ja37s9MjeScYRK?=
 =?iso-8859-1?Q?EuXRxpcdrBPCwj7A3TdlKEEFDJdk55MRjCbuZo5Du9y/Kna5k6zN08jbzn?=
 =?iso-8859-1?Q?OcZm3XZphTZaAvEupa2mEW3f7nR29p/xZcQasqOQPT3wu830Z1jkWkFkEF?=
 =?iso-8859-1?Q?UkjigAWudHf9FCxEgXIz3RjeAaYSoIrVCWEENM62uNPC2IUvaFUkV/S4/a?=
 =?iso-8859-1?Q?yg/gE/llQClEslZyxYlAX225TkJNo4jw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?j/0h91iOV2MKwakPGohCJPitUO59DpuRBW1Y4mWI4bO2pL/jMwdPAta8wW?=
 =?iso-8859-1?Q?LZEuGk0WfYPLK/54LRB6NkBVRYdaBUfFVGXgk+jJdvwpWTojI5mEXo/0bX?=
 =?iso-8859-1?Q?Z4DAgxlzutkoqgmXxWukQRNu49hbkSEUtEUz7pbk5fomUb7MIWM2ADJYd0?=
 =?iso-8859-1?Q?3koOZn/Rti/KJdgmvfhm77uauHT4wrXt46xhdmRqTz9OFEBKtohyPVJr5F?=
 =?iso-8859-1?Q?uTS+YSJTBgby1P+afdHjstA9esxUvmQ2+dMXjpCC/J4QF03xS4rnbSH0dC?=
 =?iso-8859-1?Q?LTqHKMRXxHDRFcSkIbbnI1rVLSLylusPk8JiyglbcErpxfVhDC25MMVI6d?=
 =?iso-8859-1?Q?/9DeJcv97UIXVVV4kXY9fw/rRMrWuu60TLUy3n+m6eXV9PdaiecQlA7A6N?=
 =?iso-8859-1?Q?Jxjx6zVjJWMJ3m7uYye21X6R/eEiwap9qU2fG0Cph2c0FocNmisU82llDD?=
 =?iso-8859-1?Q?cHMTYxw/wMgymrGIU6tnh0Pt3y7Qae1RxqK9PLn+cTesQ9kjkJDm48tKAR?=
 =?iso-8859-1?Q?ax9h1nmojYi07H9AsQFQpdY2DseNQiqaCySr4SMFZdWk3U5X/tYUuc6Z3W?=
 =?iso-8859-1?Q?7f5sOM+CYXPSmC+tmQ/aNVqkfXY0NeSbbYGEsGoNtUya4fwcqymytj9w4D?=
 =?iso-8859-1?Q?/eMxMaiavXis/ZrOg3qHCjsNcjepA4myI2GlyCSuw5qdmPgX5s2kydLxRL?=
 =?iso-8859-1?Q?lnnns8CYAq8/l/lUhm5XGkEnbIZE87gFLvr1HyDZBu/XjwpTw/lY2FGZO1?=
 =?iso-8859-1?Q?lEiZ+VYtkt0WPhvpmDb2CIfjEudxzRvTdCB/1k/J3HQja7J7z4/ndshY+h?=
 =?iso-8859-1?Q?ioBgwPpSDSA2AFpJJpBBCrEz4etoHTVWr/uiNkQpxoL1+aFCKBGv7FBlI5?=
 =?iso-8859-1?Q?XN8O1oxKva+VaZIqbshwzsCa8JPij9hL3a1JNASZ1B6R6NGGfNNg49CYqY?=
 =?iso-8859-1?Q?J9ybhfWlwwGCIN6vo0tgsou5K2hpf5FtDSOIef74Pbktdf72nXBjJTyWsx?=
 =?iso-8859-1?Q?uQqVqSkX/qU6lNSZw40kjIiiQ/pXAu0OfUXTK3LQ+3DCrpD0+dJPcJmScY?=
 =?iso-8859-1?Q?vlZi2EfWUwkuOCWTc8jGRIK34SKERAiqlz+gbomsNzkkC6EJxU/AliNIr4?=
 =?iso-8859-1?Q?cQEiC539NpEJEeqfJRK9c0dOeUhyCkSC4v8bsKLc2/aA9tTxoZ3SwIHoN2?=
 =?iso-8859-1?Q?RhosVapAaz6qarCUMCdCIVG0Rg098aeSHfu0a3ABnWelX/YH6pNF2TpKHc?=
 =?iso-8859-1?Q?6mNcrvxtsI5hiIiV+McNuc3/PjolnSc+xej0/gVVtda34OGGeqXXBZI+Ta?=
 =?iso-8859-1?Q?OSXY+l9E5rrVhLZWOoOPrkPv1cb3mjhbRX/F5sKXCzt8eDxoWBQY4wQC+Z?=
 =?iso-8859-1?Q?CA6247+QIe9toHC88tk8RLGlQlWQJKYhCV0CCb40BbovUf9D/1BE1CWn6S?=
 =?iso-8859-1?Q?MjMVpp7V8yMogQ40FQOsVAUTtJTapgElgrLjwkvsoyg5jV6qWZ5sSwjMrf?=
 =?iso-8859-1?Q?nNSKlvrOV5T0QxRVivlxuTOQMBxxdIqORGfy+93WjLCqDxkcs1yd4701+S?=
 =?iso-8859-1?Q?Yta/iQfEZQ1+TdRbb3jQ0rY+u8+hu7bx6fbi1uXOxAIBwr01w+k6/0kzlN?=
 =?iso-8859-1?Q?i2+uzn8Q/FEKYKtPd12wVu3nCYzr0c09cwqDGrVGPwEE9qrlkqFbZGTg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 687a54ef-4739-40bd-7b9c-08dd37250aa6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:30:39.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdJ4XVLAgs0EwkSFADdzpXAn1U/Pf/yDme0HBgWCyvY7xBMLB6RS5gNbo5HxvQk4hkt+soCfp+yXJt+QmTCj9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
X-OriginatorOrg: intel.com

On Thu, Jan 16, 2025 at 03:07:13PM -0800, Lucas De Marchi wrote:
> From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> 
> Basic PMU enabling patch. Setup the basic framework
> for adding events/timers. This patch was previously
> reviewed here -
> https://patchwork.freedesktop.org/series/119504/
> 
> Based on previous versions by Bommu Krishnaiah, Aravind Iddamsetty and
> Riana Tauro, using i915 and rapl as reference implementation.
> 
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/xe/Makefile          |   2 +
>  drivers/gpu/drm/xe/xe_device.c       |   3 +
>  drivers/gpu/drm/xe/xe_device_types.h |   4 +
>  drivers/gpu/drm/xe/xe_pmu.c          | 300 +++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_pmu.h          |  20 ++
>  drivers/gpu/drm/xe/xe_pmu_types.h    |  43 ++++
>  6 files changed, 372 insertions(+)
>  create mode 100644 drivers/gpu/drm/xe/xe_pmu.c
>  create mode 100644 drivers/gpu/drm/xe/xe_pmu.h
>  create mode 100644 drivers/gpu/drm/xe/xe_pmu_types.h
> 
> diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
> index 81f63258a7e19..b476866a2a68e 100644
> --- a/drivers/gpu/drm/xe/Makefile
> +++ b/drivers/gpu/drm/xe/Makefile
> @@ -304,6 +304,8 @@ endif
>  xe-$(CONFIG_DRM_XE_DP_TUNNEL) += \
>  	i915-display/intel_dp_tunnel.o
>  
> +xe-$(CONFIG_PERF_EVENTS) += xe_pmu.o
> +
>  obj-$(CONFIG_DRM_XE) += xe.o
>  obj-$(CONFIG_DRM_XE_KUNIT_TEST) += tests/
>  
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index 0966d9697cafe..a0a80fa16c39a 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -49,6 +49,7 @@
>  #include "xe_pat.h"
>  #include "xe_pcode.h"
>  #include "xe_pm.h"
> +#include "xe_pmu.h"
>  #include "xe_query.h"
>  #include "xe_sriov.h"
>  #include "xe_tile.h"
> @@ -865,6 +866,8 @@ int xe_device_probe(struct xe_device *xe)
>  
>  	xe_oa_register(xe);
>  
> +	xe_pmu_register(&xe->pmu);
> +
>  	xe_debugfs_register(xe);
>  
>  	xe_hwmon_register(xe);
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 16ebb2859877f..58e79e19deaad 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -18,6 +18,7 @@
>  #include "xe_memirq_types.h"
>  #include "xe_oa_types.h"
>  #include "xe_platform_types.h"
> +#include "xe_pmu_types.h"
>  #include "xe_pt_types.h"
>  #include "xe_sriov_types.h"
>  #include "xe_step_types.h"
> @@ -514,6 +515,9 @@ struct xe_device {
>  		int mode;
>  	} wedged;
>  
> +	/** @pmu: performance monitoring unit */
> +	struct xe_pmu pmu;
> +
>  #ifdef TEST_VM_OPS_ERROR
>  	/**
>  	 * @vm_inject_error_position: inject errors at different places in VM
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> new file mode 100644
> index 0000000000000..b63f819c54d02
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2025 Intel Corporation
> + */
> +
> +#include <drm/drm_drv.h>
> +#include <drm/drm_managed.h>
> +#include <drm/xe_drm.h>
> +
> +#include "regs/xe_gt_regs.h"
> +#include "xe_device.h"
> +#include "xe_force_wake.h"
> +#include "xe_gt_clock.h"
> +#include "xe_gt_printk.h"
> +#include "xe_mmio.h"
> +#include "xe_macros.h"
> +#include "xe_pm.h"
> +#include "xe_pmu.h"
> +
> +/**
> + * DOC: Xe PMU (Performance Monitoring Unit)
> + *
> + * Expose events/counters like C6 residency and GT frequency to user land.

GT-C6 please... C6 like this will get people confused with CPU C6.

> + * Events will be per device, the GT can be selected with an extra config
> + * sub-field (bits 60-63).
> + *
> + * Perf tool can be used to list these counters from the command line.
> + *
> + * Example commands to list/record supported perf events-
> + *
> + * $ ls -ld /sys/bus/event_source/devices/xe_*
> + * $ ls /sys/bus/event_source/devices/xe_0000_00_02.0/events/
> + * $ ls /sys/bus/event_source/devices/xe_0000_00_02.0/format/
> + *
> + * The format directory has info regarding the configs that can be used.
> + *
> + * The standard perf tool can be used to grep for a certain event as well-
> + * $ perf list | grep c6
> + *
> + * To list a specific event for a GT at regular intervals-

Why not ':' here and all the occurences above?

> + * $ perf stat -e <event_name,xe_gt_id=> -I <interval>
> + */
> +
> +#define XE_PMU_EVENT_GT_MASK		GENMASK_ULL(63, 60)
> +#define XE_PMU_EVENT_ID_MASK		GENMASK_ULL(11, 0)
> +
> +static unsigned int config_to_event_id(u64 config)
> +{
> +	return FIELD_GET(XE_PMU_EVENT_ID_MASK, config);
> +}
> +
> +static unsigned int config_to_gt_id(u64 config)
> +{
> +	return FIELD_GET(XE_PMU_EVENT_GT_MASK, config);
> +}
> +
> +static struct xe_gt *event_to_gt(struct perf_event *event)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	u64 gt = config_to_gt_id(event->attr.config);
> +
> +	return xe_device_get_gt(xe, gt);
> +}
> +
> +static bool event_supported(struct xe_pmu *pmu, unsigned int gt,
> +			    unsigned int id)
> +{
> +	if (gt >= XE_MAX_GT_PER_TILE)
> +		return false;
> +
> +	return false;
> +}
> +
> +static void xe_pmu_event_destroy(struct perf_event *event)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +
> +	drm_WARN_ON(&xe->drm, event->parent);
> +	drm_dev_put(&xe->drm);
> +}
> +
> +static int xe_pmu_event_init(struct perf_event *event)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_pmu *pmu = &xe->pmu;
> +	unsigned int id, gt;
> +
> +	if (!pmu->registered)
> +		return -ENODEV;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* unsupported modes and filters */
> +	if (event->attr.sample_period) /* no sampling */
> +		return -EINVAL;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	gt = config_to_gt_id(event->attr.config);
> +	id = config_to_event_id(event->attr.config);
> +	if (!event_supported(pmu, gt, id))
> +		return -ENOENT;
> +
> +	if (has_branch_stack(event))
> +		return -EOPNOTSUPP;
> +
> +	if (!event->parent) {
> +		drm_dev_get(&xe->drm);
> +		event->destroy = xe_pmu_event_destroy;
> +	}
> +
> +	return 0;
> +}
> +
> +static u64 __xe_pmu_event_read(struct perf_event *event)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_gt *gt = event_to_gt(event);
> +	u64 val = 0;
> +
> +	if (!gt)
> +		return 0;
> +
> +	return val;
> +}
> +
> +static void xe_pmu_event_read(struct perf_event *event)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct xe_pmu *pmu = &xe->pmu;
> +	u64 prev, new;
> +
> +	if (!pmu->registered) {
> +		event->hw.state = PERF_HES_STOPPED;
> +		return;
> +	}
> +
> +	prev = local64_read(&hwc->prev_count);
> +	do {
> +		new = __xe_pmu_event_read(event);
> +	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
> +
> +	local64_add(new - prev, &event->count);
> +}
> +
> +static void xe_pmu_enable(struct perf_event *event)
> +{
> +	/*
> +	 * Store the current counter value so we can report the correct delta
> +	 * for all listeners. Even when the event was already enabled and has
> +	 * an existing non-zero value.
> +	 */
> +	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event));
> +}
> +
> +static void xe_pmu_event_start(struct perf_event *event, int flags)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_pmu *pmu = &xe->pmu;
> +
> +	if (!pmu->registered)
> +		return;
> +
> +	xe_pmu_enable(event);
> +	event->hw.state = 0;
> +}
> +
> +static void xe_pmu_event_stop(struct perf_event *event, int flags)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_pmu *pmu = &xe->pmu;
> +
> +	if (pmu->registered)
> +		if (flags & PERF_EF_UPDATE)
> +			xe_pmu_event_read(event);
> +
> +	event->hw.state = PERF_HES_STOPPED;
> +}
> +
> +static int xe_pmu_event_add(struct perf_event *event, int flags)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_pmu *pmu = &xe->pmu;
> +
> +	if (!pmu->registered)
> +		return -ENODEV;
> +
> +	if (flags & PERF_EF_START)
> +		xe_pmu_event_start(event, flags);
> +
> +	return 0;
> +}
> +
> +static void xe_pmu_event_del(struct perf_event *event, int flags)
> +{
> +	xe_pmu_event_stop(event, PERF_EF_UPDATE);
> +}
> +
> +PMU_FORMAT_ATTR(gt,	"config:60-63");
> +PMU_FORMAT_ATTR(event,	"config:0-11");
> +
> +static struct attribute *pmu_format_attrs[] = {
> +	&format_attr_event.attr,
> +	&format_attr_gt.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = pmu_format_attrs,
> +};
> +
> +static struct attribute *pmu_event_attrs[] = {
> +	/* No events yet */
> +	NULL,
> +};
> +
> +static const struct attribute_group pmu_events_attr_group = {
> +	.name = "events",
> +	.attrs = pmu_event_attrs,
> +};
> +
> +/**
> + * xe_pmu_unregister() - Remove/cleanup PMU registration
> + * @arg: Ptr to pmu
> + */
> +static void xe_pmu_unregister(void *arg)
> +{
> +	struct xe_pmu *pmu = arg;
> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
> +
> +	if (!pmu->registered)
> +		return;
> +
> +	pmu->registered = false;
> +
> +	perf_pmu_unregister(&pmu->base);
> +	kfree(pmu->name);
> +}
> +
> +/**
> + * xe_pmu_register() - Define basic PMU properties for Xe and add event callbacks.
> + * @pmu: the PMU object
> + *
> + * Returns 0 on success and an appropriate error code otherwise
> + */
> +int xe_pmu_register(struct xe_pmu *pmu)
> +{
> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
> +	static const struct attribute_group *attr_groups[] = {
> +		&pmu_format_attr_group,
> +		&pmu_events_attr_group,
> +		NULL
> +	};
> +	int ret = -ENOMEM;
> +	char *name;
> +
> +	if (IS_SRIOV_VF(xe))
> +		return 0;
> +
> +	raw_spin_lock_init(&pmu->lock);
> +
> +	name = kasprintf(GFP_KERNEL, "xe_%s",
> +			 dev_name(xe->drm.dev));
> +	if (!name)
> +		goto err;
> +
> +	/* tools/perf reserves colons as special. */
> +	strreplace(name, ':', '_');
> +
> +	pmu->name		= name;
> +	pmu->base.attr_groups	= attr_groups;
> +	pmu->base.scope		= PERF_PMU_SCOPE_SYS_WIDE;
> +	pmu->base.module	= THIS_MODULE;
> +	pmu->base.task_ctx_nr	= perf_invalid_context;
> +	pmu->base.event_init	= xe_pmu_event_init;
> +	pmu->base.add		= xe_pmu_event_add;
> +	pmu->base.del		= xe_pmu_event_del;
> +	pmu->base.start		= xe_pmu_event_start;
> +	pmu->base.stop		= xe_pmu_event_stop;
> +	pmu->base.read		= xe_pmu_event_read;
> +
> +	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
> +	if (ret)
> +		goto err_name;
> +
> +	pmu->registered = true;
> +
> +	return devm_add_action_or_reset(xe->drm.dev, xe_pmu_unregister, pmu);
> +
> +err_name:
> +	kfree(name);
> +err:
> +	drm_err(&xe->drm, "Failed to register PMU (ret=%d)!\n", ret);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/xe/xe_pmu.h b/drivers/gpu/drm/xe/xe_pmu.h
> new file mode 100644
> index 0000000000000..f9dfe77d00cb6
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_pmu.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2025 Intel Corporation
> + */
> +
> +#ifndef _XE_PMU_H_
> +#define _XE_PMU_H_
> +
> +#include "xe_pmu_types.h"
> +
> +struct xe_gt;
> +
> +#if IS_ENABLED(CONFIG_PERF_EVENTS)
> +int xe_pmu_register(struct xe_pmu *pmu);
> +#else
> +static inline void xe_pmu_register(struct xe_pmu *pmu) {}
> +#endif
> +
> +#endif
> +
> diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h b/drivers/gpu/drm/xe/xe_pmu_types.h
> new file mode 100644
> index 0000000000000..e0cf7169f4fda
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_pmu_types.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2025 Intel Corporation
> + */
> +
> +#ifndef _XE_PMU_TYPES_H_
> +#define _XE_PMU_TYPES_H_
> +
> +#include <linux/perf_event.h>
> +#include <linux/spinlock_types.h>
> +
> +enum {
> +	__XE_NUM_PMU_SAMPLERS
> +};
> +
> +#define XE_PMU_MAX_GT 2
> +
> +/**
> + * struct xe_pmu - PMU related data per Xe device
> + *
> + * Stores per device PMU info that includes event/perf attributes and
> + * sampling counters across all GTs for this device.
> + */
> +struct xe_pmu {
> +	/**
> +	 * @base: PMU base.
> +	 */
> +	struct pmu base;
> +	/**
> +	 * @registered: PMU is registered and not in the unregistering process.
> +	 */
> +	bool registered;
> +	/**
> +	 * @name: Name as registered with perf core.
> +	 */
> +	const char *name;
> +	/**
> +	 * @lock: Lock protecting enable mask and ref count handling.
> +	 */
> +	raw_spinlock_t lock;
> +};
> +
> +#endif
> -- 
> 2.48.0
> 

With s/C6/GT-C6, 
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

