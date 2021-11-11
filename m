Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CDDC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 18:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F08B61502
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 18:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhKKSaj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 13:30:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233923AbhKKSaj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 13:30:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66D2760FC2;
        Thu, 11 Nov 2021 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636655269;
        bh=VW9JEaDWG7lXT/3YcWIqMRxGkLSUlVUC8SJ2TK4yg30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GnOwzs68n4h4CEP4N0jCfPFz7Pq9nVNsROjr5zRXvYH1GoMT7dVUXXbBUm08I5XYU
         19AAShFGLQMqAY2QTafB9/TgQhY8RyMqQf/C7vjg3v+o+vqQzPNLGhwe3h2JRvluzy
         9FoSknuAAEsW33cGev+920dLUPbrXUnoM04paiqG+V7Zz1XfT7o6d4yTlec3QNQUdH
         gXiW6PJ+qK3qbFcoYw9tJ8vRvFV+2Xed0K4l/5z2z9wsf/t6jwTpxG2acUrsz7woTN
         sciK1MZZwVpJ2TyhNuzb3F8d8gTB1TG90tais5YZ80DwDkXGxtNk7WO/o+x+W7bLX3
         qYNYf+neXV9rQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0287410A1; Thu, 11 Nov 2021 15:27:46 -0300 (-03)
Date:   Thu, 11 Nov 2021 15:27:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     German Gomez <german.gomez@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] perf arm-spe: Support hardware-based PID tracing
Message-ID: <YY1gop7wkdECurb7@kernel.org>
References: <20211111133625.193568-1-german.gomez@arm.com>
 <20211111133625.193568-5-german.gomez@arm.com>
 <CAM9d7chUkk-e0-giLH_moiEri2N28+G1cE-F3+JsXHK89vDJWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chUkk-e0-giLH_moiEri2N28+G1cE-F3+JsXHK89vDJWg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Nov 11, 2021 at 09:23:22AM -0800, Namhyung Kim escreveu:
> On Thu, Nov 11, 2021 at 5:36 AM German Gomez <german.gomez@arm.com> wrote:
> >
> > If Arm SPE traces contain CONTEXT packets with TID info, use these
> > values for tracking tid of samples. Otherwise fall back to using context
> > switch events and display a message warning the user of possible timing
> > inaccuracies [1].
> >
> > [1] https://lore.kernel.org/lkml/f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com/
> >
> > Signed-off-by: German Gomez <german.gomez@arm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

