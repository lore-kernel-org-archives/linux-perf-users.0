Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D7481237
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136273; cv=pass; b=IUS76qdOOEhA5nOFJQvkAvjVxcjlSbewoIPEOTdMaU/jfvfBgxbzzVi852vmmt5MafKLKUOZ43WOxITHeeYwRN3xivfaago6iPsqlxjTL+YvDkC/kP7WJ1CWvDHnZycal4WdRXgTlRVzCN4pNsnKYd+9e/2VR4fxDi/+MFCfKlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136273; c=relaxed/simple;
	bh=cNuKMIcek4rkNIhg1DjvTNY6u94NrZCdTQHA/3wIBW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKnQTqLnBsZWiHZnyNzvnn0SYT3RF3S6bv0GQxjTVc7C8QKv8DswijoGK5KA0jCtYruq53FK6gzO8rvR9RGMLfMDWTEbVMmnXwU7ZLsP3BYlBmwwfVjlfUlffFa2ZNlWASVcCEhZBTqVgtQETbZgNptwtiohF4y2xjTgqbtIs3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNCYOZMT; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNCYOZMT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab97c86bdso4765ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 10:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784136263; cv=none;
        d=google.com; s=arc-20260327;
        b=PXQi+YZ12jmfTNaFeVyjhoF6pp2pz6b5KomGkpCXVzIHoR9RVSiEzVRe0cJ2bZnE0E
         VjlVzbafAhiOTPt5C1qCwbZ2nfqzwwgdTkq+6+aqzp+oe9MgedLURW3ViKt0zyyJf/79
         wdO1w0RfiaoK47e82eXQRI1pYUaKUZ3kH8773Ka/NHPB4I9TKQ28ooJmnUNac7Qjpx10
         VW7IRE8gyup0wMUEeSFxsYIakbYy8uGKsa6iOti8Smd0CJT4SpcT0B/PsK0bOtvV3bUH
         /lH9yW0/vaw2GzEOhntyuryhTDejBtWIwGxRvG0dGYG3tMlkHwM2FWXt3vX1poSNPOet
         2bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kZWZPrQd54BSDgxOyeSGv4OPeqvj2vn4bH0lrJGj4Ms=;
        fh=HTDLhVQcnh4xY4A/8LlyGl7m1xAKbv6Btzk1Vi46D40=;
        b=nz8s4ZDWpqCSPLx9sqYE9X8Qjmivkzno99pRysQY1QZr4igcxg959JTWmBqDV6SVPA
         CyuIpTiiMC7cK8KSJcIIApl9B9hg8SrZZTudCv5/tzGV6GYWm3zRfEYSBL9J6dsbl1AJ
         0asXVZyQ/AhZp528LvJ5nLTKCy8G0fXUdpM1iJOgUDt0rUxgCOP50jfUscxm5ENOvTk5
         IpDqZUCZqTSi1d/lIrXm5Fc5Qz2a85uY2F6khRs09zxcP05dJieZ1mk9Dw1ZGveAf736
         OLcyzOZsaKqwW8PMy0DoYBMN5m8gq5lUO/2S7LRCnLylS5VItFbg5O6nDUPPeX2L/oRS
         8v1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784136263; x=1784741063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kZWZPrQd54BSDgxOyeSGv4OPeqvj2vn4bH0lrJGj4Ms=;
        b=dNCYOZMTjKvT0n9mozUVbvLRG1A14M16Z1TvZR3ewSOJ+92NuK981pCGbz0cJR8G/v
         HZ9PCP8U3kNdzdLB1nQyZOJmoUURtDQjt5G4xiEnxaLmIB+YqZ+OmhOctzJMfTUzSCyl
         8dIAR1FJOjGZN1ZxAcLnf+sedUEutez2ZDGxHHev48ljqHuf9Ac7o3Nh6ehLVcbCH9UY
         1d2hJZCCJDaxcxpxH1DPiMp+AoH0JjEUkUWT/MkCA5BElQ5kA1voBaGJZhKWrG08qtIG
         9feO3TtNOD5T7kkt8prcTYd2hJICs34SDy19QNYsZjM7y5d2BOIsiaScDe+/TN9LTuaB
         OWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784136263; x=1784741063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZWZPrQd54BSDgxOyeSGv4OPeqvj2vn4bH0lrJGj4Ms=;
        b=kJ7o6wjYcTShGz7a9yth2mhexr39C8sxdki/Rb16Q8n8bC7o70fKYpfeYPJF/G4Z0R
         j1mW0yeiSq1dQaBeu3f7HFH4rHe4FlZdobs/348IohyLzVoC9NHtC0CACvjs1aW+HxfF
         /Kiv3NlOXeHzka/B+AUuNTR+8RDhPpMSBQI96tlGgqGAKSpvXMKEAfvS2nlJoqGtlGw2
         cGGQu+asD7OzuV21LdEsJG4NX10cq100EXJ0trA24YJJiLGxBR0Xsu7ODAm6WHg/wADS
         ETHQ75/Ls5YiErNJUfllthfKQn+yFBlIIwS3tncX/8eBKuAVbo6kjdI9MAsb5DKNEz0Q
         P3mA==
