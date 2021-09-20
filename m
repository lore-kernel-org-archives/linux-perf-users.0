Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D6CC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Sep 2021 10:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20E96101C
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Sep 2021 10:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhITKn7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Sep 2021 06:43:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:55515 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhITKn7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Sep 2021 06:43:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="284116179"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="284116179"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 03:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="511250534"
Received: from um.fi.intel.com (HELO um) ([10.237.72.62])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2021 03:42:28 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     cgel.zte@gmail.com, peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] Add pointer check
In-Reply-To: <20210918030131.236378-1-yang.guang5@zte.com.cn>
References: <20210918030131.236378-1-yang.guang5@zte.com.cn>
Date:   Mon, 20 Sep 2021 13:42:28 +0300
Message-ID: <87mto7il4b.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

cgel.zte@gmail.com writes:

> From: Yang Guang <yang.guang5@zte.com.cn>
>
> The buf->stop_te pointer may be NULL.

[...]

> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -1118,9 +1118,12 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
>  		buf->intr_te = pt_topa_prev_entry(buf, buf->intr_te);
>  	}
>  
> -	buf->stop_te->stop = 1;
> -	buf->stop_te->intr = 1;
> -	buf->intr_te->intr = 1;
> +	if (buf->stop_te) {

It really can't be NULL at this point.

Regards,
--
Alex
