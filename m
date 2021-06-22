Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEF4C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 21:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2AA601FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 21:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFVVJJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 17:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhFVVJI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 17:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624396012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iwNIivw7ND0ogSAYON5f+dYUQ2aKcYsMFanvNB5fm5o=;
        b=EXodn/p+PjDjStl3orbkRnsZeDaD+HwbIFRBdz0fcScYpR55o05T9owsYu+P4CyaLq9ILh
        ndovWOdOqfq2NUeI5F+THjq2EjEhOhjMEhdLxvkBVgRrXwyGkWtfZD92yy3Su+iMMXaDBl
        H8bA407imdJV5L1nY+nOxf5rxuWXBmk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-RbiAQC_YNqGn7I4Le11f2g-1; Tue, 22 Jun 2021 17:06:50 -0400
X-MC-Unique: RbiAQC_YNqGn7I4Le11f2g-1
Received: by mail-wr1-f70.google.com with SMTP id i70-20020adf90cc0000b029011a8a299a4dso53279wri.17
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jun 2021 14:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iwNIivw7ND0ogSAYON5f+dYUQ2aKcYsMFanvNB5fm5o=;
        b=Jf3r37mMOtCuA/DWj4ezJgGHtC46S/0/3GTXDzl6j7COwQveRWH13DOH7gAChsW/0H
         VBBhdTwpkFHtOx0CPpHAuBa4clLPrQPcojAPXqir/hxtpf0GfnRPRHv/kNKY28alahHG
         Cc5dsrYDUyjIHCfobxEDcNQI8wYmdQ63qu881UgK4+7DPH3dsp713bV5686J7/duyn0s
         bci2EUNq33jm6kCWDYK7Ll9HKx2oVBBb+6Re/B04Azzt4Eax3vP/6rGRC6e09dLryALb
         15vLWPbxrfRhgFKfKCVbroGLG/khdIZ76rFcqWn5JUStA6EEcqTNW7NuepeK8n97ws1Z
         j8cA==
X-Gm-Message-State: AOAM533LEfyM1hGeMqgFiKsZyE3vYG1SHlB2Pxf9xrJdcZVVTeB09LlR
        hWn9cnNEN/CGK9N0M5ZmvQ3kFNVDcpYBeERDlCd+pAvn8fVonC+tH1Wz+/XlbO0mXuZ20sXq+jS
        oC6FesU+k4uNutyM1s0evFNr7dq2PCw==
X-Received: by 2002:a1c:2601:: with SMTP id m1mr6867458wmm.185.1624396009091;
        Tue, 22 Jun 2021 14:06:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwA5evujCVmb41YGb1m83sZnYPN7g9tyPdWnf8NtEzUikjTHKJvyfO0OIMVr5bOTFLyikgVQ==
X-Received: by 2002:a1c:2601:: with SMTP id m1mr6867441wmm.185.1624396008898;
        Tue, 22 Jun 2021 14:06:48 -0700 (PDT)
Received: from krava ([5.171.245.189])
        by smtp.gmail.com with ESMTPSA id e11sm504551wrs.64.2021.06.22.14.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 14:06:47 -0700 (PDT)
Date:   Tue, 22 Jun 2021 23:06:44 +0200
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
Message-ID: <YNJQ5P3jgOcL7sMD@krava>
References: <OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YMc6tBoIQiUQkRbq@krava>
 <OSBPR01MB4600B6FCE4D95F6B84E7E17CF7099@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4600B6FCE4D95F6B84E7E17CF7099@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 22, 2021 at 07:57:56AM +0000, nakamura.shun@fujitsu.com wrote:
> Hi, jirka
> 
> > there'no leader link on this level yet (in struct evsel)
> > so this is not implemented at the moment
> 
> Thanks for the info.
> 
> Do you have any plans to support the event group in libperf?

hi,
not until now I guess ;-) what's your use case?

jirka

