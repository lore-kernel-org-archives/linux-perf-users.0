Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE10C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 19:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A2F619E1
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 19:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbhKHTxv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbhKHTxv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 14:53:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A84C061570;
        Mon,  8 Nov 2021 11:51:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v23so6956210pjr.5;
        Mon, 08 Nov 2021 11:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IjhS3kxhetwXaiYgcJTnbbq17lp2O4y2bTsBt4Udz4Q=;
        b=jGk+Vd/0P4mleeeUfxZYYpjag6EOgu5O79b4VSJg1G8hvCKC8kzYgtBwIBSL25zecM
         BbVHlslQLYsZeraYj9Gol/D0D6I6vyHLZHx95o4pWVmfNQlwjOsa6+pLid4KQVRUnwvt
         3PUBAktZF4H4Arm8zPwHX+Bo/vbAbh+VMfWryOrQPPfaUTngYmbBlyort7ZgrrjoZPyk
         ghCacJRI1gNkckADwzimiuITMmIesDrft0SaO4FDF9XtO+hl55c8WcNFlxfwwZD9Nshe
         OD21exr+Af3DYjHIM7Z6STmaO36C7MrmGkmFo1P/cZ6M0gH1f2Urf6dmiOLj14HLxrQj
         PImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IjhS3kxhetwXaiYgcJTnbbq17lp2O4y2bTsBt4Udz4Q=;
        b=ScM1wdkZOzMjb+NrAfab5KoT9wGNzkTo5Fo7Jt+kP3tj7zcZMe0wt/teJKPCLB99UJ
         wQ+CoqQPxnUJthP5gtTIMLW3PLUfx4WZpCcmv9CxVsUXlAmGbsSMj+JEAg5XB7DTPg4p
         GEuul5K9Pn4MgaJqyp8asyGC7+mzjJ2yCbIMzdL14yE4E+X8GyyMWxvxFUPvulJ/uOeZ
         YGkTru5+lPI3JlrsHdj6zFbyWGQjgtnA67N9pL+hlUJqYbTg++veVMWaGMg53b4gOw8u
         cZnhZeJjzcD/XLYEzwR/jXMScInh+DsXS++0mHaNCNIa0sYutYZ7tPudFuz6kLCcMcys
         2fSQ==
X-Gm-Message-State: AOAM531m+w0pgT4+hF3StXqyFgoPb4lC/usGnHzlovH4Y3j0uaZ+6Bwd
        v+8JGywxh7j99EM4zO4BJzM=
X-Google-Smtp-Source: ABdhPJzwspsRw+pFLcs7NL58X4vW0O0hqmVH+i6tzE9683Ol0eMaNNPBKqVy2Y3SFYOKl0KLl7AEIQ==
X-Received: by 2002:a17:90b:4b04:: with SMTP id lx4mr914448pjb.11.1636401065754;
        Mon, 08 Nov 2021 11:51:05 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id m12sm170166pjr.14.2021.11.08.11.51.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 11:51:05 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Using perf_event_open() to sample multiple events of a process
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YYlBMmMg0PTV3pED@hirez.programming.kicks-ass.net>
Date:   Mon, 8 Nov 2021 11:51:04 -0800
Cc:     kan.liang@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <ED4D20D0-DD1C-48D1-B686-E519EB384429@gmail.com>
References: <92645262-D319-4068-9C44-2409EF44888E@gmail.com>
 <YYXQRYbRO193U4re@hirez.programming.kicks-ass.net>
 <YYXS8yldO/dwwVD4@hirez.programming.kicks-ass.net>
 <YYlBMmMg0PTV3pED@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


> On Nov 8, 2021, at 7:24 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Sat, Nov 06, 2021 at 01:57:23AM +0100, Peter Zijlstra wrote:
> 
>> The problem seems to be that we call perf_event_set_output() before we
>> set event->ctx, which is a bit of a problem.
>> 
>> Now, afaict it's been broken since c3f00c70276d ("perf: Separate
>> find_get_context() from event initialization"), which is ages ago :/
>> 
>> It's waaay too late to try and fix it; I'll be likely to make an even
>> bigger mess if I tried. Perhaps tomorrow.
>> 
>> Clearly FD_OUTPUT isn't much used :-(
> 
> The below seems to fix, it's a bit of a hack, but I couldn't really come
> up with anything saner.

I originally considered doing a similar hack. I assume it should work,
but I moved to using the ioctl workaround that you suggested.

Clearly nobody is using this feature if it is broken for 11 years.
There is always the option to deprecate it if there is an alternative.

