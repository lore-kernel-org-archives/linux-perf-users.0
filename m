Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DC281529
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369253; cv=none; b=G+XkMjV85UAvq9xyh0CVTDP1kR9ozX9TjKlHeAFKla5NcMmXGOk0MFnkKjuBijZ7KAu3mYpcwmUcbd72ovbh1Z7qtRd4ti77wmYHHComyzMD1OYUZFd6KJcZu+89A4gEj3c4RaNujBWUD7EmVwg1UC3xiO9h+02xvpYei8tfB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369253; c=relaxed/simple;
	bh=CBWXDqwmWst2ZqdY/0uSvasMfgfkKz/Uh3ju60ADh2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=i98/e/ByrOT7gBwn6P8U9NmrG8xXPEha2GVdzoPpsOaGPoM7SIvjehwOzHiUeC2Scf/Q6b2OsEtG9TrestJneX6KwgjzmbL+SlIdhXeN84WWW+Qxbg9BNb6F10keieEZRgpqyWLCJTWo803E1asopfpB4Cz7Au/XVnKaYUX3WKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zL0jlFJX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zL0jlFJX"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2323bd7f873so36157465ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748369251; x=1748974051; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MX8V9w5FVeExaYuyetA8waEgh5LNED363u7Lxm8ca88=;
        b=zL0jlFJXGyxlsUD21aqW0bFet2sLNYLeKMK1o4Ro8srPJOIgc4bW4qZXvdryrk4iKP
         B6ras8VwRLUKNQM6yBNgHclzhv99bF6PEjiL4ZSNye6yK4g54jjITLEnf9qkfUr68BwE
         zR1v1zedIpqR4OlQ3hzlWF91OCLFwf1cevvV+TEgTynRrIM/M4nFirUR9lW0tSueze4s
         1UjKRrhM5JvQ8LMM+jOAv2U1+Jo/ctj1BoZJauFehmBtyiImppp/PYB/oZfin6ZDTFeS
         v29YPd0glAJM4xMWMT7EJTYcAIR0mkuI+Ax6+xyOHmvXTF09cxss1D2zoVKUGyl86j9q
         aOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748369251; x=1748974051;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MX8V9w5FVeExaYuyetA8waEgh5LNED363u7Lxm8ca88=;
        b=TZNzWqvLmOva5FBKvB3jPWAM4AdPtB5VipCwubyx7n/sRdmUzt1UFZGiXZa7fmo3Cm
         arj4gN1GzuIMtSA09omxUGxqg6UiilyaqeraG4Cfyd0Xkl1moUJN2zwVHM2nVvcJEvMi
         UX6bcw3fJG7o+uo+obsTbXjUVypWBUIsuun6BrtLLEa9bWeT4r4N9LTAjkQA0a352rXq
         e1tH6y3Yik0VEaP/GFamya/uO6CQQkgmBb9IZJb6gmTxkUJS8KkcQ5VTiC3JsxZSTqcs
         8KAedjjPB8Zo5oZYqn+d9Kgb/gSONh/Ra8tWKsiwg4dXNGRjpxIr4bq3X9mcI/Zi+6g2
         tHrg==
X-Forwarded-Encrypted: i=1; AJvYcCXu1oPQ6qHCA+p6Dxp1dM266D2AvDcvrE0fiYxDcZ6tp52YPfOD6yr6ezWwZb3u+b8CiyxZ+NNsyNvMKEMxKT9j@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1dMIWBNriUgbRMLOvi0udLH1/FyNkDbD871cIHbwWpmb9/vm
	hUEx8RsYzqNUEkj2h9iS9HmyIjP3/QKyVJbsbk7gy5czkIjEvWHsTRRicD19A8E6T8dTCteShAU
	nYGTilXrjYg==
X-Google-Smtp-Source: AGHT+IGNqZt8gE2AinHrs5u59vtVCFuseQxQglwLlKwXoQLPdUfefW6JEtTDFuscAHg/KyKTb9DfJ3w8oY6h
X-Received: from plll21.prod.google.com ([2002:a17:902:d055:b0:234:949d:4a5c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c8:b0:234:a063:e2ac
 with SMTP id d9443c01a7336-234a063e540mr48300615ad.2.1748369250955; Tue, 27
 May 2025 11:07:30 -0700 (PDT)
Date: Tue, 27 May 2025 11:07:02 -0700
In-Reply-To: <20250527180703.129336-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527180703.129336-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250527180703.129336-6-irogers@google.com>
Subject: [PATCH v1 5/6] perf test intel-pt: Skip jitdump test if no libelf
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
2.49.0.1204.g71687c7c1d-goog

