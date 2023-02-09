Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EB7C05027
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Feb 2023 01:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBIByB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Feb 2023 20:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBIByA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Feb 2023 20:54:00 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15224C90
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Feb 2023 17:53:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r3so771902edq.13
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Feb 2023 17:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pixielabs-ai.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rVDUeahGtHXFbsO3eNUILv0MaXuR8kUOJKL5hFdI8EU=;
        b=wk5QI3chCFMkHc5M7impa2zO/+vsJVhul3l8V1SNYmvfG9moN3cL86JqFMEyFvgjFU
         0k8NqDMKglQC4B/+p4PDXaMS1R6bnzftchsLHbJgUO//+Obz6PEjl8NSJ5zj0nEdDarC
         z1mkC/GPSDSbvzvlvZmwNITgOxKBgLt1kwNqApn3W4CVzJsro4u2bko+EkKMk5Psl0H+
         NHEKTjDax1cRKFP0TuoIsKiW9IzRhJ+ego1NPkS1chuX64sA33ormt8Lfiarp5m4GNTk
         45dHjk8Vp5FBGjRCObUAxEEq1pIOI+p2Fr5Oqh99YLzZjgBen3996RXyImAglu4H/lg4
         dseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rVDUeahGtHXFbsO3eNUILv0MaXuR8kUOJKL5hFdI8EU=;
        b=2w3sHtMRq70g4YYm4NTY71Dp+Wvcjo5FK4Va1HUF43I2EV4UodOIvMWOLRX1ZLDbUM
         VPomMaqc42ujK0WmQ2drIGwdijMvNph+Nd+YnuqQbudEEpMZDiiRed1xu9B+lIrdHAeM
         2WwuV+Nd4H59IUf8CtP7A3uc/4UFJT6JSFx8/3499LzJet5EJNDSlNJ4k/thJY+BKn+H
         lnf0WSx+I7UwH2jvMB+l4wayuALeitr0TtAfMN0SaonnYawB/0v6fZfnoB4gbsDlsux7
         ybTctzeglzEgPIK1BTmeY87EeLoRy/1cOT13H7y62rpJEbGJ6e/QzdZozZ5T3G5fMnRR
         9k6w==
X-Gm-Message-State: AO0yUKUujKkRS/fpog83HJnpDnQWgA+RzOgj7MIvLV/jcDwIrqeqSLqW
        F2EXKdTP11wsWDPKzo+s1Pm9ZGt4LFUkH2dwzLTJZ+NgZhO3PcNBGjQ=
X-Google-Smtp-Source: AK7set9YI2QnsYffWyNs8kBM/zaK4PthRHy2NlQm6jBF/cum9XbqLK7Bvr5I1EYVgbxvQcvd91Wwnkenq9ICbpaWa14=
X-Received: by 2002:a50:f613:0:b0:4ab:161b:66b3 with SMTP id
 c19-20020a50f613000000b004ab161b66b3mr645268edn.4.1675907638061; Wed, 08 Feb
 2023 17:53:58 -0800 (PST)
MIME-Version: 1.0
From:   Pete Stevenson <jstevenson@pixielabs.ai>
Date:   Wed, 8 Feb 2023 17:53:46 -0800
Message-ID: <CAK2+a3QGJ6gJEiBwH831aWUqaBUskhmbyfz43cLk2vpSX_UT6A@mail.gmail.com>
Subject: missing stack frames
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

We have crafted a program where with some definite expectations about
what stack traces we expect, but in less than 1% of the samples, we
see one stack frame missing.

Roughly speaking, we see the following:
libc -> main -> foo -> bar (99.49%) (expected)
libc -> main -> bar (0.51%) (not expected)

That is, in 0.51% +/- of the cases, the stack trace samples collected
by perf appear to indicate that "main" is directly calling "bar" which
we do not believe to be the case. We first observed this in a slightly
more complicated setup with a different profiler, but have been
chasing this down to a fairly reductive example. We ran the perf
profiler using a few different command line options (with and without
-g and --call-graph dwarf) and saw the same basic results with each
method.

Curious to know if anyone understands the underlying cause of this...
Is it something like a non-atomic sample of the stack trace, i.e. the
stack frames are being manipulated while the stack trace is being
sampled? Something else?

Thank you,
John P. (Pete) Stevenson
