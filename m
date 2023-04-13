Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A8C77B6C
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 11:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDMLBJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDMLBI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 07:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326DE44B9
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681383624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Z68wGMpS8W7hPnlbC+dU5dwHaC3Z1pkCBKswknjRVg=;
        b=Ig1qsxL1a/LdNQpdEOeMriT4lP6QOMZJn4QqoO38QsDoeIqp4Y7iQxYsXpwuxWWLNZfh9l
        UxS3x44ehti0P26HsJG5/iAhvm8vDgbHg+YTifmePZnqbilFBYPw8/HaSaNjqznZxL5QdB
        ApTPSCkWPucjKDO9WlDktQrx9O0EBK0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-6m6lwIeTM_KSjpVA9gReGg-1; Thu, 13 Apr 2023 07:00:23 -0400
X-MC-Unique: 6m6lwIeTM_KSjpVA9gReGg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso183747466b.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 04:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681383622; x=1683975622;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z68wGMpS8W7hPnlbC+dU5dwHaC3Z1pkCBKswknjRVg=;
        b=c8TacN1YO6rAfEWrmgUc03iuOd+kF4Qt15rvb+nNdO369cmVrKatTTM7nu3yJuzoeW
         0uKBe5JRhPf3rLTtGKGXHJWglh62XQTQplQGG6hWlUVOg24tOzXzAl3CcTY1C+lt/LQO
         AgDukcqsIROG4eMspdn2/AA0bTzOS5QWB5tyHHUAUCfIASJ1QFZgSEqBrzU8wph2DWte
         f90oV/IE84OIhl/mVpGmCA//BkRCdGn+aSUTddJX7jCIAmj/rXt/n/mvaq6Y62Z5EVwJ
         NLgNRl3xMkZlbpdrCbxTuJ/KBhZ9Y26rOKZlJ7O/Aa/p3PPakw8tdL4uaa7C89GUiW1p
         Tj0Q==
X-Gm-Message-State: AAQBX9eyqri3q1O+5JLnbTUgMgzHA6bf6nMkL89o6Ump+xJD4l5lOWfD
        AHjYPMvr5fZOckpgHQ/AL7AFKwXtl1NdChwHXqD02k7CCA51ErkBV9d4AjS/X0zP2M7xyWf11w9
        +TdPMbWTZ+lINT0Uyq/DUVjFEtjpQQsI65Au1GqSi
X-Received: by 2002:aa7:d8d2:0:b0:504:c269:1497 with SMTP id k18-20020aa7d8d2000000b00504c2691497mr1969054eds.27.1681383621775;
        Thu, 13 Apr 2023 04:00:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zh8AmDI+sXIcl/ZT1w52Ql3HlLlVH+9qOtObPvcWJvo12TMaYNWasAuhznl13hj0H4CxlnTg==
X-Received: by 2002:aa7:d8d2:0:b0:504:c269:1497 with SMTP id k18-20020aa7d8d2000000b00504c2691497mr1969023eds.27.1681383621306;
        Thu, 13 Apr 2023 04:00:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o6-20020a056402038600b004af720b855fsm674050edv.82.2023.04.13.04.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:00:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 30676AA7AEE; Thu, 13 Apr 2023 13:00:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
In-Reply-To: <ZDfKBPXDQxH8HeX9@syu-laptop>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 13 Apr 2023 13:00:20 +0200
Message-ID: <87leiw11yz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:

> A side note: if we want all userspace visible libbpf to have a coherent
> version, perf needs to use the shared libbpf library as well (either
> autodetected or forced with LIBBPF_DYNAMIC=1 like Fedora[4]). But having to
> backport patches to kernel source to keep up with userspace package (libbpf)
> changes could be a pain.

So basically, this here is the reason we're building libbpf from the
kernel tree for the RHEL package: If we use the github version we'd need
to juggle two different versions of libbpf, one for the in-kernel-tree
users (perf as you mention, but also the BPF selftests), and one for the
userspace packages. Also, having libbpf in the kernel tree means we can
just backport patches to it along with the BPF-related kernel patches
(we do quite extensive BPF backports for each RHEL version). Finally,
building from the kernel tree means we can use the existing
kernel-related procedures for any out of order hotfixes (since AFAIK
none of the github repositories have any concept of stable branches that
receive fixes).

YMMV of course, but figured I'd share our reasoning. To be clear,
building from the kernel tree is not without its own pain points (mostly
related to how the build scripts are structured for our kernel builds).
We've discussed moving to the github version of libbpf multiple times,
but every time we've concluded that it would be more, not less, painful
than having the kernel tree be the single source of truth.

-Toke

