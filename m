Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B52877DE
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557360; cv=none; b=iktAznTi5eUsPjNLnHsVhAEaaSbfaxDks2MhfMoqFmBNwtTP8ewsyL8c7N+dHsVZz8DIjk0VEw2AgYiRoazYHl54EzUBJdfRW4XCSgpvflKwu+7OUR9r2Fe1jP6zq+euHgVhdXQhP70Wpy+Xx5zl7XOyC4wtoVWxOQMrCxwyTUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557360; c=relaxed/simple;
	bh=0HGVRBoBA+cAb5XHvSazxK+ojIOUqwhndVb/HVGZFaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxSQHB7nMp49t1lY0KZd5R8549IfqrZ0VcvzEHGjKgkTaQUVDbnGOLhWZLWqY5zfFkdV3QB8SJV1GGBWKWK2+D3HUqk5CqY/heeN8oCobdW/uINxfqmj/R7eBj00nF+i4/4bpL/NDKMJs2EncCLh89GmZJBw8wUvwjwSOW3f+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6SnFbOG; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6SnFbOG"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso5078445e9.3
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Sep 2026 18:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557357; x=1791162157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PjDyytdPMTn3M/DYdmyBBAX6C8pTKorMCooRZjrTuVs=;
        b=D6SnFbOGUSxmkstJ89+FQ3/sxpNiiDNeCP4F0aEhRkvc5jCqxUROCheiWt9cba7luA
         MsHmf2IIrnOz03mllpym0i3ylk0xuAn+SaETrVXj1ae7xoc0JHSbaEkjdyN9OTG8qI5n
         mdFXNLsfRuu2bTfWnB4cSRmd54P9xJWnZ79HZfB/xm4yI/ZV41MeRu6QLdCJ1/dmlzr6
         AqaO3/2JuF5/sdw+L5VoaCkoD2xIn24RxszpfmfYCFwDgpgB9Vwo7hpa4urFMnSdDv9M
         jx0IQ/pPCWBZLYweNqglxgWc0b3cFcQpeXqRJxBMwmzn7LgLoY6S6WTjpLfUIzOmo5R5
         z9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557357; x=1791162157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjDyytdPMTn3M/DYdmyBBAX6C8pTKorMCooRZjrTuVs=;
        b=cVd/onLRbdenLQYlCYbpcM/Hqf13/p1ngZpPBV79ouMss1/3ycRdX+DhW3FCTRqQeY
         CiDPq1K/5R5zNFwvCJ6g5d1YmXt510ib/kirCrYHvJn5/tvbCZGyfBqqla3h2FqBpTov
         fF8yK1YyDj5zP5XMnipAKupdSX/qW+8BfJFqB6Dj1eS1fWqdMfX3lNxjMhGwnrSKSuRI
         pjdPMwaAd91l5sj2gBEMvT+oM4STB6WAGD9ML0S8y1MvnE5kBMSYIktq6hLCMG87O/D6
         V6DLj35K9UeH1MTXtRYDjoIfdkx7WaLbADPRrCgFyKfAyhoVbGTHw02hIIPVp4QJiSbd
         5/Yg==
X-Forwarded-Encrypted: i=1; AKwUvBxpHsrK1EpZ0uXil5shl1jIR5vfWiYkt1HsdqV9MNMya3hEURk7SgN1eLMHJdM4uQ50fNsq7Hj5pqdft17uT5fJ@vger.kernel.org
X-Gm-Message-State: AFuF++m/49v7y7A/tlh3XhDG90JTDBsPPs8oO3RbUFR3UgNqu1EE0Hgq
	ZDlii8lnE+SlNKx2EhI6t244PBBH/rkAfSaYYuTvsm8ixS8/QGvxuUOC
