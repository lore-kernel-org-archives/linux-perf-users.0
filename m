Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793928167;
	b=fAXVP4h19i9q3COT5ukdLMb2ja40eLbOju2MzwtHwpjrHUEt9vAhDP2TtCkKejtRlA/D
	 i3fadKhhvRftmIG72/z3OlWwX6oZxfcT6Fy+PyEp83sReOe1BrxrMZythX+SRgZW2k0a4
	 1LWMs9AKjv7vDBqQYBk4uybiGM0ZZRXuEBlyc0JnjSb23MrVQ+jIIDZEuypr1tZCh1Hk2
	 RasdZG9sTyYA42TdyGaaskieaanOyPcQPjg+LX1lfTeXy/2uW5+mwemVPznTVpjZCcG0S
	 acsE1P3PNUgTvR21YuGkQIsLGfBa1sAnMKhNbHpaTWeDu6yHSWQr3A0Gxj1ZMs8DN9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
	b=YbTU/8PEW0M7ZD/DFa3XrMluOgpOAfsvY1ty2fnErDJjvzPypeJ5YEP0SXpBwBYFPWRD
	 1W7jUTz1mMhDP1EQpQQRmaQdeKPR2JoBnBj69d/0uwwYed6b0u1W6R3p7GuAoyubI8+hP
	 agQVGkIq74Iu0EUNqUXkJR/xmvICX06gaJiCdSOwk0YFJoYc+abp+cOm7xFPAtZAtSdbf
	 7Dwp2/eaDtwuUyvL4C2M2kyuEN/xxolSOjwk7EOEpnKhR2izNzmOTeLsSZDV5NRQp7Xzq
	 HrSfEFGMw3omlxzG+rvFtw7K/fYi3Ej1Ar/nKWXZB0aqY7CcQRoYBdXMSdjmcITgWUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A2606A32C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 01:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 441A2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a070755c8cso32049b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 17:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793928166; cv=none;
        d=google.com; s=arc-20260327;
        b=h0lSnSdbbWx7CulON0dTwcWRtIoWbIDnH9mg8KtA/X2QDn0L4iWFuhYD+uTD8O+1q/
         GjSGi7fQC9yMtAE2wMqwXDU87VAeQIW6ycRmIeZKmFqDIRW0fjD1f11v/u1sEe5vvVMo
         l2ZJZwPmy0AigbeaXyeC8RexJbqQTZquwTd+Td53kb9f7Ms65IHTBcMtLBSipoVNG92K
         CYEgHop9C2WIh/NFp7NdxgLqCSGZTc3Jb60FGY34X4gtNARpgVEn5Cai+xdtrXnUcBsq
         ggrK5Hgx/invTstEes8Qgyqod3raGEoV5wiCjioqgxtrPWnwfYPrD1OyzO62nsW0cEEx
         IGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        fh=ybVpxK5+Y79qSsY3Q1PR/O7EVJy5Q/dKksAp5k6zNTM=;
        b=iG/uYL5vrRk286Dw8GoobeIfpwgvCGHdbnCMdq6qon223GlUoIrEHLNR693C+BDnmP
         NZAK7HXAAqPTFmBDzxes5zMeAT5OkFN4reV7QaWHF/UbkWbra5jkJ8jexGrS52Q7SBs8
         3SKLBTfBudl46ueuMqnxOi3/YEbq1GGlbGJE6bPrjSmm63XZe3kDXApuadiBc+7oS6Uk
         eA3QQcNzF3XNJGMJLGNDKH7k/WbxFBoEN3pU9B/+QkYctCOQU3eqTD/TVM9AlZhXnYSv
         LJOYfFaz2RwPwffpL7laNuGTOnDr/MVhicLCsr6RCEs4xcwyLB8H/V9u0tTrDbZ/BAxC
         fsuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793928166; x=1794532966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=BXgsLCA51X5/W48GvZrpBezpY+stGa03fvEbUi2MV56MnNmF4a2PjDTUVnBg0Dwtqe
         Pc0pFbbkVSP0pF2lMOwQEWZuhIoVpWFLaZww3T/CDXUanEMozEFBbg5xukYGZHM3dK7Z
         /fQ7M+BmNkKN//ilq5bRiwTE5y+M3XE5NT96+Mb4FuQk23KwrKKCtl+UAKDpUXGzEGJV
         USSryhSewq0S2ePnFYtulTY16RPJSyBaU+5La6UtGtX/D/3Czi9oUOP9+hhoTJe/0ETl
         gYSYGkR59nTYA3bP+5Nf3SMG0P++deg+hHNjH+z7C7raNaTFT7WIIduRah7XGk96iqIB
         wcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793928166; x=1794532966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=c8d3NZyoQcjL3mTvzkGMf34aWh5Rw9Wp1gzTxNRkda4jqmTl6PEigQ9R+M/u5JB71f
         Jt3lVpxDhUpom/mfnjTRByosybdliW9jlDwLLKu3kl7tUhvHSOcOKuA7MCIgSBcbE/3k
         WNWFn4dcTAuKydi65xxcXmZqvvfhNmmt6LbAEjnE2fbd0+T9jQmuvPg67Pxft0NqAVRo
         tnzdkFr2pmY7ITZRpgkf8d1aC2Uso4MU8XklpkYRUWLmyYSQop2MnLGWsu5vNOdupAZz
         JYOc7TkWz0R3yGkH7wkj7exXlWrEJ9ehU04PYWJVYMIDdXI7yAcVdO/n9FnCKkdWzEvG
         rkIA==
