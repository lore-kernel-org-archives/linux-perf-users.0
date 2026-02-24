Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1013A0B21
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943399; cv=none; b=CIbZ81rK52+79lEOoCtZxJsEmzNFCaRmexruDS8nvJ7Bn1vQpSyMyanjx6Q65S570s4+AznRZBDTLqyss5Ru27/OrSdmPNpA8Xo1Eks3KUBfUTTAfWXLTWguh8mLWwU8peaZvdhQuBSm2QCxHlf8+ORwyk1D50EpqUeO2+WRnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943399; c=relaxed/simple;
	bh=xx5fsw89/QByPMFgYJOkVtu4aTQQD2MRLUD3f/OCMPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ichgBOFNy1R44p8OrhR5l9lyS4Dc269MSL0YK242ZQOTdNr8ExUcxMj/fy4aKNDeaCLxKCxb1dn50PSDgx7ikTPl2xGiZqQAcrvEkVztN+lN2U92Xea29fcGWHhc9pVNbtc5v1hZj27RTqK0VVbDm8jN+ng3QdhVuARlK8zlWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8NqQVut; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8NqQVut"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12721cd1a2aso27834377c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 06:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771943397; x=1772548197; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SF/9HIjbc6rTAg6numLxHr5OltI8HDgFivsZ6NrsbUM=;
        b=D8NqQVut3bxykiI5q6sQkLJOTnxySusMQZtdN3IHMlLiI3fqxqeIy8ii9xFWSbiGl6
         y9v4/54TpRm8zuLbewH6zgAeZI6HG6Jggsm0uX8+vMQ+KD8LQVzB/j3pTvtmT51UisCi
         6XIJO0pNQCGF1Wa23oloANPJ90lcMoRod32rctmJ8pn8hsuhaYQiyIzJrtrhB+xnqH3A
         gHKi+RZ8yPh56SsFx+zH70lOt81zQKptsZjUl/XhSfeDQ8ZWRSqYfu63YwNPQoZvfjrW
         sVyMbKVKIXhPS6iT7rJQCtEsOTJMofPp5a04kIsMIdjVEoZsN22sDIv3B4QWpaQ1/bvx
         iDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771943397; x=1772548197;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SF/9HIjbc6rTAg6numLxHr5OltI8HDgFivsZ6NrsbUM=;
        b=Dz5NgPt4GqRPJmkEHXUxiCuuWLoFG7DCyvUd94rSTgNQHlxDaL2dPadKMLHVO3ok5t
         aA/rJLR6gF52x+YXSZKEDm/EApLhHDjY1+JsYwR2FZibaDAh8OXxiky9NuOKkzp/SRNL
         a8/4uLLmZn4Bs4mdbYRj4x4N5zaFy3MjNOYdXSgy4DS+SNCWWJIsopr+unIYzRgKERu7
         J7zvxqBVTA4X7Be2r5a8EjH7v8Nh/wF2Y3j+n5RfaY6jc0rMhpRfROVp4f1JiIO64huU
         IeZxhiuWT8u/wWxipjZ8mnJrpbskqWl8F3+SYKaC8mYh31bPUogFi4YQ1yMK0vJYPY2c
         6fGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+ORiHi/lZsAxP+L/yt/AHkFL5+mrYsgurohsgJtB761wcDT8Jl+ZkZVumx5bRB0pZHJgDZ8NKUFn6SAkLdkYR@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8rcQrxYChTZYjPjGi8rm4o+LpEmoU/5RsG9XHAGaHvMKp5X0
	cTL4VIw0AysFHGbGwq6VmTUgiHPxd25nZMvI0NcPpRPHdJxQv1IUz/JqwNQCqBlJt6bo1LnGE0M
	ohU2nsb0uXw==
X-Received: from dybgx25.prod.google.com ([2002:a05:7301:2419:b0:2ba:7b4a:c331])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6428:b0:2ba:6458:b325
 with SMTP id 5a478bee46e88-2bd7bd0974cmr5588226eec.23.1771943396789; Tue, 24
 Feb 2026 06:29:56 -0800 (PST)
Date: Tue, 24 Feb 2026 06:29:33 -0800
In-Reply-To: <20260224142938.26088-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260224142938.26088-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260224142938.26088-4-irogers@google.com>
Subject: [RFC PATCH v1 3/7] perf build loongarch: Remove reference to missing file
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Blake Jones <blakejones@google.com>, Tomas Glozar <tglozar@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Shimin Guo <shimin.guo@skydio.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Thomas Richter <tmricht@linux.ibm.com>, 
	libunwind-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

The file was removed in commit e62fae9d9e85 ("perf unwind-libdw: Fix a
cross-arch unwinding bug") but the Build file not updated.

Fixes: commit e62fae9d9e85 ("perf unwind-libdw: Fix a cross-arch unwinding bug")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/loongarch/util/Build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index 3ad73d0289f3..8d91e78d31c9 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,4 +1,3 @@
 perf-util-y += header.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
-perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
-- 
2.53.0.371.g1d285c8824-goog

