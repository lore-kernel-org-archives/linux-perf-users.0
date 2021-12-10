Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A76C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Dec 2021 15:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhLJP4Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:56:24 -0500
Received: from foss.arm.com ([217.140.110.172]:43676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhLJP4X (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Dec 2021 10:56:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88766106F
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Dec 2021 07:52:48 -0800 (PST)
Received: from [10.57.3.227] (unknown [10.57.3.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4714C3F73B
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Dec 2021 07:52:48 -0800 (PST)
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
From:   Al Grant <al.grant@foss.arm.com>
Subject: PMU event repository for Arm
Message-ID: <486e7e8d-de21-5e26-3792-db2fd6991602@foss.arm.com>
Date:   Fri, 10 Dec 2021 15:52:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, other vendors have shown the value of having a machine-readable
collection of PMU events, and we now have this for Arm:

   https://github.com/ARM-software/data

This is equivalent to the tables in about 40 of Arm's public CPU
reference manuals. It includes some details that aren't needed in
tools/perf/pmu-events, but one could be generated from the other.

There's also a map of CPU ids (MIDR) to CPU names, and an example
script to scan /proc/cpuinfo and retrieve the correct JSON file(s).

I won't spam linux-perf-users every time we add something, but we
haven't publicized this before, so here it is. Feedback is welcome.

Al
