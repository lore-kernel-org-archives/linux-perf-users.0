Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570AFC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 08:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F8A61059
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 08:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbhIBInA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 04:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244285AbhIBIm7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 04:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630572121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l/Me272OZcfBsjPxKCW9n7fhIwLkTbM3YotDIdmsMn4=;
        b=ebUUAg8w0R+ozucXgEBMqNi/AZxDdCLfb8x4z7mgHH9j+cHPH3Qib3HGzXelYlz+0n2Shp
        Nbvnkdvsi1fggOI775KqZiDXcIenPQgRZEmretbTC1hy/JZ+xuH31UT0cP5mqD+i/JbhmS
        gS92yxEzGWQnZoMBPM3W5YxMrWQCUis=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-JX9qFglZMoWW2EJaILY5BQ-1; Thu, 02 Sep 2021 04:42:00 -0400
X-MC-Unique: JX9qFglZMoWW2EJaILY5BQ-1
Received: by mail-wm1-f70.google.com with SMTP id m22-20020a7bca56000000b002e7508f3faeso432467wml.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Sep 2021 01:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l/Me272OZcfBsjPxKCW9n7fhIwLkTbM3YotDIdmsMn4=;
        b=HWkVup6/+O+XY93y7lEmDUzKIRtUlP5dhxcL0JBI0R9dmvfPrANX+9svKS8nLBRIsQ
         TUlRagr+S0zVw810mOOd5KvLkmRdr/1fPsFmIFCW4WAi85e+51SjAam0FyrOe75oZc2B
         oaxOI9/ERjTJKSG7U2kIgnaMB6rY5FXIXnIGo808HtuCgkCzCSliNkUuiCHd1dlbzOJr
         04mAaEj+rTu+WjnlEAMcm+naSBg2Zdl3sgAem0f/S+5fwcyW397WEvm3oHzVuGdrpaEj
         k2s5Y5sgyOChzA1cZXaFUKkKOoCa6EU3efovqtw88buYE9bLqL9p2HlVddNE1QIXxllr
         wErQ==
X-Gm-Message-State: AOAM532LShur37aXvTpb4On6BcSbuMPDmXjVYa+X2iv8s/pevJ9KquYM
        WmB+ITc8bB8O1GE7oApvn9rCE+N5qyNuvsdG4KomM0ZV/koiLooMT7wx29EKiQpM65WGtJ6P7Ja
        4oQsGE+mlaYos+uXDwu84Z0Pu9Y31Fw==
X-Received: by 2002:adf:80e2:: with SMTP id 89mr2236837wrl.43.1630572119002;
        Thu, 02 Sep 2021 01:41:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwGjviyCfi17xavjw+z/D7fJntWfKQ/kRxKpArhL7OwEg4VyKsDyLCxTRgU7fmZk4cBdGDhA==
X-Received: by 2002:adf:80e2:: with SMTP id 89mr2236810wrl.43.1630572118716;
        Thu, 02 Sep 2021 01:41:58 -0700 (PDT)
Received: from krava ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id d145sm1022755wmd.3.2021.09.02.01.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 01:41:58 -0700 (PDT)
Date:   Thu, 2 Sep 2021 10:41:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Nakamura Shun <nakamura.shun@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: libperf: lack of interface
Message-ID: <YTCOVGyffe+VwL6G@krava>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YS+B6PVHtiTmqZS+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS+B6PVHtiTmqZS+@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 01, 2021 at 10:36:40AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 01, 2021 at 09:45:10AM +0000, nakamura.shun@fujitsu.com escreveu:
> > Hello.
> > 
> > I'm trying to change rdpmc test in perf_event_tests[1] to use libperf, but libperf doesn't have enough interfaces.
> > Does anyone plan to implement any of these libperf features?
> > 
> > - Interfaces that can run ioctl (PERF_EVENT_IOC_RESET) from userland
> > - Interfaces that can run fcntl (SIGIO) from userland

hi,
we could add perf_evsel__fd like below, would it help your usecase?

if you described your usecases in more details we could
see if we could add/move something to libperf for that

as Arnaldo said below it could be already in tools/perf/util/*.c
somewhere ;-)

jirka


> > 
> > [1] https://github.com/deater/perf_event_tests/tree/master/tests/rdpmc
> 
> So, while in this specific case you should probably follow PeterZ's
> advice, feel free to submit patches moving stuff that is in
> tools/perf/util/ to tools/lib/perf/ (libperf) when you have a reasonable
> use case, such as Vince's test suite.
> 
> We can then discuss if any adjustment is needed, but doing it this
> piecemeal way, with justification, should be a good way to enrich
> libperf with things that are in quiescent state in tools/perf/util/ and
> that have external users.
> 
> Thanks,
> 
> - Arnaldo
> 

---
 tools/lib/perf/evsel.c              | 13 +++++++++++++
 tools/lib/perf/include/perf/evsel.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index d8886720e83d..8cbdaa78749c 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -413,3 +413,16 @@ void perf_evsel__free_id(struct perf_evsel *evsel)
 	zfree(&evsel->id);
 	evsel->ids = 0;
 }
+
+int perf_evsel__fd(struct perf_evsel *evsel, int cpu, int thread)
+{
+	int max_thread = xyarray__max_y(evsel->fd);
+	int max_cpu = xyarray__max_x(evsel->fd);
+
+	if (thread >= max_thread)
+		return -EINVAL;
+	if (cpu >= max_cpu)
+		return -EINVAL;
+
+	return FD(evsel, cpu, thread);
+}
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 60eae25076d3..5f29935efcaf 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -39,5 +39,6 @@ LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__fd(struct perf_evsel *evsel, int cpu, int thread);
 
 #endif /* __LIBPERF_EVSEL_H */
-- 
2.31.1

