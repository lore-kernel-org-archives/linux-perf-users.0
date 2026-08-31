Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593A415B69;
	Mon, 31 Aug 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181922; cv=none; b=Vpx+3tQG2C9eNIYgd2Hyw/Sz/sPM+0sCFwvdK5AFPfvBF4jFXkRTC7LiCRQirNWjjoj7C0Q+HjmHB+ZPbaaHQjtaH7cn2K+kG2anrpdBszFETr77ZgJKWuma0lbVy/67bMM2dGV5O8CHc0Z9CstbKPR1HWyUixqjOSTuUWa7Ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181922; c=relaxed/simple;
	bh=/5KYpRSZZ4A+FSoqKWdzZPBZ4E8KAHVb+7eP8Tf4kGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEMi8d+488pFQDczat2iM+y2lycJfhv4eUAFImFe47qDxmhEE65aV8BrN3OlGTb7NpaGQuAufoMB5QUm5FYmQc7PHd9uncDadx8Le37Cm+dHx51RqcdJ6EwrcuyiP+YtwydeiQop0/ZXy9XGLf7sdvX2Auu28V6rZPzwETf92dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3xmVjdj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3xmVjdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6EA1F000E9;
	Mon, 31 Aug 2026 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181919;
	bh=zGvOqI1F59B/NBqV9bnLiOrTFhUb5hngXw19hg9wrKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d3xmVjdjUVA7H0mxk+W62zv9dNFDF9fKuLmpLSsBHyLPF7/Ms6T/QOdk9tJ9X3w3b
	 TmNGGrI21cXowAAQ31rtpTh6rEHgoQVVm5dOcaaTt7H40p41n1IT/1o/ds9ep2g+3l
	 6kJQBUVGYRFlSWCYxd/befeO0a7NGOCX3BFwfFV4HpQ2oT03EpcsqXZIk/lyTdwo+Z
	 PPmborqsE+qu/JU90fFBDJlswhgJF1ZLi9u3+WDUkga5YkzjcrVkYjhA7SiW6ua1VQ
	 pOjECtwEnkbVP/jI+La4UaoVz4vkyaerM5paPgR3K36rTF1spErsTsbgwlALiqd+kW
	 lPO17L6Yvhtow==
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
Subject: [PATCH 08/12] perf jitdump: Free event in jit_repipe_code_move()
Date: Mon, 31 Aug 2026 10:11:04 -0300
Message-ID: <20260831131110.4681-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831131110.4681-1-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_code_move() allocates a perf_event with calloc but never
frees it — the 'out' label exits with only perf_sample__exit().

The sibling function jit_repipe_code_load() correctly calls
free(event) at its out label.  Add the same free(event) to
jit_repipe_code_move().

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index ae63366b86c6d765..91aa1eea8229faac 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -685,6 +685,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 		build_id__mark_dso_hit(tool, event, &sample, jd->machine);
 out:
 	perf_sample__exit(&sample);
+	free(event);
 	return ret;
 }
 
-- 
2.55.0

