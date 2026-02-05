Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F33ACF02
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290759; cv=none; b=mvT+6wsIovLEWro9Kl5jDNysi2wNu432KCCaH9B0c6S9yfRHeGJWO82p7+0S290r6EEv4GpsWkNE0CMAtq11ci433+m3CWCJrLYX4/Ns70EciIqJl17pAO2lqGIzVjsijJw/VeddHuGNdJy3WWUaQAyC1VtbV0XrTMz2n6jS/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290759; c=relaxed/simple;
	bh=u5Ks6657AxreoMuzMO/MMJYMe9VCaMC2undl9mrZ4mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWCZAbb3usNhFS6TgoR3fBVxMrz48DV52O3FlRvAHR4p8QbPh6JDjhFXZ6qx/dKtOcHJFcq4Ethk7AjjMMLViAiNP/aDQPzsITuav2sFVBfuwufpaMszvLHbOAhRFIdJ++fnmbNwiItDCE8F+Qo1tk7vxD5MJbWZ92ZHmN2oUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giTsYN7j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giTsYN7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770290758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVGSE5Av5JDAYYnAAui9Tj/IGuCO1OOnFFUFHEzfwHk=;
	b=giTsYN7jcxGuO4CC5zFvTwK2JXzTOKJPJBcLzA6mtG6qkqTeAYor2kywN/y2MSviC7xjZn
	k+iVrnL7kCvAdoKqUnISwh15SIxIBhtvuca7z0YyQHRlKPT5veeGMRkgqKGJQZiuUl5+W2
	DCkCwH4uP3xQYCnL+Q6INLn2sqx+WuA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-vSsqkRwjPGigAAHoKtlVLA-1; Thu,
 05 Feb 2026 06:25:55 -0500
X-MC-Unique: vSsqkRwjPGigAAHoKtlVLA-1
X-Mimecast-MFC-AGG-ID: vSsqkRwjPGigAAHoKtlVLA_1770290753
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE4601955F0E;
	Thu,  5 Feb 2026 11:25:52 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3A8EF18003F6;
	Thu,  5 Feb 2026 11:25:45 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  5 Feb 2026 12:25:52 +0100 (CET)
Date: Thu, 5 Feb 2026 12:25:44 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"open list:UPROBES" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uprobes: replace deprecated kmap_atomic() with
 kmap_local_page()
Message-ID: <aYR-OM41gqRbEnKk@redhat.com>
References: <20260205105725.298340-1-clopez@suse.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205105725.298340-1-clopez@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Carlos,

see

	[PATCH 0/5] uprobes: transition from kmap_atomic to kmap_local_page
	https://lore.kernel.org/all/20260103084243.195125-1-ming.jvle@gmail.com/

already in tip/perf/core

Oleg.

On 02/05, Carlos López wrote:
>
> kmap_atomic() has been deprecated for a few years, and kmap_local_page()
> should be used instead, so replace it. Since the uprobes code relied on
> kmap_atomic() disabling page faults to access user pages, add the
> required calls to keep the existing behavior.
>
> Signed-off-by: Carlos López <clopez@suse.de>
> ---
>  kernel/events/uprobes.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index d546d32390a8..38898435acfe 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -179,16 +179,24 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
>
>  void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
>  {
> -	void *kaddr = kmap_atomic(page);
> +	void *kaddr = kmap_local_page(page);
> +
> +	pagefault_disable();
>  	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
> -	kunmap_atomic(kaddr);
> +	pagefault_enable();
> +
> +	kunmap_local(kaddr);
>  }
>
>  static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
>  {
> -	void *kaddr = kmap_atomic(page);
> +	void *kaddr = kmap_local_page(page);
> +
> +	pagefault_disable();
>  	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
> -	kunmap_atomic(kaddr);
> +	pagefault_enable();
> +
> +	kunmap_local(kaddr);
>  }
>
>  static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *insn,
> @@ -323,9 +331,10 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
>  		return ret == 0 ? -EBUSY : ret;
>  	}
>
> -	kaddr = kmap_atomic(page);
> +	kaddr = kmap_local_page(page);
>  	ptr = kaddr + (vaddr & ~PAGE_MASK);
>
> +	pagefault_disable();
>  	if (unlikely(*ptr + d < 0)) {
>  		pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
>  			"curr val: %d, delta: %d\n", vaddr, *ptr, d);
> @@ -336,7 +345,8 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
>  	*ptr += d;
>  	ret = 0;
>  out:
> -	kunmap_atomic(kaddr);
> +	pagefault_enable();
> +	kunmap_local(kaddr);
>  	put_page(page);
>  	return ret;
>  }
>
> base-commit: f14faaf3a1fb3b9e4cf2e56269711fb85fba9458
> --
> 2.51.0
>

