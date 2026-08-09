Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABF2D8376
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236684; cv=pass; b=LeRWkICi47zq8On34h+6M/p9mtt8Iviy6TE8hYMBw1zYu0rUXI/kEVSrLRemcsC90Cy4X9h1Wi2EQ6lVaJ8VClU3kS1hF05kZ07RE8BvjSC9mbXXEBCCcIoY3yEzDaOhIqEDB/TkVrjHp/lFpwuvne1pvgiPW6HuEgQxDobStGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236684; c=relaxed/simple;
	bh=zs4SfiVaTFG87zEuWa7DYEYXMveiqU+3HeFFRIGyKW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZebZb4cUzaYHC3BeY+rOkOzpl9J4yNHBaC8T5Ee7o1emmnsABFPnWExsiYFbaoMmwMT5Eo6oDnpizwC3oA7lRhnWdjnWFaTnHIm95fxruTcuPrEN+gJER07e1pz90h0FGbVyb56sbXg2ie6P4GIwu3vtWaqGmIqI9z+AwRw5aKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mayzSwPH; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mayzSwPH"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c15a5b265so178721cf.0
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Aug 2026 17:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786236682; cv=none;
        d=google.com; s=arc-20260327;
        b=rvGF1PdSid1SFHGnVXQQds4ndf5yBw3nMp46gkgbweVGZz+OdVpIOooQbdc7kl/ueV
         fF2WKYDok6gBVCLP8u94TWV7ol8L7eyq4Q3ZRTd1F0LeVpr5ecIuSv/ilKfixgJ+AvaL
         APQzo1DvHBXhdOybQGyYXeAWS7mP3QC6zH4AWPpPP3dpHUWYf1lX0XXAe5+oIwC8rglR
         zPAiCq3f7pZZAPt5EMhE4wTXjTCelb5JgrfjcA2muMLu3zdEhJ7vaqimroDe6A08okwZ
         MA07iuvJyL+yZwi4ebNnLFrEumAKc8g+kAHOG9BfNF4O+OLkUqXEcPrs1vBnKbttljEE
         WIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5t26LPlL2x6rRQWr8/8g+glnpY16lnjlFmjLTvMppKc=;
        fh=HVQ2GvRFgZF9AcmLhbnQNiw7d+6a3nvLiW88ShMW6Dk=;
        b=JLLSKWPiVHPiPUTxyOwzp6yAjR179J7MeMIX6YDpuMeP7sLWRfnYTpwLG46VJw8J+U
         Gh5vUUZ/NPpUCdBs0dEZjBbHPHDto71yaCv3I1bHQrzKmV1gcsPAR9FgqRDmlswDLy9k
         JhQPdypQcPSzMbG1Jd1rwiJK6R0KzhlfNz0mu6PjlxHzm4hAjVY6LZZrbKu8zPBA+SGX
         DsydlN5At9XhD+SeuuBHSaxGH3AnxVVT6pw+njb6FDO0IMSjmjHQzw+PtUAhALf9a+Dz
         SIZ16XfQ5H7NAgdCsK6QSYHGst/v12MOCl7z07T89CXYEtwB9UWDJwLuLaBF0CTo3aVa
         AZ3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786236682; x=1786841482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5t26LPlL2x6rRQWr8/8g+glnpY16lnjlFmjLTvMppKc=;
        b=mayzSwPHAL/EG8FJoZI5aKdT8CHoYJZoOfGR60texMJUcsaFfweID2d2APveCsFmm1
         7NfP3GfZ2EQU894bhlpMILuLG+mTAieRNk2Jbtyqn98artzE34Y0EuWwG/QK6ZJ6toMn
         n5lK4xcaN8kCTgvUrVo9N9V5hR2yPbiohBmiih119V+93+N+BujhVBcKw9vy47pvbFo+
         TwQZREPnF2dEqkUaMXFFfIH2oMsuXEzfppmkQt9dP8O7W2ds8X2A8VUohwh1dmhKplIl
         3fWjha0ZSz5WNIA8LvL1QIChiW5WKOaWQhiyxQJ06q+i6dlaSnIGjChtT02tH4Fvqxot
         LKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786236682; x=1786841482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5t26LPlL2x6rRQWr8/8g+glnpY16lnjlFmjLTvMppKc=;
        b=kJwzZcG4D3SR9wvsQsp+YIXwCH8DOBmjrz+iQI2V/Yt5wp4n/e+NBxndyZgissNQJB
         aOndJ85kCHChD+GTW91kcXoX3JSLEezoUkwExqXyngfKo9XmiWgW2bocKU7/ZwJV1kZs
         N63xm5u3RxV06IpqdbOt3laaZs+x/CckraXOj3TZAyKrGjbK8WeuAXq+JCEM9DKogC4Q
         tZdM7GUwd1MuzxMgWU7mKI1YtCzW+KF5kYeIzPrLPcd8GCmskvXwkVHSerJJWqAH6dkI
         B1krLM/KHFAeQhp20Xl4JWPLoWi7ItkQ7Kc3TIW8p1qU8g9JG4izCX2VDYlW+2/6jauS
         5CWA==
