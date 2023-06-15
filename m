Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169B1EB64D9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jun 2023 11:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbjFOLTj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jun 2023 07:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjFOLTi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jun 2023 07:19:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C90E2707;
        Thu, 15 Jun 2023 04:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A60EE634F3;
        Thu, 15 Jun 2023 11:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01ADC433C0;
        Thu, 15 Jun 2023 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686827976;
        bh=o6Td6MmrlfeRqs6XMwz0lA70wOPxQKNfW8M0/DTvPlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jonMy9tBrVQSohpRudZA6CWZgFxkYGzBHD2lKG2dU2b8+XbKOWCus3mg+CSJlyG8o
         Bf89KaPF+/WfnZSU18Qhd8Y/fW/oACqdBBthFSlwd4dOvBlNmPPBGGBj10Cbvvn3lV
         3rUfwD15v4qKcQg9riEDNSTtonYoIjAiNe61Xk1b1BNMYfi1CznkRfbZ3OTySk383Y
         gd+/VAeEk/hYPu1RcOK/gXviXhHG39e8wwGPkUPFgeQBO6IYF4dugjP4ikXEkW24B4
         OdBO6ysOnlNbxmPchHiRKjFqVRkY+QcpD04MUWm8Vrxd1S6Xet9ZteH7zEpvg/y/rF
         +Ask1nAh0qX4A==
Date:   Thu, 15 Jun 2023 12:19:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-perf-users@vger.kernel.org, Aishwarya.TCV@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf tools: Add a place to put kernel config
 fragments for test runs
Message-ID: <fb130fd5-7134-444b-a79c-658bff30c588@sirena.org.uk>
References: <20230614140219.2335639-1-james.clark@arm.com>
 <ZInLBt9q2F99gTg8@kernel.org>
 <d02cce4a-47b1-a776-0d3a-a6a7c9a4d8fd@arm.com>
 <20230615012546.GN217089@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tme7hkpHpIGMJ5ts"
Content-Disposition: inline
In-Reply-To: <20230615012546.GN217089@leoy-huanghe.lan>
X-Cookie: You are false data.
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--Tme7hkpHpIGMJ5ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 15, 2023 at 09:26:39AM +0800, Leo Yan wrote:
> On Wed, Jun 14, 2023 at 03:19:12PM +0100, James Clark wrote:

> > >> The RFC is for discussion on folder placement and file naming etc.

> I am wandering if we can put these configurations into kselftest (the
> folder tools/testing/selftests/).  You could see now kernel build has
> already provided option to merge kernel configurations for kselftests.

Well, it'd be nice if the whole thing was a kselftest rather than it's
own thing, that'd avoid the need for custom setup to run the tests.  But
while it's not a kselftest it's not clear to me that it's a good fit.

--Tme7hkpHpIGMJ5ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSK88EACgkQJNaLcl1U
h9BMVAf9FfveJwPe7nual8Q9ggs+55RseluL2cG95FfPxnobW0Wu7SDMBxYmS8+u
uWlUeKLJD2NbnkFPaNnVcz4W0jEY48sz1sbvYZ+KunLaKx3dDb9/BZ4PRV5OYXwh
a9ddcjuXWTVz48/4ji0dn00j13FBOLBr6Ybq2Ug0zeyzeUrQrbdAKFps1G48ch6A
2brRoReSg+y91hoFN9esY2qxQwYjLHdsYgwJGizXSY9AvWVs0jBcE/KsmZty1adE
/rzOrmkhuLiPNWluoauqpwbWJrmeGvXpBQAVGW6c81I45fpTZb4W418INZ0O6mNb
lMMgQN0pzTft3zLvhTTYlgjCL25+4A==
=2t6d
-----END PGP SIGNATURE-----

--Tme7hkpHpIGMJ5ts--
