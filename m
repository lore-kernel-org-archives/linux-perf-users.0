Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA03B8D7B;
	Thu, 14 May 2026 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735272; cv=none; b=jqQddBb9zdwSAC6PHJLgmy/sGyqOcB0HI+WJqG4K8gMh4YJnSvBC2WwqlV/VIL/CUNHEJ49MeqGDatGA5NXJbac47O/lVdLZl0PY3reMNHRKSrK2Tfkd4V28Nr641maOtmMYxIj2l2YARtnSf2fBBQZlELrCge+K2/EDXbE2qCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735272; c=relaxed/simple;
	bh=ce3AeHJV8yA0xKyUjIxramcUgkGMSx1azmaa1bteAa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RHoNAShzKDHM3roKOQN3E43j76jzB4EbcdFYEfXD3ApRqS+1lehLLH7jB0/2ZLnmgZ50sqLvyV7oPBaeP42xKnWaJiBAAK9uT3atlH+sQMAyOQYezsJt0maGmiWXeJGuvME3s/dFN0oG30DqJ+jQUSVdUeWS8zBVGrf04Gy4+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KgHc+bOn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KgHc+bOn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF4261655;
	Wed, 13 May 2026 22:07:44 -0700 (PDT)
Received: from entos-yitian-01.Arm.com (unknown [10.168.197.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E43C13F7B4;
	Wed, 13 May 2026 22:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778735270; bh=ce3AeHJV8yA0xKyUjIxramcUgkGMSx1azmaa1bteAa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgHc+bOn9lgikGgIomgvWGL7kqneuNOKKQ+fOrKWE/NieiqN2IOjN5N29xio9U/Gs
	 tBlE8ab9OSGUZFsIgarUDezyF9gM9cPeTqnwWlC2UBGo0zeYocjDsihl89fxbt8ze6
	 h1nNyx74R72oscuS5m7ZFFQvmtdjAxbza+RG+LqQ=
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
Subject: [PATCH 5/7] misc: reject duplicate names in misc_register()
Date: Thu, 14 May 2026 05:04:53 +0000
Message-Id: <20260514050455.2954509-6-justin.he@arm.com>
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

The miscdev kunit suite registers two miscdevices with the same name
and expects -EEXIST. The second call currently goes all the way to
sysfs_create_dir_ns(), which prints "cannot create duplicate filename"
with a backtrace on every run.

Walk misc_list under misc_mtx, return -EEXIST on a name collision and
free the just-allocated minor before returning.

To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/char/misc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 726516fb0a3b..d6ffa21ac495 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -248,6 +248,28 @@ int misc_register(struct miscdevice *misc)
 		}
 	}
 
+	/*
+	 * Detect duplicate names up-front so the subsequent
+	 * device_create_with_groups() does not trip
+	 * sysfs_create_dir_ns()->sysfs_warn_dup(), which unconditionally
+	 * dumps a stack trace. Both the existing miscdev kunit suite
+	 * (miscdev_test_duplicate_name) and any caller racing on the same
+	 * name would otherwise pollute dmesg on every -EEXIST.
+	 */
+	{
+		struct miscdevice *c;
+
+		list_for_each_entry(c, &misc_list, list) {
+			if (strcmp(c->name, misc->name) == 0) {
+				misc_minor_free(misc->minor);
+				if (is_dynamic)
+					misc->minor = MISC_DYNAMIC_MINOR;
+				err = -EEXIST;
+				goto out;
+			}
+		}
+	}
+
 	dev = MKDEV(MISC_MAJOR, misc->minor);
 
 	misc->this_device =
-- 
2.34.1

