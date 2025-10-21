Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55323BF80;
	Tue, 21 Oct 2025 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007933; cv=none; b=ENVEy93Yez15xZDTaYJDeDmDeIoJHs0SXNthZqYTaZ/me8lONLz6eaDWc5e3T6WGzs71bjpCJRUl+KZWShYKcLcHv35crL3DcPlA5IeN4C1k6vhyxiR2MQvIkFskYyGBbon3JLtJcOp5anc45ylFaqW+ylcCPKyN/BjPO53y8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007933; c=relaxed/simple;
	bh=Lp/sEkMZsE67tXH+Ndy0qtN++BL6+DdO3Q5iet8yKzg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=slIzflE1VzE1NNNniCqgqweMw/7owKgsSIPUQddNoufZNJrEp1epsGCBPq6N/JGuLEXfVLFEUXyWLkEn0rx0kPt+6QRw8yIRcU5KZX1QsMbsf2THL4TJF+RKaHdjjNDFByK1fwImVYPakZG5shlvFH1i9eTLc1l5zr8Zwc+9p/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCkz0ajO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCkz0ajO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B75AC19425;
	Tue, 21 Oct 2025 00:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007933;
	bh=Lp/sEkMZsE67tXH+Ndy0qtN++BL6+DdO3Q5iet8yKzg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=FCkz0ajOYx1JsxoNEvay3KaNQNoX0vYdqkxsjqhQfenvUI0oYf0l2uy9yoVv52XIL
	 pQuLvwlu/gV1PgffsSHGuN1YlB94z9GFTUgic8sqEYfrZHYYmAp9gfzO3/maOpFjxL
	 a3tXEm5Bzym1pQx3Nvfa7sipAy0N04qI/Z2iOc/qEIpaJQ7WsveLO4nsmlVYCfJI3v
	 QUg1+AgH3RoHNa9I0r6nQQCb5gSWzAtz66ca81azXNpA4/Jxpl7u9SLDG86qDHNbsX
	 HRln9QyUiVajprN8T0P4JpkSTVfdg/7u51X43ROgv9TloG8lKNGVID7MO9JmCMCPVn
	 3z06e0RVwWXfw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vB0c6-0000000209q-0FTW;
	Mon, 20 Oct 2025 20:52:34 -0400
Message-ID: <20251021005233.915557358@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 20 Oct 2025 20:52:05 -0400
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
Subject: [PATCH v4 10/13] tracing: Add trace_seq_pop() and seq_buf_pop()
References: <20251021005155.705735078@kernel.org>
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


