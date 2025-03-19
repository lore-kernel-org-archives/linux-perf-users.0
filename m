Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338524EF6B
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360874; cv=none; b=YDXRbOLfmBbfX/k1GCuUS65DRqfkTc0MmoWRRvs2glUReEKbA3O50wfH06oFzxWoBlFk2NJBVrFvbXFQ83TucpJka/AlMkG8tKN9CLHSTqTP+dfkNGVYQasJTwue/uoDcY5mpUrBcOtxpmoUwuBKQiFWLkOPa/Sdl20H9BvOeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360874; c=relaxed/simple;
	bh=frBSFQZ/Cps1/nItEHHyP8IDRMMrZoSwqR8Wpo+tIRw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=if43AR4k4NkcAyjndtsGI9z7xzZ3gaeEvH1rD2d9VtE68GFpCdCw1h49aBE8eMnfQ6uYKDOqFSZ/RMJj/YPhAxFz+ipZ/Qy97JY2hm4AppOy+iswjpBMYi5i9RCwiXd9gX/Jct9nFl2GxVIOfV1BM3s9KDBsgiwFkvqgdN2jeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUkGQ2H4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUkGQ2H4"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fee461837cso90899937b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 22:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742360870; x=1742965670; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQUhpTPLVb6N2m+nc4ISL7gti6LwY0Os+AgxG8mcvpY=;
        b=LUkGQ2H4cjlVBGQGvaUwlgG2BcfTDkje+kpNdw6qlWJGGKr+boR7JSegZM15iUVjz4
         MEBwHEamP6ipQKCr6kWPgqqe5d8gQ7pIDYUN67DlMBs3xh7f0z6v2L24naSOJndRGE8p
         IZ/eVzS6AAALcW+CsxtxIjld+DNm/BKCua2XLjrpJ9CH9Yzu9utH4p4fXROJKdLX2sle
         x0zSoXZ17zv17C5j0qubZc541z9KkjQO5Prt7gJ9k7g94psUr64iORBv1lcB9T59jzf9
         rK4hU2zGVOzi9Tjvxg0SDlnK60R+XzsOqUZ23QJ1T7oHEouBQD1N7v2SZwyQfenyt3+h
         4RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360870; x=1742965670;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQUhpTPLVb6N2m+nc4ISL7gti6LwY0Os+AgxG8mcvpY=;
        b=s2L23JuZQ9/O2gCLQH5sUoKdZeP0SmgaiIPi+KuK4CIOsfh7wWDMPCxTg2wf4h49nb
         GoVhCS/SoFizsqA8yTWMtnI+bMm7HocSzgfMtMpKHMOeGTH2jyBEDfX/m+DOdLue9vc5
         Mb6QRjv/1Z4CnD+BKlPLeI/SWsQdqvypbJRGVl2dAwtntdOeJysh2jINPJ9l+jEln/Y3
         436DjPjmuDGZ9LL5JSN9meFoR3Dha8PPMCokbTP1AWX/i+cU+slD8lOwR5wZi/kUK4HZ
         jGAJz/s63fRF4QIZq+iaVVV+GTHi8rzeBBqSv/ATt1eDyqG3R9HpaFuFreTs2VVZuVnH
         AqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnAoGIVPVQTlgZMsz3cw13sq8r7t4RVyZwWNGsNfPB1O0NCHOuHVus7sTddTQWryqLqe8KAdi3eEG58Uo12Bjm@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhpQCGruXW1+5IHChHcgd/iZ87Zatn1AQTlvccV5qprpCqVEu
	WFyWG0HrrdoRq78XbgpLw8fRGaOnVrujek8sMR1qgY0m8LFv6MkhWM9BO1EveNWSyncoHMMjzME
	lQW2qFw==
X-Google-Smtp-Source: AGHT+IHOW262Yn1ggfPbRXiaD4JOO6KMlLE7LTu3k1LoYE6sevtUdiYlZtBYV3AOcRBRzOEXQI22siUbHecM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8a11:10b5:af90:6031])
 (user=irogers job=sendgmr) by 2002:a05:690c:6912:b0:6f9:98c3:a191 with SMTP
 id 00721157ae682-7009bf44550mr5967b3.2.1742360869976; Tue, 18 Mar 2025
 22:07:49 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:07:29 -0700
In-Reply-To: <20250319050741.269828-1-irogers@google.com>
Message-Id: <20250319050741.269828-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319050741.269828-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v7 02/14] perf dso: kernel-doc for enum dso_binary_type
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

There are many and non-obvious meanings to the dso_binary_type enum
values. Add kernel-doc to speed interpretting their meanings.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h | 57 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2cc1f6593f9e..53e3b9b337e5 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -20,31 +20,88 @@ struct perf_env;
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
+	/** @DSO_BINARY_TYPE__VMLINUX: Path to kernel /boot/vmlinux file. */
 	DSO_BINARY_TYPE__VMLINUX,
+	/** @DSO_BINARY_TYPE__GUEST_VMLINUX: Path to guest kernel /boot/vmlinux file. */
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
+	/**
+	 * @DSO_BINARY_TYPE__GNU_DEBUGDATA: MiniDebuginfo where a compressed
+	 * ELF file is placed in a .gnu_debugdata section.
+	 */
 	DSO_BINARY_TYPE__GNU_DEBUGDATA,
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
2.49.0.rc1.451.g8f38331e32-goog

