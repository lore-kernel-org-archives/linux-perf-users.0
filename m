Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D402038C5;
	Mon, 28 Oct 2024 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152111; cv=none; b=BCrYmU+jUUn/InK9oEb50O6a0rtDsVPBSCKNjBw26G9UzG+rUi4zGlT4wKnqDWalFxb7W+lXOKuzFm7FdjWxL0j8urdeH/w4PYyyENutFPVM4VDJ3PdyzDX4C5KyYD+62xAIYKSj7V4aAvpbVSY0gRFtr28ysldFs0IyPJK7VbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152111; c=relaxed/simple;
	bh=0p8Qb45vgp0/wPL3MuhSna7OVGmhZaEJXaATPR0uVvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R79i4yURAxOlJx4n4z8MB4d44/+XfywjjZAqiD64+LZmZ4oe552lPfAcRNGKVy7dhVH3y2Z9hq6eL5H5ESbQH/e+sIqH2JvYYs1fP3URQQOI91Z5zIV3uwarUDMYYIvkXslMBBMJj/iyj8rmrYmBZt4w03Rps6I83G/DniGUrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igoXBPa8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igoXBPa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A20C4CEC3;
	Mon, 28 Oct 2024 21:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152111;
	bh=0p8Qb45vgp0/wPL3MuhSna7OVGmhZaEJXaATPR0uVvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igoXBPa8dHZf/M1f1+fJeVKDfXRNRWT4rfmK+s1ZC/l6ChiJRF0/C0yXo4htPcioi
	 QCLk3okovib+olaN/wLqP9COwdc9bCsQu6TPuBt3QEA30AzlPj25NT9P9hSso6bJah
	 bhggtK1fBaTyJJf0DyV9lwAer0cCN8hfMKx800ls7qTILMMpS6lalyk2XtV0tdKX0r
	 6da59FSWt7suLljhaqe8wLOJ+pCbtsArjSyDCJwUhRBqWqzeXm/hXqY6GgtR1o4sAQ
	 pQPaBWiBWWfka1m9ZvGISds6LrDfkvAD32ULAEqmiiQJ2rFwz3DcJ2t5/R7+iFotCX
	 uGDqbTbXiNG4g==
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
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 01/19] x86/vdso: Fix DWARF generation for getrandom()
Date: Mon, 28 Oct 2024 14:47:48 -0700
Message-ID: <8e0fdc4c1b30c6040502c6265f455c44d05ea041.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20241028214748.J7iinBHJcR_9_cOMI7PDTtSO9ET_Lj3XJnIMw7LKWj0@z>

Enable DWARF generation for the VDSO implementation of getrandom().

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
2.47.0

