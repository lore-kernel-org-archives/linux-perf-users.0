Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206372F9DBB;
	Mon, 22 Dec 2025 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444241; cv=none; b=Rgzp56iPQTS5O1z4vzDrVyzgNgazPHzB7Mrz98px0VVG7fmGEAu9z+zLnYbo4254iAE8DrMmZ+IQPhEd7kDEyu1Lnn3Dc+2HIEhQ8BSs4aV7zig1csbjK2wd5J62R2c670eGF+t2sRxcMS36qttzoEVyH6Mee6ZLYWcehyQRKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444241; c=relaxed/simple;
	bh=3+5GeS8/OYU69k/uHui0TVDmtpR9iplT3VIctDIIIxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvHAall4eHbSAm9msXUaazz/tQ5NTjVhb/pYIodDry0/F332rg3M2yRgsZOGEj0INkO3Azxcq6UQBwomiAL/M6/tbunI2kDmKOS4h0RbVitVkaurd3WIXGdEst8iqADaYrWW5qOZjwnpE+TDyk5uhv6RGVJ+BdTTnzjWS1+fyWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+3n0IcO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+3n0IcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514A6C4CEF1;
	Mon, 22 Dec 2025 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766444240;
	bh=3+5GeS8/OYU69k/uHui0TVDmtpR9iplT3VIctDIIIxQ=;
	h=From:To:Cc:Subject:Date:From;
	b=j+3n0IcO31KBuV9byyn8tf4tROU6MFboyNWJw7b5Mb45mT4jodFt5QtVfZa7r2H6/
	 6lleKgy0fp2cVIYBlEUtNC7Wu/TT/hJnPIti7+BwscJy/g+xJ1y1l+t9AZA9zn57Wz
	 VRr4knOEcJFxi2r1MoKyCh7Oh4iBSeZEF4KAE+YUvPBmOhfKKULyuKbDMV1BR4xiIF
	 SlylHh8dDf0oNVdxvd6Byce5WjnDhEaqaRuYloTN4cFc54PNu1A9wuZpcjrympUQwO
	 VO4zYfBLcz8OWer3RmBqjgnTkSPmxrXFV6IVnk88PoCoFweF9buPaPPckZ0u01l4NL
	 jgcLx3K6bkiLw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 01/11] tools headers: Sync UAPI drm/drm.h with kernel sources
Date: Mon, 22 Dec 2025 14:57:06 -0800
Message-ID: <20251222225716.3565649-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  179ab8e7d7b378f1 ("drm/colorop: Introduce DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE")

This should be used to beautify DRM syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h

Please see tools/include/README.kernel-copies.

Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/drm/drm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 3cd5cf15e3c9ce22..27cc159c1d275c7a 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -906,6 +906,21 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT	6
 
+/**
+ * DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
+ *
+ * If set to 1 the DRM core will allow setting the COLOR_PIPELINE
+ * property on a &drm_plane, as well as drm_colorop properties.
+ *
+ * Setting of these plane properties will be rejected when this client
+ * cap is set:
+ * - COLOR_ENCODING
+ * - COLOR_RANGE
+ *
+ * The client must enable &DRM_CLIENT_CAP_ATOMIC first.
+ */
+#define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
+
 /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.52.0.351.gbe84eed79e-goog

