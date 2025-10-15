Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664803009C3;
	Wed, 15 Oct 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549741; cv=none; b=LM7Ix3iAIxqHCk9EsUfBxKSlDDbimuUEtizbIoZaaGltXuiNpdFa6JhARh4oXMIMIG1s1B8fsfyD0x5x4+dqWuHKPAV4H7rYo71wHY+oyu4Ce5rpZwQx5Rd/1ze6fyLVl4YRN0ft+XuHTg13evyC6rapOUzF5L0KNWJVVqfowg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549741; c=relaxed/simple;
	bh=Lp/sEkMZsE67tXH+Ndy0qtN++BL6+DdO3Q5iet8yKzg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GTy3dIbc7paUXW97WCKQbg/iuZ6QlgxE9JlEGPdVZo6DAq38uaTaIGAQFw2x2E9FIZFyUyHr2ZW7aEi1sWZLTxYsJ64pFSoVl5N0IPWGa/fJJItEosFgmCZBwBYDZtJmNA94LcQ0p1gT7dgws/qdf68b3HauzH+EmH11G7K++4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6BQSnx7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6BQSnx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46158C4AF0F;
	Wed, 15 Oct 2025 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760549741;
	bh=Lp/sEkMZsE67tXH+Ndy0qtN++BL6+DdO3Q5iet8yKzg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=N6BQSnx7nuOHvqs5wYNBp481nlJlAJxPgCzjFV3x5jrM4Lvk3DiLw2Caum/NwIPz+
	 RCXD+Kp40XCseiaB7M1e+9Y/ELZoSIl+3jmgbWrhdnVC0UPsr9KvoWHHbwaat1bT+0
	 oNPOl3C55OXG/wlgI8NxaOunNk3Xb9RT9Zajjj4d44FmJ4rlsWM0vdM7waqEJSN26D
	 jx9EdsSb6z+C6cDNsi3SkguxsCCbCwEyz+VL8y/B7Gc9hELkPWJalYL5k1LHoXEBdt
	 GEKtKPdtn5d+yFfrfV9e4eeunENJ0sIDbpCo2LgDeE1dLV4gEzNVnJTg6PzYFe+sDH
	 HPMvBtmq/Su8g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v95Ph-000000011zv-3eYm;
	Wed, 15 Oct 2025 13:35:49 -0400
Message-ID: <20251015173549.717572718@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 15 Oct 2025 13:32:24 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 10/13] tracing: Add trace_seq_pop() and seq_buf_pop()
References: <20251015173214.760495866@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to allow an interface to remove an added character from the
trace_seq and seq_buf descriptors, add helper functions trace_seq_pop()
and seq_buf_pop().

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/seq_buf.h   | 17 +++++++++++++++++
 include/linux/trace_seq.h | 13 +++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 52791e070506..9f2839e73f8a 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -149,6 +149,23 @@ static inline void seq_buf_commit(struct seq_buf *s, int num)
 	}
 }
 
+/**
+ * seq_buf_pop - pop off the last written character
+ * @s: the seq_buf handle
+ *
+ * Removes the last written character to the seq_buf @s.
+ *
+ * Returns the last character or -1 if it is empty.
+ */
+static inline int seq_buf_pop(struct seq_buf *s)
+{
+	if (!s->len)
+		return -1;
+
+	s->len--;
+	return (unsigned int)s->buffer[s->len];
+}
+
 extern __printf(2, 3)
 int seq_buf_printf(struct seq_buf *s, const char *fmt, ...);
 extern __printf(2, 0)
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 557780fe1c77..4a0b8c172d27 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -80,6 +80,19 @@ static inline bool trace_seq_has_overflowed(struct trace_seq *s)
 	return s->full || seq_buf_has_overflowed(&s->seq);
 }
 
+/**
+ * trace_seq_pop - pop off the last written character
+ * @s: trace sequence descriptor
+ *
+ * Removes the last written character to the trace_seq @s.
+ *
+ * Returns the last character or -1 if it is empty.
+ */
+static inline int trace_seq_pop(struct trace_seq *s)
+{
+	return seq_buf_pop(&s->seq);
+}
+
 /*
  * Currently only defined when tracing is enabled.
  */
-- 
2.51.0


