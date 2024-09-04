Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD431CEAA4
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444210; cv=none; b=nrLpH4IlSHcO+zSNX1lq8HgdTYf4IoBLI0EiuR6jZIip1nbUyS31MD15dg62BEXLzNC0nZL8x4TwUomKLERQE7jCeDiVj+r8877LojQ7kG5pHlZlediCFjC23eTkjZEcE5BYdBe2cbp3MlljFw0rtcr/b56eMfZ1K55eNkeSdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444210; c=relaxed/simple;
	bh=/YFcA0hHFK7wxmhycoMDjnNSVweA+PN3D4jUjA8GRqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFFSZf5EJnhMY7vOvKq77AdYqadbyE/qT1xJ46tx3MksY+cTJl5QrI5Ln6EHNfKHFuu//VoskzJa5mXU3DW9dG/Qd5mNQOlGNzfQ22q9dxc/V5vvFhD3URRaBoeiyyveD/bx+JWnGFZxDHkM/a2ul1NcwfuY0SNwmSBMuuYaPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQwJkBnk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQwJkBnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725444207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3XuyEXPhJaj55f2rtMVRpx/iwXEgw9cTGMNchlnke0=;
	b=HQwJkBnkxoAsnPYJ28wIEpN3VslJAEe1w+t0VdZBwynpKfkeXXbIzUrE5hl04CQqUf7/ZG
	lgZJjlWIlfthVgR+w0jecUlqA0ISFDz+ybLciBkUAvJXeze7xCNhAW38w++tmPpk/68/Yd
	l5wVV65Wg7E4zxOrl13vJEiChdeBy6U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-toYVwjZePhefBL4CrNY2_w-1; Wed,
 04 Sep 2024 06:03:23 -0400
X-MC-Unique: toYVwjZePhefBL4CrNY2_w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 022AE1956088;
	Wed,  4 Sep 2024 10:03:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.25])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 693D2195605A;
	Wed,  4 Sep 2024 10:03:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  4 Sep 2024 12:03:10 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:03:03 +0200
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
Message-ID: <20240904100302.GA29648@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
xol_mapping.close changes, but what do you think?

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

