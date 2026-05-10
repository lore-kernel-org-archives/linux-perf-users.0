Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8C336EC0;
	Sun, 10 May 2026 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444635; cv=none; b=dJZ27bzO9IyLHo4nrKwDjZTlfTqCns8F1d8XD5yV8PLG4cSeNdTG56kudaAU0dRHswKtCYyHvA++lIq+z/6c2SFaJwDf15rcDdPoveJp+Lh58aKKc4yxPDIc2BxsY1hSyBfmKx6hoDwrivSO2gQOWxSaqshei9jLEJeEml6mh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444635; c=relaxed/simple;
	bh=QkZuSHlL6eS4V9enO3MccmwEHPmPHkV8ijz0e6MlI/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQ8NYJM2OZNEuemzUe6zU2k/5rAPOsP8NUHOqHErF1J1IO2w2rzXn15Vb0rZs/FAjID4CBctcuykeZdTwyXrV+7/VLG4zeZ0pM9bQvf9aV9XWj6XJg39Fc4zPRkbxfzLvfig43w5MaaFu4UUW4hgKtbPpo3yYgxM9t/n/88Nej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzzgKR0o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzzgKR0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C940C2BCC7;
	Sun, 10 May 2026 20:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778444634;
	bh=QkZuSHlL6eS4V9enO3MccmwEHPmPHkV8ijz0e6MlI/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzzgKR0oNdib4RIaFJ9X95edTixEABTAKiVuMLJbKVuvpMGwwsSg3hQZQwFuCY+ot
	 HkR+Pcnsul9BgHt07h2OuWXi9LwN9EIJl9nuasDZp/L2E4aUiq44Ukbbsw5c2Af+fC
	 sbH/pKs2Nz//kwI7Xqe9ARj2I3au7Lc2fhuCPIgJ2jwQmTCNZGEPnmcwYu8+KX9UtK
	 xm8LrDGYI+PvHAjJUOI5yV2LnH7GxVD3HF6N+dHzO7pIQcgt9hdJudtX6LoKneddN3
	 YyhxjosQg/Hp7xWja/2OVkxQoBgoniflYIOf9jQP+LyrdDj+TRU8y/T0O/0uH19jhj
	 ePVA6z96Bg2+A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 1/7] perf trace: Sync linux/socket.h with the kernel source
Date: Sun, 10 May 2026 13:23:40 -0700
Message-ID: <20260510202346.49853-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510202346.49853-1-namhyung@kernel.org>
References: <20260510202346.49853-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

 c66e0f453d1afa82 ("net: use ktime_t in struct scm_timestamping_internal")

This would be used to beautify networking syscall arguments and not to
affect builds of other tools (e.g. objtool).

Please see tools/include/uapi/README.

Cc: netdev@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/linux/socket.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index ec715ad4bf25f5f7..ec4a0a0257939a53 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -415,7 +415,7 @@ struct __kernel_timespec;
 struct old_timespec32;
 
 struct scm_timestamping_internal {
-	struct timespec64 ts[3];
+	ktime_t ts[3];
 };
 
 extern void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss);
-- 
2.54.0

