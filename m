Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5720B1FA
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Feb 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228044; cv=none; b=jCoc1ByOAtS4A9iWT+Oh/RTh1Sey79WOMoqPfQIOPIehRMUmDNNqhWTBb2+YsEQKKquxVyChx/deLIGKZE20EETnH8m3Hr8KWFKLrdsCy0w/OoPwCwgibo1MbvNmOecJ9SZO+zAUBuKRzP08anS+b6YYHnn9naACgIFzhJGd18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228044; c=relaxed/simple;
	bh=44WiBU3e87uUbt5Joj83rDplJVriJ4yNvs0txze1vTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKWFP3xG3JTmO3AKnZspPy6geHdI8TzfVD+7J7grVkQjhK3jp1uPOLSlBPoddhXA0HpM5ndXE1f/s1MTXHgISZs8g7MYWgeidBFJ36sc3Sri2oHAFvcCNoM0nRgnyTqdhDuxOpbqxTvUj9LauFLcqgPjrpO2IopAKSWTE5PKMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dof79qPQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dof79qPQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740228041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAd8SANoOauq5uEymG+29fWeYf7y+gGWAJmdDdaiSKs=;
	b=Dof79qPQ0YTHG5wrwCoy9dCcy76JnMN+g557oUhBe5XZc/7vQQUGDxc6tms7MNOT4WJ39V
	iZO8TWQmPZTTsJEWNJ2oBQkpqPjcIBPVPXTUA0Hibd3mS0XEwMhOeS/YQylOVzDOQWrRp6
	ijNUyQbx+QiiQSu4LzFqmh/Q5sNnX2M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-u0F871nGP4-7jWvcSvDHtQ-1; Sat,
 22 Feb 2025 07:40:35 -0500
X-MC-Unique: u0F871nGP4-7jWvcSvDHtQ-1
X-Mimecast-MFC-AGG-ID: u0F871nGP4-7jWvcSvDHtQ_1740228033
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6224619560B9;
	Sat, 22 Feb 2025 12:40:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8A6E8180094A;
	Sat, 22 Feb 2025 12:40:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 22 Feb 2025 13:40:03 +0100 (CET)
Date: Sat, 22 Feb 2025 13:39:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Peter Xu <peterx@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v2] uprobes: fix two zero old_folio bugs in
 __replace_page()
Message-ID: <20250222123952.GA17836@redhat.com>
References: <20250221015056.1269344-1-tongtiangen@huawei.com>
 <20250221152841.GA24705@redhat.com>
 <46a48eb4-5245-81ba-9779-ace8f162c31b@huawei.com>
 <ef999493-cac0-68bb-2684-97da0fb8b583@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef999493-cac0-68bb-2684-97da0fb8b583@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/22, Tong Tiangen wrote:
>
>
> I'm going to add a new patch to moving the "verify_opcode()" check down
> , IIUC that "!PageAnon(old_page)" below also needs to be moved together,

No, no.

I forgot everything, but please don't do this. IIUC This is optimization
for the case when the probed file has int3 at this offset. We should not
skip update_ref_ctr() in this case, just we can avoid __replace_page().

> and as David said this can be triggered by user space, so delete the use
>  of "WARN", as follows:

Hmm... I think that David meant the new WARN_ON() added by you in V1?

Please don't remove the old WARN(PageCompound(old_page) check. If userspace
can trigger this warning we need to to fix this code and add FOLL_SPLIT_PMD
unconditionally (and likely do something else).

I take my words back ;) Don't do the additional cleanups, just add the
is_zero_page(old_page) check right after get_user_page_vma_remote() and
update the subject/changelog as David suggests.

This function needs more cleanups anyway. Say, the usage of orig_page_huge
_looks_ obviously wrong even if (afaics) nothing bad can happen. It should
be reinitialized after "goto retry" or it should be checked before the
"orig_page = find_get_page()" code. The usage of gup_flags looks confusing
too. Lets do this later.

Oleg.

>
>
> @@ -502,20 +502,16 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe,
> struct mm_struct *mm,
>         if (IS_ERR(old_page))
>                 return PTR_ERR(old_page);
>
> -       ret = verify_opcode(old_page, vaddr, &opcode);
> -       if (ret <= 0)
> +       ret = -EINVAL;
> +       if (is_zero_page(old_page))
>                 goto put_old;
>
> -       if (is_zero_page(old_page)) {
> -               ret = -EINVAL;
> +       if (!is_register && (PageCompound(old_page) || !PageAnon(old_page)))
>                 goto put_old;
> -       }
>
> -       if (WARN(!is_register && PageCompound(old_page),
> -                "uprobe unregister should never work on compound page\n"))
> {
> -               ret = -EINVAL;
> +       ret = verify_opcode(old_page, vaddr, &opcode);
> +       if (ret <= 0)
>                 goto put_old;
> -       }
>
>         /* We are going to replace instruction, update ref_ctr. */
>         if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
> @@ -526,10 +522,6 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe,
> struct mm_struct *mm,
>                 ref_ctr_updated = 1;
>         }
>
> -       ret = 0;
> -       if (!is_register && !PageAnon(old_page))
> -               goto put_old;
> -
>         ret = anon_vma_prepare(vma);
>
> Thanks.
> >
> >>
> >>
> >>.
> >
> >.
>

