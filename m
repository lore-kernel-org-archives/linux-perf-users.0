Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22DCECAAD5
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Sep 2022 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiIBPxw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Sep 2022 11:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiIBPxV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Sep 2022 11:53:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F792C675
        for <linux-perf-users@vger.kernel.org>; Fri,  2 Sep 2022 08:46:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e18so3246500edj.3
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Sep 2022 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=ajoXh4q3PNvCbvJn5Mn8VzhtUwG+56ZVXC4P9Vh7Iio=;
        b=AcFYMnesQZY/pzw/djkTkqEyJAkyM2UZNOGDWb08JKBl77YnKSn4v+kXmuSuHe0+Pv
         X1iBwDBY2EW3PRqyif6AwJL1z3GB8P+AFj0G9FZq4b3po+Rtnbk5iBTwHHPABDfP3VlJ
         KmragM/2oL1dN3/W7VPp0R1NqfwhKVt0vp1QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ajoXh4q3PNvCbvJn5Mn8VzhtUwG+56ZVXC4P9Vh7Iio=;
        b=SPmIqdDlARrWJfTYHY2CtXAMirOS/8gCWpBYTg4IkjY+8nKupO+tMCkNGL7knBrvHG
         0wOPw2vbnJ+k2PLRyrRtUg8HQY/Y4sS3iusjxRNxW2D4LqX0BJ1l7Tkjo4H7o/I8bcU/
         oT8HbpXyYs1VEu7Tw+5Gxkg0QZ7eyYZV4XuCtPDnYGDmhhvZeAeWRuPl+FN1kj50QFI/
         XAVd1fb0O3m+kvqdmg7D0rPckKNawqL7Mg8gRpAOSVwQCjFuHIP/hkd4szLuibRcLeQM
         H+mGoZHeIkHvt4xgumbGI+2C48DcFIROysBalUuR7Ql/gSLDrbueuy1MZgy7uG1UsPLS
         4Jow==
X-Gm-Message-State: ACgBeo2pHQK5GwtW4wHpz2iNHz2ZbMprp/jtBFoqQd+w0UxiTTQuXR/D
        b1rs0wZoqIBk3QWo04ipXWhjNuor8xtQ6kP5BiD0DA==
X-Google-Smtp-Source: AA6agR7MBoEsTm2riDwZzZu/buGQeydSuaVH4Rx/57NDi177e/XV2qQZIVsLMw0TLGjOe9t5LMKHgJ6gxLI9H11/qZA=
X-Received: by 2002:a05:6402:268d:b0:43d:b9d0:9efc with SMTP id
 w13-20020a056402268d00b0043db9d09efcmr34194052edd.92.1662133588729; Fri, 02
 Sep 2022 08:46:28 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Fri, 2 Sep 2022 16:46:18 +0100
Message-ID: <CA+wXwBT_fiBrFG-=C=eWGHuJ3XzxDLe-Ba4ybOvuxvu5A1+Tig@mail.gmail.com>
Subject: perf record --kcore does not work when /proc/modules changed during copy
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, jolsa@redhat.com,
        adrian.hunter@intel.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Perf tools maintainers,

`perf record --kcore` frequently did not work on a somewhat busy system.
For example:

  sudo perf record --kcore -- sleep 1
  ERROR: Failed to copy kcore

Using strace to look at the invocation, the failure looks like:

  ...
  openat(AT_FDCWD, "/proc/modules", O_RDONLY) = 56
  openat(AT_FDCWD, "perf.data/kcore_dir/modules", O_RDONLY) = 57
  read(56, "mpls_gso 16384 0 - Live 0xffffff"..., 4096) = 4070
  read(57, "mpls_gso 16384 0 - Live 0xffffff"..., 4070) = 4070
  read(56, "xt_conntrack 24576 22 - Live 0xf"..., 4096) = 3738
  read(57, "xt_conntrack 24576 22 - Live 0xf"..., 3738) = 3738
  close(57)                               = 0
  close(56)                               = 0
  close(55)                               = 0
  unlink("perf.data/kcore_dir/kcore")     = 0
  close(54)                               = 0
  unlink("perf.data/kcore_dir/modules")   = 0
  unlink("perf.data/kcore_dir/kallsyms")  = 0
  write(2, "ERROR: Failed to copy kcore\n", 28ERROR: Failed to copy kcore
  ...

We can see that the verification of proc/modules failed because /proc/modules
output changed after we copied kcore. When i looked at it, they are caused by
changes of module refcount which seems expected on busy systems, such as

  < tcp_bbr 40960 12644 - Live 0x0000000000000000
  ---
  > tcp_bbr 40960 12678 - Live 0x0000000000000000

Any suggestions on how to make this work is much appreciated.

Cheers,
Daniel.
