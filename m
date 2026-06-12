Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634D348C74;
	Fri, 12 Jun 2026 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303076; cv=none; b=rny89UMDL1vauihxRbIH2j/h4u4puNfCmq1vtkgOXEB9Gq0VKWv6Huepb6apyQ5FQBYuutLPXPpuvWgq7aFiWfqUU8ir7EpkaRBlR07EzIf8JbHuMCUezWJeCBtAnzB7jytButMWvsm87vNJS2e77ycotlOttwP5v92BO2oASzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303076; c=relaxed/simple;
	bh=grMNwFOXXNL5IN3phtgHbd1T/m9s9l1wIdMHflI4Vng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbl3WisBHqlio83q1M3ZOrKrFVoLk6fDXduSXpayp0wLO4YGjNgI8kRHRgcEUBH2tiD1dnsB97PFlNbhMmYii3yF6S2/FkwdBMrJkk0awfrTa3BXL2pvVxxYN1OhFCLKiJS8TqI47sCpXCDisw7iIPTlfET+xRY9niFJENmPYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ6P8LOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ6P8LOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB111F000E9;
	Fri, 12 Jun 2026 22:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303075;
	bh=GiGBFzpO1ylgrt+PWStqSl1sLLmnXDZPZlagyG1SRsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QZ6P8LOKR0E6o0V6m2KHLToA/td/eu9MwnsT+0MWUmI1E3sw6FGRqgv3MRvQRHLPG
	 w+UHdZPYLn1nyFJ+GCtLhKlAGmm7FRjCVe54RgJGqJGSbDujy2VVXDo20PhpEZ+TbN
	 GFlk5Uj3XdCwHah8r6AnYIi9hXXNUGD0Ctx2wTNJ0lFxuE86rgESWQgUoqWLgiryCU
	 RqS4r72wHMfRObo6lEda26DNyugjX9L3Ax8uO813tNxZnnYV/CSnn57TGsskWJRP3U
	 yZKTATVaiXa7oph4qLwU81gCD7Kxn5knDB3d4+Wxi0bzggQGDTMSoFNa60iro49XGk
	 /nApFcqvcmJrA==
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
Subject: [PATCH 04/13] perf dso: Fix heap overflow in dso__get_filename() on decompressed path
Date: Fri, 12 Jun 2026 19:24:03 -0300
Message-ID: <20260612222413.40791-5-acme@kernel.org>
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

