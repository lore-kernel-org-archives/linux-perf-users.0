Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326184137BC;
	Thu, 13 Aug 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633919; cv=none; b=WZ3Iu6xcNqAIW7L02tOiibXxhGINqQlAhfBknA9SWFadmNyxTqOSZct0ZiwLL3Y5IQwhOt2uZx9JMrPv1FU+xYQXROWjTLi5nxqYqUyk1rvYkxvN4KXGMeYxXck/B/ls1n9tyWKole2l/twXm7RwMQTmuM9+wbRiiVr7sb2IX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633919; c=relaxed/simple;
	bh=aRh6EkoeaT9q41QRhwaIiNb5jAqSXh/lG1c2HMltMOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUIyST7TqyK6uzo3qSa0zD536meCopzk9ke6qypWj0qkrCaDoR3Dfn4I0/AStpz8595pYreUAx6C5GgQhSm5e7yKNy+I3aHgMd0H2Yw7g8CsWHex1Gcp5qfMe/17HR6rnpHffyI65VPwya4bnK3H9a8C7aQNN3wlUz9+vzP6w/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ+ulL9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ+ulL9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CD11F000E9;
	Thu, 13 Aug 2026 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633917;
	bh=35exvK7MUvcpiE6snTYa6TbYnvczpFFN0RGnE5C80i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PQ+ulL9YvttMwZTZACQOIagvjbww2MfXexClTCQ+bDup1Zyc+hErztOZL90e/ssYa
	 jtUfdlWwc4N9AIMSmaMCyxKUjb2rKni+MM1fCG900q54QJyc8YGKNQjUhYUWVQ1rKY
	 9o7WcTjv9m9Sr+Xqd/GY4HPyMKX785qmgBC67xvk/rI1LD4hhMlX4yMc8VSuZlllSO
	 sIYQRiWvXiBMnFu2LVMpltglcocGTaMeF0CFYU+mibaVAWbtiNXnjS8QDRi+ICvFUC
	 OpC82LgEDFh5HFDePfXgPQm76G0rEcev7HcNkebjAGZn/sep2+h0T+BXE3QkttniNx
	 XYOKGRdUpjotg==
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
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 1/5] perf dso: Guard against errno==0 when dso__get_filename() returns NULL
Date: Thu, 13 Aug 2026 12:11:42 -0300
Message-ID: <20260813151148.23169-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813151148.23169-1-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

__open_dso() computes fd = -errno when dso__get_filename() returns NULL.
Some failure paths in dso__get_filename() (e.g. binary type mismatch)
return NULL without making a syscall, leaving errno at 0 from a prior
successful call.  fd = -0 = 0, which is stdin — subsequent code treats
it as a valid file descriptor.

Fall back to ENOENT when errno is 0, ensuring fd is always negative on
failure.

The forced ENOENT stays in errno for the callers that check it after a
negative fd.  It must not misdirect the try_to_open_dso() fallback
loop, though: dso__get_filename()'s chroot fallback used to accept a
stale ENOENT even when stat() succeeded on a non-regular file (e.g. a
directory).  Re-stat() there and only take the chroot path when
stat() actually failed with ENOENT [sashiko-bot review of PATCH 1/5].

Fixes: eba5102d2f0b ("perf tools: Add global list of opened dso objects")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 2309196d8df3111c..b86969dc6e81e96e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -582,9 +582,18 @@ static char *dso__get_filename(struct dso *dso, const char *root_dir,
 		goto out;
 
 	if (!is_regular_file(name)) {
+		struct stat st;
 		char *new_name;
 
-		if (errno != ENOENT || dso__nsinfo(dso) == NULL)
+		/*
+		 * errno only reflects the failure reason when stat() itself
+		 * failed: a successful stat() on a non-regular file (e.g. a
+		 * directory) leaves a stale errno, which a previous failed
+		 * iteration of the try_to_open_dso() fallback loop may have
+		 * set to ENOENT.
+		 */
+		if (stat(name, &st) == 0 || errno != ENOENT ||
+		    dso__nsinfo(dso) == NULL)
 			goto out;
 
 		new_name = dso__filename_with_chroot(dso, name);
@@ -640,10 +649,13 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 	mutex_lock(dso__lock(dso));
 
 	name = dso__get_filename(dso, machine ? machine->root_dir : "", &decomp);
-	if (name)
+	if (name) {
 		fd = do_open(name);
-	else
+	} else {
+		if (errno == 0)
+			errno = ENOENT;
 		fd = -errno;
+	}
 
 	if (decomp)
 		unlink(name);
-- 
2.55.0

