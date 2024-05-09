Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2043.outbound.protection.outlook.com [40.92.74.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08B053800;
	Thu,  9 May 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276186; cv=fail; b=cMLfh5SjxFU+olZfwg77N1nQGkOlYSHpQmLJsrWY/iDDGp33Ts3b40JuKH1IBJpexqqTCxuyYK7GeGQLrWd0Z+wgzklhMXACps7FvJMN/ScyFAZOU5yzXAdylQd7x0B5seoKfZyQlmiPJAUhXoPWxaZ3kJxoY4xCDZd6bFaHiXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276186; c=relaxed/simple;
	bh=SMBeblEAgLXirC9uRPDCeNSe2AiMY1yivx8+s8/xQB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QWXcotqgmQkkJcJBZAyK116V99NNVk94bM/drfZZHAlh2xLYpRtB7ecE+cf4IRRrwpSTXYa46bDL9d+QYC4GFLpt+1ly2SDsteiuo8vP7P+shK9XBd5ld/rMdLDnBfFbMXPh+3ex7RHlbALDbMeF6rLFUSN4drkLG3PeTdag1BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=fail (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mFuHxLCA reason="signature verification failed"; arc=fail smtp.client-ip=40.92.74.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mFuHxLCA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR9XgPfYee8hVUnELZp20Vo+KiwJwSa9ItG3KDrnC2vMmdBQpKh7ik4EBPvdlGe09uUNWNEMCEhMzXispRziUNSLBMMaFaA1vqQ9mthZE6J2tQx2TWbJsMg1dziB4Iki6YD2RJQlopiajRzoCBSMGWtbs4vKJI9g219h60cfas2IueOFcWazNISBEgpH4oEBoBkilQPGt21lHlFFpGSd5Cl67Nzgk8pQBxZ5Qok7RdkN6wR2FDVQAkMpdH/nY2wO+iY0X05VT8gdei5xyL/cmII1lDScYANpXHQTjL8KMUU3tM7cfrJMG6G8QkBE/uqD85cbN97SBKwPbEzakcL1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBURV6TuD/kEv2NhntEVsdn/iuOBbSQv+CZvZFoTnlc=;
 b=aZrXc381dGeVu+q1uK3rHdRXyBFmBtGnCiThKsmb+Ky2C109Z5WDuBoNFaFth7S6OSC0YrPYryNfn4/aD0Nlxi5zDVSx6516VsW+yarjgK7OUbMoMKPeGnzANav+cM/9SHI+yDyseJrpqA749XIPJ/IQARFx03MNzj0Uk8C+l4OhFeJeYKKFPh9ITJwxrZTVfrmiVSQC4NlUsT08K7JR3WPSVToxKkBgBB3fP2GomoX+OuDk1GucS41tmJ8SQTmsi7+c6SPi3zwPwng/jKAkm1cWFyYKyIhKMs4fAQdQU6L+LcvFepjF7TyviKzRvRu60XZVT1csOB7MLqhKBKU6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBURV6TuD/kEv2NhntEVsdn/iuOBbSQv+CZvZFoTnlc=;
 b=mFuHxLCA6adoOpMzf79qRcvTxJci2LG65HZ4iitGG/QtDspR2F+SKVAhtU4wYdVWj/SNfoA5Bk4viFAQkK2/1rMdoL2E+TbVQZQJxtbLPA7bZhw3OkGuQIKrrm2waAvoz7qGIUSnxTSv66weVk0Xl7QeTMdKs5aVCFmRk8DKSIpaO6LDovMWhgZCXO2rkZ4ClakNEnkoMlxSVLXuC08flbr9IFskIlKoX4yS4k5thwDjQj3CRMiiahiWrgWqdQKZXBq5nG48N4l5OwzkCTr8W3p3++Fh/Gk9RZ5cYLR5c7ERRDgFA4LS20xImsDZQXBdBKQWnnkgnZ/myYLX6QrHXQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by VI1PR02MB10098.eurprd02.prod.outlook.com (2603:10a6:800:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 17:36:21 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 17:36:21 +0000
Date: Thu, 9 May 2024 19:36:18 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID:
 <AS8PR02MB7237F2EAAAFC4836172ECC8E8BE62@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237569E4FBE0B26F62FDFDB8B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <51a49bae-bd91-428e-b476-f862711453a0@wanadoo.fr>
 <AS8PR02MB7237EF9D1962834BE4D2C5F88B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202405060856.53AFAE4F22@keescook>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202405060856.53AFAE4F22@keescook>
X-TMN: [iDcsRxjGgXkrJwtw2eSXcS3FzDrUXW7L]
X-ClientProxiedBy: MA2P292CA0027.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::16)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240509173618.GB10465@titan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|VI1PR02MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d1bc07-14bb-43d5-e52f-08dc704e8a72
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|56899024|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	bUez79alQ8BUGIPXYs3JsNIlvJMTJVTVxLU5lkFWKOUVtxUCCLSKoVRDgkGLPECcllLAe8voj7PD/fZmHf3o956sWKeHgWpj+D28a48Qd05S+YTzEvq3zzyk9j/oJ+2VqCa1PSnFppCCm3nlFhM41p3la6tNIeMgxg809v8G2/GOvniVU4SMSuzyHbvHUfC9J76W7GQHJWsiK4vFsaamfpkt7SXO+kbFi09YO2Sw1gPS0pPWF2WIEgKyzE/Np4tV+W3z0jeHPh+VCp2005oTKbyRRs4KuI8oz+Bi+K+6zCPnygTxKvahv0kNLl4SK3cpkdqIW8hXfOXeBOR6/R56nEBrRWPKOHmtllKGTb5moPQJMxmC4rhIcp+RvoAaRSFlZOnGPke7C0gqwwXqg3b4/3j+XdApQSa6/3vDBLUS2fQ/vGl8Z/5Fs0qIxcY/liPvVuI8PFem0vmmzuQAsi/9XRBwAQ4gmdnir7ZQaugNA78Y5QTFueEqNe4fG+37vcUCcv4OmuAz5FT8GCQ4PpjnxVSrrmaoJn/mAtAwBLl/IEoPPTEytXKHSJ/It2nc8BBwPjDOfcmQre1TcivdXmc9hKaSJ3633QPOartpVip/iECW+BNu8uzGQLSrpydGa8Sv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?7J5+sNHDF5QiyyjpzNLS4S4PJeqSuVNWsYQf3VHZG9Nl7WGPku+lkpfo+g?=
 =?iso-8859-1?Q?sEh4OJqIMV8haWVBUSnnvon8RSkhasZw4sGwwB5J6osbBx5nNFvl0PWuKO?=
 =?iso-8859-1?Q?EcRHV1ufmOkpdFG8r/F0aDTXNSMGeBrIOM6tWaCb2lOwbXw+YXEc+AGcSD?=
 =?iso-8859-1?Q?re26DTyO7cFiBZVOEeQlusxtLLm2C6AuIXvu/SZYMnR/bybq1/MdmJYz2u?=
 =?iso-8859-1?Q?+ALOivexhJdjjqiNfld91kRuCFbSgTeSuYG6ikppbqOuJLUBCUxbYyx47w?=
 =?iso-8859-1?Q?idUAr5v7KT7h6KaBuFIGmF0nGWXankGmm2vqBICWZ3aYtu6iQiyu5briJb?=
 =?iso-8859-1?Q?GHaf2puYV7kQNjSDTffSwE+JtlQOW9nE9naUFuxlmoxO9imdGowpiCAt8y?=
 =?iso-8859-1?Q?RnD4coeWZl/iYXjkt8I7wFwhXcY+FoS1+ETYKOBzNYc/ll6q+Eu2C+Ebj9?=
 =?iso-8859-1?Q?+7Nxe1olHii0bJf8J8POdGyTsqhUNBPFnLxOivdbYla40dJzUNDnFe4JJV?=
 =?iso-8859-1?Q?ukZnK4tv2L+CySm7oCe+CBCM/etFZb8N2v+JMh+V5nRvrUXvm/srhfhr1b?=
 =?iso-8859-1?Q?kF1NK7R/1+87X5yh5lWD7cxsgdeiuQpPlXSu3Wqrpnf7/XPC+iH2uIrdMG?=
 =?iso-8859-1?Q?JVepNCREzTF0RN4bSznDsvalpb48J1uBHL0C/dK1D+RKjqml6UZXr71s+x?=
 =?iso-8859-1?Q?YM7tDeDgfhekZWFrsFKaYJnArSG31Dk2QHGa+SDpx0W7kqsjtuxAF8dGDY?=
 =?iso-8859-1?Q?AukDXGoK22whNZJKt2262jl5Bt1aNa7GFxEFSKxmLpl4EcGDidwknmVwtQ?=
 =?iso-8859-1?Q?TQ4cJh9F6RLuiZHyaRuYgiQUe3VKH+ATdS4To1G9N+bgUhTKdclzJkm9Rd?=
 =?iso-8859-1?Q?7LvR4Vz/pJodQh58jQ3wIk889RpdwmBq7U4gAUE5SPsmSLp6HtRQw6Ye2/?=
 =?iso-8859-1?Q?Lr/pFSzBRHL0RxbfhYzgWn8bSn+2JihkPYCSYvLjKmvMgEfDEwXmLpvULl?=
 =?iso-8859-1?Q?GfR2auF0nGapO0fatUdM7EuL3K/nnEWT+DPA+POZ0ossSWfRIjKpUNFIvC?=
 =?iso-8859-1?Q?n9/42RcUN+UIdkRn+XRPxZoI35H2v69ZjEnrv8KmFSpESGivziItrTz5fR?=
 =?iso-8859-1?Q?QBFTmJ0Dix64RvnL5WKuo3T1rmgbgTdtwC+BoV/zFfm0t5CuPGltwpdvjV?=
 =?iso-8859-1?Q?xvDaH1Dcodi/KQAiGkAjbX2JcaGWgQz3jDWMB6QDy5Vx9meWouO4wEfPTC?=
 =?iso-8859-1?Q?Z99u32QZKd8K7kgrmh1yZrtTBVyDtBNbajqwKMEBiz8K68ihMvJ02xhJOy?=
 =?iso-8859-1?Q?dzY9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d1bc07-14bb-43d5-e52f-08dc704e8a72
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 17:36:21.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10098

Hi Kees and Christophe,
First of all, thanks for the reviews, comments and advices.

On Mon, May 06, 2024 at 09:23:15AM -0700, Kees Cook wrote:
> On Sun, May 05, 2024 at 07:31:24PM +0200, Erick Archer wrote:
> > On Sun, May 05, 2024 at 05:24:55PM +0200, Christophe JAILLET wrote:
> > > Le 05/05/2024 à 16:15, Erick Archer a écrit :
> > > > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > > > index 4013408ce012..080537eff69f 100644
> > > > --- a/kernel/events/ring_buffer.c
> > > > +++ b/kernel/events/ring_buffer.c
> > > > @@ -822,9 +822,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
> > > >   	unsigned long size;
> > > 
> > > Hi,
> > > 
> > > Should size be size_t?
> > 
> > I'm sorry, but I don't have enough knowledge to answer this question.
> > The "size" variable is used as a return value by struct_size and as
> > a parameter to the order_base_2() and kzalloc_node() functions.
> 
> For Linux, size_t and unsigned long are the same (currently).
> Pedantically, yes, this should be size_t, but it's the same.

Thanks for this clarification. I will change the type for the next
version.

> 
> > [...]
> > > 	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);
> > >	if (!all_buf)
> > >		goto fail_all_buf;
> > >
> > >	rb->user_page = all_buf;
> > >	rb->data_pages[0] = all_buf + PAGE_SIZE;
> > >	if (nr_pages) {					<--- here
> > >		rb->nr_pages = 1;			<---
> > >		rb->page_order = ilog2(nr_pages);
> > >	}
> > [...]
> > I think that we don't need to deal with the "nr_pages = 0" case
> > since the flex array will always have a length of one.
> > 
> > Kees, can you help us with this?
> 
> Agh, this code hurt my head for a while.
> 
> all_buf contains "nr_pages + 1" pages. all_buf gets attached to
> rb->user_page, and then rb->data_pages[0] points to the second page in
> all_buf... which means, I guess, that rb->data_pages does only have 1
> entry.
> 
> However, the nr_pages == 0 case is weird. Currently, data_pages[0] will
> still get set (which points ... off the end of all_buf). If we
> unconditionally set rb->nr_pages to 1, we're changing the behavior. If
> we _don't_ set rb->data_pages[0], we're changing the behavior, but I
> think it's an invalid pointer anyway, so this is the safer change to
> make.

Thanks for explain things well.

> I suspect the right replacement is:

> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 4013408ce012..7d638ce76799 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -916,15 +916,11 @@ void rb_free(struct perf_buffer *rb)
>  struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>  {
>  	struct perf_buffer *rb;
> -	unsigned long size;
>  	void *all_buf;
>  	int node;
>  
> -	size = sizeof(struct perf_buffer);
> -	size += sizeof(void *);
> -
>  	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> -	rb = kzalloc_node(size, GFP_KERNEL, node);
> +	rb = kzalloc_node(struct_size(rb, nr_pages, 1), GFP_KERNEL, node);
>  	if (!rb)
>  		goto fail;
>  
> @@ -935,9 +931,9 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>  		goto fail_all_buf;
>  
>  	rb->user_page = all_buf;
> -	rb->data_pages[0] = all_buf + PAGE_SIZE;
>  	if (nr_pages) {
>  		rb->nr_pages = 1;
> +		rb->data_pages[0] = all_buf + PAGE_SIZE;
>  		rb->page_order = ilog2(nr_pages);
>  	}
>  
Ok, I'll do it like this for the next version.
> 
> 
> Also, why does rb_alloc() take an "int" nr_pages? The only caller has an
> unsigned long argument for nr_pages. Nothing checks for >INT_MAX that I
> can find.

Thanks for letting me know. I will take a look.
> 
> -- 
Again, thanks,
Erick

> Kees Cook
