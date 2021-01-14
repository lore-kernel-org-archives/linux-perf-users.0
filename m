Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC12C4332D
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Jan 2021 18:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C0723B75
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Jan 2021 18:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbhANSiq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:38:46 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41992 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbhANSiq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Jan 2021 13:38:46 -0500
Received: by mail-wr1-f51.google.com with SMTP id m4so6825520wrx.9;
        Thu, 14 Jan 2021 10:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=ZbAc4L4hN/uwYWU3tebheSSlSH1cruwhIR4SfDahNBE=;
        b=nlM4rCAsxF66U/jDIr0FhFXfeJ2Th4GbY8Nx/koPkP0GbRBEkdOB8P+bY1PL5fpV8j
         UWv178dMCu3zledEii0M/mwoQR8g8JrCHGLvNOKVmjSWtey2wp8iuTnBSDfRR5AsLCGC
         e4NFX65oskHsIQwNGmz1MCzfApbi6ngmIHLVrfDBvJtUm/sawMhD4FCV1ife2Cr9PdWf
         tGw9ADG1R3g05yjWvgIv2VB8yJ8CWegrWVj03q0TS1dHY6vQ8/EXu77hjswOlFu9I67S
         Hn6EyuAiIzmRzNqS5bhMk+Owc5brzvFYGMwyO2rwd6gtXcxMEabw/wMVONwYLwt7YB+i
         Y6XA==
X-Gm-Message-State: AOAM533x4r6+wpCCvU71FbOTh+wDszAA+/k/LmOva/uyTJVQRs198m0b
        RXagWx1Kk8TxQf3E1ncFsmjWmrqh/lp/sA==
X-Google-Smtp-Source: ABdhPJzn0eWyXlmOYTCYMEv8xYXrBV9LxKZ8O0Ms99GuUCyNr0kZEpDBQSrMClWhILq8Ne8/+uDY5A==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr3435614wrq.136.1610649483943;
        Thu, 14 Jan 2021 10:38:03 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id z184sm4633409wmg.7.2021.01.14.10.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 10:38:03 -0800 (PST)
Date:   Thu, 14 Jan 2021 19:38:01 +0100
From:   Emiliano Ingrassia <ingrassia@epigenesys.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: perf tools build broken for RISCV 32 bit
Message-ID: <YACPie55ArIHu3mI@ingrassia.epigenesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

When building perf for RISCV 32 bit (v5.10.7) I got the following

| In file included from bench/futex-hash.c:29:
| bench/futex.h: In function ‘futex_wait’:
| bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?

This issue is similar to the one reported in https://lkml.org/lkml/2019/4/19/631

I found that patching tools/arch/riscv/include/uapi/asm/unistd.h as following:

 #ifdef __LP64__
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
+#else
+#define __ARCH_WANT_TIME32_SYSCALLS
 #endif /* __LP64__ */

solved the problem.

I also found that a similar patch for arch/riscv/include/uapi/asm/unistd.h
was removed in commit d4c08b9776b3, so probably this is not the right way(?).

Thank you, best regards.
