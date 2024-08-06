Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A21741C9;
	Tue,  6 Aug 2024 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984617; cv=none; b=epgxUhYBRJV4bQAzTcGY0YkIQ/cOtuqrCDC2fQ0JzRduRmV79S+fUJ/FeKLRiDBGz341C2HOUxRDwm3eS2BNWf7anATG13alag3f2ZOUdg79rQtv7mf/POUkIHdR9ZNbKXB05IkXy3YfljU/jdv9e+rf0OT7yJgkJy/ScgiLar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984617; c=relaxed/simple;
	bh=BYhbY42/awdN5ih8e6wzjh9dbH1EcXE+2Jb9xJYjvsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2izvhdnr0GDeDFP6dj539I0aW5OeHnaArK45p/nhSb8KNRy29Aar8Y5T4x56eO5/90zfsZBlJdeqw89Z5qqCSv1v1WGz/9GB7AH2v44Ow5yhz/Zua/kQLk8Gq8K6O/g9dGyopCiQOtUoBze3opCEXJhBmV5Ym9B6SU/SZFx+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URuXeHel; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URuXeHel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2111AC4AF0C;
	Tue,  6 Aug 2024 22:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722984617;
	bh=BYhbY42/awdN5ih8e6wzjh9dbH1EcXE+2Jb9xJYjvsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URuXeHelvrEwJdKctlsDYC0/Wg+GAQjcld3kSf2QQTTq6Xk5e6YKKRWMRa1D5mavB
	 JjpX4Xphvyf88Dzp1/U7yBONohmcIqTG3iF6Ez99AlbLiQIchHkjCLbeVEXwsDL4wV
	 WR+OMXBeAlWJNdPk3Bd+rA7CFXgk6LbHPe3DqXpRgAGojUiuQrW6uGtAJl4CMiGAeg
	 bE6uXzHhB+U84CHEq9l9HSGxexSFpmf+hMFUT3YNj9QLe9KVy31u5T6T3rXaefBRwP
	 D+4rnbMQTZ79+XMUaHSrY8Fugqf9rJJ8di1FZ8aSTFYP+HTyw7x05gEAJKyuyPZdQO
	 UaFCetJnC7nlg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 02/10] tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
Date: Tue,  6 Aug 2024 15:50:05 -0700
Message-ID: <20240806225013.126130-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240806225013.126130-1-namhyung@kernel.org>
References: <20240806225013.126130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  0f1bb41bf396 drm/i915: Support replaying GPU hangs with captured context image

This should be used to beautify DRM syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Please see tools/include/uapi/README for details (it's in the first patch
of this series).

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/drm/i915_drm.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index d4d86e566e07..535cb68fdb5c 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -2163,6 +2163,15 @@ struct drm_i915_gem_context_param {
  * supports this per context flag.
  */
 #define I915_CONTEXT_PARAM_LOW_LATENCY		0xe
+
+/*
+ * I915_CONTEXT_PARAM_CONTEXT_IMAGE:
+ *
+ * Allows userspace to provide own context images.
+ *
+ * Note that this is a debug API not available on production kernel builds.
+ */
+#define I915_CONTEXT_PARAM_CONTEXT_IMAGE	0xf
 /* Must be kept compact -- no holes and well documented */
 
 	/** @value: Context parameter value to be set or queried */
@@ -2564,6 +2573,24 @@ struct i915_context_param_engines {
 	struct i915_engine_class_instance engines[N__]; \
 } __attribute__((packed)) name__
 
+struct i915_gem_context_param_context_image {
+	/** @engine: Engine class & instance to be configured. */
+	struct i915_engine_class_instance engine;
+
+	/** @flags: One of the supported flags or zero. */
+	__u32 flags;
+#define I915_CONTEXT_IMAGE_FLAG_ENGINE_INDEX (1u << 0)
+
+	/** @size: Size of the image blob pointed to by @image. */
+	__u32 size;
+
+	/** @mbz: Must be zero. */
+	__u32 mbz;
+
+	/** @image: Userspace memory containing the context image. */
+	__u64 image;
+} __attribute__((packed));
+
 /**
  * struct drm_i915_gem_context_create_ext_setparam - Context parameter
  * to set or query during context creation.
-- 
2.46.0.rc2.264.g509ed76dc8-goog

