Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408F3168E6;
	Sun, 26 Jul 2026 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109237; cv=none; b=r7xBG21d4xYzPvZCw0WdnryjZTgHyrbkapjdHdWTmWoF7b6A6iCuPFgEqZrD0STw+5p114Zted/lAI3zW8Kpm6p3tDqZna9LSZ+7m+6sIMbCjXKyQnlRMwdR30trLG2anNciZRUVgJDmrLUiLfpS89BhRY44YZjZpiGzmw9b6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109237; c=relaxed/simple;
	bh=Swwyc+lv7E/UYZIl8vJ+RJ6XhfgRoGvYjkLexW03ZCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4pVyo1747gO3wWLWJahGo2DYTb1g0UfZBlejWNEeC9YMKn0sPLEcAqxhK62Ms0rJxGDx3oJ7bMVb6mCpre9xTPnGwE5t/9aOhpN/4EOEDlKL0xNFz0gwRRnZfhOBRf3KskNxVrmz9/gDSQCJ7SOh1dT7ZE5TRERy3/zE7AGxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjRWL++0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjRWL++0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F73D1F00A3A;
	Sun, 26 Jul 2026 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109235;
	bh=lc+/StylU3eXCI6obAF0X3TU9QpvMoYh5teFEJQzdzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZjRWL++0B6prBFCOjBMtA2hTRWhZjTxbP42gt5GMWIdcCR7882tKHup9xGEl46C01
	 Fk4vGhIELQqBmwmkIGyX5O7Ml7yGslYoYVTsCogn1VylDU9Zh+rNP8ozZsox7tzxGW
	 1zeJyrTHFYVyf68+mA6lHF3l/cEY2CG5dxLOyLx4/Fmj6/W7f3YuSum9CeyK3Uqasy
	 8RGoeYFAcMF4GLeg4CyN0vJjbZxDnvEjN5tUe+jLS0+tAIeBQyaD6nmytMIt+FIKGk
	 a+61gEf23tVBRxLJ/nUekn3mohSMpSPgg5OuHQj4x812tMbIhvN6aDzAr3cNh4dEO+
	 JiiB0YSlE0LSQ==
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
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: [PATCH 5/8] perf machine: Don't abort guest map creation on first inaccessible dir
Date: Sun, 26 Jul 2026 20:40:11 -0300
Message-ID: <20260726234014.63111-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726234014.63111-1-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

machines__create_guest_kernel_maps() jumps to the failure label when one
guest directory's kallsyms file fails access(), skipping all remaining
valid guest directories.  An inaccessible directory is not fatal — other
guests may still be reachable.

Replace 'goto failure' with 'continue' so the loop processes all
directories, and remove the now-unreferenced failure label.

Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Zhang, Yanmin <yanmin_zhang@linux.intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 05724277c2a9753c..83d38637afe34fc9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1269,14 +1269,12 @@ int machines__create_guest_kernel_maps(struct machines *machines)
 			snprintf(path, sizeof(path), "%s/%s/proc/kallsyms",
 				 symbol_conf.guestmount,
 				 namelist[i]->d_name);
-			ret = access(path, R_OK);
-			if (ret) {
+			if (access(path, R_OK)) {
 				pr_debug("Can't access file %s\n", path);
-				goto failure;
+				continue;
 			}
 			machines__create_kernel_maps(machines, pid);
 		}
-failure:
 		free(namelist);
 	}
 
-- 
2.55.0

