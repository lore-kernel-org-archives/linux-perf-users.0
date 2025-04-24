Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE96218838;
	Thu, 24 Apr 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525789; cv=none; b=PQ0QXMX9W1lnV/jGR/7mRwMiqdob+t/zOZQ9Oev4CLiMtBjoZIEg3P2OeAP0E5Nwm/SPExwEOHSv7KLmVtKNYdIp0w6XzviGj0OcKkcFH8s8RKI26XZgkTYducI6IX3jhb5BH9S2kwmGb/REaQVmRCuGxXcfQzq57cen2fbWAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525789; c=relaxed/simple;
	bh=fp29FQG7tCj2MT79QM0yn2AjFI3efyx4XK+jS6q+wv4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=g6FYrzGsRJSgvhHSEbTg9aSrzt7vUii99rqD2JH6Kq5OmPZmtzReBDHAK34KmWC0EV7wYpFEkepnFVTPTffyTXHNlEsMLLQITCte2TLve6LOe0N7WyUA1jXPO7wpPrgbRWUWB1XKI4cJ+wjMBx8batpWYkiepzy+twtrxhxc54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A6AC4AF60;
	Thu, 24 Apr 2025 20:16:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u831d-0000000H3wi-0Wkx;
	Thu, 24 Apr 2025 16:18:25 -0400
Message-ID: <20250424201824.978358670@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 16:15:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v5 09/12] unwind_user/sframe: Remove .sframe section on detected corruption
References: <20250424201511.921245242@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

To avoid continued attempted use of a bad .sframe section, remove it
on demand when the first sign of corruption is detected.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/sframe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 1a35615a361e..66b920441692 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -294,6 +294,10 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 	ret = __find_fre(sec, &fde, ip, frame);
 end:
 	user_read_access_end();
+
+	if (ret == -EFAULT)
+		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
+
 	return ret;
 }
 
-- 
2.47.2


