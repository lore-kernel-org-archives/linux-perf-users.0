Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939FD257845;
	Thu,  6 Aug 2026 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019843; cv=none; b=V8t5xZgYZkIKphlQiFl2BQlhZPkaNsODnLXVEF/f+CGGBu5q36SePC5FGwcGNpWOggNBEFXj6fAECrQjbRs2sCYsMfXibb+oJiCoTvVY+VzGw1UUOPazvp6w6SjjnzFmHCKOaftEJfaUegx44UsHCODLA8Vfe4fdHtAH6ve9z+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019843; c=relaxed/simple;
	bh=BMSZSbh4QqCDcAj4jNHr9AUogJVXdKpevF2vPUwfF7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+Xo+esrRV9Ix4qiYNVU+zP9pAdAlG2NLI6qVSq59f0PSwJeYqPY3RQy7HUYJs9RaqBqAMEcxTVGTDk9ePi9X2sL93Emza7ekc4pu1+fPUpql4+1qTTnB4C3gYfuflTyaL+vYxLKpDkUrB2apTAhay1tcsPmRtrrJkWSyW3gthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGOnma2U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGOnma2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681A41F00A3A;
	Thu,  6 Aug 2026 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019836;
	bh=jz8pdtxPjlYzX8D8R/3BRdPfTaskLXym80/LcGKzffs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OGOnma2UVXQxld6SfHRu43/mJs2w5nWaZEyO2uZJO8R8Zq9X5G3pGkixtNXjwIbsC
	 JvDDa74/RfrJMEf0XNgQZ/uIurICsUfhaq1ASt5kr41H5jPmvACGSzoDl3J7l6jkne
	 PP4qIMOFJhOoJLYPMowP2H4EV0GhTST8sSASKSmTfr/skOULjVM7IYbzoV9cQAwv9C
	 dARar73/Bf8FvATiuhDqJq3VAcJyh7C5UJk+c9LghQVqTI5kjpIEJY25rarSCK08R2
	 UkeRtUBEsGI9/fhH5mfR4xisV/a4eeEj1hmXDGc4Jw5wyAhKhDOMvZZ+GWnwkBoDAT
	 bwDVjMRhHvATA==
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
	Stefano Sanfilippo <ssanfilippo@chromium.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 12/12] perf jitdump: Validate unwinding sizes against record payload
Date: Thu,  6 Aug 2026 09:36:03 -0300
Message-ID: <20260806123604.271277-13-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806123604.271277-1-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_unwinding_info() copies unwinding_size and eh_frame_hdr_size
from the jitdump record into jd-> fields without checking them against
the actual payload size.  Downstream, jit_add_eh_frame_info() in
genelf.c computes unwinding_table_size = unwinding_size -
eh_frame_hdr_size, which underflows when eh_frame_hdr_size >
unwinding_size.  The result is passed as d->d_size to libelf, causing
an OOB heap read into the output ELF file.

Validate that unwinding_size fits within the record payload and that
eh_frame_hdr_size does not exceed unwinding_size before allocating or
storing the values, so a bogus record cannot force a large allocation
that is then discarded.

mapped_size is likewise taken from the record and was narrowed into an
int for the mmap2 len computation in jit_repipe_code_load() and
jit_repipe_code_move(); values above INT_MAX would turn negative,
producing a wrong mmap2 length.  Use uint64_t for usize so the value
cannot truncate.

Fixes: 0284fecd13b6db3e ("perf jit: Add unwinding support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stefano Sanfilippo <ssanfilippo@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Assisted-by: Opencode:mimo-v2.5-free
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 5898a7d8eb962daf..d25a9fe9b020ce87 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -462,7 +462,8 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	u16 idr_size;
 	const char *sym;
 	uint64_t count;
-	int ret, csize, usize;
+	int ret, csize;
+	uint64_t usize;
 	pid_t nspid, pid, tid;
 	struct {
 		u32 pid, tid;
@@ -543,7 +544,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	event->mmap2.pgoff = GEN_ELF_TEXT_OFFSET;
 	event->mmap2.start = addr;
-	event->mmap2.len   = usize ? ALIGN_8(csize) + usize : csize;
+	event->mmap2.len   = usize ? ALIGN_8((uint64_t)csize) + usize : (uint64_t)csize;
 	event->mmap2.pid   = pid;
 	event->mmap2.tid   = tid;
 	event->mmap2.ino   = st.st_ino;
@@ -612,7 +613,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 	char *filename;
 	size_t size;
 	struct stat st;
-	int usize;
+	uint64_t usize;
 	u16 idr_size;
 	int ret;
 	pid_t nspid, pid, tid;
@@ -761,6 +762,18 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, union jr_entry *jr)
 		return -1;
 
 	unwinding_data_size  = jr->prefix.total_size - sizeof(jr->unwinding);
+
+	/*
+	 * Validate sizes before allocating — jit_add_eh_frame_info()
+	 * computes unwinding_size - eh_frame_hdr_size and uses the
+	 * result as a buffer length for libelf.
+	 */
+	if (jr->unwinding.unwinding_size > unwinding_data_size ||
+	    jr->unwinding.eh_frame_hdr_size > jr->unwinding.unwinding_size) {
+		pr_warning("jitdump: invalid unwinding sizes in unwinding_info record\n");
+		return -1;
+	}
+
 	unwinding_data = malloc(unwinding_data_size);
 	if (!unwinding_data)
 		return -1;
-- 
2.55.0

