Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EDCC636D4
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Feb 2023 11:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBQLC5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Feb 2023 06:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjBQLCi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Feb 2023 06:02:38 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967E664B16
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Feb 2023 03:02:29 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x4so956749lfq.2
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Feb 2023 03:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/plfQ38dzMrGO1JbheJ9rCmuE1cLMVk9gw7wSXm4Jqc=;
        b=b1x8b/jwmA9YOIRBgoOQyok9k8pouvrhm1zW5L0FTRJgx+tIK7LO0HIF+s3C/ln4Po
         VrmFB1cPNkVSAkWm9YVkoV5JvDum7g2l7Lq1tZEMvmXRChfaVOrbnmpg5Q3zwn0jmguJ
         5TO652PsdgW32LksChbowDOFodL6kp9mixIVoj7WO2ErnuGYAiblfGIRTtg89BpY3VRI
         rul5RtUiXlQ2JpEGKJ/1mcOvWcrJnkeKixOfEwlqihTR2gfPCAw8hsgOWxoG32Q852fw
         l01JuY1BE44VUErAENa1J51SGav4GCTVkkEfuOLyPcBkTai7J4r0k9XBoR/2MSEq+9gl
         Kp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/plfQ38dzMrGO1JbheJ9rCmuE1cLMVk9gw7wSXm4Jqc=;
        b=w5sOASSpD0Z/tGzouHpKNCa50cXEBXNRzfteuNVcoL2uR0BZEy1fw8L7kZW97GZ9bJ
         ZIQyk+DEgf0WxIMTafnpcKEvPi3dCCPdw8aim8FV5mYulqSJAJynDA6bu4GH5yz99z4A
         uqqf50HhuN4e5LEGhnQkRC+hhZlGCHBJGiwIvp6FSsqFx/jjoRtxFe3ujbtp/IhwtGj3
         k/ZCFK3oHxrfWWb7gmVT9CIEetXbj4aZrDG1jognZNtJiy1VSiW3vsAmc6mLFulhqDs/
         5t+2x/ZQFtIY6DyqaKuG4Sbz5vS75Igqz0DxwpESa+P8mjTAJdElQhpnuT7iqoM/Ggd6
         o1uA==
X-Gm-Message-State: AO0yUKXMulzkMg5Om9RtmB1OjXOv55M5i1e9kj8ezw6KvTYsHhM1d+M+
        DBVBw4q9LXvKN4xdX50FEnORrw==
X-Google-Smtp-Source: AK7set/2y7oM6jSdsEB9bbAcsNFt46R4u7C7/sbZGhjSO3xWVD8rkQc6w9MsM4qA6Cl9MgV3Ao8l8g==
X-Received: by 2002:a19:f611:0:b0:4b6:d28a:2558 with SMTP id x17-20020a19f611000000b004b6d28a2558mr2958542lfe.49.1676631747693;
        Fri, 17 Feb 2023 03:02:27 -0800 (PST)
Received: from google.com ([2a00:79e0:18:10:d02c:4bb8:fba9:c9a7])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651203c600b004cf6c56fdb5sm643926lfp.232.2023.02.17.03.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:02:26 -0800 (PST)
Date:   Fri, 17 Feb 2023 12:02:21 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf intel-pt: Synthesize cycle events
Message-ID: <Y+9evQVBRLrCLQKf@google.com>
References: <20220322082452.1429091-1-sesse@google.com>
 <YjpAYjdgHWwkid5N@kernel.org>
 <YjpFcLiCTjHZWzzA@google.com>
 <52d31321-66e1-f189-2ffc-7c93239eea74@intel.com>
 <Yj49LDY3S/ANeN0V@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj49LDY3S/ANeN0V@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Mar 25, 2022 at 07:07:40PM -0300, Arnaldo Carvalho de Melo wrote:
>>> 
>>> There are two issues in play:
>>> 
>>>  1. PT event synth doesn't support reading inline information from DWARF
>>>     yet, and my patch to add it runs into some problems. This is not
>>>     relevant for this patch at all.
>>>  2. The results from v3 don't quite match the ones from v1, and neither
>>>     of us are entirely sure why. My personal feeling is that the one
>>>     from v1 are the wrong ones, but it's up to Adrian to say whether we
>>>     want to try to investigate deeply here.
>> V3 is good.  Please take that.
> Thanks, applied.

Hi,

I downloaded linux-6.1.12 now and built perf from that, and this patch
isn't included. Did it get somehow lost along the way?

/* Steinar */
