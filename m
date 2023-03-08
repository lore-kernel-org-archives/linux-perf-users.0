Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F79AC678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 08:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCHIuR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCHIuC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 03:50:02 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8079CFF8
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 00:50:01 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 32-20020a9d0323000000b0069426a71d79so8581956otv.10
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 00:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678265401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXXn/9+lWwIo7i5vPpgF03z6CM+OJXb8oIZ08kR1L6o=;
        b=i1X0Fqktymbb6cej3g+/U1NtepQNoDbdsiB+VlIrVvaJZNrm8iIanOCVMYYAWHQkWi
         pNuVIRMB6bfTzHIJh8DfvExmzhAlbGk0X1ZcXiYMLZUFCS7Ty9y335HySX1sy5rCT7BW
         LnfUZ5TAqoK4pciV/iHa4MJeMzwzQ+LBJcmAs5xTghR44h/ojtR1OR0QOpQ0Lo6lxc27
         0IsqupGNpqfzc315rZv33gm7WhidVT9jJH5yS6EoAmXWOKc4YCm1vLLJYe9COOJE2AyO
         WDE4Pn8/lim78Jck1+77K6izCOqoXUF/2SIAygYpgesiazrm7J0VzI5R2CgeQgdYE1vv
         hpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXXn/9+lWwIo7i5vPpgF03z6CM+OJXb8oIZ08kR1L6o=;
        b=RJpS/l7vMYdMPkr54PQaJAljOUW1eGzrZuwwvOAyqMluLRAEEaDtEsJiRWRJozzBft
         cyrecHDg8WS2X3hSmc9a+ElfYhMJvIl44CZaGbKS1g8LZc65QbnD7PbxTx2eFJ9J5zZ8
         fN366Jcwb4MQ8PgArJx0Icl5Z3KvdjuVNX0N0BMGM4Yh6TlWTxMFWphdqkFAVL1Y2ggG
         7dd4dXcwK6oQOuHvUXE0UjhsCOJS2b1EuYrT0FjVSIg8isIzSZtyLEtFSDiFEC8BVMY2
         FB5OVoYTsM3A9RnVSRIbcKHUJbGncIzDvgIwW/9IIJv54pzx3yKkybEivvdOljtIHGi7
         aKxA==
X-Gm-Message-State: AO0yUKWfh94k4iWjX39+8iUFWRu6TkAv86xNloPnOQyD/yUTeqfFY3UU
        GTGdEvJ/dv73APZmCRAmhmGgPB7FKcFTf3WQaUDtvocJ
X-Google-Smtp-Source: AK7set+tV4tTfW8xrnaRIDXeUfCEnDxoAj+P/yej/Ib3M8Le+z3mV71X51WdcxLyPUq2bUKeykXRFKZi2MrogZ56Swk=
X-Received: by 2002:a05:6830:3378:b0:68d:48f0:9bad with SMTP id
 l56-20020a056830337800b0068d48f09badmr5754262ott.7.1678265401003; Wed, 08 Mar
 2023 00:50:01 -0800 (PST)
MIME-Version: 1.0
References: <CAO3P5YQ-BU+fmhQo98SAKdc96qMEsim4nNvMRiBmsW0YSUYjQg@mail.gmail.com>
 <a1b7c912-1554-a623-6799-32dbd0ead4de@intel.com>
In-Reply-To: <a1b7c912-1554-a623-6799-32dbd0ead4de@intel.com>
From:   Iti Shree <itishree1999@gmail.com>
Date:   Wed, 8 Mar 2023 08:49:24 +0000
Message-ID: <CAO3P5YTf+by5ppR2K44Bw+1h0B2JAZH__oJThS6hepAe5v6LMg@mail.gmail.com>
Subject: Re: brstack information with perf-intel-pt?
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Adrian,

Thank you for the reply and the link to itrace page.

On Mon, Mar 6, 2023 at 6:54=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 13/02/23 20:33, Iti Shree wrote:
> > Hello,
> > I am trying to get brstack information in perf.data with intel-pt
> > flag. I am passing following command for the following: perf record -e
> > intel-pt// -m, 32768
> >
> > When I try to check if brstack is present in the gathered data with :
> > perf script -F pid, ip, brstack -i pt-perf.data I can only see pid and
> > ip information.
> >
> > I can seem to find branching information with --itrace=3Db however I wa=
s
> > wondering if there is any way I can get brstack information decoded
> > into perf.data when I use intel-pt flag similar to what I get with
> > default perf record?
>
> You need to use --itrace=3Dli which will synthesize "instructions" events
> and add a branch stack.  Note that the period of the instructions events
> can be defined e.g. --itrace=3Dli10us for 10 microseconds.  And also the
> max size of the branch stack e.g. --itrace=3Dl10i for 10 branches.
>

I am wondering if I can get a branch stack on "branches" events Either
by some --itrace options (I tried --itrace=3DLcr/lcr) or by modifying
perf's codebase a bit?

> Typically you need to be aware of decoding errors also, so also add
> the 'e' option i.e. --itrace=3Del10i10us.  There is also 'L' which adds
> the branch stack to non-synthesized events (that you may have added
> with the -e option).

> Some more information about --itrace for Intel PT is here:
>
> https://perf.wiki.kernel.org/index.php/Latest_Manual_Page_of_perf-intel-p=
t.1#New_--itrace_option
>
> General information and examples for about Intel PT can be found here:
>
> https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE=
_Processor_Trace
>
>

Another question, not related. I am working quite a bit with perf and
Intel PT right now, is there any sort of active IRC channel/slack or
discord for more interactive discussions? If not, would it be okay to
cc you (or where can I find the right people to reach out?).

Thank you again. Good day!

Iti
