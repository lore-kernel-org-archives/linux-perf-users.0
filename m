Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213D9C54EE9
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Sep 2022 01:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIUBjJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Sep 2022 21:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIUBjJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Sep 2022 21:39:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D1A5F9A3
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Sep 2022 18:39:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l14so10318923eja.7
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Sep 2022 18:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=A/TFlGdOr8L/9hEZD38FqFy5byp9WYzQRTAFhaafmME=;
        b=va3s9xU4UW96rI9p0nc9mQFlluDyafsuobzVGnZaBfCoaONO/MtoeQiqygpyYp54lw
         aYjY53yqedFhzWHfmLzBBmJ5gvu8KgjM/Mx5AdWTptcPR5YAkuaqvgve0etywqyrGXZM
         vZCXxr4Q2Ef03Wsni7T1c5zb+EWeW224HGG5J2QNz97ZKohMP9zxmS25cFrs2wzB3SgM
         7ZAedw9D5LTd5NHr5i+GCsYr2lx2MXfw5OBvjBCXDa7ivmSZSlN3xWcc6TWePYzUowwi
         zKony6+Ybhle71NqLa1e1D6Ah5gqXJwXS7/9dCgSyrpvfgW9IlUJsEoQy6IhvMIwje9m
         OKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A/TFlGdOr8L/9hEZD38FqFy5byp9WYzQRTAFhaafmME=;
        b=M0Uz8KfluC8ILR8nOmI3XqE4UxHIzqBpKpuE7lG4KpOL3z1lvS6rZM2EJ28E7m+F7O
         0rwU7+aBck5EmyZ1OuEciC20sCdYBYa9ygY3DWfG02Rxre4KYriVd4xFcc3x4vGE1Z8o
         MRqmmKtokZWaVDQ69luQonUR+t8ck2OnR677vVaAji2cfQvyq9UJIGvt1YW6lX+vc+5Q
         qogS9XNhiPMPWiL96ZJ2oWOKmFtFUPQViMHr1SPnBQHNA3O5C2BuaMMFOjDlQMi4PCj1
         pLjQecS+mWmkNWOuwsB2Ah9tbkP90GPMxbZqiHUekKnpntMrZIMFJDJZh9hw+os62tsn
         F3og==
X-Gm-Message-State: ACrzQf0Z0wrJWOJMhSCEB+EfbOJlzTTWYOURGmTeNJFo2m0Exo+xUYUZ
        N7bSffJx7VSKM6MHvMV0XufPSQ==
X-Google-Smtp-Source: AMsMyM5FC/AQPP1CKTMh2VhADy8QCpWjEQIg0MSguiZyY2Wr7Q2d3IHY4O7KZOsddNjX06Bf8krjJg==
X-Received: by 2002:a17:907:a413:b0:781:3519:e225 with SMTP id sg19-20020a170907a41300b007813519e225mr11352871ejc.483.1663724345798;
        Tue, 20 Sep 2022 18:39:05 -0700 (PDT)
Received: from leoy-yangtze.lan ([104.245.97.25])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709063d2a00b0073c10031dc9sm604087ejf.80.2022.09.20.18.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 18:39:05 -0700 (PDT)
Date:   Wed, 21 Sep 2022 09:39:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH RESEND v2] perf test: Introduce script for data symbol
 testing
Message-ID: <YyprNNY/1dPiaq7v@leoy-yangtze.lan>
References: <20220918032843.27285-1-leo.yan@linaro.org>
 <CAM9d7cjZt2k8_JtsPvWcDrzaXb0K02-OKYD4bNA3oL35vXa5Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjZt2k8_JtsPvWcDrzaXb0K02-OKYD4bNA3oL35vXa5Zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,

On Tue, Sep 20, 2022 at 03:15:42PM -0700, Namhyung Kim wrote:

[...]

> > +check_result() {
> > +       # The memory report format is as below:
> > +       #    99.92%  ...  [.] buf1+0x38  ...
> > +       result=$(perf mem report -i ${PERF_DATA} --stdio 2>&1 | egrep "buf1" | \
> > +               awk '{ for (i = 1; i <= NF; i++) { if ($i ~ /^buf1/) { print $i; break; } } }')
> 
> It'd be simpler to use the 'symbol_daddr' sort key alone.
> 
>   result=$(perf mem report -i ${PERF_DATA} -s symbol_daddr -q 2>&1 | \
>         awk '/buf1/ { print $4 }'

Yeah, it's better with 'symbol_daddr', will try it out.

> > +
> > +       # Testing is failed if has no any sample for "buf1"
> > +       [ -z "$result" ] && return 1
> > +
> > +       while IFS= read -r line; do
> > +               # The "data1" and "data2" fields in structure "buf1" have
> > +               # offset "0x0" and "0x38", returns failure if detect any
> > +               # other offset value.
> > +               if [ "$line" != "buf1+0x0" ] && [ "$line" != "buf1+0x38" ]; then
> > +                       return 1
> > +               fi
> > +       done <<< "$result"
> > +
> > +       return 0
> > +}
> > +
> > +cleanup_files()
> > +{
> > +       echo "Cleaning up files..."
> > +       rm -f ${PERF_DATA}
> > +       rm -f ${TEST_PROGRAM_SOURCE}
> > +       rm -f ${TEST_PROGRAM}
> > +}
> > +
> > +trap cleanup_files exit term int
> > +
> > +# compile test program
> > +cat << EOF > $TEST_PROGRAM_SOURCE
> 
> You could directly call the compiler with a pipe.

Yeah, will refine.

> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> 
> The headers are not used?

Will remove.

> > +
> > +typedef struct _buf {
> > +       char data1;
> > +       char reserved[55];
> > +       char data2;
> > +} buf __attribute__((aligned(64)));
> > +
> > +static buf buf1;
> > +
> > +int main() {
> 
> s/()/(void)/
> 
> > +       int i;
> 
> unused.

Will update for above comments.

Thanks a lot for suggestions.

Leo
