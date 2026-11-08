Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794122438;
	b=SnUX/niLx5pjdhG6RIJw7y5FV/m4shhAMCOyrk/2Wks8IdVbreP7m17mEvey0RzYDpUO
	 FOzAqZCu+u/2VknvuW/YAI4KWbdIl3azwyfPXZI+EB/DteQCEontc0ICz9ghT/qdWbIQ6
	 XGnLjcJpWNSJba32w+fcPFELiPVoVpoQwu3ECRfuRhdQrn4LpbejhuxxqkalpKYnu6qQw
	 5uUwLR+nz15FFAB42A6bXHWgk/wOWleic7ZL97iehOktLQ/jNtcU6exZwPMo3SmtSSqET
	 3rwXJj15SGJyT6KmUtUeHhBrIZYQPxUdXXiqgkRFApptlLo+LZzrQWVw9RbV5Ywgc+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122438;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j18geaHLD1uUk2z5k4sfYhqgD5g0IHFNcch65ifUnps=;
	b=4Cfhhl4LJET62FAeQDrk1drq5Wl2Ja3DyqUW4OrfCRPOYbcSsNwXf6PT+JWI1jBvnT/n
	 H+dm8fOg8gIUiBNKk9dhFyJylbdAuExGV5eQ+Vqm/rSzFXAZgqEr/cGI9kjs399xYGbI5
	 K5qMRZicWTdWCtqqURrtWHLusqrVS5Fn8rjU1InCA0Oj3bbNqtbO2mKRT+3PQIOb/bvaD
	 rQPi1FJq/xN1AYSScTKhpq4YNR/LGi0H1ZN4m0ij/8fOMYphVzvbK0/H2dzO8qokv2aKX
	 2g1JAqSkHzQ4AeejvQDTUkfMgeBLRMOhI4+3HUJ8H++8Dfcnyuv6UIPfxKNPwK8I3Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaKFmQvQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C095606A31C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaKFmQvQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E91B1F00A05
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 07:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122438;
	bh=j18geaHLD1uUk2z5k4sfYhqgD5g0IHFNcch65ifUnps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AaKFmQvQta9usDHygx9uccJHEqeTnWugFunAqTjpL0iWjPubVnhwwIoEzO9QGfEjh
	 oBkzuQ4jgnARyQqx0p9cgXjXCrtDqfwZJHoujPa0JjdGq/+mmEuBhmTP4pYPgchQQG
	 ondEXUnRZsZxZDoumHOcCxqmCpWjGB9JtBOjmeHKhkHuo5EUORoiyKqgnSNigiCK9w
	 paSuftxmpK22ucA4kRqcOXf+sDSdA5TNzBWjxvDQanrnXsLqkCUn81e637Ru35zX/0
	 z/0n475cKitrZgxxS18RgYv867ayRKjpBx1TwG35q7AnFKuKPNaiwFqcWuWKQNBbue
	 zrleiCUwBdJig==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f22a8515eso20367585a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Nov 2026 23:20:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGyBO+3wWlOW05Udxk3aDUlnAtrC21m7QGyYYqs2qYlckgsDptwO6X/PnAvuUx8j/QwUVCgbYFrA7y1BSrph0bC@vger.kernel.org
X-Gm-Message-State: APuU4Z/a1EbMi5cH0Gymw6kTwl1040SxI9hlojsA4TXIIqIA6gfmcEDZ
	EuFYiZHWbZEjDrk+1O9O7gH7iltiIwCRexsVFyWikazSz2qgBDxYkuE1FNO3zqf32Fc3RVAUxuj
	6evMUof28R0uDPJtX8Rs3qKQ0bIv8QGk=
X-Received: by 2002:a05:620a:6190:b0:945:d7a2:4b58 with SMTP id
 af79cd13be357-9478427d0f5mr101426485a.65.1794122436125; Sat, 07 Nov 2026
 23:20:36 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-2-0d3cd15ab75f@kernel.org>
 <sashiko-outbox-200257@kernel.org> <au2_PPpdAMgRJZtX@gremlin>
In-Reply-To: <au2_PPpdAMgRJZtX@gremlin>
From: Barry Song <baohua@kernel.org>
Date: Sun, 8 Nov 2026 15:20:25 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yWQom=cG5vw2B-FR8+7wNU+rwZkvghjAxusym+3OH96A@mail.gmail.com>
X-Gm-Features: AclHuK82gk7ruViNEj2rccGK1fXvxCJcs3PhbZ9Er7PSONJ4wRSmOw3bXHmiVAU
Message-ID: <CAGsJ_4yWQom=cG5vw2B-FR8+7wNU+rwZkvghjAxusym+3OH96A@mail.gmail.com>
Subject: Re: [PATCH 02/13] mm/filemap: convert fault and readahead logic to
 use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:53=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
[...]
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2=
026-vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D2
>
> It seems these are valid, oops!
>
> Andrew suggested a fix off-list, and I agreed to this as an in-place fixu=
p to
> avoid respin.
>
> I have also updated the series locally to reflect this change:

Seems like a reasonable fix. maybe_unlock_mmap_for_io()
could have released mmap_lock, leaving the VMA
unprotected. but  ra->size *=3D 2 is still going there no matter
if the vma has disappeared

For the original patch combined with the fix,

Reviewed-by: Barry Song <baohua@kernel.org>

>
> ----8<----
>  mm/filemap.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/mm/filemap.c~mm-filemap-convert-fault-and-readahead-logic-to-use-vm=
a_flags_t-fix
> +++ a/mm/filemap.c
> @@ -3410,6 +3410,7 @@ static struct file *do_sync_mmap_readahe
>
>         if (force_thp_readahead) {
>                 unsigned long folio_nr_pages =3D 1UL << thp_order;
> +               const bool random_read =3D vma_test(vma, VMA_RAND_READ_BI=
T);
>
>                 fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
>                 ractl._index &=3D ~(folio_nr_pages - 1);
> @@ -3418,7 +3419,7 @@ static struct file *do_sync_mmap_readahe
>                  * Fetch two folios so we get the chance to actually
>                  * readahead, unless we've been told not to.
>                  */
> -               if (!vma_test(vma, VMA_RAND_READ_BIT))
> +               if (!random_read)
>                         ra->size *=3D 2;
>                 ra->async_size =3D folio_nr_pages;
>                 ra->order =3D thp_order;
> @@ -3438,7 +3439,6 @@ static struct file *do_sync_mmap_readahe
>                  * pad that might exist between sections, which would be =
a waste
>                  * of memory.
>                  */
> -               struct vm_area_struct *vma =3D vmf->vma;
>                 const unsigned long start =3D vma_start_pgoff(vma);
>                 const unsigned long end =3D vma_end_pgoff(vma);
>                 unsigned long ra_end;
> _
>

Thanks,
Barry
