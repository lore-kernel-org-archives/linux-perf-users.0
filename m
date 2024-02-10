Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0053443F
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Feb 2024 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707533205; cv=none; b=eRry+l1ZX+QW7n9wC9ZBIxWlUsGlQn4STVk46vYtwdBvFgCskAbb7laFeUS8qwszRreh9KIhmpUDFv+fIEVsZBlucuh/ANu7CCeS97RRLPQQj0bnMPEhqELdS7g4+3oQB35Z5jcQR8c+VA0gbccvybXGBvZXrCSwJcCQA+kiZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707533205; c=relaxed/simple;
	bh=uLiR7Kz1MbofB8E4x+ZPySEkA1M0AMIiXoKEeJbpDXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQlQVcMf74G9J4YW11lgMwbOPemZhYJ8tAWSdJY8JSG1q5x7nZRbW+FugHeg1NALFAoje7V/AVSH+UIDfzemsWKtdo2TLFgKLnvMi4lyQOtQjjFmbLPfP7wWYzLr07HZmh3j/m4C+lshtyy/cG8unnt4RFBzYtfwpZtSnxIZBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBDt3Or0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBDt3Or0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d89f0ab02bso50905ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Feb 2024 18:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707533203; x=1708138003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvPi1gupQqIT9F22A3YjxH75GO/tG9qnD/uz9dNXdsA=;
        b=bBDt3Or0HXwHv8cIE4k9ENtqtkvQICUKscvsTOiZXGGSfucELfFJLHJDCUVgyrtbbS
         Xn1seiv+0YdtiNrD8v6EQ4on3+maY9OgenyG+DZX/xNgUxEb4yftqHaN7JnD9Rf7O41Y
         PXMJCF00fmv0s1kpcsVzeESt+eaDXZBsXyCjD1wvpZjcmvPrOPaiLcNjT5WwPxUUOv0v
         Ztc6MfMOiYe8IvDxVxWoohv10pbHx5I1q80ehi4jPYHlKnPhC2AsKMBfFXj+AVmhOIXn
         wZLyIg56rcy0Tx21R7zmMHsU4yeJgdolAJ0ZmgfWcYN/efk9ewHYWPb3GSzbNj1NTIdf
         lrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707533203; x=1708138003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvPi1gupQqIT9F22A3YjxH75GO/tG9qnD/uz9dNXdsA=;
        b=LqJ2QXvi8iquF4fAlvzXx6KZp8WeI/+sSOUe/HN8I7/kapsWYF0K2qyrtYO/KFyBVl
         /CdBrvVAJhBBXY7WmUCnFg+OkYqMO2JL8QV3eokFiXuImqz2oazoh44NbQre1omdKbHq
         HK12BIBLHABmbdg71tneWt8qacCJg25UA+NtzxX531jgnvBdvBNw8G9OeFaY9QV4aS2n
         a8xDRNUMg9cjVjffR5v4KoNIvakk+x20x42WmebpJldp+5VC0QZVq7CnWd0ZoZkm6+Jx
         udzsN/qEa8mES6eVJDcBAgwFCP5dp1aEuLJv1GeLx5JXZSeX1ng9HTAdLP4ESr2TMS6h
         VtUw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ms1CDXL+INz/+4lvGPcGr1QPD8brrfrliTBaphK/jCMQBDjd1vuMHysHW8js2vFSzISQKHZuVm87KbkeDd36oMJfjUMs+rr8NhE0QJgpyw==
X-Gm-Message-State: AOJu0YwEnGQjJQ3NQG25fqctwLvI8JmKZY2UIGfV3XEU3mJO0c+xz2nF
	3nrz2eOoFoilCh+rEA6vFv+27FaT3m5MbHax8P4OhfmIGn0xhsoCT9kzEd4+GRTxG1l6Mm+0SZ0
	YYyADEcuaAy8PGjH94noLeVJgHb7O69ymmNmb
X-Google-Smtp-Source: AGHT+IGTCvpDi/N93KDltxbd+jCsgx+d2H4/3YL9Lk68bhh5nVQRaWaPF8hEL4Kp36NHmdjWMtDnU0IrZiIHcdBg/KA=
X-Received: by 2002:a17:903:44b:b0:1d9:a393:4a38 with SMTP id
 iw11-20020a170903044b00b001d9a3934a38mr38401plb.26.1707533202817; Fri, 09 Feb
 2024 18:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207223639.3139601-1-irogers@google.com> <CAM9d7chBixXozCQztM2WKGbfs_8C70vy6ROzKpwLSqq-upz5iQ@mail.gmail.com>
