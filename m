Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723D0C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 17:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C40860F92
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 17:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhJYRrn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbhJYRrm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 13:47:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C1C061767;
        Mon, 25 Oct 2021 10:45:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r2so11647040pgl.10;
        Mon, 25 Oct 2021 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hQuOb33lvCgB0Mk7LRNu5ggVy0l0tYq9eTUqKY/rWgk=;
        b=IpXzDwYYujGdrMjTHxSzlvL+uXoxmUO4GJmMzqRfoTQWkNUTiNpyDQJZEHGWdfHQ5L
         raIpJntj2TMCj43d9KQgOomWKZLyx5JnKr4GB56orihqsXB2disApfT0+MyJCFDKmVWW
         Wud9+BFglfdAJK8gEiy+JyzPw6KBcRPnHK+EC2HqCUEM6DkQHXHNXZ0QfNFuD1TfJ7ao
         O4DZ2mmWhBtlIBm4YcckLjo+Mlx97GcWobZHglIoy+XzUukL0VVpV+X+LQAj5+CmEUm0
         fe6vpf1F/Hlj+lVdQFx6SvPjSTucW7WypxjuiOJQgH19SUlmqS22Venj+LIY7Wwa8aKh
         aw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQuOb33lvCgB0Mk7LRNu5ggVy0l0tYq9eTUqKY/rWgk=;
        b=n0DKh2X00paY3Wm4Z10PfFY7bQxFyF5fAat0jyjUBOFuxjnf5GRnx2+h6Bv62IhgEA
         wgkq1gJUCVd+UzLD8OXcYIe8cpxjJawOF85wFLUUo841qQAqvBgroWEGhRMdu7ZoyozR
         w4x7Fac2OHYK/gVzn4aK0alhyIYdOfEMXeAJ22yOQYKKzkgN9jkXLewkrn4/a6+G7yAP
         18Im2EdoXQWUBMgaK0Pbu7WMeBC4NnVlSORlXPfpnZ3T79ltCkbMbiQfvprJCVqs9XSc
         Az4kEZBzKcPHu8NfbhmdtKen5wTPzwh2gX4AGuKBdZA8dk8ukTXMS9xCRuKiN+nElzC6
         YTXQ==
X-Gm-Message-State: AOAM531VDolEbxSC2GwrTqrK4ujkNApPKvEz22l93sAq0NlGXI8B6d3b
        TmJrcE55RYIGS+9MUlDloJCgAwBDa/Q=
X-Google-Smtp-Source: ABdhPJwiSeoxDpb+VsiHvVieWFXiy6CeGAdXK4XV9J+dZA8Cx/4g6DNojXxi1De2XZI7N9HfMSsmuQ==
X-Received: by 2002:a63:d2:: with SMTP id 201mr14812533pga.400.1635183919568;
        Mon, 25 Oct 2021 10:45:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g10sm6174536pfc.3.2021.10.25.10.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 10:45:19 -0700 (PDT)
Subject: Re: [PATCH RESEND] tools/build: drop slang include path in test-all
To:     John Keeping <john@metanate.com>, linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org
References: <20211025172314.3766032-1-john@metanate.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9acd33bf-a11b-2c2e-569f-0de4c971404f@gmail.com>
Date:   Mon, 25 Oct 2021 10:45:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025172314.3766032-1-john@metanate.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/25/21 10:23 AM, John Keeping wrote:
> Commit cbefd24f0aee3 ("tools build: Add test to check if slang.h is in
> /usr/include/slang/") added a proper test to check whether slang.h is in
> a subdirectory, and commit 1955c8cf5e26b ("perf tools: Don't hardcode
> host include path for libslang") removed the include path for
> test-libslang.bin but missed test-all.bin.  Apply the same change to
> test-all.bin.
> 
> Fixes: 1955c8cf5e26 ("perf tools: Don't hardcode host include path for libslang")
> Signed-off-by: John Keeping <john@metanate.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
