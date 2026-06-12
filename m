Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE926FA7A;
	Fri, 12 Jun 2026 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224511; cv=none; b=qVx5JdVBrpScmYUVAk8el+d4sWJduOguzTBnazqZSgJoNG3VzPms+WqhbcR5fVobMRYKHcGiMXJgIFNXZXj/pX1PpcgfBUU1leeR/I1Flf3shIFJ8iop8wzujzABQIhL9oAlYc2d7JZEWjNwm2Ly9EmG6uyVQU7luQuLzpt+fAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224511; c=relaxed/simple;
	bh=grMNwFOXXNL5IN3phtgHbd1T/m9s9l1wIdMHflI4Vng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDvQJZDlH6rVn0YTOP1dS1otzZqW6SBY259PlLYotZJrJrxx+ENptqtmgzVJrA0RdRJvUdcA5S966617Vx2v6Yqd1ugvsBMzvSd65F6KJoQwXHTtrDALYxWvM56yjGU9qrw7LnrsYTynFqfX5nw4V//aQ3r9ALObtk9u2F8+0G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOHYi2kR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOHYi2kR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB891F00A3A;
	Fri, 12 Jun 2026 00:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224509;
	bh=GiGBFzpO1ylgrt+PWStqSl1sLLmnXDZPZlagyG1SRsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IOHYi2kROEvQ9HXQNHIXaynS/kOmnKqeTyZVCLyOjT8LSK6XqvMr+qXBQTZp0HAtd
	 d8Phm+j9jIIJzX8aRW8nqUiQzO6RXTuA4ZJiYxtV2sMcB6bIaDN4dibqGTFkT+1ZRw
	 CEf2e6vETL0cE3NQ1+5r6RlYRBhHTSnT8SxelfO1KfY3Of5O8ID9E/sdvJEU6UgVVn
	 wej2ZgFGWjXQyqT1gUCwbRWP+eKeYiJ9It6DdPJgk8SnoHqfRsdGJfbdYALdSpFv5n
	 VG92XFlihNnFm2uq86mCcDnjVSGhRYf9+veTCOsebXz2eGkfmw8nh7zFluu1jefwoV
	 lhory/BkElC0g==
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
Subject: [PATCH 05/15] perf dso: Fix heap overflow in dso__get_filename() on decompressed path
Date: Thu, 11 Jun 2026 21:34:33 -0300
Message-ID: <20260612003444.50723-6-acme@kernel.org>
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

dso__get_filename() allocates name with malloc(PATH_MAX), but the
dso__filename_with_chroot() path replaces name with an asprintf'd
exact-size string (e.g. 8 bytes for "/a/b.ko").  When the DSO needs
decompression, dso__decompress_kmodule_path() writes the temp path
("/tmp/perf-kmod-XXXXXX", 22 bytes) into newpath, and strcpy(name,
newpath) overflows the smaller allocation.

Replace the strcpy with strdup(newpath) + free(name) so the buffer
is always correctly sized for its content.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: 1d6b3c9ba756a513 ("perf tools: Decompress kernel module when reading DSO data")
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5d017975873817ec..511921bd901d8145 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -603,8 +603,15 @@ static char *dso__get_filename(struct dso *dso, const char *root_dir,
 
 		/* empty pathname means file wasn't actually compressed */
 		if (newpath[0] != '\0') {
+			char *tmp = strdup(newpath);
+
+			if (!tmp) {
+				unlink(newpath);
+				goto out;
+			}
+			free(name);
+			name = tmp;
 			*decomp = true;
-			strcpy(name, newpath);
 		}
 	}
 	return name;
-- 
2.54.0

