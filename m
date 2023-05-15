Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E7C7EE22
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 04:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbjEOEIm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 00:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjEOEIl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 00:08:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BACE74
        for <linux-perf-users@vger.kernel.org>; Sun, 14 May 2023 21:08:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-52cbd7e73d2so9033619a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 May 2023 21:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684123719; x=1686715719;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UHSc8xLAvWs1P/itJCkOeE9l7NSQeoADD1ju3ti48NM=;
        b=Nx29wtBubx3Eof3MsIuRkY6aZsrdm5w/b+gDvUYbVEyf7upkSMSHA3pNaUPu8VgpDq
         LcV2wHc9cYYZxCEgZL4RKEtgcJz7ZkdQGyjdOOk6WOKUqqPa6LAlUIXxVx2PQ9EyBiIT
         Xv/kmNgwltr7zaRe/3H7dND0/xqiQNXn593dVJO9OXaSaLuhaUusQY/49GTEqfyHtbX6
         SMLopX2Xt03iOLQF/Xy3g3xKt1GSEhXT9nyBFWYL9bsJcQiUd/WJ5rFo6pEfY+aXWY0Y
         /Cn++B7sAcn5W7yuSmjLD4iwHLv3nGdsdkiaxDvTjOp8VPy3fA/P2wPAptUwrDULroAb
         D1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684123719; x=1686715719;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHSc8xLAvWs1P/itJCkOeE9l7NSQeoADD1ju3ti48NM=;
        b=gan7+fy9EdDlAHm+Irws3zrUrWHht7qHDe5CjT4RcbBI8PUZVRJqdnDue6RnWnGFbb
         P2LWCbzBrmX+KpEANIPAC9l1XxSbjQUtEal1QU19puur30TkgWf5wP6O3ULDi5xI1r+s
         2FVlGdZTHnQvr4PvOsLI3HIuq0Qb8AysANDnO2ttipbz0f11WJ543X39M/kYzM2jaUOQ
         HZnF5L0y2SxLZXfgcm5NOGCgtr0rPmq+pUIEa6WPgxXHGgAY7JiIkYTX11rCEAO369LT
         LPRDcvw/G/8gOr0rf2/Imunt3XAw2Ur5QMgh0r0w/AiUaliJEmuuBnYhqjG55YYYun35
         Zb1w==
X-Gm-Message-State: AC+VfDzt8MijOTa8BZ/Palh66LbBcx1XX4CHcXcUKD5fi33WUdABeq8r
        Dgu7xPy3xJzsSIaC6V4Vix2VPw==
X-Google-Smtp-Source: ACHHUZ76cZo6lOfe+4KgQ/rcxFJ/N2HwuKSErLP00A5AomKaQF/e90baPIOxAmH0c01z0iOxepAJNg==
X-Received: by 2002:a17:902:c40d:b0:1ab:2034:26da with SMTP id k13-20020a170902c40d00b001ab203426damr42536047plk.51.1684123719070;
        Sun, 14 May 2023 21:08:39 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.119])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902a40a00b001acae9734c0sm6193879plq.266.2023.05.14.21.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 21:08:38 -0700 (PDT)
Date:   Mon, 15 May 2023 12:08:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yanteng Si <siyanteng@loongson.cn>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 17/17] tools arch arm64: Sync the perf_regs headers
 with the kernel sources
Message-ID: <20230515040832.GB1826330@leoy-yangtze.lan>
References: <cover.1683712944.git.siyanteng@loongson.cn>
 <84e48c9d165a71c30b7a299baaa87a22c578ca0a.1683712945.git.siyanteng@loongson.cn>
 <ZFu3sY4AuuCGb9Nw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFu3sY4AuuCGb9Nw@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 10, 2023 at 12:26:41PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 10, 2023 at 06:25:24PM +0800, Yanteng Si escreveu:
