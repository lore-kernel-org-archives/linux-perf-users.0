Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460B3AD538;
	Thu, 14 May 2026 05:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735257; cv=none; b=eNJWVvRnFedErohL/PczgRefFyxULseBjRZUkWCWpRMXF0KctxnlCQX8C+FGANn/ML9jZ5U+YpzqGNMEJGXB8XvG+0u35aIo+e/bTjToWMRfpjoAA8HLz7d1cD/2+ML4hSjFLu76D6gx2epdW1KuUPRQH092bakoAc1PQoNl5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735257; c=relaxed/simple;
	bh=czAmxYpsET1Yh9/oz4/+53pPQLCrLQvlifYICwLtv+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kIvusrLqoJQch1yxgap8nQw1KoVK9YN2AiBfAhc9zztCayITnafUiDYArMWKU7xury5GViESiGzNS53Bx+ep75W7nQJ1PeAg1skOBR5HqTXqVkA4jdiev6Q3Lbx7GN3Tyw9n+fJkjNto6XZVX/TpvTYVNqMVswqHWGHXl4CmE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=o0FHpsW6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="o0FHpsW6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2CF51655;
	Wed, 13 May 2026 22:07:29 -0700 (PDT)
Received: from entos-yitian-01.Arm.com (unknown [10.168.197.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 725C53F7B4;
	Wed, 13 May 2026 22:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778735255; bh=czAmxYpsET1Yh9/oz4/+53pPQLCrLQvlifYICwLtv+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0FHpsW6gdbF86tmY2ETArYqOqWqOOY1GNI2kiRdvM0pm7oBhmWbI0Z0X6+EHPNZl
	 qQBBP5fVos0FOErmjWVY5uBrA7RJCxa2iqP47kzzSkryHXE/vBAHPK+Hyo+H+t3yN/
	 GRfD9Ykf4sHrnO+EeU80Z+AFYPlWekU7W7R3aPKc=
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
Subject: [PATCH 4/7] kunit: platform: catch duplicate (name, id) in kunit_platform_device_add()
Date: Thu, 14 May 2026 05:04:52 +0000
Message-Id: <20260514050455.2954509-5-justin.he@arm.com>
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

kunit_platform_device_add_twice_fails_test registers the same device
twice and expects failure. Without an early check the second
platform_device_add() reaches sysfs_create_dir_ns() and dumps a
backtrace via sysfs_warn_dup() on every run.

Walk the platform bus for a device with matching name and id and return
-EEXIST. PLATFORM_DEVID_AUTO assigns its id inside add() and can't
collide, so skip it.

To: Brendan Higgins <brendan.higgins@linux.dev>
To: David Gow <david@davidgow.net>
To: Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com

Signed-off-by: Jia He <justin.he@arm.com>
---
 lib/kunit/platform.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/kunit/platform.c b/lib/kunit/platform.c
index 0b518de26065..515f7c859014 100644
--- a/lib/kunit/platform.c
+++ b/lib/kunit/platform.c
@@ -7,6 +7,7 @@
 #include <linux/device/bus.h>
 #include <linux/device/driver.h>
 #include <linux/platform_device.h>
+#include <linux/string.h>
 
 #include <kunit/platform_device.h>
 #include <kunit/resource.h>
@@ -80,6 +81,20 @@ kunit_platform_device_alloc_match(struct kunit *test,
 
 KUNIT_DEFINE_ACTION_WRAPPER(platform_device_unregister_wrapper,
 			    platform_device_unregister, struct platform_device *);
+
+struct kunit_pdev_dup_match {
+	const char *name;
+	int id;
+};
+
+static int kunit_pdev_dup_match_fn(struct device *dev, void *data)
+{
+	struct kunit_pdev_dup_match *m = data;
+	struct platform_device *p = to_platform_device(dev);
+
+	return p->id == m->id && p->name && !strcmp(p->name, m->name);
+}
+
 /**
  * kunit_platform_device_add() - Register a KUnit test managed platform device
  * @test: test context
@@ -95,6 +110,22 @@ int kunit_platform_device_add(struct kunit *test, struct platform_device *pdev)
 	struct kunit_resource *res;
 	int ret;
 
+	/*
+	 * Detect duplicate (name, id) registrations early, before
+	 * platform_device_add() reaches sysfs_create_dir_ns() and
+	 * unconditionally dumps a stack trace via sysfs_warn_dup(). This keeps
+	 * tests that intentionally exercise the duplicate-add failure path
+	 * (e.g. kunit_platform_device_add_twice_fails_test) quiet without
+	 * losing the negative return value they assert on.
+	 */
+	if (pdev->name && pdev->id != PLATFORM_DEVID_AUTO) {
+		struct kunit_pdev_dup_match m = { pdev->name, pdev->id };
+
+		if (bus_for_each_dev(&platform_bus_type, NULL, &m,
+				     kunit_pdev_dup_match_fn))
+			return -EEXIST;
+	}
+
 	ret = platform_device_add(pdev);
 	if (ret)
 		return ret;
-- 
2.34.1

