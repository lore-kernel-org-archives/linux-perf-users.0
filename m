Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB5F41E25
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EU+aw5wB"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC47171F
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5a16fa94so264226276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186293; x=1698791093; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=te3vsO4FFSO2xyEIikKiywGT5AKUPIsHpoNC65majkY=;
        b=EU+aw5wBe8FZvBL8crMRweg+EtN2PXjPDp24t4tZS6NGh7DtAdvSifsXhDpa7oPG2k
         KkOOlBOnHKnfaheuCAgsfj9gHTQ4vEBNywX9PstW6/fHnbM+k/a0K/Rmj/TtX16vgSHW
         PfNKFSB8NLH+JrFWJ0liIgra8hQLQtpmh5gug/6yNu2u3YHiT/A/UVZ4NJFSHHxEqkAV
         v4++5qYr61lq72+p72jh6f2VMbCdX3hxx4EKP23L3aFlSsmIFsUXqO+MitPidgKrY7YL
         x2pwSUk7v0woASAcnX9mwYdqqd7PcBY4Ju40gJRGohUmUgsyKaDNOAUDoEVgdNu/xR8S
         HI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186293; x=1698791093;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=te3vsO4FFSO2xyEIikKiywGT5AKUPIsHpoNC65majkY=;
        b=cflOrN2ZmqI/br2CXEjXgfB4vlRvoALv6Rb6C8R0Xu+1aDiG3BhqnJBH8bch0ySNXQ
         lgEQVBkZdYTGhiN/Y7zUqVlCSzKNa7SIheEeTEFFQpsaGytrz39zf+ZbUrBUG3QkKu2A
         F+nPwDpSauUhsqirY/ht062Ke+SFaZRi4TgMOj8B4DVWAEiOjI0bj3zXKuSHcXq4RQ1c
         4MfGJ0vNkSo5+Vrepl6HP8kHltb9ljFvngHwVgXGuu3u3tffI70DEDsYX7sS6XnTfdM0
         vSsOOgBr+E71egrWtnkCjF5HrVtLnRAFI6TPXud/d6GYS5BRe7aHeyWgftKTFLB1eqgv
         F9og==
X-Gm-Message-State: AOJu0Yxy2WSJy7m3ziNs6gPGhFFjPAiueI1+br2YopiIoUenfVLFnoRQ
	X3gUiVE3/f0ClViQ7ERRfNXp6InADlWp
X-Google-Smtp-Source: AGHT+IG0qlkZIkteZoBsDEjUJuPv/qSoyKpAZj2pIJc3FbHR64e6ge1+0/2JSt3i23IoBIy48WvXUELizceV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:34d1:0:b0:d9a:6360:485b with SMTP id
 b200-20020a2534d1000000b00d9a6360485bmr385698yba.2.1698186293540; Tue, 24 Oct
 2023 15:24:53 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:21 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 18/50] tools lib api: Add io_dir an allocation free readdir alternative
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

glibc's opendir allocates a minimum of 32kb, when called recursively
for a directory tree the memory consumption can add up - nearly 300kb
during perf start-up when processing modules. Add a stack allocated
variant of readdir sized a little more than 1kb.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile |  2 +-
 tools/lib/api/io_dir.h | 72 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)
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
index 000000000000..8a70c0718df5
--- /dev/null
+++ b/tools/lib/api/io_dir.h
@@ -0,0 +1,72 @@
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
+static inline bool io_dir__is_dir(const struct io_dir *iod, const struct io_dirent64 *dent)
+{
+	if (dent->d_type == DT_UNKNOWN) {
+		struct stat st;
+
+		if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
+			return false;
+
+		return S_ISDIR(st.st_mode);
+	}
+	return dent->d_type == DT_DIR;
+}
+
+#endif
-- 
2.42.0.758.gaed0368e0e-goog

