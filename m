Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.101
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793810750;
	b=eGCMXHWPB1mi9JTmdjycCwZ4JRASTUj+AhFstvWE+8vqnIGzdL6PcS9yrLAfWH+636fg
	 Hl9wvXRm4mI22h6jKgn2crT1AQyUgG3S4170K8Zk0OKb9A39o78XV8JJa7BmhKq7AOGoY
	 soEq9YzIqiRshja/YPjjDFHN7/SG54NIYw15vggNzQ6aJnnPLVZ13eQz1z2rXPpdyqdBB
	 bGYSHloIdJmfklUPlSrZ95DpYlbHqPCPtY/ACwjxs6tIpYMs/q8b+i5XquSoe/Tiv5tOT
	 gQKQ+7pRO1z3tixsqJ854csiKOaGmirhAcyisczKanFPt7Qbs0pWgeqMZMCl06O34ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810750;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eca9dtOlyWnZT0AuDQHn5+abGsMQZ9bnIPw11JHNJfE=;
	b=5Rewzd/9NTE5R6eEYOqUiGz0f37ePuT8fIpfU70RnQ1+3DyB2sG/CN5Z4KUMkHAs3/kl
	 LYkfejYreWi9shBFVX/x8VVC0JG28/TPyvnReP03m78oj+OkhaEeG4vPbgTtSCz0A6dyR
	 DgERCWeFNwKxNS9ju41kszL145Cj6vBsH9UFyO04xLpRKIduu7ES1HdyZRTnnmaj73+AW
	 aG+Scn1jGxWXYv0AHVPrAKuSyq1SIx74wnwWIGtuCVZTlZ+hpZssGApOAS3/zlkOf3mKY
	 e/wf59lUdTjSCqVMCjwQljajf5eecUh+dM17d7D1cxr6BlNrw5zZ1aELl0FH+lVn8eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.101
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C4A606A328;
	Wed,  4 Nov 2026 16:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40C4A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjY8kRyVtT2/S31R6n8WXJF++NLYIQLouxCGyEFP/dmnAU9roi5EBl5M0zwhnFdJX0YCnk8NfH+6Ky1Ajmj9qSEUgLGyWLYgwkPNpFP7IygGSRpHGroZnEF+PcYKR2hSVRsW57jjlGfkGkmnryrPAaT/kyi0ZE9L0VqhQEANhERKpOr7IKT7t//Qx4yuMddU1udkI7Wu9ArVznywv/sLzbv22OkESZomjkT8LDnDD1YnDNFHCwDfWjaltE4XcSBigQws+nj7A5P66W+7tlSugxRcFZxY5oBcA56cFgq3oPkss0pmM1Xt6i5Uhl85V7uMcQ30sppSuNlPyda0jrffaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=eca9dtOlyWnZT0AuDQHn5+abGsMQZ9bnIPw11JHNJfE=;
 b=PIaGIKEn4kKy5Hd2VxD8mJm0yPAjXhROO2YKJCUCHoQTI1Y1XRsxafFhLWx59D86Yrgmt3mq2THHj9nYoNo+CT/X1iXjZc24xEvFlWMGv/BCG77F/RGqahjcloO/ZsbZg4cOelFoTvOODq7dG6DE6A4RsG2p0Z8MxibyB7398eIfkL1AepsJZmAiy4zKOnQP2hc9McBB2HVqmVl9DCUkND08qVyRApkMBNarsbzc8lpVSmtM+pIs7mzPuwjfiUT+tT2gHEvEh1IY1VRJNUYWISlmpk9sR0L2/O9ouj6zgLl27bAxFXod7f/e0Bfy31uQ0Ojhse5qKkNCqc4UyOkoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWXP123MB3256.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 16:45:44 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:45:43 +0000
Date: Wed, 4 Nov 2026 11:45:39 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, chjohnst@mail.com, neelx@suse.com, 
	sean@ashe.io, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 05/10] perf ftrace: Support context
 switch tracking in function graph tracer
Message-ID: <t4ylcavzix4ultomvslran24alsb3hd56oolwl3wbkpz5gqfbw@p5mirs5xguor>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-6-atomlin@atomlin.com>
 <auZlT1eIOjpTnqHZ@z2>
 <qavabkz2qznknyttzymkppwz64ho6hvqeooqn4ktsxpw5hq4t3@4jfxdhl6c2mu>
 <aurh_Uc9loXXZG0O@z2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aurh_Uc9loXXZG0O@z2>
