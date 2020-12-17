Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BE9C4361B
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Dec 2020 14:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339E02396D
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Dec 2020 14:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgLQO1w (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Dec 2020 09:27:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727566AbgLQO1v (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Dec 2020 09:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608215185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QIiTvA+6ricfpB9mLrgoeBz+cqPgmNJ6H5mBcGAQjlo=;
        b=Rypqh+OPbfj1ob/hq+mtfUPqBNuwDvlIhvmLFUbFf5V+Lx3n+EjVXkXxtCGZOrtrRpHuBe
        ALpKT8ZNRyeJCWe4Y5d46wBfFJmKBUf6MUvhYIQ2ODDzpufRYkbJ1uYb7vsceouZ6YJZZe
        nJBDcLhj3X34dz5WS4Wli6UiqZBMKIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-dV6OZ513MBS0YfaXu-TiOQ-1; Thu, 17 Dec 2020 09:26:23 -0500
X-MC-Unique: dV6OZ513MBS0YfaXu-TiOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C7C985C739;
        Thu, 17 Dec 2020 14:26:22 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBC0660CE0;
        Thu, 17 Dec 2020 14:26:21 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 2EDEB23E; Thu, 17 Dec 2020 11:26:19 -0300 (BRT)
Date:   Thu, 17 Dec 2020 11:26:19 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Nick Thompson <nathompson7@protonmail.com>
Cc:     "trivial@kernel.org" <trivial@kernel.org>,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH] perf config: Fix example command in manpage to conform
 to  syntax specified in the SYNOPSIS section.
Message-ID: <20201217142619.GA14524@redhat.com>
References: <4NRiGHoarpAH9Bm8v4IALfprSaF_-io8e27O4A486cEAHRfNccrU0jOWM4Bep37oMSUSNk565zwqiWac_l-nYQXfPBWgAtDjWBJVfO4SbrY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4NRiGHoarpAH9Bm8v4IALfprSaF_-io8e27O4A486cEAHRfNccrU0jOWM4Bep37oMSUSNk565zwqiWac_l-nYQXfPBWgAtDjWBJVfO4SbrY=@protonmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Dec 16, 2020 at 05:29:43PM +0000, Nick Thompson escreveu:
> Attached is a trivial fix to the syntax in the perf config man page.


Thanks, I've added this to complement the commit log message, and as
well your Signed-off-by, ok?

- Arnaldo

