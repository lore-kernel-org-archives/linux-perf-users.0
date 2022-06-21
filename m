Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3D3C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Jun 2022 01:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiFUBgV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Jun 2022 21:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244590AbiFUBgU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Jun 2022 21:36:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FCF1CB12
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jun 2022 18:36:19 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r66so5774727pgr.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jun 2022 18:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waymo.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vZ6F4wvpDGbWdv9LDQ/ImSRBscJ3ks5pTk2NeSqUUQw=;
        b=tJG880RA9r3Y4xwm+Il6qBFQ5sGJONzFwHJOvHSjt9EUe58fjyRvokq+3360x4fLNF
         VPWqi1ZwtRu3zjadlMB+qE7QoXLwbnroS7HqeI1bL5TUWPgZ1PEaMOlifwrDD+HfTplE
         S6b4Qiur8J8lGfSm6i0KqW2kfeX4n8t9Iy7PYnO6NEoEeg8eG5G0nXxg8SOSRrfU5wPX
         YaVf1xILZUfWPmsBWrIrmqOTnscBpOndXjZHLbNuyjtNBOa6dIP357EdGwVOQ1Y9TPRC
         PURHCWcOumCZVvhlmU8j9fKwAQsr4CUxcJGfg7YKAZdEzOOXOKF6pUeYjNtqc+RkB7xI
         Xlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vZ6F4wvpDGbWdv9LDQ/ImSRBscJ3ks5pTk2NeSqUUQw=;
        b=LzbX+GgfnxDNVZD6V3st6PkGddVXKT9MY+sS862b5fwMuupPA/KcDT2qSx1TQN7pCk
         kQtEYpR72/dTODmHDjAgf4xHlL5QxbD28lbVvHQFDRLAE0ZZqrH9hug1J+K3Dui3Dh06
         7jT2grBvfqB+EYUjCuIBaZlvnhjOm+LhsL6TQOk+6v46ylHEC8o/VFDGBWQduhDik9wT
         nn58I/yGLdJHF10gxB76ep2saiAvcw6kRyCtfDIdpl5RR0tLmbENXRbUCrJBbXhfjVim
         r2n4sL6ADo7uP7ITo768T0jRWIRP5ysys+xxE7bpx2YyARbLCuwAjKpWxBxLSJ4zQ2iM
         wvkw==
X-Gm-Message-State: AJIora95c7STRWfBWs+TDFz1TiHX1FIxFBwiUpDvQ5Vi6VBLDKIqyPic
        CxOs8dGS3KcHQT5r7s0UsDHAdC61eYFG6T+4hTrtaA==
X-Google-Smtp-Source: AGRyM1vo2+viWwqM95mm8E1n776io1sCuKmRDR4PjLs+kEY83xdRYdxsBIAlI4Xv7MYzTijsJFKJrRInYFfmwYhtOUY=
X-Received: by 2002:a63:a841:0:b0:40c:b1f6:a876 with SMTP id
 i1-20020a63a841000000b0040cb1f6a876mr7774889pgp.578.1655775378560; Mon, 20
 Jun 2022 18:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220620164953.1503934-1-rsilvera@google.com> <a651ca26-6aae-fe7f-66b1-18fdbad40f41@intel.com>
In-Reply-To: <a651ca26-6aae-fe7f-66b1-18fdbad40f41@intel.com>
Reply-To: rsilvera@waymo.com
From:   Raul Silvera <rsilvera@waymo.com>
Date:   Mon, 20 Jun 2022 18:35:52 -0700
Message-ID: <CA+PGoB_H2iKwvTA1xEGmyqccefipdrnS_GxZBixZTAe2bvkDrg@mail.gmail.com>
Subject: Re: [PATCH] perf: Adjust perf-inject output data offset for backward compatibility
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Colin Ian King <colin.king@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 20, 2022 at 11:54 AM Adrian Hunter <adrian.hunter@intel.com> wr=
ote:
>
> This looks too late since, although the header comes before the data,
> it also gets written afterwards (at_exit =3D=3D true).  It would be
> better if we could rely on header->data_offset at this point.
>

Thank you. You're right. We can rely on header->data_offset at this
point as it is
adjusted upfront in __cmd_inject. Will send an updated patch.

Ra=C3=BAl E. Silvera
Software Engineer
waymo.com
