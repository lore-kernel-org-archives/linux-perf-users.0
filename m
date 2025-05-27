Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01933281529
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369255; cv=none; b=IZgo3wqP5lIU8NP5QIrj6/xrRZuWGE555wfQOBgRNt4LkEaRSg+71TOiz2osln6R8fBXGH+8lpdbfKal2mLmlwmpBBFxjxXz3fxhCFr2bXkXZa33ypwOtG1R68904E+HvMuYOltq45EoF6qW9d2N1UkhDWBLLY+C0z/Yt3YpwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369255; c=relaxed/simple;
	bh=tXkzECMzlUGyQjl7egm1CU1/fCbel46uwneu6zgwPzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WYRbI+ZwG9cKR096iXPjWGpvpumneFm0/DQNY29hLaMA0QEnsTqxXA2hrQOydKKVBU7CJq9kw2ZPNUzBuRr4H2OFKR58ztkCg1yz0hrt78BapIEP4Qjhwbu0yh6Cgv7H1+vIPurHvFOadEeRg+0n2oX0bwJK1fJgPfibqZbBjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQSOM2mI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQSOM2mI"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c3e576201so97984a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748369253; x=1748974053; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53MnQ+9b/xbDmubcmvXnyoPwpOHXHqAfzLcTz6K+YKE=;
        b=FQSOM2mIqH6aJIdKU6K/0MBXrnKW5Tzv8Epei/2gt3GbwJa+n5WlnFDDixuEbkPQi/
         SE1I4hEypayHvBagYE4C0h4Vd1yrk1davR02Ro9DmUknExouna7zxXgON99Lxn4fnker
         cTB2kRutpv1DSYiKMipUgUC2NrRbW2Z6lh7l2q3ptHzWCJAXL+7/2j50S+7FI0SW83jc
         pI7/6ZxdNv59mdsGhxhTQemN5zaTkH4njTDAYXeaX0Z3lzELXxRhnXSJbI6GRwl5/0sn
         rj7m4Y3Vj006ideM55vA/3eFyLMnVkJ7snJ/q7tCXUGH5NpjgV9OpVJPAWSQhcla3iyy
         waLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748369253; x=1748974053;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53MnQ+9b/xbDmubcmvXnyoPwpOHXHqAfzLcTz6K+YKE=;
        b=fpQ5I/6bIoTwpeWABmrWOlXJbg2oh3V+UQJ3kaPaj1foIKEYK8hVKUaBQePVoc/5jF
         hnTsFB/VkHyDa3+0ddOIrcCVN3th6P1e7vwIOOIx7dq4MAMlwtiEsKBNjPL6EJi0BwNY
         H7BE7Ip1gdzGisQuS8/olz+sPUa0Wagu5WWFjQPPSI1N+Pu/wA3KljoKfG+wezR49EjN
         /6QNLjIu6ATu/wYXUj0w1d+aZfNe8v2w5GaP3sQqn7QhkvouYHXdb0ssAjl5V+x6/xcb
         Xh4mDB1g9kAcYSL4cW5zTtYB8VIbguvmBeMUW8ZEO9whKB7sZ+1F/8GzBZ1Ww37dNH4d
         f/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVkVEtfWNFFdTy+Q9zYbNDsNLzLMNyfoZXISG/vBPvhN2YBsfvZhuFHBNy265PtK4WRUv27LN3FC0+9qFhqkxy/@vger.kernel.org
X-Gm-Message-State: AOJu0YxxFNdUUG/ajPSfv1j9EPyFeWTG0DQlaCMuQpuY71b2sHu9Z/rR
	MzSGcXQmEASr1vpG2kguz96duH3J9I+96dhPVCojcE/yOjysrjo8zKpNEujSZ8fdfG5bRC9zKIa
	kohybSG89Mw==
X-Google-Smtp-Source: AGHT+IEs/i83HeK/kXHhOK5DIrg4XPtLsBjqCQAU/a/iwZQOPo/OM37vvPcR33Fa5ijRrs50zf6/XS1uTSXu
X-Received: from pjbsy7.prod.google.com ([2002:a17:90b:2d07:b0:311:466c:6062])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3cc3:b0:311:abba:53b6
 with SMTP id 98e67ed59e1d1-311cce9432bmr2456854a91.14.1748369253276; Tue, 27
 May 2025 11:07:33 -0700 (PDT)
Date: Tue, 27 May 2025 11:07:03 -0700
In-Reply-To: <20250527180703.129336-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527180703.129336-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250527180703.129336-7-irogers@google.com>
Subject: [PATCH v1 6/6] perf test trace_summary: Skip --bpf-summary tests if
 no libbpf
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

If perf is built without libbpf (e.g. NO_LIBBPF=1) then the
--bpf-summary perf trace tests will fail. Skip the tests as this is
expected behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_summary.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index 49766524dc21..f9bb7f9388be 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -53,6 +53,12 @@ test_perf_trace "-as --summary-mode=thread --no-bpf-summary"
 # summary only for system wide - total summary mode
 test_perf_trace "-as --summary-mode=total --no-bpf-summary"
 
+if ! perf check feature -q bpf; then
+    echo "Skip --bpf-summary tests as perf built without libbpf"
+    rm -f ${OUTPUT}
+    exit 2
+fi
+
 # summary only for system wide - per-thread summary with BPF
 test_perf_trace "-as --summary-mode=thread --bpf-summary"
 
-- 
2.49.0.1204.g71687c7c1d-goog

