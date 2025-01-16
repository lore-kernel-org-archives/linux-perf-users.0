Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2117C8B;
	Thu, 16 Jan 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046030; cv=none; b=PArb2m1n6AyB5hf2q6+90j2wlTXBH7X+OmFV5xTj7BKdea0cMW7joQTFHT9RKKcV+2X4r3vlaHuhzFcs66m0YCMMhj7lphyvAWoQfVpYV+LE5dGqyoz0vAUar2f9SDBV1iU+O1fPKv/1OgUmEw2AJ/vmFc1dNwuIngIUYQJEgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046030; c=relaxed/simple;
	bh=bj1zIvD44L0sz0dm+S6wWjfTgb66hdkO+X/lYwX/AQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVt6SkUeuT6IMaVVPFejy/WbPiMptadoSWMua0xqR2C7LFMJ7u2BluqjGV0svIvv64vGroaDESF++ZudlFcBTg+ZaxX60ut19xkIzumV5Q6Dp9vZTVnWssiiHaUBNwl8sojbThxK1zI8Ydlakube8pa3fZMto2kPdN6X1ZlPjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C1CC4CED6;
	Thu, 16 Jan 2025 16:47:09 +0000 (UTC)
Date: Thu, 16 Jan 2025 11:47:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: perf kmem --page stat and gpf_flags translation
Message-ID: <20250116114710.3f84894a@gandalf.local.home>
In-Reply-To: <2ccbae71-0a65-439d-825a-26dc2261fbcf@redhat.com>
References: <87be5f7c-1a0-dad-daa0-54e342efaea7@redhat.com>
	<20241121100326.645bd0d7@gandalf.local.home>
	<2ccbae71-0a65-439d-825a-26dc2261fbcf@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 15:34:28 +0100
Veronika Molnarova <vmolnaro@redhat.com> wrote:

> >> # perf script
> >> perf   96553 [003] 100299.663963: kmem:mm_page_alloc: page=0x1a8f9 pfn=0x1a8f9 order=0 migratetype=0 gfp_flags=0x500cc2
> >> perf   96553 [003] 100299.663995: kmem:mm_page_alloc: page=0x1bc3f pfn=0x1bc3f order=0 migratetype=0 gfp_flags=0x40cc0
> >> perf   96553 [003] 100299.664001: kmem:mm_page_alloc: page=0x1a9d9 pfn=0x1a9d9 order=0 migratetype=0 gfp_flags=0x40cc0
> >> perf   96553 [003] 100299.664011: kmem:mm_page_alloc: page=0x1788b pfn=0x1788b order=0 migratetype=0 gfp_flags=0x40cc0
> >> perf   96553 [003] 100299.664023: kmem:mm_page_alloc: page=0x17993 pfn=0x17993 order=0 migratetype=0 gfp_flags=0xcc0
> >>  
> > 
> > Does the same thing happen with trace-cmd record?
> > 
> >  # trace-cmd record -e mm_page_alloc
> > [ run tests, hit Ctrl^C ]
> > 
> >  # trace-cmd report
> > 
> > ?
> > 
> > If so, could you send the trace.dat file to me.
> > 
> > Thanks,
> > 
> > -- Steve
> >   
> 
> Hi,
> 
> is there any progress on this issue?

Sorry, the response got lost in my INBOX.

Anyway, it appears that userspace can not parse it:

$ trace-cmd dump --events /tmp/trace.dat 
        [Section 18 @ 2082: "events format", flags 0x1, 931 bytes]
        [Events format, 1 systems]
name: mm_page_alloc
ID: 510
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:unsigned long pfn;        offset:8;       size:8; signed:0;
        field:unsigned int order;       offset:16;      size:4; signed:0;
        field:unsigned long gfp_flags;  offset:24;      size:8; signed:0;
        field:int migratetype;  offset:32;      size:4; signed:1;

