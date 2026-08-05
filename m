Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0821BC2A;
	Wed,  5 Aug 2026 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965283; cv=none; b=sqs8UPdl2bDnqhSrbuT30pkXJsS/3EFzwnUTslYs4S0tn1fwqvfKukd93YNJ1iuBCazw3AFCM8bEAHa80sFSmziH8AS577AkDduueGHsZXFM1XGeXOCx4Zp/j4gfLi6bc9jshQvizA0cuBWV/QtxyOEox7R7YJVkQ8SNwk97yfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965283; c=relaxed/simple;
	bh=XpzrkI/AxHUiRdfyTzZwu7rrNLNVt1IZLGOuFgGBLvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfWODtZlB7XABzfmvO/N2B93QMq//j9Zof5SRJjuifTLxO17+l9hNxcFa4UgIXoinOmmKWQCyNKHqPxdGftMe2pt/Lk/ueoRETFJmq02nvkCACVIyEJLcTEn2lEvx+wSD5WEffLfR24wUbNF8EoUuCpq7ubhqkOZ7oVlcBHPGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCLKdUUR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCLKdUUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE041F00A3A;
	Wed,  5 Aug 2026 21:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785965282;
	bh=46Q32NiiQU+GiIomMs6YY9FirnAhja+ozdHIENQBLbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bCLKdUURZsyIIfZZbh/ADlYJHIzpbFz04cmf5fybCSBzjVuMGOBR+vGKaz9nuo718
	 CPL7GnegNOrxjR2xlQejAUqOZPd/tWjO7qSS1e8zY4wWJviDXRBrrCiMe77/7WtS1K
	 ZYqjzGgaI3ou2WH5m8YCEQHvgrm6dd7pabCnplx+oZdG7B2AVQib1cG/8xSOpNl+9u
	 Wl2oeGRFKyX2mln8dNYicdZMzhI/yGTpqAelnVCGk6SN/dlE+n5uwlej7x6hPsPK3G
	 i11RcpYgD5T1wLjjaXzCAumoKCvbEe6F1Uw/3Zhd7WH2L5mb3t6YL4aIdOn68evF1v
	 nEaKP68z8vWFQ==
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
Subject: [PATCH 09/12] perf jitdump: Use dirname() return value in jit_open()
Date: Wed,  5 Aug 2026 18:26:59 -0300
Message-ID: <20260805212704.267779-10-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805212704.267779-1-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_open() calls dirname(jd->dir) but ignores the return value.  POSIX
says dirname() may return a pointer to internal static storage — glibc
does this when the path has no '/', returning "." from a static buffer
and leaving jd->dir unchanged with the original filename.

Capture the return value and copy it back to jd->dir when dirname()
returns a different pointer.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 91aa1eea8229faac..d3de307532d55065 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -146,6 +146,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 	ssize_t bs, bsz = 0;
 	void *n, *buf = NULL;
 	int ret, retval = -1;
+	char *dname;
 
 	nsinfo__mountns_enter(jd->nsi, &nsc);
 	jd->in = fopen(name, "r");
@@ -241,7 +242,9 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 	 */
 	strncpy(jd->dir, name, PATH_MAX - 1);
 	jd->dir[PATH_MAX - 1] = '\0';
-	dirname(jd->dir);
+	dname = dirname(jd->dir);
+	if (dname != jd->dir)
+		strlcpy(jd->dir, dname, sizeof(jd->dir));
 	free(buf);
 
 	return 0;
-- 
2.55.0