X-Gm-Gg: AYBFou1xJm/N3LbSytPcSDDu5GLizyQDaWns1BkLSXPZ5YEFbQ085deSQoBQgDikHWR
	as7P5kGmzrOUnRd1xDeUeVgv7QnICy8jjhGj6SlQtf6ggvGtDp4dc68QqzwJLb55lcgcElPzFo5
	riTbVtZuJgHq/9Nac7s6u3HKs+op5kfBc95N4J7jNK18cVwOaBr+w+fAcfmY9pWvQjXOu+0i2qj
	cZ9f9YmgbEKWgOIYS+2ifghoavmr3K36pOgVMelgGW86hL/EYB1ol5PhK+ARVFYU11lBfK1wLVW
	MARxdMtkFli3ucZxK97atQxUUcoZi9INBZQSu0l0bbKtnW5V5RR4jnd1re/x+6UAA0S7HmhkgR9
	9tIYVjTiAKNuBO9hQf4zpjMVGAgZGeTxUXT2MP/KfBygmM7+wSYrojoO2+VdNnw+pusZAYWPY0u
	pXbcSqNIjDRGdKtx9DK/0oZFwYZNOZk1Ip88/VODOETFL+21eIAicq9O5l/YJw5Z4bPVcfg44rS
	Uh73BLiMisE02V/Z5/m1GsylwrC/Cb3f2w8NAiFCq39fodMtaSBwQ5b3Z8HWEJV1XZUbypihC+7
	ZBVkWbYvKN8mAjbABfoDEPaXUnYNzYlcqbYtrbPt8QpEo/tnI/zL1x/u8yEWlA==
X-Received: by 2002:a05:600c:348a:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-49fe6705942mr195533945e9.30.1790557357518;
        Sun, 27 Sep 2026 18:02:37 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm144207825e9.5.2026.09.27.18.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:02:37 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] perf symbol: Speed up demangling of long Rust symbols
Date: Mon, 28 Sep 2026 02:02:22 +0100
Message-ID: <20260928010227.1903673-1-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dso__demangle_sym() demangles Rust v0 symbols itself instead of using
a helper like the other demanglers. When a demangled name doesn't fit
the buffer, it grows the buffer by a fixed 32 bytes and reformats the
whole name from scratch. The number of attempts grows with the name's
length, so the total work is quadratic. Rust programs with deeply
nested generics can have very long demangled names, and I noticed this
as real time spent in perf report on perf.data recorded from launching
Bevy and Typst.

Patch 3 is the actual optimisation, doubling the size of the buffer
instead.  Patch 5 moves the Rust-specific logic into its own function,
matching how the other demanglers are called.  I think the cleanup is
worthwhile but I understand it comes down to personal taste and the
patch can be skipped if maintainers would rather keep
dso__demangle_sym() as is.

I used an LLM to review my patches and find the issues with the
demangle tests and the unterminated buffer bug.

Testing:
- 'perf test' passes, including the demangle Java, OCaml and Rust
  suites (patch 3 adds a case for a symbol that exceeds the buffer
  limit).
- 'perf report' output is unchanged before and after this series on
  every Rust binary I tried it on.
- Built and tested on x86-64 with a 7.0 kernel.

The series is based on perf-tools-next, commit 0ae6fc78c5ce ("perf
timechart: Remove the unused use_old_power_events variable").

Michal Pluta (5):
  perf test demangle: Fail when demangling fails
  perf symbol: Don't return an unterminated Rust demangle buffer
  perf symbol: Grow the Rust demangle buffer geometrically
  perf symbol: Shrink the demangled Rust buffer to fit
  perf symbol: Move Rust demangling into its own function

 tools/perf/tests/demangle-java-test.c    |  1 +
 tools/perf/tests/demangle-rust-v0-test.c | 13 +++++
 tools/perf/util/symbol.c                 | 60 +++++++++++++++---------
 3 files changed, 52 insertions(+), 22 deletions(-)


base-commit: 0ae6fc78c5ce0dfd18d8712a50f0fd4602eff103
-- 
2.43.0

