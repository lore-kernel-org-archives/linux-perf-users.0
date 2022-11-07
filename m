Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA3BC4332F
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Nov 2022 15:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiKGPP0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Nov 2022 10:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiKGPPZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Nov 2022 10:15:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D776F192A1;
        Mon,  7 Nov 2022 07:15:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 740FB61165;
        Mon,  7 Nov 2022 15:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7BBC433C1;
        Mon,  7 Nov 2022 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667834123;
        bh=vBP8cGicq41HNOExdovnKwO+xqM81abEks5/21F16m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jy4xpmuxYZmN58pstqH5yDuRmf80mFRDtI+TXJGQ/sZvvz+m2KA/q4L79IQSX+Hqs
         jGuR3nKGrusKDd6ZxVSRrS0HRqg3ifNy8XG+HP95WteBfPX76pE1OXZBv3If1pEz/H
         2qfcmO/oes4bwWi8xs2vKr8FgD+k6Gu9DyuKkGlVWC+6tdVn3IU7sUKuAs2gOYcpij
         zzMM3Vnu/fVTPGo1eZp8OXZ4d7fqLAVth+obzrndmg6zZpWNtnm0iuG4HBUCJhRYz8
         g0vzxY9FnV/66gIrfLOc+jXsG0oM8EJ2x9qqkaR4XQqamLuWkyY5obDFjoY7lOpWos
         vV554nZojsCpA==
Date:   Mon, 7 Nov 2022 15:15:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V5 1/7] arm64/perf: Add BRBE registers and fields
Message-ID: <Y2khBUNLxhSgWhyI@sirena.org.uk>
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MbfPbtMAW7aR1zoM"
Content-Disposition: inline
In-Reply-To: <20221107062514.2851047-2-anshuman.khandual@arm.com>
X-Cookie: Minimum charge for booths.
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--MbfPbtMAW7aR1zoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 07, 2022 at 11:55:08AM +0530, Anshuman Khandual wrote:
> This adds BRBE related register definitions and various other related field
> macros there in. These will be used subsequently in a BRBE driver which is
> being added later on.

Reviewed-by: Mark Brown <broonie@kernel.org>

Like I just said to Rob incremental differences are easier to review
when things are split up into a patch per register but this all looks
fine now so no worries.

--MbfPbtMAW7aR1zoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNpIQQACgkQJNaLcl1U
h9AuYgf/fQLWFRvgiLS5OxBMEG7Mm4HR/bm6OAstqYWhPVSQ7v1h6fM84XEd69nc
E4s5A2f3Wz4oyPfakuFKH9/YP44t2ZF+XOCdqIoXATuUxWlEyHBnzD1Dew3ffzCv
EZLaKD8uEDa0QuctNDeJyPHBDPK6NYIqkYAiMIEk5fVsfVoEGtAHzPlTGw02sgoP
M8AhfpDty6DOpUPOoYUegr2m74gmRnCkD6olHs91Af1aLS1o9pk/kbbWYiV8kQwk
ndL4JeBjDbZAoYtT043cJUPM8xb2fnF3oj55uf3cYMlZH00mPc/SwZa3bJ3r09x+
yKZgLbueTkpytpfYjhE9XmqzbckLAA==
=4Tny
-----END PGP SIGNATURE-----

--MbfPbtMAW7aR1zoM--
