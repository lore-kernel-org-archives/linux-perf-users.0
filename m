From: Arun Sharma <asharma@fb.com>
Subject: [PATCH 0/2] perf: add sort by inclusive time functionality (v2)
Date: Wed,  7 Mar 2012 14:41:17 -0800
Message-ID: <1331160079-13821-1-git-send-email-asharma@fb.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arun Sharma <asharma@fb.com>, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

This patch series refactors existing code a bit and adds sort by 
inclusive time (time spent in the function + callees).

Sample command lines:

# perf record -ag -- sleep 1
# perf report -g graph,0.5,callee -n -s inclusive

Known bugs:

total_period computation is broken for order=callee

Signed-off-by: Arun Sharma <asharma@fb.com>
Cc: Ingo Molnar <mingo@elte.hu>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Namhyung Kim <namhyung.kim@lge.com>
Cc: Tom Zanussi <tzanussi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
