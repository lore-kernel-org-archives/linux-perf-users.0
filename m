Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2089.outbound.protection.outlook.com [40.92.50.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80F50A77;
	Sat, 11 May 2024 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715434430; cv=fail; b=X8JHNCa/Q1E17e6AJWIfUXOo2evxzh4qLMXUUBbzeQoiJoHgQnH04WJs9rc27SK9gg2HRaArcmh86s1PJ5jim94K9VTxJ8YHtc5dcDJCvwPumYlTH64IwnIUo1KneA0XzwQBru6ikklIBCAsw7ilVGifqMB3ebabfo4Sp6fTn/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715434430; c=relaxed/simple;
	bh=SQ9xLei/2fzXedhIzZeMAc5v6CXfmj4NUeZ17zrygQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jlcFY1vqMvFIKtNuP52xxYF+TGG68XVc6Eq7pIkaiUi6whyEX3fyLrHfbhC3/IawesErHlx89Q+XPUk/TfGS83VEJ9bwV2amelliCdW3lf6aeiv844Pl/xV8bbURpKwvgWY9HHZkSMISI0llIwLeen5kkX30UiD5W86KBa0pSnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=M9wTKPOT; arc=fail smtp.client-ip=40.92.50.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="M9wTKPOT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXDzeRfq1O6gX568kNVElmJFgQMtp1Fa4OYzrPjvvpmZ/k64hMbuj43lDaQLoOxBN5h/ONjHk8bHTm8BMnfzuXk8nsWbmNUWJyytBIKxRVkganIWrZ3FCh5fnogK6/bvIdZx6h3Yd1t3iE+4EMirkpeUjD1KBH7A+PANnDPFZGO8CqiChf4k5P7meGG6Ko2Csx2XijntkDlT8GB4ginclDmJgEddcK7aq8i8GlrTnHu83KBjQZOzLt5m8vxbR6luURgV4WIVRJyW4hZO7JEtw2N48wxTotBxZnF2LQuzkOctyF6Onhp4RNxBQd7zFzjMxYcCeibQ29PTL6ERTtHvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9wpquRQZbqA51u9R7x+x58OizgCAZb0AHTiGJUFO/g=;
 b=V5jjUXwPwkfhfF0O7MLTZvAh3IZkoWEnqau4gNHtnALSujkX89oKFmGfa6ad1obp9KvJiqirVwtSfSi5+ozeT/rcoV3Hpq5AqCBSXt3qJ00P9pRLhkcGC4v/TpmXdVZ6Awb3fjVqOKVLqdQRm8H146FXu1f+qZSXZKHC2mWOCGJysGqSClenQkJWVGwOp6ihG4skUdq0lY3ft6VzdpQbVDmVJd1j6CwvUyFqNODMqfiM16D4BWuYS7MrQmJKLFu0iuQPKV8oeKYCMhlM6pd4bZSh/1lxtSuMS4ZjnuEMwiAaIxJ1N1aNWFD5G86WMc4WgMw45IY1n/HhERhJy45lew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9wpquRQZbqA51u9R7x+x58OizgCAZb0AHTiGJUFO/g=;
 b=M9wTKPOTNQVOjLy851FIDK0ODOOcI1MAuwR8uF9z1jZ0rvBQNWga29ryVhPDdZwVY5J2rTLjHtDEvOcp+kpVPnw98E6o2ckwULkEdvHTY2u86I6gEzzvyifMAZfuoAQxaN3My1hjH5fCNcdK+HZxXob75ZpVcXPhiqVjOlManUCToXBPeFep4JZiS4RuzvG3xy3ii38Tk3jFKTxI6+o93sOltoVNqL9CANsNgm3BHW/1Ai2/Vo5IagUZhppyuWvujBKIBj3II2/1ddV96SORN1GnlRxg7L/9JaXW5CzQG3r3m39KCSRYD2zh4jW/r2b9SUZM3LOMXAVYjWVsa20v7g==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DU0PR02MB8242.eurprd02.prod.outlook.com (2603:10a6:10:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 13:33:45 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 13:33:45 +0000
Date: Sat, 11 May 2024 15:33:34 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Kees Cook <keescook@chromium.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@outlook.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: Prefer struct_size over open
 coded arithmetic
Message-ID:
 <AS8PR02MB72373149E1A5A57D84D196CC8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-TMN: [fJBF1pTuKh06GICumBGa6bT64E2lPlXp]
X-ClientProxiedBy: MA4P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::17) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240511133334.GA2460@titan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DU0PR02MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd9b8e5-7b9b-4ed7-8187-08dc71befb3b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	/DndsaGhOZIB9jgkIoOv9quWAsvjPYW6hUmfYU9riI3F0pHYUuarFtNB+kRL82XtNthcdwo1ziJSCr7H4ALJ/XNy6F3icRo+3DZV6c5/IjGTXpMe7D0bTQVTqGyIj0y16ppDQODa/nZRLYx9tqG76hBUOBmS2ihKH9ZxDXNEReKuCyluilOEaTmvIiWcKYAHBEau4bnWMu1d2gTI/xKqxW+5wjSNXWCqceAypGF9r5EB3p2OpQRxIYA0+hzEtzS2KLN8gzwL1J2/WTOi+gbA9s1+sByPQhlmVmJqFAHIZxpg767H3UTLOm4ds3I9vimLsyS6huyEOILuniqZFGbMf4FbUxNrF1bvffc24ZWPsDFB3lKgmrQE4LM94jNJaVkdDGLJe0ilKoHPFHAhwIixRpYSg0jz3gbmDsGO1qd9DFoH/YFGwhJ1Movg2owD5ZgMfFFO1aWauTdmE7HGXFtQH84z3EJs/ZPRk7ItOfsbOPb6gG40PYF5YsE1EJ3XJWwfgz6ICNL5w9yuIAUcWBPRLgqFzF/4NRZW6qzKnraHCsZSupLU+hE1pwEFJ8OlaGHmepYSAwWotZlvmiUqaQfhg7wJGrLJd/feIoxEKK1W5BERYdPqYFnCv2zbKSS03KgOWt/qqKLUq4KLW+1DTKQ/ibcL6zBOuhqnHFEM6iCTTt2FttXH6FpMxXlQ9pMSVgzHXpbZqINnbRtG8JKXBj5V/Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LDVdBGou8EwOHq++Q4oi9di963OcUJdwEkIWicVNHYir0nk03G2xSzURw4kV?=
 =?us-ascii?Q?Vl+EI9EWTV46tlgb1C+B3fHqmfVwaUXu1JD8Ij+PI1j6R5325MtVTNOsydPm?=
 =?us-ascii?Q?NpVXhrJa5okAApAKCFeE0ieT02NUMrLtEW7KflQeplFJMzK8ZinNexSDD8iZ?=
 =?us-ascii?Q?rb4WN6RbLhsqOpjQqC/H9gy/9ztWdjBogk1pFUeUosxip7V98UdCY9wzr4tA?=
 =?us-ascii?Q?C2Cyu9+TDdnQXKpI88IpdgJUUuS6yxB5P3TS4rqXcqLPbt4Xqm1ayHBRlCO5?=
 =?us-ascii?Q?zFNREy+mYZHIgIxHXTc7baRZowiSzFbLLwpAqyh778lONr/1gpnkmwqJ52oR?=
 =?us-ascii?Q?0VUehtqYqW63a83PqxI6YaQtOA3wcEV0Ny4GbMofpfYi9jV/LBXZY2ekFLcA?=
 =?us-ascii?Q?1hcNaBynvDaA+hxQ3LQkBtfh4egNqAEvqPpQAQhV7UYwlMEyN78eDTReG7Z9?=
 =?us-ascii?Q?WYD9w0ZD9ByLhIb7GHTQTn83NXURUzMxi1gHsFfVDYEMoJTKEU5OO1dNYqJR?=
 =?us-ascii?Q?nJNbzJgT/CGzQz6GnwLbbPNns5bXQZPulthcLi4Np3+qNMXIIzTFVT8j4nTX?=
 =?us-ascii?Q?tcQqpgXrENdwf8PPxO4dRmpZDiCrKzWSVMpp7gmkFEBtYwxpeBHlI56/Z4+E?=
 =?us-ascii?Q?erO0SUU5x7yUR90R6wIKJBEolisC/zbQRWp81yGjZxXFZoFvstn57TAQ333M?=
 =?us-ascii?Q?aB1+tgrZeFEH/1OyM8dJiAfiZrB0+QsKSpJ1oPjRN7dn4suGp7NUP6aQIXvR?=
 =?us-ascii?Q?N2RJe6Xezu/LNPAb9Y23RBZ6uy/qMw/EyAEj38RqX5NriqRj9LUQ/zujt5Hp?=
 =?us-ascii?Q?jB10xUlOYzw4Pn9PQsK6fTCcwgAzMl86oEIB7HCpuvYD7EDnK/1aC5ffs90T?=
 =?us-ascii?Q?zqsNNJf7UQYqLpgYyoKeLuC4MdiFJF5o8/N1xLzy3kz25dKQ/c2unsAwtjV0?=
 =?us-ascii?Q?brCu/AYhdNXJKnMnw8NMYJbxKgE/l9qi/6ryzDozLhfS1eDlgkKPglrV78uO?=
 =?us-ascii?Q?0aGsuBrQwKLlmwNeFu375Bpxv3A4r4CNLl00lSlnl+Lm01QXGLs/Ej9n6qJd?=
 =?us-ascii?Q?toH1nyC/3qTO0mdTGVMkwySx7LabRMPyfKdaMrAdUxMIxo5phoDbRJjOUjsG?=
 =?us-ascii?Q?FRKidgVMXfiTS60np3+qf1iw3prSyVTqbCxMPqIr0NWdBxxW6QyOHefwbK3N?=
 =?us-ascii?Q?TLQak1NAP2mpsSCU0+YxhF/0nJX1sPr2fXbjpzPLs9bPIuA9iHx4AhQy3beI?=
 =?us-ascii?Q?j3/nkmMU/qHKuFgR9BDt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd9b8e5-7b9b-4ed7-8187-08dc71befb3b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 13:33:45.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8242

Hi everyone,

On Sat, Mar 30, 2024 at 03:32:59PM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "box" variable is a pointer to "struct intel_uncore_box" and
> this structure ends in a flexible array:
> 
> struct intel_uncore_box {
> 	[...]
> 	struct intel_uncore_extra_reg shared_regs[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc_node() function.
> 
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

How could this patch be accepted?
Thanks,

Erick
