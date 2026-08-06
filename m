Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF9233955;
	Thu,  6 Aug 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019821; cv=none; b=sTMlTu+7ux+Bbqfurt2VZghVF2hlXgIYz5yWCuOk2ttbfkhK4h7PMCMqR4nM9ZRBfId8XMbYX2dmw26jTEL4nIXucIum3KXfMD0/c0Pmaeog6zSXjOLw9QF2XBbd0mLAceMMIbemWFsPKPjYlLAIrFeMIzvnWbDvXq+IVlHH3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019821; c=relaxed/simple;
	bh=XpzrkI/AxHUiRdfyTzZwu7rrNLNVt1IZLGOuFgGBLvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZqTwLO3cRpruhrikq1mbc6Q/Rp+9YxQ7OZsA7d/74aA87A1th1SFMbtiWbLOMBBQ4F+hp39hVVeec9aseU3AAxIJGaVEVF9NrCWHnIL8S78vpPc+lHjSq3OTzAq+oOP9B68ijhe1GESjB2TB39fxVwM8hJm5t8zYgB93pHz1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2asDk11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2asDk11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8341F00A3A;
	Thu,  6 Aug 2026 12:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019820;
	bh=46Q32NiiQU+GiIomMs6YY9FirnAhja+ozdHIENQBLbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G2asDk11TtXjQ54eziAkkgkh7KcnT+pgQ8XB41iFr+S3xx4cnKs8ukRzUo6lcl5TO
	 q2JymGnB2XB5QeMJge422qcsQe7AzuOHddxscNYJiEN2GDwjoN4KI/tmkvpoOLVrv0
	 KN9x01s0U90mxolo9uC6k9nsQHHQTHVk1YUiCJPwRevlmN6C1Hcjv2pG888X8Lyxao
	 nTNl5F6N7Zn/CdwIFIjki2iB8y09WeDqGkeMIYEY3l1tpOt0iLrw+a2cDF1E6ifj29
	 HFVtIb1/aOwDuU/Lm35t0wp57a6mjlY1ILTe/bWLV6c9siCdWY9EdCpbc4BNTd85Ak
	 N50fEgoo5eosw==
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
Date: Thu,  6 Aug 2026 09:36:00 -0300
Message-ID: <20260806123604.271277-10-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806123604.271277-1-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
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

