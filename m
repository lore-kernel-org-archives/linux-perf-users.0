Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9C8C77B73
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 11:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjEFLCz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjEFLCx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 07:02:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52D6061AE
        for <linux-perf-users@vger.kernel.org>; Sat,  6 May 2023 04:02:50 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8Bx6enZM1Zk+bwFAA--.9597S3;
        Sat, 06 May 2023 19:02:49 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHuTUM1Zkw2tNAA--.10375S5;
        Sat, 06 May 2023 19:02:48 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     peterz@infradead.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 03/18] tools headers UAPI: Sync the drm/drm.h with the kernel sources
Date:   Sat,  6 May 2023 19:01:57 +0800
Message-Id: <e349d36624ee78b1f8337514d69e16c2f10963b5.1683370076.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683370076.git.siyanteng@loongson.cn>
References: <cover.1683370076.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHuTUM1Zkw2tNAA--.10375S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxtF1UWFWDuw18tr4UXFWDArb_yoW7CFyrpF
        Wag3ySkrZ0yF1a9FyIvwnrXr1fGa1xWr4xWa17Xr45G3ZYqFnYgr17Kan0gFWUtr1kJas5
        ZFnrXr90gr1qvwUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj
        6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU0XdjtUUUUU==
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

