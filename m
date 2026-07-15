Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEA46AEE1
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119190; cv=none; b=TU12CgOMm2eW20ufPOY5CxjjnK0Zev2gl1ZS9PmZpX7M+b+y8VujzVVv0ZJpn8/6g6l+BXwyBhZj++K4IMVSSJ+olAfM+NjAC9Qk/YfD6Qb7eBRduhdXelEGysMrPxiF568pMbIkuwvP4aAsdHPfmHLsz2eRtvmi0oKb6p9PoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119190; c=relaxed/simple;
	bh=455wlYCUNnMcrIdVi41A5Y7HIm5ipb4kz3mpabm/Y0w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QzxTM9UcDP0UUVj9/epg9rMGkuAzquij/sAHt8iC60nausal4P5tmLJTMzdTpMq1Se1iPM86GT1kt1+kNjxq3vKVw2sGTsr/ve4QfEfibxSy+NhwTngAKk5/jngdser6hnjqVfKQpZajYcYQYg5y23B7ApXjXcrfeK58qqEmhqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kgncm9lg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kgncm9lg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c19bad03so48191725e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 05:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784119186; x=1784723986; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pqmS0wGyyzISZUi2iZDsoqebuB59CdpacRLQw8zIRIw=;
        b=Kgncm9lgIzJm83nbLcjcEhzgHLFSmNh6ygNjhvozc40NOySKqDv5qn7pAzvri0uATH
         IbW/OhHugTXmzO7HNKN5clCWay4yXnzcdUYvjna7Q717ytkcZLEtBPX0ZEvum+ta3PpO
         Fm0uN+JaUr1gNI238ZSeVwmEUAg6e2QWILnnyFzRI+mh8U6OJY/9I8PXJTWtBMQSNE86
         Yo3x+AOH8bqQxITN+xzks4nO3wjg+c0nBQ8xb4OEbAWAcPXZon8BjF6e9h9ae1HvUNdB
         Z0/Hj27+ntGUDHg5cUB93Y7/q/1G7X4ar7k4Bay/jG97b9f8p6QsUwuBvUuncIwm1MwQ
         7F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784119186; x=1784723986;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pqmS0wGyyzISZUi2iZDsoqebuB59CdpacRLQw8zIRIw=;
        b=Eye40zvrvn3tGfbh3+VQQVPssErWCcnP/Pgk9khSKs/cND6DK+VUD22LfIyEvuYG/j
         m5bOaM6gQkqDHH+F3rjv/mrGG8cervNMarLB/Q9lWTLhMnbMBj/9mYmNZe92gJrGctaa
         IriHJEwDHGsudMNIgGqjh0TbO++3ftcHIrpyteOLkj8et1RykZdMEL9Mux85Y6B4NY5W
         Y0VIXJtiRh2ciPmiErc1YEh3X/8HtP20L3Gx5ZQ/KN1hAURh2bRnzwfgxWrPA95TpgT/
         sLEZlGNBnmSAMzBNfYRUWKj7O/QZJqgqXzX9bFPIhCLa47peSpLSbV5pM0oKfwRBr9Ky
         LOpQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8Cp9ir0czD/rbwUzZlVPYtT4uB2MtTFUc9nF0v8bWSTYw2rU+pJRXQg29e5+PvIjRDTNVKtin4xf1mWWJDtsA@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0Tg9aTxgHk2PianUgm8J4EkXpnWHxzr/NDW59b0u/ARTD/+m
	6B8vhKMObSRTzqIEKI9rPFouzjWE0o311dOf3D0oZQnPLpaxo2dYwEY08pv62XZKpYA=
X-Gm-Gg: AfdE7clCxWwrtX+dd3+CsEjO7feq5+t93QvEpGq8/yQScPrGU4oKdP8CiaUw//1qXrw
	cXEgXFvAJDAjaIVczYpgTS+7X+b/oBF5Qgj9JKUNeF+0Q5XLUclstOfPJUc60hyrNOA2Fej5HPN
	NezPxv5LrHIQdfZU6UbqStwZFjbFJ18xwP8AT8xuAux2RHVwGIgkTAlp5M3DWcR84PuDxPK1ywq
	DrSoxo1Q7mvQja6IEU4A/N8bu+G/aged3ZgII9PTXFv2B09VOce2CDKs0Asku1yTEr/dE+/wGtr
	MKKzLJTsR14eyUSHXL8BXMgxYTQhHzC5bCFtNK5rqM7depvPORDFlT4fflJaM8+MruE9HycJKkZ
	mQLFmTH/0qT3hcttBuJsWfnHDgg2y6ms0NE+dxOWnQcPsvgKPEs9xeRztvrCvfgmKtwocdAdU2U
	APbXfls0VhCSoIaO2VMXd1qw1y3kW/3vxP
X-Received: by 2002:a05:600c:6a0b:b0:493:d2b1:48c8 with SMTP id 5b1f17b1804b1-4953c28b6e7mr23273595e9.33.1784119186462;
        Wed, 15 Jul 2026 05:39:46 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c710facsm32360695e9.2.2026.07.15.05.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:39:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v3 0/5] tools/build: Allow versioning of all LLVM tools
Date: Wed, 15 Jul 2026 13:39:16 +0100
Message-Id: <20260715-james-perf-llvm-version-v3-0-8854bfe5af7e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHR/V2oC/3XNQQ6CMBCF4auQrq3plILoynsYF2VaoAYomZpGQ
 7i7hcREFyz/Sd43MwuWnA3sks2MbHTB+TFFfsgYdnpsLXcmNZNClqIA4A892MAnSw3v+zjwaGn
 dcJXrGrAuajwZltYT2ca9Nvl2T9258PT03h5FWK9fU+2aEbjgJWoEfdYKK3Pt3ajJHz21bEWj/
 IWqfUgmqAGJqBqRg6n+oGVZPneZK28IAQAA
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
James Clark (5):
      tools/build: Allow versioning of all LLVM tools defined in Makefile.include
      tools/build: Indent if else blocks
      tools/build: Allow versioning LLVM readelf
      tools/build: selftests: Allow versioning LLVM lld
      tools/build: selftests: Remove some duplicate toolchain definitions

 tools/bpf/resolve_btfids/Makefile    |  3 --
 tools/lib/api/Makefile               |  4 --
 tools/lib/bpf/Makefile               |  8 ++--
 tools/lib/subcmd/Makefile            |  4 --
 tools/lib/symbol/Makefile            |  4 --
 tools/perf/Makefile.perf             |  7 ----
 tools/scripts/Makefile.include       | 79 ++++++++++++++++++++----------------
 tools/testing/selftests/bpf/Makefile | 13 +++---
 8 files changed, 56 insertions(+), 66 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260511-james-perf-llvm-version-43ab1cb5bc7d

Best regards,
-- 
James Clark <james.clark@linaro.org>

