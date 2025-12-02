Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B343016EA;
	Tue,  2 Dec 2025 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719843; cv=none; b=mQE6FMy0y+PKSVdQ4tooUqX8dykFgZzA2umR0tk5uXLtp68SJsRoBy1uH/dxnV9kBgMDrqscbDCrv8A3zdF5hfa/vYqn59WiA7XasuddRidYdpWiaorElenY632FvZgIYxDuRpe0H68kGtISmXvsNDGJmeE79rAobuZSzqv3oGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719843; c=relaxed/simple;
	bh=u8BfT8If8LDCssQXfgvXMm9u3S4LLnyCDuAH4of6+ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6u76ldpAq35JErOxYIcJwcu0yxldN3eMjiw6EA/KRQYqueC6UGvoZFVFDFEvKLbRcscFHfaRf4r5dTKIIalm65Z6joEGA9zgsO2wUOt9WIIxsp/JHjBhjDzI8bTEknecrM7md4MujT2ee6oFIK2/pvT9pLCt466XXG/L9S81Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ6B5yUt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ6B5yUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABD5C113D0;
	Tue,  2 Dec 2025 23:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764719842;
	bh=u8BfT8If8LDCssQXfgvXMm9u3S4LLnyCDuAH4of6+ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQ6B5yUt0oFRBw8s6xoTHHLJMzGYtU8hg/IbL7f80X9Iw+DefQvRg/exAXuTunqN8
	 6EpfFCPNsFG4f6dBpGbnvXwZT4uIR63QaGG4DU0eQg3g+fI7NkV+sKnGnrIu/vH8nY
	 Cryex/b4tIv/PLD8YiwgZQoV9wziu4j2zvZUwfmCkfUZWs+w5SG0Km130N2Y1dBWma
	 ErBUVby4L8f/5CBK4glCN78ITeXbCZNwCbAu2u9eCqKb6V4iKMInLs7oQ+EsyyfYbE
	 9i+/iOSmGSIiXzr3Q2MNjgeRnVv4bZUusUz3Hd5m8xSNIB752icxeh7QeHsiC9QzJO
	 Wo1NCNiRmjBjQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/5] perf tools: Mark split kallsyms DSOs as loaded
Date: Tue,  2 Dec 2025 15:57:14 -0800
Message-ID: <20251202235718.1018752-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202235718.1018752-1-namhyung@kernel.org>
References: <20251202235718.1018752-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maps__split_kallsyms() will split symbols to module DSOs if it comes
from a module.  It also handled some unusual kernel symbols after modules
by creating new kernel maps like "[kernel].0".

But they are pseudo DSOs to have those unexpected symbols.  They should
not be considered as unloaded kernel DSOs.  Otherwise the dso__load()
for them will end up calling dso__load_kallsyms() and then
maps__split_kallsyms() again and again.

Fixes: 2e538c4a1847291cf ("perf tools: Improve kernel/modules symbol lookup")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d8fc5ea77f849326..5a38435d90c96092 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -972,6 +972,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 
 			dso__set_kernel(ndso, dso__kernel(dso));
+			dso__set_loaded(ndso);
 
 			curr_map = map__new2(pos->start, ndso);
 			if (curr_map == NULL) {
-- 
2.52.0.158.g65b55ccf14-goog

