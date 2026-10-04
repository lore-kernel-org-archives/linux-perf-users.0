Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1A481241
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139165; cv=pass; b=a3mOwUA4xU5lAlAahhePtcjCvREkXM54JNQTiE3NEoNrGLhm1XzA9JRytPqLbBGvIN1Pmz3rT7XjCeLM7ftAIySeZANZVuUGyB6PwSWArrmXfIVdVJNrD0EmejfmjOypjObivkOIyiQUGu/9LdZrLjJpeTdVPv733gVwV5do7xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139165; c=relaxed/simple;
	bh=Q5SKncuQynV4x7Bps+RIZqUEFmiH2TTHOAAQrnnR074=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOPg2BTanazrpyHS+YNTFVDjWjoGJig70hFk8mUANdkWE3k/n9cj9DzTKM1C/BnU3rJ87eK+LovHW3bBUrI7yWmHvnekdoBA5u+zKp6LPbMieJ+NIGzA0pJoXKa0AaoSOG5xteJCPmlmp/Nse9UyK4wgcDFcEAMxYJPBn/u0Gd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0iHyxjb; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0iHyxjb"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5337c7b9937so265811cf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Oct 2026 11:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791139161; cv=none;
        d=google.com; s=arc-20260327;
        b=EDpXrtvPAL7+xUFyODx6HOQt2ioULLZBvS2pI3H2UxdCaPn0p4mC3QoMM9gK8u3iQC
         c92vOIW+uc0+5Nvt/wuuHguDjhvUv1iwDypfabQLfWDEnJdrLwMi8CTrzuwIKPFkMBXs
         incdDevuTZXFvGiZStCFaB9GZYzgXadETe005oJhyrw3OIApH/U/7pg14Zos/OpGPkzV
         b2deFlGokLhWCj1amse0ALHPvdnEOV+TQztambJxHuIhtqWW1JrdKxBWFFfblGt9nxf+
         tX6tqRlV54v8H35/9pBSPJ2rTtPtKkEzroRtA12KiElAciEn0ky9ZWiPX3w6WGXAq3CH
         kISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        fh=oM4ALxvBA5tRO2YDBBXafbPJ5cMiQBYEiI0EYIs0s1w=;
        b=iVv6sGOSaZjRj+7ECNE807tyzARxUvTx0kB9TVYW6vCCV3sPDZoQ8e0Weuyf4lPwQv
         uBVSPDA4dCJkjl5LtnQV9uKgae07dqZm4dcFYHTI0UDelGeNBXZmiZIUL6S6NtGvLRlS
         /LGBAaQna/LNLIFdHwkKsthdlGCdb5BZm7+2MdFhhYS/s09eHzWFUDr+WvdthlAYYj/f
         cJ5yHCa59JrxZVt+G4xyvoE8khvueqNTSSo40VZ6JhRVcP7mYRNF2V/oqT3gD8A9K1CA
         Du+/U6p0O12E47IQmoZ6O6fvTlilCPLhqjBr1P8HD3rp6fdbFWsjNfavtxLrbYc15K/n
         kAsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791139161; x=1791743961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        b=l0iHyxjbrFA0mj0qSWG3UEuOwCfeu39THooR7JdjvlpS5iPbcpbOGXWgFlwrHqiq17
         g6OREDzEJg1B4R9e3NlLt/FQGfnUhJDJq9ugUkIwHD8Ouc6I0KCAE+AjFJ5im2Q3teHM
         xpabytF01LqRy3edoNlhxz/KOOwY/glawDCIRDkU1ItyqnPxe60feD3VqcauD0MIeU4s
         Cvv/OfjgN/b+SrE6g8xki0vgbqOIO/2Zkxe+N05IzJfOVKCkkH4F7eFCLA6UNgq7uegJ
         Iz6k97ECHJF0Ws6uFXO0NrKMD645vu6jOd91RLmcYxQ0T3ig64z73JKnKEdXvgZ6oM2B
         rqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139161; x=1791743961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        b=ln+elsRhvRAXsXqhcEQ1q3iz1dRGFwAW5UVY7WKntW87FGOCnbWlI3qiWqgwdunIKX
         1QDMPm/LR2VA4iApuQAmsz8Ueot7D4jrozYkmxDlj6bKbVBvzPQgaufWGoRD0As0VlFT
         cp17UY/kONcrUx0sTXLKagfVDIdqHdx/YlxC4ZQZRET8sikA2hmK94G52B3ZTmtBG7Qt
         hwKL9S4jHw/5zuhYAFSO+31u51tiA5fOFi9RnhJQfqR5ZZO1xqXh1xTaqsAz+AX9Lu3e
         mcv/tQ6niks87BNCZ2aGxi6kNJle2Yfn55JjiuVHACru86tcQ5E0NwNph1T3R3GdO5Fx
         cHqw==
