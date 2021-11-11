Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AE1C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAE061264
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhKKR47 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhKKR47 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 12:56:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75A8661354;
        Thu, 11 Nov 2021 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636653249;
        bh=VGdrCbIT+aEVXGIz48W9CinquTZXlgiRl/gO9zbM9iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCjPGJsbkRfPSkXGPZc3FvP1NVlG6b9On0bH3PhEIaqU0lGJtwBE0IC5vPJXvy6bH
         EoV3HMzsa1GdPn+x/2gbqLdZFzU0h76yzkqO4ZqszbepWa+n31iVjPyFWbFkXMS3fI
         griUA1us8LEXe2BhKB5W0of9mHlwchzelvLE1XajdRpRd1zGF5i1RH9prEfUoOisId
         eV4++HxjL8zM0PCksPwrN2kgsqf16Xn/sgMixCP+7Wu4JADbgoMKsBjUmr/KNpFip1
         kJbGmyR6r/DskdvikqGmdklYf3Q9o6aXnRb7mX5mVV2cvTaYxu3EtoLYDBXRob1OkF
         M4iLqafJgUKAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAB8F410A1; Thu, 11 Nov 2021 14:54:06 -0300 (-03)
Date:   Thu, 11 Nov 2021 14:54:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] perf vendor events power10: Add metric events json
 file for power10 platform
Message-ID: <YY1Yvt1ElJjeC48b@kernel.org>
References: <20211108060010.177517-1-kjain@linux.ibm.com>
 <20211108144702.GB12060@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108144702.GB12060@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Nov 08, 2021 at 08:47:02AM -0600, Paul A. Clarke escreveu:
> On Mon, Nov 08, 2021 at 11:30:10AM +0530, Kajol Jain wrote:
> > Add pmu metric json file for power10 platform.
> > 
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > ---
> > Changelog
> > v2 -> v3:
> > - Did nit changes in BriefDescription as suggested
> >   by Paul A. Clarke and Michael Ellermen
> 
> LGTM.
> 
> Reviewed-by: Paul A. Clarke <pc@us.ibm.com>

Thanks, applied.

- Arnaldo

