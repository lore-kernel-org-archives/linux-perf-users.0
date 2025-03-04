Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E891F463C
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064667; cv=none; b=WTHNYX05s6NKyRhxoMkl5/Fg/9ufaIXgbCOdh57S+5yzbzpfdhMfz0pANWUiEsFtawpM+AD8nywajPI+RzDlLHOrdyJIcE3AKMJ55S4+4ULVJYyMO4nfOUuIbeG8vPA4Vf0B9jhmNG3mIhq9vv3av4OCBQP5eSYsOt99Dol2BEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064667; c=relaxed/simple;
	bh=VObIbXvNiOXZ2A26WPwA6ryfoH0OsJHPNB+VKe1oCko=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=grUaC6f2HVAvvp7G5QAVWEAmtn19e3sT83vR/XzoE2JQLD7e2kgOQBIzM0JTVwhfsaVHjpCNNvx3cFBxzZX5/Pe+Z11jbG5QbyNuHLV5fnwjUOC9+JrjbUVsGf+4kfdIB2ySWqdNp4zYw73WS3JNuGva63gZttimseIMgrBGoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kUy0OM5c; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUy0OM5c"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f4348c854eso73734677b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Mar 2025 21:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064664; x=1741669464; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RooX/a1L/gN+cCpm6Vaaaao4SOz80PE9RgB3MUQjLDM=;
        b=kUy0OM5cXRlWoNaTBXcRHPzRAR+i/9mensjsVzFeoetsVYhmnJe67E/19vO5QPmaLM
         ucHUj5yaF4Rh6275pkrGTAdRu2h0i07ijJKXn+z7zi0WaMzugRxzlfpLgTcPVHVIX38s
         G/Ka5XzeuLiBGoLCZJK3UkdW2GfHsCB5tia/0zCKao4TWtHXC2zu7NA/WPBxjrnUAiRp
         rRlxefSlK6ctYhuRbt+64D3yYUP9Bm9wuYM+VLXPyJhNStcNeXT1IAa+PZPY45/9VGTX
         qXdwRVOxvZPszTO7NsdkGoCQjftRg04HtSZtksL+TCmoWixg2KbqUw8JHQq1cqPLxs2j
         4heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064664; x=1741669464;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RooX/a1L/gN+cCpm6Vaaaao4SOz80PE9RgB3MUQjLDM=;
        b=pyDRpzuazuBPLp2HzqIOwjxaPwW9AvoMs0TVh51ZQDb/NMisMt7sxBdr5SWdKy1kcl
         w+/hRWVj9CWxJXMKQzj4a8bkmJN08LbfiYPxwZHY/+mwcksF96SOAjiu4iWh9+jjHtdW
         I9xWZgTJr6rnv665tpX/V+pRDxjC6zRvZY1NYsy2e8VNdVAqPuO1z+ZKvOxqGOF1gk4Y
         37OM6Z4jN3nOuOfv2MMrjlTG17Lai9XS7wTGe24nw8sCn9V9oAmJH0AsJRCQiCFNV5gR
         pVYu4YAL71MRty3isTyfN5ncF2iyWbLrJHuAccyszB2Z1jjkrSVbhYn19FP7Sr0I3ted
         VcFw==
X-Forwarded-Encrypted: i=1; AJvYcCV73dnh7C4G9Up+4r20w/ZYTv0O1hnZJKZQisCBl5NXZmXn3YYWTvOo6015k6/xKewk6ren36yYgfAsiP7BDXJ7@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdkKVeBHFkL/sX3bTp18/D4Q3xSQ183lHi4VZYjkwTcO9MLRT
	TiQt7oRNX8F4z0SzhJ4lqw+BRjymFDt4TkvgnMnKR76Cr/uM9yRXMoE+BY598hOj/pjii7czuMW
	HhjaqCA==
X-Google-Smtp-Source: AGHT+IG3yNBru/BEal+JHj6gpTw7WWV7bMPlNKRyQ75L1lFhUhgIq9tcGynnWiw/AZRUqqBDOAjsD1m6WuHZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a05:690c:4248:b0:6fd:359a:8fc3 with SMTP
 id 00721157ae682-6fd4a0d2f2cmr9335197b3.4.1741064664475; Mon, 03 Mar 2025
 21:04:24 -0800 (PST)
Date: Mon,  3 Mar 2025 21:02:56 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 02/11] perf dso: kernel-doc for enum dso_binary_type
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