X-Forwarded-Encrypted: i=1; AHgh+RodAeCM73Ec/EUs+ay6HsrBjcQ9zyU5UDlB1GD4VMkcOGmw0TQiBZhccq0RVHHngloO4HfdNnwwrHEZY4ns1ytr@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCIbWZkvHBAxVFI6tuITAcbeTzMkmAfuw+yLOA14bV83cT9pd
	vRh/adL3aAV0aoj/xk5ipizYbzJZgG8cZgqipXsQISEdOWQOzMfEtNoAGG8W8ziKiW38evIlyLz
	jqRwwNYSfSks8vHy8TZ8reW6niCFiPQFp2PDcboEG
X-Gm-Gg: AfdE7cnp1u/S67IHB3p4FzvLECXyVVopar2KTw0I7dPo9V5R4dC32ZDKbNFPn2QKz7T
	5WtmNvbNE5KCCJfNvzdHjOYQ+TS5tCPO7k1OXMyajvwVN0MDv8zLpGE/jdHZ7/9X5//k4RZFNkD
	g9vC/Hh094mf95ehUv0x7N3brIZM9XBtS6TWVRVhb5zBYeYey/gtj1IorUMVS1Ih48VUDgCwfpf
	elHaFcOohHG6dTLJ6XPCne5rSSxWBXilFokEkJ1yrP1NLqkyOmLn6T3CEzPG7wKIGtBpgC6RhDj
	2aqpo3yqUUkjYpax6LTT/CTypl4=
X-Received: by 2002:a17:903:3807:b0:2cb:14c8:1ab9 with SMTP id
 d9443c01a7336-2cf18cd4872mr182285ad.0.1784136262817; Wed, 15 Jul 2026
 10:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
In-Reply-To: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jul 2026 10:24:11 -0700
X-Gm-Features: AUfX_mybqHGCI446L5L7h2Zp_6_VyrODdqkNsCPAiWVWAbvp3R1ALNx_UrcHOIY
Message-ID: <CAP-5=fV=_CsZFJf9HhNrJ+=jXCTqqDGd=HvwjMWu2WEn9bXqbA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] tools/build: Allow versioning of all LLVM tools
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 7:54=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> I ran into the build issue mentioned in the first commit, because using
> an option like LLVM=3D-15 is a documented way to build [1], but only
> some of the LLVM tools defined in tools/ support this.
>
> After fixing that, a lot of other tidyups fell out. I didn't go too far,
> for example some selftests include tools/testing/selftests/lib.mk which
> reimplements some of the LLVM_SUFFIX stuff, but other selftests include
> tools/scripts/Makefile.include and I stopped before touching the former.
> Some other non build scripts hard code toolchains and I didn't touch
> those either, this change is only focused on things that already
> include Makefile.include.
>
> [1]: Documentation/kbuild/llvm.rst
>
> Signed-off-by: James Clark <james.clark@linaro.org>

For the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes in v4:
> - Drop "tools/build: selftests: Allow versioning LLVM lld", clang
>   already picks the correct sibling lld version. (Sashiko)
> - Link to v3: https://lore.kernel.org/r/20260715-james-perf-llvm-version-=
v3-0-8854bfe5af7e@linaro.org
>
> Changes in v3:
> - Add warning for empty $USE_LD
> - Use $HOSTREADELF in bpf Makefile
> - Rebase on v7.2-rc3
> - Link to v2: https://lore.kernel.org/r/20260518-james-perf-llvm-version-=
v2-0-f12cc4f031d8@linaro.org
>
> Changes in v2:
> - Fix selftests/bpf build. LLD needs to take the full path to be used
>   with -fuse-ld=3D
> - Link to v1: https://lore.kernel.org/r/20260514-james-perf-llvm-version-=
v1-0-6cac1a9a4c8d@linaro.org
>
> ---
> James Clark (4):
>       tools/build: Allow versioning of all LLVM tools defined in Makefile=
.include
>       tools/build: Indent if else blocks
>       tools/build: Allow versioning LLVM readelf
>       tools/build: selftests: Remove some duplicate toolchain definitions
>
>  tools/bpf/resolve_btfids/Makefile    |  3 --
>  tools/lib/api/Makefile               |  4 --
>  tools/lib/bpf/Makefile               |  8 ++--
>  tools/lib/subcmd/Makefile            |  4 --
>  tools/lib/symbol/Makefile            |  4 --
>  tools/perf/Makefile.perf             |  7 ----
>  tools/scripts/Makefile.include       | 77 ++++++++++++++++++++----------=
------
>  tools/testing/selftests/bpf/Makefile |  1 -
>  8 files changed, 46 insertions(+), 62 deletions(-)
> ---
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> change-id: 20260511-james-perf-llvm-version-43ab1cb5bc7d
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
