Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52FFC56202
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 13:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CC520829
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 13:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY5fET/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgKQNSC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 08:18:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730628AbgKQNR5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Nov 2020 08:17:57 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D56D9241A5;
        Tue, 17 Nov 2020 13:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605619076;
        bh=ic5jBbux+UJZJYLocT+D+GpplxxWtefD7bxISAML9mE=;
        h=From:To:Cc:Subject:Date:From;
        b=HY5fET/ibuahJ83p06su5x1ExQVINy2eFT6YPWXjaRZIWREzx48FRhlo67NHtccWw
         afYr8ZvOiM7Ot0TrZPYCCIgJVTuz2zWKxsmcxMcS+wsA7zTjYNAvOagdaoFPSYMVO5
         ZH6EBDyNpxBhi9zJAa/nDewNAKL0rwJs/zrX5kpM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <al.grant@arm.com>, Ian Rogers <irogers@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.10: 3rd batch
Date:   Tue, 17 Nov 2020 10:17:47 -0300
Message-Id: <20201117131747.650843-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit af5043c89a8ef6b6949a245fff355a552eaed240:

  Merge tag 'acpi-5.10-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2020-11-12 11:06:53 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.10-2020-11-17

for you to fetch changes up to 568beb27959b0515d325ea1c6cf211eed2d66740:

  perf test: Avoid an msan warning in a copied stack. (2020-11-16 14:10:58 -0300)

----------------------------------------------------------------
perf tools updates for v5.10: 3rd batch.

- Fix file corruption due to event deletion in 'perf inject'.

- Update arch/x86/lib/mem{cpy,set}_64.S copies used in 'perf bench mem
  memcpy', silencing perf build warning.

- Avoid an msan warning in a copied stack in 'perf test'.

- Correct tracepoint field name "flags" in ARM's CS-ETM hardware tracing
  'perf test' entry.

- Update branch sample pattern for cs-etm to cope with excluding guest
  in userspace counting.

- Don't free "lock_seq_stat" if read_count isn't zero in 'perf lock'.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Test results at the signed tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-fixes-for-v5.10-2020-11-17

----------------------------------------------------------------
Al Grant (1):
      perf inject: Fix file corruption due to event deletion

Arnaldo Carvalho de Melo (1):
      tools arch: Update arch/x86/lib/mem{cpy,set}_64.S copies used in 'perf bench mem memcpy'

Ian Rogers (1):
      perf test: Avoid an msan warning in a copied stack.

Leo Yan (4):
      perf lock: Correct field name "flags"
      perf lock: Don't free "lock_seq_stat" if read_count isn't zero
      perf test: Fix a typo in cs-etm testing
      perf test: Update branch sample pattern for cs-etm

 tools/arch/x86/lib/memcpy_64.S               |  8 +++-----
 tools/arch/x86/lib/memset_64.S               | 11 ++++++-----
 tools/perf/arch/x86/tests/dwarf-unwind.c     |  7 +++++++
 tools/perf/bench/mem-memcpy-x86-64-asm.S     |  3 +++
 tools/perf/bench/mem-memset-x86-64-asm.S     |  3 +++
 tools/perf/builtin-inject.c                  | 12 +-----------
 tools/perf/builtin-lock.c                    |  4 ++--
 tools/perf/tests/shell/test_arm_coresight.sh |  4 ++--
 tools/perf/util/include/linux/linkage.h      |  7 +++++++
 9 files changed, 34 insertions(+), 25 deletions(-)
