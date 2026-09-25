Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF8438473
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321752; cv=pass; b=up8Nuh/ffkY/gSOy3NBWGcYOGyj8FEbzf6urTqVtUf1FEAUIulnzZRRFXDZcMl9AGCWqSFx50mGubNxoxsHXOpRsIJAZf6drSxHtOn/pgRgoQJf+tPlhI0GiC1SVeWBXV0jO19wG+xKTzmG7jGYZ7Ri1tpufZk4jm9ft9DKUkRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321752; c=relaxed/simple;
	bh=QleRDPze6Fay9Y/d+9oXHJ/g/hcfyRz6rdp7ap/qQ+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNnlIaxXJh9V140s5GwlT/cyXS42dXd99SvtgPghkx5RvqfzLh6AkGW4z0MuaN+Hq8FGjK+NtiTqm8W4JNNwzFiqhTeB6yMzqo794fZjGPejttGR2bMIlvBvXuf72ufuPkr8d/YYYImGHRbRhaIGbfNfXGJUMHvqX6UqZmS4vqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GBGvWS35; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBGvWS35"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so5458a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 00:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321747; cv=none;
        d=google.com; s=arc-20260327;
        b=W6UN+MyQNmSZegYfDjoGw2/d1zR/xrrDOqAcvTLNnHPlZyMVZSKMwMcucYmqsOy4Qt
         tFh6ubKxECsNVkaTUkHho6uzgTOCxUw3LT6yACWe6QCirff/gHUQrs61KSd7UGvSoyxe
         bEn06Zqn43L/ulrwR2VozhJattJ4ufRACu4VX4lTurfiLf+72z3yPXg0dbhdkoOBoZYI
         ma4BUOPs4LRHkc8ONkygLzQqF2bjjl+c6h0N1Fi5zi/jxP+VywYn0wELAHQlchCej96X
         sBX8CEHwUlQ5Ik7P5+CY4zIDnSunbD8ukVQjJvICW62O/5xbN0uIPLYoI4mFPAkujWmm
         9rEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
        fh=a9B1/W44yRD8f0BriBlJ63Ux79/0g7CpOdkBeFQuo0k=;
        b=rt/zIjiSTBxhBxlLPAMDTc9tpX0VXDJFLXAOI/3Syn8lReEUsTUO559/eILrl28a5p
         awOvjL/ITjDPlOJJLMR7oqUFNNCy4+Zt410wsRVxhxF/J+rUBMcrbEdw8KYyTAkh5OVf
         B9PnJD1AAYmMFvIKeSFRFGA5TCXdLu8rE7N0oV8PEMuaZEp/lD+oa0dlgwCgTAaVZJXP
         Yil0wraeT2x/NtZh8dOTbdUWKjEO488ZaJ56G9Ky76PbnTLZw42T9EiLQ2YTMpFn0qdV
         WmmCslSePM7kjZpK704F95vT9D2t2508Xx9CO3Whr7VQiHlltUlwZcJbObd1W62IXAqo
         OZTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790321747; x=1790926547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
        b=GBGvWS35CRs52H+n0HibcXUxhDsFXef4XaGWh2jw679xAwuCg1uimStbUKyOmHzo62
         aSMchmwbdzg7paOFIuf/8kQtxcF/LgrwJ4PWnwSTcUhTacl4XbbHR9zZfdic0iMf+lpj
         xanAi9EmnoAPJUYHYLgxzOZH9198NTbtD+rg556M+8CT6VKcwMlDw2jxIv5UX9YzP9WH
         OJARG7aOAYL2SLSrUoundJe8jBeryf8iNeYj6/bFKGTzhaYARaL24JE2HpwdUQCtcaMS
         Afp21cIeWui2Su01twICQfXS+YmDFvrnzmWqxdXqsREfAh07Rj07E3xCH3No5p6o7nNy
         +gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321747; x=1790926547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
        b=BqxBVhNFTIX5FH4K28P/JTIjJRtytfh3WpdUSo0FTYDXqdbiR0y6Vp85L50BRnkd4R
         xXywt8SazfF9LZtdtfdNAwL4Gc92O/xPR+CeCvlzDaDcGiCFZVpDomYtzPMf9ziYciys
         MaaSOkcAcsEjnvnzESla2yHImtSFJbeX2YIQ5drFNZvo6qVvkh4gKaDadCB1VEpO3mIg
         AvIYvM5a2X++Y6gITyyHxi1CAuxdoJ/Tc1LAykQYJtSDmfV4ETlQRXUB9N+od73BHJ2H
         3y0k+KpTELGsxU8hxKF/CpeIEjN7ZpcCCE8ma/zsxStv4IAOijVnCKQlv7xjgjdFJkLp
         DmIw==