print fmt: "page=%p pfn=0x%lx order=%d migratetype=%d gfp_flags=%s", REC->pfn != -1UL ? (vmemmap + (REC->pfn)) : ((void *)0), REC->pfn != -1UL ? REC->pfn : 0, REC->order, REC->migratetype, (REC->gfp_flags) ? __print_flags(REC->gfp_flags, "|", {( unsigned long)(((((((( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_IO_BIT))) | (( gfp_t)((((1UL))) << (___GFP_FS_BIT))) | (( gfp_t)((((1UL))) << (___GFP_HARDWALL_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_HIGHMEM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_MOVABLE_BIT))) | (( gfp_t)0)) | (( gfp_t)((((1UL))) << (___GFP_COMP_BIT))) | (( gfp_t)((((1UL))) << (___GFP_NOMEMALLOC_BIT))) | (( gfp_t)((((1UL))) << (___GFP_NOWARN_BIT)))) & ~(( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT))))) | (( gfp_t)((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT)))), "GFP_TRANSHUGE"}, {( unsigned long)((((((( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_IO_BIT))) | (( gfp_t)((((1UL))) << (___GFP_FS_BIT))) | (( gfp_t)((((1UL))) << (___GFP_HARDWALL_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_HIGHMEM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_MOVABLE_BIT))) | (( gfp_t)0)) | (( gfp_t)((((1UL))) << (___GFP_COMP_BIT))) | (( gfp_t)((((1UL))) << (___GFP_NOMEMALLOC_BIT))) | (( gfp_t)((((1UL))) << (___GFP_NOWARN_BIT)))) & ~(( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT))))), "GFP_TRANSHUGE_LIGHT"}, {( unsigned long)((((( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_IO_BIT))) | (( gfp_t)((((1UL))) << (___GFP_FS_BIT))) | (( gfp_t)((((1UL))) << (___GFP_HARDWALL_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_HIGHMEM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_MOVABLE_BIT))) | (( gfp_t)0)), "GFP_HIGHUSER_MOVABLE"}, {( unsigned long)(((( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_IO_BIT))) | (( gfp_t)((((1UL))) << (___GFP_FS_BIT))) | (( gfp_t)((((1UL))) << (___GFP_HARDWALL_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_HIGHMEM_BIT)))), "GFP_HIGHUSER"}, {( unsigned long)((( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_IO_BIT))) | (( gfp_t)((((1UL))) << (___GFP_FS_BIT))) | (( gfp_t)((((1UL))) << (___GFP_HARDWALL_BIT)))), "GFP_USER"}, {( unsigned long)(((( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_IO_BIT))) | (( gfp_t)((((1UL))) << (___GFP_FS_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_ACCOUNT_BIT)))), "GFP_KERNEL_ACCOUNT"}, {( unsigned long)((( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_IO_BIT))) | (( gfp_t)((((1UL))) << (___GFP_FS_BIT)))), "GFP_KERNEL"}, {( unsigned long)((( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_IO_BIT)))), "GFP_NOFS"}, {( unsigned long)((( gfp_t)((((1UL))) << (___GFP_HIGH_BIT)))|(( gfp_t)((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT)))), "GFP_ATOMIC"}, {( unsigned long)((( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT))))), "GFP_NOIO"}, {( unsigned long)((( gfp_t)((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT))) | (( gfp_t)((((1UL))) << (___GFP_NOWARN_BIT)))), "GFP_NOWAIT"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_DMA_BIT))), "GFP_DMA"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_HIGHMEM_BIT))), "__GFP_HIGHMEM"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_DMA32_BIT))), "GFP_DMA32"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_HIGH_BIT))), "__GFP_HIGH"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_IO_BIT))), "__GFP_IO"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_FS_BIT))), "__GFP_FS"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_NOWARN_BIT))), "__GFP_NOWARN"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_RETRY_MAYFAIL_BIT))), "__GFP_RETRY_MAYFAIL"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_NOFAIL_BIT))), "__GFP_NOFAIL"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_NORETRY_BIT))), "__GFP_NORETRY"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_COMP_BIT))), "__GFP_COMP"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_ZERO_BIT))), "__GFP_ZERO"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_NOMEMALLOC_BIT))), "__GFP_NOMEMALLOC"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_MEMALLOC_BIT))), "__GFP_MEMALLOC"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_HARDWALL_BIT))), "__GFP_HARDWALL"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_THISNODE_BIT))), "__GFP_THISNODE"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_RECLAIMABLE_BIT))), "__GFP_RECLAIMABLE"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_MOVABLE_BIT))), "__GFP_MOVABLE"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_ACCOUNT_BIT))), "__GFP_ACCOUNT"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_WRITE_BIT))), "__GFP_WRITE"}, {( unsigned long)(( gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT)))), "__GFP_RECLAIM"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))), "__GFP_DIRECT_RECLAIM"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_KSWAPD_RECLAIM_BIT))), "__GFP_KSWAPD_RECLAIM"}, {( unsigned long)(( gfp_t)((((1UL))) << (___GFP_ZEROTAGS_BIT))), "__GFP_ZEROTAGS"} ) : "none"

