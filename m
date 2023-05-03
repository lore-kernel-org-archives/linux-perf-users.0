Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C39AC77B7F
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 May 2023 09:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjECJiH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 May 2023 05:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjECJiE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 May 2023 05:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFB144B2
        for <linux-perf-users@vger.kernel.org>; Wed,  3 May 2023 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683106635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26wC6Uz3skz9Dn8nmQe6TTcveSmK6dcM1Jb9i+Z1uVA=;
        b=KvIP4nB9Ma0zk4batIxCCrR+5GSbO9xAmRiQG52l2GfOGUkaUPMoUcuzQsKOhIFgKl7yY5
        PY9qcmYrvvODM9MnnnNRzh2luT/O8fhtSHE36IbyCCRUTUF5EfvRnE1RkBOrSQ+0Cd78eA
        YGVwnThybJjxvLbc1KmU43U7gL0Su/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-ijt6-Vo-PzeFciUvPkYsug-1; Wed, 03 May 2023 05:36:08 -0400
X-MC-Unique: ijt6-Vo-PzeFciUvPkYsug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34960884340;
        Wed,  3 May 2023 09:36:08 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8252B42AB8;
        Wed,  3 May 2023 09:36:05 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: Re: [PATCH v2] perf: Avoid implicit function declarations in
 lexer/parse interface
References: <87sfcn7uot.fsf@oldenburg.str.redhat.com>
        <CAP-5=fXZv+KCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg@mail.gmail.com>
        <ZEx0IQAtBatrRDCR@kernel.org> <ZEx0xAamEl66qk2w@kernel.org>
Date:   Wed, 03 May 2023 11:36:03 +0200
In-Reply-To: <ZEx0xAamEl66qk2w@kernel.org> (Arnaldo Carvalho de Melo's message
        of "Fri, 28 Apr 2023 22:37:08 -0300")
Message-ID: <874jot69ks.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

* Arnaldo Carvalho de Melo:

>> Thanks, applied. BTW b4 coulnd't find this message (nor the original):

Yes, vger drops the message after accepting it for some reason, probably
something in the patch contents.  I tried to resubmit from a completely
separate account, no luck.

> Not so fast, removed it for now:
>
>   CC      /tmp/build/perf-tools-next/util/parse-events-bison.o
> In file included from util/pmu.y:14:
> /tmp/build/perf-tools-next/util/pmu-flex.h:496:1: error: unknown type nam=
e =E2=80=98YYSTYPE=E2=80=99
>   496 |
>       | ^
> /tmp/build/perf-tools-next/util/pmu-flex.h:498:19: error: unknown type na=
me =E2=80=98YYSTYPE=E2=80=99
>   498 |
>       |                   ^
> /tmp/build/perf-tools-next/util/pmu-flex.h:546:17: error: unknown type na=
me =E2=80=98YYSTYPE=E2=80=99
>   546 | extern int yylex \
>       |                 ^~
> util/pmu-bison.c: In function =E2=80=98perf_pmu_parse=E2=80=99:
> /tmp/build/perf-tools-next/util/pmu-bison.c:69:25: error: implicit declar=
ation of function =E2=80=98perf_pmu_lex=E2=80=99; did you mean =E2=80=98per=
f_pmu_free=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    69 | #define yylex           perf_pmu_lex
>       |                         ^~~~~~~~~~~~
> util/pmu-bison.c:1007:16: note: in expansion of macro =E2=80=98yylex=E2=
=80=99

This appears to be related to some BPF filter stuff that is only in
perf-next, not mainline.

Is this the right tree on which to base the patch?

  <https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/>

Branch perf-tools-next?

Thanks,
Florian

