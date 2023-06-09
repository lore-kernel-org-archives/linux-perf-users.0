Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DF6C7EE29
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jun 2023 09:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbjFIJMi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jun 2023 05:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241365AbjFIJLy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jun 2023 05:11:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E51D1FFA
        for <linux-perf-users@vger.kernel.org>; Fri,  9 Jun 2023 02:07:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 567A8AB6;
        Fri,  9 Jun 2023 02:07:33 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A225A3F71E;
        Fri,  9 Jun 2023 02:06:47 -0700 (PDT)
Message-ID: <874963e2-f97e-b463-1351-b00640b0f67b@arm.com>
Date:   Fri, 9 Jun 2023 10:06:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Some questions about using the perf tool in ARM-SPE
Content-Language: en-US
To:     =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
        linux-perf-users@vger.kernel.org
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 09/06/2023 08:14, 蔡沅信 wrote:
> hi linux-perf-users
> 
> I glad perf tool can support ARM-SPE.
> however, I have encountered some problems in using
> My perf tool version is 6.1. I compiled it to run on an Android system
> "Here are my questions"
> 
> 1.I can't use the perf c2c function to analyze, i'm not sure if it
> only supports certain hardware architectures
> 
>>> user_shell:/data/local/tmp # ./perf c2c report
>>> Failed setup nodes
> 
> 2.I get more information via the command /.perf report --mem-mode but
> I'm confused about the data
> 
> Snoop  Locked  Blocked     Local INSTR Latency
> ......         ..........  .       ..................
> N/A            No          N/A           0
> N/A            No          N/A           0
> N/A            No          N/A           0
> N/A            No          N/A           0
> .               ,                .
> .
> .
> I have observed a lot of data about Snoop&Locked&Blocked&Local INSTR
> Latency and their results are always N/A&No&N/A&0 which makes me feel
> like it is not supported. Please give me some information about it and
> introduction.
> 
> Many Thanks
> Best Regards
> Zack.

Hi Zack,

I wasn't able to reproduce your issue on Ubuntu, it could be something
to do with Android.

It looks like the error "Failed setup nodes" comes from the
setup_nodes() function. Can you debug it to see exactly which part of it
is failing? I see it's something to do with numa nodes, maybe that
doesn't work on Android or you need to add some numa stuff to the kernel
config. Or the function needs to handle missing data differently.

James
