Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641FD3431E3
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776830287; cv=pass; b=HF422iQyMicIL1ofYiR0t/u6OSK5x4+RDavSk/l8oCNcBwXD87ltqufb7x05pNAnUjYzGCCVOsO9SzWRETT+YseoQV5VBTeSxF2butrz5jHS/oa+YvbPEA8DzBIXAM/MJ3w7RZStUOR6iRKfaOFJ9euIt0+QxqR4YaOwtSUgJ5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776830287; c=relaxed/simple;
	bh=5GJsF08pQ4paFemCsTpWN6URgMlZJlEsZk5kOl6oVVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhtZZQ9J6KDSysQ/fCzrMolJ3n/OkJUqgVnyJjOpd6qJ7lL9xIEmMwf38T39uNHEU+FkFjTwVWuRR1Taz4Thxr0ToFUnmuxf02ud8PpHMQkZMl6TuRe4VSoJF3v5EDDCMQjMezqgen8E5RxrR8dxCiB9eBMuhSDj0ImNXKEH/6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TcnKmgUE; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcnKmgUE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso341315ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 20:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776830286; cv=none;
        d=google.com; s=arc-20240605;
        b=DY80YPOsM66QUUGcRplwKzjf1Mu1c1S9TrhmiRoPfJR1LVqMZ7tz13sXMv2oaOC7+g
         QeWhDyh60Ze+wuo9TlUpNAmGFhv2jNSq6aIMMxNNbRLxulh6tBngtwdIqyAoruCgAkai
         dMkb1d9b4JY6YNvDx0CxXqys0WKeiqlFH7xfFDao8j4oeVH6YOvoxQuSgJEFqxy+xlZm
         GOuPHDoQrIlprJR36pXQQe/e4wyPv1m5IusZbkyKgpm1My//yEWlOthcHJ1SuxEJZekz
         iNG9/UksneJ0F5wcKfcY2kH+YEOPJfpl3ULaWNlyPsSu2CVkl95Ew7dX2rBzNj7hXvCT
         RtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3vcY4nYueHrKZZVkH9OI6RsVYJ+Oz/SvjOA/ZYvuSpk=;
        fh=5agR9RMzbtRDSs9mp5CNxG6teRUQ1DPZOR/Le71rEgA=;
        b=dCiJ2MWv1JuRLh0ZZdbTkg+Byhteq4cJF7duBoeyc5k068IwmfSxZBxdlIqOH+Ws67
         KIWa6A1qPbZbSieiOtauIgu3puhLYBHjOYXLTvVlApWF3Memc3lK/52BpUOVtCAGJAB5
         ezG0/PcipPvNbLAwuDKMb6mR4W1BS/mEUUxD6pIqpFoi9t9u4qVkgqtQQvGyDEdrifOP
         IR9rwmpUIYtDwfxDp8YQwVUMryfXPiY4B6t6uoI9YqJpUclxAZ++mZBee/Mblr+V2uy9
         3bGv64vX6/lhXE0dgWzudJmakuQPu1473zt5L1PrYEk2mz+UgT/wXR7eNzuoXjtW5jJR
         2cZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776830286; x=1777435086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vcY4nYueHrKZZVkH9OI6RsVYJ+Oz/SvjOA/ZYvuSpk=;
        b=TcnKmgUE804Im54iq5k+0rNI8BlfgWgdjX4MrkX6gPlwGAt6z6l+ADTdXxHSliEtPI
         pVFQMUqCJLAJfq5ON4qDJuZNAWgkfxPRd21PFzGHqq9e19S0lt624PDs+icg1gK9EmzX
         xTypPGQWBYndUWyjH5z/QTlszo14tpVhSs9dFAI+TnrqVkgIdRjCnoXoMT7zhtqMHvjl
         Fofz/6WIG30Jdm+zbpoDNw3lQmvvO7XIik15AYaPCdvxdhg3G5Y57RZjARokXi+277ek
         Te5ghPU2YnPNItkwfgj8uv4xX4aygSXvOKVfVBFgV/K/Ig9xdbN5YE1KBx7T9JDtcLEW
         iaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776830286; x=1777435086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vcY4nYueHrKZZVkH9OI6RsVYJ+Oz/SvjOA/ZYvuSpk=;
        b=P4rotJdw7EjOY0et/Gk8hvx/DX6GFP/daTNZOuADCbQ6XyY59kvHHoKAw+v7FAX7SV
         fCRQhZQxExXmJ7y5m2/dbRbtyoduyoX/tw1xOMXduj+USpFRjuRyF+owXCJiC4KFcqak
         nv/lc4mM9rnlQEVGvwJfj/m7BmDpjE3U551BnhuycOE9gZO1WS4tW5MJCzy00wbsAoQc
         cFqOPmfPP99/5WI4TL5XmyppEuFptZB0R1qbmmaKYmrnYuZApwypBX5S3Jh78x031hL+
         cZkVlKcGd8WFGwSaIx42tEqmRl4NZg4QJbgDRarPHRLwT9C4USm8ZrI1Ze0AqwdiLO8i
         Ifwg==
