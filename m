Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7297AC7EE2A
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 11:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjEFLEs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 07:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjEFLEq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 07:04:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03E5672BC
        for <linux-perf-users@vger.kernel.org>; Sat,  6 May 2023 04:04:44 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8Cx9ehMNFZkQL0FAA--.9484S3;
        Sat, 06 May 2023 19:04:44 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxOLZINFZkMWxNAA--.9895S5;
        Sat, 06 May 2023 19:04:43 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     peterz@infradead.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 08/18] tools include UAPI: Sync the sound/asound.h copy with the kernel sources
Date:   Sat,  6 May 2023 19:04:10 +0800
Message-Id: <2a7370a649c72d28cff0f9b00856c41ce6c3db7f.1683370076.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683370076.git.siyanteng@loongson.cn>
References: <cover.1683370076.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxOLZINFZkMWxNAA--.9895S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KF4rZw45CryxtF1rCryfZwb_yoW5JF1kpF
        4kGFykGr47Jry0va15JF109ryFyrsFkF90k39F9w10v3WakFySqr4IkF4YyFn8CrsrAw1S
        9FZFg34rG398trJanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0Ex4A2
        jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2nmiUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Picking the changes from:

  commit 102882b5c62f6bfe ("ALSA: document that struct
   __snd_pcm_mmap_control64 is messed up")
  commit 9f656705c5faa18a ("ALSA: pcm: rewrite
   snd_pcm_playback_silence()")

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h'
   differs from latest version at 'include/uapi/sound/asound.h'
  diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/include/uapi/sound/asound.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index de6810e94abe..0aa955aa8246 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -429,9 +429,14 @@ struct snd_pcm_sw_params {
 	snd_pcm_uframes_t avail_min;		/* min avail frames for wakeup */
 	snd_pcm_uframes_t xfer_align;		/* obsolete: xfer size need to be a multiple */
 	snd_pcm_uframes_t start_threshold;	/* min hw_avail frames for automatic start */
-	snd_pcm_uframes_t stop_threshold;	/* min avail frames for automatic stop */
-	snd_pcm_uframes_t silence_threshold;	/* min distance from noise for silence filling */
-	snd_pcm_uframes_t silence_size;		/* silence block size */
+	/*
+	 * The following two thresholds alleviate playback buffer underruns; when
+	 * hw_avail drops below the threshold, the respective action is triggered:
+	 */
+	snd_pcm_uframes_t stop_threshold;	/* - stop playback */
+	snd_pcm_uframes_t silence_threshold;	/* - pre-fill buffer with silence */
+	snd_pcm_uframes_t silence_size;		/* max size of silence pre-fill; when >= boundary,
+						 * fill played area with silence immediately */
 	snd_pcm_uframes_t boundary;		/* pointers wrap point */
 	unsigned int proto;			/* protocol version */
 	unsigned int tstamp_type;		/* timestamp type (req. proto >= 2.0.12) */
@@ -570,7 +575,8 @@ struct __snd_pcm_mmap_status64 {
 struct __snd_pcm_mmap_control64 {
 	__pad_before_uframe __pad1;
 	snd_pcm_uframes_t appl_ptr;	 /* RW: appl ptr (0...boundary-1) */
-	__pad_before_uframe __pad2;
+	__pad_before_uframe __pad2;	 // This should be __pad_after_uframe, but binary
+					 // backwards compatibility constraints prevent a fix.
 
 	__pad_before_uframe __pad3;
 	snd_pcm_uframes_t  avail_min;	 /* RW: min available frames for wakeup */
-- 
2.31.4

