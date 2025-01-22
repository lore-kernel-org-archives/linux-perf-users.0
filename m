Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A205152787;
	Wed, 22 Jan 2025 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513115; cv=none; b=Rz8ZK5DoVJvqabs/dkObz2N2yWUHNDgWsa2tuQk0lomn+B1w3prGDkC0cBsmbtsUeBTzVYyQ48ma82VQqUgFdB8ExRs1VDItH60RKfGP+zfWLDxG9v2N2iqCgfx5YkFgjhHFDhCTk7kC4jAQP22aApDhRRwI14XDGmTp8yKZJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513115; c=relaxed/simple;
	bh=gEweV+ZvxXqxAtdRcPxlgi9cIku/oRPAY9rngmFOgwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcbJX8AOqXSKgAbuX0gD0TjjZ+k42v5O1lRa9XGdfSZXBwXtcGNRTZiUQCLPX5d71vV2yDe6l7YPMido/mWxc+eOyf0+sl9MfUJNSaX7EghK76O7OpSLOk+OcyL8R7S15QHgl0/2pAoSfujg4ER7LuzxnylpBYJ+XmoQldnHFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOiS4UWo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOiS4UWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAF9C4CEE8;
	Wed, 22 Jan 2025 02:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513114;
	bh=gEweV+ZvxXqxAtdRcPxlgi9cIku/oRPAY9rngmFOgwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uOiS4UWolvFcKqdrmMA6w1gW0GCsNGN2ojH/M7P7VTdPhRUF1kmfxiKd+qKLKMw2a
	 VSQLJ4eoMYMkULYxNNBg2xC5xLAOGgs5obEARz2Gg+/VKgORVL0HJ7pRwUbQNrWeYZ
	 TKGorzEf+Jevuz00R6ICLhdWL96MDuBqyCRR1gl7288nvgtt+DwXgI0aTra/PWqdDZ
	 4hoElUlB+uLv6Yd6eHh1zob98Jt/k2SbwTsxvg1KmBUcqpGIPuC5GLSMphBcFgzx9T
	 s6K6CsI2FEcO7Aczahk5SHfkiXpUcr1VEJaJ8fGyxi+iTSOysP6vmtYu5Rw3H9vt5D
	 YiMzY3cc9fHYA==
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
Subject: [PATCH v4 03/39] mm: Add guard for mmap_read_lock
Date: Tue, 21 Jan 2025 18:30:55 -0800
Message-ID: <8f8f672bec535ce8ed54d79591d98386a4d46c28.1737511963.git.jpoimboe@kernel.org>
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

This is the new way of doing things.  Converting all existing
mmap_read_lock users is an exercise left for the reader ;-)

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/mmap_lock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index de9dc20b01ba..c971c4617060 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -182,4 +182,6 @@ static inline int mmap_lock_is_contended(struct mm_struct *mm)
 	return rwsem_is_contended(&mm->mmap_lock);
 }
 
+DEFINE_GUARD(mmap_read_lock, struct mm_struct *, mmap_read_lock(_T), mmap_read_unlock(_T))
+
 #endif /* _LINUX_MMAP_LOCK_H */
-- 
2.48.1

