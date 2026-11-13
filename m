Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794608182;
	b=BSiFbb501VIOHJiOyP5SPmixpiobfkUI426kf9PKSY/Vu5/jDDIhp8qgZKdURsFQAS0x
	 VpRAYGVuL5E1wN7B00pCBF48n81SBiAoqkROqFIZsgz4p4QHStMCgQ1snig5CKbj1sURh
	 fXEytEqQJZZMwjCX6eCVgkycpho4RrgMwZVIe8bpvQvYFeYeH2ZgM8fHmafL4EO9G04ug
	 erbcrpaXYVYzZ/EhoUU7rfabS1I754rg0sJZXotWD7/tG4+w3c/7U1th4zHHXa3hfx/cU
	 InmOCNyrJGJthat8o0Y7woYN0NdjIxJB6rN1vGH8BtRaeiHIfLtB3DyouEv3ZE8PR6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/HbOdkXMag7+QwoV4l3OE5fq7viwxSbwmRnha1ZYaRM=;
	b=0ViFJKqLsj/GlTY/tvkexYvZFdUlRQa8Ao4OmJeACRR5xKgE8go+TsIrrh3pO/GA/CUi
	 2v1NRw9eLddTteKx9wPy4XP63TWv4cFKu8StMvNQpN9ar6gKTSXsY1kdV2Zfnbj613/t2
	 MAS0/zYFBGyk+Pi8Sm0X2HygvENg6kNpi4tEAjuk2bmBYkLqdR2wR0p2VyRfIBGsowOqz
	 KQVImdZ1IcApSLc+jt3UooJpRY2axGGh8fyoUglp23GopXXMBBnMap3nu977qEBGhEFH4
	 d153HHyWlklpyVg0dzcb/pvEmB6fYRkppWowMLruTP4rmyhKlAuBoZM8XfeYFrmzuYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="D/xY6zeI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE14606A33A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CE14606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D/xY6zeI
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55be673e029so22171cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 14:16:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794608180; cv=none;
        d=google.com; s=arc-20260327;
        b=W+uEDtBN0nATTAvnVx6Tfz2TSmk7CQujk+7nPGuOJ7ZaxmwhaOKs8eviAmQPjv2SBT
         /GpH928TTzBjlKqOqquGEL9kY3nr2D7jgYuaQa8G+KnWtXOwnLQRk/+Y/ZeF5ZMCF+9X
         BBxN2G93xMRwiTxMENezZ576AzetPP261IIv7dGpf5uX+g8NoM7p6cVqK2kKm0fEqYBK
         YxMzDj8o08CgdbslqIpjqxc5A5b7p/UUs4vdnzquDlSRBzXyyvh3lYM61I2Z5LJLiOka
         TEI14m6lhQpNMp0A4C+uhJpmmCIoKm+9/g54FzlIrFunqrNxr5LgfWpY0k/vlqhjCC22
         2pvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/HbOdkXMag7+QwoV4l3OE5fq7viwxSbwmRnha1ZYaRM=;
        fh=nJRy82GQRma6oGptQ8ga9eKX4Bb75nsn/Hem3hPlL4U=;
        b=VJB8zGPPVLDBxLYHXvlSkCdyIhFBO0swxELHPtaoQ5oQcguUm6KmbJ4pv0nxOHtFgU
         OLrL0PWcMKQoGPgG5FikdIFuJZ+LuDTDnKPcgf7/ph7+aue4h9eiw3ae2OJejCYKFp3/
         6iOQfD8VDr9xtmZTmfumiSoHHqY2POQXck3PaQ7HWAu7B5V7grkkyi91MiJv4fuyfEcU
         fShKqffY9/0iuUe58JXs/nLHt/51eHfL/mhTrmbjH+SfjStu40dpmS1ZHiAC52OmScUb
         kalWumhLHe+QtS1p9VNbpFnw7fPGDesIcWb+uFDIUOBe5puW+YXpkbfQ+bupHa0gGZPI
         ba4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608180; x=1795212980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/HbOdkXMag7+QwoV4l3OE5fq7viwxSbwmRnha1ZYaRM=;
        b=D/xY6zeIYBb/bGw4iaadffq6fSa3xmPLTrPYDHWw96cQSyEosZ/6rF//tY3MkbNjS5
         uSB4koX7v+xuVLXcNFBHxglWKUhkhdCCxEhSq/ZTopfQ7XydKsNdQz5fTNnCM8ifEyPD
         4STKKe6f7qL74705mujY0LeDPfn1FFYK6rcUzOLyMh89bgbTxb9Z4ehcZzpQ7+xOYUIO
         RNP3WqET93kZjvtvMLEVU8zlzjn6fP4dzqPjhDlv+uluYgXECar8fRi1bQ5y0A0Nl9Q9
         kW3yJXGSqCyRi1lWNv+Ql2FSg9HIvRxNOD96gqZw9zI5RSYYbDgRy0FlQPkwHIRZpPEO
         2d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608180; x=1795212980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HbOdkXMag7+QwoV4l3OE5fq7viwxSbwmRnha1ZYaRM=;
        b=VFpzzP2fLVgnTxY6IgiqZ3ltfFSYZor4MkhQh6K8DFNRGwsIE97zNr7SKEnpx6SdJ2
         m3v8pHiN1+WdVzwmNdIazoF77kYu0eHWzZuLymFYb+98r9aZO2RBxZHE0SFQBwBi0grn
         mAvS/6XZ1AkvPsyih59ZMsnmMroaAjr2jNp+k0KGgo8cbT3kvFJ5jxhjBYBoy4+qX4KW
         OldKJ8WGZ7J3Zu83yhH8yLsa71qy6CbI5n2oDlC2heXQ/l1EkcPycdDLqZWpB2QuvQL7
         TkQvRJmZ8RoHKTtyPn6dn4EuxFFqo+914CnnUze1Lzw9xAeXW9SR7GU6rplEuORIZiOI
         qoVA==
