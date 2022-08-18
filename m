Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAB7C32772
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Aug 2022 16:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbiHRQbE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbiHRQbD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Aug 2022 12:31:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445766A49D
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Aug 2022 09:31:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h24so2330115wrb.8
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Aug 2022 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Mj2W/9YQ8CSVcaLjuXP+DmmiR5MM9ERHw2BcymcGKFA=;
        b=kS4KpE0rlsabzWnpMDsVwTahuARW+OsaJWtYu0nSqaSJYtXJ3Inktf9oVEwqf5oBV7
         /5RTXa9UKdj2LbuQPGZRPN3IRXzOCkL4rDmuqTEsuHR5MAgE+VsVWZhp6lEXPtSWZrxi
         tiwtnj2jSsSNDMXmvaNaIf3r3yFUeuSLMsthc3ekMjSAnxCsWDVOdUr5M0iO4yxSsinH
         gcM0f0m2recGgtPRAiHhXGMr7enPlylCctjjbzG7lM+Cj4V++53YJGgEdBUEauSZGDlv
         O7rLKCVfQUZh9byFXh8HTW6yp0bervbaO3ldEdReGqy2Jo6UZrHavn7bwumbyOSDbo45
         Rw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Mj2W/9YQ8CSVcaLjuXP+DmmiR5MM9ERHw2BcymcGKFA=;
        b=4vsKkTcHTYQ7JXXzwO+GcY6eQuqq6fS+UVR+b7nmb7PN+U9EXl+U956nkJEDl1ZG+A
         F2wKRkW6yy2YvIXh7BpudIo2szxmUIFvJzzcd8my52RuyMBvaF3PouE2lrVVTcdaMi4Q
         98ArZLAdZSP+W+/5vYyiRYf2zHRnfSmm/RavTx1rPjLUFsJdL4Zod1T7ODCIp1VYj+2Y
         zHKmHT3c1HIy0PVE2/QnoFvJGZJY8WqIPbCGIiUY+GyWjWmb3PEdwiHwEXoz0i8wP5IW
         eLPFufA1H8/D/62k53+1QUhIkezxhEWhw7/TvhyiWkINZxBYdznx24Cut4/VVhpBTUCV
         QuWg==
X-Gm-Message-State: ACgBeo3J8ECAc6UyxJqDu57ZDem5hs7PHT8VSfK6Lc1G71CGUD5bxhmc
        0qvNIxHvyNFZiv40ytWE4R79C8o94SA+D4eu0DW3GA==
X-Google-Smtp-Source: AA6agR7ptwgOiN9ve6GHG++tOZb69TaGwVq5lbuz8r6SbFoOXDjW/azm5vFAdP7Toc6aCziPDQNVRfS97n3nj3BrVAo=
X-Received: by 2002:a5d:4907:0:b0:21f:bc42:989 with SMTP id
 x7-20020a5d4907000000b0021fbc420989mr2074812wrq.375.1660840260654; Thu, 18
 Aug 2022 09:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
 <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
 <b42344bc-86f6-9047-b015-88ef3b58a619@intel.com> <CAP-5=fUq4N+X+3VMsT=he3Q9_4qHKkqxdPDcMdDE=_3qdV9aCg@mail.gmail.com>
 <YvzrYLx3RDHAmqbf@kernel.org> <CA+JHD90RuF+sjO7t40voiQrXbaH172Le=KeKGzTrK_tBquVbAg@mail.gmail.com>
In-Reply-To: <CA+JHD90RuF+sjO7t40voiQrXbaH172Le=KeKGzTrK_tBquVbAg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 18 Aug 2022 09:30:48 -0700
Message-ID: <CAP-5=fV1_JToqVDqjTcTpLZ48CzfGY-kmH_WOoAD8z+QNyRsaw@mail.gmail.com>
Subject: Re: perf tools man pages on the web
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Kacur <jkacur@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 18, 2022 at 9:24 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Wed, Aug 17, 2022, 10:21 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>
>> Em Wed, Aug 17, 2022 at 06:02:25AM -0700, Ian Rogers escreveu:
>> > On Wed, Aug 17, 2022 at 1:55 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>> > > Speaking of the wiki, anyone know how to change the
>> > > "Set $wgLogo to the URL path to your own logo image." image?
>>
>> > +1000
>>
>> > Someone at RedHat knows :-)
>>
>> Documentation is at the Media Wiki site, admin up to a point was John Kacur,
>> John?
>>
>> https://www.mediawiki.org/wiki/Manual:FAQ#Changing_the_interface>
>>
>> --------------------- 8< ----------------------------------
>>
>> How do I change the logo?
>>
>> The logo that appears in the top left of each page is determined by the $wgLogo configuration line in the LocalSettings.php file.
>>
>> There are two ways to change the logo:
>>
>>     Upload a picture to your wiki using the normal file uploading interface. This allows the logo to be replaced easily, so you may want to protect the page if you use this method.
>>
>>         Then add the $wgLogo line to LocalSettings.php, for example:
>>
>>         $wgLogo = "{$wgUploadPath}/6/62/mylogo.png";
>>
>>     Upload an image to your server by other means (such as FTP).
>>
>>         Add the $wgLogo line to LocalSettings.php, for example:
>>
>>         $wgLogo = "{$wgScriptPath}/mylogo.jpg";
>>
>>         (In this example, the image is in the same folder as the LocalSettings.php file.)
>>
>> If you want to change the logo in only specific pages, override #p-logo
>> css's background-image property or use third party extension like
>> Extension:LogoFunctions.  Caution! Caution:     Do not simply overwrite
>> the default logo installed with MediaWiki (/resources/assets/wiki.png);
>> this file will be overwritten when you upgrade.  A good size for a
>> square logo is 135x135px or 150x150px, but the logo need not be square,
>> especially if it contains text below an image. The maximum logo size in
>> Vector is ~160x160px, while MonoBook's is ~155x155px. A logo that is too
>> large will be cut off.
>>
>> --------------------- 8< ----------------------------------
>
>
> I got it sorted out with the kernel.org admins.
>
> Please force reload.

You made my day!

Thanks,
Ian

> - Arnaldo
