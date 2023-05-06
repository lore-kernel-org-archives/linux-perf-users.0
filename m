Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E8EC77B73
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 11:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjEFLCy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjEFLCt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 07:02:49 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DD3259D7
        for <linux-perf-users@vger.kernel.org>; Sat,  6 May 2023 04:02:47 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8BxJunWM1Zk3bwFAA--.9415S3;
        Sat, 06 May 2023 19:02:46 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHuTUM1Zkw2tNAA--.10375S2;
        Sat, 06 May 2023 19:02:45 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     peterz@infradead.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 00/18] tools perf: fix build warning
Date:   Sat,  6 May 2023 19:01:54 +0800
Message-Id: <cover.1683370076.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHuTUM1Zkw2tNAA--.10375S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr4DCrykurW5AF45ur15urg_yoW5GF17pF
        nakFWvya1DWFWfAwn8CF4qvry8u39agF4Yg3yxWr92qa15tFykAr1xuF1UKFnrt397tF10
        9Fy7Wr15Ka4kZF7anT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I
        6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
        CTnIWIevJa73UjIFyTuYvjxUcApnDUUUU
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When I try to build perf, a lot of warnings are output, let's fix them.

Yanteng Si (18):
  tools headers UAPI: Sync the linux/in.h with the kernel sources
  tools headers UAPI: Sync the linux/prctl.h with the kernel sources
  tools headers UAPI: Sync the drm/drm.h with the kernel sources
  tools headers UAPI: Sync the i915_drm.h with the kernel sources
  tools headers UAPI: Sync the coresight-pmu headers copy with the
    kernel sources
  tools headers UAPI: Sync the linux/const.h with the kernel headers
  tools headers UAPI: Sync the linux/perf_event.h with the kernel
    headers
  tools include UAPI: Sync the sound/asound.h copy with the kernel
    sources
  tools headers UAPI: Sync the linux/mman.h with the kernel sources
  tools headers UAPI: Sync the unistd with the kernel sources
  tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the kernel
    sources
  tools arch x86: Sync the disabled-features with the kernel sources
  tools arch x86: Sync the memcpy_64 with the kernel sources
  tools arch x86: Sync the cpufeatures with the kernel sources
  tools arch x86: Sync the msr-index.h copy with the kernel sources
  tools arch x86: Sync the prctl headers with the kernel sources
  tools arch arm64: Sync the perf_regs headers with the kernel sources
  tools arch s390: Sync the ptrace headers with the kernel sources

 tools/arch/arm64/include/uapi/asm/kvm.h       |  36 ++
 tools/arch/arm64/include/uapi/asm/perf_regs.h |  10 +-
 tools/arch/s390/include/uapi/asm/ptrace.h     | 458 ++++++++++++++++++
 tools/arch/x86/include/asm/cpufeatures.h      |  28 +-
 .../arch/x86/include/asm/disabled-features.h  |  24 +-
 tools/arch/x86/include/asm/msr-index.h        |   2 +
 tools/arch/x86/include/uapi/asm/kvm.h         |   3 +
 tools/arch/x86/include/uapi/asm/prctl.h       |  20 +
 tools/arch/x86/lib/memcpy_64.S                |  35 +-
 tools/arch/x86/lib/memset_64.S                |  47 +-
 tools/include/linux/coresight-pmu.h           |  13 -
 tools/include/uapi/asm-generic/unistd.h       |   5 +-
 tools/include/uapi/drm/drm.h                  |  57 ++-
 tools/include/uapi/drm/i915_drm.h             |  25 +-
 tools/include/uapi/linux/const.h              |   2 +-
 tools/include/uapi/linux/in.h                 |   1 +
 tools/include/uapi/linux/kvm.h                |  12 +-
 tools/include/uapi/linux/mman.h               |  14 +
 tools/include/uapi/linux/perf_event.h         |   3 +-
 tools/include/uapi/linux/prctl.h              |   2 +
 tools/include/uapi/sound/asound.h             |  14 +-
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   2 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   2 +
 23 files changed, 716 insertions(+), 99 deletions(-)
 create mode 100644 tools/arch/s390/include/uapi/asm/ptrace.h

-- 
2.31.4