X-Forwarded-Encrypted: i=1; AKwUvBweeNdeZJgZCNhIIe8VYp3Dno4niM7DSO+adAGesZPWt7Q9G7bbCoLpy/fvtFVHJ+n3KQHpdrBM2befnMcBQR/u@vger.kernel.org
X-Gm-Message-State: AFuF++kskvki9yjedu8WNxdTZkMQGeYWSd6xKae/LXwANaIUbB2cy7yK
	v4y9S+tTt4nRvTPLE8DbU4dQAaMk3AUMDcVi9fjVKDtI657oaiOKuUguXQ9fgwRFQJ5sUvok7kQ
	mEISnzTo/CSuDmKYMkmyGhof/cjCSLKDOMCFRjTPI
X-Gm-Gg: AYBFou2QjJHG3Y5LfBD+r0aOoxEtt48LJ/OU4W9unu+ZKGyDQKpNpDQTEGAUhp/FGy6
	txjEBadRBCrhE6cLqrE3hfyBoq8FGqRZSeyRpx/2tvHf0ODEH7sWql2b1fK/bACGom/KxsklOUG
	vcWnrCOarn6ocbvvZAOPOKZKlL8rXFmMOfr1G1CH3B48Mj4R6NROIJEGOov11XpMMz99NwBRZQs
	36WMOano9sxJ7RTSb7fi4J7/l6zQBidjD9hZ0cF2AgEVTeZWke089JSx2OPisQGcAQUq6QPFSTG
	1jHD96hYXR3mGfcAZkLwGhq8lyle4nKnCzswunNIh/QsQXRU2IYxkRhu
X-Received: by 2002:a05:622a:a16:b0:531:282:6560 with SMTP id
 d75a77b69052e-5351322e1b3mr19806961cf.15.1791139160071; Sun, 04 Oct 2026
 11:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-21-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-21-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 20:39:04 +0200
X-Gm-Features: AclHuK-BFFMO7RL_23L1uoIyefqTPzoxo4liaojYggefG4PLZrnFo0OrrSwhSqQ
Message-ID: <CAJuCfpGtyaqwi__OXcB=iy2+LUVzFnLo-Q=Rdxz728_EHdTaWA@mail.gmail.com>
Subject: Re: [PATCH v4 21/38] uprobes: remove VM_IO, set VM_MIXEDMAP for
 mapped kernel pages
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:40=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> These are not MMIO pages so VMA_IO_BIT is an inappropriate flag to set.
>
> Instead, set them VMA_MIXEDMAP_BIT as they are kernel mappings and this i=
s
> the appropriate flag to set for those.
>
> This provides the semantics required - no VMA merging is permitted, but
> does not prevent GUP.
>
> However this has no meaningful impact as these are refcounted and thus ca=
n
> be GUPed.
>
> A previous commit already prevented __mm_populate() from being invoked on
> XOL areas, which VMA_IO_BIT was previously relied upon to do, so that is =
no
> longer required.
>
> Both VMAs set a VMA name, so always_dump_vma() returns true before
> vma_dump_size() reaches its VMA_IO_BIT check, and thus there is no change
> in core dump behaviour.
>
> Change this for both the core xol_add_vma() function and the x86-specific
> get_uprobe_trampoline() function.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  arch/x86/kernel/uprobes.c | 2 +-
>  kernel/events/uprobes.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 65a2de82ecd2..0f60c0d076b6 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -715,7 +715,7 @@ static struct vm_area_struct *get_uprobe_trampoline(s=
truct mm_struct *mm, unsign
>
>         *new_mapping =3D true;
>         return _install_special_mapping(mm, vaddr, PAGE_SIZE,
> -                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
IO,
> +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
MIXEDMAP,
>                                 &tramp_mapping);
>  }
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7709ea882477..b89cc5cee002 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1726,8 +1726,8 @@ static int xol_add_vma(struct mm_struct *mm, struct=
 xol_area *area)
>         }
>
>         vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
> -                               VM_SEALED_SYSMAP,
> +                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|
> +                               VM_MIXEDMAP|VM_SEALED_SYSMAP,
>                                 &xol_mapping);
>         if (IS_ERR(vma)) {
>                 ret =3D PTR_ERR(vma);
>
> --
> 2.55.0
>
