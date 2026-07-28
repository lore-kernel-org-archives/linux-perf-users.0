Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF146F4B8
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271348; cv=none; b=MwP5UlaQRYRZbm2dXFvqTjCbl0gp2kIOynpGKChPPwnRKhH8YCpJp1NaLgKgrxy/9qcgtVNYDlnrdxN4zKGiFATLOYzNrMz8h9dvqfwnbQ3rnfsRX/iXeGe5+i5C1HBm5LtmO/n/AZXly/qPb3M0+k0E53FIlPvItKB3Gwc7FDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271348; c=relaxed/simple;
	bh=vtwEJPeB3XSeziXiic+4w9Nt+pag5cz+X4V7fDhugMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jx+/m+/n/mCd2TdZUnD32CW19Im8zMPPtdGKN4Miu72Ka8p/RLMkN8/Q0/D6Rk0pj69eOJ7DWOYVEAc5r+uLwn1lHmBBdXVZxQUrgPv2VXsdtQREAes1jmsj6/Vi64HGWjdsHBet3Oj7NMW+cLea3GKbh5bdbmNro0UUJelQqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bo7Gfgta; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bo7Gfgta"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49558ce01afso1765325e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 13:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785271345; x=1785876145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=neJwsrreenqN9sr1ylLIXFSbq0W3o0rmjNfXzSlyrAA=;
        b=bo7Gfgta7jABHTUjkY7qGi9R6VGx2sYnWSNzJLI55vBKOB4pr/UCYeV3k0GmR3lO8a
         vvpLOz+OR+qoU/H1XskmI2R2CgKdDscUQXYMKn/XQSpnKH19cwqNgUkKgmaoq0A82kvS
         9ckI17Ho6XW0gZe2ZT9cXtPb3jK7wNCigxnDklJcsEd6CrNioO/RTHtqhcZ46y/SinqR
         bzMQG7sHmLRisvjVXsgBo8ju9H+0wTga32PZRIdnN8yoOf5CMyCwBIHjyFLO0tr3NdVb
         atVHm84kIpzI2VyJu0W0IzM97PF9rLOY9gtMICnBYnMID0vx2y8jWV1AUFiK59T8otDW
         n8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785271345; x=1785876145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=neJwsrreenqN9sr1ylLIXFSbq0W3o0rmjNfXzSlyrAA=;
        b=lpuafgzNizICWuCwy5S7ayrOpvx37RUGljEO+mqshQzB8CLdRfRtkTenh+6aJHtxBs
         qa0uvqr6n/+c49kHUcQe/+OEkVFRP3uqRTYj+Boa7fYLXL2FvlkRpWdhwRGp/b+He1x8
         yg+5l847fvWXAg15CfLCEXmm2atp1kZ1W9bLOFTCUqe4vFeukrfL2QV03Xl/C1vSB3lM
         Ip3sSM2hlaKccLEjaBpt9km3PamuIKg1dZ3ebRp8mOUDoSTQfwTSasD2kYNX15cegkK1
         /CdzXx0LxrgK0SSyI6VJRoYaqGs2evgQXsviIXnN/dIOtCADtAjVB2AZEW6UWpkkVtV+
         /+0A==
X-Forwarded-Encrypted: i=1; AHgh+RrA9fRz1MIwGZkHkTBzK6FXek/08BkFYbfAb0IFh7ngKgapMuj1BDFOgneNobXO3KTEKFQfIkyL/erR8EWuhvL9@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3D85hdFH+qipq7fBDfHw02s1f+b3vebFN7DpTPcckrvbhJrF
	v0Kq9ZYH2pt+tn+29OguwMsmGY9XWjngHO15+nkp7+HJXnG1XC7d7/dyGt/lmufejWY=
X-Gm-Gg: AR+sD13ot6juvU8aGo/ZIThejOyOjw9gdv3YwSmDgN8s1Tb/RpUphOi1wz4dHnhkbK7
	JbbZOLmzapyUfrRtSWWvLm/nZF1ik20VaXnfdWqNoYtYRoXD00KCQtlf1c8OnrQxfFWei1IRizi
	xQWlLgqLxSJo1zCa4sjvvarp7LOR2dSO2Wz1Rq/CChes0MH87GsgDnutcso0qo4hdPU9VV0hn+O
	LLZkgb0t08/UERfqFTpDhC3wlkRh/qlvJ+/Elx7zDaSd0bbp/0yHDIDsQSIwWf5NZ7VRcRo++G/
	K/pp229P1sg/GpboMz3PS0LizAQ49gV40eInH44OlnmQpjowlNavI1nvh0QMUqhyRl2V8E0RTgu
	V1DgezdYy4YSOinoohd25gXCq9O7LIr/bFSK7xOwPdFE9cBFEik76Eh9cabmzFQeQJumsYPAy44
	EO/YDZKVJEKsP/EsSYlddwlYmejCK6wXUUiaouOluqTvlnxkqynZMV8pRucqjccbFxlWvAmeKLO
	3IGFA+rpy7Ea/o=
