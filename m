Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48937BE60;
	Wed, 10 Jun 2026 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121208; cv=none; b=DSjhRVqiHYoi7JaCr+rNHKC8+iob9sVFTMG5UQXrFDuAda95NMD5yJoaqpXcto4tANfjT4pyqR5kT67o+D10KWL5lnMjUoyAJuep7C60F7BAI+aSM62RtXp4awOiO3QSlmM6H4ldm8ewq3O31/5JASodWdSajekFW0qSCkcvGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121208; c=relaxed/simple;
	bh=vjzno5/b6g27lurYaMq+MDNwXaEV4jX5dfMgM54WgrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8GatdV6a9Y6UMkcnGTgn6B/+5iivff76C3N76JTWsK6HeSMeYmk6j/tlYqKM/EupsNj7selqY6Dc8i6dENZq+fepEfebDafNT77he8I55U9WS9Mb+qYjiVgjljVNTQzvwYpJsftCI+dFwH3jxg35bppBvx+CeHiT4/lDbZJw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csKYzYs+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csKYzYs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BDA1F00898;
	Wed, 10 Jun 2026 19:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121207;
	bh=SQ8o+WE96JMrzzazKggnNeNvTGS7JtWkk6l3huHph7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=csKYzYs+Hl0suKV1xRMzWU1Lx/lQ5jFZDBJUNGA64mE/oCYZ1BaBjVtUjDdLyTU8I
	 cNamlBEpIIg9axnpHb2ETctqjdF7yAL05P/gRTrst5rF2Q3dDpj1lUbb0ZJN8sj/sP
	 lXd25KDk+EIPmQPYHNHs2Y6X+lNLj39InIjLfqF2yQJSyKPDUP5xNg2N4NdcFF6GpC
	 fUTQjCWrgts5WnqVvhBvJZptedti4l9UQrm2jhq9X5nAnFpfx5Nd0+MtRcBKMOClnd
	 EHAa7VX6uV3psJoudtQLJPu4+KEb0kKRozRGy2M8BhrtLztPq+KXUJqUzCPCZarmJ2
	 4AJSd4P1aBN1w==
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
Subject: [PATCH 16/23] perf tools: Use snprintf() in dso__read_running_kernel_build_id()
Date: Wed, 10 Jun 2026 16:51:49 -0300
Message-ID: <20260610195157.2091137-17-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

dso__read_running_kernel_build_id() uses sprintf() to format a sysfs
path from machine->root_dir into a PATH_MAX buffer.  If root_dir is
close to PATH_MAX in length, appending "/sys/kernel/notes" (18 bytes)
overflows the stack buffer.

Switch to snprintf() with sizeof(path) to prevent the overflow.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: cdd059d731eeb466 ("perf tools: Move dso_* related functions into dso object")
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 6a34717c9f31f18d..5d017975873817ec 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1779,7 +1779,7 @@ void dso__read_running_kernel_build_id(struct dso *dso, struct machine *machine)
 
 	if (machine__is_default_guest(machine))
 		return;
-	sprintf(path, "%s/sys/kernel/notes", machine->root_dir);
+	snprintf(path, sizeof(path), "%s/sys/kernel/notes", machine->root_dir);
 	sysfs__read_build_id(path, &bid);
 	dso__set_build_id(dso, &bid);
 }
-- 
2.54.0

