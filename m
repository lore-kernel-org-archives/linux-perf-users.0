Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCAC433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D7B610D2
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 14:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhJZO1p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234586AbhJZO1p (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 10:27:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F34A5603E8;
        Tue, 26 Oct 2021 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635258321;
        bh=wq4cHSA8xWjckRoJ1siSNw9emhTOZLSpWLEur+8gdMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkwChz6Fw1H2SvX8FY1gHx5MTaA7Xv+0ONt7wweq+/8wT6S9Ojk5GvCvYLqdoXTo6
         9xkS0p71cE7TlrDx97yveQVyq3FiZNiD+d/H2XC2/hTG0XZ6hYsA8xAqeT6z+jEl4N
         9zVWxAJPFMF04r8x3z4vvhTEhWsSnKg9EdN3n7ucfnuM5UdsPfj2/89sSQkoIgYjcX
         iZn5i7uAb+NtKXHiH+qVpI7AkH+obakQyI8tyu151i21Of0WgozNyYWn0cKBshB8MF
         s9NiipjPvd63uas0AgItXF3y/ZHg2cfc1uzAm/n8xhq2I+d9DV6vY8uq6/yV4d/X4s
         0rRh4j3Lj9EqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66118410A1; Tue, 26 Oct 2021 11:25:18 -0300 (-03)
Date:   Tue, 26 Oct 2021 11:25:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     John Keeping <john@metanate.com>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] tools/build: drop slang include path in test-all
Message-ID: <YXgPzslee7oDIMPD@kernel.org>
References: <20211025172314.3766032-1-john@metanate.com>
 <9acd33bf-a11b-2c2e-569f-0de4c971404f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9acd33bf-a11b-2c2e-569f-0de4c971404f@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Oct 25, 2021 at 10:45:17AM -0700, Florian Fainelli escreveu:
> On 10/25/21 10:23 AM, John Keeping wrote:
> > Commit cbefd24f0aee3 ("tools build: Add test to check if slang.h is in
> > /usr/include/slang/") added a proper test to check whether slang.h is in
> > a subdirectory, and commit 1955c8cf5e26b ("perf tools: Don't hardcode
> > host include path for libslang") removed the include path for
> > test-libslang.bin but missed test-all.bin.  Apply the same change to
> > test-all.bin.
> > 
> > Fixes: 1955c8cf5e26 ("perf tools: Don't hardcode host include path for libslang")
> > Signed-off-by: John Keeping <john@metanate.com>
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks, applied.

- Arnaldo

