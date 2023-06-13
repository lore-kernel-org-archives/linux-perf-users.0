Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D336EB64D7
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 20:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjFMU2v (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjFMU2u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 16:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D3419BC;
        Tue, 13 Jun 2023 13:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A8F963AA9;
        Tue, 13 Jun 2023 20:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482BAC433C0;
        Tue, 13 Jun 2023 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686688123;
        bh=piWwiEmiy9a5Ktg6K8hzHvERfjNNaNpCbCculiiMSXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZN7CQLLXY/bEkmX62joLdFXi2c1B7m9c7aXD9pYsm6IL6s971Or0XoID53yIsj3XZ
         vCNiDedMxC/D4TVzqfBtVyNLwC5lOpK95+5RAnnTkp3kddPI+08ByNjXr4zvTWqu/n
         +iMFOZtoG7nx6E2drssRMo9IyqXANi+n1a4WhkdkuTbxT+6OEiKgmrH+ZU5Us9/Oos
         jXRE9l+3ISW7QY9IVfg9FDwkwwrc1h69jtRXMpdLyaNDNHE5LdoI/L8T79gEX+plqH
         SJKhTEg4+iQWmjE3OmhAjaoEDnC6PyuPEUMXueokYha4GzRscsN4TDFs529mSFIDdj
         27KswACMjnypQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E487040692; Tue, 13 Jun 2023 17:28:40 -0300 (-03)
Date:   Tue, 13 Jun 2023 17:28:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>, jolsa@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, alisaidi@amazon.com, leo.yan@linaro.org,
        maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH 2/4] perf tool x86: Consolidate is_amd check into single
 function
Message-ID: <ZIjReCC2AcCMdo5V@kernel.org>
References: <20230613095506.547-1-ravi.bangoria@amd.com>
 <20230613095506.547-3-ravi.bangoria@amd.com>
 <CAP-5=fUDng69kYZ5ecA_5FBKZWNxtMCUSM+BxO-7ndesG7xrvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUDng69kYZ5ecA_5FBKZWNxtMCUSM+BxO-7ndesG7xrvQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 13, 2023 at 12:49:50PM -0700, Ian Rogers escreveu:
> On Tue, Jun 13, 2023 at 2:56 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >
> > There are multiple places where x86 specific code determines AMD vs
> > Intel arch and acts based on that. Consolidate those checks into a
> > single function.
> >
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, added to the cset.

- Arnaldo
