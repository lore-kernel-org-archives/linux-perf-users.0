Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A701AC433E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6073564EB7
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhBRTAy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233500AbhBRRYm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Feb 2021 12:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613668984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5hWZuWqbp3ABgylifjpHTTzNZwup3i6sWRHglgVFgwU=;
        b=S7SqH1xDCTt61eLBG8aA0AIyP9orq+4PJDQzXkK8hcsBwDvTddQoudJfOGzYHjvU42FpsB
        J7VovcS1stTMPvQjom+diHVjs5t75Q5z6kDBvjN28jkxkkj42bpZa7jGZOTgYAMCNHhZTZ
        8j06LmS1faJh+bFGB8cuU08Of5yRCT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-WZBeNddCMYSpCdYX6AuqYQ-1; Thu, 18 Feb 2021 12:23:02 -0500
X-MC-Unique: WZBeNddCMYSpCdYX6AuqYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30878107ACE3;
        Thu, 18 Feb 2021 17:23:01 +0000 (UTC)
Received: from host1.jankratochvil.net (ovpn-112-176.ams2.redhat.com [10.36.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0766760BD8;
        Thu, 18 Feb 2021 17:22:59 +0000 (UTC)
Date:   Thu, 18 Feb 2021 18:22:57 +0100
From:   Jan Kratochvil <jan.kratochvil@redhat.com>
To:     d.rigby@me.com
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf unwind: Set userdata for all __report_module paths
Message-ID: <YC6icUkaQ1efK3+n@host1.jankratochvil.net>
References: <20210218165654.36604-1-d.rigby@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218165654.36604-1-d.rigby@me.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 18 Feb 2021 17:56:54 +0100, d.rigby@me.com wrote:
> From: Dave Rigby <d.rigby@me.com>
> 
> When locating the dwarf module for a given address, __find_debuginfo()
> requires a 'struct dso' passed via the userdata argument.
> 
> However, this field is only set in __report_module() if the module is
> found in via dwfl_addrmodule(), not if it is found later via dwfl_report_elf().
> 
> Set userdata irrespective of how the dwarf module was found, as long
> as we found a module.
> 
> Fixes: bf53fc6b5f41 ("perf unwind: Fix separate debug info files when using elfutils' libdw's unwinder")
> Cc: linux-perf-users@vger.kernel.org
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Jan Kratochvil <jan.kratochvil@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>

Acked-by: Jan Kratochvil <jan.kratochvil@redhat.com>


Sorry for the regression,
Jan

