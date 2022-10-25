Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9AAC04A95
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Oct 2022 11:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiJYLZx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Oct 2022 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiJYLZb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Oct 2022 07:25:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0986D15B302
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Oct 2022 04:25:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pb15so10560930pjb.5
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Oct 2022 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LdRMTI4zyOld++9qNZFyci0X/oHYWTr7T2AnMFOeaA=;
        b=MzpqAJNC7tdBtUPVyiYQR8VsXjr9wKoggMijFHf4ZoBu9uj1C7xwtfrLqdwUqi5rLJ
         b/qv5WITMz2UfmiTsQ6SV3WHl8tnnf3mFlDGrkpMQaH1ZDZTEM4BqXEFYf/uJRiV/SUw
         LPJfnwRDIwUTOk1I8mR+GAPPVYw0hUvif1EE9UpZWjUlAE+ixiFyOaH1o88yKVzeabas
         nkLfPVcY/V3cqBN9gyXdaaRhORzmmHA0X0MzSNkAh98VNMYt5Aa6P50HD9BYOK5WKHJ5
         vF7klx8cFcVTzZklRxvked14hgcgIfNMIjcKCj+hTHN3vCWAia5uZIRj+ltrb/J4zS2k
         vZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LdRMTI4zyOld++9qNZFyci0X/oHYWTr7T2AnMFOeaA=;
        b=qJXDM6lBgJO1R3eJgeaLaf7UfCKRTBTuc8tYaoBTSn2OdbZ8P4tSx6F3ucr5dsONKY
         H4fS02l0MZVpfY8v1Ep/JnMy/g08jisykjG3VjM2KxGF0GApavzxbNWcwpOxdlEPAGS/
         uhEWkz+7p0OOpF4wQpYvftHs3+BTktA5xQnZvWi+rK9X3heTdQ8VIb6GcNivcO72NqfR
         Cycrp3sV2Rgb9OhmrcVOabl12hRGmoBnR2vvF1d+3g/07/ULoTPHTdKzjdZcwOf+I/ln
         asEdG8iE9g8PCgSOzLtCiq79CcV0pY0yg+dJEsL55cmS+bmGb2uhGlFeBJOC9UMlaknm
         fqVA==
X-Gm-Message-State: ACrzQf2SXHSETB5x5pQaAkneEVlfpcj46q/vvzyo2DXlb76+KarwuYOp
        hw3OW5oOCjEXjhvSlhPkHEf6Ag==
X-Google-Smtp-Source: AMsMyM5XQpmnIQ1KeJdniJme/sn/fhdr1NXq7i0leDU5y+9gKGrNDjlwBDOGqT3Atj6Nz585DKiYgw==
X-Received: by 2002:a17:902:e545:b0:182:6c84:7fc0 with SMTP id n5-20020a170902e54500b001826c847fc0mr38047150plf.144.1666697127301;
        Tue, 25 Oct 2022 04:25:27 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.103.41])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001785fa792f4sm1056792plb.243.2022.10.25.04.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 04:25:26 -0700 (PDT)
Date:   Tue, 25 Oct 2022 19:25:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Ian Rogers' <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 0/8] Update to C11, fix signal undefined behavior
Message-ID: <Y1fHn1mFeVPn7O3+@leoy-huanghe.lan>
References: <20221024173523.602064-1-irogers@google.com>
 <Y1bQlxxABicj4k3+@kernel.org>
 <CAP-5=fWPdmHPXc9D2LP6TVmhuNf93gZCnogWXCVGytkhuqi2uQ@mail.gmail.com>
 <CAP-5=fVGicObnifnUzDXjbkGOVtmNaLKcfqpGeTwnFw2zsOuDQ@mail.gmail.com>
 <7b0769b35f124869b4e30ddcc20a5985@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b0769b35f124869b4e30ddcc20a5985@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Oct 25, 2022 at 10:36:16AM +0000, David Laight wrote:

[...]

> > So I noticed a few changes missing #include-ing stdatomic.h and
> > sig_atomic_t is actually in signal.h. I'm not sure we need the C11
> > change then, but it seems like the right thing to do anyway. I'll do a
> > v2 to drop the unneeded (currently) include of stdatomic.h.
> 
> While the C standard requires you use sig_atomic_t (to avoid
> wider RMW being done for writes) the kernel very much requires
> that volatiles accesses are atomic.
> So the compilers used will do that even when the C standard
> would allow them to do otherwise.
> 
> Pretty much the last mainstream cpu that couldn't do atomic
> byte writes was an old alpha.

One case that it might break atomicity for the data with int type,
I.e. on Arm CPU when CPU access data without alignment, then it
cannot promise atomicity.  I am not sure if the data with int type
will be always compiled with 4-byte alignment, if it's packed
without alignment then sig_atomic_t is still required.

Clarify that I don't have deep understanding for compiler, so sorry
if I introduce any noise.

Thanks,
Leo

> So for anything that Linux is going to run on these changes
> aren't really needed.

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
