Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AA8EB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 17:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFURWQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjFURWO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 13:22:14 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFEE19AE;
        Wed, 21 Jun 2023 10:22:10 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so6101620276.2;
        Wed, 21 Jun 2023 10:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687368129; x=1689960129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZpPnQxJ9uihBCuzwCODut6HmIpI48UyBATMRmnphzI=;
        b=gsn5h2u1Z5oX2oDgk5S7ksOiAb01y0JtCU419fLqH8GhnhWm8thihGyXJks3CFuz8a
         f8bksGHTzy1ZkY0c9xzJPRphLINBOe+vgTNn6cDVIunUADbOvv0Sv6C63lkZqfECkRDi
         zFL2LsXYtOal7qip1Dfeqx92fM5k/XKpb2Y9qw6rK0LMWIZ0E02U5Wub36QZNybiHC3c
         i+o2dL2GfkYr7AQMKXBnIQTzVUNM4hhd3p04aEpuOiFVGJuY80uJc2WQOzLAmMIv4t8p
         VPvxCFmN2cb8JcMa3dA1pg1iD/3ptRgs0uA701Qr0GAOxpkYYceK1bz8Mtux2Nqvjn1b
         LnQg==
X-Gm-Message-State: AC+VfDwLV3JLVqszk8KPRb2B5wqnphFHK/X72hHk195n+8O6xpLjIDQl
        FFE3YUclRUoUDiYhlYGON3CaGs4YdokBcnmNjxqK2KK1
X-Google-Smtp-Source: ACHHUZ7CJ2u7aMcLckaeVS3ODaAkKDLiHQR5jej+/fEA6TF067omqvduMrMFOAbZh6j1DBo43iJ6orX74ExUqsejA6k=
X-Received: by 2002:a25:5f4d:0:b0:bcb:caf8:7aae with SMTP id
 h13-20020a255f4d000000b00bcbcaf87aaemr12274666ybm.44.1687368129592; Wed, 21
 Jun 2023 10:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230602123815.255001-1-paniii94@gmail.com>
In-Reply-To: <20230602123815.255001-1-paniii94@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 10:21:58 -0700
Message-ID: <CAM9d7ciXeG=9qhZ-5qs=ZR=iEmYD64OVjhd+z+wh_TPjsWaaEA@mail.gmail.com>
Subject: Re: [PATCH v2] Subject: perf jit: Fix incorrect file name in DWARF
 line table
To:     Elisabeth <paniii94@gmail.com>
Cc:     Elisabeth Panholzer <elisabeth@leaningtech.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 2, 2023 at 5:38 AM Elisabeth <paniii94@gmail.com> wrote:
>
> From: elisabeth <paniii94@gmail.com>
>
> Fixes an issue where an incorrect filename was added in the DWARF line table of
> an ELF object file when calling 'perf inject --jit' due to not checking the
> filename of a debug entry against the repeated name marker (/xff/0).
> The marker is mentioned in the tools/perf/util/jitdump.h header, which describes
> the jitdump binary format, and indicitates that the filename in a debug entry
> is the same as the previous enrty.
> In the function emit_lineno_info(), in the file tools/perf/util/genelf-debug.c,
> the debug entry filename gets compared to the previous entry filename. If they
> are not the same, a new filename is added to the DWARF line table. However,
> since there is no check against '\xff\0', in some cases '\xff\0' is inserted
> as the filename into the DWARF line table.
> This can be seen with `objdump --dwarf=line` on the ELF file after `perf inject --jit`.
> It also makes no source code information show up in 'perf annotate'.
>
> Signed-off-by: Elisabeth Panholzer <elisabeth@leaningtech.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org

Applied to perf-tools-next, thanks!
