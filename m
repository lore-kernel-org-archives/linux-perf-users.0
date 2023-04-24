Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ADDC77B78
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Apr 2023 17:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjDXRxG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Apr 2023 13:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjDXRxF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Apr 2023 13:53:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845E26A59
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 10:53:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a92369761cso38994715ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1682358783; x=1684950783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MKUvioDFym51E51dk6ySi5zEPkblTDJdgaK3QIKchw=;
        b=pU0zLUiEMqXNhNeDmdJkzerLQjfaVU6ziVMZ5aBW6/8vN8a4a4aaz0CGYe1VWpkXdS
         E3TAxastF2Qi8dfdy3CivEZaZAyEEqPau4V5u7GLpGIWazqDGhMvtqXwcOJk/18GWq9l
         NfYdflAXc2r5Pfs/8SKAQovKxj0V372VR5uqG12EHP3WUXy+vP1g+SEh7+pO/YgPVrGQ
         dPeNBCPwbJ55mq/jXw1ApR+87m2LRk772pjV+8HKvXMpUlsBub3G6yz+igtpk6UZgAfP
         g8+ZGHmlL+iVDIoopHyR1q0mzoLuVMgm6DEf8g3nyX83DG+CllSTCU7ZAFrebqwbyNCa
         gjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682358783; x=1684950783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MKUvioDFym51E51dk6ySi5zEPkblTDJdgaK3QIKchw=;
        b=JKFK0Q6iqaWwUzt4sNKViQn/2bdH7B3nDYdJCoGiNQ1cGCFbKfrrukWXBStIGVLI4g
         BNIPk1aJOrnCQyaabHjZ577mVI/9odpBGi/+qXU7V3WUBUECl0GhOfVk0DK3kYoUDPku
         FsxUiLoAiXX+B2oZzEngkE2wnhhr3R30ycK1jyeslwVW1wB3oyw4jQChzPgU4onMiMGq
         DmyKN1hoWzxXKSCa2rLXR9hTA6idaPDkmXJtoHsGA/HDaDJyTQgvio6HmZw4ZVZ/1OwK
         QjgNKxrDmDZ7drOh1soVhPINXMPUROQa3voZ2MP0sQCh9ROnX4XDVcWPWsCXxoGd77I7
         ioNg==
X-Gm-Message-State: AAQBX9fMhGKGYXpa1+DYbLbU11F2jfaZHwd8T0R9GlyB6NQV/iCGSj0t
        8bEkabnpAPDQ1Ik+DiBit6Pqdw==
X-Google-Smtp-Source: AKy350b8QftlmzAgdTpofeaGKzAiPoEQxlMD0oxWHc4aD9JJLcqXlXiU+XTwREVgYXPzaSKrvzQzlA==
X-Received: by 2002:a17:90b:1c87:b0:24b:2b9a:7fd2 with SMTP id oo7-20020a17090b1c8700b0024b2b9a7fd2mr13857171pjb.9.1682358782987;
        Mon, 24 Apr 2023 10:53:02 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id fs21-20020a17090af29500b002470e095920sm6824171pjb.40.2023.04.24.10.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 10:53:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pr0N2-001Vs1-FA;
        Mon, 24 Apr 2023 14:53:00 -0300
Date:   Mon, 24 Apr 2023 14:53:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/gup: disallow GUP writing to file-backed mappings by
 default
Message-ID: <ZEbB/LGw8UoSKJiX@ziepe.ca>
References: <f86dc089b460c80805e321747b0898fd1efe93d7.1682168199.git.lstoakes@gmail.com>
 <20230424160952.bvii2ahgxss2chev@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424160952.bvii2ahgxss2chev@quack3>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Apr 24, 2023 at 06:09:52PM +0200, Jan Kara wrote:

> So I'm maybe missing a bigger picture why we would like a change like this.
> Because we still need to teach filesystems to handle pinned pages for the
> usecases you don't forbid and for which we know there are users and then
> what's the benefit of this patch?

It immediately closes a security hole we have been talking about
fixing for years already and still don't have a full fix for.

An acknowledgment that this is not going to go away and starting to
clamp down on the insecurity may motivate some investment in the
proper fix. :)

Jason
