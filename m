Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4F36C230;
	Tue, 28 Oct 2025 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693070; cv=none; b=O+68cmto4neJmJmz+l2nN4vA34N4CxpwMr7wz5ZOZeHxfkRO5cHZLbFsfy3M6xEbZMt5F9t6YaCS+806KFWO0SZLqMWsPsyFzRdvj7y9yK044w/QKTKAZG5Oa+0hsvXJtsI2hdyVve3njGwSOarKbwI+LvnD3JKBZXQn92yge7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693070; c=relaxed/simple;
	bh=pEZ5P2P/pcsHQBwGmSCZzSbB6LsFpFMiLNyesbHEmAw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fzcmG4Kc5j8nCAkjWl5WFveIZsNU5HUDAnPeYLBedmCL0C8aE8lWemdBlrV0WdIUV67kF7KC4BiciRtUgNz4HhNooheZEhib7ITPT1ZsaScFB8jw3xPuT4BXntAmKpEGJq84EK+hl+N4vmzBveAsAvx5qHtGdXP2GgfkvDfjFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9/TnuhV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9/TnuhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE146C116C6;
	Tue, 28 Oct 2025 23:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761693069;
	bh=pEZ5P2P/pcsHQBwGmSCZzSbB6LsFpFMiLNyesbHEmAw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Z9/TnuhVpyEh5iCmXDPSB7UJwa0bGZ3dErdVZXPMUFQ/46iS7BhNsn6//oOpg0vjB
	 a/4HRxmyL/sZSCoWUob17jNv1P2uE3CJ1XtfZRvd0GR0rrhafmlrpqtqYjkDOfYDdl
	 meo92kG0SYzJ4YDlWXCqHyHzkXRl7p48yGiyfRkEWu+djRcWQGDyjeKTjgsb+nMDLm
	 Dw0C0CPo7GKd2ny6W0IIZHok4eFx20fLvgCP0zc9AL10yO32Gh9SExom4sQAll9g29
	 M7kzVUYxRSYig6YvrslIBlTzx+OfTAzlS+CP2wADRiTWakzP6YiOd20PUvpSatlPvo
	 nZX9TYpUnf9lg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDsqz-00000004quf-0KOC;
	Tue, 28 Oct 2025 19:11:49 -0400
Message-ID: <20251028231148.929243047@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 28 Oct 2025 19:11:26 -0400
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
Subject: [PATCH v5 12/13] tracing: Check for printable characters when printing field dyn
 strings
References: <20251028231114.820213884@kernel.org>
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


