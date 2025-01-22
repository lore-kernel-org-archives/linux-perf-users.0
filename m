Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333F41CB337;
	Wed, 22 Jan 2025 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513136; cv=none; b=cbAj10MURfCQbfX5Tn87CFVn75Xok0xJ/QxFaReF4FfpKXD0xKKzKlGoUFPsdK5OuuPdgGLazOuMjdWiedQLho1dN9iAJw+rQxvLqqZ7PQ/wCGolRHPuIfN1gQtII4ah43sUA9XucdAacRA5gIEzvuaGICVIPfaYtGyi8eZpVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513136; c=relaxed/simple;
	bh=SJtVtbvkLcEvN5WibexRkaVRWjXt1N5t9/+LsSeWysQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkGFM0dBuOdr44lJl3RQygsMYP2htd/+mQR62vc0ed3WrzzLJ/ryQWf8CXQBo4uPbzCkqY9YqfNfvts+MR8W6tJFHLO72I6v93zH3WvNp3PT9LfKzarYBlst0mNGALGAbuRzdFjtOD/RtaFH0pDolVy8IaPw4676AdGJ1VpbemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KITmzbbo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KITmzbbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C342C4CEE5;
	Wed, 22 Jan 2025 02:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513136;
	bh=SJtVtbvkLcEvN5WibexRkaVRWjXt1N5t9/+LsSeWysQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KITmzbboQkeH902l5uema+VjX6uIubfMNZW56mKn1L5OG0Fy3rzwFjatLLRvL/npn
	 sAsSAyPqa/9fhaOJJ/vBgq08p7jDcZyb8GitAc8El5z6WsJTlRBHj3UqzSgWph9Niw
	 GOshUPpWklvCTTulnQUAHYdCUYMIkeaviND/4Mx6GYl8rN+W215KKG8SHF8hT2iasY
	 L8HUVtha1/NP0YhiyocDV+2mLCRdRu9iRhd5F69fzzN3WUnuvqY/zTgyBT0x3M79bz
	 6uFYRkdzVc9mfLZCq2PZVB4Tlb12cmpYgIo9uPXo2/BZmAh5cPOC0gBpnoDL4fL4/i
	 FTB4trh0yulXA==
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
Subject: [PATCH v4 23/39] unwind_user/sframe/x86: Enable sframe unwinding on x86
Date: Tue, 21 Jan 2025 18:31:15 -0800
Message-ID: <ea29b983a63c23fe6965aa984e1087a35be3e143.1737511963.git.jpoimboe@kernel.org>
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

The x86 sframe 2.0 implementation works fairly well, starting with
binutils 2.41 (though some bugs are getting fixed in later versions).
Enable it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 08c44db0fefb..1016f8f80447 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -293,6 +293,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_COMPAT_FP	if IA32_EMULATION
 	select HAVE_UNWIND_USER_FP		if X86_64
+	select HAVE_UNWIND_USER_SFRAME		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
-- 
2.48.1

