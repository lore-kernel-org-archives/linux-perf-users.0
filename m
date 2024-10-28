Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330A201021;
	Mon, 28 Oct 2024 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152100; cv=none; b=skWkuM5P2iO41NjCn8kQD1oh/XyLvUAhCHOC9EK0owc8M3o7IjUdR3JDK+WHcta7ryPE0EEDmrFj1CJibfLjDDaNhFb/M0caSuMCpEX+B+90mdbWeq0rTossj8h3wViVztZxN4Q2ZmhfbGL9PbAxdV3r/VTTqMsc7CSxQmJWbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152100; c=relaxed/simple;
	bh=2VilLd9xLfLAN9IHrO9LwlDC2JxfM2xfGosce4CDqaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzjEdNIe+WwrrKc7RwtdTqmyo7J5BfgWBTmWiZF828GSXepjlAeP8ANU1mYrqit7edKIyk2c6QqIunZOzTtGHmgtWxY0N4FeS0UvtIdb6GF8LWbFP1OctNIOlwf7mAM7bygRxuHYsvqxgFiVcNq7/+ixq/IobExBIjpapAa6qCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d20048k8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d20048k8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED590C4CEE8;
	Mon, 28 Oct 2024 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152099;
	bh=2VilLd9xLfLAN9IHrO9LwlDC2JxfM2xfGosce4CDqaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d20048k84m+M7r/Fa/7onVHaJ2diRSDtYjPoDyQaB8DTgqAOphg0ICiYrlj8+4F48
	 S/CvoRqd91wLiFDbjYRPwco0lRk5ZBV+kHYptuk+M75vl4PphqcSE00mNs8uDqtBWu
	 pJ0L1CF8Ib9dO4MO0MxnvsekhuXDsbqZODfZwdAL5k7UFIPiQI28rVmNDwMDvy99BL
	 rcDwb9nVVicXYg3Z5hX1xeAQXvg2jreGm5sVPv4R8luTzWNncNSsGH5Xvn2EkcIbEw
	 iLOT7/QG1RqzYgEn5+JKll/aSnSNP9p/OkdVjsyTZtNNUgz3s9KUORc0erfjTMk1LW
	 H6Ouhsi73jyXg==
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
Subject: [PATCH v3 10/19] unwind/x86: Enable CONFIG_HAVE_UNWIND_USER_SFRAME
Date: Mon, 28 Oct 2024 14:47:37 -0700
Message-ID: <b7edac5073e55a11e051a86857b2a0fe159047ca.1730150953.git.jpoimboe@kernel.org>
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

Binutils 2.41 supports generating sframe v2 for x86_64.  It works well
in testing so enable it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f91098d6f535..3e6f4c80c5b5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -290,6 +290,7 @@ config X86
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_FP		if X86_64
+	select HAVE_UNWIND_USER_SFRAME		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
-- 
2.47.0

