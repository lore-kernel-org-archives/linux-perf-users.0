Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DE4AEBE8;
	Thu,  3 Sep 2026 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441805; cv=none; b=OuMbgg2IjW0davABYNF51Lb+cqHbZzuWkwzqT3yVvmym4frqF0SkWut7c2vlJGWQtfEm2EiDVky5JjgmvhStDmPaKaoLTEeBdlBtE1TzTwq0sz32syJSyJdxGBOBiIQj256XoH57plPu3bjrIfZ1Bm4Z2OgpIF9keQ9ereOVEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441805; c=relaxed/simple;
	bh=49Kw97LLSQ4wYGERFAwnuRn8NRTU8dL5rolrv5ESGpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu+FiMGbyXPyO7LjJi3ehgbV2Kw4oYzpeXhu54s9xDcaNmJkroUrcQCwS/ib664Ld7EeP5PrKJqTOWpjTHBGnquc70eC/HLU+b3jmPJYwJjgsp0TrkZDRwdysFs7Y58PVPjE6bAwIYvbXOmxHvXGYicoK6WXx4zy0YHz7ojLuVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9k0+2iW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9k0+2iW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4131F00A3D;
	Thu,  3 Sep 2026 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788441793;
	bh=zVuGCa5JkO9W8qaCsJWajvQZcXk7UK/+LrY4kqAkDVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N9k0+2iWiLbMDV4sX7XBd+Fbq8fG+52A5vi6mKScjW9s1B3GbZ0QmtcWb3v7q9FQu
	 K7BWI5fu4Xn9i7gOH6M/YyKZXMX+1uTfGHZHA5qyA9QqDdiq760ZLVnIas99+SODfJ
	 zg8VQj6mUKnAEKUNyayDx+ruU5qr9xHwD15ph8qVbQpiZT1IULQRNcIR1nhcpCApZC
	 Srq0fcLPqZBsvKadEZI7mchGDxTRXE9Jvvt0HIBeR1Plz41Xxse8b8l9XTwa3ir+FL
	 XwPNR8oUGCtaDMtUVaBkV6G04i+F9SRr3HODJt7hZe9Yog/ZL8nU50SQLLwF2lGw1T
	 5upiXXjVoohKQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 5/5] perf dso: Defer dropping the open list reference until after the lock
Date: Thu,  3 Sep 2026 10:22:51 -0300
Message-ID: <20260903132251.237029-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903132251.237029-1-acme@kernel.org>
References: <20260903132251.237029-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There was a problem in the code with some resources potentially being
left unbalanced, and the logic on dso__data_close() becoming confused
if the fd had been closed already.

The reference taken by dso__list_add() on the open list cannot be
dropped while holding the open lock: dso__put() may call
dso__data_close(), which takes dso__data_open_lock() itself,
deadlocking and leaving the list and its counter inconsistent for
concurrent threads.

Fix it by changing dso__list_del() to transfer the reference to a
deferred node, drained by dso__put_deferred() right after every
unlock of dso__data_open_lock().  Since the counter is now decremented
under the open lock, do_open()'s close_first_dso() no longer races
with a stale count.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 75 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 42bfe30a3b518e80..a4b2361bc7420084 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -531,18 +531,79 @@ static void dso__list_add(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_o
 	dso__data_open_cnt++;
 }
 
+#ifdef REFCNT_CHECKING
+/*
+ * A deferred put: carries the reference taken by dso__list_add() for an
+ * entry removed from dso__data_open.  Dedicated nodes are used so that
+ * the dso_data's own open_entry node can be relinked by a concurrent
+ * dso__list_add() without corrupting this list or its reference.
+ */
+struct dso_data_put {
+	struct list_head entry;
+	struct dso *dso;
+};
+static LIST_HEAD(dso__data_open_put);
+#endif
+
 static void dso__list_del(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
-	list_del_init(&dso__data(dso)->open_entry);
 #ifdef REFCNT_CHECKING
-	mutex_unlock(dso__data_open_lock());
-	dso__put(dso__data(dso)->dso);
-	mutex_lock(dso__data_open_lock());
+	struct dso_data_put *put;
 #endif
+
+	list_del_init(&dso__data(dso)->open_entry);
 	WARN_ONCE(dso__data_open_cnt <= 0,
 		  "DSO data fd counter out of bounds.");
 	dso__data_open_cnt--;
+#ifdef REFCNT_CHECKING
+	/*
+	 * The reference taken in dso__list_add() cannot be dropped while
+	 * holding the open lock: dso__put() may call dso__data_close(),
+	 * which takes dso__data_open_lock itself, deadlocking and leaving
+	 * the list/counter state inconsistent for concurrent threads.
+	 * Transfer the reference to a deferred node drained by
+	 * dso__put_deferred() once the lock is released.
+	 */
+	put = zalloc(sizeof(*put));
+
+	if (put == NULL)
+		return;
+
+	put->dso = dso__data(dso)->dso;
+	dso__data(dso)->dso = NULL;
+	list_add_tail(&put->entry, &dso__data_open_put);
+#endif
+}
+
+#ifdef REFCNT_CHECKING
+/*
+ * Drop the references deferred by dso__list_del().  Must be called
+ * without holding dso__data_open_lock: dso__put() may re-enter it via
+ * dso__data_close().
+ */
+static void dso__put_deferred(void) LOCKS_EXCLUDED(_dso__data_open_lock)
+{
+	for (;;) {
+		struct dso_data_put *put;
+		struct dso *dso;
+
+		mutex_lock(dso__data_open_lock());
+		put = list_first_entry_or_null(&dso__data_open_put, struct dso_data_put, entry);
+		if (put == NULL) {
+			mutex_unlock(dso__data_open_lock());
+			return;
+		}
+		list_del_init(&put->entry);
+		dso = put->dso;
+		mutex_unlock(dso__data_open_lock());
+
+		free(put);
+		dso__put(dso);
+	}
 }
+#else
+static void dso__put_deferred(void) {}
+#endif
 
 static void close_first_dso(void);
 
@@ -805,6 +866,7 @@ void dso__data_close(struct dso *dso)
 	mutex_lock(dso__data_open_lock());
 	close_dso(dso);
 	mutex_unlock(dso__data_open_lock());
+	dso__put_deferred();
 }
 
 static void try_to_open_dso(struct dso *dso, struct machine *machine)
@@ -865,12 +927,14 @@ bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
 		return true;
 
 	mutex_unlock(dso__data_open_lock());
+	dso__put_deferred();
 	return false;
 }
 
 void dso__data_put_fd(struct dso *dso __maybe_unused)
 {
 	mutex_unlock(dso__data_open_lock());
+	dso__put_deferred();
 }
 
 bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by)
@@ -1058,6 +1122,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 	ret = pread(dso__data(dso)->fd, data, DSO__DATA_CACHE_SIZE, offset);
 out:
 	mutex_unlock(dso__data_open_lock());
+	dso__put_deferred();
 	return ret;
 }
 
@@ -1188,6 +1253,7 @@ static int file_size(struct dso *dso, struct machine *machine)
 
 out:
 	mutex_unlock(dso__data_open_lock());
+	dso__put_deferred();
 	return ret;
 }
 
@@ -1405,6 +1471,7 @@ uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_
 		*e_flags = 0;
 
 	mutex_unlock(dso__data_open_lock());
+	dso__put_deferred();
 	return e_machine;
 }
 
-- 
2.55.0

