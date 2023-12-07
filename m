Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKgI3tKa"
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F3710CA
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 09:33:24 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bed6c1716so33e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2023 09:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701970402; x=1702575202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWvwuPiuxUQVO7BNeeDLUjAMj48JOZs+v7lie10kAzI=;
        b=NKgI3tKakb4aMkrzwQiaSWgp+L7RjlHKIHIAmp4tKektL8EWkuxjAQghl9ah32HrwB
         sbnLDgEIebwwQ4E37BAxnoFA3BH/tpoXStMTkV5CkjnlF/xnN8lBve8BO2WFenSwq+rX
         dEwC6GF9szaUomVqgGEDNxlJXEihrV2VBXDqEpDXYO22ajgLz5TsQFWeerU+aK9eq3h2
         ++uj27YnIqZhyUYbVdTXTn/WMIhO7qG/h2Vwh58V1ri7QcvGy9yG+Uemhni+S06xhdEn
         SJuuk0js8bwb7BYRe8QUs2G4hvqc2azoz3iYiJj/jzDKFOnCEX72x/sGbPDm6c3n0dIK
         ZUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701970402; x=1702575202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWvwuPiuxUQVO7BNeeDLUjAMj48JOZs+v7lie10kAzI=;
        b=cDNuMxnAQVw8bD9Q0zkRnDRNA3iZbcYcXal5iMEEBcm6p/ci98CgR3j6Gli/fduXVI
         j7kA4n0x8gmblSet85lrX4NGqx1Ar6kNt8ojcdNSOQmJiXxEgV+cB6qKGEGpxMSjLcpf
         MHFGgCzTTMmExHDPDRDGSr/x3fZbeHDDV60//kzO+lmhc1rsX2yzgNpfI6G9KTpXKkLn
         GodbLKKeoeEAQJC1ABQtQ70LSwfjNY+ifSES/Qy+C8Gy/RS4z47CZUNhXHotYRmjwY2V
         WsMnJ81rPWQZtM6WP4JYnrtaa5nHwXp+45hXVtjbUSZ6PgVwx/zpZeAEbsQqueh3hJeg
         F15Q==
X-Gm-Message-State: AOJu0YwbqBhtwXyuqTc7pWrMwXsaeqH+33qCaoPw1k3qV+jYZqrox8ah
	neC0BZtow8y3n9Cs9wjHNWown8NiTtCKJC1RyNKKm5kYFXTxchlLbUOF5A==
X-Google-Smtp-Source: AGHT+IG86lhLOte31MJRo1RVauOPUItQYNe9SDrSLhX2ANv5CukXoO4oocdicuGr5OZ2LbUL3IzKp5kjXgmUqFVrCR8=
X-Received: by 2002:ac2:5f56:0:b0:50b:cdd5:b54a with SMTP id
 22-20020ac25f56000000b0050bcdd5b54amr101794lfz.3.1701970402185; Thu, 07 Dec
 2023 09:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207140911.3240408-1-ben.gainey@arm.com>
In-Reply-To: <20231207140911.3240408-1-ben.gainey@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Dec 2023 09:33:10 -0800
Message-ID: <CAP-5=fVM7cdrcOKL1nRcusBZpg_6Sg5NZA6PKYWcMgeOwHjf3w@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix missing reference count get in call_path_from_sample
To: Ben Gainey <ben.gainey@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, 
	adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 6:09=E2=80=AFAM Ben Gainey <ben.gainey@arm.com> wrot=
e:
>
> The addr_location map and maps fields in the inner loop were missing
> calls to map__get/maps__get. The subsequent addr_location__exit call in
> each loop puts the map/maps fields causing use-after-free aborts.
>
> This issue reproduces on at least arm64 and x86_64 with something
> simple like `perf record -g ls` followed by `perf script -s script.py`
> with the following script:
>
>     perf_db_export_mode =3D True
>     perf_db_export_calls =3D False
>     perf_db_export_callchains =3D True
>
>     def sample_table(*args):
>         print(f'sample_table({args})')
>
>     def call_path_table(*args):
>         print(f'call_path_table({args}')

Thanks for this, I've had a go at turning this into a perf test and
will send it out shortly.

> Fixes: 0dd5041c9a0ea ("perf addr_location: Add init/exit/copy functions")
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/db-export.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index b9fb71ab7a73..106429155c2e 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
> @@ -253,8 +253,8 @@ static struct call_path *call_path_from_sample(struct=
 db_export *dbe,
>                  */
>                 addr_location__init(&al);
>                 al.sym =3D node->ms.sym;
> -               al.map =3D node->ms.map;
> -               al.maps =3D thread__maps(thread);
> +               al.map =3D map__get(node->ms.map);
> +               al.maps =3D maps__get(thread__maps(thread));
>                 al.addr =3D node->ip;
>
>                 if (al.map && !al.sym)
> --
> 2.43.0
>
