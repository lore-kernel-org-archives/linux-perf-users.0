Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A191378D8B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100060; cv=pass; b=ZZsfpSnEOtzFxQscbiepgNyujt/jEzypT53UdOYhuQxvElOv0IQ0EA97z4+j2MjXTCt7IleHAqbUdJTAZbEy0gGEKWEJHMcRCh/wBdylzWUm5tZbsT9eRD0palblAtG+LYeoFIvPfroWw3OyZ2TajNUBMCjl/732GTp6GlD6bx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100060; c=relaxed/simple;
	bh=YsHa53y8RCu9ipBGtG2gNDk5iGqSsX3V9bWPSWRdh10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZYuKht2FyL7Id1nNpuATXDj3LEzR0b9SfMF53IfEx3XFh2ItHtXv2/mKeOSp33rPEq5XHkbXA0CwfM63Jy70QVdqYUOANdP5WQP51yGY9nuMUBL3hLJy1TBv7YvBOu5aN5PNWdhshwzDshL2LT6axcaDBJLmVxoDmQ6eEyQNUWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3kXbiPr; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3kXbiPr"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a8e4ae61a0so37795ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Feb 2026 22:27:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770100058; cv=none;
        d=google.com; s=arc-20240605;
        b=ebUftxPwYEOn3CYJH5sZfoAWmq/1oGcVKfKyUZDlRdWcavGyjMR4Gbp+tPs0BFNYkf
         Fp6G3w2f3Is70fhmWLhKowKfVAiN5v2ms8Pytm4OWF8Jjt2O2aT6dFdrkZR1pCCZyUN1
         eJj9VL2Akmg8LTXki7aFxCJQSGwqgXxdxDh0U8IHq4RIhPcu4GHT05MaKhiS1uHi/q0L
         I4Oeeo4pvSQFE8r2OoUeh3cFqkl8Jq+mpbd6yFFtPVflfO8tkakDHTGNq5yrGQEx+WqK
         oQlZFmjd/2E2gLz1woCcXBYXohHiXbqCuEYsmdquZ//VicNOU5V3mDAnIK9m7WUJ/2uX
         Zd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=siCcI4DGAEoRuYxfheR8sBC8+MYbD6VsH7sC9QjQNlk=;
        fh=RACDm6IxIGQ7f0Rwk5nTJ2w9xzzN61IBv8NgOtrO+dI=;
        b=JD1Cr8V3QXGsi98r2Xzi00JcKkHxRUW33C/webFYrHVBgKNyoekKugRG0v7kDHOnrw
         MRxRvJLgdrHcC6+kstr6uX2GRinq79SJvjhvhceBGinSWbmO7LhOfWoXKHMCfQjaF7j0
         zC5objIaquIZ79Z0PPX3Z8pMC3KgsdU6FeY4X6ucKXoFIdqGPmFiJ2O7WXV1hwzc7atS
         Ump7UBIWtUtSgaj9F+0POA1+bvVYiMnNNX5rKTauzafzzDAvt6yVKbPEfauTyK/aYZZS
         r8KERqIJomg2A0FVKhpMokRspHpgqK/62dhPfO8NAs81B6fyzE+67KUskL27XZGXvP7k
         OP8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770100058; x=1770704858; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siCcI4DGAEoRuYxfheR8sBC8+MYbD6VsH7sC9QjQNlk=;
        b=q3kXbiPrAJk/q7S8p0LFBnv/vmLj94gqE+88kkrHdG778eZ2K/9jJigDq4r1d0kLuM
         TveBDg4GAf2JJfNUuxP2KBI4GsBHbb0679bVk7m0zIjrpwDREDEkzPnoC5JT95YzXGJr
         zsUja+TXBwX2lMr99b0/eTw155V5Jlf/KvbGbpoI/fVb5rcsvWZZP+HoLsanbNIH7ROa
         nmtG4Bz68WIdG5JToImbszdWs8ZK0lo5wWpzIR+TT7r/LkXT2AYgKET8y/td9fOgxEI9
         KQcC75eWTlo1doTjIAtFe5UVgMtYXuqt2OI+5Tc5a/whZ1eRprhU/4sc8Dv+zh1nmF6I
         bN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770100058; x=1770704858;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=siCcI4DGAEoRuYxfheR8sBC8+MYbD6VsH7sC9QjQNlk=;
        b=SZNeulW22kEjhoal62laXubTWP2RSxyToRFfIkGnzWu5XqsnyZEPTmRK2Cg4mxiKmS
         WixStCnEe1bEw+8Xaf6dbEl1LoNTo0QskwHoUMh/URc0ohQYMAlLdiDsQ9zVaneB+DDc
         7V8OhXdhiRU4UEjxtIQWCTJOoKA2+br2FYmUpa3rppL1xGxbbE6hF58Tz+YoqG04CMbR
         ZesJSCrfPk6bfV2JjWgb9lw4FOVm/Bu0zWWUUERQ0QQgBdigQK4Vz6Ij5yW9IgQBgL7H
         TLDZHbo9Ot/jaYjz2cnWm9vQMXTxi/NagRi6o8OxxpVpStGynbSKP/WPAr4NGzcch129
         FgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfsVCISiN+K9rsiL7smbsmAI59UttDtEitgiXkuF5OntBwldVTWn0SBKKMrQtrD/OytrOupg4qeDmurLd4G/46@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHwUEhemTnz36AVZnzbN3eukz6Ie2EaiYzSdKmnmbLK/rurgC
	xjlyhHmhhgt+8Ds8cq4Y4PzZGF775qhyKzB0dBchAXfDCm99ruNOMlyNHegzVEttB8GCIjP/jr4
	4N1TEQPvwqDd3H4MfVEWbEfvHD/bsQGWwQOiQLISP
