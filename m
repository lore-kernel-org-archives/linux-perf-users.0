Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7832CC38A02
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Oct 2022 09:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiJ1J56 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiJ1J5j (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:39 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401F6B66F
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951009; x=1698487009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BgN+8iSWd8cYylvYK6FRliQdJ8AUyo6BZ6FMoT0gJnA=;
  b=aaLsFc94ldtSWtVyilo3xY7bDje18vq/AVMjFDDl7+62djdiiAJQE/7D
   P303Y1bA+Zb6IH42jpl4SY/4F8jsot6Qr1PfCXXTetdgF2YFNB89tyenm
   TP1HVWloNcevDbF6rRHMZWe12DbFuG/L3BLmScLelob+A1n3RMLRpmTW2
   RGmoyj38QpL+Kb5P/M8Gb8UqbX4SPfBgNvY5fLMX9zbyNrJrkFWQRnCNP
   +if8wdSFcSSAUT8NY6aEDsFm9O5ZTc2W8OZgdEoZZMSc2yOhuloOmNqg/
   kjTE8BbU4tQgig3BRT6QfY5gwlwbYodgLWFL249v1UyKhBeA2UxjlEKsh
   A==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="215317957"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:56:48 +0800
IronPort-SDR: BP1JmFii19uqtUCeD1D+p8bb5NbPg9WljLIcCiitLC2GRATf50wzxAe87WdT9B5b7ud3vOD/Ps
 NqFb9rpjxYj37srnynT8oujhw6QEQIfzQ9+dMqyTIbwpsddssAqw8zFFgC6olsRHxPpy49eeVa
 yxhvMLpvsUJ6oszc0+88H7eWhIYfWAVkctf03LoOBymJjAlSQx1dvzj2WcJQHiJJ41kWSqoySz
 Egy9435E+YUn/LUHouOH/m9vQfOmlMhUHOpvpxDmYbBIpZKdeeEFoATxgCjRrI4OTV4wQBUzPn
 K3fPJlAeb3+oYyjTdbBaQaML
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:10:25 -0700
IronPort-SDR: /OrFjB9JclmupZWI/kYt9expqaiG9iNz8SPOwkuDm7uXnFQhpxCyut8vB7MVri6gNsTi1pW8NH
 9vqhDEJR6a4PIkWnO2o8afcvj0zIRuYFHQnKBJvaVr6/82CG7odaPiHKkXoBNCFGpAedjIkce9
 XZ6RUXgzcg7NrVW7CRdcZBXx630Y4V3+qB09nG1/hvBMSHJpOPPvwYUKM2JtgcXJvoF/Z+Bscb
 mVQNsaYJGdGMw8DErHlbJKlDK7mZUb1ufjExxIlh3fADTT/TDlWdvRsvd2ARjVTMcznYcthyNg
 F/U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:56:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHy80qTdz1RwvT
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 02:56:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :content-type:x-mailer:message-id:date:subject:to:from; s=dkim;
         t=1666951007; x=1669543008; bh=BgN+8iSWd8cYylvYK6FRliQdJ8AUyo6B
        Z6FMoT0gJnA=; b=TZ/OXYWLpzrktMUlmpuxX7nmfXmcysrAOvOIeAA1P47SDEME
        Nsn2uJB1Y0bVuv4nsVqqMQtvDSHF+qWcMATpJCHCqUxLLpMZbZ0ZHwAe0sMab+jB
        bD22UFay3FckIrC/gdGxKnpmvxj/nqNd5Dsl+/2XKcp3cw3sW0vgQTsT2xkXxetb
        np3kwK7Ayi8YwQVP2E2USwhd9PxIKFJ0INBvbADG87h/cH//n07GMQOKNZW9aeaI
        V2JfFboZtJ2Rtt+fRP8x8qMVenHmiBo/WtAvN+z7awVWooGLZ41iGxfdnmPePVYx
        CeReqy8D+9jHC5tJ2lhcBo7DxVReO/o6qw4MzQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kNrnxKb46KaQ for <linux-perf-users@vger.kernel.org>;
        Fri, 28 Oct 2022 02:56:47 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHxz74RDz1RvLy;
        Fri, 28 Oct 2022 02:56:39 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, dave@stgolabs.net,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        dvhart@infradead.org, mark.rutland@arm.com, peterz@infradead.org,
        arnd@arndb.de, alistair23@gmail.com,
        linux-riscv@lists.infradead.org, mingo@redhat.com,
        alistair.francis@wdc.com, atish.patra@wdc.com
Subject: [PATCH 0/6] Fixup perf tests for 32-bit systems with 64-bit time_t
Date:   Fri, 28 Oct 2022 19:56:26 +1000
Message-Id: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This series aims to fix perf for 32-bit systems with a 64-bit time_t
(like RV32).

This series also adds a public futex waitv syscall that userspace
can use to avoid this complexity.

This series hasn't addressed the build failure pointed out in:
https://patchwork.kernel.org/project/linux-riscv/patch/20211209235857.423=
773-1-alistair.francis@opensource.wdc.com/
as I'm unable to reproduce it and unclear on how it can be fixed.

v6:
 - No change

Alistair Francis (6):
  perf bench futex: Add support for 32-bit systems with 64-bit time_t
  selftests: futex: Call the futex syscall from a function
  uapi: futex: Add a futex syscall
  selftests: futex: Add support for 32-bit systems with 64-bit time_t
  uapi: futex: Add a futex waitv syscall
  selftests: futex: Use futex_waitv helper function

 include/uapi/linux/futex_syscall.h            | 119 ++++++++++++++++++
 tools/perf/bench/futex.h                      |  52 +++++++-
 .../futex/functional/futex_requeue_pi.c       |   2 +-
 .../selftests/futex/include/futex2test.h      |   3 +-
 .../selftests/futex/include/futextest.h       |  60 +++++----
 5 files changed, 206 insertions(+), 30 deletions(-)
 create mode 100644 include/uapi/linux/futex_syscall.h

--=20
2.37.3

