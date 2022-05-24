Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B1EC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 May 2022 20:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiEXUua (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 May 2022 16:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241112AbiEXUua (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 May 2022 16:50:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1033474DFB
        for <linux-perf-users@vger.kernel.org>; Tue, 24 May 2022 13:50:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gh17so24710688ejc.6
        for <linux-perf-users@vger.kernel.org>; Tue, 24 May 2022 13:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZHx5jP46nGBy2QPGgaXoFuUqRFY617ewwusEnxqU5Z8=;
        b=EsE44805pqhkXf6XcxGgQoZoRHuw3jpuDr9Oj9tDp0XY0Bxk0Q6BakmfroYSQqlEXi
         xzWWMK8RVaautaQ3wB/9+cekTZesVKC+fsIQP20EIpgsEUt/L176QgVQGCC7xiLhcb60
         dH6KynPvxxN4xe6/+fSljQsRj/fpBtw5PJZGMwbvw6w0FxIR4bGgS1kWlmgWARqA6XN6
         A0EQsFIhNyHGnfVkfsv2nLQ4qlOxmy4LrtHXWWrFVdU8xSPtiXj/OODsrTyWCixRuieU
         aYQHT00AzzaJlKhQtzzLpwky53o06wm4SdLPoChdy4eoAcE2OBfhGqqqEnBOHbMgD7e7
         eRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZHx5jP46nGBy2QPGgaXoFuUqRFY617ewwusEnxqU5Z8=;
        b=x+rJkqOeFTu5Ye2+XjyaUm3nQFEmH1iuJZC7ogartnrGeRsbxsfNt18/33sPLr5J9z
         s25j1vnHdScPG8GB+lYDj043SYjGpPFjpqn4brM3ctYxdCYqfjEKDxwer9ZtPP3Y52jF
         I2Bt+qD1K47M//JKnliD/RHdOVrDz9GyILaIevDXEzO0QTfEMNlQ4+OShCk97tiV2Cn3
         fC9KbLUujbnsqTSlytdJCiAG9hypUczYO4+m0idIUWQDV2ZhADOjuSqPNZGqTv/zqbT6
         ObtIahm+y0SDO/L7TI3O6ywHDwdjFmZOvNDKoh/dKc2vHv/1DbTneBz3T7fj1LwOiVSo
         hXew==
X-Gm-Message-State: AOAM530AiXbSWwHWCWIYpCraIVbbDwcQszMYb2mr1IrFMvvche5bvx50
        6D2qkb9B7tifJxFAOeQ0XRhjwxqKP4ABMg8DpYloURnZ+GGVFQ==
X-Google-Smtp-Source: ABdhPJzJbhZydBgBwQMSTUiGxi7dyE1k19nsnCW7il5/p62R9m0hGVE5KpT5h1iarQikhHQjn5rL/shJQ6YwInhnuTo=
X-Received: by 2002:a17:907:6d81:b0:6fe:b89d:80ba with SMTP id
 sb1-20020a1709076d8100b006feb89d80bamr17268109ejc.699.1653425427228; Tue, 24
 May 2022 13:50:27 -0700 (PDT)
MIME-Version: 1.0
From:   Travis Downs <travis.downs@gmail.com>
Date:   Tue, 24 May 2022 13:49:51 -0700
Message-ID: <CAOBGo4zjkcX=ZQm1uYRDe9EjYqsTCyZY-Gf1C4XqMNYGFCcF+Q@mail.gmail.com>
Subject: Call graph dwarf unwinding fails with lld
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I have been tracking down an issue locally where `perf record
--call-graph=dwarf` stopped working in the sense that unwinding always
failed.

Turns out it was related to `lld` - binaries linked with `lld` don't
seem to unwind correctly with `--call-graph=dwarf`. I've confirmed
that the `.eh_frame` sections are there, but I guess they are
different after using this linker.

Has anyone run into this?

There's an open LLVM issue at https://github.com/llvm/llvm-project/issues/53156

... but no activity since it was filed, though it is not clear if the
problem is really with lld or the unwinders.

In a related question: perf supports more than one DWARF unwinding
implementation, depending on what libraries are available at build
time, right? Is there a way to select which unwinder is used at
runtime?