In-Reply-To: <CAM9d7chBixXozCQztM2WKGbfs_8C70vy6ROzKpwLSqq-upz5iQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 9 Feb 2024 18:46:31 -0800
Message-ID: <CAP-5=fUVkaq3dDoeMYYEN1N-ghnL-GiP8PV3N3pWpjQKpDTCHw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] maps memory improvements and fixes
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 9:44=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Wed, Feb 7, 2024 at 2:37=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > First 6 patches from:
> > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.co=
m/
> >
> > v2. Fix NO_LIBUNWIND=3D1 build issue.
> >
> > Ian Rogers (6):
> >   perf maps: Switch from rbtree to lazily sorted array for addresses
> >   perf maps: Get map before returning in maps__find
> >   perf maps: Get map before returning in maps__find_by_name
> >   perf maps: Get map before returning in maps__find_next_entry
> >   perf maps: Hide maps internals
> >   perf maps: Locking tidy up of nr_maps
>
> Now I see a perf test failure on the vmlinux test:
>
> $ sudo ./perf test -v vmlinux
>   1: vmlinux symtab matches kallsyms                                 :
> --- start ---
> test child forked, pid 4164115
> /proc/{kallsyms,modules} inconsistency while looking for
> "[__builtin__kprobes]" module!
> /proc/{kallsyms,modules} inconsistency while looking for
> "[__builtin__kprobes]" module!
> /proc/{kallsyms,modules} inconsistency while looking for
> "[__builtin__ftrace]" module!
> Looking at the vmlinux_path (8 entries long)
> Using /usr/lib/debug/boot/vmlinux-6.5.13-1rodete2-amd64 for symbols
> perf: Segmentation fault
> Obtained 16 stack frames.
> ./perf(+0x1b7dcd) [0x55c40be97dcd]
> ./perf(+0x1b7eb7) [0x55c40be97eb7]
> /lib/x86_64-linux-gnu/libc.so.6(+0x3c510) [0x7f33d7a5a510]
> ./perf(+0x1c2e9c) [0x55c40bea2e9c]
> ./perf(+0x1c43f6) [0x55c40bea43f6]
> ./perf(+0x1c4649) [0x55c40bea4649]
> ./perf(+0x1c46d3) [0x55c40bea46d3]
> ./perf(+0x1c7303) [0x55c40bea7303]
> ./perf(+0x1c70b5) [0x55c40bea70b5]
> ./perf(+0x1c73e6) [0x55c40bea73e6]
> ./perf(+0x11833e) [0x55c40bdf833e]
> ./perf(+0x118f78) [0x55c40bdf8f78]
> ./perf(+0x103d49) [0x55c40bde3d49]
> ./perf(+0x103e75) [0x55c40bde3e75]
> ./perf(+0x1044c0) [0x55c40bde44c0]
> ./perf(+0x104de0) [0x55c40bde4de0]
> test child interrupted
> ---- end ----
> vmlinux symtab matches kallsyms: FAILED!

Ah, tripped over a latent bug summarized in this part of an asan stack trac=
e:
```
freed by thread T0 here:
   #0 0x7fa13bcd74b5 in __interceptor_realloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:85
   #1 0x561d66377713 in __maps__insert util/maps.c:353
   #2 0x561d66377b89 in maps__insert util/maps.c:413
   #3 0x561d6652911d in dso__process_kernel_symbol util/symbol-elf.c:1460
   #4 0x561d6652aaae in dso__load_sym_internal util/symbol-elf.c:1675
   #5 0x561d6652b6dc in dso__load_sym util/symbol-elf.c:1771
   #6 0x561d66321a4e in dso__load util/symbol.c:1914
   #7 0x561d66372cd9 in map__load util/map.c:353
   #8 0x561d663730e7 in map__find_symbol_by_name_idx util/map.c:397
   #9 0x561d663731e7 in map__find_symbol_by_name util/map.c:410
   #10 0x561d66378208 in maps__find_symbol_by_name_cb util/maps.c:524
   #11 0x561d66377f49 in maps__for_each_map util/maps.c:471
   #12 0x561d663784a0 in maps__find_symbol_by_name util/maps.c:546
   #13 0x561d662093e8 in machine__find_kernel_symbol_by_name util/machine.h=
:243
   #14 0x561d6620abbd in test__vmlinux_matches_kallsyms
tests/vmlinux-kallsyms.c:330
...
```
dso__process_kernel_symbol rewrites the kernel maps here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/symbol-elf.c#n1378
which resizes the maps_by_address array causing the maps__for_each_map
iteration in frame 11 to be iterating over a stale/freed value.

The most correct solutions would be to clone the maps_by_address array
prior to iteration, or reference count maps_by_address and its size.
Neither of these solutions particularly appeal, so just reloading the
maps_by_address and size on each iteration also fixes the problem, but
possibly causes some maps to be skipped/repeated. I think this is
acceptable correctness for the performance.

Thanks,
Ian

> Thanks,
> Namhyung
