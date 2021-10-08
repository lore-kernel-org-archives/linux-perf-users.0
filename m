Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4641CC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 05:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2732761058
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 05:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhJHGAt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 02:00:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:50961 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhJHGAt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 02:00:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HQcvK1BvHz4xb7;
        Fri,  8 Oct 2021 16:58:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1633672733;
        bh=k79ijaB4BqLWGRtaqOBdgCz9I0VTG7U32BBiPeHoJn8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Krzc57H5WA7NgIj5Zp7UIu3GkPW9T1PBRW/USYC6Eksmv3E5nFvSl5XmAs7KEeHE+
         UtYzEZqv1rua6HIyyjtKDZHcFpVTmaFXxnrojZoxhxzoKqNc1du1sCC8F/9cicai0Z
         M6FFf74e9Q3Jhrdq8AmFdlDLbSaz6TqaobVAK4Ci+izH7H6RJ7QidGcf+wNDu7oRml
         4oxINve8Ffhy1uWipPXezdwx1Koz+64mPVBXmVEQJCSmGlOb+rhHJrFKDwsRqwtiGO
         z/v93fQEiBD3vTCyuZ6ePLPtedp3ztzFZlQBA86lWP0Ya/NgyeKF34+3ayQyj7EwEN
         OpDtRq4cyFhTQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        "Paul A. Clarke" <pc@us.ibm.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf vendor events power10: Add metric events json file
 for power10 platform
In-Reply-To: <20211007184337.GN10333@gate.crashing.org>
References: <20211006073119.276340-1-kjain@linux.ibm.com>
 <20211006173248.GA7389@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <20211007134750.GA243632@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <20211007184337.GN10333@gate.crashing.org>
Date:   Fri, 08 Oct 2021 16:58:52 +1100
Message-ID: <875yu8njkz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Thu, Oct 07, 2021 at 08:47:50AM -0500, Paul A. Clarke wrote:
>> On Wed, Oct 06, 2021 at 12:32:48PM -0500, Paul A. Clarke wrote:
>> > > +    {
>> > > +        "BriefDescription": "Average cycles per instruction when the instruction finishes at dispatch",
>> > 
>> > I'm not sure what that means.
>> 
>> After doing a bit of research, I think it might be a bit more clear as:
>> "Average cycles per instruction when the NTF instruction finishes at dispatch"
>
> Is "next to finish" some defined and/or sensible term in this context?
> Or do you mean NTC here?  Or what :-)

Yeah I am also more familiar with NTC.

But those descriptions originally come from a spreadsheet we're given,
and they do include NTF as an acronym.

eg. search for NTF in here:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/pmu-events/arch/powerpc/power9/metrics.json

From the context it does presumably mean "next to finish".

cheers
