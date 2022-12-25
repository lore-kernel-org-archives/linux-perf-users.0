Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D32C4332F
	for <linux-perf-users@archiver.kernel.org>; Sun, 25 Dec 2022 11:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLYLwG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 25 Dec 2022 06:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiLYLvs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 25 Dec 2022 06:51:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CC5260D
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Dec 2022 03:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671969106; x=1703505106;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=zbUwL8kVAXk9TIB67s6loBmt1rXHuZDWNi+17Ea3m80=;
  b=eZdJvPS/nceAvVzOPKkEu78xWObEZONDRTSZb3XbsbHV5nqRXMBwFb7W
   RZYEHsvtWGtJ1p5cPyWpyFXnWbqbJj6ZEJmzSkjSAPiAa2nDJpvVMUNzV
   swri0eoAxFFFpAmKVkomDpN8UNYJs2Hjx2KBNhnJdR1oAbtJtyCBBKQHD
   tyDOFXjZPZoUnzuDtUDVaeJqpShN31WxCZJ7JC9VCoK/f/aYWeyG/WHct
   p9i+wU93Lh7ODtAlRphX/4v++HOkrOgHX+eJDAtErwpXeHh4zu/HTNm56
   LxZr0MCB7JSBpl6qIyCwncNQg5jUAyCXqNdZjLum31+YHYmnJhxAY5Yty
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="382762087"
X-IronPort-AV: E=Sophos;i="5.96,273,1665471600"; 
   d="scan'208";a="382762087"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 03:51:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="630200237"
X-IronPort-AV: E=Sophos;i="5.96,273,1665471600"; 
   d="scan'208";a="630200237"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by orsmga006.jf.intel.com with ESMTP; 25 Dec 2022 03:51:45 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B1173301B7E; Sun, 25 Dec 2022 03:51:45 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        debian-kernel@lists.debian.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        waldi@debian.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Getting the latest and greatest Linux perf features on every
 Debian kernel
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
        <YY58idSor+lJ84KF@kernel.org>
        <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
        <f59da80e6b4d053246fec4ef263ae4ca7aa1277f.camel@decadent.org.uk>
        <Ydx+mtl1c7L/bbGJ@kernel.org>
        <CAP-5=fUzHV765DqcTZpqCKC1Ve1H91tUfoxQE7Z2KcK5yq021A@mail.gmail.com>
Date:   Sun, 25 Dec 2022 03:51:45 -0800
In-Reply-To: <CAP-5=fUzHV765DqcTZpqCKC1Ve1H91tUfoxQE7Z2KcK5yq021A@mail.gmail.com>
        (Ian Rogers's message of "Thu, 22 Dec 2022 17:43:56 -0800")
Message-ID: <874jtjem5q.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Ian Rogers <irogers@google.com> writes:

> So I wanted to say a BIG thanks to Ben as I see in the 5.16 changelog
> that the perf wrapper script for Debian is now gone!
> https://metadata.ftp-master.debian.org/changelogs//main/l/linux/linux_6.1~rc8-1~exp1_changelog

Halleluja! This wrapper literally is the singlest biggest usability problem with
perf with real users. Hopefully that change gets picked up everywhere as
soon possible.

-Andi
