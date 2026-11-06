Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937442;
	b=sZ5b/Mw1W+l/G1R1y5Tbd0dnoEmHkTaFETy/qHaqTQkEkgSAd2GjJohBV0kTSIIkrYp5
	 IPzFoL1dli6OXvJBM9LJ5MM7R3inDBa4fHeN+PWfEESVxIsdNl8tBUfZzBdRMWZ7dlwjd
	 Z70Itly5u5Kvl13D/OXXsvGRL8kxKgRUXFGI7ca7GSISgMDT4h1CC9lmjVTwzIZPZMs4C
	 iR13ynxBc+FnVicvsd1oxxrv/JEqjijVZ4t8FajaWtTR/DI2bVYaYkNOlGWvmabfJ42ez
	 1wHb3gHKdRxgQbyvvERFW6KzfCwGXDMK7DdW+RNfkkqz9PZi/tSrThNMi/KT5hNZ29g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937442;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lHXR2FH3bh5spT35/G4nG+cv25q2yTDGLvo0NNx3ZVg=;
	b=nl4XfRVBEGYQ50ohOszztjsVrLYqrpGsekGvQzlfjlf/k3rtNY7miTtaOxT/DZN7yeYo
	 MXPhP4zdSFZtTypfCn0n5tbd9pGx5qaWgOHseLhuGBf1HGHzQVgwuXnDXw18JpyGN1JpX
	 z3r0WM1+27SOillJNkM2kD18Q6ixUMSsoM4wOt/CjDFzDXz8Y5i0mGlj5VA8M7vTi420o
	 jKGcTPoiya8aecA7uAIYGWQtTmA8vfYmYuhhnH8TKyMFJq5E8wwi6yNKLaIcxWGAXM51k
	 /sDyazynVMasBghNcZSEw068fTrvUCrT4cDsECpx+grodIDL9V7ifqTyLuXtrWhE4Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqiaXlxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2142606A338
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqiaXlxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F9C1F008BF
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 03:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793937441;
	bh=lHXR2FH3bh5spT35/G4nG+cv25q2yTDGLvo0NNx3ZVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XqiaXlxiATDzJrgw9f0OYt1TfHLb2ipTeIcKivy65nis0f6TmA/08oHIZ0R0nf5m6
	 nUvgA0EXaiwf1XpMUGGc013GsyUxECqfq1Uh00oLL7zzVrZ//HgstfV0QrxF9mqluK
	 NKkBvgk64ubOOcbPj23ww4CMq5VaK+O5NA3iSPWNPiVWpS/jS5m6iqdqtnQXeGv5w0
	 y48/IZagRGHa+F1jeQ+VqNbGxtUf9G7I+pzA0zivc6NUUr/7OjAG+Y1R8Paj8q4Cin
	 LMpizKHXpmKlbmYFDP5mLxbU6mR0aZreEhaVl2amkcHQT9fKPqzhlS/9aCSoy1O64o
	 /7S9mxQbxAZMA==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f36c18b75so12730885a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 19:57:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByc0+nJGJR48msdv59iz2OHswGswXicGuEORSopX0aMR0iso8lRRpvt2MrxpPksCYQ5O3ASyr34j+3dZ7zhdENJ@vger.kernel.org
X-Gm-Message-State: APuU4Z/zd7QA3eCMcOH63alzIjVLGbX0R7Z46BgTKcTCvdlSlyJldDIq
	grva0rwP57M5FUiTyaYAqLxdkoVGRVscYO6MiuEV31XNlYtKWJyrOhEASVHhP8xekj8o3W9W3Np
	77BywgrofzjbY0Ys+y/5InTpVLH8LeFk=
X-Received: by 2002:a05:620a:6c88:b0:939:b8d6:9b1c with SMTP id
 af79cd13be357-945f34af2acmr198595685a.19.1793937440071; Thu, 05 Nov 2026
 19:57:20 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 11:57:08 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wCd_j5or0uHwPLq0PUixcXgiFim=_d7uUhUhAuQf0nTQ@mail.gmail.com>
X-Gm-Features: AclHuK8deEInzaZZJ26UPrq6mS-8I8VnGN9Ocbio_nvLAi7VvywQ3Ss3UdDHcfM
Message-ID: <CAGsJ_4wCd_j5or0uHwPLq0PUixcXgiFim=_d7uUhUhAuQf0nTQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] mm/rmap: convert remaining VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
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
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:32=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace the remaining uses of the legacy vm_flags_t flags in the rmap log=
ic
> with vma_flags_t values.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>

>  mm/rmap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1131b76bbbc2..cdc97fec8586 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1196,7 +1196,7 @@ static bool page_mkclean_one(struct folio *folio, s=
truct vm_area_struct *vma,
>
>  static bool invalid_mkclean_vma(struct vm_area_struct *vma, void *arg)
>  {
> -       if (vma->vm_flags & VM_SHARED)
> +       if (vma_test(vma, VMA_SHARED_BIT))
>                 return false;
>
>         return true;
> @@ -1660,7 +1660,8 @@ void folio_add_new_anon_rmap(struct folio *folio, s=
truct vm_area_struct *vma,
>          * VM_DROPPABLE mappings don't swap; instead they're just dropped=
 when
>          * under memory pressure.
>          */
> -       if (!folio_test_swapbacked(folio) && !(vma->vm_flags & VM_DROPPAB=
LE))
> +       if (!folio_test_swapbacked(folio) &&
> +           !vma_test_single_mask(vma, VMA_DROPPABLE))

Right, VMA_DROPPABLE_BIT is not available on
32-bit architectures, so vma_test() cannot be
used here.
