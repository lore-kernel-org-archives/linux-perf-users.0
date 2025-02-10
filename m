Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5A261375;
	Mon, 10 Feb 2025 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739230761; cv=none; b=rZ8Ei8rBzl1YfOSYiWaMj+W2w+cL/rDSiB6JHwNcSi1qxtHlu5AzwQF8B84pG/c+aP/dAWWGjXXgZ8ccg/DgljEuu/wugme8SdDQgKp3TTxQ6rLHhRiIFt1VSEONet7P+sd2lZoqMrT7355eUeWcfgYtnKLSbeHDQ6cYr3Z9B3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739230761; c=relaxed/simple;
	bh=XtC1lnaFlsxPJJUHriOWePwP8yBTmLkmhQe6ny+9TZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enyxpP0ePtn43VNmurpnbv3QRJrTbIlcaAF9tNxR0hNz8wBfR4Oml8YfH1AOEo+c1oh4G4QTPWaieOcwBjpkLFT8RPA5cMJbf01MpAQcFzfUwS7oo2lhripwhPNXKp4af1uL+GcEYrLedl/NY06/N+BIRYjtcsyna8M4j6iOzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvCsv4p/; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvCsv4p/"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86703c58149so1230238241.0;
        Mon, 10 Feb 2025 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739230758; x=1739835558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4J5WV+6IR7+S2waApgF1qBwpbiN//GCbixakjmicks=;
        b=PvCsv4p/sEKjoFjFtVnpdanLWNPVWH5TQE4Bh0rNoohnh2nWO5PabqYBxnAu8S3+ik
         Mrmgt0OSLz5KlhUYDkE2UYYqtz0dyvV6f6cLCkXL/Dmtd72+fkxnfJfqp/PHbUrQ72V/
         1iO8Y/5Wq/E3vhT87QgBUrHUqh5iQHux4pt1SwP1ICt5kbJtr5szjkrL7wxGeN9zCd2t
         CvBoeUrIBuyeJUT/pyklgAsVA5LAoeYaQiV+t6XKBrdiwBLts7oA814JU3ifGYkEvwIj
         227H85kfKRR7bTI46CMcWRUA0ce0TTN0WA6t94QToL+SdtPo5azlgqunYArWBeAeV2Ht
         eHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739230758; x=1739835558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4J5WV+6IR7+S2waApgF1qBwpbiN//GCbixakjmicks=;
        b=YFPTmTE+faKyd5PeDli4wq3PZLmXnbYarapMkSS8IconQGbE+FbvZz6ZaCerUP2sIC
         ADNVeCzYPgWlfV2mvG+SUDfo+WTQHW1IQCRlpFR2d3ViIZlyvPrDA6hEmeUJqmAqxNuo
         fYNgSRp2R+5Ce/ydJaV+hce4sKlHGQqY6YlN5OcyYi5G/IgLemDbpREZPiTGPuLLc31m
         9teJnQf/nYOHZwtkEZZH3UZ5IjBhYRVsPac5GwyHDHYrLMfaL5FZizPrzu66coEob9DY
         WFLWtZp7TLOS7dSvr7hKep0t0md5vj6JtrcZXy33IcExvxLitB1fpD8yBW4VX5dbxEbJ
         ZyuA==
X-Forwarded-Encrypted: i=1; AJvYcCUMwXGRBWzaxykwHPx6EpFnz4h6TJAx8vEZIBo4PAmsEyITHqJXv6siANG15/+PF+KRcAzUI0d415JjByehmgdI3A==@vger.kernel.org, AJvYcCUfGoinyiubk9ar27zndQxCrlsIwpfHGi+eeuy4+OxFBp4QwZDk0HPVgFAHACoUt7IX2cHejxQGUVnXNm0nEwc/E0ZU@vger.kernel.org, AJvYcCUxdzmZ8UQbEcLCDldnQf/IvVAoV28h34raWWIf/6hQ0vlJtlob30AYYZ3OaBkCECixCTlxz2GKuGw6qP6D@vger.kernel.org, AJvYcCW76MZGXav1J96O8mHJpBz0Pc0Wq0xIdoYwj/2AedrtT1Q0VWa7nS/H+Ln5YarJ16+Ud1ut9Gld8Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGm2TqEfGEtvmrVgQiyD1+ZI2ZuWs+QmPFKwTeTxgjLgo4qrOa
	MSNP4w8RYDYNcV+GvzL6XMXJRAqhDpMwwhX5undWBEyDoh7NvwbVYI32HkBN+USzeQHBLwQzYSo
	XWwUbxZSfzosXWbmNY71hCXwP5nY=
X-Gm-Gg: ASbGncukU/5Rg7r7139f0qjOiOweN8iyZuTkLvLpr9qr9KNyq59bc+6prnBFeZ3toJu
	YuKeU8HF7iKTp8/F2Ombl4ULBKn4a5m+l/onDOnoqnw5iRLHSGTG6tI9SzB0MuTpXI6LIK6y2pf
	Gp8J7Jl6s4bOfaBpHaZialLZcbK8pOEyU=
