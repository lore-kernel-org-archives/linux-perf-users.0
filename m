Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B0BC433E9
	for <linux-perf-users@archiver.kernel.org>; Sat,  9 Jan 2021 09:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17A523A79
	for <linux-perf-users@archiver.kernel.org>; Sat,  9 Jan 2021 09:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbhAII77 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 9 Jan 2021 03:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbhAII77 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 9 Jan 2021 03:59:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66129C061786
        for <linux-perf-users@vger.kernel.org>; Sat,  9 Jan 2021 00:59:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c12so7793277pfo.10
        for <linux-perf-users@vger.kernel.org>; Sat, 09 Jan 2021 00:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version;
        bh=wN9cewZw1rEgawFFah78eSjUxeD7cVJrpgL94TErRzk=;
        b=oTzNfe77AMDlcu879/MisWv4649hNSH4Pb2II7UWAJ4DBzVxE2f+TYvmK7iZM6gw2R
         rRSfvnRXBeBndnGp9S+VAQ2hWFjsNXCjwJRAIiu7CAmgRA8BdQRw18WnJirHlsqY66Q0
         aBlZEeYEF8XF/p/COVldsmFX3xxu66HLkQ/O9J7+y50C91HxErHB+8JJTF9qr6poE240
         tebIcYqgkpgOEez7B3YufTDwoXklLiWuOAwg1NNrjkKMfYeiFo3Y3/t3YDDhKESiXO1o
         tu1tKXi5QaCCoXtr+NiJisgbg/Io2XdHzkuHMj1EeEbz2ZCiXvIZ1qUnERH8oNEeYgz/
         Zt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version;
        bh=wN9cewZw1rEgawFFah78eSjUxeD7cVJrpgL94TErRzk=;
        b=AU5fADdZFwqr60TeOMeYMXp3jl2PzUo9p6mlyt1+t0oXc9/zrxscaEhRs3uiKHs5QW
         gCMJ972LaIIr4s+zSZIPE/FGXR2rWxOi0BMWMwpU22x0IZgMdZ13ghFIvwtxwRhEAsgd
         TIdnwNxwtVRbD2b8Cak2zBEM1LZwAS8x0a8/5FD4AYrvvYy7YZW8MFhsJPD+tVeu5cfX
         r7A2PlKyS3OBahv1JL9/dJY8CEvKkvk+C4dLE3/wY/JNKZ9b1GXP43pCGitf6ihy9lWL
         P7dFTZ0I4reWeZwwRMQ87hEzHup9jKAzhhqq5xeXgnKyAUvOQ7D15mcxXunAlz8hR5Q7
         ad4A==
X-Gm-Message-State: AOAM532aduLBITCVPV/6eatW+GpihSz8zmqgzxpM8K3ZuL1tD4sTN2Bt
        nQvjBFOERARcMtt4oN2t/qDUs8u56us=
X-Google-Smtp-Source: ABdhPJxJ+et5rmgCMpoAL+nNEHCTPJ0ZU0tUx8xLV9bpurAun7fUsGMXl2LRvFWeAx/M3cdUNPJGVg==
X-Received: by 2002:a63:947:: with SMTP id 68mr10969345pgj.279.1610182758520;
        Sat, 09 Jan 2021 00:59:18 -0800 (PST)
Received: from [0.0.0.0] (tunnel595741-pt.tunnel.tserv22.tyo1.ipv6.he.net. [2001:470:23:8a4::2])
        by smtp.gmail.com with ESMTPSA id v19sm7593297pjg.50.2021.01.09.00.59.16
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 00:59:17 -0800 (PST)
To:     linux-perf-users@vger.kernel.org
From:   Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [BUG] JIT symbols not resolved after mprotect() combined vma
Message-ID: <40d550d6-e698-fad2-be81-aab6a56c5e64@gmail.com>
Date:   Sat, 9 Jan 2021 16:59:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------50B2E399DEF5A744A96073DA"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------50B2E399DEF5A744A96073DA
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

   I'm using perf to measure my LLVM jitted code performance. However, I 
found with some condition, perf will unable to resolve or annotate JIT 
symbols. After some debugging, I found the cause is mprotect() combined 
two adjacent vma, and report a MMAP2 event of merged vma, confusing perf.
   I wrote a sample program (sample.c). It creates function computing 
