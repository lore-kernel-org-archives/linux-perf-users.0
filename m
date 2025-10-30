Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF391DF26E;
	Thu, 30 Oct 2025 03:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761794823; cv=none; b=GFH4jsSUGEpcZ4xvBtgd4W/MKJ06WbwKl5dbl9XZWRNuZfZ2BDemZraBeicnL3f1GVGca2KpsNN50EVZTsp2765ibYRmcAaKRfRT1puSgvGvg4btAp/eN//IZLIjNllAv7dO+PfQbFl7BFBCDj+lR4u3irUHIw908istMmoOCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761794823; c=relaxed/simple;
	bh=SXphE1jLb3wFqppQoQld5Ohr8cF1oZ+XHL4zOmC+eaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FR/dfjCbhwAELcUckgIH/Qvv5LdT0xNiCBxk3zk6oLqLlHBq4SZqhX9zzTW+S0UNcorVuLGkvsABwo9xVE7Q1l5oXASpT6fNT7h8IqSTZrBE3XxkgP2esPRrsp5PQOU/ei9H5M81Cw2cUSp928c2Iz35jGxV56zJQfld2W+Ct/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBmo+LXx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBmo+LXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE832C4CEF7;
	Thu, 30 Oct 2025 03:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761794821;
	bh=SXphE1jLb3wFqppQoQld5Ohr8cF1oZ+XHL4zOmC+eaY=;
	h=From:To:Cc:Subject:Date:From;
	b=bBmo+LXxow5I0N6qpT9R/QuwAxPhEshiyPu0zMuSx9Qbn7LrqwmqpddNzoxbMzFhU
	 GAaQjEyvIlUShsJt5pOE1ItbzdjWRyNzEYQDdO9WhUbvNsqbusibIVKZD6zcu9KU6V
	 1IhcreS+wb/Yka2S3C7EF3QWd6cT0giccnWMS8oM22PDzH1e9EA8DWT7DaHY/mqCPH
	 EuK9zOm7XsKEo/MjW20tH1ersojv1O81vS5PtkAfjdCiHxmt/yL29MFLQY4Od/HPy3
	 SMFcM3BPmptPJj9LmP9jSB7SvMoaxGOoOMUfq734bJv511Pbxd+N9xw2Y/fq+rGkuC
	 KiwFjYoymWPcA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] tracing/wprobe: Fix to avoid inifinite watchpoint exception on arm64
Date: Thu, 30 Oct 2025 12:26:55 +0900
Message-ID: <176179481538.959775.12326313742393696258.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here are patches which fixes a wprobe bug reported by Mark Brown on
arm64[1]. The root cause was that the infinite watchpoint exception on
the same instruction, because arm64 watchpoint exception happens before
the memory access has done, it needs to configure a single-step after
calling overflow handler. It does that only for the default overflow
handlers, and not for custom overflow handler registered via
hw_breakpoint interface.

[1] https://lore.kernel.org/all/aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk/

To fix this issue, this series introduces default_overflow_compatible
flag in the perf_event and use it for identifying default overflow
handlers instead of checking handler functions everytime[1/2], and
set it in wprobe[2/2].

Thank you,

---

Masami Hiramatsu (Google) (2):
      perf: Introduce default_overflow_compatible flag
      tracing: wprobe: Make wprobe_handler default overflow_handler compatible


 include/linux/perf_event.h  |    9 ++-------
 kernel/events/core.c        |    2 ++
 kernel/trace/trace_wprobe.c |    7 +++++++
 3 files changed, 11 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
