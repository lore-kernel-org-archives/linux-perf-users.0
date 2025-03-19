Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EBA2528F7
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360898; cv=none; b=kTsLHy63vDITBl89g0D6XrimmUG2K4J+SWPYr3hyFr+4uABSfN+2qaLbIRnAqNXPGeadrQpB2cBfOVNBgT5QY4c0KHZWshXHT/8nxd1zvArvME4QHJ/RKx34EQyBjGXjmuJy9ZxEQR+kAq5xUKh1eKPtgFKy58wJe3eE1dynewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360898; c=relaxed/simple;
	bh=tSOlzIg1yXOwUyw6zWCMnGwqLZhjjUkDbEkMOcp7FiY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dS9pwMtdbNatOAKdzSFsFsuCDQ41/CXdb+GZxcUQdWFFVgo7FE/TFvFg3+f3WJ/wFx+RAsL2T6kucikIERuxK9ZCPD/zgNY0NYu9zLurB02uaj6zR66zT1/GuVYxY51R5FUTVcNLmxkyglS1tlbD6+yMTjklAwjvJFkF29JF+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s714uWxu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s714uWxu"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fef9aaefb9so69282587b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 22:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742360896; x=1742965696; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y38GESo485gGDIFJ1xMbGn6kWCzBk3/syJLY+zfYrVg=;
        b=s714uWxuhF3pTlhV44GX3YgG/HhG8jtQv+CQJQokWHeM++q0E5estCCtU2madufD53
         SZMwWHm0DRiARV3I1U556Y3TLAiHwfB3Rs4fAg83bIuwhOnBjYIUbX8MkDM2FIomdT5R
         63kFygiCzpda8COv65Lf3dTw515mN6wJzMAnQ0M/ihvnaHtZBa70+iiT5Cfnlit+QS2y
         jcTqw+w8ZPkwhzWFJuF7VBGhTx4dA7NM+7dOWquoBqdApGiTM5mRSzsu9ZNyf3i91I5U
         nOOjQT6tGoMMcg+FuA+gq6Q+hdGti89OwRoOOU9OvcoCI3SwPFkMDSN1dYppy2Ijkm2Y
         /kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360896; x=1742965696;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y38GESo485gGDIFJ1xMbGn6kWCzBk3/syJLY+zfYrVg=;
        b=VTsFz0k+7hrhByR8UkR17R7gOO32PoAgCCN0PDzP8mFeYeC4XIp0jLYDBVIvGkMccD
         iBv8fB1w/1dpeV81uMf2Lr/tjxhXN2nwb1K7l/b8tMr/endhnAxNthuSjTwPhGhqcEna
         xsoYO5LSoQWXzwIFiYJfRtnMn6l9aka5dehrYmYDBPFQ8qPgRByszFO9u1lrw9ZNwXA9
         tfzWwHERUimJ2tejYDqbIxc9HGxgJ3aeEtrgVSUE+9nVxPNnsxwihGRnKEHIAugs9hFr
         i7FpCWCz90imqCbHvclKdxnN7GEjOP7Eob/W3cv4CtXZ3y58ldz42I/5YOuiNtkkX9/8
         /VgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOdemkYStKEnfhrMrQ/pIsoTBLP9PKpZeDIFPZ/M8YcJw6bu1rk53IOb+qqcNDUWvnm7z5Xj72TUXiXGqyjcPD@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBgK4TloO9XbiuZG8o5oH/CZYIisMZEWh23wLZrrhhb3rrKaB
	rhFhieHlurDrCo34bvlxBAJ0Q/vqRUw6tyayfX3Rh+t7WlFSvhbOs2lleNNntNVDsNp6QeXo+Qn
	mv1YrtA==
X-Google-Smtp-Source: AGHT+IFPFakwCyr0uM1/sz8X8s9dtQflbQjZm9fJ42RkwL6er5xIYEKy4XS6bbEhodJ8Ew/JRCn4+wa1XjLm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8a11:10b5:af90:6031])
 (user=irogers job=sendgmr) by 2002:a05:690c:d8e:b0:6fe:e77c:7741 with SMTP id
 00721157ae682-7009c211810mr6127b3.8.1742360896116; Tue, 18 Mar 2025 22:08:16
 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:07:40 -0700
In-Reply-To: <20250319050741.269828-1-irogers@google.com>
Message-Id: <20250319050741.269828-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319050741.269828-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v7 13/14] perf trace: Fix BTF memory leak
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Add missing btf__free in trace__exit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a5f31472980b..1d4ad5d19b10 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5339,6 +5339,10 @@ static void trace__exit(struct trace *trace)
 		zfree(&trace->syscalls.table);
 	}
 	zfree(&trace->perfconfig_events);
+#ifdef HAVE_LIBBPF_SUPPORT
+	btf__free(trace->btf);
+	trace->btf = NULL;
+#endif
 }
 
 #ifdef HAVE_BPF_SKEL
-- 
2.49.0.rc1.451.g8f38331e32-goog