factorial. First it creates test1() and exec it for 10000 times. Then, 
it creates test2() and exec both test1() and test2() for 10000 times 
respectively. As a result, test1() was executed 20000 times, and test2() 
was executed 10000 times.
   However, perf report shows:

   33.33%  a.out    jitted-10742-3.so    [.] test2
   33.30%  a.out    jitted-10742-2.so    [.] test1
   33.26%  a.out    [JIT] tid 10742      [.] 0x00007f4b8cb3d010 // test1

   This is because LLVM create jitted code by using mmap() and 
mprotect(): (the address is different because of ASLR)

//// compile test1
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fca1a491000
mprotect(0x7fca1a491000, 4096, PROT_READ|PROT_EXEC) = 0
//// compile test2
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fca1a490000
mprotect(0x7fca1a490000, 4096, PROT_READ|PROT_EXEC) = 0

   The second mprotect will merge two adjacent vma, and report a MMAP2 
event of merged vma. The pref tool saw this:

9547033496331 0x2510 [0x60]: PERF_RECORD_MMAP2 10742/10742: 
[0x7f4b8cb3d000(0x2000) @ 0x7f4b8cb3d000 00:00 0 0]: r-xp //anon
9547033524086 0xf00 [0xb0]: PERF_RECORD_MMAP2 10742/10742: 
[0x7f4b8cb3d000(0x18) @ 0x40 08:02 10224200 1]: --xs 
/home/zby/src/qemuproject/qemu/.debug/jit/llvm-IR-jit-20210109-ad4573/jitted-10742-2.so
9553628266188 0x103898 [0x60]: PERF_RECORD_MMAP2 10742/10742: 
[0x7f4b8cb3c000(0x3000) @ 0x7f4b8cb3c000 00:00 0 0]: r-xp //anon
9553628283472 0xfb0 [0xb0]: PERF_RECORD_MMAP2 10742/10742: 
[0x7f4b8cb3c000(0x18) @ 0x40 08:02 10224201 1]: --xs 
/home/zby/src/qemuproject/qemu/.debug/jit/llvm-IR-jit-20210109-ad4573/jitted-10742-3.so

   The event of third line, confusing perf, make it thinks test1() had 
disappear. Then perf if unable to resolve test1() or annotate it.


Thank you very much!
Zhang Boyang

--------------50B2E399DEF5A744A96073DA
Content-Type: text/x-csrc; charset=UTF-8;
 name="sample.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sample.c"

// Compile me with: (NOTE: LLVM must be compiled with LLVM_USE_PERF=On)
//   gcc -O2 -Wall sample.c $(llvm-config --cflags --ldflags --libs --system-libs) -lstdc++
// Run me with:
//   perf record -k 1 ./a.out
// View perf result with:
//   perf inject -j -i perf.data -o perf.data.jitted && perf report -i perf.data.jitted


#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <llvm-c/Core.h>
#include <llvm-c/Target.h>
#include <llvm-c/Orc.h>
#include <llvm-c/OrcEE.h>
#include <llvm-c/LLJIT.h>
#include <llvm-c/Analysis.h>
#include <llvm-c/Transforms/PassManagerBuilder.h>

static LLVMOrcLLJITRef jit;
static LLVMOrcThreadSafeContextRef tsctx;
static LLVMContextRef ctx;
static LLVMBuilderRef bldr;
static LLVMOrcJITDylibRef jd;
static LLVMPassManagerBuilderRef pmb;
static LLVMPassManagerRef mpm;
static LLVMTypeRef int_ty;
static LLVMValueRef int_0, int_1;

typedef int (*MyFunc)(int n);

static inline void check_error(LLVMErrorRef e)
{
    if (e) {
        char *m = LLVMGetErrorMessage(e);
        puts(m);
        LLVMDisposeErrorMessage(m);
        exit(1);
    }
}
static inline void dump_module(LLVMModuleRef mdl)
{
    char *str = LLVMPrintModuleToString(mdl);
    puts(str);
    LLVMDisposeMessage(str);
}

