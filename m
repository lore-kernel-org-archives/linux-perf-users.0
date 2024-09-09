Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131C17C9E8;
	Mon,  9 Sep 2024 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725918173; cv=none; b=t8EQkQBEHuJGAdAGtajI5XHDOVnnirVk5Ra6MsCxXdrACdKDW/vyBQNFgApsmx+SqHuHObJhF7xrFnc+yGfcmLr14gGQaqTAglkKwbLINIguRMXNkZz+ONHw8NxS+q5T+ndSPRYwTaPiewebeSjxRa+x3K8kwMn2kgDqRGVWG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725918173; c=relaxed/simple;
	bh=4/kGAUMQ5ASuqDv3GlWIxRRu5r7eXxI4G0DXW4px4Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMtvoiCXldC0rGSyFzulM1MsqkjkPxIeKwtsMmDoNOftIgvp3UCaZSpakS8GiDqkBz8ZT0XUX0Mi8RSnVIIO5mVzv8zPX0f1WZXtIGQUkqWNb4xC3WBGs0znBbedNRFgPDtMVyZRnAmIzovRgNsrluNbAKojP8+5tlJoi1rf/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwj0lZHy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwj0lZHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B09C4CEC5;
	Mon,  9 Sep 2024 21:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725918172;
	bh=4/kGAUMQ5ASuqDv3GlWIxRRu5r7eXxI4G0DXW4px4Iw=;
	h=From:To:Cc:Subject:Date:From;
	b=nwj0lZHyPQ102GObjaKj6yw5nwp5tyhIjvDwEPVS79zOIGASzwbXlEMqkPiRjLqMc
	 +pXKL+wNPcxU/S9UZ/GvBfB0Gv0f56rXvpvbVY2v85m5LcdpobFO+wUt3GjJmhHV1B
	 7NQnfTd3tnK3RuUAt//YORvfvbVSQWGGtqvjtoXRUMjQHDdBCfGbpP54TUhltN78Vq
	 IrbVTKlEU1Qvo6ey1KU6cpbTGdPfeCFtnr6UCangfSMAnrMEGP17kXA7C9drceODEA
	 69qPEndY61FrTUiaZC58TwOeSbwUsB0QwAvI1bGfmpKVz3l9SKIPggvL7zCeqOm8JZ
	 VFhhaq3iGB9pw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf annotate: Treat 'call' instruction as stack operation
Date: Mon,  9 Sep 2024 14:42:50 -0700
Message-ID: <20240909214251.3033827-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found some portion of mem-store events sampled on CALL instruction
which has no memory access.  But it actually saves a return address
into stack.  It should be considered as a stack operation like RET
instruction.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4990c70b1794d7a9..1a347a711dcf5c62 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2474,6 +2474,7 @@ static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
 	if (arch__is(arch, "x86")) {
 		if (!strncmp(dl->ins.name, "push", 4) ||
 		    !strncmp(dl->ins.name, "pop", 3) ||
+		    !strncmp(dl->ins.name, "call", 4) ||
 		    !strncmp(dl->ins.name, "ret", 3))
 			return true;
 	}
-- 
2.46.0.598.g6f2099f65c-goog

