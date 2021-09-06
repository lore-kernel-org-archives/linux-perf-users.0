Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CE4C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 15:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3DA60F13
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 15:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhIFPXy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Sep 2021 11:23:54 -0400
Received: from foss.arm.com ([217.140.110.172]:56682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233929AbhIFPXy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Sep 2021 11:23:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CA3A31B;
        Mon,  6 Sep 2021 08:22:49 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.47.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B7C3E3F766;
        Mon,  6 Sep 2021 08:22:47 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tests: Fix flaky test 'Object code reading'
Date:   Mon,  6 Sep 2021 16:22:38 +0100
Message-Id: <20210906152238.3415467-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This test occasionally fails on aarch64 when a sample is taken in
free@plt and it fails with "Bytes read differ from those read by
objdump". This is because that symbol is near a section boundary in the
elf file. Despite the -z option to always output zeros, objdump uses
bfd_map_over_sections() to iterate through the elf file so it doesn't
see outside of the sections where these zeros are and can't print them.

For example this boundary proceeds free@plt in libc with a gap of 48
bytes between .plt and .text:

  objdump -d -z --start-address=0x23cc8 --stop-address=0x23d08 libc-2.30.so

  libc-2.30.so:     file format elf64-littleaarch64

  Disassembly of section .plt:

  0000000000023cc8 <*ABS*+0x7fd00@plt+0x8>:
     23cc8:	91018210 	add	x16, x16, #0x60
     23ccc:	d61f0220 	br	x17

  Disassembly of section .text:

  0000000000023d00 <abort@@GLIBC_2.17-0x98>:
     23d00:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
     23d04:	910003fd 	mov	x29, sp

Taking a sample in free@plt is very rare because it is so small, but the
test can be forced to fail almost every time on any platform by linking
the test with a shared library that has a single empty function and
calling it in a loop.

The fix is to zero the buffers so that when there is a jump in the
addresses output by objdump, zeros are already filled in between.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/code-reading.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 9866cddebf23..9b4a765e4b73 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -229,8 +229,8 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			    struct thread *thread, struct state *state)
 {
 	struct addr_location al;
-	unsigned char buf1[BUFSZ];
-	unsigned char buf2[BUFSZ];
+	unsigned char buf1[BUFSZ] = {0};
+	unsigned char buf2[BUFSZ] = {0};
 	size_t ret_len;
 	u64 objdump_addr;
 	const char *objdump_name;
-- 
2.28.0

