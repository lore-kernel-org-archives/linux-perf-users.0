Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFEA17995E;
	Tue,  3 Dec 2024 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198034; cv=none; b=ivbVZt2m7OmZ2gfFH3+C8G6GzYNv0rwnJNd2V8g3Pz88RHQfh5W2swat6CyWBHNlbntvx/VPzv1d8Hrl8fUp1MT0gRR+pP//qxD7tgKivKd/L5l2PS1HdOf8CUkiMc1a2/zDbSZl4A6LhV6pdi6AedKYq/rcdwymGKw7btM5688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198034; c=relaxed/simple;
	bh=O1RWkaeULx9ZPpdPzg3sbjMLr7t24XttgegNRluRTnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhsEsnRTJeOjYiBSGlWwoMwLyf8asLWO9KLO9qi2SMcuhGbWVtcFWTWuFruhPT+WKjZaCpzANAUThZ2ckrwfs5DVZz0RiAqJI/ZJB0LKQszf3PEf2qSK3ps2D3VsPzqa/knewARAYSthe6bhmzFmhzesd3U7/YoBazKSsc+Bwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6/hE7Ig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6/hE7Ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12A4C4CED6;
	Tue,  3 Dec 2024 03:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733198033;
	bh=O1RWkaeULx9ZPpdPzg3sbjMLr7t24XttgegNRluRTnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6/hE7Ig4WEjC7Mj78y+e2UHlJFg02WpUMgIRzashRP8vLlsnpd+Rd1GvbD1he76n
	 rTIKmb1TGuOUW2tjamnsZVOWJdcJUt+uZAsC06FVa4vkKq3dt5rL28QJeWBU8a2/4p
	 JYCXLvg53BpaIUtFOnJnsNPgESVWI4+69E2onyWqtFzhHOwnZeSfdtT5PoLZGtHHNl
	 JV68rWUx9HKb4wJWI5lIK1hrWaKQepeHYvw9gEMsRQ8OBwGOJv+bYgwJTBogOWA956
	 Ihm2i7DMdgCCMs3y4MsSlWtsuEOiA32pK7u/d5w8zuFXwvYgRH91e24kTs4z9B5JBJ
	 t5KEMOnioLSkQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 01/11] tools headers: Sync uapi/drm/drm.h with the kernel sources
Date: Mon,  2 Dec 2024 19:53:39 -0800
Message-ID: <20241203035349.1901262-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241203035349.1901262-1-namhyung@kernel.org>
References: <20241203035349.1901262-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  56c594d8df64e726 ("drm: add DRM_SET_CLIENT_NAME ioctl")

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h

Please see tools/include/uapi/README for further details.

Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/drm/drm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 16122819edfeff87..7fba37b94401a6d5 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -1024,6 +1024,13 @@ struct drm_crtc_queue_sequence {
 	__u64 user_data;	/* user data passed to event */
 };
 
+#define DRM_CLIENT_NAME_MAX_LEN		64
+struct drm_set_client_name {
+	__u64 name_len;
+	__u64 name;
+};
+
+
 #if defined(__cplusplus)
 }
 #endif
@@ -1288,6 +1295,16 @@ extern "C" {
  */
 #define DRM_IOCTL_MODE_CLOSEFB		DRM_IOWR(0xD0, struct drm_mode_closefb)
 
+/**
+ * DRM_IOCTL_SET_CLIENT_NAME - Attach a name to a drm_file
+ *
+ * Having a name allows for easier tracking and debugging.
+ * The length of the name (without null ending char) must be
+ * <= DRM_CLIENT_NAME_MAX_LEN.
+ * The call will fail if the name contains whitespaces or non-printable chars.
+ */
+#define DRM_IOCTL_SET_CLIENT_NAME	DRM_IOWR(0xD1, struct drm_set_client_name)
+
 /*
  * Device specific ioctls should only be in their respective headers
  * The device specific ioctl range is from 0x40 to 0x9f.
-- 
2.47.0.338.g60cca15819-goog

