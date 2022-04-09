Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F036C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  9 Apr 2022 15:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiDIPJ2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 9 Apr 2022 11:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242363AbiDIPJ1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 9 Apr 2022 11:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05ED56776;
        Sat,  9 Apr 2022 08:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67C7060A1E;
        Sat,  9 Apr 2022 15:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFEDC385A4;
        Sat,  9 Apr 2022 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649516838;
        bh=8fIwaEWTTC0t7RDjHYBSSEM+cb3kp73/o0Cj33EjI4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=elrwglyA8caXY/MYupOBnz2N9dJ3nq/caO6DjIW+f+CAK6UhWk29KXyJ/8Uq8QQY+
         gsG2tGPzpvorqVFiHeRYuvQxnKJjA5UdgqHRb15p/Ij4Xdom+3oao0J7o2qAkefV9O
         l/MB/TMv0H8Nnl4Zgw0lho24Nmb8wKEKzWJ1AV9Kpy1ovBE+YcH1oa7EdiEL0RrllA
         PKC7INCdwRnKPdmXuYVfw8vmGlUNfTjwaLbMK1Ztd43VaTyzB/1a0wd1dUnmRUKQQs
         SAPBg8B2AqNHUeS9LiNC5InO+t5GYYIfp13CWdPIeXBksRTbzg0FAS0kzfv68jy8UP
         387m8bZdZWMLw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8E9A40407; Sat,  9 Apr 2022 12:07:15 -0300 (-03)
Date:   Sat, 9 Apr 2022 12:07:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, alexandre.truong@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Don't show unwind error messages when augmenting
 frame pointer stack
Message-ID: <YlGhI1nHOpbb09GU@kernel.org>
References: <20220406145651.1392529-1-james.clark@arm.com>
 <ab0293b6-9e71-a28a-e5c1-e4d9b22b0ae6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0293b6-9e71-a28a-e5c1-e4d9b22b0ae6@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Apr 08, 2022 at 03:12:15PM +0100, John Garry escreveu:
> On 06/04/2022 15:56, James Clark wrote:
> > Commit b9f6fbb3b2c2 ("perf arm64: Inject missing frames when using 'perf
> > record --call-graph=fp'") intended to add a 'best effort' Dwarf unwind
> > that improved the frame pointer stack in most scenarios. It's expected
> > that the unwind will fail sometimes, but this shouldn't be reported as
> > an error. It only works when the return address can be determined from
> > the contents of the link register alone.
> > 
> > Fix the error shown when the unwinder requires extra registers by adding
> > a new flag that suppresses error messages. This flag is not set in the
> > normal --call-graph=dwarf unwind mode so that behavior is not changed.
> > 
> > Reported-by: John Garry <john.garry@huawei.com>
> > Fixes: b9f6fbb3b2c2 ("perf arm64: Inject missing frames when using 'perf record --call-graph=fp'")
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Seems ok:
> Tested-by: John Garry <john.garry@huawei.com>

Thanks, applied.

- Arnaldo

