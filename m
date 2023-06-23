Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1212EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjFWSgM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjFWSf5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 14:35:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0830D2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687545332; x=1719081332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jK7PG349QeATavwoDayij62cAR9WTDsYnMjDePmf+No=;
  b=KH4PAueMyc46UT9pkGG7oB42ZA/0LLBR5CdZhkuD9dYJMYxpd79Nts8c
   fbh9T93gXOaTyU9AehzQGciChe5C4pZ8plhdo7wPQeuA6Nsl7JIDJoHvd
   0HgkzYvM3Sl8zEfK9Q4xtWfJBtK9ZT+MilNbprY65OnMsKcJSryc7AIcR
   hHwcNyRp0Ngc7ingmVtz9L6wcm5FjQ3mhkfoQx5jcfX88nQ6cTAyVLoVm
   K9xEd2H2Uaxjh4RNKYAOYkJLvzU+Y5hP7To4rQ7ZCAsUbYkTWEqR42KVa
   LjszjjA26YrRavfimKeHYi9pK+QYDTFAP+svEKldsjlsUHI5pe2n2iDrV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="390865408"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="390865408"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 11:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="805290569"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="805290569"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 11:35:20 -0700
Date:   Fri, 23 Jun 2023 11:35:18 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: Perf stat regression from d15480a3d67
Message-ID: <ZJXl5vdhxPnVBRze@tassilo>
References: <ZJOmXU/41HMzanM9@tassilo>
 <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo>
 <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
 <ZJSr2PbOrpFrSIaL@tassilo>
 <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> Can you please help me to find a minimal repro?

Here's a smaller test case (works on SKX):

perf stat -a -e uncore_imc/event=0x4,umask=0x3/,uncore_imc/event=0x4,umask=0xc/,cycles <something the doesn't idle for 1s>


-Andi