> > Picking the changes from:
> > 
> >   commit aa3e49b606e0796a ("arm64: asm/perf_regs.h: Avoid C++-style
> >    comment in UAPI header")
> >   commit 2ee0d7fd36a3f87b ("ARM64: perf: add support for perf
> >    registers API")
> >   commit cbb0c02caf4bd98b ("perf: arm64: Add SVE vector granule
> >    register to user regs")
> > 
> > Silencing these perf build warnings:
> > 
> >   Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi
> >    /asm/perf_regs.h' differs from latest version at 'arch/arm64
> >     /include/uapi/asm/perf_regs.h'
> >   diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64
> >    /include/uapi/asm/perf_regs.h
> > 
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > ---
> >  tools/arch/arm64/include/uapi/asm/perf_regs.h | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> > index fd157f46727e..86e556429e0e 100644
> > --- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
> > +++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> > @@ -36,11 +36,13 @@ enum perf_event_arm_regs {
> >  	PERF_REG_ARM64_LR,
> >  	PERF_REG_ARM64_SP,
> >  	PERF_REG_ARM64_PC,
> > +	PERF_REG_ARM64_MAX,
> >  
> >  	/* Extended/pseudo registers */
> > -	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
> > -
> > -	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
> > -	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1
> > +	PERF_REG_ARM64_VG = 46,				/* SVE Vector Granule */
> > +	PERF_REG_ARM64_EXTENDED_MAX
> >  };
> > +
> > +#define PERF_REG_EXTENDED_MASK	(1ULL << PERF_REG_ARM64_VG)
> > +
> >  #endif /* _ASM_ARM64_PERF_REGS_H */
> 
> This needs some more work, note that -DCORESIGHT=1 in the make command line.

On the mainline kernel, the patch cbb0c02caf4bd ("perf: arm64: Add SVE
vector granule register to user regs") and f450f11b2d3f ("perf tools
arm64: Copy perf_regs.h from the kernel") are to update headers for
kernel header and tool's header respectively, but there are not
aligned with each other.  So Yanteng's patch is valid and we should
pick up it.

However, as Arnaldo tested, Yanteng's patch introduces building
regression due to arm64 and x86 both defines the macro
PERF_REG_EXTENDED_MASK, but this macro actually is architecture
specific.

The issue is now we use a single file util/perf_regs.c to maintain
perf register related stuffs for all architectures, this is fragile
since we cannot have any duplicated naming (e.g. for macros, structure
name, etc).  We need to refactor the source file util/perf_regs.c to
move architecture specific code into arch folders and only keep common
code.

@James, you is the best person to know this part for arm64.  If you
have already worked on this, please let me know.  Otherwise, I can
prepare a patch set for this, I tried a bit but found I cannot just
use a single patch to refactor util/perf_regs.c.

Thanks,
Leo

> I added some ARM folks that may help you,
> 
> - Arnaldo
> 
>   CC      /tmp/build/perf-tools/util/arm64-frame-pointer-unwind-support.o
>   CC      /tmp/build/perf-tools/util/perf_regs.o
>   CC      /tmp/build/perf-tools/util/header.o
> In file included from util/arm64-frame-pointer-unwind-support.c:9:
> util/../../arch/arm64/include/uapi/asm/perf_regs.h:46: error: "PERF_REG_EXTENDED_MASK" redefined [-Werror]
>    46 | #define PERF_REG_EXTENDED_MASK  (1ULL << PERF_REG_ARM64_VG)
>       | 
> In file included from /var/home/acme/git/perf-tools/tools/perf/arch/x86/include/perf_regs.h:7,
>                  from util/perf_regs.h:33,
>                  from util/arm64-frame-pointer-unwind-support.c:5:
> /var/home/acme/git/perf-tools/tools/arch/x86/include/uapi/asm/perf_regs.h:56: note: this is the location of the previous definition
>    56 | #define PERF_REG_EXTENDED_MASK  (~((1ULL << PERF_REG_X86_XMM0) - 1))
>       | 
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:97: /tmp/build/perf-tools/util/arm64-frame-pointer-unwind-support.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> In file included from util/perf_regs.c:26:
> util/../../arch/arm64/include/uapi/asm/perf_regs.h:46: error: "PERF_REG_EXTENDED_MASK" redefined [-Werror]
>    46 | #define PERF_REG_EXTENDED_MASK  (1ULL << PERF_REG_ARM64_VG)
>       | 
> In file included from /var/home/acme/git/perf-tools/tools/perf/arch/x86/include/perf_regs.h:7,
>                  from util/perf_regs.h:33,
>                  from util/perf_regs.c:4:
> /var/home/acme/git/perf-tools/tools/arch/x86/include/uapi/asm/perf_regs.h:56: note: this is the location of the previous definition
>    56 | #define PERF_REG_EXTENDED_MASK  (~((1ULL << PERF_REG_X86_XMM0) - 1))
>       | 
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:97: /tmp/build/perf-tools/util/perf_regs.o] Error 1
> make[3]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:140: util] Error 2
> make[2]: *** [Makefile.perf:676: /tmp/build/perf-tools/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:236: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf-tools/tools/perf'
> 
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools -C tools/perf install-bin':
> 
>        12326009385      cycles:u                                                              
>        20646679547      instructions:u                   #    1.68  insn per cycle            
> 
>        4.225375000 seconds time elapsed
> 
>        2.853093000 seconds user
>        1.630218000 seconds sys
> 
> 
> ⬢[acme@toolbox perf-tools]$
