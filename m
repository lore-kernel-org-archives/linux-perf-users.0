Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9F2264DC;
	Thu, 30 Oct 2025 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761794834; cv=none; b=JXeqPZ73rPGRC1Ldh+CXQD95PoIJi03B1T3hppXbk+/paec00LzcYZ8DAbkpOfkXbBtW9kE7kmn6s1SPBkeHLBZF1m4fB7HdyKf3ajufnP1PE7Fko/gtbv1jPrSuKwunfmYIMFbibzoD4GbaoyBuR0HfKzERVpOKJuFKRlRt8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761794834; c=relaxed/simple;
	bh=cfhICDAycpdcZ0C2xlkyCdUlNHCGdRQjBFptHTiR07c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGE7PQVirZfKXz8/LRtR22JGKq0vq0w1hRWKFPk0vkd3ITYhcNqVR3c6ViiRjQlvInQKc43TqsFmDSDMA7KdsGiW+48I66U9LoPLSMjj9ZqGw/pbutPexyhRwP9oNdrFTG/AlBHLlz4JCk9sng9FMHEGMWFGn++nmhcuKlGj9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3leZ3EQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3leZ3EQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6686C4CEFF;
	Thu, 30 Oct 2025 03:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761794833;
	bh=cfhICDAycpdcZ0C2xlkyCdUlNHCGdRQjBFptHTiR07c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3leZ3EQv52ijoBcpC1BDyWPH5QcmZcnGd0YsDnPcBk8E4QDQXA1B4Iny+PMY0mNF
	 evV8c9vtjwD693qQKwKaiueOvg2jyFVsgl53UpUzbdv8fFHjdXrQUQ2dsFm4ohwRfs
	 AQUa/IPdbPamjlgf2YNgY0LZ5mWDnQ9n/UuuV3XEyPcbqt/DPrdJwmHHbz77nHJctX
	 YBH0qaEA9otp/en9y/CiPWivt6DjAJh+MNhI9Xu9+fOjpeslkEh8PyvjE7WnMjHrVe
	 eRTvWTFNvkQ/rMxLnksAkgvoFu53//RxqInaxN/RM2V/lQpn5Vp43T8n/CCmy3zRsX
	 vMuVJZ5sIBsTw==
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
Subject: [PATCH 1/2] perf: Introduce default_overflow_compatible flag
Date: Thu, 30 Oct 2025 12:27:07 +0900
Message-ID: <176179482721.959775.9568162681903659824.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176179481538.959775.12326313742393696258.stgit@devnote2>
References: <176179481538.959775.12326313742393696258.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Instead of checking whether event->overflow_handler everytime in
is_default_overflow_handler(), just use a flag to check it once when
registering the handler.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/perf_event.h |    9 ++-------
 kernel/events/core.c       |    2 ++
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b99..40dd897e26b0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -902,6 +902,7 @@ struct perf_event {
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
+	bool				default_overflow_compatible;
 	struct bpf_prog			*prog;
 	u64				bpf_cookie;
 
@@ -1505,13 +1506,7 @@ extern int perf_event_output(struct perf_event *event,
 static inline bool
 is_default_overflow_handler(struct perf_event *event)
 {
-	perf_overflow_handler_t overflow_handler = event->overflow_handler;
-
-	if (likely(overflow_handler == perf_event_output_forward))
-		return true;
-	if (unlikely(overflow_handler == perf_event_output_backward))
-		return true;
-	return false;
+	return event->default_overflow_compatible;
 }
 
 extern void
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 177e57c1a362..6bbbde82cb21 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12946,9 +12946,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	} else if (is_write_backward(event)){
 		event->overflow_handler = perf_event_output_backward;
 		event->overflow_handler_context = NULL;
+		event->default_overflow_compatible = true;
 	} else {
 		event->overflow_handler = perf_event_output_forward;
 		event->overflow_handler_context = NULL;
+		event->default_overflow_compatible = true;
 	}
 
 	perf_event__state_init(event);

