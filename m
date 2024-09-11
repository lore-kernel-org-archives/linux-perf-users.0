Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282B42AB4
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049573; cv=none; b=ZHJgLOXxZ3NubsQKfN71Gpuzo4zY+SdDIIq65HLnA2qX5unOzSZjjOQ7WrT7SPx92MdFH2ypw3u5I0KKPruAnz/UOrei1itflyHvPR6Ak5V0cvR9f5wappdcmFiWAhONAhCOUG5WAh3yF47eM8Le0eNllDI7PsF55PC5v2lSAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049573; c=relaxed/simple;
	bh=op/V6qVZ+2QhMBbjcxS2BesD9g0dSJYO9cWaOHh3k0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSUrDVq+J4KHfr18Ql8BWEKD6U64QbGylnYIUsjsMHxAoY/2zkl/CqnJOzwcGdxanlqAJrmRtdXs4Ci+pykhfYjNd4eeHkJRLP9irm2Iic2pbyvJEJZ195LdpUiGGmlZGzbRMwuVRpz8BZJBWuhBm2oUFCIfhplN3LID8DBnxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxjq3f5j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxjq3f5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726049570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PTmGzl0xvlwo25MPX7F3S1aVWqlZHqof8zWfABGA/mo=;
	b=cxjq3f5jcHJKBEGnFQu4Fay+nDY8w1vy0Sse+Ht6Zimf275n+Z4HEV81fJ3K3MBwNGB9mb
	e1UHDxOfMD+1HM6VID2HjXwv2VpqjSzIxj2neU7hW/Tt6+g5Z8q0V25UitP4zVbeVIc98N
	DzBF8Fwpp7bk4YwiRZfB4uwubsKDCfM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-OQ2my_UnMUSs-RVpqw5Gog-1; Wed,
 11 Sep 2024 06:12:47 -0400
X-MC-Unique: OQ2my_UnMUSs-RVpqw5Gog-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6303E1955F29;
	Wed, 11 Sep 2024 10:12:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D69B819560A3;
	Wed, 11 Sep 2024 10:12:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 11 Sep 2024 12:12:32 +0200 (CEST)
Date: Wed, 11 Sep 2024 12:12:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
Message-ID: <20240911101224.GA20701@redhat.com>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com>
 <20240911094401.GA19080@redhat.com>
 <20240911095751.GA20308@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911095751.GA20308@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Damn, sorry for the spam.

So I am going to send the patch from
https://lore.kernel.org/all/20240904095449.GA28781@redhat.com/

To me it looks like a good cleanup regardless, and unless I am totally
confused it should fix the problem with use-after-free.

Oleg.

On 09/11, Oleg Nesterov wrote:
>
> I guess VM_SEALED could help, but it depends on CONFIG_64BIT
>
>
> On 09/11, Oleg Nesterov wrote:
> >
> > On 09/03, Sven Schnelle wrote:
> > >
> > > +static void uprobe_clear_state(const struct vm_special_mapping *sm, struct vm_area_struct *vma)
> > > +{
> > > +	struct xol_area *area = container_of(vma->vm_private_data, struct xol_area, xol_mapping);
> > > +
> > > +	mutex_lock(&delayed_uprobe_lock);
> > > +	delayed_uprobe_remove(NULL, vma->vm_mm);
> > > +	mutex_unlock(&delayed_uprobe_lock);
> > > +
> > > +	if (!area)
> > > +		return;
> > > +
> > > +	put_page(area->pages[0]);
> > > +	kfree(area->bitmap);
> > > +	kfree(area);
> > > +}
> > > +
> > >  static struct xol_area *__create_xol_area(unsigned long vaddr)
> > >  {
> > >  	struct mm_struct *mm = current->mm;
> > > @@ -1481,6 +1500,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
> > >
> > >  	area->xol_mapping.name = "[uprobes]";
> > >  	area->xol_mapping.fault = NULL;
> > > +	area->xol_mapping.close = uprobe_clear_state;
> >
> > Ah, no, we can't do this :/
> >
> > A malicious application can munmap() its "[uprobes]" vma and free
> > area/pages/bitmap. If this application hits the uprobe breakpoint after
> > that it will use the freed memory.
> >
> > And no, "mm->uprobes_state.xol_area = NULL" in uprobe_clear_state() won't
> > help. Say, another thread can sleep on area.wq when munmap() is called.
> >
> > Sorry, I should have realized that immediately, but I didn't :/
> >
> > Andrew, this is uprobes-use-vm_special_mapping-close-functionality.patch
> > in mm-stable
> >
> > Oleg.

