Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73CAC7EE25
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 17:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbjEJRGb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 13:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjEJRGY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 13:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E535B80
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 10:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54EE564A28
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 17:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88975C433D2;
        Wed, 10 May 2023 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738371;
        bh=ciw8gBiMmXFt108khYiQ3plxIX9TkPMUHUip7SKlsPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LWUPcUyhpa8ukErlBB7UskjzponOKGcCmxBtORstClrvTGfK73Rw+imK2Ho75b/rN
         /ZK0wmsu2sQkNwKSArBYPuAtH2pySRfHCFismiEff6IH20tGQwwGZHWKP5Rvr6HBaL
         E3J075pPNUv8c03KuW6AmwqWfylZqri3Fs1KfGRW1h7x2HDMuXBiFnFROOd8M8QWbI
         I3BrTuoRMc7L9DNALBOMGNrBHc0SOfDU50HrjVZGPOQCmbeY/OJ7gQhfAc+Et+Bz4Y
         HGwFjaZMaDsJhmaR3FLCPOcl5EpE/EQIk3QsQvldUviW4wAHVDun9Y7GL0jpglOuYy
         DKPig1Y8oxvmg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AEF48403B5; Wed, 10 May 2023 14:06:08 -0300 (-03)
Date:   Wed, 10 May 2023 14:06:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 00/17] tools perf: fix build warnings
Message-ID: <ZFvPAB4Lrcl1CcPz@kernel.org>
References: <cover.1683712944.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1683712944.git.siyanteng@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 10, 2023 at 06:21:43PM +0800, Yanteng Si escreveu:
> v2:

So had to drop the ones I explicitely replied due to build failures and
then some more because this is usually done when the window closes, i.e.
for v6.4, so that when it is finally released we don't have warnings
building perf.

The ones I applied:

⬢[acme@toolbox perf-tools]$ git log --oneline 558423699d9b37de..
79ae55cb5aa77ac2 (HEAD -> perf-tools) tools arch x86: Sync the msr-index.h copy with the kernel sources
d48eb7d03dcd623a tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the kernel sources
14665fa481b7c947 tools include UAPI: Sync the sound/asound.h copy with the kernel sources
42252bb99c0eab81 tools headers UAPI: Sync the linux/const.h with the kernel headers
fcee73a84ed92b77 tools headers UAPI: Sync the i915_drm.h with the kernel sources
82fed3e30b2319e5 tools headers UAPI: Sync the drm/drm.h with the kernel sources
a7919a256f89bea6 tools headers UAPI: Sync the linux/in.h with the kernel sources
⬢[acme@toolbox perf-tools]$

- Arnaldo
 
> * Drop <tools arch s390: Sync the ptrace headers with the kernel sources>
>    Because ptrace.h has been fixed in other tree, detail see:
>     selftests/bpf: Remove not used headers
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1f265d2aea0d
>     tools headers: Remove s390 ptrace.h in check-headers.sh
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed4da0d3de1e
> 
> * BTW, I made these patches in the next tree, so most of the warnings haven't appeared in the perf tree yet. :)
> 
> 
> v1:
> * When I try to build perf, a lot of warnings are output, let's fix them.
> 
> Yanteng Si (17):
>   tools headers UAPI: Sync the linux/in.h with the kernel sources
>   tools headers UAPI: Sync the linux/prctl.h with the kernel sources
>   tools headers UAPI: Sync the drm/drm.h with the kernel sources
>   tools headers UAPI: Sync the i915_drm.h with the kernel sources
>   tools headers UAPI: Sync the coresight-pmu headers copy with the
>     kernel sources
>   tools headers UAPI: Sync the linux/const.h with the kernel headers
>   tools headers UAPI: Sync the linux/perf_event.h with the kernel
>     headers
>   tools include UAPI: Sync the sound/asound.h copy with the kernel
>     sources
>   tools headers UAPI: Sync the linux/mman.h with the kernel sources
>   tools headers UAPI: Sync the unistd with the kernel sources
>   tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the kernel
>     sources
>   tools arch x86: Sync the disabled-features with the kernel sources
>   tools arch x86: Sync the memcpy_64 with the kernel sources
>   tools arch x86: Sync the cpufeatures with the kernel sources
>   tools arch x86: Sync the msr-index.h copy with the kernel sources
>   tools arch x86: Sync the prctl headers with the kernel sources
>   tools arch arm64: Sync the perf_regs headers with the kernel sources
> 
>  tools/arch/arm64/include/uapi/asm/kvm.h       | 36 ++++++++++++
>  tools/arch/arm64/include/uapi/asm/perf_regs.h | 10 ++--
>  tools/arch/x86/include/asm/cpufeatures.h      | 28 +++++++--
>  .../arch/x86/include/asm/disabled-features.h  | 24 +++++++-
>  tools/arch/x86/include/asm/msr-index.h        |  2 +
>  tools/arch/x86/include/uapi/asm/kvm.h         |  3 +
>  tools/arch/x86/include/uapi/asm/prctl.h       | 20 +++++++
>  tools/arch/x86/lib/memcpy_64.S                | 35 ++++--------
>  tools/arch/x86/lib/memset_64.S                | 47 ++++-----------
>  tools/include/linux/coresight-pmu.h           | 13 -----
>  tools/include/uapi/asm-generic/unistd.h       |  5 +-
>  tools/include/uapi/drm/drm.h                  | 57 ++++++++++++++++++-
>  tools/include/uapi/drm/i915_drm.h             | 25 +++++++-
>  tools/include/uapi/linux/const.h              |  2 +-
>  tools/include/uapi/linux/in.h                 |  1 +
>  tools/include/uapi/linux/kvm.h                | 12 +++-
>  tools/include/uapi/linux/mman.h               | 14 +++++
>  tools/include/uapi/linux/perf_event.h         |  3 +-
>  tools/include/uapi/linux/prctl.h              |  2 +
>  tools/include/uapi/sound/asound.h             | 14 +++--
>  .../perf/arch/s390/entry/syscalls/syscall.tbl |  2 +-
>  .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
>  22 files changed, 258 insertions(+), 99 deletions(-)
> 
> -- 
> 2.31.4
> 

-- 

- Arnaldo
