Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394935E92B;
	Thu,  7 May 2026 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138802; cv=none; b=I4TlwXVbI1y+BJGOgZiNKab//TkJ7ivOj/1kAXcwMRyMVJA6vk8cUzG/679+fQXmGi8OWPxEuf6oX/47612jKPQj+uZuu1PUT5vwZHOZIlcP2Tlqr7fAFYPR/iNWO11YprpKnX9EK534QKizA8G1+BFn//E1hpM0HIX67w/YGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138802; c=relaxed/simple;
	bh=+uNzf2qgr4C3sW8Ogf+nC1N8Nw6K51IIbYOW1sv3qkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twNVYb8nE7+4HSHy2u0C2K0kKGuirp5cviO6n506c7968ySLv9y3dHCsLpd7/Q+Zut/Bn5Uftkk5y4G+Ep6NicWdY6/uaPoGvR5PkelqR9suZMs3gSQbiEmzjE9VHWE4UE0i6f3uHMWRLVrLK0ZTT20NwL+r03NVS1mZvaAQY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii4my3vI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii4my3vI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72741C2BCF6;
	Thu,  7 May 2026 07:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778138801;
	bh=+uNzf2qgr4C3sW8Ogf+nC1N8Nw6K51IIbYOW1sv3qkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ii4my3vI1eG/o8WNVZOjHZhTl2EOCatEiro3XWBt942cGXhQax6q8CDzh51YVFM3r
	 hQ4weiUfWo971dBW5jL7CWPyORKMKsiRNYADeYv2iu9lKaXMpOfOMDgZ3SX0DEKGlg
	 jQj1bRqDG+bDArowdKLe7uhWbzQtcoZoqCEOzj6kK62vT3Fvbex2jHdhAmCyZC7rbx
	 6mlnbrRsWRX/qm+3Kh+rS5yLksPUo63L/wifDOi5CRrzSpGhvEaLoDWkFre18IBRvY
	 VRNozQj8nX7NrnNYLwswVG/qP+zA8+/lI6mQYSOS0Iry6+u9wOW95y7TZTMwjlez53
	 a6E26d9sfZzqA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/7] perf trace: Sync uapi/linux/mount.h with the kernel source
Date: Thu,  7 May 2026 00:26:28 -0700
Message-ID: <20260507072632.37152-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507072632.37152-1-namhyung@kernel.org>
References: <20260507072632.37152-1-namhyung@kernel.org>
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
2.53.0