X-Forwarded-Encrypted: i=1; AFNElJ+HIcsrTj6UhAtsR/rXYpbo4CfgzEXq8nd+yjDYRrkS3OMF+FXcQudO/FdyvvA9//L3Xe5qc4O7ppSSoNI3LO8Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyAGUMBmjv+0V6iMRdSb1qEemvXfV6FqEZBwYH+QtfKbHT1QJEV
	FjaErlNxNcxk0La/f4zUUIis7levkn2+Dn57bzZiZASxeuvtFC9ZHZSXvlNOeiRK7pp8qQapRMT
	pQlZZTN9lLsmIR0pP8Ys+ProAn5/l+UFsm2emEmpR
X-Gm-Gg: AeBDietLpjYjVVH6UBpDy8lMJe2Cgg/A9nnO88kH+Fb6xs6XtnOm+eUM6KC+QUJH+2v
	4cojhqPOkd6wA+kxA4z4hWmFHV4YbGVPMy1u2xcsDtf3gLFCPizSn7uxT9BMuSRmWetYbom4pNl
	HJvYOgwog+anCxswbGrvEDkfHFe0DPX/Shj+Q4CANeKTW5w8bJs0uNluggV8/Dan2PffkT8D3FJ
	ioWdJuPRALRY+aQjxYfLzkv+Gi3tLJejS8esu64MJ/K/jFJOeZFDq8af1NgPBcz5SeOFj6+1q1m
	OT7t6mm1+dnZZNsTXgJIWIqql5Xhlg==
X-Received: by 2002:a17:903:3c25:b0:2b0:7a9b:82f3 with SMTP id
 d9443c01a7336-2b602f29b8cmr11673045ad.8.1776830285187; Tue, 21 Apr 2026
 20:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420163222.23517-1-k@mgml.me>
In-Reply-To: <20260420163222.23517-1-k@mgml.me>
From: Ian Rogers <irogers@google.com>
Date: Tue, 21 Apr 2026 20:57:54 -0700
X-Gm-Features: AQROBzBstMSbYsgzkCg7_5Jl2E-TdlnEQEqq7tZplAslGn5jZ5R7E3duoojwy2c
Message-ID: <CAP-5=fVQS=otsfMEtZNHixairsG3=-mr=+fepBpjSs8JbbnHyw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "perf unwind-libdw: Fix invalid reference counts"
To: Kenta Akagi <k@mgml.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	linux-stable <stable@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 9:34=E2=80=AFAM Kenta Akagi <k@mgml.me> wrote:
>
> This reverts commit eddddf4ed7f69697cb54e714e773f764c8d3b67e.
>
> Upstream commit f815fc0c66e7 ("perf unwind-libdw: Fix invalid reference c=
ounts"),
> was backported to v6.6.128 as eddddf4ed7f6.
>
> However, this commit depends on map_symbol__exit, which was introduced
> in v6.7 as commit 56e144fe9826 ("perf mem_info: Add and use
> map_symbol__exit and addr_map_symbol__exit") and is absent in v6.6.y.
> This results in a build failure.
>
> This is a revert of a backport, so there is no upstream commit.

I confirm map_symbol__exit is missing in 6.6.y:
https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/t=
ools/perf/util/map_symbol.h?h=3Dlinux-6.6.y
but present later:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/tools/perf/util/map_symbol.h?h=3Dperf-tools-next&id=3D56e144fe98260a0f=
8a17326993ceb576ef859ed5

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Signed-off-by: Kenta Akagi <k@mgml.me>
> ---
>  tools/perf/util/unwind-libdw.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index bd027fdf6af1..6013335a8dae 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -133,8 +133,8 @@ static int entry(u64 ip, struct unwind_info *ui)
>         }
>
>         e->ip     =3D ip;
> -       e->ms.maps =3D maps__get(al.maps);
> -       e->ms.map =3D map__get(al.map);
> +       e->ms.maps =3D al.maps;
> +       e->ms.map =3D al.map;
>         e->ms.sym =3D al.sym;
>
>         pr_debug("unwind: %s:ip =3D 0x%" PRIx64 " (0x%" PRIx64 ")\n",
> @@ -319,9 +319,6 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *a=
rg,
>         if (err)
>                 pr_debug("unwind: failed with '%s'\n", dwfl_errmsg(-1));
>
> -       for (i =3D 0; i < ui->idx; i++)
> -               map_symbol__exit(&ui->entries[i].ms);
> -
>         dwfl_end(ui->dwfl);
>         free(ui);
>         return 0;
> --
> 2.50.1
>
