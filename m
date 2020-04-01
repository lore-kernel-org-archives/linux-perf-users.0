From: Ian Rogers <irogers@google.com>
Subject: [PATCH 4/5] tools api: add a lightweight buffered reading api
Date: Wed,  1 Apr 2020 16:39:44 -0700
Message-ID: <20200401233945.133550-5-irogers@google.com>
References: <20200401233945.133550-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200401233945.133550-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Petr Mladek <pmladek@suse.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

The synthesize benchmark shows the majority of execution time going to
fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
reading library that will be used to replace these calls in a follow-up
CL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 103 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 tools/lib/api/io.h

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
new file mode 100644
index 000000000000..e88d76c59440
--- /dev/null
+++ b/tools/lib/api/io.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lightweight buffered reading library.
+ *
+ * Copyright 2019 Google LLC.
+ */
+
+struct io {
+	/* File descriptor being read/ */
+	int fd;
+	/* Size of the read buffer. */
+	unsigned int buf_len;
+	/* Pointer to storage for buffering read. */
+	char *buf;
+	/* End of the storage. */
+	char *end;
+	/* Currently accessed data pointer. */
+	char *data;
+	/* Set true on when the end of file on read error. */
+	bool eof;
+};
+
+static inline void init_io(struct io *io, int fd,
+			   char *buf, unsigned int buf_len)
+{
+	io->fd = fd;
+	io->buf_len = buf_len;
+	io->buf = buf;
+	io->end = buf;
+	io->data = buf;
+	io->eof = false;
+}
+
+/* Reads one character from the "io" file with similar semantics to fgetc. */
+static inline int get_char(struct io *io)
+{
+	char *ptr = io->data;
+
+	if (ptr == io->end) {
+		ssize_t n = read(io->fd, io->buf, io->buf_len);
+
+		if (n <= 0) {
+			io->eof = true;
+			return -1;
+		}
+		ptr = &io->buf[0];
+		io->end = &io->buf[n];
+	}
+	io->data = ptr + 1;
+	return *ptr;
+}
+
+/* Read a hexadecimal value with no 0x prefix into the out argument hex.
+ * Returns -1 on error or if nothing is read, otherwise returns the character
+ * after the hexadecimal value.
+ */
+static inline int get_hex(struct io *io, __u64 *hex)
+{
+	bool first_read = true;
+
+	*hex = 0;
+	while (true) {
+		char ch = get_char(io);
+
+		if (ch < 0)
+			return ch;
+		if (ch >= '0' && ch <= '9')
+			*hex = (*hex << 4) | (ch - '0');
+		else if (ch >= 'a' && ch <= 'f')
+			*hex = (*hex << 4) | (ch - 'a' + 10);
+		else if (ch >= 'A' && ch <= 'F')
+			*hex = (*hex << 4) | (ch - 'A' + 10);
+		else if (first_read)
+			return -1;
+		else
+			return ch;
+		first_read = false;
+	}
+}
+
+/* Read a decimal value into the out argument dec.
+ * Returns -1 on error or if nothing is read, otherwise returns the character
+ * after the decimal value.
+ */
+static inline int get_dec(struct io *io, __u64 *dec)
+{
+	bool first_read = true;
+
+	*dec = 0;
+	while (true) {
+		char ch = get_char(io);
+
+		if (ch < 0)
+			return ch;
+		if (ch >= '0' && ch <= '9')
+			*dec = (*dec * 10) + ch - '0';
+		else if (first_read)
+			return -1;
+		else
+			return ch;
+		first_read = false;
+	}
+}
-- 
2.26.0.rc2.310.g2932bb562d-goog
