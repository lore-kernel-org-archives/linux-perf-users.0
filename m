Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F84275AF2
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776796; cv=none; b=h+NxucOy5AoJQsIc82DMulaBOhAB0TKhYUQ6RMJXTcuGRPTnvGGfdh4AhahIbF7Wg8zlqaYVunChYFUOSehwFqN8xStx1eRrECBqfuoG04yJZTJFUM4iTfzPcj1i4OE9eG1G3AwiwJnxC22kzCmyssuqhk4zA9fNO0XwPZRSfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776796; c=relaxed/simple;
	bh=ITt4zRZg9IR1k9jx1o0n2GJmxcmqNAOjXa4NYAkkW/g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=W0HbfI9gQok/YqIx7zjwnTDDjpFAo7SMijJNqtTR7ZfDQzp54mUt5UBgaJ6poF2Fh2Yh0JFxm5AFjtUYjTdGUPYxpS9R3RPUBHzKjrnPbMd3tfpxWRjpP3aMOwQi4+MD9G5n7nquSZfbzu0WpIypzDV8cGkEvmrL19v741Q1vjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEInnB2j; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEInnB2j"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2403c86ff97so20310785ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753776795; x=1754381595; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wUMFq1wPKC/c4Wk+DwUN8ZuZ12Mj3tTGq8HNHYgHImA=;
        b=NEInnB2j4nildYgtZsJaeV9+bcbZ2CJaYUEOiHkP9vLgNEh1ZrsiI1cFmDc+sDA0Yi
         hmYYjG90BHWrE3QEOUQ1b7y7Z96Y8L/0Eux2dxI47cicH9CEk52OQSDdF3BsTANG4WQA
         cvLlRodH1U2dEBWRgK1kqz18S7LBiwkNLk300ZthUFEkiQrXbtydIIa89JttqX0znTHk
         LAJBdOFstl0IvZp/lwPdsyNvRXqjXV5Ba8kE6Y9mHCaN9LeBk5p+rwAu4Q65VPtQ97m/
         HqkPVQXW8i+l6SsiKnTZYq7WkbuIYAZwTRL/fqNuYZ4zDZyuE1PpaJUqNFFosacqkkbh
         1zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753776795; x=1754381595;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUMFq1wPKC/c4Wk+DwUN8ZuZ12Mj3tTGq8HNHYgHImA=;
        b=OvnzSoAzilplH+JvnAlUUL3yYEWkc5Qg1HQgD0ZJRi+D1CS/s27+EozdPDRPwCp+6a
         KrE6mxb2njoRurUpqXzJLp1c+IGUC6u7/a/SLUjZQfQUFbIL6cOkXiNG/DTxUnHBHLTR
         WxXwV97e/aSq0q3uUblp2i4cnL2fRzZUF7T9IGKVR4We8XutjFKsHmV2WbVs/lkN8Dek
         cIgwzOPNJ/IMTBDZRKcF+pg5in5xkFiQa+E2pkKldSndBQ3NAho7ZrO9icaLc0fwkyi4
         uU/m+rynqdRSEmNQygQVSkVyk1HoSN/izrZTxJMBggVhjWH4UjfJpny7+UQ3MSuwiL6d
         30uw==
X-Forwarded-Encrypted: i=1; AJvYcCWJS3hQBzokMCTBvalzqYjoVbGy3E6GR8GIq89Tmacamq+EYLX/2lWLu8e6RZ/qxR4pKfz2Hwcg1eaq1kv/AvAv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1oDSyx31s6Q7ONUz8h9jee3ph6d2pIkXokmav99vWIu1eObYQ
	xOkcW0Js/wfKfHQWq5mXyFNTaATjxT2nFNIHfYcAD/lXREyWz8MhZZKCIzQen/J5sWt87HU+C6Q
	jETENEg==
X-Google-Smtp-Source: AGHT+IH2FBcENjqFcvbmmWBOGmaCHiMG9XtA360Jm7sdXYiLYxjwC52n8n6Sc9K/m5hpE1sc0zxCwEOoNwI=
X-Received: from plgc18.prod.google.com ([2002:a17:902:d492:b0:240:770f:72cb])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c7:b0:240:4683:90a7
 with SMTP id d9443c01a7336-24046839be0mr58409105ad.20.1753776794561; Tue, 29
 Jul 2025 01:13:14 -0700 (PDT)
Date: Tue, 29 Jul 2025 01:12:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729081256.3433892-1-yuzhuo@google.com>
Subject: [PATCH v1 0/3] perf bench: Add ticket spinlock benchmark
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yuzhuo Jing <yzj@umich.edu>, Yuzhuo Jing <yuzhuo@google.com>, 
	Guo Ren <guoren@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series adds benchmark for the kernel's ticket spinlock
implementation.

This series depends on a preceding patch series that introduces the
'perf bench sync' benchmark infrastructure.
Link: https://lore.kernel.org/lkml/20250729022640.3134066-1-yuzhuo@google.com/

In a quick test, on a 48C 96T x86 VM, ticket spinlock performs better on
2-6 threads, and qspinlock performs better on 1 thread or >=8 threads.

$ # set 't' variable, and then
$ ./perf bench sync qspinlock -t$t; sleep 1; ./perf bench sync ticket -t$t

'sync/qspinlock' benchmarks:
Lock-unlock latency of 1 threads: 8.5779 ns.
Lock-unlock latency of 2 threads: 187.1022 ns.
...
Lock-unlock latency of 6 threads: 1202.8312 ns.
...
Lock-unlock latency of 8 threads: 1541.566 ns.
Lock-unlock latency of 96 threads: 44140.8765 ns.

'sync/ticket' benchmarks:
Lock-unlock latency of 1 threads: 12.1888 ns.
Lock-unlock latency of 2 threads: 168.1132 ns.
...
Lock-unlock latency of 6 threads: 1033.2760 ns.
....
Lock-unlock latency of 8 threads: 1667.1647 ns.
Lock-unlock latency of 96 threads: 66915.8949 ns.

Yuzhuo Jing (3):
  tools: Import atomic_fetch_{and,add,sub}
  perf bench: Import ticket_spinlock from kerne
  perf bench: Add 'bench sync ticket' subcommand

 tools/arch/x86/include/asm/atomic.h        |  17 ++++
 tools/arch/x86/include/asm/cmpxchg.h       |  11 +++
 tools/include/asm-generic/atomic-gcc.h     |  51 ++++++++++
 tools/perf/bench/bench.h                   |   1 +
 tools/perf/bench/include/ticket_spinlock.h | 107 +++++++++++++++++++++
 tools/perf/bench/sync.c                    |  17 ++++
 tools/perf/builtin-bench.c                 |   1 +
 tools/perf/check-headers.sh                |   3 +
 8 files changed, 208 insertions(+)
 create mode 100644 tools/perf/bench/include/ticket_spinlock.h

-- 
2.50.1.487.gc89ff58d15-goog

