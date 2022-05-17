Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF2C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 13:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbiEQNXK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbiEQNXI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 09:23:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC742EFC
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 06:23:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kq17so34700324ejb.4
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7/rK2aVAsHwMrIQcWS8rWb/RzzGbuxUEumy+JTCBUiw=;
        b=nGbh7oLtmyjLXFQ3yL1bjr85DuoEkFUXBURb8QXnSb1msTwKjTsof4P2zkOuYWzt2g
         6dNd8qwTYPMh7Z/yI/SqrCEEoViorzJt17G8USXfvz0/BKc2X/0M33THXiMAWwVXfbv5
         DPIElxxjZMBv5SVD1EDDDuqwluzi2Qy1yB/gjHKMZWe5XjSMnMpDO7wndNdfgu4rmeUE
         UFYvEEwv7qzjQltuduGPyxNXkf09MNlUIxugHbhyq/zZpCOWYAS8tOA8MWRNZJJTGIWi
         HY0VRNYDgbd34yX7TrM1SIO+xKqXEql78iNVLvlyCb4JShztkIoqIKRW9l60rXA9bwDD
         oInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7/rK2aVAsHwMrIQcWS8rWb/RzzGbuxUEumy+JTCBUiw=;
        b=cqEOzRL79sxR4jdVyAVOwZqN/CnqF71sJTMProUW9L0mpUhJ0VtHeBmRoz1KMs5G5S
         KaM2xAbCh18ZwueP7X3TjfhcuwMoHIwyEcihvfmAOfrUi1iQZW0CZSlfqVri0swUFOLL
         DkJOBv84e43Wa9vWkpSK1YfQo5YYSZ3k2ECidelO1+1MYHYxaL1P/exNiB4MpHtlXatH
         aUfFm2KEh+IZjpj1bIXANJ26nQAVNbHdRYTXQVw9Mr6TNZI5jvCqEzLLuFyG2LHtnT5D
         YfGgt2pCsDhiN6No83BZgjiCjUMo8veYAKIIz++qASvjqboqmL87SaS9Sk0JHfQPKuqU
         nDWA==
X-Gm-Message-State: AOAM530gCBMyMQe+HmGH7tML7tcVUS706dSuNjVM4I08qcKzDMs21Nw9
        NXxA5W5ZT4t/u6/6t8We52Lw94eXwLOYOVID
X-Google-Smtp-Source: ABdhPJyuzMkoQH6fNkas9Hd5n0W8XafwwSSx48Cyik5wpw9KeB9uDGU4mw291MS47nmsocE93KpaIw==
X-Received: by 2002:a17:907:3e8e:b0:6f4:ff62:a399 with SMTP id hs14-20020a1709073e8e00b006f4ff62a399mr20869929ejc.298.1652793786005;
        Tue, 17 May 2022 06:23:06 -0700 (PDT)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id t20-20020a056402525400b0042617ba63ccsm7138612edd.86.2022.05.17.06.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 06:23:05 -0700 (PDT)
Message-ID: <659c01ac-7c99-a50b-b52e-9f565f3892f0@scylladb.com>
Date:   Tue, 17 May 2022 16:23:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Infinite recursion in `perf record`
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org
References: <f0add43b-3de5-20c5-22c4-70aff4af959f@scylladb.com>
 <CAP-5=fV0rXit7BqBxghE=zK=ao_GYhwkCbu+GhJZebzhVCxq0g@mail.gmail.com>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
In-Reply-To: <CAP-5=fV0rXit7BqBxghE=zK=ao_GYhwkCbu+GhJZebzhVCxq0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 17/05/2022 01.04, Ian Rogers wrote:
>
>> perf-5.17.6-300.fc36.x86_64
>>
> Hi, could you provide more details of the build? I have a bazel based
> build and weak symbols are a problem for me too. For example, arm and
> arm64 code needs building and linking together on an arm64 build for
> the symbols to work properly - normally we just need 1 arch. There
> have also been issues with constant propagation. I'd prefer if we
> could use #ifdefs where we explicitly say what we expect to happen on
> each architecture. Weak symbols' implicit behavior is troublesome.
> With #ifdefs if things are broken then linking fails, which provides
> useful signal.


I'm not sure what details you want. The full build log is available here 
[1].


[1] 
https://kojipkgs.fedoraproject.org//packages/kernel/5.17.6/300.fc36/data/logs/x86_64/build.log

