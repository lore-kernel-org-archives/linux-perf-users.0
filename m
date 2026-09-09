Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A758E2AC
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986507; cv=none; b=GFkyEflhp0TYT5tP/mWoc3tYMY6IQOTU6SZwCqSiTAXybamzS7IiYKb5cEOtJSdxfQtp2EQOU7AbzS7WZFsHAlBcGCYWyQpuj9Zmt+x+rcTucm86FtwZvv3Afy3OPj09sgaMwi7Ap5Jv2WiyJ02MqeO3Rm7K0soB6hz1Ucwsc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986507; c=relaxed/simple;
	bh=lzGikIwP3jt+gebSI9ASbBMxYIDTjcvzLhu0dadRD3g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L+hOfJHeJlo8j7M8ywjM9aTx3ANkiKxLQStV9V5hF8o1TQzmlwL+a3QKBtlGZeO3OIcG3DdlQsFmIC8rlm7jjiM0Fov9OMtw0V5hnqX2BmxUBf3pC0SEXXdTDA0vcTo2ORZyd3StUdnmAyzGkt8X0M3376b3i/1w9a05b85f6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDFHeMev; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDFHeMev"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db0a41434bso115232495ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2026 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788986492; x=1789591292; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQnCep2rVFC6ERkLpw82m7uGzTr5iSCdTDgfzxN2350=;
        b=VDFHeMev5pnXQuqWlK5DscSbU6oztU5Foif6XfZIkbz/x5Wn/+OKKITJdtIzbf+mVz
         2yWVMR17CirnHLdUAAtq48kIkX+T2TnwDiqWzSHMVcwhqY5aKSY/EoLcCmBPgtgfzp8u
         5OHM9Wyb2te5MxAb8KmTVSU1LFRFej36kqENFMYPxgpibEo/LQqlOozSrUwFU9LA3s2w
         M5XXfZ2fP65weowTLfN7y8Pdq59y08dlQFeZ493GThXTiM8eZUAZZy9w4Q4VA89TMqhq
         b2CKvuIwp73xXsJsYLk7SqoWNl/k2DSVu2CswSm4nAPE5L2Xs5GC+qwjEAFfcJQcnLNH
         ud2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986492; x=1789591292;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQnCep2rVFC6ERkLpw82m7uGzTr5iSCdTDgfzxN2350=;
        b=cs946j3Accs4ElNIeD0Re9jcFXvOdSTj083cz5JN/5Ec2T8d7qme5qG3ouq4nA+Grw
         +IWD51lQBb7BCIMYUrHwjD78nity1FcpmpjisRDdfZsqc1lkY8CrAzptr2zkbjsWF/cK
         RdSZf8VmpHDeUqyShit/W6Xl0b9S2RrgMvvQ9XCmvBNVBGmXEQ7f987dL36ptlM9Za6/
         55CXkW0/YRgoOKdbmZrNzMo752cUJ2c4hXuz1xk1ckUq9oJ523B8AsQHL5ScsCxGOAnK
         Lbqj0jj5kMoHpmaSn6jEwjj6pElhAFSqROq04kEJDyPrj8fLKXkaH4Pg/y8YFDI3+5Lt
         HVPQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1MrmgQB5YcfgWQ5nNMaSqPo/+bksQg3c9yn8UZfmx3HVyIsS205zj7lZaZppVgDt2QIx1eWX0BjBzraPtaZH/@vger.kernel.org
X-Gm-Message-State: AFuF++lEgCMv+rOvJEpv+czbxYzDbY0wXMK2sqIXQ/jtMm34XD6eA4cu
	ZFMorZb4KDUjJ/e0P19oDnU87YBZW1lU/ByJL8urKp2yoYor3H0r27VeA3sfLMSwUy9OoFGIEOe
	NiVOfgqB7aw==
X-Received: from dlzz35.prod.google.com ([2002:a05:7022:4a3:b0:143:56d8:251])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380a:b0:398:d2a0:87ff
 with SMTP id 98e67ed59e1d1-39d7098094bmr3884030a91.1.1788986491408; Wed, 09
 Sep 2026 13:41:31 -0700 (PDT)
Date: Wed,  9 Sep 2026 13:41:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909204122.1993010-1-irogers@google.com>
Subject: [PATCH v2 0/4] tools build: Fixes for libbfd -lzstd dependency
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Tomas Glozar <tglozar@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Leo Yan <leo.yan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is a fuller set of patches from v1 addressing build problems
linking with libbfd when zstd is a dependency. The original issue was
exposed on Fedora with perf's build-test. This series separates the
build from the perf changes and adds in bpftool and objtool fixes
caught by Sashiko. The changes follow the pattern used by the zlib -lz
dependency and so appear correct but are untested.

v1: https://lore.kernel.org/linux-perf-users/20260909181030.1870496-1-irogers@google.com/

Ian Rogers (4):
  tools build: Add explicitly sequenced -lzstd to libbfd feature
    fallback
  perf build: Add explicitly sequenced -lzstd to libbfd feature fallback
  bpftool: Add explicitly sequenced -lzstd to libbfd feature fallback
  objtool: Add explicitly sequenced -lzstd to libopcodes fallback

 tools/bpf/bpftool/Makefile   |  4 ++++
 tools/build/Makefile.feature |  3 ++-
 tools/build/feature/Makefile | 12 +++++++++---
 tools/objtool/Makefile       |  3 ++-
 tools/perf/Makefile.config   |  3 +++
 5 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.55.0.1003.g10538fe699-goog

