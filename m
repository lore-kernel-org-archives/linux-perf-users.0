Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1323D7F0
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640774; cv=pass; b=bTF4fQgQZoaNgDKZaApEF1cxUmhMHauFMaYIEpwmiOJNuEtsxAfe4+qcoQbCWz/XG3xscZYmiJvE0/xTvHvuALofeGdiJeyelGXsgduxFxNTzWWaD14Qj8AAO14Wv4U5UTZK9HVjsC8X4JAGczaEGfVwt/HoXLqMk5ux6JVz8V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640774; c=relaxed/simple;
	bh=WCpEwYm2pg45X09DYVeAAYbJ6niAepsozXrMLCbrTfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKYcsILDs1pCjZ2n+JQw69Th/0/OBPlK8SpQjTMECTD2NfrF/lLJWbyeCqNVYy61yU7NsPHIhPS9T+sXNCYwWI/1xJ/uXjreqsE3hBrOBr6JPvoxwFbiE+66S2KLtoPIKJaPPLm37oSK7Xi3aY/XdX1T51TbakAN/X2fueaKaLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=R9MTlx+R; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="R9MTlx+R"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66f7a9afe43so3099608d50.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 17:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790640772; cv=none;
        d=google.com; s=arc-20260327;
        b=cUGnB0KBkQr6638aUojqqKOpBbtmCVQiB3hoJF5voIhpOJ36UGziaaDf9M9myTCNNy
         ybXJ2A7miCwLACBTNP6fdDk4oRdyPYo7Kvf74unYXIkOyO/STTkachaJvVLanWw6Tjxh
         FLwSWFSbH6yTEuHSRtQnuOAgPjrTpHWb4RpvMOpiarsexUAwd8DWTm0R/1tcJRCQf6ID
         TbaUTueXSeWMF+vYpnp31Oh67LJ1AzjK3Hh0jBAV8wsWEN4YWOZGqe5uPmbC8svInQOj
         OGf8m8jERHqXwwhKShisWfcLGg+tHo3nuiJ9k9HZeb/0/VtFj3sduSWEagqDYksInklZ
         vgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sy5nnA4WXY2yLs1s40a3tAQdL7ZO3e0dbOF3g9DpCc0=;
        fh=1imIDD4LNf6qE+ROOtmgmLhUwkylj/9ztbwj9azoc3c=;
        b=ZWvJe8FNjQqBInyxuppQEUUKjejN47WbKC3QlRANUaCZ/yz+ZnKUUN9cLjyV6h+tT6
         2D98AIuPGMFVOeisp3yufQQXXMNGOlWTib2qIMIski8MyS1qWttIiigFhDmo0s2Tv3K/
         brWOXhiXOyB/U6WJmvq//PetkHfhAb6D/lxI6bFXp92U5ZssBYaVhRqOKF15BctKf6R5
         8H/AaVH+xy55Rxb5hh3sw3qsYlsIlz/kU7mSm3H6GTcPgTISr27UXZtvueLtobB5jqQG
         pkAV6IQcVBao7dInqn4tmvxCkukiySjCQSdnmiIpYqJLSnXwPsZf6WRjTal8J0cGTQmi
         yOoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1790640772; x=1791245572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sy5nnA4WXY2yLs1s40a3tAQdL7ZO3e0dbOF3g9DpCc0=;
        b=R9MTlx+REOvfDxlIKDkAkJpGlX1CxGpmAydaEhVOXoALAKaXrDKbF6zdgRa2DsDbgZ
         mSPAe1SptBMiMZZ5i6llfF3QgjweS+5btwZpe1AXhO5Svk+H4Sb2TPRWJszJvyHVnGSv
         MKMibcoojejmh+YQUAbfIAGfK0gLP27Jz1Oeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790640772; x=1791245572;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sy5nnA4WXY2yLs1s40a3tAQdL7ZO3e0dbOF3g9DpCc0=;
        b=Cywsg2ULgjiEV+02ixSqSie8viU5yTHwosfrIjV0KYcSo+FtDXMx2wXihcbM71czlm
         11VH32wy9jbgVk7X0Vcqk8p8bzofFgYJcbcW8MmJPgqbILxrsLSwOgdRzXNxckcbAKtP
         wHjBvSoS+q6sW/HNLJoj8jaK5tcjJou/ZqTTuVXzWyKWfgPW9CoP4kPcF3GZGIf8t5CU
         Gm9A2ySVnTmVCujPaTGAwhJcoM4TZMi5CgKrzl5xlkbK2yHkKSOz2R/4sJAgbmG/iE3I
         C9GIuseRZvGKeANEYt2VHqtJ2n9qloyRnbmSMbXwJ8BvzZABgrbRhmueHKWNve4vesgi
         xBnA==
X-Forwarded-Encrypted: i=1; AKwUvByp9XLIgLWh9d4QpX+y/Np88xeLyZJaUMtemER1DZnAvWs1M6E1Ko/FNPE1OqLGwkmY+P463pSg1rOHtSZgZGAM@vger.kernel.org
X-Gm-Message-State: AFq9FYIkIoTNvhNjWQgwdHEnrTWCttgAnRanrYlkLhZ3tnqUxXziJT7l
	mm0x5BKy9OMDYTa70cshUwHM5HJF49G78svZzGOdTHAsM5xLvHV5m9svvvM+KW3jDgQRCTMhoRm
	/5AI/1DwQ62GfYGE2bXeRuT8qSKfMdDDYQEUtAnrKEw==
