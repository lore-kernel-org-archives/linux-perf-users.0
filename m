Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781E18F2FB;
	Mon, 12 Aug 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491889; cv=none; b=cEXkakGyLnWK1VGX0H1WQEHWqK6aswl3uvi7G2NFB+lvgBoWhruxEYOInRtLKjoX5HBgB55MKxmgcmIjGLwVA28ezq+9K6YTmFOBm6ts/rU7rmuFoYGivQ8UKgE1mJRUBbyOxAt9x4fbf3Z8DYDuKffpxROX/QFILyTmSs1RhOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491889; c=relaxed/simple;
	bh=3GPgXkWJsT1OLVvTHGRN3WN1lyRR/m9IL5ggRpgDago=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s4wUrlqPRfM8kUceb3sZXefM35r99f46i/Qe9c2yzGGyxUsFbU8m9iu4cQb8VOJLTLrd/9Hjme2V4EsISpsbpgeGxyqxjmLUP87fmMJaKOtJs3zSz9fOD9qlcQzCtq1M0ELB928d5q5M88PWpYmHqlbC7zG2b8k7ETS8d9R/pyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdIPiRXZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdIPiRXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2339FC32782;
	Mon, 12 Aug 2024 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723491888;
	bh=3GPgXkWJsT1OLVvTHGRN3WN1lyRR/m9IL5ggRpgDago=;
	h=From:To:Cc:Subject:Date:From;
	b=LdIPiRXZsg6YSYpiqZbnGS1LHqeab0Ykp2okfZqxthxSnJa6uXr9pa0EQMM4QQrq2
	 62G3St5RTToG0mx0kzbfJRe3FVDsINIK9sMjVTp/9ZiWfn5ZNFbB2QOKhkjlr7zWcF
	 3VwlzrNId/EcfaKRSIOj5GY+UedcoZyo2tIcU7OAWirfZy8+t0WKe4RhI0nWeOPvNK
	 CFYca4ZsX7+So9unqmygH5tg8TlQ/n0Hs6Xj7ky5CtChVmUeKvZ8FWwhxZOvLj7QyO
	 Pv0aPcHMUQjF+iQmNej/tXreHDAW6yYDBigIlu0fd8j+zGkEIiSihqoHTCv/OzBB2k
	 Y96IPOBsXpQfw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf annotate-data: Implement folding in TUI browser
Date: Mon, 12 Aug 2024 12:44:44 -0700
Message-ID: <20240812194447.2049187-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I've implemented the folding logic to expand/collapse the current entry
in the TUI data type browser.  Users can use 'e' or 'E' to toggle the
entry (with or without children, respectively).

Ax example output looks like below.

  Annotate type: 'struct socket' (1 samples)
        Percent     Offset       Size  Field
  -      100.00          0        128  struct socket {                                  ◆
           0.00          0          4      socket_state   state;                        ▒
           0.00          4          2      short int      type;                         ▒
           0.00          8          8      long unsigned int      flags;                ▒
           0.00         16          8      struct file*   file;                         ▒
         100.00         24          8      struct sock*   sk;                           ▒
           0.00         32          8      struct proto_ops*      ops;                  ▒
  -        0.00         64         64      struct socket_wq       wq {                  ▒
  -        0.00         64         24          wait_queue_head_t  wait {                ▒
  +        0.00         64          4              spinlock_t     lock;                 ▒
  -        0.00         72         16              struct list_head       head {        ▒
           0.00         72          8                  struct list_head*  next;         ▒
           0.00         80          8                  struct list_head*  prev;         ▒
                                                   };                                   ▒
                                               };                                       ▒
           0.00         88          8          struct fasync_struct*      fasync_list;  ▒
           0.00         96          8          long unsigned int  flags;                ▒
  +        0.00        104         16          struct callback_head       rcu;          ▒
                                           };                                           ▒
                                       };                                               ▒

It hides the detail of spinlock_t and struct callback_head.

Thanks,
Namhyung


Namhyung Kim (3):
  perf annotate-data: Support folding in TUI browser
  perf annotate-data: Implement folding in TUI browser
  perf annotate-data: Show first-level children by default in TUI

 tools/perf/ui/browsers/annotate-data.c | 343 ++++++++++++++++++++++---
 1 file changed, 313 insertions(+), 30 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog

