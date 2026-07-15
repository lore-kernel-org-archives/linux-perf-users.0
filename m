Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3139A7F2
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127263; cv=none; b=flTOb+ELn1iAy1XdX4tqqIhHmZqmPyagttafNwejZqS1EJaNHqbONpRIrdz3aQ45W7olCtN3KwC+iH33i8NnJb8+8STQHKqMoz7ccbxVfowYc1MNrmctDBrIUe0Iq9JwPXUTQ1gAk50dgfiPNUEzJjg0eKV8XrhnXVILdjYFq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127263; c=relaxed/simple;
	bh=B0WPxj3EierW3H0emFrNYAU3ITUd/G+ZN9Cb4xiUUa4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K0JErDKs4PUwRclAe9/aOqgbkUOqtlYfZsUChrDaLefBXjzcIsKy/J3iFQps7bG/K7adJjablA6PEgeLHE3uGdKt8hcw5ZcpTkczXewOXzI5bXy2/POO66rbyCBGdH/aBjs55t4USpoK0l4xxV6SkXnR0NPiY9O1lJuhM9PC7c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nElDO6d1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nElDO6d1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47df6a5202bso3598674f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784127256; x=1784732056; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NoqWI+ZkKhb51wo8tujVZWJK2s6uymb7bKFku4KV8C8=;
        b=nElDO6d1lmbSDXiDUFVzPy5O1oargC2cX5VmUmcGJYM76UZvT/plCpwdUtwGrypAtI
         QgXh0ug/5pEEFuMi6THgzrcx5avL9psucFCayeITCGSOvcIqax9SSLsb1z1sst3XJ1xy
         l+04JuVYkXaBn//og+ltyLuIanZkp4sjs1+n/HZb4R1jiM5vFo/1qnMsxbJNeEHNb+Fn
         X4B/SR1319Tb0Ahn8zitikMahSf2xUmKJInr0LZ9UWUL+Av5sb/nGfsLsKr4a8ONky2j
         Fu0nBCBHwWtHOxLrZrmIs4mQgeTQdTJzpGjc2Vtko1G4R4yNJYIsUXbmsnmVo7WKYHjQ
         gghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784127256; x=1784732056;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NoqWI+ZkKhb51wo8tujVZWJK2s6uymb7bKFku4KV8C8=;
        b=ZkIk3oYkd4qB2oLRYReIdHzllTBCEzsdnmttKEuMPkciuH209zwJXm7i4VjWNDSGR2
         5l+MLKdE7kjwcN6rJnlV1nBlr/lssIJ29Z57tx7+zz44SfCw/MsgYl/MtlS5WyEaGh9l
         O7Ukhr5Vl6bOhA4rRICSXnBoCH+jK2QC+90VSQy7dOi8M8Wl1fRcfBZtp3ae6jI4VOzM
         Jo9lkkgXYinPuSUuQ2xx1teXIrCjdIYsuMpewyhuOlZGGijNJDyzCGetHb2Tnd2QsgkO
         qGNyM3w180W/us5yeQGikZayxtocEt5Rb4JdH93Sel9TPNwSJxhd31y03rCMZ8jL/qaA
         nLRg==
X-Forwarded-Encrypted: i=1; AHgh+RpndZGWiwQc3fuLI9BsQs7JDVVa1bt/NHnpNwMuHd/5YkBQf3Eq2eWfEcYagjKvppHwXNxFeXqZe7s5FZZNsLUs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpp+7/0F9VDe3SajWpvzSAwj/yYVOBvX4HL3Zk/1pEyB6dREU7
	tWxqRKyPqynBUvFILYlSfcAASQjvxGRaVgledjCyA5njxvCFx5rhouHZhjCqjrc69/o=
