Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42A41CCEE3
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443805; cv=none; b=ot/rPCcYWduvWguIciw+oXFrTv4wKHzdnlwnN2J8h52EnGMkc22GEKqlYmY3kh6wO0SdfdP4ZZQW3L1I5x/8b8sl5G12FDLv0Az2Y44ajL+4VDDcllwuXfvSrUnIpw8AubZQlgi/2Z0Hjxg7gXagD+SPZZkkzks3JdiPZCpF43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443805; c=relaxed/simple;
	bh=j7d7+SJDD2TGyNhvLnv/7wUKLARgA6jThTpmxjWen4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLh1bwgq83Y0KaLFbMVkAppUoo/8rOcYORN8u3igZEl4MLg3Edfg5LvsI5JsH4exFyabNVPOsu4XxYrl9Q3wlWWhYqANLsOmwUh3BlN+wvdr7Bnqf7CLEuVF5+LvEocdottU0qc8K8hffs2AH8yhogzkciSyNzGS+Y1a+qz9WLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LG96+EOQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LG96+EOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725443801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nBE9muUVCuFZMT5coYFm3HHWrhocogLIqDyjWLoRgw8=;
	b=LG96+EOQ5WPp3AT1ZIyLCj9fhV8rujM/oR99jsFjklVbwQM45diAowjiKK2xZwrFt4GpKG
	mH8BIQKXZ9IwZ5dI1GUthzvlkep9TMSRVBtrF2hrpxet4X1slr4FWBvV1GOl+3zI/F+COu
	p7J8jReCCD22xIfnPo6ScH7JR1ld89Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-kBEUWc58OOeCqLAoIbDK7g-1; Wed,
 04 Sep 2024 05:56:37 -0400
X-MC-Unique: kBEUWc58OOeCqLAoIbDK7g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D81701955F45;
	Wed,  4 Sep 2024 09:56:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id ACD4C1956086;
	Wed,  4 Sep 2024 09:56:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  4 Sep 2024 11:56:24 +0200 (CEST)
Date: Wed, 4 Sep 2024 11:56:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
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
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
Message-ID: <20240904095449.GA28781@redhat.com>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com>
 <20240903090843.GA17936@redhat.com>
 <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

I didn't have time to write a full reply yesterday.

On 09/03, Linus Torvalds wrote:
>
> On Tue, 3 Sept 2024 at 02:09, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > but with or without this fix __create_xol_area() also needs
> >
> >         area->xol_mapping.mremap = NULL;
>
> I think the whole thing needs to be zeroed out.

Again, this is what Sven did and I agree with this fix for now.

> It was always horribly buggy. The close thing just made it more
> *obviously* buggy, because closing a vma is a lot more common than
> mremap'ing it.

Well, this code is very old, I don't think it was "always" buggy.
But at least today it is horribly ugly, and

> Either use kzalloc(), or do a proper initializer something like this:
>
> -       area->xol_mapping.name = "[uprobes]";
> -       area->xol_mapping.fault = NULL;
> -       area->xol_mapping.pages = area->pages;
> +       area->xol_mapping = (struct vm_special_mapping) {
> +               .name = "[uprobes]",
> +               .pages = area->pages,
> +               .close = uprobe_clear_state,
> +       };

either way the code is still ugly, imo.

How about the (untested) patch below?

I am not going to send this patch right now, it conflicts with the ongoing
close/mremap changes, but what do you think?

We do not need to add the instance of vm_special_mapping into mm_struct,
a single instance (xol_mapping below) with .fault = xol_fault() is enough.
And, with this change xol_area no longer needs "struct page *pages[2]", it
can be turned into "struct page *page".

Oleg.
---

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -101,7 +101,6 @@ struct xol_area {
 	atomic_t 			slot_count;	/* number of in-use slots */
 	unsigned long 			*bitmap;	/* 0 = free slot */
 
-	struct vm_special_mapping	xol_mapping;
 	struct page 			*pages[2];
 	/*
 	 * We keep the vma's vm_start rather than a pointer to the vma
@@ -1453,6 +1452,21 @@ void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned lon
 		set_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags);
 }
 
+static vm_fault_t xol_fault(const struct vm_special_mapping *sm,
+			    struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct xol_area *area = vma->vm_mm->uprobes_state.xol_area;
+
+	vmf->page = area->pages[0];
+	get_page(vmf->page);
+	return 0;
+}
+
+static const struct vm_special_mapping xol_mapping = {
+	.name = "[uprobes]",
+	.fault = xol_fault,
+};
+
 /* Slot allocation for XOL */
 static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 {
@@ -1479,7 +1493,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
 				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
-				&area->xol_mapping);
+				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto fail;
@@ -1518,9 +1532,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (!area->bitmap)
 		goto free_area;
 
-	area->xol_mapping.name = "[uprobes]";
-	area->xol_mapping.fault = NULL;
-	area->xol_mapping.pages = area->pages;
 	area->pages[0] = alloc_page(GFP_HIGHUSER);
 	if (!area->pages[0])
 		goto free_bitmap;