X-Forwarded-Encrypted: i=1; AHgh+RpyjdYi5+UOkD0beujkTy2mnHj/tKPCXfAjfEPcC9IKrCONQzp1OWzO0YAmbofiNgLkl7xoKHTbNSufRmn/UpCp@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqrInHrahlI59CVdmZoOvs9FL/S3LfqD0fpD/UX0mqT/VJPNK
	fWMnoJlmRRrSRJ+BpfI3k0pONYHd8CxkRVCbS4w3Bp7v2jhmdBxsjBsZZHUo82yqQ9m/dm9VZQV
	bj1LiKmXSIadhoezJMQpXfx6iPnpWzPpGQ7joAM1q
X-Gm-Gg: AR+sD11EfWNyr5satz8eJbJ8Xsh4ME7hJKk4sKGufLZsOsRa8Jl+WwxgvmT6XHFUdJs
	5ifTNnZbiv4N9PqDSKNItkmY1/goQA87kiSXvzKooxkQU947+iNVFgWoTpoqc4m5i++EEEjmGm2
	gSiicg3kK/xtiLWxbr/x8xQBP6zf0AAbu1809IPzQF7SouT1nCOZ0zlxytMU3Oz8k94NU4M19/v
	XyZNKTpWNhQm0OBmHmaefiQmSqluvOpMic8mxniN0IRKQ3Lb9zC/PFrAkFvjAUIYkAvzOpNPptm
	okG+5hQXxA8G4L00K+pDyKVa/M3Qfaw140YnY8gICso=
X-Received: by 2002:a05:622a:2c2:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-52d28104052mr10844831cf.5.1786236681095; Sat, 08 Aug 2026
 17:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org> <20260806-b4-scalable-cow-virt-pgoff-v4-1-ab318a350404@kernel.org>