X-Gm-Gg: AYBFou2vA8TyNQw/yRvKwORQZZk1/bxGxF2ix7RD1wZkCsHBxQp4EBgMoV6KJnFkAKW
	8MrobIrV+zILplOMMvgn2H01abHN+A+raddHNYgK0myUebHFSJ09vPU82x4h+M7gjEu2YEb+mxY
	Ej8AhNh3GUQJeVG8aIbVZFHY4Ec2ZyFr4X15rvtHgEgEx7/V4Opx34q3Wcs07tEPQ1Fdn9jQ+go
	lrYmt8iF6+WBMY/zdMvW0zRB6uAeKLbPUYwokmK0leOiQu2M6TkAcqAei51tNLkceZJddnntpYg
	SuCOORw7wjxo+/SonphU1+Kqte6JJEy7FvJySXeu8WzpVY+zMeyMYIHDps04wkh0aOu1NSVBVfa
	4DRupLNSYdWg=
X-Received: by 2002:a05:690e:1487:b0:672:e7e1:f3de with SMTP id
 956f58d0204a3-672ed46d694mr5866366d50.73.1790640771260; Mon, 28 Sep 2026
 17:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <CA+w=M=R7vMK9-YZufh1ZW7efsVh=vCVkeh2_4rPSAsN=SH8MuQ@mail.gmail.com>
 <CAP-5=fUFWGxNSS+TW4iHqeWu+24-R2rq63oBX19VxkTXnqo+4A@mail.gmail.com>
 <arrhc_7jvX_W2uXS@google.com> <CAP-5=fUuwXTN6kjDrSqygN-Dy3OFuWMH705_tsCXX=dbG747QA@mail.gmail.com>
In-Reply-To: <CAP-5=fUuwXTN6kjDrSqygN-Dy3OFuWMH705_tsCXX=dbG747QA@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Mon, 28 Sep 2026 17:12:35 -0700
X-Gm-Features: AclHuK_Gi0q6KGkG-TKV-EY-cBXKPRFfaW4yfy4rNdbodkBmzTyCOdxEyH18vSo
Message-ID: <CA+w=M=S3USeLyFNaHSjHL+cmzssWk2Bygahetzr0dNU55TZEMw@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf symbol: Reference counting, flat array
 storage, and LRU shrinking
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 3:05=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
> > I think many of this memory overhead come from the symbol string.
> > Probably we don't use most of them.  Then would it be nice if we can
> > lazy-load the strings?

Namhyung, your guess is right. I counted live symbol allocations in eager m=
ode
on the sample fixture. At the peak, 986,688 symbols take 258 MiB:

   names (demangled, avg 210 bytes)   197 MiB   77%
   struct symbol (48 bytes each,       45 MiB   18%
     24 of them the rb_node)
   malloc overhead                     15 MiB    6%

That is most of the 335 MiB max RSS. With --lazy-load-symbols, only
2,928 symbols are created (0.5 MiB), with identical output, and max
RSS is 108 MiB.

> > Without the string (and the priv part), now it has a fixed size so it
> > should be saved in an array directly.

That is close to what patch 5/6 of my v3 does. Its index is a sorted
array of fixed-size entries:

   struct sym_idx {
           u64     start;
           u64     end;
           u32     name_off;
           u8      binding;
           u8      type;
           u8      flags;
   };

That is 24 bytes per symbol. The name is read from the string table
and demangled only when a sample lands in the symbol. The difference
from your description is that v3 then creates a regular struct symbol
for the hit and inserts it in the rb-tree, because the rest of perf
holds struct symbol pointers. If the entry itself were the symbol,
with the name as a pointer/offset union, that extra step would go
away. Ian's patch 1 would help: once every name access goes through
symbol__name(), that accessor is the only place that has to resolve
an offset.

> > Probably we can add a limit there
> > and print it with offset when it doesn't have the name.

Agreed, that is better than [unknown]. The symbol boundaries are still
known, so the frame can be printed as an offset and resolved offline.
I can do the same for the byte cap in v4.

>
> We load all symbols instead of lazily because we need the end of a
> symbol, which we can only determine by processing the entire symbol
> table as the end of one symbol is the start of the next.
>

Ian, I think most symbols don't need the next one for their end. ELF
symbols have st_size, so the end is start + st_size. Only zero-size
symbols take the next symbol's start. The whole table still has to be
scanned to find the symbol for an address, because .symtab isn't
sorted by address, so an address window would scan it again each time
it grows. The v3 index scans it once, sorts the entries and fixes up
the ends there, but keeps only the 24-byte entries, not the names.

On which kernel symbol is right in the nf_tables example: the sample
is at 0xffffffffc0c4b280, and /proc/kallsyms has nft_do_chain at
0xffffffffc0c4b0b0 and the next nf_tables symbol at
0xffffffffc0c4b4e0, so your series is right. The last dca symbol
starts at 0xffffffffc0c4aa50, and symbols__fixup_end() extends it to
0xffffffffc0c4c000, over the first page of nf_tables. I've sent the
fix separately:
https://lore.kernel.org/all/20260928-haghdoost-perf-symbols-fixup-module-en=
d-v1-1-0a70d1edd401@uber.com/

Thanks
Alireza
