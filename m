Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A741465AE;
	Wed, 22 Jan 2025 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513116; cv=none; b=dXYYkaNfRAWCDiw9BfmAjw0owSISv5qncB3/3G26aLeFE8fbVeBxYWpYbGUoq2nT+xHjyABGcHYLueSMke3jlt+qQW4ryQDx+cVQkMXpg+qlwJn2qCEBaiqPTUd7wIxIPJc2vZmT843/CFTAWABQ2AtAOPSuJlBh4zrD4+p0Eao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513116; c=relaxed/simple;
	bh=4V7fRRbrcaQZQspNP6x9fH3uJzB9WiW6Ms6JvucjOCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oig99DocXZLrD6XOfrhzvP6p1k+Rx+7I2DgNZsx2FB08QaCtOO494tQYMLAe4xsbeCRnvEZOmO+oc+9w0sIlecgoON84gLEtHS07TcJlNPMNKI/PG6ulbJkljsJB1JeAhuNP5+XKWpQplG+Sdd14O3T/omsceS/o/n5HEFJiw1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRkjhoWv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRkjhoWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6963C4CEF4;
	Wed, 22 Jan 2025 02:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513115;
	bh=4V7fRRbrcaQZQspNP6x9fH3uJzB9WiW6Ms6JvucjOCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRkjhoWvqu+HlBmXeEG35Ogzy6lKWw9hXLFV/8qWYWXZ6TTxnCMqzZ9DAI8RVXrMl
	 /nNESA4KJs6N42E3xSvt5tV1uHqeSMPYOGwO+CXXW0ZQHNlA73fA/2dfN+FmxyPGE2
	 3VUvUmjWHQFkndHaE/nBIkBJxtvaWpo6ITfQC7azxErrRW+TmRZQge8RFysgXfk1Pg
	 RUTcLFcRj3w4J+mvq82BoaMHL6wyyn4hWiZC+nQ+s8oR7Zo2rKZ8KHSobFN6dv7cHK
	 aEZX4xPL47wrO2TThop3U/rP4BxtLXLe8RvWZqfS2ifbIs0NEZrpq4gvDUQOEoSFFk
	 W5E6A8yS3bd4A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 04/39] x86/vdso: Fix DWARF generation for getrandom()
Date: Tue, 21 Jan 2025 18:30:56 -0800
Message-ID: <d33db71e14b4ad672aacd39c8a5d626a2a7da5a7.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CFI annotations to the VDSO implementation of getrandom() so it will
have valid DWARF unwinding metadata.

Fixes: 33385150ac45 ("x86: vdso: Wire up getrandom() vDSO implementation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/vdso/vgetrandom-chacha.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vgetrandom-chacha.S
index bcba5639b8ee..cc82da9216fb 100644
--- a/arch/x86/entry/vdso/vgetrandom-chacha.S
+++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
@@ -4,7 +4,7 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/frame.h>
+#include <asm/dwarf2.h>
 
 .section	.rodata, "a"
 .align 16
@@ -22,7 +22,7 @@ CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
  *	rcx: number of 64-byte blocks to write to output
  */
 SYM_FUNC_START(__arch_chacha20_blocks_nostack)
-
+	CFI_STARTPROC
 .set	output,		%rdi
 .set	key,		%rsi
 .set	counter,	%rdx
@@ -175,4 +175,5 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
 	pxor		temp,temp
 
 	ret
+	CFI_ENDPROC
 SYM_FUNC_END(__arch_chacha20_blocks_nostack)
-- 
2.48.1

