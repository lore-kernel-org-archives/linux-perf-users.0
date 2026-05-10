Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD633CEA7;
	Sun, 10 May 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444636; cv=none; b=XR23XGaZKJSJjHJHTlZ84rbyIYIBssDOzPN7o+VQ3h2McU/S2XOJsRa8IuEKfWwFwbYEP+ibhTw0dbtZiJNBDWnR0Jms+9LU8lhH0jyX7gKwQTw3h57CnBdpidHvLbx44j+Eczy3GB96aRcD5YwxGK7l96SKeI/6Puh2kscN8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444636; c=relaxed/simple;
	bh=Y+iztaeGk5XPG7WjYLkW/BI+mxbgdz2xBTbH1ELsOnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvxxQv4uMbrTaZUr0VC9gNZiy7yJHN4dc5q/j7/grSEtELRQl5q7AwLaAHuPEQ8Ns9+RAzCgr7tLNrTNCot5OeclX4RQHM6KD8AtVCvIi/M04kyCKjOApSIkdc9skJ6WJzaxBALJjg6x1dTLzI0fsCrLxiKnjmmzQKqEUdnoc7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApTJ0Tm3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApTJ0Tm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83622C2BCC7;
	Sun, 10 May 2026 20:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778444636;
	bh=Y+iztaeGk5XPG7WjYLkW/BI+mxbgdz2xBTbH1ELsOnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApTJ0Tm3wEfQz5CKDnGXlgsoGfhKX3Kyt7/br9//7mfypFEI6p2vW1eOpS8M+/QvR
	 K7nH37uWss0fVHmKPBRs2ATi44fnvlqes3S2fEdiMfR4V9rTQRv9uiO0+wmwKX1/Jl
	 snF7dNqJ3W7Y0ZCTW+haRUhYv3DcwnrsFjHtDiFoF8UYt3RXCNxcyDQwptgeYhrAxJ
	 OmlvDe/UNHCElv3DOUjHHvNlzhlnhtyo8NTs2GlGwrSVv6jZqE7pSMwcq8BWitI+x5
	 GSVu/uzGh5WIxfgAuQ+p+UddOHopk+pubpimk42znFSZNwO4gNjurRAF4JeYwhhM+I
	 Wgu34GB/nm2qg==
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/7] perf trace: Sync uapi/linux/mount.h with the kernel source
Date: Sun, 10 May 2026 13:23:42 -0700
Message-ID: <20260510202346.49853-4-namhyung@kernel.org>
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

 5e8969bd19271241 ("mount: add FSMOUNT_NAMESPACE")

This would be used to beautify mount syscall arguments and not to
affect builds of other tools (e.g. objtool).

Please see tools/include/uapi/README.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/mount.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/mount.h b/tools/perf/trace/beauty/include/uapi/linux/mount.h
index d9d86598d100cb32..2204708dbf7a583a 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/mount.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/mount.h
@@ -110,6 +110,7 @@ enum fsconfig_command {
  * fsmount() flags.
  */
 #define FSMOUNT_CLOEXEC		0x00000001
+#define FSMOUNT_NAMESPACE	0x00000002	/* Create the mount in a new mount namespace */
 
 /*
  * Mount attributes.
-- 
2.54.0

