Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BFFC4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 11:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F851610A0
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 11:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhFNLVD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235727AbhFNLTW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Jun 2021 07:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623669436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mW1OhhDo4BbGrvSu5PYyNkiZcO4Nso/XH9TpPHO3tX8=;
        b=RK8D9LTf5CY/pQrCwLVXpsHWsDjHYLFLdV1LSK6to1kvgIKI/4dFJcQz73PT4dJkYwZw44
        aG4rdLgo98nu11fPE4b4Gp2zHF8DyWYCdcTtOZ2usRBZ9gUfiZanY83jyFSlCZEr0qwrwY
        e9GUTAEInXHKmRmKEM+SoqDAO4+nb+c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231--pz7aevVPCi7K8NPbA2wCQ-1; Mon, 14 Jun 2021 07:17:14 -0400
X-MC-Unique: -pz7aevVPCi7K8NPbA2wCQ-1
Received: by mail-ed1-f72.google.com with SMTP id h23-20020aa7c5d70000b029038fed7b27d5so19922378eds.21
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jun 2021 04:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mW1OhhDo4BbGrvSu5PYyNkiZcO4Nso/XH9TpPHO3tX8=;
        b=rt7EbJ80nWvrfqDCDDl1GQl4YT+4tAr8fPLRxFZXUcW14GLzmHZlePUpeFnfC/W0ec
         77YiFSs1JzS8jGrL2o3h2dZJ3SzfvB4zyt0vhbgS4P0eVKwUOZmutLdssXvvE8Tyf300
         TIG5U2oYEEd+SxQDg0mR5yPZjrpW43rBjT02Fhs9u0vCYB48vyZsZijNNEM0rfD0aZVt
         3S1/SdrtqAyNjMJdMZSE9/024JPhVmDRX3SNpRqV+aR/qMwb59vHXQn7pIwOTONwB+bO
         nm8DwFsS7X29ksi13CAPfnBRbYiPKRJLZBx1PzRlbtqHKx9klVvgMQ9Yk4khYcF03z+7
         VJWw==
X-Gm-Message-State: AOAM531ZwoXKeVvNRf+IMR+5IjUoTkNkIj6nHEFa/miK2EGxlW5K5kAl
        u/XvaWQqn/snFw19nVf2LW292lUXSw9PaYXio3cqBC6ksSh4L1bK/xCpfzJipD/F0Bwdo+BDQtU
        ZFuQzywtZkDTNBrE2pRn3G32dMV09zQ==
X-Received: by 2002:a17:906:b74a:: with SMTP id fx10mr14622064ejb.248.1623669433806;
        Mon, 14 Jun 2021 04:17:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTrZC854XsPGiSNTA3MALRfR8LN8qGTzOISTOOj/IDn7AHGzR1WW2pb8jHa6tJKhC285AzvQ==
X-Received: by 2002:a17:906:b74a:: with SMTP id fx10mr14622049ejb.248.1623669433667;
        Mon, 14 Jun 2021 04:17:13 -0700 (PDT)
Received: from krava ([83.240.60.126])
        by smtp.gmail.com with ESMTPSA id y20sm3602394ejm.44.2021.06.14.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 04:17:09 -0700 (PDT)
Date:   Mon, 14 Jun 2021 13:17:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: libperf : Can not create event group
Message-ID: <YMc6tBoIQiUQkRbq@krava>
References: <OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 14, 2021 at 07:17:53AM +0000, nakamura.shun@fujitsu.com wrote:
> Hello.
> 
> perf_evsel__open cannot create an event group because it set group_fd
> to -1 when it ran perf_event_open.
> Is there any reason why group_fd is fixed at -1?

hi,
there'no leader link on this level yet (in struct evsel)
so this is not implemented at the moment

jirka

> 
> Best Regards
> Shunsuke

