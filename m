Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E192FECAAD2
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Aug 2022 12:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiH2Moy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiH2Moh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Aug 2022 08:44:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3BD8E
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 05:29:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 2so9906936edx.2
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 05:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=7bFrOs7b3eRCKV7uydQzE9SKCZcWgJjVIWdUndoWKeY=;
        b=Zvg/qy+vZKWraRdixlrNbeUPqGQb2Furr+3yf0LM/zkZfnwm9iF2dmYyfRajlYjHd7
         ftQKSqK8hyOfvuPteq+TXUkr5WvGEpeJ8nOYWHKUppwYeVHdoaCO3ziqiGzRqnm7Xiqy
         boA4Hwqim7wEXCR/SkANTFUVW1QHUlc3lcmt81veegB2PtI+t9AiqH2nqNUHFYn7ffWi
         zJNHZzQu5CrAGgNsJargHfQPQ3DWEJLtCk0ofL77Od9VXZaZ9qYBIGUADMb3qpL152QC
         VMJXb0Lid/3pARPFqEhcNv3oxTMIR7MdsK/wUFyg91Gc5HUAvSKUQSVhUfUKarxYi+aN
         gOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7bFrOs7b3eRCKV7uydQzE9SKCZcWgJjVIWdUndoWKeY=;
        b=L57Tw2ED9ptvYBAzjNgj8NqXB+dyi97JmT5MqqHk9Mvi2AfWPbKfViHlX65x0xOfVD
         oZ2216WuSwaZnKjoG6e5W1ksjR0xeLNdaejsg23Z5Nk/XRr8OWosU+62AOnL8ZjsWzYa
         7h0FQJ+pAogRuEdL0f1aybSLBjcpnCXvXIZuUam+4fcqlM16I7xOvRiiysli9A3K1C08
         KBpnwuRWVqoW4dZZgkEdLZO9YNce0vgZ5YOr5ztyfq0VCda7pnX3tKigmKpxjfJjr8IC
         NsLXLiyW9V8bYgjTmAXGQ41AU5qpJ8STmHXDWnPIZ6n2HvqnJCk0K4gCAEINDcMgs4VX
         +fvw==
X-Gm-Message-State: ACgBeo2wBybh7xezIy+s90Z/+bQBJARj8r9JOIS0/Z6ZftWNRSoHARHJ
        tKM4bjIuRY5BQNUbiV8x0QpDS3RjSkg=
X-Google-Smtp-Source: AA6agR5+l27Sh/JxaBv148fxr0DD+72+vaCwpFsyGJiL6Hj5nJRnGk8dTxt6Fja3fWqXIInRiOgoBw==
X-Received: by 2002:a05:6402:337:b0:447:c616:2aed with SMTP id q23-20020a056402033700b00447c6162aedmr14441446edw.127.1661776187261;
        Mon, 29 Aug 2022 05:29:47 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id gh4-20020a170906e08400b00734bfab4d64sm4456437ejb.25.2022.08.29.05.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:29:46 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 29 Aug 2022 14:29:45 +0200
To:     Hongtao Yu <Hongtao.Yu@outlook.com>
Cc:     olsajiri@gmail.com, linux-perf-users@vger.kernel.org
Subject: Re: Cannot print 'uregs' field with perf script -F uregs
Message-ID: <YwyxOVALB0mUf/t9@krava>
References: <DM4PR18MB5026C7008C77EF24557409138A6B9@DM4PR18MB5026.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR18MB5026C7008C77EF24557409138A6B9@DM4PR18MB5026.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 15, 2022 at 10:34:44PM -0700, Hongtao Yu wrote:
> You fix works, thanks! Are you going to commit it?

sorry for delay.. I was checking in more detail and we actually
can do it even without the fix with 'hw:' prefix like:

  # perf script -F hw:uregs

dummy event is special, but I'll need to check if we want
to hardcode that first

jirka
