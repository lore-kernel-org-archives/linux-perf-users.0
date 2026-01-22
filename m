Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92597480948
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067125; cv=none; b=JvZ3zBvXB2VFfFU1N+Ch6bCvjhcsSW51x+CM12VnIZ/u/iQzLJQZ2FjMwZj97t4nZpTrgr9nP4J1+DSXm/BpoBM18nfGwqpwIWRXWukNChXNCSNXsmTNB+MP8jbTPOIh16drzSpuxlqiIUuqtuKdN8uYj98QD4OK0UP0zbWD88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067125; c=relaxed/simple;
	bh=DNIcWZ9QKgcap8GIm+HHaS7sytvjKF8lN4kZaGLyU7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rtz+19CbzncliBeFIHhjiQT+RXYP5gKjZOcSkrR1dbkHrMQtwyXBf1LB17eAdlU8MxmwxmMHHbppin/BfPcAZeC5farypo0FzoFVqmqbHvCQ3X/J+uxBtrXPtLkNYeXlFBrkgmKU+Da3kqI7D13+lyEQ7un6PwvblUsHRGJIy7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBP2E3Lh; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBP2E3Lh"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b70bd4a2ccso3470486eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 23:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769067111; x=1769671911; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zuXMW9ePaQZdk+//RX5ln7bDZ0bQbPZ3cyiYbZ9aMU=;
        b=eBP2E3LhxPuLiiomYidfhRD5YnCikVSMXJDNq6u0DW0jTf0Hj55j3eVI0w2pLzUdEP
         x30GY4kf5rhzrRPAGGTXsa1N0BkolrdePWtdH/xJ88P/jigSUCAcXPTTCTeDsONfOIgq
         gn+Bv5htAmVL4SH7lbiT3wAWzeQNs/IddrdAE4siOBXQ4fAEutZQsOyYBNgu5saGn8SO
         w7kqVIyspOuE2Ya/45DGqzMA/hxd985wxXBBMM6jKDka/cIp/BdtP3ZZ/qBB6rbamCN6
         uis34HZUiHUY5X847R0H2pAAIwRtZekgmvQBntQw8WSm6XZ8OOSICGWvQoxb6bTzdL0Z
         ug5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067111; x=1769671911;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zuXMW9ePaQZdk+//RX5ln7bDZ0bQbPZ3cyiYbZ9aMU=;
        b=G1s1/diDxJ0Xl11RqViCGApuPC6KRbWe/+F4te7+EuqOlmVE4/qHxIQCI/c3ww6C4Q
         wmijL/+P2RXJBASh3LWSB9lTuzpjQzSV/sYSVlvA/Cq/1MuCR/84CW8WNGGRmfx55lKi
         lw3Zyr91jN3uzD5ZHFlF14TPlbdr1j1XtPU1jbToivQ/HBfGz7z9v0Wn2MICWEaaL+9t
         4y2sl0mjmNls6+mp8rnUokaO49mZUlzboErnc7CrPXrGbL+pdALYWLq+QHAQeyZzMHtr
         cFe3jpQfx5nXN6XPWSsT/N9nfxcv7N/zn6i0U7tiuS9w0nwcw0Bu20SGbS/Ax8FdcWGM
         TkOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR5Y/itwU3eXJL0gGU2kG/WznyEYY6ysKtFufAItXpi+5OetGvL9LQbt+w2jBuWIJoTxh2c0Ewl8gFkn55BOQU@vger.kernel.org
X-Gm-Message-State: AOJu0YyYmwSWr1UL+EDz+Mx1EGiUf5OUf2qNG0Z9DHMtswEhEUiWUqYd
	3XsgbONAX/BriA3IaF28YDxwmmV+vcse92bgsjfYe9EkcRvvOoWqct++2kOXZV8/ZpwNnA1U8Jd
	+xO1PJKFbQA==
X-Received: from dycoz10.prod.google.com ([2002:a05:7301:fc8a:b0:2b7:2358:5b16])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4350:b0:2b7:f7f:6ad
 with SMTP id 5a478bee46e88-2b70f7f09f8mr3795608eec.26.1769067110372; Wed, 21
 Jan 2026 23:31:50 -0800 (PST)
Date: Wed, 21 Jan 2026 23:31:27 -0800
In-Reply-To: <20260122073127.375139-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122073127.375139-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122073127.375139-12-irogers@google.com>
Subject: [PATCH v1 11/11] perf disasm: Minor layout tweaks for struct arch
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Pack some holes to bring down the overall struct size from 96 to 88
bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 2793d48aa04e..6a1905f9d4fc 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -18,22 +18,22 @@ struct type_state;
 struct disasm_line;
 
 struct e_machine_and_e_flags {
-	uint16_t e_machine;
 	uint32_t e_flags;
+	uint16_t e_machine;
 };
 
 struct arch {
-	/** @id: ELF machine and flags associated with arch. */
-	struct e_machine_and_e_flags id;
 	/** @name: name such as "x86" or "powerpc". */
 	const char		*name;
 	const struct ins	*instructions;
 	size_t			nr_instructions;
 	size_t			nr_instructions_allocated;
-	bool			sorted_instructions;
 	const char		*insn_suffix;
 	unsigned int		model;
 	unsigned int		family;
+	/** @id: ELF machine and flags associated with arch. */
+	struct e_machine_and_e_flags id;
+	bool			sorted_instructions;
 	struct		{
 		char comment_char;
 		char skip_functions_char;
-- 
2.52.0.457.g6b5491de43-goog

