From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 0/1] perf script fix
Date: Fri,  6 Oct 2017 10:02:09 -0300
Message-ID: <20171006130210.10533-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751961AbdJFNCQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Oct 2017 09:02:16 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Santaniello <marksan@fb.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Ingo,

	Please consider pulling,

- Arnaldo

The following changes since commit 874d48f2af91efc38c720e7c6450547f6ea8c843:

  Merge tag 'perf-urgent-for-mingo-4.14-20171005' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-10-05 20:07:08 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.14-20171006

for you to fetch changes up to e9516c0813aeb89ebd19ec0ed39fbfcd78b6ef3a:

  perf script: Add missing separator for "-F ip,brstack" (and brstackoff) (2017-10-06 09:48:32 -0300)

----------------------------------------------------------------
perf urgent fix:

. Add missing separator for "perf script -F ip,brstack"
  (and brstackoff)(Mark Santaniello <marksan@fb.com)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Mark Santaniello (1):
      perf script: Add missing separator for "-F ip,brstack" (and brstackoff)

 tools/perf/builtin-script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
