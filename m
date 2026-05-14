Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BEE1F131A;
	Thu, 14 May 2026 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735212; cv=none; b=GFo+I09kwUgBiCn3c4O6HG/cRQG69OtYeaS9JtejOMcXcoHOe8g6MEN3AG7LF/obzDGk2rNggy4PVaDswUOptzClbGy7Rtpzzoqgzuni+5DFjK+S6Qxtvt895o5JZ+3n+xeZCQTgdzdVM7ri30AlnzMULLZylAREqSyqtC1/BrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735212; c=relaxed/simple;
	bh=bamNddKdXVgxZqutIBQo9gEmJk9kTncPd0EXZfEgTdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ggp3LJiLLCUhY3TZhftZywbBSJvvXN5FRP1EGvcqWCWVTcZHrU+E1bB1GetR3udHF3Qp4qacDx6OIDBUmmXcR8jkfAMmaxbaTciFQgC7kkY7LDQKChk3p8QBEhw0Dq8UNSMqblHqvo7dYOOTbEI5vU6OtanBStFVf9colNrbD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=b673L7Bl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="b673L7Bl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE14F34E9;
	Wed, 13 May 2026 22:06:43 -0700 (PDT)
Received: from entos-yitian-01.Arm.com (unknown [10.168.197.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBDE73F7B4;
	Wed, 13 May 2026 22:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778735208; bh=bamNddKdXVgxZqutIBQo9gEmJk9kTncPd0EXZfEgTdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b673L7Blg3xg5L8WNcH7Zu5Qed2gjayMHfkv11+YttJp8eNSGYY+dy8l8+bWF+x3d
	 GlV5mp0EmcKddlaO/ogQAMiO2Nji6JgHdJUq+fZ1MI3eFkgo3FhjlM0/0ipeiPA3gT
	 pRAhQbybLcIUmVcUZ1v2H5Kk8WOLYxSe6HEv6GMA=
From: Jia He <justin.he@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jia He <justin.he@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/7] init/initramfs_test: wait_for_initramfs() before running
Date: Thu, 14 May 2026 05:04:49 +0000
Message-Id: <20260514050455.2954509-2-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514050455.2954509-1-justin.he@arm.com>
References: <20260514050455.2954509-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

initramfs_test_extract() and friends call unpack_to_rootfs() from a
kunit kthread while do_populate_rootfs() may still be running
asynchronously from rootfs_initcall. unpack_to_rootfs() keeps its
parser state in module-static variables (victim, byte_count, state,
this_header, header_buf, name_buf, ...), so the two writers corrupt
each other.

On arm64 v7.0-rc5+ this oopses early in boot:

  Unable to handle kernel paging request at virtual address ffff80018f9f0ffc
  pc : do_reset+0x3c/0x98
  Call trace:
   do_reset
   initramfs_test_extract
   kunit_try_run_case
  Initramfs unpacking failed: junk within compressed archive

do_reset() faults because 'victim' was overwritten by the boot-time
unpacker; the boot unpacker meanwhile logs the bogus "junk within
compressed archive" on the real initrd because the test wrecked its
state machine.

Add a suite .init that calls wait_for_initramfs() so the async unpack
is quiescent before the first case runs.

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-fsdevel@vger.kernel.org

Fixes: 83c0b27266ec ("initramfs_test: kunit tests for initramfs unpacking")
Signed-off-by: Jia He <justin.he@arm.com>
---
 init/initramfs_test.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 2ce38d9a8fd0..eb76f63f302e 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -3,7 +3,9 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/init.h>
 #include <linux/init_syscalls.h>
+#include <linux/initrd.h>
 #include <linux/stringify.h>
 #include <linux/timekeeping.h>
 #include "initramfs_internal.h"
@@ -510,8 +512,21 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	{},
 };
 
-static struct kunit_suite initramfs_test_suite = {
+static int __init initramfs_test_init(struct kunit *test)
+{
+	/*
+	 * unpack_to_rootfs() uses module-static state (victim, byte_count,
+	 * state, ...). The boot-time async do_populate_rootfs() may still be
+	 * running, so wait for it to finish before we call unpack_to_rootfs()
+	 * from the test thread, otherwise the two writers race and crash.
+	 */
+	wait_for_initramfs();
+	return 0;
+}
+
+static struct kunit_suite __refdata initramfs_test_suite = {
 	.name = "initramfs",
+	.init = initramfs_test_init,
 	.test_cases = initramfs_test_cases,
 };
 kunit_test_init_section_suites(&initramfs_test_suite);
-- 
2.34.1