X-Forwarded-Encrypted: i=1; AL+hErFMtUruL/Tu/JqYu3DzPFCdFahly/qi1dDaVM1QiXaK64Fsf1OL+uWNKeaD3tXppmNPJPd3UPqrzzla55r+u6E8@vger.kernel.org
X-Gm-Message-State: APuU4Z8MwB+nVJedSu6cNtTIBsXXdqE74TJpgr47xqZ0k3StEHcO3A+H
	yAzb1Y1CzWb1tpTjgy4FhRFWrBh8pqk3eHPHb8U14ai9tNxPv4JLOcZ5+n5aEm2+c8VIqABIKMx
	itH20EaiRZ8+xvn3Ui9GijAOZ6T3DtjksaFxzjtFl
X-Gm-Gg: AYBFou3xrOEQ+OJj3BlYR3AcZOl3beJvZby/lRJbl6c8otBPJhivhPAyArsw8GP3TbD
	z5EWlohV7sCGslaeynYck8OMg3aSrLFpHE6IAyNgHusJbV66gfTBxE3qT4pHx2Qyg3veyq3Nm1e
	rtjixrtcskB6EGcKO5/YNZfRlAXHqHxA8F6XpWfVCBcw6n76LyRAIy82jxnmI8JSdD39Q6PNjfp
	UOPo/li3eI1iTgS0158iqP6iR37u8o1U5wwqLsxu4n7K/do46KHPzG0XsSxB+6mno35AMHpE4nM
	+QLz4lUB8lhvUuRSAlJgc+zs8L8wMJ3h0tIlz6/gPZxSOJAUQWKg1q4zIzFYt+9T2ppxUGeZXZl
	8HnKbZOS1wXg4IoNgjJ1DbXeH4LJL0UY+Crtvtnyr1WpXDqrxWTzVJuJqCVbTP/PK1Yw=
X-Received: by 2002:a05:622a:53ca:b0:536:78de:775f with SMTP id
 d75a77b69052e-55c69c2ff17mr2165351cf.15.1794608179013; Fri, 13 Nov 2026
 14:16:19 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113200850.2803460-1-acme@kernel.org>
