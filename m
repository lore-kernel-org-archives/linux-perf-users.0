Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6967DC7EE23
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 10:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbjEJKWZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 06:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjEJKWX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 06:22:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55D4B30C0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 03:22:20 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.74])
        by gateway (Coremail) with SMTP id _____8BxJulbcFtkmlMHAA--.12278S3;
        Wed, 10 May 2023 18:22:19 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.74])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxMuVXcFtkGfJTAA--.18233S2;
        Wed, 10 May 2023 18:22:16 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 00/17] tools perf: fix build warnings
Date:   Wed, 10 May 2023 18:21:43 +0800
Message-Id: <cover.1683712944.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxMuVXcFtkGfJTAA--.18233S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWr1fXFWUGF4UtrWDJF1kXwb_yoW5CryDpF
        nakFZ5ta1DWrWfAwnxCr4jvFyruws3Za1Yg34xWryvqa1YqFykAw1xuF1UKFnrtrZ7JF40
        kry7Wr15Ka4kZaUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8
        JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jYE_NUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

v2:

* Drop <tools arch s390: Sync the ptrace headers with the kernel sources>
   Because ptrace.h has been fixed in other tree, detail see:
    selftests/bpf: Remove not used headers
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1f265d2aea0d
    tools headers: Remove s390 ptrace.h in check-headers.sh
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed4da0d3de1e

* BTW, I made these patches in the next tree, so most of the warnings haven't appeared in the perf tree yet. :)


v1:
* When I try to build perf, a lot of warnings are output, let's fix them.

Yanteng Si (17):
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

 tools/arch/arm64/include/uapi/asm/kvm.h       | 36 ++++++++++++
 tools/arch/arm64/include/uapi/asm/perf_regs.h | 10 ++--
 tools/arch/x86/include/asm/cpufeatures.h      | 28 +++++++--
 .../arch/x86/include/asm/disabled-features.h  | 24 +++++++-
 tools/arch/x86/include/asm/msr-index.h        |  2 +
 tools/arch/x86/include/uapi/asm/kvm.h         |  3 +
 tools/arch/x86/include/uapi/asm/prctl.h       | 20 +++++++
 tools/arch/x86/lib/memcpy_64.S                | 35 ++++--------
 tools/arch/x86/lib/memset_64.S                | 47 ++++-----------
 tools/include/linux/coresight-pmu.h           | 13 -----
 tools/include/uapi/asm-generic/unistd.h       |  5 +-
 tools/include/uapi/drm/drm.h                  | 57 ++++++++++++++++++-
 tools/include/uapi/drm/i915_drm.h             | 25 +++++++-
 tools/include/uapi/linux/const.h              |  2 +-
 tools/include/uapi/linux/in.h                 |  1 +
 tools/include/uapi/linux/kvm.h                | 12 +++-
 tools/include/uapi/linux/mman.h               | 14 +++++
 tools/include/uapi/linux/perf_event.h         |  3 +-
 tools/include/uapi/linux/prctl.h              |  2 +
 tools/include/uapi/sound/asound.h             | 14 +++--
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  2 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
 22 files changed, 258 insertions(+), 99 deletions(-)

-- 
2.31.4

