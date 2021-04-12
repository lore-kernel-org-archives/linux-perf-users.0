Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046D4C433B4
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Apr 2021 14:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2FB61353
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Apr 2021 14:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbhDLO3f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Apr 2021 10:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbhDLO3f (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Apr 2021 10:29:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8B0C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Apr 2021 07:29:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h10so15307111edt.13
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Apr 2021 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=0P5czINXRSmWUgVMy5hfECS3abHGtTdsAjIIm1UbVF8=;
        b=tihgRsGp00+tTlKCLZNB4FmVBtZapHn8VBUlJNQ/Y4kP+9kTsqYE+J4oi4r7KyKqSF
         Q0Iy67q2fgFBxDdsX60zuHJukxfGR15tyBPeSGJVU+qNMVFs2S2iUSWbDhD5+kUjyRyg
         OeREK4f5TsWexOQnMGL/Dqbynr2ebhJ1wpbKoqvcCZ/extNjuFjXlPPNEwH00SDBn1VB
         3unVnZCRKSLi59oKTvG5F8eCNlAhHlTFH2I78ygaV7HyixIff9ANSgfbp+ES0YGFY4o7
         MEnLeQFphAwvJNGD6q1AoM4xfOQHFaORbL2i9qP0qJGaVVaz6Pb3PT3778gxdzVUpc+U
         Ms7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=0P5czINXRSmWUgVMy5hfECS3abHGtTdsAjIIm1UbVF8=;
        b=Hi6zfp/qdElgdCJybZijCJjR8as7lHQUyVT8lfqg+JUj0MXzNJD/GGU0rgEMW7ylMm
         S7zhmcxvchJDJ2tfIo6Mszp+yc3OfajxWLPj4eDYwpkiCQsskisOWJg62Nzj8HHqA5Qo
         z+1DB+xooaw/pxARwkwd1J4oT/KuNIDAD9zvtqzZfGIbEMbdobhhJNQPDK6EH7ogirvx
         /pP/5RkxqWofOf3EDvWntvSzUBYSSFvnQG5VceQ+7aJWTGPkw3G5FxZdnRUm5QHZamrU
         EIyU74rCQCcVHJ+00nLqM+bmSfwY7zZQGTPCdULp2g4ixcXjwR52YkooJk9dFkJ7nlnT
         fg7g==
X-Gm-Message-State: AOAM532VvCwwjTr3nHDDu0lkn9nlatLnVwZwKxj681AXmWc5NQQE9e2q
        32F4yeyW7Wq5Sn1r/uBNlcGLSkvJqw==
X-Google-Smtp-Source: ABdhPJxzCcgjO5CfgUf6Kn2nUDiipBu0UW5V2mXJ2D1yqMzIGyIFv/hkJ2ADGTVP71iFO4DZK0dBNA==
X-Received: by 2002:a05:6402:1d3a:: with SMTP id dh26mr21669957edb.359.1618237756056;
        Mon, 12 Apr 2021 07:29:16 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.61])
        by smtp.gmail.com with ESMTPSA id bu26sm1919636ejb.30.2021.04.12.07.29.15
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 07:29:15 -0700 (PDT)
Date:   Mon, 12 Apr 2021 17:29:13 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-perf-users@vger.kernel.org
Subject: Double sys_exit_pread64 tracepoint event
Message-ID: <YHRZOQbTNm75Ojm1@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I was tracing trivial fio workload which does pread in 4 threads
on 4 different CPUs and got double exit event:

fio  7371 [000]  5670.259136: syscalls:sys_enter_pread64: fd: 0x00000007, buf: 0x7f2c4c001000, count: 0x00001000, pos: 0x075c1000
fio  7371 [000]  5670.259167:  syscalls:sys_exit_pread64: 0x1000
fio  7371 [000]  5670.259167:  syscalls:sys_exit_pread64: 0x1000   *****

fio  7371 [000]  5670.259169: syscalls:sys_enter_pread64: fd: 0x00000007, buf: 0x7f2c4c001000, count: 0x00001000, pos: 0x075c2000
fio  7371 [000]  5670.259199:  syscalls:sys_exit_pread64: 0x1000


Is this supposed to happen every once in a while?
