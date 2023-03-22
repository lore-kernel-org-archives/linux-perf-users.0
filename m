Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4696CC6FD1C
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Mar 2023 19:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCVT5n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Mar 2023 15:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjCVT5S (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2023 15:57:18 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC66782B
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 12:56:54 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id f23so8009563vsv.13
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679515014;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z9APGl56Q1bnnaCXzrv2RdFT8dkqBopRXMfIiml7MUk=;
        b=Gap7ivbdQPSrpg27Ty27d3XYLjybzIeab8YD6XryD+YlrZrcc9x1bDepPF67/YMJ1s
         uNw/PxdHmCY65529iR9wLUtM0lHPnsivEetdCBTXIu9DKoaewAn9JkkWolu9VPNg/K5p
         XawgL94LjYHiJOjkKv/QpzSXCus93Calh3gSwl7sjh1Q2IqNDY/Dh0GcWy8XfMWKawgo
         saNf1O2rBtp+gnVU4TF9gtiBXQatAIuqlFT3JTky4jXhAv0+c2ZKxban+Nt0iKVuLz0O
         saf99Abba9kbReI6dNJR3CxRXFyK1oR0xdrpjZ7Iy3SuBkKkdgjvHFL6pFeQSyo4i2q+
         ZMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515014;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9APGl56Q1bnnaCXzrv2RdFT8dkqBopRXMfIiml7MUk=;
        b=qkboXpHzeW/MhysfvrX7BAMDLkyRYvMK+5LtYvzlVibZAp0+/l2y8llhEWAQKs6raU
         a8CesyeeCl49T14s+GKJkddU7Vk+MOjYTw5Wn69rDqG+ChPiHW9c3WRTqpdnMMlLjOkf
         vbrCZylwsmRtZHtgVsI+uaUfJMEd6govsb3mQV6ZpyU/W9rdu9RAVbSmShWDZP5lHSsv
         oQgk2nXwICz/fzxg9UGggcVLisqcrQO8kHBvGY3FGoSv3jHMzWj4nhk1dVUPL/8EqXC/
         eLGbS5DHxTxDaVeJiVsje8Itb7QZyKz809WsULtow7I3dDIcb+vZS2QAMPuq6IGiCXMx
         Mwag==
X-Gm-Message-State: AO0yUKUaEqE2oPDeycprLBc37IFfZ0o6H5pXhq9cg4g9/j6Hi7fn2hqz
        Nw0C8155gKaPqgrmjj+d4NT7LfelGPcHbWjxN6ceI05PuQw=
X-Google-Smtp-Source: AK7set8aQLRorDt2C2L8+WSV+8SRkdWRSi+7RXjm9pLQmPTB3KucRFQf9B0LQbMfOMPcsUBV5CJ7MI155FVUe+KNPv4=
X-Received: by 2002:a67:d293:0:b0:425:cf00:e332 with SMTP id
 z19-20020a67d293000000b00425cf00e332mr364146vsi.7.1679515013816; Wed, 22 Mar
 2023 12:56:53 -0700 (PDT)
MIME-Version: 1.0
From:   Travis Downs <travis.downs@gmail.com>
Date:   Wed, 22 Mar 2023 16:56:17 -0300
Message-ID: <CAOBGo4y0eMDDWDr2qzYDU-Ab-J1XFP9pcTvxmV6jo2+toqmtfQ@mail.gmail.com>
Subject: Perf report wrong decoding of symbol addresses
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I have a project where `perf report` decodes the address -> symbols
incorrectly in the presence
of debug info. That is, if the debug info is not present, it does OK
(but evidently a lot of information
is missing, e.g. about inlined functions) but if debug info is present
it just shows the wrong symbols
for each sample.

However, if annotate the symbol, the source/assembly listing is
correct. So objdump is able to decode
the addresses correctly. Similarly if I use addr2line by hand (both
tools are from binutils 2.32) it gets it
right.

So my questions:

1) What library/external tool is perf using to display the report?

2) Is there only one option, or can I recompile in some way to try a
different one (e.g., IIRC some
functionality in perf can use addr2line or an in-process alternative)?

FWIW, it's not weird to have struggles with decoding addresses for
this particular project, it uses
fairly new DWARF version and in the past also binutils (objdump,
addr2line) would fail to decode
it properly, though they've largely been fixed.

Travis
