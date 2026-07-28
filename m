Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2B46F4B8
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271346; cv=none; b=tMyLcDEXhxJJEQVdrDGURDRDSjcx/9SKH8mYki7Qu+HwXxiQB4nuFtzoWiSkXKM8HKllb5dyJmBOS2P+QPnEK+G4N9bRJpJ6byfVziZyfai9/HlQ/qJBItW/u6wPAuvw8zMGQ+Kupypp1ATEIi2boNxQU4NeKWnxFy5TEGM5WcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271346; c=relaxed/simple;
	bh=NpnvIBWJtn/hx8oYDSPvjVssq6Qf4WShy0aZ0VH9GhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VvzB7EW2F/tZoKhuzWYwW1jmyKNSVWEuUAsmDIJGnAdyj3P89xPsvEw49TscBxJ3+IXRYIRZlmC1B2xy9UTctkOXivtk8JGRS+EEOuVWNravK5DDplaSbm+ZKxF7aogAzrlvLvXUSWythnXObyPtuQc0HwXvykU3/XfA0Ozak5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PHZXA77e; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PHZXA77e"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4955158f26aso1620305e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785271342; x=1785876142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2u1fPdLhr3mhAkJXm1RLbEzU6hTL9AhyYevvscNJEx8=;
        b=PHZXA77eTu9ota5b8i/71vYqNFK8NDhCgJJitc+FvUcJhZG+ZJ5AWJIG0Frutti60P
         6t+N3NSXHEoOLts1VxUUzthrjKrC4seDD1RA4+zapdR+oiu6WLdAZwrXEMAoktC3tYq7
         hvfJUcC0Egv7udySwjP36pNyfdV+Qo4XpV67EEzWM1uTwyLp4VFxjRMGclKyTbKE9xb/
         FQ070U7AIMpF0jbP2C9uK73uSszMTGsnU67NuT0cZJqz4MDVTaaqjKK9PncHbr+WAMWn
         OyuJX5wZnSE5JeFMNnNMN5Dw4OqtF0X/bvtCXO0wga8mQufFD2/TVfq+7ezzX523we6I
         fm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785271342; x=1785876142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2u1fPdLhr3mhAkJXm1RLbEzU6hTL9AhyYevvscNJEx8=;
        b=nzuY/SzPRaia9/dXyeDguDVLqLrobm9kkABYXK0/51K6G7P1Lv00ujeH9aA9OVNKgx
         IUe39InuKXHRbDuqN9mJshmHac/TN7uM+V89DT6ahODE0zmehiJbITzb3w7By9KJa8tT
         ngEdiaX/OjLkZmd8t51ctH2EdZ/+RlkxXvBG7fLlGQAPAZ71MIYHqrlFefSiBHZMYdwN
         Ni/f6RYII9OdEeRzdnmHV3ySeVCBYmE53DsBqaQ7XZYfCg7KkSAM/iAtLadUmPJPqMis
         592l9JD3SljYwQmBGyL2INnDzpjUDdbtwtFxh1BK/UMzU+G+yhioRTfeO7anoj5Q3TEz
         v83Q==
X-Forwarded-Encrypted: i=1; AHgh+RrjB68uVGZi24ei7WaAykmS656muh5sS4k712WGs7bYFxgzqgNO2DKBaJh9VUdUTvTH51H2yqqVozsbCzpeOFLp@vger.kernel.org
X-Gm-Message-State: AOJu0YwHCrSDU2YQR0iBbvMeEVbd1SNNe7XEnkLwfOGloUNJ/n6p+jm6
	MZXu9mva9Jo6RCseGD7VrSawktxYQAm3rPJMsjhtLlqQsNtcuMhyzWyjuOT5k2Z/YSk=
X-Gm-Gg: AR+sD11bnKOIm7jVcT3xLUgEYPOAbAcwFDki4OGnJq1SKiU4t+QtdZg+V51Q/VEtkAk
	5Scwc0DpSCC5wd/5Ee9kw5YlPq6208ZQl0jWt4I+7UgJW+vGg9k4KwhOuh4hxNUp05ogiCXeTmJ
	NP5XqAsZ0/IhpQbpEvyrfaBRhzLouJ6eqQVRLo7s7b9NdvftYHwINWuafwrU1EvdSWapS32ygke
	EiyXTeM0Q2wxvbaAXO6lVGWHaKbkHJ3MzNNUb+4lMyKR56K+qrx4wCZ/gLGVXzZKIa7f0NJWCqX
	erm6wgbXa0c46DtHsDtD7/QLfCAuEvFkmo2hwuqQ26CgVXxaN9k6tGVc6nIK8HszOYPlKCoTWp9
	FveL0Ce2xvCz35dAkCY+XZL66QTW2HIDfr7TzMh8MT7MyZ5jOXBJXToib3iMFJ5aMEYvESJW37B
	7YPgsN6mJHazWGkWNBZclFQw406ihI4KQnhxWkMd7vUBw1pwrEHIyiU/Gl/SeX6Ku6NIU2CJn9s
	uggl2yW0+CMbZI=