X-Gm-Gg: AZuq6aL+ulD7UGC7iL5YmvGDYU5AKoCg6pcLeuy76tWudL5tD0uAgTeMkcATcq2lCEm
	sBnVt7EcaEeHJP/BY+LrUtwBvlvwT8FutyOPefj4VT7Hm9q/oSaLe9gHBQxcXLQwmFS9/qwIzrK
	Vt7Be1JwXOiJcZEd4Ax9H4JGZvf3eOaFYvOGtqWt78BzLZT6yI2DEqA5pGnuwPaIaFjlmaCvhff
	r8u5d4X80U7qayUBk747ByD9ctAk42mfTDOyhtD9R+afv2XkGAJzfnp53c8OhNlvjSLKkry
X-Received: by 2002:a17:902:ffcb:b0:2a0:7fac:c031 with SMTP id
 d9443c01a7336-2a92854b1a6mr639385ad.14.1770100056946; Mon, 02 Feb 2026
 22:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203051327.2836070-1-irogers@google.com>
In-Reply-To: <20260203051327.2836070-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Feb 2026 22:27:25 -0800
X-Gm-Features: AZwV_QjE5Msh-IwP44rkYWujj5uhu0oYBRIO8Gdky9fuaHnS5d1uKy52P_cHyw4
Message-ID: <CAP-5=fXV48R6rrpWnTwBHqFuOTF1BSL=0CGBSj4=8JZ5wAMT5Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Reduce pmu-events related copying and mkdirs
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 9:13=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> When building to an output directory the previous code would remove
> files and then copy the source files over. Each source file copy would
> have a rule to make its directory. All json for every architecture was
> considered a source file. This led to unnecessary copying as a file
> would be deleted and then the same file copied again, unnecessary
> directory making, and copying of files not used in the build. A
> side-effect would be a lot of build messages.
>
> This change makes it so that all computed output files are created and
> then compared to all files in the OUTPUT directory. By filtering out
> the files that would be copied, unnecessary files can be determined
> and then deleted - note, this is a phony target which would remake the
> pmu-events.c if always depended upon, and so the dependency is
> conditional on there being files to remove. This has some overhead as
> the $(OUTPUT)/pmu-events is "find" over rather than just "rm -fr", but
> the savings from unnecessary copying, etc. should make up for this new
> make overhead. The copy target just does copying but has a dependency
> on the directory it needs being built, avoiding repetitive mkdirs. The
> source files for copying only consider the JEVENTS_ARCH unless the
> JEVENTS_ARCH is all. The metric json is only generated if appropriate,
> rather than always being generated and jevents.py deciding whether or
> not to use the files. The mypy and pylint targets are fixed as
> variable names had changed but the rules not updated.
>
> The line count of a build with "make -C tools/perf O=3D/tmp/perf clean al=
l"
> prior to this change was 2181 lines, after this change it is 1596
> lines. This is a reduction of 585 lines or about 27%.
>
> The generated pmu-events.c for JEVENTS_ARCH "x86" and "all" were
> validated as being identical after this change.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

I just wanted to add a note on testing this change. You can see the
rules run by say building JEVENTS_ARCH=3Darm64 and then switching to
JEVENTS_ARCH=3Dx86. The first build will copy the arm64 json to the
OUTPUT directory, the second will find the arm64 json shouldn't be in
the OUTPUT directory and remove it while copying/generating in all the
x86 json.