X-Forwarded-Encrypted: i=1; AKwUvBwU6zqWMO8CeIfHRo41lRDRJigQydmPBDQxih4BAliBSdiKt+bZ6V+gY/hFAPSOsmZLUa2r4KZvdosCx2uIsQxf@vger.kernel.org
X-Gm-Message-State: APuU4Z8TXADkkfQo4JFfu+y6gGpib5d6sfqSee+b6Gl4x6+5hLpDeHDP
	rOGZLS7xJZkFTn1rksqjy+NFcoeULXkHse8rCRnr5YHl2rWqg2dsqUYTURYlR1pTzBUU9ZgFB8C
	NePvAa36zE46ao5ULqXjBqTaE2Y0zpYLfy0ckbfbL
X-Gm-Gg: AYBFou2OCFCzwvFmBZR5DYDeixipsSUa68ReXzKTPaQpd0hQGWOkt48BNfEV5N/9+8D
	jp9f634las1Pa+vEILO5MZ4kLehcFYbcHTA4P0XuqKQITwHTJ7UJSir0ryhUM/YSIOGPQq93rUv
	hbKm2hFMdQ5zErg7e+1NlqshsYew2Znsk/XaJnVEdrjoRBm/SS7IczFUEGVVGktPMYF8HBfHdFY
	vZra5ecytDwNrxxg88GGHp33vvDj34DM5us2cMGxHzuXYAKTs2XOGS7/67xYXeAvqcBmn1VMHnw
	W9sZ+RQnS4kMCW9GUdJCA8J+ETClD+498dsrOdXZjG+ZF2Gt8BjzK7slVC+SwPIflGkvFGXNFxB
	sJj5rp69wtEIko/v3eqyfCm+qm1+80yfGBEhVjcLVqk7e0VZmLnDvTqhTWvmDJp/A5yF8
X-Received: by 2002:a05:6a00:4f82:b0:87d:e8a0:2389 with SMTP id
 d2e1a72fcca58-8b37b37d233mr903874b3a.21.1793928166471; Thu, 05 Nov 2026
 17:22:46 -0800 (PST)
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
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org> <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 20:22:34 -0500
X-Gm-Features: AclHuK_C6UmASiuiBuBvumlcrlzJEUCTa0-vZyEfxhlZIjAFaCskKj-ONE1360g
Message-ID: <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
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
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
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
	Georgia Garcia <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
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

On Thu, Nov 5, 2026 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
> >
> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in t=
he
> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  security/apparmor/lsm.c           |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/ipe/hooks.c              |  2 +-
> >  security/selinux/hooks.c          | 14 +++++++-------
> >  4 files changed, 10 insertions(+), 10 deletions(-)
>
> Similar to the other patchset you just posted, is there any reason why
> individual subsystem maintainers can't pick these patches up, or is
> there some reason I'm missing and they need to go through a single
> tree?
>
> If they can go through multiple trees, can you split this patch up?
> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
> different groups/people.

Since there seems to be a desire to bypass normal procedure in favor
of speed (surely that will never backfire), the SELinux changes look
fine to me, but please do wait to hear from the AppArmor, IMA, and IPE
maintainers before merging this patch.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
