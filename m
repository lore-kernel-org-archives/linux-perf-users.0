Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA96FC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Dec 2021 18:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhLJSvK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Dec 2021 13:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbhLJSvJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Dec 2021 13:51:09 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BEFC061746
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Dec 2021 10:47:34 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id w1so9248421ilh.9
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Dec 2021 10:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zuCrwPOkOfVjYV6AjR9BGPpNZxqCwWYbIUEHpGhW2vM=;
        b=eyYDIgDf8kYwpNtdZtPdqhewKyB1bQNHPv1c/v90K4AG6uzwCeUq1FfbQLpSN2nLR+
         TGop8rABA7d6T1t+HYP03GPcGuD8DYQjPNi9wRPfL/b5rPqEVqlE6GP/tqYTmxpfVkq8
         IbUYWjt9yLF7BwcItXUmEdvf7Wu7gorh/dfzTZopO9TY7jC2QxDrIEOANXyJYlcvxUgw
         QTZuxJTtGarV3YBLsO5F86rXfz8N8zbJd9qz1jTbERG1FWDXErgbNsMJPgh5d56Le02r
         /zch63bpFRF7UNrmYv9Cv1ykGSir6u9wEuWxWsdvm5FrZpYEhg3UNpHfqZz03c35iWbp
         WiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zuCrwPOkOfVjYV6AjR9BGPpNZxqCwWYbIUEHpGhW2vM=;
        b=wG0fYsO18g4jY5TOWif54weDAwyOuxxAY6Wn5sWoRMGKxRU2WYIlcRWx1suiU+/WMf
         AQE1Cc3OYpkyL1l32VV3y1/4/WKwfvl6pyXAv9SLf6wawsKeI3DZlYbyeX9jQDpa41UD
         iPfalP1qRdr3A6Fd0PecQf6PZbV4yojo7A5phoV/u2qX6aK8G2U8EkCblcUK3p3tu78y
         rno6NCcZeRG9Vlmr6ozD/JTCbpusaPsxQ98gyTIWvSLuVQdoU9o9mkSmVXEg6UOs+vuU
         9hnyVYrtVbtqNe7IWtGoCDnLfDe1h36OIyqoXnbQnNLu3ytAbw9MKHR5Mk1zSKbTZl0W
         RlDQ==
X-Gm-Message-State: AOAM5332YOHNGcfOI4r+AImDrEC3Zf/cfMfvuFc/XSAXgKuati7fqcf6
        HGQIVfvMv5g40R+FhpoBNVoVi1qbX2t9Ww7Zo1MnU4ksVew=
X-Google-Smtp-Source: ABdhPJwqjoADZoSG0w9QyJeb6IPGWJZM6/RQ4dsseEgwROh3f/ctU4i2rb/PosjA2/zhYWYVNAW2xNW+KCeDiXaL9A8=
X-Received: by 2002:a05:6e02:f51:: with SMTP id y17mr20199090ilj.2.1639162053869;
 Fri, 10 Dec 2021 10:47:33 -0800 (PST)
MIME-Version: 1.0
References: <486e7e8d-de21-5e26-3792-db2fd6991602@foss.arm.com>
In-Reply-To: <486e7e8d-de21-5e26-3792-db2fd6991602@foss.arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 10 Dec 2021 10:47:22 -0800
Message-ID: <CAP-5=fUtkCzgsGS6LkCVTuyPmw981Dd-EavtU6uv3o7OB7CnDA@mail.gmail.com>
Subject: Re: PMU event repository for Arm
To:     Al Grant <al.grant@foss.arm.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is very helpful! It is a bit strange seeing the event codes not
as hex. Do you have any plans around metrics? What is the flow from
this json to the linux/tools/perf json?

Thanks,
Ian

On Fri, Dec 10, 2021 at 7:53 AM Al Grant <al.grant@foss.arm.com> wrote:
>
> Hi, other vendors have shown the value of having a machine-readable
> collection of PMU events, and we now have this for Arm:
>
>    https://github.com/ARM-software/data
>
> This is equivalent to the tables in about 40 of Arm's public CPU
> reference manuals. It includes some details that aren't needed in
> tools/perf/pmu-events, but one could be generated from the other.
>
> There's also a map of CPU ids (MIDR) to CPU names, and an example
> script to scan /proc/cpuinfo and retrieve the correct JSON file(s).
>
> I won't spam linux-perf-users every time we add something, but we
> haven't publicized this before, so here it is. Feedback is welcome.
>
> Al
