Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144C37C0E6;
	Wed, 10 Jun 2026 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121188; cv=none; b=i4OhQGlx1i02p1xNTfL35zsX0XRFRFOnSuoB/2G796pt7YCSsjXPFQL9NYcCYr0hvGgos/JD1h9nwT+6BR4Y+xkYp3nRWtecsVAEa+SYNagu29AuSdhBuORoCJtZ0kiPtLiZ2c61rDrlu61HR6YjZBs5ZXtAHRLwkOrU1Rf83DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121188; c=relaxed/simple;
	bh=+8XPQe1Y4G3gYkzSQUgluVBV493l2yWRMPBLtMvcfLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS79qGSbZXnULf7uSpJ4H48EP8hcXP6C4yeeHtgrWdtaLqwQ1U8Dn6B1+DVRyRxwrIUHt4tNkcoNeFCYZTVeQuHwM1nv31y3aPzIKB2GeNQJ8EdNtVr7FpE83hMXdLlKB2yJfzbPaSizzc0qoHGcj5Mb0KGOkRgv39LWnL4IM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE46ZsDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE46ZsDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D231F00899;
	Wed, 10 Jun 2026 19:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121187;
	bh=cSZ5kU4pTEcqxVD47lTugGIAYK1E5U/B002HFV83qew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nE46ZsDs+5LrA4sqLGfURmXCLAVVz2B5Zwn7SzDYHLn4J1v7OAaE3j0+ZqF3TF8Px
	 gw7zlJkfCZlOCdXRnQbbk5uRDvpbagrh70bbZhcqz5S8xPbYg4BD9uxvFgwy5umX60
	 zE3cdoPpEvMdhqH0jqV03ivNdwY3N5SrvcdnPNe8SYPwaCEBQtLhn7V8+i0eFQZyzq
	 4bJEEZAmYkYm1+gnR2eEw6YhXXTespb3bJsATuO1wJNzvALnWQ8n7cqDQVEgdvXH25
	 p/95rHxTiWv1nmac48iPXPKr2552O285B/UZfQmfC1tyqZukVwGVZ6GodHZS2KhUkj
	 2mz3Ol9fbxtbg==
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
Subject: [PATCH 12/23] perf symbols: Bounds-check descsz in sysfs__read_build_id() GNU fallback
Date: Wed, 10 Jun 2026 16:51:45 -0300
Message-ID: <20260610195157.2091137-13-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When sysfs__read_build_id() matches NT_GNU_BUILD_ID with the right
namesz but the name content is not "GNU", it falls back to reading
descsz bytes into the stack buffer bf[BUFSIZ]:

    } else if (read(fd, bf, descsz) != (ssize_t)descsz)

Unlike the else branch which validates namesz + descsz against
sizeof(bf), this path passes descsz directly to read() without any
bounds check.  A crafted sysfs file with a large n_descsz overflows
the 8192-byte stack buffer.

Add a descsz > sizeof(bf) check before the read, breaking out of
the loop on oversized values.

Fixes: e5a1845fc0aeca85 ("perf symbols: Split out util/symbol-elf.c")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 36a0304707e13138..06cfb84f86eb2f64 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -961,8 +961,13 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 					err = 0;
 					break;
 				}
-			} else if (read(fd, bf, descsz) != (ssize_t)descsz)
-				break;
+			} else {
+				/* descsz from untrusted file — clamp to buffer */
+				if (descsz > sizeof(bf))
+					break;
+				if (read(fd, bf, descsz) != (ssize_t)descsz)
+					break;
+			}
 		} else {
 			size_t n;
 
-- 
2.54.0

