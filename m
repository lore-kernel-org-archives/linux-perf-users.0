Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98359EB64D9
	for <linux-perf-users@archiver.kernel.org>; Sat,  8 Jul 2023 00:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGHAPM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 Jul 2023 20:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGHAPL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Jul 2023 20:15:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC8919B7
        for <linux-perf-users@vger.kernel.org>; Fri,  7 Jul 2023 17:15:11 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6686a103a8cso4001135b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Jul 2023 17:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688775310; x=1691367310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nETmYJjgT8aoTFOsp8DLKXk+glLs0WNsSqhpsY5wWJg=;
        b=MHyqpcROOsORiRuiig5QS97hOe5HhZFl3Tt54WjbYvip6fb6JMsMsqcFJ6sK75U84M
         htn1+uBCqrpZ2M+dPnHVW59TTkffvZCiRUxEdwYUAQhdV3Y2jXC2VaOaCXSec058PZ97
         eTOGRz3UCPBv0AuVNX/5lWj0tpObuomQVAcAjDsFTxGI4KfZYqUsyrEm7Kx2+0UzcCyS
         JfsWBIogpPx6vOOWLwRjxmVU4Ah8yGzWO8INL9k/6F/8y5nZy91aJ7NoEs+XmKd9/yZS
         Dcq2X4C1lHNmwbLPnX0DfoflDqgcU6CbNfA2Q7CtWvi57vgx/bnjvyK8mH9I6ApU/jQB
         Vw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688775310; x=1691367310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nETmYJjgT8aoTFOsp8DLKXk+glLs0WNsSqhpsY5wWJg=;
        b=Y31ZjQt3aNDkIz4Uv4pzfLeEd4Qd/eONvPglKaaA98CyT775ZUgIKH6kPagDp/pnDP
         unKbGa9mJjTTaA6qBDsYcznZmGNJ2ougnAsmHWCo2dZ2ng4y9mmJAdXGtzuJP38weUCd
         wNKoNgqxSVaNJygF1RQKBNjxX++bBBEyE1pwJWNKY36jnHdjrb+awgz3iHX+MX5DI8EN
         L5pPZjs2ra9ARaoCWGdeXzQaAzWqwDaog+ay46Ab+1Y32WI0QumQEtemWT4gSuTEnKwx
         BRIrGR2dMRI+8fHM0CFiuJPLQonfRbch287MfAn2m1H7ZQ/YLqqK/U7Grm9+tdRTJzI+
         0uEQ==
X-Gm-Message-State: ABy/qLaukW1iy4O6JpGC4otAxdAQfOZyEp7Ah1VglI4K4wKhT+pHtmsK
        2kFkOjYm8loandSz239xQzFW2Q4=
X-Google-Smtp-Source: APBJJlFEc+cYhmAlo3tI45jURaJmwcNhv5hLHkov61yQJgZ28+zNvXA2cNzpYGCwt2UsNlO7OuFpOvo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8890:0:b0:668:7512:7c49 with SMTP id
 z16-20020aa78890000000b0066875127c49mr9252588pfe.5.1688775310535; Fri, 07 Jul
 2023 17:15:10 -0700 (PDT)
Date:   Fri, 7 Jul 2023 17:15:09 -0700
In-Reply-To: <20230707231156.1711948-1-andrii@kernel.org>
Mime-Version: 1.0
References: <20230707231156.1711948-1-andrii@kernel.org>
Message-ID: <ZKiqjS03rRlALV7z@google.com>
Subject: Re: [PATCH bpf-next] libbpf: only reset sec_def handler when necessary
From:   Stanislav Fomichev <sdf@google.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, ravi.bangoria@amd.com,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 07/07, Andrii Nakryiko wrote:
> Don't reset recorded sec_def handler unconditionally on
> bpf_program__set_type(). There are two situations where this is wrong.
> 
> First, if the program type didn't actually change. In that case original
> SEC handler should work just fine.
> 
> Second, catch-all custom SEC handler is supposed to work with any BPF
> program type and SEC() annotation, so it also doesn't make sense to
> reset that.
> 
> This patch fixes both issues. This was reported recently in the context
> of breaking perf tool, which uses custom catch-all handler for fancy BPF
> prologue generation logic. This patch should fix the issue.
> 
>   [0] https://lore.kernel.org/linux-perf-users/ab865e6d-06c5-078e-e404-7f90686db50d@amd.com/
> 
> Fixes: d6e6286a12e7 ("libbpf: disassociate section handler on explicit bpf_program__set_type() call")
> Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>
