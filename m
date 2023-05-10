Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95227C7EE26
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 10:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjEJKW2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 06:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbjEJKWY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 06:22:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F3221FE6
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 03:22:22 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.74])
        by gateway (Coremail) with SMTP id _____8BxJuldcFtkr1MHAA--.12280S3;
        Wed, 10 May 2023 18:22:21 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.74])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxMuVXcFtkGfJTAA--.18233S5;
        Wed, 10 May 2023 18:22:20 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 03/17] tools headers UAPI: Sync the drm/drm.h with the kernel sources
Date:   Wed, 10 May 2023 18:21:46 +0800
Message-Id: <7552c61660bf079f2979fdcbcef8e921255f877a.1683712945.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683712944.git.siyanteng@loongson.cn>
References: <cover.1683712944.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxMuVXcFtkGfJTAA--.18233S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxtF1UWFWDuw18tr4UXFWDArb_yoW7CFyrpF
        Wag3ySkrZ0yF1a9FyIvwnrXr1fGa1xWr4xWa17Xr45G3ZYqFnYgr17Kan0gFWUtr1kJas5
        ZFnrXr90gr1qvwUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5
        JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jfHUhUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Picking the changes from:

  commit 6068771673a38efc ("drm: document DRM_IOCTL_PRIME_HANDLE_TO_FD and
   PRIME_FD_TO_HANDLE")
  commit 61a55f8b1ebcde68 ("drm: document expectations for GETFB2
   handles")
  commit 158350aae16a4e66 ("drm: document DRM_IOCTL_GEM_CLOSE")

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h' differs
   from latest version at 'include/uapi/drm/drm.h'
  diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h

No changes in tooling as these are just C comment documentation changes.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/include/uapi/drm/drm.h | 57 ++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 642808520d92..a87bbbbca2d4 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -972,6 +972,19 @@ extern "C" {
 #define DRM_IOCTL_GET_STATS             DRM_IOR( 0x06, struct drm_stats)
 #define DRM_IOCTL_SET_VERSION		DRM_IOWR(0x07, struct drm_set_version)
 #define DRM_IOCTL_MODESET_CTL           DRM_IOW(0x08, struct drm_modeset_ctl)
+/**
+ * DRM_IOCTL_GEM_CLOSE - Close a GEM handle.
+ *
+ * GEM handles are not reference-counted by the kernel. User-space is
+ * responsible for managing their lifetime. For example, if user-space imports
+ * the same memory object twice on the same DRM file description, the same GEM
+ * handle is returned by both imports, and user-space needs to ensure
+ * &DRM_IOCTL_GEM_CLOSE is performed once only. The same situation can happen
+ * when a memory object is allocated, then exported and imported again on the
+ * same DRM file description. The &DRM_IOCTL_MODE_GETFB2 IOCTL is an exception
+ * and always returns fresh new GEM handles even if an existing GEM handle
+ * already refers to the same memory object before the IOCTL is performed.
+ */
 #define DRM_IOCTL_GEM_CLOSE		DRM_IOW (0x09, struct drm_gem_close)
 #define DRM_IOCTL_GEM_FLINK		DRM_IOWR(0x0a, struct drm_gem_flink)
 #define DRM_IOCTL_GEM_OPEN		DRM_IOWR(0x0b, struct drm_gem_open)
@@ -1012,7 +1025,37 @@ extern "C" {
 #define DRM_IOCTL_UNLOCK		DRM_IOW( 0x2b, struct drm_lock)
 #define DRM_IOCTL_FINISH		DRM_IOW( 0x2c, struct drm_lock)
 
+/**
+ * DRM_IOCTL_PRIME_HANDLE_TO_FD - Convert a GEM handle to a DMA-BUF FD.
+ *
+ * User-space sets &drm_prime_handle.handle with the GEM handle to export and
+ * &drm_prime_handle.flags, and gets back a DMA-BUF file descriptor in
+ * &drm_prime_handle.fd.
+ *
+ * The export can fail for any driver-specific reason, e.g. because export is
+ * not supported for this specific GEM handle (but might be for others).
+ *
+ * Support for exporting DMA-BUFs is advertised via &DRM_PRIME_CAP_EXPORT.
+ */
 #define DRM_IOCTL_PRIME_HANDLE_TO_FD    DRM_IOWR(0x2d, struct drm_prime_handle)
+/**
+ * DRM_IOCTL_PRIME_FD_TO_HANDLE - Convert a DMA-BUF FD to a GEM handle.
+ *
+ * User-space sets &drm_prime_handle.fd with a DMA-BUF file descriptor to
+ * import, and gets back a GEM handle in &drm_prime_handle.handle.
+ * &drm_prime_handle.flags is unused.
+ *
+ * If an existing GEM handle refers to the memory object backing the DMA-BUF,
+ * that GEM handle is returned. Therefore user-space which needs to handle
+ * arbitrary DMA-BUFs must have a user-space lookup data structure to manually
+ * reference-count duplicated GEM handles. For more information see
+ * &DRM_IOCTL_GEM_CLOSE.
+ *
+ * The import can fail for any driver-specific reason, e.g. because import is
+ * only supported for DMA-BUFs allocated on this DRM device.
+ *
+ * Support for importing DMA-BUFs is advertised via &DRM_PRIME_CAP_IMPORT.
+ */
 #define DRM_IOCTL_PRIME_FD_TO_HANDLE    DRM_IOWR(0x2e, struct drm_prime_handle)
 
 #define DRM_IOCTL_AGP_ACQUIRE		DRM_IO(  0x30)
@@ -1104,8 +1147,13 @@ extern "C" {
  * struct as the output.
  *
  * If the client is DRM master or has &CAP_SYS_ADMIN, &drm_mode_fb_cmd2.handles
- * will be filled with GEM buffer handles. Planes are valid until one has a
- * zero handle -- this can be used to compute the number of planes.
+ * will be filled with GEM buffer handles. Fresh new GEM handles are always
+ * returned, even if another GEM handle referring to the same memory object
+ * already exists on the DRM file description. The caller is responsible for
+ * removing the new handles, e.g. via the &DRM_IOCTL_GEM_CLOSE IOCTL. The same
+ * new handle will be returned for multiple planes in case they use the same
+ * memory object. Planes are valid until one has a zero handle -- this can be
+ * used to compute the number of planes.
  *
  * Otherwise, &drm_mode_fb_cmd2.handles will be zeroed and planes are valid
  * until one has a zero &drm_mode_fb_cmd2.pitches.
@@ -1113,6 +1161,11 @@ extern "C" {
  * If the framebuffer has a format modifier, &DRM_MODE_FB_MODIFIERS will be set
  * in &drm_mode_fb_cmd2.flags and &drm_mode_fb_cmd2.modifier will contain the
  * modifier. Otherwise, user-space must ignore &drm_mode_fb_cmd2.modifier.
+ *
+ * To obtain DMA-BUF FDs for each plane without leaking GEM handles, user-space
+ * can export each handle via &DRM_IOCTL_PRIME_HANDLE_TO_FD, then immediately
+ * close each unique handle via &DRM_IOCTL_GEM_CLOSE, making sure to not
+ * double-close handles which are specified multiple times in the array.
  */
 #define DRM_IOCTL_MODE_GETFB2		DRM_IOWR(0xCE, struct drm_mode_fb_cmd2)
 
-- 
2.31.4

