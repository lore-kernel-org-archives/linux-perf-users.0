Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79F8189BB7;
	Fri, 13 Sep 2024 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268591; cv=none; b=Odfg9iCo2HXD/onAkHbA5CxJRQo2Rbg4rAzMjaiwjYWB9UwNXmuwObrA0wuZq3E2bLI+F7laPus424q0Xnj8CPeC2v0Nb+9Ms5OKW4oJQcad5ZESs6ly/zuwiQTlCwqnnOCLdFmUBEDnhLq/SUfSKK81NJV0nTvLUGCGpAgPqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268591; c=relaxed/simple;
	bh=BWrk0q88o8e+ReU0k54FjB59AgH0K/bGbd52KtpS2Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOBOQx+m+sKdPGFP14BccAqmah1qX8Q9yRB/vQVdDsHIuL0IWP629TtGKzHy4qW18x3urABmvGenEKJ9GzFuBCJrpWGQ5wHLmLTqzPhEtBxZOP4XP6XI8xOUqMmoqGC0udvW7v23u8jpNQELcl6zaN659Yhb/YWuTG7+GZaYXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcLM4pKi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcLM4pKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C28C4CECC;
	Fri, 13 Sep 2024 23:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268591;
	bh=BWrk0q88o8e+ReU0k54FjB59AgH0K/bGbd52KtpS2Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FcLM4pKiesCclYaybkr0GdMDphswuS0pTTycksFGH/vBgcUJOtVVg+T8RVAc/jhcQ
	 dsnfF8g77iLLcAjMZeDPkFBrBKSn0yvUpaEf6dhnRwRDdlVVJxNaP0xtv76U3QQlvg
	 sSdm2hgRYfLY1ebAlCiiy6luLLmCYIhBFmAL55Udm5kDcPAjludV352JWxp6okwmBw
	 Frw+zlGitLLk/7RFxRFIcDMFKBCNM/QRBsA9ugJFnPFX48xRvOdOqpfWbvRwIRemHg
	 QqkV6mAuFYL0EDHJcFJdxm4/zJz4nl257tuKW94QonTBlhosFvsiGgkaeuj7NvUZ6o
	 EBC0YUKOUSR+A==
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
	Sam James <sam@gentoo.org>
Subject: [PATCH v2 04/11] unwind/x86/64: Add HAVE_USER_UNWIND_SFRAME
Date: Sat, 14 Sep 2024 01:02:06 +0200
Message-ID: <37de872b0894b21408754ae2903b7701cc6dfab7.1726268190.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726268190.git.jpoimboe@kernel.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binutils 2.41 supports generating sframe v2 for x86_64.  It works well
in testing so enable it.

NOTE: An out-of-tree glibc patch is still needed to enable setting
PR_ADD_SFRAME for shared libraries and dlopens.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 266edff59058..0b3d7c72b65b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -287,6 +287,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_USER_UNWIND
+	select HAVE_USER_UNWIND_SFRAME		if X86_64
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
 	select HOTPLUG_PARALLEL			if SMP && X86_64
-- 
2.46.0

