Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD066C64E7B
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 13:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510F52084C
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 13:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMDlY+v6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgLANnq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 08:43:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbgLANnq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Dec 2020 08:43:46 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EEF720770;
        Tue,  1 Dec 2020 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606830185;
        bh=X03VPdnlWDzsweoKGnP8h3wm/PD1j8u3e1jFKva3PtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMDlY+v6ZPrbqHhFkpMP94sMx5RrWTwMV2udlF65lMT3cNMbPVEDjaqVlupPGSuSs
         tgsM48ieIF5melz3xROdCOhGzwCMczURTJMOBW0cZApxqLjTQEoaF8vSVb2BxzhAP+
         5qX4D5Vi+bAxDpNX/YYfNv4r5bfwzQjyNiwiWUXQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3513C4079D; Tue,  1 Dec 2020 10:43:09 -0300 (-03)
Date:   Tue, 1 Dec 2020 10:43:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: perf probe can't remove probes
Message-ID: <20201201134309.GD49333@kernel.org>
References: <20201125172755.GA53351@kernel.org>
 <20201126092125.402257a8776637d6bd2e090c@kernel.org>
 <20201201132517.GC49333@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201132517.GC49333@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Dec 01, 2020 at 10:25:17AM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Masami,
 
> 	Any idea why listing the source code doesn't work while simply
> adding the probe works?

<SNIP>
 
> [root@seventh ~]# perf probe -L verify_pkcs7_signature
> Specified source line is not found.
>   Error: Failed to show lines.

Yeah, those fixes you sent, when cherry-picked into this bpf-next/master
based branch, do the trick, so nevermind, you fixed this already, these
fixes were already merged by Linus, bpf-next will rebase at some point,
etc. :-)

- Arnaldo

[acme@five bpf]$ git log --oneline -4
0f3147557ea8143d (HEAD -> bpfsign) perf probe: Change function definition check due to broken DWARF
0e104f490d8f86b4 perf probe: Fix to die_entrypc() returns error correctly
9423e1f089643738 libbpf: Check if the kernel supports signatures before associating them
580616996c498b70 libbpf: Attach signature ELF sections to signed ELF program sections
[acme@five bpf]$

[root@seventh ~]# perf probe -L verify_pkcs7_signature
<verify_pkcs7_signature@/home/acme/git/bpf/certs/system_keyring.c:0>
      0  int verify_pkcs7_signature(const void *data, size_t len,
                                   const void *raw_pkcs7, size_t pkcs7_len,
                                   struct key *trusted_keys,
                                   enum key_being_used_for usage,
                                   int (*view_content)(void *ctx,
                                                       const void *data, size_t len,
                                                       size_t asn1hdrlen),
                                   void *ctx)
         {
      9         struct pkcs7_message *pkcs7;
                int ret;

                pkcs7 = pkcs7_parse_message(raw_pkcs7, pkcs7_len);
     13         if (IS_ERR(pkcs7))
     14                 return PTR_ERR(pkcs7);

     16         ret = verify_pkcs7_message_sig(data, len, pkcs7, trusted_keys, usage,
                                               view_content, ctx);

     19         pkcs7_free_message(pkcs7);
     20         pr_devel("<==%s() = %d\n", __func__, ret);
                return ret;
         }
         EXPORT_SYMBOL_GPL(verify_pkcs7_signature);

[root@seventh ~]#
