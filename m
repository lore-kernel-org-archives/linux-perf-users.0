Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340B7C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 19:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A96B61371
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 19:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242457AbhI1TWH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 15:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242385AbhI1TWG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 15:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632856826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5DJdgaC2spuvdCBJC4Spr3EqvLd8zk82cI55wL8C9Qk=;
        b=Ua5n9q3U9ZqrFDvuSQNh2YRll1CapRR1PvZLdQ8zsTNJlY93bzL7C51FFcVQKRXpww9E6V
        ETdZZ1w/9tlHsspeDsA12olcCJGQO6O/NnzKkK5mUWl0Q5B0lH+F1Xoisg0EWOB/s7mfn8
        OZmTkxgqRs7v5wnUvMdEj+L7Ejp6Xjk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-zb9DkLfmPsSA3ZJP5ZTxFQ-1; Tue, 28 Sep 2021 15:20:25 -0400
X-MC-Unique: zb9DkLfmPsSA3ZJP5ZTxFQ-1
Received: by mail-ed1-f70.google.com with SMTP id o23-20020a509b17000000b003da756cac0eso7991832edi.22
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 12:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5DJdgaC2spuvdCBJC4Spr3EqvLd8zk82cI55wL8C9Qk=;
        b=25uVeCMLSPE7e2UBJg3zlDmDVUJ43aA7c+AKpzCTZHLLTmNRbyCvm6culdNjh5tFPg
         bnqy96xFadnY+GwUg2ZlIUYXuxku+d7FmatDNmPQZS1xR7lmWMsWb8/ZQt27uSARfUnS
         P9IIeSUGPxJbMMulaVdLMnh36A7LFqqDwnoXs0oreXeo5GAG3gCVkHq6+Fw5pSyu6xfS
         Y0OMfBeDDpvkgbWXdwbgAwgr2uuFPxUEA0lvAAKNf+3guAROtlfiHtyJSsjKMGn98R+4
         ZZyhSUmL/ryJMJ43acQe/wfC8MNu3fwzKW9+bc1zWQ4q7XW/wuDKsyJDwsH5mlJykSfg
         y26A==
X-Gm-Message-State: AOAM532onNZ6CZChT0Booi0833+/GQYzA6NycC9FP/FQC/HWXN7yz238
        mMllkIy2NB9cn1alf8abrdUbPAGrzPh2whsWqq29hWJfeieISUPBkKOi7F2A0DzdG7+1DLel3Yq
        Hdob+anzg93Iq6LlDMo8WRH3x3Ghdpg==
X-Received: by 2002:a17:906:9747:: with SMTP id o7mr8527743ejy.486.1632856823790;
        Tue, 28 Sep 2021 12:20:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3pqh66Y007qjr2Rpf5hXI9ilWkrw4W9YKPhpRy+WXwy8t8tR/o/AJQxiQpDVKFET4/m53OQ==
X-Received: by 2002:a17:906:9747:: with SMTP id o7mr8527728ejy.486.1632856823646;
        Tue, 28 Sep 2021 12:20:23 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id jl12sm10902844ejc.120.2021.09.28.12.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:20:23 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:20:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: problem with 'perf script -F weight'
Message-ID: <YVNq9av/3Lwmom4T@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


hi,
Joe reported broken -F weight in perf script with (on x86):

  # ./perf mem record 
  # ./perf script -F weight
  Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot print 'weight' field.

the problem seems to be introduced with the WEIGHT_STRUCT change:
  ea8d0ed6eae3 perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT

which enables WEIGHT_STRUCT sample_type on x86 instead of WEIGHT,
and leaves 'perf script -F weight' in the dark

I'm not sure what the fix should look like.. should we allow user
to use just 'WEIGHT' sample type? or is there a way to get original
weight from 'WEIGHT_STRUCT' data, so we could fix just perf script?

FYI when I switch back the WEIGHT_STRUCT to WEIGHT again it seems
to work as before.. as expected ;-)

any thoughts? thanks
jirka


---
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 2f733cdc8dbb..6bdd744894ad 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -4,5 +4,5 @@
 
 void arch_evsel__set_sample_weight(struct evsel *evsel)
 {
-	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
+	evsel__set_sample_bit(evsel, WEIGHT);
 }

