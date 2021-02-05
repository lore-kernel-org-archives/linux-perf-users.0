Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF0FC433E0
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Feb 2021 03:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE4864E3D
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Feb 2021 03:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhBFDCi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhBFCwi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Feb 2021 21:52:38 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFCDC08EDF6
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Feb 2021 15:54:11 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p15so9532800wrq.8
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Feb 2021 15:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fsiPMDpF2frSGZ5pjaUeRfI0Ls7xB3hExHTjQquPSWs=;
        b=IsEWX5nX2mTngm/gI5A+aVCM0MXyM0s0slRtmguHQ/XcQUsXs0YWFieXlArPzha5HE
         OyKHUJmzC/0aBibu9VEhXpEw8HpDJ7ssviw5okdk1tODjEgBm7xocBwPyppusjljyFYD
         Y3nwcijA1Lwin1IoU1U1o8EN5KVNxfF5iV9+PHhMPRvhZlPMX/SdfW1iFuRCWWCDpLKa
         b0KoopqPXDlhaMAAnb8RybJP9dgGHRZlj5/YBalEPcflb2AMRM4/gBAqEMlj1xl/xIvW
         U01+4cR0jT2Gi4Q+sKqxvoAsQg+4pFDEbc3Gpxgrc24B/22uZmkowGI9pTUztZF9BaQN
         q5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fsiPMDpF2frSGZ5pjaUeRfI0Ls7xB3hExHTjQquPSWs=;
        b=bCOHlFYFFCW8LzNFB0qtiP2BfabBbJzBz2E9JDht12jtSkKcB2oFqgrLjNN85LO+bI
         s4eJqN8cwCKQtYX/MFXKjVtwglHXE3fXEhylm3NWu14epjhIdLPz82XYeW+KVBcRvMGL
         jAMNXFqhJUehWcXFEK1H3yNE+H7vOLE7o8AvuD9J1sntbZ0gbh4FSPDrPj/3i0THVQ6w
         RqmYxfPxlw0hfRVGW2AZS0MVWB2EQ4iDcMxA5WKx82TPKawHAUvoOnNi662hORzPRiyH
         nxazVR0KrdS61MWcEkPaQGX4XYZ89V58OzE5mzMt4pAmOl2f/6j6a/SSmhO1rHC+T+0/
         Y3Fw==
X-Gm-Message-State: AOAM533wbZr80BCWNsVs9RyuGnbzZOjK5YyOKbtnddvyHxA1+1GbzbkP
        ScjZfdtZfMzvB5yjajelTlWtjKbefCP/UG6OZvCcByVqNQalrw==
X-Google-Smtp-Source: ABdhPJxUkK6QaWQTQD35ufW1OwK0uP1HTwxh0cfetJtQPKIgPD00/A3OYFxHNIk8ZxTCyxyqNPvd40KcO8E/V2eHDkc=
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr7126535wrm.376.1612569249531;
 Fri, 05 Feb 2021 15:54:09 -0800 (PST)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 5 Feb 2021 15:53:58 -0800
Message-ID: <CAP-5=fUPZiSJinVQ940cqHGDZDZamrcYUXG0NFpjEGg=6sngxQ@mail.gmail.com>
Subject: GSoC 2021 - Volunteer to be a mentor
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Till Kamppeter <till@linux.com>, basu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

Google Summer-of-Code is looking for organizations to mentor students
with a deadline of February 19th:
https://summerofcode.withgoogle.com/how-it-works/
If accepted the deadline for students to apply for projects will be April 13th.

Till Kamppeter and Aveek Basu for the Linux Foundation are making an
application:
https://wiki.linuxfoundation.org/gsoc/google-summer-code-2021

and I've proposed mentoring some perf related projects:
https://wiki.linuxfoundation.org/gsoc/2021-gsoc-perf

It'd be nice to have more project proposals and potential mentors. If
possible, please help with project ideas and volunteer to be added as
a mentor!

Thanks,
Ian