X-Gm-Gg: AfdE7cniraJN+UlAntWugIXIwxzvwTrwDpxPQYqA/906r+eJg1vxLxr6XCcnHKipplz
	TGDEaeHtpFK4KqYVTo4vlAqBTL+84Dn+lGj3/pyJLREw84T7D2drCgJU3bO0Fg9/TavIEIw5ULq
	MiGxyx082aWuXi0COlFQ5PyKDSJCQQ1vYD8nQ9nGvQaBKT9/FIWriSUlCvtlCoGsd6LMt5FVUcQ
	mJae8281jGzijUHDpnUAQSb9cOxhydXAXKzEsvt3WypD33GcyqnWsaOTDVVGSh6lLHMkmd+Odwq
	5S5pGdhWHPzfBrmTxg0BPsTev5klxbK72vzzKC0mLwvP3Im2mHDISjmUgxfDnAlolOiuaWCfpOD
	rndboyJv08RfgI/46OfKBRR6wR7cIV1qSMUUV0YCIP89Q+hFHkz7Tt4eRhDLfQtaFlgvpCZf9w8
	371wXU2n72FpbibfyXSg8IIg==
X-Received: by 2002:a05:600c:3487:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-4953c144adamr35488965e9.4.1784127256465;
        Wed, 15 Jul 2026 07:54:16 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49510c8e220sm137649275e9.15.2026.07.15.07.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:54:15 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v4 0/4] tools/build: Allow versioning of all LLVM tools
Date: Wed, 15 Jul 2026 15:53:47 +0100
Message-Id: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPueV2oC/3XN0QqCMBTG8VeRXbfwzE1XV71HdDHnmS7MyRajE
 N+9KURFePk/8P3ORAJ6i4Ecs4l4jDZYN6Tgu4zoTg0tUtukJixnZS4A6FXdMNARvaF9H280ol8
 2lBeqBl2LWlcNSevRo7GPVT5fUnc23J1/ro8iLNe3yTfNCDSnpVYa1EFxLZtTbwfl3d75lixoZ
 N+Q3IZYggwwrbnJC2jkH1R8oArENlQkSErBa4NCmQp/oHmeXwJwbDdRAQAA
X-Change-ID: 20260511-james-perf-llvm-version-43ab1cb5bc7d
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.2

I ran into the build issue mentioned in the first commit, because using
an option like LLVM=-15 is a documented way to build [1], but only
some of the LLVM tools defined in tools/ support this.

After fixing that, a lot of other tidyups fell out. I didn't go too far,
for example some selftests include tools/testing/selftests/lib.mk which
reimplements some of the LLVM_SUFFIX stuff, but other selftests include
tools/scripts/Makefile.include and I stopped before touching the former.
Some other non build scripts hard code toolchains and I didn't touch
those either, this change is only focused on things that already
include Makefile.include.

[1]: Documentation/kbuild/llvm.rst

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v4:
- Drop "tools/build: selftests: Allow versioning LLVM lld", clang
  already picks the correct sibling lld version. (Sashiko)
- Link to v3: https://lore.kernel.org/r/20260715-james-perf-llvm-version-v3-0-8854bfe5af7e@linaro.org

Changes in v3:
- Add warning for empty $USE_LD
- Use $HOSTREADELF in bpf Makefile
- Rebase on v7.2-rc3
- Link to v2: https://lore.kernel.org/r/20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org

Changes in v2:
- Fix selftests/bpf build. LLD needs to take the full path to be used
  with -fuse-ld=
- Link to v1: https://lore.kernel.org/r/20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org

---
James Clark (4):
      tools/build: Allow versioning of all LLVM tools defined in Makefile.include
      tools/build: Indent if else blocks
      tools/build: Allow versioning LLVM readelf
      tools/build: selftests: Remove some duplicate toolchain definitions

 tools/bpf/resolve_btfids/Makefile    |  3 --
 tools/lib/api/Makefile               |  4 --
 tools/lib/bpf/Makefile               |  8 ++--
 tools/lib/subcmd/Makefile            |  4 --
 tools/lib/symbol/Makefile            |  4 --
 tools/perf/Makefile.perf             |  7 ----
 tools/scripts/Makefile.include       | 77 ++++++++++++++++++++----------------
 tools/testing/selftests/bpf/Makefile |  1 -
 8 files changed, 46 insertions(+), 62 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260511-james-perf-llvm-version-43ab1cb5bc7d

Best regards,
-- 
James Clark <james.clark@linaro.org>