```
$ make -C tools/perf O=3D/tmp/perf3 JEVENTS_ARCH=3Darm64 clean all
...
 MKDIR   /tmp/perf3/pmu-events/arch/common/common
 MKDIR   /tmp/perf3/pmu-events/arch/test/test_soc/sys
 MKDIR   /tmp/perf3/pmu-events/arch/test/test_soc/cpu
 COPY    /tmp/perf3/ <- pmu-events/arch/test/arch-std-events.json
 MKDIR   /tmp/perf3/pmu-events/arch/arm64
 MKDIR   /tmp/perf3/pmu-events/arch/arm64/hisilicon/hip08
 MKDIR   /tmp/perf3/pmu-events/arch/arm64/hisilicon/hip09/sys
 MKDIR   /tmp/perf3/pmu-events/arch/arm64/cavium/thunderx2
 COPY    /tmp/perf3/ <- pmu-events/arch/arm64/recommended.json
 MKDIR   /tmp/perf3/pmu-events/arch/arm64/thead/yitian710/sys
 MKDIR   /tmp/perf3/pmu-events/arch/arm64/ampere/ampereone
 MKDIR   /tmp/perf3/pmu-events/arch/arm64/ampere/emag
 MKDIR   /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex
...
 GEN     /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/extra-metrics.json
 GEN     /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/extra-metrics.=
json
 GEN     /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metrics.j=
son
 COPY    /tmp/perf3/ <- pmu-events/arch/common/common/legacy-hardware.json
 COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/sys/uncore.json
 COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/cpu/metrics.json
 COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/cpu/uncore.json
 COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/cpu/other.json
 COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/cpu/cache.json
 COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/cpu/branch.json
 COPY    /tmp/perf3/ <- pmu-events/arch/arm64/mapfile.csv
 COPY    /tmp/perf3/ <- pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.j=
son
 COPY    /tmp/perf3/ <- pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.=
json
 ...
 TEST    /tmp/perf3/pmu-events/empty-pmu-events.log
 GEN     /tmp/perf3/pmu-events/pmu-events.c
...
$ make -C tools/perf O=3D/tmp/perf3 JEVENTS_ARCH=3Dx86 all
 MKDIR   /tmp/perf3/pmu-events/arch/x86
 MKDIR   /tmp/perf3/pmu-events/arch/x86/elkhartlake
 MKDIR   /tmp/perf3/pmu-events/arch/x86/rocketlake
 MKDIR   /tmp/perf3/pmu-events/arch/x86/broadwellde
...
 GEN     /tmp/perf3/pmu-events/arch/x86/amdzen1/extra-metrics.json
 GEN     /tmp/perf3/pmu-events/arch/x86/amdzen2/extra-metrics.json
 GEN     /tmp/perf3/pmu-events/arch/x86/amdzen3/extra-metrics.json
 GEN     /tmp/perf3/pmu-events/arch/x86/amdzen4/extra-metrics.json
 GEN     /tmp/perf3/pmu-events/arch/x86/amdzen5/extra-metrics.json
 GEN     /tmp/perf3/pmu-events/arch/x86/amdzen6/extra-metrics.json
 GEN     /tmp/perf3/pmu-events/arch/x86/amdzen1/extra-metricgroups.json
 GEN     /tmp/perf3/pmu-events/arch/x86/amdzen2/extra-metricgroups.json
...
 COPY    /tmp/perf3/ <- pmu-events/arch/x86/mapfile.csv
 COPY    /tmp/perf3/ <- pmu-events/arch/x86/elkhartlake/ehl-metrics.json
 RM      /tmp/perf3/pmu-events/arch/arm64/mapfile.csv
/tmp/perf3/pmu-events/arch/arm64/sbsa.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
/tmp/per
f3/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx93/sy
s/metrics.json /tmp/perf3/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.j=
son
/tmp/perf3/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
/tmp/perf3/pmu-events/arch/
arm64/freescale/imx8mn/sys/metrics.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json /tmp/
perf3/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
/tmp/perf3/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53
/branch.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/other.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-
a53/bus.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/extra-metrics.json
/tmp/perf3/pmu-events/arc
h/arm64/arm/cortex-a73/etm.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/instruction.json
/tmp/perf3/pmu-events
/arch/arm64/arm/cortex-a73/mmu.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/memory.json
/tmp/perf3/pmu-events/
arch/arm64/arm/cortex-a73/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/ll_cache
.json /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/spec_operation.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/l3_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/stall.json
/tmp/perf3/pmu-events/arch/arm64/arm/ne
overse-v1/tlb.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/general.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/retired.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/metrics.json
/tmp/perf3/pmu-events/arch/arm64
/arm/neoverse-v1/spe.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/l1i_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/fp_operation.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/bus.json
/tmp/perf3/pmu-events/
arch/arm64/arm/neoverse-v1/l1d_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/sve.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/exception.json
/tmp/perf3/p
mu-events/arch/arm64/arm/neoverse-v1/l2_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a
75/etm.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/instruction.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cort
ex-a75/mmu.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/corte
x-a75/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/branch.json
/tmp/perf3/pmu
-events/arch/arm64/arm/cortex-a65-e1/instruction.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/ifu.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/pipeline.j
son /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-
a65-e1/dpu.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
/tmp/perf3/pmu-events/
arch/arm64/arm/cmn/sys/metric.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/instruction.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/pipeline.json
/tmp/perf3/p
mu-events/arch/arm64/arm/cortex-a510/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/trace.json /tmp/perf3
/pmu-events/arch/arm64/arm/cortex-a510/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/neove
rse-v3/ll_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/spec_operation.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/stall.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/general.json
/tmp/perf3/pmu-events/arc
h/arm64/arm/neoverse-v3/tlb.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/retired.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/brbe.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
/tmp/perf3/pmu-events
/arch/arm64/arm/neoverse-v3/spe.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/l1i_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/fp_operation.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/bus.json /tmp/perf3/
pmu-events/arch/arm64/arm/neoverse-v3/l1d_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/sve.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/exception.json /
tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/l2_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/a
rm/cortex-a77/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/instruction.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/pipeline.json
/tmp/perf3/pmu-events/arc
h/arm64/arm/cortex-a77/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/extra-metricgroups.json
/tmp/perf3
/pmu-events/arch/arm64/arm/cortex-a77/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57
-a72/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json
/tmp/perf3/pmu-events/arch/ar
m64/arm/cortex-a57-a72/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/spec_op
eration.json /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/stall.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/tlb.json
/tmp/perf3/pmu-events/arch/arm64/arm/neover
se-n1/general.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/retired.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/spe.json
/tmp/perf3/pmu-events/arch/arm64/arm
/neoverse-n1/l1i_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/memory.json
/tmp/perf3/pmu-events/arch
/arm64/arm/neoverse-n1/l2_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/extra-metrics.
json /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/ll_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/l3_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/spec_operation.json
/tmp/perf3/pmu-events/arch/arm64/arm/
neoverse-n3/stall.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/tlb.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/general.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/retired.json
/tmp/perf3/pmu-events/arch/arm64
/arm/neoverse-n3/metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/spe.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/l1i_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/fp_operation.json
/tmp/perf3/pmu-eve
nts/arch/arm64/arm/neoverse-n3/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/l1d_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/sve.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/trace.json
/tmp/perf3/pmu-
events/arch/arm64/arm/neoverse-n3/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/l2_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/extra-metricgro
ups.json /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/extra-metrics.jso=
n
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/instruction.json
/tmp/perf3/pmu-events/arch/arm64/arm/
cortex-x1/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cor
tex-x1/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/branch.json
/tmp/perf3/pmu-even
ts/arch/arm64/arm/cortex-x2/instruction.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/bus.json
/tmp/perf3/pmu-ev
ents/arch/arm64/arm/cortex-x2/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/trace.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/extra-metricgroups.json
/tmp
/perf3/pmu-events/arch/arm64/arm/cortex-x2/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/instruction.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/ca
che.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/
extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/instruction.json
/tmp/perf3/pmu-events
/arch/arm64/arm/cortex-a55/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/bus.json
/tmp/perf3/pmu-event
s/arch/arm64/arm/cortex-a55/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/spe
c_operation.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json
/tmp/perf3/pmu-events/arc
h/arm64/arm/neoverse-n2-v2/tlb.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json
/tmp/p
erf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/spe.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1i_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/fp_operation.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse
-n2-v2/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/sve.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/trace.json
/tmp/perf3/pmu-events/arch/arm
64/arm/neoverse-n2-v2/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/extra-metricgroups
.json /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/extra-metrics.jso=
n
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/instruction.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/branch.json
/tmp/perf3/pmu-events/arch/arm64/ar
m/cortex-a35/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/exception.json
/tmp/perf3/pmu-events/arch/arm64/
arm/cortex-a35/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/instruction.json /tmp
/perf3/pmu-events/arch/arm64/arm/cortex-a710/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/trace.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/memory.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/co
rtex-a710/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/instruction.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/cache.json
/tmp/perf3/pmu-events/ar
ch/arm64/arm/cortex-a76/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/memory.json
/tmp/perf3/pmu-even
ts/arch/arm64/arm/cortex-a76/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/extra-metrics.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/branch.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/instructi
on.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/cache.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/bus.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/mem
ory.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/exception.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/extra-metricgroups.json
/tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/extra-metrics.json
/tmp/perf3/pmu-events/arch
/arm64/fujitsu/a64fx/branch.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/other.json
/tmp/perf3/pmu-events/ar
ch/arm64/fujitsu/a64fx/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/sve.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
/tmp/perf3/pmu-events/arch/arm
64/fujitsu/a64fx/memory.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/exception.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
/tmp/perf3/pmu-e
vents/arch/arm64/fujitsu/monaka/l3_cache.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/stall.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/general.json
/tmp/perf3/pmu
-events/arch/arm64/fujitsu/monaka/retired.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/gcycle.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/pipeline.jso
n /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/core-imp-def.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu
/monaka/l1d_cache.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/sve.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/trace.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/energy.json
/tmp/perf3/pmu-events/arch/arm64/fujit
su/monaka/memory.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/exception.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
/tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/hwpf.json
/tmp/perf3/pmu-events/arch/arm64
/common-and-microarch.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/branch.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/instruction.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/cache.json
/tmp/perf3/pmu-ev
ents/arch/arm64/ampere/ampereonex/mmu.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/spe.json /tmp
/perf3/pmu-events/arch/arm64/ampere/ampereonex/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/bus.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereo
nex/memory.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/exception.json
/tmp/perf3/pmu-events/arch/arm64/ampere/emag/branch.json
/tmp/perf3/pmu-events/arch/arm64/ampere/emag/instruction.json
/tmp/perf3/pmu-events/arch/arm64/amp
ere/emag/clock.json
/tmp/perf3/pmu-events/arch/arm64/ampere/emag/cache.json
/tmp/perf3/pmu-events/arch/arm64/ampere/emag/intrinsic.json
/tmp/perf3/pmu-events/arch/arm64/ampere/emag/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/ampere/em
ag/bus.json /tmp/perf3/pmu-events/arch/arm64/ampere/emag/memory.json
/tmp/perf3/pmu-events/arch/arm64/ampere/emag/exception.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/branch.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampere
one/instruction.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/cache.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/intrinsic.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/metrics.json
/tmp/perf3/pmu-events/arch/
arm64/ampere/ampereone/spe.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/bus.json
/tmp/perf3/pmu
-events/arch/arm64/ampere/ampereone/memory.json
/tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/exception.json
/tmp/perf3/pmu-events/arch/arm64/thead/yitian710/sys/ali_drw.json
/tmp/perf3/pmu-events/arch/arm64/thead/yitian710/sys/metri
cs.json /tmp/perf3/pmu-events/arch/arm64/recommended.json
/tmp/perf3/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
/tmp/perf3/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
/tmp/perf3/pmu-events/arch/arm64/hisilicon
/hip08/uncore-l3c.json
/tmp/perf3/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
/tmp/perf3/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
/tmp/perf3/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
/tmp/perf3/pmu-event
s/arch/arm64/hisilicon/hip08/uncore-ddrc.json
 COPY    /tmp/perf3/ <- pmu-events/arch/x86/elkhartlake/memory.json
 COPY    /tmp/perf3/ <- pmu-events/arch/x86/elkhartlake/frontend.json
 COPY    /tmp/perf3/ <- pmu-events/arch/x86/elkhartlake/virtual-memory.json
 COPY    /tmp/perf3/ <- pmu-events/arch/x86/elkhartlake/pipeline.json
...
 COPY    /tmp/perf3/ <- pmu-events/arch/x86/knightslanding/uncore-cache.jso=
n
 COPY    /tmp/perf3/ <- pmu-events/arch/x86/knightslanding/cache.json
 GEN     /tmp/perf3/pmu-events/test-empty-pmu-events.c
 TEST    /tmp/perf3/pmu-events/empty-pmu-events.log
 GEN     /tmp/perf3/pmu-events/pmu-events.c
 CC      /tmp/perf3/pmu-events/pmu-events.o
 LD      /tmp/perf3/pmu-events/pmu-events-in.o
...
```

Thanks,
Ian
