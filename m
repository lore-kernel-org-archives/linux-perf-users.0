Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403451E98EB
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560179; cv=none; b=OGTiWH1dO44qOslaQUU11mR0vIJxbyy51P99A6yzsN5Uj14gpZBVljSuXV2yEfOnBiEFG0qqDk6T4sprrbBXJBoK2QbTouU5H932IHH2K+oLRQztMew/gUxbGTT/YD9lhE13z5xvWoLr1IZyOheT6nTs4mxnGIa67nj8VRu59A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560179; c=relaxed/simple;
	bh=PF0H1yleBcdzKQCUKN2tjThzP3QOfirGFp2mYWdYP2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2XW84qsAkvC7Xh8PwbSzJGPsw6pEV3wAVdSzIja6iieiPcdN4ZjQUCI0iZotygVCWt1GFeoyZ6bhu+LumL3V7oSvzGijgbl5PdV/pQjZ6q8+kUtxyXdfHmFcFmOYWcZaHpFmf77pawOBxd+cPA0AQvHM5zCO8uGmWUjZKD9fV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Py/SqAmk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Py/SqAmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742560176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JH1JMEX1U03GwFlhmPqH+QBmMArUZbpV1nyS6EyqGXg=;
	b=Py/SqAmkC5IZv0Gj2okceuz+O8Gitsk0sFsEjzEf0GL1oE/+cjRXbnkqCAIy16owkmzAZx
	los4vYC/dRcXvoDysobNN5/rtMyDTXFxvIDDUyuKBxaweoi+jKXYJa74UXvtHARkOwrUPe
	9byn7dzxXOVDAjUN1LlbTJbf77TC9UI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-khO1C2dVOFKOcwOL3oRfBg-1; Fri,
 21 Mar 2025 08:29:33 -0400
X-MC-Unique: khO1C2dVOFKOcwOL3oRfBg-1
X-Mimecast-MFC-AGG-ID: khO1C2dVOFKOcwOL3oRfBg_1742560171
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0349C190308B;
	Fri, 21 Mar 2025 12:29:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.60])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 82168195609D;
	Fri, 21 Mar 2025 12:29:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 21 Mar 2025 13:28:58 +0100 (CET)
Date: Fri, 21 Mar 2025 13:28:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprop: Add new verification condition to verify_opcode
Message-ID: <20250321122850.GA4776@redhat.com>
References: <20250321105652.21711-1-superman.xpt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321105652.21711-1-superman.xpt@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Penglei,

On 03/21, Penglei Jiang wrote:
>
> If, during probe registration, the instruction at the probe point
> differs between the file and memory (due to self-modifying code),
> and the probe registration succeeds, the following errors occur:

Thanks for the patch, but I'd say we do not care.

uprobes.c assumes that user-space should not modify the probed memory.

And I don't think your patch can really help. What if user-space
modifies the probed insn right after verify_opcode() succeeds?

Oleg.

>   1. When unregistering the probe, it restores the wrong original
>      instruction.
>      - If the instruction crosses a page boundary: it restores only
>        part of the instruction fetched from the file (the part saved
>        in the first page) to the probe point, and does not restore
>        the remaining part that crosses the page boundary, which can
>        lead to unknown instruction.
>      - If the instruction does not cross a page boundary: it restores
>        the instruction fetched from the file to the probe point.
> 
>   2. The code logic changes because the saved original instruction
>      is fetched from the file.
> 
> Fix:
> 
>   Add an extra check in the registration branch of verify_opcode.
>   If the instruction at the probe point differs between the file
>   and memory, the verification fails.
> 
> Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
> ---
>  kernel/events/uprobes.c | 47 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index b4ca8898fe17..580dd9fe4015 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -264,10 +264,46 @@ static void copy_to_page(struct page *page, unsigned long vaddr, const void *src
>  	kunmap_atomic(kaddr);
>  }
>  
> -static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
> +static int copy_insn_from_mem(struct page *p, unsigned long vaddr,
> +		struct arch_uprobe *dst, struct mm_struct *mm)
> +{
> +	pgoff_t offset = offset_in_page(vaddr);
> +	void *dst_insn = &dst->insn;
> +	size_t size = sizeof(dst->insn);
> +	size_t first_size;
> +	int err;
> +
> +	first_size = min_t(size_t, size, PAGE_SIZE - offset);
> +	copy_from_page(p, offset, dst_insn, first_size);
> +	vaddr += first_size;
> +	dst_insn += first_size;
> +	size -= first_size;
> +
> +	/*
> +	 * If the instruction spans the page boundary, continue copying
> +	 * the remaining instruction from the second page.
> +	 */
> +	if (size) {
> +		err = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &p, NULL);
> +		if (err < 0)
> +			return err;
> +		if (err == 0)
> +			return -EBUSY;
> +
> +		copy_from_page(p, 0, dst_insn, size);
> +		put_page(p);
> +	}
> +
> +	return 0;
> +}
> +
> +static int verify_opcode(struct page *page, unsigned long vaddr,
> +		uprobe_opcode_t *new_opcode, const struct arch_uprobe *auprobe,
> +		struct mm_struct *mm)
>  {
>  	uprobe_opcode_t old_opcode;
>  	bool is_swbp;
> +	struct arch_uprobe current_insn;
>  
>  	/*
>  	 * Note: We only check if the old_opcode is UPROBE_SWBP_INSN here.
> @@ -284,6 +320,13 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
>  	if (is_swbp_insn(new_opcode)) {
>  		if (is_swbp)		/* register: already installed? */
>  			return 0;
> +
> +		if (copy_insn_from_mem(page, vaddr, &current_insn, mm))
> +			return 0;
> +					/* register: was it changed by self-modifying code? */
> +		if (memcmp(&current_insn.insn, &auprobe->insn,
> +			sizeof(current_insn.insn)))
> +			return 0;
>  	} else {
>  		if (!is_swbp)		/* unregister: was it changed by us? */
>  			return 0;
> @@ -491,7 +534,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	if (IS_ERR(old_page))
>  		return PTR_ERR(old_page);
>  
> -	ret = verify_opcode(old_page, vaddr, &opcode);
> +	ret = verify_opcode(old_page, vaddr, &opcode, auprobe, mm);
>  	if (ret <= 0)
>  		goto put_old;
>  
> -- 
> 2.17.1
> 

