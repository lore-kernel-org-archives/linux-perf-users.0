From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/2] perf symbols: Fix memory corruption because of zero length symbols
Date: Fri, 27 Oct 2017 16:50:46 -0300
Message-ID: <20171027195047.27132-2-acme@kernel.org>
References: <20171027195047.27132-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932143AbdJ0Tu7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 Oct 2017 15:50:59 -0400
In-Reply-To: <20171027195047.27132-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kim Phillips <kim.phillips@arm.com>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Taeung Song <treeze.taeung@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Perf top is often crashing at very random locations on powerpc.  After
investigating, I found the crash only happens when sample is of zero
length symbol. Powerpc kernel has many such symbols which does not
contain length details in vmlinux binary and thus start and end
addresses of such symbols are same.

Structure

  struct sym_hist {
        u64                   nr_samples;
        u64                   period;
        struct sym_hist_entry addr[0];
  };

has last member 'addr[]' of size zero. 'addr[]' is an array of addresses
that belongs to one symbol (function). If function consist of 100
instructions, 'addr' points to an array of 100 'struct sym_hist_entry'
elements. For zero length symbol, it points to the *empty* array, i.e.
no members in the array and thus offset 0 is also invalid for such
array.

  static int __symbol__inc_addr_samples(...)
  {
        ...
        offset = addr - sym->start;
        h = annotation__histogram(notes, evidx);
        h->nr_samples++;
        h->addr[offset].nr_samples++;
        h->period += sample->period;
        h->addr[offset].period += sample->period;
        ...
  }

Here, when 'addr' is same as 'sym->start', 'offset' becomes 0, which is
valid for normal symbols but *invalid* for zero length symbols and thus
updating h->addr[offset] causes memory corruption.

Fix this by adding one dummy element for zero length symbols.

Link: https://lkml.org/lkml/2016/10/10/148
Fixes: edee44be5919 ("perf annotate: Don't throw error for zero length symbols")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1508854806-10542-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4397a8b6e6cd..aa66791b1bfc 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -606,9 +606,19 @@ static struct arch *arch__find(const char *name)
 int symbol__alloc_hist(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	const size_t size = symbol__size(sym);
+	size_t size = symbol__size(sym);
 	size_t sizeof_sym_hist;
 
+	/*
+	 * Add buffer of one element for zero length symbol.
+	 * When sample is taken from first instruction of
+	 * zero length symbol, perf still resolves it and
+	 * shows symbol name in perf report and allows to
+	 * annotate it.
+	 */
+	if (size == 0)
+		size = 1;
+
 	/* Check for overflow when calculating sizeof_sym_hist */
 	if (size > (SIZE_MAX - sizeof(struct sym_hist)) / sizeof(struct sym_hist_entry))
 		return -1;
-- 
2.13.6
