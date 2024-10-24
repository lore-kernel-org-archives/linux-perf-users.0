Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533B1F76A2
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776785; cv=none; b=gNZhheA94OXN6L496MUfGBI5WIGR428HJ0sxbPdApDxbugD5+2uP3Gog0nyFr+WWSkTV3fZZYpp5POKNqPwR/lKY+ZswoTaTmcLQxye2gUoBj5b3rSdhvZ4rZ59ZgPcdO5SFNHdszaQ39kUH8ZE1qK2KcskajzYNLnfRB3AFiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776785; c=relaxed/simple;
	bh=NnMzXZbo6O7cDOamCssV4pjwCoB7voI5BP2CXThTJvQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YoDkkZ0OFEIDUB3uRHme+HBNDWB3at5/5hdz/dEVDTgMC/BizQOjY/H6u4uWOeW+lh1Xw731SOiZQi62UhIi0A+oI22Y8DYSXyZh/85Qv+0ahOPVy0qkklR5Kbded89Q8i6fPdG1gjwfOb9eJ+o+WrN75ks7bCgHQ9LBCSJRYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XZ6Hq0px5zpXL1;
	Thu, 24 Oct 2024 21:31:03 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id D33801800DB;
	Thu, 24 Oct 2024 21:32:59 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 24 Oct 2024 21:32:59 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <linux-perf-users@vger.kernel.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <leo.yan@arm.com>,
	<amadio@gentoo.org>, <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH] perf build: Add missing cflags when building with custom libtraceevent
Date: Thu, 24 Oct 2024 21:32:36 +0800
Message-ID: <20241024133236.31016-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

When building with custom libtraceevent, below errors occur:
$ make -C tools/perf NO_LIBPYTHON=1 PKG_CONFIG_PATH=<custom libtraceevent>
In file included from util/session.h:5,
                 from builtin-buildid-list.c:17:
util/trace-event.h:153:10: fatal error: traceevent/event-parse.h: No such file or directory
  153 | #include <traceevent/event-parse.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
<snip similar errors of missing headers>

This is because the include path is missed in the cflags. Add it.

Fixes: 0f0e1f445690 ("perf build: Use pkg-config for feature check for libtrace{event,fs}")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Another problem occurs when building on my old Ubuntu 18.04.1 (4.15 kernel)
is that linux/mount.h (which is introduced in the later kernel version) is
missing. It's included in tools/include/uapi/linux/fs.h which header is
introduced recently. Does it make sense to have a copy of mount.h in tools/include?

 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4ddb27a48eed..53fc5f787a77 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1194,7 +1194,7 @@ endif
 ifneq ($(NO_LIBTRACEEVENT),1)
   $(call feature_check,libtraceevent)
   ifeq ($(feature-libtraceevent), 1)
-    CFLAGS += -DHAVE_LIBTRACEEVENT
+    CFLAGS += -DHAVE_LIBTRACEEVENT $(shell $(PKG_CONFIG) --cflags libtraceevent)
     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtraceevent)
     EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtraceevent)
     LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent).0.0
-- 
2.24.0

