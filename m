Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58B9C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Nov 2021 15:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbhK3PNu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:13:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38524 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242976AbhK3PL7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Nov 2021 10:11:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 65D86CE1A0D
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Nov 2021 15:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FC7C53FC1;
        Tue, 30 Nov 2021 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638284917;
        bh=2Q80uES3AKG6t4JI2w6xPRmdjpDM9dY8nO1Hmqpz+XM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ps/l2HsgtLguTZvYET97DCmHL5XlGmDaaUTt7e69CgN855FRKoGYZCmrz35VHp346
         CfnfbH2ZhXgr5GoJWVY+e/f59VUjys5qr2TnofK4OyKazjxYL/O+p6y+2+Zn54VrdH
         wLQtfrUSy7o72YWjuo1/qzJtZAgJ85jkjJfni9TU5Jwk6mYpxjs0yaoOBccAtwafne
         gfJSHmFKEZRVj10Tk64wGh5Qw0lQBlP4P5omxFqIvB2lAzh+/0cuWVf4Y7QE+k1FpL
         sRoUdyfPaXXVXznqZH74GXDPZxjQb1SW/rMgZ/gmQg3uxlnjQdUk2Xmegp5mx2gWU5
         Yed51X36p+MIg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D856C40002; Tue, 30 Nov 2021 12:08:34 -0300 (-03)
Date:   Tue, 30 Nov 2021 12:08:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Sandipan Das <sandipan.das@amd.com>, santosh.shukla@amd.com,
        ravi.bangoria@amd.com, ananth.narayan@amd.com,
        kim.phillips@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, kjain@linux.ibm.com
Subject: Re: [PATCH v3 1/2] perf/docs: Add info on AMD raw event encoding
Message-ID: <YaY+cvt8JyixHvz4@kernel.org>
References: <20211123084613.243792-1-sandipan.das@amd.com>
 <YaOweUHKRlMpTOTf@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaOweUHKRlMpTOTf@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Nov 28, 2021 at 05:38:17PM +0100, Jiri Olsa escreveu:
> On Tue, Nov 23, 2021 at 02:16:12PM +0530, Sandipan Das wrote:
> > AMD processors have events with event select codes and unit
> > masks larger than a byte. The core PMU, for example, uses
> > 12-bit event select codes split between bits 0-7 and 32-35
> > of the PERF_CTL MSRs as can be seen from
> > /sys/bus/event_sources/devices/cpu/format/*.
> > 
> > The Processor Programming Reference (PPR) lists the event
> > codes as unified 12-bit hexadecimal values instead and the
> > split between the bits is not apparent to someone who is
> > not aware of the layout of the PERF_CTL MSRs.
> > 
> > 8-bit event select codes continue to work as the layout
> > matches that of the PERF_CTL MSRs i.e. bits 0-7 for event
> > select and 8-15 for unit mask.
> > 
> > This adds more details in the perf man pages about using
> > /sys/bus/event_sources/devices/*/format/* for determining
> > the correct raw event encoding scheme.
> > 
> > E.g. the "op_cache_hit_miss.op_cache_hit" event with code
> > 0x28f and umask 0x03 can be programmed using its symbolic
> > name as:
> > 
> >   $ sudo perf --debug perf-event-open stat -e op_cache_hit_miss.op_cache_hit sleep 1
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             4
> >     size                             128
> >     config                           0x20000038f
> >     sample_type                      IDENTIFIER
> >     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >     disabled                         1
> >     inherit                          1
> >     enable_on_exec                   1
> >     exclude_guest                    1
> >   ------------------------------------------------------------
> >   [...]
> > 
> > One might use a simple eventsel+umask combination based on
> > what the current man pages say and incorrectly program the
> > event as:
> > 
> >   $ sudo perf --debug perf-event-open stat -e r0328f sleep 1
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             4
> >     size                             128
> >     config                           0x328f
> >     sample_type                      IDENTIFIER
> >     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >     disabled                         1
> >     inherit                          1
> >     enable_on_exec                   1
> >     exclude_guest                    1
> >   ------------------------------------------------------------
> >   [...]
> > 
> > When it should have been based on the format from sysfs:
> > 
> >   $ cat /sys/bus/event_source/devices/cpu/format/event
> >   config:0-7,32-35
> > 
> >   $ sudo perf --debug perf-event-open stat -e r20000038f sleep 1
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             4
> >     size                             128
> >     config                           0x20000038f
> >     sample_type                      IDENTIFIER
> >     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >     disabled                         1
> >     inherit                          1
> >     enable_on_exec                   1
> >     exclude_guest                    1
> >   ------------------------------------------------------------
> >   [...]
> > 
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > ---
> > v1: https://lore.kernel.org/linux-perf-users/20211119111234.170726-1-sandipan.das@amd.com/
> > v2: https://lore.kernel.org/linux-perf-users/20211123065104.236717-1-sandipan.das@amd.com/
> > 
> > v3:
> > - Mention why simple eventsel+umask combinations will not
> >   work in the commit message.
> 
> for both patches:
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

