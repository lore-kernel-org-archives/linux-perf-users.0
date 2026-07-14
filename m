Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFF331EA9
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053922; cv=none; b=hvNVsjeHkQ2fSsS36lkwEB5Uj1ODg9L0wGzskFyCnXnBlWRlBj4oZPw5jUE93kvr9L9LUjYIdXjRfM7QpahpolOd8OTukwMmcfN5f8StU9msZJ/eYy/4omB6AgHvA3sU3o0yef8Ozr5I+cfNJwuLZMC3CXdlPOwXw65Xix0dVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053922; c=relaxed/simple;
	bh=VjO/40vwtlEqoqa0MWjtEwISafs1DuSDXBphWFAVeM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1yK2N3Yhzoyd2PCdlw8UVozOaBewNUgVhV2M9cOxSbQY68qnstEGmtpJf3ZaPclLHHbw/7NhJGw8lchDhv11WwDDWLICEBphbtnaEwrbmBLyUY5IVjQTBQ1d/E6fdWQA7lFXWP3Kay4hUjtkN81cUy8JbclaPrzvMfxV3PMgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU2gdJms; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU2gdJms"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so15674866d6.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053919; x=1784658719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KwQ36ycy2027O2OnXTT+jaKQ0lX0IY/IjFba+f+HbbQ=;
        b=MU2gdJmsxzKlkum3NlI0Bt6u3MFh3Ge5SRJ6lQACJSbB9X94H807fYOy5FY9pHzcLk
         FAPshpyZbymGqiTrfInEYL+xJM6h/oaOOpjzr1etSvudNc5wz42NKh2EA02P52g8NJ/X
         Vz8ujfqLmPfBh3LaLE/6h9bj/JEwNDdrLPpoFVuoZiGB2o/izJeNX70lG6X6gJsBGKQG
         oO+O2JmhN7hUbkx/eE6O3VuTqbwhj0OotnbPsIYddQnQu7cNIj+14bmB7zPHDYpY569J
         aaDJHcM0taT1bB8QAmbad63CSfgofVa6PXb0YdjckVRWTbaSsv/euNsp6FtUFy6fywaj
         dD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053919; x=1784658719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KwQ36ycy2027O2OnXTT+jaKQ0lX0IY/IjFba+f+HbbQ=;
        b=jG3SgvLY8scvrlnoKvWeC+mPtFV7Ot82vrztz5TpXcROSm04wvbj2fZ0Zp8xEXp59L
         I5WgJoRzqr1YwDEwTcwS/Vl8J0bwciSnEvdnMaezu5B5sK+nG+CLMX7ehvEthQ7Apj7W
         z5FFdcX2P+yoHMh7CGJXo6eUWHk4F4pqm8fjWlvS4Hz6L/qVF3/xFJNdwzjU9qfgLXTC
         O1YTxwCOjyHsAUx9eD2RElkFrCTJOAaEV5670TM0s66UXYJLWUUGoPUVLDg1HQWb7oKe
         +4iESVUIcVT2B9DwMY/QcQZqUhAaMwYC/InI8PdDLd6lGh8FqbfCTJ0MM+C5XVcr/6Ix
         jqdw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7X+460+EtNPuc2ak+znqZvYWwm0doRYcohopVXAsyUwa418w9btp918GeDVQP6oYv7jaJjoahFtuH5dZ0waYt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrmm1scV8F1L4TfEBYOWo8lUQKgfRFkLvLR/ELgxrI4MUEa7Vj
	kEc5Q6ybcnbVEpZzYdlY8OSBmK9gYrTQkq2Hbip8/AMoqjC12t+bZHkr
X-Gm-Gg: AfdE7cm81DvxVfUJvk6a6p9QyoMVQKhBPvaXYgRaXAzWmIiBQ1TzMdxUOyw3dn95TaL
	rKL6z5s6OYIM32y7p5UJlLeSLbwwsQfAHRD2kPVIcOywWYxfidPMHvoYgOkUUUig76d+a5zkTqs
	yRrREUFB1lMMxy9cVUS5idn+s8Qml/8zpp3ENGwcIMYDnqzbeHjJ2xjw4fRJvN++HnJUyICCxLs
	PD18fFQoOO36KPu8pqzr42D3CEvxAlzJkedxNpcUNza85OIifYKjw9wMwszwhERgbYBNhLg2K3g
	Jon5pqm/FacheJQgKeSBywb/CGxFg7Ek0Wx9OUMDsXbZcpzr3GxM3WFV8VjDxGB1nzdn1uaSd65
	JP9So4Jbjhb07QPCKpDH/lC4GTk7rhKufr5AKVPumqvJdANykDlV93WHMqZ6aZshJnO/9R8aHKe
	p7kEffJZqcjdIMtg1JkrC34UfhyAYz7d7gI5gjVmxUKIbJBVeK3rgV9DSQyuo2WA==
X-Received: by 2002:a05:6214:3d0f:b0:8cc:ea7f:d3c8 with SMTP id 6a1803df08f44-90401578bbbmr161798496d6.30.1784053918640;
        Tue, 14 Jul 2026 11:31:58 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87cacb8sm178386286d6.49.2026.07.14.11.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:31:58 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 07/13] stacktrace: export stack_trace_save_regs()
Date: Wed, 15 Jul 2026 02:31:46 +0800
Message-ID: <20260714183146.12598-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
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

