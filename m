Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6D1C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 May 2022 02:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348538AbiEFCo0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 May 2022 22:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiEFCoZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 May 2022 22:44:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DFF2AE3C
        for <linux-perf-users@vger.kernel.org>; Thu,  5 May 2022 19:40:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvZYj580jz4x7Y;
        Fri,  6 May 2022 12:40:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1651804842;
        bh=OZR46u3Sin209gHTa7HOBQ6+AD+YHBHgUHJTbOAwzOw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=llMPp7+KgH5XSjyOxoDfc3h6x932RKETWwtX4KtrWETMUxqZ60KMj6dDzncQn96Bx
         FE4QVONeCzrxC1TVJBqeO487ak5SZdZeyW6FNN9/5+E94W17jlfOz5joqM3xBSet+h
         Bdq1acqm3K8cTKkGp0JWgTi+PVJUXbrs9FN+PS/R6Zb3bcb5MBhSP6DDM3620lHfeZ
         Td76ezE56cWbHELxx06PCd9zhuMwPmA237m3M84L6ZKur5T6FJP4JN63efpl2+UjDr
         kHAGRJJJp+VJfF3mNXwr1muUlUGPwihlGk4KcHGnM5BtiV+6j7qjZky5vhp2m9K7rp
         Dwgb7mwZQyCcA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, disgoel@linux.vnet.ibm.com
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, irogers@google.com
Subject: Re: [PATCH V2 2/2] tools/perf/tests: Fix session topology test to
 skip the test in guest environment
In-Reply-To: <20220505094000.58220-3-atrajeev@linux.vnet.ibm.com>
References: <20220505094000.58220-1-atrajeev@linux.vnet.ibm.com>
 <20220505094000.58220-3-atrajeev@linux.vnet.ibm.com>
Date:   Fri, 06 May 2022 12:40:38 +1000
Message-ID: <87r157tmc9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Athira Rajeev <atrajeev@linux.vnet.ibm.com> writes:
> The session topology test fails in powerpc pSeries platform.
> Test logs:
> <<>>
> Session topology : FAILED!
> <<>>
>
> This testcases tests cpu topology by checking the core_id and
> socket_id stored in perf_env from perf session. The data from
> perf session is compared with the cpu topology information
> from "/sys/devices/system/cpu/cpuX/topology" like core_id,
> physical_package_id. In case of virtual environment, detail
> like physical_package_id is restricted to be exposed. Hence
> physical_package_id is set to -1. The testcase fails on such
> platforms since socket_id can't be fetched from topology info.
>
> Skip the testcase in powerpc for pSeries. Use the utility
> function "cpuinfo_field" to check platform from /proc/cpuinfo.

I don't think that's the right way to fix it.

If we ever had a "pseries" machine that did expose physical_package_id
then this test would continue to skip, even when it could succeed.

So if physical_package_id being -1 is the problem then you should skip
the test based on that.

cheers