X-Google-Smtp-Source: AGHT+IEzfy3CbplemS9WcnlHDD6MpmxCskJpVqC7I5+Y9/ioGIApBpWu1Deqy+MADOJ9mj0OMU6KQgcPeg0LuaokY6w=
X-Received: by 2002:a05:6102:2b88:b0:4bb:ba51:7d48 with SMTP id
 ada2fe7eead31-4bbba51806cmr4870296137.5.1739230758203; Mon, 10 Feb 2025
 15:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210193801.781278-1-david@redhat.com> <20250210150515.c71078f212ff4661eafc15bf@linux-foundation.org>
In-Reply-To: <20250210150515.c71078f212ff4661eafc15bf@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Feb 2025 12:39:07 +1300
X-Gm-Features: AWEUYZmxTQri2-Cf24uNq3e2oUES2a1ywMTPcjyR3D9qOdCEqwTj81M6L3Eziec
Message-ID: <CAGsJ_4yVkJdKejof1CxJY1hkUSsQ-ziRzCTp9CBXdBJ-4d1HHw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] mm: fixes for device-exclusive entries (hmm)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mm@kvack.org, nouveau@lists.freedesktop.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	damon@lists.linux.dev, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, SeongJae Park <sj@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Peter Xu <peterx@redhat.com>, 
	Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:05=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 10 Feb 2025 20:37:42 +0100 David Hildenbrand <david@redhat.com> w=
rote:
>
> > Against mm-hotfixes-stable for now.
> >
> > Discussing the PageTail() call in make_device_exclusive_range() with
> > Willy, I recently discovered [1] that device-exclusive handling does
> > not properly work with THP, making the hmm-tests selftests fail if THPs
> > are enabled on the system.
> >
> > Looking into more details, I found that hugetlb is not properly fenced,
> > and I realized that something that was bugging me for longer -- how
> > device-exclusive entries interact with mapcounts -- completely breaks
> > migration/swapout/split/hwpoison handling of these folios while they ha=
ve
> > device-exclusive PTEs.
> >
> > The program below can be used to allocate 1 GiB worth of pages and
> > making them device-exclusive on a kernel with CONFIG_TEST_HMM.
> >
> > Once they are device-exclusive, these folios cannot get swapped out
> > (proc$pid/smaps_rollup will always indicate 1 GiB RSS no matter how
> > much one forces memory reclaim), and when having a memory block onlined
> > to ZONE_MOVABLE, trying to offline it will loop forever and complain ab=
out
> > failed migration of a page that should be movable.
> >
> > # echo offline > /sys/devices/system/memory/memory136/state
> > # echo online_movable > /sys/devices/system/memory/memory136/state
> > # ./hmm-swap &
> > ... wait until everything is device-exclusive
> > # echo offline > /sys/devices/system/memory/memory136/state
> > [  285.193431][T14882] page: refcount:2 mapcount:0 mapping:000000000000=
0000
> >   index:0x7f20671f7 pfn:0x442b6a
> > [  285.196618][T14882] memcg:ffff888179298000
> > [  285.198085][T14882] anon flags: 0x5fff0000002091c(referenced|uptodat=
e|
> >   dirty|active|owner_2|swapbacked|node=3D1|zone=3D3|lastcpupid=3D0x7ff)
> > [  285.201734][T14882] raw: ...
> > [  285.204464][T14882] raw: ...
> > [  285.207196][T14882] page dumped because: migration failure
> > [  285.209072][T14882] page_owner tracks the page as allocated
> > [  285.210915][T14882] page last allocated via order 0, migratetype
> >   Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO=
),
> >   id 14926, tgid 14926 (hmm-swap), ts 254506295376, free_ts 22740202377=
4
> > [  285.216765][T14882]  post_alloc_hook+0x197/0x1b0
> > [  285.218874][T14882]  get_page_from_freelist+0x76e/0x3280
> > [  285.220864][T14882]  __alloc_frozen_pages_noprof+0x38e/0x2740
> > [  285.223302][T14882]  alloc_pages_mpol+0x1fc/0x540
> > [  285.225130][T14882]  folio_alloc_mpol_noprof+0x36/0x340
> > [  285.227222][T14882]  vma_alloc_folio_noprof+0xee/0x1a0
> > [  285.229074][T14882]  __handle_mm_fault+0x2b38/0x56a0
> > [  285.230822][T14882]  handle_mm_fault+0x368/0x9f0
> > ...
> >
> > This series fixes all issues I found so far.
>
> Cool.
>
> Barry, could you please redo your series "mm: batched unmap lazyfree
> large folios during reclamation" on top of this (on top of mm-unstable,
> ideally).

Sure. Thanks for letting me know.

>