In-Reply-To: <20261113200850.2803460-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Nov 2026 14:16:05 -0800
X-Gm-Features: AclHuK9NmNvcoESLqmGVD7lFBNU2Bql3t-oShpEw5-RBrs7NGcZUCfG6SP9QtS4
Message-ID: <CAP-5=fV1FRJcyCHg7vNjptZU996PBXcEcve5m3sYkUtdWSmT8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/11] perf coverage: A harness for perf, and the fixes
 it found
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 12:08=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi,
>
>         Please consider merging,
>
> Nothing measured how much of perf the test suite reaches.  Patch 1 adds
> tools/perf/scripts/coverage.sh: it builds perf with clang source based
> coverage, runs the complete perf test suite and reports line and function
> coverage, optionally against a baseline, with --table and --html like
> pahole's coverage_table.py.  Also as 'make -C tools/perf coverage',
> 'coverage-prep' and 'coverage-table'.
>
> The rest is what the first runs found, in the code, the build and the
> tests:
>
>   - clang DWARF 5 describes globals with DW_OP_addrx, which was not
>     resolved (patch 2).
>   - The flexible array member had no test; one showed the struct row at
>     0.00% while the member said 100.00% (patches 3-4).
>   - A struct pointer that -O2 keeps in a register was not resolved from
>     its DWARF location (patch 5).
>   - --insn-stat was printed before the loop that accounts the samples,
>     so --code-with-type showed zeros (patch 6).
>   - The libbfd probe printed a missing bfd.h error five times per
>     build-test run (patch 7).
>   - FEATURE-DUMP didn't record llvm-perf and rust, disabling both in the
>     build-test builds (patch 8).
>   - The Intel PT virtual LBR check lost every aux sample with a single
>     data page (patch 9).
>   - The dlfilter test kept samples whose IP the kernel now zeroes on a
>     userspace-to-kernel skid (patch 10).
>   - The LBR inline unwinding check failed instead of skipping when the
>     AMD PMU rejects branch sampling (patch 11).
>
> In a root run on this box the suite covered 49.16% of perf's 201,180
> lines.  The POLL_HUP tracepoint regression and the lock contention count
> fail in code this series does not change; the LBR inline unwinding check
> failed there and now skips.
>
> The numbers above are from v1 and are slightly different here: the
> cs-etm patch was dropped and the issues reported in the v1 review were
> addressed, which changes both the tree and what the report counts.
>
> The harness and the tests were developed with an AI coding assistant
> (OpenCode), which drafted the script and the tests and helped debug the
> failures; I reviewed every change and reproduced each failure before
> fixing it.
>
> What changed from v1:
>
>   - Patch 9 (cs-etm) is gone: Leo Yan's series replaces it.
>   - Patch 1: O=3D is accepted by all targets, the Python extension is in
>     the report, -f is normalized and the delta matches its baseline.
>   - Patch 4: the TUI browser counts flexible array accesses too.
>   - Patch 6: the stats test skips without libdw.
>   - Patches 9 and 11 (were 10 and 12): Fixes tags corrected.
>
> Best regards,
>
> - Arnaldo
>
> Arnaldo Carvalho de Melo (11):
>   perf scripts: Add a coverage harness for perf
>   perf annotate-data: Resolve DW_OP_addrx global variables
>   perf tests: Exercise the flexible array member path
>   perf annotate-data: Count flexible array accesses for the whole struct
>   perf tests: Exercise data type resolution from a register
>   perf annotate: Print the stats after the annotations
>   perf tests: Silence the libbfd probe in build-test
>   perf build: Record the display-only features in FEATURE-DUMP
>   perf tests: Fix the Intel PT virtual LBR check
>   perf test: Drop samples without an IP in the dlfilter test
>   perf test: Skip the LBR inline unwinding check when unsupported

Thanks for working on this! Patches 2, 3 and 5 add small C programs
compiled in a shell test. These are a pain for our CI framework; could
we add them as perf test workloads?

Thanks,
Ian

>  tools/perf/.gitignore                         |   1 +
>  tools/perf/Makefile                           |  11 +-
>  tools/perf/Makefile.config                    |   4 +
>  tools/perf/Makefile.perf                      |   4 +
>  tools/perf/builtin-annotate.c                 |  10 +-
>  tools/perf/scripts/coverage.sh                | 722 ++++++++++++++++++
>  tools/perf/tests/make                         |   2 +-
>  tools/perf/tests/shell/addr2line_inlines.sh   |   9 +-
>  tools/perf/tests/shell/annotate_stats.sh      |  64 ++
>  .../perf/tests/shell/data_type_flex_array.sh  | 142 ++++
>  .../tests/shell/data_type_profiling_clang.sh  | 108 +++
>  tools/perf/tests/shell/data_type_register.sh  | 120 +++
>  tools/perf/tests/shell/script_dlfilter.sh     |   2 +-
>  tools/perf/tests/shell/test_intel_pt.sh       |   9 +-
>  tools/perf/ui/browsers/annotate-data.c        |   7 +-
>  tools/perf/util/annotate-data.c               |  24 +-
>  tools/perf/util/annotate-data.h               |   3 +
>  tools/perf/util/dwarf-aux.c                   |  42 +-
>  18 files changed, 1260 insertions(+), 24 deletions(-)
>  create mode 100755 tools/perf/scripts/coverage.sh
>  create mode 100755 tools/perf/tests/shell/annotate_stats.sh
>  create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
>  create mode 100755 tools/perf/tests/shell/data_type_profiling_clang.sh
>  create mode 100755 tools/perf/tests/shell/data_type_register.sh
>
>
> base-commit: cc905a18a647a8e3ad42cd1596baa0e08fba26eb
> v1-head: 3f5465bea8f5a97a
> --
> 2.56.0
>
