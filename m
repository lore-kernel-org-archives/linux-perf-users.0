Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.130
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794949906;
	b=stLavAoGW4OGJqRPX16tWUmQUwHG+6oNIEIOXiGor3egZzSvYOAcb6IjFvsilhzNTMoG
	 z8vKA28IPkmiOn7x/w+mp4i2vkVBTByHf4fWn1xVFoJ3HxAT1KgAwjNW7Pvcqjsy8931I
	 YG/3NjO8aDboGc/XFWWFKS5ZK1I/ascL4pWdOpRcXTtnYvjPsLYmTnckMZ1PugBkUM/dc
	 WE9Z+RjFFeqHo9wKQmzv1WqVDe7fACbhB4LAFiOlM4h+/mshSCo1h+xkFPpgBNsg9+jGw
	 hrQP65IW4KWO26j9w2mrCw9qV+h8LZTTaputTr9AZftkXnyTESWRG6HdXI02YEDwp7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949906;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9MsJzQWqJOUTupf15zriRgO5gJmZu3rW/LzerdxyWNI=;
	b=PHEzx4jlDbIzdGKGwkmgob299I63Pqf1sH4lncsiWtI0UmtOQyh5b3s6AZjvEOBPxIDs
	 QyQsDbTOt70V3xu7m+UuttXBMF6xUXGcjUGjwcIA7twHH/w+tWMu8TL2iiAQ/uLw/F6Nd
	 cn1ZTxeRZZFsnWmvLSmSib3ppwrQ9qdlrwKbel2Q421y4komX6ajGpWTXsp+x1NQzf4Hi
	 LGFLNyU0g44osaP+BqF2L44gHcBRI3ipVNHguXeJIubPL5W+wcYl5NEVkt2O5F6ss6617
	 y8+bMf7X4YrM/RVvySYuI0g9i/qKiAJ92RydSPo3pspfrwAlKNd5kgKNZZSVsZ/W9uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=os.amperecomputing.com;
	spf=pass smtp.mailfrom=os.amperecomputing.com;
	dkim=pass header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.a=rsa-sha256 header.s=selector2 header.b="bmIS//5b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.130
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022130.outbound.protection.outlook.com [40.107.209.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679F606A31C;
	Tue, 17 Nov 2026 21:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B679F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.a=rsa-sha256 header.s=selector2 header.b=bmIS//5b
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPu5H9Er1QQI+uGyNDv9nAWILKNcGPpduaFjy9Pli0sVwcgjOLrRIAHG5eCudNZHCiKFEA5Sher476UblMGnoKCQGOY1PJE7T1VxyxI8lvlAy+YDO/J5AyZYPgH7Hf6hh1NMFZBtq/m0SQQspcAJJUUCu9T6JfBsk/AtrZ9EsD5XUOdxnVIQJaxUYsPQylrxadUPMb1jQnmkWKB7gG1FOT942XOme+6gc9WZMRKZRTZk+fDfKXMHt3hbWvNAcMcgvloeE4pRD/s32Wsz+WXJaU41Tba+kvz4wi0eIavmPfqPDL9ezRaDnhHylYJ4PlULVF+2bsu9lR7IvRw1mV86cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MsJzQWqJOUTupf15zriRgO5gJmZu3rW/LzerdxyWNI=;
 b=wSy0aJbdne0RxoWBg3ZRe3i8yDdX2Vy5ICZJ8251nvaC9VTrBholzgmv4Ovr/Jw+inqlGQM1FyRAcNDDx0fKRhDluCn/nG7pdi1n2eajB/ATPXghhKYTeBkHsPVeRIUcTc/Tob2ilLdVrzuKMBRYiDTJNaAVyYbLASeinV2FzEwjXveiZXOewDVC/6ZrMkBgDN+JmTqeiN0AGSuIQ0wHC/hph0YQN391YbRahTebYds6fZRQo3wAsGmYlxv8uLDZPu1FLp968shbiMbe8t/4/uXnfOLDKiAYB5fqV0wsXl+iN338dvQrK7UdY0q234EC/SnondmQe47qZGH2tg2vNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MsJzQWqJOUTupf15zriRgO5gJmZu3rW/LzerdxyWNI=;
 b=bmIS//5bTbdrTEPkvaLLOJ01nnKTpC8GVRSztnD/pTkl8L0QK7XhancdoU3RrkEgcKl3RSygDevW0BAqq5dT06BMp5S0rvod5WNuEb8UrQ2WUFzJI6J1uep4e+Uhd8fQoTk23K7USb/YlKxGYlvVGCLzX9xc0Ms4x/AqTrrKlfo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH3PR01MB488663.prod.exchangelabs.com (2603:10b6:610:34b::13)
 by DS4PR01MB9297.prod.exchangelabs.com (2603:10b6:8:280::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.6; Tue, 17 Nov 2026 21:11:41 +0000
Received: from CH3PR01MB488663.prod.exchangelabs.com
 ([fe80::117d:9e02:c9e7:5973]) by CH3PR01MB488663.prod.exchangelabs.com
 ([fe80::117d:9e02:c9e7:5973%3]) with mapi id 15.21.0639.003; Tue, 17 Nov 2026
 21:11:40 +0000
Date: Tue, 17 Nov 2026 13:11:38 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: TAKANO Mitsuhiro <takano32@gmail.com>
cc: linux-perf-users@vger.kernel.org, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>, 
    Ian Rogers <irogers@google.com>, John Garry <john.garry@linux.dev>, 
    Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf vendor events arm64 AmpereOneX: Fix misspelled
 PublicDescription keys
In-Reply-To: <20261113065253.746615-1-takano32@gmail.com>
Message-ID: <edccb772-bbc0-66e5-4606-91dc80b2972a@os.amperecomputing.com>
References: <20261108183846.3804875-1-takano32@gmail.com> <20261113065253.746615-1-takano32@gmail.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:303:b9::23) To CH3PR01MB488663.prod.exchangelabs.com
 (2603:10b6:610:34b::13)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR01MB488663:EE_|DS4PR01MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: 160226b7-6de5-4e72-bd75-08df44ef5fe0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|261022105027099003|4143699003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	MeTJf74hKkbKlRizG4yp8iMvmSKhzRABvSayiMGmQ4/Jak6cBTDSy9ICkRZNpxPnHEC9bIx4UANJZXCTnJ0ddjohQhPliRNFwRxjg7bZcrM9uzvEN/ONqmjm2LmLaP+x52FLgv5jYmAUvNWRZv1hChRyKFFOEfeXyZqGTCHhRF1cea8XNeQb7ZBfaxudX4NjPhFfTf0Ph4khfRfcDkHNuo2uCOb9njPcsWvznZBwt9XInN9Syo/UT4w1pXZxQx2tJ0pfgoFYxDJoiOZeAegrRP131EKKdkvrnbVqldYSa+JwCqK433bVmtkcGIFdOCNMWbmrKPOOKOmt4EnCYCxgQsBPi6rg2WHbSBeTs3V+T8VJ2I6YFwwjAJqfDzSfoCGohA6l5XUSsI6Cv+xz5Ek+Yl0xKBvlbGjcGHdsEz09Zqv+LEGCvZBcH9sWYXMC4hvpztTKPmtJkpfSxYulge/RRXRpse8tiqxOLnFQQbSgbp2fjzGJO6cwGs+lCMw4aU+K+nksj2DRkry9BE5+DULB0OxfGKNgeIHAhRxzOTxTXUoL6KZ2JWZOSt04ENyORM8Zt0ozTA3zoi21odEDYmN2wC4YbDKd9aqtjqabZYk4kwborqBpUmzM1Fn2adjOFVKFX3axWbU14pOBKpvNGuyKjEOtICR6mDww0BdFe45rwsw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR01MB488663.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261022105027099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NeUjLCpR8pez2N3s0UQjp4ZuBdxQWzH4VT8bOz+b0BrpO+9O7iWGllb9G5kz?=
 =?us-ascii?Q?/kL8AWPReCIAkQSxi+KSkUR+eOptXzq9wVrEo7BqsMtLbPBmdmpBcjdVxxKa?=
 =?us-ascii?Q?S8Y9zPQMwnnCEEPK07LBJSnhl4XsGTt8Gp+TFhR+qdGmJ2YJmPMq7IRcwzNs?=
 =?us-ascii?Q?Cp9la0oHCuq+Bdp0uLrDH2ephpcZWJdrqjZyTqFB6WBEvpcbsLgrI9H7sqr2?=
 =?us-ascii?Q?XoPNXE+oDQk30RBxVCXH3XkKsot+50MdXcUyBG7cDre8cvLWj5Cu5YA4MvlS?=
 =?us-ascii?Q?HsdMWrDRZbzNiTDKKa0iYY4SVLNZzeOCBjVsNw6LQYFhiYmasN9SNWozSTGa?=
 =?us-ascii?Q?X21oBkq6FYRL7hl/OjLoZN1ENjcykgvD7U9te2I1jUQ5FPbmxQPaI1LyG6dr?=
 =?us-ascii?Q?R3/pfQDL4f+N1CWSNuiG9H7m9HyFt01rBX7nW2JwrHnK6zHbsPrhaU94tgYp?=
 =?us-ascii?Q?4M7x1IM+VrzTlysyNDIsaosC7AizDIf910MRSA0QY9X9rCOshKk+RE/MVDVF?=
 =?us-ascii?Q?xlLuvT5XbS8/KDzXqIbbdWdPRavLNL7CKbj7yLWH1pGm2tt/BNZLFCoT6pQ9?=
 =?us-ascii?Q?m1mfalAvYwq6WNRmWOII2vTzCv2rgv9bJwHD7FzJiJgOz33M8druteTvyaTb?=
 =?us-ascii?Q?pKJXzfQOiaFe7Xes0Z1HgkfPYmZll1RWxd6Lommk3RN3e99I9krfY8Y7p4jN?=
 =?us-ascii?Q?m9aHcdc6gII8ECFLn/ZKL2oAVsbJTgG7g1TGHY7bM86jDd2+9BJ2jqJbwHzl?=
 =?us-ascii?Q?/yYW56nJ92ZsXcMCw0wB9jaGTDvZYI81hF6ZRXfRvOEunS4fRXmV1SgmbH1F?=
 =?us-ascii?Q?11u+zAWybTY3YgE/SmFX9kwpTTY9Dbw0dVqqwrjkjav6kjjH5FxIFCEuyNak?=
 =?us-ascii?Q?jqWLlxvR+IUwGUAJpe4F1qKY80chwqiV/AU2mHhcjhTCiW87vslN+4ueaYy0?=
 =?us-ascii?Q?xAAcwM8usFLZPPgicHrPUViri6HB9zKPAQ9tOFQ8z5Tvajv1JIgqisGBW07W?=
 =?us-ascii?Q?h60NsIl0r1S8fBaynwwrosiTrCmbRHJDg/5I9dkgwGYdvOCtkFXiX3xi85Ih?=
 =?us-ascii?Q?NSWkQW1KBwW5BDnaqc7R2uFeHprCbJ49LKUNtC4Fm2ow9wDYxmsGN9CDZTSW?=
 =?us-ascii?Q?tp9oy8EHJt2PHeYJ1HZbD7D4RzDh/Vo/4GCpVSlKmGWojmJizAsPPcZN82H/?=
 =?us-ascii?Q?DreYy+eSzc/dCIorUgVdJKgfR5qjyyHxJdlcc0TGOZS5i+9fuF/jFUHqw9n4?=
 =?us-ascii?Q?I1gknITSN27K1jRzoNO5cyPrY32KXJOjyVis9aP0fyzNoJNggs7Li6pFVna4?=
 =?us-ascii?Q?Un0csIr9KyNbLyPWMpRWC6+Fw27xOjYxbUakbhFY6blRybX/WMeb8xMymlRg?=
 =?us-ascii?Q?5Eijal50VyrvRT1FcoSWDGe9FtITWZOl3Hd0ZWhD9ZvCYfqlvhJYkpwLzYAP?=
 =?us-ascii?Q?kYbiFbVS4WNqutC9XE16hvbj+6nSWnzfEMHdelKsVoZqPAeNJPI5ovll2HlK?=
 =?us-ascii?Q?IAAoak6pH0MmH5IwAcLF2Bzxt/EWyzkAUHADDSMo9C7HL23mHF87cES5+rA9?=
 =?us-ascii?Q?r+ovW167DfMn+2u3Klui0HMWpUemLVaZb0JXEOGIlWjBZjEMKYDcU0DOvgtU?=
 =?us-ascii?Q?XHnsVcwjOGsESs+gALsg8ImDpr8pppTEU2ArgIbqKmBnq2541UnOjolOVTMt?=
 =?us-ascii?Q?eYT73Za1DrcVSzcDf/Ex3AIemyGkWoYIFkFhY5IY2VMwAYzg2NzhXk6t3ngp?=
 =?us-ascii?Q?ewNTGXUtG97CXutW26QqK9GU8VFTStI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160226b7-6de5-4e72-bd75-08df44ef5fe0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR01MB488663.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:11:40.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzHEgDE/rtBhZfnuPhtb2wz+egHgW230NXlFtPrXwf51taaANR1AcjyAoNT03MGXNoKDMYKctPhvnyyNNJeKda1g7tTCMLNvfTbzJb/0GEjWvpbdxiVf+KvI4cH6vcLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR01MB9297



On Fri, 13 Nov 2026, TAKANO Mitsuhiro wrote:

> Sixteen of the 28 entries in mmu.json spell PublicDescription as
> "PublicDescrition"; the other 12 spell it correctly.  jevents.py reads
> only the keys it asks for by name, so those 16 fields are dead.
>
> Fixing them does not change the perf list output: every one of the 16
> entries has a BriefDescription with the same text, and jevents.py drops
> the long description when it equals the brief one (jevents.py:405).
> Running jevents.py for arm64 before and after this change gives a
> byte-identical generated string table (1580383 bytes both times).
>
> The file becomes self-consistent again, and the field works if the brief
> text is ever changed on its own.  No text, name, code or expression
> changes.
>
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran the generator as described.  perf was built, not run against
> hardware.
>
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>


Thanks for the patch!

Acked-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
> v2: rebased on 7.4-rc2.  The arm64 string table generated with
>    jevents.py is byte identical before and after the change
>    (1580383 bytes), measured again on this base.
>
> .../arch/arm64/ampere/ampereonex/mmu.json     | 32 +++++++++----------
> 1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
> index 66d83b680651..9457f9be4ecc 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
> @@ -30,37 +30,37 @@
>         "BriefDescription": "Data TLB translation cache hit on S2L2 walk cache entry"
>     },
>     {
> -        "PublicDescrition": "Data TLB translation cache hit on S2L1 walk cache entry",
> +        "PublicDescription": "Data TLB translation cache hit on S2L1 walk cache entry",
>         "EventCode": "0xd805",
>         "EventName": "MMU_D_TRANS_CACHE_HIT_S2L1_WALK",
>         "BriefDescription": "Data TLB translation cache hit on S2L1 walk cache entry"
>     },
>     {
> -        "PublicDescrition": "Data TLB translation cache hit on S2L0 walk cache entry",
> +        "PublicDescription": "Data TLB translation cache hit on S2L0 walk cache entry",
>         "EventCode": "0xd806",
>         "EventName": "MMU_D_TRANS_CACHE_HIT_S2L0_WALK",
>         "BriefDescription": "Data TLB translation cache hit on S2L0 walk cache entry"
>     },
>     {
> -        "PublicDescrition": "Data-side S1 page walk cache lookup",
> +        "PublicDescription": "Data-side S1 page walk cache lookup",
>         "EventCode": "0xd807",
>         "EventName": "MMU_D_S1_WALK_CACHE_LOOKUP",
>         "BriefDescription": "Data-side S1 page walk cache lookup"
>     },
>     {
> -        "PublicDescrition": "Data-side S1 page walk cache refill",
> +        "PublicDescription": "Data-side S1 page walk cache refill",
>         "EventCode": "0xd808",
>         "EventName": "MMU_D_S1_WALK_CACHE_REFILL",
>         "BriefDescription": "Data-side S1 page walk cache refill"
>     },
>     {
> -        "PublicDescrition": "Data-side S2 page walk cache lookup",
> +        "PublicDescription": "Data-side S2 page walk cache lookup",
>         "EventCode": "0xd809",
>         "EventName": "MMU_D_S2_WALK_CACHE_LOOKUP",
>         "BriefDescription": "Data-side S2 page walk cache lookup"
>     },
>     {
> -        "PublicDescrition": "Data-side S2 page walk cache refill",
> +        "PublicDescription": "Data-side S2 page walk cache refill",
>         "EventCode": "0xd80a",
>         "EventName": "MMU_D_S2_WALK_CACHE_REFILL",
>         "BriefDescription": "Data-side S2 page walk cache refill"
> @@ -90,61 +90,61 @@
>         "BriefDescription": "Level 2 instruction translation buffer allocation"
>     },
>     {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S1L2 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S1L2 walk cache entry",
>         "EventCode": "0xd901",
>         "EventName": "MMU_I_TRANS_CACHE_HIT_S1L2_WALK",
>         "BriefDescription": "Instruction TLB translation cache hit on S1L2 walk cache entry"
>     },
>     {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S1L1 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S1L1 walk cache entry",
>         "EventCode": "0xd902",
>         "EventName": "MMU_I_TRANS_CACHE_HIT_S1L1_WALK",
>         "BriefDescription": "Instruction TLB translation cache hit on S1L1 walk cache entry"
>     },
>     {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S1L0 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S1L0 walk cache entry",
>         "EventCode": "0xd903",
>         "EventName": "MMU_I_TRANS_CACHE_HIT_S1L0_WALK",
>         "BriefDescription": "Instruction TLB translation cache hit on S1L0 walk cache entry"
>     },
>     {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S2L2 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S2L2 walk cache entry",
>         "EventCode": "0xd904",
>         "EventName": "MMU_I_TRANS_CACHE_HIT_S2L2_WALK",
>         "BriefDescription": "Instruction TLB translation cache hit on S2L2 walk cache entry"
>     },
>     {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S2L1 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S2L1 walk cache entry",
>         "EventCode": "0xd905",
>         "EventName": "MMU_I_TRANS_CACHE_HIT_S2L1_WALK",
>         "BriefDescription": "Instruction TLB translation cache hit on S2L1 walk cache entry"
>     },
>     {
> -        "PublicDescrition": "Instruction TLB translation cache hit on S2L0 walk cache entry",
> +        "PublicDescription": "Instruction TLB translation cache hit on S2L0 walk cache entry",
>         "EventCode": "0xd906",
>         "EventName": "MMU_I_TRANS_CACHE_HIT_S2L0_WALK",
>         "BriefDescription": "Instruction TLB translation cache hit on S2L0 walk cache entry"
>     },
>     {
> -        "PublicDescrition": "Instruction-side S1 page walk cache lookup",
> +        "PublicDescription": "Instruction-side S1 page walk cache lookup",
>         "EventCode": "0xd907",
>         "EventName": "MMU_I_S1_WALK_CACHE_LOOKUP",
>         "BriefDescription": "Instruction-side S1 page walk cache lookup"
>     },
>     {
> -        "PublicDescrition": "Instruction-side S1 page walk cache refill",
> +        "PublicDescription": "Instruction-side S1 page walk cache refill",
>         "EventCode": "0xd908",
>         "EventName": "MMU_I_S1_WALK_CACHE_REFILL",
>         "BriefDescription": "Instruction-side S1 page walk cache refill"
>     },
>     {
> -        "PublicDescrition": "Instruction-side S2 page walk cache lookup",
> +        "PublicDescription": "Instruction-side S2 page walk cache lookup",
>         "EventCode": "0xd909",
>         "EventName": "MMU_I_S2_WALK_CACHE_LOOKUP",
>         "BriefDescription": "Instruction-side S2 page walk cache lookup"
>     },
>     {
> -        "PublicDescrition": "Instruction-side S2 page walk cache refill",
> +        "PublicDescription": "Instruction-side S2 page walk cache refill",
>         "EventCode": "0xd90a",
>         "EventName": "MMU_I_S2_WALK_CACHE_REFILL",
>         "BriefDescription": "Instruction-side S2 page walk cache refill"
>
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> -- 
> 2.53.0
>
>
>