static MyFunc create_function(const char *name)
{
    LLVMModuleRef mod;
    LLVMValueRef fn, next;
    LLVMTypeRef fn_type;
    LLVMBasicBlockRef entry_bb, recurse_bb, return_bb;
    LLVMOrcJITTargetAddress addr;
    LLVMOrcThreadSafeModuleRef tsm;

    mod = LLVMModuleCreateWithNameInContext(name, ctx);
    fn_type = LLVMFunctionType(int_ty, &int_ty, 1, 0);

    fn = LLVMAddFunction(mod, name, fn_type);
    entry_bb = LLVMAppendBasicBlockInContext(ctx, fn, "entrybb");
    recurse_bb = LLVMAppendBasicBlockInContext(ctx, fn, "recursebb");
    return_bb = LLVMAppendBasicBlockInContext(ctx, fn, "returnbb");

    LLVMPositionBuilderAtEnd(bldr, entry_bb);
    LLVMBuildCondBr(bldr,
        LLVMBuildICmp(bldr,
            LLVMIntEQ,
            LLVMGetParam(fn, 0),
            int_0, ""),
        return_bb,
        recurse_bb);
    
    LLVMPositionBuilderAtEnd(bldr, return_bb);
    LLVMBuildRet(bldr, int_1);

    LLVMPositionBuilderAtEnd(bldr, recurse_bb);
    next = LLVMBuildSub(bldr,
        LLVMGetParam(fn, 0),
        int_1, "");
    LLVMBuildRet(bldr,
        LLVMBuildMul(bldr,
            LLVMBuildCall(bldr, fn, &next, 1, ""),
            LLVMGetParam(fn, 0), ""));

    LLVMVerifyFunction(fn, LLVMAbortProcessAction);

    LLVMRunPassManager(mpm, mod);
    //dump_module(mod);

    tsm = LLVMOrcCreateNewThreadSafeModule(mod, tsctx);
    check_error(LLVMOrcLLJITAddLLVMIRModule(jit, jd, tsm));
    LLVMOrcLLJITLookup(jit, &addr, name);
    
    printf("COMPILE DONE! %s = %p\n", name, (void *)addr);
    return (void *)addr;
}

static LLVMOrcObjectLayerRef create_oll(
    void *Ctx, LLVMOrcExecutionSessionRef ES, const char *Triple)
{
    LLVMOrcObjectLayerRef ol;
    LLVMJITEventListenerRef perf;
    ol = LLVMOrcCreateRTDyldObjectLinkingLayerWithSectionMemoryManager(ES);
    perf = LLVMCreatePerfJITEventListener();
    assert(perf); // LLVM must be compiled with LLVM_USE_PERF=On
    LLVMOrcRTDyldObjectLinkingLayerRegisterJITEventListener(ol, perf);
    return ol;
}

int main()
{
    int i;
    MyFunc factorial, test1, test2;
    LLVMOrcLLJITBuilderRef jb;

    LLVMInitializeNativeTarget();
    LLVMInitializeNativeAsmPrinter();
    LLVMInitializeNativeAsmParser();

    jb = LLVMOrcCreateLLJITBuilder();
    LLVMOrcLLJITBuilderSetObjectLinkingLayerCreator(jb, create_oll, NULL);

    check_error(LLVMOrcCreateLLJIT(&jit, jb));
    tsctx = LLVMOrcCreateNewThreadSafeContext();
    ctx = LLVMOrcThreadSafeContextGetContext(tsctx);
    bldr = LLVMCreateBuilderInContext(ctx);
    jd = LLVMOrcLLJITGetMainJITDylib(jit);
    
    pmb = LLVMPassManagerBuilderCreate();
    mpm = LLVMCreatePassManager();
    LLVMPassManagerBuilderSetOptLevel(pmb, 2);
    LLVMPassManagerBuilderPopulateModulePassManager(pmb, mpm);

    int_ty = LLVMInt32TypeInContext(ctx);
    int_0 = LLVMConstInt(int_ty, 0, 0);
    int_1 = LLVMConstInt(int_ty, 1, 0);

    factorial = create_function("factorial");
    printf("10! = %d\n", factorial(10)); // should be 3628800

    puts("TEST BEGIN!");
    test1 = create_function("test1");
    for (i = 0; i < 10000; i++) {
        test1(1000000);
    }
    test2 = create_function("test2");
    for (i = 0; i < 10000; i++) {
        test1(1000000);
        test2(1000000);
    }
    puts("TEST END!");
    return 0;
}

--------------50B2E399DEF5A744A96073DA--
