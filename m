Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795829515;
	b=dHP2E82Bf7wzDGBeFc+YNRI53U0MVRWhXG8/0JNOC59OB/YzQtdewlLtI8xtjNKEkr2w
	 UJ1Jx+uVpDZLqsURVLpUcgkUJInKLLmgq6k2ElFRp0Ia123f3y3a5v3YfD3gDSbFZAdrW
	 xZmfIQqqHStFbU7AdS+u6lfHjqkjdtoXrSdv0zQGKOfSp5vJ3gq5/MgKPRF0qzjQkD65r
	 /j4GzpiSokebBDgjBDkkpjik5MKhdMdQUA6kIyBZI7HKEHX5F+9haHBd0Kw1ON3DMQ8m5
	 nET5QmXIBBZFLiAfW5rpdfijVj7n8S6/vRuiVabFIFokgZgfboIK/qkAR/vRivW1TxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795829515;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qG6NH2Oa/dn1BIGbF7vxSJ6enOoXEJUTUx9wkaGcorI=;
	b=dJNVP2KNOUSqu+eDCI2mF+Vmun88kpGWUNQfFYjPvDR7KFuVW8WoXl/EYCedRGq9/lwc
	 mQccmjcG/45NewyTRFDn77SRDsTVq1a6i2drQ4EAMWVJSTwFuVvlTW/jVDAnI3PL0Tbmz
	 pksd/oRXqPYFOJUvQ906wFw7Axifemy6l/LLWQOibGSZn424qugbkWITH6VTRi6oQ8b+j
	 kCY/6w2HC0nso7gMxL2azQpkt+fXIe7AyhZrRc/2cRDxN2WNpQsRN+59I81ZM9k+ismfF
	 A2zemXTpkqnIiUM+M6SGbA2XmCj5qJjf5HJytzd6PCBoVIWXf/e0lJP4zKZZGtGJHAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCIy4rpq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A900606A31C
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Nov 2026 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCIy4rpq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873ED1F000C1;
	Sat, 28 Nov 2026 01:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795829514;
	bh=qG6NH2Oa/dn1BIGbF7vxSJ6enOoXEJUTUx9wkaGcorI=;
	h=From:To:Cc:Subject:Date;
	b=RCIy4rpqLQpMrAiSx8nOHRrRWBFxg9DqltS+NTqzpE1LT5P2it/Ib24wp/q2O4riJ
	 0kTTbTbVKrG/eiQnQNiSd8L9fbOA6ubq6RRoWeat2pphu5XSs5dQtee61rNXjaSZ/o
	 0A1tU7rmjBYPlXsrQETZS6sna/pPo5BmYbOhG+VIxalb4RdDR5KnZug5LpcWIhDZkJ
	 UpJy4YFTIBNpPKGi8QffRyvvPu4yXYeQuPNaehY173kHUiq//UZgcRCMqRFdqzRSA4
	 v4x1w92zxSVi9KJ43cZiEpm5E8dYPoHMwM8GCoB+/rks60EWr4p5t28d98YaJK+hKN
	 DGQAfOXS+HjxA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] perf bpf_counter: Fix the 32-bit build
Date: Fri, 27 Nov 2026 22:31:44 -0300
Message-ID: <20261128013144.16600-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpffs hint added for the perf_event_attr map compares st.f_type with
BPF_FS_MAGIC.  On 32-bit glibc __fsword_t is int while BPF_FS_MAGIC is
unsigned int, so the comparison is a sign-compare warning:

  util/bpf_counter.c:394:43: error: comparison of integer expressions of
  different signedness: '__fsword_t' {aka 'int'} and 'unsigned int'
  [-Werror=sign-compare]

It is fatal where perf builds with WERROR=1, as the almalinux i386
images do; Debian builds with WERROR=0 and only warns, and Alpine's musl
defines f_type as unsigned long, so it does not warn at all.

Cast f_type to unsigned long, the form tools/bpf/bpftool/common.c uses,
which is warning-free on both 32 and 64-bit.

Fixes: 2ea09b93b4ca61c1 ("perf bpf_counter: Say why the perf_event_attr map can't be used")
Cc: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_counter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 9a463eb9d51d9b2f..6a1d9081f0db5b80 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -391,7 +391,7 @@ static void bperf_pin_hint(struct target *target, const char *path)
 
 	scnprintf(buf, sizeof(buf), "%s", path);
 	dir = dirname(buf);
-	if (statfs(dir, &st) || st.f_type == BPF_FS_MAGIC)
+	if (statfs(dir, &st) || (unsigned long)st.f_type == BPF_FS_MAGIC)
 		return;
 	if (target->attr_map)
 		pr_err("--bpf-attr-map: %s is not on bpffs\n", dir);
-- 
2.56.0

