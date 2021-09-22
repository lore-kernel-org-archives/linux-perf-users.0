Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F65C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 00:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5F161159
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 00:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhIVAJT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 20:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhIVAIf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 20:08:35 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4276EC0617BE
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 17:06:19 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id ay30-20020a05620a179e00b00433294fbf97so6209067qkb.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=4BBDHyzTmFJD2PGtjmXQGbVqPzRCZc8ppu5cY3KZ5Y8=;
        b=i1hLF6bC7QippVnwD+QfcurzwPql0DTYdtvpNMOXEcTNGevY7UnIQHp4F8TFxhWOcC
         y5khcTlTsxcY03DM6I7OGwJdsNRusHePnZs48VJgz9iDl9BCd/WdBAHgBd08BkVlEctl
         qgkp34acvdJvQRinIA310i906+1pI4VRGGbTHUSEWOTyISF582eEBN0uohWrXglJ4Vha
         UiRiAJR9+rHm1hSoN64l3MLHm8i51hrtd5lKdh0LN16chuzJEtOj6NO2pvuQiZZnchZT
         2+/Nzn1kX3D5dvOeb3mhXnOtnZBTLnXfaqpsFhvkCaK7qjG4cSZxh2Y/t71DvQNuI5L1
         pIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=4BBDHyzTmFJD2PGtjmXQGbVqPzRCZc8ppu5cY3KZ5Y8=;
        b=cIySxy5bVYo2Jh8gHuAkdBGz4P4a2rMmVdjuRtZ37hW+dwk0ZIwcbkXSM3qKVMfFBV
         pv21m37B4ALx3ovVdUPNTaHSL6UXMMBgd+3NN8n2bgu8o0JCvInsZyO2uYdqrVvxZvjh
         ny3u89ERJFGttjn9GXU6YX/KJbY0qe66FScnOe0wBs9980KXQE1MQ/eXX4Yx4q2OEn/U
         MSxPt3LqULoO694rsFc3NMuX96QsoL168AK3gR6HWMXrOckUQMe/J2NFkFL/1E4JafWY
         rMIHwxsp4anegCMzZLtTDWi0UMqsieRGnuwABmWvoaa19kBk7T36eX9mmpyUX6I0osa2
         jLiA==
X-Gm-Message-State: AOAM533gkTER2wLB7Cxfro7pCy+3zkBSfkLlppaHmN0geqSUNjbXCQlv
        y4Mhv05B8DrlrMYGfvltpY7ouI3oy2M=
X-Google-Smtp-Source: ABdhPJzV8/bAA+bVdBd7d54Vy+1c6C23hub/FF/gkHwdARHRitfqPelJ1Pr98qSi4K4qg/f1+Xhzcbcxu/4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:ad4:466a:: with SMTP id z10mr32596974qvv.47.1632269178759;
 Tue, 21 Sep 2021 17:06:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Sep 2021 17:05:33 -0700
In-Reply-To: <20210922000533.713300-1-seanjc@google.com>
Message-Id: <20210922000533.713300-17-seanjc@google.com>
Mime-Version: 1.0
References: <20210922000533.713300-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 16/16] perf: Drop guest callback (un)register stubs
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Drop perf's stubs for (un)registering guest callbacks now that KVM
registration of callbacks is hidden behind GUEST_PERF_EVENTS=y.  The only
other user is x86 XEN_PV, and x86 unconditionally selects PERF_EVENTS.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/perf_event.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d582dfeb4e20..20327d1046bb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1505,11 +1505,6 @@ perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
 static inline void
 perf_bp_event(struct perf_event *event, void *data)			{ }
 
-static inline void perf_register_guest_info_callbacks
-(struct perf_guest_info_callbacks *cbs)					{ }
-static inline void perf_unregister_guest_info_callbacks
-(struct perf_guest_info_callbacks *cbs)					{ }
-
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
 
 typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
-- 
2.33.0.464.g1972c5931b-goog

