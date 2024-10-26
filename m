Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401055661
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Oct 2024 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729906995; cv=none; b=N8XHNbHxSrE4yhl0fPvb9JvU6Q1Gwzn3wl4/U7b/ActsjyE13yaQLReHkeYSq8DNP0/3JCqUTbQcJTu5eokthuQOFsrn3tvfU8JceLb31sAm8paoHbXxH1TSTUtwTIToCZi/bJ7H3yw8FNsckkt4ijCg1Vo/jkNJ/FzxYB/vm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729906995; c=relaxed/simple;
	bh=kaNuRtju45HeRlSVWLhtnnC7/03sbNNUitldMnHJZuU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=tjr+eWTBt2uAAr7+zBq/mz7a5xXcaquM7zc3AazuQvRB/lwb4iMkZqo7MVlCScdiSa/u1+wAygvjwr2h3CfzNEdSHd3MHUk4JQf8++qR9W9g3drw86a6SRbjkivgMOOArb9Ba1J47PBXjStq69cwUjBDI1NL4AmuNYR2eaxGHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2OqoXFDX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2OqoXFDX"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3497c8eb0so32820087b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 18:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729906991; x=1730511791; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ABCkax6iBr4pBLmb70Y7jnkGOHiVbYsTcs7q2+JUIpw=;
        b=2OqoXFDXevverhddh/vJlMPiieUOad+0cP35oLOClLeuTCBrHhMRU9hUesr+bBH3/O
         EPshfn28H+Om2c3TLBXauOU1MUfq9wBq5Xn1/FX7MbeXRT9B44mw1xridOl8c+JzFL7a
         DBX32rC6ChUyaaIW2YEMKjIJyQ/MWwnfQYrLIy1634xcKHAnnaqliv3FJrDYpepLm6Il
         oHHdXVegU8b+ivbFQ1vou6IaonlLYM8lQo4o3A48cFHCYpR4aCz5irtHCgJ7puYt9xIt
         rCiUqZe4jXkV+OkV8ZV0ylrODUvwz6oWGuhytgReUC/R0RqnmxJYTGeBQuF0KX5T23a2
         3dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729906991; x=1730511791;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABCkax6iBr4pBLmb70Y7jnkGOHiVbYsTcs7q2+JUIpw=;
        b=bEU0Pka2fGz2J77JqQw2d/RZOpjpzapEi62muwHp7+sk1v27LOJD6e0+5MLV/T9o2Q
         /eMpcrpOZlp+KfzON278ekOLVbxzlLoJYk75Ojs2PuirOXUl4H60/s03xxfP/ZMjlWuj
         hEpOpkzIOIa1rLalyuGTycItnpwlGI0oDjpc8h6Xy06OVTFqwA1X35MrRPWpBR/epJK4
         3FQ1MFD4AWZPXkDy+qRSP0Y7BL01BEpiQcP9Kzo67ootlAo4Ueifsfl+sohc65dCuSeu
         2RQxNoGfKL5rjHEdliw/JgDSj1mSIFzjOTiXQa+vPfGsG7MMYrN5utQUFncLGPfKf/p9
         5PfA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Ls/v7LGZ7Iuf4CozyVQtxz4jUrLgQ3LLnD4DrAzUFRiicUt29Hq4SxcBzLzSX6bY6vW8ZBEuTZh15giCDZPd@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0b3Syv+Nx7Pt95GbhyCmaEPKsAnuZrFukDvgCJWv2/rZmovL
	7hlj6kJAFp3pQrpE0hMOBwPOBIxfFsnqAlv6CIHS7QWsd+eQPq33jC6tHSMVSTeEwT1tgWeY6iv
	SyW4Jdg==
X-Google-Smtp-Source: AGHT+IFC/3+jcs19xorWhazJ28pT2ZwiS7jv9Z0M4w9hLSmjXpSVQtSWbTSfm4DDeXysKp74cIhI6koSA1gQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:82c:b0:620:32ea:e1d4 with SMTP id
 00721157ae682-6e9d870c0e4mr213647b3.0.1729906991231; Fri, 25 Oct 2024
 18:43:11 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:43:05 -0700
Message-Id: <20241026014305.233607-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1] perf build: Make libunwind opt-in rather than opt-out
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Having multiple unwinding libraries makes the perf code harder to
understand and we have unused/untested code paths.

Perf made BPF support an opt-out rather than opt-in feature. As libbpf
has a libelf dependency, elfutils that provides libelf will also
provide libdw. When libdw is present perf will use libdw unwinding
rather than libunwind unwinding even if libunwind support is compiled
in.

Rather than have libunwind built into perf and never used, explicitly
disable the support and make it opt-in.

Signed-off-by: Ian Rogers <irogers@google.com>
Closes: https://lore.kernel.org/linux-perf-users/CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com/
---
I think, once libunwind support has been disabled over multiple
releases we can look to remove the associated code. We should look to
do similar for libbfd and other support that is no longer really
tested.
---
 tools/perf/Makefile.config | 4 ++++
 tools/perf/Makefile.perf   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b93ed2b7623f..707d7355ff18 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -91,6 +91,10 @@ ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky riscv loon
   NO_LIBDW_DWARF_UNWIND := 1
 endif
 
+ifneq ($(LIBUNWIND),1)
+  NO_LIBUNWIND := 1
+endif
+
 ifeq ($(LIBUNWIND_LIBS),)
   NO_LIBUNWIND := 1
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b4dee7c20ed1..d74241a15131 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -52,7 +52,7 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBELF if you do not want libelf dependency (e.g. cross-builds)
 #
-# Define NO_LIBUNWIND if you do not want libunwind dependency for dwarf
+# Define LIBUNWIND if you do not want libunwind dependency for dwarf
 # backtrace post unwind.
 #
 # Define NO_BACKTRACE if you do not want stack backtrace debug feature
-- 
2.47.0.163.g1226f6d8fa-goog

