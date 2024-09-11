Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F11190052
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060477; cv=none; b=bCKp8naZTVj+jrRsderxNotr2u7te0vwuLdkOzyLf18riSNhr5Xhm0oOcRFGWGMLapj7XkUFTldDsxi+Ar6dlX/SC7eaOSE08txHBtSv8gDsTNGhc+ltvHH6kKYqLgBnvn2lbrEPR8XLZUuiwoxiFiKj1xazW+Da1dppEdJbwVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060477; c=relaxed/simple;
	bh=xMCskwQcfEwOUbdWrAErBf7MWGcAi69GXyrTD2rmklQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPLx+emIFb0txKXGyAA7zIb6yItTq/DgOQBcn5NOJykRdX5zsr46vqfgtqBJLSdVIn2Sn1lbMRzDJGB4l3S0KVkHZQ62IRXGuYMxrDST23YuWWJFnGscmJ2fI7kctzmVksHDbre44e7ELDMGRO7ZqYNww7pH+t5SCjeeSEge7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEr0EfSz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEr0EfSz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726060474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7W3kDXSwt1yeFb/GkUq9ycOOE066CsELW4k/XSqo1U=;
	b=LEr0EfSzpPDiAPp42EGwFH/5hLMBKf5+8XWg+PlFj9Mk/5NPtVauN/+cWOSZmOy3U6jqCA
	WGGaB47LVP/T7EwiuTENjf31Y5LHwcdITgSFfl+NiYMQbvFQMX6KqMZ40P10ZuNx2IyHmw
	WxHLSb8oW53LC6TnnmmFjCHw3Ot10JA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-UdEgacnvMGaY4T7ugj50_g-1; Wed,
 11 Sep 2024 09:14:29 -0400
X-MC-Unique: UdEgacnvMGaY4T7ugj50_g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A48B9197700E;
	Wed, 11 Sep 2024 13:14:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.229])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 85A893001D11;
	Wed, 11 Sep 2024 13:14:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 11 Sep 2024 15:14:15 +0200 (CEST)
Date: Wed, 11 Sep 2024 15:14:07 +0200
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
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH -mm 2/3] uprobes: introduce the global struct
 vm_special_mapping xol_mapping
Message-ID: <20240911131407.GB3448@redhat.com>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com>
 <20240911131320.GA3448@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911131320.GA3448@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently each xol_area has its own instance of vm_special_mapping, this
is suboptimal and ugly. Kill xol_area->xol_mapping and add a single global
instance of vm_special_mapping, the ->fault() method can use area->pages
rather than xol_mapping->pages.

As a side effect this fixes the problem introduced by the recent commit
223febc6e557 ("mm: add optional close() to struct vm_special_mapping"), if
special_mapping_close() is called from the __mmput() paths, it will use
vma->vm_private_data = &area->xol_mapping freed by uprobe_clear_state().

Reported-by: Sven Schnelle <svens@linux.ibm.com>
Closes: https://lore.kernel.org/all/yt9dy149vprr.fsf@linux.ibm.com/
Fixes: 223febc6e557 ("mm: add optional close() to struct vm_special_mapping")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 73cc47708679..a478e028043f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -99,7 +99,6 @@ struct xol_area {
 	atomic_t 			slot_count;	/* number of in-use slots */
 	unsigned long 			*bitmap;	/* 0 = free slot */
 
-	struct vm_special_mapping	xol_mapping;
 	struct page 			*pages[2];
 	/*
 	 * We keep the vma's vm_start rather than a pointer to the vma
@@ -1433,6 +1432,21 @@ void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned lon
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
@@ -1459,7 +1473,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
 				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
-				&area->xol_mapping);
+				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto fail;
@@ -1498,9 +1512,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (!area->bitmap)
 		goto free_area;
 
-	area->xol_mapping.name = "[uprobes]";
-	area->xol_mapping.fault = NULL;
-	area->xol_mapping.pages = area->pages;
 	area->pages[0] = alloc_page(GFP_HIGHUSER);
 	if (!area->pages[0])
 		goto free_bitmap;
-- 
2.25.1.362.g51ebf55