X-Received: by 2002:a05:600c:46d0:b0:495:4a34:16e1 with SMTP id 5b1f17b1804b1-496c656e064mr41905755e9.23.1785271344982;
        Tue, 28 Jul 2026 13:42:24 -0700 (PDT)
Received: from dev-mliang.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfc2ff2sm293304475e9.4.2026.07.28.13.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:42:24 -0700 (PDT)
From: Michael Liang <mliang@purestorage.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Liang <mliang@purestorage.com>
Subject: [PATCH 1/1] perf libdw: Fix outer-frame name resolution and spurious "(inlined)" tag
Date: Tue, 28 Jul 2026 14:42:15 -0600
Message-Id: <20260728204215.327318-2-mliang@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728204215.327318-1-mliang@purestorage.com>
References: <20260728204215.327318-1-mliang@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cu_walk_functions_at() calls libdw_a2l_cb() with the containing
DW_TAG_subprogram DIE first, then each DW_TAG_inlined_subroutine
nested inside.  The callback treated both the same way, causing two
bugs:

  1) die_name() returns the unqualified DW_AT_name, so every C++
     frame lost its namespace/class prefix (ns::Class::method
     collapsed to method).

  2) new_inline_sym() re-uses base_sym only when funcname matches
     base_sym->name exactly; otherwise it fabricates a fake symbol
     tagged "(inlined)".  Any mismatch between the DWARF name and
     the ELF symbol name mis-tags an outer, non-inline frame as
     inlined.  This hits C++ (die_name()'s unqualified output never
     matches the demangled ELF symbol) and it also hits C functions
     that GCC IPA-cloned (foo vs foo.isra.0 / .constprop / .part /
     .cold), since DW_AT_linkage_name doesn't reflect those renames.

Fix both:

  * Prefer die_get_linkage_name() (mangled, fully qualified),
    falling back to die_name() when absent (C, extern "C").
    new_inline_sym() already demangles via dso__demangle_sym().

  * For DW_TAG_subprogram DIEs, use base_sym directly -- the DIE
    tag already tells us it is the outer function, sidestepping
    the name comparison entirely for both C++ qualification and
    GCC IPA-clone renames.

Fixes: 88c51002d06f9a68 ("perf addr2line: Add a libdw implementation")
Signed-off-by: Michael Liang <mliang@purestorage.com>
---
 tools/perf/util/libdw.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index d5d2958902c0..4ca7e7e4fbe9 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -82,13 +82,39 @@ struct libdw_a2l_cb_args {
 static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 {
 	struct libdw_a2l_cb_args *args  = _args;
-	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, die_name(die));
 	const char *call_fname = die_get_call_file(die);
 	int call_lineno = die_get_call_lineno(die);
 	char *call_srcline = srcline__unknown;
-
-	if (!inline_sym)
-		goto abort_enomem;
+	struct symbol *inline_sym;
+
+	if (dwarf_tag(die) == DW_TAG_subprogram && args->sym) {
+		/*
+		 * cu_walk_functions_at() opens the walk with the
+		 * containing DW_TAG_subprogram DIE (the non-inlined outer
+		 * function). That's just the base symbol -- use it
+		 * directly. Avoids a fragile name-vs-name compare in
+		 * new_inline_sym() that misfires when GCC IPA passes
+		 * (.isra/.constprop/.part/.cold) rename the ELF symbol
+		 * while DWARF keeps the pre-clone linkage name, which
+		 * left the outer frame spuriously tagged "(inlined)".
+		 */
+		inline_sym = args->sym;
+	} else {
+		/*
+		 * Prefer DW_AT_linkage_name so C++ inline frames keep
+		 * their namespace/class qualification. new_inline_sym()
+		 * runs the name through dso__demangle_sym(), so the
+		 * mangled linkage name is turned back into
+		 * "Namespace::Class::method". Fall back to DW_AT_name
+		 * (unqualified) when no linkage name is present, e.g.
+		 * for C code or extern "C" functions.
+		 */
+		const char *funcname = die_get_linkage_name(die) ?: die_name(die);
+
+		inline_sym = new_inline_sym(args->dso, args->sym, funcname);
+		if (!inline_sym)
+			goto abort_enomem;
+	}
 
 	/* Assign caller information to the parent. */
 	if (call_fname)
-- 
2.34.1

