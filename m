Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B691261B77;
	Tue, 21 Oct 2025 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007935; cv=none; b=hrjL1uur/P6rLTFT6/nVDGoyjHQdb3hDe7ORvIlrFvKdN58amSC0ujiZck37mc1dylSGHndg9Ex6g3OeSK4JaUbtgyckFrZaUq7vbhHhyqqNtbTakLhiWmRg0NDWwTV0AxGpRJ09jIpa26Q98vYwbJEoTEooWPV5QO/UobHNyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007935; c=relaxed/simple;
	bh=pEZ5P2P/pcsHQBwGmSCZzSbB6LsFpFMiLNyesbHEmAw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gSkQZeCNL4/u+FiOGbOZJN6zBIrYP4JtzOWlWxKggV1hxV2aBz6Blr5wGzM4t+i71jIkqR+rypcn0w45qWSTNG90Kua/QONUxGnj/EUZXmN5JLTcx5XpSCis41d5d0TjXv5XgrFcmNlaRyFzppt/1IZ1ygaqidshFRkZndn428I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUur1Vpl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUur1Vpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B654C113D0;
	Tue, 21 Oct 2025 00:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007933;
	bh=pEZ5P2P/pcsHQBwGmSCZzSbB6LsFpFMiLNyesbHEmAw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=qUur1VplDrg7z/4hVtbuujHIxBdApqOgB4inITEZKlwGnLqBpTe5+/mRAXo42kv8k
	 GC0mHUNf4e2bN18TddxT+Pc+QXhx6jTgEnzWVAYivYLkJPjsPCYN8okAuULbWSPsI9
	 lS9BDgGicym+xwiIMA+M39cu/O8O7DtqIz5wpBRHehkXQpTktqTANNeD6rqXIVr+My
	 hG1pZzUKiAdIuk9Tspc5lwtrAs22upOJyvlpJDL0jb5RtX9kKJevtoNzJEoESalBvL
	 t66A3aKax8WlxKYQSybj7B+77ST2Ji+KUSBAjChN6V8chmsrHa02W2qLk5ImO8LRPq
	 M71hqSt8RGVKg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vB0c6-000000020Ap-1eU2;
	Mon, 20 Oct 2025 20:52:34 -0400
Message-ID: <20251021005234.245481539@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 20 Oct 2025 20:52:07 -0400
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
Subject: [PATCH v4 12/13] tracing: Check for printable characters when printing field dyn
 strings
References: <20251021005155.705735078@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the "fields" option is enabled, it prints each trace event field
based on its type. But a dynamic array and a dynamic string can both have
a "char *" type. Printing it as a string can cause escape characters to be
printed and mess up the output of the trace.

For dynamic strings, test if there are any non-printable characters, and
if so, print both the string with the non printable characters as '.', and
the print the hex value of the array.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 97db0b0ccf3e..718b255b6fd8 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -950,7 +950,9 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 	int offset;
 	int len;
 	int ret;
+	int i;
 	void *pos;
+	char *str;
 
 	list_for_each_entry_reverse(field, head, link) {
 		trace_seq_printf(&iter->seq, " %s=", field->name);
@@ -977,8 +979,29 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 				trace_seq_puts(&iter->seq, "<OVERFLOW>");
 				break;
 			}
-			pos = (void *)iter->ent + offset;
-			trace_seq_printf(&iter->seq, "%.*s", len, (char *)pos);
+			str = (char *)iter->ent + offset;
+			/* Check if there's any non printable strings */
+			for (i = 0; i < len; i++) {
+				if (str[i] && !(isascii(str[i]) && isprint(str[i])))
+					break;
+			}
+			if (i < len) {
+				for (i = 0; i < len; i++) {
+					if (isascii(str[i]) && isprint(str[i]))
+						trace_seq_putc(&iter->seq, str[i]);
+					else
+						trace_seq_putc(&iter->seq, '.');
+				}
+				trace_seq_puts(&iter->seq, " (");
+				for (i = 0; i < len; i++) {
+					if (i)
+						trace_seq_putc(&iter->seq, ':');
+					trace_seq_printf(&iter->seq, "%02x", str[i]);
+				}
+				trace_seq_putc(&iter->seq, ')');
+			} else {
+				trace_seq_printf(&iter->seq, "%.*s", len, str);
+			}
 			break;
 		case FILTER_PTR_STRING:
 			if (!iter->fmt_size)
-- 
2.51.0


