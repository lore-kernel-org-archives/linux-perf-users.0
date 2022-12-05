Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD738C4321E
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Dec 2022 21:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiLEVCz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Dec 2022 16:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiLEVCe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Dec 2022 16:02:34 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3C02CDD0
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Dec 2022 13:01:18 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c15so12363040qtw.8
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Dec 2022 13:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0g+SKmAQ2kZcw7R9wbq09u917yFQk55hrlQw4/atyqw=;
        b=fqjco4MOdoc7e+SC1pgcm2gXY0oIK5KEBZGpOE9my4n20dkm5CQaBG1No12SlAV3oT
         BKYHi4+EBmmlZmuaqx0Mhx6hTQjgAAQQnLyZjM+HK/SQ34GXKXTx11myzziJO8Jg8frU
         kmlj7Xx6x6Pgc3nLHpW0wF5XwLbp/W2cOxU3UpmbuehDajPS06ZOuxF4hOJknDuwp5RT
         Y7eG4gi/rirYB4dcvv2pplHzwOXPkYnGFdXyTdrBLateVtSR3WjLqILJ9qv5jmxQJdCX
         hNN4sEr+QcmDwBUWRmdKGcj1Y3Xp8qPbuVMIHea+9wo5x4Xesy+CDmQxH0pL5HHuHcxT
         11bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0g+SKmAQ2kZcw7R9wbq09u917yFQk55hrlQw4/atyqw=;
        b=JHI8rm1EaQz7sB25wqaeQuh9Edk3Lv7Vyc01bimaJQPKrlHE9lGrw3PQsSLOjGs+pv
         x09oaJtmobzqr+xHNr5/jOMtYEr3YcOEedATcMfFY7u5/8hGH9SCo8YNFLMV5l6fS3y4
         ZLRJsHaQaDIjBpSlCzo7HqCVUHCobMsxjWiELAbNTIGgaqeD5hVg6MFT7L+OewSTOI/2
         BOKvzasb9LJDXO+N4uDZkFj5MR3j954R513n1SnobVFKwR2vfuUj+z7ZDyYhh2WwfKlx
         D8R6kwZZLFqMPbxkbD3l8VK9bUaHKMEI/HFRcEMtMInBKeqwhAUaivVh1YDmfLCwUE59
         IOsw==
X-Gm-Message-State: ANoB5plU5TFQ7gDj83RG9w6//WOEl6Ksb18cZ3yYUkz5SWpuX7rPZ/7G
        pvgNDsJPJx/5olyiXUhJ5aI=
X-Google-Smtp-Source: AA0mqf6wOfQE39/VADia+urPjzcqEzQ7S4gd3/6x0Znca/vwg7c0glx7cuzBoQozG55koAxs+qSCqA==
X-Received: by 2002:ac8:1090:0:b0:3a5:6047:c75b with SMTP id a16-20020ac81090000000b003a56047c75bmr60197647qtj.60.1670274074084;
        Mon, 05 Dec 2022 13:01:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fu24-20020a05622a5d9800b0038b684a1642sm10280940qtb.32.2022.12.05.13.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:01:13 -0800 (PST)
Message-ID: <7d262374-1217-d79a-ff2d-d6626a98e195@gmail.com>
Date:   Mon, 5 Dec 2022 13:01:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] perf python: Account for multiple words in CC
Content-Language: en-US
To:     Khem Raj <raj.khem@gmail.com>, linux-perf-users@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fangrui Song <maskray@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Keeping <john@metanate.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20221205025534.150006-1-raj.khem@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221205025534.150006-1-raj.khem@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 12/4/22 18:55, Khem Raj wrote:
> Sometimes build systems may append options e.g. --sysroot etc. to CC
> variable especially in cross-compile environments like yocto project
> where CC varable is composed of cross-compiler name and some needed
> options for it to work in a relocatable environment. Therefore separate
> out the compiler name from rest of the options in CC, then add the
> options via second argument to Popen() API
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Keeping <john@metanate.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Khem Raj <raj.khem@gmail.com>

FWIW:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

