Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC471D014E;
	Wed, 22 Jan 2025 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513138; cv=none; b=hYKF28yfnghU9Lz6Ay7zA1Aw76AD2k8p4avW4EY3E7Ym+AGr7jp+vSLeNv6DuqKw/JKAjIDO8or+iPTcOo3jf0pI6qHBjMAXLJ3jI4ViupCWmM8xpPinb9ABXiXtbWJM8SDP3Z7KtsuZzqZ//VlIY2s2YIVxwRicsnAgyclPRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513138; c=relaxed/simple;
	bh=u+eqCpNqrTS/L8RyCIiLzVLvZ3FuAzNIAJa3OUbMdgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCWAWl73VBmWuOAlI5Gn1s2pmfAuq0Ou4Ljw/GVVcXxV1xx7zgYRTI1eUNnGnFDvPFlU7FQuzfZHGu3L1ALNn0bLCFMVGmSMiK2AQPX45EY+9oUHnVoNS6Owbq2qHU9xglEdxsnmajLfCy4eLPD4TvyEuv1ypnDqit85v9yJHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQCVzyB3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQCVzyB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E89FC4AF0E;
	Wed, 22 Jan 2025 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513137;
	bh=u+eqCpNqrTS/L8RyCIiLzVLvZ3FuAzNIAJa3OUbMdgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQCVzyB3yJ5ZiMZgnDQHZwolfL1MvQvbDYFL/JtQ/yHkNxTIClS4zbY2zhm1llIqw
	 Dem6EFyOqO5meqdy/TKrO52/LqnGaJw7rrG34g3XwVx9c3FGxc/e20ac3/TP125Z4D
	 JwIrx8eFj9ju3ZUFIkJ14C+uZYqablwbLgUlOgHwb5ntWIfZ1V7X84hZFzzdcQsCf5
	 m5mBTL1MFSebghzb8jD3qBr5QzysHDngvn9xq8kzSFfpUZz5SnQyrUAn+s+msn0DhL
	 dVDaaVpaBl96R7jPZ6cNBBisEiHhakHI8gmUBP3B3noUy3fIxlLHlwN/u75zYQoigs
	 jaoj8MUK7hxsQ==
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
Subject: [PATCH v4 24/39] unwind_user/sframe: Remove .sframe section on detected corruption
Date: Tue, 21 Jan 2025 18:31:16 -0800
Message-ID: <970bf7b27e7fa3d05a90d5762cc29cf9d2260cfc.1737511963.git.jpoimboe@kernel.org>
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

To avoid continued attempted use of a bad .sframe section, remove it
on demand when the first sign of corruption is detected.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/unwind/sframe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 1a35615a361e..66b920441692 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -294,6 +294,10 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 	ret = __find_fre(sec, &fde, ip, frame);
 end:
 	user_read_access_end();
+
+	if (ret == -EFAULT)
+		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
+
 	return ret;
 }
 
-- 
2.48.1

