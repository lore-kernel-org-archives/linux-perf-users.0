Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47A205148;
	Mon, 28 Oct 2024 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152120; cv=none; b=dgP/Zm6b5ipoT6CVzZCoRVdDEG8b0d2I5rconHOEiFpa9w1kIrR/LD/Tu1RF0ga3F63aSi765yvM8kiKmcRmGqwIS9joEc5bHW/LMZDZOiuQMyOwFSarldFhf++Gj/d7EBEe1iE6fE1WChAkY3UL75KMRPHuS7QerEzkAUxLk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152120; c=relaxed/simple;
	bh=2VilLd9xLfLAN9IHrO9LwlDC2JxfM2xfGosce4CDqaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOfErV4+46X8U1/ZbQKAYeUh+ZLD/aokjkVM7MPiTZbUc0WPNJPSIQEVCpCIEuTDz6Ta3hiDzHEORGzg7BikPUvMvSFel+/tqymQMY5KdXdcDXA88Ya8tNgb+kzF3PBdthtsbj5o0EUUj0jMDCVbUI3rHdEJFhQZWmc4qtG32bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OywIrhNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OywIrhNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E62C4CEEB;
	Mon, 28 Oct 2024 21:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152120;
	bh=2VilLd9xLfLAN9IHrO9LwlDC2JxfM2xfGosce4CDqaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OywIrhNzqr6LJuMu2ulMPC8abF1/oKuZac3tGOjkMWgXl5DG215Aub+7CBMBK/DXR
	 M4rnj/DAEaHNv4EBoxMnqKBEqMx1kooVZkyE8onOPrKiLgZdBBGb9EBatJmV2ddphC
	 AEc/mlx0pK+msUZDPL0Y0AcPksyalEKGZFblqZGFNUdSufWQGE0bS4YSnffh7hZurc
	 Mcoyc4uZh4Gu/apsKthSy/viPf+DQMVbjeeJwWACBL8Hh3F7T4dpiXuDJHWGB3vGmc
	 nHyCmw8OpVfIBu4z/iNu9GcWNpSIKbHtZKOnSSZpXod9+9FMoYcg54ZLkQ0X4bNppr
	 uKd6wDt9M1t2A==
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
Date: Mon, 28 Oct 2024 14:47:57 -0700
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
Message-ID: <20241028214757.M2bD7cCAXu3xfISSwUAr0vdnlyNg7DsXHosy3wEA4yE@z>

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