See all those: << (__GFP_*)

user space has no idea what numbers they represent. It should have
triggered a FAILED_TO_PARSE, but it appears that the __print_flags() hid
that error. :-/

This broke with commit: 772dd0342727c ("mm: enumerate all gfp flags") as
enums do not translate into numbers like defines do. So all gfp_flags are
now broken in user space trace tooling.

To fix this, we need to add somewhere:

TRACE_DEFINE_ENUM(___GFP_DMA_BIT);
TRACE_DEFINE_ENUM(___GFP_HIGHMEM_BIT);
TRACE_DEFINE_ENUM(___GFP_DMA32_BIT);
TRACE_DEFINE_ENUM(___GFP_MOVABLE_BIT);
TRACE_DEFINE_ENUM(___GFP_RECLAIMABLE_BIT);
TRACE_DEFINE_ENUM(___GFP_HIGH_BIT);
TRACE_DEFINE_ENUM(___GFP_IO_BIT);
TRACE_DEFINE_ENUM(___GFP_FS_BIT);
TRACE_DEFINE_ENUM(___GFP_ZERO_BIT);
TRACE_DEFINE_ENUM(___GFP_UNUSED_BIT);
TRACE_DEFINE_ENUM(___GFP_DIRECT_RECLAIM_BIT);
TRACE_DEFINE_ENUM(___GFP_KSWAPD_RECLAIM_BIT);
TRACE_DEFINE_ENUM(___GFP_WRITE_BIT);
TRACE_DEFINE_ENUM(___GFP_NOWARN_BIT);
TRACE_DEFINE_ENUM(___GFP_RETRY_MAYFAIL_BIT);
TRACE_DEFINE_ENUM(___GFP_NOFAIL_BIT);
TRACE_DEFINE_ENUM(___GFP_NORETRY_BIT);
TRACE_DEFINE_ENUM(___GFP_MEMALLOC_BIT);
TRACE_DEFINE_ENUM(___GFP_COMP_BIT);
TRACE_DEFINE_ENUM(___GFP_NOMEMALLOC_BIT);
TRACE_DEFINE_ENUM(___GFP_HARDWALL_BIT);
TRACE_DEFINE_ENUM(___GFP_THISNODE_BIT);
TRACE_DEFINE_ENUM(___GFP_ACCOUNT_BIT);
TRACE_DEFINE_ENUM(___GFP_ZEROTAGS_BIT);
#ifdef CONFIG_KASAN_HW_TAGS
TRACE_DEFINE_ENUM(___GFP_SKIP_ZERO_BIT);
TRACE_DEFINE_ENUM(___GFP_SKIP_KASAN_BIT);
#endif
#ifdef CONFIG_LOCKDEP
TRACE_DEFINE_ENUM(___GFP_NOLOCKDEP_BIT);
#endif
TRACE_DEFINE_ENUM(___GFP_LAST_BIT);

That will convert the enums into numbers in the trace event format files.


-- Steve
