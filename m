Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13703C636D4
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Feb 2023 20:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBOUdj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Feb 2023 15:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBOUdi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Feb 2023 15:33:38 -0500
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Feb 2023 12:33:36 PST
Received: from gimli.rothwell.id.au (gimli.rothwell.id.au [103.230.158.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781D3B3C4
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Feb 2023 12:33:36 -0800 (PST)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4PH8m03dr5zyZs;
        Thu, 16 Feb 2023 07:28:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1676492898;
        bh=wcHgSOMrPhx9kBoV4wdoWaMh/v9qVHffM9WyUed6D4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iULdr46CWHoW2EWP6m5SqJhvNlSvtfGa63ZN2XrC76WcErhrqLYzeATUYnh3smM2C
         VnRBH0hx2nGG3qncnbNo1QGS86jm8OCCDIupx5qb87I8hSwkNfOKQizby9mONwOlvR
         nlEPcixjUYyFfKy3J0sRUpeUD74/r8AGNxlwv7BOTTDKwHACcuNPIMj08s7nmk5d+c
         judC51TMKv2kyx1ma3f6Jt0YUfKYXArEmMVzPJ16kBbFC7LWBn2da1OXM5Pr7ALT78
         Y/vXyJ25YvMppkju76IaOxnNxMEmpLgKKxvdG6Vjk8+Evjwlm3tFgVO+Ojxggy+RFq
         B9/iz5K000Ovw==
Date:   Thu, 16 Feb 2023 07:28:15 +1100
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ian Rogers <irogers@google.com>,
        linux-kernel-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, hca@linux.ibm.com,
        egorenar@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        sumanthk@linux.ibm.com
Subject: Re: PING Re: [PATCH] tools/perf: Fix perf tool build error in
 util/pfm.c
Message-ID: <20230216072815.11dc4779@oak.ozlabs.ibm.com>
In-Reply-To: <Y+0Hqgb4fFTx9XlX@kernel.org>
References: <20230207140447.1827741-1-tmricht@linux.ibm.com>
        <Y+JoGRdML/Ckkwvb@kernel.org>
        <CAP-5=fU6vHFp1YeY9RyAUE_rS5PMECcUWdnMhR-QsMnAN0wy7g@mail.gmail.com>
        <Y+OmaXOdMEM4II57@kernel.org>
        <Y+OnKl9wYcbFvHLY@kernel.org>
        <Y+Osp+SY+1WTHvwR@kernel.org>
        <283ace48-0e69-08a4-cfd2-7bee5779c45c@linux.ibm.com>
        <Y+0Hqgb4fFTx9XlX@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0jc9q/Gl1/yC6HMwc=ltjj/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--Sig_/0jc9q/Gl1/yC6HMwc=ltjj/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Wed, 15 Feb 2023 13:26:18 -0300 Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
>
> In such cases please CC the linux-next maintainer:
>=20
> Stephen, can you please merge acme/perf/core into linux-next?

I currently fetch every day and merge
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git branches
perf/urgent and perf/core (as you have asked me to in the past).  In
yesterday's linux-next release, the top of those branches were commits

  f883675bf652 ("Merge tag 'gpio-fixes-for-v6.2-rc5' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/brgl/linux")

and

  6a5558f11664 ("perf tools: Fix perf tool build error in util/pfm.c")

respectively.  This latter one has not changed today.
--=20
Cheers,
Stephen Rothwell

--Sig_/0jc9q/Gl1/yC6HMwc=ltjj/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPtQF8ACgkQAVBC80lX
0GxcMQf/ThDroNfcN4E9goIZDnqfONcpkGkGMs+BHhGqAyRYnaLYldON7MtPDoaT
sHVEvw3WLQP9999GaxnW0n9BMEDQBmWIqqvRZw2BFS/h/eCzFbKbUVL7Ndz/faT+
62feMyD/siBpD61V4UQwbsr4N45SVQBaY9acvDR/bxOE7omWBCv9pYKrnuO2+I48
1bnTJhnM9SxYdZ2GCgbwSDsL9hts6fCIqEB1uKAou6J5ISnm2WAydlEztX6zyFtb
8b0oky4skf97gvZ5MDiBOAbiFyDQRkYkGDz99LcbMyGPMlzJTcd3oTDZxujvR7+j
S9d2J5EdDx469F/xcBWEwBkpDFTiXQ==
=yOYQ
-----END PGP SIGNATURE-----

--Sig_/0jc9q/Gl1/yC6HMwc=ltjj/--
