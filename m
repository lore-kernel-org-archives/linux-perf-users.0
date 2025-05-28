Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343C1E832E
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402812; cv=none; b=OsermkvVVUwZPREroxsP4LIL2y44adlaOEqQiY4CyDuLrrbPaf8y/rhid1xAARO7RbpdAgR3QIm0qGKp1mezZ2ZolLacEw9V6FU8xSD4zJMVdczUQgsDd7S7+yCRlQBhZpsAwzScrA24CkchiLZBRLQEMSvFjF8dQuEAaxP7Hh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402812; c=relaxed/simple;
	bh=i8h7n5g7Yx2jMb7iS2ljtS04TytCEx4tl3E+OmLZXeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=r9MJXHkQ+BvN0/TOpi0sOfv2xjDYuLZr4Hb6ympjVsxcm6w6VF+jO19r15cbdyrm41mWOczP1hgaGeVmVLu2bKaaO1ip7Gg60krK2NFZixINBKp4CLX/K8UOriHy5KWgzSJjIv5gOdHQSpVowLh/JHy8GWtIh9PP8L96Bn6np3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MnQMpx0W; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnQMpx0W"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a29af28d1so2968377a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402810; x=1749007610; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zff0XHnUhlPO/m8VZhhkpC6s4Vm+rG87FvJ9ag7e9mc=;
        b=MnQMpx0Wkc1eM2dvpJug20o/44HENBxI6eOIyVk5NDURbIDlfJEXlF62dyTOfrWx7B
         /3aPvIPhSlBrjT3GJDAyRewq0Od14bnhm633WHwstKhml5+pdsGo1+S2jUcp9JBSpSHl
         GK87A7e6Ccd962xsGVcazyxnI/hhmswDPo7sL7EXNGr3GFIV/rlFYkSBZTzVnS62/TGd
         L6Fa1ZTv5EvhSEKMSqBZrieMPU7RToMuL1YBNuXmi3y/3MJHEaFhwZn6oEup5cwgKE9L
         1QGv/BJfXm4go54zMMA+AhP8urwFO2PLD45qu/ZDBJlxlTKB+zn7cYS5xGGP+dhWVI9k
         bxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402810; x=1749007610;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zff0XHnUhlPO/m8VZhhkpC6s4Vm+rG87FvJ9ag7e9mc=;
        b=UQ97ANOJiDQFEE78TublhbPlqQV7liyJ/Q7BCiO4uWoNYaOPR13K0Id1OuA+cMh6jQ
         ChsuPoT+BDOFKI7U2pGDEKgM69ymBIGDnc32wi7X+91/XFE40zfTld2yZPqctr4B0MgP
         6W6a8PgTYWjt5y1PeJ4sfIwtrK3FLFBPz3T1x2QgqI9LZE/U5a6izmGUS+FmpmWka/GL
         q7jFO8OlEbbIqFhC/Rw8ino/FFNjcllVDOepey+XeLkMq8p+p26WIMlUUjp7ZoVEfbzh
         KH18QkdBb+YoIZCA2/ODNl9BOcU69kctrl9eJdtOouH//+MWNjPnbtfKkhDMck0SHoUM
         hLmw==
X-Forwarded-Encrypted: i=1; AJvYcCUVktuNcwT7JduqTxDkGgvVu/2qvhOoFuDKqFGOxCMWrG8exx/VBXo6ReWV0II09M30QRubjIxfM+ioP8WBTww1@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHsrgWvIW95XqAfD+T5iLJM0gfOCry0eJNiOGino/ArjVNpTl
	pgCGx3K1iRG1F3kaq6546fku9u3pXUmfTYL2UOrRx3vlwhaXZ3myLMSyuzJoLkYdUYpv0ZcQ2AE
	A0DlcaF25Ew==
X-Google-Smtp-Source: AGHT+IHKJ/0qDXr34QCYKZBYCJAvA33TCQrzWCgJUlHJZjfno5vd2Mk/7+DxoSgW8MSUvTLSWTwhIR8Qf/no
X-Received: from pjbse6.prod.google.com ([2002:a17:90b:5186:b0:311:676a:af17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c0a:b0:2f8:b2c:5ef3
 with SMTP id 98e67ed59e1d1-3110f20cc93mr27240188a91.14.1748402810537; Tue, 27
 May 2025 20:26:50 -0700 (PDT)
Date: Tue, 27 May 2025 20:26:35 -0700
In-Reply-To: <20250528032637.198960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250528032637.198960-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250528032637.198960-6-irogers@google.com>
Subject: [PATCH v2 5/7] perf test intel-pt: Skip jitdump test if no libelf
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

jitdump support is only present if building with libelf. Skip the
intel-pt jitdump test if perf isn't compiled with libelf support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index f3a9a040bacc..32a9b8dcb200 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -288,6 +288,11 @@ test_jitdump()
 	jitdump_incl_dir="${script_dir}/../../util"
 	jitdump_h="${jitdump_incl_dir}/jitdump.h"
 
+        if ! perf check feature -q libelf ; then
+		echo "SKIP: libelf is needed for jitdump"
+		return 2
+	fi
+
 	if [ ! -e "${jitdump_h}" ] ; then
 		echo "SKIP: Include file jitdump.h not found"
 		return 2
-- 
2.49.0.1238.gf8c92423fb-goog

