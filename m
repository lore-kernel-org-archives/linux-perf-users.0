Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAB4C7EE22
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 11:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjEFLEr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjEFLEp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 07:04:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CC2661AE
        for <linux-perf-users@vger.kernel.org>; Sat,  6 May 2023 04:04:44 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8BxRPBLNFZkN70FAA--.9597S3;
        Sat, 06 May 2023 19:04:43 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxOLZINFZkMWxNAA--.9895S4;
        Sat, 06 May 2023 19:04:42 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     peterz@infradead.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 07/18] tools headers UAPI: Sync the linux/perf_event.h with the kernel headers
Date:   Sat,  6 May 2023 19:04:09 +0800
Message-Id: <e5b264c4f5880cc3c2e46c803e53a6a592aa3310.1683370076.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683370076.git.siyanteng@loongson.cn>
References: <cover.1683370076.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxOLZINFZkMWxNAA--.9895S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kw4UXF1xGw13GryfWr1Dtrb_yoW8Jw48pr
        s5C3yfGrWUXF4UA34rJw1UK345W3y7WFsaq34agr4DAFs3ta95Za97ua1Yyrn7Jr48AFWY
        v3yxX39xK34avFJanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
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

  commit 09519ec3b19e4144 ("perf: Add perf_event_attr::config3")
  commit cb6c18b5a41622c7 ("perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to
   PERF_MEM_LVLNUM_CXL")

Silencing these perf build warnings::

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h'
   differs from latest version at 'include/uapi/linux/perf_event.h'
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux
   /perf_event.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/include/uapi/linux/perf_event.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 39c6a250dd1b..37675437b768 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1339,8 +1339,7 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0x7 available */
-#define PERF_MEM_LVLNUM_UNC	0x08 /* Uncached */
+/* 5-0x8 available */
 #define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
 #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
-- 
2.31.4

