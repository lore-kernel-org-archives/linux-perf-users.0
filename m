Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2078.outbound.protection.outlook.com [40.92.75.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B964084D;
	Sun,  5 May 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714930304; cv=fail; b=jLL+mHq5N2STHHtitfz7c4T3tzehVOCDOJjRMrrIl6cSoriZqxNzmh4OT5/sx6yz1cJJ9tRxxfq+RCwpSZj2p4XVOFL6v+1Dmw7CKINKhov3eiVGVGbimIvIybG3fV8pjbnnXW2yRgC6PYxHbK8jVTTe/C5TKFB4bH9LxvFto9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714930304; c=relaxed/simple;
	bh=u41/1A9u74T2+KjJZXraw6u2NAXlA17C2IM79388iD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gu6xEE+kwm37BKKrEjT2ZdlIfHD1ja06tAs0chr0RpVEsmPLwYyCsDComj5ZtdC3IPl68UW8F/FTv+XYRp7liiMqWy4SpLDLoPl97+T5Kg88IfmgX5SBw1xAbY9XkOqvbyCdMl9d59jeFU+NdLd7T+10s6r2jMLHBcMYqJhkfBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=fail (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fcQziIs5 reason="signature verification failed"; arc=fail smtp.client-ip=40.92.75.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fcQziIs5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3FGVxDBWBMeCrqxDQAr/cci1WUeD0anOm7oZ0BJJB6+DZgj81GVdb6poXNZ0B53fEmtaFnzcey/cu9qOE9tqyHuHzVFQ9GR0uCQg13CUr2Sbrsjr47TukC1MYUUHOAvsVfa5bGXxC6lQh1uLKi3FzalPHeTFD0jI/grdr631i3zH84mVB3zhtTDNRDt525pIgGz2QpM9DX+h+IP2fDosMnnCLCNR20EjEo4d6sVjOFkvkuKgBA9C9AaKvFqI4O8fqbQyLE4D4JX7KZL8osdM594Ldy1Eu7ozdKZRGSuYS3VDhbQ8uHOG2D+gBCZVm/BgxX8POeYFliY7OsHegAx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUNUXFPHtUdNq4qEGh9aKFnsJp8/vq670J34k5Beov8=;
 b=K1TUkMZ0xSl5nzT83KOi8tL82Q1qON8u57rRjUgEPEhTIK3JIWsUGdAs4HQWWaY5yjOk82OHQ+LAfwqGyc5jQiQj4mM/Lg8aS83p/njbWVCfUtUhAV+UAWFy8jdKZ9P2O7k3lW58YUoQqLdqOxz3WB+zcUkqpC0bm5fCzzB4syQuJvAo4wIpy0zJASS/LOxfIOmMcX4ksQOvGKODo+69V00oJspIl1kF6wg5NvG6UGzv6p5HLZ15v1T675a0uwnilkeK66KCN6KdkPwmh2hlhwNVF6bATDManonjg+cz2ifkn0xHjfbUh3dbXvIZSDSgI7o2GrjCh7QdH9f2/+ljwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUNUXFPHtUdNq4qEGh9aKFnsJp8/vq670J34k5Beov8=;
 b=fcQziIs5n2k2PXbFUgjmksmwVMJ7i0CuJMF9tCmpHO9Xge8NXyzhhdvr7dxLHlAtS89wCO0kCxcTn01e7SyRpyJrhHNnAxrh81XouMLCsFSva2o12kZhq+M4oH7GG75T1QPTXAcKLbrxSnN1PTsJwlYC3CIJV4AltXmIigcPb8O0MsI2p/O9QzyR8g0Mh7rBrPKi5kfxhmrTW9SYHtxLNym7kNCI8Yt2t+jA2VfOvvhx+ZuXT1A2I4SzCKzyYYvLB9krMPNlbyou02ojHYdDVPYFlzGKSdZgPcxxkPJjauxFLAMmnbasTcll8eUMHllhEvQ7hB6NfLJCO7CgNV6SHw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS8PR02MB9909.eurprd02.prod.outlook.com (2603:10a6:20b:61a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 17:31:38 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 17:31:38 +0000
Date: Sun, 5 May 2024 19:31:24 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
	Kees Cook <keescook@chromium.org>,
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
 <AS8PR02MB7237EF9D1962834BE4D2C5F88B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237569E4FBE0B26F62FDFDB8B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <51a49bae-bd91-428e-b476-f862711453a0@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51a49bae-bd91-428e-b476-f862711453a0@wanadoo.fr>
X-TMN: [APEankQk6qw0n8e7U4FMI740wFZB2FQh]
X-ClientProxiedBy: MA3P292CA0014.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::15) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240505173124.GA3980@titan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS8PR02MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: 411f1f26-1c16-4bfc-22f5-08dc6d293828
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|56899024|1710799017;
X-Microsoft-Antispam-Message-Info:
	VXkplHxuGEUFJylQiOBQeLyVeRz+3zeYzoew2Ds0TLWHqRYjrV6M1T2XZgXn/TfRjMSpKE6IR5y/wVRjEaNdAVCTPRmuHJA8zDtEvD8/OiL+QgcNlqmqqeObzU6ZzNzw5+fZNuXc5XVIhWD8P1TVvn/IoV1I1q0KTQwCi/cMAiAJQM03WgwqP3/JbzjhuViOj+S71Xeb/Nes1GwQ+F/HgpcZdldTFAaw0NQPvbwzfAeSS7currwD+j4KghjmrCE7l1W4cXnvWQ9CtNimLyPk7TW+LACg1nSLRu+7vO5KcUglkKR5zbpx5S2JzDL5F1BkvA7PQ5Z1hhyyCU3/eou0Ho1/DOlAdedl2G8czODRAhMXFEXfWITZwfWitCW8wZaoj2HvxXIcJt+zfYsNFNyA8rcdd277Q2gZD44x/R84Rpv3s2GhJG6vC/WvenGN+EVffa5kVoalyFJ8u/aIKtAPzOZsh6Yn9uKxJ3DLFUIecYb+/Z4XL6mCxpah2GIqtHjb74vxV/yAOyHd9CbQrlZKfDSua60Pkp2hTntToSl7DuIkmyq5KN69leFaeyQetPOcDtxto/PebBLjD5depnyvDTw0Luk+VFF+1q2kXEIx/jc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?DlWfybdKFHUzdbcdrbJzPkG0gOOhGRqnEwr7Z1oVkucwr3E4bGfhLyKObw?=
 =?iso-8859-1?Q?of3HSZc3MeOLa/NI2LLsE4uXxaIbWog90r5a8Cwjh3mtLLC8MjUtjizkUo?=
 =?iso-8859-1?Q?p70glhZ/GcPAysUk7RuIOMKfWq/WVwsjd+ApMNeMIfJHyc0zvK5GMOtama?=
 =?iso-8859-1?Q?EcL/Hp7js89gHRvBFojA6fKcLJrIVz71uuZTrt2NIrN/idGgupyAA/+yLh?=
 =?iso-8859-1?Q?j9b1zrQXuLGYxZdWFB60FzbQ3qo09cMNZMfH9wwkflbdCt9SetItT66mwH?=
 =?iso-8859-1?Q?KoCGAY0j0T/HHY76/VPvbAbjJEKgvJjzFtVpV5oe3PZShn7oqUG//xbFxq?=
 =?iso-8859-1?Q?9uaVivtxRX9W0o/G88ZmpCCQ/uIVQb8530zUXD+atM6a4mxHQ1d4LxzT4l?=
 =?iso-8859-1?Q?MKAy4gmMKL+xOR47hNHzoEqIHjgugXI31UTU1RdvtKU9LLot1WHKe9BTl9?=
 =?iso-8859-1?Q?xFH7c1O/rsMQ3H2bxJTQutfNJ5jjABGnd0c1YgUzXRXdscN0VbI7Z/iLJN?=
 =?iso-8859-1?Q?HabTnGsqribVVqgIIlIRPZM5wh8tdBbQgyDcN4RFvSccBue0OKS+XarNjR?=
 =?iso-8859-1?Q?7IGbF8YjxE24yjMcIo6N6enoWRpCjEgeOtqHLvc40vFKG/oAFpYKTUrhh+?=
 =?iso-8859-1?Q?lHcPyz2gQ5v0UdvNlHkMetrrjbo9Fxur6kZ5vW6ONlrkPn6akU6v6Mlwn3?=
 =?iso-8859-1?Q?V82zDKdc7bXmPOz3qDqJVho+7kcyDpxHJHPolSJosDikiCIrwn5NMfObNh?=
 =?iso-8859-1?Q?1QQHZ5hnq7pKDExAHAduGTw1Wap1VsPO+eYygAgdbvGDBfAsM8rGhmwZFz?=
 =?iso-8859-1?Q?Y//JdGZV4Gh0kYMXfVC7aPhJHZgo0N4hmOKXd7Egcy6vaQlvDxqfaC6SiD?=
 =?iso-8859-1?Q?WoJyYzbzVHUWQXajQh/A3l4Lu2k1lMq2Smi1wA3mt5fUkWF2+CatT0fMYs?=
 =?iso-8859-1?Q?g2w2tC5+lxuNQD5XvMu5X6xNo9/34YCiyMVGH6Jt0ZuA5ADXQhHAnzF0jk?=
 =?iso-8859-1?Q?opr8IkHG0UFJnNniyxEVynmIoK4p4Ge/mFor0hiATnibSqQaahNANdtITf?=
 =?iso-8859-1?Q?2ggYqJAnxy3FH9ZfAiMlq0Abg9h3cioEb0voH7pcWy97DTdRnw1O9fs3eZ?=
 =?iso-8859-1?Q?nWXp7F54/2fGyrkUF21m24duB1GGlPbGBpQGHLML6nw/+TRKl12WPR9PcH?=
 =?iso-8859-1?Q?VpSGnBo3kpMpKxA1buSEMMBqfaWRTRD/ONZIyeZFVklQQJluPDpQNnz23o?=
 =?iso-8859-1?Q?ZXgS8tZN8yWbDFl+bpP43/MeZcpyU9WIKCslYVkIZ+DuDRcs9Zlm3EEHNO?=
 =?iso-8859-1?Q?AsAA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411f1f26-1c16-4bfc-22f5-08dc6d293828
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 17:31:38.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9909

On Sun, May 05, 2024 at 05:24:55PM +0200, Christophe JAILLET wrote:
> Le 05/05/2024 à 16:15, Erick Archer a écrit :
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index 4013408ce012..080537eff69f 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -822,9 +822,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
> >   	unsigned long size;
> 
> Hi,
> 
> Should size be size_t?

I'm sorry, but I don't have enough knowledge to answer this question.
The "size" variable is used as a return value by struct_size and as
a parameter to the order_base_2() and kzalloc_node() functions.

The size type for the kzalloc_node function is "size_t" but for the
order_base_2() macro it is necessary an unsigned type (since this
is expanded to "__ilog2_u32(u32 n)" or "__ilog2_u64(u64 n)").

So, I don't know if it is correct to change the type to size_t.
Maybe someone can help with this.

> 
> >   	int i, node;
> > -	size = sizeof(struct perf_buffer);
> > -	size += nr_pages * sizeof(void *);
> > -
> > +	size = struct_size(rb, data_pages, nr_pages);
> >   	if (order_base_2(size) > PAGE_SHIFT+MAX_PAGE_ORDER)
> >   		goto fail;
> > @@ -833,6 +831,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
> >   	if (!rb)
> >   		goto fail;
> > +	rb->nr_pages = nr_pages;
> >   	rb->user_page = perf_mmap_alloc_page(cpu);
> >   	if (!rb->user_page)
> >   		goto fail_user_page;
> > @@ -843,8 +842,6 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
> >   			goto fail_data_pages;
> >   	}
> > -	rb->nr_pages = nr_pages;
> > -
> >   	ring_buffer_init(rb, watermark, flags);
> >   	return rb;
> > @@ -916,18 +913,15 @@ void rb_free(struct perf_buffer *rb)
> >   struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
> >   {
> >   	struct perf_buffer *rb;
> > -	unsigned long size;
> >   	void *all_buf;
> >   	int node;
> > -	size = sizeof(struct perf_buffer);
> > -	size += sizeof(void *);
> > -
> >   	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> > -	rb = kzalloc_node(size, GFP_KERNEL, node);
> > +	rb = kzalloc_node(struct_size(rb, data_pages, 1), GFP_KERNEL, node);
> >   	if (!rb)
> >   		goto fail;
> > +	rb->nr_pages = nr_pages;
> 
> I don't think this is correct.

I think you are right. My bad :(

> There is already a logic in place about it a few lines below:
> 
> 	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);
> 	if (!all_buf)
> 		goto fail_all_buf;
> 
> 	rb->user_page = all_buf;
> 	rb->data_pages[0] = all_buf + PAGE_SIZE;
> 	if (nr_pages) {					<--- here
> 		rb->nr_pages = 1;			<---
> 		rb->page_order = ilog2(nr_pages);
> 	}
> 
> I think that what is needed is to move this block just 2 lines above,
> (before rb->data_pages[0] = ...)
> 
> 
> I'm also wondering what should be done if nr_pages = 0.

Perhaps this is enough since we only allocate memory for one
member of the array.

@@ -916,18 +913,15 @@ void rb_free(struct perf_buffer *rb)
 struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 {
        struct perf_buffer *rb;
-       unsigned long size;
        void *all_buf;
        int node;

-       size = sizeof(struct perf_buffer);
-       size += sizeof(void *);
-
        node = (cpu == -1) ? cpu : cpu_to_node(cpu);
-       rb = kzalloc_node(size, GFP_KERNEL, node);
+       rb = kzalloc_node(struct_size(rb, data_pages, 1), GFP_KERNEL, node);
        if (!rb)
                goto fail;

+       rb->nr_pages = 1;
        INIT_WORK(&rb->work, rb_free_work);

        all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);

I think that we don't need to deal with the "nr_pages = 0" case
since the flex array will always have a length of one.

Kees, can you help us with this?

Regards,
Erick

> CJ
> 
> >   	INIT_WORK(&rb->work, rb_free_work);
> >   	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);
> 
