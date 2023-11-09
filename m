Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A4EBD
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Nov 2023 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDPeGyqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62139C43397;
	Thu,  9 Nov 2023 00:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699490626;
	bh=8NHcfWQYiDrY3TdwV6wLuh/GROrzM7rVN7CxC7jZJZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDPeGyqPNnU7PAB45cqEq79LGLRkEdObLZzQGAG1qfceKrjCHpMV31YkpCXB8L4xd
	 hI8sCYhCTeKSiJLUlMpQlxAqX1UQ2ircgRL9k/nvMBFVMXmZ242juUtWiLFRRfC57t
	 nIKxHGRLWRTyTRRH5lFbgf1mu4zylFPvtvIyRpCXU3WzLnIRu7Xre6IGQxEEyXHfNC
	 z/5lUvuvfyuUi9FHRb8w3B82gHViUaaTKIq0qsO8wzC/MjyHX0PRjyTJpgxXGPiDO0
	 RbTm6Y/bDOGG0qDwpFLNTd39iVmQn1kqZJOqXg04VjAI5SzNQdlQfBOkdsQtJO6QZb
	 GCl0JIyobKx2Q==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH RFC 10/10] unwind/x86/64: Add HAVE_USER_UNWIND_SFRAME
Date: Wed,  8 Nov 2023 16:41:15 -0800
Message-ID: <ec004e900e02c9c85cf8c89d4c26d4168a6c5d18.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
References: <cover.1699487758.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binutils 2.40 supports generating sframe for x86_64.  It works well in
testing so enable it.

NOTE: An out-of-tree glibc patch is still needed to enable setting
PR_ADD_SFRAME for shared libraries and dlopens.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95939cd54dfe..770d0528e4c9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -279,6 +279,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_USER_UNWIND
+	select HAVE_USER_UNWIND_SFRAME		if X86_64
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_PARALLEL			if SMP && X86_64
 	select HOTPLUG_SMT			if SMP
-- 
2.41.0