X-ClientProxiedBy: BN9P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::17) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWXP123MB3256:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1c5375-1ee0-450e-4e37-08df3a93114e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|4143699003|18002099003|22082099003|261102123227099003|6133799003|10067099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	RP84S4+AQuV7X5Ordc9g4wU/KUaN2M+2hJKayjNx03bS+2H0Bjihdy0v2KXHSXaF6z+9IwJpRcYB21W467ahwokHsoz5ZleL6a/ybVQYYStFU1sSuuUCgNZodorgsRnpDk2DB4JSaBi06lH+arc1Smo1NyXCUiyPi7YVdQFps0Igl6qllaE6nq7TsQOvadmZgaSfpQC/kheAxIukWoiY5fqY4ZdoMtaJlaTFXOatxBTal2YldEXtF/M6rd3NeF2dy+ti/qK7bqPVjQ2o5AdIZsVGo6C95IeqglAr83hpOb59zIvbi4GSJlO+larAYOnisaaH826Zp6OLrTyB+o9AA6nRZXpHytAdUmBGP1U9upfYlhP5v0qcrWuUObJ+J051VUZ/Sf9LC0UltD3tWyKMB6MaZkxRxex9GNJPrk40GQNkzONED7G0DFS+v2Fl2anBAFFcOBy9nBLd+cwa3Sj4umUjU/PLHc+Gts86B6QKPIEHDmSTU5CHdc6e7r1JZcwbiLK3mSE92zQr8LYTRlEauxktwq45Xt4dCBu/m11uYnuLGKuA/fBefkEcsSsy6BcKv8SARFLodWRKGJpmIC40lSiFokFXl52RCFKx7Rc1E4xkTY+pn8e1ie2Fl3ZNLnhgjbnGvoAs+BjV4EkNFkSgVh/lTaIj1n3G1kNpK/oSIpc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(4143699003)(18002099003)(22082099003)(261102123227099003)(6133799003)(10067099003)(56012099006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzFlZlNXVWsvV2tJVkJ6QzJRYURsdVp0OHVGK3NBaUJLOSsxcGNJUXFPWTRp?=
 =?utf-8?B?NHhva0dEb1Fnc1JDL3ZSN3FobWlGOXJLVCtPZDY2VEhLTUFNODlqeHpqZ2Ja?=
 =?utf-8?B?bWdoM1VxQmhqWjhkRHg3L3FKOTh6clJmU2gyQmE1UlB3ekRlMklqT3UwQjhJ?=
 =?utf-8?B?VlgzVFA4TFo0S0tpSHpUUi9FcWV5RzhLblREbDlybVJXbVFXRWdxUUVvS24w?=
 =?utf-8?B?QVFBVUk0Z0FQUXRBTjZvYVJWRURKZDNKczBMQkl3ZlFaVlZGdUdGT1BNZ1ZQ?=
 =?utf-8?B?d0JCMS8zU0NaUGxDaW85OWxIQzVyMys0UmtDMHVYbzRCZ3Rpdm1UOGp0dFdn?=
 =?utf-8?B?UzJKbC91c2lmdXBUZ0g4NzZJc1c1K2RVam93bmlBTWRManU3ZjYrUWt4TzJl?=
 =?utf-8?B?ckNJbEFDNWJlQ3FtbkM2RU04VEM4SFhTaHkzS1BuSVZOTWppTWRuZURzd1g3?=
 =?utf-8?B?UmRiM1BESFlqUnlJVkQrYjI2U3g5Q0dVQmMxcDdTQ3FnQmprcUR4N1hGS2Y5?=
 =?utf-8?B?TWVYVEJLQ0ZSZ0h3UER5ZVBWVGprNWNrYXc5d0VLczFOUlVFYkVKRDVaU0Qr?=
 =?utf-8?B?ZndsdHBmeXl3TTNlb25tNXpKVGJlN3dkVnU2eE1wVTVYMTZFMnJqZ2JzRzJs?=
 =?utf-8?B?WEdLUUZqVnVwSlh3bk9tUGJydjBqTmxpT3ZvS2pmbmJSZEdYc0g3bU9DaXUx?=
 =?utf-8?B?N1AybDMzQzBxOFpQNXFUQlZidi9zL0VwMUtHVTVqcVZzallVM09yV3dSMFhz?=
 =?utf-8?B?M0dLS2MyYzBITWkyU1BrZ3F3WW00QnZnZk9qUmFHSHdlOHdLNmJjeWNqUDhZ?=
 =?utf-8?B?QzIvaXpDUmt0ZExLb1BvaWRaVW1NSEoyRXRrNG9qUGhSVEdGODF1SS8wU0FB?=
 =?utf-8?B?NjNOc2pKcllZbHdvK0FuNGR2VFpGWGNudlY0b3ZpdFlkcEhsaitISUMya2Np?=
 =?utf-8?B?T1R1SENlazFRRWZzZE5HS2NyeC9lcGh2NWlwOFdJeG9IYXBSdC9BSWxkN0ox?=
 =?utf-8?B?eXM0NG1wajJEeTZNWkZjTXJTSEV2dnpoL2hmQjcxSWhrRVpXSkFsSjhOc2Ju?=
 =?utf-8?B?UnJSNDJldVNlSEdwenhLd3B6YkZ4ZnYwTmRBdVYwZjEzeHdmajJ1c3ZYemV3?=
 =?utf-8?B?NTAvRzlSdy9mYk15aXJka0RqZ1BLSE9mTEY3VzFwVkFyU1ZoR2Q3YUNjSVFJ?=
 =?utf-8?B?aWdGNisvUFNBSStGUTg2TnBaYVYyZWYzTkp5Y3BKR2xaWUYrRUI1ZFlubmhl?=
 =?utf-8?B?TlhDT2xrYVVQMVA1ZmhwMFRBYjN5cWhJL2g1VWg5V2paakZoQzEySk9tdzFv?=
 =?utf-8?B?d3dpNU10NThVMlJJUDB0S2FpOXFQTHhrL1lPdC9vWjYvK0hrdXVkSjh1YWpU?=
 =?utf-8?B?NThueXRzaDJsSzNhRlB6RXdBZllwZHkwVGhEcHNndHowTTZWVnJoblJnRStP?=
 =?utf-8?B?MnJ0ZVlHVjlseU9pd255dHN3UGhvVzZPWlhhOVdMV252ZDJCNkhrRW1Ca3oy?=
 =?utf-8?B?Z1ZwYTJOZ2FINzJLN2JyZTdURFFoTXlyOWVDSFpSdnJUYU9VZWJ4NnhBRGQ0?=
 =?utf-8?B?OHdPOHA1NkV4UWIyWFhkTnZwdytxUEhNcjJQbnRvNXJ0anI1cGhmSXpiZmtm?=
 =?utf-8?B?OHRsTjB1aHpRSFlkWFhWNkd6b0hRZytsVWtLckhEOTFINGdBMmxUU1dleHVa?=
 =?utf-8?B?N1JTSXVSR1Y4RUNMd1cwMDFWK0VybmFDWWNJMU9jbHV5d3pMelBEekNkWkc2?=
 =?utf-8?B?SmJOK1dSa0dTNDhpekxpSW9COGlza0QzNCtSQmd3UzlVNDdKcGp1RTluTTBq?=
 =?utf-8?B?YnpuaHlLVW5hWEdGWmZZb2tEc3pUL3V3QVdGOGJJZXNqdWlvay9uNlN1Ykla?=
 =?utf-8?B?cnd1NmZLNnk1cEZuYTRCZnRVMnVGWk1HYXNBRGpVQkxsOEQ2VmZ6dVAxaWtz?=
 =?utf-8?B?WkdtUkloOC9NWHV1QkFVenpzcmRac3N3UENwY2JocE8xYjEvOVd2SngwQnBs?=
 =?utf-8?B?bWR2RUZZOXpjbjVuWlJ6a3lYb0tBWmJ6Nm5oSVJobitwR3VYV2pRR1pQQXdF?=
 =?utf-8?B?RmtvSUdYOE9OTjFkRlNrV0xyazFpRlFSQ21UWFkvUE5xMnpFaDROczcva1RK?=
 =?utf-8?B?NTlYRGhBUG9QZ3F5T3JvZXVzSW0xa0Q5V0lITFFKaTRiMVdwTE5LQnZlL2Iw?=
 =?utf-8?B?c0NRbEtUMERVWVRUdElaWW1QdzQ3RGR0SGRtWTdpSGhZZmpMeHh0em1YbVEw?=
 =?utf-8?B?c1JSTkR5MkU3SGM3eWd6NTBPN0FwYWtQd3BxYlZlZllNV3ZMeTdtWjk0UzRN?=
 =?utf-8?B?MS8wTDN0TWFEMEFva0Rqc2dCUFQxYUw4VFF3V2RyVnFCOXpqd2JLdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1c5375-1ee0-450e-4e37-08df3a93114e
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:45:43.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQ/gjhGsLtPmOwOwKfJO+WnlDhamNQDnSWC5m+LWHV0A7rJhK2U6WuxmMexWD9HOAjGBPjKR1ImlOrHjieCpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3256

On Tue, Nov 03, 2026 at 11:42:53PM -0800, Namhyung Kim wrote:
> On Sun, Nov 01, 2026 at 07:04:17PM -0500, Aaron Tomlin wrote:
> > On Sat, Oct 31, 2026 at 03:01:51PM -0700, Namhyung Kim wrote:
> > > On Sun, Oct 25, 2026 at 10:57:30PM -0400, Aaron Tomlin wrote:
> [SNIP]
> > > > +
> > > > +		/*
> > > > +		 * Prune frames on existing and ts that exited during subsequent
> > > > +		 * execution recorded on the other state.
> > > > +		 */
> > > > +		ftrace_task_state__prune_stack(existing, ts);
> > > > +		ftrace_task_state__prune_stack(ts, existing);
> > > 
> > > I'm not sure about this.  In this context, it knows the 'ts' is uptodate
> > > and the 'existing' contains the old state.  Does it need to prune the ts
> > > using the existing?
> > > 
> > > IIUC this code assumes either ts or existing may have uptodate state
> > > like in general cases but it would make the code unnecessarily longer.
> > 
> > The reason this handled both directions is due to how trace_pipe merges
> > per-CPU buffers when a task starts on CPU 0 (unidentified, tracked in ts
> > under FTRACE_UNKNOWN_PID(0)) and migrates to CPU 1:
> > 
> >     1.  Task X starts on CPU 0 before any context switch banner is seen on
> >         CPU 0, so its initial frames are recorded in ts.
> > 
> >     2.  Task X migrates to CPU 1. If CPU 1's incoming banner ("1) idle =>
> >         X") and subsequent function exits are read from trace_pipe before
> >         CPU 0's outgoing banner ("0) X => idle") is flushed, existing is
> >         created on CPU 1 first and actually holds the newer state, while
> >         ts holds the older pre-migration frames from CPU 0.
> > 
> >     3.  Conversely, if Task X was already known on CPU 1 (existing) and
> >         migrated to an unbannered CPU 0 (ts), then ts holds the newer state
> >         and existing holds the older state.
> 
> IIRC we use the global trace pipe so I expect its output in time order.
> How can it see CPU 1's sched switch before the CPU 0's?  Maybe some time
> drifts on each CPU?  Anyway, if that happens in practice, yeah then we
> can check in both directions.

Hi Namhyung,

Yes, global trace_pipe is in timestamp order.

The reason is that function_graph does not emit context-switch banners at
the time of sched_switch; instead, verif_pid() in
kernel/trace/trace_functions_graph.c emits "CPU) prev => next" lazily only
when the next traced function entry/return event is formatted on that CPU.

So if Task X runs traced functions on CPU 0 (i.e. where prev_pid was -1, no
banner was printed yet) and then schedules out on CPU 0 to an untraced task
(e.g. under -T|-G filters or idle) before migrating to CPU 1:

    - CPU 0 emits no fgraph events while the untraced task runs, so CPU 0's
      "0) X => ..." banner is not emitted yet

    - Task X immediately hits traced functions on CPU 1, which triggers
      verif_pid() on CPU 1 and emits "1) ... => X" (and subsequent exits)
      at an earlier timestamp

    - Only later, when a task on CPU 0 next hits a traced function, does
      verif_pid() on CPU 0 emit "0) X => ..."


> > That said, I agree that maintaining a dynamic per-task watermarks[] array
> > for arbitrary multi-hop migrations before the first banner is superfluous.
> > Replacing the dynamic watermarks array with a single scalar minimum-indent
> > watermark on struct ftrace_task_state makes this much simpler and removes
> > ftrace_task_state__record_indent(), ftrace_task_state__min_indent_after(),
> > and the watermark merge loop in ftrace_task_state__rekey().
> 
> Sounds good, thanks!

Acknowledged!

Please ignore my v13. Sashiko found additional valid concerns which I need
to address first.


Thank you,
-- 
Aaron Tomlin
