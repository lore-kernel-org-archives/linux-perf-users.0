Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xyK3Bjbg"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB551BF
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 12:36:29 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50aba9b8955so83e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 12:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700685387; x=1701290187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR4sLw90jB12SVs/JReLRRIAKLV6ovCULQumS/HywIo=;
        b=xyK3Bjbg5natYbI1sJSkHMOIvgxXT/ngZn0nZ2CNZ88JbK6rC+uoKoR3/uHXPpmPac
         zJ0Aai80dptatQeI6M1inxsZNHcgXxhRdsC7H09mes7S3Yj0FJhEVzR/wvItYTaRWGjf
         OOapPLLH/nfIIvT6RsGjkSHdJQpo7Z63uv2+PZSEZVPALgJJP1VXVwoeYRBxcKL5VmHS
         sGZXpl5GtA4oEV58rqNrChCb4BeYEV5G6wGdzh5VLC1v/YnQPu70IjO6IxNXfqQV2+vU
         MGse+yP3dLTsmfJ+mCt8dch0orHhBaRCy35r93L6bIcacujjOLcmY2rEGMq8qonEQHp6
         DzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685387; x=1701290187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR4sLw90jB12SVs/JReLRRIAKLV6ovCULQumS/HywIo=;
        b=YQnDl6bdDkHMR8z6DR3TIq147yb9DOEQhoRctiaaDZ1T2mHHvMwuhor+jGluH9OxAe
         GbERdcb4j7Lztm68/fItWuMjObP9gZITnvfYHcDyU/OyceK9pyxnD94eOtgt4fgnKKOH
         dvrHUTefqVQhqTgBDVmUUt9R45SUXzjVuw1mLBBUOzvndqozCyxWe1qDZv2MAoEYOxdY
         huY7hJZAqQil3XuqzjyIk6eLNSZ3oDNWttGjZXQ/rds/SqkgCrgtsoAa0UEfXRUwQvdp
         mLbX5sBmy3L8Nyf+O1xaQSfn9zbR/a5ygZjidexOGl8+RsStZ/36SWFtcSmPdeG0pIYu
         +NeQ==
X-Gm-Message-State: AOJu0YzJljqlhUklT2fZCwWvI7mUIwVwkGvijkcZndgugo5ibXYCrEUW
	q0++fFKu+5BFww4IvflDkVESak52mgqMXYbD3EyYqQ==
X-Google-Smtp-Source: AGHT+IH32WEfT+14LMY74Y2LUjqrzFffVQ9DiIpbxOANbwCDQlxmcKw7nqP4W+anXj5b6r+AmwoFKvQ+hO6ZTs6Gqq8=
X-Received: by 2002:a19:ad43:0:b0:504:7b50:ec9a with SMTP id
 s3-20020a19ad43000000b005047b50ec9amr99424lfd.1.1700685387341; Wed, 22 Nov
 2023 12:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121192956.919380-1-oliver.upton@linux.dev>
In-Reply-To: <20231121192956.919380-1-oliver.upton@linux.dev>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Nov 2023 12:36:12 -0800
Message-ID: <CAP-5=fU3MdtsayuvLja-_-Sc11+SivPXENMhztwPA6bMugdLSA@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf build: Fixes for arm64 sysreg-defs build rules
To: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:30=E2=80=AFAM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> Small series to address the issues Ian raised in [*]. Tested with
> perf-targz-src-pkg and building arm64 KVM selftests.
>
> [*] https://lore.kernel.org/linux-perf-users/CAP-5=3DfXxiOJMVqaH1JPU_K6+1=
GhaEgVeR7YyN+F0r7qTE8DGEw@mail.gmail.com/
>
> Oliver Upton (2):
>   tools perf: Add arm64 sysreg files to MANIFEST
>   perf build: Ensure sysreg-defs Makefile respects output dir

Sorry for missing these, scripts/get_maintainer.pl will recommend
linux-kernel@vger.kernel.org so this didn't show in my review pile due
to my email filters.

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/arch/arm64/tools/Makefile      |  2 +-
>  tools/perf/MANIFEST                  |  2 ++
>  tools/perf/Makefile.perf             | 24 +++++++++++++++---------
>  tools/perf/util/Build                |  2 +-
>  tools/testing/selftests/kvm/Makefile |  5 +++--
>  5 files changed, 22 insertions(+), 13 deletions(-)
>
>
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
