Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AE27B35F;
	Fri, 12 Jun 2026 00:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224542; cv=none; b=ex3X/l7oTza2CmGz+ILbf3mIBv0oLL0esvSikJ8hNaVnhLjThy4NR7Si9pjC5G+WQ5KvWmqP9z3IpbFXV7w0Y8ybkKuPKGfwZIzohEkII1l8S64vWJjSncSkZD0ClbdRmwmbZYx9oQsznyFt/p0u8sXl/cjZ84MPVd7UFBR1+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224542; c=relaxed/simple;
	bh=+6JaWrJ4iYQzg7eXzGi6/vMHqUpYgAZPzmfdfjpBfVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPksT0AOxmqNoALt8CFF9FblPdVw0itLh5l24HzafarDs7VMsquUARrtJP1UCUSSZT0IJfSroKapIcBAto/Gtc4Ckp02HxEWkI+wKIEU+kho2Tj38zRBeBoi9uH8qAXfEu/FGP6o5yGk0v/48An4mGJm0Rsf55HlKBiSatpf/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8JltjQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8JltjQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83901F00A3D;
	Fri, 12 Jun 2026 00:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224541;
	bh=qzTzsD/ccVOr8cDLM4jg2BBitA/CpaStF8lfTIgjIOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X8JltjQjy2w+caVvn9QOIbyBcSY6d7FvQCq8dPp0e7lFfHjwuOx6f0jCZOryliqvM
	 xp8KRfpvacz5UxJ0nbdQt/0Mick5Y0sADHuvUhLu6gzjqaIvnJA0pO9YjnJt2HYEuT
	 GJloYwsSzZnxpb59Blg4LY3qow+XwL6Phz6VBy/EEM97b3E1hkipLqGyiK+OzYTmuq
	 mk6wgXFgjOnMX2WkUHjK92VUzc/z94ydDDB/ToQBdmjHLW/lg07M9WM8XB0vxVWZLu
	 i2dKPMMT+Pln+qfV9861+jEbBM/Wyl3fCct3ER3j9W/L0SpUFVCui3dRMcglH4Sptx
	 PNuVSQZXfLt0w==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 13/15] perf c2c: Free format list entries when releasing c2c hist entries
Date: Thu, 11 Jun 2026 21:34:41 -0300
Message-ID: <20260612003444.50723-14-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

c2c_hists__init() calls hpp_list__parse() which allocates and registers
format entries on hists->list.  When c2c_he_free() destroys a c2c hist
entry, it deletes the histogram entries and frees the hists container but
never unregisters the format list entries, leaking them.

Call perf_hpp__reset_output_field() before freeing the hists to properly
unregister and free all format entries.

Fixes: f485e33c4543ac31 ("perf c2c report: Add cacheline hists processing")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/finding/41
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e205f58b2f3d3786..07c7e8fb315e6cf3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -185,6 +185,7 @@ static void c2c_he_free(void *he)
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	if (c2c_he->hists) {
 		hists__delete_entries(&c2c_he->hists->hists);
+		perf_hpp__reset_output_field(&c2c_he->hists->list);
 		zfree(&c2c_he->hists);
 	}
 
-- 
2.54.0

