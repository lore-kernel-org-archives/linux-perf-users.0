Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFFC43334
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Jun 2022 20:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiFMUoO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344231AbiFMUnG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Jun 2022 16:43:06 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DAD26AD6
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jun 2022 12:46:22 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u9so3677934oiv.12
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jun 2022 12:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=UmlHxN8lllcTEnv60MTDK5JmeyzjU4zfliHhVF3Yd0I=;
        b=BRu1yWWzSisjE+M2VfddraRk2+HUjGJw4R5VuIowvLUNAErYg6aRj3cIFKjnNT6hJI
         UbbHlklvmGvRZ1J4CvCRk4AEMNE/cI/5Rac/bvDV1JiMdzRLYlkpix4BngTBdGLzLqPV
         ywoV8GbYaddDJrZgq2Rk494w/PHQkJBm3xzlk1CS/auMeet2fAWhUvDs1MtjgtGr2i5k
         ULp1rrc1HoYrwsOWyl9RG0zHoRZew56GgdmG6pT0t6HNOztaJj/2ot7m8V4wCXRStovA
         I1FRcVvsCNNzksfB681uyVzTo7LfeI/8Un/DlhW0vC169UamzJXcHchjDIPvzFetAI5i
         0eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UmlHxN8lllcTEnv60MTDK5JmeyzjU4zfliHhVF3Yd0I=;
        b=Ti8R07OSfFDNy9SjH24sLXvdVSKxA518dV5E52mcbNysqDHu1F0Rt8iK3N0oaY5ZU/
         qp7c50QoZJkpe5XFsbQVr0RZqNg7qHlJ4O9IWs+G7/cAJKMU+HKcUsjAWXyCa8DdvKQs
         5URsnfwhK8FM5dA+fQV1KDHXgLyni6mFuWTaVKZ3WlkxzL/oNEYdVBtZ2TTnT8C1DQn/
         gbPISWSRmC0cGlVA07y1ZPj4jwT5qi0R53vU/dNDZSMOU3BzkTk19VUfe0uY4HgI2PHk
         1aB4hukd800ND4VA/j41JsIzECGPE00tCydK5IOV7GLeXSG8z6I3M6hnRf8Mhpo+T6F8
         U7jQ==
X-Gm-Message-State: AOAM530E9yP6hYLGyvk/1tiNiZ/0wvs7vlyUI3qckSkyha0kDEuOz/6M
        nTVOqj4jW40ma6ys9Sh0uN9QRM389tTbonvAX+Li2jmwxzsT/Qxg
X-Google-Smtp-Source: ABdhPJyCrYg76yuAIbzxfA8uOGfk0YYfmxpGOT09M/HPByk0WygnxA71hnBcVd2B+faBTZeeS9j0okegsRZppd2xOjg=
X-Received: by 2002:a05:6808:1526:b0:32e:f98e:d56c with SMTP id
 u38-20020a056808152600b0032ef98ed56cmr196999oiw.33.1655149581428; Mon, 13 Jun
 2022 12:46:21 -0700 (PDT)
MIME-Version: 1.0
From:   Tudor Brindus <tbrindus@gmail.com>
Date:   Mon, 13 Jun 2022 20:45:55 +0100
Message-ID: <CABPTGz8qFqV0X0Wv0Tx=EZAcMORaGFAnwU94cZCeMbdGA6s6Cw@mail.gmail.com>
Subject: Is PEBS-via-PT expected to work on Alder Lake Gracemont cores?
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi linux-perf-users,

I recently obtained an Alder Lake machine, and was hoping to try out
PEBS-via-PT on its E-cores.

The patchset[0] adding support for Alder Lake to perf suggests this should be
possible:

> - The "cpu_core" PMU supports Topdown metrics.
>   The "cpu_atom" PMU supports PEBS-via-PT.

However, I haven't been able to get it to work, despite spending the better
part of a day trying. I am on a 5.19 kernel.

$ taskset -c 15 ./demo &
$ perf record -e
'{intel_pt//,cpu_atom/name=br_misp,event=0xC5,umask=0x0,aux-output/ppp}:u'
-p $(pidof demo)
Error:
cpu_atom/br_misp/: PMU Hardware doesn't support 'aux_output' feature

dmesg reports that the cpu_atom PMU should support PEBS-via-PT:

[    0.005511] core: cpu_atom PMU driver: PEBS-via-PT
[    0.005511] ... version:                5
[    0.005511] ... bit width:              48
[    0.005511] ... generic registers:      6
[    0.005511] ... value mask:             0000ffffffffffff
[    0.005511] ... max period:             00007fffffffffff
[    0.005511] ... fixed-purpose events:   3
[    0.005511] ... event mask:             000000070000003f
[    0.060399]   #9 #10 #11 #12 #13 #14 #15

Am I doing something silly here? As far as I can tell from reading the patch,
PERF_PMU_CAP_AUX_OUTPUT is a function of intel_cap.pebs_output_pt_available,
which should be set (otherwise dmesg would not be printing the "PEBS-via-PT"
string).

Thanks,
Tudor

[0]: https://lore.kernel.org/lkml/20210310165358.GI23521@zn.tnic/T/