X-Forwarded-Encrypted: i=1; AKwUvBydmFq47v9VWkVYRNwPmxXhkuTZcYkt9QzanpJ4wzwUQKSA4TCyLQ1ewvUNu2Xg1KdKqakdnMC+a2uN20X5cEPL@vger.kernel.org
X-Gm-Message-State: AFuF++n9+ZkGdGk4xDY+Qq1Bv03LbpcMkL1QKxNNRDONJpYoEq9c0KMd
	xruP6Er07KYIfiI5d5WpsDRlWmp/jKUiEMeOXzIvPYedTDCC8BxG1/B9rswS/YhV7RInGTJp1T0
	EamGNidL/0TGLKRPhGIe5VHm6fitSqohMFSmV9p/5
X-Gm-Gg: AYBFou2gf8MVZCuH/71STENjdBG1fv6eHVJR4F3x9cMFVNJqHxdfkU+KoCin7jTs7qh
	BT1UOoFurBGvsW59DjIjTo85WsP5AbbyZruopEEc5VV1wa6iAXTxCYqqYFsCqksvUsgUEXtYxHZ
	c40V/4rkeV2ROywK4IaAlbU6PEhFh/4EWOTGdRd2fPUoKQH/1GbiGSENjJQ28yMZ273weejgGWF
	nT30n3hy8mo1X22ZPzSdEVlT3Hm6nys8rY2ywZC/77W3HhawIdizUKx9WLAuQ66fYAkQYlQMmNT
	jPNnYUPLEEBm23iNqgJ8R9x4icjimcgFhUhy0mVIj/tnUYPaxgR88evvKkiYnukB
X-Received: by 2002:aa7:c64c:0:b0:6aa:e332:b762 with SMTP id
 4fb4d7f45d1cf-6aae49c58f0mr23500a12.8.1790321746110; Fri, 25 Sep 2026
 00:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org> <DLNSNQP7L4FM.1JZQ0GS9300H9@nvidia.com>
In-Reply-To: <DLNSNQP7L4FM.1JZQ0GS9300H9@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:35:33 -0700
X-Gm-Features: AclHuK_NuiQlFRW78Nf23QbG4E3oej6nx-ZjiAb0IRRSHloLT2xGmv-6NXWsN8E
Message-ID: <CAJuCfpHpo58c6eOPY_CvP+ts2zwXQEDNX2bohXd0CBANYWrBWQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/40] mm: make map_kernel_pages_[prepare,complete]
 internal and unexported
To: Zi Yan <ziy@nvidia.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
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

On Thu, Sep 24, 2026 at 12:30=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > There's no reason to export the symbols for these functions which are o=
nly
> > called from internal mm logic, additionally there's no reason for them =
to
> > be declared in mm.h.
> >
> > This patch therefore removes the exports and moves the declarations to
> > mm/internal.h.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h | 3 ---
> >  mm/internal.h      | 3 +++
> >  mm/memory.c        | 2 --
> >  3 files changed, 3 insertions(+), 5 deletions(-)
> >
>
> Makse sense.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Best Regards,
> Yan, Zi
>