X-Received: by 2002:a05:600c:4e52:b0:496:df96:ea8 with SMTP id 5b1f17b1804b1-496df9611bamr8187405e9.17.1785271341963;
        Tue, 28 Jul 2026 13:42:21 -0700 (PDT)
Received: from dev-mliang.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfc2ff2sm293304475e9.4.2026.07.28.13.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:42:21 -0700 (PDT)
From: Michael Liang <mliang@purestorage.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Liang <mliang@purestorage.com>
Subject: [PATCH 0/1] perf libdw: fix outer-frame name and spurious "(inlined)" tag
Date: Tue, 28 Jul 2026 14:42:14 -0600
Message-Id: <20260728204215.327318-1-mliang@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf is built with libdw support, addr2line uses libdw and
cu_walk_functions_at() walks the containing DW_TAG_subprogram DIE
plus every DW_TAG_inlined_subroutine DIE at the sample address. The
libdw_a2l_cb() callback treated the outer subprogram DIE the same
way as inlined subroutines, causing two bugs on the outer frame:

  1. C++ frames lost their namespace/class qualification, because
     die_name() returns the unqualified DW_AT_name -- so
     ns::Class::method rendered as method.

  2. Any DWARF-vs-ELF name mismatch on the outer frame tripped
     new_inline_sym()'s fallback path, which fabricates a fake
     symbol tagged "(inlined)". This hit C++ (die_name()'s
     unqualified string never matched the demangled ELF symbol)
     *and* it hit C functions renamed by GCC IPA-clone (foo vs
     foo.isra.0 / .constprop / .part / .cold), since
     DW_AT_linkage_name doesn't reflect those renames either.

The patch does two things:

  * Prefer die_get_linkage_name() (mangled, fully qualified),
    falling back to die_name() when absent (C, extern "C").
    new_inline_sym() already demangles via dso__demangle_sym().

  * For the outer DW_TAG_subprogram DIE, use base_sym directly --
    the DIE tag already tells us it is the outer function, so we
    skip the name comparison entirely for both C++ qualification
    and IPA-clone renames.

Testing
=======

Reproduced with a small C++ program that exercises both a
non-inline namespaced class method (which GCC also IPA-SRA-clones
into a .isra.0 symbol) and an always_inline helper:

    namespace demo {
    static volatile std::uint64_t sink;

    class Worker {
    public:
        __attribute__((noinline))
        void run_one_io_task(std::uint64_t seed) {
            std::uint64_t x = seed;
            for (int i = 0; i < 400000; ++i)
                x = x * 2862933555777941757ULL + 3037000493ULL;
            sink = x;
        }

        __attribute__((always_inline))
        inline void spin(std::uint64_t seed) {
            std::uint64_t x = seed;
            for (int i = 0; i < 300000; ++i)
                x = x * 3935559000370003845ULL + 2691343689449507681ULL;
            sink = x;
        }
    };
    } // namespace demo

    int main() {
        demo::Worker w;
        for (int i = 0; i < 400; ++i) {
            w.run_one_io_task(i);
            w.spin(i ^ 0xa5a5a5a5a5a5a5a5ULL);
        }
    }

Build:
    g++ -O2 -g -fno-omit-frame-pointer demo.cpp -o demo

Then:
    perf record -g -F 999 -- ./demo
    perf script | head

On unpatched perf, every C++ frame comes out unqualified and tagged
"(inlined)" -- including the outer IPA-cloned frame:

    run_one_io_task+0x24  (inlined)     [WRONG: unqualified, not inlined]
    spin+0x40             (inlined)     [WRONG: unqualified]

With this patch:

    demo::Worker::run_one_io_task(unsigned long) [clone .isra.0]+0x24
    demo::Worker::spin(unsigned long)+0x40  (inlined)   [true inline]

The outer frame is fully qualified and no longer carries a spurious
"(inlined)" tag; the truly-inlined helper stays correctly tagged.
The same mis-tagging behavior is reproducible in pure C by taking
any function GCC IPA-clones (e.g. a static helper that gets .isra
/ .constprop applied) -- unpatched perf tags the outer frame
"(inlined)"; with the patch it renders as the base symbol.

Michael Liang (1):
  perf libdw: Fix outer-frame name resolution and spurious "(inlined)"
    tag

 tools/perf/util/libdw.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

--
2.34.1