There are many and non-obvious meanings to the dso_binary_type enum
values. Add kernel-doc to speed interpretting their meanings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index dfd763a0bd9d..f3ca2a5e7670 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -20,30 +20,83 @@ struct perf_env;
 #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
 #define DSO__NAME_KCORE		"[kernel.kcore]"
 
+/**
+ * enum dso_binary_type - The kind of DSO generally associated with a memory
+ *                        region (struct map).
+ */
 enum dso_binary_type {
+	/** @DSO_BINARY_TYPE__KALLSYMS: Symbols from /proc/kallsyms file. */
 	DSO_BINARY_TYPE__KALLSYMS = 0,
+	/** @DSO_BINARY_TYPE__GUEST_KALLSYMS: Guest /proc/kallsyms file. */
 	DSO_BINARY_TYPE__GUEST_KALLSYMS,
+	/** @DSO_BINARY_TYPE__VMLINUX: Path to guest kernel /boot/vmlinux file. */
 	DSO_BINARY_TYPE__VMLINUX,
+	/** @DSO_BINARY_TYPE__GUEST_VMLINUX: Path to kernel /boot/vmlinux file. */
 	DSO_BINARY_TYPE__GUEST_VMLINUX,
+	/** @DSO_BINARY_TYPE__JAVA_JIT: Symbols from /tmp/perf.map file. */
 	DSO_BINARY_TYPE__JAVA_JIT,
+	/**
+	 * @DSO_BINARY_TYPE__DEBUGLINK: Debug file readable from the file path
+	 * in the .gnu_debuglink ELF section of the dso.
+	 */
 	DSO_BINARY_TYPE__DEBUGLINK,
+	/**
+	 * @DSO_BINARY_TYPE__BUILD_ID_CACHE: File named after buildid located in
+	 * the buildid cache with an elf filename.
+	 */
 	DSO_BINARY_TYPE__BUILD_ID_CACHE,
+	/**
+	 * @DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO: File named after buildid
+	 * located in the buildid cache with a debug filename.
+	 */
 	DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO,
+	/**
+	 * @DSO_BINARY_TYPE__FEDORA_DEBUGINFO: Debug file in /usr/lib/debug
+	 * with .debug suffix.
+	 */
 	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
+	/** @DSO_BINARY_TYPE__UBUNTU_DEBUGINFO: Debug file in /usr/lib/debug. */
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
+	/**
+	 * @DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO: dso__long_name debuginfo
+	 * file in /usr/lib/debug/lib rather than the expected
+	 * /usr/lib/debug/usr/lib.
+	 */
 	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
+	/**
+	 * @DSO_BINARY_TYPE__BUILDID_DEBUGINFO: File named after buildid located
+	 * in /usr/lib/debug/.build-id/.
+	 */
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+	/** @DSO_BINARY_TYPE__SYSTEM_PATH_DSO: A regular executable/shared-object file. */
 	DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
+	/** @DSO_BINARY_TYPE__GUEST_KMODULE: Guest kernel module .ko file. */
 	DSO_BINARY_TYPE__GUEST_KMODULE,
+	/** @DSO_BINARY_TYPE__GUEST_KMODULE_COMP: Guest kernel module .ko.gz file. */
 	DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
+	/** @DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE: Kernel module .ko file. */
 	DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE,
+	/** @DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP: Kernel module .ko.gz file. */
 	DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP,
+	/** @DSO_BINARY_TYPE__KCORE: /proc/kcore file. */
 	DSO_BINARY_TYPE__KCORE,
+	/** @DSO_BINARY_TYPE__GUEST_KCORE: Guest /proc/kcore file. */
 	DSO_BINARY_TYPE__GUEST_KCORE,
+	/**
+	 * @DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO: Openembedded/Yocto -dbg
+	 * package debug info.
+	 */
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+	/** @DSO_BINARY_TYPE__BPF_PROG_INFO: jitted BPF code. */
 	DSO_BINARY_TYPE__BPF_PROG_INFO,
+	/** @DSO_BINARY_TYPE__BPF_IMAGE: jitted BPF trampoline or dispatcher code. */
 	DSO_BINARY_TYPE__BPF_IMAGE,
+	/**
+	 * @DSO_BINARY_TYPE__OOL: out of line code such as kprobe-replaced
+	 * instructions or optimized kprobes or ftrace trampolines.
+	 */
 	DSO_BINARY_TYPE__OOL,
+	/** @DSO_BINARY_TYPE__NOT_FOUND: Unknown DSO kind. */
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
-- 
2.48.1.711.g2feabab25a-goog

