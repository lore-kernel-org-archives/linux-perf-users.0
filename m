Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11251EBA1F;
	Mon, 28 Oct 2024 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152090; cv=none; b=IPS+tLZWmjxQha7t2DTow1/Lpa3BTekp0u1/A/LIJWavzSgZ+SPtVs5cv07axdOCW0E2kOReE4BZzpwyfJGb96USVn25GU2Y17vVWSqi01tDDrkp4jo6EAuhASYb1tJ6FfHO+hnsTXQNdsqlIAAg8JELPVmQLph8telNSQkK5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152090; c=relaxed/simple;
	bh=0p8Qb45vgp0/wPL3MuhSna7OVGmhZaEJXaATPR0uVvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smSME5ZxSoRjb1hbrYSD+VXn9l6DM+WoxH0pay2Ot+MmTaonPa45FzpkBe7KNjGNE9bvSnqW8MRc0gQpFwgeJGfstIaiqxjZi6tml8CClrbtIbEmF2snIQiun2HZi89vdaH8PHM1kgijD6GhjgQkkdpSz1Y6YkWKvt29d8/aL48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2nl8ce6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2nl8ce6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AC4C4CEE9;
	Mon, 28 Oct 2024 21:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152090;
	bh=0p8Qb45vgp0/wPL3MuhSna7OVGmhZaEJXaATPR0uVvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2nl8ce6DKFWcXsOsYQbnZ5YkcQL7VgntNfnWupj6z8epERM1n9sPKIRhsm81kXBg
	 v1anSM//pJr2HGMA32jgWaIkPvunMY07RZvwFmqAk8LI9lRhNJfcayobsMtRR0re2v
	 fV6CvKmx/bYbmDuFcNRnK2K1az3hFVauEBLD0yqIgudXgQoahuFy/GCwWwJ235D9de
	 g7EKouVpMIOi5szyH9T3nPr2R8q1oo83a9hw1ZhpHbkQ6PFUqda/d579lM5+cr0gF7
	 p19lm3IPTO3Hohei8BEepR165IDXkKmmTUwTsc09odYM4LVpm4wPYb6Bd+ZwKkooCH
	 vjrzRKg3dDd0Q==
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
Date: Mon, 28 Oct 2024 14:47:28 -0700
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

