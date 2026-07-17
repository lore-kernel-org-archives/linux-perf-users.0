Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C403FC5D3
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293515; cv=none; b=UUEwcNTXaeI5qaU+llJSGyyp6pr1+FzHZ+YC+rgMtF3EdovxP10ZJukl/fa3cujlIRpzdj6nAeWRk/y4y10ucnD3kDWQWfUjChS4AE4E/Qu40mXdo2IKUn7VGjUOZQcRC/ovfdrKHnvNZbiEeEG6BuBg4yHy1XHUjJs7xS9PBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293515; c=relaxed/simple;
	bh=VjO/40vwtlEqoqa0MWjtEwISafs1DuSDXBphWFAVeM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFiMv1LE8xGHnO9/jFvvPNdgQkxfA5BZIQchnzZpJfyJrTClVeB7MUX6ujpsB79mBfCpPVkFl5Yu6rDyxfXguYaHxWiaAOdl3LoA3X1okFhD9DMIB2Vfprs+gkDKFS1T7C4y0NALFitIv+QZ3YywRFZw13XgvIX4Pap68PQIzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWATUe54; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWATUe54"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc891373e0so93707425ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293513; x=1784898313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KwQ36ycy2027O2OnXTT+jaKQ0lX0IY/IjFba+f+HbbQ=;
        b=oWATUe54S8qnYmiuOKIynXwkaD4LAHPfEbVj3jj/WIW82VnTmhBeB+KgqRpCGeqlxF
         zPyByHOu/OutpIdkdjnxxaG1iqlKEANYR2gwViXsr0XYfKYU9i8hJnNhkMKCFkob4Yon
         Ru5eMt+zMlp58uIQmYtt5RHC9kym1R59wQ/1knr9c45Gd1zoZVI5LUY9G6TstxWzqNzb
         R7NksC181gf20fARAEmBI2LSuMCDN++WrMjhEYy7IR6RyCgT8HWfLZ2qVDarBXDeF/eF
         0K6romtYiqad2VVJSoFQmCG6nA6w/8ElI7BKn9rKCHMhjYbHkO895zFboKsjin9YkDgc
         uvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293513; x=1784898313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KwQ36ycy2027O2OnXTT+jaKQ0lX0IY/IjFba+f+HbbQ=;
        b=bdy0262FRqdshl9MnRjl+v5RbtZ3FV5gorptMlRT1REIVUwcu4IRzXO8EyslgtT3ZH
         HYnK795Vm1oaHPXNf9yXLWobJPBz8BSmd/e2VMc9qm/KIa2Cd2S+GDrc4PpYfpfer4wF
         hWmDmv5E5ptKUpc7xlA/h3XdkYOayAosZiv67NtrhUIl0AIl7l5QE5AoFAiDstpgqaKs
         2DUfvolSlGl9tW1GEm2inX7GZ6pv0ybqOw2eMSjvuPS5d59+/6o6yXwdFN6o+gsPY8Af
         36qAz7jO2v8ERwnyLdmjLb/jqg3NKQuOYD/pTDvNP89uFNwawQlIIE9uPo558YKJefs3
         We7A==
X-Forwarded-Encrypted: i=1; AHgh+RpZyv6UjXOCXV1r6Qzal6xJ1QspSCrl/udUGa/7btWpopzzgoYihyQRlJzOPIkNYGx3dyjlhgKLmSx9GXXDcBpi@vger.kernel.org
X-Gm-Message-State: AOJu0YwD5ADwNLlQzqrLDFEeYUsiE4c/DiK2lkdRA8NKCeA2t4EjyRA7
	r/mAD2NE6zxhNTKAYp9oqvzTdW1oB1q1QDbNpzJzkehs/gc+IHY9mzZ1
X-Gm-Gg: AfdE7cn3DBcPkWoO/slFXbo2IZEzkAIVquKpdjbtNpO/OgNRfleTeqX1X0eNG3KNpBP
	tRgl2al4M8OKQI28dJQjJbLELj3rKxL05iXUQVIXoPadnpYSDS7oJFIBhBsA7NrpAADlr4hAXzX
	1CFglKKcN0rIFxfq8m9sATxAk0ypBEPAznRZCqNQ6F1k83rEdsbxUX1IGIc0lDmRvMHNIIkQyj+
	W/PNgpWNKAG83+Nk6qDh6ANbt8Ipm1A3g83xfahx5KZzZ36Qzm9XYb2PumI1y76ghTeYBC+xoZW
	g9WVXmMU6j9XEndoTv4HkZoCYaY/0MlLrgXh6Sm26n32XytvIr4VENo3/FCeTH75SqxUMuDNfgk
	z6srTC8DS+9PRbJiytVkVx5XB6mjJYJQA+z0vvCiHealsw8xpUIL1qu4OtsqJelrtdE+3YxeGbE
	VCGQ==
X-Received: by 2002:a17:902:d509:b0:2c9:cf62:6f61 with SMTP id d9443c01a7336-2cf348b264cmr25931005ad.17.1784293512798;
        Fri, 17 Jul 2026 06:05:12 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb6e8sm5156012c88.9.2026.07.17.06.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:05:11 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH v2 07/13] stacktrace: export stack_trace_save_regs()
Date: Fri, 17 Jul 2026 09:04:54 -0400
Message-ID: <20260717130454.1902704-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The other stack_trace_save_*() flavours are exported, but the regs
variant is not, so no module can capture a stack trace for a given
pt_regs. KWatch, which may be built as a module, uses it to record
who wrote to a watched address from the hardware breakpoint handler.
Export it like its siblings.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/stacktrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index afb3c116da91..d853c40f916b 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -175,6 +175,7 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 	arch_stack_walk(consume_entry, &c, current, regs);
 	return c.len;
 }
+EXPORT_SYMBOL_GPL(stack_trace_save_regs);
 
 #ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
 /**
@@ -325,6 +326,7 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 	save_stack_trace_regs(regs, &trace);
 	return trace.nr_entries;
 }
+EXPORT_SYMBOL_GPL(stack_trace_save_regs);
 
 #ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
 /**
-- 
2.53.0

