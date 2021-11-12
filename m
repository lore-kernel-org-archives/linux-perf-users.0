Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48153C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 10:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257DF60F93
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 10:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhKLKgy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 05:36:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:48187 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232791AbhKLKgy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 05:36:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="233059007"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="233059007"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 02:34:03 -0800
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="492951812"
Received: from dehex-mobl1.ccr.corp.intel.com (HELO [10.255.31.116]) ([10.255.31.116])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 02:33:57 -0800
To:     irogers@google.com
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        daniel@iogearbox.net, jolsa@redhat.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, mark.rutland@arm.com, mingo@redhat.com,
        mpetlan@redhat.com, namhyung@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, peterz@infradead.org,
        sedat.dilek@gmail.com, philip.li@intel.com
From:   Ma Xinjian <xinjianx.ma@intel.com>
Subject: Re: [PATCH 2/2] perf clang: Fixes for more recent LLVM/clang
Message-ID: <1fcb636d-71ab-12e8-aa7f-c7ca4f89a5ed@intel.com>
Date:   Fri, 12 Nov 2021 18:24:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi

We build perf with clang also recently, but unlucky that failed with 
following errors:


```
In file included from /usr/lib/llvm-7/include/llvm/ADT/STLExtras.h:21,
                  from /usr/lib/llvm-7/include/llvm/ADT/StringRef.h:13,
                  from /usr/lib/llvm-7/include/clang/Basic/Version.h:20,
                  from test-clang.cpp:2:
/usr/lib/llvm-7/include/llvm/ADT/SmallVector.h: In instantiation of 
'void llvm::SmallVectorTemplateBase<T, true>::push_back(const T&) [with 
T = clang::driver::OffloadUnbundlingJobAction::DependentActionInfo]':
/usr/lib/llvm-7/include/clang/Driver/Action.h:579:61:   required from here
/usr/lib/llvm-7/include/llvm/ADT/SmallVector.h:313:11: error: 'void* 
memcpy(void*, const void*, size_t)' writing to an object of type 'struct 
clang::driver::OffloadUnbundlingJobAction::DependentActionInfo' with no 
trivial copy-assignment; use copy-initialization instead 
[-Werror=class-memaccess]
      memcpy(this->end(), &Elt, sizeof(T));
      ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /usr/lib/llvm-7/include/clang/Driver/Driver.h:15,
                  from test-clang.cpp:6:
/usr/lib/llvm-7/include/clang/Driver/Action.h:549:10: note: 'struct 
clang::driver::OffloadUnbundlingJobAction::DependentActionInfo' declared 
here
    struct DependentActionInfo final {
           ^~~~~~~~~~~~~~~~~~~
cc1plus: all warnings being treated as errors
```

llvm version: 7
rootfs: Debian10
kernel: v5.8 v5.11 v5.15
reproduce:
$ cd linux/tools/perf
$ make LIBCLANGLLVM=1 ARCH= EXTRA_CFLAGS='-fno-omit-frame-pointer 
-fsanitize=undefined -fsanitize=address'

Would you please kindly point out what's wrong with our steps? Or can 
you give us your command to make perf with clang?


Thanks
Ma Xinjian
