Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE582C61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 20:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCMUW3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 16:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCMUW2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 16:22:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285D58B32D;
        Mon, 13 Mar 2023 13:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 821A1614B9;
        Mon, 13 Mar 2023 20:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A95BC433EF;
        Mon, 13 Mar 2023 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678738876;
        bh=w2c/7n/ZoAl+p0Uo7jveovPwHe4Aq5dpA5N/WHL1AUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXC82vRkaVviiDEHK5QmlkvLY39qBwpBMBm0xhASGgVyCBluwlUxNFANYUH3UqmkU
         XJbolWZDaqwECABdRaM+LnJZVs7Uryd+XiqpzytGLXjHvmrBeQRPaYwWGGZy9gX1GB
         /u7H2QxfcbUXbqT3k29BVRvQtxlz3BNR1Al2voddkVt7FUCukTjEOM5b3vxXIb0Jyk
         2OvUQWJNGiSSpT9h7/ke8jG32R7l0yLUN7WzKAJg7ELXSz9oFpQE3GoDnUgoWygMTB
         pWB4QoxCaYGhQFexw3KrG08LRvJSAcpeQQp1DEpDuAmaPeQ+CGCi6bL/VByf75ID63
         /BXcvvWOQSC/A==
Date:   Mon, 13 Mar 2023 20:21:12 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Paran Lee <p4ranlee@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] perf tools riscv: Add support for riscv
 lookup_binutils_path
Message-ID: <c47e371a-ea90-41f2-81e1-8e09f7524c42@spud>
References: <20230311112122.28894-1-p4ranlee@gmail.com>
 <CAP-5=fWkAqX+Uy_XhXHjEx6sj-wpOJ+WQf=vMtRzRBS-0Kj32Q@mail.gmail.com>
 <09d44d74-f3c9-cf99-8d14-74499485e956@gmail.com>
 <CAP-5=fUqLdCD_Ks2WQxjyRoNO53PxzDv_P7GJuY320+gKF=vEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iGjqrgvJjsqzLcOI"
Content-Disposition: inline
In-Reply-To: <CAP-5=fUqLdCD_Ks2WQxjyRoNO53PxzDv_P7GJuY320+gKF=vEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--iGjqrgvJjsqzLcOI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2023 at 09:27:35AM -0700, Ian Rogers wrote:

> Wrt the patch, could you reply to Conor's response.

Apologies if I asked something silly, I've been ill and kinda out of it,
just noticed it as I tried to keep up with mail and was curious...

--iGjqrgvJjsqzLcOI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZA+FuAAKCRB4tDGHoIJi
0v2DAPwNPwOTfYPSnx7Lb8DJXWaULL6Gd4dGKFzc/FHRMu995gEAoC/kPFb+do9W
xTAs/uTGGEdCihXSG+5nD0dXjIWJmgQ=
=eC1+
-----END PGP SIGNATURE-----

--iGjqrgvJjsqzLcOI--
