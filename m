Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFAFC4167B
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Nov 2022 11:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKYLYv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Nov 2022 06:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKYLYh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Nov 2022 06:24:37 -0500
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 03:24:36 PST
Received: from mail.bsc.es (mao.bsc.es [84.88.52.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FC41C422
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Nov 2022 03:24:36 -0800 (PST)
Received: from [84.88.51.51] (bsccs560.int.bsc.es [84.88.51.51])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.bsc.es (Postfix) with ESMTPSA id 034A74061440
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Nov 2022 12:17:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsc.es; s=20191012;
        t=1669375030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sOu/eKY57oazeEHlTSIKUwVLHESBeEXdM82krTGStYw=;
        b=LrdpEEVxY7LMuhnxglg+ZZpg25N+S3vFwtWukNNyfdBd1iXfDS+6pcnpNDvcJd6dwQL0ps
        jxV2xN06vrBAwbsNBiwlaY93hMfyAXJmF6mJhqtopaLKYLOCLWMdJLmyhU0DPTwFaOFqBv
        TLubbjuh9/SCaCQW1tdmVjG65Ty7pTpXIx68O2eTZMNy7c16KAqnIZ7KRCzlsgSO7eja8G
        F7aMFcc8NG7MbM67SRoY+sGuo6rG2R/99P2AcACB4mZ9Dg1EpxcNlPhTYNrV1FARNVqgJ5
        72XhlZiYhQAbDY3elkZ04XYwrFqv2jRowt3c6C63eiXbcUKCX8Eg5ZEIY1kJOg==
Message-ID: <2695ecbe-816e-eab7-8da2-30e0f62ae926@bsc.es>
Date:   Fri, 25 Nov 2022 12:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
From:   Marc Jorda <marc.jorda@bsc.es>
Subject: Available Arm CPUs with SPE
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Copyrighted-Material: Please visit http://www.bsc.es/disclaimer
X-Rspamd-Server: opsmail02.bsc.es
X-Rspamd-Queue-Id: 034A74061440
X-Spamd-Result: default: False [-12.91 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[bsc.es:s=20191012];
         NEURAL_HAM(-0.00)[-1.000];
         WHITELIST_SENDER_DOMAIN(-9.00)[bsc.es];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:13041, ipnet:84.88.0.0/16, country:ES];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.81)[99.37%]
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

I am trying to know which currently available Arm CPUs implement the 
Statistical Profiling Extension (SPE), does anyone know where can I find 
such information?

As far as I know, it is an optional extension in Armv8.2, but I don't 
know if it is mandatory for newer versions. Is it correct to assume that 
all Arm Neoverse CPUs have this extension?

Thank you very much,
Marc

