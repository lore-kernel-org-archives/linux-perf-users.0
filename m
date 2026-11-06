Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793936864;
	b=XqsCl+mu1gQvh6tuSRTzuI4W+xaIoevQqGvvTYlStCwvXPzrYQ4sUNZZubgIgtqWQb+H
	 TnfJz4834hGgprnfOlLInO6F+1TsmEz9OIfWZ00oqsYYZ2ZoOEMFB/yc7Nn5L5mFgYjdk
	 gOXlBGzbyKDUuOzBlN0iAZvE4TLZYGXEZ7jJOGf+zqAGLOtfYknvc8kN/Ti5K3tvIZrKn
	 v5IERZb1KG5sSy3pvSxS5l0GWYuYwWhv+KVOqfBBcBxWf41hP5m+2wcRXhXEc0+YeZphW
	 24168mv7Xs+hKtTOrEodEkG30nGgAHCVpyiXQyhxZZMXyn4q+JjT2eRT0LqAYkKmJ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793936864;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7itVVRO0OrCMzanAOyJRHIm0MPtgmrlnhYWCxSa5SEs=;
	b=ovKyTSql7bdlkydXczjOC6vqf/JR2HYAJT9/zpU1dDTAuKBYPSF8F68aXpXKuPDGv8fd
	 Scos9UnyXoPDCW99kFTWBTw7cDJwGemmomW0LizKelbrYlUXq+IsYHwp4BjvLvvFe7sq9
	 nbHVpI+FCxoolIPSz5/nb8HxQ73WugqQwC/n8fYxHCHzXKWWKDujOOpRInTeFf/ZQ582K
	 dM+a0gdS9C3HCwIAGGv56tdGDHyse38tDLkhpA2W0ze2V5nLVnLRvvK91fiBMukoPUBYq
	 4MXOVFsnkq8HGmzG707nLdpCQc8e0vLaJVyAhsB1ghr6iRknYc3wwsiTsrkx/bNOPpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IboQVEBX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630AE606A332
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IboQVEBX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB2A1F008A1
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 03:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793936864;
	bh=7itVVRO0OrCMzanAOyJRHIm0MPtgmrlnhYWCxSa5SEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IboQVEBXl4jWmUIvw0DOc0QCJjQ8dTtJqHWh38IstQq4GF/XzX2BgioRpgWgX6v3P
	 D5fDo4sg7rNsqSrYNK8o/zN8HDEQJwDTBpkQc5B6wdsLuzlBioIZJ1JXxYScTaKhKq
	 EXzy4QVcoH3qpcgpOmOr7ueMPQ0Pdq3rpjD4upTnMEExPCwaJHTNl7ZEa+kCA6YMjg
	 V1+Zo6uLqCaTfqZG2lyPYI8f9v6lHJhj3xgryyJGW5y3JtAdTcHJwPwPYL8MTIL+j3
	 DjsAyuNPIoqIO1HAGO1EEAT+4quG29QrQNBWH+drmvQELISCJ4FKo/roKRV/DkIV4c
	 oMSGhP/EEgang==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93a40a9a01aso160563385a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 19:47:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzxF3MD34i5piNTDRvVK1DbX7s6JV6Ud8m1NQ7iKCKrNi9nHkc4syDSq+Z+jSwgWtPAB6TT9lIEq7C0uxRGPJcE@vger.kernel.org
X-Gm-Message-State: APuU4Z/CVjJaAWUM5I2y9xAVZorxHZlzsj2yH20lRn0aRg6RSZmGuyiR
	tOcAs+Lv142PALN8xQfdBq2qEDzVNiiVt0SEGQhummc+zCeBJl3eZoPMeA3wT+CuhntXHut2AIs
	wYwvFFIq6iuv5Zh/0qw9j9jUenW5gd/M=
X-Received: by 2002:a05:620a:6ccd:b0:945:d3ba:7d99 with SMTP id
 af79cd13be357-945f3593146mr175996585a.37.1793936862458; Thu, 05 Nov 2026
 19:47:42 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 11:47:31 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wFi9mqSsq9RFoYP8m0GbqU01he_icbP2VLPhBfQAvCOg@mail.gmail.com>
X-Gm-Features: AclHuK8VX6mOjbrvfm7oXhssK45doLoq2eZ9cV_P4690FurSVGBQe9E3r9SjObI
Message-ID: <CAGsJ_4wFi9mqSsq9RFoYP8m0GbqU01he_icbP2VLPhBfQAvCOg@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm/gup: convert GUP code to use vma_flags_t
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

On Fri, Nov 6, 2026 at 5:31=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values
> throughout the GUP logic, both for the MMU and nommu variants.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/gup.c | 45 ++++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>

> @@ -1514,9 +1514,8 @@ static bool vma_permits_fault(struct vm_area_struct=
 *vma,
>  {
>         bool write   =3D !!(fault_flags & FAULT_FLAG_WRITE);
>         bool foreign =3D !!(fault_flags & FAULT_FLAG_REMOTE);
> -       vm_flags_t vm_flags =3D write ? VM_WRITE : VM_READ;
>
> -       if (!(vm_flags & vma->vm_flags))
> +       if (!vma_test(vma, write ? VMA_WRITE_BIT : VMA_READ_BIT))
>                 return false;

This also improves readability. Thanks!

>
