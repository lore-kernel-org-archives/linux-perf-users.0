Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YheQzlfs"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEE5D64
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd573c2cccso29210007b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122974; x=1701727774; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEmgO09+w7D/FXE2RqMfg/xWGErZ4jMQFLdNI3fBx44=;
        b=YheQzlfsb9155A0nVfE/EJ9mhvmONOIFZ+JLlSedA7E2YsQBZM6fiprcBmWAmQUEs4
         KXqJhg0eNCW7DORy9Y+W2kJV8E9AsKTXfP1nOHUubRdIyX4WDUimtYL/RtuIIMLfUcdA
         5yPAYK/QfVeQ5PsF5oF8P9qmIZrGV/j3pSEL99UT/i5UPjaus+q+AYQ2wDcu7F/f3eEA
         cWhK5rsMhlFoIi9clg1MuKQHFCe0TGvZm4QbkVHBHuZeJ6Dy8K2J3I/BQV4AWB3xEx9M
         EG8OizUGXZZNqARwJBn+YrZz0+tG3Wz95PO2h2mMDGyV+dTHEUKhUrpN9j2LPDigdouo
         ePdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122974; x=1701727774;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEmgO09+w7D/FXE2RqMfg/xWGErZ4jMQFLdNI3fBx44=;
        b=CKy/VQxxM/JI9Ri2FWIEzz/dimne63c3tkaUGd6iR9fRHYAbg/peV3Evr9CncB7QTm
         nRH//oI+UjKeAEkxBu+sFYZEdoj02HH/n987ldw1Sb5yu9uJY6onlMA33fCaWVuPayOX
         DdbjGeyIB9ODI/xO3++6Us/XOcPvbzw7lmYXAr3mnfEZZ4/Cw40rqbVLyOUn23sbiGY8
         tZe8Aus1itWMMOiiUXQrTK+/zSB/thgEjTO/R+P5ip68h7WcyOT4i8ee21Vn8WQUeIbY
         QXN604/xC57wUoOPyH634kvwq+P9hvOEvoQd90YAcHJJgAjc6V0kXJiRX2Ks2By1/18U
         XHWg==
X-Gm-Message-State: AOJu0YxfSOehS7xYtnHHlh3IcICK4rELwjW8N6QKOftSNbzCjpY3tD0R
	MXHDSpeCJkbe21uL7ZZShjiVqGr9Me2J
X-Google-Smtp-Source: AGHT+IHus6n9B6wO57xmLGcAOXuveh7hgGsxA/NX82QWYM0uv7NsouBu6yln/ZjYTA96ykxWGX/23AO7mqbX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b0a:b0:5d0:8fb3:559c with SMTP
 id em10-20020a05690c2b0a00b005d08fb3559cmr120925ywb.0.1701122974473; Mon, 27
 Nov 2023 14:09:34 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:18 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 06/50] tools lib api: Add io_dir an allocation free readdir alternative
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

glibc's opendir allocates a minimum of 32kb, when called recursively
for a directory tree the memory consumption can add up - nearly 300kb
during perf start-up when processing modules. Add a stack allocated
variant of readdir sized a little more than 1kb.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile |  2 +-
 tools/lib/api/io_dir.h | 75 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/api/io_dir.h

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 044860ac1ed1..186aa407de8c 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -99,7 +99,7 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-HDRS := cpu.h debug.h io.h
+HDRS := cpu.h debug.h io.h io_dir.h
 FD_HDRS := fd/array.h
 FS_HDRS := fs/fs.h fs/tracing_path.h
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
new file mode 100644
index 000000000000..f3479006edb6
--- /dev/null
+++ b/tools/lib/api/io_dir.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/*
+ * Lightweight directory reading library.
+ */
+#ifndef __API_IO_DIR__
+#define __API_IO_DIR__
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/stat.h>
+
+struct io_dirent64 {
+	ino64_t        d_ino;    /* 64-bit inode number */
+	off64_t        d_off;    /* 64-bit offset to next structure */
+	unsigned short d_reclen; /* Size of this dirent */
+	unsigned char  d_type;   /* File type */
+	char           d_name[NAME_MAX + 1]; /* Filename (null-terminated) */
+};
+
+struct io_dir {
+	int dirfd;
+	ssize_t available_bytes;
+	struct io_dirent64 *next;
+	struct io_dirent64 buff[4];
+};
+
+static inline void io_dir__init(struct io_dir *iod, int dirfd)
+{
+	iod->dirfd = dirfd;
+	iod->available_bytes = 0;
+}
+
+static inline void io_dir__rewinddir(struct io_dir *iod)
+{
+	lseek(iod->dirfd, 0, SEEK_SET);
+	iod->available_bytes = 0;
+}
+
+static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
+{
+	struct io_dirent64 *entry;
+
+	if (iod->available_bytes <= 0) {
+		ssize_t rc = getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
+
+		if (rc <= 0)
+			return NULL;
+		iod->available_bytes = rc;
+		iod->next = iod->buff;
+	}
+	entry = iod->next;
+	iod->next = (struct io_dirent64 *)((char *)entry + entry->d_reclen);
+	iod->available_bytes -= entry->d_reclen;
+	return entry;
+}
+
+static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_dirent64 *dent)
+{
+	if (dent->d_type == DT_UNKNOWN) {
+		struct stat st;
+
+		if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
+			return false;
+
+		if (S_ISDIR(st.st_mode)) {
+			dent->d_type = DT_DIR;
+			return true;
+		}
+	}
+	return dent->d_type == DT_DIR;
+}
+
+#endif
-- 
2.43.0.rc1.413.gea7ed67945-goog

