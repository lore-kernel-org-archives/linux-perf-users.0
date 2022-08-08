Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3132FC00140
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Aug 2022 11:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbiHHLaO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHHLaO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Aug 2022 07:30:14 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81430FA
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Aug 2022 04:30:12 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id q15so8544108vsr.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Aug 2022 04:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc;
        bh=revUukWPPU4AUzXIBNxy1XAS3mP/qj+7HgtZ72HE0QQ=;
        b=gWAwu5LKiMVyzl9dK6URMXDpr+lad/spVSP/l1swnDbl3dQcerjSdiqEp5imuNqAYr
         l+8Q8Z8mIv6CKkqLMVUilCApTTNdkffiL529OqJ+TIqwrQ23GWFQe3Tta2+RzVKu0bNA
         FDYOM90SriLtzTwO0tBeNCezYg/0Hto2qE9Zq1225pWJDLJXQ1UrHgeS8AKT62K+KFt9
         9cClzyOr9ZWmWM0LeA72D0vR9s7htiphWG3GxPeR2RjtAaZhuzdf+ef9jZMxph6VWW5N
         IYLGClCZTI58OmQw8EU1TUfgQEdLM/I39fjz2Pq7GMc92YI8PrzKCPACaTW5Fe019fUo
         Av/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=revUukWPPU4AUzXIBNxy1XAS3mP/qj+7HgtZ72HE0QQ=;
        b=pnOFYSUs4jIQSNbNgiGfkIr5Jd+mHPSEonBbsnk7oJThJMYt+6o8NsZXJfKJ9GMlpc
         Ekmw7cAxTiIxLtqwg0xphVvZ6QvFoSGHOUckJDUQjKhsQizHWKW9o10t5bGt8HzSt/h/
         nGNySPCVa61CIDriOkxMyJlRSJIDCx1NZi7b7g8V1mIbS+vVPDDckp8yAoEApdh4qWy4
         9VW1ea7viJF2Hrc81IqIfxc94GbG4N9MDliE3N7OCpNLGk/2k5OtyFotE2S43qelSceH
         +OY6PoFCVfaoLHXYftmEG8FfqFxB2owWkhWyyhY6vl7QVJ2/6M9y7+PmP4/ofHdHEQa6
         IYzA==
X-Gm-Message-State: ACgBeo3LY3y7qUcKL6tIJGmPhRJBqKALl5DynXDMACJJ7ks+V4miqtOd
        UGo0cYUiWn6+tt5Kgf0mxtc=
X-Google-Smtp-Source: AA6agR4u2sS95/sr70b12iCWHIfYZU/uDTBjSKg4kFwWJXx1TNKhp1hw+/d37YjckzOfqRELHpO2AA==
X-Received: by 2002:a67:c215:0:b0:387:21f6:282a with SMTP id i21-20020a67c215000000b0038721f6282amr7180592vsj.30.1659958211571;
        Mon, 08 Aug 2022 04:30:11 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.239.32])
        by smtp.gmail.com with ESMTPSA id f16-20020ab074d0000000b00384cb279757sm8736429uaq.33.2022.08.08.04.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 04:30:10 -0700 (PDT)
Date:   Mon, 08 Aug 2022 08:30:03 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>
CC:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: perf recording with java runtime broken with commit 2d86612aacb7
User-Agent: K-9 Mail for Android
In-Reply-To: <20220808105556.GC35313@leoy-ThinkPad-X240s>
References: <defae7d2-5f3e-5de1-bcd0-f7ee7871a9f9@linux.ibm.com> <20220808083618.GA35313@leoy-ThinkPad-X240s> <b8ce5423-f6ee-42bc-75eb-ce182cc325b8@linux.ibm.com> <20220808105556.GC35313@leoy-ThinkPad-X240s>
Message-ID: <F4B3D957-548A-4AD6-B00A-1C5BDD18E6EB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On August 8, 2022 7:55:56 AM GMT-03:00, Leo Yan <leo=2Eyan@linaro=2Eorg> w=
rote:
>On Mon, Aug 08, 2022 at 11:25:29AM +0200, Thomas Richter wrote:
>
>[=2E=2E=2E]
>
>> > Ian has committed a patch "perf symbol: Fail to read phdr workaround"=
 to
>> > address java JIT symbol issue:
>> > https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/acme/linux=2Egit/=
commit/?h=3Dtmp=2Eperf/core&id=3D6d518ac7be6223811ab947897273b1bbef846180
>> >=20
>> > Could you confirm if have included this patch in your code base?
>> >=20
>>=20
>> Thanks Leo, this patch fixes my issue=2E
>
>Great!  Thanks for confirmation=2E

It's upstream already:
https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/c=
ommit/?id=3D6d518ac7be6223811ab947897273b1bbef846180

- Arnaldo
