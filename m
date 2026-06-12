Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD039A806;
	Fri, 12 Jun 2026 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303095; cv=none; b=qrJDgznZLKR2DBYAS+hdq5+FXNhr5v0VXZOlLHszcv1uYpnctfAjnICkYWvmgP5Nmq97QZhjZgxmcEcaKWN6mwggu0je7MqKrFS1E/YMdpADd1ogzOizzI2r2bq5L8eVr2hJLSg8bWES0VbsKgg2VYNh754jxj6x6lSJ/o6UBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303095; c=relaxed/simple;
	bh=ykNVuErbfJQg0B4bTh0qHB4ICh11BpKkRWG3Npn99Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWGjVa0SlXQG3ubeRqPrzJYc8rY0lA2vYDRg6ywa1B5fJkmh7252bZjHrNwF9rDa6PyO53psQbQAjGwIkYdAX8+1lNKJaIWobVZiAAUESEpg+3ogxJGKPwiUf2PwlriyJe+YyWLN99EYot9KG+DO283c/uhpIPIvXGFEMlMwqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9YbeMZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9YbeMZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F049B1F00A3A;
	Fri, 12 Jun 2026 22:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303094;
	bh=N+pSTo/Skue1syM+k/apN2oz+c3vwd5HAXXw71qySlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9YbeMZzLryDIdgqacmOOB2AVbpXkb5l3DdfdmKmu7oKD7WZF+OzBcoFFTUEdryju
	 yZBlJqo1Us55ROhd/+P8KPXiYSNPEM3WysjXOb0z1jghLqDGEJpiJCWq1GEvNM+CQx
	 kVt5IZsz5KdLtnCplLxp70HquiQCg/EcIsLxLEzk8qgQ8fdEKsj50gs5UjfDk65lHM
	 oAkwt3zR6L1jHSBkH3CdeL7eCtF9h13nXDNmIyVYUpdb8z28jfw/wGZtkVUYWcuYl/
	 QU135qWz3Cb1k+Six0nZLg2u8T47Nf7f1sZ62Rd/kCZd8d9sKqS2IRYoNvcQ9m/+YI
	 ABu+RFsRrJURg==
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
	Song Liu <songliubraving@fb.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 09/13] perf bpf: Validate func_info_rec_size and sub_id in synthesize_bpf_prog_name()
Date: Fri, 12 Jun 2026 19:24:08 -0300
Message-ID: <20260612222413.40791-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612222413.40791-1-acme@kernel.org>
References: <20260612222413.40791-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

synthesize_bpf_prog_name() computes a pointer into the func_info array
using sub_id * info->func_info_rec_size without validating either value.
Both come from perf.data and are untrusted:

- A func_info_rec_size smaller than sizeof(struct bpf_func_info) means
  the finfo pointer would reference a truncated entry, reading past it
  into adjacent data.

- A sub_id >= nr_func_info computes an offset past the func_info buffer,
  causing an out-of-bounds read.

Add bounds checks for both values before computing the pointer offset.
When validation fails, fall through to the non-BTF name path instead
of reading garbage.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: 7b612e291a5affb1 ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
Cc: Song Liu <songliubraving@fb.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index c4594969d7677238..fe6fbca508c5135c 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -143,7 +143,9 @@ static int synthesize_bpf_prog_name(char *buf, int size,
 	name_len = scnprintf(buf, size, "bpf_prog_");
 	name_len += snprintf_hex(buf + name_len, size - name_len,
 				 prog_tags[sub_id], BPF_TAG_SIZE);
-	if (btf) {
+	if (btf &&
+	    info->func_info_rec_size >= sizeof(*finfo) &&
+	    sub_id < info->nr_func_info) {
 		finfo = func_infos + sub_id * info->func_info_rec_size;
 		t = btf__type_by_id(btf, finfo->type_id);
 		if (t)
-- 
2.54.0

