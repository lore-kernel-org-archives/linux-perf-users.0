Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15745411625
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Mar 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466106; cv=none; b=cy+qDvjmPxes7es+KhJ1VpA8TNpCho8aFmerNns80xajv/EDsk//rt5PHmr98j6RTd7MMX/Zmw0hCZx75tE222Po9V+btZdYJv8/MICASEo8/gA6bUqw9/mDNaI9/XzLaiUP8ntHfRFlQMWKL0liSFa5aLcJWJPVzVb8g6iknQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466106; c=relaxed/simple;
	bh=V5eDYyeSzEe01Qy0X2d3YjmdmOm2DlobDKTfwH81yIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NUsio2EFPgOjY1KiADrTXK43zEWSZELS+uhK9+s/LVdjtEw7KI9iDtap/fCjWfMmAJKQaLUQloL4uADIpejBat9EP4bZphEEnEYVjmnSmXbLVeOy1gnlRy/0/4YZAMyuuIuvvhdAXSEbSPQNmtx5YwDurOh/EE3rPAZKDmc6/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QWjdwuVb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWjdwuVb"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836bf1a920so47765235e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Mar 2026 07:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772466104; x=1773070904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvJ4Pj0Wo9ryI9xJ6mJ9OBJG9CVcmeBhutvadxQnZZs=;
        b=QWjdwuVb/t9+sKGihwIsRzZQDdjSzN3dEVZ2BVMCVyX5gDMOi04WfO3EXDuLEIMYkq
         b1MAAGH5I3wd8rBvw+Lr9FkpmDUYZCM+cXpNkpX0s7rDCX9DwnvMvZwRaBYUy8wQwFRY
         DDvHt41DUSZ1y5jjTttZoVYJYX97nEilliRaIRQN/1UY9z764ENyKoNuCuQKRDksfn6j
         e+ua+hTW50/m/OceVJWWgvRGey4+2Ut/i48x/0Ab8HM/0n4rsANdNxXZEaf7Sxu1LezT
         eh7wLjRocsyXoqQxa0p1CEp6G7jqorXPsfB8Y0Q9TiVKehJYrXW5wbZUqzceF1OYOLFA
         MSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772466104; x=1773070904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvJ4Pj0Wo9ryI9xJ6mJ9OBJG9CVcmeBhutvadxQnZZs=;
        b=DFQcI9KtHB1Wh2O5TYQ7b6a4+7eqSqJD16rzYJ7TovgkDK+7ndmAP/4BxoQsPEO85Y
         Wpf2MdonELDN2Z3fjbr2PJzr9PLYjeZYK3FgVcsJFwkoISKrfuRgT0ArFSbO9ylOwk4B
         VdzCTeTG208dgt/1vC9Ept8Dd+7FvCFZZRZdHfCAujBh2kXsCAC7UOqlI4L6jfURl83V
         pAyS8ufExVniOE0PwqOQcrJPQf66xdVIlREqfbdrHcJAZn/ezAYI5P4pJesCXh6iR4gh
         C33+uI3evTsUqyVOKSF5YQPyn4RtvooArL9RMAUt8VzSm+ATPrto572HwSCakV3gkuLV
         S2bw==
X-Forwarded-Encrypted: i=1; AJvYcCXZXYP7RH5ZW0/Iq/cCOSeKVktD7kBr0EkhzC6f3VupCIUMZQuZflYPhhHOA6q5MazBkY93wIvRW2gTut6tlL6C@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5jZ9du08Isfo2/fSvqhAfLnvivX0uBcBqUIHToOo9uhi3ZNWB
	ep7WHnUdrByJC8Gpr0bnPGLa4B3w0hKgbkZg3Hi4lkaorpSf4B3seO3aoLWUA9sJP22+VhI9QAw
	tGGCRLk4cIICe6spDKg==
X-Received: from wmby19.prod.google.com ([2002:a05:600c:c053:b0:480:690c:88de])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b18:b0:483:7432:a761 with SMTP id 5b1f17b1804b1-483c9bc558bmr213622465e9.24.1772466102970;
 Mon, 02 Mar 2026 07:41:42 -0800 (PST)
Date: Mon, 2 Mar 2026 15:41:42 +0000
In-Reply-To: <5f8dcb7f-9e4f-4484-b160-3a9ce541d63c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227200848.114019-1-david@kernel.org> <20260227200848.114019-3-david@kernel.org>
 <aaLh2BxSgC9Jl5iS@google.com> <8a27e9ac-2025-4724-a46d-0a7c90894ba7@kernel.org>
 <aaVf5gv4XjV6Ddt-@google.com> <f2f3a8a1-3dbf-4ef9-a89a-a6ec20791d1c@kernel.org>
 <aaVnifbdxKhBddQp@google.com> <5f8dcb7f-9e4f-4484-b160-3a9ce541d63c@kernel.org>
Message-ID: <aaWvtn48X8UizaaN@google.com>
Subject: Re: [PATCH v1 02/16] mm/memory: remove "zap_details" parameter from zap_page_range_single()
From: Alice Ryhl <aliceryhl@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 02, 2026 at 04:01:44PM +0100, David Hildenbrand (Arm) wrote:
> On 3/2/26 11:33, Alice Ryhl wrote:
> > On Mon, Mar 02, 2026 at 11:27:40AM +0100, David Hildenbrand (Arm) wrote:
> >> On 3/2/26 11:01, Alice Ryhl wrote:
> >>>
> >>> Well, rustfmt comes with the compiler, and it would be ideal to build
> >>> test changes before sending them :)
> >>
> >> At least on Ubuntu on my notebook where I do most of the coding+patch
> >> submissions it's a separate package?
> >>
> >> I do all my builds on a different (more powerful) machine where the
> >> whole rust machinery's in place. Further, build bots that run on my
> >> private branches did not report any issues.
> > 
> > There are some build bots that check for rustfmt, though not all of
> > them.
> > 
> >>> But no worries, I took care of testing it. Thanks for taking the time to
> >>> update the Rust code as well.
> >>
> >> I just did an allyesconfig and it does not report any warnings.
> >>
> >> So apparently, rustfmt problems not result in the compiler complaining?
> >>
> >> Or something else is off here that rust/kernel/mm/virt.rs won't get
> >> compiled on my machine, even with allyesconfig. I can definitely see
> >> some RUSTC stuff happening in the logs, like
> >>
> >> 	RUSTC L rust/kernel.o
> >>
> >> Thanks for the review and for pointing out rustfmt!
> > 
> > Similar to kerneldoc and other similar targets, formatting isn't checked
> > in the normal build, but make can be invoked on the rustfmtcheck target
> > to check it.
> 
> Thanks adding that to my cross-compile chain.

Awesome, thanks!

It's not relevant in this patch, but another thing that may be useful is
to add CLIPPY=1 to the make invocation when building normally. This
causes additional warnings to be checked using a tool called clippy.

Alice