In-Reply-To: <20260806-b4-scalable-cow-virt-pgoff-v4-1-ab318a350404@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 8 Aug 2026 17:51:10 -0700
X-Gm-Features: AUfX_mwrAfErRpWaGdsaXjFbVsuLxmBdhaCS8dBRSF7bNpazo-ZM1X1L3isxLV8
Message-ID: <CAJuCfpFAA1H2pOi6EOarNtrdzLQDJyhm6QOGsfZ4SFTuM5eiLQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] mm/vma: introduce VMA anon page offset field and
 add helpers
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:22=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Establish fields in vm_area_struct to store the anonymous page offset of
> VMAs.
>
> Initially, the anonymous page offset of a VMA is vma->vm_start >>
> PAGE_SHIFT.
>
> When a VMA is remapped to new_address its anonymous page offset is either
> updated to new_address >> PAGE_SHIFT if unfaulted or, if faulted, remains
> equal to the anonymous page offset it had when first faulted.
>
> Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
> file-backed VMAs are tracked by their file offsets. By adding anonymous
> offset as a property of VMAs, we can now track them by their anonymous pa=
ge
> offset instead.
>
> By tracking this, we provide the means by which to eliminate this
> inconsistency, and more importantly lay the foundations for future work f=
or
> the scalable CoW anonymous rmap rework.
>
> This patch simply adds the fields and some simple helpers. Subsequent
> patches will update mm code to make use of these fields correctly.
>
> The fields chosen are packed in the VMA such that, for 64-bit kernel
> builds, no additional space is taken up.
>
> The first field is present on cacheline 0 containing key VMA fields, and
> the second on cacheline 3, which contains file-backed reverse mapping
> fields.
>
> Given the relative time spent accessing reverse mapping fields as well as
> updating them, there shouldn't be any performance impact here from false
> sharing.
>
> Update the VMA userland tests to account for this change.
>
> No callsites are updated yet, so no functional change intended.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  include/linux/mm.h              | 59 +++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mm_types.h        | 12 +++++++++
>  mm/vma.h                        | 14 ++++++++++
>  mm/vma_init.c                   |  1 +
>  tools/testing/vma/include/dup.h | 26 ++++++++++++++++++
>  5 files changed, 112 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 87feaa5a2b78..df78847f5f07 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4393,6 +4393,65 @@ static inline pgoff_t vma_last_pgoff(const struct =
vm_area_struct *vma)
>         return vma_end_pgoff(vma) - 1;
>  }
>
> +/**
> + * vma_start_anon_pgoff() - Get the anonymous page offset of the start o=
f @vma
> + * @vma: The VMA whose anonymous page offset is required.
> + *
> + * If unfaulted, then this is vma->vm_start >> PAGE_SHIFT, if faulted th=
en the
> + * anonymous page offset at the time of first fault.
> + *
> + * If the VMA is anonymous, this returns the same value as vma_start_pgo=
ff().
> + *
> + * This value is used for tracking MAP_PRIVATE file-backed mappings by t=
heir
> + * anonymous page offset.

I assume this function should not be used with shared file-backed
mappings, right? If so, maybe add a comment like the one you have for
linear_anon_page_index(): "It is not valid to call this function for
shared file-backed mappings."?



> + *
> + * Returns: The anonymous page offset of the start of @vma.
> + */
> +static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *=
vma)
> +{
> +       pgoff_t pgoff =3D 0;
> +
> +#ifdef CONFIG_64BIT
> +       pgoff +=3D vma->__vm_anon_pgoff_hi;
> +       pgoff <<=3D 32;
> +#endif
> +       pgoff +=3D vma->__vm_anon_pgoff_lo;
> +       return pgoff;
> +}
> +
> +/**
> + * vma_end_anon_pgoff() - Get the anonymous page offset of the exclusive=
 end of
> + * @vma.
> + * @vma: The VMA whose end anonymous page offset is required.
> + *
> + * This returns the anonymous exclusive end page offset of @vma, which i=
s useful
> + * for expressing page offset ranges.
> + *
> + * See the description of vma_start_anon_pgoff() for a description of VM=
A
> + * anonymous page offsets.
> + *
> + * Returns: The exclusive end anonymous page offset of @vma.
> + */
> +static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vm=
a)
> +{
> +       return vma_start_anon_pgoff(vma) + vma_pages(vma);
> +}
> +
> +/**
> + * vma_last_anon_pgoff() - Get the anonymous page offset of the last pag=
e in
> + * @vma.
> + * @vma: The VMA whose last anonymous page offset is required.
> + *
> + * See the description of vma_start_anon_pgoff() for a description of VM=
A
> + * anonymous page offsets.
> + *
> + * Returns: The last anonymous page offset of @vma.
> + */
> +static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *v=
ma)
> +{
> +       return vma_end_anon_pgoff(vma) - 1;
> +}
> +
>  static inline unsigned long vma_desc_size(const struct vm_area_desc *des=
c)
>  {
>         return desc->end - desc->start;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 939b5ea8c9e0..ebf0d912be7d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -967,6 +967,11 @@ struct vm_area_struct {
>          */
>         unsigned int vm_lock_seq;
>  #endif
> +       /*
> +        * Low 32-bits of anonymous page offset.
> +        * See vma_start_anon_pgoff() comment for details.
> +        */
> +       unsigned int __vm_anon_pgoff_lo;
>         /*
>          * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_v=
ma
>          * list, after a COW of one of the file pages.  A MAP_SHARED vma
> @@ -1041,6 +1046,13 @@ struct vm_area_struct {
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>         struct lockdep_map vmlock_dep_map;
>  #endif
> +#endif
> +#ifdef CONFIG_64BIT
> +       /*
> +        * High 32-bits of anonymous page offset.
> +        * See vma_start_anon_pgoff() comment for details.
> +        */
> +       unsigned int __vm_anon_pgoff_hi;
>  #endif
>         /*
>          * For areas with an address space and backing store,
> diff --git a/mm/vma.h b/mm/vma.h
> index 0bc7d521e976..54ed7c744e3b 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -283,6 +283,20 @@ static inline void vma_set_pgoff(struct vm_area_stru=
ct *vma, pgoff_t pgoff)
>         vma->vm_pgoff =3D pgoff;
>  }
>
> +static inline void __vma_set_anon_pgoff(struct vm_area_struct *vma, pgof=
f_t pgoff)
> +{
> +#ifdef CONFIG_64BIT
> +       vma->__vm_anon_pgoff_hi =3D pgoff >> 32;
> +#endif
> +       vma->__vm_anon_pgoff_lo =3D pgoff & GENMASK(31, 0);
> +}
> +
> +static inline void vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_=
t pgoff)
> +{
> +       vma_assert_can_modify(vma);
> +       __vma_set_anon_pgoff(vma, pgoff);
> +}
> +
>  static inline void vma_add_pgoff(struct vm_area_struct *vma, pgoff_t del=
ta)
>  {
>         vma_assert_can_modify(vma);
> diff --git a/mm/vma_init.c b/mm/vma_init.c
> index 715feee283f0..baa7e82f47e3 100644
> --- a/mm/vma_init.c
> +++ b/mm/vma_init.c
> @@ -51,6 +51,7 @@ static void vm_area_init_from(const struct vm_area_stru=
ct *src,
>         dest->vm_end =3D src->vm_end;
>         dest->anon_vma =3D src->anon_vma;
>         dest->vm_pgoff =3D vma_start_pgoff(src);
> +       __vma_set_anon_pgoff(dest, vma_start_anon_pgoff(src));
>         dest->vm_file =3D src->vm_file;
>         dest->vm_private_data =3D src->vm_private_data;
>         vm_flags_init(dest, src->vm_flags);
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index c52b23773cd2..26d9210b1e8b 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -577,6 +577,7 @@ struct vm_area_struct {
>          */
>         unsigned int vm_lock_seq;
>  #endif
> +       unsigned int __vm_anon_pgoff_lo;
>
>         /*
>          * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_v=
ma
> @@ -612,6 +613,9 @@ struct vm_area_struct {
>  #ifdef CONFIG_PER_VMA_LOCK
>         /* Unstable RCU readers are allowed to read this. */
>         refcount_t vm_refcnt;
> +#endif
> +#ifdef CONFIG_64BIT
> +       unsigned int __vm_anon_pgoff_hi;
>  #endif
>         /*
>          * For areas with an address space and backing store,
> @@ -1320,6 +1324,28 @@ static inline pgoff_t vma_end_pgoff(const struct v=
m_area_struct *vma)
>         return vma_start_pgoff(vma) + vma_pages(vma);
>  }
>
> +static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *=
vma)
> +{
> +       pgoff_t pgoff =3D 0;
> +
> +#ifdef CONFIG_64BIT
> +       pgoff +=3D vma->__vm_anon_pgoff_hi;
> +       pgoff <<=3D 32;
> +#endif
> +       pgoff +=3D vma->__vm_anon_pgoff_lo;
> +       return pgoff;
> +}
> +
> +static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vm=
a)
> +{
> +       return vma_start_anon_pgoff(vma) + vma_pages(vma);
> +}
> +
> +static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *v=
ma)
> +{
> +       return vma_end_anon_pgoff(vma) - 1;
> +}
> +
>  static inline int vfs_mmap_prepare(struct file *file, struct vm_area_des=
c *desc)
>  {
>         return file->f_op->mmap_prepare(desc);
>
> --
> 2.55.0
>
